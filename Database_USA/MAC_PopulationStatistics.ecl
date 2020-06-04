 
EXPORT MAC_PopulationStatistics(infile,Ref='',source='',Input_dt_first_seen = '',Input_dt_last_seen = '',Input_dt_vendor_first_reported = '',Input_dt_vendor_last_reported = '',Input_process_date = '',Input_dotid = '',Input_dotscore = '',Input_dotweight = '',Input_empid = '',Input_empscore = '',Input_empweight = '',Input_powid = '',Input_powscore = '',Input_powweight = '',Input_proxid = '',Input_proxscore = '',Input_proxweight = '',Input_selescore = '',Input_seleweight = '',Input_orgid = '',Input_orgscore = '',Input_orgweight = '',Input_ultid = '',Input_ultscore = '',Input_ultweight = '',Input_record_type = '',Input_global_sid = '',Input_dbusa_business_id = '',Input_dbusa_executive_id = '',Input_subhq_parent_id = '',Input_hq_id = '',Input_ind_frm_indicator = '',Input_company_name = '',Input_full_name = '',Input_prefix = '',Input_first_name = '',Input_middle_initial = '',Input_last_name = '',Input_suffix = '',Input_gender = '',Input_standardized_title = '',Input_sourcetitle = '',Input_executive_title_rank = '',Input_primary_exec_flag = '',Input_exec_type = '',Input_executive_department = '',Input_executive_level = '',Input_phy_addr_standardized = '',Input_phy_addr_city = '',Input_phy_addr_state = '',Input_phy_addr_zip = '',Input_phy_addr_zip4 = '',Input_phy_addr_carrierroute = '',Input_phy_addr_deliverypt = '',Input_phy_addr_deliveryptchkdig = '',Input_mail_addr_standardized = '',Input_mail_addr_city = '',Input_mail_addr_state = '',Input_mail_addr_zip = '',Input_mail_addr_zip4 = '',Input_mail_addr_carrierroute = '',Input_mail_addr_deliverypt = '',Input_mail_addr_deliveryptchkdig = '',Input_mail_score = '',Input_mail_score_desc = '',Input_phone = '',Input_area_code = '',Input_fax = '',Input_email = '',Input_email_available_indicator = '',Input_url = '',Input_url_facebook = '',Input_url_googleplus = '',Input_url_instagram = '',Input_url_linkedin = '',Input_url_twitter = '',Input_url_youtube = '',Input_business_status_code = '',Input_business_status_desc = '',Input_franchise_flag = '',Input_franchise_type = '',Input_franchise_desc = '',Input_ticker_symbol = '',Input_stock_exchange = '',Input_fortune_1000_flag = '',Input_fortune_1000_rank = '',Input_fortune_1000_branches = '',Input_num_linked_locations = '',Input_county_code = '',Input_county_desc = '',Input_cbsa_code = '',Input_cbsa_desc = '',Input_geo_match_level = '',Input_latitude = '',Input_longitude = '',Input_scf = '',Input_timezone = '',Input_censustract = '',Input_censusblock = '',Input_city_population_code = '',Input_city_population_descr = '',Input_primary_sic = '',Input_primary_sic_desc = '',Input_sic02 = '',Input_sic02_desc = '',Input_sic03 = '',Input_sic03_desc = '',Input_sic04 = '',Input_sic04_desc = '',Input_sic05 = '',Input_sic05_desc = '',Input_sic06 = '',Input_sic06_desc = '',Input_primarysic2 = '',Input_primary_2_digit_sic_desc = '',Input_primarysic4 = '',Input_primary_4_digit_sic_desc = '',Input_naics01 = '',Input_naics01_desc = '',Input_naics02 = '',Input_naics02_desc = '',Input_naics03 = '',Input_naics03_desc = '',Input_naics04 = '',Input_naics04_desc = '',Input_naics05 = '',Input_naics05_desc = '',Input_naics06 = '',Input_naics06_desc = '',Input_location_employees_total = '',Input_location_employee_code = '',Input_location_employee_desc = '',Input_location_sales_total = '',Input_location_sales_code = '',Input_location_sales_desc = '',Input_corporate_employee_total = '',Input_corporate_employee_code = '',Input_corporate_employee_desc = '',Input_year_established = '',Input_years_in_business_range = '',Input_female_owned = '',Input_minority_owned_flag = '',Input_minority_type = '',Input_home_based_indicator = '',Input_small_business_indicator = '',Input_import_export = '',Input_manufacturing_location = '',Input_public_indicator = '',Input_ein = '',Input_non_profit_org = '',Input_square_footage = '',Input_square_footage_code = '',Input_square_footage_desc = '',Input_creditscore = '',Input_creditcode = '',Input_credit_desc = '',Input_credit_capacity = '',Input_credit_capacity_code = '',Input_credit_capacity_desc = '',Input_advertising_expenses_code = '',Input_expense_advertising_desc = '',Input_technology_expenses_code = '',Input_expense_technology_desc = '',Input_office_equip_expenses_code = '',Input_expense_office_equip_desc = '',Input_rent_expenses_code = '',Input_expense_rent_desc = '',Input_telecom_expenses_code = '',Input_expense_telecom_desc = '',Input_accounting_expenses_code = '',Input_expense_accounting_desc = '',Input_bus_insurance_expense_code = '',Input_expense_bus_insurance_desc = '',Input_legal_expenses_code = '',Input_expense_legal_desc = '',Input_utilities_expenses_code = '',Input_expense_utilities_desc = '',Input_number_of_pcs_code = '',Input_number_of_pcs_desc = '',Input_nb_flag = '',Input_hq_company_name = '',Input_hq_city = '',Input_hq_state = '',Input_subhq_parent_name = '',Input_subhq_parent_city = '',Input_subhq_parent_state = '',Input_domestic_foreign_owner_flag = '',Input_foreign_parent_company_name = '',Input_foreign_parent_city = '',Input_foreign_parent_country = '',Input_db_cons_matchkey = '',Input_databaseusa_individual_id = '',Input_db_cons_full_name = '',Input_db_cons_full_name_prefix = '',Input_db_cons_first_name = '',Input_db_cons_middle_initial = '',Input_db_cons_last_name = '',Input_db_cons_email = '',Input_db_cons_gender = '',Input_db_cons_date_of_birth_year = '',Input_db_cons_date_of_birth_month = '',Input_db_cons_age = '',Input_db_cons_age_code_desc = '',Input_db_cons_age_in_two_year_hh = '',Input_db_cons_ethnic_code = '',Input_db_cons_religious_affil = '',Input_db_cons_language_pref = '',Input_db_cons_phy_addr_std = '',Input_db_cons_phy_addr_city = '',Input_db_cons_phy_addr_state = '',Input_db_cons_phy_addr_zip = '',Input_db_cons_phy_addr_zip4 = '',Input_db_cons_phy_addr_carrierroute = '',Input_db_cons_phy_addr_deliverypt = '',Input_db_cons_line_of_travel = '',Input_db_cons_geocode_results = '',Input_db_cons_latitude = '',Input_db_cons_longitude = '',Input_db_cons_time_zone_code = '',Input_db_cons_time_zone_desc = '',Input_db_cons_census_tract = '',Input_db_cons_census_block = '',Input_db_cons_countyfips = '',Input_db_countyname = '',Input_db_cons_cbsa_code = '',Input_db_cons_cbsa_desc = '',Input_db_cons_walk_sequence = '',Input_db_cons_phone = '',Input_db_cons_dnc = '',Input_db_cons_scrubbed_phoneable = '',Input_db_cons_children_present = '',Input_db_cons_home_value_code = '',Input_db_cons_home_value_desc = '',Input_db_cons_donor_capacity = '',Input_db_cons_donor_capacity_code = '',Input_db_cons_donor_capacity_desc = '',Input_db_cons_home_owner_renter = '',Input_db_cons_length_of_res = '',Input_db_cons_length_of_res_code = '',Input_db_cons_length_of_res_desc = '',Input_db_cons_dwelling_type = '',Input_db_cons_recent_home_buyer = '',Input_db_cons_income_code = '',Input_db_cons_income_desc = '',Input_db_cons_unsecuredcredcap = '',Input_db_cons_unsecuredcredcapcode = '',Input_db_cons_unsecuredcredcapdesc = '',Input_db_cons_networthhomeval = '',Input_db_cons_networthhomevalcode = '',Input_db_cons_net_worth_desc = '',Input_db_cons_discretincome = '',Input_db_cons_discretincomecode = '',Input_db_cons_discretincomedesc = '',Input_db_cons_marital_status = '',Input_db_cons_new_parent = '',Input_db_cons_child_near_hs_grad = '',Input_db_cons_college_graduate = '',Input_db_cons_intend_purchase_veh = '',Input_db_cons_recent_divorce = '',Input_db_cons_newlywed = '',Input_db_cons_new_teen_driver = '',Input_db_cons_home_year_built = '',Input_db_cons_home_sqft_ranges = '',Input_db_cons_poli_party_ind = '',Input_db_cons_home_sqft_actual = '',Input_db_cons_occupation_ind = '',Input_db_cons_credit_card_user = '',Input_db_cons_home_property_type = '',Input_db_cons_education_hh = '',Input_db_cons_education_ind = '',Input_db_cons_other_pet_owner = '',Input_businesstypedesc = '',Input_genderdesc = '',Input_executivetypedesc = '',Input_dbconsgenderdesc = '',Input_dbconsethnicdesc = '',Input_dbconsreligiousdesc = '',Input_dbconslangprefdesc = '',Input_dbconsownerrenter = '',Input_dbconsdwellingtypedesc = '',Input_dbconsmaritaldesc = '',Input_dbconsnewparentdesc = '',Input_dbconsteendriverdesc = '',Input_dbconspolipartydesc = '',Input_dbconsoccupationdesc = '',Input_dbconspropertytypedesc = '',Input_dbconsheadhouseeducdesc = '',Input_dbconseducationdesc = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dbpc = '',Input_chk_digit = '',Input_rec_type = '',Input_fips_state = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_blk = '',Input_geo_match = '',Input_err_stat = '',Input_raw_aid = '',Input_ace_aid = '',Input_prep_address_line1 = '',Input_prep_address_line_last = '',OutFile) := MACRO
  IMPORT SALT311,Database_USA;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(source)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_dt_first_seen)='' )
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
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_dotid)='' )
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
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_global_sid)='' )
      '' 
    #ELSE
        IF( le.Input_global_sid = (TYPEOF(le.Input_global_sid))'','',':global_sid')
    #END
 
