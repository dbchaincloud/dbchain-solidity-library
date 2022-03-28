// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./dbchain_lib.sol";

contract DBChainLib {
    using dbchain  for string[];

    /***************************************************************************
    *  函数功能 ： 创建数据库
    *  函数说明 ： 无
    *  参数说明 ： src 包含3个参数
    *    name  数据库名称
    *    description  数据库描述
    *    permissionRequired  是否需要访问权限  true 或者 false
    ***************************************************************************/
    function create_application(string memory name, string memory description, string memory permissionRequired) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = name;
        params[1] = description;
        params[2] = permissionRequired;
        return params.create_application();
    }

    /***************************************************************************
    *  函数功能 ： 数据库废弃
    *  函数说明 ： 该交易不是真正的废弃数据库,只是把数据库设置为不可写和不可读取状态.可以恢复
    *  参数说明 ： src 包含1个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    ***************************************************************************/
    function drop_application(string memory appCode) public returns (bytes32){
        string[] memory params = new string[](1);
        params[0] = appCode;
        return params.drop_application();
    }

    /***************************************************************************
    *  函数功能 ： 数据库恢复
    *  函数说明 ： 把数据库从废弃状态恢复为正常状态
    *  参数说明 ： src 包含1个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    ***************************************************************************/
    function recover_application(string memory  appCode) public returns (bytes32){
        string[] memory params = new string[](1);
        params[0] = appCode;
        return params.recover_application();
    }

    /***************************************************************************
    *  函数功能 ： 修改数据库使用者, 增加或者删除
    *  函数说明 ： 当创建数据库时将permissionRequired 设为true 时, 需要把其他用户添加到user组, 用户才有读写权限
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     action  : 添加或者删除用户, add, drop
    *     userAddress : 用户地址
    ***************************************************************************/
    function modify_database_user(string memory appCode, string memory action, string memory userAddress) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = action;
        params[2] = userAddress;
        return params.modify_database_user();
    }

    /***************************************************************************
    *  函数功能 ： 为数据库添加函数
    *  函数说明 ： 为数据库添加函数，该函数可对数据库进行写操作。一般用于比较复杂的插入操作，如多表插入
    *  参数说明 ： src 包含4个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     functionName  : 添加的函数名
    *     description : 函数描述，base64 编码
    *     body : 函数内容， base64 编码
    *     添加函数实例 :
    *     函数原型 ：
    *           function funcInsert(t1, v1)
    *           fields = jsonStringToMap(v1)
    *           id, err = InsertRow(t1, fields)
    *           if err ~= "" then
    *               return err
    *               end
    *               return ""
    *           end
    *     函数描述为：insert row
    *     参数description 编码后为 ：aW5zZXJ0IHJvdw==
    *     参数body 编码后为 ：CmZ1bmN0aW9uIGZ1bmNJbnNlcnQodDEsIHYxKSAKCWZpZWxkcyA9IGpzb25TdHJpbmdUb01hcCh2MSkKCWlkLCBlcnIgPSBJbnNlcnRSb3codDEsIGZpZWxkcykKCWlmIGVyciB+PSAiIiB0aGVuCiAgICAgICAgcmV0dXJuIGVycgogICAgICAgIGVuZAogICAgICAgIHJldHVybiAiIgplbmQ=
    ***************************************************************************/
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
   *     假设我们的函数原型如下 ：
   *            function funcInsert(t1, v1)
   *            fields = jsonStringToMap(v1)
   *            id, err = InsertRow(t1, fields)
   *            if err ~= "" then
   *                return err
   *                end
   *                return ""
   *            end
   *     函数有两个参数，t1(表名)，v1(插入值)
   *     现在我们要想worker 表中插入一条数据 name:boa, 即name字段为boa
   *     参数需要先json序列化为 ["worker","{\"name\":\"boa\"}"]，然后base64 编码为WyJ3b3JrZXIiLCJ7XCJuYW1lXCI6XCJib2FcIn0iXQ==， 即argument的值为WyJ3b3JrZXIiLCJ7XCJuYW1lXCI6XCJib2FcIn0iXQ==
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
    *     Description : 查询器描述 base64编码
    *     Body : 查询器实现 base64编码
    *   Description : orm query
    *   查询器示例：
    *       function relationQuery(tableName, queryString)
    *           queryTable = jsonStringToMap(queryString)
    *           author = findRowsBy("author",queryTable)
    *           book = author:book()
    *           oneBook = book:first()
    *           return oneBook:data()
    *       end
    *       编码后
    *    Description ：b3JtIHF1ZXJ5
    *    Body ：ZnVuY3Rpb24gcmVsYXRpb25RdWVyeSh0YWJsZU5hbWUsIHF1ZXJ5U3RyaW5nKQogICAgcXVlcnlUYWJsZSA9IGpzb25TdHJpbmdUb01hcChxdWVyeVN0cmluZykKICAgIGF1dGhvciA9IGZpbmRSb3dzQnkoImF1dGhvciIscXVlcnlUYWJsZSkgCiAgICBib29rID0gYXV0aG9yOmJvb2soKSAKICAgIG9uZUJvb2sgPSBib29rOmZpcnN0KCkgCiAgICByZXR1cm4gb25lQm9vazpkYXRhKCkJCmVuZA==
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
        string[] memory params = new string[](2);
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
        string[] memory params = new string[](3);
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
        string[] memory params = new string[](7);
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
        string[] memory params = new string[](6);
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
        string[] memory params = new string[](3);
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
        string[] memory params = new string[](3);
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
        string[] memory params = new string[](4);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = oldField;
        params[3] = newField;
        return params.rename_column();
    }

    /***************************************************************************
    *  函数功能 ： 添加索引
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     field : 字段名
    ***************************************************************************/
    function create_index(string memory appCode, string memory tableName, string memory field) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = field;
        return params.create_index();
    }

    /***************************************************************************
    *  函数功能 ： 删除索引
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     field : 字段名
    ***************************************************************************/
    function drop_index(string memory appCode, string memory tableName, string memory field) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = field;
        return params.drop_index();
    }

    /***************************************************************************
    *  函数功能 ： 修改表属性
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     action : add 或者 drop
    *     option : 有三个值 public(设置表公开)、writable-by(设置哪个组可写)、payment(记录支付)
    ***************************************************************************/
    function modify_option(string memory appCode, string memory tableName, string memory action, string memory option) public returns (bytes32){
        string[] memory params = new string[](4);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = action;
        params[3] = option;
        return params.modify_option();
    }

    /***************************************************************************
    *  函数功能 ： 添加插入过滤器
    *  函数说明 ： 插入函数时，自动执行过滤器代码，检查数据
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     filter : 过滤器实现
    *     过滤器示例 ：
    *       if (this.age < 20) then
    *           return false
    *       else
    *           return true
    *       end
    *       然后base64 编码为aWYgKHRoaXMuYWdlIDwgMjApIHRoZW4KCXJldHVybiBmYWxzZQplbHNlIAoJcmV0dXJuIHRydWUKZW5k
    ***************************************************************************/
    function add_insert_filter(string memory appCode, string memory tableName, string memory filter) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = filter;
        return params.add_insert_filter();
    }

    /***************************************************************************
    *  函数功能 ： 删除插入过滤器
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    ***************************************************************************/
    function drop_insert_filter(string memory appCode, string memory tableName) public returns (bytes32){
        string[] memory params = new string[](2);
        params[0] = appCode;
        params[1] = tableName;
        return params.drop_insert_filter();
    }

    /***************************************************************************
    *  函数功能 ： 添加触发器
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     trigger : 触发器实现 base64
    *   触发器示例：
    *   if (this.age > 30) then
    *       tableName = "student"
    *       fields = {}
    *       fields["name"] = "张三"
    *       fields["age"] = "18"
    *       InsertRow(tableName,fields)
    *   end
    *   base64 编码：aWYgKHRoaXMuYWdlID4gMzApIHRoZW4KICAgIHRhYmxlTmFtZSA9ICJzdHVkZW50IgogICAgZmllbGRzID0ge30KICAgIGZpZWxkc1sibmFtZSJdID0gIuW8oOS4iSIKICAgIGZpZWxkc1siYWdlIl0gPSAiMTgiICAKICAgIEluc2VydFJvdyh0YWJsZU5hbWUsZmllbGRzKSAKZW5k
    ***************************************************************************/
    function add_trigger(string memory appCode, string memory tableName, string memory trigger) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = trigger;
        return params.add_trigger();
    }

    /***************************************************************************
    *  函数功能 ： 删除触发器
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    ***************************************************************************/
    function drop_trigger(string memory appCode, string memory tableName) public returns (bytes32){
        string[] memory params = new string[](2);
        params[0] = appCode;
        params[1] = tableName;
        return params.drop_trigger();
    }

    /***************************************************************************
    *  函数功能 ： 设置表备注
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     memo : 备注
    ***************************************************************************/
    function set_table_memo(string memory appCode, string memory tableName, string memory memo) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = memo;
        return params.set_table_memo();
    }

    /***************************************************************************
    *  函数功能 ： 设置列属性
    *  函数说明 ：
    *  参数说明 ： src 包含5个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     fieldName : 字段名
    *     action : add 或者drop
    *     option : not-null、unique、own、readable
    *   TODO option 详解
    ***************************************************************************/
    function modify_column_option(string memory appCode, string memory tableName, string memory fieldName, string memory action, string memory option) public returns (bytes32){
        string[] memory params = new string[](5);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = fieldName;
        params[3] = action;
        params[4] = option;
        return params.modify_column_option();
    }

    /***************************************************************************
    *  函数功能 ： 设置列类型
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     fieldName : 字段名
    *     dataType : string、file、int、decimal、address、time
    ***************************************************************************/
    function modify_column_data_type(string memory appCode, string memory tableName, string memory fieldName, string memory dataType) public returns (bytes32){
        string[] memory params = new string[](4);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = fieldName;
        params[3] = dataType;
        return params.modify_column_data_type();
    }

    /***************************************************************************
    *  函数功能 ： 设置列备注
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     fieldName : 字段名
    *     memo : 列备注
    ***************************************************************************/
    function modify_column_memo(string memory appCode, string memory tableName, string memory fieldName, string memory memo) public returns (bytes32){
        string[] memory params = new string[](4);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = fieldName;
        params[3] = memo;
        return params.modify_column_memo();
    }

    /***************************************************************************
    *  函数功能 ： 插入数据
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     fields : 值
    *  fields 示例 :
    *  插入一条数据 name字段的值为bob, 先用json编码 {"name":"bob"}，然后base64得到 nGZzMFdQnQegHuSBMVv，最后的传参就是nGZzMFdQnQegHuSBMVv
    ***************************************************************************/
    function insert_row(string memory appCode, string memory tableName, string memory fields) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = fields;
        return params.insert_row();
    }

    /***************************************************************************
    *  函数功能 ： 数据冻结
    *  函数说明 ： 冻结的数据不能根据字段查询，但是可以根据id查询
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     id : 数据id
    ***************************************************************************/
    function freeze_row(string memory appCode, string memory tableName, string memory id) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = tableName;
        params[2] = id;
        return params.freeze_row();
    }

    /***************************************************************************
    *  函数功能 ： 组修改
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     action : add 或者 drop
    *     group : 组名
    ***************************************************************************/
    function modify_group(string memory appCode, string memory action, string memory group) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = action;
        params[2] = group;
        return params.modify_group();
    }

    /***************************************************************************
    *  函数功能 ： 组备注修改
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     group : 组名
    *     memo : 备注
    ***************************************************************************/
    function set_group_memo(string memory appCode, string memory group, string memory memo) public returns (bytes32){
        string[] memory params = new string[](3);
        params[0] = appCode;
        params[1] = group;
        params[2] = memo;
        return params.set_group_memo();
    }

    /***************************************************************************
    *  函数功能 ： 组成员修改
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     group : 组名
    *     action : add 或者 drop
    *     member : 被修改的用户地址
    ***************************************************************************/
    function modify_group_member(string memory appCode, string memory group, string memory action, string memory member) public returns (bytes32){
        string[] memory params = new string[](4);
        params[0] = appCode;
        params[1] = group;
        params[2] = action;
        params[3] = member;
        return params.modify_group_member();
    }

    /***************************************************************************
    *  函数功能 ： 设置数据库结构状态
    *  函数说明 ： 当设置为frozen时，不能再往数据库里面新增表，表的结构也不允许修改
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     status : frozen 或者 unfrozen
    ***************************************************************************/
    function set_schema_status(string memory appCode, string memory status) public returns (bytes32){
        string[] memory params = new string[](2);
        params[0] = appCode;
        params[1] = status;
        return params.set_schema_status();
    }

    /***************************************************************************
    *  函数功能 ： 设置数据库数据状态
    *  函数说明 ： 当设置为frozen时，数据库不能再写入数据了，但是可以读取
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     status : frozen 或者 unfrozen
    ***************************************************************************/
    function set_database_data_status(string memory appCode, string memory status) public returns (bytes32){
        string[] memory params = new string[](2);
        params[0] = appCode;
        params[1] = status;
        return params.set_database_data_status();
    }

    /***************************************************************************
    *  函数功能 ： 设置数据库访问许可
    *  函数说明 ： 当设置为required时，只有user组的用户能往数据库里面写数据
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     permissionRequired : required 或者 unrequired
    ***************************************************************************/
    function set_database_permission(string memory appCode, string memory permissionRequired) public returns (bytes32){
        string[] memory params = new string[](2);
        params[0] = appCode;
        params[1] = permissionRequired;
        return params.set_database_permission();
    }

}