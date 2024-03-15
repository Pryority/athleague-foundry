// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Permissionless checkpoint actions
/// @notice Contains pool methods that can be called by anyonen
interface ICheckpointActions {
    function getOwner() external view returns (address);
    function getCoordinate() external view returns (int64, int64);
}