+    #IF( #TEXT(Input_dbusa_business_id)='' )
      '' 
    #ELSE
        IF( le.Input_dbusa_business_id = (TYPEOF(le.Input_dbusa_business_id))'','',':dbusa_business_id')
    #END
 
+    #IF( #TEXT(Input_dbusa_executive_id)='' )
      '' 
    #ELSE
        IF( le.Input_dbusa_executive_id = (TYPEOF(le.Input_dbusa_executive_id))'','',':dbusa_executive_id')
    #END
 
+    #IF( #TEXT(Input_subhq_parent_id)='' )
      '' 
    #ELSE
        IF( le.Input_subhq_parent_id = (TYPEOF(le.Input_subhq_parent_id))'','',':subhq_parent_id')
    #END
 
+    #IF( #TEXT(Input_hq_id)='' )
      '' 
    #ELSE
        IF( le.Input_hq_id = (TYPEOF(le.Input_hq_id))'','',':hq_id')
    #END
 
+    #IF( #TEXT(Input_ind_frm_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_ind_frm_indicator = (TYPEOF(le.Input_ind_frm_indicator))'','',':ind_frm_indicator')
    #END
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
    #END
 
+    #IF( #TEXT(Input_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_full_name = (TYPEOF(le.Input_full_name))'','',':full_name')
    #END
 
+    #IF( #TEXT(Input_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_prefix = (TYPEOF(le.Input_prefix))'','',':prefix')
    #END
 
+    #IF( #TEXT(Input_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_name = (TYPEOF(le.Input_first_name))'','',':first_name')
    #END
 
+    #IF( #TEXT(Input_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_middle_initial = (TYPEOF(le.Input_middle_initial))'','',':middle_initial')
    #END
 
+    #IF( #TEXT(Input_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_last_name = (TYPEOF(le.Input_last_name))'','',':last_name')
    #END
 
+    #IF( #TEXT(Input_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_suffix = (TYPEOF(le.Input_suffix))'','',':suffix')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_standardized_title)='' )
      '' 
    #ELSE
        IF( le.Input_standardized_title = (TYPEOF(le.Input_standardized_title))'','',':standardized_title')
    #END
 
+    #IF( #TEXT(Input_sourcetitle)='' )
      '' 
    #ELSE
        IF( le.Input_sourcetitle = (TYPEOF(le.Input_sourcetitle))'','',':sourcetitle')
    #END
 
+    #IF( #TEXT(Input_executive_title_rank)='' )
      '' 
    #ELSE
        IF( le.Input_executive_title_rank = (TYPEOF(le.Input_executive_title_rank))'','',':executive_title_rank')
    #END
 
+    #IF( #TEXT(Input_primary_exec_flag)='' )
      '' 
    #ELSE
        IF( le.Input_primary_exec_flag = (TYPEOF(le.Input_primary_exec_flag))'','',':primary_exec_flag')
    #END
 
+    #IF( #TEXT(Input_exec_type)='' )
      '' 
    #ELSE
        IF( le.Input_exec_type = (TYPEOF(le.Input_exec_type))'','',':exec_type')
    #END
 
+    #IF( #TEXT(Input_executive_department)='' )
      '' 
    #ELSE
        IF( le.Input_executive_department = (TYPEOF(le.Input_executive_department))'','',':executive_department')
    #END
 
+    #IF( #TEXT(Input_executive_level)='' )
      '' 
    #ELSE
        IF( le.Input_executive_level = (TYPEOF(le.Input_executive_level))'','',':executive_level')
    #END
 
+    #IF( #TEXT(Input_phy_addr_standardized)='' )
      '' 
    #ELSE
        IF( le.Input_phy_addr_standardized = (TYPEOF(le.Input_phy_addr_standardized))'','',':phy_addr_standardized')
    #END
 
+    #IF( #TEXT(Input_phy_addr_city)='' )
      '' 
    #ELSE
        IF( le.Input_phy_addr_city = (TYPEOF(le.Input_phy_addr_city))'','',':phy_addr_city')
    #END
 
+    #IF( #TEXT(Input_phy_addr_state)='' )
      '' 
    #ELSE
        IF( le.Input_phy_addr_state = (TYPEOF(le.Input_phy_addr_state))'','',':phy_addr_state')
    #END
 
+    #IF( #TEXT(Input_phy_addr_zip)='' )
      '' 
    #ELSE
        IF( le.Input_phy_addr_zip = (TYPEOF(le.Input_phy_addr_zip))'','',':phy_addr_zip')
    #END
 
+    #IF( #TEXT(Input_phy_addr_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_phy_addr_zip4 = (TYPEOF(le.Input_phy_addr_zip4))'','',':phy_addr_zip4')
    #END
 
+    #IF( #TEXT(Input_phy_addr_carrierroute)='' )
      '' 
    #ELSE
        IF( le.Input_phy_addr_carrierroute = (TYPEOF(le.Input_phy_addr_carrierroute))'','',':phy_addr_carrierroute')
    #END
 
+    #IF( #TEXT(Input_phy_addr_deliverypt)='' )
      '' 
    #ELSE
        IF( le.Input_phy_addr_deliverypt = (TYPEOF(le.Input_phy_addr_deliverypt))'','',':phy_addr_deliverypt')
    #END
 
+    #IF( #TEXT(Input_phy_addr_deliveryptchkdig)='' )
      '' 
    #ELSE
        IF( le.Input_phy_addr_deliveryptchkdig = (TYPEOF(le.Input_phy_addr_deliveryptchkdig))'','',':phy_addr_deliveryptchkdig')
    #END
 
+    #IF( #TEXT(Input_mail_addr_standardized)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_standardized = (TYPEOF(le.Input_mail_addr_standardized))'','',':mail_addr_standardized')
    #END
 
