---
name: access-control-certora
description: Cria propriedades CVL para access control, executa no Certora Prover, valida resultados, gera PoC e relatório. Use quando o orchestrator enviar slither_context de um contrato Solidity para verificação de access control.
---

## REGRAS ABSOLUTAS (nunca violar)

1. NUNCA invente sintaxe CVL. Use apenas os padrões documentados neste skill.
2. NUNCA modifique o contrato original — apenas crie/edite o arquivo .spec e .conf.
3. NUNCA afirme que o contrato é seguro sem execução bem-sucedida do Certora.
4. NUNCA afirme vulnerabilidade sem o contraexemplo do Certora.
5. Sempre execute --compilation_steps_only ANTES de enviar para a nuvem.
6. Sempre use --wait_for_results all para receber resultado no terminal.

---

## FASE 1 — ANÁLISE DO slither_context

Receba o `slither_context` do orchestrator. Identifique:

**Padrão de access control:**
- `ownable`: há modifier `onlyOwner` ou variável `owner`/`_owner`
- `rbac`: há mapping `_roles`, funções `grantRole`/`revokeRole`/`hasRole`
- `custom`: checks diretos como `require(msg.sender == admin)`
- `none`: nenhuma proteção → vulnerabilidade óbvia (verifique antes de criar spec)

**Funções privilegiadas a verificar** (das `privileged_functions` do context):
- Prioridade máxima: mint, burn, upgradeTo, selfdestruct, transferOwnership, grantRole
- Prioridade alta: pause, unpause, setFee, withdraw, emergencyWithdraw
- Prioridade média: outras funções que escrevem state variables críticas

**Determine quais propriedades são aplicáveis** com base no padrão encontrado.
Não crie propriedades para funções que o slither_context mostra como view/pure — estas não alteram estado.

---

## FASE 2 — CRIAR O ARQUIVO .spec

### Estrutura de diretórios obrigatória

```
{project_path}/
  certora_tests/
    specs/
      AccessControl.spec      ← criar aqui
    confs/
      AccessControl.conf      ← criar aqui
```

Crie os diretórios se não existirem:
```bash
mkdir -p {project_path}/certora_tests/specs
mkdir -p {project_path}/certora_tests/confs
```

---

### CVL OBRIGATÓRIO — blocos e sintaxe (CVL 2)

#### Bloco methods

**Regra:** toda função declarada aqui DEVE começar com `function` e terminar com `;`

```cvl
methods {
    // envfree: não depende de msg.sender, block, etc.
    function owner() external returns (address) envfree;
    function hasRole(bytes32, address) external returns (bool) envfree;
    function getRoleAdmin(bytes32) external returns (bytes32) envfree;
    function paused() external returns (bool) envfree;

    // COM env (depende de msg.sender) — não declarar envfree
    // function mint(address, uint256) external returns (bool);
}
```

**ERRO COMUM:** declarar `envfree` para função que usa `msg.sender` internamente. Se a função verificar `msg.sender` para controle de acesso, NÃO declare `envfree`.

#### env e variáveis

```cvl
env e;
// campos disponíveis:
// e.msg.sender  — quem chamou
// e.msg.value   — ETH enviado
// e.block.timestamp
// e.block.number
// e.tx.origin
```

#### @withrevert e lastReverted

```cvl
// CORRETO — capture lastReverted IMEDIATAMENTE após @withrevert
someFunction@withrevert(e, arg1, arg2);
bool reverted = lastReverted;  // ← capture aqui
// qualquer chamada aqui sobrescreve lastReverted

// ERRADO — não chame outra função antes de ler lastReverted
someFunction@withrevert(e, arg);
bool p = isPaused();       // ← SOBRESCREVE lastReverted!
assert p => lastReverted;  // ← lastReverted errado
```

#### mathint vs uint256

Use `mathint` para variáveis de cálculo intermediário. Use `uint256` apenas para argumentos passados diretamente a funções do contrato.

```cvl
// CORRETO
mathint balanceBefore = balanceOf(account);

// Para chamar função
uint256 amount;
transfer(e, recipient, amount);
```

---

### PROPRIEDADES POR PADRÃO DE ACCESS CONTROL

#### Para padrão OWNABLE

