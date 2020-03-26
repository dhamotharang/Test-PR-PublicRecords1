//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Cortera_Tradeline.BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Cortera_Tradeline,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Cortera_Tradeline.MAC_PopulationStatistics(Cortera_Tradeline.In_Tradeline,/*Reference Field*/,/* link_id_field */,/* account_key_field */,/* segment_id_field */,/* ar_date_field */,/* total_ar_field */,/* current_ar_field */,/* aging_1to30_field */,/* aging_31to60_field */,/* aging_61to90_field */,/* aging_91plus_field */,/* credit_limit_field */,/* first_sale_date_field */,/* last_sale_date_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
