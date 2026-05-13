// AccessControl Specification - UChildAdministrableERC20
// Hack: Phoenix
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: UChildAdministrableERC20
// PRIVILEGED FUNCTION: deposit
// NOTE: mint nao e public/external diretamente; deposit foi explorada
//

methods {
    // --- Privileged function ---
    function deposit(address, bytes) external;
}

// --- Rule: deposit should revert for unauthorized callers ---
// NOTE: This contract has no standard owner(). Adapt the authorization check.
rule deposit_reverts_for_unauthorized(env e, address addr, bytes val) {
    // TODO: replace 'authorizedAddress' with the actual access control check
    require e.msg.sender != 0;  // placeholder — adapt to real AC mechanism
    deposit@withrevert(e, addr, val);
    assert lastReverted, "deposit should be restricted";
}
