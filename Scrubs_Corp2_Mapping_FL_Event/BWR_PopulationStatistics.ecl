//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_FL_Event.BWR_PopulationStatistics - Population Statistics - SALT V3.2.0RC1');
IMPORT Scrubs_Corp2_Mapping_FL_Event,SALT32;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Mapping_FL_Event.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* corp_key_field */,/* corp_sos_charter_nbr_field */,/* event_revocation_comment1_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
