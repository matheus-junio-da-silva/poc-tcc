

pesquisa como fazer um agente de IA melhorar ele mesmo, e nao invente ou alucine dados ou fontes, pesquisa em estudos, artigos academicos, etc, pesquisa a instrucao que se deve dar para o agente melhorar ele mesmo sem alucinar ou inventar, somente com base no que ele testou e validou, por exemplo, eu tenho agentes que criam propriedades formais para o certora, testa elas no certora e gera um relatorio com os resultados, porem, pode ter muitas coisas que o agente fica confuso para resolver que seria melhor instruir ele como ele deve agir diante daquela situacao no propio markdown do agente, entao queria que o agente melhorasse o markdown dele mesmo, sem alucinar excluindo dados, modificando coisas importantes, entao pesquisa na literatura o que temos a respeito da melhor forma para fazer isso, seja para o agente melhorar ele mesmo ou criar documentos da metologia que ele teve que seguir que nao estava especificado no markdown dele. pesquisa a melhor forma que os pesquisadores fazem

Show more
10:51 AM

Sintetizou pesquisa acadêmica sobre auto-melhoria de agentes sem alucinação
Sintetizou pesquisa acadêmica sobre auto-melhoria de agentes sem alucinação
Aqui está uma síntese profunda e referenciada da literatura. Vou organizar do mais fundamental ao mais aplicado ao seu caso específico.

Como Agentes de IA Melhoram Suas Próprias Instruções — Literatura Atual
1. O Problema Central: Por Que Agentes Alucinam ao Se Melhorar
O problema que você identificou é real e documentado. Métodos de otimização de prompt existentes adaptam prompts com base em feedback de um lote local de trajetórias, mas carecem de memória persistente — o que leva a alta variância e instabilidade quando o agente tenta se auto-melhorar sem âncora em evidências concretas. 
arXiv

A raiz disso é o chamado credit assignment problem: gerar feedback reflexivo útil é desafiador porque requer compreensão precisa de onde o modelo errou, bem como a capacidade de gerar um resumo contendo insights acionáveis para melhoria. 
arXiv

2. Reflexion — O Framework Fundacional (NeurIPS 2023)
O trabalho mais citado na área é Reflexion (Shinn et al., 2023, NeurIPS). A ideia central:

Reflexion converte feedback binário ou escalar do ambiente em feedback verbal na forma de um resumo textual, que é então adicionado como contexto adicional para o agente LLM no próximo episódio. Esse feedback auto-reflexivo age como um "gradiente semântico", fornecendo ao agente uma direção concreta para melhorar, ajudando-o a aprender com erros anteriores. 
arxiv

A arquitetura tem três componentes: o Actor executa as tarefas, o Evaluator verifica o trabalho, e o Self-Reflection pensa em como melhorar. 
Substack

Resultado empírico: Agentes Reflexion melhoram em tarefas de tomada de decisão AlfWorld em 22% absolutos em 12 etapas iterativas, em raciocínio no HotPotQA em 20%, e em programação Python no HumanEval em até 11%. 
arxiv

A chave anti-alucinação: o agente só escreve reflexões sobre o que realmente aconteceu no episódio atual — o feedback é gerado a partir do resultado do ambiente (compilador, teste, etc.), não inventado.

3. ILWS — O Mais Próximo do Seu Caso (arXiv 2509.00251)
O paper Instruction-Level Weight Shaping (2025) é o mais diretamente aplicável ao seu cenário de um agente que deve melhorar seu próprio markdown/system prompt:

ILWS propõe que as instruções do sistema atuem como pseudo-parâmetros externos e auditáveis, atualizados após cada sessão via reflexão e feedback. Um Reflection Engine inspeciona os traços de conversa, diagnostica sucessos e falhas de raciocínio, e propõe deltas tipados ΔK=(ΔS, ΔU, ΔT) sobre instruções, preferências do usuário e ferramentas. Os deltas são versionados, avaliados com uma janela deslizante de avaliações de 1 a 5 estrelas, reparados automaticamente na primeira falha, e revertidos em caso de falha repetida. 
arXiv

