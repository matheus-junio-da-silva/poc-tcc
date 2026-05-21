# 05 — Agente Access Control (access-control-certora)

> **Versão:** 1.0  
> **Data:** 2026-05-21  
> **Correções aplicadas:**
> - Regra para padrão NONE reescrita (problema grave — lógica original incorreta)
> - Invariant `adminRoleNeverZero` corrigido (conflitava com OpenZeppelin)
> - Template `.conf` expandido com resolução de imports
> - Procedimento para multi-contract adicionado
> - Handling de hooks com cuidado sobre layout de storage

---

## 1. Identidade

```yaml
name: access-control-certora
description: >
  Cria propriedades CVL para access control, executa no Certora Prover,
  valida resultados, gera PoC e relatório. Use quando o orchestrator enviar
  slither_context de um contrato Solidity para verificação de access control.
```

---

## 2. Regras Absolutas

1. **NUNCA invente sintaxe CVL.** Use apenas os padrões documentados neste skill.
2. **NUNCA modifique o contrato original** — apenas crie/edite `.spec` e `.conf`.
3. **NUNCA afirme** que o contrato é seguro sem execução bem-sucedida do Certora.
4. **NUNCA afirme** vulnerabilidade sem o contraexemplo do Certora.
5. **Sempre** execute `--compilation_steps_only` ANTES de enviar para a nuvem.
6. **Sempre** use `--wait_for_results all` para receber resultado no terminal.

---

## 3. FASE 1 — Análise do slither_context

Receba o `slither_context` do orquestrador. Identifique:

### Padrão de Access Control

| Padrão | Evidência no slither_context | Templates CVL a usar |
|--------|------------------------------|---------------------|
| `ownable` | Modifier `onlyOwner` ou variável `owner`/`_owner` | Seção 5.1 |
| `rbac` | Mapping `_roles`, funções `grantRole`/`revokeRole`/`hasRole` | Seção 5.2 |
| `custom` | Checks diretos como `require(msg.sender == admin)` | Seção 5.3 |
| `none` | Nenhuma proteção em funções que alteram estado | Seção 5.4 |

### Funções Privilegiadas a Verificar

| Prioridade | Funções |
|-----------|---------|
| **Máxima** | `mint`, `burn`, `upgradeTo`, `selfdestruct`, `transferOwnership`, `grantRole` |
| **Alta** | `pause`, `unpause`, `setFee`, `withdraw`, `emergencyWithdraw` |
| **Média** | Outras funções que escrevem state variables críticas |

**NÃO criar propriedades para:**
- Funções `view` / `pure` (não alteram estado)
- Funções de leitura (`balanceOf`, `totalSupply`, etc.)

---

## 4. FASE 2 — Criar Estrutura de Diretórios

```bash
mkdir -p {project_path}/certora_tests/specs
mkdir -p {project_path}/certora_tests/confs
mkdir -p {project_path}/certora_tests/poc
mkdir -p {project_path}/certora_tests/reports
```

---

## 5. Propriedades CVL por Padrão

### 5.1 Padrão OWNABLE

```cvl
methods {
    function owner() external returns (address) envfree;
}

/// @title Somente owner pode chamar {funcName}
/// @notice Se a chamada não reverteu, o chamador é o owner
rule onlyOwnerCan_{FuncName} {
    // Adaptar parâmetros para a assinatura real da função
    address to;
    uint256 amount;
    env e;

    {funcName}@withrevert(e, to, amount);
    bool reverted = lastReverted;

    assert !reverted => e.msg.sender == owner(),
        "{funcName} executou com sucesso para um não-owner";
}

/// @title Owner nunca é o endereço zero
invariant ownerNeverZero()
    owner() != 0
    {
        preserved transferOwnership(address newOwner) with (env e) {
            require newOwner != 0;
        }
    }

/// @title Somente owner pode transferir ownership
rule transferOwnershipOnlyOwner {
    address newOwner;
    env e;

    address ownerBefore = owner();

    transferOwnership@withrevert(e, newOwner);
    bool reverted = lastReverted;

    assert !reverted => e.msg.sender == ownerBefore,
        "transferOwnership executou para não-owner";
}

/// @title transferOwnership define o novo owner corretamente
rule transferOwnershipSetsNewOwner {
    address newOwner;
    env e;

    transferOwnership(e, newOwner);

    assert owner() == newOwner,
        "owner não foi atualizado corretamente";
}

/// @title Nenhuma função não-autorizada altera o owner
rule noUnauthorizedOwnerChange(method f)
filtered { f -> !f.isView }
{
    env e;
    calldataarg args;
    address ownerBefore = owner();

    f(e, args);

    address ownerAfter = owner();

    assert ownerBefore != ownerAfter =>
        f.selector == sig:transferOwnership(address).selector ||
        f.selector == sig:renounceOwnership().selector,
        "owner foi alterado por função não autorizada";
}
```

