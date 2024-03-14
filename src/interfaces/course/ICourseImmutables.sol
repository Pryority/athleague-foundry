// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title Pool state that never changes
/// @notice These parameters are fixed for a pool forever, i.e., the methods will always return the same values
interface ICourseImmutables {
    /// @notice The contract that deployed the course, which must adhere to the ICourseFactory interface
    /// @return The contract address
    function factory() external view returns (address);

    /// @notice A description of the course and its features
    /// @return The description in bytes format
    /*function checkpoints() external view returns (address[] memory);*/

    /// @notice The game mode of the course
    /// @return uint8 which can be mapped to game mode title
    function gameMode() external view returns (uint8);
}
