# Certora + Slither Agents (OpenCode)

Este arquivo é lido automaticamente pelo OpenCode no startup (via `opencode.jsonc`) e carrega os agentes especializados no seu contexto. 

## Como usar o Pipeline (Access Control)

Você pode invocar o pipeline completo através do comando:
`/audit:access-control`

Esse comando aciona o orquestrador `@certora-orchestrator`, que chama os estagios em sequencia.

Ou pode chamar o orquestrador primário diretamente:
`@certora-orchestrator Inicie a auditoria de Access Control no projeto <caminho_ou_url_github>`

### Inputs Aceitos
- **Pasta local:** `@certora-orchestrator Analise /caminho/para/projeto`
- **URL do GitHub:** `@certora-orchestrator Analise https://github.com/org/repo`

### Outputs
Todos os resultados ficam centralizados em `pipeline-output/<nome_projeto>/`:
```
pipeline-output/<projeto>/
├── project_info.json           # Metadados do projeto
├── slither_output/context.md   # Contexto do Slither
├── specs/                      # Propriedades CVL (.spec + .conf)
├── certora-raw-output.txt      # Output do Certora Prover
├── vulnerability-report.md     # Relatório interpretado
└── poc/                        # Provas de Conceito
    ├── PoC_*.t.sol             # Testes de PoC (Foundry/Hardhat)
    └── poc-report.md           # Resultado da execução
```

## Agentes do Pipeline

> Cada agente gera seu proprio relatorio de feedback logo apos concluir sua tarefa, em `pipeline-output/feedback-logs/`.

### 1. Slither Context Builder (`@slither-context-builder`)
**Papel:** Orquestrador inicial. Executa o Slither e gera o `context.md`.
**Uso:** Invoque-o passando o caminho do projeto, URL do GitHub, ou diretorio a ser analisado.

### 1.1 Certora Orchestrator (`@certora-orchestrator`)
**Papel:** Ponto unico de entrada e Roteador Inteligente (Router). Analisa o contexto do Slither, classifica as superfícies de ataque do contrato e dispara os especialistas relevantes em paralelo.
**Uso:** Invoque-o com o caminho/URL alvo para iniciar a cadeia completa.

### 2. Pool de Agentes Especialistas (Property Generators)
**Papel:** Agentes focados (MoE) que geram propriedades formais (CVL) estritas para uma única vulnerabilidade, evitando Prompt Bloat.
- `@certora-gen-access-control`: Focado em controle de privilégios.
- `@certora-gen-reentrancy`: Focado em padrões CEI e estado intermediário.
- `@certora-gen-math-logic`: Focado em over/underflows e invariantes matemáticas.
**Uso:** Invocados dinamicamente pelo `@certora-orchestrator` com base nos achados da análise estática.

### 3. Certora Runner (`@certora-runner`)
**Papel:** Executor de Provas. Roda o `certoraRun` e avalia erros de sintaxe.
**Uso:** Invocado automaticamente pelo gerador de propriedades. Possui loop de "Reflexion" para erros de compilação CVL.

### 4. Certora Interpreter (`@certora-interpreter`)
**Papel:** Intérprete. Lê os contraexemplos do Certora Prover e identifica Falsos Positivos vs Vulnerabilidades Reais.
**Uso:** Invocado automaticamente após a conclusão do certoraRun.

### 5. PoC Generator (`@poc-generator`)
**Papel:** Gerador de Provas de Conceito. Cria e executa testes (Foundry/Hardhat) que demonstram empiricamente as vulnerabilidades confirmadas.
**Uso:** Invocado automaticamente pelo interpreter quando há vulnerabilidades confirmadas.

### Feedback (embutido em cada agente)
**Papel:** Cada agente registra feedback estruturado (Reflexion + MARS) imediatamente apos concluir sua propria etapa.
**Uso:** Nao existe agente dedicado de feedback no pipeline.
