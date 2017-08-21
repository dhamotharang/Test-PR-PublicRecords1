 
EXPORT MAC_PopulationStatistics(infile,Ref='',Input_foreclosure_id = '',Input_process_date = '',Input_state = '',Input_county = '',Input_batch_date_and_seq_nbr = '',Input_deed_category = '',Input_document_type = '',Input_recording_date = '',Input_document_year = '',Input_document_nbr = '',Input_document_book = '',Input_document_pages = '',Input_title_company_code = '',Input_title_company_name = '',Input_attorney_name = '',Input_attorney_phone_nbr = '',Input_first_defendant_borrower_owner_first_name = '',Input_first_defendant_borrower_owner_last_name = '',Input_first_defendant_borrower_company_name = '',Input_second_defendant_borrower_owner_first_name = '',Input_second_defendant_borrower_owner_last_name = '',Input_second_defendant_borrower_company_name = '',Input_third_defendant_borrower_owner_first_name = '',Input_third_defendant_borrower_owner_last_name = '',Input_third_defendant_borrower_company_name = '',Input_fourth_defendant_borrower_owner_first_name = '',Input_fourth_defendant_borrower_owner_last_name = '',Input_fourth_defendant_borrower_company_name = '',Input_defendant_borrower_owner_et_al_indicator = '',Input_filler1 = '',Input_date_of_default = '',Input_amount_of_default = '',Input_filler2 = '',Input_filing_date = '',Input_court_case_nbr = '',Input_lis_pendens_type = '',Input_plaintiff_1 = '',Input_plaintiff_2 = '',Input_final_judgment_amount = '',Input_filler_3 = '',Input_auction_date = '',Input_auction_time = '',Input_street_address_of_auction_call = '',Input_city_of_auction_call = '',Input_state_of_auction_call = '',Input_opening_bid = '',Input_tax_year = '',Input_filler4 = '',Input_sales_price = '',Input_situs_address_indicator_1 = '',Input_situs_house_number_prefix_1 = '',Input_situs_house_number_1 = '',Input_situs_house_number_suffix_1 = '',Input_situs_street_name_1 = '',Input_situs_mode_1 = '',Input_situs_direction_1 = '',Input_situs_quadrant_1 = '',Input_apartment_unit = '',Input_property_city_1 = '',Input_property_state_1 = '',Input_property_address_zip_code_1 = '',Input_carrier_code = '',Input_full_site_address_unparsed_1 = '',Input_lender_beneficiary_first_name = '',Input_lender_beneficiary_last_name = '',Input_lender_beneficiary_company_name = '',Input_lender_beneficiary_mailing_address = '',Input_lender_beneficiary_city = '',Input_lender_beneficiary_state = '',Input_lender_beneficiary_zip = '',Input_lender_phone = '',Input_filler_5 = '',Input_trustee_name = '',Input_trustee_mailing_address = '',Input_trustee_city = '',Input_trustee_state = '',Input_trustee_zip = '',Input_trustee_phone = '',Input_trustee_sale_number = '',Input_filler_6 = '',Input_original_loan_date = '',Input_original_loan_recording_date = '',Input_original_loan_amount = '',Input_original_document_number = '',Input_original_recording_book = '',Input_original_recording_page = '',Input_filler_7 = '',Input_parcel_number_parcel_id = '',Input_parcel_number_unmatched_id = '',Input_last_full_sale_transfer_date = '',Input_transfer_value = '',Input_situs_address_indicator_2 = '',Input_situs_house_number_prefix_2 = '',Input_situs_house_number_2 = '',Input_situs_house_number_suffix_2 = '',Input_situs_street_name_2 = '',Input_situs_mode_2 = '',Input_situs_direction_2 = '',Input_situs_quadrant_2 = '',Input_apartment_unit_2 = '',Input_property_city_2 = '',Input_property_state_2 = '',Input_property_address_zip_code_2 = '',Input_carrier_code_2 = '',Input_full_site_address_unparsed_2 = '',Input_property_indicator = '',Input_use_code = '',Input_number_of_units = '',Input_living_area_square_feet = '',Input_number_of_bedrooms = '',Input_number_of_bathrooms = '',Input_number_of_garages = '',Input_zoning_code = '',Input_lot_size = '',Input_year_built = '',Input_current_land_value = '',Input_current_improvement_value = '',Input_filler_8 = '',Input_section = '',Input_township = '',Input_range = '',Input_lot = '',Input_block = '',Input_tract_subdivision_name = '',Input_map_book = '',Input_map_page = '',Input_unit_nbr = '',Input_expanded_legal = '',Input_legal_2 = '',Input_legal_3 = '',Input_legal_4 = '',Input_crlf = '',Input_deed_desc = '',Input_document_desc = '',Input_et_al_desc = '',Input_property_desc = '',Input_use_desc = '',OutFile) := MACRO
  IMPORT SALT36,Scrubs_Property_Foreclosures;
  #uniquename(of)
  %of% := RECORD
    SALT36.Str512Type fields;
  END;
  #uniquename(ot)
  %of% %ot%(infile le) := TRANSFORM
    SELF.fields :=
    #IF( #TEXT(Input_foreclosure_id)='' )
      '' 
    #ELSE
        IF( le.Input_foreclosure_id = (TYPEOF(le.Input_foreclosure_id))'','',':foreclosure_id')
    #END
 
