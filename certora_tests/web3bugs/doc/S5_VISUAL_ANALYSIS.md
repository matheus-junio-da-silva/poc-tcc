# S5 Access Control Vulnerabilities - Visual Analysis

## 📊 Distribution by S5 Subcategory

```
S5-3: Privileged functions callable by anyone
████████████████████████████░░░░░░░░░░░░░░░░░░░░░ 14/25 (56%)

S5-1: Users can update privileged state variables
███████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 7/25 (28%)

S5-2: Functions callable at wrong times
████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 4/25 (16%)
```

## 🎯 Difficulty Distribution

```
Difficulty 1  ████████████████░░░░░░░░░░░░░░ 12 bugs (48%)
Difficulty 2  ███░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 2 bugs  (8%)
Difficulty 3  ████░░░░░░░░░░░░░░░░░░░░░░░░░░░ 3 bugs  (12%)
Difficulty 4  ███░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 2 bugs  (8%)
Difficulty 5  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ 0 bugs  (0%)
Difficulty 6+ ████░░░░░░░░░░░░░░░░░░░░░░░░░░░ 4 bugs  (16%)
```

## 📈 Bugs by Contest

```
Contest  5 (Vader)        ████ 4 bugs
Contest 13 (Reality)      ██ 2 bugs  
Contest 17 (Gro)          ██ 1 bug
Contest 42 (Mochi)        ██ 1 bug
Contest 52 (Vader V2)     ███ 2 bugs
Contest 55 (Maple)        ██ 1 bug
Contest 61 (Sublime)      ██ 1 bug
Contest 64 (PoolTogether) ██ 1 bug
Contest 66 (YetiFinance)  ██ 1 bug
Contest 71 (Insure)       ██ 1 bug
Contest 74 (Timeswap)     ███ 3 bugs
Contest 78 (Behodler)     ██ 1 bug
Contest 83 (Concur)       ██ 1 bug
Contest 104 (JOYN)        ███ 2 bugs
Contest 113 (AbraNFT)     ██ 1 bug
Contest 123 (Aura)        ██ 1 bug
Contest 192 (Tigris)      ██ 1 bug
```

## 🔍 Top Vulnerability Patterns

### Pattern 1: Missing Access Control (14 bugs - 56%)
**Affected Protocols:**
- Vader Protocol (2x)
- Gro Protocol (1x)
- Vader V2 (2x)
- Maple (1x)
- Sublime (1x)
- YetiFinance (1x)
- JOYN (2x)
- And more...

**Common Functions:**
- `curatePool()` - Pool reward curation
- `mintSynth()` - Synthetic asset creation
- `receiveCollateral()` - Collateral reception
- `addExcluded()` - Fee exemption lists
- `incrementWindow()` - Window advancement

**Fix Pattern:**
```solidity
// ❌ VULNERABLE
function curatePool(address token) external {
    // No access control!
    curations[token] = true;
}

// ✅ FIXED
function curatePool(address token) external onlyDAO {
    // Protected!
    curations[token] = true;
}
```

---

### Pattern 2: State Variable Corruption (7 bugs - 28%)
**Attack Types:**
1. **Interest Rate Manipulation** (Timeswap, Mochi)
   - Attackers modify `state.y` or `state.z` directly
   - Results in broken economics

2. **User Account Abuse** (Reality Cards)
   - Calling functions with arbitrary user addresses
   - `collectRentUser(victimAddress, type(uint256).max)`

3. **Reward Forfeiture** (Aura)
   - Causing other users' rewards to be forfeited

**Common Root Cause:**
Missing parameter validation or missing `require` checks

```solidity
// ❌ VULNERABLE
function collectRent(address user, uint256 time) external {
    isForeclosed[user] = (rentBalance[user] < minimumRent);
}

// ✅ FIXED
function collectRent(address user, uint256 time) external onlyAuthorized {
    require(user == msg.sender, "Can only collect own rent");
    isForeclosed[user] = (rentBalance[user] < minimumRent);
}
```

---

### Pattern 3: Temporal Access Violations (4 bugs - 16%)
**Issues:**
- Claiming rewards outside valid epochs
- Withdrawing funds at arbitrary times
- Reinitializing contracts that should be immutable

**High Impact Case:**
- **Concur H-03** (Difficulty: 19)
- Repeated `withdraw()` calls drain entire shelter
- Complete fund loss possible

**Solution:**
```solidity
// ✅ FIXED
modifier onlyDuringClaimPeriod() {
    require(block.timestamp >= claimStart && 
            block.timestamp <= claimEnd, 
            "Outside claim period");
    _;
}

function claimRewards() external onlyDuringClaimPeriod {
    // Safe to claim
}
```

---

## 🎪 Most Dangerous Bugs

### 🔴 Highest Difficulty: Concur H-03 (S5-2, Difficulty: 19)
**Vulnerability**: Repeated `Shelter.withdraw()` drains all funds
**Impact**: Total fund loss
**Attack**: Simple repeated calls to vulnerable function

### 🔴 JOYN H-04 (S5-3, Difficulty: 12)
**Vulnerability**: CoreCollection reinitialization
**Impact**: Complete state corruption

### 🔴 JOYN H-02 (S5-3, Difficulty: 10)
**Vulnerability**: `incrementWindow()` token theft
**Impact**: Direct fund theft

---

## 📋 Vulnerability Checklist

When reviewing access control, verify:

- [ ] All privileged functions have access control modifier
- [ ] Access control checks use correct sender (`msg.sender` vs `tx.origin`)
- [ ] Initialization functions cannot be called multiple times
- [ ] Flash loan protection implemented for critical functions
- [ ] Temporal constraints enforced where needed
- [ ] No state corruption from arbitrary function calls
- [ ] Parameter validation on all user inputs
- [ ] Call sequences properly ordered/protected

---

## 🔗 Quick Navigation

### By Type:
- [All S5-3 Bugs (Privileged callable)](S5_FILTERED_BUGS.csv)
- [All S5-1 Bugs (State update)](S5_FILTERED_BUGS.csv)
- [All S5-2 Bugs (Timing issues)](S5_FILTERED_BUGS.csv)

### By Severity:
- [Highest Difficulty Bugs (6+)](S5_FILTERED_BUGS.csv)
- [Medium Difficulty (3-5)](S5_FILTERED_BUGS.csv)
- [Easy to Exploit (1-2)](S5_FILTERED_BUGS.csv)

### By Protocol:
- [Vader Protocol Issues (Contests 5, 52)](S5_FILTERED_BUGS.csv)
- [AMM-Related Issues (Contests 5, 52, 74)](S5_FILTERED_BUGS.csv)
- [Lending Protocol Issues (Contests 42, 55, 61, 113, 123)](S5_FILTERED_BUGS.csv)

---

## 💡 Key Takeaways

1. **56% of access control bugs** are simply missing access control modifiers
   - Low difficulty to fix but critical impact

2. **Flash loans** enable multiple S5 attacks
   - Always protect state changes with temporal checks

3. **Initialization functions** are frequently targets
   - Use factory pattern or add initialization guards

4. **State variables** can be directly corrupted on many protocols
   - Validate all parameter modifications

5. **Timing-based attacks** are harder to detect
   - Use block numbers instead of timestamps for critical logic

---

**Analysis Date**: May 6, 2026  
**Total Bugs Analyzed**: 25  
**Average Difficulty**: 4.76  
**Contests Covered**: 16