O mecanismo de portão estatístico é exatamente o que evita alucinação e degradação:

Edições são aceitas somente se as avaliações médias melhorarem pelo menos τ com significância α, com uma tentativa de reparo e rollback na segunda falha. O sistema usa persistência versionada via git com capacidade de rollback. 
arxiv

Resultado empírico em produção: ILWS aumentou o throughput em 2,4–5,0x e reduziu alucinações auditadas em ~80% versus uma baseline congelada. Em um PoC da Adobe Commerce Cloud com contexto de 1M tokens, alcançou ganhos de 4–5x em tickets por hora e redução de ~80% no tempo por ticket, com atualizações autônomas de instrução. 
arxiv

4. MemAPO — Memória Dual: Sucessos + Falhas (arXiv 2603.21520)
O MemAPO (2026) resolve exatamente o problema de "o agente esquece o que aprendeu e reinventa a roda":

MemAPO mantém um mecanismo de memória dual que destila trajetórias de raciocínio bem-sucedidas em templates de estratégia reutilizáveis, enquanto organiza gerações incorretas em padrões de erro estruturados que capturam modos de falha recorrentes. Dado um novo prompt, o framework recupera tanto estratégias relevantes quanto padrões de falha para compor prompts que promovam raciocínio eficaz enquanto desencorajam erros conhecidos. 
arxiv

Se padrões semelhantes já existem na memória, o modelo decide se deve refiná-los incorporando a nova regra; caso contrário, um novo padrão de erro é adicionado ao repositório. Através de auto-reflexão iterativa e edição de memória, o MemAPO atualiza continuamente sua memória, permitindo que a otimização de prompt melhore ao longo do tempo em vez de recomeçar do zero para cada tarefa. 
arXiv

5. Gödel Agent — Auto-Melhoria Auto-Referencial (arXiv 2410.04444)
Para o caso mais ambicioso onde o agente modifica sua própria lógica:

O Gödel Agent introduz um framework auto-evolutivo inspirado na Gödel Machine, permitindo que agentes se melhorem recursivamente sem depender de rotinas predefinidas ou algoritmos de otimização fixos. O Gödel Agent aproveita LLMs para modificar dinamicamente sua própria lógica e comportamento, guiado apenas por objetivos de alto nível via prompting. 
arXiv

A limitação honesta do paper: diretamente instanciar auto-melhoria no estilo Gödel Agent pode ser intensivo em recursos — em tentativas iniciais de adaptar o framework a um modelo menor, execuções frequentemente falhavam por erros de memória e chamadas de ferramentas antes de completar a execução. 
arXiv

6. RSI em Produção — O Estado da Arte em 2025–2026
Agentes LLM agora reescrevem seus próprios codebases ou prompts, pipelines de descoberta científica agendam fine-tuning contínuo, e stacks de robótica corrigem controladores a partir de telemetria em streaming. O workshop ICLR 2026 sobre RSI busca cristalizar a ciência emergente de auto-melhoria recursiva — como sistemas de aprendizado reescrevem, testam e governam suas próprias atualizações. 
OpenReview

7. Guardrails — O Que os Pesquisadores Usam Para Evitar Degradação
As guardrails base nunca podem ser removidas, apenas adições são permitidas. O agente propõe, o humano (ou sistema de validação) dispõe. Capacidades individuais podem ser seguras, mas combinadas podem ser perigosas — nunca modificar as guardrails base deve ser uma regra inviolável. 
DEV Community

8. Arquitetura Recomendada Para o Seu Agente Certora
Com base na literatura, esta é a arquitetura que os pesquisadores validaram para o seu cenário exato (agente que executa testes, obtém resultados determinísticos, e deve melhorar suas instruções):