+    #IF( #TEXT(Input_process_date)='' )
      '' 
    #ELSE
        IF( le.Input_process_date = (TYPEOF(le.Input_process_date))'','',':process_date')
    #END
 
+    #IF( #TEXT(Input_state)='' )
      '' 
    #ELSE
        IF( le.Input_state = (TYPEOF(le.Input_state))'','',':state')
    #END
 
+    #IF( #TEXT(Input_county)='' )
      '' 
    #ELSE
        IF( le.Input_county = (TYPEOF(le.Input_county))'','',':county')
    #END
 
+    #IF( #TEXT(Input_batch_date_and_seq_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_batch_date_and_seq_nbr = (TYPEOF(le.Input_batch_date_and_seq_nbr))'','',':batch_date_and_seq_nbr')
    #END
 
+    #IF( #TEXT(Input_deed_category)='' )
      '' 
    #ELSE
        IF( le.Input_deed_category = (TYPEOF(le.Input_deed_category))'','',':deed_category')
    #END
 
+    #IF( #TEXT(Input_document_type)='' )
      '' 
    #ELSE
        IF( le.Input_document_type = (TYPEOF(le.Input_document_type))'','',':document_type')
    #END
 
+    #IF( #TEXT(Input_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_recording_date = (TYPEOF(le.Input_recording_date))'','',':recording_date')
    #END
 
+    #IF( #TEXT(Input_document_year)='' )
      '' 
    #ELSE
        IF( le.Input_document_year = (TYPEOF(le.Input_document_year))'','',':document_year')
    #END
 
+    #IF( #TEXT(Input_document_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_document_nbr = (TYPEOF(le.Input_document_nbr))'','',':document_nbr')
    #END
 
+    #IF( #TEXT(Input_document_book)='' )
      '' 
    #ELSE
        IF( le.Input_document_book = (TYPEOF(le.Input_document_book))'','',':document_book')
    #END
 
+    #IF( #TEXT(Input_document_pages)='' )
      '' 
    #ELSE
        IF( le.Input_document_pages = (TYPEOF(le.Input_document_pages))'','',':document_pages')
    #END
 
+    #IF( #TEXT(Input_title_company_code)='' )
      '' 
    #ELSE
        IF( le.Input_title_company_code = (TYPEOF(le.Input_title_company_code))'','',':title_company_code')
    #END
 
+    #IF( #TEXT(Input_title_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_title_company_name = (TYPEOF(le.Input_title_company_name))'','',':title_company_name')
    #END
 
+    #IF( #TEXT(Input_attorney_name)='' )
      '' 
    #ELSE
        IF( le.Input_attorney_name = (TYPEOF(le.Input_attorney_name))'','',':attorney_name')
    #END
 
+    #IF( #TEXT(Input_attorney_phone_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_attorney_phone_nbr = (TYPEOF(le.Input_attorney_phone_nbr))'','',':attorney_phone_nbr')
    #END
 
+    #IF( #TEXT(Input_first_defendant_borrower_owner_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_defendant_borrower_owner_first_name = (TYPEOF(le.Input_first_defendant_borrower_owner_first_name))'','',':first_defendant_borrower_owner_first_name')
    #END
 
+    #IF( #TEXT(Input_first_defendant_borrower_owner_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_defendant_borrower_owner_last_name = (TYPEOF(le.Input_first_defendant_borrower_owner_last_name))'','',':first_defendant_borrower_owner_last_name')
    #END
 
+    #IF( #TEXT(Input_first_defendant_borrower_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_first_defendant_borrower_company_name = (TYPEOF(le.Input_first_defendant_borrower_company_name))'','',':first_defendant_borrower_company_name')
    #END
 
