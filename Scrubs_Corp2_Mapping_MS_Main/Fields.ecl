IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_Corp2_Mapping_MS_Main; // Import modules for FieldTypes attribute definitions
EXPORT Fields := MODULE
 
// Processing for each FieldType
EXPORT SALT34.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_corp_vendor','invalid_state_origin','invalid_mandatory','invalid_alphablank','invalid_alphablankhyphen','invalid_alphablankcomma','invalid_corp_key','invalid_charter','invalid_date_general','invalid_date_past','invalid_optional_date_general','invalid_optional_date_past','invalid_forgn_dom_code','invalid_for_profit_ind','invalid_name_type_code','invalid_corp_filing_desc');
EXPORT FieldTypeNum(SALT34.StrType fn) := CASE(fn,'invalid_corp_vendor' => 1,'invalid_state_origin' => 2,'invalid_mandatory' => 3,'invalid_alphablank' => 4,'invalid_alphablankhyphen' => 5,'invalid_alphablankcomma' => 6,'invalid_corp_key' => 7,'invalid_charter' => 8,'invalid_date_general' => 9,'invalid_date_past' => 10,'invalid_optional_date_general' => 11,'invalid_optional_date_past' => 12,'invalid_forgn_dom_code' => 13,'invalid_for_profit_ind' => 14,'invalid_name_type_code' => 15,'invalid_corp_filing_desc' => 16,0);
 
