 
EXPORT MAC_PopulationStatistics(infile,Ref='',fips_code='',Input_ln_fares_id = '',Input_process_date = '',Input_vendor_source_flag = '',Input_current_record = '',Input_from_file = '',Input_fips_code = '',Input_state = '',Input_county_name = '',Input_record_type = '',Input_apnt_or_pin_number = '',Input_fares_unformatted_apn = '',Input_multi_apn_flag = '',Input_tax_id_number = '',Input_excise_tax_number = '',Input_buyer_or_borrower_ind = '',Input_name1 = '',Input_name1_id_code = '',Input_name2 = '',Input_name2_id_code = '',Input_vesting_code = '',Input_addendum_flag = '',Input_phone_number = '',Input_mailing_care_of = '',Input_mailing_street = '',Input_mailing_unit_number = '',Input_mailing_csz = '',Input_mailing_address_cd = '',Input_seller1 = '',Input_seller1_id_code = '',Input_seller2 = '',Input_seller2_id_code = '',Input_seller_addendum_flag = '',Input_seller_mailing_full_street_address = '',Input_seller_mailing_address_unit_number = '',Input_seller_mailing_address_citystatezip = '',Input_property_full_street_address = '',Input_property_address_unit_number = '',Input_property_address_citystatezip = '',Input_property_address_code = '',Input_legal_lot_code = '',Input_legal_lot_number = '',Input_legal_block = '',Input_legal_section = '',Input_legal_district = '',Input_legal_land_lot = '',Input_legal_unit = '',Input_legal_city_municipality_township = '',Input_legal_subdivision_name = '',Input_legal_phase_number = '',Input_legal_tract_number = '',Input_legal_sec_twn_rng_mer = '',Input_legal_brief_description = '',Input_recorder_map_reference = '',Input_complete_legal_description_code = '',Input_contract_date = '',Input_recording_date = '',Input_arm_reset_date = '',Input_document_number = '',Input_document_type_code = '',Input_loan_number = '',Input_recorder_book_number = '',Input_recorder_page_number = '',Input_concurrent_mortgage_book_page_document_number = '',Input_sales_price = '',Input_sales_price_code = '',Input_city_transfer_tax = '',Input_county_transfer_tax = '',Input_total_transfer_tax = '',Input_first_td_loan_amount = '',Input_second_td_loan_amount = '',Input_first_td_lender_type_code = '',Input_second_td_lender_type_code = '',Input_first_td_loan_type_code = '',Input_type_financing = '',Input_first_td_interest_rate = '',Input_first_td_due_date = '',Input_title_company_name = '',Input_partial_interest_transferred = '',Input_loan_term_months = '',Input_loan_term_years = '',Input_lender_name = '',Input_lender_name_id = '',Input_lender_dba_aka_name = '',Input_lender_full_street_address = '',Input_lender_address_unit_number = '',Input_lender_address_citystatezip = '',Input_assessment_match_land_use_code = '',Input_property_use_code = '',Input_condo_code = '',Input_timeshare_flag = '',Input_land_lot_size = '',Input_hawaii_tct = '',Input_hawaii_condo_cpr_code = '',Input_hawaii_condo_name = '',Input_filler_except_hawaii = '',Input_rate_change_frequency = '',Input_change_index = '',Input_adjustable_rate_index = '',Input_adjustable_rate_rider = '',Input_graduated_payment_rider = '',Input_balloon_rider = '',Input_fixed_step_rate_rider = '',Input_condominium_rider = '',Input_planned_unit_development_rider = '',Input_rate_improvement_rider = '',Input_assumability_rider = '',Input_prepayment_rider = '',Input_one_four_family_rider = '',Input_biweekly_payment_rider = '',Input_second_home_rider = '',Input_data_source_code = '',Input_main_record_id_code = '',Input_addl_name_flag = '',Input_prop_addr_propagated_ind = '',Input_ln_ownership_rights = '',Input_ln_relationship_type = '',Input_ln_buyer_mailing_country_code = '',Input_ln_seller_mailing_country_code = '',OutFile) := MACRO
  IMPORT SALT311,Scrubs_LN_PropertyV2_Deed;
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
 
+    #IF( #TEXT(Input_from_file)='' )
      '' 
    #ELSE
        IF( le.Input_from_file = (TYPEOF(le.Input_from_file))'','',':from_file')
    #END
 
