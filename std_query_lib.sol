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

    function table(string memory tableName) public pure returns(string[] memory) {
        string[] memory data = new string[](3);
        data[0] = '{ "method" : "table", "table" : "';
        data[1] = tableName;
        data[2] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        string[] memory conditions = new string[](1);
        conditions[0] = string(bz);
        return conditions;
    }

    /************************************************************************
    *
    * 说明 ：申明查询条件
    * 示例 ：{"method":"where","field":"id","value":"1","operator":"="}
    *
    ************************************************************************/

    function where(string[] memory conditions, string memory fieldName, string memory operator, string memory value) public pure returns(string[] memory) {
        string[] memory data = new string[](7);
        data[0] = '{"method" : "where", "field" : "';
        data[1] = fieldName;
        data[2] = '", "operator" : "';
        data[3] = operator;
        data[4] = '", "value" : "';
        data[5] = value;
        data[6] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        string[] memory newConditions = stringArrayAppend(conditions, string(bz));
        return newConditions;
    }

    /************************************************************************
    *
    * 说明 ：申明返回的字段，字段用逗号隔开
    * 示例 ：{"method":"select","field":"name,age"}
    *
    ************************************************************************/

    function select(string[] memory conditions, string memory fields) public pure returns(string[] memory) {
        string[] memory data = new string[](3);
        data[0] = '{"method" : "select", "fields" : "';
        data[1] = fields;
        data[2] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        string[] memory newConditions = stringArrayAppend(conditions, string(bz));
        return newConditions;
    }

    /************************************************************************
    *
    * 说明 ：根据id查询
    * 示例 ：{"method":"find","id":"1"}
    *
    ************************************************************************/

    function find(string[] memory conditions, string memory id) public pure returns(string[] memory) {
        string[] memory data = new string[](3);
        data[0] = '{"method" : "find", "id" : "';
        data[1] = id;
        data[2] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        string[] memory newConditions = stringArrayAppend(conditions, string(bz));
        return newConditions;
    }

    /************************************************************************
    *
    * 说明 ：查询返回第一条或者最后一条数据
    * 示例 ：{"method":"first"} 或者 {"method":"last"}
    *
    ************************************************************************/

    function firstOrLast(string[] memory conditions, string memory method) public pure returns(string[] memory) {
        string[] memory data = new string[](3);
        data[0] = '{"method" : "';
        data[1] = method;
        data[2] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        string[] memory newConditions = stringArrayAppend(conditions, string(bz));
        return newConditions;
    }

    /************************************************************************
    *
    * 说明 ：offset 设置从第几条数据开始返回， limit 设置返回数据条数
    * 示例 ：{"method":"limit","value":"1"} ， {"method":"offset","value":"1"}
    *
    ************************************************************************/

    function offsetOrLimit(string[] memory conditions, string memory method, string memory value) public pure returns(string[] memory) {
        string[] memory data = new string[](5);
        data[0] = '{"method" : "';
        data[1] = method;
        data[2] = '", "value" : "';
        data[3] = value;
        data[4] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        string[] memory newConditions = stringArrayAppend(conditions, string(bz));
        return newConditions;
    }

    /************************************************************************
    *
    * 说明 ：申明排序方式
    * 示例 ：{"method":"order","field":"name","direction":"desc"}
    *
    ************************************************************************/

    function order(string[] memory conditions, string memory fieldName, string memory sort) public pure returns(string[] memory) {
        string[] memory data = new string[](5);
        data[0] = '{"method" : "order", "field" : "';
        data[1] = fieldName;
        data[2] = '", "direction" : "';
        data[3] = sort;
        data[4] = '"}';
        bytes memory bz = data.strCatsWithoutLen();
        string[] memory newConditions = stringArrayAppend(conditions, string(bz));
        return newConditions;
    }


    /************************************************************************
    *
    * 说明 ：将各个查询条件拼接起来
    * 示例 ：[{"method":"table","table":"student"},{"method":"where","field":"id","value":"1","operator":"="}]
    *
    ************************************************************************/

    function obj(string[] memory elems) public pure returns(string memory) {
        string[] memory data = new string[](3);
        data[0] = '[';
        data[2] = ']';
        bytes memory bz = elems.strJoin(",");
        data[1] = string(bz);
        bytes memory queryObj = data.strCatsWithoutLen();
        return string(queryObj);
    }

    // help function
    function stringArrayAppend(string[] memory src, string memory newString) public pure returns(string[] memory) {
        string[] memory result = new string[](src.length + 1);
        for (uint256 i = 0; i < src.length; i++) {
            result[i] = src[i];
        }
        result[src.length] = newString;
        return result;
    }
}