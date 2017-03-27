
create or replace package passwords_pkg as
   ---------------------------------------------------------------------------
    --
    -- PACKAGE NOTES
    -- 提供用户登陆认证及密码加密存储的功能
    -- 包括如下功能：
    -- 修改密码
    -- 新用户
    -- 登陆验证及历史记录
    --
    -------------------------- ALGORITHM CONSTANTS ----------------------------
    -- 指定加密的算法（encrypt_aes128），填充方法（pad_pkcs5）以及连方法（chain_cbc）
    ---------------------------------------------------------------------------

    l_type pls_integer := dbms_crypto.encrypt_aes128 +dbms_crypto.pad_pkcs5 + dbms_crypto.chain_cbc;
    l_key varchar2(16) := '0123456789123456';
    ---------------------------------------------------------------------------

    ---------------------- FUNCTIONS AND PROCEDURES ------------------------

    ------------------------------------------------------------------------
    --
    -- NAME:  change_password
    --
    -- DESCRIPTION:
    -- 修改密码
    --
    -- PARAMETERS
    --res 修改结果
    --
    procedure change_password
      (user_id in usrs.id%type,
       new_password in "password"."PASSWORD"%type);
    
    
    -- NAME:  new_user
    --
    -- DESCRIPTION:
    -- 创建新用户
    --
    -- PARAMETERS
    --
    procedure new_user
      (account_name in usrs.account_name%type,
      lastname in usrs.lastname%type,
      firstname in usrs.firstname%type,
      passwd in "password"."PASSWORD"%type,
      photo in usrs.photo%type := NULL,
      gender in usrs.gender%type := NULL,
      email in usrs.email%type := NULL,
      phone1 in usrs.phone1%type := NULL, 
      phone2 in usrs.phone2%type := NULL,
      address in usrs.address%type := NULL );

    --
    -- NAME:  login
    --
    -- DESCRIPTION:
    -- 登陆验证用户名密码返回ID,并记录登录信息
    --
    -- PARAMETERS
    -- id 
    --
    
    procedure login
    (user_name in usrs.account_name%type,
    passwd in varchar2,
    ip_addr in log_in_history.ip%type := null,
    "id" out usrs."ID"%type
    );
end passwords_pkg;
/



--passwords_pkg body
create or replace package body passwords_pkg as
   -- change_password
    procedure change_password
      (user_id in usrs."ID"%type,
       new_password in "password"."PASSWORD"%type)
    is
    begin
       update "password" set "PASSWORD" = dbms_crypto.encrypt(
        src=>utl_i18n.string_to_raw(new_password,'AL32UTF8'),
        typ=>l_type,
        key=>utl_i18n.string_to_raw(l_key,'AL32UTF8'))
        where "ID" = user_id;
    end change_password;
    
    -- new_user
    procedure new_user
      (account_name in usrs.account_name%type,
      lastname in usrs.lastname%type,
      firstname in usrs.firstname%type,
      passwd in "password"."PASSWORD"%type,
      photo in usrs.photo%type := NULL,
      gender in usrs.gender%type := NULL,
      email in usrs.email%type := NULL,
      phone1 in usrs.phone1%type := NULL, 
      phone2 in usrs.phone2%type := NULL,
      address in usrs.address%type := NULL )
    is
    new_id number := users_sequence.nextval;
    begin
        insert into usrs(account_name,lastname,firstname,photo,gender,email,phone1,phone2,address,
                        "ID",register_date) 
          values(account_name,lastname,firstname,photo,gender,email,phone1,phone2,address,
                        new_id,trunc(sysdate));
        insert into "password"("ID","PASSWORD")
          values(new_id, dbms_crypto.encrypt(
                          src=>utl_i18n.string_to_raw(passwd,'AL32UTF8'),
                          typ=>l_type,
                          key=>utl_i18n.string_to_raw(l_key,'AL32UTF8')));
                          
    end new_user;
    
    -- login
    procedure login
    (user_name in usrs.account_name%type,
    passwd in varchar2,
    ip_addr in log_in_history.ip%type := null,
    "id" out usrs."ID"%type)
    is
      encryptpasswd raw(2000);
      res number;
      res_id usrs."ID"%type;
      succeed log_in_history."SUCCESS"%type := to_char(0);
    begin
      encryptpasswd := dbms_crypto.encrypt(
        src=>utl_i18n.string_to_raw(passwd,'AL32UTF8'),
        typ=>l_type,
        key=>utl_i18n.string_to_raw(l_key,'AL32UTF8'));
      select count(*) into res
      from "password" pw, usrs u 
      where pw."ID"=u."ID" and u.account_name = user_name and pw."PASSWORD" = encryptpasswd ;
      if (res > 0) then
        succeed := to_char(1);
        select u."ID" into res_id 
        from usrs u
        where u.account_name = user_name;
      else
        res_id := 0;
      end if;
      --历史记录
      insert into log_in_history("ID","ACCOUNT","USER_ID","PASSWORD","IP","SUCCESS")
        values(log_in_history_sequence.nextval,user_name,res_id,encryptpasswd,ip_addr,succeed);
      "id" := res_id;
    end login;
  
end passwords_pkg;
/
---