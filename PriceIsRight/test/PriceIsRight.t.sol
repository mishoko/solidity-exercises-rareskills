// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/PriceIsRight.sol";

contract PriceIsRightTest is Test {
    PriceIsRight public priceIsRight;

    function setUp() public {
        priceIsRight = new PriceIsRight();
    }

    function testBuy(uint256 amount) external {
        amount = 2 ether;
        vm.deal(address(this), 4 ether);
        priceIsRight.buy{value: 1 ether}();

        vm.expectRevert();
        priceIsRight.buy{value: 3}();
    }
}
