// server.js

const express = require('express');
// const Web3 = require('web3');

const { Web3 } = require('web3');


const app = express();
const web3 = new Web3('https://goerli.infura.io/v3/a6294f5db7df4686ae9cc19bdce06ebe');

app.use(express.json());

app.get('/api', (req, res) => {
    res.send('Blockchain Betting API');
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
