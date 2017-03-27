

create or replace package set_info_pkg as
   ---------------------------------------------------------------------------
    --
    -- PACKAGE NOTES
    -- 包括如下功能：
    -- 修改用户信息
    -- 修改医生信息
    -- 医生信息录入
    -- 资格证信息录入
    -- 添加预约
    -- 添加病情说明
    --
    -------------------------- ALGORITHM CONSTANTS ----------------------------
    ---------------------------------------------------------------------------

    ---------------------------------------------------------------------------

    ---------------------- FUNCTIONS AND PROCEDURES ------------------------

    ------------------------------------------------------------------------
    --
    -- NAME:  set_user_info
    --
    -- DESCRIPTION:
    -- 修改用户信息
    --
    -- PARAMETERS
    --需要修改的信息
    --
      procedure set_user_info
      (id_ in usrs."ID"%type,
      lastname_ in usrs.lastname%type := null,
      firstname_ in usrs.firstname%type := null,
      photo_ in usrs.photo%type := NULL,
      gender_ in usrs.gender%type := NULL,
      email_ in usrs.email%type := NULL,
      phone1_ in usrs.phone1%type := NULL, 
      phone2_ in usrs.phone2%type := NULL,
      address_ in usrs.address%type := NULL );
    --------------------------------------------------
        
    --------------------------------------------------
    -- NAME:  set_doctor_info
    --
    -- DESCRIPTION:
    -- 修改医生信息
    --
    -- PARAMETERS
    --需要修改的信息
    --
      procedure set_doctor_info
      (id_ in doctors."ID"%type,
      department_ in doctors.department%type := null,
      workplace_ in doctors.workplace%type := null,
      speciality_ in doctors.speciality%type := NULL,
      introduction_ in doctors.introduction%type := NULL,
      work_year_ in doctors.working_years%type := NULL );
    --------------------------------------------------  
    
    --------------------------------------------------
    -- NAME:  new_doctor
    --
    -- DESCRIPTION:
    -- 插入医生信息，帐号申请成为医生时填写，id必须在user表中
    --validate_date默认是一个很大的值，管理员审核通过后设置成为有效值
    --
    -- PARAMETERS
    --需要，填写的信息
    --
      procedure new_doctor
      (id_ in doctors."ID"%type,
      department_ in doctors.department%type := null,
      workplace_ in doctors.workplace%type := null,
      speciality_ in doctors.speciality%type := NULL,
      introduction_ in doctors.introduction%type := NULL,
      work_year_ in doctors.working_years%type := NULL );
    --------------------------------------------------  
   
    --------------------------------------------------
    -- NAME:  add_certification
    --
    -- DESCRIPTION:
    -- 插入医生资格证书
    --
    -- PARAMETERS
    --需要，填写的信息
    --
      procedure add_certification
      (doc_id in certifications."DOCTOR_ID"%type,
      picture in certifications.photo%type := NULL,
      explanation in certifications.detail%type := NULL );
    --------------------------------------------------  
    
    --------------------------------------------------
    -- NAME:  add_appointment
    --
    -- DESCRIPTION:
    -- 插入预约
    --
    -- PARAMETERS
    --需要，填写的信息
    --
      procedure add_appointment
      (doc_id in appointments."DOCTOR_ID"%type,
      user_id in appointments.user_id%type,
      place_ in appointments.place%type ,
      time_ in appointments."TIME"%type  );
    --------------------------------------------------  

    --------------------------------------------------
    -- NAME:  add_disease_description
    --
    -- DESCRIPTION:
    -- 插入病情描述
    --
    -- PARAMETERS
    --需要，填写的信息
    --
      procedure add_disease_description
      (user_id in disease_description.user_id%type,
      title_ in disease_description."TITLE"%type ,
      detail_ in disease_description."DETAIL"%type  );
    --------------------------------------------------  
    
end set_info_pkg;
/
    ---------------------------------------------------------------------------

    -------------------------------- BODY ----------------------------------

    ------------------------------------------------------------------------