+    #IF( #TEXT(Input_fips_code)='' )
      '' 
    #ELSE
        IF( le.Input_fips_code = (TYPEOF(le.Input_fips_code))'','',':fips_code')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_county_name)='' )
      '' 
    #ELSE
        IF( le.Input_county_name = (TYPEOF(le.Input_county_name))'','',':county_name')
    #END
 
+    #IF( #TEXT(Input_record_type)='' )
      '' 
    #ELSE
        IF( le.Input_record_type = (TYPEOF(le.Input_record_type))'','',':record_type')
    #END
 
+    #IF( #TEXT(Input_apnt_or_pin_number)='' )
      '' 
    #ELSE
        IF( le.Input_apnt_or_pin_number = (TYPEOF(le.Input_apnt_or_pin_number))'','',':apnt_or_pin_number')
    #END
 
+    #IF( #TEXT(Input_fares_unformatted_apn)='' )
      '' 
    #ELSE
        IF( le.Input_fares_unformatted_apn = (TYPEOF(le.Input_fares_unformatted_apn))'','',':fares_unformatted_apn')
    #END
 
+    #IF( #TEXT(Input_multi_apn_flag)='' )
      '' 
    #ELSE
        IF( le.Input_multi_apn_flag = (TYPEOF(le.Input_multi_apn_flag))'','',':multi_apn_flag')
    #END
 
+    #IF( #TEXT(Input_tax_id_number)='' )
      '' 
    #ELSE
        IF( le.Input_tax_id_number = (TYPEOF(le.Input_tax_id_number))'','',':tax_id_number')
    #END
 
+    #IF( #TEXT(Input_excise_tax_number)='' )
      '' 
    #ELSE
        IF( le.Input_excise_tax_number = (TYPEOF(le.Input_excise_tax_number))'','',':excise_tax_number')
    #END
 
+    #IF( #TEXT(Input_buyer_or_borrower_ind)='' )
      '' 
    #ELSE
        IF( le.Input_buyer_or_borrower_ind = (TYPEOF(le.Input_buyer_or_borrower_ind))'','',':buyer_or_borrower_ind')
    #END
 
+    #IF( #TEXT(Input_name1)='' )
      '' 
    #ELSE
        IF( le.Input_name1 = (TYPEOF(le.Input_name1))'','',':name1')
    #END
 
+    #IF( #TEXT(Input_name1_id_code)='' )
      '' 
    #ELSE
        IF( le.Input_name1_id_code = (TYPEOF(le.Input_name1_id_code))'','',':name1_id_code')
    #END
 
+    #IF( #TEXT(Input_name2)='' )
      '' 
    #ELSE
        IF( le.Input_name2 = (TYPEOF(le.Input_name2))'','',':name2')
    #END
 
+    #IF( #TEXT(Input_name2_id_code)='' )
      '' 
    #ELSE
        IF( le.Input_name2_id_code = (TYPEOF(le.Input_name2_id_code))'','',':name2_id_code')
    #END
 
+    #IF( #TEXT(Input_vesting_code)='' )
      '' 
    #ELSE
        IF( le.Input_vesting_code = (TYPEOF(le.Input_vesting_code))'','',':vesting_code')
    #END
 
+    #IF( #TEXT(Input_addendum_flag)='' )
      '' 
    #ELSE
        IF( le.Input_addendum_flag = (TYPEOF(le.Input_addendum_flag))'','',':addendum_flag')
    #END
 
+    #IF( #TEXT(Input_phone_number)='' )
      '' 
    #ELSE
        IF( le.Input_phone_number = (TYPEOF(le.Input_phone_number))'','',':phone_number')
    #END
 
+    #IF( #TEXT(Input_mailing_care_of)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_care_of = (TYPEOF(le.Input_mailing_care_of))'','',':mailing_care_of')
    #END
 
+    #IF( #TEXT(Input_mailing_street)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_street = (TYPEOF(le.Input_mailing_street))'','',':mailing_street')
    #END
 
+    #IF( #TEXT(Input_mailing_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_unit_number = (TYPEOF(le.Input_mailing_unit_number))'','',':mailing_unit_number')
    #END
 
