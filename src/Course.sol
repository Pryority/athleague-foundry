// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Course {
    address public owner;
    bool public finalized;
    mapping(uint256 => Checkpoint) public checkpoints;
    uint256 public numCheckpoints;

    struct Checkpoint {
        uint256 lat;
        uint256 long;
        uint256 sequence;
        bool completed;
    }

    event CheckpointCompleted(uint256, address);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(
            msg.sender == owner,
            "Only the owner can perform this operation."
        );
        _;
    }

    modifier notFinalized() {
        require(!finalized, "Course has already been finalized.");
        _;
    }

    modifier courseFinalized() {
        require(finalized, "Course has not yet been finalized.");
        _;
    }

    function addCheckpoint(
        uint256 _lat,
        uint256 _long
    ) public onlyOwner notFinalized {
        checkpoints[numCheckpoints] = Checkpoint(
            _lat,
            _long,
            numCheckpoints,
            false
        );
        numCheckpoints++;
    }

    function removeCheckpoint(uint256 _sequence) public onlyOwner notFinalized {
        require(_sequence < numCheckpoints, "Invalid sequence number.");
        for (uint256 i = _sequence; i < numCheckpoints - 1; i++) {
            checkpoints[i] = checkpoints[i + 1];
        }
        delete checkpoints[numCheckpoints - 1];
        numCheckpoints--;
    }

    function finalizeCourse() public onlyOwner notFinalized {
        require(numCheckpoints > 0, "At least one checkpoint must be added.");
        finalized = true;
    }

    function getCheckpoints()
        public
        view
        courseFinalized
        returns (Checkpoint[] memory)
    {
        Checkpoint[] memory result = new Checkpoint[](numCheckpoints);
        for (uint256 i = 0; i < numCheckpoints; i++) {
            result[i] = checkpoints[i];
        }
        return result;
    }

    function markCheckpointCompleted(
        uint256 checkpointId,
        address cpOwner
    ) public onlyOwner courseFinalized {
        require(
            !checkpoints[checkpointId].completed,
            "Checkpoint already completed"
        );

        checkpoints[checkpointId].completed = true;
        emit CheckpointCompleted(checkpointId, cpOwner);
    }
}
