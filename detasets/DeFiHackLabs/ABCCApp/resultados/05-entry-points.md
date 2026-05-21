## entry-points
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:

Contract [1m[93mABCCApp[0m is Ownable is Context (contracts/ABCCApp.sol#73-880)
+-------------------+----------------------------------------------+----------------+
| Variables         | Types                                        | Inherited From |
+-------------------+----------------------------------------------+----------------+
| [1m[94m_owner[0m            | [92maddress[0m                                      | [95mOwnable[0m        |
| [1m[94mvaultAddr[0m         | [92maddress[0m                                      |                |
| [1m[94mpartUSDT[0m          | [92muint256[0m                                      |                |
| [1m[94mclaimFee[0m          | [92muint256[0m                                      |                |
| [1m[94misEnable[0m          | [92mbool[0m                                         |                |
| [1m[94mfixedDay[0m          | [92muint256[0m                                      |                |
| [1m[94mREFERER_RATES[0m     | [92muint256[][0m                                    |                |
| [1m[94musers[0m             | [92mmapping(address => ABCCApp.User)[0m             |                |
| [1m[94mdailyPrices[0m       | [92mmapping(uint256 => uint256)[0m                  |                |
| [1m[94muserDirects[0m       | [92mmapping(address => ABCCApp.DirectReferral[])[0m |                |
| [1m[94muserIncomeRecords[0m | [92mmapping(address => ABCCApp.IncomeRecord[])[0m   |                |
| [1m[94misOperators[0m       | [92mmapping(address => bool)[0m                     |                |
| [1m[94mglobalData[0m        | [92mABCCApp.GlobalData[0m                           |                |
+-------------------+----------------------------------------------+----------------+
+---------------------------------------+-----------+----------------+
| Functions                             | Modifiers | Inherited From |
+---------------------------------------+-----------+----------------+
| [1m[95mconstructor[0m()                         |           |                |
| [1m[91msetPartUSDT[0m(uint256)                  | [92monlyOwner[0m |                |
| [1m[91msetOperator[0m(address,bool)             | [92monlyOwner[0m |                |
| [1m[91msetVaultAddr[0m(address)                 | [92monlyOwner[0m |                |
| [1m[91msetEnable[0m(bool)                       | [92monlyOwner[0m |                |
| [1m[91mdeposit[0m(uint256,address)              |           |                |
| [1m[91mclaimDDDD[0m()                           |           |                |
| [1m[91msetSettlePrice[0m(uint256,uint256)       | [92monlyOwner[0m |                |
| [1m[91msetLevelRate[0m(uint256,uint256)         | [92monlyOwner[0m |                |
| [1m[91msetClaimFee[0m(uint256)                  | [92monlyOwner[0m |                |
| [1m[91msetUserRemainingUSDT[0m(address,uint256) | [92monlyOwner[0m |                |
| [1m[91maddFixedDay[0m(uint256)                  |           |                |
| [1m[91memergencyFixed[0m(address,address)       | [92monlyOwner[0m |                |
| [1m[91mrenounceOwnership[0m()                   | [92monlyOwner[0m | [95mOwnable[0m        |
| [1m[91mtransferOwnership[0m(address)            | [92monlyOwner[0m | [95mOwnable[0m        |
+---------------------------------------+-----------+----------------+
INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
