 
EXPORT Input_MAC_PopulationStatistics(infile,Ref='',Input_accounting_expenses_code = '',Input_advertising_expenses_code = '',Input_bus_insurance_expense_code = '',Input_business_status_code = '',Input_business_status_desc = '',Input_city_population_code = '',Input_city_population_descr = '',Input_company_name = '',Input_corporate_employee_code = '',Input_corporate_employee_desc = '',Input_county_code = '',Input_creditcode = '',Input_credit_desc = '',Input_credit_capacity_code = '',Input_credit_capacity_desc = '',Input_db_cons_age = '',Input_db_cons_child_near_hs_grad = '',Input_db_cons_children_present = '',Input_db_cons_college_graduate = '',Input_db_cons_credit_card_user = '',Input_db_cons_date_of_birth_month = '',Input_db_cons_date_of_birth_year = '',Input_db_cons_discretincomecode = '',Input_db_cons_discretincomedesc = '',Input_db_cons_dnc = '',Input_db_cons_donor_capacity_code = '',Input_db_cons_donor_capacity_desc = '',Input_db_cons_dwelling_type = '',Input_db_cons_education_hh = '',Input_db_cons_education_ind = '',Input_db_cons_email = '',Input_db_cons_ethnic_code = '',Input_db_cons_full_name = '',Input_db_cons_gender = '',Input_db_cons_home_owner_renter = '',Input_db_cons_home_property_type = '',Input_db_cons_home_sqft_ranges = '',Input_db_cons_home_value_code = '',Input_db_cons_home_value_desc = '',Input_db_cons_home_year_built = '',Input_db_cons_income_code = '',Input_db_cons_income_desc = '',Input_db_cons_intend_purchase_veh = '',Input_db_cons_language_pref = '',Input_db_cons_length_of_res_code = '',Input_db_cons_length_of_res_desc = '',Input_db_cons_marital_status = '',Input_db_cons_networthhomevalcode = '',Input_db_cons_net_worth_desc = '',Input_db_cons_new_parent = '',Input_db_cons_new_teen_driver = '',Input_db_cons_newlywed = '',Input_db_cons_occupation_ind = '',Input_db_cons_other_pet_owner = '',Input_db_cons_phone = '',Input_db_cons_poli_party_ind = '',Input_db_cons_recent_divorce = '',Input_db_cons_recent_home_buyer = '',Input_db_cons_religious_affil = '',Input_db_cons_scrubbed_phoneable = '',Input_db_cons_time_zone_code = '',Input_db_cons_time_zone_desc = '',Input_db_cons_unsecuredcredcapcode = '',Input_db_cons_unsecuredcredcapdesc = '',Input_domestic_foreign_owner_flag = '',Input_email = '',Input_email_available_indicator = '',Input_exec_type = '',Input_executive_level = '',Input_executive_title_rank = '',Input_expense_accounting_desc = '',Input_expense_advertising_desc = '',Input_expense_bus_insurance_desc = '',Input_expense_legal_desc = '',Input_expense_office_equip_desc = '',Input_expense_rent_desc = '',Input_expense_technology_desc = '',Input_expense_telecom_desc = '',Input_expense_utilities_desc = '',Input_female_owned = '',Input_franchise_flag = '',Input_franchise_type = '',Input_full_name = '',Input_gender = '',Input_home_based_indicator = '',Input_import_export = '',Input_ind_frm_indicator = '',Input_legal_expenses_code = '',Input_location_employee_code = '',Input_location_employee_desc = '',Input_location_sales_code = '',Input_location_sales_desc = '',Input_mail_addr_state = '',Input_mail_addr_zip = '',Input_mail_score = '',Input_manufacturing_location = '',Input_minority_owned_flag = '',Input_minority_type = '',Input_naics01 = '',Input_naics02 = '',Input_naics03 = '',Input_naics04 = '',Input_naics05 = '',Input_naics06 = '',Input_nb_flag = '',Input_non_profit_org = '',Input_number_of_pcs_code = '',Input_number_of_pcs_desc = '',Input_office_equip_expenses_code = '',Input_phone = '',Input_phy_addr_state = '',Input_phy_addr_zip = '',Input_primary_exec_flag = '',Input_primary_sic = '',Input_primarysic2 = '',Input_primarysic4 = '',Input_public_indicator = '',Input_rent_expenses_code = '',Input_sic02 = '',Input_sic03 = '',Input_sic04 = '',Input_sic05 = '',Input_sic06 = '',Input_small_business_indicator = '',Input_square_footage_code = '',Input_square_footage_desc = '',Input_standardized_title = '',Input_technology_expenses_code = '',Input_telecom_expenses_code = '',Input_url = '',Input_utilities_expenses_code = '',Input_year_established = '',Input_years_in_business_range = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_Database_USA;
  #uniquename(of)
  %of% := RECORD
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_accounting_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_accounting_expenses_code = (TYPEOF(le.Input_accounting_expenses_code))'','',':accounting_expenses_code')
    #END
 
