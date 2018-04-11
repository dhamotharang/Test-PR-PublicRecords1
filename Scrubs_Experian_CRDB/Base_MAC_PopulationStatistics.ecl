 
EXPORT Base_MAC_PopulationStatistics(infile,Ref='',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_seleid = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_bdid = '',Input_bdid_score = '',Input_did = '',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_experian_bus_id = '',Input_business_name = '',Input_address = '',Input_city = '',Input_state = '',Input_zip_code = '',Input_zip_plus_4 = '',Input_carrier_route = '',Input_county_code = '',Input_county_name = '',Input_phone_number = '',Input_msa_code = '',Input_msa_description = '',Input_establish_date = '',Input_latest_reported_date = '',Input_years_in_file = '',Input_geo_code_latitude = '',Input_geo_code_latitude_direction = '',Input_geo_code_longitude = '',Input_geo_code_longitude_direction = '',Input_recent_update_code = '',Input_years_in_business_code = '',Input_year_business_started = '',Input_months_in_file = '',Input_address_type_code = '',Input_estimated_number_of_employees = '',Input_employee_size_code = '',Input_estimated_annual_sales_amount_sign = '',Input_estimated_annual_sales_amount = '',Input_annual_sales_size_code = '',Input_location_code = '',Input_primary_sic_code_industry_classification = '',Input_primary_sic_code_4_digit = '',Input_primary_sic_code = '',Input_second_sic_code = '',Input_third_sic_code = '',Input_fourth_sic_code = '',Input_fifth_sic_code = '',Input_sixth_sic_code = '',Input_primary_naics_code = '',Input_second_naics_code = '',Input_third_naics_code = '',Input_fourth_naics_code = '',Input_executive_count = '',Input_executive_last_name = '',Input_executive_first_name = '',Input_executive_middle_initial = '',Input_executive_title = '',Input_business_type = '',Input_ownership_code = '',Input_url = '',Input_derogatory_indicator = '',Input_recent_derogatory_filed_date = '',Input_derogatory_liability_amount_sign = '',Input_derogatory_liability_amount = '',Input_ucc_data_indicator = '',Input_ucc_count = '',Input_number_of_legal_items = '',Input_legal_balance_sign = '',Input_legal_balance_amount = '',Input_pmtkbankruptcy = '',Input_pmtkjudgment = '',Input_pmtktaxlien = '',Input_pmtkpayment = '',Input_bankruptcy_filed = '',Input_number_of_derogatory_legal_items = '',Input_lien_count = '',Input_judgment_count = '',Input_bkc006 = '',Input_bkc007 = '',Input_bkc008 = '',Input_bko009 = '',Input_bkb001_sign = '',Input_bkb001 = '',Input_bkb003_sign = '',Input_bkb003 = '',Input_bko010 = '',Input_bko011 = '',Input_jdc010 = '',Input_jdc011 = '',Input_jdc012 = '',Input_jdb004 = '',Input_jdb005 = '',Input_jdb006 = '',Input_jDO013 = '',Input_jDO014 = '',Input_jdb002 = '',Input_jdp016 = '',Input_lgc004 = '',Input_pro001 = '',Input_pro003 = '',Input_txc010 = '',Input_txc011 = '',Input_txb004_sign = '',Input_txb004 = '',Input_txo013 = '',Input_txb002_sign = '',Input_txb002 = '',Input_txp016 = '',Input_ucc001 = '',Input_ucc002 = '',Input_ucc003 = '',Input_intelliscore_plus = '',Input_percentile_model = '',Input_model_action = '',Input_score_factor_1 = '',Input_score_factor_2 = '',Input_score_factor_3 = '',Input_score_factor_4 = '',Input_model_code = '',Input_model_type = '',Input_last_experian_inquiry_date = '',Input_recent_high_credit_sign = '',Input_recent_high_credit = '',Input_median_credit_amount_sign = '',Input_median_credit_amount = '',Input_total_combined_trade_lines_count = '',Input_dbt_of_combined_trade_totals = '',Input_combined_trade_balance = '',Input_aged_trade_lines = '',Input_experian_credit_rating = '',Input_quarter_1_average_dbt = '',Input_quarter_2_average_dbt = '',Input_quarter_3_average_dbt = '',Input_quarter_4_average_dbt = '',Input_quarter_5_average_dbt = '',Input_combined_dbt = '',Input_total_account_balance_sign = '',Input_total_account_balance = '',Input_combined_account_balance_sign = '',Input_combined_account_balance = '',Input_collection_count = '',Input_atc021 = '',Input_atc022 = '',Input_atc023 = '',Input_atc024 = '',Input_atc025 = '',Input_last_activity_age_code = '',Input_cottage_indicator = '',Input_nonprofit_indicator = '',Input_financial_stability_risk_score = '',Input_fsr_risk_class = '',Input_fsr_score_factor_1 = '',Input_fsr_score_factor_2 = '',Input_fsr_score_factor_3 = '',Input_fsr_score_factor_4 = '',Input_ip_score_change_sign = '',Input_ip_score_change = '',Input_fsr_score_change_sign = '',Input_fsr_score_change = '',Input_dba_name = '',Input_clean_dba_name = '',Input_clean_phone = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_recent_update_desc = '',Input_years_in_business_desc = '',Input_address_type_desc = '',Input_employee_size_desc = '',Input_annual_sales_size_desc = '',Input_location_desc = '',Input_primary_sic_code_industry_class_desc = '',Input_business_type_desc = '',Input_ownership_code_desc = '',Input_ucc_data_indicator_desc = '',Input_experian_credit_rating_desc = '',Input_last_activity_age_desc = '',Input_cottage_indicator_desc = '',Input_nonprofit_indicator_desc = '',Input_company_name = '',Input_p_title = '',Input_p_fname = '',Input_p_mname = '',Input_p_lname = '',Input_p_name_suffix = '',Input_raw_aid = '',Input_ace_aid = '',Input_prep_addr_line1 = '',Input_prep_addr_line_last = '',Input_source_rec_id = '',OutFile) := MACRO
  IMPORT SALT38,Scrubs_Experian_CRDB;
  #uniquename(of)
  %of% := RECORD
    SALT38.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dotid)='' )
      '' 
    #ELSE
        IF( le.Input_dotid = (TYPEOF(le.Input_dotid))'','',':dotid')
    #END
 
