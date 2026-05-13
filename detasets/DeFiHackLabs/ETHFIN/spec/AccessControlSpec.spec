// AccessControl Specification - EthernalFinanceII
// Hack: ETHFIN
// Fixed by fix_error_hacks.py
// 2026-05-13 15:30 UTC
//
// CONTRACT: EthernalFinanceII
// PRIVILEGED FUNCTION: DistributeRewards
// NOTE: withdraw nao existe; DistributeRewards e a funcao critica
//

methods {
    // --- Privileged function ---
    function DistributeRewards(uint32) external;
}

// --- Rule: DistributeRewards should revert for unauthorized callers ---
// NOTE: This contract has no standard owner(). Adapt the authorization check.
rule DistributeRewards_reverts_for_unauthorized(env e, uint32 val) {
    // TODO: replace 'authorizedAddress' with the actual access control check
    require e.msg.sender != 0;  // placeholder — adapt to real AC mechanism
    DistributeRewards@withrevert(e, val);
    assert lastReverted, "DistributeRewards should be restricted";
}
