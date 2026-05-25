#!/usr/bin/env bash
# =============================================================================
# scripts/00_env_setup.sh
# Configura variáveis de ambiente, arquivos .env e PATH do usuário.
# =============================================================================

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
readonly UTILS_DIR="${PROJECT_DIR}/utils"

source "${UTILS_DIR}/logger.sh"

readonly ENV_FILE="$PROJECT_DIR/.env"
readonly ENV_EXAMPLE="$PROJECT_DIR/.env.example"
readonly CURRENT_USER="${SUDO_USER:-$USER}"

log_step "0. Preparando ambiente e chaves (.env)"

# =============================================================================
# 1. Garantir .env e .env.example
# =============================================================================
if [ ! -f "$ENV_EXAMPLE" ]; then
    cat > "$ENV_EXAMPLE" << 'ENV_EOF'
# ─────────────────────────────────────────────────────────────
# Variaveis de ambiente — poc-tcc (BMad + OpenCode + Certora)
# NUNCA commite o arquivo .env
# ─────────────────────────────────────────────────────────────

# Certora Prover — necessario para verificacao formal
# Obter em: https://www.certora.com/signup?plan=prover
CERTORA_MODE=cloud
CERTORAKEY=sua-chave-certora-aqui

# GitHub Token — opcional, evita rate limit durante instalacao do BMad
# Obter em: https://github.com/settings/tokens
GITHUB_TOKEN=

# ─────────────────────────────────────────────────────────────
# Opcionais — apenas se precisar de outros providers no OpenCode
# ─────────────────────────────────────────────────────────────
# OPENAI_API_KEY=
# GOOGLE_AI_API_KEY=
ENV_EOF
    log_ok ".env.example criado"
else
    log_ok ".env.example ja existe"
fi

if [ ! -f "$ENV_FILE" ]; then
    cp "$ENV_EXAMPLE" "$ENV_FILE"
    log_warn ".env criado — preencha suas chaves em: $ENV_FILE"
else
    log_ok ".env ja existe"
fi

# Carregar o .env atual para poder avaliar CERTORA_MODE e CERTORAKEY
set -a; source "$ENV_FILE"; set +a

set_env_var() {
    local key="$1"
    local value="$2"
    local file="${3:-$ENV_FILE}"

    if [ ! -f "$file" ]; then
        touch "$file"
    fi

    if grep -q "^${key}=" "$file"; then
        sed -i "s|^${key}=.*|${key}=${value}|" "$file"
    else
        echo "${key}=${value}" >> "$file"
    fi
}

remove_env_var() {
    local key="$1"
    local file="${2:-$ENV_FILE}"

    if [ -f "$file" ] && grep -q "^${key}=" "$file"; then
        sed -i "/^${key}=/d" "$file"
    fi
}

# =============================================================================
# 2. Configurar modo do Certora
# =============================================================================
CERTORA_MODE="${CERTORA_MODE:-}"
if [ -z "$CERTORA_MODE" ]; then
    if [ -t 0 ]; then
        read -r -p "Usar Certora Cloud? (requer CERTORAKEY) [Y/n] " CERTORA_MODE || true
    elif [ -c /dev/tty ]; then
        read -r -p "Usar Certora Cloud? (requer CERTORAKEY) [Y/n] " CERTORA_MODE < /dev/tty || true
    fi
fi

if [ -z "$CERTORA_MODE" ]; then
    CERTORA_MODE="cloud"
fi

if [[ "${CERTORA_MODE,,}" == "n" || "${CERTORA_MODE,,}" == "no" || "${CERTORA_MODE,,}" == "local" ]]; then
    CERTORA_MODE="local"
    set_env_var "CERTORA_MODE" "local"
    log_info "Modo local selecionado. CERTORAKEY nao e obrigatorio."
else
    CERTORA_MODE="cloud"
    set_env_var "CERTORA_MODE" "cloud"

    if [ -z "${CERTORAKEY:-}" ] || [ "$CERTORAKEY" = "sua-chave-certora-aqui" ]; then
        if [ -t 0 ]; then
            read -r -s -p "Digite sua CERTORAKEY: " CERTORAKEY || true
            echo ""
        elif [ -c /dev/tty ]; then
            read -r -s -p "Digite sua CERTORAKEY: " CERTORAKEY < /dev/tty || true
            echo ""
        fi
    fi

    if [ -n "${CERTORAKEY:-}" ] && [ "$CERTORAKEY" != "sua-chave-certora-aqui" ]; then
        set_env_var "CERTORAKEY" "$CERTORAKEY"
        log_ok "CERTORAKEY salva no .env"
    else
        log_warn "CERTORAKEY nao configurada. O certoraRun falhara no modo cloud."
    fi
fi

remove_env_var "ANTHROPIC_API_KEY"

# =============================================================================
# 3. Configurar PATH
# =============================================================================
log_step "0.5 Configurando PATH do usuário"

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

log_success() { echo -e "  \033[0;32m✓\033[0m $1"; }
log_success "Módulo 00_env_setup.sh concluído."
