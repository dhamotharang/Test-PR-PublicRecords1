//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DL_TN_WDL.BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_DL_TN_WDL,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DL_TN_WDL.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* process_date_field */,/* dl_number_field */,/* action_code_field */,/* event_date_field */,/* last_name_field */,/* birthdate_field */,/* post_date_field */,/* county_code_field */,/* action_type_field */,/* filler_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
