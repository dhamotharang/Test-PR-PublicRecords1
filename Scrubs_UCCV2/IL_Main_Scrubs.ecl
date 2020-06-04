IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_UCCV2; // Import modules for FieldTypes attribute definitions
EXPORT IL_Main_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 57;
  EXPORT NumRulesFromFieldType := 57;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 56;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(IL_Main_Layout_UCCV2)
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
    UNSIGNED1 irs_serial_number_Invalid;
    UNSIGNED1 effective_date_Invalid;
    UNSIGNED1 signer_name_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 filing_agency_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 duns_number_Invalid;
    UNSIGNED1 cmnt_effective_date_Invalid;
    UNSIGNED1 description_Invalid;
    UNSIGNED1 prim_machine_Invalid;
    UNSIGNED1 sec_machine_Invalid;
    UNSIGNED1 manufacturer_code_Invalid;
    UNSIGNED1 manufacturer_name_Invalid;
    UNSIGNED1 model_Invalid;
    UNSIGNED1 model_year_Invalid;
    UNSIGNED1 model_desc_Invalid;
    UNSIGNED1 collateral_count_Invalid;
    UNSIGNED1 manufactured_year_Invalid;
    UNSIGNED1 new_used_Invalid;
    UNSIGNED1 serial_number_Invalid;
    UNSIGNED1 property_desc_Invalid;
    UNSIGNED1 borough_Invalid;
    UNSIGNED1 block_Invalid;
    UNSIGNED1 collateral_address_Invalid;
    UNSIGNED1 air_rights_indc_Invalid;
    UNSIGNED1 subterranean_rights_indc_Invalid;
    UNSIGNED1 easment_indc_Invalid;
    UNSIGNED1 volume_Invalid;
    UNSIGNED1 persistent_record_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(IL_Main_Layout_UCCV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(IL_Main_Layout_UCCV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.tmsid_Invalid := IL_Main_Fields.InValid_tmsid((SALT311.StrType)le.tmsid);
    SELF.rmsid_Invalid := IL_Main_Fields.InValid_rmsid((SALT311.StrType)le.rmsid);
    SELF.process_date_Invalid := IL_Main_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.filing_jurisdiction_Invalid := IL_Main_Fields.InValid_filing_jurisdiction((SALT311.StrType)le.filing_jurisdiction);
    SELF.orig_filing_number_Invalid := IL_Main_Fields.InValid_orig_filing_number((SALT311.StrType)le.orig_filing_number);
    SELF.orig_filing_type_Invalid := IL_Main_Fields.InValid_orig_filing_type((SALT311.StrType)le.orig_filing_type);
    SELF.orig_filing_date_Invalid := IL_Main_Fields.InValid_orig_filing_date((SALT311.StrType)le.orig_filing_date);
    SELF.orig_filing_time_Invalid := IL_Main_Fields.InValid_orig_filing_time((SALT311.StrType)le.orig_filing_time);
    SELF.filing_number_Invalid := IL_Main_Fields.InValid_filing_number((SALT311.StrType)le.filing_number);
    SELF.filing_type_Invalid := IL_Main_Fields.InValid_filing_type((SALT311.StrType)le.filing_type);
    SELF.filing_date_Invalid := IL_Main_Fields.InValid_filing_date((SALT311.StrType)le.filing_date);
    SELF.filing_time_Invalid := IL_Main_Fields.InValid_filing_time((SALT311.StrType)le.filing_time);
    SELF.filing_status_Invalid := IL_Main_Fields.InValid_filing_status((SALT311.StrType)le.filing_status);
    SELF.status_type_Invalid := IL_Main_Fields.InValid_status_type((SALT311.StrType)le.status_type);
    SELF.page_Invalid := IL_Main_Fields.InValid_page((SALT311.StrType)le.page);
    SELF.expiration_date_Invalid := IL_Main_Fields.InValid_expiration_date((SALT311.StrType)le.expiration_date);
    SELF.contract_type_Invalid := IL_Main_Fields.InValid_contract_type((SALT311.StrType)le.contract_type);
    SELF.vendor_entry_date_Invalid := IL_Main_Fields.InValid_vendor_entry_date((SALT311.StrType)le.vendor_entry_date);
    SELF.vendor_upd_date_Invalid := IL_Main_Fields.InValid_vendor_upd_date((SALT311.StrType)le.vendor_upd_date);
    SELF.statements_filed_Invalid := IL_Main_Fields.InValid_statements_filed((SALT311.StrType)le.statements_filed);
    SELF.continuious_expiration_Invalid := IL_Main_Fields.InValid_continuious_expiration((SALT311.StrType)le.continuious_expiration);
    SELF.microfilm_number_Invalid := IL_Main_Fields.InValid_microfilm_number((SALT311.StrType)le.microfilm_number);
    SELF.amount_Invalid := IL_Main_Fields.InValid_amount((SALT311.StrType)le.amount);
    SELF.irs_serial_number_Invalid := IL_Main_Fields.InValid_irs_serial_number((SALT311.StrType)le.irs_serial_number);
    SELF.effective_date_Invalid := IL_Main_Fields.InValid_effective_date((SALT311.StrType)le.effective_date);
    SELF.signer_name_Invalid := IL_Main_Fields.InValid_signer_name((SALT311.StrType)le.signer_name);
    SELF.title_Invalid := IL_Main_Fields.InValid_title((SALT311.StrType)le.title);
    SELF.filing_agency_Invalid := IL_Main_Fields.InValid_filing_agency((SALT311.StrType)le.filing_agency);
    SELF.address_Invalid := IL_Main_Fields.InValid_address((SALT311.StrType)le.address);
    SELF.city_Invalid := IL_Main_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := IL_Main_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.county_Invalid := IL_Main_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.zip_Invalid := IL_Main_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.duns_number_Invalid := IL_Main_Fields.InValid_duns_number((SALT311.StrType)le.duns_number);
    SELF.cmnt_effective_date_Invalid := IL_Main_Fields.InValid_cmnt_effective_date((SALT311.StrType)le.cmnt_effective_date);
    SELF.description_Invalid := IL_Main_Fields.InValid_description((SALT311.StrType)le.description);
    SELF.prim_machine_Invalid := IL_Main_Fields.InValid_prim_machine((SALT311.StrType)le.prim_machine);
    SELF.sec_machine_Invalid := IL_Main_Fields.InValid_sec_machine((SALT311.StrType)le.sec_machine);
    SELF.manufacturer_code_Invalid := IL_Main_Fields.InValid_manufacturer_code((SALT311.StrType)le.manufacturer_code);
    SELF.manufacturer_name_Invalid := IL_Main_Fields.InValid_manufacturer_name((SALT311.StrType)le.manufacturer_name);
    SELF.model_Invalid := IL_Main_Fields.InValid_model((SALT311.StrType)le.model);
    SELF.model_year_Invalid := IL_Main_Fields.InValid_model_year((SALT311.StrType)le.model_year);
    SELF.model_desc_Invalid := IL_Main_Fields.InValid_model_desc((SALT311.StrType)le.model_desc);
    SELF.collateral_count_Invalid := IL_Main_Fields.InValid_collateral_count((SALT311.StrType)le.collateral_count);
    SELF.manufactured_year_Invalid := IL_Main_Fields.InValid_manufactured_year((SALT311.StrType)le.manufactured_year);
    SELF.new_used_Invalid := IL_Main_Fields.InValid_new_used((SALT311.StrType)le.new_used);
    SELF.serial_number_Invalid := IL_Main_Fields.InValid_serial_number((SALT311.StrType)le.serial_number);
    SELF.property_desc_Invalid := IL_Main_Fields.InValid_property_desc((SALT311.StrType)le.property_desc);
    SELF.borough_Invalid := IL_Main_Fields.InValid_borough((SALT311.StrType)le.borough);
    SELF.block_Invalid := IL_Main_Fields.InValid_block((SALT311.StrType)le.block);
    SELF.collateral_address_Invalid := IL_Main_Fields.InValid_collateral_address((SALT311.StrType)le.collateral_address);
    SELF.air_rights_indc_Invalid := IL_Main_Fields.InValid_air_rights_indc((SALT311.StrType)le.air_rights_indc);
    SELF.subterranean_rights_indc_Invalid := IL_Main_Fields.InValid_subterranean_rights_indc((SALT311.StrType)le.subterranean_rights_indc);
    SELF.easment_indc_Invalid := IL_Main_Fields.InValid_easment_indc((SALT311.StrType)le.easment_indc);
    SELF.volume_Invalid := IL_Main_Fields.InValid_volume((SALT311.StrType)le.volume);
    SELF.persistent_record_id_Invalid := IL_Main_Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),IL_Main_Layout_UCCV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.tmsid_Invalid << 0 ) + ( le.rmsid_Invalid << 1 ) + ( le.process_date_Invalid << 2 ) + ( le.filing_jurisdiction_Invalid << 4 ) + ( le.orig_filing_number_Invalid << 5 ) + ( le.orig_filing_type_Invalid << 6 ) + ( le.orig_filing_date_Invalid << 7 ) + ( le.orig_filing_time_Invalid << 8 ) + ( le.filing_number_Invalid << 9 ) + ( le.filing_type_Invalid << 10 ) + ( le.filing_date_Invalid << 11 ) + ( le.filing_time_Invalid << 12 ) + ( le.filing_status_Invalid << 13 ) + ( le.status_type_Invalid << 14 ) + ( le.page_Invalid << 15 ) + ( le.expiration_date_Invalid << 16 ) + ( le.contract_type_Invalid << 17 ) + ( le.vendor_entry_date_Invalid << 18 ) + ( le.vendor_upd_date_Invalid << 19 ) + ( le.statements_filed_Invalid << 20 ) + ( le.continuious_expiration_Invalid << 21 ) + ( le.microfilm_number_Invalid << 22 ) + ( le.amount_Invalid << 23 ) + ( le.irs_serial_number_Invalid << 24 ) + ( le.effective_date_Invalid << 25 ) + ( le.signer_name_Invalid << 26 ) + ( le.title_Invalid << 27 ) + ( le.filing_agency_Invalid << 28 ) + ( le.address_Invalid << 29 ) + ( le.city_Invalid << 30 ) + ( le.state_Invalid << 31 ) + ( le.county_Invalid << 32 ) + ( le.zip_Invalid << 33 ) + ( le.duns_number_Invalid << 34 ) + ( le.cmnt_effective_date_Invalid << 35 ) + ( le.description_Invalid << 36 ) + ( le.prim_machine_Invalid << 37 ) + ( le.sec_machine_Invalid << 38 ) + ( le.manufacturer_code_Invalid << 39 ) + ( le.manufacturer_name_Invalid << 40 ) + ( le.model_Invalid << 41 ) + ( le.model_year_Invalid << 42 ) + ( le.model_desc_Invalid << 43 ) + ( le.collateral_count_Invalid << 44 ) + ( le.manufactured_year_Invalid << 45 ) + ( le.new_used_Invalid << 46 ) + ( le.serial_number_Invalid << 47 ) + ( le.property_desc_Invalid << 48 ) + ( le.borough_Invalid << 49 ) + ( le.block_Invalid << 50 ) + ( le.collateral_address_Invalid << 51 ) + ( le.air_rights_indc_Invalid << 52 ) + ( le.subterranean_rights_indc_Invalid << 53 ) + ( le.easment_indc_Invalid << 54 ) + ( le.volume_Invalid << 55 ) + ( le.persistent_record_id_Invalid << 56 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,IL_Main_Layout_UCCV2);
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
    SELF.microfilm_number_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.amount_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.irs_serial_number_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.effective_date_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.signer_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.filing_agency_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.duns_number_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.cmnt_effective_date_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.description_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.prim_machine_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.sec_machine_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.manufacturer_code_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.manufacturer_name_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.model_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.model_year_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.model_desc_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.collateral_count_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.manufactured_year_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.new_used_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.serial_number_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.property_desc_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.borough_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.block_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.collateral_address_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.air_rights_indc_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.subterranean_rights_indc_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.easment_indc_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.volume_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits1 >> 56) & 1;
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
    process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    filing_jurisdiction_ENUM_ErrorCount := COUNT(GROUP,h.filing_jurisdiction_Invalid=1);
    orig_filing_number_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_number_Invalid=1);
    orig_filing_type_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_type_Invalid=1);
    orig_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid=1);
    orig_filing_time_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_time_Invalid=1);
    filing_number_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_number_Invalid=1);
    filing_type_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_type_Invalid=1);
    filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=1);
    filing_time_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_time_Invalid=1);
    filing_status_LENGTHS_ErrorCount := COUNT(GROUP,h.filing_status_Invalid=1);
    status_type_LENGTHS_ErrorCount := COUNT(GROUP,h.status_type_Invalid=1);
    page_ALLOW_ErrorCount := COUNT(GROUP,h.page_Invalid=1);
    expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=1);
    contract_type_LENGTHS_ErrorCount := COUNT(GROUP,h.contract_type_Invalid=1);
    vendor_entry_date_LENGTHS_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid=1);
    vendor_upd_date_LENGTHS_ErrorCount := COUNT(GROUP,h.vendor_upd_date_Invalid=1);
    statements_filed_ALLOW_ErrorCount := COUNT(GROUP,h.statements_filed_Invalid=1);
    continuious_expiration_ENUM_ErrorCount := COUNT(GROUP,h.continuious_expiration_Invalid=1);
    microfilm_number_LENGTHS_ErrorCount := COUNT(GROUP,h.microfilm_number_Invalid=1);
    amount_LENGTHS_ErrorCount := COUNT(GROUP,h.amount_Invalid=1);
    irs_serial_number_LENGTHS_ErrorCount := COUNT(GROUP,h.irs_serial_number_Invalid=1);
    effective_date_LENGTHS_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=1);
    signer_name_LENGTHS_ErrorCount := COUNT(GROUP,h.signer_name_Invalid=1);
    title_LENGTHS_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    filing_agency_LENGTHS_ErrorCount := COUNT(GROUP,h.filing_agency_Invalid=1);
    address_LENGTHS_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    city_LENGTHS_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    county_LENGTHS_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    duns_number_LENGTHS_ErrorCount := COUNT(GROUP,h.duns_number_Invalid=1);
    cmnt_effective_date_LENGTHS_ErrorCount := COUNT(GROUP,h.cmnt_effective_date_Invalid=1);
    description_LENGTHS_ErrorCount := COUNT(GROUP,h.description_Invalid=1);
    prim_machine_LENGTHS_ErrorCount := COUNT(GROUP,h.prim_machine_Invalid=1);
    sec_machine_LENGTHS_ErrorCount := COUNT(GROUP,h.sec_machine_Invalid=1);
    manufacturer_code_LENGTHS_ErrorCount := COUNT(GROUP,h.manufacturer_code_Invalid=1);
    manufacturer_name_LENGTHS_ErrorCount := COUNT(GROUP,h.manufacturer_name_Invalid=1);
    model_LENGTHS_ErrorCount := COUNT(GROUP,h.model_Invalid=1);
    model_year_LENGTHS_ErrorCount := COUNT(GROUP,h.model_year_Invalid=1);
    model_desc_LENGTHS_ErrorCount := COUNT(GROUP,h.model_desc_Invalid=1);
    collateral_count_LENGTHS_ErrorCount := COUNT(GROUP,h.collateral_count_Invalid=1);
    manufactured_year_LENGTHS_ErrorCount := COUNT(GROUP,h.manufactured_year_Invalid=1);
    new_used_LENGTHS_ErrorCount := COUNT(GROUP,h.new_used_Invalid=1);
    serial_number_LENGTHS_ErrorCount := COUNT(GROUP,h.serial_number_Invalid=1);
    property_desc_LENGTHS_ErrorCount := COUNT(GROUP,h.property_desc_Invalid=1);
    borough_LENGTHS_ErrorCount := COUNT(GROUP,h.borough_Invalid=1);
    block_LENGTHS_ErrorCount := COUNT(GROUP,h.block_Invalid=1);
    collateral_address_LENGTHS_ErrorCount := COUNT(GROUP,h.collateral_address_Invalid=1);
    air_rights_indc_LENGTHS_ErrorCount := COUNT(GROUP,h.air_rights_indc_Invalid=1);
    subterranean_rights_indc_LENGTHS_ErrorCount := COUNT(GROUP,h.subterranean_rights_indc_Invalid=1);
    easment_indc_LENGTHS_ErrorCount := COUNT(GROUP,h.easment_indc_Invalid=1);
    volume_LENGTHS_ErrorCount := COUNT(GROUP,h.volume_Invalid=1);
    persistent_record_id_LENGTHS_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.tmsid_Invalid > 0 OR h.rmsid_Invalid > 0 OR h.process_date_Invalid > 0 OR h.filing_jurisdiction_Invalid > 0 OR h.orig_filing_number_Invalid > 0 OR h.orig_filing_type_Invalid > 0 OR h.orig_filing_date_Invalid > 0 OR h.orig_filing_time_Invalid > 0 OR h.filing_number_Invalid > 0 OR h.filing_type_Invalid > 0 OR h.filing_date_Invalid > 0 OR h.filing_time_Invalid > 0 OR h.filing_status_Invalid > 0 OR h.status_type_Invalid > 0 OR h.page_Invalid > 0 OR h.expiration_date_Invalid > 0 OR h.contract_type_Invalid > 0 OR h.vendor_entry_date_Invalid > 0 OR h.vendor_upd_date_Invalid > 0 OR h.statements_filed_Invalid > 0 OR h.continuious_expiration_Invalid > 0 OR h.microfilm_number_Invalid > 0 OR h.amount_Invalid > 0 OR h.irs_serial_number_Invalid > 0 OR h.effective_date_Invalid > 0 OR h.signer_name_Invalid > 0 OR h.title_Invalid > 0 OR h.filing_agency_Invalid > 0 OR h.address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.county_Invalid > 0 OR h.zip_Invalid > 0 OR h.duns_number_Invalid > 0 OR h.cmnt_effective_date_Invalid > 0 OR h.description_Invalid > 0 OR h.prim_machine_Invalid > 0 OR h.sec_machine_Invalid > 0 OR h.manufacturer_code_Invalid > 0 OR h.manufacturer_name_Invalid > 0 OR h.model_Invalid > 0 OR h.model_year_Invalid > 0 OR h.model_desc_Invalid > 0 OR h.collateral_count_Invalid > 0 OR h.manufactured_year_Invalid > 0 OR h.new_used_Invalid > 0 OR h.serial_number_Invalid > 0 OR h.property_desc_Invalid > 0 OR h.borough_Invalid > 0 OR h.block_Invalid > 0 OR h.collateral_address_Invalid > 0 OR h.air_rights_indc_Invalid > 0 OR h.subterranean_rights_indc_Invalid > 0 OR h.easment_indc_Invalid > 0 OR h.volume_Invalid > 0 OR h.persistent_record_id_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.tmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_Total_ErrorCount > 0, 1, 0) + IF(le.filing_jurisdiction_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_filing_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_filing_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_filing_time_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_time_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_status_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.status_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.page_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expiration_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contract_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vendor_entry_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vendor_upd_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.statements_filed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.continuious_expiration_ENUM_ErrorCount > 0, 1, 0) + IF(le.microfilm_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.amount_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.irs_serial_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.effective_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.signer_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.filing_agency_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.county_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.duns_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cmnt_effective_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.description_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_machine_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sec_machine_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.manufacturer_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.manufacturer_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_desc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.collateral_count_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.manufactured_year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.new_used_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.serial_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.property_desc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.borough_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.block_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.collateral_address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.air_rights_indc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.subterranean_rights_indc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.easment_indc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.volume_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.tmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.rmsid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.filing_jurisdiction_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_filing_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_filing_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_filing_time_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_time_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.filing_status_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.status_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.page_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expiration_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.contract_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vendor_entry_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vendor_upd_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.statements_filed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.continuious_expiration_ENUM_ErrorCount > 0, 1, 0) + IF(le.microfilm_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.amount_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.irs_serial_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.effective_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.signer_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.filing_agency_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.county_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.duns_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cmnt_effective_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.description_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_machine_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sec_machine_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.manufacturer_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.manufacturer_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.model_desc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.collateral_count_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.manufactured_year_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.new_used_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.serial_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.property_desc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.borough_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.block_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.collateral_address_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.air_rights_indc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.subterranean_rights_indc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.easment_indc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.volume_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_LENGTHS_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.tmsid_Invalid,le.rmsid_Invalid,le.process_date_Invalid,le.filing_jurisdiction_Invalid,le.orig_filing_number_Invalid,le.orig_filing_type_Invalid,le.orig_filing_date_Invalid,le.orig_filing_time_Invalid,le.filing_number_Invalid,le.filing_type_Invalid,le.filing_date_Invalid,le.filing_time_Invalid,le.filing_status_Invalid,le.status_type_Invalid,le.page_Invalid,le.expiration_date_Invalid,le.contract_type_Invalid,le.vendor_entry_date_Invalid,le.vendor_upd_date_Invalid,le.statements_filed_Invalid,le.continuious_expiration_Invalid,le.microfilm_number_Invalid,le.amount_Invalid,le.irs_serial_number_Invalid,le.effective_date_Invalid,le.signer_name_Invalid,le.title_Invalid,le.filing_agency_Invalid,le.address_Invalid,le.city_Invalid,le.state_Invalid,le.county_Invalid,le.zip_Invalid,le.duns_number_Invalid,le.cmnt_effective_date_Invalid,le.description_Invalid,le.prim_machine_Invalid,le.sec_machine_Invalid,le.manufacturer_code_Invalid,le.manufacturer_name_Invalid,le.model_Invalid,le.model_year_Invalid,le.model_desc_Invalid,le.collateral_count_Invalid,le.manufactured_year_Invalid,le.new_used_Invalid,le.serial_number_Invalid,le.property_desc_Invalid,le.borough_Invalid,le.block_Invalid,le.collateral_address_Invalid,le.air_rights_indc_Invalid,le.subterranean_rights_indc_Invalid,le.easment_indc_Invalid,le.volume_Invalid,le.persistent_record_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,IL_Main_Fields.InvalidMessage_tmsid(le.tmsid_Invalid),IL_Main_Fields.InvalidMessage_rmsid(le.rmsid_Invalid),IL_Main_Fields.InvalidMessage_process_date(le.process_date_Invalid),IL_Main_Fields.InvalidMessage_filing_jurisdiction(le.filing_jurisdiction_Invalid),IL_Main_Fields.InvalidMessage_orig_filing_number(le.orig_filing_number_Invalid),IL_Main_Fields.InvalidMessage_orig_filing_type(le.orig_filing_type_Invalid),IL_Main_Fields.InvalidMessage_orig_filing_date(le.orig_filing_date_Invalid),IL_Main_Fields.InvalidMessage_orig_filing_time(le.orig_filing_time_Invalid),IL_Main_Fields.InvalidMessage_filing_number(le.filing_number_Invalid),IL_Main_Fields.InvalidMessage_filing_type(le.filing_type_Invalid),IL_Main_Fields.InvalidMessage_filing_date(le.filing_date_Invalid),IL_Main_Fields.InvalidMessage_filing_time(le.filing_time_Invalid),IL_Main_Fields.InvalidMessage_filing_status(le.filing_status_Invalid),IL_Main_Fields.InvalidMessage_status_type(le.status_type_Invalid),IL_Main_Fields.InvalidMessage_page(le.page_Invalid),IL_Main_Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),IL_Main_Fields.InvalidMessage_contract_type(le.contract_type_Invalid),IL_Main_Fields.InvalidMessage_vendor_entry_date(le.vendor_entry_date_Invalid),IL_Main_Fields.InvalidMessage_vendor_upd_date(le.vendor_upd_date_Invalid),IL_Main_Fields.InvalidMessage_statements_filed(le.statements_filed_Invalid),IL_Main_Fields.InvalidMessage_continuious_expiration(le.continuious_expiration_Invalid),IL_Main_Fields.InvalidMessage_microfilm_number(le.microfilm_number_Invalid),IL_Main_Fields.InvalidMessage_amount(le.amount_Invalid),IL_Main_Fields.InvalidMessage_irs_serial_number(le.irs_serial_number_Invalid),IL_Main_Fields.InvalidMessage_effective_date(le.effective_date_Invalid),IL_Main_Fields.InvalidMessage_signer_name(le.signer_name_Invalid),IL_Main_Fields.InvalidMessage_title(le.title_Invalid),IL_Main_Fields.InvalidMessage_filing_agency(le.filing_agency_Invalid),IL_Main_Fields.InvalidMessage_address(le.address_Invalid),IL_Main_Fields.InvalidMessage_city(le.city_Invalid),IL_Main_Fields.InvalidMessage_state(le.state_Invalid),IL_Main_Fields.InvalidMessage_county(le.county_Invalid),IL_Main_Fields.InvalidMessage_zip(le.zip_Invalid),IL_Main_Fields.InvalidMessage_duns_number(le.duns_number_Invalid),IL_Main_Fields.InvalidMessage_cmnt_effective_date(le.cmnt_effective_date_Invalid),IL_Main_Fields.InvalidMessage_description(le.description_Invalid),IL_Main_Fields.InvalidMessage_prim_machine(le.prim_machine_Invalid),IL_Main_Fields.InvalidMessage_sec_machine(le.sec_machine_Invalid),IL_Main_Fields.InvalidMessage_manufacturer_code(le.manufacturer_code_Invalid),IL_Main_Fields.InvalidMessage_manufacturer_name(le.manufacturer_name_Invalid),IL_Main_Fields.InvalidMessage_model(le.model_Invalid),IL_Main_Fields.InvalidMessage_model_year(le.model_year_Invalid),IL_Main_Fields.InvalidMessage_model_desc(le.model_desc_Invalid),IL_Main_Fields.InvalidMessage_collateral_count(le.collateral_count_Invalid),IL_Main_Fields.InvalidMessage_manufactured_year(le.manufactured_year_Invalid),IL_Main_Fields.InvalidMessage_new_used(le.new_used_Invalid),IL_Main_Fields.InvalidMessage_serial_number(le.serial_number_Invalid),IL_Main_Fields.InvalidMessage_property_desc(le.property_desc_Invalid),IL_Main_Fields.InvalidMessage_borough(le.borough_Invalid),IL_Main_Fields.InvalidMessage_block(le.block_Invalid),IL_Main_Fields.InvalidMessage_collateral_address(le.collateral_address_Invalid),IL_Main_Fields.InvalidMessage_air_rights_indc(le.air_rights_indc_Invalid),IL_Main_Fields.InvalidMessage_subterranean_rights_indc(le.subterranean_rights_indc_Invalid),IL_Main_Fields.InvalidMessage_easment_indc(le.easment_indc_Invalid),IL_Main_Fields.InvalidMessage_volume(le.volume_Invalid),IL_Main_Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.tmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.filing_jurisdiction_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_filing_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_time_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_time_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_status_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.status_type_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.page_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expiration_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contract_type_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.vendor_entry_date_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.vendor_upd_date_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.statements_filed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.continuious_expiration_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.microfilm_number_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.amount_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.irs_serial_number_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.effective_date_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.signer_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.filing_agency_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.duns_number_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.cmnt_effective_date_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.description_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prim_machine_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.sec_machine_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.manufacturer_code_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.manufacturer_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.model_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.model_year_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.model_desc_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.collateral_count_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.manufactured_year_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.new_used_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.serial_number_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.property_desc_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.borough_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.block_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.collateral_address_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.air_rights_indc_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.subterranean_rights_indc_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.easment_indc_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.volume_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'tmsid','rmsid','process_date','filing_jurisdiction','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','filing_number','filing_type','filing_date','filing_time','filing_status','status_type','page','expiration_date','contract_type','vendor_entry_date','vendor_upd_date','statements_filed','continuious_expiration','microfilm_number','amount','irs_serial_number','effective_date','signer_name','title','filing_agency','address','city','state','county','zip','duns_number','cmnt_effective_date','description','prim_machine','sec_machine','manufacturer_code','manufacturer_name','model','model_year','model_desc','collateral_count','manufactured_year','new_used','serial_number','property_desc','borough','block','collateral_address','air_rights_indc','subterranean_rights_indc','easment_indc','volume','persistent_record_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_tmsid','invalid_rmsid','invalid_8pastdate','invalid_filing_jurisdiction','invalid_orig_filing_number','invalid_orig_filing_type','invalid_orig_filing_date','invalid_orig_filing_time','invalid_filing_number','invalid_filing_type','invalid_filing_date','invalid_filing_time','invalid_empty','invalid_empty','invalid_numeric_blank','invalid_expiration_date','invalid_empty','invalid_empty','invalid_empty','invalid_numeric_blank','invalid_boolean_yn_blank','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.tmsid,(SALT311.StrType)le.rmsid,(SALT311.StrType)le.process_date,(SALT311.StrType)le.filing_jurisdiction,(SALT311.StrType)le.orig_filing_number,(SALT311.StrType)le.orig_filing_type,(SALT311.StrType)le.orig_filing_date,(SALT311.StrType)le.orig_filing_time,(SALT311.StrType)le.filing_number,(SALT311.StrType)le.filing_type,(SALT311.StrType)le.filing_date,(SALT311.StrType)le.filing_time,(SALT311.StrType)le.filing_status,(SALT311.StrType)le.status_type,(SALT311.StrType)le.page,(SALT311.StrType)le.expiration_date,(SALT311.StrType)le.contract_type,(SALT311.StrType)le.vendor_entry_date,(SALT311.StrType)le.vendor_upd_date,(SALT311.StrType)le.statements_filed,(SALT311.StrType)le.continuious_expiration,(SALT311.StrType)le.microfilm_number,(SALT311.StrType)le.amount,(SALT311.StrType)le.irs_serial_number,(SALT311.StrType)le.effective_date,(SALT311.StrType)le.signer_name,(SALT311.StrType)le.title,(SALT311.StrType)le.filing_agency,(SALT311.StrType)le.address,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.county,(SALT311.StrType)le.zip,(SALT311.StrType)le.duns_number,(SALT311.StrType)le.cmnt_effective_date,(SALT311.StrType)le.description,(SALT311.StrType)le.prim_machine,(SALT311.StrType)le.sec_machine,(SALT311.StrType)le.manufacturer_code,(SALT311.StrType)le.manufacturer_name,(SALT311.StrType)le.model,(SALT311.StrType)le.model_year,(SALT311.StrType)le.model_desc,(SALT311.StrType)le.collateral_count,(SALT311.StrType)le.manufactured_year,(SALT311.StrType)le.new_used,(SALT311.StrType)le.serial_number,(SALT311.StrType)le.property_desc,(SALT311.StrType)le.borough,(SALT311.StrType)le.block,(SALT311.StrType)le.collateral_address,(SALT311.StrType)le.air_rights_indc,(SALT311.StrType)le.subterranean_rights_indc,(SALT311.StrType)le.easment_indc,(SALT311.StrType)le.volume,(SALT311.StrType)le.persistent_record_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,56,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(IL_Main_Layout_UCCV2) prevDS = DATASET([], IL_Main_Layout_UCCV2), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'tmsid:invalid_tmsid:CUSTOM'
          ,'rmsid:invalid_rmsid:CUSTOM'
          ,'process_date:invalid_8pastdate:CUSTOM','process_date:invalid_8pastdate:LENGTHS'
          ,'filing_jurisdiction:invalid_filing_jurisdiction:ENUM'
          ,'orig_filing_number:invalid_orig_filing_number:CUSTOM'
          ,'orig_filing_type:invalid_orig_filing_type:CUSTOM'
          ,'orig_filing_date:invalid_orig_filing_date:CUSTOM'
          ,'orig_filing_time:invalid_orig_filing_time:CUSTOM'
          ,'filing_number:invalid_filing_number:CUSTOM'
          ,'filing_type:invalid_filing_type:CUSTOM'
          ,'filing_date:invalid_filing_date:CUSTOM'
          ,'filing_time:invalid_filing_time:CUSTOM'
          ,'filing_status:invalid_empty:LENGTHS'
          ,'status_type:invalid_empty:LENGTHS'
          ,'page:invalid_numeric_blank:ALLOW'
          ,'expiration_date:invalid_expiration_date:CUSTOM'
          ,'contract_type:invalid_empty:LENGTHS'
          ,'vendor_entry_date:invalid_empty:LENGTHS'
          ,'vendor_upd_date:invalid_empty:LENGTHS'
          ,'statements_filed:invalid_numeric_blank:ALLOW'
          ,'continuious_expiration:invalid_boolean_yn_blank:ENUM'
          ,'microfilm_number:invalid_empty:LENGTHS'
          ,'amount:invalid_empty:LENGTHS'
          ,'irs_serial_number:invalid_empty:LENGTHS'
          ,'effective_date:invalid_empty:LENGTHS'
          ,'signer_name:invalid_empty:LENGTHS'
          ,'title:invalid_empty:LENGTHS'
          ,'filing_agency:invalid_empty:LENGTHS'
          ,'address:invalid_empty:LENGTHS'
          ,'city:invalid_empty:LENGTHS'
          ,'state:invalid_empty:LENGTHS'
          ,'county:invalid_empty:LENGTHS'
          ,'zip:invalid_empty:LENGTHS'
          ,'duns_number:invalid_empty:LENGTHS'
          ,'cmnt_effective_date:invalid_empty:LENGTHS'
          ,'description:invalid_empty:LENGTHS'
          ,'prim_machine:invalid_empty:LENGTHS'
          ,'sec_machine:invalid_empty:LENGTHS'
          ,'manufacturer_code:invalid_empty:LENGTHS'
          ,'manufacturer_name:invalid_empty:LENGTHS'
          ,'model:invalid_empty:LENGTHS'
          ,'model_year:invalid_empty:LENGTHS'
          ,'model_desc:invalid_empty:LENGTHS'
          ,'collateral_count:invalid_empty:LENGTHS'
          ,'manufactured_year:invalid_empty:LENGTHS'
          ,'new_used:invalid_empty:LENGTHS'
          ,'serial_number:invalid_empty:LENGTHS'
          ,'property_desc:invalid_empty:LENGTHS'
          ,'borough:invalid_empty:LENGTHS'
          ,'block:invalid_empty:LENGTHS'
          ,'collateral_address:invalid_empty:LENGTHS'
          ,'air_rights_indc:invalid_empty:LENGTHS'
          ,'subterranean_rights_indc:invalid_empty:LENGTHS'
          ,'easment_indc:invalid_empty:LENGTHS'
          ,'volume:invalid_empty:LENGTHS'
          ,'persistent_record_id:invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,IL_Main_Fields.InvalidMessage_tmsid(1)
          ,IL_Main_Fields.InvalidMessage_rmsid(1)
          ,IL_Main_Fields.InvalidMessage_process_date(1),IL_Main_Fields.InvalidMessage_process_date(2)
          ,IL_Main_Fields.InvalidMessage_filing_jurisdiction(1)
          ,IL_Main_Fields.InvalidMessage_orig_filing_number(1)
          ,IL_Main_Fields.InvalidMessage_orig_filing_type(1)
          ,IL_Main_Fields.InvalidMessage_orig_filing_date(1)
          ,IL_Main_Fields.InvalidMessage_orig_filing_time(1)
          ,IL_Main_Fields.InvalidMessage_filing_number(1)
          ,IL_Main_Fields.InvalidMessage_filing_type(1)
          ,IL_Main_Fields.InvalidMessage_filing_date(1)
          ,IL_Main_Fields.InvalidMessage_filing_time(1)
          ,IL_Main_Fields.InvalidMessage_filing_status(1)
          ,IL_Main_Fields.InvalidMessage_status_type(1)
          ,IL_Main_Fields.InvalidMessage_page(1)
          ,IL_Main_Fields.InvalidMessage_expiration_date(1)
          ,IL_Main_Fields.InvalidMessage_contract_type(1)
          ,IL_Main_Fields.InvalidMessage_vendor_entry_date(1)
          ,IL_Main_Fields.InvalidMessage_vendor_upd_date(1)
          ,IL_Main_Fields.InvalidMessage_statements_filed(1)
          ,IL_Main_Fields.InvalidMessage_continuious_expiration(1)
          ,IL_Main_Fields.InvalidMessage_microfilm_number(1)
          ,IL_Main_Fields.InvalidMessage_amount(1)
          ,IL_Main_Fields.InvalidMessage_irs_serial_number(1)
          ,IL_Main_Fields.InvalidMessage_effective_date(1)
          ,IL_Main_Fields.InvalidMessage_signer_name(1)
          ,IL_Main_Fields.InvalidMessage_title(1)
          ,IL_Main_Fields.InvalidMessage_filing_agency(1)
          ,IL_Main_Fields.InvalidMessage_address(1)
          ,IL_Main_Fields.InvalidMessage_city(1)
          ,IL_Main_Fields.InvalidMessage_state(1)
          ,IL_Main_Fields.InvalidMessage_county(1)
          ,IL_Main_Fields.InvalidMessage_zip(1)
          ,IL_Main_Fields.InvalidMessage_duns_number(1)
          ,IL_Main_Fields.InvalidMessage_cmnt_effective_date(1)
          ,IL_Main_Fields.InvalidMessage_description(1)
          ,IL_Main_Fields.InvalidMessage_prim_machine(1)
          ,IL_Main_Fields.InvalidMessage_sec_machine(1)
          ,IL_Main_Fields.InvalidMessage_manufacturer_code(1)
          ,IL_Main_Fields.InvalidMessage_manufacturer_name(1)
          ,IL_Main_Fields.InvalidMessage_model(1)
          ,IL_Main_Fields.InvalidMessage_model_year(1)
          ,IL_Main_Fields.InvalidMessage_model_desc(1)
          ,IL_Main_Fields.InvalidMessage_collateral_count(1)
          ,IL_Main_Fields.InvalidMessage_manufactured_year(1)
          ,IL_Main_Fields.InvalidMessage_new_used(1)
          ,IL_Main_Fields.InvalidMessage_serial_number(1)
          ,IL_Main_Fields.InvalidMessage_property_desc(1)
          ,IL_Main_Fields.InvalidMessage_borough(1)
          ,IL_Main_Fields.InvalidMessage_block(1)
          ,IL_Main_Fields.InvalidMessage_collateral_address(1)
          ,IL_Main_Fields.InvalidMessage_air_rights_indc(1)
          ,IL_Main_Fields.InvalidMessage_subterranean_rights_indc(1)
          ,IL_Main_Fields.InvalidMessage_easment_indc(1)
          ,IL_Main_Fields.InvalidMessage_volume(1)
          ,IL_Main_Fields.InvalidMessage_persistent_record_id(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.filing_jurisdiction_ENUM_ErrorCount
          ,le.orig_filing_number_CUSTOM_ErrorCount
          ,le.orig_filing_type_CUSTOM_ErrorCount
          ,le.orig_filing_date_CUSTOM_ErrorCount
          ,le.orig_filing_time_CUSTOM_ErrorCount
          ,le.filing_number_CUSTOM_ErrorCount
          ,le.filing_type_CUSTOM_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.filing_time_CUSTOM_ErrorCount
          ,le.filing_status_LENGTHS_ErrorCount
          ,le.status_type_LENGTHS_ErrorCount
          ,le.page_ALLOW_ErrorCount
          ,le.expiration_date_CUSTOM_ErrorCount
          ,le.contract_type_LENGTHS_ErrorCount
          ,le.vendor_entry_date_LENGTHS_ErrorCount
          ,le.vendor_upd_date_LENGTHS_ErrorCount
          ,le.statements_filed_ALLOW_ErrorCount
          ,le.continuious_expiration_ENUM_ErrorCount
          ,le.microfilm_number_LENGTHS_ErrorCount
          ,le.amount_LENGTHS_ErrorCount
          ,le.irs_serial_number_LENGTHS_ErrorCount
          ,le.effective_date_LENGTHS_ErrorCount
          ,le.signer_name_LENGTHS_ErrorCount
          ,le.title_LENGTHS_ErrorCount
          ,le.filing_agency_LENGTHS_ErrorCount
          ,le.address_LENGTHS_ErrorCount
          ,le.city_LENGTHS_ErrorCount
          ,le.state_LENGTHS_ErrorCount
          ,le.county_LENGTHS_ErrorCount
          ,le.zip_LENGTHS_ErrorCount
          ,le.duns_number_LENGTHS_ErrorCount
          ,le.cmnt_effective_date_LENGTHS_ErrorCount
          ,le.description_LENGTHS_ErrorCount
          ,le.prim_machine_LENGTHS_ErrorCount
          ,le.sec_machine_LENGTHS_ErrorCount
          ,le.manufacturer_code_LENGTHS_ErrorCount
          ,le.manufacturer_name_LENGTHS_ErrorCount
          ,le.model_LENGTHS_ErrorCount
          ,le.model_year_LENGTHS_ErrorCount
          ,le.model_desc_LENGTHS_ErrorCount
          ,le.collateral_count_LENGTHS_ErrorCount
          ,le.manufactured_year_LENGTHS_ErrorCount
          ,le.new_used_LENGTHS_ErrorCount
          ,le.serial_number_LENGTHS_ErrorCount
          ,le.property_desc_LENGTHS_ErrorCount
          ,le.borough_LENGTHS_ErrorCount
          ,le.block_LENGTHS_ErrorCount
          ,le.collateral_address_LENGTHS_ErrorCount
          ,le.air_rights_indc_LENGTHS_ErrorCount
          ,le.subterranean_rights_indc_LENGTHS_ErrorCount
          ,le.easment_indc_LENGTHS_ErrorCount
          ,le.volume_LENGTHS_ErrorCount
          ,le.persistent_record_id_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.filing_jurisdiction_ENUM_ErrorCount
          ,le.orig_filing_number_CUSTOM_ErrorCount
          ,le.orig_filing_type_CUSTOM_ErrorCount
          ,le.orig_filing_date_CUSTOM_ErrorCount
          ,le.orig_filing_time_CUSTOM_ErrorCount
          ,le.filing_number_CUSTOM_ErrorCount
          ,le.filing_type_CUSTOM_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.filing_time_CUSTOM_ErrorCount
          ,le.filing_status_LENGTHS_ErrorCount
          ,le.status_type_LENGTHS_ErrorCount
          ,le.page_ALLOW_ErrorCount
          ,le.expiration_date_CUSTOM_ErrorCount
          ,le.contract_type_LENGTHS_ErrorCount
          ,le.vendor_entry_date_LENGTHS_ErrorCount
          ,le.vendor_upd_date_LENGTHS_ErrorCount
          ,le.statements_filed_ALLOW_ErrorCount
          ,le.continuious_expiration_ENUM_ErrorCount
          ,le.microfilm_number_LENGTHS_ErrorCount
          ,le.amount_LENGTHS_ErrorCount
          ,le.irs_serial_number_LENGTHS_ErrorCount
          ,le.effective_date_LENGTHS_ErrorCount
          ,le.signer_name_LENGTHS_ErrorCount
          ,le.title_LENGTHS_ErrorCount
          ,le.filing_agency_LENGTHS_ErrorCount
          ,le.address_LENGTHS_ErrorCount
          ,le.city_LENGTHS_ErrorCount
          ,le.state_LENGTHS_ErrorCount
          ,le.county_LENGTHS_ErrorCount
          ,le.zip_LENGTHS_ErrorCount
          ,le.duns_number_LENGTHS_ErrorCount
          ,le.cmnt_effective_date_LENGTHS_ErrorCount
          ,le.description_LENGTHS_ErrorCount
          ,le.prim_machine_LENGTHS_ErrorCount
          ,le.sec_machine_LENGTHS_ErrorCount
          ,le.manufacturer_code_LENGTHS_ErrorCount
          ,le.manufacturer_name_LENGTHS_ErrorCount
          ,le.model_LENGTHS_ErrorCount
          ,le.model_year_LENGTHS_ErrorCount
          ,le.model_desc_LENGTHS_ErrorCount
          ,le.collateral_count_LENGTHS_ErrorCount
          ,le.manufactured_year_LENGTHS_ErrorCount
          ,le.new_used_LENGTHS_ErrorCount
          ,le.serial_number_LENGTHS_ErrorCount
          ,le.property_desc_LENGTHS_ErrorCount
          ,le.borough_LENGTHS_ErrorCount
          ,le.block_LENGTHS_ErrorCount
          ,le.collateral_address_LENGTHS_ErrorCount
          ,le.air_rights_indc_LENGTHS_ErrorCount
          ,le.subterranean_rights_indc_LENGTHS_ErrorCount
          ,le.easment_indc_LENGTHS_ErrorCount
          ,le.volume_LENGTHS_ErrorCount
          ,le.persistent_record_id_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := IL_Main_hygiene(PROJECT(h, IL_Main_Layout_UCCV2));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'tmsid:' + getFieldTypeText(h.tmsid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rmsid:' + getFieldTypeText(h.rmsid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'static_value:' + getFieldTypeText(h.static_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_removed:' + getFieldTypeText(h.date_vendor_removed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_changed:' + getFieldTypeText(h.date_vendor_changed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_jurisdiction:' + getFieldTypeText(h.filing_jurisdiction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_filing_number:' + getFieldTypeText(h.orig_filing_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_filing_type:' + getFieldTypeText(h.orig_filing_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_filing_date:' + getFieldTypeText(h.orig_filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_filing_time:' + getFieldTypeText(h.orig_filing_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_number:' + getFieldTypeText(h.filing_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_number_indc:' + getFieldTypeText(h.filing_number_indc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_type:' + getFieldTypeText(h.filing_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_date:' + getFieldTypeText(h.filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_time:' + getFieldTypeText(h.filing_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_status:' + getFieldTypeText(h.filing_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status_type:' + getFieldTypeText(h.status_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'page:' + getFieldTypeText(h.page) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'expiration_date:' + getFieldTypeText(h.expiration_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contract_type:' + getFieldTypeText(h.contract_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_entry_date:' + getFieldTypeText(h.vendor_entry_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_upd_date:' + getFieldTypeText(h.vendor_upd_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statements_filed:' + getFieldTypeText(h.statements_filed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'continuious_expiration:' + getFieldTypeText(h.continuious_expiration) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'microfilm_number:' + getFieldTypeText(h.microfilm_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amount:' + getFieldTypeText(h.amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'irs_serial_number:' + getFieldTypeText(h.irs_serial_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'effective_date:' + getFieldTypeText(h.effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'signer_name:' + getFieldTypeText(h.signer_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_agency:' + getFieldTypeText(h.filing_agency) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duns_number:' + getFieldTypeText(h.duns_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cmnt_effective_date:' + getFieldTypeText(h.cmnt_effective_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'description:' + getFieldTypeText(h.description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'collateral_desc:' + getFieldTypeText(h.collateral_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_machine:' + getFieldTypeText(h.prim_machine) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_machine:' + getFieldTypeText(h.sec_machine) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manufacturer_code:' + getFieldTypeText(h.manufacturer_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manufacturer_name:' + getFieldTypeText(h.manufacturer_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model:' + getFieldTypeText(h.model) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_year:' + getFieldTypeText(h.model_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'model_desc:' + getFieldTypeText(h.model_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'collateral_count:' + getFieldTypeText(h.collateral_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manufactured_year:' + getFieldTypeText(h.manufactured_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'new_used:' + getFieldTypeText(h.new_used) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'serial_number:' + getFieldTypeText(h.serial_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'property_desc:' + getFieldTypeText(h.property_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'borough:' + getFieldTypeText(h.borough) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'block:' + getFieldTypeText(h.block) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'collateral_address:' + getFieldTypeText(h.collateral_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'air_rights_indc:' + getFieldTypeText(h.air_rights_indc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'subterranean_rights_indc:' + getFieldTypeText(h.subterranean_rights_indc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'easment_indc:' + getFieldTypeText(h.easment_indc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'volume:' + getFieldTypeText(h.volume) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_tmsid_cnt
          ,le.populated_rmsid_cnt
          ,le.populated_process_date_cnt
          ,le.populated_static_value_cnt
          ,le.populated_date_vendor_removed_cnt
          ,le.populated_date_vendor_changed_cnt
          ,le.populated_filing_jurisdiction_cnt
          ,le.populated_orig_filing_number_cnt
          ,le.populated_orig_filing_type_cnt
          ,le.populated_orig_filing_date_cnt
          ,le.populated_orig_filing_time_cnt
          ,le.populated_filing_number_cnt
          ,le.populated_filing_number_indc_cnt
          ,le.populated_filing_type_cnt
          ,le.populated_filing_date_cnt
          ,le.populated_filing_time_cnt
          ,le.populated_filing_status_cnt
          ,le.populated_status_type_cnt
          ,le.populated_page_cnt
          ,le.populated_expiration_date_cnt
          ,le.populated_contract_type_cnt
          ,le.populated_vendor_entry_date_cnt
          ,le.populated_vendor_upd_date_cnt
          ,le.populated_statements_filed_cnt
          ,le.populated_continuious_expiration_cnt
          ,le.populated_microfilm_number_cnt
          ,le.populated_amount_cnt
          ,le.populated_irs_serial_number_cnt
          ,le.populated_effective_date_cnt
          ,le.populated_signer_name_cnt
          ,le.populated_title_cnt
          ,le.populated_filing_agency_cnt
          ,le.populated_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_county_cnt
          ,le.populated_zip_cnt
          ,le.populated_duns_number_cnt
          ,le.populated_cmnt_effective_date_cnt
          ,le.populated_description_cnt
          ,le.populated_collateral_desc_cnt
          ,le.populated_prim_machine_cnt
          ,le.populated_sec_machine_cnt
          ,le.populated_manufacturer_code_cnt
          ,le.populated_manufacturer_name_cnt
          ,le.populated_model_cnt
          ,le.populated_model_year_cnt
          ,le.populated_model_desc_cnt
          ,le.populated_collateral_count_cnt
          ,le.populated_manufactured_year_cnt
          ,le.populated_new_used_cnt
          ,le.populated_serial_number_cnt
          ,le.populated_property_desc_cnt
          ,le.populated_borough_cnt
          ,le.populated_block_cnt
          ,le.populated_lot_cnt
          ,le.populated_collateral_address_cnt
          ,le.populated_air_rights_indc_cnt
          ,le.populated_subterranean_rights_indc_cnt
          ,le.populated_easment_indc_cnt
          ,le.populated_volume_cnt
          ,le.populated_persistent_record_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_tmsid_pcnt
          ,le.populated_rmsid_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_static_value_pcnt
          ,le.populated_date_vendor_removed_pcnt
          ,le.populated_date_vendor_changed_pcnt
          ,le.populated_filing_jurisdiction_pcnt
          ,le.populated_orig_filing_number_pcnt
          ,le.populated_orig_filing_type_pcnt
          ,le.populated_orig_filing_date_pcnt
          ,le.populated_orig_filing_time_pcnt
          ,le.populated_filing_number_pcnt
          ,le.populated_filing_number_indc_pcnt
          ,le.populated_filing_type_pcnt
          ,le.populated_filing_date_pcnt
          ,le.populated_filing_time_pcnt
          ,le.populated_filing_status_pcnt
          ,le.populated_status_type_pcnt
          ,le.populated_page_pcnt
          ,le.populated_expiration_date_pcnt
          ,le.populated_contract_type_pcnt
          ,le.populated_vendor_entry_date_pcnt
          ,le.populated_vendor_upd_date_pcnt
          ,le.populated_statements_filed_pcnt
          ,le.populated_continuious_expiration_pcnt
          ,le.populated_microfilm_number_pcnt
          ,le.populated_amount_pcnt
          ,le.populated_irs_serial_number_pcnt
          ,le.populated_effective_date_pcnt
          ,le.populated_signer_name_pcnt
          ,le.populated_title_pcnt
          ,le.populated_filing_agency_pcnt
          ,le.populated_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_county_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_duns_number_pcnt
          ,le.populated_cmnt_effective_date_pcnt
          ,le.populated_description_pcnt
          ,le.populated_collateral_desc_pcnt
          ,le.populated_prim_machine_pcnt
          ,le.populated_sec_machine_pcnt
          ,le.populated_manufacturer_code_pcnt
          ,le.populated_manufacturer_name_pcnt
          ,le.populated_model_pcnt
          ,le.populated_model_year_pcnt
          ,le.populated_model_desc_pcnt
          ,le.populated_collateral_count_pcnt
          ,le.populated_manufactured_year_pcnt
          ,le.populated_new_used_pcnt
          ,le.populated_serial_number_pcnt
          ,le.populated_property_desc_pcnt
          ,le.populated_borough_pcnt
          ,le.populated_block_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_collateral_address_pcnt
          ,le.populated_air_rights_indc_pcnt
          ,le.populated_subterranean_rights_indc_pcnt
          ,le.populated_easment_indc_pcnt
          ,le.populated_volume_pcnt
          ,le.populated_persistent_record_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,62,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := IL_Main_Delta(prevDS, PROJECT(h, IL_Main_Layout_UCCV2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),62,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(IL_Main_Layout_UCCV2) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_UCCV2, IL_Main_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