create or replace package body set_info_pkg as
--
    procedure set_user_info
      (id_ in usrs."ID"%type,
      lastname_ in usrs.lastname%type := null,
      firstname_ in usrs.firstname%type := null,
      photo_ in usrs.photo%type := NULL,
      gender_ in usrs.gender%type := NULL,
      email_ in usrs.email%type := NULL,
      phone1_ in usrs.phone1%type := NULL, 
      phone2_ in usrs.phone2%type := NULL,
      address_ in usrs.address%type := NULL  )
      is
        l_ usrs.lastname%type;
        f_ usrs.firstname%type;
        p_  usrs.photo%type;
        g_ usrs.gender%type;
        e_ usrs.email%type;
        p_1 usrs.phone1%type;
        p_2 usrs.phone2%type;
        a_ usrs.address%type;
      begin
      select lastname,firstname,photo,gender,email,phone1,phone2,address
      into l_,f_,p_,g_,e_,p_1,p_2,a_
      from usrs
      where usrs."ID"=id_;
      
      if lastname_ is not null then l_ :=lastname_; end if;
     if firstname_ is not null then f_ :=firstname_; end if;
     if photo_ is not null then p_ :=photo_; end if;
     if gender_ is not null then g_ :=gender_; end if;
     if email_ is not null then e_ :=email_; end if;
     if phone1_ is not null then p_1 :=phone1_; end if;
     if phone2_ is not null then p_2 :=phone2_; end if;
     if address_ is not null then a_ :=address_; end if;
     
     update usrs 
     set lastname = l_ , firstname =f_, photo=p_,gender=g_,email=e_,
      phone1=p_1,phone2=p_2,address=a_
      where usrs."ID"=id_;
     
  end set_user_info;
    --------------------------------------------------
    
    --
      procedure set_doctor_info
      (id_ in doctors."ID"%type,
      department_ in doctors.department%type := null,
      workplace_ in doctors.workplace%type := null,
      speciality_ in doctors.speciality%type := NULL,
      introduction_ in doctors.introduction%type := NULL,
      work_year_ in doctors.working_years%type := NULL )
      is
      d_ doctors.department%type;
      w_ doctors.workplace%type;
      s_ doctors.introduction%type;
      i_ doctors.introduction%type;
      wy_ doctors.working_years%type;
      begin
      select department,workplace,speciality,introduction,working_years
      into d_,w_,s_,i_,wy_
      from doctors
      where doctors."ID" = id_;
      
    if department_ is not null then d_ :=department_; end if;
     if workplace_ is not null then w_ :=workplace_; end if;
     if speciality_ is not null then s_ :=speciality_; end if;
     if introduction_ is not null then i_ :=introduction_; end if;
     if work_year_ is not null then wy_ :=work_year_; end if;
     
     update doctors
     set department = d_,workplace = w_,speciality =s_,introduction =i_,working_years =wy_
     where doctors."ID"= id_;
      end set_doctor_info;
    --------------------------------------------------
    
    --
      procedure new_doctor
      (id_ in doctors."ID"%type,
      department_ in doctors.department%type := null,
      workplace_ in doctors.workplace%type := null,
      speciality_ in doctors.speciality%type := NULL,
      introduction_ in doctors.introduction%type := NULL,
      work_year_ in doctors.working_years%type := NULL )
      is
      begin
        insert into doctors("ID",department,workplace,speciality,introduction,working_years)
        values(id_,department_,workplace_,speciality_,introduction_,work_year_);
      end new_doctor;
      --------------------------------------------------

      --
      
      procedure add_certification
      (doc_id in certifications."DOCTOR_ID"%type,
      picture in certifications.photo%type := NULL,
      explanation in certifications.detail%type := NULL )
      is
      begin
        insert into certifications("ID",doctor_id,photo,detail)
        values(certifications_sequence.nextval,doc_id,picture,explanation);
      end add_certification;
      --------------------------------------------------
      
      --
      procedure add_appointment
      (doc_id in appointments."DOCTOR_ID"%type,
      user_id in appointments.user_id%type,
      place_ in appointments.place%type ,
      time_ in appointments."TIME"%type  )
      is
      begin
      insert into appointments("ID",doctor_id,user_id,place,"TIME")
      values(appointments_sequence.nextval,doc_id,user_id,place_,time_);
      end add_appointment;
      --------------------------------------------------
      
      --
      procedure add_disease_description
      (user_id in disease_description.user_id%type,
      title_ in disease_description."TITLE"%type ,
      detail_ in disease_description."DETAIL"%type  )
      is
      begin
      insert into disease_description("ID",user_id,"TITLE","DETAIL")
      values(disease_description_sequence.nextval,user_id,title_,detail_);
      end add_disease_description;
      --------------------------------------------------
      
end set_info_pkg;
/