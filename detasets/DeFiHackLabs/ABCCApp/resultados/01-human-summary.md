## human-summary
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
Compiled with solc
Total number of contracts in source files: 5
Source lines of code (SLOC) in source files: 418
Number of  assembly lines: 0
Number of optimization issues: 0
Number of informational issues: 12
Number of low issues: 10
Number of medium issues: 11
Number of high issues: 4
ERCs: ERC20

+------------+-------------+-------+--------------------+--------------+--------------------+
| Name       | # functions | ERCS  | ERC20 info         | Complex code | Features           |
+------------+-------------+-------+--------------------+--------------+--------------------+
| IUniswapV3 | 5           |       |                    | No           | Receive ETH        |
| ABCCApp    | 33          |       |                    | No           | Tokens interaction |
| IERC20     | 6           | ERC20 | No Minting         | No           |                    |
|            |             |       | Approve Race Cond. |              |                    |
|            |             |       |                    |              |                    |
+------------+-------------+-------+--------------------+--------------+--------------------+
INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
