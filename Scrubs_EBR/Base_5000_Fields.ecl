IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_5000_Fields := MODULE
 
EXPORT NumFields := 43;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_dt_yymmdd','invalid_dt_mmddyy','invalid_record_type','invalid_segment','invalid_file_number','invalid_bal_range_code','invalid_acct_bal_range_code','invalid_acct_bal','invalid_acct_rating_code','invalid_relationship_code','invalid_relationship_desc','invalid_state','invalid_state_desc','invalid_zip5','invalid_phone','invalid_direction');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_dt_yymmdd' => 6,'invalid_dt_mmddyy' => 7,'invalid_record_type' => 8,'invalid_segment' => 9,'invalid_file_number' => 10,'invalid_bal_range_code' => 11,'invalid_acct_bal_range_code' => 12,'invalid_acct_bal' => 13,'invalid_acct_rating_code' => 14,'invalid_relationship_code' => 15,'invalid_relationship_desc' => 16,'invalid_state' => 17,'invalid_state_desc' => 18,'invalid_zip5' => 19,'invalid_phone' => 20,'invalid_direction' => 21,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_or_allzeros(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric_or_allzeros(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_numeric_or_allzeros(s)>0);
EXPORT InValidMessageFT_invalid_numeric_or_allzeros(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_numeric_or_allzeros'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_first_seen(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_first_seen(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_first_seen(s)>0);
EXPORT InValidMessageFT_invalid_dt_first_seen(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_first_seen'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_yymmdd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_yymmdd(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_yymmdd(s)>0);
EXPORT InValidMessageFT_invalid_dt_yymmdd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_yymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dt_mmddyy(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dt_mmddyy(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_dt_mmddyy(s)>0);
EXPORT InValidMessageFT_invalid_dt_mmddyy(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_dt_mmddyy'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','C']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_segment(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['5000','5000']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('5000|5000'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bal_range_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bal_range_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','0','A','B','C','D']);
EXPORT InValidMessageFT_invalid_bal_range_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |0|A|B|C|D'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_acct_bal_range_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_acct_bal_range_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN [' ','0','1','2']);
EXPORT InValidMessageFT_invalid_acct_bal_range_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum(' |0|1|2'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_acct_bal(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789ABCDEFGHI-{'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_acct_bal(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789ABCDEFGHI-{'))));
EXPORT InValidMessageFT_invalid_acct_bal(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789ABCDEFGHI-{'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_acct_rating_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_acct_rating_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['G','N','S','U']);
EXPORT InValidMessageFT_invalid_acct_rating_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('G|N|S|U'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_relationship_code(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_valid_relationship_code(s)>0);
EXPORT InValidMessageFT_invalid_relationship_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_valid_relationship_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_relationship_desc(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_valid_relationship_desc(s)>0);
EXPORT InValidMessageFT_invalid_relationship_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_valid_relationship_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_desc(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_verify_state_desc(s)>0);
EXPORT InValidMessageFT_invalid_state_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_verify_state_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_verify_zip5'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_verify_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_verify_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_direction(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['E','N','S','W','NE','NW','SE','SW','']);
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('E|N|S|W|NE|NW|SE|SW|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','name','street_address','city','state_code','state_desc','zip_code','telephone','relationship_code','relationship_desc','bal_range_code','acct_bal_range_code','nbr_fig_in_bal','acct_bal_total','acct_rating_code','date_acct_opened_ymd','date_acct_closed_ymd','name_addr_key','append_rawaid','append_aceaid','prep_addr_line1','prep_addr_last_line','clean_address_predir','clean_address_prim_name','clean_address_postdir','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','name','street_address','city','state_code','state_desc','zip_code','telephone','relationship_code','relationship_desc','bal_range_code','acct_bal_range_code','nbr_fig_in_bal','acct_bal_total','acct_rating_code','date_acct_opened_ymd','date_acct_closed_ymd','name_addr_key','append_rawaid','append_aceaid','prep_addr_line1','prep_addr_last_line','clean_address_predir','clean_address_prim_name','clean_address_postdir','clean_address_p_city_name','clean_address_v_city_name','clean_address_st','clean_address_zip');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'segment_code' => 13,'sequence_number' => 14,'name' => 15,'street_address' => 16,'city' => 17,'state_code' => 18,'state_desc' => 19,'zip_code' => 20,'telephone' => 21,'relationship_code' => 22,'relationship_desc' => 23,'bal_range_code' => 24,'acct_bal_range_code' => 25,'nbr_fig_in_bal' => 26,'acct_bal_total' => 27,'acct_rating_code' => 28,'date_acct_opened_ymd' => 29,'date_acct_closed_ymd' => 30,'name_addr_key' => 31,'append_rawaid' => 32,'append_aceaid' => 33,'prep_addr_line1' => 34,'prep_addr_last_line' => 35,'clean_address_predir' => 36,'clean_address_prim_name' => 37,'clean_address_postdir' => 38,'clean_address_p_city_name' => 39,'clean_address_v_city_name' => 40,'clean_address_st' => 41,'clean_address_zip' => 42,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['ALLOW'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['ENUM'],['LENGTHS'],['ENUM'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_powid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_powid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_proxid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_proxid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_seleid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_seleid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_orgid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orgid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_ultid(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_ultid(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_bdid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_date_first_seen(SALT311.StrType s0) := MakeFT_invalid_dt_first_seen(s0);
EXPORT InValid_date_first_seen(SALT311.StrType s) := InValidFT_invalid_dt_first_seen(s);
EXPORT InValidMessage_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_first_seen(wh);
 
EXPORT Make_date_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date_first_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date_first_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_file_number(SALT311.StrType s0) := MakeFT_invalid_file_number(s0);
EXPORT InValid_file_number(SALT311.StrType s) := InValidFT_invalid_file_number(s);
EXPORT InValidMessage_file_number(UNSIGNED1 wh) := InValidMessageFT_invalid_file_number(wh);
 
EXPORT Make_segment_code(SALT311.StrType s0) := MakeFT_invalid_segment(s0);
EXPORT InValid_segment_code(SALT311.StrType s) := InValidFT_invalid_segment(s);
EXPORT InValidMessage_segment_code(UNSIGNED1 wh) := InValidMessageFT_invalid_segment(wh);
 
EXPORT Make_sequence_number(SALT311.StrType s0) := MakeFT_invalid_numeric_or_allzeros(s0);
EXPORT InValid_sequence_number(SALT311.StrType s) := InValidFT_invalid_numeric_or_allzeros(s);
EXPORT InValidMessage_sequence_number(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_or_allzeros(wh);
 
EXPORT Make_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_street_address(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_street_address(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_street_address(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_state_code(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state_code(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state_code(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_state_desc(SALT311.StrType s0) := MakeFT_invalid_state_desc(s0);
EXPORT InValid_state_desc(SALT311.StrType s) := InValidFT_invalid_state_desc(s);
EXPORT InValidMessage_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_state_desc(wh);
 
EXPORT Make_zip_code(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip_code(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_telephone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_telephone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_telephone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_relationship_code(SALT311.StrType s0) := MakeFT_invalid_relationship_code(s0);
EXPORT InValid_relationship_code(SALT311.StrType s) := InValidFT_invalid_relationship_code(s);
EXPORT InValidMessage_relationship_code(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_code(wh);
 
EXPORT Make_relationship_desc(SALT311.StrType s0) := MakeFT_invalid_relationship_desc(s0);
EXPORT InValid_relationship_desc(SALT311.StrType s) := InValidFT_invalid_relationship_desc(s);
EXPORT InValidMessage_relationship_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_desc(wh);
 
EXPORT Make_bal_range_code(SALT311.StrType s0) := MakeFT_invalid_bal_range_code(s0);
EXPORT InValid_bal_range_code(SALT311.StrType s) := InValidFT_invalid_bal_range_code(s);
EXPORT InValidMessage_bal_range_code(UNSIGNED1 wh) := InValidMessageFT_invalid_bal_range_code(wh);
 
EXPORT Make_acct_bal_range_code(SALT311.StrType s0) := MakeFT_invalid_acct_bal_range_code(s0);
EXPORT InValid_acct_bal_range_code(SALT311.StrType s) := InValidFT_invalid_acct_bal_range_code(s);
EXPORT InValidMessage_acct_bal_range_code(UNSIGNED1 wh) := InValidMessageFT_invalid_acct_bal_range_code(wh);
 
EXPORT Make_nbr_fig_in_bal(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_nbr_fig_in_bal(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_nbr_fig_in_bal(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_acct_bal_total(SALT311.StrType s0) := MakeFT_invalid_acct_bal(s0);
EXPORT InValid_acct_bal_total(SALT311.StrType s) := InValidFT_invalid_acct_bal(s);
EXPORT InValidMessage_acct_bal_total(UNSIGNED1 wh) := InValidMessageFT_invalid_acct_bal(wh);
 
EXPORT Make_acct_rating_code(SALT311.StrType s0) := MakeFT_invalid_acct_rating_code(s0);
EXPORT InValid_acct_rating_code(SALT311.StrType s) := InValidFT_invalid_acct_rating_code(s);
EXPORT InValidMessage_acct_rating_code(UNSIGNED1 wh) := InValidMessageFT_invalid_acct_rating_code(wh);
 
EXPORT Make_date_acct_opened_ymd(SALT311.StrType s0) := MakeFT_invalid_dt_mmddyy(s0);
EXPORT InValid_date_acct_opened_ymd(SALT311.StrType s) := InValidFT_invalid_dt_mmddyy(s);
EXPORT InValidMessage_date_acct_opened_ymd(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_mmddyy(wh);
 
EXPORT Make_date_acct_closed_ymd(SALT311.StrType s0) := MakeFT_invalid_dt_mmddyy(s0);
EXPORT InValid_date_acct_closed_ymd(SALT311.StrType s) := InValidFT_invalid_dt_mmddyy(s);
EXPORT InValidMessage_date_acct_closed_ymd(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_mmddyy(wh);
 
EXPORT Make_name_addr_key(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_name_addr_key(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_name_addr_key(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_append_rawaid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_append_rawaid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_append_rawaid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_append_aceaid(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_append_aceaid(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_append_aceaid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_prep_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_last_line(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_last_line(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_last_line(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_address_predir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_clean_address_predir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_clean_address_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_clean_address_prim_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_address_prim_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_address_postdir(SALT311.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_clean_address_postdir(SALT311.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_clean_address_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_clean_address_p_city_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_address_p_city_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_address_v_city_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_address_v_city_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_address_st(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_clean_address_st(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_clean_address_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_clean_address_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_clean_address_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_clean_address_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_EBR;
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
    BOOLEAN Diff_powid;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_date_first_seen;
    BOOLEAN Diff_date_last_seen;
    BOOLEAN Diff_process_date_first_seen;
    BOOLEAN Diff_process_date_last_seen;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_file_number;
    BOOLEAN Diff_segment_code;
    BOOLEAN Diff_sequence_number;
    BOOLEAN Diff_name;
    BOOLEAN Diff_street_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state_code;
    BOOLEAN Diff_state_desc;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_telephone;
    BOOLEAN Diff_relationship_code;
    BOOLEAN Diff_relationship_desc;
    BOOLEAN Diff_bal_range_code;
    BOOLEAN Diff_acct_bal_range_code;
    BOOLEAN Diff_nbr_fig_in_bal;
    BOOLEAN Diff_acct_bal_total;
    BOOLEAN Diff_acct_rating_code;
    BOOLEAN Diff_date_acct_opened_ymd;
    BOOLEAN Diff_date_acct_closed_ymd;
    BOOLEAN Diff_name_addr_key;
    BOOLEAN Diff_append_rawaid;
    BOOLEAN Diff_append_aceaid;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_last_line;
    BOOLEAN Diff_clean_address_predir;
    BOOLEAN Diff_clean_address_prim_name;
    BOOLEAN Diff_clean_address_postdir;
    BOOLEAN Diff_clean_address_p_city_name;
    BOOLEAN Diff_clean_address_v_city_name;
    BOOLEAN Diff_clean_address_st;
    BOOLEAN Diff_clean_address_zip;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_date_first_seen := le.date_first_seen <> ri.date_first_seen;
    SELF.Diff_date_last_seen := le.date_last_seen <> ri.date_last_seen;
    SELF.Diff_process_date_first_seen := le.process_date_first_seen <> ri.process_date_first_seen;
    SELF.Diff_process_date_last_seen := le.process_date_last_seen <> ri.process_date_last_seen;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_file_number := le.file_number <> ri.file_number;
    SELF.Diff_segment_code := le.segment_code <> ri.segment_code;
    SELF.Diff_sequence_number := le.sequence_number <> ri.sequence_number;
    SELF.Diff_name := le.name <> ri.name;
    SELF.Diff_street_address := le.street_address <> ri.street_address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state_code := le.state_code <> ri.state_code;
    SELF.Diff_state_desc := le.state_desc <> ri.state_desc;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_telephone := le.telephone <> ri.telephone;
    SELF.Diff_relationship_code := le.relationship_code <> ri.relationship_code;
    SELF.Diff_relationship_desc := le.relationship_desc <> ri.relationship_desc;
    SELF.Diff_bal_range_code := le.bal_range_code <> ri.bal_range_code;
    SELF.Diff_acct_bal_range_code := le.acct_bal_range_code <> ri.acct_bal_range_code;
    SELF.Diff_nbr_fig_in_bal := le.nbr_fig_in_bal <> ri.nbr_fig_in_bal;
    SELF.Diff_acct_bal_total := le.acct_bal_total <> ri.acct_bal_total;
    SELF.Diff_acct_rating_code := le.acct_rating_code <> ri.acct_rating_code;
    SELF.Diff_date_acct_opened_ymd := le.date_acct_opened_ymd <> ri.date_acct_opened_ymd;
    SELF.Diff_date_acct_closed_ymd := le.date_acct_closed_ymd <> ri.date_acct_closed_ymd;
    SELF.Diff_name_addr_key := le.name_addr_key <> ri.name_addr_key;
    SELF.Diff_append_rawaid := le.append_rawaid <> ri.append_rawaid;
    SELF.Diff_append_aceaid := le.append_aceaid <> ri.append_aceaid;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_last_line := le.prep_addr_last_line <> ri.prep_addr_last_line;
    SELF.Diff_clean_address_predir := le.clean_address_predir <> ri.clean_address_predir;
    SELF.Diff_clean_address_prim_name := le.clean_address_prim_name <> ri.clean_address_prim_name;
    SELF.Diff_clean_address_postdir := le.clean_address_postdir <> ri.clean_address_postdir;
    SELF.Diff_clean_address_p_city_name := le.clean_address_p_city_name <> ri.clean_address_p_city_name;
    SELF.Diff_clean_address_v_city_name := le.clean_address_v_city_name <> ri.clean_address_v_city_name;
    SELF.Diff_clean_address_st := le.clean_address_st <> ri.clean_address_st;
    SELF.Diff_clean_address_zip := le.clean_address_zip <> ri.clean_address_zip;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_name,1,0)+ IF( SELF.Diff_street_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state_code,1,0)+ IF( SELF.Diff_state_desc,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_telephone,1,0)+ IF( SELF.Diff_relationship_code,1,0)+ IF( SELF.Diff_relationship_desc,1,0)+ IF( SELF.Diff_bal_range_code,1,0)+ IF( SELF.Diff_acct_bal_range_code,1,0)+ IF( SELF.Diff_nbr_fig_in_bal,1,0)+ IF( SELF.Diff_acct_bal_total,1,0)+ IF( SELF.Diff_acct_rating_code,1,0)+ IF( SELF.Diff_date_acct_opened_ymd,1,0)+ IF( SELF.Diff_date_acct_closed_ymd,1,0)+ IF( SELF.Diff_name_addr_key,1,0)+ IF( SELF.Diff_append_rawaid,1,0)+ IF( SELF.Diff_append_aceaid,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_last_line,1,0)+ IF( SELF.Diff_clean_address_predir,1,0)+ IF( SELF.Diff_clean_address_prim_name,1,0)+ IF( SELF.Diff_clean_address_postdir,1,0)+ IF( SELF.Diff_clean_address_p_city_name,1,0)+ IF( SELF.Diff_clean_address_v_city_name,1,0)+ IF( SELF.Diff_clean_address_st,1,0)+ IF( SELF.Diff_clean_address_zip,1,0);
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
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_date_first_seen := COUNT(GROUP,%Closest%.Diff_date_first_seen);
    Count_Diff_date_last_seen := COUNT(GROUP,%Closest%.Diff_date_last_seen);
    Count_Diff_process_date_first_seen := COUNT(GROUP,%Closest%.Diff_process_date_first_seen);
    Count_Diff_process_date_last_seen := COUNT(GROUP,%Closest%.Diff_process_date_last_seen);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_file_number := COUNT(GROUP,%Closest%.Diff_file_number);
    Count_Diff_segment_code := COUNT(GROUP,%Closest%.Diff_segment_code);
    Count_Diff_sequence_number := COUNT(GROUP,%Closest%.Diff_sequence_number);
    Count_Diff_name := COUNT(GROUP,%Closest%.Diff_name);
    Count_Diff_street_address := COUNT(GROUP,%Closest%.Diff_street_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state_code := COUNT(GROUP,%Closest%.Diff_state_code);
    Count_Diff_state_desc := COUNT(GROUP,%Closest%.Diff_state_desc);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_telephone := COUNT(GROUP,%Closest%.Diff_telephone);
    Count_Diff_relationship_code := COUNT(GROUP,%Closest%.Diff_relationship_code);
    Count_Diff_relationship_desc := COUNT(GROUP,%Closest%.Diff_relationship_desc);
    Count_Diff_bal_range_code := COUNT(GROUP,%Closest%.Diff_bal_range_code);
    Count_Diff_acct_bal_range_code := COUNT(GROUP,%Closest%.Diff_acct_bal_range_code);
    Count_Diff_nbr_fig_in_bal := COUNT(GROUP,%Closest%.Diff_nbr_fig_in_bal);
    Count_Diff_acct_bal_total := COUNT(GROUP,%Closest%.Diff_acct_bal_total);
    Count_Diff_acct_rating_code := COUNT(GROUP,%Closest%.Diff_acct_rating_code);
    Count_Diff_date_acct_opened_ymd := COUNT(GROUP,%Closest%.Diff_date_acct_opened_ymd);
    Count_Diff_date_acct_closed_ymd := COUNT(GROUP,%Closest%.Diff_date_acct_closed_ymd);
    Count_Diff_name_addr_key := COUNT(GROUP,%Closest%.Diff_name_addr_key);
    Count_Diff_append_rawaid := COUNT(GROUP,%Closest%.Diff_append_rawaid);
    Count_Diff_append_aceaid := COUNT(GROUP,%Closest%.Diff_append_aceaid);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_prep_addr_last_line);
    Count_Diff_clean_address_predir := COUNT(GROUP,%Closest%.Diff_clean_address_predir);
    Count_Diff_clean_address_prim_name := COUNT(GROUP,%Closest%.Diff_clean_address_prim_name);
    Count_Diff_clean_address_postdir := COUNT(GROUP,%Closest%.Diff_clean_address_postdir);
    Count_Diff_clean_address_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_address_p_city_name);
    Count_Diff_clean_address_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_address_v_city_name);
    Count_Diff_clean_address_st := COUNT(GROUP,%Closest%.Diff_clean_address_st);
    Count_Diff_clean_address_zip := COUNT(GROUP,%Closest%.Diff_clean_address_zip);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
