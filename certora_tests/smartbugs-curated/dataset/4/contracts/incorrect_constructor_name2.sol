/*
 * @source: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-118#incorrect-constructor-name1sol
 * @author: Ben Perez
 * @vulnerable_at_lines: 18
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
    function missing() public {
        owner = msg.sender;
    }

    receive() external payable {}

    function withdraw() public onlyowner {
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent);
    }
}
