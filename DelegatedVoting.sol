// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DelegatedVoting {
    struct Voter {
        bool authorized;
        bool voted;
        address delegate;
        uint vote;
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    address public chairperson;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function giveRightToVote(address voter) public {
        require(msg.sender == chairperson, "Only chairperson can authorize");
        require(!voters[voter].voted, "Already voted");
        voters[voter].authorized = true;
    }

    function delegate(address to) public {
        Voter storage sender = voters[msg.sender];
        require(sender.authorized, "Not authorized");
        require(!sender.voted, "Already voted");
        require(to != msg.sender, "Self-delegation not allowed");

        while (voters[to
