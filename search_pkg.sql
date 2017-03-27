create or replace package search_pkg as
   ---------------------------------------------------------------------------
    
    -- PACKAGE NOTES
    -- 搜索医生姓名
    -- 搜索医生科室
    -- 搜索医生专长
    -- 搜索医生位置
    -- 搜索医生介绍
    -- 综合搜索医生
    -- 搜索病情信息
    ---------------------------------------------------------------------------

    ---------------------- FUNCTIONS AND PROCEDURES ------------------------

    ------------------------------------------------------------------------
    --
    -- NAME: search_doc_name
    --
    -- DESCRIPTION:
    -- 搜索医生姓名
    --
    -- PARAMETERS
    -- str 姓名字符串
    --res 结果
    --
    procedure search_doc_name
    (str in usrs.firstname%type,
    res  in out sys_refcursor);
    --------------------------------------------------
        --
    -- NAME: search_doc_department
    --
    -- DESCRIPTION:
    -- 搜索医生科室
    --
    -- PARAMETERS
    -- str 科室字符串
    --res 结果
    --
    procedure search_doc_department
    (str in doctors.department%type,
    res  in out sys_refcursor);
    --------------------------------------------------
        --
    -- NAME: search_doc_speciality
    --
    -- DESCRIPTION:
    -- 搜索医生专长
    --
    -- PARAMETERS
    -- str 医生专长字符串
    --res 结果
    --
    procedure search_doc_speciality
    (str in doctors.speciality%type,
    res  in out sys_refcursor);
    --------------------------------------------------
        --
    -- NAME: search_doc_workplace
    --
    -- DESCRIPTION:
    -- 搜索医生位置
    --
    -- PARAMETERS
    -- str 姓名字符串
    --res 结果
    --
    procedure search_doc_workplace
    (str in doctors.workplace%type,
    res  in out sys_refcursor);
    --------------------------------------------------
        --
    -- NAME: search_doc_introduction
    --
    -- DESCRIPTION:
    -- 搜索医生介绍
    --
    -- PARAMETERS
    -- str 姓名字符串
    --res 结果
    --
    procedure search_doc_introduction
    (str in doctors.introduction%type,
    res  in out sys_refcursor);
    --------------------------------------------------
        --
    -- NAME: search_doctor
    --
    -- DESCRIPTION:
    -- 综合搜索医生
    --
    -- PARAMETERS
    -- str 姓名字符串
    --res 结果
    --
    procedure search_doctor
    (name_ in usrs.firstname%type :=null,
    depart_ in doctors.department%type :=null,
    special_ in doctors.speciality%type :=null,
    locate_ in doctors.workplace%type :=null,
    intru_ in doctors.introduction%type :=null,
    res  in out sys_refcursor);
    --------------------------------------------------
    
    -- NAME: search_patient
    --
    -- DESCRIPTION:
    -- 搜索病情信息,对disease_description进行搜索
    --
    -- PARAMETERS
    -- str 姓名字符串
    --res 结果
    --
    procedure search_patient
    (str in usrs.firstname%type,
    res  in out sys_refcursor);
    --------------------------------------------------
    
end search_pkg;
/

    ---------------------------------------------------------------------------

    -------------------------------- BODY ----------------------------------

    ------------------------------------------------------------------------
create or replace package body search_pkg as
    procedure search_doc_name
    (str in usrs.firstname%type,
    res  in out sys_refcursor)
    is
    str2 usrs.firstname%type := '%' || str || '%';
    begin
    open res for 
      select * from doctors doc ,usrs u
      where doc."ID"=u."ID" and u.lastname || u.firstname like str2;
    end search_doc_name;
    --------------------------------------------------
    
    procedure search_doc_department
    (str in doctors.department%type,
    res  in out sys_refcursor)
    is
    str2 doctors.department%type := '%' || str || '%';
    begin
    open res for 
      select * from doctors doc ,usrs u
      where doc."ID"=u."ID" and DOC.DEPARTMENT like str2;
    end search_doc_department;
    --------------------------------------------------
    
    procedure search_doc_speciality
    (str in doctors.speciality%type,
    res  in out sys_refcursor)
    is
    str2 doctors.speciality%type := '%' || str || '%';
    begin
    open res for 
      select * from doctors doc ,usrs u
      where doc."ID"=u."ID" and DOC.speciality like str2;
    end search_doc_speciality;
    --------------------------------------------------
    
    procedure search_doc_workplace
    (str in doctors.workplace%type,
    res  in out sys_refcursor)
    is
    str2 doctors.workplace%type := '%' || str || '%';
    begin
    open res for 
      select * from doctors doc ,usrs u
      where doc."ID"=u."ID" and DOC.workplace like str2;
    end search_doc_workplace;
    --------------------------------------------------
    
    procedure search_doc_introduction
    (str in doctors.introduction%type,
    res  in out sys_refcursor)
    is
    str2 doctors.introduction%type := '%' || str || '%';
    begin
    open res for 
      select * from doctors doc ,usrs u
      where doc."ID"=u."ID" and DOC.introduction like str2;
    end search_doc_introduction;
    --------------------------------------------------
    
    procedure search_doctor
    (name_ in usrs.firstname%type :=null,
    depart_ in doctors.department%type :=null,
    special_ in doctors.speciality%type :=null,
    locate_ in doctors.workplace%type :=null,
    intru_ in doctors.introduction%type :=null,
    res  in out sys_refcursor)
    is
    str_name usrs.firstname%type :='%' || name_ || '%';
    str_depart doctors.department%type :='%' || depart_ || '%';
    str_special doctors.speciality%type :='%' || special_ || '%';
    str_locate doctors.workplace%type :='%' || locate_ || '%';
    str_intru doctors.introduction%type :='%' || intru_ || '%';
    begin
      open res for
        select * from
          doctors doc, usrs u
        where doc."ID"=u."ID"
          and DOC.introduction like str_intru
          and DOC.workplace like str_locate
          and DOC.speciality like str_special
          and DOC.DEPARTMENT like str_depart
          and  u.lastname || u.firstname like str_name;
    end search_doctor;
    --------------------------------------------------
    
    procedure search_patient
    (str in usrs.firstname%type,
    res  in out sys_refcursor)
    is
    str2 usrs.firstname%type := '%' || str || '%';
    begin
      open res for 
        select * from 
          disease_description dd
        where dd.title like str2 or dd.detail like str2
        order by dd."TIME";
    end search_patient;
    --------------------------------------------------
end search_pkg;
--get_id