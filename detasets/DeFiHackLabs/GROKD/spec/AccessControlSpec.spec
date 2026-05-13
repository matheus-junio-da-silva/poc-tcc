// AccessControl Specification - ERC1967Proxy
// Hack: GROKD
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: ERC1967Proxy
// PRIVILEGED FUNCTION: upgradeTo
// NOTE: Proxy ERC1967: so tem implementation(); funcao critica e upgradeTo
//

methods {
    // --- Privileged function ---
    function upgradeTo() external;
}

// --- Rule: upgradeTo should revert for unauthorized callers ---
// NOTE: This contract has no standard owner(). Adapt the authorization check.
rule upgradeTo_reverts_for_unauthorized(env e) {
    // TODO: replace 'authorizedAddress' with the actual access control check
    require e.msg.sender != 0;  // placeholder — adapt to real AC mechanism
    upgradeTo@withrevert(e);
    assert lastReverted, "upgradeTo should be restricted";
}