+    #IF( #TEXT(Input_dotscore)='' )
      '' 
    #ELSE
        IF( le.Input_dotscore = (TYPEOF(le.Input_dotscore))'','',':dotscore')
    #END
 
+    #IF( #TEXT(Input_dotweight)='' )
      '' 
    #ELSE
        IF( le.Input_dotweight = (TYPEOF(le.Input_dotweight))'','',':dotweight')
    #END
 
+    #IF( #TEXT(Input_empid)='' )
      '' 
    #ELSE
        IF( le.Input_empid = (TYPEOF(le.Input_empid))'','',':empid')
    #END
 
+    #IF( #TEXT(Input_empscore)='' )
      '' 
    #ELSE
        IF( le.Input_empscore = (TYPEOF(le.Input_empscore))'','',':empscore')
    #END
 
+    #IF( #TEXT(Input_empweight)='' )
      '' 
    #ELSE
        IF( le.Input_empweight = (TYPEOF(le.Input_empweight))'','',':empweight')
    #END
 
+    #IF( #TEXT(Input_powid)='' )
      '' 
    #ELSE
        IF( le.Input_powid = (TYPEOF(le.Input_powid))'','',':powid')
    #END
 
+    #IF( #TEXT(Input_powscore)='' )
      '' 
    #ELSE
        IF( le.Input_powscore = (TYPEOF(le.Input_powscore))'','',':powscore')
    #END
 
+    #IF( #TEXT(Input_powweight)='' )
      '' 
    #ELSE
        IF( le.Input_powweight = (TYPEOF(le.Input_powweight))'','',':powweight')
    #END
 
+    #IF( #TEXT(Input_proxid)='' )
      '' 
    #ELSE
        IF( le.Input_proxid = (TYPEOF(le.Input_proxid))'','',':proxid')
    #END
 
+    #IF( #TEXT(Input_proxscore)='' )
      '' 
    #ELSE
        IF( le.Input_proxscore = (TYPEOF(le.Input_proxscore))'','',':proxscore')
    #END
 
+    #IF( #TEXT(Input_proxweight)='' )
      '' 
    #ELSE
        IF( le.Input_proxweight = (TYPEOF(le.Input_proxweight))'','',':proxweight')
    #END
 
+    #IF( #TEXT(Input_seleid)='' )
      '' 
    #ELSE
        IF( le.Input_seleid = (TYPEOF(le.Input_seleid))'','',':seleid')
    #END
 
+    #IF( #TEXT(Input_selescore)='' )
      '' 
    #ELSE
        IF( le.Input_selescore = (TYPEOF(le.Input_selescore))'','',':selescore')
    #END
 
+    #IF( #TEXT(Input_seleweight)='' )
      '' 
    #ELSE
        IF( le.Input_seleweight = (TYPEOF(le.Input_seleweight))'','',':seleweight')
    #END
 
+    #IF( #TEXT(Input_orgid)='' )
      '' 
    #ELSE
        IF( le.Input_orgid = (TYPEOF(le.Input_orgid))'','',':orgid')
    #END
 
+    #IF( #TEXT(Input_orgscore)='' )
      '' 
    #ELSE
        IF( le.Input_orgscore = (TYPEOF(le.Input_orgscore))'','',':orgscore')
    #END
 
+    #IF( #TEXT(Input_orgweight)='' )
      '' 
    #ELSE
        IF( le.Input_orgweight = (TYPEOF(le.Input_orgweight))'','',':orgweight')
    #END
 
+    #IF( #TEXT(Input_ultid)='' )
      '' 
    #ELSE
        IF( le.Input_ultid = (TYPEOF(le.Input_ultid))'','',':ultid')
    #END
 
+    #IF( #TEXT(Input_ultscore)='' )
      '' 
    #ELSE
        IF( le.Input_ultscore = (TYPEOF(le.Input_ultscore))'','',':ultscore')
    #END
 
+    #IF( #TEXT(Input_ultweight)='' )
      '' 
    #ELSE
        IF( le.Input_ultweight = (TYPEOF(le.Input_ultweight))'','',':ultweight')
    #END
 
+    #IF( #TEXT(Input_bdid)='' )
      '' 
    #ELSE
        IF( le.Input_bdid = (TYPEOF(le.Input_bdid))'','',':bdid')
    #END
 
+    #IF( #TEXT(Input_bdid_score)='' )
      '' 
    #ELSE
        IF( le.Input_bdid_score = (TYPEOF(le.Input_bdid_score))'','',':bdid_score')
    #END
 
+    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
 
+    #IF( #TEXT(Input_dt_first_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_first_seen = (TYPEOF(le.Input_dt_first_seen))'','',':dt_first_seen')
    #END
 
+    #IF( #TEXT(Input_dt_last_seen)='' )
      '' 
    #ELSE
        IF( le.Input_dt_last_seen = (TYPEOF(le.Input_dt_last_seen))'','',':dt_last_seen')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_first_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_first_reported = (TYPEOF(le.Input_dt_vendor_first_reported))'','',':dt_vendor_first_reported')
    #END
 
+    #IF( #TEXT(Input_dt_vendor_last_reported)='' )
      '' 
    #ELSE
        IF( le.Input_dt_vendor_last_reported = (TYPEOF(le.Input_dt_vendor_last_reported))'','',':dt_vendor_last_reported')
    #END
 
+    #IF( #TEXT(Input_experian_bus_id)='' )
      '' 
    #ELSE
        IF( le.Input_experian_bus_id = (TYPEOF(le.Input_experian_bus_id))'','',':experian_bus_id')
    #END
 
+    #IF( #TEXT(Input_business_name)='' )
      '' 
    #ELSE
        IF( le.Input_business_name = (TYPEOF(le.Input_business_name))'','',':business_name')
    #END
 
+    #IF( #TEXT(Input_address)='' )
      '' 
    #ELSE
        IF( le.Input_address = (TYPEOF(le.Input_address))'','',':address')
    #END
 
+    #IF( #TEXT(Input_city)='' )
      '' 
    #ELSE
        IF( le.Input_city = (TYPEOF(le.Input_city))'','',':city')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
 
+    #IF( #TEXT(Input_zip_plus_4)='' )
      '' 
    #ELSE
        IF( le.Input_zip_plus_4 = (TYPEOF(le.Input_zip_plus_4))'','',':zip_plus_4')
    #END
 
+    #IF( #TEXT(Input_carrier_route)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_route = (TYPEOF(le.Input_carrier_route))'','',':carrier_route')
    #END
 
