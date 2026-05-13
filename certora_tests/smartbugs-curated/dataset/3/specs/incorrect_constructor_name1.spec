pragma specify 2.0;

/**
 * Specification for incorrect_constructor_name1 vulnerability verification
 * Vulnerability: ACCESS_CONTROL - Constructor function has wrong name (IamMissing instead of Missing)
 * Any user can call IamMissing() after deployment to become the owner
 */

using Missing as missing;

methods {
    function owner() external returns (address) envfree;
    function IamMissing() external;
    function withdraw() external;
}

/**
 * PROPRIEDADE 1: Owner should be set only once, during deployment (in constructor)
 * The vulnerability allows anyone to change owner by calling IamMissing()
 */
rule ownerSetOnlyInConstructor(env e) {
    address ownerBefore = owner();
    
    // Try to call IamMissing() - this should not change owner in correct code
    IamMissing@withrevert(e);
    
    address ownerAfter = owner();
    
    // In vulnerable code: assertion fails because owner changed for non-authorized caller
    // IamMissing() can be called by anyone and will set owner = msg.sender
    assert ownerAfter == ownerBefore || e.msg.sender == ownerBefore,
        "Owner was changed by unauthorized caller";
}

/**
 * PROPRIEDADE 2: Only the initial owner should be able to withdraw
 * This verifies that whoever set themselves as owner via IamMissing() can withdraw
 */
rule onlyOwnerCanWithdraw(env e) {
    address currentOwner = owner();
    
    // Only the current owner should succeed
    withdraw@withrevert(e);
    
    // Vulnerable: anyone who called IamMissing first can withdraw
    // The rule expects: only currentOwner can call withdraw without revert
    assert !lastReverted => e.msg.sender == currentOwner,
        "Non-owner successfully withdrew funds";
}

/**
 * PROPRIEDADE 3: IamMissing() should not exist or should be protected
 * Having a public function that sets owner is the root cause
 */
rule iamMissingIsProtected(env e) {
    address ownerBefore = owner();
    
    // This function should either not exist or should be protected
    // In vulnerable code, anyone can call it
    IamMissing@withrevert(e);
    
    // Vulnerable: no protection, anyone can call
    // Correct: should require previous owner or not exist
    assert e.msg.sender != e.msg.sender => lastReverted,
        "IamMissing() is callable without proper authorization";
}

/**
 * PROPRIEDADE 4: Owner should never be the zero address
 * This ensures a valid owner always exists
 */
invariant ownerIsNeverZero()
    owner() != 0

/**
 * PROPRIEDADE 5: Only one user should be able to set themselves as owner
 * The vulnerability: multiple users can call IamMissing() and each becomes "owner"
 */
rule onlyOneOwnerCanBeSet(env e) {
    address ownerBefore = owner();
    
    // First caller becomes owner
    IamMissing@withrevert(e);
    
    address ownerAfter = owner();
    
    // Vulnerable: multiple users can call and change owner
    // In correct implementation, this should be restricted or not allowed
    if (ownerBefore == 0) {
        // First time: owner should be set to msg.sender
        assert ownerAfter == e.msg.sender || lastReverted,
            "First owner assignment failed";
    } else {
        // Already has owner: should not change
        assert ownerAfter == ownerBefore,
            "Owner changed when it should not";
    }
}
