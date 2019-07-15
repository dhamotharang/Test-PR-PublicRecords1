IMPORT SALT38;
IMPORT Scrubs,Scrubs_Corp2_Mapping_PA_Main; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 39;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_date','invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_charter','invalid_mandatory','invalid_name_type_code','invalid_name_type_desc','invalid_address1_type_cd','invalid_address1_type_desc','invalid_corp_status_cd','invalid_corp_status_desc','invalid_corp_term_exist_cd','invalid_corp_term_exist_desc','invalid_optional_date','invalid_forgn_dom_code','invalid_corp_orig_org_structure_cd','invalid_corp_orig_org_structure_desc','invalid_for_profit_indicator','invalid_cont_type_cd','invalid_cont_type_desc','invalid_cont_title1_desc','invalid_corp_name_status_cd','invalid_corp_name_status_desc','invalid_alphablankcomma');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_date' => 1,'invalid_corp_key' => 2,'invalid_corp_vendor' => 3,'invalid_state_origin' => 4,'invalid_charter' => 5,'invalid_mandatory' => 6,'invalid_name_type_code' => 7,'invalid_name_type_desc' => 8,'invalid_address1_type_cd' => 9,'invalid_address1_type_desc' => 10,'invalid_corp_status_cd' => 11,'invalid_corp_status_desc' => 12,'invalid_corp_term_exist_cd' => 13,'invalid_corp_term_exist_desc' => 14,'invalid_optional_date' => 15,'invalid_forgn_dom_code' => 16,'invalid_corp_orig_org_structure_cd' => 17,'invalid_corp_orig_org_structure_desc' => 18,'invalid_for_profit_indicator' => 19,'invalid_cont_type_cd' => 20,'invalid_cont_type_desc' => 21,'invalid_cont_title1_desc' => 22,'invalid_corp_name_status_cd' => 23,'invalid_corp_name_status_desc' => 24,'invalid_alphablankcomma' => 25,0);
 
