// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Checkpoint} from "../libraries/Checkpoint.sol";

/// @notice Returns the key for identifying a course
struct CourseKey {
    // the first checkpoint
    Checkpoint.Info start;
    // the last checkpoint
    Checkpoint.Info end;
}
