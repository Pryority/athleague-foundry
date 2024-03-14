// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/CourseFactory.sol";
import "../src/CheckpointFactory.sol";
import "../src/interfaces/ICourseFactory.sol";
import "../src/interfaces/ICheckpointFactory.sol";

contract CourseFactoryTest is Test {
    ICourseFactory courseFactory;
    ICheckpointFactory checkpointFactory;

    function setUp() public {
        courseFactory = new CourseFactory();
        checkpointFactory = new CheckpointFactory();
    }

    function testFuzz_createCourse(int64 latitude, int64 longitude) public {
        address checkpoint = checkpointFactory.createCheckpoint(latitude, longitude);
        courseFactory.createCourse(checkpoint, 0);
    }
}
