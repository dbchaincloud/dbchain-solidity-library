// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./dbchain_lib.sol";

contract DBChainLib {
    using dbchain  for string[];

    function create_application(string memory name, string memory description, string memory permissionRequired) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = name;
        params[1] = description;
        params[2] = permissionRequired;
        return params.create_application();
    }

}