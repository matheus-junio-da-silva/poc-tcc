#!/usr/bin/env python3
import json
import sys
import os

def extract_context(slither_json_path, output_path, vulnerability_type):
    if not os.path.exists(slither_json_path):
        print(f"Erro: {slither_json_path} não encontrado.")
        sys.exit(1)

    with open(slither_json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)

    printers = data.get('results', {}).get('printers', [])
    
    extracted = {
        "vulnerability_focus": vulnerability_type,
        "printers_raw": {}
    }

    for p in printers:
        printer_name = p.get('printer')
        description = p.get('description', '')
        extracted["printers_raw"][printer_name] = description

    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(extracted, f, indent=2, ensure_ascii=False)
    
    print(f"Contexto bruto extraído em: {output_path}")

if __name__ == "__main__":
    if len(sys.argv) < 4:
        print(f"Uso: {sys.argv[0]} <caminho_slither_full.json> <caminho_output.json> <tipo_vulnerabilidade>")
        sys.exit(1)
    
    extract_context(sys.argv[1], sys.argv[2], sys.argv[3])
