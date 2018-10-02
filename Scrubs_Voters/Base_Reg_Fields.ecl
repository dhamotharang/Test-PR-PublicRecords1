IMPORT SALT39;
IMPORT Scrubs_Voters; // Import modules for FieldTypes attribute definitions
EXPORT Base_Reg_Fields := MODULE
 
EXPORT NumFields := 218;
 
// Processing for each FieldType
EXPORT SALT39.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_boolean_yn_empty','invalid_numeric','invalid_nums_empty','invalid_percentage','invalid_alphanum','invalid_alphanum_empty','invalid_alphanumquot_empty','invalid_alphanum_specials','invalid_pastdate8','invalid_ssn','invalid_vtid','invalid_source','invalid_file_id','invalid_source_state','invalid_last_name','invalid_dob','invalid_agecat','invalid_agecat_exp','invalid_regdate','invalid_race','invalid_race_exp','invalid_gender','invalid_political_party','invalid_politicalparty_exp','invalid_phone','invalid_active_status_exp','invalid_voter_status_exp','invalid_lastdatevote','invalid_fname','invalid_direction','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_changedate','invalid_name_type','invalid_addr_type');
EXPORT FieldTypeNum(SALT39.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_boolean_yn_empty' => 2,'invalid_numeric' => 3,'invalid_nums_empty' => 4,'invalid_percentage' => 5,'invalid_alphanum' => 6,'invalid_alphanum_empty' => 7,'invalid_alphanumquot_empty' => 8,'invalid_alphanum_specials' => 9,'invalid_pastdate8' => 10,'invalid_ssn' => 11,'invalid_vtid' => 12,'invalid_source' => 13,'invalid_file_id' => 14,'invalid_source_state' => 15,'invalid_last_name' => 16,'invalid_dob' => 17,'invalid_agecat' => 18,'invalid_agecat_exp' => 19,'invalid_regdate' => 20,'invalid_race' => 21,'invalid_race_exp' => 22,'invalid_gender' => 23,'invalid_political_party' => 24,'invalid_politicalparty_exp' => 25,'invalid_phone' => 26,'invalid_active_status_exp' => 27,'invalid_voter_status_exp' => 28,'invalid_lastdatevote' => 29,'invalid_fname' => 30,'invalid_direction' => 31,'invalid_st' => 32,'invalid_zip5' => 33,'invalid_zip4' => 34,'invalid_cart' => 35,'invalid_cr_sort_sz' => 36,'invalid_lot' => 37,'invalid_lot_order' => 38,'invalid_dpbc' => 39,'invalid_chk_digit' => 40,'invalid_rec_type' => 41,'invalid_fips_state' => 42,'invalid_fips_county' => 43,'invalid_geo' => 44,'invalid_msa' => 45,'invalid_geo_blk' => 46,'invalid_geo_match' => 47,'invalid_err_stat' => 48,'invalid_changedate' => 49,'invalid_name_type' => 50,'invalid_addr_type' => 51,0);
 
EXPORT MakeFT_invalid_mandatory(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_populated_strings(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_populated_strings'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yn_empty(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yn_empty(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean_yn_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('N|Y|'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nums_empty(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_nums_empty(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_nums_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_range_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alphanum(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_non_empty_alphanum(s)>0);
EXPORT InValidMessageFT_invalid_alphanum(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_non_empty_alphanum'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum_empty(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum_empty(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alphanum_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanumquot_empty(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanumquot_empty(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" '))));
EXPORT InValidMessageFT_invalid_alphanumquot_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ" '),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum_specials(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum_specials(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'))));
EXPORT InValidMessageFT_invalid_alphanum_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @#-:./,`&\'Ã£Ã±Ã¨Ã³Ã©Ã Ã‚Ã¡Ã”Ã­Ã¶Ã‹Ãº'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate8(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate8(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate8(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_past_yyyymmdd'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ssn(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ssn(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,9)>0);
EXPORT InValidMessageFT_invalid_ssn(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_vtid(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_vtid(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_vtid(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['EMERGES','EMERGES']);
EXPORT InValidMessageFT_invalid_source(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('EMERGES|EMERGES'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_id(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_file_id(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['VOTE','VOTE']);
EXPORT InValidMessageFT_invalid_file_id(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('VOTE|VOTE'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_state(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_state(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_source_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_verify_state'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_name(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_last_name(SALT39.StrType s,SALT39.StrType first_name,SALT39.StrType middle_name) := WHICH(~Scrubs_Voters.Functions.fn_populated_strings(s,first_name,middle_name)>0);
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_populated_strings'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dob(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dob(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_generic_date(s)>0);
EXPORT InValidMessageFT_invalid_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_generic_date'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_agecat(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_agecat(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_agecat(s)>0);
EXPORT InValidMessageFT_invalid_agecat(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_agecat'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_agecat_exp(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_agecat_exp(SALT39.StrType s,SALT39.StrType agecat) := WHICH(~Scrubs_Voters.Functions.fn_valid_agecat_exp(s,agecat)>0);
EXPORT InValidMessageFT_invalid_agecat_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_agecat_exp'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_regdate(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_regdate(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_generic_date(s)>0);
EXPORT InValidMessageFT_invalid_regdate(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_generic_date'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_race(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_race(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_race(s)>0);
EXPORT InValidMessageFT_invalid_race(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_race'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_race_exp(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_race_exp(SALT39.StrType s,SALT39.StrType race) := WHICH(~Scrubs_Voters.Functions.fn_race_exp(s,race)>0);
EXPORT InValidMessageFT_invalid_race_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_race_exp'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['F','M','U','']);
EXPORT InValidMessageFT_invalid_gender(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('F|M|U|'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_political_party(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_political_party(SALT39.StrType s,SALT39.StrType politicalparty_exp) := WHICH(~Scrubs_Voters.Functions.fn_dependent_strings(s,politicalparty_exp)>0);
EXPORT InValidMessageFT_invalid_political_party(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_dependent_strings'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_politicalparty_exp(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_politicalparty_exp(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_political_party(s)>0);
EXPORT InValidMessageFT_invalid_politicalparty_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_political_party'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_verify_optional_phone'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_active_status_exp(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_active_status_exp(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['ACTIVE','INACTIVE','CANCELLED','']);
EXPORT InValidMessageFT_invalid_active_status_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('ACTIVE|INACTIVE|CANCELLED|'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_voter_status_exp(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_voter_status_exp(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_voter_status(s)>0);
EXPORT InValidMessageFT_invalid_voter_status_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_voter_status'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lastdatevote(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lastdatevote(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_valid_generic_date(s)>0);
EXPORT InValidMessageFT_invalid_lastdatevote(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_valid_generic_date'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fname(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fname(SALT39.StrType s,SALT39.StrType mname,SALT39.StrType lname) := WHICH(~Scrubs_Voters.Functions.fn_populated_strings(s,mname,lname)>0);
EXPORT InValidMessageFT_invalid_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_populated_strings'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT39.StrType s0) := FUNCTION
  s1 := SALT39.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT39.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT39.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInChars('ENSW'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_verify_state'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_verify_cart(s)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_verify_cart'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['A','B','C','D']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('A|B|C|D'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['A','D']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('A|D'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dpbc(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dpbc(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rec_type(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rec_type(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_addr_rec_type(s)>0);
EXPORT InValidMessageFT_invalid_rec_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_addr_rec_type'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_geo_coord'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_blk(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_blk(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,7)>0);
EXPORT InValidMessageFT_invalid_geo_blk(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_numeric'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_non_empty_alphanum(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_non_empty_alphanum'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_changedate(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_changedate(SALT39.StrType s) := WHICH(~Scrubs_Voters.Functions.fn_optional_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_changedate(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.CustomFail('Scrubs_Voters.Functions.fn_optional_past_yyyymmdd'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['2','']);
EXPORT InValidMessageFT_invalid_name_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('2|'),SALT39.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_addr_type(SALT39.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_addr_type(SALT39.StrType s) := WHICH(((SALT39.StrType) s) NOT IN ['M','']);
EXPORT InValidMessageFT_invalid_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT39.HygieneErrors.NotInEnum('M|'),SALT39.HygieneErrors.Good);
 
EXPORT SALT39.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'rid','did','did_score','ssn','vtid','process_date','date_first_seen','date_last_seen','source','file_id','vendor_id','source_state','source_code','file_acquired_date','use_code','prefix_title','last_name','first_name','middle_name','maiden_prior','clean_maiden_pri','name_suffix_in','voterfiller','source_voterid','dob','agecat','agecat_exp','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','race_exp','gender','political_party','politicalparty_exp','phone','work_phone','other_phone','active_status','active_status_exp','gendersurnamguess','active_other','voter_status','voter_status_exp','res_addr1','res_addr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','timezonetbl','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','cassaddrtyptbl','cassdelivpointcd','casscarrierrtetbl','blkgrpenumdist','congressionaldist','lattitude','countyfips','censustract','fipsstcountycd','longitude','contributorparty','recipientparty','dateofcontr','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller4','lastdatevote','miscvotehist','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_rec_type','mail_ace_fips_st','mail_fips_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','idtypes','precinct','ward1','idcode','precinctparttextdesig','precinctparttextname','precincttextdesig','marriedappend','supervisordistrict','district','ward2','citycountycouncil','countyprecinct','countycommis','schoolboard','ward3','towncitycouncil1','towncitycouncil2','regents','watershed','education','policeconstable','freeholder','municourt','changedate','name_type','addr_type');
EXPORT SALT39.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'rid','did','did_score','ssn','vtid','process_date','date_first_seen','date_last_seen','source','file_id','vendor_id','source_state','source_code','file_acquired_date','use_code','prefix_title','last_name','first_name','middle_name','maiden_prior','clean_maiden_pri','name_suffix_in','voterfiller','source_voterid','dob','agecat','agecat_exp','headhousehold','place_of_birth','occupation','maiden_name','motorvoterid','regsource','regdate','race','race_exp','gender','political_party','politicalparty_exp','phone','work_phone','other_phone','active_status','active_status_exp','gendersurnamguess','active_other','voter_status','voter_status_exp','res_addr1','res_addr2','res_city','res_state','res_zip','res_county','mail_addr1','mail_addr2','mail_city','mail_state','mail_zip','mail_county','addr_filler1','addr_filler2','city_filler','state_filler','zip_filler','timezonetbl','towncode','distcode','countycode','schoolcode','cityinout','spec_dist1','spec_dist2','precinct1','precinct2','precinct3','villageprecinct','schoolprecinct','ward','precinct_citytown','ancsmdindc','citycouncildist','countycommdist','statehouse','statesenate','ushouse','elemschooldist','schooldist','schoolfiller','commcolldist','dist_filler','municipal','villagedist','policejury','policedist','publicservcomm','rescue','fire','sanitary','sewerdist','waterdist','mosquitodist','taxdist','supremecourt','justiceofpeace','judicialdist','superiorctdist','appealsct','courtfiller','cassaddrtyptbl','cassdelivpointcd','casscarrierrtetbl','blkgrpenumdist','congressionaldist','lattitude','countyfips','censustract','fipsstcountycd','longitude','contributorparty','recipientparty','dateofcontr','dollaramt','officecontto','cumuldollaramt','contfiller1','contfiller2','conttype','contfiller4','lastdatevote','miscvotehist','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','mail_prim_range','mail_predir','mail_prim_name','mail_addr_suffix','mail_postdir','mail_unit_desig','mail_sec_range','mail_p_city_name','mail_v_city_name','mail_st','mail_ace_zip','mail_zip4','mail_cart','mail_cr_sort_sz','mail_lot','mail_lot_order','mail_dpbc','mail_chk_digit','mail_rec_type','mail_ace_fips_st','mail_fips_county','mail_geo_lat','mail_geo_long','mail_msa','mail_geo_blk','mail_geo_match','mail_err_stat','idtypes','precinct','ward1','idcode','precinctparttextdesig','precinctparttextname','precincttextdesig','marriedappend','supervisordistrict','district','ward2','citycountycouncil','countyprecinct','countycommis','schoolboard','ward3','towncitycouncil1','towncitycouncil2','regents','watershed','education','policeconstable','freeholder','municourt','changedate','name_type','addr_type');
EXPORT FieldNum(SALT39.StrType fn) := CASE(fn,'rid' => 0,'did' => 1,'did_score' => 2,'ssn' => 3,'vtid' => 4,'process_date' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'source' => 8,'file_id' => 9,'vendor_id' => 10,'source_state' => 11,'source_code' => 12,'file_acquired_date' => 13,'use_code' => 14,'prefix_title' => 15,'last_name' => 16,'first_name' => 17,'middle_name' => 18,'maiden_prior' => 19,'clean_maiden_pri' => 20,'name_suffix_in' => 21,'voterfiller' => 22,'source_voterid' => 23,'dob' => 24,'agecat' => 25,'agecat_exp' => 26,'headhousehold' => 27,'place_of_birth' => 28,'occupation' => 29,'maiden_name' => 30,'motorvoterid' => 31,'regsource' => 32,'regdate' => 33,'race' => 34,'race_exp' => 35,'gender' => 36,'political_party' => 37,'politicalparty_exp' => 38,'phone' => 39,'work_phone' => 40,'other_phone' => 41,'active_status' => 42,'active_status_exp' => 43,'gendersurnamguess' => 44,'active_other' => 45,'voter_status' => 46,'voter_status_exp' => 47,'res_addr1' => 48,'res_addr2' => 49,'res_city' => 50,'res_state' => 51,'res_zip' => 52,'res_county' => 53,'mail_addr1' => 54,'mail_addr2' => 55,'mail_city' => 56,'mail_state' => 57,'mail_zip' => 58,'mail_county' => 59,'addr_filler1' => 60,'addr_filler2' => 61,'city_filler' => 62,'state_filler' => 63,'zip_filler' => 64,'timezonetbl' => 65,'towncode' => 66,'distcode' => 67,'countycode' => 68,'schoolcode' => 69,'cityinout' => 70,'spec_dist1' => 71,'spec_dist2' => 72,'precinct1' => 73,'precinct2' => 74,'precinct3' => 75,'villageprecinct' => 76,'schoolprecinct' => 77,'ward' => 78,'precinct_citytown' => 79,'ancsmdindc' => 80,'citycouncildist' => 81,'countycommdist' => 82,'statehouse' => 83,'statesenate' => 84,'ushouse' => 85,'elemschooldist' => 86,'schooldist' => 87,'schoolfiller' => 88,'commcolldist' => 89,'dist_filler' => 90,'municipal' => 91,'villagedist' => 92,'policejury' => 93,'policedist' => 94,'publicservcomm' => 95,'rescue' => 96,'fire' => 97,'sanitary' => 98,'sewerdist' => 99,'waterdist' => 100,'mosquitodist' => 101,'taxdist' => 102,'supremecourt' => 103,'justiceofpeace' => 104,'judicialdist' => 105,'superiorctdist' => 106,'appealsct' => 107,'courtfiller' => 108,'cassaddrtyptbl' => 109,'cassdelivpointcd' => 110,'casscarrierrtetbl' => 111,'blkgrpenumdist' => 112,'congressionaldist' => 113,'lattitude' => 114,'countyfips' => 115,'censustract' => 116,'fipsstcountycd' => 117,'longitude' => 118,'contributorparty' => 119,'recipientparty' => 120,'dateofcontr' => 121,'dollaramt' => 122,'officecontto' => 123,'cumuldollaramt' => 124,'contfiller1' => 125,'contfiller2' => 126,'conttype' => 127,'contfiller4' => 128,'lastdatevote' => 129,'miscvotehist' => 130,'title' => 131,'fname' => 132,'mname' => 133,'lname' => 134,'name_suffix' => 135,'name_score' => 136,'prim_range' => 137,'predir' => 138,'prim_name' => 139,'addr_suffix' => 140,'postdir' => 141,'unit_desig' => 142,'sec_range' => 143,'p_city_name' => 144,'v_city_name' => 145,'st' => 146,'zip' => 147,'zip4' => 148,'cart' => 149,'cr_sort_sz' => 150,'lot' => 151,'lot_order' => 152,'dpbc' => 153,'chk_digit' => 154,'rec_type' => 155,'ace_fips_st' => 156,'fips_county' => 157,'geo_lat' => 158,'geo_long' => 159,'msa' => 160,'geo_blk' => 161,'geo_match' => 162,'err_stat' => 163,'mail_prim_range' => 164,'mail_predir' => 165,'mail_prim_name' => 166,'mail_addr_suffix' => 167,'mail_postdir' => 168,'mail_unit_desig' => 169,'mail_sec_range' => 170,'mail_p_city_name' => 171,'mail_v_city_name' => 172,'mail_st' => 173,'mail_ace_zip' => 174,'mail_zip4' => 175,'mail_cart' => 176,'mail_cr_sort_sz' => 177,'mail_lot' => 178,'mail_lot_order' => 179,'mail_dpbc' => 180,'mail_chk_digit' => 181,'mail_rec_type' => 182,'mail_ace_fips_st' => 183,'mail_fips_county' => 184,'mail_geo_lat' => 185,'mail_geo_long' => 186,'mail_msa' => 187,'mail_geo_blk' => 188,'mail_geo_match' => 189,'mail_err_stat' => 190,'idtypes' => 191,'precinct' => 192,'ward1' => 193,'idcode' => 194,'precinctparttextdesig' => 195,'precinctparttextname' => 196,'precincttextdesig' => 197,'marriedappend' => 198,'supervisordistrict' => 199,'district' => 200,'ward2' => 201,'citycountycouncil' => 202,'countyprecinct' => 203,'countycommis' => 204,'schoolboard' => 205,'ward3' => 206,'towncitycouncil1' => 207,'towncitycouncil2' => 208,'regents' => 209,'watershed' => 210,'education' => 211,'policeconstable' => 212,'freeholder' => 213,'municourt' => 214,'changedate' => 215,'name_type' => 216,'addr_type' => 217,0);
EXPORT SET OF SALT39.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],[],[],['CUSTOM'],['ALLOW'],['ALLOW'],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],[],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],[],['CUSTOM'],[],[],[],[],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],['ENUM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],['ENUM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_rid(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_rid(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_rid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_did(SALT39.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_did(SALT39.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_did_score(SALT39.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_did_score(SALT39.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_did_score(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_ssn(SALT39.StrType s0) := MakeFT_invalid_ssn(s0);
EXPORT InValid_ssn(SALT39.StrType s) := InValidFT_invalid_ssn(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_ssn(wh);
 
EXPORT Make_vtid(SALT39.StrType s0) := MakeFT_invalid_vtid(s0);
EXPORT InValid_vtid(SALT39.StrType s) := InValidFT_invalid_vtid(s);
EXPORT InValidMessage_vtid(UNSIGNED1 wh) := InValidMessageFT_invalid_vtid(wh);
 
EXPORT Make_process_date(SALT39.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_process_date(SALT39.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_date_first_seen(SALT39.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_date_first_seen(SALT39.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_date_last_seen(SALT39.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_date_last_seen(SALT39.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_source(SALT39.StrType s0) := MakeFT_invalid_source(s0);
EXPORT InValid_source(SALT39.StrType s) := InValidFT_invalid_source(s);
EXPORT InValidMessage_source(UNSIGNED1 wh) := InValidMessageFT_invalid_source(wh);
 
EXPORT Make_file_id(SALT39.StrType s0) := MakeFT_invalid_file_id(s0);
EXPORT InValid_file_id(SALT39.StrType s) := InValidFT_invalid_file_id(s);
EXPORT InValidMessage_file_id(UNSIGNED1 wh) := InValidMessageFT_invalid_file_id(wh);
 
EXPORT Make_vendor_id(SALT39.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_vendor_id(SALT39.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_vendor_id(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
 
EXPORT Make_source_state(SALT39.StrType s0) := MakeFT_invalid_source_state(s0);
EXPORT InValid_source_state(SALT39.StrType s) := InValidFT_invalid_source_state(s);
EXPORT InValidMessage_source_state(UNSIGNED1 wh) := InValidMessageFT_invalid_source_state(wh);
 
EXPORT Make_source_code(SALT39.StrType s0) := s0;
EXPORT InValid_source_code(SALT39.StrType s) := 0;
EXPORT InValidMessage_source_code(UNSIGNED1 wh) := '';
 
EXPORT Make_file_acquired_date(SALT39.StrType s0) := MakeFT_invalid_pastdate8(s0);
EXPORT InValid_file_acquired_date(SALT39.StrType s) := InValidFT_invalid_pastdate8(s);
EXPORT InValidMessage_file_acquired_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate8(wh);
 
EXPORT Make_use_code(SALT39.StrType s0) := s0;
EXPORT InValid_use_code(SALT39.StrType s) := 0;
EXPORT InValidMessage_use_code(UNSIGNED1 wh) := '';
 
EXPORT Make_prefix_title(SALT39.StrType s0) := s0;
EXPORT InValid_prefix_title(SALT39.StrType s) := 0;
EXPORT InValidMessage_prefix_title(UNSIGNED1 wh) := '';
 
EXPORT Make_last_name(SALT39.StrType s0) := MakeFT_invalid_last_name(s0);
EXPORT InValid_last_name(SALT39.StrType s,SALT39.StrType first_name,SALT39.StrType middle_name) := InValidFT_invalid_last_name(s,first_name,middle_name);
EXPORT InValidMessage_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_last_name(wh);
 
EXPORT Make_first_name(SALT39.StrType s0) := MakeFT_invalid_alphanum_specials(s0);
EXPORT InValid_first_name(SALT39.StrType s) := InValidFT_invalid_alphanum_specials(s);
EXPORT InValidMessage_first_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_specials(wh);
 
EXPORT Make_middle_name(SALT39.StrType s0) := MakeFT_invalid_alphanum_specials(s0);
EXPORT InValid_middle_name(SALT39.StrType s) := InValidFT_invalid_alphanum_specials(s);
EXPORT InValidMessage_middle_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_specials(wh);
 
EXPORT Make_maiden_prior(SALT39.StrType s0) := s0;
EXPORT InValid_maiden_prior(SALT39.StrType s) := 0;
EXPORT InValidMessage_maiden_prior(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_maiden_pri(SALT39.StrType s0) := s0;
EXPORT InValid_clean_maiden_pri(SALT39.StrType s) := 0;
EXPORT InValidMessage_clean_maiden_pri(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix_in(SALT39.StrType s0) := s0;
EXPORT InValid_name_suffix_in(SALT39.StrType s) := 0;
EXPORT InValidMessage_name_suffix_in(UNSIGNED1 wh) := '';
 
EXPORT Make_voterfiller(SALT39.StrType s0) := s0;
EXPORT InValid_voterfiller(SALT39.StrType s) := 0;
EXPORT InValidMessage_voterfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_source_voterid(SALT39.StrType s0) := MakeFT_invalid_alphanum(s0);
EXPORT InValid_source_voterid(SALT39.StrType s) := InValidFT_invalid_alphanum(s);
EXPORT InValidMessage_source_voterid(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum(wh);
 
EXPORT Make_dob(SALT39.StrType s0) := MakeFT_invalid_dob(s0);
EXPORT InValid_dob(SALT39.StrType s) := InValidFT_invalid_dob(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_dob(wh);
 
EXPORT Make_agecat(SALT39.StrType s0) := MakeFT_invalid_agecat(s0);
EXPORT InValid_agecat(SALT39.StrType s) := InValidFT_invalid_agecat(s);
EXPORT InValidMessage_agecat(UNSIGNED1 wh) := InValidMessageFT_invalid_agecat(wh);
 
EXPORT Make_agecat_exp(SALT39.StrType s0) := MakeFT_invalid_agecat_exp(s0);
EXPORT InValid_agecat_exp(SALT39.StrType s,SALT39.StrType agecat) := InValidFT_invalid_agecat_exp(s,agecat);
EXPORT InValidMessage_agecat_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_agecat_exp(wh);
 
EXPORT Make_headhousehold(SALT39.StrType s0) := s0;
EXPORT InValid_headhousehold(SALT39.StrType s) := 0;
EXPORT InValidMessage_headhousehold(UNSIGNED1 wh) := '';
 
EXPORT Make_place_of_birth(SALT39.StrType s0) := s0;
EXPORT InValid_place_of_birth(SALT39.StrType s) := 0;
EXPORT InValidMessage_place_of_birth(UNSIGNED1 wh) := '';
 
EXPORT Make_occupation(SALT39.StrType s0) := s0;
EXPORT InValid_occupation(SALT39.StrType s) := 0;
EXPORT InValidMessage_occupation(UNSIGNED1 wh) := '';
 
EXPORT Make_maiden_name(SALT39.StrType s0) := s0;
EXPORT InValid_maiden_name(SALT39.StrType s) := 0;
EXPORT InValidMessage_maiden_name(UNSIGNED1 wh) := '';
 
EXPORT Make_motorvoterid(SALT39.StrType s0) := s0;
EXPORT InValid_motorvoterid(SALT39.StrType s) := 0;
EXPORT InValidMessage_motorvoterid(UNSIGNED1 wh) := '';
 
EXPORT Make_regsource(SALT39.StrType s0) := s0;
EXPORT InValid_regsource(SALT39.StrType s) := 0;
EXPORT InValidMessage_regsource(UNSIGNED1 wh) := '';
 
EXPORT Make_regdate(SALT39.StrType s0) := MakeFT_invalid_regdate(s0);
EXPORT InValid_regdate(SALT39.StrType s) := InValidFT_invalid_regdate(s);
EXPORT InValidMessage_regdate(UNSIGNED1 wh) := InValidMessageFT_invalid_regdate(wh);
 
EXPORT Make_race(SALT39.StrType s0) := MakeFT_invalid_race(s0);
EXPORT InValid_race(SALT39.StrType s) := InValidFT_invalid_race(s);
EXPORT InValidMessage_race(UNSIGNED1 wh) := InValidMessageFT_invalid_race(wh);
 
EXPORT Make_race_exp(SALT39.StrType s0) := MakeFT_invalid_race_exp(s0);
EXPORT InValid_race_exp(SALT39.StrType s,SALT39.StrType race) := InValidFT_invalid_race_exp(s,race);
EXPORT InValidMessage_race_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_race_exp(wh);
 
EXPORT Make_gender(SALT39.StrType s0) := MakeFT_invalid_gender(s0);
EXPORT InValid_gender(SALT39.StrType s) := InValidFT_invalid_gender(s);
EXPORT InValidMessage_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender(wh);
 
EXPORT Make_political_party(SALT39.StrType s0) := MakeFT_invalid_political_party(s0);
EXPORT InValid_political_party(SALT39.StrType s,SALT39.StrType politicalparty_exp) := InValidFT_invalid_political_party(s,politicalparty_exp);
EXPORT InValidMessage_political_party(UNSIGNED1 wh) := InValidMessageFT_invalid_political_party(wh);
 
EXPORT Make_politicalparty_exp(SALT39.StrType s0) := MakeFT_invalid_politicalparty_exp(s0);
EXPORT InValid_politicalparty_exp(SALT39.StrType s) := InValidFT_invalid_politicalparty_exp(s);
EXPORT InValidMessage_politicalparty_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_politicalparty_exp(wh);
 
EXPORT Make_phone(SALT39.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT39.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_work_phone(SALT39.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_work_phone(SALT39.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_work_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_other_phone(SALT39.StrType s0) := MakeFT_invalid_nums_empty(s0);
EXPORT InValid_other_phone(SALT39.StrType s) := InValidFT_invalid_nums_empty(s);
EXPORT InValidMessage_other_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_nums_empty(wh);
 
EXPORT Make_active_status(SALT39.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_active_status(SALT39.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_active_status(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_active_status_exp(SALT39.StrType s0) := MakeFT_invalid_active_status_exp(s0);
EXPORT InValid_active_status_exp(SALT39.StrType s) := InValidFT_invalid_active_status_exp(s);
EXPORT InValidMessage_active_status_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_active_status_exp(wh);
 
EXPORT Make_gendersurnamguess(SALT39.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_gendersurnamguess(SALT39.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_gendersurnamguess(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_active_other(SALT39.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_active_other(SALT39.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_active_other(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_voter_status(SALT39.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_voter_status(SALT39.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_voter_status(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_voter_status_exp(SALT39.StrType s0) := MakeFT_invalid_voter_status_exp(s0);
EXPORT InValid_voter_status_exp(SALT39.StrType s) := InValidFT_invalid_voter_status_exp(s);
EXPORT InValidMessage_voter_status_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_voter_status_exp(wh);
 
EXPORT Make_res_addr1(SALT39.StrType s0) := s0;
EXPORT InValid_res_addr1(SALT39.StrType s) := 0;
EXPORT InValidMessage_res_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_res_addr2(SALT39.StrType s0) := s0;
EXPORT InValid_res_addr2(SALT39.StrType s) := 0;
EXPORT InValidMessage_res_addr2(UNSIGNED1 wh) := '';
 
EXPORT Make_res_city(SALT39.StrType s0) := s0;
EXPORT InValid_res_city(SALT39.StrType s) := 0;
EXPORT InValidMessage_res_city(UNSIGNED1 wh) := '';
 
EXPORT Make_res_state(SALT39.StrType s0) := s0;
EXPORT InValid_res_state(SALT39.StrType s) := 0;
EXPORT InValidMessage_res_state(UNSIGNED1 wh) := '';
 
EXPORT Make_res_zip(SALT39.StrType s0) := s0;
EXPORT InValid_res_zip(SALT39.StrType s) := 0;
EXPORT InValidMessage_res_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_res_county(SALT39.StrType s0) := s0;
EXPORT InValid_res_county(SALT39.StrType s) := 0;
EXPORT InValidMessage_res_county(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr1(SALT39.StrType s0) := s0;
EXPORT InValid_mail_addr1(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_addr2(SALT39.StrType s0) := s0;
EXPORT InValid_mail_addr2(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_addr2(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_city(SALT39.StrType s0) := s0;
EXPORT InValid_mail_city(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_city(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_state(SALT39.StrType s0) := s0;
EXPORT InValid_mail_state(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_state(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_zip(SALT39.StrType s0) := s0;
EXPORT InValid_mail_zip(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_county(SALT39.StrType s0) := s0;
EXPORT InValid_mail_county(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_county(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_filler1(SALT39.StrType s0) := s0;
EXPORT InValid_addr_filler1(SALT39.StrType s) := 0;
EXPORT InValidMessage_addr_filler1(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_filler2(SALT39.StrType s0) := s0;
EXPORT InValid_addr_filler2(SALT39.StrType s) := 0;
EXPORT InValidMessage_addr_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_city_filler(SALT39.StrType s0) := s0;
EXPORT InValid_city_filler(SALT39.StrType s) := 0;
EXPORT InValidMessage_city_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_state_filler(SALT39.StrType s0) := s0;
EXPORT InValid_state_filler(SALT39.StrType s) := 0;
EXPORT InValidMessage_state_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_zip_filler(SALT39.StrType s0) := s0;
EXPORT InValid_zip_filler(SALT39.StrType s) := 0;
EXPORT InValidMessage_zip_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_timezonetbl(SALT39.StrType s0) := MakeFT_invalid_nums_empty(s0);
EXPORT InValid_timezonetbl(SALT39.StrType s) := InValidFT_invalid_nums_empty(s);
EXPORT InValidMessage_timezonetbl(UNSIGNED1 wh) := InValidMessageFT_invalid_nums_empty(wh);
 
EXPORT Make_towncode(SALT39.StrType s0) := s0;
EXPORT InValid_towncode(SALT39.StrType s) := 0;
EXPORT InValidMessage_towncode(UNSIGNED1 wh) := '';
 
EXPORT Make_distcode(SALT39.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_distcode(SALT39.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_distcode(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_countycode(SALT39.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_countycode(SALT39.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_countycode(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_schoolcode(SALT39.StrType s0) := MakeFT_invalid_alphanum_specials(s0);
EXPORT InValid_schoolcode(SALT39.StrType s) := InValidFT_invalid_alphanum_specials(s);
EXPORT InValidMessage_schoolcode(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_specials(wh);
 
EXPORT Make_cityinout(SALT39.StrType s0) := s0;
EXPORT InValid_cityinout(SALT39.StrType s) := 0;
EXPORT InValidMessage_cityinout(UNSIGNED1 wh) := '';
 
EXPORT Make_spec_dist1(SALT39.StrType s0) := s0;
EXPORT InValid_spec_dist1(SALT39.StrType s) := 0;
EXPORT InValidMessage_spec_dist1(UNSIGNED1 wh) := '';
 
EXPORT Make_spec_dist2(SALT39.StrType s0) := s0;
EXPORT InValid_spec_dist2(SALT39.StrType s) := 0;
EXPORT InValidMessage_spec_dist2(UNSIGNED1 wh) := '';
 
EXPORT Make_precinct1(SALT39.StrType s0) := s0;
EXPORT InValid_precinct1(SALT39.StrType s) := 0;
EXPORT InValidMessage_precinct1(UNSIGNED1 wh) := '';
 
EXPORT Make_precinct2(SALT39.StrType s0) := s0;
EXPORT InValid_precinct2(SALT39.StrType s) := 0;
EXPORT InValidMessage_precinct2(UNSIGNED1 wh) := '';
 
EXPORT Make_precinct3(SALT39.StrType s0) := s0;
EXPORT InValid_precinct3(SALT39.StrType s) := 0;
EXPORT InValidMessage_precinct3(UNSIGNED1 wh) := '';
 
EXPORT Make_villageprecinct(SALT39.StrType s0) := s0;
EXPORT InValid_villageprecinct(SALT39.StrType s) := 0;
EXPORT InValidMessage_villageprecinct(UNSIGNED1 wh) := '';
 
EXPORT Make_schoolprecinct(SALT39.StrType s0) := s0;
EXPORT InValid_schoolprecinct(SALT39.StrType s) := 0;
EXPORT InValidMessage_schoolprecinct(UNSIGNED1 wh) := '';
 
EXPORT Make_ward(SALT39.StrType s0) := s0;
EXPORT InValid_ward(SALT39.StrType s) := 0;
EXPORT InValidMessage_ward(UNSIGNED1 wh) := '';
 
EXPORT Make_precinct_citytown(SALT39.StrType s0) := s0;
EXPORT InValid_precinct_citytown(SALT39.StrType s) := 0;
EXPORT InValidMessage_precinct_citytown(UNSIGNED1 wh) := '';
 
EXPORT Make_ancsmdindc(SALT39.StrType s0) := s0;
EXPORT InValid_ancsmdindc(SALT39.StrType s) := 0;
EXPORT InValidMessage_ancsmdindc(UNSIGNED1 wh) := '';
 
EXPORT Make_citycouncildist(SALT39.StrType s0) := s0;
EXPORT InValid_citycouncildist(SALT39.StrType s) := 0;
EXPORT InValidMessage_citycouncildist(UNSIGNED1 wh) := '';
 
EXPORT Make_countycommdist(SALT39.StrType s0) := s0;
EXPORT InValid_countycommdist(SALT39.StrType s) := 0;
EXPORT InValidMessage_countycommdist(UNSIGNED1 wh) := '';
 
EXPORT Make_statehouse(SALT39.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_statehouse(SALT39.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_statehouse(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_statesenate(SALT39.StrType s0) := MakeFT_invalid_alphanumquot_empty(s0);
EXPORT InValid_statesenate(SALT39.StrType s) := InValidFT_invalid_alphanumquot_empty(s);
EXPORT InValidMessage_statesenate(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanumquot_empty(wh);
 
EXPORT Make_ushouse(SALT39.StrType s0) := MakeFT_invalid_alphanum_empty(s0);
EXPORT InValid_ushouse(SALT39.StrType s) := InValidFT_invalid_alphanum_empty(s);
EXPORT InValidMessage_ushouse(UNSIGNED1 wh) := InValidMessageFT_invalid_alphanum_empty(wh);
 
EXPORT Make_elemschooldist(SALT39.StrType s0) := s0;
EXPORT InValid_elemschooldist(SALT39.StrType s) := 0;
EXPORT InValidMessage_elemschooldist(UNSIGNED1 wh) := '';
 
EXPORT Make_schooldist(SALT39.StrType s0) := s0;
EXPORT InValid_schooldist(SALT39.StrType s) := 0;
EXPORT InValidMessage_schooldist(UNSIGNED1 wh) := '';
 
EXPORT Make_schoolfiller(SALT39.StrType s0) := s0;
EXPORT InValid_schoolfiller(SALT39.StrType s) := 0;
EXPORT InValidMessage_schoolfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_commcolldist(SALT39.StrType s0) := s0;
EXPORT InValid_commcolldist(SALT39.StrType s) := 0;
EXPORT InValidMessage_commcolldist(UNSIGNED1 wh) := '';
 
EXPORT Make_dist_filler(SALT39.StrType s0) := s0;
EXPORT InValid_dist_filler(SALT39.StrType s) := 0;
EXPORT InValidMessage_dist_filler(UNSIGNED1 wh) := '';
 
EXPORT Make_municipal(SALT39.StrType s0) := s0;
EXPORT InValid_municipal(SALT39.StrType s) := 0;
EXPORT InValidMessage_municipal(UNSIGNED1 wh) := '';
 
EXPORT Make_villagedist(SALT39.StrType s0) := s0;
EXPORT InValid_villagedist(SALT39.StrType s) := 0;
EXPORT InValidMessage_villagedist(UNSIGNED1 wh) := '';
 
EXPORT Make_policejury(SALT39.StrType s0) := s0;
EXPORT InValid_policejury(SALT39.StrType s) := 0;
EXPORT InValidMessage_policejury(UNSIGNED1 wh) := '';
 
EXPORT Make_policedist(SALT39.StrType s0) := s0;
EXPORT InValid_policedist(SALT39.StrType s) := 0;
EXPORT InValidMessage_policedist(UNSIGNED1 wh) := '';
 
EXPORT Make_publicservcomm(SALT39.StrType s0) := s0;
EXPORT InValid_publicservcomm(SALT39.StrType s) := 0;
EXPORT InValidMessage_publicservcomm(UNSIGNED1 wh) := '';
 
EXPORT Make_rescue(SALT39.StrType s0) := s0;
EXPORT InValid_rescue(SALT39.StrType s) := 0;
EXPORT InValidMessage_rescue(UNSIGNED1 wh) := '';
 
EXPORT Make_fire(SALT39.StrType s0) := s0;
EXPORT InValid_fire(SALT39.StrType s) := 0;
EXPORT InValidMessage_fire(UNSIGNED1 wh) := '';
 
EXPORT Make_sanitary(SALT39.StrType s0) := s0;
EXPORT InValid_sanitary(SALT39.StrType s) := 0;
EXPORT InValidMessage_sanitary(UNSIGNED1 wh) := '';
 
EXPORT Make_sewerdist(SALT39.StrType s0) := s0;
EXPORT InValid_sewerdist(SALT39.StrType s) := 0;
EXPORT InValidMessage_sewerdist(UNSIGNED1 wh) := '';
 
EXPORT Make_waterdist(SALT39.StrType s0) := s0;
EXPORT InValid_waterdist(SALT39.StrType s) := 0;
EXPORT InValidMessage_waterdist(UNSIGNED1 wh) := '';
 
EXPORT Make_mosquitodist(SALT39.StrType s0) := s0;
EXPORT InValid_mosquitodist(SALT39.StrType s) := 0;
EXPORT InValidMessage_mosquitodist(UNSIGNED1 wh) := '';
 
EXPORT Make_taxdist(SALT39.StrType s0) := s0;
EXPORT InValid_taxdist(SALT39.StrType s) := 0;
EXPORT InValidMessage_taxdist(UNSIGNED1 wh) := '';
 
EXPORT Make_supremecourt(SALT39.StrType s0) := s0;
EXPORT InValid_supremecourt(SALT39.StrType s) := 0;
EXPORT InValidMessage_supremecourt(UNSIGNED1 wh) := '';
 
EXPORT Make_justiceofpeace(SALT39.StrType s0) := s0;
EXPORT InValid_justiceofpeace(SALT39.StrType s) := 0;
EXPORT InValidMessage_justiceofpeace(UNSIGNED1 wh) := '';
 
EXPORT Make_judicialdist(SALT39.StrType s0) := s0;
EXPORT InValid_judicialdist(SALT39.StrType s) := 0;
EXPORT InValidMessage_judicialdist(UNSIGNED1 wh) := '';
 
EXPORT Make_superiorctdist(SALT39.StrType s0) := s0;
EXPORT InValid_superiorctdist(SALT39.StrType s) := 0;
EXPORT InValidMessage_superiorctdist(UNSIGNED1 wh) := '';
 
EXPORT Make_appealsct(SALT39.StrType s0) := s0;
EXPORT InValid_appealsct(SALT39.StrType s) := 0;
EXPORT InValidMessage_appealsct(UNSIGNED1 wh) := '';
 
EXPORT Make_courtfiller(SALT39.StrType s0) := s0;
EXPORT InValid_courtfiller(SALT39.StrType s) := 0;
EXPORT InValidMessage_courtfiller(UNSIGNED1 wh) := '';
 
EXPORT Make_cassaddrtyptbl(SALT39.StrType s0) := s0;
EXPORT InValid_cassaddrtyptbl(SALT39.StrType s) := 0;
EXPORT InValidMessage_cassaddrtyptbl(UNSIGNED1 wh) := '';
 
EXPORT Make_cassdelivpointcd(SALT39.StrType s0) := s0;
EXPORT InValid_cassdelivpointcd(SALT39.StrType s) := 0;
EXPORT InValidMessage_cassdelivpointcd(UNSIGNED1 wh) := '';
 
EXPORT Make_casscarrierrtetbl(SALT39.StrType s0) := s0;
EXPORT InValid_casscarrierrtetbl(SALT39.StrType s) := 0;
EXPORT InValidMessage_casscarrierrtetbl(UNSIGNED1 wh) := '';
 
EXPORT Make_blkgrpenumdist(SALT39.StrType s0) := s0;
EXPORT InValid_blkgrpenumdist(SALT39.StrType s) := 0;
EXPORT InValidMessage_blkgrpenumdist(UNSIGNED1 wh) := '';
 
EXPORT Make_congressionaldist(SALT39.StrType s0) := s0;
EXPORT InValid_congressionaldist(SALT39.StrType s) := 0;
EXPORT InValidMessage_congressionaldist(UNSIGNED1 wh) := '';
 
EXPORT Make_lattitude(SALT39.StrType s0) := s0;
EXPORT InValid_lattitude(SALT39.StrType s) := 0;
EXPORT InValidMessage_lattitude(UNSIGNED1 wh) := '';
 
EXPORT Make_countyfips(SALT39.StrType s0) := s0;
EXPORT InValid_countyfips(SALT39.StrType s) := 0;
EXPORT InValidMessage_countyfips(UNSIGNED1 wh) := '';
 
EXPORT Make_censustract(SALT39.StrType s0) := s0;
EXPORT InValid_censustract(SALT39.StrType s) := 0;
EXPORT InValidMessage_censustract(UNSIGNED1 wh) := '';
 
EXPORT Make_fipsstcountycd(SALT39.StrType s0) := s0;
EXPORT InValid_fipsstcountycd(SALT39.StrType s) := 0;
EXPORT InValidMessage_fipsstcountycd(UNSIGNED1 wh) := '';
 
EXPORT Make_longitude(SALT39.StrType s0) := s0;
EXPORT InValid_longitude(SALT39.StrType s) := 0;
EXPORT InValidMessage_longitude(UNSIGNED1 wh) := '';
 
EXPORT Make_contributorparty(SALT39.StrType s0) := s0;
EXPORT InValid_contributorparty(SALT39.StrType s) := 0;
EXPORT InValidMessage_contributorparty(UNSIGNED1 wh) := '';
 
EXPORT Make_recipientparty(SALT39.StrType s0) := s0;
EXPORT InValid_recipientparty(SALT39.StrType s) := 0;
EXPORT InValidMessage_recipientparty(UNSIGNED1 wh) := '';
 
EXPORT Make_dateofcontr(SALT39.StrType s0) := s0;
EXPORT InValid_dateofcontr(SALT39.StrType s) := 0;
EXPORT InValidMessage_dateofcontr(UNSIGNED1 wh) := '';
 
EXPORT Make_dollaramt(SALT39.StrType s0) := s0;
EXPORT InValid_dollaramt(SALT39.StrType s) := 0;
EXPORT InValidMessage_dollaramt(UNSIGNED1 wh) := '';
 
EXPORT Make_officecontto(SALT39.StrType s0) := s0;
EXPORT InValid_officecontto(SALT39.StrType s) := 0;
EXPORT InValidMessage_officecontto(UNSIGNED1 wh) := '';
 
EXPORT Make_cumuldollaramt(SALT39.StrType s0) := s0;
EXPORT InValid_cumuldollaramt(SALT39.StrType s) := 0;
EXPORT InValidMessage_cumuldollaramt(UNSIGNED1 wh) := '';
 
EXPORT Make_contfiller1(SALT39.StrType s0) := s0;
EXPORT InValid_contfiller1(SALT39.StrType s) := 0;
EXPORT InValidMessage_contfiller1(UNSIGNED1 wh) := '';
 
EXPORT Make_contfiller2(SALT39.StrType s0) := s0;
EXPORT InValid_contfiller2(SALT39.StrType s) := 0;
EXPORT InValidMessage_contfiller2(UNSIGNED1 wh) := '';
 
EXPORT Make_conttype(SALT39.StrType s0) := s0;
EXPORT InValid_conttype(SALT39.StrType s) := 0;
EXPORT InValidMessage_conttype(UNSIGNED1 wh) := '';
 
EXPORT Make_contfiller4(SALT39.StrType s0) := s0;
EXPORT InValid_contfiller4(SALT39.StrType s) := 0;
EXPORT InValidMessage_contfiller4(UNSIGNED1 wh) := '';
 
EXPORT Make_lastdatevote(SALT39.StrType s0) := MakeFT_invalid_lastdatevote(s0);
EXPORT InValid_lastdatevote(SALT39.StrType s) := InValidFT_invalid_lastdatevote(s);
EXPORT InValidMessage_lastdatevote(UNSIGNED1 wh) := InValidMessageFT_invalid_lastdatevote(wh);
 
EXPORT Make_miscvotehist(SALT39.StrType s0) := s0;
EXPORT InValid_miscvotehist(SALT39.StrType s) := 0;
EXPORT InValidMessage_miscvotehist(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT39.StrType s0) := s0;
EXPORT InValid_title(SALT39.StrType s) := 0;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT39.StrType s0) := MakeFT_invalid_fname(s0);
EXPORT InValid_fname(SALT39.StrType s,SALT39.StrType mname,SALT39.StrType lname) := InValidFT_invalid_fname(s,mname,lname);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_fname(wh);
 
EXPORT Make_mname(SALT39.StrType s0) := s0;
EXPORT InValid_mname(SALT39.StrType s) := 0;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT39.StrType s0) := s0;
EXPORT InValid_lname(SALT39.StrType s) := 0;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT39.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT39.StrType s) := 0;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_name_score(SALT39.StrType s0) := s0;
EXPORT InValid_name_score(SALT39.StrType s) := 0;
EXPORT InValidMessage_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT39.StrType s0) := s0;
EXPORT InValid_prim_range(SALT39.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT39.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_predir(SALT39.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_prim_name(SALT39.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prim_name(SALT39.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr_suffix(SALT39.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT39.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT39.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_postdir(SALT39.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_unit_desig(SALT39.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT39.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT39.StrType s0) := s0;
EXPORT InValid_sec_range(SALT39.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT39.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_p_city_name(SALT39.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_v_city_name(SALT39.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_v_city_name(SALT39.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_st(SALT39.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_st(SALT39.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_zip(SALT39.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip(SALT39.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_zip4(SALT39.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT39.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_cart(SALT39.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_cart(SALT39.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_cr_sort_sz(SALT39.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT39.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_lot(SALT39.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_lot(SALT39.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_lot_order(SALT39.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_lot_order(SALT39.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_dpbc(SALT39.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_dpbc(SALT39.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_chk_digit(SALT39.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_chk_digit(SALT39.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_rec_type(SALT39.StrType s0) := MakeFT_invalid_rec_type(s0);
EXPORT InValid_rec_type(SALT39.StrType s) := InValidFT_invalid_rec_type(s);
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_rec_type(wh);
 
EXPORT Make_ace_fips_st(SALT39.StrType s0) := MakeFT_invalid_fips_state(s0);
EXPORT InValid_ace_fips_st(SALT39.StrType s) := InValidFT_invalid_fips_state(s);
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_state(wh);
 
EXPORT Make_fips_county(SALT39.StrType s0) := MakeFT_invalid_fips_county(s0);
EXPORT InValid_fips_county(SALT39.StrType s) := InValidFT_invalid_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_county(wh);
 
EXPORT Make_geo_lat(SALT39.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_lat(SALT39.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_geo_long(SALT39.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_long(SALT39.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_msa(SALT39.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_msa(SALT39.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_geo_blk(SALT39.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_geo_blk(SALT39.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
 
EXPORT Make_geo_match(SALT39.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_geo_match(SALT39.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_err_stat(SALT39.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_err_stat(SALT39.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
EXPORT Make_mail_prim_range(SALT39.StrType s0) := s0;
EXPORT InValid_mail_prim_range(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_predir(SALT39.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_mail_predir(SALT39.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_mail_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_mail_prim_name(SALT39.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mail_prim_name(SALT39.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mail_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mail_addr_suffix(SALT39.StrType s0) := s0;
EXPORT InValid_mail_addr_suffix(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_postdir(SALT39.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_mail_postdir(SALT39.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_mail_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_mail_unit_desig(SALT39.StrType s0) := s0;
EXPORT InValid_mail_unit_desig(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_sec_range(SALT39.StrType s0) := s0;
EXPORT InValid_mail_sec_range(SALT39.StrType s) := 0;
EXPORT InValidMessage_mail_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_mail_p_city_name(SALT39.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mail_p_city_name(SALT39.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mail_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mail_v_city_name(SALT39.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_mail_v_city_name(SALT39.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_mail_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_mail_st(SALT39.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_mail_st(SALT39.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_mail_st(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_mail_ace_zip(SALT39.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_mail_ace_zip(SALT39.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_mail_ace_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_mail_zip4(SALT39.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_mail_zip4(SALT39.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_mail_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_mail_cart(SALT39.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_mail_cart(SALT39.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_mail_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_mail_cr_sort_sz(SALT39.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_mail_cr_sort_sz(SALT39.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_mail_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_mail_lot(SALT39.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_mail_lot(SALT39.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_mail_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_mail_lot_order(SALT39.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_mail_lot_order(SALT39.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_mail_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_mail_dpbc(SALT39.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_mail_dpbc(SALT39.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_mail_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_mail_chk_digit(SALT39.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_mail_chk_digit(SALT39.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_mail_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_mail_rec_type(SALT39.StrType s0) := MakeFT_invalid_rec_type(s0);
EXPORT InValid_mail_rec_type(SALT39.StrType s) := InValidFT_invalid_rec_type(s);
EXPORT InValidMessage_mail_rec_type(UNSIGNED1 wh) := InValidMessageFT_invalid_rec_type(wh);
 
EXPORT Make_mail_ace_fips_st(SALT39.StrType s0) := MakeFT_invalid_fips_state(s0);
EXPORT InValid_mail_ace_fips_st(SALT39.StrType s) := InValidFT_invalid_fips_state(s);
EXPORT InValidMessage_mail_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_state(wh);
 
EXPORT Make_mail_fips_county(SALT39.StrType s0) := MakeFT_invalid_fips_county(s0);
EXPORT InValid_mail_fips_county(SALT39.StrType s) := InValidFT_invalid_fips_county(s);
EXPORT InValidMessage_mail_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_county(wh);
 
EXPORT Make_mail_geo_lat(SALT39.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_mail_geo_lat(SALT39.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_mail_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_mail_geo_long(SALT39.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_mail_geo_long(SALT39.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_mail_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_mail_msa(SALT39.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_mail_msa(SALT39.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_mail_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_mail_geo_blk(SALT39.StrType s0) := MakeFT_invalid_geo_blk(s0);
EXPORT InValid_mail_geo_blk(SALT39.StrType s) := InValidFT_invalid_geo_blk(s);
EXPORT InValidMessage_mail_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_blk(wh);
 
EXPORT Make_mail_geo_match(SALT39.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_mail_geo_match(SALT39.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_mail_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_mail_err_stat(SALT39.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_mail_err_stat(SALT39.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_mail_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
EXPORT Make_idtypes(SALT39.StrType s0) := s0;
EXPORT InValid_idtypes(SALT39.StrType s) := 0;
EXPORT InValidMessage_idtypes(UNSIGNED1 wh) := '';
 
EXPORT Make_precinct(SALT39.StrType s0) := s0;
EXPORT InValid_precinct(SALT39.StrType s) := 0;
EXPORT InValidMessage_precinct(UNSIGNED1 wh) := '';
 
EXPORT Make_ward1(SALT39.StrType s0) := s0;
EXPORT InValid_ward1(SALT39.StrType s) := 0;
EXPORT InValidMessage_ward1(UNSIGNED1 wh) := '';
 
EXPORT Make_idcode(SALT39.StrType s0) := s0;
EXPORT InValid_idcode(SALT39.StrType s) := 0;
EXPORT InValidMessage_idcode(UNSIGNED1 wh) := '';
 
EXPORT Make_precinctparttextdesig(SALT39.StrType s0) := s0;
EXPORT InValid_precinctparttextdesig(SALT39.StrType s) := 0;
EXPORT InValidMessage_precinctparttextdesig(UNSIGNED1 wh) := '';
 
EXPORT Make_precinctparttextname(SALT39.StrType s0) := s0;
EXPORT InValid_precinctparttextname(SALT39.StrType s) := 0;
EXPORT InValidMessage_precinctparttextname(UNSIGNED1 wh) := '';
 
EXPORT Make_precincttextdesig(SALT39.StrType s0) := s0;
EXPORT InValid_precincttextdesig(SALT39.StrType s) := 0;
EXPORT InValidMessage_precincttextdesig(UNSIGNED1 wh) := '';
 
EXPORT Make_marriedappend(SALT39.StrType s0) := MakeFT_invalid_boolean_yn_empty(s0);
EXPORT InValid_marriedappend(SALT39.StrType s) := InValidFT_invalid_boolean_yn_empty(s);
EXPORT InValidMessage_marriedappend(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_empty(wh);
 
EXPORT Make_supervisordistrict(SALT39.StrType s0) := s0;
EXPORT InValid_supervisordistrict(SALT39.StrType s) := 0;
EXPORT InValidMessage_supervisordistrict(UNSIGNED1 wh) := '';
 
EXPORT Make_district(SALT39.StrType s0) := s0;
EXPORT InValid_district(SALT39.StrType s) := 0;
EXPORT InValidMessage_district(UNSIGNED1 wh) := '';
 
EXPORT Make_ward2(SALT39.StrType s0) := s0;
EXPORT InValid_ward2(SALT39.StrType s) := 0;
EXPORT InValidMessage_ward2(UNSIGNED1 wh) := '';
 
EXPORT Make_citycountycouncil(SALT39.StrType s0) := s0;
EXPORT InValid_citycountycouncil(SALT39.StrType s) := 0;
EXPORT InValidMessage_citycountycouncil(UNSIGNED1 wh) := '';
 
EXPORT Make_countyprecinct(SALT39.StrType s0) := s0;
EXPORT InValid_countyprecinct(SALT39.StrType s) := 0;
EXPORT InValidMessage_countyprecinct(UNSIGNED1 wh) := '';
 
EXPORT Make_countycommis(SALT39.StrType s0) := s0;
EXPORT InValid_countycommis(SALT39.StrType s) := 0;
EXPORT InValidMessage_countycommis(UNSIGNED1 wh) := '';
 
EXPORT Make_schoolboard(SALT39.StrType s0) := s0;
EXPORT InValid_schoolboard(SALT39.StrType s) := 0;
EXPORT InValidMessage_schoolboard(UNSIGNED1 wh) := '';
 
EXPORT Make_ward3(SALT39.StrType s0) := s0;
EXPORT InValid_ward3(SALT39.StrType s) := 0;
EXPORT InValidMessage_ward3(UNSIGNED1 wh) := '';
 
EXPORT Make_towncitycouncil1(SALT39.StrType s0) := s0;
EXPORT InValid_towncitycouncil1(SALT39.StrType s) := 0;
EXPORT InValidMessage_towncitycouncil1(UNSIGNED1 wh) := '';
 
EXPORT Make_towncitycouncil2(SALT39.StrType s0) := s0;
EXPORT InValid_towncitycouncil2(SALT39.StrType s) := 0;
EXPORT InValidMessage_towncitycouncil2(UNSIGNED1 wh) := '';
 
EXPORT Make_regents(SALT39.StrType s0) := s0;
EXPORT InValid_regents(SALT39.StrType s) := 0;
EXPORT InValidMessage_regents(UNSIGNED1 wh) := '';
 
EXPORT Make_watershed(SALT39.StrType s0) := s0;
EXPORT InValid_watershed(SALT39.StrType s) := 0;
EXPORT InValidMessage_watershed(UNSIGNED1 wh) := '';
 
EXPORT Make_education(SALT39.StrType s0) := s0;
EXPORT InValid_education(SALT39.StrType s) := 0;
EXPORT InValidMessage_education(UNSIGNED1 wh) := '';
 
EXPORT Make_policeconstable(SALT39.StrType s0) := s0;
EXPORT InValid_policeconstable(SALT39.StrType s) := 0;
EXPORT InValidMessage_policeconstable(UNSIGNED1 wh) := '';
 
EXPORT Make_freeholder(SALT39.StrType s0) := s0;
EXPORT InValid_freeholder(SALT39.StrType s) := 0;
EXPORT InValidMessage_freeholder(UNSIGNED1 wh) := '';
 
EXPORT Make_municourt(SALT39.StrType s0) := s0;
EXPORT InValid_municourt(SALT39.StrType s) := 0;
EXPORT InValidMessage_municourt(UNSIGNED1 wh) := '';
 
EXPORT Make_changedate(SALT39.StrType s0) := MakeFT_invalid_changedate(s0);
EXPORT InValid_changedate(SALT39.StrType s) := InValidFT_invalid_changedate(s);
EXPORT InValidMessage_changedate(UNSIGNED1 wh) := InValidMessageFT_invalid_changedate(wh);
 
EXPORT Make_name_type(SALT39.StrType s0) := MakeFT_invalid_name_type(s0);
EXPORT InValid_name_type(SALT39.StrType s) := InValidFT_invalid_name_type(s);
EXPORT InValidMessage_name_type(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type(wh);
 
EXPORT Make_addr_type(SALT39.StrType s0) := MakeFT_invalid_addr_type(s0);
EXPORT InValid_addr_type(SALT39.StrType s) := InValidFT_invalid_addr_type(s);
EXPORT InValidMessage_addr_type(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_type(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT39,Scrubs_Voters;
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
    BOOLEAN Diff_rid;
    BOOLEAN Diff_did;
    BOOLEAN Diff_did_score;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_vtid;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_source;
    BOOLEAN Diff_file_id;
    BOOLEAN Diff_vendor_id;
    BOOLEAN Diff_source_state;
    BOOLEAN Diff_source_code;
    BOOLEAN Diff_file_acquired_date;
    BOOLEAN Diff_use_code;
    BOOLEAN Diff_prefix_title;
    BOOLEAN Diff_last_name;
    BOOLEAN Diff_first_name;
    BOOLEAN Diff_middle_name;
    BOOLEAN Diff_maiden_prior;
    BOOLEAN Diff_clean_maiden_pri;
    BOOLEAN Diff_name_suffix_in;
    BOOLEAN Diff_voterfiller;
    BOOLEAN Diff_source_voterid;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_agecat;
    BOOLEAN Diff_agecat_exp;
    BOOLEAN Diff_headhousehold;
    BOOLEAN Diff_place_of_birth;
    BOOLEAN Diff_occupation;
    BOOLEAN Diff_maiden_name;
    BOOLEAN Diff_motorvoterid;
    BOOLEAN Diff_regsource;
    BOOLEAN Diff_regdate;
    BOOLEAN Diff_race;
    BOOLEAN Diff_race_exp;
    BOOLEAN Diff_gender;
    BOOLEAN Diff_political_party;
    BOOLEAN Diff_politicalparty_exp;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_work_phone;
    BOOLEAN Diff_other_phone;
    BOOLEAN Diff_active_status;
    BOOLEAN Diff_active_status_exp;
    BOOLEAN Diff_gendersurnamguess;
    BOOLEAN Diff_active_other;
    BOOLEAN Diff_voter_status;
    BOOLEAN Diff_voter_status_exp;
    BOOLEAN Diff_res_addr1;
    BOOLEAN Diff_res_addr2;
    BOOLEAN Diff_res_city;
    BOOLEAN Diff_res_state;
    BOOLEAN Diff_res_zip;
    BOOLEAN Diff_res_county;
    BOOLEAN Diff_mail_addr1;
    BOOLEAN Diff_mail_addr2;
    BOOLEAN Diff_mail_city;
    BOOLEAN Diff_mail_state;
    BOOLEAN Diff_mail_zip;
    BOOLEAN Diff_mail_county;
    BOOLEAN Diff_addr_filler1;
    BOOLEAN Diff_addr_filler2;
    BOOLEAN Diff_city_filler;
    BOOLEAN Diff_state_filler;
    BOOLEAN Diff_zip_filler;
    BOOLEAN Diff_timezonetbl;
    BOOLEAN Diff_towncode;
    BOOLEAN Diff_distcode;
    BOOLEAN Diff_countycode;
    BOOLEAN Diff_schoolcode;
    BOOLEAN Diff_cityinout;
    BOOLEAN Diff_spec_dist1;
    BOOLEAN Diff_spec_dist2;
    BOOLEAN Diff_precinct1;
    BOOLEAN Diff_precinct2;
    BOOLEAN Diff_precinct3;
    BOOLEAN Diff_villageprecinct;
    BOOLEAN Diff_schoolprecinct;
    BOOLEAN Diff_ward;
    BOOLEAN Diff_precinct_citytown;
    BOOLEAN Diff_ancsmdindc;
    BOOLEAN Diff_citycouncildist;
    BOOLEAN Diff_countycommdist;
    BOOLEAN Diff_statehouse;
    BOOLEAN Diff_statesenate;
    BOOLEAN Diff_ushouse;
    BOOLEAN Diff_elemschooldist;
    BOOLEAN Diff_schooldist;
    BOOLEAN Diff_schoolfiller;
    BOOLEAN Diff_commcolldist;
    BOOLEAN Diff_dist_filler;
    BOOLEAN Diff_municipal;
    BOOLEAN Diff_villagedist;
    BOOLEAN Diff_policejury;
    BOOLEAN Diff_policedist;
    BOOLEAN Diff_publicservcomm;
    BOOLEAN Diff_rescue;
    BOOLEAN Diff_fire;
    BOOLEAN Diff_sanitary;
    BOOLEAN Diff_sewerdist;
    BOOLEAN Diff_waterdist;
    BOOLEAN Diff_mosquitodist;
    BOOLEAN Diff_taxdist;
    BOOLEAN Diff_supremecourt;
    BOOLEAN Diff_justiceofpeace;
    BOOLEAN Diff_judicialdist;
    BOOLEAN Diff_superiorctdist;
    BOOLEAN Diff_appealsct;
    BOOLEAN Diff_courtfiller;
    BOOLEAN Diff_cassaddrtyptbl;
    BOOLEAN Diff_cassdelivpointcd;
    BOOLEAN Diff_casscarrierrtetbl;
    BOOLEAN Diff_blkgrpenumdist;
    BOOLEAN Diff_congressionaldist;
    BOOLEAN Diff_lattitude;
    BOOLEAN Diff_countyfips;
    BOOLEAN Diff_censustract;
    BOOLEAN Diff_fipsstcountycd;
    BOOLEAN Diff_longitude;
    BOOLEAN Diff_contributorparty;
    BOOLEAN Diff_recipientparty;
    BOOLEAN Diff_dateofcontr;
    BOOLEAN Diff_dollaramt;
    BOOLEAN Diff_officecontto;
    BOOLEAN Diff_cumuldollaramt;
    BOOLEAN Diff_contfiller1;
    BOOLEAN Diff_contfiller2;
    BOOLEAN Diff_conttype;
    BOOLEAN Diff_contfiller4;
    BOOLEAN Diff_lastdatevote;
    BOOLEAN Diff_miscvotehist;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_name_score;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_mail_prim_range;
    BOOLEAN Diff_mail_predir;
    BOOLEAN Diff_mail_prim_name;
    BOOLEAN Diff_mail_addr_suffix;
    BOOLEAN Diff_mail_postdir;
    BOOLEAN Diff_mail_unit_desig;
    BOOLEAN Diff_mail_sec_range;
    BOOLEAN Diff_mail_p_city_name;
    BOOLEAN Diff_mail_v_city_name;
    BOOLEAN Diff_mail_st;
    BOOLEAN Diff_mail_ace_zip;
    BOOLEAN Diff_mail_zip4;
    BOOLEAN Diff_mail_cart;
    BOOLEAN Diff_mail_cr_sort_sz;
    BOOLEAN Diff_mail_lot;
    BOOLEAN Diff_mail_lot_order;
    BOOLEAN Diff_mail_dpbc;
    BOOLEAN Diff_mail_chk_digit;
    BOOLEAN Diff_mail_rec_type;
    BOOLEAN Diff_mail_ace_fips_st;
    BOOLEAN Diff_mail_fips_county;
    BOOLEAN Diff_mail_geo_lat;
    BOOLEAN Diff_mail_geo_long;
    BOOLEAN Diff_mail_msa;
    BOOLEAN Diff_mail_geo_blk;
    BOOLEAN Diff_mail_geo_match;
    BOOLEAN Diff_mail_err_stat;
    BOOLEAN Diff_idtypes;
    BOOLEAN Diff_precinct;
    BOOLEAN Diff_ward1;
    BOOLEAN Diff_idcode;
    BOOLEAN Diff_precinctparttextdesig;
    BOOLEAN Diff_precinctparttextname;
    BOOLEAN Diff_precincttextdesig;
    BOOLEAN Diff_marriedappend;
    BOOLEAN Diff_supervisordistrict;
    BOOLEAN Diff_district;
    BOOLEAN Diff_ward2;
    BOOLEAN Diff_citycountycouncil;
    BOOLEAN Diff_countyprecinct;
    BOOLEAN Diff_countycommis;
    BOOLEAN Diff_schoolboard;
    BOOLEAN Diff_ward3;
    BOOLEAN Diff_towncitycouncil1;
    BOOLEAN Diff_towncitycouncil2;
    BOOLEAN Diff_regents;
    BOOLEAN Diff_watershed;
    BOOLEAN Diff_education;
    BOOLEAN Diff_policeconstable;
    BOOLEAN Diff_freeholder;
    BOOLEAN Diff_municourt;
    BOOLEAN Diff_changedate;
    BOOLEAN Diff_name_type;
    BOOLEAN Diff_addr_type;
    UNSIGNED Num_Diffs;
    SALT39.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_rid := le.rid <> ri.rid;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_did_score := le.did_score <> ri.did_score;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_vtid := le.vtid <> ri.vtid;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_source := le.source <> ri.source;
    SELF.Diff_file_id := le.file_id <> ri.file_id;
    SELF.Diff_vendor_id := le.vendor_id <> ri.vendor_id;
    SELF.Diff_source_state := le.source_state <> ri.source_state;
    SELF.Diff_source_code := le.source_code <> ri.source_code;
    SELF.Diff_file_acquired_date := le.file_acquired_date <> ri.file_acquired_date;
    SELF.Diff_use_code := le.use_code <> ri.use_code;
    SELF.Diff_prefix_title := le.prefix_title <> ri.prefix_title;
    SELF.Diff_last_name := le.last_name <> ri.last_name;
    SELF.Diff_first_name := le.first_name <> ri.first_name;
    SELF.Diff_middle_name := le.middle_name <> ri.middle_name;
    SELF.Diff_maiden_prior := le.maiden_prior <> ri.maiden_prior;
    SELF.Diff_clean_maiden_pri := le.clean_maiden_pri <> ri.clean_maiden_pri;
    SELF.Diff_name_suffix_in := le.name_suffix_in <> ri.name_suffix_in;
    SELF.Diff_voterfiller := le.voterfiller <> ri.voterfiller;
    SELF.Diff_source_voterid := le.source_voterid <> ri.source_voterid;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_agecat := le.agecat <> ri.agecat;
    SELF.Diff_agecat_exp := le.agecat_exp <> ri.agecat_exp;
    SELF.Diff_headhousehold := le.headhousehold <> ri.headhousehold;
    SELF.Diff_place_of_birth := le.place_of_birth <> ri.place_of_birth;
    SELF.Diff_occupation := le.occupation <> ri.occupation;
    SELF.Diff_maiden_name := le.maiden_name <> ri.maiden_name;
    SELF.Diff_motorvoterid := le.motorvoterid <> ri.motorvoterid;
    SELF.Diff_regsource := le.regsource <> ri.regsource;
    SELF.Diff_regdate := le.regdate <> ri.regdate;
    SELF.Diff_race := le.race <> ri.race;
    SELF.Diff_race_exp := le.race_exp <> ri.race_exp;
    SELF.Diff_gender := le.gender <> ri.gender;
    SELF.Diff_political_party := le.political_party <> ri.political_party;
    SELF.Diff_politicalparty_exp := le.politicalparty_exp <> ri.politicalparty_exp;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_work_phone := le.work_phone <> ri.work_phone;
    SELF.Diff_other_phone := le.other_phone <> ri.other_phone;
    SELF.Diff_active_status := le.active_status <> ri.active_status;
    SELF.Diff_active_status_exp := le.active_status_exp <> ri.active_status_exp;
    SELF.Diff_gendersurnamguess := le.gendersurnamguess <> ri.gendersurnamguess;
    SELF.Diff_active_other := le.active_other <> ri.active_other;
    SELF.Diff_voter_status := le.voter_status <> ri.voter_status;
    SELF.Diff_voter_status_exp := le.voter_status_exp <> ri.voter_status_exp;
    SELF.Diff_res_addr1 := le.res_addr1 <> ri.res_addr1;
    SELF.Diff_res_addr2 := le.res_addr2 <> ri.res_addr2;
    SELF.Diff_res_city := le.res_city <> ri.res_city;
    SELF.Diff_res_state := le.res_state <> ri.res_state;
    SELF.Diff_res_zip := le.res_zip <> ri.res_zip;
    SELF.Diff_res_county := le.res_county <> ri.res_county;
    SELF.Diff_mail_addr1 := le.mail_addr1 <> ri.mail_addr1;
    SELF.Diff_mail_addr2 := le.mail_addr2 <> ri.mail_addr2;
    SELF.Diff_mail_city := le.mail_city <> ri.mail_city;
    SELF.Diff_mail_state := le.mail_state <> ri.mail_state;
    SELF.Diff_mail_zip := le.mail_zip <> ri.mail_zip;
    SELF.Diff_mail_county := le.mail_county <> ri.mail_county;
    SELF.Diff_addr_filler1 := le.addr_filler1 <> ri.addr_filler1;
    SELF.Diff_addr_filler2 := le.addr_filler2 <> ri.addr_filler2;
    SELF.Diff_city_filler := le.city_filler <> ri.city_filler;
    SELF.Diff_state_filler := le.state_filler <> ri.state_filler;
    SELF.Diff_zip_filler := le.zip_filler <> ri.zip_filler;
    SELF.Diff_timezonetbl := le.timezonetbl <> ri.timezonetbl;
    SELF.Diff_towncode := le.towncode <> ri.towncode;
    SELF.Diff_distcode := le.distcode <> ri.distcode;
    SELF.Diff_countycode := le.countycode <> ri.countycode;
    SELF.Diff_schoolcode := le.schoolcode <> ri.schoolcode;
    SELF.Diff_cityinout := le.cityinout <> ri.cityinout;
    SELF.Diff_spec_dist1 := le.spec_dist1 <> ri.spec_dist1;
    SELF.Diff_spec_dist2 := le.spec_dist2 <> ri.spec_dist2;
    SELF.Diff_precinct1 := le.precinct1 <> ri.precinct1;
    SELF.Diff_precinct2 := le.precinct2 <> ri.precinct2;
    SELF.Diff_precinct3 := le.precinct3 <> ri.precinct3;
    SELF.Diff_villageprecinct := le.villageprecinct <> ri.villageprecinct;
    SELF.Diff_schoolprecinct := le.schoolprecinct <> ri.schoolprecinct;
    SELF.Diff_ward := le.ward <> ri.ward;
    SELF.Diff_precinct_citytown := le.precinct_citytown <> ri.precinct_citytown;
    SELF.Diff_ancsmdindc := le.ancsmdindc <> ri.ancsmdindc;
    SELF.Diff_citycouncildist := le.citycouncildist <> ri.citycouncildist;
    SELF.Diff_countycommdist := le.countycommdist <> ri.countycommdist;
    SELF.Diff_statehouse := le.statehouse <> ri.statehouse;
    SELF.Diff_statesenate := le.statesenate <> ri.statesenate;
    SELF.Diff_ushouse := le.ushouse <> ri.ushouse;
    SELF.Diff_elemschooldist := le.elemschooldist <> ri.elemschooldist;
    SELF.Diff_schooldist := le.schooldist <> ri.schooldist;
    SELF.Diff_schoolfiller := le.schoolfiller <> ri.schoolfiller;
    SELF.Diff_commcolldist := le.commcolldist <> ri.commcolldist;
    SELF.Diff_dist_filler := le.dist_filler <> ri.dist_filler;
    SELF.Diff_municipal := le.municipal <> ri.municipal;
    SELF.Diff_villagedist := le.villagedist <> ri.villagedist;
    SELF.Diff_policejury := le.policejury <> ri.policejury;
    SELF.Diff_policedist := le.policedist <> ri.policedist;
    SELF.Diff_publicservcomm := le.publicservcomm <> ri.publicservcomm;
    SELF.Diff_rescue := le.rescue <> ri.rescue;
    SELF.Diff_fire := le.fire <> ri.fire;
    SELF.Diff_sanitary := le.sanitary <> ri.sanitary;
    SELF.Diff_sewerdist := le.sewerdist <> ri.sewerdist;
    SELF.Diff_waterdist := le.waterdist <> ri.waterdist;
    SELF.Diff_mosquitodist := le.mosquitodist <> ri.mosquitodist;
    SELF.Diff_taxdist := le.taxdist <> ri.taxdist;
    SELF.Diff_supremecourt := le.supremecourt <> ri.supremecourt;
    SELF.Diff_justiceofpeace := le.justiceofpeace <> ri.justiceofpeace;
    SELF.Diff_judicialdist := le.judicialdist <> ri.judicialdist;
    SELF.Diff_superiorctdist := le.superiorctdist <> ri.superiorctdist;
    SELF.Diff_appealsct := le.appealsct <> ri.appealsct;
    SELF.Diff_courtfiller := le.courtfiller <> ri.courtfiller;
    SELF.Diff_cassaddrtyptbl := le.cassaddrtyptbl <> ri.cassaddrtyptbl;
    SELF.Diff_cassdelivpointcd := le.cassdelivpointcd <> ri.cassdelivpointcd;
    SELF.Diff_casscarrierrtetbl := le.casscarrierrtetbl <> ri.casscarrierrtetbl;
    SELF.Diff_blkgrpenumdist := le.blkgrpenumdist <> ri.blkgrpenumdist;
    SELF.Diff_congressionaldist := le.congressionaldist <> ri.congressionaldist;
    SELF.Diff_lattitude := le.lattitude <> ri.lattitude;
    SELF.Diff_countyfips := le.countyfips <> ri.countyfips;
    SELF.Diff_censustract := le.censustract <> ri.censustract;
    SELF.Diff_fipsstcountycd := le.fipsstcountycd <> ri.fipsstcountycd;
    SELF.Diff_longitude := le.longitude <> ri.longitude;
    SELF.Diff_contributorparty := le.contributorparty <> ri.contributorparty;
    SELF.Diff_recipientparty := le.recipientparty <> ri.recipientparty;
    SELF.Diff_dateofcontr := le.dateofcontr <> ri.dateofcontr;
    SELF.Diff_dollaramt := le.dollaramt <> ri.dollaramt;
    SELF.Diff_officecontto := le.officecontto <> ri.officecontto;
    SELF.Diff_cumuldollaramt := le.cumuldollaramt <> ri.cumuldollaramt;
    SELF.Diff_contfiller1 := le.contfiller1 <> ri.contfiller1;
    SELF.Diff_contfiller2 := le.contfiller2 <> ri.contfiller2;
    SELF.Diff_conttype := le.conttype <> ri.conttype;
    SELF.Diff_contfiller4 := le.contfiller4 <> ri.contfiller4;
    SELF.Diff_lastdatevote := le.lastdatevote <> ri.lastdatevote;
    SELF.Diff_miscvotehist := le.miscvotehist <> ri.miscvotehist;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_name_score := le.name_score <> ri.name_score;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_mail_prim_range := le.mail_prim_range <> ri.mail_prim_range;
    SELF.Diff_mail_predir := le.mail_predir <> ri.mail_predir;
    SELF.Diff_mail_prim_name := le.mail_prim_name <> ri.mail_prim_name;
    SELF.Diff_mail_addr_suffix := le.mail_addr_suffix <> ri.mail_addr_suffix;
    SELF.Diff_mail_postdir := le.mail_postdir <> ri.mail_postdir;
    SELF.Diff_mail_unit_desig := le.mail_unit_desig <> ri.mail_unit_desig;
    SELF.Diff_mail_sec_range := le.mail_sec_range <> ri.mail_sec_range;
    SELF.Diff_mail_p_city_name := le.mail_p_city_name <> ri.mail_p_city_name;
    SELF.Diff_mail_v_city_name := le.mail_v_city_name <> ri.mail_v_city_name;
    SELF.Diff_mail_st := le.mail_st <> ri.mail_st;
    SELF.Diff_mail_ace_zip := le.mail_ace_zip <> ri.mail_ace_zip;
    SELF.Diff_mail_zip4 := le.mail_zip4 <> ri.mail_zip4;
    SELF.Diff_mail_cart := le.mail_cart <> ri.mail_cart;
    SELF.Diff_mail_cr_sort_sz := le.mail_cr_sort_sz <> ri.mail_cr_sort_sz;
    SELF.Diff_mail_lot := le.mail_lot <> ri.mail_lot;
    SELF.Diff_mail_lot_order := le.mail_lot_order <> ri.mail_lot_order;
    SELF.Diff_mail_dpbc := le.mail_dpbc <> ri.mail_dpbc;
    SELF.Diff_mail_chk_digit := le.mail_chk_digit <> ri.mail_chk_digit;
    SELF.Diff_mail_rec_type := le.mail_rec_type <> ri.mail_rec_type;
    SELF.Diff_mail_ace_fips_st := le.mail_ace_fips_st <> ri.mail_ace_fips_st;
    SELF.Diff_mail_fips_county := le.mail_fips_county <> ri.mail_fips_county;
    SELF.Diff_mail_geo_lat := le.mail_geo_lat <> ri.mail_geo_lat;
    SELF.Diff_mail_geo_long := le.mail_geo_long <> ri.mail_geo_long;
    SELF.Diff_mail_msa := le.mail_msa <> ri.mail_msa;
    SELF.Diff_mail_geo_blk := le.mail_geo_blk <> ri.mail_geo_blk;
    SELF.Diff_mail_geo_match := le.mail_geo_match <> ri.mail_geo_match;
    SELF.Diff_mail_err_stat := le.mail_err_stat <> ri.mail_err_stat;
    SELF.Diff_idtypes := le.idtypes <> ri.idtypes;
    SELF.Diff_precinct := le.precinct <> ri.precinct;
    SELF.Diff_ward1 := le.ward1 <> ri.ward1;
    SELF.Diff_idcode := le.idcode <> ri.idcode;
    SELF.Diff_precinctparttextdesig := le.precinctparttextdesig <> ri.precinctparttextdesig;
    SELF.Diff_precinctparttextname := le.precinctparttextname <> ri.precinctparttextname;
    SELF.Diff_precincttextdesig := le.precincttextdesig <> ri.precincttextdesig;
    SELF.Diff_marriedappend := le.marriedappend <> ri.marriedappend;
    SELF.Diff_supervisordistrict := le.supervisordistrict <> ri.supervisordistrict;
    SELF.Diff_district := le.district <> ri.district;
    SELF.Diff_ward2 := le.ward2 <> ri.ward2;
    SELF.Diff_citycountycouncil := le.citycountycouncil <> ri.citycountycouncil;
    SELF.Diff_countyprecinct := le.countyprecinct <> ri.countyprecinct;
    SELF.Diff_countycommis := le.countycommis <> ri.countycommis;
    SELF.Diff_schoolboard := le.schoolboard <> ri.schoolboard;
    SELF.Diff_ward3 := le.ward3 <> ri.ward3;
    SELF.Diff_towncitycouncil1 := le.towncitycouncil1 <> ri.towncitycouncil1;
    SELF.Diff_towncitycouncil2 := le.towncitycouncil2 <> ri.towncitycouncil2;
    SELF.Diff_regents := le.regents <> ri.regents;
    SELF.Diff_watershed := le.watershed <> ri.watershed;
    SELF.Diff_education := le.education <> ri.education;
    SELF.Diff_policeconstable := le.policeconstable <> ri.policeconstable;
    SELF.Diff_freeholder := le.freeholder <> ri.freeholder;
    SELF.Diff_municourt := le.municourt <> ri.municourt;
    SELF.Diff_changedate := le.changedate <> ri.changedate;
    SELF.Diff_name_type := le.name_type <> ri.name_type;
    SELF.Diff_addr_type := le.addr_type <> ri.addr_type;
    SELF.Val := (SALT39.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_rid,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_did_score,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_vtid,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_source,1,0)+ IF( SELF.Diff_file_id,1,0)+ IF( SELF.Diff_vendor_id,1,0)+ IF( SELF.Diff_source_state,1,0)+ IF( SELF.Diff_source_code,1,0)+ IF( SELF.Diff_file_acquired_date,1,0)+ IF( SELF.Diff_use_code,1,0)+ IF( SELF.Diff_prefix_title,1,0)+ IF( SELF.Diff_last_name,1,0)+ IF( SELF.Diff_first_name,1,0)+ IF( SELF.Diff_middle_name,1,0)+ IF( SELF.Diff_maiden_prior,1,0)+ IF( SELF.Diff_clean_maiden_pri,1,0)+ IF( SELF.Diff_name_suffix_in,1,0)+ IF( SELF.Diff_voterfiller,1,0)+ IF( SELF.Diff_source_voterid,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_agecat,1,0)+ IF( SELF.Diff_agecat_exp,1,0)+ IF( SELF.Diff_headhousehold,1,0)+ IF( SELF.Diff_place_of_birth,1,0)+ IF( SELF.Diff_occupation,1,0)+ IF( SELF.Diff_maiden_name,1,0)+ IF( SELF.Diff_motorvoterid,1,0)+ IF( SELF.Diff_regsource,1,0)+ IF( SELF.Diff_regdate,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_race_exp,1,0)+ IF( SELF.Diff_gender,1,0)+ IF( SELF.Diff_political_party,1,0)+ IF( SELF.Diff_politicalparty_exp,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_work_phone,1,0)+ IF( SELF.Diff_other_phone,1,0)+ IF( SELF.Diff_active_status,1,0)+ IF( SELF.Diff_active_status_exp,1,0)+ IF( SELF.Diff_gendersurnamguess,1,0)+ IF( SELF.Diff_active_other,1,0)+ IF( SELF.Diff_voter_status,1,0)+ IF( SELF.Diff_voter_status_exp,1,0)+ IF( SELF.Diff_res_addr1,1,0)+ IF( SELF.Diff_res_addr2,1,0)+ IF( SELF.Diff_res_city,1,0)+ IF( SELF.Diff_res_state,1,0)+ IF( SELF.Diff_res_zip,1,0)+ IF( SELF.Diff_res_county,1,0)+ IF( SELF.Diff_mail_addr1,1,0)+ IF( SELF.Diff_mail_addr2,1,0)+ IF( SELF.Diff_mail_city,1,0)+ IF( SELF.Diff_mail_state,1,0)+ IF( SELF.Diff_mail_zip,1,0)+ IF( SELF.Diff_mail_county,1,0)+ IF( SELF.Diff_addr_filler1,1,0)+ IF( SELF.Diff_addr_filler2,1,0)+ IF( SELF.Diff_city_filler,1,0)+ IF( SELF.Diff_state_filler,1,0)+ IF( SELF.Diff_zip_filler,1,0)+ IF( SELF.Diff_timezonetbl,1,0)+ IF( SELF.Diff_towncode,1,0)+ IF( SELF.Diff_distcode,1,0)+ IF( SELF.Diff_countycode,1,0)+ IF( SELF.Diff_schoolcode,1,0)+ IF( SELF.Diff_cityinout,1,0)+ IF( SELF.Diff_spec_dist1,1,0)+ IF( SELF.Diff_spec_dist2,1,0)+ IF( SELF.Diff_precinct1,1,0)+ IF( SELF.Diff_precinct2,1,0)+ IF( SELF.Diff_precinct3,1,0)+ IF( SELF.Diff_villageprecinct,1,0)+ IF( SELF.Diff_schoolprecinct,1,0)+ IF( SELF.Diff_ward,1,0)+ IF( SELF.Diff_precinct_citytown,1,0)+ IF( SELF.Diff_ancsmdindc,1,0)+ IF( SELF.Diff_citycouncildist,1,0)+ IF( SELF.Diff_countycommdist,1,0)+ IF( SELF.Diff_statehouse,1,0)+ IF( SELF.Diff_statesenate,1,0)+ IF( SELF.Diff_ushouse,1,0)+ IF( SELF.Diff_elemschooldist,1,0)+ IF( SELF.Diff_schooldist,1,0)+ IF( SELF.Diff_schoolfiller,1,0)+ IF( SELF.Diff_commcolldist,1,0)+ IF( SELF.Diff_dist_filler,1,0)+ IF( SELF.Diff_municipal,1,0)+ IF( SELF.Diff_villagedist,1,0)+ IF( SELF.Diff_policejury,1,0)+ IF( SELF.Diff_policedist,1,0)+ IF( SELF.Diff_publicservcomm,1,0)+ IF( SELF.Diff_rescue,1,0)+ IF( SELF.Diff_fire,1,0)+ IF( SELF.Diff_sanitary,1,0)+ IF( SELF.Diff_sewerdist,1,0)+ IF( SELF.Diff_waterdist,1,0)+ IF( SELF.Diff_mosquitodist,1,0)+ IF( SELF.Diff_taxdist,1,0)+ IF( SELF.Diff_supremecourt,1,0)+ IF( SELF.Diff_justiceofpeace,1,0)+ IF( SELF.Diff_judicialdist,1,0)+ IF( SELF.Diff_superiorctdist,1,0)+ IF( SELF.Diff_appealsct,1,0)+ IF( SELF.Diff_courtfiller,1,0)+ IF( SELF.Diff_cassaddrtyptbl,1,0)+ IF( SELF.Diff_cassdelivpointcd,1,0)+ IF( SELF.Diff_casscarrierrtetbl,1,0)+ IF( SELF.Diff_blkgrpenumdist,1,0)+ IF( SELF.Diff_congressionaldist,1,0)+ IF( SELF.Diff_lattitude,1,0)+ IF( SELF.Diff_countyfips,1,0)+ IF( SELF.Diff_censustract,1,0)+ IF( SELF.Diff_fipsstcountycd,1,0)+ IF( SELF.Diff_longitude,1,0)+ IF( SELF.Diff_contributorparty,1,0)+ IF( SELF.Diff_recipientparty,1,0)+ IF( SELF.Diff_dateofcontr,1,0)+ IF( SELF.Diff_dollaramt,1,0)+ IF( SELF.Diff_officecontto,1,0)+ IF( SELF.Diff_cumuldollaramt,1,0)+ IF( SELF.Diff_contfiller1,1,0)+ IF( SELF.Diff_contfiller2,1,0)+ IF( SELF.Diff_conttype,1,0)+ IF( SELF.Diff_contfiller4,1,0)+ IF( SELF.Diff_lastdatevote,1,0)+ IF( SELF.Diff_miscvotehist,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_name_score,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_mail_prim_range,1,0)+ IF( SELF.Diff_mail_predir,1,0)+ IF( SELF.Diff_mail_prim_name,1,0)+ IF( SELF.Diff_mail_addr_suffix,1,0)+ IF( SELF.Diff_mail_postdir,1,0)+ IF( SELF.Diff_mail_unit_desig,1,0)+ IF( SELF.Diff_mail_sec_range,1,0)+ IF( SELF.Diff_mail_p_city_name,1,0)+ IF( SELF.Diff_mail_v_city_name,1,0)+ IF( SELF.Diff_mail_st,1,0)+ IF( SELF.Diff_mail_ace_zip,1,0)+ IF( SELF.Diff_mail_zip4,1,0)+ IF( SELF.Diff_mail_cart,1,0)+ IF( SELF.Diff_mail_cr_sort_sz,1,0)+ IF( SELF.Diff_mail_lot,1,0)+ IF( SELF.Diff_mail_lot_order,1,0)+ IF( SELF.Diff_mail_dpbc,1,0)+ IF( SELF.Diff_mail_chk_digit,1,0)+ IF( SELF.Diff_mail_rec_type,1,0)+ IF( SELF.Diff_mail_ace_fips_st,1,0)+ IF( SELF.Diff_mail_fips_county,1,0)+ IF( SELF.Diff_mail_geo_lat,1,0)+ IF( SELF.Diff_mail_geo_long,1,0)+ IF( SELF.Diff_mail_msa,1,0)+ IF( SELF.Diff_mail_geo_blk,1,0)+ IF( SELF.Diff_mail_geo_match,1,0)+ IF( SELF.Diff_mail_err_stat,1,0)+ IF( SELF.Diff_idtypes,1,0)+ IF( SELF.Diff_precinct,1,0)+ IF( SELF.Diff_ward1,1,0)+ IF( SELF.Diff_idcode,1,0)+ IF( SELF.Diff_precinctparttextdesig,1,0)+ IF( SELF.Diff_precinctparttextname,1,0)+ IF( SELF.Diff_precincttextdesig,1,0)+ IF( SELF.Diff_marriedappend,1,0)+ IF( SELF.Diff_supervisordistrict,1,0)+ IF( SELF.Diff_district,1,0)+ IF( SELF.Diff_ward2,1,0)+ IF( SELF.Diff_citycountycouncil,1,0)+ IF( SELF.Diff_countyprecinct,1,0)+ IF( SELF.Diff_countycommis,1,0)+ IF( SELF.Diff_schoolboard,1,0)+ IF( SELF.Diff_ward3,1,0)+ IF( SELF.Diff_towncitycouncil1,1,0)+ IF( SELF.Diff_towncitycouncil2,1,0)+ IF( SELF.Diff_regents,1,0)+ IF( SELF.Diff_watershed,1,0)+ IF( SELF.Diff_education,1,0)+ IF( SELF.Diff_policeconstable,1,0)+ IF( SELF.Diff_freeholder,1,0)+ IF( SELF.Diff_municourt,1,0)+ IF( SELF.Diff_changedate,1,0)+ IF( SELF.Diff_name_type,1,0)+ IF( SELF.Diff_addr_type,1,0);
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
    Count_Diff_rid := COUNT(GROUP,%Closest%.Diff_rid);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_did_score := COUNT(GROUP,%Closest%.Diff_did_score);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_vtid := COUNT(GROUP,%Closest%.Diff_vtid);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_source := COUNT(GROUP,%Closest%.Diff_source);
    Count_Diff_file_id := COUNT(GROUP,%Closest%.Diff_file_id);
    Count_Diff_vendor_id := COUNT(GROUP,%Closest%.Diff_vendor_id);
    Count_Diff_source_state := COUNT(GROUP,%Closest%.Diff_source_state);
    Count_Diff_source_code := COUNT(GROUP,%Closest%.Diff_source_code);
    Count_Diff_file_acquired_date := COUNT(GROUP,%Closest%.Diff_file_acquired_date);
    Count_Diff_use_code := COUNT(GROUP,%Closest%.Diff_use_code);
    Count_Diff_prefix_title := COUNT(GROUP,%Closest%.Diff_prefix_title);
    Count_Diff_last_name := COUNT(GROUP,%Closest%.Diff_last_name);
    Count_Diff_first_name := COUNT(GROUP,%Closest%.Diff_first_name);
    Count_Diff_middle_name := COUNT(GROUP,%Closest%.Diff_middle_name);
    Count_Diff_maiden_prior := COUNT(GROUP,%Closest%.Diff_maiden_prior);
    Count_Diff_clean_maiden_pri := COUNT(GROUP,%Closest%.Diff_clean_maiden_pri);
    Count_Diff_name_suffix_in := COUNT(GROUP,%Closest%.Diff_name_suffix_in);
    Count_Diff_voterfiller := COUNT(GROUP,%Closest%.Diff_voterfiller);
    Count_Diff_source_voterid := COUNT(GROUP,%Closest%.Diff_source_voterid);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_agecat := COUNT(GROUP,%Closest%.Diff_agecat);
    Count_Diff_agecat_exp := COUNT(GROUP,%Closest%.Diff_agecat_exp);
    Count_Diff_headhousehold := COUNT(GROUP,%Closest%.Diff_headhousehold);
    Count_Diff_place_of_birth := COUNT(GROUP,%Closest%.Diff_place_of_birth);
    Count_Diff_occupation := COUNT(GROUP,%Closest%.Diff_occupation);
    Count_Diff_maiden_name := COUNT(GROUP,%Closest%.Diff_maiden_name);
    Count_Diff_motorvoterid := COUNT(GROUP,%Closest%.Diff_motorvoterid);
    Count_Diff_regsource := COUNT(GROUP,%Closest%.Diff_regsource);
    Count_Diff_regdate := COUNT(GROUP,%Closest%.Diff_regdate);
    Count_Diff_race := COUNT(GROUP,%Closest%.Diff_race);
    Count_Diff_race_exp := COUNT(GROUP,%Closest%.Diff_race_exp);
    Count_Diff_gender := COUNT(GROUP,%Closest%.Diff_gender);
    Count_Diff_political_party := COUNT(GROUP,%Closest%.Diff_political_party);
    Count_Diff_politicalparty_exp := COUNT(GROUP,%Closest%.Diff_politicalparty_exp);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_work_phone := COUNT(GROUP,%Closest%.Diff_work_phone);
    Count_Diff_other_phone := COUNT(GROUP,%Closest%.Diff_other_phone);
    Count_Diff_active_status := COUNT(GROUP,%Closest%.Diff_active_status);
    Count_Diff_active_status_exp := COUNT(GROUP,%Closest%.Diff_active_status_exp);
    Count_Diff_gendersurnamguess := COUNT(GROUP,%Closest%.Diff_gendersurnamguess);
    Count_Diff_active_other := COUNT(GROUP,%Closest%.Diff_active_other);
    Count_Diff_voter_status := COUNT(GROUP,%Closest%.Diff_voter_status);
    Count_Diff_voter_status_exp := COUNT(GROUP,%Closest%.Diff_voter_status_exp);
    Count_Diff_res_addr1 := COUNT(GROUP,%Closest%.Diff_res_addr1);
    Count_Diff_res_addr2 := COUNT(GROUP,%Closest%.Diff_res_addr2);
    Count_Diff_res_city := COUNT(GROUP,%Closest%.Diff_res_city);
    Count_Diff_res_state := COUNT(GROUP,%Closest%.Diff_res_state);
    Count_Diff_res_zip := COUNT(GROUP,%Closest%.Diff_res_zip);
    Count_Diff_res_county := COUNT(GROUP,%Closest%.Diff_res_county);
    Count_Diff_mail_addr1 := COUNT(GROUP,%Closest%.Diff_mail_addr1);
    Count_Diff_mail_addr2 := COUNT(GROUP,%Closest%.Diff_mail_addr2);
    Count_Diff_mail_city := COUNT(GROUP,%Closest%.Diff_mail_city);
    Count_Diff_mail_state := COUNT(GROUP,%Closest%.Diff_mail_state);
    Count_Diff_mail_zip := COUNT(GROUP,%Closest%.Diff_mail_zip);
    Count_Diff_mail_county := COUNT(GROUP,%Closest%.Diff_mail_county);
    Count_Diff_addr_filler1 := COUNT(GROUP,%Closest%.Diff_addr_filler1);
    Count_Diff_addr_filler2 := COUNT(GROUP,%Closest%.Diff_addr_filler2);
    Count_Diff_city_filler := COUNT(GROUP,%Closest%.Diff_city_filler);
    Count_Diff_state_filler := COUNT(GROUP,%Closest%.Diff_state_filler);
    Count_Diff_zip_filler := COUNT(GROUP,%Closest%.Diff_zip_filler);
    Count_Diff_timezonetbl := COUNT(GROUP,%Closest%.Diff_timezonetbl);
    Count_Diff_towncode := COUNT(GROUP,%Closest%.Diff_towncode);
    Count_Diff_distcode := COUNT(GROUP,%Closest%.Diff_distcode);
    Count_Diff_countycode := COUNT(GROUP,%Closest%.Diff_countycode);
    Count_Diff_schoolcode := COUNT(GROUP,%Closest%.Diff_schoolcode);
    Count_Diff_cityinout := COUNT(GROUP,%Closest%.Diff_cityinout);
    Count_Diff_spec_dist1 := COUNT(GROUP,%Closest%.Diff_spec_dist1);
    Count_Diff_spec_dist2 := COUNT(GROUP,%Closest%.Diff_spec_dist2);
    Count_Diff_precinct1 := COUNT(GROUP,%Closest%.Diff_precinct1);
    Count_Diff_precinct2 := COUNT(GROUP,%Closest%.Diff_precinct2);
    Count_Diff_precinct3 := COUNT(GROUP,%Closest%.Diff_precinct3);
    Count_Diff_villageprecinct := COUNT(GROUP,%Closest%.Diff_villageprecinct);
    Count_Diff_schoolprecinct := COUNT(GROUP,%Closest%.Diff_schoolprecinct);
    Count_Diff_ward := COUNT(GROUP,%Closest%.Diff_ward);
    Count_Diff_precinct_citytown := COUNT(GROUP,%Closest%.Diff_precinct_citytown);
    Count_Diff_ancsmdindc := COUNT(GROUP,%Closest%.Diff_ancsmdindc);
    Count_Diff_citycouncildist := COUNT(GROUP,%Closest%.Diff_citycouncildist);
    Count_Diff_countycommdist := COUNT(GROUP,%Closest%.Diff_countycommdist);
    Count_Diff_statehouse := COUNT(GROUP,%Closest%.Diff_statehouse);
    Count_Diff_statesenate := COUNT(GROUP,%Closest%.Diff_statesenate);
    Count_Diff_ushouse := COUNT(GROUP,%Closest%.Diff_ushouse);
    Count_Diff_elemschooldist := COUNT(GROUP,%Closest%.Diff_elemschooldist);
    Count_Diff_schooldist := COUNT(GROUP,%Closest%.Diff_schooldist);
    Count_Diff_schoolfiller := COUNT(GROUP,%Closest%.Diff_schoolfiller);
    Count_Diff_commcolldist := COUNT(GROUP,%Closest%.Diff_commcolldist);
    Count_Diff_dist_filler := COUNT(GROUP,%Closest%.Diff_dist_filler);
    Count_Diff_municipal := COUNT(GROUP,%Closest%.Diff_municipal);
    Count_Diff_villagedist := COUNT(GROUP,%Closest%.Diff_villagedist);
    Count_Diff_policejury := COUNT(GROUP,%Closest%.Diff_policejury);
    Count_Diff_policedist := COUNT(GROUP,%Closest%.Diff_policedist);
    Count_Diff_publicservcomm := COUNT(GROUP,%Closest%.Diff_publicservcomm);
    Count_Diff_rescue := COUNT(GROUP,%Closest%.Diff_rescue);
    Count_Diff_fire := COUNT(GROUP,%Closest%.Diff_fire);
    Count_Diff_sanitary := COUNT(GROUP,%Closest%.Diff_sanitary);
    Count_Diff_sewerdist := COUNT(GROUP,%Closest%.Diff_sewerdist);
    Count_Diff_waterdist := COUNT(GROUP,%Closest%.Diff_waterdist);
    Count_Diff_mosquitodist := COUNT(GROUP,%Closest%.Diff_mosquitodist);
    Count_Diff_taxdist := COUNT(GROUP,%Closest%.Diff_taxdist);
    Count_Diff_supremecourt := COUNT(GROUP,%Closest%.Diff_supremecourt);
    Count_Diff_justiceofpeace := COUNT(GROUP,%Closest%.Diff_justiceofpeace);
    Count_Diff_judicialdist := COUNT(GROUP,%Closest%.Diff_judicialdist);
    Count_Diff_superiorctdist := COUNT(GROUP,%Closest%.Diff_superiorctdist);
    Count_Diff_appealsct := COUNT(GROUP,%Closest%.Diff_appealsct);
    Count_Diff_courtfiller := COUNT(GROUP,%Closest%.Diff_courtfiller);
    Count_Diff_cassaddrtyptbl := COUNT(GROUP,%Closest%.Diff_cassaddrtyptbl);
    Count_Diff_cassdelivpointcd := COUNT(GROUP,%Closest%.Diff_cassdelivpointcd);
    Count_Diff_casscarrierrtetbl := COUNT(GROUP,%Closest%.Diff_casscarrierrtetbl);
    Count_Diff_blkgrpenumdist := COUNT(GROUP,%Closest%.Diff_blkgrpenumdist);
    Count_Diff_congressionaldist := COUNT(GROUP,%Closest%.Diff_congressionaldist);
    Count_Diff_lattitude := COUNT(GROUP,%Closest%.Diff_lattitude);
    Count_Diff_countyfips := COUNT(GROUP,%Closest%.Diff_countyfips);
    Count_Diff_censustract := COUNT(GROUP,%Closest%.Diff_censustract);
    Count_Diff_fipsstcountycd := COUNT(GROUP,%Closest%.Diff_fipsstcountycd);
    Count_Diff_longitude := COUNT(GROUP,%Closest%.Diff_longitude);
    Count_Diff_contributorparty := COUNT(GROUP,%Closest%.Diff_contributorparty);
    Count_Diff_recipientparty := COUNT(GROUP,%Closest%.Diff_recipientparty);
    Count_Diff_dateofcontr := COUNT(GROUP,%Closest%.Diff_dateofcontr);
    Count_Diff_dollaramt := COUNT(GROUP,%Closest%.Diff_dollaramt);
    Count_Diff_officecontto := COUNT(GROUP,%Closest%.Diff_officecontto);
    Count_Diff_cumuldollaramt := COUNT(GROUP,%Closest%.Diff_cumuldollaramt);
    Count_Diff_contfiller1 := COUNT(GROUP,%Closest%.Diff_contfiller1);
    Count_Diff_contfiller2 := COUNT(GROUP,%Closest%.Diff_contfiller2);
    Count_Diff_conttype := COUNT(GROUP,%Closest%.Diff_conttype);
    Count_Diff_contfiller4 := COUNT(GROUP,%Closest%.Diff_contfiller4);
    Count_Diff_lastdatevote := COUNT(GROUP,%Closest%.Diff_lastdatevote);
    Count_Diff_miscvotehist := COUNT(GROUP,%Closest%.Diff_miscvotehist);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_name_score := COUNT(GROUP,%Closest%.Diff_name_score);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_mail_prim_range := COUNT(GROUP,%Closest%.Diff_mail_prim_range);
    Count_Diff_mail_predir := COUNT(GROUP,%Closest%.Diff_mail_predir);
    Count_Diff_mail_prim_name := COUNT(GROUP,%Closest%.Diff_mail_prim_name);
    Count_Diff_mail_addr_suffix := COUNT(GROUP,%Closest%.Diff_mail_addr_suffix);
    Count_Diff_mail_postdir := COUNT(GROUP,%Closest%.Diff_mail_postdir);
    Count_Diff_mail_unit_desig := COUNT(GROUP,%Closest%.Diff_mail_unit_desig);
    Count_Diff_mail_sec_range := COUNT(GROUP,%Closest%.Diff_mail_sec_range);
    Count_Diff_mail_p_city_name := COUNT(GROUP,%Closest%.Diff_mail_p_city_name);
    Count_Diff_mail_v_city_name := COUNT(GROUP,%Closest%.Diff_mail_v_city_name);
    Count_Diff_mail_st := COUNT(GROUP,%Closest%.Diff_mail_st);
    Count_Diff_mail_ace_zip := COUNT(GROUP,%Closest%.Diff_mail_ace_zip);
    Count_Diff_mail_zip4 := COUNT(GROUP,%Closest%.Diff_mail_zip4);
    Count_Diff_mail_cart := COUNT(GROUP,%Closest%.Diff_mail_cart);
    Count_Diff_mail_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_mail_cr_sort_sz);
    Count_Diff_mail_lot := COUNT(GROUP,%Closest%.Diff_mail_lot);
    Count_Diff_mail_lot_order := COUNT(GROUP,%Closest%.Diff_mail_lot_order);
    Count_Diff_mail_dpbc := COUNT(GROUP,%Closest%.Diff_mail_dpbc);
    Count_Diff_mail_chk_digit := COUNT(GROUP,%Closest%.Diff_mail_chk_digit);
    Count_Diff_mail_rec_type := COUNT(GROUP,%Closest%.Diff_mail_rec_type);
    Count_Diff_mail_ace_fips_st := COUNT(GROUP,%Closest%.Diff_mail_ace_fips_st);
    Count_Diff_mail_fips_county := COUNT(GROUP,%Closest%.Diff_mail_fips_county);
    Count_Diff_mail_geo_lat := COUNT(GROUP,%Closest%.Diff_mail_geo_lat);
    Count_Diff_mail_geo_long := COUNT(GROUP,%Closest%.Diff_mail_geo_long);
    Count_Diff_mail_msa := COUNT(GROUP,%Closest%.Diff_mail_msa);
    Count_Diff_mail_geo_blk := COUNT(GROUP,%Closest%.Diff_mail_geo_blk);
    Count_Diff_mail_geo_match := COUNT(GROUP,%Closest%.Diff_mail_geo_match);
    Count_Diff_mail_err_stat := COUNT(GROUP,%Closest%.Diff_mail_err_stat);
    Count_Diff_idtypes := COUNT(GROUP,%Closest%.Diff_idtypes);
    Count_Diff_precinct := COUNT(GROUP,%Closest%.Diff_precinct);
    Count_Diff_ward1 := COUNT(GROUP,%Closest%.Diff_ward1);
    Count_Diff_idcode := COUNT(GROUP,%Closest%.Diff_idcode);
    Count_Diff_precinctparttextdesig := COUNT(GROUP,%Closest%.Diff_precinctparttextdesig);
    Count_Diff_precinctparttextname := COUNT(GROUP,%Closest%.Diff_precinctparttextname);
    Count_Diff_precincttextdesig := COUNT(GROUP,%Closest%.Diff_precincttextdesig);
    Count_Diff_marriedappend := COUNT(GROUP,%Closest%.Diff_marriedappend);
    Count_Diff_supervisordistrict := COUNT(GROUP,%Closest%.Diff_supervisordistrict);
    Count_Diff_district := COUNT(GROUP,%Closest%.Diff_district);
    Count_Diff_ward2 := COUNT(GROUP,%Closest%.Diff_ward2);
    Count_Diff_citycountycouncil := COUNT(GROUP,%Closest%.Diff_citycountycouncil);
    Count_Diff_countyprecinct := COUNT(GROUP,%Closest%.Diff_countyprecinct);
    Count_Diff_countycommis := COUNT(GROUP,%Closest%.Diff_countycommis);
    Count_Diff_schoolboard := COUNT(GROUP,%Closest%.Diff_schoolboard);
    Count_Diff_ward3 := COUNT(GROUP,%Closest%.Diff_ward3);
    Count_Diff_towncitycouncil1 := COUNT(GROUP,%Closest%.Diff_towncitycouncil1);
    Count_Diff_towncitycouncil2 := COUNT(GROUP,%Closest%.Diff_towncitycouncil2);
    Count_Diff_regents := COUNT(GROUP,%Closest%.Diff_regents);
    Count_Diff_watershed := COUNT(GROUP,%Closest%.Diff_watershed);
    Count_Diff_education := COUNT(GROUP,%Closest%.Diff_education);
    Count_Diff_policeconstable := COUNT(GROUP,%Closest%.Diff_policeconstable);
    Count_Diff_freeholder := COUNT(GROUP,%Closest%.Diff_freeholder);
    Count_Diff_municourt := COUNT(GROUP,%Closest%.Diff_municourt);
    Count_Diff_changedate := COUNT(GROUP,%Closest%.Diff_changedate);
    Count_Diff_name_type := COUNT(GROUP,%Closest%.Diff_name_type);
    Count_Diff_addr_type := COUNT(GROUP,%Closest%.Diff_addr_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
