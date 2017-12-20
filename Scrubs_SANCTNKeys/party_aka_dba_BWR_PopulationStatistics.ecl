//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTNKeys.party_aka_dba_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_SANCTNKeys,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_SANCTNKeys.party_aka_dba_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* batch_number_field */,/* incident_number_field */,/* party_number_field */,/* record_type_field */,/* order_number_field */,/* name_type_field */,/* last_name_field */,/* first_name_field */,/* middle_name_field */,/* aka_dba_text_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
