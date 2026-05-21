# 01 — Visão Geral da Arquitetura

> **Versão:** 1.0  
> **Data:** 2026-05-21  
> **Status:** Revisado e corrigido com base na análise crítica dos documentos originais

---

## 1. Objetivo do Sistema

Construir um sistema de agentes de IA para o Hermes Agent que **detecta vulnerabilidades em contratos inteligentes Solidity** através de verificação formal, seguindo este pipeline:

1. **Enriquecimento de contexto** via Slither (análise estática — printers, não detectores)
2. **Criação de propriedades formais** em CVL (Certora Verification Language)
3. **Execução da verificação** no Certora Prover (cloud)
4. **Validação dos resultados** (PASS / FAIL / TIMEOUT / SANITY)
5. **Geração de Prova de Conceito** (PoC) quando vulnerabilidade é encontrada
6. **Geração de relatório** estruturado com evidências

O sistema começa focado em **Access Control** (CWE-284), com arquitetura extensível para outros tipos de vulnerabilidade (reentrancy, overflow, etc.).

---

## 2. Arquitetura de Agentes

```
┌──────────────────────────────────────────────────────────────────┐
│                     USUÁRIO                                       │
│  Input: project_path + vuln_types                                │
└──────────────────────┬───────────────────────────────────────────┘
                       │
                       ▼
┌──────────────────────────────────────────────────────────────────┐
│              AGENTE ORQUESTRADOR                                  │
│  (security-orchestrator)                                          │
│                                                                   │
│  • Valida estrutura do projeto                                    │
│  • Roteia para enricher + agente de vulnerabilidade               │
│  • Consolida relatório final                                      │
└───────┬──────────────────────────┬───────────────────────────────┘
        │                          │
        ▼                          ▼
┌───────────────────┐   ┌──────────────────────────────────────────┐
│  SLITHER ENRICHER │   │  AGENTE DE VULNERABILIDADE               │
│                   │   │  (ex: access-control-certora)             │
│  • Executa        │   │                                           │
│    printers       │──▶│  • Analisa slither_context                │
│  • Retorna JSON   │   │  • Cria .spec + .conf                    │
│    estruturado    │   │  • Valida sintaxe (--compilation_steps)   │
│                   │   │  • Executa no Certora Cloud               │
│  Stateless e      │   │  • Interpreta resultado                   │
│  reutilizável     │   │  • Gera PoC (se FAIL)                     │
└───────────────────┘   │  • Gera relatório                         │
                        └──────────────────────────────────────────┘
```

### Por que 3 agentes e não 1?

| Critério | Agente Único | 3 Agentes Separados |
|----------|-------------|---------------------|
| Tamanho do skill | Enorme (1500+ linhas) | Focados (100-600 linhas cada) |
| Extensibilidade | Modificar o monolito | Adicionar novo agente de vuln |
| Tokens por execução | Carrega tudo sempre | Carrega só o necessário |
| Manutenção | Qualquer mudança afeta tudo | Mudança isolada por agente |
| Reutilização | Slither acoplado a cada vuln | Enricher compartilhado |

### Por que um Slither Enricher separado?

O Enricher é **stateless**: recebe caminho do projeto + tipo de vulnerabilidade, executa os printers apropriados, e retorna um JSON compacto. O mesmo enricher serve para access-control, reentrancy e overflow — a diferença está apenas em quais printers executa.

Isso evita que cada agente de vulnerabilidade precise saber como executar e parsear output do Slither.

---

## 3. Decisões de Design

### 3.1 Slither como enriquecedor, NÃO como detector

O Slither é usado exclusivamente para **printers** (informação estrutural):
- Quais funções existem e sua visibilidade
- Quais modifiers protegem cada função
- Quais variáveis de estado cada função escreve
- Hierarquia de herança

**Nunca** usar output de detectores do Slither como evidência de vulnerabilidade. O Slither tem falsos positivos. A evidência vem exclusivamente do Certora Prover (contraexemplo matemático).

### 3.2 Documentos de guia → Destilados nos skills

