//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_RealSource.BWR_PopulationStatistics - Population Statistics - SALT V3.8.2');
IMPORT Scrubs_RealSource,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_RealSource.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* firstname_field */,/* middleinit_field */,/* lastname_field */,/* suffix_field */,/* address_field */,/* city_field */,/* state_field */,/* zipcode_field */,/* zipplus4_field */,/* phone_field */,/* dob_field */,/* email_field */,/* ipaddr_field */,/* datestamp_field */,/* url_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
