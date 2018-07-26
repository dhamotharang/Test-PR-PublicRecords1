 
EXPORT MAC_PopulationStatistics(infile,Ref='',fips_code='',Input_ln_fares_id = '',Input_process_date = '',Input_vendor_source_flag = '',Input_current_record = '',Input_fips_code = '',Input_state_code = '',Input_county_name = '',Input_old_apn = '',Input_apna_or_pin_number = '',Input_fares_unformatted_apn = '',Input_duplicate_apn_multiple_address_id = '',Input_assessee_name = '',Input_second_assessee_name = '',Input_assessee_ownership_rights_code = '',Input_assessee_relationship_code = '',Input_assessee_phone_number = '',Input_tax_account_number = '',Input_contract_owner = '',Input_assessee_name_type_code = '',Input_second_assessee_name_type_code = '',Input_mail_care_of_name_type_code = '',Input_mailing_care_of_name = '',Input_mailing_full_street_address = '',Input_mailing_unit_number = '',Input_mailing_city_state_zip = '',Input_property_full_street_address = '',Input_property_unit_number = '',Input_property_city_state_zip = '',Input_property_country_code = '',Input_property_address_code = '',Input_legal_lot_code = '',Input_legal_lot_number = '',Input_legal_land_lot = '',Input_legal_block = '',Input_legal_section = '',Input_legal_district = '',Input_legal_unit = '',Input_legal_city_municipality_township = '',Input_legal_subdivision_name = '',Input_legal_phase_number = '',Input_legal_tract_number = '',Input_legal_sec_twn_rng_mer = '',Input_legal_brief_description = '',Input_legal_assessor_map_ref = '',Input_census_tract = '',Input_record_type_code = '',Input_ownership_type_code = '',Input_new_record_type_code = '',Input_state_land_use_code = '',Input_county_land_use_code = '',Input_county_land_use_description = '',Input_standardized_land_use_code = '',Input_timeshare_code = '',Input_zoning = '',Input_owner_occupied = '',Input_recorder_document_number = '',Input_recorder_book_number = '',Input_recorder_page_number = '',Input_transfer_date = '',Input_recording_date = '',Input_sale_date = '',Input_document_type = '',Input_sales_price = '',Input_sales_price_code = '',Input_mortgage_loan_amount = '',Input_mortgage_loan_type_code = '',Input_mortgage_lender_name = '',Input_mortgage_lender_type_code = '',Input_prior_transfer_date = '',Input_prior_recording_date = '',Input_prior_sales_price = '',Input_prior_sales_price_code = '',Input_assessed_land_value = '',Input_assessed_improvement_value = '',Input_assessed_total_value = '',Input_assessed_value_year = '',Input_market_land_value = '',Input_market_improvement_value = '',Input_market_total_value = '',Input_market_value_year = '',Input_homestead_homeowner_exemption = '',Input_tax_exemption1_code = '',Input_tax_exemption2_code = '',Input_tax_exemption3_code = '',Input_tax_exemption4_code = '',Input_tax_rate_code_area = '',Input_tax_amount = '',Input_tax_year = '',Input_tax_delinquent_year = '',Input_school_tax_district1 = '',Input_school_tax_district1_indicator = '',Input_school_tax_district2 = '',Input_school_tax_district2_indicator = '',Input_school_tax_district3 = '',Input_school_tax_district3_indicator = '',Input_lot_size = '',Input_lot_size_acres = '',Input_lot_size_frontage_feet = '',Input_lot_size_depth_feet = '',Input_land_acres = '',Input_land_square_footage = '',Input_land_dimensions = '',Input_building_area = '',Input_building_area_indicator = '',Input_building_area1 = '',Input_building_area1_indicator = '',Input_building_area2 = '',Input_building_area2_indicator = '',Input_building_area3 = '',Input_building_area3_indicator = '',Input_building_area4 = '',Input_building_area4_indicator = '',Input_building_area5 = '',Input_building_area5_indicator = '',Input_building_area6 = '',Input_building_area6_indicator = '',Input_building_area7 = '',Input_building_area7_indicator = '',Input_year_built = '',Input_effective_year_built = '',Input_no_of_buildings = '',Input_no_of_stories = '',Input_no_of_units = '',Input_no_of_rooms = '',Input_no_of_bedrooms = '',Input_no_of_baths = '',Input_no_of_partial_baths = '',Input_no_of_plumbing_fixtures = '',Input_garage_type_code = '',Input_parking_no_of_cars = '',Input_pool_code = '',Input_style_code = '',Input_type_construction_code = '',Input_foundation_code = '',Input_building_quality_code = '',Input_building_condition_code = '',Input_exterior_walls_code = '',Input_interior_walls_code = '',Input_roof_cover_code = '',Input_roof_type_code = '',Input_floor_cover_code = '',Input_water_code = '',Input_sewer_code = '',Input_heating_code = '',Input_heating_fuel_type_code = '',Input_air_conditioning_code = '',Input_air_conditioning_type_code = '',Input_elevator = '',Input_fireplace_indicator = '',Input_fireplace_number = '',Input_basement_code = '',Input_building_class_code = '',Input_site_influence1_code = '',Input_site_influence2_code = '',Input_site_influence3_code = '',Input_site_influence4_code = '',Input_site_influence5_code = '',Input_amenities1_code = '',Input_amenities2_code = '',Input_amenities3_code = '',Input_amenities4_code = '',Input_amenities5_code = '',Input_amenities2_code1 = '',Input_amenities2_code2 = '',Input_amenities2_code3 = '',Input_amenities2_code4 = '',Input_amenities2_code5 = '',Input_extra_features1_area = '',Input_extra_features1_indicator = '',Input_extra_features2_area = '',Input_extra_features2_indicator = '',Input_extra_features3_area = '',Input_extra_features3_indicator = '',Input_extra_features4_area = '',Input_extra_features4_indicator = '',Input_other_buildings1_code = '',Input_other_buildings2_code = '',Input_other_buildings3_code = '',Input_other_buildings4_code = '',Input_other_buildings5_code = '',Input_other_impr_building1_indicator = '',Input_other_impr_building2_indicator = '',Input_other_impr_building3_indicator = '',Input_other_impr_building4_indicator = '',Input_other_impr_building5_indicator = '',Input_other_impr_building_area1 = '',Input_other_impr_building_area2 = '',Input_other_impr_building_area3 = '',Input_other_impr_building_area4 = '',Input_other_impr_building_area5 = '',Input_topograpy_code = '',Input_neighborhood_code = '',Input_condo_project_or_building_name = '',Input_assessee_name_indicator = '',Input_second_assessee_name_indicator = '',Input_other_rooms_indicator = '',Input_mail_care_of_name_indicator = '',Input_comments = '',Input_tape_cut_date = '',Input_certification_date = '',Input_edition_number = '',Input_prop_addr_propagated_ind = '',Input_ln_ownership_rights = '',Input_ln_relationship_type = '',Input_ln_mailing_country_code = '',Input_ln_property_name = '',Input_ln_property_name_type = '',Input_ln_land_use_category = '',Input_ln_lot = '',Input_ln_block = '',Input_ln_unit = '',Input_ln_subfloor = '',Input_ln_floor_cover = '',Input_ln_mobile_home_indicator = '',Input_ln_condo_indicator = '',Input_ln_property_tax_exemption = '',Input_ln_veteran_status = '',Input_ln_old_apn_indicator = '',Input_fips = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_LN_PropertyV2_Assessor;
  #uniquename(of)
  %of% := RECORD
    #IF (#TEXT(fips_code)<>'')
    SALT311.StrType source;
    #END
    SALT311.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_ln_fares_id)='' )
      '' 
    #ELSE
        IF( le.Input_ln_fares_id = (TYPEOF(le.Input_ln_fares_id))'','',':ln_fares_id')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_process_date = 0,'', ':process_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_process_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_vendor_source_flag)='' )
      '' 
    #ELSE
        IF( le.Input_vendor_source_flag = (TYPEOF(le.Input_vendor_source_flag))'','',':vendor_source_flag')
    #END
 