> **Nota sobre a regra `noUnauthorizedOwnerChange`:** A versão original verificava `e.msg.sender == ownerBefore || e.msg.sender == ownerAfter`, o que é menos preciso. A versão corrigida verifica que apenas `transferOwnership` e `renounceOwnership` podem alterar o owner — é mais restritiva e detecta funções que acidentalmente sobrescrevem o owner.

### 5.2 Padrão RBAC (AccessControl do OpenZeppelin)

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
    function getRoleAdmin(bytes32 role) external returns (bytes32) envfree;
}

definition DEFAULT_ADMIN_ROLE() returns bytes32 = to_bytes32(0);

/// @title Somente role admin pode conceder role
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

/// @title Somente role admin pode revogar role
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

/// @title Somente grantRole/revokeRole/renounceRole podem alterar roles
rule onlyRoleFunctionsChangeRoles(method f)
filtered { f -> !f.isView }
{
    env e;
    bytes32 anyRole;
    address anyAccount;
    calldataarg args;

    bool hasRoleBefore = hasRole(anyRole, anyAccount);

    f(e, args);

    bool hasRoleAfter = hasRole(anyRole, anyAccount);

    assert hasRoleAfter != hasRoleBefore =>
        f.selector == sig:grantRole(bytes32, address).selector   ||
        f.selector == sig:revokeRole(bytes32, address).selector  ||
        f.selector == sig:renounceRole(bytes32, address).selector,
        "Método não autorizado alterou estado de roles";
}

/// @title Nenhum papel pode ser atribuído ao address zero
invariant zeroAddressHasNoRole(bytes32 role)
    !hasRole(role, 0)
    {
        preserved grantRole(bytes32 r, address account) with (env e) {
            require account != 0;
        }
    }
```

> **CORREÇÃO CRÍTICA:** A proposta original incluía o invariant:
> ```cvl
> invariant adminRoleNeverZero(bytes32 role)
>     getRoleAdmin(role) != to_bytes32(0);
> ```
> **Isso está ERRADO.** No OpenZeppelin `AccessControl`, o `DEFAULT_ADMIN_ROLE` é `0x00` (bytes32 zero), e o admin do `DEFAULT_ADMIN_ROLE` **também é** `0x00` — ele é admin de si mesmo. Este invariant falharia imediatamente no caso mais comum de RBAC. Foi removido da especificação corrigida.

### 5.3 Padrão CUSTOM (require inline)

```cvl
methods {
    // Adaptar para a variável de controle de acesso real do contrato
    function admin() external returns (address) envfree;
}

/// @title Somente admin pode chamar {funcName}
rule onlyAdminCan_{FuncName} {
    env e;
    calldataarg args;

    {funcName}@withrevert(e, args);
    bool reverted = lastReverted;

    assert !reverted => e.msg.sender == admin(),
        "{funcName} executou para não-admin";
}
```

### 5.4 Padrão NONE (sem access control)

> **CORREÇÃO CRÍTICA:** A proposta original usava duas chamadas sequenciais à mesma função, o que é logicamente incorreto — a segunda chamada opera sobre o estado modificado pela primeira, causando falsos positivos/negativos. A versão corrigida verifica que a função reverte quando chamada por um endereço arbitrário não-privilegiado.

```cvl
/// @title Função crítica não tem controle de acesso
/// @notice Esta regra deve PASSAR se a função realmente não tem AC.
/// Se ela PASSAR, isso CONFIRMA a ausência de proteção = vulnerabilidade.
rule noAccessControlOn_{FuncName} {
    env e;
    calldataarg args;

    // Usar um endereço arbitrário que não deveria ter permissão
    // Se a função não reverte para QUALQUER sender, não tem AC
    require e.msg.value == 0;  // eliminar revert por msg.value

    {funcName}@withrevert(e, args);
    bool reverted = lastReverted;

    // Se esta regra encontrar um caso onde NÃO reverte,
    // significa que existe um sender sem autorização que pode executar
    // Combine com a regra paramétrica abaixo para confirmar
    satisfy !reverted;
}

