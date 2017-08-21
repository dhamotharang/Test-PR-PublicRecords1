IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_TN; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_num_specials','invalid_numeric','invalid_numeric_blank','invalid_alpha_num','invalid_empty','invalid_boolean_yn_empty','invalid_wordbag','invalid_8pastdate','invalid_8generaldate','invalid_orig_name','invalid_orig_state','invalid_orig_zip_code','invalid_orig_dl_number','invalid_orig_license_type','invalid_orig_sex','invalid_orig_height_ft','invalid_orig_weight','invalid_orig_eye_color','invalid_orig_hair_color','invalid_orig_restrictions','invalid_orig_endorsements','invalid_orig_race');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_num_specials' => 3,'invalid_numeric' => 4,'invalid_numeric_blank' => 5,'invalid_alpha_num' => 6,'invalid_empty' => 7,'invalid_boolean_yn_empty' => 8,'invalid_wordbag' => 9,'invalid_8pastdate' => 10,'invalid_8generaldate' => 11,'invalid_orig_name' => 12,'invalid_orig_state' => 13,'invalid_orig_zip_code' => 14,'invalid_orig_dl_number' => 15,'invalid_orig_license_type' => 16,'invalid_orig_sex' => 17,'invalid_orig_height_ft' => 18,'invalid_orig_weight' => 19,'invalid_orig_eye_color' => 20,'invalid_orig_hair_color' => 21,'invalid_orig_restrictions' => 22,'invalid_orig_endorsements' => 23,'invalid_orig_race' => 24,0);
 