+    #IF( #TEXT(Input_second_defendant_borrower_owner_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_second_defendant_borrower_owner_first_name = (TYPEOF(le.Input_second_defendant_borrower_owner_first_name))'','',':second_defendant_borrower_owner_first_name')
    #END
 
+    #IF( #TEXT(Input_second_defendant_borrower_owner_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_second_defendant_borrower_owner_last_name = (TYPEOF(le.Input_second_defendant_borrower_owner_last_name))'','',':second_defendant_borrower_owner_last_name')
    #END
 
+    #IF( #TEXT(Input_second_defendant_borrower_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_second_defendant_borrower_company_name = (TYPEOF(le.Input_second_defendant_borrower_company_name))'','',':second_defendant_borrower_company_name')
    #END
 
+    #IF( #TEXT(Input_third_defendant_borrower_owner_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_third_defendant_borrower_owner_first_name = (TYPEOF(le.Input_third_defendant_borrower_owner_first_name))'','',':third_defendant_borrower_owner_first_name')
    #END
 
+    #IF( #TEXT(Input_third_defendant_borrower_owner_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_third_defendant_borrower_owner_last_name = (TYPEOF(le.Input_third_defendant_borrower_owner_last_name))'','',':third_defendant_borrower_owner_last_name')
    #END
 
+    #IF( #TEXT(Input_third_defendant_borrower_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_third_defendant_borrower_company_name = (TYPEOF(le.Input_third_defendant_borrower_company_name))'','',':third_defendant_borrower_company_name')
    #END
 
+    #IF( #TEXT(Input_fourth_defendant_borrower_owner_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_fourth_defendant_borrower_owner_first_name = (TYPEOF(le.Input_fourth_defendant_borrower_owner_first_name))'','',':fourth_defendant_borrower_owner_first_name')
    #END
 
+    #IF( #TEXT(Input_fourth_defendant_borrower_owner_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_fourth_defendant_borrower_owner_last_name = (TYPEOF(le.Input_fourth_defendant_borrower_owner_last_name))'','',':fourth_defendant_borrower_owner_last_name')
    #END
 
+    #IF( #TEXT(Input_fourth_defendant_borrower_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_fourth_defendant_borrower_company_name = (TYPEOF(le.Input_fourth_defendant_borrower_company_name))'','',':fourth_defendant_borrower_company_name')
    #END
 
+    #IF( #TEXT(Input_defendant_borrower_owner_et_al_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_defendant_borrower_owner_et_al_indicator = (TYPEOF(le.Input_defendant_borrower_owner_et_al_indicator))'','',':defendant_borrower_owner_et_al_indicator')
    #END
 
+    #IF( #TEXT(Input_filler1)='' )
      '' 
    #ELSE
        IF( le.Input_filler1 = (TYPEOF(le.Input_filler1))'','',':filler1')
    #END
 
+    #IF( #TEXT(Input_date_of_default)='' )
      '' 
    #ELSE
        IF( le.Input_date_of_default = (TYPEOF(le.Input_date_of_default))'','',':date_of_default')
    #END
 
+    #IF( #TEXT(Input_amount_of_default)='' )
      '' 
    #ELSE
        IF( le.Input_amount_of_default = (TYPEOF(le.Input_amount_of_default))'','',':amount_of_default')
    #END
 
+    #IF( #TEXT(Input_filler2)='' )
      '' 
    #ELSE
        IF( le.Input_filler2 = (TYPEOF(le.Input_filler2))'','',':filler2')
    #END
 
+    #IF( #TEXT(Input_filing_date)='' )
      '' 
    #ELSE
        IF( le.Input_filing_date = (TYPEOF(le.Input_filing_date))'','',':filing_date')
    #END
 
+    #IF( #TEXT(Input_court_case_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_court_case_nbr = (TYPEOF(le.Input_court_case_nbr))'','',':court_case_nbr')
    #END
 
+    #IF( #TEXT(Input_lis_pendens_type)='' )
      '' 
    #ELSE
        IF( le.Input_lis_pendens_type = (TYPEOF(le.Input_lis_pendens_type))'','',':lis_pendens_type')
    #END
 
+    #IF( #TEXT(Input_plaintiff_1)='' )
      '' 
    #ELSE
        IF( le.Input_plaintiff_1 = (TYPEOF(le.Input_plaintiff_1))'','',':plaintiff_1')
    #END
 
+    #IF( #TEXT(Input_plaintiff_2)='' )
      '' 
    #ELSE
        IF( le.Input_plaintiff_2 = (TYPEOF(le.Input_plaintiff_2))'','',':plaintiff_2')
    #END
 
