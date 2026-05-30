#!/usr/bin/env python3
"""
project_manager.py — Gerenciador de Projetos para o Pipeline de Auditoria

Substitui o sandbox_manager.py. Trabalha in-place (sem cópia de arquivos),
suporta pastas locais e URLs do GitHub, e prepara o ambiente para Slither/Certora.

Uso:
    python3 scripts/utils/project_manager.py prepare <caminho_ou_url> [--vuln-type access_control]
    python3 scripts/utils/project_manager.py info <caminho_ou_url>
    python3 scripts/utils/project_manager.py list
    python3 scripts/utils/project_manager.py clean <project_id>
"""

import os
import sys
import json
import re
import glob
import hashlib
import shutil
import argparse
import subprocess
from dataclasses import dataclass, asdict, field
from datetime import datetime
from typing import Optional


PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
OUTPUT_BASE_DIR = os.path.join(PROJECT_ROOT, 'pipeline-output')
WORKSPACES_DIR = os.path.join(PROJECT_ROOT, '_workspaces')
REGISTRY_FILE = os.path.join(OUTPUT_BASE_DIR, 'project_registry.json')
VENV_DIR = os.path.join(PROJECT_ROOT, 'certora_venv')


# ─────────────────────────────────────────────────────────────
# Data Model
# ─────────────────────────────────────────────────────────────

@dataclass
class ProjectInfo:
    """Metadados do projeto preparado para o pipeline."""
    project_id: str                        # ID único (ex: vader-protocol_a4116a21)
    project_path: str                      # Caminho absoluto do projeto
    source_type: str                       # 'local' | 'github'
    framework: str                         # 'hardhat' | 'foundry' | 'truffle' | 'bare'
    solc_version: str                      # ex: '0.8.3'
    solc_remaps: list = field(default_factory=list)  # ex: ['@openzeppelin/=node_modules/@openzeppelin/']
    contracts_dir: str = ''                # ex: '/path/to/contracts'
    output_dir: str = ''                   # ex: 'pipeline-output/vader-protocol/'
    vuln_type: str = 'access_control'
    has_node_modules: bool = False
    hardhat_config: Optional[str] = None   # path do hardhat.config.js
    foundry_toml: Optional[str] = None     # path do foundry.toml
    github_url: Optional[str] = None       # URL original (se clonado)
    prepared_at: str = ''                  # ISO timestamp

    def save(self):
        """Salva project_info.json no output_dir."""
        os.makedirs(self.output_dir, exist_ok=True)
        info_path = os.path.join(self.output_dir, 'project_info.json')
        with open(info_path, 'w') as f:
            json.dump(asdict(self), f, indent=4)
        print(f"[ProjectManager] project_info.json saved at: {info_path}")
        return info_path

    @staticmethod
    def load(info_path: str) -> 'ProjectInfo':
        """Carrega ProjectInfo de um arquivo JSON."""
        with open(info_path, 'r') as f:
            data = json.load(f)
        return ProjectInfo(**data)


# ─────────────────────────────────────────────────────────────
# Registry (lista de projetos já preparados)
# ─────────────────────────────────────────────────────────────

def get_registry() -> dict:
    if not os.path.exists(REGISTRY_FILE):
        return {}
    try:
        with open(REGISTRY_FILE, 'r') as f:
            return json.load(f)
    except Exception:
        return {}


def save_registry(data: dict):
    os.makedirs(os.path.dirname(REGISTRY_FILE), exist_ok=True)
    with open(REGISTRY_FILE, 'w') as f:
        json.dump(data, f, indent=4)


# ─────────────────────────────────────────────────────────────
# Utilities
# ─────────────────────────────────────────────────────────────