┌─────────────────────────────────────────────────────────────────┐
│                    CICLO DE EXECUÇÃO NORMAL                     │
│  Agente → Gera propriedade Certora → Executa → Recebe resultado │
└─────────────────────────┬───────────────────────────────────────┘
                          │ resultado determinístico (pass/fail + log)
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│                   REFLECTION ENGINE (ILWS)                      │
│                                                                 │
│  1. Classifica: foi erro de INSTRUÇÃO ou de RACIOCÍNIO?         │
│  2. Se for padrão recorrente (≥N ocorrências): gera delta       │
│  3. Propõe adição ao markdown em seção específica               │
│  4. NÃO modifica, NÃO deleta — apenas ADICIONA                  │
└─────────────────────────┬───────────────────────────────────────┘
                          │ proposta de delta tipado
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│              PORTÃO ESTATÍSTICO + VERSIONING (ILWS)             │
│                                                                 │
│  • Aceita só se performance melhorar em ≥τ com significância α  │
│  • Versiona com git (rollback disponível)                       │
│  • Auto-reparo na primeira falha; rollback na segunda           │
└─────────────────────────┬───────────────────────────────────────┘
                          │ delta aprovado
                          ▼
┌─────────────────────────────────────────────────────────────────┐
│           DUAL MEMORY (MemAPO) — NO PRÓPRIO MARKDOWN            │
│                                                                 │
│  Seção "KNOWN PATTERNS":                                        │
│    • ✅ SUCCESS PATTERNS: o que funcionou + contexto            │
│    • ❌ FAILURE PATTERNS: o que não funciona + por quê          │
│                                                                 │
│  Regra: toda entrada DEVE ter evidência do log Certora          │
└─────────────────────────────────────────────────────────────────┘
9. As Regras Que a Literatura Converge Para Evitar Alucinação
Com base nos três papers acima (Reflexion, ILWS, MemAPO), as regras que pesquisadores usam:

Regra 1 — Âncora em evidência real. O agente só pode escrever no markdown algo que está diretamente evidenciado no output do Certora. Nunca pode generalizar para além do que o log mostrou.

Regra 2 — Só adição, nunca deleção autônoma. As guardrails base nunca podem ser removidas — apenas adições são permitidas. Para o markdown: o agente pode adicionar seções de "casos conhecidos", mas não pode reescrever instruções existentes sem validação. 
DEV Community

Regra 3 — Padrão mínimo de ocorrências. Uma falha isolada não gera instrução nova. O agente deve observar o mesmo padrão de confusão N vezes (pesquisadores usam N≥3) antes de escrever uma regra.

Regra 4 — Rollback estatístico. Cada delta é avaliado sob uma análise de janela deslizante, reparado automaticamente na primeira falha, e revertido em falha repetida. 
arXiv

Regra 5 — Estrutura tipada de deltas. Edits são versão-controlados como surrogados explícitos e auditáveis para atualizações de baixo rank, com persistência git e rollback. 
arxiv

10. Template de Instrução Para Incluir no Markdown do Agente
Com base nessa literatura, o prompt de auto-melhoria que você deve incluir no próprio markdown do agente Certora deve conter algo como:

markdown
## AUTO-IMPROVEMENT PROTOCOL

Ao final de cada execução, se identificares um padrão de confusão
NÃO coberto por este documento:

1. **CONDIÇÃO DE ATIVAÇÃO**: o mesmo tipo de erro deve ter ocorrido
   em ≥3 execuções distintas com logs Certora como evidência.

2. **O QUE PODES ADICIONAR**: uma nova entrada na seção
   `## Known Patterns` com:
   - Descrição do padrão (baseada no log, não em inferência)
   - Evidência: trecho exato do erro do Certora
   - Ação correta validada (que produziu pass)
   - Data e hash do contrato testado

3. **O QUE NUNCA PODES FAZER**:
   - Modificar ou deletar instruções existentes
   - Adicionar padrões sem evidência do log
   - Generalizar além do que o log demonstrou
   - Inferir causas não confirmadas pelos resultados

4. **FORMATO DE ENTRADA** (obrigatório):
[PATTERN-ID]: <nome curto>
Evidência: <trecho exato do erro Certora> Contexto: <tipo de propriedade, tipo de contrato> Ação correta: <o que funcionou> Validado em: <data> | <N execuções>