+    #IF( #TEXT(Input_mail_addr_city)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_city = (TYPEOF(le.Input_mail_addr_city))'','',':mail_addr_city')
    #END
 
+    #IF( #TEXT(Input_mail_addr_state)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_state = (TYPEOF(le.Input_mail_addr_state))'','',':mail_addr_state')
    #END
 
+    #IF( #TEXT(Input_mail_addr_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_zip = (TYPEOF(le.Input_mail_addr_zip))'','',':mail_addr_zip')
    #END
 
+    #IF( #TEXT(Input_mail_addr_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_zip4 = (TYPEOF(le.Input_mail_addr_zip4))'','',':mail_addr_zip4')
    #END
 
+    #IF( #TEXT(Input_mail_addr_carrierroute)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_carrierroute = (TYPEOF(le.Input_mail_addr_carrierroute))'','',':mail_addr_carrierroute')
    #END
 
+    #IF( #TEXT(Input_mail_addr_deliverypt)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_deliverypt = (TYPEOF(le.Input_mail_addr_deliverypt))'','',':mail_addr_deliverypt')
    #END
 
+    #IF( #TEXT(Input_mail_addr_deliveryptchkdig)='' )
      '' 
    #ELSE
        IF( le.Input_mail_addr_deliveryptchkdig = (TYPEOF(le.Input_mail_addr_deliveryptchkdig))'','',':mail_addr_deliveryptchkdig')
    #END
 
+    #IF( #TEXT(Input_mail_score)='' )
      '' 
    #ELSE
        IF( le.Input_mail_score = (TYPEOF(le.Input_mail_score))'','',':mail_score')
    #END
 
+    #IF( #TEXT(Input_mail_score_desc)='' )
      '' 
    #ELSE
        IF( le.Input_mail_score_desc = (TYPEOF(le.Input_mail_score_desc))'','',':mail_score_desc')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
    #END
 
+    #IF( #TEXT(Input_area_code)='' )
      '' 
    #ELSE
        IF( le.Input_area_code = (TYPEOF(le.Input_area_code))'','',':area_code')
    #END
 
+    #IF( #TEXT(Input_fax)='' )
      '' 
    #ELSE
        IF( le.Input_fax = (TYPEOF(le.Input_fax))'','',':fax')
    #END
 
+    #IF( #TEXT(Input_email)='' )
      '' 
    #ELSE
        IF( le.Input_email = (TYPEOF(le.Input_email))'','',':email')
    #END
 
+    #IF( #TEXT(Input_email_available_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_email_available_indicator = (TYPEOF(le.Input_email_available_indicator))'','',':email_available_indicator')
    #END
 
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
 
+    #IF( #TEXT(Input_url_facebook)='' )
      '' 
    #ELSE
        IF( le.Input_url_facebook = (TYPEOF(le.Input_url_facebook))'','',':url_facebook')
    #END
 
+    #IF( #TEXT(Input_url_googleplus)='' )
      '' 
    #ELSE
        IF( le.Input_url_googleplus = (TYPEOF(le.Input_url_googleplus))'','',':url_googleplus')
    #END
 
+    #IF( #TEXT(Input_url_instagram)='' )
      '' 
    #ELSE
        IF( le.Input_url_instagram = (TYPEOF(le.Input_url_instagram))'','',':url_instagram')
    #END
 
+    #IF( #TEXT(Input_url_linkedin)='' )
      '' 
    #ELSE
        IF( le.Input_url_linkedin = (TYPEOF(le.Input_url_linkedin))'','',':url_linkedin')
    #END
 
+    #IF( #TEXT(Input_url_twitter)='' )
      '' 
    #ELSE
        IF( le.Input_url_twitter = (TYPEOF(le.Input_url_twitter))'','',':url_twitter')
    #END
 
+    #IF( #TEXT(Input_url_youtube)='' )
      '' 
    #ELSE
        IF( le.Input_url_youtube = (TYPEOF(le.Input_url_youtube))'','',':url_youtube')
    #END
 
+    #IF( #TEXT(Input_business_status_code)='' )
      '' 
    #ELSE
        IF( le.Input_business_status_code = (TYPEOF(le.Input_business_status_code))'','',':business_status_code')
    #END
 
+    #IF( #TEXT(Input_business_status_desc)='' )
      '' 
    #ELSE
        IF( le.Input_business_status_desc = (TYPEOF(le.Input_business_status_desc))'','',':business_status_desc')
    #END
 
+    #IF( #TEXT(Input_franchise_flag)='' )
      '' 
    #ELSE
        IF( le.Input_franchise_flag = (TYPEOF(le.Input_franchise_flag))'','',':franchise_flag')
    #END
 
+    #IF( #TEXT(Input_franchise_type)='' )
      '' 
    #ELSE
        IF( le.Input_franchise_type = (TYPEOF(le.Input_franchise_type))'','',':franchise_type')
    #END
 
+    #IF( #TEXT(Input_franchise_desc)='' )
      '' 
    #ELSE
        IF( le.Input_franchise_desc = (TYPEOF(le.Input_franchise_desc))'','',':franchise_desc')
    #END
 
+    #IF( #TEXT(Input_ticker_symbol)='' )
      '' 
    #ELSE
        IF( le.Input_ticker_symbol = (TYPEOF(le.Input_ticker_symbol))'','',':ticker_symbol')
    #END
 
+    #IF( #TEXT(Input_stock_exchange)='' )
      '' 
    #ELSE
        IF( le.Input_stock_exchange = (TYPEOF(le.Input_stock_exchange))'','',':stock_exchange')
    #END
 
+    #IF( #TEXT(Input_fortune_1000_flag)='' )
      '' 
    #ELSE
        IF( le.Input_fortune_1000_flag = (TYPEOF(le.Input_fortune_1000_flag))'','',':fortune_1000_flag')
    #END
 
+    #IF( #TEXT(Input_fortune_1000_rank)='' )
      '' 
    #ELSE
        IF( le.Input_fortune_1000_rank = (TYPEOF(le.Input_fortune_1000_rank))'','',':fortune_1000_rank')
    #END
 
+    #IF( #TEXT(Input_fortune_1000_branches)='' )
      '' 
    #ELSE
        IF( le.Input_fortune_1000_branches = (TYPEOF(le.Input_fortune_1000_branches))'','',':fortune_1000_branches')
    #END
 
+    #IF( #TEXT(Input_num_linked_locations)='' )
      '' 
    #ELSE
        IF( le.Input_num_linked_locations = (TYPEOF(le.Input_num_linked_locations))'','',':num_linked_locations')
    #END
 
+    #IF( #TEXT(Input_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_county_code = (TYPEOF(le.Input_county_code))'','',':county_code')
    #END
 
+    #IF( #TEXT(Input_county_desc)='' )
      '' 
    #ELSE
        IF( le.Input_county_desc = (TYPEOF(le.Input_county_desc))'','',':county_desc')
    #END
 
+    #IF( #TEXT(Input_cbsa_code)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa_code = (TYPEOF(le.Input_cbsa_code))'','',':cbsa_code')
    #END
 
+    #IF( #TEXT(Input_cbsa_desc)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa_desc = (TYPEOF(le.Input_cbsa_desc))'','',':cbsa_desc')
    #END
 
+    #IF( #TEXT(Input_geo_match_level)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match_level = (TYPEOF(le.Input_geo_match_level))'','',':geo_match_level')
    #END
 
+    #IF( #TEXT(Input_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_latitude = (TYPEOF(le.Input_latitude))'','',':latitude')
    #END
 
+    #IF( #TEXT(Input_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_longitude = (TYPEOF(le.Input_longitude))'','',':longitude')
    #END
 
+    #IF( #TEXT(Input_scf)='' )
      '' 
    #ELSE
        IF( le.Input_scf = (TYPEOF(le.Input_scf))'','',':scf')
    #END
 
+    #IF( #TEXT(Input_timezone)='' )
      '' 
    #ELSE
        IF( le.Input_timezone = (TYPEOF(le.Input_timezone))'','',':timezone')
    #END
 
