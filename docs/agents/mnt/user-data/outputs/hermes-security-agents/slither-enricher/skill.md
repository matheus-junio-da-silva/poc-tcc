---
name: slither-enricher
description: Executa printers específicos do Slither para enriquecer o contexto de um contrato Solidity. NÃO detecta vulnerabilidades — apenas coleta estrutura para o agente Certora.
---

## QUANDO USAR
Quando o orchestrator precisar de contexto estruturado de um contrato Solidity antes de criar propriedades Certora.

## REGRA ABSOLUTA
- Execute apenas printers. NÃO execute detectores para concluir vulnerabilidades.
- NÃO afirme que existe ou não existe vulnerabilidade com base no Slither.
- O output deve ser estruturado (JSON/tabela), não saída raw de terminal.

---

## SELEÇÃO DE PRINTERS POR VULNERABILIDADE

### access-control
```bash
slither {contract_file} --print vars-and-auth --json - 2>/dev/null
slither {contract_file} --print modifiers --json - 2>/dev/null
slither {contract_file} --print function-summary --json - 2>/dev/null
slither {contract_file} --print require --json - 2>/dev/null
slither {contract_file} --print inheritance --json - 2>/dev/null
```

Justificativa de cada printer:
- `vars-and-auth`: mostra exatamente quais variáveis cada função ESCREVE e quais checks de msg.sender existem → ponto de partida direto para propriedades CVL
- `modifiers`: mostra quais modifiers cada função usa → identifica onlyOwner, onlyRole, etc.
- `function-summary`: visibilidade, modifiers, leituras/escritas de state variables → identifica funções críticas sem proteção
- `require`: lista todos os require/assert → identifica controles de acesso feitos inline
- `inheritance`: hierarquia de herança → acesso herdado de contratos pai

### reentrancy (futuro)
```bash
slither {contract_file} --print call-graph --json - 2>/dev/null
slither {contract_file} --print function-summary --json - 2>/dev/null
slither {contract_file} --print data-dependency --json - 2>/dev/null
```

### overflow (futuro)
```bash
slither {contract_file} --print slithir --json - 2>/dev/null
slither {contract_file} --print function-summary --json - 2>/dev/null
slither {contract_file} --print data-dependency --json - 2>/dev/null
```

---

## PRINTERS NÃO USADOS E POR QUÊ

| Printer | Motivo de exclusão para access-control |
|---------|----------------------------------------|
| `cfg` | CFG por função é verboso demais; não acrescenta para AC |
| `slithir` | Representação IR desnecessária para AC |
| `evm` | Bytecode EVM é irrelevante para propriedades CVL |
| `echidna` | Para fuzzing, não verificação formal |
| `call-graph` | Útil para reentrância, não para AC |
| `data-dependency` | Útil para overflow/reentrância, não para AC |
| `human-summary` | Informativo mas não acionável para CVL |
| `loc` | Métrica de código, irrelevante |

---

## EXECUÇÃO

Se o projeto usar framework (hardhat/foundry), execute na raiz:
```bash
cd {project_path}
slither . --print vars-and-auth,modifiers,function-summary,require,inheritance \
  --exclude-dependencies \
  --json slither_output.json 2>/dev/null
```

Se arquivo único:
```bash
slither {contract_file} --print vars-and-auth,modifiers,function-summary,require,inheritance \
  --exclude-dependencies \
  --json slither_output.json 2>/dev/null
```

Se Slither não estiver instalado:
```bash
pip install slither-analyzer --quiet
```

Se a versão do solc for incompatível:
```bash
pip install solc-select --quiet
solc-select install {version_from_pragma}
solc-select use {version_from_pragma}
```

---

## OUTPUT ESTRUTURADO OBRIGATÓRIO

Após executar, NÃO retorne a saída raw. Extraia e retorne este JSON compacto:

```json
{
  "contracts": ["NomeContrato1", "NomeContrato2"],
  "pragma_version": "0.8.20",
  "functions": [
    {
      "name": "mint",
      "visibility": "public",
      "modifiers": ["onlyOwner"],
      "state_vars_written": ["_balances", "_totalSupply"],
      "msg_sender_checks": ["require(msg.sender == owner())"],
      "require_statements": ["require(amount > 0)"]
    }
  ],
  "state_variables": [
    { "name": "owner", "type": "address", "visibility": "private" },
    { "name": "_roles", "type": "mapping(bytes32 => RoleData)", "visibility": "private" }
  ],
  "inheritance": ["Ownable", "ERC20", "Pausable"],
  "access_control_pattern": "ownable | rbac | custom | none",
  "privileged_functions": ["mint", "burn", "pause", "transferOwnership", "grantRole"]
}
```

Campos obrigatórios: `contracts`, `pragma_version`, `functions`, `state_variables`, `privileged_functions`.
Campo `access_control_pattern`: preencher com base nos modifiers/require encontrados.

---

## CANDIDATES

| ID | Padrão | Ocorrências | Evidência | Data |
|----|--------|-------------|-----------|------|

## CONFIRMED PATTERNS

## DEPRECATED
