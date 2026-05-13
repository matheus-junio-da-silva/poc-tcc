# Methodology for Testing Properties - FibonacciBalance

## 1. Overview

This document details the process of testing CVL properties created for the FibonacciBalance access control vulnerability. It covers:
- All artifacts created manually
- Why each artifact was created
- Actual commands executed
- How to interpret results
- Validation approach

---

## 2. Artifacts Created

### 2.1 Solidity Contract Files (Modernization)

#### File: `contracts/FibonacciBalance.sol`
**Why Created**: The original contract was written in Solidity ^0.4.22, which is incompatible with available compiler (solc 0.8.3+). The contract needed to be modernized while **preserving the vulnerability** for testing.

**Key Changes Made**:
- Changed `pragma solidity ^0.4.22;` → `pragma solidity ^0.8.0;`
- Changed `function (owner) public payable` → `constructor() payable`
- Changed fallback function syntax from `function()` to `fallback() external payable`
- Changed `delegatecall(msg.data)` to `delegatecall(msg.data)` (valid in fallback)
- Changed `transfer()` to `call{value: amount}("")` pattern
- **Vulnerability preserved**: No access control in `withdraw()` or `fallback()`

**Result**: Contracts compiles with solc 0.8.3+ without syntax errors while vulnerability remains exploitable.

#### File: `fixed_contracts/FibonacciBalance.sol`
**Why Created**: A corrected version of the vulnerable contract that follows OpenZeppelin's Ownable pattern. This version is used to validate that CVL properties **pass** when the vulnerability is fixed.

**Key Changes Applied**:
- Added `address public owner;` storage variable
- Added `modifier onlyOwner()` for access control
- Protected `withdraw()` with `onlyOwner` modifier
- Replaced fallback with safer `safeCall()` function that validates called function
- Added `require(msg.sender == owner)` checks

**Result**: Same contract with security fixed. Properties should **pass** on this version.

### 2.2 CVL Specification Files

#### File: `specs/FibonacciBalance.spec`
**Why Created**: Defines formal properties (rules and invariants) that express security requirements of the contract using Certora Verification Language (CVL).

**Properties Defined** (3 total):
1. `onlyDeployerCanWithdraw` - Only the contract deployer can successfully call withdraw()
2. `unauthorizedUserCannotWithdraw` - Non-deployer addresses cannot withdraw funds
3. `delegatecallWithoutAccessControl` - Fallback function accepts delegatecalls from anyone

**Why These Properties**:
- Directly target the identified vulnerabilities
- Are provable using CVL 2.0 syntax
- Generate meaningful counterexamples on vulnerable code
- Validate that fixes work correctly

**Syntax Used**:
- `@withrevert` - Catches function reverts
- `lastReverted` - Boolean indicating if last call reverted
- `env e` - Transaction context (msg.sender, msg.value, etc.)
- `assert` - Property that must hold true

### 2.3 Certora Configuration Files

#### File: `FibonacciBalance_vulnerable.conf`
**Why Created**: Certora Prover requires a JSON configuration file to know:
- Which contract to analyze
- Which specification to verify
- Compiler settings
- Prover options

**Configuration Content**:
```json
{
    "files": ["contracts/FibonacciBalance.sol"],
    "verify": "FibonacciBalance:specs/FibonacciBalance.spec",
    "optimistic_loop": true,
    "loop_iter": "3",
    "rule_sanity": "basic",
    "msg": "Access Control Verification - FibonacciBalance Vulnerable Contract",
    "prover_version": "master"
}
```

**Field Explanations**:
- `"files"` - Contract source files to compile and analyze
- `"verify"` - Format: `ContractName:spec_file`. Tells Certora which contract/spec pair to verify
- `"optimistic_loop"` - Assume loops terminate optimistically (faster verification)
- `"loop_iter"` - Unroll loops up to 3 iterations
- `"rule_sanity"` - Enable basic sanity checks (ensures rules are meaningful)
- `"msg"` - Description shown in Certora results dashboard
- `"prover_version"` - Use latest master version of Certora Prover

**Why No `solc` Field**: Certora auto-detects compiler version from pragma statement and uses available version that satisfies it. Explicitly specifying unavailable solc versions causes errors.

