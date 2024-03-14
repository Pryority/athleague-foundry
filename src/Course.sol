// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Checkpoint.sol";
import "./interfaces/ICourse.sol";
import "./interfaces/ICourseDeployer.sol";

contract Course is ICourse, NoDelegateCall {
    /*using Checkpoint for Checkpoint.Info;*/

    struct Info {
        mapping(address => mapping(uint256 => bool)) checkpointsCompleted;
        uint256 numCheckpoints;
    }

    address public immutable override factory;
    address[] public checkpoints;
    uint8 public immutable override gameMode;

    /*mapping(address => uint256) public startTimes;
    mapping(address => uint256) public finishTimes;*/

    constructor(address[] memory _checkpoints) {
        (factory, gameMode) = ICourseDeployer(msg.sender).parameters();
        require(_checkpoints.length > 0, "At least one checkpoint is required");
        checkpoints = _checkpoints;
    }
    /*modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this operation.");
        _;
    }*/

    /*
    function markCheckpointCompleted(Info storage info, address player, uint256 index) internal {
        require(index < info.numCheckpoints, "Index out of bounds");
        require(!isCheckpointCompleted(info, player, index), "Checkpoint already completed.");

        info.checkpointsCompleted[player][index] = true;
    }

    function isCheckpointCompleted(Info storage info, address player, uint256 index) internal view returns (bool) {
        require(index < info.numCheckpoints, "Index out of bounds.");

        return info.checkpointsCompleted[player][index];
    }


    modifier isBuilt() {
        require(built, "Course has not yet been built.");
        _;
    }

    function buy(bytes32 commitment) public payable {
        require(msg.value >= 0.001 ether);
        require(now < ticketingCloses);

        commitments[msg.sender] = commitment;
    }

    function createRaceCommitment(address player, uint256 rand) public pure returns (bytes32) {
        return keccak256(abi.encode(player, rand));
    }
    */
    /*function addCheckpoint(int256 lat, int256 long) public onlyOwner {
        checkpoints.push(
            Checkpoint({coord: Coord({lat: lat, long: long}), sequence: checkpoints.length, completed: false})
        );
    }

    function addCheckpoints(int256[] memory latitudes, int256[] memory longitudes) public onlyOwner {
        require(latitudes.length == longitudes.length, "Number of latitudes must match number of longitudes.");

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
        require(checkpoints.length > 0, "At least one checkpoint must be added.");
        require(index < checkpoints.length, "Index out of bounds.");
        checkpoints[index] = checkpoints[checkpoints.length - 1];
        checkpoints.pop();
    }

    function build() public onlyOwner {
        require(checkpoints.length > 1, "At least two checkpoints must be added.");
        built = true;
    }

    function getCheckpoints() public view returns (Checkpoint[] memory) {
        return checkpoints;
    }*/

    /*

    function markCheckpointCompleted(uint256 index, address racer) public {
        require(index < checkpoints.length, "Index out of bounds.");
        require(!checkpoints[index].completed, "Checkpoint has already been completed.");
        require(racer != address(0), "Racer address cannot be null.");
        require(startTimes[racer] != 0, "Racer has not started the course yet.");
        require(
            checkpoints[index].sequence == 0 || checkpoints[index - 1].completed,
            "Checkpoints must be completed in order."
        );

        checkpoints[index].completed = true;

        if (index == checkpoints.length - 1) {
            finishCourse(racer);
        }
    }

    function startCourse() public {
        require(startTimes[msg.sender] == 0, "Racer has already started the course.");

        startTimes[msg.sender] = block.timestamp;
    }

    function finishCourse(address racer) public {
        require(checkpoints[checkpoints.length - 1].completed, "Course has not been completed.");
        require(startTimes[racer] != 0, "Racer has not started the course yet.");
        require(finishTimes[racer] == 0, "Racer has already finished the course.");

        finishTimes[racer] = block.timestamp;
    }*/
}
