#!/usr/bin/env python3
import os
import sys
import json
import shutil
import hashlib
import argparse
import subprocess
import re
from datetime import datetime

PROJECT_ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), '..', '..'))
SANDBOXES_DIR = os.path.join(PROJECT_ROOT, '_sandboxes')
REGISTRY_FILE = os.path.join(SANDBOXES_DIR, 'registry.json')
DEFAULT_NODE_VERSION = "22"

def get_registry():
    if not os.path.exists(REGISTRY_FILE):
        return {}
    try:
        with open(REGISTRY_FILE, 'r') as f:
            return json.load(f)
    except Exception:
        return {}

def save_registry(data):
    os.makedirs(SANDBOXES_DIR, exist_ok=True)
    with open(REGISTRY_FILE, 'w') as f:
        json.dump(data, f, indent=4)

def get_dir_size_mb(path):
    total_size = 0
    for dirpath, _, filenames in os.walk(path):
        for f in filenames:
            fp = os.path.join(dirpath, f)
            if not os.path.islink(fp):
                total_size += os.path.getsize(fp)
    return round(total_size / (1024 * 1024), 2)

def generate_sandbox_id(dataset_path):
    abs_path = os.path.abspath(dataset_path)
    base_name = os.path.basename(abs_path)
    path_hash = hashlib.md5(abs_path.encode()).hexdigest()[:8]
    return f"{base_name}_{path_hash}"

def find_project_root(sandbox_path):
    """
    Detecta o diretório real do projeto Hardhat dentro do sandbox.
    Projetos de datasets frequentemente têm estrutura nested:
      sandbox_root/
        subprojeto/
          contracts/
          package.json
    """
    # Se a raiz do sandbox já tem contracts/, é o projeto
    if os.path.isdir(os.path.join(sandbox_path, 'contracts')):
        return sandbox_path
    # Senão, procurar subdiretório com contracts/
    for item in os.listdir(sandbox_path):
        subpath = os.path.join(sandbox_path, item)
        if os.path.isdir(subpath) and os.path.exists(os.path.join(subpath, 'contracts')):
            print(f"[Sandbox] Auto-detected nested project root: {item}")
            return subpath
    # Fallback: procurar subdiretório com package.json + hardhat
    for item in os.listdir(sandbox_path):
        subpath = os.path.join(sandbox_path, item)
        pkg = os.path.join(subpath, 'package.json')
        if os.path.isdir(subpath) and os.path.exists(pkg):
            try:
                with open(pkg, 'r') as f:
                    data = json.load(f)
                deps = {**data.get('dependencies', {}), **data.get('devDependencies', {})}
                if 'hardhat' in deps:
                    print(f"[Sandbox] Auto-detected nested project root (via hardhat dep): {item}")
                    return subpath
            except Exception:
                pass
    return sandbox_path

def extract_node_version(project_root):
    """
    Detecta a versão de Node compatível. Verifica engines.node no package.json,
    mas como a maioria dos projetos de dataset NÃO declara engines, usa Node 22
    como default seguro (compatível com Hardhat moderno).
    """
    pkg_path = os.path.join(project_root, 'package.json')
    if os.path.exists(pkg_path):
        try:
            with open(pkg_path, 'r') as f:
                data = json.load(f)
                engines = data.get('engines', {})
                node_req = engines.get('node', '')
                if node_req:
                    match = re.search(r'(\d+)', node_req)
                    if match:
                        version = match.group(1)
                        # Garantir mínimo de Node 18 para compatibilidade
                        return str(max(int(version), 18))
        except Exception:
            pass
    return DEFAULT_NODE_VERSION

def run_cmd(cmd, cwd=None, shell=True):
    print(f"[Sandbox] Executing: {cmd}")
    result = subprocess.run(cmd, cwd=cwd, shell=shell, executable="/bin/bash")
    if result.returncode != 0:
        print(f"[Sandbox] Command failed with exit code {result.returncode}")
        sys.exit(result.returncode)

