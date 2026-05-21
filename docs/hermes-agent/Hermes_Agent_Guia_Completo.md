**HERMES AGENT**

Guia Completo e Detalhado

*O Agente de IA Open Source que Aprende e Cresce com Você*

Desenvolvido por: Nous Research  |  Lançamento: 26 de fevereiro de 2026

Licença: Apache 2.0  |  GitHub Stars: 140.000+  |  Plataforma: Linux, macOS, WSL2

# **1\. O Que é o Hermes Agent?**

O Hermes Agent é um agente de IA autônomo, open source e auto-hospedado, desenvolvido pela Nous Research e lançado em 26 de fevereiro de 2026\. Diferente de um simples chatbot ou copiloto de IDE, o Hermes é um agente persistente que vive no seu servidor ou máquina local, aprende com as interações ao longo do tempo e se torna progressivamente mais capaz.

Em menos de três meses após o lançamento, o projeto ultrapassou 140.000 estrelas no GitHub, tornando-se o framework de agente open source com crescimento mais rápido do ano — e, segundo o OpenRouter, o agente de IA mais utilizado no mundo em maio de 2026\.

**Problema que resolve:** A maioria dos frameworks de agentes anteriores (como LangGraph e CrewAI) utilizava bancos de dados vetoriais como "memória de longo prazo", mas na prática o agente não aprendia de verdade — apenas recuperava texto. O Hermes resolve isso com um mecanismo de auto-melhoria real, onde o agente converte fluxos de trabalho bem-sucedidos em habilidades (skills) reutilizáveis, verificáveis e compartilháveis.

*Em resumo, não é um chatbot. Não é um copiloto. É um agente que vive na sua máquina e fica mais inteligente a cada dia.*

# **2\. Contexto e Origem — Nous Research**

A Nous Research surgiu informalmente em 2022 como um coletivo nativo da internet, formado através do Discord e Twitter, e foi formalizada em 2023\. Os fundadores incluem Jeff Quesnelle, Karan Malhotra, Teknium e Shivani Mitra. Desde o início, a organização se posicionou como um laboratório focado em open source e descentralização, com o objetivo de tornar a inteligência artificial amplamente acessível.

### **Linha do tempo de desenvolvimentos-chave:**

* **2022–2023:** Série de modelos Hermes (Hermes 2, Hermes 3\) — fine-tuning de modelos open source sobre Llama e Mistral.

* **2024:** DisTrO (treinamento distribuído pela internet), ambientes de simulação WorldSim e Doomscroll, e o framework de RL Atropos.

* **2025:** Hermes 4 com raciocínio híbrido e geração sintética de dados em larga escala.

* **Fevereiro de 2026:** Lançamento do Hermes Agent — síntese lógica de todos os trabalhos anteriores, o primeiro agente real alternativo ao OpenClaw.

# **3\. Arquitetura e Como Funciona**

O Hermes Agent é construído em torno do loop do próprio agente como motor de orquestração síncrono central. Isso o diferencia fundamentalmente de outros frameworks como o OpenClaw, que usa um gateway como plano de controle central.

## **3.1 O Loop Principal do Agente**

O ciclo central do Hermes é:

1. Receber uma tarefa em linguagem natural

2. Decompor a tarefa em passos menores

3. Selecionar a ferramenta mais adequada da biblioteca de 40+ tools

4. Executar, observar o resultado e iterar

5. Registrar o que funcionou e o que falhou na memória episódica

6. Se a tarefa foi difícil e bem-sucedida, criar uma skill reutilizável

## **3.2 Componentes Principais**

| Componente | Função |
| :---- | :---- |
| Loop do Agente (AIAgent) | Núcleo síncrono de orquestração — gerencia planejamento, execução de ferramentas e memória |
| Gateway de Mensagens | Processo único que roteia mensagens entre plataformas (Telegram, Discord, Slack, WhatsApp, Signal, CLI) |
| Scheduler (Cron) | Executa tarefas agendadas em sessões isoladas e entrega outputs automaticamente |
| Skills System | Biblioteca de habilidades procedurais criadas pelo agente e pela comunidade |
| SQLite Store | Persistência de sessões e histórico de conversas com busca semântica |
| ACP Integration | Agent Communication Protocol para integração com editores externos |
| RL Environments (Atropos) | Ambientes de reinforcement learning para treinamento de comportamentos agenticos |

