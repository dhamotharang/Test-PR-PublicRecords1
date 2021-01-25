//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_IDA.RawInput_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_IDA,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_IDA.RawInput_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* firstname_field */,/* middlename_field */,/* lastname_field */,/* suffix_field */,/* addressline1_field */,/* addressline2_field */,/* city_field */,/* state_field */,/* zip_field */,/* dob_field */,/* ssn_field */,/* dl_field */,/* dlstate_field */,/* phone_field */,/* clientassigneduniquerecordid_field */,/* emailaddress_field */,/* ipaddress_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
