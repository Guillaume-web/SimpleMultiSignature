// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import 'foundry-test-utility/contracts/utils/console.sol';
import '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import { CheatCodes } from 'foundry-test-utility/contracts/utils/cheatcodes.sol';
import { Helper } from './shared/helper.t.sol';
import { SimpleMultiSignature } from '../SimpleMultiSignature.sol';

contract Test_Enzo_SimpleMultiSignature is Helper, CheatCodes {
  SimpleMultiSignature public multiSignature;
  uint8 LOG_LEVEL = 0;
  address public owner1;
  address public owner2;
  address public owner3;
  address public owner4;
  address public owner5;

  address public notOwner1;
  address public notOwner2;
  address public notOwner3;
  address public notOwner4;
  address public notOwner5;

  function setUp(uint8 LOG_LEVEL_) public {
    // Set general test settings
    _LOG_LEVEL = LOG_LEVEL_;
    vm.roll(1);
    vm.warp(100);

    owner1 = vm.addr(1);
    owner2 = vm.addr(2);
    owner3 = vm.addr(3);
    owner4 = vm.addr(4);
    owner5 = vm.addr(5);

    notOwner1 = vm.addr(6);
    notOwner2 = vm.addr(7);
    notOwner3 = vm.addr(8);
    notOwner4 = vm.addr(9);
    notOwner5 = vm.addr(10);

    vm.roll(block.number + 1);
    vm.warp(block.timestamp + 100);
  }

  function test_owner_and_threshold_set() public {
    vm.prank(owner1);
    multiSignature = new SimpleMultiSignature([owner1, owner2, owner3, owner4, owner5], 3);

    assertEq(multiSignature.threshold(), 3);
    assertTrue(owner1);
    assertTrue(owner2);
    assertTrue(owner3);
    assertTrue(owner4);
    assertTrue(owner5);

    assertTrue(!notOwner1);
    assertTrue(!notOwner2);
  }
}
