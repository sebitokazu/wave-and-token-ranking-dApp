// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {

    uint256 totalWaves;

    /*
     * We will be using this below to help generate a random number
     */
    uint256 private seed;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastWavedAt;

    mapping(string => uint256) tokenSuggestionCount;
    string[] public tokens;


    /*
     * A little magic, Google what events are in Solidity!
     */
    event NewWave(address indexed from, uint256 timestamp);
    event NewVote(address indexed from, uint256 timestamp, string token);

    constructor() payable {
        console.log("ANASHEEEEEEE");
    }

    function wave() public {
        /*
         * We need to make sure the current timestamp is at least 15-minutes bigger than the last timestamp we stored
         */
        require(
            lastWavedAt[msg.sender] + 15 minutes < block.timestamp,
            "Wait 15m"
        );

         /*
         * Update the current timestamp we have for the user
         */
        lastWavedAt[msg.sender] = block.timestamp;

        totalWaves += 1;
        console.log("%s says: ANASHEEE",msg.sender);

        /*
         * I added some fanciness here, Google it and try to figure out what it is!
         * Let me know what you learn in #general-chill-chat
         */
        emit NewWave(msg.sender, block.timestamp);

        /*
         * Generate a Psuedo random number between 0 and 100
         */
        uint256 randomNumber = (block.difficulty + block.timestamp + seed) % 100;
        console.log("Random # generated: %s", randomNumber);

        /*
         * Set the generated, random number as the seed for the next wave
         */
        seed = randomNumber;

        /*
         * Give a 50% chance that the user wins the prize.
         */
        if (randomNumber < 50) {
            console.log("%s won!", msg.sender);
            uint256 prizeAmount = 0.00001 ether;
            require(prizeAmount <= address(this).balance, "Contract does not have enough funds to prize you. Sorry :(");
            (bool success,) = (msg.sender).call{value: prizeAmount}("");
            require(success,"Failed to withdraw money from contract :s");
        }
    }

    function getTotalWaves() public view returns (uint256){
        console.log("%d people said ANASHEEE", totalWaves);
        return totalWaves;
    }

    function bullToken(string memory _tokenName) public{
        saveIfNewToken(_tokenName);
        tokenSuggestionCount[_tokenName] += 1;
        console.log("%s is bullish on %s", msg.sender, _tokenName);
        emit NewVote(msg.sender, block.timestamp, _tokenName);
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