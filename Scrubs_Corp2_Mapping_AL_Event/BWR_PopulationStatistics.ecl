//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Corp2_Mapping_AL_Event.BWR_PopulationStatistics - Population Statistics - SALT V3.2.0RC1');
IMPORT Scrubs_Corp2_Mapping_AL_Event,SALT32;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Corp2_Mapping_AL_Event.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* event_filing_cd_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
