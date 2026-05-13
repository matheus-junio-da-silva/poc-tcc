# Access Control Dataset - DeFiHackLabs -> Certora

**Generated:** 2026-05-12 17:11 UTC  
**Total hacks:** 87  
**With PoC:** 86  
**Without PoC:** 1  
**Proxy contracts:** 5  

## Distribution by Chain

| Chain | Incidents |
|-------|-----------|
| bsc | 41 |
| ethereum | 39 |
| unknown | 4 |
| fantom | 1 |
| polygon | 1 |
| arbitrum | 1 |

## All Hacks (sorted by date)

| # | Date | Name | Chain | Proxy | PoC | Description |
|---|------|------|-------|-------|-----|-------------|
| 1 | 20170719 | **Parity_Multisig** | bsc | no | `IT_exp.sol` | delegatecall to unprotected initwallet |
| 2 | 20200618 | **Bancor_Protocol** | ethereum | no | `Bancor_exp.sol` | access control |
| 3 | 20210607 | **88mph_NFT** | ethereum | no | `88mph_exp.sol` | access control |
| 4 | 20210903 | **DAO_Maker** | ethereum | PROXY | `DaoMaker_exp.sol` | bad access controal |
| 5 | 20220208 | **Sandbox_LAND** | ethereum | no | `Sandbox_exp.sol` | access control |
| 6 | 20220415 | **Rikkei_Finance** | bsc | no | `Rikkei_exp.sol` | access control  price oracle manipulation |
| 7 | 20220608 | **GYMNetwork** | bsc | no | `GYMNET_exp.sol` | accesscontrol |
| 8 | 20220706 | **FlippazOne_NFT** | ethereum | no | `FlippazOne_exp.sol` | accesscontrol |
| 9 | 20220801 | **Reaper_Farm** | fantom | no | `ReaperFarm_exp.sol` | business logic flaw  lack of access control mechanism |
| 10 | 20220902 | **ShadowFi** | bsc | no | `Shadowfi_exp.sol` | access control |
| 11 | 20220908 | **Ragnarok_Online_Invasion** | unknown | no | (none) | broken access control |
| 12 | 20221001 | **BabySwap** | bsc | no | `BabySwap_exp.sol` | parameter access control |
| 13 | 20221011 | **Templedao** | ethereum | no | `Templedao_exp.sol` | insufficient access control |
| 14 | 20221017 | **Uerii_Token** | ethereum | no | `Uerii_exp.sol` | access control |
| 15 | 20221018 | **HPAY** | bsc | no | `HPAY_exp.sol` | access control |
| 16 | 20221025 | **ULME** | bsc | no | `ULME_exp.sol` | access control |
| 17 | 20221129 | **MBC___ZZSH** | bsc | no | `MBC_ZZSH_exp.sol` | mbc  zzsh   business logic flaw  access control |
| 18 | 20221214 | **FPR** | bsc | no | `FPR_exp.sol` | fpr   access control |
| 19 | 20230227 | **LaunchZone** | bsc | no | `LaunchZone_exp.sol` | launchzone   access control |
| 20 | 20230227 | **SwapX** | bsc | no | `SwapX_exp.sol` | swapx   access control |
| 21 | 20230307 | **Phoenix** | polygon | no | `Phoenix_exp.sol` | phoenix   access control  arbitrary external call |
| 22 | 20230506 | **Melo** | bsc | no | `Melo_exp.sol` | access control |
| 23 | 20230524 | **LocalTrade** | bsc | no | `LocalTrader2_exp.sol` | improper access control of close source contract |
| 24 | 20230615 | **DEPUSDT_LEVUSDC** | ethereum | no | `DEPUSDT_LEVUSDC_exp.sol` | incorrect access control |
| 25 | 20230708 | **CIVNFT** | ethereum | no | `CIVNFT_exp.sol` | lack of access control |
| 26 | 20230708 | **Civfund** | ethereum | no | `Civfund_exp.sol` | lack of access control |
| 27 | 20230715 | **USDTStakingContract28** | ethereum | no | `USDTStakingContract28_exp.sol` | lack of access control |
| 28 | 20230801 | **LeetSwap** | unknown | no | `Leetswap_exp.sol` | access control |
| 29 | 20230921 | **CEXISWAP** | ethereum | PROXY | `CEXISWAP_exp.sol` | incorrect access control |
| 30 | 20231102 | **BRAND** | bsc | no | `BRAND_exp.sol` | lack of access control |
| 31 | 20231107 | **MEVbot** | bsc | no | `BNB48MEVBot_exp.sol` | lack of access control |
| 32 | 20231112 | **MEV_0x8c2d** | bsc | no | `MEV_0x8c2d_exp.sol` | lack of access control |
| 33 | 20231112 | **MEV_0xa247** | ethereum | no | `MEV_0xa247_exp.sol` | incorrect access control |
| 34 | 20231129 | **AIS** | bsc | no | `AIS_exp.sol` | access control |
| 35 | 20240110 | **Freedom** | bsc | no | `Freedom_exp.sol` | lack of access control |
| 36 | 20240115 | **Shell_MEV_0xa898** | bsc | no | `Shell_MEV_0xa898_exp.sol` | lack of access control |
| 37 | 20240122 | **DAO_SoulMate** | ethereum | no | `DAO_SoulMate_exp.sol` | incorrect access control |
| 38 | 20240202 | **ADC** | ethereum | no | `ADC_exp.sol` | incorrect access control |
| 39 | 20240210 | **FILX_DN404** | ethereum | no | `DN404_exp.sol` | access control |
| 40 | 20240320 | **Paraswap** | ethereum | no | `Paraswap_exp.sol` | incorrect access control |
| 41 | 20240323 | **CGT** | ethereum | no | `CGT_exp.sol` | incorrect access control |
| 42 | 20240329 | **ETHFIN** | bsc | no | `ETHFIN_exp.sol` | lack of access control |
| 43 | 20240412 | **GROKD** | bsc | no | `GROKD_exp.sol` | lack of access control |
| 44 | 20240425 | **NGFS** | bsc | no | `NGFS_exp.sol` | bad access control |
| 45 | 20240510 | **GFOX** | ethereum | no | `GFOX_exp.sol` | lack of access control |
| 46 | 20240529 | **MetaDragon** | bsc | no | `MetaDragon_exp.sol` | lack of access control |
| 47 | 20240601 | **VeloCore** | unknown | no | `Velocore_exp.sol` | lack of access control |
| 48 | 20240703 | **UnverifiedContr_0x452E25** | ethereum | no | `UnverifiedContr_0x452E25_exp.sol` | lack of access control |
| 49 | 20240711 | **GAX** | bsc | no | `GAX_exp.sol` | lack of access control |
| 50 | 20240828 | **Unverified_667d** | bsc | no | `unverified_667d_exp.sol` | access control |
| 51 | 20240904 | **Unverified_16d0** | ethereum | no | `unverified_16d0.sol` | access control |
| 52 | 20240905 | **Unverified_a89f** | ethereum | no | `unverified_a89f_exp.sol` | access control |
| 53 | 20240905 | **PLN** | ethereum | no | `PLN_exp.sol` | access control |
| 54 | 20240911 | **INUMI** | ethereum | no | `INUMI_exp.sol` | access control |
| 55 | 20240911 | **INUMI_db27** | ethereum | no | `NUM_exp.sol` | access control |
| 56 | 20240911 | **AIRBTC** | bsc | no | `AIRBTC_exp.sol` | access control |
| 57 | 20240912 | **Unverified_03f9** | ethereum | no | `unverified_03f9_exp.sol` | access control |
| 58 | 20240913 | **Unverified_5697** | ethereum | no | `unverified_5697_exp.sol` | access control |
| 59 | 20240918 | **Unverified_766a** | bsc | no | `unverified_766a_exp.sol` | access control |
| 60 | 20240920 | **Shezmu** | ethereum | no | `Shezmu_exp.sol` | access control |
| 61 | 20241022 | **Erc20transfer** | ethereum | no | `Erc20transfer_exp.sol` | access control |
| 62 | 20241107 | **CoW** | ethereum | no | `CoW_exp.sol` | access control |
| 63 | 20241109 | **X319** | bsc | no | `X319_exp.sol` | access control |
| 64 | 20241120 | **MainnetSettler** | ethereum | no | `MainnetSettler_exp.sol` | access control |
| 65 | 20241123 | **Ak1111** | bsc | no | `Ak1111_exp.sol` | access control |
| 66 | 20241126 | **NFTG** | bsc | no | `NFTG_exp.sol` | access control |
| 67 | 20241203 | **Pledge** | bsc | no | `Pledge_exp.sol` | access control |
| 68 | 20250108 | **HORS** | bsc | no | `HORS_exp.sol` | access control |
| 69 | 20250215 | **unverified_d4f1** | bsc | PROXY | `unverified_d4f1_exp.sol` | access control |
| 70 | 20250316 | **wKeyDAO** | bsc | no | `wKeyDAO_exp.sol` | unprotected function |
| 71 | 20250404 | **AIRWA** | bsc | no | `AIRWA_exp.sol` | access control |
| 72 | 20250411 | **Unverified_0x6077** | bsc | no | `UN_exp.sol` | lack of access control |
| 73 | 20250514 | **Unwarp** | unknown | no | `Unwarp_exp.sol` | lack of access control |
| 74 | 20250524 | **RICE** | ethereum | no | `RICE_exp.sol` | lack of access control |
| 75 | 20250528 | **Corkprotocol** | ethereum | no | `Corkprotocol_exp.sol` | access control |
| 76 | 20250610 | **unverified_8490** | bsc | PROXY | `unverified_8490_exp.sol` | access control |
| 77 | 20250617 | **MetaPool** | ethereum | no | `MetaPool_exp.sol` | access control |
| 78 | 20250625 | **Unverified_b5cb** | bsc | PROXY | `unverified_b5cb_exp.sol` | access control |
| 79 | 20250629 | **Stead** | arbitrum | no | `Stead_exp.sol` | access control |
| 80 | 20250705 | **Unverified_54cd** | ethereum | no | `unverified_54cd_exp.sol` | access control |
| 81 | 20250728 | **SuperRare** | ethereum | no | `SuperRare_exp.sol` | access control |
| 82 | 20250815 | **SizeCredit** | ethereum | no | `SizeCredit_exp.sol` | access control |
| 83 | 20250820 | **MulticallWithXera** | bsc | no | `MulticallWithXera_exp.sol` | access control |
| 84 | 20250820 | **0x8d2e** | ethereum | no | `0x8d2e_exp.sol` | access control |
| 85 | 20250823 | **ABCCApp** | bsc | no | `ABCCApp_exp.sol` | lack of access control |
| 86 | 20250827 | **0xf340** | ethereum | no | `0xf340_exp.sol` | access control |
| 87 | 20251007 | **TokenHolder** | bsc | no | `TokenHolder_exp.sol` | access control |