+    #IF( #TEXT(Input_current_record)='' )
      '' 
    #ELSE
        IF( le.Input_current_record = (TYPEOF(le.Input_current_record))'','',':current_record')
    #END
 
+    #IF( #TEXT(Input_fips_code)='' )
      '' 
    #ELSE
        IF( le.Input_fips_code = (TYPEOF(le.Input_fips_code))'','',':fips_code')
    #END
 
+    #IF( #TEXT(Input_state_code)='' )
      '' 
    #ELSE
        IF( le.Input_state_code = (TYPEOF(le.Input_state_code))'','',':state_code')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_old_apn)='' )
      '' 
    #ELSE
        IF( le.Input_old_apn = (TYPEOF(le.Input_old_apn))'','',':old_apn')
    #END
 
+    #IF( #TEXT(Input_apna_or_pin_number)='' )
      '' 
    #ELSE
        IF( le.Input_apna_or_pin_number = (TYPEOF(le.Input_apna_or_pin_number))'','',':apna_or_pin_number')
    #END
 
+    #IF( #TEXT(Input_fares_unformatted_apn)='' )
      '' 
    #ELSE
        IF( le.Input_fares_unformatted_apn = (TYPEOF(le.Input_fares_unformatted_apn))'','',':fares_unformatted_apn')
    #END
 
+    #IF( #TEXT(Input_duplicate_apn_multiple_address_id)='' )
      '' 
    #ELSE
        IF( le.Input_duplicate_apn_multiple_address_id = (TYPEOF(le.Input_duplicate_apn_multiple_address_id))'','',':duplicate_apn_multiple_address_id')
    #END
 
+    #IF( #TEXT(Input_assessee_name)='' )
      '' 
    #ELSE
        IF( le.Input_assessee_name = (TYPEOF(le.Input_assessee_name))'','',':assessee_name')
    #END
 
+    #IF( #TEXT(Input_second_assessee_name)='' )
      '' 
    #ELSE
        IF( le.Input_second_assessee_name = (TYPEOF(le.Input_second_assessee_name))'','',':second_assessee_name')
    #END
 
+    #IF( #TEXT(Input_assessee_ownership_rights_code)='' )
      '' 
    #ELSE
        IF( le.Input_assessee_ownership_rights_code = (TYPEOF(le.Input_assessee_ownership_rights_code))'','',':assessee_ownership_rights_code')
    #END
 
+    #IF( #TEXT(Input_assessee_relationship_code)='' )
      '' 
    #ELSE
        IF( le.Input_assessee_relationship_code = (TYPEOF(le.Input_assessee_relationship_code))'','',':assessee_relationship_code')
    #END
 
+    #IF( #TEXT(Input_assessee_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_assessee_phone_number = (TYPEOF(le.Input_assessee_phone_number))'','',':assessee_phone_number')
    #END
 
+    #IF( #TEXT(Input_tax_account_number)='' )
      '' 
    #ELSE
        IF( le.Input_tax_account_number = (TYPEOF(le.Input_tax_account_number))'','',':tax_account_number')
    #END
 
+    #IF( #TEXT(Input_contract_owner)='' )
      '' 
    #ELSE
        IF( le.Input_contract_owner = (TYPEOF(le.Input_contract_owner))'','',':contract_owner')
    #END
 
+    #IF( #TEXT(Input_assessee_name_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_assessee_name_type_code = (TYPEOF(le.Input_assessee_name_type_code))'','',':assessee_name_type_code')
    #END
 
+    #IF( #TEXT(Input_second_assessee_name_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_second_assessee_name_type_code = (TYPEOF(le.Input_second_assessee_name_type_code))'','',':second_assessee_name_type_code')
    #END
 
+    #IF( #TEXT(Input_mail_care_of_name_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_mail_care_of_name_type_code = (TYPEOF(le.Input_mail_care_of_name_type_code))'','',':mail_care_of_name_type_code')
    #END
 
+    #IF( #TEXT(Input_mailing_care_of_name)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_care_of_name = (TYPEOF(le.Input_mailing_care_of_name))'','',':mailing_care_of_name')
    #END
 
+    #IF( #TEXT(Input_mailing_full_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_full_street_address = (TYPEOF(le.Input_mailing_full_street_address))'','',':mailing_full_street_address')
    #END
 
+    #IF( #TEXT(Input_mailing_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_unit_number = (TYPEOF(le.Input_mailing_unit_number))'','',':mailing_unit_number')
    #END
 
+    #IF( #TEXT(Input_mailing_city_state_zip)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_city_state_zip = (TYPEOF(le.Input_mailing_city_state_zip))'','',':mailing_city_state_zip')
    #END
 
+    #IF( #TEXT(Input_property_full_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_property_full_street_address = (TYPEOF(le.Input_property_full_street_address))'','',':property_full_street_address')
    #END
 
+    #IF( #TEXT(Input_property_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_property_unit_number = (TYPEOF(le.Input_property_unit_number))'','',':property_unit_number')
    #END
 
+    #IF( #TEXT(Input_property_city_state_zip)='' )
      '' 
    #ELSE
        IF( le.Input_property_city_state_zip = (TYPEOF(le.Input_property_city_state_zip))'','',':property_city_state_zip')
    #END
 
+    #IF( #TEXT(Input_property_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_property_country_code = (TYPEOF(le.Input_property_country_code))'','',':property_country_code')
    #END
 
+    #IF( #TEXT(Input_property_address_code)='' )
      '' 
    #ELSE
        IF( le.Input_property_address_code = (TYPEOF(le.Input_property_address_code))'','',':property_address_code')
    #END
 