+    #IF( #TEXT(Input_censustract)='' )
      '' 
    #ELSE
        IF( le.Input_censustract = (TYPEOF(le.Input_censustract))'','',':censustract')
    #END
 
+    #IF( #TEXT(Input_censusblock)='' )
      '' 
    #ELSE
        IF( le.Input_censusblock = (TYPEOF(le.Input_censusblock))'','',':censusblock')
    #END
 
+    #IF( #TEXT(Input_city_population_code)='' )
      '' 
    #ELSE
        IF( le.Input_city_population_code = (TYPEOF(le.Input_city_population_code))'','',':city_population_code')
    #END
 
+    #IF( #TEXT(Input_city_population_descr)='' )
      '' 
    #ELSE
        IF( le.Input_city_population_descr = (TYPEOF(le.Input_city_population_descr))'','',':city_population_descr')
    #END
 
+    #IF( #TEXT(Input_primary_sic)='' )
      '' 
    #ELSE
        IF( le.Input_primary_sic = (TYPEOF(le.Input_primary_sic))'','',':primary_sic')
    #END
 
+    #IF( #TEXT(Input_primary_sic_desc)='' )
      '' 
    #ELSE
        IF( le.Input_primary_sic_desc = (TYPEOF(le.Input_primary_sic_desc))'','',':primary_sic_desc')
    #END
 
+    #IF( #TEXT(Input_sic02)='' )
      '' 
    #ELSE
        IF( le.Input_sic02 = (TYPEOF(le.Input_sic02))'','',':sic02')
    #END
 
+    #IF( #TEXT(Input_sic02_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic02_desc = (TYPEOF(le.Input_sic02_desc))'','',':sic02_desc')
    #END
 
+    #IF( #TEXT(Input_sic03)='' )
      '' 
    #ELSE
        IF( le.Input_sic03 = (TYPEOF(le.Input_sic03))'','',':sic03')
    #END
 
+    #IF( #TEXT(Input_sic03_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic03_desc = (TYPEOF(le.Input_sic03_desc))'','',':sic03_desc')
    #END
 
+    #IF( #TEXT(Input_sic04)='' )
      '' 
    #ELSE
        IF( le.Input_sic04 = (TYPEOF(le.Input_sic04))'','',':sic04')
    #END
 
+    #IF( #TEXT(Input_sic04_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic04_desc = (TYPEOF(le.Input_sic04_desc))'','',':sic04_desc')
    #END
 
+    #IF( #TEXT(Input_sic05)='' )
      '' 
    #ELSE
        IF( le.Input_sic05 = (TYPEOF(le.Input_sic05))'','',':sic05')
    #END
 
+    #IF( #TEXT(Input_sic05_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic05_desc = (TYPEOF(le.Input_sic05_desc))'','',':sic05_desc')
    #END
 
+    #IF( #TEXT(Input_sic06)='' )
      '' 
    #ELSE
        IF( le.Input_sic06 = (TYPEOF(le.Input_sic06))'','',':sic06')
    #END
 
+    #IF( #TEXT(Input_sic06_desc)='' )
      '' 
    #ELSE
        IF( le.Input_sic06_desc = (TYPEOF(le.Input_sic06_desc))'','',':sic06_desc')
    #END
 
+    #IF( #TEXT(Input_primarysic2)='' )
      '' 
    #ELSE
        IF( le.Input_primarysic2 = (TYPEOF(le.Input_primarysic2))'','',':primarysic2')
    #END
 
+    #IF( #TEXT(Input_primary_2_digit_sic_desc)='' )
      '' 
    #ELSE
        IF( le.Input_primary_2_digit_sic_desc = (TYPEOF(le.Input_primary_2_digit_sic_desc))'','',':primary_2_digit_sic_desc')
    #END
 
+    #IF( #TEXT(Input_primarysic4)='' )
      '' 
    #ELSE
        IF( le.Input_primarysic4 = (TYPEOF(le.Input_primarysic4))'','',':primarysic4')
    #END
 
+    #IF( #TEXT(Input_primary_4_digit_sic_desc)='' )
      '' 
    #ELSE
        IF( le.Input_primary_4_digit_sic_desc = (TYPEOF(le.Input_primary_4_digit_sic_desc))'','',':primary_4_digit_sic_desc')
    #END
 
+    #IF( #TEXT(Input_naics01)='' )
      '' 
    #ELSE
        IF( le.Input_naics01 = (TYPEOF(le.Input_naics01))'','',':naics01')
    #END
 
+    #IF( #TEXT(Input_naics01_desc)='' )
      '' 
    #ELSE
        IF( le.Input_naics01_desc = (TYPEOF(le.Input_naics01_desc))'','',':naics01_desc')
    #END
 
+    #IF( #TEXT(Input_naics02)='' )
      '' 
    #ELSE
        IF( le.Input_naics02 = (TYPEOF(le.Input_naics02))'','',':naics02')
    #END
 
+    #IF( #TEXT(Input_naics02_desc)='' )
      '' 
    #ELSE
        IF( le.Input_naics02_desc = (TYPEOF(le.Input_naics02_desc))'','',':naics02_desc')
    #END
 
+    #IF( #TEXT(Input_naics03)='' )
      '' 
    #ELSE
        IF( le.Input_naics03 = (TYPEOF(le.Input_naics03))'','',':naics03')
    #END
 
+    #IF( #TEXT(Input_naics03_desc)='' )
      '' 
    #ELSE
        IF( le.Input_naics03_desc = (TYPEOF(le.Input_naics03_desc))'','',':naics03_desc')
    #END
 
+    #IF( #TEXT(Input_naics04)='' )
      '' 
    #ELSE
        IF( le.Input_naics04 = (TYPEOF(le.Input_naics04))'','',':naics04')
    #END
 
+    #IF( #TEXT(Input_naics04_desc)='' )
      '' 
    #ELSE
        IF( le.Input_naics04_desc = (TYPEOF(le.Input_naics04_desc))'','',':naics04_desc')
    #END
 
+    #IF( #TEXT(Input_naics05)='' )
      '' 
    #ELSE
        IF( le.Input_naics05 = (TYPEOF(le.Input_naics05))'','',':naics05')
    #END
 
+    #IF( #TEXT(Input_naics05_desc)='' )
      '' 
    #ELSE
        IF( le.Input_naics05_desc = (TYPEOF(le.Input_naics05_desc))'','',':naics05_desc')
    #END
 
+    #IF( #TEXT(Input_naics06)='' )
      '' 
    #ELSE
        IF( le.Input_naics06 = (TYPEOF(le.Input_naics06))'','',':naics06')
    #END
 
+    #IF( #TEXT(Input_naics06_desc)='' )
      '' 
    #ELSE
        IF( le.Input_naics06_desc = (TYPEOF(le.Input_naics06_desc))'','',':naics06_desc')
    #END
 
+    #IF( #TEXT(Input_location_employees_total)='' )
      '' 
    #ELSE
        IF( le.Input_location_employees_total = (TYPEOF(le.Input_location_employees_total))'','',':location_employees_total')
    #END
 
+    #IF( #TEXT(Input_location_employee_code)='' )
      '' 
    #ELSE
        IF( le.Input_location_employee_code = (TYPEOF(le.Input_location_employee_code))'','',':location_employee_code')
    #END
 
+    #IF( #TEXT(Input_location_employee_desc)='' )
      '' 
    #ELSE
        IF( le.Input_location_employee_desc = (TYPEOF(le.Input_location_employee_desc))'','',':location_employee_desc')
    #END
 
+    #IF( #TEXT(Input_location_sales_total)='' )
      '' 
    #ELSE
        IF( le.Input_location_sales_total = (TYPEOF(le.Input_location_sales_total))'','',':location_sales_total')
    #END
 
+    #IF( #TEXT(Input_location_sales_code)='' )
      '' 
    #ELSE
        IF( le.Input_location_sales_code = (TYPEOF(le.Input_location_sales_code))'','',':location_sales_code')
    #END
 
