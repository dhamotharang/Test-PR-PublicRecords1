//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_MBS.IndTypeExclusion_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_MBS,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_MBS.IndTypeExclusion_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* fdn_file_ind_type_exclusion_id_field */,/* fdn_file_info_id_field */,/* ind_type_field */,/* status_field */,/* date_added_field */,/* user_added_field */,/* date_changed_field */,/* user_changed_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
