//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Anchor.BWR_PopulationStatistics - Population Statistics - SALT V3.8.2');
IMPORT Scrubs_Anchor,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Anchor.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* firstname_field */,/* lastname_field */,/* address_1_field */,/* address_2_field */,/* city_field */,/* state_field */,/* zipcode_field */,/* sourceurl_field */,/* ipaddress_field */,/* optindate_field */,/* emailaddress_field */,/* anchorinternalcode_field */,/* addresstype_field */,/* dob_field */,/* latitude_field */,/* longitude_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