+    #IF( #TEXT(Input_mailing_csz)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_csz = (TYPEOF(le.Input_mailing_csz))'','',':mailing_csz')
    #END
 
+    #IF( #TEXT(Input_mailing_address_cd)='' )
      '' 
    #ELSE
        IF( le.Input_mailing_address_cd = (TYPEOF(le.Input_mailing_address_cd))'','',':mailing_address_cd')
    #END
 
+    #IF( #TEXT(Input_seller1)='' )
      '' 
    #ELSE
        IF( le.Input_seller1 = (TYPEOF(le.Input_seller1))'','',':seller1')
    #END
 
+    #IF( #TEXT(Input_seller1_id_code)='' )
      '' 
    #ELSE
        IF( le.Input_seller1_id_code = (TYPEOF(le.Input_seller1_id_code))'','',':seller1_id_code')
    #END
 
+    #IF( #TEXT(Input_seller2)='' )
      '' 
    #ELSE
        IF( le.Input_seller2 = (TYPEOF(le.Input_seller2))'','',':seller2')
    #END
 
+    #IF( #TEXT(Input_seller2_id_code)='' )
      '' 
    #ELSE
        IF( le.Input_seller2_id_code = (TYPEOF(le.Input_seller2_id_code))'','',':seller2_id_code')
    #END
 
+    #IF( #TEXT(Input_seller_addendum_flag)='' )
      '' 
    #ELSE
        IF( le.Input_seller_addendum_flag = (TYPEOF(le.Input_seller_addendum_flag))'','',':seller_addendum_flag')
    #END
 
+    #IF( #TEXT(Input_seller_mailing_full_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_seller_mailing_full_street_address = (TYPEOF(le.Input_seller_mailing_full_street_address))'','',':seller_mailing_full_street_address')
    #END
 
+    #IF( #TEXT(Input_seller_mailing_address_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_seller_mailing_address_unit_number = (TYPEOF(le.Input_seller_mailing_address_unit_number))'','',':seller_mailing_address_unit_number')
    #END
 
+    #IF( #TEXT(Input_seller_mailing_address_citystatezip)='' )
      '' 
    #ELSE
        IF( le.Input_seller_mailing_address_citystatezip = (TYPEOF(le.Input_seller_mailing_address_citystatezip))'','',':seller_mailing_address_citystatezip')
    #END
 
+    #IF( #TEXT(Input_property_full_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_property_full_street_address = (TYPEOF(le.Input_property_full_street_address))'','',':property_full_street_address')
    #END
 
+    #IF( #TEXT(Input_property_address_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_property_address_unit_number = (TYPEOF(le.Input_property_address_unit_number))'','',':property_address_unit_number')
    #END
 
+    #IF( #TEXT(Input_property_address_citystatezip)='' )
      '' 
    #ELSE
        IF( le.Input_property_address_citystatezip = (TYPEOF(le.Input_property_address_citystatezip))'','',':property_address_citystatezip')
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
 
+    #IF( #TEXT(Input_legal_land_lot)='' )
      '' 
    #ELSE
        IF( le.Input_legal_land_lot = (TYPEOF(le.Input_legal_land_lot))'','',':legal_land_lot')
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
 
+    #IF( #TEXT(Input_recorder_map_reference)='' )
      '' 
    #ELSE
        IF( le.Input_recorder_map_reference = (TYPEOF(le.Input_recorder_map_reference))'','',':recorder_map_reference')
    #END
 
+    #IF( #TEXT(Input_complete_legal_description_code)='' )
      '' 
    #ELSE
        IF( le.Input_complete_legal_description_code = (TYPEOF(le.Input_complete_legal_description_code))'','',':complete_legal_description_code')
    #END
 
+    #IF( #TEXT(Input_contract_date)='' )
      '' 
    #ELSE
        IF( le.Input_contract_date = (TYPEOF(le.Input_contract_date))'','',':contract_date')
    #END
 
+    #IF( #TEXT(Input_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_recording_date = (TYPEOF(le.Input_recording_date))'','',':recording_date')
    #END
 
+    #IF( #TEXT(Input_arm_reset_date)='' )
      '' 
    #ELSE
        IF( le.Input_arm_reset_date = (TYPEOF(le.Input_arm_reset_date))'','',':arm_reset_date')
    #END
 
