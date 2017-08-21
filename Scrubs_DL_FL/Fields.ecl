IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_DL_FL; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_specials','invalid_numeric','invalid_alphanum_blank','invalid_boolean_yes_no','invalid_empty','invalid_wordbag','invalid_process_date','invalid_08date','invalid_8pastdate','invalid_issuance','invalid_state','invalid_zip','invalid_race','invalid_sex_flag','invalid_license_type','invalid_attention_flag','invalid_dod','invalid_restrictions','invalid_lic_endorsement','invalid_dl_number','invalid_age','invalid_new_dl_number','invalid_height','invalid_oos_previous_st','invalid_name');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_specials' => 3,'invalid_numeric' => 4,'invalid_alphanum_blank' => 5,'invalid_boolean_yes_no' => 6,'invalid_empty' => 7,'invalid_wordbag' => 8,'invalid_process_date' => 9,'invalid_08date' => 10,'invalid_8pastdate' => 11,'invalid_issuance' => 12,'invalid_state' => 13,'invalid_zip' => 14,'invalid_race' => 15,'invalid_sex_flag' => 16,'invalid_license_type' => 17,'invalid_attention_flag' => 18,'invalid_dod' => 19,'invalid_restrictions' => 20,'invalid_lic_endorsement' => 21,'invalid_dl_number' => 22,'invalid_age' => 23,'invalid_new_dl_number' => 24,'invalid_height' => 25,'invalid_oos_previous_st' => 26,'invalid_name' => 27,0);
 
