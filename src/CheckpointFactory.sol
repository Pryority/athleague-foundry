// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Checkpoint.sol";
import "./CheckpointDeployer.sol";
import "./NoDelegateCall.sol";
import "./interfaces/ICheckpointFactory.sol";

contract CheckpointFactory is ICheckpointFactory, CheckpointDeployer, NoDelegateCall {
    /*using Checkpoint for Checkpoint.Info;*/

    mapping(int64 => mapping(int64 => address)) public override getCheckpoint;

    /// @inheritdoc ICheckpointFactory
    function createCheckpoint(int64 latitude, int64 longitude, address owner)
        external
        override
        noDelegateCall
        returns (address checkpoint)
    {
        require(getCheckpoint[latitude][longitude] == address(0));
        checkpoint = deploy(latitude, longitude, owner);
        getCheckpoint[latitude][longitude] = checkpoint;
        emit CheckpointCreated(checkpoint, latitude, longitude);
    }

    /// @inheritdoc ICheckpointFactory
    function createCheckpoints(int64[] calldata latitudes, int64[] calldata longitudes, address owner)
        external
        override
        noDelegateCall
        returns (address[] memory checkpoints)
    {
        require(latitudes.length == longitudes.length, "Array lengths must match");

        uint256 numCheckpoints = latitudes.length;
        checkpoints = new address[](numCheckpoints);

        for (uint256 i = 0; i < numCheckpoints; i++) {
            int64 latitude = latitudes[i];
            int64 longitude = longitudes[i];

            require(getCheckpoint[latitude][longitude] == address(0), "Checkpoint already exists");
            checkpoints[i] = deploy(latitude, longitude, owner);
            getCheckpoint[latitude][longitude] = checkpoints[i];
            emit CheckpointCreated(checkpoints[i], latitude, longitude);
        }
    }
}
