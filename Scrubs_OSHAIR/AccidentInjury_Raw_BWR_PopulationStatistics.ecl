//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OSHAIR.AccidentInjury_Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_OSHAIR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_OSHAIR.AccidentInjury_Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* summary_nr_field */,/* rel_insp_nr_field */,/* age_field */,/* sex_field */,/* nature_of_inj_field */,/* part_of_body_field */,/* src_of_injury_field */,/* event_type_field */,/* evn_factor_field */,/* hum_factor_field */,/* occ_code_field */,/* degree_of_inj_field */,/* task_assigned_field */,/* hazsub_field */,/* const_op_field */,/* const_op_cause_field */,/* fat_cause_field */,/* fall_distance_field */,/* fall_ht_field */,/* injury_line_nr_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
