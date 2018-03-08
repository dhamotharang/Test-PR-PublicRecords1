//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Voters.Base_History_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_Voters,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Voters.Base_History_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* vtid_field */,/* voted_year_field */,/* primary_field */,/* special_1_field */,/* other_field */,/* special_2_field */,/* general_field */,/* pres_field */,/* vote_date_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
