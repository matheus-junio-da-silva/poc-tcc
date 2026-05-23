---
description: "BMad Method skills - use bmad-help to get started, or invoke any skill by name (bmad-help, bmad-prd, bmad-architecture, bmad-dev-story, etc.)"
---

# BMad Method Skills

All BMad skills are available. Use the skill name to invoke them.

## Core Skills
- `bmad-help` — Analyzes project state and recommends next steps
- `bmad-brainstorming` — Facilita sessões de ideação
- `bmad-advanced-elicitation` — Aprofunda análise crítica

## Planning (BMad Method)
- `bmad-product-brief` — Brief do produto
- `bmad-prfaq` — Working Backwards (PR/FAQ)
- `bmad-prd` — Product Requirements Document
- `bmad-architecture` — Documento de arquitetura
- `bmad-ux` — UX e fluxos de usuário

## Implementation
- `bmad-sm` — Scrum Master — sprint planning e histórias
- `bmad-dev-story` — Implementar uma história
- `bmad-quick-dev` — Desenvolvimento rápido (Quick Flow)
- `bmad-code-review` — Code review
- `bmad-qa-generate-e2e-tests` — Gerar testes E2E

## Reference
- Skills location: `_bmad/`
- Output artifacts: `_bmad-output/`
- Custom agents: `.opencode/agents/`

## Certora Pipeline Agents
- `@slither-context-builder` — Orquestra Slither e gera `context.json`
- `@certora-property-generator` — Gera specs CVL e `.conf`
- `@certora-runner` — Executa certoraRun
- `@certora-interpreter` — Interpreta resultados e gera relatorio

## Feedback
Cada agente gera seu proprio relatorio de feedback logo apos concluir sua etapa, em `_bmad-output/feedback-logs/`.
