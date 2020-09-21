//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OSHAIR.Accident_Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_OSHAIR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_OSHAIR.Accident_Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* summary_nr_field */,/* report_id_field */,/* event_date_time_field */,/* const_end_use_field */,/* build_stories_field */,/* nonbuild_ht_field */,/* project_cost_field */,/* project_type_field */,/* sic_list_field */,/* fatality_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
