---
description: DEPRECATED. Feedback agora e produzido por cada agente apos sua tarefa.
mode: subagent
model: anthropic/claude-sonnet-4-20250514
temperature: 0.2
permission:
  read: allow
---

DEPRECATED: Este agente NAO deve ser invocado no pipeline. Cada agente gera seu proprio relatorio de feedback logo apos concluir sua tarefa.

Use este arquivo apenas como referencia de template para feedback. Nao execute acoes, nao escreva arquivos, nao orquestre o pipeline.

## TEMPLATE DE RELATORIO (REFERENCIA)
Este template e o mesmo recomendado nos documentos de melhoria (Reflexion + MARS):

```markdown
# RELATÓRIO DE FEEDBACK DO AGENTE
**Data/Hora:** [YYYY-MM-DD HH:MM:SS]
**Contrato Analisado:** [nome]
**Tipo de Vulnerabilidade Alvo:** Access Control

---

## 1. RESUMO DA TAREFA
[Breve]

---

## 2. METODOLOGIA APLICADA
[O que ocorreu?]

---

## 3. ERROS ENCONTRADOS E COMO FORAM RESOLVIDOS
### 3.1 Erros de Compilação CVL
| Erro | Causa Identificada | Solução Aplicada |

### 3.2 Erros Semânticos (propriedade compilou mas não captura a vulnerabilidade)
| Propriedade | Problema Semântico | Reformulação Adotada |

### 3.3 Erros de Raciocínio (lógica equivocada sobre o contrato)
[Descreva]

---

## 4. PRINCÍPIOS VIOLADOS (Reflexão Baseada em Princípios)
- **Princípio [A]:** [regra geral quebrada]

---

## 5. ESTRATÉGIAS DE SUCESSO (Reflexão Procedural)
- [Passos que funcionaram e podem ser replicados]

---

## 6. CONHECIMENTO NÃO EXPLICITADO NAS INSTRUÇÕES
[O que foi descoberto na prática que não estava nas instruções dos agentes?]

---

## 7. DICAS PARA EXECUÇÕES FUTURAS
- [Recomendações acionáveis para o prompt]

---

## 8. AVALIAÇÃO DE QUALIDADE (Auto-Avaliação)
[Notas e justificativas]

---

## 9. CONTEXTO PARA CURADORIA HUMANA
- **Padrão de erro mais crítico desta execução:** [...]
- **Instrução de maior impacto que poderia evitar os problemas:** [...]
```
