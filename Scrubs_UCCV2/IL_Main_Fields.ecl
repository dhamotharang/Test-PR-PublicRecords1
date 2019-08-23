IMPORT SALT311;
IMPORT Scrubs,Scrubs_UCCV2; // Import modules for FieldTypes attribute definitions
EXPORT IL_Main_Fields := MODULE
 
EXPORT NumFields := 62;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_numeric','invalid_numeric_blank','invalid_boolean_yn_blank','invalid_empty','invalid_8pastdate','invalid_tmsid','invalid_rmsid','invalid_filing_jurisdiction','invalid_orig_filing_number','invalid_orig_filing_type','invalid_orig_filing_date','invalid_orig_filing_time','invalid_filing_number','invalid_filing_type','invalid_filing_date','invalid_filing_time','invalid_expiration_date');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_numeric' => 2,'invalid_numeric_blank' => 3,'invalid_boolean_yn_blank' => 4,'invalid_empty' => 5,'invalid_8pastdate' => 6,'invalid_tmsid' => 7,'invalid_rmsid' => 8,'invalid_filing_jurisdiction' => 9,'invalid_orig_filing_number' => 10,'invalid_orig_filing_type' => 11,'invalid_orig_filing_date' => 12,'invalid_orig_filing_time' => 13,'invalid_filing_number' => 14,'invalid_filing_type' => 15,'invalid_filing_date' => 16,'invalid_filing_time' => 17,'invalid_expiration_date' => 18,0);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric_blank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric_blank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_numeric_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789 '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean_yn_blank(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean_yn_blank(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N','Y','']);
EXPORT InValidMessageFT_invalid_boolean_yn_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N|Y|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_empty(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_empty(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) = 0));
EXPORT InValidMessageFT_invalid_empty(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('0'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_8pastdate(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_8pastdate(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_8pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT311.HygieneErrors.NotLength('0,8'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_tmsid(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_tmsid(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid(s,'IL')>0);
EXPORT InValidMessageFT_invalid_tmsid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_rmsid(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_rmsid(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid(s,'IL')>0);
EXPORT InValidMessageFT_invalid_rmsid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_state_tmsid_rmsid'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_jurisdiction(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_jurisdiction(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['IL','IL']);
EXPORT InValidMessageFT_invalid_filing_jurisdiction(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('IL|IL'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_filing_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_filing_number(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_non_empty_numeric(s)>0);
EXPORT InValidMessageFT_invalid_orig_filing_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_non_empty_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_filing_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_filing_type(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_il_orig_filing_type(s)>0);
EXPORT InValidMessageFT_invalid_orig_filing_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_il_orig_filing_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_filing_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_filing_date(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_orig_filing_date(s)>0);
EXPORT InValidMessageFT_invalid_orig_filing_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_orig_filing_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_orig_filing_time(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_orig_filing_time(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_check_time(s)>0);
EXPORT InValidMessageFT_invalid_orig_filing_time(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_check_time'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_number(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_numeric_or_blank(s)>0);
EXPORT InValidMessageFT_invalid_filing_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_numeric_or_blank'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_type(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_il_filing_type(s)>0);
EXPORT InValidMessageFT_invalid_filing_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_il_filing_type'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_date(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_filing_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_past_yyyymmdd'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_filing_time(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_filing_time(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_check_time(s)>0);
EXPORT InValidMessageFT_invalid_filing_time(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_check_time'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_expiration_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_expiration_date(SALT311.StrType s) := WHICH(~Scrubs_UCCV2.Functions.fn_expiration_date(s)>0);
EXPORT InValidMessageFT_invalid_expiration_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs_UCCV2.Functions.fn_expiration_date'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'tmsid','rmsid','process_date','static_value','date_vendor_removed','date_vendor_changed','filing_jurisdiction','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','filing_number','filing_number_indc','filing_type','filing_date','filing_time','filing_status','status_type','page','expiration_date','contract_type','vendor_entry_date','vendor_upd_date','statements_filed','continuious_expiration','microfilm_number','amount','irs_serial_number','effective_date','signer_name','title','filing_agency','address','city','state','county','zip','duns_number','cmnt_effective_date','description','collateral_desc','prim_machine','sec_machine','manufacturer_code','manufacturer_name','model','model_year','model_desc','collateral_count','manufactured_year','new_used','serial_number','property_desc','borough','block','lot','collateral_address','air_rights_indc','subterranean_rights_indc','easment_indc','volume','persistent_record_id');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'tmsid','rmsid','process_date','static_value','date_vendor_removed','date_vendor_changed','filing_jurisdiction','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','filing_number','filing_number_indc','filing_type','filing_date','filing_time','filing_status','status_type','page','expiration_date','contract_type','vendor_entry_date','vendor_upd_date','statements_filed','continuious_expiration','microfilm_number','amount','irs_serial_number','effective_date','signer_name','title','filing_agency','address','city','state','county','zip','duns_number','cmnt_effective_date','description','collateral_desc','prim_machine','sec_machine','manufacturer_code','manufacturer_name','model','model_year','model_desc','collateral_count','manufactured_year','new_used','serial_number','property_desc','borough','block','lot','collateral_address','air_rights_indc','subterranean_rights_indc','easment_indc','volume','persistent_record_id');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'tmsid' => 0,'rmsid' => 1,'process_date' => 2,'static_value' => 3,'date_vendor_removed' => 4,'date_vendor_changed' => 5,'filing_jurisdiction' => 6,'orig_filing_number' => 7,'orig_filing_type' => 8,'orig_filing_date' => 9,'orig_filing_time' => 10,'filing_number' => 11,'filing_number_indc' => 12,'filing_type' => 13,'filing_date' => 14,'filing_time' => 15,'filing_status' => 16,'status_type' => 17,'page' => 18,'expiration_date' => 19,'contract_type' => 20,'vendor_entry_date' => 21,'vendor_upd_date' => 22,'statements_filed' => 23,'continuious_expiration' => 24,'microfilm_number' => 25,'amount' => 26,'irs_serial_number' => 27,'effective_date' => 28,'signer_name' => 29,'title' => 30,'filing_agency' => 31,'address' => 32,'city' => 33,'state' => 34,'county' => 35,'zip' => 36,'duns_number' => 37,'cmnt_effective_date' => 38,'description' => 39,'collateral_desc' => 40,'prim_machine' => 41,'sec_machine' => 42,'manufacturer_code' => 43,'manufacturer_name' => 44,'model' => 45,'model_year' => 46,'model_desc' => 47,'collateral_count' => 48,'manufactured_year' => 49,'new_used' => 50,'serial_number' => 51,'property_desc' => 52,'borough' => 53,'block' => 54,'lot' => 55,'collateral_address' => 56,'air_rights_indc' => 57,'subterranean_rights_indc' => 58,'easment_indc' => 59,'volume' => 60,'persistent_record_id' => 61,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM','LENGTHS'],[],[],[],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['ALLOW'],['CUSTOM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['ALLOW'],['ENUM'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],['LENGTHS'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_tmsid(SALT311.StrType s0) := MakeFT_invalid_tmsid(s0);
EXPORT InValid_tmsid(SALT311.StrType s) := InValidFT_invalid_tmsid(s);
EXPORT InValidMessage_tmsid(UNSIGNED1 wh) := InValidMessageFT_invalid_tmsid(wh);
 
EXPORT Make_rmsid(SALT311.StrType s0) := MakeFT_invalid_rmsid(s0);
EXPORT InValid_rmsid(SALT311.StrType s) := InValidFT_invalid_rmsid(s);
EXPORT InValidMessage_rmsid(UNSIGNED1 wh) := InValidMessageFT_invalid_rmsid(wh);
 
EXPORT Make_process_date(SALT311.StrType s0) := MakeFT_invalid_8pastdate(s0);
EXPORT InValid_process_date(SALT311.StrType s) := InValidFT_invalid_8pastdate(s);
EXPORT InValidMessage_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_8pastdate(wh);
 
EXPORT Make_static_value(SALT311.StrType s0) := s0;
EXPORT InValid_static_value(SALT311.StrType s) := 0;
EXPORT InValidMessage_static_value(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_removed(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_removed(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_removed(UNSIGNED1 wh) := '';
 
EXPORT Make_date_vendor_changed(SALT311.StrType s0) := s0;
EXPORT InValid_date_vendor_changed(SALT311.StrType s) := 0;
EXPORT InValidMessage_date_vendor_changed(UNSIGNED1 wh) := '';
 
EXPORT Make_filing_jurisdiction(SALT311.StrType s0) := MakeFT_invalid_filing_jurisdiction(s0);
EXPORT InValid_filing_jurisdiction(SALT311.StrType s) := InValidFT_invalid_filing_jurisdiction(s);
EXPORT InValidMessage_filing_jurisdiction(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_jurisdiction(wh);
 
EXPORT Make_orig_filing_number(SALT311.StrType s0) := MakeFT_invalid_orig_filing_number(s0);
EXPORT InValid_orig_filing_number(SALT311.StrType s) := InValidFT_invalid_orig_filing_number(s);
EXPORT InValidMessage_orig_filing_number(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_filing_number(wh);
 
EXPORT Make_orig_filing_type(SALT311.StrType s0) := MakeFT_invalid_orig_filing_type(s0);
EXPORT InValid_orig_filing_type(SALT311.StrType s) := InValidFT_invalid_orig_filing_type(s);
EXPORT InValidMessage_orig_filing_type(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_filing_type(wh);
 
EXPORT Make_orig_filing_date(SALT311.StrType s0) := MakeFT_invalid_orig_filing_date(s0);
EXPORT InValid_orig_filing_date(SALT311.StrType s) := InValidFT_invalid_orig_filing_date(s);
EXPORT InValidMessage_orig_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_filing_date(wh);
 
EXPORT Make_orig_filing_time(SALT311.StrType s0) := MakeFT_invalid_orig_filing_time(s0);
EXPORT InValid_orig_filing_time(SALT311.StrType s) := InValidFT_invalid_orig_filing_time(s);
EXPORT InValidMessage_orig_filing_time(UNSIGNED1 wh) := InValidMessageFT_invalid_orig_filing_time(wh);
 
EXPORT Make_filing_number(SALT311.StrType s0) := MakeFT_invalid_filing_number(s0);
EXPORT InValid_filing_number(SALT311.StrType s) := InValidFT_invalid_filing_number(s);
EXPORT InValidMessage_filing_number(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_number(wh);
 
EXPORT Make_filing_number_indc(SALT311.StrType s0) := s0;
EXPORT InValid_filing_number_indc(SALT311.StrType s) := 0;
EXPORT InValidMessage_filing_number_indc(UNSIGNED1 wh) := '';
 
EXPORT Make_filing_type(SALT311.StrType s0) := MakeFT_invalid_filing_type(s0);
EXPORT InValid_filing_type(SALT311.StrType s) := InValidFT_invalid_filing_type(s);
EXPORT InValidMessage_filing_type(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_type(wh);
 
EXPORT Make_filing_date(SALT311.StrType s0) := MakeFT_invalid_filing_date(s0);
EXPORT InValid_filing_date(SALT311.StrType s) := InValidFT_invalid_filing_date(s);
EXPORT InValidMessage_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_date(wh);
 
EXPORT Make_filing_time(SALT311.StrType s0) := MakeFT_invalid_filing_time(s0);
EXPORT InValid_filing_time(SALT311.StrType s) := InValidFT_invalid_filing_time(s);
EXPORT InValidMessage_filing_time(UNSIGNED1 wh) := InValidMessageFT_invalid_filing_time(wh);
 
EXPORT Make_filing_status(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_filing_status(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_filing_status(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_status_type(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_status_type(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_status_type(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_page(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_page(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_page(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_expiration_date(SALT311.StrType s0) := MakeFT_invalid_expiration_date(s0);
EXPORT InValid_expiration_date(SALT311.StrType s) := InValidFT_invalid_expiration_date(s);
EXPORT InValidMessage_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_expiration_date(wh);
 
EXPORT Make_contract_type(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_contract_type(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_contract_type(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_vendor_entry_date(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_vendor_entry_date(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_vendor_entry_date(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_vendor_upd_date(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_vendor_upd_date(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_vendor_upd_date(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_statements_filed(SALT311.StrType s0) := MakeFT_invalid_numeric_blank(s0);
EXPORT InValid_statements_filed(SALT311.StrType s) := InValidFT_invalid_numeric_blank(s);
EXPORT InValidMessage_statements_filed(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric_blank(wh);
 
EXPORT Make_continuious_expiration(SALT311.StrType s0) := MakeFT_invalid_boolean_yn_blank(s0);
EXPORT InValid_continuious_expiration(SALT311.StrType s) := InValidFT_invalid_boolean_yn_blank(s);
EXPORT InValidMessage_continuious_expiration(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean_yn_blank(wh);
 
EXPORT Make_microfilm_number(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_microfilm_number(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_microfilm_number(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_amount(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_amount(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_irs_serial_number(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_irs_serial_number(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_irs_serial_number(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_effective_date(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_effective_date(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_signer_name(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_signer_name(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_signer_name(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_title(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_title(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_title(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_filing_agency(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_filing_agency(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_filing_agency(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_address(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_address(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_county(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_county(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_county(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_zip(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_zip(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_duns_number(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_duns_number(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_duns_number(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_cmnt_effective_date(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_cmnt_effective_date(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_cmnt_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_description(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_description(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_description(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_collateral_desc(SALT311.StrType s0) := s0;
EXPORT InValid_collateral_desc(SALT311.StrType s) := 0;
EXPORT InValidMessage_collateral_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_machine(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_prim_machine(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_prim_machine(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_sec_machine(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_sec_machine(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_sec_machine(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_manufacturer_code(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_manufacturer_code(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_manufacturer_code(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_manufacturer_name(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_manufacturer_name(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_manufacturer_name(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_model(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_model(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_model(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_model_year(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_model_year(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_model_year(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_model_desc(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_model_desc(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_model_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_collateral_count(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_collateral_count(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_collateral_count(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_manufactured_year(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_manufactured_year(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_manufactured_year(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_new_used(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_new_used(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_new_used(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_serial_number(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_serial_number(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_serial_number(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_property_desc(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_property_desc(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_property_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_borough(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_borough(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_borough(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_block(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_block(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_block(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_lot(SALT311.StrType s0) := s0;
EXPORT InValid_lot(SALT311.StrType s) := 0;
EXPORT InValidMessage_lot(UNSIGNED1 wh) := '';
 
EXPORT Make_collateral_address(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_collateral_address(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_collateral_address(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_air_rights_indc(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_air_rights_indc(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_air_rights_indc(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_subterranean_rights_indc(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_subterranean_rights_indc(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_subterranean_rights_indc(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_easment_indc(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_easment_indc(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_easment_indc(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_volume(SALT311.StrType s0) := MakeFT_invalid_empty(s0);
EXPORT InValid_volume(SALT311.StrType s) := InValidFT_invalid_empty(s);
EXPORT InValidMessage_volume(UNSIGNED1 wh) := InValidMessageFT_invalid_empty(wh);
 
EXPORT Make_persistent_record_id(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_persistent_record_id(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_persistent_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_UCCV2;
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
    BOOLEAN Diff_tmsid;
    BOOLEAN Diff_rmsid;
    BOOLEAN Diff_process_date;
    BOOLEAN Diff_static_value;
    BOOLEAN Diff_date_vendor_removed;
    BOOLEAN Diff_date_vendor_changed;
    BOOLEAN Diff_filing_jurisdiction;
    BOOLEAN Diff_orig_filing_number;
    BOOLEAN Diff_orig_filing_type;
    BOOLEAN Diff_orig_filing_date;
    BOOLEAN Diff_orig_filing_time;
    BOOLEAN Diff_filing_number;
    BOOLEAN Diff_filing_number_indc;
    BOOLEAN Diff_filing_type;
    BOOLEAN Diff_filing_date;
    BOOLEAN Diff_filing_time;
    BOOLEAN Diff_filing_status;
    BOOLEAN Diff_status_type;
    BOOLEAN Diff_page;
    BOOLEAN Diff_expiration_date;
    BOOLEAN Diff_contract_type;
    BOOLEAN Diff_vendor_entry_date;
    BOOLEAN Diff_vendor_upd_date;
    BOOLEAN Diff_statements_filed;
    BOOLEAN Diff_continuious_expiration;
    BOOLEAN Diff_microfilm_number;
    BOOLEAN Diff_amount;
    BOOLEAN Diff_irs_serial_number;
    BOOLEAN Diff_effective_date;
    BOOLEAN Diff_signer_name;
    BOOLEAN Diff_title;
    BOOLEAN Diff_filing_agency;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_county;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_duns_number;
    BOOLEAN Diff_cmnt_effective_date;
    BOOLEAN Diff_description;
    BOOLEAN Diff_collateral_desc;
    BOOLEAN Diff_prim_machine;
    BOOLEAN Diff_sec_machine;
    BOOLEAN Diff_manufacturer_code;
    BOOLEAN Diff_manufacturer_name;
    BOOLEAN Diff_model;
    BOOLEAN Diff_model_year;
    BOOLEAN Diff_model_desc;
    BOOLEAN Diff_collateral_count;
    BOOLEAN Diff_manufactured_year;
    BOOLEAN Diff_new_used;
    BOOLEAN Diff_serial_number;
    BOOLEAN Diff_property_desc;
    BOOLEAN Diff_borough;
    BOOLEAN Diff_block;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_collateral_address;
    BOOLEAN Diff_air_rights_indc;
    BOOLEAN Diff_subterranean_rights_indc;
    BOOLEAN Diff_easment_indc;
    BOOLEAN Diff_volume;
    BOOLEAN Diff_persistent_record_id;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_tmsid := le.tmsid <> ri.tmsid;
    SELF.Diff_rmsid := le.rmsid <> ri.rmsid;
    SELF.Diff_process_date := le.process_date <> ri.process_date;
    SELF.Diff_static_value := le.static_value <> ri.static_value;
    SELF.Diff_date_vendor_removed := le.date_vendor_removed <> ri.date_vendor_removed;
    SELF.Diff_date_vendor_changed := le.date_vendor_changed <> ri.date_vendor_changed;
    SELF.Diff_filing_jurisdiction := le.filing_jurisdiction <> ri.filing_jurisdiction;
    SELF.Diff_orig_filing_number := le.orig_filing_number <> ri.orig_filing_number;
    SELF.Diff_orig_filing_type := le.orig_filing_type <> ri.orig_filing_type;
    SELF.Diff_orig_filing_date := le.orig_filing_date <> ri.orig_filing_date;
    SELF.Diff_orig_filing_time := le.orig_filing_time <> ri.orig_filing_time;
    SELF.Diff_filing_number := le.filing_number <> ri.filing_number;
    SELF.Diff_filing_number_indc := le.filing_number_indc <> ri.filing_number_indc;
    SELF.Diff_filing_type := le.filing_type <> ri.filing_type;
    SELF.Diff_filing_date := le.filing_date <> ri.filing_date;
    SELF.Diff_filing_time := le.filing_time <> ri.filing_time;
    SELF.Diff_filing_status := le.filing_status <> ri.filing_status;
    SELF.Diff_status_type := le.status_type <> ri.status_type;
    SELF.Diff_page := le.page <> ri.page;
    SELF.Diff_expiration_date := le.expiration_date <> ri.expiration_date;
    SELF.Diff_contract_type := le.contract_type <> ri.contract_type;
    SELF.Diff_vendor_entry_date := le.vendor_entry_date <> ri.vendor_entry_date;
    SELF.Diff_vendor_upd_date := le.vendor_upd_date <> ri.vendor_upd_date;
    SELF.Diff_statements_filed := le.statements_filed <> ri.statements_filed;
    SELF.Diff_continuious_expiration := le.continuious_expiration <> ri.continuious_expiration;
    SELF.Diff_microfilm_number := le.microfilm_number <> ri.microfilm_number;
    SELF.Diff_amount := le.amount <> ri.amount;
    SELF.Diff_irs_serial_number := le.irs_serial_number <> ri.irs_serial_number;
    SELF.Diff_effective_date := le.effective_date <> ri.effective_date;
    SELF.Diff_signer_name := le.signer_name <> ri.signer_name;
    SELF.Diff_title := le.title <> ri.title;
    SELF.Diff_filing_agency := le.filing_agency <> ri.filing_agency;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_county := le.county <> ri.county;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_duns_number := le.duns_number <> ri.duns_number;
    SELF.Diff_cmnt_effective_date := le.cmnt_effective_date <> ri.cmnt_effective_date;
    SELF.Diff_description := le.description <> ri.description;
    SELF.Diff_collateral_desc := le.collateral_desc <> ri.collateral_desc;
    SELF.Diff_prim_machine := le.prim_machine <> ri.prim_machine;
    SELF.Diff_sec_machine := le.sec_machine <> ri.sec_machine;
    SELF.Diff_manufacturer_code := le.manufacturer_code <> ri.manufacturer_code;
    SELF.Diff_manufacturer_name := le.manufacturer_name <> ri.manufacturer_name;
    SELF.Diff_model := le.model <> ri.model;
    SELF.Diff_model_year := le.model_year <> ri.model_year;
    SELF.Diff_model_desc := le.model_desc <> ri.model_desc;
    SELF.Diff_collateral_count := le.collateral_count <> ri.collateral_count;
    SELF.Diff_manufactured_year := le.manufactured_year <> ri.manufactured_year;
    SELF.Diff_new_used := le.new_used <> ri.new_used;
    SELF.Diff_serial_number := le.serial_number <> ri.serial_number;
    SELF.Diff_property_desc := le.property_desc <> ri.property_desc;
    SELF.Diff_borough := le.borough <> ri.borough;
    SELF.Diff_block := le.block <> ri.block;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_collateral_address := le.collateral_address <> ri.collateral_address;
    SELF.Diff_air_rights_indc := le.air_rights_indc <> ri.air_rights_indc;
    SELF.Diff_subterranean_rights_indc := le.subterranean_rights_indc <> ri.subterranean_rights_indc;
    SELF.Diff_easment_indc := le.easment_indc <> ri.easment_indc;
    SELF.Diff_volume := le.volume <> ri.volume;
    SELF.Diff_persistent_record_id := le.persistent_record_id <> ri.persistent_record_id;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_tmsid,1,0)+ IF( SELF.Diff_rmsid,1,0)+ IF( SELF.Diff_process_date,1,0)+ IF( SELF.Diff_static_value,1,0)+ IF( SELF.Diff_date_vendor_removed,1,0)+ IF( SELF.Diff_date_vendor_changed,1,0)+ IF( SELF.Diff_filing_jurisdiction,1,0)+ IF( SELF.Diff_orig_filing_number,1,0)+ IF( SELF.Diff_orig_filing_type,1,0)+ IF( SELF.Diff_orig_filing_date,1,0)+ IF( SELF.Diff_orig_filing_time,1,0)+ IF( SELF.Diff_filing_number,1,0)+ IF( SELF.Diff_filing_number_indc,1,0)+ IF( SELF.Diff_filing_type,1,0)+ IF( SELF.Diff_filing_date,1,0)+ IF( SELF.Diff_filing_time,1,0)+ IF( SELF.Diff_filing_status,1,0)+ IF( SELF.Diff_status_type,1,0)+ IF( SELF.Diff_page,1,0)+ IF( SELF.Diff_expiration_date,1,0)+ IF( SELF.Diff_contract_type,1,0)+ IF( SELF.Diff_vendor_entry_date,1,0)+ IF( SELF.Diff_vendor_upd_date,1,0)+ IF( SELF.Diff_statements_filed,1,0)+ IF( SELF.Diff_continuious_expiration,1,0)+ IF( SELF.Diff_microfilm_number,1,0)+ IF( SELF.Diff_amount,1,0)+ IF( SELF.Diff_irs_serial_number,1,0)+ IF( SELF.Diff_effective_date,1,0)+ IF( SELF.Diff_signer_name,1,0)+ IF( SELF.Diff_title,1,0)+ IF( SELF.Diff_filing_agency,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_county,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_duns_number,1,0)+ IF( SELF.Diff_cmnt_effective_date,1,0)+ IF( SELF.Diff_description,1,0)+ IF( SELF.Diff_collateral_desc,1,0)+ IF( SELF.Diff_prim_machine,1,0)+ IF( SELF.Diff_sec_machine,1,0)+ IF( SELF.Diff_manufacturer_code,1,0)+ IF( SELF.Diff_manufacturer_name,1,0)+ IF( SELF.Diff_model,1,0)+ IF( SELF.Diff_model_year,1,0)+ IF( SELF.Diff_model_desc,1,0)+ IF( SELF.Diff_collateral_count,1,0)+ IF( SELF.Diff_manufactured_year,1,0)+ IF( SELF.Diff_new_used,1,0)+ IF( SELF.Diff_serial_number,1,0)+ IF( SELF.Diff_property_desc,1,0)+ IF( SELF.Diff_borough,1,0)+ IF( SELF.Diff_block,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_collateral_address,1,0)+ IF( SELF.Diff_air_rights_indc,1,0)+ IF( SELF.Diff_subterranean_rights_indc,1,0)+ IF( SELF.Diff_easment_indc,1,0)+ IF( SELF.Diff_volume,1,0)+ IF( SELF.Diff_persistent_record_id,1,0);
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
    Count_Diff_tmsid := COUNT(GROUP,%Closest%.Diff_tmsid);
    Count_Diff_rmsid := COUNT(GROUP,%Closest%.Diff_rmsid);
    Count_Diff_process_date := COUNT(GROUP,%Closest%.Diff_process_date);
    Count_Diff_static_value := COUNT(GROUP,%Closest%.Diff_static_value);
    Count_Diff_date_vendor_removed := COUNT(GROUP,%Closest%.Diff_date_vendor_removed);
    Count_Diff_date_vendor_changed := COUNT(GROUP,%Closest%.Diff_date_vendor_changed);
    Count_Diff_filing_jurisdiction := COUNT(GROUP,%Closest%.Diff_filing_jurisdiction);
    Count_Diff_orig_filing_number := COUNT(GROUP,%Closest%.Diff_orig_filing_number);
    Count_Diff_orig_filing_type := COUNT(GROUP,%Closest%.Diff_orig_filing_type);
    Count_Diff_orig_filing_date := COUNT(GROUP,%Closest%.Diff_orig_filing_date);
    Count_Diff_orig_filing_time := COUNT(GROUP,%Closest%.Diff_orig_filing_time);
    Count_Diff_filing_number := COUNT(GROUP,%Closest%.Diff_filing_number);
    Count_Diff_filing_number_indc := COUNT(GROUP,%Closest%.Diff_filing_number_indc);
    Count_Diff_filing_type := COUNT(GROUP,%Closest%.Diff_filing_type);
    Count_Diff_filing_date := COUNT(GROUP,%Closest%.Diff_filing_date);
    Count_Diff_filing_time := COUNT(GROUP,%Closest%.Diff_filing_time);
    Count_Diff_filing_status := COUNT(GROUP,%Closest%.Diff_filing_status);
    Count_Diff_status_type := COUNT(GROUP,%Closest%.Diff_status_type);
    Count_Diff_page := COUNT(GROUP,%Closest%.Diff_page);
    Count_Diff_expiration_date := COUNT(GROUP,%Closest%.Diff_expiration_date);
    Count_Diff_contract_type := COUNT(GROUP,%Closest%.Diff_contract_type);
    Count_Diff_vendor_entry_date := COUNT(GROUP,%Closest%.Diff_vendor_entry_date);
    Count_Diff_vendor_upd_date := COUNT(GROUP,%Closest%.Diff_vendor_upd_date);
    Count_Diff_statements_filed := COUNT(GROUP,%Closest%.Diff_statements_filed);
    Count_Diff_continuious_expiration := COUNT(GROUP,%Closest%.Diff_continuious_expiration);
    Count_Diff_microfilm_number := COUNT(GROUP,%Closest%.Diff_microfilm_number);
    Count_Diff_amount := COUNT(GROUP,%Closest%.Diff_amount);
    Count_Diff_irs_serial_number := COUNT(GROUP,%Closest%.Diff_irs_serial_number);
    Count_Diff_effective_date := COUNT(GROUP,%Closest%.Diff_effective_date);
    Count_Diff_signer_name := COUNT(GROUP,%Closest%.Diff_signer_name);
    Count_Diff_title := COUNT(GROUP,%Closest%.Diff_title);
    Count_Diff_filing_agency := COUNT(GROUP,%Closest%.Diff_filing_agency);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_county := COUNT(GROUP,%Closest%.Diff_county);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_duns_number := COUNT(GROUP,%Closest%.Diff_duns_number);
    Count_Diff_cmnt_effective_date := COUNT(GROUP,%Closest%.Diff_cmnt_effective_date);
    Count_Diff_description := COUNT(GROUP,%Closest%.Diff_description);
    Count_Diff_collateral_desc := COUNT(GROUP,%Closest%.Diff_collateral_desc);
    Count_Diff_prim_machine := COUNT(GROUP,%Closest%.Diff_prim_machine);
    Count_Diff_sec_machine := COUNT(GROUP,%Closest%.Diff_sec_machine);
    Count_Diff_manufacturer_code := COUNT(GROUP,%Closest%.Diff_manufacturer_code);
    Count_Diff_manufacturer_name := COUNT(GROUP,%Closest%.Diff_manufacturer_name);
    Count_Diff_model := COUNT(GROUP,%Closest%.Diff_model);
    Count_Diff_model_year := COUNT(GROUP,%Closest%.Diff_model_year);
    Count_Diff_model_desc := COUNT(GROUP,%Closest%.Diff_model_desc);
    Count_Diff_collateral_count := COUNT(GROUP,%Closest%.Diff_collateral_count);
    Count_Diff_manufactured_year := COUNT(GROUP,%Closest%.Diff_manufactured_year);
    Count_Diff_new_used := COUNT(GROUP,%Closest%.Diff_new_used);
    Count_Diff_serial_number := COUNT(GROUP,%Closest%.Diff_serial_number);
    Count_Diff_property_desc := COUNT(GROUP,%Closest%.Diff_property_desc);
    Count_Diff_borough := COUNT(GROUP,%Closest%.Diff_borough);
    Count_Diff_block := COUNT(GROUP,%Closest%.Diff_block);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_collateral_address := COUNT(GROUP,%Closest%.Diff_collateral_address);
    Count_Diff_air_rights_indc := COUNT(GROUP,%Closest%.Diff_air_rights_indc);
    Count_Diff_subterranean_rights_indc := COUNT(GROUP,%Closest%.Diff_subterranean_rights_indc);
    Count_Diff_easment_indc := COUNT(GROUP,%Closest%.Diff_easment_indc);
    Count_Diff_volume := COUNT(GROUP,%Closest%.Diff_volume);
    Count_Diff_persistent_record_id := COUNT(GROUP,%Closest%.Diff_persistent_record_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
