//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_AZ_Event.BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_Corp2_Mapping_AZ_Event,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Mapping_AZ_Event.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* corp_key_field */,/* corp_sos_charter_nbr_field */,/* event_date_type_cd_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