+    #IF( #TEXT(Input_location_sales_desc)='' )
      '' 
    #ELSE
        IF( le.Input_location_sales_desc = (TYPEOF(le.Input_location_sales_desc))'','',':location_sales_desc')
    #END
 
+    #IF( #TEXT(Input_corporate_employee_total)='' )
      '' 
    #ELSE
        IF( le.Input_corporate_employee_total = (TYPEOF(le.Input_corporate_employee_total))'','',':corporate_employee_total')
    #END
 
+    #IF( #TEXT(Input_corporate_employee_code)='' )
      '' 
    #ELSE
        IF( le.Input_corporate_employee_code = (TYPEOF(le.Input_corporate_employee_code))'','',':corporate_employee_code')
    #END
 
+    #IF( #TEXT(Input_corporate_employee_desc)='' )
      '' 
    #ELSE
        IF( le.Input_corporate_employee_desc = (TYPEOF(le.Input_corporate_employee_desc))'','',':corporate_employee_desc')
    #END
 
+    #IF( #TEXT(Input_year_established)='' )
      '' 
    #ELSE
        IF( le.Input_year_established = (TYPEOF(le.Input_year_established))'','',':year_established')
    #END
 
+    #IF( #TEXT(Input_years_in_business_range)='' )
      '' 
    #ELSE
        IF( le.Input_years_in_business_range = (TYPEOF(le.Input_years_in_business_range))'','',':years_in_business_range')
    #END
 
+    #IF( #TEXT(Input_female_owned)='' )
      '' 
    #ELSE
        IF( le.Input_female_owned = (TYPEOF(le.Input_female_owned))'','',':female_owned')
    #END
 
+    #IF( #TEXT(Input_minority_owned_flag)='' )
      '' 
    #ELSE
        IF( le.Input_minority_owned_flag = (TYPEOF(le.Input_minority_owned_flag))'','',':minority_owned_flag')
    #END
 
+    #IF( #TEXT(Input_minority_type)='' )
      '' 
    #ELSE
        IF( le.Input_minority_type = (TYPEOF(le.Input_minority_type))'','',':minority_type')
    #END
 
+    #IF( #TEXT(Input_home_based_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_home_based_indicator = (TYPEOF(le.Input_home_based_indicator))'','',':home_based_indicator')
    #END
 
+    #IF( #TEXT(Input_small_business_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_small_business_indicator = (TYPEOF(le.Input_small_business_indicator))'','',':small_business_indicator')
    #END
 
+    #IF( #TEXT(Input_import_export)='' )
      '' 
    #ELSE
        IF( le.Input_import_export = (TYPEOF(le.Input_import_export))'','',':import_export')
    #END
 
+    #IF( #TEXT(Input_manufacturing_location)='' )
      '' 
    #ELSE
        IF( le.Input_manufacturing_location = (TYPEOF(le.Input_manufacturing_location))'','',':manufacturing_location')
    #END
 
+    #IF( #TEXT(Input_public_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_public_indicator = (TYPEOF(le.Input_public_indicator))'','',':public_indicator')
    #END
 
+    #IF( #TEXT(Input_ein)='' )
      '' 
    #ELSE
        IF( le.Input_ein = (TYPEOF(le.Input_ein))'','',':ein')
    #END
 
+    #IF( #TEXT(Input_non_profit_org)='' )
      '' 
    #ELSE
        IF( le.Input_non_profit_org = (TYPEOF(le.Input_non_profit_org))'','',':non_profit_org')
    #END
 
+    #IF( #TEXT(Input_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_square_footage = (TYPEOF(le.Input_square_footage))'','',':square_footage')
    #END
 
+    #IF( #TEXT(Input_square_footage_code)='' )
      '' 
    #ELSE
        IF( le.Input_square_footage_code = (TYPEOF(le.Input_square_footage_code))'','',':square_footage_code')
    #END
 
+    #IF( #TEXT(Input_square_footage_desc)='' )
      '' 
    #ELSE
        IF( le.Input_square_footage_desc = (TYPEOF(le.Input_square_footage_desc))'','',':square_footage_desc')
    #END
 
+    #IF( #TEXT(Input_creditscore)='' )
      '' 
    #ELSE
        IF( le.Input_creditscore = (TYPEOF(le.Input_creditscore))'','',':creditscore')
    #END
 
+    #IF( #TEXT(Input_creditcode)='' )
      '' 
    #ELSE
        IF( le.Input_creditcode = (TYPEOF(le.Input_creditcode))'','',':creditcode')
    #END
 
+    #IF( #TEXT(Input_credit_desc)='' )
      '' 
    #ELSE
        IF( le.Input_credit_desc = (TYPEOF(le.Input_credit_desc))'','',':credit_desc')
    #END
 
+    #IF( #TEXT(Input_credit_capacity)='' )
      '' 
    #ELSE
        IF( le.Input_credit_capacity = (TYPEOF(le.Input_credit_capacity))'','',':credit_capacity')
    #END
 
+    #IF( #TEXT(Input_credit_capacity_code)='' )
      '' 
    #ELSE
        IF( le.Input_credit_capacity_code = (TYPEOF(le.Input_credit_capacity_code))'','',':credit_capacity_code')
    #END
 
+    #IF( #TEXT(Input_credit_capacity_desc)='' )
      '' 
    #ELSE
        IF( le.Input_credit_capacity_desc = (TYPEOF(le.Input_credit_capacity_desc))'','',':credit_capacity_desc')
    #END
 
+    #IF( #TEXT(Input_advertising_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_advertising_expenses_code = (TYPEOF(le.Input_advertising_expenses_code))'','',':advertising_expenses_code')
    #END
 
+    #IF( #TEXT(Input_expense_advertising_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_advertising_desc = (TYPEOF(le.Input_expense_advertising_desc))'','',':expense_advertising_desc')
    #END
 
+    #IF( #TEXT(Input_technology_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_technology_expenses_code = (TYPEOF(le.Input_technology_expenses_code))'','',':technology_expenses_code')
    #END
 
+    #IF( #TEXT(Input_expense_technology_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_technology_desc = (TYPEOF(le.Input_expense_technology_desc))'','',':expense_technology_desc')
    #END
 
+    #IF( #TEXT(Input_office_equip_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_office_equip_expenses_code = (TYPEOF(le.Input_office_equip_expenses_code))'','',':office_equip_expenses_code')
    #END
 
+    #IF( #TEXT(Input_expense_office_equip_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_office_equip_desc = (TYPEOF(le.Input_expense_office_equip_desc))'','',':expense_office_equip_desc')
    #END
 
+    #IF( #TEXT(Input_rent_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_rent_expenses_code = (TYPEOF(le.Input_rent_expenses_code))'','',':rent_expenses_code')
    #END
 
+    #IF( #TEXT(Input_expense_rent_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_rent_desc = (TYPEOF(le.Input_expense_rent_desc))'','',':expense_rent_desc')
    #END
 
+    #IF( #TEXT(Input_telecom_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_telecom_expenses_code = (TYPEOF(le.Input_telecom_expenses_code))'','',':telecom_expenses_code')
    #END
 
+    #IF( #TEXT(Input_expense_telecom_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_telecom_desc = (TYPEOF(le.Input_expense_telecom_desc))'','',':expense_telecom_desc')
    #END
 
+    #IF( #TEXT(Input_accounting_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_accounting_expenses_code = (TYPEOF(le.Input_accounting_expenses_code))'','',':accounting_expenses_code')
    #END
 
+    #IF( #TEXT(Input_expense_accounting_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_accounting_desc = (TYPEOF(le.Input_expense_accounting_desc))'','',':expense_accounting_desc')
    #END
 
+    #IF( #TEXT(Input_bus_insurance_expense_code)='' )
      '' 
    #ELSE
        IF( le.Input_bus_insurance_expense_code = (TYPEOF(le.Input_bus_insurance_expense_code))'','',':bus_insurance_expense_code')
    #END
 
+    #IF( #TEXT(Input_expense_bus_insurance_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_bus_insurance_desc = (TYPEOF(le.Input_expense_bus_insurance_desc))'','',':expense_bus_insurance_desc')
    #END
 
