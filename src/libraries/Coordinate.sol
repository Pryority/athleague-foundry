// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Coordinate
/// @notice Coordinates represent a location on Earth, used for Checkpoints
/// @dev Coordinates are used in the Checkpoint.Info struct
library Coordinate {
    struct Info {
        // latitude of the coordinate
        int256 lat;
        // longitude of the coordinate
        int256 long;
    }
}
