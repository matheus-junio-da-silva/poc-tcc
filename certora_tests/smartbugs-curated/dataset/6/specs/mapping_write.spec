pragma specify 2.0;

/**
 * Specification for mapping_write vulnerability verification
 * Vulnerability: ACCESS_CONTROL - set() function can be called by anyone to write to map
 * Allows arbitrary modification of internal data structure
 */

using Map as mapContract;

methods {
    function set(uint256 key, uint256 value) external;
    function get(uint256 key) external returns (uint256) envfree;
    function withdraw() external;
    function owner() external returns (address) envfree;
}

/**
 * PROPRIEDADE 1: Only owner should be able to call set()
 * In vulnerable code, anyone can write to the map
 */
rule onlyOwnerCanCallSet(env e) {
    uint256 key;
    uint256 value;
    
    set@withrevert(e, key, value);
    
    // Vulnerable: assertion fails because anyone can call
    // Only owner should be allowed to write to map
    assert e.msg.sender == owner() => !lastReverted,
        "Non-owner was able to write to map";
}

/**
 * PROPRIEDADE 2: Unauthorized users cannot modify map values
 * Ensures data integrity is preserved
 */
rule unauthorizedCannotModifyMap(env e) {
    uint256 key;
    uint256 oldValue = get(key);
    
    uint256 newValue;
    set@withrevert(e, key, newValue);
    
    // Check if unauthorized user succeeded in writing
    uint256 valueAfter = get(key);
    
    // In vulnerable code: anyone can modify, assertion fails
    // Expected: only owner can modify, others' modifications fail
    assert valueAfter == oldValue || e.msg.sender == owner(),
        "Unauthorized user modified map value";
}

/**
 * PROPRIEDADE 3: Map length manipulation should be restricted
 * The function can expand map.length arbitrarily
 */
rule mapLengthExpansionIsControlled(env e) {
    uint256 key;
    uint256 value;
    
    // Calling set with large key can expand map.length dangerously
    // This should only be allowed for authorized users
    set@withrevert(e, key, value);
    
    // Vulnerable: anyone can expand map causing DOS
    assert e.msg.sender == owner() => !lastReverted,
        "Unauthorized user expanded map";
}

/**
 * PROPRIEDADE 4: Only owner should be able to withdraw
 * This is correctly implemented with require check
 * But data corruption via set() undermines this
 */
rule onlyOwnerCanWithdraw(env e) {
    withdraw@withrevert(e);
    
    assert e.msg.sender != owner() => lastReverted,
        "Non-owner called withdraw";
}

/**
 * PROPRIEDADE 5: Map should maintain data integrity
 * No unauthorized writes should occur
 */
rule mapDataIntegrityPreserved(env e) {
    uint256 keyToCheck;
    uint256 valueInitial = get(keyToCheck);
    
    // Arbitrary set operation
    uint256 keyToSet;
    uint256 valueToSet;
    set@withrevert(e, keyToSet, valueToSet);
    
    // Check that only authorized modifications occurred
    uint256 valueAfter = get(keyToCheck);
    
    // Vulnerable: anyone can change any value
    if (keyToSet == keyToCheck) {
        assert !lastReverted => e.msg.sender == owner(),
            "Unauthorized user modified map";
    }
}

/**
 * PROPRIEDADE 6: set() function behavior should be consistent with access control
 * Should revert for non-authorized users
 */
rule setFunctionAccessControl(env e) {
    uint256 key;
    uint256 value;
    
    // Non-owner calls should revert
    if (e.msg.sender != owner()) {
        set@withrevert(e, key, value);
        // Vulnerable: doesn't revert
        assert lastReverted,
            "set() succeeded for non-owner, violating access control";
    } else {
        // Owner calls should succeed
        set@withrevert(e, key, value);
        assert !lastReverted,
            "set() reverted for owner";
    }
}
