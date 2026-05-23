#!/usr/bin/env bash
# =============================================================================
# run_slither_printers.sh
# Roda os printers do Slither relevantes para Access Control
# e salva o output em formato JSON no diretório slither_output.
# =============================================================================

set -euo pipefail

if [ "$#" -lt 2 ]; then
    echo "Uso: $0 <caminho_para_contrato.sol> <tipo_vulnerabilidade> [solc_version]"
    echo "Exemplo: $0 detasets/meu_contrato.sol access_control 0.8.20"
    exit 1
fi

TARGET_FILE="$1"
VULN_TYPE="$2"
SOLC_VERSION="${3:-0.8.20}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
VENV_DIR="$PROJECT_DIR/certora_venv"

if [ ! -d "$VENV_DIR" ]; then
    echo "Erro: Ambiente virtual $VENV_DIR não encontrado. Instale o Slither primeiro."
    exit 1
fi

# Ativa o virtualenv para ter acesso ao slither
source "$VENV_DIR/bin/activate"

# Garantir a versão correta do solc
solc-select use "$SOLC_VERSION" || solc-select install "$SOLC_VERSION" && solc-select use "$SOLC_VERSION"

CONTRACT_BASENAME=$(basename "$TARGET_FILE" .sol)
OUTPUT_DIR="$PROJECT_DIR/slither_output/$CONTRACT_BASENAME"

mkdir -p "$OUTPUT_DIR"

echo "=== Executando Printers do Slither para $CONTRACT_BASENAME ==="

# Seleção de printers baseada na vulnerabilidade
if [ "$VULN_TYPE" == "access_control" ]; then
    PRINTERS="vars-and-auth,function-summary,modifiers,require,human-summary,inheritance"
elif [ "$VULN_TYPE" == "reentrancy" ]; then
    PRINTERS="call-graph,human-summary,cfg"
else
    echo "Vulnerabilidade não suportada: $VULN_TYPE. Usando printers padrão."
    PRINTERS="human-summary,inheritance"
fi

echo "Rodando Slither gerando output completo em JSON para $VULN_TYPE..."
slither "$TARGET_FILE" --print "$PRINTERS" --json "$OUTPUT_DIR/slither_full.json" > "$OUTPUT_DIR/slither_printers_output.txt" 2>&1 || true
# O Slither frequentemente retorna non-zero se acha vulnerabilidades, por isso `|| true` acima

if [ ! -f "$OUTPUT_DIR/slither_full.json" ]; then
    echo "ERRO: O arquivo slither_full.json não foi gerado."
    echo "Isso geralmente indica um erro de compilação ou sintaxe no contrato Solidity."
    echo "Verifique o log de erros em $OUTPUT_DIR/slither_printers_output.txt"
    exit 1
fi

echo "Output gerado com sucesso em $OUTPUT_DIR/"
ls -lh "$OUTPUT_DIR/"