## **3.3 Ambientes de Execução Suportados**

O Hermes é portátil e não está amarrado a uma única plataforma ou máquina:

* Terminal local (Linux, macOS, WSL2)

* VPS (Virtual Private Server)

* Docker (com hardening de segurança)

* SSH remoto — executa comandos em qualquer servidor conectado

* Infraestrutura serverless

* Sistemas com GPU — NVIDIA RTX PCs, RTX PRO Workstations, DGX Spark

# **4\. Sistema de Memória em Três Camadas**

Este é o diferencial técnico mais importante do Hermes em relação a qualquer outro framework de agente open source. A memória não é apenas um banco de dados vetorial — é um sistema em camadas que suporta aprendizado real.

## **4.1 Memória de Curto Prazo (Short-Term)**

É o contexto da tarefa ativa: objetivo atual, passos executados, outputs das ferramentas, resultados intermediários. Corresponde à janela de contexto do LLM, gerenciada cuidadosamente para evitar overflow. Não persiste entre sessões.

## **4.2 Memória de Longo Prazo (Long-Term)**

Um armazenamento persistente de chave-valor para fatos e preferências do usuário que persistem entre sessões. Se você informa ao agente suas convenções de código preferidas, linguagem de programação favorita ou estrutura de um projeto, ele se lembra na próxima vez — sem necessidade de re-explicar.

## **4.3 Memória Episódica (Episodic)**

Esta é a camada de auto-melhoria. Após cada tarefa, o Hermes grava um registro estruturado contendo: o que a tarefa exigiu, qual abordagem foi utilizada, quais ferramentas foram selecionadas, o que teve sucesso e o que falhou. Em tarefas futuras com características similares, o agente recupera esses registros e os usa para ajustar sua abordagem antes da execução.

**Como funciona a recuperação:** O agente gera um embedding da tarefa atual e realiza uma busca por similaridade de cosseno no banco episódico para encontrar episódios relevantes. O aprendizado é por recuperação — os pesos do modelo não são alterados, mas o desempenho em tarefas repetidas melhora mensuradamente ao longo do tempo.

**Nota prática:** Na primeira utilização, não há episódios anteriores para recuperar. Após 20–30 tarefas em um domínio, você começa a observar melhora real — menos tentativas falsas, melhor seleção de ferramentas, menos intervenção necessária.

# **5\. Sistema de Skills — Auto-Melhoria em Ação**

O sistema de skills é o mecanismo que torna o Hermes verdadeiramente auto-melhorável. Quando o agente resolve um problema difícil com sucesso, ele cria automaticamente um documento de skill (SKILL.md) que codifica o método — não apenas o resultado.

## **5.1 O Que é uma Skill?**

Uma skill é um documento em formato SKILL.md que descreve como realizar uma categoria de tarefa: as ferramentas a usar, a sequência de passos, armadilhas comuns a evitar e exemplos de uso. Skills são:

* Pesquisáveis pelo agente em tarefas futuras

* Compartilháveis com outros usuários via agentskills.io

* Compatíveis com o padrão aberto agentskills.io

* Auditáveis — você pode ler o arquivo em disco e verificar o que o agente aprendeu

* Instaláveis da comunidade com um único comando

## **5.2 Skills Integradas (40+)**

O Hermes vem com mais de 40 skills pré-construídas e curadas pela Nous Research, cobrindo:

| Categoria | Exemplos de Skills |
| :---- | :---- |
| MLOps | Treinamento de modelos, geração de dados, exportação de trajetórias |
| GitHub | Criação de PRs, issues, gerenciamento de repositórios |
| Diagramação | Geração de diagramas de arquitetura, fluxogramas |
| Anotações | Captura e organização de notas persistentes |
| Automação Web | Scraping, extração de páginas, preenchimento de formulários |
| Execução de Código | Python, bash, scripts em ambientes sandbox |
| Gerenciamento de Arquivos | Leitura, escrita, diff, movimentação de arquivos |

