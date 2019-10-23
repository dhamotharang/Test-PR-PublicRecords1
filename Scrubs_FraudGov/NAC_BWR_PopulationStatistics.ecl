//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FraudGov.NAC_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_FraudGov,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FraudGov.NAC_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* SearchAddress1StreetAddress1_field */,/* SearchAddress1StreetAddress2_field */,/* SearchAddress1City_field */,/* SearchAddress1State_field */,/* SearchAddress1Zip_field */,/* SearchAddress2StreetAddress1_field */,/* SearchAddress2StreetAddress2_field */,/* SearchAddress2City_field */,/* SearchAddress2State_field */,/* SearchAddress2Zip_field */,/* SearchCaseId_field */,/* enduserip_field */,/* CaseID_field */,/* ClientFirstName_field */,/* ClientMiddleName_field */,/* ClientLastName_field */,/* ClientPhone_field */,/* ClientEmail_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