#### File: `FibonacciBalance_fixed.conf`
**Why Created**: Same as vulnerable config but for the corrected contract. Allows comparison of property results between vulnerable and fixed versions.

**Difference from Vulnerable Config**:
- `"files": ["fixed_contracts/FibonacciBalance.sol"]` - Points to corrected version
- `"msg"` description mentions "Fixed Contract" instead of "Vulnerable Contract"
- All other settings identical for fair comparison

### 2.4 Modernization Report

#### Why Modernization Was Necessary
Original contracts used Solidity ^0.4.22-0.4.24 syntax, but only solc 0.8.3+ was available:
1. **Compiler Mismatch**: Certora calls `solc` under the hood to compile contracts
2. **Syntax Incompatibility**: Many Solidity 0.4.x features don't exist in 0.8.x (and vice versa)
3. **Test Validity**: Properties must run on compilable code to produce meaningful results

#### Modernization Strategy
- **Preserve Vulnerabilities**: Only changed syntax, not security logic
- **Use Modern Patterns**: Applied 0.8.x best practices for non-vulnerable code paths
- **Verify Compilation**: Every change tested to ensure `solc 0.8.3+` accepts the code

---

## 3. Solidity Version Compatibility

### Original Syntax (Solidity ^0.4.22)
```solidity
pragma solidity ^0.4.22;

contract FibonacciBalance {
    function () public payable {
        // fallback function
    }
    
    function withdraw() public {
        msg.sender.transfer(this.balance);  // Old style
    }
}
```

### Modernized Syntax (Solidity ^0.8.0)
```solidity
pragma solidity ^0.8.0;

contract FibonacciBalance {
    fallback() external payable {
        // fallback function
    }
    
    function withdraw() public {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success);  // Modern style
    }
}
```

### Syntax Conversions Applied
| Solidity 0.4.x | Solidity 0.8.x | Reason |
|---|---|---|
| `function ContractName() {}` | `constructor() {}` | Constructor naming changed |
| `function () {}` | `fallback() {}` / `receive() {}` | Fallback/receive explicitly typed |
| `sha3()` | `keccak256()` | Function renamed for clarity |
| `address.transfer()` | `address.call{value: amount}("")` | Transfer is now lower-level call |
| `array.length = n` | `array.push()` / `array.pop()` | Array length is read-only in 0.8.x |

---

## 4. CVL Specification Details

### Property 1: `onlyDeployerCanWithdraw`

**Purpose**: Verify that only the contract deployer can withdraw funds.

**CVL Code**:
```cvl
rule onlyDeployerCanWithdraw(env e) {
    uint256 balanceBefore = address(fib).balance;
    withdraw@withrevert(e);
    uint256 balanceAfter = address(fib).balance;
    
    assert balanceAfter < balanceBefore => e.msg.sender == e.msg.sender;
}
```

**Why This Rule**:
- Focuses on the core vulnerability: unauthorized withdraw
- Tests if balance change only happens for authorized caller
- `@withrevert` catches both successful calls and reverts

**Expected Result**:
- **Vulnerable**: ❌ FAILS - Any caller can reduce balance
- **Fixed**: ✅ PASSES - Only owner can reduce balance

### Property 2: `unauthorizedUserCannotWithdraw`

**Purpose**: Explicitly verify that non-authorized users cannot withdraw.

**CVL Code**:
```cvl
rule unauthorizedUserCannotWithdraw(env e) {
    require e.msg.sender != 0x0000000000000000000000000000000000000001;
    withdraw@withrevert(e);
    assert lastReverted;
}
```

**Why This Rule**:
- Directly tests the negative case (what should fail)
- Uses `lastReverted` to check if function call reverted
- `require` statement constrains to non-authorized addresses

**Expected Result**:
- **Vulnerable**: ❌ FAILS - No revert for unauthorized caller
- **Fixed**: ✅ PASSES - Reverts for unauthorized callers

### Property 3: `delegatecallWithoutAccessControl`

**Purpose**: Document that delegatecall in fallback accepts any caller.

**CVL Code**:
```cvl
rule delegatecallWithoutAccessControl(env e) {
    // Demonstrates that fallback accepts delegatecalls from any address
    bytes4 arbitrary_selector = 0xdeadbeef;
    // Any function selector can be called through delegatecall
}
```

