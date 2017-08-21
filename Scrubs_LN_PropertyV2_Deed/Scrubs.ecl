IMPORT ut,SALT33;
IMPORT Scrubs,Scrubs_LN_PropertyV2_Assessor; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Property_deed)
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
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT33.StrType)le.process_date);
    SELF.vendor_source_flag_Invalid := Fields.InValid_vendor_source_flag((SALT33.StrType)le.vendor_source_flag);
    SELF.from_file_Invalid := Fields.InValid_from_file((SALT33.StrType)le.from_file);
    SELF.fips_code_Invalid := Fields.InValid_fips_code((SALT33.StrType)le.fips_code);
    SELF.state_Invalid := Fields.InValid_state((SALT33.StrType)le.state);
    SELF.county_name_Invalid := Fields.InValid_county_name((SALT33.StrType)le.county_name);
    SELF.record_type_Invalid := Fields.InValid_record_type((SALT33.StrType)le.record_type,(SALT33.StrType)le.vendor_source_flag);
    SELF.apnt_or_pin_number_Invalid := Fields.InValid_apnt_or_pin_number((SALT33.StrType)le.apnt_or_pin_number);
    SELF.fares_unformatted_apn_Invalid := Fields.InValid_fares_unformatted_apn((SALT33.StrType)le.fares_unformatted_apn);
    SELF.buyer_or_borrower_ind_Invalid := Fields.InValid_buyer_or_borrower_ind((SALT33.StrType)le.buyer_or_borrower_ind);
    SELF.name1_Invalid := Fields.InValid_name1((SALT33.StrType)le.name1);
    SELF.name1_id_code_Invalid := Fields.InValid_name1_id_code((SALT33.StrType)le.name1_id_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.name2_Invalid := Fields.InValid_name2((SALT33.StrType)le.name2);
    SELF.name2_id_code_Invalid := Fields.InValid_name2_id_code((SALT33.StrType)le.name2_id_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.vesting_code_Invalid := Fields.InValid_vesting_code((SALT33.StrType)le.vesting_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.mailing_care_of_Invalid := Fields.InValid_mailing_care_of((SALT33.StrType)le.mailing_care_of);
    SELF.mailing_street_Invalid := Fields.InValid_mailing_street((SALT33.StrType)le.mailing_street);
    SELF.mailing_unit_number_Invalid := Fields.InValid_mailing_unit_number((SALT33.StrType)le.mailing_unit_number);
    SELF.mailing_csz_Invalid := Fields.InValid_mailing_csz((SALT33.StrType)le.mailing_csz);
    SELF.mailing_address_cd_Invalid := Fields.InValid_mailing_address_cd((SALT33.StrType)le.mailing_address_cd);
    SELF.seller1_Invalid := Fields.InValid_seller1((SALT33.StrType)le.seller1);
    SELF.seller1_id_code_Invalid := Fields.InValid_seller1_id_code((SALT33.StrType)le.seller1_id_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.seller2_Invalid := Fields.InValid_seller2((SALT33.StrType)le.seller2);
    SELF.seller2_id_code_Invalid := Fields.InValid_seller2_id_code((SALT33.StrType)le.seller2_id_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.seller_mailing_full_street_address_Invalid := Fields.InValid_seller_mailing_full_street_address((SALT33.StrType)le.seller_mailing_full_street_address);
    SELF.property_full_street_address_Invalid := Fields.InValid_property_full_street_address((SALT33.StrType)le.property_full_street_address);
    SELF.property_address_citystatezip_Invalid := Fields.InValid_property_address_citystatezip((SALT33.StrType)le.property_address_citystatezip);
    SELF.legal_lot_code_Invalid := Fields.InValid_legal_lot_code((SALT33.StrType)le.legal_lot_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.legal_phase_number_Invalid := Fields.InValid_legal_phase_number((SALT33.StrType)le.legal_phase_number);
    SELF.contract_date_Invalid := Fields.InValid_contract_date((SALT33.StrType)le.contract_date);
    SELF.recording_date_Invalid := Fields.InValid_recording_date((SALT33.StrType)le.recording_date);
    SELF.arm_reset_date_Invalid := Fields.InValid_arm_reset_date((SALT33.StrType)le.arm_reset_date);
    SELF.document_type_code_Invalid := Fields.InValid_document_type_code((SALT33.StrType)le.document_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.sales_price_Invalid := Fields.InValid_sales_price((SALT33.StrType)le.sales_price);
    SELF.sales_price_code_Invalid := Fields.InValid_sales_price_code((SALT33.StrType)le.sales_price_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.first_td_loan_amount_Invalid := Fields.InValid_first_td_loan_amount((SALT33.StrType)le.first_td_loan_amount);
    SELF.second_td_loan_amount_Invalid := Fields.InValid_second_td_loan_amount((SALT33.StrType)le.second_td_loan_amount);
    SELF.first_td_lender_type_code_Invalid := Fields.InValid_first_td_lender_type_code((SALT33.StrType)le.first_td_lender_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.second_td_lender_type_code_Invalid := Fields.InValid_second_td_lender_type_code((SALT33.StrType)le.second_td_lender_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.first_td_loan_type_code_Invalid := Fields.InValid_first_td_loan_type_code((SALT33.StrType)le.first_td_loan_type_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.type_financing_Invalid := Fields.InValid_type_financing((SALT33.StrType)le.type_financing,(SALT33.StrType)le.vendor_source_flag);
    SELF.first_td_due_date_Invalid := Fields.InValid_first_td_due_date((SALT33.StrType)le.first_td_due_date);
    SELF.lender_full_street_address_Invalid := Fields.InValid_lender_full_street_address((SALT33.StrType)le.lender_full_street_address);
    SELF.lender_address_citystatezip_Invalid := Fields.InValid_lender_address_citystatezip((SALT33.StrType)le.lender_address_citystatezip);
    SELF.property_use_code_Invalid := Fields.InValid_property_use_code((SALT33.StrType)le.property_use_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.condo_code_Invalid := Fields.InValid_condo_code((SALT33.StrType)le.condo_code,(SALT33.StrType)le.vendor_source_flag);
    SELF.rate_change_frequency_Invalid := Fields.InValid_rate_change_frequency((SALT33.StrType)le.rate_change_frequency,(SALT33.StrType)le.vendor_source_flag);
    SELF.adjustable_rate_index_Invalid := Fields.InValid_adjustable_rate_index((SALT33.StrType)le.adjustable_rate_index,(SALT33.StrType)le.vendor_source_flag);
    SELF.fixed_step_rate_rider_Invalid := Fields.InValid_fixed_step_rate_rider((SALT33.StrType)le.fixed_step_rate_rider,(SALT33.StrType)le.vendor_source_flag);
    SELF := le;
  END;
  EXPORT ExpandedInfile0 := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile0 := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Property_deed);
  EXPORT WithinList1 := DEDUP(SORT(TABLE(Scrubs_LN_PropertyV2_Assessor.file_fips,{fips_code}),fips_code),ALL) : PERSIST('~temp::Scrubs_LN_PropertyV2_Deed::Scrubs_LN_PropertyV2_Assessor.file_fips::fips_code',EXPIRE(Config.PersistExpire));
  EXPORT ExpandedInfile1 := JOIN(ExpandedInfile0, WithinList1, LEFT.fips_code=RIGHT.fips_code AND LEFT.fips_code_Invalid=0, TRANSFORM(Expanded_Layout, SELF.fips_code_Invalid:=MAP(RIGHT.fips_code<>''=>0,LEFT.fips_code_Invalid>0=>LEFT.fips_code_Invalid,3),SELF:=LEFT),LEFT OUTER, SMART);
  EXPORT ExpandedInfile := ExpandedInfile1;
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
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.fips_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=3);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    vendor_source_flag_ENUM_ErrorCount := COUNT(GROUP,h.vendor_source_flag_Invalid=1);
    from_file_ENUM_ErrorCount := COUNT(GROUP,h.from_file_Invalid=1);
    fips_code_ALLOW_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=1);
    fips_code_LENGTH_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=2);
    fips_code_WITHIN_FILE_ErrorCount := COUNT(GROUP,h.fips_code_Invalid=3);
    fips_code_Total_ErrorCount := COUNT(GROUP,h.fips_code_Invalid>0);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
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
    contract_date_LENGTH_ErrorCount := COUNT(GROUP,h.contract_date_Invalid=3);
    contract_date_Total_ErrorCount := COUNT(GROUP,h.contract_date_Invalid>0);
    recording_date_ALLOW_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=1);
    recording_date_CUSTOM_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=2);
    recording_date_LENGTH_ErrorCount := COUNT(GROUP,h.recording_date_Invalid=3);
    recording_date_Total_ErrorCount := COUNT(GROUP,h.recording_date_Invalid>0);
    arm_reset_date_ALLOW_ErrorCount := COUNT(GROUP,h.arm_reset_date_Invalid=1);
    arm_reset_date_CUSTOM_ErrorCount := COUNT(GROUP,h.arm_reset_date_Invalid=2);
    arm_reset_date_LENGTH_ErrorCount := COUNT(GROUP,h.arm_reset_date_Invalid=3);
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
    first_td_due_date_LENGTH_ErrorCount := COUNT(GROUP,h.first_td_due_date_Invalid=3);
    first_td_due_date_Total_ErrorCount := COUNT(GROUP,h.first_td_due_date_Invalid>0);
    lender_full_street_address_ALLOW_ErrorCount := COUNT(GROUP,h.lender_full_street_address_Invalid=1);
    lender_address_citystatezip_ALLOW_ErrorCount := COUNT(GROUP,h.lender_address_citystatezip_Invalid=1);
    property_use_code_CUSTOM_ErrorCount := COUNT(GROUP,h.property_use_code_Invalid=1);
    condo_code_CUSTOM_ErrorCount := COUNT(GROUP,h.condo_code_Invalid=1);
    rate_change_frequency_CUSTOM_ErrorCount := COUNT(GROUP,h.rate_change_frequency_Invalid=1);
    adjustable_rate_index_CUSTOM_ErrorCount := COUNT(GROUP,h.adjustable_rate_index_Invalid=1);
    fixed_step_rate_rider_CUSTOM_ErrorCount := COUNT(GROUP,h.fixed_step_rate_rider_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,fips_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.fips_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.vendor_source_flag_Invalid,le.from_file_Invalid,le.fips_code_Invalid,le.state_Invalid,le.county_name_Invalid,le.record_type_Invalid,le.apnt_or_pin_number_Invalid,le.fares_unformatted_apn_Invalid,le.buyer_or_borrower_ind_Invalid,le.name1_Invalid,le.name1_id_code_Invalid,le.name2_Invalid,le.name2_id_code_Invalid,le.vesting_code_Invalid,le.mailing_care_of_Invalid,le.mailing_street_Invalid,le.mailing_unit_number_Invalid,le.mailing_csz_Invalid,le.mailing_address_cd_Invalid,le.seller1_Invalid,le.seller1_id_code_Invalid,le.seller2_Invalid,le.seller2_id_code_Invalid,le.seller_mailing_full_street_address_Invalid,le.property_full_street_address_Invalid,le.property_address_citystatezip_Invalid,le.legal_lot_code_Invalid,le.legal_phase_number_Invalid,le.contract_date_Invalid,le.recording_date_Invalid,le.arm_reset_date_Invalid,le.document_type_code_Invalid,le.sales_price_Invalid,le.sales_price_code_Invalid,le.first_td_loan_amount_Invalid,le.second_td_loan_amount_Invalid,le.first_td_lender_type_code_Invalid,le.second_td_lender_type_code_Invalid,le.first_td_loan_type_code_Invalid,le.type_financing_Invalid,le.first_td_due_date_Invalid,le.lender_full_street_address_Invalid,le.lender_address_citystatezip_Invalid,le.property_use_code_Invalid,le.condo_code_Invalid,le.rate_change_frequency_Invalid,le.adjustable_rate_index_Invalid,le.fixed_step_rate_rider_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_vendor_source_flag(le.vendor_source_flag_Invalid),Fields.InvalidMessage_from_file(le.from_file_Invalid),Fields.InvalidMessage_fips_code(le.fips_code_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_county_name(le.county_name_Invalid),Fields.InvalidMessage_record_type(le.record_type_Invalid),Fields.InvalidMessage_apnt_or_pin_number(le.apnt_or_pin_number_Invalid),Fields.InvalidMessage_fares_unformatted_apn(le.fares_unformatted_apn_Invalid),Fields.InvalidMessage_buyer_or_borrower_ind(le.buyer_or_borrower_ind_Invalid),Fields.InvalidMessage_name1(le.name1_Invalid),Fields.InvalidMessage_name1_id_code(le.name1_id_code_Invalid),Fields.InvalidMessage_name2(le.name2_Invalid),Fields.InvalidMessage_name2_id_code(le.name2_id_code_Invalid),Fields.InvalidMessage_vesting_code(le.vesting_code_Invalid),Fields.InvalidMessage_mailing_care_of(le.mailing_care_of_Invalid),Fields.InvalidMessage_mailing_street(le.mailing_street_Invalid),Fields.InvalidMessage_mailing_unit_number(le.mailing_unit_number_Invalid),Fields.InvalidMessage_mailing_csz(le.mailing_csz_Invalid),Fields.InvalidMessage_mailing_address_cd(le.mailing_address_cd_Invalid),Fields.InvalidMessage_seller1(le.seller1_Invalid),Fields.InvalidMessage_seller1_id_code(le.seller1_id_code_Invalid),Fields.InvalidMessage_seller2(le.seller2_Invalid),Fields.InvalidMessage_seller2_id_code(le.seller2_id_code_Invalid),Fields.InvalidMessage_seller_mailing_full_street_address(le.seller_mailing_full_street_address_Invalid),Fields.InvalidMessage_property_full_street_address(le.property_full_street_address_Invalid),Fields.InvalidMessage_property_address_citystatezip(le.property_address_citystatezip_Invalid),Fields.InvalidMessage_legal_lot_code(le.legal_lot_code_Invalid),Fields.InvalidMessage_legal_phase_number(le.legal_phase_number_Invalid),Fields.InvalidMessage_contract_date(le.contract_date_Invalid),Fields.InvalidMessage_recording_date(le.recording_date_Invalid),Fields.InvalidMessage_arm_reset_date(le.arm_reset_date_Invalid),Fields.InvalidMessage_document_type_code(le.document_type_code_Invalid),Fields.InvalidMessage_sales_price(le.sales_price_Invalid),Fields.InvalidMessage_sales_price_code(le.sales_price_code_Invalid),Fields.InvalidMessage_first_td_loan_amount(le.first_td_loan_amount_Invalid),Fields.InvalidMessage_second_td_loan_amount(le.second_td_loan_amount_Invalid),Fields.InvalidMessage_first_td_lender_type_code(le.first_td_lender_type_code_Invalid),Fields.InvalidMessage_second_td_lender_type_code(le.second_td_lender_type_code_Invalid),Fields.InvalidMessage_first_td_loan_type_code(le.first_td_loan_type_code_Invalid),Fields.InvalidMessage_type_financing(le.type_financing_Invalid),Fields.InvalidMessage_first_td_due_date(le.first_td_due_date_Invalid),Fields.InvalidMessage_lender_full_street_address(le.lender_full_street_address_Invalid),Fields.InvalidMessage_lender_address_citystatezip(le.lender_address_citystatezip_Invalid),Fields.InvalidMessage_property_use_code(le.property_use_code_Invalid),Fields.InvalidMessage_condo_code(le.condo_code_Invalid),Fields.InvalidMessage_rate_change_frequency(le.rate_change_frequency_Invalid),Fields.InvalidMessage_adjustable_rate_index(le.adjustable_rate_index_Invalid),Fields.InvalidMessage_fixed_step_rate_rider(le.fixed_step_rate_rider_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.vendor_source_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.from_file_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fips_code_Invalid,'ALLOW','LENGTH','WITHIN_FILE','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','LENGTH','UNKNOWN')
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
          ,CHOOSE(le.contract_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.recording_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.arm_reset_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.document_type_code_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.sales_price_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sales_price_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_td_loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.second_td_loan_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.first_td_lender_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.second_td_lender_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_td_loan_type_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.type_financing_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_td_due_date_Invalid,'ALLOW','CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.lender_full_street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lender_address_citystatezip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.property_use_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.condo_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rate_change_frequency_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.adjustable_rate_index_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fixed_step_rate_rider_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','vendor_source_flag','from_file','fips_code','state','county_name','record_type','apnt_or_pin_number','fares_unformatted_apn','buyer_or_borrower_ind','name1','name1_id_code','name2','name2_id_code','vesting_code','mailing_care_of','mailing_street','mailing_unit_number','mailing_csz','mailing_address_cd','seller1','seller1_id_code','seller2','seller2_id_code','seller_mailing_full_street_address','property_full_street_address','property_address_citystatezip','legal_lot_code','legal_phase_number','contract_date','recording_date','arm_reset_date','document_type_code','sales_price','sales_price_code','first_td_loan_amount','second_td_loan_amount','first_td_lender_type_code','second_td_lender_type_code','first_td_loan_type_code','type_financing','first_td_due_date','lender_full_street_address','lender_address_citystatezip','property_use_code','condo_code','rate_change_frequency','adjustable_rate_index','fixed_step_rate_rider','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_vendor_source','invalid_from_file','invalid_fips','invalid_state_code','invalid_county_name','invalid_record_type','invalid_apn','invalid_apn','invalid_buyer_or_borrower_ind','invalid_alpha','invalid_name1_id_code','invalid_alpha','invalid_name1_id_code','invalid_vesting_code','invalid_alpha','invalid_address','invalid_address','invalid_zcs','invalid_address','invalid_alpha','invalid_seller1_id_code','invalid_alpha','invalid_seller2_id_code','invalid_address','invalid_address','invalid_address','invalid_legal_lot_code','invalid_char','invalid_date','invalid_date','invalid_date_future','invalid_document_type_code','invalid_amount','invalid_sales_price_code','invalid_amount','invalid_amount','invalid_lender_type_code','invalid_lender_type_code','invalid_loan_type_code','invalid_type_financing','invalid_date_future','invalid_address','invalid_address','invalid_property_use_code','invalid_condo_code','invalid_rate_change_frequency','invalid_adjustable_rate_index','invalid_fixed_step_rate_ride','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.process_date,(SALT33.StrType)le.vendor_source_flag,(SALT33.StrType)le.from_file,(SALT33.StrType)le.fips_code,(SALT33.StrType)le.state,(SALT33.StrType)le.county_name,(SALT33.StrType)le.record_type,(SALT33.StrType)le.apnt_or_pin_number,(SALT33.StrType)le.fares_unformatted_apn,(SALT33.StrType)le.buyer_or_borrower_ind,(SALT33.StrType)le.name1,(SALT33.StrType)le.name1_id_code,(SALT33.StrType)le.name2,(SALT33.StrType)le.name2_id_code,(SALT33.StrType)le.vesting_code,(SALT33.StrType)le.mailing_care_of,(SALT33.StrType)le.mailing_street,(SALT33.StrType)le.mailing_unit_number,(SALT33.StrType)le.mailing_csz,(SALT33.StrType)le.mailing_address_cd,(SALT33.StrType)le.seller1,(SALT33.StrType)le.seller1_id_code,(SALT33.StrType)le.seller2,(SALT33.StrType)le.seller2_id_code,(SALT33.StrType)le.seller_mailing_full_street_address,(SALT33.StrType)le.property_full_street_address,(SALT33.StrType)le.property_address_citystatezip,(SALT33.StrType)le.legal_lot_code,(SALT33.StrType)le.legal_phase_number,(SALT33.StrType)le.contract_date,(SALT33.StrType)le.recording_date,(SALT33.StrType)le.arm_reset_date,(SALT33.StrType)le.document_type_code,(SALT33.StrType)le.sales_price,(SALT33.StrType)le.sales_price_code,(SALT33.StrType)le.first_td_loan_amount,(SALT33.StrType)le.second_td_loan_amount,(SALT33.StrType)le.first_td_lender_type_code,(SALT33.StrType)le.second_td_lender_type_code,(SALT33.StrType)le.first_td_loan_type_code,(SALT33.StrType)le.type_financing,(SALT33.StrType)le.first_td_due_date,(SALT33.StrType)le.lender_full_street_address,(SALT33.StrType)le.lender_address_citystatezip,(SALT33.StrType)le.property_use_code,(SALT33.StrType)le.condo_code,(SALT33.StrType)le.rate_change_frequency,(SALT33.StrType)le.adjustable_rate_index,(SALT33.StrType)le.fixed_step_rate_rider,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,49,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.fips_code;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:CUSTOM','process_date:invalid_date:LENGTH'
          ,'vendor_source_flag:invalid_vendor_source:ENUM'
          ,'from_file:invalid_from_file:ENUM'
          ,'fips_code:invalid_fips:ALLOW','fips_code:invalid_fips:LENGTH','fips_code:invalid_fips:WITHIN_FILE'
          ,'state:invalid_state_code:LEFTTRIM','state:invalid_state_code:ALLOW','state:invalid_state_code:LENGTH'
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
          ,'contract_date:invalid_date:ALLOW','contract_date:invalid_date:CUSTOM','contract_date:invalid_date:LENGTH'
          ,'recording_date:invalid_date:ALLOW','recording_date:invalid_date:CUSTOM','recording_date:invalid_date:LENGTH'
          ,'arm_reset_date:invalid_date_future:ALLOW','arm_reset_date:invalid_date_future:CUSTOM','arm_reset_date:invalid_date_future:LENGTH'
          ,'document_type_code:invalid_document_type_code:ALLOW','document_type_code:invalid_document_type_code:CUSTOM'
          ,'sales_price:invalid_amount:ALLOW'
          ,'sales_price_code:invalid_sales_price_code:CUSTOM'
          ,'first_td_loan_amount:invalid_amount:ALLOW'
          ,'second_td_loan_amount:invalid_amount:ALLOW'
          ,'first_td_lender_type_code:invalid_lender_type_code:CUSTOM'
          ,'second_td_lender_type_code:invalid_lender_type_code:CUSTOM'
          ,'first_td_loan_type_code:invalid_loan_type_code:CUSTOM'
          ,'type_financing:invalid_type_financing:CUSTOM'
          ,'first_td_due_date:invalid_date_future:ALLOW','first_td_due_date:invalid_date_future:CUSTOM','first_td_due_date:invalid_date_future:LENGTH'
          ,'lender_full_street_address:invalid_address:ALLOW'
          ,'lender_address_citystatezip:invalid_address:ALLOW'
          ,'property_use_code:invalid_property_use_code:CUSTOM'
          ,'condo_code:invalid_condo_code:CUSTOM'
          ,'rate_change_frequency:invalid_rate_change_frequency:CUSTOM'
          ,'adjustable_rate_index:invalid_adjustable_rate_index:CUSTOM'
          ,'fixed_step_rate_rider:invalid_fixed_step_rate_ride:CUSTOM','UNKNOWN');
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
          ,Fields.InvalidMessage_fixed_step_rate_rider(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.vendor_source_flag_ENUM_ErrorCount
          ,le.from_file_ENUM_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTH_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
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
          ,le.contract_date_ALLOW_ErrorCount,le.contract_date_CUSTOM_ErrorCount,le.contract_date_LENGTH_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_CUSTOM_ErrorCount,le.recording_date_LENGTH_ErrorCount
          ,le.arm_reset_date_ALLOW_ErrorCount,le.arm_reset_date_CUSTOM_ErrorCount,le.arm_reset_date_LENGTH_ErrorCount
          ,le.document_type_code_ALLOW_ErrorCount,le.document_type_code_CUSTOM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_CUSTOM_ErrorCount
          ,le.first_td_loan_amount_ALLOW_ErrorCount
          ,le.second_td_loan_amount_ALLOW_ErrorCount
          ,le.first_td_lender_type_code_CUSTOM_ErrorCount
          ,le.second_td_lender_type_code_CUSTOM_ErrorCount
          ,le.first_td_loan_type_code_CUSTOM_ErrorCount
          ,le.type_financing_CUSTOM_ErrorCount
          ,le.first_td_due_date_ALLOW_ErrorCount,le.first_td_due_date_CUSTOM_ErrorCount,le.first_td_due_date_LENGTH_ErrorCount
          ,le.lender_full_street_address_ALLOW_ErrorCount
          ,le.lender_address_citystatezip_ALLOW_ErrorCount
          ,le.property_use_code_CUSTOM_ErrorCount
          ,le.condo_code_CUSTOM_ErrorCount
          ,le.rate_change_frequency_CUSTOM_ErrorCount
          ,le.adjustable_rate_index_CUSTOM_ErrorCount
          ,le.fixed_step_rate_rider_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_ALLOW_ErrorCount,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.vendor_source_flag_ENUM_ErrorCount
          ,le.from_file_ENUM_ErrorCount
          ,le.fips_code_ALLOW_ErrorCount,le.fips_code_LENGTH_ErrorCount,le.fips_code_WITHIN_FILE_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
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
          ,le.contract_date_ALLOW_ErrorCount,le.contract_date_CUSTOM_ErrorCount,le.contract_date_LENGTH_ErrorCount
          ,le.recording_date_ALLOW_ErrorCount,le.recording_date_CUSTOM_ErrorCount,le.recording_date_LENGTH_ErrorCount
          ,le.arm_reset_date_ALLOW_ErrorCount,le.arm_reset_date_CUSTOM_ErrorCount,le.arm_reset_date_LENGTH_ErrorCount
          ,le.document_type_code_ALLOW_ErrorCount,le.document_type_code_CUSTOM_ErrorCount
          ,le.sales_price_ALLOW_ErrorCount
          ,le.sales_price_code_CUSTOM_ErrorCount
          ,le.first_td_loan_amount_ALLOW_ErrorCount
          ,le.second_td_loan_amount_ALLOW_ErrorCount
          ,le.first_td_lender_type_code_CUSTOM_ErrorCount
          ,le.second_td_lender_type_code_CUSTOM_ErrorCount
          ,le.first_td_loan_type_code_CUSTOM_ErrorCount
          ,le.type_financing_CUSTOM_ErrorCount
          ,le.first_td_due_date_ALLOW_ErrorCount,le.first_td_due_date_CUSTOM_ErrorCount,le.first_td_due_date_LENGTH_ErrorCount
          ,le.lender_full_street_address_ALLOW_ErrorCount
          ,le.lender_address_citystatezip_ALLOW_ErrorCount
          ,le.property_use_code_CUSTOM_ErrorCount
          ,le.condo_code_CUSTOM_ErrorCount
          ,le.rate_change_frequency_CUSTOM_ErrorCount
          ,le.adjustable_rate_index_CUSTOM_ErrorCount
          ,le.fixed_step_rate_rider_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,65,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
