pragma solidity >=0.7.0 <0.9.0;

library utils {
    //uint256 转 bytes
    function toBytes(uint256  x) internal pure returns (bytes memory) {
        bytes memory b = new bytes(32);
        assembly { mstore(add(b, 32), x) }
        return b;
    }

    //两个 bytes 拼接
    function concat(bytes memory _preBytes, bytes memory _postBytes)
    internal pure returns (bytes memory)
    {
        bytes memory tempBytes;

        assembly {
        // Get a location of some free memory and store it in tempBytes as
        // Solidity does for memory variables.
            tempBytes := mload(0x40)

        // Store the length of the first bytes array at the beginning of
        // the memory for tempBytes.
            let length := mload(_preBytes)
            mstore(tempBytes, length)

        // Maintain a memory counter for the current write location in the
        // temp bytes array by adding the 32 bytes for the array length to
        // the starting location.
            let mc := add(tempBytes, 0x20)
        // Stop copying when the memory counter reaches the length of the
        // first bytes array.
            let end := add(mc, length)

            for {
            // Initialize a copy counter to the start of the _preBytes data,
            // 32 bytes into its memory.
                let cc := add(_preBytes, 0x20)
            } lt(mc, end) {
            // Increase both counters by 32 bytes each iteration.
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
            // Write the _preBytes data into the tempBytes memory 32 bytes
            // at a time.
                mstore(mc, mload(cc))
            }

        // Add the length of _postBytes to the current length of tempBytes
        // and store it as the new length in the first 32 bytes of the
        // tempBytes memory.
            length := mload(_postBytes)
            mstore(tempBytes, add(length, mload(tempBytes)))

        // Move the memory counter back from a multiple of 0x20 to the
        // actual end of the _preBytes data.
            mc := end
        // Stop copying when the memory counter reaches the new combined
        // length of the arrays.
            end := add(mc, length)

            for {
                let cc := add(_postBytes, 0x20)
            } lt(mc, end) {
                mc := add(mc, 0x20)
                cc := add(cc, 0x20)
            } {
                mstore(mc, mload(cc))
            }

        // Update the free-memory pointer by padding our last write location
        // to 32 bytes: add 31 bytes to the end of tempBytes to move to the
        // next 32 byte block, then round down to the nearest multiple of
        // 32. If the sum of the length of the two arrays is zero then add
        // one before rounding down to leave a blank 32 bytes (the length block with 0).
            mstore(0x40, and(
            add(add(end, iszero(add(length, mload(_preBytes)))), 31),
            not(31) // Round down to the nearest 32 bytes.
            ))
        }
        return tempBytes;
    }

    //多个 bytes 拼接
    function concats(bytes[] memory _postBytes)
    internal pure returns (bytes memory)
    {
        bytes memory tempBytes;
        if (_postBytes.length < 1 ) {
            return tempBytes;
        } else if (_postBytes.length == 1 ) {
            tempBytes = _postBytes[0];
            return tempBytes;
        }

        tempBytes = _postBytes[0];

        for (uint i = 1; i <  _postBytes.length; i++) {
            tempBytes = concat(tempBytes, _postBytes[i]);
        }

        return tempBytes;
    }

    //将多个字符串拼接，并添加每个字符串的长度
    function strCats(string[] memory params) internal pure returns (bytes memory) {
        bytes memory tempBytes;
        if (params.length < 1 ) {
            return tempBytes;
        }

        bytes memory lenStr1 = toBytes(bytes(params[0]).length);
        tempBytes = concat(lenStr1, bytes(params[0]));
        if (params.length == 1) {
            return tempBytes;
        }

        for (uint i = 1; i < params.length; i++) {
            bytes memory lenStr = toBytes(bytes(params[i]).length);
            tempBytes = concat(tempBytes, lenStr);
            tempBytes = concat(tempBytes, bytes(params[i]));
        }

        return tempBytes;
    }

    //将多个字符串拼接新的字符串
    function strCatsWithoutLen(string[] memory params) internal pure returns (bytes memory) {
        bytes memory tempBytes;
        if (params.length < 1 ) {
            return tempBytes;
        }

        tempBytes = params[0];
        if (params.length == 1) {
            return tempBytes;
        }

        for (uint i = 1; i < params.length; i++) {
            tempBytes = concat(tempBytes, bytes(params[i]));
        }

        return tempBytes;
    }

    function strJoin(string[] memory params, string memory sep) internal pure returns (bytes memory) {
        bytes memory tempBytes;
        if (params.length < 1 ) {
            return tempBytes;
        }

        tempBytes = params[0];
        if (params.length == 1) {
            return tempBytes;
        }

        for (uint i = 1; i < params.length; i++) {
            tempBytes = concat(tempBytes, bytes(sep));
            tempBytes = concat(tempBytes, bytes(params[i]));
        }

        return tempBytes;
    }
}