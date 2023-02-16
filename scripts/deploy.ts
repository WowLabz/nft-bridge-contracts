import { ethers } from "hardhat";

async function main() {
  const currentTimestampInSeconds = Math.round(Date.now() / 1000);
  const ONE_YEAR_IN_SECS = 365 * 24 * 60 * 60;
  const unlockTime = currentTimestampInSeconds + ONE_YEAR_IN_SECS;

  const lockedAmount = ethers.utils.parseEther("1");

  // const Lock = await ethers.getContractFactory("Lock");
  // const lock = await Lock.deploy(unlockTime, { value: lockedAmount });

  // await lock.deployed();

  const BridgeNft = await ethers.getContractFactory("BridgeNFT");
  const bridgeNft = await BridgeNft.deploy();
  await bridgeNft.deployed();
  console.log(`BridgeNft deployed at ${bridgeNft.address}`);
  const Bridge = await ethers.getContractFactory("Bridge");
  const bridge = await Bridge.deploy(bridgeNft.address);
  await bridge.deployed();
  console.log(`Contract Bridge deployed at address: ${bridge.address}`);


  // const NFT = await ethers.getContractFactory("TestMan");
  // const nft = await NFT.deploy();
  // await nft.deployed();
  // console.log(`Contract NFT deployed at address: ${nft.address}`);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
