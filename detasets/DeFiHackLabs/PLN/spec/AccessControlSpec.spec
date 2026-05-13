// AccessControl Specification - PLNTOKEN
// Hack: PLN
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: PLNTOKEN
// PRIVILEGED FUNCTION: burn
// NOTE: withdraw nao existe; burn e public sem AC
//

methods {
    // --- Privileged function ---
    function burn(address) external;
        function owner() external returns (address) envfree;
}

// --- Rule: only owner can call burn ---
rule onlyOwnerCanCall_burn(env e, address addr) {
    require e.msg.sender != currentContract.owner();
    burn@withrevert(e, addr);
    assert lastReverted, "Unprivileged caller should not call burn";
}

// --- Invariant: zero address is never owner ---
invariant ownerNotZero()
    owner() != 0
    { preserved { require owner() != 0; } }
