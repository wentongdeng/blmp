connect blm_code/blmpwd;
--创建synonym
create or replace synonym appointments for blm_data.appointments;
create or replace synonym certifications for blm_data.certifications;
create or replace synonym disease_description for blm_data.disease_description;
create or replace synonym doctor_keyword for blm_data.doctor_keyword;
create or replace synonym doctors for blm_data.doctors;
create or replace synonym keywords for blm_data.keywords;
create or replace synonym mal_behavior_records for blm_data.mal_behavior_records;
create or replace synonym user_keyword for blm_data.user_keyword;
create or replace synonym mal_behaviors for blm_data.mal_behaviors;
create or replace synonym usrs for blm_data.usrs;
create or replace synonym "password" for blm_data."password";
create or replace synonym log_in_history for blm_data.log_in_history;
create or replace synonym users_sequence for blm_data.users_sequence;
create or replace synonym certifications_sequence for blm_data.certifications_sequence;
create or replace synonym disease_description_sequence for blm_data.disease_description_sequence;
create or replace synonym appointments_sequence for blm_data.appointments_sequence;
create or replace synonym mal_behaviors_sequence for blm_data.mal_behaviors_sequence;
create or replace synonym mal_behavior_records_sequence for blm_data.mal_behavior_records_sequence;
create or replace synonym keywords_sequence for blm_data.keywords_sequence;
create or replace synonym log_in_history_sequence for blm_data.log_in_history_sequence;

   ---------------------------------------------------------------------------
--创建程序包
@password_pkg.sql;
@set_info_pkg.sql;
@get_info_pkg.sql;
@admin_pkg.sql;
@search_pkg.sql;

--授予执行权限
GRANT EXECUTE ON passwords_pkg TO blm_user;
GRANT EXECUTE ON set_info_pkg TO blm_user;
GRANT EXECUTE ON get_info_pkg TO blm_user;
GRANT EXECUTE ON admin_pkg TO blm_user;
grant execute on search_pkg to blm_user;
------------------------------------------------------