+    #IF( #TEXT(Input_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_document_number = (TYPEOF(le.Input_document_number))'','',':document_number')
    #END
 
+    #IF( #TEXT(Input_document_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_document_type_code = (TYPEOF(le.Input_document_type_code))'','',':document_type_code')
    #END
 
+    #IF( #TEXT(Input_loan_number)='' )
      '' 
    #ELSE
        IF( le.Input_loan_number = (TYPEOF(le.Input_loan_number))'','',':loan_number')
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
 
+    #IF( #TEXT(Input_concurrent_mortgage_book_page_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_concurrent_mortgage_book_page_document_number = (TYPEOF(le.Input_concurrent_mortgage_book_page_document_number))'','',':concurrent_mortgage_book_page_document_number')
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
 
+    #IF( #TEXT(Input_city_transfer_tax)='' )
      '' 
    #ELSE
        IF( le.Input_city_transfer_tax = (TYPEOF(le.Input_city_transfer_tax))'','',':city_transfer_tax')
    #END
 
+    #IF( #TEXT(Input_county_transfer_tax)='' )
      '' 
    #ELSE
        IF( le.Input_county_transfer_tax = (TYPEOF(le.Input_county_transfer_tax))'','',':county_transfer_tax')
    #END
 
+    #IF( #TEXT(Input_total_transfer_tax)='' )
      '' 
    #ELSE
        IF( le.Input_total_transfer_tax = (TYPEOF(le.Input_total_transfer_tax))'','',':total_transfer_tax')
    #END
 
+    #IF( #TEXT(Input_first_td_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_first_td_loan_amount = (TYPEOF(le.Input_first_td_loan_amount))'','',':first_td_loan_amount')
    #END
 
+    #IF( #TEXT(Input_second_td_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_second_td_loan_amount = (TYPEOF(le.Input_second_td_loan_amount))'','',':second_td_loan_amount')
    #END
 
+    #IF( #TEXT(Input_first_td_lender_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_first_td_lender_type_code = (TYPEOF(le.Input_first_td_lender_type_code))'','',':first_td_lender_type_code')
    #END
 
+    #IF( #TEXT(Input_second_td_lender_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_second_td_lender_type_code = (TYPEOF(le.Input_second_td_lender_type_code))'','',':second_td_lender_type_code')
    #END
 
+    #IF( #TEXT(Input_first_td_loan_type_code)='' )
      '' 
    #ELSE
        IF( le.Input_first_td_loan_type_code = (TYPEOF(le.Input_first_td_loan_type_code))'','',':first_td_loan_type_code')
    #END
 
+    #IF( #TEXT(Input_type_financing)='' )
      '' 
    #ELSE
        IF( le.Input_type_financing = (TYPEOF(le.Input_type_financing))'','',':type_financing')
    #END
 
+    #IF( #TEXT(Input_first_td_interest_rate)='' )
      '' 
    #ELSE
        IF( le.Input_first_td_interest_rate = (TYPEOF(le.Input_first_td_interest_rate))'','',':first_td_interest_rate')
    #END
 
+    #IF( #TEXT(Input_first_td_due_date)='' )
      '' 
    #ELSE
        IF( le.Input_first_td_due_date = (TYPEOF(le.Input_first_td_due_date))'','',':first_td_due_date')
    #END
 
+    #IF( #TEXT(Input_title_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_title_company_name = (TYPEOF(le.Input_title_company_name))'','',':title_company_name')
    #END
 
+    #IF( #TEXT(Input_partial_interest_transferred)='' )
      '' 
    #ELSE
        IF( le.Input_partial_interest_transferred = (TYPEOF(le.Input_partial_interest_transferred))'','',':partial_interest_transferred')
    #END
 
+    #IF( #TEXT(Input_loan_term_months)='' )
      '' 
    #ELSE
        IF( le.Input_loan_term_months = (TYPEOF(le.Input_loan_term_months))'','',':loan_term_months')
    #END
 
+    #IF( #TEXT(Input_loan_term_years)='' )
      '' 
    #ELSE
        IF( le.Input_loan_term_years = (TYPEOF(le.Input_loan_term_years))'','',':loan_term_years')
    #END
 
