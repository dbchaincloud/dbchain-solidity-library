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

    function drop_application(string memory appCode) public returns (bytes32){
        string[] memory params = new string[](1);
        params[0] = appCode;
        return params.drop_application();
    }

    function recover_application(string memory  appCode) public returns (bytes32){
        string[] memory params = new string[](1);
        params[0] = appCode;
        return params.recover_application();
    }

    function modify_database_user(string memory appCode, string memory action, string memory userAddress) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = action;
        params[2] = userAddress;
        return params.modify_database_user();
    }

    function add_function(string memory appCode, string memory functionName, string memory description, string memory body) public returns (bytes32){
        string[] memory params = new string[](4);
        params[0] = appCode;
        params[1] = functionName;
        params[2] = description;
        params[3] = body;
        return params.add_function();
    }

    /***************************************************************************
   *  函数功能 ： 数据库函数调用
   *  函数说明 ： 此函式是添加在数据库上的函数， 即add_function 添加的函数
   *  参数说明 ： src 包含3个参数
   *     appCode : 数据库code, 创建数据库时唯一的code
   *     functionName  : 调用的函数名
   *     argument : 调用的函数需要的参数
   *     TODO argument 参数说明
   ***************************************************************************/
    function call_function(string memory appCode, string memory functionName, string memory argument) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = functionName;
        params[2] = argument;
        return params.call_function();
    }


    /***************************************************************************
        *  函数功能 ： 添加数据库查询器
        *  函数说明 ： 用于比较复杂的查询操作
        *  参数说明 ： src 包含4个参数
        *     appCode : 数据库code, 创建数据库时唯一的code
        *     QuerierName : 查询器名称
        *     Description : 查询器描述
        *     Body : 查询器实现
        *  TODO 查询器实例
        ***************************************************************************/
    function add_querier(string memory appCode, string memory QuerierName, string memory Description, string memory Body) public returns (bytes32){
        string[] memory params = new string[](4);
        params[0] = appCode;
        params[1] = QuerierName;
        params[2] = Description;
        params[3] = Body;
        return params.add_querier();
    }

    /***************************************************************************
    *  函数功能 ： 删除数据库查询器
    *  函数说明 ： 删除添加的查询器
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     QuerierName : 查询器名称
    ***************************************************************************/
    function drop_querier(string memory  appCode, string memory  QuerierName) public returns (bytes32){
        bstring[] memory params = new string[](2);
        params[0] = appCode;
        params[1] = QuerierName;
        return params.drop_querier();
    }

    /***************************************************************************
    *  函数功能 ： 建表
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 表名
    *     fields : 字段，多个字段用逗号隔开，如"field1,field2"
    ***************************************************************************/
    function create_table(string memory  appCode, string memory  tableName, string memory  fields) public returns (bytes32){
        bstring[] memory params = new string[](2);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = fields;
        return params.create_table();
    }

    /***************************************************************************
    *  函数功能 ： 表之间建立关联
    *  函数说明 ： 设置表之间的关联关系
    *  参数说明 ： src 包含7个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     associationMode : 关联关系，有has_one, has_many, belongs_to三种关系
    *     associationTable : 要关联的表
    *     method : 方法名，用来进行关联查询的方法，一般用关联的表名做方法名
    *     foreignKey : 关联的字段
    *     option : 添加或者删除关联 add 或者 drop
    ***************************************************************************/
    function modify_table_association(string memory appCode, string memory tableName, string memory associationMode, string memory associationTable, string memory method, string memory foreignKey, string memory option) public returns (bytes32){
        bstring[] memory params = new string[](7);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = associationMode;
        params[3] = associationTable;
        params[4] = method;
        params[5] = foreignKey;
        params[6] = option;
        return params.modify_table_association();
    }

    /***************************************************************************
    *  函数功能 ： 增加一个计数字段
    *  函数说明 ： 增加一个字段统计其他表的数据
    *  参数说明 ： src 包含6个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     associationTable : 要关联的表，统计表中数据
    *     foreignKey : 关联的字段
    *     counterCacheField : 用于计数的字段
    *     limit : 限制最大插入量，当limit <= 0时，表示没有限制
    ***************************************************************************/
    function add_counter_cache(string memory appCode, string memory tableName, string memory associationTable, string memory foreignKey, string memory counterCacheField, string memory limit) public returns (bytes32){
        bstring[] memory params = new string[](6);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = associationTable;
        params[3] = foreignKey;
        params[4] = counterCacheField;
        params[5] = limit;
        return params.add_counter_cache();
    }

    /***************************************************************************
    *  函数功能 ： 新增字段
    *  函数说明 ： 在表中新增一个普通字段
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     field : 新增字段名
    ***************************************************************************/
    function add_column(string memory appCode, string memory tableName, string memory field) public returns (bytes32){
        bstring[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = field;
        return params.add_column();
    }

    /***************************************************************************
    *  函数功能 ： 删除字段
    *  函数说明 ： 删除表一个字段
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     field : 新增字段名
    ***************************************************************************/
    function drop_column(string memory appCode, string memory tableName, string memory field) public returns (bytes32){
        bstring[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = field;
        return params.drop_column();
    }

    /***************************************************************************
    *  函数功能 ： 字段重命名
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     oldField : 旧字段名
    *     newField : 新字段名
    ***************************************************************************/
    function rename_column(string memory appCode, string memory tableName, string memory oldField, string memory newField) public returns (bytes32){
        bstring[] memory params = new string[](4);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = oldField;
        params[3] = newField;
        return params.rename_column();
    }

}