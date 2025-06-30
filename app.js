const contractAddress = "0x13848bb241E02BBbeD825CD6dba9C3ac309802b4";

const abi = [
  "function enter(string name) public payable",
  "function pickWinner() public",
  "event WinnerSelected(address winner, string name)"
];


const provider = new ethers.providers.Web3Provider(window.ethereum);
let signer;
let contract;

async function connectWallet() {
  await provider.send("eth_requestAccounts", []);
  signer = provider.getSigner();
  contract = new ethers.Contract(contractAddress, abi, signer);
  alert("✅ Wallet connected!");
}

async function enterRaffle() {
  if (!contract) return alert("Connect wallet first!");
  const tx = await contract.enter({ value: ethers.utils.parseEther("0.001") });
  await tx.wait();
  alert("🎟️ You entered the raffle!");
}

async function spinWheel() {
  if (!contract) return alert("Connect wallet first!");
  const tx = await contract.pickWinner();
  const receipt = await tx.wait();
  const event = receipt.events.find(e => e.event === "WinnerSelected");
  const winner = event.args.winner;
  alert(`🎉 Winner: ${winner}`);
}
