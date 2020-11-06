//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_eCrash_MBSAgency.BWR_PopulationStatistics - Population Statistics - SALT V3.7.0');
IMPORT Scrubs_eCrash_MBSAgency,SALT37;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_eCrash_MBSAgency.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* agency_id_field */,/* agency_name_field */,/* source_id_field */,/* agency_state_abbr_field */,/* agency_ori_field */,/* allow_open_search_field */,/* append_overwrite_flag_field */,/* drivers_exchange_flag_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
