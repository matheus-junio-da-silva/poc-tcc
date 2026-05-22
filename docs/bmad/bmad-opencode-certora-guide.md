# Guia Completo: BMad Method + OpenCode no WSL Ubuntu
### Para Criação de Agentes de Detecção de Vulnerabilidades em Contratos Solidity com Certora Prover

> **Fonte:** Documentação oficial — [docs.bmad-method.org](https://docs.bmad-method.org), [opencode.ai/docs](https://opencode.ai/docs), [docs.certora.com](https://docs.certora.com)

---

## Índice

1. [Visão Geral da Stack](#1-visão-geral-da-stack)
2. [Pré-requisitos do Sistema (WSL Ubuntu)](#2-pré-requisitos-do-sistema-wsl-ubuntu)
3. [Instalando o OpenCode](#3-instalando-o-opencode)
4. [Instalando o BMad Method](#4-instalando-o-bmad-method)
5. [Integrando BMad + OpenCode](#5-integrando-bmad--opencode)
6. [Instalando o Certora Prover](#6-instalando-o-certora-prover)
7. [Criando Agentes Customizados no BMad para Análise de Contratos](#7-criando-agentes-customizados-no-bmad-para-análise-de-contratos)
8. [Arquitetura do Orquestrador + Sub-agentes Certora](#8-arquitetura-do-orquestrador--sub-agentes-certora)
9. [Erros Comuns e Como Resolver](#9-erros-comuns-e-como-resolver)
10. [Melhores Práticas](#10-melhores-práticas)
11. [Ferramentas Complementares Recomendadas](#11-ferramentas-complementares-recomendadas)

---

## 1. Visão Geral da Stack

| Ferramenta | Papel no Projeto |
|---|---|
| **BMad Method (v6)** | Framework de orquestração de agentes AI; define personas, workflows e memória |
| **OpenCode** | Coding agent terminal-first; executa os agentes BMad e interage com o código |
| **Certora Prover** | Verificação formal de contratos Solidity via CVL (Certora Verification Language) |
| **WSL Ubuntu** | Ambiente de execução Linux no Windows |

**Fluxo Geral:**
```
Usuário → OpenCode (TUI/CLI)
             ↓ carrega agentes BMad via .opencode/skills/
        Orquestrador BMad
             ↓ delega via Task tool
    ┌────────┬────────┬────────┐
 Analyzer  Specifier  Runner  Reporter
 (lê .sol) (escreve  (executa (interpreta
            .spec)   certoraRun) resultados)
```

---

## 2. Pré-requisitos do Sistema (WSL Ubuntu)

### 2.1 Instalar o WSL (se ainda não tiver)

No PowerShell do Windows (como Administrador):
```powershell
wsl --install
# Reinicie e configure seu usuário Ubuntu
```

### 2.2 Dependências no Ubuntu

Abra o terminal WSL e instale tudo em ordem:

```bash
# Atualizar o sistema
sudo apt update && sudo apt upgrade -y

# Node.js 20.12+ (obrigatório para o instalador BMad)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install -y nodejs

# Verificar versão (precisa ser ≥ 20.12)
node --version
npm --version

# Git (obrigatório para BMad clonar módulos externos)
sudo apt install -y git

# Python 3.9+ (obrigatório para o Certora Prover)
sudo apt install -y python3 python3-pip python3-venv

# Java Development Kit 21+ (obrigatório para o Certora Prover)
sudo apt install -y openjdk-21-jdk

# Verificar versões
python3 --version   # deve ser ≥ 3.9
java --version      # deve ser ≥ 21

# curl (para instalar o OpenCode)
sudo apt install -y curl
```

### 2.3 Configurar o PATH no `.bashrc` ou `.profile`

```bash
# Adicione ao final do ~/.bashrc
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
```

> **Importante para WSL:** Se seus arquivos de projeto estão em `/mnt/c/`, considere cloná-los dentro do filesystem do WSL (ex: `~/code/`) para melhor performance. A documentação oficial do OpenCode recomenda isso explicitamente.

---

## 3. Instalando o OpenCode

O OpenCode (de [opencode.ai](https://opencode.ai)) é o coding agent open source recomendado para uso no terminal. Ele é o "motor" que vai executar os agentes BMad.

### 3.1 Instalação via script (método recomendado para WSL Ubuntu)

```bash
curl -fsSL https://opencode.ai/install | bash
```

### 3.2 Alternativa via npm

```bash
npm install -g opencode-ai
```

### 3.3 Alternativa via Homebrew

```bash
brew install anomalyco/tap/opencode
```

### 3.4 Verificar instalação

```bash
opencode --version
```

### 3.5 Configurar um provider de AI

Ao abrir o OpenCode pela primeira vez, você precisa conectar um provider. Para usar Claude (recomendado com BMad):

```bash
opencode
# Dentro do TUI, execute:
/connect
# Selecione "Anthropic" e insira sua ANTHROPIC_API_KEY
```

Alternativamente, configure via variável de ambiente:

```bash
export ANTHROPIC_API_KEY="sua-chave-aqui"
# Para tornar permanente:
echo 'export ANTHROPIC_API_KEY="sua-chave-aqui"' >> ~/.bashrc
source ~/.bashrc
```

### 3.6 Inicializar um projeto no OpenCode

```bash
cd ~/code/meu-projeto-solidity
opencode
# Dentro do TUI:
/init
```

O comando `/init` analisa o projeto e cria um arquivo `AGENTS.md` na raiz — **faça commit desse arquivo no Git**.

---

## 4. Instalando o BMad Method

O BMad usa `npx` (Node.js) para instalação via CLI. **Deve ser executado na raiz do projeto.**

### 4.1 Instalação interativa (recomendada para primeiro uso)

```bash
cd ~/code/meu-projeto-solidity
npx bmad-method install
```

O instalador faz 5 perguntas interativas:

1. **Diretório de instalação** — pressione Enter para usar o atual
2. **Módulos** — selecione `bmm` (BMad Method) com a barra de espaço
3. **"Ready to install (all stable)?"** — confirme com `Y`
4. **AI tool/IDE** — selecione `opencode` com a barra de espaço ← **importante!**
5. **Config do módulo** — nome do projeto, linguagem, pasta de output

### 4.2 Instalação headless (CI ou scripts automatizados)

```bash
npx bmad-method install --yes \
  --modules bmm \
  --tools opencode \
  --set bmm.user_skill_level=expert
```

### 4.3 O que é criado

Após a instalação, você terá:
```
seu-projeto/
├── _bmad/                     # Núcleo BMad: agentes, workflows, configuração
│   ├── _config/
│   │   ├── manifest.yaml      # Registra versões instaladas
│   │   └── agents/            # Customizações de agentes
│   └── bmm/                   # Módulo BMad Method
├── _bmad-output/              # Onde os artefatos (PRD, specs) são salvos
└── .opencode/
    └── skills/                # ← BMad instala seus workflows aqui para o OpenCode
        └── BMAD/
            └── bmm/           # Skills do módulo BMad Method
```

> **Nota sobre OpenCode + BMad:** O instalador BMad cria os skills em `.opencode/skills/BMAD/` e também cria um `opencode.json` (ou `opencode.jsonc`) na raiz do projeto com as referências dos agentes. A integração nativa BMad → OpenCode usa o sistema de **skills** do OpenCode.

---

## 5. Integrando BMad + OpenCode

### 5.1 Como o BMad funciona dentro do OpenCode

Após a instalação, os agentes BMad ficam disponíveis como **skills** no OpenCode. Para usá-los:

```bash
cd ~/code/meu-projeto-solidity
opencode
```

Dentro do TUI do OpenCode:

- **Listar skills BMad disponíveis:** digite `/` e procure por `bmad`
- **Ativar um agente:** `bmad-help` (para começar) ou `bmad-agent-dev`, `bmad-agent-architect`, etc.
- **Trocar entre agentes primários:** tecla `Tab`
- **Invocar sub-agentes:** use `@nome-do-agente` no prompt

### 5.2 Estrutura de agentes BMad no OpenCode

O BMad instala automaticamente no OpenCode:

| Skill BMad | Descrição |
|---|---|
| `bmad-help` | Guia inteligente — detecta estado do projeto e orienta o próximo passo |
| `bmad-agent-analyst` | Agente analista para brainstorming e pesquisa |
| `bmad-agent-architect` | Agente arquiteto para decisões técnicas |
| `bmad-agent-pm` | Product Manager — cria PRDs e épicos |
| `bmad-agent-dev` | Desenvolvedor — implementa stories |
| `bmad-agent-qa` | QA — validação e testes |
| `bmad-prd` | Workflow de criação de PRD |
| `bmad-create-architecture` | Workflow de arquitetura |
| `bmad-dev-story` | Workflow de implementação de story |

### 5.3 Verificar a integração

Dentro do OpenCode TUI:
```
/bmad-help
```
Ou no modo CLI (sem abrir TUI):
```bash
opencode -p "bmad-help qual é o próximo passo do projeto?"
```

### 5.4 Configuração do `opencode.json` gerado pelo BMad

O BMad cria/modifica o `opencode.json` na raiz do projeto. Estrutura típica:

```json
{
  "$schema": "https://opencode.ai/config.json",
  "instructions": [
    "{file:./_bmad/bmm/config.yaml}",
    "{file:./_bmad/core-config.yaml}"
  ],
  "agent": {
    "build": {
      "model": "anthropic/claude-sonnet-4-20250514",
      "permission": {
        "bash": "ask",
        "edit": "ask"
      }
    }
  }
}
```

---

## 6. Instalando o Certora Prover

O Certora Prover é executado na nuvem da Certora, mas o CLI é instalado localmente.

### 6.1 Obter a chave de acesso

Registre-se gratuitamente em [certora.com/signup](https://www.certora.com/signup?plan=prover) para obter sua `CERTORAKEY`.

### 6.2 Instalar o Certora CLI

**Recomendado: usar ambiente virtual Python para isolar dependências:**

```bash
# Criar e ativar ambiente virtual
python3 -m venv ~/certora-env
source ~/certora-env/bin/activate

# Instalar o Certora CLI
pip3 install certora-cli

# Verificar
certoraRun --version
```

Para ativar automaticamente no login, adicione ao `~/.bashrc`:
```bash
echo 'source ~/certora-env/bin/activate' >> ~/.bashrc
```

### 6.3 Instalar o `solc-select` (gerenciador de versões do compilador Solidity)

```bash
pip3 install solc-select
solc-select install 0.8.20
solc-select use 0.8.20
solc --version
```

### 6.4 Configurar a chave de acesso

```bash
export CERTORAKEY="sua-chave-pessoal"
# Tornar permanente:
echo 'export CERTORAKEY="sua-chave-pessoal"' >> ~/.bashrc
source ~/.bashrc
```

### 6.5 Testar a instalação

Crie um contrato de teste simples:
```bash
mkdir -p ~/certora-test/contracts ~/certora-test/specs
cat > ~/certora-test/contracts/Simple.sol << 'EOF'
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Simple {
    uint256 public value;
    function setValue(uint256 v) external { value = v; }
}
EOF

cat > ~/certora-test/specs/Simple.spec << 'EOF'
rule valueSet(uint256 v) {
    env e;
    setValue(e, v);
    assert value() == v;
}
EOF

cd ~/certora-test
certoraRun contracts/Simple.sol \
  --verify Simple:specs/Simple.spec \
  --solc solc
```

---

## 7. Criando Agentes Customizados no BMad para Análise de Contratos

Esta é a parte central do seu projeto: criar agentes especializados para detecção de vulnerabilidades.

### 7.1 Onde criar agentes customizados

No OpenCode, agentes Markdown ficam em:
- **Global:** `~/.config/opencode/agents/`
- **Por projeto:** `.opencode/agents/`

Para integração com BMad, use a pasta do projeto:
```bash
mkdir -p ~/code/meu-projeto-solidity/.opencode/agents
```

### 7.2 Agente Orquestrador

Crie `.opencode/agents/certora-orchestrator.md`:

```markdown
---
description: Orchestrates vulnerability detection in Solidity smart contracts using Certora Prover. Delegates to specialized subagents for analysis, spec writing, execution, and reporting.
mode: primary
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
permission:
  bash:
    "*": ask
    "certoraRun *": allow
    "solc *": allow
    "cat *": allow
    "ls *": allow
  edit: ask
  read: allow
---

You are the Certora Vulnerability Detection Orchestrator for Solidity smart contracts.

## Your Mission
Coordinate a full formal verification pipeline using Certora Prover to detect security vulnerabilities in Solidity contracts.

## Workflow
1. **@certora-analyzer** to read and understand the contract structure
2. **@certora-specifier** to write CVL specifications targeting known vulnerability patterns
3. **@certora-runner** to execute certoraRun and capture results
4. **@certora-reporter** to interpret findings and generate a vulnerability report

## Vulnerability Patterns to Target
- Reentrancy vulnerabilities
- Integer overflow/underflow
- Access control failures
- Incorrect state transitions
- Arithmetic precision errors
- Token balance invariants

## Rules
- Always start by understanding the full contract before writing specs
- Each spec should test one vulnerability category at a time
- Never skip the analysis phase
- All bash commands that write files must be approved
```

### 7.3 Agente Analisador de Contrato

Crie `.opencode/agents/certora-analyzer.md`:

```markdown
---
description: Analyzes Solidity smart contract source code to identify structure, functions, state variables, and potential vulnerability entry points for formal verification.
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.1
permission:
  read: allow
  edit: deny
  bash:
    "cat *": allow
    "find *": allow
    "ls *": allow
    "solc *": allow
---

You are a Solidity contract analyzer specialized in formal verification preparation.

## Your Task
Given a Solidity contract, produce a structured analysis containing:

1. **Contract Overview:** name, pragma, imports, inheritance
2. **State Variables:** types, visibility, mutability
3. **Functions:** signatures, visibility, modifiers, side effects
4. **Events & Modifiers:** definitions and usage
5. **Vulnerability Entry Points:** functions that modify state, handle ETH, or have access control

## Output Format
Produce a markdown report saved to `_bmad-output/certora-analysis.md`.

## Important
- Do NOT modify any files other than the analysis output
- Use `solc --ast-compact-json` for deeper AST analysis when needed
- Identify the Solidity version and note compatibility with certoraRun
```

### 7.4 Agente Escritor de Especificações CVL

Crie `.opencode/agents/certora-specifier.md`:

```markdown
---
description: Writes CVL (Certora Verification Language) specification files to formally verify security properties in Solidity contracts.
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.05
permission:
  read: allow
  edit:
    "*.spec": allow
    "*.conf": allow
  bash:
    "cat *": allow
---

You are a CVL specification writer for the Certora Prover.

## CVL Syntax Reference
- `rule <name>([params]) { ... }` — define a verification rule
- `invariant <name> <expr>` — define a state invariant
- `methods { ... }` — declare external contract methods
- `env e;` — declare the EVM environment
- `assert <condition>;` — property to verify
- `satisfy <condition>;` — existence check
- `havoc` — non-deterministic value
- `mathint` — unbounded integer (avoids overflow)

## Common Vulnerability Specs

### Reentrancy
```cvl
rule noReentrancy(method f) {
    env e; calldataarg args;
    uint256 balanceBefore = nativeBalances[currentContract];
    f(e, args);
    uint256 balanceAfter = nativeBalances[currentContract];
    assert balanceAfter >= balanceBefore || /* expected decrease */;
}
```

### Access Control
```cvl
rule onlyOwnerCanCall(method f) {
    env e; calldataarg args;
    require e.msg.sender != owner();
    f@withrevert(e, args);
    assert lastReverted;
}
```

## Your Task
- Read `_bmad-output/certora-analysis.md`
- Write spec files to `specs/<vulnerability_category>.spec`
- Write a `.conf` file for certoraRun configuration
- Document each rule's intent in comments
```

### 7.5 Agente Executor do Certora

Crie `.opencode/agents/certora-runner.md`:

```markdown
---
description: Executes certoraRun commands against Solidity contracts and captures verification results.
mode: subagent
model: anthropic/claude-haiku-4-20250514
temperature: 0.0
permission:
  bash:
    "certoraRun *": allow
    "cat *": allow
    "ls *": allow
  edit:
    "_bmad-output/*": allow
  read: allow
---

You are the Certora Prover execution agent.

## Your Task
Execute certoraRun using the configuration from `specs/*.conf` and capture results.

## Execution Pattern
```bash
certoraRun <contract>.sol \
  --verify <ContractName>:<spec_file>.spec \
  --solc solc \
  --output_dir _bmad-output/certora-results \
  --msg "Automated vulnerability scan"
```

## Output
Save the full stdout/stderr to `_bmad-output/certora-raw-output.txt`.
Extract and save the verification summary to `_bmad-output/certora-summary.json`.

## Error Handling
- If certoraRun fails with exit code != 0, capture the error and report it
- Check if CERTORAKEY is set before running
- Verify solc version matches contract pragma
```

### 7.6 Agente Gerador de Relatório

Crie `.opencode/agents/certora-reporter.md`:

```markdown
---
description: Interprets Certora Prover results and generates a human-readable vulnerability report with severity classifications and remediation suggestions.
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.2
permission:
  read: allow
  edit:
    "_bmad-output/vulnerability-report.md": allow
  bash:
    "cat *": allow
---

You are a smart contract security reporter specializing in formal verification results.

## Your Task
Read `_bmad-output/certora-raw-output.txt` and `_bmad-output/certora-summary.json`,
then produce `_bmad-output/vulnerability-report.md`.

## Report Structure
1. **Executive Summary** — overall risk level and key findings
2. **Verified Properties** — rules that PASSED (no violations found)
3. **Violated Properties** — rules that FAILED (vulnerabilities detected)
   - Rule name and description
   - Counterexample provided by the Prover
   - Severity: Critical / High / Medium / Low
   - Remediation suggestion
4. **Timeout/Unknown Results** — rules that could not be decided
5. **Next Steps** — recommended manual review areas

## Severity Classification
- **Critical:** Reentrancy, unauthorized ETH drain, access control bypass
- **High:** Integer overflow, incorrect invariants
- **Medium:** Precision loss, incorrect state transitions
- **Low:** Minor arithmetic issues, informational findings
```

---

## 8. Arquitetura do Orquestrador + Sub-agentes Certora

### 8.1 Como invocar o pipeline completo

Dentro do OpenCode TUI, com o agente orquestrador ativo:

```
# Trocar para o orquestrador (Tab para ciclar entre primários)
# Ou invoke diretamente:
@certora-orchestrator Analise o contrato em contracts/MyToken.sol por vulnerabilidades
```

### 8.2 Invocação manual de sub-agentes (para debug)

```
@certora-analyzer Analise contracts/MyToken.sol e gere o relatório de análise
@certora-specifier Escreva specs CVL baseado na análise em _bmad-output/certora-analysis.md
@certora-runner Execute o certoraRun com as specs em specs/
@certora-reporter Gere o relatório final de vulnerabilidades
```

### 8.3 Estrutura de diretórios recomendada

```
meu-projeto-solidity/
├── contracts/
│   └── MyToken.sol            # Contratos a verificar
├── specs/
│   ├── reentrancy.spec        # Specs CVL por categoria
│   ├── access-control.spec
│   └── verification.conf      # Config do certoraRun
├── .opencode/
│   └── agents/                # Agentes customizados
│       ├── certora-orchestrator.md
│       ├── certora-analyzer.md
│       ├── certora-specifier.md
│       ├── certora-runner.md
│       └── certora-reporter.md
├── _bmad/                     # BMad framework
├── _bmad-output/              # Artefatos gerados
│   ├── certora-analysis.md
│   ├── certora-raw-output.txt
│   ├── certora-summary.json
│   └── vulnerability-report.md
├── opencode.json              # Config OpenCode (gerado pelo BMad)
└── AGENTS.md                  # Gerado pelo /init do OpenCode
```

### 8.4 Arquivo `.conf` do Certora (exemplo)

Crie `specs/verification.conf`:
```json
{
  "files": ["contracts/MyToken.sol"],
  "verify": "MyToken:specs/reentrancy.spec",
  "solc": "solc",
  "output_dir": "_bmad-output/certora-results",
  "optimistic_loop": true,
  "loop_iter": "3",
  "msg": "Automated vulnerability scan via BMad/OpenCode"
}
```

---

## 9. Erros Comuns e Como Resolver

### 9.1 Erros de Instalação do BMad

**Erro:** `Could not resolve stable tag` ou `API rate limit exceeded`
```
Error: Could not resolve stable tag for module 'bmb'
```
**Causa:** GitHub limita chamadas anônimas a 60/hora por IP. Em WSL ou redes corporativas, vários usuários compartilham o mesmo IP.

**Solução:**
```bash
export GITHUB_TOKEN="seu-token-github-publico"
npx bmad-method install
```
Qualquer PAT do GitHub sem escopos especiais funciona.

---

**Erro:** `--pin bmm=X didn't do anything`

**Causa:** `bmm` é um módulo bundled dentro do instalador, não um módulo externo. `--pin` não se aplica a ele.

**Solução:** Use `npx bmad-method@next install` para obter a versão pré-release do `bmm`.

---

**Erro:** `Tag 'vX.Y.Z' not found`

**Causa:** A tag que você passou ao `--pin` não existe no repositório.

**Solução:** Verifique as releases disponíveis em `https://github.com/bmad-code-org/bmad-builder/releases`.

---

### 9.2 Erros de Integração BMad + OpenCode

**Problema:** Skills BMad não aparecem ao digitar `/` no OpenCode.

**Causa:** O BMad foi instalado com outro tool (ex: `claude-code`) ou a pasta `.opencode/skills/` está vazia.

**Diagnóstico:**
```bash
ls .opencode/skills/BMAD/bmm/
```
**Solução:** Re-instalar selecionando `opencode` como tool:
```bash
npx bmad-method install --yes --action update --tools opencode
```

---

**Problema:** Agentes customizados em `.opencode/agents/` não aparecem no `@` autocomplete.

**Causa:** O arquivo `.md` pode ter YAML frontmatter inválido ou estar no diretório global em vez do local.

**Diagnóstico:**
```bash
# Verificar estrutura do arquivo
head -20 .opencode/agents/certora-orchestrator.md
```
**Solução:** Confirme que o frontmatter YAML começa com `---` e tem pelo menos `description` e `mode`.

---

**Problema:** `opencode.json` conflita com configurações existentes.

**Causa:** O BMad modifica o `opencode.json` e pode sobrescrever configurações manuais.

**Solução:** Use `--set` para configurações do BMad e mantenha suas customizações fora do alcance do installer:
```bash
npx bmad-method install --yes --modules bmm --tools opencode \
  --set bmm.user_skill_level=expert
```
Sempre verifique o arquivo após o install e proteja configs críticas em `_bmad/config.user.toml`.

---

### 9.3 Erros do Certora Prover

**Erro:** `certoraRun: command not found`

**Causa:** O pacote foi instalado mas `~/.local/bin` não está no PATH.

**Solução:**
```bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
which certoraRun  # deve retornar o path
```
Se usou venv: `source ~/certora-env/bin/activate`

---

**Erro:** `CERTORAKEY environment variable is not set`

**Solução:**
```bash
export CERTORAKEY="sua-chave"
# Permanente:
echo 'export CERTORAKEY="sua-chave"' >> ~/.bashrc
source ~/.bashrc
```

---

**Erro:** `Solidity version mismatch` ou `solc: not found`

**Causa:** A versão do solc instalada não corresponde ao `pragma solidity` do contrato.

**Solução:**
```bash
pip3 install solc-select
solc-select install 0.8.20   # use a versão do seu contrato
solc-select use 0.8.20
```
No arquivo `.conf`, especifique: `"solc": "solc"` e `"solc_via_ir": false` para versões antigas.

---

**Erro:** `Timeout` nas regras CVL

**Causa:** Regras muito complexas ou loops sem limite (`loop_iter` não configurado).

**Solução no `.conf`:**
```json
{
  "optimistic_loop": true,
  "loop_iter": "3",
  "smt_timeout": "300"
}
```
Simplifique a spec: divida regras complexas em regras menores e mais focadas.

---

**Erro:** Agente OpenCode tenta rodar `certoraRun` mas a permissão está negada (permission dialog).

**Causa:** O agente não tem `"certoraRun *": allow` no frontmatter de permissões.

**Solução:** Adicione ao frontmatter YAML do agente:
```yaml
permission:
  bash:
    "certoraRun *": allow
```

---

### 9.4 Erros de Ambiente WSL

**Problema:** Performance lenta ao rodar certoraRun em arquivos em `/mnt/c/`.

**Solução (documentação oficial do OpenCode recomenda):**
```bash
# Clone o projeto para dentro do filesystem WSL
cp -r /mnt/c/Users/SeuNome/projeto ~/code/projeto
cd ~/code/projeto
```

---

**Problema:** Terminal WSL não renderiza corretamente o TUI do OpenCode.

**Causa:** Terminal sem suporte a Unicode/cores.

**Solução:** Use um terminal moderno. A documentação do OpenCode recomenda:
- [WezTerm](https://wezterm.org) (cross-platform, excelente no WSL)
- [Alacritty](https://alacritty.org) (cross-platform)
- [Windows Terminal](https://aka.ms/terminal) com perfil Ubuntu (gratuito, nativo)

---

## 10. Melhores Práticas

### 10.1 BMad

- **Sempre abra uma nova sessão (chat) para cada workflow.** O BMad foi desenhado para sessões frescas; contexto acumulado pode causar conflitos entre agentes.
- **Commite o `AGENTS.md` no Git.** Ele ajuda todos os agentes a entender o projeto.
- **Use `bmad-help` como ponto de partida.** Ele detecta o que já foi feito e indica o próximo passo, evitando retrabalho.
- **Registre customizações em `_bmad/_config/`**, não em `_bmad/`. Arquivos em `_bmad/_config/` sobrevivem a updates; os demais podem ser sobrescritos.

### 10.2 OpenCode

- **Use o modo Plan (Tab) antes de Build** para analisar o que o agente fará sem fazer alterações. Isso é crítico ao trabalhar com contratos que serão submetidos ao Certora.
- **Permissões granulares por agente.** Cada agente deve ter apenas as permissões que precisa. O orquestrador pode ter permissões mais amplas; sub-agentes de análise devem ser read-only.
- **Use múltiplas sessões paralelas** para rodar análises em contratos diferentes simultaneamente (OpenCode suporta isso nativamente).
- **Commite o `opencode.json`.** Permite que toda a equipe use a mesma configuração de agentes.

### 10.3 Certora Prover

- **Escreva specs incrementalmente.** Comece com invariantes simples (ex: `totalSupply >= balanceOf(user)`) antes de atacar reentrância.
- **Uma regra, uma propriedade.** Regras que testam muitas coisas ao mesmo tempo são difíceis de debugar quando falham.
- **Use `satisfy` antes de `assert`** para confirmar que sua spec é atingível (evita specs vacuamente verdadeiras).
- **Use `optimistic_loop: true`** para contratos com loops — sem isso, o Prover pode falhar por timeout tentando não-deterministicamente expandir loops.
- **Mantenha um diretório `specs/` versionado no Git** com as specs de cada contrato. Isso permite auditoria de quais propriedades foram verificadas.

### 10.4 Segurança de Chaves

```bash
# NUNCA commite chaves no repositório. Use .gitignore:
echo '.env' >> .gitignore
echo '*.key' >> .gitignore

# Use um arquivo .env local (não comitado):
cat > .env << 'EOF'
CERTORAKEY=sua-chave-certora
ANTHROPIC_API_KEY=sua-chave-anthropic
EOF

# Carregue no .bashrc ou use dotenv:
set -a && source .env && set +a
```

---

## 11. Ferramentas Complementares Recomendadas

Além do BMad + OpenCode + Certora, as seguintes ferramentas se integram bem ao pipeline de auditoria de contratos Solidity:

### 11.1 Foundry — Framework de Testes

Excelente para testes fuzz e unitários que complementam a verificação formal do Certora.

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
# Uso: forge test --fuzz-runs 10000
```
**Papel no pipeline:** Os agentes BMad podem rodar `forge test` como pré-verificação antes de submeter ao Certora.

### 11.2 Slither — Análise Estática

Analisador estático de Solidity da Trail of Bits. Rápido e sem necessidade de chave externa.

```bash
pip3 install slither-analyzer
slither contracts/MyToken.sol
```
**Papel no pipeline:** O `certora-analyzer` pode usar Slither para identificar entry points de vulnerabilidade antes de escrever specs CVL.

### 11.3 Mythril — Análise Simbólica

Ferramenta de análise de segurança para EVM.

```bash
pip3 install mythril
myth analyze contracts/MyToken.sol
```

### 11.4 solc-select — Gerenciador de Versões Solidity

Já mencionado, mas essencial:
```bash
pip3 install solc-select
solc-select install 0.8.20
solc-select use 0.8.20
```

### 11.5 hardhat-certora (plugin opcional)

Se o projeto usa Hardhat, existe um plugin que integra diretamente:
```bash
npm install --save-dev @certora/hardhat-certora
```

### 11.6 Stack Resumida para o Projeto

```
Análise Rápida    →  Slither + Mythril  (minutos, local)
Testes Fuzz       →  Foundry forge fuzz (minutos, local)
Verificação Formal →  Certora Prover    (minutos-horas, nuvem)
Orquestração AI   →  BMad + OpenCode    (coordena tudo acima)
```

---

## Links de Referência

| Recurso | URL |
|---|---|
| BMad Docs | https://docs.bmad-method.org |
| BMad GitHub | https://github.com/bmad-code-org/BMAD-METHOD |
| BMad Discord | https://discord.gg/gk8jAdXWmj |
| OpenCode Docs | https://opencode.ai/docs |
| OpenCode WSL Guide | https://opencode.ai/docs/windows-wsl |
| OpenCode Agents | https://opencode.ai/docs/agents |
| OpenCode GitHub | https://github.com/anomalyco/opencode |
| Certora Install | https://docs.certora.com/en/latest/docs/user-guide/install.html |
| Certora Prover Docs | https://docs.certora.com |
| Certora Signup (grátis) | https://www.certora.com/signup?plan=prover |
| Foundry | https://foundry.paradigm.xyz |
| Slither | https://github.com/crytic/slither |
| solc-select | https://github.com/crytic/solc-select |

---

*Documento gerado com base na documentação oficial de cada ferramenta. Última verificação: maio 2026.*
