// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/CourseFactory.sol";
import "../src/CheckpointFactory.sol";
import "../src/interfaces/ICourseFactory.sol";
import "../src/Course.sol";
import "../src/interfaces/ICheckpointFactory.sol";

contract CourseFactoryTest is Test {
    ICourseFactory courseFactory;
    ICheckpointFactory checkpointFactory;

    function setUp() public {
        courseFactory = new CourseFactory();
        checkpointFactory = new CheckpointFactory();
    }

    function testFuzz_createCourse(int64 lat1, int64 lng1, int64 lat2, int64 lng2) public {
        vm.assume(lat1 != lat2 && lng1 != lng2);
        vm.startPrank(address(1));
        address checkpoint1 = checkpointFactory.createCheckpoint(lat1, lng1);
        address checkpoint2 = checkpointFactory.createCheckpoint(lat2, lng2);

        address[] memory checkpoints = new address[](2);
        checkpoints[0] = checkpoint1;
        checkpoints[1] = checkpoint2;

        Course course = Course(courseFactory.createCourse(checkpoints, 0));
        vm.stopPrank();

        address[] memory courseCheckpoints = course.getCheckpoints();
        assertEq(2, courseCheckpoints.length);
    }
}