def create_sandbox(dataset_path, force=False):
    if not os.path.exists(dataset_path):
        print(f"Error: Dataset path '{dataset_path}' does not exist.")
        sys.exit(1)
        
    dataset_path = os.path.abspath(dataset_path)
    sandbox_id = generate_sandbox_id(dataset_path)
    sandbox_path = os.path.join(SANDBOXES_DIR, sandbox_id)
    
    registry = get_registry()
    
    if os.path.exists(sandbox_path):
        if force:
            print(f"[Sandbox] Forcing recreation of sandbox '{sandbox_id}'...")
            shutil.rmtree(sandbox_path)
        else:
            print(f"[Sandbox] Sandbox '{sandbox_id}' already exists. Reusing it.")
            print(f"export SANDBOX_PATH={sandbox_path}")
            return sandbox_path
            
    print(f"[Sandbox] Creating new sandbox for '{dataset_path}' -> '{sandbox_id}'")
    
    if os.path.isfile(dataset_path):
        os.makedirs(sandbox_path, exist_ok=True)
        shutil.copy2(dataset_path, sandbox_path)
    else:
        def ignore_patterns(path, names):
            # Não excluir artifacts/cache — Slither precisa de artifacts/build-info
            return [n for n in names if n in ('.git', 'node_modules')]
        shutil.copytree(dataset_path, sandbox_path, ignore=ignore_patterns)
    
    # Detectar o diretório real do projeto (pode ser nested)
    project_root = find_project_root(sandbox_path)
    print(f"[Sandbox] Project root: {project_root}")
    
    node_version = extract_node_version(project_root)
    print(f"[Sandbox] Detected/Selected Node Version: {node_version}")
    
    with open(os.path.join(sandbox_path, '.nvmrc'), 'w') as f:
        f.write(node_version)
        
    # Instalar dependências no diretório correto do projeto
    pkg_json_path = os.path.join(project_root, 'package.json')
    if os.path.exists(pkg_json_path):
        nvm_cmd = (
            f"source $HOME/.nvm/nvm.sh && "
            f"nvm install {node_version} && nvm use {node_version} && "
            f"npm install && "
            f"npx hardhat compile"
        )
    else:
        nvm_cmd = f"source $HOME/.nvm/nvm.sh && nvm install {node_version} && nvm use {node_version}"
        
    run_cmd(nvm_cmd, cwd=project_root)
    
    # Se o project_root é diferente do sandbox_root, também instalar na raiz se houver package.json
    sandbox_pkg = os.path.join(sandbox_path, 'package.json')
    if project_root != sandbox_path and os.path.exists(sandbox_pkg):
        print(f"[Sandbox] Also installing dependencies at sandbox root...")
        nvm_root_cmd = (
            f"source $HOME/.nvm/nvm.sh && "
            f"nvm use {node_version} && "
            f"npm install"
        )
        run_cmd(nvm_root_cmd, cwd=sandbox_path)
    
    registry[sandbox_id] = {
        "original_path": dataset_path,
        "sandbox_path": sandbox_path,
        "node_version": node_version,
        "created_at": datetime.now().isoformat(),
        "size_mb": get_dir_size_mb(sandbox_path)
    }
    save_registry(registry)
    print(f"[Sandbox] Successfully created and configured sandbox.")
    print(f"export SANDBOX_PATH={sandbox_path}")
    return sandbox_path

def list_sandboxes():
    registry = get_registry()
    if not registry:
        print("No active sandboxes found.")
        return
        
    print(f"{'ID':<30} | {'Node':<5} | {'Size(MB)':<10} | {'Original Path'}")
    print("-" * 80)
    for sid, data in registry.items():
        # Update size dynamically
        if os.path.exists(data['sandbox_path']):
            size = get_dir_size_mb(data['sandbox_path'])
        else:
            size = "N/A"
        print(f"{sid:<30} | {data['node_version']:<5} | {size:<10} | {data['original_path']}")

def clean_sandbox(sandbox_id):
    registry = get_registry()
    if sandbox_id not in registry:
        print(f"Sandbox '{sandbox_id}' not found in registry.")
        return
        
    path = registry[sandbox_id]['sandbox_path']
    if os.path.exists(path):
        shutil.rmtree(path)
        print(f"[Sandbox] Deleted directory {path}")
        
    del registry[sandbox_id]
    save_registry(registry)
    print(f"[Sandbox] Removed '{sandbox_id}' from registry.")

def clean_all():
    if os.path.exists(SANDBOXES_DIR):
        shutil.rmtree(SANDBOXES_DIR)
        print(f"[Sandbox] Deleted all sandboxes in {SANDBOXES_DIR}")
    else:
        print("[Sandbox] No sandboxes directory found.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Slither Sandbox Manager")
    subparsers = parser.add_subparsers(dest="command", required=True)
    
    parser_create = subparsers.add_parser("create")
    parser_create.add_argument("dataset_path", help="Path to the Solidity dataset/project")
    parser_create.add_argument("--force", action="store_true", help="Force recreate sandbox")
    
    parser_list = subparsers.add_parser("list")
    
    parser_clean = subparsers.add_parser("clean")
    parser_clean.add_argument("sandbox_id", help="Sandbox ID to clean")
    
    parser_clean_all = subparsers.add_parser("clean-all")
    
    args = parser.parse_args()
    
    if args.command == "create":
        create_sandbox(args.dataset_path, args.force)
    elif args.command == "list":
        list_sandboxes()
    elif args.command == "clean":
        clean_sandbox(args.sandbox_id)
    elif args.command == "clean-all":
        clean_all()
