IMPORT SALT38;
IMPORT Scrubs_DL_ME_MEDCERT,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 79;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_Past_Date','invalid_General_Date','invalid_process_date','invalid_orig_credential_type','invalid_orig_lname','invalid_orig_fname','invalid_Alpha','invalid_mandatory','invalid_orig_state','invalid_orig_zip','invalid_zip5','invalid_zip4','invalid_boolean','invalid_orig_sex','invalid_Num','invalid_orig_hair','invalid_orig_eyes','invalid_orig_dlstat','invalid_orig_dlclass','invalid_Alpha_Numeric','invalid_orig_endorsements','invalid_orig_comm_driv_status','invalid_clean_name_first','invalid_clean_name_middle','invalid_clean_name_last','invalid_clean_cart','invalid_clean_lot','invalid_clean_lot_order','invalid_clean_dpbc','invalid_clean_chk_digit','invalid_clean_fips_state','invalid_clean_fips_county','invalid_clean_geo','invalid_clean_msa','invalid_clean_geo_match','invalid_clean_err_stat');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_Past_Date' => 1,'invalid_General_Date' => 2,'invalid_process_date' => 3,'invalid_orig_credential_type' => 4,'invalid_orig_lname' => 5,'invalid_orig_fname' => 6,'invalid_Alpha' => 7,'invalid_mandatory' => 8,'invalid_orig_state' => 9,'invalid_orig_zip' => 10,'invalid_zip5' => 11,'invalid_zip4' => 12,'invalid_boolean' => 13,'invalid_orig_sex' => 14,'invalid_Num' => 15,'invalid_orig_hair' => 16,'invalid_orig_eyes' => 17,'invalid_orig_dlstat' => 18,'invalid_orig_dlclass' => 19,'invalid_Alpha_Numeric' => 20,'invalid_orig_endorsements' => 21,'invalid_orig_comm_driv_status' => 22,'invalid_clean_name_first' => 23,'invalid_clean_name_middle' => 24,'invalid_clean_name_last' => 25,'invalid_clean_cart' => 26,'invalid_clean_lot' => 27,'invalid_clean_lot_order' => 28,'invalid_clean_dpbc' => 29,'invalid_clean_chk_digit' => 30,'invalid_clean_fips_state' => 31,'invalid_clean_fips_county' => 32,'invalid_clean_geo' => 33,'invalid_clean_msa' => 34,'invalid_clean_geo_match' => 35,'invalid_clean_err_stat' => 36,0);
 
