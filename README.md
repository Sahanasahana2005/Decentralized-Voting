# Decentralized Voting System

## Goal
Tamper-proof voting system using Solidity smart contracts.

## Features
- Voter authorization by chairperson
- Prevents double voting
- Dynamic tally calculation

## Deployment
- Run local node: `npx hardhat node`
- Deploy contract: `npx hardhat run scripts/deploy.js --network localhost`

## Testing
- Run tests: `npx hardhat test`
- Includes:
  - Voter authorization check
  - Double voting prevention
  - Correct tally calculation

