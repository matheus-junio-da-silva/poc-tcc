/*
 * @source: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-118#incorrect-constructor-name2sol
 * @author: Ben Perez
 * @vulnerable_at_lines: 17
 * @fixed_by: Renaming Constructor() to correct constructor name Missing
 * @modernized_for: Solidity 0.8.x
 */

pragma solidity ^0.8.0;

contract Missing {
    address private owner;

    modifier onlyowner {
        require(msg.sender == owner);
        _;
    }

    // FIX: Renamed to correct constructor name (Missing, matching contract name)
    // This executes at deployment time and properly initializes owner
    constructor()
    {
        owner = msg.sender;
    }

    // FIX: If Constructor() function needs to exist for compatibility, protect it
    function Constructor()
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
