// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiRoundVoting {
    struct Voter {
        bool authorized;
        bool voted;
        uint vote;
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
        bool eliminated;
    }

    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    uint public round;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0,
                eliminated: false
            }));
        }
        round = 1;
    }

    function giveRightToVote(address voter) public {
        require(msg.sender == chairperson, "Only chairperson can authorize");
        require(!voters[voter].authorized, "Already authorized");
        voters[voter].authorized = true;
    }

    function vote(uint proposal) public {
        Voter storage sender = voters[msg.sender];
        require(sender.authorized, "Not authorized");
        require(!sender.voted, "Already voted");
        require(!proposals[proposal].eliminated, "Proposal eliminated");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount++;
    }

    function nextRound() public {
        require(msg.sender == chairperson, "Only chairperson can start next round");
        // eliminate lowest vote proposals
        uint minVotes = type(uint).max;
        for (uint i = 0; i < proposals.length; i++) {
            if (!proposals[i].eliminated && proposals[i].voteCount < minVotes) {
                minVotes = proposals[i].voteCount;
            }
        }
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount == minVotes) {
                proposals[i].eliminated = true;
            }
            proposals[i].voteCount = 0; // reset for next round
        }
        round++;
        // reset voters
        for (uint i = 0; i < proposals.length; i++) {
            voters[msg.sender].voted = false;
        }
    }

    function winningProposal() public view returns (uint winningProposal_) {
        for (uint i = 0; i < proposals.length; i++) {
            if (!proposals[i].eliminated) {
                winningProposal_ = i;
            }
        }
    }
}

