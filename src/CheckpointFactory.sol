// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Checkpoint.sol";
import "./CheckpointDeployer.sol";
import "./NoDelegateCall.sol";
import "./interfaces/ICheckpointFactory.sol";

contract CheckpointFactory is ICheckpointFactory, CheckpointDeployer, NoDelegateCall {
    /*using Checkpoint for Checkpoint.Info;*/

    /// @inheritdoc ICheckpointFactory
    address public override course;
    mapping(int64 => mapping(int64 => address)) public override getCheckpoint;

    constructor() {
        course = msg.sender;
    }

    /// @inheritdoc ICheckpointFactory
    function createCheckpoint(int64 latitude, int64 longitude)
        external
        override
        noDelegateCall
        returns (address checkpoint)
    {
        require(getCheckpoint[latitude][longitude] == address(0));
        checkpoint = deploy(address(this), latitude, longitude);
        getCheckpoint[latitude][longitude] = checkpoint;
        emit CheckpointCreated(checkpoint, latitude, longitude);
    }
}
