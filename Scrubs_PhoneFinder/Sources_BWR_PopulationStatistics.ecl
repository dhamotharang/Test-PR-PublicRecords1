//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhoneFinder.Sources_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_PhoneFinder,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhoneFinder.Sources_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* auto_id_field */,/* transaction_id_field */,/* phonenumber_field */,/* lexid_field */,/* phone_id_field */,/* identity_id_field */,/* sequence_number_field */,/* totalsourcecount_field */,/* date_added_field */,/* filename_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
