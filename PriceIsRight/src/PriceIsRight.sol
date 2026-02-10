// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract PriceIsRight {
    /// @dev make this function revert unless exactly 1 ether is sent as value in the function call
    error ValueNot1ETH(uint x);
    function buy() public payable {
        /// your code here
        // require(msg.value == 1 ether);
        // require(msg.value == 1e18);
        if (msg.value != 1 ether) {
            revert ValueNot1ETH(msg.value);
        }

    }
}
