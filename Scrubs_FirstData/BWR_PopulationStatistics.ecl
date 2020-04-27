//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FirstData.BWR_PopulationStatistics - Population Statistics - SALT V3.11.6');
IMPORT Scrubs_FirstData,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FirstData.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* process_date_field */,/* filedate_field */,/* record_type_field */,/* action_code_field */,/* cons_id_field */,/* dl_state_field */,/* dl_id_field */,/* first_seen_date_true_field */,/* last_seen_date_field */,/* dispute_status_field */,/* lex_id_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
