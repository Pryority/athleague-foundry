// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Course {
    address public owner;
    bool public finalized;
    mapping(uint => Checkpoint) public checkpoints;
    uint public numCheckpoints;

    struct Checkpoint {
        uint lat;
        uint long;
        uint sequence;
    }

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

    function addCheckpoint(
        uint _lat,
        uint _long
    ) public onlyOwner notFinalized {
        checkpoints[numCheckpoints] = Checkpoint(_lat, _long, numCheckpoints);
        numCheckpoints++;
    }

    function removeCheckpoint(uint _sequence) public onlyOwner notFinalized {
        require(_sequence < numCheckpoints, "Invalid sequence number.");
        for (uint i = _sequence; i < numCheckpoints - 1; i++) {
            checkpoints[i] = checkpoints[i + 1];
        }
        delete checkpoints[numCheckpoints - 1];
        numCheckpoints--;
    }

    function finalizeCourse() public onlyOwner notFinalized {
        require(numCheckpoints > 0, "At least one checkpoint must be added.");
        finalized = true;
    }

    function getCheckpoints() public view returns (Checkpoint[] memory) {
        Checkpoint[] memory result = new Checkpoint[](numCheckpoints);
        for (uint i = 0; i < numCheckpoints; i++) {
            result[i] = checkpoints[i];
        }
        return result;
    }
}
