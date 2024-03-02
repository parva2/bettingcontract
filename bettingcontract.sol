// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BettingContract {
    struct Bet {
        uint id;
        string description;
        uint totalWagered;
        address payable creator;
        bool isSettled;
        address payable[] winners;
        mapping(address => uint) wagers;
        uint totalWinnings;
    }

    uint public nextBetId;
    mapping(uint => Bet) public bets;
    mapping(address => uint) public balances;

    event BetCreated(uint betId, string description);
    event WagerPlaced(uint betId, address better, uint amount);
    event BetSettled(uint betId, address[] winners);
    event WinningsClaimed(address claimant, uint amount);

    function createBet(string memory _description) public {
        Bet storage newBet = bets[nextBetId];
        newBet.id = nextBetId;
        newBet.description = _description;
        newBet.creator = payable(msg.sender);
        newBet.isSettled = false;

        emit BetCreated(nextBetId, _description);
        nextBetId++;
    }

    function placeWager(uint _betId, uint _amount) public payable {
        require(msg.value == _amount, "Wager amount is incorrect");
        require(!bets[_betId].isSettled, "Bet is already settled");

        Bet storage bet = bets[_betId];
        bet.wagers[msg.sender] += _amount;
        bet.totalWagered += _amount;

        emit WagerPlaced(_betId, msg.sender, _amount);
    }

    function settleBet(uint _betId, address payable[] memory _winners) public {
        require(msg.sender == bets[_betId].creator, "Only the bet creator can settle the bet");
        require(!bets[_betId].isSettled, "Bet is already settled");
        require(_winners.length > 0, "There must be at least one winner");

        Bet storage bet = bets[_betId];
        bet.isSettled = true;
        bet.winners = _winners;
        bet.totalWinnings = bet.totalWagered;

    address[] memory winnerAddresses = new address[](_winners.length);
    for (uint i = 0; i < _winners.length; i++) {
        winnerAddresses[i] = _winners[i];
    }
        for (uint i = 0; i < _winners.length; i++) {
            uint winnerShare = bet.wagers[_winners[i]] * bet.totalWinnings / bet.totalWagered;
            balances[_winners[i]] += winnerShare;
        }

        
    emit BetSettled(_betId, winnerAddresses);
    }

    function claimWinnings() public {
        uint amount = balances[msg.sender];
        require(amount > 0, "No winnings to claim");

        balances[msg.sender] = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");

        emit WinningsClaimed(msg.sender, amount);
    }
}
