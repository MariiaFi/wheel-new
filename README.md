# Neon Raffle Wheel DApp

This is an interactive Raffle Wheel connected to the Ethereum Sepolia testnet, with a fully functional demo mode.

---

## Features

- **Connect Wallet** — connect MetaMask and create the contract instance.
- **Enter Raffle** — register your nickname by sending a transaction with a small ETH fee.
- **SPIN** — pick a real winner from registered participants on-chain.
- **DEMO SPIN** — simulate the wheel spin without interacting with the blockchain.
- **SVG Neon Wheel** — visual representation of all segments with glowing styling.
- **Winner Display** — shows the winner’s name below the wheel.

---

## ⚙Buttons Overview

| Button               | Action                                                                 |
|----------------------|------------------------------------------------------------------------|
| **Connect Wallet**   | Requests MetaMask connection and initializes ethers.js contract object |
| **Enter Raffle**     | Calls `enter(name)` and pays 0.001 ETH to join the raffle              |
| **SPIN**             | Calls `pickWinner()` on the smart contract and animates the wheel      |
| **DEMO SPIN**        | Picks a random winner locally without blockchain transactions          |

---

## 🛠️ Technologies Used

- **HTML + CSS + JavaScript**
- **ethers.js v5**
- **Ethereum Sepolia Testnet**
- **MetaMask**

---

## 🚀 How to Use

1. Install [MetaMask](https://metamask.io).
2. Switch to the Sepolia network and get test ETH from a faucet.
3. Open `index.html` in your browser.
4. Click **Connect Wallet**.
5. Enter your nickname.
6. Click **Enter Raffle** to join.
7. Use **SPIN** to select an on-chain winner or **DEMO SPIN** to test without blockchain.

---

## 📄 Smart Contract

**Contract Address:**
`0x13848bb241E02BBbeD825CD6dba9C3ac309802b4`

**Functions:**
- `enter(string name) payable`
- `pickWinner()`
- `event WinnerSelected(address winner, string name)`

---

## Notes

- You must have at least one real participant to use **SPIN**.
- If there are no players, use **DEMO SPIN** to simulate a winner.
- Button widths are fixed via CSS to avoid layout shifts when labels change.
- Winner text is always displayed below the wheel, centered.

---

## License

MIT License. Feel free to customize and improve!
"# wheel" 
"# wheel" 
