
create or replace package get_info_pkg as
   ---------------------------------------------------------------------------
    --
    -- PACKAGE NOTES
    -- 提供获得表信息的接口
    -- 包括如下功能：
    -- 得到用户ID
    -- 得到用户信息
    -- 得到医生信息
    -- 得到病情描述
    -- 得到用户恶意行为记录
    -- 得到用户关键词
    -- 得到医生关键词
    -- 得到医生日程安排
    -- 得到医生预约历史记录
    -- 得到用户预约历史记录
    -- 返回医生申请是否通过
    ---------------------------------------------------------------------------

    ---------------------- FUNCTIONS AND PROCEDURES ------------------------

    ------------------------------------------------------------------------
    --
    -- NAME:  get_id
    --
    -- DESCRIPTION:
    -- 通过用户名得到ID
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_id
    ("account" in usrs.account_name%type,
    res  out usrs."ID"%type);
    --------------------------------------------------

    --------------------------------------------------
    -- NAME:  get_user_info
    --
    -- DESCRIPTION:
    -- 通过ID得到用户user表的的所有信息
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_user_info
    (user_id in usrs."ID"%type,
    res  in out sys_refcursor);
    --------------------------------------------------
 
 
    --------------------------------------------------
    -- NAME:  get_doctor_info
    --
    -- DESCRIPTION:
    -- 通过ID得到医生doctor表的的所有信息
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_doctor_info
    (doc_id in usrs."ID"%type,
    res  in out sys_refcursor);
    --------------------------------------------------
    
    --------------------------------------------------
    -- NAME:  get_disease_description
    --
    -- DESCRIPTION:
    -- 通过该表id得到表的所有信息
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_disease_description
    (dd_id in disease_description."ID"%type,
    res  in out sys_refcursor);   
    --------------------------------------------------
    
    --------------------------------------------------
    -- NAME:  get_mal_behavior_records
    --
    -- DESCRIPTION:
    -- 通过该表id得到表的所有信息
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_mal_behavior_records
    (mbr_id in mal_behavior_records."ID"%type,
    res  in out sys_refcursor);  
    --------------------------------------------------
    
    --------------------------------------------------
    --!!!!!!!!!!!!!!未测试
    -- NAME:  get_user_keywords
    --
    -- DESCRIPTION:
    -- 通过用户的ID得到用户的所有关键词记录
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_user_keywords
    (user_ in usrs."ID"%type,
    res  in out sys_refcursor);  
    --------------------------------------------------

    --------------------------------------------------    
    --!!!!!!!!!!!!!!未测试
    -- NAME:  get_doctor_keywords
    --
    -- DESCRIPTION:
    -- 通过医生的ID得到医生的所有关键词记录
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_doctor_keywords
    (doctor_ in usrs."ID"%type,
    res  in out sys_refcursor); 
    --------------------------------------------------
    
    --------------------------------------------------    
    -- NAME:  doctor_schedule
    --
    -- DESCRIPTION:
    -- 按时间顺序的医生日程安排，只返回大于当前时间的日程
    --
    -- PARAMETERS
    --res 结果
    --
    procedure doctor_schedule
    (doctor_id in usrs."ID"%type,
    res  in out sys_refcursor); 
    --------------------------------------------------
      
    --------------------------------------------------
    -- NAME:  get_appointments
    --
    -- DESCRIPTION:
    -- 通过预约单ID得到预约信息
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_appointments
    (a_id in appointments."ID"%type,
    res  in out sys_refcursor);
    --------------------------------------------------  

    --------------------------------------------------
    -- NAME:  get_doctor_appointments
    --
    -- DESCRIPTION:
    -- 通过医生ID得到预约信息
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_doctor_appointments
    (doctor_id in usrs."ID"%type,
    res  in out sys_refcursor);
    --------------------------------------------------  
    
    --------------------------------------------------
    -- NAME:  get_user_appointments
    --
    -- DESCRIPTION:
    -- 通过用户ID得到预约信息
    --
    -- PARAMETERS
    --res 结果
    --
    procedure get_user_appointments
    (user_id in usrs."ID"%type,
    res  in out sys_refcursor);
    --------------------------------------------------  
    
    --!!!!!!!!!!!!!!未测试
    --------------------------------------------------
    -- NAME:  get_doc_expire
    --
    -- DESCRIPTION:
    -- 查看医生认证过期时间
    -- 通过医生ID查看医生信息表的validate date信息如果日期小于当前时间则通过
    --
    -- PARAMETERS
    --res 结果
    --vdate 通过日期
    procedure get_doc_expire
    (doc_id in usrs."ID"%type,
    res  out number,
    expire_ out date);
    --------------------------------------------------  
    