+    #IF( #TEXT(Input_legal_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_legal_expenses_code = (TYPEOF(le.Input_legal_expenses_code))'','',':legal_expenses_code')
    #END
 
+    #IF( #TEXT(Input_expense_legal_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_legal_desc = (TYPEOF(le.Input_expense_legal_desc))'','',':expense_legal_desc')
    #END
 
+    #IF( #TEXT(Input_utilities_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_utilities_expenses_code = (TYPEOF(le.Input_utilities_expenses_code))'','',':utilities_expenses_code')
    #END
 
+    #IF( #TEXT(Input_expense_utilities_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_utilities_desc = (TYPEOF(le.Input_expense_utilities_desc))'','',':expense_utilities_desc')
    #END
 
+    #IF( #TEXT(Input_number_of_pcs_code)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_pcs_code = (TYPEOF(le.Input_number_of_pcs_code))'','',':number_of_pcs_code')
    #END
 
+    #IF( #TEXT(Input_number_of_pcs_desc)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_pcs_desc = (TYPEOF(le.Input_number_of_pcs_desc))'','',':number_of_pcs_desc')
    #END
 
+    #IF( #TEXT(Input_nb_flag)='' )
      '' 
    #ELSE
        IF( le.Input_nb_flag = (TYPEOF(le.Input_nb_flag))'','',':nb_flag')
    #END
 
+    #IF( #TEXT(Input_hq_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_hq_company_name = (TYPEOF(le.Input_hq_company_name))'','',':hq_company_name')
    #END
 
+    #IF( #TEXT(Input_hq_city)='' )
      '' 
    #ELSE
        IF( le.Input_hq_city = (TYPEOF(le.Input_hq_city))'','',':hq_city')
    #END
 
+    #IF( #TEXT(Input_hq_state)='' )
      '' 
    #ELSE
        IF( le.Input_hq_state = (TYPEOF(le.Input_hq_state))'','',':hq_state')
    #END
 
+    #IF( #TEXT(Input_subhq_parent_name)='' )
      '' 
    #ELSE
        IF( le.Input_subhq_parent_name = (TYPEOF(le.Input_subhq_parent_name))'','',':subhq_parent_name')
    #END
 
+    #IF( #TEXT(Input_subhq_parent_city)='' )
      '' 
    #ELSE
        IF( le.Input_subhq_parent_city = (TYPEOF(le.Input_subhq_parent_city))'','',':subhq_parent_city')
    #END
 
+    #IF( #TEXT(Input_subhq_parent_state)='' )
      '' 
    #ELSE
        IF( le.Input_subhq_parent_state = (TYPEOF(le.Input_subhq_parent_state))'','',':subhq_parent_state')
    #END
 
+    #IF( #TEXT(Input_domestic_foreign_owner_flag)='' )
      '' 
    #ELSE
        IF( le.Input_domestic_foreign_owner_flag = (TYPEOF(le.Input_domestic_foreign_owner_flag))'','',':domestic_foreign_owner_flag')
    #END
 
+    #IF( #TEXT(Input_foreign_parent_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_parent_company_name = (TYPEOF(le.Input_foreign_parent_company_name))'','',':foreign_parent_company_name')
    #END
 
+    #IF( #TEXT(Input_foreign_parent_city)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_parent_city = (TYPEOF(le.Input_foreign_parent_city))'','',':foreign_parent_city')
    #END
 
+    #IF( #TEXT(Input_foreign_parent_country)='' )
      '' 
    #ELSE
        IF( le.Input_foreign_parent_country = (TYPEOF(le.Input_foreign_parent_country))'','',':foreign_parent_country')
    #END
 
+    #IF( #TEXT(Input_db_cons_matchkey)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_matchkey = (TYPEOF(le.Input_db_cons_matchkey))'','',':db_cons_matchkey')
    #END
 
+    #IF( #TEXT(Input_databaseusa_individual_id)='' )
      '' 
    #ELSE
        IF( le.Input_databaseusa_individual_id = (TYPEOF(le.Input_databaseusa_individual_id))'','',':databaseusa_individual_id')
    #END
 
+    #IF( #TEXT(Input_db_cons_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_full_name = (TYPEOF(le.Input_db_cons_full_name))'','',':db_cons_full_name')
    #END
 
+    #IF( #TEXT(Input_db_cons_full_name_prefix)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_full_name_prefix = (TYPEOF(le.Input_db_cons_full_name_prefix))'','',':db_cons_full_name_prefix')
    #END
 
+    #IF( #TEXT(Input_db_cons_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_first_name = (TYPEOF(le.Input_db_cons_first_name))'','',':db_cons_first_name')
    #END
 
+    #IF( #TEXT(Input_db_cons_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_middle_initial = (TYPEOF(le.Input_db_cons_middle_initial))'','',':db_cons_middle_initial')
    #END
 
+    #IF( #TEXT(Input_db_cons_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_last_name = (TYPEOF(le.Input_db_cons_last_name))'','',':db_cons_last_name')
    #END
 
+    #IF( #TEXT(Input_db_cons_email)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_email = (TYPEOF(le.Input_db_cons_email))'','',':db_cons_email')
    #END
 
+    #IF( #TEXT(Input_db_cons_gender)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_gender = (TYPEOF(le.Input_db_cons_gender))'','',':db_cons_gender')
    #END
 
+    #IF( #TEXT(Input_db_cons_date_of_birth_year)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_date_of_birth_year = (TYPEOF(le.Input_db_cons_date_of_birth_year))'','',':db_cons_date_of_birth_year')
    #END
 
+    #IF( #TEXT(Input_db_cons_date_of_birth_month)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_date_of_birth_month = (TYPEOF(le.Input_db_cons_date_of_birth_month))'','',':db_cons_date_of_birth_month')
    #END
 
+    #IF( #TEXT(Input_db_cons_age)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_age = (TYPEOF(le.Input_db_cons_age))'','',':db_cons_age')
    #END
 
+    #IF( #TEXT(Input_db_cons_age_code_desc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_age_code_desc = (TYPEOF(le.Input_db_cons_age_code_desc))'','',':db_cons_age_code_desc')
    #END
 
+    #IF( #TEXT(Input_db_cons_age_in_two_year_hh)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_age_in_two_year_hh = (TYPEOF(le.Input_db_cons_age_in_two_year_hh))'','',':db_cons_age_in_two_year_hh')
    #END
 
+    #IF( #TEXT(Input_db_cons_ethnic_code)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_ethnic_code = (TYPEOF(le.Input_db_cons_ethnic_code))'','',':db_cons_ethnic_code')
    #END
 
+    #IF( #TEXT(Input_db_cons_religious_affil)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_religious_affil = (TYPEOF(le.Input_db_cons_religious_affil))'','',':db_cons_religious_affil')
    #END
 
+    #IF( #TEXT(Input_db_cons_language_pref)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_language_pref = (TYPEOF(le.Input_db_cons_language_pref))'','',':db_cons_language_pref')
    #END
 
+    #IF( #TEXT(Input_db_cons_phy_addr_std)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phy_addr_std = (TYPEOF(le.Input_db_cons_phy_addr_std))'','',':db_cons_phy_addr_std')
    #END
 
+    #IF( #TEXT(Input_db_cons_phy_addr_city)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phy_addr_city = (TYPEOF(le.Input_db_cons_phy_addr_city))'','',':db_cons_phy_addr_city')
    #END
 
+    #IF( #TEXT(Input_db_cons_phy_addr_state)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phy_addr_state = (TYPEOF(le.Input_db_cons_phy_addr_state))'','',':db_cons_phy_addr_state')
    #END
 
+    #IF( #TEXT(Input_db_cons_phy_addr_zip)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phy_addr_zip = (TYPEOF(le.Input_db_cons_phy_addr_zip))'','',':db_cons_phy_addr_zip')
    #END
 
+    #IF( #TEXT(Input_db_cons_phy_addr_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phy_addr_zip4 = (TYPEOF(le.Input_db_cons_phy_addr_zip4))'','',':db_cons_phy_addr_zip4')
    #END
 
+    #IF( #TEXT(Input_db_cons_phy_addr_carrierroute)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phy_addr_carrierroute = (TYPEOF(le.Input_db_cons_phy_addr_carrierroute))'','',':db_cons_phy_addr_carrierroute')
    #END
 
