#!/bin/bash

# Script para ativar o ambiente Certora facilmente
# Uso: source ./activate_certora.sh ou bash ./activate_certora.sh

PROJECT_ROOT="/home/mat/poc1novo/poc-tcc"
VENV_PATH="$PROJECT_ROOT/certora_venv"

# Cores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Verificar se o diretório do venv existe
if [ ! -d "$VENV_PATH" ]; then
    echo -e "${RED}✗ Erro: Virtual environment não encontrado em $VENV_PATH${NC}"
    echo "Execute primeiro: python3 -m venv certora_venv"
    exit 1
fi

# Ativar o virtual environment
echo -e "${YELLOW}Ativando Certora environment...${NC}"
source "$VENV_PATH/bin/activate"

# Verificar se a ativação foi bem-sucedida
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Certora environment ativado com sucesso!${NC}"
    echo ""
    echo "Versões instaladas:"
    echo "---"
    pip list | grep -E "(certora|solc)" || echo "  (packages not listed)"
    echo ""
    echo "Comandos disponíveis:"
    echo "  - certoraRun --help      : Ver opções do Certora"
    echo "  - cd certora_tests       : Ir para diretório de testes"
    echo "  - solcjs --version       : Ver versão do compilador"
    echo ""
    echo "Para desativar: deactivate"
else
    echo -e "${RED}✗ Erro ao ativar o environment${NC}"
    exit 1
fi
