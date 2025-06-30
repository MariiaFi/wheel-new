require("@nomiclabs/hardhat-ethers");

module.exports = {
  solidity: "0.8.28",
  networks: {
    sepolia: {
      url: "https://sepolia.infura.io/v3/5eff3dce4e3e4f15963f304cddab3138",
      accounts: ["7ae930c36ec195f6f539e82c926a889a52ef2c7dd975a24dd62d0271ac1e00a0"]
    }
  }
};
