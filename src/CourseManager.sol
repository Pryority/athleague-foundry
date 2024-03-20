// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import {Course} from "./libraries/Course.sol";
import {Checkpoint} from "./libraries/Checkpoint.sol";
import {CourseKey} from "./types/CourseKey.sol";
import {CourseGetters} from "./libraries/CourseGetters.sol";
import {CourseId, CourseIdLibrary} from "./types/CourseId.sol";
import {CoordinateMath} from "./libraries/CoordinateMath.sol";
import {ICourseManager} from "./interfaces/ICourseManager.sol";
import {NoDelegateCall} from "./NoDelegateCall.sol";

/// @notice Holds the state for all pools
contract CourseManager is ICourseManager, NoDelegateCall {
    using CourseIdLibrary for CourseKey;
    /*using SafeCast for *;*/
    using Course for *;
    /*using Hooks for IHooks;*/
    using Checkpoint for mapping(bytes32 => Checkpoint.Info);
    /*using CurrencyLibrary for Currency;*/
    /*using SwapFeeLibrary for uint24;*/
    using CourseGetters for Course.State;

    /// @inheritdoc ICourseManager
    int32 public constant MAX_LATITUDE = CoordinateMath.MAX_LATITUDE;
    /// @inheritdoc ICourseManager
    int32 public constant MIN_LATITUDE = CoordinateMath.MIN_LATITUDE;
    /// @inheritdoc ICourseManager
    int32 public constant MAX_LONGITUDE = CoordinateMath.MAX_LONGITUDE;
    /// @inheritdoc ICourseManager
    int32 public constant MIN_LONGITUDE = CoordinateMath.MIN_LONGITUDE;

    mapping(CourseId id => Course.State) courses;

    /// @inheritdoc ICourseManager
    function getSlot0(CourseId id)
        external
        view
        override
        returns (int32 startLat, int32 startLng, uint256 completions, address leader)
    {
        Course.Slot0 memory slot0 = courses[id].slot0;

        return (slot0.startLat, slot0.startLng, slot0.completions, slot0.leader);
    }

    function getCheckpointByIndex(CourseId id, int8 index)
        public
        view
        override
        returns (Checkpoint.Info memory checkpoint)
    {
        return courses[id].checkpoints[index];
    }

    /*/// @inheritdoc ICourseManager
    function initialize(CourseKey memory key, uint160 sqrtPriceX96, bytes calldata hookData)
        external
        override
        returns (int24 tick)
    {
        // see TickBitmap.sol for overflow conditions that can arise from tick spacing being too large
        if (key.tickSpacing > MAX_TICK_SPACING) revert TickSpacingTooLarge();
        if (key.tickSpacing < MIN_TICK_SPACING) revert TickSpacingTooSmall();
        if (key.currency0 >= key.currency1) revert CurrenciesOutOfOrderOrEqual();
        if (!key.hooks.isValidHookAddress(key.fee)) revert Hooks.HookAddressNotValid(address(key.hooks));

        uint24 swapFee = key.fee.getSwapFee();

        key.hooks.beforeInitialize(key, sqrtPriceX96, hookData);

        CourseId id = key.toId();
        (, uint16 protocolFee) = _fetchProtocolFee(key);

        tick = pools[id].initialize(sqrtPriceX96, protocolFee, swapFee);

        key.hooks.afterInitialize(key, sqrtPriceX96, tick, hookData);

        // On intitalize we emit the key's fee, which tells us all fee settings a pool can have: either a static swap fee or dynamic swap fee and if the hook has enabled swap or withdraw fees.
        emit Initialize(id, key.currency0, key.currency1, key.fee, key.tickSpacing, key.hooks);
    }*/

    /*function getCheckpoint(CourseId id, address _owner, int24 tickLower, int24 tickUpper)
        external
        view
        override
        returns (Course.Info memory course)
    {
        return courses[id].positions.get(_owner, tickLower, tickUpper);
    }*/

    function getCourseTryInfo(CourseId id, int8 tryInfo) external view returns (Course.TryInfo memory) {
        /*getCourseTryInfo comes from 'using CourseGetters for Course.State;' */
        return courses[id].getCourseTryInfo(tryInfo);
    }

    function getCourseBitmapInfo(CourseId id, int8 word) external view returns (uint256 tryBitmap) {
        /*getCourseBitmapInfo comes from 'using CourseGetters for Course.State;' */
        return courses[id].getCourseBitmapInfo(word);
    }

    /// @notice receive native tokens for native pools
    receive() external payable {}
}
