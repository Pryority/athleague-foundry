// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title An interface for a contract that is capable of deploying Athleague Courses
/// @notice A contract that constructs a course must implement this to pass arguments to the course
/// @dev This is used to avoid having constructor arguments in the course contract, which results in the init code hash
/// of the course being constant allowing the CREATE2 address of the course to be cheaply computed on-chain
interface ICourseDeployer {
    /// @notice Get the parameters to be used in constructing the course, set transiently during course creation.
    /// @dev Called by the course constructor to fetch the parameters of the pool
    /// Returns factory The factory address
    /// Returns description The description of the features of the course
    function parameters() external view returns (address factory, uint8 gameMode);
}
