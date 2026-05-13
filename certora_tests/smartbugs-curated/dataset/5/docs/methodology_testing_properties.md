# Methodology for Testing Properties - Missing (incorrect_constructor_name3)

## 1. Overview

This document details testing CVL properties for the Missing contract with generic constructor name vulnerability.

---

## 2. Artifacts Created

### 2.1 Solidity Contract Files

#### File: `contracts/incorrect_constructor_name3.sol`
**Why Created**: Modernized from Solidity ^0.4.24 to ^0.8.0 while **preserving the vulnerability**.

**Key Changes Made**:
- Updated pragma: `pragma solidity ^0.8.0;`
- Kept generic function name: `Constructor()` (incorrect, should be constructor)
- In Solidity 0.4.x, this is a regular function, not the special constructor
- **Vulnerability preserved**: `Constructor()` can be called by anyone anytime

**Result**: Compiles with solc 0.8.3+ but vulnerability remains.

#### File: `fixed_contracts/incorrect_constructor_name3.sol`
**Why Created**: Corrected version with proper constructor keyword.

**Key Changes Applied**:
- Changed `function Constructor()` → `constructor()`
- Owner correctly set once at deployment
- Generic name `Constructor()` removed

**Result**: Properties should **pass** on this version.

### 2.2 CVL Specification Files

#### File: `specs/incorrect_constructor_name3.spec`
**Why Created**: Defines 6 formal properties targeting the generic constructor name vulnerability.

**Properties Defined** (6 total):
1. `ownerInitializedOnlyAtDeployment` - Owner set once at deploy
2. `onlyLegitimateOwnerCanWithdraw` - Only owner withdraws
3. `constructorFunctionIsNotCallable` - Constructor() cannot be called
4. `ownerIsNeverZero` (invariant) - Owner always initialized
5. `functionNamingIsSignificant` - Naming matters for constructors
6. `ownershipTransferIsControlled` - Owner cannot be reassigned

### 2.3 Certora Configuration Files

#### Files: `Missing_vulnerable.conf`, `Missing_fixed.conf`
**Why Created**: Configuration for Certora verification.

**Configuration Content**:
```json
{
    "files": ["contracts/incorrect_constructor_name3.sol"],
    "verify": "Missing:specs/incorrect_constructor_name3.spec",
    "optimistic_loop": true,
    "loop_iter": "3",
    "rule_sanity": "basic",
    "msg": "Access Control Verification - Missing Vulnerable Contract",
    "prover_version": "master"
}
```

---

## 3. The Vulnerability Explained

### Original Code (Solidity 0.4.24)
```solidity
contract Missing {
    address public owner;
    
    function Constructor() public {  // WRONG! Generic name, not contract-specific
        owner = msg.sender;
    }
    
    function withdraw() public {
        require(msg.sender == owner);
        msg.sender.transfer(this.balance);
    }
}
```

### Why It's Vulnerable
- In Solidity 0.4.x, constructors must match contract name
- `Constructor()` is a generic name, not contract-specific
- This is a regular function, not recognized as constructor
- Can be called multiple times by anyone
- Each caller can become the owner

### Constructor Naming Rules

**Solidity 0.4.x**:
```
contract MyContract {
    function MyContract() { }  ← Correct, executed once at deployment
    function Constructor() { } ← WRONG, just a regular function
    function mycontract() { }  ← WRONG, case must match exactly
}
```

**Solidity 0.8.x**:
```
contract MyContract {
    constructor() { }  ← Correct, keyword-based (case doesn't matter)
    function Constructor() { } ← Now just a regular function
}
```

### The Fix
```solidity
contract Missing {
    address public owner;
    
    constructor() public {  // CORRECT keyword-based constructor
        owner = msg.sender;
    }
    
    function withdraw() public {
        require(msg.sender == owner);
        (bool sent,) = msg.sender.call{value: address(this).balance}("");
        require(sent);
    }
}
```

---

## 4. Commands Executed

### Run Vulnerable Contract
```bash
cd /home/mat/poc1novo/poc-tcc/certora_tests/smartbugs-curated/dataset/5
certoraRun Missing_vulnerable.conf --disable_local_typechecking
```

### Run Fixed Contract
```bash
certoraRun Missing_fixed.conf --disable_local_typechecking
```

---

## 5. Expected Results

**Vulnerable Contract**:
- Properties FAIL ❌
- Counterexample: Non-deployer calls `Constructor()` and becomes owner
- Demonstrates function naming issue

**Fixed Contract**:
- Properties PASS ✅
- Constructor executes exactly once at deployment
- Owner cannot be changed by calling a function

---

## 6. Files Location

```
dataset/5/
├── contracts/incorrect_constructor_name3.sol (vulnerable)
├── fixed_contracts/incorrect_constructor_name3.sol (fixed)
├── specs/incorrect_constructor_name3.spec (6 properties)
├── docs/
│   ├── methodology_creating_properties.md
│   └── methodology_testing_properties.md (this file)
├── Missing_vulnerable.conf
└── Missing_fixed.conf
```

---

**Document Version**: 1.0  
**Created**: May 12, 2026  
**Status**: Complete
