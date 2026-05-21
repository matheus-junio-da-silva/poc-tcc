# function-id
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
IUniswapV3:
+------------------------------------------------------------------------------------+------------+
| Name                                                                               | ID         |
+------------------------------------------------------------------------------------+------------+
| exactInputSingle((address,address,uint24,address,uint256,uint256,uint256,uint160)) | 0x414bf389 |
| exactInput((bytes,address,uint256,uint256,uint256))                                | 0xc04b8d59 |
| slot0()                                                                            | 0x3850c7bd |
| token0()                                                                           | 0x0dfe1681 |
| token1()                                                                           | 0xd21220a7 |
+------------------------------------------------------------------------------------+------------+

ABCCApp:
+-------------------------------------------+------------+
| Name                                      | ID         |
+-------------------------------------------+------------+
| owner()                                   | 0x8da5cb5b |
| renounceOwnership()                       | 0x715018a6 |
| transferOwnership(address)                | 0xf2fde38b |
| constructor()                             | 0x90fa17bb |
| dashboard(address)                        | 0xb8b92f50 |
| setPartUSDT(uint256)                      | 0x02e5bff8 |
| setOperator(address,bool)                 | 0x558a7297 |
| setVaultAddr(address)                     | 0xe5a4afd1 |
| setEnable(bool)                           | 0x7726bed3 |
| getCanClaimUSDT(address)                  | 0x9789ce27 |
| deposit(uint256,address)                  | 0x6e553f65 |
| claimDDDD()                               | 0x2a9ff421 |
| getUserDirects(address,uint256,uint256)   | 0x5a35ce4d |
| getIncomeRecords(address,uint256,uint256) | 0xed0acd84 |
| setSettlePrice(uint256,uint256)           | 0x74a2c5b2 |
| setLevelRate(uint256,uint256)             | 0x1ab10037 |
| setClaimFee(uint256)                      | 0x2e75ab50 |
| setUserRemainingUSDT(address,uint256)     | 0x487ca881 |
| getFixedDay()                             | 0x93fd2b12 |
| addFixedDay(uint256)                      | 0x3b1126c9 |
| getDDDDValueInUSDT(uint256)               | 0x48e33317 |
| getTokenPriceInBNB()                      | 0x25164809 |
| getBNBPriceInUSDT()                       | 0x456e08e2 |
| emergencyFixed(address,address)           | 0xfb78ccb9 |
| USDT()                                    | 0xc54e44eb |
| DDDD()                                    | 0xd3ee815f |
| BNB()                                     | 0x58f7f6d2 |
| swapV3Router()                            | 0x6c242545 |
| vaultAddr()                               | 0xd27567f2 |
| partUSDT()                                | 0x46957b27 |
| claimFee()                                | 0x99d32fc4 |
| isEnable()                                | 0x4bb77d68 |
| fixedDay()                                | 0x88c336cd |
| REFERER_RATES(uint256)                    | 0x245ceeac |
| users(address)                            | 0xa87430ba |
| dailyPrices(uint256)                      | 0xdfd9eacd |
| userDirects(address,uint256)              | 0x99f0a5e8 |
| userIncomeRecords(address,uint256)        | 0x79578232 |
| isOperators(address)                      | 0xee0fb4eb |
| globalData()                              | 0x613ce410 |
+-------------------------------------------+------------+

IERC20:
+---------------------------------------+------------+
| Name                                  | ID         |
+---------------------------------------+------------+
| totalSupply()                         | 0x18160ddd |
| balanceOf(address)                    | 0x70a08231 |
| transfer(address,uint256)             | 0xa9059cbb |
| allowance(address,address)            | 0xdd62ed3e |
| approve(address,uint256)              | 0x095ea7b3 |
| transferFrom(address,address,uint256) | 0x23b872dd |
+---------------------------------------+------------+

INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
