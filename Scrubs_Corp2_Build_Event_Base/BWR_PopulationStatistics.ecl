//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Build_Event_Base.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT Scrubs_Corp2_Build_Event_Base,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Build_Event_Base.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* bdid_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* corp_key_field */,/* corp_supp_key_field */,/* corp_vendor_field */,/* corp_vendor_county_field */,/* corp_vendor_subcode_field */,/* corp_state_origin_field */,/* corp_process_date_field */,/* corp_sos_charter_nbr_field */,/* event_filing_reference_nbr_field */,/* event_amendment_nbr_field */,/* event_filing_date_field */,/* event_date_type_cd_field */,/* event_date_type_desc_field */,/* event_filing_cd_field */,/* event_filing_desc_field */,/* event_corp_nbr_field */,/* event_corp_nbr_cd_field */,/* event_corp_nbr_desc_field */,/* event_roll_field */,/* event_frame_field */,/* event_start_field */,/* event_end_field */,/* event_microfilm_nbr_field */,/* event_desc_field */,/* record_type_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
