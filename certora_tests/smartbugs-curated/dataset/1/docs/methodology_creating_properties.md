# Methodology for Creating Properties - FibonacciBalance Vulnerability Analysis

## 1. Identificação da Vulnerabilidade

### Análise Manual do Código
A vulnerabilidade foi identificada através da revisão estática do contrato `FibonacciBalance.sol`:

1. **Função `withdraw()` sem proteção** (linha 31):
   - Função pública que transfere fundos
   - Não possui nenhum modifier que verifique autorização
   - Qualquer endereço pode chamar e drenar o contrato

2. **Fallback function sem controle** (linha 38):
   - Aceita delegatecalls arbitrários para `fibonacciLibrary`
   - Não valida quem pode chamar
   - Permite que qualquer um execute funções através do delegatecall

### Tipo de Vulnerabilidade
- **Categoria**: SWC-118 (Missing Constructor) / Arbitrary Function Call
- **Tipo de Controle de Acesso**: Missing Authorization
- **Severidade**: CRÍTICA

## 2. Padrão de Vulnerabilidade

### Causa Raiz
- Falta de verificação de `msg.sender` antes de operações sensíveis
- Uso irrestrito de `delegatecall` sem whitelist de funções
- Nenhum armazenamento de endereço autorizado (owner)

### Impacto
- **Roubo de Fundos**: Qualquer pessoa pode chamar `withdraw()` e receber fundos
- **Execução Arbitrária**: Fallback permite chamar qualquer função em fibonacciLibrary
- **Comprometimento Total**: Contrato é completamente inseguro

## 3. Correção Implementada

### Mudanças Principais
1. **Armazenar o owner**:
   ```solidity
   address public owner;
   
   constructor(address _fibonacciLibrary) public payable {
       owner = msg.sender;  // Armazena o endereço que fez o deploy
       fibonacciLibrary = _fibonacciLibrary;
   }
   ```

2. **Adicionar modifier `onlyOwner`**:
   ```solidity
   modifier onlyOwner() {
       require(msg.sender == owner, "Only owner can call this function");
       _;
   }
   ```

3. **Proteger `withdraw()`**:
   ```solidity
   function withdraw() public onlyOwner {
       // ... resto da função
   }
   ```

4. **Remover fallback inseguro**:
   - Substitui por função `safeCall()` que valida seletores de função
   - Apenas `onlyOwner` pode chamar
   - Apenas `fibSig` (setFibonacci) é permitido

## 4. Propriedades CVL Verificadas

### Propriedade 1: `onlyDeployerCanWithdraw`
- **Objetivo**: Verificar que apenas o deployer pode chamar withdraw com sucesso
- **Falha na versão vulnerável**: ✓ (qualquer um pode chamar)
- **Sucesso na versão corrigida**: ✓ (apenas owner consegue)

### Propriedade 2: `unauthorizedUserCannotWithdraw`
- **Objetivo**: Verificar que usuários não autorizados não podem retirar fundos
- **Falha na versão vulnerável**: ✓ (qualquer um consegue)
- **Sucesso na versão corrigida**: ✓ (revert para non-owner)

### Propriedade 3: `delegatecallWithoutAccessControl`
- **Objetivo**: Documentar que delegatecall sem proteção é vulnerável
- **Demonstração**: Mostra que fallback não valida acesso

## 5. Técnicas de Análise Utilizadas

### Análise Estática
- Leitura do código-fonte para identificar funções públicas sem modifiers
- Busca por operações sensíveis (transfer, delegatecall) sem guards
- Verificação de presença de owner ou autorização

### Padrões de Código
- Identificação de padrões conhecidos de vulnerabilidade
- Comparação com padrão seguro do OpenZeppelin (Ownable)
- Análise de delegatecall sem whitelist

### Verificação com Certora
- Propriedades CVL validam comportamento esperado
- Contraexemplos mostram como a vulnerabilidade pode ser explorada
- Testes com contrato corrigido verificam que patches funcionam

## 6. Validação

### Testes Realizados
1. ✓ Compilação do contrato vulnerável
2. ✓ Compilação do contrato corrigido
3. ✓ Propriedades CVL escritas
4. ✓ Execução de regras no Certora Prover

### Resultado Esperado
- **Contrato Vulnerável**: Propriedades falham (contraexemplo: qualquer endereço consegue chamar withdraw)
- **Contrato Corrigido**: Propriedades passam (apenas owner consegue chamar)

## 7. Referências

- OpenZeppelin Ownable: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
- Smart Contract Best Practices: https://smartcontractssecurity.github.io/
- Certora Prover Documentation: https://docs.certora.com/

## 8. Conclusão

A vulnerabilidade foi identificada através de análise estática, corrigida com padrão bem estabelecido (Ownable), 
e validada com propriedades CVL. A correção é robusta e segue boas práticas da indústria.
