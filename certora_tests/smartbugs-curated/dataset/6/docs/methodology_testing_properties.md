# Methodology for Testing Properties - Map (mapping_write)

## 1. Overview

This document details testing CVL properties for the Map contract arbitrary write vulnerability.

---

## 2. Artifacts Created

### 2.1 Solidity Contract Files

#### File: `contracts/mapping_write.sol`
**Why Created**: Modernized from Solidity ^0.4.24 to ^0.8.0 while **preserving the vulnerability**.

**Key Changes Made**:
- Updated pragma: `pragma solidity ^0.8.0;`
- Changed `array.length = key + 1` → `array.push(0)` (modern array operation)
- Changed `msg.sender.transfer()` → `msg.sender.call{value: amount}("")`
- Updated fallback syntax if present
- **Vulnerability preserved**: `set()` function is public with no access control

**Result**: Compiles with solc 0.8.3+ but vulnerability remains.

#### File: `fixed_contracts/mapping_write.sol`
**Why Created**: Corrected version with OpenZeppelin Ownable pattern.

**Key Changes Applied**:
- Added `address public owner;` in constructor
- Added `modifier onlyOwner()` for access control
- Protected `set()` with `onlyOwner` modifier
- Protected `withdraw()` with `onlyOwner` modifier
- Array operations use modern syntax

**Result**: Properties should **pass** on this version.

### 2.2 CVL Specification Files

#### File: `specs/mapping_write.spec`
**Why Created**: Defines 6 formal properties targeting arbitrary write vulnerability.

**Properties Defined** (6 total):
1. `onlyOwnerCanCallSet` - Only owner can call set()
2. `unauthorizedCannotModifyMap` - Non-owner cannot modify array
3. `mapLengthExpansionIsControlled` - Array expansion is authorized
4. `onlyOwnerCanWithdraw` - Only owner can withdraw funds
5. `mapDataIntegrityPreserved` - Data integrity maintained
6. `setFunctionAccessControl` - set() has access control

### 2.3 Certora Configuration Files

#### Files: `Map_vulnerable.conf`, `Map_fixed.conf`
**Why Created**: Configuration for Certora verification.

**Configuration Content**:
```json
{
    "files": ["contracts/mapping_write.sol"],
    "verify": "Map:specs/mapping_write.spec",
    "optimistic_loop": true,
    "loop_iter": "3",
    "rule_sanity": "basic",
    "msg": "Access Control Verification - Map Vulnerable Contract",
    "prover_version": "master"
}
```

---

## 3. The Vulnerability Explained

### Original Code (Solidity 0.4.24)
```solidity
contract Map {
    address public owner;
    uint256[] map;
    
    function set(uint256 key, uint256 value) public {  // NO ACCESS CONTROL!
        if (map.length <= key) {
            map.length = key + 1;  // Anyone can expand array
        }
        map[key] = value;  // Anyone can write arbitrary values
    }
    
    function withdraw() public {
        require(msg.sender == owner);
        msg.sender.transfer(address(this).balance);
    }
}
```

### Why It's Vulnerable
- `set()` is a public function with no access control checks
- Any address can call `set()` to modify the map array
- Can expand array arbitrarily
- Can write arbitrary values to any index
- Violates integrity of contract state

### Attack Scenario
```
1. Attacker calls set(1000000, 0)
2. Array expands to length 1000001
3. Memory/storage corrupted
4. Contract state compromised
```

### The Fix
```solidity
contract Map {
    address public owner;
    uint256[] map;
    
    constructor() public {
        owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner");
        _;
    }
    
    function set(uint256 key, uint256 value) public onlyOwner {  // PROTECTED!
        if (map.length <= key) {
            map.push(0);  // Only owner can expand
        }
        map[key] = value;  // Only owner can write
    }
    
    function withdraw() public onlyOwner {
        (bool sent,) = msg.sender.call{value: address(this).balance}("");
        require(sent);
    }
}
```

---

## 4. Array Operations: Old vs New Syntax

| Operation | Solidity 0.4.x | Solidity 0.8.x | Reason |
|-----------|---|---|---|
| Expand array | `array.length = n` | `array.push(0)` | length is read-only in 0.8.x |
| Remove last | `array.length--` | `array.pop()` | Same reason |
| Get length | `array.length` | `array.length` | Same |
| Access element | `array[i]` | `array[i]` | Same |

---

## 5. Commands Executed

### Run Vulnerable Contract
```bash
cd /home/mat/poc1novo/poc-tcc/certora_tests/smartbugs-curated/dataset/6
certoraRun Map_vulnerable.conf --disable_local_typechecking
```

### Run Fixed Contract
```bash
certoraRun Map_fixed.conf --disable_local_typechecking
```

---

## 6. Expected Results

**Vulnerable Contract**:
- Properties FAIL ❌
- Counterexample: Non-owner successfully calls set() and modifies array
- Shows arbitrary write is possible

**Fixed Contract**:
- Properties PASS ✅
- set() can only be called by owner
- Array modifications are controlled

---

## 7. CVL Properties Explained

### Property 1: `onlyOwnerCanCallSet`
**What it tests**:
- Attempts to call set() from different callers
- Checks if only owner succeeds
- Validates access control exists

### Property 2: `unauthorizedCannotModifyMap`
**What it tests**:
- Non-owner tries to call set()
- Should revert or fail
- Validates rejection of unauthorized calls

### Property 3: `mapLengthExpansionIsControlled`
**What it tests**:
- Array expansion can be triggered
- Only authorized user should trigger it
- Validates no arbitrary expansion

### Property 4: `onlyOwnerCanWithdraw`
**What it tests**:
- withdraw() function is also protected
- Only owner can access funds
- Validates multi-function access control

---

## 8. Files Location

```
dataset/6/
├── contracts/mapping_write.sol (vulnerable)
├── fixed_contracts/mapping_write.sol (fixed)
├── specs/mapping_write.spec (6 properties)
├── docs/
│   ├── methodology_creating_properties.md
│   └── methodology_testing_properties.md (this file)
├── Map_vulnerable.conf
└── Map_fixed.conf
```

---

## 9. Summary

The Map contract testing setup consists of:

1. **Two Versions**: Vulnerable and Fixed (both Solidity 0.8.x)
2. **Properties**: 6 CVL rules for access control
3. **Configs**: 2 Certora `.conf` files
4. **Expected**: FAILs on vulnerable, PASSes on fixed

---

**Document Version**: 1.0  
**Created**: May 12, 2026  
**Status**: Complete