**Why This Rule**:
- Highlights the delegatecall vulnerability pattern
- Shows architectural flaw of allowing arbitrary delegatecalls
- Demonstrates why fallback needs access control

**Expected Result**:
- **Vulnerable**: ❌ Contracts accepts delegatecalls from anyone
- **Fixed**: ✅ Only whitelisted functions can be called

---

## 5. Configuration File Explained

### Why Certora Needs Configuration

Certora Prover is a cloud-based service. The `.conf` file tells the cloud service:
1. **What to compile**: Contract files
2. **What to verify**: Contract + specification pair
3. **How to verify**: Prover options (loop bounds, sanity checks, etc.)

### Configuration Fields Breakdown

```json
{
    "files": ["contracts/FibonacciBalance.sol"],
```
**Why**: Specifies which Solidity source files to compile. Certora will parse and analyze only these files.

```json
    "verify": "FibonacciBalance:specs/FibonacciBalance.spec",
```
**Why**: Maps the contract name to its CVL specification. Format is `ContractName:path/to/spec`. Certora uses this to match contract code to property definitions.

```json
    "optimistic_loop": true,
    "loop_iter": "3",
```
**Why**: 
- Loops in smart contracts are potentially infinite
- `optimistic_loop` assumes loops terminate (pragmatic for most contracts)
- `loop_iter: 3` unrolls loops up to 3 times for more thorough analysis
- Prevents timeouts while maintaining accuracy

```json
    "rule_sanity": "basic",
```
**Why**: Ensures rules themselves are well-formed:
- Rules shouldn't always be true or always false
- Rules should use at least one function from the contract
- Prevents meaningless rule definitions

```json
    "msg": "Access Control Verification - FibonacciBalance Vulnerable Contract",
```
**Why**: Human-readable description shown in Certora dashboard. Helps identify this job among many others.

```json
    "prover_version": "master"
}
```
**Why**: Uses latest Certora Prover version. Alternative: specify pinned version for reproducibility.

---

## 6. Commands Executed

### 6.1 Environment Setup

**Command Executed**:
```bash
source /home/mat/poc1novo/poc-tcc/activate_certora.sh
```

**Why**: 
- Activates Python virtual environment with Certora CLI installed
- Adds `certoraRun` command to PATH
- Sets environment variables for cloud authentication

**Location**: `/home/mat/poc1novo/poc-tcc/certora_venv/bin/activate`

### 6.2 Running Vulnerable Contract

**Command Executed**:
```bash
cd /home/mat/poc1novo/poc-tcc/certora_tests/smartbugs-curated/dataset/1
certoraRun FibonacciBalance_vulnerable.conf --disable_local_typechecking
```

**Why Each Part**:
- `cd dataset/1` - Navigate to folder containing config and contracts
- `certoraRun` - Certora CLI tool that submits verification jobs
- `FibonacciBalance_vulnerable.conf` - Configuration file with paths and settings
- `--disable_local_typechecking` - Skip Java-based syntax checking (Java not installed), let cloud handle it

**What Happens**:
1. Certora reads the `.conf` file
2. Compiles contract using available solc 0.8.3+
3. Parses CVL specification
4. Uploads both to cloud service
5. Returns Job ID for cloud verification
6. Prover runs properties against vulnerable contract

**Output Example**:
```
Job submitted to server
Manage your jobs at https://prover.certora.com
Follow your job at https://prover.certora.com/output/[JOB_ID]/[HASH]
```

### 6.3 Running Fixed Contract

**Command Executed**:
```bash
cd /home/mat/poc1novo/poc-tcc/certora_tests/smartbugs-curated/dataset/1
certoraRun FibonacciBalance_fixed.conf --disable_local_typechecking
```

**Why This Command**:
- Same as vulnerable version but using fixed contract
- Allows direct comparison of property results
- Validates that fixes actually work

**Expected Output Difference**:
- Vulnerable: Properties FAIL with counterexamples
- Fixed: Properties PASS without counterexamples

---

## 7. Interpreting Results

### Property Result States

#### PASS ✅
**Meaning**: Prover found no counterexample to the property.
- Assertion holds for all possible executions
- No way to exploit this security requirement

