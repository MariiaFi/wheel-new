# Neon Raffle Wheel DApp

[![Ethereum](https://img.shields.io/badge/Ethereum-Sepolia-blue?logo=ethereum)](https://ethereum.org)
[![Chainlink](https://img.shields.io/badge/Chainlink-VRF-blue?logo=chainlink)](https://chain.link/)
[![MetaMask](https://img.shields.io/badge/MetaMask-Supported-orange?logo=metamask)](https://metamask.io)
[![License](https://img.shields.io/badge/License-MIT-green)](LICENSE)

An interactive decentralized Raffle Wheel connected to the Ethereum Sepolia testnet, featuring live Chainlink VRF randomness and dynamic segment updates.

---

## Features

- **Connect Wallet** — connect MetaMask and initialize the contract.
- **Enter Raffle** — register your nickname on-chain by sending 0.001 ETH.
- **SPIN** — request secure randomness via Chainlink VRF to pick a winner on-chain.
- **DEMO SPIN** — simulate spinning the wheel without blockchain interaction.
- **Dynamic SVG Neon Wheel** — displays all current participants in glowing segments.
- **Winner Display** — shows the selected winner below the wheel.

---

## Buttons Overview

| Button               | Action                                                                 |
|----------------------|------------------------------------------------------------------------|
| **Connect Wallet**   | Requests MetaMask connection and sets up the ethers.js contract        |
| **Enter Raffle**     | Calls `enter(name)` and pays 0.001 ETH to join the raffle              |
| **SPIN**             | Calls `pickWinner()`, waits for Chainlink VRF response, and animates   |
| **DEMO SPIN**        | Randomly picks a winner locally without blockchain                    |

---

## Technologies Used

- **HTML + CSS + JavaScript**
- **ethers.js v5**
- **Chainlink VRF v2**
- **Ethereum Sepolia Testnet**
- **MetaMask**

---

## How to Use

1. Install [MetaMask](https://metamask.io).
2. Switch to Sepolia network and get test ETH from a faucet.
3. Clone this repo and open `index.html` in your browser.
4. Click **Connect Wallet**.
5. Enter your nickname.
6. Click **Enter Raffle** to register your name on-chain.
7. Use **SPIN** to randomly pick a winner via Chainlink VRF.
8. Use **DEMO SPIN** anytime to test spinning without real transactions.

---

## 🛠 Smart Contract

**Contract Address:**
`0x13848bb241E02BBbeD825CD6dba9C3ac309802b4`


**Main Functions:**
- `enter(string name) payable` — joins the raffle with your nickname.
- `pickWinner()` — requests a secure random number from Chainlink VRF and selects the winner.
- `getPlayers()` — returns current participant addresses and nicknames.

**Events:**
- `WinnerSelected(address winner, string name)`

---

## Notes

- The wheel automatically updates segments each time a new player joins.
- Winner selection uses real randomness from Chainlink VRF (not predictable).
- **DEMO SPIN** is only for frontend testing and does not require any blockchain interaction.
- All button sizes are styled to prevent layout shifts.
- Winner display is always centered below the wheel.

---

## License

MIT License. Feel free to customize and improve!



