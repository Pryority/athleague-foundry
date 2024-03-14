// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Pool state that never changes
/// @notice These parameters are fixed for a pool forever, i.e., the methods will always return the same values
interface ICheckpointImmutables {
    /// @notice The course contract that deployed the checkpoint, which must adhere to the ... interface
    /// @return The contract address
    function course() external view returns (address);

    /// @notice The latitude of the checkpoint
    /// @return The latitude of the checkpoint coordinate as int64
    function latitude() external view returns (int64);

    /// @notice The longitude of the checkpoint
    /// @return The longitude of the checkpoint coordinate as int64
    function longitude() external view returns (int64);
}
