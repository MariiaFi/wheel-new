// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract RaffleWheel {
    mapping(address => string) public names;
    address[] public players;
    address public lastWinner;

    function enter(string memory name) public payable {
        require(msg.value == 0.001 ether, "Entry fee is 0.001 ETH");
        require(bytes(name).length > 0, "Name cannot be empty");
        players.push(msg.sender);
        names[msg.sender] = name;
    }

    function pickWinner() public {
        require(players.length > 0, "No players");
        uint random = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao, players.length)));
        uint winnerIndex = random % players.length;
        address winnerAddr = players[winnerIndex];
        string memory winnerName = names[winnerAddr];
        lastWinner = winnerAddr;
        payable(winnerAddr).transfer(address(this).balance);
        emit WinnerSelected(winnerAddr, winnerName);
        delete players;
    }

    event WinnerSelected(address winner, string name);
}