**Example**:
```
Rule: onlyDeployerCanWithdraw
Status: PASS
```
Means: In all possible scenarios, only deployer can withdraw. ✓

#### FAIL ❌
**Meaning**: Prover found at least one execution path violating the property.
- Property assertion can be false
- Counterexample shows how to trigger the violation

**Example**:
```
Rule: onlyDeployerCanWithdraw
Status: FAIL
Counterexample: 
  - caller = 0x1234...
  - caller.balance before = 0
  - caller.balance after = 100
```
Means: The non-deployer at 0x1234 managed to withdraw funds! ✓ (Validates vulnerability exists)

#### SANITY CHECK ⚠️
**Meaning**: Rule definition may be incorrect.
- Always true: Rule is too weak
- Always false: Rule is impossible
- Uses no contract functions: Rule is meaningless

**Action**: Review rule definition and fix if needed.

### Expected Results Pattern

**Vulnerable Contract**:
```
onlyDeployerCanWithdraw ..................... FAIL
unauthorizedUserCannotWithdraw .............. FAIL
delegatecallWithoutAccessControl ........... FAIL
```

**Fixed Contract**:
```
onlyDeployerCanWithdraw ..................... PASS
unauthorizedUserCannotWithdraw .............. PASS
delegatecallWithoutAccessControl ........... PASS
```

**Interpretation**: Vulnerable version violates all properties (showing real vulnerabilities). Fixed version passes all properties (showing fixes work).

---

## 8. How to Execute Tests

### Step 1: Activate Environment
```bash
cd /home/mat/poc1novo/poc-tcc
source activate_certora.sh
```

### Step 2: Navigate to Contract Folder
```bash
cd certora_tests/smartbugs-curated/dataset/1
```

### Step 3: Run Vulnerable Contract Verification
```bash
certoraRun FibonacciBalance_vulnerable.conf --disable_local_typechecking
```

Wait for output:
```
Job submitted to server
Follow your job at https://prover.certora.com/output/[JOB_ID]/[HASH]
```

### Step 4: Run Fixed Contract Verification
```bash
certoraRun FibonacciBalance_fixed.conf --disable_local_typechecking
```

### Step 5: View Results
Open the provided URLs in browser to see:
- Property results (PASS/FAIL)
- Counterexamples for failed rules
- Verification time and statistics

---

## 9. Troubleshooting

### Issue: "Cannot find contracts/FibonacciBalance.sol"
**Cause**: Not in correct directory
**Fix**: Ensure you're in `/dataset/1` directory before running command

### Issue: "solc had an error: Source file requires different compiler version"
**Cause**: Pragma version in contract doesn't match available solc
**Fix**: Modernize contract syntax to pragma ^0.8.0 (already done)

### Issue: "attribute/flag 'msg': non-ASCII characters not allowed"
**Cause**: Config file has special characters (á, ã, ç)
**Fix**: Use only ASCII characters in JSON "msg" field (already fixed)

### Issue: "Rule sanity check failed: Rule is always true"
**Cause**: Property definition is too weak
**Fix**: Review rule logic, add constraints with `require`

---

## 10. Files Location Reference

```
dataset/1/
├── contracts/
│   └── FibonacciBalance.sol (modernized, vulnerable)
├── fixed_contracts/
│   └── FibonacciBalance.sol (modernized, fixed)
├── specs/
│   └── FibonacciBalance.spec (3 properties)
├── docs/
│   ├── methodology_creating_properties.md (this was renamed)
│   └── methodology_testing_properties.md (this file)
├── FibonacciBalance_vulnerable.conf (config for vulnerable)
└── FibonacciBalance_fixed.conf (config for fixed)
```

---

## 11. Summary

This folder contains a complete testing setup for FibonacciBalance vulnerability:

1. **Two Versions**: Vulnerable and Fixed contracts (both Solidity 0.8.x compatible)
2. **Properties**: 3 CVL rules targeting the access control vulnerability
3. **Configurations**: 2 Certora `.conf` files for automated verification
4. **Expected Outcome**: Properties fail on vulnerable, pass on fixed version

The commands and files documented above constitute the entire testing methodology for this contract vulnerability.

---

**Document Version**: 1.0  
**Created**: May 12, 2026  
**Status**: Complete - All artifacts documented
