// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract Withdraw {
    // @notice make this contract able to receive ether from anyone and anyone can call withdraw below to withdraw all ether from it
    error NothingToSend();

    function withdraw() public payable {
        // your code here
        require(address(this).balance > 0, NothingToSend());
        msg.sender.call{value: address(this).balance}("");
    }

    receive() external payable {}
}
