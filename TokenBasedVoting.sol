// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC20 {
    function balanceOf(address account) external view returns (uint);
}

contract TokenBasedVoting {
    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    IERC20 public votingToken;
    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames, address tokenAddress) {
        votingToken = IERC20(tokenAddress);
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function vote(uint proposal) public {
        uint voterBalance = votingToken.balanceOf(msg.sender);
        require(voterBalance > 0, "No voting tokens");
        proposals[proposal].voteCount += voterBalance;
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

