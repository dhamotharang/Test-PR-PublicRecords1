//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhonesFeedback.BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_PhonesFeedback,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhonesFeedback.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* did_field */,/* did_score_field */,/* hhid_field */,/* phone_number_field */,/* login_history_id_field */,/* fname_field */,/* lname_field */,/* mname_field */,/* street_pre_direction_field */,/* street_post_direction_field */,/* street_number_field */,/* street_name_field */,/* street_suffix_field */,/* unit_number_field */,/* unit_designation_field */,/* zip5_field */,/* zip4_field */,/* city_field */,/* state_field */,/* alt_phone_field */,/* other_info_field */,/* phone_contact_type_field */,/* feedback_source_field */,/* date_time_added_field */,/* loginid_field */,/* customerid_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
