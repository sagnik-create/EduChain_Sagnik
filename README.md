# EduToken and CoinRedemption Contracts

This project consists of two Solidity smart contracts: `EduToken` and `CoinRedemption`. These contracts are designed to work together to facilitate the use of blockchain technology in a learning environment. The system enables users to earn in-game coins and redeem them for EDU tokens, which are ERC-20 compliant tokens.

## Overview

### EduToken Contract
`EduToken` is an ERC-20 token implementation with the following features:
- **Name**: EduToken
- **Symbol**: EDU
- **Decimals**: 18
- **Total Supply**: Dynamically updated as tokens are minted
- **Ownership**: Only the owner of the contract can mint new tokens.

### CoinRedemption Contract
`CoinRedemption` manages the redemption of in-game coins for EDU tokens. It:
- Allows the owner to add in-game coins to users' balances.
- Lets users redeem their in-game coins for EDU tokens based on a redemption rate.
- Allows the owner to update the redemption rate.

## Contract Deployment

### Prerequisites
- A Solidity-compatible Ethereum development environment (e.g., Remix, Hardhat, or Truffle).
- A funded Ethereum wallet for deploying contracts.

### Steps
1. Deploy the `EduToken` contract.
2. Deploy the `CoinRedemption` contract, passing the address of the deployed `EduToken` contract and the initial redemption rate as constructor arguments.

## Usage

### EduToken Contract
#### Minting Tokens
The owner can mint tokens for any address using:
```solidity
mint(address to, uint256 amount)
```

#### Transferring Tokens
Users can transfer tokens to another address using:
```solidity
transfer(address to, uint256 amount)
```

### CoinRedemption Contract
#### Adding Game Coins
The owner can add in-game coins to a user's balance using:
```solidity
addGameCoins(address user, uint256 amount)
```

#### Redeeming Coins
Users can redeem their in-game coins for EDU tokens using:
```solidity
redeemCoins()
```
This function calculates the number of EDU tokens the user is eligible for based on their game coin balance and the redemption rate. Remaining game coins that are insufficient for another redemption are retained in the user's balance.

#### Updating Redemption Rate
The owner can update the redemption rate using:
```solidity
updateRedemptionRate(uint256 newRate)
```

## Events
The contracts emit the following events:

### EduToken Contract
- `Transfer(address indexed from, address indexed to, uint256 value)`:
  Emitted whenever tokens are minted or transferred.

### CoinRedemption Contract
- `CoinsRedeemed(address indexed user, uint256 gameCoins, uint256 eduTokens)`:
  Emitted when a user redeems in-game coins for EDU tokens.

## Example Workflow
1. The owner mints EDU tokens using the `EduToken` contract.
2. The owner adds in-game coins to users' balances using the `CoinRedemption` contract.
3. Users redeem their in-game coins for EDU tokens.
4. Users can transfer EDU tokens to others as needed.

## Security Considerations
- **Ownership Restriction**: Only the owner can mint tokens and add in-game coins to user balances.
- **Balance Check**: Users can only redeem coins if they have enough in-game coins to meet the redemption rate.
- **ERC-20 Compliance**: The `EduToken` contract follows the ERC-20 standard.

## Future Enhancements
- Add functionality to burn unused EDU tokens.
- Integrate with an off-chain system to automatically track and add game coins based on user activity.
- Implement a frontend interface for easier interaction with the contracts.

---

### Disclaimer
Use these contracts at your own risk. Ensure thorough testing and auditing before deploying them to a production environment.

