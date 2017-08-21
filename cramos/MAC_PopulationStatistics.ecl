EXPORT MAC_PopulationStatistics(infile,Ref='',Input_did = '',Input_state_code = '',Input_zip_code = '',Input_zipplus_4 = '',Input_delivery_point_code = '',Input_carrier_route = '',Input_blank_space1 = '',Input_dsf_season_code = '',Input_dsf_delivery_type_code = '',Input_blank_space2 = '',Input_surname = '',Input_primary_given_name = '',Input_primary_middle_initial = '',Input_primary_name_suffix = '',Input_primary_title_code = '',Input_primary_gender = '',Input_secondary_given_name = '',Input_secondary_title_code = '',Input_house_number = '',Input_fraction = '',Input_street_prefix_direction = '',Input_contracted_street_address = '',Input_route_designator_and_number = '',Input_box_designator_and_number = '',Input_secondary_unit_designation = '',Input_post_office_name = '',Input_state_abbreviation = '',Input_county_code = '',Input_phone_suppression_source = '',Input_msas = '',Input_blank_space3 = '',Input_dma = '',Input_nielson_county_size_code = '',Input_area_codeall_available = '',Input_telephoneall_available = '',Input_status_code_of_records = '',Input_addressname_censor_code = '',Input_address_quality_code = '',Input_address_type = '',Input_file_code = '',Input_blank_space4 = '',Input_home_ownerrenter_code = '',Input_advhome_owner = '',Input_advhome_owner_indicator = '',Input_household_type_code = '',Input_marital_status = '',Input_advhousehold_marital_status_indicator = '',Input_blank_space5 = '',Input_dwelling_type = '',Input_advdwelling_type_indicator = '',Input_length_of_residence = '',Input_advlength_of_residence_indicator = '',Input_blank_space6 = '',Input_structure_age_year = '',Input_verification_date_of_household = '',Input_blank_space43 = '',Input_number_of_sources_verifying_household = '',Input_blank_space7 = '',Input_narrow_band_income_predictor = '',Input_estimated_home_income_predictor = '',Input_income_model_indicator = '',Input_niches = '',Input_blank_space8 = '',Input_mail_public_responder_indicator = '',Input_mail_responsive_buyer_indicator = '',Input_mail_responsive_donor_indicator = '',Input_blank_space9 = '',Input_outdoors_dimension_household = '',Input_athletic_dimension_household = '',Input_fitness_dimension_household = '',Input_domestic_dimension_household = '',Input_good_life_dimension_household = '',Input_cultural_dimension_household = '',Input_blue_chip_dimension_household = '',Input_do_it_yourself_dimension_household = '',Input_technology_dimension_household = '',Input_household_occupation = '',Input_blank_space10 = '',Input_combined_market_value_of_all_vehicles = '',Input_number_of_cars_currently_registered_owned = '',Input_body_size_class_of_newest_car_owned = '',Input_truck_owner_code = '',Input_new_vehicle_purchase_code = '',Input_motorcycle_ownership_code = '',Input_recreational_vehicle_ownership_code = '',Input_advhousehold_age = '',Input_age_indicator = '',Input_household_age_code = '',Input_advhousehold_size = '',Input_advhousehold_size_indicator = '',Input_number_of_persons_in_household = '',Input_number_of_adults_in_household = '',Input_advnumber_of_adults_indicator = '',Input_number_of_children_in_household = '',Input_age_unknown_of_adults = '',Input_age_75_years_old_specific = '',Input_age_65to74_year_old_specific = '',Input_age_55to64_year_old_specific = '',Input_age_45to54_year_old_specific = '',Input_age_35to44_year_old_specific = '',Input_age_25to34_year_old_specific = '',Input_age_18to24_year_old_specific = '',Input_presence_of_adults_age_65_inferred = '',Input_age_45to64_year_old_inferred = '',Input_age_35to44_year_old_inferred = '',Input_presence_of_adults_age_under_35_inferred = '',Input_children_age_0_to_2 = '',Input_children_age_3_to_5 = '',Input_children_age_6_to_10 = '',Input_children_age_11_to_15 = '',Input_children_age_16_to_17 = '',Input_children_age_0_to_17_unknown_gender = '',Input_blank_space11 = '',Input_title_code_1 = '',Input_gender_1 = '',Input_age_1 = '',Input_birth_year_1 = '',Input_birth_month_1 = '',Input_given_name_1 = '',Input_middle_initial_1 = '',Input_member_code_of_person_1 = '',Input_title_code_2 = '',Input_gender_2 = '',Input_age_2 = '',Input_birth_year_2 = '',Input_birth_month_2 = '',Input_given_name_2 = '',Input_middle_initial_2 = '',Input_member_code_of_person_2 = '',Input_title_code_3 = '',Input_gender_3 = '',Input_age_3 = '',Input_birth_year_3 = '',Input_birth_month_3 = '',Input_given_name_3 = '',Input_middle_initial_3 = '',Input_member_code_of_person_3 = '',Input_title_code_4 = '',Input_gender_4 = '',Input_age_4 = '',Input_birth_year_4 = '',Input_birth_month_4 = '',Input_given_name_4 = '',Input_middle_initial_4 = '',Input_member_code_of_person_4 = '',Input_title_code_5 = '',Input_gender_5 = '',Input_age_5 = '',Input_birth_year_5 = '',Input_birth_month_5 = '',Input_given_name_5 = '',Input_middle_initial_5 = '',Input_member_code_of_person_5 = '',Input_us_census_tract_identifier_2000 = '',Input_census_tract_suffix = '',Input_block_group_number = '',Input_blank_space12 = '',Input_us_census_state_code_2000 = '',Input_us_census_county_code_2000 = '',Input_record_type = '',Input_smacs_2000_level = '',Input_median_household_income_3_bytes = '',Input_households_with_related_children = '',Input_median_age_of_adults_18_or_older_3_bytes = '',Input_median_school_years_completed_by_adults_25_3_bytes = '',Input_percent_employed_managerial_and_professional = '',Input_managementbusinessfinancial_operations = '',Input_owner_occupied_housing_units = '',Input_percent_in_single_unit_structures = '',Input_median_home_value_4_bytes = '',Input_percent_owner_occupied_structures_built_since_1990 = '',Input_percent_persons_move_in_since_1995 = '',Input_percent_of_motor_vehicle_ownership = '',Input_percent_white = '',Input_blank_space13 = '',Input_cbsa_code = '',Input_blank_space14 = '',Input_credit_card_usage_miscellaneous = '',Input_credit_card_usage_standard_retail = '',Input_credit_card_usage_standard_specialty_card = '',Input_credit_card_usage_upscale_retail = '',Input_credit_card_usage_upscale_spec_retail = '',Input_credit_card_usage_bank_card = '',Input_credit_card_usage_oil__gas_card = '',Input_credit_card_usage_finance_co_card = '',Input_credit_card_usage_travel__entertainment = '',Input_tcc_american_express = '',Input_tcc_any_credit_card = '',Input_tcc_catalog_showroom = '',Input_tcc_computerelectronic = '',Input_tcc_debit_card = '',Input_tcc_furniture = '',Input_tcc_grocery = '',Input_tcc_home_improvement = '',Input_tcc_homeoffice_supply = '',Input_tcc_low_end_department_store = '',Input_tcc_main_street_retail = '',Input_tcc_mastercard = '',Input_tcc_membership_warehouse = '',Input_tcc_specialty_apparel = '',Input_tcc_sporting_goods = '',Input_tcc_tv_mail_order = '',Input_tcc_visa = '',Input_responder_education_code_1 = '',Input_responder_education_code_2 = '',Input_responder_education_code_3 = '',Input_responder_education_code_4 = '',Input_spouse_education_code_1 = '',Input_spouse_education_code_2 = '',Input_spouse_education_code_3 = '',Input_spouse_education_code_4 = '',Input_advhousehold_education = '',Input_advhousehold_education_indicator = '',Input_household_income_identifier = '',Input_narrow_band_household_income_identifier = '',Input_income_model_indicator2 = '',Input_lf = '',Input_title = '',Input_fname = '',Input_mname = '',Input_lname = '',Input_name_suffix = '',Input_name_score = '',Input_prim_range = '',Input_predir = '',Input_prim_name = '',Input_addr_suffix = '',Input_postdir = '',Input_unit_desig = '',Input_sec_range = '',Input_p_city_name = '',Input_v_city_name = '',Input_st = '',Input_zip = '',Input_zip4 = '',Input_cart = '',Input_cr_sort_sz = '',Input_lot = '',Input_lot_order = '',Input_dpbc = '',Input_chk_digit = '',Input_rec_type = '',Input_ace_fips_st = '',Input_fips_county = '',Input_geo_lat = '',Input_geo_long = '',Input_msa = '',Input_geo_match = '',Input_err_stat = '',Input_telephone = '',Input_gender = '',Input_age = '',Input_birth_year = '',Input_birth_month = '',Input_member_code_of_person = '',Input_household_member_cnt = '',OutFile) := MACRO
  IMPORT SALT26,CDKelly;
  #uniquename(of)
  %of% := RECORD
    SALT26.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_did)='' )
      '' 
    #ELSE
        IF( le.Input_did = (TYPEOF(le.Input_did))'','',':did')
    #END
