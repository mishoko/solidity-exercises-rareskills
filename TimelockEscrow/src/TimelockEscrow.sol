// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */
    uint256 public constant ESCROW_INTERACTIONS_ALLOWED = 3 days;
    mapping(address => Escrow) buyersEscrows;

    error ZeroValueSent(uint256);
    error UnclaimedUserEscrow();

    // buyer, balanceOfEscrow
    struct Escrow {
        uint256 amountContributed;
        bool isClaimed;
        uint256 timeInitialContribution;
    }

    // |-----------------|----------------|
    constructor() {
        seller = msg.sender;
    }

    /**
     * creates a buy order between msg.sender and seller
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but after which only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        require(msg.value > 0, ZeroValueSent(msg.value));
        require(buyersEscrows[msg.sender].isClaimed == false, UnclaimedUserEscrow());
        buyersEscrows[msg.sender] = Escrow(msg.value, false, block.timestamp);
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(msg.sender == seller);
        require(buyersEscrows[buyer].isClaimed == false, "this one is claimed");
        require(block.timestamp > buyersEscrows[buyer].timeInitialContribution + ESCROW_INTERACTIONS_ALLOWED);
        buyersEscrows[buyer].isClaimed == true;
        (bool ok,) = seller.call{value: buyersEscrows[buyer].amountContributed}("");
        require(ok, "err during sellerWithdraw!");
    }

    /**
     * allows buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        require(buyersEscrows[msg.sender].isClaimed == false, "already claimed");
        require(buyersEscrows[msg.sender].timeInitialContribution + 3 days > block.timestamp);
        require(buyersEscrows[msg.sender].amountContributed > 0);
        (bool ok,) = msg.sender.call{value: buyersEscrows[msg.sender].amountContributed}("");
        require(ok, "err during buyerWithdraw!");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        require(buyersEscrows[buyer].isClaimed == false, "already claimed");
        return buyersEscrows[buyer].amountContributed;
    }
}
