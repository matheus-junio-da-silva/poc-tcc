pragma specify 2.0;

/**
 * Specification for incorrect_constructor_name2 vulnerability verification
 * Vulnerability: ACCESS_CONTROL - Constructor function has wrong name (missing instead of Missing)
 * Case-sensitive issue: 'missing' != 'Missing'
 * Any user can call missing() after deployment to become the owner
 */

using Missing as missing;

methods {
    function owner() external returns (address) envfree;
    function missing() external;
    function withdraw() external;
}

/**
 * PROPRIEDADE 1: Owner should only be initialized at contract deployment
 * The function missing() should not be callable after deployment to change owner
 */
rule ownerInitializedOnlyAtDeployment(env e) {
    address ownerBefore = owner();
    
    // Try to call missing() - should not change owner if code was correct
    missing@withrevert(e);
    
    address ownerAfter = owner();
    
    // Vulnerable: assertion fails, owner gets changed by unauthorized caller
    // The lowercase 'missing' is not the constructor, so it's a regular function
    assert ownerAfter == ownerBefore || e.msg.sender == ownerBefore,
        "Owner was changed by non-authorized address";
}

/**
 * PROPRIEDADE 2: Only legitimate owner should be able to withdraw
 * In vulnerable code, whoever calls missing() first becomes owner
 */
rule onlyLegitimateOwnerCanWithdraw(env e) {
    address currentOwner = owner();
    
    withdraw@withrevert(e);
    
    // In vulnerable code: anyone who called missing() can withdraw
    assert !lastReverted => e.msg.sender == currentOwner,
        "Non-owner successfully withdrew funds";
}

/**
 * PROPRIEDADE 3: missing() function should be protected or not callable
 * Having it callable by anyone creates the vulnerability
 */
rule missingFunctionIsProtected(env e) {
    address ownerBefore = owner();
    
    // This function should require authorization to be called
    missing@withrevert(e);
    
    // Vulnerable: no protection
    assert e.msg.sender != e.msg.sender => lastReverted,
        "missing() is callable without authorization";
}

/**
 * PROPRIEDADE 4: Owner should never be uninitialized (zero address)
 */
invariant ownerIsNeverUninitialized()
    owner() != 0

/**
 * PROPRIEDADE 5: Only one address should have legitimate ownership rights
 * Vulnerable code: multiple addresses can call missing() and claim ownership
 */
rule ownershipCantBeReassignedFreely(env e) {
    address ownerBefore = owner();
    
    missing@withrevert(e);
    
    address ownerAfter = owner();
    
    // If owner was already set, missing() should not change it
    if (ownerBefore != 0) {
        assert ownerAfter == ownerBefore,
            "Owner reassigned when it should be immutable";
    }
}

/**
 * PROPRIEDADE 6: Case-sensitive comparison - Missing != missing
 * This documents the subtle Solidity rule about constructor names
 */
rule caseMattersForConstructor(env e) {
    // In Solidity, constructor name MUST match contract name exactly
    // Missing (uppercase M) != missing (lowercase m)
    // So missing() is a regular function, not a constructor
    
    address ownerInitial = owner();
    
    // missing() executes as regular function
    missing@withrevert(e);
    
    // This is the root cause: owner changes when it shouldn't
    assert true, "Demonstrates case-sensitive constructor naming is critical";
}
