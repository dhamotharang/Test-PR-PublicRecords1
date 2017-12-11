//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTNKeys.license_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_SANCTNKeys,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_SANCTNKeys.license_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* batch_number_field */,/* incident_number_field */,/* party_number_field */,/* record_type_field */,/* order_number_field */,/* license_number_field */,/* license_type_field */,/* license_state_field */,/* cln_license_number_field */,/* std_type_desc_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
