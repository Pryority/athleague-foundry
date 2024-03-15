// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/CheckpointFactory.sol";
import "../src/interfaces/ICheckpointFactory.sol";

contract CheckpointFactoryTest is Test {
    ICheckpointFactory factory;
    address alice;

    function setUp() public {
        alice = makeAddr("alice");
        factory = new CheckpointFactory();
    }

    function test_createCheckpoints() public {
        vm.startPrank(alice);
        int64[] memory latitudes = new int64[](2);
        latitudes[0] = int64(3782843421461088);
        latitudes[1] = int64(3784643521462498);
        int64[] memory longitudes = new int64[](2);
        longitudes[0] = int64(-8782843421461069);
        longitudes[1] = int64(-7784643521462420);
        uint256 numCheckpoints = latitudes.length;
        for (uint256 i = 0; i < numCheckpoints; i++) {
            address checkpoint = factory.createCheckpoint(latitudes[i], longitudes[i], alice);
            address returnedCheckpoint = factory.getCheckpoint(latitudes[i], longitudes[i]);
            assertEq(checkpoint, returnedCheckpoint);
        }
        vm.stopPrank();
    }

    function testFuzz_createCheckpoint(int64 latitude, int64 longitude) public {
        vm.startPrank(alice);
        address checkpoint = factory.createCheckpoint(latitude, longitude, alice);
        Checkpoint returnedCheckpoint = Checkpoint(factory.getCheckpoint(latitude, longitude));
        assertEq(checkpoint, address(returnedCheckpoint));
        address checkpointOwner = returnedCheckpoint.getOwner();
        assertEq(alice, checkpointOwner);
        vm.stopPrank();
    }
}
