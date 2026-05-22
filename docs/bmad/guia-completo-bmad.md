# Guia Completo: BMad Method — Do Zero ao Agente Otimizado

> **Versão de referência:** BMad v6 (mai/2026) · Claude Code (recomendado) · Node.js 20.12+

---

## Índice

1. [O que é o BMad Method?](#1-o-que-é-o-bmad-method)
2. [Como funciona por dentro](#2-como-funciona-por-dentro)
3. [Instalação passo a passo](#3-instalação-passo-a-passo)
4. [Os agentes e seus papéis](#4-os-agentes-e-seus-papéis)
5. [Fluxo de trabalho completo](#5-fluxo-de-trabalho-completo)
6. [Erros comuns e como evitá-los](#6-erros-comuns-e-como-evitá-los)
7. [Como criar o melhor agente possível](#7-como-criar-o-melhor-agente-possível)
8. [Sistema de Feedback do Agente (pós-tarefa)](#8-sistema-de-feedback-do-agente-pós-tarefa)
9. [Template de Relatório de Feedback](#9-template-de-relatório-de-feedback)
10. [Ciclo de Melhoria Contínua](#10-ciclo-de-melhoria-contínua)
11. [Referências e leituras recomendadas](#11-referências-e-leituras-recomendadas)

---

## 1. O que é o BMad Method?

O **BMad** (*Breakthrough Method for Agile AI-Driven Development* — ou, no seu significado alternativo oficial, *Build More Architect Dreams*) é um framework open-source de desenvolvimento orientado por agentes de IA. Em vez de usar a IA como um autocomplete glorificado, o BMad organiza agentes especializados que colaboram como um time de software real, cobrindo todo o ciclo de vida de um projeto: da ideia à entrega.

### Por que ele existe?

O problema que o BMad resolve tem nome: **"vibe coding"** — o hábito de mandar prompts aleatórios para a IA e torcer para que funcione. Esse modelo colapsa em projetos complexos por três razões principais:

- **Perda de contexto**: o LLM esquece decisões tomadas há mensagens atrás
- **Inconsistência de planejamento**: o que o PM decidiu não chega intacto ao desenvolvedor
- **Falta de estrutura**: sem artefatos formais, não há como auditar, revisar ou melhorar

O BMad responde a isso com dois pilares:

1. **Agentes dedicados de planejamento** — Analyst, PM e Architect trabalham *antes* de qualquer linha de código ser escrita
2. **Histórias de desenvolvimento hiper-detalhadas** — o Scrum Master gera documentos com contexto suficiente para que o Developer não precise "lembrar" de nada; tudo está escrito

### Posição no mercado (2026)

- +37.000 estrelas no GitHub
- Suporte nativo ao Claude Code, Cursor e Codex CLI
- 5 módulos oficiais: Core Agile, BMad Builder, Testing (TEA), Game Dev Studio, Creative Intelligence Suite
- V6 introduziu **Skills Architecture** e **Scale-Adaptive Intelligence** (o framework se ajusta automaticamente à complexidade do projeto)

---

## 2. Como funciona por dentro

### Arquitetura de contexto

O BMad é, fundamentalmente, um **sistema de engenharia de contexto**, não apenas de engenharia de prompt. A diferença é crítica:

| Engenharia de Prompt | Engenharia de Contexto (BMad) |
|---|---|
| Foca em *como* você pergunta | Foca em *o que* o agente sabe |
| Melhora uma interação | Estrutura todo o ambiente de informação |
| Resultado: melhor frase | Resultado: melhor projeto |

### Os três problemas que o BMad resolve

**1. Context Loss (perda de contexto)**
Cada agente recebe apenas o contexto necessário para sua tarefa, via artefatos versionados (PRD, arquitetura, histórias). Nada de "o agente lembrar" — tudo está escrito em arquivo.

**2. Planning Inconsistency (inconsistência de planejamento)**
O Scrum Master consome os artefatos do PM e do Architect e produz histórias que *embarcam* todo o contexto. O Developer nunca precisa inferir intenção — ela está documentada.

**3. Agent Drift (deriva do agente)**
Ao usar chats frescos para cada workflow, o BMad impede que o contexto de tarefas anteriores "contamine" a tarefa atual, um problema comum em sessões longas com LLMs.

### Estrutura de pastas após instalação

```
projeto/
├── _bmad/                    ← Framework (não editar manualmente)
│   ├── agents/               ← Definições dos agentes
│   ├── workflows/            ← Fluxos de trabalho
│   ├── tasks/                ← Tarefas atômicas
│   └── config/               ← Configuração geral
└── _bmad-output/             ← Seus artefatos (editar aqui)
    ├── project-context.md    ← Suas convenções e regras
    ├── prd.md                ← Product Requirements Document
    ├── architecture.md       ← Decisões de arquitetura
    ├── stories/              ← Histórias de desenvolvimento
    └── [feedback-logs/]      ← Seu sistema de feedback (criado por você)
```

### Scale-Adaptive Intelligence (v6)

O BMad v6 detecta automaticamente a escala do projeto e ajusta o nível de planejamento:

| Track | Ideal para | Artefatos gerados |
|---|---|---|
| **Quick Flow** | Bug fixes, features simples (1–15 histórias) | Tech-spec apenas |
| **BMad Method** | Produtos, plataformas (10–50+ histórias) | PRD + Arquitetura + UX |
| **Enterprise** | Sistemas complexos, compliance (30+ histórias) | PRD + Arquitetura + Segurança + DevOps |

---

## 3. Instalação passo a passo

### Pré-requisitos

- Node.js 20.12 ou superior (`node --version`)
- Git instalado e configurado
- Um AI coding assistant: **Claude Code** (recomendado), Cursor ou Codex CLI
- Acesso a Claude Sonnet 4 ou GPT-4o (modelos menores causam colapso de lógica em PRDs longos)

### Instalação

```bash
# Na pasta do seu projeto
npx bmad-method install
```

Quando solicitado, selecione o módulo **BMad Method**.

Para instalar a versão mais recente (prerelease):

```bash
npx bmad-method@next install
```

### Primeiro uso

Após instalar, abra o projeto no seu AI IDE e execute:

```
bmad-help
```

O **BMad-Help** vai inspecionar o projeto, detectar o que já foi feito e recomendar exatamente o próximo passo. Ele também roda automaticamente ao final de cada workflow.

> **Regra de ouro:** sempre inicie um chat fresco para cada workflow. Chats longos acumulam contexto que degrada a qualidade das respostas.

---

## 4. Os agentes e seus papéis

O BMad tem 12+ personas de agentes especializados. Os principais:

### Agentes de Planejamento

| Agente | Skill | Responsabilidade |
|---|---|---|
| **Analyst** | `bmad-agent-analyst` | Pesquisa de mercado, PRFAQ, brief de produto |
| **Product Manager (PM)** | `bmad-prd` | Cria e valida o PRD (Product Requirements Document) |
| **Architect** | `bmad-architecture` | Define a arquitetura técnica do sistema |
| **UX Expert** | `bmad-ux` | Fluxos de usuário, wireframes conceituais |

### Agentes de Execução

| Agente | Skill | Responsabilidade |
|---|---|---|
| **Scrum Master** | `bmad-sm` | Transforma PRD + arquitetura em histórias de desenvolvimento |
| **Developer** | `bmad-dev` | Implementa as histórias, guiado pelo contexto embutido |
| **QA Tester** | `bmad-qa` | Valida implementações contra critérios de aceitação |
| **Technical Writer** | `bmad-tw` | Documentação técnica |

### Party Mode

O **Party Mode** permite que múltiplos agentes participem da mesma sessão para discussão colaborativa e tomada de decisões — útil para decisões arquiteturais com perspectivas conflitantes.

---

## 5. Fluxo de trabalho completo

### Fase 1: Análise (opcional)

```
bmad-brainstorming          ← Ideação guiada
bmad-market-research        ← Pesquisa de mercado
bmad-domain-research        ← Pesquisa de domínio
bmad-technical-research     ← Pesquisa técnica
bmad-product-brief          ← Brief do produto (recomendado quando a ideia está clara)
bmad-prfaq                  ← Stress-test da ideia (Working Backwards)
```

### Fase 2: Planejamento (obrigatório)

```
bmad-prd                    ← Cria o PRD
```

Intenções disponíveis: **Create** (do zero), **Update** (refinar), **Validate** (revisar).

Output: `prd.md`, `addendum.md`, `decision-log.md`

### Fase 3: Solutioning (BMad Method / Enterprise)

```
bmad-architecture           ← Documento de arquitetura
bmad-ux                     ← Fluxos de UX
bmad-generate-project-context ← Gera project-context.md com suas convenções
```

### Fase 4: Implementação

```
bmad-sm                     ← Inicializa sprint planning (gera histórias)
bmad-dev                    ← Implementa história por história
bmad-qa                     ← Valida cada história
```

### O ciclo de build

```
1. Scrum Master gera história N
2. Developer implementa história N (chat fresco)
3. QA valida história N
4. Feedback coletado (veja Seção 8)
5. Próxima história
```

---

## 6. Erros comuns e como evitá-los

### ❌ Erro 1: Reutilizar o mesmo chat entre workflows

**O problema:** o LLM acumula contexto irrelevante, instrução antiga "contamina" a nova task, e a qualidade cai progressivamente.

**Solução:** sempre abra um chat fresco para cada workflow. É inegociável.

---

### ❌ Erro 2: Usar modelos fracos

**O problema:** modelos menores que GPT-4o ou Claude Sonnet 3.5 sofrem "instruction forgetting" ao processar PRDs longos ou arquiteturas complexas — eles literalmente esquecem instruções anteriores dentro do mesmo documento.

**Solução:** use Claude Sonnet 4 (recomendado) ou GPT-4o como mínimo. Para tarefas de alta complexidade, Claude Opus.

---

### ❌ Erro 3: Pular a fase de planejamento

**O problema:** sair direto para o código sem PRD resulta em retrabalho massivo. O BMad foi reportado como ineficiente justamente quando as pessoas pulam as fases iniciais.

**Solução:** trate o PRD como código — ele é a especificação que todos os agentes vão consumir. Investir aqui economiza horas depois.

---

### ❌ Erro 4: Aceitar histórias marcadas como "completas" sem verificar

**O problema:** casos reportados na comunidade mostram agentes marcando histórias como completas mesmo com bugs críticos (ex: sistema de autenticação quebrado marcado como OK). O pipeline multi-agente reduz, mas não elimina, a falibilidade da IA.

**Solução:** sempre execute o agente QA em separado e, para funcionalidades críticas, faça revisão humana antes de fechar a história.

---

### ❌ Erro 5: Tratar o BMad como "faça tudo por mim"

**O problema:** o BMad não substitui pensamento humano — ele amplifica. Usuários que esperam que o Analyst gere ideias brilhantes sem input qualificado ficam frustrados.

**Solução:** você é o diretor. Os agentes são especialistas que executam *sua* visão com mais rigor e velocidade do que você conseguiria sozinho.

---

### ❌ Erro 6: Não criar o `project-context.md`

**O problema:** sem esse arquivo, cada agente reinventa suas próprias convenções. Um agente usa TypeScript com `interface`, outro com `type`. Um usa `camelCase`, outro `snake_case`.

**Solução:** após a fase de arquitetura, execute `bmad-generate-project-context` e revise o arquivo gerado. Documente: stack de tecnologia, convenções de nomenclatura, padrões de código, regras de commit.

---

### ❌ Erro 7: Alimentar o agente com contexto excessivo

**O problema:** "jogar tudo que você tem" no contexto não melhora o resultado — prejudica. O agente perde foco.

**Solução:** use a **Active Context Policy** — carregue apenas os artefatos relevantes para a tarefa atual. Para documentos grandes, use o **Document Sharding** (`bmad-shard`) para dividir em seções acessíveis.

---

### ❌ Erro 8: Não usar o BMad-Help

**O problema:** tentar navegar os workflows manualmente sem o guia inteligente, resultando em passos fora de ordem.

**Solução:** sempre comece com `bmad-help` após instalar, e deixe-o rodar no final de cada workflow para saber exatamente o que fazer a seguir.

---

## 7. Como criar o melhor agente possível

Esta seção combina as práticas do BMad com os estudos mais recentes em engenharia de agentes (2025–2026).

### 7.1 Princípios fundamentais de design de agente

#### Persona clara e limitada

Um agente com escopo bem definido é radicalmente mais confiável do que um agente genérico. Defina:

- **Papel único:** o agente sabe *exatamente* o que faz e o que *não* faz
- **Tom e linguagem:** como ele se comunica (formal, técnico, didático)
- **Limites explícitos:** o que ele deve recusar ou escalar para outro agente

Exemplo de definição de persona bem estruturada:

```yaml
name: "Agente de Code Review"
role: "Revisor de código backend especializado em Python e segurança"
scope:
  - Revisa PRs conforme as diretrizes em project-context.md
  - Identifica vulnerabilidades de segurança (OWASP Top 10)
  - Sugere refatorações baseadas em PEP 8 e Clean Code
out_of_scope:
  - NÃO escreve código novo
  - NÃO toma decisões arquiteturais
  - NÃO aprova PRs — apenas recomenda
escalation:
  - Decisões arquiteturais → Architect Agent
  - Mudanças de requisitos → PM Agent
```

---

#### 7.2 Técnicas de prompt engineering avançadas (ciência aplicada)

**Chain-of-Thought (CoT) obrigatório**

Instrua o agente a pensar em voz alta antes de responder. Pesquisas de 2024-2025 mostram ganhos de 20–40% em acurácia em tarefas complexas com CoT explícito.

```
Antes de responder, pense passo a passo:
1. O que foi pedido?
2. Quais são as restrições e contexto?
3. Quais são as opções possíveis?
4. Qual é a melhor opção e por quê?
Só então forneça a resposta final.
```

**Self-Consistency**

Para decisões críticas, o agente executa o mesmo raciocínio múltiplas vezes com variações e elege a resposta majoritária. Estudos mostram ganho de 2–3x em acurácia sobre CoT simples. No BMad, isso é implementado via **Adversarial Review** (`bmad-adversarial-review`).

**Meta-prompting**

Um agente "blueprints" descreve a estrutura da tarefa para que um agente especializado a execute de forma mais confiável. O Scrum Master do BMad é uma implementação exata disso — ele cria histórias que instruem o Developer.

**Reflexion Pattern (baseado em pesquisa da Princeton/MIT, 2023, consolidado em 2025)**

O agente critica sua própria saída antes de finalizá-la:

```
Após gerar a resposta:
1. Revise o que você produziu criticamente
2. Identifique possíveis erros, omissões ou inconsistências
3. Liste o que você NÃO sabia e assumiu
4. Corrija se necessário
5. Entregue a versão revisada com uma nota sobre o que mudou
```

---

#### 7.3 Estrutura de instruções do agente (anatomia)

Um agente bem construído tem estas seções em seu system prompt:

```markdown
## 1. IDENTIDADE
Quem você é, seu papel exato, sua especialidade.

## 2. OBJETIVO PRIMÁRIO
O que você deve alcançar — resultado concreto, não processo.

## 3. CONTEXTO E ARTEFATOS
Quais arquivos/documentos você deve consultar antes de agir.
(Liste explicitamente: project-context.md, prd.md, etc.)

## 4. REGRAS DE COMPORTAMENTO
- Faça sempre X
- Nunca faça Y
- Se encontrar Z, escale para o agente W

## 5. FORMATO DE OUTPUT
Estrutura exata da resposta esperada (seções, markdown, JSON, etc.)

## 6. CRITÉRIOS DE QUALIDADE
Como você sabe que fez um bom trabalho?
(Checklist que o agente deve passar antes de entregar)

## 7. PROTOCOLO DE FEEDBACK (NOVO — veja Seção 8)
Após cada tarefa, gere o relatório de feedback conforme template.
```

---

#### 7.4 Gestão de contexto (a parte mais crítica)

O contexto é o limite real dos agentes. As melhores práticas em 2026:

**Active Context Policy**
Carregue apenas artefatos relevantes à tarefa. Para um agente de code review de um módulo específico, carregue apenas a arquitetura daquele módulo, não do sistema inteiro.

**Document Sharding**
Para documentos com 50+ páginas, use `bmad-shard` para dividir em seções. Cada agente consome apenas as seções necessárias.

**Memória em duas camadas** (padrão Reflexion)

- **Memória de curto prazo:** histórico da execução atual (o que foi feito, em que ordem)
- **Memória de longo prazo:** relatórios de feedback acumulados (lições aprendidas, padrões de erro)

---

#### 7.5 Human-in-the-Loop (HITL) — onde colocar o humano

Não coloque revisão humana em tudo — isso elimina o benefício da automação. Coloque revisão onde há maior risco:

| Ponto de revisão | Por quê |
|---|---|
| Aprovação do PRD | Define todo o projeto |
| Aprovação da arquitetura | Decisões difíceis de reverter |
| Fechamento de história crítica | Funcionalidades de negócio central |
| Análise do relatório de feedback | Melhoria contínua do agente |

---

## 8. Sistema de Feedback do Agente (pós-tarefa)

Esta é a seção mais importante para **sua meta específica**: criar um mecanismo pelo qual o agente, ao terminar uma tarefa, gera um relatório que te permite melhorá-lo com o tempo.

### 8.1 A filosofia por trás

A pesquisa acadêmica em agentes reflexivos (Reflexion, MARS, Self-Refine — 2023–2026) demonstrou que agentes que verbalizam o que *não sabiam*, *o que encontraram de diferente* e *como resolveram* criam o material mais valioso para melhoria de prompts. Em vez de fine-tuning (que requer infraestrutura complexa), você usa esses relatórios como **base para atualizar manualmente as instruções do agente** — um ciclo de melhoria eficiente e controlado.

### 8.2 Como instruir o agente a gerar o feedback

Adicione estas instruções ao final do system prompt de cada agente:

```markdown
## PROTOCOLO DE ENCERRAMENTO DE TAREFA (OBRIGATÓRIO)

Ao concluir qualquer tarefa, ANTES de encerrar a sessão, você DEVE:

1. Gerar um arquivo chamado `feedback-[data]-[nome-da-tarefa].md`
2. Salvá-lo em `_bmad-output/feedback-logs/`
3. Seguir EXATAMENTE o template de feedback documentado

Este relatório é tão importante quanto a entrega principal.
Não pule esta etapa, mesmo que a tarefa seja simples.
```

### 8.3 Quando o agente gera o feedback

O relatório deve ser gerado **sempre**, incluindo:

- Tarefas concluídas com sucesso
- Tarefas parcialmente concluídas
- Tarefas em que o agente precisou desviar do plano original
- Tarefas em que o agente encontrou ambiguidades

---

## 9. Template de Relatório de Feedback

Salve este template em `_bmad/templates/feedback-template.md` e instrua cada agente a seguir exatamente esta estrutura:

---

```markdown
# Relatório de Feedback — [Nome da Tarefa]

**Agente:** [Nome do agente/persona]
**Data:** [YYYY-MM-DD]
**Tarefa:** [Descrição breve da tarefa executada]
**Status:** [Concluído / Parcial / Bloqueado]
**Duração estimada:** [Tempo aproximado de execução]

---

## 1. RESUMO DA ENTREGA

[2–3 parágrafos descrevendo o que foi feito, como foi feito e o resultado alcançado]

---

## 2. METODOLOGIA UTILIZADA

### Abordagem geral
[Como o agente estruturou o trabalho — quais etapas seguiu, em que ordem e por quê]

### Decisões tomadas durante a execução
| Decisão | Alternativas consideradas | Razão da escolha |
|---|---|---|
| [Decisão 1] | [Alt A, Alt B] | [Por que esta foi escolhida] |

### Ferramentas e artefatos consultados
- `[arquivo-consultado-1.md]` — [por que foi necessário]
- `[arquivo-consultado-2.md]` — [por que foi necessário]

---

## 3. ERROS E PROBLEMAS ENCONTRADOS

### 3.1 Erros que NÃO estavam documentados nas instruções

| # | Descrição do problema | Como afetou a tarefa | Solução aplicada |
|---|---|---|---|
| 1 | [Descrição clara do problema] | [Impacto] | [Como foi resolvido] |

### 3.2 Ambiguidades nas instruções do agente

> Estas são lacunas nas instruções que precisam ser endereçadas pelo humano responsável.

| # | Instrução ambígua | Como eu interpretei | Interpretação alternativa possível |
|---|---|---|---|
| 1 | [Trecho da instrução] | [Minha interpretação] | [Outra interpretação válida] |

### 3.3 Suposições feitas por falta de informação

| # | Suposição feita | Risco se estiver errada | Recomendação |
|---|---|---|---|
| 1 | [O que assumi] | [Consequência se errado] | [Como confirmar/corrigir] |

---

## 4. DESCOBERTAS E DICAS (não documentadas)

> Conhecimento que o agente descobriu durante a execução e que seria útil ter nas instruções desde o início.

### 4.1 Atalhos e melhores práticas descobertos
- **[Dica 1]:** [Descrição e por que é útil]
- **[Dica 2]:** [Descrição e por que é útil]

### 4.2 Padrões identificados (pode ser útil para tarefas futuras similares)
- [Padrão 1]
- [Padrão 2]

### 4.3 Recursos externos úteis encontrados
- [Recurso/documentação/ferramenta] — [por que é relevante]

---

## 5. PROBLEMAS RESOLVIDOS SEM INSTRUÇÃO EXPLÍCITA

> Situações em que o agente precisou improvisar porque as instruções não cobriam o cenário.

| # | Situação | Solução improvisada | Deveria estar nas instruções? |
|---|---|---|---|
| 1 | [Contexto do problema] | [O que foi feito] | [Sim/Não — e por quê] |

---

## 6. RECOMENDAÇÕES PARA MELHORIA DO AGENTE

> Estas são sugestões diretas de como atualizar as instruções do agente para evitar os problemas encontrados.

### 6.1 Adicionar às instruções
```
[Texto sugerido para adicionar ao system prompt]
```

### 6.2 Remover ou modificar nas instruções
```
[O que deve ser removido/mudado e por quê]
```

### 6.3 Novo artefato/documento sugerido
- [Nome do artefato] — [Para resolver qual problema]

---

## 7. MÉTRICAS DE QUALIDADE (auto-avaliação)

| Critério | Nota (1–5) | Justificativa |
|---|---|---|
| Fidelidade ao objetivo da tarefa | [1–5] | [Por quê] |
| Clareza das instruções recebidas | [1–5] | [Por quê] |
| Qualidade do output gerado | [1–5] | [Por quê] |
| Completude da entrega | [1–5] | [Por quê] |
| Dificuldade inesperada | [1–5] | [1=fácil, 5=muito difícil] |

**Nota geral:** [Média] / 5

---

## 8. PRÓXIMOS PASSOS SUGERIDOS

- [ ] [Ação 1 que o humano deve tomar]
- [ ] [Ação 2 que o humano deve tomar]
- [ ] [Atualização sugerida no agente]

---

*Relatório gerado automaticamente pelo agente [Nome] em [Data/Hora]*
```

---

## 10. Ciclo de Melhoria Contínua

O objetivo final é criar um loop onde cada execução torna o agente melhor. Baseado nas pesquisas mais recentes (Reflexion, MARS — 2025, Self-Improving Agents — NeurIPS 2025):

### O loop completo

```
┌─────────────────────────────────────────────────────┐
│                                                     │
│   1. DEFINIR                                        │
│   Escreva as instruções iniciais do agente          │
│   (system prompt + project-context.md)              │
│                          │                          │
│                          ▼                          │
│   2. EXECUTAR                                       │
│   Agente realiza a tarefa                           │
│                          │                          │
│                          ▼                          │
│   3. FEEDBACK                                       │
│   Agente gera o relatório de feedback               │
│   (feedback-logs/feedback-YYYY-MM-DD-tarefa.md)     │
│                          │                          │
│                          ▼                          │
│   4. REVISAR (você)                                 │
│   Leia o relatório. Identifique padrões:            │
│   - Mesmo erro apareceu 3+ vezes? → Corrija         │
│   - Mesma dica apareceu? → Adicione às instruções   │
│   - Mesma ambiguidade? → Clarifique                 │
│                          │                          │
│                          ▼                          │
│   5. ATUALIZAR                                      │
│   Atualize o system prompt do agente                │
│   Versione a mudança (ex: agent-v1.2.md)            │
│                          │                          │
│                          └──────────────────────────┘
│                          (volta ao passo 2)
```

### Cadência recomendada de revisão

| Frequência | O que revisar |
|---|---|
| **Após cada tarefa** | Leia o feedback, sinalize itens urgentes |
| **Semanalmente** | Agrupe feedbacks da semana, identifique padrões |
| **Mensalmente** | Refatore o system prompt do agente com as lições acumuladas |
| **Trimestralmente** | Avalie se o agente ainda serve ao propósito ou precisa de redesign |

### Como identificar padrões nos feedbacks

Crie um arquivo `_bmad-output/feedback-logs/PADROES.md` e mantenha um log assim:

```markdown
# Padrões Identificados nos Feedbacks

## Erros Recorrentes

| Padrão | Ocorrências | Última vez | Status |
|---|---|---|---|
| Agente assume framework X quando não especificado | 4x | 2026-05-15 | ✅ Corrigido na v1.3 |
| Agente não consulta project-context.md antes de decidir | 2x | 2026-05-20 | 🔄 Pendente |

## Dicas Recorrentes (para adicionar às instruções)

- [Dica que apareceu 2+ vezes] — adicionar na v1.4
```

### Versionamento das instruções do agente

Trate as instruções do agente como código:

```
_bmad/agents/
├── meu-agente-v1.0.md      ← Versão original
├── meu-agente-v1.1.md      ← Corrigiu problema de contexto
├── meu-agente-v1.2.md      ← Adicionou regras de formato
└── meu-agente-current.md   ← Sempre aponta para a versão atual (symlink ou cópia)
```

Em cada versão, documente o changelog:

```markdown
## Changelog

### v1.2 (2026-05-22)
- Adicionado: agente agora consulta `architecture.md` antes de sugerir implementações
- Corrigido: ambiguidade sobre o que fazer quando o PRD contradiz o project-context

### v1.1 (2026-05-15)
- Adicionado: instrução para nunca assumir o framework de testes
- Corrigido: agente agora gera feedback mesmo em tarefas simples
```

---

## 11. Referências e leituras recomendadas

### Documentação oficial do BMad
- Docs: https://docs.bmad-method.org
- GitHub: https://github.com/bmad-code-org/BMAD-METHOD
- Discord: https://discord.gg/gk8jAdXWmj
- YouTube (tutoriais): https://www.youtube.com/@BMadCode

### Pesquisas acadêmicas sobre agentes reflexivos
- **Reflexion** (Princeton/MIT, 2023) — base do padrão de auto-avaliação
- **MARS: Metacognitive Agent with Reflective Self-improvement** (arxiv 2026) — melhoria de prompts por reflexão metacognitiva
- **Self-Challenging Agents** (NeurIPS 2025) — agentes que geram seus próprios desafios de treinamento
- **SEAL: Self-Adapting Language Models** (NeurIPS 2025) — modelos que se ajustam via feedback natural

### Artigos práticos recomendados
- "BMAD vs Standard Prompting" — trigidigital.com
- "Applied BMAD: Reclaiming Control in AI Development" — bennycheung.github.io
- "You Should BMAD — Part 2" (análise crítica) — adsantos.medium.com
- "Reflective and Self-Improving Agents" — medium.com/@swapnilshekade

### Conceitos-chave para estudar
- **Context Engineering** vs Prompt Engineering
- **ReAct pattern** (Reason + Act)
- **Human-in-the-Loop (HITL)**
- **Adversarial Review** (BMad nativo)
- **Chain-of-Thought** e **Self-Consistency**

---

*Documento criado em maio/2026. Mantenha este guia atualizado à medida que o BMad evolui — especialmente após releases maiores (v6, v7...).*
