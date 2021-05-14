//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.addresshistory_BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_Crim,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Crim.addresshistory_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*vendor Field*/,/* recordid_field */,/* statecode_field */,/* street_field */,/* unit_field */,/* city_field */,/* orig_state_field */,/* orig_zip_field */,/* addresstype_field */,/* sourcename_field */,/* sourceid_field */,/* vendor_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
