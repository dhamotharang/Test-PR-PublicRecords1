IMPORT SALT311;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_4510_Fields := MODULE
 
EXPORT NumFields := 38;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_or_allzeros','invalid_pastdate','invalid_dt_first_seen','invalid_dt_yymmdd','invalid_record_type','invalid_segment','invalid_file_number','invalid_type_code','invalid_type_desc','invalid_action_code','invalid_action_desc','invalid_coll_code','invalid_coll_desc','invalid_state','invalid_state_desc');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_or_allzeros' => 3,'invalid_pastdate' => 4,'invalid_dt_first_seen' => 5,'invalid_dt_yymmdd' => 6,'invalid_record_type' => 7,'invalid_segment' => 8,'invalid_file_number' => 9,'invalid_type_code' => 10,'invalid_type_desc' => 11,'invalid_action_code' => 12,'invalid_action_desc' => 13,'invalid_coll_code' => 14,'invalid_coll_desc' => 15,'invalid_state' => 16,'invalid_state_desc' => 17,0);
 
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
EXPORT InValidFT_invalid_segment(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['4510','4510']);
EXPORT InValidMessageFT_invalid_segment(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('4510|4510'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_file_number(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_file_number(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) = 9));
EXPORT InValidMessageFT_invalid_file_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT311.HygieneErrors.NotLength('9'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['08','08']);
EXPORT InValidMessageFT_invalid_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('08|08'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_type_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_type_desc(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['UCC-','UCC-']);
EXPORT InValidMessageFT_invalid_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('UCC-|UCC-'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_action_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_action_code(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_valid_action_code(s)>0);
EXPORT InValidMessageFT_invalid_action_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_valid_action_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_action_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_action_desc(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_valid_action_desc(s)>0);
EXPORT InValidMessageFT_invalid_action_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_valid_action_desc'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_coll_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_coll_code(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_valid_4510_coll_code(s)>0);
EXPORT InValidMessageFT_invalid_coll_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_valid_4510_coll_code'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_coll_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_coll_desc(SALT311.StrType s) := WHICH(~Scrubs_EBR.Functions.fn_valid_4510_coll_desc(s)>0);
EXPORT InValidMessageFT_invalid_coll_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_EBR.Functions.fn_valid_4510_coll_desc'),SALT311.HygieneErrors.Good);
 
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
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_filed_yymmdd','type_code','type_desc','action_code','action_desc','document_number','filing_location','coll_code1','coll_desc1','coll_code2','coll_desc2','coll_code3','coll_desc3','coll_code4','coll_desc4','coll_code5','coll_desc5','coll_code6','coll_desc6','orig_file_state_code','orig_file_state_desc','orig_file_number','date_filed');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_filed_yymmdd','type_code','type_desc','action_code','action_desc','document_number','filing_location','coll_code1','coll_desc1','coll_code2','coll_desc2','coll_code3','coll_desc3','coll_code4','coll_desc4','coll_code5','coll_desc5','coll_code6','coll_desc6','orig_file_state_code','orig_file_state_desc','orig_file_number','date_filed');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'powid' => 0,'proxid' => 1,'seleid' => 2,'orgid' => 3,'ultid' => 4,'bdid' => 5,'date_first_seen' => 6,'date_last_seen' => 7,'process_date_first_seen' => 8,'process_date_last_seen' => 9,'record_type' => 10,'process_date' => 11,'file_number' => 12,'segment_code' => 13,'sequence_number' => 14,'orig_date_filed_yymmdd' => 15,'type_code' => 16,'type_desc' => 17,'action_code' => 18,'action_desc' => 19,'document_number' => 20,'filing_location' => 21,'coll_code1' => 22,'coll_desc1' => 23,'coll_code2' => 24,'coll_desc2' => 25,'coll_code3' => 26,'coll_desc3' => 27,'coll_code4' => 28,'coll_desc4' => 29,'coll_code5' => 30,'coll_desc5' => 31,'coll_code6' => 32,'coll_desc6' => 33,'orig_file_state_code' => 34,'orig_file_state_desc' => 35,'orig_file_number' => 36,'date_filed' => 37,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_orig_date_filed_yymmdd(SALT311.StrType s0) := MakeFT_invalid_dt_yymmdd(s0);
EXPORT InValid_orig_date_filed_yymmdd(SALT311.StrType s) := InValidFT_invalid_dt_yymmdd(s);
EXPORT InValidMessage_orig_date_filed_yymmdd(UNSIGNED1 wh) := InValidMessageFT_invalid_dt_yymmdd(wh);
 
EXPORT Make_type_code(SALT311.StrType s0) := MakeFT_invalid_type_code(s0);
EXPORT InValid_type_code(SALT311.StrType s) := InValidFT_invalid_type_code(s);
EXPORT InValidMessage_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_type_code(wh);
 
EXPORT Make_type_desc(SALT311.StrType s0) := MakeFT_invalid_type_desc(s0);
EXPORT InValid_type_desc(SALT311.StrType s) := InValidFT_invalid_type_desc(s);
EXPORT InValidMessage_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_type_desc(wh);
 
EXPORT Make_action_code(SALT311.StrType s0) := MakeFT_invalid_action_code(s0);
EXPORT InValid_action_code(SALT311.StrType s) := InValidFT_invalid_action_code(s);
EXPORT InValidMessage_action_code(UNSIGNED1 wh) := InValidMessageFT_invalid_action_code(wh);
 
EXPORT Make_action_desc(SALT311.StrType s0) := MakeFT_invalid_action_desc(s0);
EXPORT InValid_action_desc(SALT311.StrType s) := InValidFT_invalid_action_desc(s);
EXPORT InValidMessage_action_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_action_desc(wh);
 
EXPORT Make_document_number(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_document_number(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_document_number(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_filing_location(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_filing_location(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_filing_location(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_coll_code1(SALT311.StrType s0) := MakeFT_invalid_coll_code(s0);
EXPORT InValid_coll_code1(SALT311.StrType s) := InValidFT_invalid_coll_code(s);
EXPORT InValidMessage_coll_code1(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_code(wh);
 
EXPORT Make_coll_desc1(SALT311.StrType s0) := MakeFT_invalid_coll_desc(s0);
EXPORT InValid_coll_desc1(SALT311.StrType s) := InValidFT_invalid_coll_desc(s);
EXPORT InValidMessage_coll_desc1(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_desc(wh);
 
EXPORT Make_coll_code2(SALT311.StrType s0) := MakeFT_invalid_coll_code(s0);
EXPORT InValid_coll_code2(SALT311.StrType s) := InValidFT_invalid_coll_code(s);
EXPORT InValidMessage_coll_code2(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_code(wh);
 
EXPORT Make_coll_desc2(SALT311.StrType s0) := MakeFT_invalid_coll_desc(s0);
EXPORT InValid_coll_desc2(SALT311.StrType s) := InValidFT_invalid_coll_desc(s);
EXPORT InValidMessage_coll_desc2(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_desc(wh);
 
EXPORT Make_coll_code3(SALT311.StrType s0) := MakeFT_invalid_coll_code(s0);
EXPORT InValid_coll_code3(SALT311.StrType s) := InValidFT_invalid_coll_code(s);
EXPORT InValidMessage_coll_code3(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_code(wh);
 
EXPORT Make_coll_desc3(SALT311.StrType s0) := MakeFT_invalid_coll_desc(s0);
EXPORT InValid_coll_desc3(SALT311.StrType s) := InValidFT_invalid_coll_desc(s);
EXPORT InValidMessage_coll_desc3(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_desc(wh);
 
EXPORT Make_coll_code4(SALT311.StrType s0) := MakeFT_invalid_coll_code(s0);
EXPORT InValid_coll_code4(SALT311.StrType s) := InValidFT_invalid_coll_code(s);
EXPORT InValidMessage_coll_code4(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_code(wh);
 
EXPORT Make_coll_desc4(SALT311.StrType s0) := MakeFT_invalid_coll_desc(s0);
EXPORT InValid_coll_desc4(SALT311.StrType s) := InValidFT_invalid_coll_desc(s);
EXPORT InValidMessage_coll_desc4(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_desc(wh);
 
EXPORT Make_coll_code5(SALT311.StrType s0) := MakeFT_invalid_coll_code(s0);
EXPORT InValid_coll_code5(SALT311.StrType s) := InValidFT_invalid_coll_code(s);
EXPORT InValidMessage_coll_code5(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_code(wh);
 
EXPORT Make_coll_desc5(SALT311.StrType s0) := MakeFT_invalid_coll_desc(s0);
EXPORT InValid_coll_desc5(SALT311.StrType s) := InValidFT_invalid_coll_desc(s);
EXPORT InValidMessage_coll_desc5(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_desc(wh);
 
EXPORT Make_coll_code6(SALT311.StrType s0) := MakeFT_invalid_coll_code(s0);
EXPORT InValid_coll_code6(SALT311.StrType s) := InValidFT_invalid_coll_code(s);
EXPORT InValidMessage_coll_code6(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_code(wh);
 
EXPORT Make_coll_desc6(SALT311.StrType s0) := MakeFT_invalid_coll_desc(s0);
EXPORT InValid_coll_desc6(SALT311.StrType s) := InValidFT_invalid_coll_desc(s);
EXPORT InValidMessage_coll_desc6(UNSIGNED1 wh) := InValidMessageFT_invalid_coll_desc(wh);
 
EXPORT Make_orig_file_state_code(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_orig_file_state_code(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_orig_file_state_code(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_orig_file_state_desc(SALT311.StrType s0) := MakeFT_invalid_state_desc(s0);
EXPORT InValid_orig_file_state_desc(SALT311.StrType s) := InValidFT_invalid_state_desc(s);
EXPORT InValidMessage_orig_file_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_state_desc(wh);
 
EXPORT Make_orig_file_number(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_orig_file_number(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_orig_file_number(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_date_filed(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_date_filed(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_date_filed(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
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
    BOOLEAN Diff_orig_date_filed_yymmdd;
    BOOLEAN Diff_type_code;
    BOOLEAN Diff_type_desc;
    BOOLEAN Diff_action_code;
    BOOLEAN Diff_action_desc;
    BOOLEAN Diff_document_number;
    BOOLEAN Diff_filing_location;
    BOOLEAN Diff_coll_code1;
    BOOLEAN Diff_coll_desc1;
    BOOLEAN Diff_coll_code2;
    BOOLEAN Diff_coll_desc2;
    BOOLEAN Diff_coll_code3;
    BOOLEAN Diff_coll_desc3;
    BOOLEAN Diff_coll_code4;
    BOOLEAN Diff_coll_desc4;
    BOOLEAN Diff_coll_code5;
    BOOLEAN Diff_coll_desc5;
    BOOLEAN Diff_coll_code6;
    BOOLEAN Diff_coll_desc6;
    BOOLEAN Diff_orig_file_state_code;
    BOOLEAN Diff_orig_file_state_desc;
    BOOLEAN Diff_orig_file_number;
    BOOLEAN Diff_date_filed;
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
    SELF.Diff_orig_date_filed_yymmdd := le.orig_date_filed_yymmdd <> ri.orig_date_filed_yymmdd;
    SELF.Diff_type_code := le.type_code <> ri.type_code;
    SELF.Diff_type_desc := le.type_desc <> ri.type_desc;
    SELF.Diff_action_code := le.action_code <> ri.action_code;
    SELF.Diff_action_desc := le.action_desc <> ri.action_desc;
    SELF.Diff_document_number := le.document_number <> ri.document_number;
    SELF.Diff_filing_location := le.filing_location <> ri.filing_location;
    SELF.Diff_coll_code1 := le.coll_code1 <> ri.coll_code1;
    SELF.Diff_coll_desc1 := le.coll_desc1 <> ri.coll_desc1;
    SELF.Diff_coll_code2 := le.coll_code2 <> ri.coll_code2;
    SELF.Diff_coll_desc2 := le.coll_desc2 <> ri.coll_desc2;
    SELF.Diff_coll_code3 := le.coll_code3 <> ri.coll_code3;
    SELF.Diff_coll_desc3 := le.coll_desc3 <> ri.coll_desc3;
    SELF.Diff_coll_code4 := le.coll_code4 <> ri.coll_code4;
    SELF.Diff_coll_desc4 := le.coll_desc4 <> ri.coll_desc4;
    SELF.Diff_coll_code5 := le.coll_code5 <> ri.coll_code5;
    SELF.Diff_coll_desc5 := le.coll_desc5 <> ri.coll_desc5;
    SELF.Diff_coll_code6 := le.coll_code6 <> ri.coll_code6;
    SELF.Diff_coll_desc6 := le.coll_desc6 <> ri.coll_desc6;
    SELF.Diff_orig_file_state_code := le.orig_file_state_code <> ri.orig_file_state_code;
    SELF.Diff_orig_file_state_desc := le.orig_file_state_desc <> ri.orig_file_state_desc;
    SELF.Diff_orig_file_number := le.orig_file_number <> ri.orig_file_number;
    SELF.Diff_date_filed := le.date_filed <> ri.date_filed;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_date_first_seen,1,0)+ IF( SELF.Diff_date_last_seen,1,0)+ IF( SELF.Diff_process_date_first_seen,1,0)+ IF( SELF.Diff_process_date_last_seen,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_file_number,1,0)+ IF( SELF.Diff_segment_code,1,0)+ IF( SELF.Diff_sequence_number,1,0)+ IF( SELF.Diff_orig_date_filed_yymmdd,1,0)+ IF( SELF.Diff_type_code,1,0)+ IF( SELF.Diff_type_desc,1,0)+ IF( SELF.Diff_action_code,1,0)+ IF( SELF.Diff_action_desc,1,0)+ IF( SELF.Diff_document_number,1,0)+ IF( SELF.Diff_filing_location,1,0)+ IF( SELF.Diff_coll_code1,1,0)+ IF( SELF.Diff_coll_desc1,1,0)+ IF( SELF.Diff_coll_code2,1,0)+ IF( SELF.Diff_coll_desc2,1,0)+ IF( SELF.Diff_coll_code3,1,0)+ IF( SELF.Diff_coll_desc3,1,0)+ IF( SELF.Diff_coll_code4,1,0)+ IF( SELF.Diff_coll_desc4,1,0)+ IF( SELF.Diff_coll_code5,1,0)+ IF( SELF.Diff_coll_desc5,1,0)+ IF( SELF.Diff_coll_code6,1,0)+ IF( SELF.Diff_coll_desc6,1,0)+ IF( SELF.Diff_orig_file_state_code,1,0)+ IF( SELF.Diff_orig_file_state_desc,1,0)+ IF( SELF.Diff_orig_file_number,1,0)+ IF( SELF.Diff_date_filed,1,0);
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
    Count_Diff_orig_date_filed_yymmdd := COUNT(GROUP,%Closest%.Diff_orig_date_filed_yymmdd);
    Count_Diff_type_code := COUNT(GROUP,%Closest%.Diff_type_code);
    Count_Diff_type_desc := COUNT(GROUP,%Closest%.Diff_type_desc);
    Count_Diff_action_code := COUNT(GROUP,%Closest%.Diff_action_code);
    Count_Diff_action_desc := COUNT(GROUP,%Closest%.Diff_action_desc);
    Count_Diff_document_number := COUNT(GROUP,%Closest%.Diff_document_number);
    Count_Diff_filing_location := COUNT(GROUP,%Closest%.Diff_filing_location);
    Count_Diff_coll_code1 := COUNT(GROUP,%Closest%.Diff_coll_code1);
    Count_Diff_coll_desc1 := COUNT(GROUP,%Closest%.Diff_coll_desc1);
    Count_Diff_coll_code2 := COUNT(GROUP,%Closest%.Diff_coll_code2);
    Count_Diff_coll_desc2 := COUNT(GROUP,%Closest%.Diff_coll_desc2);
    Count_Diff_coll_code3 := COUNT(GROUP,%Closest%.Diff_coll_code3);
    Count_Diff_coll_desc3 := COUNT(GROUP,%Closest%.Diff_coll_desc3);
    Count_Diff_coll_code4 := COUNT(GROUP,%Closest%.Diff_coll_code4);
    Count_Diff_coll_desc4 := COUNT(GROUP,%Closest%.Diff_coll_desc4);
    Count_Diff_coll_code5 := COUNT(GROUP,%Closest%.Diff_coll_code5);
    Count_Diff_coll_desc5 := COUNT(GROUP,%Closest%.Diff_coll_desc5);
    Count_Diff_coll_code6 := COUNT(GROUP,%Closest%.Diff_coll_code6);
    Count_Diff_coll_desc6 := COUNT(GROUP,%Closest%.Diff_coll_desc6);
    Count_Diff_orig_file_state_code := COUNT(GROUP,%Closest%.Diff_orig_file_state_code);
    Count_Diff_orig_file_state_desc := COUNT(GROUP,%Closest%.Diff_orig_file_state_desc);
    Count_Diff_orig_file_number := COUNT(GROUP,%Closest%.Diff_orig_file_number);
    Count_Diff_date_filed := COUNT(GROUP,%Closest%.Diff_date_filed);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
