import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomiclabs/hardhat-ganache";

const config: HardhatUserConfig = {
  solidity: "0.8.17",
  networks: {
    polygon_mumbai: {
      url: 'https://polygon-mumbai.g.alchemy.com/v2/5gvxdiPQMpVWvyYQ1CBjz7vllUuYAXtm',
      accounts: [
        `0x${"27b6162a1f99870f240264f68d6cd640c891c384a2e934efaa5e11059b2ec2e3"}`,
      ]
    },
    goerli_eth: {
      url: 'https://eth-goerli.g.alchemy.com/v2/EbXXs_Ij0jy0gTEsH3vXTyrZK4ipimHC',
      accounts: [
        `0x${"27b6162a1f99870f240264f68d6cd640c891c384a2e934efaa5e11059b2ec2e3"}`,
      ]
    },
    ganache: {
      url: 'http://127.0.0.1:7545',
      accounts: [
        `0x${"8ea4f2288b9e23cd5b9948e017fa76b77de98fadb4ca6bbbebaa63c4972803cc"}`
      ]
    }
  }
};

export default config;
