// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface ICheckpointFactory {
    event CheckpointCreated(address checkpoint, int64 indexed latitude, int64 indexed longitude);

    function getCheckpoint(int64 latitude, int64 longitude) external view returns (address checkpoint);

    function createCheckpoint(int64 latitude, int64 longitude, address owner) external returns (address checkpoint);

    function createCheckpoints(int64[] calldata latitudes, int64[] calldata longitudes, address owner)
        external
        returns (address[] memory checkpoints);
}
