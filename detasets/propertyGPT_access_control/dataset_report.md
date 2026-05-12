# Access Control Dataset — PropertyGPT

**Gerado em:** 2026-05-12 16:36 UTC
**Fonte:** `certora_projects/`

## Resumo Geral

| Metrica | Valor |
|---------|-------|
| Projetos com Access Control | **21** |
| Contratos AC copiados       | **200** |
| Specs relacionadas a AC     | **53** |
| Specs outras                | **84** |

## Padroes de Access Control Detectados (global)

| Padrao | Ocorrencias |
|--------|-------------|
| `ROLE_constant` | 62 |
| `auth_modifier` | 33 |
| `onlyOwner` | 19 |
| `Ownable` | 15 |
| `Managed_contract` | 8 |
| `onlyAdmin` | 5 |
| `AccessControl_OZ` | 4 |
| `onlyRole` | 4 |
| `grantRole` | 4 |
| `revokeRole` | 4 |
| `hasRole` | 3 |
| `AccessControlEnumerable` | 3 |
| `onlyGuardian` | 2 |
| `onlyGovernor` | 1 |

## Projetos Incluidos no Dataset

| Projeto | Contratos AC | Specs AC | Padroes |
|---------|-------------|----------|---------|
| **aave_l2_bridge** | 6 | 2 | `auth_modifier`, `onlyGuardian`, `Ownable`, `onlyOwner` |
| **aave_proof_of_reserve** | 2 | 0 | `Ownable`, `onlyOwner` |
| **aave_rescue_mission** | 1 | 0 | `Ownable`, `onlyOwner` |
| **aave_staked_token** | 2 | 1 | `onlyOwner`, `auth_modifier`, `ROLE_constant` |
| **aave_starknet_bridge** | 1 | 0 | `onlyAdmin`, `auth_modifier` |
| **aave_v2** | 16 | 0 | `Ownable`, `onlyOwner`, `auth_modifier`, `Managed_contract` |
| **aave_v3** | 17 | 2 | `AccessControl_OZ`, `onlyRole`, `hasRole`, `grantRole`, `revokeRole`, `ROLE_constant`, `AccessControlEnumerable`, `Managed_contract`, `Ownable`, `onlyOwner`, `auth_modifier` |
| **aave_vault** | 1 | 2 | `onlyOwner` |
| **celo_governance** | 34 | 7 | `Ownable`, `onlyOwner`, `onlyGuardian`, `auth_modifier` |
| **furucombo** | 13 | 6 | `Ownable`, `onlyOwner`, `auth_modifier` |
| **gho-core** | 3 | 3 | `Ownable`, `onlyOwner`, `auth_modifier`, `AccessControl_OZ`, `onlyRole`, `ROLE_constant` |
| **keep_fully** | 5 | 1 | `onlyOwner`, `auth_modifier`, `onlyAdmin`, `Managed_contract` |
| **lido_v2** | 16 | 0 | `onlyRole`, `ROLE_constant`, `AccessControlEnumerable`, `onlyOwner`, `auth_modifier`, `AccessControl_OZ`, `hasRole`, `onlyAdmin`, `grantRole`, `revokeRole`, `Managed_contract` |
| **notional_finance_v2** | 2 | 2 | `Ownable`, `onlyOwner`, `auth_modifier`, `grantRole`, `revokeRole`, `ROLE_constant` |
| **openzepplin** | 26 | 7 | `AccessControl_OZ`, `onlyRole`, `hasRole`, `grantRole`, `revokeRole`, `ROLE_constant`, `AccessControlEnumerable`, `Managed_contract`, `Ownable`, `onlyOwner`, `auth_modifier` |
| **opyn_gamma_protocol** | 10 | 5 | `Ownable`, `onlyOwner`, `auth_modifier` |
| **ousd** | 20 | 4 | `onlyGovernor`, `Ownable`, `auth_modifier`, `onlyAdmin`, `onlyOwner` |
| **popsicle_v3_optimizer** | 6 | 1 | `auth_modifier` |
| **radicle_drips** | 3 | 1 | `Managed_contract`, `onlyAdmin`, `auth_modifier`, `Ownable`, `onlyOwner` |
| **rocket_joe** | 6 | 5 | `Ownable`, `onlyOwner` |
| **sushi_benttobox** | 10 | 4 | `onlyOwner`, `Ownable`, `auth_modifier`, `Managed_contract` |

## Estrutura do Dataset

```
access_control_dataset/
  <project>/
    contracts/              <- .sol com access control
      access_control/       <- specs de access control
      other/                <- demais specs
    metadata.json           <- metadados do projeto
  dataset_summary.json      <- resumo geral
  dataset_report.md         <- este relatorio
```