```cvl
methods {
    function owner() external returns (address) envfree;
}

/// @title Somente owner pode chamar funções críticas
/// @notice Se a chamada não reverteu, o chamador é o owner
rule onlyOwnerCan_{FuncName} {
    address to;
    uint256 amount;
    env e;

    {funcName}@withrevert(e, to, amount);
    bool reverted = lastReverted;

    assert !reverted => e.msg.sender == owner(),
        "{funcName} executou com sucesso para um não-owner";
}

/// @title Owner nunca pode ser o endereço zero
invariant ownerNeverZero()
    owner() != 0;

/// @title transferOwnership reverte se chamador não é owner
rule transferOwnershipOnlyOwner {
    address newOwner;
    env e;

    transferOwnership@withrevert(e, newOwner);
    bool reverted = lastReverted;

    assert !reverted => e.msg.sender == owner(),
        "transferOwnership executou para não-owner";
}

/// @title Parametric: nenhuma função não-autorizada altera o owner
rule noUnauthorizedOwnerChange(method f)
filtered { f -> !f.isView }
{
    env e;
    calldataarg args;
    address ownerBefore = owner();

    f(e, args);

    address ownerAfter = owner();

    assert ownerBefore != ownerAfter =>
        (e.msg.sender == ownerBefore || e.msg.sender == ownerAfter),
        "owner foi alterado por endereço não autorizado";
}
```

#### Para padrão RBAC (AccessControl)

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
    function getRoleAdmin(bytes32 role) external returns (bytes32) envfree;
}

/// @title Somente detentor do role pode chamar função protegida
rule onlyRoleCanCall_{FuncName}(bytes32 requiredRole) {
    env e;
    // adaptar args para a assinatura real da função
    calldataarg args;

    {funcName}@withrevert(e, args);
    bool reverted = lastReverted;

    assert !reverted => hasRole(requiredRole, e.msg.sender),
        "{funcName} executou sem o role requerido";
}

/// @title grantRole só pode ser chamado pelo admin do role
rule grantRoleOnlyAdmin {
    bytes32 role;
    address account;
    env e;

    bytes32 adminRole = getRoleAdmin(role);

    grantRole@withrevert(e, role, account);
    bool reverted = lastReverted;

    assert !reverted => hasRole(adminRole, e.msg.sender),
        "grantRole executou sem ser admin do role";
}

/// @title revokeRole só pode ser chamado pelo admin do role
rule revokeRoleOnlyAdmin {
    bytes32 role;
    address account;
    env e;

    bytes32 adminRole = getRoleAdmin(role);

    revokeRole@withrevert(e, role, account);
    bool reverted = lastReverted;

    assert !reverted => hasRole(adminRole, e.msg.sender),
        "revokeRole executou sem ser admin do role";
}

/// @title renounceRole só afeta o próprio chamador
rule renounceRoleOnlyForSelf {
    bytes32 role;
    address account;
    env e;

    renounceRole@withrevert(e, role, account);
    bool reverted = lastReverted;

    assert !reverted => account == e.msg.sender,
        "renounceRole executou para account diferente do msg.sender";
}

/// @title Invariant: DEFAULT_ADMIN_ROLE nunca é endereço zero
invariant adminRoleNeverZero(bytes32 role)
    getRoleAdmin(role) != to_bytes32(0);

/// @title grantRole não afeta outros pares (role, account)
rule grantRoleIsolation {
    bytes32 role;
    address account;
    bytes32 otherRole;
    address otherAccount;
    env e;

    require otherRole != role || otherAccount != account;
    bool hasOtherBefore = hasRole(otherRole, otherAccount);

    grantRole(e, role, account);

    bool hasOtherAfter = hasRole(otherRole, otherAccount);

    assert hasOtherAfter == hasOtherBefore,
        "grantRole afetou par (role, account) diferente";
}
```

#### Para padrão CUSTOM (require inline)

```cvl
methods {
    function admin() external returns (address) envfree;
    // adapte para a variável de controle de acesso real do contrato
}

/// @title Somente admin pode chamar função crítica
rule onlyAdminCan_{FuncName} {
    env e;
    calldataarg args;

    {funcName}@withrevert(e, args);
    bool reverted = lastReverted;

    assert !reverted => e.msg.sender == admin(),
        "{funcName} executou para não-admin";
}
```

#### Para padrão NONE (sem access control)

```cvl
/// @title Qualquer endereço pode chamar função crítica — verificar se intencional
rule anyoneCanCall_{FuncName} {
    env e1;
    env e2;
    calldataarg args;

    // Verificar que dois callers diferentes produzem o mesmo resultado
    // (esta regra deve FALHAR se a função não tem controle de acesso)
    require e1.msg.sender != e2.msg.sender;

    {funcName}@withrevert(e1, args);
    bool reverted1 = lastReverted;

    {funcName}@withrevert(e2, args);
    bool reverted2 = lastReverted;

    // Se ambas não revertem, o controle de acesso está ausente
    assert reverted1 || reverted2,
        "{funcName} não tem controle de acesso — qualquer chamador pode executar";
}
```

---

### ARQUIVO .conf OBRIGATÓRIO

```json
{
    "files": ["{caminho/relativo/Contrato.sol}"],
    "verify": "{NomeContrato}:certora_tests/specs/AccessControl.spec",
    "solc": "solc{major}.{minor}",
    "msg": "Access Control verification — {NomeContrato}",
    "rule_sanity": "basic",
    "optimistic_loop": true,
    "loop_iter": "3",
    "wait_for_results": "all"
}
```

Adaptar `solc` para a versão do pragma do contrato (ex: pragma ^0.8.20 → `"solc": "solc0.8.20"`).

---

## FASE 3 — VALIDAÇÃO LOCAL E EXECUÇÃO

### 3.1 Validar sintaxe localmente (OBRIGATÓRIO antes de enviar)

```bash
certoraRun {project_path}/certora_tests/confs/AccessControl.conf \
  --compilation_steps_only