+    #IF( #TEXT(Input_final_judgment_amount)='' )
      '' 
    #ELSE
        IF( le.Input_final_judgment_amount = (TYPEOF(le.Input_final_judgment_amount))'','',':final_judgment_amount')
    #END
 
+    #IF( #TEXT(Input_filler_3)='' )
      '' 
    #ELSE
        IF( le.Input_filler_3 = (TYPEOF(le.Input_filler_3))'','',':filler_3')
    #END
 
+    #IF( #TEXT(Input_auction_date)='' )
      '' 
    #ELSE
        IF( le.Input_auction_date = (TYPEOF(le.Input_auction_date))'','',':auction_date')
    #END
 
+    #IF( #TEXT(Input_auction_time)='' )
      '' 
    #ELSE
        IF( le.Input_auction_time = (TYPEOF(le.Input_auction_time))'','',':auction_time')
    #END
 
+    #IF( #TEXT(Input_street_address_of_auction_call)='' )
      '' 
    #ELSE
        IF( le.Input_street_address_of_auction_call = (TYPEOF(le.Input_street_address_of_auction_call))'','',':street_address_of_auction_call')
    #END
 
+    #IF( #TEXT(Input_city_of_auction_call)='' )
      '' 
    #ELSE
        IF( le.Input_city_of_auction_call = (TYPEOF(le.Input_city_of_auction_call))'','',':city_of_auction_call')
    #END
 
+    #IF( #TEXT(Input_state_of_auction_call)='' )
      '' 
    #ELSE
        IF( le.Input_state_of_auction_call = (TYPEOF(le.Input_state_of_auction_call))'','',':state_of_auction_call')
    #END
 
+    #IF( #TEXT(Input_opening_bid)='' )
      '' 
    #ELSE
        IF( le.Input_opening_bid = (TYPEOF(le.Input_opening_bid))'','',':opening_bid')
    #END
 
+    #IF( #TEXT(Input_tax_year)='' )
      '' 
    #ELSE
        IF( le.Input_tax_year = (TYPEOF(le.Input_tax_year))'','',':tax_year')
    #END
 
+    #IF( #TEXT(Input_filler4)='' )
      '' 
    #ELSE
        IF( le.Input_filler4 = (TYPEOF(le.Input_filler4))'','',':filler4')
    #END
 
+    #IF( #TEXT(Input_sales_price)='' )
      '' 
    #ELSE
        IF( le.Input_sales_price = (TYPEOF(le.Input_sales_price))'','',':sales_price')
    #END
 
+    #IF( #TEXT(Input_situs_address_indicator_1)='' )
      '' 
    #ELSE
        IF( le.Input_situs_address_indicator_1 = (TYPEOF(le.Input_situs_address_indicator_1))'','',':situs_address_indicator_1')
    #END
 
+    #IF( #TEXT(Input_situs_house_number_prefix_1)='' )
      '' 
    #ELSE
        IF( le.Input_situs_house_number_prefix_1 = (TYPEOF(le.Input_situs_house_number_prefix_1))'','',':situs_house_number_prefix_1')
    #END
 
+    #IF( #TEXT(Input_situs_house_number_1)='' )
      '' 
    #ELSE
        IF( le.Input_situs_house_number_1 = (TYPEOF(le.Input_situs_house_number_1))'','',':situs_house_number_1')
    #END
 
+    #IF( #TEXT(Input_situs_house_number_suffix_1)='' )
      '' 
    #ELSE
        IF( le.Input_situs_house_number_suffix_1 = (TYPEOF(le.Input_situs_house_number_suffix_1))'','',':situs_house_number_suffix_1')
    #END
 
+    #IF( #TEXT(Input_situs_street_name_1)='' )
      '' 
    #ELSE
        IF( le.Input_situs_street_name_1 = (TYPEOF(le.Input_situs_street_name_1))'','',':situs_street_name_1')
    #END
 
+    #IF( #TEXT(Input_situs_mode_1)='' )
      '' 
    #ELSE
        IF( le.Input_situs_mode_1 = (TYPEOF(le.Input_situs_mode_1))'','',':situs_mode_1')
    #END
 
+    #IF( #TEXT(Input_situs_direction_1)='' )
      '' 
    #ELSE
        IF( le.Input_situs_direction_1 = (TYPEOF(le.Input_situs_direction_1))'','',':situs_direction_1')
    #END
 
+    #IF( #TEXT(Input_situs_quadrant_1)='' )
      '' 
    #ELSE
        IF( le.Input_situs_quadrant_1 = (TYPEOF(le.Input_situs_quadrant_1))'','',':situs_quadrant_1')
    #END
 
