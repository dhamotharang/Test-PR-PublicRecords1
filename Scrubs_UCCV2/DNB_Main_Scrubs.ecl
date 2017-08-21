IMPORT SALT37;
IMPORT Scrubs_UCCV2,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT DNB_Main_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(DNB_Main_Layout_UCCV2)
    UNSIGNED1 tmsid_Invalid;
    UNSIGNED1 rmsid_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 static_value_Invalid;
    UNSIGNED1 date_vendor_removed_Invalid;
    UNSIGNED1 date_vendor_changed_Invalid;
    UNSIGNED1 filing_jurisdiction_Invalid;
    UNSIGNED1 orig_filing_number_Invalid;
    UNSIGNED1 orig_filing_type_Invalid;
    UNSIGNED1 orig_filing_date_Invalid;
    UNSIGNED1 orig_filing_time_Invalid;
    UNSIGNED1 filing_number_Invalid;
    UNSIGNED1 filing_number_indc_Invalid;
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
    UNSIGNED1 prim_machine_Invalid;
    UNSIGNED1 sec_machine_Invalid;
    UNSIGNED1 manufacturer_name_Invalid;
    UNSIGNED1 model_Invalid;
    UNSIGNED1 model_year_Invalid;
    UNSIGNED1 collateral_count_Invalid;
    UNSIGNED1 manufactured_year_Invalid;
    UNSIGNED1 new_used_Invalid;
    UNSIGNED1 collateral_address_Invalid;
    UNSIGNED1 air_rights_indc_Invalid;
    UNSIGNED1 subterranean_rights_indc_Invalid;
    UNSIGNED1 easment_indc_Invalid;
    UNSIGNED1 volume_Invalid;
    UNSIGNED1 persistent_record_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(DNB_Main_Layout_UCCV2)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(DNB_Main_Layout_UCCV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.tmsid_Invalid := DNB_Main_Fields.InValid_tmsid((SALT37.StrType)le.tmsid);
    SELF.rmsid_Invalid := DNB_Main_Fields.InValid_rmsid((SALT37.StrType)le.rmsid);
    SELF.process_date_Invalid := DNB_Main_Fields.InValid_process_date((SALT37.StrType)le.process_date);
    SELF.static_value_Invalid := DNB_Main_Fields.InValid_static_value((SALT37.StrType)le.static_value);
    SELF.date_vendor_removed_Invalid := DNB_Main_Fields.InValid_date_vendor_removed((SALT37.StrType)le.date_vendor_removed);
    SELF.date_vendor_changed_Invalid := DNB_Main_Fields.InValid_date_vendor_changed((SALT37.StrType)le.date_vendor_changed);
    SELF.filing_jurisdiction_Invalid := DNB_Main_Fields.InValid_filing_jurisdiction((SALT37.StrType)le.filing_jurisdiction);
    SELF.orig_filing_number_Invalid := DNB_Main_Fields.InValid_orig_filing_number((SALT37.StrType)le.orig_filing_number);
    SELF.orig_filing_type_Invalid := DNB_Main_Fields.InValid_orig_filing_type((SALT37.StrType)le.orig_filing_type);
    SELF.orig_filing_date_Invalid := DNB_Main_Fields.InValid_orig_filing_date((SALT37.StrType)le.orig_filing_date);
    SELF.orig_filing_time_Invalid := DNB_Main_Fields.InValid_orig_filing_time((SALT37.StrType)le.orig_filing_time);
    SELF.filing_number_Invalid := DNB_Main_Fields.InValid_filing_number((SALT37.StrType)le.filing_number);
    SELF.filing_number_indc_Invalid := DNB_Main_Fields.InValid_filing_number_indc((SALT37.StrType)le.filing_number_indc);
    SELF.filing_type_Invalid := DNB_Main_Fields.InValid_filing_type((SALT37.StrType)le.filing_type);
    SELF.filing_date_Invalid := DNB_Main_Fields.InValid_filing_date((SALT37.StrType)le.filing_date);
    SELF.filing_time_Invalid := DNB_Main_Fields.InValid_filing_time((SALT37.StrType)le.filing_time);
    SELF.filing_status_Invalid := DNB_Main_Fields.InValid_filing_status((SALT37.StrType)le.filing_status);
    SELF.status_type_Invalid := DNB_Main_Fields.InValid_status_type((SALT37.StrType)le.status_type);
    SELF.page_Invalid := DNB_Main_Fields.InValid_page((SALT37.StrType)le.page);
    SELF.expiration_date_Invalid := DNB_Main_Fields.InValid_expiration_date((SALT37.StrType)le.expiration_date);
    SELF.contract_type_Invalid := DNB_Main_Fields.InValid_contract_type((SALT37.StrType)le.contract_type);
    SELF.vendor_entry_date_Invalid := DNB_Main_Fields.InValid_vendor_entry_date((SALT37.StrType)le.vendor_entry_date);
    SELF.vendor_upd_date_Invalid := DNB_Main_Fields.InValid_vendor_upd_date((SALT37.StrType)le.vendor_upd_date);
    SELF.statements_filed_Invalid := DNB_Main_Fields.InValid_statements_filed((SALT37.StrType)le.statements_filed);
    SELF.continuious_expiration_Invalid := DNB_Main_Fields.InValid_continuious_expiration((SALT37.StrType)le.continuious_expiration);
    SELF.microfilm_number_Invalid := DNB_Main_Fields.InValid_microfilm_number((SALT37.StrType)le.microfilm_number);
    SELF.amount_Invalid := DNB_Main_Fields.InValid_amount((SALT37.StrType)le.amount);
    SELF.irs_serial_number_Invalid := DNB_Main_Fields.InValid_irs_serial_number((SALT37.StrType)le.irs_serial_number);
    SELF.effective_date_Invalid := DNB_Main_Fields.InValid_effective_date((SALT37.StrType)le.effective_date);
    SELF.signer_name_Invalid := DNB_Main_Fields.InValid_signer_name((SALT37.StrType)le.signer_name);
    SELF.title_Invalid := DNB_Main_Fields.InValid_title((SALT37.StrType)le.title);
    SELF.filing_agency_Invalid := DNB_Main_Fields.InValid_filing_agency((SALT37.StrType)le.filing_agency);
    SELF.address_Invalid := DNB_Main_Fields.InValid_address((SALT37.StrType)le.address);
    SELF.city_Invalid := DNB_Main_Fields.InValid_city((SALT37.StrType)le.city);
    SELF.state_Invalid := DNB_Main_Fields.InValid_state((SALT37.StrType)le.state);
    SELF.county_Invalid := DNB_Main_Fields.InValid_county((SALT37.StrType)le.county);
    SELF.zip_Invalid := DNB_Main_Fields.InValid_zip((SALT37.StrType)le.zip);
    SELF.duns_number_Invalid := DNB_Main_Fields.InValid_duns_number((SALT37.StrType)le.duns_number);
    SELF.cmnt_effective_date_Invalid := DNB_Main_Fields.InValid_cmnt_effective_date((SALT37.StrType)le.cmnt_effective_date);
    SELF.prim_machine_Invalid := DNB_Main_Fields.InValid_prim_machine((SALT37.StrType)le.prim_machine);
    SELF.sec_machine_Invalid := DNB_Main_Fields.InValid_sec_machine((SALT37.StrType)le.sec_machine);
    SELF.manufacturer_name_Invalid := DNB_Main_Fields.InValid_manufacturer_name((SALT37.StrType)le.manufacturer_name);
    SELF.model_Invalid := DNB_Main_Fields.InValid_model((SALT37.StrType)le.model);
    SELF.model_year_Invalid := DNB_Main_Fields.InValid_model_year((SALT37.StrType)le.model_year);
    SELF.collateral_count_Invalid := DNB_Main_Fields.InValid_collateral_count((SALT37.StrType)le.collateral_count);
    SELF.manufactured_year_Invalid := DNB_Main_Fields.InValid_manufactured_year((SALT37.StrType)le.manufactured_year);
    SELF.new_used_Invalid := DNB_Main_Fields.InValid_new_used((SALT37.StrType)le.new_used);
    SELF.collateral_address_Invalid := DNB_Main_Fields.InValid_collateral_address((SALT37.StrType)le.collateral_address);
    SELF.air_rights_indc_Invalid := DNB_Main_Fields.InValid_air_rights_indc((SALT37.StrType)le.air_rights_indc);
    SELF.subterranean_rights_indc_Invalid := DNB_Main_Fields.InValid_subterranean_rights_indc((SALT37.StrType)le.subterranean_rights_indc);
    SELF.easment_indc_Invalid := DNB_Main_Fields.InValid_easment_indc((SALT37.StrType)le.easment_indc);
    SELF.volume_Invalid := DNB_Main_Fields.InValid_volume((SALT37.StrType)le.volume);
    SELF.persistent_record_id_Invalid := DNB_Main_Fields.InValid_persistent_record_id((SALT37.StrType)le.persistent_record_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DNB_Main_Layout_UCCV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.tmsid_Invalid << 0 ) + ( le.rmsid_Invalid << 1 ) + ( le.process_date_Invalid << 2 ) + ( le.static_value_Invalid << 4 ) + ( le.date_vendor_removed_Invalid << 5 ) + ( le.date_vendor_changed_Invalid << 6 ) + ( le.filing_jurisdiction_Invalid << 7 ) + ( le.orig_filing_number_Invalid << 8 ) + ( le.orig_filing_type_Invalid << 10 ) + ( le.orig_filing_date_Invalid << 11 ) + ( le.orig_filing_time_Invalid << 12 ) + ( le.filing_number_Invalid << 13 ) + ( le.filing_number_indc_Invalid << 14 ) + ( le.filing_type_Invalid << 15 ) + ( le.filing_date_Invalid << 16 ) + ( le.filing_time_Invalid << 17 ) + ( le.filing_status_Invalid << 18 ) + ( le.status_type_Invalid << 19 ) + ( le.page_Invalid << 20 ) + ( le.expiration_date_Invalid << 21 ) + ( le.contract_type_Invalid << 22 ) + ( le.vendor_entry_date_Invalid << 23 ) + ( le.vendor_upd_date_Invalid << 25 ) + ( le.statements_filed_Invalid << 27 ) + ( le.continuious_expiration_Invalid << 28 ) + ( le.microfilm_number_Invalid << 29 ) + ( le.amount_Invalid << 30 ) + ( le.irs_serial_number_Invalid << 31 ) + ( le.effective_date_Invalid << 32 ) + ( le.signer_name_Invalid << 33 ) + ( le.title_Invalid << 35 ) + ( le.filing_agency_Invalid << 37 ) + ( le.address_Invalid << 38 ) + ( le.city_Invalid << 40 ) + ( le.state_Invalid << 41 ) + ( le.county_Invalid << 42 ) + ( le.zip_Invalid << 43 ) + ( le.duns_number_Invalid << 44 ) + ( le.cmnt_effective_date_Invalid << 45 ) + ( le.prim_machine_Invalid << 47 ) + ( le.sec_machine_Invalid << 49 ) + ( le.manufacturer_name_Invalid << 51 ) + ( le.model_Invalid << 53 ) + ( le.model_year_Invalid << 55 ) + ( le.collateral_count_Invalid << 57 ) + ( le.manufactured_year_Invalid << 58 ) + ( le.new_used_Invalid << 59 ) + ( le.collateral_address_Invalid << 60 ) + ( le.air_rights_indc_Invalid << 61 ) + ( le.subterranean_rights_indc_Invalid << 62 ) + ( le.easment_indc_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.volume_Invalid << 0 ) + ( le.persistent_record_id_Invalid << 1 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DNB_Main_Layout_UCCV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.tmsid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.rmsid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.static_value_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.date_vendor_removed_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_vendor_changed_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.filing_jurisdiction_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orig_filing_number_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.orig_filing_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_filing_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_filing_time_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.filing_number_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.filing_number_indc_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.filing_type_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.filing_date_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.filing_time_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.filing_status_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.status_type_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.page_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.expiration_date_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.contract_type_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.vendor_entry_date_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.vendor_upd_date_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.statements_filed_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.continuious_expiration_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.microfilm_number_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.amount_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.irs_serial_number_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.effective_date_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.signer_name_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.title_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.filing_agency_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.duns_number_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.cmnt_effective_date_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.prim_machine_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.sec_machine_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.manufacturer_name_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.model_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.model_year_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.collateral_count_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.manufactured_year_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.new_used_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.collateral_address_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.air_rights_indc_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.subterranean_rights_indc_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.easment_indc_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.volume_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits2 >> 1) & 1;
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
    static_value_LENGTH_ErrorCount := COUNT(GROUP,h.static_value_Invalid=1);
    date_vendor_removed_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_removed_Invalid=1);
    date_vendor_changed_LENGTH_ErrorCount := COUNT(GROUP,h.date_vendor_changed_Invalid=1);
    filing_jurisdiction_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_jurisdiction_Invalid=1);
    orig_filing_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_filing_number_Invalid=1);
    orig_filing_number_LENGTH_ErrorCount := COUNT(GROUP,h.orig_filing_number_Invalid=2);
    orig_filing_number_Total_ErrorCount := COUNT(GROUP,h.orig_filing_number_Invalid>0);
    orig_filing_type_LENGTH_ErrorCount := COUNT(GROUP,h.orig_filing_type_Invalid=1);
    orig_filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_filing_date_Invalid=1);
    orig_filing_time_LENGTH_ErrorCount := COUNT(GROUP,h.orig_filing_time_Invalid=1);
    filing_number_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_number_Invalid=1);
    filing_number_indc_LENGTH_ErrorCount := COUNT(GROUP,h.filing_number_indc_Invalid=1);
    filing_type_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_type_Invalid=1);
    filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=1);
    filing_time_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_time_Invalid=1);
    filing_status_LENGTH_ErrorCount := COUNT(GROUP,h.filing_status_Invalid=1);
    status_type_LENGTH_ErrorCount := COUNT(GROUP,h.status_type_Invalid=1);
    page_ALLOW_ErrorCount := COUNT(GROUP,h.page_Invalid=1);
    expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.expiration_date_Invalid=1);
    contract_type_CUSTOM_ErrorCount := COUNT(GROUP,h.contract_type_Invalid=1);
    vendor_entry_date_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid=1);
    vendor_entry_date_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid=2);
    vendor_entry_date_Total_ErrorCount := COUNT(GROUP,h.vendor_entry_date_Invalid>0);
    vendor_upd_date_CUSTOM_ErrorCount := COUNT(GROUP,h.vendor_upd_date_Invalid=1);
    vendor_upd_date_LENGTH_ErrorCount := COUNT(GROUP,h.vendor_upd_date_Invalid=2);
    vendor_upd_date_Total_ErrorCount := COUNT(GROUP,h.vendor_upd_date_Invalid>0);
    statements_filed_LENGTH_ErrorCount := COUNT(GROUP,h.statements_filed_Invalid=1);
    continuious_expiration_LENGTH_ErrorCount := COUNT(GROUP,h.continuious_expiration_Invalid=1);
    microfilm_number_LENGTH_ErrorCount := COUNT(GROUP,h.microfilm_number_Invalid=1);
    amount_LENGTH_ErrorCount := COUNT(GROUP,h.amount_Invalid=1);
    irs_serial_number_LENGTH_ErrorCount := COUNT(GROUP,h.irs_serial_number_Invalid=1);
    effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.effective_date_Invalid=1);
    signer_name_ALLOW_ErrorCount := COUNT(GROUP,h.signer_name_Invalid=1);
    signer_name_LENGTH_ErrorCount := COUNT(GROUP,h.signer_name_Invalid=2);
    signer_name_Total_ErrorCount := COUNT(GROUP,h.signer_name_Invalid>0);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    title_LENGTH_ErrorCount := COUNT(GROUP,h.title_Invalid=2);
    title_Total_ErrorCount := COUNT(GROUP,h.title_Invalid>0);
    filing_agency_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_agency_Invalid=1);
    address_ALLOW_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    address_LENGTH_ErrorCount := COUNT(GROUP,h.address_Invalid=2);
    address_Total_ErrorCount := COUNT(GROUP,h.address_Invalid>0);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    duns_number_CUSTOM_ErrorCount := COUNT(GROUP,h.duns_number_Invalid=1);
    cmnt_effective_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cmnt_effective_date_Invalid=1);
    cmnt_effective_date_LENGTH_ErrorCount := COUNT(GROUP,h.cmnt_effective_date_Invalid=2);
    cmnt_effective_date_Total_ErrorCount := COUNT(GROUP,h.cmnt_effective_date_Invalid>0);
    prim_machine_ALLOW_ErrorCount := COUNT(GROUP,h.prim_machine_Invalid=1);
    prim_machine_LENGTH_ErrorCount := COUNT(GROUP,h.prim_machine_Invalid=2);
    prim_machine_Total_ErrorCount := COUNT(GROUP,h.prim_machine_Invalid>0);
    sec_machine_ALLOW_ErrorCount := COUNT(GROUP,h.sec_machine_Invalid=1);
    sec_machine_LENGTH_ErrorCount := COUNT(GROUP,h.sec_machine_Invalid=2);
    sec_machine_Total_ErrorCount := COUNT(GROUP,h.sec_machine_Invalid>0);
    manufacturer_name_ALLOW_ErrorCount := COUNT(GROUP,h.manufacturer_name_Invalid=1);
    manufacturer_name_LENGTH_ErrorCount := COUNT(GROUP,h.manufacturer_name_Invalid=2);
    manufacturer_name_Total_ErrorCount := COUNT(GROUP,h.manufacturer_name_Invalid>0);
    model_ALLOW_ErrorCount := COUNT(GROUP,h.model_Invalid=1);
    model_LENGTH_ErrorCount := COUNT(GROUP,h.model_Invalid=2);
    model_Total_ErrorCount := COUNT(GROUP,h.model_Invalid>0);
    model_year_CUSTOM_ErrorCount := COUNT(GROUP,h.model_year_Invalid=1);
    model_year_LENGTH_ErrorCount := COUNT(GROUP,h.model_year_Invalid=2);
    model_year_Total_ErrorCount := COUNT(GROUP,h.model_year_Invalid>0);
    collateral_count_CUSTOM_ErrorCount := COUNT(GROUP,h.collateral_count_Invalid=1);
    manufactured_year_CUSTOM_ErrorCount := COUNT(GROUP,h.manufactured_year_Invalid=1);
    new_used_ENUM_ErrorCount := COUNT(GROUP,h.new_used_Invalid=1);
    collateral_address_LENGTH_ErrorCount := COUNT(GROUP,h.collateral_address_Invalid=1);
    air_rights_indc_LENGTH_ErrorCount := COUNT(GROUP,h.air_rights_indc_Invalid=1);
    subterranean_rights_indc_LENGTH_ErrorCount := COUNT(GROUP,h.subterranean_rights_indc_Invalid=1);
    easment_indc_LENGTH_ErrorCount := COUNT(GROUP,h.easment_indc_Invalid=1);
    volume_LENGTH_ErrorCount := COUNT(GROUP,h.volume_Invalid=1);
    persistent_record_id_CUSTOM_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.tmsid_Invalid,le.rmsid_Invalid,le.process_date_Invalid,le.static_value_Invalid,le.date_vendor_removed_Invalid,le.date_vendor_changed_Invalid,le.filing_jurisdiction_Invalid,le.orig_filing_number_Invalid,le.orig_filing_type_Invalid,le.orig_filing_date_Invalid,le.orig_filing_time_Invalid,le.filing_number_Invalid,le.filing_number_indc_Invalid,le.filing_type_Invalid,le.filing_date_Invalid,le.filing_time_Invalid,le.filing_status_Invalid,le.status_type_Invalid,le.page_Invalid,le.expiration_date_Invalid,le.contract_type_Invalid,le.vendor_entry_date_Invalid,le.vendor_upd_date_Invalid,le.statements_filed_Invalid,le.continuious_expiration_Invalid,le.microfilm_number_Invalid,le.amount_Invalid,le.irs_serial_number_Invalid,le.effective_date_Invalid,le.signer_name_Invalid,le.title_Invalid,le.filing_agency_Invalid,le.address_Invalid,le.city_Invalid,le.state_Invalid,le.county_Invalid,le.zip_Invalid,le.duns_number_Invalid,le.cmnt_effective_date_Invalid,le.prim_machine_Invalid,le.sec_machine_Invalid,le.manufacturer_name_Invalid,le.model_Invalid,le.model_year_Invalid,le.collateral_count_Invalid,le.manufactured_year_Invalid,le.new_used_Invalid,le.collateral_address_Invalid,le.air_rights_indc_Invalid,le.subterranean_rights_indc_Invalid,le.easment_indc_Invalid,le.volume_Invalid,le.persistent_record_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DNB_Main_Fields.InvalidMessage_tmsid(le.tmsid_Invalid),DNB_Main_Fields.InvalidMessage_rmsid(le.rmsid_Invalid),DNB_Main_Fields.InvalidMessage_process_date(le.process_date_Invalid),DNB_Main_Fields.InvalidMessage_static_value(le.static_value_Invalid),DNB_Main_Fields.InvalidMessage_date_vendor_removed(le.date_vendor_removed_Invalid),DNB_Main_Fields.InvalidMessage_date_vendor_changed(le.date_vendor_changed_Invalid),DNB_Main_Fields.InvalidMessage_filing_jurisdiction(le.filing_jurisdiction_Invalid),DNB_Main_Fields.InvalidMessage_orig_filing_number(le.orig_filing_number_Invalid),DNB_Main_Fields.InvalidMessage_orig_filing_type(le.orig_filing_type_Invalid),DNB_Main_Fields.InvalidMessage_orig_filing_date(le.orig_filing_date_Invalid),DNB_Main_Fields.InvalidMessage_orig_filing_time(le.orig_filing_time_Invalid),DNB_Main_Fields.InvalidMessage_filing_number(le.filing_number_Invalid),DNB_Main_Fields.InvalidMessage_filing_number_indc(le.filing_number_indc_Invalid),DNB_Main_Fields.InvalidMessage_filing_type(le.filing_type_Invalid),DNB_Main_Fields.InvalidMessage_filing_date(le.filing_date_Invalid),DNB_Main_Fields.InvalidMessage_filing_time(le.filing_time_Invalid),DNB_Main_Fields.InvalidMessage_filing_status(le.filing_status_Invalid),DNB_Main_Fields.InvalidMessage_status_type(le.status_type_Invalid),DNB_Main_Fields.InvalidMessage_page(le.page_Invalid),DNB_Main_Fields.InvalidMessage_expiration_date(le.expiration_date_Invalid),DNB_Main_Fields.InvalidMessage_contract_type(le.contract_type_Invalid),DNB_Main_Fields.InvalidMessage_vendor_entry_date(le.vendor_entry_date_Invalid),DNB_Main_Fields.InvalidMessage_vendor_upd_date(le.vendor_upd_date_Invalid),DNB_Main_Fields.InvalidMessage_statements_filed(le.statements_filed_Invalid),DNB_Main_Fields.InvalidMessage_continuious_expiration(le.continuious_expiration_Invalid),DNB_Main_Fields.InvalidMessage_microfilm_number(le.microfilm_number_Invalid),DNB_Main_Fields.InvalidMessage_amount(le.amount_Invalid),DNB_Main_Fields.InvalidMessage_irs_serial_number(le.irs_serial_number_Invalid),DNB_Main_Fields.InvalidMessage_effective_date(le.effective_date_Invalid),DNB_Main_Fields.InvalidMessage_signer_name(le.signer_name_Invalid),DNB_Main_Fields.InvalidMessage_title(le.title_Invalid),DNB_Main_Fields.InvalidMessage_filing_agency(le.filing_agency_Invalid),DNB_Main_Fields.InvalidMessage_address(le.address_Invalid),DNB_Main_Fields.InvalidMessage_city(le.city_Invalid),DNB_Main_Fields.InvalidMessage_state(le.state_Invalid),DNB_Main_Fields.InvalidMessage_county(le.county_Invalid),DNB_Main_Fields.InvalidMessage_zip(le.zip_Invalid),DNB_Main_Fields.InvalidMessage_duns_number(le.duns_number_Invalid),DNB_Main_Fields.InvalidMessage_cmnt_effective_date(le.cmnt_effective_date_Invalid),DNB_Main_Fields.InvalidMessage_prim_machine(le.prim_machine_Invalid),DNB_Main_Fields.InvalidMessage_sec_machine(le.sec_machine_Invalid),DNB_Main_Fields.InvalidMessage_manufacturer_name(le.manufacturer_name_Invalid),DNB_Main_Fields.InvalidMessage_model(le.model_Invalid),DNB_Main_Fields.InvalidMessage_model_year(le.model_year_Invalid),DNB_Main_Fields.InvalidMessage_collateral_count(le.collateral_count_Invalid),DNB_Main_Fields.InvalidMessage_manufactured_year(le.manufactured_year_Invalid),DNB_Main_Fields.InvalidMessage_new_used(le.new_used_Invalid),DNB_Main_Fields.InvalidMessage_collateral_address(le.collateral_address_Invalid),DNB_Main_Fields.InvalidMessage_air_rights_indc(le.air_rights_indc_Invalid),DNB_Main_Fields.InvalidMessage_subterranean_rights_indc(le.subterranean_rights_indc_Invalid),DNB_Main_Fields.InvalidMessage_easment_indc(le.easment_indc_Invalid),DNB_Main_Fields.InvalidMessage_volume(le.volume_Invalid),DNB_Main_Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.tmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.rmsid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.static_value_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_removed_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.date_vendor_changed_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_jurisdiction_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_filing_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_filing_time_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_number_indc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_time_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.filing_status_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.status_type_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.page_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expiration_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.contract_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_entry_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.vendor_upd_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.statements_filed_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.continuious_expiration_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.microfilm_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.amount_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.irs_serial_number_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.effective_date_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.signer_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.filing_agency_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.duns_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cmnt_effective_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.prim_machine_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sec_machine_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.manufacturer_name_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.model_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.model_year_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.collateral_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.manufactured_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.new_used_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.collateral_address_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.air_rights_indc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.subterranean_rights_indc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.easment_indc_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.volume_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'tmsid','rmsid','process_date','static_value','date_vendor_removed','date_vendor_changed','filing_jurisdiction','orig_filing_number','orig_filing_type','orig_filing_date','orig_filing_time','filing_number','filing_number_indc','filing_type','filing_date','filing_time','filing_status','status_type','page','expiration_date','contract_type','vendor_entry_date','vendor_upd_date','statements_filed','continuious_expiration','microfilm_number','amount','irs_serial_number','effective_date','signer_name','title','filing_agency','address','city','state','county','zip','duns_number','cmnt_effective_date','prim_machine','sec_machine','manufacturer_name','model','model_year','collateral_count','manufactured_year','new_used','collateral_address','air_rights_indc','subterranean_rights_indc','easment_indc','volume','persistent_record_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_tmsid','invalid_rmsid','invalid_8pastdate','invalid_empty','invalid_empty','invalid_empty','invalid_filing_jurisdiction','invalid_wordbag','invalid_empty','invalid_orig_filing_date','invalid_empty','invalid_mandatory','invalid_empty','invalid_filing_type','invalid_filing_date','invalid_filing_time','invalid_empty','invalid_empty','invalid_numeric_blank','invalid_expiration_date','invalid_contract_type','invalid_8pastdate','invalid_pastyear','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_wordbag','invalid_wordbag','invalid_mandatory','invalid_wordbag','invalid_alpha_num_specials','invalid_state','invalid_alpha_num_specials','invalid_zip_code59','invalid_duns_number','invalid_8pastdate','invalid_wordbag','invalid_wordbag','invalid_wordbag','invalid_wordbag','invalid_pastyear','invalid_collateral_count','invalid_manufactured_year','invalid_new_used','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT37.StrType)le.tmsid,(SALT37.StrType)le.rmsid,(SALT37.StrType)le.process_date,(SALT37.StrType)le.static_value,(SALT37.StrType)le.date_vendor_removed,(SALT37.StrType)le.date_vendor_changed,(SALT37.StrType)le.filing_jurisdiction,(SALT37.StrType)le.orig_filing_number,(SALT37.StrType)le.orig_filing_type,(SALT37.StrType)le.orig_filing_date,(SALT37.StrType)le.orig_filing_time,(SALT37.StrType)le.filing_number,(SALT37.StrType)le.filing_number_indc,(SALT37.StrType)le.filing_type,(SALT37.StrType)le.filing_date,(SALT37.StrType)le.filing_time,(SALT37.StrType)le.filing_status,(SALT37.StrType)le.status_type,(SALT37.StrType)le.page,(SALT37.StrType)le.expiration_date,(SALT37.StrType)le.contract_type,(SALT37.StrType)le.vendor_entry_date,(SALT37.StrType)le.vendor_upd_date,(SALT37.StrType)le.statements_filed,(SALT37.StrType)le.continuious_expiration,(SALT37.StrType)le.microfilm_number,(SALT37.StrType)le.amount,(SALT37.StrType)le.irs_serial_number,(SALT37.StrType)le.effective_date,(SALT37.StrType)le.signer_name,(SALT37.StrType)le.title,(SALT37.StrType)le.filing_agency,(SALT37.StrType)le.address,(SALT37.StrType)le.city,(SALT37.StrType)le.state,(SALT37.StrType)le.county,(SALT37.StrType)le.zip,(SALT37.StrType)le.duns_number,(SALT37.StrType)le.cmnt_effective_date,(SALT37.StrType)le.prim_machine,(SALT37.StrType)le.sec_machine,(SALT37.StrType)le.manufacturer_name,(SALT37.StrType)le.model,(SALT37.StrType)le.model_year,(SALT37.StrType)le.collateral_count,(SALT37.StrType)le.manufactured_year,(SALT37.StrType)le.new_used,(SALT37.StrType)le.collateral_address,(SALT37.StrType)le.air_rights_indc,(SALT37.StrType)le.subterranean_rights_indc,(SALT37.StrType)le.easment_indc,(SALT37.StrType)le.volume,(SALT37.StrType)le.persistent_record_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,53,Into(LEFT,COUNTER));
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
          ,'static_value:invalid_empty:LENGTH'
          ,'date_vendor_removed:invalid_empty:LENGTH'
          ,'date_vendor_changed:invalid_empty:LENGTH'
          ,'filing_jurisdiction:invalid_filing_jurisdiction:CUSTOM'
          ,'orig_filing_number:invalid_wordbag:ALLOW','orig_filing_number:invalid_wordbag:LENGTH'
          ,'orig_filing_type:invalid_empty:LENGTH'
          ,'orig_filing_date:invalid_orig_filing_date:CUSTOM'
          ,'orig_filing_time:invalid_empty:LENGTH'
          ,'filing_number:invalid_mandatory:CUSTOM'
          ,'filing_number_indc:invalid_empty:LENGTH'
          ,'filing_type:invalid_filing_type:CUSTOM'
          ,'filing_date:invalid_filing_date:CUSTOM'
          ,'filing_time:invalid_filing_time:CUSTOM'
          ,'filing_status:invalid_empty:LENGTH'
          ,'status_type:invalid_empty:LENGTH'
          ,'page:invalid_numeric_blank:ALLOW'
          ,'expiration_date:invalid_expiration_date:CUSTOM'
          ,'contract_type:invalid_contract_type:CUSTOM'
          ,'vendor_entry_date:invalid_8pastdate:CUSTOM','vendor_entry_date:invalid_8pastdate:LENGTH'
          ,'vendor_upd_date:invalid_pastyear:CUSTOM','vendor_upd_date:invalid_pastyear:LENGTH'
          ,'statements_filed:invalid_empty:LENGTH'
          ,'continuious_expiration:invalid_empty:LENGTH'
          ,'microfilm_number:invalid_empty:LENGTH'
          ,'amount:invalid_empty:LENGTH'
          ,'irs_serial_number:invalid_empty:LENGTH'
          ,'effective_date:invalid_empty:LENGTH'
          ,'signer_name:invalid_wordbag:ALLOW','signer_name:invalid_wordbag:LENGTH'
          ,'title:invalid_wordbag:ALLOW','title:invalid_wordbag:LENGTH'
          ,'filing_agency:invalid_mandatory:CUSTOM'
          ,'address:invalid_wordbag:ALLOW','address:invalid_wordbag:LENGTH'
          ,'city:invalid_alpha_num_specials:ALLOW'
          ,'state:invalid_state:CUSTOM'
          ,'county:invalid_alpha_num_specials:ALLOW'
          ,'zip:invalid_zip_code59:CUSTOM'
          ,'duns_number:invalid_duns_number:CUSTOM'
          ,'cmnt_effective_date:invalid_8pastdate:CUSTOM','cmnt_effective_date:invalid_8pastdate:LENGTH'
          ,'prim_machine:invalid_wordbag:ALLOW','prim_machine:invalid_wordbag:LENGTH'
          ,'sec_machine:invalid_wordbag:ALLOW','sec_machine:invalid_wordbag:LENGTH'
          ,'manufacturer_name:invalid_wordbag:ALLOW','manufacturer_name:invalid_wordbag:LENGTH'
          ,'model:invalid_wordbag:ALLOW','model:invalid_wordbag:LENGTH'
          ,'model_year:invalid_pastyear:CUSTOM','model_year:invalid_pastyear:LENGTH'
          ,'collateral_count:invalid_collateral_count:CUSTOM'
          ,'manufactured_year:invalid_manufactured_year:CUSTOM'
          ,'new_used:invalid_new_used:ENUM'
          ,'collateral_address:invalid_empty:LENGTH'
          ,'air_rights_indc:invalid_empty:LENGTH'
          ,'subterranean_rights_indc:invalid_empty:LENGTH'
          ,'easment_indc:invalid_empty:LENGTH'
          ,'volume:invalid_empty:LENGTH'
          ,'persistent_record_id:invalid_mandatory:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DNB_Main_Fields.InvalidMessage_tmsid(1)
          ,DNB_Main_Fields.InvalidMessage_rmsid(1)
          ,DNB_Main_Fields.InvalidMessage_process_date(1),DNB_Main_Fields.InvalidMessage_process_date(2)
          ,DNB_Main_Fields.InvalidMessage_static_value(1)
          ,DNB_Main_Fields.InvalidMessage_date_vendor_removed(1)
          ,DNB_Main_Fields.InvalidMessage_date_vendor_changed(1)
          ,DNB_Main_Fields.InvalidMessage_filing_jurisdiction(1)
          ,DNB_Main_Fields.InvalidMessage_orig_filing_number(1),DNB_Main_Fields.InvalidMessage_orig_filing_number(2)
          ,DNB_Main_Fields.InvalidMessage_orig_filing_type(1)
          ,DNB_Main_Fields.InvalidMessage_orig_filing_date(1)
          ,DNB_Main_Fields.InvalidMessage_orig_filing_time(1)
          ,DNB_Main_Fields.InvalidMessage_filing_number(1)
          ,DNB_Main_Fields.InvalidMessage_filing_number_indc(1)
          ,DNB_Main_Fields.InvalidMessage_filing_type(1)
          ,DNB_Main_Fields.InvalidMessage_filing_date(1)
          ,DNB_Main_Fields.InvalidMessage_filing_time(1)
          ,DNB_Main_Fields.InvalidMessage_filing_status(1)
          ,DNB_Main_Fields.InvalidMessage_status_type(1)
          ,DNB_Main_Fields.InvalidMessage_page(1)
          ,DNB_Main_Fields.InvalidMessage_expiration_date(1)
          ,DNB_Main_Fields.InvalidMessage_contract_type(1)
          ,DNB_Main_Fields.InvalidMessage_vendor_entry_date(1),DNB_Main_Fields.InvalidMessage_vendor_entry_date(2)
          ,DNB_Main_Fields.InvalidMessage_vendor_upd_date(1),DNB_Main_Fields.InvalidMessage_vendor_upd_date(2)
          ,DNB_Main_Fields.InvalidMessage_statements_filed(1)
          ,DNB_Main_Fields.InvalidMessage_continuious_expiration(1)
          ,DNB_Main_Fields.InvalidMessage_microfilm_number(1)
          ,DNB_Main_Fields.InvalidMessage_amount(1)
          ,DNB_Main_Fields.InvalidMessage_irs_serial_number(1)
          ,DNB_Main_Fields.InvalidMessage_effective_date(1)
          ,DNB_Main_Fields.InvalidMessage_signer_name(1),DNB_Main_Fields.InvalidMessage_signer_name(2)
          ,DNB_Main_Fields.InvalidMessage_title(1),DNB_Main_Fields.InvalidMessage_title(2)
          ,DNB_Main_Fields.InvalidMessage_filing_agency(1)
          ,DNB_Main_Fields.InvalidMessage_address(1),DNB_Main_Fields.InvalidMessage_address(2)
          ,DNB_Main_Fields.InvalidMessage_city(1)
          ,DNB_Main_Fields.InvalidMessage_state(1)
          ,DNB_Main_Fields.InvalidMessage_county(1)
          ,DNB_Main_Fields.InvalidMessage_zip(1)
          ,DNB_Main_Fields.InvalidMessage_duns_number(1)
          ,DNB_Main_Fields.InvalidMessage_cmnt_effective_date(1),DNB_Main_Fields.InvalidMessage_cmnt_effective_date(2)
          ,DNB_Main_Fields.InvalidMessage_prim_machine(1),DNB_Main_Fields.InvalidMessage_prim_machine(2)
          ,DNB_Main_Fields.InvalidMessage_sec_machine(1),DNB_Main_Fields.InvalidMessage_sec_machine(2)
          ,DNB_Main_Fields.InvalidMessage_manufacturer_name(1),DNB_Main_Fields.InvalidMessage_manufacturer_name(2)
          ,DNB_Main_Fields.InvalidMessage_model(1),DNB_Main_Fields.InvalidMessage_model(2)
          ,DNB_Main_Fields.InvalidMessage_model_year(1),DNB_Main_Fields.InvalidMessage_model_year(2)
          ,DNB_Main_Fields.InvalidMessage_collateral_count(1)
          ,DNB_Main_Fields.InvalidMessage_manufactured_year(1)
          ,DNB_Main_Fields.InvalidMessage_new_used(1)
          ,DNB_Main_Fields.InvalidMessage_collateral_address(1)
          ,DNB_Main_Fields.InvalidMessage_air_rights_indc(1)
          ,DNB_Main_Fields.InvalidMessage_subterranean_rights_indc(1)
          ,DNB_Main_Fields.InvalidMessage_easment_indc(1)
          ,DNB_Main_Fields.InvalidMessage_volume(1)
          ,DNB_Main_Fields.InvalidMessage_persistent_record_id(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.static_value_LENGTH_ErrorCount
          ,le.date_vendor_removed_LENGTH_ErrorCount
          ,le.date_vendor_changed_LENGTH_ErrorCount
          ,le.filing_jurisdiction_CUSTOM_ErrorCount
          ,le.orig_filing_number_ALLOW_ErrorCount,le.orig_filing_number_LENGTH_ErrorCount
          ,le.orig_filing_type_LENGTH_ErrorCount
          ,le.orig_filing_date_CUSTOM_ErrorCount
          ,le.orig_filing_time_LENGTH_ErrorCount
          ,le.filing_number_CUSTOM_ErrorCount
          ,le.filing_number_indc_LENGTH_ErrorCount
          ,le.filing_type_CUSTOM_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.filing_time_CUSTOM_ErrorCount
          ,le.filing_status_LENGTH_ErrorCount
          ,le.status_type_LENGTH_ErrorCount
          ,le.page_ALLOW_ErrorCount
          ,le.expiration_date_CUSTOM_ErrorCount
          ,le.contract_type_CUSTOM_ErrorCount
          ,le.vendor_entry_date_CUSTOM_ErrorCount,le.vendor_entry_date_LENGTH_ErrorCount
          ,le.vendor_upd_date_CUSTOM_ErrorCount,le.vendor_upd_date_LENGTH_ErrorCount
          ,le.statements_filed_LENGTH_ErrorCount
          ,le.continuious_expiration_LENGTH_ErrorCount
          ,le.microfilm_number_LENGTH_ErrorCount
          ,le.amount_LENGTH_ErrorCount
          ,le.irs_serial_number_LENGTH_ErrorCount
          ,le.effective_date_LENGTH_ErrorCount
          ,le.signer_name_ALLOW_ErrorCount,le.signer_name_LENGTH_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount
          ,le.filing_agency_CUSTOM_ErrorCount
          ,le.address_ALLOW_ErrorCount,le.address_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.duns_number_CUSTOM_ErrorCount
          ,le.cmnt_effective_date_CUSTOM_ErrorCount,le.cmnt_effective_date_LENGTH_ErrorCount
          ,le.prim_machine_ALLOW_ErrorCount,le.prim_machine_LENGTH_ErrorCount
          ,le.sec_machine_ALLOW_ErrorCount,le.sec_machine_LENGTH_ErrorCount
          ,le.manufacturer_name_ALLOW_ErrorCount,le.manufacturer_name_LENGTH_ErrorCount
          ,le.model_ALLOW_ErrorCount,le.model_LENGTH_ErrorCount
          ,le.model_year_CUSTOM_ErrorCount,le.model_year_LENGTH_ErrorCount
          ,le.collateral_count_CUSTOM_ErrorCount
          ,le.manufactured_year_CUSTOM_ErrorCount
          ,le.new_used_ENUM_ErrorCount
          ,le.collateral_address_LENGTH_ErrorCount
          ,le.air_rights_indc_LENGTH_ErrorCount
          ,le.subterranean_rights_indc_LENGTH_ErrorCount
          ,le.easment_indc_LENGTH_ErrorCount
          ,le.volume_LENGTH_ErrorCount
          ,le.persistent_record_id_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.tmsid_CUSTOM_ErrorCount
          ,le.rmsid_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.static_value_LENGTH_ErrorCount
          ,le.date_vendor_removed_LENGTH_ErrorCount
          ,le.date_vendor_changed_LENGTH_ErrorCount
          ,le.filing_jurisdiction_CUSTOM_ErrorCount
          ,le.orig_filing_number_ALLOW_ErrorCount,le.orig_filing_number_LENGTH_ErrorCount
          ,le.orig_filing_type_LENGTH_ErrorCount
          ,le.orig_filing_date_CUSTOM_ErrorCount
          ,le.orig_filing_time_LENGTH_ErrorCount
          ,le.filing_number_CUSTOM_ErrorCount
          ,le.filing_number_indc_LENGTH_ErrorCount
          ,le.filing_type_CUSTOM_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.filing_time_CUSTOM_ErrorCount
          ,le.filing_status_LENGTH_ErrorCount
          ,le.status_type_LENGTH_ErrorCount
          ,le.page_ALLOW_ErrorCount
          ,le.expiration_date_CUSTOM_ErrorCount
          ,le.contract_type_CUSTOM_ErrorCount
          ,le.vendor_entry_date_CUSTOM_ErrorCount,le.vendor_entry_date_LENGTH_ErrorCount
          ,le.vendor_upd_date_CUSTOM_ErrorCount,le.vendor_upd_date_LENGTH_ErrorCount
          ,le.statements_filed_LENGTH_ErrorCount
          ,le.continuious_expiration_LENGTH_ErrorCount
          ,le.microfilm_number_LENGTH_ErrorCount
          ,le.amount_LENGTH_ErrorCount
          ,le.irs_serial_number_LENGTH_ErrorCount
          ,le.effective_date_LENGTH_ErrorCount
          ,le.signer_name_ALLOW_ErrorCount,le.signer_name_LENGTH_ErrorCount
          ,le.title_ALLOW_ErrorCount,le.title_LENGTH_ErrorCount
          ,le.filing_agency_CUSTOM_ErrorCount
          ,le.address_ALLOW_ErrorCount,le.address_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.duns_number_CUSTOM_ErrorCount
          ,le.cmnt_effective_date_CUSTOM_ErrorCount,le.cmnt_effective_date_LENGTH_ErrorCount
          ,le.prim_machine_ALLOW_ErrorCount,le.prim_machine_LENGTH_ErrorCount
          ,le.sec_machine_ALLOW_ErrorCount,le.sec_machine_LENGTH_ErrorCount
          ,le.manufacturer_name_ALLOW_ErrorCount,le.manufacturer_name_LENGTH_ErrorCount
          ,le.model_ALLOW_ErrorCount,le.model_LENGTH_ErrorCount
          ,le.model_year_CUSTOM_ErrorCount,le.model_year_LENGTH_ErrorCount
          ,le.collateral_count_CUSTOM_ErrorCount
          ,le.manufactured_year_CUSTOM_ErrorCount
          ,le.new_used_ENUM_ErrorCount
          ,le.collateral_address_LENGTH_ErrorCount
          ,le.air_rights_indc_LENGTH_ErrorCount
          ,le.subterranean_rights_indc_LENGTH_ErrorCount
          ,le.easment_indc_LENGTH_ErrorCount
          ,le.volume_LENGTH_ErrorCount
          ,le.persistent_record_id_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,66,Into(LEFT,COUNTER));
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