## Detalhe por Projeto

### aave_l2_bridge

- **Contratos com AC:** 6
- **Specs de AC:** 2
- **Padroes:** `auth_modifier`, `onlyGuardian`, `Ownable`, `onlyOwner`

### aave_proof_of_reserve

- **Contratos com AC:** 2
- **Specs de AC:** 0
- **Padroes:** `Ownable`, `onlyOwner`

### aave_rescue_mission

- **Contratos com AC:** 1
- **Specs de AC:** 0
- **Padroes:** `Ownable`, `onlyOwner`

### aave_staked_token

- **Contratos com AC:** 2
- **Specs de AC:** 1
- **Padroes:** `onlyOwner`, `auth_modifier`, `ROLE_constant`

### aave_starknet_bridge

- **Contratos com AC:** 1
- **Specs de AC:** 0
- **Padroes:** `onlyAdmin`, `auth_modifier`

### aave_v2

- **Contratos com AC:** 16
- **Specs de AC:** 0
- **Padroes:** `Ownable`, `onlyOwner`, `auth_modifier`, `Managed_contract`

### aave_v3

- **Contratos com AC:** 17
- **Specs de AC:** 2
- **Padroes:** `AccessControl_OZ`, `onlyRole`, `hasRole`, `grantRole`, `revokeRole`, `ROLE_constant`, `AccessControlEnumerable`, `Managed_contract`, `Ownable`, `onlyOwner`, `auth_modifier`

### aave_vault

- **Contratos com AC:** 1
- **Specs de AC:** 2
- **Padroes:** `onlyOwner`

### celo_governance

- **Contratos com AC:** 34
- **Specs de AC:** 7
- **Padroes:** `Ownable`, `onlyOwner`, `onlyGuardian`, `auth_modifier`

### furucombo

- **Contratos com AC:** 13
- **Specs de AC:** 6
- **Padroes:** `Ownable`, `onlyOwner`, `auth_modifier`

### gho-core

- **Contratos com AC:** 3
- **Specs de AC:** 3
- **Padroes:** `Ownable`, `onlyOwner`, `auth_modifier`, `AccessControl_OZ`, `onlyRole`, `ROLE_constant`

### keep_fully

- **Contratos com AC:** 5
- **Specs de AC:** 1
- **Padroes:** `onlyOwner`, `auth_modifier`, `onlyAdmin`, `Managed_contract`

### lido_v2

- **Contratos com AC:** 16
- **Specs de AC:** 0
- **Padroes:** `onlyRole`, `ROLE_constant`, `AccessControlEnumerable`, `onlyOwner`, `auth_modifier`, `AccessControl_OZ`, `hasRole`, `onlyAdmin`, `grantRole`, `revokeRole`, `Managed_contract`

### notional_finance_v2

- **Contratos com AC:** 2
- **Specs de AC:** 2
- **Padroes:** `Ownable`, `onlyOwner`, `auth_modifier`, `grantRole`, `revokeRole`, `ROLE_constant`

### openzepplin

- **Contratos com AC:** 26
- **Specs de AC:** 7
- **Padroes:** `AccessControl_OZ`, `onlyRole`, `hasRole`, `grantRole`, `revokeRole`, `ROLE_constant`, `AccessControlEnumerable`, `Managed_contract`, `Ownable`, `onlyOwner`, `auth_modifier`

### opyn_gamma_protocol

- **Contratos com AC:** 10
- **Specs de AC:** 5
- **Padroes:** `Ownable`, `onlyOwner`, `auth_modifier`

### ousd

- **Contratos com AC:** 20
- **Specs de AC:** 4
- **Padroes:** `onlyGovernor`, `Ownable`, `auth_modifier`, `onlyAdmin`, `onlyOwner`

### popsicle_v3_optimizer

- **Contratos com AC:** 6
- **Specs de AC:** 1
- **Padroes:** `auth_modifier`

### radicle_drips

- **Contratos com AC:** 3
- **Specs de AC:** 1
- **Padroes:** `Managed_contract`, `onlyAdmin`, `auth_modifier`, `Ownable`, `onlyOwner`

### rocket_joe

- **Contratos com AC:** 6
- **Specs de AC:** 5
- **Padroes:** `Ownable`, `onlyOwner`

### sushi_benttobox

- **Contratos com AC:** 10
- **Specs de AC:** 4
- **Padroes:** `onlyOwner`, `Ownable`, `auth_modifier`, `Managed_contract`
