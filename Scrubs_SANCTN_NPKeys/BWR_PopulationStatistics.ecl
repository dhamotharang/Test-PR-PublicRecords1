//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_SANCTN_NPKeys.BWR_PopulationStatistics - Population Statistics - SALT V3.3.2');
IMPORT Scrubs_SANCTN_NPKeys,SALT33;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_SANCTN_NPKeys.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*dbcode Field*/,/* batch_field */,/* dbcode_field */,/* primary_key_field */,/* foreign_key_field */,/* incident_num_field */,/* number_field */,/* field_name_field */,/* code_type_field */,/* code_value_field */,/* code_state_field */,/* other_desc_field */,/* std_type_desc_field */,/* cln_license_number_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
