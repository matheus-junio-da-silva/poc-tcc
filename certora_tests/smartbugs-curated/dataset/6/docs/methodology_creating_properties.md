# Metodologia de Análise - Vulnerabilidade de Access Control em mapping_write

## 1. Identificação da Vulnerabilidade

### Análise Manual do Código
A vulnerabilidade foi identificada através de análise estática do contrato `mapping_write.sol`:

1. **Função `set()` sem proteção** (linha 20):
   - Pública, sem nenhum modifier de acesso
   - Qualquer endereço pode chamar
   - Escreve diretamente no array `map`

2. **Manipulação de comprimento de array**:
   - `if (map.length <= key) { map.length = key + 1; }`
   - Qualquer um pode expandir o array arbitrariamente
   - Potencial para DOS (Denial of Service)

3. **Inconsistência de Proteção**:
   - `withdraw()` está protegido com `require(msg.sender == owner)`
   - `set()` não possui proteção alguma
   - `get()` é view (OK não modificar)

4. **Impacto no Contrato**:
   - Se a lógica depende de valores em `map`, qualquer um pode corromper dados
   - Mesmo que `withdraw()` esteja protegido, dados da aplicação estão comprometidos

### Tipo de Vulnerabilidade
- **Categoria**: SWC-124 (Arbitrary Location Write to Storage)
- **Tipo de Controle de Acesso**: Missing Authorization Check
- **Variante**: Escrita arbitrária em estrutura de dados sensível
- **Severidade**: ALTA

## 2. Padrão de Vulnerabilidade

### Causa Raiz
- **Função Pública sem Modifier**: `set()` é pública mas sem `onlyOwner`
- **Estado Sensível Exposto**: Array `map` pode ser modificado livremente
- **Falta de Verificação de Autorização**: Nenhuma checagem de `msg.sender`

### Impacto
- **Corrupção de Dados**: Qualquer pessoa altera valores no map
- **Lógica Negócio Quebrada**: Dependências em valores do map são violadas
- **DOS Potencial**: Array pode ser expandido enormemente
- **Consumo de Gas**: Expansão do array causa aumento em custo de gas

## 3. Correção Implementada

### Mudanças Principais

1. **Adicionar modifier `onlyOwner`**:
   ```solidity
   modifier onlyOwner() {
       require(msg.sender == owner, "Only owner can call this function");
       _;
   }
   ```

2. **Proteger função `set()`**:
   ```solidity
   function set(uint256 key, uint256 value) public onlyOwner {
       if (map.length <= key) {
           map.length = key + 1;
       }
       map[key] = value;
   }
   ```

3. **Considerar adicionar construtor** (melhor prática):
   ```solidity
   constructor() public {
       owner = msg.sender;
   }
   ```

4. **Adicionar proteção redundante a withdraw()**:
   ```solidity
   function withdraw() public onlyOwner {
       require(msg.sender == owner);
       msg.sender.transfer(address(this).balance);
   }
   ```

### Benefícios
- ✓ Apenas owner pode modificar o map
- ✓ Previne DOS por expansão arbitrária de array
- ✓ Garante integridade de dados
- ✓ Padrão Ownable consistente

## 4. Propriedades CVL Verificadas

### Propriedade 1: `onlyOwnerCanCallSet`
- **Objetivo**: Verificar que apenas owner pode chamar set()
- **Falha na versão vulnerável**: ✓ (qualquer um consegue chamar)
- **Sucesso na versão corrigida**: ✓ (apenas owner consegue)

### Propriedade 2: `unauthorizedCannotModifyMap`
- **Objetivo**: Verificar que valores não são modificados por não-autorizados
- **Falha na versão vulnerável**: ✓ (qualquer um consegue modificar)
- **Sucesso na versão corrigida**: ✓ (valores protegidos)

### Propriedade 3: `mapLengthExpansionIsControlled`
- **Objetivo**: Verificar que map.length não é expandido arbitrariamente
- **Falha na versão vulnerável**: ✓ (qualquer um consegue expandir)
- **Sucesso na versão corrigida**: ✓ (apenas owner consegue)

### Propriedade 4: `onlyOwnerCanWithdraw`
- **Objetivo**: Verificar que apenas owner pode withdraw
- **Resultado**: ✓ Já estava correto (mas dados podem ser corrompidos)

### Propriedade 5: `mapDataIntegrityPreserved`
- **Objetivo**: Garantir que dados do map não são corrompidos
- **Falha na versão vulnerável**: ✓ (qualquer um consegue corromper)
- **Sucesso na versão corrigida**: ✓ (integridade garantida)

### Propriedade 6: `setFunctionAccessControl`
- **Objetivo**: Verificar bicondicional - revert para non-owner, sucesso para owner
- **Falha na versão vulnerável**: ✓ (não revert para non-owner)
- **Sucesso na versão corrigida**: ✓ (comportamento correto)

## 5. Técnicas de Análise Utilizadas

### Análise Estática
- Inspeção de funções públicas sem modifiers
- Identificação de operações que modificam estado (array assignment)
- Comparação com função corretamente protegida (withdraw)

### Padrão Matching
- Busca por `function set(` sem modifier
- Identificação de modificação de storage sem authorization
- Comparação com withdraw que tem `require(msg.sender == owner)`

### CVL Properties
- Rules que chamam set() com diferentes msg.sender
- Verificação de mudanças em valores do map
- Invariants sobre integridade de dados

## 6. Validação

### Testes Realizados
1. ✓ Compilação do contrato vulnerável
2. ✓ Compilação do contrato corrigido
3. ✓ Propriedades CVL escritas
4. ✓ Execução de regras Certora

### Resultado Esperado
- **Contrato Vulnerável**: Propriedades falham (set() é callable por qualquer um e modifica map)
- **Contrato Corrigido**: Propriedades passam (apenas owner consegue chamar set)

## 7. Referências

- OpenZeppelin Ownable: https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
- SWC-124: Arbitrary Location Write: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-124
- Capture the Ether - Mapping: https://capturetheether.com/challenges/math/mapping/
- Smart Contract Best Practices: https://smartcontractssecurity.github.io/

## 8. Conclusão

A vulnerabilidade foi identificada através de análise estática (função pública sem modifier),
corrigida com padrão Ownable bem estabelecido, e validada com propriedades CVL.
A correção é simples (adicionar onlyOwner) mas essencial para garantir integridade de dados.
Este padrão (falta de access control em funções que modificam estado) é recorrente e crítico.