+
    #IF( #TEXT(Input_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_state_code = (TYPEOF(le.Input_state_code))'','',':state_code')
    #END
+
    #IF( #TEXT(Input_zip_code)='' )
      '' 
    #ELSE
        IF( le.Input_zip_code = (TYPEOF(le.Input_zip_code))'','',':zip_code')
    #END
+
    #IF( #TEXT(Input_zipplus_4)='' )
      '' 
    #ELSE
        IF( le.Input_zipplus_4 = (TYPEOF(le.Input_zipplus_4))'','',':zipplus_4')
    #END
+
    #IF( #TEXT(Input_delivery_point_code)='' )
      '' 
    #ELSE
        IF( le.Input_delivery_point_code = (TYPEOF(le.Input_delivery_point_code))'','',':delivery_point_code')
    #END
+
    #IF( #TEXT(Input_carrier_route)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_route = (TYPEOF(le.Input_carrier_route))'','',':carrier_route')
    #END
+
    #IF( #TEXT(Input_blank_space1)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space1 = (TYPEOF(le.Input_blank_space1))'','',':blank_space1')
    #END
+
    #IF( #TEXT(Input_dsf_season_code)='' )
      '' 
    #ELSE
        IF( le.Input_dsf_season_code = (TYPEOF(le.Input_dsf_season_code))'','',':dsf_season_code')
    #END
+
    #IF( #TEXT(Input_dsf_delivery_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_dsf_delivery_type_code = (TYPEOF(le.Input_dsf_delivery_type_code))'','',':dsf_delivery_type_code')
    #END
+
    #IF( #TEXT(Input_blank_space2)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space2 = (TYPEOF(le.Input_blank_space2))'','',':blank_space2')
    #END
+
    #IF( #TEXT(Input_surname)='' )
      '' 
    #ELSE
        IF( le.Input_surname = (TYPEOF(le.Input_surname))'','',':surname')
    #END
+
    #IF( #TEXT(Input_primary_given_name)='' )
      '' 
    #ELSE
        IF( le.Input_primary_given_name = (TYPEOF(le.Input_primary_given_name))'','',':primary_given_name')
    #END
+
    #IF( #TEXT(Input_primary_middle_initial)='' )
      '' 
    #ELSE
        IF( le.Input_primary_middle_initial = (TYPEOF(le.Input_primary_middle_initial))'','',':primary_middle_initial')
    #END
+
    #IF( #TEXT(Input_primary_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_primary_name_suffix = (TYPEOF(le.Input_primary_name_suffix))'','',':primary_name_suffix')
    #END
+
    #IF( #TEXT(Input_primary_title_code)='' )
      '' 
    #ELSE
        IF( le.Input_primary_title_code = (TYPEOF(le.Input_primary_title_code))'','',':primary_title_code')
    #END
+
    #IF( #TEXT(Input_primary_gender)='' )
      '' 
    #ELSE
        IF( le.Input_primary_gender = (TYPEOF(le.Input_primary_gender))'','',':primary_gender')
    #END
+
    #IF( #TEXT(Input_secondary_given_name)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_given_name = (TYPEOF(le.Input_secondary_given_name))'','',':secondary_given_name')
    #END
+
    #IF( #TEXT(Input_secondary_title_code)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_title_code = (TYPEOF(le.Input_secondary_title_code))'','',':secondary_title_code')
    #END
+
    #IF( #TEXT(Input_house_number)='' )
      '' 
    #ELSE
        IF( le.Input_house_number = (TYPEOF(le.Input_house_number))'','',':house_number')
    #END
+
    #IF( #TEXT(Input_fraction)='' )
      '' 
    #ELSE
        IF( le.Input_fraction = (TYPEOF(le.Input_fraction))'','',':fraction')
    #END
+
    #IF( #TEXT(Input_street_prefix_direction)='' )
      '' 
    #ELSE
        IF( le.Input_street_prefix_direction = (TYPEOF(le.Input_street_prefix_direction))'','',':street_prefix_direction')
    #END
+
    #IF( #TEXT(Input_contracted_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_contracted_street_address = (TYPEOF(le.Input_contracted_street_address))'','',':contracted_street_address')
    #END
+
    #IF( #TEXT(Input_route_designator_and_number)='' )
      '' 
    #ELSE
        IF( le.Input_route_designator_and_number = (TYPEOF(le.Input_route_designator_and_number))'','',':route_designator_and_number')
    #END
+
    #IF( #TEXT(Input_box_designator_and_number)='' )
      '' 
    #ELSE
        IF( le.Input_box_designator_and_number = (TYPEOF(le.Input_box_designator_and_number))'','',':box_designator_and_number')
    #END
+
    #IF( #TEXT(Input_secondary_unit_designation)='' )
      '' 
    #ELSE
        IF( le.Input_secondary_unit_designation = (TYPEOF(le.Input_secondary_unit_designation))'','',':secondary_unit_designation')
    #END
+
    #IF( #TEXT(Input_post_office_name)='' )
      '' 
    #ELSE
        IF( le.Input_post_office_name = (TYPEOF(le.Input_post_office_name))'','',':post_office_name')
    #END
+
    #IF( #TEXT(Input_state_abbreviation)='' )
      '' 
    #ELSE
        IF( le.Input_state_abbreviation = (TYPEOF(le.Input_state_abbreviation))'','',':state_abbreviation')
    #END
+
    #IF( #TEXT(Input_county_code)='' )
      '' 
    #ELSE
        IF( le.Input_county_code = (TYPEOF(le.Input_county_code))'','',':county_code')
    #END
+
    #IF( #TEXT(Input_phone_suppression_source)='' )
      '' 
    #ELSE
        IF( le.Input_phone_suppression_source = (TYPEOF(le.Input_phone_suppression_source))'','',':phone_suppression_source')
    #END
+
    #IF( #TEXT(Input_msas)='' )
      '' 
    #ELSE
        IF( le.Input_msas = (TYPEOF(le.Input_msas))'','',':msas')
    #END
+
    #IF( #TEXT(Input_blank_space3)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space3 = (TYPEOF(le.Input_blank_space3))'','',':blank_space3')
    #END
+
    #IF( #TEXT(Input_dma)='' )
      '' 
    #ELSE
        IF( le.Input_dma = (TYPEOF(le.Input_dma))'','',':dma')
    #END
+
    #IF( #TEXT(Input_nielson_county_size_code)='' )
      '' 
    #ELSE
        IF( le.Input_nielson_county_size_code = (TYPEOF(le.Input_nielson_county_size_code))'','',':nielson_county_size_code')
    #END
+
    #IF( #TEXT(Input_area_codeall_available)='' )
      '' 
    #ELSE
        IF( le.Input_area_codeall_available = (TYPEOF(le.Input_area_codeall_available))'','',':area_codeall_available')
    #END
