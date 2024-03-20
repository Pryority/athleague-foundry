// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Permissionless course actions
/// @notice Contains pool methods that can be called by anyonen
interface ICourseActions {
    function getCheckpoints() external view returns (address[] memory);
}
