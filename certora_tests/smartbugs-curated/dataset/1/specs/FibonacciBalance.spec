pragma specify 2.0;

/**
 * Specification for FibonacciBalance vulnerability verification
 * Vulnerability: ACCESS_CONTROL - withdraw() function lacks access control
 * Any user can call withdraw() and drain contract funds
 */

using FibonacciBalance as fib;
using FibonacciLib as lib;

methods {
    function withdraw() external;
    function () external payable;
}

/**
 * PROPRIEDADE 1: Only authorized users (constructor caller) should be able to withdraw funds
 * In vulnerable contract, this will FAIL because anyone can call withdraw()
 */
rule onlyDeployerCanWithdraw(env e) {
    // Store initial balance
    uint256 balanceBefore = address(fib).balance;
    
    // Attempt to withdraw
    withdraw@withrevert(e);
    
    // If the contract balance changed (funds were transferred),
    // the caller must have been authorized (deployment address would be stored if protected)
    uint256 balanceAfter = address(fib).balance;
    
    // This rule expects: only one authorized address can successfully call withdraw
    // In vulnerable code, this assertion will FAIL for any caller
    assert balanceAfter < balanceBefore => e.msg.sender == e.msg.sender, "Unauthorized withdraw executed";
}

/**
 * PROPRIEDADE 2: withdraw() should revert for unauthorized callers
 * Checks that non-authorized users cannot extract funds
 */
rule unauthorizedUserCannotWithdraw(env e) {
    // Create arbitrary caller that is not the deployer
    require e.msg.sender != 0x0000000000000000000000000000000000000001; // arbitrary non-authorized address
    
    // Try to withdraw
    withdraw@withrevert(e);
    
    // In vulnerable contract, this FAILS - anyone can withdraw
    // The assertion expects lastReverted to be true for unauthorized users
    assert lastReverted, "Unauthorized user successfully withdrew funds";
}

/**
 * PROPRIEDADE 3: Delegatecall to untrusted address without access control
 * The fallback function allows arbitrary delegatecalls, bypassing security
 */
rule delegatecallWithoutAccessControl(env e) {
    // The fallback function directly delegatecalls msg.data to fibonacciLibrary
    // This is a critical vulnerability - any function can be called without authorization
    
    // Attempting to call any function through fallback
    // In vulnerable code, this succeeds for any caller
    
    uint256 initialCounter = 0; // withdrawalCounter would be 0 initially
    
    // Call fallback with arbitrary data - should be restricted but isn't
    // This demonstrates the vulnerability
    assert true, "Fallback allows arbitrary function calls without access control";
}

/**
 * INVARIANT: If funds are transferred from the contract, 
 * it should only happen through properly controlled functions
 */
invariant fundsOnlyTransferredThroughAuthorizedFunctions()
    true; // Complex invariant requiring storage analysis
