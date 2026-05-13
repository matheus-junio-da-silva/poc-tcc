# Deep Check Report — AC Dataset for Certora

**Generated:** 2026-05-13 15:30 UTC  
**Total checked:** 41  
**Ready for certoraRun:** 37  
**With errors:** 4  

## Hacks Ready for Certora

| Hack | Contract | Function | Chain | Proxy | Warnings |
|------|----------|----------|-------|-------|----------|
| 88mph_NFT | `NFT` | `transferOwnership` | ethereum | no | 11 |
| ABCCApp | `ABCCApp` | `transfer` | bsc | no | 3 |
| ADC | `Vault` | `withdraw` | ethereum | no | 10 |
| AIS | `AISPACE` | `setMarketAddress` | bsc | no | 5 |
| Ak1111 | `AkashaOFT` | `owner` | bsc | no | 8 |
| BRAND | `PancakePair` | `transfer` | bsc | no | 2 |
| BabySwap | `SwapMining` | `addWhitelist` | bsc | no | 2 |
| Bancor_Protocol | `XBPToken` | `transfer` | ethereum | no | 3 |
| CIVNFT | `TransparentUpgradeableProxy` | `upgradeTo` | ethereum | YES | 6 |
| DAO_Maker | `ERC20` | `transfer` | ethereum | YES | 3 |
| FILX_DN404 | `LinearVesting` | `init` | ethereum | YES | 7 |
| FPR | `BEP20FPR` | `setPairAddr` | bsc | no | 3 |
| GYMNetwork | `GymRouter` | `initialize` | bsc | YES | 12 |
| HPAY | `MintableAutoCompundRelockBonus` | `withdraw` | bsc | no | 14 |
| INUMI_db27 | `ERC677InitializableTokenV2` | `burn` | ethereum | YES | 7 |
| LocalTrade | `LCTExchange` | `owner` | bsc | no | 4 |
| Melo | `cERC20` | `mint` | bsc | no | 1 |
| MetaPool | `TransparentUpgradeableProxy` | `upgradeTo` | ethereum | YES | 8 |
| NGFS | `NGFSToken` | `transfer` | bsc | no | 2 |
| PLN | `PLNTOKEN` | `burn` | ethereum | no | 1 |
| Parity_Multisig | `IntrospectionToken` | `transfer` | bsc | no | 1 |
| Pledge | `Pledge` | `transfer` | bsc | no | 1 |
| Rikkei_Finance | `BEP20TokenImplementation` | `transfer` | bsc | YES | 6 |
| Sandbox_LAND | `Land` | `burn` | ethereum | no | 2 |
| ShadowFi | `ShadowFi` | `burn` | bsc | no | 1 |
| SizeCredit | `LeverageUp` | `validateInitialize` | ethereum | no | 18 |
| Stead | `TransparentUpgradeableProxy` | `owner` | arbitrum | YES | 11 |
| SuperRare | `RareStakingV1` | `initialize` | ethereum | no | 11 |
| SwapX | `Diamond` | `owner` | bsc | no | 3 |
| Templedao | `StaxLPStaking` | `withdraw` | ethereum | no | 3 |
| TokenHolder | `BorrowerOperationsV6` | `initialize` | bsc | no | 7 |
| ULME | `UniverseGoldMountain` | `transfer` | bsc | no | 2 |
| USDTStakingContract28 | `TetherToken` | `transfer` | ethereum | no | 4 |
| Uerii_Token | `Token` | `mint` | ethereum | no | 1 |
| Unverified_0x6077 | `D3MM` | `owner` | bsc | no | 7 |
| Unverified_54cd | `ERC1967Proxy` | `upgradeTo` | ethereum | YES | 9 |
| wKeyDAO | `WebKeyProSales` | `owner` | bsc | YES | 14 |

## Hacks with Errors

| Hack | Error | Fix |
|------|-------|-----|
| CoW | owner() nao declarado no bloco methods | Adicionar: function owner() external returns (address) envfree; |
| ETHFIN | owner() nao declarado no bloco methods | Adicionar: function owner() external returns (address) envfree; |
| GROKD | Funcao 'upgradeTo' NAO encontrada no source | Funcoes similares encontradas: ['upgradeToAndCall', 'upgradeBeaconToAndCall'] |
| GROKD | owner() nao encontrada - spec usa currentContract.owner() | Adaptar spec para usar o mecanismo de AC real do contrato |
| GROKD | owner() nao declarado no bloco methods | Adicionar: function owner() external returns (address) envfree; |
| Phoenix | owner() nao declarado no bloco methods | Adicionar: function owner() external returns (address) envfree; |

## How to Run

```bash
# Run a single hack
cd ac_dataset/<HackName>
certoraRun certora.conf

# Or from the dataset root:
certoraRun ac_dataset/Templedao/certora.conf
```