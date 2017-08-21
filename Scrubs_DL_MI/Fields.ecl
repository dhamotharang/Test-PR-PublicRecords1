IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_MI; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT35.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alpha','invalid_alpha_specials','invalid_numeric','invalid_numeric_nonblank','invalid_alpha_num','invalid_empty','invalid_wordbag','invalid_8pastdate','invalid_orig_reccode','invalid_orig_clientidnum','invalid_dlnum_pid','invalid_orig_name','invalid_state','invalid_zip','invalid_orig_dob','invalid_orig_sex','invalid_orig_county','invalid_orig_dlnorpidindicator','invalid_clean_name','invalid_addr_type');
EXPORT FieldTypeNum(SALT35.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alpha' => 2,'invalid_alpha_specials' => 3,'invalid_numeric' => 4,'invalid_numeric_nonblank' => 5,'invalid_alpha_num' => 6,'invalid_empty' => 7,'invalid_wordbag' => 8,'invalid_8pastdate' => 9,'invalid_orig_reccode' => 10,'invalid_orig_clientidnum' => 11,'invalid_dlnum_pid' => 12,'invalid_orig_name' => 13,'invalid_state' => 14,'invalid_zip' => 15,'invalid_orig_dob' => 16,'invalid_orig_sex' => 17,'invalid_orig_county' => 18,'invalid_orig_dlnorpidindicator' => 19,'invalid_clean_name' => 20,'invalid_addr_type' => 21,0);
 
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
 
EXPORT MakeFT_invalid_alpha_specials(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ @-.,#'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_specials(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ @-.,#'))));
EXPORT InValidMessageFT_invalid_alpha_specials(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ @-.,#'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_nonblank(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_nonblank(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric_nonblank(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha_num(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alpha_num(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alpha_num(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('0'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_wordbag(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringtouppercase(s0); // Force to upper case
  s2 := SALT35.stringfilter(s1,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'); // Only allow valid symbols
  s3 := SALT35.stringcleanspaces( SALT35.stringsubstituteout(s2,' <>{}[]()-^=!+&,./#*\'\\|"',' ') ); // Insert spaces but avoid doubles
  RETURN  s3;
END;
EXPORT InValidFT_invalid_wordbag(SALT35.StrType s) := WHICH(SALT35.stringtouppercase(s)<>s,LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'))));
EXPORT InValidMessageFT_invalid_wordbag(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotCaps,SALT35.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 <>{}[]()-^=!+&,./#*\'\\|"'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT35.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_reccode(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_reccode(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['A','C','D']);
EXPORT InValidMessageFT_invalid_orig_reccode(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('A|C|D'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_clientidnum(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_orig_clientidnum(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_orig_clientidnum(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('10'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dlnum_pid(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dlnum_pid(SALT35.StrType s) := WHICH(~Scrubs_DL_MI.Functions.fn_check_dl_number(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 13));
EXPORT InValidMessageFT_invalid_dlnum_pid(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_MI.Functions.fn_check_dl_number'),SALT35.HygieneErrors.NotLength('0,13'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_name(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_name(SALT35.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_orig_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotLength('1..'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT35.StrType s) := WHICH(~Scrubs_DL_MI.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_MI.Functions.fn_verify_state'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  MakeFT_invalid_numeric(s1);
END;
EXPORT InValidFT_invalid_zip(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 5));
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('0123456789'),SALT35.HygieneErrors.NotLength('5'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_dob(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_dob(SALT35.StrType s) := WHICH(~Scrubs_DL_MI.Functions.fn_valid_past_date(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_orig_dob(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_MI.Functions.fn_valid_past_date'),SALT35.HygieneErrors.NotLength('8'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_sex(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_sex(SALT35.StrType s) := WHICH(((SALT35.StrType) s) NOT IN ['F','M']);
EXPORT InValidMessageFT_invalid_orig_sex(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInEnum('F|M'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_county(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_county(SALT35.StrType s) := WHICH(~Scrubs_DL_MI.Functions.fn_verify_county(s)>0,~(LENGTH(TRIM(s)) = 2));
EXPORT InValidMessageFT_invalid_orig_county(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_MI.Functions.fn_verify_county'),SALT35.HygieneErrors.NotLength('2'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_dlnorpidindicator(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_dlnorpidindicator(SALT35.StrType s,SALT35.StrType orig_dlnum,SALT35.StrType orig_personalidnum) := WHICH(~Scrubs_DL_MI.Functions.fn_verify_indicator(s,orig_dlnum,orig_personalidnum)>0);
EXPORT InValidMessageFT_invalid_orig_dlnorpidindicator(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_MI.Functions.fn_verify_indicator'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_name(SALT35.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_name(SALT35.StrType s,SALT35.StrType clean_name_first,SALT35.StrType clean_name_middle) := WHICH(~Scrubs_DL_MI.Functions.fn_valid_name(s,clean_name_first,clean_name_middle)>0);
EXPORT InValidMessageFT_invalid_clean_name(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.CustomFail('Scrubs_DL_MI.Functions.fn_valid_name'),SALT35.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_addr_type(SALT35.StrType s0) := FUNCTION
  s1 := SALT35.stringfilter(s0,'M'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_addr_type(SALT35.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT35.StringFilter(s,'M'))),~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1));
EXPORT InValidMessageFT_invalid_addr_type(UNSIGNED1 wh) := CHOOSE(wh,SALT35.HygieneErrors.NotInChars('M'),SALT35.HygieneErrors.NotLength('0,1'),SALT35.HygieneErrors.Good);
 
EXPORT SALT35.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'append_process_date','orig_reccode','orig_clientidnum','orig_dlnum','orig_personalidnum','orig_name','orig_street','orig_city','orig_state','orig_zip','orig_dob','orig_sex','orig_county','orig_dlnorpidindicator','orig_mailingstreet','orig_mailingcity','orig_mailingstate','orig_mailingzip','orig_optoutindicator','orig_lf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat','addr_type');
EXPORT FieldNum(SALT35.StrType fn) := CASE(fn,'append_process_date' => 0,'orig_reccode' => 1,'orig_clientidnum' => 2,'orig_dlnum' => 3,'orig_personalidnum' => 4,'orig_name' => 5,'orig_street' => 6,'orig_city' => 7,'orig_state' => 8,'orig_zip' => 9,'orig_dob' => 10,'orig_sex' => 11,'orig_county' => 12,'orig_dlnorpidindicator' => 13,'orig_mailingstreet' => 14,'orig_mailingcity' => 15,'orig_mailingstate' => 16,'orig_mailingzip' => 17,'orig_optoutindicator' => 18,'orig_lf' => 19,'clean_name_prefix' => 20,'clean_name_first' => 21,'clean_name_middle' => 22,'clean_name_last' => 23,'clean_name_suffix' => 24,'clean_name_score' => 25,'clean_prim_range' => 26,'clean_predir' => 27,'clean_prim_name' => 28,'clean_addr_suffix' => 29,'clean_postdir' => 30,'clean_unit_desig' => 31,'clean_sec_range' => 32,'clean_p_city_name' => 33,'clean_v_city_name' => 34,'clean_st' => 35,'clean_zip' => 36,'clean_zip4' => 37,'clean_cart' => 38,'clean_cr_sort_sz' => 39,'clean_lot' => 40,'clean_lot_order' => 41,'clean_dpbc' => 42,'clean_chk_digit' => 43,'clean_record_type' => 44,'clean_ace_fips_st' => 45,'clean_fipscounty' => 46,'clean_geo_lat' => 47,'clean_geo_long' => 48,'clean_msa' => 49,'clean_geo_blk' => 50,'clean_geo_match' => 51,'clean_err_stat' => 52,'addr_type' => 53,0);
 
//Individual field level validation
 
EXPORT Make_append_process_date(SALT35.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_append_process_date(SALT35.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_append_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_orig_reccode(SALT35.StrType s0) := MakeFT_invalid_orig_reccode(s0);
EXPORT InValid_orig_reccode(SALT35.StrType s) := InValidFT_invalid_orig_reccode(s);
EXPORT InValidMessage_orig_reccode(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_reccode(wh);
 
EXPORT Make_orig_clientidnum(SALT35.StrType s0) := MakeFT_invalid_orig_clientidnum(s0);
EXPORT InValid_orig_clientidnum(SALT35.StrType s) := InValidFT_invalid_orig_clientidnum(s);
EXPORT InValidMessage_orig_clientidnum(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_clientidnum(wh);
 
EXPORT Make_orig_dlnum(SALT35.StrType s0) := MakeFT_invalid_dlnum_pid(s0);
EXPORT InValid_orig_dlnum(SALT35.StrType s) := InValidFT_invalid_dlnum_pid(s);
EXPORT InValidMessage_orig_dlnum(UNSIGNED1 wh) := InValidMessageFT_invalid_dlnum_pid(wh);
 
EXPORT Make_orig_personalidnum(SALT35.StrType s0) := MakeFT_invalid_dlnum_pid(s0);
EXPORT InValid_orig_personalidnum(SALT35.StrType s) := InValidFT_invalid_dlnum_pid(s);
EXPORT InValidMessage_orig_personalidnum(UNSIGNED1 wh) := InValidMessageFT_invalid_dlnum_pid(wh);
 
EXPORT Make_orig_name(SALT35.StrType s0) := MakeFT_invalid_orig_name(s0);
EXPORT InValid_orig_name(SALT35.StrType s) := InValidFT_invalid_orig_name(s);
EXPORT InValidMessage_orig_name(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_name(wh);
 
EXPORT Make_orig_street(SALT35.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_orig_street(SALT35.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_orig_street(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_orig_city(SALT35.StrType s0) := MakeFT_invalid_alpha_specials(s0);
EXPORT InValid_orig_city(SALT35.StrType s) := InValidFT_invalid_alpha_specials(s);
EXPORT InValidMessage_orig_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_specials(wh);
 
EXPORT Make_orig_state(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_state(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_orig_zip(SALT35.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_orig_zip(SALT35.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_orig_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_orig_dob(SALT35.StrType s0) := MakeFT_invalid_orig_dob(s0);
EXPORT InValid_orig_dob(SALT35.StrType s) := InValidFT_invalid_orig_dob(s);
EXPORT InValidMessage_orig_dob(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_dob(wh);
 
EXPORT Make_orig_sex(SALT35.StrType s0) := MakeFT_invalid_orig_sex(s0);
EXPORT InValid_orig_sex(SALT35.StrType s) := InValidFT_invalid_orig_sex(s);
EXPORT InValidMessage_orig_sex(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_sex(wh);
 
EXPORT Make_orig_county(SALT35.StrType s0) := MakeFT_invalid_orig_county(s0);
EXPORT InValid_orig_county(SALT35.StrType s) := InValidFT_invalid_orig_county(s);
EXPORT InValidMessage_orig_county(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_county(wh);
 
EXPORT Make_orig_dlnorpidindicator(SALT35.StrType s0) := MakeFT_invalid_orig_dlnorpidindicator(s0);
EXPORT InValid_orig_dlnorpidindicator(SALT35.StrType s,SALT35.StrType orig_dlnum,SALT35.StrType orig_personalidnum) := InValidFT_invalid_orig_dlnorpidindicator(s,orig_dlnum,orig_personalidnum);
EXPORT InValidMessage_orig_dlnorpidindicator(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_dlnorpidindicator(wh);
 
EXPORT Make_orig_mailingstreet(SALT35.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_orig_mailingstreet(SALT35.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_orig_mailingstreet(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_orig_mailingcity(SALT35.StrType s0) := MakeFT_invalid_alpha_specials(s0);
EXPORT InValid_orig_mailingcity(SALT35.StrType s) := InValidFT_invalid_alpha_specials(s);
EXPORT InValidMessage_orig_mailingcity(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_specials(wh);
 
EXPORT Make_orig_mailingstate(SALT35.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_mailingstate(SALT35.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_mailingstate(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_orig_mailingzip(SALT35.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_orig_mailingzip(SALT35.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_orig_mailingzip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_orig_optoutindicator(SALT35.StrType s0) := s0;
EXPORT InValid_orig_optoutindicator(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_optoutindicator(UNSIGNED1 wh) := '';
 
EXPORT Make_orig_lf(SALT35.StrType s0) := s0;
EXPORT InValid_orig_lf(SALT35.StrType s) := 0;
EXPORT InValidMessage_orig_lf(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_name_prefix(SALT35.StrType s0) := MakeFT_invalid_alpha_specials(s0);
EXPORT InValid_clean_name_prefix(SALT35.StrType s) := InValidFT_invalid_alpha_specials(s);
EXPORT InValidMessage_clean_name_prefix(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha_specials(wh);
 
EXPORT Make_clean_name_first(SALT35.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_clean_name_first(SALT35.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_clean_name_first(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_clean_name_middle(SALT35.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_clean_name_middle(SALT35.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_clean_name_middle(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_clean_name_last(SALT35.StrType s0) := MakeFT_invalid_clean_name(s0);
EXPORT InValid_clean_name_last(SALT35.StrType s,SALT35.StrType clean_name_first,SALT35.StrType clean_name_middle) := InValidFT_invalid_clean_name(s,clean_name_first,clean_name_middle);
EXPORT InValidMessage_clean_name_last(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_name(wh);
 
EXPORT Make_clean_name_suffix(SALT35.StrType s0) := MakeFT_invalid_wordbag(s0);
EXPORT InValid_clean_name_suffix(SALT35.StrType s) := InValidFT_invalid_wordbag(s);
EXPORT InValidMessage_clean_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_wordbag(wh);
 
EXPORT Make_clean_name_score(SALT35.StrType s0) := s0;
EXPORT InValid_clean_name_score(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_name_score(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_prim_range(SALT35.StrType s0) := s0;
EXPORT InValid_clean_prim_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_predir(SALT35.StrType s0) := s0;
EXPORT InValid_clean_predir(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_predir(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_prim_name(SALT35.StrType s0) := s0;
EXPORT InValid_clean_prim_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_prim_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_addr_suffix(SALT35.StrType s0) := s0;
EXPORT InValid_clean_addr_suffix(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_postdir(SALT35.StrType s0) := s0;
EXPORT InValid_clean_postdir(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_postdir(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_unit_desig(SALT35.StrType s0) := s0;
EXPORT InValid_clean_unit_desig(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_sec_range(SALT35.StrType s0) := s0;
EXPORT InValid_clean_sec_range(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_p_city_name(SALT35.StrType s0) := s0;
EXPORT InValid_clean_p_city_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_p_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_v_city_name(SALT35.StrType s0) := s0;
EXPORT InValid_clean_v_city_name(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_v_city_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_st(SALT35.StrType s0) := s0;
EXPORT InValid_clean_st(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_st(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_zip(SALT35.StrType s0) := s0;
EXPORT InValid_clean_zip(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_zip(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_zip4(SALT35.StrType s0) := s0;
EXPORT InValid_clean_zip4(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_zip4(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_cart(SALT35.StrType s0) := s0;
EXPORT InValid_clean_cart(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_cart(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_cr_sort_sz(SALT35.StrType s0) := s0;
EXPORT InValid_clean_cr_sort_sz(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_cr_sort_sz(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_lot(SALT35.StrType s0) := s0;
EXPORT InValid_clean_lot(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_lot_order(SALT35.StrType s0) := s0;
EXPORT InValid_clean_lot_order(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_lot_order(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_dpbc(SALT35.StrType s0) := s0;
EXPORT InValid_clean_dpbc(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_dpbc(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_chk_digit(SALT35.StrType s0) := s0;
EXPORT InValid_clean_chk_digit(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_chk_digit(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_record_type(SALT35.StrType s0) := s0;
EXPORT InValid_clean_record_type(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_record_type(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_ace_fips_st(SALT35.StrType s0) := s0;
EXPORT InValid_clean_ace_fips_st(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_ace_fips_st(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_fipscounty(SALT35.StrType s0) := s0;
EXPORT InValid_clean_fipscounty(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_fipscounty(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_geo_lat(SALT35.StrType s0) := s0;
EXPORT InValid_clean_geo_lat(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_geo_lat(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_geo_long(SALT35.StrType s0) := s0;
EXPORT InValid_clean_geo_long(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_geo_long(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_msa(SALT35.StrType s0) := s0;
EXPORT InValid_clean_msa(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_msa(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_geo_blk(SALT35.StrType s0) := s0;
EXPORT InValid_clean_geo_blk(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_geo_match(SALT35.StrType s0) := s0;
EXPORT InValid_clean_geo_match(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_geo_match(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_err_stat(SALT35.StrType s0) := s0;
EXPORT InValid_clean_err_stat(SALT35.StrType s) := 0;
EXPORT InValidMessage_clean_err_stat(UNSIGNED1 wh) := '';
 
EXPORT Make_addr_type(SALT35.StrType s0) := MakeFT_invalid_addr_type(s0);
EXPORT InValid_addr_type(SALT35.StrType s) := InValidFT_invalid_addr_type(s);
EXPORT InValidMessage_addr_type(UNSIGNED1 wh) := InValidMessageFT_invalid_addr_type(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT35,Scrubs_DL_MI;
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
    BOOLEAN Diff_orig_reccode;
    BOOLEAN Diff_orig_clientidnum;
    BOOLEAN Diff_orig_dlnum;
    BOOLEAN Diff_orig_personalidnum;
    BOOLEAN Diff_orig_name;
    BOOLEAN Diff_orig_street;
    BOOLEAN Diff_orig_city;
    BOOLEAN Diff_orig_state;
    BOOLEAN Diff_orig_zip;
    BOOLEAN Diff_orig_dob;
    BOOLEAN Diff_orig_sex;
    BOOLEAN Diff_orig_county;
    BOOLEAN Diff_orig_dlnorpidindicator;
    BOOLEAN Diff_orig_mailingstreet;
    BOOLEAN Diff_orig_mailingcity;
    BOOLEAN Diff_orig_mailingstate;
    BOOLEAN Diff_orig_mailingzip;
    BOOLEAN Diff_orig_optoutindicator;
    BOOLEAN Diff_orig_lf;
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
    BOOLEAN Diff_addr_type;
    UNSIGNED Num_Diffs;
    SALT35.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_append_process_date := le.append_process_date <> ri.append_process_date;
    SELF.Diff_orig_reccode := le.orig_reccode <> ri.orig_reccode;
    SELF.Diff_orig_clientidnum := le.orig_clientidnum <> ri.orig_clientidnum;
    SELF.Diff_orig_dlnum := le.orig_dlnum <> ri.orig_dlnum;
    SELF.Diff_orig_personalidnum := le.orig_personalidnum <> ri.orig_personalidnum;
    SELF.Diff_orig_name := le.orig_name <> ri.orig_name;
    SELF.Diff_orig_street := le.orig_street <> ri.orig_street;
    SELF.Diff_orig_city := le.orig_city <> ri.orig_city;
    SELF.Diff_orig_state := le.orig_state <> ri.orig_state;
    SELF.Diff_orig_zip := le.orig_zip <> ri.orig_zip;
    SELF.Diff_orig_dob := le.orig_dob <> ri.orig_dob;
    SELF.Diff_orig_sex := le.orig_sex <> ri.orig_sex;
    SELF.Diff_orig_county := le.orig_county <> ri.orig_county;
    SELF.Diff_orig_dlnorpidindicator := le.orig_dlnorpidindicator <> ri.orig_dlnorpidindicator;
    SELF.Diff_orig_mailingstreet := le.orig_mailingstreet <> ri.orig_mailingstreet;
    SELF.Diff_orig_mailingcity := le.orig_mailingcity <> ri.orig_mailingcity;
    SELF.Diff_orig_mailingstate := le.orig_mailingstate <> ri.orig_mailingstate;
    SELF.Diff_orig_mailingzip := le.orig_mailingzip <> ri.orig_mailingzip;
    SELF.Diff_orig_optoutindicator := le.orig_optoutindicator <> ri.orig_optoutindicator;
    SELF.Diff_orig_lf := le.orig_lf <> ri.orig_lf;
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
    SELF.Diff_addr_type := le.addr_type <> ri.addr_type;
    SELF.Val := (SALT35.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_append_process_date,1,0)+ IF( SELF.Diff_orig_reccode,1,0)+ IF( SELF.Diff_orig_clientidnum,1,0)+ IF( SELF.Diff_orig_dlnum,1,0)+ IF( SELF.Diff_orig_personalidnum,1,0)+ IF( SELF.Diff_orig_name,1,0)+ IF( SELF.Diff_orig_street,1,0)+ IF( SELF.Diff_orig_city,1,0)+ IF( SELF.Diff_orig_state,1,0)+ IF( SELF.Diff_orig_zip,1,0)+ IF( SELF.Diff_orig_dob,1,0)+ IF( SELF.Diff_orig_sex,1,0)+ IF( SELF.Diff_orig_county,1,0)+ IF( SELF.Diff_orig_dlnorpidindicator,1,0)+ IF( SELF.Diff_orig_mailingstreet,1,0)+ IF( SELF.Diff_orig_mailingcity,1,0)+ IF( SELF.Diff_orig_mailingstate,1,0)+ IF( SELF.Diff_orig_mailingzip,1,0)+ IF( SELF.Diff_orig_optoutindicator,1,0)+ IF( SELF.Diff_orig_lf,1,0)+ IF( SELF.Diff_clean_name_prefix,1,0)+ IF( SELF.Diff_clean_name_first,1,0)+ IF( SELF.Diff_clean_name_middle,1,0)+ IF( SELF.Diff_clean_name_last,1,0)+ IF( SELF.Diff_clean_name_suffix,1,0)+ IF( SELF.Diff_clean_name_score,1,0)+ IF( SELF.Diff_clean_prim_range,1,0)+ IF( SELF.Diff_clean_predir,1,0)+ IF( SELF.Diff_clean_prim_name,1,0)+ IF( SELF.Diff_clean_addr_suffix,1,0)+ IF( SELF.Diff_clean_postdir,1,0)+ IF( SELF.Diff_clean_unit_desig,1,0)+ IF( SELF.Diff_clean_sec_range,1,0)+ IF( SELF.Diff_clean_p_city_name,1,0)+ IF( SELF.Diff_clean_v_city_name,1,0)+ IF( SELF.Diff_clean_st,1,0)+ IF( SELF.Diff_clean_zip,1,0)+ IF( SELF.Diff_clean_zip4,1,0)+ IF( SELF.Diff_clean_cart,1,0)+ IF( SELF.Diff_clean_cr_sort_sz,1,0)+ IF( SELF.Diff_clean_lot,1,0)+ IF( SELF.Diff_clean_lot_order,1,0)+ IF( SELF.Diff_clean_dpbc,1,0)+ IF( SELF.Diff_clean_chk_digit,1,0)+ IF( SELF.Diff_clean_record_type,1,0)+ IF( SELF.Diff_clean_ace_fips_st,1,0)+ IF( SELF.Diff_clean_fipscounty,1,0)+ IF( SELF.Diff_clean_geo_lat,1,0)+ IF( SELF.Diff_clean_geo_long,1,0)+ IF( SELF.Diff_clean_msa,1,0)+ IF( SELF.Diff_clean_geo_blk,1,0)+ IF( SELF.Diff_clean_geo_match,1,0)+ IF( SELF.Diff_clean_err_stat,1,0)+ IF( SELF.Diff_addr_type,1,0);
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
    Count_Diff_orig_reccode := COUNT(GROUP,%Closest%.Diff_orig_reccode);
    Count_Diff_orig_clientidnum := COUNT(GROUP,%Closest%.Diff_orig_clientidnum);
    Count_Diff_orig_dlnum := COUNT(GROUP,%Closest%.Diff_orig_dlnum);
    Count_Diff_orig_personalidnum := COUNT(GROUP,%Closest%.Diff_orig_personalidnum);
    Count_Diff_orig_name := COUNT(GROUP,%Closest%.Diff_orig_name);
    Count_Diff_orig_street := COUNT(GROUP,%Closest%.Diff_orig_street);
    Count_Diff_orig_city := COUNT(GROUP,%Closest%.Diff_orig_city);
    Count_Diff_orig_state := COUNT(GROUP,%Closest%.Diff_orig_state);
    Count_Diff_orig_zip := COUNT(GROUP,%Closest%.Diff_orig_zip);
    Count_Diff_orig_dob := COUNT(GROUP,%Closest%.Diff_orig_dob);
    Count_Diff_orig_sex := COUNT(GROUP,%Closest%.Diff_orig_sex);
    Count_Diff_orig_county := COUNT(GROUP,%Closest%.Diff_orig_county);
    Count_Diff_orig_dlnorpidindicator := COUNT(GROUP,%Closest%.Diff_orig_dlnorpidindicator);
    Count_Diff_orig_mailingstreet := COUNT(GROUP,%Closest%.Diff_orig_mailingstreet);
    Count_Diff_orig_mailingcity := COUNT(GROUP,%Closest%.Diff_orig_mailingcity);
    Count_Diff_orig_mailingstate := COUNT(GROUP,%Closest%.Diff_orig_mailingstate);
    Count_Diff_orig_mailingzip := COUNT(GROUP,%Closest%.Diff_orig_mailingzip);
    Count_Diff_orig_optoutindicator := COUNT(GROUP,%Closest%.Diff_orig_optoutindicator);
    Count_Diff_orig_lf := COUNT(GROUP,%Closest%.Diff_orig_lf);
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
    Count_Diff_addr_type := COUNT(GROUP,%Closest%.Diff_addr_type);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
