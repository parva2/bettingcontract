/*

const HDWalletProvider = require('@truffle/hdwallet-provider');
const mnemonic = 'badge whip employ super frost poet swarm legal another melody flower frog'; // DO NOT share your real mnemonic
// const infuraKey = 'a6294f5db7df4686ae9cc19bdce06ebe';

module.exports = {

  compilers: {
    solc: {
      version: "^0.8.0",
  networks: {
    karak: {
      provider: () => new HDWalletProvider(mnemonic, `https://goerli.node1.karak.network/`),
      network_id:'2511', // Karak Goerli's network id
      gas: 5500000,
    },
    // other networks...
  },
  // ...
}
  }
}; */
const HDWalletProvider = require('@truffle/hdwallet-provider');
const mnemonic = 'badge whip employ super frost poet swarm legal another melody flower frog'; // DO NOT share your real mnemonic

module.exports = {
  compilers: {
    solc: {
      version: "^0.8.0",
    },
  },
  networks: {
    karak: {
      provider: () => new HDWalletProvider(mnemonic, `https://goerli.node1.karak.network/`),
      network_id: '2511', // Karak Goerli's network id
      gas: 55000000000000,
    },
    // other networks...
  },
  // ...
};
