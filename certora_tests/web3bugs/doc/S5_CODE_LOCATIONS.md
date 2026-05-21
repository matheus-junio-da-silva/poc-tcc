# 🔍 S5 Vulnerabilities - Exact Code Locations

## Where to Find the Vulnerable Code

This guide shows exactly where the vulnerabilities are located in the dataset's contract files.

---

## Contest 5 - Vader Protocol

### 📁 Location: `contracts/5/contracts/`

#### H-10: Anyone can list anchors / curate tokens [S5-3]
**File**: `Router.sol`  
**Function**: `listAnchor()` and `replaceAnchor()`
**Issue**: No access control on anchor curation function
```
Look for: 
- Line with: function listAnchor(address token) external {
- Missing: onlyDAO modifier
- Should be: function listAnchor(address token) external onlyDAO {
```

#### H-14: Missing access restriction [S5-3]
**File**: Unknown - check `Vault.sol`, `Router.sol`
**Function**: `lockUnits()` and `unlockUnits()`
**Issue**: Publicly callable functions without authorization checks

#### H-21: Anyone Can Avoid Transfer Fees [S5-3]
**File**: `Vether.sol`
**Function**: `addExcluded(address)`
**Issue**: Function allows anyone to exclude themselves from fees
```
Look for:
- function addExcluded(address _address) external {
- Should check: require(msg.sender == owner)
```

#### H-23: Anyone can curate pools [S5-3]
**File**: `Router.sol`
**Function**: `curatePool()` and `replacePool()`
**Issue**: No access control - anyone can add/replace curated pools
```
Look for:
- function curatePool(...) external {
- function replacePool(...) external {
- Missing: onlyDAO modifier
```

---

## Contest 13 - Reality Cards

### 📁 Location: `contracts/13/`

#### H-03: anyone can call function sponsor [S5-3]
**File**: Look in contracts directory
**Function**: `sponsor()`
**Issue**: Public sponsor function with no access control
**Impact**: Difficulty 4 - significant

#### H-04: Anyone can affect deposits [S5-1]
**File**: `RCTreasury.sol`
**Function**: `collectRentUser(address _user, uint256 _timeToCollectTo)`
**Issue**: Public function with arbitrary user address parameter
```
Attack Vector:
- collectRentUser(victimAddress, type(uint256).max)
- Sets: isForeclosed[victimAddress] = true
- Result: Victim's deposit locked/seized
```

---

## Contest 17 - Gro Protocol

### 📁 Location: `contracts/17/contracts/`

#### H-03: Arbitrary minting of GVT tokens [S5-3]
**File**: Look for GVT token or minting function
**Function**: Likely `mint()` or token creation function
**Issue**: Operator logic error allows arbitrary minting
**Difficulty**: 3 - high complexity

---

## Contest 42 - Mochi

### 📁 Location: `contracts/42/`

#### H-08: Anyone can extend withdraw wait period [S5-1]
**File**: Look for deposit/withdrawal contracts
**Function**: Deposit or collateral function
**Issue**: Zero collateral deposit extends protection period
```
Attack:
- Deposit 0 collateral
- Extends withdrawal wait period for others
- Causes temporary fund lock
```
**Difficulty**: 2

---

## Contest 52 - Vader Protocol V2

### 📁 Location: `contracts/52/contracts/`

#### H-13: Arbitrary Mint Synthetic Assets [S5-3]
**File**: `VaderPoolV2.sol`
**Function**: `mintSynth()`
**Issue**: No access control on minting
```
Look for:
- function mintSynth(...) external {
- Missing: onlyDAO or role check
```

#### H-14: Arbitrary Mint Fungible Tokens [S5-3]
**File**: `VaderPoolV2.sol`
**Function**: `mintFungible()`
**Issue**: No access control on token minting

---

## Contest 55 - Maple Protocol

### 📁 Location: `contracts/55/`

#### H-01: makePayment() Lacks Access Control [S5-3]
**File**: Look for lending/payment contracts
**Function**: `makePayment()`
**Issue**: Lender can retrieve funds at will without authorization
**Impact**: Borrower fund loss

---

## Contest 61 - Sublime

### 📁 Location: `contracts/61/`

#### H-06: Anyone can liquidate credit line [S5-3]
**File**: Look for credit line module
**Function**: `liquidate()` or liquidation function
**Issue**: When `autoLiquidation=false`, anyone can liquidate without proper authorization

---

## Contest 64 - PoolTogether

### 📁 Location: `contracts/64/`

#### H-03: Continue claiming rewards after epochs [S5-2]
**File**: Look for reward claiming mechanism
**Function**: `claimReward()` or similar
**Issue**: No check for epoch end time - can claim indefinitely
```
Attack:
- numberOfEpochs = 100 (for example)
- After epoch 100 ends, still can claim
- Missing: require(currentEpoch < numberOfEpochs)
```
**Difficulty**: 6 ⚠️

---

## Contest 66 - YetiFinance

### 📁 Location: `contracts/66/`

#### H-01: receiveCollateral() callable by anyone [S5-3]
**File**: Look for collateral handling contracts
**Function**: `receiveCollateral()`
**Issue**: No access control - anyone can modify collateral state
**Impact**: Collateral manipulation/theft

---

## Contest 71 - Insure Protocol

### 📁 Location: `contracts/71/`

#### H-12: LP pool resumption exploit [S5-2]
**File**: `IndexTemplate.sol`
**Function**: Function that resumes/locks pools
**Issue**: LP can resume locked PayingOut pools inappropriately
**Impact**: Circumvent compensation obligations

