## vars-and-auth
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
Contract IUniswapV3
+------------------+-------------------------+--------------------------+
| Function         | State variables written | Conditions on msg.sender |
+------------------+-------------------------+--------------------------+
| exactInputSingle | []                      | []                       |
| exactInput       | []                      | []                       |
| slot0            | []                      | []                       |
| token0           | []                      | []                       |
| token1           | []                      | []                       |
+------------------+-------------------------+--------------------------+

Contract ABCCApp
+-------------------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------+
| Function                            | State variables written                                                                                                                             | Conditions on msg.sender                           |
+-------------------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------+
| constructor                         | ['_owner']                                                                                                                                          | []                                                 |
| owner                               | []                                                                                                                                                  | []                                                 |
| _checkOwner                         | []                                                                                                                                                  | []                                                 |
| renounceOwnership                   | ['_owner']                                                                                                                                          | []                                                 |
| transferOwnership                   | ['_owner']                                                                                                                                          | []                                                 |
| _transferOwnership                  | ['_owner']                                                                                                                                          | []                                                 |
| _msgSender                          | []                                                                                                                                                  | []                                                 |
| _msgData                            | []                                                                                                                                                  | []                                                 |
| _contextSuffixLength                | []                                                                                                                                                  | []                                                 |
| constructor                         | ['_owner', 'isOperators']                                                                                                                           | []                                                 |
| dashboard                           | []                                                                                                                                                  | []                                                 |
| setPartUSDT                         | ['partUSDT']                                                                                                                                        | []                                                 |
| setOperator                         | ['isOperators']                                                                                                                                     | []                                                 |
| setVaultAddr                        | ['vaultAddr']                                                                                                                                       | []                                                 |
| setEnable                           | ['isEnable']                                                                                                                                        | []                                                 |
| getCanClaimUSDT                     | []                                                                                                                                                  | []                                                 |
| deposit                             | ['globalData', 'userDirects', 'users']                                                                                                              | ['require(bool,string)(referer != msg.sender,E2)'] |
| claimDDDD                           | ['globalData', 'userIncomeRecords', 'users']                                                                                                        | []                                                 |
| processReferers                     | ['globalData', 'userIncomeRecords', 'users']                                                                                                        | []                                                 |
| getUserDirects                      | []                                                                                                                                                  | []                                                 |
| getIncomeRecords                    | []                                                                                                                                                  | []                                                 |
| setSettlePrice                      | ['dailyPrices']                                                                                                                                     | []                                                 |
| setLevelRate                        | ['REFERER_RATES']                                                                                                                                   | []                                                 |
| setClaimFee                         | ['claimFee']                                                                                                                                        | []                                                 |
| setUserRemainingUSDT                | ['users']                                                                                                                                           | []                                                 |
| getFixedDay                         | []                                                                                                                                                  | []                                                 |
| addFixedDay                         | ['fixedDay']                                                                                                                                        | []                                                 |
| getDDDDValueInUSDT                  | []                                                                                                                                                  | []                                                 |
| getTokenPriceInBNB                  | []                                                                                                                                                  | []                                                 |
| getBNBPriceInUSDT                   | []                                                                                                                                                  | []                                                 |
| emergencyFixed                      | []                                                                                                                                                  | []                                                 |
| slitherConstructorVariables         | ['BNB', 'DDDD', 'REFERER_RATES', 'USDT', 'bnbUSDTPool', 'claimFee', 'ddddBNBPool', 'fixedDay', 'isEnable', 'partUSDT', 'swapV3Router', 'vaultAddr'] | []                                                 |
| slitherConstructorConstantVariables | ['DAY', 'Q96']                                                                                                                                      | []                                                 |
+-------------------------------------+-----------------------------------------------------------------------------------------------------------------------------------------------------+----------------------------------------------------+

Contract Ownable
+----------------------+-------------------------+--------------------------+
| Function             | State variables written | Conditions on msg.sender |
+----------------------+-------------------------+--------------------------+
| _msgSender           | []                      | []                       |
| _msgData             | []                      | []                       |
| _contextSuffixLength | []                      | []                       |
| constructor          | ['_owner']              | []                       |
| owner                | []                      | []                       |
| _checkOwner          | []                      | []                       |
| renounceOwnership    | ['_owner']              | []                       |
| transferOwnership    | ['_owner']              | []                       |
| _transferOwnership   | ['_owner']              | []                       |
+----------------------+-------------------------+--------------------------+

Contract IERC20
+--------------+-------------------------+--------------------------+
| Function     | State variables written | Conditions on msg.sender |
+--------------+-------------------------+--------------------------+
| totalSupply  | []                      | []                       |
| balanceOf    | []                      | []                       |
| transfer     | []                      | []                       |
| allowance    | []                      | []                       |
| approve      | []                      | []                       |
| transferFrom | []                      | []                       |
+--------------+-------------------------+--------------------------+

Contract Context
+----------------------+-------------------------+--------------------------+
| Function             | State variables written | Conditions on msg.sender |
+----------------------+-------------------------+--------------------------+
| _msgSender           | []                      | []                       |
| _msgData             | []                      | []                       |
| _contextSuffixLength | []                      | []                       |
+----------------------+-------------------------+--------------------------+

INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