+    #IF( #TEXT(Input_legal_lot_code)='' )
      '' 
    #ELSE
        IF( le.Input_legal_lot_code = (TYPEOF(le.Input_legal_lot_code))'','',':legal_lot_code')
    #END
 
+    #IF( #TEXT(Input_legal_lot_number)='' )
      '' 
    #ELSE
        IF( le.Input_legal_lot_number = (TYPEOF(le.Input_legal_lot_number))'','',':legal_lot_number')
    #END
 
+    #IF( #TEXT(Input_legal_land_lot)='' )
      '' 
    #ELSE
        IF( le.Input_legal_land_lot = (TYPEOF(le.Input_legal_land_lot))'','',':legal_land_lot')
    #END
 
+    #IF( #TEXT(Input_legal_block)='' )
      '' 
    #ELSE
        IF( le.Input_legal_block = (TYPEOF(le.Input_legal_block))'','',':legal_block')
    #END
 
+    #IF( #TEXT(Input_legal_section)='' )
      '' 
    #ELSE
        IF( le.Input_legal_section = (TYPEOF(le.Input_legal_section))'','',':legal_section')
    #END
 
+    #IF( #TEXT(Input_legal_district)='' )
      '' 
    #ELSE
        IF( le.Input_legal_district = (TYPEOF(le.Input_legal_district))'','',':legal_district')
    #END
 
+    #IF( #TEXT(Input_legal_unit)='' )
      '' 
    #ELSE
        IF( le.Input_legal_unit = (TYPEOF(le.Input_legal_unit))'','',':legal_unit')
    #END
 
+    #IF( #TEXT(Input_legal_city_municipality_township)='' )
      '' 
    #ELSE
        IF( le.Input_legal_city_municipality_township = (TYPEOF(le.Input_legal_city_municipality_township))'','',':legal_city_municipality_township')
    #END
 
+    #IF( #TEXT(Input_legal_subdivision_name)='' )
      '' 
    #ELSE
        IF( le.Input_legal_subdivision_name = (TYPEOF(le.Input_legal_subdivision_name))'','',':legal_subdivision_name')
    #END
 
+    #IF( #TEXT(Input_legal_phase_number)='' )
      '' 
    #ELSE
        IF( le.Input_legal_phase_number = (TYPEOF(le.Input_legal_phase_number))'','',':legal_phase_number')
    #END
 
+    #IF( #TEXT(Input_legal_tract_number)='' )
      '' 
    #ELSE
        IF( le.Input_legal_tract_number = (TYPEOF(le.Input_legal_tract_number))'','',':legal_tract_number')
    #END
 
+    #IF( #TEXT(Input_legal_sec_twn_rng_mer)='' )
      '' 
    #ELSE
        IF( le.Input_legal_sec_twn_rng_mer = (TYPEOF(le.Input_legal_sec_twn_rng_mer))'','',':legal_sec_twn_rng_mer')
    #END
 
+    #IF( #TEXT(Input_legal_brief_description)='' )
      '' 
    #ELSE
        IF( le.Input_legal_brief_description = (TYPEOF(le.Input_legal_brief_description))'','',':legal_brief_description')
    #END
 
+    #IF( #TEXT(Input_legal_assessor_map_ref)='' )
      '' 
    #ELSE
        IF( le.Input_legal_assessor_map_ref = (TYPEOF(le.Input_legal_assessor_map_ref))'','',':legal_assessor_map_ref')
    #END
 
+    #IF( #TEXT(Input_census_tract)='' )
      '' 
    #ELSE
        IF( le.Input_census_tract = (TYPEOF(le.Input_census_tract))'','',':census_tract')
    #END
 
+    #IF( #TEXT(Input_record_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_record_type_code = (TYPEOF(le.Input_record_type_code))'','',':record_type_code')
    #END
 
+    #IF( #TEXT(Input_ownership_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_ownership_type_code = (TYPEOF(le.Input_ownership_type_code))'','',':ownership_type_code')
    #END
 
+    #IF( #TEXT(Input_new_record_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_new_record_type_code = (TYPEOF(le.Input_new_record_type_code))'','',':new_record_type_code')
    #END
 
+    #IF( #TEXT(Input_state_land_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_state_land_use_code = (TYPEOF(le.Input_state_land_use_code))'','',':state_land_use_code')
    #END
 
+    #IF( #TEXT(Input_county_land_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_county_land_use_code = (TYPEOF(le.Input_county_land_use_code))'','',':county_land_use_code')
    #END
 
+    #IF( #TEXT(Input_county_land_use_description)='' )
      '' 
    #ELSE
        IF( le.Input_county_land_use_description = (TYPEOF(le.Input_county_land_use_description))'','',':county_land_use_description')
    #END
 
+    #IF( #TEXT(Input_standardized_land_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_standardized_land_use_code = (TYPEOF(le.Input_standardized_land_use_code))'','',':standardized_land_use_code')
    #END
 
+    #IF( #TEXT(Input_timeshare_code)='' )
      '' 
    #ELSE
        IF( le.Input_timeshare_code = (TYPEOF(le.Input_timeshare_code))'','',':timeshare_code')
    #END
 
+    #IF( #TEXT(Input_zoning)='' )
      '' 
    #ELSE
        IF( le.Input_zoning = (TYPEOF(le.Input_zoning))'','',':zoning')
    #END
 
+    #IF( #TEXT(Input_owner_occupied)='' )
      '' 
    #ELSE
        IF( le.Input_owner_occupied = (TYPEOF(le.Input_owner_occupied))'','',':owner_occupied')
    #END
 
+    #IF( #TEXT(Input_recorder_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_recorder_document_number = (TYPEOF(le.Input_recorder_document_number))'','',':recorder_document_number')
    #END
 
+    #IF( #TEXT(Input_recorder_book_number)='' )
      '' 
    #ELSE
        IF( le.Input_recorder_book_number = (TYPEOF(le.Input_recorder_book_number))'','',':recorder_book_number')
    #END
 
+    #IF( #TEXT(Input_recorder_page_number)='' )
      '' 
    #ELSE
        IF( le.Input_recorder_page_number = (TYPEOF(le.Input_recorder_page_number))'','',':recorder_page_number')
    #END
 
+    #IF( #TEXT(Input_transfer_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_transfer_date = 0,'', ':transfer_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_transfer_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_recording_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_recording_date = 0,'', ':recording_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_recording_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_sale_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_sale_date = 0,'', ':sale_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_sale_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_document_type)='' )
      '' 
    #ELSE
        IF( le.Input_document_type = (TYPEOF(le.Input_document_type))'','',':document_type')
    #END
 
+    #IF( #TEXT(Input_sales_price)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price = (TYPEOF(le.Input_sales_price))'','',':sales_price')
    #END
 
+    #IF( #TEXT(Input_sales_price_code)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price_code = (TYPEOF(le.Input_sales_price_code))'','',':sales_price_code')
    #END
 
