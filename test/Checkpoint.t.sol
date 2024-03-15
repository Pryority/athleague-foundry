// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/CheckpointFactory.sol";
import "../src/interfaces/ICheckpointFactory.sol";

contract CheckpointTest is Test {
    ICheckpointFactory factory;
    address alice;
    address bob;

    function setUp() public {
        alice = makeAddr("alice");
        factory = new CheckpointFactory();
    }

    function testFuzz_setOwner(int64 latitude, int64 longitude, address someAddress) public {
        vm.startPrank(alice);

        address checkpointAddress = factory.createCheckpoint(latitude, longitude, alice);
        Checkpoint checkpoint = Checkpoint(factory.getCheckpoint(latitude, longitude));
        checkpoint.setOwner(someAddress);
        address checkpointOwner = checkpoint.getOwner();

        assertEq(checkpointAddress, address(checkpoint));
        assertEq(someAddress, checkpointOwner);

        vm.stopPrank();
    }
}
