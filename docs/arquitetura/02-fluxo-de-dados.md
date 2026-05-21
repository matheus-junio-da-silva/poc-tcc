# 02 — Fluxo de Dados Entre Agentes

> **Versão:** 1.0  
> **Data:** 2026-05-21  
> **Correção aplicada:** Documentação do fluxo que estava ausente nos documentos originais

---

## 1. Diagrama do Fluxo Completo

```
USUÁRIO
  │
  │  Input: { project_path: "/path/to/project", vuln_types: ["access-control"] }
  │
  ▼
┌─────────────────────────────────────────────────────────────────────────┐
│                        ORQUESTRADOR                                      │
│                                                                          │
│  1. find *.sol (validar que existem contratos)                           │
│  2. Identificar contrato principal, pragma, framework                    │
│                                                                          │
│  Para cada vuln_type:                                                    │
│  ┌─────────────────────────────────────────────────────────────────────┐ │
│  │ 3. Chamar SLITHER ENRICHER                                          │ │
│  │    Input:  { project_path, vuln_type, main_contract_file }          │ │
│  │    Output: slither_context (JSON ~30-80 linhas)                     │ │
│  └──────────────────────────────┬──────────────────────────────────────┘ │
│                                 │                                        │
│  ┌──────────────────────────────▼──────────────────────────────────────┐ │
│  │ 4. Chamar AGENTE DE VULNERABILIDADE                                 │ │
│  │    Input:  { project_path, main_contract_file, slither_context }    │ │
│  │    Output: relatório + PoC (se aplicável)                           │ │
│  └──────────────────────────────┬──────────────────────────────────────┘ │
│                                 │                                        │
│  5. Consolidar relatórios de todas as vuln_types                         │
│                                                                          │
│  Output final: relatório consolidado                                     │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 2. Dados Trocados em Cada Etapa

### 2.1 Usuário → Orquestrador

```json
{
  "project_path": "/home/user/my-token-project",
  "vuln_types": ["access-control"]
}
```

**Estimativa de tokens:** ~20 tokens

---

### 2.2 Orquestrador → Slither Enricher

```json
{
  "project_path": "/home/user/my-token-project",
  "vuln_type": "access-control",
  "main_contract_file": "contracts/MyToken.sol"
}
```

**Estimativa de tokens:** ~30 tokens

**O que NÃO enviar:**
- Código-fonte do contrato (Slither lê do disco)
- Documentos de guia (conhecimento já está no skill)

---

### 2.3 Slither Enricher → Orquestrador → Agente de Vulnerabilidade

```json
{
  "contracts": ["MyToken", "Ownable", "ERC20"],
  "main_contract": "MyToken",
  "pragma_version": "0.8.20",
  "framework": "hardhat",
  "functions": [
    {
      "name": "mint",
      "contract": "MyToken",
      "visibility": "public",
      "modifiers": ["onlyOwner"],
      "state_vars_written": ["_balances", "_totalSupply"],
      "msg_sender_checks": ["require(msg.sender == owner())"],
      "require_statements": ["require(amount > 0)"]
    },
    {
      "name": "transfer",
      "contract": "ERC20",
      "visibility": "public",
      "modifiers": [],
      "state_vars_written": ["_balances"],
      "msg_sender_checks": [],
      "require_statements": ["require(to != address(0))"]
    }
  ],
  "state_variables": [
    { "name": "_owner", "type": "address", "visibility": "private", "contract": "Ownable" },
    { "name": "_balances", "type": "mapping(address => uint256)", "visibility": "private", "contract": "ERC20" }
  ],
  "inheritance": {
    "MyToken": ["Ownable", "ERC20", "Pausable"]
  },
  "access_control_pattern": "ownable",
  "privileged_functions": ["mint", "burn", "pause", "unpause", "transferOwnership"],
  "entry_points": ["mint", "burn", "transfer", "approve", "pause", "unpause", "transferOwnership"]
}
```

**Estimativa de tokens:** ~200-500 tokens (varia com complexidade do contrato)

**Campos obrigatórios:**
- `contracts` — lista de contratos encontrados
- `main_contract` — contrato mais derivado
- `pragma_version` — para configurar solc
- `framework` — para saber como compilar
- `functions` — com visibilidade, modifiers e state vars
- `access_control_pattern` — ownable / rbac / custom / none
- `privileged_functions` — funções que alteram estado protegido

**Campo adicionado na revisão:**
- `entry_points` — extraído do printer `entry-points` do Slither (ausente na proposta original)
- `framework` — necessário para resolução de imports no `.conf`
- `main_contract` — distingue do contrato que herda

---

### 2.4 Agente de Vulnerabilidade → Orquestrador

O agente retorna:
1. **Relatório em markdown** (salvo em `certora_tests/reports/`)
2. **PoC em Solidity** (salvo em `certora_tests/poc/`, se FAIL)
3. **Resumo para consolidação** (inline no retorno):

```json
{
  "vuln_type": "access-control",
  "result": "VULNERABILITY_FOUND",
  "violations_count": 1,
  "violations": [
    {
      "rule": "onlyOwnerCanMint",
      "function": "mint",
      "severity": "Critical",
      "cwe": "CWE-284",
      "counterexample_sender": "0x000...DEAD",
      "poc_path": "certora_tests/poc/PoCAccessControl.sol"
    }
  ],
  "passed_rules": ["ownerNeverZero", "transferOwnershipOnlyOwner"],
  "inconclusive_rules": [],
  "certora_dashboard_url": "https://prover.certora.com/output/...",
  "report_path": "certora_tests/reports/access_control_report.md"
}
```

**Estimativa de tokens:** ~150-300 tokens

---

## 3. O que NÃO Passar Entre Agentes

| Dado | Por que NÃO passar | Alternativa |
|------|---------------------|-------------|
| Código-fonte `.sol` completo | 500+ linhas por contrato, ~2000+ tokens | slither_context (~200-500 tokens) |
| Saída raw do terminal Slither | Muito verboso, contém warnings irrelevantes | JSON estruturado pelo enricher |
| Documentos de guia (certora_cloud_run_guide, etc.) | 600+ linhas cada, ~3000+ tokens | Conhecimento já destilado no skill |
| Output de detectores do Slither | Falsos positivos, não é evidência formal | Certora é a única fonte de evidência |

**Economia estimada por execução:** ~5000-8000 tokens comparado com a abordagem de passar tudo

---

## 4. Arquivos Criados no Projeto Alvo

Ao final de uma execução completa, o agente cria esta estrutura:

```
{project_path}/
  contracts/                          ← NÃO MODIFICAR
    MyToken.sol
  certora_tests/                      ← criado pelos agentes
    specs/
      AccessControl.spec              ← propriedades CVL
    confs/
      AccessControl.conf              ← configuração do certoraRun
    poc/
      PoCAccessControl.sol            ← PoC Foundry (se FAIL)
    reports/
      access_control_report.md        ← relatório detalhado
