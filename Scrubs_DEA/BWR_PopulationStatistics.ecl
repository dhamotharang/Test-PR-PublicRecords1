//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DEA.BWR_PopulationStatistics - Population Statistics - SALT V3.2.1');
IMPORT Scrubs_DEA,SALT32;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DEA.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dea_registration_number_field */,/* business_activity_code_field */,/* drug_schedules_field */,/* expiration_date_field */,/* address1_field */,/* address2_field */,/* address3_field */,/* address4_field */,/* address5_field */,/* state_field */,/* zip_code_field */,/* bus_activity_sub_code_field */,/* exp_of_payment_indicator_field */,/* activity_field */,/* crlf_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
