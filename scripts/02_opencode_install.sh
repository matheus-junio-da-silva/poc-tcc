#!/usr/bin/env bash
# =============================================================================
# scripts/02_opencode_install.sh
# Instala o OpenCode
# =============================================================================

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
readonly UTILS_DIR="${PROJECT_DIR}/utils"

source "${UTILS_DIR}/logger.sh"

readonly CURRENT_USER="${SUDO_USER:-$USER}"

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

log_step "2. Instalando o OpenCode"

USER_HOME=$(eval echo "~$CURRENT_USER")
OPENCODE_BIN="$USER_HOME/.opencode/bin/opencode"

if [ -f "$OPENCODE_BIN" ]; then
    log_ok "OpenCode já instalado: $($OPENCODE_BIN --version 2>/dev/null || echo 'versão desconhecida')"
else
    log_info "Instalando OpenCode via script oficial..."
    run_as_user bash -c 'curl -fsSL https://opencode.ai/install | bash'
    if [ -f "$OPENCODE_BIN" ]; then
        log_ok "OpenCode $($OPENCODE_BIN --version 2>/dev/null) instalado"
    else
        log_warn "OpenCode instalado mas não encontrado em $OPENCODE_BIN"
    fi
fi

log_ok "Módulo 02_opencode_install.sh concluído."
