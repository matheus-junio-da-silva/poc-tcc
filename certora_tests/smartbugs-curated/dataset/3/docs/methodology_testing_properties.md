# Methodology for Testing Properties - Missing (incorrect_constructor_name1)

## 1. Overview

This document details testing CVL properties for the Missing contract vulnerability. The issue is a broken constructor with wrong function name.

---

## 2. Artifacts Created

### 2.1 Solidity Contract Files

#### File: `contracts/incorrect_constructor_name1.sol`
**Why Created**: Modernized from Solidity ^0.4.24 to ^0.8.0 while **preserving the vulnerability**.

**Key Changes Made**:
- Updated pragma: `pragma solidity ^0.8.0;`
- Kept function name as `IamMissing()` (incorrect, not constructor)
- Updated function visibility syntax
- **Vulnerability preserved**: `IamMissing()` is a regular function, anyone can call it to become owner

**Result**: Compiles with solc 0.8.3+ but vulnerability remains.

#### File: `fixed_contracts/incorrect_constructor_name1.sol`
**Why Created**: Corrected version with proper constructor name.

**Key Changes Applied**:
- Changed `function IamMissing()` → `constructor()`
- Owner correctly set only during deployment
- Other functions properly protected

**Result**: Properties should **pass** on this version.

### 2.2 CVL Specification Files

#### File: `specs/incorrect_constructor_name1.spec`
**Why Created**: Defines 5 formal properties targeting broken constructor vulnerability.

**Properties Defined**:
1. `ownerSetOnlyInConstructor` - Owner set only once at deployment
2. `onlyOwnerCanWithdraw` - Withdraw restricted to owner
3. `iamMissingIsProtected` - IamMissing() cannot be called
4. `ownerIsNeverZero` (invariant) - Owner is never uninitialized
5. `onlyOneOwnerCanBeSet` - Only one owner at any time

### 2.3 Certora Configuration Files

#### Files: `Missing_vulnerable.conf`, `Missing_fixed.conf`
**Why Created**: Configuration for Certora to analyze vulnerable and fixed versions.

**Configuration**:
```json
{
    "files": ["contracts/incorrect_constructor_name1.sol"],
    "verify": "Missing:specs/incorrect_constructor_name1.spec",
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
    
    function IamMissing() public {  // WRONG NAME! Should be "Missing"
        owner = msg.sender;
    }
    
    function withdraw() public {
        require(msg.sender == owner);
        msg.sender.transfer(this.balance);
    }
}
```

### Why It's Vulnerable
- Constructor names in Solidity 0.4.x were the same as contract name
- `IamMissing()` is a regular function, not constructor
- Any address can call `IamMissing()` after deployment
- They immediately become the owner

### The Fix
```solidity
contract Missing {
    address public owner;
    
    constructor() public {  // CORRECT NAME in Solidity 0.8.x
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
cd /home/mat/poc1novo/poc-tcc/certora_tests/smartbugs-curated/dataset/3
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
- Counterexample: Any address can call `IamMissing()` and become owner
- Shows the vulnerability is real

**Fixed Contract**:
- Properties PASS ✅
- No counterexamples found
- Shows the fix works

---

## 6. Files Location

```
dataset/3/
├── contracts/incorrect_constructor_name1.sol (vulnerable)
├── fixed_contracts/incorrect_constructor_name1.sol (fixed)
├── specs/incorrect_constructor_name1.spec (5 properties)
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
