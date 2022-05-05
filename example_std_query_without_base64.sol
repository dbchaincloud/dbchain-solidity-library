pragma solidity >=0.7.0 <0.9.0;

import "./dbchain_query_lib.sol";
import "./std_query_lib.sol";

contract DBChainQueryLib {
    using dbchain_query for string[];

    /***************************************************************************
    *  函数功能 ： where 查询
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"id","value":"1","operator":"="}]
    ***************************************************************************/
    function query_std_where(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string[] memory queryObjArray = new string[](2);
        queryObjArray[0] = stdQueryUtils.methodTable("student");
        queryObjArray[1] = stdQueryUtils.methodWhere("id", "=", "1");
        string memory querierObj = stdQueryUtils.methodObj(queryObjArray);
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"select","field":"name,age"}]
    ***************************************************************************/
    function query_std_where_select(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string[] memory queryObjArray = new string[](3);
        queryObjArray[0] = stdQueryUtils.methodTable("student");
        queryObjArray[1] = stdQueryUtils.methodWhere("age", "=", "18");
        queryObjArray[2] = stdQueryUtils.methodSelect("name,age");
        string memory querierObj = stdQueryUtils.methodObj(queryObjArray);
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"first"}]
    ***************************************************************************/
    function query_std_where_first(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string[] memory queryObjArray = new string[](3);
        queryObjArray[0] = stdQueryUtils.methodTable("student");
        queryObjArray[1] = stdQueryUtils.methodWhere("age", "=", "18");
        queryObjArray[2] = stdQueryUtils.methodFirstOrLast("first");
        string memory querierObj = stdQueryUtils.methodObj(queryObjArray);
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"last"}]
    ***************************************************************************/
    function query_std_where_last(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string[] memory queryObjArray = new string[](3);
        queryObjArray[0] = stdQueryUtils.methodTable("student");
        queryObjArray[1] = stdQueryUtils.methodWhere("age", "=", "18");
        queryObjArray[2] = stdQueryUtils.methodFirstOrLast("last");
        string memory querierObj = stdQueryUtils.methodObj(queryObjArray);
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"offset","value":"1"}]
    ***************************************************************************/
    function query_std_where_offset(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string[] memory queryObjArray = new string[](3);
        queryObjArray[0] = stdQueryUtils.methodTable("student");
        queryObjArray[1] = stdQueryUtils.methodWhere("age", "=", "18");
        queryObjArray[2] = stdQueryUtils.methodOffsetOrLimit("offset", "1");
        string memory querierObj = stdQueryUtils.methodObj(queryObjArray);
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"limit","value":"1"}]
    ***************************************************************************/

    function query_std_where_limit(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string[] memory queryObjArray = new string[](3);
        queryObjArray[0] = stdQueryUtils.methodTable("student");
        queryObjArray[1] = stdQueryUtils.methodWhere("age", "=", "18");
        queryObjArray[2] = stdQueryUtils.methodOffsetOrLimit("limit", "1");
        string memory querierObj = stdQueryUtils.methodObj(queryObjArray);
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"order","field":"id","direction":"desc"}]
    ***************************************************************************/
    function query_std_where_order(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string[] memory queryObjArray = new string[](3);
        queryObjArray[0] = stdQueryUtils.methodTable("student");
        queryObjArray[1] = stdQueryUtils.methodWhere("age", "=", "18");
        queryObjArray[2] = stdQueryUtils.methodOrder("id", "desc");
        string memory querierObj = stdQueryUtils.methodObj(queryObjArray);
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }
}