EXPORT MakeFT_invalid_Past_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Past_Date(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_valid_past_date(s)>0);
EXPORT InValidMessageFT_invalid_Past_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_valid_past_date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_General_Date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_General_Date(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_valid_general_Date(s)>0);
EXPORT InValidMessageFT_invalid_General_Date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_valid_general_Date'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_process_date(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_process_date(SALT38.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_process_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_credential_type(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'DIL|DLP|DTL|SID|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_credential_type(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'DIL|DLP|DTL|SID|'))));
EXPORT InValidMessageFT_invalid_orig_credential_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('DIL|DLP|DTL|SID|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_lname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_lname(SALT38.StrType s,SALT38.StrType orig_fname) := WHICH(~Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names(s,orig_fname)>0);
EXPORT InValidMessageFT_invalid_orig_lname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_fname(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_fname(SALT38.StrType s,SALT38.StrType orig_lname) := WHICH(~Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names(s,orig_lname)>0);
EXPORT InValidMessageFT_invalid_orig_fname(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Alpha(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Alpha(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_alpha(s)>0);
EXPORT InValidMessageFT_invalid_Alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_alpha'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_chk_blanks(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_chk_blanks'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_state(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_orig_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_zip(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_zip(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_full_zip(s)>0);
EXPORT InValidMessageFT_invalid_orig_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_full_zip'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_verify_zip5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_verify_zip4'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'N|Y|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_boolean(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'N|Y|'))));
EXPORT InValidMessageFT_invalid_boolean(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('N|Y|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_sex(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'F|M|U|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_sex(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'F|M|U|'))));
EXPORT InValidMessageFT_invalid_orig_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('F|M|U|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Num(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Num(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_Num(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_hair(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'AU|BD|BK|BR|BT|GY|RD|WH|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_hair(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'AU|BD|BK|BR|BT|GY|RD|WH|'))));
EXPORT InValidMessageFT_invalid_orig_hair(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('AU|BD|BK|BR|BT|GY|RD|WH|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_eyes(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'BK|BL|BR|DB|DI|DG|DH|GR|GY|HB|HG|HH|HZ|PK|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_eyes(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'BK|BL|BR|DB|DI|DG|DH|GR|GY|HB|HG|HH|HZ|PK|'))));
EXPORT InValidMessageFT_invalid_orig_eyes(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('BK|BL|BR|DB|DI|DG|DH|GR|GY|HB|HG|HH|HZ|PK|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_dlstat(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'A|C|D|I|R|S|V|X|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_dlstat(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'A|C|D|I|R|S|V|X|'))));
EXPORT InValidMessageFT_invalid_orig_dlstat(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('A|C|D|I|R|S|V|X|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_dlclass(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'1|2|3|A|B|C|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_dlclass(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'1|2|3|A|B|C|'))));
EXPORT InValidMessageFT_invalid_orig_dlclass(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('1|2|3|A|B|C|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Alpha_Numeric(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_Alpha_Numeric(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_alphanumeric(s)>0);
EXPORT InValidMessageFT_invalid_Alpha_Numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_endorsements(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'2|3|H|I|J|K|L|N|P|S|T|X|Y|Z|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_endorsements(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'2|3|H|I|J|K|L|N|P|S|T|X|Y|Z|'))));
EXPORT InValidMessageFT_invalid_orig_endorsements(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('2|3|H|I|J|K|L|N|P|S|T|X|Y|Z|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_comm_driv_status(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'A|B|C|D|E|F|G|H|I|K|L|M|N|O|P|R|S|T|U|V|W|X|Y|'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_orig_comm_driv_status(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'A|B|C|D|E|F|G|H|I|K|L|M|N|O|P|R|S|T|U|V|W|X|Y|'))));
EXPORT InValidMessageFT_invalid_orig_comm_driv_status(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('A|B|C|D|E|F|G|H|I|K|L|M|N|O|P|R|S|T|U|V|W|X|Y|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name_first(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name_first(SALT38.StrType s,SALT38.StrType clean_name_middle,SALT38.StrType Clean_name_last) := WHICH(~Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names(s,clean_name_middle,Clean_name_last)>0);
EXPORT InValidMessageFT_invalid_clean_name_first(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name_middle(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name_middle(SALT38.StrType s,SALT38.StrType clean_name_first,SALT38.StrType Clean_name_last) := WHICH(~Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names(s,clean_name_first,Clean_name_last)>0);
EXPORT InValidMessageFT_invalid_clean_name_middle(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name_last(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name_last(SALT38.StrType s,SALT38.StrType clean_name_first,SALT38.StrType clean_name_middle) := WHICH(~Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names(s,clean_name_first,clean_name_middle)>0);
EXPORT InValidMessageFT_invalid_clean_name_last(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_cart(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_cart(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_alphanumeric(s,4)>0);
EXPORT InValidMessageFT_invalid_clean_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_lot(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_lot(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_clean_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_lot_order(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_lot_order(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_invalid_clean_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|D|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_dpbc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_dpbc(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_clean_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_chk_digit(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_chk_digit(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_clean_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_fips_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_fips_state(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_clean_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_fips_county(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_fips_county(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_clean_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_geo(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_geo(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_invalid_clean_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_geo_coord'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_msa(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_msa(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_clean_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_geo_match(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_geo_match(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_clean_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_err_stat(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_err_stat(SALT38.StrType s) := WHICH(~Scrubs_DL_ME_MEDCERT.Functions.fn_alphanumeric(s,4)>0);
EXPORT InValidMessageFT_invalid_clean_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_DL_ME_MEDCERT.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','orig_dob','orig_credential_type','orig_id_terminal_date','orig_lname','orig_fname','orig_mi','orig_namesuf','orig_street','orig_city','orig_state','orig_zip','orig_drivered','orig_sex','orig_height','orig_height2','orig_weight','orig_hair','orig_eyes','orig_dlexpiredate','orig_dlstat','orig_dlissuedate','orig_originalissuedate','orig_regstatfr','orig_regstatcr','orig_dlclass','orig_historynum','orig_disabledvet','orig_photo','orig_habitualoffender','orig_restrictions','orig_endorsements','orig_endorsements2','orig_endorsements3','orig_endorsements4','orig_endorsements5','orig_endorsements6','orig_endorsements7','orig_endorsements8','orig_endorsements9','orig_endorsements10','orig_endorsements11_20','orig_comm_driv_status','orig_disabled_vet_type','orig_organ_donor','orig_crlf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','orig_dob','orig_credential_type','orig_id_terminal_date','orig_lname','orig_fname','orig_mi','orig_namesuf','orig_street','orig_city','orig_state','orig_zip','orig_drivered','orig_sex','orig_height','orig_height2','orig_weight','orig_hair','orig_eyes','orig_dlexpiredate','orig_dlstat','orig_dlissuedate','orig_originalissuedate','orig_regstatfr','orig_regstatcr','orig_dlclass','orig_historynum','orig_disabledvet','orig_photo','orig_habitualoffender','orig_restrictions','orig_endorsements','orig_endorsements2','orig_endorsements3','orig_endorsements4','orig_endorsements5','orig_endorsements6','orig_endorsements7','orig_endorsements8','orig_endorsements9','orig_endorsements10','orig_endorsements11_20','orig_comm_driv_status','orig_disabled_vet_type','orig_organ_donor','orig_crlf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'append_process_date' => 0,'orig_dob' => 1,'orig_credential_type' => 2,'orig_id_terminal_date' => 3,'orig_lname' => 4,'orig_fname' => 5,'orig_mi' => 6,'orig_namesuf' => 7,'orig_street' => 8,'orig_city' => 9,'orig_state' => 10,'orig_zip' => 11,'orig_drivered' => 12,'orig_sex' => 13,'orig_height' => 14,'orig_height2' => 15,'orig_weight' => 16,'orig_hair' => 17,'orig_eyes' => 18,'orig_dlexpiredate' => 19,'orig_dlstat' => 20,'orig_dlissuedate' => 21,'orig_originalissuedate' => 22,'orig_regstatfr' => 23,'orig_regstatcr' => 24,'orig_dlclass' => 25,'orig_historynum' => 26,'orig_disabledvet' => 27,'orig_photo' => 28,'orig_habitualoffender' => 29,'orig_restrictions' => 30,'orig_endorsements' => 31,'orig_endorsements2' => 32,'orig_endorsements3' => 33,'orig_endorsements4' => 34,'orig_endorsements5' => 35,'orig_endorsements6' => 36,'orig_endorsements7' => 37,'orig_endorsements8' => 38,'orig_endorsements9' => 39,'orig_endorsements10' => 40,'orig_endorsements11_20' => 41,'orig_comm_driv_status' => 42,'orig_disabled_vet_type' => 43,'orig_organ_donor' => 44,'orig_crlf' => 45,'clean_name_prefix' => 46,'clean_name_first' => 47,'clean_name_middle' => 48,'clean_name_last' => 49,'clean_name_suffix' => 50,'clean_name_score' => 51,'clean_prim_range' => 52,'clean_predir' => 53,'clean_prim_name' => 54,'clean_addr_suffix' => 55,'clean_postdir' => 56,'clean_unit_desig' => 57,'clean_sec_range' => 58,'clean_p_city_name' => 59,'clean_v_city_name' => 60,'clean_st' => 61,'clean_zip' => 62,'clean_zip4' => 63,'clean_cart' => 64,'clean_cr_sort_sz' => 65,'clean_lot' => 66,'clean_lot_order' => 67,'clean_dpbc' => 68,'clean_chk_digit' => 69,'clean_record_type' => 70,'clean_ace_fips_st' => 71,'clean_fipscounty' => 72,'clean_geo_lat' => 73,'clean_geo_long' => 74,'clean_msa' => 75,'clean_geo_blk' => 76,'clean_geo_match' => 77,'clean_err_stat' => 78,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],[],[],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],[],['ALLOW'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],['CUSTOM'],[],[],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_append_process_date(SALT38.StrType s0) := MakeFT_invalid_process_date(s0);
EXPORT InValid_append_process_date(SALT38.StrType s) := InValidFT_invalid_process_date(s);
EXPORT InValidMessage_append_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_process_date(wh);
 
EXPORT Make_orig_dob(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_orig_dob(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_orig_credential_type(SALT38.StrType s0) := MakeFT_invalid_orig_credential_type(s0);
EXPORT InValid_orig_credential_type(SALT38.StrType s) := InValidFT_invalid_orig_credential_type(s);
EXPORT InValidMessage_orig_credential_type(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_credential_type(wh);
 
EXPORT Make_orig_id_terminal_date(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_orig_id_terminal_date(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_orig_id_terminal_date(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_orig_lname(SALT38.StrType s0) := MakeFT_invalid_orig_lname(s0);
EXPORT InValid_orig_lname(SALT38.StrType s,SALT38.StrType orig_fname) := InValidFT_invalid_orig_lname(s,orig_fname);
EXPORT InValidMessage_orig_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_lname(wh);
 
EXPORT Make_orig_fname(SALT38.StrType s0) := MakeFT_invalid_orig_fname(s0);
EXPORT InValid_orig_fname(SALT38.StrType s,SALT38.StrType orig_lname) := InValidFT_invalid_orig_fname(s,orig_lname);
EXPORT InValidMessage_orig_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_fname(wh);
 
EXPORT Make_orig_mi(SALT38.StrType s0) := MakeFT_invalid_Alpha(s0);
EXPORT InValid_orig_mi(SALT38.StrType s) := InValidFT_invalid_Alpha(s);
EXPORT InValidMessage_orig_mi(UNSIGNED1 wh) := InValidMessageFT_invalid_Alpha(wh);
 
EXPORT Make_orig_namesuf(SALT38.StrType s0) := s0;
EXPORT InValid_orig_namesuf(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_namesuf(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_street(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_street(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_street(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_city(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_city(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orig_state(SALT38.StrType s0) := MakeFT_invalid_orig_state(s0);
EXPORT InValid_orig_state(SALT38.StrType s) := InValidFT_invalid_orig_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_state(wh);
 
EXPORT Make_orig_zip(SALT38.StrType s0) := MakeFT_invalid_orig_zip(s0);
EXPORT InValid_orig_zip(SALT38.StrType s) := InValidFT_invalid_orig_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_zip(wh);
 
EXPORT Make_orig_drivered(SALT38.StrType s0) := s0;
EXPORT InValid_orig_drivered(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_drivered(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_sex(SALT38.StrType s0) := MakeFT_invalid_orig_sex(s0);
EXPORT InValid_orig_sex(SALT38.StrType s) := InValidFT_invalid_orig_sex(s);
EXPORT InValidMessage_orig_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_sex(wh);
 
EXPORT Make_orig_height(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_orig_height(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_orig_height(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);
 
EXPORT Make_orig_height2(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_orig_height2(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_orig_height2(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);
 
EXPORT Make_orig_weight(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_orig_weight(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_orig_weight(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);
 
EXPORT Make_orig_hair(SALT38.StrType s0) := MakeFT_invalid_orig_hair(s0);
EXPORT InValid_orig_hair(SALT38.StrType s) := InValidFT_invalid_orig_hair(s);
EXPORT InValidMessage_orig_hair(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_hair(wh);
 
EXPORT Make_orig_eyes(SALT38.StrType s0) := MakeFT_invalid_orig_eyes(s0);
EXPORT InValid_orig_eyes(SALT38.StrType s) := InValidFT_invalid_orig_eyes(s);
EXPORT InValidMessage_orig_eyes(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_eyes(wh);
 
EXPORT Make_orig_dlexpiredate(SALT38.StrType s0) := MakeFT_invalid_General_Date(s0);
EXPORT InValid_orig_dlexpiredate(SALT38.StrType s) := InValidFT_invalid_General_Date(s);
EXPORT InValidMessage_orig_dlexpiredate(UNSIGNED1 wh) := InValidMessageFT_invalid_General_Date(wh);
 
EXPORT Make_orig_dlstat(SALT38.StrType s0) := MakeFT_invalid_orig_dlstat(s0);
EXPORT InValid_orig_dlstat(SALT38.StrType s) := InValidFT_invalid_orig_dlstat(s);
EXPORT InValidMessage_orig_dlstat(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_dlstat(wh);
 
EXPORT Make_orig_dlissuedate(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_orig_dlissuedate(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_orig_dlissuedate(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_orig_originalissuedate(SALT38.StrType s0) := MakeFT_invalid_Past_Date(s0);
EXPORT InValid_orig_originalissuedate(SALT38.StrType s) := InValidFT_invalid_Past_Date(s);
EXPORT InValidMessage_orig_originalissuedate(UNSIGNED1 wh) := InValidMessageFT_invalid_Past_Date(wh);
 
EXPORT Make_orig_regstatfr(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_orig_regstatfr(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_orig_regstatfr(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_orig_regstatcr(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_orig_regstatcr(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_orig_regstatcr(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_orig_dlclass(SALT38.StrType s0) := MakeFT_invalid_orig_dlclass(s0);
EXPORT InValid_orig_dlclass(SALT38.StrType s) := InValidFT_invalid_orig_dlclass(s);
EXPORT InValidMessage_orig_dlclass(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_dlclass(wh);
 
EXPORT Make_orig_historynum(SALT38.StrType s0) := MakeFT_invalid_Num(s0);
EXPORT InValid_orig_historynum(SALT38.StrType s) := InValidFT_invalid_Num(s);
EXPORT InValidMessage_orig_historynum(UNSIGNED1 wh) := InValidMessageFT_invalid_Num(wh);
 
EXPORT Make_orig_disabledvet(SALT38.StrType s0) := s0;
EXPORT InValid_orig_disabledvet(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_disabledvet(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_photo(SALT38.StrType s0) := s0;
EXPORT InValid_orig_photo(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_photo(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_habitualoffender(SALT38.StrType s0) := s0;
EXPORT InValid_orig_habitualoffender(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_habitualoffender(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_restrictions(SALT38.StrType s0) := MakeFT_invalid_Alpha_Numeric(s0);
EXPORT InValid_orig_restrictions(SALT38.StrType s) := InValidFT_invalid_Alpha_Numeric(s);
EXPORT InValidMessage_orig_restrictions(UNSIGNED1 wh) := InValidMessageFT_invalid_Alpha_Numeric(wh);
 
EXPORT Make_orig_endorsements(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements2(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements2(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements2(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements3(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements3(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements3(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements4(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements4(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements4(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements5(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements5(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements5(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements6(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements6(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements6(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements7(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements7(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements7(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements8(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements8(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements8(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements9(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements9(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements9(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements10(SALT38.StrType s0) := MakeFT_invalid_orig_endorsements(s0);
EXPORT InValid_orig_endorsements10(SALT38.StrType s) := InValidFT_invalid_orig_endorsements(s);
EXPORT InValidMessage_orig_endorsements10(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_endorsements(wh);
 
EXPORT Make_orig_endorsements11_20(SALT38.StrType s0) := s0;
EXPORT InValid_orig_endorsements11_20(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_endorsements11_20(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_comm_driv_status(SALT38.StrType s0) := MakeFT_invalid_orig_comm_driv_status(s0);
EXPORT InValid_orig_comm_driv_status(SALT38.StrType s) := InValidFT_invalid_orig_comm_driv_status(s);
EXPORT InValidMessage_orig_comm_driv_status(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_comm_driv_status(wh);
 
EXPORT Make_orig_disabled_vet_type(SALT38.StrType s0) := s0;
EXPORT InValid_orig_disabled_vet_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_disabled_vet_type(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_organ_donor(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_orig_organ_donor(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_orig_organ_donor(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_orig_crlf(SALT38.StrType s0) := s0;
EXPORT InValid_orig_crlf(SALT38.StrType s) := 0;
EXPORT InValidMessage_orig_crlf(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_prefix(SALT38.StrType s0) := s0;
EXPORT InValid_clean_name_prefix(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_name_prefix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_first(SALT38.StrType s0) := MakeFT_invalid_clean_name_first(s0);
EXPORT InValid_clean_name_first(SALT38.StrType s,SALT38.StrType clean_name_middle,SALT38.StrType Clean_name_last) := InValidFT_invalid_clean_name_first(s,clean_name_middle,Clean_name_last);
EXPORT InValidMessage_clean_name_first(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name_first(wh);
 
EXPORT Make_clean_name_middle(SALT38.StrType s0) := MakeFT_invalid_clean_name_middle(s0);
EXPORT InValid_clean_name_middle(SALT38.StrType s,SALT38.StrType clean_name_first,SALT38.StrType Clean_name_last) := InValidFT_invalid_clean_name_middle(s,clean_name_first,Clean_name_last);
EXPORT InValidMessage_clean_name_middle(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name_middle(wh);
 
EXPORT Make_clean_name_last(SALT38.StrType s0) := MakeFT_invalid_clean_name_last(s0);
EXPORT InValid_clean_name_last(SALT38.StrType s,SALT38.StrType clean_name_first,SALT38.StrType clean_name_middle) := InValidFT_invalid_clean_name_last(s,clean_name_first,clean_name_middle);
EXPORT InValidMessage_clean_name_last(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name_last(wh);
 
EXPORT Make_clean_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_clean_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_score(SALT38.StrType s0) := s0;
EXPORT InValid_clean_name_score(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_clean_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_predir(SALT38.StrType s0) := s0;
EXPORT InValid_clean_predir(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_prim_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_prim_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_addr_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_clean_addr_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_postdir(SALT38.StrType s0) := s0;
EXPORT InValid_clean_postdir(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_unit_desig(SALT38.StrType s0) := s0;
EXPORT InValid_clean_unit_desig(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_clean_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_p_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_p_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_v_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_v_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_st(SALT38.StrType s0) := MakeFT_invalid_orig_state(s0);
EXPORT InValid_clean_st(SALT38.StrType s) := InValidFT_invalid_orig_state(s);
EXPORT InValidMessage_clean_st(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_state(wh);
 
EXPORT Make_clean_zip(SALT38.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_clean_zip(SALT38.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_clean_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_clean_zip4(SALT38.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_clean_zip4(SALT38.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_clean_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_clean_cart(SALT38.StrType s0) := MakeFT_invalid_clean_cart(s0);
EXPORT InValid_clean_cart(SALT38.StrType s) := InValidFT_invalid_clean_cart(s);
EXPORT InValidMessage_clean_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_cart(wh);
 
EXPORT Make_clean_cr_sort_sz(SALT38.StrType s0) := s0;
EXPORT InValid_clean_cr_sort_sz(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_lot(SALT38.StrType s0) := MakeFT_invalid_clean_lot(s0);
EXPORT InValid_clean_lot(SALT38.StrType s) := InValidFT_invalid_clean_lot(s);
EXPORT InValidMessage_clean_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_lot(wh);
 
EXPORT Make_clean_lot_order(SALT38.StrType s0) := MakeFT_invalid_clean_lot_order(s0);
EXPORT InValid_clean_lot_order(SALT38.StrType s) := InValidFT_invalid_clean_lot_order(s);
EXPORT InValidMessage_clean_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_lot_order(wh);
 
EXPORT Make_clean_dpbc(SALT38.StrType s0) := MakeFT_invalid_clean_dpbc(s0);
EXPORT InValid_clean_dpbc(SALT38.StrType s) := InValidFT_invalid_clean_dpbc(s);
EXPORT InValidMessage_clean_dpbc(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_dpbc(wh);
 
EXPORT Make_clean_chk_digit(SALT38.StrType s0) := MakeFT_invalid_clean_chk_digit(s0);
EXPORT InValid_clean_chk_digit(SALT38.StrType s) := InValidFT_invalid_clean_chk_digit(s);
EXPORT InValidMessage_clean_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_chk_digit(wh);
 
EXPORT Make_clean_record_type(SALT38.StrType s0) := s0;
EXPORT InValid_clean_record_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_ace_fips_st(SALT38.StrType s0) := MakeFT_invalid_clean_fips_state(s0);
EXPORT InValid_clean_ace_fips_st(SALT38.StrType s) := InValidFT_invalid_clean_fips_state(s);
EXPORT InValidMessage_clean_ace_fips_st(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_fips_state(wh);
 
EXPORT Make_clean_fipscounty(SALT38.StrType s0) := MakeFT_invalid_clean_fips_county(s0);
EXPORT InValid_clean_fipscounty(SALT38.StrType s) := InValidFT_invalid_clean_fips_county(s);
EXPORT InValidMessage_clean_fipscounty(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_fips_county(wh);
 
EXPORT Make_clean_geo_lat(SALT38.StrType s0) := MakeFT_invalid_clean_geo(s0);
EXPORT InValid_clean_geo_lat(SALT38.StrType s) := InValidFT_invalid_clean_geo(s);
EXPORT InValidMessage_clean_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_geo(wh);
 
EXPORT Make_clean_geo_long(SALT38.StrType s0) := MakeFT_invalid_clean_geo(s0);
EXPORT InValid_clean_geo_long(SALT38.StrType s) := InValidFT_invalid_clean_geo(s);
EXPORT InValidMessage_clean_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_geo(wh);
 
EXPORT Make_clean_msa(SALT38.StrType s0) := MakeFT_invalid_clean_msa(s0);
EXPORT InValid_clean_msa(SALT38.StrType s) := InValidFT_invalid_clean_msa(s);
EXPORT InValidMessage_clean_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_msa(wh);
 
EXPORT Make_clean_geo_blk(SALT38.StrType s0) := s0;
EXPORT InValid_clean_geo_blk(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_geo_match(SALT38.StrType s0) := MakeFT_invalid_clean_geo_match(s0);
EXPORT InValid_clean_geo_match(SALT38.StrType s) := InValidFT_invalid_clean_geo_match(s);
EXPORT InValidMessage_clean_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_geo_match(wh);
 
EXPORT Make_clean_err_stat(SALT38.StrType s0) := MakeFT_invalid_clean_err_stat(s0);
EXPORT InValid_clean_err_stat(SALT38.StrType s) := InValidFT_invalid_clean_err_stat(s);
EXPORT InValidMessage_clean_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_err_stat(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_DL_ME_MEDCERT;
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
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_credential_type;
    BOOLEAN Diff_orig_id_terminal_date;
    BOOLEAN Diff_orig_lname;
    BOOLEAN Diff_orig_fname;
    BOOLEAN Diff_orig_mi;
    BOOLEAN Diff_orig_namesuf;
    BOOLEAN Diff_orig_street;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_drivered;
    BOOLEAN Diff_orig_sex;
    BOOLEAN Diff_orig_height;
    BOOLEAN Diff_orig_height2;
    BOOLEAN Diff_orig_weight;
    BOOLEAN Diff_orig_hair;
    BOOLEAN Diff_orig_eyes;
    BOOLEAN Diff_orig_dlexpiredate;
    BOOLEAN Diff_orig_dlstat;
    BOOLEAN Diff_orig_dlissuedate;
    BOOLEAN Diff_orig_originalissuedate;
    BOOLEAN Diff_orig_regstatfr;
    BOOLEAN Diff_orig_regstatcr;
    BOOLEAN Diff_orig_dlclass;
    BOOLEAN Diff_orig_historynum;
    BOOLEAN Diff_orig_disabledvet;
    BOOLEAN Diff_orig_photo;
    BOOLEAN Diff_orig_habitualoffender;
    BOOLEAN Diff_orig_restrictions;
    BOOLEAN Diff_orig_endorsements;
    BOOLEAN Diff_orig_endorsements2;
    BOOLEAN Diff_orig_endorsements3;
    BOOLEAN Diff_orig_endorsements4;
    BOOLEAN Diff_orig_endorsements5;
    BOOLEAN Diff_orig_endorsements6;
    BOOLEAN Diff_orig_endorsements7;
    BOOLEAN Diff_orig_endorsements8;
    BOOLEAN Diff_orig_endorsements9;
    BOOLEAN Diff_orig_endorsements10;
    BOOLEAN Diff_orig_endorsements11_20;
    BOOLEAN Diff_orig_comm_driv_status;
    BOOLEAN Diff_orig_disabled_vet_type;
    BOOLEAN Diff_orig_organ_donor;
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
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_process_date := le.append_process_date <> ri.append_process_date;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_credential_type := le.orig_credential_type <> ri.orig_credential_type;
    SELF.Diff_orig_id_terminal_date := le.orig_id_terminal_date <> ri.orig_id_terminal_date;
    SELF.Diff_orig_lname := le.orig_lname <> ri.orig_lname;
    SELF.Diff_orig_fname := le.orig_fname <> ri.orig_fname;
    SELF.Diff_orig_mi := le.orig_mi <> ri.orig_mi;
    SELF.Diff_orig_namesuf := le.orig_namesuf <> ri.orig_namesuf;
    SELF.Diff_orig_street := le.orig_street <> ri.orig_street;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_drivered := le.orig_drivered <> ri.orig_drivered;
    SELF.Diff_orig_sex := le.orig_sex <> ri.orig_sex;
    SELF.Diff_orig_height := le.orig_height <> ri.orig_height;
    SELF.Diff_orig_height2 := le.orig_height2 <> ri.orig_height2;
    SELF.Diff_orig_weight := le.orig_weight <> ri.orig_weight;
    SELF.Diff_orig_hair := le.orig_hair <> ri.orig_hair;
    SELF.Diff_orig_eyes := le.orig_eyes <> ri.orig_eyes;
    SELF.Diff_orig_dlexpiredate := le.orig_dlexpiredate <> ri.orig_dlexpiredate;
    SELF.Diff_orig_dlstat := le.orig_dlstat <> ri.orig_dlstat;
    SELF.Diff_orig_dlissuedate := le.orig_dlissuedate <> ri.orig_dlissuedate;
    SELF.Diff_orig_originalissuedate := le.orig_originalissuedate <> ri.orig_originalissuedate;
    SELF.Diff_orig_regstatfr := le.orig_regstatfr <> ri.orig_regstatfr;
    SELF.Diff_orig_regstatcr := le.orig_regstatcr <> ri.orig_regstatcr;
    SELF.Diff_orig_dlclass := le.orig_dlclass <> ri.orig_dlclass;
    SELF.Diff_orig_historynum := le.orig_historynum <> ri.orig_historynum;
    SELF.Diff_orig_disabledvet := le.orig_disabledvet <> ri.orig_disabledvet;
    SELF.Diff_orig_photo := le.orig_photo <> ri.orig_photo;
    SELF.Diff_orig_habitualoffender := le.orig_habitualoffender <> ri.orig_habitualoffender;
    SELF.Diff_orig_restrictions := le.orig_restrictions <> ri.orig_restrictions;
    SELF.Diff_orig_endorsements := le.orig_endorsements <> ri.orig_endorsements;
    SELF.Diff_orig_endorsements2 := le.orig_endorsements2 <> ri.orig_endorsements2;
    SELF.Diff_orig_endorsements3 := le.orig_endorsements3 <> ri.orig_endorsements3;
    SELF.Diff_orig_endorsements4 := le.orig_endorsements4 <> ri.orig_endorsements4;
    SELF.Diff_orig_endorsements5 := le.orig_endorsements5 <> ri.orig_endorsements5;
    SELF.Diff_orig_endorsements6 := le.orig_endorsements6 <> ri.orig_endorsements6;
    SELF.Diff_orig_endorsements7 := le.orig_endorsements7 <> ri.orig_endorsements7;
    SELF.Diff_orig_endorsements8 := le.orig_endorsements8 <> ri.orig_endorsements8;
    SELF.Diff_orig_endorsements9 := le.orig_endorsements9 <> ri.orig_endorsements9;
    SELF.Diff_orig_endorsements10 := le.orig_endorsements10 <> ri.orig_endorsements10;
    SELF.Diff_orig_endorsements11_20 := le.orig_endorsements11_20 <> ri.orig_endorsements11_20;
    SELF.Diff_orig_comm_driv_status := le.orig_comm_driv_status <> ri.orig_comm_driv_status;
    SELF.Diff_orig_disabled_vet_type := le.orig_disabled_vet_type <> ri.orig_disabled_vet_type;
    SELF.Diff_orig_organ_donor := le.orig_organ_donor <> ri.orig_organ_donor;
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
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_process_date,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_credential_type,1,0)+ IF( SELF.Diff_orig_id_terminal_date,1,0)+ IF( SELF.Diff_orig_lname,1,0)+ IF( SELF.Diff_orig_fname,1,0)+ IF( SELF.Diff_orig_mi,1,0)+ IF( SELF.Diff_orig_namesuf,1,0)+ IF( SELF.Diff_orig_street,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_drivered,1,0)+ IF( SELF.Diff_orig_sex,1,0)+ IF( SELF.Diff_orig_height,1,0)+ IF( SELF.Diff_orig_height2,1,0)+ IF( SELF.Diff_orig_weight,1,0)+ IF( SELF.Diff_orig_hair,1,0)+ IF( SELF.Diff_orig_eyes,1,0)+ IF( SELF.Diff_orig_dlexpiredate,1,0)+ IF( SELF.Diff_orig_dlstat,1,0)+ IF( SELF.Diff_orig_dlissuedate,1,0)+ IF( SELF.Diff_orig_originalissuedate,1,0)+ IF( SELF.Diff_orig_regstatfr,1,0)+ IF( SELF.Diff_orig_regstatcr,1,0)+ IF( SELF.Diff_orig_dlclass,1,0)+ IF( SELF.Diff_orig_historynum,1,0)+ IF( SELF.Diff_orig_disabledvet,1,0)+ IF( SELF.Diff_orig_photo,1,0)+ IF( SELF.Diff_orig_habitualoffender,1,0)+ IF( SELF.Diff_orig_restrictions,1,0)+ IF( SELF.Diff_orig_endorsements,1,0)+ IF( SELF.Diff_orig_endorsements2,1,0)+ IF( SELF.Diff_orig_endorsements3,1,0)+ IF( SELF.Diff_orig_endorsements4,1,0)+ IF( SELF.Diff_orig_endorsements5,1,0)+ IF( SELF.Diff_orig_endorsements6,1,0)+ IF( SELF.Diff_orig_endorsements7,1,0)+ IF( SELF.Diff_orig_endorsements8,1,0)+ IF( SELF.Diff_orig_endorsements9,1,0)+ IF( SELF.Diff_orig_endorsements10,1,0)+ IF( SELF.Diff_orig_endorsements11_20,1,0)+ IF( SELF.Diff_orig_comm_driv_status,1,0)+ IF( SELF.Diff_orig_disabled_vet_type,1,0)+ IF( SELF.Diff_orig_organ_donor,1,0)+ IF( SELF.Diff_orig_crlf,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_name_first,1,0)+ IF( SELF.Diff_clean_name_middle,1,0)+ IF( SELF.Diff_clean_name_last,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0)+ IF( SELF.Diff_clean_prim_range,1,0)+ IF( SELF.Diff_clean_predir,1,0)+ IF( SELF.Diff_clean_prim_name,1,0)+ IF( SELF.Diff_clean_addr_suffix,1,0)+ IF( SELF.Diff_clean_postdir,1,0)+ IF( SELF.Diff_clean_unit_desig,1,0)+ IF( SELF.Diff_clean_sec_range,1,0)+ IF( SELF.Diff_clean_p_city_name,1,0)+ IF( SELF.Diff_clean_v_city_name,1,0)+ IF( SELF.Diff_clean_st,1,0)+ IF( SELF.Diff_clean_zip,1,0)+ IF( SELF.Diff_clean_zip4,1,0)+ IF( SELF.Diff_clean_cart,1,0)+ IF( SELF.Diff_clean_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_lot,1,0)+ IF( SELF.Diff_clean_lot_order,1,0)+ IF( SELF.Diff_clean_dpbc,1,0)+ IF( SELF.Diff_clean_chk_digit,1,0)+ IF( SELF.Diff_clean_record_type,1,0)+ IF( SELF.Diff_clean_ace_fips_st,1,0)+ IF( SELF.Diff_clean_fipscounty,1,0)+ IF( SELF.Diff_clean_geo_lat,1,0)+ IF( SELF.Diff_clean_geo_long,1,0)+ IF( SELF.Diff_clean_msa,1,0)+ IF( SELF.Diff_clean_geo_blk,1,0)+ IF( SELF.Diff_clean_geo_match,1,0)+ IF( SELF.Diff_clean_err_stat,1,0);
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
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_credential_type := COUNT(GROUP,%Closest%.Diff_orig_credential_type);
    Count_Diff_orig_id_terminal_date := COUNT(GROUP,%Closest%.Diff_orig_id_terminal_date);
    Count_Diff_orig_lname := COUNT(GROUP,%Closest%.Diff_orig_lname);
    Count_Diff_orig_fname := COUNT(GROUP,%Closest%.Diff_orig_fname);
    Count_Diff_orig_mi := COUNT(GROUP,%Closest%.Diff_orig_mi);
    Count_Diff_orig_namesuf := COUNT(GROUP,%Closest%.Diff_orig_namesuf);
    Count_Diff_orig_street := COUNT(GROUP,%Closest%.Diff_orig_street);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_drivered := COUNT(GROUP,%Closest%.Diff_orig_drivered);
    Count_Diff_orig_sex := COUNT(GROUP,%Closest%.Diff_orig_sex);
    Count_Diff_orig_height := COUNT(GROUP,%Closest%.Diff_orig_height);
    Count_Diff_orig_height2 := COUNT(GROUP,%Closest%.Diff_orig_height2);
    Count_Diff_orig_weight := COUNT(GROUP,%Closest%.Diff_orig_weight);
    Count_Diff_orig_hair := COUNT(GROUP,%Closest%.Diff_orig_hair);
    Count_Diff_orig_eyes := COUNT(GROUP,%Closest%.Diff_orig_eyes);
    Count_Diff_orig_dlexpiredate := COUNT(GROUP,%Closest%.Diff_orig_dlexpiredate);
    Count_Diff_orig_dlstat := COUNT(GROUP,%Closest%.Diff_orig_dlstat);
    Count_Diff_orig_dlissuedate := COUNT(GROUP,%Closest%.Diff_orig_dlissuedate);
    Count_Diff_orig_originalissuedate := COUNT(GROUP,%Closest%.Diff_orig_originalissuedate);
    Count_Diff_orig_regstatfr := COUNT(GROUP,%Closest%.Diff_orig_regstatfr);
    Count_Diff_orig_regstatcr := COUNT(GROUP,%Closest%.Diff_orig_regstatcr);
    Count_Diff_orig_dlclass := COUNT(GROUP,%Closest%.Diff_orig_dlclass);
    Count_Diff_orig_historynum := COUNT(GROUP,%Closest%.Diff_orig_historynum);
    Count_Diff_orig_disabledvet := COUNT(GROUP,%Closest%.Diff_orig_disabledvet);
    Count_Diff_orig_photo := COUNT(GROUP,%Closest%.Diff_orig_photo);
    Count_Diff_orig_habitualoffender := COUNT(GROUP,%Closest%.Diff_orig_habitualoffender);
    Count_Diff_orig_restrictions := COUNT(GROUP,%Closest%.Diff_orig_restrictions);
    Count_Diff_orig_endorsements := COUNT(GROUP,%Closest%.Diff_orig_endorsements);
    Count_Diff_orig_endorsements2 := COUNT(GROUP,%Closest%.Diff_orig_endorsements2);
    Count_Diff_orig_endorsements3 := COUNT(GROUP,%Closest%.Diff_orig_endorsements3);
    Count_Diff_orig_endorsements4 := COUNT(GROUP,%Closest%.Diff_orig_endorsements4);
    Count_Diff_orig_endorsements5 := COUNT(GROUP,%Closest%.Diff_orig_endorsements5);
    Count_Diff_orig_endorsements6 := COUNT(GROUP,%Closest%.Diff_orig_endorsements6);
    Count_Diff_orig_endorsements7 := COUNT(GROUP,%Closest%.Diff_orig_endorsements7);
    Count_Diff_orig_endorsements8 := COUNT(GROUP,%Closest%.Diff_orig_endorsements8);
    Count_Diff_orig_endorsements9 := COUNT(GROUP,%Closest%.Diff_orig_endorsements9);
    Count_Diff_orig_endorsements10 := COUNT(GROUP,%Closest%.Diff_orig_endorsements10);
    Count_Diff_orig_endorsements11_20 := COUNT(GROUP,%Closest%.Diff_orig_endorsements11_20);
    Count_Diff_orig_comm_driv_status := COUNT(GROUP,%Closest%.Diff_orig_comm_driv_status);
    Count_Diff_orig_disabled_vet_type := COUNT(GROUP,%Closest%.Diff_orig_disabled_vet_type);
    Count_Diff_orig_organ_donor := COUNT(GROUP,%Closest%.Diff_orig_organ_donor);
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
