# 07 — Extensibilidade: Adicionando Novas Vulnerabilidades

> **Versão:** 1.0  
> **Data:** 2026-05-21

---

## 1. Princípio de Design

A arquitetura segue um padrão de **agente-por-vulnerabilidade**: cada tipo de vulnerabilidade tem seu próprio agente com:
- Printers Slither específicos
- Templates CVL específicos
- Interpretação de counterexample específica
- Estrutura de PoC específica

O Slither Enricher é compartilhado — apenas a seleção de printers muda por `vuln_type`.

---

## 2. Checklist Para Adicionar Uma Nova Vulnerabilidade

### Passo 1 — Definir os Printers Slither

Determinar quais printers do Slither são relevantes para este tipo de vulnerabilidade:

| Pergunta | Se SIM → usar printer |
|----------|----------------------|
| Precisa saber quem pode chamar o quê? | `vars-and-auth`, `modifiers` |
| Precisa saber o fluxo de chamadas entre funções? | `call-graph` |
| Precisa saber quais operações aritméticas existem? | `slithir` |
| Precisa saber de onde vêm os valores das variáveis? | `data-dependency` |
| Precisa saber o control flow dentro de uma função? | `cfg` |
| Precisa saber os pontos de entrada? | `entry-points` |
| Precisa saber a estrutura de herança? | `inheritance` |
| Precisa saber quais requires existem? | `require` |
| Precisa saber o resumo das funções? | `function-summary` |

**Regra:** incluir apenas printers que fornecem informação acionável para criar propriedades CVL. Cada printer adicional aumenta o output e o consumo de tokens.

Adicionar a seleção no skill do Slither Enricher:

```markdown
### {vuln-type}
```bash
slither {contract_file} --print {printer1},{printer2} --json - 2>/dev/null
```
```

### Passo 2 — Criar o Skill do Agente

Criar o arquivo: `hermes-security-agents/{vuln-type}/skill.md`

Estrutura obrigatória:

```yaml
---
name: {vuln-type}-certora
description: >
  Cria propriedades CVL para {descrição da vulnerabilidade}, executa no Certora Prover,
  valida resultados, gera PoC e relatório.
---
```

Seções obrigatórias do skill:

| Seção | Conteúdo |
|-------|----------|
| **Regras Absolutas** | Mesmas 6 regras base (não inventar, não modificar contrato, etc.) |
| **Fase 1 — Análise** | Como interpretar o slither_context para esta vulnerabilidade |
| **Fase 2 — Spec** | Templates CVL específicos para esta vulnerabilidade |
| **Fase 3 — Execução** | Procedimento de compilação e execução (mesmo para todos) |
| **Fase 4 — Validação** | Como interpretar resultados (mesmo para todos) |
| **Fase 5A — PoC** | Template de PoC específico para esta vulnerabilidade |
| **Fase 5B — Relatório** | Template de relatório (CWE específico, formato de impacto) |
| **Armadilhas** | Erros CVL comuns para esta vulnerabilidade |
| **CANDIDATES/CONFIRMED/DEPRECATED** | Seções de auto-melhoria |

### Passo 3 — Definir Templates CVL

Cada vulnerabilidade precisa de templates CVL que capturem as propriedades relevantes:

| Vulnerabilidade | Tipo de Propriedade | Exemplo |
|-----------------|---------------------|---------|
| Access Control | "Se não reverteu, caller tinha permissão" | `assert !reverted => hasRole(...)` |
| Reentrancy | "Estado é atualizado ANTES de chamada externa" | Hooks em Sstore + ghost tracking |
| Overflow | "Resultado de operação está dentro dos limites" | `assert result <= max_uint256` |
| Flash Loan | "Saldo do contrato não diminui após operação" | `assert balanceAfter >= balanceBefore` |

### Passo 4 — Definir Interpretação de Counterexample

Cada vulnerabilidade tem um counterexample diferente:

| Vulnerabilidade | O que extrair do CE |
|-----------------|---------------------|
| Access Control | `msg.sender` não autorizado + função chamada |
| Reentrancy | Sequência de chamadas re-entrantes + valores |
| Overflow | Valores de input que causam overflow + resultado |

