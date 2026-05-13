# 📋 GUIA RÁPIDO - CERTORA SETUP COMPLETO ✓

> **Última atualização:** 12 de Maio de 2026
> **Status:** ✓ Instalação Completa e Testada

## 🎯 Para Usar o Certora AGORA:

```bash
# 1. Abra terminal e navegue até o diretório
cd /home/mat/poc1novo/poc-tcc

# 2. Ative o environment (escolha um):

# Opção A: Usar script (recomendado)
source activate_certora.sh

# OU Opção B: Ativação manual
source certora_venv/bin/activate

# 3. Pronto! Você pode usar:
certoraRun --help
cd certora_tests
solcjs --version
```

---

## 📚 DOCUMENTOS PRINCIPAIS

| Documento | Propósito | Tamanho |
|-----------|-----------|--------|
| **CERTORA_SETUP.md** | Guia completo passo-a-passo com explicações | 6.8 KB |
| **CERTORA_README.md** | Visão geral e índice de recursos | 5.4 KB |
| **certora_tests/CERTORA_TEST_REPORT.md** | Relatório de testes com resultados | 5.1 KB |
| **activate_certora.sh** | Script para ativar ambiente facilmente | 1.3 KB |

## 🛠️ PASSOS DE INSTALAÇÃO (RESUMIDO)

Se você precisar reinstalar ou configurar em outro computador:

```bash
# 1️⃣  Instalar pacote de venv do sistema
sudo apt install -y python3.12-venv

# 2️⃣  Criar virtual environment
python3 -m venv certora_venv

# 3️⃣  Ativar environment
source certora_venv/bin/activate

# 4️⃣  Instalar Certora CLI
pip install certora-cli

# 5️⃣  Instalar compilador Solidity
npm install -g solc

# 6️⃣  Pronto para usar!
certoraRun --help
```

## ✅ VERIFICAÇÃO DE INSTALAÇÃO

Execute para confirmar que tudo está funcionando:

```bash
# Ativar environment primeiro
source certora_venv/bin/activate

# Verificar versões
echo "Python:" && python3 --version
echo "Certora:" && pip list | grep certora
echo "Node.js:" && node --version
echo "Solidity:" && solcjs --version
echo "✓ Tudo funcionando!"
```

## 🧪 TESTAR COM CONTRATOS

```bash
# Navegue para testes
cd certora_tests

# Liste arquivos
ls -la

# Compile um contrato
solcjs SimpleSuicideModern.sol --bin --abi -o ./output

# Veja o resultado
ls output/
cat output/*.abi
```

## 📁 ESTRUTURA DE ARQUIVOS

```
poc-tcc/                            
├── 📄 CERTORA_SETUP.md             ← Leia primeiro para instalação
├── 📄 CERTORA_README.md            ← Visão geral completa
├── 🔧 activate_certora.sh          ← Execute: source activate_certora.sh
│
├── 📁 certora_venv/                ← Virtual environment (automático)
│   └── bin/
│       ├── python                  
│       ├── pip                     
│       └── activate               
│
├── 📁 certora_tests/               ← Seus testes e contratos
│   ├── 📄 CERTORA_TEST_REPORT.md   ← Resultados de testes ✓
│   ├── 📝 simple_suicide.sol       
│   ├── 📝 SimpleSuicide.spec       
│   ├── ⚙️ SimpleSuicide.conf       
│   ├── 📝 mycontract.sol           
│   ├── 📝 MyContract.spec          
│   ├── ⚙️ MyContract.conf          
│   ├── 📝 SimpleSuicideModern.sol  ← Compilado com sucesso ✓
│   └── 📁 output/                  ← Arquivos compilados
│       ├── *.abi
│       └── *.bin
│
└── 📁 detasets/                    ← Dataset original
    └── smartbugs-curated/
        └── dataset/
            └── (todos os contratos)
```

## 🔑 COMANDOS IMPORTANTES

```bash
# Ativar/Desativar
source certora_venv/bin/activate    # Ativar
deactivate                          # Desativar

# Gerenciar pacotes
pip list                            # Ver pacotes instalados
pip install <pacote>               # Instalar novo pacote
pip upgrade <pacote>               # Atualizar pacote

# Certora
certoraRun --help                   # Ver todas as opções
certoraRun arquivo.conf             # Executar verificação

# Solidity
solcjs --version                    # Ver versão compilador
solcjs arquivo.sol --bin --abi      # Compilar contrato

# Utilitários
chmod +x script.sh                  # Tornar script executável
source script.sh                    # Executar script shell
```

## ⚠️ ERROS COMUNS E SOLUÇÕES

| Erro | Solução |
|------|---------|
| `command not found: certoraRun` | Execute: `source certora_venv/bin/activate` |
| `externally-managed-environment` | Use virtual environment: `python3 -m venv certora_venv` |
| `solcjs: command not found` | Instale: `npm install -g solc` |
| `No module named certora_cli` | Instale: `pip install certora-cli` |
| Erro de versão Solidity | Use `SimpleSuicideModern.sol` ou instale versão específica |

## 📞 SUPORTE RÁPIDO

**Problema:** Ambiente não funciona depois de reiniciar

**Solução:**
```bash
cd /home/mat/poc1novo/poc-tcc
source certora_venv/bin/activate
# Pronto!
```

**Problema:** Esqueceu qual versão do Certora está instalada

**Solução:**
```bash
source certora_venv/bin/activate
pip list | grep certora
```


## 📖 DOCUMENTAÇÃO EXTERNA

- **Certora Docs:** https://docs.certora.com
- **CVL Language:** https://docs.certora.com/en/latest/docs/cvl/
- **SmartBugs:** https://github.com/smartbugs/smartbugs-curated

---

## ✨ RESUMO

- ✓ Certora CLI 8.13.0 instalado
- ✓ Compilador Solidity (solcjs 0.8.35) instalado
- ✓ Virtual environment configurado
- ✓ Testes compilados com sucesso
- ✓ Documentação completa disponível
- ✓ Scripts de automação criados

**Você está pronto para usar Certora!**

Para começar: 
```bash
cd /home/mat/poc1novo/poc-tcc
source activate_certora.sh
```

---

*Documentação criada em: 12 de Maio de 2026*  
*Localização: `/home/mat/poc1novo/poc-tcc/`*
