pragma solidity >=0.7.0 <0.9.0;

import "./utils.sol";

library  dbchain {
    using utils for *;

    /***************************************************************************
    *  函数功能 ： 创建数据库
    *  函数说明 ： 无
    *  参数说明 ： src 包含3个参数
    *    name  数据库名称
    *    description  数据库描述
    *    permissionRequired  是否需要访问权限  true 或者 false
    ***************************************************************************/
    function create_application(string[]  memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "01");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 数据库废弃
    *  函数说明 ： 该交易不是真正的废弃数据库,只是把数据库设置为不可写和不可读取状态.可以恢复
    *  参数说明 ： src 包含1个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    ***************************************************************************/
    function drop_application(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 1, "02");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 数据库恢复
    *  函数说明 ： 把数据库从废弃状态恢复为正常状态
    *  参数说明 ： src 包含1个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    ***************************************************************************/
    function recover_application(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 1, "03");
        return res[0];
    }

    /**************************************************************************
    *  函数功能 ： 数据库智能合约绑定
    *  函数说明 ： 把数据库与智能合约绑定，绑定后的数据库只能通过智能合约写入或者修改数据
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     contractAddr : 智能合约地址
    **************************************************************************/
    function contract_db_binding(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "2A");
        return res[0];
    }

    /**************************************************************************
    *  函数功能 ： 数据库智能合约解绑
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     contractAddr : 智能合约地址
    **************************************************************************/
    function contract_db_unbinding(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "2C");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 修改数据库使用者, 增加或者删除
    *  函数说明 ： 当创建数据库时将permissionRequired 设为true 时, 需要把其他用户添加到user组, 用户才有读写权限
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     action  : 添加或者删除用户, add, drop
    *     userAddress : 用户地址
    ***************************************************************************/
    function modify_database_user(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "06");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 为数据库添加函数
    *  函数说明 ： 为数据库添加函数，该函数可对数据库进行写操作。一般用于比较复杂的插入操作，如多表插入
    *  参数说明 ： src 包含4个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     functionName  : 添加的函数名
    *     description : 函数描述
    *     body : 函数内容
    *     TODO 添加函数实例
    ***************************************************************************/
    function add_function(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 4, "07");
        return res[0];
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
    function call_function(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "08");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 数据库函数删除
    *  函数说明 ： 删除添加在数据上的函数
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     functionName  : 函数名
    ***************************************************************************/
    function drop_function(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "09");
        return res[0];
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
    function add_querier(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 4, "0A");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 删除数据库查询器
    *  函数说明 ： 删除添加的查询器
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     QuerierName : 查询器名称
    ***************************************************************************/
    function drop_querier(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "0B");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 建表
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 表名
    *     fields : 字段，多个字段用逗号隔开，如"field1,field2"
    ***************************************************************************/
    function create_table(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "0C");
        return res[0];
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
    function modify_table_association(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 7, "0D");
        return res[0];
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
    function add_counter_cache(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 6, "0F");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 新增字段
    *  函数说明 ： 在表中新增一个普通字段
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     field : 新增字段名
    ***************************************************************************/
    function add_column(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "10");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 删除字段
    *  函数说明 ： 删除表一个字段
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     field : 新增字段名
    ***************************************************************************/
    function drop_column(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "11");
        return res[0];
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
    function rename_column(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 4, "12");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 添加索引
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     field : 字段名
    ***************************************************************************/
    function create_index(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "13");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 删除索引
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     field : 字段名
    ***************************************************************************/
    function drop_index(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "14");
        return res[0];
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
    function modify_option(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 4, "15");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 添加插入过滤器
    *  函数说明 ： 插入函数时，自动执行过滤器代码，检查数据
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     filter : 过滤器实现
    *   TODO 过滤器实例
    ***************************************************************************/
    function add_insert_filter(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "16");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 删除插入过滤器
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    ***************************************************************************/
    function drop_insert_filter(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "17");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 添加触发器
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     trigger : 触发器实现
    *  TODO 触发器实现
    ***************************************************************************/
    function add_trigger(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "18");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 删除触发器
    *  函数说明 ：
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    ***************************************************************************/
    function drop_trigger(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "19");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 设置表备注
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     memo : 备注
    ***************************************************************************/
    function set_table_memo(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "1A");
        return res[0];
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
    function modify_column_option(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 5, "1B");
        return res[0];
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
    function modify_column_data_type(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 4, "1C");
        return res[0];
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
    function modify_column_memo(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 4, "1D");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 插入数据
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     fields : 值
    *   TODO fields 示例
    ***************************************************************************/
    function insert_row(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "1F");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 更新数据
    *  函数说明 ：
    *  参数说明 ： src 包含4个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     id     : 需要修改数据的id
    *     fields : 需要更新的值
    ***************************************************************************/
    function update_row(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 4, "2B");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 数据冻结
    *  函数说明 ： 冻结的数据不能根据字段查询，但是可以根据id查询
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     tableName : 当前表名
    *     id : 数据id
    *   TODO fields 示例
    ***************************************************************************/
    function freeze_row(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "20");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 组修改
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     action : add 或者 drop
    *     group : 组名
    ***************************************************************************/
    function modify_group(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "21");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 组备注修改
    *  函数说明 ：
    *  参数说明 ： src 包含3个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     group : 组名
    *     memo : 备注
    ***************************************************************************/
    function set_group_memo(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 3, "22");
        return res[0];
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
    function modify_group_member(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 4, "23");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 设置数据库结构状态
    *  函数说明 ： 当设置为frozen时，不能再往数据库里面新增表，表的结构也不允许修改
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     status : frozen 或者 unfrozen
    ***************************************************************************/
    function set_schema_status(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "27");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 设置数据库数据状态
    *  函数说明 ： 当设置为frozen时，数据库不能再写入数据了，但是可以读取
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     status : frozen 或者 unfrozen
    ***************************************************************************/
    function set_database_data_status(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "28");
        return res[0];
    }

    /***************************************************************************
    *  函数功能 ： 设置数据库访问许可
    *  函数说明 ： 当设置为required时，只有user组的用户能往数据库里面写数据
    *  参数说明 ： src 包含2个参数
    *     appCode : 数据库code, 创建数据库时唯一的code
    *     permissionRequired : required 或者 unrequired
    ***************************************************************************/
    function set_database_permission(string[] memory  src) public returns (bytes32){
        bytes32[1] memory res = execute_tx(src, 2, "29");
        return res[0];
    }



    function execute_tx(string[] memory src, uint256 length, string memory methodCode) internal returns (bytes32[1] memory ) {
        require (src.length == length);
        string memory method = methodCode;
        string[] memory params = new string[](length + 1);
        params[0] = method;

        for (uint i = 1; i < length + 1; i++) {
            params[i] = src[i-1];//appCode;
        }
        bytes memory data = params.strCats();
        bytes32[1] memory h;

        assembly {
            if iszero(
            call(not(0), 0xFE, 0, add(data, 32), mload(data), h, 32)
            ) {
                invalid()
            }
        }
        return h;
    }
}
