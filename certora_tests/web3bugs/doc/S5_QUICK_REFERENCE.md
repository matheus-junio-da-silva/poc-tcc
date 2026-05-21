# 🗺️ S5 Access Control Bugs - Quick Reference Navigation Map

## 📌 Quick Access by Type

### 🔐 S5-3 Bugs: Privileged Functions Callable by Anyone (14 bugs)
Most common vulnerability - functions with administrative functions but no access control

**Easy Navigation:**
```
Contest 5   → H-10 (listAnchor)
           → H-14 (lockUnits/unlockUnits)
           → H-21 (addExcluded)
           → H-23 (curatePool)

Contest 13  → H-03 (sponsor)

Contest 17  → H-03 (arbitrary minting)

Contest 52  → H-13 (mintSynth)
           → H-14 (mintFungible)

Contest 55  → H-01 (makePayment)

Contest 61  → H-06 (liquidate)

Contest 66  → H-01 (receiveCollateral)

Contest 104 → H-02 (incrementWindow)
           → H-04 (CoreCollection reinitialization)
```

**Key Finding**: Most of these just need `onlyDAO` or `onlyOwner` modifier

---

### 🎯 S5-1 Bugs: Users Update Privileged State Variables (7 bugs)
State corruption vulnerabilities - users can modify critical parameters arbitrarily

**Easy Navigation:**
```
Contest 13  → H-04 (collectRentUser - user address abuse)

Contest 42  → H-08 (extend withdraw wait period)

Contest 74  → H-01 (state.z manipulation)
           → H-02 (state.y manipulation)
           → H-03 (Y state interest rate)

Contest 78  → H-01 (assertGovernanceApproved)

Contest 123 → H-01 (forfeit other rewards)

Contest 192 → H-05 (BondNFT asset theft)
```

**Key Finding**: Missing input validation or authorization checks

---

### ⏰ S5-2 Bugs: Functions Callable at Wrong Times (4 bugs)
Temporal access control issues - functions should be restricted to specific timeframes

**Easy Navigation:**
```
Contest 64  → H-03 (claim rewards beyond epochs) - DANGEROUS: Diff 6

Contest 71  → H-12 (LP pool resumption at wrong time)

Contest 83  → H-03 (repeated withdrawals) - CRITICAL: Diff 19 🔴

Contest 113 → H-04 (seize collateral by parameter change)
```

**Key Finding**: Add temporal validation with `block.timestamp` or `block.number` checks

---

## 🎪 By Difficulty Level

### 🟢 Easy Fixes (Difficulty 1-2): 14 bugs
```
Diff 1:  H-10, H-14, H-21, H-23 (Vader)
         H-04 (Reality Cards)
         H-03 (Gro)
         H-13, H-14 (Vader V2)
         H-01 (Maple)
         H-06 (Sublime)
         → Just add access control modifiers

Diff 2:  H-08 (Mochi)
         H-12 (Insure)
         → Add parameter validation or timing checks
```

### 🟠 Medium Fixes (Difficulty 3-4): 5 bugs
```
Diff 3:  H-03 (Reality Cards) - User address abuse
         H-03 (Gro) - Operator logic
         H-01 (YetiFinance) - Missing access
         H-01 (Behodler) - Complex governance

Diff 4:  H-03 (Timeswap) - Interest rate manipulation
         H-03 (Reality Cards) - Complex state

→ Requires deeper understanding of protocol economics
```

### 🔴 Complex Fixes (Difficulty 5+): 6 bugs
```
Diff 6:  H-03 (PoolTogether) - Temporal boundary issue
         H-05 (Tigris) - Multi-vector attack

Diff 7:  H-04 (AbraNFT) - Lending parameter abuse

Diff 10: H-02 (JOYN) - Window advancement + theft

Diff 12: H-04 (JOYN) - Reinitialization logic

Diff 19: H-03 (Concur) - Drainage attack 🔴 CRITICAL
         → Complete fund loss possible

→ Requires security model redesign
```

---

## 🏢 By Protocol/Contest

### Lending Protocols (Highest Risk)
```
Contest 42  - Mochi (1 bug)
Contest 55  - Maple (1 bug)
Contest 61  - Sublime (1 bug)
Contest 113 - AbraNFT (1 bug)
Contest 123 - Aura (1 bug)
Contest 192 - Tigris (1 bug)

⚠️ Total: 6 bugs in lending protocols
🎯 Common Issue: Missing access control on withdrawal/liquidation
```

### DEX/Pool Protocols (Most Vulnerable)
```
Contest 5   - Vader (4 bugs) ← MOST BUGS
Contest 17  - Gro (1 bug)
Contest 52  - Vader V2 (2 bugs)
Contest 74  - Timeswap (3 bugs)

⚠️ Total: 10 bugs in DEX protocols
🎯 Common Issue: Unrestricted pool management functions
```

