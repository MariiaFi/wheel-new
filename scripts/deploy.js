async function main() {
  const RaffleWheel = await ethers.getContractFactory("RaffleWheel");
  const raffleWheel = await RaffleWheel.deploy();
  await raffleWheel.deployed();
  console.log(`Contract deployed to: ${raffleWheel.address}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
