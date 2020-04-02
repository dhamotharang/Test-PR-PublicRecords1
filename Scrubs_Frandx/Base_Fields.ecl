IMPORT SALT311;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 37;
 
// Processing for each FieldType
EXPORT SALT311.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_ace_aid','invalid_alpha','invalid_chk_digit','invalid_company_name','invalid_date','invalid_err_stat','invalid_fips_county','invalid_fips_state','invalid_franchisee_id','invalid_fruns','invalid_industry_type','invalid_nonempty_number','invalid_numeric','invalid_phone','invalid_record_type','invalid_relationship_code','invalid_relationship_code_exp','invalid_secondary_phone','invalid_sic_code','invalid_state','invalid_unit_flag','invalid_unit_flag_exp','invalid_zip_code','invalid_zip_code4');
EXPORT FieldTypeNum(SALT311.StrType fn) := CASE(fn,'invalid_ace_aid' => 1,'invalid_alpha' => 2,'invalid_chk_digit' => 3,'invalid_company_name' => 4,'invalid_date' => 5,'invalid_err_stat' => 6,'invalid_fips_county' => 7,'invalid_fips_state' => 8,'invalid_franchisee_id' => 9,'invalid_fruns' => 10,'invalid_industry_type' => 11,'invalid_nonempty_number' => 12,'invalid_numeric' => 13,'invalid_phone' => 14,'invalid_record_type' => 15,'invalid_relationship_code' => 16,'invalid_relationship_code_exp' => 17,'invalid_secondary_phone' => 18,'invalid_sic_code' => 19,'invalid_state' => 20,'invalid_unit_flag' => 21,'invalid_unit_flag_exp' => 22,'invalid_zip_code' => 23,'invalid_zip_code4' => 24,0);
 