+    #IF( #TEXT(Input_mortgage_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_mortgage_loan_amount = (TYPEOF(le.Input_mortgage_loan_amount))'','',':mortgage_loan_amount')
    #END
 
+    #IF( #TEXT(Input_mortgage_loan_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_mortgage_loan_type_code = (TYPEOF(le.Input_mortgage_loan_type_code))'','',':mortgage_loan_type_code')
    #END
 
+    #IF( #TEXT(Input_mortgage_lender_name)='' )
      '' 
    #ELSE
        IF( le.Input_mortgage_lender_name = (TYPEOF(le.Input_mortgage_lender_name))'','',':mortgage_lender_name')
    #END
 
+    #IF( #TEXT(Input_mortgage_lender_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_mortgage_lender_type_code = (TYPEOF(le.Input_mortgage_lender_type_code))'','',':mortgage_lender_type_code')
    #END
 
+    #IF( #TEXT(Input_prior_transfer_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_prior_transfer_date = 0,'', ':prior_transfer_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_prior_transfer_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_prior_recording_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_prior_recording_date = 0,'', ':prior_recording_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_prior_recording_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_prior_sales_price)='' )
      '' 
    #ELSE
        IF( le.Input_prior_sales_price = (TYPEOF(le.Input_prior_sales_price))'','',':prior_sales_price')
    #END
 
+    #IF( #TEXT(Input_prior_sales_price_code)='' )
      '' 
    #ELSE
        IF( le.Input_prior_sales_price_code = (TYPEOF(le.Input_prior_sales_price_code))'','',':prior_sales_price_code')
    #END
 
+    #IF( #TEXT(Input_assessed_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_assessed_land_value = (TYPEOF(le.Input_assessed_land_value))'','',':assessed_land_value')
    #END
 
+    #IF( #TEXT(Input_assessed_improvement_value)='' )
      '' 
    #ELSE
        IF( le.Input_assessed_improvement_value = (TYPEOF(le.Input_assessed_improvement_value))'','',':assessed_improvement_value')
    #END
 
+    #IF( #TEXT(Input_assessed_total_value)='' )
      '' 
    #ELSE
        IF( le.Input_assessed_total_value = (TYPEOF(le.Input_assessed_total_value))'','',':assessed_total_value')
    #END
 
+    #IF( #TEXT(Input_assessed_value_year)='' )
      '' 
    #ELSE
        IF( le.Input_assessed_value_year = (TYPEOF(le.Input_assessed_value_year))'','',':assessed_value_year')
    #END
 
+    #IF( #TEXT(Input_market_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_market_land_value = (TYPEOF(le.Input_market_land_value))'','',':market_land_value')
    #END
 
+    #IF( #TEXT(Input_market_improvement_value)='' )
      '' 
    #ELSE
        IF( le.Input_market_improvement_value = (TYPEOF(le.Input_market_improvement_value))'','',':market_improvement_value')
    #END
 
+    #IF( #TEXT(Input_market_total_value)='' )
      '' 
    #ELSE
        IF( le.Input_market_total_value = (TYPEOF(le.Input_market_total_value))'','',':market_total_value')
    #END
 
+    #IF( #TEXT(Input_market_value_year)='' )
      '' 
    #ELSE
        IF( le.Input_market_value_year = (TYPEOF(le.Input_market_value_year))'','',':market_value_year')
    #END
 
+    #IF( #TEXT(Input_homestead_homeowner_exemption)='' )
      '' 
    #ELSE
        IF( le.Input_homestead_homeowner_exemption = (TYPEOF(le.Input_homestead_homeowner_exemption))'','',':homestead_homeowner_exemption')
    #END
 
+    #IF( #TEXT(Input_tax_exemption1_code)='' )
      '' 
    #ELSE
        IF( le.Input_tax_exemption1_code = (TYPEOF(le.Input_tax_exemption1_code))'','',':tax_exemption1_code')
    #END
 
+    #IF( #TEXT(Input_tax_exemption2_code)='' )
      '' 
    #ELSE
        IF( le.Input_tax_exemption2_code = (TYPEOF(le.Input_tax_exemption2_code))'','',':tax_exemption2_code')
    #END
 
+    #IF( #TEXT(Input_tax_exemption3_code)='' )
      '' 
    #ELSE
        IF( le.Input_tax_exemption3_code = (TYPEOF(le.Input_tax_exemption3_code))'','',':tax_exemption3_code')
    #END
 
+    #IF( #TEXT(Input_tax_exemption4_code)='' )
      '' 
    #ELSE
        IF( le.Input_tax_exemption4_code = (TYPEOF(le.Input_tax_exemption4_code))'','',':tax_exemption4_code')
    #END
 
+    #IF( #TEXT(Input_tax_rate_code_area)='' )
      '' 
    #ELSE
        IF( le.Input_tax_rate_code_area = (TYPEOF(le.Input_tax_rate_code_area))'','',':tax_rate_code_area')
    #END
 
+    #IF( #TEXT(Input_tax_amount)='' )
      '' 
    #ELSE
        IF( le.Input_tax_amount = (TYPEOF(le.Input_tax_amount))'','',':tax_amount')
    #END
 
+    #IF( #TEXT(Input_tax_year)='' )
      '' 
    #ELSE
        IF( le.Input_tax_year = (TYPEOF(le.Input_tax_year))'','',':tax_year')
    #END
 
+    #IF( #TEXT(Input_tax_delinquent_year)='' )
      '' 
    #ELSE
        IF( le.Input_tax_delinquent_year = (TYPEOF(le.Input_tax_delinquent_year))'','',':tax_delinquent_year')
    #END
 
+    #IF( #TEXT(Input_school_tax_district1)='' )
      '' 
    #ELSE
        IF( le.Input_school_tax_district1 = (TYPEOF(le.Input_school_tax_district1))'','',':school_tax_district1')
    #END
 
+    #IF( #TEXT(Input_school_tax_district1_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_school_tax_district1_indicator = (TYPEOF(le.Input_school_tax_district1_indicator))'','',':school_tax_district1_indicator')
    #END
 
+    #IF( #TEXT(Input_school_tax_district2)='' )
      '' 
    #ELSE
        IF( le.Input_school_tax_district2 = (TYPEOF(le.Input_school_tax_district2))'','',':school_tax_district2')
    #END
 
+    #IF( #TEXT(Input_school_tax_district2_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_school_tax_district2_indicator = (TYPEOF(le.Input_school_tax_district2_indicator))'','',':school_tax_district2_indicator')
    #END
 
+    #IF( #TEXT(Input_school_tax_district3)='' )
      '' 
    #ELSE
        IF( le.Input_school_tax_district3 = (TYPEOF(le.Input_school_tax_district3))'','',':school_tax_district3')
    #END
 
+    #IF( #TEXT(Input_school_tax_district3_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_school_tax_district3_indicator = (TYPEOF(le.Input_school_tax_district3_indicator))'','',':school_tax_district3_indicator')
    #END
 
