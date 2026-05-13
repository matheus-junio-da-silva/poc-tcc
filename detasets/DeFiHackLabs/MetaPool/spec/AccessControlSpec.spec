// AccessControl Specification - TransparentUpgradeableProxy
// Hack: MetaPool
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: TransparentUpgradeableProxy
// PRIVILEGED FUNCTION: upgradeTo
// NOTE: Proxy: upgradeTo disponivel sem restricao adequada
//

methods {
    // --- Privileged function ---
    function upgradeTo(address) external;
        function owner() external returns (address) envfree;
}

// --- Rule: only owner can call upgradeTo ---
rule onlyOwnerCanCall_upgradeTo(env e, address addr) {
    require e.msg.sender != currentContract.owner();
    upgradeTo@withrevert(e, addr);
    assert lastReverted, "Unprivileged caller should not call upgradeTo";
}

// --- Invariant: zero address is never owner ---
invariant ownerNotZero()
    owner() != 0
    { preserved { require owner() != 0; } }
