// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./checkpoint/ICheckpointImmutables.sol";
import "./checkpoint/ICheckpointState.sol";
import "./checkpoint/ICheckpointActions.sol";
import "./checkpoint/ICheckpointEvents.sol";

/// @title The interface for an Athleague Checkpoint
/// @notice A checkpoint facilitates verification of location proofs for a course they belong to
/// @dev The checkpoint interface is broken up into many smaller pieces
interface ICheckpoint is ICheckpointImmutables, ICheckpointState, ICheckpointActions, ICheckpointEvents {}