+    #IF( #TEXT(Input_apartment_unit)='' )
      '' 
    #ELSE
        IF( le.Input_apartment_unit = (TYPEOF(le.Input_apartment_unit))'','',':apartment_unit')
    #END
 
+    #IF( #TEXT(Input_property_city_1)='' )
      '' 
    #ELSE
        IF( le.Input_property_city_1 = (TYPEOF(le.Input_property_city_1))'','',':property_city_1')
    #END
 
+    #IF( #TEXT(Input_property_state_1)='' )
      '' 
    #ELSE
        IF( le.Input_property_state_1 = (TYPEOF(le.Input_property_state_1))'','',':property_state_1')
    #END
 
+    #IF( #TEXT(Input_property_address_zip_code_1)='' )
      '' 
    #ELSE
        IF( le.Input_property_address_zip_code_1 = (TYPEOF(le.Input_property_address_zip_code_1))'','',':property_address_zip_code_1')
    #END
 
+    #IF( #TEXT(Input_carrier_code)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_code = (TYPEOF(le.Input_carrier_code))'','',':carrier_code')
    #END
 
+    #IF( #TEXT(Input_full_site_address_unparsed_1)='' )
      '' 
    #ELSE
        IF( le.Input_full_site_address_unparsed_1 = (TYPEOF(le.Input_full_site_address_unparsed_1))'','',':full_site_address_unparsed_1')
    #END
 
+    #IF( #TEXT(Input_lender_beneficiary_first_name)='' )
      '' 
    #ELSE
        IF( le.Input_lender_beneficiary_first_name = (TYPEOF(le.Input_lender_beneficiary_first_name))'','',':lender_beneficiary_first_name')
    #END
 
+    #IF( #TEXT(Input_lender_beneficiary_last_name)='' )
      '' 
    #ELSE
        IF( le.Input_lender_beneficiary_last_name = (TYPEOF(le.Input_lender_beneficiary_last_name))'','',':lender_beneficiary_last_name')
    #END
 
+    #IF( #TEXT(Input_lender_beneficiary_company_name)='' )
      '' 
    #ELSE
        IF( le.Input_lender_beneficiary_company_name = (TYPEOF(le.Input_lender_beneficiary_company_name))'','',':lender_beneficiary_company_name')
    #END
 
+    #IF( #TEXT(Input_lender_beneficiary_mailing_address)='' )
      '' 
    #ELSE
        IF( le.Input_lender_beneficiary_mailing_address = (TYPEOF(le.Input_lender_beneficiary_mailing_address))'','',':lender_beneficiary_mailing_address')
    #END
 
+    #IF( #TEXT(Input_lender_beneficiary_city)='' )
      '' 
    #ELSE
        IF( le.Input_lender_beneficiary_city = (TYPEOF(le.Input_lender_beneficiary_city))'','',':lender_beneficiary_city')
    #END
 
+    #IF( #TEXT(Input_lender_beneficiary_state)='' )
      '' 
    #ELSE
        IF( le.Input_lender_beneficiary_state = (TYPEOF(le.Input_lender_beneficiary_state))'','',':lender_beneficiary_state')
    #END
 
+    #IF( #TEXT(Input_lender_beneficiary_zip)='' )
      '' 
    #ELSE
        IF( le.Input_lender_beneficiary_zip = (TYPEOF(le.Input_lender_beneficiary_zip))'','',':lender_beneficiary_zip')
    #END
 
+    #IF( #TEXT(Input_lender_phone)='' )
      '' 
    #ELSE
        IF( le.Input_lender_phone = (TYPEOF(le.Input_lender_phone))'','',':lender_phone')
    #END
 
+    #IF( #TEXT(Input_filler_5)='' )
      '' 
    #ELSE
        IF( le.Input_filler_5 = (TYPEOF(le.Input_filler_5))'','',':filler_5')
    #END
 
+    #IF( #TEXT(Input_trustee_name)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_name = (TYPEOF(le.Input_trustee_name))'','',':trustee_name')
    #END
 
+    #IF( #TEXT(Input_trustee_mailing_address)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_mailing_address = (TYPEOF(le.Input_trustee_mailing_address))'','',':trustee_mailing_address')
    #END
 
+    #IF( #TEXT(Input_trustee_city)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_city = (TYPEOF(le.Input_trustee_city))'','',':trustee_city')
    #END
 
+    #IF( #TEXT(Input_trustee_state)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_state = (TYPEOF(le.Input_trustee_state))'','',':trustee_state')
    #END
 
