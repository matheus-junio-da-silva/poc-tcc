#!/usr/bin/env bash
# =============================================================================
# install.sh — BMad Method + OpenCode + Agentes Certora
# Repositório: poc-tcc
#
# Uso:
#   bash install.sh
#
# Instalação baseada no guia oficial:
#   docs/bmad/bmad-opencode-certora-guide.md
#
# Pré-requisitos:
#   - WSL Ubuntu 22.04+ ou Ubuntu nativo
#   - sudo com senha (para instalação de pacotes apt)
#   - Acesso à internet
#
# Variáveis de ambiente (opcionais — lidas do .env se existir):
#   ANTHROPIC_API_KEY  — chave Anthropic para o OpenCode
#   CERTORAKEY         — chave Certora Prover (certora.com/signup)
#   GITHUB_TOKEN       — token GitHub (evita rate limit no BMad)
# =============================================================================

set -euo pipefail

# ─── Cores ──────────────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log_step()  { echo -e "\n${BOLD}${BLUE}==>${NC} ${BOLD}$1${NC}"; }
log_ok()    { echo -e "  ${GREEN}✓${NC} $1"; }
log_warn()  { echo -e "  ${YELLOW}⚠${NC}  $1"; }
log_err()   { echo -e "  ${RED}✗${NC} $1" >&2; }
log_info()  { echo -e "  ${CYAN}ℹ${NC}  $1"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR"
CURRENT_USER="${SUDO_USER:-$USER}"

# =============================================================================
# BANNER
# =============================================================================
echo -e "${BOLD}${CYAN}"
echo "╔══════════════════════════════════════════════════════════╗"
echo "║       BMad Method + OpenCode — Script de Instalação      ║"
echo "║           poc-tcc | WSL Ubuntu                           ║"
echo "╚══════════════════════════════════════════════════════════╝"
echo -e "${NC}"
echo -e "  Projeto: ${CYAN}$PROJECT_DIR${NC}"
echo -e "  Usuário: ${CYAN}$CURRENT_USER${NC}"
echo ""

# =============================================================================
# PASSO 0 — Carregar .env
# =============================================================================
log_step "0. Carregando variáveis de ambiente"

if [ -f "$PROJECT_DIR/.env" ]; then
    set -a; source "$PROJECT_DIR/.env"; set +a
    log_ok ".env carregado"
else
    log_warn ".env não encontrado — crie um baseado em .env.example"
fi

# =============================================================================
# PASSO 1 — Dependências do sistema
# =============================================================================
log_step "1. Verificando e instalando dependências do sistema"

apt-get update -qq

# Git
command -v git &>/dev/null && log_ok "git $(git --version | awk '{print $3}')" || {
    apt-get install -y git; log_ok "git instalado"
}

# curl
command -v curl &>/dev/null && log_ok "curl" || {
    apt-get install -y curl; log_ok "curl instalado"
}

# expect (necessário para automatizar o instalador interativo do BMad)
command -v expect &>/dev/null && log_ok "expect" || {
    apt-get install -y expect; log_ok "expect instalado"
}

# Node.js 20+
NODE_REQUIRED=20
if command -v node &>/dev/null; then
    NODE_MAJOR=$(node --version | sed 's/v//' | cut -d. -f1)
    if [ "$NODE_MAJOR" -ge "$NODE_REQUIRED" ]; then
        log_ok "Node.js $(node --version)"
    else
        log_info "Atualizando Node.js para v$NODE_REQUIRED..."
        curl -fsSL "https://deb.nodesource.com/setup_${NODE_REQUIRED}.x" | bash -
        apt-get install -y nodejs
        log_ok "Node.js $(node --version)"
    fi
else
    log_info "Instalando Node.js $NODE_REQUIRED..."
    curl -fsSL "https://deb.nodesource.com/setup_${NODE_REQUIRED}.x" | bash -
    apt-get install -y nodejs
    log_ok "Node.js $(node --version)"
fi

# Python3 (necessário para Certora Prover)
command -v python3 &>/dev/null && log_ok "Python3 $(python3 --version | awk '{print $2}')" || {
    apt-get install -y python3 python3-pip python3-venv; log_ok "Python3 instalado"
}

# Java 21 (necessário para Certora Prover)
command -v java &>/dev/null && log_ok "Java" || {
    log_warn "Java não encontrado — instale manualmente: sudo apt-get install -y openjdk-21-jdk"
}

# =============================================================================
# PASSO 2 — Configurar PATH
# =============================================================================
log_step "2. Configurando PATH"

# PATH para usuário atual
USER_HOME=$(eval echo "~$CURRENT_USER")
USER_BASHRC="$USER_HOME/.bashrc"

if ! grep -qF 'HOME/.local/bin' "$USER_BASHRC" 2>/dev/null; then
    echo '' >> "$USER_BASHRC"
    echo '# Adicionado pelo install.sh do poc-tcc' >> "$USER_BASHRC"
    echo 'export PATH="$HOME/.local/bin:$HOME/.opencode/bin:$PATH"' >> "$USER_BASHRC"
    log_ok "PATH configurado em $USER_BASHRC"
else
    log_ok "PATH já configurado"
fi

export PATH="$USER_HOME/.local/bin:$USER_HOME/.opencode/bin:$PATH"

# =============================================================================
# PASSO 3 — Instalar o OpenCode
# =============================================================================
log_step "3. Instalando o OpenCode"
# Fonte: guia seção 3.1 | documentação: https://opencode.ai/docs

OPENCODE_BIN="$USER_HOME/.opencode/bin/opencode"

if [ -f "$OPENCODE_BIN" ]; then
    log_ok "OpenCode já instalado: $($OPENCODE_BIN --version 2>/dev/null || echo 'versão desconhecida')"
else
    log_info "Instalando OpenCode via script oficial..."
    sudo -u "$CURRENT_USER" bash -c 'curl -fsSL https://opencode.ai/install | bash'
    if [ -f "$OPENCODE_BIN" ]; then
        log_ok "OpenCode $($OPENCODE_BIN --version 2>/dev/null) instalado"
    else
        log_warn "OpenCode instalado mas não encontrado em $OPENCODE_BIN"
        log_info "Execute: source ~/.bashrc && opencode --version"
    fi
fi

# =============================================================================
# PASSO 4 — Corrigir permissões dos diretórios do projeto
# =============================================================================
log_step "4. Ajustando permissões do projeto"

# Garantir que o usuário atual é dono de todos os arquivos do projeto
chown -R "$CURRENT_USER:$CURRENT_USER" "$PROJECT_DIR" 2>/dev/null || true
log_ok "Permissões ajustadas para $CURRENT_USER"

# =============================================================================
# PASSO 5 — Instalar o BMad Method
# =============================================================================
log_step "5. Instalando o BMad Method (v6.7.1+)"
# Fonte: guia seção 4 | instalador interativo automatizado com expect

cd "$PROJECT_DIR"

if [ -d "$PROJECT_DIR/_bmad/bmm" ] && [ -d "$PROJECT_DIR/_bmad/core" ]; then
    log_ok "BMad já instalado (_bmad/bmm e _bmad/core presentes)"
    log_info "Versão: $(grep 'version:' _bmad/_config/manifest.yaml | head -1 | awk '{print $2}')"
else
    log_info "Instalando BMad via expect (responde automaticamente ao instalador interativo)..."
    log_warn "Este processo pode levar 1-2 minutos — aguarde..."

    # Script expect para automatizar o instalador interativo do BMad
    # O BMad usa @clack/prompts que requer TTY real (não aceita pipe simples)
    sudo -u "$CURRENT_USER" expect << 'EXPECT_EOF'
set timeout 180
spawn bash -c "stty rows 40 cols 120; cd /PLACEHOLDER_PROJECT_DIR && npx --yes bmad-method install"

# Prompt 1: Installation directory
expect -re {Installation directory} { sleep 1; send "\r" }

# Prompt 2: Install to this directory?
expect -re {Install to this directory} { sleep 1; send "\r" }

# Prompt 3: Select official modules (bmm + core pré-selecionados)
expect -re {Select official modules} { sleep 1; send "\r" }

# Prompt 4: Community modules? Não
expect -re {community modules} { sleep 1; send "\r" }

# Prompt 5: Integrate with — selecionar OpenCode via busca
expect -re {Integrate with} {
    sleep 1.5
    send "Open"
    sleep 1.5
    send " "
    sleep 0.5
    send "\r"
}

# Prompt 6: Nome do usuário
expect -re {agents call you} { sleep 1; send "\r" }

# Prompt 7: Nome do projeto
expect -re {project called} { sleep 1; send "\r" }

# Prompt 8: Idioma do agente
expect -re {language should agents} { sleep 1; send "\r" }

# Prompt 9: Idioma do documento
expect -re {document output} { sleep 1; send "\r" }

# Prompt 10: Diretório de output
expect -re {output files} { sleep 1; send "\r" }

# Aguardar conclusão
expect {
    -re {BMAD is ready|Installation complete|finalized} {
        puts "\n✓ BMad instalado!"
    }
    eof { puts "\n✓ Concluído" }
    timeout { puts "\nTimeout — verifique a instalação" }
}
wait
EXPECT_EOF

    if [ -d "$PROJECT_DIR/_bmad/bmm" ]; then
        log_ok "BMad instalado com sucesso"
    else
        log_warn "BMad pode não ter completado — execute manualmente: npx bmad-method install"
    fi
fi

# =============================================================================
# PASSO 6 — Criar estrutura de diretórios
# =============================================================================
log_step "6. Criando estrutura de diretórios"

DIRS=(
    "$PROJECT_DIR/.opencode/agents"
    "$PROJECT_DIR/.opencode/skills/BMAD"
    "$PROJECT_DIR/_bmad-output"
    "$PROJECT_DIR/_bmad-output/planning-artifacts"
    "$PROJECT_DIR/_bmad-output/implementation-artifacts"
    "$PROJECT_DIR/_bmad-output/feedback-logs"
    "$PROJECT_DIR/_bmad/templates"
    "$PROJECT_DIR/specs"
)

for DIR in "${DIRS[@]}"; do
    mkdir -p "$DIR"
    chown "$CURRENT_USER:$CURRENT_USER" "$DIR" 2>/dev/null || true
done
log_ok "Diretórios criados e permissões ajustadas"

# =============================================================================
# PASSO 7 — Criar skill BMad para OpenCode
# =============================================================================
log_step "7. Criando skill BMad para o OpenCode"

SKILL_FILE="$PROJECT_DIR/.opencode/skills/BMAD/bmad-skills.md"
if [ -f "$SKILL_FILE" ]; then
    log_ok "bmad-skills.md já existe"
else
    cat > "$SKILL_FILE" << 'SKILL_EOF'
---
description: "BMad Method skills - invoke by name: bmad-help, bmad-prd, bmad-architecture, bmad-dev-story, bmad-quick-dev, etc."
---

# BMad Method Skills

## Core Skills
- `bmad-help` — Analisa o projeto e recomenda o próximo passo
- `bmad-brainstorming` — Sessão de ideação guiada
- `bmad-advanced-elicitation` — Critique e refinamento profundo

## Planning (BMad Method)
- `bmad-product-brief` — Brief do produto
- `bmad-prfaq` — Working Backwards (PR/FAQ)
- `bmad-prd` — Product Requirements Document
- `bmad-architecture` — Documento de arquitetura técnica
- `bmad-ux` — Fluxos de UX e wireframes

## Implementation
- `bmad-sm` — Scrum Master — sprint planning e histórias
- `bmad-dev-story` — Implementar uma história de desenvolvimento
- `bmad-quick-dev` — Desenvolvimento rápido (Quick Flow)
- `bmad-code-review` — Revisão de código
- `bmad-qa-generate-e2e-tests` — Gerar testes E2E

## Certora Pipeline
- `@certora-orchestrator` — Pipeline completo de verificação formal
- `@certora-analyzer` — Analisa contratos Solidity
- `@certora-specifier` — Escreve especificações CVL
- `@certora-runner` — Executa certoraRun
- `@certora-reporter` — Relatório de vulnerabilidades

## Reference
- Módulos BMad: `_bmad/`
- Artefatos: `_bmad-output/`
- Agentes Certora: `.opencode/agents/`
SKILL_EOF
    log_ok "bmad-skills.md criado"
fi

# =============================================================================
# PASSO 8 — Criar agentes Certora customizados
# =============================================================================
log_step "8. Criando agentes customizados Certora"
# Fonte: guia seções 7.2 a 7.6

AGENTS_DIR="$PROJECT_DIR/.opencode/agents"

# Agente Orquestrador
cat > "$AGENTS_DIR/certora-orchestrator.md" << 'AGENT_EOF'
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
AGENT_EOF

# Agente Analisador
cat > "$AGENTS_DIR/certora-analyzer.md" << 'AGENT_EOF'
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
AGENT_EOF

# Agente Escritor de Specs CVL
cat > "$AGENTS_DIR/certora-specifier.md" << 'AGENT_EOF'
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
- `mathint` — unbounded integer (avoids overflow)

## Common Vulnerability Specs

### Reentrancy
```cvl
rule noReentrancy(method f) {
    env e; calldataarg args;
    uint256 balanceBefore = nativeBalances[currentContract];
    f(e, args);
    uint256 balanceAfter = nativeBalances[currentContract];
    assert balanceAfter >= balanceBefore;
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
AGENT_EOF

# Agente Executor
cat > "$AGENTS_DIR/certora-runner.md" << 'AGENT_EOF'
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
AGENT_EOF

# Agente Reporter
cat > "$AGENTS_DIR/certora-reporter.md" << 'AGENT_EOF'
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
AGENT_EOF

log_ok "5 agentes Certora criados em .opencode/agents/"

# =============================================================================
# PASSO 9 — Criar template de feedback BMad
# =============================================================================
log_step "9. Criando template de feedback BMad"
# Fonte: guia-completo-bmad.md seção 9

TEMPLATE_FILE="$PROJECT_DIR/_bmad/templates/feedback-template.md"
if [ ! -f "$TEMPLATE_FILE" ]; then
    mkdir -p "$(dirname "$TEMPLATE_FILE")"
    cat > "$TEMPLATE_FILE" << 'TEMPLATE_EOF'
# Relatório de Feedback — [Nome da Tarefa]

**Agente:** [Nome do agente/persona]
**Data:** [YYYY-MM-DD]
**Tarefa:** [Descrição breve da tarefa executada]
**Status:** [Concluído / Parcial / Bloqueado]
**Duração estimada:** [Tempo aproximado de execução]

---

## 1. RESUMO DA ENTREGA
[2–3 parágrafos descrevendo o que foi feito, como foi feito e o resultado alcançado]

---

## 2. METODOLOGIA UTILIZADA
### Abordagem geral
[Como o agente estruturou o trabalho]

### Decisões tomadas durante a execução
| Decisão | Alternativas consideradas | Razão da escolha |
|---|---|---|
| [Decisão 1] | [Alt A, Alt B] | [Por que esta foi escolhida] |

---

## 3. ERROS E PROBLEMAS ENCONTRADOS
### 3.1 Erros não documentados nas instruções
| # | Descrição | Impacto | Solução |
|---|---|---|---|

### 3.2 Ambiguidades nas instruções
| # | Instrução ambígua | Minha interpretação | Alternativa possível |
|---|---|---|---|

---

## 4. RECOMENDAÇÕES PARA MELHORIA DO AGENTE
### 4.1 Adicionar às instruções
```
[Texto sugerido]
```

---

## 7. MÉTRICAS DE QUALIDADE
| Critério | Nota (1–5) | Justificativa |
|---|---|---|
| Fidelidade ao objetivo | [1–5] | |
| Qualidade do output | [1–5] | |
| Completude | [1–5] | |

**Nota geral:** [Média] / 5

---
*Relatório gerado pelo agente [Nome] em [Data/Hora]*
TEMPLATE_EOF
    log_ok "feedback-template.md criado"
else
    log_ok "feedback-template.md já existe"
fi

# =============================================================================
# PASSO 10 — Criar .env.example
# =============================================================================
log_step "10. Criando .env.example"

ENV_EXAMPLE="$PROJECT_DIR/.env.example"
if [ ! -f "$ENV_EXAMPLE" ]; then
    cat > "$ENV_EXAMPLE" << 'ENV_EOF'
# ─────────────────────────────────────────────────────────────
# Variáveis de ambiente — poc-tcc (BMad + OpenCode + Certora)
# Copie para .env e preencha suas chaves
# NUNCA commite o arquivo .env
# ─────────────────────────────────────────────────────────────

# Anthropic Claude — necessário para o OpenCode
# Obter em: https://console.anthropic.com/settings/keys
ANTHROPIC_API_KEY=sua-chave-anthropic-aqui

# Certora Prover — necessário para verificação formal
# Obter em: https://www.certora.com/signup?plan=prover
CERTORAKEY=sua-chave-certora-aqui

# GitHub Token — opcional, evita rate limit durante instalação do BMad
GITHUB_TOKEN=
ENV_EOF
    log_ok ".env.example criado"
else
    log_ok ".env.example já existe"
fi

# Criar .env se não existir
if [ ! -f "$PROJECT_DIR/.env" ]; then
    cp "$ENV_EXAMPLE" "$PROJECT_DIR/.env"
    log_warn ".env criado — preencha suas chaves em: $PROJECT_DIR/.env"
fi

# =============================================================================
# PASSO 11 — Criar opencode.json
# =============================================================================
log_step "11. Criando opencode.json"

OPENCODE_JSON="$PROJECT_DIR/opencode.json"
if [ ! -f "$OPENCODE_JSON" ]; then
    cat > "$OPENCODE_JSON" << 'JSON_EOF'
{
  "$schema": "https://opencode.ai/config.json",
  "rules": [
    "./_bmad/core/bmad-help/SKILL.md",
    "./_bmad/_config/skill-manifest.csv"
  ]
}
JSON_EOF
    log_ok "opencode.json criado"
else
    log_ok "opencode.json já existe"
fi

# Ajustar permissões finais
chown -R "$CURRENT_USER:$CURRENT_USER" "$PROJECT_DIR/.opencode" "$PROJECT_DIR/_bmad-output" \
    "$PROJECT_DIR/opencode.json" "$PROJECT_DIR/.env" "$PROJECT_DIR/.env.example" 2>/dev/null || true

# =============================================================================
# PASSO 12 — Verificação final
# =============================================================================
log_step "12. Verificação final"

echo ""
echo -e "  ${BOLD}Componente                 Status${NC}"
echo -e "  ────────────────────────────────────────────────"

check() {
    local label="$1"
    local condition="$2"
    local detail="${3:-}"
    if eval "$condition" &>/dev/null; then
        echo -e "  ${GREEN}✓${NC} ${label}${detail:+ ($detail)}"
    else
        echo -e "  ${YELLOW}⚠${NC} ${label} — não encontrado"
    fi
}

check "Node.js 20+"               "node --version | grep -E 'v2[0-9]'"  "$(node --version 2>/dev/null)"
check "OpenCode"                  "[ -f '$OPENCODE_BIN' ]"              "$($OPENCODE_BIN --version 2>/dev/null || echo '')"
check "BMad _bmad/bmm/"          "[ -d '$PROJECT_DIR/_bmad/bmm' ]"     "v$(grep -m1 'version:' $PROJECT_DIR/_bmad/_config/manifest.yaml 2>/dev/null | awk '{print $2}')"
check "BMad _bmad/core/"         "[ -d '$PROJECT_DIR/_bmad/core' ]"
check "Skill BMad OpenCode"       "[ -f '$PROJECT_DIR/.opencode/skills/BMAD/bmad-skills.md' ]"
check "Agentes Certora (5)"      "[ \$(ls $PROJECT_DIR/.opencode/agents/*.md 2>/dev/null | wc -l) -eq 5 ]"
check "opencode.json"            "[ -f '$PROJECT_DIR/opencode.json' ]"
check "Template feedback BMad"   "[ -f '$PROJECT_DIR/_bmad/templates/feedback-template.md' ]"

# Chaves de API
if [ -n "${ANTHROPIC_API_KEY:-}" ] && [ "$ANTHROPIC_API_KEY" != "sua-chave-anthropic-aqui" ]; then
    echo -e "  ${GREEN}✓${NC} ANTHROPIC_API_KEY configurada"
else
    echo -e "  ${YELLOW}⚠${NC} ANTHROPIC_API_KEY — não configurada (edite .env)"
fi

if [ -n "${CERTORAKEY:-}" ] && [ "$CERTORAKEY" != "sua-chave-certora-aqui" ]; then
    echo -e "  ${GREEN}✓${NC} CERTORAKEY configurada"
else
    echo -e "  ${YELLOW}⚠${NC} CERTORAKEY — não configurada (edite .env)"
fi

echo ""

# =============================================================================
# RESUMO FINAL
# =============================================================================
echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${BOLD}${GREEN}  ✓ Instalação concluída!${NC}"
echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo -e "  ${BOLD}Próximos passos:${NC}"
echo ""
echo -e "  ${YELLOW}1.${NC} Configure suas chaves de API:"
echo -e "     ${CYAN}nano .env${NC}"
echo ""
echo -e "  ${YELLOW}2.${NC} Recarregue o shell:"
echo -e "     ${CYAN}source ~/.bashrc${NC}"
echo ""
echo -e "  ${YELLOW}3.${NC} Abra o OpenCode no projeto:"
echo -e "     ${CYAN}cd $PROJECT_DIR && opencode${NC}"
echo ""
echo -e "  ${YELLOW}4.${NC} Dentro do OpenCode, inicie com o BMad:"
echo -e "     ${CYAN}bmad-help${NC}  — guia para o próximo passo"
echo ""
echo -e "  ${YELLOW}5.${NC} Para analisar um contrato Solidity:"
echo -e "     ${CYAN}@certora-orchestrator Analise contracts/MeuContrato.sol${NC}"
echo ""
echo -e "  ${BOLD}Documentação:${NC}"
echo -e "     ${CYAN}docs/bmad/bmad-opencode-certora-guide.md${NC}"
echo -e "     ${CYAN}docs/bmad/guia-completo-bmad.md${NC}"
echo ""
