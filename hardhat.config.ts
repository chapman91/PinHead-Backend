import "dotenv/config"
import { HardhatUserConfig } from "hardhat/config"
import "@nomicfoundation/hardhat-toolbox"
import "hardhat-gas-reporter"

const config: HardhatUserConfig = {
  solidity: { compilers: [{ version: "0.8.20" }, { version: "0.4.18" }] },
  gasReporter: {
    currency: "USD",
    gasPrice: 21,
    enabled: true,
  },
  networks: {
    baseMainnet: {
      url: "https://mainnet.base.org",
      chainId: 8453,
      accounts: [process.env.BASE_MAINNET_PRIVATE_KEY!],
    },
    baseSepolia: {
      url: "https://sepolia.base.org",
      chainId: 84532,
      accounts: [process.env.BASE_SEPOLIA_PRIVATE_KEY!],
    },
  },
};

export default config