---

## Contest 74 - Timeswap

### 📁 Location: `contracts/74/`

#### H-01: borrow() state manipulation [S5-1]
**File**: `TimeswapPair.sol`
**Function**: `borrow()`
**Issue**: Attacker can increase `pool.state.z` arbitrarily
```
Attack Impact:
- Pool state corruption
- Price manipulation
- Economic breakdown
```

#### H-02: borrowGivenDebt() state.y manipulation [S5-1]
**File**: `TimeswapConvenience.sol`
**Function**: `borrowGivenDebt()`
**Issue**: Can increase `state.y` to extremely large value with dust amount
```
Attack Impact:
- Interest rate manipulation
- Pool becoming unusable
```

#### H-03: Y State Interest Rate Manipulation [S5-1]
**File**: Timeswap core
**Function**: State modification functions
**Issue**: State.y controls interest rates - arbitrary modification possible
**Difficulty**: 4 - Critical for protocol economics

---

## Contest 78 - Behodler

### 📁 Location: `contracts/78/`

#### H-01: assertGovernanceApproved access control [S5-1]
**File**: Look for governance modules
**Function**: `assertGovernanceApproved()` or calling it
**Issue**: Lacks proper access control - allows unauthorized approvals
**Impact**: Funds locked, governance bypassed
**Difficulty**: 3

---

## Contest 83 - Concur 🔴 CRITICAL

### 📁 Location: `contracts/83/`

#### H-03: Repeated Shelter.withdraw drains funds [S5-2]
**File**: `Shelter.sol` or vault contracts
**Function**: `withdraw()`
**Issue**: Repeated calls to withdraw drain entire shelter
```
Attack:
- while (balance > 0) { 
    shelter.withdraw(amount) 
  }
- Result: Complete drain of all funds
```
**Difficulty**: 19 - CRITICAL  
**Impact**: Total fund loss 🔴
```

---

## Contest 104 - JOYN

### 📁 Location: `contracts/104/`

#### H-02: Splitter incrementWindow token theft [S5-3]
**File**: `Splitter.sol` or token distribution
**Function**: `incrementWindow()`
**Issue**: Anyone can call incrementWindow to steal tokens
```
Attack:
- Repeatedly call incrementWindow()
- Steal tokens from contract
```
**Difficulty**: 10

#### H-04: CoreCollection reinitialization [S5-3]
**File**: `CoreCollection.sol` or similar
**Function**: `initialize()` or `init()`
**Issue**: Can be reinitialized multiple times
```
Attack:
- Call init() multiple times
- Reset state variables
- Corruption of contract state
```
**Difficulty**: 12

---

## Contest 113 - AbraNFT

### 📁 Location: `contracts/113/`

#### H-04: Lender seize collateral by parameter change [S5-2]
**File**: Lending contracts
**Function**: Loan parameter modification functions
**Issue**: Lender can change loan parameters to seize collateral
**Impact**: Borrower loses collateral
**Difficulty**: 7

---

## Contest 123 - Aura Protocol

### 📁 Location: `contracts/123/`

#### H-01: User can forfeit other user rewards [S5-1]
**File**: Look for reward contracts
**Function**: `forfeitRewards()` or similar
**Issue**: Can call on behalf of any user without authorization
```
Attack:
- User A calls: forfeitRewards(userB)
- Result: User B loses all rewards
```

---

## Contest 192 - Tigris Protocol

### 📁 Location: `contracts/192/`

#### H-05: Malicious user steal BondNFT assets [S5-1]
**File**: `BondNFT.sol` or similar
**Function**: Asset transfer/redemption function
**Issue**: Missing access control on critical functions
```
Attack:
- Steal all NFT assets from contract
- Complete fund loss from BondNFT
```
**Difficulty**: 6

---

## 🛠️ How to Find These

### Quick Search Strategy:

1. **S5-3 Vulnerabilities (14)** - Missing `onlyDAO` or `onlyOwner`:
   ```
   Search for: "external {" without "only" modifier
   Look for: admin/minting/curation functions
   ```

2. **S5-1 Vulnerabilities (7)** - Parameter abuse:
   ```
   Search for: functions with (address user, ...) parameters
   Check for: msg.sender == user validation
   Look for: state variable direct modification
   ```

3. **S5-2 Vulnerabilities (4)** - Timing issues:
   ```
   Search for: require(block.timestamp
   Look for: epoch/period checks
   Check for: state resets/reinitialization
   ```

### Navigation:

```
Each vulnerability in:
- Report file: /reports/[contestID].md
- Contains links to: github.com/code-423n4/[year]-[month]-[protocol]
- Shows exact GitHub issue number
```

---

## 📝 Summary Table

| Contest | File | Function | Type | Difficulty |
|---------|------|----------|------|-----------|
| 5 | Router.sol | listAnchor() | S5-3 | 1 |
| 5 | Vether.sol | addExcluded() | S5-3 | 1 |
| 5 | Router.sol | curatePool() | S5-3 | 1 |
| 74 | TimeswapPair.sol | borrow() | S5-1 | 1 |
| 83 | Shelter.sol | withdraw() | S5-2 | 19 🔴 |
| 104 | Splitter.sol | incrementWindow() | S5-3 | 10 |

---

**Note**: Exact file paths vary by contest structure. Use the investigation clues above to locate specific contracts. All contracts are located under `contracts/[contestID]/` directory.
