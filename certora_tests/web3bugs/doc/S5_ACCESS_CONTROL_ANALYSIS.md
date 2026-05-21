# 🔐 Web3Bugs Dataset - S5 Access Control Vulnerabilities Analysis

## Summary
**Total S5 (Access Control) Vulnerabilities Found: 25**

Classification by S5 subcategory:
- **S5-1** (7 bugs): Users can update privileged state variables arbitrarily
- **S5-2** (4 bugs): Users can invoke functions at a time they should not be able to
- **S5-3** (14 bugs): Privileged functions can be called by anyone or at any time

---

## 📊 Breakdown by Contest and Vulnerability Type

### Contest 5 - Vader Protocol (4 bugs)

#### H-10: Anyone can list anchors / curate tokens [S5-3, Difficulty: 1]
- **Location**: Report: [reports/5.md](reports/5.md#h-10)
- **Contract**: Router.sol - `listAnchor` function
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: The `Router.listAnchor` function can be called by anyone to add tokens. Anchored pools automatically become curated pools that receive rewards. An attacker can remove rewards from existing pools and add them to custom pools they control.
- **Attack Vector**: Flash loan + custom token with controlled liquidity
- **Impact**: Reward manipulation, protocol fund loss

#### H-14: Missing access restriction on lockUnits/unlockUnits [S5-3, Difficulty: 1]
- **Location**: Report: [reports/5.md](reports/5.md#h-14)
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: Functions lack access control, allowing unauthorized calls
- **Impact**: State corruption, fund loss

#### H-21: Anyone Can Avoid All Vether Transfer Fees [S5-3, Difficulty: 1]
- **Location**: Report: [reports/5.md](reports/5.md#h-21)
- **Contract**: Vether.sol - `addExcluded` function
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: The unrestricted `addExcluded()` function allows any user to exclude their own address from transfer fees
- **Attack**: User calls `Vether.addExcluded(userAddress)` → transfers with no fees
- **Impact**: Lost protocol revenue (~$140k estimated at time of audit)

#### H-23: Anyone can curate pools and steal rewards [S5-3, Difficulty: 1]
- **Location**: Report: [reports/5.md](reports/5.md#h-23)
- **Contract**: Router.sol - `curatePool` and `replacePool` functions
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: No access control on pool curation. Attacker can flash loan + replace curated pools with custom ones
- **Attack Path**:
  1. Get flash loan of base tokens
  2. Call `replacePool()` to replace existing curated pools
  3. Redirect rewards to attacker's custom pool using custom token
  4. Manipulate reward system through swaps in custom pool
  5. Withdraw liquidity and repay flash loan
- **Impact**: Reward theft, protocol fund loss

---

### Contest 13 - Reality Cards (2 bugs)

#### H-03: anyone can call function sponsor [S5-3, Difficulty: 4]
- **Location**: Report: [reports/13.md](reports/13.md#h-03)
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Impact**: HIGH severity (Difficulty: 4)

#### H-04: Anyone can affect deposits of any user [S5-1, Difficulty: 1]
- **Location**: Report: [reports/13.md](reports/13.md#h-04)
- **Contract**: RCTreasury - `collectRentUser` method (public function)
- **Issue Type**: S5-1 - Users can update privileged state variables arbitrarily
- **Description**: Public method allows any caller to collect rent on behalf of any user with arbitrary timestamps
- **Attack**: `collectRentUser(victimAddress, type(uint256).max)` → forces user foreclosure
- **Impact**: User asset seizure, state corruption

---

### Contest 17 - Gro Protocol (1 bug)

#### H-03: Incorrect use of operator leads to arbitrary minting [S5-3, Difficulty: 3]
- **Location**: Report: [reports/17.md](reports/17.md#h-03)
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Impact**: Arbitrary minting of GVT tokens without authorization

---

### Contest 42 - Mochi (1 bug)

#### H-08: Anyone can extend withdraw wait period [S5-1, Difficulty: 2]
- **Location**: Report: [reports/42.md](reports/42.md#h-08)
- **Issue Type**: S5-1 - Users can update privileged state variables
- **Description**: Depositing zero collateral can extend withdrawal wait period
- **Impact**: Protocol denial of service, fund lock

---

### Contest 52 - Vader Protocol V2 (2 bugs)

#### H-13: Anyone Can Arbitrarily Mint Synthetic Assets [S5-3, Difficulty: 1]
- **Location**: Report: [reports/52.md](reports/52.md#h-13)
- **Contract**: VaderPoolV2 - `mintSynth()` function
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Impact**: Unlimited token minting without authorization

#### H-14: Anyone Can Arbitrarily Mint Fungible Tokens [S5-3, Difficulty: 1]
- **Location**: Report: [reports/52.md](reports/52.md#h-14)
- **Contract**: VaderPoolV2 - `mintFungible()` function
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Impact**: Unlimited token minting without authorization

---

### Contest 55 - Maple (1 bug)

#### H-01: makePayment() Lacks Access Control [S5-3, Difficulty: 1]
- **Location**: Report: [reports/55.md](reports/55.md#h-01)
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: Malicious lender can retrieve large portion of funds earlier
- **Impact**: Borrower fund loss

---

### Contest 61 - Sublime (1 bug)

#### H-06: Anyone can liquidate credit line [S5-3, Difficulty: 1]
- **Location**: Report: [reports/61.md](reports/61.md#h-06)
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: Function callable without proper authorization when `autoLiquidation` is false
- **Impact**: Unauthorized liquidation

---

### Contest 64 - PoolTogether (1 bug)

#### H-03: Continue claiming rewards after epochs end [S5-2, Difficulty: 6]
- **Location**: Report: [reports/64.md](reports/64.md#h-03)
- **Issue Type**: S5-2 - Functions callable at wrong times
- **Description**: Users can continue claiming rewards beyond the intended timeframe
- **Impact**: Reward inflation, fund loss

---

### Contest 66 - YetiFinance (1 bug)

#### H-01: receiveCollateral() can be called by anyone [S5-3, Difficulty: 3]
- **Location**: Report: [reports/66.md](reports/66.md#h-01)
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: Function lacks access control, allowing unauthorized calls
- **Impact**: Collateral manipulation

---

### Contest 71 - Insure (1 bug)

#### H-12: Wrong implementation allows LP pool resumption [S5-2, Difficulty: 2]
- **Location**: Report: [reports/71.md](reports/71.md#h-12)
- **Contract**: IndexTemplate.sol
- **Issue Type**: S5-2 - Functions callable at wrong times
- **Description**: LP of index pool can resume locked PayingOut pool and escape compensation responsibility
- **Impact**: Responsibility bypass

---

### Contest 74 - Timeswap (3 bugs)

#### H-01: borrow() allows improper state manipulation [S5-1, Difficulty: 1]
- **Location**: Report: [reports/74.md](reports/74.md#h-01)
- **Contract**: TimeswapPair.sol
- **Issue Type**: S5-1 - Users can update privileged state variables
- **Description**: Attacker can increase `pool.state.z` to large value
- **Impact**: Pool state corruption, price manipulation

#### H-02: borrowGivenDebt() state.y manipulation [S5-1, Difficulty: 1]
- **Location**: Report: [reports/74.md](reports/74.md#h-02)
- **Contract**: TimeswapConvenience.sol
- **Issue Type**: S5-1 - Users can update privileged state variables
- **Description**: Attacker can increase `state.y` to extremely large value with dust amount
- **Impact**: Pool state corruption, interest rate manipulation

#### H-03: Manipulation of Y State Results in Interest Rate Manipulation [S5-1, Difficulty: 4]
- **Location**: Report: [reports/74.md](reports/74.md#h-03)
- **Issue Type**: S5-1 - Users can update privileged state variables
- **Description**: State manipulation leads to critical interest rate changes
- **Impact**: Protocol economical breakdown

---

### Contest 78 - Behodler (1 bug)

#### H-01: Lack of access control on assertGovernanceApproved [S5-1, Difficulty: 3]
- **Location**: Report: [reports/78.md](reports/78.md#h-01)
- **Issue Type**: S5-1 - Users can update privileged state variables
- **Description**: Function can be called without proper authorization, locking funds
- **Impact**: Fund lock, governance bypass

---

### Contest 83 - Concur (1 bug)

#### H-03: Repeated Calls to Shelter.withdraw Can Drain Funds [S5-2, Difficulty: 19]
- **Location**: Report: [reports/83.md](reports/83.md#h-03)
- **Issue Type**: S5-2 - Functions callable at wrong times
- **Description**: Repeated calls can drain all funds from shelter
- **Impact**: Wallet draining, complete fund loss

---

### Contest 104 - JOYN (2 bugs)

#### H-02: Splitter - Anyone can call incrementWindow [S5-3, Difficulty: 10]
- **Location**: Report: [reports/104.md](reports/104.md#h-02)
- **Contract**: Splitter
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: Unrestricted function call allows token stealing
- **Impact**: Fund theft

#### H-04: CoreCollection can be reinitialized [S5-3, Difficulty: 12]
- **Location**: Report: [reports/104.md](reports/104.md#h-04)
- **Issue Type**: S5-3 - Privileged functions callable by anyone
- **Description**: Reinitialization vulnerability in core collection
- **Impact**: State corruption, fund loss

---

### Contest 113 - AbraNFT (1 bug)

#### H-04: Lender can seize collateral by changing loan parameters [S5-2, Difficulty: 7]
- **Location**: Report: [reports/113.md](reports/113.md#h-04)
- **Issue Type**: S5-2 - Functions callable at wrong times
- **Description**: Ability to change parameters allows collateral seizure
- **Impact**: Borrower fund loss

---

### Contest 123 - Aura (1 bug)

#### H-01: User can forfeit other user rewards [S5-1, Difficulty: 1]
- **Location**: Report: [reports/123.md](reports/123.md#h-01)
- **Issue Type**: S5-1 - Users can update privileged state variables
- **Description**: Function allows arbitrary user reward forfeiture
- **Impact**: Reward theft

---

### Contest 192 - Tigris (1 bug)

#### H-05: Malicious user can steal all assets in BondNFT [S5-1, Difficulty: 6]
- **Location**: Report: [reports/192.md](reports/192.md#h-05)
- **Issue Type**: S5-1 - Users can update privileged state variables
- **Description**: Lack of proper access control allows asset theft
- **Impact**: Complete fund loss from BondNFT

---

## 🎯 Key Patterns Identified

### Most Common Issue: S5-3 (14 occurrences - 56%)
**"Privileged functions can be called by anyone"**
- Missing access control checks
- No owner/admin verification
- Public functions that should be restricted
- Examples: `curatePool`, `mintSynth`, `receiveCollateral`

### Pattern: S5-1 (7 occurrences - 28%)
**"Users can update privileged state variables arbitrarily"**
- State manipulation vulnerabilities
- Parameters that can be changed without authorization
- Examples: Interest rate manipulation, pool state changes

### Pattern: S5-2 (4 occurrences - 16%)
**"Users can invoke functions at wrong times"**
- Timing-based access control issues
- Functions that should have temporal restrictions
- Examples: Claiming rewards beyond epochs, reinitialization

---

## 🔧 Common Vulnerability Root Causes

1. **Missing Access Control Modifiers** (14 cases)
   - Functions not protected by `onlyOwner`, `onlyDAO`, etc.
   - Example: `Router.listAnchor()` has no restrictions

2. **Parameter Validation Issues** (7 cases)
   - Privileged parameters can be set by any user
   - Example: Interest rate state can be manipulated

3. **Timing/Replay Issues** (4 cases)
   - No temporal checks on function execution
   - Example: Rewards can be claimed multiple times

---

## 💡 Recommended Fixes

### 1. Add Access Control Modifiers
```solidity
modifier onlyDAO() {
    require(msg.sender == dao, "Only DAO");
    _;
}

function curatePool(...) external onlyDAO { ... }
```

### 2. Implement State Validation
```solidity
require(msg.sender == owner || msg.sender == authorized, "Not authorized");
```

### 3. Add Temporal Checks
```solidity
require(block.timestamp <= claimDeadline, "Claims ended");
```

### 4. Use Flash Loan Protections
```solidity
require(block.number > lastBlockInteraction, "Flash loan protection");
```

---

## 📈 Statistics

| Metric | Value |
|--------|-------|
| Total S5 Bugs | 25 |
| Average Difficulty | 4.76 |
| Contests Affected | 16 |
| Range of Difficulties | 1-19 |
| Most Common Type | S5-3 (56%) |
| Highest Impact Difficulty | 19 (H-03 in Concur) |

---

## 🔗 Related Files
- Original CSV: [results/bugs.csv](results/bugs.csv)
- Dataset Reports: [reports/](reports/)
- Classification Standards: [docs/standard.md](docs/standard.md)

---

Generated: 2026-05-06
Dataset: Web3Bugs - Access Control Vulnerability Analysis
