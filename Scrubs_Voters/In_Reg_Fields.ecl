IMPORT SALT311;
IMPORT Scrubs_Voters; // Import modules for FieldTypes attribute definitions
EXPORT In_Reg_Fields := MODULE
 
EXPORT NumFields := 33;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_agecat','invalid_alphanum','invalid_alphanum_empty','invalid_alphanum_empty_specials','invalid_alphanum_specials','invalid_alphanumquot_empty','invalid_boolean_yn_empty','invalid_changedate','invalid_dob','invalid_gender','invalid_lastdatevote','invalid_last_name','invalid_mandatory','invalid_numeric','invalid_nums_empty','invalid_pastdate8','invalid_percentage','invalid_phone','invalid_race','invalid_regdate','invalid_source_state','invalid_st');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_agecat' => 1,'invalid_alphanum' => 2,'invalid_alphanum_empty' => 3,'invalid_alphanum_empty_specials' => 4,'invalid_alphanum_specials' => 5,'invalid_alphanumquot_empty' => 6,'invalid_boolean_yn_empty' => 7,'invalid_changedate' => 8,'invalid_dob' => 9,'invalid_gender' => 10,'invalid_lastdatevote' => 11,'invalid_last_name' => 12,'invalid_mandatory' => 13,'invalid_numeric' => 14,'invalid_nums_empty' => 15,'invalid_pastdate8' => 16,'invalid_percentage' => 17,'invalid_phone' => 18,'invalid_race' => 19,'invalid_regdate' => 20,'invalid_source_state' => 21,'invalid_st' => 22,0);
 
