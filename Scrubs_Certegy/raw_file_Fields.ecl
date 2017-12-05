IMPORT SALT38;
IMPORT Scrubs_Certegy; // Import modules for FieldTypes attribute definitions
EXPORT raw_file_Fields := MODULE
 
EXPORT NumFields := 29;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_dl_state','invalid_dl_num','invalid_ssn','invalid_dl_issue_dte','invalid_dl_expire_dte','invalid_house_bldg_num','invalid_street_suffix','invalid_apt_num','invalid_unit_desc','invalid_street_post_dir','invalid_street_pre_dir','invalid_state','invalid_zip','invalid_zip4','invalid_dob','invalid_deceased_dte','invalid_home_tel_area','invalid_home_tel_num','invalid_work_tel_area','invalid_work_tel_num','invalid_work_tel_ext','invalid_upd_dte_time','invalid_first_name','invalid_mid_name','invalid_last_name','invalid_gen_delivery','invalid_street_name','invalid_city');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_dl_state' => 1,'invalid_dl_num' => 2,'invalid_ssn' => 3,'invalid_dl_issue_dte' => 4,'invalid_dl_expire_dte' => 5,'invalid_house_bldg_num' => 6,'invalid_street_suffix' => 7,'invalid_apt_num' => 8,'invalid_unit_desc' => 9,'invalid_street_post_dir' => 10,'invalid_street_pre_dir' => 11,'invalid_state' => 12,'invalid_zip' => 13,'invalid_zip4' => 14,'invalid_dob' => 15,'invalid_deceased_dte' => 16,'invalid_home_tel_area' => 17,'invalid_home_tel_num' => 18,'invalid_work_tel_area' => 19,'invalid_work_tel_num' => 20,'invalid_work_tel_ext' => 21,'invalid_upd_dte_time' => 22,'invalid_first_name' => 23,'invalid_mid_name' => 24,'invalid_last_name' => 25,'invalid_gen_delivery' => 26,'invalid_street_name' => 27,'invalid_city' => 28,0);
 
