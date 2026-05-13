# Methodology for Testing Properties - Wallet (arbitrary_location_write_simple)

## 1. Overview

This document details the process of testing CVL properties for the Wallet access control vulnerability. It covers:
- All artifacts created manually
- Why each artifact was created
- Actual commands executed
- How to interpret results
- Validation approach

---

## 2. Artifacts Created

### 2.1 Solidity Contract Files (Modernization)

#### File: `contracts/arbitrary_location_write_simple.sol`
**Why Created**: The original contract was written in Solidity ^0.4.24, incompatible with available compiler (solc 0.8.3+). The contract was modernized while **preserving the vulnerability**.

**Key Changes Made**:
- Changed `pragma solidity ^0.4.24;` → `pragma solidity ^0.8.0;`
- Changed `function Wallet() public` → `constructor() public`
- Removed all visibility modifiers on public functions (they remain public)
- Updated comment references to maintain documentation
- **Vulnerability preserved**: `PushBonusCode()`, `PopBonusCode()`, `UpdateBonusCodeAt()` have no access control

**Result**: Contract compiles with solc 0.8.3+ without syntax errors while vulnerability remains.

#### File: `fixed_contracts/arbitrary_location_write_simple.sol`
**Why Created**: A corrected version following OpenZeppelin's Ownable pattern. This version validates that CVL properties **pass** when the vulnerability is fixed.

**Key Changes Applied**:
- Added `address public owner;` storage variable
- Added `modifier onlyOwner()` for access control
- Protected `PushBonusCode()` with `onlyOwner` modifier
- Protected `PopBonusCode()` with `onlyOwner` modifier
- Protected `UpdateBonusCodeAt()` with `onlyOwner` modifier
- Protected `Destroy()` with `onlyOwner` modifier
- Fixed array underflow logic in `PopBonusCode()`

**Result**: Same contract with security fixed. Properties should **pass** on this version.

### 2.2 CVL Specification Files

#### File: `specs/arbitrary_location_write_simple.spec`
**Why Created**: Defines formal properties (rules) that express the security requirements of the Wallet contract using CVL.

**Properties Defined** (5 total):
1. `onlyOwnerCanPopBonusCode` - Only owner can call PopBonusCode()
2. `onlyOwnerCanUpdateBonusCode` - Only owner can call UpdateBonusCodeAt()
3. `bonusCodesModificationControlled` - Bonus codes array modifications are authorized
4. `onlyOwnerCanDestroy` - Only owner can call Destroy()
5. `bonusCodesIntegrityPreserved` - Array integrity is maintained

**Why These Properties**:
- Target unauthorized array modifications
- Verify access control on sensitive functions
- Ensure data integrity is preserved
- Validate that fixes prevent exploitation

### 2.3 Certora Configuration Files

#### File: `Wallet_vulnerable.conf`
**Why Created**: Configuration for Certora to analyze the vulnerable Wallet contract.

**Configuration Content**:
```json
{
    "files": ["contracts/arbitrary_location_write_simple.sol"],
    "verify": "Wallet:specs/arbitrary_location_write_simple.spec",
    "optimistic_loop": true,
    "loop_iter": "3",
    "rule_sanity": "basic",
    "msg": "Access Control Verification - Wallet Vulnerable Contract",
    "prover_version": "master"
}
```

**Key Fields**:
- `"files"` - Points to vulnerable version of Wallet
- `"verify": "Wallet:..."` - Contract name is `Wallet` (defined in source as `contract Wallet`)
- Other fields same as FibonacciBalance

**Why This Config**:
- Tells Certora which contract to analyze
- Maps contract to its CVL specification
- Enables properties to run and find vulnerabilities

#### File: `Wallet_fixed.conf`
**Why Created**: Configuration for the corrected Wallet contract. Allows comparison of results.

**Difference**:
- `"files": ["fixed_contracts/arbitrary_location_write_simple.sol"]`
- `"msg"` mentions "Fixed Contract"
- All other settings identical

---

## 3. Contract Details

### Original Vulnerability Structure

The Wallet contract has these public functions without access control:

| Function | Parameters | Vulnerability |
|----------|-----------|---|
| `PushBonusCode(uint c)` | bonus code value | Anyone can add bonus codes |
| `PopBonusCode()` | none | Anyone can remove codes (array underflow) |
| `UpdateBonusCodeAt(uint idx, uint c)` | index, new code | Anyone can modify any code |
| `Destroy()` | none | Anyone can destroy contract |

### Fix Strategy

Protect all public functions with OpenZeppelin Ownable pattern:

```solidity
modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can call this");
    _;
}

function PopBonusCode() public onlyOwner { // ADDED onlyOwner
    // now only owner can execute
}
```

### Why These Specific Properties

**onlyOwnerCanPopBonusCode**: 
- PopBonusCode causes array length reduction
- This can cause underflow issues
- Must be restricted to prevent exploitation

**onlyOwnerCanUpdateBonusCode**:
- Allows arbitrary array modification
- Could corrupt contract state
- Requires authorization

**onlyOwnerCanDestroy**:
- Destroys the entire contract
- Most sensitive operation
- Absolutely must be owner-only

---

## 4. Solidity Version Compatibility

### Original Syntax (Solidity ^0.4.24)
```solidity
pragma solidity ^0.4.24;

contract Wallet {
    function Wallet() public { // old constructor syntax
        owner = msg.sender;
    }
    
    function PopBonusCode() public { // no restriction
        require(bonusCodes.length > 0);
        bonusCodes.length--; // old array length syntax
    }
}
```

