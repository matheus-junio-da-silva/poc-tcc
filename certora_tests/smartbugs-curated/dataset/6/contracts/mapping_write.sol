/*
 * @source: https://smartcontractsecurity.github.io/SWC-registry/docs/SWC-124#mapping-writesol
 * @author: Suhabe Bugrara
 * @vulnerable_at_lines: 20
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

    function set(uint256 key, uint256 value) public {
        if (map.length <= key) {
            map.push(0);
        }
        // <yes> <report> ACCESS_CONTROL
        map[key] = value;
    }

    function get(uint256 key) public view returns (uint256) {
        return map[key];
    }

    function withdraw() public {
        require(msg.sender == owner);
        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent);
    }
}
