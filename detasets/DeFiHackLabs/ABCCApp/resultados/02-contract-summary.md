## contract-summary
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
+ Contract IUniswapV3 (Most derived contract)
  - From IUniswapV3
    - exactInput(IUniswapV3.ExactInputParams) (external)
    - exactInputSingle(IUniswapV3.ExactInputSingleParams) (external)
    - slot0() (external)
    - token0() (external)
    - token1() (external)

+ Contract ABCCApp (Most derived contract)
  - From Ownable
    - _checkOwner() (internal)
    - _transferOwnership(address) (internal)
    - constructor(address) (internal)
    - owner() (public)
    - renounceOwnership() (public)
    - transferOwnership(address) (public)
  - From Context
    - _contextSuffixLength() (internal)
    - _msgData() (internal)
    - _msgSender() (internal)
  - From ABCCApp
    - addFixedDay(uint256) (public)
    - claimDDDD() (external)
    - constructor() (public)
    - dashboard(address) (public)
    - deposit(uint256,address) (external)
    - emergencyFixed(address,address) (public)
    - getBNBPriceInUSDT() (public)
    - getCanClaimUSDT(address) (public)
    - getDDDDValueInUSDT(uint256) (public)
    - getFixedDay() (public)
    - getIncomeRecords(address,uint256,uint256) (external)
    - getTokenPriceInBNB() (public)
    - getUserDirects(address,uint256,uint256) (external)
    - processReferers(address,address,uint256) (internal)
    - setClaimFee(uint256) (public)
    - setEnable(bool) (public)
    - setLevelRate(uint256,uint256) (public)
    - setOperator(address,bool) (public)
    - setPartUSDT(uint256) (public)
    - setSettlePrice(uint256,uint256) (public)
    - setUserRemainingUSDT(address,uint256) (public)
    - setVaultAddr(address) (public)

+ Contract Ownable
  - From Context
    - _contextSuffixLength() (internal)
    - _msgData() (internal)
    - _msgSender() (internal)
  - From Ownable
    - _checkOwner() (internal)
    - _transferOwnership(address) (internal)
    - constructor(address) (internal)
    - owner() (public)
    - renounceOwnership() (public)
    - transferOwnership(address) (public)

+ Contract IERC20 (Most derived contract)
  - From IERC20
    - allowance(address,address) (external)
    - approve(address,uint256) (external)
    - balanceOf(address) (external)
    - totalSupply() (external)
    - transfer(address,uint256) (external)
    - transferFrom(address,address,uint256) (external)

+ Contract Context
  - From Context
    - _contextSuffixLength() (internal)
    - _msgData() (internal)
    - _msgSender() (internal)

INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