+    #IF( #TEXT(Input_advertising_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_advertising_expenses_code = (TYPEOF(le.Input_advertising_expenses_code))'','',':advertising_expenses_code')
    #END
 
+    #IF( #TEXT(Input_bus_insurance_expense_code)='' )
      '' 
    #ELSE
        IF( le.Input_bus_insurance_expense_code = (TYPEOF(le.Input_bus_insurance_expense_code))'','',':bus_insurance_expense_code')
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
 
+    #IF( #TEXT(Input_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_company_name = (TYPEOF(le.Input_company_name))'','',':company_name')
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
 
+    #IF( #TEXT(Input_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_county_code = (TYPEOF(le.Input_county_code))'','',':county_code')
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
 
+    #IF( #TEXT(Input_db_cons_age)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_age = (TYPEOF(le.Input_db_cons_age))'','',':db_cons_age')
    #END
 
+    #IF( #TEXT(Input_db_cons_child_near_hs_grad)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_child_near_hs_grad = (TYPEOF(le.Input_db_cons_child_near_hs_grad))'','',':db_cons_child_near_hs_grad')
    #END
 
+    #IF( #TEXT(Input_db_cons_children_present)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_children_present = (TYPEOF(le.Input_db_cons_children_present))'','',':db_cons_children_present')
    #END
 
+    #IF( #TEXT(Input_db_cons_college_graduate)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_college_graduate = (TYPEOF(le.Input_db_cons_college_graduate))'','',':db_cons_college_graduate')
    #END
 
+    #IF( #TEXT(Input_db_cons_credit_card_user)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_credit_card_user = (TYPEOF(le.Input_db_cons_credit_card_user))'','',':db_cons_credit_card_user')
    #END
 
+    #IF( #TEXT(Input_db_cons_date_of_birth_month)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_date_of_birth_month = (TYPEOF(le.Input_db_cons_date_of_birth_month))'','',':db_cons_date_of_birth_month')
    #END
 
+    #IF( #TEXT(Input_db_cons_date_of_birth_year)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_date_of_birth_year = (TYPEOF(le.Input_db_cons_date_of_birth_year))'','',':db_cons_date_of_birth_year')
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
 
+    #IF( #TEXT(Input_db_cons_dnc)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_dnc = (TYPEOF(le.Input_db_cons_dnc))'','',':db_cons_dnc')
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
 
+    #IF( #TEXT(Input_db_cons_dwelling_type)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_dwelling_type = (TYPEOF(le.Input_db_cons_dwelling_type))'','',':db_cons_dwelling_type')
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
 
+    #IF( #TEXT(Input_db_cons_email)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_email = (TYPEOF(le.Input_db_cons_email))'','',':db_cons_email')
    #END
 
+    #IF( #TEXT(Input_db_cons_ethnic_code)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_ethnic_code = (TYPEOF(le.Input_db_cons_ethnic_code))'','',':db_cons_ethnic_code')
    #END
 
+    #IF( #TEXT(Input_db_cons_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_full_name = (TYPEOF(le.Input_db_cons_full_name))'','',':db_cons_full_name')
    #END
 
+    #IF( #TEXT(Input_db_cons_gender)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_gender = (TYPEOF(le.Input_db_cons_gender))'','',':db_cons_gender')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_owner_renter)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_owner_renter = (TYPEOF(le.Input_db_cons_home_owner_renter))'','',':db_cons_home_owner_renter')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_property_type)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_property_type = (TYPEOF(le.Input_db_cons_home_property_type))'','',':db_cons_home_property_type')
    #END
 
+    #IF( #TEXT(Input_db_cons_home_sqft_ranges)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_sqft_ranges = (TYPEOF(le.Input_db_cons_home_sqft_ranges))'','',':db_cons_home_sqft_ranges')
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
 
