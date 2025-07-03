// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract RaffleWheelVRF is VRFConsumerBaseV2 {
    mapping(address => string) public names;
    address[] public players;
    address public lastWinner;

    VRFCoordinatorV2Interface COORDINATOR;
    uint64 s_subscriptionId;
    bytes32 keyHash;
    uint32 callbackGasLimit = 100000;
    uint16 requestConfirmations = 3;
    uint32 numWords = 1;

    uint256 public s_requestId;
    address public s_owner;

    event WinnerSelected(address winner, string name);

    constructor(
        uint64 subscriptionId,
        address vrfCoordinator,
        bytes32 vrfKeyHash
    ) VRFConsumerBaseV2(vrfCoordinator) {
        COORDINATOR = VRFCoordinatorV2Interface(vrfCoordinator);
        s_subscriptionId = subscriptionId;
        keyHash = vrfKeyHash;
        s_owner = msg.sender;
    }

    function enter(string memory name) public payable {
        require(msg.value == 0.001 ether, "Entry fee is 0.001 ETH");
        require(bytes(name).length > 0, "Name cannot be empty");
        players.push(msg.sender);
        names[msg.sender] = name;
    }

    function pickWinner() public onlyOwner {
        require(players.length > 0, "No players");
        s_requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }

    function fulfillRandomWords(
        uint256, /* requestId */
        uint256[] memory randomWords
    ) internal override {
        uint256 random = randomWords[0];
        uint256 winnerIndex = random % players.length;
        address winnerAddr = players[winnerIndex];
        string memory winnerName = names[winnerAddr];
        lastWinner = winnerAddr;
        payable(winnerAddr).transfer(address(this).balance);
        emit WinnerSelected(winnerAddr, winnerName);
        delete players;
    }

    function getPlayers() public view returns (address[] memory, string[] memory) {
        string[] memory playerNames = new string[](players.length);
        for (uint i = 0; i < players.length; i++) {
            playerNames[i] = names[players[i]];
        }
        return (players, playerNames);
    }

    modifier onlyOwner() {
        require(msg.sender == s_owner, "Only owner can call this");
        _;
    }
}
