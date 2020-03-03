//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Crim.alias_counties_BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_Crim,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Crim.alias_counties_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*vendor Field*/,/* recordid_field */,/* statecode_field */,/* akaname_field */,/* akalastname_field */,/* akafirstname_field */,/* akamiddlename_field */,/* akasuffix_field */,/* akadob_field */,/* sourcename_field */,/* vendor_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
