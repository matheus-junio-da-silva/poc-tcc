/*
 * @source: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-118#incorrect-constructor-name2sol
 * @author: Ben Perez
 * @vulnerable_at_lines: 17
 * @modernized_for: Solidity 0.8.x
 */

pragma solidity ^0.8.0;

contract Missing {
    address private owner;

    modifier onlyowner {
        require(msg.sender == owner);
        _;
    }

    // <yes> <report> ACCESS_CONTROL
    function Constructor() public {
        owner = msg.sender;
    }

    receive() external payable {}

    function withdraw() public onlyowner {
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent);
    }
}
