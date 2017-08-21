//This is the code to execute in a builder window
#workunit('name','Scrubs_PhoneMart.BWR_PopulationStatistics - Population Statistics - SALT V3.0 B1');
IMPORT Scrubs_PhoneMart,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhoneMart.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* phone_field */,/* did_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* record_type_field */,/* cid_number_field */,/* csd_ref_number_field */,/* ssn_field */,/* address_field */,/* city_field */,/* state_field */,/* zipcode_field */,/* history_flag_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
