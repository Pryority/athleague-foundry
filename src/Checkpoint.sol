// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./interfaces/ICheckpoint.sol";
import "./NoDelegateCall.sol";

/// @title Checkpoint
/// @notice Checkpoints represent a location on Earth, used when constructing a Course
contract Checkpoint is ICheckpoint, NoDelegateCall {
    address public override owner;
    int64 public immutable override latitude;
    int64 public immutable override longitude;

    constructor(address _owner) {
        owner = _owner;
    }

    function getCoordinate() public view override returns (int64, int64) {
        return (latitude, longitude);
    }

    function getOwner() public view override returns (address) {
        return owner;
    }

    function setOwner(address _owner) external override {
        require(msg.sender == owner);
        emit OwnerChanged(owner, _owner);
        owner = _owner;
    }
}
