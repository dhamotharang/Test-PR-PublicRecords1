//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_CityStateZip.BWR_PopulationStatistics - Population Statistics - SALT V3.11.0');
IMPORT Scrubs_CityStateZip,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_CityStateZip.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* zip5_field */,/* zipclass_field */,/* city_field */,/* state_field */,/* county_field */,/* prefctystname_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
