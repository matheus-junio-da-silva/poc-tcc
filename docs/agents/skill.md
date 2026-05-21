---
name: security-orchestrator
description: Orquestra a detecção de vulnerabilidades em contratos Solidity via Slither + Certora. Use quando o usuário informar um caminho de projeto Solidity e quiser detectar vulnerabilidades.
---

## QUANDO USAR
Detectar vulnerabilidades em contratos Solidity. O usuário passa:
- `project_path`: caminho da pasta do projeto Solidity
- `vuln_types`: lista de vulnerabilidades a checar (ex: ["access-control"]). Padrão: ["access-control"]

## REGRA ABSOLUTA
Nunca invente resultados. Nunca afirme que uma vulnerabilidade existe sem o contraexemplo do Certora. Nunca afirme que o contrato é seguro sem execução bem-sucedida do Certora.

---

## PASSO 1 — LER ESTRUTURA DO PROJETO

```bash
find {project_path} -name "*.sol" | grep -v node_modules | grep -v .git
```

Identifique:
- Contrato(s) principal(is): o mais derivado (herda dos outros)
- Versão do pragma Solidity (ex: ^0.8.20)
- Framework: presença de hardhat.config.*, foundry.toml, truffle-config.js

Se zero arquivos .sol encontrados → responda "Nenhum contrato Solidity encontrado em {project_path}" e pare.

---

## PASSO 2 — CHAMAR SLITHER ENRICHER

Para cada tipo de vulnerabilidade solicitada, chame o agente `slither-enricher` com:
```
project_path: {project_path}
vuln_type: {vuln_type}  # "access-control" | "reentrancy" | "overflow"
main_contract_file: {arquivo.sol}
```

O enricher retorna um `slither_context` estruturado. Guarde-o.

---

## PASSO 3 — CHAMAR AGENTE DE VULNERABILIDADE

Para cada `vuln_type`, chame o agente correspondente:
- "access-control" → agente `access-control-certora`
- "reentrancy"     → agente `reentrancy-certora` (futuro)
- "overflow"       → agente `overflow-certora` (futuro)

Passe apenas:
```
project_path: {project_path}
main_contract_file: {arquivo.sol}
slither_context: {resultado do enricher — NÃO a saída raw do terminal}
```

NÃO passe:
- Código-fonte completo do contrato (reduz tokens desnecessariamente)
- Saída raw do terminal do Slither
- Documentos de guia (o conhecimento já está no skill do agente)

---

## PASSO 4 — CONSOLIDAR RELATÓRIO

Receba o relatório de cada agente e monte o relatório final com:
1. Resumo executivo (vulnerabilidades encontradas / não encontradas)
2. Relatório detalhado por vulnerabilidade (vindo do agente)
3. Nota metodológica: "Verificação formal via Certora Prover — resultados matemáticos sobre todos os inputs possíveis"

---

## INCONCLUSIVO / ERRO

Se o agente de vulnerabilidade reportar erro irrecuperável:
- Informe o erro exato
- NÃO afirme que o contrato é seguro
- Sugira: verificar a versão do compilador, dependências do projeto

---

## CANDIDATES (auto-melhoria — preencher ao longo do uso)

| ID | Padrão | Ocorrências | Evidência | Data |
|----|--------|-------------|-----------|------|

## CONFIRMED PATTERNS
<!-- Promovido após ≥3 ocorrências com logs distintos -->

## DEPRECATED
<!-- Padrões que causaram falha após promoção -->