+    #IF( #TEXT(Input_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_county_code = (TYPEOF(le.Input_county_code))'','',':county_code')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
 
+    #IF( #TEXT(Input_msa_code)='' )
      '' 
    #ELSE
        IF( le.Input_msa_code = (TYPEOF(le.Input_msa_code))'','',':msa_code')
    #END
 
+    #IF( #TEXT(Input_msa_description)='' )
      '' 
    #ELSE
        IF( le.Input_msa_description = (TYPEOF(le.Input_msa_description))'','',':msa_description')
    #END
 
+    #IF( #TEXT(Input_establish_date)='' )
      '' 
    #ELSE
        IF( le.Input_establish_date = (TYPEOF(le.Input_establish_date))'','',':establish_date')
    #END
 
+    #IF( #TEXT(Input_latest_reported_date)='' )
      '' 
    #ELSE
        IF( le.Input_latest_reported_date = (TYPEOF(le.Input_latest_reported_date))'','',':latest_reported_date')
    #END
 
+    #IF( #TEXT(Input_years_in_file)='' )
      '' 
    #ELSE
        IF( le.Input_years_in_file = (TYPEOF(le.Input_years_in_file))'','',':years_in_file')
    #END
 
+    #IF( #TEXT(Input_geo_code_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_geo_code_latitude = (TYPEOF(le.Input_geo_code_latitude))'','',':geo_code_latitude')
    #END
 
+    #IF( #TEXT(Input_geo_code_latitude_direction)='' )
      '' 
    #ELSE
        IF( le.Input_geo_code_latitude_direction = (TYPEOF(le.Input_geo_code_latitude_direction))'','',':geo_code_latitude_direction')
    #END
 
+    #IF( #TEXT(Input_geo_code_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_geo_code_longitude = (TYPEOF(le.Input_geo_code_longitude))'','',':geo_code_longitude')
    #END
 
+    #IF( #TEXT(Input_geo_code_longitude_direction)='' )
      '' 
    #ELSE
        IF( le.Input_geo_code_longitude_direction = (TYPEOF(le.Input_geo_code_longitude_direction))'','',':geo_code_longitude_direction')
    #END
 
+    #IF( #TEXT(Input_recent_update_code)='' )
      '' 
    #ELSE
        IF( le.Input_recent_update_code = (TYPEOF(le.Input_recent_update_code))'','',':recent_update_code')
    #END
 
+    #IF( #TEXT(Input_years_in_business_code)='' )
      '' 
    #ELSE
        IF( le.Input_years_in_business_code = (TYPEOF(le.Input_years_in_business_code))'','',':years_in_business_code')
    #END
 
+    #IF( #TEXT(Input_year_business_started)='' )
      '' 
    #ELSE
        IF( le.Input_year_business_started = (TYPEOF(le.Input_year_business_started))'','',':year_business_started')
    #END
 
+    #IF( #TEXT(Input_months_in_file)='' )
      '' 
    #ELSE
        IF( le.Input_months_in_file = (TYPEOF(le.Input_months_in_file))'','',':months_in_file')
    #END
 
+    #IF( #TEXT(Input_address_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_address_type_code = (TYPEOF(le.Input_address_type_code))'','',':address_type_code')
    #END
 
+    #IF( #TEXT(Input_estimated_number_of_employees)='' )
      '' 
    #ELSE
        IF( le.Input_estimated_number_of_employees = (TYPEOF(le.Input_estimated_number_of_employees))'','',':estimated_number_of_employees')
    #END
 
+    #IF( #TEXT(Input_employee_size_code)='' )
      '' 
    #ELSE
        IF( le.Input_employee_size_code = (TYPEOF(le.Input_employee_size_code))'','',':employee_size_code')
    #END
 
+    #IF( #TEXT(Input_estimated_annual_sales_amount_sign)='' )
      '' 
    #ELSE
        IF( le.Input_estimated_annual_sales_amount_sign = (TYPEOF(le.Input_estimated_annual_sales_amount_sign))'','',':estimated_annual_sales_amount_sign')
    #END
 
+    #IF( #TEXT(Input_estimated_annual_sales_amount)='' )
      '' 
    #ELSE
        IF( le.Input_estimated_annual_sales_amount = (TYPEOF(le.Input_estimated_annual_sales_amount))'','',':estimated_annual_sales_amount')
    #END
 
+    #IF( #TEXT(Input_annual_sales_size_code)='' )
      '' 
    #ELSE
        IF( le.Input_annual_sales_size_code = (TYPEOF(le.Input_annual_sales_size_code))'','',':annual_sales_size_code')
    #END
 
+    #IF( #TEXT(Input_location_code)='' )
      '' 
    #ELSE
        IF( le.Input_location_code = (TYPEOF(le.Input_location_code))'','',':location_code')
    #END
 
+    #IF( #TEXT(Input_primary_sic_code_industry_classification)='' )
      '' 
    #ELSE
        IF( le.Input_primary_sic_code_industry_classification = (TYPEOF(le.Input_primary_sic_code_industry_classification))'','',':primary_sic_code_industry_classification')
    #END
 
+    #IF( #TEXT(Input_primary_sic_code_4_digit)='' )
      '' 
    #ELSE
        IF( le.Input_primary_sic_code_4_digit = (TYPEOF(le.Input_primary_sic_code_4_digit))'','',':primary_sic_code_4_digit')
    #END
 
+    #IF( #TEXT(Input_primary_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_primary_sic_code = (TYPEOF(le.Input_primary_sic_code))'','',':primary_sic_code')
    #END
 
+    #IF( #TEXT(Input_second_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_second_sic_code = (TYPEOF(le.Input_second_sic_code))'','',':second_sic_code')
    #END
 
+    #IF( #TEXT(Input_third_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_third_sic_code = (TYPEOF(le.Input_third_sic_code))'','',':third_sic_code')
    #END
 
+    #IF( #TEXT(Input_fourth_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_fourth_sic_code = (TYPEOF(le.Input_fourth_sic_code))'','',':fourth_sic_code')
    #END
 
+    #IF( #TEXT(Input_fifth_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_fifth_sic_code = (TYPEOF(le.Input_fifth_sic_code))'','',':fifth_sic_code')
    #END
 
+    #IF( #TEXT(Input_sixth_sic_code)='' )
      '' 
    #ELSE
        IF( le.Input_sixth_sic_code = (TYPEOF(le.Input_sixth_sic_code))'','',':sixth_sic_code')
    #END
 
