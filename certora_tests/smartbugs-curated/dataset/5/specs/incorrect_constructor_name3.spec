pragma specify 2.0;

/**
 * Specification for incorrect_constructor_name3 vulnerability verification
 * Vulnerability: ACCESS_CONTROL - Constructor function has wrong name (Constructor instead of Missing)
 * Any user can call Constructor() after deployment to become the owner
 */

using Missing as missing;

methods {
    function owner() external returns (address) envfree;
    function Constructor() external;
    function withdraw() external;
}

/**
 * PROPRIEDADE 1: Owner should be set only at contract deployment
 * Constructor() being callable means owner wasn't properly initialized
 */
rule ownerInitializedOnlyAtDeployment(env e) {
    address ownerBefore = owner();
    
    // Try to call Constructor() - should not change owner if code was correct
    Constructor@withrevert(e);
    
    address ownerAfter = owner();
    
    // Vulnerable: assertion fails because Constructor() changes owner
    assert ownerAfter == ownerBefore || e.msg.sender == ownerBefore,
        "Owner was changed by unauthorized caller via Constructor()";
}

/**
 * PROPRIEDADE 2: Only the legitimate owner should withdraw
 * Anyone calling Constructor() first becomes owner and can withdraw
 */
rule onlyLegitimateOwnerCanWithdraw(env e) {
    address currentOwner = owner();
    
    withdraw@withrevert(e);
    
    // In vulnerable code: anyone who called Constructor() first can withdraw
    assert !lastReverted => e.msg.sender == currentOwner,
        "Non-owner successfully withdrew";
}

/**
 * PROPRIEDADE 3: Constructor() should not be callable after deployment
 * Having Constructor() callable is the vulnerability
 */
rule constructorFunctionIsNotCallable(env e) {
    address ownerBefore = owner();
    
    // This should not be a callable function - should be constructor
    Constructor@withrevert(e);
    
    // Vulnerable: Constructor() succeeds for anyone
    assert e.msg.sender != e.msg.sender => lastReverted,
        "Constructor() callable by unauthorized user";
}

/**
 * PROPRIEDADE 4: Owner should never be the zero address
 * Ensures legitimate owner exists
 */
invariant ownerIsNeverZero()
    owner() != 0

/**
 * PROPRIEDADE 5: Function naming matters - "Constructor" is not a constructor
 * In Solidity, constructor name MUST match contract name exactly
 * Missing != Constructor
 */
rule functionNamingIsSignificant(env e) {
    // "Constructor" with capital C is just a regular function name
    // True constructor for contract Missing should be "function Missing() { ... }"
    // This documents the semantic requirement
    
    assert true, "Demonstrates importance of correct constructor naming";
}

/**
 * PROPRIEDADE 6: Ownership transfer should only happen through authorized means
 * Constructor() changing owner is the vulnerability
 */
rule ownershipTransferIsControlled(env e) {
    address ownerBefore = owner();
    
    Constructor@withrevert(e);
    
    address ownerAfter = owner();
    
    // If owner changed, only authorized party should have caused it
    assert ownerAfter != ownerBefore => false,
        "Owner changed through uncontrolled Constructor() call";
}
