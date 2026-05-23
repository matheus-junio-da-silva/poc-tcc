# Melhoria de Agentes de IA: Revisão da Literatura e Estrutura Ótima de Feedback

> **Contexto de aplicação:** Agentes BMAD + OpenCode para geração de especificações formais (propriedades Certora) voltadas à detecção de vulnerabilidades em contratos inteligentes Solidity.

---

## Sumário

1. [O Problema: Por que Agentes Estáticos Falham](#1-o-problema)
2. [Principais Frameworks de Auto-Melhoria na Literatura](#2-frameworks)
   - 2.1 Reflexion — Aprendizado Verbal por Reforço
   - 2.2 Self-Refine — Refinamento Iterativo com Auto-Feedback
   - 2.3 MARS — Reflexão Metacognitiva
   - 2.4 MARS Memory-Enhanced — Memória + Reflexão
   - 2.5 PropertyGPT — Agentes + Verificação Formal (Certora)
   - 2.6 ReAct — Pensamento-Ação-Observação
   - 2.7 HITL (Human-in-the-Loop) e Curadoria Humana de Feedback
3. [O que os Estudos Dizem sobre Estrutura de Relatório de Feedback](#3-estrutura-feedback)
4. [Template de Relatório de Feedback para o Agente](#4-template)
5. [Prompt de Instrução para o Agente Gerar o Relatório](#5-prompt)
6. [Ciclo Recomendado de Curadoria Humana (5–10 Execuções)](#6-ciclo)
7. [Referências](#7-referencias)

---

## 1. O Problema: Por que Agentes Estáticos Falham {#1-o-problema}

A literatura recente é uniforme em um diagnóstico central: agentes LLM modernos são construídos sobre **componentes estáticos** — prompts fixos escritos manualmente, fluxos de trabalho predefinidos e configurações imutáveis — o que limita drasticamente sua adaptabilidade a estratégias que fogem da intuição humana original de quem os criou (MARS, arXiv 2601.11974, 2026).

Três limitações estruturais se repetem nos estudos:

| Limitação | Consequência Prática |
|---|---|
| Prompts fixos não capturam exceções reais | O agente repete os mesmos erros em casos-limite |
| Ausência de memória episódica persistente | Cada execução começa do zero, sem acúmulo de experiência |
| Feedback binário (sucesso/falha) é insuficiente | O agente não sabe *por que* falhou nem *como* corrigir |

Para o contexto específico de geração de propriedades formais para o Certora Prover, o PropertyGPT (Liu et al., NDSS 2025) documenta que a principal barreira não é a capacidade de gerar propriedades, mas a ausência de um **oráculo externo de feedback estruturado** que guie revisões iterativas quando uma propriedade falha em compilar ou é semanticamente inadequada.

---

## 2. Principais Frameworks de Auto-Melhoria na Literatura {#2-frameworks}

### 2.1 Reflexion — Aprendizado Verbal por Reforço
**Shinn et al., NeurIPS 2023 | arXiv 2303.11366**

O Reflexion é o framework fundacional mais citado. Ele propõe que o agente não precisa de fine-tuning de pesos para aprender: basta **converter sinais de feedback em linguagem natural** e armazená-los em um buffer de memória episódica.

**Arquitetura central:**
```
Actor (executa) → Evaluator (pontua) → Self-Reflection (gera resumo verbal) → Memory (armazena) → Actor (próxima tentativa)
```

O ponto crítico do Reflexion é que o Self-Reflection model analisa o par `{trajetória, recompensa}` e produz um **resumo semântico** (`sr`) que aponta **a direção concreta de melhoria**. Esse resumo age como um "gradiente semântico" — em vez de atualizar parâmetros, atualiza o *contexto* do próximo prompt.

> *"Generating useful reflective feedback is challenging since it requires a good understanding of where the model made mistakes (the credit assignment problem) as well as the ability to generate a summary containing **actionable insights** for improvement."*
> — Shinn et al., 2023

**Implicação para o seu caso:** O agente precisa ser instruído a identificar **exatamente em qual etapa** (análise do contrato, escolha do tipo de propriedade, sintaxe CVL, execução no Certora) o erro ocorreu — não apenas que algo saiu errado.

---

### 2.2 Self-Refine — Refinamento Iterativo com Auto-Feedback
**Madaan et al., 2023 | arXiv 2303.17651**

O Self-Refine introduz um loop onde o próprio LLM gera **crítica estruturada** de sua saída e a usa para refinamento. Diferente do Reflexion (que usa memória entre episódios), o Self-Refine opera dentro de uma única sessão.

**Estrutura do feedback gerado:**
1. **O que está errado** (critique): identificação específica do problema
2. **Por que está errado** (rationale): causa raiz
3. **Como corrigir** (suggestion): instrução acionável

**Limitação documentada:** O Self-Refine é mais eficaz em tarefas de raciocínio single-step. Para agentes multi-etapa como o seu (análise → síntese de propriedade → compilação → verificação), o Reflexion com memória persistente é superior.

---

### 2.3 MARS — Reflexão Metacognitiva
**arXiv 2601.11974, Janeiro 2026 (mais recente)**

O MARS (Metacognitive Agent with Reflective Self-improvement) é o framework mais avançado neste levantamento. Inspirado em psicologia educacional, ele distingue **dois tipos complementares de reflexão**:

#### Reflexão Baseada em Princípios (Principle-Based Reflection)
- Abstrai **regras normativas** a partir das falhas
- Responde: *"Qual princípio geral eu violei?"*
- Exemplo para Certora: *"Propriedades de invariante nunca devem assumir estado intermediário entre chamadas externas"*

#### Reflexão Procedural (Procedural Reflection)
- Deriva **estratégias passo-a-passo** para o sucesso
- Responde: *"Qual sequência de ações levou ao resultado correto?"*
- Exemplo para Certora: *"Primeiro verificar o tipo de vulnerabilidade → mapear para categoria de propriedade CVL → gerar esqueleto → validar compilação → refinar semântica"*

> *"MARS mimics human learning by integrating principle-based reflection (abstracting normative rules to avoid errors) and procedural reflection (deriving step-by-step strategies for success). By synthesizing these insights into optimized instructions, MARS allows agents to systematically refine their reasoning logic without continuous online feedback."*
> — arXiv 2601.11974, 2026

**Resultado:** MARS supera sistemas state-of-the-art de auto-evolução com **menor custo computacional** ao completar o ciclo de reflexão em um único passo recursivo.

---

### 2.4 MARS Memory-Enhanced — Memória + Reflexão
**Liang et al., arXiv 2503.19271, Março 2025**

Esta variante do MARS adiciona um **mecanismo de otimização de memória baseado na curva de esquecimento de Ebbinghaus** — o agente retém seletivamente informações críticas, priorizando erros recentes e padrões recorrentes.

**Três componentes:**
1. **Armazenamento de memória** de experiências passadas (ações + resultados)
2. **Reflexão** sobre essas experiências para extração de aprendizado
3. **Aplicação** dos insights em novas tarefas

**Resultado empírico:** Melhoria de até 2,26× no benchmark AgentBench para GPT-3.5/4 e entre 57,7% e 100% em modelos open-source.

**Implicação prática:** Para o ciclo de 5–10 execuções que você planeja, os relatórios mais antigos devem ter peso menor na curadoria, e os padrões de erro **recorrentes** devem ter prioridade máxima.

---

### 2.5 PropertyGPT — Agentes + Verificação Formal (Certora)
**Liu et al., NDSS Symposium 2025 | arXiv 2405.02580**

Este é o trabalho mais diretamente relevante para o seu contexto. O PropertyGPT usa LLMs para gerar propriedades formais automaticamente para contratos Solidity verificados via Certora, e documenta um **loop de feedback iterativo estruturado em três camadas**:

1. **Feedback de compilação** (oráculo externo): erros sintáticos CVL são retornados ao LLM para revisão
2. **Feedback de adequação semântica**: ranqueamento por similaridade multi-dimensional com propriedades de referência (base de conhecimento de 623 propriedades de 23 projetos Certora)
3. **Feedback do prover**: verificação formal da correção das propriedades geradas

> *"We use the compilation and static analysis feedback as an external oracle to guide LLMs in iteratively revising the generated properties."*
> — Liu et al., NDSS 2025

**Resultado:** 80% de recall vs. ground truth humano; detecção de 26 CVEs de 37 testadas; descoberta de 12 vulnerabilidades zero-day.

**Implicação para o seu agente:** Cada execução deve registrar explicitamente quais erros de compilação CVL ocorreram, quais revisar resolveu, e quais tipos de propriedade (invariante, pré/pós-condição, regra) foram mais problemáticos para o contrato analisado.

---

### 2.6 ReAct — Pensamento-Ação-Observação
**Yao et al., 2023**

O ReAct estrutura o raciocínio do agente em ciclos explícitos de:
- **Thought** (raciocínio interno)
- **Action** (ação no ambiente)
- **Observation** (feedback do ambiente)

Para geração de logs de feedback, o ReAct sugere que o agente **externalize seu raciocínio em cada etapa**, tornando auditável exatamente onde o processo divergiu do esperado. O Prompt Engineering Guide da DAIR.AI (2024) recomenda esse padrão como base para qualquer sistema que precise de rastreabilidade de erros.

---

### 2.7 HITL (Human-in-the-Loop) e Curadoria Humana de Feedback
**Google Cloud CTO Office, Dezembro 2025**

O relatório do Google Cloud sobre lições de 2025 com agentes documenta que o padrão mais robusto para melhoria iterativa é o uso de **autoraters** (um LLM como juiz) para avaliação em tempo real, combinado com curadoria humana periódica. A equipe documenta:

> *"Real-time autoraters catch and fix errors at the source, before they cascade. Even for tasks without objectively right answers, autoraters predict likely errors and iteratively fix them for higher overall quality."*
> — Google Cloud CTO Office, 2025

Para o ciclo que você planeja (5–10 relatórios → curadoria → melhoria do agente), isso valida que a abordagem mais eficaz é **a acumulação de feedback estruturado dos próprios agentes**, com posterior síntese humana — exatamente o que você propõe.

---

## 3. O que os Estudos Dizem sobre a Estrutura de Relatório de Feedback {#3-estrutura-feedback}

A partir da síntese dos frameworks acima, os estudos convergem para **seis dimensões essenciais** que um relatório de feedback de agente deve cobrir:

| # | Dimensão | Base Científica | Pergunta Central |
|---|---|---|---|
| 1 | **Identificação da falha** | Reflexion (credit assignment problem) | *Onde exatamente o processo falhou?* |
| 2 | **Causa raiz** | Self-Refine (rationale), ReAct (thought) | *Por que falhou? Ambiguidade? Limite do modelo? Dado insuficiente?* |
| 3 | **Regra/princípio violado** | MARS principle-based reflection | *Qual regra normativa geral foi ignorada ou desconhecida?* |
| 4 | **Estratégia bem-sucedida** | MARS procedural reflection | *Qual sequência de ações funcionou? Pode ser reproduzida?* |
| 5 | **Conhecimento não explicitado** | PropertyGPT (in-context learning gaps) | *O que o agente precisou descobrir que não estava nas instruções?* |
| 6 | **Recomendação para instrução futura** | Reflexion episodic memory, MARS synthesis | *O que deve ser adicionado/alterado no prompt do agente?* |

O estudo de Self-Reflection in LLM Agents (arXiv 2405.06682) adiciona uma observação crítica: **mesmo o simples conhecimento de que houve erro melhora o desempenho na tentativa seguinte**. Isso reforça que o relatório não precisa ser perfeito — mas precisa ser estruturado o suficiente para que o curador humano identifique padrões entre execuções.

---

## 4. Template de Relatório de Feedback para o Agente {#4-template}

Este template é derivado diretamente dos frameworks Reflexion, MARS e PropertyGPT, adaptado ao contexto de geração de propriedades Certora para contratos Solidity.

---

```markdown
# RELATÓRIO DE FEEDBACK DO AGENTE
**Execução nº:** [N]
**Data:** [YYYY-MM-DD]
**Contrato Analisado:** [nome/endereço]
**Tipo de Vulnerabilidade Alvo:** [ex: reentrancy, overflow, access control]

---

## 1. RESUMO DA TAREFA
> Descreva em 3–5 linhas o que foi solicitado, o contrato analisado e o resultado final (sucesso/falha parcial/falha).

---

## 2. METODOLOGIA APLICADA
> Descreva a abordagem adotada passo a passo:
- Como você interpretou o contrato?
- Qual tipo de propriedade foi escolhido (invariante, pré/pós-condição, regra)?
- Qual foi a estratégia de mapeamento vulnerabilidade → propriedade CVL?
- Quantas iterações de revisão foram necessárias?

---

## 3. ERROS ENCONTRADOS E COMO FORAM RESOLVIDOS

### 3.1 Erros de Compilação CVL
| Erro | Causa Identificada | Solução Aplicada |
|---|---|---|
| [ex: variável não declarada] | [ex: escopo de função ignorado] | [ex: adicionar `address currentUser` no ghost] |

### 3.2 Erros Semânticos (propriedade compilou mas não captura a vulnerabilidade)
| Propriedade | Problema Semântico | Reformulação Adotada |
|---|---|---|
| [descreva] | [descreva] | [descreva] |

### 3.3 Erros de Raciocínio (lógica equivocada sobre o contrato)
> Descreva qualquer interpretação errada do contrato que levou à geração de propriedades inadequadas.

---

## 4. PRINCÍPIOS VIOLADOS (Reflexão Baseada em Princípios)
> Liste as regras normativas que foram violadas ou desconhecidas:
- **Princípio [A]:** [ex: "Propriedades de invariante não devem assumir estado entre chamadas cross-contract"]
- **Princípio [B]:** [ex: "Funções com modificador `onlyOwner` exigem verificação de acesso no precondition, não no body"]

---

## 5. ESTRATÉGIAS DE SUCESSO (Reflexão Procedural)
> Descreva as sequências de ações que funcionaram e podem ser replicadas:
- **Para este tipo de vulnerabilidade:** [passo 1 → passo 2 → passo 3]
- **Para este padrão de contrato:** [ex: contratos com herança múltipla exigem X antes de Y]

---

## 6. CONHECIMENTO NÃO EXPLICITADO NAS INSTRUÇÕES
> Liste o que você precisou descobrir durante a execução que NÃO estava no prompt do agente:
- [ex: "O Certora Prover rejeita `require` dentro de `rule` quando há `havoc` implícito — isso não estava documentado nas instruções"]
- [ex: "Contratos com `delegatecall` exigem modelagem explícita do storage layout"]

---

## 7. DICAS PARA EXECUÇÕES FUTURAS
> Liste recomendações concretas e acionáveis:
- [ ] [ex: "Antes de gerar a propriedade, verificar se o contrato usa proxy pattern — isso muda completamente a abordagem"]
- [ ] [ex: "Para vulnerabilidades de reentrancy, começar sempre com `sinvoke` em vez de `invoke`"]
- [ ] [ex: "Adicionar verificação de compatibilidade de versão do Certora CLI antes de qualquer compilação"]

---

## 8. AVALIAÇÃO DE QUALIDADE (Auto-Avaliação)
| Critério | Nota (1–5) | Justificativa |
|---|---|---|
| Cobertura da vulnerabilidade | [N] | [justifique] |
| Qualidade sintática das propriedades CVL | [N] | [justifique] |
| Eficiência do processo (nº de iterações) | [N] | [justifique] |
| Confiança no resultado final | [N] | [justifique] |

---

## 9. CONTEXTO PARA CURADORIA HUMANA
> Esta seção é dirigida ao engenheiro que irá revisar este relatório junto com outros 4–9 relatórios:
- **Padrão de erro mais crítico desta execução:** [descreva em 1 linha]
- **Instrução de maior impacto que poderia evitar os problemas:** [descreva em 1–2 linhas]
- **Tipo de contrato/vulnerabilidade que mais desafiou o agente:** [descreva]
```

---

## 5. Prompt de Instrução para o Agente Gerar o Relatório {#5-prompt}

Baseado na estrutura do MARS (princípios + procedimentos) e no mecanismo de Self-Reflection do Reflexion, o seguinte prompt deve ser adicionado ao final do fluxo do agente, **após a conclusão da tarefa principal**:

---

```
## INSTRUÇÃO FINAL: RELATÓRIO DE FEEDBACK

Após concluir a geração das propriedades formais para o Certora Prover, você deve produzir um 
relatório de feedback estruturado em Markdown. Este relatório NÃO é para você mesmo — é para 
o engenheiro humano que irá usar múltiplos relatórios como este para melhorar suas instruções.

Siga rigorosamente o template abaixo. Seja específico, não genérico. Prefira exemplos reais 
do que você enfrentou nesta execução a afirmações abstratas.

### Diretrizes de qualidade para o relatório:

1. **Seja preciso na seção de erros** (Seção 3): Não diga "houve erros de compilação". 
   Diga qual erro, em qual propriedade, qual linha, qual foi a causa e como foi corrigido.

2. **Seja normativo nos princípios** (Seção 4): Formule como regras explícitas no estilo 
   "SEMPRE [X] quando [condição Y]" ou "NUNCA [X] porque [razão Z]".

3. **Seja reproduzível nas estratégias** (Seção 5): Descreva passos numerados que outro 
   agente poderia seguir sem ambiguidade.

4. **Seja honesto no conhecimento não explicitado** (Seção 6): Esta é a seção mais valiosa 
   para melhoria do agente. Liste tudo que você descobriu "na prática" e que não estava 
   escrito nas suas instruções. Não omita nada por achar que é óbvio.

5. **Seção 9 é crítica**: Sintetize o mais importante em até 3 linhas para facilitar 
   a curadoria humana.

Produza o relatório em Markdown, começando com o cabeçalho `# RELATÓRIO DE FEEDBACK DO AGENTE`.
```

---

## 6. Ciclo Recomendado de Curadoria Humana (5–10 Execuções) {#6-ciclo}

Com base nos princípios do MARS Memory-Enhanced (curva de Ebbinghaus) e nas lições do Google Cloud (2025), o ciclo de melhoria recomendado é:

```
Execução 1–10
     ↓
Agente gera Relatório de Feedback (template Seção 4)
     ↓
Curador Humano coleta os N relatórios
     ↓
Identificação de padrões:
  - Erros que aparecem em ≥3 execuções → prioridade ALTA para correção
  - Princípios ausentes mais citados → candidatos a novas instruções
  - Estratégias de sucesso consistentes → candidatos a exemplos no prompt
     ↓
Síntese: "Nota de Melhoria do Agente" (documento separado)
     ↓
Atualização do prompt/agente
     ↓
Nova rodada de execuções
```

**Critérios de priorização para a curadoria:**

| Prioridade | Critério |
|---|---|
| 🔴 Alta | Erro que ocorreu em ≥50% das execuções |
| 🟡 Média | Conhecimento não explicitado mencionado por ≥2 agentes |
| 🟢 Baixa | Dica de otimização de eficiência (não afeta correção) |

---

## 7. Referências {#7-referencias}

> Todos os trabalhos foram verificados em buscas realizadas em maio de 2026. Apenas fontes primárias (arXiv, ACL Anthology, NDSS, NeurIPS, Nature) ou documentação técnica oficial foram utilizadas.

1. **Shinn, N., Cassano, F., Berman, E., Gopinath, A., Narasimhan, K., & Yao, S.** (2023). *Reflexion: Language Agents with Verbal Reinforcement Learning*. NeurIPS 2023. arXiv:2303.11366.

2. **Madaan, A., Tandon, N., Gupta, P. et al.** (2023). *Self-Refine: Iterative Refinement with Self-Feedback*. arXiv:2303.17651.

3. **MARS (Metacognitive Agent Reflective Self-improvement)** (2026). *Learn Like Humans: Use Meta-cognitive Reflection for Efficient Self-Improvement*. arXiv:2601.11974.

4. **Liang, X., Tao, M., Xia, Y. et al.** (2025). *MARS: Memory-Enhanced Agents with Reflective Self-improvement*. arXiv:2503.19271.

5. **Liu, Y., Xue, Y., Wu, D., Sun, Y., Li, Y., Shi, M., & Liu, Y.** (2025). *PropertyGPT: LLM-driven Formal Verification of Smart Contracts through Retrieval-Augmented Property Generation*. NDSS Symposium 2025. arXiv:2405.02580.

6. **Yao, S. et al.** (2023). *ReAct: Synergizing Reasoning and Acting in Language Models*. ICLR 2023.

7. **Pan, L. et al.** (2023). *Automatically Correcting Large Language Models: Surveying the Landscape of Diverse Self-Correction Strategies*. arXiv:2308.03188.

8. **Google Cloud Office of the CTO** (2025). *Lessons from 2025 on Agents and Trust*. Google Cloud Blog, Dezembro 2025.

9. **Self-Reflection in LLM Agents: Effects on Problem-Solving Performance** (2024). arXiv:2405.06682.

10. **ICLR 2026 Workshop on AI with Recursive Self-Improvement** (2026). Workshop Summary. OpenReview.

11. **Yuan, W. et al.** (2024). *Self-Rewarding Language Models*. arXiv:2401.10020.

---

*Documento gerado com base em pesquisa de literatura científica — maio de 2026.*
*Todas as citações foram verificadas contra fontes primárias.*