## Dataset Structure

```
ac_dataset/
  <HackName>/
    poc/                    <- Foundry PoC from DeFiHackLabs
    spec/
      AccessControlSpec.spec  <- CVL spec for Certora (adapt)
    certora.conf            <- Certora config (adapt)
    metadata.json           <- hack data + proxy info
  dataset_summary.json
  dataset_report.md
```

## Usage with Certora

```bash
# For each hack in the dataset:
cd ac_dataset/<HackName>

# 1. Place the vulnerable contract source in contracts/
#    (download via Etherscan/Blockscout using poc_source from metadata.json)

# 2. Adapt spec/AccessControlSpec.spec
#    - Replace <ContractName> and <privileged_function>

# 3. For proxies (is_proxy=true), add the implementation contract
#    and adjust prover_args in certora.conf

# 4. Run the Certora Prover
certoraRun certora.conf
```

## Notes on Proxy Contracts

Hacks marked as PROXY involve a proxy pattern. Considerations:

- **Storage Collision:** proxy storage slot may collide with implementation
- **Uninitialized Proxy:** initialize() can be called by anyone if not protected
- **UUPSUpgradeable:** upgradeTo authorization logic must live in the implementation
- **In Certora:** use --link Contract:impl=Implementation to verify implementation
- **EIP-1967:** ensures the implementation slot is not overwritten