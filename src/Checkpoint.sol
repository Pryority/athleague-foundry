// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./interfaces/ICheckpoint.sol";
import "./NoDelegateCall.sol";

/// @title Checkpoint
/// @notice Checkpoints represent a location on Earth, used when constructing a Course
contract Checkpoint is ICheckpoint, NoDelegateCall {
    address public immutable override course;
    int64 public immutable override latitude;
    int64 public immutable override longitude;
}
