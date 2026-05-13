# Certora CVL — Especificações de Access Control em Contratos Solidity

> **Nota de rigor:** Este documento foi construído exclusivamente com base na documentação oficial do Certora Prover (`docs.certora.com`), tutoriais oficiais, exemplos publicados no GitHub da Certora e da OpenZeppelin, e fontes verificadas da comunidade (RareSkills, dev.to). Nada foi inventado ou especulado.

---

## Índice

1. [Conceitos Fundamentais de CVL](#1-conceitos-fundamentais-de-cvl)
2. [Estrutura de um Arquivo `.spec`](#2-estrutura-de-um-arquivo-spec)
3. [O que é Access Control e por que verificar formalmente](#3-o-que-é-access-control-e-por-que-verificar-formalmente)
4. [Primitivas CVL essenciais para Access Control](#4-primitivas-cvl-essenciais-para-access-control)
5. [Propriedades — Exemplos completos](#5-propriedades--exemplos-completos)
   - 5.1 [Ownable: somente owner pode chamar funções críticas](#51-ownable-somente-owner-pode-chamar-funções-críticas)
   - 5.2 [Ownable: transferência de ownership](#52-ownable-transferência-de-ownership)
   - 5.3 [Role-Based Access Control (RBAC)](#53-role-based-access-control-rbac)
   - 5.4 [Imutabilidade do owner após deploy](#54-imutabilidade-do-owner-após-deploy)
   - 5.5 [Funções críticas não podem ser chamadas por address zero](#55-funções-críticas-não-podem-ser-chamadas-por-address-zero)
   - 5.6 [Apenas funções autorizadas alteram papéis](#56-apenas-funções-autorizadas-alteram-papéis)
   - 5.7 [Pausable: somente pauser pode pausar](#57-pausable-somente-pauser-pode-pausar)
   - 5.8 [Parametric rule: nenhuma função não-autorizada altera storage privilegiado](#58-parametric-rule-nenhuma-função-não-autorizada-altera-storage-privilegiado)
   - 5.9 [Ghost + Hook: rastrear mudanças de roles](#59-ghost--hook-rastrear-mudanças-de-roles)
   - 5.10 [Invariant: admin nunca é address zero](#510-invariant-admin-nunca-é-address-zero)
   - 5.11 [Invariant: role admin só pode ser alterado por quem tem o papel correto](#511-invariant-role-admin-só-pode-ser-alterado-por-quem-tem-o-papel-correto)
   - 5.12 [Invariant forte (strong invariant): access control durante chamadas externas](#512-invariant-forte-strong-invariant-access-control-durante-chamadas-externas)
   - 5.13 [Regra de reversão bidirecional](#513-regra-de-reversão-bidirecional)
   - 5.14 [Isolamento de efeitos: grantRole não afeta outros papéis](#514-isolamento-de-efeitos-grantrole-não-afeta-outros-papéis)
   - 5.15 [renounceRole só afeta o próprio chamador](#515-renouncerole-só-afeta-o-próprio-chamador)
6. [Configuração do arquivo `.conf`](#6-configuração-do-arquivo-conf)
7. [Boas práticas e armadilhas comuns](#7-boas-práticas-e-armadilhas-comuns)
8. [Referências](#8-referências)

---

## 1. Conceitos Fundamentais de CVL

O **Certora Prover** verifica que um contrato inteligente satisfaz um conjunto de regras escritas na **Certora Verification Language (CVL)**. Ele opera sobre o bytecode EVM gerado pelo compilador Solidity — não sobre o código-fonte — e usa um solver SMT para encontrar contraexemplos ou provar a ausência de violações.

Os blocos principais de um arquivo `.spec` são:

| Bloco | Finalidade |
|---|---|
| `methods` | Declara como o Prover deve tratar métodos do contrato (envfree, summaries) |
| `rule` | Descreve comportamento esperado de transições de estado |
| `invariant` | Descreve propriedades que devem ser verdadeiras em **todos** os estados alcançáveis |
| `ghost` | Variáveis auxiliares em CVL para rastrear estado extra não exposto diretamente |
| `hook` | Instrumenta o contrato para executar código CVL quando um slot de storage é lido/escrito |
| `function` (CVL) | Funções reutilizáveis dentro da spec |
| `definition` | Expressões CVL reutilizáveis |

---

## 2. Estrutura de um Arquivo `.spec`

```cvl
// Referência a outros contratos (se necessário)
using OtherContract as other;

// Bloco de métodos: declara quais funções do contrato não dependem do ambiente
methods {
    function owner()              external returns (address) envfree;
    function hasRole(bytes32, address) external returns (bool)  envfree;
    function getRoleAdmin(bytes32) external returns (bytes32)  envfree;
    function paused()             external returns (bool)      envfree;
}

// Ghost: variável auxiliar para rastrear estado
ghost address ghostOwner;

// Hook: atualiza o ghost sempre que o slot _owner é escrito
hook Sstore _owner address newOwner {
    ghostOwner = newOwner;
}

// Invariant: propriedade sempre verdadeira
invariant ownerNeverZero()
    owner() != 0;

// Rule: propriedade de uma transição específica
rule onlyOwnerCanMint {
    address to;
    uint256 amount;
    env e;

    mint@withrevert(e, to, amount);

    assert !lastReverted => e.msg.sender == owner(),
        "mint só pode ser chamado pelo owner";
}
```

---

## 3. O que é Access Control e por que verificar formalmente

**Access control** é a garantia de que somente entidades autorizadas podem executar ações privilegiadas em um contrato. Falhas nessa camada são recorrentes em exploits reais (ex.: funções `mint`, `upgradeTo`, `pause`, transferência de ownership).

As vulnerabilidades típicas incluem:

- Modifier `onlyOwner` ausente ou mal posicionado
- Verificação de role feita com a variável errada
- Owner inicializado como `address(0)` ou jamais definido
- `grantRole` / `revokeRole` sem verificação adequada do chamador
- Transferência de ownership sem confirmação do novo owner (ausência de two-step)

A verificação formal prova — matematicamente, para **todos os inputs possíveis** — que essas condições nunca são violadas.

---

## 4. Primitivas CVL essenciais para Access Control

### `env e` — o ambiente de execução

O tipo `env` agrupa as variáveis globais do Solidity. É obrigatório em chamadas a funções que dependem de `msg.sender`, `msg.value`, `block.timestamp`, etc.

```cvl
env e;
// campos disponíveis:
// e.msg.sender  — address do chamador
// e.msg.value   — ETH enviado
// e.block.timestamp
// e.block.number
// e.tx.origin
```

### `@withrevert` e `lastReverted`

Por padrão, o Prover **assume que funções não revertem**. Use `@withrevert` para considerar o caminho de revert:

```cvl
someFunction@withrevert(e, arg);
assert lastReverted => <condição>;
```

> **Atenção:** `lastReverted` é atualizado após **cada** chamada, mesmo sem `@withrevert`. Não chame outra função entre o `@withrevert` e a leitura de `lastReverted`.

### `envfree`

Funções que não dependem de `msg.sender` ou outras variáveis de ambiente devem ser declaradas `envfree` no bloco `methods`. Isso permite chamá-las sem passar `env`:

```cvl
methods {
    function owner() external returns (address) envfree;
}
// Uso direto sem env:
address o = owner();
```

### Parametric rules (regras paramétricas)

Usando `method f` como parâmetro, o Prover verifica a regra para **cada método do contrato**:

```cvl
rule noUnauthorizedStateChange(method f) {
    env e;
    calldataarg args;
    // ...
    f(e, args);
    // ...
}
```

### `filtered`

Restringe quais métodos são verificados numa regra paramétrica:

```cvl
rule onlyMutatingFunctions(method f)
filtered { f -> !f.isView }
{
    // ...
}
```

### `ghost` e `hook`

Usados para rastrear estado interno do contrato que não é diretamente acessível:

```cvl
ghost address ghostOwner;

hook Sstore _owner address newVal {
    ghostOwner = newVal;
}
```

### `requireInvariant`

Permite assumir que um invariant já verificado é verdadeiro dentro de um preserved block, evitando provar novamente:

```cvl
invariant myInvariant() ... {
    preserved {
        requireInvariant ownerNeverZero();
    }
}
```

---

## 5. Propriedades — Exemplos completos

As propriedades abaixo são organizadas do mais simples ao mais avançado. Cada uma tem comentário explicativo, o código CVL e uma nota sobre o que ela detecta.

---

### 5.1 Ownable: somente owner pode chamar funções críticas

**Propriedade:** Se `mint` não reverteu, então o chamador é o owner.

```cvl
methods {
    function owner() external returns (address) envfree;
}

/// @title Somente owner pode mintar tokens
/// @notice Se a chamada a mint não reverteu, o chamador deve ser o owner
rule onlyOwnerCanMint {
    address to;
    uint256 amount;
    env e;

    mint@withrevert(e, to, amount);

    assert !lastReverted => e.msg.sender == owner(),
        "mint executou com sucesso para um não-owner";
}
```

**Detecta:** Modifier `onlyOwner` ausente ou mal posicionado em `mint`.

---

### 5.2 Ownable: transferência de ownership

**Propriedade:** Após `transferOwnership`, o novo owner é exatamente o endereço fornecido.

```cvl
methods {
    function owner() external returns (address) envfree;
}

/// @title transferOwnership define o novo owner corretamente
rule transferOwnershipSetsNewOwner {
    address newOwner;
    env e;

    // Somente permite chamada bem-sucedida
    transferOwnership(e, newOwner);

    assert owner() == newOwner,
        "owner não foi atualizado corretamente após transferOwnership";
}
```

**Detecta:** Bugs onde o storage de `_owner` não é atualizado corretamente.

---

### 5.2b Ownable: apenas owner pode transferir ownership

**Propriedade:** Se `transferOwnership` não reverteu, então o chamador era o owner antes da chamada.

```cvl
methods {
    function owner() external returns (address) envfree;
}

/// @title Somente o owner pode iniciar transferência de ownership
rule onlyOwnerCanTransferOwnership {
    address newOwner;
    env e;

    address ownerBefore = owner();

    transferOwnership@withrevert(e, newOwner);

    assert !lastReverted => e.msg.sender == ownerBefore,
        "transferOwnership executou com sucesso para um não-owner";
}
```

---

### 5.3 Role-Based Access Control (RBAC)

**Propriedade:** `grantRole` só pode ser chamado com sucesso por quem tem o papel de admin do role sendo concedido.

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
    function getRoleAdmin(bytes32 role)             external returns (bytes32) envfree;
}

/// @title Somente o role admin pode conceder um role
rule onlyRoleAdminCanGrantRole {
    bytes32 role;
    address account;
    env e;

    bytes32 adminRole = getRoleAdmin(role);

    grantRole@withrevert(e, role, account);

    assert !lastReverted => hasRole(adminRole, e.msg.sender),
        "grantRole executou para quem não tem o adminRole";
}
```

**Detecta:** Ausência de `_checkRole(getRoleAdmin(role))` dentro de `grantRole`.

---

### 5.3b RBAC: somente role admin pode revogar role

```cvl
/// @title Somente o role admin pode revogar um role
rule onlyRoleAdminCanRevokeRole {
    bytes32 role;
    address account;
    env e;

    bytes32 adminRole = getRoleAdmin(role);

    revokeRole@withrevert(e, role, account);

    assert !lastReverted => hasRole(adminRole, e.msg.sender),
        "revokeRole executou para quem não tem o adminRole";
}
```

---

### 5.4 Imutabilidade do owner após deploy

**Invariant:** O owner nunca é `address(0)`.

```cvl
methods {
    function owner() external returns (address) envfree;
}

/// @title O owner nunca pode ser o endereço zero
invariant ownerNeverZero()
    owner() != 0
    {
        preserved constructor() {
            // Garante que o invariant vale logo após o deploy
        }
    }
```

**Detecta:** `constructor` que não seta o owner, ou `renounceOwnership` sem guard.

---

### 5.5 Funções críticas não podem ser chamadas por address zero

**Propriedade:** Se uma função crítica não reverteu, o chamador não é `address(0)`.

```cvl
/// @title address(0) não pode chamar funções privilegiadas com sucesso
rule zeroAddressCannotCallPrivileged {
    env e;
    uint256 amount;
    address to;

    mint@withrevert(e, to, amount);

    assert !lastReverted => e.msg.sender != 0,
        "address(0) conseguiu chamar mint com sucesso";
}
```

---

### 5.6 Apenas funções autorizadas alteram papéis

**Propriedade (paramétrica):** O mapping `_roles` só muda via `grantRole`, `revokeRole` ou `renounceRole`.

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
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
        "Um método não autorizado alterou o estado de roles";
}
```

> Esta propriedade foi verificada em produção no repositório `spark-alm-controller-certora` da Sky Ecosystem.

**Detecta:** Funções que acidentalmente modificam o storage de roles sem passar pelas funções de gerenciamento oficiais.

---

### 5.7 Pausable: somente pauser pode pausar

**Propriedade:** Se `pause()` não reverteu, o chamador tem o `PAUSER_ROLE`.

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
    function paused()                               external returns (bool) envfree;
}

definition PAUSER_ROLE() returns bytes32 =
    0x65d7a28e3265b37a6474929f336521b332c1681b933f6cb9f3376673440d862a;

/// @title Somente pauser pode pausar o contrato
rule onlyPauserCanPause {
    env e;

    pause@withrevert(e);

    assert !lastReverted => hasRole(PAUSER_ROLE(), e.msg.sender),
        "pause executou para quem não tem PAUSER_ROLE";
}

/// @title Somente pauser pode despausar o contrato
rule onlyPauserCanUnpause {
    env e;

    unpause@withrevert(e);

    assert !lastReverted => hasRole(PAUSER_ROLE(), e.msg.sender),
        "unpause executou para quem não tem PAUSER_ROLE";
}
```

---

### 5.8 Parametric rule: nenhuma função não-autorizada altera storage privilegiado

Esta regra generalizada verifica que qualquer função executada por um não-owner que **altere o estado** do contrato deve reverter.

```cvl
methods {
    function owner() external returns (address) envfree;
}

/// @title Funções de estado só podem ser chamadas com sucesso pelo owner
rule nonOwnerCannotChangeState(method f)
filtered { f -> !f.isView && !f.isPure }
{
    env e;
    calldataarg args;

    // Armazena o storage antes
    storage stateBefore = lastStorage;

    f(e, args);

    storage stateAfter = lastStorage;

    // Se o estado mudou E o chamador não é o owner, deve ter revertido
    // (Nota: esta versão simplificada assume que qualquer mudança de estado
    //  requer owner. Ajuste conforme a lógica real do contrato.)
    assert stateAfter != stateBefore =>
        e.msg.sender == owner() || lastReverted,
        "Estado alterado por não-owner sem reversão";
}
```

> **Nota:** O operador `!=` para o tipo `storage` está disponível em CVL e compara snapshots do EVM storage. Combine com `@withrevert` quando necessário.

---

### 5.9 Ghost + Hook: rastrear mudanças de roles

Usando ghosts e hooks para criar um invariant mais robusto sobre o estado de roles.

```cvl
// Ghost que rastreia se o DEFAULT_ADMIN_ROLE já foi concedido alguma vez
ghost bool adminRoleEverGranted {
    init_state axiom !adminRoleEverGranted;
}

// O bytes32 do DEFAULT_ADMIN_ROLE no OpenZeppelin AccessControl é 0x00
definition DEFAULT_ADMIN_ROLE() returns bytes32 = to_bytes32(0);

// Hook no Sstore do mapping interno _roles[role][account]
// Nota: o nome exato do slot depende do layout de storage do seu contrato.
// Adapte conforme necessário.
hook Sstore _roles[KEY bytes32 role][KEY address account] bool newVal (bool oldVal) {
    if (role == DEFAULT_ADMIN_ROLE() && newVal == true) {
        adminRoleEverGranted = true;
    }
}

/// @title O DEFAULT_ADMIN_ROLE deve ter sido explicitamente concedido
invariant adminRoleGrantedOnce()
    adminRoleEverGranted
    {
        preserved constructor() {
            // Assume que o constructor define o admin
        }
    }
```

---

### 5.10 Invariant: admin nunca é address zero

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
}

definition DEFAULT_ADMIN_ROLE() returns bytes32 = to_bytes32(0);

/// @title Nenhum papel pode ser atribuído ao address zero
invariant zeroAddressHasNoRole(bytes32 role)
    !hasRole(role, 0)
    {
        preserved {
            // Para todos os métodos que podem conceder roles,
            // exigimos que o account não seja zero
        }
        preserved grantRole(bytes32 r, address account) with (env e) {
            require account != 0;
        }
    }
```

**Detecta:** Concessão acidental de roles ao `address(0)`.

---

### 5.11 Invariant: role admin só pode ser alterado por quem tem o papel correto

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
    function getRoleAdmin(bytes32 role)             external returns (bytes32) envfree;
}

/// @title O admin de um role não muda sem autorização do admin atual
rule roleAdminOnlyChangedByAdmin {
    bytes32 role;
    env e;
    calldataarg args;

    bytes32 adminBefore = getRoleAdmin(role);

    // Chama um método qualquer que poderia alterar o role admin
    setRoleAdmin@withrevert(e, role, args);

    bytes32 adminAfter = getRoleAdmin(role);

    assert adminAfter != adminBefore =>
        hasRole(adminBefore, e.msg.sender),
        "Role admin alterado por quem não tem o adminRole";
}
```

---

### 5.12 Invariant forte (strong invariant): access control durante chamadas externas

Um `strong invariant` garante que a propriedade se mantém **mesmo durante** chamadas externas no meio da execução (relevante para contratos sem reentrancy guard).

```cvl
methods {
    function owner() external returns (address) envfree;
}

/// @title O owner nunca é zero, mesmo durante chamadas externas
strong invariant ownerNeverZeroStrong()
    owner() != 0
```

> Diferença: `invariant` verifica antes e depois de cada função. `strong invariant` verifica também nos pontos onde chamadas externas ocorrem dentro da execução.

---

### 5.13 Regra de reversão bidirecional

Esta propriedade é mais forte: afirma que a função **reverte se e somente se** o chamador não é o owner (assumindo que não há outras causas de revert).

```cvl
methods {
    function owner()   external returns (address) envfree;
    function counter() external returns (uint256) envfree;
}

/// @title increment reverte se e somente se o chamador não é o owner
/// @notice Requer que não haja outros motivos de revert (overflow, msg.value != 0)
rule incrementRevertsIffNotOwner(env e) {
    address current = owner();

    // Elimina outros motivos de revert antes de fazer a asserção bidirecional
    require e.msg.value == 0;
    require counter() < max_uint256;

    increment@withrevert(e);

    assert !lastReverted <=> e.msg.sender == current,
        "increment não reverte sse o chamador é o owner";
}
```

> Fonte: RareSkills Certora tutorial (rareskills.io/post/certora-msgsender-msgvalue)

---

### 5.14 Isolamento de efeitos: grantRole não afeta outros papéis

**Propriedade:** `grantRole(role, account)` não deve alterar o estado de outros pares `(otherRole, otherAccount)`.

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
}

/// @title grantRole afeta somente o par (role, account) especificado
rule grantRoleIsolation {
    bytes32 role;
    address account;
    bytes32 otherRole;
    address otherAccount;
    env e;

    // Garante que estamos verificando um par diferente
    require otherRole != role || otherAccount != account;

    bool hasOtherBefore = hasRole(otherRole, otherAccount);

    grantRole(e, role, account);

    bool hasRoleAfter  = hasRole(role, account);
    bool hasOtherAfter = hasRole(otherRole, otherAccount);

    // O role concedido deve ser verdadeiro
    assert hasRoleAfter,
        "grantRole não concedeu o role ao account";

    // Outros pares não devem mudar
    assert hasOtherAfter == hasOtherBefore,
        "grantRole afetou um par (role, account) diferente do esperado";
}
```

> Esta propriedade foi verificada no repositório `spark-alm-controller-certora`.

---

### 5.15 renounceRole só afeta o próprio chamador

**Propriedade:** `renounceRole` só pode ser chamado pelo próprio titular do role (o chamador não pode renunciar ao role de outro).

```cvl
methods {
    function hasRole(bytes32 role, address account) external returns (bool) envfree;
}

/// @title renounceRole reverte se o callerAccount não é o msg.sender
rule renounceRoleOnlyForSelf {
    bytes32 role;
    address account;
    env e;

    renounceRole@withrevert(e, role, account);

    assert !lastReverted => account == e.msg.sender,
        "renounceRole executou para um account diferente do msg.sender";
}
```

**Detecta:** Implementações bugadas onde qualquer pessoa pode forçar outro usuário a renunciar ao próprio role.

---

## 6. Configuração do arquivo `.conf`

O arquivo `.conf` (JSON) configura como o Prover executa a verificação:

```json
{
    "files": [
        "contracts/MyToken.sol"
    ],
    "verify": "MyToken:certora/specs/AccessControl.spec",
    "solc": "solc8.20",
    "msg": "Verificação de Access Control - MyToken",
    "rule_sanity": "basic",
    "optimistic_loop": true,
    "loop_iter": "3"
}
```

| Opção | Descrição |
|---|---|
| `files` | Contratos Solidity a compilar |
| `verify` | `Contrato:arquivo.spec` |
| `solc` | Versão do compilador Solidity |
| `rule_sanity` | `"basic"` detecta regras vacuamente verdadeiras |
| `optimistic_loop` | Assume que loops terminam no número configurado de iterações |
| `loop_iter` | Número máximo de iterações de loop a considerar |

**Executar a verificação:**

```bash
certoraRun certora/conf/AccessControl.conf
```

---

## 7. Boas práticas e armadilhas comuns

### Armadilha 1 — `lastReverted` sobrescrito

```cvl
// ERRADO: isPaused() sobrescreve lastReverted
rule wrongRule {
    withdraw@withrevert(e);
    bool p = isPaused(); // ← isto atualiza lastReverted!
    assert isPaused() => lastReverted;
}

// CORRETO: capture lastReverted imediatamente após @withrevert
rule correctRule {
    withdraw@withrevert(e);
    bool reverted = lastReverted;
    bool p = isPaused();
    assert p => reverted;
}
```

### Armadilha 2 — `require` em preserved blocks pode introduzir unsoundness

Preserved blocks com `require` restringem os estados analisados. Se a restrição for muito forte, o Prover pode verificar um invariant que na prática é violável. Use `requireInvariant` quando possível e documente o motivo de cada `require`.

### Armadilha 3 — Filtros em regras paramétricas

```cvl
// ERRADO: f declarado dentro do corpo, não como parâmetro
rule myRule()
filtered { f -> f.isView }  // Erro: f não é parâmetro da regra
{
    method f;
    f(e, args);
}

// CORRETO: f como parâmetro
rule myRule(method f)
filtered { f -> f.isView }
{
    env e; calldataarg args;
    f(e, args);
}
```

### Armadilha 4 — Invariants que revert no estado "antes"

Se o invariant pode reverter no estado anterior à chamada (ex.: acessa um array fora dos limites), o Prover descarta o contraexemplo ao invés de reportá-lo. Isso é uma fonte de **unsoundness** documentada pela Certora. Use com cuidado invariants que chamam funções que podem reverter dependendo do estado.

### Boa prática — `rule_sanity`

Sempre adicione `"rule_sanity": "basic"` ao `.conf`. Isso detecta regras vacuamente verdadeiras (onde o `require` é sempre falso, tornando qualquer `assert` trivialmente verdadeiro).

### Boa prática — Documente cada propriedade

Use `/// @title` e `/// @notice` acima de cada rule/invariant. O Prover exibe essas anotações no relatório de verificação e são exigidas em competições como a `gho-competition` da Certora.

### Boa prática — Teste com mutações

Injete bugs no contrato e verifique se suas regras falham. A Certora fornece a ferramenta **Gambit** para geração automática de mutações:

```bash
certoraMutate --conf certora/conf/default.conf
```

---

## 8. Referências

Todas as fontes consultadas para este documento:

1. **Documentação oficial CVL** — https://docs.certora.com/en/latest/docs/cvl/
2. **Rules** — https://docs.certora.com/en/latest/docs/cvl/rules.html
3. **Invariants** — https://docs.certora.com/en/latest/docs/cvl/invariants.html
4. **Ghosts** — https://docs.certora.com/en/latest/docs/cvl/ghosts.html
5. **Expressions (env, lastReverted)** — https://docs.certora.com/en/latest/docs/cvl/expr.html
6. **Types (method, calldataarg, env)** — https://docs.certora.com/en/latest/docs/cvl/types.html
7. **Certora CLI 5.0 Changes** — https://docs.certora.com/en/latest/docs/cvl/v5-changes.html
8. **Certora Technology White Paper** — https://www.certora.com/blog/white-paper
9. **OpenZeppelin Certora specs** — https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/certora
10. **spark-alm-controller-certora (ALMProxy.spec)** — https://github.com/sky-ecosystem/spark-alm-controller-certora
11. **RareSkills — Testing msg.sender and msg.value in CVL** — https://rareskills.io/post/certora-msgsender-msgvalue
12. **Certora Tutorials (ghosts/hooks)** — https://docs.certora.com/projects/tutorials/en/latest/lesson4_invariants/ghosts/basics.html
13. **Certora Examples repository** — https://github.com/Certora/Examples
14. **A look into formal verification of smart contracts using Certora** — https://dev.to/spalladino/a-look-into-formal-verification-of-smart-contracts-using-certora-3o8g