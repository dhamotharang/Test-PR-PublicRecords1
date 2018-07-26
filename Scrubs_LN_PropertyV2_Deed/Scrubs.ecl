IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_LN_PropertyV2_Assessor; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 65;
  EXPORT NumRulesFromFieldType := 65;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 49;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Property_deed)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 vendor_source_flag_Invalid;
    UNSIGNED1 from_file_Invalid;
    UNSIGNED1 fips_code_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 apnt_or_pin_number_Invalid;
    UNSIGNED1 fares_unformatted_apn_Invalid;
    UNSIGNED1 buyer_or_borrower_ind_Invalid;
    UNSIGNED1 name1_Invalid;
    UNSIGNED1 name1_id_code_Invalid;
    UNSIGNED1 name2_Invalid;
    UNSIGNED1 name2_id_code_Invalid;
    UNSIGNED1 vesting_code_Invalid;
    UNSIGNED1 mailing_care_of_Invalid;
    UNSIGNED1 mailing_street_Invalid;
    UNSIGNED1 mailing_unit_number_Invalid;
    UNSIGNED1 mailing_csz_Invalid;
    UNSIGNED1 mailing_address_cd_Invalid;
    UNSIGNED1 seller1_Invalid;
    UNSIGNED1 seller1_id_code_Invalid;
    UNSIGNED1 seller2_Invalid;
    UNSIGNED1 seller2_id_code_Invalid;
    UNSIGNED1 seller_mailing_full_street_address_Invalid;
    UNSIGNED1 property_full_street_address_Invalid;
    UNSIGNED1 property_address_citystatezip_Invalid;
    UNSIGNED1 legal_lot_code_Invalid;
    UNSIGNED1 legal_phase_number_Invalid;
    UNSIGNED1 contract_date_Invalid;
    UNSIGNED1 recording_date_Invalid;
    UNSIGNED1 arm_reset_date_Invalid;
    UNSIGNED1 document_type_code_Invalid;
    UNSIGNED1 sales_price_Invalid;
    UNSIGNED1 sales_price_code_Invalid;
    UNSIGNED1 first_td_loan_amount_Invalid;
    UNSIGNED1 second_td_loan_amount_Invalid;
    UNSIGNED1 first_td_lender_type_code_Invalid;
    UNSIGNED1 second_td_lender_type_code_Invalid;
    UNSIGNED1 first_td_loan_type_code_Invalid;
    UNSIGNED1 type_financing_Invalid;
    UNSIGNED1 first_td_due_date_Invalid;
    UNSIGNED1 lender_full_street_address_Invalid;
    UNSIGNED1 lender_address_citystatezip_Invalid;
    UNSIGNED1 property_use_code_Invalid;
    UNSIGNED1 condo_code_Invalid;
    UNSIGNED1 rate_change_frequency_Invalid;
    UNSIGNED1 adjustable_rate_index_Invalid;
    UNSIGNED1 fixed_step_rate_rider_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Property_deed)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Property_deed) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.vendor_source_flag_Invalid := Fields.InValid_vendor_source_flag((SALT311.StrType)le.vendor_source_flag);
    SELF.from_file_Invalid := Fields.InValid_from_file((SALT311.StrType)le.from_file);
    SELF.fips_code_Invalid := Fields.InValid_fips_code((SALT311.StrType)le.fips_code);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.county_name_Invalid := Fields.InValid_county_name((SALT311.StrType)le.county_name);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT311.StrType)le.record_type,(SALT311.StrType)le.vendor_source_flag);
    SELF.apnt_or_pin_number_Invalid := Fields.InValid_apnt_or_pin_number((SALT311.StrType)le.apnt_or_pin_number);
    SELF.fares_unformatted_apn_Invalid := Fields.InValid_fares_unformatted_apn((SALT311.StrType)le.fares_unformatted_apn);
    SELF.buyer_or_borrower_ind_Invalid := Fields.InValid_buyer_or_borrower_ind((SALT311.StrType)le.buyer_or_borrower_ind);
    SELF.name1_Invalid := Fields.InValid_name1((SALT311.StrType)le.name1);
    SELF.name1_id_code_Invalid := Fields.InValid_name1_id_code((SALT311.StrType)le.name1_id_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.name2_Invalid := Fields.InValid_name2((SALT311.StrType)le.name2);
    SELF.name2_id_code_Invalid := Fields.InValid_name2_id_code((SALT311.StrType)le.name2_id_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.vesting_code_Invalid := Fields.InValid_vesting_code((SALT311.StrType)le.vesting_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.mailing_care_of_Invalid := Fields.InValid_mailing_care_of((SALT311.StrType)le.mailing_care_of);
    SELF.mailing_street_Invalid := Fields.InValid_mailing_street((SALT311.StrType)le.mailing_street);
    SELF.mailing_unit_number_Invalid := Fields.InValid_mailing_unit_number((SALT311.StrType)le.mailing_unit_number);
    SELF.mailing_csz_Invalid := Fields.InValid_mailing_csz((SALT311.StrType)le.mailing_csz);
    SELF.mailing_address_cd_Invalid := Fields.InValid_mailing_address_cd((SALT311.StrType)le.mailing_address_cd);
    SELF.seller1_Invalid := Fields.InValid_seller1((SALT311.StrType)le.seller1);
    SELF.seller1_id_code_Invalid := Fields.InValid_seller1_id_code((SALT311.StrType)le.seller1_id_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.seller2_Invalid := Fields.InValid_seller2((SALT311.StrType)le.seller2);
    SELF.seller2_id_code_Invalid := Fields.InValid_seller2_id_code((SALT311.StrType)le.seller2_id_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.seller_mailing_full_street_address_Invalid := Fields.InValid_seller_mailing_full_street_address((SALT311.StrType)le.seller_mailing_full_street_address);
    SELF.property_full_street_address_Invalid := Fields.InValid_property_full_street_address((SALT311.StrType)le.property_full_street_address);
    SELF.property_address_citystatezip_Invalid := Fields.InValid_property_address_citystatezip((SALT311.StrType)le.property_address_citystatezip);
    SELF.legal_lot_code_Invalid := Fields.InValid_legal_lot_code((SALT311.StrType)le.legal_lot_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.legal_phase_number_Invalid := Fields.InValid_legal_phase_number((SALT311.StrType)le.legal_phase_number);
    SELF.contract_date_Invalid := Fields.InValid_contract_date((SALT311.StrType)le.contract_date);
    SELF.recording_date_Invalid := Fields.InValid_recording_date((SALT311.StrType)le.recording_date);
    SELF.arm_reset_date_Invalid := Fields.InValid_arm_reset_date((SALT311.StrType)le.arm_reset_date);
    SELF.document_type_code_Invalid := Fields.InValid_document_type_code((SALT311.StrType)le.document_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.sales_price_Invalid := Fields.InValid_sales_price((SALT311.StrType)le.sales_price);
    SELF.sales_price_code_Invalid := Fields.InValid_sales_price_code((SALT311.StrType)le.sales_price_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.first_td_loan_amount_Invalid := Fields.InValid_first_td_loan_amount((SALT311.StrType)le.first_td_loan_amount);
    SELF.second_td_loan_amount_Invalid := Fields.InValid_second_td_loan_amount((SALT311.StrType)le.second_td_loan_amount);
    SELF.first_td_lender_type_code_Invalid := Fields.InValid_first_td_lender_type_code((SALT311.StrType)le.first_td_lender_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.second_td_lender_type_code_Invalid := Fields.InValid_second_td_lender_type_code((SALT311.StrType)le.second_td_lender_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.first_td_loan_type_code_Invalid := Fields.InValid_first_td_loan_type_code((SALT311.StrType)le.first_td_loan_type_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.type_financing_Invalid := Fields.InValid_type_financing((SALT311.StrType)le.type_financing,(SALT311.StrType)le.vendor_source_flag);
    SELF.first_td_due_date_Invalid := Fields.InValid_first_td_due_date((SALT311.StrType)le.first_td_due_date);
    SELF.lender_full_street_address_Invalid := Fields.InValid_lender_full_street_address((SALT311.StrType)le.lender_full_street_address);
    SELF.lender_address_citystatezip_Invalid := Fields.InValid_lender_address_citystatezip((SALT311.StrType)le.lender_address_citystatezip);
    SELF.property_use_code_Invalid := Fields.InValid_property_use_code((SALT311.StrType)le.property_use_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.condo_code_Invalid := Fields.InValid_condo_code((SALT311.StrType)le.condo_code,(SALT311.StrType)le.vendor_source_flag);
    SELF.rate_change_frequency_Invalid := Fields.InValid_rate_change_frequency((SALT311.StrType)le.rate_change_frequency,(SALT311.StrType)le.vendor_source_flag);
    SELF.adjustable_rate_index_Invalid := Fields.InValid_adjustable_rate_index((SALT311.StrType)le.adjustable_rate_index,(SALT311.StrType)le.vendor_source_flag);
    SELF.fixed_step_rate_rider_Invalid := Fields.InValid_fixed_step_rate_rider((SALT311.StrType)le.fixed_step_rate_rider,(SALT311.StrType)le.vendor_source_flag);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT WithinList1 := DEDUP(SORT(TABLE(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code}),fips_code),ALL) : PERSIST('~temp::Scrubs_LN_PropertyV2_Deed::Scrubs_LN_PropertyV2_Assessor.file_fips::fips_code',EXPIRE(Scrubs_LN_PropertyV2_Deed.Config.PersistExpire));
  EXPORT ExpandedInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.fips_code=RIGHT.fips_code AND LEFT.fips_code_Invalid=0, TRANSFORM(Expanded_Layout, SELF.fips_code_Invalid:=MAP(RIGHT.fips_code<>''=>0,LEFT.fips_code_Invalid>0=>LEFT.fips_code_Invalid,3),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile := ExpandedInfile1;
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Property_deed);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.vendor_source_flag_Invalid << 2 ) + ( le.from_file_Invalid << 3 ) + ( le.fips_code_Invalid << 4 ) + ( le.state_Invalid << 6 ) + ( le.county_name_Invalid << 8 ) + ( le.record_type_Invalid << 10 ) + ( le.apnt_or_pin_number_Invalid << 11 ) + ( le.fares_unformatted_apn_Invalid << 12 ) + ( le.buyer_or_borrower_ind_Invalid << 13 ) + ( le.name1_Invalid << 14 ) + ( le.name1_id_code_Invalid << 15 ) + ( le.name2_Invalid << 16 ) + ( le.name2_id_code_Invalid << 17 ) + ( le.vesting_code_Invalid << 18 ) + ( le.mailing_care_of_Invalid << 19 ) + ( le.mailing_street_Invalid << 20 ) + ( le.mailing_unit_number_Invalid << 21 ) + ( le.mailing_csz_Invalid << 22 ) + ( le.mailing_address_cd_Invalid << 23 ) + ( le.seller1_Invalid << 24 ) + ( le.seller1_id_code_Invalid << 25 ) + ( le.seller2_Invalid << 26 ) + ( le.seller2_id_code_Invalid << 27 ) + ( le.seller_mailing_full_street_address_Invalid << 28 ) + ( le.property_full_street_address_Invalid << 29 ) + ( le.property_address_citystatezip_Invalid << 30 ) + ( le.legal_lot_code_Invalid << 31 ) + ( le.legal_phase_number_Invalid << 32 ) + ( le.contract_date_Invalid << 33 ) + ( le.recording_date_Invalid << 35 ) + ( le.arm_reset_date_Invalid << 37 ) + ( le.document_type_code_Invalid << 39 ) + ( le.sales_price_Invalid << 41 ) + ( le.sales_price_code_Invalid << 42 ) + ( le.first_td_loan_amount_Invalid << 43 ) + ( le.second_td_loan_amount_Invalid << 44 ) + ( le.first_td_lender_type_code_Invalid << 45 ) + ( le.second_td_lender_type_code_Invalid << 46 ) + ( le.first_td_loan_type_code_Invalid << 47 ) + ( le.type_financing_Invalid << 48 ) + ( le.first_td_due_date_Invalid << 49 ) + ( le.lender_full_street_address_Invalid << 51 ) + ( le.lender_address_citystatezip_Invalid << 52 ) + ( le.property_use_code_Invalid << 53 ) + ( le.condo_code_Invalid << 54 ) + ( le.rate_change_frequency_Invalid << 55 ) + ( le.adjustable_rate_index_Invalid << 56 ) + ( le.fixed_step_rate_rider_Invalid << 57 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Property_deed);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.vendor_source_flag_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.from_file_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.fips_code_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.apnt_or_pin_number_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.fares_unformatted_apn_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.buyer_or_borrower_ind_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.name1_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.name1_id_code_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.name2_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.name2_id_code_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.vesting_code_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.mailing_care_of_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.mailing_street_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.mailing_unit_number_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.mailing_csz_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.mailing_address_cd_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.seller1_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.seller1_id_code_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.seller2_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.seller2_id_code_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.seller_mailing_full_street_address_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.property_full_street_address_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.property_address_citystatezip_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.legal_lot_code_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.legal_phase_number_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.contract_date_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.recording_date_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.arm_reset_date_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.document_type_code_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.sales_price_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.sales_price_code_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.first_td_loan_amount_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.second_td_loan_amount_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.first_td_lender_type_code_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.second_td_lender_type_code_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.first_td_loan_type_code_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.type_financing_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.first_td_due_date_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.lender_full_street_address_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.lender_address_citystatezip_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.property_use_code_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.condo_code_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.rate_change_frequency_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.adjustable_rate_index_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.fixed_step_rate_rider_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.fips_code) fips_code := IF(Glob, '', h.fips_code);
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.process_date_Invalid=3);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    vendor_source_flag_ENUM_ErrorCount := COUNT(GROUP,h.vendor_source_flag_Invalid=1);
    from_file_ENUM_ErrorCount := COUNT(GROUP,h.from_file_Invalid=1);
    fips_code_ALLOW_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=1);
    fips_code_LENGTHS_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=2);
    fips_code_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=3);
    fips_code_Total_ErrorCount := COUNT(GROUP,h.fips_code_Invalid>0);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    county_name_ALLOW_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    county_name_WORDS_ErrorCount := COUNT(GROUP,h.county_name_Invalid=2);
    county_name_Total_ErrorCount := COUNT(GROUP,h.county_name_Invalid>0);
    record_type_CUSTOM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    apnt_or_pin_number_ALLOW_ErrorCount := COUNT(GROUP,h.apnt_or_pin_number_Invalid=1);
    fares_unformatted_apn_ALLOW_ErrorCount := COUNT(GROUP,h.fares_unformatted_apn_Invalid=1);
    buyer_or_borrower_ind_ENUM_ErrorCount := COUNT(GROUP,h.buyer_or_borrower_ind_Invalid=1);
    name1_ALLOW_ErrorCount := COUNT(GROUP,h.name1_Invalid=1);
    name1_id_code_CUSTOM_ErrorCount := COUNT(GROUP,h.name1_id_code_Invalid=1);
    name2_ALLOW_ErrorCount := COUNT(GROUP,h.name2_Invalid=1);
    name2_id_code_CUSTOM_ErrorCount := COUNT(GROUP,h.name2_id_code_Invalid=1);
    vesting_code_CUSTOM_ErrorCount := COUNT(GROUP,h.vesting_code_Invalid=1);
    mailing_care_of_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_care_of_Invalid=1);
    mailing_street_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_street_Invalid=1);
    mailing_unit_number_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_unit_number_Invalid=1);
    mailing_csz_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_csz_Invalid=1);
    mailing_address_cd_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_address_cd_Invalid=1);
    seller1_ALLOW_ErrorCount := COUNT(GROUP,h.seller1_Invalid=1);
    seller1_id_code_CUSTOM_ErrorCount := COUNT(GROUP,h.seller1_id_code_Invalid=1);
    seller2_ALLOW_ErrorCount := COUNT(GROUP,h.seller2_Invalid=1);
    seller2_id_code_CUSTOM_ErrorCount := COUNT(GROUP,h.seller2_id_code_Invalid=1);
    seller_mailing_full_street_address_ALLOW_ErrorCount := COUNT(GROUP,h.seller_mailing_full_street_address_Invalid=1);
    property_full_street_address_ALLOW_ErrorCount := COUNT(GROUP,h.property_full_street_address_Invalid=1);
    property_address_citystatezip_ALLOW_ErrorCount := COUNT(GROUP,h.property_address_citystatezip_Invalid=1);
    legal_lot_code_CUSTOM_ErrorCount := COUNT(GROUP,h.legal_lot_code_Invalid=1);
    legal_phase_number_ALLOW_ErrorCount := COUNT(GROUP,h.legal_phase_number_Invalid=1);
    contract_date_ALLOW_ErrorCount := COUNT(GROUP,h.contract_date_Invalid=1);
    contract_date_CUSTOM_ErrorCount := COUNT(GROUP,h.contract_date_Invalid=2);
    contract_date_LENGTHS_ErrorCount := COUNT(GROUP,h.contract_date_Invalid=3);
    contract_date_Total_ErrorCount := COUNT(GROUP,h.contract_date_Invalid>0);
    recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=1);
    recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=2);
    recording_date_LENGTHS_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=3);
    recording_date_Total_ErrorCount := COUNT(GROUP,h.recording_date_Invalid>0);
    arm_reset_date_ALLOW_ErrorCount := COUNT(GROUP,h.arm_reset_date_Invalid=1);
    arm_reset_date_CUSTOM_ErrorCount := COUNT(GROUP,h.arm_reset_date_Invalid=2);
    arm_reset_date_LENGTHS_ErrorCount := COUNT(GROUP,h.arm_reset_date_Invalid=3);
    arm_reset_date_Total_ErrorCount := COUNT(GROUP,h.arm_reset_date_Invalid>0);
    document_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.document_type_code_Invalid=1);
    document_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.document_type_code_Invalid=2);
    document_type_code_Total_ErrorCount := COUNT(GROUP,h.document_type_code_Invalid>0);
    sales_price_ALLOW_ErrorCount := COUNT(GROUP,h.sales_price_Invalid=1);
    sales_price_code_CUSTOM_ErrorCount := COUNT(GROUP,h.sales_price_code_Invalid=1);
    first_td_loan_amount_ALLOW_ErrorCount := COUNT(GROUP,h.first_td_loan_amount_Invalid=1);
    second_td_loan_amount_ALLOW_ErrorCount := COUNT(GROUP,h.second_td_loan_amount_Invalid=1);
    first_td_lender_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.first_td_lender_type_code_Invalid=1);
    second_td_lender_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.second_td_lender_type_code_Invalid=1);
    first_td_loan_type_code_CUSTOM_ErrorCount := COUNT(GROUP,h.first_td_loan_type_code_Invalid=1);
    type_financing_CUSTOM_ErrorCount := COUNT(GROUP,h.type_financing_Invalid=1);
    first_td_due_date_ALLOW_ErrorCount := COUNT(GROUP,h.first_td_due_date_Invalid=1);
    first_td_due_date_CUSTOM_ErrorCount := COUNT(GROUP,h.first_td_due_date_Invalid=2);
    first_td_due_date_LENGTHS_ErrorCount := COUNT(GROUP,h.first_td_due_date_Invalid=3);
    first_td_due_date_Total_ErrorCount := COUNT(GROUP,h.first_td_due_date_Invalid>0);
    lender_full_street_address_ALLOW_ErrorCount := COUNT(GROUP,h.lender_full_street_address_Invalid=1);
    lender_address_citystatezip_ALLOW_ErrorCount := COUNT(GROUP,h.lender_address_citystatezip_Invalid=1);
    property_use_code_CUSTOM_ErrorCount := COUNT(GROUP,h.property_use_code_Invalid=1);
    condo_code_CUSTOM_ErrorCount := COUNT(GROUP,h.condo_code_Invalid=1);
    rate_change_frequency_CUSTOM_ErrorCount := COUNT(GROUP,h.rate_change_frequency_Invalid=1);
    adjustable_rate_index_CUSTOM_ErrorCount := COUNT(GROUP,h.adjustable_rate_index_Invalid=1);
    fixed_step_rate_rider_CUSTOM_ErrorCount := COUNT(GROUP,h.fixed_step_rate_rider_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.vendor_source_flag_Invalid > 0 OR h.from_file_Invalid > 0 OR h.fips_code_Invalid > 0 OR h.state_Invalid > 0 OR h.county_name_Invalid > 0 OR h.record_type_Invalid > 0 OR h.apnt_or_pin_number_Invalid > 0 OR h.fares_unformatted_apn_Invalid > 0 OR h.buyer_or_borrower_ind_Invalid > 0 OR h.name1_Invalid > 0 OR h.name1_id_code_Invalid > 0 OR h.name2_Invalid > 0 OR h.name2_id_code_Invalid > 0 OR h.vesting_code_Invalid > 0 OR h.mailing_care_of_Invalid > 0 OR h.mailing_street_Invalid > 0 OR h.mailing_unit_number_Invalid > 0 OR h.mailing_csz_Invalid > 0 OR h.mailing_address_cd_Invalid > 0 OR h.seller1_Invalid > 0 OR h.seller1_id_code_Invalid > 0 OR h.seller2_Invalid > 0 OR h.seller2_id_code_Invalid > 0 OR h.seller_mailing_full_street_address_Invalid > 0 OR h.property_full_street_address_Invalid > 0 OR h.property_address_citystatezip_Invalid > 0 OR h.legal_lot_code_Invalid > 0 OR h.legal_phase_number_Invalid > 0 OR h.contract_date_Invalid > 0 OR h.recording_date_Invalid > 0 OR h.arm_reset_date_Invalid > 0 OR h.document_type_code_Invalid > 0 OR h.sales_price_Invalid > 0 OR h.sales_price_code_Invalid > 0 OR h.first_td_loan_amount_Invalid > 0 OR h.second_td_loan_amount_Invalid > 0 OR h.first_td_lender_type_code_Invalid > 0 OR h.second_td_lender_type_code_Invalid > 0 OR h.first_td_loan_type_code_Invalid > 0 OR h.type_financing_Invalid > 0 OR h.first_td_due_date_Invalid > 0 OR h.lender_full_street_address_Invalid > 0 OR h.lender_address_citystatezip_Invalid > 0 OR h.property_use_code_Invalid > 0 OR h.condo_code_Invalid > 0 OR h.rate_change_frequency_Invalid > 0 OR h.adjustable_rate_index_Invalid > 0 OR h.fixed_step_rate_rider_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,fips_code,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_Total_ErrorCount > 0, 1, 0) + IF(le.vendor_source_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.from_file_ENUM_ErrorCount > 0, 1, 0) + IF(le.fips_code_Total_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.county_name_Total_ErrorCount > 0, 1, 0) + IF(le.record_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.apnt_or_pin_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fares_unformatted_apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_or_borrower_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.name1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name1_id_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name2_id_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vesting_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_care_of_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_csz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_address_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller1_id_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seller2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller2_id_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seller_mailing_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_address_citystatezip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.legal_lot_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.legal_phase_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contract_date_Total_ErrorCount > 0, 1, 0) + IF(le.recording_date_Total_ErrorCount > 0, 1, 0) + IF(le.arm_reset_date_Total_ErrorCount > 0, 1, 0) + IF(le.document_type_code_Total_ErrorCount > 0, 1, 0) + IF(le.sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sales_price_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_td_loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.second_td_loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_td_lender_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_td_lender_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_td_loan_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_financing_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_td_due_date_Total_ErrorCount > 0, 1, 0) + IF(le.lender_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lender_address_citystatezip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_use_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.condo_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rate_change_frequency_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.adjustable_rate_index_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fixed_step_rate_rider_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vendor_source_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.from_file_ENUM_ErrorCount > 0, 1, 0) + IF(le.fips_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_code_WITHIN_FILE_ErrorCount > 0, 1, 0) + IF(le.state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.county_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_name_WORDS_ErrorCount > 0, 1, 0) + IF(le.record_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.apnt_or_pin_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fares_unformatted_apn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.buyer_or_borrower_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.name1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name1_id_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name2_id_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vesting_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_care_of_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_unit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_csz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_address_cd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller1_id_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seller2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.seller2_id_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.seller_mailing_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_address_citystatezip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.legal_lot_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.legal_phase_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contract_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contract_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contract_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.recording_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recording_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.recording_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.arm_reset_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.arm_reset_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.arm_reset_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.document_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.document_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sales_price_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sales_price_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_td_loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.second_td_loan_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_td_lender_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.second_td_lender_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_td_loan_type_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_financing_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_td_due_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_td_due_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_td_due_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lender_full_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lender_address_citystatezip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.property_use_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.condo_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rate_change_frequency_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.adjustable_rate_index_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fixed_step_rate_rider_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.fips_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.vendor_source_flag_Invalid,le.from_file_Invalid,le.fips_code_Invalid,le.state_Invalid,le.county_name_Invalid,le.record_type_Invalid,le.apnt_or_pin_number_Invalid,le.fares_unformatted_apn_Invalid,le.buyer_or_borrower_ind_Invalid,le.name1_Invalid,le.name1_id_code_Invalid,le.name2_Invalid,le.name2_id_code_Invalid,le.vesting_code_Invalid,le.mailing_care_of_Invalid,le.mailing_street_Invalid,le.mailing_unit_number_Invalid,le.mailing_csz_Invalid,le.mailing_address_cd_Invalid,le.seller1_Invalid,le.seller1_id_code_Invalid,le.seller2_Invalid,le.seller2_id_code_Invalid,le.seller_mailing_full_street_address_Invalid,le.property_full_street_address_Invalid,le.property_address_citystatezip_Invalid,le.legal_lot_code_Invalid,le.legal_phase_number_Invalid,le.contract_date_Invalid,le.recording_date_Invalid,le.arm_reset_date_Invalid,le.document_type_code_Invalid,le.sales_price_Invalid,le.sales_price_code_Invalid,le.first_td_loan_amount_Invalid,le.second_td_loan_amount_Invalid,le.first_td_lender_type_code_Invalid,le.second_td_lender_type_code_Invalid,le.first_td_loan_type_code_Invalid,le.type_financing_Invalid,le.first_td_due_date_Invalid,le.lender_full_street_address_Invalid,le.lender_address_citystatezip_Invalid,le.property_use_code_Invalid,le.condo_code_Invalid,le.rate_change_frequency_Invalid,le.adjustable_rate_index_Invalid,le.fixed_step_rate_rider_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_vendor_source_flag(le.vendor_source_flag_Invalid),Fields.InvalidMessage_from_file(le.from_file_Invalid),Fields.InvalidMessage_fips_code(le.fips_code_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_county_name(le.county_name_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_apnt_or_pin_number(le.apnt_or_pin_number_Invalid),Fields.InvalidMessage_fares_unformatted_apn(le.fares_unformatted_apn_Invalid),Fields.InvalidMessage_buyer_or_borrower_ind(le.buyer_or_borrower_ind_Invalid),Fields.InvalidMessage_name1(le.name1_Invalid),Fields.InvalidMessage_name1_id_code(le.name1_id_code_Invalid),Fields.InvalidMessage_name2(le.name2_Invalid),Fields.InvalidMessage_name2_id_code(le.name2_id_code_Invalid),Fields.InvalidMessage_vesting_code(le.vesting_code_Invalid),Fields.InvalidMessage_mailing_care_of(le.mailing_care_of_Invalid),Fields.InvalidMessage_mailing_street(le.mailing_street_Invalid),Fields.InvalidMessage_mailing_unit_number(le.mailing_unit_number_Invalid),Fields.InvalidMessage_mailing_csz(le.mailing_csz_Invalid),Fields.InvalidMessage_mailing_address_cd(le.mailing_address_cd_Invalid),Fields.InvalidMessage_seller1(le.seller1_Invalid),Fields.InvalidMessage_seller1_id_code(le.seller1_id_code_Invalid),Fields.InvalidMessage_seller2(le.seller2_Invalid),Fields.InvalidMessage_seller2_id_code(le.seller2_id_code_Invalid),Fields.InvalidMessage_seller_mailing_full_street_address(le.seller_mailing_full_street_address_Invalid),Fields.InvalidMessage_property_full_street_address(le.property_full_street_address_Invalid),Fields.InvalidMessage_property_address_citystatezip(le.property_address_citystatezip_Invalid),Fields.InvalidMessage_legal_lot_code(le.legal_lot_code_Invalid),Fields.InvalidMessage_legal_phase_number(le.legal_phase_number_Invalid),Fields.InvalidMessage_contract_date(le.contract_date_Invalid),Fields.InvalidMessage_recording_date(le.recording_date_Invalid),Fields.InvalidMessage_arm_reset_date(le.arm_reset_date_Invalid),Fields.InvalidMessage_document_type_code(le.document_type_code_Invalid),Fields.InvalidMessage_sales_price(le.sales_price_Invalid),Fields.InvalidMessage_sales_price_code(le.sales_price_code_Invalid),Fields.InvalidMessage_first_td_loan_amount(le.first_td_loan_amount_Invalid),Fields.InvalidMessage_second_td_loan_amount(le.second_td_loan_amount_Invalid),Fields.InvalidMessage_first_td_lender_type_code(le.first_td_lender_type_code_Invalid),Fields.InvalidMessage_second_td_lender_type_code(le.second_td_lender_type_code_Invalid),Fields.InvalidMessage_first_td_loan_type_code(le.first_td_loan_type_code_Invalid),Fields.InvalidMessage_type_financing(le.type_financing_Invalid),Fields.InvalidMessage_first_td_due_date(le.first_td_due_date_Invalid),Fields.InvalidMessage_lender_full_street_address(le.lender_full_street_address_Invalid),Fields.InvalidMessage_lender_address_citystatezip(le.lender_address_citystatezip_Invalid),Fields.InvalidMessage_property_use_code(le.property_use_code_Invalid),Fields.InvalidMessage_condo_code(le.condo_code_Invalid),Fields.InvalidMessage_rate_change_frequency(le.rate_change_frequency_Invalid),Fields.InvalidMessage_adjustable_rate_index(le.adjustable_rate_index_Invalid),Fields.InvalidMessage_fixed_step_rate_rider(le.fixed_step_rate_rider_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vendor_source_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.from_file_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fips_code_Invalid,'ALLOW','LENGTHS','WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.apnt_or_pin_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fares_unformatted_apn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.buyer_or_borrower_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.name1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name1_id_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name2_id_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vesting_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_care_of_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_street_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_unit_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_csz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_address_cd_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seller1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seller1_id_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seller2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.seller2_id_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.seller_mailing_full_street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_full_street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_address_citystatezip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.legal_lot_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.legal_phase_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contract_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.recording_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.arm_reset_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.document_type_code_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sales_price_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_td_loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.second_td_loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.first_td_lender_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.second_td_lender_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_td_loan_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.type_financing_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_td_due_date_Invalid,'ALLOW','CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.lender_full_street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lender_address_citystatezip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_use_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.condo_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rate_change_frequency_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.adjustable_rate_index_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fixed_step_rate_rider_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','vendor_source_flag','from_file','fips_code','state','county_name','record_type','apnt_or_pin_number','fares_unformatted_apn','buyer_or_borrower_ind','name1','name1_id_code','name2','name2_id_code','vesting_code','mailing_care_of','mailing_street','mailing_unit_number','mailing_csz','mailing_address_cd','seller1','seller1_id_code','seller2','seller2_id_code','seller_mailing_full_street_address','property_full_street_address','property_address_citystatezip','legal_lot_code','legal_phase_number','contract_date','recording_date','arm_reset_date','document_type_code','sales_price','sales_price_code','first_td_loan_amount','second_td_loan_amount','first_td_lender_type_code','second_td_lender_type_code','first_td_loan_type_code','type_financing','first_td_due_date','lender_full_street_address','lender_address_citystatezip','property_use_code','condo_code','rate_change_frequency','adjustable_rate_index','fixed_step_rate_rider','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_vendor_source','invalid_from_file','invalid_fips','invalid_state_code','invalid_county_name','invalid_record_type','invalid_apn','invalid_apn','invalid_buyer_or_borrower_ind','invalid_alpha','invalid_name1_id_code','invalid_alpha','invalid_name1_id_code','invalid_vesting_code','invalid_alpha','invalid_address','invalid_address','invalid_zcs','invalid_address','invalid_alpha','invalid_seller1_id_code','invalid_alpha','invalid_seller2_id_code','invalid_address','invalid_address','invalid_address','invalid_legal_lot_code','invalid_char','invalid_date','invalid_date','invalid_date_future','invalid_document_type_code','invalid_amount','invalid_sales_price_code','invalid_amount','invalid_amount','invalid_lender_type_code','invalid_lender_type_code','invalid_loan_type_code','invalid_type_financing','invalid_date_future','invalid_address','invalid_address','invalid_property_use_code','invalid_condo_code','invalid_rate_change_frequency','invalid_adjustable_rate_index','invalid_fixed_step_rate_ride','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.vendor_source_flag,(SALT311.StrType)le.from_file,(SALT311.StrType)le.fips_code,(SALT311.StrType)le.state,(SALT311.StrType)le.county_name,(SALT311.StrType)le.record_type,(SALT311.StrType)le.apnt_or_pin_number,(SALT311.StrType)le.fares_unformatted_apn,(SALT311.StrType)le.buyer_or_borrower_ind,(SALT311.StrType)le.name1,(SALT311.StrType)le.name1_id_code,(SALT311.StrType)le.name2,(SALT311.StrType)le.name2_id_code,(SALT311.StrType)le.vesting_code,(SALT311.StrType)le.mailing_care_of,(SALT311.StrType)le.mailing_street,(SALT311.StrType)le.mailing_unit_number,(SALT311.StrType)le.mailing_csz,(SALT311.StrType)le.mailing_address_cd,(SALT311.StrType)le.seller1,(SALT311.StrType)le.seller1_id_code,(SALT311.StrType)le.seller2,(SALT311.StrType)le.seller2_id_code,(SALT311.StrType)le.seller_mailing_full_street_address,(SALT311.StrType)le.property_full_street_address,(SALT311.StrType)le.property_address_citystatezip,(SALT311.StrType)le.legal_lot_code,(SALT311.StrType)le.legal_phase_number,(SALT311.StrType)le.contract_date,(SALT311.StrType)le.recording_date,(SALT311.StrType)le.arm_reset_date,(SALT311.StrType)le.document_type_code,(SALT311.StrType)le.sales_price,(SALT311.StrType)le.sales_price_code,(SALT311.StrType)le.first_td_loan_amount,(SALT311.StrType)le.second_td_loan_amount,(SALT311.StrType)le.first_td_lender_type_code,(SALT311.StrType)le.second_td_lender_type_code,(SALT311.StrType)le.first_td_loan_type_code,(SALT311.StrType)le.type_financing,(SALT311.StrType)le.first_td_due_date,(SALT311.StrType)le.lender_full_street_address,(SALT311.StrType)le.lender_address_citystatezip,(SALT311.StrType)le.property_use_code,(SALT311.StrType)le.condo_code,(SALT311.StrType)le.rate_change_frequency,(SALT311.StrType)le.adjustable_rate_index,(SALT311.StrType)le.fixed_step_rate_rider,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,49,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Property_deed) prevDS = DATASET([], Layout_Property_deed)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.fips_code;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:CUSTOM','process_date:invalid_date:LENGTHS'
          ,'vendor_source_flag:invalid_vendor_source:ENUM'
          ,'from_file:invalid_from_file:ENUM'
          ,'fips_code:invalid_fips:ALLOW','fips_code:invalid_fips:LENGTHS','fips_code:invalid_fips:WITHIN_FILE'
          ,'state:invalid_state_code:LEFTTRIM','state:invalid_state_code:ALLOW','state:invalid_state_code:LENGTHS'
          ,'county_name:invalid_county_name:ALLOW','county_name:invalid_county_name:WORDS'
          ,'record_type:invalid_record_type:CUSTOM'
          ,'apnt_or_pin_number:invalid_apn:ALLOW'
          ,'fares_unformatted_apn:invalid_apn:ALLOW'
          ,'buyer_or_borrower_ind:invalid_buyer_or_borrower_ind:ENUM'
          ,'name1:invalid_alpha:ALLOW'
          ,'name1_id_code:invalid_name1_id_code:CUSTOM'
          ,'name2:invalid_alpha:ALLOW'
          ,'name2_id_code:invalid_name1_id_code:CUSTOM'
          ,'vesting_code:invalid_vesting_code:CUSTOM'
          ,'mailing_care_of:invalid_alpha:ALLOW'
          ,'mailing_street:invalid_address:ALLOW'
          ,'mailing_unit_number:invalid_address:ALLOW'
          ,'mailing_csz:invalid_zcs:ALLOW'
          ,'mailing_address_cd:invalid_address:ALLOW'
          ,'seller1:invalid_alpha:ALLOW'
          ,'seller1_id_code:invalid_seller1_id_code:CUSTOM'
          ,'seller2:invalid_alpha:ALLOW'
          ,'seller2_id_code:invalid_seller2_id_code:CUSTOM'
          ,'seller_mailing_full_street_address:invalid_address:ALLOW'
          ,'property_full_street_address:invalid_address:ALLOW'
          ,'property_address_citystatezip:invalid_address:ALLOW'
          ,'legal_lot_code:invalid_legal_lot_code:CUSTOM'
          ,'legal_phase_number:invalid_char:ALLOW'
          ,'contract_date:invalid_date:ALLOW','contract_date:invalid_date:CUSTOM','contract_date:invalid_date:LENGTHS'
          ,'recording_date:invalid_date:ALLOW','recording_date:invalid_date:CUSTOM','recording_date:invalid_date:LENGTHS'
          ,'arm_reset_date:invalid_date_future:ALLOW','arm_reset_date:invalid_date_future:CUSTOM','arm_reset_date:invalid_date_future:LENGTHS'
          ,'document_type_code:invalid_document_type_code:ALLOW','document_type_code:invalid_document_type_code:CUSTOM'
          ,'sales_price:invalid_amount:ALLOW'
          ,'sales_price_code:invalid_sales_price_code:CUSTOM'
          ,'first_td_loan_amount:invalid_amount:ALLOW'
          ,'second_td_loan_amount:invalid_amount:ALLOW'
          ,'first_td_lender_type_code:invalid_lender_type_code:CUSTOM'
          ,'second_td_lender_type_code:invalid_lender_type_code:CUSTOM'
          ,'first_td_loan_type_code:invalid_loan_type_code:CUSTOM'
          ,'type_financing:invalid_type_financing:CUSTOM'
          ,'first_td_due_date:invalid_date_future:ALLOW','first_td_due_date:invalid_date_future:CUSTOM','first_td_due_date:invalid_date_future:LENGTHS'
          ,'lender_full_street_address:invalid_address:ALLOW'
          ,'lender_address_citystatezip:invalid_address:ALLOW'
          ,'property_use_code:invalid_property_use_code:CUSTOM'
          ,'condo_code:invalid_condo_code:CUSTOM'
          ,'rate_change_frequency:invalid_rate_change_frequency:CUSTOM'
          ,'adjustable_rate_index:invalid_adjustable_rate_index:CUSTOM'
          ,'fixed_step_rate_rider:invalid_fixed_step_rate_ride:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2),Fields.InvalidMessage_process_date(3)
          ,Fields.InvalidMessage_vendor_source_flag(1)
          ,Fields.InvalidMessage_from_file(1)
          ,Fields.InvalidMessage_fips_code(1),Fields.InvalidMessage_fips_code(2),Fields.InvalidMessage_fips_code(3)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2),Fields.InvalidMessage_state(3)
          ,Fields.InvalidMessage_county_name(1),Fields.InvalidMessage_county_name(2)
          ,Fields.InvalidMessage_record_type(1)
          ,Fields.InvalidMessage_apnt_or_pin_number(1)
          ,Fields.InvalidMessage_fares_unformatted_apn(1)
          ,Fields.InvalidMessage_buyer_or_borrower_ind(1)
          ,Fields.InvalidMessage_name1(1)
          ,Fields.InvalidMessage_name1_id_code(1)
          ,Fields.InvalidMessage_name2(1)
          ,Fields.InvalidMessage_name2_id_code(1)
          ,Fields.InvalidMessage_vesting_code(1)
          ,Fields.InvalidMessage_mailing_care_of(1)
          ,Fields.InvalidMessage_mailing_street(1)
          ,Fields.InvalidMessage_mailing_unit_number(1)
          ,Fields.InvalidMessage_mailing_csz(1)
          ,Fields.InvalidMessage_mailing_address_cd(1)
          ,Fields.InvalidMessage_seller1(1)
          ,Fields.InvalidMessage_seller1_id_code(1)
          ,Fields.InvalidMessage_seller2(1)
          ,Fields.InvalidMessage_seller2_id_code(1)
          ,Fields.InvalidMessage_seller_mailing_full_street_address(1)
          ,Fields.InvalidMessage_property_full_street_address(1)
          ,Fields.InvalidMessage_property_address_citystatezip(1)
          ,Fields.InvalidMessage_legal_lot_code(1)
          ,Fields.InvalidMessage_legal_phase_number(1)
          ,Fields.InvalidMessage_contract_date(1),Fields.InvalidMessage_contract_date(2),Fields.InvalidMessage_contract_date(3)
          ,Fields.InvalidMessage_recording_date(1),Fields.InvalidMessage_recording_date(2),Fields.InvalidMessage_recording_date(3)
          ,Fields.InvalidMessage_arm_reset_date(1),Fields.InvalidMessage_arm_reset_date(2),Fields.InvalidMessage_arm_reset_date(3)
          ,Fields.InvalidMessage_document_type_code(1),Fields.InvalidMessage_document_type_code(2)
          ,Fields.InvalidMessage_sales_price(1)
          ,Fields.InvalidMessage_sales_price_code(1)
          ,Fields.InvalidMessage_first_td_loan_amount(1)
          ,Fields.InvalidMessage_second_td_loan_amount(1)
          ,Fields.InvalidMessage_first_td_lender_type_code(1)
          ,Fields.InvalidMessage_second_td_lender_type_code(1)
          ,Fields.InvalidMessage_first_td_loan_type_code(1)
          ,Fields.InvalidMessage_type_financing(1)
          ,Fields.InvalidMessage_first_td_due_date(1),Fields.InvalidMessage_first_td_due_date(2),Fields.InvalidMessage_first_td_due_date(3)
          ,Fields.InvalidMessage_lender_full_street_address(1)
          ,Fields.InvalidMessage_lender_address_citystatezip(1)
          ,Fields.InvalidMessage_property_use_code(1)
          ,Fields.InvalidMessage_condo_code(1)
          ,Fields.InvalidMessage_rate_change_frequency(1)
          ,Fields.InvalidMessage_adjustable_rate_index(1)
          ,Fields.InvalidMessage_fixed_step_rate_rider(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.vendor_source_flag_ENUM_ErrorCount
          ,le.from_file_ENUM_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTHS_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.record_type_CUSTOM_ErrorCount
          ,le.apnt_or_pin_number_ALLOW_ErrorCount
          ,le.fares_unformatted_apn_ALLOW_ErrorCount
          ,le.buyer_or_borrower_ind_ENUM_ErrorCount
          ,le.name1_ALLOW_ErrorCount
          ,le.name1_id_code_CUSTOM_ErrorCount
          ,le.name2_ALLOW_ErrorCount
          ,le.name2_id_code_CUSTOM_ErrorCount
          ,le.vesting_code_CUSTOM_ErrorCount
          ,le.mailing_care_of_ALLOW_ErrorCount
          ,le.mailing_street_ALLOW_ErrorCount
          ,le.mailing_unit_number_ALLOW_ErrorCount
          ,le.mailing_csz_ALLOW_ErrorCount
          ,le.mailing_address_cd_ALLOW_ErrorCount
          ,le.seller1_ALLOW_ErrorCount
          ,le.seller1_id_code_CUSTOM_ErrorCount
          ,le.seller2_ALLOW_ErrorCount
          ,le.seller2_id_code_CUSTOM_ErrorCount
          ,le.seller_mailing_full_street_address_ALLOW_ErrorCount
          ,le.property_full_street_address_ALLOW_ErrorCount
          ,le.property_address_citystatezip_ALLOW_ErrorCount
          ,le.legal_lot_code_CUSTOM_ErrorCount
          ,le.legal_phase_number_ALLOW_ErrorCount
          ,le.contract_date_ALLOW_ErrorCount,le.contract_date_CUSTOM_ErrorCount,le.contract_date_LENGTHS_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_CUSTOM_ErrorCount,le.recording_date_LENGTHS_ErrorCount
          ,le.arm_reset_date_ALLOW_ErrorCount,le.arm_reset_date_CUSTOM_ErrorCount,le.arm_reset_date_LENGTHS_ErrorCount
          ,le.document_type_code_ALLOW_ErrorCount,le.document_type_code_CUSTOM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_CUSTOM_ErrorCount
          ,le.first_td_loan_amount_ALLOW_ErrorCount
          ,le.second_td_loan_amount_ALLOW_ErrorCount
          ,le.first_td_lender_type_code_CUSTOM_ErrorCount
          ,le.second_td_lender_type_code_CUSTOM_ErrorCount
          ,le.first_td_loan_type_code_CUSTOM_ErrorCount
          ,le.type_financing_CUSTOM_ErrorCount
          ,le.first_td_due_date_ALLOW_ErrorCount,le.first_td_due_date_CUSTOM_ErrorCount,le.first_td_due_date_LENGTHS_ErrorCount
          ,le.lender_full_street_address_ALLOW_ErrorCount
          ,le.lender_address_citystatezip_ALLOW_ErrorCount
          ,le.property_use_code_CUSTOM_ErrorCount
          ,le.condo_code_CUSTOM_ErrorCount
          ,le.rate_change_frequency_CUSTOM_ErrorCount
          ,le.adjustable_rate_index_CUSTOM_ErrorCount
          ,le.fixed_step_rate_rider_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.vendor_source_flag_ENUM_ErrorCount
          ,le.from_file_ENUM_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTHS_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.county_name_ALLOW_ErrorCount,le.county_name_WORDS_ErrorCount
          ,le.record_type_CUSTOM_ErrorCount
          ,le.apnt_or_pin_number_ALLOW_ErrorCount
          ,le.fares_unformatted_apn_ALLOW_ErrorCount
          ,le.buyer_or_borrower_ind_ENUM_ErrorCount
          ,le.name1_ALLOW_ErrorCount
          ,le.name1_id_code_CUSTOM_ErrorCount
          ,le.name2_ALLOW_ErrorCount
          ,le.name2_id_code_CUSTOM_ErrorCount
          ,le.vesting_code_CUSTOM_ErrorCount
          ,le.mailing_care_of_ALLOW_ErrorCount
          ,le.mailing_street_ALLOW_ErrorCount
          ,le.mailing_unit_number_ALLOW_ErrorCount
          ,le.mailing_csz_ALLOW_ErrorCount
          ,le.mailing_address_cd_ALLOW_ErrorCount
          ,le.seller1_ALLOW_ErrorCount
          ,le.seller1_id_code_CUSTOM_ErrorCount
          ,le.seller2_ALLOW_ErrorCount
          ,le.seller2_id_code_CUSTOM_ErrorCount
          ,le.seller_mailing_full_street_address_ALLOW_ErrorCount
          ,le.property_full_street_address_ALLOW_ErrorCount
          ,le.property_address_citystatezip_ALLOW_ErrorCount
          ,le.legal_lot_code_CUSTOM_ErrorCount
          ,le.legal_phase_number_ALLOW_ErrorCount
          ,le.contract_date_ALLOW_ErrorCount,le.contract_date_CUSTOM_ErrorCount,le.contract_date_LENGTHS_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_CUSTOM_ErrorCount,le.recording_date_LENGTHS_ErrorCount
          ,le.arm_reset_date_ALLOW_ErrorCount,le.arm_reset_date_CUSTOM_ErrorCount,le.arm_reset_date_LENGTHS_ErrorCount
          ,le.document_type_code_ALLOW_ErrorCount,le.document_type_code_CUSTOM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_CUSTOM_ErrorCount
          ,le.first_td_loan_amount_ALLOW_ErrorCount
          ,le.second_td_loan_amount_ALLOW_ErrorCount
          ,le.first_td_lender_type_code_CUSTOM_ErrorCount
          ,le.second_td_lender_type_code_CUSTOM_ErrorCount
          ,le.first_td_loan_type_code_CUSTOM_ErrorCount
          ,le.type_financing_CUSTOM_ErrorCount
          ,le.first_td_due_date_ALLOW_ErrorCount,le.first_td_due_date_CUSTOM_ErrorCount,le.first_td_due_date_LENGTHS_ErrorCount
          ,le.lender_full_street_address_ALLOW_ErrorCount
          ,le.lender_address_citystatezip_ALLOW_ErrorCount
          ,le.property_use_code_CUSTOM_ErrorCount
          ,le.condo_code_CUSTOM_ErrorCount
          ,le.rate_change_frequency_CUSTOM_ErrorCount
          ,le.adjustable_rate_index_CUSTOM_ErrorCount
          ,le.fixed_step_rate_rider_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_Property_deed));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'ln_fares_id:' + getFieldTypeText(h.ln_fares_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_source_flag:' + getFieldTypeText(h.vendor_source_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_record:' + getFieldTypeText(h.current_record) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'from_file:' + getFieldTypeText(h.from_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_code:' + getFieldTypeText(h.fips_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apnt_or_pin_number:' + getFieldTypeText(h.apnt_or_pin_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fares_unformatted_apn:' + getFieldTypeText(h.fares_unformatted_apn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'multi_apn_flag:' + getFieldTypeText(h.multi_apn_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tax_id_number:' + getFieldTypeText(h.tax_id_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'excise_tax_number:' + getFieldTypeText(h.excise_tax_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'buyer_or_borrower_ind:' + getFieldTypeText(h.buyer_or_borrower_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name1:' + getFieldTypeText(h.name1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name1_id_code:' + getFieldTypeText(h.name1_id_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name2:' + getFieldTypeText(h.name2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name2_id_code:' + getFieldTypeText(h.name2_id_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vesting_code:' + getFieldTypeText(h.vesting_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addendum_flag:' + getFieldTypeText(h.addendum_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_care_of:' + getFieldTypeText(h.mailing_care_of) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_street:' + getFieldTypeText(h.mailing_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_unit_number:' + getFieldTypeText(h.mailing_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_csz:' + getFieldTypeText(h.mailing_csz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_address_cd:' + getFieldTypeText(h.mailing_address_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller1:' + getFieldTypeText(h.seller1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller1_id_code:' + getFieldTypeText(h.seller1_id_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller2:' + getFieldTypeText(h.seller2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller2_id_code:' + getFieldTypeText(h.seller2_id_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller_addendum_flag:' + getFieldTypeText(h.seller_addendum_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller_mailing_full_street_address:' + getFieldTypeText(h.seller_mailing_full_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller_mailing_address_unit_number:' + getFieldTypeText(h.seller_mailing_address_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seller_mailing_address_citystatezip:' + getFieldTypeText(h.seller_mailing_address_citystatezip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_full_street_address:' + getFieldTypeText(h.property_full_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_address_unit_number:' + getFieldTypeText(h.property_address_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_address_citystatezip:' + getFieldTypeText(h.property_address_citystatezip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_address_code:' + getFieldTypeText(h.property_address_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_lot_code:' + getFieldTypeText(h.legal_lot_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_lot_number:' + getFieldTypeText(h.legal_lot_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_block:' + getFieldTypeText(h.legal_block) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_section:' + getFieldTypeText(h.legal_section) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_district:' + getFieldTypeText(h.legal_district) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_land_lot:' + getFieldTypeText(h.legal_land_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_unit:' + getFieldTypeText(h.legal_unit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_city_municipality_township:' + getFieldTypeText(h.legal_city_municipality_township) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_subdivision_name:' + getFieldTypeText(h.legal_subdivision_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_phase_number:' + getFieldTypeText(h.legal_phase_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_tract_number:' + getFieldTypeText(h.legal_tract_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_sec_twn_rng_mer:' + getFieldTypeText(h.legal_sec_twn_rng_mer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_brief_description:' + getFieldTypeText(h.legal_brief_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recorder_map_reference:' + getFieldTypeText(h.recorder_map_reference) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'complete_legal_description_code:' + getFieldTypeText(h.complete_legal_description_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contract_date:' + getFieldTypeText(h.contract_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_date:' + getFieldTypeText(h.recording_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arm_reset_date:' + getFieldTypeText(h.arm_reset_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'document_number:' + getFieldTypeText(h.document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'document_type_code:' + getFieldTypeText(h.document_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_number:' + getFieldTypeText(h.loan_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recorder_book_number:' + getFieldTypeText(h.recorder_book_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recorder_page_number:' + getFieldTypeText(h.recorder_page_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'concurrent_mortgage_book_page_document_number:' + getFieldTypeText(h.concurrent_mortgage_book_page_document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price:' + getFieldTypeText(h.sales_price) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sales_price_code:' + getFieldTypeText(h.sales_price_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city_transfer_tax:' + getFieldTypeText(h.city_transfer_tax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_transfer_tax:' + getFieldTypeText(h.county_transfer_tax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_transfer_tax:' + getFieldTypeText(h.total_transfer_tax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_td_loan_amount:' + getFieldTypeText(h.first_td_loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_td_loan_amount:' + getFieldTypeText(h.second_td_loan_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_td_lender_type_code:' + getFieldTypeText(h.first_td_lender_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_td_lender_type_code:' + getFieldTypeText(h.second_td_lender_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_td_loan_type_code:' + getFieldTypeText(h.first_td_loan_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_financing:' + getFieldTypeText(h.type_financing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_td_interest_rate:' + getFieldTypeText(h.first_td_interest_rate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_td_due_date:' + getFieldTypeText(h.first_td_due_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title_company_name:' + getFieldTypeText(h.title_company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'partial_interest_transferred:' + getFieldTypeText(h.partial_interest_transferred) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_term_months:' + getFieldTypeText(h.loan_term_months) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loan_term_years:' + getFieldTypeText(h.loan_term_years) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lender_name:' + getFieldTypeText(h.lender_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lender_name_id:' + getFieldTypeText(h.lender_name_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lender_dba_aka_name:' + getFieldTypeText(h.lender_dba_aka_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lender_full_street_address:' + getFieldTypeText(h.lender_full_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lender_address_unit_number:' + getFieldTypeText(h.lender_address_unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lender_address_citystatezip:' + getFieldTypeText(h.lender_address_citystatezip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assessment_match_land_use_code:' + getFieldTypeText(h.assessment_match_land_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_use_code:' + getFieldTypeText(h.property_use_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'condo_code:' + getFieldTypeText(h.condo_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timeshare_flag:' + getFieldTypeText(h.timeshare_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'land_lot_size:' + getFieldTypeText(h.land_lot_size) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hawaii_tct:' + getFieldTypeText(h.hawaii_tct) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hawaii_condo_cpr_code:' + getFieldTypeText(h.hawaii_condo_cpr_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hawaii_condo_name:' + getFieldTypeText(h.hawaii_condo_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler_except_hawaii:' + getFieldTypeText(h.filler_except_hawaii) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rate_change_frequency:' + getFieldTypeText(h.rate_change_frequency) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'change_index:' + getFieldTypeText(h.change_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'adjustable_rate_index:' + getFieldTypeText(h.adjustable_rate_index) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'adjustable_rate_rider:' + getFieldTypeText(h.adjustable_rate_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'graduated_payment_rider:' + getFieldTypeText(h.graduated_payment_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'balloon_rider:' + getFieldTypeText(h.balloon_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fixed_step_rate_rider:' + getFieldTypeText(h.fixed_step_rate_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'condominium_rider:' + getFieldTypeText(h.condominium_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'planned_unit_development_rider:' + getFieldTypeText(h.planned_unit_development_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rate_improvement_rider:' + getFieldTypeText(h.rate_improvement_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assumability_rider:' + getFieldTypeText(h.assumability_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepayment_rider:' + getFieldTypeText(h.prepayment_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'one_four_family_rider:' + getFieldTypeText(h.one_four_family_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'biweekly_payment_rider:' + getFieldTypeText(h.biweekly_payment_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'second_home_rider:' + getFieldTypeText(h.second_home_rider) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'data_source_code:' + getFieldTypeText(h.data_source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'main_record_id_code:' + getFieldTypeText(h.main_record_id_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addl_name_flag:' + getFieldTypeText(h.addl_name_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_propagated_ind:' + getFieldTypeText(h.prop_addr_propagated_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_ownership_rights:' + getFieldTypeText(h.ln_ownership_rights) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_relationship_type:' + getFieldTypeText(h.ln_relationship_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_buyer_mailing_country_code:' + getFieldTypeText(h.ln_buyer_mailing_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_seller_mailing_country_code:' + getFieldTypeText(h.ln_seller_mailing_country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ln_fares_id_cnt
          ,le.populated_process_date_cnt
          ,le.populated_vendor_source_flag_cnt
          ,le.populated_current_record_cnt
          ,le.populated_from_file_cnt
          ,le.populated_fips_code_cnt
          ,le.populated_state_cnt
          ,le.populated_county_name_cnt
          ,le.populated_record_type_cnt
          ,le.populated_apnt_or_pin_number_cnt
          ,le.populated_fares_unformatted_apn_cnt
          ,le.populated_multi_apn_flag_cnt
          ,le.populated_tax_id_number_cnt
          ,le.populated_excise_tax_number_cnt
          ,le.populated_buyer_or_borrower_ind_cnt
          ,le.populated_name1_cnt
          ,le.populated_name1_id_code_cnt
          ,le.populated_name2_cnt
          ,le.populated_name2_id_code_cnt
          ,le.populated_vesting_code_cnt
          ,le.populated_addendum_flag_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_mailing_care_of_cnt
          ,le.populated_mailing_street_cnt
          ,le.populated_mailing_unit_number_cnt
          ,le.populated_mailing_csz_cnt
          ,le.populated_mailing_address_cd_cnt
          ,le.populated_seller1_cnt
          ,le.populated_seller1_id_code_cnt
          ,le.populated_seller2_cnt
          ,le.populated_seller2_id_code_cnt
          ,le.populated_seller_addendum_flag_cnt
          ,le.populated_seller_mailing_full_street_address_cnt
          ,le.populated_seller_mailing_address_unit_number_cnt
          ,le.populated_seller_mailing_address_citystatezip_cnt
          ,le.populated_property_full_street_address_cnt
          ,le.populated_property_address_unit_number_cnt
          ,le.populated_property_address_citystatezip_cnt
          ,le.populated_property_address_code_cnt
          ,le.populated_legal_lot_code_cnt
          ,le.populated_legal_lot_number_cnt
          ,le.populated_legal_block_cnt
          ,le.populated_legal_section_cnt
          ,le.populated_legal_district_cnt
          ,le.populated_legal_land_lot_cnt
          ,le.populated_legal_unit_cnt
          ,le.populated_legal_city_municipality_township_cnt
          ,le.populated_legal_subdivision_name_cnt
          ,le.populated_legal_phase_number_cnt
          ,le.populated_legal_tract_number_cnt
          ,le.populated_legal_sec_twn_rng_mer_cnt
          ,le.populated_legal_brief_description_cnt
          ,le.populated_recorder_map_reference_cnt
          ,le.populated_complete_legal_description_code_cnt
          ,le.populated_contract_date_cnt
          ,le.populated_recording_date_cnt
          ,le.populated_arm_reset_date_cnt
          ,le.populated_document_number_cnt
          ,le.populated_document_type_code_cnt
          ,le.populated_loan_number_cnt
          ,le.populated_recorder_book_number_cnt
          ,le.populated_recorder_page_number_cnt
          ,le.populated_concurrent_mortgage_book_page_document_number_cnt
          ,le.populated_sales_price_cnt
          ,le.populated_sales_price_code_cnt
          ,le.populated_city_transfer_tax_cnt
          ,le.populated_county_transfer_tax_cnt
          ,le.populated_total_transfer_tax_cnt
          ,le.populated_first_td_loan_amount_cnt
          ,le.populated_second_td_loan_amount_cnt
          ,le.populated_first_td_lender_type_code_cnt
          ,le.populated_second_td_lender_type_code_cnt
          ,le.populated_first_td_loan_type_code_cnt
          ,le.populated_type_financing_cnt
          ,le.populated_first_td_interest_rate_cnt
          ,le.populated_first_td_due_date_cnt
          ,le.populated_title_company_name_cnt
          ,le.populated_partial_interest_transferred_cnt
          ,le.populated_loan_term_months_cnt
          ,le.populated_loan_term_years_cnt
          ,le.populated_lender_name_cnt
          ,le.populated_lender_name_id_cnt
          ,le.populated_lender_dba_aka_name_cnt
          ,le.populated_lender_full_street_address_cnt
          ,le.populated_lender_address_unit_number_cnt
          ,le.populated_lender_address_citystatezip_cnt
          ,le.populated_assessment_match_land_use_code_cnt
          ,le.populated_property_use_code_cnt
          ,le.populated_condo_code_cnt
          ,le.populated_timeshare_flag_cnt
          ,le.populated_land_lot_size_cnt
          ,le.populated_hawaii_tct_cnt
          ,le.populated_hawaii_condo_cpr_code_cnt
          ,le.populated_hawaii_condo_name_cnt
          ,le.populated_filler_except_hawaii_cnt
          ,le.populated_rate_change_frequency_cnt
          ,le.populated_change_index_cnt
          ,le.populated_adjustable_rate_index_cnt
          ,le.populated_adjustable_rate_rider_cnt
          ,le.populated_graduated_payment_rider_cnt
          ,le.populated_balloon_rider_cnt
          ,le.populated_fixed_step_rate_rider_cnt
          ,le.populated_condominium_rider_cnt
          ,le.populated_planned_unit_development_rider_cnt
          ,le.populated_rate_improvement_rider_cnt
          ,le.populated_assumability_rider_cnt
          ,le.populated_prepayment_rider_cnt
          ,le.populated_one_four_family_rider_cnt
          ,le.populated_biweekly_payment_rider_cnt
          ,le.populated_second_home_rider_cnt
          ,le.populated_data_source_code_cnt
          ,le.populated_main_record_id_code_cnt
          ,le.populated_addl_name_flag_cnt
          ,le.populated_prop_addr_propagated_ind_cnt
          ,le.populated_ln_ownership_rights_cnt
          ,le.populated_ln_relationship_type_cnt
          ,le.populated_ln_buyer_mailing_country_code_cnt
          ,le.populated_ln_seller_mailing_country_code_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ln_fares_id_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_vendor_source_flag_pcnt
          ,le.populated_current_record_pcnt
          ,le.populated_from_file_pcnt
          ,le.populated_fips_code_pcnt
          ,le.populated_state_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_apnt_or_pin_number_pcnt
          ,le.populated_fares_unformatted_apn_pcnt
          ,le.populated_multi_apn_flag_pcnt
          ,le.populated_tax_id_number_pcnt
          ,le.populated_excise_tax_number_pcnt
          ,le.populated_buyer_or_borrower_ind_pcnt
          ,le.populated_name1_pcnt
          ,le.populated_name1_id_code_pcnt
          ,le.populated_name2_pcnt
          ,le.populated_name2_id_code_pcnt
          ,le.populated_vesting_code_pcnt
          ,le.populated_addendum_flag_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_mailing_care_of_pcnt
          ,le.populated_mailing_street_pcnt
          ,le.populated_mailing_unit_number_pcnt
          ,le.populated_mailing_csz_pcnt
          ,le.populated_mailing_address_cd_pcnt
          ,le.populated_seller1_pcnt
          ,le.populated_seller1_id_code_pcnt
          ,le.populated_seller2_pcnt
          ,le.populated_seller2_id_code_pcnt
          ,le.populated_seller_addendum_flag_pcnt
          ,le.populated_seller_mailing_full_street_address_pcnt
          ,le.populated_seller_mailing_address_unit_number_pcnt
          ,le.populated_seller_mailing_address_citystatezip_pcnt
          ,le.populated_property_full_street_address_pcnt
          ,le.populated_property_address_unit_number_pcnt
          ,le.populated_property_address_citystatezip_pcnt
          ,le.populated_property_address_code_pcnt
          ,le.populated_legal_lot_code_pcnt
          ,le.populated_legal_lot_number_pcnt
          ,le.populated_legal_block_pcnt
          ,le.populated_legal_section_pcnt
          ,le.populated_legal_district_pcnt
          ,le.populated_legal_land_lot_pcnt
          ,le.populated_legal_unit_pcnt
          ,le.populated_legal_city_municipality_township_pcnt
          ,le.populated_legal_subdivision_name_pcnt
          ,le.populated_legal_phase_number_pcnt
          ,le.populated_legal_tract_number_pcnt
          ,le.populated_legal_sec_twn_rng_mer_pcnt
          ,le.populated_legal_brief_description_pcnt
          ,le.populated_recorder_map_reference_pcnt
          ,le.populated_complete_legal_description_code_pcnt
          ,le.populated_contract_date_pcnt
          ,le.populated_recording_date_pcnt
          ,le.populated_arm_reset_date_pcnt
          ,le.populated_document_number_pcnt
          ,le.populated_document_type_code_pcnt
          ,le.populated_loan_number_pcnt
          ,le.populated_recorder_book_number_pcnt
          ,le.populated_recorder_page_number_pcnt
          ,le.populated_concurrent_mortgage_book_page_document_number_pcnt
          ,le.populated_sales_price_pcnt
          ,le.populated_sales_price_code_pcnt
          ,le.populated_city_transfer_tax_pcnt
          ,le.populated_county_transfer_tax_pcnt
          ,le.populated_total_transfer_tax_pcnt
          ,le.populated_first_td_loan_amount_pcnt
          ,le.populated_second_td_loan_amount_pcnt
          ,le.populated_first_td_lender_type_code_pcnt
          ,le.populated_second_td_lender_type_code_pcnt
          ,le.populated_first_td_loan_type_code_pcnt
          ,le.populated_type_financing_pcnt
          ,le.populated_first_td_interest_rate_pcnt
          ,le.populated_first_td_due_date_pcnt
          ,le.populated_title_company_name_pcnt
          ,le.populated_partial_interest_transferred_pcnt
          ,le.populated_loan_term_months_pcnt
          ,le.populated_loan_term_years_pcnt
          ,le.populated_lender_name_pcnt
          ,le.populated_lender_name_id_pcnt
          ,le.populated_lender_dba_aka_name_pcnt
          ,le.populated_lender_full_street_address_pcnt
          ,le.populated_lender_address_unit_number_pcnt
          ,le.populated_lender_address_citystatezip_pcnt
          ,le.populated_assessment_match_land_use_code_pcnt
          ,le.populated_property_use_code_pcnt
          ,le.populated_condo_code_pcnt
          ,le.populated_timeshare_flag_pcnt
          ,le.populated_land_lot_size_pcnt
          ,le.populated_hawaii_tct_pcnt
          ,le.populated_hawaii_condo_cpr_code_pcnt
          ,le.populated_hawaii_condo_name_pcnt
          ,le.populated_filler_except_hawaii_pcnt
          ,le.populated_rate_change_frequency_pcnt
          ,le.populated_change_index_pcnt
          ,le.populated_adjustable_rate_index_pcnt
          ,le.populated_adjustable_rate_rider_pcnt
          ,le.populated_graduated_payment_rider_pcnt
          ,le.populated_balloon_rider_pcnt
          ,le.populated_fixed_step_rate_rider_pcnt
          ,le.populated_condominium_rider_pcnt
          ,le.populated_planned_unit_development_rider_pcnt
          ,le.populated_rate_improvement_rider_pcnt
          ,le.populated_assumability_rider_pcnt
          ,le.populated_prepayment_rider_pcnt
          ,le.populated_one_four_family_rider_pcnt
          ,le.populated_biweekly_payment_rider_pcnt
          ,le.populated_second_home_rider_pcnt
          ,le.populated_data_source_code_pcnt
          ,le.populated_main_record_id_code_pcnt
          ,le.populated_addl_name_flag_pcnt
          ,le.populated_prop_addr_propagated_ind_pcnt
          ,le.populated_ln_ownership_rights_pcnt
          ,le.populated_ln_relationship_type_pcnt
          ,le.populated_ln_buyer_mailing_country_code_pcnt
          ,le.populated_ln_seller_mailing_country_code_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,118,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Property_deed));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),118,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Property_deed) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_LN_PropertyV2_Deed, Fields, 'RECORDOF(scrubsSummaryOverall)', 'fips_code');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, fips_code, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
