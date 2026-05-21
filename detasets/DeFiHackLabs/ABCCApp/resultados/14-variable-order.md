# variable-order
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
IUniswapV3:
+------+------+------+--------+-------+
| Name | Type | Slot | Offset | State |
+------+------+------+--------+-------+
+------+------+------+--------+-------+

ABCCApp:
+---------------------------+----------------------------------------------+------+--------+---------+
| Name                      | Type                                         | Slot | Offset | State   |
+---------------------------+----------------------------------------------+------+--------+---------+
| Ownable._owner            | address                                      | 0    | 0      | Storage |
| ABCCApp.vaultAddr         | address                                      | 1    | 0      | Storage |
| ABCCApp.partUSDT          | uint256                                      | 2    | 0      | Storage |
| ABCCApp.claimFee          | uint256                                      | 3    | 0      | Storage |
| ABCCApp.isEnable          | bool                                         | 4    | 0      | Storage |
| ABCCApp.fixedDay          | uint256                                      | 5    | 0      | Storage |
| ABCCApp.REFERER_RATES     | uint256[]                                    | 6    | 0      | Storage |
| ABCCApp.users             | mapping(address => ABCCApp.User)             | 7    | 0      | Storage |
| ABCCApp.dailyPrices       | mapping(uint256 => uint256)                  | 8    | 0      | Storage |
| ABCCApp.userDirects       | mapping(address => ABCCApp.DirectReferral[]) | 9    | 0      | Storage |
| ABCCApp.userIncomeRecords | mapping(address => ABCCApp.IncomeRecord[])   | 10   | 0      | Storage |
| ABCCApp.isOperators       | mapping(address => bool)                     | 11   | 0      | Storage |
| ABCCApp.globalData        | ABCCApp.GlobalData                           | 12   | 0      | Storage |
+---------------------------+----------------------------------------------+------+--------+---------+

IERC20:
+------+------+------+--------+-------+
| Name | Type | Slot | Offset | State |
+------+------+------+--------+-------+
+------+------+------+--------+-------+

INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