+    #IF( #TEXT(Input_lender_name)='' )
      '' 
    #ELSE
        IF( le.Input_lender_name = (TYPEOF(le.Input_lender_name))'','',':lender_name')
    #END
 
+    #IF( #TEXT(Input_lender_name_id)='' )
      '' 
    #ELSE
        IF( le.Input_lender_name_id = (TYPEOF(le.Input_lender_name_id))'','',':lender_name_id')
    #END
 
+    #IF( #TEXT(Input_lender_dba_aka_name)='' )
      '' 
    #ELSE
        IF( le.Input_lender_dba_aka_name = (TYPEOF(le.Input_lender_dba_aka_name))'','',':lender_dba_aka_name')
    #END
 
+    #IF( #TEXT(Input_lender_full_street_address)='' )
      '' 
    #ELSE
        IF( le.Input_lender_full_street_address = (TYPEOF(le.Input_lender_full_street_address))'','',':lender_full_street_address')
    #END
 
+    #IF( #TEXT(Input_lender_address_unit_number)='' )
      '' 
    #ELSE
        IF( le.Input_lender_address_unit_number = (TYPEOF(le.Input_lender_address_unit_number))'','',':lender_address_unit_number')
    #END
 
+    #IF( #TEXT(Input_lender_address_citystatezip)='' )
      '' 
    #ELSE
        IF( le.Input_lender_address_citystatezip = (TYPEOF(le.Input_lender_address_citystatezip))'','',':lender_address_citystatezip')
    #END
 
+    #IF( #TEXT(Input_assessment_match_land_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_assessment_match_land_use_code = (TYPEOF(le.Input_assessment_match_land_use_code))'','',':assessment_match_land_use_code')
    #END
 
+    #IF( #TEXT(Input_property_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_property_use_code = (TYPEOF(le.Input_property_use_code))'','',':property_use_code')
    #END
 
+    #IF( #TEXT(Input_condo_code)='' )
      '' 
    #ELSE
        IF( le.Input_condo_code = (TYPEOF(le.Input_condo_code))'','',':condo_code')
    #END
 
+    #IF( #TEXT(Input_timeshare_flag)='' )
      '' 
    #ELSE
        IF( le.Input_timeshare_flag = (TYPEOF(le.Input_timeshare_flag))'','',':timeshare_flag')
    #END
 
+    #IF( #TEXT(Input_land_lot_size)='' )
      '' 
    #ELSE
        IF( le.Input_land_lot_size = (TYPEOF(le.Input_land_lot_size))'','',':land_lot_size')
    #END
 
+    #IF( #TEXT(Input_hawaii_tct)='' )
      '' 
    #ELSE
        IF( le.Input_hawaii_tct = (TYPEOF(le.Input_hawaii_tct))'','',':hawaii_tct')
    #END
 
+    #IF( #TEXT(Input_hawaii_condo_cpr_code)='' )
      '' 
    #ELSE
        IF( le.Input_hawaii_condo_cpr_code = (TYPEOF(le.Input_hawaii_condo_cpr_code))'','',':hawaii_condo_cpr_code')
    #END
 
+    #IF( #TEXT(Input_hawaii_condo_name)='' )
      '' 
    #ELSE
        IF( le.Input_hawaii_condo_name = (TYPEOF(le.Input_hawaii_condo_name))'','',':hawaii_condo_name')
    #END
 
+    #IF( #TEXT(Input_filler_except_hawaii)='' )
      '' 
    #ELSE
        IF( le.Input_filler_except_hawaii = (TYPEOF(le.Input_filler_except_hawaii))'','',':filler_except_hawaii')
    #END
 
+    #IF( #TEXT(Input_rate_change_frequency)='' )
      '' 
    #ELSE
        IF( le.Input_rate_change_frequency = (TYPEOF(le.Input_rate_change_frequency))'','',':rate_change_frequency')
    #END
 
+    #IF( #TEXT(Input_change_index)='' )
      '' 
    #ELSE
        IF( le.Input_change_index = (TYPEOF(le.Input_change_index))'','',':change_index')
    #END
 
+    #IF( #TEXT(Input_adjustable_rate_index)='' )
      '' 
    #ELSE
        IF( le.Input_adjustable_rate_index = (TYPEOF(le.Input_adjustable_rate_index))'','',':adjustable_rate_index')
    #END
 