```

**Se houver erro de sintaxe:** corrija o .spec e repita. Não envie para a nuvem com erro de sintaxe.

Erros comuns e correções:

| Erro | Causa | Correção |
|------|-------|----------|
| `Syntax error: unexpected token near ID(...)` | Assinatura no methods block no formato CVL1 | Adicionar `function` no início e `;` no final |
| `type error: cannot convert uint256 to mathint` | Usar uint256 onde mathint é necessário | Substituir por `mathint` |
| `0 rules provided in the spec` | Spec sem regras válidas ou filtrado errado | Verificar sintaxe das rules |
| `envfree function uses msg.sender` | Função declarada envfree acessa msg.sender | Remover envfree da declaração |
| `method not found` | Nome de função errado no methods block | Checar assinatura exata no contrato |

### 3.2 Executar no Certora Cloud

```bash
certoraRun {project_path}/certora_tests/confs/AccessControl.conf \
  --wait_for_results all \
  --msg "Access control check — {NomeContrato} run {N}"
```

**Observação:** sem `--wait_for_results all`, o terminal retorna apenas um link sem mostrar os resultados. Sempre usar este flag.

### 3.3 Iteração em caso de erro no spec

Máximo **5 iterações**. Se após 5 tentativas o spec ainda tiver erro:
- Reporte o erro exato
- NÃO continue tentando
- NÃO afirme que o contrato é seguro

Estratégia de iteração:
1. Erro de sintaxe → corrigir sintaxe específica apontada
2. Erro de tipo → verificar uso de mathint vs uint256
3. envfree failure → verificar se função realmente não usa env
4. Loop unwind → adicionar `--optimistic_loop` no .conf (já está no template)
5. Timeout → usar `--rule nome_da_regra` para testar uma regra por vez

---

## FASE 4 — VALIDAÇÃO DO RESULTADO

### 4.1 Interpretar saída do Certora

| Saída | Significado | Ação |
|-------|-------------|------|
| `All rules passed.` | Propriedades satisfeitas para todos os inputs | Relatar "não encontrou violação" |
| `Prover found violations: [rule] X: FAIL` | Violação encontrada — há contraexemplo | Extrair contraexemplo → Fase 5 |
| `[rule] X: TIMEOUT` | Regra muito complexa para o solver | Ver HANDLING TIMEOUT |
| `[rule] X: SANITY` | Regra vacuamente verdadeira (require sempre falso) | Reescrever a regra |
| `CRITICAL: Syntax error` | Erro no .spec | Corrigir e reiterar |

### 4.2 HANDLING TIMEOUT

Timeout NÃO significa que o contrato é seguro. Ações:
1. Testar a regra isolada: `--rule nome_da_regra --wait_for_results all`
2. Simplificar quantificadores (remover forall quando possível)
3. Aumentar `--smt_timeout 600` no .conf
4. Se persistir: reportar como INCONCLUSIVO, não como PASS

### 4.3 HANDLING SANITY FAILURE

`rule_sanity: basic` detecta regras vacuamente verdadeiras (o require é sempre falso, então o assert nunca é testado). Ação:
1. Remover ou relaxar o require que está sendo muito restritivo
2. Verificar se a função realmente existe no contrato

### 4.4 Verificar que as propriedades testam o que dizem

Antes de reportar PASS como "seguro", verificar:
- [ ] O methods block tem as funções corretas com assinaturas corretas?
- [ ] As regras cobrem as funções privilegiadas identificadas no slither_context?
- [ ] Nenhuma regra tem vacuidade (rule_sanity: basic deve passar)?
- [ ] O padrão de access control identificado corresponde ao que está no spec?

---

## FASE 5A — GERAR PoC (se FAIL)

Extraia do relatório Certora:
- Qual regra violou
- Valor de `e.msg.sender` no contraexemplo
- Argumentos da função no contraexemplo
- Estado das variáveis antes da chamada

Gere um teste Foundry:

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^{versao};

import "forge-std/Test.sol";
import "{caminho/Contrato.sol}";

/// @title PoC — {NomeVulnerabilidade} em {NomeContrato}
/// @notice Reproduz a violação encontrada pelo Certora Prover
/// Regra violada: {nomeRegra}
/// CWE: CWE-284 (Improper Access Control)
contract PoCAccessControl is Test {
    {NomeContrato} target;

    function setUp() public {
        target = new {NomeContrato}({args_constructor});
        // Estado inicial conforme contraexemplo do Certora
    }

    function test_accessControlViolation() public {
        // Caller não-autorizado conforme contraexemplo
        address attacker = address(0xDEAD);

        vm.prank(attacker);
        // Chama a função privilegiada sem autorização
        target.{funcName}({args_do_contraexemplo});

        // Se chegou aqui, o access control falhou
        // O Certora provou que este caminho é alcançável
    }
}
```

