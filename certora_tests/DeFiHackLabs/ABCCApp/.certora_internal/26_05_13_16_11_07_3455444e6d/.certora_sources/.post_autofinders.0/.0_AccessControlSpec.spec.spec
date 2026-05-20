methods {
    function owner() external returns (address) envfree;
}

/// @title Somente owner pode chamar setPartUSDT
rule onlyOwnerCanSetPartUSDT {
    uint target;
    env e;
    setPartUSDT@withrevert(e, target);
    assert !lastReverted => e.msg.sender == owner(),
        "setPartUSDT executou para nao-owner";
}

/// @title Somente owner pode chamar setOperator
rule onlyOwnerCanSetOperator {
    address target;
    bool flag;
    env e;
    setOperator@withrevert(e, target, flag);
    assert !lastReverted => e.msg.sender == owner(),
        "setOperator executou para nao-owner";
}

/// @title Somente owner pode chamar setVaultAddr
rule onlyOwnerCanSetVaultAddr {
    address target;
    env e;
    setVaultAddr@withrevert(e, target);
    assert !lastReverted => e.msg.sender == owner(),
        "setVaultAddr executou para nao-owner";
}

/// @title Somente owner pode chamar setEnable
rule onlyOwnerCanSetEnable {
    bool flag;
    env e;
    setEnable@withrevert(e, flag);
    assert !lastReverted => e.msg.sender == owner(),
        "setEnable executou para nao-owner";
}

/// @title Somente owner pode chamar setSettlePrice
rule onlyOwnerCanSetSettlePrice {
    uint price;
    uint targetTime;
    env e;
    setSettlePrice@withrevert(e, price, targetTime);
    assert !lastReverted => e.msg.sender == owner(),
        "setSettlePrice executou para nao-owner";
}

/// @title Somente owner pode chamar setLevelRate
rule onlyOwnerCanSetLevelRate {
    uint index;
    uint value;
    env e;
    setLevelRate@withrevert(e, index, value);
    assert !lastReverted => e.msg.sender == owner(),
        "setLevelRate executou para nao-owner";
}

/// @title Somente owner pode chamar setClaimFee
rule onlyOwnerCanSetClaimFee {
    uint target;
    env e;
    setClaimFee@withrevert(e, target);
    assert !lastReverted => e.msg.sender == owner(),
        "setClaimFee executou para nao-owner";
}

/// @title Somente owner pode chamar setUserRemainingUSDT
rule onlyOwnerCanSetUserRemainingUSDT {
    address target;
    uint value;
    env e;
    setUserRemainingUSDT@withrevert(e, target, value);
    assert !lastReverted => e.msg.sender == owner(),
        "setUserRemainingUSDT executou para nao-owner";
}

/// @title Somente owner pode chamar addFixedDay
rule onlyOwnerCanAddFixedDay {
    uint target;
    env e;
    addFixedDay@withrevert(e, target);
    assert !lastReverted => e.msg.sender == owner(),
        "addFixedDay executou para nao-owner";
}

/// @title Somente owner pode chamar emergencyFixed
rule onlyOwnerCanEmergencyFixed {
    address targetContract;
    address recipient;
    env e;
    emergencyFixed@withrevert(e, targetContract, recipient);
    assert !lastReverted => e.msg.sender == owner(),
        "emergencyFixed executou para nao-owner";
}
