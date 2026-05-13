/*
 * @source: https://github.com/trailofbits/not-so-smart-contracts/blob/master/wrong_constructor_name/incorrect_constructor.sol
 * @author: Ben Perez
 * @vulnerable_at_lines: 20
 * @modernized_for: Solidity 0.8.x
 */

pragma solidity ^0.8.0;

contract Missing {
    address private owner;

    modifier onlyowner {
        require(msg.sender == owner);
        _;
    }

    // The name of the constructor should be Missing
    // Anyone can call the IamMissing once the contract is deployed
    // <yes> <report> ACCESS_CONTROL
    function IamMissing() public {
        owner = msg.sender;
    }

    receive() external payable {}

    function withdraw() public onlyowner {
        (bool sent, ) = owner.call{value: address(this).balance}("");
        require(sent);
    }
}