+
    #IF( #TEXT(Input_telephoneall_available)='' )
      '' 
    #ELSE
        IF( le.Input_telephoneall_available = (TYPEOF(le.Input_telephoneall_available))'','',':telephoneall_available')
    #END
+
    #IF( #TEXT(Input_status_code_of_records)='' )
      '' 
    #ELSE
        IF( le.Input_status_code_of_records = (TYPEOF(le.Input_status_code_of_records))'','',':status_code_of_records')
    #END
+
    #IF( #TEXT(Input_addressname_censor_code)='' )
      '' 
    #ELSE
        IF( le.Input_addressname_censor_code = (TYPEOF(le.Input_addressname_censor_code))'','',':addressname_censor_code')
    #END
+
    #IF( #TEXT(Input_address_quality_code)='' )
      '' 
    #ELSE
        IF( le.Input_address_quality_code = (TYPEOF(le.Input_address_quality_code))'','',':address_quality_code')
    #END
+
    #IF( #TEXT(Input_address_type)='' )
      '' 
    #ELSE
        IF( le.Input_address_type = (TYPEOF(le.Input_address_type))'','',':address_type')
    #END
+
    #IF( #TEXT(Input_file_code)='' )
      '' 
    #ELSE
        IF( le.Input_file_code = (TYPEOF(le.Input_file_code))'','',':file_code')
    #END
+
    #IF( #TEXT(Input_blank_space4)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space4 = (TYPEOF(le.Input_blank_space4))'','',':blank_space4')
    #END
+
    #IF( #TEXT(Input_home_ownerrenter_code)='' )
      '' 
    #ELSE
        IF( le.Input_home_ownerrenter_code = (TYPEOF(le.Input_home_ownerrenter_code))'','',':home_ownerrenter_code')
    #END
+
    #IF( #TEXT(Input_advhome_owner)='' )
      '' 
    #ELSE
        IF( le.Input_advhome_owner = (TYPEOF(le.Input_advhome_owner))'','',':advhome_owner')
    #END
+
    #IF( #TEXT(Input_advhome_owner_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_advhome_owner_indicator = (TYPEOF(le.Input_advhome_owner_indicator))'','',':advhome_owner_indicator')
    #END
+
    #IF( #TEXT(Input_household_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_household_type_code = (TYPEOF(le.Input_household_type_code))'','',':household_type_code')
    #END
+
    #IF( #TEXT(Input_marital_status)='' )
      '' 
    #ELSE
        IF( le.Input_marital_status = (TYPEOF(le.Input_marital_status))'','',':marital_status')
    #END
+
    #IF( #TEXT(Input_advhousehold_marital_status_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_advhousehold_marital_status_indicator = (TYPEOF(le.Input_advhousehold_marital_status_indicator))'','',':advhousehold_marital_status_indicator')
    #END
+
    #IF( #TEXT(Input_blank_space5)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space5 = (TYPEOF(le.Input_blank_space5))'','',':blank_space5')
    #END
+
    #IF( #TEXT(Input_dwelling_type)='' )
      '' 
    #ELSE
        IF( le.Input_dwelling_type = (TYPEOF(le.Input_dwelling_type))'','',':dwelling_type')
    #END
+
    #IF( #TEXT(Input_advdwelling_type_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_advdwelling_type_indicator = (TYPEOF(le.Input_advdwelling_type_indicator))'','',':advdwelling_type_indicator')
    #END
+
    #IF( #TEXT(Input_length_of_residence)='' )
      '' 
    #ELSE
        IF( le.Input_length_of_residence = (TYPEOF(le.Input_length_of_residence))'','',':length_of_residence')
    #END
+
    #IF( #TEXT(Input_advlength_of_residence_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_advlength_of_residence_indicator = (TYPEOF(le.Input_advlength_of_residence_indicator))'','',':advlength_of_residence_indicator')
    #END
+
    #IF( #TEXT(Input_blank_space6)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space6 = (TYPEOF(le.Input_blank_space6))'','',':blank_space6')
    #END
+
    #IF( #TEXT(Input_structure_age_year)='' )
      '' 
    #ELSE
        IF( le.Input_structure_age_year = (TYPEOF(le.Input_structure_age_year))'','',':structure_age_year')
    #END
+
    #IF( #TEXT(Input_verification_date_of_household)='' )
      '' 
    #ELSE
        IF( le.Input_verification_date_of_household = (TYPEOF(le.Input_verification_date_of_household))'','',':verification_date_of_household')
    #END
+
    #IF( #TEXT(Input_blank_space43)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space43 = (TYPEOF(le.Input_blank_space43))'','',':blank_space43')
    #END
+
    #IF( #TEXT(Input_number_of_sources_verifying_household)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_sources_verifying_household = (TYPEOF(le.Input_number_of_sources_verifying_household))'','',':number_of_sources_verifying_household')
    #END
+
    #IF( #TEXT(Input_blank_space7)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space7 = (TYPEOF(le.Input_blank_space7))'','',':blank_space7')
    #END
+
    #IF( #TEXT(Input_narrow_band_income_predictor)='' )
      '' 
    #ELSE
        IF( le.Input_narrow_band_income_predictor = (TYPEOF(le.Input_narrow_band_income_predictor))'','',':narrow_band_income_predictor')
    #END
+
    #IF( #TEXT(Input_estimated_home_income_predictor)='' )
      '' 
    #ELSE
        IF( le.Input_estimated_home_income_predictor = (TYPEOF(le.Input_estimated_home_income_predictor))'','',':estimated_home_income_predictor')
    #END
+
    #IF( #TEXT(Input_income_model_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_income_model_indicator = (TYPEOF(le.Input_income_model_indicator))'','',':income_model_indicator')
    #END
+
    #IF( #TEXT(Input_niches)='' )
      '' 
    #ELSE
        IF( le.Input_niches = (TYPEOF(le.Input_niches))'','',':niches')
    #END
+
    #IF( #TEXT(Input_blank_space8)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space8 = (TYPEOF(le.Input_blank_space8))'','',':blank_space8')
    #END
+
    #IF( #TEXT(Input_mail_public_responder_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_mail_public_responder_indicator = (TYPEOF(le.Input_mail_public_responder_indicator))'','',':mail_public_responder_indicator')
    #END
+
    #IF( #TEXT(Input_mail_responsive_buyer_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_mail_responsive_buyer_indicator = (TYPEOF(le.Input_mail_responsive_buyer_indicator))'','',':mail_responsive_buyer_indicator')
    #END
+
    #IF( #TEXT(Input_mail_responsive_donor_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_mail_responsive_donor_indicator = (TYPEOF(le.Input_mail_responsive_donor_indicator))'','',':mail_responsive_donor_indicator')
    #END
+
    #IF( #TEXT(Input_blank_space9)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space9 = (TYPEOF(le.Input_blank_space9))'','',':blank_space9')
    #END
+
    #IF( #TEXT(Input_outdoors_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_outdoors_dimension_household = (TYPEOF(le.Input_outdoors_dimension_household))'','',':outdoors_dimension_household')
    #END
+
    #IF( #TEXT(Input_athletic_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_athletic_dimension_household = (TYPEOF(le.Input_athletic_dimension_household))'','',':athletic_dimension_household')
    #END
+
    #IF( #TEXT(Input_fitness_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_fitness_dimension_household = (TYPEOF(le.Input_fitness_dimension_household))'','',':fitness_dimension_household')
    #END
+
    #IF( #TEXT(Input_domestic_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_domestic_dimension_household = (TYPEOF(le.Input_domestic_dimension_household))'','',':domestic_dimension_household')
    #END
+
    #IF( #TEXT(Input_good_life_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_good_life_dimension_household = (TYPEOF(le.Input_good_life_dimension_household))'','',':good_life_dimension_household')
    #END
+
    #IF( #TEXT(Input_cultural_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_cultural_dimension_household = (TYPEOF(le.Input_cultural_dimension_household))'','',':cultural_dimension_household')
    #END
+
    #IF( #TEXT(Input_blue_chip_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_blue_chip_dimension_household = (TYPEOF(le.Input_blue_chip_dimension_household))'','',':blue_chip_dimension_household')
    #END
