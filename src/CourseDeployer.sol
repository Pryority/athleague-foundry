// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.19;

import "./interfaces/ICourseDeployer.sol";
import "./Course.sol";

contract CourseDeployer is ICourseDeployer {
    struct Parameters {
        address factory;
        address checkpoint0;
        uint8 gameMode;
    }

    Parameters public override parameters;

    /// @dev Deploys a course with the given parameters by transiently setting the parameters storage slot and then
    /// clearing it after deploying the course.
    /// @param factory The contract address of the Athleague Course factory
    /// @param checkpoint0 The first checkpoint of the course as bytes32
    /// @param gameMode The gameMode of the course as uint8
    function deploy(address factory, address checkpoint0, uint8 gameMode)
        internal
        returns (address course)
    {
        parameters = Parameters({
            factory: factory,
            checkpoint0: checkpoint0,
            gameMode: gameMode
        });
        course = address(new Course{salt: keccak256(abi.encode(checkpoint0, gameMode))}());
        delete parameters;
    }
}