EXPORT MakeFT_invalid_agecat(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_agecat(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_agecat(s)>0);
EXPORT InValidMessageFT_invalid_agecat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_agecat'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alphanum(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_non_empty_alphanum(s)>0);
EXPORT InValidMessageFT_invalid_alphanum(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_non_empty_alphanum'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum_empty(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum_empty(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '))));
EXPORT InValidMessageFT_invalid_alphanum_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum_empty_specials(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()@#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum_empty_specials(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()@#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº '))));
EXPORT InValidMessageFT_invalid_alphanum_empty_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz()@#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum_specials(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alphanum_specials(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_non_empty_alphanum_specials(s)>0);
EXPORT InValidMessageFT_invalid_alphanum_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_non_empty_alphanum_specials'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumquot_empty(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumquot_empty(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" '))));
EXPORT InValidMessageFT_invalid_alphanumquot_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz" '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yn_empty(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yn_empty(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean_yn_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|Y|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_changedate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_changedate(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_optional_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_changedate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_optional_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dob(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dob(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_generic_date(s)>0);
EXPORT InValidMessageFT_invalid_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_generic_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['F','M','U','N','']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('F|M|U|N|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lastdatevote(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lastdatevote(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_generic_date(s)>0);
EXPORT InValidMessageFT_invalid_lastdatevote(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_generic_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_last_name(SALT311.StrType s,SALT311.StrType first_name,SALT311.StrType middle_name) := WHICH(~Scrubs_Voters.Functions.fn_populated_strings(s,first_name,middle_name)>0);
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_populated_strings'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nums_empty(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_nums_empty(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_nums_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_range_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_race(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_race(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_race(s)>0);
EXPORT InValidMessageFT_invalid_race(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_race'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_regdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_regdate(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_generic_date(s)>0);
EXPORT InValidMessageFT_invalid_regdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_generic_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_state(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_source_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'active_status','agecat','changedate','countycode','distcode','dob','EMID_number','file_acquired_date','first_name','gender','gendersurnamguess','home_phone','idcode','lastdatevote','last_name','marriedappend','middle_name','political_party','race','regdate','res_addr1','res_city','res_state','res_zip','schoolcode','source_voterid','statehouse','statesenate','state_code','timezonetbl','ushouse','voter_status','work_phone');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'active_status','agecat','changedate','countycode','distcode','dob','EMID_number','file_acquired_date','first_name','gender','gendersurnamguess','home_phone','idcode','lastdatevote','last_name','marriedappend','middle_name','political_party','race','regdate','res_addr1','res_city','res_state','res_zip','schoolcode','source_voterid','statehouse','statesenate','state_code','timezonetbl','ushouse','voter_status','work_phone');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'active_status' => 0,'agecat' => 1,'changedate' => 2,'countycode' => 3,'distcode' => 4,'dob' => 5,'EMID_number' => 6,'file_acquired_date' => 7,'first_name' => 8,'gender' => 9,'gendersurnamguess' => 10,'home_phone' => 11,'idcode' => 12,'lastdatevote' => 13,'last_name' => 14,'marriedappend' => 15,'middle_name' => 16,'political_party' => 17,'race' => 18,'regdate' => 19,'res_addr1' => 20,'res_city' => 21,'res_state' => 22,'res_zip' => 23,'schoolcode' => 24,'source_voterid' => 25,'statehouse' => 26,'statesenate' => 27,'state_code' => 28,'timezonetbl' => 29,'ushouse' => 30,'voter_status' => 31,'work_phone' => 32,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ENUM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_active_status(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_active_status(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_active_status(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_agecat(SALT311.StrType s0) := MakeFT_invalid_agecat(s0);
EXPORT InValid_agecat(SALT311.StrType s) := InValidFT_invalid_agecat(s);
EXPORT InValidMessage_agecat(UNSIGNED1 wh) := InValidMessageFT_invalid_agecat(wh);
 
EXPORT Make_changedate(SALT311.StrType s0) := MakeFT_invalid_changedate(s0);
EXPORT InValid_changedate(SALT311.StrType s) := InValidFT_invalid_changedate(s);
EXPORT InValidMessage_changedate(UNSIGNED1 wh) := InValidMessageFT_invalid_changedate(wh);
 
EXPORT Make_countycode(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_countycode(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_countycode(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_distcode(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_distcode(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_distcode(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_dob(SALT311.StrType s0) := MakeFT_invalid_dob(s0);
EXPORT InValid_dob(SALT311.StrType s) := InValidFT_invalid_dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_dob(wh);
 
EXPORT Make_EMID_number(SALT311.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_EMID_number(SALT311.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_EMID_number(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
 
EXPORT Make_file_acquired_date(SALT311.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_file_acquired_date(SALT311.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_file_acquired_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_first_name(SALT311.StrType s0) := MakeFT_invalid_alphanum_specials(s0);
EXPORT InValid_first_name(SALT311.StrType s) := InValidFT_invalid_alphanum_specials(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_specials(wh);
 
EXPORT Make_gender(SALT311.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT311.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_gendersurnamguess(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_gendersurnamguess(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_gendersurnamguess(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_home_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_home_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_home_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_idcode(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_idcode(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_idcode(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_lastdatevote(SALT311.StrType s0) := MakeFT_invalid_lastdatevote(s0);
EXPORT InValid_lastdatevote(SALT311.StrType s) := InValidFT_invalid_lastdatevote(s);
EXPORT InValidMessage_lastdatevote(UNSIGNED1 wh) := InValidMessageFT_invalid_lastdatevote(wh);
 
EXPORT Make_last_name(SALT311.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_last_name(SALT311.StrType s,SALT311.StrType first_name,SALT311.StrType middle_name) := InValidFT_invalid_last_name(s,first_name,middle_name);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
 
EXPORT Make_marriedappend(SALT311.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_marriedappend(SALT311.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_marriedappend(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_middle_name(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty_specials(s0);
EXPORT InValid_middle_name(SALT311.StrType s) := InValidFT_invalid_alphanum_empty_specials(s);
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty_specials(wh);
 
EXPORT Make_political_party(SALT311.StrType s0) := MakeFT_invalid_nums_empty(s0);
EXPORT InValid_political_party(SALT311.StrType s) := InValidFT_invalid_nums_empty(s);
EXPORT InValidMessage_political_party(UNSIGNED1 wh) := InValidMessageFT_invalid_nums_empty(wh);
 
EXPORT Make_race(SALT311.StrType s0) := MakeFT_invalid_race(s0);
EXPORT InValid_race(SALT311.StrType s) := InValidFT_invalid_race(s);
EXPORT InValidMessage_race(UNSIGNED1 wh) := InValidMessageFT_invalid_race(wh);
 
EXPORT Make_regdate(SALT311.StrType s0) := MakeFT_invalid_regdate(s0);
EXPORT InValid_regdate(SALT311.StrType s) := InValidFT_invalid_regdate(s);
EXPORT InValidMessage_regdate(UNSIGNED1 wh) := InValidMessageFT_invalid_regdate(wh);
 
EXPORT Make_res_addr1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_res_addr1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_res_addr1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_res_city(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_res_city(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_res_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_res_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_res_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_res_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_res_zip(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_res_zip(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_res_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_schoolcode(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_schoolcode(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_schoolcode(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_source_voterid(SALT311.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_source_voterid(SALT311.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_source_voterid(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
 
EXPORT Make_statehouse(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_statehouse(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_statehouse(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_statesenate(SALT311.StrType s0) := MakeFT_invalid_alphanumquot_empty(s0);
EXPORT InValid_statesenate(SALT311.StrType s) := InValidFT_invalid_alphanumquot_empty(s);
EXPORT InValidMessage_statesenate(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumquot_empty(wh);
 
EXPORT Make_state_code(SALT311.StrType s0) := MakeFT_invalid_source_state(s0);
EXPORT InValid_state_code(SALT311.StrType s) := InValidFT_invalid_source_state(s);
EXPORT InValidMessage_state_code(UNSIGNED1 wh) := InValidMessageFT_invalid_source_state(wh);
 
EXPORT Make_timezonetbl(SALT311.StrType s0) := MakeFT_invalid_nums_empty(s0);
EXPORT InValid_timezonetbl(SALT311.StrType s) := InValidFT_invalid_nums_empty(s);
EXPORT InValidMessage_timezonetbl(UNSIGNED1 wh) := InValidMessageFT_invalid_nums_empty(wh);
 
EXPORT Make_ushouse(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_ushouse(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_ushouse(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_voter_status(SALT311.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_voter_status(SALT311.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_voter_status(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_work_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_work_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_work_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Voters;
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
    BOOLEAN Diff_active_status;
    BOOLEAN Diff_agecat;
    BOOLEAN Diff_changedate;
    BOOLEAN Diff_countycode;
    BOOLEAN Diff_distcode;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_EMID_number;
    BOOLEAN Diff_file_acquired_date;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_gendersurnamguess;
    BOOLEAN Diff_home_phone;
    BOOLEAN Diff_idcode;
    BOOLEAN Diff_lastdatevote;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_marriedappend;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_political_party;
    BOOLEAN Diff_race;
    BOOLEAN Diff_regdate;
    BOOLEAN Diff_res_addr1;
    BOOLEAN Diff_res_city;
    BOOLEAN Diff_res_state;
    BOOLEAN Diff_res_zip;
    BOOLEAN Diff_schoolcode;
    BOOLEAN Diff_source_voterid;
    BOOLEAN Diff_statehouse;
    BOOLEAN Diff_statesenate;
    BOOLEAN Diff_state_code;
    BOOLEAN Diff_timezonetbl;
    BOOLEAN Diff_ushouse;
    BOOLEAN Diff_voter_status;
    BOOLEAN Diff_work_phone;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_active_status := le.active_status <> ri.active_status;
    SELF.Diff_agecat := le.agecat <> ri.agecat;
    SELF.Diff_changedate := le.changedate <> ri.changedate;
    SELF.Diff_countycode := le.countycode <> ri.countycode;
    SELF.Diff_distcode := le.distcode <> ri.distcode;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_EMID_number := le.EMID_number <> ri.EMID_number;
    SELF.Diff_file_acquired_date := le.file_acquired_date <> ri.file_acquired_date;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_gendersurnamguess := le.gendersurnamguess <> ri.gendersurnamguess;
    SELF.Diff_home_phone := le.home_phone <> ri.home_phone;
    SELF.Diff_idcode := le.idcode <> ri.idcode;
    SELF.Diff_lastdatevote := le.lastdatevote <> ri.lastdatevote;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_marriedappend := le.marriedappend <> ri.marriedappend;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_political_party := le.political_party <> ri.political_party;
    SELF.Diff_race := le.race <> ri.race;
    SELF.Diff_regdate := le.regdate <> ri.regdate;
    SELF.Diff_res_addr1 := le.res_addr1 <> ri.res_addr1;
    SELF.Diff_res_city := le.res_city <> ri.res_city;
    SELF.Diff_res_state := le.res_state <> ri.res_state;
    SELF.Diff_res_zip := le.res_zip <> ri.res_zip;
    SELF.Diff_schoolcode := le.schoolcode <> ri.schoolcode;
    SELF.Diff_source_voterid := le.source_voterid <> ri.source_voterid;
    SELF.Diff_statehouse := le.statehouse <> ri.statehouse;
    SELF.Diff_statesenate := le.statesenate <> ri.statesenate;
    SELF.Diff_state_code := le.state_code <> ri.state_code;
    SELF.Diff_timezonetbl := le.timezonetbl <> ri.timezonetbl;
    SELF.Diff_ushouse := le.ushouse <> ri.ushouse;
    SELF.Diff_voter_status := le.voter_status <> ri.voter_status;
    SELF.Diff_work_phone := le.work_phone <> ri.work_phone;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_active_status,1,0)+ IF( SELF.Diff_agecat,1,0)+ IF( SELF.Diff_changedate,1,0)+ IF( SELF.Diff_countycode,1,0)+ IF( SELF.Diff_distcode,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_EMID_number,1,0)+ IF( SELF.Diff_file_acquired_date,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_gendersurnamguess,1,0)+ IF( SELF.Diff_home_phone,1,0)+ IF( SELF.Diff_idcode,1,0)+ IF( SELF.Diff_lastdatevote,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_marriedappend,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_political_party,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_regdate,1,0)+ IF( SELF.Diff_res_addr1,1,0)+ IF( SELF.Diff_res_city,1,0)+ IF( SELF.Diff_res_state,1,0)+ IF( SELF.Diff_res_zip,1,0)+ IF( SELF.Diff_schoolcode,1,0)+ IF( SELF.Diff_source_voterid,1,0)+ IF( SELF.Diff_statehouse,1,0)+ IF( SELF.Diff_statesenate,1,0)+ IF( SELF.Diff_state_code,1,0)+ IF( SELF.Diff_timezonetbl,1,0)+ IF( SELF.Diff_ushouse,1,0)+ IF( SELF.Diff_voter_status,1,0)+ IF( SELF.Diff_work_phone,1,0);
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
    Count_Diff_active_status := COUNT(GROUP,%Closest%.Diff_active_status);
    Count_Diff_agecat := COUNT(GROUP,%Closest%.Diff_agecat);
    Count_Diff_changedate := COUNT(GROUP,%Closest%.Diff_changedate);
    Count_Diff_countycode := COUNT(GROUP,%Closest%.Diff_countycode);
    Count_Diff_distcode := COUNT(GROUP,%Closest%.Diff_distcode);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_EMID_number := COUNT(GROUP,%Closest%.Diff_EMID_number);
    Count_Diff_file_acquired_date := COUNT(GROUP,%Closest%.Diff_file_acquired_date);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_gendersurnamguess := COUNT(GROUP,%Closest%.Diff_gendersurnamguess);
    Count_Diff_home_phone := COUNT(GROUP,%Closest%.Diff_home_phone);
    Count_Diff_idcode := COUNT(GROUP,%Closest%.Diff_idcode);
    Count_Diff_lastdatevote := COUNT(GROUP,%Closest%.Diff_lastdatevote);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_marriedappend := COUNT(GROUP,%Closest%.Diff_marriedappend);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_political_party := COUNT(GROUP,%Closest%.Diff_political_party);
    Count_Diff_race := COUNT(GROUP,%Closest%.Diff_race);
    Count_Diff_regdate := COUNT(GROUP,%Closest%.Diff_regdate);
    Count_Diff_res_addr1 := COUNT(GROUP,%Closest%.Diff_res_addr1);
    Count_Diff_res_city := COUNT(GROUP,%Closest%.Diff_res_city);
    Count_Diff_res_state := COUNT(GROUP,%Closest%.Diff_res_state);
    Count_Diff_res_zip := COUNT(GROUP,%Closest%.Diff_res_zip);
    Count_Diff_schoolcode := COUNT(GROUP,%Closest%.Diff_schoolcode);
    Count_Diff_source_voterid := COUNT(GROUP,%Closest%.Diff_source_voterid);
    Count_Diff_statehouse := COUNT(GROUP,%Closest%.Diff_statehouse);
    Count_Diff_statesenate := COUNT(GROUP,%Closest%.Diff_statesenate);
    Count_Diff_state_code := COUNT(GROUP,%Closest%.Diff_state_code);
    Count_Diff_timezonetbl := COUNT(GROUP,%Closest%.Diff_timezonetbl);
    Count_Diff_ushouse := COUNT(GROUP,%Closest%.Diff_ushouse);
    Count_Diff_voter_status := COUNT(GROUP,%Closest%.Diff_voter_status);
    Count_Diff_work_phone := COUNT(GROUP,%Closest%.Diff_work_phone);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
