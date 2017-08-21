MODULE:Scrubs_LN_PropertyV2_Deed
FILENAME:Property_deed
//Uncomment up to NINES for internal or external adl
//IDFIELD:EXISTS:<NameOfIDField>
//RIDFIELD:<NameOfRidField>
//RECORDS:<NumberOfRecordsInDataFile>
//POPULATION:<ExpectedNumberOfEntitiesInDataFile>
//NINES:<Precision required 3 = 99.9, 2 = 99 2.164980e+260tc>
//Uncomment Process if doing external adl
//PROCESS:<ProcessName>
SOURCEFIELD:fips_code
FIELDTYPE:invalid_alpha:SPACES( ):ALLOW( &(),-/.'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_char:SPACES( ):ALLOW( &(),-/.'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_address:SPACES( ):ALLOW(',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_apn:SPACES( ):ALLOW( _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZ)
FIELDTYPE:invalid_county_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ'):SPACES( -):WORDS(1,2,3,4,5)
FIELDTYPE:invalid_vendor_source:ENUM(F|D|O|S)
FIELDTYPE:invalid_from_file:ENUM(F|M|D)
FIELDTYPE:invalid_buyer_or_borrower_ind:ENUM(B|O)
FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0..8):CUSTOM(Scrubs.fn_valid_date > 0) 
FIELDTYPE:invalid_date_future:ALLOW(0123456789):LENGTHS(0..8):CUSTOM(Scrubs.fn_valid_date > 0, 'F')
FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(5,9)
FIELDTYPE:invalid_fips:SPACES( ):ALLOW(0123456789):LENGTHS(5):WITHIN(Scrubs_LN_PropertyV2_Assessor.file_fips,fips_code)
FIELDTYPE:invalid_zcs:SPACES( ):ALLOW( ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)
FIELDTYPE:invalid_prop_amount:ALLOW(0123456789.)
FIELDTYPE:invalid_amount:ALLOW(0123456789.)
FIELDTYPE:invalid_state_code:ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(2)
FIELDTYPE:invalid_document_type_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'DOCUMENT_TYPE_CODE', 'FARES_1080'):SPACES( ):ALLOW( -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&'-)
FIELDTYPE:invalid_legal_lot_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'LEGAL_LOT_CODE', 'FARES_1080') 
FIELDTYPE:invalid_sales_price_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'SALE_CODE', 'FARES_1080') 
FIELDTYPE:invalid_property_use_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'PROPERTY_INDICATOR_CODE', 'FARES_1080') 
FIELDTYPE:invalid_condo_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'CONDO_CODE', 'FARES_1080') 
FIELDTYPE:invalid_loan_type_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'MORTGAGE_LOAN_TYPE_CODE', 'FARES_1080') 
FIELDTYPE:invalid_lender_type_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'FIRST_TD_LENDER_TYPE_CODE', 'FARES_1080') 
FIELDTYPE:invalid_name1_id_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'BUYER1_ID_CODE', 'FARES_1080')
//:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'BORROWER1_ID_CODE', 'FARES_1080') 
FIELDTYPE:invalid_vesting_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'BUYER_VESTING_CODE', 'FARES_1080')
//:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'BORROWER_VESTING_CODE', 'FARES_1080')
FIELDTYPE:invalid_seller1_id_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'SELLER1_ID_CODE', 'FARES_1080') 
FIELDTYPE:invalid_seller2_id_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'SELLER2_ID_CODE', 'FARES_1080') 
FIELDTYPE:invalid_record_type:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'RECORD_TYPE', 'FARES_1080') 
FIELDTYPE:invalid_type_financing:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'TYPE_FINANCING', 'FARES_1080') 
FIELDTYPE:invalid_rate_change_frequency:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'RATE_CHANGE_FREQUENCY', 'FARES_1080') 
FIELDTYPE:invalid_adjustable_rate_index:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'ADJUSTABLE_RATE_INDEX', 'FARES_1080') 
FIELDTYPE:invalid_fixed_step_rate_ride:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,'FIXED_STEP_RATE_RIDER', 'FARES_1080') 
FIELD:ln_fares_id:0,0
DATEFIELD:process_date:LIKE(invalid_date):0,0
FIELD:vendor_source_flag:LIKE(invalid_vendor_source):0,0
FIELD:current_record:0,0
FIELD:from_file:LIKE(invalid_from_file):0,0
FIELD:fips_code:LIKE(invalid_fips):0,0
FIELD:state:LIKE(invalid_state_code):0,0
FIELD:county_name:LIKE(invalid_county_name):0,0
FIELD:record_type:LIKE(invalid_record_type):0,0
FIELD:apnt_or_pin_number:LIKe(invalid_apn):0,0
FIELD:fares_unformatted_apn:LIKE(invalid_apn):0,0
FIELD:multi_apn_flag:0,0
FIELD:tax_id_number:0,0
FIELD:excise_tax_number:0,0
FIELD:buyer_or_borrower_ind:LIKE(invalid_buyer_or_borrower_ind):0,0
FIELD:name1:LIKE(invalid_alpha):0,0
FIELD:name1_id_code:LIKE(invalid_name1_id_code):0,0
FIELD:name2:LIKE(invalid_alpha):0,0
FIELD:name2_id_code:LIKE(invalid_name1_id_code):0,0
FIELD:vesting_code:LIKE(invalid_vesting_code):0,0
FIELD:addendum_flag:0,0
FIELD:phone_number:0,0
FIELD:mailing_care_of:LIKE(invalid_alpha):0,0
FIELD:mailing_street:LIKE(invalid_address):0,0
FIELD:mailing_unit_number:LIKE(invalid_address):0,0
FIELD:mailing_csz:LIKE(invalid_zcs):0,0
FIELD:mailing_address_cd:LIKE(invalid_address):0,0
FIELD:seller1:LIKE(invalid_alpha):0,0
FIELD:seller1_id_code:LIKE(invalid_seller1_id_code):0,0
FIELD:seller2:LIKE(invalid_alpha):0,0
FIELD:seller2_id_code:LIKE(invalid_seller2_id_code):0,0
FIELD:seller_addendum_flag:0,0
FIELD:seller_mailing_full_street_address:LIKE(invalid_address):0,0
FIELD:seller_mailing_address_unit_number:0,0
FIELD:seller_mailing_address_citystatezip:0,0
FIELD:property_full_street_address:LIKE(invalid_address):0,0
FIELD:property_address_unit_number:0,0
FIELD:property_address_citystatezip:LIKE(invalid_address):0,0
FIELD:property_address_code:0,0
FIELD:legal_lot_code:LIKE(invalid_legal_lot_code):0,0
FIELD:legal_lot_number:0,0
FIELD:legal_block:0,0
FIELD:legal_section:0,0
FIELD:legal_district:0,0
FIELD:legal_land_lot:0,0
FIELD:legal_unit:0,0
FIELD:legal_city_municipality_township:0,0
FIELD:legal_subdivision_name:0,0
FIELD:legal_phase_number:LIKE(invalid_char):0,0
FIELD:legal_tract_number:0,0
FIELD:legal_sec_twn_rng_mer:0,0
FIELD:legal_brief_description:0,0
FIELD:recorder_map_reference:0,0
FIELD:complete_legal_description_code:0,0
FIELD:contract_date:LIKE(invalid_date):0,0
FIELD:recording_date:LIKE(invalid_date):0,0
FIELD:arm_reset_date:LIKE(invalid_date_future):0,0
FIELD:document_number:0,0
FIELD:document_type_code:LIKE(invalid_document_type_code):0,0
FIELD:loan_number:0,0
FIELD:recorder_book_number:0,0
FIELD:recorder_page_number:0,0
FIELD:concurrent_mortgage_book_page_document_number:0,0
FIELD:sales_price:LIKE(invalid_amount):0,0
FIELD:sales_price_code:LIKE(invalid_sales_price_code):0,0
FIELD:city_transfer_tax:0,0
FIELD:county_transfer_tax:0,0
FIELD:total_transfer_tax:0,0
FIELD:first_td_loan_amount:LIKE(invalid_amount):0,0
FIELD:second_td_loan_amount:LIKE(invalid_amount):0,0
FIELD:first_td_lender_type_code:LIKE(invalid_lender_type_code):0,0
FIELD:second_td_lender_type_code:LIKE(invalid_lender_type_code):0,0
FIELD:first_td_loan_type_code:LIKE(invalid_loan_type_code):0,0
FIELD:type_financing:LIKE(invalid_type_financing):0,0
FIELD:first_td_interest_rate:0,0
FIELD:first_td_due_date:LIKE(invalid_date_future):0,0
FIELD:title_company_name:0,0
FIELD:partial_interest_transferred:0,0
FIELD:loan_term_months:0,0
FIELD:loan_term_years:0,0
FIELD:lender_name:0,0
FIELD:lender_name_id:0,0
FIELD:lender_dba_aka_name:0,0
FIELD:lender_full_street_address:LIKE(invalid_address):0,0
FIELD:lender_address_unit_number:0,0
FIELD:lender_address_citystatezip:LIKE(invalid_address):0,0
FIELD:assessment_match_land_use_code:0,0
FIELD:property_use_code:LIKE(invalid_property_use_code):0,0
FIELD:condo_code:LIKE(invalid_condo_code):0,0
FIELD:timeshare_flag:0,0
FIELD:land_lot_size:0,0
FIELD:hawaii_tct:0,0
FIELD:hawaii_condo_cpr_code:0,0
FIELD:hawaii_condo_name:0,0
FIELD:filler_except_hawaii:0,0
FIELD:rate_change_frequency:LIKE(invalid_rate_change_frequency):0,0
FIELD:change_index:0,0
FIELD:adjustable_rate_index:LIKE(invalid_adjustable_rate_index):0,0
FIELD:adjustable_rate_rider:0,0
FIELD:graduated_payment_rider:0,0
FIELD:balloon_rider:0,0
FIELD:fixed_step_rate_rider:LIKE(invalid_fixed_step_rate_ride):0,0
FIELD:condominium_rider:0,0
FIELD:planned_unit_development_rider:0,0
FIELD:rate_improvement_rider:0,0
FIELD:assumability_rider:0,0
FIELD:prepayment_rider:0,0
FIELD:one_four_family_rider:0,0
FIELD:biweekly_payment_rider:0,0
FIELD:second_home_rider:0,0
FIELD:data_source_code:0,0
FIELD:main_record_id_code:0,0
FIELD:addl_name_flag:0,0
FIELD:prop_addr_propagated_ind:0,0
FIELD:ln_ownership_rights:0,0
FIELD:ln_relationship_type:0,0
FIELD:ln_buyer_mailing_country_code:0,0
FIELD:ln_seller_mailing_country_code:0,0