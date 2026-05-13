/*
 * @source: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-124#arbitrary-location-write-simplesol
 * @author: Suhabe Bugrara
 * @vulnerable_at_lines: 27
 * @fixed_by: Adding onlyOwner modifier to PushBonusCode and PopBonusCode
 * @modernized_for: Solidity 0.8.x
 */

pragma solidity ^0.8.0;

contract Wallet {
    uint[] private bonusCodes;
    address private owner;

    constructor() {
        bonusCodes = new uint[](0);
        owner = msg.sender;
    }

    receive() external payable {}

    // FIX: Add onlyOwner modifier to restrict who can push bonus codes
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function PushBonusCode(uint c) public onlyOwner {  // FIX: Added onlyOwner
        bonusCodes.push(c);
    }

    function PopBonusCode() public onlyOwner {  // FIX: Added onlyOwner
        // FIX: Changed condition to properly check array length
        require(bonusCodes.length > 0, "Cannot pop from empty array");
        bonusCodes.pop();
    }

    function UpdateBonusCodeAt(uint idx, uint c) public onlyOwner {  // FIX: Added onlyOwner
        require(idx < bonusCodes.length, "Index out of bounds");
        bonusCodes[idx] = c;
    }

    function Destroy() public {
        require(msg.sender == owner);
        selfdestruct(payable(msg.sender));
    }
}
}