+
    #IF( #TEXT(Input_do_it_yourself_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_do_it_yourself_dimension_household = (TYPEOF(le.Input_do_it_yourself_dimension_household))'','',':do_it_yourself_dimension_household')
    #END
+
    #IF( #TEXT(Input_technology_dimension_household)='' )
      '' 
    #ELSE
        IF( le.Input_technology_dimension_household = (TYPEOF(le.Input_technology_dimension_household))'','',':technology_dimension_household')
    #END
+
    #IF( #TEXT(Input_household_occupation)='' )
      '' 
    #ELSE
        IF( le.Input_household_occupation = (TYPEOF(le.Input_household_occupation))'','',':household_occupation')
    #END
+
    #IF( #TEXT(Input_blank_space10)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space10 = (TYPEOF(le.Input_blank_space10))'','',':blank_space10')
    #END
+
    #IF( #TEXT(Input_combined_market_value_of_all_vehicles)='' )
      '' 
    #ELSE
        IF( le.Input_combined_market_value_of_all_vehicles = (TYPEOF(le.Input_combined_market_value_of_all_vehicles))'','',':combined_market_value_of_all_vehicles')
    #END
+
    #IF( #TEXT(Input_number_of_cars_currently_registered_owned)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_cars_currently_registered_owned = (TYPEOF(le.Input_number_of_cars_currently_registered_owned))'','',':number_of_cars_currently_registered_owned')
    #END
+
    #IF( #TEXT(Input_body_size_class_of_newest_car_owned)='' )
      '' 
    #ELSE
        IF( le.Input_body_size_class_of_newest_car_owned = (TYPEOF(le.Input_body_size_class_of_newest_car_owned))'','',':body_size_class_of_newest_car_owned')
    #END
+
    #IF( #TEXT(Input_truck_owner_code)='' )
      '' 
    #ELSE
        IF( le.Input_truck_owner_code = (TYPEOF(le.Input_truck_owner_code))'','',':truck_owner_code')
    #END
+
    #IF( #TEXT(Input_new_vehicle_purchase_code)='' )
      '' 
    #ELSE
        IF( le.Input_new_vehicle_purchase_code = (TYPEOF(le.Input_new_vehicle_purchase_code))'','',':new_vehicle_purchase_code')
    #END
+
    #IF( #TEXT(Input_motorcycle_ownership_code)='' )
      '' 
    #ELSE
        IF( le.Input_motorcycle_ownership_code = (TYPEOF(le.Input_motorcycle_ownership_code))'','',':motorcycle_ownership_code')
    #END
+
    #IF( #TEXT(Input_recreational_vehicle_ownership_code)='' )
      '' 
    #ELSE
        IF( le.Input_recreational_vehicle_ownership_code = (TYPEOF(le.Input_recreational_vehicle_ownership_code))'','',':recreational_vehicle_ownership_code')
    #END
+
    #IF( #TEXT(Input_advhousehold_age)='' )
      '' 
    #ELSE
        IF( le.Input_advhousehold_age = (TYPEOF(le.Input_advhousehold_age))'','',':advhousehold_age')
    #END
+
    #IF( #TEXT(Input_age_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_age_indicator = (TYPEOF(le.Input_age_indicator))'','',':age_indicator')
    #END
+
    #IF( #TEXT(Input_household_age_code)='' )
      '' 
    #ELSE
        IF( le.Input_household_age_code = (TYPEOF(le.Input_household_age_code))'','',':household_age_code')
    #END
+
    #IF( #TEXT(Input_advhousehold_size)='' )
      '' 
    #ELSE
        IF( le.Input_advhousehold_size = (TYPEOF(le.Input_advhousehold_size))'','',':advhousehold_size')
    #END
+
    #IF( #TEXT(Input_advhousehold_size_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_advhousehold_size_indicator = (TYPEOF(le.Input_advhousehold_size_indicator))'','',':advhousehold_size_indicator')
    #END
+
    #IF( #TEXT(Input_number_of_persons_in_household)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_persons_in_household = (TYPEOF(le.Input_number_of_persons_in_household))'','',':number_of_persons_in_household')
    #END
+
    #IF( #TEXT(Input_number_of_adults_in_household)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_adults_in_household = (TYPEOF(le.Input_number_of_adults_in_household))'','',':number_of_adults_in_household')
    #END
+
    #IF( #TEXT(Input_advnumber_of_adults_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_advnumber_of_adults_indicator = (TYPEOF(le.Input_advnumber_of_adults_indicator))'','',':advnumber_of_adults_indicator')
    #END
+
    #IF( #TEXT(Input_number_of_children_in_household)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_children_in_household = (TYPEOF(le.Input_number_of_children_in_household))'','',':number_of_children_in_household')
    #END
+
    #IF( #TEXT(Input_age_unknown_of_adults)='' )
      '' 
    #ELSE
        IF( le.Input_age_unknown_of_adults = (TYPEOF(le.Input_age_unknown_of_adults))'','',':age_unknown_of_adults')
    #END
+
    #IF( #TEXT(Input_age_75_years_old_specific)='' )
      '' 
    #ELSE
        IF( le.Input_age_75_years_old_specific = (TYPEOF(le.Input_age_75_years_old_specific))'','',':age_75_years_old_specific')
    #END
+
    #IF( #TEXT(Input_age_65to74_year_old_specific)='' )
      '' 
    #ELSE
        IF( le.Input_age_65to74_year_old_specific = (TYPEOF(le.Input_age_65to74_year_old_specific))'','',':age_65to74_year_old_specific')
    #END
+
    #IF( #TEXT(Input_age_55to64_year_old_specific)='' )
      '' 
    #ELSE
        IF( le.Input_age_55to64_year_old_specific = (TYPEOF(le.Input_age_55to64_year_old_specific))'','',':age_55to64_year_old_specific')
    #END
+
    #IF( #TEXT(Input_age_45to54_year_old_specific)='' )
      '' 
    #ELSE
        IF( le.Input_age_45to54_year_old_specific = (TYPEOF(le.Input_age_45to54_year_old_specific))'','',':age_45to54_year_old_specific')
    #END
+
    #IF( #TEXT(Input_age_35to44_year_old_specific)='' )
      '' 
    #ELSE
        IF( le.Input_age_35to44_year_old_specific = (TYPEOF(le.Input_age_35to44_year_old_specific))'','',':age_35to44_year_old_specific')
    #END
+
    #IF( #TEXT(Input_age_25to34_year_old_specific)='' )
      '' 
    #ELSE
        IF( le.Input_age_25to34_year_old_specific = (TYPEOF(le.Input_age_25to34_year_old_specific))'','',':age_25to34_year_old_specific')
    #END
+
    #IF( #TEXT(Input_age_18to24_year_old_specific)='' )
      '' 
    #ELSE
        IF( le.Input_age_18to24_year_old_specific = (TYPEOF(le.Input_age_18to24_year_old_specific))'','',':age_18to24_year_old_specific')
    #END
+
    #IF( #TEXT(Input_presence_of_adults_age_65_inferred)='' )
      '' 
    #ELSE
        IF( le.Input_presence_of_adults_age_65_inferred = (TYPEOF(le.Input_presence_of_adults_age_65_inferred))'','',':presence_of_adults_age_65_inferred')
    #END
+
    #IF( #TEXT(Input_age_45to64_year_old_inferred)='' )
      '' 
    #ELSE
        IF( le.Input_age_45to64_year_old_inferred = (TYPEOF(le.Input_age_45to64_year_old_inferred))'','',':age_45to64_year_old_inferred')
    #END
+
    #IF( #TEXT(Input_age_35to44_year_old_inferred)='' )
      '' 
    #ELSE
        IF( le.Input_age_35to44_year_old_inferred = (TYPEOF(le.Input_age_35to44_year_old_inferred))'','',':age_35to44_year_old_inferred')
    #END
+
    #IF( #TEXT(Input_presence_of_adults_age_under_35_inferred)='' )
      '' 
    #ELSE
        IF( le.Input_presence_of_adults_age_under_35_inferred = (TYPEOF(le.Input_presence_of_adults_age_under_35_inferred))'','',':presence_of_adults_age_under_35_inferred')
    #END
