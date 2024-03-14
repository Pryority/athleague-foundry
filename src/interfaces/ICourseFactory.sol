// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @title The interface for the Athleague Course Factory
/// @notice The Athleague Course Factory facilitates creation of Athleague courses and control over the checkpoints
interface ICourseFactory {
    /// @notice Emitted when the owner of the factory is changed
    /// @param oldOwner The owner before the owner was changed
    /// @param newOwner The owner after the owner was changed
    event OwnerChanged(address indexed oldOwner, address indexed newOwner);

    /// @notice Emitted when a course is created
    /// @param course The address of the created course
    /// @param checkpoint0 The first token of the pool by address sort order
    /// @param gameMode The second token of the pool by address sort order
    event CourseCreated(address course, address indexed checkpoint0, uint8 indexed gameMode);

    /// @notice Emitted when a new fee amount is enabled for pool creation via the factory
    /// @param fee The enabled fee, denominated in hundredths of a bip
    /*event GameModeEnabled(uint8 indexed gameMode);*/

    /// @notice Returns the current owner of the factory
    /// @dev Can be changed by the current owner via setOwner
    /// @return The address of the factory owner
    function owner() external view returns (address);

    /// @notice Returns the course address for a given start checkpoint and game mode, or address 0 if it does not exist
    /// @dev startCheckpoint and tokenB may be passed in either token0/token1 or token1/token0 order
    /// @param checkpoint The contract address of a checkpoint belonging to the course
    /// @param gameMode The game mode for the course
    /// @return course The course address
    function getCourse(address checkpoint, uint8 gameMode) external view returns (address course);

    /// @notice Creates a course for the given checkpoint
    /// @param checkpoint The address of the first checkpoint of the course
    /// @param gameMode The game mode for the course
    /// from the fee. The call will revert if the pool already exists, the fee is invalid, or the token arguments
    /// are invalid.
    /// @return course The address of the newly created course
    function createCourse(address checkpoint, uint8 gameMode) external returns (address course);

    /// @notice Updates the owner of the factory
    /// @dev Must be called by the current owner
    /// @param _owner The new owner of the factory
    /*function setOwner(address _owner) external;*/

    /// @notice Enables a fee amount with the given tickSpacing
    /// @dev Fee amounts may never be removed once enabled
    /// @param gameMode The game mode for the course
    /*function enableGameMode(uint8 gameMode) external;*/
}
