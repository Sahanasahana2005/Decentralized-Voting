// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract QuadraticVoting {
    struct Voter {
        bool authorized;
        bool voted;
        uint credits; // credits assigned
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames, uint creditsPerVoter) {
        chairperson = msg.sender;
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
        // chairperson can later assign credits to voters
    }

    function giveRightToVote(address voter, uint credits) public {
        require(msg.sender == chairperson, "Only chairperson can authorize");
        require(!voters[voter].authorized, "Already authorized");
        voters[voter].authorized = true;
        voters[voter].credits = credits;
    }

    function vote(uint proposal, uint numVotes) public {
        Voter storage sender = voters[msg.sender];
        require(sender.authorized, "Not authorized");
        require(!sender.voted, "Already voted");
        uint cost = numVotes * numVotes; // quadratic cost
        require(cost <= sender.credits, "Not enough credits");
        sender.voted = true;
        sender.credits -= cost;
        proposals[proposal].voteCount += numVotes;
    }

    function winningProposal() public view returns (uint winningProposal_) {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winningVoteCount) {
                winningVoteCount = proposals[p].voteCount;
                winningProposal_ = p;
            }
        }
    }
}

