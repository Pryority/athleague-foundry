// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Course} from "./Course.sol";

library CourseGetters {
    function getCourseTryInfo(Course.State storage course, int8 index) internal view returns (Course.TryInfo memory) {
        return course.tries[index];
    }

    function getCourseBitmapInfo(Course.State storage course, int8 word) internal view returns (uint256 tickBitmap) {
        return course.tryBitmap[word];
    }
}