+
    #IF( #TEXT(Input_children_age_0_to_2)='' )
      '' 
    #ELSE
        IF( le.Input_children_age_0_to_2 = (TYPEOF(le.Input_children_age_0_to_2))'','',':children_age_0_to_2')
    #END
+
    #IF( #TEXT(Input_children_age_3_to_5)='' )
      '' 
    #ELSE
        IF( le.Input_children_age_3_to_5 = (TYPEOF(le.Input_children_age_3_to_5))'','',':children_age_3_to_5')
    #END
+
    #IF( #TEXT(Input_children_age_6_to_10)='' )
      '' 
    #ELSE
        IF( le.Input_children_age_6_to_10 = (TYPEOF(le.Input_children_age_6_to_10))'','',':children_age_6_to_10')
    #END
+
    #IF( #TEXT(Input_children_age_11_to_15)='' )
      '' 
    #ELSE
        IF( le.Input_children_age_11_to_15 = (TYPEOF(le.Input_children_age_11_to_15))'','',':children_age_11_to_15')
    #END
+
    #IF( #TEXT(Input_children_age_16_to_17)='' )
      '' 
    #ELSE
        IF( le.Input_children_age_16_to_17 = (TYPEOF(le.Input_children_age_16_to_17))'','',':children_age_16_to_17')
    #END
+
    #IF( #TEXT(Input_children_age_0_to_17_unknown_gender)='' )
      '' 
    #ELSE
        IF( le.Input_children_age_0_to_17_unknown_gender = (TYPEOF(le.Input_children_age_0_to_17_unknown_gender))'','',':children_age_0_to_17_unknown_gender')
    #END
+
    #IF( #TEXT(Input_blank_space11)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space11 = (TYPEOF(le.Input_blank_space11))'','',':blank_space11')
    #END
+
    #IF( #TEXT(Input_title_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_1 = (TYPEOF(le.Input_title_code_1))'','',':title_code_1')
    #END
+
    #IF( #TEXT(Input_gender_1)='' )
      '' 
    #ELSE
        IF( le.Input_gender_1 = (TYPEOF(le.Input_gender_1))'','',':gender_1')
    #END
+
    #IF( #TEXT(Input_age_1)='' )
      '' 
    #ELSE
        IF( le.Input_age_1 = (TYPEOF(le.Input_age_1))'','',':age_1')
    #END
+
    #IF( #TEXT(Input_birth_year_1)='' )
      '' 
    #ELSE
        IF( le.Input_birth_year_1 = (TYPEOF(le.Input_birth_year_1))'','',':birth_year_1')
    #END
+
    #IF( #TEXT(Input_birth_month_1)='' )
      '' 
    #ELSE
        IF( le.Input_birth_month_1 = (TYPEOF(le.Input_birth_month_1))'','',':birth_month_1')
    #END
+
    #IF( #TEXT(Input_given_name_1)='' )
      '' 
    #ELSE
        IF( le.Input_given_name_1 = (TYPEOF(le.Input_given_name_1))'','',':given_name_1')
    #END
+
    #IF( #TEXT(Input_middle_initial_1)='' )
      '' 
    #ELSE
        IF( le.Input_middle_initial_1 = (TYPEOF(le.Input_middle_initial_1))'','',':middle_initial_1')
    #END
+
    #IF( #TEXT(Input_member_code_of_person_1)='' )
      '' 
    #ELSE
        IF( le.Input_member_code_of_person_1 = (TYPEOF(le.Input_member_code_of_person_1))'','',':member_code_of_person_1')
    #END
+
    #IF( #TEXT(Input_title_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_2 = (TYPEOF(le.Input_title_code_2))'','',':title_code_2')
    #END
+
    #IF( #TEXT(Input_gender_2)='' )
      '' 
    #ELSE
        IF( le.Input_gender_2 = (TYPEOF(le.Input_gender_2))'','',':gender_2')
    #END
+
    #IF( #TEXT(Input_age_2)='' )
      '' 
    #ELSE
        IF( le.Input_age_2 = (TYPEOF(le.Input_age_2))'','',':age_2')
    #END
+
    #IF( #TEXT(Input_birth_year_2)='' )
      '' 
    #ELSE
        IF( le.Input_birth_year_2 = (TYPEOF(le.Input_birth_year_2))'','',':birth_year_2')
    #END
+
    #IF( #TEXT(Input_birth_month_2)='' )
      '' 
    #ELSE
        IF( le.Input_birth_month_2 = (TYPEOF(le.Input_birth_month_2))'','',':birth_month_2')
    #END
+
    #IF( #TEXT(Input_given_name_2)='' )
      '' 
    #ELSE
        IF( le.Input_given_name_2 = (TYPEOF(le.Input_given_name_2))'','',':given_name_2')
    #END
+
    #IF( #TEXT(Input_middle_initial_2)='' )
      '' 
    #ELSE
        IF( le.Input_middle_initial_2 = (TYPEOF(le.Input_middle_initial_2))'','',':middle_initial_2')
    #END
+
    #IF( #TEXT(Input_member_code_of_person_2)='' )
      '' 
    #ELSE
        IF( le.Input_member_code_of_person_2 = (TYPEOF(le.Input_member_code_of_person_2))'','',':member_code_of_person_2')
    #END
+
    #IF( #TEXT(Input_title_code_3)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_3 = (TYPEOF(le.Input_title_code_3))'','',':title_code_3')
    #END
+
    #IF( #TEXT(Input_gender_3)='' )
      '' 
    #ELSE
        IF( le.Input_gender_3 = (TYPEOF(le.Input_gender_3))'','',':gender_3')
    #END
+
    #IF( #TEXT(Input_age_3)='' )
      '' 
    #ELSE
        IF( le.Input_age_3 = (TYPEOF(le.Input_age_3))'','',':age_3')
    #END
+
    #IF( #TEXT(Input_birth_year_3)='' )
      '' 
    #ELSE
        IF( le.Input_birth_year_3 = (TYPEOF(le.Input_birth_year_3))'','',':birth_year_3')
    #END
+
    #IF( #TEXT(Input_birth_month_3)='' )
      '' 
    #ELSE
        IF( le.Input_birth_month_3 = (TYPEOF(le.Input_birth_month_3))'','',':birth_month_3')
    #END
+
    #IF( #TEXT(Input_given_name_3)='' )
      '' 
    #ELSE
        IF( le.Input_given_name_3 = (TYPEOF(le.Input_given_name_3))'','',':given_name_3')
    #END
+
    #IF( #TEXT(Input_middle_initial_3)='' )
      '' 
    #ELSE
        IF( le.Input_middle_initial_3 = (TYPEOF(le.Input_middle_initial_3))'','',':middle_initial_3')
    #END
+
    #IF( #TEXT(Input_member_code_of_person_3)='' )
      '' 
    #ELSE
        IF( le.Input_member_code_of_person_3 = (TYPEOF(le.Input_member_code_of_person_3))'','',':member_code_of_person_3')
    #END
+
    #IF( #TEXT(Input_title_code_4)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_4 = (TYPEOF(le.Input_title_code_4))'','',':title_code_4')
    #END
+
    #IF( #TEXT(Input_gender_4)='' )
      '' 
    #ELSE
        IF( le.Input_gender_4 = (TYPEOF(le.Input_gender_4))'','',':gender_4')
    #END
+
    #IF( #TEXT(Input_age_4)='' )
      '' 
    #ELSE
        IF( le.Input_age_4 = (TYPEOF(le.Input_age_4))'','',':age_4')
    #END
+
    #IF( #TEXT(Input_birth_year_4)='' )
      '' 
    #ELSE
        IF( le.Input_birth_year_4 = (TYPEOF(le.Input_birth_year_4))'','',':birth_year_4')
    #END
+
    #IF( #TEXT(Input_birth_month_4)='' )
      '' 
    #ELSE
        IF( le.Input_birth_month_4 = (TYPEOF(le.Input_birth_month_4))'','',':birth_month_4')
    #END
