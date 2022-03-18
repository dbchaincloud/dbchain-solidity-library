pragma solidity >=0.7.0 <0.9.0;

import "./utils.sol";

library  dbchain {
    using utils for *;

    function create_application(string[]  memory  src) public returns (bytes32){
        require (src.length == 3);
        string memory method = "01";
        string[] memory params = new string[](4);
        params[0] = method;
        params[1] = src[0];//name;
        params[2] = src[1];//description;
        params[3] = src[2];//permissionRequired;
        bytes memory data = params.strCats();
        bytes32[1] memory h;

        assembly {
            if iszero(
            call(not(0), 0xFE, 0, add(data, 32), mload(data), h, 32)
            ) {
                invalid()
            }
        }
        return h[0];
    }
}
