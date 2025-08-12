// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Vm.sol";

// Medusa cheatsheet interface for compatibility
contract Cheats {
    Vm private constant vm = Vm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);
    
    function prank(address msgSender) external {
        vm.prank(msgSender);
    }
    
    function startPrank(address msgSender) external {
        vm.startPrank(msgSender);
    }
    
    function stopPrank() external {
        vm.stopPrank();
    }
    
    function deal(address to, uint256 give) external {
        vm.deal(to, give);
    }
    
    function warp(uint256 newTimestamp) external {
        vm.warp(newTimestamp);
    }
    
    function skip(uint256 time) external {
        vm.warp(block.timestamp + time);
    }
    
    function roll(uint256 newHeight) external {
        vm.roll(newHeight);
    }
    
    function expectRevert() external {
        vm.expectRevert();
    }
    
    function expectRevert(bytes4 revertData) external {
        vm.expectRevert(revertData);
    }
    
    function expectRevert(bytes calldata revertData) external {
        vm.expectRevert(revertData);
    }
}