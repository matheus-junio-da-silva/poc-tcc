/*
 * @source: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-118#incorrect-constructor-name1sol
 * @author: Ben Perez
 * @vulnerable_at_lines: 18
 * @fixed_by: Renaming missing() to correct constructor name Missing
 * @modernized_for: Solidity 0.8.x
 */

pragma solidity ^0.8.0;

contract Missing {
    address private owner;

    modifier onlyowner {
        require(msg.sender == owner);
        _;
    }

    // FIX: Renamed to correct constructor name (Missing with capital M)
    // This executes at deployment and initializes owner correctly
    constructor()
    {
        owner = msg.sender;
    }

    // FIX: If missing() function needs to exist, make it protected
    function missing()
        public
        onlyowner
    {
        owner = msg.sender;
    }

    receive() external payable {}

    function withdraw()
        public
        onlyowner
    {
       (bool sent, ) = owner.call{value: address(this).balance}("");
       require(sent);
    }
}