end get_info_pkg;
/

    ---------------------------------------------------------------------------

    -------------------------------- BODY ----------------------------------

    ------------------------------------------------------------------------
create or replace package body get_info_pkg as

--get_id
    procedure get_id
    ("account" in usrs.account_name%type,
         res  out usrs."ID"%type)
    is
    begin
      select "ID" into res
      from usrs u
      where u.account_name = "account";
    exception
      when NO_DATA_FOUND then
      res := 0;
    end get_id;
    --------------------------------------------------

--get_user_info
    procedure get_user_info
    (user_id in usrs."ID"%type,
    res  in out sys_refcursor)
    is
    begin
      open res for 
      select * from usrs
      where usrs."ID" = user_id;
    end get_user_info;
    --------------------------------------------------
    
--get_doctor_info
    procedure get_doctor_info
    (doc_id in usrs."ID"%type,
    res  in out sys_refcursor)
    is
    begin
      open res for 
      select * from doctors
      where doctors."ID"=doc_id;
    end get_doctor_info;
    --------------------------------------------------
    
--get_disease_description
    procedure get_disease_description
    (dd_id in disease_description."ID"%type,
    res  in out sys_refcursor)
    is
    begin
      open res for 
      select * from disease_description
      where disease_description."ID"=dd_id;
    end get_disease_description;
    --------------------------------------------------
    
--get_mal_behavior_records
    procedure get_mal_behavior_records
    (mbr_id in mal_behavior_records."ID"%type,
    res  in out sys_refcursor)
    is
    begin
      open res for 
      select * from mal_behavior_records
      where mal_behavior_records."ID"=mbr_id;
    end get_mal_behavior_records;
    --------------------------------------------------
    
--get_user_keywords
    procedure get_user_keywords
    (user_ in usrs."ID"%type,
    res  in out sys_refcursor)
    is
    begin 
      open res for 
        select "CLASS",detail
        from keywords kw, user_keyword uk
        where uk.user_id = user_ and kw."ID" = uk.key_id;
    end get_user_keywords;
    --------------------------------------------------
    
--get_doctor_keywords   
    procedure get_doctor_keywords
    (doctor_ in usrs."ID"%type,
    res  in out sys_refcursor)
    is
    begin
      open res for 
        select "CLASS",detail
        from keywords kw, doctor_keyword dk
        where dk.doctor_id = doctor_ and kw."ID" = dk.key_id;
    end get_doctor_keywords;
    --------------------------------------------------

--doctor_schedule
    procedure doctor_schedule
    (doctor_id in usrs."ID"%type,
    res  in out sys_refcursor)
    is
    begin
      open res for
        select * from appointments ap
        where ap.doctor_id = doctor_id and ap."TIME"> sysdate
        order by ap."TIME";
    end doctor_schedule;
    --------------------------------------------------
    
--get_appointments
    procedure get_appointments
    (a_id in appointments."ID"%type,
    res  in out sys_refcursor)
    is
     begin
      open res for
        select * from appointments ap
        where ap."ID" = a_id;
    end get_appointments;
    --------------------------------------------------
    
--get_doctor_appointments
    procedure get_doctor_appointments
    (doctor_id in usrs."ID"%type,
    res  in out sys_refcursor)
    is
    begin
      open res for
        select * from appointments ap
        where ap.doctor_id = doctor_id 
        order by ap."TIME";
    end get_doctor_appointments;
    --------------------------------------------------
    
--get_user_appointments  
    procedure get_user_appointments
    (user_id in usrs."ID"%type,
    res  in out sys_refcursor)  
        is
    begin
      open res for
        select * from appointments ap
        where ap.user_id = user_id 
        order by ap."TIME";
    end get_user_appointments;
    --------------------------------------------------
    
--get_doc_expire  
    procedure get_doc_expire
    (doc_id in usrs."ID"%type,
    res  out number,
    expire_ out date)
    is
    begin
      select expire_date into expire_ 
      from doctors dt
      where dt."ID"=doc_id;
      if expire_>sysdate then
        res := 1;
      else res := 0;
      end if;
    end get_doc_expire;
    --------------------------------------------------
end get_info_pkg;
/