EXPORT MakeFT_invalid_ace_aid(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ace_aid(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_ace_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alpha(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_alpha(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_invalid_alpha(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_company_name(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_company_name(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_ASCII_printable(s)>0);
EXPORT InValidMessageFT_invalid_company_name(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_ASCII_printable'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_date(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_date(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_date(s)>0);
EXPORT InValidMessageFT_invalid_date(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_date'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_err_stat(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'))));
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_franchisee_id(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_franchisee_id(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s,6)>0);
EXPORT InValidMessageFT_invalid_franchisee_id(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fruns(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fruns(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_fruns(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_industry_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_industry_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['NON-FOOD','FOOD']);
EXPORT InValidMessageFT_invalid_industry_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('NON-FOOD|FOOD'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nonempty_number(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_nonempty_number(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_nonempty_number(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT311.StrType s0) := FUNCTION
  s1 := SALT311.stringfilter(s0,'0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numeric(SALT311.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT311.StringFilter(s,'0123456789'))));
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInChars('0123456789'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_record_type(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_record_type(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['H','']);
EXPORT InValidMessageFT_invalid_record_type(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('H|'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_relationship_code(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['ST','AD','AR']);
EXPORT InValidMessageFT_invalid_relationship_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('ST|AD|AR'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_relationship_code_exp(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_relationship_code_exp(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['STANDALONE','AREA DEVELOPER','AREA REPRESENTATIVE']);
EXPORT InValidMessageFT_invalid_relationship_code_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('STANDALONE|AREA DEVELOPER|AREA REPRESENTATIVE'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_secondary_phone(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_secondary_phone(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_optional_phone(s)>0);
EXPORT InValidMessageFT_invalid_secondary_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_optional_phone'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic_code(SALT311.StrType s) := WHICH(~Scrubs.functions.fn_valid_SicCode(s)>0);
EXPORT InValidMessageFT_invalid_sic_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.functions.fn_valid_SicCode'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_verify_state'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unit_flag(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unit_flag(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['U','H','UN','HQ']);
EXPORT InValidMessageFT_invalid_unit_flag(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('U|H|UN|HQ'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_unit_flag_exp(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_unit_flag_exp(SALT311.StrType s) := WHICH(((SALT311.StrType) s) NOT IN ['SERVICE LOCATION','HEADQUARTER']);
EXPORT InValidMessageFT_invalid_unit_flag_exp(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.NotInEnum('SERVICE LOCATION|HEADQUARTER'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip_code(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric(s,5)>0);
EXPORT InValidMessageFT_invalid_zip_code(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric'),SALT311.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip_code4(SALT311.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip_code4(SALT311.StrType s) := WHICH(~Scrubs.Functions.fn_numeric_optional(s,4)>0);
EXPORT InValidMessageFT_invalid_zip_code4(UNSIGNED1 wh) := CHOOSE(wh,SALT311.HygieneErrors.CustomFail('Scrubs.Functions.fn_numeric_optional'),SALT311.HygieneErrors.Good);
 
EXPORT SALT311.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'ace_aid','address1','brand_name','chk_digit','city','clean_phone','clean_secondary_phone','company_name','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','err_stat','fips_county','fips_state','franchisee_id','fruns','f_units','industry','industry_type','p_city_name','phone','phone_extension','prim_name','record_id','record_type','relationship_code','relationship_code_exp','secondary_phone','sector','sic_code','state','unit_flag','unit_flag_exp','v_city_name','zip_code','zip_code4');
EXPORT SALT311.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'ace_aid','address1','brand_name','chk_digit','city','clean_phone','clean_secondary_phone','company_name','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','err_stat','fips_county','fips_state','franchisee_id','fruns','f_units','industry','industry_type','p_city_name','phone','phone_extension','prim_name','record_id','record_type','relationship_code','relationship_code_exp','secondary_phone','sector','sic_code','state','unit_flag','unit_flag_exp','v_city_name','zip_code','zip_code4');
EXPORT FieldNum(SALT311.StrType fn) := CASE(fn,'ace_aid' => 0,'address1' => 1,'brand_name' => 2,'chk_digit' => 3,'city' => 4,'clean_phone' => 5,'clean_secondary_phone' => 6,'company_name' => 7,'dt_first_seen' => 8,'dt_last_seen' => 9,'dt_vendor_first_reported' => 10,'dt_vendor_last_reported' => 11,'err_stat' => 12,'fips_county' => 13,'fips_state' => 14,'franchisee_id' => 15,'fruns' => 16,'f_units' => 17,'industry' => 18,'industry_type' => 19,'p_city_name' => 20,'phone' => 21,'phone_extension' => 22,'prim_name' => 23,'record_id' => 24,'record_type' => 25,'relationship_code' => 26,'relationship_code_exp' => 27,'secondary_phone' => 28,'sector' => 29,'sic_code' => 30,'state' => 31,'unit_flag' => 32,'unit_flag_exp' => 33,'v_city_name' => 34,'zip_code' => 35,'zip_code4' => 36,0);
EXPORT SET OF SALT311.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_ace_aid(SALT311.StrType s0) := MakeFT_invalid_ace_aid(s0);
EXPORT InValid_ace_aid(SALT311.StrType s) := InValidFT_invalid_ace_aid(s);
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := InValidMessageFT_invalid_ace_aid(wh);
 
EXPORT Make_address1(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_address1(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_address1(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_brand_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_brand_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_brand_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_chk_digit(SALT311.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_chk_digit(SALT311.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_city(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_city(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_clean_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_clean_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_clean_secondary_phone(SALT311.StrType s0) := MakeFT_invalid_secondary_phone(s0);
EXPORT InValid_clean_secondary_phone(SALT311.StrType s) := InValidFT_invalid_secondary_phone(s);
EXPORT InValidMessage_clean_secondary_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_secondary_phone(wh);
 
EXPORT Make_company_name(SALT311.StrType s0) := MakeFT_invalid_company_name(s0);
EXPORT InValid_company_name(SALT311.StrType s) := InValidFT_invalid_company_name(s);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_company_name(wh);
 
EXPORT Make_dt_first_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_first_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_last_seen(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_last_seen(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_first_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT311.StrType s0) := MakeFT_invalid_date(s0);
EXPORT InValid_dt_vendor_last_reported(SALT311.StrType s) := InValidFT_invalid_date(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_date(wh);
 
EXPORT Make_err_stat(SALT311.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_err_stat(SALT311.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
EXPORT Make_fips_county(SALT311.StrType s0) := MakeFT_invalid_fips_county(s0);
EXPORT InValid_fips_county(SALT311.StrType s) := InValidFT_invalid_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_county(wh);
 
EXPORT Make_fips_state(SALT311.StrType s0) := MakeFT_invalid_fips_state(s0);
EXPORT InValid_fips_state(SALT311.StrType s) := InValidFT_invalid_fips_state(s);
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_state(wh);
 
EXPORT Make_franchisee_id(SALT311.StrType s0) := MakeFT_invalid_franchisee_id(s0);
EXPORT InValid_franchisee_id(SALT311.StrType s) := InValidFT_invalid_franchisee_id(s);
EXPORT InValidMessage_franchisee_id(UNSIGNED1 wh) := InValidMessageFT_invalid_franchisee_id(wh);
 
EXPORT Make_fruns(SALT311.StrType s0) := MakeFT_invalid_fruns(s0);
EXPORT InValid_fruns(SALT311.StrType s) := InValidFT_invalid_fruns(s);
EXPORT InValidMessage_fruns(UNSIGNED1 wh) := InValidMessageFT_invalid_fruns(wh);
 
EXPORT Make_f_units(SALT311.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_f_units(SALT311.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_f_units(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_industry(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_industry(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_industry(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_industry_type(SALT311.StrType s0) := MakeFT_invalid_industry_type(s0);
EXPORT InValid_industry_type(SALT311.StrType s) := InValidFT_invalid_industry_type(s);
EXPORT InValidMessage_industry_type(UNSIGNED1 wh) := InValidMessageFT_invalid_industry_type(wh);
 
EXPORT Make_p_city_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_p_city_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_phone(SALT311.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone(SALT311.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_phone_extension(SALT311.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_phone_extension(SALT311.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_phone_extension(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_prim_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_prim_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_record_id(SALT311.StrType s0) := MakeFT_invalid_nonempty_number(s0);
EXPORT InValid_record_id(SALT311.StrType s) := InValidFT_invalid_nonempty_number(s);
EXPORT InValidMessage_record_id(UNSIGNED1 wh) := InValidMessageFT_invalid_nonempty_number(wh);
 
EXPORT Make_record_type(SALT311.StrType s0) := MakeFT_invalid_record_type(s0);
EXPORT InValid_record_type(SALT311.StrType s) := InValidFT_invalid_record_type(s);
EXPORT InValidMessage_record_type(UNSIGNED1 wh) := InValidMessageFT_invalid_record_type(wh);
 
EXPORT Make_relationship_code(SALT311.StrType s0) := MakeFT_invalid_relationship_code(s0);
EXPORT InValid_relationship_code(SALT311.StrType s) := InValidFT_invalid_relationship_code(s);
EXPORT InValidMessage_relationship_code(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_code(wh);
 
EXPORT Make_relationship_code_exp(SALT311.StrType s0) := MakeFT_invalid_relationship_code_exp(s0);
EXPORT InValid_relationship_code_exp(SALT311.StrType s) := InValidFT_invalid_relationship_code_exp(s);
EXPORT InValidMessage_relationship_code_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_relationship_code_exp(wh);
 
EXPORT Make_secondary_phone(SALT311.StrType s0) := MakeFT_invalid_secondary_phone(s0);
EXPORT InValid_secondary_phone(SALT311.StrType s) := InValidFT_invalid_secondary_phone(s);
EXPORT InValidMessage_secondary_phone(UNSIGNED1 wh) := InValidMessageFT_invalid_secondary_phone(wh);
 
EXPORT Make_sector(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_sector(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_sector(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_sic_code(SALT311.StrType s0) := MakeFT_invalid_sic_code(s0);
EXPORT InValid_sic_code(SALT311.StrType s) := InValidFT_invalid_sic_code(s);
EXPORT InValidMessage_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_code(wh);
 
EXPORT Make_state(SALT311.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT311.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_unit_flag(SALT311.StrType s0) := MakeFT_invalid_unit_flag(s0);
EXPORT InValid_unit_flag(SALT311.StrType s) := InValidFT_invalid_unit_flag(s);
EXPORT InValidMessage_unit_flag(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_flag(wh);
 
EXPORT Make_unit_flag_exp(SALT311.StrType s0) := MakeFT_invalid_unit_flag_exp(s0);
EXPORT InValid_unit_flag_exp(SALT311.StrType s) := InValidFT_invalid_unit_flag_exp(s);
EXPORT InValidMessage_unit_flag_exp(UNSIGNED1 wh) := InValidMessageFT_invalid_unit_flag_exp(wh);
 
EXPORT Make_v_city_name(SALT311.StrType s0) := MakeFT_invalid_alpha(s0);
EXPORT InValid_v_city_name(SALT311.StrType s) := InValidFT_invalid_alpha(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alpha(wh);
 
EXPORT Make_zip_code(SALT311.StrType s0) := MakeFT_invalid_zip_code(s0);
EXPORT InValid_zip_code(SALT311.StrType s) := InValidFT_invalid_zip_code(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code(wh);
 
EXPORT Make_zip_code4(SALT311.StrType s0) := MakeFT_invalid_zip_code4(s0);
EXPORT InValid_zip_code4(SALT311.StrType s) := InValidFT_invalid_zip_code4(s);
EXPORT InValidMessage_zip_code4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip_code4(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT311,Scrubs_Frandx;
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
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_address1;
    BOOLEAN Diff_brand_name;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_city;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_clean_secondary_phone;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_franchisee_id;
    BOOLEAN Diff_fruns;
    BOOLEAN Diff_f_units;
    BOOLEAN Diff_industry;
    BOOLEAN Diff_industry_type;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_phone;
    BOOLEAN Diff_phone_extension;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_record_id;
    BOOLEAN Diff_record_type;
    BOOLEAN Diff_relationship_code;
    BOOLEAN Diff_relationship_code_exp;
    BOOLEAN Diff_secondary_phone;
    BOOLEAN Diff_sector;
    BOOLEAN Diff_sic_code;
    BOOLEAN Diff_state;
    BOOLEAN Diff_unit_flag;
    BOOLEAN Diff_unit_flag_exp;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_zip_code4;
    UNSIGNED Num_Diffs;
    SALT311.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_address1 := le.address1 <> ri.address1;
    SELF.Diff_brand_name := le.brand_name <> ri.brand_name;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_clean_secondary_phone := le.clean_secondary_phone <> ri.clean_secondary_phone;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_franchisee_id := le.franchisee_id <> ri.franchisee_id;
    SELF.Diff_fruns := le.fruns <> ri.fruns;
    SELF.Diff_f_units := le.f_units <> ri.f_units;
    SELF.Diff_industry := le.industry <> ri.industry;
    SELF.Diff_industry_type := le.industry_type <> ri.industry_type;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_phone := le.phone <> ri.phone;
    SELF.Diff_phone_extension := le.phone_extension <> ri.phone_extension;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_record_id := le.record_id <> ri.record_id;
    SELF.Diff_record_type := le.record_type <> ri.record_type;
    SELF.Diff_relationship_code := le.relationship_code <> ri.relationship_code;
    SELF.Diff_relationship_code_exp := le.relationship_code_exp <> ri.relationship_code_exp;
    SELF.Diff_secondary_phone := le.secondary_phone <> ri.secondary_phone;
    SELF.Diff_sector := le.sector <> ri.sector;
    SELF.Diff_sic_code := le.sic_code <> ri.sic_code;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_unit_flag := le.unit_flag <> ri.unit_flag;
    SELF.Diff_unit_flag_exp := le.unit_flag_exp <> ri.unit_flag_exp;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_zip_code4 := le.zip_code4 <> ri.zip_code4;
    SELF.Val := (SALT311.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_address1,1,0)+ IF( SELF.Diff_brand_name,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_clean_secondary_phone,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_franchisee_id,1,0)+ IF( SELF.Diff_fruns,1,0)+ IF( SELF.Diff_f_units,1,0)+ IF( SELF.Diff_industry,1,0)+ IF( SELF.Diff_industry_type,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_phone,1,0)+ IF( SELF.Diff_phone_extension,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_record_id,1,0)+ IF( SELF.Diff_record_type,1,0)+ IF( SELF.Diff_relationship_code,1,0)+ IF( SELF.Diff_relationship_code_exp,1,0)+ IF( SELF.Diff_secondary_phone,1,0)+ IF( SELF.Diff_sector,1,0)+ IF( SELF.Diff_sic_code,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_unit_flag,1,0)+ IF( SELF.Diff_unit_flag_exp,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_zip_code4,1,0);
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
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_address1 := COUNT(GROUP,%Closest%.Diff_address1);
    Count_Diff_brand_name := COUNT(GROUP,%Closest%.Diff_brand_name);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_clean_secondary_phone := COUNT(GROUP,%Closest%.Diff_clean_secondary_phone);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_franchisee_id := COUNT(GROUP,%Closest%.Diff_franchisee_id);
    Count_Diff_fruns := COUNT(GROUP,%Closest%.Diff_fruns);
    Count_Diff_f_units := COUNT(GROUP,%Closest%.Diff_f_units);
    Count_Diff_industry := COUNT(GROUP,%Closest%.Diff_industry);
    Count_Diff_industry_type := COUNT(GROUP,%Closest%.Diff_industry_type);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_phone := COUNT(GROUP,%Closest%.Diff_phone);
    Count_Diff_phone_extension := COUNT(GROUP,%Closest%.Diff_phone_extension);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_record_id := COUNT(GROUP,%Closest%.Diff_record_id);
    Count_Diff_record_type := COUNT(GROUP,%Closest%.Diff_record_type);
    Count_Diff_relationship_code := COUNT(GROUP,%Closest%.Diff_relationship_code);
    Count_Diff_relationship_code_exp := COUNT(GROUP,%Closest%.Diff_relationship_code_exp);
    Count_Diff_secondary_phone := COUNT(GROUP,%Closest%.Diff_secondary_phone);
    Count_Diff_sector := COUNT(GROUP,%Closest%.Diff_sector);
    Count_Diff_sic_code := COUNT(GROUP,%Closest%.Diff_sic_code);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_unit_flag := COUNT(GROUP,%Closest%.Diff_unit_flag);
    Count_Diff_unit_flag_exp := COUNT(GROUP,%Closest%.Diff_unit_flag_exp);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_zip_code4 := COUNT(GROUP,%Closest%.Diff_zip_code4);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
