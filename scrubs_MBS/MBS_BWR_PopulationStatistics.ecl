//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.MBS_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_MBS.MBS_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* fdn_file_info_id_field */,/* fdn_file_code_field */,/* gc_id_field */,/* file_type_field */,/* description_field */,/* primary_source_entity_field */,/* ind_type_field */,/* update_freq_field */,/* expiration_days_field */,/* post_contract_expiration_days_field */,/* status_field */,/* product_include_field */,/* expectation_of_victim_entities_field */,/* suspected_discrepancy_field */,/* confidence_that_activity_was_deceitful_field */,/* workflow_stage_committed_field */,/* workflow_stage_detected_field */,/* channels_field */,/* threat_field */,/* alert_level_field */,/* entity_type_field */,/* entity_sub_type_field */,/* role_field */,/* evidence_field */,/* date_added_field */,/* user_added_field */,/* date_changed_field */,/* user_changed_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