Os documentos de referência (guia do Certora, guia do Slither, guia de propriedades CVL) são a **fonte** para escrever os skills dos agentes. O agente lê o skill, não os documentos originais. Razões:

1. **Custo de tokens**: documentos de 600+ linhas por chamada seriam desperdiçados
2. **Consistência**: o skill tem procedimento determinístico; o documento tem informação genérica
3. **Foco**: o skill contém apenas o necessário para a tarefa específica

### 3.3 Código-fonte do contrato NÃO é passado ao agente Certora

O agente de vulnerabilidade recebe apenas o `slither_context` (JSON compacto com ~30-50 linhas). O `certoraRun` lê o arquivo `.sol` diretamente do disco. O agente precisa saber:
- Assinaturas de funções (para o methods block do spec)
- Padrão de access control (para escolher templates CVL)
- Caminho do arquivo (para o `.conf`)

### 3.4 Resultado "PASS" ≠ "contrato seguro"

Um resultado PASS do Certora significa: "não encontrou violação para as propriedades especificadas, dentro do timeout configurado". Isso NÃO é equivalente a "o contrato é seguro". As limitações incluem:
- Propriedades que o agente não criou
- Timeout que impediu exploração completa
- Interações cross-contract não modeladas

O relatório deve sempre usar a linguagem "nenhuma violação encontrada para as propriedades verificadas", nunca "contrato seguro".

---

## 4. Escopo Atual vs Futuro

### Implementado (v1)

| Componente | Status |
|-----------|--------|
| Orquestrador | ✅ Skill definido |
| Slither Enricher | ✅ Skill definido |
| Access Control Agent | ✅ Skill definido |
| Padrão Ownable | ✅ Templates CVL prontos |
| Padrão RBAC | ✅ Templates CVL prontos |
| Padrão Custom | ✅ Template CVL básico |
| PoC Foundry | ✅ Template definido |
| Relatório | ✅ Template definido |

### Planejado (futuro)

| Componente | Status | Dependência |
|-----------|--------|-------------|
| Reentrancy Agent | 📋 Printers selecionados | Templates CVL a criar |
| Overflow Agent | 📋 Printers selecionados | Templates CVL a criar |
| Auto-melhoria (ILWS/MemAPO) | 📋 Seções CANDIDATES no skill | Execuções reais para validar |
| Multi-contract linking | ⚠️ Necessário mas não especificado | Documentação de `--link` |

---

## 5. Relação com o Hermes Agent

O sistema opera dentro do framework Hermes Agent:
- Cada agente é um arquivo `SKILL.md` com YAML frontmatter
- O Hermes carrega skills por relevância (matching de tarefa)
- O sistema de memória episódica do Hermes complementa as seções CANDIDATES/CONFIRMED dos skills
- Execução de ferramentas (Slither, Certora) via tools do Hermes (terminal, bash)

> **Nota**: O Hermes Agent é o framework de execução. Os skills definem o comportamento. A auto-melhoria (seções CANDIDATES/CONFIRMED/DEPRECATED) segue os princípios do ILWS e MemAPO, implementados via markdown no próprio skill — sem necessidade de modificar o código-fonte do Hermes.

---

## 6. Documentos Relacionados

| Documento | Conteúdo |
|-----------|----------|
| [02-fluxo-de-dados.md](./02-fluxo-de-dados.md) | Diagrama completo do fluxo de dados entre agentes |
| [03-agente-orquestrador.md](./03-agente-orquestrador.md) | Especificação do orquestrador |
| [04-agente-slither-enricher.md](./04-agente-slither-enricher.md) | Especificação do Slither Enricher |
| [05-agente-access-control.md](./05-agente-access-control.md) | Especificação do agente Access Control |
| [06-configuracao-ambiente.md](./06-configuracao-ambiente.md) | Pré-requisitos e setup |
| [07-extensibilidade.md](./07-extensibilidade.md) | Como adicionar novas vulnerabilidades |
| [08-revisao-critica.md](./08-revisao-critica.md) | Achados da revisão crítica |
