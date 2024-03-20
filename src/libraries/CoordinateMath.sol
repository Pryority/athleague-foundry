// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/// @title CoordinateMath
library CoordinateMath {
    /// @dev The maximum latitude as 90 degrees * 10^7
    int32 internal constant MAX_LATITUDE = int32(900000000);
    /// @dev The minimum latitude as -90 degrees * 10^7
    int32 internal constant MIN_LATITUDE = int32(-900000000);
    /// @dev The maximum longitude as 180 degrees * 10^7
    int32 internal constant MAX_LONGITUDE = 1800000000;
    /// @dev The minimum latitude as -180 degrees * 10^7
    int32 internal constant MIN_LONGITUDE = -1800000000;

    function pack4Coords(uint64 c1, uint64 c2, uint64 c3, uint64 c4) public pure returns (uint256 packed) {
        packed = uint256(c1);
        packed |= uint256(c2) << 64;
        packed |= uint256(c3) << 128;
        packed |= uint256(c4) << 192;
    }

    function packCoord(int32 lat, int32 lon) public pure returns (uint64 packedCoord) {
        uint32 latitude = uint32(lat);
        uint32 longitude = uint32(lon);

        packedCoord = uint64(latitude);
        packedCoord |= uint64(longitude) << 32;
    }

    function unpack4Coords(uint256 packed4Coords) public pure returns (uint64[4] memory unpacked) {
        uint64 c1 = uint64(packed4Coords);
        uint64 c2 = uint64(packed4Coords >> 64);
        uint64 c3 = uint64(packed4Coords >> 128);
        uint64 c4 = uint64(packed4Coords >> 192);

        return [c1, c2, c3, c4];
    }
}
