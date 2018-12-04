﻿IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_6510_Fields := MODULE
 
EXPORT NumFields := 41;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_dt_yymmdd','invalid_record_type','invalid_segment','invalid_file_number','invalid_state','invalid_state_desc','invalid_zip5','invalid_action_code','invalid_action_desc','invalid_extent','invalid_agency_code','invalid_agency_desc');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_dt_yymmdd' => 6,'invalid_record_type' => 7,'invalid_segment' => 8,'invalid_file_number' => 9,'invalid_state' => 10,'invalid_state_desc' => 11,'invalid_zip5' => 12,'invalid_action_code' => 13,'invalid_action_desc' => 14,'invalid_extent' => 15,'invalid_agency_code' => 16,'invalid_agency_desc' => 17,0);
 
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
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','C']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_segment(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['6510','6510']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('6510|6510'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT MakeFT_invalid_action_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_action_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['51','52','55','57','58']);
EXPORT InValidMessageFT_invalid_action_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('51|52|55|57|58'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_action_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_action_desc(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['SUSPND-B','INELIG-F','','INELG-H1','INELG-H2','DEBARR-C']);
EXPORT InValidMessageFT_invalid_action_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('SUSPND-B|INELIG-F||INELG-H1|INELG-H2|DEBARR-C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_extent(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_extent(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['GOVERNMENT WIDE','WITHIN GPO','WITHIN PS']);
EXPORT InValidMessageFT_invalid_extent(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('GOVERNMENT WIDE|WITHIN GPO|WITHIN PS'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_agency_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_agency_code(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_agency_code(s)>0);
EXPORT InValidMessageFT_invalid_agency_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_agency_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_agency_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_agency_desc(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_agency_desc(s)>0);
EXPORT InValidMessageFT_invalid_agency_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_agency_desc'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_reported_yymmdd','action_code','action_desc','co_bus_name','co_bus_address','co_bus_city','co_bus_state_code','co_bus_state_desc','co_bus_zip','extent_of_action','agency_code','agency_desc','date_reported','prep_addr_line1','prep_addr_last_line','clean_business_address_prim_range','clean_business_address_prim_name','clean_business_address_p_city_name','clean_business_address_v_city_name','clean_business_address_st','clean_business_address_zip','clean_business_name_title','clean_business_name_fname','clean_business_name_mname','clean_business_name_lname','clean_business_name_name_suffix');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_reported_yymmdd','action_code','action_desc','co_bus_name','co_bus_address','co_bus_city','co_bus_state_code','co_bus_state_desc','co_bus_zip','extent_of_action','agency_code','agency_desc','date_reported','prep_addr_line1','prep_addr_last_line','clean_business_address_prim_range','clean_business_address_prim_name','clean_business_address_p_city_name','clean_business_address_v_city_name','clean_business_address_st','clean_business_address_zip','clean_business_name_title','clean_business_name_fname','clean_business_name_mname','clean_business_name_lname','clean_business_name_name_suffix');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'segment_code' => 13,'sequence_number' => 14,'orig_date_reported_yymmdd' => 15,'action_code' => 16,'action_desc' => 17,'co_bus_name' => 18,'co_bus_address' => 19,'co_bus_city' => 20,'co_bus_state_code' => 21,'co_bus_state_desc' => 22,'co_bus_zip' => 23,'extent_of_action' => 24,'agency_code' => 25,'agency_desc' => 26,'date_reported' => 27,'prep_addr_line1' => 28,'prep_addr_last_line' => 29,'clean_business_address_prim_range' => 30,'clean_business_address_prim_name' => 31,'clean_business_address_p_city_name' => 32,'clean_business_address_v_city_name' => 33,'clean_business_address_st' => 34,'clean_business_address_zip' => 35,'clean_business_name_title' => 36,'clean_business_name_fname' => 37,'clean_business_name_mname' => 38,'clean_business_name_lname' => 39,'clean_business_name_name_suffix' => 40,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_orig_date_reported_yymmdd(SALT311.StrType s0) := MakeFT_invalid_dt_yymmdd(s0);
EXPORT InValid_orig_date_reported_yymmdd(SALT311.StrType s) := InValidFT_invalid_dt_yymmdd(s);
EXPORT InValidMessage_orig_date_reported_yymmdd(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_yymmdd(wh);
 
EXPORT Make_action_code(SALT311.StrType s0) := MakeFT_invalid_action_code(s0);
EXPORT InValid_action_code(SALT311.StrType s) := InValidFT_invalid_action_code(s);
EXPORT InValidMessage_action_code(UNSIGNED1 wh) := InValidMessageFT_invalid_action_code(wh);
 
EXPORT Make_action_desc(SALT311.StrType s0) := MakeFT_invalid_action_desc(s0);
EXPORT InValid_action_desc(SALT311.StrType s) := InValidFT_invalid_action_desc(s);
EXPORT InValidMessage_action_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_action_desc(wh);
 
EXPORT Make_co_bus_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_co_bus_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_co_bus_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_co_bus_address(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_co_bus_address(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_co_bus_address(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_co_bus_city(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_co_bus_city(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_co_bus_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_co_bus_state_code(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_co_bus_state_code(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_co_bus_state_code(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_co_bus_state_desc(SALT311.StrType s0) := MakeFT_invalid_state_desc(s0);
EXPORT InValid_co_bus_state_desc(SALT311.StrType s) := InValidFT_invalid_state_desc(s);
EXPORT InValidMessage_co_bus_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_state_desc(wh);
 
EXPORT Make_co_bus_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_co_bus_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_co_bus_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_extent_of_action(SALT311.StrType s0) := MakeFT_invalid_extent(s0);
EXPORT InValid_extent_of_action(SALT311.StrType s) := InValidFT_invalid_extent(s);
EXPORT InValidMessage_extent_of_action(UNSIGNED1 wh) := InValidMessageFT_invalid_extent(wh);
 
EXPORT Make_agency_code(SALT311.StrType s0) := MakeFT_invalid_agency_code(s0);
EXPORT InValid_agency_code(SALT311.StrType s) := InValidFT_invalid_agency_code(s);
EXPORT InValidMessage_agency_code(UNSIGNED1 wh) := InValidMessageFT_invalid_agency_code(wh);
 
EXPORT Make_agency_desc(SALT311.StrType s0) := MakeFT_invalid_agency_desc(s0);
EXPORT InValid_agency_desc(SALT311.StrType s) := InValidFT_invalid_agency_desc(s);
EXPORT InValidMessage_agency_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_agency_desc(wh);
 
EXPORT Make_date_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_prep_addr_line1(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_last_line(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_last_line(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_last_line(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_address_prim_range(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_address_prim_range(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_address_prim_range(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_address_prim_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_address_prim_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_address_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_address_p_city_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_address_p_city_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_address_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_address_v_city_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_address_v_city_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_address_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_address_st(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_clean_business_address_st(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_clean_business_address_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_clean_business_address_zip(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_clean_business_address_zip(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_clean_business_address_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_clean_business_name_title(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_name_title(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_name_title(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_name_fname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_name_fname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_name_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_name_mname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_name_mname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_name_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_name_lname(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_name_lname(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_name_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_business_name_name_suffix(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_business_name_name_suffix(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_business_name_name_suffix(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
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
    BOOLEAN Diff_orig_date_reported_yymmdd;
    BOOLEAN Diff_action_code;
    BOOLEAN Diff_action_desc;
    BOOLEAN Diff_co_bus_name;
    BOOLEAN Diff_co_bus_address;
    BOOLEAN Diff_co_bus_city;
    BOOLEAN Diff_co_bus_state_code;
    BOOLEAN Diff_co_bus_state_desc;
    BOOLEAN Diff_co_bus_zip;
    BOOLEAN Diff_extent_of_action;
    BOOLEAN Diff_agency_code;
    BOOLEAN Diff_agency_desc;
    BOOLEAN Diff_date_reported;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_last_line;
    BOOLEAN Diff_clean_business_address_prim_range;
    BOOLEAN Diff_clean_business_address_prim_name;
    BOOLEAN Diff_clean_business_address_p_city_name;
    BOOLEAN Diff_clean_business_address_v_city_name;
    BOOLEAN Diff_clean_business_address_st;
    BOOLEAN Diff_clean_business_address_zip;
    BOOLEAN Diff_clean_business_name_title;
    BOOLEAN Diff_clean_business_name_fname;
    BOOLEAN Diff_clean_business_name_mname;
    BOOLEAN Diff_clean_business_name_lname;
    BOOLEAN Diff_clean_business_name_name_suffix;
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
    SELF.Diff_orig_date_reported_yymmdd := le.orig_date_reported_yymmdd <> ri.orig_date_reported_yymmdd;
    SELF.Diff_action_code := le.action_code <> ri.action_code;
    SELF.Diff_action_desc := le.action_desc <> ri.action_desc;
    SELF.Diff_co_bus_name := le.co_bus_name <> ri.co_bus_name;
    SELF.Diff_co_bus_address := le.co_bus_address <> ri.co_bus_address;
    SELF.Diff_co_bus_city := le.co_bus_city <> ri.co_bus_city;
    SELF.Diff_co_bus_state_code := le.co_bus_state_code <> ri.co_bus_state_code;
    SELF.Diff_co_bus_state_desc := le.co_bus_state_desc <> ri.co_bus_state_desc;
    SELF.Diff_co_bus_zip := le.co_bus_zip <> ri.co_bus_zip;
    SELF.Diff_extent_of_action := le.extent_of_action <> ri.extent_of_action;
    SELF.Diff_agency_code := le.agency_code <> ri.agency_code;
    SELF.Diff_agency_desc := le.agency_desc <> ri.agency_desc;
    SELF.Diff_date_reported := le.date_reported <> ri.date_reported;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_last_line := le.prep_addr_last_line <> ri.prep_addr_last_line;
    SELF.Diff_clean_business_address_prim_range := le.clean_business_address_prim_range <> ri.clean_business_address_prim_range;
    SELF.Diff_clean_business_address_prim_name := le.clean_business_address_prim_name <> ri.clean_business_address_prim_name;
    SELF.Diff_clean_business_address_p_city_name := le.clean_business_address_p_city_name <> ri.clean_business_address_p_city_name;
    SELF.Diff_clean_business_address_v_city_name := le.clean_business_address_v_city_name <> ri.clean_business_address_v_city_name;
    SELF.Diff_clean_business_address_st := le.clean_business_address_st <> ri.clean_business_address_st;
    SELF.Diff_clean_business_address_zip := le.clean_business_address_zip <> ri.clean_business_address_zip;
    SELF.Diff_clean_business_name_title := le.clean_business_name_title <> ri.clean_business_name_title;
    SELF.Diff_clean_business_name_fname := le.clean_business_name_fname <> ri.clean_business_name_fname;
    SELF.Diff_clean_business_name_mname := le.clean_business_name_mname <> ri.clean_business_name_mname;
    SELF.Diff_clean_business_name_lname := le.clean_business_name_lname <> ri.clean_business_name_lname;
    SELF.Diff_clean_business_name_name_suffix := le.clean_business_name_name_suffix <> ri.clean_business_name_name_suffix;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_orig_date_reported_yymmdd,1,0)+ IF( SELF.Diff_action_code,1,0)+ IF( SELF.Diff_action_desc,1,0)+ IF( SELF.Diff_co_bus_name,1,0)+ IF( SELF.Diff_co_bus_address,1,0)+ IF( SELF.Diff_co_bus_city,1,0)+ IF( SELF.Diff_co_bus_state_code,1,0)+ IF( SELF.Diff_co_bus_state_desc,1,0)+ IF( SELF.Diff_co_bus_zip,1,0)+ IF( SELF.Diff_extent_of_action,1,0)+ IF( SELF.Diff_agency_code,1,0)+ IF( SELF.Diff_agency_desc,1,0)+ IF( SELF.Diff_date_reported,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_last_line,1,0)+ IF( SELF.Diff_clean_business_address_prim_range,1,0)+ IF( SELF.Diff_clean_business_address_prim_name,1,0)+ IF( SELF.Diff_clean_business_address_p_city_name,1,0)+ IF( SELF.Diff_clean_business_address_v_city_name,1,0)+ IF( SELF.Diff_clean_business_address_st,1,0)+ IF( SELF.Diff_clean_business_address_zip,1,0)+ IF( SELF.Diff_clean_business_name_title,1,0)+ IF( SELF.Diff_clean_business_name_fname,1,0)+ IF( SELF.Diff_clean_business_name_mname,1,0)+ IF( SELF.Diff_clean_business_name_lname,1,0)+ IF( SELF.Diff_clean_business_name_name_suffix,1,0);
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
    Count_Diff_orig_date_reported_yymmdd := COUNT(GROUP,%Closest%.Diff_orig_date_reported_yymmdd);
    Count_Diff_action_code := COUNT(GROUP,%Closest%.Diff_action_code);
    Count_Diff_action_desc := COUNT(GROUP,%Closest%.Diff_action_desc);
    Count_Diff_co_bus_name := COUNT(GROUP,%Closest%.Diff_co_bus_name);
    Count_Diff_co_bus_address := COUNT(GROUP,%Closest%.Diff_co_bus_address);
    Count_Diff_co_bus_city := COUNT(GROUP,%Closest%.Diff_co_bus_city);
    Count_Diff_co_bus_state_code := COUNT(GROUP,%Closest%.Diff_co_bus_state_code);
    Count_Diff_co_bus_state_desc := COUNT(GROUP,%Closest%.Diff_co_bus_state_desc);
    Count_Diff_co_bus_zip := COUNT(GROUP,%Closest%.Diff_co_bus_zip);
    Count_Diff_extent_of_action := COUNT(GROUP,%Closest%.Diff_extent_of_action);
    Count_Diff_agency_code := COUNT(GROUP,%Closest%.Diff_agency_code);
    Count_Diff_agency_desc := COUNT(GROUP,%Closest%.Diff_agency_desc);
    Count_Diff_date_reported := COUNT(GROUP,%Closest%.Diff_date_reported);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_last_line := COUNT(GROUP,%Closest%.Diff_prep_addr_last_line);
    Count_Diff_clean_business_address_prim_range := COUNT(GROUP,%Closest%.Diff_clean_business_address_prim_range);
    Count_Diff_clean_business_address_prim_name := COUNT(GROUP,%Closest%.Diff_clean_business_address_prim_name);
    Count_Diff_clean_business_address_p_city_name := COUNT(GROUP,%Closest%.Diff_clean_business_address_p_city_name);
    Count_Diff_clean_business_address_v_city_name := COUNT(GROUP,%Closest%.Diff_clean_business_address_v_city_name);
    Count_Diff_clean_business_address_st := COUNT(GROUP,%Closest%.Diff_clean_business_address_st);
    Count_Diff_clean_business_address_zip := COUNT(GROUP,%Closest%.Diff_clean_business_address_zip);
    Count_Diff_clean_business_name_title := COUNT(GROUP,%Closest%.Diff_clean_business_name_title);
    Count_Diff_clean_business_name_fname := COUNT(GROUP,%Closest%.Diff_clean_business_name_fname);
    Count_Diff_clean_business_name_mname := COUNT(GROUP,%Closest%.Diff_clean_business_name_mname);
    Count_Diff_clean_business_name_lname := COUNT(GROUP,%Closest%.Diff_clean_business_name_lname);
    Count_Diff_clean_business_name_name_suffix := COUNT(GROUP,%Closest%.Diff_clean_business_name_name_suffix);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
