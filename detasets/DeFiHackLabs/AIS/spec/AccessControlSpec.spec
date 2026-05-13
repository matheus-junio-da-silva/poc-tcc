// AccessControl Specification - AISPACE
// Hack: AIS
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: AISPACE
// PRIVILEGED FUNCTION: setMarketAddress
// NOTE: setAdmin nao existe; setMarketAddress e funcao privilegiada real
//

methods {
    // --- Privileged function ---
    function setMarketAddress(address) external;
        function owner() external returns (address) envfree;
}

// --- Rule: only owner can call setMarketAddress ---
rule onlyOwnerCanCall_setMarketAddress(env e, address addr) {
    require e.msg.sender != currentContract.owner();
    setMarketAddress@withrevert(e, addr);
    assert lastReverted, "Unprivileged caller should not call setMarketAddress";
}

// --- Invariant: zero address is never owner ---
invariant ownerNotZero()
    owner() != 0
    { preserved { require owner() != 0; } }
