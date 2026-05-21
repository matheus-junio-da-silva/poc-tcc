# modifiers
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
Contract IUniswapV3
+------------------+-----------+
| Function         | Modifiers |
+------------------+-----------+
| exactInputSingle | []        |
| exactInput       | []        |
| slot0            | []        |
| token0           | []        |
| token1           | []        |
+------------------+-----------+
INFO:Printers:
Contract ABCCApp
+-------------------------------------+---------------+
| Function                            | Modifiers     |
+-------------------------------------+---------------+
| constructor                         | []            |
| owner                               | []            |
| _checkOwner                         | []            |
| renounceOwnership                   | ['onlyOwner'] |
| transferOwnership                   | ['onlyOwner'] |
| _transferOwnership                  | []            |
| _msgSender                          | []            |
| _msgData                            | []            |
| _contextSuffixLength                | []            |
| constructor                         | []            |
| dashboard                           | []            |
| setPartUSDT                         | ['onlyOwner'] |
| setOperator                         | ['onlyOwner'] |
| setVaultAddr                        | ['onlyOwner'] |
| setEnable                           | ['onlyOwner'] |
| getCanClaimUSDT                     | []            |
| deposit                             | []            |
| claimDDDD                           | []            |
| processReferers                     | []            |
| getUserDirects                      | []            |
| getIncomeRecords                    | []            |
| setSettlePrice                      | ['onlyOwner'] |
| setLevelRate                        | ['onlyOwner'] |
| setClaimFee                         | ['onlyOwner'] |
| setUserRemainingUSDT                | ['onlyOwner'] |
| getFixedDay                         | []            |
| addFixedDay                         | []            |
| getDDDDValueInUSDT                  | []            |
| getTokenPriceInBNB                  | []            |
| getBNBPriceInUSDT                   | []            |
| emergencyFixed                      | ['onlyOwner'] |
| slitherConstructorVariables         | []            |
| slitherConstructorConstantVariables | []            |
+-------------------------------------+---------------+
INFO:Printers:
Contract IERC20
+--------------+-----------+
| Function     | Modifiers |
+--------------+-----------+
| totalSupply  | []        |
| balanceOf    | []        |
| transfer     | []        |
| allowance    | []        |
| approve      | []        |
| transferFrom | []        |
+--------------+-----------+
INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
