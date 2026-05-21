# 06 — Configuração do Ambiente

> **Versão:** 1.0  
> **Data:** 2026-05-21  
> **Nota:** Este documento estava completamente ausente na proposta original. Sem ele, o agente falharia silenciosamente por falta de ferramentas ou variáveis de ambiente.

---

## 1. Ferramentas Obrigatórias

| Ferramenta | Versão Mínima | Finalidade | Verificação |
|-----------|---------------|-----------|-------------|
| Python | 3.9+ | Runtime do Slither e Certora CLI | `python3 --version` |
| Java (JDK) | 21+ | Certora Prover (solver SMT) | `java --version` |
| Slither | Mais recente | Análise estática (printers) | `slither --version` |
| Certora CLI | Mais recente | Envio de jobs ao Certora Cloud | `certoraRun --version` |
| solc-select | Mais recente | Gerenciamento de versões do solc | `solc-select --help` |
| solc | Compatível com pragma | Compilador Solidity | `solc --version` |

### Ferramentas Opcionais (para PoC)

| Ferramenta | Finalidade | Verificação |
|-----------|-----------|-------------|
| Foundry (forge) | Execução de PoC em teste | `forge --version` |

---

## 2. Instalação

### 2.1 Slither

```bash
pip3 install slither-analyzer
```

Ou usando uv (mais rápido):
```bash
uv tool install slither-analyzer
```

### 2.2 Certora CLI

```bash
pip3 install certora-cli
```

> **Atenção:** O terminal pode avisar que o executável `certoraRun` foi instalado fora do `PATH`. Adicione esse caminho ao `PATH` se necessário.

### 2.3 solc-select

```bash
pip3 install solc-select

# Instalar uma versão específica
solc-select install 0.8.20
solc-select use 0.8.20
```

### 2.4 Java JDK

```bash
# Ubuntu/Debian
sudo apt install openjdk-21-jdk

# macOS
brew install openjdk@21
```

### 2.5 Foundry (opcional, para PoC)

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

---

## 3. Chave de Acesso Certora (CERTORAKEY)

O Certora Prover exige uma chave pessoal gratuita.

### Obter a chave

Registre-se em: https://www.certora.com/signup?plan=prover

### Configuração temporária (válida até fechar o terminal)

```bash
export CERTORAKEY=<sua_chave_aqui>
```

### Configuração permanente

**Linux (bash):**
```bash
echo 'export CERTORAKEY=<sua_chave_aqui>' >> ~/.profile
source ~/.profile
```

**Linux (zsh) / macOS:**
```bash
echo 'export CERTORAKEY=<sua_chave_aqui>' >> ~/.zshenv
source ~/.zshenv
```

### Verificar que a chave está configurada

```bash
# Deve imprimir os primeiros caracteres da chave
echo $CERTORAKEY | head -c 8
```

> **CRÍTICO:** Se `CERTORAKEY` não estiver configurada, `certoraRun` falhará silenciosamente ou com erro genérico. Isso é a causa #1 de falhas não diagnosticadas.

---

## 4. Configuração do Projeto Alvo

### Para projetos Hardhat

```bash
cd {project_path}
npm install  # instalar dependências (OpenZeppelin, etc.)
```

Verificar que compila:
```bash
npx hardhat compile
```

### Para projetos Foundry

```bash
cd {project_path}
forge install  # instalar dependências
```

Verificar que compila:
```bash
forge build
```

### Para arquivo standalone (sem framework)

Não é necessário instalar dependências, mas o arquivo não pode ter imports externos. Se tiver:
- Flatten com `slither-flat`: `slither-flat {arquivo.sol}`
- Ou instalar as dependências manualmente

---

## 5. Script de Verificação do Ambiente

O orquestrador pode executar este script no início de cada execução:

```bash
#!/bin/bash
# verify-environment.sh

echo "=== Verificação do Ambiente ==="

# Python
echo -n "Python: "
python3 --version 2>/dev/null || echo "NÃO ENCONTRADO"

# Java
echo -n "Java: "
java --version 2>/dev/null | head -1 || echo "NÃO ENCONTRADO"

# Slither
echo -n "Slither: "
slither --version 2>/dev/null || echo "NÃO ENCONTRADO"

# Certora CLI
echo -n "Certora CLI: "
certoraRun --version 2>/dev/null || echo "NÃO ENCONTRADO"

# solc
echo -n "solc: "
solc --version 2>/dev/null | grep "Version:" || echo "NÃO ENCONTRADO"

# solc-select
echo -n "solc-select: "
which solc-select >/dev/null 2>&1 && echo "OK" || echo "NÃO ENCONTRADO"

# CERTORAKEY
echo -n "CERTORAKEY: "
if [ -z "$CERTORAKEY" ]; then
    echo "NÃO CONFIGURADA — BLOQUEANTE"
else
    echo "OK ($(echo $CERTORAKEY | head -c 4)...)"
fi

# Forge (opcional)
echo -n "Forge: "
forge --version 2>/dev/null | head -1 || echo "não encontrado (opcional)"

echo "=== Fim da Verificação ==="
```

---

## 6. Versões do solc por Pragma

O agente deve detectar a versão do pragma no contrato e configurar o solc correspondente:

| Pragma | Comando | Valor no `.conf` |
|--------|---------|-------------------|
| `pragma solidity ^0.8.20;` | `solc-select use 0.8.20` | `"solc": "solc0.8.20"` |
| `pragma solidity >=0.8.0 <0.9.0;` | `solc-select use 0.8.0` | `"solc": "solc0.8.0"` |
| `pragma solidity 0.8.23;` | `solc-select use 0.8.23` | `"solc": "solc0.8.23"` |
| `pragma solidity ^0.7.6;` | `solc-select use 0.7.6` | `"solc": "solc0.7.6"` |

### Extrair versão do pragma automaticamente

```bash
grep -oP 'pragma solidity \^?\K[0-9]+\.[0-9]+\.[0-9]+' {contrato.sol} | head -1
```

---

## 7. Troubleshooting Comum

| Problema | Causa | Solução |
|----------|-------|---------|
| `certoraRun: command not found` | Não está no PATH | `pip3 show certora-cli` para ver onde instalou, adicionar ao PATH |
| `CERTORAKEY is not set` | Variável de ambiente ausente | `export CERTORAKEY=<chave>` |
| `solc not found` | solc não instalado | `solc-select install {versão} && solc-select use {versão}` |
| `Source not found: @openzeppelin/...` | Dependências não instaladas | `npm install` ou `forge install` |
| Slither: `Compilation failed` | Versão do solc incompatível | `solc-select use {versão_correta}` |
| Certora: `Java not found` | JDK não instalado | `sudo apt install openjdk-21-jdk` |
| Certora: `timeout` no terminal | Job muito longo | Normal para specs complexos — aguardar ou verificar no dashboard |
