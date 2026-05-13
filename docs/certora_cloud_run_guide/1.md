# Certora Cloud — Guia Completo de Uso via CLI

> **Fonte:** documentação oficial em [docs.certora.com](https://docs.certora.com)  
> Apenas informações verificadas nas fontes oficiais foram incluídas.

---

## Índice

1. [Pré-requisitos e Instalação](#1-pré-requisitos-e-instalação)
2. [Configurando a Chave de Acesso](#2-configurando-a-chave-de-acesso)
3. [Comandos Básicos](#3-comandos-básicos)
4. [O Problema do Terminal Silencioso — `--wait_for_results`](#4-o-problema-do-terminal-silencioso----wait_for_results)
5. [Opções CLI Mais Importantes](#5-opções-cli-mais-importantes)
6. [Arquivos de Configuração `.conf`](#6-arquivos-de-configuração-conf)
7. [Verificando o Status e os Resultados](#7-verificando-o-status-e-os-resultados)
8. [Erros Comuns e Como Diagnosticá-los](#8-erros-comuns-e-como-diagnosticá-los)
9. [Dicas de Fluxo de Trabalho](#9-dicas-de-fluxo-de-trabalho)
10. [Referência Rápida](#10-referência-rápida)

---

## 1. Pré-requisitos e Instalação

### Dependências obrigatórias

| Dependência | Versão mínima | Verificação |
|---|---|---|
| Python | 3.9+ | `python3 --version` |
| Java (JDK) | 21+ | `java --version` |
| Solidity compiler (`solc`) | 0.5+ (idealmente) | `solc --version` |

### Instalar o Certora CLI

```bash
pip3 install certora-cli
```

> **Atenção:** o terminal pode avisar que o executável `certoraRun` foi instalado em um caminho fora do `PATH`. Adicione esse caminho ao seu `PATH` para evitar erros.

#### Instalar versão beta (opcional)

```bash
pip uninstall certora-cli
pip install certora-cli-beta
```

Para alternar entre versões usando `virtualenv`:

```bash
pip install virtualenv
virtualenv certora-beta
source certora-beta/bin/activate
pip3 install certora-cli-beta
# Para voltar ao padrão: deactivate
```

### Instalar o compilador Solidity via `solc-select` (recomendado)

```bash
pip install solc-select
solc-select install 0.8.23
solc-select use 0.8.23
```

---

## 2. Configurando a Chave de Acesso

O Certora Prover exige uma chave pessoal de acesso. Você pode obter uma gratuitamente registrando-se em [certora.com/signup](https://www.certora.com/signup?plan=prover).

### Configuração temporária (válida até fechar o terminal)

```bash
export CERTORAKEY=<sua_chave_aqui>
```

### Configuração permanente

**macOS:**

```bash
cd ~
nano .zshenv
# Adicione a linha:
export CERTORAKEY=<sua_chave_aqui>
# Salve (ctrl+x no nano) e aplique:
source .zshenv
```

**Linux:**

```bash
cd ~
nano .profile
# Adicione a linha:
export CERTORAKEY=<sua_chave_aqui>
# Salve (ctrl+x) e aplique:
source .profile
```

---

## 3. Comandos Básicos

### Forma geral

```bash
certoraRun contractFile:contractName --verify contractName:specFile
```

### Forma simplificada (quando o arquivo se chama `ContractName.sol`)

```bash
certoraRun ContractName.sol --verify ContractName:ContractName.spec
```

### Ajuda

```bash
certoraRun --help
```

### Exemplo prático

```bash
certoraRun Bank.sol --verify Bank:Bank.spec
```

Este comando:
1. Invoca o compilador Solidity localmente
2. Envia o job de verificação para os servidores da Certora
3. Por padrão (**modo `send_only`**), retorna imediatamente com um link para o dashboard

---

## 4. O Problema do Terminal Silencioso — `--wait_for_results`

### Por que o terminal não mostra os resultados?

A partir de uma versão recente do `certora-cli`, **o modo padrão é `send_only`**: o job é enviado para a nuvem e o comando retorna imediatamente, sem aguardar o resultado. O terminal mostrará apenas algo como:

```
Job submitted to server
Follow your job at https://prover.certora.com
Once the job is completed, the results will be available at https://prover.certora.com/output/...
```

Isso significa que, sem `--wait_for_results`, você **não verá** se as propriedades passaram, falharam ou deram erro — apenas um link para o dashboard.

### A solução: `--wait_for_results all`

Para que o terminal aguarde e imprima o resultado completo (incluindo violações de regras, erros de propriedades, etc.):

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --wait_for_results all
```

Com esse flag, a saída ao final será similar a:

```
Finished verification request
ERROR: Prover found violations:
[rule] transferSpec: FAIL
report url: https://prover.certora.com/output/...
```

Ou, se tudo passou:

```
Finished verification request
All rules passed.
report url: https://prover.certora.com/output/...
```

### Valores possíveis de `--wait_for_results`

| Valor | Comportamento |
|---|---|
| `all` | Aguarda a conclusão do job e exibe log + resultados no terminal |
| `none` | Envia o job e retorna imediatamente (sem aguardar). Em ambientes de CI, **força** esse comportamento mesmo que o CI normalmente aguardaria |

> **Nota sobre CI:** em ambientes de CI (ex: GitHub Actions), o comportamento padrão é diferente do uso local — o Prover já aguarda os resultados por padrão e o código de retorno é diferente de zero se houver violação. Use `--wait_for_results none` para forçar o envio sem espera mesmo em CI.

### No arquivo `.conf`

```json
{
  "files": ["Bank.sol"],
  "verify": "Bank:Bank.spec",
  "wait_for_results": "all"
}
```

---

## 5. Opções CLI Mais Importantes

### `--verify` — obrigatório para verificação

```bash
certoraRun Bank.sol --verify Bank:Bank.spec
```

### `--msg` — adicionar mensagem ao job (recomendado)

Aparece no título do e-mail de conclusão e facilita rastrear múltiplas execuções no dashboard.

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --msg 'Corrigindo regra de saldo'
```

### `--rule` — verificar somente regras específicas

Muito útil para iterar rapidamente em uma regra específica sem rodar o spec inteiro.

```bash
# Verificar somente a regra 'withdraw_succeeds'
certoraRun Bank.sol --verify Bank:Bank.spec --rule withdraw_succeeds

# Verificar múltiplas regras
certoraRun Bank.sol --verify Bank:Bank.spec --rule withdraw_succeeds withdraw_fails

# Usando wildcard
certoraRun Bank.sol --verify Bank:Bank.spec --rule withdraw*
```

### `--exclude_rule` — excluir regras específicas

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --exclude_rule "withdraw*"
```

### `--solc` — especificar o compilador Solidity

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --solc solc8.23
```

### `--global_timeout` — timeout máximo em segundos

O Prover tem um limite máximo de **2 horas (7200 segundos)**. Valores acima são ignorados. Jobs que excedem o timeout são encerrados e os relatórios podem não ser gerados.

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --global_timeout 3600
```

> **Diferença importante:** `--global_timeout` limita o tempo total do job (inclui análise estática e pré-processamento). `--smt_timeout` limita o tempo por regra individual.

### `--smt_timeout` — timeout por regra (em segundos)

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --smt_timeout 300
```

### `--rule_sanity` — checar sanidade das regras

```bash
# Verificação básica de sanidade
certoraRun Bank.sol --verify Bank:Bank.spec --rule_sanity basic
```

### `--split_rules` — rodar regras pesadas em jobs separados

Útil quando algumas regras demoram muito mais que as outras. Cada regra correspondente recebe um job dedicado com mais recursos.

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --split_rules heavy_rule1 heavy_rule2
```

Após o lançamento dos jobs, o terminal retorna um link para o dashboard com o status de todos os jobs gerados.

### `--compilation_steps_only` — compilar sem enviar para a nuvem

Para verificar erros de sintaxe e compilação localmente sem consumir tempo de verificação na nuvem.

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --compilation_steps_only
```

### `--loop_iter` — número de iterações de loops

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --loop_iter 3
```

### `--optimistic_loop` — ignorar falhas de loop unwind

Use quando você está recebendo um counterexample rotulado como "loop unwind condition".

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --loop_iter 3 --optimistic_loop
```

### `--max_concurrent_rules` — controlar paralelismo

Reduz o número de regras executadas simultaneamente. Pode ajudar com erros de falta de memória em jobs grandes.

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --max_concurrent_rules 4
```

### `--url_visibility` — controlar visibilidade da URL do relatório

```bash
# Tornar o relatório publicamente acessível (útil para compartilhar)
certoraRun Bank.sol --verify Bank:Bank.spec --url_visibility public

# Restringir o acesso (recomendado para CI)
certoraRun Bank.sol --verify Bank:Bank.spec --url_visibility private
```

---

## 6. Arquivos de Configuração `.conf`

Para projetos maiores, o comando de linha se torna longo e difícil de gerenciar. Os arquivos `.conf` são o formato recomendado.

### Estrutura básica

São arquivos **JSON5** (suportam comentários):

```json
{
  "files": ["contracts/Bank.sol"],
  "verify": "Bank:certora/specs/Bank.spec",
  "solc": "solc8.23",
  "wait_for_results": "all",
  "msg": "Verificação principal do Bank"
}
```

### Como usar

```bash
certoraRun meu_projeto.conf
```

### Mapeamento: CLI → `.conf`

| CLI | `.conf` |
|---|---|
| `--verify Bank:Bank.spec` | `"verify": "Bank:Bank.spec"` |
| `--solc solc8.23` | `"solc": "solc8.23"` |
| `--rule withdraw_succeeds` | `"rule": ["withdraw_succeeds"]` |
| `--loop_iter 3` | `"loop_iter": "3"` |
| `--multi_assert_check` (flag booleano) | `"multi_assert_check": true` |
| `--wait_for_results all` | `"wait_for_results": "all"` |

### Arquivo `.conf` gerado automaticamente

Após cada execução bem-sucedida de `certoraRun`, um arquivo `.conf` é gerado em:

```
.certora_internal/latest/run.conf
```

Você pode usar esse arquivo como base para criar seu próprio `.conf`.

### Exemplo completo de `.conf`

```json
{
  "files": [
    "contracts/Bank.sol",
    "contracts/Token.sol"
  ],
  "verify": "Bank:certora/specs/Bank.spec",
  "solc": "solc8.23",
  "loop_iter": "3",
  "optimistic_loop": true,
  "rule_sanity": "basic",
  "wait_for_results": "all",
  "msg": "Verificação completa do Bank v2"
}
```

### Passar flags adicionais via CLI sobre um `.conf`

Você pode sobrescrever ou adicionar parâmetros diretamente na linha de comando:

```bash
# Rodar o conf, mas verificar apenas uma regra específica
certoraRun Bank.conf --rule withdraw_succeeds

# Rodar o conf, mas com uma mensagem diferente
certoraRun Bank.conf --msg "Debug da regra de saque"
```

---

## 7. Verificando o Status e os Resultados

### Via terminal (com `--wait_for_results all`)

O modo mais direto. Com esse flag, o terminal exibe:

- Log da execução em tempo real
- Status final de cada regra (`PASS` / `FAIL` / `TIMEOUT`)
- URL do relatório completo

**Exemplo de saída com violação:**

```
Finished verification request
ERROR: Prover found violations:
[rule] transferSpec: FAIL
report url: https://prover.certora.com/output/<id>/...
```

**Exemplo de saída sem violação:**

```
Finished verification request
All rules passed.
report url: https://prover.certora.com/output/<id>/...
```

### Via dashboard (sem `--wait_for_results`)

Acesse [https://prover.certora.com](https://prover.certora.com) e selecione o job na lista de execuções recentes. O dashboard mostra:

- Status por regra (verde = passou, vermelho = falhou, amarelo = timeout)
- Counterexamples detalhados para regras que falharam
- Call trace
- Tab de notificações do Prover

### Usando `--msg` para encontrar seu job no dashboard

Sempre use `--msg` para identificar facilmente seus jobs:

```bash
certoraRun Bank.conf --msg "PR #42 - fix saldo negativo"
```

A mensagem aparece como título no dashboard e no e-mail de conclusão.

---

## 8. Erros Comuns e Como Diagnosticá-los

### "Job sent but no results in terminal"

**Causa:** o modo padrão é `send_only`.  
**Solução:** adicione `--wait_for_results all` ao comando ou ao `.conf`.

---

### Erros de sintaxe / tipo no spec (CVL)

O `certoraRun` realiza verificação local de sintaxe e tipo antes de enviar o job. Se houver erros, eles aparecerão no terminal **antes** do job ser enviado.

**Exemplo de erro típico:**

```
CRITICAL: [main] ERROR ALWAYS - certora/spec/Bank.spec:4:5: Syntax error: unexpected token near ID(transferFrom)
```

**Dica:** o flag `--compilation_steps_only` permite verificar erros de compilação localmente sem enviar para a nuvem.

> **Nota sobre `--disable_local_type_checking`:** esse flag desabilita a verificação local de sintaxe/tipo. Erros só serão visíveis durante a execução na nuvem, causando atrasos. **Evite usar esse flag** — ele é fortemente desaconselhado pela documentação oficial.

---

### "Loop unwind condition" como counterexample

**Causa:** o Prover encontrou um caso onde o loop não termina no número definido de iterações.  
**Solução:** use `--optimistic_loop` junto com `--loop_iter`:

```bash
certoraRun Bank.sol --verify Bank:Bank.spec --loop_iter 3 --optimistic_loop
```

---

### Timeout de regras

**Sintomas:** regras com resultado `TIMEOUT` no dashboard.

**Possíveis soluções:**
- Diminuir o escopo: use `--rule` para verificar uma regra por vez
- Aumentar `--smt_timeout` para dar mais tempo por regra
- Usar `--split_rules` para dar recursos dedicados a regras pesadas
- Reduzir `--max_concurrent_rules` para diminuir concorrência e uso de memória
- Usar `--loop_iter` com valor menor se houver loops

---

### Erro de tipo com inteiros no CVL

**Causa:** CVL 2 é mais rigoroso com conversão de tipos numéricos.  
**Dica da documentação:** tente usar `mathint` para a maioria das variáveis de inteiro. Use tipos específicos (`uint256`, etc.) apenas para argumentos passados diretamente a funções do contrato.

---

### "0 rules provided in the spec"

**Causa:** o spec não contém nenhuma regra válida ou todas foram filtradas por `--rule` / `--exclude_rule`.  
**Solução:** verifique o spec e os filtros aplicados.

---

### Erros em `methods` block (CVL 2)

No CVL 2, entradas no bloco `methods` **devem** começar com `function` e terminar com `;`:

```cvl
// Correto (CVL 2)
methods {
    function transfer(address, uint256) external returns (bool) envfree;
}

// Incorreto (CVL 1 — não funciona mais)
methods {
    transfer(address, uint256) returns (bool) envfree
}
```

---

### Propriedades `envfree` falhando

Se uma função declarada como `envfree` no bloco `methods` depende do ambiente (`msg.sender`, `block.timestamp`, etc.), o Prover irá reportar falha. O problema aparece nas seções "Rules" e "Problems View" do dashboard.

---

## 9. Dicas de Fluxo de Trabalho

### Iteração rápida em uma regra

```bash
# Verificar apenas a regra que você está desenvolvendo
certoraRun Bank.conf --rule minha_nova_regra --wait_for_results all
```

### Validar sintaxe sem enviar para a nuvem

```bash
certoraRun Bank.conf --compilation_steps_only
```

### Adicionar mensagem sempre

Facilita rastrear jobs no dashboard, especialmente quando você roda vários ao mesmo tempo:

```bash
certoraRun Bank.conf --msg "fix regra de overflow" --wait_for_results all
```

### Reutilizar a configuração do último run

```bash
# O arquivo .conf do último run fica aqui:
cat .certora_internal/latest/run.conf
```

### Rodar spec completo com mensagem e aguardar resultados

```bash
certoraRun certora/confs/Bank.conf \
  --msg "verificação completa antes do merge" \
  --wait_for_results all
```

---

## 10. Referência Rápida

### Flags essenciais

```bash
# Estrutura mínima
certoraRun Contrato.sol --verify Contrato:Contrato.spec

# Com resultados no terminal (necessário para não depender do dashboard)
certoraRun Contrato.sol --verify Contrato:Contrato.spec --wait_for_results all

# Rodar via conf (recomendado para projetos reais)
certoraRun certora/confs/Contrato.conf --wait_for_results all

# Verificar só uma regra (iteração rápida)
certoraRun certora/confs/Contrato.conf --rule nome_da_regra --wait_for_results all

# Validar sintaxe localmente sem enviar para a nuvem
certoraRun certora/confs/Contrato.conf --compilation_steps_only
```

### Resumo dos flags de resultados

| Situação | Flag | Efeito |
|---|---|---|
| Quero ver resultados no terminal | `--wait_for_results all` | Aguarda e imprime tudo |
| Quero apenas enviar e ver no dashboard | (padrão, sem flag) | Retorna imediatamente com link |
| Ambiente CI, quero forçar envio rápido | `--wait_for_results none` | Retorna assim que o job é enviado |

### Links úteis

- Documentação oficial: [docs.certora.com](https://docs.certora.com)
- Dashboard: [prover.certora.com](https://prover.certora.com)
- Opções CLI completas: [docs.certora.com/en/latest/docs/prover/cli/options.html](https://docs.certora.com/en/latest/docs/prover/cli/options.html)
- Arquivos `.conf`: [docs.certora.com/en/latest/docs/prover/cli/conf-file-api.html](https://docs.certora.com/en/latest/docs/prover/cli/conf-file-api.html)
- Guia de instalação: [docs.certora.com/en/latest/docs/user-guide/install.html](https://docs.certora.com/en/latest/docs/user-guide/install.html)
- Configuração de CI: [docs.certora.com/en/latest/docs/user-guide/ci.html](https://docs.certora.com/en/latest/docs/user-guide/ci.html)