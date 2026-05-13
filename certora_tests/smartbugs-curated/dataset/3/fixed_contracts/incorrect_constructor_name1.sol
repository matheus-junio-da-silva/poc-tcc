/*
 * @source: https://github.com/trailofbits/not-so-smart-contracts/blob/master/wrong_constructor_name/incorrect_constructor.sol
 * @author: Ben Perez
 * @vulnerable_at_lines: 20
 * @fixed_by: Renaming IamMissing to correct constructor name and adding protections
 * @modernized_for: Solidity 0.8.x
 */

pragma solidity ^0.8.0;

contract Missing {
    address private owner;

    modifier onlyowner {
        require(msg.sender == owner);
        _;
    }

    // FIX: Renamed constructor to correct name (Missing) to execute at deployment
    // This ensures owner is set automatically at deployment, not via public function
    constructor()
    {
        owner = msg.sender;
    }

    // FIX: Keep IamMissing as protected function if needed, or remove it entirely
    // Here we keep it for compatibility but make it protected
    function IamMissing()
        public
        onlyowner
    {
        // This can now only be called by current owner if needed
        owner = msg.sender;
    }

    function () payable {}

    function withdraw()
        public
        onlyowner
    {
       (bool sent, ) = owner.call{value: address(this).balance}("");
       require(sent);
    }
}