+    #IF( #TEXT(Input_primary_naics_code)='' )
      '' 
    #ELSE
        IF( le.Input_primary_naics_code = (TYPEOF(le.Input_primary_naics_code))'','',':primary_naics_code')
    #END
 
+    #IF( #TEXT(Input_second_naics_code)='' )
      '' 
    #ELSE
        IF( le.Input_second_naics_code = (TYPEOF(le.Input_second_naics_code))'','',':second_naics_code')
    #END
 
+    #IF( #TEXT(Input_third_naics_code)='' )
      '' 
    #ELSE
        IF( le.Input_third_naics_code = (TYPEOF(le.Input_third_naics_code))'','',':third_naics_code')
    #END
 
+    #IF( #TEXT(Input_fourth_naics_code)='' )
      '' 
    #ELSE
        IF( le.Input_fourth_naics_code = (TYPEOF(le.Input_fourth_naics_code))'','',':fourth_naics_code')
    #END
 
+    #IF( #TEXT(Input_executive_count)='' )
      '' 
    #ELSE
        IF( le.Input_executive_count = (TYPEOF(le.Input_executive_count))'','',':executive_count')
    #END
 
+    #IF( #TEXT(Input_executive_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_executive_last_name = (TYPEOF(le.Input_executive_last_name))'','',':executive_last_name')
    #END
 
+    #IF( #TEXT(Input_executive_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_executive_first_name = (TYPEOF(le.Input_executive_first_name))'','',':executive_first_name')
    #END
 
+    #IF( #TEXT(Input_executive_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_executive_middle_initial = (TYPEOF(le.Input_executive_middle_initial))'','',':executive_middle_initial')
    #END
 
+    #IF( #TEXT(Input_executive_title)='' )
      '' 
    #ELSE
        IF( le.Input_executive_title = (TYPEOF(le.Input_executive_title))'','',':executive_title')
    #END
 
+    #IF( #TEXT(Input_business_type)='' )
      '' 
    #ELSE
        IF( le.Input_business_type = (TYPEOF(le.Input_business_type))'','',':business_type')
    #END
 
+    #IF( #TEXT(Input_ownership_code)='' )
      '' 
    #ELSE
        IF( le.Input_ownership_code = (TYPEOF(le.Input_ownership_code))'','',':ownership_code')
    #END
 
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
 
+    #IF( #TEXT(Input_derogatory_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_derogatory_indicator = (TYPEOF(le.Input_derogatory_indicator))'','',':derogatory_indicator')
    #END
 
+    #IF( #TEXT(Input_recent_derogatory_filed_date)='' )
      '' 
    #ELSE
        IF( le.Input_recent_derogatory_filed_date = (TYPEOF(le.Input_recent_derogatory_filed_date))'','',':recent_derogatory_filed_date')
    #END
 
+    #IF( #TEXT(Input_derogatory_liability_amount_sign)='' )
      '' 
    #ELSE
        IF( le.Input_derogatory_liability_amount_sign = (TYPEOF(le.Input_derogatory_liability_amount_sign))'','',':derogatory_liability_amount_sign')
    #END
 
+    #IF( #TEXT(Input_derogatory_liability_amount)='' )
      '' 
    #ELSE
        IF( le.Input_derogatory_liability_amount = (TYPEOF(le.Input_derogatory_liability_amount))'','',':derogatory_liability_amount')
    #END
 
+    #IF( #TEXT(Input_ucc_data_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_ucc_data_indicator = (TYPEOF(le.Input_ucc_data_indicator))'','',':ucc_data_indicator')
    #END
 
+    #IF( #TEXT(Input_ucc_count)='' )
      '' 
    #ELSE
        IF( le.Input_ucc_count = (TYPEOF(le.Input_ucc_count))'','',':ucc_count')
    #END
 
+    #IF( #TEXT(Input_number_of_legal_items)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_legal_items = (TYPEOF(le.Input_number_of_legal_items))'','',':number_of_legal_items')
    #END
 
+    #IF( #TEXT(Input_legal_balance_sign)='' )
      '' 
    #ELSE
        IF( le.Input_legal_balance_sign = (TYPEOF(le.Input_legal_balance_sign))'','',':legal_balance_sign')
    #END
 
+    #IF( #TEXT(Input_legal_balance_amount)='' )
      '' 
    #ELSE
        IF( le.Input_legal_balance_amount = (TYPEOF(le.Input_legal_balance_amount))'','',':legal_balance_amount')
    #END
 
+    #IF( #TEXT(Input_pmtkbankruptcy)='' )
      '' 
    #ELSE
        IF( le.Input_pmtkbankruptcy = (TYPEOF(le.Input_pmtkbankruptcy))'','',':pmtkbankruptcy')
    #END
 
+    #IF( #TEXT(Input_pmtkjudgment)='' )
      '' 
    #ELSE
        IF( le.Input_pmtkjudgment = (TYPEOF(le.Input_pmtkjudgment))'','',':pmtkjudgment')
    #END
 
+    #IF( #TEXT(Input_pmtktaxlien)='' )
      '' 
    #ELSE
        IF( le.Input_pmtktaxlien = (TYPEOF(le.Input_pmtktaxlien))'','',':pmtktaxlien')
    #END
 
+    #IF( #TEXT(Input_pmtkpayment)='' )
      '' 
    #ELSE
        IF( le.Input_pmtkpayment = (TYPEOF(le.Input_pmtkpayment))'','',':pmtkpayment')
    #END
 
+    #IF( #TEXT(Input_bankruptcy_filed)='' )
      '' 
    #ELSE
        IF( le.Input_bankruptcy_filed = (TYPEOF(le.Input_bankruptcy_filed))'','',':bankruptcy_filed')
    #END
 
+    #IF( #TEXT(Input_number_of_derogatory_legal_items)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_derogatory_legal_items = (TYPEOF(le.Input_number_of_derogatory_legal_items))'','',':number_of_derogatory_legal_items')
    #END
 
+    #IF( #TEXT(Input_lien_count)='' )
      '' 
    #ELSE
        IF( le.Input_lien_count = (TYPEOF(le.Input_lien_count))'','',':lien_count')
    #END
 
+    #IF( #TEXT(Input_judgment_count)='' )
      '' 
    #ELSE
        IF( le.Input_judgment_count = (TYPEOF(le.Input_judgment_count))'','',':judgment_count')
    #END
 
