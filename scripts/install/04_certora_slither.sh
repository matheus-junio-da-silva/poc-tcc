#!/usr/bin/env bash
# =============================================================================
# scripts/04_certora_slither.sh
# Instala Slither e Certora CLI via pip em um venv isolado.
# =============================================================================

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
readonly UTILS_DIR="${PROJECT_DIR}/utils"
readonly VENV_DIR="$PROJECT_DIR/certora_venv"

source "${UTILS_DIR}/logger.sh"

log_step "7. Instalando Slither e Certora CLI"

if [ ! -d "$VENV_DIR" ]; then
    log_info "Criando virtualenv em $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
fi

# Ativa o virtualenv e trata possiveis erros
set +u
source "$VENV_DIR/bin/activate"
set -u

log_info "Instalando certora-cli, slither-analyzer e solc-select via pip..."
pip install --quiet --upgrade pip
pip install --quiet certora-cli slither-analyzer solc-select

log_info "Verificando instalacao:"
if command -v slither &>/dev/null; then
    log_ok "slither $(slither --version 2>/dev/null)"
else
    log_err "Falha na instalacao do slither"
    exit 1
fi

if command -v certoraRun &>/dev/null; then
    log_ok "certoraRun disponivel"
else
    log_err "Falha na instalacao do certoraRun"
    exit 1
fi

log_info "Instalando versão padrao do solc (0.8.20)..."
solc-select install 0.8.20
solc-select use 0.8.20

log_ok "Slither e Certora CLI instalados no venv com sucesso."
log_ok "Módulo 04_certora_slither.sh concluído."
