// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Checkpoint state that can change
/// @notice These methods should only be controlled by the owner
interface ICheckpointState {
    function setOwner(address _owner) external;
}
