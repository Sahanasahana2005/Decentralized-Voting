
const { expect } = require("chai");
const { ethers } = require("hardhat");

// Test cases for VotingProtocol
describe("VotingProtocol", function () {
  let VotingProtocol, voting, chairperson, voter1, voter2;

  beforeEach(async function () {
    [chairperson, voter1, voter2] = await ethers.getSigners();
    VotingProtocol = await ethers.getContractFactory("VotingProtocol");
    const proposals = ["Proposal1", "Proposal2"].map(p =>
      ethers.encodeBytes32String(p)
    );
    voting = await VotingProtocol.deploy(proposals);
    await voting.deployed();
  });

  it("should authorize a voter", async function () {
    await voting.connect(chairperson).giveRightToVote(voter1.address);
    const voter = await voting.voters(voter1.address);
    expect(voter.authorized).to.equal(true);
  });
});
