//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OSHAIR.Violation_Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_OSHAIR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_OSHAIR.Violation_Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* activity_nr_field */,/* citation_id_field */,/* delete_flag_field */,/* viol_type_field */,/* issuance_date_field */,/* abate_date_field */,/* current_penalty_field */,/* initial_penalty_field */,/* contest_date_field */,/* final_order_date_field */,/* nr_instances_field */,/* nr_exposed_field */,/* rec_field */,/* gravity_field */,/* emphasis_field */,/* hazcat_field */,/* fta_insp_nr_field */,/* fta_issuance_date_field */,/* fta_penalty_field */,/* fta_contest_date_field */,/* fta_final_order_date_field */,/* hazsub1_field */,/* hazsub2_field */,/* hazsub3_field */,/* hazsub4_field */,/* hazsub5_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
