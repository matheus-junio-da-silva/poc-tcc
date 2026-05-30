#!/usr/bin/env bash
# =============================================================================
# scripts/03_bmad_install.sh
# Configura a estrutura do pipeline (OpenCode + Certora + Slither).
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

log_step "3. Criando diretórios do pipeline"

log_ok "Permissões ajustadas para $CURRENT_USER"

DIRS=(
    "$PROJECT_DIR/.opencode/agents"
    "$PROJECT_DIR/pipeline-output"
    "$PROJECT_DIR/pipeline-output/feedback-logs"
    "$PROJECT_DIR/specs"
)

for DIR in "${DIRS[@]}"; do
    run_as_user mkdir -p "$DIR"
done
log_ok "Estrutura de diretórios do pipeline criada"

log_ok "Módulo 03_bmad_install.sh concluído."