EXPORT MakeFT_invalid_dl_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dl_state(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_dl_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dl_num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'*0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dl_num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'*0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_dl_num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('*0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ssn(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ssn(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_valid_ssn(s)>0);
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_valid_ssn'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dl_issue_dte(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dl_issue_dte(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_past_date(s)>0);
EXPORT InValidMessageFT_invalid_dl_issue_dte(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_past_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dl_expire_dte(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dl_expire_dte(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_general_date(s)>0);
EXPORT InValidMessageFT_invalid_dl_expire_dte(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_general_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_house_bldg_num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' -/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_house_bldg_num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' -/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_house_bldg_num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' -/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_street_suffix(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_street_suffix(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_street_suffix(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_apt_num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' /-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_apt_num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' /-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_apt_num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' /-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unit_desc(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'#ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_unit_desc(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'#ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_unit_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('#ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_street_post_dir(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_street_post_dir(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_street_post_dir(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ENSW'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_street_pre_dir(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_street_pre_dir(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_street_pre_dir(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ENSW'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_verify_zip5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_verify_zip4'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dob(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dob(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_past_date(s)>0);
EXPORT InValidMessageFT_invalid_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_past_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_deceased_dte(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_deceased_dte(SALT38.StrType s,SALT38.StrType deceased_dte,SALT38.StrType dob) := WHICH(~Scrubs_Certegy.functions.fn_deceased_dte(deceased_dte,dob)>0);
EXPORT InValidMessageFT_invalid_deceased_dte(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_deceased_dte'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_tel_area(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_tel_area(SALT38.StrType s,SALT38.StrType home_tel_area,SALT38.StrType home_tel_num) := WHICH(~Scrubs_Certegy.functions.fn_CleanPhone(home_tel_area,home_tel_num)>0);
EXPORT InValidMessageFT_invalid_home_tel_area(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_CleanPhone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_home_tel_num(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_home_tel_num(SALT38.StrType s,SALT38.StrType home_tel_area,SALT38.StrType home_tel_num) := WHICH(~Scrubs_Certegy.functions.fn_CleanPhone(home_tel_area,home_tel_num)>0);
EXPORT InValidMessageFT_invalid_home_tel_num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_CleanPhone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_work_tel_area(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_work_tel_area(SALT38.StrType s,SALT38.StrType work_tel_area,SALT38.StrType work_tel_num) := WHICH(~Scrubs_Certegy.functions.fn_CleanPhone(work_tel_area,work_tel_num)>0);
EXPORT InValidMessageFT_invalid_work_tel_area(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_CleanPhone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_work_tel_num(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_work_tel_num(SALT38.StrType s,SALT38.StrType work_tel_area,SALT38.StrType work_tel_num) := WHICH(~Scrubs_Certegy.functions.fn_CleanPhone(work_tel_area,work_tel_num)>0);
EXPORT InValidMessageFT_invalid_work_tel_num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_CleanPhone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_work_tel_ext(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_work_tel_ext(SALT38.StrType s,SALT38.StrType work_tel_ext) := WHICH(~Scrubs_Certegy.functions.fn_tel_ext(work_tel_ext)>0);
EXPORT InValidMessageFT_invalid_work_tel_ext(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_tel_ext'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_upd_dte_time(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_upd_dte_time(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_past_date(s)>0);
EXPORT InValidMessageFT_invalid_upd_dte_time(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_past_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_first_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_first_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType mid_name,SALT38.StrType last_name) := WHICH(~Scrubs_Certegy.functions.fn_chk_blank_names(first_name,mid_name,last_name)>0);
EXPORT InValidMessageFT_invalid_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_chk_blank_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mid_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mid_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType mid_name,SALT38.StrType last_name) := WHICH(~Scrubs_Certegy.functions.fn_chk_blank_names(first_name,mid_name,last_name)>0);
EXPORT InValidMessageFT_invalid_mid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_chk_blank_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_last_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType mid_name,SALT38.StrType last_name) := WHICH(~Scrubs_Certegy.functions.fn_chk_blank_names(first_name,mid_name,last_name)>0);
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_chk_blank_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gen_delivery(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gen_delivery(SALT38.StrType s) := WHICH(~Scrubs_Certegy.functions.fn_gen_del(s)>0);
EXPORT InValidMessageFT_invalid_gen_delivery(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Certegy.functions.fn_gen_del'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_street_name(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' .-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_street_name(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' .-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_street_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' .-/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_city(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_city(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_city(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dl_state','dl_num','ssn','dl_issue_dte','dl_expire_dte','house_bldg_num','street_suffix','apt_num','unit_desc','street_post_dir','street_pre_dir','state','zip','zip4','dob','deceased_dte','home_tel_area','home_tel_num','work_tel_area','work_tel_num','work_tel_ext','upd_dte_time','first_name','mid_name','last_name','gen_delivery','street_name','city','foreign_cntry');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dl_state','dl_num','ssn','dl_issue_dte','dl_expire_dte','house_bldg_num','street_suffix','apt_num','unit_desc','street_post_dir','street_pre_dir','state','zip','zip4','dob','deceased_dte','home_tel_area','home_tel_num','work_tel_area','work_tel_num','work_tel_ext','upd_dte_time','first_name','mid_name','last_name','gen_delivery','street_name','city','foreign_cntry');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'dl_state' => 0,'dl_num' => 1,'ssn' => 2,'dl_issue_dte' => 3,'dl_expire_dte' => 4,'house_bldg_num' => 5,'street_suffix' => 6,'apt_num' => 7,'unit_desc' => 8,'street_post_dir' => 9,'street_pre_dir' => 10,'state' => 11,'zip' => 12,'zip4' => 13,'dob' => 14,'deceased_dte' => 15,'home_tel_area' => 16,'home_tel_num' => 17,'work_tel_area' => 18,'work_tel_num' => 19,'work_tel_ext' => 20,'upd_dte_time' => 21,'first_name' => 22,'mid_name' => 23,'last_name' => 24,'gen_delivery' => 25,'street_name' => 26,'city' => 27,'foreign_cntry' => 28,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dl_state(SALT38.StrType s0) := MakeFT_invalid_dl_state(s0);
EXPORT InValid_dl_state(SALT38.StrType s) := InValidFT_invalid_dl_state(s);
EXPORT InValidMessage_dl_state(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_state(wh);
 
EXPORT Make_dl_num(SALT38.StrType s0) := MakeFT_invalid_dl_num(s0);
EXPORT InValid_dl_num(SALT38.StrType s) := InValidFT_invalid_dl_num(s);
EXPORT InValidMessage_dl_num(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_num(wh);
 
EXPORT Make_ssn(SALT38.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT38.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
 
EXPORT Make_dl_issue_dte(SALT38.StrType s0) := MakeFT_invalid_dl_issue_dte(s0);
EXPORT InValid_dl_issue_dte(SALT38.StrType s) := InValidFT_invalid_dl_issue_dte(s);
EXPORT InValidMessage_dl_issue_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_issue_dte(wh);
 
EXPORT Make_dl_expire_dte(SALT38.StrType s0) := MakeFT_invalid_dl_expire_dte(s0);
EXPORT InValid_dl_expire_dte(SALT38.StrType s) := InValidFT_invalid_dl_expire_dte(s);
EXPORT InValidMessage_dl_expire_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_expire_dte(wh);
 
EXPORT Make_house_bldg_num(SALT38.StrType s0) := MakeFT_invalid_house_bldg_num(s0);
EXPORT InValid_house_bldg_num(SALT38.StrType s) := InValidFT_invalid_house_bldg_num(s);
EXPORT InValidMessage_house_bldg_num(UNSIGNED1 wh) := InValidMessageFT_invalid_house_bldg_num(wh);
 
EXPORT Make_street_suffix(SALT38.StrType s0) := MakeFT_invalid_street_suffix(s0);
EXPORT InValid_street_suffix(SALT38.StrType s) := InValidFT_invalid_street_suffix(s);
EXPORT InValidMessage_street_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_street_suffix(wh);
 
EXPORT Make_apt_num(SALT38.StrType s0) := MakeFT_invalid_apt_num(s0);
EXPORT InValid_apt_num(SALT38.StrType s) := InValidFT_invalid_apt_num(s);
EXPORT InValidMessage_apt_num(UNSIGNED1 wh) := InValidMessageFT_invalid_apt_num(wh);
 
EXPORT Make_unit_desc(SALT38.StrType s0) := MakeFT_invalid_unit_desc(s0);
EXPORT InValid_unit_desc(SALT38.StrType s) := InValidFT_invalid_unit_desc(s);
EXPORT InValidMessage_unit_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_desc(wh);
 
EXPORT Make_street_post_dir(SALT38.StrType s0) := MakeFT_invalid_street_post_dir(s0);
EXPORT InValid_street_post_dir(SALT38.StrType s) := InValidFT_invalid_street_post_dir(s);
EXPORT InValidMessage_street_post_dir(UNSIGNED1 wh) := InValidMessageFT_invalid_street_post_dir(wh);
 
EXPORT Make_street_pre_dir(SALT38.StrType s0) := MakeFT_invalid_street_pre_dir(s0);
EXPORT InValid_street_pre_dir(SALT38.StrType s) := InValidFT_invalid_street_pre_dir(s);
EXPORT InValidMessage_street_pre_dir(UNSIGNED1 wh) := InValidMessageFT_invalid_street_pre_dir(wh);
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip4(SALT38.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT38.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_dob(SALT38.StrType s0) := MakeFT_invalid_dob(s0);
EXPORT InValid_dob(SALT38.StrType s) := InValidFT_invalid_dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_dob(wh);
 
EXPORT Make_deceased_dte(SALT38.StrType s0) := MakeFT_invalid_deceased_dte(s0);
EXPORT InValid_deceased_dte(SALT38.StrType s,SALT38.StrType deceased_dte,SALT38.StrType dob) := InValidFT_invalid_deceased_dte(s,deceased_dte,dob);
EXPORT InValidMessage_deceased_dte(UNSIGNED1 wh) := InValidMessageFT_invalid_deceased_dte(wh);
 
EXPORT Make_home_tel_area(SALT38.StrType s0) := MakeFT_invalid_home_tel_area(s0);
EXPORT InValid_home_tel_area(SALT38.StrType s,SALT38.StrType home_tel_area,SALT38.StrType home_tel_num) := InValidFT_invalid_home_tel_area(s,home_tel_area,home_tel_num);
EXPORT InValidMessage_home_tel_area(UNSIGNED1 wh) := InValidMessageFT_invalid_home_tel_area(wh);
 
EXPORT Make_home_tel_num(SALT38.StrType s0) := MakeFT_invalid_home_tel_num(s0);
EXPORT InValid_home_tel_num(SALT38.StrType s,SALT38.StrType home_tel_area,SALT38.StrType home_tel_num) := InValidFT_invalid_home_tel_num(s,home_tel_area,home_tel_num);
EXPORT InValidMessage_home_tel_num(UNSIGNED1 wh) := InValidMessageFT_invalid_home_tel_num(wh);
 
EXPORT Make_work_tel_area(SALT38.StrType s0) := MakeFT_invalid_work_tel_area(s0);
EXPORT InValid_work_tel_area(SALT38.StrType s,SALT38.StrType work_tel_area,SALT38.StrType work_tel_num) := InValidFT_invalid_work_tel_area(s,work_tel_area,work_tel_num);
EXPORT InValidMessage_work_tel_area(UNSIGNED1 wh) := InValidMessageFT_invalid_work_tel_area(wh);
 
EXPORT Make_work_tel_num(SALT38.StrType s0) := MakeFT_invalid_work_tel_num(s0);
EXPORT InValid_work_tel_num(SALT38.StrType s,SALT38.StrType work_tel_area,SALT38.StrType work_tel_num) := InValidFT_invalid_work_tel_num(s,work_tel_area,work_tel_num);
EXPORT InValidMessage_work_tel_num(UNSIGNED1 wh) := InValidMessageFT_invalid_work_tel_num(wh);
 
EXPORT Make_work_tel_ext(SALT38.StrType s0) := MakeFT_invalid_work_tel_ext(s0);
EXPORT InValid_work_tel_ext(SALT38.StrType s,SALT38.StrType work_tel_ext) := InValidFT_invalid_work_tel_ext(s,work_tel_ext);
EXPORT InValidMessage_work_tel_ext(UNSIGNED1 wh) := InValidMessageFT_invalid_work_tel_ext(wh);
 
EXPORT Make_upd_dte_time(SALT38.StrType s0) := MakeFT_invalid_upd_dte_time(s0);
EXPORT InValid_upd_dte_time(SALT38.StrType s) := InValidFT_invalid_upd_dte_time(s);
EXPORT InValidMessage_upd_dte_time(UNSIGNED1 wh) := InValidMessageFT_invalid_upd_dte_time(wh);
 
EXPORT Make_first_name(SALT38.StrType s0) := MakeFT_invalid_first_name(s0);
EXPORT InValid_first_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType mid_name,SALT38.StrType last_name) := InValidFT_invalid_first_name(s,first_name,mid_name,last_name);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_first_name(wh);
 
EXPORT Make_mid_name(SALT38.StrType s0) := MakeFT_invalid_mid_name(s0);
EXPORT InValid_mid_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType mid_name,SALT38.StrType last_name) := InValidFT_invalid_mid_name(s,first_name,mid_name,last_name);
EXPORT InValidMessage_mid_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mid_name(wh);
 
EXPORT Make_last_name(SALT38.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_last_name(SALT38.StrType s,SALT38.StrType first_name,SALT38.StrType mid_name,SALT38.StrType last_name) := InValidFT_invalid_last_name(s,first_name,mid_name,last_name);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
 
EXPORT Make_gen_delivery(SALT38.StrType s0) := MakeFT_invalid_gen_delivery(s0);
EXPORT InValid_gen_delivery(SALT38.StrType s) := InValidFT_invalid_gen_delivery(s);
EXPORT InValidMessage_gen_delivery(UNSIGNED1 wh) := InValidMessageFT_invalid_gen_delivery(wh);
 
EXPORT Make_street_name(SALT38.StrType s0) := MakeFT_invalid_street_name(s0);
EXPORT InValid_street_name(SALT38.StrType s) := InValidFT_invalid_street_name(s);
EXPORT InValidMessage_street_name(UNSIGNED1 wh) := InValidMessageFT_invalid_street_name(wh);
 
EXPORT Make_city(SALT38.StrType s0) := MakeFT_invalid_city(s0);
EXPORT InValid_city(SALT38.StrType s) := InValidFT_invalid_city(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_city(wh);
 
EXPORT Make_foreign_cntry(SALT38.StrType s0) := s0;
EXPORT InValid_foreign_cntry(SALT38.StrType s) := 0;
EXPORT InValidMessage_foreign_cntry(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Certegy;
//Find those highly occuring pivot values to remove them from consideration
#uniquename(tr)
  %tr% := table(in_left+in_right,{ val := pivot_exp; });
#uniquename(r1)
  %r1% := record
    %tr%.val;    unsigned Cnt := COUNT(GROUP);
  end;
#uniquename(t1)
  %t1% := table(%tr%,%r1%,val,local); // Pre-aggregate before distribute
#uniquename(r2)
  %r2% := record
    %t1%.val;    unsigned Cnt := SUM(GROUP,%t1%.Cnt);
  end;
#uniquename(t2)
  %t2% := table(%t1%,%r2%,val); // Now do global aggregate
Bad_Pivots := %t2%(Cnt>100);
#uniquename(dl)
  %dl% := RECORD
    BOOLEAN Diff_dl_state;
    BOOLEAN Diff_dl_num;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_dl_issue_dte;
    BOOLEAN Diff_dl_expire_dte;
    BOOLEAN Diff_house_bldg_num;
    BOOLEAN Diff_street_suffix;
    BOOLEAN Diff_apt_num;
    BOOLEAN Diff_unit_desc;
    BOOLEAN Diff_street_post_dir;
    BOOLEAN Diff_street_pre_dir;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_deceased_dte;
    BOOLEAN Diff_home_tel_area;
    BOOLEAN Diff_home_tel_num;
    BOOLEAN Diff_work_tel_area;
    BOOLEAN Diff_work_tel_num;
    BOOLEAN Diff_work_tel_ext;
    BOOLEAN Diff_upd_dte_time;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_mid_name;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_gen_delivery;
    BOOLEAN Diff_street_name;
    BOOLEAN Diff_city;
    BOOLEAN Diff_foreign_cntry;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dl_state := le.dl_state <> ri.dl_state;
    SELF.Diff_dl_num := le.dl_num <> ri.dl_num;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_dl_issue_dte := le.dl_issue_dte <> ri.dl_issue_dte;
    SELF.Diff_dl_expire_dte := le.dl_expire_dte <> ri.dl_expire_dte;
    SELF.Diff_house_bldg_num := le.house_bldg_num <> ri.house_bldg_num;
    SELF.Diff_street_suffix := le.street_suffix <> ri.street_suffix;
    SELF.Diff_apt_num := le.apt_num <> ri.apt_num;
    SELF.Diff_unit_desc := le.unit_desc <> ri.unit_desc;
    SELF.Diff_street_post_dir := le.street_post_dir <> ri.street_post_dir;
    SELF.Diff_street_pre_dir := le.street_pre_dir <> ri.street_pre_dir;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_deceased_dte := le.deceased_dte <> ri.deceased_dte;
    SELF.Diff_home_tel_area := le.home_tel_area <> ri.home_tel_area;
    SELF.Diff_home_tel_num := le.home_tel_num <> ri.home_tel_num;
    SELF.Diff_work_tel_area := le.work_tel_area <> ri.work_tel_area;
    SELF.Diff_work_tel_num := le.work_tel_num <> ri.work_tel_num;
    SELF.Diff_work_tel_ext := le.work_tel_ext <> ri.work_tel_ext;
    SELF.Diff_upd_dte_time := le.upd_dte_time <> ri.upd_dte_time;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_mid_name := le.mid_name <> ri.mid_name;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_gen_delivery := le.gen_delivery <> ri.gen_delivery;
    SELF.Diff_street_name := le.street_name <> ri.street_name;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_foreign_cntry := le.foreign_cntry <> ri.foreign_cntry;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dl_state,1,0)+ IF( SELF.Diff_dl_num,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_dl_issue_dte,1,0)+ IF( SELF.Diff_dl_expire_dte,1,0)+ IF( SELF.Diff_house_bldg_num,1,0)+ IF( SELF.Diff_street_suffix,1,0)+ IF( SELF.Diff_apt_num,1,0)+ IF( SELF.Diff_unit_desc,1,0)+ IF( SELF.Diff_street_post_dir,1,0)+ IF( SELF.Diff_street_pre_dir,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_deceased_dte,1,0)+ IF( SELF.Diff_home_tel_area,1,0)+ IF( SELF.Diff_home_tel_num,1,0)+ IF( SELF.Diff_work_tel_area,1,0)+ IF( SELF.Diff_work_tel_num,1,0)+ IF( SELF.Diff_work_tel_ext,1,0)+ IF( SELF.Diff_upd_dte_time,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_mid_name,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_gen_delivery,1,0)+ IF( SELF.Diff_street_name,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_foreign_cntry,1,0);
  END;
// Now need to remove bad pivots from comparison
#uniquename(L)
  %L% := JOIN(in_left,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(R)
  %R% := JOIN(in_right,bad_pivots,evaluate(LEFT,pivot_exp)=right.val,transform(left),left only,lookup);
#uniquename(DiffL)
  %DiffL% := JOIN(%L%,%R%,evaluate(left,pivot_exp)=evaluate(right,pivot_exp),%fd%(left,right),hash);
#uniquename(Closest)
  %Closest% := DEDUP(SORT(%DiffL%,Val,Num_Diffs,local),Val,local); // Join will have distributed by pivot_exp
#uniquename(AggRec)
  %AggRec% := RECORD
    Count_Diff_dl_state := COUNT(GROUP,%Closest%.Diff_dl_state);
    Count_Diff_dl_num := COUNT(GROUP,%Closest%.Diff_dl_num);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_dl_issue_dte := COUNT(GROUP,%Closest%.Diff_dl_issue_dte);
    Count_Diff_dl_expire_dte := COUNT(GROUP,%Closest%.Diff_dl_expire_dte);
    Count_Diff_house_bldg_num := COUNT(GROUP,%Closest%.Diff_house_bldg_num);
    Count_Diff_street_suffix := COUNT(GROUP,%Closest%.Diff_street_suffix);
    Count_Diff_apt_num := COUNT(GROUP,%Closest%.Diff_apt_num);
    Count_Diff_unit_desc := COUNT(GROUP,%Closest%.Diff_unit_desc);
    Count_Diff_street_post_dir := COUNT(GROUP,%Closest%.Diff_street_post_dir);
    Count_Diff_street_pre_dir := COUNT(GROUP,%Closest%.Diff_street_pre_dir);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_deceased_dte := COUNT(GROUP,%Closest%.Diff_deceased_dte);
    Count_Diff_home_tel_area := COUNT(GROUP,%Closest%.Diff_home_tel_area);
    Count_Diff_home_tel_num := COUNT(GROUP,%Closest%.Diff_home_tel_num);
    Count_Diff_work_tel_area := COUNT(GROUP,%Closest%.Diff_work_tel_area);
    Count_Diff_work_tel_num := COUNT(GROUP,%Closest%.Diff_work_tel_num);
    Count_Diff_work_tel_ext := COUNT(GROUP,%Closest%.Diff_work_tel_ext);
    Count_Diff_upd_dte_time := COUNT(GROUP,%Closest%.Diff_upd_dte_time);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_mid_name := COUNT(GROUP,%Closest%.Diff_mid_name);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_gen_delivery := COUNT(GROUP,%Closest%.Diff_gen_delivery);
    Count_Diff_street_name := COUNT(GROUP,%Closest%.Diff_street_name);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_foreign_cntry := COUNT(GROUP,%Closest%.Diff_foreign_cntry);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