+    #IF( #TEXT(Input_bkc006)='' )
      '' 
    #ELSE
        IF( le.Input_bkc006 = (TYPEOF(le.Input_bkc006))'','',':bkc006')
    #END
 
+    #IF( #TEXT(Input_bkc007)='' )
      '' 
    #ELSE
        IF( le.Input_bkc007 = (TYPEOF(le.Input_bkc007))'','',':bkc007')
    #END
 
+    #IF( #TEXT(Input_bkc008)='' )
      '' 
    #ELSE
        IF( le.Input_bkc008 = (TYPEOF(le.Input_bkc008))'','',':bkc008')
    #END
 
+    #IF( #TEXT(Input_bko009)='' )
      '' 
    #ELSE
        IF( le.Input_bko009 = (TYPEOF(le.Input_bko009))'','',':bko009')
    #END
 
+    #IF( #TEXT(Input_bkb001_sign)='' )
      '' 
    #ELSE
        IF( le.Input_bkb001_sign = (TYPEOF(le.Input_bkb001_sign))'','',':bkb001_sign')
    #END
 
+    #IF( #TEXT(Input_bkb001)='' )
      '' 
    #ELSE
        IF( le.Input_bkb001 = (TYPEOF(le.Input_bkb001))'','',':bkb001')
    #END
 
+    #IF( #TEXT(Input_bkb003_sign)='' )
      '' 
    #ELSE
        IF( le.Input_bkb003_sign = (TYPEOF(le.Input_bkb003_sign))'','',':bkb003_sign')
    #END
 
+    #IF( #TEXT(Input_bkb003)='' )
      '' 
    #ELSE
        IF( le.Input_bkb003 = (TYPEOF(le.Input_bkb003))'','',':bkb003')
    #END
 
+    #IF( #TEXT(Input_bko010)='' )
      '' 
    #ELSE
        IF( le.Input_bko010 = (TYPEOF(le.Input_bko010))'','',':bko010')
    #END
 
+    #IF( #TEXT(Input_bko011)='' )
      '' 
    #ELSE
        IF( le.Input_bko011 = (TYPEOF(le.Input_bko011))'','',':bko011')
    #END
 
+    #IF( #TEXT(Input_jdc010)='' )
      '' 
    #ELSE
        IF( le.Input_jdc010 = (TYPEOF(le.Input_jdc010))'','',':jdc010')
    #END
 
+    #IF( #TEXT(Input_jdc011)='' )
      '' 
    #ELSE
        IF( le.Input_jdc011 = (TYPEOF(le.Input_jdc011))'','',':jdc011')
    #END
 
+    #IF( #TEXT(Input_jdc012)='' )
      '' 
    #ELSE
        IF( le.Input_jdc012 = (TYPEOF(le.Input_jdc012))'','',':jdc012')
    #END
 
+    #IF( #TEXT(Input_jdb004)='' )
      '' 
    #ELSE
        IF( le.Input_jdb004 = (TYPEOF(le.Input_jdb004))'','',':jdb004')
    #END
 
+    #IF( #TEXT(Input_jdb005)='' )
      '' 
    #ELSE
        IF( le.Input_jdb005 = (TYPEOF(le.Input_jdb005))'','',':jdb005')
    #END
 
+    #IF( #TEXT(Input_jdb006)='' )
      '' 
    #ELSE
        IF( le.Input_jdb006 = (TYPEOF(le.Input_jdb006))'','',':jdb006')
    #END
 
+    #IF( #TEXT(Input_jDO013)='' )
      '' 
    #ELSE
        IF( le.Input_jDO013 = (TYPEOF(le.Input_jDO013))'','',':jDO013')
    #END
 
+    #IF( #TEXT(Input_jDO014)='' )
      '' 
    #ELSE
        IF( le.Input_jDO014 = (TYPEOF(le.Input_jDO014))'','',':jDO014')
    #END
 
+    #IF( #TEXT(Input_jdb002)='' )
      '' 
    #ELSE
        IF( le.Input_jdb002 = (TYPEOF(le.Input_jdb002))'','',':jdb002')
    #END
 
+    #IF( #TEXT(Input_jdp016)='' )
      '' 
    #ELSE
        IF( le.Input_jdp016 = (TYPEOF(le.Input_jdp016))'','',':jdp016')
    #END
 
+    #IF( #TEXT(Input_lgc004)='' )
      '' 
    #ELSE
        IF( le.Input_lgc004 = (TYPEOF(le.Input_lgc004))'','',':lgc004')
    #END
 
+    #IF( #TEXT(Input_pro001)='' )
      '' 
    #ELSE
        IF( le.Input_pro001 = (TYPEOF(le.Input_pro001))'','',':pro001')
    #END
 
+    #IF( #TEXT(Input_pro003)='' )
      '' 
    #ELSE
        IF( le.Input_pro003 = (TYPEOF(le.Input_pro003))'','',':pro003')
    #END
 
+    #IF( #TEXT(Input_txc010)='' )
      '' 
    #ELSE
        IF( le.Input_txc010 = (TYPEOF(le.Input_txc010))'','',':txc010')
    #END
 
+    #IF( #TEXT(Input_txc011)='' )
      '' 
    #ELSE
        IF( le.Input_txc011 = (TYPEOF(le.Input_txc011))'','',':txc011')
    #END
 
+    #IF( #TEXT(Input_txb004_sign)='' )
      '' 
    #ELSE
        IF( le.Input_txb004_sign = (TYPEOF(le.Input_txb004_sign))'','',':txb004_sign')
    #END
 
+    #IF( #TEXT(Input_txb004)='' )
      '' 
    #ELSE
        IF( le.Input_txb004 = (TYPEOF(le.Input_txb004))'','',':txb004')
    #END
 
+    #IF( #TEXT(Input_txo013)='' )
      '' 
    #ELSE
        IF( le.Input_txo013 = (TYPEOF(le.Input_txo013))'','',':txo013')
    #END
 
+    #IF( #TEXT(Input_txb002_sign)='' )
      '' 
    #ELSE
        IF( le.Input_txb002_sign = (TYPEOF(le.Input_txb002_sign))'','',':txb002_sign')
    #END
 
+    #IF( #TEXT(Input_txb002)='' )
      '' 
    #ELSE
        IF( le.Input_txb002 = (TYPEOF(le.Input_txb002))'','',':txb002')
    #END
 
