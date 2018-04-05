//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FraudGov.InquiryLogs_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_FraudGov,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FraudGov.InquiryLogs_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* Customer_Account_Number_field */,/* Customer_County_field */,/* Customer_State_field */,/* Customer_Agency_Vertical_Type_field */,/* Customer_Program_field */,/* LexID_field */,/* raw_Full_Name_field */,/* raw_First_name_field */,/* raw_Last_Name_field */,/* SSN_field */,/* Drivers_License_State_field */,/* Drivers_License_Number_field */,/* Street_1_field */,/* City_field */,/* State_field */,/* Zip_field */,/* did_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
