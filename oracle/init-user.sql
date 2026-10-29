ALTER SESSION SET CONTAINER = ORCLPDB;
CREATE USER orcl IDENTIFIED BY orcl123;
GRANT CREATE SESSION TO orcl;
GRANT CONNECT, RESOURCE TO orcl;



sqlplus / as sysdba;
-- 切换到 ORCL 可插拔数据库 (PDB)
-- 注意：12c 默认包含 CDB 和 PDB。如果您的镜像是单实例非 CDB，请删除下面这行
ALTER SESSION SET CONTAINER = ORCLPDB;

-- 1. 创建新用户（将 my_user 和 my_password 替换为您自己的用户名和密码）
CREATE USER orcl IDENTIFIED BY orcl123;

-- 2. 分配基础连接权限 (DML 权限的前提)
GRANT CREATE SESSION TO orcl;
GRANT CONNECT, RESOURCE TO orcl;

-- 3. 分配 DML 权限（允许用户对自己创建的表或被授权的表进行增删改查）
-- 在 Oracle 中，用户默认拥有自己 schema 下所有对象的完全 DML 权限
-- 如果需要操作其他 schema 的表，需要额外授权，例如: GRANT SELECT, INSERT, UPDATE, DELETE ON other_schema.table_name TO my_user;

-- 4. 分配 DDL 权限（允许用户创建、修改、删除表、视图、序列等）
GRANT CREATE TABLE TO orcl;
GRANT CREATE VIEW TO orcl;
GRANT CREATE SEQUENCE TO orcl;
GRANT CREATE PROCEDURE TO orcl;
GRANT CREATE TRIGGER TO orcl;

-- 5. 分配表空间配额（极其重要！否则无法创建表和插入数据）
ALTER USER orcl QUOTA UNLIMITED ON USERS;



sqlplus / as sysdba;
sqlplus / as sysdba;ALTER SYSTEM DISABLE RESTRICTED SESSION;

-- 1. 启用受限模式
ALTER SYSTEM ENABLE RESTRICTED SESSION;

-- 2. 再次尝试修改字符集（使用你之前的命令）
ALTER DATABASE CHARACTER SET INTERNAL_USE ZHS16GBK;

ALTER SYSTEM DISABLE RESTRICTED SESSION;

SHUTDOWN IMMEDIATE;
STARTUP;