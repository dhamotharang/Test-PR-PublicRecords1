IMPORT SALT38;
IMPORT Scrubs_Experian_CRDB; // Import modules for FieldTypes attribute definitions
EXPORT Base_Fields := MODULE
 
EXPORT NumFields := 233;
 
// Processing for each FieldType
EXPORT SALT38.StrType FieldTypeName(UNSIGNED2 i) := CHOOSE(i,'invalid_mandatory','invalid_alphaHyphen','invalid_numericPeriod','invalid_zero_blank','invalid_model_action','invalid_numeric','invalid_experian_bus_id','invalid_percentage','invalid_sic_codes','invalid_naics_codes','invalid_pastdate','invalid_boolean','invalid_sign','invalid_state','invalid_zip','invalid_zip4','invalid_phone','invalid_first_name','invalid_mid_name','invalid_last_name','invalid_business_name','invalid_carrier_route','invalid_Experian_Credit_Rating','invalid_geo_code_latitude_direction','invalid_geo_code_longitude_direction','invalid_recent_update_code','invalid_years_in_business_code','invalid_address_type_code','invalid_employee_size_code','invalid_annual_Sales_Size_Code','invalid_location_code','invalid_primary_sic_code_industry_classification','invalid_executive_count','invalid_business_type','invalid_ownership_code','invalid_derogatory_indicator','invalid_ucc_data_indicator','invalid_model_type','invalid_aged_trade_lines','invalid_last_activity_age_code','invalid_nonprofit_indicator','invalid_fsr_risk_class','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_msa','invalid_geo_match','invalid_err_stat','invalid_raw_aid','invalid_ace_aid','invalid_direction','invalid_year','invalid_clean_dba_name','invalid_bName_pName','invalid_bName_fName','invalid_bName_mName','invalid_bName_lName');
EXPORT FieldTypeNum(SALT38.StrType fn) := CASE(fn,'invalid_mandatory' => 1,'invalid_alphaHyphen' => 2,'invalid_numericPeriod' => 3,'invalid_zero_blank' => 4,'invalid_model_action' => 5,'invalid_numeric' => 6,'invalid_experian_bus_id' => 7,'invalid_percentage' => 8,'invalid_sic_codes' => 9,'invalid_naics_codes' => 10,'invalid_pastdate' => 11,'invalid_boolean' => 12,'invalid_sign' => 13,'invalid_state' => 14,'invalid_zip' => 15,'invalid_zip4' => 16,'invalid_phone' => 17,'invalid_first_name' => 18,'invalid_mid_name' => 19,'invalid_last_name' => 20,'invalid_business_name' => 21,'invalid_carrier_route' => 22,'invalid_Experian_Credit_Rating' => 23,'invalid_geo_code_latitude_direction' => 24,'invalid_geo_code_longitude_direction' => 25,'invalid_recent_update_code' => 26,'invalid_years_in_business_code' => 27,'invalid_address_type_code' => 28,'invalid_employee_size_code' => 29,'invalid_annual_Sales_Size_Code' => 30,'invalid_location_code' => 31,'invalid_primary_sic_code_industry_classification' => 32,'invalid_executive_count' => 33,'invalid_business_type' => 34,'invalid_ownership_code' => 35,'invalid_derogatory_indicator' => 36,'invalid_ucc_data_indicator' => 37,'invalid_model_type' => 38,'invalid_aged_trade_lines' => 39,'invalid_last_activity_age_code' => 40,'invalid_nonprofit_indicator' => 41,'invalid_fsr_risk_class' => 42,'invalid_cart' => 43,'invalid_cr_sort_sz' => 44,'invalid_lot' => 45,'invalid_lot_order' => 46,'invalid_dpbc' => 47,'invalid_chk_digit' => 48,'invalid_fips_state' => 49,'invalid_fips_county' => 50,'invalid_geo' => 51,'invalid_msa' => 52,'invalid_geo_match' => 53,'invalid_err_stat' => 54,'invalid_raw_aid' => 55,'invalid_ace_aid' => 56,'invalid_direction' => 57,'invalid_year' => 58,'invalid_clean_dba_name' => 59,'invalid_bName_pName' => 60,'invalid_bName_fName' => 61,'invalid_bName_mName' => 62,'invalid_bName_lName' => 63,0);
 
