IMPORT SALT38,STD;
IMPORT Scrubs_Experian_CRDB; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 202;
  EXPORT NumRulesFromFieldType := 202;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 202;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_Experian_CRDB)
    UNSIGNED1 dotid_Invalid;
    UNSIGNED1 dotscore_Invalid;
    UNSIGNED1 dotweight_Invalid;
    UNSIGNED1 empid_Invalid;
    UNSIGNED1 empscore_Invalid;
    UNSIGNED1 empweight_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 powscore_Invalid;
    UNSIGNED1 powweight_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 proxscore_Invalid;
    UNSIGNED1 proxweight_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 selescore_Invalid;
    UNSIGNED1 seleweight_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 orgscore_Invalid;
    UNSIGNED1 orgweight_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 ultscore_Invalid;
    UNSIGNED1 ultweight_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 experian_bus_id_Invalid;
    UNSIGNED1 business_name_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 zip_plus_4_Invalid;
    UNSIGNED1 carrier_route_Invalid;
    UNSIGNED1 county_code_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 msa_code_Invalid;
    UNSIGNED1 establish_date_Invalid;
    UNSIGNED1 latest_reported_date_Invalid;
    UNSIGNED1 years_in_file_Invalid;
    UNSIGNED1 geo_code_latitude_Invalid;
    UNSIGNED1 geo_code_latitude_direction_Invalid;
    UNSIGNED1 geo_code_longitude_Invalid;
    UNSIGNED1 geo_code_longitude_direction_Invalid;
    UNSIGNED1 recent_update_code_Invalid;
    UNSIGNED1 years_in_business_code_Invalid;
    UNSIGNED1 year_business_started_Invalid;
    UNSIGNED1 months_in_file_Invalid;
    UNSIGNED1 address_type_code_Invalid;
    UNSIGNED1 estimated_number_of_employees_Invalid;
    UNSIGNED1 employee_size_code_Invalid;
    UNSIGNED1 estimated_annual_sales_amount_sign_Invalid;
    UNSIGNED1 estimated_annual_sales_amount_Invalid;
    UNSIGNED1 annual_sales_size_code_Invalid;
    UNSIGNED1 location_code_Invalid;
    UNSIGNED1 primary_sic_code_industry_classification_Invalid;
    UNSIGNED1 primary_sic_code_4_digit_Invalid;
    UNSIGNED1 primary_sic_code_Invalid;
    UNSIGNED1 second_sic_code_Invalid;
    UNSIGNED1 third_sic_code_Invalid;
    UNSIGNED1 fourth_sic_code_Invalid;
    UNSIGNED1 fifth_sic_code_Invalid;
    UNSIGNED1 sixth_sic_code_Invalid;
    UNSIGNED1 primary_naics_code_Invalid;
    UNSIGNED1 second_naics_code_Invalid;
    UNSIGNED1 third_naics_code_Invalid;
    UNSIGNED1 fourth_naics_code_Invalid;
    UNSIGNED1 executive_count_Invalid;
    UNSIGNED1 business_type_Invalid;
    UNSIGNED1 ownership_code_Invalid;
    UNSIGNED1 derogatory_indicator_Invalid;
    UNSIGNED1 recent_derogatory_filed_date_Invalid;
    UNSIGNED1 derogatory_liability_amount_sign_Invalid;
    UNSIGNED1 derogatory_liability_amount_Invalid;
    UNSIGNED1 ucc_data_indicator_Invalid;
    UNSIGNED1 ucc_count_Invalid;
    UNSIGNED1 number_of_legal_items_Invalid;
    UNSIGNED1 legal_balance_sign_Invalid;
    UNSIGNED1 legal_balance_amount_Invalid;
    UNSIGNED1 pmtkbankruptcy_Invalid;
    UNSIGNED1 pmtkjudgment_Invalid;
    UNSIGNED1 pmtktaxlien_Invalid;
    UNSIGNED1 pmtkpayment_Invalid;
    UNSIGNED1 bankruptcy_filed_Invalid;
    UNSIGNED1 number_of_derogatory_legal_items_Invalid;
    UNSIGNED1 lien_count_Invalid;
    UNSIGNED1 judgment_count_Invalid;
    UNSIGNED1 bkc006_Invalid;
    UNSIGNED1 bkc007_Invalid;
    UNSIGNED1 bkc008_Invalid;
    UNSIGNED1 bko009_Invalid;
    UNSIGNED1 bkb001_sign_Invalid;
    UNSIGNED1 bkb001_Invalid;
    UNSIGNED1 bkb003_sign_Invalid;
    UNSIGNED1 bkb003_Invalid;
    UNSIGNED1 bko010_Invalid;
    UNSIGNED1 bko011_Invalid;
    UNSIGNED1 jdc010_Invalid;
    UNSIGNED1 jdc011_Invalid;
    UNSIGNED1 jdc012_Invalid;
    UNSIGNED1 jdb004_Invalid;
    UNSIGNED1 jdb005_Invalid;
    UNSIGNED1 jdb006_Invalid;
    UNSIGNED1 jDO013_Invalid;
    UNSIGNED1 jDO014_Invalid;
    UNSIGNED1 jdb002_Invalid;
    UNSIGNED1 jdp016_Invalid;
    UNSIGNED1 lgc004_Invalid;
    UNSIGNED1 pro001_Invalid;
    UNSIGNED1 pro003_Invalid;
    UNSIGNED1 txc010_Invalid;
    UNSIGNED1 txc011_Invalid;
    UNSIGNED1 txb004_sign_Invalid;
    UNSIGNED1 txb004_Invalid;
    UNSIGNED1 txo013_Invalid;
    UNSIGNED1 txb002_sign_Invalid;
    UNSIGNED1 txb002_Invalid;
    UNSIGNED1 txp016_Invalid;
    UNSIGNED1 ucc001_Invalid;
    UNSIGNED1 ucc002_Invalid;
    UNSIGNED1 ucc003_Invalid;
    UNSIGNED1 intelliscore_plus_Invalid;
    UNSIGNED1 percentile_model_Invalid;
    UNSIGNED1 model_action_Invalid;
    UNSIGNED1 score_factor_1_Invalid;
    UNSIGNED1 score_factor_2_Invalid;
    UNSIGNED1 score_factor_3_Invalid;
    UNSIGNED1 score_factor_4_Invalid;
    UNSIGNED1 model_type_Invalid;
    UNSIGNED1 last_experian_inquiry_date_Invalid;
    UNSIGNED1 recent_high_credit_sign_Invalid;
    UNSIGNED1 recent_high_credit_Invalid;
    UNSIGNED1 median_credit_amount_sign_Invalid;
    UNSIGNED1 median_credit_amount_Invalid;
    UNSIGNED1 total_combined_trade_lines_count_Invalid;
    UNSIGNED1 dbt_of_combined_trade_totals_Invalid;
    UNSIGNED1 combined_trade_balance_Invalid;
    UNSIGNED1 aged_trade_lines_Invalid;
    UNSIGNED1 experian_credit_rating_Invalid;
    UNSIGNED1 quarter_1_average_dbt_Invalid;
    UNSIGNED1 quarter_2_average_dbt_Invalid;
    UNSIGNED1 quarter_3_average_dbt_Invalid;
    UNSIGNED1 quarter_4_average_dbt_Invalid;
    UNSIGNED1 quarter_5_average_dbt_Invalid;
    UNSIGNED1 combined_dbt_Invalid;
    UNSIGNED1 total_account_balance_sign_Invalid;
    UNSIGNED1 total_account_balance_Invalid;
    UNSIGNED1 combined_account_balance_sign_Invalid;
    UNSIGNED1 combined_account_balance_Invalid;
    UNSIGNED1 collection_count_Invalid;
    UNSIGNED1 atc021_Invalid;
    UNSIGNED1 atc022_Invalid;
    UNSIGNED1 atc023_Invalid;
    UNSIGNED1 atc024_Invalid;
    UNSIGNED1 atc025_Invalid;
    UNSIGNED1 last_activity_age_code_Invalid;
    UNSIGNED1 cottage_indicator_Invalid;
    UNSIGNED1 nonprofit_indicator_Invalid;
    UNSIGNED1 financial_stability_risk_score_Invalid;
    UNSIGNED1 fsr_risk_class_Invalid;
    UNSIGNED1 fsr_score_factor_1_Invalid;
    UNSIGNED1 fsr_score_factor_2_Invalid;
    UNSIGNED1 fsr_score_factor_3_Invalid;
    UNSIGNED1 fsr_score_factor_4_Invalid;
    UNSIGNED1 ip_score_change_sign_Invalid;
    UNSIGNED1 ip_score_change_Invalid;
    UNSIGNED1 fsr_score_change_sign_Invalid;
    UNSIGNED1 fsr_score_change_Invalid;
    UNSIGNED1 clean_dba_name_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dbpc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 fips_state_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 p_fname_Invalid;
    UNSIGNED1 p_mname_Invalid;
    UNSIGNED1 p_lname_Invalid;
    UNSIGNED1 raw_aid_Invalid;
    UNSIGNED1 ace_aid_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Experian_CRDB)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
