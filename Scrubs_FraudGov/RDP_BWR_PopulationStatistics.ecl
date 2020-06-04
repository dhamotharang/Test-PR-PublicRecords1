//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FraudGov.RDP_BWR_PopulationStatistics - Population Statistics - SALT V3.11.11');
IMPORT Scrubs_FraudGov,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FraudGov.RDP_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* Transaction_ID_field */,/* TransactionDate_field */,/* FirstName_field */,/* LastName_field */,/* MiddleName_field */,/* Suffix_field */,/* BirthDate_field */,/* SSN_field */,/* Lexid_Input_field */,/* Street1_field */,/* Street2_field */,/* Suite_field */,/* City_field */,/* State_field */,/* Zip5_field */,/* Phone_field */,/* Lexid_Discovered_field */,/* RemoteIPAddress_field */,/* ConsumerIPAddress_field */,/* Email_Address_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
