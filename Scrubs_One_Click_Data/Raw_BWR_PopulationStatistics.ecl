//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_One_Click_Data.Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.7');
IMPORT Scrubs_One_Click_Data,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_One_Click_Data.Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* ssn_field */,/* firstname_field */,/* lastname_field */,/* dob_field */,/* homeaddress_field */,/* homecity_field */,/* homestate_field */,/* homezip_field */,/* homephone_field */,/* mobilephone_field */,/* emailaddress_field */,/* workname_field */,/* workaddress_field */,/* workcity_field */,/* workstate_field */,/* workzip_field */,/* workphone_field */,/* ref1firstname_field */,/* ref1lastname_field */,/* ref1phone_field */,/* lastinquirydate_field */,/* ip_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