def run_cmd(cmd: str, cwd: str = None, check: bool = True, capture: bool = False) -> subprocess.CompletedProcess:
    """Executa comando shell. Retorna CompletedProcess."""
    print(f"[ProjectManager] Executing: {cmd}")
    result = subprocess.run(
        cmd, cwd=cwd, shell=True, executable="/bin/bash",
        capture_output=capture, text=True if capture else None
    )
    if check and result.returncode != 0:
        stderr = result.stderr if capture else ''
        print(f"[ProjectManager] Command failed (rc={result.returncode}): {stderr}", file=sys.stderr)
        if check:
            sys.exit(result.returncode)
    return result


def generate_project_id(project_path: str) -> str:
    """Gera ID único baseado no nome + hash do caminho."""
    abs_path = os.path.abspath(project_path)
    base_name = os.path.basename(abs_path)
    path_hash = hashlib.md5(abs_path.encode()).hexdigest()[:8]
    return f"{base_name}_{path_hash}"


def is_github_url(input_str: str) -> bool:
    """Verifica se o input é uma URL do GitHub."""
    return bool(re.match(r'^https?://(www\.)?github\.com/', input_str))


# ─────────────────────────────────────────────────────────────
# ProjectManager
# ─────────────────────────────────────────────────────────────

class ProjectManager:
    """
    Gerenciador de projetos Solidity para o pipeline de auditoria.
    Trabalha in-place — NÃO copia arquivos.
    """

    def prepare(self, input_str: str, vuln_type: str = 'access_control') -> ProjectInfo:
        """
        Entry point principal. Resolve input, detecta framework/solc,
        instala dependências mínimas, e retorna ProjectInfo.
        """
        # 1. Resolver input (local ou GitHub)
        project_path, source_type, github_url = self._resolve_input(input_str)

        # 2. Detectar projeto root (nested projects como dataset/5/vader-protocol/)
        project_root = self._find_project_root(project_path)
        print(f"[ProjectManager] Project root: {project_root}")

        # 3. Detectar framework
        framework, config_path = self._detect_framework(project_root)
        print(f"[ProjectManager] Framework: {framework}")

        # 4. Detectar versão do Solidity
        solc_version = self._detect_solc_version(project_root)
        print(f"[ProjectManager] Solidity version: {solc_version}")

        # 5. Instalar solc via solc-select
        self._install_solc(solc_version)

        # 6. Detectar diretório de contratos
        contracts_dir = self._find_contracts_dir(project_root)

        # 7. Detectar remappings
        solc_remaps = self._detect_solc_remaps(project_root, framework)

        # 8. Instalar dependências npm (se necessário para imports)
        has_node_modules = self._ensure_dependencies(project_root, framework, solc_remaps)

        # 9. Gerar ID e output dir
        project_id = generate_project_id(project_root)
        output_dir = os.path.join(OUTPUT_BASE_DIR, os.path.basename(project_root))
        os.makedirs(output_dir, exist_ok=True)

        # 10. Criar ProjectInfo
        info = ProjectInfo(
            project_id=project_id,
            project_path=project_root,
            source_type=source_type,
            framework=framework,
            solc_version=solc_version,
            solc_remaps=solc_remaps,
            contracts_dir=contracts_dir,
            output_dir=output_dir,
            vuln_type=vuln_type,
            has_node_modules=has_node_modules,
            hardhat_config=config_path if framework == 'hardhat' else None,
            foundry_toml=config_path if framework == 'foundry' else None,
            github_url=github_url,
            prepared_at=datetime.now().isoformat(),
        )

        # 11. Salvar project_info.json e registry
        info.save()
        self._update_registry(info)

        print(f"[ProjectManager] ✓ Project prepared successfully!")
        print(f"[ProjectManager] Output dir: {output_dir}")
        return info

    # ─────────────── Input Resolution ───────────────

    def _resolve_input(self, input_str: str) -> tuple:
        """Resolve input para (project_path, source_type, github_url)."""
        if is_github_url(input_str):
            project_path = self._clone_github(input_str)
            return project_path, 'github', input_str
        else:
            abs_path = os.path.abspath(input_str)
            if not os.path.exists(abs_path):
                print(f"[ProjectManager] Error: Path '{abs_path}' does not exist.", file=sys.stderr)
                sys.exit(1)
            return abs_path, 'local', None

    def _clone_github(self, url: str) -> str:
        """Clona repositório do GitHub em _workspaces/."""
        # Extrair nome do repo
        match = re.match(r'https?://github\.com/[\w.-]+/([\w.-]+?)(?:\.git)?/?$', url)
        if not match:
            print(f"[ProjectManager] Error: Invalid GitHub URL: {url}", file=sys.stderr)
            sys.exit(1)

        repo_name = match.group(1)
        clone_path = os.path.join(WORKSPACES_DIR, repo_name)

        if os.path.exists(clone_path):
            print(f"[ProjectManager] Repository already cloned: {clone_path}")
            return clone_path

        os.makedirs(WORKSPACES_DIR, exist_ok=True)
        print(f"[ProjectManager] Cloning {url} -> {clone_path}")
        run_cmd(f"git clone --depth 1 {url} {clone_path}")
        return clone_path

    # ─────────────── Project Detection ───────────────

    def _find_project_root(self, path: str) -> str:
        """
        Detecta o diretório real do projeto Hardhat/Foundry.
        Datasets podem ter estrutura nested: dataset/5/vader-protocol/
        
        Prioridade:
        1. Subdiretório com 'contracts/' ou 'src/' (projeto real)
        2. Raiz se ela mesma tem 'contracts/' ou 'src/'
        3. Raiz se ela tem apenas config file (hardhat.config.js)
        """
        if os.path.isfile(path):
            return os.path.dirname(path)

        # Verificar se algum subdiretório tem contracts/ ou src/ (sinal de projeto real)
        subdirs_with_contracts = []
        for item in sorted(os.listdir(path)):
            subpath = os.path.join(path, item)
            if os.path.isdir(subpath) and not item.startswith('.') and item != 'node_modules':
                if os.path.isdir(os.path.join(subpath, 'contracts')) or \
                   os.path.isdir(os.path.join(subpath, 'src')):
                    subdirs_with_contracts.append(subpath)

        # Se encontrou subdiretório com contracts/, prefira-o
        if subdirs_with_contracts:
            chosen = subdirs_with_contracts[0]
            print(f"[ProjectManager] Auto-detected nested project: {os.path.basename(chosen)}")
            return chosen

        # Se a raiz tem contracts/ ou src/, é o projeto
        if os.path.isdir(os.path.join(path, 'contracts')) or \
           os.path.isdir(os.path.join(path, 'src')):
            return path

        # Se a raiz tem config file mas sem contracts/, pode ser wrapper
        if self._is_project_dir(path):
            return path

        # Procurar subdiretório que é um projeto (config files)
        for item in sorted(os.listdir(path)):
            subpath = os.path.join(path, item)
            if os.path.isdir(subpath) and not item.startswith('.'):
                if self._is_project_dir(subpath):
                    print(f"[ProjectManager] Auto-detected nested project: {item}")
                    return subpath

        # Fallback: retorna o path original
        return path

    def _is_project_dir(self, path: str) -> bool:
        """Verifica se um diretório é um projeto Solidity."""
        indicators = ['contracts', 'src', 'foundry.toml', 'hardhat.config.js',
                       'hardhat.config.ts', 'truffle-config.js']
        return any(os.path.exists(os.path.join(path, ind)) for ind in indicators)

    def _detect_framework(self, project_path: str) -> tuple:
        """Detecta o framework do projeto. Retorna (framework, config_path)."""
        # Foundry
        foundry_toml = os.path.join(project_path, 'foundry.toml')
        if os.path.exists(foundry_toml):
            return 'foundry', foundry_toml

        # Hardhat (.js ou .ts)
        for ext in ['js', 'ts']:
            hh_config = os.path.join(project_path, f'hardhat.config.{ext}')
            if os.path.exists(hh_config):
                return 'hardhat', hh_config

        # Truffle
        truffle_config = os.path.join(project_path, 'truffle-config.js')
        if os.path.exists(truffle_config):
            return 'truffle', truffle_config

        # Bare Solidity
        return 'bare', None

    # ─────────────── Solidity Version ───────────────

    def _detect_solc_version(self, project_path: str) -> str:
        """
        Detecta a versão do Solidity a partir dos arquivos .sol.
        Prioriza versões exatas e usa a mais recente se houver múltiplas.
        """
        sol_files = []
        for root, dirs, files in os.walk(project_path):
            # Skip node_modules, lib, .git
            dirs[:] = [d for d in dirs if d not in ('node_modules', '.git', 'lib', 'cache', 'artifacts')]
            for f in files:
                if f.endswith('.sol'):
                    sol_files.append(os.path.join(root, f))

        if not sol_files:
            print("[ProjectManager] WARNING: No .sol files found. Using default 0.8.20")
            return '0.8.20'

        versions = set()
        for sol_file in sol_files[:50]:  # Limitar busca
            try:
                with open(sol_file, 'r', errors='ignore') as f:
                    content = f.read()
                # Extrair pragma solidity
                for match in re.finditer(r'pragma\s+solidity\s+[\^>=<]*\s*([\d.]+)', content):
                    versions.add(match.group(1))
            except Exception:
                pass

        if not versions:
            print("[ProjectManager] WARNING: No pragma solidity found. Using default 0.8.20")
            return '0.8.20'

        # Usar a versão mais recente encontrada
        sorted_versions = sorted(versions, key=lambda v: [int(x) for x in v.split('.')])
        chosen = sorted_versions[-1]
        print(f"[ProjectManager] Found Solidity versions: {sorted_versions} -> using {chosen}")
        return chosen

    def _install_solc(self, version: str):
        """Instala solc via solc-select (dentro do venv do Certora)."""
        activate = f"source {VENV_DIR}/bin/activate" if os.path.exists(VENV_DIR) else ""

        # Verificar se já está instalado
        result = run_cmd(
            f"{activate} && solc-select versions 2>/dev/null",
            capture=True, check=False
        )
        installed = result.stdout if result.returncode == 0 else ''

        if version in installed:
            # Verificar se já é a versão ativa
            if f"{version} (current" in installed:
                print(f"[ProjectManager] solc {version} already active")
                return
            run_cmd(f"{activate} && solc-select use {version}")
            print(f"[ProjectManager] Switched to solc {version}")
        else:
            print(f"[ProjectManager] Installing solc {version}...")
            run_cmd(f"{activate} && solc-select install {version} && solc-select use {version}")
            print(f"[ProjectManager] ✓ solc {version} installed and active")

    # ─────────────── Contracts & Remaps ───────────────

    def _find_contracts_dir(self, project_path: str) -> str:
        """Encontra o diretório de contratos."""
        for candidate in ['contracts', 'src']:
            contracts_path = os.path.join(project_path, candidate)
            if os.path.isdir(contracts_path):
                return contracts_path
        # Fallback: o próprio projeto
        return project_path

    def _detect_solc_remaps(self, project_path: str, framework: str) -> list:
        """
        Detecta remappings de imports para o Slither.
        Analisa imports nos .sol e gera remaps baseado no que existe em node_modules/.
        """
        remaps = []

        # 1. Se Foundry, ler remappings.txt ou foundry.toml
        if framework == 'foundry':
            remaps_file = os.path.join(project_path, 'remappings.txt')
            if os.path.exists(remaps_file):
                with open(remaps_file, 'r') as f:
                    for line in f:
                        line = line.strip()
                        if line and '=' in line:
                            remaps.append(line)
                return remaps

        # 2. Detectar imports automaticamente dos arquivos .sol
        import_prefixes = set()
        contracts_dir = self._find_contracts_dir(project_path)

        for root, dirs, files in os.walk(contracts_dir):
            dirs[:] = [d for d in dirs if d not in ('node_modules', '.git')]
            for f in files:
                if not f.endswith('.sol'):
                    continue
                try:
                    with open(os.path.join(root, f), 'r', errors='ignore') as fh:
                        for line in fh:
                            # import "@openzeppelin/contracts/..."
                            match = re.search(r'import\s+["\'](@[\w.-]+/[\w.-]+)/', line)
                            if match:
                                import_prefixes.add(match.group(1))
                except Exception:
                    pass

        # 3. Gerar remaps para cada prefix encontrado
        node_modules = os.path.join(project_path, 'node_modules')
        for prefix in sorted(import_prefixes):
            # Verificar se existe em node_modules
            nm_path = os.path.join(node_modules, prefix)
            if os.path.exists(nm_path):
                remaps.append(f"{prefix}/={nm_path}/")

        if remaps:
            print(f"[ProjectManager] Detected {len(remaps)} import remappings")

        return remaps

    # ─────────────── Dependencies ───────────────

    def _ensure_dependencies(self, project_path: str, framework: str, solc_remaps: list) -> bool:
        """
        Instala dependências SOMENTE se necessário (imports que precisam de node_modules).
        Retorna True se node_modules existe após a operação.
        """
        node_modules = os.path.join(project_path, 'node_modules')
        pkg_json = os.path.join(project_path, 'package.json')

        # Se já tem node_modules, verificar se está ok
        if os.path.isdir(node_modules) and os.listdir(node_modules):
            print(f"[ProjectManager] node_modules already exists ({len(os.listdir(node_modules))} packages)")
            return True

        # Se não tem package.json, não precisa instalar
        if not os.path.exists(pkg_json):
            print(f"[ProjectManager] No package.json found. Skipping npm install.")
            return False

        # Verificar se realmente precisa de npm deps (tem imports @...)
        needs_npm = len(solc_remaps) > 0 or self._has_npm_imports(project_path)

        if not needs_npm:
            print(f"[ProjectManager] No npm imports detected. Skipping npm install.")
            return False

        # Instalar com a versão de Node adequada via NVM
        print(f"[ProjectManager] Installing npm dependencies...")
        node_version = self._detect_node_version(project_path)

        nvm_cmd = (
            f"source $HOME/.nvm/nvm.sh && "
            f"nvm install {node_version} > /dev/null 2>&1 && "
            f"nvm use {node_version} && "
            f"npm install --no-audit --no-fund --loglevel=warn"
        )

        result = run_cmd(nvm_cmd, cwd=project_path, check=False)
        if result.returncode != 0:
            print(f"[ProjectManager] WARNING: npm install failed (rc={result.returncode}). "
                  f"Slither may still work with solc-select if no npm imports are used.",
                  file=sys.stderr)
            return False

        print(f"[ProjectManager] ✓ npm dependencies installed")
        return True

    def _has_npm_imports(self, project_path: str) -> bool:
        """Verifica se os .sol têm imports que precisam de node_modules."""
        contracts_dir = self._find_contracts_dir(project_path)
        for root, dirs, files in os.walk(contracts_dir):
            dirs[:] = [d for d in dirs if d not in ('node_modules', '.git')]
            for f in files:
                if not f.endswith('.sol'):
                    continue
                try:
                    with open(os.path.join(root, f), 'r', errors='ignore') as fh:
                        for line in fh:
                            if re.search(r'import\s+["\']@', line):
                                return True
                except Exception:
                    pass
        return False

    def _detect_node_version(self, project_path: str) -> str:
        """
        Detecta a versão de Node adequada. Usa 22 como default seguro.
        """
        pkg_path = os.path.join(project_path, 'package.json')
        if os.path.exists(pkg_path):
            try:
                with open(pkg_path, 'r') as f:
                    data = json.load(f)
                engines = data.get('engines', {})
                node_req = engines.get('node', '')
                if node_req:
                    match = re.search(r'(\d+)', node_req)
                    if match:
                        version = int(match.group(1))
                        return str(max(version, 18))  # Mínimo 18
            except Exception:
                pass
        return '22'  # Default seguro

    # ─────────────── Registry ───────────────

    def _update_registry(self, info: ProjectInfo):
        """Atualiza o registro de projetos preparados."""
        registry = get_registry()
        registry[info.project_id] = {
            'project_path': info.project_path,
            'output_dir': info.output_dir,
            'source_type': info.source_type,
            'framework': info.framework,
            'solc_version': info.solc_version,
            'vuln_type': info.vuln_type,
            'prepared_at': info.prepared_at,
        }
        save_registry(registry)


