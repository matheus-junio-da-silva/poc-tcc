# 08 — Revisão Crítica Consolidada

> **Versão:** 1.0  
> **Data:** 2026-05-21  
> **Revisor:** Análise crítica sobre 11 documentos de contexto fornecidos pelo autor

---

## 1. Resumo

| Categoria | Quantidade |
|-----------|-----------|
| 🔴 Problemas graves (bloqueantes) | 6 |
| 🟠 Problemas moderados | 5 |
| 🟡 Pontos de atenção menores | 3 |
| ✅ Elementos corretos e sólidos | Múltiplos |

---

## 2. Problemas Graves (🔴)

### 2.1 Regra CVL para Padrão NONE — Lógica Incorreta

**Documento afetado:** `docs/agents/mnt/user-data/outputs/hermes-security-agents/access-control/skill.md` (linhas 288-309)

**O que estava:**
```cvl
rule anyoneCanCall_{FuncName} {
    require e1.msg.sender != e2.msg.sender;
    {funcName}@withrevert(e1, args);
    bool reverted1 = lastReverted;
    {funcName}@withrevert(e2, args);
    bool reverted2 = lastReverted;
    assert reverted1 || reverted2;
}
```

**Por que está errado:** A segunda chamada à função opera sobre o estado **modificado pela primeira chamada**. Se a primeira chamada transfere tokens, a segunda pode reverter por saldo insuficiente — não por falta de access control. Isso gera falsos negativos (conclui que há AC quando na verdade não há).

**Correção aplicada em:** `docs/arquitetura/05-agente-access-control.md`, seção 5.4

---

### 2.2 Invariant `adminRoleNeverZero` — Factualmente Incorreto

**Documento afetado:** `docs/agents/mnt/user-data/outputs/hermes-security-agents/access-control/skill.md` (linhas 242-243)

**O que estava:**
```cvl
invariant adminRoleNeverZero(bytes32 role)
    getRoleAdmin(role) != to_bytes32(0);
```

**Por que está errado:** No OpenZeppelin `AccessControl`:
- `DEFAULT_ADMIN_ROLE = 0x00` (bytes32 zero)
- `getRoleAdmin(DEFAULT_ADMIN_ROLE)` retorna `0x00` (é admin de si mesmo)
- Este invariant falharia imediatamente no caso mais básico de RBAC

**Correção aplicada em:** `docs/arquitetura/05-agente-access-control.md` — invariant removido, substituído por `zeroAddressHasNoRole` que é correto.

---

### 2.3 Template `.conf` Incompleto — Projetos Reais Não Compilam

**Documento afetado:** `docs/agents/mnt/user-data/outputs/hermes-security-agents/access-control/skill.md` (linhas 315-326)

**O que faltava:**
- `packages_path` para resolver imports do `node_modules` (Hardhat)
- `solc_remaps` para resolver imports de `lib/` (Foundry)
- `link` para conectar múltiplos contratos
- Distinção entre frameworks (Hardhat vs Foundry vs standalone)

**Impacto:** Qualquer projeto com OpenZeppelin (que é a grande maioria) falharia na compilação com `Source not found: @openzeppelin/...`

**Correção aplicada em:** `docs/arquitetura/05-agente-access-control.md`, seção 6 — templates separados por framework

---

### 2.4 Sem Suporte a Múltiplos Contratos

**Documentos afetados:** Todos os skills de agentes

**O que faltava:** Projetos Solidity reais quase sempre têm múltiplos contratos (Token + Governance + Timelock). O access control frequentemente está distribuído entre eles. O Certora precisa de `--link` para conectar contratos.

**Correção aplicada em:** `docs/arquitetura/05-agente-access-control.md`, seção 6 — template multi-contract adicionado

---

### 2.5 Contradição de Licença no Guia do Hermes

**Documento afetado:** `docs/hermes-agent/Hermes_Agent_Guia_Completo.md`

**Contradição:**
- Linha 9: "Licença: Apache 2.0"
- Linha 227: "Licença MIT / Apache 2.0"
- `docs/perguntas_respostas/arquitetura.md` linha 181: "licença MIT"

**Status:** Não corrigido nos documentos de arquitetura (é erro do documento fonte). O repositório oficial do Hermes Agent no GitHub deve ser consultado para a licença real.

---

### 2.6 Ausência de Documentação de Configuração de Ambiente

**Documentos afetados:** Nenhum documento cobria este tópico

**Impacto:** Sem `CERTORAKEY`, `certoraRun` falha silenciosamente. Sem `solc` na versão correta, Slither e Certora não compilam. Sem `npm install` / `forge install`, imports não resolvem.

**Correção aplicada em:** `docs/arquitetura/06-configuracao-ambiente.md` — documento completamente novo

---

## 3. Problemas Moderados (🟠)

### 3.1 Slither Enricher — Execução Individual vs Combinada Contraditória

**Documento afetado:** `docs/agents/mnt/user-data/outputs/hermes-security-agents/slither-enricher/skill.md`

**Problema:** O skill mostra dois modos de execução:
- Linhas 19-24: comandos individuais por printer
- Linhas 70-72: execução combinada

A forma combinada é mais eficiente (compila uma vez), mas pode ter output JSON diferente. O skill não especifica qual usar.