+    #IF( #TEXT(Input_trustee_zip)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_zip = (TYPEOF(le.Input_trustee_zip))'','',':trustee_zip')
    #END
 
+    #IF( #TEXT(Input_trustee_phone)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_phone = (TYPEOF(le.Input_trustee_phone))'','',':trustee_phone')
    #END
 
+    #IF( #TEXT(Input_trustee_sale_number)='' )
      '' 
    #ELSE
        IF( le.Input_trustee_sale_number = (TYPEOF(le.Input_trustee_sale_number))'','',':trustee_sale_number')
    #END
 
+    #IF( #TEXT(Input_filler_6)='' )
      '' 
    #ELSE
        IF( le.Input_filler_6 = (TYPEOF(le.Input_filler_6))'','',':filler_6')
    #END
 
+    #IF( #TEXT(Input_original_loan_date)='' )
      '' 
    #ELSE
        IF( le.Input_original_loan_date = (TYPEOF(le.Input_original_loan_date))'','',':original_loan_date')
    #END
 
+    #IF( #TEXT(Input_original_loan_recording_date)='' )
      '' 
    #ELSE
        IF( le.Input_original_loan_recording_date = (TYPEOF(le.Input_original_loan_recording_date))'','',':original_loan_recording_date')
    #END
 
+    #IF( #TEXT(Input_original_loan_amount)='' )
      '' 
    #ELSE
        IF( le.Input_original_loan_amount = (TYPEOF(le.Input_original_loan_amount))'','',':original_loan_amount')
    #END
 
+    #IF( #TEXT(Input_original_document_number)='' )
      '' 
    #ELSE
        IF( le.Input_original_document_number = (TYPEOF(le.Input_original_document_number))'','',':original_document_number')
    #END
 
+    #IF( #TEXT(Input_original_recording_book)='' )
      '' 
    #ELSE
        IF( le.Input_original_recording_book = (TYPEOF(le.Input_original_recording_book))'','',':original_recording_book')
    #END
 
+    #IF( #TEXT(Input_original_recording_page)='' )
      '' 
    #ELSE
        IF( le.Input_original_recording_page = (TYPEOF(le.Input_original_recording_page))'','',':original_recording_page')
    #END
 
+    #IF( #TEXT(Input_filler_7)='' )
      '' 
    #ELSE
        IF( le.Input_filler_7 = (TYPEOF(le.Input_filler_7))'','',':filler_7')
    #END
 
+    #IF( #TEXT(Input_parcel_number_parcel_id)='' )
      '' 
    #ELSE
        IF( le.Input_parcel_number_parcel_id = (TYPEOF(le.Input_parcel_number_parcel_id))'','',':parcel_number_parcel_id')
    #END
 
+    #IF( #TEXT(Input_parcel_number_unmatched_id)='' )
      '' 
    #ELSE
        IF( le.Input_parcel_number_unmatched_id = (TYPEOF(le.Input_parcel_number_unmatched_id))'','',':parcel_number_unmatched_id')
    #END
 
+    #IF( #TEXT(Input_last_full_sale_transfer_date)='' )
      '' 
    #ELSE
        IF( le.Input_last_full_sale_transfer_date = (TYPEOF(le.Input_last_full_sale_transfer_date))'','',':last_full_sale_transfer_date')
    #END
 
+    #IF( #TEXT(Input_transfer_value)='' )
      '' 
    #ELSE
        IF( le.Input_transfer_value = (TYPEOF(le.Input_transfer_value))'','',':transfer_value')
    #END
 
+    #IF( #TEXT(Input_situs_address_indicator_2)='' )
      '' 
    #ELSE
        IF( le.Input_situs_address_indicator_2 = (TYPEOF(le.Input_situs_address_indicator_2))'','',':situs_address_indicator_2')
    #END
 
+    #IF( #TEXT(Input_situs_house_number_prefix_2)='' )
      '' 
    #ELSE
        IF( le.Input_situs_house_number_prefix_2 = (TYPEOF(le.Input_situs_house_number_prefix_2))'','',':situs_house_number_prefix_2')
    #END
 
+    #IF( #TEXT(Input_situs_house_number_2)='' )
      '' 
    #ELSE
        IF( le.Input_situs_house_number_2 = (TYPEOF(le.Input_situs_house_number_2))'','',':situs_house_number_2')
    #END
 
+    #IF( #TEXT(Input_situs_house_number_suffix_2)='' )
      '' 
    #ELSE
        IF( le.Input_situs_house_number_suffix_2 = (TYPEOF(le.Input_situs_house_number_suffix_2))'','',':situs_house_number_suffix_2')
    #END
 
