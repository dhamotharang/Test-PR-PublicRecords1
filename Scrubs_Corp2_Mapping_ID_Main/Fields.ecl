IMPORT SALT311;
IMPORT Scrubs_Corp2_Mapping_ID_Main,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
EXPORT NumFields := 34;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_key','invalid_corp_vendor','invalid_state_origin','invalid_name_type_code','invalid_name_type_desc','invalid_status','invalid_mandatory','invalid_charter','invalid_date','invalid_exp_date','invalid_term_exist_cd','invalid_term_exist_desc','invalid_forgn_dom_code','invalid_flag_code','invalid_management','invalid_recordorigin','invalid_month','invalid_alphablank','invalid_alphablankcomma','invalid_org_structure_desc');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_corp_key' => 1,'invalid_corp_vendor' => 2,'invalid_state_origin' => 3,'invalid_name_type_code' => 4,'invalid_name_type_desc' => 5,'invalid_status' => 6,'invalid_mandatory' => 7,'invalid_charter' => 8,'invalid_date' => 9,'invalid_exp_date' => 10,'invalid_term_exist_cd' => 11,'invalid_term_exist_desc' => 12,'invalid_forgn_dom_code' => 13,'invalid_flag_code' => 14,'invalid_management' => 15,'invalid_recordorigin' => 16,'invalid_month' => 17,'invalid_alphablank' => 18,'invalid_alphablankcomma' => 19,'invalid_org_structure_desc' => 20,0);
 
