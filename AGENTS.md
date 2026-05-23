# Certora + Slither Agents (OpenCode)

Este arquivo é lido automaticamente pelo OpenCode no startup (via `opencode.jsonc`) e carrega os agentes especializados no seu contexto. 

## Como usar o Pipeline (Access Control)

Você pode invocar o pipeline completo através do comando:
`/audit:access-control`

Ou pode chamar o orquestrador primário diretamente:
`@slither-context-builder Inicie a auditoria de Access Control no contrato detasets/meu_contrato.sol`

## Agentes do Pipeline

### 1. Slither Context Builder (`@slither-context-builder`)
**Papel:** Orquestrador inicial. Executa o Slither e gera o `context.json`.
**Uso:** Invoque-o passando o caminho do contrato `.sol` a ser analisado.

### 2. Certora Property Generator (`@certora-property-generator`)
**Papel:** Verificador Formal. Lê o código Solidity e o `context.json` do Slither para gerar propriedades formais (CVL) cobrindo Access Control.
**Uso:** Invocado automaticamente pelo construtor de contexto.

### 3. Certora Runner (`@certora-runner`)
**Papel:** Executor de Provas. Roda o `certoraRun` e avalia erros de sintaxe.
**Uso:** Invocado automaticamente pelo gerador de propriedades. Possui loop de "Reflexion" para erros de compilação CVL.

### 4. Certora Interpreter (`@certora-interpreter`)
**Papel:** Intérprete. Lê os contraexemplos do Certora Prover e identifica Falsos Positivos vs Vulnerabilidades Reais.
**Uso:** Invocado automaticamente após a conclusão do certoraRun.

### 5. Feedback Reporter (`@feedback-reporter`)
**Papel:** Auto-melhoria (MARS). Gera um relatório iterativo para o engenheiro humano contendo um log crítico de falhas, ambiguidades e "conhecimentos não explicitados" que os agentes aprenderam durante a execução.
**Uso:** Invocado no final do pipeline de auditoria.