# **6\. Ferramentas Integradas (40+)**

A seleção de ferramentas é automática — o agente raciocina sobre qual tool invocar em cada passo, sem que você precise especificar. As categorias principais são:

| Categoria | Ferramentas Disponíveis |
| :---- | :---- |
| Arquivo e Sistema | Leitura, escrita, diff, movimentação, busca de arquivos |
| Web e Navegador | Busca web, extração de páginas, automação completa de browser (clicar, digitar, screenshot) |
| Terminal | Execução de comandos locais, Docker, SSH remoto |
| API | Chamadas HTTP customizadas com headers personalizados |
| Código | Execução em sandbox, Python, bash |
| Visão e Mídia | Análise de imagens, geração de imagens, text-to-speech |
| Comunicação | Mensagens via Telegram, Discord, Slack, WhatsApp, Signal |
| Sub-Agentes | Spawn de agentes paralelos com conversas e terminais isolados |

# **7\. Gateway Multi-Plataforma**

Um dos recursos mais práticos do Hermes é o gateway de mensagens: um único processo que conecta todas as plataformas de comunicação. Isso desacopla o assistente do seu laptop — o processamento acontece no servidor, mas a interface permanece leve e sempre disponível.

## **7.1 Plataformas Suportadas**

* Telegram

* Discord

* Slack

* WhatsApp

* Signal

* CLI (terminal)

Você pode iniciar uma conversa no Telegram e continuá-la no terminal — o contexto é mantido. O gateway também suporta transcrição de mensagens de voz.

## **7.2 Configurando o Gateway**

\# Assistente de configuração interativo

hermes gateway setup

\# Iniciar o gateway de mensagens

hermes gateway

\# Instalar como serviço do sistema (systemd)

hermes gateway install

# **8\. Agendamento e Automações (Cron)**

O Hermes possui um scheduler integrado que executa tarefas recorrentes automaticamente em sessões isoladas. Os outputs são entregues via qualquer plataforma configurada.

Exemplos de automações possíveis:

* Relatórios diários (ex: resumo de e-mails, métricas do projeto)

* Backups noturnos de arquivos e repositórios

* Auditorias semanais de segurança ou código

* Briefings matinais com resumo de notícias relevantes

* Monitoramento contínuo de APIs externas

# **9\. Suporte a Modelos (Model-Agnostic)**

O Hermes não está preso a um único provedor de IA. Você configura qual modelo usar, e trocar o backend é apenas uma variável de ambiente.

| Provedor | Exemplos de Modelos | Integração |
| :---- | :---- | :---- |
| Nous Portal | Hermes 4 e variantes | OAuth nativo |
| OpenRouter | 200+ modelos disponíveis | Chave de API |
| OpenAI | GPT-4o, o3 | Endpoint compatível OpenAI |
| Anthropic | Claude Sonnet 4.6, Claude Opus 4.6 | Endpoint compatível |
| Ollama (local) | Llama 3, Mistral, Phi-3 etc. | Totalmente on-premise |
| vLLM / API customizada | Qualquer modelo | Endpoint OpenAI-compatível |

**Dica de custo:** Você pode rotear tarefas mais simples para um modelo local (Ollama) e tarefas que exigem raciocínio avançado para um modelo frontier via API, controlando os custos operacionais.

# **10\. Segurança e Privacidade**

O Hermes foi projetado com segurança como padrão (safer-by-default), não como configuração opcional:

| Recurso | Detalhe |
| :---- | :---- |
| Zero Telemetria | Nenhum dado é enviado para a Nous Research ou terceiros |
| Armazenamento Local | Toda a memória fica em \~/.hermes/ na sua máquina |
| Container Hardening | Root somente leitura, capabilities reduzidas, limites de PID |
| Autorização do Usuário | Verificações de aprovação antes de ações sensíveis |
| Filtragem de Credenciais | O agente não expõe credenciais no output |
| Varredura de Contexto | Analisa o contexto antes de executar para evitar injeção de prompt |
| Licença MIT / Apache 2.0 | Código 100% auditável — você pode ler cada linha |