+    #IF( #TEXT(Input_db_cons_phy_addr_deliverypt)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phy_addr_deliverypt = (TYPEOF(le.Input_db_cons_phy_addr_deliverypt))'','',':db_cons_phy_addr_deliverypt')
    #END
 
+    #IF( #TEXT(Input_db_cons_line_of_travel)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_line_of_travel = (TYPEOF(le.Input_db_cons_line_of_travel))'','',':db_cons_line_of_travel')
    #END
 
+    #IF( #TEXT(Input_db_cons_geocode_results)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_geocode_results = (TYPEOF(le.Input_db_cons_geocode_results))'','',':db_cons_geocode_results')
    #END
 
+    #IF( #TEXT(Input_db_cons_latitude)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_latitude = (TYPEOF(le.Input_db_cons_latitude))'','',':db_cons_latitude')
    #END
 
+    #IF( #TEXT(Input_db_cons_longitude)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_longitude = (TYPEOF(le.Input_db_cons_longitude))'','',':db_cons_longitude')
    #END
 
+    #IF( #TEXT(Input_db_cons_time_zone_code)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_time_zone_code = (TYPEOF(le.Input_db_cons_time_zone_code))'','',':db_cons_time_zone_code')
    #END
 
+    #IF( #TEXT(Input_db_cons_time_zone_desc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_time_zone_desc = (TYPEOF(le.Input_db_cons_time_zone_desc))'','',':db_cons_time_zone_desc')
    #END
 
+    #IF( #TEXT(Input_db_cons_census_tract)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_census_tract = (TYPEOF(le.Input_db_cons_census_tract))'','',':db_cons_census_tract')
    #END
 
+    #IF( #TEXT(Input_db_cons_census_block)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_census_block = (TYPEOF(le.Input_db_cons_census_block))'','',':db_cons_census_block')
    #END
 
+    #IF( #TEXT(Input_db_cons_countyfips)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_countyfips = (TYPEOF(le.Input_db_cons_countyfips))'','',':db_cons_countyfips')
    #END
 
+    #IF( #TEXT(Input_db_countyname)='' )
      '' 
    #ELSE
        IF( le.Input_db_countyname = (TYPEOF(le.Input_db_countyname))'','',':db_countyname')
    #END
 
+    #IF( #TEXT(Input_db_cons_cbsa_code)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_cbsa_code = (TYPEOF(le.Input_db_cons_cbsa_code))'','',':db_cons_cbsa_code')
    #END
 
+    #IF( #TEXT(Input_db_cons_cbsa_desc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_cbsa_desc = (TYPEOF(le.Input_db_cons_cbsa_desc))'','',':db_cons_cbsa_desc')
    #END
 
+    #IF( #TEXT(Input_db_cons_walk_sequence)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_walk_sequence = (TYPEOF(le.Input_db_cons_walk_sequence))'','',':db_cons_walk_sequence')
    #END
 
+    #IF( #TEXT(Input_db_cons_phone)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phone = (TYPEOF(le.Input_db_cons_phone))'','',':db_cons_phone')
    #END
 
+    #IF( #TEXT(Input_db_cons_dnc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_dnc = (TYPEOF(le.Input_db_cons_dnc))'','',':db_cons_dnc')
    #END
 
+    #IF( #TEXT(Input_db_cons_scrubbed_phoneable)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_scrubbed_phoneable = (TYPEOF(le.Input_db_cons_scrubbed_phoneable))'','',':db_cons_scrubbed_phoneable')
    #END
 
+    #IF( #TEXT(Input_db_cons_children_present)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_children_present = (TYPEOF(le.Input_db_cons_children_present))'','',':db_cons_children_present')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_value_code)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_value_code = (TYPEOF(le.Input_db_cons_home_value_code))'','',':db_cons_home_value_code')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_value_desc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_value_desc = (TYPEOF(le.Input_db_cons_home_value_desc))'','',':db_cons_home_value_desc')
    #END
 
+    #IF( #TEXT(Input_db_cons_donor_capacity)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_donor_capacity = (TYPEOF(le.Input_db_cons_donor_capacity))'','',':db_cons_donor_capacity')
    #END
 
+    #IF( #TEXT(Input_db_cons_donor_capacity_code)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_donor_capacity_code = (TYPEOF(le.Input_db_cons_donor_capacity_code))'','',':db_cons_donor_capacity_code')
    #END
 
+    #IF( #TEXT(Input_db_cons_donor_capacity_desc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_donor_capacity_desc = (TYPEOF(le.Input_db_cons_donor_capacity_desc))'','',':db_cons_donor_capacity_desc')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_owner_renter)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_owner_renter = (TYPEOF(le.Input_db_cons_home_owner_renter))'','',':db_cons_home_owner_renter')
    #END
 
+    #IF( #TEXT(Input_db_cons_length_of_res)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_length_of_res = (TYPEOF(le.Input_db_cons_length_of_res))'','',':db_cons_length_of_res')
    #END
 
+    #IF( #TEXT(Input_db_cons_length_of_res_code)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_length_of_res_code = (TYPEOF(le.Input_db_cons_length_of_res_code))'','',':db_cons_length_of_res_code')
    #END
 
+    #IF( #TEXT(Input_db_cons_length_of_res_desc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_length_of_res_desc = (TYPEOF(le.Input_db_cons_length_of_res_desc))'','',':db_cons_length_of_res_desc')
    #END
 
+    #IF( #TEXT(Input_db_cons_dwelling_type)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_dwelling_type = (TYPEOF(le.Input_db_cons_dwelling_type))'','',':db_cons_dwelling_type')
    #END
 
+    #IF( #TEXT(Input_db_cons_recent_home_buyer)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_recent_home_buyer = (TYPEOF(le.Input_db_cons_recent_home_buyer))'','',':db_cons_recent_home_buyer')
    #END
 
+    #IF( #TEXT(Input_db_cons_income_code)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_income_code = (TYPEOF(le.Input_db_cons_income_code))'','',':db_cons_income_code')
    #END
 
+    #IF( #TEXT(Input_db_cons_income_desc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_income_desc = (TYPEOF(le.Input_db_cons_income_desc))'','',':db_cons_income_desc')
    #END
 
+    #IF( #TEXT(Input_db_cons_unsecuredcredcap)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_unsecuredcredcap = (TYPEOF(le.Input_db_cons_unsecuredcredcap))'','',':db_cons_unsecuredcredcap')
    #END
 
+    #IF( #TEXT(Input_db_cons_unsecuredcredcapcode)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_unsecuredcredcapcode = (TYPEOF(le.Input_db_cons_unsecuredcredcapcode))'','',':db_cons_unsecuredcredcapcode')
    #END
 
+    #IF( #TEXT(Input_db_cons_unsecuredcredcapdesc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_unsecuredcredcapdesc = (TYPEOF(le.Input_db_cons_unsecuredcredcapdesc))'','',':db_cons_unsecuredcredcapdesc')
    #END
 
+    #IF( #TEXT(Input_db_cons_networthhomeval)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_networthhomeval = (TYPEOF(le.Input_db_cons_networthhomeval))'','',':db_cons_networthhomeval')
    #END
 
+    #IF( #TEXT(Input_db_cons_networthhomevalcode)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_networthhomevalcode = (TYPEOF(le.Input_db_cons_networthhomevalcode))'','',':db_cons_networthhomevalcode')
    #END
 
+    #IF( #TEXT(Input_db_cons_net_worth_desc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_net_worth_desc = (TYPEOF(le.Input_db_cons_net_worth_desc))'','',':db_cons_net_worth_desc')
    #END
 
+    #IF( #TEXT(Input_db_cons_discretincome)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_discretincome = (TYPEOF(le.Input_db_cons_discretincome))'','',':db_cons_discretincome')
    #END
 
+    #IF( #TEXT(Input_db_cons_discretincomecode)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_discretincomecode = (TYPEOF(le.Input_db_cons_discretincomecode))'','',':db_cons_discretincomecode')
    #END
 
