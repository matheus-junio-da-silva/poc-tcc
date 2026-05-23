#!/usr/bin/env bash
# =============================================================================
# install_slither.sh
# Instala Slither e Certora CLI via pip em um venv isolado
# Instala tambem solc-select para gerenciar as versoes do Solidity
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
VENV_DIR="$PROJECT_DIR/certora_venv"

echo "=== Instalando Slither + Certora CLI ==="

if [ ! -d "$VENV_DIR" ]; then
    echo "Criando virtualenv em $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
fi

# Ativa o virtualenv
source "$VENV_DIR/bin/activate"

# Instala Slither e dependências essenciais (solc-select para gerenciar solc)
echo "Instalando certora-cli, slither-analyzer e solc-select via pip..."
pip install --upgrade pip
pip install certora-cli slither-analyzer solc-select

echo "Verificando instalacao:"
slither --version
certoraRun --version || true

# Configura o solc-select com a versão 0.8.20 como padrão inicial
echo "Instalando versão padrao do solc (0.8.20)..."
solc-select install 0.8.20 || true
solc-select use 0.8.20 || true

echo "=== Instalacao concluida ==="
echo "Para usar manualmente, ative o ambiente: source certora_venv/bin/activate"