EXPORT MakeFT_invalid_date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT38.HygieneErrors.NotLength('8'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_key(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'KB0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'KB0123456789-'))),~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('KB0123456789-'),SALT38.HygieneErrors.NotLength('4..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['42','42']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('42|42'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['PA','PA']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('PA|PA'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'KB0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'KB0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('KB0123456789'),SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotLength('1..'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_code(SALT38.StrType s,SALT38.StrType recordOrigin) := WHICH(~Scrubs_Corp2_Mapping_PA_Main.Functions.invalid_name_type_code(s,recordOrigin)>0);
EXPORT InValidMessageFT_invalid_name_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Corp2_Mapping_PA_Main.Functions.invalid_name_type_code'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_desc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_desc(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_nametype_desc);
EXPORT InValidMessageFT_invalid_name_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_nametype_desc'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address1_type_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address1_type_cd(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','AA','AD','M','5','6','7','PE','PP','PM','11','12','9','14','15','16','B','18','19','20',' ']);
EXPORT InValidMessageFT_invalid_address1_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|AA|AD|M|5|6|7|PE|PP|PM|11|12|9|14|15|16|B|18|19|20| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address1_type_desc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_address1_type_desc(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_addr_desc);
EXPORT InValidMessageFT_invalid_address1_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_addr_desc'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_status_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_status_cd(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['1','2','4','5','7','8','9','10','11','12','13','14','15','16','17',' ']);
EXPORT InValidMessageFT_invalid_corp_status_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('1|2|4|5|7|8|9|10|11|12|13|14|15|16|17| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_status_desc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_status_desc(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_status_desc);
EXPORT InValidMessageFT_invalid_corp_status_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_status_desc'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_term_exist_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_term_exist_cd(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['D','P',' ']);
EXPORT InValidMessageFT_invalid_corp_term_exist_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('D|P| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_term_exist_desc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_term_exist_desc(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['EXPIRATION DATE','PERPETUAL',' ']);
EXPORT InValidMessageFT_invalid_corp_term_exist_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('EXPIRATION DATE|PERPETUAL| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_optional_date(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_optional_date(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_optional_date(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789'),SALT38.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT38.HygieneErrors.NotLength('0,1,8'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_forgn_dom_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_forgn_dom_code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['D','F',' ']);
EXPORT InValidMessageFT_invalid_forgn_dom_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('D|F| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_orig_org_structure_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_orig_org_structure_cd(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_orgstruc_cd);
EXPORT InValidMessageFT_invalid_corp_orig_org_structure_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_orgstruc_cd'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_orig_org_structure_desc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_orig_org_structure_desc(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_orgstruc_desc);
EXPORT InValidMessageFT_invalid_corp_orig_org_structure_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_orgstruc_desc'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_for_profit_indicator(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_for_profit_indicator(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['N',' ']);
EXPORT InValidMessageFT_invalid_for_profit_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('N| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cont_type_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cont_type_cd(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['T',' ']);
EXPORT InValidMessageFT_invalid_cont_type_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('T| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cont_type_desc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cont_type_desc(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['CONTACT',' ']);
EXPORT InValidMessageFT_invalid_cont_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('CONTACT| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cont_title1_desc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cont_title1_desc(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_conttitle1_desc);
EXPORT InValidMessageFT_invalid_cont_title1_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_PA_Main.Functions.set_valid_conttitle1_desc'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_name_status_cd(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_name_status_cd(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['3','6',' ']);
EXPORT InValidMessageFT_invalid_corp_name_status_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('3|6| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_name_status_desc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_name_status_desc(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['ACTIVE-NAME IS AVAILABLE','NAME RESERVATION EXPIRATION',' ']);
EXPORT InValidMessageFT_invalid_corp_name_status_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('ACTIVE-NAME IS AVAILABLE|NAME RESERVATION EXPIRATION| '),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablankcomma(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablankcomma(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablankcomma(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_address1_type_cd','corp_address1_type_desc','corp_status_cd','corp_status_desc','corp_inc_state','corp_inc_date','corp_term_exist_cd','corp_term_exist_desc','corp_term_exist_exp','corp_foreign_domestic_ind','corp_forgn_date','corp_orig_org_structure_cd','corp_orig_org_structure_desc','corp_for_profit_ind','cont_type_cd','cont_type_desc','cont_title1_desc','cont_address_type_cd','cont_address_type_desc','corp_dissolved_date','corp_merger_date','corp_name_status_cd','corp_name_status_desc','corp_forgn_state_desc','recordorigin');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_address1_type_cd','corp_address1_type_desc','corp_status_cd','corp_status_desc','corp_inc_state','corp_inc_date','corp_term_exist_cd','corp_term_exist_desc','corp_term_exist_exp','corp_foreign_domestic_ind','corp_forgn_date','corp_orig_org_structure_cd','corp_orig_org_structure_desc','corp_for_profit_ind','cont_type_cd','cont_type_desc','cont_title1_desc','cont_address_type_cd','cont_address_type_desc','corp_dissolved_date','corp_merger_date','corp_name_status_cd','corp_name_status_desc','corp_forgn_state_desc','recordorigin');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'dt_vendor_first_reported' => 0,'dt_vendor_last_reported' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'corp_ra_dt_first_seen' => 4,'corp_ra_dt_last_seen' => 5,'corp_key' => 6,'corp_vendor' => 7,'corp_state_origin' => 8,'corp_process_date' => 9,'corp_orig_sos_charter_nbr' => 10,'corp_legal_name' => 11,'corp_ln_name_type_cd' => 12,'corp_ln_name_type_desc' => 13,'corp_address1_type_cd' => 14,'corp_address1_type_desc' => 15,'corp_status_cd' => 16,'corp_status_desc' => 17,'corp_inc_state' => 18,'corp_inc_date' => 19,'corp_term_exist_cd' => 20,'corp_term_exist_desc' => 21,'corp_term_exist_exp' => 22,'corp_foreign_domestic_ind' => 23,'corp_forgn_date' => 24,'corp_orig_org_structure_cd' => 25,'corp_orig_org_structure_desc' => 26,'corp_for_profit_ind' => 27,'cont_type_cd' => 28,'cont_type_desc' => 29,'cont_title1_desc' => 30,'cont_address_type_cd' => 31,'cont_address_type_desc' => 32,'corp_dissolved_date' => 33,'corp_merger_date' => 34,'corp_name_status_cd' => 35,'corp_name_status_desc' => 36,'corp_forgn_state_desc' => 37,'recordorigin' => 38,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ALLOW','CUSTOM','LENGTH'],['ALLOW','CUSTOM','LENGTH'],['ALLOW','CUSTOM','LENGTH'],['ALLOW','CUSTOM','LENGTH'],['ALLOW','CUSTOM','LENGTH'],['ALLOW','CUSTOM','LENGTH'],['ALLOW','LENGTH'],['ENUM'],['ENUM'],['ALLOW','CUSTOM','LENGTH'],['ALLOW','LENGTH'],['LENGTH'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ALLOW','CUSTOM','LENGTH'],['ENUM'],['ENUM'],['ALLOW','CUSTOM','LENGTH'],['ENUM'],['ALLOW','CUSTOM','LENGTH'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ALLOW','CUSTOM','LENGTH'],['ALLOW','CUSTOM','LENGTH'],['ENUM'],['ENUM'],['ALLOW'],[],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
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
 
EXPORT Make_corp_ra_dt_first_seen(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_ra_dt_first_seen(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_ra_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_ra_dt_last_seen(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_ra_dt_last_seen(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_ra_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_key(SALT38.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT38.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_vendor(SALT38.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT38.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_state_origin(SALT38.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT38.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_process_date(SALT38.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT38.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT38.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_corp_orig_sos_charter_nbr(SALT38.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
 
EXPORT Make_corp_legal_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_ln_name_type_cd(SALT38.StrType s0) := MakeFT_invalid_name_type_code(s0);
EXPORT InValid_corp_ln_name_type_cd(SALT38.StrType s,SALT38.StrType recordOrigin) := InValidFT_invalid_name_type_code(s,recordOrigin);
EXPORT InValidMessage_corp_ln_name_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type_code(wh);
 
EXPORT Make_corp_ln_name_type_desc(SALT38.StrType s0) := MakeFT_invalid_name_type_desc(s0);
EXPORT InValid_corp_ln_name_type_desc(SALT38.StrType s) := InValidFT_invalid_name_type_desc(s);
EXPORT InValidMessage_corp_ln_name_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type_desc(wh);
 
EXPORT Make_corp_address1_type_cd(SALT38.StrType s0) := MakeFT_invalid_address1_type_cd(s0);
EXPORT InValid_corp_address1_type_cd(SALT38.StrType s) := InValidFT_invalid_address1_type_cd(s);
EXPORT InValidMessage_corp_address1_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_address1_type_cd(wh);
 
EXPORT Make_corp_address1_type_desc(SALT38.StrType s0) := MakeFT_invalid_address1_type_desc(s0);
EXPORT InValid_corp_address1_type_desc(SALT38.StrType s) := InValidFT_invalid_address1_type_desc(s);
EXPORT InValidMessage_corp_address1_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_address1_type_desc(wh);
 
EXPORT Make_corp_status_cd(SALT38.StrType s0) := MakeFT_invalid_corp_status_cd(s0);
EXPORT InValid_corp_status_cd(SALT38.StrType s) := InValidFT_invalid_corp_status_cd(s);
EXPORT InValidMessage_corp_status_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_status_cd(wh);
 
EXPORT Make_corp_status_desc(SALT38.StrType s0) := MakeFT_invalid_corp_status_desc(s0);
EXPORT InValid_corp_status_desc(SALT38.StrType s) := InValidFT_invalid_corp_status_desc(s);
EXPORT InValidMessage_corp_status_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_status_desc(wh);
 
EXPORT Make_corp_inc_state(SALT38.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_inc_state(SALT38.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_inc_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_inc_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_inc_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_term_exist_cd(SALT38.StrType s0) := MakeFT_invalid_corp_term_exist_cd(s0);
EXPORT InValid_corp_term_exist_cd(SALT38.StrType s) := InValidFT_invalid_corp_term_exist_cd(s);
EXPORT InValidMessage_corp_term_exist_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_term_exist_cd(wh);
 
EXPORT Make_corp_term_exist_desc(SALT38.StrType s0) := MakeFT_invalid_corp_term_exist_desc(s0);
EXPORT InValid_corp_term_exist_desc(SALT38.StrType s) := InValidFT_invalid_corp_term_exist_desc(s);
EXPORT InValidMessage_corp_term_exist_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_term_exist_desc(wh);
 
EXPORT Make_corp_term_exist_exp(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_term_exist_exp(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_term_exist_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_foreign_domestic_ind(SALT38.StrType s0) := MakeFT_invalid_forgn_dom_code(s0);
EXPORT InValid_corp_foreign_domestic_ind(SALT38.StrType s) := InValidFT_invalid_forgn_dom_code(s);
EXPORT InValidMessage_corp_foreign_domestic_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_forgn_dom_code(wh);
 
EXPORT Make_corp_forgn_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_forgn_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_forgn_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_orig_org_structure_cd(SALT38.StrType s0) := MakeFT_invalid_corp_orig_org_structure_cd(s0);
EXPORT InValid_corp_orig_org_structure_cd(SALT38.StrType s) := InValidFT_invalid_corp_orig_org_structure_cd(s);
EXPORT InValidMessage_corp_orig_org_structure_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_orig_org_structure_cd(wh);
 
EXPORT Make_corp_orig_org_structure_desc(SALT38.StrType s0) := MakeFT_invalid_corp_orig_org_structure_desc(s0);
EXPORT InValid_corp_orig_org_structure_desc(SALT38.StrType s) := InValidFT_invalid_corp_orig_org_structure_desc(s);
EXPORT InValidMessage_corp_orig_org_structure_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_orig_org_structure_desc(wh);
 
EXPORT Make_corp_for_profit_ind(SALT38.StrType s0) := MakeFT_invalid_for_profit_indicator(s0);
EXPORT InValid_corp_for_profit_ind(SALT38.StrType s) := InValidFT_invalid_for_profit_indicator(s);
EXPORT InValidMessage_corp_for_profit_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_for_profit_indicator(wh);
 
EXPORT Make_cont_type_cd(SALT38.StrType s0) := MakeFT_invalid_cont_type_cd(s0);
EXPORT InValid_cont_type_cd(SALT38.StrType s) := InValidFT_invalid_cont_type_cd(s);
EXPORT InValidMessage_cont_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_cont_type_cd(wh);
 
EXPORT Make_cont_type_desc(SALT38.StrType s0) := MakeFT_invalid_cont_type_desc(s0);
EXPORT InValid_cont_type_desc(SALT38.StrType s) := InValidFT_invalid_cont_type_desc(s);
EXPORT InValidMessage_cont_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_cont_type_desc(wh);
 
EXPORT Make_cont_title1_desc(SALT38.StrType s0) := MakeFT_invalid_cont_title1_desc(s0);
EXPORT InValid_cont_title1_desc(SALT38.StrType s) := InValidFT_invalid_cont_title1_desc(s);
EXPORT InValidMessage_cont_title1_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_cont_title1_desc(wh);
 
EXPORT Make_cont_address_type_cd(SALT38.StrType s0) := MakeFT_invalid_cont_type_cd(s0);
EXPORT InValid_cont_address_type_cd(SALT38.StrType s) := InValidFT_invalid_cont_type_cd(s);
EXPORT InValidMessage_cont_address_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_cont_type_cd(wh);
 
EXPORT Make_cont_address_type_desc(SALT38.StrType s0) := MakeFT_invalid_cont_type_desc(s0);
EXPORT InValid_cont_address_type_desc(SALT38.StrType s) := InValidFT_invalid_cont_type_desc(s);
EXPORT InValidMessage_cont_address_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_cont_type_desc(wh);
 
EXPORT Make_corp_dissolved_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_dissolved_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_dissolved_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_merger_date(SALT38.StrType s0) := MakeFT_invalid_optional_date(s0);
EXPORT InValid_corp_merger_date(SALT38.StrType s) := InValidFT_invalid_optional_date(s);
EXPORT InValidMessage_corp_merger_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date(wh);
 
EXPORT Make_corp_name_status_cd(SALT38.StrType s0) := MakeFT_invalid_corp_name_status_cd(s0);
EXPORT InValid_corp_name_status_cd(SALT38.StrType s) := InValidFT_invalid_corp_name_status_cd(s);
EXPORT InValidMessage_corp_name_status_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_name_status_cd(wh);
 
EXPORT Make_corp_name_status_desc(SALT38.StrType s0) := MakeFT_invalid_corp_name_status_desc(s0);
EXPORT InValid_corp_name_status_desc(SALT38.StrType s) := InValidFT_invalid_corp_name_status_desc(s);
EXPORT InValidMessage_corp_name_status_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_name_status_desc(wh);
 
EXPORT Make_corp_forgn_state_desc(SALT38.StrType s0) := MakeFT_invalid_alphablankcomma(s0);
EXPORT InValid_corp_forgn_state_desc(SALT38.StrType s) := InValidFT_invalid_alphablankcomma(s);
EXPORT InValidMessage_corp_forgn_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablankcomma(wh);
 
EXPORT Make_recordorigin(SALT38.StrType s0) := s0;
EXPORT InValid_recordorigin(SALT38.StrType s) := 0;
EXPORT InValidMessage_recordorigin(UNSIGNED1 wh) := '';
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Corp2_Mapping_PA_Main;
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
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_process_date;
    BOOLEAN Diff_corp_orig_sos_charter_nbr;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_corp_ln_name_type_cd;
    BOOLEAN Diff_corp_ln_name_type_desc;
    BOOLEAN Diff_corp_address1_type_cd;
    BOOLEAN Diff_corp_address1_type_desc;
    BOOLEAN Diff_corp_status_cd;
    BOOLEAN Diff_corp_status_desc;
    BOOLEAN Diff_corp_inc_state;
    BOOLEAN Diff_corp_inc_date;
    BOOLEAN Diff_corp_term_exist_cd;
    BOOLEAN Diff_corp_term_exist_desc;
    BOOLEAN Diff_corp_term_exist_exp;
    BOOLEAN Diff_corp_foreign_domestic_ind;
    BOOLEAN Diff_corp_forgn_date;
    BOOLEAN Diff_corp_orig_org_structure_cd;
    BOOLEAN Diff_corp_orig_org_structure_desc;
    BOOLEAN Diff_corp_for_profit_ind;
    BOOLEAN Diff_cont_type_cd;
    BOOLEAN Diff_cont_type_desc;
    BOOLEAN Diff_cont_title1_desc;
    BOOLEAN Diff_cont_address_type_cd;
    BOOLEAN Diff_cont_address_type_desc;
    BOOLEAN Diff_corp_dissolved_date;
    BOOLEAN Diff_corp_merger_date;
    BOOLEAN Diff_corp_name_status_cd;
    BOOLEAN Diff_corp_name_status_desc;
    BOOLEAN Diff_corp_forgn_state_desc;
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
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_process_date := le.corp_process_date <> ri.corp_process_date;
    SELF.Diff_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr <> ri.corp_orig_sos_charter_nbr;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_corp_ln_name_type_cd := le.corp_ln_name_type_cd <> ri.corp_ln_name_type_cd;
    SELF.Diff_corp_ln_name_type_desc := le.corp_ln_name_type_desc <> ri.corp_ln_name_type_desc;
    SELF.Diff_corp_address1_type_cd := le.corp_address1_type_cd <> ri.corp_address1_type_cd;
    SELF.Diff_corp_address1_type_desc := le.corp_address1_type_desc <> ri.corp_address1_type_desc;
    SELF.Diff_corp_status_cd := le.corp_status_cd <> ri.corp_status_cd;
    SELF.Diff_corp_status_desc := le.corp_status_desc <> ri.corp_status_desc;
    SELF.Diff_corp_inc_state := le.corp_inc_state <> ri.corp_inc_state;
    SELF.Diff_corp_inc_date := le.corp_inc_date <> ri.corp_inc_date;
    SELF.Diff_corp_term_exist_cd := le.corp_term_exist_cd <> ri.corp_term_exist_cd;
    SELF.Diff_corp_term_exist_desc := le.corp_term_exist_desc <> ri.corp_term_exist_desc;
    SELF.Diff_corp_term_exist_exp := le.corp_term_exist_exp <> ri.corp_term_exist_exp;
    SELF.Diff_corp_foreign_domestic_ind := le.corp_foreign_domestic_ind <> ri.corp_foreign_domestic_ind;
    SELF.Diff_corp_forgn_date := le.corp_forgn_date <> ri.corp_forgn_date;
    SELF.Diff_corp_orig_org_structure_cd := le.corp_orig_org_structure_cd <> ri.corp_orig_org_structure_cd;
    SELF.Diff_corp_orig_org_structure_desc := le.corp_orig_org_structure_desc <> ri.corp_orig_org_structure_desc;
    SELF.Diff_corp_for_profit_ind := le.corp_for_profit_ind <> ri.corp_for_profit_ind;
    SELF.Diff_cont_type_cd := le.cont_type_cd <> ri.cont_type_cd;
    SELF.Diff_cont_type_desc := le.cont_type_desc <> ri.cont_type_desc;
    SELF.Diff_cont_title1_desc := le.cont_title1_desc <> ri.cont_title1_desc;
    SELF.Diff_cont_address_type_cd := le.cont_address_type_cd <> ri.cont_address_type_cd;
    SELF.Diff_cont_address_type_desc := le.cont_address_type_desc <> ri.cont_address_type_desc;
    SELF.Diff_corp_dissolved_date := le.corp_dissolved_date <> ri.corp_dissolved_date;
    SELF.Diff_corp_merger_date := le.corp_merger_date <> ri.corp_merger_date;
    SELF.Diff_corp_name_status_cd := le.corp_name_status_cd <> ri.corp_name_status_cd;
    SELF.Diff_corp_name_status_desc := le.corp_name_status_desc <> ri.corp_name_status_desc;
    SELF.Diff_corp_forgn_state_desc := le.corp_forgn_state_desc <> ri.corp_forgn_state_desc;
    SELF.Diff_recordorigin := le.recordorigin <> ri.recordorigin;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_first_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_last_seen,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_corp_ln_name_type_cd,1,0)+ IF( SELF.Diff_corp_ln_name_type_desc,1,0)+ IF( SELF.Diff_corp_address1_type_cd,1,0)+ IF( SELF.Diff_corp_address1_type_desc,1,0)+ IF( SELF.Diff_corp_status_cd,1,0)+ IF( SELF.Diff_corp_status_desc,1,0)+ IF( SELF.Diff_corp_inc_state,1,0)+ IF( SELF.Diff_corp_inc_date,1,0)+ IF( SELF.Diff_corp_term_exist_cd,1,0)+ IF( SELF.Diff_corp_term_exist_desc,1,0)+ IF( SELF.Diff_corp_term_exist_exp,1,0)+ IF( SELF.Diff_corp_foreign_domestic_ind,1,0)+ IF( SELF.Diff_corp_forgn_date,1,0)+ IF( SELF.Diff_corp_orig_org_structure_cd,1,0)+ IF( SELF.Diff_corp_orig_org_structure_desc,1,0)+ IF( SELF.Diff_corp_for_profit_ind,1,0)+ IF( SELF.Diff_cont_type_cd,1,0)+ IF( SELF.Diff_cont_type_desc,1,0)+ IF( SELF.Diff_cont_title1_desc,1,0)+ IF( SELF.Diff_cont_address_type_cd,1,0)+ IF( SELF.Diff_cont_address_type_desc,1,0)+ IF( SELF.Diff_corp_dissolved_date,1,0)+ IF( SELF.Diff_corp_merger_date,1,0)+ IF( SELF.Diff_corp_name_status_cd,1,0)+ IF( SELF.Diff_corp_name_status_desc,1,0)+ IF( SELF.Diff_corp_forgn_state_desc,1,0)+ IF( SELF.Diff_recordorigin,1,0);
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
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_process_date := COUNT(GROUP,%Closest%.Diff_corp_process_date);
    Count_Diff_corp_orig_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_orig_sos_charter_nbr);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_corp_ln_name_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_cd);
    Count_Diff_corp_ln_name_type_desc := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_desc);
    Count_Diff_corp_address1_type_cd := COUNT(GROUP,%Closest%.Diff_corp_address1_type_cd);
    Count_Diff_corp_address1_type_desc := COUNT(GROUP,%Closest%.Diff_corp_address1_type_desc);
    Count_Diff_corp_status_cd := COUNT(GROUP,%Closest%.Diff_corp_status_cd);
    Count_Diff_corp_status_desc := COUNT(GROUP,%Closest%.Diff_corp_status_desc);
    Count_Diff_corp_inc_state := COUNT(GROUP,%Closest%.Diff_corp_inc_state);
    Count_Diff_corp_inc_date := COUNT(GROUP,%Closest%.Diff_corp_inc_date);
    Count_Diff_corp_term_exist_cd := COUNT(GROUP,%Closest%.Diff_corp_term_exist_cd);
    Count_Diff_corp_term_exist_desc := COUNT(GROUP,%Closest%.Diff_corp_term_exist_desc);
    Count_Diff_corp_term_exist_exp := COUNT(GROUP,%Closest%.Diff_corp_term_exist_exp);
    Count_Diff_corp_foreign_domestic_ind := COUNT(GROUP,%Closest%.Diff_corp_foreign_domestic_ind);
    Count_Diff_corp_forgn_date := COUNT(GROUP,%Closest%.Diff_corp_forgn_date);
    Count_Diff_corp_orig_org_structure_cd := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_cd);
    Count_Diff_corp_orig_org_structure_desc := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_desc);
    Count_Diff_corp_for_profit_ind := COUNT(GROUP,%Closest%.Diff_corp_for_profit_ind);
    Count_Diff_cont_type_cd := COUNT(GROUP,%Closest%.Diff_cont_type_cd);
    Count_Diff_cont_type_desc := COUNT(GROUP,%Closest%.Diff_cont_type_desc);
    Count_Diff_cont_title1_desc := COUNT(GROUP,%Closest%.Diff_cont_title1_desc);
    Count_Diff_cont_address_type_cd := COUNT(GROUP,%Closest%.Diff_cont_address_type_cd);
    Count_Diff_cont_address_type_desc := COUNT(GROUP,%Closest%.Diff_cont_address_type_desc);
    Count_Diff_corp_dissolved_date := COUNT(GROUP,%Closest%.Diff_corp_dissolved_date);
    Count_Diff_corp_merger_date := COUNT(GROUP,%Closest%.Diff_corp_merger_date);
    Count_Diff_corp_name_status_cd := COUNT(GROUP,%Closest%.Diff_corp_name_status_cd);
    Count_Diff_corp_name_status_desc := COUNT(GROUP,%Closest%.Diff_corp_name_status_desc);
    Count_Diff_corp_forgn_state_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_desc);
    Count_Diff_recordorigin := COUNT(GROUP,%Closest%.Diff_recordorigin);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