/// @title Verificação paramétrica: funções que alteram estado sem proteção
/// @notice Para cada função que altera estado, verifica se QUALQUER sender pode executar
rule stateChangingFunctionLacksAC(method f)
filtered { f -> !f.isView && !f.isPure }
{
    env e;
    calldataarg args;

    require e.msg.value == 0;

    storage stateBefore = lastStorage;

    f@withrevert(e, args);
    bool reverted = lastReverted;

    storage stateAfter = lastStorage;

    // Se o estado mudou sem revert, e o sender é um endereço qualquer,
    // isso indica ausência de access control
    // Nota: esta regra pode ter falsos positivos para funções que
    // legitimamente podem ser chamadas por qualquer um (ex: transfer)
    // O agente deve analisar quais funções são ESPERADAS sem AC
    assert stateAfter != stateBefore && !reverted =>
        // Adicionar aqui as funções que legitimamente não precisam de AC:
        f.selector == sig:transfer(address, uint256).selector ||
        f.selector == sig:approve(address, uint256).selector ||
        f.selector == sig:transferFrom(address, address, uint256).selector,
        "Função que altera estado sem controle de acesso identificada";
}
```

> **Nota:** Para padrão `none`, a abordagem é diferente: em vez de provar que "access control funciona", provamos que "access control está ausente". A regra `satisfy` encontra um caminho onde a função executa sem revert — se isso é possível para um endereço arbitrário, confirma a ausência de proteção. A regra paramétrica filtra funções que legitimamente não precisam de AC (como `transfer`).

---

## 6. Arquivo `.conf`

### Template para projetos com Hardhat

```json
{
    "files": [
        "contracts/{Contrato}.sol"
    ],
    "verify": "{NomeContrato}:certora_tests/specs/AccessControl.spec",
    "solc": "solc{major}.{minor}",
    "packages_path": ["node_modules"],
    "msg": "Access Control verification — {NomeContrato}",
    "rule_sanity": "basic",
    "optimistic_loop": true,
    "loop_iter": "3",
    "wait_for_results": "all"
}
```

### Template para projetos com Foundry

```json
{
    "files": [
        "src/{Contrato}.sol"
    ],
    "verify": "{NomeContrato}:certora_tests/specs/AccessControl.spec",
    "solc": "solc{major}.{minor}",
    "solc_remaps": [
        "@openzeppelin/=lib/openzeppelin-contracts/",
        "forge-std/=lib/forge-std/src/"
    ],
    "msg": "Access Control verification — {NomeContrato}",
    "rule_sanity": "basic",
    "optimistic_loop": true,
    "loop_iter": "3",
    "wait_for_results": "all"
}
```

### Template para arquivo standalone

```json
{
    "files": [
        "{Contrato}.sol"
    ],
    "verify": "{NomeContrato}:{Contrato}.spec",
    "solc": "solc{major}.{minor}",
    "msg": "Access Control verification — {NomeContrato}",
    "rule_sanity": "basic",
    "optimistic_loop": true,
    "loop_iter": "3",
    "wait_for_results": "all"
}
```

### Multi-Contract (quando há contratos auxiliares)

```json
{
    "files": [
        "contracts/MyToken.sol",
        "contracts/TokenGovernance.sol"
    ],
    "verify": "MyToken:certora_tests/specs/AccessControl.spec",
    "link": [
        "MyToken:governance=TokenGovernance"
    ],
    "solc": "solc0.8.20",
    "packages_path": ["node_modules"],
    "msg": "Access Control verification — MyToken + Governance",
    "rule_sanity": "basic",
    "optimistic_loop": true,
    "loop_iter": "3",
    "wait_for_results": "all"
}
```

> **CORREÇÃO:** A proposta original não incluía `packages_path`, `solc_remaps` nem `link`. Sem estes, qualquer projeto real com OpenZeppelin falharia na compilação por não resolver imports como `@openzeppelin/contracts/access/Ownable.sol`.

### Como determinar `solc`

| Pragma do contrato | Valor do `solc` |
|-------------------|-----------------|
| `pragma solidity ^0.8.20;` | `"solc": "solc0.8.20"` |
| `pragma solidity >=0.8.0 <0.9.0;` | `"solc": "solc0.8.0"` (usar mínimo) |
| `pragma solidity 0.8.23;` | `"solc": "solc0.8.23"` |

---

## 7. FASE 3 — Validação Local e Execução

### 7.1 Validar Sintaxe (OBRIGATÓRIO antes de enviar)

```bash
certoraRun {project_path}/certora_tests/confs/AccessControl.conf \
  --compilation_steps_only
