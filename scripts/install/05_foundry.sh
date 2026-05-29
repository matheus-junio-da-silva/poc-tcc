#!/usr/bin/env bash
# =============================================================================
# scripts/install/05_foundry.sh
# Instala Foundry (forge, cast, anvil, chisel) para PoC e testes.
# =============================================================================

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
readonly UTILS_DIR="${PROJECT_DIR}/utils"

source "${UTILS_DIR}/logger.sh"

log_step "8. Instalando Foundry (Forge/Cast/Anvil)"

# Verificar se Foundry ja esta instalado
if command -v forge &>/dev/null; then
    FORGE_VERSION=$(forge --version 2>/dev/null | head -1 || echo "unknown")
    log_ok "Foundry ja instalado: $FORGE_VERSION"
else
    log_info "Instalando Foundry via foundryup..."

    # Instalar foundryup se nao existir
    if ! command -v foundryup &>/dev/null; then
        curl -L https://foundry.paradigm.xyz 2>/dev/null | bash
        # Adicionar ao PATH do shell atual
        export PATH="$HOME/.foundry/bin:$PATH"
    fi

    # Rodar foundryup para instalar forge/cast/anvil/chisel
    if command -v foundryup &>/dev/null; then
        foundryup
        log_ok "Foundry instalado com sucesso"
    else
        log_err "Falha ao instalar foundryup. Verifique sua conexao de internet."
        log_warn "Foundry e opcional — o pipeline funciona sem ele (sem PoC automatico)."
    fi
fi

# Garantir que o PATH do Foundry esta no .bashrc
CURRENT_USER="${SUDO_USER:-$USER}"
USER_HOME=$(eval echo "~$CURRENT_USER")
USER_BASHRC="$USER_HOME/.bashrc"

if ! grep -qF '.foundry/bin' "$USER_BASHRC" 2>/dev/null; then
    echo '' >> "$USER_BASHRC"
    echo '# Foundry (forge/cast/anvil)' >> "$USER_BASHRC"
    echo 'export PATH="$HOME/.foundry/bin:$PATH"' >> "$USER_BASHRC"
    log_ok "Foundry PATH adicionado ao .bashrc"
fi

# Verificar instalacao
if command -v forge &>/dev/null; then
    log_ok "forge $(forge --version 2>/dev/null | grep -oP 'forge \K[\d.]+' || echo 'ok')"
    log_ok "cast disponivel"
    log_ok "anvil disponivel"
else
    log_warn "Foundry nao encontrado no PATH. Reinicie o terminal ou execute: source ~/.bashrc"
fi

log_ok "Modulo 05_foundry.sh concluido."