+
    #IF( #TEXT(Input_given_name_4)='' )
      '' 
    #ELSE
        IF( le.Input_given_name_4 = (TYPEOF(le.Input_given_name_4))'','',':given_name_4')
    #END
+
    #IF( #TEXT(Input_middle_initial_4)='' )
      '' 
    #ELSE
        IF( le.Input_middle_initial_4 = (TYPEOF(le.Input_middle_initial_4))'','',':middle_initial_4')
    #END
+
    #IF( #TEXT(Input_member_code_of_person_4)='' )
      '' 
    #ELSE
        IF( le.Input_member_code_of_person_4 = (TYPEOF(le.Input_member_code_of_person_4))'','',':member_code_of_person_4')
    #END
+
    #IF( #TEXT(Input_title_code_5)='' )
      '' 
    #ELSE
        IF( le.Input_title_code_5 = (TYPEOF(le.Input_title_code_5))'','',':title_code_5')
    #END
+
    #IF( #TEXT(Input_gender_5)='' )
      '' 
    #ELSE
        IF( le.Input_gender_5 = (TYPEOF(le.Input_gender_5))'','',':gender_5')
    #END
+
    #IF( #TEXT(Input_age_5)='' )
      '' 
    #ELSE
        IF( le.Input_age_5 = (TYPEOF(le.Input_age_5))'','',':age_5')
    #END
+
    #IF( #TEXT(Input_birth_year_5)='' )
      '' 
    #ELSE
        IF( le.Input_birth_year_5 = (TYPEOF(le.Input_birth_year_5))'','',':birth_year_5')
    #END
+
    #IF( #TEXT(Input_birth_month_5)='' )
      '' 
    #ELSE
        IF( le.Input_birth_month_5 = (TYPEOF(le.Input_birth_month_5))'','',':birth_month_5')
    #END
+
    #IF( #TEXT(Input_given_name_5)='' )
      '' 
    #ELSE
        IF( le.Input_given_name_5 = (TYPEOF(le.Input_given_name_5))'','',':given_name_5')
    #END
+
    #IF( #TEXT(Input_middle_initial_5)='' )
      '' 
    #ELSE
        IF( le.Input_middle_initial_5 = (TYPEOF(le.Input_middle_initial_5))'','',':middle_initial_5')
    #END
+
    #IF( #TEXT(Input_member_code_of_person_5)='' )
      '' 
    #ELSE
        IF( le.Input_member_code_of_person_5 = (TYPEOF(le.Input_member_code_of_person_5))'','',':member_code_of_person_5')
    #END
+
    #IF( #TEXT(Input_us_census_tract_identifier_2000)='' )
      '' 
    #ELSE
        IF( le.Input_us_census_tract_identifier_2000 = (TYPEOF(le.Input_us_census_tract_identifier_2000))'','',':us_census_tract_identifier_2000')
    #END
+
    #IF( #TEXT(Input_census_tract_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_census_tract_suffix = (TYPEOF(le.Input_census_tract_suffix))'','',':census_tract_suffix')
    #END
+
    #IF( #TEXT(Input_block_group_number)='' )
      '' 
    #ELSE
        IF( le.Input_block_group_number = (TYPEOF(le.Input_block_group_number))'','',':block_group_number')
    #END
+
    #IF( #TEXT(Input_blank_space12)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space12 = (TYPEOF(le.Input_blank_space12))'','',':blank_space12')
    #END
+
    #IF( #TEXT(Input_us_census_state_code_2000)='' )
      '' 
    #ELSE
        IF( le.Input_us_census_state_code_2000 = (TYPEOF(le.Input_us_census_state_code_2000))'','',':us_census_state_code_2000')
    #END
+
    #IF( #TEXT(Input_us_census_county_code_2000)='' )
      '' 
    #ELSE
        IF( le.Input_us_census_county_code_2000 = (TYPEOF(le.Input_us_census_county_code_2000))'','',':us_census_county_code_2000')
    #END
+
    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
+
    #IF( #TEXT(Input_smacs_2000_level)='' )
      '' 
    #ELSE
        IF( le.Input_smacs_2000_level = (TYPEOF(le.Input_smacs_2000_level))'','',':smacs_2000_level')
    #END
+
    #IF( #TEXT(Input_median_household_income_3_bytes)='' )
      '' 
    #ELSE
        IF( le.Input_median_household_income_3_bytes = (TYPEOF(le.Input_median_household_income_3_bytes))'','',':median_household_income_3_bytes')
    #END
+
    #IF( #TEXT(Input_households_with_related_children)='' )
      '' 
    #ELSE
        IF( le.Input_households_with_related_children = (TYPEOF(le.Input_households_with_related_children))'','',':households_with_related_children')
    #END
+
    #IF( #TEXT(Input_median_age_of_adults_18_or_older_3_bytes)='' )
      '' 
    #ELSE
        IF( le.Input_median_age_of_adults_18_or_older_3_bytes = (TYPEOF(le.Input_median_age_of_adults_18_or_older_3_bytes))'','',':median_age_of_adults_18_or_older_3_bytes')
    #END
+
    #IF( #TEXT(Input_median_school_years_completed_by_adults_25_3_bytes)='' )
      '' 
    #ELSE
        IF( le.Input_median_school_years_completed_by_adults_25_3_bytes = (TYPEOF(le.Input_median_school_years_completed_by_adults_25_3_bytes))'','',':median_school_years_completed_by_adults_25_3_bytes')
    #END
+
    #IF( #TEXT(Input_percent_employed_managerial_and_professional)='' )
      '' 
    #ELSE
        IF( le.Input_percent_employed_managerial_and_professional = (TYPEOF(le.Input_percent_employed_managerial_and_professional))'','',':percent_employed_managerial_and_professional')
    #END
+
    #IF( #TEXT(Input_managementbusinessfinancial_operations)='' )
      '' 
    #ELSE
        IF( le.Input_managementbusinessfinancial_operations = (TYPEOF(le.Input_managementbusinessfinancial_operations))'','',':managementbusinessfinancial_operations')
    #END
+
    #IF( #TEXT(Input_owner_occupied_housing_units)='' )
      '' 
    #ELSE
        IF( le.Input_owner_occupied_housing_units = (TYPEOF(le.Input_owner_occupied_housing_units))'','',':owner_occupied_housing_units')
    #END
+
    #IF( #TEXT(Input_percent_in_single_unit_structures)='' )
      '' 
    #ELSE
        IF( le.Input_percent_in_single_unit_structures = (TYPEOF(le.Input_percent_in_single_unit_structures))'','',':percent_in_single_unit_structures')
    #END
+
    #IF( #TEXT(Input_median_home_value_4_bytes)='' )
      '' 
    #ELSE
        IF( le.Input_median_home_value_4_bytes = (TYPEOF(le.Input_median_home_value_4_bytes))'','',':median_home_value_4_bytes')
    #END
+
    #IF( #TEXT(Input_percent_owner_occupied_structures_built_since_1990)='' )
      '' 
    #ELSE
        IF( le.Input_percent_owner_occupied_structures_built_since_1990 = (TYPEOF(le.Input_percent_owner_occupied_structures_built_since_1990))'','',':percent_owner_occupied_structures_built_since_1990')
    #END
+
    #IF( #TEXT(Input_percent_persons_move_in_since_1995)='' )
      '' 
    #ELSE
        IF( le.Input_percent_persons_move_in_since_1995 = (TYPEOF(le.Input_percent_persons_move_in_since_1995))'','',':percent_persons_move_in_since_1995')
    #END
+
    #IF( #TEXT(Input_percent_of_motor_vehicle_ownership)='' )
      '' 
    #ELSE
        IF( le.Input_percent_of_motor_vehicle_ownership = (TYPEOF(le.Input_percent_of_motor_vehicle_ownership))'','',':percent_of_motor_vehicle_ownership')
    #END
+
    #IF( #TEXT(Input_percent_white)='' )
      '' 
    #ELSE
        IF( le.Input_percent_white = (TYPEOF(le.Input_percent_white))'','',':percent_white')
    #END
+
    #IF( #TEXT(Input_blank_space13)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space13 = (TYPEOF(le.Input_blank_space13))'','',':blank_space13')
    #END