+    #IF( #TEXT(Input_txp016)='' )
      '' 
    #ELSE
        IF( le.Input_txp016 = (TYPEOF(le.Input_txp016))'','',':txp016')
    #END
 
+    #IF( #TEXT(Input_ucc001)='' )
      '' 
    #ELSE
        IF( le.Input_ucc001 = (TYPEOF(le.Input_ucc001))'','',':ucc001')
    #END
 
+    #IF( #TEXT(Input_ucc002)='' )
      '' 
    #ELSE
        IF( le.Input_ucc002 = (TYPEOF(le.Input_ucc002))'','',':ucc002')
    #END
 
+    #IF( #TEXT(Input_ucc003)='' )
      '' 
    #ELSE
        IF( le.Input_ucc003 = (TYPEOF(le.Input_ucc003))'','',':ucc003')
    #END
 
+    #IF( #TEXT(Input_intelliscore_plus)='' )
      '' 
    #ELSE
        IF( le.Input_intelliscore_plus = (TYPEOF(le.Input_intelliscore_plus))'','',':intelliscore_plus')
    #END
 
+    #IF( #TEXT(Input_percentile_model)='' )
      '' 
    #ELSE
        IF( le.Input_percentile_model = (TYPEOF(le.Input_percentile_model))'','',':percentile_model')
    #END
 
+    #IF( #TEXT(Input_model_action)='' )
      '' 
    #ELSE
        IF( le.Input_model_action = (TYPEOF(le.Input_model_action))'','',':model_action')
    #END
 
+    #IF( #TEXT(Input_score_factor_1)='' )
      '' 
    #ELSE
        IF( le.Input_score_factor_1 = (TYPEOF(le.Input_score_factor_1))'','',':score_factor_1')
    #END
 
+    #IF( #TEXT(Input_score_factor_2)='' )
      '' 
    #ELSE
        IF( le.Input_score_factor_2 = (TYPEOF(le.Input_score_factor_2))'','',':score_factor_2')
    #END
 
+    #IF( #TEXT(Input_score_factor_3)='' )
      '' 
    #ELSE
        IF( le.Input_score_factor_3 = (TYPEOF(le.Input_score_factor_3))'','',':score_factor_3')
    #END
 
+    #IF( #TEXT(Input_score_factor_4)='' )
      '' 
    #ELSE
        IF( le.Input_score_factor_4 = (TYPEOF(le.Input_score_factor_4))'','',':score_factor_4')
    #END
 
+    #IF( #TEXT(Input_model_code)='' )
      '' 
    #ELSE
        IF( le.Input_model_code = (TYPEOF(le.Input_model_code))'','',':model_code')
    #END
 
+    #IF( #TEXT(Input_model_type)='' )
      '' 
    #ELSE
        IF( le.Input_model_type = (TYPEOF(le.Input_model_type))'','',':model_type')
    #END
 
+    #IF( #TEXT(Input_last_experian_inquiry_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_experian_inquiry_date = (TYPEOF(le.Input_last_experian_inquiry_date))'','',':last_experian_inquiry_date')
    #END
 
+    #IF( #TEXT(Input_recent_high_credit_sign)='' )
      '' 
    #ELSE
        IF( le.Input_recent_high_credit_sign = (TYPEOF(le.Input_recent_high_credit_sign))'','',':recent_high_credit_sign')
    #END
 
+    #IF( #TEXT(Input_recent_high_credit)='' )
      '' 
    #ELSE
        IF( le.Input_recent_high_credit = (TYPEOF(le.Input_recent_high_credit))'','',':recent_high_credit')
    #END
 
+    #IF( #TEXT(Input_median_credit_amount_sign)='' )
      '' 
    #ELSE
        IF( le.Input_median_credit_amount_sign = (TYPEOF(le.Input_median_credit_amount_sign))'','',':median_credit_amount_sign')
    #END
 
+    #IF( #TEXT(Input_median_credit_amount)='' )
      '' 
    #ELSE
        IF( le.Input_median_credit_amount = (TYPEOF(le.Input_median_credit_amount))'','',':median_credit_amount')
    #END
 
+    #IF( #TEXT(Input_total_combined_trade_lines_count)='' )
      '' 
    #ELSE
        IF( le.Input_total_combined_trade_lines_count = (TYPEOF(le.Input_total_combined_trade_lines_count))'','',':total_combined_trade_lines_count')
    #END
 
+    #IF( #TEXT(Input_dbt_of_combined_trade_totals)='' )
      '' 
    #ELSE
        IF( le.Input_dbt_of_combined_trade_totals = (TYPEOF(le.Input_dbt_of_combined_trade_totals))'','',':dbt_of_combined_trade_totals')
    #END
 
+    #IF( #TEXT(Input_combined_trade_balance)='' )
      '' 
    #ELSE
        IF( le.Input_combined_trade_balance = (TYPEOF(le.Input_combined_trade_balance))'','',':combined_trade_balance')
    #END
 
+    #IF( #TEXT(Input_aged_trade_lines)='' )
      '' 
    #ELSE
        IF( le.Input_aged_trade_lines = (TYPEOF(le.Input_aged_trade_lines))'','',':aged_trade_lines')
    #END
 
+    #IF( #TEXT(Input_experian_credit_rating)='' )
      '' 
    #ELSE
        IF( le.Input_experian_credit_rating = (TYPEOF(le.Input_experian_credit_rating))'','',':experian_credit_rating')
    #END
 
+    #IF( #TEXT(Input_quarter_1_average_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_quarter_1_average_dbt = (TYPEOF(le.Input_quarter_1_average_dbt))'','',':quarter_1_average_dbt')
    #END
 
+    #IF( #TEXT(Input_quarter_2_average_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_quarter_2_average_dbt = (TYPEOF(le.Input_quarter_2_average_dbt))'','',':quarter_2_average_dbt')
    #END
 
+    #IF( #TEXT(Input_quarter_3_average_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_quarter_3_average_dbt = (TYPEOF(le.Input_quarter_3_average_dbt))'','',':quarter_3_average_dbt')
    #END
 
+    #IF( #TEXT(Input_quarter_4_average_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_quarter_4_average_dbt = (TYPEOF(le.Input_quarter_4_average_dbt))'','',':quarter_4_average_dbt')
    #END
 
+    #IF( #TEXT(Input_quarter_5_average_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_quarter_5_average_dbt = (TYPEOF(le.Input_quarter_5_average_dbt))'','',':quarter_5_average_dbt')
    #END
 
