// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../src/Course.sol";

contract CourseTest is Test {
    Course course;
    address owner;

    function setUp() public {
        course = new Course();
        owner = msg.sender;
    }

    function test_AddCheckpoint() public {
        course.addCheckpoint(123, 456);
        course.addCheckpoint(654, 321);
        course.build();
        Course.Checkpoint[] memory checkpoints = course.getCheckpoints();
        assertEq(checkpoints.length, 2);
        assertEq(checkpoints[0].coord.lat, 123);
        assertEq(checkpoints[0].coord.long, 456);
        assertEq(checkpoints[0].sequence, 0);
    }

    function test_RemoveCheckpoint() public {
        course.addCheckpoint(123, 456);
        course.removeCheckpoint(0);
        vm.expectRevert("At least two checkpoints must be added.");
        course.build();
    }

    function test_Build() public {
        course.addCheckpoint(123, 456);
        course.addCheckpoint(101, 202);
        course.build();
        bool built = course.built();
        assertEq(built, true);
    }

    function test_GetCheckpoints() public {
        course.addCheckpoint(123, 456);
        course.addCheckpoint(789, 101112);
        course.build();
        Course.Checkpoint[] memory checkpoints = course.getCheckpoints();
        assertEq(checkpoints.length, 2);
        assertEq(checkpoints[0].coord.lat, 123);
        assertEq(checkpoints[0].coord.long, 456);
        assertEq(checkpoints[0].sequence, 0);
        assertEq(checkpoints[1].coord.lat, 789);
        assertEq(checkpoints[1].coord.long, 101112);
        assertEq(checkpoints[1].sequence, 1);
    }

    function test_OnlyOwnerModifier() public {
        vm.prank(owner);
        Course otherCourse = new Course();
        course.addCheckpoint(654, 321);
        try otherCourse.addCheckpoint(123, 456) {
            assertTrue(false, "Function should have reverted.");
        } catch Error(string memory reason) {
            assertEq(reason, "Only the owner can perform this operation.");
        } catch {
            assertTrue(false, "Unexpected error.");
        }
        try otherCourse.removeCheckpoint(0) {
            assertTrue(false, "Function should have reverted.");
        } catch Error(string memory reason) {
            assertEq(reason, "Only the owner can perform this operation.");
        } catch {
            assertTrue(false, "Unexpected error.");
        }
        try otherCourse.build() {
            assertTrue(false, "Function should have reverted.");
        } catch Error(string memory reason) {
            assertEq(reason, "Only the owner can perform this operation.");
        } catch {
            assertTrue(false, "Unexpected error.");
        }
    }

    function test_NotBuiltModifier() public {
        course.addCheckpoint(123, 456);
        course.addCheckpoint(654, 321);
        course.build();
        vm.expectRevert("Course has already been built.");
        course.addCheckpoint(789, 101112);
    }

    function test_MarkCheckpointCompleted() public {
        course.addCheckpoint(123, 456);
        course.addCheckpoint(654, 321);
        course.build();
        vm.prank(owner);
        course.startCourse();
        course.markCheckpointCompleted(0, owner);
    }
}
