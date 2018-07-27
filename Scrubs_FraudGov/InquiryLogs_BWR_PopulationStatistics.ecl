//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_FraudGov.InquiryLogs_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_FraudGov,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_FraudGov.InquiryLogs_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* transaction_id_field */,/* datetime_field */,/* full_name_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* ssn_field */,/* appended_ssn_field */,/* address_field */,/* city_field */,/* state_field */,/* zip_field */,/* fips_county_field */,/* personal_phone_field */,/* dob_field */,/* email_address_field */,/* dl_st_field */,/* dl_field */,/* ipaddr_field */,/* geo_lat_field */,/* geo_long_field */,/* Source_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
