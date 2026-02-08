// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBank {
    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
        require(msg.value > 0, 'r u kidding me?');
    }

    function addEtherV2() external payable {
        // silent fail
        (bool ok,) = address(this).call{value: msg.value}("");
    }

    function addEtherV3() external payable {
        (bool ok,) = address(this).call{value: msg.value}("");
        (bool ok1,) = address(this).call{value: msg.value}("");
        (bool ok2,) = address(this).call{value: msg.value}("");
        (bool ok3,) = address(this).call{value: msg.value}("");
        (bool ok4,) = address(this).call{value: msg.value}("");

        // loud fail
        require(ok4, 'oops');
    }

    function removeEther(uint256 amount) external payable {
        (bool ok,) = msg.sender.call{value: address(this).balance}("");
        require(ok, 'oops removeEther');
    }

    receive() external payable{}

}



