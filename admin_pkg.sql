
create or replace package admin_pkg as
   ---------------------------------------------------------------------------
    --
    -- PACKAGE NOTES
    -- 统计用户登录历史
    -- 统计恶意登陆的IP
    -- 查看申请的医生
    -- 批准医生
    -------------------------- ALGORITHM CONSTANTS ----------------------------
    max_try number :=10; --最大尝试次数，超过次数无法登陆会被提交进恶意记录
    
    ---------------------------------------------------------------------------

    ---------------------------------------------------------------------------

    ---------------------- FUNCTIONS AND PROCEDURES ------------------------

    ------------------------------------------------------------------------
    --
    -- NAME:  users_log_records
    --
    -- DESCRIPTION:
    -- 统计所有用户登陆记录
    --
    -- PARAMETERS
    -- date 时间之后，默认默示所有
    -- id 指定用户,默认默示所有
    -- res 结果
    --
    procedure users_log_records
    (id_ in usrs."ID"%type := 0,
    date_ in date := to_date('1000-01-01','YYYY-MM-DD'),
    res in out sys_refcursor);
    --------------------------------------------------
    
        --!!!!!!!!!!!!!!未测试
    -- NAME:  mal_login_statistic
    --
    -- DESCRIPTION:
    -- 统计恶意登陆信息,写入到恶意行为表中
    --
    -- PARAMETERS
    -- res 结果
    --
    --------------------------------------------------
   
    -- NAME:  doctors_applying
    --
    -- DESCRIPTION:
    -- 查看一段时间内的医生认证申请,默认所有
    --
    -- PARAMETERS
    -- date 时间之后，默认默示所有
    -- res 结果
    --
    procedure doctors_applying
    (date_ in date := to_date('1000-01-01','YYYY-MM-DD'),
    res in out sys_refcursor);
    --------------------------------------------------
  
    -- NAME:  agree_application
    --
    -- DESCRIPTION:
    -- 统计所有用户登陆记录
    --
    -- PARAMETERS
    -- id_ 医生id
    -- date_ 有效期，默认无限制
    --
    procedure agree_application
    (id_ in usrs."ID"%type := 0,
    date_ in date := to_date('3000-01-01','YYYY-MM-DD'));
    --------------------------------------------------
    
end admin_pkg;
/
    ---------------------------------------------------------------------------

    -------------------------------- BODY ----------------------------------

    ------------------------------------------------------------------------
create or replace package body admin_pkg as
--
    procedure users_log_records
    (id_ in usrs."ID"%type := 0,
    date_ in date := to_date('1000-01-01','YYYY-MM-DD'),
    res in out sys_refcursor)
    is
    begin
      if id_ > 0 then
        open res for
        select "TIME","ACCOUNT",user_id,ip 
        from log_in_history lih
        where lih.user_id=id_ and lih."SUCCESS"=to_char(1) and lih."TIME" > date_
        order by lih."TIME";
      else
        open res for
        select "TIME","ACCOUNT",user_id,ip 
        from log_in_history lih
        where lih."SUCCESS"=to_char(1) and lih."TIME" > date_
        group by user_id,"TIME","ACCOUNT",ip 
        order by lih."TIME";
      end if;
    end users_log_records;
    --------------------------------------------------
    
--
    procedure doctors_applying
    (date_ in date := to_date('1000-01-01','YYYY-MM-DD'),
    res in out sys_refcursor)
    is
    begin
     open res for 
      select * from doctors doc
      where doc.apply_date > date_ and doc.expire_date < sysdate;
    end doctors_applying;
    --------------------------------------------------
    
--
    procedure agree_application
    (id_ in usrs."ID"%type := 0,
    date_ in date := to_date('3000-01-01','YYYY-MM-DD'))
    is
    begin
      update doctors
      set expire_date = date_,validate_date=sysdate
      where "ID"=id_;
    end agree_application;
    --------------------------------------------------
end admin_pkg;
/
