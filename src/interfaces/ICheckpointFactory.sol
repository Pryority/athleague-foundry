// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface ICheckpointFactory {
    event CheckpointCreated(address checkpoint, int64 indexed latitude, int64 indexed longitude);

    function course() external view returns (address);

    function getCheckpoint(int64 latitude, int64 longitude) external view returns (address checkpoint);

    function createCheckpoint(int64 latitude, int64 longitude) external returns (address checkpoint);
}
