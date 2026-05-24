#!/usr/bin/env bash
# =============================================================================
# install.sh — BMad Method + OpenCode + Agentes Certora
# Repositório: poc-tcc
#
# Uso:
#   bash install.sh
# =============================================================================

set -euo pipefail

readonly PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly SCRIPTS_DIR="${PROJECT_ROOT}/scripts"
readonly UTILS_DIR="${PROJECT_ROOT}/utils"
readonly CURRENT_USER="${SUDO_USER:-$USER}"

# Configura variavel SUDO que os sub-scripts podem usar
if [ "${EUID:-$(id -u)}" -ne 0 ] && command -v sudo &>/dev/null; then
    export SUDO="sudo"
    if ! sudo -v; then
        echo "sudo falhou. Verifique sua senha e tente novamente." >&2
        exit 1
    fi
else
    export SUDO=""
fi

if [[ ! -f "${UTILS_DIR}/logger.sh" ]]; then
    echo "ERRO CRÍTICO: Utilitário de log não encontrado em ${UTILS_DIR}/logger.sh" >&2
    exit 1
fi

source "${UTILS_DIR}/logger.sh"

on_error() {
    log_err "Falha na instalacao (linha $1). Verifique o log acima e tente novamente."
}

trap 'on_error $LINENO' ERR

main() {
    echo -e "${BOLD}${CYAN}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║       BMad Method + OpenCode — Script de Instalação      ║"
    echo "║           poc-tcc | WSL Ubuntu                           ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
    echo -e "  Projeto: ${CYAN}$PROJECT_ROOT${NC}"
    echo -e "  Usuário: ${CYAN}$CURRENT_USER${NC}"
    echo ""

    log_info "Iniciando processo de instalação do ambiente automatizado..."
    
    local -r modules=(
        "00_env_setup.sh"
        "01_os_deps.sh"
        "02_opencode_install.sh"
        "03_bmad_install.sh"
        "04_certora_slither.sh"
        "06_verify.sh"
    )

    for module in "${modules[@]}"; do
        local script_path="${SCRIPTS_DIR}/${module}"
        
        if [[ ! -x "${script_path}" ]]; then
            # Tentativa de conceder permissão se não for executável
            chmod +x "${script_path}" 2>/dev/null || {
                log_err "Módulo não encontrado ou sem permissão de execução: ${script_path}"
                exit 1
            }
        fi

        log_step "===> Executando módulo: ${module}"
        
        if ! "${script_path}"; then
            log_err "Falha crítica durante a execução de ${module}. Abortando."
            exit 1
        fi
    done
}

main "$@"