+    #IF( #TEXT(Input_combined_dbt)='' )
      '' 
    #ELSE
        IF( le.Input_combined_dbt = (TYPEOF(le.Input_combined_dbt))'','',':combined_dbt')
    #END
 
+    #IF( #TEXT(Input_total_account_balance_sign)='' )
      '' 
    #ELSE
        IF( le.Input_total_account_balance_sign = (TYPEOF(le.Input_total_account_balance_sign))'','',':total_account_balance_sign')
    #END
 
+    #IF( #TEXT(Input_total_account_balance)='' )
      '' 
    #ELSE
        IF( le.Input_total_account_balance = (TYPEOF(le.Input_total_account_balance))'','',':total_account_balance')
    #END
 
+    #IF( #TEXT(Input_combined_account_balance_sign)='' )
      '' 
    #ELSE
        IF( le.Input_combined_account_balance_sign = (TYPEOF(le.Input_combined_account_balance_sign))'','',':combined_account_balance_sign')
    #END
 
+    #IF( #TEXT(Input_combined_account_balance)='' )
      '' 
    #ELSE
        IF( le.Input_combined_account_balance = (TYPEOF(le.Input_combined_account_balance))'','',':combined_account_balance')
    #END
 
+    #IF( #TEXT(Input_collection_count)='' )
      '' 
    #ELSE
        IF( le.Input_collection_count = (TYPEOF(le.Input_collection_count))'','',':collection_count')
    #END
 
+    #IF( #TEXT(Input_atc021)='' )
      '' 
    #ELSE
        IF( le.Input_atc021 = (TYPEOF(le.Input_atc021))'','',':atc021')
    #END
 
+    #IF( #TEXT(Input_atc022)='' )
      '' 
    #ELSE
        IF( le.Input_atc022 = (TYPEOF(le.Input_atc022))'','',':atc022')
    #END
 
+    #IF( #TEXT(Input_atc023)='' )
      '' 
    #ELSE
        IF( le.Input_atc023 = (TYPEOF(le.Input_atc023))'','',':atc023')
    #END
 
+    #IF( #TEXT(Input_atc024)='' )
      '' 
    #ELSE
        IF( le.Input_atc024 = (TYPEOF(le.Input_atc024))'','',':atc024')
    #END
 
+    #IF( #TEXT(Input_atc025)='' )
      '' 
    #ELSE
        IF( le.Input_atc025 = (TYPEOF(le.Input_atc025))'','',':atc025')
    #END
 
+    #IF( #TEXT(Input_last_activity_age_code)='' )
      '' 
    #ELSE
        IF( le.Input_last_activity_age_code = (TYPEOF(le.Input_last_activity_age_code))'','',':last_activity_age_code')
    #END
 
+    #IF( #TEXT(Input_cottage_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_cottage_indicator = (TYPEOF(le.Input_cottage_indicator))'','',':cottage_indicator')
    #END
 
+    #IF( #TEXT(Input_nonprofit_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_nonprofit_indicator = (TYPEOF(le.Input_nonprofit_indicator))'','',':nonprofit_indicator')
    #END
 
+    #IF( #TEXT(Input_financial_stability_risk_score)='' )
      '' 
    #ELSE
        IF( le.Input_financial_stability_risk_score = (TYPEOF(le.Input_financial_stability_risk_score))'','',':financial_stability_risk_score')
    #END
 
+    #IF( #TEXT(Input_fsr_risk_class)='' )
      '' 
    #ELSE
        IF( le.Input_fsr_risk_class = (TYPEOF(le.Input_fsr_risk_class))'','',':fsr_risk_class')
    #END
 
+    #IF( #TEXT(Input_fsr_score_factor_1)='' )
      '' 
    #ELSE
        IF( le.Input_fsr_score_factor_1 = (TYPEOF(le.Input_fsr_score_factor_1))'','',':fsr_score_factor_1')
    #END
 
+    #IF( #TEXT(Input_fsr_score_factor_2)='' )
      '' 
    #ELSE
        IF( le.Input_fsr_score_factor_2 = (TYPEOF(le.Input_fsr_score_factor_2))'','',':fsr_score_factor_2')
    #END
 
+    #IF( #TEXT(Input_fsr_score_factor_3)='' )
      '' 
    #ELSE
        IF( le.Input_fsr_score_factor_3 = (TYPEOF(le.Input_fsr_score_factor_3))'','',':fsr_score_factor_3')
    #END
 
+    #IF( #TEXT(Input_fsr_score_factor_4)='' )
      '' 
    #ELSE
        IF( le.Input_fsr_score_factor_4 = (TYPEOF(le.Input_fsr_score_factor_4))'','',':fsr_score_factor_4')
    #END
 
+    #IF( #TEXT(Input_ip_score_change_sign)='' )
      '' 
    #ELSE
        IF( le.Input_ip_score_change_sign = (TYPEOF(le.Input_ip_score_change_sign))'','',':ip_score_change_sign')
    #END
 
+    #IF( #TEXT(Input_ip_score_change)='' )
      '' 
    #ELSE
        IF( le.Input_ip_score_change = (TYPEOF(le.Input_ip_score_change))'','',':ip_score_change')
    #END
 
+    #IF( #TEXT(Input_fsr_score_change_sign)='' )
      '' 
    #ELSE
        IF( le.Input_fsr_score_change_sign = (TYPEOF(le.Input_fsr_score_change_sign))'','',':fsr_score_change_sign')
    #END
 
+    #IF( #TEXT(Input_fsr_score_change)='' )
      '' 
    #ELSE
        IF( le.Input_fsr_score_change = (TYPEOF(le.Input_fsr_score_change))'','',':fsr_score_change')
    #END
 
+    #IF( #TEXT(Input_dba_name)='' )
      '' 
    #ELSE
        IF( le.Input_dba_name = (TYPEOF(le.Input_dba_name))'','',':dba_name')
    #END
 
+    #IF( #TEXT(Input_clean_dba_name)='' )
      '' 
    #ELSE
        IF( le.Input_clean_dba_name = (TYPEOF(le.Input_clean_dba_name))'','',':clean_dba_name')
    #END
 
+    #IF( #TEXT(Input_clean_phone)='' )
      '' 
    #ELSE
        IF( le.Input_clean_phone = (TYPEOF(le.Input_clean_phone))'','',':clean_phone')
    #END
 
+    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
 
+    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
 
+    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
 
