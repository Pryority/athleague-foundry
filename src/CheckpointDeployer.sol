// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "./Checkpoint.sol";
import "./interfaces/ICheckpointDeployer.sol";

contract CheckpointDeployer is ICheckpointDeployer {
    struct Parameters {
        int64 latitude;
        int64 longitude;
    }

    Parameters public override parameters;

    function deploy(int64 latitude, int64 longitude, address owner) internal returns (address checkpoint) {
        parameters = Parameters({latitude: latitude, longitude: longitude});
        checkpoint = address(new Checkpoint{salt: keccak256(abi.encode(latitude, longitude))}(owner));
        delete parameters;
    }
}
