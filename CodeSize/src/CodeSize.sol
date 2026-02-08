// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CodeSize {
    /**
     * The challenge is to create a contract whose runtime code (bytecode) size is greater than 1kb but less than 4kb
     */
     uint256 public x = 100;
     uint256 public y = 300;

    function add2() public view returns(uint256) {
        return x + y;
    }

    function add3() public view returns(uint256) {
        return x - y;
    }

       function expr() public view returns(uint256) {
        return x ** y;
    }

       function add5() public view returns(uint256) {
        return x * y;
    }


    function add6() public view returns(uint256) {
        return x / y;
    }
}