# **11\. Capacidades MLOps e Treinamento**

Além da automação de tarefas, o Hermes é uma plataforma para geração de dados de treinamento, experimentos de RL e exportação de trajetórias para fine-tuning.

## **11.1 Processamento em Batch**

Gera milhares de trajetórias de chamadas de ferramentas em paralelo, com checkpointing automático. Permite configurar workers, tamanhos de batch e distribuições de toolset.

## **11.2 Treinamento por Reinforcement Learning**

Integração com Atropos (também da Nous Research) para RL em comportamentos agenticos. Conta com 11 parsers de tool-call para treinamento de qualquer arquitetura de modelo.

## **11.3 Exportação de Trajetórias**

Exporta conversas no formato ShareGPT para fine-tuning. A compressão de trajetórias permite encaixar dados de treinamento nos budgets de tokens.

# **12\. Instalação — Passo a Passo**

O Hermes Agent foi projetado para ser instalado com um único comando, sem pré-requisitos manuais. O script instala automaticamente uv, Python 3.11, clona o repositório e configura tudo.

## **Passo 1: Instalar**

curl \-fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash

## **Passo 2: Configurar**

\# Assistente de configuração interativo

hermes setup

\# Ou escolher o modelo diretamente

hermes model

## **Passo 3: Iniciar**

hermes

CLI interativo completo com ferramentas, memória e skills. Simples assim.

## **Passo 4: Configurar Plataformas de Mensagens (Opcional)**

\# Assistente de configuração do gateway

hermes gateway setup

\# Iniciar gateway

hermes gateway

\# Instalar como serviço

hermes gateway install

## **Passo 5: Atualizar**

hermes update

Baixa as últimas alterações e reinstala dependências. Execute a qualquer momento para obter novas funcionalidades.

**⚠️ Aviso:** O suporte nativo ao Windows é experimental. Recomenda-se instalar o WSL2 e executar o Hermes Agent a partir dele.

# **13\. Casos de Uso Práticos**

## **13.1 Desenvolvimento de Software**

* Automatizar revisão de código e criação de PRs no GitHub

* Executar testes, fazer builds e deployments via SSH

* Manter contexto do projeto entre sessões (arquitetura, padrões de código, convenções)

* Gerar documentação automaticamente a partir do código

## **13.2 Pesquisa e Análise**

* Busca web automatizada e extração de informações de páginas

* Sumarização de documentos e relatórios com agendamento recorrente

* Monitoramento contínuo de fontes de dados (APIs, sites, feeds RSS)

## **13.3 MLOps e Data Science**

* Geração de datasets de treinamento em batch

* Execução de experimentos de RL com Atropos

* Exportação de trajetórias para fine-tuning de modelos

* Pipelines de avaliação automatizados

## **13.4 Automação Pessoal e Produtividade**

* Briefings matinais entregues via Telegram

* Gerenciamento de arquivos, backups automáticos

* Redação e edição de documentos longos com memória de projetos

* Agente de suporte pessoal acessível via WhatsApp ou Discord

# **14\. Comparativo: Hermes Agent vs Concorrentes**

| Fator | Hermes Agent | OpenClaw | Claude Code | Cursor Agent |
| :---- | :---- | :---- | :---- | :---- |
| Arquitetura | Loop do agente como núcleo | Gateway como plano de controle | Copiloto de IDE | Copiloto de IDE |
| Memória | 3 camadas (curto/longo/episódica) | Explícita, baseada em arquivos | Contexto da sessão | Contexto da sessão |
| Auto-Melhoria | ✅ Skills geradas automaticamente | ❌ Skills humanas | ❌ | ❌ |
| Hospedagem | Self-hosted, 100% local | Self-hosted | Nuvem (Anthropic) | Nuvem |
| Plataformas | Telegram, Discord, Slack, etc. | CLI e IDE | CLI | IDE |
| Modelos | Agnóstico (qualquer provider) | Agnóstico | Claude apenas | Claude/GPT-4o |
| Agendamento | ✅ Cron integrado | Limitado | ❌ | ❌ |
| Licença | Apache 2.0 (grátis) | MIT (grátis) | Pago | Pago |
| Melhor para | Agente persistente de longo prazo | Controle manual granular | Codificação rápida | Codificação em IDE |

