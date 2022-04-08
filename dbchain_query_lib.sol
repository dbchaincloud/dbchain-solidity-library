pragma solidity >=0.7.0 <0.9.0;

import "./utils.sol";

library dbchain_query {
    using utils for string[];


    /****************************************************************************
    *                                查询接口                                    *
    *****************************************************************************/


    /***************************************************************************
    *  函数功能 ： 查询自己的数据库列表
    *  函数说明 ：
    *  参数说明 ： src 包含1个参数
    *     accessToken :
    ***************************************************************************/
    function query_own_application(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 1, "80");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库详情
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     accessToken :
    *     appCode :
    ***************************************************************************/
    function query_application_info(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 2, "81");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库所有表
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     accessToken :
    *     appCode :
    ***************************************************************************/
    function query_application_tables(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 2, "82");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库表详情
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    ***************************************************************************/
    function query_application_table_info(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "83");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库表属性
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    ***************************************************************************/
    function query_application_table_option(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "84");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库注册函数
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     accessToken :
    *     appCode :
    ***************************************************************************/
    function query_application_functions(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 2, "85");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库注册函数详情
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     functionName : 函数名称
    ***************************************************************************/
    function query_application_function_info(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "86");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库所有自定义查询器
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     accessToken :
    *     appCode :
    ***************************************************************************/
    function query_application_custom_queriers(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 2, "87");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库自定义查询器详情
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     querierName : 查询器名称
    ***************************************************************************/
    function query_application_custom_querier_info(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "88");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库自定义查询器调用
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     accessToken :
    *     appCode :
    *     querierName : 查询器名称
    *     params  : 查询器参数
    *     TODO 参数示例
    ***************************************************************************/
    function query_call_custom_querier(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 4, "89");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询字段属性
    *  参数说明 ： src 包含4个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     field  : 字段名
    ***************************************************************************/
    function query_field_option(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 4, "8A");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 查询字段类型
    *  参数说明 ： src 包含4个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     field  : 字段名
    ***************************************************************************/
    function query_field_data_type(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 4, "8B");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 根据id 查询一行数据
    *  参数说明 ： src 包含4个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     id  : id
    ***************************************************************************/
    function query_row(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 4, "8C");
        return res;
    }

    /***************************************************************************
    *  函数功能 ： 根据字段 查询所有id
    *  参数说明 ： src 包含5个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     field  : 字段名
    *     value  : 值
    ***************************************************************************/
    function query_ids(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 5, "8D");
        return res;
    }

    /***************************************************************************
    *  函数功能 ：  查询所有id
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    ***************************************************************************/
    function query_all_ids(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "8E");
        return res;
    }

    /***************************************************************************
    *  函数功能 ：  查询所有库分组
    *  参数说明 ： src 包含2个参数
    *     accessToken :
    *     appCode :
    ***************************************************************************/
    function query_all_groups(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 2, "8F");
        return res;
    }

    /***************************************************************************
    *  函数功能 ：  查询库分组详情
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     groupName : 组名
    ***************************************************************************/
    function query_group_info(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "90");
        return res;
    }

    /***************************************************************************
    *  函数功能 ：  查询表索引
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    ***************************************************************************/
    function query_index(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "91");
        return res;
    }

    /***************************************************************************
    *  函数功能 ：  标准查询器
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     querierObj : 表名
    *     querierObj 示例：
    *       查询条件 ：[{"method":"table","table":"student"},{"method":"where","field":"id","value":"1","operator":"="}]
    *       base64编码 ： W3sibWV0aG9kIjoidGFibGUiLCJ0YWJsZSI6InN0dWRlbnQifSx7Im1ldGhvZCI6IndoZXJlIiwiZmllbGQiOiJpZCIsInZhbHVlIjoiMSIsIm9wZXJhdG9yIjoiPSJ9XQ==
    ***************************************************************************/
    function query_std_querier(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "92");
        return res;
    }

    /***************************************************************************
    *  函数功能 ：  查询表关联
    *  参数说明 ： src 包含3个参数
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    ***************************************************************************/
    function query_table_association(string[] memory src) public view returns(bytes memory) {
        bytes memory res = execute_query(src, 3, "93");
        return res;
    }




    function execute_query(string[] memory src, uint256 length, string memory methodCode) internal view returns (bytes memory) {
        require (src.length == length);
        string memory method = methodCode;
        string[] memory params = new string[](length + 1);
        params[0] = method;
        uint256 maxLen = 100*1000;

        for (uint i = 1; i < length + 1; i++) {
            params[i] = src[i-1];
        }
        bytes memory data = params.strCats();

        // bytes32[1] memory h;
        bytes memory h = new bytes(maxLen);

        assembly {
            if iszero(
            staticcall(not(0), 0xFE, add(data, 32), mload(data), add(h, 32), mload(h))
            ) {
                invalid()
            }
        }
        return h;
    }
}