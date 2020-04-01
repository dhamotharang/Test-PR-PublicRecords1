//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTN_NPKeys.party_aka_dba_BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_SANCTN_NPKeys,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_SANCTN_NPKeys.party_aka_dba_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*dbcode Field*/,/* batch_field */,/* dbcode_field */,/* incident_num_field */,/* party_num_field */,/* name_type_field */,/* first_name_field */,/* middle_name_field */,/* last_name_field */,/* aka_dba_text_field */,/* party_key_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
