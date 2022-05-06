pragma solidity >=0.7.0 <0.9.0;

import "./dbchain_query_lib.sol";
import "./std_query_lib.sol";

contract DBChainQueryLib {
    using dbchain_query for string[];
    using stdQueryUtils for string[];

    /***************************************************************************
    *  函数功能 ： where 查询
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"id","value":"1","operator":"="}]
    ***************************************************************************/
    function query_std_where(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string memory querierObj = stdQueryUtils.table("student").where("id", "=", "1").obj();
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询，加select 返回指定字段
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"select","field":"name,age"}]
    ***************************************************************************/
    function query_std_where_select(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string memory querierObj = stdQueryUtils.table("student").where("age", "=", "18").select("name,age").obj();
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询，返回第一条数据
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"first"}]
    ***************************************************************************/
    function query_std_where_first(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string memory querierObj = stdQueryUtils.table("student").where("age", "=", "18").firstOrLast("first").obj();
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询，返回最后一条数据
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"last"}]
    ***************************************************************************/
    function query_std_where_last(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string memory querierObj = stdQueryUtils.table("student").where("age", "=", "18").firstOrLast("last").obj();
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询， 加从第几条数据开始返回
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"offset","value":"1"}]
    ***************************************************************************/
    function query_std_where_offset(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string memory querierObj = stdQueryUtils.table("student").where("age", "=", "18").offsetOrLimit("offset", "1").obj();
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询，加limit 限制返回数量
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"limit","value":"1"}]
    ***************************************************************************/

    function query_std_where_limit(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string memory querierObj = stdQueryUtils.table("student").where("age", "=", "18").offsetOrLimit("limit", "1").obj();
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }

    /***************************************************************************
    *  函数功能 ： where 查询 加 order 排序
    *  查询原型 ：[{"method":"table","table":"student"},{"method":"where","field":"age","value":"18","operator":"="},{"method":"order","field":"id","direction":"desc"}]
    ***************************************************************************/
    function query_std_where_order(string memory accessToken, string memory appCode) public view returns(string memory) {
        string[] memory params = new string[](4);
        params[0] = "json";
        params[1] = accessToken;
        params[2] = appCode;
        string memory querierObj = stdQueryUtils.table("student").where("age", "=", "18").order("id", "desc").obj();
        params[3] = querierObj;

        bytes memory jsonBytes =  params.query_std_querier_without_base64();
        return string(jsonBytes);
    }
}