```

**Erros comuns e correções:**

| Erro | Causa | Correção |
|------|-------|----------|
| `Syntax error: unexpected token near ID(...)` | Methods block no formato CVL1 | Adicionar `function` no início e `;` no final |
| `type error: cannot convert uint256 to mathint` | Tipo errado | Substituir por `mathint` para cálculos |
| `0 rules provided in the spec` | Spec sem regras ou filtrado | Verificar sintaxe das rules |
| `envfree function uses msg.sender` | Função envfree acessa msg.sender | Remover `envfree` da declaração |
| `method not found` | Nome de função errado | Checar assinatura exata no contrato |
| `Source not found` / `Import not found` | Import não resolvido | Adicionar `packages_path` ou `solc_remaps` ao `.conf` |

### 7.2 Executar no Certora Cloud

```bash
certoraRun {project_path}/certora_tests/confs/AccessControl.conf \
  --wait_for_results all \
  --msg "Access control check — {NomeContrato} run {N}"
```

### 7.3 Iteração em Caso de Erro

**Máximo 5 iterações.** Se após 5 tentativas o spec ainda tiver erro:
- Reportar o erro exato
- **NÃO** continuar tentando
- **NÃO** afirmar que o contrato é seguro

**Estratégia de iteração:**
1. Erro de sintaxe → corrigir sintaxe específica apontada
2. Erro de tipo → verificar uso de `mathint` vs `uint256`
3. envfree failure → verificar se função realmente não usa env
4. Import não resolvido → adicionar `packages_path` ou `solc_remaps`
5. Timeout → usar `--rule nome_da_regra` para testar uma regra por vez

---

## 8. FASE 4 — Validação do Resultado

### 8.1 Interpretação

| Saída do Certora | Significado | Ação |
|-----------------|-------------|------|
| `All rules passed.` | Propriedades satisfeitas para todos os inputs | Reportar: "nenhuma violação encontrada para estas propriedades" |
| `Prover found violations: [rule] X: FAIL` | Violação — há contraexemplo | Extrair CE → Fase 5 |
| `[rule] X: TIMEOUT` | Solver não terminou | Ver seção 8.2 |
| `[rule] X: SANITY` | Regra vacuamente verdadeira | Ver seção 8.3 |
| `CRITICAL: Syntax error` | Erro no .spec | Corrigir e reiterar (max 5×) |

### 8.2 Handling de TIMEOUT

Timeout **NÃO** significa que o contrato é seguro.

1. Testar regra isolada: `--rule nome_da_regra --wait_for_results all`
2. Simplificar quantificadores (remover forall quando possível)
3. Aumentar `--smt_timeout 600` no `.conf`
4. Se persistir: reportar como **INCONCLUSIVO**, não como PASS

### 8.3 Handling de SANITY

`rule_sanity: basic` detecta regras vacuamente verdadeiras (o `require` é sempre falso).

1. Remover ou relaxar o `require` muito restritivo
2. Verificar se a função realmente existe no contrato
3. Verificar se os parâmetros do methods block estão corretos

### 8.4 Checklist de Validação (antes de reportar)

- [ ] O methods block tem as funções corretas com assinaturas corretas?
- [ ] As regras cobrem as funções privilegiadas do slither_context?
- [ ] Nenhuma regra tem vacuidade (rule_sanity passed)?
- [ ] O padrão de AC identificado corresponde ao que está no spec?
- [ ] Para RBAC: o DEFAULT_ADMIN_ROLE está tratado corretamente?

---

## 9. FASE 5A — Gerar PoC (se FAIL)

Extrair do relatório Certora:
- Qual regra violou
- Valor de `e.msg.sender` no contraexemplo
- Argumentos da função no contraexemplo
- Estado das variáveis antes da chamada

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^{versao};

import "forge-std/Test.sol";
import "{caminho/Contrato.sol}";

/// @title PoC — Falha de Access Control em {NomeContrato}
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

        // Se chegou aqui sem revert, o access control falhou
        // O Certora provou que este caminho é alcançável
    }
}
```

