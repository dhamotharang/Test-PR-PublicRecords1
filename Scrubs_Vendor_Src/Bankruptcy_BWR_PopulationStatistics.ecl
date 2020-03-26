//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Vendor_Src.Bankruptcy_BWR_PopulationStatistics - Population Statistics - SALT V3.11.6');
IMPORT Scrubs_Vendor_Src,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Vendor_Src.Bankruptcy_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* lncourtcode_field */,/* court_code_field */,/* court_name_field */,/* address1_field */,/* address2_field */,/* city_field */,/* state_field */,/* zip_field */,/* phone_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
