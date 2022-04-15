// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./dbchain_query_lib.sol";
import "./rlpReader.sol";

contract DBChainQueryLib {
    using dbchain_query for string[];
    using RLPReader for RLPReader.RLPItem;
    using RLPReader for RLPReader.Iterator;
    using RLPReader for bytes;

    /********************************************************************
    *                                                                   *
    *                                                                   *
    *     查询接口                                                       *
    *   查询接口的返回值采用的是rlp编码                                      *
    *                                                                   *
    *********************************************************************/

    /***************************************************************************
    *  函数功能 ： 查询自己的数据库列表
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     返回值为rpl 编码的数组
    ***************************************************************************/
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

    /***************************************************************************
    *  函数功能 ： 查询数据库详情
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     返回值是 rlp编码的 数组
    *     值依次为 AppCode, AppId, DataFrozen, Description, Expiration, Name, Owner, PermissionRequired, SchemaFrozen
    ***************************************************************************/
    function query_application_info(string memory encode, string memory accessToken, string memory appCode) public view returns(string[] memory) {
        string[] memory params = new string[](3);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        bytes memory rlpBytes =  params.query_application_info();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory appStatus = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            appStatus[i] = string(ls[i].toBytes());
        }
        return appStatus;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库绑定情况
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     返回值是数据库上绑定的所有合约 rlp编码的 数组
    ***************************************************************************/
    function query_application_bind_status(string memory encode, string memory accessToken, string memory appCode) public view returns(string[] memory) {
        string[] memory params = new string[](3);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        bytes memory rlpBytes =  params.query_application_bind_status();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory appBindStatus = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            appBindStatus[i] = string(ls[i].toBytes());
        }
        return appBindStatus;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库所有表
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     返回值为rpl 编码的数组
    ***************************************************************************/
    function query_application_tables(string memory encode, string memory accessToken, string memory appCode) public view returns(string[] memory) {
        string[] memory params = new string[](3);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        bytes memory rlpBytes =  params.query_application_tables();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory tables = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            tables[i] = string(ls[i].toBytes());
        }
        return tables;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库表详情
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     返回值为rpl 编码的数组
    *     返回值依次为 Fields(数组)，Filter，Memo，Memos(数组)，Name，Owner，Trigger
    ***************************************************************************/
    function query_application_table_info(string memory encode, string memory accessToken, string memory appCode, string memory tableName) public view {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        bytes memory rlpBytes =  params.query_application_table_info();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory tables = new string[](ls.length);
        RLPReader.RLPItem memory fields = ls[0];
        string memory Fielter =  string(ls[1].toBytes());
        string memory Memo =  string(ls[2].toBytes());
        RLPReader.RLPItem memory Memos = ls[3];
        string memory Name = string(ls[4].toBytes());
        string memory Owner = string(ls[5].toBytes());
        string memory Trigger = string(ls[6].toBytes());
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库表属性
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     返回值为rpl 编码的数组
    ***************************************************************************/
    function query_application_table_option(string memory encode, string memory accessToken, string memory appCode, string memory tableName) public view returns(string[] memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        bytes memory rlpBytes =  params.query_application_table_option();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory options = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            options[i] = string(ls[i].toBytes());
        }
        return options;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库注册函数
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     返回值为rpl 编码的数组
    ***************************************************************************/
    function query_application_functions(string memory encode, string memory accessToken, string memory appCode) public view returns(string[] memory) {
        string[] memory params = new string[](3);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        bytes memory rlpBytes =  params.query_application_functions();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory functions = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            functions[i] = string(ls[i].toBytes());
        }
        return functions;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库注册函数详情
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     functionName : 函数名称
    *     返回值为rpl 编码的字符串数组
    *     返回值依次为：Body，Description，Name，Owner
    ***************************************************************************/
    function query_application_function_info(string memory encode, string memory accessToken, string memory appCode, string memory functionName) public view returns(string[] memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = functionName;
        bytes memory rlpBytes =  params.query_application_function_info();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory functionInfo = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            functionInfo[i] = string(ls[i].toBytes());
        }
        return functionInfo;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库所有自定义查询器
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     返回值为rpl 编码的字符串数组
    ***************************************************************************/
    function query_application_custom_queriers(string memory encode, string memory accessToken, string memory appCode) public view returns(string[] memory) {
        string[] memory params = new string[](3);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        bytes memory rlpBytes =  params.query_application_custom_queriers();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory queriers = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            queriers[i] = string(ls[i].toBytes());
        }
        return queriers;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库自定义查询器详情
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     querierName : 查询器名称
    *     返回值为rpl 编码的字符串数组
    *     返回值依次为：Body，Description，Name，Owner
    ***************************************************************************/
    function query_application_custom_querier_info(string memory encode, string memory accessToken, string memory appCode, string memory querierName) public view returns(string[] memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = querierName;
        bytes memory rlpBytes =  params.query_application_custom_querier_info();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory querierInfo = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            querierInfo[i] = string(ls[i].toBytes());
        }
        return querierInfo;
    }

    /***************************************************************************
    *  函数功能 ： 查询数据库自定义查询器调用
    *  函数说明 ：
    *  参数说明 ： src 包含5个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     querierName : 查询器名称
    *     querierParams  : 查询器参数
    *     假设已经注册了自定义查询器如下：
    *       function customQuery(tableName, queryString)
    *           queryTable = jsonStringToMap(queryString)
    *           queryData = findRowsBy(tableName,queryTable)
    *           return queryData:data()
    *       end
    *       调用时 ： querierName 为 customQuery
    *       参数为 ： ["worker","{\"name\":\"boa\"}"] base64编码后 ： WyJ3b3JrZXIiLCJ7XCJuYW1lXCI6XCJib2FcIn0iXQ==
    *     返回值为rpl 编码的字符串数组, 类型为string[][]
    *     我们可以定义一个结构体来获取返回的数据，接头体就是表的字段
    *     因为每张表都有4个系统字段， id, created_at, created_by, txhash， 如果您建的表有两个字段：name，age. 那么返回数据的会把字段进行升序排序
    *   所以返回后的值的顺序依次为：age,created_at, created_by,id,name, txhash.
    ***************************************************************************/
    struct queryTest {
        string age;
        string created_at;
        string created_by;
        string id;
        string name;
        string txhash;
    }

    function query_call_custom_querier(string memory encode, string memory accessToken, string memory appCode, string memory querierName, string memory querierParams) public view returns(string memory, string memory){
        string[] memory params = new string[](5);

        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = querierName;
        params[4] = querierParams;
        bytes memory rlpBytes =  params.query_call_custom_querier();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        queryTest[] memory values = new queryTest[] (ls.length);
        for (uint i = 0; i < ls.length; i++) {
            queryTest memory temp;
            RLPReader.RLPItem memory item =  ls[i];
            temp.age = string(item.toList()[0].toBytes());
            temp.created_at = string(item.toList()[1].toBytes());
            temp.created_by = string(item.toList()[2].toBytes());
            temp.id = string(item.toList()[3].toBytes());
            temp.name = string(item.toList()[4].toBytes());
            temp.txhash = string(item.toList()[5].toBytes());
            values[i] = temp;
        }
        if (ls.length != 0 ) {
            return (values[0].age, values[0].name);
        }
    }


    /***************************************************************************
    *  函数功能 ： 查询数据库自定义查询器调用
    *  函数说明 ： 功能与query_call_custom_querier一样，区别是querierParams没有base64编码
    *  参数说明 ： src 包含5个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     querierName : 查询器名称
    *     querierParams  : 查询器参数
    *     假设已经注册了自定义查询器如下：
    *       function customQuery(tableName, queryString)
    *           queryTable = jsonStringToMap(queryString)
    *           queryData = findRowsBy(tableName,queryTable)
    *           return queryData:data()
    *       end
    *       调用时 ： querierName 为 customQuery
    *       参数为 ： ["worker","{\"name\":\"boa\"}"]
    *     返回值为rpl 编码的字符串数组, 类型为string[][]
    *     我们可以定义一个结构体来获取返回的数据，接头体就是表的字段
    *     因为每张表都有4个系统字段， id, created_at, created_by, txhash， 如果您建的表有两个字段：name，age. 那么返回数据的会把字段进行升序排序
    *   所以返回后的值的顺序依次为：age,created_at, created_by,id,name, txhash.
    ***************************************************************************/
    function query_call_custom_querier_without_base64(string memory encode, string memory accessToken, string memory appCode, string memory querierName) public view returns(string memory, string memory){
        string[] memory params = new string[](5);

        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = querierName;
        string memory querierParams = '["worker","{\\\"name\\\":\\\"boa\\\"}"] ';
        params[4] = querierParams;
        bytes memory rlpBytes =  params.query_call_custom_querier_without_base64();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        queryTest[] memory values = new queryTest[] (ls.length);
        for (uint i = 0; i < ls.length; i++) {
            queryTest memory temp;
            RLPReader.RLPItem memory item =  ls[i];
            temp.age = string(item.toList()[0].toBytes());
            temp.created_at = string(item.toList()[1].toBytes());
            temp.created_by = string(item.toList()[2].toBytes());
            temp.id = string(item.toList()[3].toBytes());
            temp.name = string(item.toList()[4].toBytes());
            temp.txhash = string(item.toList()[5].toBytes());
            values[i] = temp;
        }
        if (ls.length != 0 ) {
            return (values[0].age, values[0].name);
        }
    }

    /***************************************************************************
    *  函数功能 ： 查询字段属性
    *  参数说明 ： src 包含5个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     返回值为rpl 编码的字符串数组
    ***************************************************************************/
    function query_field_option(string memory encode, string memory accessToken, string memory appCode, string memory tableName, string memory field) public view returns(string[] memory) {
        string[] memory params = new string[](5);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        params[4] = field;
        bytes memory rlpBytes =  params.query_field_option();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory options = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            options[i] = string(ls[i].toBytes());
        }
        return options;
    }

    /***************************************************************************
    *  函数功能 ： 查询字段类型
    *  参数说明 ： src 包含5个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     返回值为rpl 编码的字符串
    ***************************************************************************/
    function query_field_data_type(string memory encode, string memory accessToken, string memory appCode, string memory tableName, string memory field) public view returns(string memory) {
        string[] memory params = new string[](5);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        params[4] = field;
        bytes memory rlpBytes =  params.query_field_data_type();
        RLPReader.RLPItem memory ls = rlpBytes.toRlpItem();
        string memory dataType = string(ls.toBytes());
        return dataType;
    }

    /***************************************************************************
    *  函数功能 ： 根据id 查询一行数据
    *  参数说明 ： src 包含5个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     id  : id
     *     返回值为rpl 编码的字符串数组, 类型为string[]
    *     我们可以定义一个结构体来获取返回的数据，接头体就是表的字段
    *     因为每张表都有4个系统字段， id, created_at, created_by, txhash， 如果您建的表有两个字段：name，age. 那么返回数据的会把字段进行升序排序
    *   所以返回后的值的顺序依次为：age,created_at, created_by,id,name, txhash.
    ***************************************************************************/


    struct student {
        string age;
        string create_at;
        string create_by;
        string id;
        string name;
        string txhash;
    }

    function query_row(string memory encode, string memory accessToken, string memory appCode, string memory tableName, string memory id) public view returns(string memory,string memory,string memory,string memory,string memory,string memory) {
        string[] memory params = new string[](5);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        params[4] = id;
        bytes memory rlpBytes =  params.query_row();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList(); // must convert to an rlpItem first!

        student memory s;
        s.age  = string(ls[0].toBytes());
        s.create_at = string(ls[1].toBytes());
        s.create_by = string(ls[2].toBytes());
        s.id = string(ls[3].toBytes());
        s.name = string(ls[4].toBytes());
        s.txhash = string(ls[5].toBytes());

        return (s.age, s.create_at, s.create_by, s.id, s.name, s.txhash);
    }

    /***************************************************************************
    *  函数功能 ： 根据字段 查询所有id
    *  参数说明 ： src 包含6个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     field  : 字段名
    *     value  : 值
    *     返回值为rpl 编码的uint数组, 类型为uint[]
    ***************************************************************************/
    function query_ids(string memory encode, string memory accessToken, string memory appCode, string memory tableName, string memory field, string memory value) public view returns(uint[] memory) {
        string[] memory params = new string[](6);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        params[4] = field;
        params[5] = value;
        bytes memory rlpBytes =  params.query_ids();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        uint[] memory ids = new uint[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            ids[i] = ls[i].toUint();
        }
        return ids;

    }

    /***************************************************************************
    *  函数功能 ：  查询所有id
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     tableName : 表名
   *     返回值为rpl 编码的uint数组, 类型为uint[]
    ***************************************************************************/
    function query_all_ids(string memory encode, string memory accessToken, string memory appCode, string memory tableName) public view returns(uint[] memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        bytes memory rlpBytes =  params.query_all_ids();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        uint[] memory ids = new uint[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            ids[i] = ls[i].toUint();
        }
        return ids;
    }

    /***************************************************************************
    *  函数功能 ：  查询所有库分组
    *  参数说明 ： src 包含3个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     返回值为rpl 编码的字符串数组
    ***************************************************************************/
    function query_all_groups(string memory encode, string memory accessToken, string memory appCode) public view returns(string[] memory) {
        string[] memory params = new string[](3);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        bytes memory rlpBytes =  params.query_all_groups();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory groups = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            groups[i] = string(ls[i].toBytes());
        }
        return groups;
    }

    /***************************************************************************
    *  函数功能 ：  查询库分组详情
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     groupName : 组名
    *     返回值为rpl 编码的字符串数组
    ***************************************************************************/
    function query_group_info(string memory encode, string memory accessToken, string memory appCode, string memory groupName) public view returns(string[] memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = groupName;
        bytes memory rlpBytes =  params.query_group_info();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory groupMembers = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            groupMembers[i] = string(ls[i].toBytes());
        }
        return groupMembers;
    }

    /***************************************************************************
    *  函数功能 ：  查询表索引
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     返回值为rpl 编码的字符串数组
    ***************************************************************************/
    function query_index(string memory encode, string memory accessToken, string memory appCode, string memory tableName) public view returns(string[] memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        bytes memory rlpBytes =  params.query_index();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        string[] memory indexFields = new string[](ls.length);
        for (uint i = 0; i < ls.length; i++) {
            indexFields[i] = string(ls[i].toBytes());
        }
        return indexFields;
    }

    /***************************************************************************
    *  函数功能 ：  标准查询器
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     querierObj : 表名
    *     querierObj 示例：
    *       查询条件 ：[{"method":"table","table":"student"},{"method":"where","field":"id","value":"1","operator":"="}]
    *       base64编码 ： W3sibWV0aG9kIjoidGFibGUiLCJ0YWJsZSI6InN0dWRlbnQifSx7Im1ldGhvZCI6IndoZXJlIiwiZmllbGQiOiJpZCIsInZhbHVlIjoiMSIsIm9wZXJhdG9yIjoiPSJ9XQ==
    *     返回值为rpl 编码的字符串数组, 类型为string[][]
    *     我们可以定义一个结构体来获取返回的数据，接头体就是表的字段
    *     因为每张表都有4个系统字段， id, created_at, created_by, txhash， 如果您建的表有两个字段：name，age. 那么返回数据的会把字段进行升序排序
    *   所以返回后的值的顺序依次为：age,created_at, created_by,id,name, txhash.
    ***************************************************************************/

    event LogUint(uint x);
    function log(uint x) internal {
        emit LogUint( x);
    }

    function query_std_querier(string memory encode, string memory accessToken, string memory appCode, string memory querierObj) public view returns(string memory, string memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = querierObj;

        bytes memory rlpBytes =  params.query_std_querier();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        queryTest[] memory values = new queryTest[] (ls.length);
        for (uint i = 0; i < ls.length; i++) {
            queryTest memory temp;
            RLPReader.RLPItem[] memory item =  ls[i].toList();
            temp.age = string(item[0].toBytes());
            temp.created_at = string(item[1].toBytes());
            temp.created_by = string(item[2].toBytes());
            temp.id = string(item[3].toBytes());
            temp.name = string(item[4].toBytes());
            temp.txhash = string(item[5].toBytes());
            values[i] = temp;
        }
        if (ls.length != 0) {
            return (values[0].age, values[0].name);
        }
    }

    /***************************************************************************
    *  函数功能 ：  标准查询器
    *  函数说明 ：  功能与query_std_querier一样， 区别是querierObj没有bse64编码
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     querierObj : 表名
    *     querierObj 示例：
    *       查询条件 ：[{"method":"table","table":"student"},{"method":"where","field":"id","value":"1","operator":"="}]
    *
    *     返回值为rpl 编码的字符串数组, 类型为string[][]
    *     我们可以定义一个结构体来获取返回的数据，接头体就是表的字段
    *     因为每张表都有4个系统字段， id, created_at, created_by, txhash， 如果您建的表有两个字段：name，age. 那么返回数据的会把字段进行升序排序
    *   所以返回后的值的顺序依次为：age,created_at, created_by,id,name, txhash.
    ***************************************************************************/
    function query_std_querier_without_base64(string memory encode, string memory accessToken, string memory appCode) public view returns(string memory, string memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        string memory querierObj = '[{"method":"table","table":"student"},{"method":"where","field":"id","value":"1","operator":"="}]';
        params[3] = querierObj;

        bytes memory rlpBytes =  params.query_std_querier_without_base64();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        queryTest[] memory values = new queryTest[] (ls.length);
        for (uint i = 0; i < ls.length; i++) {
            queryTest memory temp;
            RLPReader.RLPItem[] memory item =  ls[i].toList();
            temp.age = string(item[0].toBytes());
            temp.created_at = string(item[1].toBytes());
            temp.created_by = string(item[2].toBytes());
            temp.id = string(item[3].toBytes());
            temp.name = string(item[4].toBytes());
            temp.txhash = string(item[5].toBytes());
            values[i] = temp;
        }
        if (ls.length != 0) {
            return (values[0].age, values[0].name);
        }
    }

    /***************************************************************************
    *  函数功能 ：  查询表关联
    *  参数说明 ： src 包含4个参数
    *     encode ：返回值的编码方式""json" 或者 "rlp",示例给出的是encode为rlp的解码示例，json的返回值一般用于直接返回
    *     accessToken :
    *     appCode :
    *     tableName : 表名
    *     返回值为rpl 编码的字符串数组, 类型为string[][]
    *     每一个string[]值依次为 AssociationMode, AssociationTable, ForeignKey, Method
    ***************************************************************************/
    function query_table_association(string memory encode, string memory accessToken, string memory appCode, string memory tableName) public view returns(string memory, string memory, string memory, string memory) {
        string[] memory params = new string[](4);
        params[0] = encode;
        params[1] = accessToken;
        params[2] = appCode;
        params[3] = tableName;
        bytes memory rlpBytes =  params.query_table_association();
        RLPReader.RLPItem[] memory ls = rlpBytes.toRlpItem().toList();
        if (ls.length == 0) {
            return ("","","","");
        }
        RLPReader.RLPItem[] memory item = ls[0].toList();
        string memory AssociationMode = string(item[0].toBytes());
        string memory AssociationTable = string(item[1].toBytes());
        string memory ForeignKey = string(item[2].toBytes());
        string memory Method = string(item[3].toBytes());
        return (AssociationMode, AssociationTable, ForeignKey, Method);
    }

}