# **15\. Requisitos do Sistema**

| Recurso | Mínimo | Recomendado |
| :---- | :---- | :---- |
| RAM | 4 GB | 8 GB ou mais |
| CPU | Qualquer CPU moderna | Multi-core para sub-agentes paralelos |
| GPU | Não necessário (via API) | NVIDIA RTX (para modelos locais) |
| Armazenamento | \~500 MB | 2 GB+ (para skills e memória) |
| OS | Linux, macOS, WSL2 | Ubuntu 22.04+ / macOS 13+ |
| Python | 3.11 (instalado automaticamente) | 3.11+ |
| Custo mensal | $0 (self-hosted) | \~$5/mês (VPS básica) |

# **16\. Limitações e Pontos de Atenção**

O Hermes Agent ainda é um produto em fase inicial. É importante ter clareza sobre suas limitações:

* **Documentação incompleta:** A documentação ainda tem lacunas em algumas áreas avançadas.

* **Comunidade pequena:** Embora crescente, a comunidade ainda é menor que a de frameworks mais estabelecidos.

* **Confiabilidade variável:** O desempenho varia dependendo do modelo backend configurado. Modelos menores (7B) podem apresentar seleção incorreta de ferramentas.

* **Não é plug-and-play:** Requer algum conhecimento técnico para configuração e depuração de problemas de Python.

* **Não é para produção crítica sem testes:** Não garante conclusão de tarefas em fluxos de automação sem supervisão cuidadosa.

* **Windows nativo experimental:** Usuários Windows devem usar WSL2.

# **17\. Para Quem o Hermes Agent é Indicado?**

## **✅ Ideal para:**

* Desenvolvedores que trabalham em ambientes onde enviar código para APIs de terceiros é restrito

* Profissionais que desejam um agente persistente que aprenda seus projetos ao longo do tempo

* Pesquisadores de MLOps que precisam gerar trajetórias e datasets de treinamento

* Usuários que querem experimentar infraestrutura agentica open source sem pagar por uma licença proprietária

* Quem quer um assistente acessível via Telegram/Discord/WhatsApp 24/7

## **❌ Não é ideal para:**

* Quem precisa de um produto polido com documentação completa e suporte garantido

* Integração de IDE para codificação diária (use Cursor ou Claude Code para isso)

* Quem não se sente confortável depurando problemas de configuração em Python

* Automações críticas de produção sem testes extensivos

# **18\. Recursos e Links Úteis**

| Recurso | URL |
| :---- | :---- |
| Site oficial | https://hermes-agent.org |
| Repositório GitHub | https://github.com/NousResearch/hermes-agent |
| Nous Research | https://nousresearch.com |
| Marketplace de Skills | https://agentskills.io |
| OpenRouter (modelos) | https://openrouter.ai |

# **Conclusão**

O Hermes Agent representa uma mudança real de paradigma no espaço de agentes de IA open source. Enquanto a maioria dos frameworks anteriores chamava um banco de dados vetorial de "memória" e encerrava o assunto, o Hermes constrói um sistema em que o aprendizado é verificável, persistente e reutilizável.

O mecanismo de skills — que converte experiências bem-sucedidas em procedimentos codificados — é o diferencial técnico mais concreto. Combinado com o sistema de memória em três camadas, o agendamento integrado, o suporte a múltiplas plataformas de mensagens e a filosofia de 100% local e agnóstico de modelo, o Hermes entrega algo que nenhum outro framework open source havia entregado até fevereiro de 2026: um agente que genuinamente melhora com o uso.

Para quem está disposto a investir no setup inicial e aceitar que ainda é um projeto em maturação, o Hermes Agent oferece a fundação mais sólida atualmente disponível para construir um assistente de IA verdadeiramente pessoal e persistente.

*Documento gerado com base em fontes públicas — Maio de 2026*