+    #IF( #TEXT(Input_lot_size)='' )
      '' 
    #ELSE
        IF( le.Input_lot_size = (TYPEOF(le.Input_lot_size))'','',':lot_size')
    #END
 
+    #IF( #TEXT(Input_lot_size_acres)='' )
      '' 
    #ELSE
        IF( le.Input_lot_size_acres = (TYPEOF(le.Input_lot_size_acres))'','',':lot_size_acres')
    #END
 
+    #IF( #TEXT(Input_lot_size_frontage_feet)='' )
      '' 
    #ELSE
        IF( le.Input_lot_size_frontage_feet = (TYPEOF(le.Input_lot_size_frontage_feet))'','',':lot_size_frontage_feet')
    #END
 
+    #IF( #TEXT(Input_lot_size_depth_feet)='' )
      '' 
    #ELSE
        IF( le.Input_lot_size_depth_feet = (TYPEOF(le.Input_lot_size_depth_feet))'','',':lot_size_depth_feet')
    #END
 
+    #IF( #TEXT(Input_land_acres)='' )
      '' 
    #ELSE
        IF( le.Input_land_acres = (TYPEOF(le.Input_land_acres))'','',':land_acres')
    #END
 
+    #IF( #TEXT(Input_land_square_footage)='' )
      '' 
    #ELSE
        IF( le.Input_land_square_footage = (TYPEOF(le.Input_land_square_footage))'','',':land_square_footage')
    #END
 
+    #IF( #TEXT(Input_land_dimensions)='' )
      '' 
    #ELSE
        IF( le.Input_land_dimensions = (TYPEOF(le.Input_land_dimensions))'','',':land_dimensions')
    #END
 
+    #IF( #TEXT(Input_building_area)='' )
      '' 
    #ELSE
        IF( le.Input_building_area = (TYPEOF(le.Input_building_area))'','',':building_area')
    #END
 
+    #IF( #TEXT(Input_building_area_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_building_area_indicator = (TYPEOF(le.Input_building_area_indicator))'','',':building_area_indicator')
    #END
 
+    #IF( #TEXT(Input_building_area1)='' )
      '' 
    #ELSE
        IF( le.Input_building_area1 = (TYPEOF(le.Input_building_area1))'','',':building_area1')
    #END
 
+    #IF( #TEXT(Input_building_area1_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_building_area1_indicator = (TYPEOF(le.Input_building_area1_indicator))'','',':building_area1_indicator')
    #END
 
+    #IF( #TEXT(Input_building_area2)='' )
      '' 
    #ELSE
        IF( le.Input_building_area2 = (TYPEOF(le.Input_building_area2))'','',':building_area2')
    #END
 
+    #IF( #TEXT(Input_building_area2_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_building_area2_indicator = (TYPEOF(le.Input_building_area2_indicator))'','',':building_area2_indicator')
    #END
 
+    #IF( #TEXT(Input_building_area3)='' )
      '' 
    #ELSE
        IF( le.Input_building_area3 = (TYPEOF(le.Input_building_area3))'','',':building_area3')
    #END
 
+    #IF( #TEXT(Input_building_area3_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_building_area3_indicator = (TYPEOF(le.Input_building_area3_indicator))'','',':building_area3_indicator')
    #END
 
+    #IF( #TEXT(Input_building_area4)='' )
      '' 
    #ELSE
        IF( le.Input_building_area4 = (TYPEOF(le.Input_building_area4))'','',':building_area4')
    #END
 
+    #IF( #TEXT(Input_building_area4_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_building_area4_indicator = (TYPEOF(le.Input_building_area4_indicator))'','',':building_area4_indicator')
    #END
 
+    #IF( #TEXT(Input_building_area5)='' )
      '' 
    #ELSE
        IF( le.Input_building_area5 = (TYPEOF(le.Input_building_area5))'','',':building_area5')
    #END
 
+    #IF( #TEXT(Input_building_area5_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_building_area5_indicator = (TYPEOF(le.Input_building_area5_indicator))'','',':building_area5_indicator')
    #END
 
+    #IF( #TEXT(Input_building_area6)='' )
      '' 
    #ELSE
        IF( le.Input_building_area6 = (TYPEOF(le.Input_building_area6))'','',':building_area6')
    #END
 
+    #IF( #TEXT(Input_building_area6_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_building_area6_indicator = (TYPEOF(le.Input_building_area6_indicator))'','',':building_area6_indicator')
    #END
 
+    #IF( #TEXT(Input_building_area7)='' )
      '' 
    #ELSE
        IF( le.Input_building_area7 = (TYPEOF(le.Input_building_area7))'','',':building_area7')
    #END
 
+    #IF( #TEXT(Input_building_area7_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_building_area7_indicator = (TYPEOF(le.Input_building_area7_indicator))'','',':building_area7_indicator')
    #END
 
+    #IF( #TEXT(Input_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_year_built = (TYPEOF(le.Input_year_built))'','',':year_built')
    #END
 
+    #IF( #TEXT(Input_effective_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_effective_year_built = (TYPEOF(le.Input_effective_year_built))'','',':effective_year_built')
    #END
 
+    #IF( #TEXT(Input_no_of_buildings)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_buildings = (TYPEOF(le.Input_no_of_buildings))'','',':no_of_buildings')
    #END
 
+    #IF( #TEXT(Input_no_of_stories)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_stories = (TYPEOF(le.Input_no_of_stories))'','',':no_of_stories')
    #END
 
+    #IF( #TEXT(Input_no_of_units)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_units = (TYPEOF(le.Input_no_of_units))'','',':no_of_units')
    #END
 
+    #IF( #TEXT(Input_no_of_rooms)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_rooms = (TYPEOF(le.Input_no_of_rooms))'','',':no_of_rooms')
    #END
 
+    #IF( #TEXT(Input_no_of_bedrooms)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_bedrooms = (TYPEOF(le.Input_no_of_bedrooms))'','',':no_of_bedrooms')
    #END
 
+    #IF( #TEXT(Input_no_of_baths)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_baths = (TYPEOF(le.Input_no_of_baths))'','',':no_of_baths')
    #END
 
+    #IF( #TEXT(Input_no_of_partial_baths)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_partial_baths = (TYPEOF(le.Input_no_of_partial_baths))'','',':no_of_partial_baths')
    #END
 
+    #IF( #TEXT(Input_no_of_plumbing_fixtures)='' )
      '' 
    #ELSE
        IF( le.Input_no_of_plumbing_fixtures = (TYPEOF(le.Input_no_of_plumbing_fixtures))'','',':no_of_plumbing_fixtures')
    #END
 
+    #IF( #TEXT(Input_garage_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_garage_type_code = (TYPEOF(le.Input_garage_type_code))'','',':garage_type_code')
    #END
 
+    #IF( #TEXT(Input_parking_no_of_cars)='' )
      '' 
    #ELSE
        IF( le.Input_parking_no_of_cars = (TYPEOF(le.Input_parking_no_of_cars))'','',':parking_no_of_cars')
    #END
 
