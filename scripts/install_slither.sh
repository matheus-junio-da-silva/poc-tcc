#!/usr/bin/env bash
# =============================================================================
# install_slither.sh
# Instala o Slither via pip para manter a licença do projeto isolada
# Instala também solc-select para gerenciar as versões do Solidity
# =============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
VENV_DIR="$PROJECT_DIR/certora_venv"

echo "=== Instalando Slither ==="

if [ ! -d "$VENV_DIR" ]; then
    echo "Criando virtualenv em $VENV_DIR..."
    python3 -m venv "$VENV_DIR"
fi

# Ativa o virtualenv
source "$VENV_DIR/bin/activate"

# Instala Slither e dependências essenciais (solc-select para gerenciar solc)
echo "Instalando slither-analyzer e solc-select via pip..."
pip install --upgrade pip
pip install slither-analyzer solc-select

echo "Verificando instalação:"
slither --version

# Configura o solc-select com a versão 0.8.20 como padrão inicial
echo "Instalando versão padrao do solc (0.8.20)..."
solc-select install 0.8.20 || true
solc-select use 0.8.20 || true

echo "=== Instalação do Slither concluída ==="
echo "Para usar manualmente, ative o ambiente: source certora_venv/bin/activate"
