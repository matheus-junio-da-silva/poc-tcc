// AccessControl Specification - SwapMining
// Hack: BabySwap
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: SwapMining
// PRIVILEGED FUNCTION: addWhitelist
// NOTE: withdraw pertence ao LP, nao ao contrato vulneravel; addWhitelist e a funcao AC
//

methods {
    // --- Privileged function ---
    function addWhitelist(address) external;
        function owner() external returns (address) envfree;
}

// --- Rule: only owner can call addWhitelist ---
rule onlyOwnerCanCall_addWhitelist(env e, address addr) {
    require e.msg.sender != currentContract.owner();
    addWhitelist@withrevert(e, addr);
    assert lastReverted, "Unprivileged caller should not call addWhitelist";
}

// --- Invariant: zero address is never owner ---
invariant ownerNotZero()
    owner() != 0
    { preserved { require owner() != 0; } }