EXPORT FromNone(DATASET(Base_Layout_Experian_CRDB) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dotid_Invalid := Base_Fields.InValid_dotid((SALT38.StrType)le.dotid);
    SELF.dotscore_Invalid := Base_Fields.InValid_dotscore((SALT38.StrType)le.dotscore);
    SELF.dotweight_Invalid := Base_Fields.InValid_dotweight((SALT38.StrType)le.dotweight);
    SELF.empid_Invalid := Base_Fields.InValid_empid((SALT38.StrType)le.empid);
    SELF.empscore_Invalid := Base_Fields.InValid_empscore((SALT38.StrType)le.empscore);
    SELF.empweight_Invalid := Base_Fields.InValid_empweight((SALT38.StrType)le.empweight);
    SELF.powid_Invalid := Base_Fields.InValid_powid((SALT38.StrType)le.powid);
    SELF.powscore_Invalid := Base_Fields.InValid_powscore((SALT38.StrType)le.powscore);
    SELF.powweight_Invalid := Base_Fields.InValid_powweight((SALT38.StrType)le.powweight);
    SELF.proxid_Invalid := Base_Fields.InValid_proxid((SALT38.StrType)le.proxid);
    SELF.proxscore_Invalid := Base_Fields.InValid_proxscore((SALT38.StrType)le.proxscore);
    SELF.proxweight_Invalid := Base_Fields.InValid_proxweight((SALT38.StrType)le.proxweight);
    SELF.seleid_Invalid := Base_Fields.InValid_seleid((SALT38.StrType)le.seleid);
    SELF.selescore_Invalid := Base_Fields.InValid_selescore((SALT38.StrType)le.selescore);
    SELF.seleweight_Invalid := Base_Fields.InValid_seleweight((SALT38.StrType)le.seleweight);
    SELF.orgid_Invalid := Base_Fields.InValid_orgid((SALT38.StrType)le.orgid);
    SELF.orgscore_Invalid := Base_Fields.InValid_orgscore((SALT38.StrType)le.orgscore);
    SELF.orgweight_Invalid := Base_Fields.InValid_orgweight((SALT38.StrType)le.orgweight);
    SELF.ultid_Invalid := Base_Fields.InValid_ultid((SALT38.StrType)le.ultid);
    SELF.ultscore_Invalid := Base_Fields.InValid_ultscore((SALT38.StrType)le.ultscore);
    SELF.ultweight_Invalid := Base_Fields.InValid_ultweight((SALT38.StrType)le.ultweight);
    SELF.bdid_Invalid := Base_Fields.InValid_bdid((SALT38.StrType)le.bdid);
    SELF.bdid_score_Invalid := Base_Fields.InValid_bdid_score((SALT38.StrType)le.bdid_score);
    SELF.did_Invalid := Base_Fields.InValid_did((SALT38.StrType)le.did);
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT38.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT38.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Base_Fields.InValid_dt_vendor_first_reported((SALT38.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Base_Fields.InValid_dt_vendor_last_reported((SALT38.StrType)le.dt_vendor_last_reported);
    SELF.experian_bus_id_Invalid := Base_Fields.InValid_experian_bus_id((SALT38.StrType)le.experian_bus_id);
    SELF.business_name_Invalid := Base_Fields.InValid_business_name((SALT38.StrType)le.business_name);
    SELF.address_Invalid := Base_Fields.InValid_address((SALT38.StrType)le.address);
    SELF.city_Invalid := Base_Fields.InValid_city((SALT38.StrType)le.city);
    SELF.state_Invalid := Base_Fields.InValid_state((SALT38.StrType)le.state);
    SELF.zip_code_Invalid := Base_Fields.InValid_zip_code((SALT38.StrType)le.zip_code);
    SELF.zip_plus_4_Invalid := Base_Fields.InValid_zip_plus_4((SALT38.StrType)le.zip_plus_4);
    SELF.carrier_route_Invalid := Base_Fields.InValid_carrier_route((SALT38.StrType)le.carrier_route);
    SELF.county_code_Invalid := Base_Fields.InValid_county_code((SALT38.StrType)le.county_code);
    SELF.county_name_Invalid := Base_Fields.InValid_county_name((SALT38.StrType)le.county_name);
    SELF.phone_number_Invalid := Base_Fields.InValid_phone_number((SALT38.StrType)le.phone_number);
    SELF.msa_code_Invalid := Base_Fields.InValid_msa_code((SALT38.StrType)le.msa_code);
    SELF.establish_date_Invalid := Base_Fields.InValid_establish_date((SALT38.StrType)le.establish_date);
    SELF.latest_reported_date_Invalid := Base_Fields.InValid_latest_reported_date((SALT38.StrType)le.latest_reported_date);
    SELF.years_in_file_Invalid := Base_Fields.InValid_years_in_file((SALT38.StrType)le.years_in_file);
    SELF.geo_code_latitude_Invalid := Base_Fields.InValid_geo_code_latitude((SALT38.StrType)le.geo_code_latitude);
    SELF.geo_code_latitude_direction_Invalid := Base_Fields.InValid_geo_code_latitude_direction((SALT38.StrType)le.geo_code_latitude_direction);
    SELF.geo_code_longitude_Invalid := Base_Fields.InValid_geo_code_longitude((SALT38.StrType)le.geo_code_longitude);
    SELF.geo_code_longitude_direction_Invalid := Base_Fields.InValid_geo_code_longitude_direction((SALT38.StrType)le.geo_code_longitude_direction);
    SELF.recent_update_code_Invalid := Base_Fields.InValid_recent_update_code((SALT38.StrType)le.recent_update_code);
    SELF.years_in_business_code_Invalid := Base_Fields.InValid_years_in_business_code((SALT38.StrType)le.years_in_business_code);
    SELF.year_business_started_Invalid := Base_Fields.InValid_year_business_started((SALT38.StrType)le.year_business_started);
    SELF.months_in_file_Invalid := Base_Fields.InValid_months_in_file((SALT38.StrType)le.months_in_file);
    SELF.address_type_code_Invalid := Base_Fields.InValid_address_type_code((SALT38.StrType)le.address_type_code);
    SELF.estimated_number_of_employees_Invalid := Base_Fields.InValid_estimated_number_of_employees((SALT38.StrType)le.estimated_number_of_employees);
    SELF.employee_size_code_Invalid := Base_Fields.InValid_employee_size_code((SALT38.StrType)le.employee_size_code);
    SELF.estimated_annual_sales_amount_sign_Invalid := Base_Fields.InValid_estimated_annual_sales_amount_sign((SALT38.StrType)le.estimated_annual_sales_amount_sign);
    SELF.estimated_annual_sales_amount_Invalid := Base_Fields.InValid_estimated_annual_sales_amount((SALT38.StrType)le.estimated_annual_sales_amount);
    SELF.annual_sales_size_code_Invalid := Base_Fields.InValid_annual_sales_size_code((SALT38.StrType)le.annual_sales_size_code);
    SELF.location_code_Invalid := Base_Fields.InValid_location_code((SALT38.StrType)le.location_code);
    SELF.primary_sic_code_industry_classification_Invalid := Base_Fields.InValid_primary_sic_code_industry_classification((SALT38.StrType)le.primary_sic_code_industry_classification);
    SELF.primary_sic_code_4_digit_Invalid := Base_Fields.InValid_primary_sic_code_4_digit((SALT38.StrType)le.primary_sic_code_4_digit);
    SELF.primary_sic_code_Invalid := Base_Fields.InValid_primary_sic_code((SALT38.StrType)le.primary_sic_code);
    SELF.second_sic_code_Invalid := Base_Fields.InValid_second_sic_code((SALT38.StrType)le.second_sic_code);
    SELF.third_sic_code_Invalid := Base_Fields.InValid_third_sic_code((SALT38.StrType)le.third_sic_code);
    SELF.fourth_sic_code_Invalid := Base_Fields.InValid_fourth_sic_code((SALT38.StrType)le.fourth_sic_code);
    SELF.fifth_sic_code_Invalid := Base_Fields.InValid_fifth_sic_code((SALT38.StrType)le.fifth_sic_code);
    SELF.sixth_sic_code_Invalid := Base_Fields.InValid_sixth_sic_code((SALT38.StrType)le.sixth_sic_code);
    SELF.primary_naics_code_Invalid := Base_Fields.InValid_primary_naics_code((SALT38.StrType)le.primary_naics_code);
    SELF.second_naics_code_Invalid := Base_Fields.InValid_second_naics_code((SALT38.StrType)le.second_naics_code);
    SELF.third_naics_code_Invalid := Base_Fields.InValid_third_naics_code((SALT38.StrType)le.third_naics_code);
    SELF.fourth_naics_code_Invalid := Base_Fields.InValid_fourth_naics_code((SALT38.StrType)le.fourth_naics_code);
    SELF.executive_count_Invalid := Base_Fields.InValid_executive_count((SALT38.StrType)le.executive_count);
    SELF.business_type_Invalid := Base_Fields.InValid_business_type((SALT38.StrType)le.business_type);
    SELF.ownership_code_Invalid := Base_Fields.InValid_ownership_code((SALT38.StrType)le.ownership_code);
    SELF.derogatory_indicator_Invalid := Base_Fields.InValid_derogatory_indicator((SALT38.StrType)le.derogatory_indicator);
    SELF.recent_derogatory_filed_date_Invalid := Base_Fields.InValid_recent_derogatory_filed_date((SALT38.StrType)le.recent_derogatory_filed_date);
    SELF.derogatory_liability_amount_sign_Invalid := Base_Fields.InValid_derogatory_liability_amount_sign((SALT38.StrType)le.derogatory_liability_amount_sign);
    SELF.derogatory_liability_amount_Invalid := Base_Fields.InValid_derogatory_liability_amount((SALT38.StrType)le.derogatory_liability_amount);
    SELF.ucc_data_indicator_Invalid := Base_Fields.InValid_ucc_data_indicator((SALT38.StrType)le.ucc_data_indicator);
    SELF.ucc_count_Invalid := Base_Fields.InValid_ucc_count((SALT38.StrType)le.ucc_count);
    SELF.number_of_legal_items_Invalid := Base_Fields.InValid_number_of_legal_items((SALT38.StrType)le.number_of_legal_items);
    SELF.legal_balance_sign_Invalid := Base_Fields.InValid_legal_balance_sign((SALT38.StrType)le.legal_balance_sign);
    SELF.legal_balance_amount_Invalid := Base_Fields.InValid_legal_balance_amount((SALT38.StrType)le.legal_balance_amount);
    SELF.pmtkbankruptcy_Invalid := Base_Fields.InValid_pmtkbankruptcy((SALT38.StrType)le.pmtkbankruptcy);
    SELF.pmtkjudgment_Invalid := Base_Fields.InValid_pmtkjudgment((SALT38.StrType)le.pmtkjudgment);
    SELF.pmtktaxlien_Invalid := Base_Fields.InValid_pmtktaxlien((SALT38.StrType)le.pmtktaxlien);
    SELF.pmtkpayment_Invalid := Base_Fields.InValid_pmtkpayment((SALT38.StrType)le.pmtkpayment);
    SELF.bankruptcy_filed_Invalid := Base_Fields.InValid_bankruptcy_filed((SALT38.StrType)le.bankruptcy_filed);
    SELF.number_of_derogatory_legal_items_Invalid := Base_Fields.InValid_number_of_derogatory_legal_items((SALT38.StrType)le.number_of_derogatory_legal_items);
    SELF.lien_count_Invalid := Base_Fields.InValid_lien_count((SALT38.StrType)le.lien_count);
    SELF.judgment_count_Invalid := Base_Fields.InValid_judgment_count((SALT38.StrType)le.judgment_count);
    SELF.bkc006_Invalid := Base_Fields.InValid_bkc006((SALT38.StrType)le.bkc006);
    SELF.bkc007_Invalid := Base_Fields.InValid_bkc007((SALT38.StrType)le.bkc007);
    SELF.bkc008_Invalid := Base_Fields.InValid_bkc008((SALT38.StrType)le.bkc008);
    SELF.bko009_Invalid := Base_Fields.InValid_bko009((SALT38.StrType)le.bko009);
    SELF.bkb001_sign_Invalid := Base_Fields.InValid_bkb001_sign((SALT38.StrType)le.bkb001_sign);
    SELF.bkb001_Invalid := Base_Fields.InValid_bkb001((SALT38.StrType)le.bkb001);
    SELF.bkb003_sign_Invalid := Base_Fields.InValid_bkb003_sign((SALT38.StrType)le.bkb003_sign);
    SELF.bkb003_Invalid := Base_Fields.InValid_bkb003((SALT38.StrType)le.bkb003);
    SELF.bko010_Invalid := Base_Fields.InValid_bko010((SALT38.StrType)le.bko010);
    SELF.bko011_Invalid := Base_Fields.InValid_bko011((SALT38.StrType)le.bko011);
    SELF.jdc010_Invalid := Base_Fields.InValid_jdc010((SALT38.StrType)le.jdc010);
    SELF.jdc011_Invalid := Base_Fields.InValid_jdc011((SALT38.StrType)le.jdc011);
    SELF.jdc012_Invalid := Base_Fields.InValid_jdc012((SALT38.StrType)le.jdc012);
    SELF.jdb004_Invalid := Base_Fields.InValid_jdb004((SALT38.StrType)le.jdb004);
    SELF.jdb005_Invalid := Base_Fields.InValid_jdb005((SALT38.StrType)le.jdb005);
    SELF.jdb006_Invalid := Base_Fields.InValid_jdb006((SALT38.StrType)le.jdb006);
    SELF.jDO013_Invalid := Base_Fields.InValid_jDO013((SALT38.StrType)le.jDO013);
    SELF.jDO014_Invalid := Base_Fields.InValid_jDO014((SALT38.StrType)le.jDO014);
    SELF.jdb002_Invalid := Base_Fields.InValid_jdb002((SALT38.StrType)le.jdb002);
    SELF.jdp016_Invalid := Base_Fields.InValid_jdp016((SALT38.StrType)le.jdp016);
    SELF.lgc004_Invalid := Base_Fields.InValid_lgc004((SALT38.StrType)le.lgc004);
    SELF.pro001_Invalid := Base_Fields.InValid_pro001((SALT38.StrType)le.pro001);
    SELF.pro003_Invalid := Base_Fields.InValid_pro003((SALT38.StrType)le.pro003);
    SELF.txc010_Invalid := Base_Fields.InValid_txc010((SALT38.StrType)le.txc010);
    SELF.txc011_Invalid := Base_Fields.InValid_txc011((SALT38.StrType)le.txc011);
    SELF.txb004_sign_Invalid := Base_Fields.InValid_txb004_sign((SALT38.StrType)le.txb004_sign);
    SELF.txb004_Invalid := Base_Fields.InValid_txb004((SALT38.StrType)le.txb004);
    SELF.txo013_Invalid := Base_Fields.InValid_txo013((SALT38.StrType)le.txo013);
    SELF.txb002_sign_Invalid := Base_Fields.InValid_txb002_sign((SALT38.StrType)le.txb002_sign);
    SELF.txb002_Invalid := Base_Fields.InValid_txb002((SALT38.StrType)le.txb002);
    SELF.txp016_Invalid := Base_Fields.InValid_txp016((SALT38.StrType)le.txp016);
    SELF.ucc001_Invalid := Base_Fields.InValid_ucc001((SALT38.StrType)le.ucc001);
    SELF.ucc002_Invalid := Base_Fields.InValid_ucc002((SALT38.StrType)le.ucc002);
    SELF.ucc003_Invalid := Base_Fields.InValid_ucc003((SALT38.StrType)le.ucc003);
    SELF.intelliscore_plus_Invalid := Base_Fields.InValid_intelliscore_plus((SALT38.StrType)le.intelliscore_plus);
    SELF.percentile_model_Invalid := Base_Fields.InValid_percentile_model((SALT38.StrType)le.percentile_model);
    SELF.model_action_Invalid := Base_Fields.InValid_model_action((SALT38.StrType)le.model_action);
    SELF.score_factor_1_Invalid := Base_Fields.InValid_score_factor_1((SALT38.StrType)le.score_factor_1);
    SELF.score_factor_2_Invalid := Base_Fields.InValid_score_factor_2((SALT38.StrType)le.score_factor_2);
    SELF.score_factor_3_Invalid := Base_Fields.InValid_score_factor_3((SALT38.StrType)le.score_factor_3);
    SELF.score_factor_4_Invalid := Base_Fields.InValid_score_factor_4((SALT38.StrType)le.score_factor_4);
    SELF.model_type_Invalid := Base_Fields.InValid_model_type((SALT38.StrType)le.model_type);
    SELF.last_experian_inquiry_date_Invalid := Base_Fields.InValid_last_experian_inquiry_date((SALT38.StrType)le.last_experian_inquiry_date);
    SELF.recent_high_credit_sign_Invalid := Base_Fields.InValid_recent_high_credit_sign((SALT38.StrType)le.recent_high_credit_sign);
    SELF.recent_high_credit_Invalid := Base_Fields.InValid_recent_high_credit((SALT38.StrType)le.recent_high_credit);
    SELF.median_credit_amount_sign_Invalid := Base_Fields.InValid_median_credit_amount_sign((SALT38.StrType)le.median_credit_amount_sign);
    SELF.median_credit_amount_Invalid := Base_Fields.InValid_median_credit_amount((SALT38.StrType)le.median_credit_amount);
    SELF.total_combined_trade_lines_count_Invalid := Base_Fields.InValid_total_combined_trade_lines_count((SALT38.StrType)le.total_combined_trade_lines_count);
    SELF.dbt_of_combined_trade_totals_Invalid := Base_Fields.InValid_dbt_of_combined_trade_totals((SALT38.StrType)le.dbt_of_combined_trade_totals);
    SELF.combined_trade_balance_Invalid := Base_Fields.InValid_combined_trade_balance((SALT38.StrType)le.combined_trade_balance);
    SELF.aged_trade_lines_Invalid := Base_Fields.InValid_aged_trade_lines((SALT38.StrType)le.aged_trade_lines);
    SELF.experian_credit_rating_Invalid := Base_Fields.InValid_experian_credit_rating((SALT38.StrType)le.experian_credit_rating);
    SELF.quarter_1_average_dbt_Invalid := Base_Fields.InValid_quarter_1_average_dbt((SALT38.StrType)le.quarter_1_average_dbt);
    SELF.quarter_2_average_dbt_Invalid := Base_Fields.InValid_quarter_2_average_dbt((SALT38.StrType)le.quarter_2_average_dbt);
    SELF.quarter_3_average_dbt_Invalid := Base_Fields.InValid_quarter_3_average_dbt((SALT38.StrType)le.quarter_3_average_dbt);
    SELF.quarter_4_average_dbt_Invalid := Base_Fields.InValid_quarter_4_average_dbt((SALT38.StrType)le.quarter_4_average_dbt);
    SELF.quarter_5_average_dbt_Invalid := Base_Fields.InValid_quarter_5_average_dbt((SALT38.StrType)le.quarter_5_average_dbt);
    SELF.combined_dbt_Invalid := Base_Fields.InValid_combined_dbt((SALT38.StrType)le.combined_dbt);
    SELF.total_account_balance_sign_Invalid := Base_Fields.InValid_total_account_balance_sign((SALT38.StrType)le.total_account_balance_sign);
    SELF.total_account_balance_Invalid := Base_Fields.InValid_total_account_balance((SALT38.StrType)le.total_account_balance);
    SELF.combined_account_balance_sign_Invalid := Base_Fields.InValid_combined_account_balance_sign((SALT38.StrType)le.combined_account_balance_sign);
    SELF.combined_account_balance_Invalid := Base_Fields.InValid_combined_account_balance((SALT38.StrType)le.combined_account_balance);
    SELF.collection_count_Invalid := Base_Fields.InValid_collection_count((SALT38.StrType)le.collection_count);
    SELF.atc021_Invalid := Base_Fields.InValid_atc021((SALT38.StrType)le.atc021);
    SELF.atc022_Invalid := Base_Fields.InValid_atc022((SALT38.StrType)le.atc022);
    SELF.atc023_Invalid := Base_Fields.InValid_atc023((SALT38.StrType)le.atc023);
    SELF.atc024_Invalid := Base_Fields.InValid_atc024((SALT38.StrType)le.atc024);
    SELF.atc025_Invalid := Base_Fields.InValid_atc025((SALT38.StrType)le.atc025);
    SELF.last_activity_age_code_Invalid := Base_Fields.InValid_last_activity_age_code((SALT38.StrType)le.last_activity_age_code);
    SELF.cottage_indicator_Invalid := Base_Fields.InValid_cottage_indicator((SALT38.StrType)le.cottage_indicator);
    SELF.nonprofit_indicator_Invalid := Base_Fields.InValid_nonprofit_indicator((SALT38.StrType)le.nonprofit_indicator);
    SELF.financial_stability_risk_score_Invalid := Base_Fields.InValid_financial_stability_risk_score((SALT38.StrType)le.financial_stability_risk_score);
    SELF.fsr_risk_class_Invalid := Base_Fields.InValid_fsr_risk_class((SALT38.StrType)le.fsr_risk_class);
    SELF.fsr_score_factor_1_Invalid := Base_Fields.InValid_fsr_score_factor_1((SALT38.StrType)le.fsr_score_factor_1);
    SELF.fsr_score_factor_2_Invalid := Base_Fields.InValid_fsr_score_factor_2((SALT38.StrType)le.fsr_score_factor_2);
    SELF.fsr_score_factor_3_Invalid := Base_Fields.InValid_fsr_score_factor_3((SALT38.StrType)le.fsr_score_factor_3);
    SELF.fsr_score_factor_4_Invalid := Base_Fields.InValid_fsr_score_factor_4((SALT38.StrType)le.fsr_score_factor_4);
    SELF.ip_score_change_sign_Invalid := Base_Fields.InValid_ip_score_change_sign((SALT38.StrType)le.ip_score_change_sign);
    SELF.ip_score_change_Invalid := Base_Fields.InValid_ip_score_change((SALT38.StrType)le.ip_score_change);
    SELF.fsr_score_change_sign_Invalid := Base_Fields.InValid_fsr_score_change_sign((SALT38.StrType)le.fsr_score_change_sign);
    SELF.fsr_score_change_Invalid := Base_Fields.InValid_fsr_score_change((SALT38.StrType)le.fsr_score_change);
    SELF.clean_dba_name_Invalid := Base_Fields.InValid_clean_dba_name((SALT38.StrType)le.clean_dba_name,(SALT38.StrType)le.dba_name);
    SELF.predir_Invalid := Base_Fields.InValid_predir((SALT38.StrType)le.predir);
    SELF.prim_name_Invalid := Base_Fields.InValid_prim_name((SALT38.StrType)le.prim_name);
    SELF.postdir_Invalid := Base_Fields.InValid_postdir((SALT38.StrType)le.postdir);
    SELF.p_city_name_Invalid := Base_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Base_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name);
    SELF.st_Invalid := Base_Fields.InValid_st((SALT38.StrType)le.st);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT38.StrType)le.zip);
    SELF.zip4_Invalid := Base_Fields.InValid_zip4((SALT38.StrType)le.zip4);
    SELF.cart_Invalid := Base_Fields.InValid_cart((SALT38.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Base_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Base_Fields.InValid_lot((SALT38.StrType)le.lot);
    SELF.lot_order_Invalid := Base_Fields.InValid_lot_order((SALT38.StrType)le.lot_order);
    SELF.dbpc_Invalid := Base_Fields.InValid_dbpc((SALT38.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Base_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit);
    SELF.fips_state_Invalid := Base_Fields.InValid_fips_state((SALT38.StrType)le.fips_state);
    SELF.fips_county_Invalid := Base_Fields.InValid_fips_county((SALT38.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Base_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Base_Fields.InValid_geo_long((SALT38.StrType)le.geo_long);
    SELF.msa_Invalid := Base_Fields.InValid_msa((SALT38.StrType)le.msa);
    SELF.geo_match_Invalid := Base_Fields.InValid_geo_match((SALT38.StrType)le.geo_match);
    SELF.err_stat_Invalid := Base_Fields.InValid_err_stat((SALT38.StrType)le.err_stat);
    SELF.company_name_Invalid := Base_Fields.InValid_company_name((SALT38.StrType)le.company_name,(SALT38.StrType)le.p_fname,(SALT38.StrType)le.p_mname,(SALT38.StrType)le.p_lname);
    SELF.p_fname_Invalid := Base_Fields.InValid_p_fname((SALT38.StrType)le.p_fname,(SALT38.StrType)le.company_name,(SALT38.StrType)le.p_mname,(SALT38.StrType)le.p_lname);
    SELF.p_mname_Invalid := Base_Fields.InValid_p_mname((SALT38.StrType)le.p_mname,(SALT38.StrType)le.company_name,(SALT38.StrType)le.p_fname,(SALT38.StrType)le.p_lname);
    SELF.p_lname_Invalid := Base_Fields.InValid_p_lname((SALT38.StrType)le.p_lname,(SALT38.StrType)le.company_name,(SALT38.StrType)le.p_fname,(SALT38.StrType)le.p_mname);
    SELF.raw_aid_Invalid := Base_Fields.InValid_raw_aid((SALT38.StrType)le.raw_aid);
    SELF.ace_aid_Invalid := Base_Fields.InValid_ace_aid((SALT38.StrType)le.ace_aid);
    SELF.prep_addr_line1_Invalid := Base_Fields.InValid_prep_addr_line1((SALT38.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Base_Fields.InValid_prep_addr_line_last((SALT38.StrType)le.prep_addr_line_last);
    SELF.source_rec_id_Invalid := Base_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Experian_CRDB);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dotid_Invalid << 0 ) + ( le.dotscore_Invalid << 1 ) + ( le.dotweight_Invalid << 2 ) + ( le.empid_Invalid << 3 ) + ( le.empscore_Invalid << 4 ) + ( le.empweight_Invalid << 5 ) + ( le.powid_Invalid << 6 ) + ( le.powscore_Invalid << 7 ) + ( le.powweight_Invalid << 8 ) + ( le.proxid_Invalid << 9 ) + ( le.proxscore_Invalid << 10 ) + ( le.proxweight_Invalid << 11 ) + ( le.seleid_Invalid << 12 ) + ( le.selescore_Invalid << 13 ) + ( le.seleweight_Invalid << 14 ) + ( le.orgid_Invalid << 15 ) + ( le.orgscore_Invalid << 16 ) + ( le.orgweight_Invalid << 17 ) + ( le.ultid_Invalid << 18 ) + ( le.ultscore_Invalid << 19 ) + ( le.ultweight_Invalid << 20 ) + ( le.bdid_Invalid << 21 ) + ( le.bdid_score_Invalid << 22 ) + ( le.did_Invalid << 23 ) + ( le.dt_first_seen_Invalid << 24 ) + ( le.dt_last_seen_Invalid << 25 ) + ( le.dt_vendor_first_reported_Invalid << 26 ) + ( le.dt_vendor_last_reported_Invalid << 27 ) + ( le.experian_bus_id_Invalid << 28 ) + ( le.business_name_Invalid << 29 ) + ( le.address_Invalid << 30 ) + ( le.city_Invalid << 31 ) + ( le.state_Invalid << 32 ) + ( le.zip_code_Invalid << 33 ) + ( le.zip_plus_4_Invalid << 34 ) + ( le.carrier_route_Invalid << 35 ) + ( le.county_code_Invalid << 36 ) + ( le.county_name_Invalid << 37 ) + ( le.phone_number_Invalid << 38 ) + ( le.msa_code_Invalid << 39 ) + ( le.establish_date_Invalid << 40 ) + ( le.latest_reported_date_Invalid << 41 ) + ( le.years_in_file_Invalid << 42 ) + ( le.geo_code_latitude_Invalid << 43 ) + ( le.geo_code_latitude_direction_Invalid << 44 ) + ( le.geo_code_longitude_Invalid << 45 ) + ( le.geo_code_longitude_direction_Invalid << 46 ) + ( le.recent_update_code_Invalid << 47 ) + ( le.years_in_business_code_Invalid << 48 ) + ( le.year_business_started_Invalid << 49 ) + ( le.months_in_file_Invalid << 50 ) + ( le.address_type_code_Invalid << 51 ) + ( le.estimated_number_of_employees_Invalid << 52 ) + ( le.employee_size_code_Invalid << 53 ) + ( le.estimated_annual_sales_amount_sign_Invalid << 54 ) + ( le.estimated_annual_sales_amount_Invalid << 55 ) + ( le.annual_sales_size_code_Invalid << 56 ) + ( le.location_code_Invalid << 57 ) + ( le.primary_sic_code_industry_classification_Invalid << 58 ) + ( le.primary_sic_code_4_digit_Invalid << 59 ) + ( le.primary_sic_code_Invalid << 60 ) + ( le.second_sic_code_Invalid << 61 ) + ( le.third_sic_code_Invalid << 62 ) + ( le.fourth_sic_code_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.fifth_sic_code_Invalid << 0 ) + ( le.sixth_sic_code_Invalid << 1 ) + ( le.primary_naics_code_Invalid << 2 ) + ( le.second_naics_code_Invalid << 3 ) + ( le.third_naics_code_Invalid << 4 ) + ( le.fourth_naics_code_Invalid << 5 ) + ( le.executive_count_Invalid << 6 ) + ( le.business_type_Invalid << 7 ) + ( le.ownership_code_Invalid << 8 ) + ( le.derogatory_indicator_Invalid << 9 ) + ( le.recent_derogatory_filed_date_Invalid << 10 ) + ( le.derogatory_liability_amount_sign_Invalid << 11 ) + ( le.derogatory_liability_amount_Invalid << 12 ) + ( le.ucc_data_indicator_Invalid << 13 ) + ( le.ucc_count_Invalid << 14 ) + ( le.number_of_legal_items_Invalid << 15 ) + ( le.legal_balance_sign_Invalid << 16 ) + ( le.legal_balance_amount_Invalid << 17 ) + ( le.pmtkbankruptcy_Invalid << 18 ) + ( le.pmtkjudgment_Invalid << 19 ) + ( le.pmtktaxlien_Invalid << 20 ) + ( le.pmtkpayment_Invalid << 21 ) + ( le.bankruptcy_filed_Invalid << 22 ) + ( le.number_of_derogatory_legal_items_Invalid << 23 ) + ( le.lien_count_Invalid << 24 ) + ( le.judgment_count_Invalid << 25 ) + ( le.bkc006_Invalid << 26 ) + ( le.bkc007_Invalid << 27 ) + ( le.bkc008_Invalid << 28 ) + ( le.bko009_Invalid << 29 ) + ( le.bkb001_sign_Invalid << 30 ) + ( le.bkb001_Invalid << 31 ) + ( le.bkb003_sign_Invalid << 32 ) + ( le.bkb003_Invalid << 33 ) + ( le.bko010_Invalid << 34 ) + ( le.bko011_Invalid << 35 ) + ( le.jdc010_Invalid << 36 ) + ( le.jdc011_Invalid << 37 ) + ( le.jdc012_Invalid << 38 ) + ( le.jdb004_Invalid << 39 ) + ( le.jdb005_Invalid << 40 ) + ( le.jdb006_Invalid << 41 ) + ( le.jDO013_Invalid << 42 ) + ( le.jDO014_Invalid << 43 ) + ( le.jdb002_Invalid << 44 ) + ( le.jdp016_Invalid << 45 ) + ( le.lgc004_Invalid << 46 ) + ( le.pro001_Invalid << 47 ) + ( le.pro003_Invalid << 48 ) + ( le.txc010_Invalid << 49 ) + ( le.txc011_Invalid << 50 ) + ( le.txb004_sign_Invalid << 51 ) + ( le.txb004_Invalid << 52 ) + ( le.txo013_Invalid << 53 ) + ( le.txb002_sign_Invalid << 54 ) + ( le.txb002_Invalid << 55 ) + ( le.txp016_Invalid << 56 ) + ( le.ucc001_Invalid << 57 ) + ( le.ucc002_Invalid << 58 ) + ( le.ucc003_Invalid << 59 ) + ( le.intelliscore_plus_Invalid << 60 ) + ( le.percentile_model_Invalid << 61 ) + ( le.model_action_Invalid << 62 ) + ( le.score_factor_1_Invalid << 63 );
    SELF.ScrubsBits3 := ( le.score_factor_2_Invalid << 0 ) + ( le.score_factor_3_Invalid << 1 ) + ( le.score_factor_4_Invalid << 2 ) + ( le.model_type_Invalid << 3 ) + ( le.last_experian_inquiry_date_Invalid << 4 ) + ( le.recent_high_credit_sign_Invalid << 5 ) + ( le.recent_high_credit_Invalid << 6 ) + ( le.median_credit_amount_sign_Invalid << 7 ) + ( le.median_credit_amount_Invalid << 8 ) + ( le.total_combined_trade_lines_count_Invalid << 9 ) + ( le.dbt_of_combined_trade_totals_Invalid << 10 ) + ( le.combined_trade_balance_Invalid << 11 ) + ( le.aged_trade_lines_Invalid << 12 ) + ( le.experian_credit_rating_Invalid << 13 ) + ( le.quarter_1_average_dbt_Invalid << 14 ) + ( le.quarter_2_average_dbt_Invalid << 15 ) + ( le.quarter_3_average_dbt_Invalid << 16 ) + ( le.quarter_4_average_dbt_Invalid << 17 ) + ( le.quarter_5_average_dbt_Invalid << 18 ) + ( le.combined_dbt_Invalid << 19 ) + ( le.total_account_balance_sign_Invalid << 20 ) + ( le.total_account_balance_Invalid << 21 ) + ( le.combined_account_balance_sign_Invalid << 22 ) + ( le.combined_account_balance_Invalid << 23 ) + ( le.collection_count_Invalid << 24 ) + ( le.atc021_Invalid << 25 ) + ( le.atc022_Invalid << 26 ) + ( le.atc023_Invalid << 27 ) + ( le.atc024_Invalid << 28 ) + ( le.atc025_Invalid << 29 ) + ( le.last_activity_age_code_Invalid << 30 ) + ( le.cottage_indicator_Invalid << 31 ) + ( le.nonprofit_indicator_Invalid << 32 ) + ( le.financial_stability_risk_score_Invalid << 33 ) + ( le.fsr_risk_class_Invalid << 34 ) + ( le.fsr_score_factor_1_Invalid << 35 ) + ( le.fsr_score_factor_2_Invalid << 36 ) + ( le.fsr_score_factor_3_Invalid << 37 ) + ( le.fsr_score_factor_4_Invalid << 38 ) + ( le.ip_score_change_sign_Invalid << 39 ) + ( le.ip_score_change_Invalid << 40 ) + ( le.fsr_score_change_sign_Invalid << 41 ) + ( le.fsr_score_change_Invalid << 42 ) + ( le.clean_dba_name_Invalid << 43 ) + ( le.predir_Invalid << 44 ) + ( le.prim_name_Invalid << 45 ) + ( le.postdir_Invalid << 46 ) + ( le.p_city_name_Invalid << 47 ) + ( le.v_city_name_Invalid << 48 ) + ( le.st_Invalid << 49 ) + ( le.zip_Invalid << 50 ) + ( le.zip4_Invalid << 51 ) + ( le.cart_Invalid << 52 ) + ( le.cr_sort_sz_Invalid << 53 ) + ( le.lot_Invalid << 54 ) + ( le.lot_order_Invalid << 55 ) + ( le.dbpc_Invalid << 56 ) + ( le.chk_digit_Invalid << 57 ) + ( le.fips_state_Invalid << 58 ) + ( le.fips_county_Invalid << 59 ) + ( le.geo_lat_Invalid << 60 ) + ( le.geo_long_Invalid << 61 ) + ( le.msa_Invalid << 62 ) + ( le.geo_match_Invalid << 63 );
    SELF.ScrubsBits4 := ( le.err_stat_Invalid << 0 ) + ( le.company_name_Invalid << 1 ) + ( le.p_fname_Invalid << 2 ) + ( le.p_mname_Invalid << 3 ) + ( le.p_lname_Invalid << 4 ) + ( le.raw_aid_Invalid << 5 ) + ( le.ace_aid_Invalid << 6 ) + ( le.prep_addr_line1_Invalid << 7 ) + ( le.prep_addr_line_last_Invalid << 8 ) + ( le.source_rec_id_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Experian_CRDB);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dotid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dotscore_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dotweight_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.empid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.empscore_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.empweight_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.powid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.powscore_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.powweight_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.proxscore_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.proxweight_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.selescore_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.seleweight_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orgscore_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orgweight_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.ultscore_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.ultweight_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.bdid_score_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.experian_bus_id_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.business_name_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.zip_plus_4_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.carrier_route_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.county_code_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.msa_code_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.establish_date_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.latest_reported_date_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.years_in_file_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.geo_code_latitude_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.geo_code_latitude_direction_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.geo_code_longitude_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.geo_code_longitude_direction_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.recent_update_code_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.years_in_business_code_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.year_business_started_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.months_in_file_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.address_type_code_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.estimated_number_of_employees_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.employee_size_code_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.estimated_annual_sales_amount_sign_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.estimated_annual_sales_amount_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.annual_sales_size_code_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.location_code_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.primary_sic_code_industry_classification_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.primary_sic_code_4_digit_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.primary_sic_code_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.second_sic_code_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.third_sic_code_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.fourth_sic_code_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.fifth_sic_code_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.sixth_sic_code_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.primary_naics_code_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.second_naics_code_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.third_naics_code_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.fourth_naics_code_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.executive_count_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.business_type_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.ownership_code_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF.derogatory_indicator_Invalid := (le.ScrubsBits2 >> 9) & 1;
    SELF.recent_derogatory_filed_date_Invalid := (le.ScrubsBits2 >> 10) & 1;
    SELF.derogatory_liability_amount_sign_Invalid := (le.ScrubsBits2 >> 11) & 1;
    SELF.derogatory_liability_amount_Invalid := (le.ScrubsBits2 >> 12) & 1;
    SELF.ucc_data_indicator_Invalid := (le.ScrubsBits2 >> 13) & 1;
    SELF.ucc_count_Invalid := (le.ScrubsBits2 >> 14) & 1;
    SELF.number_of_legal_items_Invalid := (le.ScrubsBits2 >> 15) & 1;
    SELF.legal_balance_sign_Invalid := (le.ScrubsBits2 >> 16) & 1;
    SELF.legal_balance_amount_Invalid := (le.ScrubsBits2 >> 17) & 1;
    SELF.pmtkbankruptcy_Invalid := (le.ScrubsBits2 >> 18) & 1;
    SELF.pmtkjudgment_Invalid := (le.ScrubsBits2 >> 19) & 1;
    SELF.pmtktaxlien_Invalid := (le.ScrubsBits2 >> 20) & 1;
    SELF.pmtkpayment_Invalid := (le.ScrubsBits2 >> 21) & 1;
    SELF.bankruptcy_filed_Invalid := (le.ScrubsBits2 >> 22) & 1;
    SELF.number_of_derogatory_legal_items_Invalid := (le.ScrubsBits2 >> 23) & 1;
    SELF.lien_count_Invalid := (le.ScrubsBits2 >> 24) & 1;
    SELF.judgment_count_Invalid := (le.ScrubsBits2 >> 25) & 1;
    SELF.bkc006_Invalid := (le.ScrubsBits2 >> 26) & 1;
    SELF.bkc007_Invalid := (le.ScrubsBits2 >> 27) & 1;
    SELF.bkc008_Invalid := (le.ScrubsBits2 >> 28) & 1;
    SELF.bko009_Invalid := (le.ScrubsBits2 >> 29) & 1;
    SELF.bkb001_sign_Invalid := (le.ScrubsBits2 >> 30) & 1;
    SELF.bkb001_Invalid := (le.ScrubsBits2 >> 31) & 1;
    SELF.bkb003_sign_Invalid := (le.ScrubsBits2 >> 32) & 1;
    SELF.bkb003_Invalid := (le.ScrubsBits2 >> 33) & 1;
    SELF.bko010_Invalid := (le.ScrubsBits2 >> 34) & 1;
    SELF.bko011_Invalid := (le.ScrubsBits2 >> 35) & 1;
    SELF.jdc010_Invalid := (le.ScrubsBits2 >> 36) & 1;
    SELF.jdc011_Invalid := (le.ScrubsBits2 >> 37) & 1;
    SELF.jdc012_Invalid := (le.ScrubsBits2 >> 38) & 1;
    SELF.jdb004_Invalid := (le.ScrubsBits2 >> 39) & 1;
    SELF.jdb005_Invalid := (le.ScrubsBits2 >> 40) & 1;
    SELF.jdb006_Invalid := (le.ScrubsBits2 >> 41) & 1;
    SELF.jDO013_Invalid := (le.ScrubsBits2 >> 42) & 1;
    SELF.jDO014_Invalid := (le.ScrubsBits2 >> 43) & 1;
    SELF.jdb002_Invalid := (le.ScrubsBits2 >> 44) & 1;
    SELF.jdp016_Invalid := (le.ScrubsBits2 >> 45) & 1;
    SELF.lgc004_Invalid := (le.ScrubsBits2 >> 46) & 1;
    SELF.pro001_Invalid := (le.ScrubsBits2 >> 47) & 1;
    SELF.pro003_Invalid := (le.ScrubsBits2 >> 48) & 1;
    SELF.txc010_Invalid := (le.ScrubsBits2 >> 49) & 1;
    SELF.txc011_Invalid := (le.ScrubsBits2 >> 50) & 1;
    SELF.txb004_sign_Invalid := (le.ScrubsBits2 >> 51) & 1;
    SELF.txb004_Invalid := (le.ScrubsBits2 >> 52) & 1;
    SELF.txo013_Invalid := (le.ScrubsBits2 >> 53) & 1;
    SELF.txb002_sign_Invalid := (le.ScrubsBits2 >> 54) & 1;
    SELF.txb002_Invalid := (le.ScrubsBits2 >> 55) & 1;
    SELF.txp016_Invalid := (le.ScrubsBits2 >> 56) & 1;
    SELF.ucc001_Invalid := (le.ScrubsBits2 >> 57) & 1;
    SELF.ucc002_Invalid := (le.ScrubsBits2 >> 58) & 1;
    SELF.ucc003_Invalid := (le.ScrubsBits2 >> 59) & 1;
    SELF.intelliscore_plus_Invalid := (le.ScrubsBits2 >> 60) & 1;
    SELF.percentile_model_Invalid := (le.ScrubsBits2 >> 61) & 1;
    SELF.model_action_Invalid := (le.ScrubsBits2 >> 62) & 1;
    SELF.score_factor_1_Invalid := (le.ScrubsBits2 >> 63) & 1;
    SELF.score_factor_2_Invalid := (le.ScrubsBits3 >> 0) & 1;
    SELF.score_factor_3_Invalid := (le.ScrubsBits3 >> 1) & 1;
    SELF.score_factor_4_Invalid := (le.ScrubsBits3 >> 2) & 1;
    SELF.model_type_Invalid := (le.ScrubsBits3 >> 3) & 1;
    SELF.last_experian_inquiry_date_Invalid := (le.ScrubsBits3 >> 4) & 1;
    SELF.recent_high_credit_sign_Invalid := (le.ScrubsBits3 >> 5) & 1;
    SELF.recent_high_credit_Invalid := (le.ScrubsBits3 >> 6) & 1;
    SELF.median_credit_amount_sign_Invalid := (le.ScrubsBits3 >> 7) & 1;
    SELF.median_credit_amount_Invalid := (le.ScrubsBits3 >> 8) & 1;
    SELF.total_combined_trade_lines_count_Invalid := (le.ScrubsBits3 >> 9) & 1;
    SELF.dbt_of_combined_trade_totals_Invalid := (le.ScrubsBits3 >> 10) & 1;
    SELF.combined_trade_balance_Invalid := (le.ScrubsBits3 >> 11) & 1;
    SELF.aged_trade_lines_Invalid := (le.ScrubsBits3 >> 12) & 1;
    SELF.experian_credit_rating_Invalid := (le.ScrubsBits3 >> 13) & 1;
    SELF.quarter_1_average_dbt_Invalid := (le.ScrubsBits3 >> 14) & 1;
    SELF.quarter_2_average_dbt_Invalid := (le.ScrubsBits3 >> 15) & 1;
    SELF.quarter_3_average_dbt_Invalid := (le.ScrubsBits3 >> 16) & 1;
    SELF.quarter_4_average_dbt_Invalid := (le.ScrubsBits3 >> 17) & 1;
    SELF.quarter_5_average_dbt_Invalid := (le.ScrubsBits3 >> 18) & 1;
    SELF.combined_dbt_Invalid := (le.ScrubsBits3 >> 19) & 1;
    SELF.total_account_balance_sign_Invalid := (le.ScrubsBits3 >> 20) & 1;
    SELF.total_account_balance_Invalid := (le.ScrubsBits3 >> 21) & 1;
    SELF.combined_account_balance_sign_Invalid := (le.ScrubsBits3 >> 22) & 1;
    SELF.combined_account_balance_Invalid := (le.ScrubsBits3 >> 23) & 1;
    SELF.collection_count_Invalid := (le.ScrubsBits3 >> 24) & 1;
    SELF.atc021_Invalid := (le.ScrubsBits3 >> 25) & 1;
    SELF.atc022_Invalid := (le.ScrubsBits3 >> 26) & 1;
    SELF.atc023_Invalid := (le.ScrubsBits3 >> 27) & 1;
    SELF.atc024_Invalid := (le.ScrubsBits3 >> 28) & 1;
    SELF.atc025_Invalid := (le.ScrubsBits3 >> 29) & 1;
    SELF.last_activity_age_code_Invalid := (le.ScrubsBits3 >> 30) & 1;
    SELF.cottage_indicator_Invalid := (le.ScrubsBits3 >> 31) & 1;
    SELF.nonprofit_indicator_Invalid := (le.ScrubsBits3 >> 32) & 1;
    SELF.financial_stability_risk_score_Invalid := (le.ScrubsBits3 >> 33) & 1;
    SELF.fsr_risk_class_Invalid := (le.ScrubsBits3 >> 34) & 1;
    SELF.fsr_score_factor_1_Invalid := (le.ScrubsBits3 >> 35) & 1;
    SELF.fsr_score_factor_2_Invalid := (le.ScrubsBits3 >> 36) & 1;
    SELF.fsr_score_factor_3_Invalid := (le.ScrubsBits3 >> 37) & 1;
    SELF.fsr_score_factor_4_Invalid := (le.ScrubsBits3 >> 38) & 1;
    SELF.ip_score_change_sign_Invalid := (le.ScrubsBits3 >> 39) & 1;
    SELF.ip_score_change_Invalid := (le.ScrubsBits3 >> 40) & 1;
    SELF.fsr_score_change_sign_Invalid := (le.ScrubsBits3 >> 41) & 1;
    SELF.fsr_score_change_Invalid := (le.ScrubsBits3 >> 42) & 1;
    SELF.clean_dba_name_Invalid := (le.ScrubsBits3 >> 43) & 1;
    SELF.predir_Invalid := (le.ScrubsBits3 >> 44) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits3 >> 45) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits3 >> 46) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits3 >> 47) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits3 >> 48) & 1;
    SELF.st_Invalid := (le.ScrubsBits3 >> 49) & 1;
    SELF.zip_Invalid := (le.ScrubsBits3 >> 50) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits3 >> 51) & 1;
    SELF.cart_Invalid := (le.ScrubsBits3 >> 52) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits3 >> 53) & 1;
    SELF.lot_Invalid := (le.ScrubsBits3 >> 54) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits3 >> 55) & 1;
    SELF.dbpc_Invalid := (le.ScrubsBits3 >> 56) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits3 >> 57) & 1;
    SELF.fips_state_Invalid := (le.ScrubsBits3 >> 58) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits3 >> 59) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits3 >> 60) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits3 >> 61) & 1;
    SELF.msa_Invalid := (le.ScrubsBits3 >> 62) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits3 >> 63) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits4 >> 0) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits4 >> 1) & 1;
    SELF.p_fname_Invalid := (le.ScrubsBits4 >> 2) & 1;
    SELF.p_mname_Invalid := (le.ScrubsBits4 >> 3) & 1;
    SELF.p_lname_Invalid := (le.ScrubsBits4 >> 4) & 1;
    SELF.raw_aid_Invalid := (le.ScrubsBits4 >> 5) & 1;
    SELF.ace_aid_Invalid := (le.ScrubsBits4 >> 6) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits4 >> 7) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits4 >> 8) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits4 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dotid_ENUM_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotscore_ENUM_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotweight_ENUM_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    empid_ENUM_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empscore_ENUM_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empweight_ENUM_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    powid_CUSTOM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powscore_CUSTOM_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powweight_CUSTOM_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    proxid_CUSTOM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxscore_CUSTOM_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxweight_CUSTOM_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    seleid_CUSTOM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    selescore_CUSTOM_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    seleweight_CUSTOM_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    orgid_CUSTOM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgscore_CUSTOM_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgweight_CUSTOM_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    ultid_CUSTOM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultscore_CUSTOM_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultweight_CUSTOM_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_score_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    did_CUSTOM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    experian_bus_id_CUSTOM_ErrorCount := COUNT(GROUP,h.experian_bus_id_Invalid=1);
    business_name_CUSTOM_ErrorCount := COUNT(GROUP,h.business_name_Invalid=1);
    address_CUSTOM_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    zip_plus_4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_plus_4_Invalid=1);
    carrier_route_ALLOW_ErrorCount := COUNT(GROUP,h.carrier_route_Invalid=1);
    county_code_CUSTOM_ErrorCount := COUNT(GROUP,h.county_code_Invalid=1);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    phone_number_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    msa_code_CUSTOM_ErrorCount := COUNT(GROUP,h.msa_code_Invalid=1);
    establish_date_CUSTOM_ErrorCount := COUNT(GROUP,h.establish_date_Invalid=1);
    latest_reported_date_CUSTOM_ErrorCount := COUNT(GROUP,h.latest_reported_date_Invalid=1);
    years_in_file_CUSTOM_ErrorCount := COUNT(GROUP,h.years_in_file_Invalid=1);
    geo_code_latitude_ALLOW_ErrorCount := COUNT(GROUP,h.geo_code_latitude_Invalid=1);
    geo_code_latitude_direction_ALLOW_ErrorCount := COUNT(GROUP,h.geo_code_latitude_direction_Invalid=1);
    geo_code_longitude_ALLOW_ErrorCount := COUNT(GROUP,h.geo_code_longitude_Invalid=1);
    geo_code_longitude_direction_ALLOW_ErrorCount := COUNT(GROUP,h.geo_code_longitude_direction_Invalid=1);
    recent_update_code_ENUM_ErrorCount := COUNT(GROUP,h.recent_update_code_Invalid=1);
    years_in_business_code_ALLOW_ErrorCount := COUNT(GROUP,h.years_in_business_code_Invalid=1);
    year_business_started_CUSTOM_ErrorCount := COUNT(GROUP,h.year_business_started_Invalid=1);
    months_in_file_CUSTOM_ErrorCount := COUNT(GROUP,h.months_in_file_Invalid=1);
    address_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.address_type_code_Invalid=1);
    estimated_number_of_employees_CUSTOM_ErrorCount := COUNT(GROUP,h.estimated_number_of_employees_Invalid=1);
    employee_size_code_ALLOW_ErrorCount := COUNT(GROUP,h.employee_size_code_Invalid=1);
    estimated_annual_sales_amount_sign_ENUM_ErrorCount := COUNT(GROUP,h.estimated_annual_sales_amount_sign_Invalid=1);
    estimated_annual_sales_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.estimated_annual_sales_amount_Invalid=1);
    annual_sales_size_code_ENUM_ErrorCount := COUNT(GROUP,h.annual_sales_size_code_Invalid=1);
    location_code_ENUM_ErrorCount := COUNT(GROUP,h.location_code_Invalid=1);
    primary_sic_code_industry_classification_ENUM_ErrorCount := COUNT(GROUP,h.primary_sic_code_industry_classification_Invalid=1);
    primary_sic_code_4_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_sic_code_4_digit_Invalid=1);
    primary_sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_sic_code_Invalid=1);
    second_sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.second_sic_code_Invalid=1);
    third_sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.third_sic_code_Invalid=1);
    fourth_sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.fourth_sic_code_Invalid=1);
    fifth_sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.fifth_sic_code_Invalid=1);
    sixth_sic_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sixth_sic_code_Invalid=1);
    primary_naics_code_CUSTOM_ErrorCount := COUNT(GROUP,h.primary_naics_code_Invalid=1);
    second_naics_code_CUSTOM_ErrorCount := COUNT(GROUP,h.second_naics_code_Invalid=1);
    third_naics_code_CUSTOM_ErrorCount := COUNT(GROUP,h.third_naics_code_Invalid=1);
    fourth_naics_code_CUSTOM_ErrorCount := COUNT(GROUP,h.fourth_naics_code_Invalid=1);
    executive_count_CUSTOM_ErrorCount := COUNT(GROUP,h.executive_count_Invalid=1);
    business_type_ALLOW_ErrorCount := COUNT(GROUP,h.business_type_Invalid=1);
    ownership_code_ALLOW_ErrorCount := COUNT(GROUP,h.ownership_code_Invalid=1);
    derogatory_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.derogatory_indicator_Invalid=1);
    recent_derogatory_filed_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recent_derogatory_filed_date_Invalid=1);
    derogatory_liability_amount_sign_ENUM_ErrorCount := COUNT(GROUP,h.derogatory_liability_amount_sign_Invalid=1);
    derogatory_liability_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.derogatory_liability_amount_Invalid=1);
    ucc_data_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.ucc_data_indicator_Invalid=1);
    ucc_count_CUSTOM_ErrorCount := COUNT(GROUP,h.ucc_count_Invalid=1);
    number_of_legal_items_CUSTOM_ErrorCount := COUNT(GROUP,h.number_of_legal_items_Invalid=1);
    legal_balance_sign_ENUM_ErrorCount := COUNT(GROUP,h.legal_balance_sign_Invalid=1);
    legal_balance_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.legal_balance_amount_Invalid=1);
    pmtkbankruptcy_ENUM_ErrorCount := COUNT(GROUP,h.pmtkbankruptcy_Invalid=1);
    pmtkjudgment_ENUM_ErrorCount := COUNT(GROUP,h.pmtkjudgment_Invalid=1);
    pmtktaxlien_ENUM_ErrorCount := COUNT(GROUP,h.pmtktaxlien_Invalid=1);
    pmtkpayment_ENUM_ErrorCount := COUNT(GROUP,h.pmtkpayment_Invalid=1);
    bankruptcy_filed_ENUM_ErrorCount := COUNT(GROUP,h.bankruptcy_filed_Invalid=1);
    number_of_derogatory_legal_items_CUSTOM_ErrorCount := COUNT(GROUP,h.number_of_derogatory_legal_items_Invalid=1);
    lien_count_CUSTOM_ErrorCount := COUNT(GROUP,h.lien_count_Invalid=1);
    judgment_count_CUSTOM_ErrorCount := COUNT(GROUP,h.judgment_count_Invalid=1);
    bkc006_CUSTOM_ErrorCount := COUNT(GROUP,h.bkc006_Invalid=1);
    bkc007_CUSTOM_ErrorCount := COUNT(GROUP,h.bkc007_Invalid=1);
    bkc008_CUSTOM_ErrorCount := COUNT(GROUP,h.bkc008_Invalid=1);
    bko009_CUSTOM_ErrorCount := COUNT(GROUP,h.bko009_Invalid=1);
    bkb001_sign_ENUM_ErrorCount := COUNT(GROUP,h.bkb001_sign_Invalid=1);
    bkb001_CUSTOM_ErrorCount := COUNT(GROUP,h.bkb001_Invalid=1);
    bkb003_sign_ENUM_ErrorCount := COUNT(GROUP,h.bkb003_sign_Invalid=1);
    bkb003_CUSTOM_ErrorCount := COUNT(GROUP,h.bkb003_Invalid=1);
    bko010_CUSTOM_ErrorCount := COUNT(GROUP,h.bko010_Invalid=1);
    bko011_CUSTOM_ErrorCount := COUNT(GROUP,h.bko011_Invalid=1);
    jdc010_CUSTOM_ErrorCount := COUNT(GROUP,h.jdc010_Invalid=1);
    jdc011_CUSTOM_ErrorCount := COUNT(GROUP,h.jdc011_Invalid=1);
    jdc012_CUSTOM_ErrorCount := COUNT(GROUP,h.jdc012_Invalid=1);
    jdb004_CUSTOM_ErrorCount := COUNT(GROUP,h.jdb004_Invalid=1);
    jdb005_CUSTOM_ErrorCount := COUNT(GROUP,h.jdb005_Invalid=1);
    jdb006_CUSTOM_ErrorCount := COUNT(GROUP,h.jdb006_Invalid=1);
    jDO013_CUSTOM_ErrorCount := COUNT(GROUP,h.jDO013_Invalid=1);
    jDO014_CUSTOM_ErrorCount := COUNT(GROUP,h.jDO014_Invalid=1);
    jdb002_CUSTOM_ErrorCount := COUNT(GROUP,h.jdb002_Invalid=1);
    jdp016_CUSTOM_ErrorCount := COUNT(GROUP,h.jdp016_Invalid=1);
    lgc004_CUSTOM_ErrorCount := COUNT(GROUP,h.lgc004_Invalid=1);
    pro001_CUSTOM_ErrorCount := COUNT(GROUP,h.pro001_Invalid=1);
    pro003_CUSTOM_ErrorCount := COUNT(GROUP,h.pro003_Invalid=1);
    txc010_CUSTOM_ErrorCount := COUNT(GROUP,h.txc010_Invalid=1);
    txc011_CUSTOM_ErrorCount := COUNT(GROUP,h.txc011_Invalid=1);
    txb004_sign_ENUM_ErrorCount := COUNT(GROUP,h.txb004_sign_Invalid=1);
    txb004_CUSTOM_ErrorCount := COUNT(GROUP,h.txb004_Invalid=1);
    txo013_CUSTOM_ErrorCount := COUNT(GROUP,h.txo013_Invalid=1);
    txb002_sign_ENUM_ErrorCount := COUNT(GROUP,h.txb002_sign_Invalid=1);
    txb002_CUSTOM_ErrorCount := COUNT(GROUP,h.txb002_Invalid=1);
    txp016_CUSTOM_ErrorCount := COUNT(GROUP,h.txp016_Invalid=1);
    ucc001_CUSTOM_ErrorCount := COUNT(GROUP,h.ucc001_Invalid=1);
    ucc002_CUSTOM_ErrorCount := COUNT(GROUP,h.ucc002_Invalid=1);
    ucc003_CUSTOM_ErrorCount := COUNT(GROUP,h.ucc003_Invalid=1);
    intelliscore_plus_CUSTOM_ErrorCount := COUNT(GROUP,h.intelliscore_plus_Invalid=1);
    percentile_model_CUSTOM_ErrorCount := COUNT(GROUP,h.percentile_model_Invalid=1);
    model_action_ENUM_ErrorCount := COUNT(GROUP,h.model_action_Invalid=1);
    score_factor_1_CUSTOM_ErrorCount := COUNT(GROUP,h.score_factor_1_Invalid=1);
    score_factor_2_CUSTOM_ErrorCount := COUNT(GROUP,h.score_factor_2_Invalid=1);
    score_factor_3_CUSTOM_ErrorCount := COUNT(GROUP,h.score_factor_3_Invalid=1);
    score_factor_4_CUSTOM_ErrorCount := COUNT(GROUP,h.score_factor_4_Invalid=1);
    model_type_ALLOW_ErrorCount := COUNT(GROUP,h.model_type_Invalid=1);
    last_experian_inquiry_date_CUSTOM_ErrorCount := COUNT(GROUP,h.last_experian_inquiry_date_Invalid=1);
    recent_high_credit_sign_ENUM_ErrorCount := COUNT(GROUP,h.recent_high_credit_sign_Invalid=1);
    recent_high_credit_CUSTOM_ErrorCount := COUNT(GROUP,h.recent_high_credit_Invalid=1);
    median_credit_amount_sign_ENUM_ErrorCount := COUNT(GROUP,h.median_credit_amount_sign_Invalid=1);
    median_credit_amount_CUSTOM_ErrorCount := COUNT(GROUP,h.median_credit_amount_Invalid=1);
    total_combined_trade_lines_count_CUSTOM_ErrorCount := COUNT(GROUP,h.total_combined_trade_lines_count_Invalid=1);
    dbt_of_combined_trade_totals_CUSTOM_ErrorCount := COUNT(GROUP,h.dbt_of_combined_trade_totals_Invalid=1);
    combined_trade_balance_CUSTOM_ErrorCount := COUNT(GROUP,h.combined_trade_balance_Invalid=1);
    aged_trade_lines_ALLOW_ErrorCount := COUNT(GROUP,h.aged_trade_lines_Invalid=1);
    experian_credit_rating_ALLOW_ErrorCount := COUNT(GROUP,h.experian_credit_rating_Invalid=1);
    quarter_1_average_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.quarter_1_average_dbt_Invalid=1);
    quarter_2_average_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.quarter_2_average_dbt_Invalid=1);
    quarter_3_average_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.quarter_3_average_dbt_Invalid=1);
    quarter_4_average_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.quarter_4_average_dbt_Invalid=1);
    quarter_5_average_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.quarter_5_average_dbt_Invalid=1);
    combined_dbt_CUSTOM_ErrorCount := COUNT(GROUP,h.combined_dbt_Invalid=1);
    total_account_balance_sign_ENUM_ErrorCount := COUNT(GROUP,h.total_account_balance_sign_Invalid=1);
    total_account_balance_CUSTOM_ErrorCount := COUNT(GROUP,h.total_account_balance_Invalid=1);
    combined_account_balance_sign_ENUM_ErrorCount := COUNT(GROUP,h.combined_account_balance_sign_Invalid=1);
    combined_account_balance_CUSTOM_ErrorCount := COUNT(GROUP,h.combined_account_balance_Invalid=1);
    collection_count_CUSTOM_ErrorCount := COUNT(GROUP,h.collection_count_Invalid=1);
    atc021_CUSTOM_ErrorCount := COUNT(GROUP,h.atc021_Invalid=1);
    atc022_CUSTOM_ErrorCount := COUNT(GROUP,h.atc022_Invalid=1);
    atc023_CUSTOM_ErrorCount := COUNT(GROUP,h.atc023_Invalid=1);
    atc024_CUSTOM_ErrorCount := COUNT(GROUP,h.atc024_Invalid=1);
    atc025_CUSTOM_ErrorCount := COUNT(GROUP,h.atc025_Invalid=1);
    last_activity_age_code_ALLOW_ErrorCount := COUNT(GROUP,h.last_activity_age_code_Invalid=1);
    cottage_indicator_ENUM_ErrorCount := COUNT(GROUP,h.cottage_indicator_Invalid=1);
    nonprofit_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.nonprofit_indicator_Invalid=1);
    financial_stability_risk_score_CUSTOM_ErrorCount := COUNT(GROUP,h.financial_stability_risk_score_Invalid=1);
    fsr_risk_class_ALLOW_ErrorCount := COUNT(GROUP,h.fsr_risk_class_Invalid=1);
    fsr_score_factor_1_CUSTOM_ErrorCount := COUNT(GROUP,h.fsr_score_factor_1_Invalid=1);
    fsr_score_factor_2_CUSTOM_ErrorCount := COUNT(GROUP,h.fsr_score_factor_2_Invalid=1);
    fsr_score_factor_3_CUSTOM_ErrorCount := COUNT(GROUP,h.fsr_score_factor_3_Invalid=1);
    fsr_score_factor_4_CUSTOM_ErrorCount := COUNT(GROUP,h.fsr_score_factor_4_Invalid=1);
    ip_score_change_sign_ENUM_ErrorCount := COUNT(GROUP,h.ip_score_change_sign_Invalid=1);
    ip_score_change_CUSTOM_ErrorCount := COUNT(GROUP,h.ip_score_change_Invalid=1);
    fsr_score_change_sign_ENUM_ErrorCount := COUNT(GROUP,h.fsr_score_change_sign_Invalid=1);
    fsr_score_change_CUSTOM_ErrorCount := COUNT(GROUP,h.fsr_score_change_Invalid=1);
    clean_dba_name_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_dba_name_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    p_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_CUSTOM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_CUSTOM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_CUSTOM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_CUSTOM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ENUM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dbpc_CUSTOM_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    chk_digit_CUSTOM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    fips_state_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=1);
    fips_county_CUSTOM_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_CUSTOM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_match_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_CUSTOM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    p_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.p_fname_Invalid=1);
    p_mname_CUSTOM_ErrorCount := COUNT(GROUP,h.p_mname_Invalid=1);
    p_lname_CUSTOM_ErrorCount := COUNT(GROUP,h.p_lname_Invalid=1);
    raw_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.raw_aid_Invalid=1);
    ace_aid_CUSTOM_ErrorCount := COUNT(GROUP,h.ace_aid_Invalid=1);
    prep_addr_line1_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_CUSTOM_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    source_rec_id_CUSTOM_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dotid_Invalid > 0 OR h.dotscore_Invalid > 0 OR h.dotweight_Invalid > 0 OR h.empid_Invalid > 0 OR h.empscore_Invalid > 0 OR h.empweight_Invalid > 0 OR h.powid_Invalid > 0 OR h.powscore_Invalid > 0 OR h.powweight_Invalid > 0 OR h.proxid_Invalid > 0 OR h.proxscore_Invalid > 0 OR h.proxweight_Invalid > 0 OR h.seleid_Invalid > 0 OR h.selescore_Invalid > 0 OR h.seleweight_Invalid > 0 OR h.orgid_Invalid > 0 OR h.orgscore_Invalid > 0 OR h.orgweight_Invalid > 0 OR h.ultid_Invalid > 0 OR h.ultscore_Invalid > 0 OR h.ultweight_Invalid > 0 OR h.bdid_Invalid > 0 OR h.bdid_score_Invalid > 0 OR h.did_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.experian_bus_id_Invalid > 0 OR h.business_name_Invalid > 0 OR h.address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.zip_plus_4_Invalid > 0 OR h.carrier_route_Invalid > 0 OR h.county_code_Invalid > 0 OR h.county_name_Invalid > 0 OR h.phone_number_Invalid > 0 OR h.msa_code_Invalid > 0 OR h.establish_date_Invalid > 0 OR h.latest_reported_date_Invalid > 0 OR h.years_in_file_Invalid > 0 OR h.geo_code_latitude_Invalid > 0 OR h.geo_code_latitude_direction_Invalid > 0 OR h.geo_code_longitude_Invalid > 0 OR h.geo_code_longitude_direction_Invalid > 0 OR h.recent_update_code_Invalid > 0 OR h.years_in_business_code_Invalid > 0 OR h.year_business_started_Invalid > 0 OR h.months_in_file_Invalid > 0 OR h.address_type_code_Invalid > 0 OR h.estimated_number_of_employees_Invalid > 0 OR h.employee_size_code_Invalid > 0 OR h.estimated_annual_sales_amount_sign_Invalid > 0 OR h.estimated_annual_sales_amount_Invalid > 0 OR h.annual_sales_size_code_Invalid > 0 OR h.location_code_Invalid > 0 OR h.primary_sic_code_industry_classification_Invalid > 0 OR h.primary_sic_code_4_digit_Invalid > 0 OR h.primary_sic_code_Invalid > 0 OR h.second_sic_code_Invalid > 0 OR h.third_sic_code_Invalid > 0 OR h.fourth_sic_code_Invalid > 0 OR h.fifth_sic_code_Invalid > 0 OR h.sixth_sic_code_Invalid > 0 OR h.primary_naics_code_Invalid > 0 OR h.second_naics_code_Invalid > 0 OR h.third_naics_code_Invalid > 0 OR h.fourth_naics_code_Invalid > 0 OR h.executive_count_Invalid > 0 OR h.business_type_Invalid > 0 OR h.ownership_code_Invalid > 0 OR h.derogatory_indicator_Invalid > 0 OR h.recent_derogatory_filed_date_Invalid > 0 OR h.derogatory_liability_amount_sign_Invalid > 0 OR h.derogatory_liability_amount_Invalid > 0 OR h.ucc_data_indicator_Invalid > 0 OR h.ucc_count_Invalid > 0 OR h.number_of_legal_items_Invalid > 0 OR h.legal_balance_sign_Invalid > 0 OR h.legal_balance_amount_Invalid > 0 OR h.pmtkbankruptcy_Invalid > 0 OR h.pmtkjudgment_Invalid > 0 OR h.pmtktaxlien_Invalid > 0 OR h.pmtkpayment_Invalid > 0 OR h.bankruptcy_filed_Invalid > 0 OR h.number_of_derogatory_legal_items_Invalid > 0 OR h.lien_count_Invalid > 0 OR h.judgment_count_Invalid > 0 OR h.bkc006_Invalid > 0 OR h.bkc007_Invalid > 0 OR h.bkc008_Invalid > 0 OR h.bko009_Invalid > 0 OR h.bkb001_sign_Invalid > 0 OR h.bkb001_Invalid > 0 OR h.bkb003_sign_Invalid > 0 OR h.bkb003_Invalid > 0 OR h.bko010_Invalid > 0 OR h.bko011_Invalid > 0 OR h.jdc010_Invalid > 0 OR h.jdc011_Invalid > 0 OR h.jdc012_Invalid > 0 OR h.jdb004_Invalid > 0 OR h.jdb005_Invalid > 0 OR h.jdb006_Invalid > 0 OR h.jDO013_Invalid > 0 OR h.jDO014_Invalid > 0 OR h.jdb002_Invalid > 0 OR h.jdp016_Invalid > 0 OR h.lgc004_Invalid > 0 OR h.pro001_Invalid > 0 OR h.pro003_Invalid > 0 OR h.txc010_Invalid > 0 OR h.txc011_Invalid > 0 OR h.txb004_sign_Invalid > 0 OR h.txb004_Invalid > 0 OR h.txo013_Invalid > 0 OR h.txb002_sign_Invalid > 0 OR h.txb002_Invalid > 0 OR h.txp016_Invalid > 0 OR h.ucc001_Invalid > 0 OR h.ucc002_Invalid > 0 OR h.ucc003_Invalid > 0 OR h.intelliscore_plus_Invalid > 0 OR h.percentile_model_Invalid > 0 OR h.model_action_Invalid > 0 OR h.score_factor_1_Invalid > 0 OR h.score_factor_2_Invalid > 0 OR h.score_factor_3_Invalid > 0 OR h.score_factor_4_Invalid > 0 OR h.model_type_Invalid > 0 OR h.last_experian_inquiry_date_Invalid > 0 OR h.recent_high_credit_sign_Invalid > 0 OR h.recent_high_credit_Invalid > 0 OR h.median_credit_amount_sign_Invalid > 0 OR h.median_credit_amount_Invalid > 0 OR h.total_combined_trade_lines_count_Invalid > 0 OR h.dbt_of_combined_trade_totals_Invalid > 0 OR h.combined_trade_balance_Invalid > 0 OR h.aged_trade_lines_Invalid > 0 OR h.experian_credit_rating_Invalid > 0 OR h.quarter_1_average_dbt_Invalid > 0 OR h.quarter_2_average_dbt_Invalid > 0 OR h.quarter_3_average_dbt_Invalid > 0 OR h.quarter_4_average_dbt_Invalid > 0 OR h.quarter_5_average_dbt_Invalid > 0 OR h.combined_dbt_Invalid > 0 OR h.total_account_balance_sign_Invalid > 0 OR h.total_account_balance_Invalid > 0 OR h.combined_account_balance_sign_Invalid > 0 OR h.combined_account_balance_Invalid > 0 OR h.collection_count_Invalid > 0 OR h.atc021_Invalid > 0 OR h.atc022_Invalid > 0 OR h.atc023_Invalid > 0 OR h.atc024_Invalid > 0 OR h.atc025_Invalid > 0 OR h.last_activity_age_code_Invalid > 0 OR h.cottage_indicator_Invalid > 0 OR h.nonprofit_indicator_Invalid > 0 OR h.financial_stability_risk_score_Invalid > 0 OR h.fsr_risk_class_Invalid > 0 OR h.fsr_score_factor_1_Invalid > 0 OR h.fsr_score_factor_2_Invalid > 0 OR h.fsr_score_factor_3_Invalid > 0 OR h.fsr_score_factor_4_Invalid > 0 OR h.ip_score_change_sign_Invalid > 0 OR h.ip_score_change_Invalid > 0 OR h.fsr_score_change_sign_Invalid > 0 OR h.fsr_score_change_Invalid > 0 OR h.clean_dba_name_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.postdir_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.fips_state_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.company_name_Invalid > 0 OR h.p_fname_Invalid > 0 OR h.p_mname_Invalid > 0 OR h.p_lname_Invalid > 0 OR h.raw_aid_Invalid > 0 OR h.ace_aid_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_line_last_Invalid > 0 OR h.source_rec_id_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dotid_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.empid_ENUM_ErrorCount > 0, 1, 0) + IF(le.empscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.empweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.selescore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.experian_bus_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_plus_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_route_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.establish_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.latest_reported_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.years_in_file_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_code_latitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_code_latitude_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_code_longitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_code_longitude_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recent_update_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.years_in_business_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_business_started_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.months_in_file_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.estimated_number_of_employees_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.employee_size_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.estimated_annual_sales_amount_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.estimated_annual_sales_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.annual_sales_size_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.location_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_code_industry_classification_ENUM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_code_4_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.third_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fourth_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fifth_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sixth_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.third_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fourth_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ownership_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.derogatory_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recent_derogatory_filed_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.derogatory_liability_amount_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.derogatory_liability_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ucc_data_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ucc_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.number_of_legal_items_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.legal_balance_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.legal_balance_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pmtkbankruptcy_ENUM_ErrorCount > 0, 1, 0) + IF(le.pmtkjudgment_ENUM_ErrorCount > 0, 1, 0) + IF(le.pmtktaxlien_ENUM_ErrorCount > 0, 1, 0) + IF(le.pmtkpayment_ENUM_ErrorCount > 0, 1, 0) + IF(le.bankruptcy_filed_ENUM_ErrorCount > 0, 1, 0) + IF(le.number_of_derogatory_legal_items_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lien_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judgment_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkc006_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkc007_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkc008_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bko009_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkb001_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.bkb001_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkb003_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.bkb003_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bko010_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bko011_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdc010_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdc011_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdc012_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdb004_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdb005_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdb006_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jDO013_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jDO014_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdb002_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdp016_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lgc004_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pro001_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pro003_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txc010_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txc011_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txb004_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.txb004_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txo013_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txb002_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.txb002_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txp016_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ucc001_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ucc002_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ucc003_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.intelliscore_plus_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.percentile_model_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.model_action_ENUM_ErrorCount > 0, 1, 0) + IF(le.score_factor_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_factor_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_factor_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_factor_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.model_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_experian_inquiry_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.median_credit_amount_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.median_credit_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_combined_trade_lines_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_of_combined_trade_totals_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.combined_trade_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.aged_trade_lines_ALLOW_ErrorCount > 0, 1, 0) + IF(le.experian_credit_rating_ALLOW_ErrorCount > 0, 1, 0) + IF(le.quarter_1_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_2_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_3_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_4_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_5_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.combined_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_account_balance_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.total_account_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.combined_account_balance_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.combined_account_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.collection_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc021_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc022_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc023_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc024_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc025_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_activity_age_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cottage_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.nonprofit_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.financial_stability_risk_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_risk_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fsr_score_factor_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_factor_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_factor_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_factor_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ip_score_change_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.ip_score_change_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_change_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_change_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_dba_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dbpc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.raw_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dotid_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.dotweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.empid_ENUM_ErrorCount > 0, 1, 0) + IF(le.empscore_ENUM_ErrorCount > 0, 1, 0) + IF(le.empweight_ENUM_ErrorCount > 0, 1, 0) + IF(le.powid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.powweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.proxweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.selescore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seleweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orgweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultscore_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ultweight_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.experian_bus_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_plus_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_route_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.establish_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.latest_reported_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.years_in_file_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_code_latitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_code_latitude_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_code_longitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_code_longitude_direction_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recent_update_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.years_in_business_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.year_business_started_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.months_in_file_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.estimated_number_of_employees_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.employee_size_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.estimated_annual_sales_amount_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.estimated_annual_sales_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.annual_sales_size_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.location_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_code_industry_classification_ENUM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_code_4_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.third_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fourth_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fifth_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sixth_sic_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.primary_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.third_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fourth_naics_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.executive_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.business_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ownership_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.derogatory_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recent_derogatory_filed_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.derogatory_liability_amount_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.derogatory_liability_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ucc_data_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ucc_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.number_of_legal_items_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.legal_balance_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.legal_balance_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pmtkbankruptcy_ENUM_ErrorCount > 0, 1, 0) + IF(le.pmtkjudgment_ENUM_ErrorCount > 0, 1, 0) + IF(le.pmtktaxlien_ENUM_ErrorCount > 0, 1, 0) + IF(le.pmtkpayment_ENUM_ErrorCount > 0, 1, 0) + IF(le.bankruptcy_filed_ENUM_ErrorCount > 0, 1, 0) + IF(le.number_of_derogatory_legal_items_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lien_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judgment_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkc006_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkc007_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkc008_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bko009_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkb001_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.bkb001_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkb003_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.bkb003_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bko010_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bko011_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdc010_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdc011_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdc012_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdb004_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdb005_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdb006_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jDO013_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jDO014_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdb002_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.jdp016_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lgc004_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pro001_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pro003_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txc010_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txc011_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txb004_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.txb004_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txo013_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txb002_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.txb002_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.txp016_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ucc001_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ucc002_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ucc003_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.intelliscore_plus_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.percentile_model_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.model_action_ENUM_ErrorCount > 0, 1, 0) + IF(le.score_factor_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_factor_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_factor_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_factor_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.model_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_experian_inquiry_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.recent_high_credit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.median_credit_amount_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.median_credit_amount_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_combined_trade_lines_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dbt_of_combined_trade_totals_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.combined_trade_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.aged_trade_lines_ALLOW_ErrorCount > 0, 1, 0) + IF(le.experian_credit_rating_ALLOW_ErrorCount > 0, 1, 0) + IF(le.quarter_1_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_2_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_3_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_4_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.quarter_5_average_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.combined_dbt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.total_account_balance_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.total_account_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.combined_account_balance_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.combined_account_balance_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.collection_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc021_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc022_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc023_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc024_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.atc025_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.last_activity_age_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cottage_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.nonprofit_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.financial_stability_risk_score_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_risk_class_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fsr_score_factor_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_factor_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_factor_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_factor_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ip_score_change_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.ip_score_change_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_change_sign_ENUM_ErrorCount > 0, 1, 0) + IF(le.fsr_score_change_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_dba_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.st_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cart_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dbpc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chk_digit_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fips_county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_match_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.err_stat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.raw_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ace_aid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.did_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.experian_bus_id_Invalid,le.business_name_Invalid,le.address_Invalid,le.city_Invalid,le.state_Invalid,le.zip_code_Invalid,le.zip_plus_4_Invalid,le.carrier_route_Invalid,le.county_code_Invalid,le.county_name_Invalid,le.phone_number_Invalid,le.msa_code_Invalid,le.establish_date_Invalid,le.latest_reported_date_Invalid,le.years_in_file_Invalid,le.geo_code_latitude_Invalid,le.geo_code_latitude_direction_Invalid,le.geo_code_longitude_Invalid,le.geo_code_longitude_direction_Invalid,le.recent_update_code_Invalid,le.years_in_business_code_Invalid,le.year_business_started_Invalid,le.months_in_file_Invalid,le.address_type_code_Invalid,le.estimated_number_of_employees_Invalid,le.employee_size_code_Invalid,le.estimated_annual_sales_amount_sign_Invalid,le.estimated_annual_sales_amount_Invalid,le.annual_sales_size_code_Invalid,le.location_code_Invalid,le.primary_sic_code_industry_classification_Invalid,le.primary_sic_code_4_digit_Invalid,le.primary_sic_code_Invalid,le.second_sic_code_Invalid,le.third_sic_code_Invalid,le.fourth_sic_code_Invalid,le.fifth_sic_code_Invalid,le.sixth_sic_code_Invalid,le.primary_naics_code_Invalid,le.second_naics_code_Invalid,le.third_naics_code_Invalid,le.fourth_naics_code_Invalid,le.executive_count_Invalid,le.business_type_Invalid,le.ownership_code_Invalid,le.derogatory_indicator_Invalid,le.recent_derogatory_filed_date_Invalid,le.derogatory_liability_amount_sign_Invalid,le.derogatory_liability_amount_Invalid,le.ucc_data_indicator_Invalid,le.ucc_count_Invalid,le.number_of_legal_items_Invalid,le.legal_balance_sign_Invalid,le.legal_balance_amount_Invalid,le.pmtkbankruptcy_Invalid,le.pmtkjudgment_Invalid,le.pmtktaxlien_Invalid,le.pmtkpayment_Invalid,le.bankruptcy_filed_Invalid,le.number_of_derogatory_legal_items_Invalid,le.lien_count_Invalid,le.judgment_count_Invalid,le.bkc006_Invalid,le.bkc007_Invalid,le.bkc008_Invalid,le.bko009_Invalid,le.bkb001_sign_Invalid,le.bkb001_Invalid,le.bkb003_sign_Invalid,le.bkb003_Invalid,le.bko010_Invalid,le.bko011_Invalid,le.jdc010_Invalid,le.jdc011_Invalid,le.jdc012_Invalid,le.jdb004_Invalid,le.jdb005_Invalid,le.jdb006_Invalid,le.jDO013_Invalid,le.jDO014_Invalid,le.jdb002_Invalid,le.jdp016_Invalid,le.lgc004_Invalid,le.pro001_Invalid,le.pro003_Invalid,le.txc010_Invalid,le.txc011_Invalid,le.txb004_sign_Invalid,le.txb004_Invalid,le.txo013_Invalid,le.txb002_sign_Invalid,le.txb002_Invalid,le.txp016_Invalid,le.ucc001_Invalid,le.ucc002_Invalid,le.ucc003_Invalid,le.intelliscore_plus_Invalid,le.percentile_model_Invalid,le.model_action_Invalid,le.score_factor_1_Invalid,le.score_factor_2_Invalid,le.score_factor_3_Invalid,le.score_factor_4_Invalid,le.model_type_Invalid,le.last_experian_inquiry_date_Invalid,le.recent_high_credit_sign_Invalid,le.recent_high_credit_Invalid,le.median_credit_amount_sign_Invalid,le.median_credit_amount_Invalid,le.total_combined_trade_lines_count_Invalid,le.dbt_of_combined_trade_totals_Invalid,le.combined_trade_balance_Invalid,le.aged_trade_lines_Invalid,le.experian_credit_rating_Invalid,le.quarter_1_average_dbt_Invalid,le.quarter_2_average_dbt_Invalid,le.quarter_3_average_dbt_Invalid,le.quarter_4_average_dbt_Invalid,le.quarter_5_average_dbt_Invalid,le.combined_dbt_Invalid,le.total_account_balance_sign_Invalid,le.total_account_balance_Invalid,le.combined_account_balance_sign_Invalid,le.combined_account_balance_Invalid,le.collection_count_Invalid,le.atc021_Invalid,le.atc022_Invalid,le.atc023_Invalid,le.atc024_Invalid,le.atc025_Invalid,le.last_activity_age_code_Invalid,le.cottage_indicator_Invalid,le.nonprofit_indicator_Invalid,le.financial_stability_risk_score_Invalid,le.fsr_risk_class_Invalid,le.fsr_score_factor_1_Invalid,le.fsr_score_factor_2_Invalid,le.fsr_score_factor_3_Invalid,le.fsr_score_factor_4_Invalid,le.ip_score_change_sign_Invalid,le.ip_score_change_Invalid,le.fsr_score_change_sign_Invalid,le.fsr_score_change_Invalid,le.clean_dba_name_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.postdir_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.fips_state_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.company_name_Invalid,le.p_fname_Invalid,le.p_mname_Invalid,le.p_lname_Invalid,le.raw_aid_Invalid,le.ace_aid_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,le.source_rec_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_dotid(le.dotid_Invalid),Base_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),Base_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),Base_Fields.InvalidMessage_empid(le.empid_Invalid),Base_Fields.InvalidMessage_empscore(le.empscore_Invalid),Base_Fields.InvalidMessage_empweight(le.empweight_Invalid),Base_Fields.InvalidMessage_powid(le.powid_Invalid),Base_Fields.InvalidMessage_powscore(le.powscore_Invalid),Base_Fields.InvalidMessage_powweight(le.powweight_Invalid),Base_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),Base_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),Base_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_Fields.InvalidMessage_selescore(le.selescore_Invalid),Base_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),Base_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),Base_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),Base_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),Base_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),Base_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),Base_Fields.InvalidMessage_did(le.did_Invalid),Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Base_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Base_Fields.InvalidMessage_experian_bus_id(le.experian_bus_id_Invalid),Base_Fields.InvalidMessage_business_name(le.business_name_Invalid),Base_Fields.InvalidMessage_address(le.address_Invalid),Base_Fields.InvalidMessage_city(le.city_Invalid),Base_Fields.InvalidMessage_state(le.state_Invalid),Base_Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Base_Fields.InvalidMessage_zip_plus_4(le.zip_plus_4_Invalid),Base_Fields.InvalidMessage_carrier_route(le.carrier_route_Invalid),Base_Fields.InvalidMessage_county_code(le.county_code_Invalid),Base_Fields.InvalidMessage_county_name(le.county_name_Invalid),Base_Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Base_Fields.InvalidMessage_msa_code(le.msa_code_Invalid),Base_Fields.InvalidMessage_establish_date(le.establish_date_Invalid),Base_Fields.InvalidMessage_latest_reported_date(le.latest_reported_date_Invalid),Base_Fields.InvalidMessage_years_in_file(le.years_in_file_Invalid),Base_Fields.InvalidMessage_geo_code_latitude(le.geo_code_latitude_Invalid),Base_Fields.InvalidMessage_geo_code_latitude_direction(le.geo_code_latitude_direction_Invalid),Base_Fields.InvalidMessage_geo_code_longitude(le.geo_code_longitude_Invalid),Base_Fields.InvalidMessage_geo_code_longitude_direction(le.geo_code_longitude_direction_Invalid),Base_Fields.InvalidMessage_recent_update_code(le.recent_update_code_Invalid),Base_Fields.InvalidMessage_years_in_business_code(le.years_in_business_code_Invalid),Base_Fields.InvalidMessage_year_business_started(le.year_business_started_Invalid),Base_Fields.InvalidMessage_months_in_file(le.months_in_file_Invalid),Base_Fields.InvalidMessage_address_type_code(le.address_type_code_Invalid),Base_Fields.InvalidMessage_estimated_number_of_employees(le.estimated_number_of_employees_Invalid),Base_Fields.InvalidMessage_employee_size_code(le.employee_size_code_Invalid),Base_Fields.InvalidMessage_estimated_annual_sales_amount_sign(le.estimated_annual_sales_amount_sign_Invalid),Base_Fields.InvalidMessage_estimated_annual_sales_amount(le.estimated_annual_sales_amount_Invalid),Base_Fields.InvalidMessage_annual_sales_size_code(le.annual_sales_size_code_Invalid),Base_Fields.InvalidMessage_location_code(le.location_code_Invalid),Base_Fields.InvalidMessage_primary_sic_code_industry_classification(le.primary_sic_code_industry_classification_Invalid),Base_Fields.InvalidMessage_primary_sic_code_4_digit(le.primary_sic_code_4_digit_Invalid),Base_Fields.InvalidMessage_primary_sic_code(le.primary_sic_code_Invalid),Base_Fields.InvalidMessage_second_sic_code(le.second_sic_code_Invalid),Base_Fields.InvalidMessage_third_sic_code(le.third_sic_code_Invalid),Base_Fields.InvalidMessage_fourth_sic_code(le.fourth_sic_code_Invalid),Base_Fields.InvalidMessage_fifth_sic_code(le.fifth_sic_code_Invalid),Base_Fields.InvalidMessage_sixth_sic_code(le.sixth_sic_code_Invalid),Base_Fields.InvalidMessage_primary_naics_code(le.primary_naics_code_Invalid),Base_Fields.InvalidMessage_second_naics_code(le.second_naics_code_Invalid),Base_Fields.InvalidMessage_third_naics_code(le.third_naics_code_Invalid),Base_Fields.InvalidMessage_fourth_naics_code(le.fourth_naics_code_Invalid),Base_Fields.InvalidMessage_executive_count(le.executive_count_Invalid),Base_Fields.InvalidMessage_business_type(le.business_type_Invalid),Base_Fields.InvalidMessage_ownership_code(le.ownership_code_Invalid),Base_Fields.InvalidMessage_derogatory_indicator(le.derogatory_indicator_Invalid),Base_Fields.InvalidMessage_recent_derogatory_filed_date(le.recent_derogatory_filed_date_Invalid),Base_Fields.InvalidMessage_derogatory_liability_amount_sign(le.derogatory_liability_amount_sign_Invalid),Base_Fields.InvalidMessage_derogatory_liability_amount(le.derogatory_liability_amount_Invalid),Base_Fields.InvalidMessage_ucc_data_indicator(le.ucc_data_indicator_Invalid),Base_Fields.InvalidMessage_ucc_count(le.ucc_count_Invalid),Base_Fields.InvalidMessage_number_of_legal_items(le.number_of_legal_items_Invalid),Base_Fields.InvalidMessage_legal_balance_sign(le.legal_balance_sign_Invalid),Base_Fields.InvalidMessage_legal_balance_amount(le.legal_balance_amount_Invalid),Base_Fields.InvalidMessage_pmtkbankruptcy(le.pmtkbankruptcy_Invalid),Base_Fields.InvalidMessage_pmtkjudgment(le.pmtkjudgment_Invalid),Base_Fields.InvalidMessage_pmtktaxlien(le.pmtktaxlien_Invalid),Base_Fields.InvalidMessage_pmtkpayment(le.pmtkpayment_Invalid),Base_Fields.InvalidMessage_bankruptcy_filed(le.bankruptcy_filed_Invalid),Base_Fields.InvalidMessage_number_of_derogatory_legal_items(le.number_of_derogatory_legal_items_Invalid),Base_Fields.InvalidMessage_lien_count(le.lien_count_Invalid),Base_Fields.InvalidMessage_judgment_count(le.judgment_count_Invalid),Base_Fields.InvalidMessage_bkc006(le.bkc006_Invalid),Base_Fields.InvalidMessage_bkc007(le.bkc007_Invalid),Base_Fields.InvalidMessage_bkc008(le.bkc008_Invalid),Base_Fields.InvalidMessage_bko009(le.bko009_Invalid),Base_Fields.InvalidMessage_bkb001_sign(le.bkb001_sign_Invalid),Base_Fields.InvalidMessage_bkb001(le.bkb001_Invalid),Base_Fields.InvalidMessage_bkb003_sign(le.bkb003_sign_Invalid),Base_Fields.InvalidMessage_bkb003(le.bkb003_Invalid),Base_Fields.InvalidMessage_bko010(le.bko010_Invalid),Base_Fields.InvalidMessage_bko011(le.bko011_Invalid),Base_Fields.InvalidMessage_jdc010(le.jdc010_Invalid),Base_Fields.InvalidMessage_jdc011(le.jdc011_Invalid),Base_Fields.InvalidMessage_jdc012(le.jdc012_Invalid),Base_Fields.InvalidMessage_jdb004(le.jdb004_Invalid),Base_Fields.InvalidMessage_jdb005(le.jdb005_Invalid),Base_Fields.InvalidMessage_jdb006(le.jdb006_Invalid),Base_Fields.InvalidMessage_jDO013(le.jDO013_Invalid),Base_Fields.InvalidMessage_jDO014(le.jDO014_Invalid),Base_Fields.InvalidMessage_jdb002(le.jdb002_Invalid),Base_Fields.InvalidMessage_jdp016(le.jdp016_Invalid),Base_Fields.InvalidMessage_lgc004(le.lgc004_Invalid),Base_Fields.InvalidMessage_pro001(le.pro001_Invalid),Base_Fields.InvalidMessage_pro003(le.pro003_Invalid),Base_Fields.InvalidMessage_txc010(le.txc010_Invalid),Base_Fields.InvalidMessage_txc011(le.txc011_Invalid),Base_Fields.InvalidMessage_txb004_sign(le.txb004_sign_Invalid),Base_Fields.InvalidMessage_txb004(le.txb004_Invalid),Base_Fields.InvalidMessage_txo013(le.txo013_Invalid),Base_Fields.InvalidMessage_txb002_sign(le.txb002_sign_Invalid),Base_Fields.InvalidMessage_txb002(le.txb002_Invalid),Base_Fields.InvalidMessage_txp016(le.txp016_Invalid),Base_Fields.InvalidMessage_ucc001(le.ucc001_Invalid),Base_Fields.InvalidMessage_ucc002(le.ucc002_Invalid),Base_Fields.InvalidMessage_ucc003(le.ucc003_Invalid),Base_Fields.InvalidMessage_intelliscore_plus(le.intelliscore_plus_Invalid),Base_Fields.InvalidMessage_percentile_model(le.percentile_model_Invalid),Base_Fields.InvalidMessage_model_action(le.model_action_Invalid),Base_Fields.InvalidMessage_score_factor_1(le.score_factor_1_Invalid),Base_Fields.InvalidMessage_score_factor_2(le.score_factor_2_Invalid),Base_Fields.InvalidMessage_score_factor_3(le.score_factor_3_Invalid),Base_Fields.InvalidMessage_score_factor_4(le.score_factor_4_Invalid),Base_Fields.InvalidMessage_model_type(le.model_type_Invalid),Base_Fields.InvalidMessage_last_experian_inquiry_date(le.last_experian_inquiry_date_Invalid),Base_Fields.InvalidMessage_recent_high_credit_sign(le.recent_high_credit_sign_Invalid),Base_Fields.InvalidMessage_recent_high_credit(le.recent_high_credit_Invalid),Base_Fields.InvalidMessage_median_credit_amount_sign(le.median_credit_amount_sign_Invalid),Base_Fields.InvalidMessage_median_credit_amount(le.median_credit_amount_Invalid),Base_Fields.InvalidMessage_total_combined_trade_lines_count(le.total_combined_trade_lines_count_Invalid),Base_Fields.InvalidMessage_dbt_of_combined_trade_totals(le.dbt_of_combined_trade_totals_Invalid),Base_Fields.InvalidMessage_combined_trade_balance(le.combined_trade_balance_Invalid),Base_Fields.InvalidMessage_aged_trade_lines(le.aged_trade_lines_Invalid),Base_Fields.InvalidMessage_experian_credit_rating(le.experian_credit_rating_Invalid),Base_Fields.InvalidMessage_quarter_1_average_dbt(le.quarter_1_average_dbt_Invalid),Base_Fields.InvalidMessage_quarter_2_average_dbt(le.quarter_2_average_dbt_Invalid),Base_Fields.InvalidMessage_quarter_3_average_dbt(le.quarter_3_average_dbt_Invalid),Base_Fields.InvalidMessage_quarter_4_average_dbt(le.quarter_4_average_dbt_Invalid),Base_Fields.InvalidMessage_quarter_5_average_dbt(le.quarter_5_average_dbt_Invalid),Base_Fields.InvalidMessage_combined_dbt(le.combined_dbt_Invalid),Base_Fields.InvalidMessage_total_account_balance_sign(le.total_account_balance_sign_Invalid),Base_Fields.InvalidMessage_total_account_balance(le.total_account_balance_Invalid),Base_Fields.InvalidMessage_combined_account_balance_sign(le.combined_account_balance_sign_Invalid),Base_Fields.InvalidMessage_combined_account_balance(le.combined_account_balance_Invalid),Base_Fields.InvalidMessage_collection_count(le.collection_count_Invalid),Base_Fields.InvalidMessage_atc021(le.atc021_Invalid),Base_Fields.InvalidMessage_atc022(le.atc022_Invalid),Base_Fields.InvalidMessage_atc023(le.atc023_Invalid),Base_Fields.InvalidMessage_atc024(le.atc024_Invalid),Base_Fields.InvalidMessage_atc025(le.atc025_Invalid),Base_Fields.InvalidMessage_last_activity_age_code(le.last_activity_age_code_Invalid),Base_Fields.InvalidMessage_cottage_indicator(le.cottage_indicator_Invalid),Base_Fields.InvalidMessage_nonprofit_indicator(le.nonprofit_indicator_Invalid),Base_Fields.InvalidMessage_financial_stability_risk_score(le.financial_stability_risk_score_Invalid),Base_Fields.InvalidMessage_fsr_risk_class(le.fsr_risk_class_Invalid),Base_Fields.InvalidMessage_fsr_score_factor_1(le.fsr_score_factor_1_Invalid),Base_Fields.InvalidMessage_fsr_score_factor_2(le.fsr_score_factor_2_Invalid),Base_Fields.InvalidMessage_fsr_score_factor_3(le.fsr_score_factor_3_Invalid),Base_Fields.InvalidMessage_fsr_score_factor_4(le.fsr_score_factor_4_Invalid),Base_Fields.InvalidMessage_ip_score_change_sign(le.ip_score_change_sign_Invalid),Base_Fields.InvalidMessage_ip_score_change(le.ip_score_change_Invalid),Base_Fields.InvalidMessage_fsr_score_change_sign(le.fsr_score_change_sign_Invalid),Base_Fields.InvalidMessage_fsr_score_change(le.fsr_score_change_Invalid),Base_Fields.InvalidMessage_clean_dba_name(le.clean_dba_name_Invalid),Base_Fields.InvalidMessage_predir(le.predir_Invalid),Base_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Base_Fields.InvalidMessage_postdir(le.postdir_Invalid),Base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Fields.InvalidMessage_st(le.st_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_zip4(le.zip4_Invalid),Base_Fields.InvalidMessage_cart(le.cart_Invalid),Base_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Base_Fields.InvalidMessage_lot(le.lot_Invalid),Base_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Base_Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Base_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Base_Fields.InvalidMessage_fips_state(le.fips_state_Invalid),Base_Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Base_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Base_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Base_Fields.InvalidMessage_msa(le.msa_Invalid),Base_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Base_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Base_Fields.InvalidMessage_company_name(le.company_name_Invalid),Base_Fields.InvalidMessage_p_fname(le.p_fname_Invalid),Base_Fields.InvalidMessage_p_mname(le.p_mname_Invalid),Base_Fields.InvalidMessage_p_lname(le.p_lname_Invalid),Base_Fields.InvalidMessage_raw_aid(le.raw_aid_Invalid),Base_Fields.InvalidMessage_ace_aid(le.ace_aid_Invalid),Base_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Base_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),Base_Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dotid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.experian_bus_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_plus_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.carrier_route_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.msa_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.establish_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.latest_reported_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.years_in_file_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_code_latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_code_latitude_direction_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_code_longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_code_longitude_direction_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recent_update_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.years_in_business_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.year_business_started_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.months_in_file_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_type_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.estimated_number_of_employees_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.employee_size_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.estimated_annual_sales_amount_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.estimated_annual_sales_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.annual_sales_size_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.location_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_sic_code_industry_classification_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.primary_sic_code_4_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.second_sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.third_sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fourth_sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fifth_sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sixth_sic_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.primary_naics_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.second_naics_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.third_naics_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fourth_naics_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.executive_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.business_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ownership_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.derogatory_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recent_derogatory_filed_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.derogatory_liability_amount_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.derogatory_liability_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ucc_data_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ucc_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.number_of_legal_items_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.legal_balance_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.legal_balance_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pmtkbankruptcy_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.pmtkjudgment_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.pmtktaxlien_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.pmtkpayment_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.bankruptcy_filed_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.number_of_derogatory_legal_items_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lien_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judgment_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bkc006_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bkc007_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bkc008_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bko009_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bkb001_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.bkb001_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bkb003_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.bkb003_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bko010_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bko011_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jdc010_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jdc011_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jdc012_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jdb004_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jdb005_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jdb006_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jDO013_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jDO014_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jdb002_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.jdp016_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lgc004_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pro001_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pro003_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.txc010_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.txc011_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.txb004_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.txb004_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.txo013_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.txb002_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.txb002_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.txp016_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ucc001_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ucc002_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ucc003_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.intelliscore_plus_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.percentile_model_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.model_action_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.score_factor_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.score_factor_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.score_factor_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.score_factor_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.model_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_experian_inquiry_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.recent_high_credit_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.recent_high_credit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.median_credit_amount_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.median_credit_amount_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.total_combined_trade_lines_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dbt_of_combined_trade_totals_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.combined_trade_balance_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.aged_trade_lines_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.experian_credit_rating_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.quarter_1_average_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.quarter_2_average_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.quarter_3_average_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.quarter_4_average_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.quarter_5_average_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.combined_dbt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.total_account_balance_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.total_account_balance_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.combined_account_balance_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.combined_account_balance_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.collection_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.atc021_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.atc022_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.atc023_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.atc024_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.atc025_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.last_activity_age_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cottage_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.nonprofit_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.financial_stability_risk_score_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fsr_risk_class_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fsr_score_factor_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fsr_score_factor_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fsr_score_factor_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fsr_score_factor_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ip_score_change_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ip_score_change_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fsr_score_change_sign_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fsr_score_change_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_dba_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.p_fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.p_mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.p_lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.raw_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ace_aid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','bdid','bdid_score','did','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','experian_bus_id','business_name','address','city','state','zip_code','zip_plus_4','carrier_route','county_code','county_name','phone_number','msa_code','establish_date','latest_reported_date','years_in_file','geo_code_latitude','geo_code_latitude_direction','geo_code_longitude','geo_code_longitude_direction','recent_update_code','years_in_business_code','year_business_started','months_in_file','address_type_code','estimated_number_of_employees','employee_size_code','estimated_annual_sales_amount_sign','estimated_annual_sales_amount','annual_sales_size_code','location_code','primary_sic_code_industry_classification','primary_sic_code_4_digit','primary_sic_code','second_sic_code','third_sic_code','fourth_sic_code','fifth_sic_code','sixth_sic_code','primary_naics_code','second_naics_code','third_naics_code','fourth_naics_code','executive_count','business_type','ownership_code','derogatory_indicator','recent_derogatory_filed_date','derogatory_liability_amount_sign','derogatory_liability_amount','ucc_data_indicator','ucc_count','number_of_legal_items','legal_balance_sign','legal_balance_amount','pmtkbankruptcy','pmtkjudgment','pmtktaxlien','pmtkpayment','bankruptcy_filed','number_of_derogatory_legal_items','lien_count','judgment_count','bkc006','bkc007','bkc008','bko009','bkb001_sign','bkb001','bkb003_sign','bkb003','bko010','bko011','jdc010','jdc011','jdc012','jdb004','jdb005','jdb006','jDO013','jDO014','jdb002','jdp016','lgc004','pro001','pro003','txc010','txc011','txb004_sign','txb004','txo013','txb002_sign','txb002','txp016','ucc001','ucc002','ucc003','intelliscore_plus','percentile_model','model_action','score_factor_1','score_factor_2','score_factor_3','score_factor_4','model_type','last_experian_inquiry_date','recent_high_credit_sign','recent_high_credit','median_credit_amount_sign','median_credit_amount','total_combined_trade_lines_count','dbt_of_combined_trade_totals','combined_trade_balance','aged_trade_lines','experian_credit_rating','quarter_1_average_dbt','quarter_2_average_dbt','quarter_3_average_dbt','quarter_4_average_dbt','quarter_5_average_dbt','combined_dbt','total_account_balance_sign','total_account_balance','combined_account_balance_sign','combined_account_balance','collection_count','atc021','atc022','atc023','atc024','atc025','last_activity_age_code','cottage_indicator','nonprofit_indicator','financial_stability_risk_score','fsr_risk_class','fsr_score_factor_1','fsr_score_factor_2','fsr_score_factor_3','fsr_score_factor_4','ip_score_change_sign','ip_score_change','fsr_score_change_sign','fsr_score_change','clean_dba_name','predir','prim_name','postdir','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','fips_state','fips_county','geo_lat','geo_long','msa','geo_match','err_stat','company_name','p_fname','p_mname','p_lname','raw_aid','ace_aid','prep_addr_line1','prep_addr_line_last','source_rec_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_zero_blank','invalid_zero_blank','invalid_zero_blank','invalid_zero_blank','invalid_zero_blank','invalid_zero_blank','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_numeric','invalid_percentage','invalid_numeric','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_experian_bus_id','invalid_business_name','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_zip4','invalid_carrier_route','invalid_numeric','invalid_alphaHyphen','invalid_phone','invalid_numeric','invalid_pastdate','invalid_pastdate','invalid_numeric','invalid_numericPeriod','invalid_geo_code_latitude_direction','invalid_numericPeriod','invalid_geo_code_longitude_direction','invalid_recent_update_code','invalid_years_in_business_code','invalid_year','invalid_numeric','invalid_address_type_code','invalid_numeric','invalid_employee_size_code','invalid_sign','invalid_numeric','invalid_annual_Sales_Size_Code','invalid_location_code','invalid_primary_sic_code_industry_classification','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_sic_codes','invalid_naics_codes','invalid_naics_codes','invalid_naics_codes','invalid_naics_codes','invalid_numeric','invalid_business_type','invalid_ownership_code','invalid_derogatory_indicator','invalid_pastdate','invalid_sign','invalid_numeric','invalid_ucc_data_indicator','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_boolean','invalid_boolean','invalid_boolean','invalid_boolean','invalid_boolean','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_model_action','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_model_type','invalid_pastdate','invalid_sign','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_aged_trade_lines','invalid_Experian_Credit_Rating','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_sign','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_last_activity_age_code','invalid_boolean','invalid_nonprofit_indicator','invalid_numeric','invalid_fsr_risk_class','invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_sign','invalid_numeric','invalid_sign','invalid_numeric','invalid_clean_dba_name','invalid_direction','invalid_mandatory','invalid_direction','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_match','invalid_err_stat','invalid_bName_pName','invalid_bName_fName','invalid_bName_mName','invalid_bName_lName','invalid_raw_aid','invalid_ace_aid','invalid_mandatory','invalid_mandatory','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.dotid,(SALT38.StrType)le.dotscore,(SALT38.StrType)le.dotweight,(SALT38.StrType)le.empid,(SALT38.StrType)le.empscore,(SALT38.StrType)le.empweight,(SALT38.StrType)le.powid,(SALT38.StrType)le.powscore,(SALT38.StrType)le.powweight,(SALT38.StrType)le.proxid,(SALT38.StrType)le.proxscore,(SALT38.StrType)le.proxweight,(SALT38.StrType)le.seleid,(SALT38.StrType)le.selescore,(SALT38.StrType)le.seleweight,(SALT38.StrType)le.orgid,(SALT38.StrType)le.orgscore,(SALT38.StrType)le.orgweight,(SALT38.StrType)le.ultid,(SALT38.StrType)le.ultscore,(SALT38.StrType)le.ultweight,(SALT38.StrType)le.bdid,(SALT38.StrType)le.bdid_score,(SALT38.StrType)le.did,(SALT38.StrType)le.dt_first_seen,(SALT38.StrType)le.dt_last_seen,(SALT38.StrType)le.dt_vendor_first_reported,(SALT38.StrType)le.dt_vendor_last_reported,(SALT38.StrType)le.experian_bus_id,(SALT38.StrType)le.business_name,(SALT38.StrType)le.address,(SALT38.StrType)le.city,(SALT38.StrType)le.state,(SALT38.StrType)le.zip_code,(SALT38.StrType)le.zip_plus_4,(SALT38.StrType)le.carrier_route,(SALT38.StrType)le.county_code,(SALT38.StrType)le.county_name,(SALT38.StrType)le.phone_number,(SALT38.StrType)le.msa_code,(SALT38.StrType)le.establish_date,(SALT38.StrType)le.latest_reported_date,(SALT38.StrType)le.years_in_file,(SALT38.StrType)le.geo_code_latitude,(SALT38.StrType)le.geo_code_latitude_direction,(SALT38.StrType)le.geo_code_longitude,(SALT38.StrType)le.geo_code_longitude_direction,(SALT38.StrType)le.recent_update_code,(SALT38.StrType)le.years_in_business_code,(SALT38.StrType)le.year_business_started,(SALT38.StrType)le.months_in_file,(SALT38.StrType)le.address_type_code,(SALT38.StrType)le.estimated_number_of_employees,(SALT38.StrType)le.employee_size_code,(SALT38.StrType)le.estimated_annual_sales_amount_sign,(SALT38.StrType)le.estimated_annual_sales_amount,(SALT38.StrType)le.annual_sales_size_code,(SALT38.StrType)le.location_code,(SALT38.StrType)le.primary_sic_code_industry_classification,(SALT38.StrType)le.primary_sic_code_4_digit,(SALT38.StrType)le.primary_sic_code,(SALT38.StrType)le.second_sic_code,(SALT38.StrType)le.third_sic_code,(SALT38.StrType)le.fourth_sic_code,(SALT38.StrType)le.fifth_sic_code,(SALT38.StrType)le.sixth_sic_code,(SALT38.StrType)le.primary_naics_code,(SALT38.StrType)le.second_naics_code,(SALT38.StrType)le.third_naics_code,(SALT38.StrType)le.fourth_naics_code,(SALT38.StrType)le.executive_count,(SALT38.StrType)le.business_type,(SALT38.StrType)le.ownership_code,(SALT38.StrType)le.derogatory_indicator,(SALT38.StrType)le.recent_derogatory_filed_date,(SALT38.StrType)le.derogatory_liability_amount_sign,(SALT38.StrType)le.derogatory_liability_amount,(SALT38.StrType)le.ucc_data_indicator,(SALT38.StrType)le.ucc_count,(SALT38.StrType)le.number_of_legal_items,(SALT38.StrType)le.legal_balance_sign,(SALT38.StrType)le.legal_balance_amount,(SALT38.StrType)le.pmtkbankruptcy,(SALT38.StrType)le.pmtkjudgment,(SALT38.StrType)le.pmtktaxlien,(SALT38.StrType)le.pmtkpayment,(SALT38.StrType)le.bankruptcy_filed,(SALT38.StrType)le.number_of_derogatory_legal_items,(SALT38.StrType)le.lien_count,(SALT38.StrType)le.judgment_count,(SALT38.StrType)le.bkc006,(SALT38.StrType)le.bkc007,(SALT38.StrType)le.bkc008,(SALT38.StrType)le.bko009,(SALT38.StrType)le.bkb001_sign,(SALT38.StrType)le.bkb001,(SALT38.StrType)le.bkb003_sign,(SALT38.StrType)le.bkb003,(SALT38.StrType)le.bko010,(SALT38.StrType)le.bko011,(SALT38.StrType)le.jdc010,(SALT38.StrType)le.jdc011,(SALT38.StrType)le.jdc012,(SALT38.StrType)le.jdb004,(SALT38.StrType)le.jdb005,(SALT38.StrType)le.jdb006,(SALT38.StrType)le.jDO013,(SALT38.StrType)le.jDO014,(SALT38.StrType)le.jdb002,(SALT38.StrType)le.jdp016,(SALT38.StrType)le.lgc004,(SALT38.StrType)le.pro001,(SALT38.StrType)le.pro003,(SALT38.StrType)le.txc010,(SALT38.StrType)le.txc011,(SALT38.StrType)le.txb004_sign,(SALT38.StrType)le.txb004,(SALT38.StrType)le.txo013,(SALT38.StrType)le.txb002_sign,(SALT38.StrType)le.txb002,(SALT38.StrType)le.txp016,(SALT38.StrType)le.ucc001,(SALT38.StrType)le.ucc002,(SALT38.StrType)le.ucc003,(SALT38.StrType)le.intelliscore_plus,(SALT38.StrType)le.percentile_model,(SALT38.StrType)le.model_action,(SALT38.StrType)le.score_factor_1,(SALT38.StrType)le.score_factor_2,(SALT38.StrType)le.score_factor_3,(SALT38.StrType)le.score_factor_4,(SALT38.StrType)le.model_type,(SALT38.StrType)le.last_experian_inquiry_date,(SALT38.StrType)le.recent_high_credit_sign,(SALT38.StrType)le.recent_high_credit,(SALT38.StrType)le.median_credit_amount_sign,(SALT38.StrType)le.median_credit_amount,(SALT38.StrType)le.total_combined_trade_lines_count,(SALT38.StrType)le.dbt_of_combined_trade_totals,(SALT38.StrType)le.combined_trade_balance,(SALT38.StrType)le.aged_trade_lines,(SALT38.StrType)le.experian_credit_rating,(SALT38.StrType)le.quarter_1_average_dbt,(SALT38.StrType)le.quarter_2_average_dbt,(SALT38.StrType)le.quarter_3_average_dbt,(SALT38.StrType)le.quarter_4_average_dbt,(SALT38.StrType)le.quarter_5_average_dbt,(SALT38.StrType)le.combined_dbt,(SALT38.StrType)le.total_account_balance_sign,(SALT38.StrType)le.total_account_balance,(SALT38.StrType)le.combined_account_balance_sign,(SALT38.StrType)le.combined_account_balance,(SALT38.StrType)le.collection_count,(SALT38.StrType)le.atc021,(SALT38.StrType)le.atc022,(SALT38.StrType)le.atc023,(SALT38.StrType)le.atc024,(SALT38.StrType)le.atc025,(SALT38.StrType)le.last_activity_age_code,(SALT38.StrType)le.cottage_indicator,(SALT38.StrType)le.nonprofit_indicator,(SALT38.StrType)le.financial_stability_risk_score,(SALT38.StrType)le.fsr_risk_class,(SALT38.StrType)le.fsr_score_factor_1,(SALT38.StrType)le.fsr_score_factor_2,(SALT38.StrType)le.fsr_score_factor_3,(SALT38.StrType)le.fsr_score_factor_4,(SALT38.StrType)le.ip_score_change_sign,(SALT38.StrType)le.ip_score_change,(SALT38.StrType)le.fsr_score_change_sign,(SALT38.StrType)le.fsr_score_change,(SALT38.StrType)le.clean_dba_name,(SALT38.StrType)le.predir,(SALT38.StrType)le.prim_name,(SALT38.StrType)le.postdir,(SALT38.StrType)le.p_city_name,(SALT38.StrType)le.v_city_name,(SALT38.StrType)le.st,(SALT38.StrType)le.zip,(SALT38.StrType)le.zip4,(SALT38.StrType)le.cart,(SALT38.StrType)le.cr_sort_sz,(SALT38.StrType)le.lot,(SALT38.StrType)le.lot_order,(SALT38.StrType)le.dbpc,(SALT38.StrType)le.chk_digit,(SALT38.StrType)le.fips_state,(SALT38.StrType)le.fips_county,(SALT38.StrType)le.geo_lat,(SALT38.StrType)le.geo_long,(SALT38.StrType)le.msa,(SALT38.StrType)le.geo_match,(SALT38.StrType)le.err_stat,(SALT38.StrType)le.company_name,(SALT38.StrType)le.p_fname,(SALT38.StrType)le.p_mname,(SALT38.StrType)le.p_lname,(SALT38.StrType)le.raw_aid,(SALT38.StrType)le.ace_aid,(SALT38.StrType)le.prep_addr_line1,(SALT38.StrType)le.prep_addr_line_last,(SALT38.StrType)le.source_rec_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,202,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_Experian_CRDB) prevDS = DATASET([], Base_Layout_Experian_CRDB), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dotid:invalid_zero_blank:ENUM'
          ,'dotscore:invalid_zero_blank:ENUM'
          ,'dotweight:invalid_zero_blank:ENUM'
          ,'empid:invalid_zero_blank:ENUM'
          ,'empscore:invalid_zero_blank:ENUM'
          ,'empweight:invalid_zero_blank:ENUM'
          ,'powid:invalid_numeric:CUSTOM'
          ,'powscore:invalid_percentage:CUSTOM'
          ,'powweight:invalid_numeric:CUSTOM'
          ,'proxid:invalid_numeric:CUSTOM'
          ,'proxscore:invalid_percentage:CUSTOM'
          ,'proxweight:invalid_numeric:CUSTOM'
          ,'seleid:invalid_numeric:CUSTOM'
          ,'selescore:invalid_percentage:CUSTOM'
          ,'seleweight:invalid_numeric:CUSTOM'
          ,'orgid:invalid_numeric:CUSTOM'
          ,'orgscore:invalid_percentage:CUSTOM'
          ,'orgweight:invalid_numeric:CUSTOM'
          ,'ultid:invalid_numeric:CUSTOM'
          ,'ultscore:invalid_percentage:CUSTOM'
          ,'ultweight:invalid_numeric:CUSTOM'
          ,'bdid:invalid_numeric:CUSTOM'
          ,'bdid_score:invalid_percentage:CUSTOM'
          ,'did:invalid_numeric:CUSTOM'
          ,'dt_first_seen:invalid_pastdate:CUSTOM'
          ,'dt_last_seen:invalid_pastdate:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate:CUSTOM'
          ,'experian_bus_id:invalid_experian_bus_id:CUSTOM'
          ,'business_name:invalid_business_name:CUSTOM'
          ,'address:invalid_mandatory:CUSTOM'
          ,'city:invalid_mandatory:CUSTOM'
          ,'state:invalid_state:CUSTOM'
          ,'zip_code:invalid_zip:CUSTOM'
          ,'zip_plus_4:invalid_zip4:CUSTOM'
          ,'carrier_route:invalid_carrier_route:ALLOW'
          ,'county_code:invalid_numeric:CUSTOM'
          ,'county_name:invalid_alphaHyphen:ALLOW'
          ,'phone_number:invalid_phone:CUSTOM'
          ,'msa_code:invalid_numeric:CUSTOM'
          ,'establish_date:invalid_pastdate:CUSTOM'
          ,'latest_reported_date:invalid_pastdate:CUSTOM'
          ,'years_in_file:invalid_numeric:CUSTOM'
          ,'geo_code_latitude:invalid_numericPeriod:ALLOW'
          ,'geo_code_latitude_direction:invalid_geo_code_latitude_direction:ALLOW'
          ,'geo_code_longitude:invalid_numericPeriod:ALLOW'
          ,'geo_code_longitude_direction:invalid_geo_code_longitude_direction:ALLOW'
          ,'recent_update_code:invalid_recent_update_code:ENUM'
          ,'years_in_business_code:invalid_years_in_business_code:ALLOW'
          ,'year_business_started:invalid_year:CUSTOM'
          ,'months_in_file:invalid_numeric:CUSTOM'
          ,'address_type_code:invalid_address_type_code:ALLOW'
          ,'estimated_number_of_employees:invalid_numeric:CUSTOM'
          ,'employee_size_code:invalid_employee_size_code:ALLOW'
          ,'estimated_annual_sales_amount_sign:invalid_sign:ENUM'
          ,'estimated_annual_sales_amount:invalid_numeric:CUSTOM'
          ,'annual_sales_size_code:invalid_annual_Sales_Size_Code:ENUM'
          ,'location_code:invalid_location_code:ENUM'
          ,'primary_sic_code_industry_classification:invalid_primary_sic_code_industry_classification:ENUM'
          ,'primary_sic_code_4_digit:invalid_sic_codes:CUSTOM'
          ,'primary_sic_code:invalid_sic_codes:CUSTOM'
          ,'second_sic_code:invalid_sic_codes:CUSTOM'
          ,'third_sic_code:invalid_sic_codes:CUSTOM'
          ,'fourth_sic_code:invalid_sic_codes:CUSTOM'
          ,'fifth_sic_code:invalid_sic_codes:CUSTOM'
          ,'sixth_sic_code:invalid_sic_codes:CUSTOM'
          ,'primary_naics_code:invalid_naics_codes:CUSTOM'
          ,'second_naics_code:invalid_naics_codes:CUSTOM'
          ,'third_naics_code:invalid_naics_codes:CUSTOM'
          ,'fourth_naics_code:invalid_naics_codes:CUSTOM'
          ,'executive_count:invalid_numeric:CUSTOM'
          ,'business_type:invalid_business_type:ALLOW'
          ,'ownership_code:invalid_ownership_code:ALLOW'
          ,'derogatory_indicator:invalid_derogatory_indicator:ALLOW'
          ,'recent_derogatory_filed_date:invalid_pastdate:CUSTOM'
          ,'derogatory_liability_amount_sign:invalid_sign:ENUM'
          ,'derogatory_liability_amount:invalid_numeric:CUSTOM'
          ,'ucc_data_indicator:invalid_ucc_data_indicator:ALLOW'
          ,'ucc_count:invalid_numeric:CUSTOM'
          ,'number_of_legal_items:invalid_numeric:CUSTOM'
          ,'legal_balance_sign:invalid_sign:ENUM'
          ,'legal_balance_amount:invalid_numeric:CUSTOM'
          ,'pmtkbankruptcy:invalid_boolean:ENUM'
          ,'pmtkjudgment:invalid_boolean:ENUM'
          ,'pmtktaxlien:invalid_boolean:ENUM'
          ,'pmtkpayment:invalid_boolean:ENUM'
          ,'bankruptcy_filed:invalid_boolean:ENUM'
          ,'number_of_derogatory_legal_items:invalid_numeric:CUSTOM'
          ,'lien_count:invalid_numeric:CUSTOM'
          ,'judgment_count:invalid_numeric:CUSTOM'
          ,'bkc006:invalid_numeric:CUSTOM'
          ,'bkc007:invalid_numeric:CUSTOM'
          ,'bkc008:invalid_numeric:CUSTOM'
          ,'bko009:invalid_numeric:CUSTOM'
          ,'bkb001_sign:invalid_sign:ENUM'
          ,'bkb001:invalid_numeric:CUSTOM'
          ,'bkb003_sign:invalid_sign:ENUM'
          ,'bkb003:invalid_numeric:CUSTOM'
          ,'bko010:invalid_numeric:CUSTOM'
          ,'bko011:invalid_numeric:CUSTOM'
          ,'jdc010:invalid_numeric:CUSTOM'
          ,'jdc011:invalid_numeric:CUSTOM'
          ,'jdc012:invalid_numeric:CUSTOM'
          ,'jdb004:invalid_numeric:CUSTOM'
          ,'jdb005:invalid_numeric:CUSTOM'
          ,'jdb006:invalid_numeric:CUSTOM'
          ,'jDO013:invalid_numeric:CUSTOM'
          ,'jDO014:invalid_numeric:CUSTOM'
          ,'jdb002:invalid_numeric:CUSTOM'
          ,'jdp016:invalid_numeric:CUSTOM'
          ,'lgc004:invalid_numeric:CUSTOM'
          ,'pro001:invalid_numeric:CUSTOM'
          ,'pro003:invalid_numeric:CUSTOM'
          ,'txc010:invalid_numeric:CUSTOM'
          ,'txc011:invalid_numeric:CUSTOM'
          ,'txb004_sign:invalid_sign:ENUM'
          ,'txb004:invalid_numeric:CUSTOM'
          ,'txo013:invalid_numeric:CUSTOM'
          ,'txb002_sign:invalid_sign:ENUM'
          ,'txb002:invalid_numeric:CUSTOM'
          ,'txp016:invalid_numeric:CUSTOM'
          ,'ucc001:invalid_numeric:CUSTOM'
          ,'ucc002:invalid_numeric:CUSTOM'
          ,'ucc003:invalid_numeric:CUSTOM'
          ,'intelliscore_plus:invalid_numeric:CUSTOM'
          ,'percentile_model:invalid_numeric:CUSTOM'
          ,'model_action:invalid_model_action:ENUM'
          ,'score_factor_1:invalid_numeric:CUSTOM'
          ,'score_factor_2:invalid_numeric:CUSTOM'
          ,'score_factor_3:invalid_numeric:CUSTOM'
          ,'score_factor_4:invalid_numeric:CUSTOM'
          ,'model_type:invalid_model_type:ALLOW'
          ,'last_experian_inquiry_date:invalid_pastdate:CUSTOM'
          ,'recent_high_credit_sign:invalid_sign:ENUM'
          ,'recent_high_credit:invalid_numeric:CUSTOM'
          ,'median_credit_amount_sign:invalid_sign:ENUM'
          ,'median_credit_amount:invalid_numeric:CUSTOM'
          ,'total_combined_trade_lines_count:invalid_numeric:CUSTOM'
          ,'dbt_of_combined_trade_totals:invalid_numeric:CUSTOM'
          ,'combined_trade_balance:invalid_numeric:CUSTOM'
          ,'aged_trade_lines:invalid_aged_trade_lines:ALLOW'
          ,'experian_credit_rating:invalid_Experian_Credit_Rating:ALLOW'
          ,'quarter_1_average_dbt:invalid_numeric:CUSTOM'
          ,'quarter_2_average_dbt:invalid_numeric:CUSTOM'
          ,'quarter_3_average_dbt:invalid_numeric:CUSTOM'
          ,'quarter_4_average_dbt:invalid_numeric:CUSTOM'
          ,'quarter_5_average_dbt:invalid_numeric:CUSTOM'
          ,'combined_dbt:invalid_numeric:CUSTOM'
          ,'total_account_balance_sign:invalid_sign:ENUM'
          ,'total_account_balance:invalid_numeric:CUSTOM'
          ,'combined_account_balance_sign:invalid_sign:ENUM'
          ,'combined_account_balance:invalid_numeric:CUSTOM'
          ,'collection_count:invalid_numeric:CUSTOM'
          ,'atc021:invalid_numeric:CUSTOM'
          ,'atc022:invalid_numeric:CUSTOM'
          ,'atc023:invalid_numeric:CUSTOM'
          ,'atc024:invalid_numeric:CUSTOM'
          ,'atc025:invalid_numeric:CUSTOM'
          ,'last_activity_age_code:invalid_last_activity_age_code:ALLOW'
          ,'cottage_indicator:invalid_boolean:ENUM'
          ,'nonprofit_indicator:invalid_nonprofit_indicator:ALLOW'
          ,'financial_stability_risk_score:invalid_numeric:CUSTOM'
          ,'fsr_risk_class:invalid_fsr_risk_class:ALLOW'
          ,'fsr_score_factor_1:invalid_numeric:CUSTOM'
          ,'fsr_score_factor_2:invalid_numeric:CUSTOM'
          ,'fsr_score_factor_3:invalid_numeric:CUSTOM'
          ,'fsr_score_factor_4:invalid_numeric:CUSTOM'
          ,'ip_score_change_sign:invalid_sign:ENUM'
          ,'ip_score_change:invalid_numeric:CUSTOM'
          ,'fsr_score_change_sign:invalid_sign:ENUM'
          ,'fsr_score_change:invalid_numeric:CUSTOM'
          ,'clean_dba_name:invalid_clean_dba_name:CUSTOM'
          ,'predir:invalid_direction:ALLOW'
          ,'prim_name:invalid_mandatory:CUSTOM'
          ,'postdir:invalid_direction:ALLOW'
          ,'p_city_name:invalid_mandatory:CUSTOM'
          ,'v_city_name:invalid_mandatory:CUSTOM'
          ,'st:invalid_state:CUSTOM'
          ,'zip:invalid_zip:CUSTOM'
          ,'zip4:invalid_zip4:CUSTOM'
          ,'cart:invalid_cart:CUSTOM'
          ,'cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'lot:invalid_lot:CUSTOM'
          ,'lot_order:invalid_lot_order:ENUM'
          ,'dbpc:invalid_dpbc:CUSTOM'
          ,'chk_digit:invalid_chk_digit:CUSTOM'
          ,'fips_state:invalid_fips_state:CUSTOM'
          ,'fips_county:invalid_fips_county:CUSTOM'
          ,'geo_lat:invalid_geo:CUSTOM'
          ,'geo_long:invalid_geo:CUSTOM'
          ,'msa:invalid_msa:CUSTOM'
          ,'geo_match:invalid_geo_match:CUSTOM'
          ,'err_stat:invalid_err_stat:CUSTOM'
          ,'company_name:invalid_bName_pName:CUSTOM'
          ,'p_fname:invalid_bName_fName:CUSTOM'
          ,'p_mname:invalid_bName_mName:CUSTOM'
          ,'p_lname:invalid_bName_lName:CUSTOM'
          ,'raw_aid:invalid_raw_aid:CUSTOM'
          ,'ace_aid:invalid_ace_aid:CUSTOM'
          ,'prep_addr_line1:invalid_mandatory:CUSTOM'
          ,'prep_addr_line_last:invalid_mandatory:CUSTOM'
          ,'source_rec_id:invalid_numeric:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_dotid(1)
          ,Base_Fields.InvalidMessage_dotscore(1)
          ,Base_Fields.InvalidMessage_dotweight(1)
          ,Base_Fields.InvalidMessage_empid(1)
          ,Base_Fields.InvalidMessage_empscore(1)
          ,Base_Fields.InvalidMessage_empweight(1)
          ,Base_Fields.InvalidMessage_powid(1)
          ,Base_Fields.InvalidMessage_powscore(1)
          ,Base_Fields.InvalidMessage_powweight(1)
          ,Base_Fields.InvalidMessage_proxid(1)
          ,Base_Fields.InvalidMessage_proxscore(1)
          ,Base_Fields.InvalidMessage_proxweight(1)
          ,Base_Fields.InvalidMessage_seleid(1)
          ,Base_Fields.InvalidMessage_selescore(1)
          ,Base_Fields.InvalidMessage_seleweight(1)
          ,Base_Fields.InvalidMessage_orgid(1)
          ,Base_Fields.InvalidMessage_orgscore(1)
          ,Base_Fields.InvalidMessage_orgweight(1)
          ,Base_Fields.InvalidMessage_ultid(1)
          ,Base_Fields.InvalidMessage_ultscore(1)
          ,Base_Fields.InvalidMessage_ultweight(1)
          ,Base_Fields.InvalidMessage_bdid(1)
          ,Base_Fields.InvalidMessage_bdid_score(1)
          ,Base_Fields.InvalidMessage_did(1)
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Base_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Base_Fields.InvalidMessage_experian_bus_id(1)
          ,Base_Fields.InvalidMessage_business_name(1)
          ,Base_Fields.InvalidMessage_address(1)
          ,Base_Fields.InvalidMessage_city(1)
          ,Base_Fields.InvalidMessage_state(1)
          ,Base_Fields.InvalidMessage_zip_code(1)
          ,Base_Fields.InvalidMessage_zip_plus_4(1)
          ,Base_Fields.InvalidMessage_carrier_route(1)
          ,Base_Fields.InvalidMessage_county_code(1)
          ,Base_Fields.InvalidMessage_county_name(1)
          ,Base_Fields.InvalidMessage_phone_number(1)
          ,Base_Fields.InvalidMessage_msa_code(1)
          ,Base_Fields.InvalidMessage_establish_date(1)
          ,Base_Fields.InvalidMessage_latest_reported_date(1)
          ,Base_Fields.InvalidMessage_years_in_file(1)
          ,Base_Fields.InvalidMessage_geo_code_latitude(1)
          ,Base_Fields.InvalidMessage_geo_code_latitude_direction(1)
          ,Base_Fields.InvalidMessage_geo_code_longitude(1)
          ,Base_Fields.InvalidMessage_geo_code_longitude_direction(1)
          ,Base_Fields.InvalidMessage_recent_update_code(1)
          ,Base_Fields.InvalidMessage_years_in_business_code(1)
          ,Base_Fields.InvalidMessage_year_business_started(1)
          ,Base_Fields.InvalidMessage_months_in_file(1)
          ,Base_Fields.InvalidMessage_address_type_code(1)
          ,Base_Fields.InvalidMessage_estimated_number_of_employees(1)
          ,Base_Fields.InvalidMessage_employee_size_code(1)
          ,Base_Fields.InvalidMessage_estimated_annual_sales_amount_sign(1)
          ,Base_Fields.InvalidMessage_estimated_annual_sales_amount(1)
          ,Base_Fields.InvalidMessage_annual_sales_size_code(1)
          ,Base_Fields.InvalidMessage_location_code(1)
          ,Base_Fields.InvalidMessage_primary_sic_code_industry_classification(1)
          ,Base_Fields.InvalidMessage_primary_sic_code_4_digit(1)
          ,Base_Fields.InvalidMessage_primary_sic_code(1)
          ,Base_Fields.InvalidMessage_second_sic_code(1)
          ,Base_Fields.InvalidMessage_third_sic_code(1)
          ,Base_Fields.InvalidMessage_fourth_sic_code(1)
          ,Base_Fields.InvalidMessage_fifth_sic_code(1)
          ,Base_Fields.InvalidMessage_sixth_sic_code(1)
          ,Base_Fields.InvalidMessage_primary_naics_code(1)
          ,Base_Fields.InvalidMessage_second_naics_code(1)
          ,Base_Fields.InvalidMessage_third_naics_code(1)
          ,Base_Fields.InvalidMessage_fourth_naics_code(1)
          ,Base_Fields.InvalidMessage_executive_count(1)
          ,Base_Fields.InvalidMessage_business_type(1)
          ,Base_Fields.InvalidMessage_ownership_code(1)
          ,Base_Fields.InvalidMessage_derogatory_indicator(1)
          ,Base_Fields.InvalidMessage_recent_derogatory_filed_date(1)
          ,Base_Fields.InvalidMessage_derogatory_liability_amount_sign(1)
          ,Base_Fields.InvalidMessage_derogatory_liability_amount(1)
          ,Base_Fields.InvalidMessage_ucc_data_indicator(1)
          ,Base_Fields.InvalidMessage_ucc_count(1)
          ,Base_Fields.InvalidMessage_number_of_legal_items(1)
          ,Base_Fields.InvalidMessage_legal_balance_sign(1)
          ,Base_Fields.InvalidMessage_legal_balance_amount(1)
          ,Base_Fields.InvalidMessage_pmtkbankruptcy(1)
          ,Base_Fields.InvalidMessage_pmtkjudgment(1)
          ,Base_Fields.InvalidMessage_pmtktaxlien(1)
          ,Base_Fields.InvalidMessage_pmtkpayment(1)
          ,Base_Fields.InvalidMessage_bankruptcy_filed(1)
          ,Base_Fields.InvalidMessage_number_of_derogatory_legal_items(1)
          ,Base_Fields.InvalidMessage_lien_count(1)
          ,Base_Fields.InvalidMessage_judgment_count(1)
          ,Base_Fields.InvalidMessage_bkc006(1)
          ,Base_Fields.InvalidMessage_bkc007(1)
          ,Base_Fields.InvalidMessage_bkc008(1)
          ,Base_Fields.InvalidMessage_bko009(1)
          ,Base_Fields.InvalidMessage_bkb001_sign(1)
          ,Base_Fields.InvalidMessage_bkb001(1)
          ,Base_Fields.InvalidMessage_bkb003_sign(1)
          ,Base_Fields.InvalidMessage_bkb003(1)
          ,Base_Fields.InvalidMessage_bko010(1)
          ,Base_Fields.InvalidMessage_bko011(1)
          ,Base_Fields.InvalidMessage_jdc010(1)
          ,Base_Fields.InvalidMessage_jdc011(1)
          ,Base_Fields.InvalidMessage_jdc012(1)
          ,Base_Fields.InvalidMessage_jdb004(1)
          ,Base_Fields.InvalidMessage_jdb005(1)
          ,Base_Fields.InvalidMessage_jdb006(1)
          ,Base_Fields.InvalidMessage_jDO013(1)
          ,Base_Fields.InvalidMessage_jDO014(1)
          ,Base_Fields.InvalidMessage_jdb002(1)
          ,Base_Fields.InvalidMessage_jdp016(1)
          ,Base_Fields.InvalidMessage_lgc004(1)
          ,Base_Fields.InvalidMessage_pro001(1)
          ,Base_Fields.InvalidMessage_pro003(1)
          ,Base_Fields.InvalidMessage_txc010(1)
          ,Base_Fields.InvalidMessage_txc011(1)
          ,Base_Fields.InvalidMessage_txb004_sign(1)
          ,Base_Fields.InvalidMessage_txb004(1)
          ,Base_Fields.InvalidMessage_txo013(1)
          ,Base_Fields.InvalidMessage_txb002_sign(1)
          ,Base_Fields.InvalidMessage_txb002(1)
          ,Base_Fields.InvalidMessage_txp016(1)
          ,Base_Fields.InvalidMessage_ucc001(1)
          ,Base_Fields.InvalidMessage_ucc002(1)
          ,Base_Fields.InvalidMessage_ucc003(1)
          ,Base_Fields.InvalidMessage_intelliscore_plus(1)
          ,Base_Fields.InvalidMessage_percentile_model(1)
          ,Base_Fields.InvalidMessage_model_action(1)
          ,Base_Fields.InvalidMessage_score_factor_1(1)
          ,Base_Fields.InvalidMessage_score_factor_2(1)
          ,Base_Fields.InvalidMessage_score_factor_3(1)
          ,Base_Fields.InvalidMessage_score_factor_4(1)
          ,Base_Fields.InvalidMessage_model_type(1)
          ,Base_Fields.InvalidMessage_last_experian_inquiry_date(1)
          ,Base_Fields.InvalidMessage_recent_high_credit_sign(1)
          ,Base_Fields.InvalidMessage_recent_high_credit(1)
          ,Base_Fields.InvalidMessage_median_credit_amount_sign(1)
          ,Base_Fields.InvalidMessage_median_credit_amount(1)
          ,Base_Fields.InvalidMessage_total_combined_trade_lines_count(1)
          ,Base_Fields.InvalidMessage_dbt_of_combined_trade_totals(1)
          ,Base_Fields.InvalidMessage_combined_trade_balance(1)
          ,Base_Fields.InvalidMessage_aged_trade_lines(1)
          ,Base_Fields.InvalidMessage_experian_credit_rating(1)
          ,Base_Fields.InvalidMessage_quarter_1_average_dbt(1)
          ,Base_Fields.InvalidMessage_quarter_2_average_dbt(1)
          ,Base_Fields.InvalidMessage_quarter_3_average_dbt(1)
          ,Base_Fields.InvalidMessage_quarter_4_average_dbt(1)
          ,Base_Fields.InvalidMessage_quarter_5_average_dbt(1)
          ,Base_Fields.InvalidMessage_combined_dbt(1)
          ,Base_Fields.InvalidMessage_total_account_balance_sign(1)
          ,Base_Fields.InvalidMessage_total_account_balance(1)
          ,Base_Fields.InvalidMessage_combined_account_balance_sign(1)
          ,Base_Fields.InvalidMessage_combined_account_balance(1)
          ,Base_Fields.InvalidMessage_collection_count(1)
          ,Base_Fields.InvalidMessage_atc021(1)
          ,Base_Fields.InvalidMessage_atc022(1)
          ,Base_Fields.InvalidMessage_atc023(1)
          ,Base_Fields.InvalidMessage_atc024(1)
          ,Base_Fields.InvalidMessage_atc025(1)
          ,Base_Fields.InvalidMessage_last_activity_age_code(1)
          ,Base_Fields.InvalidMessage_cottage_indicator(1)
          ,Base_Fields.InvalidMessage_nonprofit_indicator(1)
          ,Base_Fields.InvalidMessage_financial_stability_risk_score(1)
          ,Base_Fields.InvalidMessage_fsr_risk_class(1)
          ,Base_Fields.InvalidMessage_fsr_score_factor_1(1)
          ,Base_Fields.InvalidMessage_fsr_score_factor_2(1)
          ,Base_Fields.InvalidMessage_fsr_score_factor_3(1)
          ,Base_Fields.InvalidMessage_fsr_score_factor_4(1)
          ,Base_Fields.InvalidMessage_ip_score_change_sign(1)
          ,Base_Fields.InvalidMessage_ip_score_change(1)
          ,Base_Fields.InvalidMessage_fsr_score_change_sign(1)
          ,Base_Fields.InvalidMessage_fsr_score_change(1)
          ,Base_Fields.InvalidMessage_clean_dba_name(1)
          ,Base_Fields.InvalidMessage_predir(1)
          ,Base_Fields.InvalidMessage_prim_name(1)
          ,Base_Fields.InvalidMessage_postdir(1)
          ,Base_Fields.InvalidMessage_p_city_name(1)
          ,Base_Fields.InvalidMessage_v_city_name(1)
          ,Base_Fields.InvalidMessage_st(1)
          ,Base_Fields.InvalidMessage_zip(1)
          ,Base_Fields.InvalidMessage_zip4(1)
          ,Base_Fields.InvalidMessage_cart(1)
          ,Base_Fields.InvalidMessage_cr_sort_sz(1)
          ,Base_Fields.InvalidMessage_lot(1)
          ,Base_Fields.InvalidMessage_lot_order(1)
          ,Base_Fields.InvalidMessage_dbpc(1)
          ,Base_Fields.InvalidMessage_chk_digit(1)
          ,Base_Fields.InvalidMessage_fips_state(1)
          ,Base_Fields.InvalidMessage_fips_county(1)
          ,Base_Fields.InvalidMessage_geo_lat(1)
          ,Base_Fields.InvalidMessage_geo_long(1)
          ,Base_Fields.InvalidMessage_msa(1)
          ,Base_Fields.InvalidMessage_geo_match(1)
          ,Base_Fields.InvalidMessage_err_stat(1)
          ,Base_Fields.InvalidMessage_company_name(1)
          ,Base_Fields.InvalidMessage_p_fname(1)
          ,Base_Fields.InvalidMessage_p_mname(1)
          ,Base_Fields.InvalidMessage_p_lname(1)
          ,Base_Fields.InvalidMessage_raw_aid(1)
          ,Base_Fields.InvalidMessage_ace_aid(1)
          ,Base_Fields.InvalidMessage_prep_addr_line1(1)
          ,Base_Fields.InvalidMessage_prep_addr_line_last(1)
          ,Base_Fields.InvalidMessage_source_rec_id(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.powscore_CUSTOM_ErrorCount
          ,le.powweight_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.proxscore_CUSTOM_ErrorCount
          ,le.proxweight_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.selescore_CUSTOM_ErrorCount
          ,le.seleweight_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.orgscore_CUSTOM_ErrorCount
          ,le.orgweight_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.ultscore_CUSTOM_ErrorCount
          ,le.ultweight_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.bdid_score_CUSTOM_ErrorCount
          ,le.did_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.experian_bus_id_CUSTOM_ErrorCount
          ,le.business_name_CUSTOM_ErrorCount
          ,le.address_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.zip_plus_4_CUSTOM_ErrorCount
          ,le.carrier_route_ALLOW_ErrorCount
          ,le.county_code_CUSTOM_ErrorCount
          ,le.county_name_ALLOW_ErrorCount
          ,le.phone_number_CUSTOM_ErrorCount
          ,le.msa_code_CUSTOM_ErrorCount
          ,le.establish_date_CUSTOM_ErrorCount
          ,le.latest_reported_date_CUSTOM_ErrorCount
          ,le.years_in_file_CUSTOM_ErrorCount
          ,le.geo_code_latitude_ALLOW_ErrorCount
          ,le.geo_code_latitude_direction_ALLOW_ErrorCount
          ,le.geo_code_longitude_ALLOW_ErrorCount
          ,le.geo_code_longitude_direction_ALLOW_ErrorCount
          ,le.recent_update_code_ENUM_ErrorCount
          ,le.years_in_business_code_ALLOW_ErrorCount
          ,le.year_business_started_CUSTOM_ErrorCount
          ,le.months_in_file_CUSTOM_ErrorCount
          ,le.address_type_code_ALLOW_ErrorCount
          ,le.estimated_number_of_employees_CUSTOM_ErrorCount
          ,le.employee_size_code_ALLOW_ErrorCount
          ,le.estimated_annual_sales_amount_sign_ENUM_ErrorCount
          ,le.estimated_annual_sales_amount_CUSTOM_ErrorCount
          ,le.annual_sales_size_code_ENUM_ErrorCount
          ,le.location_code_ENUM_ErrorCount
          ,le.primary_sic_code_industry_classification_ENUM_ErrorCount
          ,le.primary_sic_code_4_digit_CUSTOM_ErrorCount
          ,le.primary_sic_code_CUSTOM_ErrorCount
          ,le.second_sic_code_CUSTOM_ErrorCount
          ,le.third_sic_code_CUSTOM_ErrorCount
          ,le.fourth_sic_code_CUSTOM_ErrorCount
          ,le.fifth_sic_code_CUSTOM_ErrorCount
          ,le.sixth_sic_code_CUSTOM_ErrorCount
          ,le.primary_naics_code_CUSTOM_ErrorCount
          ,le.second_naics_code_CUSTOM_ErrorCount
          ,le.third_naics_code_CUSTOM_ErrorCount
          ,le.fourth_naics_code_CUSTOM_ErrorCount
          ,le.executive_count_CUSTOM_ErrorCount
          ,le.business_type_ALLOW_ErrorCount
          ,le.ownership_code_ALLOW_ErrorCount
          ,le.derogatory_indicator_ALLOW_ErrorCount
          ,le.recent_derogatory_filed_date_CUSTOM_ErrorCount
          ,le.derogatory_liability_amount_sign_ENUM_ErrorCount
          ,le.derogatory_liability_amount_CUSTOM_ErrorCount
          ,le.ucc_data_indicator_ALLOW_ErrorCount
          ,le.ucc_count_CUSTOM_ErrorCount
          ,le.number_of_legal_items_CUSTOM_ErrorCount
          ,le.legal_balance_sign_ENUM_ErrorCount
          ,le.legal_balance_amount_CUSTOM_ErrorCount
          ,le.pmtkbankruptcy_ENUM_ErrorCount
          ,le.pmtkjudgment_ENUM_ErrorCount
          ,le.pmtktaxlien_ENUM_ErrorCount
          ,le.pmtkpayment_ENUM_ErrorCount
          ,le.bankruptcy_filed_ENUM_ErrorCount
          ,le.number_of_derogatory_legal_items_CUSTOM_ErrorCount
          ,le.lien_count_CUSTOM_ErrorCount
          ,le.judgment_count_CUSTOM_ErrorCount
          ,le.bkc006_CUSTOM_ErrorCount
          ,le.bkc007_CUSTOM_ErrorCount
          ,le.bkc008_CUSTOM_ErrorCount
          ,le.bko009_CUSTOM_ErrorCount
          ,le.bkb001_sign_ENUM_ErrorCount
          ,le.bkb001_CUSTOM_ErrorCount
          ,le.bkb003_sign_ENUM_ErrorCount
          ,le.bkb003_CUSTOM_ErrorCount
          ,le.bko010_CUSTOM_ErrorCount
          ,le.bko011_CUSTOM_ErrorCount
          ,le.jdc010_CUSTOM_ErrorCount
          ,le.jdc011_CUSTOM_ErrorCount
          ,le.jdc012_CUSTOM_ErrorCount
          ,le.jdb004_CUSTOM_ErrorCount
          ,le.jdb005_CUSTOM_ErrorCount
          ,le.jdb006_CUSTOM_ErrorCount
          ,le.jDO013_CUSTOM_ErrorCount
          ,le.jDO014_CUSTOM_ErrorCount
          ,le.jdb002_CUSTOM_ErrorCount
          ,le.jdp016_CUSTOM_ErrorCount
          ,le.lgc004_CUSTOM_ErrorCount
          ,le.pro001_CUSTOM_ErrorCount
          ,le.pro003_CUSTOM_ErrorCount
          ,le.txc010_CUSTOM_ErrorCount
          ,le.txc011_CUSTOM_ErrorCount
          ,le.txb004_sign_ENUM_ErrorCount
          ,le.txb004_CUSTOM_ErrorCount
          ,le.txo013_CUSTOM_ErrorCount
          ,le.txb002_sign_ENUM_ErrorCount
          ,le.txb002_CUSTOM_ErrorCount
          ,le.txp016_CUSTOM_ErrorCount
          ,le.ucc001_CUSTOM_ErrorCount
          ,le.ucc002_CUSTOM_ErrorCount
          ,le.ucc003_CUSTOM_ErrorCount
          ,le.intelliscore_plus_CUSTOM_ErrorCount
          ,le.percentile_model_CUSTOM_ErrorCount
          ,le.model_action_ENUM_ErrorCount
          ,le.score_factor_1_CUSTOM_ErrorCount
          ,le.score_factor_2_CUSTOM_ErrorCount
          ,le.score_factor_3_CUSTOM_ErrorCount
          ,le.score_factor_4_CUSTOM_ErrorCount
          ,le.model_type_ALLOW_ErrorCount
          ,le.last_experian_inquiry_date_CUSTOM_ErrorCount
          ,le.recent_high_credit_sign_ENUM_ErrorCount
          ,le.recent_high_credit_CUSTOM_ErrorCount
          ,le.median_credit_amount_sign_ENUM_ErrorCount
          ,le.median_credit_amount_CUSTOM_ErrorCount
          ,le.total_combined_trade_lines_count_CUSTOM_ErrorCount
          ,le.dbt_of_combined_trade_totals_CUSTOM_ErrorCount
          ,le.combined_trade_balance_CUSTOM_ErrorCount
          ,le.aged_trade_lines_ALLOW_ErrorCount
          ,le.experian_credit_rating_ALLOW_ErrorCount
          ,le.quarter_1_average_dbt_CUSTOM_ErrorCount
          ,le.quarter_2_average_dbt_CUSTOM_ErrorCount
          ,le.quarter_3_average_dbt_CUSTOM_ErrorCount
          ,le.quarter_4_average_dbt_CUSTOM_ErrorCount
          ,le.quarter_5_average_dbt_CUSTOM_ErrorCount
          ,le.combined_dbt_CUSTOM_ErrorCount
          ,le.total_account_balance_sign_ENUM_ErrorCount
          ,le.total_account_balance_CUSTOM_ErrorCount
          ,le.combined_account_balance_sign_ENUM_ErrorCount
          ,le.combined_account_balance_CUSTOM_ErrorCount
          ,le.collection_count_CUSTOM_ErrorCount
          ,le.atc021_CUSTOM_ErrorCount
          ,le.atc022_CUSTOM_ErrorCount
          ,le.atc023_CUSTOM_ErrorCount
          ,le.atc024_CUSTOM_ErrorCount
          ,le.atc025_CUSTOM_ErrorCount
          ,le.last_activity_age_code_ALLOW_ErrorCount
          ,le.cottage_indicator_ENUM_ErrorCount
          ,le.nonprofit_indicator_ALLOW_ErrorCount
          ,le.financial_stability_risk_score_CUSTOM_ErrorCount
          ,le.fsr_risk_class_ALLOW_ErrorCount
          ,le.fsr_score_factor_1_CUSTOM_ErrorCount
          ,le.fsr_score_factor_2_CUSTOM_ErrorCount
          ,le.fsr_score_factor_3_CUSTOM_ErrorCount
          ,le.fsr_score_factor_4_CUSTOM_ErrorCount
          ,le.ip_score_change_sign_ENUM_ErrorCount
          ,le.ip_score_change_CUSTOM_ErrorCount
          ,le.fsr_score_change_sign_ENUM_ErrorCount
          ,le.fsr_score_change_CUSTOM_ErrorCount
          ,le.clean_dba_name_CUSTOM_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dbpc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.p_fname_CUSTOM_ErrorCount
          ,le.p_mname_CUSTOM_ErrorCount
          ,le.p_lname_CUSTOM_ErrorCount
          ,le.raw_aid_CUSTOM_ErrorCount
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_line_last_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dotid_ENUM_ErrorCount
          ,le.dotscore_ENUM_ErrorCount
          ,le.dotweight_ENUM_ErrorCount
          ,le.empid_ENUM_ErrorCount
          ,le.empscore_ENUM_ErrorCount
          ,le.empweight_ENUM_ErrorCount
          ,le.powid_CUSTOM_ErrorCount
          ,le.powscore_CUSTOM_ErrorCount
          ,le.powweight_CUSTOM_ErrorCount
          ,le.proxid_CUSTOM_ErrorCount
          ,le.proxscore_CUSTOM_ErrorCount
          ,le.proxweight_CUSTOM_ErrorCount
          ,le.seleid_CUSTOM_ErrorCount
          ,le.selescore_CUSTOM_ErrorCount
          ,le.seleweight_CUSTOM_ErrorCount
          ,le.orgid_CUSTOM_ErrorCount
          ,le.orgscore_CUSTOM_ErrorCount
          ,le.orgweight_CUSTOM_ErrorCount
          ,le.ultid_CUSTOM_ErrorCount
          ,le.ultscore_CUSTOM_ErrorCount
          ,le.ultweight_CUSTOM_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.bdid_score_CUSTOM_ErrorCount
          ,le.did_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.experian_bus_id_CUSTOM_ErrorCount
          ,le.business_name_CUSTOM_ErrorCount
          ,le.address_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.zip_plus_4_CUSTOM_ErrorCount
          ,le.carrier_route_ALLOW_ErrorCount
          ,le.county_code_CUSTOM_ErrorCount
          ,le.county_name_ALLOW_ErrorCount
          ,le.phone_number_CUSTOM_ErrorCount
          ,le.msa_code_CUSTOM_ErrorCount
          ,le.establish_date_CUSTOM_ErrorCount
          ,le.latest_reported_date_CUSTOM_ErrorCount
          ,le.years_in_file_CUSTOM_ErrorCount
          ,le.geo_code_latitude_ALLOW_ErrorCount
          ,le.geo_code_latitude_direction_ALLOW_ErrorCount
          ,le.geo_code_longitude_ALLOW_ErrorCount
          ,le.geo_code_longitude_direction_ALLOW_ErrorCount
          ,le.recent_update_code_ENUM_ErrorCount
          ,le.years_in_business_code_ALLOW_ErrorCount
          ,le.year_business_started_CUSTOM_ErrorCount
          ,le.months_in_file_CUSTOM_ErrorCount
          ,le.address_type_code_ALLOW_ErrorCount
          ,le.estimated_number_of_employees_CUSTOM_ErrorCount
          ,le.employee_size_code_ALLOW_ErrorCount
          ,le.estimated_annual_sales_amount_sign_ENUM_ErrorCount
          ,le.estimated_annual_sales_amount_CUSTOM_ErrorCount
          ,le.annual_sales_size_code_ENUM_ErrorCount
          ,le.location_code_ENUM_ErrorCount
          ,le.primary_sic_code_industry_classification_ENUM_ErrorCount
          ,le.primary_sic_code_4_digit_CUSTOM_ErrorCount
          ,le.primary_sic_code_CUSTOM_ErrorCount
          ,le.second_sic_code_CUSTOM_ErrorCount
          ,le.third_sic_code_CUSTOM_ErrorCount
          ,le.fourth_sic_code_CUSTOM_ErrorCount
          ,le.fifth_sic_code_CUSTOM_ErrorCount
          ,le.sixth_sic_code_CUSTOM_ErrorCount
          ,le.primary_naics_code_CUSTOM_ErrorCount
          ,le.second_naics_code_CUSTOM_ErrorCount
          ,le.third_naics_code_CUSTOM_ErrorCount
          ,le.fourth_naics_code_CUSTOM_ErrorCount
          ,le.executive_count_CUSTOM_ErrorCount
          ,le.business_type_ALLOW_ErrorCount
          ,le.ownership_code_ALLOW_ErrorCount
          ,le.derogatory_indicator_ALLOW_ErrorCount
          ,le.recent_derogatory_filed_date_CUSTOM_ErrorCount
          ,le.derogatory_liability_amount_sign_ENUM_ErrorCount
          ,le.derogatory_liability_amount_CUSTOM_ErrorCount
          ,le.ucc_data_indicator_ALLOW_ErrorCount
          ,le.ucc_count_CUSTOM_ErrorCount
          ,le.number_of_legal_items_CUSTOM_ErrorCount
          ,le.legal_balance_sign_ENUM_ErrorCount
          ,le.legal_balance_amount_CUSTOM_ErrorCount
          ,le.pmtkbankruptcy_ENUM_ErrorCount
          ,le.pmtkjudgment_ENUM_ErrorCount
          ,le.pmtktaxlien_ENUM_ErrorCount
          ,le.pmtkpayment_ENUM_ErrorCount
          ,le.bankruptcy_filed_ENUM_ErrorCount
          ,le.number_of_derogatory_legal_items_CUSTOM_ErrorCount
          ,le.lien_count_CUSTOM_ErrorCount
          ,le.judgment_count_CUSTOM_ErrorCount
          ,le.bkc006_CUSTOM_ErrorCount
          ,le.bkc007_CUSTOM_ErrorCount
          ,le.bkc008_CUSTOM_ErrorCount
          ,le.bko009_CUSTOM_ErrorCount
          ,le.bkb001_sign_ENUM_ErrorCount
          ,le.bkb001_CUSTOM_ErrorCount
          ,le.bkb003_sign_ENUM_ErrorCount
          ,le.bkb003_CUSTOM_ErrorCount
          ,le.bko010_CUSTOM_ErrorCount
          ,le.bko011_CUSTOM_ErrorCount
          ,le.jdc010_CUSTOM_ErrorCount
          ,le.jdc011_CUSTOM_ErrorCount
          ,le.jdc012_CUSTOM_ErrorCount
          ,le.jdb004_CUSTOM_ErrorCount
          ,le.jdb005_CUSTOM_ErrorCount
          ,le.jdb006_CUSTOM_ErrorCount
          ,le.jDO013_CUSTOM_ErrorCount
          ,le.jDO014_CUSTOM_ErrorCount
          ,le.jdb002_CUSTOM_ErrorCount
          ,le.jdp016_CUSTOM_ErrorCount
          ,le.lgc004_CUSTOM_ErrorCount
          ,le.pro001_CUSTOM_ErrorCount
          ,le.pro003_CUSTOM_ErrorCount
          ,le.txc010_CUSTOM_ErrorCount
          ,le.txc011_CUSTOM_ErrorCount
          ,le.txb004_sign_ENUM_ErrorCount
          ,le.txb004_CUSTOM_ErrorCount
          ,le.txo013_CUSTOM_ErrorCount
          ,le.txb002_sign_ENUM_ErrorCount
          ,le.txb002_CUSTOM_ErrorCount
          ,le.txp016_CUSTOM_ErrorCount
          ,le.ucc001_CUSTOM_ErrorCount
          ,le.ucc002_CUSTOM_ErrorCount
          ,le.ucc003_CUSTOM_ErrorCount
          ,le.intelliscore_plus_CUSTOM_ErrorCount
          ,le.percentile_model_CUSTOM_ErrorCount
          ,le.model_action_ENUM_ErrorCount
          ,le.score_factor_1_CUSTOM_ErrorCount
          ,le.score_factor_2_CUSTOM_ErrorCount
          ,le.score_factor_3_CUSTOM_ErrorCount
          ,le.score_factor_4_CUSTOM_ErrorCount
          ,le.model_type_ALLOW_ErrorCount
          ,le.last_experian_inquiry_date_CUSTOM_ErrorCount
          ,le.recent_high_credit_sign_ENUM_ErrorCount
          ,le.recent_high_credit_CUSTOM_ErrorCount
          ,le.median_credit_amount_sign_ENUM_ErrorCount
          ,le.median_credit_amount_CUSTOM_ErrorCount
          ,le.total_combined_trade_lines_count_CUSTOM_ErrorCount
          ,le.dbt_of_combined_trade_totals_CUSTOM_ErrorCount
          ,le.combined_trade_balance_CUSTOM_ErrorCount
          ,le.aged_trade_lines_ALLOW_ErrorCount
          ,le.experian_credit_rating_ALLOW_ErrorCount
          ,le.quarter_1_average_dbt_CUSTOM_ErrorCount
          ,le.quarter_2_average_dbt_CUSTOM_ErrorCount
          ,le.quarter_3_average_dbt_CUSTOM_ErrorCount
          ,le.quarter_4_average_dbt_CUSTOM_ErrorCount
          ,le.quarter_5_average_dbt_CUSTOM_ErrorCount
          ,le.combined_dbt_CUSTOM_ErrorCount
          ,le.total_account_balance_sign_ENUM_ErrorCount
          ,le.total_account_balance_CUSTOM_ErrorCount
          ,le.combined_account_balance_sign_ENUM_ErrorCount
          ,le.combined_account_balance_CUSTOM_ErrorCount
          ,le.collection_count_CUSTOM_ErrorCount
          ,le.atc021_CUSTOM_ErrorCount
          ,le.atc022_CUSTOM_ErrorCount
          ,le.atc023_CUSTOM_ErrorCount
          ,le.atc024_CUSTOM_ErrorCount
          ,le.atc025_CUSTOM_ErrorCount
          ,le.last_activity_age_code_ALLOW_ErrorCount
          ,le.cottage_indicator_ENUM_ErrorCount
          ,le.nonprofit_indicator_ALLOW_ErrorCount
          ,le.financial_stability_risk_score_CUSTOM_ErrorCount
          ,le.fsr_risk_class_ALLOW_ErrorCount
          ,le.fsr_score_factor_1_CUSTOM_ErrorCount
          ,le.fsr_score_factor_2_CUSTOM_ErrorCount
          ,le.fsr_score_factor_3_CUSTOM_ErrorCount
          ,le.fsr_score_factor_4_CUSTOM_ErrorCount
          ,le.ip_score_change_sign_ENUM_ErrorCount
          ,le.ip_score_change_CUSTOM_ErrorCount
          ,le.fsr_score_change_sign_ENUM_ErrorCount
          ,le.fsr_score_change_CUSTOM_ErrorCount
          ,le.clean_dba_name_CUSTOM_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_CUSTOM_ErrorCount
          ,le.v_city_name_CUSTOM_ErrorCount
          ,le.st_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.cart_CUSTOM_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_CUSTOM_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dbpc_CUSTOM_ErrorCount
          ,le.chk_digit_CUSTOM_ErrorCount
          ,le.fips_state_CUSTOM_ErrorCount
          ,le.fips_county_CUSTOM_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.geo_match_CUSTOM_ErrorCount
          ,le.err_stat_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.p_fname_CUSTOM_ErrorCount
          ,le.p_mname_CUSTOM_ErrorCount
          ,le.p_lname_CUSTOM_ErrorCount
          ,le.raw_aid_CUSTOM_ErrorCount
          ,le.ace_aid_CUSTOM_ErrorCount
          ,le.prep_addr_line1_CUSTOM_ErrorCount
          ,le.prep_addr_line_last_CUSTOM_ErrorCount
          ,le.source_rec_id_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_Experian_CRDB));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'experian_bus_id:' + getFieldTypeText(h.experian_bus_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_name:' + getFieldTypeText(h.business_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_plus_4:' + getFieldTypeText(h.zip_plus_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_route:' + getFieldTypeText(h.carrier_route) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_code:' + getFieldTypeText(h.county_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa_code:' + getFieldTypeText(h.msa_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa_description:' + getFieldTypeText(h.msa_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'establish_date:' + getFieldTypeText(h.establish_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'latest_reported_date:' + getFieldTypeText(h.latest_reported_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'years_in_file:' + getFieldTypeText(h.years_in_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_code_latitude:' + getFieldTypeText(h.geo_code_latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_code_latitude_direction:' + getFieldTypeText(h.geo_code_latitude_direction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_code_longitude:' + getFieldTypeText(h.geo_code_longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_code_longitude_direction:' + getFieldTypeText(h.geo_code_longitude_direction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_update_code:' + getFieldTypeText(h.recent_update_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'years_in_business_code:' + getFieldTypeText(h.years_in_business_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'year_business_started:' + getFieldTypeText(h.year_business_started) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'months_in_file:' + getFieldTypeText(h.months_in_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type_code:' + getFieldTypeText(h.address_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'estimated_number_of_employees:' + getFieldTypeText(h.estimated_number_of_employees) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'employee_size_code:' + getFieldTypeText(h.employee_size_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'estimated_annual_sales_amount_sign:' + getFieldTypeText(h.estimated_annual_sales_amount_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'estimated_annual_sales_amount:' + getFieldTypeText(h.estimated_annual_sales_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'annual_sales_size_code:' + getFieldTypeText(h.annual_sales_size_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_code:' + getFieldTypeText(h.location_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_sic_code_industry_classification:' + getFieldTypeText(h.primary_sic_code_industry_classification) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_sic_code_4_digit:' + getFieldTypeText(h.primary_sic_code_4_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_sic_code:' + getFieldTypeText(h.primary_sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_sic_code:' + getFieldTypeText(h.second_sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'third_sic_code:' + getFieldTypeText(h.third_sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fourth_sic_code:' + getFieldTypeText(h.fourth_sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fifth_sic_code:' + getFieldTypeText(h.fifth_sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sixth_sic_code:' + getFieldTypeText(h.sixth_sic_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_naics_code:' + getFieldTypeText(h.primary_naics_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_naics_code:' + getFieldTypeText(h.second_naics_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'third_naics_code:' + getFieldTypeText(h.third_naics_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fourth_naics_code:' + getFieldTypeText(h.fourth_naics_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_count:' + getFieldTypeText(h.executive_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_last_name:' + getFieldTypeText(h.executive_last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_first_name:' + getFieldTypeText(h.executive_first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_middle_initial:' + getFieldTypeText(h.executive_middle_initial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'executive_title:' + getFieldTypeText(h.executive_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_type:' + getFieldTypeText(h.business_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownership_code:' + getFieldTypeText(h.ownership_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'url:' + getFieldTypeText(h.url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'derogatory_indicator:' + getFieldTypeText(h.derogatory_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_derogatory_filed_date:' + getFieldTypeText(h.recent_derogatory_filed_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'derogatory_liability_amount_sign:' + getFieldTypeText(h.derogatory_liability_amount_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'derogatory_liability_amount:' + getFieldTypeText(h.derogatory_liability_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ucc_data_indicator:' + getFieldTypeText(h.ucc_data_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ucc_count:' + getFieldTypeText(h.ucc_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'number_of_legal_items:' + getFieldTypeText(h.number_of_legal_items) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_balance_sign:' + getFieldTypeText(h.legal_balance_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_balance_amount:' + getFieldTypeText(h.legal_balance_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pmtkbankruptcy:' + getFieldTypeText(h.pmtkbankruptcy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pmtkjudgment:' + getFieldTypeText(h.pmtkjudgment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pmtktaxlien:' + getFieldTypeText(h.pmtktaxlien) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pmtkpayment:' + getFieldTypeText(h.pmtkpayment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bankruptcy_filed:' + getFieldTypeText(h.bankruptcy_filed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'number_of_derogatory_legal_items:' + getFieldTypeText(h.number_of_derogatory_legal_items) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lien_count:' + getFieldTypeText(h.lien_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgment_count:' + getFieldTypeText(h.judgment_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkc006:' + getFieldTypeText(h.bkc006) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkc007:' + getFieldTypeText(h.bkc007) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkc008:' + getFieldTypeText(h.bkc008) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bko009:' + getFieldTypeText(h.bko009) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkb001_sign:' + getFieldTypeText(h.bkb001_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkb001:' + getFieldTypeText(h.bkb001) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkb003_sign:' + getFieldTypeText(h.bkb003_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkb003:' + getFieldTypeText(h.bkb003) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bko010:' + getFieldTypeText(h.bko010) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bko011:' + getFieldTypeText(h.bko011) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jdc010:' + getFieldTypeText(h.jdc010) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jdc011:' + getFieldTypeText(h.jdc011) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jdc012:' + getFieldTypeText(h.jdc012) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jdb004:' + getFieldTypeText(h.jdb004) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jdb005:' + getFieldTypeText(h.jdb005) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jdb006:' + getFieldTypeText(h.jdb006) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jDO013:' + getFieldTypeText(h.jDO013) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jDO014:' + getFieldTypeText(h.jDO014) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jdb002:' + getFieldTypeText(h.jdb002) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jdp016:' + getFieldTypeText(h.jdp016) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lgc004:' + getFieldTypeText(h.lgc004) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pro001:' + getFieldTypeText(h.pro001) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pro003:' + getFieldTypeText(h.pro003) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'txc010:' + getFieldTypeText(h.txc010) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'txc011:' + getFieldTypeText(h.txc011) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'txb004_sign:' + getFieldTypeText(h.txb004_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'txb004:' + getFieldTypeText(h.txb004) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'txo013:' + getFieldTypeText(h.txo013) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'txb002_sign:' + getFieldTypeText(h.txb002_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'txb002:' + getFieldTypeText(h.txb002) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'txp016:' + getFieldTypeText(h.txp016) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ucc001:' + getFieldTypeText(h.ucc001) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ucc002:' + getFieldTypeText(h.ucc002) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ucc003:' + getFieldTypeText(h.ucc003) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'intelliscore_plus:' + getFieldTypeText(h.intelliscore_plus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'percentile_model:' + getFieldTypeText(h.percentile_model) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_action:' + getFieldTypeText(h.model_action) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'score_factor_1:' + getFieldTypeText(h.score_factor_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'score_factor_2:' + getFieldTypeText(h.score_factor_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'score_factor_3:' + getFieldTypeText(h.score_factor_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'score_factor_4:' + getFieldTypeText(h.score_factor_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_code:' + getFieldTypeText(h.model_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_type:' + getFieldTypeText(h.model_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_experian_inquiry_date:' + getFieldTypeText(h.last_experian_inquiry_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_high_credit_sign:' + getFieldTypeText(h.recent_high_credit_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_high_credit:' + getFieldTypeText(h.recent_high_credit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'median_credit_amount_sign:' + getFieldTypeText(h.median_credit_amount_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'median_credit_amount:' + getFieldTypeText(h.median_credit_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_combined_trade_lines_count:' + getFieldTypeText(h.total_combined_trade_lines_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbt_of_combined_trade_totals:' + getFieldTypeText(h.dbt_of_combined_trade_totals) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'combined_trade_balance:' + getFieldTypeText(h.combined_trade_balance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aged_trade_lines:' + getFieldTypeText(h.aged_trade_lines) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'experian_credit_rating:' + getFieldTypeText(h.experian_credit_rating) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'quarter_1_average_dbt:' + getFieldTypeText(h.quarter_1_average_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'quarter_2_average_dbt:' + getFieldTypeText(h.quarter_2_average_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'quarter_3_average_dbt:' + getFieldTypeText(h.quarter_3_average_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'quarter_4_average_dbt:' + getFieldTypeText(h.quarter_4_average_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'quarter_5_average_dbt:' + getFieldTypeText(h.quarter_5_average_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'combined_dbt:' + getFieldTypeText(h.combined_dbt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_account_balance_sign:' + getFieldTypeText(h.total_account_balance_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_account_balance:' + getFieldTypeText(h.total_account_balance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'combined_account_balance_sign:' + getFieldTypeText(h.combined_account_balance_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'combined_account_balance:' + getFieldTypeText(h.combined_account_balance) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'collection_count:' + getFieldTypeText(h.collection_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'atc021:' + getFieldTypeText(h.atc021) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'atc022:' + getFieldTypeText(h.atc022) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'atc023:' + getFieldTypeText(h.atc023) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'atc024:' + getFieldTypeText(h.atc024) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'atc025:' + getFieldTypeText(h.atc025) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_activity_age_code:' + getFieldTypeText(h.last_activity_age_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cottage_indicator:' + getFieldTypeText(h.cottage_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nonprofit_indicator:' + getFieldTypeText(h.nonprofit_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'financial_stability_risk_score:' + getFieldTypeText(h.financial_stability_risk_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fsr_risk_class:' + getFieldTypeText(h.fsr_risk_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fsr_score_factor_1:' + getFieldTypeText(h.fsr_score_factor_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fsr_score_factor_2:' + getFieldTypeText(h.fsr_score_factor_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fsr_score_factor_3:' + getFieldTypeText(h.fsr_score_factor_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fsr_score_factor_4:' + getFieldTypeText(h.fsr_score_factor_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ip_score_change_sign:' + getFieldTypeText(h.ip_score_change_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ip_score_change:' + getFieldTypeText(h.ip_score_change) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fsr_score_change_sign:' + getFieldTypeText(h.fsr_score_change_sign) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fsr_score_change:' + getFieldTypeText(h.fsr_score_change) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dba_name:' + getFieldTypeText(h.dba_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dba_name:' + getFieldTypeText(h.clean_dba_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phone:' + getFieldTypeText(h.clean_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recent_update_desc:' + getFieldTypeText(h.recent_update_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'years_in_business_desc:' + getFieldTypeText(h.years_in_business_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type_desc:' + getFieldTypeText(h.address_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'employee_size_desc:' + getFieldTypeText(h.employee_size_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'annual_sales_size_desc:' + getFieldTypeText(h.annual_sales_size_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_desc:' + getFieldTypeText(h.location_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary_sic_code_industry_class_desc:' + getFieldTypeText(h.primary_sic_code_industry_class_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_type_desc:' + getFieldTypeText(h.business_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ownership_code_desc:' + getFieldTypeText(h.ownership_code_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ucc_data_indicator_desc:' + getFieldTypeText(h.ucc_data_indicator_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'experian_credit_rating_desc:' + getFieldTypeText(h.experian_credit_rating_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_activity_age_desc:' + getFieldTypeText(h.last_activity_age_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cottage_indicator_desc:' + getFieldTypeText(h.cottage_indicator_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nonprofit_indicator_desc:' + getFieldTypeText(h.nonprofit_indicator_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_title:' + getFieldTypeText(h.p_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_fname:' + getFieldTypeText(h.p_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_mname:' + getFieldTypeText(h.p_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_lname:' + getFieldTypeText(h.p_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_name_suffix:' + getFieldTypeText(h.p_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line_last:' + getFieldTypeText(h.prep_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt
          ,le.populated_bdid_cnt
          ,le.populated_bdid_score_cnt
          ,le.populated_did_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_experian_bus_id_cnt
          ,le.populated_business_name_cnt
          ,le.populated_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_zip_plus_4_cnt
          ,le.populated_carrier_route_cnt
          ,le.populated_county_code_cnt
          ,le.populated_county_name_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_msa_code_cnt
          ,le.populated_msa_description_cnt
          ,le.populated_establish_date_cnt
          ,le.populated_latest_reported_date_cnt
          ,le.populated_years_in_file_cnt
          ,le.populated_geo_code_latitude_cnt
          ,le.populated_geo_code_latitude_direction_cnt
          ,le.populated_geo_code_longitude_cnt
          ,le.populated_geo_code_longitude_direction_cnt
          ,le.populated_recent_update_code_cnt
          ,le.populated_years_in_business_code_cnt
          ,le.populated_year_business_started_cnt
          ,le.populated_months_in_file_cnt
          ,le.populated_address_type_code_cnt
          ,le.populated_estimated_number_of_employees_cnt
          ,le.populated_employee_size_code_cnt
          ,le.populated_estimated_annual_sales_amount_sign_cnt
          ,le.populated_estimated_annual_sales_amount_cnt
          ,le.populated_annual_sales_size_code_cnt
          ,le.populated_location_code_cnt
          ,le.populated_primary_sic_code_industry_classification_cnt
          ,le.populated_primary_sic_code_4_digit_cnt
          ,le.populated_primary_sic_code_cnt
          ,le.populated_second_sic_code_cnt
          ,le.populated_third_sic_code_cnt
          ,le.populated_fourth_sic_code_cnt
          ,le.populated_fifth_sic_code_cnt
          ,le.populated_sixth_sic_code_cnt
          ,le.populated_primary_naics_code_cnt
          ,le.populated_second_naics_code_cnt
          ,le.populated_third_naics_code_cnt
          ,le.populated_fourth_naics_code_cnt
          ,le.populated_executive_count_cnt
          ,le.populated_executive_last_name_cnt
          ,le.populated_executive_first_name_cnt
          ,le.populated_executive_middle_initial_cnt
          ,le.populated_executive_title_cnt
          ,le.populated_business_type_cnt
          ,le.populated_ownership_code_cnt
          ,le.populated_url_cnt
          ,le.populated_derogatory_indicator_cnt
          ,le.populated_recent_derogatory_filed_date_cnt
          ,le.populated_derogatory_liability_amount_sign_cnt
          ,le.populated_derogatory_liability_amount_cnt
          ,le.populated_ucc_data_indicator_cnt
          ,le.populated_ucc_count_cnt
          ,le.populated_number_of_legal_items_cnt
          ,le.populated_legal_balance_sign_cnt
          ,le.populated_legal_balance_amount_cnt
          ,le.populated_pmtkbankruptcy_cnt
          ,le.populated_pmtkjudgment_cnt
          ,le.populated_pmtktaxlien_cnt
          ,le.populated_pmtkpayment_cnt
          ,le.populated_bankruptcy_filed_cnt
          ,le.populated_number_of_derogatory_legal_items_cnt
          ,le.populated_lien_count_cnt
          ,le.populated_judgment_count_cnt
          ,le.populated_bkc006_cnt
          ,le.populated_bkc007_cnt
          ,le.populated_bkc008_cnt
          ,le.populated_bko009_cnt
          ,le.populated_bkb001_sign_cnt
          ,le.populated_bkb001_cnt
          ,le.populated_bkb003_sign_cnt
          ,le.populated_bkb003_cnt
          ,le.populated_bko010_cnt
          ,le.populated_bko011_cnt
          ,le.populated_jdc010_cnt
          ,le.populated_jdc011_cnt
          ,le.populated_jdc012_cnt
          ,le.populated_jdb004_cnt
          ,le.populated_jdb005_cnt
          ,le.populated_jdb006_cnt
          ,le.populated_jDO013_cnt
          ,le.populated_jDO014_cnt
          ,le.populated_jdb002_cnt
          ,le.populated_jdp016_cnt
          ,le.populated_lgc004_cnt
          ,le.populated_pro001_cnt
          ,le.populated_pro003_cnt
          ,le.populated_txc010_cnt
          ,le.populated_txc011_cnt
          ,le.populated_txb004_sign_cnt
          ,le.populated_txb004_cnt
          ,le.populated_txo013_cnt
          ,le.populated_txb002_sign_cnt
          ,le.populated_txb002_cnt
          ,le.populated_txp016_cnt
          ,le.populated_ucc001_cnt
          ,le.populated_ucc002_cnt
          ,le.populated_ucc003_cnt
          ,le.populated_intelliscore_plus_cnt
          ,le.populated_percentile_model_cnt
          ,le.populated_model_action_cnt
          ,le.populated_score_factor_1_cnt
          ,le.populated_score_factor_2_cnt
          ,le.populated_score_factor_3_cnt
          ,le.populated_score_factor_4_cnt
          ,le.populated_model_code_cnt
          ,le.populated_model_type_cnt
          ,le.populated_last_experian_inquiry_date_cnt
          ,le.populated_recent_high_credit_sign_cnt
          ,le.populated_recent_high_credit_cnt
          ,le.populated_median_credit_amount_sign_cnt
          ,le.populated_median_credit_amount_cnt
          ,le.populated_total_combined_trade_lines_count_cnt
          ,le.populated_dbt_of_combined_trade_totals_cnt
          ,le.populated_combined_trade_balance_cnt
          ,le.populated_aged_trade_lines_cnt
          ,le.populated_experian_credit_rating_cnt
          ,le.populated_quarter_1_average_dbt_cnt
          ,le.populated_quarter_2_average_dbt_cnt
          ,le.populated_quarter_3_average_dbt_cnt
          ,le.populated_quarter_4_average_dbt_cnt
          ,le.populated_quarter_5_average_dbt_cnt
          ,le.populated_combined_dbt_cnt
          ,le.populated_total_account_balance_sign_cnt
          ,le.populated_total_account_balance_cnt
          ,le.populated_combined_account_balance_sign_cnt
          ,le.populated_combined_account_balance_cnt
          ,le.populated_collection_count_cnt
          ,le.populated_atc021_cnt
          ,le.populated_atc022_cnt
          ,le.populated_atc023_cnt
          ,le.populated_atc024_cnt
          ,le.populated_atc025_cnt
          ,le.populated_last_activity_age_code_cnt
          ,le.populated_cottage_indicator_cnt
          ,le.populated_nonprofit_indicator_cnt
          ,le.populated_financial_stability_risk_score_cnt
          ,le.populated_fsr_risk_class_cnt
          ,le.populated_fsr_score_factor_1_cnt
          ,le.populated_fsr_score_factor_2_cnt
          ,le.populated_fsr_score_factor_3_cnt
          ,le.populated_fsr_score_factor_4_cnt
          ,le.populated_ip_score_change_sign_cnt
          ,le.populated_ip_score_change_cnt
          ,le.populated_fsr_score_change_sign_cnt
          ,le.populated_fsr_score_change_cnt
          ,le.populated_dba_name_cnt
          ,le.populated_clean_dba_name_cnt
          ,le.populated_clean_phone_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_fips_state_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_recent_update_desc_cnt
          ,le.populated_years_in_business_desc_cnt
          ,le.populated_address_type_desc_cnt
          ,le.populated_employee_size_desc_cnt
          ,le.populated_annual_sales_size_desc_cnt
          ,le.populated_location_desc_cnt
          ,le.populated_primary_sic_code_industry_class_desc_cnt
          ,le.populated_business_type_desc_cnt
          ,le.populated_ownership_code_desc_cnt
          ,le.populated_ucc_data_indicator_desc_cnt
          ,le.populated_experian_credit_rating_desc_cnt
          ,le.populated_last_activity_age_desc_cnt
          ,le.populated_cottage_indicator_desc_cnt
          ,le.populated_nonprofit_indicator_desc_cnt
          ,le.populated_company_name_cnt
          ,le.populated_p_title_cnt
          ,le.populated_p_fname_cnt
          ,le.populated_p_mname_cnt
          ,le.populated_p_lname_cnt
          ,le.populated_p_name_suffix_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_ace_aid_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_line_last_cnt
          ,le.populated_source_rec_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_bdid_score_pcnt
          ,le.populated_did_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_experian_bus_id_pcnt
          ,le.populated_business_name_pcnt
          ,le.populated_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_zip_plus_4_pcnt
          ,le.populated_carrier_route_pcnt
          ,le.populated_county_code_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_msa_code_pcnt
          ,le.populated_msa_description_pcnt
          ,le.populated_establish_date_pcnt
          ,le.populated_latest_reported_date_pcnt
          ,le.populated_years_in_file_pcnt
          ,le.populated_geo_code_latitude_pcnt
          ,le.populated_geo_code_latitude_direction_pcnt
          ,le.populated_geo_code_longitude_pcnt
          ,le.populated_geo_code_longitude_direction_pcnt
          ,le.populated_recent_update_code_pcnt
          ,le.populated_years_in_business_code_pcnt
          ,le.populated_year_business_started_pcnt
          ,le.populated_months_in_file_pcnt
          ,le.populated_address_type_code_pcnt
          ,le.populated_estimated_number_of_employees_pcnt
          ,le.populated_employee_size_code_pcnt
          ,le.populated_estimated_annual_sales_amount_sign_pcnt
          ,le.populated_estimated_annual_sales_amount_pcnt
          ,le.populated_annual_sales_size_code_pcnt
          ,le.populated_location_code_pcnt
          ,le.populated_primary_sic_code_industry_classification_pcnt
          ,le.populated_primary_sic_code_4_digit_pcnt
          ,le.populated_primary_sic_code_pcnt
          ,le.populated_second_sic_code_pcnt
          ,le.populated_third_sic_code_pcnt
          ,le.populated_fourth_sic_code_pcnt
          ,le.populated_fifth_sic_code_pcnt
          ,le.populated_sixth_sic_code_pcnt
          ,le.populated_primary_naics_code_pcnt
          ,le.populated_second_naics_code_pcnt
          ,le.populated_third_naics_code_pcnt
          ,le.populated_fourth_naics_code_pcnt
          ,le.populated_executive_count_pcnt
          ,le.populated_executive_last_name_pcnt
          ,le.populated_executive_first_name_pcnt
          ,le.populated_executive_middle_initial_pcnt
          ,le.populated_executive_title_pcnt
          ,le.populated_business_type_pcnt
          ,le.populated_ownership_code_pcnt
          ,le.populated_url_pcnt
          ,le.populated_derogatory_indicator_pcnt
          ,le.populated_recent_derogatory_filed_date_pcnt
          ,le.populated_derogatory_liability_amount_sign_pcnt
          ,le.populated_derogatory_liability_amount_pcnt
          ,le.populated_ucc_data_indicator_pcnt
          ,le.populated_ucc_count_pcnt
          ,le.populated_number_of_legal_items_pcnt
          ,le.populated_legal_balance_sign_pcnt
          ,le.populated_legal_balance_amount_pcnt
          ,le.populated_pmtkbankruptcy_pcnt
          ,le.populated_pmtkjudgment_pcnt
          ,le.populated_pmtktaxlien_pcnt
          ,le.populated_pmtkpayment_pcnt
          ,le.populated_bankruptcy_filed_pcnt
          ,le.populated_number_of_derogatory_legal_items_pcnt
          ,le.populated_lien_count_pcnt
          ,le.populated_judgment_count_pcnt
          ,le.populated_bkc006_pcnt
          ,le.populated_bkc007_pcnt
          ,le.populated_bkc008_pcnt
          ,le.populated_bko009_pcnt
          ,le.populated_bkb001_sign_pcnt
          ,le.populated_bkb001_pcnt
          ,le.populated_bkb003_sign_pcnt
          ,le.populated_bkb003_pcnt
          ,le.populated_bko010_pcnt
          ,le.populated_bko011_pcnt
          ,le.populated_jdc010_pcnt
          ,le.populated_jdc011_pcnt
          ,le.populated_jdc012_pcnt
          ,le.populated_jdb004_pcnt
          ,le.populated_jdb005_pcnt
          ,le.populated_jdb006_pcnt
          ,le.populated_jDO013_pcnt
          ,le.populated_jDO014_pcnt
          ,le.populated_jdb002_pcnt
          ,le.populated_jdp016_pcnt
          ,le.populated_lgc004_pcnt
          ,le.populated_pro001_pcnt
          ,le.populated_pro003_pcnt
          ,le.populated_txc010_pcnt
          ,le.populated_txc011_pcnt
          ,le.populated_txb004_sign_pcnt
          ,le.populated_txb004_pcnt
          ,le.populated_txo013_pcnt
          ,le.populated_txb002_sign_pcnt
          ,le.populated_txb002_pcnt
          ,le.populated_txp016_pcnt
          ,le.populated_ucc001_pcnt
          ,le.populated_ucc002_pcnt
          ,le.populated_ucc003_pcnt
          ,le.populated_intelliscore_plus_pcnt
          ,le.populated_percentile_model_pcnt
          ,le.populated_model_action_pcnt
          ,le.populated_score_factor_1_pcnt
          ,le.populated_score_factor_2_pcnt
          ,le.populated_score_factor_3_pcnt
          ,le.populated_score_factor_4_pcnt
          ,le.populated_model_code_pcnt
          ,le.populated_model_type_pcnt
          ,le.populated_last_experian_inquiry_date_pcnt
          ,le.populated_recent_high_credit_sign_pcnt
          ,le.populated_recent_high_credit_pcnt
          ,le.populated_median_credit_amount_sign_pcnt
          ,le.populated_median_credit_amount_pcnt
          ,le.populated_total_combined_trade_lines_count_pcnt
          ,le.populated_dbt_of_combined_trade_totals_pcnt
          ,le.populated_combined_trade_balance_pcnt
          ,le.populated_aged_trade_lines_pcnt
          ,le.populated_experian_credit_rating_pcnt
          ,le.populated_quarter_1_average_dbt_pcnt
          ,le.populated_quarter_2_average_dbt_pcnt
          ,le.populated_quarter_3_average_dbt_pcnt
          ,le.populated_quarter_4_average_dbt_pcnt
          ,le.populated_quarter_5_average_dbt_pcnt
          ,le.populated_combined_dbt_pcnt
          ,le.populated_total_account_balance_sign_pcnt
          ,le.populated_total_account_balance_pcnt
          ,le.populated_combined_account_balance_sign_pcnt
          ,le.populated_combined_account_balance_pcnt
          ,le.populated_collection_count_pcnt
          ,le.populated_atc021_pcnt
          ,le.populated_atc022_pcnt
          ,le.populated_atc023_pcnt
          ,le.populated_atc024_pcnt
          ,le.populated_atc025_pcnt
          ,le.populated_last_activity_age_code_pcnt
          ,le.populated_cottage_indicator_pcnt
          ,le.populated_nonprofit_indicator_pcnt
          ,le.populated_financial_stability_risk_score_pcnt
          ,le.populated_fsr_risk_class_pcnt
          ,le.populated_fsr_score_factor_1_pcnt
          ,le.populated_fsr_score_factor_2_pcnt
          ,le.populated_fsr_score_factor_3_pcnt
          ,le.populated_fsr_score_factor_4_pcnt
          ,le.populated_ip_score_change_sign_pcnt
          ,le.populated_ip_score_change_pcnt
          ,le.populated_fsr_score_change_sign_pcnt
          ,le.populated_fsr_score_change_pcnt
          ,le.populated_dba_name_pcnt
          ,le.populated_clean_dba_name_pcnt
          ,le.populated_clean_phone_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_fips_state_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_recent_update_desc_pcnt
          ,le.populated_years_in_business_desc_pcnt
          ,le.populated_address_type_desc_pcnt
          ,le.populated_employee_size_desc_pcnt
          ,le.populated_annual_sales_size_desc_pcnt
          ,le.populated_location_desc_pcnt
          ,le.populated_primary_sic_code_industry_class_desc_pcnt
          ,le.populated_business_type_desc_pcnt
          ,le.populated_ownership_code_desc_pcnt
          ,le.populated_ucc_data_indicator_desc_pcnt
          ,le.populated_experian_credit_rating_desc_pcnt
          ,le.populated_last_activity_age_desc_pcnt
          ,le.populated_cottage_indicator_desc_pcnt
          ,le.populated_nonprofit_indicator_desc_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_p_title_pcnt
          ,le.populated_p_fname_pcnt
          ,le.populated_p_mname_pcnt
          ,le.populated_p_lname_pcnt
          ,le.populated_p_name_suffix_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_ace_aid_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_line_last_pcnt
          ,le.populated_source_rec_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,233,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_Experian_CRDB));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),233,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_Experian_CRDB) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Experian_CRDB, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