+
    #IF( #TEXT(Input_cbsa_code)='' )
      '' 
    #ELSE
        IF( le.Input_cbsa_code = (TYPEOF(le.Input_cbsa_code))'','',':cbsa_code')
    #END
+
    #IF( #TEXT(Input_blank_space14)='' )
      '' 
    #ELSE
        IF( le.Input_blank_space14 = (TYPEOF(le.Input_blank_space14))'','',':blank_space14')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_miscellaneous)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_miscellaneous = (TYPEOF(le.Input_credit_card_usage_miscellaneous))'','',':credit_card_usage_miscellaneous')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_standard_retail)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_standard_retail = (TYPEOF(le.Input_credit_card_usage_standard_retail))'','',':credit_card_usage_standard_retail')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_standard_specialty_card)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_standard_specialty_card = (TYPEOF(le.Input_credit_card_usage_standard_specialty_card))'','',':credit_card_usage_standard_specialty_card')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_upscale_retail)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_upscale_retail = (TYPEOF(le.Input_credit_card_usage_upscale_retail))'','',':credit_card_usage_upscale_retail')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_upscale_spec_retail)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_upscale_spec_retail = (TYPEOF(le.Input_credit_card_usage_upscale_spec_retail))'','',':credit_card_usage_upscale_spec_retail')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_bank_card)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_bank_card = (TYPEOF(le.Input_credit_card_usage_bank_card))'','',':credit_card_usage_bank_card')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_oil__gas_card)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_oil__gas_card = (TYPEOF(le.Input_credit_card_usage_oil__gas_card))'','',':credit_card_usage_oil__gas_card')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_finance_co_card)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_finance_co_card = (TYPEOF(le.Input_credit_card_usage_finance_co_card))'','',':credit_card_usage_finance_co_card')
    #END
+
    #IF( #TEXT(Input_credit_card_usage_travel__entertainment)='' )
      '' 
    #ELSE
        IF( le.Input_credit_card_usage_travel__entertainment = (TYPEOF(le.Input_credit_card_usage_travel__entertainment))'','',':credit_card_usage_travel__entertainment')
    #END
+
    #IF( #TEXT(Input_tcc_american_express)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_american_express = (TYPEOF(le.Input_tcc_american_express))'','',':tcc_american_express')
    #END
+
    #IF( #TEXT(Input_tcc_any_credit_card)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_any_credit_card = (TYPEOF(le.Input_tcc_any_credit_card))'','',':tcc_any_credit_card')
    #END
+
    #IF( #TEXT(Input_tcc_catalog_showroom)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_catalog_showroom = (TYPEOF(le.Input_tcc_catalog_showroom))'','',':tcc_catalog_showroom')
    #END
+
    #IF( #TEXT(Input_tcc_computerelectronic)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_computerelectronic = (TYPEOF(le.Input_tcc_computerelectronic))'','',':tcc_computerelectronic')
    #END
+
    #IF( #TEXT(Input_tcc_debit_card)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_debit_card = (TYPEOF(le.Input_tcc_debit_card))'','',':tcc_debit_card')
    #END
+
    #IF( #TEXT(Input_tcc_furniture)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_furniture = (TYPEOF(le.Input_tcc_furniture))'','',':tcc_furniture')
    #END
+
    #IF( #TEXT(Input_tcc_grocery)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_grocery = (TYPEOF(le.Input_tcc_grocery))'','',':tcc_grocery')
    #END
+
    #IF( #TEXT(Input_tcc_home_improvement)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_home_improvement = (TYPEOF(le.Input_tcc_home_improvement))'','',':tcc_home_improvement')
    #END
+
    #IF( #TEXT(Input_tcc_homeoffice_supply)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_homeoffice_supply = (TYPEOF(le.Input_tcc_homeoffice_supply))'','',':tcc_homeoffice_supply')
    #END
+
    #IF( #TEXT(Input_tcc_low_end_department_store)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_low_end_department_store = (TYPEOF(le.Input_tcc_low_end_department_store))'','',':tcc_low_end_department_store')
    #END
+
    #IF( #TEXT(Input_tcc_main_street_retail)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_main_street_retail = (TYPEOF(le.Input_tcc_main_street_retail))'','',':tcc_main_street_retail')
    #END
+
    #IF( #TEXT(Input_tcc_mastercard)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_mastercard = (TYPEOF(le.Input_tcc_mastercard))'','',':tcc_mastercard')
    #END
+
    #IF( #TEXT(Input_tcc_membership_warehouse)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_membership_warehouse = (TYPEOF(le.Input_tcc_membership_warehouse))'','',':tcc_membership_warehouse')
    #END
+
    #IF( #TEXT(Input_tcc_specialty_apparel)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_specialty_apparel = (TYPEOF(le.Input_tcc_specialty_apparel))'','',':tcc_specialty_apparel')
    #END
+
    #IF( #TEXT(Input_tcc_sporting_goods)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_sporting_goods = (TYPEOF(le.Input_tcc_sporting_goods))'','',':tcc_sporting_goods')
    #END
+
    #IF( #TEXT(Input_tcc_tv_mail_order)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_tv_mail_order = (TYPEOF(le.Input_tcc_tv_mail_order))'','',':tcc_tv_mail_order')
    #END
+
    #IF( #TEXT(Input_tcc_visa)='' )
      '' 
    #ELSE
        IF( le.Input_tcc_visa = (TYPEOF(le.Input_tcc_visa))'','',':tcc_visa')
    #END
+
    #IF( #TEXT(Input_responder_education_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_responder_education_code_1 = (TYPEOF(le.Input_responder_education_code_1))'','',':responder_education_code_1')
    #END
+
    #IF( #TEXT(Input_responder_education_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_responder_education_code_2 = (TYPEOF(le.Input_responder_education_code_2))'','',':responder_education_code_2')
    #END
+
    #IF( #TEXT(Input_responder_education_code_3)='' )
      '' 
    #ELSE
        IF( le.Input_responder_education_code_3 = (TYPEOF(le.Input_responder_education_code_3))'','',':responder_education_code_3')
    #END
+
    #IF( #TEXT(Input_responder_education_code_4)='' )
      '' 
    #ELSE
        IF( le.Input_responder_education_code_4 = (TYPEOF(le.Input_responder_education_code_4))'','',':responder_education_code_4')
    #END
+
    #IF( #TEXT(Input_spouse_education_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_education_code_1 = (TYPEOF(le.Input_spouse_education_code_1))'','',':spouse_education_code_1')
    #END
+
    #IF( #TEXT(Input_spouse_education_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_education_code_2 = (TYPEOF(le.Input_spouse_education_code_2))'','',':spouse_education_code_2')
    #END
+
    #IF( #TEXT(Input_spouse_education_code_3)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_education_code_3 = (TYPEOF(le.Input_spouse_education_code_3))'','',':spouse_education_code_3')
    #END
+
    #IF( #TEXT(Input_spouse_education_code_4)='' )
      '' 
    #ELSE
        IF( le.Input_spouse_education_code_4 = (TYPEOF(le.Input_spouse_education_code_4))'','',':spouse_education_code_4')
    #END
+
    #IF( #TEXT(Input_advhousehold_education)='' )
      '' 
    #ELSE
        IF( le.Input_advhousehold_education = (TYPEOF(le.Input_advhousehold_education))'','',':advhousehold_education')
    #END
+
    #IF( #TEXT(Input_advhousehold_education_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_advhousehold_education_indicator = (TYPEOF(le.Input_advhousehold_education_indicator))'','',':advhousehold_education_indicator')
    #END
+
    #IF( #TEXT(Input_household_income_identifier)='' )
      '' 
    #ELSE
        IF( le.Input_household_income_identifier = (TYPEOF(le.Input_household_income_identifier))'','',':household_income_identifier')
    #END
+
    #IF( #TEXT(Input_narrow_band_household_income_identifier)='' )
      '' 
    #ELSE
        IF( le.Input_narrow_band_household_income_identifier = (TYPEOF(le.Input_narrow_band_household_income_identifier))'','',':narrow_band_household_income_identifier')
    #END
