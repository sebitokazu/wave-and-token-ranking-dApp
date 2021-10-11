// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    mapping(string => uint256) tokenSuggestionCount;
    string[] public tokens;

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
        saveIfNewToken(_tokenName);
        tokenSuggestionCount[_tokenName] += 1;
        console.log("%s is bullish on %s", msg.sender, _tokenName);
    }

    function getTokenBullCount(string memory _tokenName) public view returns (uint256){
        console.log("%s token has %d votes", _tokenName, tokenSuggestionCount[_tokenName]);
        return tokenSuggestionCount[_tokenName];
    }

    function getAllTokenBullCount() public view returns(string[] memory, uint256[] memory){
        uint256 tokenSize = tokens.length;
        uint256[] memory tokenCount = new uint256[](tokenSize);
        for(uint256 i=0; i<tokenSize; i++){
            tokenCount[i] = tokenSuggestionCount[tokens[i]];
        }

        return (tokens, tokenCount);
    }

    function saveIfNewToken(string memory _tokenName) private {
        if(tokenSuggestionCount[_tokenName] == 0){
            tokens.push(_tokenName);
            console.log("New token: %s", _tokenName);
        }
    }
}