EXPORT MakeFT_invalid_mandatory(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('1..'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num_specials(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\''); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num_specials(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\''))));
EXPORT InValidMessageFT_invalid_alpha_num_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ .,-\''),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789 '),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha_num(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('0'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yn_empty(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yn_empty(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean_yn_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('N|Y|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wordbag(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,`./#@*\'\\|_"%'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=:!+&,`./#@*\'\\|_"%',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_wordbag(SALT35.StrType s) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,`./#@*\'\\|_"%'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=:!+&,`./#@*\'\\|_"%'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8generaldate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8generaldate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_name(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_name(SALT35.StrType s,SALT35.StrType orig_first_name,SALT35.StrType orig_middle_name) := WHICH(~Scrubs_DL_TN.Functions.fn_valid_name(s,orig_first_name,orig_middle_name)>0);
EXPORT InValidMessageFT_invalid_orig_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_state(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_state(SALT35.StrType s) := WHICH(~Scrubs_DL_TN.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_verify_state'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_zip_code(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_orig_zip_code(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_orig_zip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('5'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_dl_number(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_orig_dl_number(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_orig_dl_number(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('9'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_license_type(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_license_type(SALT35.StrType s) := WHICH(~Scrubs_DL_TN.Functions.fn_check_license_type(s)>0);
EXPORT InValidMessageFT_invalid_orig_license_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_check_license_type'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_sex(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_sex(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['F','M','U','']);
EXPORT InValidMessageFT_invalid_orig_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('F|M|U|'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_height_ft(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_height_ft(SALT35.StrType s,SALT35.StrType orig_height_in) := WHICH(~Scrubs_DL_TN.Functions.fn_verify_height(s,orig_height_in)>0);
EXPORT InValidMessageFT_invalid_orig_height_ft(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_verify_height'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_weight(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_weight(SALT35.StrType s) := WHICH(~Scrubs_DL_TN.Functions.fn_verify_weight(s)>0);
EXPORT InValidMessageFT_invalid_orig_weight(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_verify_weight'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_eye_color(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_eye_color(SALT35.StrType s) := WHICH(~Scrubs_DL_TN.Functions.fn_check_eye_color(s)>0);
EXPORT InValidMessageFT_invalid_orig_eye_color(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_check_eye_color'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_hair_color(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_hair_color(SALT35.StrType s) := WHICH(~Scrubs_DL_TN.Functions.fn_check_hair_color(s)>0);
EXPORT InValidMessageFT_invalid_orig_hair_color(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_check_hair_color'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_restrictions(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num(s1);
END;
EXPORT InValidFT_invalid_orig_restrictions(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_orig_restrictions(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT35.HygieneErrors.NotLength('0,1,2'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_endorsements(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_endorsements(SALT35.StrType s) := WHICH(~Scrubs_DL_TN.Functions.fn_check_endorsement(s)>0);
EXPORT InValidMessageFT_invalid_orig_endorsements(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_check_endorsement'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_race(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_race(SALT35.StrType s) := WHICH(~Scrubs_DL_TN.Functions.fn_check_race(s)>0);
EXPORT InValidMessageFT_invalid_orig_race(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_TN.Functions.fn_check_race'),SALT35.HygieneErrors.Good);
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'process_date','orig_last_name','orig_first_name','orig_middle_name','orig_name_suffix','orig_street_address1','orig_street_address2','orig_city','orig_state','orig_zip_code','orig_dl_number','orig_license_type','orig_sex','orig_height_ft','orig_height_in','orig_weight','orig_eye_color','orig_hair_color','orig_restrictions1','orig_restrictions2','orig_restrictions3','orig_restrictions4','orig_restrictions5','orig_endorsements1','orig_endorsements2','orig_endorsements3','orig_endorsements4','orig_endorsements5','orig_dob','orig_issue_date','orig_expire_date','orig_non_cdl_status','orig_cdl_status','orig_race','orig_crlf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cln_zip5','cln_zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'process_date' => 0,'orig_last_name' => 1,'orig_first_name' => 2,'orig_middle_name' => 3,'orig_name_suffix' => 4,'orig_street_address1' => 5,'orig_street_address2' => 6,'orig_city' => 7,'orig_state' => 8,'orig_zip_code' => 9,'orig_dl_number' => 10,'orig_license_type' => 11,'orig_sex' => 12,'orig_height_ft' => 13,'orig_height_in' => 14,'orig_weight' => 15,'orig_eye_color' => 16,'orig_hair_color' => 17,'orig_restrictions1' => 18,'orig_restrictions2' => 19,'orig_restrictions3' => 20,'orig_restrictions4' => 21,'orig_restrictions5' => 22,'orig_endorsements1' => 23,'orig_endorsements2' => 24,'orig_endorsements3' => 25,'orig_endorsements4' => 26,'orig_endorsements5' => 27,'orig_dob' => 28,'orig_issue_date' => 29,'orig_expire_date' => 30,'orig_non_cdl_status' => 31,'orig_cdl_status' => 32,'orig_race' => 33,'orig_crlf' => 34,'clean_name_prefix' => 35,'clean_name_first' => 36,'clean_name_middle' => 37,'clean_name_last' => 38,'clean_name_suffix' => 39,'prim_range' => 40,'predir' => 41,'prim_name' => 42,'addr_suffix' => 43,'postdir' => 44,'unit_desig' => 45,'sec_range' => 46,'p_city_name' => 47,'v_city_name' => 48,'st' => 49,'cln_zip5' => 50,'cln_zip4' => 51,'cart' => 52,'cr_sort_sz' => 53,'lot' => 54,'lot_order' => 55,'dpbc' => 56,'chk_digit' => 57,'rec_type' => 58,'ace_fips_st' => 59,'county' => 60,'geo_lat' => 61,'geo_long' => 62,'msa' => 63,'geo_blk' => 64,'geo_match' => 65,'err_stat' => 66,0);
 
//Individual field level validation
 
EXPORT Make_process_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_process_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_orig_last_name(SALT35.StrType s0) := MakeFT_invalid_orig_name(s0);
EXPORT InValid_orig_last_name(SALT35.StrType s,SALT35.StrType orig_first_name,SALT35.StrType orig_middle_name) := InValidFT_invalid_orig_name(s,orig_first_name,orig_middle_name);
EXPORT InValidMessage_orig_last_name(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_name(wh);
 
EXPORT Make_orig_first_name(SALT35.StrType s0) := s0;
EXPORT InValid_orig_first_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_middle_name(SALT35.StrType s0) := s0;
EXPORT InValid_orig_middle_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_middle_name(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_name_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_orig_name_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_street_address1(SALT35.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_street_address1(SALT35.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_street_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_street_address2(SALT35.StrType s0) := s0;
EXPORT InValid_orig_street_address2(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_street_address2(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_city(SALT35.StrType s0) := MakeFT_invalid_alpha_num_specials(s0);
EXPORT InValid_orig_city(SALT35.StrType s) := InValidFT_invalid_alpha_num_specials(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num_specials(wh);
 
EXPORT Make_orig_state(SALT35.StrType s0) := MakeFT_invalid_orig_state(s0);
EXPORT InValid_orig_state(SALT35.StrType s) := InValidFT_invalid_orig_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_state(wh);
 
EXPORT Make_orig_zip_code(SALT35.StrType s0) := MakeFT_invalid_orig_zip_code(s0);
EXPORT InValid_orig_zip_code(SALT35.StrType s) := InValidFT_invalid_orig_zip_code(s);
EXPORT InValidMessage_orig_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip_code(wh);
 
EXPORT Make_orig_dl_number(SALT35.StrType s0) := MakeFT_invalid_orig_dl_number(s0);
EXPORT InValid_orig_dl_number(SALT35.StrType s) := InValidFT_invalid_orig_dl_number(s);
EXPORT InValidMessage_orig_dl_number(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_dl_number(wh);
 
EXPORT Make_orig_license_type(SALT35.StrType s0) := MakeFT_invalid_orig_license_type(s0);
EXPORT InValid_orig_license_type(SALT35.StrType s) := InValidFT_invalid_orig_license_type(s);
EXPORT InValidMessage_orig_license_type(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_license_type(wh);
 
EXPORT Make_orig_sex(SALT35.StrType s0) := MakeFT_invalid_orig_sex(s0);
EXPORT InValid_orig_sex(SALT35.StrType s) := InValidFT_invalid_orig_sex(s);
EXPORT InValidMessage_orig_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_sex(wh);
 
EXPORT Make_orig_height_ft(SALT35.StrType s0) := MakeFT_invalid_orig_height_ft(s0);
EXPORT InValid_orig_height_ft(SALT35.StrType s,SALT35.StrType orig_height_in) := InValidFT_invalid_orig_height_ft(s,orig_height_in);
EXPORT InValidMessage_orig_height_ft(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_height_ft(wh);
 
EXPORT Make_orig_height_in(SALT35.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_orig_height_in(SALT35.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_orig_height_in(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_orig_weight(SALT35.StrType s0) := MakeFT_invalid_orig_weight(s0);
EXPORT InValid_orig_weight(SALT35.StrType s) := InValidFT_invalid_orig_weight(s);
EXPORT InValidMessage_orig_weight(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_weight(wh);
 
EXPORT Make_orig_eye_color(SALT35.StrType s0) := MakeFT_invalid_orig_eye_color(s0);
EXPORT InValid_orig_eye_color(SALT35.StrType s) := InValidFT_invalid_orig_eye_color(s);
EXPORT InValidMessage_orig_eye_color(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_eye_color(wh);
 
EXPORT Make_orig_hair_color(SALT35.StrType s0) := MakeFT_invalid_orig_hair_color(s0);
EXPORT InValid_orig_hair_color(SALT35.StrType s) := InValidFT_invalid_orig_hair_color(s);
EXPORT InValidMessage_orig_hair_color(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_hair_color(wh);
 
EXPORT Make_orig_restrictions1(SALT35.StrType s0) := MakeFT_invalid_orig_restrictions(s0);
EXPORT InValid_orig_restrictions1(SALT35.StrType s) := InValidFT_invalid_orig_restrictions(s);
EXPORT InValidMessage_orig_restrictions1(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_restrictions(wh);
 
EXPORT Make_orig_restrictions2(SALT35.StrType s0) := MakeFT_invalid_orig_restrictions(s0);
EXPORT InValid_orig_restrictions2(SALT35.StrType s) := InValidFT_invalid_orig_restrictions(s);
EXPORT InValidMessage_orig_restrictions2(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_restrictions(wh);
 
EXPORT Make_orig_restrictions3(SALT35.StrType s0) := MakeFT_invalid_orig_restrictions(s0);
EXPORT InValid_orig_restrictions3(SALT35.StrType s) := InValidFT_invalid_orig_restrictions(s);
EXPORT InValidMessage_orig_restrictions3(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_restrictions(wh);
 
EXPORT Make_orig_restrictions4(SALT35.StrType s0) := MakeFT_invalid_orig_restrictions(s0);
EXPORT InValid_orig_restrictions4(SALT35.StrType s) := InValidFT_invalid_orig_restrictions(s);
EXPORT InValidMessage_orig_restrictions4(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_restrictions(wh);
 
EXPORT Make_orig_restrictions5(SALT35.StrType s0) := MakeFT_invalid_orig_restrictions(s0);
EXPORT InValid_orig_restrictions5(SALT35.StrType s) := InValidFT_invalid_orig_restrictions(s);
EXPORT InValidMessage_orig_restrictions5(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_restrictions(wh);
 
EXPORT Make_orig_endorsements1(SALT35.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements1(SALT35.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements1(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements2(SALT35.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements2(SALT35.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements2(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements3(SALT35.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements3(SALT35.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements3(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements4(SALT35.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements4(SALT35.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements4(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements5(SALT35.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements5(SALT35.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements5(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_dob(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_orig_dob(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_orig_issue_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_orig_issue_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_orig_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_orig_expire_date(SALT35.StrType s0) := MakeFT_invalid_8generaldate(s0);
EXPORT InValid_orig_expire_date(SALT35.StrType s) := InValidFT_invalid_8generaldate(s);
EXPORT InValidMessage_orig_expire_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8generaldate(wh);
 
EXPORT Make_orig_non_cdl_status(SALT35.StrType s0) := MakeFT_invalid_alpha_num(s0);
EXPORT InValid_orig_non_cdl_status(SALT35.StrType s) := InValidFT_invalid_alpha_num(s);
EXPORT InValidMessage_orig_non_cdl_status(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num(wh);
 
EXPORT Make_orig_cdl_status(SALT35.StrType s0) := MakeFT_invalid_alpha_num(s0);
EXPORT InValid_orig_cdl_status(SALT35.StrType s) := InValidFT_invalid_alpha_num(s);
EXPORT InValidMessage_orig_cdl_status(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_num(wh);
 
EXPORT Make_orig_race(SALT35.StrType s0) := MakeFT_invalid_orig_race(s0);
EXPORT InValid_orig_race(SALT35.StrType s) := InValidFT_invalid_orig_race(s);
EXPORT InValidMessage_orig_race(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_race(wh);
 
EXPORT Make_orig_crlf(SALT35.StrType s0) := s0;
EXPORT InValid_orig_crlf(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_crlf(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_prefix(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_prefix(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_first(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_first(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_first(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_middle(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_middle(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_middle(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_last(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_last(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_last(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT35.StrType s0) := s0;
EXPORT InValid_predir(SALT35.StrType s) := 0;
EXPORT InValidMessage_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT35.StrType s0) := s0;
EXPORT InValid_postdir(SALT35.StrType s) := 0;
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT35.StrType s0) := s0;
EXPORT InValid_p_city_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_v_city_name(SALT35.StrType s0) := s0;
EXPORT InValid_v_city_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_st(SALT35.StrType s0) := s0;
EXPORT InValid_st(SALT35.StrType s) := 0;
EXPORT InValidMessage_st(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_zip5(SALT35.StrType s0) := s0;
EXPORT InValid_cln_zip5(SALT35.StrType s) := 0;
EXPORT InValidMessage_cln_zip5(UNSIGNED1 wh) := '';
 
EXPORT Make_cln_zip4(SALT35.StrType s0) := s0;
EXPORT InValid_cln_zip4(SALT35.StrType s) := 0;
EXPORT InValidMessage_cln_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_cart(SALT35.StrType s0) := s0;
EXPORT InValid_cart(SALT35.StrType s) := 0;
EXPORT InValidMessage_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_cr_sort_sz(SALT35.StrType s0) := s0;
EXPORT InValid_cr_sort_sz(SALT35.StrType s) := 0;
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_lot(SALT35.StrType s0) := s0;
EXPORT InValid_lot(SALT35.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_lot_order(SALT35.StrType s0) := s0;
EXPORT InValid_lot_order(SALT35.StrType s) := 0;
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_dpbc(SALT35.StrType s0) := s0;
EXPORT InValid_dpbc(SALT35.StrType s) := 0;
EXPORT InValidMessage_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_chk_digit(SALT35.StrType s0) := s0;
EXPORT InValid_chk_digit(SALT35.StrType s) := 0;
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_rec_type(SALT35.StrType s0) := s0;
EXPORT InValid_rec_type(SALT35.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_ace_fips_st(SALT35.StrType s0) := s0;
EXPORT InValid_ace_fips_st(SALT35.StrType s) := 0;
EXPORT InValidMessage_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_county(SALT35.StrType s0) := s0;
EXPORT InValid_county(SALT35.StrType s) := 0;
EXPORT InValidMessage_county(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_lat(SALT35.StrType s0) := s0;
EXPORT InValid_geo_lat(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_long(SALT35.StrType s0) := s0;
EXPORT InValid_geo_long(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_msa(SALT35.StrType s0) := s0;
EXPORT InValid_msa(SALT35.StrType s) := 0;
EXPORT InValidMessage_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_blk(SALT35.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT35.StrType s0) := s0;
EXPORT InValid_geo_match(SALT35.StrType s) := 0;
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_err_stat(SALT35.StrType s0) := s0;
EXPORT InValid_err_stat(SALT35.StrType s) := 0;
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT35,Scrubs_DL_TN;
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
    BOOLEAN Diff_orig_last_name;
    BOOLEAN Diff_orig_first_name;
    BOOLEAN Diff_orig_middle_name;
    BOOLEAN Diff_orig_name_suffix;
    BOOLEAN Diff_orig_street_address1;
    BOOLEAN Diff_orig_street_address2;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip_code;
    BOOLEAN Diff_orig_dl_number;
    BOOLEAN Diff_orig_license_type;
    BOOLEAN Diff_orig_sex;
    BOOLEAN Diff_orig_height_ft;
    BOOLEAN Diff_orig_height_in;
    BOOLEAN Diff_orig_weight;
    BOOLEAN Diff_orig_eye_color;
    BOOLEAN Diff_orig_hair_color;
    BOOLEAN Diff_orig_restrictions1;
    BOOLEAN Diff_orig_restrictions2;
    BOOLEAN Diff_orig_restrictions3;
    BOOLEAN Diff_orig_restrictions4;
    BOOLEAN Diff_orig_restrictions5;
    BOOLEAN Diff_orig_endorsements1;
    BOOLEAN Diff_orig_endorsements2;
    BOOLEAN Diff_orig_endorsements3;
    BOOLEAN Diff_orig_endorsements4;
    BOOLEAN Diff_orig_endorsements5;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_issue_date;
    BOOLEAN Diff_orig_expire_date;
    BOOLEAN Diff_orig_non_cdl_status;
    BOOLEAN Diff_orig_cdl_status;
    BOOLEAN Diff_orig_race;
    BOOLEAN Diff_orig_crlf;
    BOOLEAN Diff_clean_name_prefix;
    BOOLEAN Diff_clean_name_first;
    BOOLEAN Diff_clean_name_middle;
    BOOLEAN Diff_clean_name_last;
    BOOLEAN Diff_clean_name_suffix;
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
    BOOLEAN Diff_cln_zip5;
    BOOLEAN Diff_cln_zip4;
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
    SALT35.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_orig_last_name := le.orig_last_name <> ri.orig_last_name;
    SELF.Diff_orig_first_name := le.orig_first_name <> ri.orig_first_name;
    SELF.Diff_orig_middle_name := le.orig_middle_name <> ri.orig_middle_name;
    SELF.Diff_orig_name_suffix := le.orig_name_suffix <> ri.orig_name_suffix;
    SELF.Diff_orig_street_address1 := le.orig_street_address1 <> ri.orig_street_address1;
    SELF.Diff_orig_street_address2 := le.orig_street_address2 <> ri.orig_street_address2;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip_code := le.orig_zip_code <> ri.orig_zip_code;
    SELF.Diff_orig_dl_number := le.orig_dl_number <> ri.orig_dl_number;
    SELF.Diff_orig_license_type := le.orig_license_type <> ri.orig_license_type;
    SELF.Diff_orig_sex := le.orig_sex <> ri.orig_sex;
    SELF.Diff_orig_height_ft := le.orig_height_ft <> ri.orig_height_ft;
    SELF.Diff_orig_height_in := le.orig_height_in <> ri.orig_height_in;
    SELF.Diff_orig_weight := le.orig_weight <> ri.orig_weight;
    SELF.Diff_orig_eye_color := le.orig_eye_color <> ri.orig_eye_color;
    SELF.Diff_orig_hair_color := le.orig_hair_color <> ri.orig_hair_color;
    SELF.Diff_orig_restrictions1 := le.orig_restrictions1 <> ri.orig_restrictions1;
    SELF.Diff_orig_restrictions2 := le.orig_restrictions2 <> ri.orig_restrictions2;
    SELF.Diff_orig_restrictions3 := le.orig_restrictions3 <> ri.orig_restrictions3;
    SELF.Diff_orig_restrictions4 := le.orig_restrictions4 <> ri.orig_restrictions4;
    SELF.Diff_orig_restrictions5 := le.orig_restrictions5 <> ri.orig_restrictions5;
    SELF.Diff_orig_endorsements1 := le.orig_endorsements1 <> ri.orig_endorsements1;
    SELF.Diff_orig_endorsements2 := le.orig_endorsements2 <> ri.orig_endorsements2;
    SELF.Diff_orig_endorsements3 := le.orig_endorsements3 <> ri.orig_endorsements3;
    SELF.Diff_orig_endorsements4 := le.orig_endorsements4 <> ri.orig_endorsements4;
    SELF.Diff_orig_endorsements5 := le.orig_endorsements5 <> ri.orig_endorsements5;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_issue_date := le.orig_issue_date <> ri.orig_issue_date;
    SELF.Diff_orig_expire_date := le.orig_expire_date <> ri.orig_expire_date;
    SELF.Diff_orig_non_cdl_status := le.orig_non_cdl_status <> ri.orig_non_cdl_status;
    SELF.Diff_orig_cdl_status := le.orig_cdl_status <> ri.orig_cdl_status;
    SELF.Diff_orig_race := le.orig_race <> ri.orig_race;
    SELF.Diff_orig_crlf := le.orig_crlf <> ri.orig_crlf;
    SELF.Diff_clean_name_prefix := le.clean_name_prefix <> ri.clean_name_prefix;
    SELF.Diff_clean_name_first := le.clean_name_first <> ri.clean_name_first;
    SELF.Diff_clean_name_middle := le.clean_name_middle <> ri.clean_name_middle;
    SELF.Diff_clean_name_last := le.clean_name_last <> ri.clean_name_last;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
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
    SELF.Diff_cln_zip5 := le.cln_zip5 <> ri.cln_zip5;
    SELF.Diff_cln_zip4 := le.cln_zip4 <> ri.cln_zip4;
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
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_orig_last_name,1,0)+ IF( SELF.Diff_orig_first_name,1,0)+ IF( SELF.Diff_orig_middle_name,1,0)+ IF( SELF.Diff_orig_name_suffix,1,0)+ IF( SELF.Diff_orig_street_address1,1,0)+ IF( SELF.Diff_orig_street_address2,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip_code,1,0)+ IF( SELF.Diff_orig_dl_number,1,0)+ IF( SELF.Diff_orig_license_type,1,0)+ IF( SELF.Diff_orig_sex,1,0)+ IF( SELF.Diff_orig_height_ft,1,0)+ IF( SELF.Diff_orig_height_in,1,0)+ IF( SELF.Diff_orig_weight,1,0)+ IF( SELF.Diff_orig_eye_color,1,0)+ IF( SELF.Diff_orig_hair_color,1,0)+ IF( SELF.Diff_orig_restrictions1,1,0)+ IF( SELF.Diff_orig_restrictions2,1,0)+ IF( SELF.Diff_orig_restrictions3,1,0)+ IF( SELF.Diff_orig_restrictions4,1,0)+ IF( SELF.Diff_orig_restrictions5,1,0)+ IF( SELF.Diff_orig_endorsements1,1,0)+ IF( SELF.Diff_orig_endorsements2,1,0)+ IF( SELF.Diff_orig_endorsements3,1,0)+ IF( SELF.Diff_orig_endorsements4,1,0)+ IF( SELF.Diff_orig_endorsements5,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_issue_date,1,0)+ IF( SELF.Diff_orig_expire_date,1,0)+ IF( SELF.Diff_orig_non_cdl_status,1,0)+ IF( SELF.Diff_orig_cdl_status,1,0)+ IF( SELF.Diff_orig_race,1,0)+ IF( SELF.Diff_orig_crlf,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_name_first,1,0)+ IF( SELF.Diff_clean_name_middle,1,0)+ IF( SELF.Diff_clean_name_last,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_cln_zip5,1,0)+ IF( SELF.Diff_cln_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dpbc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_ace_fips_st,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0);
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
    Count_Diff_orig_last_name := COUNT(GROUP,%Closest%.Diff_orig_last_name);
    Count_Diff_orig_first_name := COUNT(GROUP,%Closest%.Diff_orig_first_name);
    Count_Diff_orig_middle_name := COUNT(GROUP,%Closest%.Diff_orig_middle_name);
    Count_Diff_orig_name_suffix := COUNT(GROUP,%Closest%.Diff_orig_name_suffix);
    Count_Diff_orig_street_address1 := COUNT(GROUP,%Closest%.Diff_orig_street_address1);
    Count_Diff_orig_street_address2 := COUNT(GROUP,%Closest%.Diff_orig_street_address2);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip_code := COUNT(GROUP,%Closest%.Diff_orig_zip_code);
    Count_Diff_orig_dl_number := COUNT(GROUP,%Closest%.Diff_orig_dl_number);
    Count_Diff_orig_license_type := COUNT(GROUP,%Closest%.Diff_orig_license_type);
    Count_Diff_orig_sex := COUNT(GROUP,%Closest%.Diff_orig_sex);
    Count_Diff_orig_height_ft := COUNT(GROUP,%Closest%.Diff_orig_height_ft);
    Count_Diff_orig_height_in := COUNT(GROUP,%Closest%.Diff_orig_height_in);
    Count_Diff_orig_weight := COUNT(GROUP,%Closest%.Diff_orig_weight);
    Count_Diff_orig_eye_color := COUNT(GROUP,%Closest%.Diff_orig_eye_color);
    Count_Diff_orig_hair_color := COUNT(GROUP,%Closest%.Diff_orig_hair_color);
    Count_Diff_orig_restrictions1 := COUNT(GROUP,%Closest%.Diff_orig_restrictions1);
    Count_Diff_orig_restrictions2 := COUNT(GROUP,%Closest%.Diff_orig_restrictions2);
    Count_Diff_orig_restrictions3 := COUNT(GROUP,%Closest%.Diff_orig_restrictions3);
    Count_Diff_orig_restrictions4 := COUNT(GROUP,%Closest%.Diff_orig_restrictions4);
    Count_Diff_orig_restrictions5 := COUNT(GROUP,%Closest%.Diff_orig_restrictions5);
    Count_Diff_orig_endorsements1 := COUNT(GROUP,%Closest%.Diff_orig_endorsements1);
    Count_Diff_orig_endorsements2 := COUNT(GROUP,%Closest%.Diff_orig_endorsements2);
    Count_Diff_orig_endorsements3 := COUNT(GROUP,%Closest%.Diff_orig_endorsements3);
    Count_Diff_orig_endorsements4 := COUNT(GROUP,%Closest%.Diff_orig_endorsements4);
    Count_Diff_orig_endorsements5 := COUNT(GROUP,%Closest%.Diff_orig_endorsements5);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_issue_date := COUNT(GROUP,%Closest%.Diff_orig_issue_date);
    Count_Diff_orig_expire_date := COUNT(GROUP,%Closest%.Diff_orig_expire_date);
    Count_Diff_orig_non_cdl_status := COUNT(GROUP,%Closest%.Diff_orig_non_cdl_status);
    Count_Diff_orig_cdl_status := COUNT(GROUP,%Closest%.Diff_orig_cdl_status);
    Count_Diff_orig_race := COUNT(GROUP,%Closest%.Diff_orig_race);
    Count_Diff_orig_crlf := COUNT(GROUP,%Closest%.Diff_orig_crlf);
    Count_Diff_clean_name_prefix := COUNT(GROUP,%Closest%.Diff_clean_name_prefix);
    Count_Diff_clean_name_first := COUNT(GROUP,%Closest%.Diff_clean_name_first);
    Count_Diff_clean_name_middle := COUNT(GROUP,%Closest%.Diff_clean_name_middle);
    Count_Diff_clean_name_last := COUNT(GROUP,%Closest%.Diff_clean_name_last);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
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
    Count_Diff_cln_zip5 := COUNT(GROUP,%Closest%.Diff_cln_zip5);
    Count_Diff_cln_zip4 := COUNT(GROUP,%Closest%.Diff_cln_zip4);
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
