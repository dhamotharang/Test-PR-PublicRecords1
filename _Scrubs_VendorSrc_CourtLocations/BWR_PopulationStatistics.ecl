//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','_Scrubs_VendorSrc_CourtLocations.BWR_PopulationStatistics - Population Statistics - SALT V3.11.6');
IMPORT _Scrubs_VendorSrc_CourtLocations,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  _Scrubs_VendorSrc_CourtLocations.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* fipscode_field */,/* statefips_field */,/* countyfips_field */,/* courtid_field */,/* consolidatedcourtid_field */,/* masterid_field */,/* stateofservice_field */,/* countyofservice_field */,/* courtname_field */,/* phone_field */,/* address1_field */,/* address2_field */,/* city_field */,/* state_field */,/* zipcode_field */,/* zip4_field */,/* mailaddress1_field */,/* mailaddress2_field */,/* mailcity_field */,/* mailctate_field */,/* mailzipcode_field */,/* mailzip4_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