+    #IF( #TEXT(Input_situs_street_name_2)='' )
      '' 
    #ELSE
        IF( le.Input_situs_street_name_2 = (TYPEOF(le.Input_situs_street_name_2))'','',':situs_street_name_2')
    #END
 
+    #IF( #TEXT(Input_situs_mode_2)='' )
      '' 
    #ELSE
        IF( le.Input_situs_mode_2 = (TYPEOF(le.Input_situs_mode_2))'','',':situs_mode_2')
    #END
 
+    #IF( #TEXT(Input_situs_direction_2)='' )
      '' 
    #ELSE
        IF( le.Input_situs_direction_2 = (TYPEOF(le.Input_situs_direction_2))'','',':situs_direction_2')
    #END
 
+    #IF( #TEXT(Input_situs_quadrant_2)='' )
      '' 
    #ELSE
        IF( le.Input_situs_quadrant_2 = (TYPEOF(le.Input_situs_quadrant_2))'','',':situs_quadrant_2')
    #END
 
+    #IF( #TEXT(Input_apartment_unit_2)='' )
      '' 
    #ELSE
        IF( le.Input_apartment_unit_2 = (TYPEOF(le.Input_apartment_unit_2))'','',':apartment_unit_2')
    #END
 
+    #IF( #TEXT(Input_property_city_2)='' )
      '' 
    #ELSE
        IF( le.Input_property_city_2 = (TYPEOF(le.Input_property_city_2))'','',':property_city_2')
    #END
 
+    #IF( #TEXT(Input_property_state_2)='' )
      '' 
    #ELSE
        IF( le.Input_property_state_2 = (TYPEOF(le.Input_property_state_2))'','',':property_state_2')
    #END
 
+    #IF( #TEXT(Input_property_address_zip_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_property_address_zip_code_2 = (TYPEOF(le.Input_property_address_zip_code_2))'','',':property_address_zip_code_2')
    #END
 
+    #IF( #TEXT(Input_carrier_code_2)='' )
      '' 
    #ELSE
        IF( le.Input_carrier_code_2 = (TYPEOF(le.Input_carrier_code_2))'','',':carrier_code_2')
    #END
 
+    #IF( #TEXT(Input_full_site_address_unparsed_2)='' )
      '' 
    #ELSE
        IF( le.Input_full_site_address_unparsed_2 = (TYPEOF(le.Input_full_site_address_unparsed_2))'','',':full_site_address_unparsed_2')
    #END
 
+    #IF( #TEXT(Input_property_indicator)='' )
      '' 
    #ELSE
        IF( le.Input_property_indicator = (TYPEOF(le.Input_property_indicator))'','',':property_indicator')
    #END
 
+    #IF( #TEXT(Input_use_code)='' )
      '' 
    #ELSE
        IF( le.Input_use_code = (TYPEOF(le.Input_use_code))'','',':use_code')
    #END
 
+    #IF( #TEXT(Input_number_of_units)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_units = (TYPEOF(le.Input_number_of_units))'','',':number_of_units')
    #END
 
+    #IF( #TEXT(Input_living_area_square_feet)='' )
      '' 
    #ELSE
        IF( le.Input_living_area_square_feet = (TYPEOF(le.Input_living_area_square_feet))'','',':living_area_square_feet')
    #END
 
+    #IF( #TEXT(Input_number_of_bedrooms)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_bedrooms = (TYPEOF(le.Input_number_of_bedrooms))'','',':number_of_bedrooms')
    #END
 
+    #IF( #TEXT(Input_number_of_bathrooms)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_bathrooms = (TYPEOF(le.Input_number_of_bathrooms))'','',':number_of_bathrooms')
    #END
 
+    #IF( #TEXT(Input_number_of_garages)='' )
      '' 
    #ELSE
        IF( le.Input_number_of_garages = (TYPEOF(le.Input_number_of_garages))'','',':number_of_garages')
    #END
 
+    #IF( #TEXT(Input_zoning_code)='' )
      '' 
    #ELSE
        IF( le.Input_zoning_code = (TYPEOF(le.Input_zoning_code))'','',':zoning_code')
    #END
 
+    #IF( #TEXT(Input_lot_size)='' )
      '' 
    #ELSE
        IF( le.Input_lot_size = (TYPEOF(le.Input_lot_size))'','',':lot_size')
    #END
 
+    #IF( #TEXT(Input_year_built)='' )
      '' 
    #ELSE
        IF( le.Input_year_built = (TYPEOF(le.Input_year_built))'','',':year_built')
    #END
 