EXPORT MakeFT_invalid_mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_specials(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@-.,'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_specials(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@-.,'))));
EXPORT InValidMessageFT_invalid_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@-.,'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphanum_blank(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphanum_blank(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphanum_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yes_no(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' YN'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_boolean_yes_no(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' YN'))));
EXPORT InValidMessageFT_invalid_boolean_yes_no(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' YN'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wordbag(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()+-=^:;!?&$,`./#@*\'\\|_"%~'); // Only allow valid symbols
  s2 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s1,' <>{}[]()+-=^:;!?&$,`./#@*\'\\|_"%~',' ') ); // Insert spaces but avoid doubles
  RETURN  s2;
END;
EXPORT InValidFT_invalid_wordbag(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()+-=^:;!?&$,`./#@*\'\\|_"%~'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()+-=^:;!?&$,`./#@*\'\\|_"%~'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_process_date(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_process_date(SALT34.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_process_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_08date(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_08date(SALT34.StrType s) := WHICH(~Scrubs_DL_FL.Functions.fn_valid_date(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_08date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_FL.Functions.fn_valid_date'),SALT34.HygieneErrors.NotLength('0,8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT34.StrType s) := WHICH(~Scrubs_DL_FL.Functions.fn_valid_past_date(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_FL.Functions.fn_valid_past_date'),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_issuance(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123459'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_issuance(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123459'))));
EXPORT InValidMessageFT_invalid_issuance(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123459'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alphanum_blank(s1);
END;
EXPORT InValidFT_invalid_state(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.NotLength('0,2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('0,5'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_race(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABHIOW '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_race(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABHIOW '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_race(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABHIOW '),SALT34.HygieneErrors.NotLength('0,1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sex_flag(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'FM '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_sex_flag(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'FM '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_sex_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('FM '),SALT34.HygieneErrors.NotLength('0,1'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_license_type(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_license_type(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['ID','LEARNER','CLASS A','CLASS B','CLASS C','CLASS E','']);
EXPORT InValidMessageFT_invalid_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('ID|LEARNER|CLASS A|CLASS B|CLASS C|CLASS E|'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_attention_flag(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_attention_flag(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['ORGAN DONOR','FLORIDA ONLY','']);
EXPORT InValidMessageFT_invalid_attention_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('ORGAN DONOR|FLORIDA ONLY|'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dod(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_dod(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_dod(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0'),SALT34.HygieneErrors.NotLength('0,8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_restrictions(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_restrictions(SALT34.StrType s) := WHICH(~Scrubs_DL_FL.Functions.fn_check_restriction_codes(s)>0);
EXPORT InValidMessageFT_invalid_restrictions(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_FL.Functions.fn_check_restriction_codes'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lic_endorsement(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lic_endorsement(SALT34.StrType s) := WHICH(~Scrubs_DL_FL.Functions.fn_check_endorsement_codes(s)>0);
EXPORT InValidMessageFT_invalid_lic_endorsement(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_FL.Functions.fn_check_endorsement_codes'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dl_number(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dl_number(SALT34.StrType s) := WHICH(~Scrubs_DL_FL.Functions.fn_check_dl_number(s)>0,~(LENGTH(TRIM(s)) = 13));
EXPORT InValidMessageFT_invalid_dl_number(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_FL.Functions.fn_check_dl_number'),SALT34.HygieneErrors.NotLength('13'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_age(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_age(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_age(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.NotLength('0,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_new_dl_number(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_new_dl_number(SALT34.StrType s) := WHICH(~Scrubs_DL_FL.Functions.fn_check_dl_number(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 13));
EXPORT InValidMessageFT_invalid_new_dl_number(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_FL.Functions.fn_check_dl_number'),SALT34.HygieneErrors.NotLength('0,13'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_height(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_height(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 3));
EXPORT InValidMessageFT_invalid_height(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('0,3'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_oos_previous_st(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@-.,'); // Only allow valid symbols
  RETURN  MakeFT_invalid_specials(s1);
END;
EXPORT InValidFT_invalid_oos_previous_st(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@-.,'))),~(LENGTH(TRIM(s)) >= 0 AND LENGTH(TRIM(s)) <= 2));
EXPORT InValidMessageFT_invalid_oos_previous_st(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ@-.,'),SALT34.HygieneErrors.NotLength('0..2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name(SALT34.StrType s,SALT34.StrType mname,SALT34.StrType lname) := WHICH(~Scrubs_DL_FL.Functions.fn_valid_name(s,mname,lname)>0);
EXPORT InValidMessageFT_invalid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_FL.Functions.fn_valid_name'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','issuance','address_change','name_change','dob_change','sex_change','name','addr1','city','state','zip','dob','race','sex_flag','license_type','attention_flag','dod','restrictions','orig_expiration_date','lic_issue_date','lic_endorsement','dl_number','ssn','age','new_dl_number','personal_info_flag','dl_orig_issue_date','height','oos_previous_dl_number','oos_previous_st','filler2','title','fname','mname','lname','name_suffix','cleaning_score','addr_fix_flag','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'process_date' => 0,'issuance' => 1,'address_change' => 2,'name_change' => 3,'dob_change' => 4,'sex_change' => 5,'name' => 6,'addr1' => 7,'city' => 8,'state' => 9,'zip' => 10,'dob' => 11,'race' => 12,'sex_flag' => 13,'license_type' => 14,'attention_flag' => 15,'dod' => 16,'restrictions' => 17,'orig_expiration_date' => 18,'lic_issue_date' => 19,'lic_endorsement' => 20,'dl_number' => 21,'ssn' => 22,'age' => 23,'new_dl_number' => 24,'personal_info_flag' => 25,'dl_orig_issue_date' => 26,'height' => 27,'oos_previous_dl_number' => 28,'oos_previous_st' => 29,'filler2' => 30,'title' => 31,'fname' => 32,'mname' => 33,'lname' => 34,'name_suffix' => 35,'cleaning_score' => 36,'addr_fix_flag' => 37,'prim_range' => 38,'predir' => 39,'prim_name' => 40,'suffix' => 41,'postdir' => 42,'unit_desig' => 43,'sec_range' => 44,'p_city_name' => 45,'v_city_name' => 46,'st' => 47,'zip5' => 48,'zip4' => 49,'cart' => 50,'cr_sort_sz' => 51,'lot' => 52,'lot_order' => 53,'dpbc' => 54,'chk_digit' => 55,'rec_type' => 56,'ace_fips_st' => 57,'county' => 58,'geo_lat' => 59,'geo_long' => 60,'msa' => 61,'geo_blk' => 62,'geo_match' => 63,'err_stat' => 64,0);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT34.StrType s0) := MakeFT_invalid_process_date(s0);
EXPORT InValid_process_date(SALT34.StrType s) := InValidFT_invalid_process_date(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_process_date(wh);
 
EXPORT Make_issuance(SALT34.StrType s0) := MakeFT_invalid_issuance(s0);
EXPORT InValid_issuance(SALT34.StrType s) := InValidFT_invalid_issuance(s);
EXPORT InValidMessage_issuance(UNSIGNED1 wh) := InValidMessageFT_invalid_issuance(wh);
 
EXPORT Make_address_change(SALT34.StrType s0) := MakeFT_invalid_boolean_yes_no(s0);
EXPORT InValid_address_change(SALT34.StrType s) := InValidFT_invalid_boolean_yes_no(s);
EXPORT InValidMessage_address_change(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yes_no(wh);
 
EXPORT Make_name_change(SALT34.StrType s0) := MakeFT_invalid_boolean_yes_no(s0);
EXPORT InValid_name_change(SALT34.StrType s) := InValidFT_invalid_boolean_yes_no(s);
EXPORT InValidMessage_name_change(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yes_no(wh);
 
EXPORT Make_dob_change(SALT34.StrType s0) := MakeFT_invalid_boolean_yes_no(s0);
EXPORT InValid_dob_change(SALT34.StrType s) := InValidFT_invalid_boolean_yes_no(s);
EXPORT InValidMessage_dob_change(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yes_no(wh);
 
EXPORT Make_sex_change(SALT34.StrType s0) := MakeFT_invalid_boolean_yes_no(s0);
EXPORT InValid_sex_change(SALT34.StrType s) := InValidFT_invalid_boolean_yes_no(s);
EXPORT InValidMessage_sex_change(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yes_no(wh);
 
EXPORT Make_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr1(SALT34.StrType s0) := s0;
EXPORT InValid_addr1(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_addr1(UNSIGNED1 wh) := '';
 
EXPORT Make_city(SALT34.StrType s0) := MakeFT_invalid_specials(s0);
EXPORT InValid_city(SALT34.StrType s) := InValidFT_invalid_specials(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_specials(wh);
 
EXPORT Make_state(SALT34.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT34.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT34.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT34.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_dob(SALT34.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_dob(SALT34.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_race(SALT34.StrType s0) := MakeFT_invalid_race(s0);
EXPORT InValid_race(SALT34.StrType s) := InValidFT_invalid_race(s);
EXPORT InValidMessage_race(UNSIGNED1 wh) := InValidMessageFT_invalid_race(wh);
 
EXPORT Make_sex_flag(SALT34.StrType s0) := MakeFT_invalid_sex_flag(s0);
EXPORT InValid_sex_flag(SALT34.StrType s) := InValidFT_invalid_sex_flag(s);
EXPORT InValidMessage_sex_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_sex_flag(wh);
 
EXPORT Make_license_type(SALT34.StrType s0) := MakeFT_invalid_license_type(s0);
EXPORT InValid_license_type(SALT34.StrType s) := InValidFT_invalid_license_type(s);
EXPORT InValidMessage_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_license_type(wh);
 
EXPORT Make_attention_flag(SALT34.StrType s0) := MakeFT_invalid_attention_flag(s0);
EXPORT InValid_attention_flag(SALT34.StrType s) := InValidFT_invalid_attention_flag(s);
EXPORT InValidMessage_attention_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_attention_flag(wh);
 
EXPORT Make_dod(SALT34.StrType s0) := MakeFT_invalid_dod(s0);
EXPORT InValid_dod(SALT34.StrType s) := InValidFT_invalid_dod(s);
EXPORT InValidMessage_dod(UNSIGNED1 wh) := InValidMessageFT_invalid_dod(wh);
 
EXPORT Make_restrictions(SALT34.StrType s0) := MakeFT_invalid_restrictions(s0);
EXPORT InValid_restrictions(SALT34.StrType s) := InValidFT_invalid_restrictions(s);
EXPORT InValidMessage_restrictions(UNSIGNED1 wh) := InValidMessageFT_invalid_restrictions(wh);
 
EXPORT Make_orig_expiration_date(SALT34.StrType s0) := MakeFT_invalid_08date(s0);
EXPORT InValid_orig_expiration_date(SALT34.StrType s) := InValidFT_invalid_08date(s);
EXPORT InValidMessage_orig_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_08date(wh);
 
EXPORT Make_lic_issue_date(SALT34.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_lic_issue_date(SALT34.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_lic_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_lic_endorsement(SALT34.StrType s0) := MakeFT_invalid_lic_endorsement(s0);
EXPORT InValid_lic_endorsement(SALT34.StrType s) := InValidFT_invalid_lic_endorsement(s);
EXPORT InValidMessage_lic_endorsement(UNSIGNED1 wh) := InValidMessageFT_invalid_lic_endorsement(wh);
 
EXPORT Make_dl_number(SALT34.StrType s0) := MakeFT_invalid_dl_number(s0);
EXPORT InValid_dl_number(SALT34.StrType s) := InValidFT_invalid_dl_number(s);
EXPORT InValidMessage_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_dl_number(wh);
 
EXPORT Make_ssn(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_ssn(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_ssn(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_age(SALT34.StrType s0) := MakeFT_invalid_age(s0);
EXPORT InValid_age(SALT34.StrType s) := InValidFT_invalid_age(s);
EXPORT InValidMessage_age(UNSIGNED1 wh) := InValidMessageFT_invalid_age(wh);
 
EXPORT Make_new_dl_number(SALT34.StrType s0) := MakeFT_invalid_new_dl_number(s0);
EXPORT InValid_new_dl_number(SALT34.StrType s) := InValidFT_invalid_new_dl_number(s);
EXPORT InValidMessage_new_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_new_dl_number(wh);
 
EXPORT Make_personal_info_flag(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_personal_info_flag(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_personal_info_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_dl_orig_issue_date(SALT34.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_dl_orig_issue_date(SALT34.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_dl_orig_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_height(SALT34.StrType s0) := MakeFT_invalid_height(s0);
EXPORT InValid_height(SALT34.StrType s) := InValidFT_invalid_height(s);
EXPORT InValidMessage_height(UNSIGNED1 wh) := InValidMessageFT_invalid_height(wh);
 
EXPORT Make_oos_previous_dl_number(SALT34.StrType s0) := s0;
EXPORT InValid_oos_previous_dl_number(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_oos_previous_dl_number(UNSIGNED1 wh) := '';
 
EXPORT Make_oos_previous_st(SALT34.StrType s0) := MakeFT_invalid_oos_previous_st(s0);
EXPORT InValid_oos_previous_st(SALT34.StrType s) := InValidFT_invalid_oos_previous_st(s);
EXPORT InValidMessage_oos_previous_st(UNSIGNED1 wh) := InValidMessageFT_invalid_oos_previous_st(wh);
 
EXPORT Make_filler2(SALT34.StrType s0) := s0;
EXPORT InValid_filler2(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_filler2(UNSIGNED1 wh) := '';
 
EXPORT Make_title(SALT34.StrType s0) := s0;
EXPORT InValid_title(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_title(UNSIGNED1 wh) := '';
 
EXPORT Make_fname(SALT34.StrType s0) := MakeFT_invalid_name(s0);
EXPORT InValid_fname(SALT34.StrType s,SALT34.StrType mname,SALT34.StrType lname) := InValidFT_invalid_name(s,mname,lname);
EXPORT InValidMessage_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_name(wh);
 
EXPORT Make_mname(SALT34.StrType s0) := s0;
EXPORT InValid_mname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_mname(UNSIGNED1 wh) := '';
 
EXPORT Make_lname(SALT34.StrType s0) := s0;
EXPORT InValid_lname(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lname(UNSIGNED1 wh) := '';
 
EXPORT Make_name_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_name_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_cleaning_score(SALT34.StrType s0) := s0;
EXPORT InValid_cleaning_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cleaning_score(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_fix_flag(SALT34.StrType s0) := s0;
EXPORT InValid_addr_fix_flag(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_addr_fix_flag(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT34.StrType s0) := s0;
EXPORT InValid_prim_range(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT34.StrType s0) := s0;
EXPORT InValid_predir(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT34.StrType s0) := s0;
EXPORT InValid_prim_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT34.StrType s0) := s0;
EXPORT InValid_postdir(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT34.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT34.StrType s0) := s0;
EXPORT InValid_sec_range(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT34.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT34.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT34.StrType s0) := s0;
EXPORT InValid_st(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_zip5(SALT34.StrType s0) := s0;
EXPORT InValid_zip5(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_zip4(SALT34.StrType s0) := s0;
EXPORT InValid_zip4(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT34.StrType s0) := s0;
EXPORT InValid_cart(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT34.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT34.StrType s0) := s0;
EXPORT InValid_lot(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT34.StrType s0) := s0;
EXPORT InValid_lot_order(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc(SALT34.StrType s0) := s0;
EXPORT InValid_dpbc(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT34.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT34.StrType s0) := s0;
EXPORT InValid_rec_type(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT34.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT34.StrType s0) := s0;
EXPORT InValid_county(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT34.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT34.StrType s0) := s0;
EXPORT InValid_geo_long(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT34.StrType s0) := s0;
EXPORT InValid_msa(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT34.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT34.StrType s0) := s0;
EXPORT InValid_geo_match(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT34.StrType s0) := s0;
EXPORT InValid_err_stat(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_DL_FL;
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
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_issuance;
    BOOLEAN Diff_address_change;
    BOOLEAN Diff_name_change;
    BOOLEAN Diff_dob_change;
    BOOLEAN Diff_sex_change;
    BOOLEAN Diff_name;
    BOOLEAN Diff_addr1;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_dob;
    BOOLEAN Diff_race;
    BOOLEAN Diff_sex_flag;
    BOOLEAN Diff_license_type;
    BOOLEAN Diff_attention_flag;
    BOOLEAN Diff_dod;
    BOOLEAN Diff_restrictions;
    BOOLEAN Diff_orig_expiration_date;
    BOOLEAN Diff_lic_issue_date;
    BOOLEAN Diff_lic_endorsement;
    BOOLEAN Diff_dl_number;
    BOOLEAN Diff_ssn;
    BOOLEAN Diff_age;
    BOOLEAN Diff_new_dl_number;
    BOOLEAN Diff_personal_info_flag;
    BOOLEAN Diff_dl_orig_issue_date;
    BOOLEAN Diff_height;
    BOOLEAN Diff_oos_previous_dl_number;
    BOOLEAN Diff_oos_previous_st;
    BOOLEAN Diff_filler2;
    BOOLEAN Diff_title;
    BOOLEAN Diff_fname;
    BOOLEAN Diff_mname;
    BOOLEAN Diff_lname;
    BOOLEAN Diff_name_suffix;
    BOOLEAN Diff_cleaning_score;
    BOOLEAN Diff_addr_fix_flag;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip5;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dpbc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_ace_fips_st;
    BOOLEAN Diff_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_issuance := le.issuance <> ri.issuance;
    SELF.Diff_address_change := le.address_change <> ri.address_change;
    SELF.Diff_name_change := le.name_change <> ri.name_change;
    SELF.Diff_dob_change := le.dob_change <> ri.dob_change;
    SELF.Diff_sex_change := le.sex_change <> ri.sex_change;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_addr1 := le.addr1 <> ri.addr1;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_dob := le.dob <> ri.dob;
    SELF.Diff_race := le.race <> ri.race;
    SELF.Diff_sex_flag := le.sex_flag <> ri.sex_flag;
    SELF.Diff_license_type := le.license_type <> ri.license_type;
    SELF.Diff_attention_flag := le.attention_flag <> ri.attention_flag;
    SELF.Diff_dod := le.dod <> ri.dod;
    SELF.Diff_restrictions := le.restrictions <> ri.restrictions;
    SELF.Diff_orig_expiration_date := le.orig_expiration_date <> ri.orig_expiration_date;
    SELF.Diff_lic_issue_date := le.lic_issue_date <> ri.lic_issue_date;
    SELF.Diff_lic_endorsement := le.lic_endorsement <> ri.lic_endorsement;
    SELF.Diff_dl_number := le.dl_number <> ri.dl_number;
    SELF.Diff_ssn := le.ssn <> ri.ssn;
    SELF.Diff_age := le.age <> ri.age;
    SELF.Diff_new_dl_number := le.new_dl_number <> ri.new_dl_number;
    SELF.Diff_personal_info_flag := le.personal_info_flag <> ri.personal_info_flag;
    SELF.Diff_dl_orig_issue_date := le.dl_orig_issue_date <> ri.dl_orig_issue_date;
    SELF.Diff_height := le.height <> ri.height;
    SELF.Diff_oos_previous_dl_number := le.oos_previous_dl_number <> ri.oos_previous_dl_number;
    SELF.Diff_oos_previous_st := le.oos_previous_st <> ri.oos_previous_st;
    SELF.Diff_filler2 := le.filler2 <> ri.filler2;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_fname := le.fname <> ri.fname;
    SELF.Diff_mname := le.mname <> ri.mname;
    SELF.Diff_lname := le.lname <> ri.lname;
    SELF.Diff_name_suffix := le.name_suffix <> ri.name_suffix;
    SELF.Diff_cleaning_score := le.cleaning_score <> ri.cleaning_score;
    SELF.Diff_addr_fix_flag := le.addr_fix_flag <> ri.addr_fix_flag;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_suffix := le.suffix <> ri.suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip5 := le.zip5 <> ri.zip5;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dpbc := le.dpbc <> ri.dpbc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_ace_fips_st := le.ace_fips_st <> ri.ace_fips_st;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_issuance,1,0)+ IF( SELF.Diff_address_change,1,0)+ IF( SELF.Diff_name_change,1,0)+ IF( SELF.Diff_dob_change,1,0)+ IF( SELF.Diff_sex_change,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_addr1,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_dob,1,0)+ IF( SELF.Diff_race,1,0)+ IF( SELF.Diff_sex_flag,1,0)+ IF( SELF.Diff_license_type,1,0)+ IF( SELF.Diff_attention_flag,1,0)+ IF( SELF.Diff_dod,1,0)+ IF( SELF.Diff_restrictions,1,0)+ IF( SELF.Diff_orig_expiration_date,1,0)+ IF( SELF.Diff_lic_issue_date,1,0)+ IF( SELF.Diff_lic_endorsement,1,0)+ IF( SELF.Diff_dl_number,1,0)+ IF( SELF.Diff_ssn,1,0)+ IF( SELF.Diff_age,1,0)+ IF( SELF.Diff_new_dl_number,1,0)+ IF( SELF.Diff_personal_info_flag,1,0)+ IF( SELF.Diff_dl_orig_issue_date,1,0)+ IF( SELF.Diff_height,1,0)+ IF( SELF.Diff_oos_previous_dl_number,1,0)+ IF( SELF.Diff_oos_previous_st,1,0)+ IF( SELF.Diff_filler2,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_fname,1,0)+ IF( SELF.Diff_mname,1,0)+ IF( SELF.Diff_lname,1,0)+ IF( SELF.Diff_name_suffix,1,0)+ IF( SELF.Diff_cleaning_score,1,0)+ IF( SELF.Diff_addr_fix_flag,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip5,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_issuance := COUNT(GROUP,%Closest%.Diff_issuance);
    Count_Diff_address_change := COUNT(GROUP,%Closest%.Diff_address_change);
    Count_Diff_name_change := COUNT(GROUP,%Closest%.Diff_name_change);
    Count_Diff_dob_change := COUNT(GROUP,%Closest%.Diff_dob_change);
    Count_Diff_sex_change := COUNT(GROUP,%Closest%.Diff_sex_change);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_addr1 := COUNT(GROUP,%Closest%.Diff_addr1);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_dob := COUNT(GROUP,%Closest%.Diff_dob);
    Count_Diff_race := COUNT(GROUP,%Closest%.Diff_race);
    Count_Diff_sex_flag := COUNT(GROUP,%Closest%.Diff_sex_flag);
    Count_Diff_license_type := COUNT(GROUP,%Closest%.Diff_license_type);
    Count_Diff_attention_flag := COUNT(GROUP,%Closest%.Diff_attention_flag);
    Count_Diff_dod := COUNT(GROUP,%Closest%.Diff_dod);
    Count_Diff_restrictions := COUNT(GROUP,%Closest%.Diff_restrictions);
    Count_Diff_orig_expiration_date := COUNT(GROUP,%Closest%.Diff_orig_expiration_date);
    Count_Diff_lic_issue_date := COUNT(GROUP,%Closest%.Diff_lic_issue_date);
    Count_Diff_lic_endorsement := COUNT(GROUP,%Closest%.Diff_lic_endorsement);
    Count_Diff_dl_number := COUNT(GROUP,%Closest%.Diff_dl_number);
    Count_Diff_ssn := COUNT(GROUP,%Closest%.Diff_ssn);
    Count_Diff_age := COUNT(GROUP,%Closest%.Diff_age);
    Count_Diff_new_dl_number := COUNT(GROUP,%Closest%.Diff_new_dl_number);
    Count_Diff_personal_info_flag := COUNT(GROUP,%Closest%.Diff_personal_info_flag);
    Count_Diff_dl_orig_issue_date := COUNT(GROUP,%Closest%.Diff_dl_orig_issue_date);
    Count_Diff_height := COUNT(GROUP,%Closest%.Diff_height);
    Count_Diff_oos_previous_dl_number := COUNT(GROUP,%Closest%.Diff_oos_previous_dl_number);
    Count_Diff_oos_previous_st := COUNT(GROUP,%Closest%.Diff_oos_previous_st);
    Count_Diff_filler2 := COUNT(GROUP,%Closest%.Diff_filler2);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_fname := COUNT(GROUP,%Closest%.Diff_fname);
    Count_Diff_mname := COUNT(GROUP,%Closest%.Diff_mname);
    Count_Diff_lname := COUNT(GROUP,%Closest%.Diff_lname);
    Count_Diff_name_suffix := COUNT(GROUP,%Closest%.Diff_name_suffix);
    Count_Diff_cleaning_score := COUNT(GROUP,%Closest%.Diff_cleaning_score);
    Count_Diff_addr_fix_flag := COUNT(GROUP,%Closest%.Diff_addr_fix_flag);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_suffix := COUNT(GROUP,%Closest%.Diff_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip5 := COUNT(GROUP,%Closest%.Diff_zip5);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dpbc := COUNT(GROUP,%Closest%.Diff_dpbc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_ace_fips_st := COUNT(GROUP,%Closest%.Diff_ace_fips_st);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