+    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
 
+    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
 
+    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
 
+    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
 
+    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
 
+    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
 
+    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
 
+    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
 
+    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
 
+    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
 
+    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
 
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
 
+    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
 
+    #IF( #TEXT(Input_dbpc)='' )
      '' 
    #ELSE
        IF( le.Input_dbpc = (TYPEOF(le.Input_dbpc))'','',':dbpc')
    #END
 
+    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
 
+    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
 
+    #IF( #TEXT(Input_fips_state)='' )
      '' 
    #ELSE
        IF( le.Input_fips_state = (TYPEOF(le.Input_fips_state))'','',':fips_state')
    #END
 
+    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
 
+    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
 
+    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
 
+    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
 
+    #IF( #TEXT(Input_geo_blk)='' )
      '' 
    #ELSE
        IF( le.Input_geo_blk = (TYPEOF(le.Input_geo_blk))'','',':geo_blk')
    #END
 
+    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
 
+    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
 
+    #IF( #TEXT(Input_recent_update_desc)='' )
      '' 
    #ELSE
        IF( le.Input_recent_update_desc = (TYPEOF(le.Input_recent_update_desc))'','',':recent_update_desc')
    #END
 
+    #IF( #TEXT(Input_years_in_business_desc)='' )
      '' 
    #ELSE
        IF( le.Input_years_in_business_desc = (TYPEOF(le.Input_years_in_business_desc))'','',':years_in_business_desc')
    #END
 
+    #IF( #TEXT(Input_address_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_address_type_desc = (TYPEOF(le.Input_address_type_desc))'','',':address_type_desc')
    #END
 
+    #IF( #TEXT(Input_employee_size_desc)='' )
      '' 
    #ELSE
        IF( le.Input_employee_size_desc = (TYPEOF(le.Input_employee_size_desc))'','',':employee_size_desc')
    #END
 
+    #IF( #TEXT(Input_annual_sales_size_desc)='' )
      '' 
    #ELSE
        IF( le.Input_annual_sales_size_desc = (TYPEOF(le.Input_annual_sales_size_desc))'','',':annual_sales_size_desc')
    #END
 
+    #IF( #TEXT(Input_location_desc)='' )
      '' 
    #ELSE
        IF( le.Input_location_desc = (TYPEOF(le.Input_location_desc))'','',':location_desc')
    #END
 
+    #IF( #TEXT(Input_primary_sic_code_industry_class_desc)='' )
      '' 
    #ELSE
        IF( le.Input_primary_sic_code_industry_class_desc = (TYPEOF(le.Input_primary_sic_code_industry_class_desc))'','',':primary_sic_code_industry_class_desc')
    #END
 
+    #IF( #TEXT(Input_business_type_desc)='' )
      '' 
    #ELSE
        IF( le.Input_business_type_desc = (TYPEOF(le.Input_business_type_desc))'','',':business_type_desc')
    #END
 
+    #IF( #TEXT(Input_ownership_code_desc)='' )
      '' 
    #ELSE
        IF( le.Input_ownership_code_desc = (TYPEOF(le.Input_ownership_code_desc))'','',':ownership_code_desc')
    #END
 
+    #IF( #TEXT(Input_ucc_data_indicator_desc)='' )
      '' 
    #ELSE
        IF( le.Input_ucc_data_indicator_desc = (TYPEOF(le.Input_ucc_data_indicator_desc))'','',':ucc_data_indicator_desc')
    #END
 
+    #IF( #TEXT(Input_experian_credit_rating_desc)='' )
      '' 
    #ELSE
        IF( le.Input_experian_credit_rating_desc = (TYPEOF(le.Input_experian_credit_rating_desc))'','',':experian_credit_rating_desc')
    #END
 
+    #IF( #TEXT(Input_last_activity_age_desc)='' )
      '' 
    #ELSE
        IF( le.Input_last_activity_age_desc = (TYPEOF(le.Input_last_activity_age_desc))'','',':last_activity_age_desc')
    #END
 
+    #IF( #TEXT(Input_cottage_indicator_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cottage_indicator_desc = (TYPEOF(le.Input_cottage_indicator_desc))'','',':cottage_indicator_desc')
    #END
 
+    #IF( #TEXT(Input_nonprofit_indicator_desc)='' )
      '' 
    #ELSE
        IF( le.Input_nonprofit_indicator_desc = (TYPEOF(le.Input_nonprofit_indicator_desc))'','',':nonprofit_indicator_desc')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_p_title)='' )
      '' 
    #ELSE
        IF( le.Input_p_title = (TYPEOF(le.Input_p_title))'','',':p_title')
    #END
 
+    #IF( #TEXT(Input_p_fname)='' )
      '' 
    #ELSE
        IF( le.Input_p_fname = (TYPEOF(le.Input_p_fname))'','',':p_fname')
    #END
 
+    #IF( #TEXT(Input_p_mname)='' )
      '' 
    #ELSE
        IF( le.Input_p_mname = (TYPEOF(le.Input_p_mname))'','',':p_mname')
    #END
 
+    #IF( #TEXT(Input_p_lname)='' )
      '' 
    #ELSE
        IF( le.Input_p_lname = (TYPEOF(le.Input_p_lname))'','',':p_lname')
    #END
 
+    #IF( #TEXT(Input_p_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_p_name_suffix = (TYPEOF(le.Input_p_name_suffix))'','',':p_name_suffix')
    #END
 
+    #IF( #TEXT(Input_raw_aid)='' )
      '' 
    #ELSE
        IF( le.Input_raw_aid = (TYPEOF(le.Input_raw_aid))'','',':raw_aid')
    #END
 
+    #IF( #TEXT(Input_ace_aid)='' )
      '' 
    #ELSE
        IF( le.Input_ace_aid = (TYPEOF(le.Input_ace_aid))'','',':ace_aid')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line1 = (TYPEOF(le.Input_prep_addr_line1))'','',':prep_addr_line1')
    #END
 
+    #IF( #TEXT(Input_prep_addr_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_addr_line_last = (TYPEOF(le.Input_prep_addr_line_last))'','',':prep_addr_line_last')
    #END
 
+    #IF( #TEXT(Input_source_rec_id)='' )
      '' 
    #ELSE
        IF( le.Input_source_rec_id = (TYPEOF(le.Input_source_rec_id))'','',':source_rec_id')
    #END
;
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%, fields, FEW ), 1000, -cnt );
ENDMACRO;
