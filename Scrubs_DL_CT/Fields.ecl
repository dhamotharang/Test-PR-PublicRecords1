IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_DL_CT; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_blank','invalid_alpha_special','invalid_alpha_num_specials','invalid_numeric','invalid_numeric_blank','invalid_alpha_num','invalid_empty','invalid_boolean_yn_empty','invalid_wordbag','invalid_8pastdate','invalid_08pastdate','invalid_orig_dlstate','invalid_orig_dlnumber','invalid_orig_name','invalid_orig_sex','invalid_orig_height','invalid_inches','invalid_orig_eye_color','invalid_orig_classification','invalid_orig_issue_date','invalid_day','invalid_orig_expire_date','invalid_orig_status','invalid_orig_restrictions','invalid_state','invalid_clean_name');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_blank' => 3,'invalid_alpha_special' => 4,'invalid_alpha_num_specials' => 5,'invalid_numeric' => 6,'invalid_numeric_blank' => 7,'invalid_alpha_num' => 8,'invalid_empty' => 9,'invalid_boolean_yn_empty' => 10,'invalid_wordbag' => 11,'invalid_8pastdate' => 12,'invalid_08pastdate' => 13,'invalid_orig_dlstate' => 14,'invalid_orig_dlnumber' => 15,'invalid_orig_name' => 16,'invalid_orig_sex' => 17,'invalid_orig_height' => 18,'invalid_inches' => 19,'invalid_orig_eye_color' => 20,'invalid_orig_classification' => 21,'invalid_orig_issue_date' => 22,'invalid_day' => 23,'invalid_orig_expire_date' => 24,'invalid_orig_status' => 25,'invalid_orig_restrictions' => 26,'invalid_state' => 27,'invalid_clean_name' => 28,0);
 
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
 
