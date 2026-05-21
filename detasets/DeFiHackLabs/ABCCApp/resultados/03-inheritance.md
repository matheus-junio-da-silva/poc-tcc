## inheritance
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:Inheritance
Child_Contract -> Immediate_Base_Contracts [Not_Immediate_Base_Contracts]
+ IUniswapV3

+ ABCCApp
 -> Ownable
, [Context]

+ Ownable
 -> Context

+ IERC20

+ Context


Base_Contract -> Immediate_Child_Contracts
 [Not_Immediate_Child_Contracts]

+ IUniswapV3

+ ABCCApp

+ Ownable
 -> ABCCApp

+ IERC20

+ Context
 -> Ownable
, [ABCCApp]

INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