+    #IF( #TEXT(Input_pool_code)='' )
      '' 
    #ELSE
        IF( le.Input_pool_code = (TYPEOF(le.Input_pool_code))'','',':pool_code')
    #END
 
+    #IF( #TEXT(Input_style_code)='' )
      '' 
    #ELSE
        IF( le.Input_style_code = (TYPEOF(le.Input_style_code))'','',':style_code')
    #END
 
+    #IF( #TEXT(Input_type_construction_code)='' )
      '' 
    #ELSE
        IF( le.Input_type_construction_code = (TYPEOF(le.Input_type_construction_code))'','',':type_construction_code')
    #END
 
+    #IF( #TEXT(Input_foundation_code)='' )
      '' 
    #ELSE
        IF( le.Input_foundation_code = (TYPEOF(le.Input_foundation_code))'','',':foundation_code')
    #END
 
+    #IF( #TEXT(Input_building_quality_code)='' )
      '' 
    #ELSE
        IF( le.Input_building_quality_code = (TYPEOF(le.Input_building_quality_code))'','',':building_quality_code')
    #END
 
+    #IF( #TEXT(Input_building_condition_code)='' )
      '' 
    #ELSE
        IF( le.Input_building_condition_code = (TYPEOF(le.Input_building_condition_code))'','',':building_condition_code')
    #END
 
+    #IF( #TEXT(Input_exterior_walls_code)='' )
      '' 
    #ELSE
        IF( le.Input_exterior_walls_code = (TYPEOF(le.Input_exterior_walls_code))'','',':exterior_walls_code')
    #END
 
+    #IF( #TEXT(Input_interior_walls_code)='' )
      '' 
    #ELSE
        IF( le.Input_interior_walls_code = (TYPEOF(le.Input_interior_walls_code))'','',':interior_walls_code')
    #END
 
+    #IF( #TEXT(Input_roof_cover_code)='' )
      '' 
    #ELSE
        IF( le.Input_roof_cover_code = (TYPEOF(le.Input_roof_cover_code))'','',':roof_cover_code')
    #END
 
+    #IF( #TEXT(Input_roof_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_roof_type_code = (TYPEOF(le.Input_roof_type_code))'','',':roof_type_code')
    #END
 
+    #IF( #TEXT(Input_floor_cover_code)='' )
      '' 
    #ELSE
        IF( le.Input_floor_cover_code = (TYPEOF(le.Input_floor_cover_code))'','',':floor_cover_code')
    #END
 
+    #IF( #TEXT(Input_water_code)='' )
      '' 
    #ELSE
        IF( le.Input_water_code = (TYPEOF(le.Input_water_code))'','',':water_code')
    #END
 
+    #IF( #TEXT(Input_sewer_code)='' )
      '' 
    #ELSE
        IF( le.Input_sewer_code = (TYPEOF(le.Input_sewer_code))'','',':sewer_code')
    #END
 
+    #IF( #TEXT(Input_heating_code)='' )
      '' 
    #ELSE
        IF( le.Input_heating_code = (TYPEOF(le.Input_heating_code))'','',':heating_code')
    #END
 
+    #IF( #TEXT(Input_heating_fuel_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_heating_fuel_type_code = (TYPEOF(le.Input_heating_fuel_type_code))'','',':heating_fuel_type_code')
    #END
 
+    #IF( #TEXT(Input_air_conditioning_code)='' )
      '' 
    #ELSE
        IF( le.Input_air_conditioning_code = (TYPEOF(le.Input_air_conditioning_code))'','',':air_conditioning_code')
    #END
 
+    #IF( #TEXT(Input_air_conditioning_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_air_conditioning_type_code = (TYPEOF(le.Input_air_conditioning_type_code))'','',':air_conditioning_type_code')
    #END
 
+    #IF( #TEXT(Input_elevator)='' )
      '' 
    #ELSE
        IF( le.Input_elevator = (TYPEOF(le.Input_elevator))'','',':elevator')
    #END
 
+    #IF( #TEXT(Input_fireplace_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_fireplace_indicator = (TYPEOF(le.Input_fireplace_indicator))'','',':fireplace_indicator')
    #END
 
+    #IF( #TEXT(Input_fireplace_number)='' )
      '' 
    #ELSE
        IF( le.Input_fireplace_number = (TYPEOF(le.Input_fireplace_number))'','',':fireplace_number')
    #END
 
+    #IF( #TEXT(Input_basement_code)='' )
      '' 
    #ELSE
        IF( le.Input_basement_code = (TYPEOF(le.Input_basement_code))'','',':basement_code')
    #END
 
+    #IF( #TEXT(Input_building_class_code)='' )
      '' 
    #ELSE
        IF( le.Input_building_class_code = (TYPEOF(le.Input_building_class_code))'','',':building_class_code')
    #END
 
+    #IF( #TEXT(Input_site_influence1_code)='' )
      '' 
    #ELSE
        IF( le.Input_site_influence1_code = (TYPEOF(le.Input_site_influence1_code))'','',':site_influence1_code')
    #END
 
+    #IF( #TEXT(Input_site_influence2_code)='' )
      '' 
    #ELSE
        IF( le.Input_site_influence2_code = (TYPEOF(le.Input_site_influence2_code))'','',':site_influence2_code')
    #END
 
+    #IF( #TEXT(Input_site_influence3_code)='' )
      '' 
    #ELSE
        IF( le.Input_site_influence3_code = (TYPEOF(le.Input_site_influence3_code))'','',':site_influence3_code')
    #END
 
+    #IF( #TEXT(Input_site_influence4_code)='' )
      '' 
    #ELSE
        IF( le.Input_site_influence4_code = (TYPEOF(le.Input_site_influence4_code))'','',':site_influence4_code')
    #END
 
+    #IF( #TEXT(Input_site_influence5_code)='' )
      '' 
    #ELSE
        IF( le.Input_site_influence5_code = (TYPEOF(le.Input_site_influence5_code))'','',':site_influence5_code')
    #END
 
+    #IF( #TEXT(Input_amenities1_code)='' )
      '' 
    #ELSE
        IF( le.Input_amenities1_code = (TYPEOF(le.Input_amenities1_code))'','',':amenities1_code')
    #END
 
+    #IF( #TEXT(Input_amenities2_code)='' )
      '' 
    #ELSE
        IF( le.Input_amenities2_code = (TYPEOF(le.Input_amenities2_code))'','',':amenities2_code')
    #END
 
+    #IF( #TEXT(Input_amenities3_code)='' )
      '' 
    #ELSE
        IF( le.Input_amenities3_code = (TYPEOF(le.Input_amenities3_code))'','',':amenities3_code')
    #END
 
