//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Suppress.New_BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_Suppress,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Suppress.New_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* product_field */,/* linking_type_field */,/* linking_id_field */,/* document_type_field */,/* document_id_field */,/* date_added_field */,/* user_field */,/* compliance_id_field */,/* comment_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