**Correção aplicada em:** `docs/arquitetura/04-agente-slither-enricher.md` — unificada para execução combinada com nota sobre eficiência

---

### 3.2 Portão de Contagem (N≥3) Sem Base Empírica

**Documento afetado:** `docs/perguntas_respostas/arquitetura.md` (linha 286)

**Problema:** Afirma que o portão de contagem "resolve 90% do problema de alucinação" — sem citação ou evidência empírica. O revisor 1 já identificou este problema.

**Status:** Mantido nos skills como mecanismo prático, mas sem a afirmação de 90%. A eficácia deve ser validada empiricamente com execuções reais.

---

### 3.3 Ausência de Fluxo de Dados Documentado

**Documentos afetados:** `docs/agents/README.md`, `docs/agents/skill.md`

**Problema:** Nenhum documento especificava exatamente quais dados fluem entre agentes, em que formato e tamanho estimado em tokens.

**Correção aplicada em:** `docs/arquitetura/02-fluxo-de-dados.md` — documento completamente novo

---

### 3.4 Sem Procedimento para Configuração do Ambiente

**Ver seção 2.6** — tratado como problema grave.

---

### 3.5 Hooks CVL Dependem de Layout de Storage

**Documento afetado:** `docs/certora_properties_creation_guide/1.md` (linhas 500-517)

**Problema:** Hooks como `hook Sstore _roles[KEY bytes32 role][KEY address account]` assumem nomes de slots específicos. Se o contrato usar proxy ou layout diferente, o hook silenciosamente não dispara, causando falsos negativos.

**Correção aplicada em:** `docs/arquitetura/05-agente-access-control.md`, seção 11 — aviso sobre dependência de layout de storage com recomendação de verificar com `variable-order`

---

## 4. Pontos de Atenção Menores (🟡)

### 4.1 Printer `entry-points` Ausente do Enricher

**Documento afetado:** `docs/agents/mnt/user-data/outputs/hermes-security-agents/slither-enricher/skill.md`

O printer `entry-points` mostra funções de ponto de entrada que alteram estado — diretamente relevante para access control. Estava ausente da seleção.

**Correção aplicada em:** `docs/arquitetura/04-agente-slither-enricher.md` — adicionado como obrigatório

---

### 4.2 Dois Guias de Slither Idênticos

- `docs/slither_guide/1.md` (714 linhas)
- `docs/perguntas_respostas/slither_guide.md` (714 linhas)

São cópias idênticas. Manter apenas um e referenciar.

---

### 4.3 Estrutura de Pastas dos Agentes Confusa

O caminho `docs/agents/mnt/user-data/outputs/hermes-security-agents/` parece um output gerado por ferramenta, não documentação de arquitetura intencional. Se esses skills são a versão final, considerar mover para um path como `docs/agents/skills/{vuln-type}/`.

---

## 5. Elementos Corretos e Sólidos (✅)

| Elemento | Documento | Avaliação |
|----------|-----------|-----------|
| Referências acadêmicas (Reflexion, ILWS, MemAPO, Gödel Agent, ProTeGi) | `arquitetura.md` | Todos os 5 papers existem, IDs arXiv corretos |
| Arquitetura de auto-melhoria (portão de contagem + evidência) | `arquitetura.md` | Metodologicamente coerente |
| Risco de Skill Poisoning | `arquitetura.md` | Corretamente identificado e mitigado |
| Decisão de separar agentes por vulnerabilidade | `README.md` | Correta e bem justificada |
| Slither como enriquecedor (não detector) | `README.md` | Abordagem correta |
| Templates CVL para Ownable e RBAC (exceto os erros corrigidos) | `access-control/skill.md` | Majoritariamente corretos |
| Procedimento de iteração do spec (max 5×) | `access-control/skill.md` | Prático e razoável |
| Handling de resultados (PASS/FAIL/TIMEOUT/SANITY) | `README.md` | Correto e completo |
| Guia de CVL para access control | `certora_properties_creation_guide/1.md` | Bem documentado com referências verificáveis |
| Guia do Slither | `slither_guide/1.md` | Completo e correto |
| Guia do Certora Cloud | `certora_cloud_run_guide/1.md` | Completo e correto |
| Resultado PASS ≠ "contrato seguro" | Múltiplos | Corretamente documentado |
| ILWS como preprint de autor único (ressalva) | `revisor1.md` | Honestamente identificado |

---

## 6. Recomendações de Prioridade

### Imediato (antes de executar os agentes)

1. ✅ Corrigir regra para padrão NONE → feito em `05-agente-access-control.md`
2. ✅ Remover invariant `adminRoleNeverZero` → feito em `05-agente-access-control.md`
3. ✅ Expandir template `.conf` com resolução de imports → feito
4. ✅ Criar documento de configuração de ambiente → feito em `06-configuracao-ambiente.md`

### Antes de produção

5. Testar os templates CVL contra pelo menos 3 contratos reais (OpenZeppelin examples)
6. Validar que o output combinado de printers do Slither é parseável corretamente
7. Definir procedimento claro para multi-contract com `--link`

### Melhoria contínua

8. Eliminar duplicação do guia Slither
9. Reorganizar pasta de agentes para path mais limpo
10. Validar empiricamente a eficácia do portão N≥3
