--创建表空间、用户、授权
@blm_schema.sql;
--创建对象、授予表权限
@blm_data.sql;
--0创建程序包、授予执行权限
@blm_code.sql;
--导入数据
@blm_test_data.sql;