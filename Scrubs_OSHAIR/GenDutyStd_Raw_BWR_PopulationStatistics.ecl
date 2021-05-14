//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OSHAIR.GenDutyStd_Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_OSHAIR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_OSHAIR.GenDutyStd_Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* activity_nr_field */,/* citation_id_field */,/* line_nr_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
