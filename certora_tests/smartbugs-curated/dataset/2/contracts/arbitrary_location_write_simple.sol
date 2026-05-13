/*
 * @source: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-124#arbitrary-location-write-simplesol
 * @author: Suhabe Bugrara
 * @vulnerable_at_lines: 27
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

    function PushBonusCode(uint c) public {
        bonusCodes.push(c);
    }

    function PopBonusCode() public {
        // <yes> <report> ACCESS_CONTROL
        require(bonusCodes.length > 0);
        bonusCodes.pop();
    }

    function UpdateBonusCodeAt(uint idx, uint c) public {
        require(idx < bonusCodes.length);
        bonusCodes[idx] = c; // write to any index less than bonusCodes.length
    }

    function Destroy() public {
        require(msg.sender == owner);
        selfdestruct(payable(msg.sender));
    }
}