+    #IF( #TEXT(Input_adjustable_rate_rider)='' )
      '' 
    #ELSE
        IF( le.Input_adjustable_rate_rider = (TYPEOF(le.Input_adjustable_rate_rider))'','',':adjustable_rate_rider')
    #END
 
+    #IF( #TEXT(Input_graduated_payment_rider)='' )
      '' 
    #ELSE
        IF( le.Input_graduated_payment_rider = (TYPEOF(le.Input_graduated_payment_rider))'','',':graduated_payment_rider')
    #END
 
+    #IF( #TEXT(Input_balloon_rider)='' )
      '' 
    #ELSE
        IF( le.Input_balloon_rider = (TYPEOF(le.Input_balloon_rider))'','',':balloon_rider')
    #END
 
+    #IF( #TEXT(Input_fixed_step_rate_rider)='' )
      '' 
    #ELSE
        IF( le.Input_fixed_step_rate_rider = (TYPEOF(le.Input_fixed_step_rate_rider))'','',':fixed_step_rate_rider')
    #END
 
+    #IF( #TEXT(Input_condominium_rider)='' )
      '' 
    #ELSE
        IF( le.Input_condominium_rider = (TYPEOF(le.Input_condominium_rider))'','',':condominium_rider')
    #END
 
+    #IF( #TEXT(Input_planned_unit_development_rider)='' )
      '' 
    #ELSE
        IF( le.Input_planned_unit_development_rider = (TYPEOF(le.Input_planned_unit_development_rider))'','',':planned_unit_development_rider')
    #END
 
+    #IF( #TEXT(Input_rate_improvement_rider)='' )
      '' 
    #ELSE
        IF( le.Input_rate_improvement_rider = (TYPEOF(le.Input_rate_improvement_rider))'','',':rate_improvement_rider')
    #END
 
+    #IF( #TEXT(Input_assumability_rider)='' )
      '' 
    #ELSE
        IF( le.Input_assumability_rider = (TYPEOF(le.Input_assumability_rider))'','',':assumability_rider')
    #END
 
+    #IF( #TEXT(Input_prepayment_rider)='' )
      '' 
    #ELSE
        IF( le.Input_prepayment_rider = (TYPEOF(le.Input_prepayment_rider))'','',':prepayment_rider')
    #END
 
+    #IF( #TEXT(Input_one_four_family_rider)='' )
      '' 
    #ELSE
        IF( le.Input_one_four_family_rider = (TYPEOF(le.Input_one_four_family_rider))'','',':one_four_family_rider')
    #END
 
+    #IF( #TEXT(Input_biweekly_payment_rider)='' )
      '' 
    #ELSE
        IF( le.Input_biweekly_payment_rider = (TYPEOF(le.Input_biweekly_payment_rider))'','',':biweekly_payment_rider')
    #END
 
+    #IF( #TEXT(Input_second_home_rider)='' )
      '' 
    #ELSE
        IF( le.Input_second_home_rider = (TYPEOF(le.Input_second_home_rider))'','',':second_home_rider')
    #END
 
+    #IF( #TEXT(Input_data_source_code)='' )
      '' 
    #ELSE
        IF( le.Input_data_source_code = (TYPEOF(le.Input_data_source_code))'','',':data_source_code')
    #END
 
+    #IF( #TEXT(Input_main_record_id_code)='' )
      '' 
    #ELSE
        IF( le.Input_main_record_id_code = (TYPEOF(le.Input_main_record_id_code))'','',':main_record_id_code')
    #END
 
+    #IF( #TEXT(Input_addl_name_flag)='' )
      '' 
    #ELSE
        IF( le.Input_addl_name_flag = (TYPEOF(le.Input_addl_name_flag))'','',':addl_name_flag')
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
 
+    #IF( #TEXT(Input_ln_buyer_mailing_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_ln_buyer_mailing_country_code = (TYPEOF(le.Input_ln_buyer_mailing_country_code))'','',':ln_buyer_mailing_country_code')
    #END
 
+    #IF( #TEXT(Input_ln_seller_mailing_country_code)='' )
      '' 
    #ELSE
        IF( le.Input_ln_seller_mailing_country_code = (TYPEOF(le.Input_ln_seller_mailing_country_code))'','',':ln_seller_mailing_country_code')
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
