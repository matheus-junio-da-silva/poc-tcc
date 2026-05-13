/*
 * @source: https://github.com/sigp/solidity-security-blog
 * @author: Suhabe Bugrara
 * @vulnerable_at_lines: 31,38
 * @fixed_by: Adding access control to withdraw() and fallback functions
 * @modernized_for: Solidity 0.8.x
 */

pragma solidity ^0.8.0;

contract FibonacciBalance {

    address public owner;
    address public fibonacciLibrary;
    // the current fibonacci number to withdraw
    uint public calculatedFibNumber;
    // the starting fibonacci sequence number
    uint public start = 3;
    uint public withdrawalCounter;
    // the fibonancci function selector
    bytes4 constant fibSig = bytes4(keccak256("setFibonacci(uint256)"));

    // constructor - loads the contract with ether
    constructor(address _fibonacciLibrary) payable {
        owner = msg.sender;  // FIX: Store owner to enforce access control
        fibonacciLibrary = _fibonacciLibrary;
    }

    // FIX: Add onlyOwner modifier to protect withdraw function
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function withdraw() public onlyOwner {  // FIX: Add onlyOwner modifier
        withdrawalCounter += 1;
        // calculate the fibonacci number for the current withdrawal user
        // this sets calculatedFibNumber
        (bool success, ) = fibonacciLibrary.delegatecall(abi.encodeWithSelector(fibSig, withdrawalCounter));
        require(success);
        (bool sent, ) = msg.sender.call{value: calculatedFibNumber * 1 ether}("");
        require(sent);
    }

    // FIX: Add access control to fallback function or remove it entirely
    // In this case, we remove it to prevent arbitrary delegatecalls
    // If delegatecalls are needed, only specific functions should be callable
    function safeCall(bytes4 sig, uint256 value) public onlyOwner {
        // Only allow specific function signatures
        require(sig == fibSig, "Function not allowed");
        (bool success, ) = fibonacciLibrary.delegatecall(abi.encodeWithSelector(sig, value));
        require(success);
    }
}
}

// library contract - calculates fibonacci-like numbers;
contract FibonacciLib {
    // initializing the standard fibonacci sequence;
    uint public start;
    uint public calculatedFibNumber;

    // modify the zeroth number in the sequence
    function setStart(uint _start) public {
        start = _start;
    }

    function setFibonacci(uint n) public {
        calculatedFibNumber = fibonacci(n);
    }

    function fibonacci(uint n) internal returns (uint) {
        if (n == 0) return start;
        else if (n == 1) return start + 1;
        else return fibonacci(n - 1) + fibonacci(n - 2);
    }
}
