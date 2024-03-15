// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Pool state that never changes
/// @notice These parameters are fixed for a pool forever, i.e., the methods will always return the same values
interface ICheckpointEvents {
    event OwnerChanged(address oldOwner, address newOwner);
}