Preencha com os valores exatos do contraexemplo. Se o contraexemplo não tiver valores concretos para algum argumento, use valores simbólicos documentados.

---

## FASE 5B — RELATÓRIO ESTRUTURADO

```markdown
# Relatório de Verificação Formal — Access Control
**Contrato:** {NomeContrato}
**Data:** {data}
**Ferramenta:** Certora Prover + Slither (enriquecimento de contexto)

## Resumo
- Resultado: VULNERABILIDADE ENCONTRADA / NÃO ENCONTRADA / INCONCLUSIVO
- Propriedades verificadas: N
- Violações: N

## Vulnerabilidades Encontradas

### VULN-001 — {Título}
- **Severidade:** Critical / High / Medium
- **CWE:** CWE-284 (Improper Access Control)
- **Regra CVL violada:** {nomeRegra}
- **Função afetada:** {funcName}
- **Contraexemplo Certora:**
  - msg.sender: {valor}
  - argumentos: {valores}
  - estado pré-chamada: {estado relevante}
- **Impacto:** {descrição do impacto}
- **Recomendação:** Adicionar modifier `onlyOwner` / `onlyRole(ROLE)` / `require(msg.sender == admin)` na função {funcName}
- **PoC:** certora_tests/poc/PoCAccessControl.sol

## Propriedades Verificadas

| Regra | Status | Descrição |
|-------|--------|-----------|
| onlyOwnerCanMint | FAIL | mint executou para não-owner |
| ownerNeverZero | PASS | owner nunca é address(0) |

## Metodologia
1. Slither printers executados: vars-and-auth, modifiers, function-summary, require, inheritance
2. Padrão de access control identificado: {ownable/rbac/custom/none}
3. Propriedades CVL criadas: N rules + M invariants
4. Execução Certora: {URL do dashboard}
5. Validação: rule_sanity basic executado — sem vacuidade

## Limitações
- Verificação cobre os caminhos provados pelo solver SMT dentro do timeout configurado
- Timeouts reportados como INCONCLUSIVO, não como PASS
- PoC requer ambiente Foundry para reprodução
```

---

## ARMADILHAS CONHECIDAS CVL

### lastReverted sobrescrito
```cvl
// ERRADO
func@withrevert(e);
bool p = getStatus();   // ← sobrescreve lastReverted
assert p => lastReverted;

// CORRETO
func@withrevert(e);
bool reverted = lastReverted;  // ← capturar imediatamente
bool p = getStatus();
assert p => reverted;
```

### envfree errado
```cvl
// ERRADO — owner() pode chamar msg.sender internamente mas não é o problema
// O problema é: você está tentando declarar envfree uma função que depende de env
methods {
    function mint(address, uint256) external returns (bool) envfree;  // ERRADO se mint usa msg.sender
}

// CORRETO — apenas funções que não dependem do ambiente
methods {
    function owner() external returns (address) envfree;  // OK: retorna variável de storage
}
```

### Filtered com method não como parâmetro
```cvl
// ERRADO
rule myRule()
filtered { f -> f.isView }  // f não está declarado
{ method f; f(e, args); }

// CORRETO
rule myRule(method f)
filtered { f -> !f.isView }
{ env e; calldataarg args; f(e, args); }
```

### Preserved blocks — require muito restritivo
```cvl
// PERIGOSO — restrict demais → invariant vacuamente verdadeiro
invariant ownerNeverZero()
    owner() != 0
{
    preserved {
        require owner() != 0;  // ← assume o que quer provar
    }
}

// CORRETO — usar requireInvariant de outro invariant já provado
invariant ownerNeverZero()
    owner() != 0
{
    preserved transferOwnership(address newOwner) with (env e) {
        require newOwner != 0;  // ← restrição válida: novo owner não pode ser zero
    }
}
```

---

## CANDIDATES

| ID | Padrão | Ocorrências | Evidência (resumo do log Certora) | Data |
|----|--------|-------------|-----------------------------------|------|

## CONFIRMED PATTERNS
<!-- Promovido após ≥3 ocorrências com logs distintos de execuções reais -->

## DEPRECATED
<!-- Padrões que foram promovidos mas causaram erros após adoção -->