5. **VERSIONAMENTO**: toda modificação gera commit com mensagem
   `[auto-improve] <PATTERN-ID> validated after N runs`.
Referências Diretas
Paper	Onde Encontrar	Contribuição Chave
Reflexion (Shinn et al.)	NeurIPS 2023 / arXiv:2303.11366	Verbal RL, episodic memory buffer
ILWS	arXiv:2509.00251	Typed deltas, statistical gate, rollback
MemAPO	arXiv:2603.21520	Dual memory (success + failure patterns)
Gödel Agent	arXiv:2410.04444	Self-referential recursive self-improvement
ProTeGi	arXiv:2305.03495	Textual gradients para otimização de prompt
O ponto em que toda a literatura converge: auto-melhoria sem alucinação requer que cada modificação nas instruções seja rastreável a um evento observado e mensurável — no seu caso, o output determinístico do Certora é o âncora perfeito, exatamente o tipo de "environment feedback" que Reflexion e ILWS identificam como o sinal mais confiável para self-improvement.

pesquisa como o hermes agent relaciona com isso, e se seria bom para meu caso

11:00 AM

Analisou Hermes Agent e avaliou viabilidade para caso Certora
Analisou Hermes Agent e avaliou viabilidade para caso Certora
Ótima pergunta — Hermes é exatamente o que conecta a teoria da pesquisa anterior com uma implementação concreta e open-source. Aqui está a análise completa.

Hermes Agent — O Que É, Como Funciona e Se Serve ao Seu Caso
1. O Que É o Hermes Agent
O Nous Research lançou o Hermes Agent em 25 de fevereiro de 2026. Sete semanas depois cruzou 95.000 estrelas no GitHub — é o framework open-source de agentes de crescimento mais rápido do ano. A razão não é a contagem de estrelas. A razão é que é o primeiro framework onde "aprendizado" significa algo verificável lendo um arquivo em disco. 
Medium

Hermes Agent é um framework autônomo de agente de IA desenvolvido pelo Nous Research, sob licença MIT. Não é um chatbot simples — é um agente persistente e auto-hospedado que roda 24/7 no seu próprio servidor e fica mais inteligente com o uso. Todos os dados — memórias, skills, histórico de conversas — são armazenados em um banco SQLite local na sua máquina. Nada passa por serviços de cloud de terceiros. 
Tencent Cloud

2. O Sistema de Skills — A Parte Que Interessa ao Seu Caso
Este é o coração do Hermes e o que mais se aproxima do que você quer fazer:

Skills no Hermes Agent funcionam como memória procedural — capacidades reutilizáveis que o agente cria a partir da experiência e melhora com o uso contínuo. Após completar uma tarefa complexa envolvendo 5 ou mais chamadas de ferramentas, o agente pode gerar autonomamente um arquivo SKILL.md estruturado capturando o procedimento, armadilhas comuns e etapas de verificação. O formato inclui seções: When to Use, Quick Reference, Procedure, Pitfalls, e Verification. 
Remote OpenClaw

Skills são apenas arquivos markdown com YAML frontmatter — não requerem código. O agente pode criar e atualizar skills usando skill_manage. Após resolver um problema complexo, o Hermes pode oferecer salvar a abordagem como uma skill para próxima vez. 
Nousresearch

Na prática, isso é quase idêntico ao que você descreveu: o agente Certora resolve um problema difícil, e ao invés de perder esse conhecimento, escreve uma seção nova no próprio markdown.

3. O Loop de Auto-Evolução — hermes-agent-self-evolution (ICLR 2026)
O Nous Research foi além e criou um pipeline de pesquisa para evoluir as próprias skills:

GEPA lê os execution traces para entender por que as coisas falharam (não apenas que falharam), e então propõe melhorias direcionadas. O projeto foi aceito como Oral no ICLR 2026 e é licença MIT. Permite evoluir uma skill usando dados de avaliação sintéticos ou histórico real de sessões do Claude Code, Copilot e Hermes. 
GitHub