+    #IF( #TEXT(Input_amenities4_code)='' )
      '' 
    #ELSE
        IF( le.Input_amenities4_code = (TYPEOF(le.Input_amenities4_code))'','',':amenities4_code')
    #END
 
+    #IF( #TEXT(Input_amenities5_code)='' )
      '' 
    #ELSE
        IF( le.Input_amenities5_code = (TYPEOF(le.Input_amenities5_code))'','',':amenities5_code')
    #END
 
+    #IF( #TEXT(Input_amenities2_code1)='' )
      '' 
    #ELSE
        IF( le.Input_amenities2_code1 = (TYPEOF(le.Input_amenities2_code1))'','',':amenities2_code1')
    #END
 
+    #IF( #TEXT(Input_amenities2_code2)='' )
      '' 
    #ELSE
        IF( le.Input_amenities2_code2 = (TYPEOF(le.Input_amenities2_code2))'','',':amenities2_code2')
    #END
 
+    #IF( #TEXT(Input_amenities2_code3)='' )
      '' 
    #ELSE
        IF( le.Input_amenities2_code3 = (TYPEOF(le.Input_amenities2_code3))'','',':amenities2_code3')
    #END
 
+    #IF( #TEXT(Input_amenities2_code4)='' )
      '' 
    #ELSE
        IF( le.Input_amenities2_code4 = (TYPEOF(le.Input_amenities2_code4))'','',':amenities2_code4')
    #END
 
+    #IF( #TEXT(Input_amenities2_code5)='' )
      '' 
    #ELSE
        IF( le.Input_amenities2_code5 = (TYPEOF(le.Input_amenities2_code5))'','',':amenities2_code5')
    #END
 
+    #IF( #TEXT(Input_extra_features1_area)='' )
      '' 
    #ELSE
        IF( le.Input_extra_features1_area = (TYPEOF(le.Input_extra_features1_area))'','',':extra_features1_area')
    #END
 
+    #IF( #TEXT(Input_extra_features1_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_extra_features1_indicator = (TYPEOF(le.Input_extra_features1_indicator))'','',':extra_features1_indicator')
    #END
 
+    #IF( #TEXT(Input_extra_features2_area)='' )
      '' 
    #ELSE
        IF( le.Input_extra_features2_area = (TYPEOF(le.Input_extra_features2_area))'','',':extra_features2_area')
    #END
 
+    #IF( #TEXT(Input_extra_features2_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_extra_features2_indicator = (TYPEOF(le.Input_extra_features2_indicator))'','',':extra_features2_indicator')
    #END
 
+    #IF( #TEXT(Input_extra_features3_area)='' )
      '' 
    #ELSE
        IF( le.Input_extra_features3_area = (TYPEOF(le.Input_extra_features3_area))'','',':extra_features3_area')
    #END
 
+    #IF( #TEXT(Input_extra_features3_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_extra_features3_indicator = (TYPEOF(le.Input_extra_features3_indicator))'','',':extra_features3_indicator')
    #END
 
+    #IF( #TEXT(Input_extra_features4_area)='' )
      '' 
    #ELSE
        IF( le.Input_extra_features4_area = (TYPEOF(le.Input_extra_features4_area))'','',':extra_features4_area')
    #END
 
+    #IF( #TEXT(Input_extra_features4_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_extra_features4_indicator = (TYPEOF(le.Input_extra_features4_indicator))'','',':extra_features4_indicator')
    #END
 
+    #IF( #TEXT(Input_other_buildings1_code)='' )
      '' 
    #ELSE
        IF( le.Input_other_buildings1_code = (TYPEOF(le.Input_other_buildings1_code))'','',':other_buildings1_code')
    #END
 
+    #IF( #TEXT(Input_other_buildings2_code)='' )
      '' 
    #ELSE
        IF( le.Input_other_buildings2_code = (TYPEOF(le.Input_other_buildings2_code))'','',':other_buildings2_code')
    #END
 
+    #IF( #TEXT(Input_other_buildings3_code)='' )
      '' 
    #ELSE
        IF( le.Input_other_buildings3_code = (TYPEOF(le.Input_other_buildings3_code))'','',':other_buildings3_code')
    #END
 
+    #IF( #TEXT(Input_other_buildings4_code)='' )
      '' 
    #ELSE
        IF( le.Input_other_buildings4_code = (TYPEOF(le.Input_other_buildings4_code))'','',':other_buildings4_code')
    #END
 
+    #IF( #TEXT(Input_other_buildings5_code)='' )
      '' 
    #ELSE
        IF( le.Input_other_buildings5_code = (TYPEOF(le.Input_other_buildings5_code))'','',':other_buildings5_code')
    #END
 
+    #IF( #TEXT(Input_other_impr_building1_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building1_indicator = (TYPEOF(le.Input_other_impr_building1_indicator))'','',':other_impr_building1_indicator')
    #END
 
+    #IF( #TEXT(Input_other_impr_building2_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building2_indicator = (TYPEOF(le.Input_other_impr_building2_indicator))'','',':other_impr_building2_indicator')
    #END
 
+    #IF( #TEXT(Input_other_impr_building3_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building3_indicator = (TYPEOF(le.Input_other_impr_building3_indicator))'','',':other_impr_building3_indicator')
    #END
 
+    #IF( #TEXT(Input_other_impr_building4_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building4_indicator = (TYPEOF(le.Input_other_impr_building4_indicator))'','',':other_impr_building4_indicator')
    #END
 
+    #IF( #TEXT(Input_other_impr_building5_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building5_indicator = (TYPEOF(le.Input_other_impr_building5_indicator))'','',':other_impr_building5_indicator')
    #END
 
+    #IF( #TEXT(Input_other_impr_building_area1)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building_area1 = (TYPEOF(le.Input_other_impr_building_area1))'','',':other_impr_building_area1')
    #END
 
+    #IF( #TEXT(Input_other_impr_building_area2)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building_area2 = (TYPEOF(le.Input_other_impr_building_area2))'','',':other_impr_building_area2')
    #END
 
+    #IF( #TEXT(Input_other_impr_building_area3)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building_area3 = (TYPEOF(le.Input_other_impr_building_area3))'','',':other_impr_building_area3')
    #END
 
+    #IF( #TEXT(Input_other_impr_building_area4)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building_area4 = (TYPEOF(le.Input_other_impr_building_area4))'','',':other_impr_building_area4')
    #END
 
+    #IF( #TEXT(Input_other_impr_building_area5)='' )
      '' 
    #ELSE
        IF( le.Input_other_impr_building_area5 = (TYPEOF(le.Input_other_impr_building_area5))'','',':other_impr_building_area5')
    #END
 
+    #IF( #TEXT(Input_topograpy_code)='' )
      '' 
    #ELSE
        IF( le.Input_topograpy_code = (TYPEOF(le.Input_topograpy_code))'','',':topograpy_code')
    #END
 
