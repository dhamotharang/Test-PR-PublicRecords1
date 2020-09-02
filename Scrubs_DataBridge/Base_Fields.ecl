IMPORT SALT311;
IMPORT Scrubs_DataBridge; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 48;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_generaldate','invalid_pastdate','invalid_trans_date','invalid_record_type','invalid_numeric','invalid_st','invalid_zip5','invalid_phone','invalid_sic','invalid_url','invalid_email','invalid_mail_score','invalid_gender_code','invalid_email_present_flag','invalid_source_code','invalid_email_status');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_generaldate' => 2,'invalid_pastdate' => 3,'invalid_trans_date' => 4,'invalid_record_type' => 5,'invalid_numeric' => 6,'invalid_st' => 7,'invalid_zip5' => 8,'invalid_phone' => 9,'invalid_sic' => 10,'invalid_url' => 11,'invalid_email' => 12,'invalid_mail_score' => 13,'invalid_gender_code' => 14,'invalid_email_present_flag' => 15,'invalid_source_code' => 16,'invalid_email_status' => 17,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_generaldate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_generaldate(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_general_date(s)>0);
EXPORT InValidMessageFT_invalid_generaldate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_general_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_trans_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_trans_date(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_trans_date(s)>0);
EXPORT InValidMessageFT_invalid_trans_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_trans_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','H']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|H'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_st(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_st(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_st(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip5(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip5(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip5(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_sic(s)>0);
EXPORT InValidMessageFT_invalid_sic(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_sic'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_url(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_url(SALT311.StrType s) := WHICH(~Scrubs_DataBridge.Functions.fn_url(s)>0);
EXPORT InValidMessageFT_invalid_url(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_DataBridge.Functions.fn_url'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_email(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'))));
EXPORT InValidMessageFT_invalid_email(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz-.@_,;\'&'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mail_score(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mail_score(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['1','2','3','4','5','6','7','8']);
EXPORT InValidMessageFT_invalid_mail_score(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('1|2|3|4|5|6|7|8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_gender_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_gender_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1','2','3','4','UNDEFINED','']);
EXPORT InValidMessageFT_invalid_gender_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1|2|3|4|UNDEFINED|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email_present_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_email_present_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1','2','3']);
EXPORT InValidMessageFT_invalid_email_present_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1|2|3'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_source_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_source_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['0','1']);
EXPORT InValidMessageFT_invalid_source_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('0|1'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_email_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_email_status(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['VALID','INVALID','UNKNOWN','']);
EXPORT InValidMessageFT_invalid_email_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('VALID|INVALID|UNKNOWN|'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','clean_company_name','clean_telephone_num','state','zip_code5','mail_score','name_gender','web_address','sic8_1','sic8_2','sic8_3','sic8_4','sic6_1','sic6_2','sic6_3','sic6_4','sic6_5','transaction_date','database_site_id','database_individual_id','email','email_present_flag','site_source1','site_source2','site_source3','site_source4','site_source5','site_source6','site_source7','site_source8','site_source9','site_source10','individual_source1','individual_source2','individual_source3','individual_source4','individual_source5','individual_source6','individual_source7','individual_source8','individual_source9','individual_source10','email_status');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','clean_company_name','clean_telephone_num','state','zip_code5','mail_score','name_gender','web_address','sic8_1','sic8_2','sic8_3','sic8_4','sic6_1','sic6_2','sic6_3','sic6_4','sic6_5','transaction_date','database_site_id','database_individual_id','email','email_present_flag','site_source1','site_source2','site_source3','site_source4','site_source5','site_source6','site_source7','site_source8','site_source9','site_source10','individual_source1','individual_source2','individual_source3','individual_source4','individual_source5','individual_source6','individual_source7','individual_source8','individual_source9','individual_source10','email_status');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_first_seen' => 0,'dt_last_seen' => 1,'dt_vendor_first_reported' => 2,'dt_vendor_last_reported' => 3,'process_date' => 4,'record_type' => 5,'clean_company_name' => 6,'clean_telephone_num' => 7,'state' => 8,'zip_code5' => 9,'mail_score' => 10,'name_gender' => 11,'web_address' => 12,'sic8_1' => 13,'sic8_2' => 14,'sic8_3' => 15,'sic8_4' => 16,'sic6_1' => 17,'sic6_2' => 18,'sic6_3' => 19,'sic6_4' => 20,'sic6_5' => 21,'transaction_date' => 22,'database_site_id' => 23,'database_individual_id' => 24,'email' => 25,'email_present_flag' => 26,'site_source1' => 27,'site_source2' => 28,'site_source3' => 29,'site_source4' => 30,'site_source5' => 31,'site_source6' => 32,'site_source7' => 33,'site_source8' => 34,'site_source9' => 35,'site_source10' => 36,'individual_source1' => 37,'individual_source2' => 38,'individual_source3' => 39,'individual_source4' => 40,'individual_source5' => 41,'individual_source6' => 42,'individual_source7' => 43,'individual_source8' => 44,'individual_source9' => 45,'individual_source10' => 46,'email_status' => 47,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['LENGTHS'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_generaldate(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_generaldate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_generaldate(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_clean_company_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_clean_company_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_clean_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_clean_telephone_num(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_telephone_num(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_telephone_num(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_st(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_st(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_st(wh);
 
EXPORT Make_zip_code5(SALT311.StrType s0) := MakeFT_invalid_zip5(s0);
EXPORT InValid_zip_code5(SALT311.StrType s) := InValidFT_invalid_zip5(s);
EXPORT InValidMessage_zip_code5(UNSIGNED1 wh) := InValidMessageFT_invalid_zip5(wh);
 
EXPORT Make_mail_score(SALT311.StrType s0) := MakeFT_invalid_mail_score(s0);
EXPORT InValid_mail_score(SALT311.StrType s) := InValidFT_invalid_mail_score(s);
EXPORT InValidMessage_mail_score(UNSIGNED1 wh) := InValidMessageFT_invalid_mail_score(wh);
 
EXPORT Make_name_gender(SALT311.StrType s0) := MakeFT_invalid_gender_code(s0);
EXPORT InValid_name_gender(SALT311.StrType s) := InValidFT_invalid_gender_code(s);
EXPORT InValidMessage_name_gender(UNSIGNED1 wh) := InValidMessageFT_invalid_gender_code(wh);
 
EXPORT Make_web_address(SALT311.StrType s0) := MakeFT_invalid_url(s0);
EXPORT InValid_web_address(SALT311.StrType s) := InValidFT_invalid_url(s);
EXPORT InValidMessage_web_address(UNSIGNED1 wh) := InValidMessageFT_invalid_url(wh);
 
EXPORT Make_sic8_1(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic8_1(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic8_1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic8_2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic8_2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic8_2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic8_3(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic8_3(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic8_3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic8_4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic8_4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic8_4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_1(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_1(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_1(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_2(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_2(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_2(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_3(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_3(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_3(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_4(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_4(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_4(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_sic6_5(SALT311.StrType s0) := MakeFT_invalid_sic(s0);
EXPORT InValid_sic6_5(SALT311.StrType s) := InValidFT_invalid_sic(s);
EXPORT InValidMessage_sic6_5(UNSIGNED1 wh) := InValidMessageFT_invalid_sic(wh);
 
EXPORT Make_transaction_date(SALT311.StrType s0) := MakeFT_invalid_trans_date(s0);
EXPORT InValid_transaction_date(SALT311.StrType s) := InValidFT_invalid_trans_date(s);
EXPORT InValidMessage_transaction_date(UNSIGNED1 wh) := InValidMessageFT_invalid_trans_date(wh);
 
EXPORT Make_database_site_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_database_site_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_database_site_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_database_individual_id(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_database_individual_id(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_database_individual_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_email(SALT311.StrType s0) := MakeFT_invalid_email(s0);
EXPORT InValid_email(SALT311.StrType s) := InValidFT_invalid_email(s);
EXPORT InValidMessage_email(UNSIGNED1 wh) := InValidMessageFT_invalid_email(wh);
 
EXPORT Make_email_present_flag(SALT311.StrType s0) := MakeFT_invalid_email_present_flag(s0);
EXPORT InValid_email_present_flag(SALT311.StrType s) := InValidFT_invalid_email_present_flag(s);
EXPORT InValidMessage_email_present_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_email_present_flag(wh);
 
EXPORT Make_site_source1(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source1(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source1(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source2(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source2(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source2(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source3(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source3(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source3(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source4(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source4(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source4(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source5(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source5(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source5(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source6(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source6(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source6(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source7(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source7(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source7(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source8(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source8(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source8(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source9(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source9(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source9(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_site_source10(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_site_source10(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_site_source10(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source1(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source1(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source1(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source2(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source2(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source2(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source3(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source3(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source3(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source4(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source4(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source4(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source5(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source5(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source5(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source6(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source6(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source6(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source7(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source7(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source7(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source8(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source8(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source8(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source9(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source9(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source9(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_individual_source10(SALT311.StrType s0) := MakeFT_invalid_source_code(s0);
EXPORT InValid_individual_source10(SALT311.StrType s) := InValidFT_invalid_source_code(s);
EXPORT InValidMessage_individual_source10(UNSIGNED1 wh) := InValidMessageFT_invalid_source_code(wh);
 
EXPORT Make_email_status(SALT311.StrType s0) := MakeFT_invalid_email_status(s0);
EXPORT InValid_email_status(SALT311.StrType s) := InValidFT_invalid_email_status(s);
EXPORT InValidMessage_email_status(UNSIGNED1 wh) := InValidMessageFT_invalid_email_status(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_DataBridge;
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
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_clean_company_name;
    BOOLEAN Diff_clean_telephone_num;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code5;
    BOOLEAN Diff_mail_score;
    BOOLEAN Diff_name_gender;
    BOOLEAN Diff_web_address;
    BOOLEAN Diff_sic8_1;
    BOOLEAN Diff_sic8_2;
    BOOLEAN Diff_sic8_3;
    BOOLEAN Diff_sic8_4;
    BOOLEAN Diff_sic6_1;
    BOOLEAN Diff_sic6_2;
    BOOLEAN Diff_sic6_3;
    BOOLEAN Diff_sic6_4;
    BOOLEAN Diff_sic6_5;
    BOOLEAN Diff_transaction_date;
    BOOLEAN Diff_database_site_id;
    BOOLEAN Diff_database_individual_id;
    BOOLEAN Diff_email;
    BOOLEAN Diff_email_present_flag;
    BOOLEAN Diff_site_source1;
    BOOLEAN Diff_site_source2;
    BOOLEAN Diff_site_source3;
    BOOLEAN Diff_site_source4;
    BOOLEAN Diff_site_source5;
    BOOLEAN Diff_site_source6;
    BOOLEAN Diff_site_source7;
    BOOLEAN Diff_site_source8;
    BOOLEAN Diff_site_source9;
    BOOLEAN Diff_site_source10;
    BOOLEAN Diff_individual_source1;
    BOOLEAN Diff_individual_source2;
    BOOLEAN Diff_individual_source3;
    BOOLEAN Diff_individual_source4;
    BOOLEAN Diff_individual_source5;
    BOOLEAN Diff_individual_source6;
    BOOLEAN Diff_individual_source7;
    BOOLEAN Diff_individual_source8;
    BOOLEAN Diff_individual_source9;
    BOOLEAN Diff_individual_source10;
    BOOLEAN Diff_email_status;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_clean_company_name := le.clean_company_name <> ri.clean_company_name;
    SELF.Diff_clean_telephone_num := le.clean_telephone_num <> ri.clean_telephone_num;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code5 := le.zip_code5 <> ri.zip_code5;
    SELF.Diff_mail_score := le.mail_score <> ri.mail_score;
    SELF.Diff_name_gender := le.name_gender <> ri.name_gender;
    SELF.Diff_web_address := le.web_address <> ri.web_address;
    SELF.Diff_sic8_1 := le.sic8_1 <> ri.sic8_1;
    SELF.Diff_sic8_2 := le.sic8_2 <> ri.sic8_2;
    SELF.Diff_sic8_3 := le.sic8_3 <> ri.sic8_3;
    SELF.Diff_sic8_4 := le.sic8_4 <> ri.sic8_4;
    SELF.Diff_sic6_1 := le.sic6_1 <> ri.sic6_1;
    SELF.Diff_sic6_2 := le.sic6_2 <> ri.sic6_2;
    SELF.Diff_sic6_3 := le.sic6_3 <> ri.sic6_3;
    SELF.Diff_sic6_4 := le.sic6_4 <> ri.sic6_4;
    SELF.Diff_sic6_5 := le.sic6_5 <> ri.sic6_5;
    SELF.Diff_transaction_date := le.transaction_date <> ri.transaction_date;
    SELF.Diff_database_site_id := le.database_site_id <> ri.database_site_id;
    SELF.Diff_database_individual_id := le.database_individual_id <> ri.database_individual_id;
    SELF.Diff_email := le.email <> ri.email;
    SELF.Diff_email_present_flag := le.email_present_flag <> ri.email_present_flag;
    SELF.Diff_site_source1 := le.site_source1 <> ri.site_source1;
    SELF.Diff_site_source2 := le.site_source2 <> ri.site_source2;
    SELF.Diff_site_source3 := le.site_source3 <> ri.site_source3;
    SELF.Diff_site_source4 := le.site_source4 <> ri.site_source4;
    SELF.Diff_site_source5 := le.site_source5 <> ri.site_source5;
    SELF.Diff_site_source6 := le.site_source6 <> ri.site_source6;
    SELF.Diff_site_source7 := le.site_source7 <> ri.site_source7;
    SELF.Diff_site_source8 := le.site_source8 <> ri.site_source8;
    SELF.Diff_site_source9 := le.site_source9 <> ri.site_source9;
    SELF.Diff_site_source10 := le.site_source10 <> ri.site_source10;
    SELF.Diff_individual_source1 := le.individual_source1 <> ri.individual_source1;
    SELF.Diff_individual_source2 := le.individual_source2 <> ri.individual_source2;
    SELF.Diff_individual_source3 := le.individual_source3 <> ri.individual_source3;
    SELF.Diff_individual_source4 := le.individual_source4 <> ri.individual_source4;
    SELF.Diff_individual_source5 := le.individual_source5 <> ri.individual_source5;
    SELF.Diff_individual_source6 := le.individual_source6 <> ri.individual_source6;
    SELF.Diff_individual_source7 := le.individual_source7 <> ri.individual_source7;
    SELF.Diff_individual_source8 := le.individual_source8 <> ri.individual_source8;
    SELF.Diff_individual_source9 := le.individual_source9 <> ri.individual_source9;
    SELF.Diff_individual_source10 := le.individual_source10 <> ri.individual_source10;
    SELF.Diff_email_status := le.email_status <> ri.email_status;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_clean_company_name,1,0)+ IF( SELF.Diff_clean_telephone_num,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code5,1,0)+ IF( SELF.Diff_mail_score,1,0)+ IF( SELF.Diff_name_gender,1,0)+ IF( SELF.Diff_web_address,1,0)+ IF( SELF.Diff_sic8_1,1,0)+ IF( SELF.Diff_sic8_2,1,0)+ IF( SELF.Diff_sic8_3,1,0)+ IF( SELF.Diff_sic8_4,1,0)+ IF( SELF.Diff_sic6_1,1,0)+ IF( SELF.Diff_sic6_2,1,0)+ IF( SELF.Diff_sic6_3,1,0)+ IF( SELF.Diff_sic6_4,1,0)+ IF( SELF.Diff_sic6_5,1,0)+ IF( SELF.Diff_transaction_date,1,0)+ IF( SELF.Diff_database_site_id,1,0)+ IF( SELF.Diff_database_individual_id,1,0)+ IF( SELF.Diff_email,1,0)+ IF( SELF.Diff_email_present_flag,1,0)+ IF( SELF.Diff_site_source1,1,0)+ IF( SELF.Diff_site_source2,1,0)+ IF( SELF.Diff_site_source3,1,0)+ IF( SELF.Diff_site_source4,1,0)+ IF( SELF.Diff_site_source5,1,0)+ IF( SELF.Diff_site_source6,1,0)+ IF( SELF.Diff_site_source7,1,0)+ IF( SELF.Diff_site_source8,1,0)+ IF( SELF.Diff_site_source9,1,0)+ IF( SELF.Diff_site_source10,1,0)+ IF( SELF.Diff_individual_source1,1,0)+ IF( SELF.Diff_individual_source2,1,0)+ IF( SELF.Diff_individual_source3,1,0)+ IF( SELF.Diff_individual_source4,1,0)+ IF( SELF.Diff_individual_source5,1,0)+ IF( SELF.Diff_individual_source6,1,0)+ IF( SELF.Diff_individual_source7,1,0)+ IF( SELF.Diff_individual_source8,1,0)+ IF( SELF.Diff_individual_source9,1,0)+ IF( SELF.Diff_individual_source10,1,0)+ IF( SELF.Diff_email_status,1,0);
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
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_clean_company_name := COUNT(GROUP,%Closest%.Diff_clean_company_name);
    Count_Diff_clean_telephone_num := COUNT(GROUP,%Closest%.Diff_clean_telephone_num);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code5 := COUNT(GROUP,%Closest%.Diff_zip_code5);
    Count_Diff_mail_score := COUNT(GROUP,%Closest%.Diff_mail_score);
    Count_Diff_name_gender := COUNT(GROUP,%Closest%.Diff_name_gender);
    Count_Diff_web_address := COUNT(GROUP,%Closest%.Diff_web_address);
    Count_Diff_sic8_1 := COUNT(GROUP,%Closest%.Diff_sic8_1);
    Count_Diff_sic8_2 := COUNT(GROUP,%Closest%.Diff_sic8_2);
    Count_Diff_sic8_3 := COUNT(GROUP,%Closest%.Diff_sic8_3);
    Count_Diff_sic8_4 := COUNT(GROUP,%Closest%.Diff_sic8_4);
    Count_Diff_sic6_1 := COUNT(GROUP,%Closest%.Diff_sic6_1);
    Count_Diff_sic6_2 := COUNT(GROUP,%Closest%.Diff_sic6_2);
    Count_Diff_sic6_3 := COUNT(GROUP,%Closest%.Diff_sic6_3);
    Count_Diff_sic6_4 := COUNT(GROUP,%Closest%.Diff_sic6_4);
    Count_Diff_sic6_5 := COUNT(GROUP,%Closest%.Diff_sic6_5);
    Count_Diff_transaction_date := COUNT(GROUP,%Closest%.Diff_transaction_date);
    Count_Diff_database_site_id := COUNT(GROUP,%Closest%.Diff_database_site_id);
    Count_Diff_database_individual_id := COUNT(GROUP,%Closest%.Diff_database_individual_id);
    Count_Diff_email := COUNT(GROUP,%Closest%.Diff_email);
    Count_Diff_email_present_flag := COUNT(GROUP,%Closest%.Diff_email_present_flag);
    Count_Diff_site_source1 := COUNT(GROUP,%Closest%.Diff_site_source1);
    Count_Diff_site_source2 := COUNT(GROUP,%Closest%.Diff_site_source2);
    Count_Diff_site_source3 := COUNT(GROUP,%Closest%.Diff_site_source3);
    Count_Diff_site_source4 := COUNT(GROUP,%Closest%.Diff_site_source4);
    Count_Diff_site_source5 := COUNT(GROUP,%Closest%.Diff_site_source5);
    Count_Diff_site_source6 := COUNT(GROUP,%Closest%.Diff_site_source6);
    Count_Diff_site_source7 := COUNT(GROUP,%Closest%.Diff_site_source7);
    Count_Diff_site_source8 := COUNT(GROUP,%Closest%.Diff_site_source8);
    Count_Diff_site_source9 := COUNT(GROUP,%Closest%.Diff_site_source9);
    Count_Diff_site_source10 := COUNT(GROUP,%Closest%.Diff_site_source10);
    Count_Diff_individual_source1 := COUNT(GROUP,%Closest%.Diff_individual_source1);
    Count_Diff_individual_source2 := COUNT(GROUP,%Closest%.Diff_individual_source2);
    Count_Diff_individual_source3 := COUNT(GROUP,%Closest%.Diff_individual_source3);
    Count_Diff_individual_source4 := COUNT(GROUP,%Closest%.Diff_individual_source4);
    Count_Diff_individual_source5 := COUNT(GROUP,%Closest%.Diff_individual_source5);
    Count_Diff_individual_source6 := COUNT(GROUP,%Closest%.Diff_individual_source6);
    Count_Diff_individual_source7 := COUNT(GROUP,%Closest%.Diff_individual_source7);
    Count_Diff_individual_source8 := COUNT(GROUP,%Closest%.Diff_individual_source8);
    Count_Diff_individual_source9 := COUNT(GROUP,%Closest%.Diff_individual_source9);
    Count_Diff_individual_source10 := COUNT(GROUP,%Closest%.Diff_individual_source10);
    Count_Diff_email_status := COUNT(GROUP,%Closest%.Diff_email_status);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
