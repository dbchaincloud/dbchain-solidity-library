pragma solidity >=0.7.0 <0.9.0;



//该库是用于在合约内部拼接标准查询对象，该查询不用base64编码

import "./utils.sol";

library stdQueryUtils {
    using utils for string[];

    /************************************************************************
    *
    * 说明 ：申明需要查询的表
    * 示例 ：{"method":"table","table":"tableName"}
    *
    ************************************************************************/

    function methodTable(string memory tableName) public pure returns(string memory) {
        string[] memory data = new string[](3);
        data[0] = '{ "method" : "table", "table" : "';
        data[1] = tableName;
        data[2] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        return string(bz);
    }

    /************************************************************************
    *
    * 说明 ：申明查询条件
    * 示例 ：{"method":"where","field":"id","value":"1","operator":"="}
    *
    ************************************************************************/

    function methodWhere(string memory fieldName, string memory operator, string memory value) public pure returns(string memory) {
        string[] memory data = new string[](7);
        data[0] = '{"method" : "where", "field" : "';
        data[1] = fieldName;
        data[2] = '", "operator" : "';
        data[3] = operator;
        data[4] = '", "value" : "';
        data[5] = value;
        data[6] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        return string(bz);
    }

    /************************************************************************
    *
    * 说明 ：申明返回的字段，字段用逗号隔开
    * 示例 ：{"method":"select","field":"name,age"}
    *
    ************************************************************************/

    function methodSelect(string memory fields) public pure returns(string memory) {
        string[] memory data = new string[](3);
        data[0] = '{"method" : "select", "fields" : "';
        data[1] = fields;
        data[2] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        return string(bz);
    }

    /************************************************************************
    *
    * 说明 ：根据id查询
    * 示例 ：{"method":"find","id":"1"}
    *
    ************************************************************************/

    function methodFind(string memory id) public pure returns(string memory) {
        string[] memory data = new string[](3);
        data[0] = '{"method" : "select", "find" : "';
        data[1] = id;
        data[2] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        return string(bz);
    }

    /************************************************************************
    *
    * 说明 ：查询返回第一条或者最后一条数据
    * 示例 ：{"method":"first"} 或者 {"method":"last"}
    *
    ************************************************************************/

    function methodFirstOrLast(string memory method) public pure returns(string memory) {
        string[] memory data = new string[](3);
        data[0] = '{"method" : "';
        data[1] = method;
        data[2] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        return string(bz);
    }

    /************************************************************************
    *
    * 说明 ：offset 设置从第几条数据开始返回， limit 设置返回数据条数
    * 示例 ：{"method":"limit","value":"1"} ， {"method":"offset","value":"1"}
    *
    ************************************************************************/

    function methodOffsetOrLimit(string memory method, string memory value) public pure returns(string memory) {
        string[] memory data = new string[](5);
        data[0] = '{"method" : "';
        data[1] = method;
        data[2] = '", "value" : "';
        data[3] = value;
        data[4] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        return string(bz);
    }

    /************************************************************************
    *
    * 说明 ：申明排序方式
    * 示例 ：{"method":"order","field":"name","direction":"desc"}
    *
    ************************************************************************/

    function methodOrder(string memory fieldName, string memory order) public pure returns(string memory) {
        string[] memory data = new string[](5);
        data[0] = '{"method" : "order", "field" : "';
        data[1] = fieldName;
        data[2] = '", "direction" : "';
        data[3] = order;
        data[4] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        return string(bz);
    }


    /************************************************************************
    *
    * 说明 ：将各个查询条件拼接起来
    * 示例 ：[{"method":"table","table":"student"},{"method":"where","field":"id","value":"1","operator":"="}]
    *
    ************************************************************************/

    function methodObj(string[] memory elems) public pure returns(string memory) {
        string[] memory data = new string[](3);
        data[0] = '[';
        data[2] = ']';
        bytes memory bz = elems.strJoin(",");
        data[1] = string(bz);
        bytes memory obj = data.strCatsWithoutLen();
        return string(obj);
    }
}