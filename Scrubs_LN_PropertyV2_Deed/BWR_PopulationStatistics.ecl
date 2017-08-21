//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Deed.BWR_PopulationStatistics - Population Statistics - SALT V3.3.2');
IMPORT Scrubs_LN_PropertyV2_Deed,SALT33;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_LN_PropertyV2_Deed.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*fips_code Field*/,/* ln_fares_id_field */,/* process_date_field */,/* vendor_source_flag_field */,/* current_record_field */,/* from_file_field */,/* fips_code_field */,/* state_field */,/* county_name_field */,/* record_type_field */,/* apnt_or_pin_number_field */,/* fares_unformatted_apn_field */,/* multi_apn_flag_field */,/* tax_id_number_field */,/* excise_tax_number_field */,/* buyer_or_borrower_ind_field */,/* name1_field */,/* name1_id_code_field */,/* name2_field */,/* name2_id_code_field */,/* vesting_code_field */,/* addendum_flag_field */,/* phone_number_field */,/* mailing_care_of_field */,/* mailing_street_field */,/* mailing_unit_number_field */,/* mailing_csz_field */,/* mailing_address_cd_field */,/* seller1_field */,/* seller1_id_code_field */,/* seller2_field */,/* seller2_id_code_field */,/* seller_addendum_flag_field */,/* seller_mailing_full_street_address_field */,/* seller_mailing_address_unit_number_field */,/* seller_mailing_address_citystatezip_field */,/* property_full_street_address_field */,/* property_address_unit_number_field */,/* property_address_citystatezip_field */,/* property_address_code_field */,/* legal_lot_code_field */,/* legal_lot_number_field */,/* legal_block_field */,/* legal_section_field */,/* legal_district_field */,/* legal_land_lot_field */,/* legal_unit_field */,/* legal_city_municipality_township_field */,/* legal_subdivision_name_field */,/* legal_phase_number_field */,/* legal_tract_number_field */,/* legal_sec_twn_rng_mer_field */,/* legal_brief_description_field */,/* recorder_map_reference_field */,/* complete_legal_description_code_field */,/* contract_date_field */,/* recording_date_field */,/* arm_reset_date_field */,/* document_number_field */,/* document_type_code_field */,/* loan_number_field */,/* recorder_book_number_field */,/* recorder_page_number_field */,/* concurrent_mortgage_book_page_document_number_field */,/* sales_price_field */,/* sales_price_code_field */,/* city_transfer_tax_field */,/* county_transfer_tax_field */,/* total_transfer_tax_field */,/* first_td_loan_amount_field */,/* second_td_loan_amount_field */,/* first_td_lender_type_code_field */,/* second_td_lender_type_code_field */,/* first_td_loan_type_code_field */,/* type_financing_field */,/* first_td_interest_rate_field */,/* first_td_due_date_field */,/* title_company_name_field */,/* partial_interest_transferred_field */,/* loan_term_months_field */,/* loan_term_years_field */,/* lender_name_field */,/* lender_name_id_field */,/* lender_dba_aka_name_field */,/* lender_full_street_address_field */,/* lender_address_unit_number_field */,/* lender_address_citystatezip_field */,/* assessment_match_land_use_code_field */,/* property_use_code_field */,/* condo_code_field */,/* timeshare_flag_field */,/* land_lot_size_field */,/* hawaii_tct_field */,/* hawaii_condo_cpr_code_field */,/* hawaii_condo_name_field */,/* filler_except_hawaii_field */,/* rate_change_frequency_field */,/* change_index_field */,/* adjustable_rate_index_field */,/* adjustable_rate_rider_field */,/* graduated_payment_rider_field */,/* balloon_rider_field */,/* fixed_step_rate_rider_field */,/* condominium_rider_field */,/* planned_unit_development_rider_field */,/* rate_improvement_rider_field */,/* assumability_rider_field */,/* prepayment_rider_field */,/* one_four_family_rider_field */,/* biweekly_payment_rider_field */,/* second_home_rider_field */,/* data_source_code_field */,/* main_record_id_code_field */,/* addl_name_flag_field */,/* prop_addr_propagated_ind_field */,/* ln_ownership_rights_field */,/* ln_relationship_type_field */,/* ln_buyer_mailing_country_code_field */,/* ln_seller_mailing_country_code_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