+    #IF( #TEXT(Input_db_cons_home_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_home_year_built = (TYPEOF(le.Input_db_cons_home_year_built))'','',':db_cons_home_year_built')
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
 
+    #IF( #TEXT(Input_db_cons_intend_purchase_veh)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_intend_purchase_veh = (TYPEOF(le.Input_db_cons_intend_purchase_veh))'','',':db_cons_intend_purchase_veh')
    #END
 
+    #IF( #TEXT(Input_db_cons_language_pref)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_language_pref = (TYPEOF(le.Input_db_cons_language_pref))'','',':db_cons_language_pref')
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
 
+    #IF( #TEXT(Input_db_cons_marital_status)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_marital_status = (TYPEOF(le.Input_db_cons_marital_status))'','',':db_cons_marital_status')
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
 
+    #IF( #TEXT(Input_db_cons_new_parent)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_new_parent = (TYPEOF(le.Input_db_cons_new_parent))'','',':db_cons_new_parent')
    #END
 
+    #IF( #TEXT(Input_db_cons_new_teen_driver)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_new_teen_driver = (TYPEOF(le.Input_db_cons_new_teen_driver))'','',':db_cons_new_teen_driver')
    #END
 
+    #IF( #TEXT(Input_db_cons_newlywed)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_newlywed = (TYPEOF(le.Input_db_cons_newlywed))'','',':db_cons_newlywed')
    #END
 
+    #IF( #TEXT(Input_db_cons_occupation_ind)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_occupation_ind = (TYPEOF(le.Input_db_cons_occupation_ind))'','',':db_cons_occupation_ind')
    #END
 
+    #IF( #TEXT(Input_db_cons_other_pet_owner)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_other_pet_owner = (TYPEOF(le.Input_db_cons_other_pet_owner))'','',':db_cons_other_pet_owner')
    #END
 
+    #IF( #TEXT(Input_db_cons_phone)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_phone = (TYPEOF(le.Input_db_cons_phone))'','',':db_cons_phone')
    #END
 
+    #IF( #TEXT(Input_db_cons_poli_party_ind)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_poli_party_ind = (TYPEOF(le.Input_db_cons_poli_party_ind))'','',':db_cons_poli_party_ind')
    #END
 
+    #IF( #TEXT(Input_db_cons_recent_divorce)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_recent_divorce = (TYPEOF(le.Input_db_cons_recent_divorce))'','',':db_cons_recent_divorce')
    #END
 
+    #IF( #TEXT(Input_db_cons_recent_home_buyer)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_recent_home_buyer = (TYPEOF(le.Input_db_cons_recent_home_buyer))'','',':db_cons_recent_home_buyer')
    #END
 
+    #IF( #TEXT(Input_db_cons_religious_affil)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_religious_affil = (TYPEOF(le.Input_db_cons_religious_affil))'','',':db_cons_religious_affil')
    #END
 
+    #IF( #TEXT(Input_db_cons_scrubbed_phoneable)='' )
      '' 
    #ELSE
        IF( le.Input_db_cons_scrubbed_phoneable = (TYPEOF(le.Input_db_cons_scrubbed_phoneable))'','',':db_cons_scrubbed_phoneable')
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
 
+    #IF( #TEXT(Input_domestic_foreign_owner_flag)='' )
      '' 
    #ELSE
        IF( le.Input_domestic_foreign_owner_flag = (TYPEOF(le.Input_domestic_foreign_owner_flag))'','',':domestic_foreign_owner_flag')
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
 
+    #IF( #TEXT(Input_exec_type)='' )
      '' 
    #ELSE
        IF( le.Input_exec_type = (TYPEOF(le.Input_exec_type))'','',':exec_type')
    #END
 
+    #IF( #TEXT(Input_executive_level)='' )
      '' 
    #ELSE
        IF( le.Input_executive_level = (TYPEOF(le.Input_executive_level))'','',':executive_level')
    #END
 
+    #IF( #TEXT(Input_executive_title_rank)='' )
      '' 
    #ELSE
        IF( le.Input_executive_title_rank = (TYPEOF(le.Input_executive_title_rank))'','',':executive_title_rank')
    #END
 
+    #IF( #TEXT(Input_expense_accounting_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_accounting_desc = (TYPEOF(le.Input_expense_accounting_desc))'','',':expense_accounting_desc')
    #END
 
