// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    mapping(string => uint256) tokenSuggestionCount;
    mapping(address => uint256) suggestionsByAddress;

    constructor() {
        console.log("ANASHEEEEEEE");
    }

    function wave() public {
        totalWaves += 1;
        console.log("%s says: ANASHEEE",msg.sender);
    }

    function getTotalWaves() public view returns (uint256){
        console.log("%d people said ANASHEEE", totalWaves);
        return totalWaves;
    }

    function bullToken(string memory _tokenName) public{
        suggestionsByAddress[msg.sender] += 1;
        tokenSuggestionCount[_tokenName] += 1;
        console.log("%s is bullish on %s", msg.sender, _tokenName);
    }

    function getSuggestionsByAddress(address _address) public view returns(uint256){
        console.log("%s has voted %d times", _address, suggestionsByAddress[_address]);
        return suggestionsByAddress[_address];
    }

    function getTokenBullCount(string memory _tokenName) public view returns (uint256){
        console.log("%s token has %d fans", _tokenName, tokenSuggestionCount[_tokenName]);
        return tokenSuggestionCount[_tokenName];
    }
}