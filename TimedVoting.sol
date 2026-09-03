// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TimedVoting {
    struct Voter {
        bool authorized;
        bool voted;
        uint vote;
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
    uint public votingDeadline;

    constructor(bytes32[] memory proposalNames, uint durationMinutes) {
        chairperson = msg.sender;
        votingDeadline = block.timestamp + (durationMinutes * 1 minutes);
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function giveRightToVote(address voter) public {
        require(msg.sender == chairperson, "Only chairperson can authorize");
        require(!voters[voter].voted, "Already voted");
        voters[voter].authorized = true;
    }

    function vote(uint proposal) public {
        require(block.timestamp <= votingDeadline, "Voting period ended");
        Voter storage sender = voters[msg.sender];
        require(sender.authorized, "Not authorized");
        require(!sender.voted, "Already voted");
        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount++;
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
