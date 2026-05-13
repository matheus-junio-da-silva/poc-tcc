# Methodology for Testing Properties - Missing (incorrect_constructor_name2)

## 1. Overview

This document details testing CVL properties for the Missing contract with case-sensitivity vulnerability.

---

## 2. Artifacts Created

### 2.1 Solidity Contract Files

#### File: `contracts/incorrect_constructor_name2.sol`
**Why Created**: Modernized from Solidity ^0.4.24 to ^0.8.0 while **preserving the vulnerability**.

**Key Changes Made**:
- Updated pragma: `pragma solidity ^0.8.0;`
- Kept lowercase function name: `missing()` (incorrect, should be constructor)
- In Solidity 0.4.x, constructors are case-sensitive
- **Vulnerability preserved**: `missing()` is a regular function, exploitable

**Result**: Compiles with solc 0.8.3+ but vulnerability remains.

#### File: `fixed_contracts/incorrect_constructor_name2.sol`
**Why Created**: Corrected version with proper constructor.

**Key Changes Applied**:
- Changed `function missing()` → `constructor()`
- Owner correctly set during deployment
- Case sensitivity is now irrelevant (keyword is lowercase `constructor`)

**Result**: Properties should **pass** on this version.

### 2.2 CVL Specification Files

#### File: `specs/incorrect_constructor_name2.spec`
**Why Created**: Defines 6 formal properties targeting the case-sensitivity vulnerability.

**Properties Defined** (6 total):
1. `ownerInitializedOnlyAtDeployment` - Owner initialized once
2. `onlyLegitimateOwnerCanWithdraw` - Only owner withdraws
3. `missingFunctionIsProtected` - missing() is not callable
4. `ownerIsNeverUninitialized` (invariant) - Owner always set
5. `ownershipCantBeReassignedFreely` - Owner cannot be changed
6. `caseMattersForConstructor` - Case sensitivity demonstrated

### 2.3 Certora Configuration Files

#### Files: `Missing_vulnerable.conf`, `Missing_fixed.conf`
**Why Created**: Configuration for Certora verification.

**Configuration Content**:
```json
{
    "files": ["contracts/incorrect_constructor_name2.sol"],
    "verify": "Missing:specs/incorrect_constructor_name2.spec",
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
    
    function missing() public {  // lowercase! Should be Missing() or constructor()
        owner = msg.sender;
    }
    
    function withdraw() public {
        require(msg.sender == owner);
        msg.sender.transfer(this.balance);
    }
}
```

### Why It's Vulnerable
- In Solidity 0.4.x, constructors must match contract name exactly (case-sensitive)
- `missing()` (lowercase) is NOT the constructor
- `missing()` is a regular function that can be called anytime
- Anyone can call `missing()` to become owner

### Case Sensitivity in Solidity 0.4.x
```
Contract name: Missing
Constructor:   Missing()   ← correct
Constructor:   missing()   ← WRONG (not recognized as constructor)
Constructor:   MISSING()   ← WRONG (case matters!)
```

### The Fix
```solidity
contract Missing {
    address public owner;
    
    constructor() public {  // CORRECT syntax in Solidity 0.8.x
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
cd /home/mat/poc1novo/poc-tcc/certora_tests/smartbugs-curated/dataset/4
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
- Counterexample: Non-owner calls `missing()` and becomes owner
- Demonstrates case-sensitivity issue

**Fixed Contract**:
- Properties PASS ✅
- Constructor properly executes once at deployment
- Owner is truly immutable after initialization

---

## 6. Files Location

```
dataset/4/
├── contracts/incorrect_constructor_name2.sol (vulnerable)
├── fixed_contracts/incorrect_constructor_name2.sol (fixed)
├── specs/incorrect_constructor_name2.spec (6 properties)
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
