// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/CheckpointFactory.sol";
import "../src/interfaces/ICheckpointFactory.sol";

contract CheckpointFactoryTest is Test {
    ICheckpointFactory factory;

    function setUp() public {
        factory = new CheckpointFactory();
    }

    function testFuzz_createCheckpoint(int64 latitude, int64 longitude) public {
        factory.createCheckpoint(latitude, longitude);
    }
}
