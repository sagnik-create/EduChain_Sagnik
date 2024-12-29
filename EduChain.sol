// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EduToken {
    string public name = "EduToken";
    string public symbol = "EDU";
    uint8 public decimals = 18;
    uint256 public totalSupply;
    address public owner;

    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function mint(address to, uint256 amount) external onlyOwner {
        balances[to] += amount;
        totalSupply += amount;
        emit Transfer(address(0), to, amount);
    }

    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to, amount);
    }
}

contract CoinRedemption {
    EduToken public token;
    uint256 public redemptionRate; // Number of in-game coins required for 1 EDU token
    address public owner;

    mapping(address => uint256) public gameBalances;

    event CoinsRedeemed(address indexed user, uint256 gameCoins, uint256 eduTokens);

    constructor(address tokenAddress, uint256 rate) {
        token = EduToken(tokenAddress);
        redemptionRate = rate;
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    function updateRedemptionRate(uint256 newRate) external onlyOwner {
        redemptionRate = newRate;
    }

    function addGameCoins(address user, uint256 amount) external onlyOwner {
        gameBalances[user] += amount;
    }

    function redeemCoins() external {
        uint256 gameCoins = gameBalances[msg.sender];
        require(gameCoins >= redemptionRate, "Not enough game coins to redeem");

        uint256 eduTokens = gameCoins / redemptionRate;
        gameBalances[msg.sender] %= redemptionRate;

        token.mint(msg.sender, eduTokens);
        emit CoinsRedeemed(msg.sender, gameCoins, eduTokens);
    }
}
