﻿// Machine-readable versions of the spec file and subsets thereof
EXPORT Base_GenerationMod := MODULE
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.8.0';
  EXPORT salt_MODULE := 'SALT38'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_Experian_CRDB';
  EXPORT spc_NAMESCOPE := 'Base';
  EXPORT spc_PROCESS := '';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
 
  // The entire spec file
  EXPORT spcString :=
    'OPTIONS:-gh\n'
    + 'MODULE:Scrubs_Experian_CRDB\n'
    + 'FILENAME:Experian_CRDB\n'
    + 'NAMESCOPE:Base\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9%, 2 = 99% etc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + '//FIELDTYPE statements can be used to clean up (or check the cleaning) of individual fields\n'
    + '//BESTTYPE statements declare methods of generating the best value for a given cluster; this can also improve linking\n'
    + '//FUZZY can be used to create new types of FUZZY linking\n'
    + 'FIELDTYPE:invalid_mandatory:CUSTOM(Scrubs_Experian_CRDB.functions.fn_chk_blanks>0)\n'
    + 'FIELDTYPE:invalid_alphaHyphen:ALLOW( -ABCDEFGHIJKLMNOPQRSTUVWXYZ)   \n'
    + 'FIELDTYPE:invalid_numericPeriod:ALLOW(.0123456789)  \n'
    + 'FIELDTYPE:invalid_zero_blank:ENUM(0|)\n'
    + 'FIELDTYPE:invalid_model_action:ENUM(MEDIUM RISK|LOW-MEDIUM RISK|LOW RISK|MEDIUM-HIGH RISK|HIGH RISK|INSUFFICIENT DATA TO SCORE|RECENT BANKRUPTCY ON FILE)\n'
    + 'FIELDTYPE:invalid_numeric:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_experian_bus_id:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0,9)\n'
    + 'FIELDTYPE:invalid_percentage:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_range_numeric>0,0,100)\n'
    + 'FIELDTYPE:invalid_sic_codes:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_sic_code>0) \n'
    + 'FIELDTYPE:invalid_naics_codes:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_naics_code>0) \n'
    + 'FIELDTYPE:invalid_pastdate:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_past_yyyymmdd>0)\n'
    + 'FIELDTYPE:invalid_boolean:ENUM(Y|N|)\n'
    + 'FIELDTYPE:invalid_sign:ENUM(+|-|I|B|)\n'
    + 'FIELDTYPE:invalid_state:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_verify_state>0)   \n'
    + 'FIELDTYPE:invalid_zip:CUSTOM(Scrubs_Experian_CRDB.functions.fn_verify_zip5>0)\n'
    + 'FIELDTYPE:invalid_zip4:CUSTOM(Scrubs_Experian_CRDB.functions.fn_verify_zip4>0) \n'
    + 'FIELDTYPE:invalid_phone:CUSTOM(Scrubs_Experian_CRDB.functions.fn_CleanPhone>0)                                   \n'
    + 'FIELDTYPE:invalid_first_name:CUSTOM(Scrubs_Experian_CRDB.functions.fn_chk_people_names>0,p_mname,p_lname)\n'
    + 'FIELDTYPE:invalid_mid_name:CUSTOM(Scrubs_Experian_CRDB.functions.fn_chk_people_names>0,p_fname,p_lname)\n'
    + 'FIELDTYPE:invalid_last_name:CUSTOM(Scrubs_Experian_CRDB.functions.fn_chk_people_names>0,p_fname,p_mname)   \n'
    + 'FIELDTYPE:invalid_business_name:CUSTOM(Scrubs_Experian_CRDB.functions.fn_chk_blanks>0)                            \n'
    + 'FIELDTYPE:invalid_carrier_route:ALLOW(0123456789BCGHR)\n'
    + 'FIELDTYPE:invalid_Experian_Credit_Rating:ALLOW(01234567) \n'
    + 'FIELDTYPE:invalid_geo_code_latitude_direction:ALLOW(NS)                                           \n'
    + 'FIELDTYPE:invalid_geo_code_longitude_direction:ALLOW(WE)                                           \n'
    + 'FIELDTYPE:invalid_recent_update_code:Enum(A|B|C|)                                          \n'
    + 'FIELDTYPE:invalid_years_in_business_code:ALLOW(ABCDEF)\n'
    + 'FIELDTYPE:invalid_address_type_code:ALLOW(FGHMPRS)                                         \n'
    + 'FIELDTYPE:invalid_employee_size_code:ALLOW(ABCDEFGHI)                                      \n'
    + 'FIELDTYPE:invalid_annual_Sales_Size_Code:Enum(A|B|C|D|E|F|G|H|I|J|K|)                                \n'
    + 'FIELDTYPE:invalid_location_code:Enum(B|H|S|)                                          \n'
    + 'FIELDTYPE:invalid_primary_sic_code_industry_classification:Enum(A|B|C|D|E|F|G|H|I|J|K|)                                        \n'
    + 'FIELDTYPE:invalid_executive_count:ALLOW(01)                                       \n'
    + 'FIELDTYPE:invalid_business_type:ALLOW(CGPS)                                           \n'
    + 'FIELDTYPE:invalid_ownership_code:ALLOW(01)                                    \n'
    + 'FIELDTYPE:invalid_derogatory_indicator:ALLOW(CNY)                                    \n'
    + 'FIELDTYPE:invalid_ucc_data_indicator:ALLOW(DNY)                                                                          \n'
    + 'FIELDTYPE:invalid_model_type:ALLOW(1)                                    \n'
    + 'FIELDTYPE:invalid_aged_trade_lines:ALLOW(0)                                          \n'
    + 'FIELDTYPE:invalid_last_activity_age_code:ALLOW(ABCDEFGHIJKLMNO) \n'
    + 'FIELDTYPE:invalid_nonprofit_indicator:ALLOW(NPU)                                      \n'
    + 'FIELDTYPE:invalid_fsr_risk_class:ALLOW(-12345)                                                                                  \n'
    + 'FIELDTYPE:invalid_cart:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_alphanumeric>0,4)\n'
    + 'FIELDTYPE:invalid_cr_sort_sz:ENUM(B|C|D|)\n'
    + 'FIELDTYPE:invalid_lot:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0,4)\n'
    + 'FIELDTYPE:invalid_lot_order:ENUM(A|D|)\n'
    + 'FIELDTYPE:invalid_dpbc:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0,2)\n'
    + 'FIELDTYPE:invalid_chk_digit:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0,1)\n'
    + 'FIELDTYPE:invalid_fips_state:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0,2)\n'
    + 'FIELDTYPE:invalid_fips_county:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0,3)\n'
    + 'FIELDTYPE:invalid_geo:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_geo_coord>0)\n'
    + 'FIELDTYPE:invalid_msa:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0,4)\n'
    + 'FIELDTYPE:invalid_geo_match:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0,1)\n'
    + 'FIELDTYPE:invalid_err_stat:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_alphanumeric>0,4)\n'
    + 'FIELDTYPE:invalid_raw_aid:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_ace_aid:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_numeric>0)\n'
    + 'FIELDTYPE:invalid_direction:ALLOW(ENSW)\n'
    + 'FIELDTYPE:invalid_year:CUSTOM(Scrubs_Experian_CRDB.Functions.fn_valid_year>0)\n'
    + 'FIELDTYPE:invalid_clean_dba_name:CUSTOM(Scrubs_Experian_CRDB.functions.fn_clean_dba_name>0,dba_name) \n'
    + 'FIELDTYPE:invalid_bName_pName:CUSTOM(Scrubs_Experian_CRDB.functions.fn_bName_pName>0,p_fname,p_mname,p_lname) \n'
    + 'FIELDTYPE:invalid_bName_fName:CUSTOM(Scrubs_Experian_CRDB.functions.fn_bName_pName>0,company_name,p_mname,p_lname) \n'
    + 'FIELDTYPE:invalid_bName_mName:CUSTOM(Scrubs_Experian_CRDB.functions.fn_bName_pName>0,company_name,p_fname,p_lname) \n'
    + 'FIELDTYPE:invalid_bName_lName:CUSTOM(Scrubs_Experian_CRDB.functions.fn_bName_pName>0,company_name,p_fname,p_mname) \n'
    + '\n'
    + 'FIELD:dotid:TYPE(UNSIGNED6):LIKE(invalid_zero_blank):0,0\n'
    + 'FIELD:dotscore:TYPE(UNSIGNED2):LIKE(invalid_zero_blank):0,0\n'
    + 'FIELD:dotweight:TYPE(UNSIGNED2):LIKE(invalid_zero_blank):0,0\n'
    + 'FIELD:empid:TYPE(UNSIGNED6):LIKE(invalid_zero_blank):0,0\n'
    + 'FIELD:empscore:TYPE(UNSIGNED2):LIKE(invalid_zero_blank):0,0\n'
    + 'FIELD:empweight:TYPE(UNSIGNED2):LIKE(invalid_zero_blank):0,0\n'
    + 'FIELD:powid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:powscore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:powweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:proxid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:proxscore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:proxweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:seleid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:selescore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:seleweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:orgid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:orgscore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:orgweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:ultid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:ultscore:TYPE(UNSIGNED2):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:ultweight:TYPE(UNSIGNED2):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:bdid:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:bdid_score:TYPE(UNSIGNED1):LIKE(invalid_percentage):0,0\n'
    + 'FIELD:did:TYPE(UNSIGNED6):LIKE(invalid_numeric):0,0\n'
    + 'FIELD:dt_first_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_last_seen:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_vendor_first_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:dt_vendor_last_reported:TYPE(UNSIGNED4):LIKE(invalid_pastdate):0,0\n'
    + 'FIELD:experian_bus_id:LIKE(invalid_experian_bus_id):TYPE(STRING9):0,0\n'
    + 'FIELD:business_name:LIKE(invalid_business_name):TYPE(STRING120):0,0 \n'
    + 'FIELD:address:LIKE(invalid_mandatory):TYPE(STRING60):0,0\n'
    + 'FIELD:city:LIKE(invalid_mandatory):TYPE(STRING40):0,0\n'
    + 'FIELD:state:LIKE(invalid_state):TYPE(STRING2):0,0\n'
    + 'FIELD:zip_code:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + 'FIELD:zip_plus_4:TYPE(STRING4):LIKE(invalid_zip4):0,0\n'
    + 'FIELD:carrier_route:LIKE(invalid_carrier_route):TYPE(STRING4):0,0\n'
    + 'FIELD:county_code:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:county_name:LIKE(invalid_alphaHyphen):TYPE(STRING30):0,0\n'
    + 'FIELD:phone_number:LIKE(invalid_phone):TYPE(STRING10):0,0\n'
    + 'FIELD:msa_code:LIKE(invalid_numeric):TYPE(STRING4):0,0\n'
    + 'FIELD:msa_description:TYPE(STRING50):0,0\n'
    + 'FIELD:establish_date:LIKE(invalid_pastdate):TYPE(STRING8):0,0\n'
    + 'FIELD:latest_reported_date:LIKE(invalid_pastdate):TYPE(STRING8):0,0\n'
    + 'FIELD:years_in_file:LIKE(invalid_numeric):TYPE(STRING2):0,0\n'
    + 'FIELD:geo_code_latitude:LIKE(invalid_numericPeriod):TYPE(STRING10):0,0\n'
    + 'FIELD:geo_code_latitude_direction:LIKE(invalid_geo_code_latitude_direction):TYPE(STRING1):0,0\n'
    + 'FIELD:geo_code_longitude:LIKE(invalid_numericPeriod):TYPE(STRING10):0,0\n'
    + 'FIELD:geo_code_longitude_direction:LIKE(invalid_geo_code_longitude_direction):TYPE(STRING1):0,0\n'
    + 'FIELD:recent_update_code:LIKE(invalid_recent_update_code):TYPE(STRING1):0,0\n'
    + 'FIELD:years_in_business_code:LIKE(invalid_years_in_business_code):TYPE(STRING1):0,0\n'
    + 'FIELD:year_business_started:LIKE(invalid_year):TYPE(STRING4):0,0\n'
    + 'FIELD:months_in_file:LIKE(invalid_numeric):TYPE(STRING4):0,0\n'
    + 'FIELD:address_type_code:LIKE(invalid_address_type_code):TYPE(STRING1):0,0\n'
    + 'FIELD:estimated_number_of_employees:LIKE(invalid_numeric):TYPE(STRING7):0,0\n'
    + 'FIELD:employee_size_code:LIKE(invalid_employee_size_code):TYPE(STRING1):0,0\n'
    + 'FIELD:estimated_annual_sales_amount_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:estimated_annual_sales_amount:LIKE(invalid_numeric):TYPE(STRING8):0,0\n'
    + 'FIELD:annual_sales_size_code:LIKE(invalid_annual_sales_size_code):TYPE(STRING1):0,0\n'
    + 'FIELD:location_code:LIKE(invalid_location_code):TYPE(STRING1):0,0\n'
    + 'FIELD:primary_sic_code_industry_classification:LIKE(invalid_primary_sic_code_industry_classification):TYPE(STRING1):0,0\n'
    + 'FIELD:primary_sic_code_4_digit:LIKE(invalid_sic_codes):TYPE(STRING4):0,0\n'
    + 'FIELD:primary_sic_code:LIKE(invalid_sic_codes):TYPE(STRING8):0,0\n'
    + 'FIELD:second_sic_code:LIKE(invalid_sic_codes):TYPE(STRING8):0,0\n'
    + 'FIELD:third_sic_code:LIKE(invalid_sic_codes):TYPE(STRING8):0,0\n'
    + 'FIELD:fourth_sic_code:LIKE(invalid_sic_codes):TYPE(STRING8):0,0\n'
    + 'FIELD:fifth_sic_code:LIKE(invalid_sic_codes):TYPE(STRING8):0,0\n'
    + 'FIELD:sixth_sic_code:LIKE(invalid_sic_codes):TYPE(STRING8):0,0\n'
    + 'FIELD:primary_naics_code:LIKE(invalid_naics_codes):TYPE(STRING6):0,0\n'
    + 'FIELD:second_naics_code:LIKE(invalid_naics_codes):TYPE(STRING6):0,0\n'
    + 'FIELD:third_naics_code:LIKE(invalid_naics_codes):TYPE(STRING6):0,0\n'
    + 'FIELD:fourth_naics_code:LIKE(invalid_naics_codes):TYPE(STRING6):0,0\n'
    + 'FIELD:executive_count:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:executive_last_name:TYPE(STRING20):0,0\n'
    + 'FIELD:executive_first_name:TYPE(STRING10):0,0\n'
    + 'FIELD:executive_middle_initial:TYPE(STRING1):0,0\n'
    + 'FIELD:executive_title:TYPE(STRING10):0,0\n'
    + 'FIELD:business_type:LIKE(invalid_business_type):TYPE(STRING1):0,0\n'
    + 'FIELD:ownership_code:LIKE(invalid_ownership_code):TYPE(STRING1):0,0\n'
    + 'FIELD:url:TYPE(STRING50):0,0\n'
    + 'FIELD:derogatory_indicator:LIKE(invalid_derogatory_indicator):TYPE(STRING1):0,0\n'
    + 'FIELD:recent_derogatory_filed_date:LIKE(invalid_pastdate):TYPE(STRING8):0,0\n'
    + 'FIELD:derogatory_liability_amount_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:derogatory_liability_amount:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:ucc_data_indicator:LIKE(invalid_ucc_data_indicator):TYPE(STRING1):0,0\n'
    + 'FIELD:ucc_count:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:number_of_legal_items:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:legal_balance_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:legal_balance_amount:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:pmtkbankruptcy:LIKE(invalid_boolean):TYPE(STRING1):0,0\n'
    + 'FIELD:pmtkjudgment:LIKE(invalid_boolean):TYPE(STRING1):0,0\n'
    + 'FIELD:pmtktaxlien:LIKE(invalid_boolean):TYPE(STRING1):0,0\n'
    + 'FIELD:pmtkpayment:LIKE(invalid_boolean):TYPE(STRING1):0,0\n'
    + 'FIELD:bankruptcy_filed:LIKE(invalid_boolean):TYPE(STRING1):0,0\n'
    + 'FIELD:number_of_derogatory_legal_items:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:lien_count:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:judgment_count:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:bkc006:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:bkc007:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:bkc008:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:bko009:LIKE(invalid_numeric):TYPE(STRING1):0,0\n'
    + 'FIELD:bkb001_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:bkb001:LIKE(invalid_numeric):TYPE(STRING11):0,0\n'
    + 'FIELD:bkb003_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:bkb003:LIKE(invalid_numeric):TYPE(STRING11):0,0\n'
    + 'FIELD:bko010:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:bko011:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:jdc010:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:jdc011:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:jdc012:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:jdb004:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:jdb005:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:jdb006:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:jDO013:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:jDO014:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:jdb002:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:jdp016:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:lgc004:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:pro001:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:pro003:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:txc010:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:txc011:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:txb004_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:txb004:LIKE(invalid_numeric):TYPE(STRING11):0,0\n'
    + 'FIELD:txo013:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:txb002_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:txb002:LIKE(invalid_numeric):TYPE(STRING11):0,0\n'
    + 'FIELD:txp016:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:ucc001:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:ucc002:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:ucc003:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:intelliscore_plus:LIKE(invalid_numeric):TYPE(STRING8):0,0\n'
    + 'FIELD:percentile_model:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:model_action:LIKE(invalid_model_action):TYPE(STRING30):0,0\n'
    + 'FIELD:score_factor_1:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:score_factor_2:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:score_factor_3:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:score_factor_4:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:model_code:TYPE(STRING6):0,0\n'
    + 'FIELD:model_type:LIKE(invalid_model_type):TYPE(STRING1):0,0\n'
    + 'FIELD:last_experian_inquiry_date:LIKE(invalid_pastdate):TYPE(STRING8):0,0\n'
    + 'FIELD:recent_high_credit_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:recent_high_credit:LIKE(invalid_numeric):TYPE(STRING9):0,0\n'
    + 'FIELD:median_credit_amount_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:median_credit_amount:LIKE(invalid_numeric):TYPE(STRING9):0,0\n'
    + 'FIELD:total_combined_trade_lines_count:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:dbt_of_combined_trade_totals:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:combined_trade_balance:LIKE(invalid_numeric):TYPE(STRING9):0,0\n'
    + 'FIELD:aged_trade_lines:LIKE(invalid_aged_trade_lines):TYPE(STRING5):0,0\n'
    + 'FIELD:experian_credit_rating:LIKE(invalid_Experian_Credit_Rating):TYPE(STRING1):0,0\n'
    + 'FIELD:quarter_1_average_dbt:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:quarter_2_average_dbt:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:quarter_3_average_dbt:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:quarter_4_average_dbt:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:quarter_5_average_dbt:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:combined_dbt:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:total_account_balance_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:total_account_balance:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:combined_account_balance_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:combined_account_balance:LIKE(invalid_numeric):TYPE(STRING10):0,0\n'
    + 'FIELD:collection_count:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:atc021:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:atc022:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:atc023:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:atc024:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:atc025:LIKE(invalid_numeric):TYPE(STRING5):0,0\n'
    + 'FIELD:last_activity_age_code:LIKE(invalid_last_activity_age_code):TYPE(STRING1):0,0\n'
    + 'FIELD:cottage_indicator:LIKE(invalid_boolean):TYPE(STRING1):0,0\n'
    + 'FIELD:nonprofit_indicator:LIKE(invalid_nonprofit_indicator):TYPE(STRING1):0,0\n'
    + 'FIELD:financial_stability_risk_score:LIKE(invalid_numeric):TYPE(STRING8):0,0\n'
    + 'FIELD:fsr_risk_class:LIKE(invalid_fsr_risk_class):TYPE(STRING1):0,0\n'
    + 'FIELD:fsr_score_factor_1:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:fsr_score_factor_2:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:fsr_score_factor_3:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:fsr_score_factor_4:LIKE(invalid_numeric):TYPE(STRING3):0,0\n'
    + 'FIELD:ip_score_change_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:ip_score_change:LIKE(invalid_numeric):TYPE(STRING2):0,0\n'
    + 'FIELD:fsr_score_change_sign:LIKE(invalid_sign):TYPE(STRING1):0,0\n'
    + 'FIELD:fsr_score_change:LIKE(invalid_numeric):TYPE(STRING2):0,0\n'
    + 'FIELD:dba_name:TYPE(STRING122):0,0\n'
    + 'FIELD:clean_dba_name:LIKE(invalid_clean_dba_name):TYPE(STRING122):0,0\n'
    + 'FIELD:clean_phone:TYPE(STRING10):0,0\n'
    + 'FIELD:prim_range:TYPE(STRING10):0,0\n'
    + 'FIELD:predir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:prim_name:TYPE(STRING28):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:addr_suffix:TYPE(STRING4):0,0\n'
    + 'FIELD:postdir:TYPE(STRING2):LIKE(invalid_direction):0,0\n'
    + 'FIELD:unit_desig:TYPE(STRING10):0,0\n'
    + 'FIELD:sec_range:TYPE(STRING8):0,0\n'
    + 'FIELD:p_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:v_city_name:TYPE(STRING25):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:st:TYPE(STRING2):LIKE(invalid_state):0,0\n'
    + 'FIELD:zip:TYPE(STRING5):LIKE(invalid_zip):0,0\n'
    + 'FIELD:zip4:TYPE(STRING4):LIKE(invalid_zip4):0,0\n'
    + 'FIELD:cart:TYPE(STRING4):LIKE(invalid_cart):0,0\n'
    + 'FIELD:cr_sort_sz:TYPE(STRING1):LIKE(invalid_cr_sort_sz):0,0\n'
    + 'FIELD:lot:TYPE(STRING4):LIKE(invalid_lot):0,0\n'
    + 'FIELD:lot_order:TYPE(STRING1):LIKE(invalid_lot_order):0,0\n'
    + 'FIELD:dbpc:TYPE(STRING2):LIKE(invalid_dpbc):0,0\n'
    + 'FIELD:chk_digit:TYPE(STRING1):LIKE(invalid_chk_digit):0,0\n'
    + 'FIELD:rec_type:TYPE(STRING2):0,0\n'
    + 'FIELD:fips_state:TYPE(STRING2):LIKE(invalid_fips_state):0,0\n'
    + 'FIELD:fips_county:TYPE(STRING3):LIKE(invalid_fips_county):0,0\n'
    + 'FIELD:geo_lat:TYPE(STRING10):LIKE(invalid_geo):0,0\n'
    + 'FIELD:geo_long:TYPE(STRING11):LIKE(invalid_geo):0,0\n'
    + 'FIELD:msa:TYPE(STRING4):LIKE(invalid_msa):0,0\n'
    + 'FIELD:geo_blk:TYPE(STRING7):0,0\n'
    + 'FIELD:geo_match:TYPE(STRING1):LIKE(invalid_geo_match):0,0\n'
    + 'FIELD:err_stat:TYPE(STRING4):LIKE(invalid_err_stat):0,0\n'
    + 'FIELD:recent_update_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:years_in_business_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:address_type_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:employee_size_desc:TYPE(STRING20):0,0\n'
    + 'FIELD:annual_sales_size_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:location_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:primary_sic_code_industry_class_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:business_type_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:ownership_code_desc:TYPE(STRING10):0,0\n'
    + 'FIELD:ucc_data_indicator_desc:TYPE(STRING30):0,0\n'
    + 'FIELD:experian_credit_rating_desc:TYPE(STRING30):0,0 \n'
    + 'FIELD:last_activity_age_desc:TYPE(STRING20):0,0\n'
    + 'FIELD:cottage_indicator_desc:TYPE(STRING20):0,0\n'
    + 'FIELD:nonprofit_indicator_desc:TYPE(STRING20):0,0 \n'
    + 'FIELD:company_name:LIKE(invalid_bName_pName):TYPE(STRING100):0,0\n'
    + 'FIELD:p_title:TYPE(STRING5):0,0\n'
    + 'FIELD:p_fname:LIKE(invalid_bName_fName):TYPE(STRING20):0,0\n'
    + 'FIELD:p_mname:LIKE(invalid_bName_mName):TYPE(STRING20):0,0\n'
    + 'FIELD:p_lname:LIKE(invalid_bName_lName):TYPE(STRING20):0,0\n'
    + 'FIELD:p_name_suffix:TYPE(STRING5):0,0\n'
    + 'FIELD:raw_aid:TYPE(UNSIGNED8):LIKE(invalid_raw_aid):0,0\n'
    + 'FIELD:ace_aid:TYPE(UNSIGNED8):LIKE(invalid_ace_aid):0,0\n'
    + 'FIELD:prep_addr_line1:TYPE(STRING100):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:prep_addr_line_last:TYPE(STRING50):LIKE(invalid_mandatory):0,0\n'
    + 'FIELD:source_rec_id:TYPE(UNSIGNED8):LIKE(invalid_numeric):0,0\n'
    + '//CONCEPT statements should be used to group together interellated fields; such as address\n'
    + '//RELATIONSHIP is used to find non-obvious relationships between the clusters\n'
    + '//SOURCEFIELD is used if a field of the file denotes a source of the records in that file\n'
    + '//LINKPATH is used to define access paths for external linking\n'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;
