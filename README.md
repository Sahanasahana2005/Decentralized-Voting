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

## Token-Based Voting
- Voting rights linked to ERC20 token balance.
- More tokens = more voting power.
- Useful for DAO governance and token communities.
## Multi-Round Voting
- Elections proceed in multiple rounds.
- Lowest vote proposals eliminated each round.
- Final round decides the ultimate winner.
## Anonymous Voting
- Voter identity hidden using hash values.
- Prevents linking votes to specific addresses.
- Useful for privacy-focused elections.
## Quadratic Voting
- Voters can cast multiple votes, but cost increases quadratically.
- Example: 2 votes cost 4 credits, 3 votes cost 9 credits.
- Balances majority vs minority influence.
## Delegated Voting
- Voters can delegate their vote to another authorized voter.
- Prevents self-delegation and loops in delegation chain.
- Useful for representative voting systems.
## Weighted Voting
- Each voter can be assigned a custom weight.
- Example: Shareholders voting based on number of shares.
- Vote counts are tallied using assigned weights.
## Timed Voting
- Voting period can be restricted using `durationMinutes` parameter.
- Example: Deploy with 30 minutes → voting closes automatically after 30 minutes.
