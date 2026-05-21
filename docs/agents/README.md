# Arquitetura: Hermes Security Agents

## Visão geral

Três agentes cooperativos para detectar vulnerabilidades em contratos Solidity via verificação formal (Certora Prover), com enriquecimento de contexto via Slither.

```
User → Orchestrator → Slither Enricher → structured context
                   → Access Control Agent → spec → Certora → PoC + Report
                   → [Reentrancy Agent] (futuro)
                   → [Overflow Agent] (futuro)
```

---

## Decisões de Design

### Por que agentes separados por vulnerabilidade?

Cada tipo de vulnerabilidade precisa de:
- Printers Slither diferentes
- Templates CVL diferentes
- Interpretação de counterexample diferente
- Estrutura de PoC diferente

Colocar tudo em um agente único tornaria o skill enorme e confuso. Agentes separados por vulnerabilidade são focados, menores e mais fáceis de melhorar independentemente.

### Por que um Slither Enricher separado?

O Slither enricher é **stateless e reutilizável**: o mesmo enricher serve para access-control, reentrancy e overflow. A diferença é apenas quais printers ele executa (definido pelo parâmetro `vuln_type`).

Separar o enricher evita que cada agente de vulnerabilidade precise saber rodar o Slither — eles recebem context já estruturado.

### Por que NÃO passar os documentos de guia para o agente?

A abordagem anterior enviava os documentos `docs/certora_cloud_run_guide` e `docs/certora_properties_creation_guide` como context em cada execução. Problemas:

1. **Custo de tokens**: documentos de 600+ linhas em cada chamada
2. **Ruído**: o agente precisa extrair o relevante de um documento longo
3. **Inconsistência**: o agente pode escolher partes diferentes do documento em execuções diferentes

A abordagem correta: os documentos são a **fonte** para escrever os skills. O skill é a versão distilada, estruturada e acionável do documento. O agente lê o skill, não o documento original.

### Por que NÃO passar o código-fonte completo do contrato?

O agente Certora não precisa do código-fonte completo. Ele precisa de:
- Assinaturas de funções (para o methods block do spec)
- Tipos das state variables (para ghosts/hooks)
- Padrão de access control (para escolher o template CVL certo)

Tudo isso está no `slither_context` em formato compacto (~30 linhas de JSON vs. 500+ linhas de código-fonte).

O `certoraRun` lê o arquivo `.sol` diretamente — o agente apenas precisa saber o caminho.

### Slither como enriquecedor de contexto, não detector

O Slither é **excelente** para análise estática, mas tem falsos positivos e não prova matematicamente a ausência de vulnerabilidades.

O Certora Prover é matemático mas precisa saber onde olhar.

A combinação correta:
- Slither: "aqui estão as funções privilegiadas e os padrões de access control"
- Certora: "vou provar matematicamente que essas funções só podem ser chamadas por endereços autorizados"

Nunca usar saída de detector do Slither como evidência de vulnerabilidade no relatório final.

---

## Printers Slither por Vulnerabilidade

### Access Control

| Printer | Por que usar | O que extrai |
|---------|-------------|--------------|
| `vars-and-auth` | **Principal** | Quais variáveis cada função escreve + checks de msg.sender |
| `modifiers` | **Principal** | Quais modifiers cada função tem (onlyOwner, onlyRole...) |
| `function-summary` | **Principal** | Visibilidade, modifiers, state vars lidas/escritas |
| `require` | Importante | Require/assert com controle de acesso inline |
| `inheritance` | Importante | Access control herdado de contratos pai |
| `human-summary` | Opcional | Overview — raramente necessário |

**NÃO usar para access control:** call-graph, cfg, slithir, data-dependency, echidna.

### Reentrancy (futuro)

| Printer | Por que usar |
|---------|-------------|
| `call-graph` | Grafo de chamadas externas — essencial |
| `function-summary` | Estado antes/depois de chamadas externas |
| `data-dependency` | Fluxo de ETH e valores |
| `cfg` | Control flow para identificar padrão CEI vs não-CEI |

### Overflow (futuro)

| Printer | Por que usar |
|---------|-------------|
| `slithir` | Operações aritméticas em IR — essencial |
| `function-summary` | Funções que fazem cálculos |
| `data-dependency` | De onde vêm os valores dos cálculos |

---

## Estrutura de Pastas nos Projetos Alvo

```
{project_root}/
  contracts/            ← código original (NÃO modificar)
    MyToken.sol
  certora_tests/        ← criado pelos agentes
    specs/
      AccessControl.spec
    confs/
      AccessControl.conf
    poc/
      PoCAccessControl.sol
    reports/
      access_control_report.md
```

---

## Workflow de Iteração do Spec

```
Criar spec
    ↓
certoraRun --compilation_steps_only
    ↓
Erro de sintaxe? → corrigir → repetir (max 5×)
    ↓
OK → certoraRun --wait_for_results all
    ↓
FAIL → extrair counterexample → gerar PoC
PASS → verificar vacuidade → reportar
TIMEOUT → reportar como INCONCLUSIVO
SANITY → reescrever regra vacua
```

---

## Handling de Resultados do Certora

| Resultado | O que significa | O que o agente faz |
|-----------|-----------------|---------------------|
| `FAIL` | Violação encontrada, counterexample disponível | Extrair CE → gerar PoC → incluir no relatório como vulnerabilidade confirmada |
| `PASS` | Propriedade satisfeita para todos os inputs | Reportar como "não encontrou violação para esta propriedade" (não "contrato seguro") |
| `TIMEOUT` | Solver não terminou no tempo configurado | Reportar como INCONCLUSIVO — não é PASS |
| `SANITY` | Regra vacuamente verdadeira | Reescrever regra — não conta como verificação válida |
| Erro de sintaxe | Spec incorreto | Corrigir e reiterar (max 5×) |

---

## Como Adicionar uma Nova Vulnerabilidade

1. Criar `hermes-security-agents/{vuln-type}/skill.md`
2. Definir quais printers Slither usar (seção no skill do enricher)
3. Definir templates CVL específicos
4. Definir como interpretar o counterexample para gerar PoC
5. Definir estrutura de relatório
6. Adicionar roteamento no orchestrator: `"vuln-type" → agente`

O enricher já aceita novos `vuln_type` — apenas adicionar a seção de printers correspondente.

---

## O que o agente NÃO deve fazer

- Modificar os contratos originais
- Criar propriedades CVL com sintaxe inventada
- Reportar vulnerabilidade sem contraexemplo do Certora
- Reportar "contrato seguro" sem execução bem-sucedida
- Passar documentos de guia como context (o skill já é o guia)
- Continuar iterando spec com erro após 5 tentativas
- Usar saída de detectors do Slither como evidência de vulnerabilidade
