// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IERC721 {
    function balanceOf(address owner) external view returns (uint);
}

contract NFTBasedVoting {
    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    IERC721 public votingNFT;
    Proposal[] public proposals;

    constructor(bytes32[] memory proposalNames, address nftAddress) {
        votingNFT = IERC721(nftAddress);
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function vote(uint proposal) public {
        uint nftBalance = votingNFT.balanceOf(msg.sender);
        require(nftBalance > 0, "No NFT ownership");
        proposals[proposal].voteCount += nftBalance;
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

