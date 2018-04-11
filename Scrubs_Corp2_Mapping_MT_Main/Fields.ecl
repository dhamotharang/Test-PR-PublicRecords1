IMPORT SALT38;
IMPORT Scrubs,Scrubs_Corp2_Mapping_MT_Main; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 34;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_charter_nbr','invalid_mandatory','invalid_date','invalid_optional_date','invalid_recordorigin','invalid_name_type_cd','invalid_forgn_dom_code','invalid_characters','invalid_characters_ext','invalid_term_cd','invalid_term_exp','invalid_bus_type_cd');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_corp_key' => 1,'invalid_corp_vendor' => 2,'invalid_state_origin' => 3,'invalid_charter_nbr' => 4,'invalid_mandatory' => 5,'invalid_date' => 6,'invalid_optional_date' => 7,'invalid_recordorigin' => 8,'invalid_name_type_cd' => 9,'invalid_forgn_dom_code' => 10,'invalid_characters' => 11,'invalid_characters_ext' => 12,'invalid_term_cd' => 13,'invalid_term_exp' => 14,'invalid_bus_type_cd' => 15,0);
 
EXPORT MakeFT_invalid_corp_key(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'))),~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-'),SALT38.HygieneErrors.NotLength('4..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['30']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('30'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['MT']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('MT'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter_nbr(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter_nbr(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_charter_nbr(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'),SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT38.HygieneErrors.NotLength('8'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_optional_date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_optional_date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_optional_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT38.HygieneErrors.NotLength('0,1,8'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_recordorigin(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'C|T'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_recordorigin(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'C|T'))));
EXPORT InValidMessageFT_invalid_recordorigin(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('C|T'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_cd(SALT38.StrType s,SALT38.StrType recordOrigin) := WHICH(~Scrubs_Corp2_Mapping_MT_Main.Functions.invalid_name_type_code(s,recordOrigin)>0);
EXPORT InValidMessageFT_invalid_name_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Corp2_Mapping_MT_Main.Functions.invalid_name_type_code'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_forgn_dom_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_forgn_dom_code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['D','F',' ']);
EXPORT InValidMessageFT_invalid_forgn_dom_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('D|F| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_characters(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' .,-&:/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_characters(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' .,-&:/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()'))));
EXPORT InValidMessageFT_invalid_characters(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' .,-&:/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_characters_ext(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' .,\'-_&;:/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()*+"#?$='); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_characters_ext(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' .,\'-_&;:/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()*+"#?$='))));
EXPORT InValidMessageFT_invalid_characters_ext(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' .,\'-_&;:/ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789()*+"#?$='),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_term_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_term_cd(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['D','P','F',' ']);
EXPORT InValidMessageFT_invalid_term_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('D|P|F| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_term_exp(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789 '); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_term_exp(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789 '))));
EXPORT InValidMessageFT_invalid_term_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789 '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bus_type_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bus_type_cd(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN set_valid_bus_type_cd);
EXPORT InValidMessageFT_invalid_bus_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('set_valid_bus_type_cd'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','corp_key','corp_orig_sos_charter_nbr','corp_vendor','corp_state_origin','corp_inc_state','corp_legal_name','corp_ln_name_type_cd','corp_filing_date','corp_inc_date','corp_forgn_date','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_trademark_class_desc1','corp_trademark_class_desc2','corp_trademark_class_desc3','corp_trademark_class_desc4','corp_trademark_class_desc5','corp_trademark_class_desc6','corp_term_exist_cd','corp_term_exist_exp','corp_status_desc','corp_status_comment','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_renewal_date','cont_title1_desc','recordorigin');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','corp_key','corp_orig_sos_charter_nbr','corp_vendor','corp_state_origin','corp_inc_state','corp_legal_name','corp_ln_name_type_cd','corp_filing_date','corp_inc_date','corp_forgn_date','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_trademark_class_desc1','corp_trademark_class_desc2','corp_trademark_class_desc3','corp_trademark_class_desc4','corp_trademark_class_desc5','corp_trademark_class_desc6','corp_term_exist_cd','corp_term_exist_exp','corp_status_desc','corp_status_comment','corp_trademark_first_use_date','corp_trademark_first_use_date_in_state','corp_trademark_renewal_date','cont_title1_desc','recordorigin');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'dt_vendor_first_reported' => 0,'dt_vendor_last_reported' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'corp_ra_dt_first_seen' => 4,'corp_ra_dt_last_seen' => 5,'corp_process_date' => 6,'corp_key' => 7,'corp_orig_sos_charter_nbr' => 8,'corp_vendor' => 9,'corp_state_origin' => 10,'corp_inc_state' => 11,'corp_legal_name' => 12,'corp_ln_name_type_cd' => 13,'corp_filing_date' => 14,'corp_inc_date' => 15,'corp_forgn_date' => 16,'corp_foreign_domestic_ind' => 17,'corp_forgn_state_desc' => 18,'corp_trademark_class_desc1' => 19,'corp_trademark_class_desc2' => 20,'corp_trademark_class_desc3' => 21,'corp_trademark_class_desc4' => 22,'corp_trademark_class_desc5' => 23,'corp_trademark_class_desc6' => 24,'corp_term_exist_cd' => 25,'corp_term_exist_exp' => 26,'corp_status_desc' => 27,'corp_status_comment' => 28,'corp_trademark_first_use_date' => 29,'corp_trademark_first_use_date_in_state' => 30,'corp_trademark_renewal_date' => 31,'cont_title1_desc' => 32,'recordorigin' => 33,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','LENGTHS'],['ALLOW','LENGTHS'],['ENUM'],['ENUM'],['ENUM'],['LENGTHS'],['CUSTOM'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW','CUSTOM','LENGTHS'],['ALLOW'],['ALLOW'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_vendor_first_reported(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_first_seen(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_first_seen(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_last_seen(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_last_seen(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_first_seen(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_ra_dt_first_seen(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_ra_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_last_seen(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_ra_dt_last_seen(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_ra_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_process_date(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_key(SALT38.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT38.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT38.StrType s0) := MakeFT_invalid_charter_nbr(s0);
EXPORT InValid_corp_orig_sos_charter_nbr(SALT38.StrType s) := InValidFT_invalid_charter_nbr(s);
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter_nbr(wh);
 
EXPORT Make_corp_vendor(SALT38.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT38.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_state_origin(SALT38.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT38.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_inc_state(SALT38.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_inc_state(SALT38.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_legal_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_ln_name_type_cd(SALT38.StrType s0) := MakeFT_invalid_name_type_cd(s0);
EXPORT InValid_corp_ln_name_type_cd(SALT38.StrType s,SALT38.StrType recordOrigin) := InValidFT_invalid_name_type_cd(s,recordOrigin);
EXPORT InValidMessage_corp_ln_name_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type_cd(wh);
 
EXPORT Make_corp_filing_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_filing_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_inc_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_inc_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_inc_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_forgn_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_forgn_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_forgn_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_foreign_domestic_ind(SALT38.StrType s0) := MakeFT_invalid_forgn_dom_code(s0);
EXPORT InValid_corp_foreign_domestic_ind(SALT38.StrType s) := InValidFT_invalid_forgn_dom_code(s);
EXPORT InValidMessage_corp_foreign_domestic_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_forgn_dom_code(wh);
 
EXPORT Make_corp_forgn_state_desc(SALT38.StrType s0) := MakeFT_invalid_characters(s0);
EXPORT InValid_corp_forgn_state_desc(SALT38.StrType s) := InValidFT_invalid_characters(s);
EXPORT InValidMessage_corp_forgn_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_characters(wh);
 
EXPORT Make_corp_trademark_class_desc1(SALT38.StrType s0) := MakeFT_invalid_characters_ext(s0);
EXPORT InValid_corp_trademark_class_desc1(SALT38.StrType s) := InValidFT_invalid_characters_ext(s);
EXPORT InValidMessage_corp_trademark_class_desc1(UNSIGNED1 wh) := InValidMessageFT_invalid_characters_ext(wh);
 
EXPORT Make_corp_trademark_class_desc2(SALT38.StrType s0) := MakeFT_invalid_characters_ext(s0);
EXPORT InValid_corp_trademark_class_desc2(SALT38.StrType s) := InValidFT_invalid_characters_ext(s);
EXPORT InValidMessage_corp_trademark_class_desc2(UNSIGNED1 wh) := InValidMessageFT_invalid_characters_ext(wh);
 
EXPORT Make_corp_trademark_class_desc3(SALT38.StrType s0) := MakeFT_invalid_characters_ext(s0);
EXPORT InValid_corp_trademark_class_desc3(SALT38.StrType s) := InValidFT_invalid_characters_ext(s);
EXPORT InValidMessage_corp_trademark_class_desc3(UNSIGNED1 wh) := InValidMessageFT_invalid_characters_ext(wh);
 
EXPORT Make_corp_trademark_class_desc4(SALT38.StrType s0) := MakeFT_invalid_characters_ext(s0);
EXPORT InValid_corp_trademark_class_desc4(SALT38.StrType s) := InValidFT_invalid_characters_ext(s);
EXPORT InValidMessage_corp_trademark_class_desc4(UNSIGNED1 wh) := InValidMessageFT_invalid_characters_ext(wh);
 
EXPORT Make_corp_trademark_class_desc5(SALT38.StrType s0) := MakeFT_invalid_characters_ext(s0);
EXPORT InValid_corp_trademark_class_desc5(SALT38.StrType s) := InValidFT_invalid_characters_ext(s);
EXPORT InValidMessage_corp_trademark_class_desc5(UNSIGNED1 wh) := InValidMessageFT_invalid_characters_ext(wh);
 
EXPORT Make_corp_trademark_class_desc6(SALT38.StrType s0) := MakeFT_invalid_characters_ext(s0);
EXPORT InValid_corp_trademark_class_desc6(SALT38.StrType s) := InValidFT_invalid_characters_ext(s);
EXPORT InValidMessage_corp_trademark_class_desc6(UNSIGNED1 wh) := InValidMessageFT_invalid_characters_ext(wh);
 
EXPORT Make_corp_term_exist_cd(SALT38.StrType s0) := MakeFT_invalid_term_cd(s0);
EXPORT InValid_corp_term_exist_cd(SALT38.StrType s) := InValidFT_invalid_term_cd(s);
EXPORT InValidMessage_corp_term_exist_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_term_cd(wh);
 
EXPORT Make_corp_term_exist_exp(SALT38.StrType s0) := MakeFT_invalid_term_exp(s0);
EXPORT InValid_corp_term_exist_exp(SALT38.StrType s) := InValidFT_invalid_term_exp(s);
EXPORT InValidMessage_corp_term_exist_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_term_exp(wh);
 
EXPORT Make_corp_status_desc(SALT38.StrType s0) := MakeFT_invalid_characters(s0);
EXPORT InValid_corp_status_desc(SALT38.StrType s) := InValidFT_invalid_characters(s);
EXPORT InValidMessage_corp_status_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_characters(wh);
 
EXPORT Make_corp_status_comment(SALT38.StrType s0) := MakeFT_invalid_characters(s0);
EXPORT InValid_corp_status_comment(SALT38.StrType s) := InValidFT_invalid_characters(s);
EXPORT InValidMessage_corp_status_comment(UNSIGNED1 wh) := InValidMessageFT_invalid_characters(wh);
 
EXPORT Make_corp_trademark_first_use_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_trademark_first_use_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_trademark_first_use_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_trademark_first_use_date_in_state(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_trademark_first_use_date_in_state(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_trademark_first_use_date_in_state(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_trademark_renewal_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_trademark_renewal_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_trademark_renewal_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_cont_title1_desc(SALT38.StrType s0) := MakeFT_invalid_characters_ext(s0);
EXPORT InValid_cont_title1_desc(SALT38.StrType s) := InValidFT_invalid_characters_ext(s);
EXPORT InValidMessage_cont_title1_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_characters_ext(wh);
 
EXPORT Make_recordorigin(SALT38.StrType s0) := MakeFT_invalid_recordorigin(s0);
EXPORT InValid_recordorigin(SALT38.StrType s) := InValidFT_invalid_recordorigin(s);
EXPORT InValidMessage_recordorigin(UNSIGNED1 wh) := InValidMessageFT_invalid_recordorigin(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Corp2_Mapping_MT_Main;
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
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_corp_ra_dt_first_seen;
    BOOLEAN Diff_corp_ra_dt_last_seen;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_orig_sos_charter_nbr;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_inc_state;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_corp_ln_name_type_cd;
    BOOLEAN Diff_corp_filing_date;
    BOOLEAN Diff_corp_inc_date;
    BOOLEAN Diff_corp_forgn_date;
    BOOLEAN Diff_corp_foreign_domestic_ind;
    BOOLEAN Diff_corp_forgn_state_desc;
    BOOLEAN Diff_corp_trademark_class_desc1;
    BOOLEAN Diff_corp_trademark_class_desc2;
    BOOLEAN Diff_corp_trademark_class_desc3;
    BOOLEAN Diff_corp_trademark_class_desc4;
    BOOLEAN Diff_corp_trademark_class_desc5;
    BOOLEAN Diff_corp_trademark_class_desc6;
    BOOLEAN Diff_corp_term_exist_cd;
    BOOLEAN Diff_corp_term_exist_exp;
    BOOLEAN Diff_corp_status_desc;
    BOOLEAN Diff_corp_status_comment;
    BOOLEAN Diff_corp_trademark_first_use_date;
    BOOLEAN Diff_corp_trademark_first_use_date_in_state;
    BOOLEAN Diff_corp_trademark_renewal_date;
    BOOLEAN Diff_cont_title1_desc;
    BOOLEAN Diff_recordorigin;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_corp_ra_dt_first_seen := le.corp_ra_dt_first_seen <> ri.corp_ra_dt_first_seen;
    SELF.Diff_corp_ra_dt_last_seen := le.corp_ra_dt_last_seen <> ri.corp_ra_dt_last_seen;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr <> ri.corp_orig_sos_charter_nbr;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_inc_state := le.corp_inc_state <> ri.corp_inc_state;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_corp_ln_name_type_cd := le.corp_ln_name_type_cd <> ri.corp_ln_name_type_cd;
    SELF.Diff_corp_filing_date := le.corp_filing_date <> ri.corp_filing_date;
    SELF.Diff_corp_inc_date := le.corp_inc_date <> ri.corp_inc_date;
    SELF.Diff_corp_forgn_date := le.corp_forgn_date <> ri.corp_forgn_date;
    SELF.Diff_corp_foreign_domestic_ind := le.corp_foreign_domestic_ind <> ri.corp_foreign_domestic_ind;
    SELF.Diff_corp_forgn_state_desc := le.corp_forgn_state_desc <> ri.corp_forgn_state_desc;
    SELF.Diff_corp_trademark_class_desc1 := le.corp_trademark_class_desc1 <> ri.corp_trademark_class_desc1;
    SELF.Diff_corp_trademark_class_desc2 := le.corp_trademark_class_desc2 <> ri.corp_trademark_class_desc2;
    SELF.Diff_corp_trademark_class_desc3 := le.corp_trademark_class_desc3 <> ri.corp_trademark_class_desc3;
    SELF.Diff_corp_trademark_class_desc4 := le.corp_trademark_class_desc4 <> ri.corp_trademark_class_desc4;
    SELF.Diff_corp_trademark_class_desc5 := le.corp_trademark_class_desc5 <> ri.corp_trademark_class_desc5;
    SELF.Diff_corp_trademark_class_desc6 := le.corp_trademark_class_desc6 <> ri.corp_trademark_class_desc6;
    SELF.Diff_corp_term_exist_cd := le.corp_term_exist_cd <> ri.corp_term_exist_cd;
    SELF.Diff_corp_term_exist_exp := le.corp_term_exist_exp <> ri.corp_term_exist_exp;
    SELF.Diff_corp_status_desc := le.corp_status_desc <> ri.corp_status_desc;
    SELF.Diff_corp_status_comment := le.corp_status_comment <> ri.corp_status_comment;
    SELF.Diff_corp_trademark_first_use_date := le.corp_trademark_first_use_date <> ri.corp_trademark_first_use_date;
    SELF.Diff_corp_trademark_first_use_date_in_state := le.corp_trademark_first_use_date_in_state <> ri.corp_trademark_first_use_date_in_state;
    SELF.Diff_corp_trademark_renewal_date := le.corp_trademark_renewal_date <> ri.corp_trademark_renewal_date;
    SELF.Diff_cont_title1_desc := le.cont_title1_desc <> ri.cont_title1_desc;
    SELF.Diff_recordorigin := le.recordorigin <> ri.recordorigin;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_first_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_last_seen,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_inc_state,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_corp_ln_name_type_cd,1,0)+ IF( SELF.Diff_corp_filing_date,1,0)+ IF( SELF.Diff_corp_inc_date,1,0)+ IF( SELF.Diff_corp_forgn_date,1,0)+ IF( SELF.Diff_corp_foreign_domestic_ind,1,0)+ IF( SELF.Diff_corp_forgn_state_desc,1,0)+ IF( SELF.Diff_corp_trademark_class_desc1,1,0)+ IF( SELF.Diff_corp_trademark_class_desc2,1,0)+ IF( SELF.Diff_corp_trademark_class_desc3,1,0)+ IF( SELF.Diff_corp_trademark_class_desc4,1,0)+ IF( SELF.Diff_corp_trademark_class_desc5,1,0)+ IF( SELF.Diff_corp_trademark_class_desc6,1,0)+ IF( SELF.Diff_corp_term_exist_cd,1,0)+ IF( SELF.Diff_corp_term_exist_exp,1,0)+ IF( SELF.Diff_corp_status_desc,1,0)+ IF( SELF.Diff_corp_status_comment,1,0)+ IF( SELF.Diff_corp_trademark_first_use_date,1,0)+ IF( SELF.Diff_corp_trademark_first_use_date_in_state,1,0)+ IF( SELF.Diff_corp_trademark_renewal_date,1,0)+ IF( SELF.Diff_cont_title1_desc,1,0)+ IF( SELF.Diff_recordorigin,1,0);
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
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_corp_ra_dt_first_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_first_seen);
    Count_Diff_corp_ra_dt_last_seen := COUNT(GROUP,%Closest%.Diff_corp_ra_dt_last_seen);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_orig_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_orig_sos_charter_nbr);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_inc_state := COUNT(GROUP,%Closest%.Diff_corp_inc_state);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_corp_ln_name_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_cd);
    Count_Diff_corp_filing_date := COUNT(GROUP,%Closest%.Diff_corp_filing_date);
    Count_Diff_corp_inc_date := COUNT(GROUP,%Closest%.Diff_corp_inc_date);
    Count_Diff_corp_forgn_date := COUNT(GROUP,%Closest%.Diff_corp_forgn_date);
    Count_Diff_corp_foreign_domestic_ind := COUNT(GROUP,%Closest%.Diff_corp_foreign_domestic_ind);
    Count_Diff_corp_forgn_state_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_desc);
    Count_Diff_corp_trademark_class_desc1 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_desc1);
    Count_Diff_corp_trademark_class_desc2 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_desc2);
    Count_Diff_corp_trademark_class_desc3 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_desc3);
    Count_Diff_corp_trademark_class_desc4 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_desc4);
    Count_Diff_corp_trademark_class_desc5 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_desc5);
    Count_Diff_corp_trademark_class_desc6 := COUNT(GROUP,%Closest%.Diff_corp_trademark_class_desc6);
    Count_Diff_corp_term_exist_cd := COUNT(GROUP,%Closest%.Diff_corp_term_exist_cd);
    Count_Diff_corp_term_exist_exp := COUNT(GROUP,%Closest%.Diff_corp_term_exist_exp);
    Count_Diff_corp_status_desc := COUNT(GROUP,%Closest%.Diff_corp_status_desc);
    Count_Diff_corp_status_comment := COUNT(GROUP,%Closest%.Diff_corp_status_comment);
    Count_Diff_corp_trademark_first_use_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_first_use_date);
    Count_Diff_corp_trademark_first_use_date_in_state := COUNT(GROUP,%Closest%.Diff_corp_trademark_first_use_date_in_state);
    Count_Diff_corp_trademark_renewal_date := COUNT(GROUP,%Closest%.Diff_corp_trademark_renewal_date);
    Count_Diff_cont_title1_desc := COUNT(GROUP,%Closest%.Diff_cont_title1_desc);
    Count_Diff_recordorigin := COUNT(GROUP,%Closest%.Diff_recordorigin);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