EXPORT MakeFT_invalid_mandatory(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mandatory(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.functions.fn_chk_blanks(s)>0);
EXPORT InValidMessageFT_invalid_mandatory(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_chk_blanks'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_alphaHyphen(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_alphaHyphen(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'))));
EXPORT InValidMessageFT_invalid_alphaHyphen(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars(' -ABCDEFGHIJKLMNOPQRSTUVWXYZ'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numericPeriod(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'.0123456789'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_numericPeriod(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'.0123456789'))));
EXPORT InValidMessageFT_invalid_numericPeriod(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('.0123456789'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zero_blank(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zero_blank(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['0','']);
EXPORT InValidMessageFT_invalid_zero_blank(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('0|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_model_action(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_model_action(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['MEDIUM RISK','LOW-MEDIUM RISK','LOW RISK','MEDIUM-HIGH RISK','HIGH RISK','INSUFFICIENT DATA TO SCORE','RECENT BANKRUPTCY ON FILE']);
EXPORT InValidMessageFT_invalid_model_action(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('MEDIUM RISK|LOW-MEDIUM RISK|LOW RISK|MEDIUM-HIGH RISK|HIGH RISK|INSUFFICIENT DATA TO SCORE|RECENT BANKRUPTCY ON FILE'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_numeric(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_numeric(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_numeric(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_experian_bus_id(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_experian_bus_id(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s,9)>0);
EXPORT InValidMessageFT_invalid_experian_bus_id(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_percentage(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_percentage(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_range_numeric(s,0,100)>0);
EXPORT InValidMessageFT_invalid_percentage(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_range_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sic_codes(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sic_codes(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_sic_code(s)>0);
EXPORT InValidMessageFT_invalid_sic_codes(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_sic_code'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_naics_codes(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_naics_codes(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_naics_code(s)>0);
EXPORT InValidMessageFT_invalid_naics_codes(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_naics_code'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_pastdate(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_pastdate(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_past_yyyymmdd(s)>0);
EXPORT InValidMessageFT_invalid_pastdate(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_past_yyyymmdd'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_boolean(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_boolean(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['Y','N','']);
EXPORT InValidMessageFT_invalid_boolean(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('Y|N|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_sign(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_sign(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['+','-','I','B','']);
EXPORT InValidMessageFT_invalid_sign(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('+|-|I|B|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_state(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_verify_state(s)>0);
EXPORT InValidMessageFT_invalid_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_verify_state'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.functions.fn_verify_zip5(s)>0);
EXPORT InValidMessageFT_invalid_zip(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_verify_zip5'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_zip4(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_zip4(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.functions.fn_verify_zip4(s)>0);
EXPORT InValidMessageFT_invalid_zip4(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_verify_zip4'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_phone(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_phone(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.functions.fn_CleanPhone(s)>0);
EXPORT InValidMessageFT_invalid_phone(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_CleanPhone'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_first_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_first_name(SALT38.StrType s,SALT38.StrType p_mname,SALT38.StrType p_lname) := WHICH(~Scrubs_Experian_CRDB.functions.fn_chk_people_names(s,p_mname,p_lname)>0);
EXPORT InValidMessageFT_invalid_first_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_mid_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_mid_name(SALT38.StrType s,SALT38.StrType p_fname,SALT38.StrType p_lname) := WHICH(~Scrubs_Experian_CRDB.functions.fn_chk_people_names(s,p_fname,p_lname)>0);
EXPORT InValidMessageFT_invalid_mid_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_last_name(SALT38.StrType s,SALT38.StrType p_fname,SALT38.StrType p_mname) := WHICH(~Scrubs_Experian_CRDB.functions.fn_chk_people_names(s,p_fname,p_mname)>0);
EXPORT InValidMessageFT_invalid_last_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_chk_people_names'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_business_name(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.functions.fn_chk_blanks(s)>0);
EXPORT InValidMessageFT_invalid_business_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_chk_blanks'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_carrier_route(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0123456789BCGHR'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_carrier_route(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0123456789BCGHR'))));
EXPORT InValidMessageFT_invalid_carrier_route(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0123456789BCGHR'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_Experian_Credit_Rating(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'01234567'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_Experian_Credit_Rating(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'01234567'))));
EXPORT InValidMessageFT_invalid_Experian_Credit_Rating(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('01234567'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_code_latitude_direction(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'NS'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo_code_latitude_direction(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'NS'))));
EXPORT InValidMessageFT_invalid_geo_code_latitude_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('NS'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_code_longitude_direction(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'WE'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_geo_code_longitude_direction(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'WE'))));
EXPORT InValidMessageFT_invalid_geo_code_longitude_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('WE'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_recent_update_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_recent_update_code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','B','C','']);
EXPORT InValidMessageFT_invalid_recent_update_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|B|C|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_years_in_business_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEF'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_years_in_business_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEF'))));
EXPORT InValidMessageFT_invalid_years_in_business_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEF'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_address_type_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'FGHMPRS'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_address_type_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'FGHMPRS'))));
EXPORT InValidMessageFT_invalid_address_type_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('FGHMPRS'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_employee_size_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHI'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_employee_size_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHI'))));
EXPORT InValidMessageFT_invalid_employee_size_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHI'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_annual_Sales_Size_Code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_annual_Sales_Size_Code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','J','K','']);
EXPORT InValidMessageFT_invalid_annual_Sales_Size_Code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|J|K|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_location_code(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_location_code(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['B','H','S','']);
EXPORT InValidMessageFT_invalid_location_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('B|H|S|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_primary_sic_code_industry_classification(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_primary_sic_code_industry_classification(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','B','C','D','E','F','G','H','I','J','K','']);
EXPORT InValidMessageFT_invalid_primary_sic_code_industry_classification(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|B|C|D|E|F|G|H|I|J|K|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_executive_count(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'01'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_executive_count(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'01'))));
EXPORT InValidMessageFT_invalid_executive_count(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('01'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_business_type(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'CGPS'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_business_type(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'CGPS'))));
EXPORT InValidMessageFT_invalid_business_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('CGPS'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ownership_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'01'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ownership_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'01'))));
EXPORT InValidMessageFT_invalid_ownership_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('01'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_derogatory_indicator(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'CNY'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_derogatory_indicator(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'CNY'))));
EXPORT InValidMessageFT_invalid_derogatory_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('CNY'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ucc_data_indicator(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'DNY'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_ucc_data_indicator(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'DNY'))));
EXPORT InValidMessageFT_invalid_ucc_data_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('DNY'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_model_type(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'1'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_model_type(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'1'))));
EXPORT InValidMessageFT_invalid_model_type(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('1'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_aged_trade_lines(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'0'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_aged_trade_lines(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'0'))));
EXPORT InValidMessageFT_invalid_aged_trade_lines(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('0'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_last_activity_age_code(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ABCDEFGHIJKLMNO'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_last_activity_age_code(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ABCDEFGHIJKLMNO'))));
EXPORT InValidMessageFT_invalid_last_activity_age_code(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ABCDEFGHIJKLMNO'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_nonprofit_indicator(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'NPU'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_nonprofit_indicator(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'NPU'))));
EXPORT InValidMessageFT_invalid_nonprofit_indicator(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('NPU'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fsr_risk_class(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'-12345'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_fsr_risk_class(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'-12345'))));
EXPORT InValidMessageFT_invalid_fsr_risk_class(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('-12345'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cart(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cart(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_alphanumeric(s,4)>0);
EXPORT InValidMessageFT_invalid_cart(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_cr_sort_sz(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_cr_sort_sz(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['B','C','D','']);
EXPORT InValidMessageFT_invalid_cr_sort_sz(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('B|C|D|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_lot(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_lot_order(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_lot_order(SALT38.StrType s) := WHICH(((SALT38.StrType) s) NOT IN ['A','D','']);
EXPORT InValidMessageFT_invalid_lot_order(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInEnum('A|D|'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_dpbc(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_dpbc(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_dpbc(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_chk_digit(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_chk_digit(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_chk_digit(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_state(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_state(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s,2)>0);
EXPORT InValidMessageFT_invalid_fips_state(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_fips_county(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_fips_county(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s,3)>0);
EXPORT InValidMessageFT_invalid_fips_county(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_geo_coord(s)>0);
EXPORT InValidMessageFT_invalid_geo(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_geo_coord'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_msa(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_msa(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s,4)>0);
EXPORT InValidMessageFT_invalid_msa(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_geo_match(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_geo_match(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s,1)>0);
EXPORT InValidMessageFT_invalid_geo_match(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_err_stat(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_err_stat(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_alphanumeric(s,4)>0);
EXPORT InValidMessageFT_invalid_err_stat(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_alphanumeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_raw_aid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_raw_aid(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_raw_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_ace_aid(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_ace_aid(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_numeric(s)>0);
EXPORT InValidMessageFT_invalid_ace_aid(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_numeric'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_direction(SALT38.StrType s0) := FUNCTION
  s1 := SALT38.stringfilter(s0,'ENSW'); // Only allow valid symbols
  RETURN  s1;
END;
EXPORT InValidFT_invalid_direction(SALT38.StrType s) := WHICH(LENGTH(TRIM(s))<>LENGTH(TRIM(SALT38.StringFilter(s,'ENSW'))));
EXPORT InValidMessageFT_invalid_direction(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.NotInChars('ENSW'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_year(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_year(SALT38.StrType s) := WHICH(~Scrubs_Experian_CRDB.Functions.fn_valid_year(s)>0);
EXPORT InValidMessageFT_invalid_year(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.Functions.fn_valid_year'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_clean_dba_name(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_clean_dba_name(SALT38.StrType s,SALT38.StrType dba_name) := WHICH(~Scrubs_Experian_CRDB.functions.fn_clean_dba_name(s,dba_name)>0);
EXPORT InValidMessageFT_invalid_clean_dba_name(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_clean_dba_name'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bName_pName(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bName_pName(SALT38.StrType s,SALT38.StrType p_fname,SALT38.StrType p_mname,SALT38.StrType p_lname) := WHICH(~Scrubs_Experian_CRDB.functions.fn_bName_pName(s,p_fname,p_mname,p_lname)>0);
EXPORT InValidMessageFT_invalid_bName_pName(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_bName_pName'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bName_fName(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bName_fName(SALT38.StrType s,SALT38.StrType company_name,SALT38.StrType p_mname,SALT38.StrType p_lname) := WHICH(~Scrubs_Experian_CRDB.functions.fn_bName_pName(s,company_name,p_mname,p_lname)>0);
EXPORT InValidMessageFT_invalid_bName_fName(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_bName_pName'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bName_mName(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bName_mName(SALT38.StrType s,SALT38.StrType company_name,SALT38.StrType p_fname,SALT38.StrType p_lname) := WHICH(~Scrubs_Experian_CRDB.functions.fn_bName_pName(s,company_name,p_fname,p_lname)>0);
EXPORT InValidMessageFT_invalid_bName_mName(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_bName_pName'),SALT38.HygieneErrors.Good);
 
EXPORT MakeFT_invalid_bName_lName(SALT38.StrType s0) := FUNCTION
  RETURN  s0;
END;
EXPORT InValidFT_invalid_bName_lName(SALT38.StrType s,SALT38.StrType company_name,SALT38.StrType p_fname,SALT38.StrType p_mname) := WHICH(~Scrubs_Experian_CRDB.functions.fn_bName_pName(s,company_name,p_fname,p_mname)>0);
EXPORT InValidMessageFT_invalid_bName_lName(UNSIGNED1 wh) := CHOOSE(wh,SALT38.HygieneErrors.CustomFail('Scrubs_Experian_CRDB.functions.fn_bName_pName'),SALT38.HygieneErrors.Good);
 
EXPORT SALT38.StrType FieldName(UNSIGNED2 i) := CHOOSE(i,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','experian_bus_id','business_name','address','city','state','zip_code','zip_plus_4','carrier_route','county_code','county_name','phone_number','msa_code','msa_description','establish_date','latest_reported_date','years_in_file','geo_code_latitude','geo_code_latitude_direction','geo_code_longitude','geo_code_longitude_direction','recent_update_code','years_in_business_code','year_business_started','months_in_file','address_type_code','estimated_number_of_employees','employee_size_code','estimated_annual_sales_amount_sign','estimated_annual_sales_amount','annual_sales_size_code','location_code','primary_sic_code_industry_classification','primary_sic_code_4_digit','primary_sic_code','second_sic_code','third_sic_code','fourth_sic_code','fifth_sic_code','sixth_sic_code','primary_naics_code','second_naics_code','third_naics_code','fourth_naics_code','executive_count','executive_last_name','executive_first_name','executive_middle_initial','executive_title','business_type','ownership_code','url','derogatory_indicator','recent_derogatory_filed_date','derogatory_liability_amount_sign','derogatory_liability_amount','ucc_data_indicator','ucc_count','number_of_legal_items','legal_balance_sign','legal_balance_amount','pmtkbankruptcy','pmtkjudgment','pmtktaxlien','pmtkpayment','bankruptcy_filed','number_of_derogatory_legal_items','lien_count','judgment_count','bkc006','bkc007','bkc008','bko009','bkb001_sign','bkb001','bkb003_sign','bkb003','bko010','bko011','jdc010','jdc011','jdc012','jdb004','jdb005','jdb006','jDO013','jDO014','jdb002','jdp016','lgc004','pro001','pro003','txc010','txc011','txb004_sign','txb004','txo013','txb002_sign','txb002','txp016','ucc001','ucc002','ucc003','intelliscore_plus','percentile_model','model_action','score_factor_1','score_factor_2','score_factor_3','score_factor_4','model_code','model_type','last_experian_inquiry_date','recent_high_credit_sign','recent_high_credit','median_credit_amount_sign','median_credit_amount','total_combined_trade_lines_count','dbt_of_combined_trade_totals','combined_trade_balance','aged_trade_lines','experian_credit_rating','quarter_1_average_dbt','quarter_2_average_dbt','quarter_3_average_dbt','quarter_4_average_dbt','quarter_5_average_dbt','combined_dbt','total_account_balance_sign','total_account_balance','combined_account_balance_sign','combined_account_balance','collection_count','atc021','atc022','atc023','atc024','atc025','last_activity_age_code','cottage_indicator','nonprofit_indicator','financial_stability_risk_score','fsr_risk_class','fsr_score_factor_1','fsr_score_factor_2','fsr_score_factor_3','fsr_score_factor_4','ip_score_change_sign','ip_score_change','fsr_score_change_sign','fsr_score_change','dba_name','clean_dba_name','clean_phone','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','recent_update_desc','years_in_business_desc','address_type_desc','employee_size_desc','annual_sales_size_desc','location_desc','primary_sic_code_industry_class_desc','business_type_desc','ownership_code_desc','ucc_data_indicator_desc','experian_credit_rating_desc','last_activity_age_desc','cottage_indicator_desc','nonprofit_indicator_desc','company_name','p_title','p_fname','p_mname','p_lname','p_name_suffix','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id');
EXPORT SALT38.StrType FlatName(UNSIGNED2 i) := CHOOSE(i,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','experian_bus_id','business_name','address','city','state','zip_code','zip_plus_4','carrier_route','county_code','county_name','phone_number','msa_code','msa_description','establish_date','latest_reported_date','years_in_file','geo_code_latitude','geo_code_latitude_direction','geo_code_longitude','geo_code_longitude_direction','recent_update_code','years_in_business_code','year_business_started','months_in_file','address_type_code','estimated_number_of_employees','employee_size_code','estimated_annual_sales_amount_sign','estimated_annual_sales_amount','annual_sales_size_code','location_code','primary_sic_code_industry_classification','primary_sic_code_4_digit','primary_sic_code','second_sic_code','third_sic_code','fourth_sic_code','fifth_sic_code','sixth_sic_code','primary_naics_code','second_naics_code','third_naics_code','fourth_naics_code','executive_count','executive_last_name','executive_first_name','executive_middle_initial','executive_title','business_type','ownership_code','url','derogatory_indicator','recent_derogatory_filed_date','derogatory_liability_amount_sign','derogatory_liability_amount','ucc_data_indicator','ucc_count','number_of_legal_items','legal_balance_sign','legal_balance_amount','pmtkbankruptcy','pmtkjudgment','pmtktaxlien','pmtkpayment','bankruptcy_filed','number_of_derogatory_legal_items','lien_count','judgment_count','bkc006','bkc007','bkc008','bko009','bkb001_sign','bkb001','bkb003_sign','bkb003','bko010','bko011','jdc010','jdc011','jdc012','jdb004','jdb005','jdb006','jDO013','jDO014','jdb002','jdp016','lgc004','pro001','pro003','txc010','txc011','txb004_sign','txb004','txo013','txb002_sign','txb002','txp016','ucc001','ucc002','ucc003','intelliscore_plus','percentile_model','model_action','score_factor_1','score_factor_2','score_factor_3','score_factor_4','model_code','model_type','last_experian_inquiry_date','recent_high_credit_sign','recent_high_credit','median_credit_amount_sign','median_credit_amount','total_combined_trade_lines_count','dbt_of_combined_trade_totals','combined_trade_balance','aged_trade_lines','experian_credit_rating','quarter_1_average_dbt','quarter_2_average_dbt','quarter_3_average_dbt','quarter_4_average_dbt','quarter_5_average_dbt','combined_dbt','total_account_balance_sign','total_account_balance','combined_account_balance_sign','combined_account_balance','collection_count','atc021','atc022','atc023','atc024','atc025','last_activity_age_code','cottage_indicator','nonprofit_indicator','financial_stability_risk_score','fsr_risk_class','fsr_score_factor_1','fsr_score_factor_2','fsr_score_factor_3','fsr_score_factor_4','ip_score_change_sign','ip_score_change','fsr_score_change_sign','fsr_score_change','dba_name','clean_dba_name','clean_phone','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_state','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','recent_update_desc','years_in_business_desc','address_type_desc','employee_size_desc','annual_sales_size_desc','location_desc','primary_sic_code_industry_class_desc','business_type_desc','ownership_code_desc','ucc_data_indicator_desc','experian_credit_rating_desc','last_activity_age_desc','cottage_indicator_desc','nonprofit_indicator_desc','company_name','p_title','p_fname','p_mname','p_lname','p_name_suffix','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id');
EXPORT FieldNum(SALT38.StrType fn) := CASE(fn,'dotid' => 0,'dotscore' => 1,'dotweight' => 2,'empid' => 3,'empscore' => 4,'empweight' => 5,'powid' => 6,'powscore' => 7,'powweight' => 8,'proxid' => 9,'proxscore' => 10,'proxweight' => 11,'seleid' => 12,'selescore' => 13,'seleweight' => 14,'orgid' => 15,'orgscore' => 16,'orgweight' => 17,'ultid' => 18,'ultscore' => 19,'ultweight' => 20,'bdid' => 21,'bdid_score' => 22,'did' => 23,'dt_first_seen' => 24,'dt_last_seen' => 25,'dt_vendor_first_reported' => 26,'dt_vendor_last_reported' => 27,'experian_bus_id' => 28,'business_name' => 29,'address' => 30,'city' => 31,'state' => 32,'zip_code' => 33,'zip_plus_4' => 34,'carrier_route' => 35,'county_code' => 36,'county_name' => 37,'phone_number' => 38,'msa_code' => 39,'msa_description' => 40,'establish_date' => 41,'latest_reported_date' => 42,'years_in_file' => 43,'geo_code_latitude' => 44,'geo_code_latitude_direction' => 45,'geo_code_longitude' => 46,'geo_code_longitude_direction' => 47,'recent_update_code' => 48,'years_in_business_code' => 49,'year_business_started' => 50,'months_in_file' => 51,'address_type_code' => 52,'estimated_number_of_employees' => 53,'employee_size_code' => 54,'estimated_annual_sales_amount_sign' => 55,'estimated_annual_sales_amount' => 56,'annual_sales_size_code' => 57,'location_code' => 58,'primary_sic_code_industry_classification' => 59,'primary_sic_code_4_digit' => 60,'primary_sic_code' => 61,'second_sic_code' => 62,'third_sic_code' => 63,'fourth_sic_code' => 64,'fifth_sic_code' => 65,'sixth_sic_code' => 66,'primary_naics_code' => 67,'second_naics_code' => 68,'third_naics_code' => 69,'fourth_naics_code' => 70,'executive_count' => 71,'executive_last_name' => 72,'executive_first_name' => 73,'executive_middle_initial' => 74,'executive_title' => 75,'business_type' => 76,'ownership_code' => 77,'url' => 78,'derogatory_indicator' => 79,'recent_derogatory_filed_date' => 80,'derogatory_liability_amount_sign' => 81,'derogatory_liability_amount' => 82,'ucc_data_indicator' => 83,'ucc_count' => 84,'number_of_legal_items' => 85,'legal_balance_sign' => 86,'legal_balance_amount' => 87,'pmtkbankruptcy' => 88,'pmtkjudgment' => 89,'pmtktaxlien' => 90,'pmtkpayment' => 91,'bankruptcy_filed' => 92,'number_of_derogatory_legal_items' => 93,'lien_count' => 94,'judgment_count' => 95,'bkc006' => 96,'bkc007' => 97,'bkc008' => 98,'bko009' => 99,'bkb001_sign' => 100,'bkb001' => 101,'bkb003_sign' => 102,'bkb003' => 103,'bko010' => 104,'bko011' => 105,'jdc010' => 106,'jdc011' => 107,'jdc012' => 108,'jdb004' => 109,'jdb005' => 110,'jdb006' => 111,'jDO013' => 112,'jDO014' => 113,'jdb002' => 114,'jdp016' => 115,'lgc004' => 116,'pro001' => 117,'pro003' => 118,'txc010' => 119,'txc011' => 120,'txb004_sign' => 121,'txb004' => 122,'txo013' => 123,'txb002_sign' => 124,'txb002' => 125,'txp016' => 126,'ucc001' => 127,'ucc002' => 128,'ucc003' => 129,'intelliscore_plus' => 130,'percentile_model' => 131,'model_action' => 132,'score_factor_1' => 133,'score_factor_2' => 134,'score_factor_3' => 135,'score_factor_4' => 136,'model_code' => 137,'model_type' => 138,'last_experian_inquiry_date' => 139,'recent_high_credit_sign' => 140,'recent_high_credit' => 141,'median_credit_amount_sign' => 142,'median_credit_amount' => 143,'total_combined_trade_lines_count' => 144,'dbt_of_combined_trade_totals' => 145,'combined_trade_balance' => 146,'aged_trade_lines' => 147,'experian_credit_rating' => 148,'quarter_1_average_dbt' => 149,'quarter_2_average_dbt' => 150,'quarter_3_average_dbt' => 151,'quarter_4_average_dbt' => 152,'quarter_5_average_dbt' => 153,'combined_dbt' => 154,'total_account_balance_sign' => 155,'total_account_balance' => 156,'combined_account_balance_sign' => 157,'combined_account_balance' => 158,'collection_count' => 159,'atc021' => 160,'atc022' => 161,'atc023' => 162,'atc024' => 163,'atc025' => 164,'last_activity_age_code' => 165,'cottage_indicator' => 166,'nonprofit_indicator' => 167,'financial_stability_risk_score' => 168,'fsr_risk_class' => 169,'fsr_score_factor_1' => 170,'fsr_score_factor_2' => 171,'fsr_score_factor_3' => 172,'fsr_score_factor_4' => 173,'ip_score_change_sign' => 174,'ip_score_change' => 175,'fsr_score_change_sign' => 176,'fsr_score_change' => 177,'dba_name' => 178,'clean_dba_name' => 179,'clean_phone' => 180,'prim_range' => 181,'predir' => 182,'prim_name' => 183,'addr_suffix' => 184,'postdir' => 185,'unit_desig' => 186,'sec_range' => 187,'p_city_name' => 188,'v_city_name' => 189,'st' => 190,'zip' => 191,'zip4' => 192,'cart' => 193,'cr_sort_sz' => 194,'lot' => 195,'lot_order' => 196,'dbpc' => 197,'chk_digit' => 198,'rec_type' => 199,'fips_state' => 200,'fips_county' => 201,'geo_lat' => 202,'geo_long' => 203,'msa' => 204,'geo_blk' => 205,'geo_match' => 206,'err_stat' => 207,'recent_update_desc' => 208,'years_in_business_desc' => 209,'address_type_desc' => 210,'employee_size_desc' => 211,'annual_sales_size_desc' => 212,'location_desc' => 213,'primary_sic_code_industry_class_desc' => 214,'business_type_desc' => 215,'ownership_code_desc' => 216,'ucc_data_indicator_desc' => 217,'experian_credit_rating_desc' => 218,'last_activity_age_desc' => 219,'cottage_indicator_desc' => 220,'nonprofit_indicator_desc' => 221,'company_name' => 222,'p_title' => 223,'p_fname' => 224,'p_mname' => 225,'p_lname' => 226,'p_name_suffix' => 227,'raw_aid' => 228,'ace_aid' => 229,'prep_addr_line1' => 230,'prep_addr_line_last' => 231,'source_rec_id' => 232,0);
EXPORT SET OF SALT38.StrType FieldRules(UNSIGNED2 i) := CHOOSE(i,['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['ALLOW'],['ALLOW'],['ENUM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['ALLOW'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],[],[],[],['ALLOW'],['ALLOW'],[],['ALLOW'],['CUSTOM'],['ENUM'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['ALLOW'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ALLOW'],['ENUM'],['ALLOW'],['CUSTOM'],['ALLOW'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],[],['CUSTOM'],[],[],['ALLOW'],['CUSTOM'],[],['ALLOW'],[],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['ENUM'],['CUSTOM'],['ENUM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],[],[],[],[],[],[],[],[],[],[],[],[],[],[],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],[],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],['CUSTOM'],[]);
EXPORT BOOLEAN InBaseLayout(UNSIGNED2 i) := CHOOSE(i,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE);
 
//Individual field level validation
 
EXPORT Make_dotid(SALT38.StrType s0) := MakeFT_invalid_zero_blank(s0);
EXPORT InValid_dotid(SALT38.StrType s) := InValidFT_invalid_zero_blank(s);
EXPORT InValidMessage_dotid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_blank(wh);
 
EXPORT Make_dotscore(SALT38.StrType s0) := MakeFT_invalid_zero_blank(s0);
EXPORT InValid_dotscore(SALT38.StrType s) := InValidFT_invalid_zero_blank(s);
EXPORT InValidMessage_dotscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_blank(wh);
 
EXPORT Make_dotweight(SALT38.StrType s0) := MakeFT_invalid_zero_blank(s0);
EXPORT InValid_dotweight(SALT38.StrType s) := InValidFT_invalid_zero_blank(s);
EXPORT InValidMessage_dotweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_blank(wh);
 
EXPORT Make_empid(SALT38.StrType s0) := MakeFT_invalid_zero_blank(s0);
EXPORT InValid_empid(SALT38.StrType s) := InValidFT_invalid_zero_blank(s);
EXPORT InValidMessage_empid(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_blank(wh);
 
EXPORT Make_empscore(SALT38.StrType s0) := MakeFT_invalid_zero_blank(s0);
EXPORT InValid_empscore(SALT38.StrType s) := InValidFT_invalid_zero_blank(s);
EXPORT InValidMessage_empscore(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_blank(wh);
 
EXPORT Make_empweight(SALT38.StrType s0) := MakeFT_invalid_zero_blank(s0);
EXPORT InValid_empweight(SALT38.StrType s) := InValidFT_invalid_zero_blank(s);
EXPORT InValidMessage_empweight(UNSIGNED1 wh) := InValidMessageFT_invalid_zero_blank(wh);
 
EXPORT Make_powid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_powid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_powid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_powscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_powscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_powscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_powweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_powweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_powweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_proxid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_proxid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_proxid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_proxscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_proxscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_proxscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_proxweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_proxweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_proxweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_seleid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_seleid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_seleid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_selescore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_selescore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_selescore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_seleweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_seleweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_seleweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_orgid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_orgid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_orgid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_orgscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_orgscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_orgscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_orgweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_orgweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_orgweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ultid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ultid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ultid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ultscore(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_ultscore(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_ultscore(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_ultweight(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ultweight(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ultweight(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bdid(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bdid(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bdid(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bdid_score(SALT38.StrType s0) := MakeFT_invalid_percentage(s0);
EXPORT InValid_bdid_score(SALT38.StrType s) := InValidFT_invalid_percentage(s);
EXPORT InValidMessage_bdid_score(UNSIGNED1 wh) := InValidMessageFT_invalid_percentage(wh);
 
EXPORT Make_did(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_did(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_did(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_dt_first_seen(SALT38.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_first_seen(SALT38.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_first_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_last_seen(SALT38.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_last_seen(SALT38.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_last_seen(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_vendor_first_reported(SALT38.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_vendor_first_reported(SALT38.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_vendor_first_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_dt_vendor_last_reported(SALT38.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_dt_vendor_last_reported(SALT38.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_dt_vendor_last_reported(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_experian_bus_id(SALT38.StrType s0) := MakeFT_invalid_experian_bus_id(s0);
EXPORT InValid_experian_bus_id(SALT38.StrType s) := InValidFT_invalid_experian_bus_id(s);
EXPORT InValidMessage_experian_bus_id(UNSIGNED1 wh) := InValidMessageFT_invalid_experian_bus_id(wh);
 
EXPORT Make_business_name(SALT38.StrType s0) := MakeFT_invalid_business_name(s0);
EXPORT InValid_business_name(SALT38.StrType s) := InValidFT_invalid_business_name(s);
EXPORT InValidMessage_business_name(UNSIGNED1 wh) := InValidMessageFT_invalid_business_name(wh);
 
EXPORT Make_address(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_address(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_address(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_city(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_city(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_city(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_state(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_state(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_state(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip_code(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip_code(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip_code(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip_plus_4(SALT38.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip_plus_4(SALT38.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip_plus_4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_carrier_route(SALT38.StrType s0) := MakeFT_invalid_carrier_route(s0);
EXPORT InValid_carrier_route(SALT38.StrType s) := InValidFT_invalid_carrier_route(s);
EXPORT InValidMessage_carrier_route(UNSIGNED1 wh) := InValidMessageFT_invalid_carrier_route(wh);
 
EXPORT Make_county_code(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_county_code(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_county_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_county_name(SALT38.StrType s0) := MakeFT_invalid_alphaHyphen(s0);
EXPORT InValid_county_name(SALT38.StrType s) := InValidFT_invalid_alphaHyphen(s);
EXPORT InValidMessage_county_name(UNSIGNED1 wh) := InValidMessageFT_invalid_alphaHyphen(wh);
 
EXPORT Make_phone_number(SALT38.StrType s0) := MakeFT_invalid_phone(s0);
EXPORT InValid_phone_number(SALT38.StrType s) := InValidFT_invalid_phone(s);
EXPORT InValidMessage_phone_number(UNSIGNED1 wh) := InValidMessageFT_invalid_phone(wh);
 
EXPORT Make_msa_code(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_msa_code(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_msa_code(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_msa_description(SALT38.StrType s0) := s0;
EXPORT InValid_msa_description(SALT38.StrType s) := 0;
EXPORT InValidMessage_msa_description(UNSIGNED1 wh) := '';
 
EXPORT Make_establish_date(SALT38.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_establish_date(SALT38.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_establish_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_latest_reported_date(SALT38.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_latest_reported_date(SALT38.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_latest_reported_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_years_in_file(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_years_in_file(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_years_in_file(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_geo_code_latitude(SALT38.StrType s0) := MakeFT_invalid_numericPeriod(s0);
EXPORT InValid_geo_code_latitude(SALT38.StrType s) := InValidFT_invalid_numericPeriod(s);
EXPORT InValidMessage_geo_code_latitude(UNSIGNED1 wh) := InValidMessageFT_invalid_numericPeriod(wh);
 
EXPORT Make_geo_code_latitude_direction(SALT38.StrType s0) := MakeFT_invalid_geo_code_latitude_direction(s0);
EXPORT InValid_geo_code_latitude_direction(SALT38.StrType s) := InValidFT_invalid_geo_code_latitude_direction(s);
EXPORT InValidMessage_geo_code_latitude_direction(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_code_latitude_direction(wh);
 
EXPORT Make_geo_code_longitude(SALT38.StrType s0) := MakeFT_invalid_numericPeriod(s0);
EXPORT InValid_geo_code_longitude(SALT38.StrType s) := InValidFT_invalid_numericPeriod(s);
EXPORT InValidMessage_geo_code_longitude(UNSIGNED1 wh) := InValidMessageFT_invalid_numericPeriod(wh);
 
EXPORT Make_geo_code_longitude_direction(SALT38.StrType s0) := MakeFT_invalid_geo_code_longitude_direction(s0);
EXPORT InValid_geo_code_longitude_direction(SALT38.StrType s) := InValidFT_invalid_geo_code_longitude_direction(s);
EXPORT InValidMessage_geo_code_longitude_direction(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_code_longitude_direction(wh);
 
EXPORT Make_recent_update_code(SALT38.StrType s0) := MakeFT_invalid_recent_update_code(s0);
EXPORT InValid_recent_update_code(SALT38.StrType s) := InValidFT_invalid_recent_update_code(s);
EXPORT InValidMessage_recent_update_code(UNSIGNED1 wh) := InValidMessageFT_invalid_recent_update_code(wh);
 
EXPORT Make_years_in_business_code(SALT38.StrType s0) := MakeFT_invalid_years_in_business_code(s0);
EXPORT InValid_years_in_business_code(SALT38.StrType s) := InValidFT_invalid_years_in_business_code(s);
EXPORT InValidMessage_years_in_business_code(UNSIGNED1 wh) := InValidMessageFT_invalid_years_in_business_code(wh);
 
EXPORT Make_year_business_started(SALT38.StrType s0) := MakeFT_invalid_year(s0);
EXPORT InValid_year_business_started(SALT38.StrType s) := InValidFT_invalid_year(s);
EXPORT InValidMessage_year_business_started(UNSIGNED1 wh) := InValidMessageFT_invalid_year(wh);
 
EXPORT Make_months_in_file(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_months_in_file(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_months_in_file(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_address_type_code(SALT38.StrType s0) := MakeFT_invalid_address_type_code(s0);
EXPORT InValid_address_type_code(SALT38.StrType s) := InValidFT_invalid_address_type_code(s);
EXPORT InValidMessage_address_type_code(UNSIGNED1 wh) := InValidMessageFT_invalid_address_type_code(wh);
 
EXPORT Make_estimated_number_of_employees(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_estimated_number_of_employees(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_estimated_number_of_employees(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_employee_size_code(SALT38.StrType s0) := MakeFT_invalid_employee_size_code(s0);
EXPORT InValid_employee_size_code(SALT38.StrType s) := InValidFT_invalid_employee_size_code(s);
EXPORT InValidMessage_employee_size_code(UNSIGNED1 wh) := InValidMessageFT_invalid_employee_size_code(wh);
 
EXPORT Make_estimated_annual_sales_amount_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_estimated_annual_sales_amount_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_estimated_annual_sales_amount_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_estimated_annual_sales_amount(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_estimated_annual_sales_amount(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_estimated_annual_sales_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_annual_sales_size_code(SALT38.StrType s0) := MakeFT_invalid_annual_Sales_Size_Code(s0);
EXPORT InValid_annual_sales_size_code(SALT38.StrType s) := InValidFT_invalid_annual_Sales_Size_Code(s);
EXPORT InValidMessage_annual_sales_size_code(UNSIGNED1 wh) := InValidMessageFT_invalid_annual_Sales_Size_Code(wh);
 
EXPORT Make_location_code(SALT38.StrType s0) := MakeFT_invalid_location_code(s0);
EXPORT InValid_location_code(SALT38.StrType s) := InValidFT_invalid_location_code(s);
EXPORT InValidMessage_location_code(UNSIGNED1 wh) := InValidMessageFT_invalid_location_code(wh);
 
EXPORT Make_primary_sic_code_industry_classification(SALT38.StrType s0) := MakeFT_invalid_primary_sic_code_industry_classification(s0);
EXPORT InValid_primary_sic_code_industry_classification(SALT38.StrType s) := InValidFT_invalid_primary_sic_code_industry_classification(s);
EXPORT InValidMessage_primary_sic_code_industry_classification(UNSIGNED1 wh) := InValidMessageFT_invalid_primary_sic_code_industry_classification(wh);
 
EXPORT Make_primary_sic_code_4_digit(SALT38.StrType s0) := MakeFT_invalid_sic_codes(s0);
EXPORT InValid_primary_sic_code_4_digit(SALT38.StrType s) := InValidFT_invalid_sic_codes(s);
EXPORT InValidMessage_primary_sic_code_4_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_codes(wh);
 
EXPORT Make_primary_sic_code(SALT38.StrType s0) := MakeFT_invalid_sic_codes(s0);
EXPORT InValid_primary_sic_code(SALT38.StrType s) := InValidFT_invalid_sic_codes(s);
EXPORT InValidMessage_primary_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_codes(wh);
 
EXPORT Make_second_sic_code(SALT38.StrType s0) := MakeFT_invalid_sic_codes(s0);
EXPORT InValid_second_sic_code(SALT38.StrType s) := InValidFT_invalid_sic_codes(s);
EXPORT InValidMessage_second_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_codes(wh);
 
EXPORT Make_third_sic_code(SALT38.StrType s0) := MakeFT_invalid_sic_codes(s0);
EXPORT InValid_third_sic_code(SALT38.StrType s) := InValidFT_invalid_sic_codes(s);
EXPORT InValidMessage_third_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_codes(wh);
 
EXPORT Make_fourth_sic_code(SALT38.StrType s0) := MakeFT_invalid_sic_codes(s0);
EXPORT InValid_fourth_sic_code(SALT38.StrType s) := InValidFT_invalid_sic_codes(s);
EXPORT InValidMessage_fourth_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_codes(wh);
 
EXPORT Make_fifth_sic_code(SALT38.StrType s0) := MakeFT_invalid_sic_codes(s0);
EXPORT InValid_fifth_sic_code(SALT38.StrType s) := InValidFT_invalid_sic_codes(s);
EXPORT InValidMessage_fifth_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_codes(wh);
 
EXPORT Make_sixth_sic_code(SALT38.StrType s0) := MakeFT_invalid_sic_codes(s0);
EXPORT InValid_sixth_sic_code(SALT38.StrType s) := InValidFT_invalid_sic_codes(s);
EXPORT InValidMessage_sixth_sic_code(UNSIGNED1 wh) := InValidMessageFT_invalid_sic_codes(wh);
 
EXPORT Make_primary_naics_code(SALT38.StrType s0) := MakeFT_invalid_naics_codes(s0);
EXPORT InValid_primary_naics_code(SALT38.StrType s) := InValidFT_invalid_naics_codes(s);
EXPORT InValidMessage_primary_naics_code(UNSIGNED1 wh) := InValidMessageFT_invalid_naics_codes(wh);
 
EXPORT Make_second_naics_code(SALT38.StrType s0) := MakeFT_invalid_naics_codes(s0);
EXPORT InValid_second_naics_code(SALT38.StrType s) := InValidFT_invalid_naics_codes(s);
EXPORT InValidMessage_second_naics_code(UNSIGNED1 wh) := InValidMessageFT_invalid_naics_codes(wh);
 
EXPORT Make_third_naics_code(SALT38.StrType s0) := MakeFT_invalid_naics_codes(s0);
EXPORT InValid_third_naics_code(SALT38.StrType s) := InValidFT_invalid_naics_codes(s);
EXPORT InValidMessage_third_naics_code(UNSIGNED1 wh) := InValidMessageFT_invalid_naics_codes(wh);
 
EXPORT Make_fourth_naics_code(SALT38.StrType s0) := MakeFT_invalid_naics_codes(s0);
EXPORT InValid_fourth_naics_code(SALT38.StrType s) := InValidFT_invalid_naics_codes(s);
EXPORT InValidMessage_fourth_naics_code(UNSIGNED1 wh) := InValidMessageFT_invalid_naics_codes(wh);
 
EXPORT Make_executive_count(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_executive_count(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_executive_count(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_executive_last_name(SALT38.StrType s0) := s0;
EXPORT InValid_executive_last_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_executive_last_name(UNSIGNED1 wh) := '';
 
EXPORT Make_executive_first_name(SALT38.StrType s0) := s0;
EXPORT InValid_executive_first_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_executive_first_name(UNSIGNED1 wh) := '';
 
EXPORT Make_executive_middle_initial(SALT38.StrType s0) := s0;
EXPORT InValid_executive_middle_initial(SALT38.StrType s) := 0;
EXPORT InValidMessage_executive_middle_initial(UNSIGNED1 wh) := '';
 
EXPORT Make_executive_title(SALT38.StrType s0) := s0;
EXPORT InValid_executive_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_executive_title(UNSIGNED1 wh) := '';
 
EXPORT Make_business_type(SALT38.StrType s0) := MakeFT_invalid_business_type(s0);
EXPORT InValid_business_type(SALT38.StrType s) := InValidFT_invalid_business_type(s);
EXPORT InValidMessage_business_type(UNSIGNED1 wh) := InValidMessageFT_invalid_business_type(wh);
 
EXPORT Make_ownership_code(SALT38.StrType s0) := MakeFT_invalid_ownership_code(s0);
EXPORT InValid_ownership_code(SALT38.StrType s) := InValidFT_invalid_ownership_code(s);
EXPORT InValidMessage_ownership_code(UNSIGNED1 wh) := InValidMessageFT_invalid_ownership_code(wh);
 
EXPORT Make_url(SALT38.StrType s0) := s0;
EXPORT InValid_url(SALT38.StrType s) := 0;
EXPORT InValidMessage_url(UNSIGNED1 wh) := '';
 
EXPORT Make_derogatory_indicator(SALT38.StrType s0) := MakeFT_invalid_derogatory_indicator(s0);
EXPORT InValid_derogatory_indicator(SALT38.StrType s) := InValidFT_invalid_derogatory_indicator(s);
EXPORT InValidMessage_derogatory_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_derogatory_indicator(wh);
 
EXPORT Make_recent_derogatory_filed_date(SALT38.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_recent_derogatory_filed_date(SALT38.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_recent_derogatory_filed_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_derogatory_liability_amount_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_derogatory_liability_amount_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_derogatory_liability_amount_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_derogatory_liability_amount(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_derogatory_liability_amount(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_derogatory_liability_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ucc_data_indicator(SALT38.StrType s0) := MakeFT_invalid_ucc_data_indicator(s0);
EXPORT InValid_ucc_data_indicator(SALT38.StrType s) := InValidFT_invalid_ucc_data_indicator(s);
EXPORT InValidMessage_ucc_data_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_ucc_data_indicator(wh);
 
EXPORT Make_ucc_count(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ucc_count(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ucc_count(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_number_of_legal_items(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_number_of_legal_items(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_number_of_legal_items(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_legal_balance_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_legal_balance_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_legal_balance_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_legal_balance_amount(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_legal_balance_amount(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_legal_balance_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_pmtkbankruptcy(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_pmtkbankruptcy(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_pmtkbankruptcy(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_pmtkjudgment(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_pmtkjudgment(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_pmtkjudgment(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_pmtktaxlien(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_pmtktaxlien(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_pmtktaxlien(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_pmtkpayment(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_pmtkpayment(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_pmtkpayment(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_bankruptcy_filed(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_bankruptcy_filed(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_bankruptcy_filed(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_number_of_derogatory_legal_items(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_number_of_derogatory_legal_items(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_number_of_derogatory_legal_items(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_lien_count(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_lien_count(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_lien_count(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_judgment_count(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_judgment_count(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_judgment_count(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bkc006(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bkc006(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bkc006(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bkc007(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bkc007(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bkc007(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bkc008(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bkc008(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bkc008(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bko009(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bko009(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bko009(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bkb001_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_bkb001_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_bkb001_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_bkb001(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bkb001(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bkb001(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bkb003_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_bkb003_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_bkb003_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_bkb003(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bkb003(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bkb003(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bko010(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bko010(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bko010(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_bko011(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_bko011(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_bko011(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jdc010(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jdc010(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jdc010(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jdc011(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jdc011(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jdc011(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jdc012(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jdc012(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jdc012(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jdb004(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jdb004(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jdb004(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jdb005(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jdb005(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jdb005(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jdb006(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jdb006(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jdb006(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jDO013(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jDO013(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jDO013(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jDO014(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jDO014(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jDO014(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jdb002(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jdb002(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jdb002(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_jdp016(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_jdp016(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_jdp016(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_lgc004(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_lgc004(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_lgc004(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_pro001(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_pro001(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_pro001(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_pro003(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_pro003(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_pro003(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_txc010(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_txc010(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_txc010(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_txc011(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_txc011(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_txc011(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_txb004_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_txb004_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_txb004_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_txb004(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_txb004(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_txb004(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_txo013(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_txo013(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_txo013(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_txb002_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_txb002_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_txb002_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_txb002(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_txb002(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_txb002(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_txp016(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_txp016(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_txp016(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ucc001(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ucc001(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ucc001(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ucc002(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ucc002(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ucc002(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ucc003(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ucc003(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ucc003(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_intelliscore_plus(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_intelliscore_plus(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_intelliscore_plus(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_percentile_model(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_percentile_model(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_percentile_model(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_model_action(SALT38.StrType s0) := MakeFT_invalid_model_action(s0);
EXPORT InValid_model_action(SALT38.StrType s) := InValidFT_invalid_model_action(s);
EXPORT InValidMessage_model_action(UNSIGNED1 wh) := InValidMessageFT_invalid_model_action(wh);
 
EXPORT Make_score_factor_1(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_score_factor_1(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_score_factor_1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_score_factor_2(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_score_factor_2(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_score_factor_2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_score_factor_3(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_score_factor_3(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_score_factor_3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_score_factor_4(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_score_factor_4(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_score_factor_4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_model_code(SALT38.StrType s0) := s0;
EXPORT InValid_model_code(SALT38.StrType s) := 0;
EXPORT InValidMessage_model_code(UNSIGNED1 wh) := '';
 
EXPORT Make_model_type(SALT38.StrType s0) := MakeFT_invalid_model_type(s0);
EXPORT InValid_model_type(SALT38.StrType s) := InValidFT_invalid_model_type(s);
EXPORT InValidMessage_model_type(UNSIGNED1 wh) := InValidMessageFT_invalid_model_type(wh);
 
EXPORT Make_last_experian_inquiry_date(SALT38.StrType s0) := MakeFT_invalid_pastdate(s0);
EXPORT InValid_last_experian_inquiry_date(SALT38.StrType s) := InValidFT_invalid_pastdate(s);
EXPORT InValidMessage_last_experian_inquiry_date(UNSIGNED1 wh) := InValidMessageFT_invalid_pastdate(wh);
 
EXPORT Make_recent_high_credit_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_recent_high_credit_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_recent_high_credit_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_recent_high_credit(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_recent_high_credit(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_recent_high_credit(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_median_credit_amount_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_median_credit_amount_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_median_credit_amount_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_median_credit_amount(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_median_credit_amount(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_median_credit_amount(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_total_combined_trade_lines_count(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_total_combined_trade_lines_count(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_total_combined_trade_lines_count(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_dbt_of_combined_trade_totals(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_dbt_of_combined_trade_totals(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_dbt_of_combined_trade_totals(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_combined_trade_balance(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_combined_trade_balance(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_combined_trade_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_aged_trade_lines(SALT38.StrType s0) := MakeFT_invalid_aged_trade_lines(s0);
EXPORT InValid_aged_trade_lines(SALT38.StrType s) := InValidFT_invalid_aged_trade_lines(s);
EXPORT InValidMessage_aged_trade_lines(UNSIGNED1 wh) := InValidMessageFT_invalid_aged_trade_lines(wh);
 
EXPORT Make_experian_credit_rating(SALT38.StrType s0) := MakeFT_invalid_Experian_Credit_Rating(s0);
EXPORT InValid_experian_credit_rating(SALT38.StrType s) := InValidFT_invalid_Experian_Credit_Rating(s);
EXPORT InValidMessage_experian_credit_rating(UNSIGNED1 wh) := InValidMessageFT_invalid_Experian_Credit_Rating(wh);
 
EXPORT Make_quarter_1_average_dbt(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_quarter_1_average_dbt(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_quarter_1_average_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_quarter_2_average_dbt(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_quarter_2_average_dbt(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_quarter_2_average_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_quarter_3_average_dbt(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_quarter_3_average_dbt(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_quarter_3_average_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_quarter_4_average_dbt(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_quarter_4_average_dbt(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_quarter_4_average_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_quarter_5_average_dbt(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_quarter_5_average_dbt(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_quarter_5_average_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_combined_dbt(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_combined_dbt(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_combined_dbt(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_total_account_balance_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_total_account_balance_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_total_account_balance_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_total_account_balance(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_total_account_balance(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_total_account_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_combined_account_balance_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_combined_account_balance_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_combined_account_balance_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_combined_account_balance(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_combined_account_balance(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_combined_account_balance(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_collection_count(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_collection_count(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_collection_count(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_atc021(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_atc021(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_atc021(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_atc022(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_atc022(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_atc022(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_atc023(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_atc023(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_atc023(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_atc024(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_atc024(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_atc024(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_atc025(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_atc025(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_atc025(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_last_activity_age_code(SALT38.StrType s0) := MakeFT_invalid_last_activity_age_code(s0);
EXPORT InValid_last_activity_age_code(SALT38.StrType s) := InValidFT_invalid_last_activity_age_code(s);
EXPORT InValidMessage_last_activity_age_code(UNSIGNED1 wh) := InValidMessageFT_invalid_last_activity_age_code(wh);
 
EXPORT Make_cottage_indicator(SALT38.StrType s0) := MakeFT_invalid_boolean(s0);
EXPORT InValid_cottage_indicator(SALT38.StrType s) := InValidFT_invalid_boolean(s);
EXPORT InValidMessage_cottage_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_boolean(wh);
 
EXPORT Make_nonprofit_indicator(SALT38.StrType s0) := MakeFT_invalid_nonprofit_indicator(s0);
EXPORT InValid_nonprofit_indicator(SALT38.StrType s) := InValidFT_invalid_nonprofit_indicator(s);
EXPORT InValidMessage_nonprofit_indicator(UNSIGNED1 wh) := InValidMessageFT_invalid_nonprofit_indicator(wh);
 
EXPORT Make_financial_stability_risk_score(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_financial_stability_risk_score(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_financial_stability_risk_score(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fsr_risk_class(SALT38.StrType s0) := MakeFT_invalid_fsr_risk_class(s0);
EXPORT InValid_fsr_risk_class(SALT38.StrType s) := InValidFT_invalid_fsr_risk_class(s);
EXPORT InValidMessage_fsr_risk_class(UNSIGNED1 wh) := InValidMessageFT_invalid_fsr_risk_class(wh);
 
EXPORT Make_fsr_score_factor_1(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fsr_score_factor_1(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fsr_score_factor_1(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fsr_score_factor_2(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fsr_score_factor_2(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fsr_score_factor_2(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fsr_score_factor_3(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fsr_score_factor_3(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fsr_score_factor_3(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fsr_score_factor_4(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fsr_score_factor_4(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fsr_score_factor_4(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_ip_score_change_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_ip_score_change_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_ip_score_change_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_ip_score_change(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_ip_score_change(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_ip_score_change(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_fsr_score_change_sign(SALT38.StrType s0) := MakeFT_invalid_sign(s0);
EXPORT InValid_fsr_score_change_sign(SALT38.StrType s) := InValidFT_invalid_sign(s);
EXPORT InValidMessage_fsr_score_change_sign(UNSIGNED1 wh) := InValidMessageFT_invalid_sign(wh);
 
EXPORT Make_fsr_score_change(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_fsr_score_change(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_fsr_score_change(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
EXPORT Make_dba_name(SALT38.StrType s0) := s0;
EXPORT InValid_dba_name(SALT38.StrType s) := 0;
EXPORT InValidMessage_dba_name(UNSIGNED1 wh) := '';
 
EXPORT Make_clean_dba_name(SALT38.StrType s0) := MakeFT_invalid_clean_dba_name(s0);
EXPORT InValid_clean_dba_name(SALT38.StrType s,SALT38.StrType dba_name) := InValidFT_invalid_clean_dba_name(s,dba_name);
EXPORT InValidMessage_clean_dba_name(UNSIGNED1 wh) := InValidMessageFT_invalid_clean_dba_name(wh);
 
EXPORT Make_clean_phone(SALT38.StrType s0) := s0;
EXPORT InValid_clean_phone(SALT38.StrType s) := 0;
EXPORT InValidMessage_clean_phone(UNSIGNED1 wh) := '';
 
EXPORT Make_prim_range(SALT38.StrType s0) := s0;
EXPORT InValid_prim_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_prim_range(UNSIGNED1 wh) := '';
 
EXPORT Make_predir(SALT38.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_predir(SALT38.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_predir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_prim_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prim_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prim_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_addr_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_addr_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_addr_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_postdir(SALT38.StrType s0) := MakeFT_invalid_direction(s0);
EXPORT InValid_postdir(SALT38.StrType s) := InValidFT_invalid_direction(s);
EXPORT InValidMessage_postdir(UNSIGNED1 wh) := InValidMessageFT_invalid_direction(wh);
 
EXPORT Make_unit_desig(SALT38.StrType s0) := s0;
EXPORT InValid_unit_desig(SALT38.StrType s) := 0;
EXPORT InValidMessage_unit_desig(UNSIGNED1 wh) := '';
 
EXPORT Make_sec_range(SALT38.StrType s0) := s0;
EXPORT InValid_sec_range(SALT38.StrType s) := 0;
EXPORT InValidMessage_sec_range(UNSIGNED1 wh) := '';
 
EXPORT Make_p_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_p_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_p_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_v_city_name(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_v_city_name(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_v_city_name(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_st(SALT38.StrType s0) := MakeFT_invalid_state(s0);
EXPORT InValid_st(SALT38.StrType s) := InValidFT_invalid_state(s);
EXPORT InValidMessage_st(UNSIGNED1 wh) := InValidMessageFT_invalid_state(wh);
 
EXPORT Make_zip(SALT38.StrType s0) := MakeFT_invalid_zip(s0);
EXPORT InValid_zip(SALT38.StrType s) := InValidFT_invalid_zip(s);
EXPORT InValidMessage_zip(UNSIGNED1 wh) := InValidMessageFT_invalid_zip(wh);
 
EXPORT Make_zip4(SALT38.StrType s0) := MakeFT_invalid_zip4(s0);
EXPORT InValid_zip4(SALT38.StrType s) := InValidFT_invalid_zip4(s);
EXPORT InValidMessage_zip4(UNSIGNED1 wh) := InValidMessageFT_invalid_zip4(wh);
 
EXPORT Make_cart(SALT38.StrType s0) := MakeFT_invalid_cart(s0);
EXPORT InValid_cart(SALT38.StrType s) := InValidFT_invalid_cart(s);
EXPORT InValidMessage_cart(UNSIGNED1 wh) := InValidMessageFT_invalid_cart(wh);
 
EXPORT Make_cr_sort_sz(SALT38.StrType s0) := MakeFT_invalid_cr_sort_sz(s0);
EXPORT InValid_cr_sort_sz(SALT38.StrType s) := InValidFT_invalid_cr_sort_sz(s);
EXPORT InValidMessage_cr_sort_sz(UNSIGNED1 wh) := InValidMessageFT_invalid_cr_sort_sz(wh);
 
EXPORT Make_lot(SALT38.StrType s0) := MakeFT_invalid_lot(s0);
EXPORT InValid_lot(SALT38.StrType s) := InValidFT_invalid_lot(s);
EXPORT InValidMessage_lot(UNSIGNED1 wh) := InValidMessageFT_invalid_lot(wh);
 
EXPORT Make_lot_order(SALT38.StrType s0) := MakeFT_invalid_lot_order(s0);
EXPORT InValid_lot_order(SALT38.StrType s) := InValidFT_invalid_lot_order(s);
EXPORT InValidMessage_lot_order(UNSIGNED1 wh) := InValidMessageFT_invalid_lot_order(wh);
 
EXPORT Make_dbpc(SALT38.StrType s0) := MakeFT_invalid_dpbc(s0);
EXPORT InValid_dbpc(SALT38.StrType s) := InValidFT_invalid_dpbc(s);
EXPORT InValidMessage_dbpc(UNSIGNED1 wh) := InValidMessageFT_invalid_dpbc(wh);
 
EXPORT Make_chk_digit(SALT38.StrType s0) := MakeFT_invalid_chk_digit(s0);
EXPORT InValid_chk_digit(SALT38.StrType s) := InValidFT_invalid_chk_digit(s);
EXPORT InValidMessage_chk_digit(UNSIGNED1 wh) := InValidMessageFT_invalid_chk_digit(wh);
 
EXPORT Make_rec_type(SALT38.StrType s0) := s0;
EXPORT InValid_rec_type(SALT38.StrType s) := 0;
EXPORT InValidMessage_rec_type(UNSIGNED1 wh) := '';
 
EXPORT Make_fips_state(SALT38.StrType s0) := MakeFT_invalid_fips_state(s0);
EXPORT InValid_fips_state(SALT38.StrType s) := InValidFT_invalid_fips_state(s);
EXPORT InValidMessage_fips_state(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_state(wh);
 
EXPORT Make_fips_county(SALT38.StrType s0) := MakeFT_invalid_fips_county(s0);
EXPORT InValid_fips_county(SALT38.StrType s) := InValidFT_invalid_fips_county(s);
EXPORT InValidMessage_fips_county(UNSIGNED1 wh) := InValidMessageFT_invalid_fips_county(wh);
 
EXPORT Make_geo_lat(SALT38.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_lat(SALT38.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_lat(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_geo_long(SALT38.StrType s0) := MakeFT_invalid_geo(s0);
EXPORT InValid_geo_long(SALT38.StrType s) := InValidFT_invalid_geo(s);
EXPORT InValidMessage_geo_long(UNSIGNED1 wh) := InValidMessageFT_invalid_geo(wh);
 
EXPORT Make_msa(SALT38.StrType s0) := MakeFT_invalid_msa(s0);
EXPORT InValid_msa(SALT38.StrType s) := InValidFT_invalid_msa(s);
EXPORT InValidMessage_msa(UNSIGNED1 wh) := InValidMessageFT_invalid_msa(wh);
 
EXPORT Make_geo_blk(SALT38.StrType s0) := s0;
EXPORT InValid_geo_blk(SALT38.StrType s) := 0;
EXPORT InValidMessage_geo_blk(UNSIGNED1 wh) := '';
 
EXPORT Make_geo_match(SALT38.StrType s0) := MakeFT_invalid_geo_match(s0);
EXPORT InValid_geo_match(SALT38.StrType s) := InValidFT_invalid_geo_match(s);
EXPORT InValidMessage_geo_match(UNSIGNED1 wh) := InValidMessageFT_invalid_geo_match(wh);
 
EXPORT Make_err_stat(SALT38.StrType s0) := MakeFT_invalid_err_stat(s0);
EXPORT InValid_err_stat(SALT38.StrType s) := InValidFT_invalid_err_stat(s);
EXPORT InValidMessage_err_stat(UNSIGNED1 wh) := InValidMessageFT_invalid_err_stat(wh);
 
EXPORT Make_recent_update_desc(SALT38.StrType s0) := s0;
EXPORT InValid_recent_update_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_recent_update_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_years_in_business_desc(SALT38.StrType s0) := s0;
EXPORT InValid_years_in_business_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_years_in_business_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_address_type_desc(SALT38.StrType s0) := s0;
EXPORT InValid_address_type_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_address_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_employee_size_desc(SALT38.StrType s0) := s0;
EXPORT InValid_employee_size_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_employee_size_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_annual_sales_size_desc(SALT38.StrType s0) := s0;
EXPORT InValid_annual_sales_size_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_annual_sales_size_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_location_desc(SALT38.StrType s0) := s0;
EXPORT InValid_location_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_location_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_primary_sic_code_industry_class_desc(SALT38.StrType s0) := s0;
EXPORT InValid_primary_sic_code_industry_class_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_primary_sic_code_industry_class_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_business_type_desc(SALT38.StrType s0) := s0;
EXPORT InValid_business_type_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_business_type_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_ownership_code_desc(SALT38.StrType s0) := s0;
EXPORT InValid_ownership_code_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_ownership_code_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_ucc_data_indicator_desc(SALT38.StrType s0) := s0;
EXPORT InValid_ucc_data_indicator_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_ucc_data_indicator_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_experian_credit_rating_desc(SALT38.StrType s0) := s0;
EXPORT InValid_experian_credit_rating_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_experian_credit_rating_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_last_activity_age_desc(SALT38.StrType s0) := s0;
EXPORT InValid_last_activity_age_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_last_activity_age_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_cottage_indicator_desc(SALT38.StrType s0) := s0;
EXPORT InValid_cottage_indicator_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_cottage_indicator_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_nonprofit_indicator_desc(SALT38.StrType s0) := s0;
EXPORT InValid_nonprofit_indicator_desc(SALT38.StrType s) := 0;
EXPORT InValidMessage_nonprofit_indicator_desc(UNSIGNED1 wh) := '';
 
EXPORT Make_company_name(SALT38.StrType s0) := MakeFT_invalid_bName_pName(s0);
EXPORT InValid_company_name(SALT38.StrType s,SALT38.StrType p_fname,SALT38.StrType p_mname,SALT38.StrType p_lname) := InValidFT_invalid_bName_pName(s,p_fname,p_mname,p_lname);
EXPORT InValidMessage_company_name(UNSIGNED1 wh) := InValidMessageFT_invalid_bName_pName(wh);
 
EXPORT Make_p_title(SALT38.StrType s0) := s0;
EXPORT InValid_p_title(SALT38.StrType s) := 0;
EXPORT InValidMessage_p_title(UNSIGNED1 wh) := '';
 
EXPORT Make_p_fname(SALT38.StrType s0) := MakeFT_invalid_bName_fName(s0);
EXPORT InValid_p_fname(SALT38.StrType s,SALT38.StrType company_name,SALT38.StrType p_mname,SALT38.StrType p_lname) := InValidFT_invalid_bName_fName(s,company_name,p_mname,p_lname);
EXPORT InValidMessage_p_fname(UNSIGNED1 wh) := InValidMessageFT_invalid_bName_fName(wh);
 
EXPORT Make_p_mname(SALT38.StrType s0) := MakeFT_invalid_bName_mName(s0);
EXPORT InValid_p_mname(SALT38.StrType s,SALT38.StrType company_name,SALT38.StrType p_fname,SALT38.StrType p_lname) := InValidFT_invalid_bName_mName(s,company_name,p_fname,p_lname);
EXPORT InValidMessage_p_mname(UNSIGNED1 wh) := InValidMessageFT_invalid_bName_mName(wh);
 
EXPORT Make_p_lname(SALT38.StrType s0) := MakeFT_invalid_bName_lName(s0);
EXPORT InValid_p_lname(SALT38.StrType s,SALT38.StrType company_name,SALT38.StrType p_fname,SALT38.StrType p_mname) := InValidFT_invalid_bName_lName(s,company_name,p_fname,p_mname);
EXPORT InValidMessage_p_lname(UNSIGNED1 wh) := InValidMessageFT_invalid_bName_lName(wh);
 
EXPORT Make_p_name_suffix(SALT38.StrType s0) := s0;
EXPORT InValid_p_name_suffix(SALT38.StrType s) := 0;
EXPORT InValidMessage_p_name_suffix(UNSIGNED1 wh) := '';
 
EXPORT Make_raw_aid(SALT38.StrType s0) := MakeFT_invalid_raw_aid(s0);
EXPORT InValid_raw_aid(SALT38.StrType s) := InValidFT_invalid_raw_aid(s);
EXPORT InValidMessage_raw_aid(UNSIGNED1 wh) := InValidMessageFT_invalid_raw_aid(wh);
 
EXPORT Make_ace_aid(SALT38.StrType s0) := MakeFT_invalid_ace_aid(s0);
EXPORT InValid_ace_aid(SALT38.StrType s) := InValidFT_invalid_ace_aid(s);
EXPORT InValidMessage_ace_aid(UNSIGNED1 wh) := InValidMessageFT_invalid_ace_aid(wh);
 
EXPORT Make_prep_addr_line1(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line1(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line1(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_prep_addr_line_last(SALT38.StrType s0) := MakeFT_invalid_mandatory(s0);
EXPORT InValid_prep_addr_line_last(SALT38.StrType s) := InValidFT_invalid_mandatory(s);
EXPORT InValidMessage_prep_addr_line_last(UNSIGNED1 wh) := InValidMessageFT_invalid_mandatory(wh);
 
EXPORT Make_source_rec_id(SALT38.StrType s0) := MakeFT_invalid_numeric(s0);
EXPORT InValid_source_rec_id(SALT38.StrType s) := InValidFT_invalid_numeric(s);
EXPORT InValidMessage_source_rec_id(UNSIGNED1 wh) := InValidMessageFT_invalid_numeric(wh);
 
// This macro will compute and count field level differences based upon a pivot expression
export MAC_CountDifferencesByPivot(in_left,in_right,pivot_exp,bad_pivots,out_counts) := MACRO
  IMPORT SALT38,Scrubs_Experian_CRDB;
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
    BOOLEAN Diff_dotid;
    BOOLEAN Diff_dotscore;
    BOOLEAN Diff_dotweight;
    BOOLEAN Diff_empid;
    BOOLEAN Diff_empscore;
    BOOLEAN Diff_empweight;
    BOOLEAN Diff_powid;
    BOOLEAN Diff_powscore;
    BOOLEAN Diff_powweight;
    BOOLEAN Diff_proxid;
    BOOLEAN Diff_proxscore;
    BOOLEAN Diff_proxweight;
    BOOLEAN Diff_seleid;
    BOOLEAN Diff_selescore;
    BOOLEAN Diff_seleweight;
    BOOLEAN Diff_orgid;
    BOOLEAN Diff_orgscore;
    BOOLEAN Diff_orgweight;
    BOOLEAN Diff_ultid;
    BOOLEAN Diff_ultscore;
    BOOLEAN Diff_ultweight;
    BOOLEAN Diff_bdid;
    BOOLEAN Diff_bdid_score;
    BOOLEAN Diff_did;
    BOOLEAN Diff_dt_first_seen;
    BOOLEAN Diff_dt_last_seen;
    BOOLEAN Diff_dt_vendor_first_reported;
    BOOLEAN Diff_dt_vendor_last_reported;
    BOOLEAN Diff_experian_bus_id;
    BOOLEAN Diff_business_name;
    BOOLEAN Diff_address;
    BOOLEAN Diff_city;
    BOOLEAN Diff_state;
    BOOLEAN Diff_zip_code;
    BOOLEAN Diff_zip_plus_4;
    BOOLEAN Diff_carrier_route;
    BOOLEAN Diff_county_code;
    BOOLEAN Diff_county_name;
    BOOLEAN Diff_phone_number;
    BOOLEAN Diff_msa_code;
    BOOLEAN Diff_msa_description;
    BOOLEAN Diff_establish_date;
    BOOLEAN Diff_latest_reported_date;
    BOOLEAN Diff_years_in_file;
    BOOLEAN Diff_geo_code_latitude;
    BOOLEAN Diff_geo_code_latitude_direction;
    BOOLEAN Diff_geo_code_longitude;
    BOOLEAN Diff_geo_code_longitude_direction;
    BOOLEAN Diff_recent_update_code;
    BOOLEAN Diff_years_in_business_code;
    BOOLEAN Diff_year_business_started;
    BOOLEAN Diff_months_in_file;
    BOOLEAN Diff_address_type_code;
    BOOLEAN Diff_estimated_number_of_employees;
    BOOLEAN Diff_employee_size_code;
    BOOLEAN Diff_estimated_annual_sales_amount_sign;
    BOOLEAN Diff_estimated_annual_sales_amount;
    BOOLEAN Diff_annual_sales_size_code;
    BOOLEAN Diff_location_code;
    BOOLEAN Diff_primary_sic_code_industry_classification;
    BOOLEAN Diff_primary_sic_code_4_digit;
    BOOLEAN Diff_primary_sic_code;
    BOOLEAN Diff_second_sic_code;
    BOOLEAN Diff_third_sic_code;
    BOOLEAN Diff_fourth_sic_code;
    BOOLEAN Diff_fifth_sic_code;
    BOOLEAN Diff_sixth_sic_code;
    BOOLEAN Diff_primary_naics_code;
    BOOLEAN Diff_second_naics_code;
    BOOLEAN Diff_third_naics_code;
    BOOLEAN Diff_fourth_naics_code;
    BOOLEAN Diff_executive_count;
    BOOLEAN Diff_executive_last_name;
    BOOLEAN Diff_executive_first_name;
    BOOLEAN Diff_executive_middle_initial;
    BOOLEAN Diff_executive_title;
    BOOLEAN Diff_business_type;
    BOOLEAN Diff_ownership_code;
    BOOLEAN Diff_url;
    BOOLEAN Diff_derogatory_indicator;
    BOOLEAN Diff_recent_derogatory_filed_date;
    BOOLEAN Diff_derogatory_liability_amount_sign;
    BOOLEAN Diff_derogatory_liability_amount;
    BOOLEAN Diff_ucc_data_indicator;
    BOOLEAN Diff_ucc_count;
    BOOLEAN Diff_number_of_legal_items;
    BOOLEAN Diff_legal_balance_sign;
    BOOLEAN Diff_legal_balance_amount;
    BOOLEAN Diff_pmtkbankruptcy;
    BOOLEAN Diff_pmtkjudgment;
    BOOLEAN Diff_pmtktaxlien;
    BOOLEAN Diff_pmtkpayment;
    BOOLEAN Diff_bankruptcy_filed;
    BOOLEAN Diff_number_of_derogatory_legal_items;
    BOOLEAN Diff_lien_count;
    BOOLEAN Diff_judgment_count;
    BOOLEAN Diff_bkc006;
    BOOLEAN Diff_bkc007;
    BOOLEAN Diff_bkc008;
    BOOLEAN Diff_bko009;
    BOOLEAN Diff_bkb001_sign;
    BOOLEAN Diff_bkb001;
    BOOLEAN Diff_bkb003_sign;
    BOOLEAN Diff_bkb003;
    BOOLEAN Diff_bko010;
    BOOLEAN Diff_bko011;
    BOOLEAN Diff_jdc010;
    BOOLEAN Diff_jdc011;
    BOOLEAN Diff_jdc012;
    BOOLEAN Diff_jdb004;
    BOOLEAN Diff_jdb005;
    BOOLEAN Diff_jdb006;
    BOOLEAN Diff_jDO013;
    BOOLEAN Diff_jDO014;
    BOOLEAN Diff_jdb002;
    BOOLEAN Diff_jdp016;
    BOOLEAN Diff_lgc004;
    BOOLEAN Diff_pro001;
    BOOLEAN Diff_pro003;
    BOOLEAN Diff_txc010;
    BOOLEAN Diff_txc011;
    BOOLEAN Diff_txb004_sign;
    BOOLEAN Diff_txb004;
    BOOLEAN Diff_txo013;
    BOOLEAN Diff_txb002_sign;
    BOOLEAN Diff_txb002;
    BOOLEAN Diff_txp016;
    BOOLEAN Diff_ucc001;
    BOOLEAN Diff_ucc002;
    BOOLEAN Diff_ucc003;
    BOOLEAN Diff_intelliscore_plus;
    BOOLEAN Diff_percentile_model;
    BOOLEAN Diff_model_action;
    BOOLEAN Diff_score_factor_1;
    BOOLEAN Diff_score_factor_2;
    BOOLEAN Diff_score_factor_3;
    BOOLEAN Diff_score_factor_4;
    BOOLEAN Diff_model_code;
    BOOLEAN Diff_model_type;
    BOOLEAN Diff_last_experian_inquiry_date;
    BOOLEAN Diff_recent_high_credit_sign;
    BOOLEAN Diff_recent_high_credit;
    BOOLEAN Diff_median_credit_amount_sign;
    BOOLEAN Diff_median_credit_amount;
    BOOLEAN Diff_total_combined_trade_lines_count;
    BOOLEAN Diff_dbt_of_combined_trade_totals;
    BOOLEAN Diff_combined_trade_balance;
    BOOLEAN Diff_aged_trade_lines;
    BOOLEAN Diff_experian_credit_rating;
    BOOLEAN Diff_quarter_1_average_dbt;
    BOOLEAN Diff_quarter_2_average_dbt;
    BOOLEAN Diff_quarter_3_average_dbt;
    BOOLEAN Diff_quarter_4_average_dbt;
    BOOLEAN Diff_quarter_5_average_dbt;
    BOOLEAN Diff_combined_dbt;
    BOOLEAN Diff_total_account_balance_sign;
    BOOLEAN Diff_total_account_balance;
    BOOLEAN Diff_combined_account_balance_sign;
    BOOLEAN Diff_combined_account_balance;
    BOOLEAN Diff_collection_count;
    BOOLEAN Diff_atc021;
    BOOLEAN Diff_atc022;
    BOOLEAN Diff_atc023;
    BOOLEAN Diff_atc024;
    BOOLEAN Diff_atc025;
    BOOLEAN Diff_last_activity_age_code;
    BOOLEAN Diff_cottage_indicator;
    BOOLEAN Diff_nonprofit_indicator;
    BOOLEAN Diff_financial_stability_risk_score;
    BOOLEAN Diff_fsr_risk_class;
    BOOLEAN Diff_fsr_score_factor_1;
    BOOLEAN Diff_fsr_score_factor_2;
    BOOLEAN Diff_fsr_score_factor_3;
    BOOLEAN Diff_fsr_score_factor_4;
    BOOLEAN Diff_ip_score_change_sign;
    BOOLEAN Diff_ip_score_change;
    BOOLEAN Diff_fsr_score_change_sign;
    BOOLEAN Diff_fsr_score_change;
    BOOLEAN Diff_dba_name;
    BOOLEAN Diff_clean_dba_name;
    BOOLEAN Diff_clean_phone;
    BOOLEAN Diff_prim_range;
    BOOLEAN Diff_predir;
    BOOLEAN Diff_prim_name;
    BOOLEAN Diff_addr_suffix;
    BOOLEAN Diff_postdir;
    BOOLEAN Diff_unit_desig;
    BOOLEAN Diff_sec_range;
    BOOLEAN Diff_p_city_name;
    BOOLEAN Diff_v_city_name;
    BOOLEAN Diff_st;
    BOOLEAN Diff_zip;
    BOOLEAN Diff_zip4;
    BOOLEAN Diff_cart;
    BOOLEAN Diff_cr_sort_sz;
    BOOLEAN Diff_lot;
    BOOLEAN Diff_lot_order;
    BOOLEAN Diff_dbpc;
    BOOLEAN Diff_chk_digit;
    BOOLEAN Diff_rec_type;
    BOOLEAN Diff_fips_state;
    BOOLEAN Diff_fips_county;
    BOOLEAN Diff_geo_lat;
    BOOLEAN Diff_geo_long;
    BOOLEAN Diff_msa;
    BOOLEAN Diff_geo_blk;
    BOOLEAN Diff_geo_match;
    BOOLEAN Diff_err_stat;
    BOOLEAN Diff_recent_update_desc;
    BOOLEAN Diff_years_in_business_desc;
    BOOLEAN Diff_address_type_desc;
    BOOLEAN Diff_employee_size_desc;
    BOOLEAN Diff_annual_sales_size_desc;
    BOOLEAN Diff_location_desc;
    BOOLEAN Diff_primary_sic_code_industry_class_desc;
    BOOLEAN Diff_business_type_desc;
    BOOLEAN Diff_ownership_code_desc;
    BOOLEAN Diff_ucc_data_indicator_desc;
    BOOLEAN Diff_experian_credit_rating_desc;
    BOOLEAN Diff_last_activity_age_desc;
    BOOLEAN Diff_cottage_indicator_desc;
    BOOLEAN Diff_nonprofit_indicator_desc;
    BOOLEAN Diff_company_name;
    BOOLEAN Diff_p_title;
    BOOLEAN Diff_p_fname;
    BOOLEAN Diff_p_mname;
    BOOLEAN Diff_p_lname;
    BOOLEAN Diff_p_name_suffix;
    BOOLEAN Diff_raw_aid;
    BOOLEAN Diff_ace_aid;
    BOOLEAN Diff_prep_addr_line1;
    BOOLEAN Diff_prep_addr_line_last;
    BOOLEAN Diff_source_rec_id;
    UNSIGNED Num_Diffs;
    SALT38.StrType Val {MAXLENGTH(1024)};
  END;
#uniquename(fd)
  %dl% %fd%(in_left le,in_right ri) := TRANSFORM
    SELF.Diff_dotid := le.dotid <> ri.dotid;
    SELF.Diff_dotscore := le.dotscore <> ri.dotscore;
    SELF.Diff_dotweight := le.dotweight <> ri.dotweight;
    SELF.Diff_empid := le.empid <> ri.empid;
    SELF.Diff_empscore := le.empscore <> ri.empscore;
    SELF.Diff_empweight := le.empweight <> ri.empweight;
    SELF.Diff_powid := le.powid <> ri.powid;
    SELF.Diff_powscore := le.powscore <> ri.powscore;
    SELF.Diff_powweight := le.powweight <> ri.powweight;
    SELF.Diff_proxid := le.proxid <> ri.proxid;
    SELF.Diff_proxscore := le.proxscore <> ri.proxscore;
    SELF.Diff_proxweight := le.proxweight <> ri.proxweight;
    SELF.Diff_seleid := le.seleid <> ri.seleid;
    SELF.Diff_selescore := le.selescore <> ri.selescore;
    SELF.Diff_seleweight := le.seleweight <> ri.seleweight;
    SELF.Diff_orgid := le.orgid <> ri.orgid;
    SELF.Diff_orgscore := le.orgscore <> ri.orgscore;
    SELF.Diff_orgweight := le.orgweight <> ri.orgweight;
    SELF.Diff_ultid := le.ultid <> ri.ultid;
    SELF.Diff_ultscore := le.ultscore <> ri.ultscore;
    SELF.Diff_ultweight := le.ultweight <> ri.ultweight;
    SELF.Diff_bdid := le.bdid <> ri.bdid;
    SELF.Diff_bdid_score := le.bdid_score <> ri.bdid_score;
    SELF.Diff_did := le.did <> ri.did;
    SELF.Diff_dt_first_seen := le.dt_first_seen <> ri.dt_first_seen;
    SELF.Diff_dt_last_seen := le.dt_last_seen <> ri.dt_last_seen;
    SELF.Diff_dt_vendor_first_reported := le.dt_vendor_first_reported <> ri.dt_vendor_first_reported;
    SELF.Diff_dt_vendor_last_reported := le.dt_vendor_last_reported <> ri.dt_vendor_last_reported;
    SELF.Diff_experian_bus_id := le.experian_bus_id <> ri.experian_bus_id;
    SELF.Diff_business_name := le.business_name <> ri.business_name;
    SELF.Diff_address := le.address <> ri.address;
    SELF.Diff_city := le.city <> ri.city;
    SELF.Diff_state := le.state <> ri.state;
    SELF.Diff_zip_code := le.zip_code <> ri.zip_code;
    SELF.Diff_zip_plus_4 := le.zip_plus_4 <> ri.zip_plus_4;
    SELF.Diff_carrier_route := le.carrier_route <> ri.carrier_route;
    SELF.Diff_county_code := le.county_code <> ri.county_code;
    SELF.Diff_county_name := le.county_name <> ri.county_name;
    SELF.Diff_phone_number := le.phone_number <> ri.phone_number;
    SELF.Diff_msa_code := le.msa_code <> ri.msa_code;
    SELF.Diff_msa_description := le.msa_description <> ri.msa_description;
    SELF.Diff_establish_date := le.establish_date <> ri.establish_date;
    SELF.Diff_latest_reported_date := le.latest_reported_date <> ri.latest_reported_date;
    SELF.Diff_years_in_file := le.years_in_file <> ri.years_in_file;
    SELF.Diff_geo_code_latitude := le.geo_code_latitude <> ri.geo_code_latitude;
    SELF.Diff_geo_code_latitude_direction := le.geo_code_latitude_direction <> ri.geo_code_latitude_direction;
    SELF.Diff_geo_code_longitude := le.geo_code_longitude <> ri.geo_code_longitude;
    SELF.Diff_geo_code_longitude_direction := le.geo_code_longitude_direction <> ri.geo_code_longitude_direction;
    SELF.Diff_recent_update_code := le.recent_update_code <> ri.recent_update_code;
    SELF.Diff_years_in_business_code := le.years_in_business_code <> ri.years_in_business_code;
    SELF.Diff_year_business_started := le.year_business_started <> ri.year_business_started;
    SELF.Diff_months_in_file := le.months_in_file <> ri.months_in_file;
    SELF.Diff_address_type_code := le.address_type_code <> ri.address_type_code;
    SELF.Diff_estimated_number_of_employees := le.estimated_number_of_employees <> ri.estimated_number_of_employees;
    SELF.Diff_employee_size_code := le.employee_size_code <> ri.employee_size_code;
    SELF.Diff_estimated_annual_sales_amount_sign := le.estimated_annual_sales_amount_sign <> ri.estimated_annual_sales_amount_sign;
    SELF.Diff_estimated_annual_sales_amount := le.estimated_annual_sales_amount <> ri.estimated_annual_sales_amount;
    SELF.Diff_annual_sales_size_code := le.annual_sales_size_code <> ri.annual_sales_size_code;
    SELF.Diff_location_code := le.location_code <> ri.location_code;
    SELF.Diff_primary_sic_code_industry_classification := le.primary_sic_code_industry_classification <> ri.primary_sic_code_industry_classification;
    SELF.Diff_primary_sic_code_4_digit := le.primary_sic_code_4_digit <> ri.primary_sic_code_4_digit;
    SELF.Diff_primary_sic_code := le.primary_sic_code <> ri.primary_sic_code;
    SELF.Diff_second_sic_code := le.second_sic_code <> ri.second_sic_code;
    SELF.Diff_third_sic_code := le.third_sic_code <> ri.third_sic_code;
    SELF.Diff_fourth_sic_code := le.fourth_sic_code <> ri.fourth_sic_code;
    SELF.Diff_fifth_sic_code := le.fifth_sic_code <> ri.fifth_sic_code;
    SELF.Diff_sixth_sic_code := le.sixth_sic_code <> ri.sixth_sic_code;
    SELF.Diff_primary_naics_code := le.primary_naics_code <> ri.primary_naics_code;
    SELF.Diff_second_naics_code := le.second_naics_code <> ri.second_naics_code;
    SELF.Diff_third_naics_code := le.third_naics_code <> ri.third_naics_code;
    SELF.Diff_fourth_naics_code := le.fourth_naics_code <> ri.fourth_naics_code;
    SELF.Diff_executive_count := le.executive_count <> ri.executive_count;
    SELF.Diff_executive_last_name := le.executive_last_name <> ri.executive_last_name;
    SELF.Diff_executive_first_name := le.executive_first_name <> ri.executive_first_name;
    SELF.Diff_executive_middle_initial := le.executive_middle_initial <> ri.executive_middle_initial;
    SELF.Diff_executive_title := le.executive_title <> ri.executive_title;
    SELF.Diff_business_type := le.business_type <> ri.business_type;
    SELF.Diff_ownership_code := le.ownership_code <> ri.ownership_code;
    SELF.Diff_url := le.url <> ri.url;
    SELF.Diff_derogatory_indicator := le.derogatory_indicator <> ri.derogatory_indicator;
    SELF.Diff_recent_derogatory_filed_date := le.recent_derogatory_filed_date <> ri.recent_derogatory_filed_date;
    SELF.Diff_derogatory_liability_amount_sign := le.derogatory_liability_amount_sign <> ri.derogatory_liability_amount_sign;
    SELF.Diff_derogatory_liability_amount := le.derogatory_liability_amount <> ri.derogatory_liability_amount;
    SELF.Diff_ucc_data_indicator := le.ucc_data_indicator <> ri.ucc_data_indicator;
    SELF.Diff_ucc_count := le.ucc_count <> ri.ucc_count;
    SELF.Diff_number_of_legal_items := le.number_of_legal_items <> ri.number_of_legal_items;
    SELF.Diff_legal_balance_sign := le.legal_balance_sign <> ri.legal_balance_sign;
    SELF.Diff_legal_balance_amount := le.legal_balance_amount <> ri.legal_balance_amount;
    SELF.Diff_pmtkbankruptcy := le.pmtkbankruptcy <> ri.pmtkbankruptcy;
    SELF.Diff_pmtkjudgment := le.pmtkjudgment <> ri.pmtkjudgment;
    SELF.Diff_pmtktaxlien := le.pmtktaxlien <> ri.pmtktaxlien;
    SELF.Diff_pmtkpayment := le.pmtkpayment <> ri.pmtkpayment;
    SELF.Diff_bankruptcy_filed := le.bankruptcy_filed <> ri.bankruptcy_filed;
    SELF.Diff_number_of_derogatory_legal_items := le.number_of_derogatory_legal_items <> ri.number_of_derogatory_legal_items;
    SELF.Diff_lien_count := le.lien_count <> ri.lien_count;
    SELF.Diff_judgment_count := le.judgment_count <> ri.judgment_count;
    SELF.Diff_bkc006 := le.bkc006 <> ri.bkc006;
    SELF.Diff_bkc007 := le.bkc007 <> ri.bkc007;
    SELF.Diff_bkc008 := le.bkc008 <> ri.bkc008;
    SELF.Diff_bko009 := le.bko009 <> ri.bko009;
    SELF.Diff_bkb001_sign := le.bkb001_sign <> ri.bkb001_sign;
    SELF.Diff_bkb001 := le.bkb001 <> ri.bkb001;
    SELF.Diff_bkb003_sign := le.bkb003_sign <> ri.bkb003_sign;
    SELF.Diff_bkb003 := le.bkb003 <> ri.bkb003;
    SELF.Diff_bko010 := le.bko010 <> ri.bko010;
    SELF.Diff_bko011 := le.bko011 <> ri.bko011;
    SELF.Diff_jdc010 := le.jdc010 <> ri.jdc010;
    SELF.Diff_jdc011 := le.jdc011 <> ri.jdc011;
    SELF.Diff_jdc012 := le.jdc012 <> ri.jdc012;
    SELF.Diff_jdb004 := le.jdb004 <> ri.jdb004;
    SELF.Diff_jdb005 := le.jdb005 <> ri.jdb005;
    SELF.Diff_jdb006 := le.jdb006 <> ri.jdb006;
    SELF.Diff_jDO013 := le.jDO013 <> ri.jDO013;
    SELF.Diff_jDO014 := le.jDO014 <> ri.jDO014;
    SELF.Diff_jdb002 := le.jdb002 <> ri.jdb002;
    SELF.Diff_jdp016 := le.jdp016 <> ri.jdp016;
    SELF.Diff_lgc004 := le.lgc004 <> ri.lgc004;
    SELF.Diff_pro001 := le.pro001 <> ri.pro001;
    SELF.Diff_pro003 := le.pro003 <> ri.pro003;
    SELF.Diff_txc010 := le.txc010 <> ri.txc010;
    SELF.Diff_txc011 := le.txc011 <> ri.txc011;
    SELF.Diff_txb004_sign := le.txb004_sign <> ri.txb004_sign;
    SELF.Diff_txb004 := le.txb004 <> ri.txb004;
    SELF.Diff_txo013 := le.txo013 <> ri.txo013;
    SELF.Diff_txb002_sign := le.txb002_sign <> ri.txb002_sign;
    SELF.Diff_txb002 := le.txb002 <> ri.txb002;
    SELF.Diff_txp016 := le.txp016 <> ri.txp016;
    SELF.Diff_ucc001 := le.ucc001 <> ri.ucc001;
    SELF.Diff_ucc002 := le.ucc002 <> ri.ucc002;
    SELF.Diff_ucc003 := le.ucc003 <> ri.ucc003;
    SELF.Diff_intelliscore_plus := le.intelliscore_plus <> ri.intelliscore_plus;
    SELF.Diff_percentile_model := le.percentile_model <> ri.percentile_model;
    SELF.Diff_model_action := le.model_action <> ri.model_action;
    SELF.Diff_score_factor_1 := le.score_factor_1 <> ri.score_factor_1;
    SELF.Diff_score_factor_2 := le.score_factor_2 <> ri.score_factor_2;
    SELF.Diff_score_factor_3 := le.score_factor_3 <> ri.score_factor_3;
    SELF.Diff_score_factor_4 := le.score_factor_4 <> ri.score_factor_4;
    SELF.Diff_model_code := le.model_code <> ri.model_code;
    SELF.Diff_model_type := le.model_type <> ri.model_type;
    SELF.Diff_last_experian_inquiry_date := le.last_experian_inquiry_date <> ri.last_experian_inquiry_date;
    SELF.Diff_recent_high_credit_sign := le.recent_high_credit_sign <> ri.recent_high_credit_sign;
    SELF.Diff_recent_high_credit := le.recent_high_credit <> ri.recent_high_credit;
    SELF.Diff_median_credit_amount_sign := le.median_credit_amount_sign <> ri.median_credit_amount_sign;
    SELF.Diff_median_credit_amount := le.median_credit_amount <> ri.median_credit_amount;
    SELF.Diff_total_combined_trade_lines_count := le.total_combined_trade_lines_count <> ri.total_combined_trade_lines_count;
    SELF.Diff_dbt_of_combined_trade_totals := le.dbt_of_combined_trade_totals <> ri.dbt_of_combined_trade_totals;
    SELF.Diff_combined_trade_balance := le.combined_trade_balance <> ri.combined_trade_balance;
    SELF.Diff_aged_trade_lines := le.aged_trade_lines <> ri.aged_trade_lines;
    SELF.Diff_experian_credit_rating := le.experian_credit_rating <> ri.experian_credit_rating;
    SELF.Diff_quarter_1_average_dbt := le.quarter_1_average_dbt <> ri.quarter_1_average_dbt;
    SELF.Diff_quarter_2_average_dbt := le.quarter_2_average_dbt <> ri.quarter_2_average_dbt;
    SELF.Diff_quarter_3_average_dbt := le.quarter_3_average_dbt <> ri.quarter_3_average_dbt;
    SELF.Diff_quarter_4_average_dbt := le.quarter_4_average_dbt <> ri.quarter_4_average_dbt;
    SELF.Diff_quarter_5_average_dbt := le.quarter_5_average_dbt <> ri.quarter_5_average_dbt;
    SELF.Diff_combined_dbt := le.combined_dbt <> ri.combined_dbt;
    SELF.Diff_total_account_balance_sign := le.total_account_balance_sign <> ri.total_account_balance_sign;
    SELF.Diff_total_account_balance := le.total_account_balance <> ri.total_account_balance;
    SELF.Diff_combined_account_balance_sign := le.combined_account_balance_sign <> ri.combined_account_balance_sign;
    SELF.Diff_combined_account_balance := le.combined_account_balance <> ri.combined_account_balance;
    SELF.Diff_collection_count := le.collection_count <> ri.collection_count;
    SELF.Diff_atc021 := le.atc021 <> ri.atc021;
    SELF.Diff_atc022 := le.atc022 <> ri.atc022;
    SELF.Diff_atc023 := le.atc023 <> ri.atc023;
    SELF.Diff_atc024 := le.atc024 <> ri.atc024;
    SELF.Diff_atc025 := le.atc025 <> ri.atc025;
    SELF.Diff_last_activity_age_code := le.last_activity_age_code <> ri.last_activity_age_code;
    SELF.Diff_cottage_indicator := le.cottage_indicator <> ri.cottage_indicator;
    SELF.Diff_nonprofit_indicator := le.nonprofit_indicator <> ri.nonprofit_indicator;
    SELF.Diff_financial_stability_risk_score := le.financial_stability_risk_score <> ri.financial_stability_risk_score;
    SELF.Diff_fsr_risk_class := le.fsr_risk_class <> ri.fsr_risk_class;
    SELF.Diff_fsr_score_factor_1 := le.fsr_score_factor_1 <> ri.fsr_score_factor_1;
    SELF.Diff_fsr_score_factor_2 := le.fsr_score_factor_2 <> ri.fsr_score_factor_2;
    SELF.Diff_fsr_score_factor_3 := le.fsr_score_factor_3 <> ri.fsr_score_factor_3;
    SELF.Diff_fsr_score_factor_4 := le.fsr_score_factor_4 <> ri.fsr_score_factor_4;
    SELF.Diff_ip_score_change_sign := le.ip_score_change_sign <> ri.ip_score_change_sign;
    SELF.Diff_ip_score_change := le.ip_score_change <> ri.ip_score_change;
    SELF.Diff_fsr_score_change_sign := le.fsr_score_change_sign <> ri.fsr_score_change_sign;
    SELF.Diff_fsr_score_change := le.fsr_score_change <> ri.fsr_score_change;
    SELF.Diff_dba_name := le.dba_name <> ri.dba_name;
    SELF.Diff_clean_dba_name := le.clean_dba_name <> ri.clean_dba_name;
    SELF.Diff_clean_phone := le.clean_phone <> ri.clean_phone;
    SELF.Diff_prim_range := le.prim_range <> ri.prim_range;
    SELF.Diff_predir := le.predir <> ri.predir;
    SELF.Diff_prim_name := le.prim_name <> ri.prim_name;
    SELF.Diff_addr_suffix := le.addr_suffix <> ri.addr_suffix;
    SELF.Diff_postdir := le.postdir <> ri.postdir;
    SELF.Diff_unit_desig := le.unit_desig <> ri.unit_desig;
    SELF.Diff_sec_range := le.sec_range <> ri.sec_range;
    SELF.Diff_p_city_name := le.p_city_name <> ri.p_city_name;
    SELF.Diff_v_city_name := le.v_city_name <> ri.v_city_name;
    SELF.Diff_st := le.st <> ri.st;
    SELF.Diff_zip := le.zip <> ri.zip;
    SELF.Diff_zip4 := le.zip4 <> ri.zip4;
    SELF.Diff_cart := le.cart <> ri.cart;
    SELF.Diff_cr_sort_sz := le.cr_sort_sz <> ri.cr_sort_sz;
    SELF.Diff_lot := le.lot <> ri.lot;
    SELF.Diff_lot_order := le.lot_order <> ri.lot_order;
    SELF.Diff_dbpc := le.dbpc <> ri.dbpc;
    SELF.Diff_chk_digit := le.chk_digit <> ri.chk_digit;
    SELF.Diff_rec_type := le.rec_type <> ri.rec_type;
    SELF.Diff_fips_state := le.fips_state <> ri.fips_state;
    SELF.Diff_fips_county := le.fips_county <> ri.fips_county;
    SELF.Diff_geo_lat := le.geo_lat <> ri.geo_lat;
    SELF.Diff_geo_long := le.geo_long <> ri.geo_long;
    SELF.Diff_msa := le.msa <> ri.msa;
    SELF.Diff_geo_blk := le.geo_blk <> ri.geo_blk;
    SELF.Diff_geo_match := le.geo_match <> ri.geo_match;
    SELF.Diff_err_stat := le.err_stat <> ri.err_stat;
    SELF.Diff_recent_update_desc := le.recent_update_desc <> ri.recent_update_desc;
    SELF.Diff_years_in_business_desc := le.years_in_business_desc <> ri.years_in_business_desc;
    SELF.Diff_address_type_desc := le.address_type_desc <> ri.address_type_desc;
    SELF.Diff_employee_size_desc := le.employee_size_desc <> ri.employee_size_desc;
    SELF.Diff_annual_sales_size_desc := le.annual_sales_size_desc <> ri.annual_sales_size_desc;
    SELF.Diff_location_desc := le.location_desc <> ri.location_desc;
    SELF.Diff_primary_sic_code_industry_class_desc := le.primary_sic_code_industry_class_desc <> ri.primary_sic_code_industry_class_desc;
    SELF.Diff_business_type_desc := le.business_type_desc <> ri.business_type_desc;
    SELF.Diff_ownership_code_desc := le.ownership_code_desc <> ri.ownership_code_desc;
    SELF.Diff_ucc_data_indicator_desc := le.ucc_data_indicator_desc <> ri.ucc_data_indicator_desc;
    SELF.Diff_experian_credit_rating_desc := le.experian_credit_rating_desc <> ri.experian_credit_rating_desc;
    SELF.Diff_last_activity_age_desc := le.last_activity_age_desc <> ri.last_activity_age_desc;
    SELF.Diff_cottage_indicator_desc := le.cottage_indicator_desc <> ri.cottage_indicator_desc;
    SELF.Diff_nonprofit_indicator_desc := le.nonprofit_indicator_desc <> ri.nonprofit_indicator_desc;
    SELF.Diff_company_name := le.company_name <> ri.company_name;
    SELF.Diff_p_title := le.p_title <> ri.p_title;
    SELF.Diff_p_fname := le.p_fname <> ri.p_fname;
    SELF.Diff_p_mname := le.p_mname <> ri.p_mname;
    SELF.Diff_p_lname := le.p_lname <> ri.p_lname;
    SELF.Diff_p_name_suffix := le.p_name_suffix <> ri.p_name_suffix;
    SELF.Diff_raw_aid := le.raw_aid <> ri.raw_aid;
    SELF.Diff_ace_aid := le.ace_aid <> ri.ace_aid;
    SELF.Diff_prep_addr_line1 := le.prep_addr_line1 <> ri.prep_addr_line1;
    SELF.Diff_prep_addr_line_last := le.prep_addr_line_last <> ri.prep_addr_line_last;
    SELF.Diff_source_rec_id := le.source_rec_id <> ri.source_rec_id;
    SELF.Val := (SALT38.StrType)evaluate(le,pivot_exp);
    SELF.Num_Diffs := 0+ IF( SELF.Diff_dotid,1,0)+ IF( SELF.Diff_dotscore,1,0)+ IF( SELF.Diff_dotweight,1,0)+ IF( SELF.Diff_empid,1,0)+ IF( SELF.Diff_empscore,1,0)+ IF( SELF.Diff_empweight,1,0)+ IF( SELF.Diff_powid,1,0)+ IF( SELF.Diff_powscore,1,0)+ IF( SELF.Diff_powweight,1,0)+ IF( SELF.Diff_proxid,1,0)+ IF( SELF.Diff_proxscore,1,0)+ IF( SELF.Diff_proxweight,1,0)+ IF( SELF.Diff_seleid,1,0)+ IF( SELF.Diff_selescore,1,0)+ IF( SELF.Diff_seleweight,1,0)+ IF( SELF.Diff_orgid,1,0)+ IF( SELF.Diff_orgscore,1,0)+ IF( SELF.Diff_orgweight,1,0)+ IF( SELF.Diff_ultid,1,0)+ IF( SELF.Diff_ultscore,1,0)+ IF( SELF.Diff_ultweight,1,0)+ IF( SELF.Diff_bdid,1,0)+ IF( SELF.Diff_bdid_score,1,0)+ IF( SELF.Diff_did,1,0)+ IF( SELF.Diff_dt_first_seen,1,0)+ IF( SELF.Diff_dt_last_seen,1,0)+ IF( SELF.Diff_dt_vendor_first_reported,1,0)+ IF( SELF.Diff_dt_vendor_last_reported,1,0)+ IF( SELF.Diff_experian_bus_id,1,0)+ IF( SELF.Diff_business_name,1,0)+ IF( SELF.Diff_address,1,0)+ IF( SELF.Diff_city,1,0)+ IF( SELF.Diff_state,1,0)+ IF( SELF.Diff_zip_code,1,0)+ IF( SELF.Diff_zip_plus_4,1,0)+ IF( SELF.Diff_carrier_route,1,0)+ IF( SELF.Diff_county_code,1,0)+ IF( SELF.Diff_county_name,1,0)+ IF( SELF.Diff_phone_number,1,0)+ IF( SELF.Diff_msa_code,1,0)+ IF( SELF.Diff_msa_description,1,0)+ IF( SELF.Diff_establish_date,1,0)+ IF( SELF.Diff_latest_reported_date,1,0)+ IF( SELF.Diff_years_in_file,1,0)+ IF( SELF.Diff_geo_code_latitude,1,0)+ IF( SELF.Diff_geo_code_latitude_direction,1,0)+ IF( SELF.Diff_geo_code_longitude,1,0)+ IF( SELF.Diff_geo_code_longitude_direction,1,0)+ IF( SELF.Diff_recent_update_code,1,0)+ IF( SELF.Diff_years_in_business_code,1,0)+ IF( SELF.Diff_year_business_started,1,0)+ IF( SELF.Diff_months_in_file,1,0)+ IF( SELF.Diff_address_type_code,1,0)+ IF( SELF.Diff_estimated_number_of_employees,1,0)+ IF( SELF.Diff_employee_size_code,1,0)+ IF( SELF.Diff_estimated_annual_sales_amount_sign,1,0)+ IF( SELF.Diff_estimated_annual_sales_amount,1,0)+ IF( SELF.Diff_annual_sales_size_code,1,0)+ IF( SELF.Diff_location_code,1,0)+ IF( SELF.Diff_primary_sic_code_industry_classification,1,0)+ IF( SELF.Diff_primary_sic_code_4_digit,1,0)+ IF( SELF.Diff_primary_sic_code,1,0)+ IF( SELF.Diff_second_sic_code,1,0)+ IF( SELF.Diff_third_sic_code,1,0)+ IF( SELF.Diff_fourth_sic_code,1,0)+ IF( SELF.Diff_fifth_sic_code,1,0)+ IF( SELF.Diff_sixth_sic_code,1,0)+ IF( SELF.Diff_primary_naics_code,1,0)+ IF( SELF.Diff_second_naics_code,1,0)+ IF( SELF.Diff_third_naics_code,1,0)+ IF( SELF.Diff_fourth_naics_code,1,0)+ IF( SELF.Diff_executive_count,1,0)+ IF( SELF.Diff_executive_last_name,1,0)+ IF( SELF.Diff_executive_first_name,1,0)+ IF( SELF.Diff_executive_middle_initial,1,0)+ IF( SELF.Diff_executive_title,1,0)+ IF( SELF.Diff_business_type,1,0)+ IF( SELF.Diff_ownership_code,1,0)+ IF( SELF.Diff_url,1,0)+ IF( SELF.Diff_derogatory_indicator,1,0)+ IF( SELF.Diff_recent_derogatory_filed_date,1,0)+ IF( SELF.Diff_derogatory_liability_amount_sign,1,0)+ IF( SELF.Diff_derogatory_liability_amount,1,0)+ IF( SELF.Diff_ucc_data_indicator,1,0)+ IF( SELF.Diff_ucc_count,1,0)+ IF( SELF.Diff_number_of_legal_items,1,0)+ IF( SELF.Diff_legal_balance_sign,1,0)+ IF( SELF.Diff_legal_balance_amount,1,0)+ IF( SELF.Diff_pmtkbankruptcy,1,0)+ IF( SELF.Diff_pmtkjudgment,1,0)+ IF( SELF.Diff_pmtktaxlien,1,0)+ IF( SELF.Diff_pmtkpayment,1,0)+ IF( SELF.Diff_bankruptcy_filed,1,0)+ IF( SELF.Diff_number_of_derogatory_legal_items,1,0)+ IF( SELF.Diff_lien_count,1,0)+ IF( SELF.Diff_judgment_count,1,0)+ IF( SELF.Diff_bkc006,1,0)+ IF( SELF.Diff_bkc007,1,0)+ IF( SELF.Diff_bkc008,1,0)+ IF( SELF.Diff_bko009,1,0)+ IF( SELF.Diff_bkb001_sign,1,0)+ IF( SELF.Diff_bkb001,1,0)+ IF( SELF.Diff_bkb003_sign,1,0)+ IF( SELF.Diff_bkb003,1,0)+ IF( SELF.Diff_bko010,1,0)+ IF( SELF.Diff_bko011,1,0)+ IF( SELF.Diff_jdc010,1,0)+ IF( SELF.Diff_jdc011,1,0)+ IF( SELF.Diff_jdc012,1,0)+ IF( SELF.Diff_jdb004,1,0)+ IF( SELF.Diff_jdb005,1,0)+ IF( SELF.Diff_jdb006,1,0)+ IF( SELF.Diff_jDO013,1,0)+ IF( SELF.Diff_jDO014,1,0)+ IF( SELF.Diff_jdb002,1,0)+ IF( SELF.Diff_jdp016,1,0)+ IF( SELF.Diff_lgc004,1,0)+ IF( SELF.Diff_pro001,1,0)+ IF( SELF.Diff_pro003,1,0)+ IF( SELF.Diff_txc010,1,0)+ IF( SELF.Diff_txc011,1,0)+ IF( SELF.Diff_txb004_sign,1,0)+ IF( SELF.Diff_txb004,1,0)+ IF( SELF.Diff_txo013,1,0)+ IF( SELF.Diff_txb002_sign,1,0)+ IF( SELF.Diff_txb002,1,0)+ IF( SELF.Diff_txp016,1,0)+ IF( SELF.Diff_ucc001,1,0)+ IF( SELF.Diff_ucc002,1,0)+ IF( SELF.Diff_ucc003,1,0)+ IF( SELF.Diff_intelliscore_plus,1,0)+ IF( SELF.Diff_percentile_model,1,0)+ IF( SELF.Diff_model_action,1,0)+ IF( SELF.Diff_score_factor_1,1,0)+ IF( SELF.Diff_score_factor_2,1,0)+ IF( SELF.Diff_score_factor_3,1,0)+ IF( SELF.Diff_score_factor_4,1,0)+ IF( SELF.Diff_model_code,1,0)+ IF( SELF.Diff_model_type,1,0)+ IF( SELF.Diff_last_experian_inquiry_date,1,0)+ IF( SELF.Diff_recent_high_credit_sign,1,0)+ IF( SELF.Diff_recent_high_credit,1,0)+ IF( SELF.Diff_median_credit_amount_sign,1,0)+ IF( SELF.Diff_median_credit_amount,1,0)+ IF( SELF.Diff_total_combined_trade_lines_count,1,0)+ IF( SELF.Diff_dbt_of_combined_trade_totals,1,0)+ IF( SELF.Diff_combined_trade_balance,1,0)+ IF( SELF.Diff_aged_trade_lines,1,0)+ IF( SELF.Diff_experian_credit_rating,1,0)+ IF( SELF.Diff_quarter_1_average_dbt,1,0)+ IF( SELF.Diff_quarter_2_average_dbt,1,0)+ IF( SELF.Diff_quarter_3_average_dbt,1,0)+ IF( SELF.Diff_quarter_4_average_dbt,1,0)+ IF( SELF.Diff_quarter_5_average_dbt,1,0)+ IF( SELF.Diff_combined_dbt,1,0)+ IF( SELF.Diff_total_account_balance_sign,1,0)+ IF( SELF.Diff_total_account_balance,1,0)+ IF( SELF.Diff_combined_account_balance_sign,1,0)+ IF( SELF.Diff_combined_account_balance,1,0)+ IF( SELF.Diff_collection_count,1,0)+ IF( SELF.Diff_atc021,1,0)+ IF( SELF.Diff_atc022,1,0)+ IF( SELF.Diff_atc023,1,0)+ IF( SELF.Diff_atc024,1,0)+ IF( SELF.Diff_atc025,1,0)+ IF( SELF.Diff_last_activity_age_code,1,0)+ IF( SELF.Diff_cottage_indicator,1,0)+ IF( SELF.Diff_nonprofit_indicator,1,0)+ IF( SELF.Diff_financial_stability_risk_score,1,0)+ IF( SELF.Diff_fsr_risk_class,1,0)+ IF( SELF.Diff_fsr_score_factor_1,1,0)+ IF( SELF.Diff_fsr_score_factor_2,1,0)+ IF( SELF.Diff_fsr_score_factor_3,1,0)+ IF( SELF.Diff_fsr_score_factor_4,1,0)+ IF( SELF.Diff_ip_score_change_sign,1,0)+ IF( SELF.Diff_ip_score_change,1,0)+ IF( SELF.Diff_fsr_score_change_sign,1,0)+ IF( SELF.Diff_fsr_score_change,1,0)+ IF( SELF.Diff_dba_name,1,0)+ IF( SELF.Diff_clean_dba_name,1,0)+ IF( SELF.Diff_clean_phone,1,0)+ IF( SELF.Diff_prim_range,1,0)+ IF( SELF.Diff_predir,1,0)+ IF( SELF.Diff_prim_name,1,0)+ IF( SELF.Diff_addr_suffix,1,0)+ IF( SELF.Diff_postdir,1,0)+ IF( SELF.Diff_unit_desig,1,0)+ IF( SELF.Diff_sec_range,1,0)+ IF( SELF.Diff_p_city_name,1,0)+ IF( SELF.Diff_v_city_name,1,0)+ IF( SELF.Diff_st,1,0)+ IF( SELF.Diff_zip,1,0)+ IF( SELF.Diff_zip4,1,0)+ IF( SELF.Diff_cart,1,0)+ IF( SELF.Diff_cr_sort_sz,1,0)+ IF( SELF.Diff_lot,1,0)+ IF( SELF.Diff_lot_order,1,0)+ IF( SELF.Diff_dbpc,1,0)+ IF( SELF.Diff_chk_digit,1,0)+ IF( SELF.Diff_rec_type,1,0)+ IF( SELF.Diff_fips_state,1,0)+ IF( SELF.Diff_fips_county,1,0)+ IF( SELF.Diff_geo_lat,1,0)+ IF( SELF.Diff_geo_long,1,0)+ IF( SELF.Diff_msa,1,0)+ IF( SELF.Diff_geo_blk,1,0)+ IF( SELF.Diff_geo_match,1,0)+ IF( SELF.Diff_err_stat,1,0)+ IF( SELF.Diff_recent_update_desc,1,0)+ IF( SELF.Diff_years_in_business_desc,1,0)+ IF( SELF.Diff_address_type_desc,1,0)+ IF( SELF.Diff_employee_size_desc,1,0)+ IF( SELF.Diff_annual_sales_size_desc,1,0)+ IF( SELF.Diff_location_desc,1,0)+ IF( SELF.Diff_primary_sic_code_industry_class_desc,1,0)+ IF( SELF.Diff_business_type_desc,1,0)+ IF( SELF.Diff_ownership_code_desc,1,0)+ IF( SELF.Diff_ucc_data_indicator_desc,1,0)+ IF( SELF.Diff_experian_credit_rating_desc,1,0)+ IF( SELF.Diff_last_activity_age_desc,1,0)+ IF( SELF.Diff_cottage_indicator_desc,1,0)+ IF( SELF.Diff_nonprofit_indicator_desc,1,0)+ IF( SELF.Diff_company_name,1,0)+ IF( SELF.Diff_p_title,1,0)+ IF( SELF.Diff_p_fname,1,0)+ IF( SELF.Diff_p_mname,1,0)+ IF( SELF.Diff_p_lname,1,0)+ IF( SELF.Diff_p_name_suffix,1,0)+ IF( SELF.Diff_raw_aid,1,0)+ IF( SELF.Diff_ace_aid,1,0)+ IF( SELF.Diff_prep_addr_line1,1,0)+ IF( SELF.Diff_prep_addr_line_last,1,0)+ IF( SELF.Diff_source_rec_id,1,0);
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
    Count_Diff_dotid := COUNT(GROUP,%Closest%.Diff_dotid);
    Count_Diff_dotscore := COUNT(GROUP,%Closest%.Diff_dotscore);
    Count_Diff_dotweight := COUNT(GROUP,%Closest%.Diff_dotweight);
    Count_Diff_empid := COUNT(GROUP,%Closest%.Diff_empid);
    Count_Diff_empscore := COUNT(GROUP,%Closest%.Diff_empscore);
    Count_Diff_empweight := COUNT(GROUP,%Closest%.Diff_empweight);
    Count_Diff_powid := COUNT(GROUP,%Closest%.Diff_powid);
    Count_Diff_powscore := COUNT(GROUP,%Closest%.Diff_powscore);
    Count_Diff_powweight := COUNT(GROUP,%Closest%.Diff_powweight);
    Count_Diff_proxid := COUNT(GROUP,%Closest%.Diff_proxid);
    Count_Diff_proxscore := COUNT(GROUP,%Closest%.Diff_proxscore);
    Count_Diff_proxweight := COUNT(GROUP,%Closest%.Diff_proxweight);
    Count_Diff_seleid := COUNT(GROUP,%Closest%.Diff_seleid);
    Count_Diff_selescore := COUNT(GROUP,%Closest%.Diff_selescore);
    Count_Diff_seleweight := COUNT(GROUP,%Closest%.Diff_seleweight);
    Count_Diff_orgid := COUNT(GROUP,%Closest%.Diff_orgid);
    Count_Diff_orgscore := COUNT(GROUP,%Closest%.Diff_orgscore);
    Count_Diff_orgweight := COUNT(GROUP,%Closest%.Diff_orgweight);
    Count_Diff_ultid := COUNT(GROUP,%Closest%.Diff_ultid);
    Count_Diff_ultscore := COUNT(GROUP,%Closest%.Diff_ultscore);
    Count_Diff_ultweight := COUNT(GROUP,%Closest%.Diff_ultweight);
    Count_Diff_bdid := COUNT(GROUP,%Closest%.Diff_bdid);
    Count_Diff_bdid_score := COUNT(GROUP,%Closest%.Diff_bdid_score);
    Count_Diff_did := COUNT(GROUP,%Closest%.Diff_did);
    Count_Diff_dt_first_seen := COUNT(GROUP,%Closest%.Diff_dt_first_seen);
    Count_Diff_dt_last_seen := COUNT(GROUP,%Closest%.Diff_dt_last_seen);
    Count_Diff_dt_vendor_first_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_first_reported);
    Count_Diff_dt_vendor_last_reported := COUNT(GROUP,%Closest%.Diff_dt_vendor_last_reported);
    Count_Diff_experian_bus_id := COUNT(GROUP,%Closest%.Diff_experian_bus_id);
    Count_Diff_business_name := COUNT(GROUP,%Closest%.Diff_business_name);
    Count_Diff_address := COUNT(GROUP,%Closest%.Diff_address);
    Count_Diff_city := COUNT(GROUP,%Closest%.Diff_city);
    Count_Diff_state := COUNT(GROUP,%Closest%.Diff_state);
    Count_Diff_zip_code := COUNT(GROUP,%Closest%.Diff_zip_code);
    Count_Diff_zip_plus_4 := COUNT(GROUP,%Closest%.Diff_zip_plus_4);
    Count_Diff_carrier_route := COUNT(GROUP,%Closest%.Diff_carrier_route);
    Count_Diff_county_code := COUNT(GROUP,%Closest%.Diff_county_code);
    Count_Diff_county_name := COUNT(GROUP,%Closest%.Diff_county_name);
    Count_Diff_phone_number := COUNT(GROUP,%Closest%.Diff_phone_number);
    Count_Diff_msa_code := COUNT(GROUP,%Closest%.Diff_msa_code);
    Count_Diff_msa_description := COUNT(GROUP,%Closest%.Diff_msa_description);
    Count_Diff_establish_date := COUNT(GROUP,%Closest%.Diff_establish_date);
    Count_Diff_latest_reported_date := COUNT(GROUP,%Closest%.Diff_latest_reported_date);
    Count_Diff_years_in_file := COUNT(GROUP,%Closest%.Diff_years_in_file);
    Count_Diff_geo_code_latitude := COUNT(GROUP,%Closest%.Diff_geo_code_latitude);
    Count_Diff_geo_code_latitude_direction := COUNT(GROUP,%Closest%.Diff_geo_code_latitude_direction);
    Count_Diff_geo_code_longitude := COUNT(GROUP,%Closest%.Diff_geo_code_longitude);
    Count_Diff_geo_code_longitude_direction := COUNT(GROUP,%Closest%.Diff_geo_code_longitude_direction);
    Count_Diff_recent_update_code := COUNT(GROUP,%Closest%.Diff_recent_update_code);
    Count_Diff_years_in_business_code := COUNT(GROUP,%Closest%.Diff_years_in_business_code);
    Count_Diff_year_business_started := COUNT(GROUP,%Closest%.Diff_year_business_started);
    Count_Diff_months_in_file := COUNT(GROUP,%Closest%.Diff_months_in_file);
    Count_Diff_address_type_code := COUNT(GROUP,%Closest%.Diff_address_type_code);
    Count_Diff_estimated_number_of_employees := COUNT(GROUP,%Closest%.Diff_estimated_number_of_employees);
    Count_Diff_employee_size_code := COUNT(GROUP,%Closest%.Diff_employee_size_code);
    Count_Diff_estimated_annual_sales_amount_sign := COUNT(GROUP,%Closest%.Diff_estimated_annual_sales_amount_sign);
    Count_Diff_estimated_annual_sales_amount := COUNT(GROUP,%Closest%.Diff_estimated_annual_sales_amount);
    Count_Diff_annual_sales_size_code := COUNT(GROUP,%Closest%.Diff_annual_sales_size_code);
    Count_Diff_location_code := COUNT(GROUP,%Closest%.Diff_location_code);
    Count_Diff_primary_sic_code_industry_classification := COUNT(GROUP,%Closest%.Diff_primary_sic_code_industry_classification);
    Count_Diff_primary_sic_code_4_digit := COUNT(GROUP,%Closest%.Diff_primary_sic_code_4_digit);
    Count_Diff_primary_sic_code := COUNT(GROUP,%Closest%.Diff_primary_sic_code);
    Count_Diff_second_sic_code := COUNT(GROUP,%Closest%.Diff_second_sic_code);
    Count_Diff_third_sic_code := COUNT(GROUP,%Closest%.Diff_third_sic_code);
    Count_Diff_fourth_sic_code := COUNT(GROUP,%Closest%.Diff_fourth_sic_code);
    Count_Diff_fifth_sic_code := COUNT(GROUP,%Closest%.Diff_fifth_sic_code);
    Count_Diff_sixth_sic_code := COUNT(GROUP,%Closest%.Diff_sixth_sic_code);
    Count_Diff_primary_naics_code := COUNT(GROUP,%Closest%.Diff_primary_naics_code);
    Count_Diff_second_naics_code := COUNT(GROUP,%Closest%.Diff_second_naics_code);
    Count_Diff_third_naics_code := COUNT(GROUP,%Closest%.Diff_third_naics_code);
    Count_Diff_fourth_naics_code := COUNT(GROUP,%Closest%.Diff_fourth_naics_code);
    Count_Diff_executive_count := COUNT(GROUP,%Closest%.Diff_executive_count);
    Count_Diff_executive_last_name := COUNT(GROUP,%Closest%.Diff_executive_last_name);
    Count_Diff_executive_first_name := COUNT(GROUP,%Closest%.Diff_executive_first_name);
    Count_Diff_executive_middle_initial := COUNT(GROUP,%Closest%.Diff_executive_middle_initial);
    Count_Diff_executive_title := COUNT(GROUP,%Closest%.Diff_executive_title);
    Count_Diff_business_type := COUNT(GROUP,%Closest%.Diff_business_type);
    Count_Diff_ownership_code := COUNT(GROUP,%Closest%.Diff_ownership_code);
    Count_Diff_url := COUNT(GROUP,%Closest%.Diff_url);
    Count_Diff_derogatory_indicator := COUNT(GROUP,%Closest%.Diff_derogatory_indicator);
    Count_Diff_recent_derogatory_filed_date := COUNT(GROUP,%Closest%.Diff_recent_derogatory_filed_date);
    Count_Diff_derogatory_liability_amount_sign := COUNT(GROUP,%Closest%.Diff_derogatory_liability_amount_sign);
    Count_Diff_derogatory_liability_amount := COUNT(GROUP,%Closest%.Diff_derogatory_liability_amount);
    Count_Diff_ucc_data_indicator := COUNT(GROUP,%Closest%.Diff_ucc_data_indicator);
    Count_Diff_ucc_count := COUNT(GROUP,%Closest%.Diff_ucc_count);
    Count_Diff_number_of_legal_items := COUNT(GROUP,%Closest%.Diff_number_of_legal_items);
    Count_Diff_legal_balance_sign := COUNT(GROUP,%Closest%.Diff_legal_balance_sign);
    Count_Diff_legal_balance_amount := COUNT(GROUP,%Closest%.Diff_legal_balance_amount);
    Count_Diff_pmtkbankruptcy := COUNT(GROUP,%Closest%.Diff_pmtkbankruptcy);
    Count_Diff_pmtkjudgment := COUNT(GROUP,%Closest%.Diff_pmtkjudgment);
    Count_Diff_pmtktaxlien := COUNT(GROUP,%Closest%.Diff_pmtktaxlien);
    Count_Diff_pmtkpayment := COUNT(GROUP,%Closest%.Diff_pmtkpayment);
    Count_Diff_bankruptcy_filed := COUNT(GROUP,%Closest%.Diff_bankruptcy_filed);
    Count_Diff_number_of_derogatory_legal_items := COUNT(GROUP,%Closest%.Diff_number_of_derogatory_legal_items);
    Count_Diff_lien_count := COUNT(GROUP,%Closest%.Diff_lien_count);
    Count_Diff_judgment_count := COUNT(GROUP,%Closest%.Diff_judgment_count);
    Count_Diff_bkc006 := COUNT(GROUP,%Closest%.Diff_bkc006);
    Count_Diff_bkc007 := COUNT(GROUP,%Closest%.Diff_bkc007);
    Count_Diff_bkc008 := COUNT(GROUP,%Closest%.Diff_bkc008);
    Count_Diff_bko009 := COUNT(GROUP,%Closest%.Diff_bko009);
    Count_Diff_bkb001_sign := COUNT(GROUP,%Closest%.Diff_bkb001_sign);
    Count_Diff_bkb001 := COUNT(GROUP,%Closest%.Diff_bkb001);
    Count_Diff_bkb003_sign := COUNT(GROUP,%Closest%.Diff_bkb003_sign);
    Count_Diff_bkb003 := COUNT(GROUP,%Closest%.Diff_bkb003);
    Count_Diff_bko010 := COUNT(GROUP,%Closest%.Diff_bko010);
    Count_Diff_bko011 := COUNT(GROUP,%Closest%.Diff_bko011);
    Count_Diff_jdc010 := COUNT(GROUP,%Closest%.Diff_jdc010);
    Count_Diff_jdc011 := COUNT(GROUP,%Closest%.Diff_jdc011);
    Count_Diff_jdc012 := COUNT(GROUP,%Closest%.Diff_jdc012);
    Count_Diff_jdb004 := COUNT(GROUP,%Closest%.Diff_jdb004);
    Count_Diff_jdb005 := COUNT(GROUP,%Closest%.Diff_jdb005);
    Count_Diff_jdb006 := COUNT(GROUP,%Closest%.Diff_jdb006);
    Count_Diff_jDO013 := COUNT(GROUP,%Closest%.Diff_jDO013);
    Count_Diff_jDO014 := COUNT(GROUP,%Closest%.Diff_jDO014);
    Count_Diff_jdb002 := COUNT(GROUP,%Closest%.Diff_jdb002);
    Count_Diff_jdp016 := COUNT(GROUP,%Closest%.Diff_jdp016);
    Count_Diff_lgc004 := COUNT(GROUP,%Closest%.Diff_lgc004);
    Count_Diff_pro001 := COUNT(GROUP,%Closest%.Diff_pro001);
    Count_Diff_pro003 := COUNT(GROUP,%Closest%.Diff_pro003);
    Count_Diff_txc010 := COUNT(GROUP,%Closest%.Diff_txc010);
    Count_Diff_txc011 := COUNT(GROUP,%Closest%.Diff_txc011);
    Count_Diff_txb004_sign := COUNT(GROUP,%Closest%.Diff_txb004_sign);
    Count_Diff_txb004 := COUNT(GROUP,%Closest%.Diff_txb004);
    Count_Diff_txo013 := COUNT(GROUP,%Closest%.Diff_txo013);
    Count_Diff_txb002_sign := COUNT(GROUP,%Closest%.Diff_txb002_sign);
    Count_Diff_txb002 := COUNT(GROUP,%Closest%.Diff_txb002);
    Count_Diff_txp016 := COUNT(GROUP,%Closest%.Diff_txp016);
    Count_Diff_ucc001 := COUNT(GROUP,%Closest%.Diff_ucc001);
    Count_Diff_ucc002 := COUNT(GROUP,%Closest%.Diff_ucc002);
    Count_Diff_ucc003 := COUNT(GROUP,%Closest%.Diff_ucc003);
    Count_Diff_intelliscore_plus := COUNT(GROUP,%Closest%.Diff_intelliscore_plus);
    Count_Diff_percentile_model := COUNT(GROUP,%Closest%.Diff_percentile_model);
    Count_Diff_model_action := COUNT(GROUP,%Closest%.Diff_model_action);
    Count_Diff_score_factor_1 := COUNT(GROUP,%Closest%.Diff_score_factor_1);
    Count_Diff_score_factor_2 := COUNT(GROUP,%Closest%.Diff_score_factor_2);
    Count_Diff_score_factor_3 := COUNT(GROUP,%Closest%.Diff_score_factor_3);
    Count_Diff_score_factor_4 := COUNT(GROUP,%Closest%.Diff_score_factor_4);
    Count_Diff_model_code := COUNT(GROUP,%Closest%.Diff_model_code);
    Count_Diff_model_type := COUNT(GROUP,%Closest%.Diff_model_type);
    Count_Diff_last_experian_inquiry_date := COUNT(GROUP,%Closest%.Diff_last_experian_inquiry_date);
    Count_Diff_recent_high_credit_sign := COUNT(GROUP,%Closest%.Diff_recent_high_credit_sign);
    Count_Diff_recent_high_credit := COUNT(GROUP,%Closest%.Diff_recent_high_credit);
    Count_Diff_median_credit_amount_sign := COUNT(GROUP,%Closest%.Diff_median_credit_amount_sign);
    Count_Diff_median_credit_amount := COUNT(GROUP,%Closest%.Diff_median_credit_amount);
    Count_Diff_total_combined_trade_lines_count := COUNT(GROUP,%Closest%.Diff_total_combined_trade_lines_count);
    Count_Diff_dbt_of_combined_trade_totals := COUNT(GROUP,%Closest%.Diff_dbt_of_combined_trade_totals);
    Count_Diff_combined_trade_balance := COUNT(GROUP,%Closest%.Diff_combined_trade_balance);
    Count_Diff_aged_trade_lines := COUNT(GROUP,%Closest%.Diff_aged_trade_lines);
    Count_Diff_experian_credit_rating := COUNT(GROUP,%Closest%.Diff_experian_credit_rating);
    Count_Diff_quarter_1_average_dbt := COUNT(GROUP,%Closest%.Diff_quarter_1_average_dbt);
    Count_Diff_quarter_2_average_dbt := COUNT(GROUP,%Closest%.Diff_quarter_2_average_dbt);
    Count_Diff_quarter_3_average_dbt := COUNT(GROUP,%Closest%.Diff_quarter_3_average_dbt);
    Count_Diff_quarter_4_average_dbt := COUNT(GROUP,%Closest%.Diff_quarter_4_average_dbt);
    Count_Diff_quarter_5_average_dbt := COUNT(GROUP,%Closest%.Diff_quarter_5_average_dbt);
    Count_Diff_combined_dbt := COUNT(GROUP,%Closest%.Diff_combined_dbt);
    Count_Diff_total_account_balance_sign := COUNT(GROUP,%Closest%.Diff_total_account_balance_sign);
    Count_Diff_total_account_balance := COUNT(GROUP,%Closest%.Diff_total_account_balance);
    Count_Diff_combined_account_balance_sign := COUNT(GROUP,%Closest%.Diff_combined_account_balance_sign);
    Count_Diff_combined_account_balance := COUNT(GROUP,%Closest%.Diff_combined_account_balance);
    Count_Diff_collection_count := COUNT(GROUP,%Closest%.Diff_collection_count);
    Count_Diff_atc021 := COUNT(GROUP,%Closest%.Diff_atc021);
    Count_Diff_atc022 := COUNT(GROUP,%Closest%.Diff_atc022);
    Count_Diff_atc023 := COUNT(GROUP,%Closest%.Diff_atc023);
    Count_Diff_atc024 := COUNT(GROUP,%Closest%.Diff_atc024);
    Count_Diff_atc025 := COUNT(GROUP,%Closest%.Diff_atc025);
    Count_Diff_last_activity_age_code := COUNT(GROUP,%Closest%.Diff_last_activity_age_code);
    Count_Diff_cottage_indicator := COUNT(GROUP,%Closest%.Diff_cottage_indicator);
    Count_Diff_nonprofit_indicator := COUNT(GROUP,%Closest%.Diff_nonprofit_indicator);
    Count_Diff_financial_stability_risk_score := COUNT(GROUP,%Closest%.Diff_financial_stability_risk_score);
    Count_Diff_fsr_risk_class := COUNT(GROUP,%Closest%.Diff_fsr_risk_class);
    Count_Diff_fsr_score_factor_1 := COUNT(GROUP,%Closest%.Diff_fsr_score_factor_1);
    Count_Diff_fsr_score_factor_2 := COUNT(GROUP,%Closest%.Diff_fsr_score_factor_2);
    Count_Diff_fsr_score_factor_3 := COUNT(GROUP,%Closest%.Diff_fsr_score_factor_3);
    Count_Diff_fsr_score_factor_4 := COUNT(GROUP,%Closest%.Diff_fsr_score_factor_4);
    Count_Diff_ip_score_change_sign := COUNT(GROUP,%Closest%.Diff_ip_score_change_sign);
    Count_Diff_ip_score_change := COUNT(GROUP,%Closest%.Diff_ip_score_change);
    Count_Diff_fsr_score_change_sign := COUNT(GROUP,%Closest%.Diff_fsr_score_change_sign);
    Count_Diff_fsr_score_change := COUNT(GROUP,%Closest%.Diff_fsr_score_change);
    Count_Diff_dba_name := COUNT(GROUP,%Closest%.Diff_dba_name);
    Count_Diff_clean_dba_name := COUNT(GROUP,%Closest%.Diff_clean_dba_name);
    Count_Diff_clean_phone := COUNT(GROUP,%Closest%.Diff_clean_phone);
    Count_Diff_prim_range := COUNT(GROUP,%Closest%.Diff_prim_range);
    Count_Diff_predir := COUNT(GROUP,%Closest%.Diff_predir);
    Count_Diff_prim_name := COUNT(GROUP,%Closest%.Diff_prim_name);
    Count_Diff_addr_suffix := COUNT(GROUP,%Closest%.Diff_addr_suffix);
    Count_Diff_postdir := COUNT(GROUP,%Closest%.Diff_postdir);
    Count_Diff_unit_desig := COUNT(GROUP,%Closest%.Diff_unit_desig);
    Count_Diff_sec_range := COUNT(GROUP,%Closest%.Diff_sec_range);
    Count_Diff_p_city_name := COUNT(GROUP,%Closest%.Diff_p_city_name);
    Count_Diff_v_city_name := COUNT(GROUP,%Closest%.Diff_v_city_name);
    Count_Diff_st := COUNT(GROUP,%Closest%.Diff_st);
    Count_Diff_zip := COUNT(GROUP,%Closest%.Diff_zip);
    Count_Diff_zip4 := COUNT(GROUP,%Closest%.Diff_zip4);
    Count_Diff_cart := COUNT(GROUP,%Closest%.Diff_cart);
    Count_Diff_cr_sort_sz := COUNT(GROUP,%Closest%.Diff_cr_sort_sz);
    Count_Diff_lot := COUNT(GROUP,%Closest%.Diff_lot);
    Count_Diff_lot_order := COUNT(GROUP,%Closest%.Diff_lot_order);
    Count_Diff_dbpc := COUNT(GROUP,%Closest%.Diff_dbpc);
    Count_Diff_chk_digit := COUNT(GROUP,%Closest%.Diff_chk_digit);
    Count_Diff_rec_type := COUNT(GROUP,%Closest%.Diff_rec_type);
    Count_Diff_fips_state := COUNT(GROUP,%Closest%.Diff_fips_state);
    Count_Diff_fips_county := COUNT(GROUP,%Closest%.Diff_fips_county);
    Count_Diff_geo_lat := COUNT(GROUP,%Closest%.Diff_geo_lat);
    Count_Diff_geo_long := COUNT(GROUP,%Closest%.Diff_geo_long);
    Count_Diff_msa := COUNT(GROUP,%Closest%.Diff_msa);
    Count_Diff_geo_blk := COUNT(GROUP,%Closest%.Diff_geo_blk);
    Count_Diff_geo_match := COUNT(GROUP,%Closest%.Diff_geo_match);
    Count_Diff_err_stat := COUNT(GROUP,%Closest%.Diff_err_stat);
    Count_Diff_recent_update_desc := COUNT(GROUP,%Closest%.Diff_recent_update_desc);
    Count_Diff_years_in_business_desc := COUNT(GROUP,%Closest%.Diff_years_in_business_desc);
    Count_Diff_address_type_desc := COUNT(GROUP,%Closest%.Diff_address_type_desc);
    Count_Diff_employee_size_desc := COUNT(GROUP,%Closest%.Diff_employee_size_desc);
    Count_Diff_annual_sales_size_desc := COUNT(GROUP,%Closest%.Diff_annual_sales_size_desc);
    Count_Diff_location_desc := COUNT(GROUP,%Closest%.Diff_location_desc);
    Count_Diff_primary_sic_code_industry_class_desc := COUNT(GROUP,%Closest%.Diff_primary_sic_code_industry_class_desc);
    Count_Diff_business_type_desc := COUNT(GROUP,%Closest%.Diff_business_type_desc);
    Count_Diff_ownership_code_desc := COUNT(GROUP,%Closest%.Diff_ownership_code_desc);
    Count_Diff_ucc_data_indicator_desc := COUNT(GROUP,%Closest%.Diff_ucc_data_indicator_desc);
    Count_Diff_experian_credit_rating_desc := COUNT(GROUP,%Closest%.Diff_experian_credit_rating_desc);
    Count_Diff_last_activity_age_desc := COUNT(GROUP,%Closest%.Diff_last_activity_age_desc);
    Count_Diff_cottage_indicator_desc := COUNT(GROUP,%Closest%.Diff_cottage_indicator_desc);
    Count_Diff_nonprofit_indicator_desc := COUNT(GROUP,%Closest%.Diff_nonprofit_indicator_desc);
    Count_Diff_company_name := COUNT(GROUP,%Closest%.Diff_company_name);
    Count_Diff_p_title := COUNT(GROUP,%Closest%.Diff_p_title);
    Count_Diff_p_fname := COUNT(GROUP,%Closest%.Diff_p_fname);
    Count_Diff_p_mname := COUNT(GROUP,%Closest%.Diff_p_mname);
    Count_Diff_p_lname := COUNT(GROUP,%Closest%.Diff_p_lname);
    Count_Diff_p_name_suffix := COUNT(GROUP,%Closest%.Diff_p_name_suffix);
    Count_Diff_raw_aid := COUNT(GROUP,%Closest%.Diff_raw_aid);
    Count_Diff_ace_aid := COUNT(GROUP,%Closest%.Diff_ace_aid);
    Count_Diff_prep_addr_line1 := COUNT(GROUP,%Closest%.Diff_prep_addr_line1);
    Count_Diff_prep_addr_line_last := COUNT(GROUP,%Closest%.Diff_prep_addr_line_last);
    Count_Diff_source_rec_id := COUNT(GROUP,%Closest%.Diff_source_rec_id);
  END;
  out_counts := table(%Closest%,%AggRec%,true);
ENDMACRO;
END;
