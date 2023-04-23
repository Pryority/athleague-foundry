// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Course {
    struct Coord {
        int256 lat;
        int256 long;
    }

    struct Checkpoint {
        Coord coord;
        uint256 sequence;
        bool completed;
    }

    Checkpoint[] public checkpoints;
    bool public built;
    address owner;

    mapping(address => uint256) public startTimes;
    mapping(address => uint256) public finishTimes;

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

    modifier notBuilt() {
        require(!built, "Course has already been built.");
        _;
    }

    modifier isBuilt() {
        require(built, "Course has not yet been built.");
        _;
    }

    function addCheckpoint(int256 lat, int256 long) public onlyOwner {
        require(!built, "Course has already been built.");
        checkpoints.push(
            Checkpoint({
                coord: Coord({lat: lat, long: long}),
                sequence: checkpoints.length,
                completed: false
            })
        );
    }

    function addCheckpoints(
        int256[] memory latitudes,
        int256[] memory longitudes
    ) public onlyOwner {
        require(!built, "Course has already been built.");
        require(
            latitudes.length == longitudes.length,
            "Number of latitudes must match number of longitudes."
        );

        for (uint256 i = 0; i < latitudes.length; i++) {
            checkpoints.push(
                Checkpoint({
                    coord: Coord({lat: latitudes[i], long: longitudes[i]}),
                    sequence: checkpoints.length,
                    completed: false
                })
            );
        }
    }

    function removeCheckpoint(uint256 index) public onlyOwner {
        require(!built, "Course has already been built.");
        require(
            checkpoints.length > 0,
            "At least one checkpoint must be added."
        );
        require(index < checkpoints.length, "Index out of bounds.");
        checkpoints[index] = checkpoints[checkpoints.length - 1];
        checkpoints.pop();
    }

    function build() public onlyOwner {
        require(!built, "Course has already been built.");
        require(
            checkpoints.length > 1,
            "At least two checkpoints must be added."
        );
        built = true;
    }

    function getCheckpoints() public view returns (Checkpoint[] memory) {
        return checkpoints;
    }

    function markCheckpointCompleted(uint256 index, address racer) public {
        require(built, "Course has not been built.");
        require(index < checkpoints.length, "Index out of bounds.");
        require(
            !checkpoints[index].completed,
            "Checkpoint has already been completed."
        );
        require(racer != address(0), "Racer address cannot be null.");
        require(
            startTimes[racer] != 0,
            "Racer has not started the course yet."
        );
        require(
            checkpoints[index].sequence == 0 ||
                checkpoints[index - 1].completed,
            "Checkpoints must be completed in order."
        );

        checkpoints[index].completed = true;

        if (index == checkpoints.length - 1) {
            finishCourse(racer);
        }
    }

    function startCourse() public {
        require(built, "Course has not been built.");
        require(
            startTimes[msg.sender] == 0,
            "Racer has already started the course."
        );

        startTimes[msg.sender] = block.timestamp;
    }

    function finishCourse(address racer) public {
        require(built, "Course has not been built.");
        require(
            checkpoints[checkpoints.length - 1].completed,
            "Course has not been completed."
        );
        require(
            startTimes[racer] != 0,
            "Racer has not started the course yet."
        );
        require(
            finishTimes[racer] == 0,
            "Racer has already finished the course."
        );

        finishTimes[racer] = block.timestamp;
    }
}
