//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE); 
#workunit('name','Scrubs_Corp2_Mapping_WA_Main.BWR_PopulationStatistics - Population Statistics - SALT V3.4.3');
IMPORT Scrubs_Corp2_Mapping_WA_Main,SALT34;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Mapping_WA_Main.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* corp_ra_dt_first_seen_field */,/* corp_ra_dt_last_seen_field */,/* corp_process_date_field */,/* corp_inc_date_field */,/* corp_forgn_date_field */,/* corp_dissolved_date_field */,/* corp_merger_date_field */,/* corp_key_field */,/* corp_orig_sos_charter_nbr_field */,/* corp_vendor_field */,/* corp_state_origin_field */,/* corp_legal_name_field */,/* corp_inc_state_field */,/* corp_forgn_state_desc_field */,/* corp_foreign_domestic_ind_field */,/* corp_for_profit_ind_field */,/* corp_ln_name_type_cd_field */,/* corp_ln_name_type_desc_field */,/* corp_orig_org_structure_cd_field */,/* corp_orig_org_structure_desc_field */,/* corp_status_desc_field */,/* corp_merger_desc_field */,/* cont_title1_desc_field */,/* recordorigin_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
