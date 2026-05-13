/*
 * @source: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-124#mapping-writesol
 * @author: Suhabe Bugrara
 * @vulnerable_at_lines: 20
 * @fixed_by: Adding onlyOwner modifier to set() function
 * @modernized_for: Solidity 0.8.x
 */

pragma solidity ^0.8.0;

//This code is derived from the Capture the Ether https://capturetheether.com/challenges/math/mapping/

contract Map {
    address public owner;
    uint256[] map;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function set(uint256 key, uint256 value) public onlyOwner {  // FIX: Added onlyOwner modifier
        if (map.length <= key) {
            map.push(0);
        }
        // Now only owner can write to map
        map[key] = value;
    }

    function get(uint256 key) public view returns (uint256) {
        return map[key];
    }

    function withdraw() public onlyOwner {
        require(msg.sender == owner);
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent);
    }
}
