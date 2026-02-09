// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether if no-one
          else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract.
           If the deposit is higher than the previous highest deposit, the endTime is
           updated by current time + 1 hour, the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner after the betting
           period has ended. It transfers the entire balance of the contract to the winner.
    */
    struct Bid {
        uint256 lastBid;
        address lastBidder;
        uint256 timeLastBid;
    }
    Bid bid;

    function bet() public payable {
        // your code here
        if (bid.lastBid < msg.value) {
            bid.lastBid = msg.value;
            bid.lastBidder = msg.sender;
            bid.timeLastBid = block.timestamp;
        }
    }

    function claimPrize() public {
        // your code here
        require(bid.lastBidder == msg.sender);
        // require(bid.timeLastBid + 1 hours < block.timestamp);
        require(block.timestamp >= bid.timeLastBid + 1 hours);
        (bool success,) = msg.sender.call{value: address(this).balance}("");
        require(success);
    }
}