# ─────────────────────────────────────────────────────────────
# CLI
# ─────────────────────────────────────────────────────────────

def cmd_prepare(args):
    pm = ProjectManager()
    info = pm.prepare(args.input, args.vuln_type)
    print(f"\n{'='*60}")
    print(f"Project ID:     {info.project_id}")
    print(f"Project Path:   {info.project_path}")
    print(f"Framework:      {info.framework}")
    print(f"Solc Version:   {info.solc_version}")
    print(f"Contracts Dir:  {info.contracts_dir}")
    print(f"Output Dir:     {info.output_dir}")
    print(f"Remaps:         {info.solc_remaps}")
    print(f"{'='*60}")


def cmd_info(args):
    pm = ProjectManager()
    project_path = os.path.abspath(args.input)
    project_root = pm._find_project_root(project_path)
    project_id = generate_project_id(project_root)
    output_dir = os.path.join(OUTPUT_BASE_DIR, os.path.basename(project_root))
    info_path = os.path.join(output_dir, 'project_info.json')

    if os.path.exists(info_path):
        info = ProjectInfo.load(info_path)
        print(json.dumps(asdict(info), indent=4))
    else:
        print(f"No project_info.json found. Run 'prepare' first.")
        sys.exit(1)


def cmd_list(args):
    registry = get_registry()
    if not registry:
        print("No prepared projects found.")
        return

    print(f"{'ID':<35} | {'Framework':<10} | {'Solc':<8} | {'Path'}")
    print("-" * 100)
    for pid, data in registry.items():
        print(f"{pid:<35} | {data.get('framework','?'):<10} | {data.get('solc_version','?'):<8} | {data.get('project_path','?')}")


