// AccessControl Specification - GPv2Settlement
// Hack: CoW
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: GPv2Settlement
// PRIVILEGED FUNCTION: setPreSignature
// NOTE: withdraw nao existe; setPreSignature e a funcao de AC vulnerability
//

methods {
    // --- Privileged function ---
    function setPreSignature(bytes, bool) external;
}

// --- Rule: setPreSignature should revert for unauthorized callers ---
// NOTE: This contract has no standard owner(). Adapt the authorization check.
rule setPreSignature_reverts_for_unauthorized(env e, bytes val, bool flag) {
    // TODO: replace 'authorizedAddress' with the actual access control check
    require e.msg.sender != 0;  // placeholder — adapt to real AC mechanism
    setPreSignature@withrevert(e, val, flag);
    assert lastReverted, "setPreSignature should be restricted";
}
