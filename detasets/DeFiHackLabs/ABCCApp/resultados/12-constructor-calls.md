# constructor-calls
```
'solc --version' running
'solc @openzeppelin/contracts=node_modules/@openzeppelin/contracts contracts/ABCCApp.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --via-ir --optimize --allow-paths .,/home/mat/poc1novo/poc-tcc/detasets/DeFiHackLabs/ABCCApp/contracts' running
INFO:Printers:
#######################
####### ABCCApp #######
#######################

## Constructor Call Sequence
	- Ownable
	- ABCCApp

## Constructor Definitions

### Ownable

     constructor(address initialOwner) {
        if (initialOwner == address(0)) {
            revert OwnableInvalidOwner(address(0));
        }
        _transferOwnership(initialOwner);
    }

### ABCCApp

     constructor() Ownable(msg.sender) {
        isOperators[msg.sender] = true;
    }

INFO:Slither:contracts/ABCCApp.sol analyzed (5 contracts)
```
