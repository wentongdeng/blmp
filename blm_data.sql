connect blm_data/blmpwd;
--创建表
  create table "BLM_DATA"."USERS#" 
   (	"ID" number not null enable, 
	"FIRSTNAME" varchar2(20 byte) not null enable, 
	"LASTNAME" varchar2(20 byte) not null enable, 
	"REGISTER_DATE" date default sysdate not null enable , 
	"ADDRESS" varchar2(200 byte), 
	"PHONE1" number, 
	"PHONE2" number, 
	"EMAIL" varchar2(100 byte), 
	"GENDER" char(1 byte),
  "PHOTO" blob, 
  "ACCOUNT_NAME" varchar2(20 byte) not null enable,
  "VALID" char(1 byte) default 1 not null enable,
	 constraint "USERS#_PK" primary key ("ID"),
   constraint "USERS#_UK1" UNIQUE ("ACCOUNT_NAME"));
  
  create table "BLM_DATA"."PASSWORD#"
   (	"ID" number not null enable, 
  "PASSWORD" varchar2(32 byte) not null enable,
  constraint "PASSWORD#_PK" primary key ("ID"),
  constraint "PASSWORD#_FK1" foreign key ("ID")
	  references "BLM_DATA"."USERS#" ("ID") enable);
 
  create table "BLM_DATA"."DOCTORS#" 
   (	"ID" number not null enable, 
	"DEPARTMENT" varchar2(100 byte), 
	"WORKPLACE" varchar2(500 byte), 
	"SPECIALITY" varchar2(100 byte), 
	"INTRODUCTION" varchar2(1000 byte), 
	"WORKING_YEARS" number, 
	"APPLY_DATE" date default sysdate not null enable, 
	"EXPIRE_DATE" date default sysdate not null enable, 
	"VALIDATE_DATE" date DEFAULT to_date('1000-01-02','YYYY-MM-DD') not null enable, 
	 constraint "DOCTORS#_PK" primary key ("ID"),
   constraint "DOCTORS#_FK1" foreign key ("ID")
	  references "BLM_DATA"."USERS#" ("ID") enable);
   
  create table "BLM_DATA"."CERTIFICATIONS#" 
   (	"ID" number not null enable, 
	"DOCTOR_ID" number not null enable, 
	"DETAIL" varchar2(1000 byte), 
	"PHOTO" blob, 
	 constraint "CERTIFICATIONS#_PK" primary key ("ID"),
   constraint "CERTIFICATIONS#_FK1" foreign key ("DOCTOR_ID")
	  references "BLM_DATA"."DOCTORS#" ("ID") on delete cascade enable
   );

  create table "BLM_DATA"."DISEASE_DESCRIPTION#" 
   (	"ID" number not null enable, 
	"USER_ID" number not null enable, 
	"TITLE" varchar2(200 byte) not null enable, 
	"DETAIL" varchar2(1000 byte) not null enable, 
	"TIME" date default sysdate not null enable, 
	 constraint "DISEASE_DESCRIPTION#_PK" primary key ("ID"),
	 constraint "DISEASE_DESCRIPTION#_FK1" foreign key ("USER_ID")
	  references "BLM_DATA"."USERS#" ("ID") on delete cascade enable);

  create table "BLM_DATA"."APPOINTMENTS#" 
   (	"ID" number not null enable, 
	"USER_ID" number not null enable, 
	"DOCTOR_ID" number not null enable, 
	"TIME" date not null enable, 
	"PLACE" varchar2(200 byte) not null enable, 
	 constraint "APPOINTMENTS#_PK" primary key ("ID"),
   constraint "APPOINTMENTS#_FK1" foreign key ("USER_ID")
	  references "BLM_DATA"."USERS#" ("ID") on delete cascade enable, 
	 constraint "APPOINTMENTS#_FK2" foreign key ("DOCTOR_ID")
	  references "BLM_DATA"."DOCTORS#" ("ID") on delete cascade enable);

  create table "BLM_DATA"."MAL_BEHAVIORS#" 
   (	"ID" number not null enable, 
	"NAME" varchar2(20 byte) not null enable, 
	"DETAIL" varchar2(200 byte) not null enable, 
	 constraint "MALBEHAVIORS#_PK" primary key ("ID"));

  create table "BLM_DATA"."MAL_BEHAVIOR_RECORDS#" 
   (	"USERS_ID" number not null enable, 
	"ID" number not null enable, 
	"TIME" date default sysdate not null enable, 
	"BEHAVIOR_ID" number not null enable, 
	 constraint "MAL_BEHAVIOR_RECORDS#_PK" primary key ("ID"),
	 constraint "MAL_BEHAIVOR_RECORDS#_FK1" foreign key ("USERS_ID")
	  references "BLM_DATA"."USERS#" ("ID") on delete cascade enable, 
	 constraint "MAL_BEHAIVOR_RECORDS#_FK2" foreign key ("BEHAVIOR_ID")
	  references "BLM_DATA"."MAL_BEHAVIORS#" ("ID") on delete cascade enable);

  create table "BLM_DATA"."KEYWORDS#" 
   (	"CLASS" varchar2(20 byte),
	"DETAIL" varchar2(20 byte) not null enable, 
	"ID" number not null enable, 
	 constraint "KEYWORD_PK" primary key ("ID"));

  create table "BLM_DATA"."DOCTOR_KEYWORD#" 
   (	"DOCTOR_ID" number not null enable, 
	"KEY_ID" number not null enable, 
	 constraint "DOCTOR_KEYWORD#_FK1" foreign key ("DOCTOR_ID")
	  references "BLM_DATA"."DOCTORS#" ("ID") on delete cascade enable, 
	 constraint "DOCTOR_KEYWORD#_FK2" foreign key ("KEY_ID")
	  references "BLM_DATA"."KEYWORDS#" ("ID") on delete cascade enable);

  create table "BLM_DATA"."USER_KEYWORD#" 
   (	"USER_ID" number not null enable, 
	"KEY_ID" number not null enable, 
	 constraint "USER_KEYWORD#_FK1" foreign key ("KEY_ID")
	  references "BLM_DATA"."KEYWORDS#" ("ID") on delete cascade enable, 
	 constraint "USER_KEYWORD#_FK2" foreign key ("USER_ID")
	  references "BLM_DATA"."USERS#" ("ID") on delete cascade enable);
    
  CREATE TABLE "BLM_DATA"."PASSWORD_HISTORY#" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"TIME" DATE  DEFAULT sysdate NOT NULL ENABLE, 
	"OLD_PSWD" VARCHAR2(32 BYTE) , 
	"NEW_PSWD" VARCHAR2(32 BYTE) NOT NULL ENABLE, 
	"USER_ID" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "PASSWORD_HISTORY_PK" PRIMARY KEY ("ID"),
	 CONSTRAINT "PASSWORD_HISTORY_FK1" FOREIGN KEY ("USER_ID")
	  REFERENCES "BLM_DATA"."USERS#" ("ID") ON DELETE CASCADE ENABLE
   );
   
  CREATE TABLE "BLM_DATA"."LOG_IN_HISTORY#" 
   (	"ID" NUMBER NOT NULL ENABLE, 
	"TIME" DATE DEFAULT sysdate NOT NULL ENABLE, 
	"ACCOUNT" VARCHAR2(20 BYTE) NOT NULL ENABLE, 
	"SUCCESS" CHAR(1 BYTE) NOT NULL ENABLE, 
	"PASSWORD" VARCHAR2(32 BYTE) NOT NULL ENABLE, 
  "USER_ID" NUMBER DEFAULT 0, 
	"IP" VARCHAR2(17 BYTE), 
	 CONSTRAINT "LOG_IN_HISTORY#_PK" PRIMARY KEY ("ID"));
   