EXPORT MakeFT_invalid_corp_key(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) = 13));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789-'),SALT311.HygieneErrors.NotLength('13'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_vendor(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['16','16']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('16|16'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['ID','ID']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('ID|ID'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN Scrubs_Corp2_Mapping_ID_Main.Functions.Name_Type_Codes);
EXPORT InValidMessageFT_invalid_name_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_ID_Main.Functions.Name_Type_Codes'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_desc(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN Scrubs_Corp2_Mapping_ID_Main.Functions.Name_Type_Descs);
EXPORT InValidMessageFT_invalid_name_type_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_ID_Main.Functions.Name_Type_Descs'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_status(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_status(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN Scrubs_Corp2_Mapping_ID_Main.Functions.status_Descs);
EXPORT InValidMessageFT_invalid_status(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Scrubs_Corp2_Mapping_ID_Main.Functions.status_Descs'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT311.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotLength('1..'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) = 10));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.NotLength('10'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_pastDate(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_exp_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_exp_date(SALT311.StrType s) := WHICH(~Scrubs.fn_valid_GeneralDate(s)>0);
EXPORT InValidMessageFT_invalid_exp_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_term_exist_cd(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_term_exist_cd(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['P',' ']);
EXPORT InValidMessageFT_invalid_term_exist_cd(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('P| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_term_exist_desc(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_term_exist_desc(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['PERPETUAL',' ']);
EXPORT InValidMessageFT_invalid_term_exist_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('PERPETUAL| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_forgn_dom_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_forgn_dom_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['D','F',' ']);
EXPORT InValidMessageFT_invalid_forgn_dom_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('D|F| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_flag_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_flag_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['N',' ']);
EXPORT InValidMessageFT_invalid_flag_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('N| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_management(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_management(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['Y',' ']);
EXPORT InValidMessageFT_invalid_management(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('Y| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_recordorigin(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_recordorigin(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['C','C']);
EXPORT InValidMessageFT_invalid_recordorigin(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('C|C'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_month(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_month(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPT','OCTOBER','NOVEMBER','DECEMBER',' ']);
EXPORT InValidMessageFT_invalid_month(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('JANUARY|FEBRUARY|MARCH|APRIL|MAY|JUNE|JULY|AUGUST|SEPT|OCTOBER|NOVEMBER|DECEMBER| '),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablank(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablank(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablank(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablankcomma(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablankcomma(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablankcomma(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_org_structure_desc(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,' -()ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_org_structure_desc(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,' -()ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_org_structure_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars(' -()ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_status_desc','corp_status_date','corp_inc_state','corp_inc_date','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_forgn_date','corp_term_exist_cd','corp_term_exist_desc','corp_orig_org_structure_desc','corp_for_profit_ind','corp_name_reservation_expiration_date','corp_orig_bus_type_desc','corp_management_desc','corp_fiscal_year_month','corp_agent_county','InternalField1','InternalField2','InternalField3','recordorigin');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_key','corp_vendor','corp_state_origin','corp_process_date','corp_orig_sos_charter_nbr','corp_legal_name','corp_ln_name_type_cd','corp_ln_name_type_desc','corp_status_desc','corp_status_date','corp_inc_state','corp_inc_date','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_forgn_date','corp_term_exist_cd','corp_term_exist_desc','corp_orig_org_structure_desc','corp_for_profit_ind','corp_name_reservation_expiration_date','corp_orig_bus_type_desc','corp_management_desc','corp_fiscal_year_month','corp_agent_county','InternalField1','InternalField2','InternalField3','recordorigin');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'dt_vendor_first_reported' => 0,'dt_vendor_last_reported' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'corp_ra_dt_first_seen' => 4,'corp_ra_dt_last_seen' => 5,'corp_key' => 6,'corp_vendor' => 7,'corp_state_origin' => 8,'corp_process_date' => 9,'corp_orig_sos_charter_nbr' => 10,'corp_legal_name' => 11,'corp_ln_name_type_cd' => 12,'corp_ln_name_type_desc' => 13,'corp_status_desc' => 14,'corp_status_date' => 15,'corp_inc_state' => 16,'corp_inc_date' => 17,'corp_foreign_domestic_ind' => 18,'corp_forgn_state_desc' => 19,'corp_forgn_date' => 20,'corp_term_exist_cd' => 21,'corp_term_exist_desc' => 22,'corp_orig_org_structure_desc' => 23,'corp_for_profit_ind' => 24,'corp_name_reservation_expiration_date' => 25,'corp_orig_bus_type_desc' => 26,'corp_management_desc' => 27,'corp_fiscal_year_month' => 28,'corp_agent_county' => 29,'InternalField1' => 30,'InternalField2' => 31,'InternalField3' => 32,'recordorigin' => 33,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW','LENGTHS'],['ENUM'],['ENUM'],['CUSTOM'],['ALLOW','LENGTHS'],['LENGTHS'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['ALLOW'],['CUSTOM'],['ENUM'],['ENUM'],['ALLOW'],['ENUM'],['CUSTOM'],['ALLOW'],['ENUM'],['ENUM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_ra_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_ra_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_ra_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_ra_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_ra_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_key(SALT311.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT311.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_vendor(SALT311.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT311.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_state_origin(SALT311.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT311.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_process_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_process_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT311.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_corp_orig_sos_charter_nbr(SALT311.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
 
EXPORT Make_corp_legal_name(SALT311.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT311.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_ln_name_type_cd(SALT311.StrType s0) := MakeFT_invalid_name_type_code(s0);
EXPORT InValid_corp_ln_name_type_cd(SALT311.StrType s) := InValidFT_invalid_name_type_code(s);
EXPORT InValidMessage_corp_ln_name_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type_code(wh);
 
EXPORT Make_corp_ln_name_type_desc(SALT311.StrType s0) := MakeFT_invalid_name_type_desc(s0);
EXPORT InValid_corp_ln_name_type_desc(SALT311.StrType s) := InValidFT_invalid_name_type_desc(s);
EXPORT InValidMessage_corp_ln_name_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type_desc(wh);
 
EXPORT Make_corp_status_desc(SALT311.StrType s0) := MakeFT_invalid_status(s0);
EXPORT InValid_corp_status_desc(SALT311.StrType s) := InValidFT_invalid_status(s);
EXPORT InValidMessage_corp_status_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_status(wh);
 
EXPORT Make_corp_status_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_status_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_status_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_inc_state(SALT311.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_inc_state(SALT311.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_inc_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_inc_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_inc_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_foreign_domestic_ind(SALT311.StrType s0) := MakeFT_invalid_forgn_dom_code(s0);
EXPORT InValid_corp_foreign_domestic_ind(SALT311.StrType s) := InValidFT_invalid_forgn_dom_code(s);
EXPORT InValidMessage_corp_foreign_domestic_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_forgn_dom_code(wh);
 
EXPORT Make_corp_forgn_state_desc(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_corp_forgn_state_desc(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_corp_forgn_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_corp_forgn_date(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_corp_forgn_date(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_corp_forgn_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_corp_term_exist_cd(SALT311.StrType s0) := MakeFT_invalid_term_exist_cd(s0);
EXPORT InValid_corp_term_exist_cd(SALT311.StrType s) := InValidFT_invalid_term_exist_cd(s);
EXPORT InValidMessage_corp_term_exist_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_term_exist_cd(wh);
 
EXPORT Make_corp_term_exist_desc(SALT311.StrType s0) := MakeFT_invalid_term_exist_desc(s0);
EXPORT InValid_corp_term_exist_desc(SALT311.StrType s) := InValidFT_invalid_term_exist_desc(s);
EXPORT InValidMessage_corp_term_exist_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_term_exist_desc(wh);
 
EXPORT Make_corp_orig_org_structure_desc(SALT311.StrType s0) := MakeFT_invalid_org_structure_desc(s0);
EXPORT InValid_corp_orig_org_structure_desc(SALT311.StrType s) := InValidFT_invalid_org_structure_desc(s);
EXPORT InValidMessage_corp_orig_org_structure_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_org_structure_desc(wh);
 
EXPORT Make_corp_for_profit_ind(SALT311.StrType s0) := MakeFT_invalid_flag_code(s0);
EXPORT InValid_corp_for_profit_ind(SALT311.StrType s) := InValidFT_invalid_flag_code(s);
EXPORT InValidMessage_corp_for_profit_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_flag_code(wh);
 
EXPORT Make_corp_name_reservation_expiration_date(SALT311.StrType s0) := MakeFT_invalid_exp_date(s0);
EXPORT InValid_corp_name_reservation_expiration_date(SALT311.StrType s) := InValidFT_invalid_exp_date(s);
EXPORT InValidMessage_corp_name_reservation_expiration_date(UNSIGNED1 wh) := InValidMessageFT_invalid_exp_date(wh);
 
EXPORT Make_corp_orig_bus_type_desc(SALT311.StrType s0) := MakeFT_invalid_alphablankcomma(s0);
EXPORT InValid_corp_orig_bus_type_desc(SALT311.StrType s) := InValidFT_invalid_alphablankcomma(s);
EXPORT InValidMessage_corp_orig_bus_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablankcomma(wh);
 
EXPORT Make_corp_management_desc(SALT311.StrType s0) := MakeFT_invalid_management(s0);
EXPORT InValid_corp_management_desc(SALT311.StrType s) := InValidFT_invalid_management(s);
EXPORT InValidMessage_corp_management_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_management(wh);
 
EXPORT Make_corp_fiscal_year_month(SALT311.StrType s0) := MakeFT_invalid_month(s0);
EXPORT InValid_corp_fiscal_year_month(SALT311.StrType s) := InValidFT_invalid_month(s);
EXPORT InValidMessage_corp_fiscal_year_month(UNSIGNED1 wh) := InValidMessageFT_invalid_month(wh);
 
EXPORT Make_corp_agent_county(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_corp_agent_county(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_corp_agent_county(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_InternalField1(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_InternalField1(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_InternalField1(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_InternalField2(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_InternalField2(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_InternalField2(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_InternalField3(SALT311.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_InternalField3(SALT311.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_InternalField3(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_recordorigin(SALT311.StrType s0) := MakeFT_invalid_recordorigin(s0);
EXPORT InValid_recordorigin(SALT311.StrType s) := InValidFT_invalid_recordorigin(s);
EXPORT InValidMessage_recordorigin(UNSIGNED1 wh) := InValidMessageFT_invalid_recordorigin(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Corp2_Mapping_ID_Main;
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
    BOOLEAN Diff_corp_status_desc;
    BOOLEAN Diff_corp_status_date;
    BOOLEAN Diff_corp_inc_state;
    BOOLEAN Diff_corp_inc_date;
    BOOLEAN Diff_corp_foreign_domestic_ind;
    BOOLEAN Diff_corp_forgn_state_desc;
    BOOLEAN Diff_corp_forgn_date;
    BOOLEAN Diff_corp_term_exist_cd;
    BOOLEAN Diff_corp_term_exist_desc;
    BOOLEAN Diff_corp_orig_org_structure_desc;
    BOOLEAN Diff_corp_for_profit_ind;
    BOOLEAN Diff_corp_name_reservation_expiration_date;
    BOOLEAN Diff_corp_orig_bus_type_desc;
    BOOLEAN Diff_corp_management_desc;
    BOOLEAN Diff_corp_fiscal_year_month;
    BOOLEAN Diff_corp_agent_county;
    BOOLEAN Diff_InternalField1;
    BOOLEAN Diff_InternalField2;
    BOOLEAN Diff_InternalField3;
    BOOLEAN Diff_recordorigin;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
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
    SELF.Diff_corp_status_desc := le.corp_status_desc <> ri.corp_status_desc;
    SELF.Diff_corp_status_date := le.corp_status_date <> ri.corp_status_date;
    SELF.Diff_corp_inc_state := le.corp_inc_state <> ri.corp_inc_state;
    SELF.Diff_corp_inc_date := le.corp_inc_date <> ri.corp_inc_date;
    SELF.Diff_corp_foreign_domestic_ind := le.corp_foreign_domestic_ind <> ri.corp_foreign_domestic_ind;
    SELF.Diff_corp_forgn_state_desc := le.corp_forgn_state_desc <> ri.corp_forgn_state_desc;
    SELF.Diff_corp_forgn_date := le.corp_forgn_date <> ri.corp_forgn_date;
    SELF.Diff_corp_term_exist_cd := le.corp_term_exist_cd <> ri.corp_term_exist_cd;
    SELF.Diff_corp_term_exist_desc := le.corp_term_exist_desc <> ri.corp_term_exist_desc;
    SELF.Diff_corp_orig_org_structure_desc := le.corp_orig_org_structure_desc <> ri.corp_orig_org_structure_desc;
    SELF.Diff_corp_for_profit_ind := le.corp_for_profit_ind <> ri.corp_for_profit_ind;
    SELF.Diff_corp_name_reservation_expiration_date := le.corp_name_reservation_expiration_date <> ri.corp_name_reservation_expiration_date;
    SELF.Diff_corp_orig_bus_type_desc := le.corp_orig_bus_type_desc <> ri.corp_orig_bus_type_desc;
    SELF.Diff_corp_management_desc := le.corp_management_desc <> ri.corp_management_desc;
    SELF.Diff_corp_fiscal_year_month := le.corp_fiscal_year_month <> ri.corp_fiscal_year_month;
    SELF.Diff_corp_agent_county := le.corp_agent_county <> ri.corp_agent_county;
    SELF.Diff_InternalField1 := le.InternalField1 <> ri.InternalField1;
    SELF.Diff_InternalField2 := le.InternalField2 <> ri.InternalField2;
    SELF.Diff_InternalField3 := le.InternalField3 <> ri.InternalField3;
    SELF.Diff_recordorigin := le.recordorigin <> ri.recordorigin;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_first_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_last_seen,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_corp_ln_name_type_cd,1,0)+ IF( SELF.Diff_corp_ln_name_type_desc,1,0)+ IF( SELF.Diff_corp_status_desc,1,0)+ IF( SELF.Diff_corp_status_date,1,0)+ IF( SELF.Diff_corp_inc_state,1,0)+ IF( SELF.Diff_corp_inc_date,1,0)+ IF( SELF.Diff_corp_foreign_domestic_ind,1,0)+ IF( SELF.Diff_corp_forgn_state_desc,1,0)+ IF( SELF.Diff_corp_forgn_date,1,0)+ IF( SELF.Diff_corp_term_exist_cd,1,0)+ IF( SELF.Diff_corp_term_exist_desc,1,0)+ IF( SELF.Diff_corp_orig_org_structure_desc,1,0)+ IF( SELF.Diff_corp_for_profit_ind,1,0)+ IF( SELF.Diff_corp_name_reservation_expiration_date,1,0)+ IF( SELF.Diff_corp_orig_bus_type_desc,1,0)+ IF( SELF.Diff_corp_management_desc,1,0)+ IF( SELF.Diff_corp_fiscal_year_month,1,0)+ IF( SELF.Diff_corp_agent_county,1,0)+ IF( SELF.Diff_InternalField1,1,0)+ IF( SELF.Diff_InternalField2,1,0)+ IF( SELF.Diff_InternalField3,1,0)+ IF( SELF.Diff_recordorigin,1,0);
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
    Count_Diff_corp_status_desc := COUNT(GROUP,%Closest%.Diff_corp_status_desc);
    Count_Diff_corp_status_date := COUNT(GROUP,%Closest%.Diff_corp_status_date);
    Count_Diff_corp_inc_state := COUNT(GROUP,%Closest%.Diff_corp_inc_state);
    Count_Diff_corp_inc_date := COUNT(GROUP,%Closest%.Diff_corp_inc_date);
    Count_Diff_corp_foreign_domestic_ind := COUNT(GROUP,%Closest%.Diff_corp_foreign_domestic_ind);
    Count_Diff_corp_forgn_state_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_desc);
    Count_Diff_corp_forgn_date := COUNT(GROUP,%Closest%.Diff_corp_forgn_date);
    Count_Diff_corp_term_exist_cd := COUNT(GROUP,%Closest%.Diff_corp_term_exist_cd);
    Count_Diff_corp_term_exist_desc := COUNT(GROUP,%Closest%.Diff_corp_term_exist_desc);
    Count_Diff_corp_orig_org_structure_desc := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_desc);
    Count_Diff_corp_for_profit_ind := COUNT(GROUP,%Closest%.Diff_corp_for_profit_ind);
    Count_Diff_corp_name_reservation_expiration_date := COUNT(GROUP,%Closest%.Diff_corp_name_reservation_expiration_date);
    Count_Diff_corp_orig_bus_type_desc := COUNT(GROUP,%Closest%.Diff_corp_orig_bus_type_desc);
    Count_Diff_corp_management_desc := COUNT(GROUP,%Closest%.Diff_corp_management_desc);
    Count_Diff_corp_fiscal_year_month := COUNT(GROUP,%Closest%.Diff_corp_fiscal_year_month);
    Count_Diff_corp_agent_county := COUNT(GROUP,%Closest%.Diff_corp_agent_county);
    Count_Diff_InternalField1 := COUNT(GROUP,%Closest%.Diff_InternalField1);
    Count_Diff_InternalField2 := COUNT(GROUP,%Closest%.Diff_InternalField2);
    Count_Diff_InternalField3 := COUNT(GROUP,%Closest%.Diff_InternalField3);
    Count_Diff_recordorigin := COUNT(GROUP,%Closest%.Diff_recordorigin);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