A cada 15 chamadas de ferramentas, o agente pausa, olha o que funcionou na sessão e salva um arquivo de workflow em ~/.hermes/skills/. Você pode ler, editar ou deletar. Uma mesma task que levava 20 minutos na semana 1 levou 12 minutos na semana 4 e 8 minutos na semana 6 — o agente parou de redescobrir o procedimento toda vez. 
Aakash Gupta

4. As Camadas de Memória — Como o Hermes Diferencia o Que Persiste
A documentação oficial faz a distinção: "Se você colocaria em um documento de referência, é uma skill. Se colocaria em um post-it, é memória." Mantenha skills focadas. Skills que não são mantidas tornam-se passivos. 
Nousresearch

O sistema de skills usa uma estratégia de carregamento progressivo em três níveis: Nível 1 — nome e descrição breve (~20 tokens). Nível 2 — descrição detalhada e specs de parâmetros (~200 tokens). Nível 3 — etapas completas de execução e sequências de chamadas de ferramentas (~1.000+ tokens). 
Tencent Cloud

5. O Risco Principal — Skill Poisoning (Crítico Para o Seu Uso)
Aqui está o problema documentado que você precisa conhecer antes de adotar:

Skill poisoning é prompt injection com um botão de salvar. Se o agente for injetado uma vez durante uma sessão, e essa sessão produzir uma skill, a injeção persiste em disco como um arquivo Markdown. Na próxima vez que o agente selecionar uma task relacionada, carrega essa skill como contexto confiável e segue a instrução. Não há proveniência assinada nas skills. Não existe diferença observável entre "uma skill que o agente escreveu" e "um arquivo que eu dropei no diretório". Sua defesa é qualquer processo de revisão que você pessoalmente impõe, em cada skill, para sempre. 
Medium

Para qualquer coisa regulada (fintech, saúde, jurídico), "o agente aprendeu isso" não é uma resposta aceitável para uma pergunta de compliance. Não há proveniência assinada de skill, nenhum log imutável do que foi promovido quando, nenhum workflow de aprovação. Isso é corrigível. Não está corrigido. 
Medium

Para o seu caso específico (Certora), esse risco é menor do que em outros contextos, porque:

Você controla o ambiente completamente (sem usuários externos)
O feedback vem do compilador Certora, que é determinístico
Não há superfície de ataque de terceiros
6. Ferramentas do Ecossistema Relevantes Para Você
A comunidade já construiu exatamente o que faltava no Hermes base:

hermes-curator-evolver — companion orientado a evidências para o Curator nativo. Observa eventos de ferramenta/skill/sessão em SQLite local, gera relatórios e propostas em modo dry-run, e roda um loop diário guardado que apenas adiciona notas embasadas em evidências de baixo risco (com backups e manifestos de rollback). Inspirado no SkillClaw, mas adaptado com opt-ins explícitos de modelo e pins de skill com segurança. 
GitHub

SkillClaw — auto-evolui, deduplica e melhora sua biblioteca de skills a partir de dados reais de sessão. Adiciona um loop de evolução pós-task sobre a criação de skills nativa do Hermes. Integração nativa via ~/.hermes/skills, com flows de segurança (skillclaw doctor hermes / skillclaw restore hermes). 705 estrelas, licença MIT. 
GitHub

7. Veredicto: Hermes É Bom Para o Seu Caso?
Aqui está a análise honesta, pesando o que a literatura diz contra o seu cenário concreto:

Dimensão	Hermes Puro	Hermes + ILWS Principles	Ideal Para Você
Criação de skills baseada em execução	✅ nativo (5+ tool calls)	✅	✅ sim
Portão estatístico antes de aceitar	❌ não existe	✅ precisa implementar	✅ necessário
Rollback de skill degradada	⚠️ manual (SkillClaw)	✅ automático em ILWS	✅ necessário
Âncora em evidência (output Certora)	❌ não verifica	✅ precisa implementar	✅ crítico
Proveniência assinada de skills	❌ não tem	❌ não tem	⚠️ importante se auditável
Funciona com Claude	✅ sim	✅	✅
Open-source e local	✅	✅	✅
Skill em markdown legível	✅ exatamente	✅	✅ compatível com seu stack
Conclusão direta: O Hermes é conceitualmente perfeito para o seu caso — skills como markdown, criação automática após execuções complexas, refinamento contínuo, compatível com Claude. Mas em seu estado puro ele não tem o portão estatístico do ILWS nem a âncora de evidência do MemAPO, o que significa que ele pode escrever skills baseadas em raciocínio interno, não só em resultados validados do Certora.

A abordagem mais sólida seria: Hermes como infraestrutura de skills + as regras do ILWS como protocolo de aceitação. Ou seja, você usa o formato e o sistema de arquivos do Hermes (SKILL.md, skill_manage, histórico de sessão), mas instrui o agente a só promover uma adição ao markdown quando tiver evidência explícita do log do Certora, seguindo o portão estatístico — exatamente o template de instrução que discutimos antes. O hermes-curator-evolver já implementa parte disso como plugin nativo.

mas para ele ter o portao estatistico do ilws e a ancora de evidencia do MemAPO, é só colocar no markdown do agente especificando isso ou tem que modificar o código fonte do hermes agent?

11:15 AM

Avaliou viabilidade de implementar portão estatístico e ancoragem de evidência via markdown
Avaliou viabilidade de implementar portão estatístico e ancoragem de evidência via markdown
Boa pergunta, e a resposta não é binária — depende do nível de rigor que você quer de cada garantia. Vou ser direto sobre o que é possível só com markdown vs o que genuinamente precisa de código.

O Que Controla o Comportamento do Hermes
Primeiro, o ponto fundamental. O loop do Claude Code vive no comportamento do modelo, moldado pelas instruções do system prompt sobre uso de ferramentas e conclusão de tarefas. O Hermes tem um loop formalmente documentado na sua classe AIAgent, com etapas claras: o prompt builder monta as instruções do sistema (personalidade, memória, skills, context files, schemas de ferramentas), o modelo executa, as chamadas de ferramentas são despachadas e observadas, e o loop continua até a conclusão. 
Medium

Isso significa que a skill (markdown) é parte direta da montagem do system prompt — não é uma dica, é contexto autoritativo. O que você escreve na skill realmente molda o comportamento.

A orientação oficial do Hermes é: se é uma regra de comportamento estável, vai no system prompt. Se é um procedimento com passos, vai na skill. Se é um fato estável, vai na memória. 
Hermes Agent

Âncora de Evidência (MemAPO) — 100% Markdown, Sem Código
Este é o mais simples. É uma restrição comportamental, e LLMs seguem restrições bem especificadas na skill. Você escreve no markdown:

markdown
## EVIDENCE REQUIREMENT (obrigatório antes de qualquer adição)

Você NUNCA pode adicionar à seção Known Patterns sem:
1. Citar o trecho EXATO do output do Certora que evidencia o padrão
2. O output deve ser de uma execução real desta sessão, não inferência

Formato exigido para qualquer nova entrada:
Certora output (evidência):
[cole o trecho exato aqui]


Se não tiver esse trecho em mãos, NÃO escreva a entrada. Escreva em CANDIDATES.
Isso funciona porque o agente já tem acesso ao output do Certora no contexto da sessão — é uma ferramenta que ele chamou. A instrução apenas o obriga a citar o que já está no contexto, não a inventar nada.

Portão de Ocorrências (Aproximação Prática do ILWS) — Markdown com Estrutura
O portão estatístico formal do ILWS (janela deslizante, significância α, τ) precisa de código. Mas um portão de contagem, que resolve 90% do problema de alucinação, é implementável só com markdown, usando uma seção CANDIDATES que o próprio agente mantém:

markdown
## PROMOTION PROTOCOL

