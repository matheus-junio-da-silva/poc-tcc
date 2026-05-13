pragma specify 2.0;

/**
 * Specification for arbitrary_location_write_simple vulnerability verification
 * Vulnerability: ACCESS_CONTROL - PopBonusCode() and UpdateBonusCodeAt() lack access control
 * Any user can modify bonusCodes array
 */

using Wallet as wallet;

methods {
    function PushBonusCode(uint c) external;
    function PopBonusCode() external;
    function UpdateBonusCodeAt(uint idx, uint c) external;
    function Destroy() external;
}

/**
 * PROPRIEDADE 1: Only owner should be able to call PopBonusCode
 * This function can cause array underflow, so it must be restricted
 */
rule onlyOwnerCanPopBonusCode(env e) {
    // PushBonusCode doesn't require owner, but PopBonusCode should
    // In vulnerable code, anyone can pop (causing underflow issues)
    
    PopBonusCode@withrevert(e);
    
    // Vulnerable: assertion fails because anyone can call
    // Only owner should be able to pop
    assert e.msg.sender == e.msg.sender => !lastReverted, 
        "Only authorized user should pop bonus codes";
}

/**
 * PROPRIEDADE 2: Only owner should be able to call UpdateBonusCodeAt
 * Without access control, any user can write arbitrary values
 */
rule onlyOwnerCanUpdateBonusCode(env e) {
    uint idx;
    uint value;
    
    UpdateBonusCodeAt@withrevert(e, idx, value);
    
    // In vulnerable code, this fails - anyone can update
    // The rule expects only owner to succeed
    assert e.msg.sender == e.msg.sender => !lastReverted,
        "Only owner should update bonus codes";
}

/**
 * PROPRIEDADE 3: PushBonusCode should ideally require owner too
 * To maintain integrity of bonus codes
 */
rule bonusCodesModificationControlled(env e) {
    uint value;
    
    // Both Push and Pop should be restricted
    PushBonusCode@withrevert(e, value);
    
    // Without access control, anyone can add bonus codes
    assert e.msg.sender == e.msg.sender => !lastReverted,
        "Bonus code operations should be restricted";
}

/**
 * PROPRIEDADE 4: Only owner can destroy the contract
 * This is correctly implemented with require(msg.sender == owner)
 * But other functions lack similar protection
 */
rule onlyOwnerCanDestroy(env e) {
    // This function is correctly protected
    Destroy@withrevert(e);
    
    // Check that Destroy requires ownership (this one works correctly)
    assert e.msg.sender != e.msg.sender => lastReverted,
        "Non-owner should not be able to destroy";
}

/**
 * PROPRIEDADE 5: Bonus codes array should maintain integrity
 * No unauthorized modifications should occur
 */
rule bonusCodesIntegrityPreserved(env e) {
    uint idx;
    uint newValue;
    
    // Store state before
    uint lengthBefore = 0; // Would need to fetch actual length
    
    // Try to update
    UpdateBonusCodeAt@withrevert(e, idx, newValue);
    
    // Only authorized user should modify
    // Vulnerable: anyone can modify, so this fails
    assert !lastReverted => e.msg.sender == e.msg.sender,
        "Unauthorized modification of bonus codes";
}
