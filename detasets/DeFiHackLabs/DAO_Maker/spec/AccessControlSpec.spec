// AccessControl Specification - ERC20
// Hack: DAO_Maker
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: ERC20
// PRIVILEGED FUNCTION: transfer
// NOTE: init nao existe como funcao publica; transfer foi explorada
//

methods {
    // --- Privileged function ---
    function transfer(address, uint256) external;
        function owner() external returns (address) envfree;
}

// --- Rule: only owner can call transfer ---
rule onlyOwnerCanCall_transfer(env e, address addr, uint256 amount) {
    require e.msg.sender != currentContract.owner();
    transfer@withrevert(e, addr, amount);
    assert lastReverted, "Unprivileged caller should not call transfer";
}

// --- Invariant: zero address is never owner ---
invariant ownerNotZero()
    owner() != 0
    { preserved { require owner() != 0; } }
