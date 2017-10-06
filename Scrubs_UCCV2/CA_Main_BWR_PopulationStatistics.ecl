﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_UCCV2.CA_Main_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_UCCV2,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_UCCV2.CA_Main_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* tmsid_field */,/* rmsid_field */,/* process_date_field */,/* static_value_field */,/* date_vendor_removed_field */,/* date_vendor_changed_field */,/* filing_jurisdiction_field */,/* orig_filing_number_field */,/* orig_filing_type_field */,/* orig_filing_date_field */,/* orig_filing_time_field */,/* filing_number_field */,/* filing_number_indc_field */,/* filing_type_field */,/* filing_date_field */,/* filing_time_field */,/* filing_status_field */,/* status_type_field */,/* page_field */,/* expiration_date_field */,/* contract_type_field */,/* vendor_entry_date_field */,/* vendor_upd_date_field */,/* statements_filed_field */,/* continuious_expiration_field */,/* microfilm_number_field */,/* amount_field */,/* irs_serial_number_field */,/* effective_date_field */,/* signer_name_field */,/* title_field */,/* filing_agency_field */,/* address_field */,/* city_field */,/* state_field */,/* county_field */,/* zip_field */,/* duns_number_field */,/* cmnt_effective_date_field */,/* description_field */,/* collateral_desc_field */,/* prim_machine_field */,/* sec_machine_field */,/* manufacturer_code_field */,/* manufacturer_name_field */,/* model_field */,/* model_year_field */,/* model_desc_field */,/* collateral_count_field */,/* manufactured_year_field */,/* new_used_field */,/* serial_number_field */,/* property_desc_field */,/* borough_field */,/* block_field */,/* lot_field */,/* collateral_address_field */,/* air_rights_indc_field */,/* subterranean_rights_indc_field */,/* easment_indc_field */,/* volume_field */,/* persistent_record_id_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