+    #IF( #TEXT(Input_neighborhood_code)='' )
      '' 
    #ELSE
        IF( le.Input_neighborhood_code = (TYPEOF(le.Input_neighborhood_code))'','',':neighborhood_code')
    #END
 
+    #IF( #TEXT(Input_condo_project_or_building_name)='' )
      '' 
    #ELSE
        IF( le.Input_condo_project_or_building_name = (TYPEOF(le.Input_condo_project_or_building_name))'','',':condo_project_or_building_name')
    #END
 
+    #IF( #TEXT(Input_assessee_name_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_assessee_name_indicator = (TYPEOF(le.Input_assessee_name_indicator))'','',':assessee_name_indicator')
    #END
 
+    #IF( #TEXT(Input_second_assessee_name_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_second_assessee_name_indicator = (TYPEOF(le.Input_second_assessee_name_indicator))'','',':second_assessee_name_indicator')
    #END
 
+    #IF( #TEXT(Input_other_rooms_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_other_rooms_indicator = (TYPEOF(le.Input_other_rooms_indicator))'','',':other_rooms_indicator')
    #END
 
+    #IF( #TEXT(Input_mail_care_of_name_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_mail_care_of_name_indicator = (TYPEOF(le.Input_mail_care_of_name_indicator))'','',':mail_care_of_name_indicator')
    #END
 
+    #IF( #TEXT(Input_comments)='' )
      '' 
    #ELSE
        IF( le.Input_comments = (TYPEOF(le.Input_comments))'','',':comments')
    #END
 
+    #IF( #TEXT(Input_tape_cut_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_tape_cut_date = 0,'', ':tape_cut_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_tape_cut_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_certification_date)='' )
      '' 
    #ELSE
        IF( (unsigned)le.Input_certification_date = 0,'', ':certification_date(' + SALT311.fn_date_valid_as_text((unsigned)le.Input_certification_date) + ')' )
    #END
 
+    #IF( #TEXT(Input_edition_number)='' )
      '' 
    #ELSE
        IF( le.Input_edition_number = (TYPEOF(le.Input_edition_number))'','',':edition_number')
    #END
 
+    #IF( #TEXT(Input_prop_addr_propagated_ind)='' )
      '' 
    #ELSE
        IF( le.Input_prop_addr_propagated_ind = (TYPEOF(le.Input_prop_addr_propagated_ind))'','',':prop_addr_propagated_ind')
    #END
 
+    #IF( #TEXT(Input_ln_ownership_rights)='' )
      '' 
    #ELSE
        IF( le.Input_ln_ownership_rights = (TYPEOF(le.Input_ln_ownership_rights))'','',':ln_ownership_rights')
    #END
 
+    #IF( #TEXT(Input_ln_relationship_type)='' )
      '' 
    #ELSE
        IF( le.Input_ln_relationship_type = (TYPEOF(le.Input_ln_relationship_type))'','',':ln_relationship_type')
    #END
 
+    #IF( #TEXT(Input_ln_mailing_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_ln_mailing_country_code = (TYPEOF(le.Input_ln_mailing_country_code))'','',':ln_mailing_country_code')
    #END
 
+    #IF( #TEXT(Input_ln_property_name)='' )
      '' 
    #ELSE
        IF( le.Input_ln_property_name = (TYPEOF(le.Input_ln_property_name))'','',':ln_property_name')
    #END
 
+    #IF( #TEXT(Input_ln_property_name_type)='' )
      '' 
    #ELSE
        IF( le.Input_ln_property_name_type = (TYPEOF(le.Input_ln_property_name_type))'','',':ln_property_name_type')
    #END
 
+    #IF( #TEXT(Input_ln_land_use_category)='' )
      '' 
    #ELSE
        IF( le.Input_ln_land_use_category = (TYPEOF(le.Input_ln_land_use_category))'','',':ln_land_use_category')
    #END
 
+    #IF( #TEXT(Input_ln_lot)='' )
      '' 
    #ELSE
        IF( le.Input_ln_lot = (TYPEOF(le.Input_ln_lot))'','',':ln_lot')
    #END
 
+    #IF( #TEXT(Input_ln_block)='' )
      '' 
    #ELSE
        IF( le.Input_ln_block = (TYPEOF(le.Input_ln_block))'','',':ln_block')
    #END
 
+    #IF( #TEXT(Input_ln_unit)='' )
      '' 
    #ELSE
        IF( le.Input_ln_unit = (TYPEOF(le.Input_ln_unit))'','',':ln_unit')
    #END
 
+    #IF( #TEXT(Input_ln_subfloor)='' )
      '' 
    #ELSE
        IF( le.Input_ln_subfloor = (TYPEOF(le.Input_ln_subfloor))'','',':ln_subfloor')
    #END
 
+    #IF( #TEXT(Input_ln_floor_cover)='' )
      '' 
    #ELSE
        IF( le.Input_ln_floor_cover = (TYPEOF(le.Input_ln_floor_cover))'','',':ln_floor_cover')
    #END
 
+    #IF( #TEXT(Input_ln_mobile_home_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_ln_mobile_home_indicator = (TYPEOF(le.Input_ln_mobile_home_indicator))'','',':ln_mobile_home_indicator')
    #END
 
+    #IF( #TEXT(Input_ln_condo_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_ln_condo_indicator = (TYPEOF(le.Input_ln_condo_indicator))'','',':ln_condo_indicator')
    #END
 
+    #IF( #TEXT(Input_ln_property_tax_exemption)='' )
      '' 
    #ELSE
        IF( le.Input_ln_property_tax_exemption = (TYPEOF(le.Input_ln_property_tax_exemption))'','',':ln_property_tax_exemption')
    #END
 
+    #IF( #TEXT(Input_ln_veteran_status)='' )
      '' 
    #ELSE
        IF( le.Input_ln_veteran_status = (TYPEOF(le.Input_ln_veteran_status))'','',':ln_veteran_status')
    #END
 
+    #IF( #TEXT(Input_ln_old_apn_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_ln_old_apn_indicator = (TYPEOF(le.Input_ln_old_apn_indicator))'','',':ln_old_apn_indicator')
    #END
 
+    #IF( #TEXT(Input_fips)='' )
      '' 
    #ELSE
        IF( le.Input_fips = (TYPEOF(le.Input_fips))'','',':fips')
    #END
;
    #IF (#TEXT(fips_code)<>'')
    SELF.source := le.fips_code;
    #END
  END;
  #uniquename(op)
  %op% := PROJECT(infile,%ot%(LEFT));
  #uniquename(ort)
  %ort% := RECORD
    #IF (#TEXT(fips_code)<>'')
    %op%.source;
    #END
    %op%.fields;
    UNSIGNED cnt := COUNT(GROUP);
  END;
  outfile := TOPN( TABLE( %op%, %ort%,#IF( #TEXT(fips_code)<>'' ) source, #END fields, FEW ), 1000,#IF( #TEXT(fips_code)<>'' ) source, #END -cnt );
ENDMACRO;
