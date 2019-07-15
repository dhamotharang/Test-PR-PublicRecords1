//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Inql_Nfcra_Bridger.BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_Inql_Nfcra_Bridger,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Inql_Nfcra_Bridger.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* datetime_field */,/* customer_id_field */,/* search_function_name_field */,/* entity_type_field */,/* field1_field */,/* field2_field */,/* field3_field */,/* field4_field */,/* field5_field */,/* field6_field */,/* field7_field */,/* field8_field */,/* field9_field */,/* field10_field */,/* field11_field */,/* field12_field */,/* field13_field */,/* field14_field */,/* field15_field */,/* field16_field */,/* id__field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
