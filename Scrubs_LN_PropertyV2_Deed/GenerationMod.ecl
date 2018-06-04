// Machine-readable versions of the spec file and subsets thereof
IMPORT SALT311;
EXPORT GenerationMod := MODULE(SALT311.iGenerationMod)
 
  // SALT Version info
  EXPORT salt_VERSION := 'V3.11.0';
  EXPORT salt_MODULE := 'SALT311'; // Optional override by HACK:SALTMODULE
  EXPORT salt_TOOLSMODULE := 'SALTTOOLS30'; // Optional override by HACK:SALTTOOLSMODULE
 
  // Core module configuration values
  EXPORT spc_MODULE := 'Scrubs_LN_PropertyV2_Deed';
  EXPORT spc_NAMESCOPE := '';
  EXPORT spc_PROCESS := '';
  EXPORT spc_PROCLAYOUTS := 'Process__Layouts';
  EXPORT spc_IDNAME := ''; // cluster id (input)
  EXPORT spc_IDFIELD := ''; // cluster id (output)
  EXPORT spc_RIDFIELD := ''; // record id
  EXPORT spc_CONFIG := 'Config';
  EXPORT spc_CONFIGPARAM := FALSE;
  EXPORT spc_SOURCEFIELD := 'fips_code';
  EXPORT spc_FILEPREFIX := 'In_';
  EXPORT spc_FILENAME := 'Property_deed';
  EXPORT spc_INGESTSTATUS := '';
  EXPORT spc_EXTERNAL_MAPPING := 'UniqueID:';
  EXPORT spc_EXTERNAL_BATCH_PARAM := ',/* MY_ */,ln_fares_id,process_date,vendor_source_flag,current_record,from_file,fips_code,state,county_name,record_type,apnt_or_pin_number,fares_unformatted_apn,multi_apn_flag,tax_id_number,excise_tax_number,buyer_or_borrower_ind,name1,name1_id_code,name2,name2_id_code,vesting_code,addendum_flag,phone_number,mailing_care_of,mailing_street,mailing_unit_number,mailing_csz,mailing_address_cd,seller1,seller1_id_code,seller2,seller2_id_code,seller_addendum_flag,seller_mailing_full_street_address,seller_mailing_address_unit_number,seller_mailing_address_citystatezip,property_full_street_address,property_address_unit_number,property_address_citystatezip,property_address_code,legal_lot_code,legal_lot_number,legal_block,legal_section,legal_district,legal_land_lot,legal_unit,legal_city_municipality_township,legal_subdivision_name,legal_phase_number,legal_tract_number,legal_sec_twn_rng_mer,legal_brief_description,recorder_map_reference,complete_legal_description_code,contract_date,recording_date,arm_reset_date,document_number,document_type_code,loan_number,recorder_book_number,recorder_page_number,concurrent_mortgage_book_page_document_number,sales_price,sales_price_code,city_transfer_tax,county_transfer_tax,total_transfer_tax,first_td_loan_amount,second_td_loan_amount,first_td_lender_type_code,second_td_lender_type_code,first_td_loan_type_code,type_financing,first_td_interest_rate,first_td_due_date,title_company_name,partial_interest_transferred,loan_term_months,loan_term_years,lender_name,lender_name_id,lender_dba_aka_name,lender_full_street_address,lender_address_unit_number,lender_address_citystatezip,assessment_match_land_use_code,property_use_code,condo_code,timeshare_flag,land_lot_size,hawaii_tct,hawaii_condo_cpr_code,hawaii_condo_name,filler_except_hawaii,rate_change_frequency,change_index,adjustable_rate_index,adjustable_rate_rider,graduated_payment_rider,balloon_rider,fixed_step_rate_rider,condominium_rider,planned_unit_development_rider,rate_improvement_rider,assumability_rider,prepayment_rider,one_four_family_rider,biweekly_payment_rider,second_home_rider,data_source_code,main_record_id_code,addl_name_flag,prop_addr_propagated_ind,ln_ownership_rights,ln_relationship_type,ln_buyer_mailing_country_code,ln_seller_mailing_country_code';
  EXPORT spc_HAS_TWOSTEP := FALSE;
  EXPORT spc_HAS_PARTITION := FALSE;
  EXPORT spc_HAS_FIELDTYPES := TRUE;
  EXPORT spc_HAS_INCREMENTAL := FALSE;
  EXPORT spc_HAS_ASOF := FALSE;
  EXPORT spc_HAS_NONCONTIGUOUS := FALSE;
  EXPORT spc_HAS_SUPERFILES := FALSE;
  EXPORT spc_HAS_CONSISTENT := FALSE;
  EXPORT spc_HAS_EXTERNAL := FALSE;
  EXPORT spc_HAS_PARENTS := FALSE;
  EXPORT spc_HAS_FORCE := FALSE;
  EXPORT spc_HAS_BLOCKLINK := FALSE;
 
  // The entire spec file
  EXPORT spcString :=
    'options:-gh\n'
    + 'MODULE:Scrubs_LN_PropertyV2_Deed\n'
    + 'FILENAME:Property_deed\n'
    + '//Uncomment up to NINES for internal or external adl\n'
    + '//IDFIELD:EXISTS:<NameOfIDField>\n'
    + '//RIDFIELD:<NameOfRidField>\n'
    + '//RECORDS:<NumberOfRecordsInDataFile>\n'
    + '//POPULATION:<ExpectedNumberOfEntitiesInDataFile>\n'
    + '//NINES:<Precision required 3 = 99.9, 2 = 99 2.164980e+260tc>\n'
    + '//Uncomment Process if doing external adl\n'
    + '//PROCESS:<ProcessName>\n'
    + 'SOURCEFIELD:fips_code\n'
    + 'FIELDTYPE:invalid_alpha:SPACES( ):ALLOW( &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_char:SPACES( ):ALLOW( &(),-/.\'#:;*;ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:invalid_address:SPACES( ):ALLOW(\',./#-&/0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_apn:SPACES( ):ALLOW( _-.,/:&()*0123456789:;ABCDEFGHIJKLMNOPQRSTUVWXYZ)\n'
    + 'FIELDTYPE:invalid_county_name:ALLOW(ABCDEFGHIJKLMNOPQRSTUVWXYZ\'):SPACES( -):WORDS(1,2,3,4,5)\n'
    + 'FIELDTYPE:invalid_vendor_source:ENUM(F|D|O|S)\n'
    + 'FIELDTYPE:invalid_from_file:ENUM(F|M|D)\n'
    + 'FIELDTYPE:invalid_buyer_or_borrower_ind:ENUM(B|O)\n'
    + 'FIELDTYPE:invalid_date:ALLOW(0123456789):LENGTHS(0..8):CUSTOM(Scrubs.fn_valid_date > 0) \n'
    + 'FIELDTYPE:invalid_date_future:ALLOW(0123456789):LENGTHS(0..8):CUSTOM(Scrubs.fn_valid_date > 0, \'F\')\n'
    + 'FIELDTYPE:invalid_zip:ALLOW(0123456789):LENGTHS(5,9)\n'
    + 'FIELDTYPE:invalid_fips:SPACES( ):ALLOW(0123456789):LENGTHS(5):WITHIN(Scrubs_LN_PropertyV2_Assessor.file_fips,fips_code)\n'
    + 'FIELDTYPE:invalid_zcs:SPACES( ):ALLOW( ,-ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789)\n'
    + 'FIELDTYPE:invalid_prop_amount:ALLOW(0123456789.)\n'
    + 'FIELDTYPE:invalid_amount:ALLOW(0123456789.)\n'
    + 'FIELDTYPE:invalid_state_code:ALLOW(ACDEFGHIJKLMNOPRSTUVWXYZ):LEFTTRIM:LENGTHS(2)\n'
    + 'FIELDTYPE:invalid_document_type_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'DOCUMENT_TYPE_CODE\', \'FARES_1080\'):SPACES( ):ALLOW( -.:ABCDEFGHIJKLMNOPQRSTUVWXYZ/():,&\'-)\n'
    + 'FIELDTYPE:invalid_legal_lot_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'LEGAL_LOT_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_sales_price_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'SALE_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_property_use_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'PROPERTY_INDICATOR_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_condo_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'CONDO_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_loan_type_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'MORTGAGE_LOAN_TYPE_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_lender_type_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'FIRST_TD_LENDER_TYPE_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_name1_id_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'BUYER1_ID_CODE\', \'FARES_1080\')\n'
    + '//:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'BORROWER1_ID_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_vesting_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'BUYER_VESTING_CODE\', \'FARES_1080\')\n'
    + '//:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'BORROWER_VESTING_CODE\', \'FARES_1080\')\n'
    + 'FIELDTYPE:invalid_seller1_id_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'SELLER1_ID_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_seller2_id_code:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'SELLER2_ID_CODE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_record_type:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'RECORD_TYPE\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_type_financing:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'TYPE_FINANCING\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_rate_change_frequency:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'RATE_CHANGE_FREQUENCY\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_adjustable_rate_index:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'ADJUSTABLE_RATE_INDEX\', \'FARES_1080\') \n'
    + 'FIELDTYPE:invalid_fixed_step_rate_ride:CUSTOM(Scrubs_LN_PropertyV2_Assessor.fn_valid_codesv3_property > 0,vendor_source_flag,\'FIXED_STEP_RATE_RIDER\', \'FARES_1080\') \n'
    + 'FIELD:ln_fares_id:0,0\n'
    + 'DATEFIELD:process_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:vendor_source_flag:LIKE(invalid_vendor_source):0,0\n'
    + 'FIELD:current_record:0,0\n'
    + 'FIELD:from_file:LIKE(invalid_from_file):0,0\n'
    + 'FIELD:fips_code:LIKE(invalid_fips):0,0\n'
    + 'FIELD:state:LIKE(invalid_state_code):0,0\n'
    + 'FIELD:county_name:LIKE(invalid_county_name):0,0\n'
    + 'FIELD:record_type:LIKE(invalid_record_type):0,0\n'
    + 'FIELD:apnt_or_pin_number:LIKe(invalid_apn):0,0\n'
    + 'FIELD:fares_unformatted_apn:LIKE(invalid_apn):0,0\n'
    + 'FIELD:multi_apn_flag:0,0\n'
    + 'FIELD:tax_id_number:0,0\n'
    + 'FIELD:excise_tax_number:0,0\n'
    + 'FIELD:buyer_or_borrower_ind:LIKE(invalid_buyer_or_borrower_ind):0,0\n'
    + 'FIELD:name1:LIKE(invalid_alpha):0,0\n'
    + 'FIELD:name1_id_code:LIKE(invalid_name1_id_code):0,0\n'
    + 'FIELD:name2:LIKE(invalid_alpha):0,0\n'
    + 'FIELD:name2_id_code:LIKE(invalid_name1_id_code):0,0\n'
    + 'FIELD:vesting_code:LIKE(invalid_vesting_code):0,0\n'
    + 'FIELD:addendum_flag:0,0\n'
    + 'FIELD:phone_number:0,0\n'
    + 'FIELD:mailing_care_of:LIKE(invalid_alpha):0,0\n'
    + 'FIELD:mailing_street:LIKE(invalid_address):0,0\n'
    + 'FIELD:mailing_unit_number:LIKE(invalid_address):0,0\n'
    + 'FIELD:mailing_csz:LIKE(invalid_zcs):0,0\n'
    + 'FIELD:mailing_address_cd:LIKE(invalid_address):0,0\n'
    + 'FIELD:seller1:LIKE(invalid_alpha):0,0\n'
    + 'FIELD:seller1_id_code:LIKE(invalid_seller1_id_code):0,0\n'
    + 'FIELD:seller2:LIKE(invalid_alpha):0,0\n'
    + 'FIELD:seller2_id_code:LIKE(invalid_seller2_id_code):0,0\n'
    + 'FIELD:seller_addendum_flag:0,0\n'
    + 'FIELD:seller_mailing_full_street_address:LIKE(invalid_address):0,0\n'
    + 'FIELD:seller_mailing_address_unit_number:0,0\n'
    + 'FIELD:seller_mailing_address_citystatezip:0,0\n'
    + 'FIELD:property_full_street_address:LIKE(invalid_address):0,0\n'
    + 'FIELD:property_address_unit_number:0,0\n'
    + 'FIELD:property_address_citystatezip:LIKE(invalid_address):0,0\n'
    + 'FIELD:property_address_code:0,0\n'
    + 'FIELD:legal_lot_code:LIKE(invalid_legal_lot_code):0,0\n'
    + 'FIELD:legal_lot_number:0,0\n'
    + 'FIELD:legal_block:0,0\n'
    + 'FIELD:legal_section:0,0\n'
    + 'FIELD:legal_district:0,0\n'
    + 'FIELD:legal_land_lot:0,0\n'
    + 'FIELD:legal_unit:0,0\n'
    + 'FIELD:legal_city_municipality_township:0,0\n'
    + 'FIELD:legal_subdivision_name:0,0\n'
    + 'FIELD:legal_phase_number:LIKE(invalid_char):0,0\n'
    + 'FIELD:legal_tract_number:0,0\n'
    + 'FIELD:legal_sec_twn_rng_mer:0,0\n'
    + 'FIELD:legal_brief_description:0,0\n'
    + 'FIELD:recorder_map_reference:0,0\n'
    + 'FIELD:complete_legal_description_code:0,0\n'
    + 'FIELD:contract_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:recording_date:LIKE(invalid_date):0,0\n'
    + 'FIELD:arm_reset_date:LIKE(invalid_date_future):0,0\n'
    + 'FIELD:document_number:0,0\n'
    + 'FIELD:document_type_code:LIKE(invalid_document_type_code):0,0\n'
    + 'FIELD:loan_number:0,0\n'
    + 'FIELD:recorder_book_number:0,0\n'
    + 'FIELD:recorder_page_number:0,0\n'
    + 'FIELD:concurrent_mortgage_book_page_document_number:0,0\n'
    + 'FIELD:sales_price:LIKE(invalid_amount):0,0\n'
    + 'FIELD:sales_price_code:LIKE(invalid_sales_price_code):0,0\n'
    + 'FIELD:city_transfer_tax:0,0\n'
    + 'FIELD:county_transfer_tax:0,0\n'
    + 'FIELD:total_transfer_tax:0,0\n'
    + 'FIELD:first_td_loan_amount:LIKE(invalid_amount):0,0\n'
    + 'FIELD:second_td_loan_amount:LIKE(invalid_amount):0,0\n'
    + 'FIELD:first_td_lender_type_code:LIKE(invalid_lender_type_code):0,0\n'
    + 'FIELD:second_td_lender_type_code:LIKE(invalid_lender_type_code):0,0\n'
    + 'FIELD:first_td_loan_type_code:LIKE(invalid_loan_type_code):0,0\n'
    + 'FIELD:type_financing:LIKE(invalid_type_financing):0,0\n'
    + 'FIELD:first_td_interest_rate:0,0\n'
    + 'FIELD:first_td_due_date:LIKE(invalid_date_future):0,0\n'
    + 'FIELD:title_company_name:0,0\n'
    + 'FIELD:partial_interest_transferred:0,0\n'
    + 'FIELD:loan_term_months:0,0\n'
    + 'FIELD:loan_term_years:0,0\n'
    + 'FIELD:lender_name:0,0\n'
    + 'FIELD:lender_name_id:0,0\n'
    + 'FIELD:lender_dba_aka_name:0,0\n'
    + 'FIELD:lender_full_street_address:LIKE(invalid_address):0,0\n'
    + 'FIELD:lender_address_unit_number:0,0\n'
    + 'FIELD:lender_address_citystatezip:LIKE(invalid_address):0,0\n'
    + 'FIELD:assessment_match_land_use_code:0,0\n'
    + 'FIELD:property_use_code:LIKE(invalid_property_use_code):0,0\n'
    + 'FIELD:condo_code:LIKE(invalid_condo_code):0,0\n'
    + 'FIELD:timeshare_flag:0,0\n'
    + 'FIELD:land_lot_size:0,0\n'
    + 'FIELD:hawaii_tct:0,0\n'
    + 'FIELD:hawaii_condo_cpr_code:0,0\n'
    + 'FIELD:hawaii_condo_name:0,0\n'
    + 'FIELD:filler_except_hawaii:0,0\n'
    + 'FIELD:rate_change_frequency:LIKE(invalid_rate_change_frequency):0,0\n'
    + 'FIELD:change_index:0,0\n'
    + 'FIELD:adjustable_rate_index:LIKE(invalid_adjustable_rate_index):0,0\n'
    + 'FIELD:adjustable_rate_rider:0,0\n'
    + 'FIELD:graduated_payment_rider:0,0\n'
    + 'FIELD:balloon_rider:0,0\n'
    + 'FIELD:fixed_step_rate_rider:LIKE(invalid_fixed_step_rate_ride):0,0\n'
    + 'FIELD:condominium_rider:0,0\n'
    + 'FIELD:planned_unit_development_rider:0,0\n'
    + 'FIELD:rate_improvement_rider:0,0\n'
    + 'FIELD:assumability_rider:0,0\n'
    + 'FIELD:prepayment_rider:0,0\n'
    + 'FIELD:one_four_family_rider:0,0\n'
    + 'FIELD:biweekly_payment_rider:0,0\n'
    + 'FIELD:second_home_rider:0,0\n'
    + 'FIELD:data_source_code:0,0\n'
    + 'FIELD:main_record_id_code:0,0\n'
    + 'FIELD:addl_name_flag:0,0\n'
    + 'FIELD:prop_addr_propagated_ind:0,0\n'
    + 'FIELD:ln_ownership_rights:0,0\n'
    + 'FIELD:ln_relationship_type:0,0\n'
    + 'FIELD:ln_buyer_mailing_country_code:0,0\n'
    + 'FIELD:ln_seller_mailing_country_code:0,0'
    ;
 
  // Structured values
  EXPORT linkpaths := DATASET([
    ],{STRING linkpath;STRING compulsory;STRING optional;STRING bonus;STRING required;STRING search});
 
END;