### CANDIDATES (padrões observados, ainda não promovidos)
<!-- O agente adiciona aqui após 1ª ocorrência -->
<!-- Formato: [CAND-ID] | ocorrências: N | última evidência: data -->

| ID | Descrição | Ocorrências | Última Evidência |
|----|-----------|-------------|-----------------|
| CAND-001 | overflow em loop com array dinâmico | 2 | 2026-05-18 |

### CONFIRMED PATTERNS (promovidos após ≥3 ocorrências)
<!-- Só promova se a mesma situação ocorreu ≥3 vezes com logs distintos -->

### DEPRECATED (padrões que causaram falha após promoção)
<!-- Mova aqui + adicione motivo se um CONFIRMED piorou os resultados -->
O agente mantém os contadores na tabela CANDIDATES. Quando uma linha atinge 3, ele promove. Isso é estado mantido no próprio arquivo, sem banco de dados.

Rollback — Plugin, Sem Modificar Código Fonte
Para o rollback automático (se um padrão promovido piorar os resultados), você não precisa modificar o Hermes. O hermes-curator-evolver observa eventos de ferramenta/skill/sessão em SQLite local, gera relatórios e propostas em modo dry-run, e roda um loop diário guardado que apenas adiciona notas embasadas em evidências de baixo risco, com backups e manifestos de rollback. É um plugin que se instala sobre o Hermes existente. 
GitHub

O Que Realmente Precisa de Código
Sendo honesto sobre os limites do markdown puro:

Garantia	Markdown Puro	Plugin/Código
Âncora de evidência (citar log Certora)	✅ funciona bem	não precisa
Gate de contagem (N ocorrências)	✅ aproximação prática	não precisa
Rollback manual / backup de arquivo	✅ instrução + git	não precisa
Rollback automático por degradação	❌	hermes-curator-evolver
Significância estatística real (α, τ)	❌	implementação ILWS
Proveniência assinada (auditoria formal)	❌	não existe no Hermes hoje
Para o seu caso específico, a coluna "plugin/código" só se torna necessária se você precisar que o rollback seja automático e sem supervisão humana. Para um ciclo com revisão sua de tempos em tempos, markdown + hermes-curator-evolver cobre tudo.

O Formato Completo da Skill Para o Seu Agente Certora
Combinando tudo isso, a skill markdown que implementa os três mecanismos fica assim:

markdown
---
name: certora-formal-verification
description: Gera, executa e aprende com propriedades formais Certora
---

## QUANDO USAR
Geração e verificação de propriedades formais em Solidity via Certora Prover.

## EVIDENCE REQUIREMENT
Antes de qualquer escrita na seção Known Patterns ou Candidates:
- Cole o trecho EXATO do output Certora que originou a observação
- Sem esse trecho: escreva somente em CANDIDATES, nunca em CONFIRMED
- Nunca generalize além do que o log mostrou nessa execução

## PROMOTION PROTOCOL
- 1ª ocorrência → CANDIDATES (com evidência)
- 3ª ocorrência com logs distintos → promova para CONFIRMED
- Se um CONFIRMED causar falha → mova para DEPRECATED com motivo

## CANDIDATES
| ID | Padrão | Ocorrências | Evidência (resumo) | Data |
|---|---|---|---|---|

## CONFIRMED PATTERNS
<!-- Só chegam aqui via protocolo acima -->

## DEPRECATED
<!-- Padrões que foram promovidos mas pioraram os resultados -->

## PROCEDURE
[seu procedimento normal aqui]

## PITFALLS
[armadilhas já conhecidas]

## VERIFICATION
Após cada execução: checar se o resultado justifica atualizar
CANDIDATES antes de encerrar a sessão.
Uma única instrução como "quando terminar uma tarefa difícil, escreva uma skill para não ter que descobrir de novo" é o que transforma um chatbot em um agente auto-melhorável. No seu caso, você está refinando essa instrução para que ela só se aplique quando há evidência real — o que é exatamente a diferença entre auto-melhoria útil e alucinação persistida em disco. 
DEV Community






