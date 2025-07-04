// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

// Import Chainlink VRF base contract and interface
import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

/**
 * @title RaffleWheelVRF
 * @dev A decentralized raffle that uses Chainlink VRF for provably fair randomness.
 */
contract RaffleWheelVRF is VRFConsumerBaseV2 {
    // Mapping from player address to their display name
    mapping(address => string) public names;

    // List of current players (addresses)
    address[] public players;

    // The last winner's address
    address public lastWinner;

    // Chainlink VRF coordinator contract interface
    VRFCoordinatorV2Interface COORDINATOR;

    // VRF subscription ID
    uint64 s_subscriptionId;

    // VRF keyHash identifies the Chainlink oracle job
    bytes32 keyHash;

    // Max gas to use for fulfillRandomWords callback
    uint32 callbackGasLimit = 100000;

    // How many block confirmations Chainlink nodes should wait before responding
    uint16 requestConfirmations = 3;

    // Number of random words to request (1 in this case)
    uint32 numWords = 1;

    // The last randomness request ID
    uint256 public s_requestId;

    // Owner of the contract
    address public s_owner;

    // Event emitted when a winner is selected
    event WinnerSelected(address winner, string name);

    /**
     * @dev Constructor sets VRF config and owner.
     * @param subscriptionId Your Chainlink VRF subscription ID
     * @param vrfCoordinator Address of the VRFCoordinator contract
     * @param vrfKeyHash Key hash used to identify the oracle job
     */
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

    /**
     * @dev Allows a user to enter the raffle by paying 0.001 ETH and providing a name.
     * @param name Display name for the player
     */
    function enter(string memory name) public payable {
        require(msg.value == 0.001 ether, "Entry fee is 0.001 ETH");
        require(bytes(name).length > 0, "Name cannot be empty");
        players.push(msg.sender);
        names[msg.sender] = name;
    }

    /**
     * @dev Owner triggers a random winner selection using Chainlink VRF.
     */
    function pickWinner() public onlyOwner {
        require(players.length > 0, "No players");
        // Request randomness from Chainlink VRF
        s_requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
    }

    /**
     * @dev Called by Chainlink VRF when randomness is fulfilled.
     * @param randomWords Array of random numbers returned by Chainlink VRF
     */
    function fulfillRandomWords(
        uint256, /* requestId */
        uint256[] memory randomWords
    ) internal override {
        // Use the first random word
        uint256 random = randomWords[0];

        // Compute winner index
        uint256 winnerIndex = random % players.length;
        address winnerAddr = players[winnerIndex];
        string memory winnerName = names[winnerAddr];

        // Save winner
        lastWinner = winnerAddr;

        // Transfer the entire contract balance to the winner
        payable(winnerAddr).transfer(address(this).balance);

        // Emit winner event
        emit WinnerSelected(winnerAddr, winnerName);

        // Clear players for the next round
        delete players;
    }

    /**
     * @dev Returns the current list of players and their names.
     * @return An array of player addresses and an array of player names.
     */
    function getPlayers() public view returns (address[] memory, string[] memory) {
        string[] memory playerNames = new string[](players.length);
        for (uint i = 0; i < players.length; i++) {
            playerNames[i] = names[players[i]];
        }
        return (players, playerNames);
    }

    /**
     * @dev Modifier to restrict functions to contract owner only.
     */
    modifier onlyOwner() {
        require(msg.sender == s_owner, "Only owner can call this");
        _;
    }
}