def cmd_clean(args):
    registry = get_registry()
    if args.project_id not in registry:
        print(f"Project '{args.project_id}' not found in registry.")
        return

    data = registry[args.project_id]
    output_dir = data.get('output_dir', '')

    # Limpar output (não o projeto original!)
    if output_dir and os.path.exists(output_dir):
        shutil.rmtree(output_dir)
        print(f"[ProjectManager] Deleted output dir: {output_dir}")

    # Se foi clonado do GitHub, limpar workspace
    if data.get('source_type') == 'github':
        project_path = data.get('project_path', '')
        if project_path and project_path.startswith(WORKSPACES_DIR) and os.path.exists(project_path):
            shutil.rmtree(project_path)
            print(f"[ProjectManager] Deleted cloned workspace: {project_path}")

    del registry[args.project_id]
    save_registry(registry)
    print(f"[ProjectManager] Removed '{args.project_id}' from registry.")


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description="Solidity Project Manager for Audit Pipeline")
    subparsers = parser.add_subparsers(dest='command', required=True)

    # prepare
    p_prepare = subparsers.add_parser('prepare', help='Prepare a project for analysis')
    p_prepare.add_argument('input', help='Local path or GitHub URL')
    p_prepare.add_argument('--vuln-type', default='access_control', help='Vulnerability type to target')
    p_prepare.set_defaults(func=cmd_prepare)

    # info
    p_info = subparsers.add_parser('info', help='Show project info')
    p_info.add_argument('input', help='Local path or GitHub URL')
    p_info.set_defaults(func=cmd_info)

    # list
    p_list = subparsers.add_parser('list', help='List all prepared projects')
    p_list.set_defaults(func=cmd_list)

    # clean
    p_clean = subparsers.add_parser('clean', help='Clean project outputs')
    p_clean.add_argument('project_id', help='Project ID to clean')
    p_clean.set_defaults(func=cmd_clean)

    args = parser.parse_args()
    args.func(args)