+    #IF( #TEXT(Input_current_land_value)='' )
      '' 
    #ELSE
        IF( le.Input_current_land_value = (TYPEOF(le.Input_current_land_value))'','',':current_land_value')
    #END
 
+    #IF( #TEXT(Input_current_improvement_value)='' )
      '' 
    #ELSE
        IF( le.Input_current_improvement_value = (TYPEOF(le.Input_current_improvement_value))'','',':current_improvement_value')
    #END
 
+    #IF( #TEXT(Input_filler_8)='' )
      '' 
    #ELSE
        IF( le.Input_filler_8 = (TYPEOF(le.Input_filler_8))'','',':filler_8')
    #END
 
+    #IF( #TEXT(Input_section)='' )
      '' 
    #ELSE
        IF( le.Input_section = (TYPEOF(le.Input_section))'','',':section')
    #END
 
+    #IF( #TEXT(Input_township)='' )
      '' 
    #ELSE
        IF( le.Input_township = (TYPEOF(le.Input_township))'','',':township')
    #END
 
+    #IF( #TEXT(Input_range)='' )
      '' 
    #ELSE
        IF( le.Input_range = (TYPEOF(le.Input_range))'','',':range')
    #END
 
+    #IF( #TEXT(Input_lot)='' )
      '' 
    #ELSE
        IF( le.Input_lot = (TYPEOF(le.Input_lot))'','',':lot')
    #END
 
+    #IF( #TEXT(Input_block)='' )
      '' 
    #ELSE
        IF( le.Input_block = (TYPEOF(le.Input_block))'','',':block')
    #END
 
+    #IF( #TEXT(Input_tract_subdivision_name)='' )
      '' 
    #ELSE
        IF( le.Input_tract_subdivision_name = (TYPEOF(le.Input_tract_subdivision_name))'','',':tract_subdivision_name')
    #END
 
+    #IF( #TEXT(Input_map_book)='' )
      '' 
    #ELSE
        IF( le.Input_map_book = (TYPEOF(le.Input_map_book))'','',':map_book')
    #END
 
+    #IF( #TEXT(Input_map_page)='' )
      '' 
    #ELSE
        IF( le.Input_map_page = (TYPEOF(le.Input_map_page))'','',':map_page')
    #END
 
+    #IF( #TEXT(Input_unit_nbr)='' )
      '' 
    #ELSE
        IF( le.Input_unit_nbr = (TYPEOF(le.Input_unit_nbr))'','',':unit_nbr')
    #END
 
+    #IF( #TEXT(Input_expanded_legal)='' )
      '' 
    #ELSE
        IF( le.Input_expanded_legal = (TYPEOF(le.Input_expanded_legal))'','',':expanded_legal')
    #END
 
+    #IF( #TEXT(Input_legal_2)='' )
      '' 
    #ELSE
        IF( le.Input_legal_2 = (TYPEOF(le.Input_legal_2))'','',':legal_2')
    #END
 
+    #IF( #TEXT(Input_legal_3)='' )
      '' 
    #ELSE
        IF( le.Input_legal_3 = (TYPEOF(le.Input_legal_3))'','',':legal_3')
    #END
 
+    #IF( #TEXT(Input_legal_4)='' )
      '' 
    #ELSE
        IF( le.Input_legal_4 = (TYPEOF(le.Input_legal_4))'','',':legal_4')
    #END
 
+    #IF( #TEXT(Input_crlf)='' )
      '' 
    #ELSE
        IF( le.Input_crlf = (TYPEOF(le.Input_crlf))'','',':crlf')
    #END
 
+    #IF( #TEXT(Input_deed_desc)='' )
      '' 
    #ELSE
        IF( le.Input_deed_desc = (TYPEOF(le.Input_deed_desc))'','',':deed_desc')
    #END
 
+    #IF( #TEXT(Input_document_desc)='' )
      '' 
    #ELSE
        IF( le.Input_document_desc = (TYPEOF(le.Input_document_desc))'','',':document_desc')
    #END
 
+    #IF( #TEXT(Input_et_al_desc)='' )
      '' 
    #ELSE
        IF( le.Input_et_al_desc = (TYPEOF(le.Input_et_al_desc))'','',':et_al_desc')
    #END
 
+    #IF( #TEXT(Input_property_desc)='' )
      '' 
    #ELSE
        IF( le.Input_property_desc = (TYPEOF(le.Input_property_desc))'','',':property_desc')
    #END
 
+    #IF( #TEXT(Input_use_desc)='' )
      '' 
    #ELSE
        IF( le.Input_use_desc = (TYPEOF(le.Input_use_desc))'','',':use_desc')
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
