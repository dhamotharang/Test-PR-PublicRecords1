//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_AddressFeedback.BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_AddressFeedback,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_AddressFeedback.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* address_feedback_id_field */,/* login_history_id_field */,/* phone_number_field */,/* unique_id_field */,/* fname_field */,/* lname_field */,/* mname_field */,/* orig_street_pre_direction_field */,/* orig_street_post_direction_field */,/* orig_street_number_field */,/* orig_street_name_field */,/* orig_street_suffix_field */,/* orig_unit_number_field */,/* orig_unit_designation_field */,/* orig_zip5_field */,/* orig_zip4_field */,/* orig_city_field */,/* orig_state_field */,/* alt_phone_field */,/* other_info_field */,/* address_contact_type_field */,/* feedback_source_field */,/* transaction_id_field */,/* date_time_added_field */,/* loginid_field */,/* companyid_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
