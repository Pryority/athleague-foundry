// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "../Course.sol";
import "../Checkpoint.sol";

/// @title Pool state that can change
/// @notice These methods compose the pool's state, and can change with any frequency including multiple times
/// per transaction
interface ICourseState {
    function slot0()
        external
        view
        returns (
            uint160 sqrtPriceX96,
            int24 tick,
            uint16 observationIndex,
            uint16 observationCardinality,
            uint16 observationCardinalityNext,
            uint8 totalCheckpoints,
            bool built
        );

    /*function startCheckpoint() external view returns (Checkpoint.Info);*/

    /*function finishCheckpoint() external view returns (Checkpoint.Info);*/

    function checkpoints(uint256 index)
        external
        view
        returns (
            uint128 _liquidity,
            uint256 feeGrowthInside0LastX128,
            uint256 feeGrowthInside1LastX128,
            uint128 tokensOwed0,
            uint128 tokensOwed1
        );

    function checkpoints(bytes32 key)
        external
        view
        returns (
            uint128 _liquidity,
            uint256 feeGrowthInside0LastX128,
            uint256 feeGrowthInside1LastX128,
            uint128 tokensOwed0,
            uint128 tokensOwed1
        );
}
