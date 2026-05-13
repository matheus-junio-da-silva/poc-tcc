// AccessControl Specification - BEP20FPR
// Hack: FPR
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: BEP20FPR
// PRIVILEGED FUNCTION: setPairAddr
// NOTE: setAdmin nao existe; setPairAddr permite alterar par sem restricao
//

methods {
    // --- Privileged function ---
    function setPairAddr(address) external;
        function owner() external returns (address) envfree;
}

// --- Rule: only owner can call setPairAddr ---
rule onlyOwnerCanCall_setPairAddr(env e, address addr) {
    require e.msg.sender != currentContract.owner();
    setPairAddr@withrevert(e, addr);
    assert lastReverted, "Unprivileged caller should not call setPairAddr";
}

// --- Invariant: zero address is never owner ---
invariant ownerNotZero()
    owner() != 0
    { preserved { require owner() != 0; } }
