// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "./Checkpoint.sol";
import "./interfaces/ICheckpointDeployer.sol";

contract CheckpointDeployer is ICheckpointDeployer {
    struct Parameters {
        address course;
        int64 latitude;
        int64 longitude;
    }

    Parameters public override parameters;

    function deploy(address course, int64 latitude, int64 longitude) internal returns (address checkpoint) {
        parameters = Parameters({course: course, latitude: latitude, longitude: longitude});
        checkpoint = address(new Checkpoint{salt: keccak256(abi.encode(latitude, longitude))}());
        delete parameters;
    }
}
