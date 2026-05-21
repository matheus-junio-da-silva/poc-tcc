# data-dependency
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
Contract IUniswapV3
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
+----------+--------------+

Function exactInputSingle(IUniswapV3.ExactInputSingleParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function exactInput(IUniswapV3.ExactInputParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function slot0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token1()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
INFO:Printers:
Contract IUniswapV3
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
+----------+--------------+

Function exactInputSingle(IUniswapV3.ExactInputSingleParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function exactInput(IUniswapV3.ExactInputParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function slot0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token1()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Contract ABCCApp
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable          | Dependencies                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| USDT              | ['USDT']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| DDDD              | ['DDDD']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| BNB               | ['BNB']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| swapV3Router      | ['swapV3Router']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ddddBNBPool       | ['ddddBNBPool']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bnbUSDTPool       | ['bnbUSDTPool']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| vaultAddr         | ['target', 'vaultAddr']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| partUSDT          | ['partUSDT', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| claimFee          | ['claimFee', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| isEnable          | ['flag', 'isEnable']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| DAY               | ['DAY']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Q96               | ['Q96']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| fixedDay          | ['fixedDay', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| REFERER_RATES     | ['REFERER_RATES', 'value']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| users             | ['BNB', 'DAY', 'DDDD', 'Q96', 'REFERER_RATES', 'TUPLE_2', 'TUPLE_3', 'TUPLE_4', 'USDT', 'amount', 'amountUSDT', 'block.timestamp', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'canUSDT', 'claimFee', 'ddddAmount', 'ddddBNBPool', 'ddddPrice', 'diffDay', 'diffSecond', 'dynamicUSDT', 'fee', 'fixedDay', 'fullDDDD', 'incomeUSDT', 'number', 'params', 'partUSDT', 'payUSDT', 'price', 'referer', 'sqrtPriceX96', 'staticUSDT', 'swapV3Router', 'target', 'this', 'tokenBnbPool', 'tokenPriceInBNB', 'totalUSDT', 'user', 'users', 'value', 'valueInUSDT']                |
| dailyPrices       | ['Q96', 'TUPLE_3', 'TUPLE_4', 'amount', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'dailyPrices', 'ddddBNBPool', 'price', 'sqrtPriceX96', 'tokenBnbPool', 'tokenPriceInBNB', 'valueInUSDT']                                                                                                                                                                                                                                                                                                                                                                                |
| userDirects       | ['userDirects']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| userIncomeRecords | ['userIncomeRecords']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| isOperators       | ['flag', 'isOperators']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| globalData        | ['BNB', 'DAY', 'DDDD', 'Q96', 'REFERER_RATES', 'TUPLE_2', 'TUPLE_3', 'TUPLE_4', 'USDT', 'amount', 'amountUSDT', 'block.timestamp', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'canUSDT', 'claimFee', 'ddddAmount', 'ddddBNBPool', 'ddddPrice', 'diffDay', 'diffSecond', 'dynamicUSDT', 'fee', 'fixedDay', 'fullDDDD', 'globalData', 'incomeUSDT', 'keepUSDT', 'number', 'params', 'partUSDT', 'payUSDT', 'price', 'sqrtPriceX96', 'staticUSDT', 'swapV3Router', 'target', 'this', 'tokenBnbPool', 'tokenPriceInBNB', 'totalUSDT', 'user', 'users', 'value', 'valueInUSDT'] |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Function constructor()
+---------------------------+-----------------+
| Variable                  | Dependencies    |
+---------------------------+-----------------+
| ABCCApp.USDT              | []              |
| ABCCApp.DDDD              | []              |
| ABCCApp.BNB               | []              |
| ABCCApp.swapV3Router      | []              |
| ABCCApp.ddddBNBPool       | []              |
| ABCCApp.bnbUSDTPool       | []              |
| ABCCApp.vaultAddr         | []              |
| ABCCApp.partUSDT          | []              |
| ABCCApp.claimFee          | []              |
| ABCCApp.isEnable          | []              |
| ABCCApp.DAY               | []              |
| ABCCApp.Q96               | []              |
| ABCCApp.fixedDay          | []              |
| ABCCApp.REFERER_RATES     | []              |
| ABCCApp.users             | []              |
| ABCCApp.dailyPrices       | []              |
| ABCCApp.userDirects       | []              |
| ABCCApp.userIncomeRecords | []              |
| ABCCApp.isOperators       | ['isOperators'] |
| ABCCApp.globalData        | []              |
+---------------------------+-----------------+
Function dashboard(address)
+---------------------------+--------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                     |
+---------------------------+--------------------------------------------------------------------------------------------------+
| target                    | []                                                                                               |
| data                      | ['DDDD', 'TUPLE_0', 'USDT', 'data', 'dynamicUSDT', 'staticUSDT', 'target', 'totalUSDT', 'users'] |
| staticUSDT                | ['TUPLE_0', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                            |
| ABCCApp.USDT              | ['USDT']                                                                                         |
| ABCCApp.DDDD              | ['DDDD']                                                                                         |
| ABCCApp.BNB               | []                                                                                               |
| ABCCApp.swapV3Router      | []                                                                                               |
| ABCCApp.ddddBNBPool       | []                                                                                               |
| ABCCApp.bnbUSDTPool       | []                                                                                               |
| ABCCApp.vaultAddr         | []                                                                                               |
| ABCCApp.partUSDT          | []                                                                                               |
| ABCCApp.claimFee          | []                                                                                               |
| ABCCApp.isEnable          | []                                                                                               |
| ABCCApp.DAY               | []                                                                                               |
| ABCCApp.Q96               | []                                                                                               |
| ABCCApp.fixedDay          | []                                                                                               |
| ABCCApp.REFERER_RATES     | []                                                                                               |
| ABCCApp.users             | ['users']                                                                                        |
| ABCCApp.dailyPrices       | []                                                                                               |
| ABCCApp.userDirects       | []                                                                                               |
| ABCCApp.userIncomeRecords | []                                                                                               |
| ABCCApp.isOperators       | []                                                                                               |
| ABCCApp.globalData        | []                                                                                               |
+---------------------------+--------------------------------------------------------------------------------------------------+
Function setPartUSDT(uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | ['target']   |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setOperator(address,bool)
+---------------------------+-------------------------+
| Variable                  | Dependencies            |
+---------------------------+-------------------------+
| target                    | []                      |
| flag                      | []                      |
| ABCCApp.USDT              | []                      |
| ABCCApp.DDDD              | []                      |
| ABCCApp.BNB               | []                      |
| ABCCApp.swapV3Router      | []                      |
| ABCCApp.ddddBNBPool       | []                      |
| ABCCApp.bnbUSDTPool       | []                      |
| ABCCApp.vaultAddr         | []                      |
| ABCCApp.partUSDT          | []                      |
| ABCCApp.claimFee          | []                      |
| ABCCApp.isEnable          | []                      |
| ABCCApp.DAY               | []                      |
| ABCCApp.Q96               | []                      |
| ABCCApp.fixedDay          | []                      |
| ABCCApp.REFERER_RATES     | []                      |
| ABCCApp.users             | []                      |
| ABCCApp.dailyPrices       | []                      |
| ABCCApp.userDirects       | []                      |
| ABCCApp.userIncomeRecords | []                      |
| ABCCApp.isOperators       | ['flag', 'isOperators'] |
| ABCCApp.globalData        | []                      |
+---------------------------+-------------------------+
Function setVaultAddr(address)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | ['target']   |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setEnable(bool)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| flag                      | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | ['flag']     |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function getCanClaimUSDT(address)
+---------------------------+---------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                      |
+---------------------------+---------------------------------------------------------------------------------------------------+
| target                    | ['msg.sender', 'target']                                                                          |
| totalUSDT                 | ['DAY', 'block.timestamp', 'diffDay', 'diffSecond', 'dynamicUSDT', 'staticUSDT', 'user', 'users'] |
| staticUSDT                | ['DAY', 'block.timestamp', 'diffDay', 'diffSecond', 'staticUSDT', 'user', 'users']                |
| dynamicUSDT               | ['user', 'users']                                                                                 |
| user                      | ['user', 'users']                                                                                 |
| diffSecond                | ['block.timestamp', 'user', 'users']                                                              |
| diffDay                   | ['DAY', 'block.timestamp', 'diffSecond', 'user', 'users']                                         |
| ABCCApp.USDT              | []                                                                                                |
| ABCCApp.DDDD              | []                                                                                                |
| ABCCApp.BNB               | []                                                                                                |
| ABCCApp.swapV3Router      | []                                                                                                |
| ABCCApp.ddddBNBPool       | []                                                                                                |
| ABCCApp.bnbUSDTPool       | []                                                                                                |
| ABCCApp.vaultAddr         | []                                                                                                |
| ABCCApp.partUSDT          | []                                                                                                |
| ABCCApp.claimFee          | []                                                                                                |
| ABCCApp.isEnable          | []                                                                                                |
| ABCCApp.DAY               | ['DAY']                                                                                           |
| ABCCApp.Q96               | []                                                                                                |
| ABCCApp.fixedDay          | []                                                                                                |
| ABCCApp.REFERER_RATES     | []                                                                                                |
| ABCCApp.users             | ['users']                                                                                         |
| ABCCApp.dailyPrices       | []                                                                                                |
| ABCCApp.userDirects       | []                                                                                                |
| ABCCApp.userIncomeRecords | []                                                                                                |
| ABCCApp.isOperators       | []                                                                                                |
| ABCCApp.globalData        | []                                                                                                |
+---------------------------+---------------------------------------------------------------------------------------------------+
Function deposit(uint256,address)
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                                                          |
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| number                    | []                                                                                                                                                    |
| referer                   | ['referer', 'this']                                                                                                                                   |
| user                      | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'number', 'params', 'partUSDT', 'payUSDT', 'referer', 'swapV3Router', 'this', 'user']          |
| totalUSDT                 | ['TUPLE_1', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                 |
| payUSDT                   | ['number', 'partUSDT']                                                                                                                                |
| params                    | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'number', 'partUSDT', 'payUSDT', 'this']                                                                   |
| fullDDDD                  | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'number', 'params', 'partUSDT', 'payUSDT', 'swapV3Router', 'this']                                         |
| ABCCApp.USDT              | ['USDT']                                                                                                                                              |
| ABCCApp.DDDD              | ['DDDD']                                                                                                                                              |
| ABCCApp.BNB               | ['BNB']                                                                                                                                               |
| ABCCApp.swapV3Router      | ['swapV3Router']                                                                                                                                      |
| ABCCApp.ddddBNBPool       | []                                                                                                                                                    |
| ABCCApp.bnbUSDTPool       | []                                                                                                                                                    |
| ABCCApp.vaultAddr         | []                                                                                                                                                    |
| ABCCApp.partUSDT          | ['partUSDT']                                                                                                                                          |
| ABCCApp.claimFee          | []                                                                                                                                                    |
| ABCCApp.isEnable          | ['isEnable']                                                                                                                                          |
| ABCCApp.DAY               | []                                                                                                                                                    |
| ABCCApp.Q96               | []                                                                                                                                                    |
| ABCCApp.fixedDay          | []                                                                                                                                                    |
| ABCCApp.REFERER_RATES     | []                                                                                                                                                    |
| ABCCApp.users             | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'number', 'params', 'partUSDT', 'payUSDT', 'referer', 'swapV3Router', 'this', 'user', 'users'] |
| ABCCApp.dailyPrices       | []                                                                                                                                                    |
| ABCCApp.userDirects       | ['userDirects']                                                                                                                                       |
| ABCCApp.userIncomeRecords | []                                                                                                                                                    |
| ABCCApp.isOperators       | []                                                                                                                                                    |
| ABCCApp.globalData        | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'globalData', 'number', 'params', 'partUSDT', 'payUSDT', 'swapV3Router', 'this']               |
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
Function claimDDDD()
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                                                           |
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| user                      | ['TUPLE_2', 'block.timestamp', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'user', 'valueInUSDT']          |
| totalUSDT                 | ['TUPLE_2', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                  |
| staticUSDT                | ['TUPLE_2', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                  |
| ddddPrice                 | ['valueInUSDT']                                                                                                                                        |
| ddddAmount                | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                                     |
| fee                       | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                                            |
| ABCCApp.USDT              | []                                                                                                                                                     |
| ABCCApp.DDDD              | ['DDDD']                                                                                                                                               |
| ABCCApp.BNB               | []                                                                                                                                                     |
| ABCCApp.swapV3Router      | []                                                                                                                                                     |
| ABCCApp.ddddBNBPool       | []                                                                                                                                                     |
| ABCCApp.bnbUSDTPool       | []                                                                                                                                                     |
| ABCCApp.vaultAddr         | ['vaultAddr']                                                                                                                                          |
| ABCCApp.partUSDT          | []                                                                                                                                                     |
| ABCCApp.claimFee          | ['claimFee']                                                                                                                                           |
| ABCCApp.isEnable          | []                                                                                                                                                     |
| ABCCApp.DAY               | []                                                                                                                                                     |
| ABCCApp.Q96               | []                                                                                                                                                     |
| ABCCApp.fixedDay          | []                                                                                                                                                     |
| ABCCApp.REFERER_RATES     | []                                                                                                                                                     |
| ABCCApp.users             | ['TUPLE_2', 'block.timestamp', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'user', 'users', 'valueInUSDT'] |
| ABCCApp.dailyPrices       | []                                                                                                                                                     |
| ABCCApp.userDirects       | []                                                                                                                                                     |
| ABCCApp.userIncomeRecords | []                                                                                                                                                     |
| ABCCApp.isOperators       | []                                                                                                                                                     |
| ABCCApp.globalData        | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'globalData', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                       |
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
Function processReferers(address,address,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                             |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| sender                    | ['msg.sender']                                                                                           |
| current                   | ['current', 'user']                                                                                      |
| amountUSDT                | ['staticUSDT']                                                                                           |
| keepUSDT                  | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'keepUSDT', 'staticUSDT', 'user']               |
| depth                     | ['depth']                                                                                                |
| user                      | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| incomeUSDT                | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| canUSDT                   | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| ABCCApp.USDT              | []                                                                                                       |
| ABCCApp.DDDD              | []                                                                                                       |
| ABCCApp.BNB               | []                                                                                                       |
| ABCCApp.swapV3Router      | []                                                                                                       |
| ABCCApp.ddddBNBPool       | []                                                                                                       |
| ABCCApp.bnbUSDTPool       | []                                                                                                       |
| ABCCApp.vaultAddr         | []                                                                                                       |
| ABCCApp.partUSDT          | []                                                                                                       |
| ABCCApp.claimFee          | []                                                                                                       |
| ABCCApp.isEnable          | []                                                                                                       |
| ABCCApp.DAY               | []                                                                                                       |
| ABCCApp.Q96               | []                                                                                                       |
| ABCCApp.fixedDay          | []                                                                                                       |
| ABCCApp.REFERER_RATES     | ['REFERER_RATES']                                                                                        |
| ABCCApp.users             | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user', 'users']                  |
| ABCCApp.dailyPrices       | []                                                                                                       |
| ABCCApp.userDirects       | []                                                                                                       |
| ABCCApp.userIncomeRecords | ['userIncomeRecords']                                                                                    |
| ABCCApp.isOperators       | []                                                                                                       |
| ABCCApp.globalData        | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'globalData', 'incomeUSDT', 'keepUSDT', 'staticUSDT', 'user'] |
+---------------------------+----------------------------------------------------------------------------------------------------------+
Function getUserDirects(address,uint256,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                   |
+---------------------------+----------------------------------------------------------------------------------------------------------------+
| _user                     | []                                                                                                             |
| page                      | []                                                                                                             |
| pageSize                  | []                                                                                                             |
|                           | []                                                                                                             |
| referrals                 | ['referrals', 'userDirects']                                                                                   |
| len                       | ['referrals', 'userDirects']                                                                                   |
| start                     | ['len', 'page', 'pageSize', 'referrals', 'start', 'userDirects']                                               |
| end                       | ['end', 'len', 'page', 'pageSize', 'referrals', 'userDirects']                                                 |
| resultLen                 | ['end', 'len', 'page', 'pageSize', 'referrals', 'start', 'userDirects']                                        |
| result                    | ['end', 'len', 'page', 'pageSize', 'ref', 'referrals', 'result', 'resultLen', 'start', 'userDirects', 'users'] |
| i                         | ['i']                                                                                                          |
| ref                       | ['ref', 'referrals', 'userDirects']                                                                            |
| ABCCApp.USDT              | []                                                                                                             |
| ABCCApp.DDDD              | []                                                                                                             |
| ABCCApp.BNB               | []                                                                                                             |
| ABCCApp.swapV3Router      | []                                                                                                             |
| ABCCApp.ddddBNBPool       | []                                                                                                             |
| ABCCApp.bnbUSDTPool       | []                                                                                                             |
| ABCCApp.vaultAddr         | []                                                                                                             |
| ABCCApp.partUSDT          | []                                                                                                             |
| ABCCApp.claimFee          | []                                                                                                             |
| ABCCApp.isEnable          | []                                                                                                             |
| ABCCApp.DAY               | []                                                                                                             |
| ABCCApp.Q96               | []                                                                                                             |
| ABCCApp.fixedDay          | []                                                                                                             |
| ABCCApp.REFERER_RATES     | []                                                                                                             |
| ABCCApp.users             | ['users']                                                                                                      |
| ABCCApp.dailyPrices       | []                                                                                                             |
| ABCCApp.userDirects       | ['userDirects']                                                                                                |
| ABCCApp.userIncomeRecords | []                                                                                                             |
| ABCCApp.isOperators       | []                                                                                                             |
| ABCCApp.globalData        | []                                                                                                             |
+---------------------------+----------------------------------------------------------------------------------------------------------------+
Function getIncomeRecords(address,uint256,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                       |
+---------------------------+----------------------------------------------------------------------------------------------------+
| user                      | []                                                                                                 |
| page                      | []                                                                                                 |
| pageSize                  | []                                                                                                 |
|                           | []                                                                                                 |
| records                   | ['records', 'userIncomeRecords']                                                                   |
| len                       | ['records', 'userIncomeRecords']                                                                   |
| start                     | ['len', 'page', 'pageSize', 'records', 'start', 'userIncomeRecords']                               |
| end                       | ['end', 'len', 'page', 'pageSize', 'records', 'userIncomeRecords']                                 |
| resultLen                 | ['end', 'len', 'page', 'pageSize', 'records', 'start', 'userIncomeRecords']                        |
| result                    | ['end', 'len', 'page', 'pageSize', 'records', 'result', 'resultLen', 'start', 'userIncomeRecords'] |
| i                         | ['i']                                                                                              |
| ABCCApp.USDT              | []                                                                                                 |
| ABCCApp.DDDD              | []                                                                                                 |
| ABCCApp.BNB               | []                                                                                                 |
| ABCCApp.swapV3Router      | []                                                                                                 |
| ABCCApp.ddddBNBPool       | []                                                                                                 |
| ABCCApp.bnbUSDTPool       | []                                                                                                 |
| ABCCApp.vaultAddr         | []                                                                                                 |
| ABCCApp.partUSDT          | []                                                                                                 |
| ABCCApp.claimFee          | []                                                                                                 |
| ABCCApp.isEnable          | []                                                                                                 |
| ABCCApp.DAY               | []                                                                                                 |
| ABCCApp.Q96               | []                                                                                                 |
| ABCCApp.fixedDay          | []                                                                                                 |
| ABCCApp.REFERER_RATES     | []                                                                                                 |
| ABCCApp.users             | []                                                                                                 |
| ABCCApp.dailyPrices       | []                                                                                                 |
| ABCCApp.userDirects       | []                                                                                                 |
| ABCCApp.userIncomeRecords | ['userIncomeRecords']                                                                              |
| ABCCApp.isOperators       | []                                                                                                 |
| ABCCApp.globalData        | []                                                                                                 |
+---------------------------+----------------------------------------------------------------------------------------------------+
Function setSettlePrice(uint256,uint256)
+---------------------------+-----------------------------------------+
| Variable                  | Dependencies                            |
+---------------------------+-----------------------------------------+
| price                     | ['price', 'valueInUSDT']                |
| targetTime                | ['block.timestamp', 'targetTime']       |
| ABCCApp.USDT              | []                                      |
| ABCCApp.DDDD              | []                                      |
| ABCCApp.BNB               | []                                      |
| ABCCApp.swapV3Router      | []                                      |
| ABCCApp.ddddBNBPool       | []                                      |
| ABCCApp.bnbUSDTPool       | []                                      |
| ABCCApp.vaultAddr         | []                                      |
| ABCCApp.partUSDT          | []                                      |
| ABCCApp.claimFee          | []                                      |
| ABCCApp.isEnable          | []                                      |
| ABCCApp.DAY               | ['DAY']                                 |
| ABCCApp.Q96               | []                                      |
| ABCCApp.fixedDay          | []                                      |
| ABCCApp.REFERER_RATES     | []                                      |
| ABCCApp.users             | []                                      |
| ABCCApp.dailyPrices       | ['dailyPrices', 'price', 'valueInUSDT'] |
| ABCCApp.userDirects       | []                                      |
| ABCCApp.userIncomeRecords | []                                      |
| ABCCApp.isOperators       | []                                      |
| ABCCApp.globalData        | []                                      |
+---------------------------+-----------------------------------------+
Function setLevelRate(uint256,uint256)
+---------------------------+----------------------------+
| Variable                  | Dependencies               |
+---------------------------+----------------------------+
| index                     | []                         |
| value                     | []                         |
| ABCCApp.USDT              | []                         |
| ABCCApp.DDDD              | []                         |
| ABCCApp.BNB               | []                         |
| ABCCApp.swapV3Router      | []                         |
| ABCCApp.ddddBNBPool       | []                         |
| ABCCApp.bnbUSDTPool       | []                         |
| ABCCApp.vaultAddr         | []                         |
| ABCCApp.partUSDT          | []                         |
| ABCCApp.claimFee          | []                         |
| ABCCApp.isEnable          | []                         |
| ABCCApp.DAY               | []                         |
| ABCCApp.Q96               | []                         |
| ABCCApp.fixedDay          | []                         |
| ABCCApp.REFERER_RATES     | ['REFERER_RATES', 'value'] |
| ABCCApp.users             | []                         |
| ABCCApp.dailyPrices       | []                         |
| ABCCApp.userDirects       | []                         |
| ABCCApp.userIncomeRecords | []                         |
| ABCCApp.isOperators       | []                         |
| ABCCApp.globalData        | []                         |
+---------------------------+----------------------------+
Function setClaimFee(uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | ['target']   |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setUserRemainingUSDT(address,uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| value                     | []           |
| old                       | ['users']    |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | ['users']    |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function getFixedDay()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
|                           | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | ['DAY']      |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | ['fixedDay'] |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function addFixedDay(uint256)
+---------------------------+------------------------+
| Variable                  | Dependencies           |
+---------------------------+------------------------+
| target                    | []                     |
| ABCCApp.USDT              | []                     |
| ABCCApp.DDDD              | []                     |
| ABCCApp.BNB               | []                     |
| ABCCApp.swapV3Router      | []                     |
| ABCCApp.ddddBNBPool       | []                     |
| ABCCApp.bnbUSDTPool       | []                     |
| ABCCApp.vaultAddr         | []                     |
| ABCCApp.partUSDT          | []                     |
| ABCCApp.claimFee          | []                     |
| ABCCApp.isEnable          | []                     |
| ABCCApp.DAY               | []                     |
| ABCCApp.Q96               | []                     |
| ABCCApp.fixedDay          | ['fixedDay', 'target'] |
| ABCCApp.REFERER_RATES     | []                     |
| ABCCApp.users             | []                     |
| ABCCApp.dailyPrices       | []                     |
| ABCCApp.userDirects       | []                     |
| ABCCApp.userIncomeRecords | []                     |
| ABCCApp.isOperators       | []                     |
| ABCCApp.globalData        | []                     |
+---------------------------+------------------------+
Function getDDDDValueInUSDT(uint256)
+---------------------------+----------------------------------------------------------+
| Variable                  | Dependencies                                             |
+---------------------------+----------------------------------------------------------+
| amount                    | []                                                       |
|                           | []                                                       |
| tokenPriceInBNB           | ['price']                                                |
| bnbPriceInUSDT            | ['price']                                                |
| valueInUSDT               | ['amount', 'bnbPriceInUSDT', 'price', 'tokenPriceInBNB'] |
| ABCCApp.USDT              | []                                                       |
| ABCCApp.DDDD              | []                                                       |
| ABCCApp.BNB               | []                                                       |
| ABCCApp.swapV3Router      | []                                                       |
| ABCCApp.ddddBNBPool       | []                                                       |
| ABCCApp.bnbUSDTPool       | []                                                       |
| ABCCApp.vaultAddr         | []                                                       |
| ABCCApp.partUSDT          | []                                                       |
| ABCCApp.claimFee          | []                                                       |
| ABCCApp.isEnable          | []                                                       |
| ABCCApp.DAY               | []                                                       |
| ABCCApp.Q96               | []                                                       |
| ABCCApp.fixedDay          | []                                                       |
| ABCCApp.REFERER_RATES     | []                                                       |
| ABCCApp.users             | []                                                       |
| ABCCApp.dailyPrices       | []                                                       |
| ABCCApp.userDirects       | []                                                       |
| ABCCApp.userIncomeRecords | []                                                       |
| ABCCApp.isOperators       | []                                                       |
| ABCCApp.globalData        | []                                                       |
+---------------------------+----------------------------------------------------------+
Function getTokenPriceInBNB()
+---------------------------+----------------------------------------------------------------------------+
| Variable                  | Dependencies                                                               |
+---------------------------+----------------------------------------------------------------------------+
|                           | []                                                                         |
| tokenBnbPool              | ['ddddBNBPool']                                                            |
| sqrtPriceX96              | ['TUPLE_3', 'ddddBNBPool', 'tokenBnbPool']                                 |
| isToken0                  | ['DDDD', 'ddddBNBPool', 'tokenBnbPool']                                    |
| price                     | ['Q96', 'TUPLE_3', 'ddddBNBPool', 'price', 'sqrtPriceX96', 'tokenBnbPool'] |
| ABCCApp.USDT              | []                                                                         |
| ABCCApp.DDDD              | ['DDDD']                                                                   |
| ABCCApp.BNB               | []                                                                         |
| ABCCApp.swapV3Router      | []                                                                         |
| ABCCApp.ddddBNBPool       | ['ddddBNBPool']                                                            |
| ABCCApp.bnbUSDTPool       | []                                                                         |
| ABCCApp.vaultAddr         | []                                                                         |
| ABCCApp.partUSDT          | []                                                                         |
| ABCCApp.claimFee          | []                                                                         |
| ABCCApp.isEnable          | []                                                                         |
| ABCCApp.DAY               | []                                                                         |
| ABCCApp.Q96               | ['Q96']                                                                    |
| ABCCApp.fixedDay          | []                                                                         |
| ABCCApp.REFERER_RATES     | []                                                                         |
| ABCCApp.users             | []                                                                         |
| ABCCApp.dailyPrices       | []                                                                         |
| ABCCApp.userDirects       | []                                                                         |
| ABCCApp.userIncomeRecords | []                                                                         |
| ABCCApp.isOperators       | []                                                                         |
| ABCCApp.globalData        | []                                                                         |
+---------------------------+----------------------------------------------------------------------------+
Function getBNBPriceInUSDT()
+---------------------------+---------------------------------------------------------------------------+
| Variable                  | Dependencies                                                              |
+---------------------------+---------------------------------------------------------------------------+
|                           | []                                                                        |
| bnbUsdtPool               | ['bnbUSDTPool']                                                           |
| sqrtPriceX96              | ['TUPLE_4', 'bnbUSDTPool', 'bnbUsdtPool']                                 |
| isBNBToken0               | ['BNB', 'bnbUSDTPool', 'bnbUsdtPool']                                     |
| price                     | ['Q96', 'TUPLE_4', 'bnbUSDTPool', 'bnbUsdtPool', 'price', 'sqrtPriceX96'] |
| ABCCApp.USDT              | []                                                                        |
| ABCCApp.DDDD              | []                                                                        |
| ABCCApp.BNB               | ['BNB']                                                                   |
| ABCCApp.swapV3Router      | []                                                                        |
| ABCCApp.ddddBNBPool       | []                                                                        |
| ABCCApp.bnbUSDTPool       | ['bnbUSDTPool']                                                           |
| ABCCApp.vaultAddr         | []                                                                        |
| ABCCApp.partUSDT          | []                                                                        |
| ABCCApp.claimFee          | []                                                                        |
| ABCCApp.isEnable          | []                                                                        |
| ABCCApp.DAY               | []                                                                        |
| ABCCApp.Q96               | ['Q96']                                                                   |
| ABCCApp.fixedDay          | []                                                                        |
| ABCCApp.REFERER_RATES     | []                                                                        |
| ABCCApp.users             | []                                                                        |
| ABCCApp.dailyPrices       | []                                                                        |
| ABCCApp.userDirects       | []                                                                        |
| ABCCApp.userIncomeRecords | []                                                                        |
| ABCCApp.isOperators       | []                                                                        |
| ABCCApp.globalData        | []                                                                        |
+---------------------------+---------------------------------------------------------------------------+
Function emergencyFixed(address,address)
+---------------------------+----------------------------+
| Variable                  | Dependencies               |
+---------------------------+----------------------------+
| targetContract            | []                         |
| recipient                 | []                         |
| balance                   | ['targetContract', 'this'] |
| ABCCApp.USDT              | []                         |
| ABCCApp.DDDD              | []                         |
| ABCCApp.BNB               | []                         |
| ABCCApp.swapV3Router      | []                         |
| ABCCApp.ddddBNBPool       | []                         |
| ABCCApp.bnbUSDTPool       | []                         |
| ABCCApp.vaultAddr         | []                         |
| ABCCApp.partUSDT          | []                         |
| ABCCApp.claimFee          | []                         |
| ABCCApp.isEnable          | []                         |
| ABCCApp.DAY               | []                         |
| ABCCApp.Q96               | []                         |
| ABCCApp.fixedDay          | []                         |
| ABCCApp.REFERER_RATES     | []                         |
| ABCCApp.users             | []                         |
| ABCCApp.dailyPrices       | []                         |
| ABCCApp.userDirects       | []                         |
| ABCCApp.userIncomeRecords | []                         |
| ABCCApp.isOperators       | []                         |
| ABCCApp.globalData        | []                         |
+---------------------------+----------------------------+
Function slitherConstructorVariables()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function slitherConstructorConstantVariables()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function isOperator()
+---------------------------+-----------------+
| Variable                  | Dependencies    |
+---------------------------+-----------------+
| ABCCApp.USDT              | []              |
| ABCCApp.DDDD              | []              |
| ABCCApp.BNB               | []              |
| ABCCApp.swapV3Router      | []              |
| ABCCApp.ddddBNBPool       | []              |
| ABCCApp.bnbUSDTPool       | []              |
| ABCCApp.vaultAddr         | []              |
| ABCCApp.partUSDT          | []              |
| ABCCApp.claimFee          | []              |
| ABCCApp.isEnable          | []              |
| ABCCApp.DAY               | []              |
| ABCCApp.Q96               | []              |
| ABCCApp.fixedDay          | []              |
| ABCCApp.REFERER_RATES     | []              |
| ABCCApp.users             | []              |
| ABCCApp.dailyPrices       | []              |
| ABCCApp.userDirects       | []              |
| ABCCApp.userIncomeRecords | []              |
| ABCCApp.isOperators       | ['isOperators'] |
| ABCCApp.globalData        | []              |
+---------------------------+-----------------+
INFO:Printers:
Contract IUniswapV3
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
+----------+--------------+

Function exactInputSingle(IUniswapV3.ExactInputSingleParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function exactInput(IUniswapV3.ExactInputParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function slot0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token1()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Contract ABCCApp
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable          | Dependencies                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| USDT              | ['USDT']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| DDDD              | ['DDDD']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| BNB               | ['BNB']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| swapV3Router      | ['swapV3Router']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ddddBNBPool       | ['ddddBNBPool']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bnbUSDTPool       | ['bnbUSDTPool']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| vaultAddr         | ['target', 'vaultAddr']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| partUSDT          | ['partUSDT', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| claimFee          | ['claimFee', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| isEnable          | ['flag', 'isEnable']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| DAY               | ['DAY']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Q96               | ['Q96']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| fixedDay          | ['fixedDay', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| REFERER_RATES     | ['REFERER_RATES', 'value']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| users             | ['BNB', 'DAY', 'DDDD', 'Q96', 'REFERER_RATES', 'TUPLE_2', 'TUPLE_3', 'TUPLE_4', 'USDT', 'amount', 'amountUSDT', 'block.timestamp', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'canUSDT', 'claimFee', 'ddddAmount', 'ddddBNBPool', 'ddddPrice', 'diffDay', 'diffSecond', 'dynamicUSDT', 'fee', 'fixedDay', 'fullDDDD', 'incomeUSDT', 'number', 'params', 'partUSDT', 'payUSDT', 'price', 'referer', 'sqrtPriceX96', 'staticUSDT', 'swapV3Router', 'target', 'this', 'tokenBnbPool', 'tokenPriceInBNB', 'totalUSDT', 'user', 'users', 'value', 'valueInUSDT']                |
| dailyPrices       | ['Q96', 'TUPLE_3', 'TUPLE_4', 'amount', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'dailyPrices', 'ddddBNBPool', 'price', 'sqrtPriceX96', 'tokenBnbPool', 'tokenPriceInBNB', 'valueInUSDT']                                                                                                                                                                                                                                                                                                                                                                                |
| userDirects       | ['userDirects']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| userIncomeRecords | ['userIncomeRecords']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| isOperators       | ['flag', 'isOperators']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| globalData        | ['BNB', 'DAY', 'DDDD', 'Q96', 'REFERER_RATES', 'TUPLE_2', 'TUPLE_3', 'TUPLE_4', 'USDT', 'amount', 'amountUSDT', 'block.timestamp', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'canUSDT', 'claimFee', 'ddddAmount', 'ddddBNBPool', 'ddddPrice', 'diffDay', 'diffSecond', 'dynamicUSDT', 'fee', 'fixedDay', 'fullDDDD', 'globalData', 'incomeUSDT', 'keepUSDT', 'number', 'params', 'partUSDT', 'payUSDT', 'price', 'sqrtPriceX96', 'staticUSDT', 'swapV3Router', 'target', 'this', 'tokenBnbPool', 'tokenPriceInBNB', 'totalUSDT', 'user', 'users', 'value', 'valueInUSDT'] |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Function constructor()
+---------------------------+-----------------+
| Variable                  | Dependencies    |
+---------------------------+-----------------+
| ABCCApp.USDT              | []              |
| ABCCApp.DDDD              | []              |
| ABCCApp.BNB               | []              |
| ABCCApp.swapV3Router      | []              |
| ABCCApp.ddddBNBPool       | []              |
| ABCCApp.bnbUSDTPool       | []              |
| ABCCApp.vaultAddr         | []              |
| ABCCApp.partUSDT          | []              |
| ABCCApp.claimFee          | []              |
| ABCCApp.isEnable          | []              |
| ABCCApp.DAY               | []              |
| ABCCApp.Q96               | []              |
| ABCCApp.fixedDay          | []              |
| ABCCApp.REFERER_RATES     | []              |
| ABCCApp.users             | []              |
| ABCCApp.dailyPrices       | []              |
| ABCCApp.userDirects       | []              |
| ABCCApp.userIncomeRecords | []              |
| ABCCApp.isOperators       | ['isOperators'] |
| ABCCApp.globalData        | []              |
+---------------------------+-----------------+
Function dashboard(address)
+---------------------------+--------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                     |
+---------------------------+--------------------------------------------------------------------------------------------------+
| target                    | []                                                                                               |
| data                      | ['DDDD', 'TUPLE_0', 'USDT', 'data', 'dynamicUSDT', 'staticUSDT', 'target', 'totalUSDT', 'users'] |
| staticUSDT                | ['TUPLE_0', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                            |
| ABCCApp.USDT              | ['USDT']                                                                                         |
| ABCCApp.DDDD              | ['DDDD']                                                                                         |
| ABCCApp.BNB               | []                                                                                               |
| ABCCApp.swapV3Router      | []                                                                                               |
| ABCCApp.ddddBNBPool       | []                                                                                               |
| ABCCApp.bnbUSDTPool       | []                                                                                               |
| ABCCApp.vaultAddr         | []                                                                                               |
| ABCCApp.partUSDT          | []                                                                                               |
| ABCCApp.claimFee          | []                                                                                               |
| ABCCApp.isEnable          | []                                                                                               |
| ABCCApp.DAY               | []                                                                                               |
| ABCCApp.Q96               | []                                                                                               |
| ABCCApp.fixedDay          | []                                                                                               |
| ABCCApp.REFERER_RATES     | []                                                                                               |
| ABCCApp.users             | ['users']                                                                                        |
| ABCCApp.dailyPrices       | []                                                                                               |
| ABCCApp.userDirects       | []                                                                                               |
| ABCCApp.userIncomeRecords | []                                                                                               |
| ABCCApp.isOperators       | []                                                                                               |
| ABCCApp.globalData        | []                                                                                               |
+---------------------------+--------------------------------------------------------------------------------------------------+
Function setPartUSDT(uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | ['target']   |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setOperator(address,bool)
+---------------------------+-------------------------+
| Variable                  | Dependencies            |
+---------------------------+-------------------------+
| target                    | []                      |
| flag                      | []                      |
| ABCCApp.USDT              | []                      |
| ABCCApp.DDDD              | []                      |
| ABCCApp.BNB               | []                      |
| ABCCApp.swapV3Router      | []                      |
| ABCCApp.ddddBNBPool       | []                      |
| ABCCApp.bnbUSDTPool       | []                      |
| ABCCApp.vaultAddr         | []                      |
| ABCCApp.partUSDT          | []                      |
| ABCCApp.claimFee          | []                      |
| ABCCApp.isEnable          | []                      |
| ABCCApp.DAY               | []                      |
| ABCCApp.Q96               | []                      |
| ABCCApp.fixedDay          | []                      |
| ABCCApp.REFERER_RATES     | []                      |
| ABCCApp.users             | []                      |
| ABCCApp.dailyPrices       | []                      |
| ABCCApp.userDirects       | []                      |
| ABCCApp.userIncomeRecords | []                      |
| ABCCApp.isOperators       | ['flag', 'isOperators'] |
| ABCCApp.globalData        | []                      |
+---------------------------+-------------------------+
Function setVaultAddr(address)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | ['target']   |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setEnable(bool)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| flag                      | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | ['flag']     |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function getCanClaimUSDT(address)
+---------------------------+---------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                      |
+---------------------------+---------------------------------------------------------------------------------------------------+
| target                    | ['msg.sender', 'target']                                                                          |
| totalUSDT                 | ['DAY', 'block.timestamp', 'diffDay', 'diffSecond', 'dynamicUSDT', 'staticUSDT', 'user', 'users'] |
| staticUSDT                | ['DAY', 'block.timestamp', 'diffDay', 'diffSecond', 'staticUSDT', 'user', 'users']                |
| dynamicUSDT               | ['user', 'users']                                                                                 |
| user                      | ['user', 'users']                                                                                 |
| diffSecond                | ['block.timestamp', 'user', 'users']                                                              |
| diffDay                   | ['DAY', 'block.timestamp', 'diffSecond', 'user', 'users']                                         |
| ABCCApp.USDT              | []                                                                                                |
| ABCCApp.DDDD              | []                                                                                                |
| ABCCApp.BNB               | []                                                                                                |
| ABCCApp.swapV3Router      | []                                                                                                |
| ABCCApp.ddddBNBPool       | []                                                                                                |
| ABCCApp.bnbUSDTPool       | []                                                                                                |
| ABCCApp.vaultAddr         | []                                                                                                |
| ABCCApp.partUSDT          | []                                                                                                |
| ABCCApp.claimFee          | []                                                                                                |
| ABCCApp.isEnable          | []                                                                                                |
| ABCCApp.DAY               | ['DAY']                                                                                           |
| ABCCApp.Q96               | []                                                                                                |
| ABCCApp.fixedDay          | []                                                                                                |
| ABCCApp.REFERER_RATES     | []                                                                                                |
| ABCCApp.users             | ['users']                                                                                         |
| ABCCApp.dailyPrices       | []                                                                                                |
| ABCCApp.userDirects       | []                                                                                                |
| ABCCApp.userIncomeRecords | []                                                                                                |
| ABCCApp.isOperators       | []                                                                                                |
| ABCCApp.globalData        | []                                                                                                |
+---------------------------+---------------------------------------------------------------------------------------------------+
Function deposit(uint256,address)
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                                                          |
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| number                    | []                                                                                                                                                    |
| referer                   | ['referer', 'this']                                                                                                                                   |
| user                      | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'number', 'params', 'partUSDT', 'payUSDT', 'referer', 'swapV3Router', 'this', 'user']          |
| totalUSDT                 | ['TUPLE_1', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                 |
| payUSDT                   | ['number', 'partUSDT']                                                                                                                                |
| params                    | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'number', 'partUSDT', 'payUSDT', 'this']                                                                   |
| fullDDDD                  | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'number', 'params', 'partUSDT', 'payUSDT', 'swapV3Router', 'this']                                         |
| ABCCApp.USDT              | ['USDT']                                                                                                                                              |
| ABCCApp.DDDD              | ['DDDD']                                                                                                                                              |
| ABCCApp.BNB               | ['BNB']                                                                                                                                               |
| ABCCApp.swapV3Router      | ['swapV3Router']                                                                                                                                      |
| ABCCApp.ddddBNBPool       | []                                                                                                                                                    |
| ABCCApp.bnbUSDTPool       | []                                                                                                                                                    |
| ABCCApp.vaultAddr         | []                                                                                                                                                    |
| ABCCApp.partUSDT          | ['partUSDT']                                                                                                                                          |
| ABCCApp.claimFee          | []                                                                                                                                                    |
| ABCCApp.isEnable          | ['isEnable']                                                                                                                                          |
| ABCCApp.DAY               | []                                                                                                                                                    |
| ABCCApp.Q96               | []                                                                                                                                                    |
| ABCCApp.fixedDay          | []                                                                                                                                                    |
| ABCCApp.REFERER_RATES     | []                                                                                                                                                    |
| ABCCApp.users             | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'number', 'params', 'partUSDT', 'payUSDT', 'referer', 'swapV3Router', 'this', 'user', 'users'] |
| ABCCApp.dailyPrices       | []                                                                                                                                                    |
| ABCCApp.userDirects       | ['userDirects']                                                                                                                                       |
| ABCCApp.userIncomeRecords | []                                                                                                                                                    |
| ABCCApp.isOperators       | []                                                                                                                                                    |
| ABCCApp.globalData        | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'globalData', 'number', 'params', 'partUSDT', 'payUSDT', 'swapV3Router', 'this']               |
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
Function claimDDDD()
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                                                           |
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| user                      | ['TUPLE_2', 'block.timestamp', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'user', 'valueInUSDT']          |
| totalUSDT                 | ['TUPLE_2', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                  |
| staticUSDT                | ['TUPLE_2', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                  |
| ddddPrice                 | ['valueInUSDT']                                                                                                                                        |
| ddddAmount                | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                                     |
| fee                       | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                                            |
| ABCCApp.USDT              | []                                                                                                                                                     |
| ABCCApp.DDDD              | ['DDDD']                                                                                                                                               |
| ABCCApp.BNB               | []                                                                                                                                                     |
| ABCCApp.swapV3Router      | []                                                                                                                                                     |
| ABCCApp.ddddBNBPool       | []                                                                                                                                                     |
| ABCCApp.bnbUSDTPool       | []                                                                                                                                                     |
| ABCCApp.vaultAddr         | ['vaultAddr']                                                                                                                                          |
| ABCCApp.partUSDT          | []                                                                                                                                                     |
| ABCCApp.claimFee          | ['claimFee']                                                                                                                                           |
| ABCCApp.isEnable          | []                                                                                                                                                     |
| ABCCApp.DAY               | []                                                                                                                                                     |
| ABCCApp.Q96               | []                                                                                                                                                     |
| ABCCApp.fixedDay          | []                                                                                                                                                     |
| ABCCApp.REFERER_RATES     | []                                                                                                                                                     |
| ABCCApp.users             | ['TUPLE_2', 'block.timestamp', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'user', 'users', 'valueInUSDT'] |
| ABCCApp.dailyPrices       | []                                                                                                                                                     |
| ABCCApp.userDirects       | []                                                                                                                                                     |
| ABCCApp.userIncomeRecords | []                                                                                                                                                     |
| ABCCApp.isOperators       | []                                                                                                                                                     |
| ABCCApp.globalData        | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'globalData', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                       |
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
Function processReferers(address,address,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                             |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| sender                    | ['msg.sender']                                                                                           |
| current                   | ['current', 'user']                                                                                      |
| amountUSDT                | ['staticUSDT']                                                                                           |
| keepUSDT                  | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'keepUSDT', 'staticUSDT', 'user']               |
| depth                     | ['depth']                                                                                                |
| user                      | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| incomeUSDT                | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| canUSDT                   | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| ABCCApp.USDT              | []                                                                                                       |
| ABCCApp.DDDD              | []                                                                                                       |
| ABCCApp.BNB               | []                                                                                                       |
| ABCCApp.swapV3Router      | []                                                                                                       |
| ABCCApp.ddddBNBPool       | []                                                                                                       |
| ABCCApp.bnbUSDTPool       | []                                                                                                       |
| ABCCApp.vaultAddr         | []                                                                                                       |
| ABCCApp.partUSDT          | []                                                                                                       |
| ABCCApp.claimFee          | []                                                                                                       |
| ABCCApp.isEnable          | []                                                                                                       |
| ABCCApp.DAY               | []                                                                                                       |
| ABCCApp.Q96               | []                                                                                                       |
| ABCCApp.fixedDay          | []                                                                                                       |
| ABCCApp.REFERER_RATES     | ['REFERER_RATES']                                                                                        |
| ABCCApp.users             | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user', 'users']                  |
| ABCCApp.dailyPrices       | []                                                                                                       |
| ABCCApp.userDirects       | []                                                                                                       |
| ABCCApp.userIncomeRecords | ['userIncomeRecords']                                                                                    |
| ABCCApp.isOperators       | []                                                                                                       |
| ABCCApp.globalData        | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'globalData', 'incomeUSDT', 'keepUSDT', 'staticUSDT', 'user'] |
+---------------------------+----------------------------------------------------------------------------------------------------------+
Function getUserDirects(address,uint256,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                   |
+---------------------------+----------------------------------------------------------------------------------------------------------------+
| _user                     | []                                                                                                             |
| page                      | []                                                                                                             |
| pageSize                  | []                                                                                                             |
|                           | []                                                                                                             |
| referrals                 | ['referrals', 'userDirects']                                                                                   |
| len                       | ['referrals', 'userDirects']                                                                                   |
| start                     | ['len', 'page', 'pageSize', 'referrals', 'start', 'userDirects']                                               |
| end                       | ['end', 'len', 'page', 'pageSize', 'referrals', 'userDirects']                                                 |
| resultLen                 | ['end', 'len', 'page', 'pageSize', 'referrals', 'start', 'userDirects']                                        |
| result                    | ['end', 'len', 'page', 'pageSize', 'ref', 'referrals', 'result', 'resultLen', 'start', 'userDirects', 'users'] |
| i                         | ['i']                                                                                                          |
| ref                       | ['ref', 'referrals', 'userDirects']                                                                            |
| ABCCApp.USDT              | []                                                                                                             |
| ABCCApp.DDDD              | []                                                                                                             |
| ABCCApp.BNB               | []                                                                                                             |
| ABCCApp.swapV3Router      | []                                                                                                             |
| ABCCApp.ddddBNBPool       | []                                                                                                             |
| ABCCApp.bnbUSDTPool       | []                                                                                                             |
| ABCCApp.vaultAddr         | []                                                                                                             |
| ABCCApp.partUSDT          | []                                                                                                             |
| ABCCApp.claimFee          | []                                                                                                             |
| ABCCApp.isEnable          | []                                                                                                             |
| ABCCApp.DAY               | []                                                                                                             |
| ABCCApp.Q96               | []                                                                                                             |
| ABCCApp.fixedDay          | []                                                                                                             |
| ABCCApp.REFERER_RATES     | []                                                                                                             |
| ABCCApp.users             | ['users']                                                                                                      |
| ABCCApp.dailyPrices       | []                                                                                                             |
| ABCCApp.userDirects       | ['userDirects']                                                                                                |
| ABCCApp.userIncomeRecords | []                                                                                                             |
| ABCCApp.isOperators       | []                                                                                                             |
| ABCCApp.globalData        | []                                                                                                             |
+---------------------------+----------------------------------------------------------------------------------------------------------------+
Function getIncomeRecords(address,uint256,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                       |
+---------------------------+----------------------------------------------------------------------------------------------------+
| user                      | []                                                                                                 |
| page                      | []                                                                                                 |
| pageSize                  | []                                                                                                 |
|                           | []                                                                                                 |
| records                   | ['records', 'userIncomeRecords']                                                                   |
| len                       | ['records', 'userIncomeRecords']                                                                   |
| start                     | ['len', 'page', 'pageSize', 'records', 'start', 'userIncomeRecords']                               |
| end                       | ['end', 'len', 'page', 'pageSize', 'records', 'userIncomeRecords']                                 |
| resultLen                 | ['end', 'len', 'page', 'pageSize', 'records', 'start', 'userIncomeRecords']                        |
| result                    | ['end', 'len', 'page', 'pageSize', 'records', 'result', 'resultLen', 'start', 'userIncomeRecords'] |
| i                         | ['i']                                                                                              |
| ABCCApp.USDT              | []                                                                                                 |
| ABCCApp.DDDD              | []                                                                                                 |
| ABCCApp.BNB               | []                                                                                                 |
| ABCCApp.swapV3Router      | []                                                                                                 |
| ABCCApp.ddddBNBPool       | []                                                                                                 |
| ABCCApp.bnbUSDTPool       | []                                                                                                 |
| ABCCApp.vaultAddr         | []                                                                                                 |
| ABCCApp.partUSDT          | []                                                                                                 |
| ABCCApp.claimFee          | []                                                                                                 |
| ABCCApp.isEnable          | []                                                                                                 |
| ABCCApp.DAY               | []                                                                                                 |
| ABCCApp.Q96               | []                                                                                                 |
| ABCCApp.fixedDay          | []                                                                                                 |
| ABCCApp.REFERER_RATES     | []                                                                                                 |
| ABCCApp.users             | []                                                                                                 |
| ABCCApp.dailyPrices       | []                                                                                                 |
| ABCCApp.userDirects       | []                                                                                                 |
| ABCCApp.userIncomeRecords | ['userIncomeRecords']                                                                              |
| ABCCApp.isOperators       | []                                                                                                 |
| ABCCApp.globalData        | []                                                                                                 |
+---------------------------+----------------------------------------------------------------------------------------------------+
Function setSettlePrice(uint256,uint256)
+---------------------------+-----------------------------------------+
| Variable                  | Dependencies                            |
+---------------------------+-----------------------------------------+
| price                     | ['price', 'valueInUSDT']                |
| targetTime                | ['block.timestamp', 'targetTime']       |
| ABCCApp.USDT              | []                                      |
| ABCCApp.DDDD              | []                                      |
| ABCCApp.BNB               | []                                      |
| ABCCApp.swapV3Router      | []                                      |
| ABCCApp.ddddBNBPool       | []                                      |
| ABCCApp.bnbUSDTPool       | []                                      |
| ABCCApp.vaultAddr         | []                                      |
| ABCCApp.partUSDT          | []                                      |
| ABCCApp.claimFee          | []                                      |
| ABCCApp.isEnable          | []                                      |
| ABCCApp.DAY               | ['DAY']                                 |
| ABCCApp.Q96               | []                                      |
| ABCCApp.fixedDay          | []                                      |
| ABCCApp.REFERER_RATES     | []                                      |
| ABCCApp.users             | []                                      |
| ABCCApp.dailyPrices       | ['dailyPrices', 'price', 'valueInUSDT'] |
| ABCCApp.userDirects       | []                                      |
| ABCCApp.userIncomeRecords | []                                      |
| ABCCApp.isOperators       | []                                      |
| ABCCApp.globalData        | []                                      |
+---------------------------+-----------------------------------------+
Function setLevelRate(uint256,uint256)
+---------------------------+----------------------------+
| Variable                  | Dependencies               |
+---------------------------+----------------------------+
| index                     | []                         |
| value                     | []                         |
| ABCCApp.USDT              | []                         |
| ABCCApp.DDDD              | []                         |
| ABCCApp.BNB               | []                         |
| ABCCApp.swapV3Router      | []                         |
| ABCCApp.ddddBNBPool       | []                         |
| ABCCApp.bnbUSDTPool       | []                         |
| ABCCApp.vaultAddr         | []                         |
| ABCCApp.partUSDT          | []                         |
| ABCCApp.claimFee          | []                         |
| ABCCApp.isEnable          | []                         |
| ABCCApp.DAY               | []                         |
| ABCCApp.Q96               | []                         |
| ABCCApp.fixedDay          | []                         |
| ABCCApp.REFERER_RATES     | ['REFERER_RATES', 'value'] |
| ABCCApp.users             | []                         |
| ABCCApp.dailyPrices       | []                         |
| ABCCApp.userDirects       | []                         |
| ABCCApp.userIncomeRecords | []                         |
| ABCCApp.isOperators       | []                         |
| ABCCApp.globalData        | []                         |
+---------------------------+----------------------------+
Function setClaimFee(uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | ['target']   |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setUserRemainingUSDT(address,uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| value                     | []           |
| old                       | ['users']    |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | ['users']    |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function getFixedDay()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
|                           | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | ['DAY']      |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | ['fixedDay'] |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function addFixedDay(uint256)
+---------------------------+------------------------+
| Variable                  | Dependencies           |
+---------------------------+------------------------+
| target                    | []                     |
| ABCCApp.USDT              | []                     |
| ABCCApp.DDDD              | []                     |
| ABCCApp.BNB               | []                     |
| ABCCApp.swapV3Router      | []                     |
| ABCCApp.ddddBNBPool       | []                     |
| ABCCApp.bnbUSDTPool       | []                     |
| ABCCApp.vaultAddr         | []                     |
| ABCCApp.partUSDT          | []                     |
| ABCCApp.claimFee          | []                     |
| ABCCApp.isEnable          | []                     |
| ABCCApp.DAY               | []                     |
| ABCCApp.Q96               | []                     |
| ABCCApp.fixedDay          | ['fixedDay', 'target'] |
| ABCCApp.REFERER_RATES     | []                     |
| ABCCApp.users             | []                     |
| ABCCApp.dailyPrices       | []                     |
| ABCCApp.userDirects       | []                     |
| ABCCApp.userIncomeRecords | []                     |
| ABCCApp.isOperators       | []                     |
| ABCCApp.globalData        | []                     |
+---------------------------+------------------------+
Function getDDDDValueInUSDT(uint256)
+---------------------------+----------------------------------------------------------+
| Variable                  | Dependencies                                             |
+---------------------------+----------------------------------------------------------+
| amount                    | []                                                       |
|                           | []                                                       |
| tokenPriceInBNB           | ['price']                                                |
| bnbPriceInUSDT            | ['price']                                                |
| valueInUSDT               | ['amount', 'bnbPriceInUSDT', 'price', 'tokenPriceInBNB'] |
| ABCCApp.USDT              | []                                                       |
| ABCCApp.DDDD              | []                                                       |
| ABCCApp.BNB               | []                                                       |
| ABCCApp.swapV3Router      | []                                                       |
| ABCCApp.ddddBNBPool       | []                                                       |
| ABCCApp.bnbUSDTPool       | []                                                       |
| ABCCApp.vaultAddr         | []                                                       |
| ABCCApp.partUSDT          | []                                                       |
| ABCCApp.claimFee          | []                                                       |
| ABCCApp.isEnable          | []                                                       |
| ABCCApp.DAY               | []                                                       |
| ABCCApp.Q96               | []                                                       |
| ABCCApp.fixedDay          | []                                                       |
| ABCCApp.REFERER_RATES     | []                                                       |
| ABCCApp.users             | []                                                       |
| ABCCApp.dailyPrices       | []                                                       |
| ABCCApp.userDirects       | []                                                       |
| ABCCApp.userIncomeRecords | []                                                       |
| ABCCApp.isOperators       | []                                                       |
| ABCCApp.globalData        | []                                                       |
+---------------------------+----------------------------------------------------------+
Function getTokenPriceInBNB()
+---------------------------+----------------------------------------------------------------------------+
| Variable                  | Dependencies                                                               |
+---------------------------+----------------------------------------------------------------------------+
|                           | []                                                                         |
| tokenBnbPool              | ['ddddBNBPool']                                                            |
| sqrtPriceX96              | ['TUPLE_3', 'ddddBNBPool', 'tokenBnbPool']                                 |
| isToken0                  | ['DDDD', 'ddddBNBPool', 'tokenBnbPool']                                    |
| price                     | ['Q96', 'TUPLE_3', 'ddddBNBPool', 'price', 'sqrtPriceX96', 'tokenBnbPool'] |
| ABCCApp.USDT              | []                                                                         |
| ABCCApp.DDDD              | ['DDDD']                                                                   |
| ABCCApp.BNB               | []                                                                         |
| ABCCApp.swapV3Router      | []                                                                         |
| ABCCApp.ddddBNBPool       | ['ddddBNBPool']                                                            |
| ABCCApp.bnbUSDTPool       | []                                                                         |
| ABCCApp.vaultAddr         | []                                                                         |
| ABCCApp.partUSDT          | []                                                                         |
| ABCCApp.claimFee          | []                                                                         |
| ABCCApp.isEnable          | []                                                                         |
| ABCCApp.DAY               | []                                                                         |
| ABCCApp.Q96               | ['Q96']                                                                    |
| ABCCApp.fixedDay          | []                                                                         |
| ABCCApp.REFERER_RATES     | []                                                                         |
| ABCCApp.users             | []                                                                         |
| ABCCApp.dailyPrices       | []                                                                         |
| ABCCApp.userDirects       | []                                                                         |
| ABCCApp.userIncomeRecords | []                                                                         |
| ABCCApp.isOperators       | []                                                                         |
| ABCCApp.globalData        | []                                                                         |
+---------------------------+----------------------------------------------------------------------------+
Function getBNBPriceInUSDT()
+---------------------------+---------------------------------------------------------------------------+
| Variable                  | Dependencies                                                              |
+---------------------------+---------------------------------------------------------------------------+
|                           | []                                                                        |
| bnbUsdtPool               | ['bnbUSDTPool']                                                           |
| sqrtPriceX96              | ['TUPLE_4', 'bnbUSDTPool', 'bnbUsdtPool']                                 |
| isBNBToken0               | ['BNB', 'bnbUSDTPool', 'bnbUsdtPool']                                     |
| price                     | ['Q96', 'TUPLE_4', 'bnbUSDTPool', 'bnbUsdtPool', 'price', 'sqrtPriceX96'] |
| ABCCApp.USDT              | []                                                                        |
| ABCCApp.DDDD              | []                                                                        |
| ABCCApp.BNB               | ['BNB']                                                                   |
| ABCCApp.swapV3Router      | []                                                                        |
| ABCCApp.ddddBNBPool       | []                                                                        |
| ABCCApp.bnbUSDTPool       | ['bnbUSDTPool']                                                           |
| ABCCApp.vaultAddr         | []                                                                        |
| ABCCApp.partUSDT          | []                                                                        |
| ABCCApp.claimFee          | []                                                                        |
| ABCCApp.isEnable          | []                                                                        |
| ABCCApp.DAY               | []                                                                        |
| ABCCApp.Q96               | ['Q96']                                                                   |
| ABCCApp.fixedDay          | []                                                                        |
| ABCCApp.REFERER_RATES     | []                                                                        |
| ABCCApp.users             | []                                                                        |
| ABCCApp.dailyPrices       | []                                                                        |
| ABCCApp.userDirects       | []                                                                        |
| ABCCApp.userIncomeRecords | []                                                                        |
| ABCCApp.isOperators       | []                                                                        |
| ABCCApp.globalData        | []                                                                        |
+---------------------------+---------------------------------------------------------------------------+
Function emergencyFixed(address,address)
+---------------------------+----------------------------+
| Variable                  | Dependencies               |
+---------------------------+----------------------------+
| targetContract            | []                         |
| recipient                 | []                         |
| balance                   | ['targetContract', 'this'] |
| ABCCApp.USDT              | []                         |
| ABCCApp.DDDD              | []                         |
| ABCCApp.BNB               | []                         |
| ABCCApp.swapV3Router      | []                         |
| ABCCApp.ddddBNBPool       | []                         |
| ABCCApp.bnbUSDTPool       | []                         |
| ABCCApp.vaultAddr         | []                         |
| ABCCApp.partUSDT          | []                         |
| ABCCApp.claimFee          | []                         |
| ABCCApp.isEnable          | []                         |
| ABCCApp.DAY               | []                         |
| ABCCApp.Q96               | []                         |
| ABCCApp.fixedDay          | []                         |
| ABCCApp.REFERER_RATES     | []                         |
| ABCCApp.users             | []                         |
| ABCCApp.dailyPrices       | []                         |
| ABCCApp.userDirects       | []                         |
| ABCCApp.userIncomeRecords | []                         |
| ABCCApp.isOperators       | []                         |
| ABCCApp.globalData        | []                         |
+---------------------------+----------------------------+
Function slitherConstructorVariables()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function slitherConstructorConstantVariables()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function isOperator()
+---------------------------+-----------------+
| Variable                  | Dependencies    |
+---------------------------+-----------------+
| ABCCApp.USDT              | []              |
| ABCCApp.DDDD              | []              |
| ABCCApp.BNB               | []              |
| ABCCApp.swapV3Router      | []              |
| ABCCApp.ddddBNBPool       | []              |
| ABCCApp.bnbUSDTPool       | []              |
| ABCCApp.vaultAddr         | []              |
| ABCCApp.partUSDT          | []              |
| ABCCApp.claimFee          | []              |
| ABCCApp.isEnable          | []              |
| ABCCApp.DAY               | []              |
| ABCCApp.Q96               | []              |
| ABCCApp.fixedDay          | []              |
| ABCCApp.REFERER_RATES     | []              |
| ABCCApp.users             | []              |
| ABCCApp.dailyPrices       | []              |
| ABCCApp.userDirects       | []              |
| ABCCApp.userIncomeRecords | []              |
| ABCCApp.isOperators       | ['isOperators'] |
| ABCCApp.globalData        | []              |
+---------------------------+-----------------+
Contract Ownable
+----------+------------------------------------------------------+
| Variable | Dependencies                                         |
+----------+------------------------------------------------------+
| _owner   | ['_owner', 'initialOwner', 'msg.sender', 'newOwner'] |
+----------+------------------------------------------------------+

Function constructor(address)
+----------------+----------------+
| Variable       | Dependencies   |
+----------------+----------------+
| initialOwner   | ['msg.sender'] |
| Ownable._owner | []             |
+----------------+----------------+
Function owner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
|                | []           |
| Ownable._owner | ['_owner']   |
+----------------+--------------+
Function _checkOwner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
Function renounceOwnership()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
Function transferOwnership(address)
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| newOwner       | []           |
| Ownable._owner | []           |
+----------------+--------------+
Function _transferOwnership(address)
+----------------+----------------------------------------+
| Variable       | Dependencies                           |
+----------------+----------------------------------------+
| newOwner       | ['initialOwner', 'newOwner']           |
| oldOwner       | ['_owner', 'initialOwner', 'newOwner'] |
| Ownable._owner | ['_owner', 'initialOwner', 'newOwner'] |
+----------------+----------------------------------------+
Function onlyOwner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
INFO:Printers:
Contract IUniswapV3
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
+----------+--------------+

Function exactInputSingle(IUniswapV3.ExactInputSingleParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function exactInput(IUniswapV3.ExactInputParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function slot0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token1()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Contract ABCCApp
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable          | Dependencies                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| USDT              | ['USDT']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| DDDD              | ['DDDD']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| BNB               | ['BNB']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| swapV3Router      | ['swapV3Router']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ddddBNBPool       | ['ddddBNBPool']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bnbUSDTPool       | ['bnbUSDTPool']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| vaultAddr         | ['target', 'vaultAddr']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| partUSDT          | ['partUSDT', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| claimFee          | ['claimFee', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| isEnable          | ['flag', 'isEnable']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| DAY               | ['DAY']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Q96               | ['Q96']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| fixedDay          | ['fixedDay', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| REFERER_RATES     | ['REFERER_RATES', 'value']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| users             | ['BNB', 'DAY', 'DDDD', 'Q96', 'REFERER_RATES', 'TUPLE_2', 'TUPLE_3', 'TUPLE_4', 'USDT', 'amount', 'amountUSDT', 'block.timestamp', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'canUSDT', 'claimFee', 'ddddAmount', 'ddddBNBPool', 'ddddPrice', 'diffDay', 'diffSecond', 'dynamicUSDT', 'fee', 'fixedDay', 'fullDDDD', 'incomeUSDT', 'number', 'params', 'partUSDT', 'payUSDT', 'price', 'referer', 'sqrtPriceX96', 'staticUSDT', 'swapV3Router', 'target', 'this', 'tokenBnbPool', 'tokenPriceInBNB', 'totalUSDT', 'user', 'users', 'value', 'valueInUSDT']                |
| dailyPrices       | ['Q96', 'TUPLE_3', 'TUPLE_4', 'amount', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'dailyPrices', 'ddddBNBPool', 'price', 'sqrtPriceX96', 'tokenBnbPool', 'tokenPriceInBNB', 'valueInUSDT']                                                                                                                                                                                                                                                                                                                                                                                |
| userDirects       | ['userDirects']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| userIncomeRecords | ['userIncomeRecords']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| isOperators       | ['flag', 'isOperators']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| globalData        | ['BNB', 'DAY', 'DDDD', 'Q96', 'REFERER_RATES', 'TUPLE_2', 'TUPLE_3', 'TUPLE_4', 'USDT', 'amount', 'amountUSDT', 'block.timestamp', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'canUSDT', 'claimFee', 'ddddAmount', 'ddddBNBPool', 'ddddPrice', 'diffDay', 'diffSecond', 'dynamicUSDT', 'fee', 'fixedDay', 'fullDDDD', 'globalData', 'incomeUSDT', 'keepUSDT', 'number', 'params', 'partUSDT', 'payUSDT', 'price', 'sqrtPriceX96', 'staticUSDT', 'swapV3Router', 'target', 'this', 'tokenBnbPool', 'tokenPriceInBNB', 'totalUSDT', 'user', 'users', 'value', 'valueInUSDT'] |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Function constructor()
+---------------------------+-----------------+
| Variable                  | Dependencies    |
+---------------------------+-----------------+
| ABCCApp.USDT              | []              |
| ABCCApp.DDDD              | []              |
| ABCCApp.BNB               | []              |
| ABCCApp.swapV3Router      | []              |
| ABCCApp.ddddBNBPool       | []              |
| ABCCApp.bnbUSDTPool       | []              |
| ABCCApp.vaultAddr         | []              |
| ABCCApp.partUSDT          | []              |
| ABCCApp.claimFee          | []              |
| ABCCApp.isEnable          | []              |
| ABCCApp.DAY               | []              |
| ABCCApp.Q96               | []              |
| ABCCApp.fixedDay          | []              |
| ABCCApp.REFERER_RATES     | []              |
| ABCCApp.users             | []              |
| ABCCApp.dailyPrices       | []              |
| ABCCApp.userDirects       | []              |
| ABCCApp.userIncomeRecords | []              |
| ABCCApp.isOperators       | ['isOperators'] |
| ABCCApp.globalData        | []              |
+---------------------------+-----------------+
Function dashboard(address)
+---------------------------+--------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                     |
+---------------------------+--------------------------------------------------------------------------------------------------+
| target                    | []                                                                                               |
| data                      | ['DDDD', 'TUPLE_0', 'USDT', 'data', 'dynamicUSDT', 'staticUSDT', 'target', 'totalUSDT', 'users'] |
| staticUSDT                | ['TUPLE_0', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                            |
| ABCCApp.USDT              | ['USDT']                                                                                         |
| ABCCApp.DDDD              | ['DDDD']                                                                                         |
| ABCCApp.BNB               | []                                                                                               |
| ABCCApp.swapV3Router      | []                                                                                               |
| ABCCApp.ddddBNBPool       | []                                                                                               |
| ABCCApp.bnbUSDTPool       | []                                                                                               |
| ABCCApp.vaultAddr         | []                                                                                               |
| ABCCApp.partUSDT          | []                                                                                               |
| ABCCApp.claimFee          | []                                                                                               |
| ABCCApp.isEnable          | []                                                                                               |
| ABCCApp.DAY               | []                                                                                               |
| ABCCApp.Q96               | []                                                                                               |
| ABCCApp.fixedDay          | []                                                                                               |
| ABCCApp.REFERER_RATES     | []                                                                                               |
| ABCCApp.users             | ['users']                                                                                        |
| ABCCApp.dailyPrices       | []                                                                                               |
| ABCCApp.userDirects       | []                                                                                               |
| ABCCApp.userIncomeRecords | []                                                                                               |
| ABCCApp.isOperators       | []                                                                                               |
| ABCCApp.globalData        | []                                                                                               |
+---------------------------+--------------------------------------------------------------------------------------------------+
Function setPartUSDT(uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | ['target']   |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setOperator(address,bool)
+---------------------------+-------------------------+
| Variable                  | Dependencies            |
+---------------------------+-------------------------+
| target                    | []                      |
| flag                      | []                      |
| ABCCApp.USDT              | []                      |
| ABCCApp.DDDD              | []                      |
| ABCCApp.BNB               | []                      |
| ABCCApp.swapV3Router      | []                      |
| ABCCApp.ddddBNBPool       | []                      |
| ABCCApp.bnbUSDTPool       | []                      |
| ABCCApp.vaultAddr         | []                      |
| ABCCApp.partUSDT          | []                      |
| ABCCApp.claimFee          | []                      |
| ABCCApp.isEnable          | []                      |
| ABCCApp.DAY               | []                      |
| ABCCApp.Q96               | []                      |
| ABCCApp.fixedDay          | []                      |
| ABCCApp.REFERER_RATES     | []                      |
| ABCCApp.users             | []                      |
| ABCCApp.dailyPrices       | []                      |
| ABCCApp.userDirects       | []                      |
| ABCCApp.userIncomeRecords | []                      |
| ABCCApp.isOperators       | ['flag', 'isOperators'] |
| ABCCApp.globalData        | []                      |
+---------------------------+-------------------------+
Function setVaultAddr(address)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | ['target']   |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setEnable(bool)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| flag                      | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | ['flag']     |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function getCanClaimUSDT(address)
+---------------------------+---------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                      |
+---------------------------+---------------------------------------------------------------------------------------------------+
| target                    | ['msg.sender', 'target']                                                                          |
| totalUSDT                 | ['DAY', 'block.timestamp', 'diffDay', 'diffSecond', 'dynamicUSDT', 'staticUSDT', 'user', 'users'] |
| staticUSDT                | ['DAY', 'block.timestamp', 'diffDay', 'diffSecond', 'staticUSDT', 'user', 'users']                |
| dynamicUSDT               | ['user', 'users']                                                                                 |
| user                      | ['user', 'users']                                                                                 |
| diffSecond                | ['block.timestamp', 'user', 'users']                                                              |
| diffDay                   | ['DAY', 'block.timestamp', 'diffSecond', 'user', 'users']                                         |
| ABCCApp.USDT              | []                                                                                                |
| ABCCApp.DDDD              | []                                                                                                |
| ABCCApp.BNB               | []                                                                                                |
| ABCCApp.swapV3Router      | []                                                                                                |
| ABCCApp.ddddBNBPool       | []                                                                                                |
| ABCCApp.bnbUSDTPool       | []                                                                                                |
| ABCCApp.vaultAddr         | []                                                                                                |
| ABCCApp.partUSDT          | []                                                                                                |
| ABCCApp.claimFee          | []                                                                                                |
| ABCCApp.isEnable          | []                                                                                                |
| ABCCApp.DAY               | ['DAY']                                                                                           |
| ABCCApp.Q96               | []                                                                                                |
| ABCCApp.fixedDay          | []                                                                                                |
| ABCCApp.REFERER_RATES     | []                                                                                                |
| ABCCApp.users             | ['users']                                                                                         |
| ABCCApp.dailyPrices       | []                                                                                                |
| ABCCApp.userDirects       | []                                                                                                |
| ABCCApp.userIncomeRecords | []                                                                                                |
| ABCCApp.isOperators       | []                                                                                                |
| ABCCApp.globalData        | []                                                                                                |
+---------------------------+---------------------------------------------------------------------------------------------------+
Function deposit(uint256,address)
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                                                          |
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| number                    | []                                                                                                                                                    |
| referer                   | ['referer', 'this']                                                                                                                                   |
| user                      | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'number', 'params', 'partUSDT', 'payUSDT', 'referer', 'swapV3Router', 'this', 'user']          |
| totalUSDT                 | ['TUPLE_1', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                 |
| payUSDT                   | ['number', 'partUSDT']                                                                                                                                |
| params                    | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'number', 'partUSDT', 'payUSDT', 'this']                                                                   |
| fullDDDD                  | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'number', 'params', 'partUSDT', 'payUSDT', 'swapV3Router', 'this']                                         |
| ABCCApp.USDT              | ['USDT']                                                                                                                                              |
| ABCCApp.DDDD              | ['DDDD']                                                                                                                                              |
| ABCCApp.BNB               | ['BNB']                                                                                                                                               |
| ABCCApp.swapV3Router      | ['swapV3Router']                                                                                                                                      |
| ABCCApp.ddddBNBPool       | []                                                                                                                                                    |
| ABCCApp.bnbUSDTPool       | []                                                                                                                                                    |
| ABCCApp.vaultAddr         | []                                                                                                                                                    |
| ABCCApp.partUSDT          | ['partUSDT']                                                                                                                                          |
| ABCCApp.claimFee          | []                                                                                                                                                    |
| ABCCApp.isEnable          | ['isEnable']                                                                                                                                          |
| ABCCApp.DAY               | []                                                                                                                                                    |
| ABCCApp.Q96               | []                                                                                                                                                    |
| ABCCApp.fixedDay          | []                                                                                                                                                    |
| ABCCApp.REFERER_RATES     | []                                                                                                                                                    |
| ABCCApp.users             | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'number', 'params', 'partUSDT', 'payUSDT', 'referer', 'swapV3Router', 'this', 'user', 'users'] |
| ABCCApp.dailyPrices       | []                                                                                                                                                    |
| ABCCApp.userDirects       | ['userDirects']                                                                                                                                       |
| ABCCApp.userIncomeRecords | []                                                                                                                                                    |
| ABCCApp.isOperators       | []                                                                                                                                                    |
| ABCCApp.globalData        | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'globalData', 'number', 'params', 'partUSDT', 'payUSDT', 'swapV3Router', 'this']               |
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
Function claimDDDD()
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                                                           |
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| user                      | ['TUPLE_2', 'block.timestamp', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'user', 'valueInUSDT']          |
| totalUSDT                 | ['TUPLE_2', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                  |
| staticUSDT                | ['TUPLE_2', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                  |
| ddddPrice                 | ['valueInUSDT']                                                                                                                                        |
| ddddAmount                | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                                     |
| fee                       | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                                            |
| ABCCApp.USDT              | []                                                                                                                                                     |
| ABCCApp.DDDD              | ['DDDD']                                                                                                                                               |
| ABCCApp.BNB               | []                                                                                                                                                     |
| ABCCApp.swapV3Router      | []                                                                                                                                                     |
| ABCCApp.ddddBNBPool       | []                                                                                                                                                     |
| ABCCApp.bnbUSDTPool       | []                                                                                                                                                     |
| ABCCApp.vaultAddr         | ['vaultAddr']                                                                                                                                          |
| ABCCApp.partUSDT          | []                                                                                                                                                     |
| ABCCApp.claimFee          | ['claimFee']                                                                                                                                           |
| ABCCApp.isEnable          | []                                                                                                                                                     |
| ABCCApp.DAY               | []                                                                                                                                                     |
| ABCCApp.Q96               | []                                                                                                                                                     |
| ABCCApp.fixedDay          | []                                                                                                                                                     |
| ABCCApp.REFERER_RATES     | []                                                                                                                                                     |
| ABCCApp.users             | ['TUPLE_2', 'block.timestamp', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'user', 'users', 'valueInUSDT'] |
| ABCCApp.dailyPrices       | []                                                                                                                                                     |
| ABCCApp.userDirects       | []                                                                                                                                                     |
| ABCCApp.userIncomeRecords | []                                                                                                                                                     |
| ABCCApp.isOperators       | []                                                                                                                                                     |
| ABCCApp.globalData        | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'globalData', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                       |
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
Function processReferers(address,address,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                             |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| sender                    | ['msg.sender']                                                                                           |
| current                   | ['current', 'user']                                                                                      |
| amountUSDT                | ['staticUSDT']                                                                                           |
| keepUSDT                  | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'keepUSDT', 'staticUSDT', 'user']               |
| depth                     | ['depth']                                                                                                |
| user                      | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| incomeUSDT                | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| canUSDT                   | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| ABCCApp.USDT              | []                                                                                                       |
| ABCCApp.DDDD              | []                                                                                                       |
| ABCCApp.BNB               | []                                                                                                       |
| ABCCApp.swapV3Router      | []                                                                                                       |
| ABCCApp.ddddBNBPool       | []                                                                                                       |
| ABCCApp.bnbUSDTPool       | []                                                                                                       |
| ABCCApp.vaultAddr         | []                                                                                                       |
| ABCCApp.partUSDT          | []                                                                                                       |
| ABCCApp.claimFee          | []                                                                                                       |
| ABCCApp.isEnable          | []                                                                                                       |
| ABCCApp.DAY               | []                                                                                                       |
| ABCCApp.Q96               | []                                                                                                       |
| ABCCApp.fixedDay          | []                                                                                                       |
| ABCCApp.REFERER_RATES     | ['REFERER_RATES']                                                                                        |
| ABCCApp.users             | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user', 'users']                  |
| ABCCApp.dailyPrices       | []                                                                                                       |
| ABCCApp.userDirects       | []                                                                                                       |
| ABCCApp.userIncomeRecords | ['userIncomeRecords']                                                                                    |
| ABCCApp.isOperators       | []                                                                                                       |
| ABCCApp.globalData        | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'globalData', 'incomeUSDT', 'keepUSDT', 'staticUSDT', 'user'] |
+---------------------------+----------------------------------------------------------------------------------------------------------+
Function getUserDirects(address,uint256,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                   |
+---------------------------+----------------------------------------------------------------------------------------------------------------+
| _user                     | []                                                                                                             |
| page                      | []                                                                                                             |
| pageSize                  | []                                                                                                             |
|                           | []                                                                                                             |
| referrals                 | ['referrals', 'userDirects']                                                                                   |
| len                       | ['referrals', 'userDirects']                                                                                   |
| start                     | ['len', 'page', 'pageSize', 'referrals', 'start', 'userDirects']                                               |
| end                       | ['end', 'len', 'page', 'pageSize', 'referrals', 'userDirects']                                                 |
| resultLen                 | ['end', 'len', 'page', 'pageSize', 'referrals', 'start', 'userDirects']                                        |
| result                    | ['end', 'len', 'page', 'pageSize', 'ref', 'referrals', 'result', 'resultLen', 'start', 'userDirects', 'users'] |
| i                         | ['i']                                                                                                          |
| ref                       | ['ref', 'referrals', 'userDirects']                                                                            |
| ABCCApp.USDT              | []                                                                                                             |
| ABCCApp.DDDD              | []                                                                                                             |
| ABCCApp.BNB               | []                                                                                                             |
| ABCCApp.swapV3Router      | []                                                                                                             |
| ABCCApp.ddddBNBPool       | []                                                                                                             |
| ABCCApp.bnbUSDTPool       | []                                                                                                             |
| ABCCApp.vaultAddr         | []                                                                                                             |
| ABCCApp.partUSDT          | []                                                                                                             |
| ABCCApp.claimFee          | []                                                                                                             |
| ABCCApp.isEnable          | []                                                                                                             |
| ABCCApp.DAY               | []                                                                                                             |
| ABCCApp.Q96               | []                                                                                                             |
| ABCCApp.fixedDay          | []                                                                                                             |
| ABCCApp.REFERER_RATES     | []                                                                                                             |
| ABCCApp.users             | ['users']                                                                                                      |
| ABCCApp.dailyPrices       | []                                                                                                             |
| ABCCApp.userDirects       | ['userDirects']                                                                                                |
| ABCCApp.userIncomeRecords | []                                                                                                             |
| ABCCApp.isOperators       | []                                                                                                             |
| ABCCApp.globalData        | []                                                                                                             |
+---------------------------+----------------------------------------------------------------------------------------------------------------+
Function getIncomeRecords(address,uint256,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                       |
+---------------------------+----------------------------------------------------------------------------------------------------+
| user                      | []                                                                                                 |
| page                      | []                                                                                                 |
| pageSize                  | []                                                                                                 |
|                           | []                                                                                                 |
| records                   | ['records', 'userIncomeRecords']                                                                   |
| len                       | ['records', 'userIncomeRecords']                                                                   |
| start                     | ['len', 'page', 'pageSize', 'records', 'start', 'userIncomeRecords']                               |
| end                       | ['end', 'len', 'page', 'pageSize', 'records', 'userIncomeRecords']                                 |
| resultLen                 | ['end', 'len', 'page', 'pageSize', 'records', 'start', 'userIncomeRecords']                        |
| result                    | ['end', 'len', 'page', 'pageSize', 'records', 'result', 'resultLen', 'start', 'userIncomeRecords'] |
| i                         | ['i']                                                                                              |
| ABCCApp.USDT              | []                                                                                                 |
| ABCCApp.DDDD              | []                                                                                                 |
| ABCCApp.BNB               | []                                                                                                 |
| ABCCApp.swapV3Router      | []                                                                                                 |
| ABCCApp.ddddBNBPool       | []                                                                                                 |
| ABCCApp.bnbUSDTPool       | []                                                                                                 |
| ABCCApp.vaultAddr         | []                                                                                                 |
| ABCCApp.partUSDT          | []                                                                                                 |
| ABCCApp.claimFee          | []                                                                                                 |
| ABCCApp.isEnable          | []                                                                                                 |
| ABCCApp.DAY               | []                                                                                                 |
| ABCCApp.Q96               | []                                                                                                 |
| ABCCApp.fixedDay          | []                                                                                                 |
| ABCCApp.REFERER_RATES     | []                                                                                                 |
| ABCCApp.users             | []                                                                                                 |
| ABCCApp.dailyPrices       | []                                                                                                 |
| ABCCApp.userDirects       | []                                                                                                 |
| ABCCApp.userIncomeRecords | ['userIncomeRecords']                                                                              |
| ABCCApp.isOperators       | []                                                                                                 |
| ABCCApp.globalData        | []                                                                                                 |
+---------------------------+----------------------------------------------------------------------------------------------------+
Function setSettlePrice(uint256,uint256)
+---------------------------+-----------------------------------------+
| Variable                  | Dependencies                            |
+---------------------------+-----------------------------------------+
| price                     | ['price', 'valueInUSDT']                |
| targetTime                | ['block.timestamp', 'targetTime']       |
| ABCCApp.USDT              | []                                      |
| ABCCApp.DDDD              | []                                      |
| ABCCApp.BNB               | []                                      |
| ABCCApp.swapV3Router      | []                                      |
| ABCCApp.ddddBNBPool       | []                                      |
| ABCCApp.bnbUSDTPool       | []                                      |
| ABCCApp.vaultAddr         | []                                      |
| ABCCApp.partUSDT          | []                                      |
| ABCCApp.claimFee          | []                                      |
| ABCCApp.isEnable          | []                                      |
| ABCCApp.DAY               | ['DAY']                                 |
| ABCCApp.Q96               | []                                      |
| ABCCApp.fixedDay          | []                                      |
| ABCCApp.REFERER_RATES     | []                                      |
| ABCCApp.users             | []                                      |
| ABCCApp.dailyPrices       | ['dailyPrices', 'price', 'valueInUSDT'] |
| ABCCApp.userDirects       | []                                      |
| ABCCApp.userIncomeRecords | []                                      |
| ABCCApp.isOperators       | []                                      |
| ABCCApp.globalData        | []                                      |
+---------------------------+-----------------------------------------+
Function setLevelRate(uint256,uint256)
+---------------------------+----------------------------+
| Variable                  | Dependencies               |
+---------------------------+----------------------------+
| index                     | []                         |
| value                     | []                         |
| ABCCApp.USDT              | []                         |
| ABCCApp.DDDD              | []                         |
| ABCCApp.BNB               | []                         |
| ABCCApp.swapV3Router      | []                         |
| ABCCApp.ddddBNBPool       | []                         |
| ABCCApp.bnbUSDTPool       | []                         |
| ABCCApp.vaultAddr         | []                         |
| ABCCApp.partUSDT          | []                         |
| ABCCApp.claimFee          | []                         |
| ABCCApp.isEnable          | []                         |
| ABCCApp.DAY               | []                         |
| ABCCApp.Q96               | []                         |
| ABCCApp.fixedDay          | []                         |
| ABCCApp.REFERER_RATES     | ['REFERER_RATES', 'value'] |
| ABCCApp.users             | []                         |
| ABCCApp.dailyPrices       | []                         |
| ABCCApp.userDirects       | []                         |
| ABCCApp.userIncomeRecords | []                         |
| ABCCApp.isOperators       | []                         |
| ABCCApp.globalData        | []                         |
+---------------------------+----------------------------+
Function setClaimFee(uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | ['target']   |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setUserRemainingUSDT(address,uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| value                     | []           |
| old                       | ['users']    |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | ['users']    |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function getFixedDay()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
|                           | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | ['DAY']      |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | ['fixedDay'] |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function addFixedDay(uint256)
+---------------------------+------------------------+
| Variable                  | Dependencies           |
+---------------------------+------------------------+
| target                    | []                     |
| ABCCApp.USDT              | []                     |
| ABCCApp.DDDD              | []                     |
| ABCCApp.BNB               | []                     |
| ABCCApp.swapV3Router      | []                     |
| ABCCApp.ddddBNBPool       | []                     |
| ABCCApp.bnbUSDTPool       | []                     |
| ABCCApp.vaultAddr         | []                     |
| ABCCApp.partUSDT          | []                     |
| ABCCApp.claimFee          | []                     |
| ABCCApp.isEnable          | []                     |
| ABCCApp.DAY               | []                     |
| ABCCApp.Q96               | []                     |
| ABCCApp.fixedDay          | ['fixedDay', 'target'] |
| ABCCApp.REFERER_RATES     | []                     |
| ABCCApp.users             | []                     |
| ABCCApp.dailyPrices       | []                     |
| ABCCApp.userDirects       | []                     |
| ABCCApp.userIncomeRecords | []                     |
| ABCCApp.isOperators       | []                     |
| ABCCApp.globalData        | []                     |
+---------------------------+------------------------+
Function getDDDDValueInUSDT(uint256)
+---------------------------+----------------------------------------------------------+
| Variable                  | Dependencies                                             |
+---------------------------+----------------------------------------------------------+
| amount                    | []                                                       |
|                           | []                                                       |
| tokenPriceInBNB           | ['price']                                                |
| bnbPriceInUSDT            | ['price']                                                |
| valueInUSDT               | ['amount', 'bnbPriceInUSDT', 'price', 'tokenPriceInBNB'] |
| ABCCApp.USDT              | []                                                       |
| ABCCApp.DDDD              | []                                                       |
| ABCCApp.BNB               | []                                                       |
| ABCCApp.swapV3Router      | []                                                       |
| ABCCApp.ddddBNBPool       | []                                                       |
| ABCCApp.bnbUSDTPool       | []                                                       |
| ABCCApp.vaultAddr         | []                                                       |
| ABCCApp.partUSDT          | []                                                       |
| ABCCApp.claimFee          | []                                                       |
| ABCCApp.isEnable          | []                                                       |
| ABCCApp.DAY               | []                                                       |
| ABCCApp.Q96               | []                                                       |
| ABCCApp.fixedDay          | []                                                       |
| ABCCApp.REFERER_RATES     | []                                                       |
| ABCCApp.users             | []                                                       |
| ABCCApp.dailyPrices       | []                                                       |
| ABCCApp.userDirects       | []                                                       |
| ABCCApp.userIncomeRecords | []                                                       |
| ABCCApp.isOperators       | []                                                       |
| ABCCApp.globalData        | []                                                       |
+---------------------------+----------------------------------------------------------+
Function getTokenPriceInBNB()
+---------------------------+----------------------------------------------------------------------------+
| Variable                  | Dependencies                                                               |
+---------------------------+----------------------------------------------------------------------------+
|                           | []                                                                         |
| tokenBnbPool              | ['ddddBNBPool']                                                            |
| sqrtPriceX96              | ['TUPLE_3', 'ddddBNBPool', 'tokenBnbPool']                                 |
| isToken0                  | ['DDDD', 'ddddBNBPool', 'tokenBnbPool']                                    |
| price                     | ['Q96', 'TUPLE_3', 'ddddBNBPool', 'price', 'sqrtPriceX96', 'tokenBnbPool'] |
| ABCCApp.USDT              | []                                                                         |
| ABCCApp.DDDD              | ['DDDD']                                                                   |
| ABCCApp.BNB               | []                                                                         |
| ABCCApp.swapV3Router      | []                                                                         |
| ABCCApp.ddddBNBPool       | ['ddddBNBPool']                                                            |
| ABCCApp.bnbUSDTPool       | []                                                                         |
| ABCCApp.vaultAddr         | []                                                                         |
| ABCCApp.partUSDT          | []                                                                         |
| ABCCApp.claimFee          | []                                                                         |
| ABCCApp.isEnable          | []                                                                         |
| ABCCApp.DAY               | []                                                                         |
| ABCCApp.Q96               | ['Q96']                                                                    |
| ABCCApp.fixedDay          | []                                                                         |
| ABCCApp.REFERER_RATES     | []                                                                         |
| ABCCApp.users             | []                                                                         |
| ABCCApp.dailyPrices       | []                                                                         |
| ABCCApp.userDirects       | []                                                                         |
| ABCCApp.userIncomeRecords | []                                                                         |
| ABCCApp.isOperators       | []                                                                         |
| ABCCApp.globalData        | []                                                                         |
+---------------------------+----------------------------------------------------------------------------+
Function getBNBPriceInUSDT()
+---------------------------+---------------------------------------------------------------------------+
| Variable                  | Dependencies                                                              |
+---------------------------+---------------------------------------------------------------------------+
|                           | []                                                                        |
| bnbUsdtPool               | ['bnbUSDTPool']                                                           |
| sqrtPriceX96              | ['TUPLE_4', 'bnbUSDTPool', 'bnbUsdtPool']                                 |
| isBNBToken0               | ['BNB', 'bnbUSDTPool', 'bnbUsdtPool']                                     |
| price                     | ['Q96', 'TUPLE_4', 'bnbUSDTPool', 'bnbUsdtPool', 'price', 'sqrtPriceX96'] |
| ABCCApp.USDT              | []                                                                        |
| ABCCApp.DDDD              | []                                                                        |
| ABCCApp.BNB               | ['BNB']                                                                   |
| ABCCApp.swapV3Router      | []                                                                        |
| ABCCApp.ddddBNBPool       | []                                                                        |
| ABCCApp.bnbUSDTPool       | ['bnbUSDTPool']                                                           |
| ABCCApp.vaultAddr         | []                                                                        |
| ABCCApp.partUSDT          | []                                                                        |
| ABCCApp.claimFee          | []                                                                        |
| ABCCApp.isEnable          | []                                                                        |
| ABCCApp.DAY               | []                                                                        |
| ABCCApp.Q96               | ['Q96']                                                                   |
| ABCCApp.fixedDay          | []                                                                        |
| ABCCApp.REFERER_RATES     | []                                                                        |
| ABCCApp.users             | []                                                                        |
| ABCCApp.dailyPrices       | []                                                                        |
| ABCCApp.userDirects       | []                                                                        |
| ABCCApp.userIncomeRecords | []                                                                        |
| ABCCApp.isOperators       | []                                                                        |
| ABCCApp.globalData        | []                                                                        |
+---------------------------+---------------------------------------------------------------------------+
Function emergencyFixed(address,address)
+---------------------------+----------------------------+
| Variable                  | Dependencies               |
+---------------------------+----------------------------+
| targetContract            | []                         |
| recipient                 | []                         |
| balance                   | ['targetContract', 'this'] |
| ABCCApp.USDT              | []                         |
| ABCCApp.DDDD              | []                         |
| ABCCApp.BNB               | []                         |
| ABCCApp.swapV3Router      | []                         |
| ABCCApp.ddddBNBPool       | []                         |
| ABCCApp.bnbUSDTPool       | []                         |
| ABCCApp.vaultAddr         | []                         |
| ABCCApp.partUSDT          | []                         |
| ABCCApp.claimFee          | []                         |
| ABCCApp.isEnable          | []                         |
| ABCCApp.DAY               | []                         |
| ABCCApp.Q96               | []                         |
| ABCCApp.fixedDay          | []                         |
| ABCCApp.REFERER_RATES     | []                         |
| ABCCApp.users             | []                         |
| ABCCApp.dailyPrices       | []                         |
| ABCCApp.userDirects       | []                         |
| ABCCApp.userIncomeRecords | []                         |
| ABCCApp.isOperators       | []                         |
| ABCCApp.globalData        | []                         |
+---------------------------+----------------------------+
Function slitherConstructorVariables()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function slitherConstructorConstantVariables()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function isOperator()
+---------------------------+-----------------+
| Variable                  | Dependencies    |
+---------------------------+-----------------+
| ABCCApp.USDT              | []              |
| ABCCApp.DDDD              | []              |
| ABCCApp.BNB               | []              |
| ABCCApp.swapV3Router      | []              |
| ABCCApp.ddddBNBPool       | []              |
| ABCCApp.bnbUSDTPool       | []              |
| ABCCApp.vaultAddr         | []              |
| ABCCApp.partUSDT          | []              |
| ABCCApp.claimFee          | []              |
| ABCCApp.isEnable          | []              |
| ABCCApp.DAY               | []              |
| ABCCApp.Q96               | []              |
| ABCCApp.fixedDay          | []              |
| ABCCApp.REFERER_RATES     | []              |
| ABCCApp.users             | []              |
| ABCCApp.dailyPrices       | []              |
| ABCCApp.userDirects       | []              |
| ABCCApp.userIncomeRecords | []              |
| ABCCApp.isOperators       | ['isOperators'] |
| ABCCApp.globalData        | []              |
+---------------------------+-----------------+
Contract Ownable
+----------+------------------------------------------------------+
| Variable | Dependencies                                         |
+----------+------------------------------------------------------+
| _owner   | ['_owner', 'initialOwner', 'msg.sender', 'newOwner'] |
+----------+------------------------------------------------------+

Function constructor(address)
+----------------+----------------+
| Variable       | Dependencies   |
+----------------+----------------+
| initialOwner   | ['msg.sender'] |
| Ownable._owner | []             |
+----------------+----------------+
Function owner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
|                | []           |
| Ownable._owner | ['_owner']   |
+----------------+--------------+
Function _checkOwner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
Function renounceOwnership()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
Function transferOwnership(address)
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| newOwner       | []           |
| Ownable._owner | []           |
+----------------+--------------+
Function _transferOwnership(address)
+----------------+----------------------------------------+
| Variable       | Dependencies                           |
+----------------+----------------------------------------+
| newOwner       | ['initialOwner', 'newOwner']           |
| oldOwner       | ['_owner', 'initialOwner', 'newOwner'] |
| Ownable._owner | ['_owner', 'initialOwner', 'newOwner'] |
+----------------+----------------------------------------+
Function onlyOwner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
Contract IERC20
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
+----------+--------------+

Function totalSupply()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function balanceOf(address)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| account  | []           |
|          | []           |
+----------+--------------+
Function transfer(address,uint256)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| to       | []           |
| value    | []           |
|          | []           |
+----------+--------------+
Function allowance(address,address)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| owner    | []           |
| spender  | []           |
|          | []           |
+----------+--------------+
Function approve(address,uint256)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| spender  | []           |
| value    | []           |
|          | []           |
+----------+--------------+
Function transferFrom(address,address,uint256)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| from     | []           |
| to       | []           |
| value    | []           |
|          | []           |
+----------+--------------+
INFO:Printers:
Contract IUniswapV3
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
+----------+--------------+

Function exactInputSingle(IUniswapV3.ExactInputSingleParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function exactInput(IUniswapV3.ExactInputParams)
+-----------+--------------+
| Variable  | Dependencies |
+-----------+--------------+
| params    | []           |
| amountOut | []           |
+-----------+--------------+
Function slot0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token0()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function token1()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Contract ABCCApp
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable          | Dependencies                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| USDT              | ['USDT']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| DDDD              | ['DDDD']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| BNB               | ['BNB']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| swapV3Router      | ['swapV3Router']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| ddddBNBPool       | ['ddddBNBPool']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| bnbUSDTPool       | ['bnbUSDTPool']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| vaultAddr         | ['target', 'vaultAddr']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| partUSDT          | ['partUSDT', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| claimFee          | ['claimFee', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| isEnable          | ['flag', 'isEnable']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| DAY               | ['DAY']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| Q96               | ['Q96']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| fixedDay          | ['fixedDay', 'target']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
| REFERER_RATES     | ['REFERER_RATES', 'value']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
| users             | ['BNB', 'DAY', 'DDDD', 'Q96', 'REFERER_RATES', 'TUPLE_2', 'TUPLE_3', 'TUPLE_4', 'USDT', 'amount', 'amountUSDT', 'block.timestamp', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'canUSDT', 'claimFee', 'ddddAmount', 'ddddBNBPool', 'ddddPrice', 'diffDay', 'diffSecond', 'dynamicUSDT', 'fee', 'fixedDay', 'fullDDDD', 'incomeUSDT', 'number', 'params', 'partUSDT', 'payUSDT', 'price', 'referer', 'sqrtPriceX96', 'staticUSDT', 'swapV3Router', 'target', 'this', 'tokenBnbPool', 'tokenPriceInBNB', 'totalUSDT', 'user', 'users', 'value', 'valueInUSDT']                |
| dailyPrices       | ['Q96', 'TUPLE_3', 'TUPLE_4', 'amount', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'dailyPrices', 'ddddBNBPool', 'price', 'sqrtPriceX96', 'tokenBnbPool', 'tokenPriceInBNB', 'valueInUSDT']                                                                                                                                                                                                                                                                                                                                                                                |
| userDirects       | ['userDirects']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 |
| userIncomeRecords | ['userIncomeRecords']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| isOperators       | ['flag', 'isOperators']                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| globalData        | ['BNB', 'DAY', 'DDDD', 'Q96', 'REFERER_RATES', 'TUPLE_2', 'TUPLE_3', 'TUPLE_4', 'USDT', 'amount', 'amountUSDT', 'block.timestamp', 'bnbPriceInUSDT', 'bnbUSDTPool', 'bnbUsdtPool', 'canUSDT', 'claimFee', 'ddddAmount', 'ddddBNBPool', 'ddddPrice', 'diffDay', 'diffSecond', 'dynamicUSDT', 'fee', 'fixedDay', 'fullDDDD', 'globalData', 'incomeUSDT', 'keepUSDT', 'number', 'params', 'partUSDT', 'payUSDT', 'price', 'sqrtPriceX96', 'staticUSDT', 'swapV3Router', 'target', 'this', 'tokenBnbPool', 'tokenPriceInBNB', 'totalUSDT', 'user', 'users', 'value', 'valueInUSDT'] |
+-------------------+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

Function constructor()
+---------------------------+-----------------+
| Variable                  | Dependencies    |
+---------------------------+-----------------+
| ABCCApp.USDT              | []              |
| ABCCApp.DDDD              | []              |
| ABCCApp.BNB               | []              |
| ABCCApp.swapV3Router      | []              |
| ABCCApp.ddddBNBPool       | []              |
| ABCCApp.bnbUSDTPool       | []              |
| ABCCApp.vaultAddr         | []              |
| ABCCApp.partUSDT          | []              |
| ABCCApp.claimFee          | []              |
| ABCCApp.isEnable          | []              |
| ABCCApp.DAY               | []              |
| ABCCApp.Q96               | []              |
| ABCCApp.fixedDay          | []              |
| ABCCApp.REFERER_RATES     | []              |
| ABCCApp.users             | []              |
| ABCCApp.dailyPrices       | []              |
| ABCCApp.userDirects       | []              |
| ABCCApp.userIncomeRecords | []              |
| ABCCApp.isOperators       | ['isOperators'] |
| ABCCApp.globalData        | []              |
+---------------------------+-----------------+
Function dashboard(address)
+---------------------------+--------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                     |
+---------------------------+--------------------------------------------------------------------------------------------------+
| target                    | []                                                                                               |
| data                      | ['DDDD', 'TUPLE_0', 'USDT', 'data', 'dynamicUSDT', 'staticUSDT', 'target', 'totalUSDT', 'users'] |
| staticUSDT                | ['TUPLE_0', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                            |
| ABCCApp.USDT              | ['USDT']                                                                                         |
| ABCCApp.DDDD              | ['DDDD']                                                                                         |
| ABCCApp.BNB               | []                                                                                               |
| ABCCApp.swapV3Router      | []                                                                                               |
| ABCCApp.ddddBNBPool       | []                                                                                               |
| ABCCApp.bnbUSDTPool       | []                                                                                               |
| ABCCApp.vaultAddr         | []                                                                                               |
| ABCCApp.partUSDT          | []                                                                                               |
| ABCCApp.claimFee          | []                                                                                               |
| ABCCApp.isEnable          | []                                                                                               |
| ABCCApp.DAY               | []                                                                                               |
| ABCCApp.Q96               | []                                                                                               |
| ABCCApp.fixedDay          | []                                                                                               |
| ABCCApp.REFERER_RATES     | []                                                                                               |
| ABCCApp.users             | ['users']                                                                                        |
| ABCCApp.dailyPrices       | []                                                                                               |
| ABCCApp.userDirects       | []                                                                                               |
| ABCCApp.userIncomeRecords | []                                                                                               |
| ABCCApp.isOperators       | []                                                                                               |
| ABCCApp.globalData        | []                                                                                               |
+---------------------------+--------------------------------------------------------------------------------------------------+
Function setPartUSDT(uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | ['target']   |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setOperator(address,bool)
+---------------------------+-------------------------+
| Variable                  | Dependencies            |
+---------------------------+-------------------------+
| target                    | []                      |
| flag                      | []                      |
| ABCCApp.USDT              | []                      |
| ABCCApp.DDDD              | []                      |
| ABCCApp.BNB               | []                      |
| ABCCApp.swapV3Router      | []                      |
| ABCCApp.ddddBNBPool       | []                      |
| ABCCApp.bnbUSDTPool       | []                      |
| ABCCApp.vaultAddr         | []                      |
| ABCCApp.partUSDT          | []                      |
| ABCCApp.claimFee          | []                      |
| ABCCApp.isEnable          | []                      |
| ABCCApp.DAY               | []                      |
| ABCCApp.Q96               | []                      |
| ABCCApp.fixedDay          | []                      |
| ABCCApp.REFERER_RATES     | []                      |
| ABCCApp.users             | []                      |
| ABCCApp.dailyPrices       | []                      |
| ABCCApp.userDirects       | []                      |
| ABCCApp.userIncomeRecords | []                      |
| ABCCApp.isOperators       | ['flag', 'isOperators'] |
| ABCCApp.globalData        | []                      |
+---------------------------+-------------------------+
Function setVaultAddr(address)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | ['target']   |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setEnable(bool)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| flag                      | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | ['flag']     |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function getCanClaimUSDT(address)
+---------------------------+---------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                      |
+---------------------------+---------------------------------------------------------------------------------------------------+
| target                    | ['msg.sender', 'target']                                                                          |
| totalUSDT                 | ['DAY', 'block.timestamp', 'diffDay', 'diffSecond', 'dynamicUSDT', 'staticUSDT', 'user', 'users'] |
| staticUSDT                | ['DAY', 'block.timestamp', 'diffDay', 'diffSecond', 'staticUSDT', 'user', 'users']                |
| dynamicUSDT               | ['user', 'users']                                                                                 |
| user                      | ['user', 'users']                                                                                 |
| diffSecond                | ['block.timestamp', 'user', 'users']                                                              |
| diffDay                   | ['DAY', 'block.timestamp', 'diffSecond', 'user', 'users']                                         |
| ABCCApp.USDT              | []                                                                                                |
| ABCCApp.DDDD              | []                                                                                                |
| ABCCApp.BNB               | []                                                                                                |
| ABCCApp.swapV3Router      | []                                                                                                |
| ABCCApp.ddddBNBPool       | []                                                                                                |
| ABCCApp.bnbUSDTPool       | []                                                                                                |
| ABCCApp.vaultAddr         | []                                                                                                |
| ABCCApp.partUSDT          | []                                                                                                |
| ABCCApp.claimFee          | []                                                                                                |
| ABCCApp.isEnable          | []                                                                                                |
| ABCCApp.DAY               | ['DAY']                                                                                           |
| ABCCApp.Q96               | []                                                                                                |
| ABCCApp.fixedDay          | []                                                                                                |
| ABCCApp.REFERER_RATES     | []                                                                                                |
| ABCCApp.users             | ['users']                                                                                         |
| ABCCApp.dailyPrices       | []                                                                                                |
| ABCCApp.userDirects       | []                                                                                                |
| ABCCApp.userIncomeRecords | []                                                                                                |
| ABCCApp.isOperators       | []                                                                                                |
| ABCCApp.globalData        | []                                                                                                |
+---------------------------+---------------------------------------------------------------------------------------------------+
Function deposit(uint256,address)
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                                                          |
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
| number                    | []                                                                                                                                                    |
| referer                   | ['referer', 'this']                                                                                                                                   |
| user                      | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'number', 'params', 'partUSDT', 'payUSDT', 'referer', 'swapV3Router', 'this', 'user']          |
| totalUSDT                 | ['TUPLE_1', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                 |
| payUSDT                   | ['number', 'partUSDT']                                                                                                                                |
| params                    | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'number', 'partUSDT', 'payUSDT', 'this']                                                                   |
| fullDDDD                  | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'number', 'params', 'partUSDT', 'payUSDT', 'swapV3Router', 'this']                                         |
| ABCCApp.USDT              | ['USDT']                                                                                                                                              |
| ABCCApp.DDDD              | ['DDDD']                                                                                                                                              |
| ABCCApp.BNB               | ['BNB']                                                                                                                                               |
| ABCCApp.swapV3Router      | ['swapV3Router']                                                                                                                                      |
| ABCCApp.ddddBNBPool       | []                                                                                                                                                    |
| ABCCApp.bnbUSDTPool       | []                                                                                                                                                    |
| ABCCApp.vaultAddr         | []                                                                                                                                                    |
| ABCCApp.partUSDT          | ['partUSDT']                                                                                                                                          |
| ABCCApp.claimFee          | []                                                                                                                                                    |
| ABCCApp.isEnable          | ['isEnable']                                                                                                                                          |
| ABCCApp.DAY               | []                                                                                                                                                    |
| ABCCApp.Q96               | []                                                                                                                                                    |
| ABCCApp.fixedDay          | []                                                                                                                                                    |
| ABCCApp.REFERER_RATES     | []                                                                                                                                                    |
| ABCCApp.users             | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'number', 'params', 'partUSDT', 'payUSDT', 'referer', 'swapV3Router', 'this', 'user', 'users'] |
| ABCCApp.dailyPrices       | []                                                                                                                                                    |
| ABCCApp.userDirects       | ['userDirects']                                                                                                                                       |
| ABCCApp.userIncomeRecords | []                                                                                                                                                    |
| ABCCApp.isOperators       | []                                                                                                                                                    |
| ABCCApp.globalData        | ['BNB', 'DDDD', 'USDT', 'block.timestamp', 'fullDDDD', 'globalData', 'number', 'params', 'partUSDT', 'payUSDT', 'swapV3Router', 'this']               |
+---------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------+
Function claimDDDD()
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                                                           |
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
| user                      | ['TUPLE_2', 'block.timestamp', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'user', 'valueInUSDT']          |
| totalUSDT                 | ['TUPLE_2', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                  |
| staticUSDT                | ['TUPLE_2', 'dynamicUSDT', 'staticUSDT', 'totalUSDT']                                                                                                  |
| ddddPrice                 | ['valueInUSDT']                                                                                                                                        |
| ddddAmount                | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                                     |
| fee                       | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                                            |
| ABCCApp.USDT              | []                                                                                                                                                     |
| ABCCApp.DDDD              | ['DDDD']                                                                                                                                               |
| ABCCApp.BNB               | []                                                                                                                                                     |
| ABCCApp.swapV3Router      | []                                                                                                                                                     |
| ABCCApp.ddddBNBPool       | []                                                                                                                                                     |
| ABCCApp.bnbUSDTPool       | []                                                                                                                                                     |
| ABCCApp.vaultAddr         | ['vaultAddr']                                                                                                                                          |
| ABCCApp.partUSDT          | []                                                                                                                                                     |
| ABCCApp.claimFee          | ['claimFee']                                                                                                                                           |
| ABCCApp.isEnable          | []                                                                                                                                                     |
| ABCCApp.DAY               | []                                                                                                                                                     |
| ABCCApp.Q96               | []                                                                                                                                                     |
| ABCCApp.fixedDay          | []                                                                                                                                                     |
| ABCCApp.REFERER_RATES     | []                                                                                                                                                     |
| ABCCApp.users             | ['TUPLE_2', 'block.timestamp', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'staticUSDT', 'totalUSDT', 'user', 'users', 'valueInUSDT'] |
| ABCCApp.dailyPrices       | []                                                                                                                                                     |
| ABCCApp.userDirects       | []                                                                                                                                                     |
| ABCCApp.userIncomeRecords | []                                                                                                                                                     |
| ABCCApp.isOperators       | []                                                                                                                                                     |
| ABCCApp.globalData        | ['TUPLE_2', 'claimFee', 'ddddAmount', 'ddddPrice', 'dynamicUSDT', 'fee', 'globalData', 'staticUSDT', 'totalUSDT', 'valueInUSDT']                       |
+---------------------------+--------------------------------------------------------------------------------------------------------------------------------------------------------+
Function processReferers(address,address,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                             |
+---------------------------+----------------------------------------------------------------------------------------------------------+
| sender                    | ['msg.sender']                                                                                           |
| current                   | ['current', 'user']                                                                                      |
| amountUSDT                | ['staticUSDT']                                                                                           |
| keepUSDT                  | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'keepUSDT', 'staticUSDT', 'user']               |
| depth                     | ['depth']                                                                                                |
| user                      | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| incomeUSDT                | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| canUSDT                   | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user']                           |
| ABCCApp.USDT              | []                                                                                                       |
| ABCCApp.DDDD              | []                                                                                                       |
| ABCCApp.BNB               | []                                                                                                       |
| ABCCApp.swapV3Router      | []                                                                                                       |
| ABCCApp.ddddBNBPool       | []                                                                                                       |
| ABCCApp.bnbUSDTPool       | []                                                                                                       |
| ABCCApp.vaultAddr         | []                                                                                                       |
| ABCCApp.partUSDT          | []                                                                                                       |
| ABCCApp.claimFee          | []                                                                                                       |
| ABCCApp.isEnable          | []                                                                                                       |
| ABCCApp.DAY               | []                                                                                                       |
| ABCCApp.Q96               | []                                                                                                       |
| ABCCApp.fixedDay          | []                                                                                                       |
| ABCCApp.REFERER_RATES     | ['REFERER_RATES']                                                                                        |
| ABCCApp.users             | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'incomeUSDT', 'staticUSDT', 'user', 'users']                  |
| ABCCApp.dailyPrices       | []                                                                                                       |
| ABCCApp.userDirects       | []                                                                                                       |
| ABCCApp.userIncomeRecords | ['userIncomeRecords']                                                                                    |
| ABCCApp.isOperators       | []                                                                                                       |
| ABCCApp.globalData        | ['REFERER_RATES', 'amountUSDT', 'canUSDT', 'globalData', 'incomeUSDT', 'keepUSDT', 'staticUSDT', 'user'] |
+---------------------------+----------------------------------------------------------------------------------------------------------+
Function getUserDirects(address,uint256,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                                   |
+---------------------------+----------------------------------------------------------------------------------------------------------------+
| _user                     | []                                                                                                             |
| page                      | []                                                                                                             |
| pageSize                  | []                                                                                                             |
|                           | []                                                                                                             |
| referrals                 | ['referrals', 'userDirects']                                                                                   |
| len                       | ['referrals', 'userDirects']                                                                                   |
| start                     | ['len', 'page', 'pageSize', 'referrals', 'start', 'userDirects']                                               |
| end                       | ['end', 'len', 'page', 'pageSize', 'referrals', 'userDirects']                                                 |
| resultLen                 | ['end', 'len', 'page', 'pageSize', 'referrals', 'start', 'userDirects']                                        |
| result                    | ['end', 'len', 'page', 'pageSize', 'ref', 'referrals', 'result', 'resultLen', 'start', 'userDirects', 'users'] |
| i                         | ['i']                                                                                                          |
| ref                       | ['ref', 'referrals', 'userDirects']                                                                            |
| ABCCApp.USDT              | []                                                                                                             |
| ABCCApp.DDDD              | []                                                                                                             |
| ABCCApp.BNB               | []                                                                                                             |
| ABCCApp.swapV3Router      | []                                                                                                             |
| ABCCApp.ddddBNBPool       | []                                                                                                             |
| ABCCApp.bnbUSDTPool       | []                                                                                                             |
| ABCCApp.vaultAddr         | []                                                                                                             |
| ABCCApp.partUSDT          | []                                                                                                             |
| ABCCApp.claimFee          | []                                                                                                             |
| ABCCApp.isEnable          | []                                                                                                             |
| ABCCApp.DAY               | []                                                                                                             |
| ABCCApp.Q96               | []                                                                                                             |
| ABCCApp.fixedDay          | []                                                                                                             |
| ABCCApp.REFERER_RATES     | []                                                                                                             |
| ABCCApp.users             | ['users']                                                                                                      |
| ABCCApp.dailyPrices       | []                                                                                                             |
| ABCCApp.userDirects       | ['userDirects']                                                                                                |
| ABCCApp.userIncomeRecords | []                                                                                                             |
| ABCCApp.isOperators       | []                                                                                                             |
| ABCCApp.globalData        | []                                                                                                             |
+---------------------------+----------------------------------------------------------------------------------------------------------------+
Function getIncomeRecords(address,uint256,uint256)
+---------------------------+----------------------------------------------------------------------------------------------------+
| Variable                  | Dependencies                                                                                       |
+---------------------------+----------------------------------------------------------------------------------------------------+
| user                      | []                                                                                                 |
| page                      | []                                                                                                 |
| pageSize                  | []                                                                                                 |
|                           | []                                                                                                 |
| records                   | ['records', 'userIncomeRecords']                                                                   |
| len                       | ['records', 'userIncomeRecords']                                                                   |
| start                     | ['len', 'page', 'pageSize', 'records', 'start', 'userIncomeRecords']                               |
| end                       | ['end', 'len', 'page', 'pageSize', 'records', 'userIncomeRecords']                                 |
| resultLen                 | ['end', 'len', 'page', 'pageSize', 'records', 'start', 'userIncomeRecords']                        |
| result                    | ['end', 'len', 'page', 'pageSize', 'records', 'result', 'resultLen', 'start', 'userIncomeRecords'] |
| i                         | ['i']                                                                                              |
| ABCCApp.USDT              | []                                                                                                 |
| ABCCApp.DDDD              | []                                                                                                 |
| ABCCApp.BNB               | []                                                                                                 |
| ABCCApp.swapV3Router      | []                                                                                                 |
| ABCCApp.ddddBNBPool       | []                                                                                                 |
| ABCCApp.bnbUSDTPool       | []                                                                                                 |
| ABCCApp.vaultAddr         | []                                                                                                 |
| ABCCApp.partUSDT          | []                                                                                                 |
| ABCCApp.claimFee          | []                                                                                                 |
| ABCCApp.isEnable          | []                                                                                                 |
| ABCCApp.DAY               | []                                                                                                 |
| ABCCApp.Q96               | []                                                                                                 |
| ABCCApp.fixedDay          | []                                                                                                 |
| ABCCApp.REFERER_RATES     | []                                                                                                 |
| ABCCApp.users             | []                                                                                                 |
| ABCCApp.dailyPrices       | []                                                                                                 |
| ABCCApp.userDirects       | []                                                                                                 |
| ABCCApp.userIncomeRecords | ['userIncomeRecords']                                                                              |
| ABCCApp.isOperators       | []                                                                                                 |
| ABCCApp.globalData        | []                                                                                                 |
+---------------------------+----------------------------------------------------------------------------------------------------+
Function setSettlePrice(uint256,uint256)
+---------------------------+-----------------------------------------+
| Variable                  | Dependencies                            |
+---------------------------+-----------------------------------------+
| price                     | ['price', 'valueInUSDT']                |
| targetTime                | ['block.timestamp', 'targetTime']       |
| ABCCApp.USDT              | []                                      |
| ABCCApp.DDDD              | []                                      |
| ABCCApp.BNB               | []                                      |
| ABCCApp.swapV3Router      | []                                      |
| ABCCApp.ddddBNBPool       | []                                      |
| ABCCApp.bnbUSDTPool       | []                                      |
| ABCCApp.vaultAddr         | []                                      |
| ABCCApp.partUSDT          | []                                      |
| ABCCApp.claimFee          | []                                      |
| ABCCApp.isEnable          | []                                      |
| ABCCApp.DAY               | ['DAY']                                 |
| ABCCApp.Q96               | []                                      |
| ABCCApp.fixedDay          | []                                      |
| ABCCApp.REFERER_RATES     | []                                      |
| ABCCApp.users             | []                                      |
| ABCCApp.dailyPrices       | ['dailyPrices', 'price', 'valueInUSDT'] |
| ABCCApp.userDirects       | []                                      |
| ABCCApp.userIncomeRecords | []                                      |
| ABCCApp.isOperators       | []                                      |
| ABCCApp.globalData        | []                                      |
+---------------------------+-----------------------------------------+
Function setLevelRate(uint256,uint256)
+---------------------------+----------------------------+
| Variable                  | Dependencies               |
+---------------------------+----------------------------+
| index                     | []                         |
| value                     | []                         |
| ABCCApp.USDT              | []                         |
| ABCCApp.DDDD              | []                         |
| ABCCApp.BNB               | []                         |
| ABCCApp.swapV3Router      | []                         |
| ABCCApp.ddddBNBPool       | []                         |
| ABCCApp.bnbUSDTPool       | []                         |
| ABCCApp.vaultAddr         | []                         |
| ABCCApp.partUSDT          | []                         |
| ABCCApp.claimFee          | []                         |
| ABCCApp.isEnable          | []                         |
| ABCCApp.DAY               | []                         |
| ABCCApp.Q96               | []                         |
| ABCCApp.fixedDay          | []                         |
| ABCCApp.REFERER_RATES     | ['REFERER_RATES', 'value'] |
| ABCCApp.users             | []                         |
| ABCCApp.dailyPrices       | []                         |
| ABCCApp.userDirects       | []                         |
| ABCCApp.userIncomeRecords | []                         |
| ABCCApp.isOperators       | []                         |
| ABCCApp.globalData        | []                         |
+---------------------------+----------------------------+
Function setClaimFee(uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | ['target']   |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function setUserRemainingUSDT(address,uint256)
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| target                    | []           |
| value                     | []           |
| old                       | ['users']    |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | ['users']    |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function getFixedDay()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
|                           | []           |
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | ['DAY']      |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | ['fixedDay'] |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function addFixedDay(uint256)
+---------------------------+------------------------+
| Variable                  | Dependencies           |
+---------------------------+------------------------+
| target                    | []                     |
| ABCCApp.USDT              | []                     |
| ABCCApp.DDDD              | []                     |
| ABCCApp.BNB               | []                     |
| ABCCApp.swapV3Router      | []                     |
| ABCCApp.ddddBNBPool       | []                     |
| ABCCApp.bnbUSDTPool       | []                     |
| ABCCApp.vaultAddr         | []                     |
| ABCCApp.partUSDT          | []                     |
| ABCCApp.claimFee          | []                     |
| ABCCApp.isEnable          | []                     |
| ABCCApp.DAY               | []                     |
| ABCCApp.Q96               | []                     |
| ABCCApp.fixedDay          | ['fixedDay', 'target'] |
| ABCCApp.REFERER_RATES     | []                     |
| ABCCApp.users             | []                     |
| ABCCApp.dailyPrices       | []                     |
| ABCCApp.userDirects       | []                     |
| ABCCApp.userIncomeRecords | []                     |
| ABCCApp.isOperators       | []                     |
| ABCCApp.globalData        | []                     |
+---------------------------+------------------------+
Function getDDDDValueInUSDT(uint256)
+---------------------------+----------------------------------------------------------+
| Variable                  | Dependencies                                             |
+---------------------------+----------------------------------------------------------+
| amount                    | []                                                       |
|                           | []                                                       |
| tokenPriceInBNB           | ['price']                                                |
| bnbPriceInUSDT            | ['price']                                                |
| valueInUSDT               | ['amount', 'bnbPriceInUSDT', 'price', 'tokenPriceInBNB'] |
| ABCCApp.USDT              | []                                                       |
| ABCCApp.DDDD              | []                                                       |
| ABCCApp.BNB               | []                                                       |
| ABCCApp.swapV3Router      | []                                                       |
| ABCCApp.ddddBNBPool       | []                                                       |
| ABCCApp.bnbUSDTPool       | []                                                       |
| ABCCApp.vaultAddr         | []                                                       |
| ABCCApp.partUSDT          | []                                                       |
| ABCCApp.claimFee          | []                                                       |
| ABCCApp.isEnable          | []                                                       |
| ABCCApp.DAY               | []                                                       |
| ABCCApp.Q96               | []                                                       |
| ABCCApp.fixedDay          | []                                                       |
| ABCCApp.REFERER_RATES     | []                                                       |
| ABCCApp.users             | []                                                       |
| ABCCApp.dailyPrices       | []                                                       |
| ABCCApp.userDirects       | []                                                       |
| ABCCApp.userIncomeRecords | []                                                       |
| ABCCApp.isOperators       | []                                                       |
| ABCCApp.globalData        | []                                                       |
+---------------------------+----------------------------------------------------------+
Function getTokenPriceInBNB()
+---------------------------+----------------------------------------------------------------------------+
| Variable                  | Dependencies                                                               |
+---------------------------+----------------------------------------------------------------------------+
|                           | []                                                                         |
| tokenBnbPool              | ['ddddBNBPool']                                                            |
| sqrtPriceX96              | ['TUPLE_3', 'ddddBNBPool', 'tokenBnbPool']                                 |
| isToken0                  | ['DDDD', 'ddddBNBPool', 'tokenBnbPool']                                    |
| price                     | ['Q96', 'TUPLE_3', 'ddddBNBPool', 'price', 'sqrtPriceX96', 'tokenBnbPool'] |
| ABCCApp.USDT              | []                                                                         |
| ABCCApp.DDDD              | ['DDDD']                                                                   |
| ABCCApp.BNB               | []                                                                         |
| ABCCApp.swapV3Router      | []                                                                         |
| ABCCApp.ddddBNBPool       | ['ddddBNBPool']                                                            |
| ABCCApp.bnbUSDTPool       | []                                                                         |
| ABCCApp.vaultAddr         | []                                                                         |
| ABCCApp.partUSDT          | []                                                                         |
| ABCCApp.claimFee          | []                                                                         |
| ABCCApp.isEnable          | []                                                                         |
| ABCCApp.DAY               | []                                                                         |
| ABCCApp.Q96               | ['Q96']                                                                    |
| ABCCApp.fixedDay          | []                                                                         |
| ABCCApp.REFERER_RATES     | []                                                                         |
| ABCCApp.users             | []                                                                         |
| ABCCApp.dailyPrices       | []                                                                         |
| ABCCApp.userDirects       | []                                                                         |
| ABCCApp.userIncomeRecords | []                                                                         |
| ABCCApp.isOperators       | []                                                                         |
| ABCCApp.globalData        | []                                                                         |
+---------------------------+----------------------------------------------------------------------------+
Function getBNBPriceInUSDT()
+---------------------------+---------------------------------------------------------------------------+
| Variable                  | Dependencies                                                              |
+---------------------------+---------------------------------------------------------------------------+
|                           | []                                                                        |
| bnbUsdtPool               | ['bnbUSDTPool']                                                           |
| sqrtPriceX96              | ['TUPLE_4', 'bnbUSDTPool', 'bnbUsdtPool']                                 |
| isBNBToken0               | ['BNB', 'bnbUSDTPool', 'bnbUsdtPool']                                     |
| price                     | ['Q96', 'TUPLE_4', 'bnbUSDTPool', 'bnbUsdtPool', 'price', 'sqrtPriceX96'] |
| ABCCApp.USDT              | []                                                                        |
| ABCCApp.DDDD              | []                                                                        |
| ABCCApp.BNB               | ['BNB']                                                                   |
| ABCCApp.swapV3Router      | []                                                                        |
| ABCCApp.ddddBNBPool       | []                                                                        |
| ABCCApp.bnbUSDTPool       | ['bnbUSDTPool']                                                           |
| ABCCApp.vaultAddr         | []                                                                        |
| ABCCApp.partUSDT          | []                                                                        |
| ABCCApp.claimFee          | []                                                                        |
| ABCCApp.isEnable          | []                                                                        |
| ABCCApp.DAY               | []                                                                        |
| ABCCApp.Q96               | ['Q96']                                                                   |
| ABCCApp.fixedDay          | []                                                                        |
| ABCCApp.REFERER_RATES     | []                                                                        |
| ABCCApp.users             | []                                                                        |
| ABCCApp.dailyPrices       | []                                                                        |
| ABCCApp.userDirects       | []                                                                        |
| ABCCApp.userIncomeRecords | []                                                                        |
| ABCCApp.isOperators       | []                                                                        |
| ABCCApp.globalData        | []                                                                        |
+---------------------------+---------------------------------------------------------------------------+
Function emergencyFixed(address,address)
+---------------------------+----------------------------+
| Variable                  | Dependencies               |
+---------------------------+----------------------------+
| targetContract            | []                         |
| recipient                 | []                         |
| balance                   | ['targetContract', 'this'] |
| ABCCApp.USDT              | []                         |
| ABCCApp.DDDD              | []                         |
| ABCCApp.BNB               | []                         |
| ABCCApp.swapV3Router      | []                         |
| ABCCApp.ddddBNBPool       | []                         |
| ABCCApp.bnbUSDTPool       | []                         |
| ABCCApp.vaultAddr         | []                         |
| ABCCApp.partUSDT          | []                         |
| ABCCApp.claimFee          | []                         |
| ABCCApp.isEnable          | []                         |
| ABCCApp.DAY               | []                         |
| ABCCApp.Q96               | []                         |
| ABCCApp.fixedDay          | []                         |
| ABCCApp.REFERER_RATES     | []                         |
| ABCCApp.users             | []                         |
| ABCCApp.dailyPrices       | []                         |
| ABCCApp.userDirects       | []                         |
| ABCCApp.userIncomeRecords | []                         |
| ABCCApp.isOperators       | []                         |
| ABCCApp.globalData        | []                         |
+---------------------------+----------------------------+
Function slitherConstructorVariables()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function slitherConstructorConstantVariables()
+---------------------------+--------------+
| Variable                  | Dependencies |
+---------------------------+--------------+
| ABCCApp.USDT              | []           |
| ABCCApp.DDDD              | []           |
| ABCCApp.BNB               | []           |
| ABCCApp.swapV3Router      | []           |
| ABCCApp.ddddBNBPool       | []           |
| ABCCApp.bnbUSDTPool       | []           |
| ABCCApp.vaultAddr         | []           |
| ABCCApp.partUSDT          | []           |
| ABCCApp.claimFee          | []           |
| ABCCApp.isEnable          | []           |
| ABCCApp.DAY               | []           |
| ABCCApp.Q96               | []           |
| ABCCApp.fixedDay          | []           |
| ABCCApp.REFERER_RATES     | []           |
| ABCCApp.users             | []           |
| ABCCApp.dailyPrices       | []           |
| ABCCApp.userDirects       | []           |
| ABCCApp.userIncomeRecords | []           |
| ABCCApp.isOperators       | []           |
| ABCCApp.globalData        | []           |
+---------------------------+--------------+
Function isOperator()
+---------------------------+-----------------+
| Variable                  | Dependencies    |
+---------------------------+-----------------+
| ABCCApp.USDT              | []              |
| ABCCApp.DDDD              | []              |
| ABCCApp.BNB               | []              |
| ABCCApp.swapV3Router      | []              |
| ABCCApp.ddddBNBPool       | []              |
| ABCCApp.bnbUSDTPool       | []              |
| ABCCApp.vaultAddr         | []              |
| ABCCApp.partUSDT          | []              |
| ABCCApp.claimFee          | []              |
| ABCCApp.isEnable          | []              |
| ABCCApp.DAY               | []              |
| ABCCApp.Q96               | []              |
| ABCCApp.fixedDay          | []              |
| ABCCApp.REFERER_RATES     | []              |
| ABCCApp.users             | []              |
| ABCCApp.dailyPrices       | []              |
| ABCCApp.userDirects       | []              |
| ABCCApp.userIncomeRecords | []              |
| ABCCApp.isOperators       | ['isOperators'] |
| ABCCApp.globalData        | []              |
+---------------------------+-----------------+
Contract Ownable
+----------+------------------------------------------------------+
| Variable | Dependencies                                         |
+----------+------------------------------------------------------+
| _owner   | ['_owner', 'initialOwner', 'msg.sender', 'newOwner'] |
+----------+------------------------------------------------------+

Function constructor(address)
+----------------+----------------+
| Variable       | Dependencies   |
+----------------+----------------+
| initialOwner   | ['msg.sender'] |
| Ownable._owner | []             |
+----------------+----------------+
Function owner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
|                | []           |
| Ownable._owner | ['_owner']   |
+----------------+--------------+
Function _checkOwner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
Function renounceOwnership()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
Function transferOwnership(address)
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| newOwner       | []           |
| Ownable._owner | []           |
+----------------+--------------+
Function _transferOwnership(address)
+----------------+----------------------------------------+
| Variable       | Dependencies                           |
+----------------+----------------------------------------+
| newOwner       | ['initialOwner', 'newOwner']           |
| oldOwner       | ['_owner', 'initialOwner', 'newOwner'] |
| Ownable._owner | ['_owner', 'initialOwner', 'newOwner'] |
+----------------+----------------------------------------+
Function onlyOwner()
+----------------+--------------+
| Variable       | Dependencies |
+----------------+--------------+
| Ownable._owner | []           |
+----------------+--------------+
Contract IERC20
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
+----------+--------------+

Function totalSupply()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function balanceOf(address)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| account  | []           |
|          | []           |
+----------+--------------+
Function transfer(address,uint256)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| to       | []           |
| value    | []           |
|          | []           |
+----------+--------------+
Function allowance(address,address)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| owner    | []           |
| spender  | []           |
|          | []           |
+----------+--------------+
Function approve(address,uint256)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| spender  | []           |
| value    | []           |
|          | []           |
+----------+--------------+
Function transferFrom(address,address,uint256)
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
| from     | []           |
| to       | []           |
| value    | []           |
|          | []           |
+----------+--------------+
Contract Context
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
+----------+--------------+

Function _msgSender()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function _msgData()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
Function _contextSuffixLength()
+----------+--------------+
| Variable | Dependencies |
+----------+--------------+
|          | []           |
+----------+--------------+
INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