EXPORT MakeFT_invalid_alpha_blank(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_blank(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_special(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_special(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))));
EXPORT InValidMessageFT_invalid_alpha_special(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num_specials(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num_specials(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @-'))));
EXPORT InValidMessageFT_invalid_alpha_num_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @-'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789 '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '))));
EXPORT InValidMessageFT_invalid_alpha_num(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('0'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yn_empty(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yn_empty(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean_yn_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('N|Y|'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wordbag(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringtouppercase(s0); // Force to upper case
  s2 := SALT34.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^:;!&,`./#@*\'\\|_"%~'); // Only allow valid symbols
  s3 := SALT34.stringcleanspaces( SALT34.stringsubstituteout(s2,' <>{}[]()-^:;!&,`./#@*\'\\|_"%~',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_wordbag(SALT34.StrType s) := WHICH(SALT34.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^:;!&,`./#@*\'\\|_"%~'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotCaps,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^:;!&,`./#@*\'\\|_"%~'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT34.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_08pastdate(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_08pastdate(SALT34.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_08pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT34.HygieneErrors.NotLength('0,8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_dlstate(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_dlstate(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['CT','CT']);
EXPORT InValidMessageFT_invalid_orig_dlstate(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('CT|CT'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_dlnumber(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_orig_dlnumber(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs_DL_CT.Functions.fn_check_dl_number(s)>0,~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_orig_dlnumber(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_dl_number'),SALT34.HygieneErrors.NotLength('9'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_name(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @-'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_num_specials(s1);
END;
EXPORT InValidFT_invalid_orig_name(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @-'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_orig_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ @-'),SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_sex(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_sex(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['1','2']);
EXPORT InValidMessageFT_invalid_orig_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('1|2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_height(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_height(SALT34.StrType s,SALT34.StrType orig_height2) := WHICH(~Scrubs_DL_CT.Functions.fn_verify_height(s,orig_height2)>0);
EXPORT InValidMessageFT_invalid_orig_height(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_verify_height'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_inches(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_inches(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['00','01','02','03','04','05','06','07','08','09','10','11']);
EXPORT InValidMessageFT_invalid_inches(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('00|01|02|03|04|05|06|07|08|09|10|11'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_eye_color(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_eye_color(SALT34.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_eye_color(s)>0);
EXPORT InValidMessageFT_invalid_orig_eye_color(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_eye_color'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_classification(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_classification(SALT34.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_class(s)>0);
EXPORT InValidMessageFT_invalid_orig_classification(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_class'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_issue_date(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_issue_date(SALT34.StrType s,SALT34.StrType orig_issue_date_dd) := WHICH(~Scrubs_DL_CT.Functions.fn_check_pastdate(s,orig_issue_date_dd)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6));
EXPORT InValidMessageFT_invalid_orig_issue_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_pastdate'),SALT34.HygieneErrors.NotLength('0,6'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_day(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_day(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','']);
EXPORT InValidMessageFT_invalid_day(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_expire_date(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_expire_date(SALT34.StrType s,SALT34.StrType orig_expire_date_dd) := WHICH(~Scrubs_DL_CT.Functions.fn_check_date(s,orig_expire_date_dd)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 6));
EXPORT InValidMessageFT_invalid_orig_expire_date(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_date'),SALT34.HygieneErrors.NotLength('0,6'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_status(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_status(SALT34.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_status_code(s)>0);
EXPORT InValidMessageFT_invalid_orig_status(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_status_code'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_restrictions(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_restrictions(SALT34.StrType s) := WHICH(~Scrubs_DL_CT.Functions.fn_check_restriction_codes(s)>0);
EXPORT InValidMessageFT_invalid_orig_restrictions(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_check_restriction_codes'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha(s1);
END;
EXPORT InValidFT_invalid_state(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.NotLength('0,2'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'); // Only allow valid symbols
  RETURN  MakeFT_invalid_alpha_special(s1);
END;
EXPORT InValidFT_invalid_clean_name(SALT34.StrType s,SALT34.StrType clean_name_first,SALT34.StrType clean_name_middle) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ -'))),~Scrubs_DL_CT.Functions.fn_valid_name(s,clean_name_first,clean_name_middle)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ -'),SALT34.HygieneErrors.CustomFail('Scrubs_DL_CT.Functions.fn_valid_name'),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','orig_dlstate','orig_dlnumber','orig_name','orig_dob','orig_sex','orig_height1','orig_height2','orig_eye_color','orig_mailaddress','orig_classification','orig_endorsements','orig_issue_date','orig_issue_date_dd','orig_expire_date','orig_expire_date_dd','orig_noncdlstatus','orig_cdlstatus','orig_restrictions','orig_origdate','orig_origcdldate','orig_cancelst','orig_canceldate','orig_crlf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'append_process_date' => 0,'orig_dlstate' => 1,'orig_dlnumber' => 2,'orig_name' => 3,'orig_dob' => 4,'orig_sex' => 5,'orig_height1' => 6,'orig_height2' => 7,'orig_eye_color' => 8,'orig_mailaddress' => 9,'orig_classification' => 10,'orig_endorsements' => 11,'orig_issue_date' => 12,'orig_issue_date_dd' => 13,'orig_expire_date' => 14,'orig_expire_date_dd' => 15,'orig_noncdlstatus' => 16,'orig_cdlstatus' => 17,'orig_restrictions' => 18,'orig_origdate' => 19,'orig_origcdldate' => 20,'orig_cancelst' => 21,'orig_canceldate' => 22,'orig_crlf' => 23,'clean_name_prefix' => 24,'clean_name_first' => 25,'clean_name_middle' => 26,'clean_name_last' => 27,'clean_name_suffix' => 28,'clean_name_score' => 29,'clean_prim_range' => 30,'clean_predir' => 31,'clean_prim_name' => 32,'clean_addr_suffix' => 33,'clean_postdir' => 34,'clean_unit_desig' => 35,'clean_sec_range' => 36,'clean_p_city_name' => 37,'clean_v_city_name' => 38,'clean_st' => 39,'clean_zip' => 40,'clean_zip4' => 41,'clean_cart' => 42,'clean_cr_sort_sz' => 43,'clean_lot' => 44,'clean_lot_order' => 45,'clean_dpbc' => 46,'clean_chk_digit' => 47,'clean_record_type' => 48,'clean_ace_fips_st' => 49,'clean_fipscounty' => 50,'clean_geo_lat' => 51,'clean_geo_long' => 52,'clean_msa' => 53,'clean_geo_blk' => 54,'clean_geo_match' => 55,'clean_err_stat' => 56,0);
 
//Individual field level validation
 
EXPORT Make_append_process_date(SALT34.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_append_process_date(SALT34.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_append_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_orig_dlstate(SALT34.StrType s0) := MakeFT_invalid_orig_dlstate(s0);
EXPORT InValid_orig_dlstate(SALT34.StrType s) := InValidFT_invalid_orig_dlstate(s);
EXPORT InValidMessage_orig_dlstate(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_dlstate(wh);
 
EXPORT Make_orig_dlnumber(SALT34.StrType s0) := MakeFT_invalid_orig_dlnumber(s0);
EXPORT InValid_orig_dlnumber(SALT34.StrType s) := InValidFT_invalid_orig_dlnumber(s);
EXPORT InValidMessage_orig_dlnumber(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_dlnumber(wh);
 
EXPORT Make_orig_name(SALT34.StrType s0) := MakeFT_invalid_orig_name(s0);
EXPORT InValid_orig_name(SALT34.StrType s) := InValidFT_invalid_orig_name(s);
EXPORT InValidMessage_orig_name(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_name(wh);
 
EXPORT Make_orig_dob(SALT34.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_orig_dob(SALT34.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_orig_sex(SALT34.StrType s0) := MakeFT_invalid_orig_sex(s0);
EXPORT InValid_orig_sex(SALT34.StrType s) := InValidFT_invalid_orig_sex(s);
EXPORT InValidMessage_orig_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_sex(wh);
 
EXPORT Make_orig_height1(SALT34.StrType s0) := MakeFT_invalid_orig_height(s0);
EXPORT InValid_orig_height1(SALT34.StrType s,SALT34.StrType orig_height2) := InValidFT_invalid_orig_height(s,orig_height2);
EXPORT InValidMessage_orig_height1(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_height(wh);
 
EXPORT Make_orig_height2(SALT34.StrType s0) := MakeFT_invalid_inches(s0);
EXPORT InValid_orig_height2(SALT34.StrType s) := InValidFT_invalid_inches(s);
EXPORT InValidMessage_orig_height2(UNSIGNED1 wh) := InValidMessageFT_invalid_inches(wh);
 
EXPORT Make_orig_eye_color(SALT34.StrType s0) := MakeFT_invalid_orig_eye_color(s0);
EXPORT InValid_orig_eye_color(SALT34.StrType s) := InValidFT_invalid_orig_eye_color(s);
EXPORT InValidMessage_orig_eye_color(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_eye_color(wh);
 
EXPORT Make_orig_mailaddress(SALT34.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_orig_mailaddress(SALT34.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_orig_mailaddress(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_orig_classification(SALT34.StrType s0) := MakeFT_invalid_orig_classification(s0);
EXPORT InValid_orig_classification(SALT34.StrType s) := InValidFT_invalid_orig_classification(s);
EXPORT InValidMessage_orig_classification(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_classification(wh);
 
EXPORT Make_orig_endorsements(SALT34.StrType s0) := s0;
EXPORT InValid_orig_endorsements(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_orig_endorsements(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_issue_date(SALT34.StrType s0) := MakeFT_invalid_orig_issue_date(s0);
EXPORT InValid_orig_issue_date(SALT34.StrType s,SALT34.StrType orig_issue_date_dd) := InValidFT_invalid_orig_issue_date(s,orig_issue_date_dd);
EXPORT InValidMessage_orig_issue_date(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_issue_date(wh);
 
EXPORT Make_orig_issue_date_dd(SALT34.StrType s0) := MakeFT_invalid_day(s0);
EXPORT InValid_orig_issue_date_dd(SALT34.StrType s) := InValidFT_invalid_day(s);
EXPORT InValidMessage_orig_issue_date_dd(UNSIGNED1 wh) := InValidMessageFT_invalid_day(wh);
 
EXPORT Make_orig_expire_date(SALT34.StrType s0) := MakeFT_invalid_orig_expire_date(s0);
EXPORT InValid_orig_expire_date(SALT34.StrType s,SALT34.StrType orig_expire_date_dd) := InValidFT_invalid_orig_expire_date(s,orig_expire_date_dd);
EXPORT InValidMessage_orig_expire_date(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_expire_date(wh);
 
EXPORT Make_orig_expire_date_dd(SALT34.StrType s0) := MakeFT_invalid_day(s0);
EXPORT InValid_orig_expire_date_dd(SALT34.StrType s) := InValidFT_invalid_day(s);
EXPORT InValidMessage_orig_expire_date_dd(UNSIGNED1 wh) := InValidMessageFT_invalid_day(wh);
 
EXPORT Make_orig_noncdlstatus(SALT34.StrType s0) := MakeFT_invalid_orig_status(s0);
EXPORT InValid_orig_noncdlstatus(SALT34.StrType s) := InValidFT_invalid_orig_status(s);
EXPORT InValidMessage_orig_noncdlstatus(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_status(wh);
 
EXPORT Make_orig_cdlstatus(SALT34.StrType s0) := MakeFT_invalid_orig_status(s0);
EXPORT InValid_orig_cdlstatus(SALT34.StrType s) := InValidFT_invalid_orig_status(s);
EXPORT InValidMessage_orig_cdlstatus(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_status(wh);
 
EXPORT Make_orig_restrictions(SALT34.StrType s0) := MakeFT_invalid_orig_restrictions(s0);
EXPORT InValid_orig_restrictions(SALT34.StrType s) := InValidFT_invalid_orig_restrictions(s);
EXPORT InValidMessage_orig_restrictions(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_restrictions(wh);
 
EXPORT Make_orig_origdate(SALT34.StrType s0) := MakeFT_invalid_08pastdate(s0);
EXPORT InValid_orig_origdate(SALT34.StrType s) := InValidFT_invalid_08pastdate(s);
EXPORT InValidMessage_orig_origdate(UNSIGNED1 wh) := InValidMessageFT_invalid_08pastdate(wh);
 
EXPORT Make_orig_origcdldate(SALT34.StrType s0) := MakeFT_invalid_08pastdate(s0);
EXPORT InValid_orig_origcdldate(SALT34.StrType s) := InValidFT_invalid_08pastdate(s);
EXPORT InValidMessage_orig_origcdldate(UNSIGNED1 wh) := InValidMessageFT_invalid_08pastdate(wh);
 
EXPORT Make_orig_cancelst(SALT34.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_cancelst(SALT34.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_cancelst(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_orig_canceldate(SALT34.StrType s0) := MakeFT_invalid_08pastdate(s0);
EXPORT InValid_orig_canceldate(SALT34.StrType s) := InValidFT_invalid_08pastdate(s);
EXPORT InValidMessage_orig_canceldate(UNSIGNED1 wh) := InValidMessageFT_invalid_08pastdate(wh);
 
EXPORT Make_orig_crlf(SALT34.StrType s0) := s0;
EXPORT InValid_orig_crlf(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_orig_crlf(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_prefix(SALT34.StrType s0) := s0;
EXPORT InValid_clean_name_prefix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_first(SALT34.StrType s0) := s0;
EXPORT InValid_clean_name_first(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_name_first(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_middle(SALT34.StrType s0) := s0;
EXPORT InValid_clean_name_middle(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_name_middle(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_last(SALT34.StrType s0) := MakeFT_invalid_clean_name(s0);
EXPORT InValid_clean_name_last(SALT34.StrType s,SALT34.StrType clean_name_first,SALT34.StrType clean_name_middle) := InValidFT_invalid_clean_name(s,clean_name_first,clean_name_middle);
EXPORT InValidMessage_clean_name_last(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name(wh);
 
EXPORT Make_clean_name_suffix(SALT34.StrType s0) := s0;
EXPORT InValid_clean_name_suffix(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_score(SALT34.StrType s0) := s0;
EXPORT InValid_clean_name_score(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_prim_range(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_prim_range(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_predir(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_predir(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_prim_name(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_prim_name(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_addr_suffix(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_addr_suffix(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_addr_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_postdir(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_postdir(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_unit_desig(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_unit_desig(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_unit_desig(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_sec_range(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_sec_range(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_sec_range(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_p_city_name(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_p_city_name(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_v_city_name(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_v_city_name(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_st(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_st(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_st(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_zip(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_zip(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_zip4(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_zip4(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_cart(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_cart(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_cr_sort_sz(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_cr_sort_sz(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_lot(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_lot(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_lot_order(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_lot_order(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_dpbc(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_dpbc(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_chk_digit(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_chk_digit(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_record_type(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_record_type(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_ace_fips_st(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_ace_fips_st(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_fipscounty(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_fipscounty(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_fipscounty(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_geo_lat(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_geo_lat(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_geo_long(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_geo_long(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_msa(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_msa(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_geo_blk(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_geo_blk(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_geo_blk(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_geo_match(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_geo_match(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_clean_err_stat(SALT34.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_clean_err_stat(SALT34.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_clean_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_DL_CT;
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
    BOOLEAN Diff_append_process_date;
    BOOLEAN Diff_orig_dlstate;
    BOOLEAN Diff_orig_dlnumber;
    BOOLEAN Diff_orig_name;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_sex;
    BOOLEAN Diff_orig_height1;
    BOOLEAN Diff_orig_height2;
    BOOLEAN Diff_orig_eye_color;
    BOOLEAN Diff_orig_mailaddress;
    BOOLEAN Diff_orig_classification;
    BOOLEAN Diff_orig_endorsements;
    BOOLEAN Diff_orig_issue_date;
    BOOLEAN Diff_orig_issue_date_dd;
    BOOLEAN Diff_orig_expire_date;
    BOOLEAN Diff_orig_expire_date_dd;
    BOOLEAN Diff_orig_noncdlstatus;
    BOOLEAN Diff_orig_cdlstatus;
    BOOLEAN Diff_orig_restrictions;
    BOOLEAN Diff_orig_origdate;
    BOOLEAN Diff_orig_origcdldate;
    BOOLEAN Diff_orig_cancelst;
    BOOLEAN Diff_orig_canceldate;
    BOOLEAN Diff_orig_crlf;
    BOOLEAN Diff_clean_name_prefix;
    BOOLEAN Diff_clean_name_first;
    BOOLEAN Diff_clean_name_middle;
    BOOLEAN Diff_clean_name_last;
    BOOLEAN Diff_clean_name_suffix;
    BOOLEAN Diff_clean_name_score;
    BOOLEAN Diff_clean_prim_range;
    BOOLEAN Diff_clean_predir;
    BOOLEAN Diff_clean_prim_name;
    BOOLEAN Diff_clean_addr_suffix;
    BOOLEAN Diff_clean_postdir;
    BOOLEAN Diff_clean_unit_desig;
    BOOLEAN Diff_clean_sec_range;
    BOOLEAN Diff_clean_p_city_name;
    BOOLEAN Diff_clean_v_city_name;
    BOOLEAN Diff_clean_st;
    BOOLEAN Diff_clean_zip;
    BOOLEAN Diff_clean_zip4;
    BOOLEAN Diff_clean_cart;
    BOOLEAN Diff_clean_cr_sort_sz;
    BOOLEAN Diff_clean_lot;
    BOOLEAN Diff_clean_lot_order;
    BOOLEAN Diff_clean_dpbc;
    BOOLEAN Diff_clean_chk_digit;
    BOOLEAN Diff_clean_record_type;
    BOOLEAN Diff_clean_ace_fips_st;
    BOOLEAN Diff_clean_fipscounty;
    BOOLEAN Diff_clean_geo_lat;
    BOOLEAN Diff_clean_geo_long;
    BOOLEAN Diff_clean_msa;
    BOOLEAN Diff_clean_geo_blk;
    BOOLEAN Diff_clean_geo_match;
    BOOLEAN Diff_clean_err_stat;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_process_date := le.append_process_date <> ri.append_process_date;
    SELF.Diff_orig_dlstate := le.orig_dlstate <> ri.orig_dlstate;
    SELF.Diff_orig_dlnumber := le.orig_dlnumber <> ri.orig_dlnumber;
    SELF.Diff_orig_name := le.orig_name <> ri.orig_name;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_sex := le.orig_sex <> ri.orig_sex;
    SELF.Diff_orig_height1 := le.orig_height1 <> ri.orig_height1;
    SELF.Diff_orig_height2 := le.orig_height2 <> ri.orig_height2;
    SELF.Diff_orig_eye_color := le.orig_eye_color <> ri.orig_eye_color;
    SELF.Diff_orig_mailaddress := le.orig_mailaddress <> ri.orig_mailaddress;
    SELF.Diff_orig_classification := le.orig_classification <> ri.orig_classification;
    SELF.Diff_orig_endorsements := le.orig_endorsements <> ri.orig_endorsements;
    SELF.Diff_orig_issue_date := le.orig_issue_date <> ri.orig_issue_date;
    SELF.Diff_orig_issue_date_dd := le.orig_issue_date_dd <> ri.orig_issue_date_dd;
    SELF.Diff_orig_expire_date := le.orig_expire_date <> ri.orig_expire_date;
    SELF.Diff_orig_expire_date_dd := le.orig_expire_date_dd <> ri.orig_expire_date_dd;
    SELF.Diff_orig_noncdlstatus := le.orig_noncdlstatus <> ri.orig_noncdlstatus;
    SELF.Diff_orig_cdlstatus := le.orig_cdlstatus <> ri.orig_cdlstatus;
    SELF.Diff_orig_restrictions := le.orig_restrictions <> ri.orig_restrictions;
    SELF.Diff_orig_origdate := le.orig_origdate <> ri.orig_origdate;
    SELF.Diff_orig_origcdldate := le.orig_origcdldate <> ri.orig_origcdldate;
    SELF.Diff_orig_cancelst := le.orig_cancelst <> ri.orig_cancelst;
    SELF.Diff_orig_canceldate := le.orig_canceldate <> ri.orig_canceldate;
    SELF.Diff_orig_crlf := le.orig_crlf <> ri.orig_crlf;
    SELF.Diff_clean_name_prefix := le.clean_name_prefix <> ri.clean_name_prefix;
    SELF.Diff_clean_name_first := le.clean_name_first <> ri.clean_name_first;
    SELF.Diff_clean_name_middle := le.clean_name_middle <> ri.clean_name_middle;
    SELF.Diff_clean_name_last := le.clean_name_last <> ri.clean_name_last;
    SELF.Diff_clean_name_suffix := le.clean_name_suffix <> ri.clean_name_suffix;
    SELF.Diff_clean_name_score := le.clean_name_score <> ri.clean_name_score;
    SELF.Diff_clean_prim_range := le.clean_prim_range <> ri.clean_prim_range;
    SELF.Diff_clean_predir := le.clean_predir <> ri.clean_predir;
    SELF.Diff_clean_prim_name := le.clean_prim_name <> ri.clean_prim_name;
    SELF.Diff_clean_addr_suffix := le.clean_addr_suffix <> ri.clean_addr_suffix;
    SELF.Diff_clean_postdir := le.clean_postdir <> ri.clean_postdir;
    SELF.Diff_clean_unit_desig := le.clean_unit_desig <> ri.clean_unit_desig;
    SELF.Diff_clean_sec_range := le.clean_sec_range <> ri.clean_sec_range;
    SELF.Diff_clean_p_city_name := le.clean_p_city_name <> ri.clean_p_city_name;
    SELF.Diff_clean_v_city_name := le.clean_v_city_name <> ri.clean_v_city_name;
    SELF.Diff_clean_st := le.clean_st <> ri.clean_st;
    SELF.Diff_clean_zip := le.clean_zip <> ri.clean_zip;
    SELF.Diff_clean_zip4 := le.clean_zip4 <> ri.clean_zip4;
    SELF.Diff_clean_cart := le.clean_cart <> ri.clean_cart;
    SELF.Diff_clean_cr_sort_sz := le.clean_cr_sort_sz <> ri.clean_cr_sort_sz;
    SELF.Diff_clean_lot := le.clean_lot <> ri.clean_lot;
    SELF.Diff_clean_lot_order := le.clean_lot_order <> ri.clean_lot_order;
    SELF.Diff_clean_dpbc := le.clean_dpbc <> ri.clean_dpbc;
    SELF.Diff_clean_chk_digit := le.clean_chk_digit <> ri.clean_chk_digit;
    SELF.Diff_clean_record_type := le.clean_record_type <> ri.clean_record_type;
    SELF.Diff_clean_ace_fips_st := le.clean_ace_fips_st <> ri.clean_ace_fips_st;
    SELF.Diff_clean_fipscounty := le.clean_fipscounty <> ri.clean_fipscounty;
    SELF.Diff_clean_geo_lat := le.clean_geo_lat <> ri.clean_geo_lat;
    SELF.Diff_clean_geo_long := le.clean_geo_long <> ri.clean_geo_long;
    SELF.Diff_clean_msa := le.clean_msa <> ri.clean_msa;
    SELF.Diff_clean_geo_blk := le.clean_geo_blk <> ri.clean_geo_blk;
    SELF.Diff_clean_geo_match := le.clean_geo_match <> ri.clean_geo_match;
    SELF.Diff_clean_err_stat := le.clean_err_stat <> ri.clean_err_stat;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_process_date,1,0)+ IF( SELF.Diff_orig_dlstate,1,0)+ IF( SELF.Diff_orig_dlnumber,1,0)+ IF( SELF.Diff_orig_name,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_sex,1,0)+ IF( SELF.Diff_orig_height1,1,0)+ IF( SELF.Diff_orig_height2,1,0)+ IF( SELF.Diff_orig_eye_color,1,0)+ IF( SELF.Diff_orig_mailaddress,1,0)+ IF( SELF.Diff_orig_classification,1,0)+ IF( SELF.Diff_orig_endorsements,1,0)+ IF( SELF.Diff_orig_issue_date,1,0)+ IF( SELF.Diff_orig_issue_date_dd,1,0)+ IF( SELF.Diff_orig_expire_date,1,0)+ IF( SELF.Diff_orig_expire_date_dd,1,0)+ IF( SELF.Diff_orig_noncdlstatus,1,0)+ IF( SELF.Diff_orig_cdlstatus,1,0)+ IF( SELF.Diff_orig_restrictions,1,0)+ IF( SELF.Diff_orig_origdate,1,0)+ IF( SELF.Diff_orig_origcdldate,1,0)+ IF( SELF.Diff_orig_cancelst,1,0)+ IF( SELF.Diff_orig_canceldate,1,0)+ IF( SELF.Diff_orig_crlf,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_name_first,1,0)+ IF( SELF.Diff_clean_name_middle,1,0)+ IF( SELF.Diff_clean_name_last,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0)+ IF( SELF.Diff_clean_prim_range,1,0)+ IF( SELF.Diff_clean_predir,1,0)+ IF( SELF.Diff_clean_prim_name,1,0)+ IF( SELF.Diff_clean_addr_suffix,1,0)+ IF( SELF.Diff_clean_postdir,1,0)+ IF( SELF.Diff_clean_unit_desig,1,0)+ IF( SELF.Diff_clean_sec_range,1,0)+ IF( SELF.Diff_clean_p_city_name,1,0)+ IF( SELF.Diff_clean_v_city_name,1,0)+ IF( SELF.Diff_clean_st,1,0)+ IF( SELF.Diff_clean_zip,1,0)+ IF( SELF.Diff_clean_zip4,1,0)+ IF( SELF.Diff_clean_cart,1,0)+ IF( SELF.Diff_clean_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_lot,1,0)+ IF( SELF.Diff_clean_lot_order,1,0)+ IF( SELF.Diff_clean_dpbc,1,0)+ IF( SELF.Diff_clean_chk_digit,1,0)+ IF( SELF.Diff_clean_record_type,1,0)+ IF( SELF.Diff_clean_ace_fips_st,1,0)+ IF( SELF.Diff_clean_fipscounty,1,0)+ IF( SELF.Diff_clean_geo_lat,1,0)+ IF( SELF.Diff_clean_geo_long,1,0)+ IF( SELF.Diff_clean_msa,1,0)+ IF( SELF.Diff_clean_geo_blk,1,0)+ IF( SELF.Diff_clean_geo_match,1,0)+ IF( SELF.Diff_clean_err_stat,1,0);
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
    Count_Diff_append_process_date := COUNT(GROUP,%Closest%.Diff_append_process_date);
    Count_Diff_orig_dlstate := COUNT(GROUP,%Closest%.Diff_orig_dlstate);
    Count_Diff_orig_dlnumber := COUNT(GROUP,%Closest%.Diff_orig_dlnumber);
    Count_Diff_orig_name := COUNT(GROUP,%Closest%.Diff_orig_name);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_sex := COUNT(GROUP,%Closest%.Diff_orig_sex);
    Count_Diff_orig_height1 := COUNT(GROUP,%Closest%.Diff_orig_height1);
    Count_Diff_orig_height2 := COUNT(GROUP,%Closest%.Diff_orig_height2);
    Count_Diff_orig_eye_color := COUNT(GROUP,%Closest%.Diff_orig_eye_color);
    Count_Diff_orig_mailaddress := COUNT(GROUP,%Closest%.Diff_orig_mailaddress);
    Count_Diff_orig_classification := COUNT(GROUP,%Closest%.Diff_orig_classification);
    Count_Diff_orig_endorsements := COUNT(GROUP,%Closest%.Diff_orig_endorsements);
    Count_Diff_orig_issue_date := COUNT(GROUP,%Closest%.Diff_orig_issue_date);
    Count_Diff_orig_issue_date_dd := COUNT(GROUP,%Closest%.Diff_orig_issue_date_dd);
    Count_Diff_orig_expire_date := COUNT(GROUP,%Closest%.Diff_orig_expire_date);
    Count_Diff_orig_expire_date_dd := COUNT(GROUP,%Closest%.Diff_orig_expire_date_dd);
    Count_Diff_orig_noncdlstatus := COUNT(GROUP,%Closest%.Diff_orig_noncdlstatus);
    Count_Diff_orig_cdlstatus := COUNT(GROUP,%Closest%.Diff_orig_cdlstatus);
    Count_Diff_orig_restrictions := COUNT(GROUP,%Closest%.Diff_orig_restrictions);
    Count_Diff_orig_origdate := COUNT(GROUP,%Closest%.Diff_orig_origdate);
    Count_Diff_orig_origcdldate := COUNT(GROUP,%Closest%.Diff_orig_origcdldate);
    Count_Diff_orig_cancelst := COUNT(GROUP,%Closest%.Diff_orig_cancelst);
    Count_Diff_orig_canceldate := COUNT(GROUP,%Closest%.Diff_orig_canceldate);
    Count_Diff_orig_crlf := COUNT(GROUP,%Closest%.Diff_orig_crlf);
    Count_Diff_clean_name_prefix := COUNT(GROUP,%Closest%.Diff_clean_name_prefix);
    Count_Diff_clean_name_first := COUNT(GROUP,%Closest%.Diff_clean_name_first);
    Count_Diff_clean_name_middle := COUNT(GROUP,%Closest%.Diff_clean_name_middle);
    Count_Diff_clean_name_last := COUNT(GROUP,%Closest%.Diff_clean_name_last);
    Count_Diff_clean_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_name_suffix);
    Count_Diff_clean_name_score := COUNT(GROUP,%Closest%.Diff_clean_name_score);
    Count_Diff_clean_prim_range := COUNT(GROUP,%Closest%.Diff_clean_prim_range);
    Count_Diff_clean_predir := COUNT(GROUP,%Closest%.Diff_clean_predir);
    Count_Diff_clean_prim_name := COUNT(GROUP,%Closest%.Diff_clean_prim_name);
    Count_Diff_clean_addr_suffix := COUNT(GROUP,%Closest%.Diff_clean_addr_suffix);
    Count_Diff_clean_postdir := COUNT(GROUP,%Closest%.Diff_clean_postdir);
    Count_Diff_clean_unit_desig := COUNT(GROUP,%Closest%.Diff_clean_unit_desig);
    Count_Diff_clean_sec_range := COUNT(GROUP,%Closest%.Diff_clean_sec_range);
    Count_Diff_clean_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_p_city_name);
    Count_Diff_clean_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_v_city_name);
    Count_Diff_clean_st := COUNT(GROUP,%Closest%.Diff_clean_st);
    Count_Diff_clean_zip := COUNT(GROUP,%Closest%.Diff_clean_zip);
    Count_Diff_clean_zip4 := COUNT(GROUP,%Closest%.Diff_clean_zip4);
    Count_Diff_clean_cart := COUNT(GROUP,%Closest%.Diff_clean_cart);
    Count_Diff_clean_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_clean_cr_sort_sz);
    Count_Diff_clean_lot := COUNT(GROUP,%Closest%.Diff_clean_lot);
    Count_Diff_clean_lot_order := COUNT(GROUP,%Closest%.Diff_clean_lot_order);
    Count_Diff_clean_dpbc := COUNT(GROUP,%Closest%.Diff_clean_dpbc);
    Count_Diff_clean_chk_digit := COUNT(GROUP,%Closest%.Diff_clean_chk_digit);
    Count_Diff_clean_record_type := COUNT(GROUP,%Closest%.Diff_clean_record_type);
    Count_Diff_clean_ace_fips_st := COUNT(GROUP,%Closest%.Diff_clean_ace_fips_st);
    Count_Diff_clean_fipscounty := COUNT(GROUP,%Closest%.Diff_clean_fipscounty);
    Count_Diff_clean_geo_lat := COUNT(GROUP,%Closest%.Diff_clean_geo_lat);
    Count_Diff_clean_geo_long := COUNT(GROUP,%Closest%.Diff_clean_geo_long);
    Count_Diff_clean_msa := COUNT(GROUP,%Closest%.Diff_clean_msa);
    Count_Diff_clean_geo_blk := COUNT(GROUP,%Closest%.Diff_clean_geo_blk);
    Count_Diff_clean_geo_match := COUNT(GROUP,%Closest%.Diff_clean_geo_match);
    Count_Diff_clean_err_stat := COUNT(GROUP,%Closest%.Diff_clean_err_stat);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
