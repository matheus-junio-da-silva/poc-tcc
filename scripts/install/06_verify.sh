#!/usr/bin/env bash
# =============================================================================
# scripts/06_verify.sh
# Verificação final e mensagem de sucesso
# =============================================================================

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
readonly UTILS_DIR="${PROJECT_DIR}/utils"
readonly OPENCODE_BIN="$HOME/.opencode/bin/opencode"

source "${UTILS_DIR}/logger.sh"
if [ -f "$PROJECT_DIR/.env" ]; then
    set -a; source "$PROJECT_DIR/.env"; set +a
fi

log_step "10. Verificacao final"

echo ""
echo -e "  ${BOLD}Componente                 Status${NC}"
echo -e "  ────────────────────────────────────────────────"

FAILED_REQUIRED=0

check() {
    local label="$1"
    local condition="$2"
    local detail="${3:-}"
    local is_required="${4:-true}"
    
    if eval "$condition" &>/dev/null; then
        echo -e "  ${GREEN}✓${NC} ${GREEN}${label}${NC}${detail:+ ($detail)}"
    else
        if [ "$is_required" = "true" ]; then
            echo -e "  ${RED}✗${NC} ${RED}${label}${NC} — NÃO ENCONTRADO / FALHOU"
            FAILED_REQUIRED=$((FAILED_REQUIRED + 1))
        else
            echo -e "  ${YELLOW}⚠${NC} ${YELLOW}${label}${NC} — não encontrado (opcional)"
        fi
    fi
}

check "Node.js 20+"               "node --version | grep -E 'v2[0-9]'"  "$(node --version 2>/dev/null || true)"
check "Python3"                   "python3 --version"                   "$(python3 --version 2>/dev/null | awk '{print $2}' || true)"
check "Java (OpenJDK)"            "java -version"                       "$(java -version 2>&1 | head -n 1 | cut -d' ' -f 1-3 | tr -d '\"' || true)"
check "OpenCode"                  "[ -f '$OPENCODE_BIN' ]"              "$($OPENCODE_BIN --version 2>/dev/null || echo '')"
check "BMad _bmad/bmm/"          "[ -d '$PROJECT_DIR/_bmad/bmm' ]"     "v$(grep -m1 'version:' $PROJECT_DIR/_bmad/_config/manifest.yaml 2>/dev/null | awk '{print $2}' || true)"
check "BMad _bmad/core/"         "[ -d '$PROJECT_DIR/_bmad/core' ]"
check "Skill BMad OpenCode"       "[ -f '$PROJECT_DIR/.opencode/skills/BMAD/bmad-skills.md' ]"
check "Agentes OpenCode (>=8)"   "[ \$(ls $PROJECT_DIR/.opencode/agents/*.md 2>/dev/null | wc -l) -ge 8 ]"
check "opencode.json/jsonc"      "[ -f '$PROJECT_DIR/opencode.json' ] || [ -f '$PROJECT_DIR/opencode.jsonc' ]"
check "Template feedback BMad"   "[ -f '$PROJECT_DIR/_bmad/templates/feedback-template.md' ]"
check "Certora CLI"              "[ -x '$PROJECT_DIR/certora_venv/bin/certoraRun' ]" "$($PROJECT_DIR/certora_venv/bin/certoraRun --version 2>/dev/null || true)"

# Certora
if [ "${CERTORA_MODE:-cloud}" = "local" ]; then
    echo -e "  ${GREEN}✓${NC} ${GREEN}CERTORA_MODE=local${NC}"
else
    if [ -n "${CERTORAKEY:-}" ] && [ "$CERTORAKEY" != "sua-chave-certora-aqui" ]; then
        echo -e "  ${GREEN}✓${NC} ${GREEN}CERTORAKEY configurada${NC}"
    else
        echo -e "  ${YELLOW}⚠${NC} ${YELLOW}CERTORAKEY${NC} — não configurada no .env (requerida para modo cloud)"
    fi
fi

echo ""

if [ "$FAILED_REQUIRED" -eq 0 ]; then
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${GREEN}  ✓ Instalação concluída com sucesso! Todos os testes passaram!${NC}"
    echo -e "${BOLD}${CYAN}═══════════════════════════════════════════════════════════${NC}"
else
    echo -e "${BOLD}${RED}═══════════════════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${RED}  ✗ Instalação concluída com $FAILED_REQUIRED falha(s) nos componentes obrigatórios!${NC}"
    echo -e "${BOLD}${RED}═══════════════════════════════════════════════════════════${NC}"
fi

echo ""
echo -e "  ${BOLD}Próximos passos:${NC}"
echo ""
echo -e "  ${YELLOW}1.${NC} Configure CERTORAKEY (modo cloud) e GITHUB_TOKEN (opcional):"
echo -e "     ${CYAN}nano .env${NC}"
echo ""
echo -e "  ${YELLOW}2.${NC} Recarregue o shell:"
echo -e "     ${CYAN}source ~/.bashrc${NC}"
echo ""
echo -e "  ${YELLOW}3.${NC} Abra o OpenCode no projeto e conecte um provider:"
echo -e "     ${CYAN}cd $PROJECT_DIR && opencode${NC}"
echo -e "     ${CYAN}/connect${NC}  — escolha OpenCode Zen ou GitHub Copilot"
echo ""
echo -e "  ${YELLOW}4.${NC} Dentro do OpenCode, inicie com o BMad:"
echo -e "     ${CYAN}bmad-help${NC}  — guia para o próximo passo"
echo ""
echo -e "  ${YELLOW}5.${NC} Para analisar um contrato Solidity:"
echo -e "     ${CYAN}@certora-orchestrator Analise contracts/MeuContrato.sol${NC}"
echo ""

log_ok "Módulo 06_verify.sh concluído."
