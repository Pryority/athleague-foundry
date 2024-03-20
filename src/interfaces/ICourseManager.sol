// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*import {Currency} from "../types/Currency.sol";*/
import {CourseKey} from "../types/CourseKey.sol";
import {Course} from "../libraries/Course.sol";
import {CourseId} from "../types/CourseId.sol";
import {Checkpoint} from "../libraries/Checkpoint.sol";

interface ICourseManager {
    function MAX_LATITUDE() external view returns (int32);

    function MIN_LATITUDE() external view returns (int32);

    function MAX_LONGITUDE() external view returns (int32);

    function MIN_LONGITUDE() external view returns (int32);

    /// @notice Get the current value in slot0 of the given pool
    function getSlot0(CourseId id)
        external
        view
        returns (int32 startLat, int32 startLng, uint256 completions, address leader);

    /// @notice Getter for TryInfo for the given CourseId and try index
    function getCourseTryInfo(CourseId id, int8 index) external view returns (Course.TryInfo memory);

    /// @notice Getter for the bitmap given the poolId and word position
    function getCourseBitmapInfo(CourseId id, int8 word) external view returns (uint256 tickBitmap);

    function getCheckpointByIndex(CourseId id, int8 index) external view returns (Checkpoint.Info memory checkpoint);
    /*/// @notice Get the checkpoint struct for a specified course and latitude
    function getCheckpointByLat(CourseId id, int32 latitude)
        external
        view
        returns (Checkpoint.Info memory checkpoint);

    /// @notice Get the checkpoint struct for a specified course and longitude
    function getCheckpointByLng(CourseId id, int32 longitude)
        external
        view
        returns (Checkpoint.Info memory checkpoint);*/

    /*struct ModifyCheckpointParams {
        // the lat and lng of the checkpoint
        int32 latitude;
        int32 longitude;
    }

    /// @notice Modify the liquidity for the given pool
    function modifyCheckpoint(CourseKey memory key, ModifyCheckpointParams memory params)
        external
        returns (Checkpoint.Info memory);*/

    /// @notice Called by the user to move value into ERC6909 balance
    /*function mint(address to, uint256 id, uint256 amount) external;*/
}