--创建序列
   create sequence users_sequence increment by 1 start with 1;
   create sequence certifications_sequence increment by 1 start with 1;
   create sequence disease_description_sequence increment by 1 start with 1;
   create sequence appointments_sequence increment by 1 start with 1;
   create sequence mal_behaviors_sequence increment by 1 start with 1;
   create sequence mal_behavior_records_sequence increment by 1 start with 1;
   create sequence keywords_sequence increment by 1 start with 1;
   create sequence password_history_sequence increment by 1 start with 1;
   create sequence log_in_history_sequence increment by 1 start with 1;

--创建版本视图；
  create or replace editioning view appointments as select * from appointments#;
  create or replace editioning view certifications as select * from certifications#;
  create or replace editioning view disease_description as select * from disease_description#;
  create or replace editioning view doctor_keyword as select * from doctor_keyword#;
  create or replace editioning view doctors as select * from doctors#;
  create or replace editioning view keywords as select * from keywords#;
  create or replace editioning view mal_behavior_records as select * from mal_behavior_records#;
  create or replace editioning view mal_behaviors as select * from mal_behaviors#;
  create or replace editioning view user_keyword as select * from user_keyword#;
  create or replace editioning view usrs as select * from users#;
  create or replace editioning view "password" as select * from password#;
  create or replace editioning view password_history as select * from password_history#;
  create or replace editioning view log_in_history as select * from log_in_history#;
  
--创建triggers

--记录密码更改历史
  create or replace trigger password_history_trigger
  after update on "password" for each row
  declare
  begin
   /* if INSERTING then
      insert into password_history("ID","USER_ID","NEW_PSWD") values(password_history_sequence.nextval,:old."ID",:new."PASSWORD");
    elsif UPDATING then */
       insert into password_history("ID","USER_ID","OLD_PSWD","NEW_PSWD") 
       values(password_history_sequence.nextval,:old."ID",:old."PASSWORD",:new."PASSWORD");
    --end if;
  end;
/

--授予blm_code表权限
grant select,update, insert on blm_data.usrs to blm_code;
grant select,update, insert on blm_data.doctors to blm_code;
grant select,update, insert on blm_data.disease_description to blm_code;
grant select,update, insert on blm_data.certifications to blm_code;
grant select,update, insert on blm_data.appointments to blm_code;
grant select,update, insert on blm_data.doctor_keyword to blm_code;
grant select,update, insert on blm_data.keywords to blm_code;
grant select,update, insert on blm_data.mal_behavior_records to blm_code;
grant select,update, insert on blm_data.mal_behaviors to blm_code;
grant select,update, insert on blm_data.user_keyword to blm_code;
grant select,update, insert on blm_data."password" to blm_code;
grant select,insert on blm_data.log_in_history to blm_code;
grant select on blm_data.users_sequence to blm_code;
grant select on blm_data.certifications_sequence to blm_code;
grant select on blm_data.disease_description_sequence to blm_code;
grant select on blm_data.appointments_sequence to blm_code;
grant select on blm_data.mal_behaviors_sequence to blm_code;
grant select on blm_data.mal_behavior_records_sequence to blm_code;
grant select on blm_data.keywords_sequence to blm_code;
grant select on blm_data.log_in_history_sequence to blm_code;