---

## 10. FASE 5B — Relatório Estruturado

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
  - estado pré-chamada: {estado}
- **Impacto:** {descrição}
- **Recomendação:** Adicionar modifier/require adequado
- **PoC:** certora_tests/poc/PoCAccessControl.sol

## Propriedades Verificadas

| Regra | Status | Descrição |
|-------|--------|-----------|
| onlyOwnerCanMint | FAIL/PASS/TIMEOUT | descrição |

## Metodologia
1. Slither printers: vars-and-auth, modifiers, function-summary, require, inheritance, entry-points
2. Padrão de AC: {ownable/rbac/custom/none}
3. Propriedades CVL: N rules + M invariants
4. Execução Certora: {URL dashboard}
5. Validação: rule_sanity basic — sem vacuidade

## Limitações
- Verificação cobre os caminhos provados dentro do timeout configurado
- Timeouts reportados como INCONCLUSIVO, não como PASS
- Interações cross-contract podem não ser completamente modeladas
- PoC requer ambiente Foundry para reprodução
```

---

## 11. Armadilhas Conhecidas (CVL)

### `lastReverted` sobrescrito
```cvl
// ERRADO
func@withrevert(e);
bool p = getStatus();       // sobrescreve lastReverted
assert p => lastReverted;

// CORRETO
func@withrevert(e);
bool reverted = lastReverted;  // capturar imediatamente
bool p = getStatus();
assert p => reverted;
```

### `envfree` errado
```cvl
// ERRADO — mint usa msg.sender internamente
methods {
    function mint(address, uint256) external returns (bool) envfree;
}

// CORRETO — apenas getters de storage
methods {
    function owner() external returns (address) envfree;
}
```

### Filtered sem parâmetro
```cvl
// ERRADO
rule myRule()
filtered { f -> f.isView }
{ method f; f(e, args); }

// CORRETO
rule myRule(method f)
filtered { f -> !f.isView }
{ env e; calldataarg args; f(e, args); }
```

### Preserved block assume o que quer provar
```cvl
// PERIGOSO — torna o invariant vacuamente verdadeiro
invariant ownerNeverZero()
    owner() != 0
{
    preserved {
        require owner() != 0;  // assume o que quer provar!
    }
}

// CORRETO
invariant ownerNeverZero()
    owner() != 0
{
    preserved transferOwnership(address newOwner) with (env e) {
        require newOwner != 0;  // restrição válida sobre input
    }
}
```

### Hooks dependem do layout de storage
```cvl
// CUIDADO — este hook assume um nome de slot específico
// Se o contrato usar proxy ou layout diferente, o hook silenciosamente não dispara
hook Sstore _owner address newOwner {
    ghostOwner = newOwner;
}
```
**Recomendação:** Verificar o layout de storage com o printer `variable-order` do Slither antes de usar hooks. Para contratos com proxy, hooks podem não funcionar corretamente.

---

## 12. Auto-Melhoria

### CANDIDATES

| ID | Padrão | Ocorrências | Evidência (log Certora) | Data |
|----|--------|-------------|------------------------|------|

### CONFIRMED PATTERNS
<!-- Promovido após ≥3 ocorrências com logs distintos -->

### DEPRECATED
<!-- Padrões que causaram falha após promoção -->