```

O agente **nunca** modifica arquivos dentro de `contracts/`.

---

## 5. Fluxo de Iteração do Spec (detalhado)

```
┌───────────────────────────────────────────────────────┐
│ Agente cria AccessControl.spec + AccessControl.conf   │
└──────────────────────┬────────────────────────────────┘
                       │
                       ▼
┌───────────────────────────────────────────────────────┐
│ certoraRun ... --compilation_steps_only               │
│ (validação local de sintaxe/tipos)                    │
└──────────────────────┬────────────────────────────────┘
                       │
              ┌────────┴────────┐
              │                 │
        ┌─────▼─────┐   ┌──────▼──────┐
        │ ERRO       │   │ OK          │
        │            │   │             │
        │ tentativa  │   │ Prosseguir  │
        │ N/5?       │   │             │
        └─────┬──────┘   └──────┬──────┘
              │                 │
        ┌─────▼─────┐          │
        │ N < 5:    │          │
        │ corrigir  │──────────┘
        │ e repetir │
        └─────┬─────┘
              │ N = 5:
              ▼
        ┌────────────┐
        │ REPORTAR   │
        │ ERRO       │
        │ (não seguro│
        │ não inseguro│
        │ = erro)    │
        └────────────┘

                       ▼ (se OK)
┌───────────────────────────────────────────────────────┐
│ certoraRun ... --wait_for_results all                 │
│ (execução no Certora Cloud)                           │
└──────────────────────┬────────────────────────────────┘
                       │
        ┌──────────────┼──────────────┬──────────────┐
        │              │              │              │
   ┌────▼────┐  ┌──────▼─────┐ ┌─────▼─────┐ ┌─────▼─────┐
   │ FAIL    │  │ PASS       │ │ TIMEOUT   │ │ SANITY    │
   │         │  │            │ │           │ │           │
   │ Extrair │  │ Verificar  │ │ Reportar  │ │ Reescrever│
   │ CE →    │  │ vacuidade  │ │ como      │ │ regra     │
   │ PoC +   │  │ → relatório│ │INCONCLUSIVO│ │ vacua     │
   │relatório│  └────────────┘ └───────────┘ └───────────┘
   └─────────┘
```

CE = Contraexemplo
