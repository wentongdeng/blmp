conn blm_user/blmpwd;
create or replace synonym passwords_pkg for blm_code.passwords_pkg;
create or replace synonym set_info_pkg for blm_code.set_info_pkg;
create or replace synonym get_info_pkg for blm_code.get_info_pkg;
create or replace synonym search_pkg for blm_code.search_pkg;
create or replace synonym admin_pkg for blm_code.admin_pkg;

--passwords_pkg.new_user('帐户名','姓','名','密码','图片','姓别','EMAIL','电话','电话2','住址');
   exec passwords_pkg.new_user('ht1111','华','佗','123457',null,'M','ht1111@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('qyr1234','秦','越人','123458',null,'M','qyr1111@jlu.edu.cn','15755708612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('lss7894','李','时珍','127458',null,'M','lss7894@jlu.edu.cn','15755788612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('zzj6666','张','仲景','127458',null,'M','zzj6666@jlu.edu.cn','15755988612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('zxy5514','张','小宇','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('jxb5514','金','煦博','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('cqc5514','迟','全超','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('ww5514','魏','闻','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('dwt5514','邓','文通','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('zzl5514','周','泽霖','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('hg5514','海','哥','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('mgy5514','马','革','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('hlg514','哈','了个','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('doge5514','DOGE','柴柴','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   exec passwords_pkg.new_user('corgi5514','CORGI','小短TUI','123456',null,'M','zxy5514@jlu.edu.cn','15754308612',null,'吉林省长春市朝阳区前进大街吉大南校南苑二');
   
   
   
   
--set_info_pkg.new_doctor(ID,'部门','工作地点','专长','介绍','工作时间／年');
  exec set_info_pkg.new_doctor(1,'普通内科','吉林大学校医院','支气管炎、肺炎、肺结核，高血压，糖尿病','毕业于XX医学专科学校，在基层工作了10余年，对常见病、多发病有比较多的经验。',10);
  exec set_info_pkg.new_doctor(2,'普通外科','吉林大学校医院','甲状腺疾病，外伤，阑尾炎，刮骨疗毒 ','毕业于XX医科大学，在基层工作多年，对常见病、多发病有比较多的经验，妙手回春，药到病除。',20);
  exec set_info_pkg.new_doctor(3,'中医 ','吉林大学校医院','各种内外疾病 ','毕业于XX医科大学，天资聪颖，曾师于名医长桑君，医德高尚，医术高超。能使枯骨生肉，尸体起死回生，人称“扁鹊”。',20);
  exec set_info_pkg.new_doctor(4,'妇科 ','吉林大学校医院','各种妇科疾病 ','毕业于XX医科大学，有多年临床经验，经验丰富，用药谨慎',20);

--set_info_pkg.add_appointment(医生ID,病人ID,'地点','时间');
  exec set_info_pkg.add_appointment(1,6,'吉林大学校医院501',to_date('2016-12-22 7:00','YYYY-MM-DD HH24:mi'));
  exec set_info_pkg.add_appointment(1,7,'吉林大学校医院501',to_date('2016-12-23 12:00','YYYY-MM-DD HH24:mi'));
  exec set_info_pkg.add_appointment(2,8,'吉林大学校医院501',to_date('2016-12-24 13:00','YYYY-MM-DD HH24:mi'));
  exec set_info_pkg.add_appointment(2,9,'吉林大学校医院511',to_date('2016-12-24 15:00','YYYY-MM-DD HH24:mi'));
  exec set_info_pkg.add_appointment(4,5,'吉林大学校医院511',to_date('2016-12-25 19:00','YYYY-MM-DD HH24:mi'));
  exec set_info_pkg.add_appointment(4,5,'吉林大学校医院511',to_date('2016-12-30 9:00','YYYY-MM-DD HH24:mi'));
  exec set_info_pkg.add_appointment(3,5,'吉林大学校医院521',to_date('2016-12-26 10:00','YYYY-MM-DD HH24:mi'));
  exec set_info_pkg.add_appointment(3,5,'吉林大学校医院521',to_date('2016-12-27 11:00','YYYY-MM-DD HH24:mi'));


--set_info_pkg.add_disease_description(病人ID,'标题','详情');
  exec set_info_pkg.add_disease_description(6,'指甲一片白的，是怎么回事？急求_有问必答_快速问医生','突然下面一片白的，这是怎么回事？是缺少钙还是怎么的？？？？？？？？？？ ');
  exec set_info_pkg.add_disease_description(7,'失眠。急求_有问必答_快速问医生','最近晚上睡不着觉，失眠多梦，而且脱发严重，白天犯困 ');
  exec set_info_pkg.add_disease_description(8,'头痛。急求_有问必答_快速问医生','头总是不定期的疼痛，特别是走路或者运动的时候，安静不动的时候好些 ');
  exec set_info_pkg.add_disease_description(9,'手臂中箭。急求_有问必答_快速问医生','两军对战，不幸被流矢所伤，箭头有剧毒。 ');
  exec set_info_pkg.add_disease_description(5,'腹痛。急求_有问必答_快速问医生','吃饭时突然觉得腹痛难忍，将吃的东西全部吐了出来，现在身体虚弱，四肢乏力，面色苍白. ');
  exec set_info_pkg.add_disease_description(5,'头痛，胸闷。失眠。急求_有问必答_快速问医生','身患重疾，心中烦闷，不思睡眠，日渐消瘦，茶水难进，多医无策，命不久矣~. ');
  exec set_info_pkg.add_disease_description(5,'。身上伤口数十处。急求_有问必答_快速问医生','为掩护主公，被乱军所伤，来不及解释了，快来救命！！！！ ');
  exec set_info_pkg.add_disease_description(8,'头痛。急求_有问必答_快速问医生','经常头痛难忍，头痛时头脑不清，无法做事。中年之后愈加严重. ');
  exec set_info_pkg.add_disease_description(9,'被狗咬了。急求_有问必答_快速问医生','被家里宠物狗咬了，狗一直很健康卫生，用打狂犬疫苗吗？. ');
  exec set_info_pkg.add_disease_description(8,'骨折。急求_有问必答_快速问医生','打球时不慎摔倒，好几天了，一直隐隐作痛，不知道是不是骨折？. ');
  exec set_info_pkg.add_disease_description(6,'天凉发烧。急求_有问必答_快速问医生','鼻塞，头痛，四肢无力，时冷时热. ');
  exec set_info_pkg.add_disease_description(5,'失眠多梦，月经不调。急求_有问必答_快速问医生','如题. ');
  exec set_info_pkg.add_disease_description(7,'颈椎痛。急求_有问必答_快速问医生','经常玩游戏或者工作时感觉颈椎疼，稍微一动就哔啪作响. ');
  exec set_info_pkg.add_disease_description(3,'腹痛。急求_有问必答_快速问医生','吃饭时突然觉得腹痛难忍，将吃的东西全部吐了出来，现在身体虚弱，四肢乏力，面色苍白. ');


  
conn blm_data/blmpwd;
insert into log_in_history("ID","ACCOUNT","TIME","SUCCESS","USER_ID","IP","PASSWORD") 
VALUES(log_in_history_sequence.nextval,'zxy5514',to_date('2016-12-22 7:00','YYYY-MM-DD HH24:mi'),to_char(0),0,'123.222.54.12','94AC6CB8E7A09D0DA19A5F0A2789BBFD');
insert into log_in_history("ID","ACCOUNT","TIME","SUCCESS","USER_ID","IP","PASSWORD") 
VALUES(log_in_history_sequence.nextval,'zxy5514',to_date('2016-12-22 7:00','YYYY-MM-DD HH24:mi'),to_char(1),0,'123.54.76.12','8D5D73511F1046376D52A402DBF52138');
insert into log_in_history("ID","ACCOUNT","TIME","SUCCESS","USER_ID","IP","PASSWORD") 
VALUES(log_in_history_sequence.nextval,'zxy5514',to_date('2016-12-22 7:00','YYYY-MM-DD HH24:mi'),to_char(0),0,'111.111.11.1','94AC6CB8E7A09D0DA19A5F0A2789BBFD');
insert into log_in_history("ID","ACCOUNT","TIME","SUCCESS","USER_ID","IP","PASSWORD") 
VALUES(log_in_history_sequence.nextval,'adfa',to_date('2016-12-22 17:00','YYYY-MM-DD HH24:mi'),to_char(0),0,'123.222.54.12','94AC6CB8E7A09D0DA19A5F0A2789BBFD');
insert into log_in_history("ID","ACCOUNT","TIME","SUCCESS","USER_ID","IP","PASSWORD") 
VALUES(log_in_history_sequence.nextval,'zxy',to_date('2016-12-25 19:45','YYYY-MM-DD HH24:mi'),to_char(0),0,'123.222.54.12','94AC6CB8E7A09D0DA19A5F0A2789BBFD');
insert into log_in_history("ID","ACCOUNT","TIME","SUCCESS","USER_ID","IP","PASSWORD") 
VALUES(log_in_history_sequence.nextval,'zxy',to_date('2016-12-22 9:50','YYYY-MM-DD HH24:mi'),to_char(0),0,'123.22.4.12','94AC6CB8E7A09D0DA19A5F0A2789BBFD');
insert into log_in_history("ID","ACCOUNT","TIME","SUCCESS","USER_ID","IP","PASSWORD") 
VALUES(log_in_history_sequence.nextval,'jxb',to_date('2016-12-22 7:30','YYYY-MM-DD HH24:mi'),to_char(0),0,'3.222.54.12','94AC6CB8E7A09D0DA19A5F0A2789BBFD');
insert into log_in_history("ID","ACCOUNT","TIME","SUCCESS","USER_ID","IP","PASSWORD") 
VALUES(log_in_history_sequence.nextval,'zxy',to_date('2016-12-22 7:00','YYYY-MM-DD HH24:mi'),to_char(0),0,'61.122.54.12','94AC6CB8E7A09D0DA19A5F0A2789BBFD');


