### Passo 5 — Definir CWE e Template de PoC

| Vulnerabilidade | CWE | Tipo de PoC |
|-----------------|-----|-------------|
| Access Control | CWE-284 (Improper Access Control) | `vm.prank(attacker)` |
| Reentrancy | CWE-841 (Improper Enforcement of Behavioral Workflow) | Contrato atacante com `receive()` |
| Integer Overflow | CWE-190 (Integer Overflow) | Chamada com valores extremos |

### Passo 6 — Adicionar Roteamento no Orquestrador

No skill do orquestrador, adicionar à tabela de roteamento:

```
| "{vuln-type}" | `{vuln-type}-certora` | ✅ Implementado |
```

---

## 3. Exemplo: Blueprint para Reentrancy Agent

> **Nota:** Este é um blueprint indicativo. As propriedades CVL devem ser validadas antes do uso.

### Printers Slither

```bash
slither . --print call-graph,function-summary,data-dependency,cfg,vars-and-auth \
  --exclude-dependencies --json slither_output.json 2>/dev/null
```

### Informações a Extrair do slither_context

```json
{
  "external_calls": [
    {
      "function": "withdraw",
      "external_call_target": "msg.sender",
      "call_type": "call",
      "state_written_after_call": ["_balances"],
      "reentrancy_guard": false
    }
  ],
  "modifiers_with_mutex": ["nonReentrant", "ReentrancyGuard"],
  "functions_with_value_transfer": ["withdraw", "emergencyWithdraw"]
}
```

### Propriedade CVL Core (Reentrancy)

```cvl
/// @title Estado atualizado antes de chamada externa
/// @notice Detecta padrão CEI violado (Checks-Effects-Interactions)
ghost bool externalCallMade;

hook CALL(uint g, address addr, uint value, uint argsOffset, 
          uint argsLength, uint retOffset, uint retLength) uint rc {
    externalCallMade = true;
}

rule noStateChangeAfterExternalCall(method f)
filtered { f -> !f.isView }
{
    env e;
    calldataarg args;
    
    // Reset ghost
    require !externalCallMade;
    
    f(e, args);
    
    // Se uma chamada externa foi feita E o estado mudou depois,
    // o padrão CEI pode estar violado
    // NOTA: esta é uma aproximação — verificar contra false positives
}
```

### CWE e PoC

- CWE: CWE-841
- PoC: contrato atacante com `receive()` que chama a função vulnerável recursivamente

---

## 4. Exemplo: Blueprint para Overflow Agent

### Printers Slither

```bash
slither . --print slithir,function-summary,data-dependency \
  --exclude-dependencies --json slither_output.json 2>/dev/null
```

### Propriedade CVL Core (Overflow)

```cvl
/// @title Operação aritmética não causa overflow
/// @notice Para Solidity >= 0.8.0, checked math é padrão
/// Esta regra é mais relevante para contratos com unchecked blocks
rule noOverflowInUncheckedBlock {
    env e;
    uint256 a;
    uint256 b;
    
    // Para funções que usam unchecked
    mathint result = a + b;
    
    assert result <= max_uint256,
        "Overflow detectado em operação aritmética";
}
```

> **Nota:** Para Solidity ≥ 0.8.0 com checked math ativado, o overflow causa revert automaticamente. As propriedades de overflow são mais relevantes para:
> 1. Blocos `unchecked { }`
> 2. Contratos em Solidity < 0.8.0
> 3. Operações de shift e cast que não são checked

---

## 5. Princípios Para Novos Agentes

1. **Cada agente deve ser independente.** Não deve depender de output de outro agente de vulnerabilidade.
2. **O enricher é compartilhado.** Apenas adicionar nova seleção de printers.
3. **O orquestrador é genérico.** Apenas adicionar nova entrada na tabela de roteamento.
4. **Templates CVL devem ser validados manualmente** em pelo menos 3 contratos reais antes de serem adicionados ao skill.
5. **CWE e severidade devem ser corretos.** Consultar a base CWE oficial (cwe.mitre.org).
6. **PoC deve ser reproduzível.** Incluir setup completo, não apenas a chamada.
