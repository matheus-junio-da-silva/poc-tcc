# 🔓 Subtipos de Broken Access Control (S5) em Smart Contracts

No ecossistema Web3 e em Smart Contracts, as falhas de "Broken Access Control" (Controle de Acesso Quebrado), categorizadas aqui sob o rótulo **S5**, ocorrem quando o código falha em impor adequadamente quem pode executar ações ou modificar o estado e quando essas ações podem ser tomadas.

Com base na análise do dataset Web3Bugs, detalhamos abaixo os 3 subtipos específicos de falhas de controle de acesso encontrados.

---

## 1. S5-3: Unrestricted Privileged Functions (Funções Privilegiadas Acessíveis por Qualquer Um)

**A Falha Mais Comum (56% do dataset)**

### Definição
Ocorre quando funções destinadas ao administrador, dono (owner) ou uma governança descentralizada (DAO) estão implementadas como públicas (`public`) ou externas (`external`) sem nenhum tipo de verificador de autorização (como um modificador `onlyOwner`). Qualquer usuário na blockchain pode chamar a função e executar ações restritas.

### Exemplo de Ataque
Um contrato tem uma função `setFee(uint256 newFee)` sem proteção. Um atacante chama essa função e altera a taxa do protocolo para 0, resultando em perda de receita, ou para 100%, roubando ou travando fundos de outros usuários. Outro exemplo clássico visto no dataset é a de "mintagem" (criação) de tokens livremente (visto em Vader Protocol `mintSynth()` e `mintFungible()`).

### Impacto
Catastrófico ou Alto. Pode permitir a emissão infinita de tokens (inflação e colapso de preços), saque indevido de fundos inteiros, ou a apropriação do sistema por um invasor.

### Mitigação Principal
Utilização do padrão *Role-Based Access Control* (RBAC) ou modificadores como o `onlyOwner` do OpenZeppelin:
```solidity
function restrictedAction() external onlyOwner { ... }
```

---

## 2. S5-1: State Variable Modification (Usuários Podem Atualizar Variáveis de Estado Privilegiadas)

**A Falha de Manipulação do Sistema (28% do dataset)**

### Definição
Distinto de uma função administrativa solta, neste caso, o próprio design lógico de uma função de usuário quebrou o isolamento de privilégio. A função permite ao usuário comum alterar dados que deveriam ser fixos, ou ele pode passar parâmetros arbitrários que acabam adulterando os saldos e o estado que pertence a outro usuário (manipulação de contas cruzadas) ou do próprio protocolo. 

### Exemplo de Ataque
Em um protocolo de liquidação, um usuário passa um endereço de outra pessoa na variável `user` em uma chamada de foreclouse ou cobrança, sem que o sistema valide se `msg.sender == user`. Como visto na Reality Cards (`collectRentUser`), permitindo penalizar/tormar depósitos alheios. Outro cenário: o atacante envia valores zerados ou pequenos (dust attacks) que acabam disparando um bug matemático que subverte variáveis globais como "interest rate" (taxas de juros em Timeswap `state.y` e `state.z`).

### Impacto
Alto, levando frequentemente a corrupção de estado interno, manipulação de taxas de juros nos pools, e roubo disfarçado passando pelo fluxo de regras do negócio, ao invés da porta da frente.

### Mitigação Principal
Efetuar validação rigorosa dos inputs e verificação forte da origem do chamador (`msg.sender` limitando ações restritas exclusivamente àquilo que os inputs do mensageiro tem autorização para modificar).
```solidity
require(msg.sender == targetUser, "Not authorized to modify this user");
```

---

## 3. S5-2: Temporal Access Control Violation (Funções Acessíveis no Tempo Errado)

**A Falha Temporal / Lógica de Estado (16% do dataset)**

### Definição
Geralmente, há uma limitação temporal para quando funções ou transações podem acontecer. Por exemplo, a colheita de recompensa tem limites, a inicialização de um pool só pode ser feita uma vez, ou fundos só saem do cofre se passados X blocos. Uma falha do tipo S5-2 quebra esse limite temporal e a transação é ativada "fora de época", ou invocada em loop sem a trava adequada.

### Exemplo de Ataque
Caso claríssimo no bug do Vault no "Concur" (onde sacões iterativos limpam o contrato) e nas recompensas do "PoolTogether", em que um usuário consegue clamar retornos contínuos mesmo depois das "epochs" de pagamento oficiais já terem terminado. Nenhuma verificação temporal (`block.timestamp` ou `block.number`) ou limite de reinicialização é efetuado para abortar o percurso.

### Impacto
Geralmente leva a um esvaziamento (drain) total e gradual das pools de recompensas se detectado no fim das épocas normais ou a esgotamentos imediatos estilo reentrância, gerando inflação falsa e roubo da liquidez de terceiros.

### Mitigação Principal
Uso eficaz de condicionais de tempo ou limite de estados, marcando inícios, encerramentos, ou flags limitadoras de inicialização via `initializer` e tempos com `block.timestamp`.
```solidity
require(block.timestamp <= expiryDate, "Action has expired");
require(!hasClaimed[msg.sender], "Already claimed");
```