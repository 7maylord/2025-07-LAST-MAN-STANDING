// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import {Game} from "../src/Game.sol";

contract GameTest is Test {
    Game public game;

    address public deployer;
    address public player1;
    address public player2;
    address public player3;
    address public maliciousActor;

    // Initial game parameters for testing
    uint256 public constant INITIAL_CLAIM_FEE = 0.1 ether; // 0.1 ETH
    uint256 public constant GRACE_PERIOD = 1 days; // 1 day in seconds
    uint256 public constant FEE_INCREASE_PERCENTAGE = 10; // 10%
    uint256 public constant PLATFORM_FEE_PERCENTAGE = 5; // 5%

    function setUp() public {
        deployer = address(0x1);
        player1 = address(0x2);
        player2 = address(0x3);
        player3 = address(0x4);
        maliciousActor = address(0x5);

        game = new Game(INITIAL_CLAIM_FEE, GRACE_PERIOD, FEE_INCREASE_PERCENTAGE, PLATFORM_FEE_PERCENTAGE);
    }

    function testConstructor_RevertInvalidGracePeriod() public {
        try new Game(INITIAL_CLAIM_FEE, 0, FEE_INCREASE_PERCENTAGE, PLATFORM_FEE_PERCENTAGE) {
            assert(false); // Should have reverted
        } catch Error(string memory reason) {
            assert(keccak256(bytes(reason)) == keccak256("Game: Grace period must be greater than zero."));
        }
    }
}
