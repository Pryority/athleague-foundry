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
        course.finalizeCourse();
        Course.Checkpoint[] memory checkpoints = course.getCheckpoints();
        assertEq(checkpoints.length, 1);
        assertEq(checkpoints[0].lat, 123);
        assertEq(checkpoints[0].long, 456);
        assertEq(checkpoints[0].sequence, 0);
    }

    function test_RemoveCheckpoint() public {
        course.addCheckpoint(123, 456);
        course.removeCheckpoint(0);
        vm.expectRevert("At least one checkpoint must be added.");
        course.finalizeCourse();
    }

    function test_FinalizeCourse() public {
        course.addCheckpoint(123, 456);
        course.finalizeCourse();
        bool finalized = course.finalized();
        assertEq(finalized, true);
    }

    function test_GetCheckpoints() public {
        course.addCheckpoint(123, 456);
        course.addCheckpoint(789, 101112);
        course.finalizeCourse();
        Course.Checkpoint[] memory checkpoints = course.getCheckpoints();
        assertEq(checkpoints.length, 2);
        assertEq(checkpoints[0].lat, 123);
        assertEq(checkpoints[0].long, 456);
        assertEq(checkpoints[0].sequence, 0);
        assertEq(checkpoints[1].lat, 789);
        assertEq(checkpoints[1].long, 101112);
        assertEq(checkpoints[1].sequence, 1);
    }

    function test_OnlyOwnerModifier() public {
        vm.prank(owner);
        Course otherCourse = new Course();
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
        try otherCourse.finalizeCourse() {
            assertTrue(false, "Function should have reverted.");
        } catch Error(string memory reason) {
            assertEq(reason, "Only the owner can perform this operation.");
        } catch {
            assertTrue(false, "Unexpected error.");
        }
    }

    function test_NotFinalizedModifier() public {
        course.addCheckpoint(123, 456);
        course.finalizeCourse();
        vm.expectRevert("Course has already been finalized.");
        course.addCheckpoint(789, 101112);
    }

    function test_MarkCheckpointCompleted() public {
        course.addCheckpoint(123, 456);
        course.finalizeCourse();
        course.markCheckpointCompleted(0, owner);
    }
}
