IMPORT SALT37;
IMPORT Scrubs,Scrubs_UCCV2; // Import modules for FieldTypes attribute definitions
EXPORT CA_Main_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(CA_Main_Layout_UCCV2)
    UNSIGNED1 tmsid_Invalid;
    UNSIGNED1 rmsid_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 filing_jurisdiction_Invalid;
    UNSIGNED1 orig_filing_number_Invalid;
    UNSIGNED1 orig_filing_type_Invalid;
    UNSIGNED1 orig_filing_date_Invalid;
    UNSIGNED1 orig_filing_time_Invalid;
    UNSIGNED1 filing_number_Invalid;
    UNSIGNED1 filing_type_Invalid;
    UNSIGNED1 filing_date_Invalid;
    UNSIGNED1 filing_time_Invalid;
    UNSIGNED1 filing_status_Invalid;
    UNSIGNED1 status_type_Invalid;
    UNSIGNED1 page_Invalid;
    UNSIGNED1 expiration_date_Invalid;
    UNSIGNED1 contract_type_Invalid;
    UNSIGNED1 vendor_entry_date_Invalid;
    UNSIGNED1 vendor_upd_date_Invalid;
    UNSIGNED1 statements_filed_Invalid;
    UNSIGNED1 continuious_expiration_Invalid;
    UNSIGNED1 microfilm_number_Invalid;
    UNSIGNED1 amount_Invalid;
    UNSIGNED1 effective_date_Invalid;
    UNSIGNED1 signer_name_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 filing_agency_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 prim_machine_Invalid;
    UNSIGNED1 manufacturer_code_Invalid;
    UNSIGNED1 manufacturer_name_Invalid;
    UNSIGNED1 model_Invalid;
    UNSIGNED1 model_year_Invalid;
    UNSIGNED1 model_desc_Invalid;
    UNSIGNED1 collateral_count_Invalid;
    UNSIGNED1 new_used_Invalid;
    UNSIGNED1 serial_number_Invalid;
    UNSIGNED1 property_desc_Invalid;
    UNSIGNED1 borough_Invalid;
    UNSIGNED1 block_Invalid;
    UNSIGNED1 collateral_address_Invalid;
    UNSIGNED1 air_rights_indc_Invalid;
    UNSIGNED1 subterranean_rights_indc_Invalid;
    UNSIGNED1 easment_indc_Invalid;
    UNSIGNED1 persistent_record_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(CA_Main_Layout_UCCV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(CA_Main_Layout_UCCV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.tmsid_Invalid := CA_Main_Fields.InValid_tmsid((SALT37.StrType)le.tmsid);
    SELF.rmsid_Invalid := CA_Main_Fields.InValid_rmsid((SALT37.StrType)le.rmsid);
    SELF.process_date_Invalid := CA_Main_Fields.InValid_process_date((SALT37.StrType)le.process_date);
    SELF.filing_jurisdiction_Invalid := CA_Main_Fields.InValid_filing_jurisdiction((SALT37.StrType)le.filing_jurisdiction);
    SELF.orig_filing_number_Invalid := CA_Main_Fields.InValid_orig_filing_number((SALT37.StrType)le.orig_filing_number);
    SELF.orig_filing_type_Invalid := CA_Main_Fields.InValid_orig_filing_type((SALT37.StrType)le.orig_filing_type);
    SELF.orig_filing_date_Invalid := CA_Main_Fields.InValid_orig_filing_date((SALT37.StrType)le.orig_filing_date);
    SELF.orig_filing_time_Invalid := CA_Main_Fields.InValid_orig_filing_time((SALT37.StrType)le.orig_filing_time);
    SELF.filing_number_Invalid := CA_Main_Fields.InValid_filing_number((SALT37.StrType)le.filing_number);
    SELF.filing_type_Invalid := CA_Main_Fields.InValid_filing_type((SALT37.StrType)le.filing_type);
    SELF.filing_date_Invalid := CA_Main_Fields.InValid_filing_date((SALT37.StrType)le.filing_date);
    SELF.filing_time_Invalid := CA_Main_Fields.InValid_filing_time((SALT37.StrType)le.filing_time);
    SELF.filing_status_Invalid := CA_Main_Fields.InValid_filing_status((SALT37.StrType)le.filing_status);
    SELF.status_type_Invalid := CA_Main_Fields.InValid_status_type((SALT37.StrType)le.status_type);
    SELF.page_Invalid := CA_Main_Fields.InValid_page((SALT37.StrType)le.page);
    SELF.expiration_date_Invalid := CA_Main_Fields.InValid_expiration_date((SALT37.StrType)le.expiration_date);
    SELF.contract_type_Invalid := CA_Main_Fields.InValid_contract_type((SALT37.StrType)le.contract_type);
    SELF.vendor_entry_date_Invalid := CA_Main_Fields.InValid_vendor_entry_date((SALT37.StrType)le.vendor_entry_date);
    SELF.vendor_upd_date_Invalid := CA_Main_Fields.InValid_vendor_upd_date((SALT37.StrType)le.vendor_upd_date);
    SELF.statements_filed_Invalid := CA_Main_Fields.InValid_statements_filed((SALT37.StrType)le.statements_filed);
    SELF.continuious_expiration_Invalid := CA_Main_Fields.InValid_continuious_expiration((SALT37.StrType)le.continuious_expiration);
    SELF.microfilm_number_Invalid := CA_Main_Fields.InValid_microfilm_number((SALT37.StrType)le.microfilm_number);
    SELF.amount_Invalid := CA_Main_Fields.InValid_amount((SALT37.StrType)le.amount);
    SELF.effective_date_Invalid := CA_Main_Fields.InValid_effective_date((SALT37.StrType)le.effective_date);
    SELF.signer_name_Invalid := CA_Main_Fields.InValid_signer_name((SALT37.StrType)le.signer_name);
    SELF.title_Invalid := CA_Main_Fields.InValid_title((SALT37.StrType)le.title);
    SELF.filing_agency_Invalid := CA_Main_Fields.InValid_filing_agency((SALT37.StrType)le.filing_agency);
    SELF.address_Invalid := CA_Main_Fields.InValid_address((SALT37.StrType)le.address);
    SELF.city_Invalid := CA_Main_Fields.InValid_city((SALT37.StrType)le.city);
    SELF.state_Invalid := CA_Main_Fields.InValid_state((SALT37.StrType)le.state);
    SELF.county_Invalid := CA_Main_Fields.InValid_county((SALT37.StrType)le.county);
    SELF.zip_Invalid := CA_Main_Fields.InValid_zip((SALT37.StrType)le.zip);
    SELF.prim_machine_Invalid := CA_Main_Fields.InValid_prim_machine((SALT37.StrType)le.prim_machine);
    SELF.manufacturer_code_Invalid := CA_Main_Fields.InValid_manufacturer_code((SALT37.StrType)le.manufacturer_code);
    SELF.manufacturer_name_Invalid := CA_Main_Fields.InValid_manufacturer_name((SALT37.StrType)le.manufacturer_name);
    SELF.model_Invalid := CA_Main_Fields.InValid_model((SALT37.StrType)le.model);
    SELF.model_year_Invalid := CA_Main_Fields.InValid_model_year((SALT37.StrType)le.model_year);
    SELF.model_desc_Invalid := CA_Main_Fields.InValid_model_desc((SALT37.StrType)le.model_desc);
    SELF.collateral_count_Invalid := CA_Main_Fields.InValid_collateral_count((SALT37.StrType)le.collateral_count);
    SELF.new_used_Invalid := CA_Main_Fields.InValid_new_used((SALT37.StrType)le.new_used);
    SELF.serial_number_Invalid := CA_Main_Fields.InValid_serial_number((SALT37.StrType)le.serial_number);
    SELF.property_desc_Invalid := CA_Main_Fields.InValid_property_desc((SALT37.StrType)le.property_desc);
    SELF.borough_Invalid := CA_Main_Fields.InValid_borough((SALT37.StrType)le.borough);
    SELF.block_Invalid := CA_Main_Fields.InValid_block((SALT37.StrType)le.block);
    SELF.collateral_address_Invalid := CA_Main_Fields.InValid_collateral_address((SALT37.StrType)le.collateral_address);
    SELF.air_rights_indc_Invalid := CA_Main_Fields.InValid_air_rights_indc((SALT37.StrType)le.air_rights_indc);
    SELF.subterranean_rights_indc_Invalid := CA_Main_Fields.InValid_subterranean_rights_indc((SALT37.StrType)le.subterranean_rights_indc);
    SELF.easment_indc_Invalid := CA_Main_Fields.InValid_easment_indc((SALT37.StrType)le.easment_indc);
    SELF.persistent_record_id_Invalid := CA_Main_Fields.InValid_persistent_record_id((SALT37.StrType)le.persistent_record_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),CA_Main_Layout_UCCV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.tmsid_Invalid << 0 ) + ( le.rmsid_Invalid << 1 ) + ( le.process_date_Invalid << 2 ) + ( le.filing_jurisdiction_Invalid << 4 ) + ( le.orig_filing_number_Invalid << 5 ) + ( le.orig_filing_type_Invalid << 6 ) + ( le.orig_filing_date_Invalid << 7 ) + ( le.orig_filing_time_Invalid << 8 ) + ( le.filing_number_Invalid << 9 ) + ( le.filing_type_Invalid << 10 ) + ( le.filing_date_Invalid << 11 ) + ( le.filing_time_Invalid << 12 ) + ( le.filing_status_Invalid << 13 ) + ( le.status_type_Invalid << 14 ) + ( le.page_Invalid << 15 ) + ( le.expiration_date_Invalid << 16 ) + ( le.contract_type_Invalid << 17 ) + ( le.vendor_entry_date_Invalid << 18 ) + ( le.vendor_upd_date_Invalid << 19 ) + ( le.statements_filed_Invalid << 20 ) + ( le.continuious_expiration_Invalid << 21 ) + ( le.microfilm_number_Invalid << 22 ) + ( le.amount_Invalid << 24 ) + ( le.effective_date_Invalid << 25 ) + ( le.signer_name_Invalid << 26 ) + ( le.title_Invalid << 28 ) + ( le.filing_agency_Invalid << 29 ) + ( le.address_Invalid << 30 ) + ( le.city_Invalid << 31 ) + ( le.state_Invalid << 32 ) + ( le.county_Invalid << 33 ) + ( le.zip_Invalid << 34 ) + ( le.prim_machine_Invalid << 35 ) + ( le.manufacturer_code_Invalid << 36 ) + ( le.manufacturer_name_Invalid << 37 ) + ( le.model_Invalid << 38 ) + ( le.model_year_Invalid << 39 ) + ( le.model_desc_Invalid << 40 ) + ( le.collateral_count_Invalid << 41 ) + ( le.new_used_Invalid << 42 ) + ( le.serial_number_Invalid << 43 ) + ( le.property_desc_Invalid << 44 ) + ( le.borough_Invalid << 45 ) + ( le.block_Invalid << 46 ) + ( le.collateral_address_Invalid << 47 ) + ( le.air_rights_indc_Invalid << 48 ) + ( le.subterranean_rights_indc_Invalid << 49 ) + ( le.easment_indc_Invalid << 50 ) + ( le.persistent_record_id_Invalid << 51 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,CA_Main_Layout_UCCV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.tmsid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.rmsid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.filing_jurisdiction_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_filing_number_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_filing_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.orig_filing_date_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orig_filing_time_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.filing_number_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.filing_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.filing_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.filing_time_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.filing_status_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.status_type_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.page_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.expiration_date_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.contract_type_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.vendor_entry_date_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.vendor_upd_date_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.statements_filed_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.continuious_expiration_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.microfilm_number_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.amount_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.effective_date_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.signer_name_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.title_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.filing_agency_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.prim_machine_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.manufacturer_code_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.manufacturer_name_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.model_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.model_year_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.model_desc_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.collateral_count_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.new_used_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.serial_number_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.property_desc_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.borough_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.block_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.collateral_address_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.air_rights_indc_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.subterranean_rights_indc_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.easment_indc_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    tmsid_CUSTOM_ErrorCount := COUNT(GROUP,h.tmsid_Invalid=1);
    rmsid_CUSTOM_ErrorCount := COUNT(GROUP,h.rmsid_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    filing_jurisdiction_ENUM_ErrorCount := COUNT(GROUP,h.filing_jurisdiction_Invalid=1);
    orig_filing_number_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_number_Invalid=1);
    orig_filing_type_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_type_Invalid=1);
    orig_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid=1);
    orig_filing_time_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_time_Invalid=1);
    filing_number_LENGTH_ErrorCount := COUNT(GROUP,h.filing_number_Invalid=1);
    filing_type_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_type_Invalid=1);
    filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=1);
    filing_time_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_time_Invalid=1);
    filing_status_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_status_Invalid=1);
    status_type_CUSTOM_ErrorCount := COUNT(GROUP,h.status_type_Invalid=1);
    page_ALLOW_ErrorCount := COUNT(GROUP,h.page_Invalid=1);
    expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=1);
    contract_type_LENGTH_ErrorCount := COUNT(GROUP,h.contract_type_Invalid=1);
    vendor_entry_date_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid=1);
    vendor_upd_date_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_upd_date_Invalid=1);
    statements_filed_LENGTH_ErrorCount := COUNT(GROUP,h.statements_filed_Invalid=1);
    continuious_expiration_LENGTH_ErrorCount := COUNT(GROUP,h.continuious_expiration_Invalid=1);
    microfilm_number_ALLOW_ErrorCount := COUNT(GROUP,h.microfilm_number_Invalid=1);
    microfilm_number_LENGTH_ErrorCount := COUNT(GROUP,h.microfilm_number_Invalid=2);
    microfilm_number_Total_ErrorCount := COUNT(GROUP,h.microfilm_number_Invalid>0);
    amount_LENGTH_ErrorCount := COUNT(GROUP,h.amount_Invalid=1);
    effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=1);
    signer_name_ALLOW_ErrorCount := COUNT(GROUP,h.signer_name_Invalid=1);
    signer_name_LENGTH_ErrorCount := COUNT(GROUP,h.signer_name_Invalid=2);
    signer_name_Total_ErrorCount := COUNT(GROUP,h.signer_name_Invalid>0);
    title_LENGTH_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    filing_agency_LENGTH_ErrorCount := COUNT(GROUP,h.filing_agency_Invalid=1);
    address_LENGTH_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    city_LENGTH_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    county_LENGTH_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    prim_machine_LENGTH_ErrorCount := COUNT(GROUP,h.prim_machine_Invalid=1);
    manufacturer_code_LENGTH_ErrorCount := COUNT(GROUP,h.manufacturer_code_Invalid=1);
    manufacturer_name_LENGTH_ErrorCount := COUNT(GROUP,h.manufacturer_name_Invalid=1);
    model_LENGTH_ErrorCount := COUNT(GROUP,h.model_Invalid=1);
    model_year_LENGTH_ErrorCount := COUNT(GROUP,h.model_year_Invalid=1);
    model_desc_LENGTH_ErrorCount := COUNT(GROUP,h.model_desc_Invalid=1);
    collateral_count_LENGTH_ErrorCount := COUNT(GROUP,h.collateral_count_Invalid=1);
    new_used_LENGTH_ErrorCount := COUNT(GROUP,h.new_used_Invalid=1);
    serial_number_LENGTH_ErrorCount := COUNT(GROUP,h.serial_number_Invalid=1);
    property_desc_LENGTH_ErrorCount := COUNT(GROUP,h.property_desc_Invalid=1);
    borough_LENGTH_ErrorCount := COUNT(GROUP,h.borough_Invalid=1);
    block_LENGTH_ErrorCount := COUNT(GROUP,h.block_Invalid=1);
    collateral_address_LENGTH_ErrorCount := COUNT(GROUP,h.collateral_address_Invalid=1);
    air_rights_indc_LENGTH_ErrorCount := COUNT(GROUP,h.air_rights_indc_Invalid=1);
    subterranean_rights_indc_LENGTH_ErrorCount := COUNT(GROUP,h.subterranean_rights_indc_Invalid=1);
    easment_indc_LENGTH_ErrorCount := COUNT(GROUP,h.easment_indc_Invalid=1);
    persistent_record_id_LENGTH_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT37.StrType ErrorMessage;
    SALT37.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.tmsid_Invalid,le.rmsid_Invalid,le.process_date_Invalid,le.filing_jurisdiction_Invalid,le.orig_filing_number_Invalid,le.orig_filing_type_Invalid,le.orig_filing_date_Invalid,le.orig_filing_time_Invalid,le.filing_number_Invalid,le.filing_type_Invalid,le.filing_date_Invalid,le.filing_time_Invalid,le.filing_status_Invalid,le.status_type_Invalid,le.page_Invalid,le.expiration_date_Invalid,le.contract_type_Invalid,le.vendor_entry_date_Invalid,le.vendor_upd_date_Invalid,le.statements_filed_Invalid,le.continuious_expiration_Invalid,le.microfilm_number_Invalid,le.amount_Invalid,le.effective_date_Invalid,le.signer_name_Invalid,le.title_Invalid,le.filing_agency_Invalid,le.address_Invalid,le.city_Invalid,le.state_Invalid,le.county_Invalid,le.zip_Invalid,le.prim_machine_Invalid,le.manufacturer_code_Invalid,le.manufacturer_name_Invalid,le.model_Invalid,le.model_year_Invalid,le.model_desc_Invalid,le.collateral_count_Invalid,le.new_used_Invalid,le.serial_number_Invalid,le.property_desc_Invalid,le.borough_Invalid,le.block_Invalid,le.collateral_address_Invalid,le.air_rights_indc_Invalid,le.subterranean_rights_indc_Invalid,le.easment_indc_Invalid,le.persistent_record_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,CA_Main_Fields.InvalidMessage_tmsid(le.tmsid_Invalid),CA_Main_Fields.InvalidMessage_rmsid(le.rmsid_Invalid),CA_Main_Fields.InvalidMessage_process_date(le.process_date_Invalid),CA_Main_Fields.InvalidMessage_filing_jurisdiction(le.filing_jurisdiction_Invalid),CA_Main_Fields.InvalidMessage_orig_filing_number(le.orig_filing_number_Invalid),CA_Main_Fields.InvalidMessage_orig_filing_type(le.orig_filing_type_Invalid),CA_Main_Fields.InvalidMessage_orig_filing_date(le.orig_filing_date_Invalid),CA_Main_Fields.InvalidMessage_orig_filing_time(le.orig_filing_time_Invalid),CA_Main_Fields.InvalidMessage_filing_number(le.filing_number_Invalid),CA_Main_Fields.InvalidMessage_filing_type(le.filing_type_Invalid),CA_Main_Fields.InvalidMessage_filing_date(le.filing_date_Invalid),CA_Main_Fields.InvalidMessage_filing_time(le.filing_time_Invalid),CA_Main_Fields.InvalidMessage_filing_status(le.filing_status_Invalid),CA_Main_Fields.InvalidMessage_status_type(le.status_type_Invalid),CA_Main_Fields.InvalidMessage_page(le.page_Invalid),CA_Main_Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),CA_Main_Fields.InvalidMessage_contract_type(le.contract_type_Invalid),CA_Main_Fields.InvalidMessage_vendor_entry_date(le.vendor_entry_date_Invalid),CA_Main_Fields.InvalidMessage_vendor_upd_date(le.vendor_upd_date_Invalid),CA_Main_Fields.InvalidMessage_statements_filed(le.statements_filed_Invalid),CA_Main_Fields.InvalidMessage_continuious_expiration(le.continuious_expiration_Invalid),CA_Main_Fields.InvalidMessage_microfilm_number(le.microfilm_number_Invalid),CA_Main_Fields.InvalidMessage_amount(le.amount_Invalid),CA_Main_Fields.InvalidMessage_effective_date(le.effective_date_Invalid),CA_Main_Fields.InvalidMessage_signer_name(le.signer_name_Invalid),CA_Main_Fields.InvalidMessage_title(le.title_Invalid),CA_Main_Fields.InvalidMessage_filing_agency(le.filing_agency_Invalid),CA_Main_Fields.InvalidMessage_address(le.address_Invalid),CA_Main_Fields.InvalidMessage_city(le.city_Invalid),CA_Main_Fields.InvalidMessage_state(le.state_Invalid),CA_Main_Fields.InvalidMessage_county(le.county_Invalid),CA_Main_Fields.InvalidMessage_zip(le.zip_Invalid),CA_Main_Fields.InvalidMessage_prim_machine(le.prim_machine_Invalid),CA_Main_Fields.InvalidMessage_manufacturer_code(le.manufacturer_code_Invalid),CA_Main_Fields.InvalidMessage_manufacturer_name(le.manufacturer_name_Invalid),CA_Main_Fields.InvalidMessage_model(le.model_Invalid),CA_Main_Fields.InvalidMessage_model_year(le.model_year_Invalid),CA_Main_Fields.InvalidMessage_model_desc(le.model_desc_Invalid),CA_Main_Fields.InvalidMessage_collateral_count(le.collateral_count_Invalid),CA_Main_Fields.InvalidMessage_new_used(le.new_used_Invalid),CA_Main_Fields.InvalidMessage_serial_number(le.serial_number_Invalid),CA_Main_Fields.InvalidMessage_property_desc(le.property_desc_Invalid),CA_Main_Fields.InvalidMessage_borough(le.borough_Invalid),CA_Main_Fields.InvalidMessage_block(le.block_Invalid),CA_Main_Fields.InvalidMessage_collateral_address(le.collateral_address_Invalid),CA_Main_Fields.InvalidMessage_air_rights_indc(le.air_rights_indc_Invalid),CA_Main_Fields.InvalidMessage_subterranean_rights_indc(le.subterranean_rights_indc_Invalid),CA_Main_Fields.InvalidMessage_easment_indc(le.easment_indc_Invalid),CA_Main_Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.tmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_jurisdiction_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_filing_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_time_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_time_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_status_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.status_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.page_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expiration_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contract_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.vendor_entry_date_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.vendor_upd_date_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.statements_filed_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.continuious_expiration_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.microfilm_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.amount_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.effective_date_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.signer_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_agency_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.prim_machine_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.manufacturer_code_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.manufacturer_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.model_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.model_year_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.model_desc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.collateral_count_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.new_used_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.serial_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.property_desc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.borough_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.block_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.collateral_address_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.air_rights_indc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.subterranean_rights_indc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.easment_indc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'tmsid','rmsid','process_date','filing_jurisdiction','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','filing_number','filing_type','filing_date','filing_time','filing_status','status_type','page','expiration_date','contract_type','vendor_entry_date','vendor_upd_date','statements_filed','continuious_expiration','microfilm_number','amount','effective_date','signer_name','title','filing_agency','address','city','state','county','zip','prim_machine','manufacturer_code','manufacturer_name','model','model_year','model_desc','collateral_count','new_used','serial_number','property_desc','borough','block','collateral_address','air_rights_indc','subterranean_rights_indc','easment_indc','persistent_record_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_tmsid','invalid_rmsid','invalid_8pastdate','invalid_filing_jurisdiction','invalid_orig_filing_number','invalid_orig_filing_type','invalid_orig_filing_date','invalid_orig_filing_time','invalid_mandatory','invalid_filing_type','invalid_filing_date','invalid_filing_time','invalid_filing_status','invalid_status_type','invalid_numeric_blank','invalid_expiration_date','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_microfilm_number','invalid_empty','invalid_empty','invalid_wordbag','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.tmsid,(SALT37.StrType)le.rmsid,(SALT37.StrType)le.process_date,(SALT37.StrType)le.filing_jurisdiction,(SALT37.StrType)le.orig_filing_number,(SALT37.StrType)le.orig_filing_type,(SALT37.StrType)le.orig_filing_date,(SALT37.StrType)le.orig_filing_time,(SALT37.StrType)le.filing_number,(SALT37.StrType)le.filing_type,(SALT37.StrType)le.filing_date,(SALT37.StrType)le.filing_time,(SALT37.StrType)le.filing_status,(SALT37.StrType)le.status_type,(SALT37.StrType)le.page,(SALT37.StrType)le.expiration_date,(SALT37.StrType)le.contract_type,(SALT37.StrType)le.vendor_entry_date,(SALT37.StrType)le.vendor_upd_date,(SALT37.StrType)le.statements_filed,(SALT37.StrType)le.continuious_expiration,(SALT37.StrType)le.microfilm_number,(SALT37.StrType)le.amount,(SALT37.StrType)le.effective_date,(SALT37.StrType)le.signer_name,(SALT37.StrType)le.title,(SALT37.StrType)le.filing_agency,(SALT37.StrType)le.address,(SALT37.StrType)le.city,(SALT37.StrType)le.state,(SALT37.StrType)le.county,(SALT37.StrType)le.zip,(SALT37.StrType)le.prim_machine,(SALT37.StrType)le.manufacturer_code,(SALT37.StrType)le.manufacturer_name,(SALT37.StrType)le.model,(SALT37.StrType)le.model_year,(SALT37.StrType)le.model_desc,(SALT37.StrType)le.collateral_count,(SALT37.StrType)le.new_used,(SALT37.StrType)le.serial_number,(SALT37.StrType)le.property_desc,(SALT37.StrType)le.borough,(SALT37.StrType)le.block,(SALT37.StrType)le.collateral_address,(SALT37.StrType)le.air_rights_indc,(SALT37.StrType)le.subterranean_rights_indc,(SALT37.StrType)le.easment_indc,(SALT37.StrType)le.persistent_record_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,49,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT37.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'tmsid:invalid_tmsid:CUSTOM'
          ,'rmsid:invalid_rmsid:CUSTOM'
          ,'process_date:invalid_8pastdate:CUSTOM','process_date:invalid_8pastdate:LENGTH'
          ,'filing_jurisdiction:invalid_filing_jurisdiction:ENUM'
          ,'orig_filing_number:invalid_orig_filing_number:CUSTOM'
          ,'orig_filing_type:invalid_orig_filing_type:CUSTOM'
          ,'orig_filing_date:invalid_orig_filing_date:CUSTOM'
          ,'orig_filing_time:invalid_orig_filing_time:CUSTOM'
          ,'filing_number:invalid_mandatory:LENGTH'
          ,'filing_type:invalid_filing_type:CUSTOM'
          ,'filing_date:invalid_filing_date:CUSTOM'
          ,'filing_time:invalid_filing_time:CUSTOM'
          ,'filing_status:invalid_filing_status:CUSTOM'
          ,'status_type:invalid_status_type:CUSTOM'
          ,'page:invalid_numeric_blank:ALLOW'
          ,'expiration_date:invalid_expiration_date:CUSTOM'
          ,'contract_type:invalid_empty:LENGTH'
          ,'vendor_entry_date:invalid_empty:LENGTH'
          ,'vendor_upd_date:invalid_empty:LENGTH'
          ,'statements_filed:invalid_empty:LENGTH'
          ,'continuious_expiration:invalid_empty:LENGTH'
          ,'microfilm_number:invalid_microfilm_number:ALLOW','microfilm_number:invalid_microfilm_number:LENGTH'
          ,'amount:invalid_empty:LENGTH'
          ,'effective_date:invalid_empty:LENGTH'
          ,'signer_name:invalid_wordbag:ALLOW','signer_name:invalid_wordbag:LENGTH'
          ,'title:invalid_empty:LENGTH'
          ,'filing_agency:invalid_empty:LENGTH'
          ,'address:invalid_empty:LENGTH'
          ,'city:invalid_empty:LENGTH'
          ,'state:invalid_empty:LENGTH'
          ,'county:invalid_empty:LENGTH'
          ,'zip:invalid_empty:LENGTH'
          ,'prim_machine:invalid_empty:LENGTH'
          ,'manufacturer_code:invalid_empty:LENGTH'
          ,'manufacturer_name:invalid_empty:LENGTH'
          ,'model:invalid_empty:LENGTH'
          ,'model_year:invalid_empty:LENGTH'
          ,'model_desc:invalid_empty:LENGTH'
          ,'collateral_count:invalid_empty:LENGTH'
          ,'new_used:invalid_empty:LENGTH'
          ,'serial_number:invalid_empty:LENGTH'
          ,'property_desc:invalid_empty:LENGTH'
          ,'borough:invalid_empty:LENGTH'
          ,'block:invalid_empty:LENGTH'
          ,'collateral_address:invalid_empty:LENGTH'
          ,'air_rights_indc:invalid_empty:LENGTH'
          ,'subterranean_rights_indc:invalid_empty:LENGTH'
          ,'easment_indc:invalid_empty:LENGTH'
          ,'persistent_record_id:invalid_mandatory:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,CA_Main_Fields.InvalidMessage_tmsid(1)
          ,CA_Main_Fields.InvalidMessage_rmsid(1)
          ,CA_Main_Fields.InvalidMessage_process_date(1),CA_Main_Fields.InvalidMessage_process_date(2)
          ,CA_Main_Fields.InvalidMessage_filing_jurisdiction(1)
          ,CA_Main_Fields.InvalidMessage_orig_filing_number(1)
          ,CA_Main_Fields.InvalidMessage_orig_filing_type(1)
          ,CA_Main_Fields.InvalidMessage_orig_filing_date(1)
          ,CA_Main_Fields.InvalidMessage_orig_filing_time(1)
          ,CA_Main_Fields.InvalidMessage_filing_number(1)
          ,CA_Main_Fields.InvalidMessage_filing_type(1)
          ,CA_Main_Fields.InvalidMessage_filing_date(1)
          ,CA_Main_Fields.InvalidMessage_filing_time(1)
          ,CA_Main_Fields.InvalidMessage_filing_status(1)
          ,CA_Main_Fields.InvalidMessage_status_type(1)
          ,CA_Main_Fields.InvalidMessage_page(1)
          ,CA_Main_Fields.InvalidMessage_expiration_date(1)
          ,CA_Main_Fields.InvalidMessage_contract_type(1)
          ,CA_Main_Fields.InvalidMessage_vendor_entry_date(1)
          ,CA_Main_Fields.InvalidMessage_vendor_upd_date(1)
          ,CA_Main_Fields.InvalidMessage_statements_filed(1)
          ,CA_Main_Fields.InvalidMessage_continuious_expiration(1)
          ,CA_Main_Fields.InvalidMessage_microfilm_number(1),CA_Main_Fields.InvalidMessage_microfilm_number(2)
          ,CA_Main_Fields.InvalidMessage_amount(1)
          ,CA_Main_Fields.InvalidMessage_effective_date(1)
          ,CA_Main_Fields.InvalidMessage_signer_name(1),CA_Main_Fields.InvalidMessage_signer_name(2)
          ,CA_Main_Fields.InvalidMessage_title(1)
          ,CA_Main_Fields.InvalidMessage_filing_agency(1)
          ,CA_Main_Fields.InvalidMessage_address(1)
          ,CA_Main_Fields.InvalidMessage_city(1)
          ,CA_Main_Fields.InvalidMessage_state(1)
          ,CA_Main_Fields.InvalidMessage_county(1)
          ,CA_Main_Fields.InvalidMessage_zip(1)
          ,CA_Main_Fields.InvalidMessage_prim_machine(1)
          ,CA_Main_Fields.InvalidMessage_manufacturer_code(1)
          ,CA_Main_Fields.InvalidMessage_manufacturer_name(1)
          ,CA_Main_Fields.InvalidMessage_model(1)
          ,CA_Main_Fields.InvalidMessage_model_year(1)
          ,CA_Main_Fields.InvalidMessage_model_desc(1)
          ,CA_Main_Fields.InvalidMessage_collateral_count(1)
          ,CA_Main_Fields.InvalidMessage_new_used(1)
          ,CA_Main_Fields.InvalidMessage_serial_number(1)
          ,CA_Main_Fields.InvalidMessage_property_desc(1)
          ,CA_Main_Fields.InvalidMessage_borough(1)
          ,CA_Main_Fields.InvalidMessage_block(1)
          ,CA_Main_Fields.InvalidMessage_collateral_address(1)
          ,CA_Main_Fields.InvalidMessage_air_rights_indc(1)
          ,CA_Main_Fields.InvalidMessage_subterranean_rights_indc(1)
          ,CA_Main_Fields.InvalidMessage_easment_indc(1)
          ,CA_Main_Fields.InvalidMessage_persistent_record_id(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.filing_jurisdiction_ENUM_ErrorCount
          ,le.orig_filing_number_CUSTOM_ErrorCount
          ,le.orig_filing_type_CUSTOM_ErrorCount
          ,le.orig_filing_date_CUSTOM_ErrorCount
          ,le.orig_filing_time_CUSTOM_ErrorCount
          ,le.filing_number_LENGTH_ErrorCount
          ,le.filing_type_CUSTOM_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.filing_time_CUSTOM_ErrorCount
          ,le.filing_status_CUSTOM_ErrorCount
          ,le.status_type_CUSTOM_ErrorCount
          ,le.page_ALLOW_ErrorCount
          ,le.expiration_date_CUSTOM_ErrorCount
          ,le.contract_type_LENGTH_ErrorCount
          ,le.vendor_entry_date_LENGTH_ErrorCount
          ,le.vendor_upd_date_LENGTH_ErrorCount
          ,le.statements_filed_LENGTH_ErrorCount
          ,le.continuious_expiration_LENGTH_ErrorCount
          ,le.microfilm_number_ALLOW_ErrorCount,le.microfilm_number_LENGTH_ErrorCount
          ,le.amount_LENGTH_ErrorCount
          ,le.effective_date_LENGTH_ErrorCount
          ,le.signer_name_ALLOW_ErrorCount,le.signer_name_LENGTH_ErrorCount
          ,le.title_LENGTH_ErrorCount
          ,le.filing_agency_LENGTH_ErrorCount
          ,le.address_LENGTH_ErrorCount
          ,le.city_LENGTH_ErrorCount
          ,le.state_LENGTH_ErrorCount
          ,le.county_LENGTH_ErrorCount
          ,le.zip_LENGTH_ErrorCount
          ,le.prim_machine_LENGTH_ErrorCount
          ,le.manufacturer_code_LENGTH_ErrorCount
          ,le.manufacturer_name_LENGTH_ErrorCount
          ,le.model_LENGTH_ErrorCount
          ,le.model_year_LENGTH_ErrorCount
          ,le.model_desc_LENGTH_ErrorCount
          ,le.collateral_count_LENGTH_ErrorCount
          ,le.new_used_LENGTH_ErrorCount
          ,le.serial_number_LENGTH_ErrorCount
          ,le.property_desc_LENGTH_ErrorCount
          ,le.borough_LENGTH_ErrorCount
          ,le.block_LENGTH_ErrorCount
          ,le.collateral_address_LENGTH_ErrorCount
          ,le.air_rights_indc_LENGTH_ErrorCount
          ,le.subterranean_rights_indc_LENGTH_ErrorCount
          ,le.easment_indc_LENGTH_ErrorCount
          ,le.persistent_record_id_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.filing_jurisdiction_ENUM_ErrorCount
          ,le.orig_filing_number_CUSTOM_ErrorCount
          ,le.orig_filing_type_CUSTOM_ErrorCount
          ,le.orig_filing_date_CUSTOM_ErrorCount
          ,le.orig_filing_time_CUSTOM_ErrorCount
          ,le.filing_number_LENGTH_ErrorCount
          ,le.filing_type_CUSTOM_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.filing_time_CUSTOM_ErrorCount
          ,le.filing_status_CUSTOM_ErrorCount
          ,le.status_type_CUSTOM_ErrorCount
          ,le.page_ALLOW_ErrorCount
          ,le.expiration_date_CUSTOM_ErrorCount
          ,le.contract_type_LENGTH_ErrorCount
          ,le.vendor_entry_date_LENGTH_ErrorCount
          ,le.vendor_upd_date_LENGTH_ErrorCount
          ,le.statements_filed_LENGTH_ErrorCount
          ,le.continuious_expiration_LENGTH_ErrorCount
          ,le.microfilm_number_ALLOW_ErrorCount,le.microfilm_number_LENGTH_ErrorCount
          ,le.amount_LENGTH_ErrorCount
          ,le.effective_date_LENGTH_ErrorCount
          ,le.signer_name_ALLOW_ErrorCount,le.signer_name_LENGTH_ErrorCount
          ,le.title_LENGTH_ErrorCount
          ,le.filing_agency_LENGTH_ErrorCount
          ,le.address_LENGTH_ErrorCount
          ,le.city_LENGTH_ErrorCount
          ,le.state_LENGTH_ErrorCount
          ,le.county_LENGTH_ErrorCount
          ,le.zip_LENGTH_ErrorCount
          ,le.prim_machine_LENGTH_ErrorCount
          ,le.manufacturer_code_LENGTH_ErrorCount
          ,le.manufacturer_name_LENGTH_ErrorCount
          ,le.model_LENGTH_ErrorCount
          ,le.model_year_LENGTH_ErrorCount
          ,le.model_desc_LENGTH_ErrorCount
          ,le.collateral_count_LENGTH_ErrorCount
          ,le.new_used_LENGTH_ErrorCount
          ,le.serial_number_LENGTH_ErrorCount
          ,le.property_desc_LENGTH_ErrorCount
          ,le.borough_LENGTH_ErrorCount
          ,le.block_LENGTH_ErrorCount
          ,le.collateral_address_LENGTH_ErrorCount
          ,le.air_rights_indc_LENGTH_ErrorCount
          ,le.subterranean_rights_indc_LENGTH_ErrorCount
          ,le.easment_indc_LENGTH_ErrorCount
          ,le.persistent_record_id_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,52,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT37.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT37.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
