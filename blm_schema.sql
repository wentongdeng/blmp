
--创建表空间
create tablespace blm
datafile 'blm.dbf' size 100M
autoextend on 
next 10M
maxsize 1000M;

--创建用户
create  user blm_data identified by blmpwd
default tablespace blm
quota unlimited on blm
enable editions;

create  user blm_code identified by blmpwd
default tablespace blm
quota unlimited on blm
enable editions;

create user blm_user identified by blmpwd
enable editions;

--授权
grant create session to blm_data;
grant create table,create view, create trigger, create sequence,create procedure to blm_data;

grant create session to blm_code;
grant create procedure, create synonym to blm_code;
grant execute on dbms_crypto to blm_code;

grant create session to blm_user;
grant create synonym to blm_user;




