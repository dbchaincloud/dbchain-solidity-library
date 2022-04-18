# dbchain-solidity-library
solidity library to wrap dbchain precompiled contracts.  For more information, see the [dbchain documentation.](https://doc.dbchain.cloud/)

### Usage

dbchain_tx.sol contains all the txs interacting with dbchain.  And dbchain_query.sol contains all the queriers interacting with dbchain.  Other files are libs or tools.

### example

create db

```solidity
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
```



query db

```solidity
pragma solidity >=0.7.0 <0.9.0;

import "./dbchain_query_lib.sol";
import "./rlpReader.sol";

contract DBChainQueryLib {
    using dbchain_query for string[];
    using RLPReader for RLPReader.RLPItem;
    using RLPReader for RLPReader.Iterator;
    using RLPReader for bytes;

    function query_own_application(string memory encode, string memory accessToken) public view returns(string[] memory) {
        string[] memory params = new string[](2);
        params[0] = encode;
        params[1] = accessToken;
        bytes memory rlpBytes =  params.query_own_application();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory apps = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            apps[i] = string(ls[i].toBytes());
        }
        return apps;
    }
}
```