+    #IF( #TEXT(Input_db_cons_discretincomedesc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_discretincomedesc = (TYPEOF(le.Input_db_cons_discretincomedesc))'','',':db_cons_discretincomedesc')
    #END
 
+    #IF( #TEXT(Input_db_cons_marital_status)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_marital_status = (TYPEOF(le.Input_db_cons_marital_status))'','',':db_cons_marital_status')
    #END
 
+    #IF( #TEXT(Input_db_cons_new_parent)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_new_parent = (TYPEOF(le.Input_db_cons_new_parent))'','',':db_cons_new_parent')
    #END
 
+    #IF( #TEXT(Input_db_cons_child_near_hs_grad)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_child_near_hs_grad = (TYPEOF(le.Input_db_cons_child_near_hs_grad))'','',':db_cons_child_near_hs_grad')
    #END
 
+    #IF( #TEXT(Input_db_cons_college_graduate)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_college_graduate = (TYPEOF(le.Input_db_cons_college_graduate))'','',':db_cons_college_graduate')
    #END
 
+    #IF( #TEXT(Input_db_cons_intend_purchase_veh)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_intend_purchase_veh = (TYPEOF(le.Input_db_cons_intend_purchase_veh))'','',':db_cons_intend_purchase_veh')
    #END
 
+    #IF( #TEXT(Input_db_cons_recent_divorce)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_recent_divorce = (TYPEOF(le.Input_db_cons_recent_divorce))'','',':db_cons_recent_divorce')
    #END
 
+    #IF( #TEXT(Input_db_cons_newlywed)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_newlywed = (TYPEOF(le.Input_db_cons_newlywed))'','',':db_cons_newlywed')
    #END
 
+    #IF( #TEXT(Input_db_cons_new_teen_driver)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_new_teen_driver = (TYPEOF(le.Input_db_cons_new_teen_driver))'','',':db_cons_new_teen_driver')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_year_built = (TYPEOF(le.Input_db_cons_home_year_built))'','',':db_cons_home_year_built')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_sqft_ranges)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_sqft_ranges = (TYPEOF(le.Input_db_cons_home_sqft_ranges))'','',':db_cons_home_sqft_ranges')
    #END
 
+    #IF( #TEXT(Input_db_cons_poli_party_ind)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_poli_party_ind = (TYPEOF(le.Input_db_cons_poli_party_ind))'','',':db_cons_poli_party_ind')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_sqft_actual)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_sqft_actual = (TYPEOF(le.Input_db_cons_home_sqft_actual))'','',':db_cons_home_sqft_actual')
    #END
 
+    #IF( #TEXT(Input_db_cons_occupation_ind)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_occupation_ind = (TYPEOF(le.Input_db_cons_occupation_ind))'','',':db_cons_occupation_ind')
    #END
 
+    #IF( #TEXT(Input_db_cons_credit_card_user)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_credit_card_user = (TYPEOF(le.Input_db_cons_credit_card_user))'','',':db_cons_credit_card_user')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_property_type)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_property_type = (TYPEOF(le.Input_db_cons_home_property_type))'','',':db_cons_home_property_type')
    #END
 
+    #IF( #TEXT(Input_db_cons_education_hh)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_education_hh = (TYPEOF(le.Input_db_cons_education_hh))'','',':db_cons_education_hh')
    #END
 
+    #IF( #TEXT(Input_db_cons_education_ind)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_education_ind = (TYPEOF(le.Input_db_cons_education_ind))'','',':db_cons_education_ind')
    #END
 
+    #IF( #TEXT(Input_db_cons_other_pet_owner)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_other_pet_owner = (TYPEOF(le.Input_db_cons_other_pet_owner))'','',':db_cons_other_pet_owner')
    #END
 
+    #IF( #TEXT(Input_businesstypedesc)='' )
      '' 
    #ELSE
        IF( le.Input_businesstypedesc = (TYPEOF(le.Input_businesstypedesc))'','',':businesstypedesc')
    #END
 
+    #IF( #TEXT(Input_genderdesc)='' )
      '' 
    #ELSE
        IF( le.Input_genderdesc = (TYPEOF(le.Input_genderdesc))'','',':genderdesc')
    #END
 
+    #IF( #TEXT(Input_executivetypedesc)='' )
      '' 
    #ELSE
        IF( le.Input_executivetypedesc = (TYPEOF(le.Input_executivetypedesc))'','',':executivetypedesc')
    #END
 
+    #IF( #TEXT(Input_dbconsgenderdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsgenderdesc = (TYPEOF(le.Input_dbconsgenderdesc))'','',':dbconsgenderdesc')
    #END
 
+    #IF( #TEXT(Input_dbconsethnicdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsethnicdesc = (TYPEOF(le.Input_dbconsethnicdesc))'','',':dbconsethnicdesc')
    #END
 
+    #IF( #TEXT(Input_dbconsreligiousdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsreligiousdesc = (TYPEOF(le.Input_dbconsreligiousdesc))'','',':dbconsreligiousdesc')
    #END
 
+    #IF( #TEXT(Input_dbconslangprefdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconslangprefdesc = (TYPEOF(le.Input_dbconslangprefdesc))'','',':dbconslangprefdesc')
    #END
 
+    #IF( #TEXT(Input_dbconsownerrenter)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsownerrenter = (TYPEOF(le.Input_dbconsownerrenter))'','',':dbconsownerrenter')
    #END
 
+    #IF( #TEXT(Input_dbconsdwellingtypedesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsdwellingtypedesc = (TYPEOF(le.Input_dbconsdwellingtypedesc))'','',':dbconsdwellingtypedesc')
    #END
 
+    #IF( #TEXT(Input_dbconsmaritaldesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsmaritaldesc = (TYPEOF(le.Input_dbconsmaritaldesc))'','',':dbconsmaritaldesc')
    #END
 
+    #IF( #TEXT(Input_dbconsnewparentdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsnewparentdesc = (TYPEOF(le.Input_dbconsnewparentdesc))'','',':dbconsnewparentdesc')
    #END
 
+    #IF( #TEXT(Input_dbconsteendriverdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsteendriverdesc = (TYPEOF(le.Input_dbconsteendriverdesc))'','',':dbconsteendriverdesc')
    #END
 
+    #IF( #TEXT(Input_dbconspolipartydesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconspolipartydesc = (TYPEOF(le.Input_dbconspolipartydesc))'','',':dbconspolipartydesc')
    #END
 
+    #IF( #TEXT(Input_dbconsoccupationdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsoccupationdesc = (TYPEOF(le.Input_dbconsoccupationdesc))'','',':dbconsoccupationdesc')
    #END
 
+    #IF( #TEXT(Input_dbconspropertytypedesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconspropertytypedesc = (TYPEOF(le.Input_dbconspropertytypedesc))'','',':dbconspropertytypedesc')
    #END
 
+    #IF( #TEXT(Input_dbconsheadhouseeducdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconsheadhouseeducdesc = (TYPEOF(le.Input_dbconsheadhouseeducdesc))'','',':dbconsheadhouseeducdesc')
    #END
 
+    #IF( #TEXT(Input_dbconseducationdesc)='' )
      '' 
    #ELSE
        IF( le.Input_dbconseducationdesc = (TYPEOF(le.Input_dbconseducationdesc))'','',':dbconseducationdesc')
    #END
 
+    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
 
+    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
 
+    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
 
+    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
 
+    #IF( #TEXT(Input_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_score = (TYPEOF(le.Input_name_score))'','',':name_score')
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
 
+    #IF( #TEXT(Input_prep_address_line1)='' )
      '' 
    #ELSE
        IF( le.Input_prep_address_line1 = (TYPEOF(le.Input_prep_address_line1))'','',':prep_address_line1')
    #END
 
+    #IF( #TEXT(Input_prep_address_line_last)='' )
      '' 
    #ELSE
        IF( le.Input_prep_address_line_last = (TYPEOF(le.Input_prep_address_line_last))'','',':prep_address_line_last')
    #END
;
    #IF (#TEXT(source)<>'')
    SELF.source := le.source;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(source)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(source)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(source)<>'' ) source, #END -cnt );
ENDMACRO;