### Governance/Vault Protocols
```
Contest 13  - Reality Cards (2 bugs)
Contest 64  - PoolTogether (1 bug)
Contest 71  - Insure (1 bug)
Contest 78  - Behodler (1 bug)
Contest 83  - Concur (1 bug)
Contest 104 - JOYN (2 bugs)
Contest 66  - YetiFinance (1 bug)

⚠️ Total: 9 bugs in governance/vault protocols
🎯 Common Issue: Initialization + temporal access problems
```

---

## 🚀 Quick Fix Patterns

### Pattern 1: Add Access Control (14 S5-3 bugs)
**Location**: Look for public/external functions doing admin tasks
**Fix**:
```solidity
// BEFORE
function curatePool(address token) external { ... }

// AFTER
function curatePool(address token) external onlyDAO { ... }
```

### Pattern 2: Validate Parameters (7 S5-1 bugs)
**Location**: Functions that modify critical state
**Fix**:
```solidity
// BEFORE
function collectRent(address user, uint time) external {
    isForeclosed[user] = true;
}

// AFTER
function collectRent(address user, uint time) external {
    require(msg.sender == daoAddress, "Unauthorized");
    isForeclosed[user] = true;
}
```

### Pattern 3: Add Temporal Checks (4 S5-2 bugs)
**Location**: Functions that should have time limits
**Fix**:
```solidity
// BEFORE
function claimRewards() external { ... }

// AFTER
function claimRewards() external {
    require(block.timestamp >= claimStart, "Too early");
    require(block.timestamp <= claimEnd, "Too late");
    ...
}
```

---

## 📊 Risk Matrix

```
                  EASY (Diff 1-2)   MEDIUM (Diff 3-4)   HARD (Diff 5+)
                  
S5-3 (Priv)       ✅ 10 bugs        ⚠️  2 bugs          ❌ 2 bugs
S5-1 (State)      ✅ 2 bugs         ⚠️  2 bugs          ❌ 3 bugs
S5-2 (Timing)     ⚠️  0 bugs        ⚠️  1 bug           ❌ 3 bugs

Legend:
✅ Easy to detect and fix
⚠️  Medium complexity
❌ High complexity, requires redesign
```

---

## 🔗 Finding Details

### Report Locations:
All original reports are in: `/reports/[contestID].md`

### Examples:
- Vader bugs: `/reports/5.md` (Search for "H-10", "H-14", "H-21", "H-23")
- Timeswap bugs: `/reports/74.md` (Search for "H-01", "H-02", "H-03")
- JOYN bugs: `/reports/104.md` (Search for "H-02", "H-04")
- Concur critical: `/reports/83.md` (Search for "H-03")

### Dataset Files:
- Full analysis: `S5_ACCESS_CONTROL_ANALYSIS.md`
- Visual breakdown: `S5_VISUAL_ANALYSIS.md`
- Filtered CSV: `S5_FILTERED_BUGS.csv`

---

## ✅ Audit Checklist for Access Control

When auditing a new Web3 protocol:

- [ ] **Identify Admin Functions**
  - Are all admin functions guarded by access control?
  - Is the access control mechanism correct? (msg.sender vs tx.origin)

- [ ] **Check Initialization**
  - Can init functions be called multiple times?
  - Are they properly protected?

- [ ] **Validate State Modifications**
  - Who can modify critical state variables?
  - Are all parameters validated?

- [ ] **Audit Timing Issues**
  - Are there time-based restrictions?
  - Can functions be called at the wrong time?

- [ ] **Flash Loan Safety**
  - Are critical state changes protected?
  - Is there a block delay requirement?

- [ ] **Test Vectors**
  - Call admin functions as attacker
  - Initialize contracts multiple times
  - Manipulate state variables
  - Try calling functions at different times

---

## 📈 Statistics Summary

| Category | Count | % |
|----------|-------|---|
| S5-3 (Privileged) | 14 | 56% |
| S5-1 (State) | 7 | 28% |
| S5-2 (Timing) | 4 | 16% |
| **Total** | **25** | **100%** |

| Difficulty | Count | Risk Level |
|------------|-------|-----------|
| 1-2 (Easy) | 14 | Low (quick fix) |
| 3-4 (Medium) | 5 | Medium |
| 5+ (Hard) | 6 | High (redesign needed) |
| Max: 19 | Concur | 🔴 CRITICAL |

---

**Last Updated**: May 6, 2026  
**Scope**: Web3Bugs Dataset - Access Control (S5) Vulnerability Analysis  
**Total Protocols Analyzed**: 16 contests  
**Files Generated**: 4 analysis files