+
    #IF( #TEXT(Input_income_model_indicator2)='' )
      '' 
    #ELSE
        IF( le.Input_income_model_indicator2 = (TYPEOF(le.Input_income_model_indicator2))'','',':income_model_indicator2')
    #END
+
    #IF( #TEXT(Input_lf)='' )
      '' 
    #ELSE
        IF( le.Input_lf = (TYPEOF(le.Input_lf))'','',':lf')
    #END
+
    #IF( #TEXT(Input_title)='' )
      '' 
    #ELSE
        IF( le.Input_title = (TYPEOF(le.Input_title))'','',':title')
    #END
+
    #IF( #TEXT(Input_fname)='' )
      '' 
    #ELSE
        IF( le.Input_fname = (TYPEOF(le.Input_fname))'','',':fname')
    #END
+
    #IF( #TEXT(Input_mname)='' )
      '' 
    #ELSE
        IF( le.Input_mname = (TYPEOF(le.Input_mname))'','',':mname')
    #END
+
    #IF( #TEXT(Input_lname)='' )
      '' 
    #ELSE
        IF( le.Input_lname = (TYPEOF(le.Input_lname))'','',':lname')
    #END
+
    #IF( #TEXT(Input_name_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_name_suffix = (TYPEOF(le.Input_name_suffix))'','',':name_suffix')
    #END
+
    #IF( #TEXT(Input_name_score)='' )
      '' 
    #ELSE
        IF( le.Input_name_score = (TYPEOF(le.Input_name_score))'','',':name_score')
    #END
+
    #IF( #TEXT(Input_prim_range)='' )
      '' 
    #ELSE
        IF( le.Input_prim_range = (TYPEOF(le.Input_prim_range))'','',':prim_range')
    #END
+
    #IF( #TEXT(Input_predir)='' )
      '' 
    #ELSE
        IF( le.Input_predir = (TYPEOF(le.Input_predir))'','',':predir')
    #END
+
    #IF( #TEXT(Input_prim_name)='' )
      '' 
    #ELSE
        IF( le.Input_prim_name = (TYPEOF(le.Input_prim_name))'','',':prim_name')
    #END
+
    #IF( #TEXT(Input_addr_suffix)='' )
      '' 
    #ELSE
        IF( le.Input_addr_suffix = (TYPEOF(le.Input_addr_suffix))'','',':addr_suffix')
    #END
+
    #IF( #TEXT(Input_postdir)='' )
      '' 
    #ELSE
        IF( le.Input_postdir = (TYPEOF(le.Input_postdir))'','',':postdir')
    #END
+
    #IF( #TEXT(Input_unit_desig)='' )
      '' 
    #ELSE
        IF( le.Input_unit_desig = (TYPEOF(le.Input_unit_desig))'','',':unit_desig')
    #END
+
    #IF( #TEXT(Input_sec_range)='' )
      '' 
    #ELSE
        IF( le.Input_sec_range = (TYPEOF(le.Input_sec_range))'','',':sec_range')
    #END
+
    #IF( #TEXT(Input_p_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_p_city_name = (TYPEOF(le.Input_p_city_name))'','',':p_city_name')
    #END
+
    #IF( #TEXT(Input_v_city_name)='' )
      '' 
    #ELSE
        IF( le.Input_v_city_name = (TYPEOF(le.Input_v_city_name))'','',':v_city_name')
    #END
+
    #IF( #TEXT(Input_st)='' )
      '' 
    #ELSE
        IF( le.Input_st = (TYPEOF(le.Input_st))'','',':st')
    #END
+
    #IF( #TEXT(Input_zip)='' )
      '' 
    #ELSE
        IF( le.Input_zip = (TYPEOF(le.Input_zip))'','',':zip')
    #END
+
    #IF( #TEXT(Input_zip4)='' )
      '' 
    #ELSE
        IF( le.Input_zip4 = (TYPEOF(le.Input_zip4))'','',':zip4')
    #END
+
    #IF( #TEXT(Input_cart)='' )
      '' 
    #ELSE
        IF( le.Input_cart = (TYPEOF(le.Input_cart))'','',':cart')
    #END
+
    #IF( #TEXT(Input_cr_sort_sz)='' )
      '' 
    #ELSE
        IF( le.Input_cr_sort_sz = (TYPEOF(le.Input_cr_sort_sz))'','',':cr_sort_sz')
    #END
+
    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
+
    #IF( #TEXT(Input_lot_order)='' )
      '' 
    #ELSE
        IF( le.Input_lot_order = (TYPEOF(le.Input_lot_order))'','',':lot_order')
    #END
+
    #IF( #TEXT(Input_dpbc)='' )
      '' 
    #ELSE
        IF( le.Input_dpbc = (TYPEOF(le.Input_dpbc))'','',':dpbc')
    #END
+
    #IF( #TEXT(Input_chk_digit)='' )
      '' 
    #ELSE
        IF( le.Input_chk_digit = (TYPEOF(le.Input_chk_digit))'','',':chk_digit')
    #END
+
    #IF( #TEXT(Input_rec_type)='' )
      '' 
    #ELSE
        IF( le.Input_rec_type = (TYPEOF(le.Input_rec_type))'','',':rec_type')
    #END
+
    #IF( #TEXT(Input_ace_fips_st)='' )
      '' 
    #ELSE
        IF( le.Input_ace_fips_st = (TYPEOF(le.Input_ace_fips_st))'','',':ace_fips_st')
    #END
+
    #IF( #TEXT(Input_fips_county)='' )
      '' 
    #ELSE
        IF( le.Input_fips_county = (TYPEOF(le.Input_fips_county))'','',':fips_county')
    #END
+
    #IF( #TEXT(Input_geo_lat)='' )
      '' 
    #ELSE
        IF( le.Input_geo_lat = (TYPEOF(le.Input_geo_lat))'','',':geo_lat')
    #END
+
    #IF( #TEXT(Input_geo_long)='' )
      '' 
    #ELSE
        IF( le.Input_geo_long = (TYPEOF(le.Input_geo_long))'','',':geo_long')
    #END
+
    #IF( #TEXT(Input_msa)='' )
      '' 
    #ELSE
        IF( le.Input_msa = (TYPEOF(le.Input_msa))'','',':msa')
    #END
+
    #IF( #TEXT(Input_geo_match)='' )
      '' 
    #ELSE
        IF( le.Input_geo_match = (TYPEOF(le.Input_geo_match))'','',':geo_match')
    #END
+
    #IF( #TEXT(Input_err_stat)='' )
      '' 
    #ELSE
        IF( le.Input_err_stat = (TYPEOF(le.Input_err_stat))'','',':err_stat')
    #END
+
    #IF( #TEXT(Input_telephone)='' )
      '' 
    #ELSE
        IF( le.Input_telephone = (TYPEOF(le.Input_telephone))'','',':telephone')
    #END
+
    #IF( #TEXT(Input_gender)='' )
      '' 
    #ELSE
        IF( le.Input_gender = (TYPEOF(le.Input_gender))'','',':gender')
    #END
+
    #IF( #TEXT(Input_age)='' )
      '' 
    #ELSE
        IF( le.Input_age = (TYPEOF(le.Input_age))'','',':age')
    #END
+
    #IF( #TEXT(Input_birth_year)='' )
      '' 
    #ELSE
        IF( le.Input_birth_year = (TYPEOF(le.Input_birth_year))'','',':birth_year')
    #END
+
    #IF( #TEXT(Input_birth_month)='' )
      '' 
    #ELSE
        IF( le.Input_birth_month = (TYPEOF(le.Input_birth_month))'','',':birth_month')
    #END
+
    #IF( #TEXT(Input_member_code_of_person)='' )
      '' 
    #ELSE
        IF( le.Input_member_code_of_person = (TYPEOF(le.Input_member_code_of_person))'','',':member_code_of_person')
    #END
+
    #IF( #TEXT(Input_household_member_cnt)='' )
      '' 
    #ELSE
        IF( le.Input_household_member_cnt = (TYPEOF(le.Input_household_member_cnt))'','',':household_member_cnt')
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