### Modernized Syntax (Solidity ^0.8.0)
```solidity
pragma solidity ^0.8.0;

contract Wallet {
    constructor() public { // new constructor syntax
        owner = msg.sender;
    }
    
    function PopBonusCode() public { // same, but code updated
        require(bonusCodes.length > 0);
        bonusCodes.pop(); // new array pop syntax
    }
}
```

---

## 5. CVL Properties Detailed

### Property 1: `onlyOwnerCanPopBonusCode`

**Purpose**: Verify only owner can reduce bonus codes array.

**CVL Approach**:
- Call PopBonusCode with different callers
- Check if array length decreased
- Assert only authorized caller succeeded

**Expected Results**:
- **Vulnerable**: ❌ FAILS - Any caller can pop
- **Fixed**: ✅ PASSES - Only owner can pop

### Property 2: `onlyOwnerCanUpdateBonusCode`

**Purpose**: Verify only owner can modify array elements.

**CVL Approach**:
- Try to update element with different callers
- Check if value changed
- Assert only authorized caller succeeded

**Expected Results**:
- **Vulnerable**: ❌ FAILS - Any caller can update
- **Fixed**: ✅ PASSES - Only owner can update

### Property 3: `bonusCodesModificationControlled`

**Purpose**: Ensure array can only be modified by authorized user.

**CVL Approach**:
- Run all three modification functions
- Verify authorization on all
- Ensure modifications are tracked

**Expected Results**:
- **Vulnerable**: ❌ FAILS - Uncontrolled modifications
- **Fixed**: ✅ PASSES - All modifications authorized

---

## 6. Commands Executed

### 6.1 Environment Setup

**Command**:
```bash
source /home/mat/poc1novo/poc-tcc/activate_certora.sh
```

**Why**: Activates Certora CLI in Python virtual environment.

### 6.2 Running Vulnerable Contract

**Command**:
```bash
cd /home/mat/poc1novo/poc-tcc/certora_tests/smartbugs-curated/dataset/2
certoraRun Wallet_vulnerable.conf --disable_local_typechecking
```

**What Happens**:
1. Reads `Wallet_vulnerable.conf`
2. Compiles `contracts/arbitrary_location_write_simple.sol` with solc 0.8.3+
3. Parses `specs/arbitrary_location_write_simple.spec`
4. Uploads to Certora cloud
5. Returns Job ID for verification

**Output**:
```
Job submitted to server
Follow your job at https://prover.certora.com/output/[JOB_ID]/[HASH]
```

### 6.3 Running Fixed Contract

**Command**:
```bash
certoraRun Wallet_fixed.conf --disable_local_typechecking
```

**Why**: Verify that fixes work by comparing property results.

---

## 7. Interpreting Results

### Expected Pattern for Wallet

**Vulnerable Wallet**:
```
onlyOwnerCanPopBonusCode ..................... FAIL
onlyOwnerCanUpdateBonusCode .................. FAIL
bonusCodesModificationControlled ............ FAIL
onlyOwnerCanDestroy .......................... FAIL
bonusCodesIntegrityPreserved ................. FAIL
```

**Fixed Wallet**:
```
onlyOwnerCanPopBonusCode ..................... PASS
onlyOwnerCanUpdateBonusCode .................. PASS
bonusCodesModificationControlled ............ PASS
onlyOwnerCanDestroy .......................... PASS
bonusCodesIntegrityPreserved ................. PASS
```

### Counterexample Explanation

When vulnerable contract FAILs, Certora provides counterexample showing:
```
Counterexample:
  - Caller: 0x9999... (not the deployer)
  - Function: PopBonusCode()
  - Result: Array length decreased successfully
  
Conclusion: Arbitrary caller can modify array!
```

This proves the vulnerability exists.

---

## 8. How to Execute Tests

### Step 1: Activate Environment
```bash
cd /home/mat/poc1novo/poc-tcc
source activate_certora.sh
```

### Step 2: Navigate to Folder
```bash
cd certora_tests/smartbugs-curated/dataset/2
```

### Step 3: Run Vulnerable Version
```bash
certoraRun Wallet_vulnerable.conf --disable_local_typechecking
```

### Step 4: Run Fixed Version
```bash
certoraRun Wallet_fixed.conf --disable_local_typechecking
```

### Step 5: Compare Results
- Visit both Job URLs in browser
- Compare PASS/FAIL counts
- Review counterexamples for FAIL cases

---

## 9. Files Location Reference

```
dataset/2/
├── contracts/
│   └── arbitrary_location_write_simple.sol (modernized, vulnerable)
├── fixed_contracts/
│   └── arbitrary_location_write_simple.sol (modernized, fixed)
├── specs/
│   └── arbitrary_location_write_simple.spec (5 properties)
├── docs/
│   ├── methodology_creating_properties.md (vulnerability analysis)
│   └── methodology_testing_properties.md (this file)
├── Wallet_vulnerable.conf (config for vulnerable)
└── Wallet_fixed.conf (config for fixed)
```

---

## 10. Summary

The Wallet (arbitrary_location_write_simple) testing setup consists of:

1. **Two Versions**: Vulnerable and Fixed (both Solidity 0.8.x)
2. **Properties**: 5 CVL rules for access control
3. **Configs**: 2 Certora `.conf` files
4. **Expected**: FAILs on vulnerable, PASSes on fixed

---

**Document Version**: 1.0  
**Created**: May 12, 2026  
**Status**: Complete
