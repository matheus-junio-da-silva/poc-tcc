#!/usr/bin/env bash
# =============================================================================
# scripts/01_os_deps.sh
# Instala dependências do sistema operacional via apt.
# =============================================================================

set -euo pipefail

readonly SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly PROJECT_DIR="$(dirname "$(dirname "$SCRIPT_DIR")")"
readonly UTILS_DIR="${PROJECT_DIR}/utils"

source "${UTILS_DIR}/logger.sh"

# Verifica se o sudo foi exportado pelo orquestrador
if [ -z "${SUDO:-}" ]; then
    if [ "${EUID:-$(id -u)}" -ne 0 ] && command -v sudo &>/dev/null; then
        SUDO="sudo"
    else
        SUDO=""
    fi
fi

log_step "1. Verificando e instalando dependências do sistema"
$SUDO apt-get update -qq

# Git
command -v git &>/dev/null && log_ok "git $(git --version | awk '{print $3}')" || {
    $SUDO apt-get install -y git; log_ok "git instalado"
}

# Curl
command -v curl &>/dev/null && log_ok "curl" || {
    $SUDO apt-get install -y curl; log_ok "curl instalado"
}

# Node.js 20+
NODE_REQUIRED=20
if command -v node &>/dev/null; then
    NODE_MAJOR=$(node --version | sed 's/v//' | cut -d. -f1)
    if [ "$NODE_MAJOR" -ge "$NODE_REQUIRED" ]; then
        log_ok "Node.js $(node --version)"
    else
        log_info "Atualizando Node.js para v$NODE_REQUIRED..."
        curl -fsSL "https://deb.nodesource.com/setup_${NODE_REQUIRED}.x" | $SUDO bash -
        $SUDO apt-get install -y nodejs
        log_ok "Node.js $(node --version)"
    fi
else
    log_info "Instalando Node.js $NODE_REQUIRED..."
    curl -fsSL "https://deb.nodesource.com/setup_${NODE_REQUIRED}.x" | $SUDO bash -
    $SUDO apt-get install -y nodejs
    log_ok "Node.js $(node --version)"
fi

# Python3 e pacotes críticos para Virtualenvs
command -v python3 &>/dev/null || $SUDO apt-get install -y python3
dpkg -l | grep -qw python3-pip || $SUDO apt-get install -y python3-pip
dpkg -l | grep -qw python3-venv || $SUDO apt-get install -y python3-venv
log_ok "Python3 $(python3 --version | awk '{print $2}') com pip e venv instalados"

# Java 21 (necessário para Certora Prover)
command -v java &>/dev/null && log_ok "Java" || {
    log_warn "Java nao encontrado — instale manualmente: sudo apt-get install -y openjdk-21-jdk"
}

log_ok "Módulo 01_os_deps.sh concluído."
