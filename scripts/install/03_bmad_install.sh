#!/usr/bin/env bash
# =============================================================================
# scripts/03_bmad_install.sh
# Ajusta permissões, instala BMad Method, cria diretórios e templates.
# =============================================================================

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
readonly UTILS_DIR="${PROJECT_DIR}/utils"

source "${UTILS_DIR}/logger.sh"

readonly CURRENT_USER="${SUDO_USER:-$USER}"

# Verifica se o sudo foi exportado pelo orquestrador
if [ -z "${SUDO:-}" ]; then
    if [ "${EUID:-$(id -u)}" -ne 0 ] && command -v sudo &>/dev/null; then
        SUDO="sudo"
    else
        SUDO=""
    fi
fi

run_as_user() {
    if [ "${EUID:-$(id -u)}" -eq 0 ] && [ -n "$CURRENT_USER" ] && [ "$CURRENT_USER" != "root" ]; then
        if command -v sudo &>/dev/null; then
            sudo -u "$CURRENT_USER" "$@"
        else
            su - "$CURRENT_USER" -c "$(printf "%q " "$@")"
        fi
    else
        "$@"
    fi
}

log_step "3. Ajustando permissões do projeto e criando diretórios"


log_ok "Permissões ajustadas para $CURRENT_USER"

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
    run_as_user mkdir -p "$DIR"
done
log_ok "Estrutura de diretórios BMad criada"

log_step "4. Instalando o BMad Method (v6.7.1+)"

cd "$PROJECT_DIR"

if [ -d "$PROJECT_DIR/_bmad/bmm" ] && [ -d "$PROJECT_DIR/_bmad/core" ]; then
    log_ok "BMad já instalado (_bmad/bmm e _bmad/core presentes)"
else
    log_info "Instalando BMad via expect..."
    log_warn "Este processo pode levar 1-2 minutos — aguarde..."

    run_as_user expect << EXPECT_EOF
set timeout 180
set project_dir "$PROJECT_DIR"
spawn bash -c "stty rows 40 cols 120; cd \"\$project_dir\" && npx --yes bmad-method install"

expect -re {Installation directory} { sleep 1; send "\r" }
expect -re {Install to this directory} { sleep 1; send "\r" }
expect -re {Select official modules} { sleep 1; send "\r" }
expect -re {community modules} { sleep 1; send "\r" }
expect -re {Integrate with} { sleep 1; send "OpenCode\r"; sleep 1 }
expect -re {agents call you} { sleep 1; send "\r" }
expect -re {project called} { sleep 1; send "\r" }
expect -re {language should agents} { sleep 1; send "\r" }
expect -re {document output} { sleep 1; send "\r" }
expect -re {output files} { sleep 1; send "\r" }

expect {
    -re {BMAD is ready|Installation complete|finalized} { puts "\n✓ BMad instalado!" }
    eof { puts "\n✓ Concluído" }
    timeout { puts "\nTimeout — verifique a instalação" }
}
wait
EXPECT_EOF

    if [ -d "$PROJECT_DIR/_bmad/bmm" ]; then
        log_ok "BMad instalado com sucesso"
    else
        log_warn "BMad pode não ter completado. Execute npx bmad-method install manualmente."
    fi
fi

log_step "5. Criando skill BMad para o OpenCode"

SKILL_FILE="$PROJECT_DIR/.opencode/skills/BMAD/bmad-skills.md"
if [ ! -f "$SKILL_FILE" ]; then
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
else
    log_ok "bmad-skills.md já existe"
fi

log_step "6. Criando template de feedback BMad"

TEMPLATE_FILE="$PROJECT_DIR/_bmad/templates/feedback-template.md"
if [ ! -f "$TEMPLATE_FILE" ]; then
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

log_ok "Módulo 03_bmad_install.sh concluído."