+    #IF( #TEXT(Input_expense_advertising_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_advertising_desc = (TYPEOF(le.Input_expense_advertising_desc))'','',':expense_advertising_desc')
    #END
 
+    #IF( #TEXT(Input_expense_bus_insurance_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_bus_insurance_desc = (TYPEOF(le.Input_expense_bus_insurance_desc))'','',':expense_bus_insurance_desc')
    #END
 
+    #IF( #TEXT(Input_expense_legal_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_legal_desc = (TYPEOF(le.Input_expense_legal_desc))'','',':expense_legal_desc')
    #END
 
+    #IF( #TEXT(Input_expense_office_equip_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_office_equip_desc = (TYPEOF(le.Input_expense_office_equip_desc))'','',':expense_office_equip_desc')
    #END
 
+    #IF( #TEXT(Input_expense_rent_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_rent_desc = (TYPEOF(le.Input_expense_rent_desc))'','',':expense_rent_desc')
    #END
 
+    #IF( #TEXT(Input_expense_technology_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_technology_desc = (TYPEOF(le.Input_expense_technology_desc))'','',':expense_technology_desc')
    #END
 
+    #IF( #TEXT(Input_expense_telecom_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_telecom_desc = (TYPEOF(le.Input_expense_telecom_desc))'','',':expense_telecom_desc')
    #END
 
+    #IF( #TEXT(Input_expense_utilities_desc)='' )
      '' 
    #ELSE
        IF( le.Input_expense_utilities_desc = (TYPEOF(le.Input_expense_utilities_desc))'','',':expense_utilities_desc')
    #END
 
+    #IF( #TEXT(Input_female_owned)='' )
      '' 
    #ELSE
        IF( le.Input_female_owned = (TYPEOF(le.Input_female_owned))'','',':female_owned')
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
 
+    #IF( #TEXT(Input_full_name)='' )
      '' 
    #ELSE
        IF( le.Input_full_name = (TYPEOF(le.Input_full_name))'','',':full_name')
    #END
 
+    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
 
+    #IF( #TEXT(Input_home_based_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_home_based_indicator = (TYPEOF(le.Input_home_based_indicator))'','',':home_based_indicator')
    #END
 
+    #IF( #TEXT(Input_import_export)='' )
      '' 
    #ELSE
        IF( le.Input_import_export = (TYPEOF(le.Input_import_export))'','',':import_export')
    #END
 
+    #IF( #TEXT(Input_ind_frm_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_ind_frm_indicator = (TYPEOF(le.Input_ind_frm_indicator))'','',':ind_frm_indicator')
    #END
 
+    #IF( #TEXT(Input_legal_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_legal_expenses_code = (TYPEOF(le.Input_legal_expenses_code))'','',':legal_expenses_code')
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
 
+    #IF( #TEXT(Input_mail_score)='' )
      '' 
    #ELSE
        IF( le.Input_mail_score = (TYPEOF(le.Input_mail_score))'','',':mail_score')
    #END
 
+    #IF( #TEXT(Input_manufacturing_location)='' )
      '' 
    #ELSE
        IF( le.Input_manufacturing_location = (TYPEOF(le.Input_manufacturing_location))'','',':manufacturing_location')
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
 
+    #IF( #TEXT(Input_naics01)='' )
      '' 
    #ELSE
        IF( le.Input_naics01 = (TYPEOF(le.Input_naics01))'','',':naics01')
    #END
 
+    #IF( #TEXT(Input_naics02)='' )
      '' 
    #ELSE
        IF( le.Input_naics02 = (TYPEOF(le.Input_naics02))'','',':naics02')
    #END
 
+    #IF( #TEXT(Input_naics03)='' )
      '' 
    #ELSE
        IF( le.Input_naics03 = (TYPEOF(le.Input_naics03))'','',':naics03')
    #END
 
+    #IF( #TEXT(Input_naics04)='' )
      '' 
    #ELSE
        IF( le.Input_naics04 = (TYPEOF(le.Input_naics04))'','',':naics04')
    #END
 
+    #IF( #TEXT(Input_naics05)='' )
      '' 
    #ELSE
        IF( le.Input_naics05 = (TYPEOF(le.Input_naics05))'','',':naics05')
    #END
 
+    #IF( #TEXT(Input_naics06)='' )
      '' 
    #ELSE
        IF( le.Input_naics06 = (TYPEOF(le.Input_naics06))'','',':naics06')
    #END
 
