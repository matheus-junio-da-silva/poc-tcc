# require
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
Contract IUniswapV3
+------------------+-------------------+
| Function         | require or assert |
+------------------+-------------------+
| exactInputSingle |                   |
| exactInput       |                   |
| slot0            |                   |
| token0           |                   |
| token1           |                   |
+------------------+-------------------+
INFO:Printers:
Contract ABCCApp
+-------------------------------------+-------------------------------------------------------+
| Function                            | require or assert                                     |
+-------------------------------------+-------------------------------------------------------+
| constructor                         |                                                       |
| owner                               |                                                       |
| _checkOwner                         |                                                       |
| renounceOwnership                   |                                                       |
| transferOwnership                   |                                                       |
| _transferOwnership                  |                                                       |
| _msgSender                          |                                                       |
| _msgData                            |                                                       |
| _contextSuffixLength                |                                                       |
| constructor                         |                                                       |
| dashboard                           |                                                       |
| setPartUSDT                         |                                                       |
| setOperator                         |                                                       |
| setVaultAddr                        |                                                       |
| setEnable                           |                                                       |
| getCanClaimUSDT                     |                                                       |
| deposit                             | require(bool,string)(isEnable,CLOSED)                 |
|                                     | require(bool,string)(number > 0,E0)                   |
|                                     | require(bool,string)(referer != msg.sender,E2)        |
|                                     | require(bool,string)(totalUSDT == 0,E1)               |
|                                     | require(bool,string)(users[referer].joinTime > 0,E3)  |
| claimDDDD                           | require(bool,string)(totalUSDT > 0,E0)                |
| processReferers                     |                                                       |
| getUserDirects                      |                                                       |
| getIncomeRecords                    |                                                       |
| setSettlePrice                      |                                                       |
| setLevelRate                        | require(bool,string)(index < REFERER_RATES.length,E0) |
|                                     | require(bool,string)(value < 100,E1)                  |
| setClaimFee                         | require(bool,string)(target < 100,E0)                 |
| setUserRemainingUSDT                | require(bool,string)(users[target].joinTime > 0,E0)   |
| getFixedDay                         |                                                       |
| addFixedDay                         |                                                       |
| getDDDDValueInUSDT                  |                                                       |
| getTokenPriceInBNB                  |                                                       |
| getBNBPriceInUSDT                   |                                                       |
| emergencyFixed                      |                                                       |
| slitherConstructorVariables         |                                                       |
| slitherConstructorConstantVariables |                                                       |
+-------------------------------------+-------------------------------------------------------+
INFO:Printers:
Contract IERC20
+--------------+-------------------+
| Function     | require or assert |
+--------------+-------------------+
| totalSupply  |                   |
| balanceOf    |                   |
| transfer     |                   |
| allowance    |                   |
| approve      |                   |
| transferFrom |                   |
+--------------+-------------------+
INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