EXPORT MakeFT_invalid_corp_vendor(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_vendor(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['28']);
EXPORT InValidMessageFT_invalid_corp_vendor(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('28'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state_origin(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state_origin(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['MS']);
EXPORT InValidMessageFT_invalid_state_origin(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('MS'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mandatory(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT34.StrType s) := WHICH(~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablank(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablank(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablank(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablankhyphen(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablankhyphen(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablankhyphen(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphablankcomma(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphablankcomma(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphablankcomma(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars(' ,ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_key(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789-'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_corp_key(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789-'))),~(LENGTH(TRIM(s)) >= 4));
EXPORT InValidMessageFT_invalid_corp_key(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789-'),SALT34.HygieneErrors.NotLength('4..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_charter(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_charter(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~(LENGTH(TRIM(s)) >= 1));
EXPORT InValidMessageFT_invalid_charter(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.NotLength('1..'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_general(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date_general(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date_general(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date_past(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_date_past(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_date_past(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT34.HygieneErrors.NotLength('8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_optional_date_general(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_optional_date_general(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_GeneralDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_optional_date_general(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_GeneralDate'),SALT34.HygieneErrors.NotLength('0,1,8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_optional_date_past(SALT34.StrType s0) := FUNCTION
  s1 := SALT34.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_optional_date_past(SALT34.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT34.StringFilter(s,'0123456789'))),~Scrubs.fn_valid_pastDate(s)>0,~(LENGTH(TRIM(s)) = 0 OR LENGTH(TRIM(s)) = 1 OR LENGTH(TRIM(s)) = 8));
EXPORT InValidMessageFT_invalid_optional_date_past(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInChars('0123456789'),SALT34.HygieneErrors.CustomFail('Scrubs.fn_valid_pastDate'),SALT34.HygieneErrors.NotLength('0,1,8'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_forgn_dom_code(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_forgn_dom_code(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['D','F',' ']);
EXPORT InValidMessageFT_invalid_forgn_dom_code(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('D|F| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_for_profit_ind(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_for_profit_ind(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['Y','N',' ']);
EXPORT InValidMessageFT_invalid_for_profit_ind(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('Y|N| '),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_name_type_code(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_name_type_code(SALT34.StrType s,SALT34.StrType recordOrigin) := WHICH(~Scrubs_Corp2_Mapping_MS_Main.Functions.invalid_name_type_code(s,recordOrigin)>0);
EXPORT InValidMessageFT_invalid_name_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.CustomFail('Scrubs_Corp2_Mapping_MS_Main.Functions.invalid_name_type_code'),SALT34.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_corp_filing_desc(SALT34.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_corp_filing_desc(SALT34.StrType s) := WHICH(((SALT34.StrType) s) NOT IN ['HOME STATE','APPROVED','ANNUAL MEETING DATE','DURATION DATE','EXPIRATION DATE','FILED','FUTURE EFFECTIVE DATE','SUBMITTED','AMENDMENT ADOPTED DATE',' ']);
EXPORT InValidMessageFT_invalid_corp_filing_desc(UNSIGNED1 wh) := CHOOSE(wh,SALT34.HygieneErrors.NotInEnum('HOME STATE|APPROVED|ANNUAL MEETING DATE|DURATION DATE|EXPIRATION DATE|FILED|FUTURE EFFECTIVE DATE|SUBMITTED|AMENDMENT ADOPTED DATE| '),SALT34.HygieneErrors.Good);
 
EXPORT SALT34.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dt_vendor_first_reported','dt_vendor_last_reported','dt_first_seen','dt_last_seen','corp_ra_dt_first_seen','corp_ra_dt_last_seen','corp_process_date','corp_filing_date','corp_delayed_effective_date','corp_forgn_date','corp_dissolved_date','corp_inc_date','corp_key','corp_vendor','corp_state_origin','corp_orig_sos_charter_nbr','corp_legal_name','corp_inc_state','corp_foreign_domestic_ind','corp_forgn_state_desc','corp_country_of_formation','corp_for_profit_ind','corp_status_desc','corp_ln_name_type_cd','recordorigin','corp_orig_org_structure_desc','corp_filing_desc','cont_type_desc','cont_title1_desc','cont_title2_desc','cont_title3_desc','cont_title4_desc','cont_title5_desc');
EXPORT FieldNum(SALT34.StrType fn) := CASE(fn,'dt_vendor_first_reported' => 0,'dt_vendor_last_reported' => 1,'dt_first_seen' => 2,'dt_last_seen' => 3,'corp_ra_dt_first_seen' => 4,'corp_ra_dt_last_seen' => 5,'corp_process_date' => 6,'corp_filing_date' => 7,'corp_delayed_effective_date' => 8,'corp_forgn_date' => 9,'corp_dissolved_date' => 10,'corp_inc_date' => 11,'corp_key' => 12,'corp_vendor' => 13,'corp_state_origin' => 14,'corp_orig_sos_charter_nbr' => 15,'corp_legal_name' => 16,'corp_inc_state' => 17,'corp_foreign_domestic_ind' => 18,'corp_forgn_state_desc' => 19,'corp_country_of_formation' => 20,'corp_for_profit_ind' => 21,'corp_status_desc' => 22,'corp_ln_name_type_cd' => 23,'recordorigin' => 24,'corp_orig_org_structure_desc' => 25,'corp_filing_desc' => 26,'cont_type_desc' => 27,'cont_title1_desc' => 28,'cont_title2_desc' => 29,'cont_title3_desc' => 30,'cont_title4_desc' => 31,'cont_title5_desc' => 32,0);
 
//Individual field level validation
 
EXPORT Make_dt_vendor_first_reported(SALT34.StrType s0) := MakeFT_invalid_date_past(s0);
EXPORT InValid_dt_vendor_first_reported(SALT34.StrType s) := InValidFT_invalid_date_past(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date_past(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT34.StrType s0) := MakeFT_invalid_date_past(s0);
EXPORT InValid_dt_vendor_last_reported(SALT34.StrType s) := InValidFT_invalid_date_past(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date_past(wh);
 
EXPORT Make_dt_first_seen(SALT34.StrType s0) := MakeFT_invalid_date_past(s0);
EXPORT InValid_dt_first_seen(SALT34.StrType s) := InValidFT_invalid_date_past(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date_past(wh);
 
EXPORT Make_dt_last_seen(SALT34.StrType s0) := MakeFT_invalid_date_past(s0);
EXPORT InValid_dt_last_seen(SALT34.StrType s) := InValidFT_invalid_date_past(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date_past(wh);
 
EXPORT Make_corp_ra_dt_first_seen(SALT34.StrType s0) := MakeFT_invalid_date_past(s0);
EXPORT InValid_corp_ra_dt_first_seen(SALT34.StrType s) := InValidFT_invalid_date_past(s);
EXPORT InValidMessage_corp_ra_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date_past(wh);
 
EXPORT Make_corp_ra_dt_last_seen(SALT34.StrType s0) := MakeFT_invalid_date_past(s0);
EXPORT InValid_corp_ra_dt_last_seen(SALT34.StrType s) := InValidFT_invalid_date_past(s);
EXPORT InValidMessage_corp_ra_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date_past(wh);
 
EXPORT Make_corp_process_date(SALT34.StrType s0) := MakeFT_invalid_date_past(s0);
EXPORT InValid_corp_process_date(SALT34.StrType s) := InValidFT_invalid_date_past(s);
EXPORT InValidMessage_corp_process_date(UNSIGNED1 wh) := InValidMessageFT_invalid_date_past(wh);
 
EXPORT Make_corp_filing_date(SALT34.StrType s0) := MakeFT_invalid_optional_date_past(s0);
EXPORT InValid_corp_filing_date(SALT34.StrType s) := InValidFT_invalid_optional_date_past(s);
EXPORT InValidMessage_corp_filing_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date_past(wh);
 
EXPORT Make_corp_delayed_effective_date(SALT34.StrType s0) := MakeFT_invalid_optional_date_general(s0);
EXPORT InValid_corp_delayed_effective_date(SALT34.StrType s) := InValidFT_invalid_optional_date_general(s);
EXPORT InValidMessage_corp_delayed_effective_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date_general(wh);
 
EXPORT Make_corp_forgn_date(SALT34.StrType s0) := MakeFT_invalid_optional_date_general(s0);
EXPORT InValid_corp_forgn_date(SALT34.StrType s) := InValidFT_invalid_optional_date_general(s);
EXPORT InValidMessage_corp_forgn_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date_general(wh);
 
EXPORT Make_corp_dissolved_date(SALT34.StrType s0) := MakeFT_invalid_optional_date_general(s0);
EXPORT InValid_corp_dissolved_date(SALT34.StrType s) := InValidFT_invalid_optional_date_general(s);
EXPORT InValidMessage_corp_dissolved_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date_general(wh);
 
EXPORT Make_corp_inc_date(SALT34.StrType s0) := MakeFT_invalid_optional_date_general(s0);
EXPORT InValid_corp_inc_date(SALT34.StrType s) := InValidFT_invalid_optional_date_general(s);
EXPORT InValidMessage_corp_inc_date(UNSIGNED1 wh) := InValidMessageFT_invalid_optional_date_general(wh);
 
EXPORT Make_corp_key(SALT34.StrType s0) := MakeFT_invalid_corp_key(s0);
EXPORT InValid_corp_key(SALT34.StrType s) := InValidFT_invalid_corp_key(s);
EXPORT InValidMessage_corp_key(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_key(wh);
 
EXPORT Make_corp_vendor(SALT34.StrType s0) := MakeFT_invalid_corp_vendor(s0);
EXPORT InValid_corp_vendor(SALT34.StrType s) := InValidFT_invalid_corp_vendor(s);
EXPORT InValidMessage_corp_vendor(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_vendor(wh);
 
EXPORT Make_corp_state_origin(SALT34.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_state_origin(SALT34.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_state_origin(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_orig_sos_charter_nbr(SALT34.StrType s0) := MakeFT_invalid_charter(s0);
EXPORT InValid_corp_orig_sos_charter_nbr(SALT34.StrType s) := InValidFT_invalid_charter(s);
EXPORT InValidMessage_corp_orig_sos_charter_nbr(UNSIGNED1 wh) := InValidMessageFT_invalid_charter(wh);
 
EXPORT Make_corp_legal_name(SALT34.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_corp_legal_name(SALT34.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_corp_legal_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_corp_inc_state(SALT34.StrType s0) := MakeFT_invalid_state_origin(s0);
EXPORT InValid_corp_inc_state(SALT34.StrType s) := InValidFT_invalid_state_origin(s);
EXPORT InValidMessage_corp_inc_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state_origin(wh);
 
EXPORT Make_corp_foreign_domestic_ind(SALT34.StrType s0) := MakeFT_invalid_forgn_dom_code(s0);
EXPORT InValid_corp_foreign_domestic_ind(SALT34.StrType s) := InValidFT_invalid_forgn_dom_code(s);
EXPORT InValidMessage_corp_foreign_domestic_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_forgn_dom_code(wh);
 
EXPORT Make_corp_forgn_state_desc(SALT34.StrType s0) := MakeFT_invalid_alphablankcomma(s0);
EXPORT InValid_corp_forgn_state_desc(SALT34.StrType s) := InValidFT_invalid_alphablankcomma(s);
EXPORT InValidMessage_corp_forgn_state_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablankcomma(wh);
 
EXPORT Make_corp_country_of_formation(SALT34.StrType s0) := MakeFT_invalid_alphablankcomma(s0);
EXPORT InValid_corp_country_of_formation(SALT34.StrType s) := InValidFT_invalid_alphablankcomma(s);
EXPORT InValidMessage_corp_country_of_formation(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablankcomma(wh);
 
EXPORT Make_corp_for_profit_ind(SALT34.StrType s0) := MakeFT_invalid_for_profit_ind(s0);
EXPORT InValid_corp_for_profit_ind(SALT34.StrType s) := InValidFT_invalid_for_profit_ind(s);
EXPORT InValidMessage_corp_for_profit_ind(UNSIGNED1 wh) := InValidMessageFT_invalid_for_profit_ind(wh);
 
EXPORT Make_corp_status_desc(SALT34.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_corp_status_desc(SALT34.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_corp_status_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_corp_ln_name_type_cd(SALT34.StrType s0) := MakeFT_invalid_name_type_code(s0);
EXPORT InValid_corp_ln_name_type_cd(SALT34.StrType s,SALT34.StrType recordOrigin) := InValidFT_invalid_name_type_code(s,recordOrigin);
EXPORT InValidMessage_corp_ln_name_type_cd(UNSIGNED1 wh) := InValidMessageFT_invalid_name_type_code(wh);
 
EXPORT Make_recordorigin(SALT34.StrType s0) := s0;
EXPORT InValid_recordorigin(SALT34.StrType s) := FALSE;
EXPORT InValidMessage_recordorigin(UNSIGNED1 wh) := '';
 
EXPORT Make_corp_orig_org_structure_desc(SALT34.StrType s0) := MakeFT_invalid_alphablankhyphen(s0);
EXPORT InValid_corp_orig_org_structure_desc(SALT34.StrType s) := InValidFT_invalid_alphablankhyphen(s);
EXPORT InValidMessage_corp_orig_org_structure_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablankhyphen(wh);
 
EXPORT Make_corp_filing_desc(SALT34.StrType s0) := MakeFT_invalid_corp_filing_desc(s0);
EXPORT InValid_corp_filing_desc(SALT34.StrType s) := InValidFT_invalid_corp_filing_desc(s);
EXPORT InValidMessage_corp_filing_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_corp_filing_desc(wh);
 
EXPORT Make_cont_type_desc(SALT34.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_cont_type_desc(SALT34.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_cont_type_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_cont_title1_desc(SALT34.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_cont_title1_desc(SALT34.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_cont_title1_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_cont_title2_desc(SALT34.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_cont_title2_desc(SALT34.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_cont_title2_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_cont_title3_desc(SALT34.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_cont_title3_desc(SALT34.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_cont_title3_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_cont_title4_desc(SALT34.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_cont_title4_desc(SALT34.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_cont_title4_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
EXPORT Make_cont_title5_desc(SALT34.StrType s0) := MakeFT_invalid_alphablank(s0);
EXPORT InValid_cont_title5_desc(SALT34.StrType s) := InValidFT_invalid_alphablank(s);
EXPORT InValidMessage_cont_title5_desc(UNSIGNED1 wh) := InValidMessageFT_invalid_alphablank(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT34,Scrubs_Corp2_Mapping_MS_Main;
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
    BOOLEAN Diff_corp_filing_date;
    BOOLEAN Diff_corp_delayed_effective_date;
    BOOLEAN Diff_corp_forgn_date;
    BOOLEAN Diff_corp_dissolved_date;
    BOOLEAN Diff_corp_inc_date;
    BOOLEAN Diff_corp_key;
    BOOLEAN Diff_corp_vendor;
    BOOLEAN Diff_corp_state_origin;
    BOOLEAN Diff_corp_orig_sos_charter_nbr;
    BOOLEAN Diff_corp_legal_name;
    BOOLEAN Diff_corp_inc_state;
    BOOLEAN Diff_corp_foreign_domestic_ind;
    BOOLEAN Diff_corp_forgn_state_desc;
    BOOLEAN Diff_corp_country_of_formation;
    BOOLEAN Diff_corp_for_profit_ind;
    BOOLEAN Diff_corp_status_desc;
    BOOLEAN Diff_corp_ln_name_type_cd;
    BOOLEAN Diff_recordorigin;
    BOOLEAN Diff_corp_orig_org_structure_desc;
    BOOLEAN Diff_corp_filing_desc;
    BOOLEAN Diff_cont_type_desc;
    BOOLEAN Diff_cont_title1_desc;
    BOOLEAN Diff_cont_title2_desc;
    BOOLEAN Diff_cont_title3_desc;
    BOOLEAN Diff_cont_title4_desc;
    BOOLEAN Diff_cont_title5_desc;
    UNSIGNED Num_Diffs;
    SALT34.StrType Val {MAXLENGTH(1024)};
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
    SELF.Diff_corp_filing_date := le.corp_filing_date <> ri.corp_filing_date;
    SELF.Diff_corp_delayed_effective_date := le.corp_delayed_effective_date <> ri.corp_delayed_effective_date;
    SELF.Diff_corp_forgn_date := le.corp_forgn_date <> ri.corp_forgn_date;
    SELF.Diff_corp_dissolved_date := le.corp_dissolved_date <> ri.corp_dissolved_date;
    SELF.Diff_corp_inc_date := le.corp_inc_date <> ri.corp_inc_date;
    SELF.Diff_corp_key := le.corp_key <> ri.corp_key;
    SELF.Diff_corp_vendor := le.corp_vendor <> ri.corp_vendor;
    SELF.Diff_corp_state_origin := le.corp_state_origin <> ri.corp_state_origin;
    SELF.Diff_corp_orig_sos_charter_nbr := le.corp_orig_sos_charter_nbr <> ri.corp_orig_sos_charter_nbr;
    SELF.Diff_corp_legal_name := le.corp_legal_name <> ri.corp_legal_name;
    SELF.Diff_corp_inc_state := le.corp_inc_state <> ri.corp_inc_state;
    SELF.Diff_corp_foreign_domestic_ind := le.corp_foreign_domestic_ind <> ri.corp_foreign_domestic_ind;
    SELF.Diff_corp_forgn_state_desc := le.corp_forgn_state_desc <> ri.corp_forgn_state_desc;
    SELF.Diff_corp_country_of_formation := le.corp_country_of_formation <> ri.corp_country_of_formation;
    SELF.Diff_corp_for_profit_ind := le.corp_for_profit_ind <> ri.corp_for_profit_ind;
    SELF.Diff_corp_status_desc := le.corp_status_desc <> ri.corp_status_desc;
    SELF.Diff_corp_ln_name_type_cd := le.corp_ln_name_type_cd <> ri.corp_ln_name_type_cd;
    SELF.Diff_recordorigin := le.recordorigin <> ri.recordorigin;
    SELF.Diff_corp_orig_org_structure_desc := le.corp_orig_org_structure_desc <> ri.corp_orig_org_structure_desc;
    SELF.Diff_corp_filing_desc := le.corp_filing_desc <> ri.corp_filing_desc;
    SELF.Diff_cont_type_desc := le.cont_type_desc <> ri.cont_type_desc;
    SELF.Diff_cont_title1_desc := le.cont_title1_desc <> ri.cont_title1_desc;
    SELF.Diff_cont_title2_desc := le.cont_title2_desc <> ri.cont_title2_desc;
    SELF.Diff_cont_title3_desc := le.cont_title3_desc <> ri.cont_title3_desc;
    SELF.Diff_cont_title4_desc := le.cont_title4_desc <> ri.cont_title4_desc;
    SELF.Diff_cont_title5_desc := le.cont_title5_desc <> ri.cont_title5_desc;
    SELF.Val := (SALT34.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_first_seen,1,0)+ IF( SELF.Diff_corp_ra_dt_last_seen,1,0)+ IF( SELF.Diff_corp_process_date,1,0)+ IF( SELF.Diff_corp_filing_date,1,0)+ IF( SELF.Diff_corp_delayed_effective_date,1,0)+ IF( SELF.Diff_corp_forgn_date,1,0)+ IF( SELF.Diff_corp_dissolved_date,1,0)+ IF( SELF.Diff_corp_inc_date,1,0)+ IF( SELF.Diff_corp_key,1,0)+ IF( SELF.Diff_corp_vendor,1,0)+ IF( SELF.Diff_corp_state_origin,1,0)+ IF( SELF.Diff_corp_orig_sos_charter_nbr,1,0)+ IF( SELF.Diff_corp_legal_name,1,0)+ IF( SELF.Diff_corp_inc_state,1,0)+ IF( SELF.Diff_corp_foreign_domestic_ind,1,0)+ IF( SELF.Diff_corp_forgn_state_desc,1,0)+ IF( SELF.Diff_corp_country_of_formation,1,0)+ IF( SELF.Diff_corp_for_profit_ind,1,0)+ IF( SELF.Diff_corp_status_desc,1,0)+ IF( SELF.Diff_corp_ln_name_type_cd,1,0)+ IF( SELF.Diff_recordorigin,1,0)+ IF( SELF.Diff_corp_orig_org_structure_desc,1,0)+ IF( SELF.Diff_corp_filing_desc,1,0)+ IF( SELF.Diff_cont_type_desc,1,0)+ IF( SELF.Diff_cont_title1_desc,1,0)+ IF( SELF.Diff_cont_title2_desc,1,0)+ IF( SELF.Diff_cont_title3_desc,1,0)+ IF( SELF.Diff_cont_title4_desc,1,0)+ IF( SELF.Diff_cont_title5_desc,1,0);
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
    Count_Diff_corp_filing_date := COUNT(GROUP,%Closest%.Diff_corp_filing_date);
    Count_Diff_corp_delayed_effective_date := COUNT(GROUP,%Closest%.Diff_corp_delayed_effective_date);
    Count_Diff_corp_forgn_date := COUNT(GROUP,%Closest%.Diff_corp_forgn_date);
    Count_Diff_corp_dissolved_date := COUNT(GROUP,%Closest%.Diff_corp_dissolved_date);
    Count_Diff_corp_inc_date := COUNT(GROUP,%Closest%.Diff_corp_inc_date);
    Count_Diff_corp_key := COUNT(GROUP,%Closest%.Diff_corp_key);
    Count_Diff_corp_vendor := COUNT(GROUP,%Closest%.Diff_corp_vendor);
    Count_Diff_corp_state_origin := COUNT(GROUP,%Closest%.Diff_corp_state_origin);
    Count_Diff_corp_orig_sos_charter_nbr := COUNT(GROUP,%Closest%.Diff_corp_orig_sos_charter_nbr);
    Count_Diff_corp_legal_name := COUNT(GROUP,%Closest%.Diff_corp_legal_name);
    Count_Diff_corp_inc_state := COUNT(GROUP,%Closest%.Diff_corp_inc_state);
    Count_Diff_corp_foreign_domestic_ind := COUNT(GROUP,%Closest%.Diff_corp_foreign_domestic_ind);
    Count_Diff_corp_forgn_state_desc := COUNT(GROUP,%Closest%.Diff_corp_forgn_state_desc);
    Count_Diff_corp_country_of_formation := COUNT(GROUP,%Closest%.Diff_corp_country_of_formation);
    Count_Diff_corp_for_profit_ind := COUNT(GROUP,%Closest%.Diff_corp_for_profit_ind);
    Count_Diff_corp_status_desc := COUNT(GROUP,%Closest%.Diff_corp_status_desc);
    Count_Diff_corp_ln_name_type_cd := COUNT(GROUP,%Closest%.Diff_corp_ln_name_type_cd);
    Count_Diff_recordorigin := COUNT(GROUP,%Closest%.Diff_recordorigin);
    Count_Diff_corp_orig_org_structure_desc := COUNT(GROUP,%Closest%.Diff_corp_orig_org_structure_desc);
    Count_Diff_corp_filing_desc := COUNT(GROUP,%Closest%.Diff_corp_filing_desc);
    Count_Diff_cont_type_desc := COUNT(GROUP,%Closest%.Diff_cont_type_desc);
    Count_Diff_cont_title1_desc := COUNT(GROUP,%Closest%.Diff_cont_title1_desc);
    Count_Diff_cont_title2_desc := COUNT(GROUP,%Closest%.Diff_cont_title2_desc);
    Count_Diff_cont_title3_desc := COUNT(GROUP,%Closest%.Diff_cont_title3_desc);
    Count_Diff_cont_title4_desc := COUNT(GROUP,%Closest%.Diff_cont_title4_desc);
    Count_Diff_cont_title5_desc := COUNT(GROUP,%Closest%.Diff_cont_title5_desc);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