+    #IF( #TEXT(Input_nb_flag)='' )
      '' 
    #ELSE
        IF( le.Input_nb_flag = (TYPEOF(le.Input_nb_flag))'','',':nb_flag')
    #END
 
+    #IF( #TEXT(Input_non_profit_org)='' )
      '' 
    #ELSE
        IF( le.Input_non_profit_org = (TYPEOF(le.Input_non_profit_org))'','',':non_profit_org')
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
 
+    #IF( #TEXT(Input_office_equip_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_office_equip_expenses_code = (TYPEOF(le.Input_office_equip_expenses_code))'','',':office_equip_expenses_code')
    #END
 
+    #IF( #TEXT(Input_phone)='' )
      '' 
    #ELSE
        IF( le.Input_phone = (TYPEOF(le.Input_phone))'','',':phone')
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
 
+    #IF( #TEXT(Input_primary_exec_flag)='' )
      '' 
    #ELSE
        IF( le.Input_primary_exec_flag = (TYPEOF(le.Input_primary_exec_flag))'','',':primary_exec_flag')
    #END
 
+    #IF( #TEXT(Input_primary_sic)='' )
      '' 
    #ELSE
        IF( le.Input_primary_sic = (TYPEOF(le.Input_primary_sic))'','',':primary_sic')
    #END
 
+    #IF( #TEXT(Input_primarysic2)='' )
      '' 
    #ELSE
        IF( le.Input_primarysic2 = (TYPEOF(le.Input_primarysic2))'','',':primarysic2')
    #END
 
+    #IF( #TEXT(Input_primarysic4)='' )
      '' 
    #ELSE
        IF( le.Input_primarysic4 = (TYPEOF(le.Input_primarysic4))'','',':primarysic4')
    #END
 
+    #IF( #TEXT(Input_public_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_public_indicator = (TYPEOF(le.Input_public_indicator))'','',':public_indicator')
    #END
 
+    #IF( #TEXT(Input_rent_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_rent_expenses_code = (TYPEOF(le.Input_rent_expenses_code))'','',':rent_expenses_code')
    #END
 
+    #IF( #TEXT(Input_sic02)='' )
      '' 
    #ELSE
        IF( le.Input_sic02 = (TYPEOF(le.Input_sic02))'','',':sic02')
    #END
 
+    #IF( #TEXT(Input_sic03)='' )
      '' 
    #ELSE
        IF( le.Input_sic03 = (TYPEOF(le.Input_sic03))'','',':sic03')
    #END
 
+    #IF( #TEXT(Input_sic04)='' )
      '' 
    #ELSE
        IF( le.Input_sic04 = (TYPEOF(le.Input_sic04))'','',':sic04')
    #END
 
+    #IF( #TEXT(Input_sic05)='' )
      '' 
    #ELSE
        IF( le.Input_sic05 = (TYPEOF(le.Input_sic05))'','',':sic05')
    #END
 
+    #IF( #TEXT(Input_sic06)='' )
      '' 
    #ELSE
        IF( le.Input_sic06 = (TYPEOF(le.Input_sic06))'','',':sic06')
    #END
 
+    #IF( #TEXT(Input_small_business_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_small_business_indicator = (TYPEOF(le.Input_small_business_indicator))'','',':small_business_indicator')
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
 
+    #IF( #TEXT(Input_standardized_title)='' )
      '' 
    #ELSE
        IF( le.Input_standardized_title = (TYPEOF(le.Input_standardized_title))'','',':standardized_title')
    #END
 
+    #IF( #TEXT(Input_technology_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_technology_expenses_code = (TYPEOF(le.Input_technology_expenses_code))'','',':technology_expenses_code')
    #END
 
+    #IF( #TEXT(Input_telecom_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_telecom_expenses_code = (TYPEOF(le.Input_telecom_expenses_code))'','',':telecom_expenses_code')
    #END
 
+    #IF( #TEXT(Input_url)='' )
      '' 
    #ELSE
        IF( le.Input_url = (TYPEOF(le.Input_url))'','',':url')
    #END
 
+    #IF( #TEXT(Input_utilities_expenses_code)='' )
      '' 
    #ELSE
        IF( le.Input_utilities_expenses_code = (TYPEOF(le.Input_utilities_expenses_code))'','',':utilities_expenses_code')
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
