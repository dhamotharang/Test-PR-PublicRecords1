//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_PhoneFraud.BWR_PopulationStatistics - Population Statistics - SALT V3.6.1');
IMPORT Scrubs_PhoneFraud,SALT36;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_PhoneFraud.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* date_file_loaded_field */,/* transaction_id_field */,/* event_date_field */,/* event_time_field */,/* function_name_field */,/* account_id_field */,/* subject_id_field */,/* customer_subject_id_field */,/* otp_id_field */,/* verify_passed_field */,/* otp_delivery_method_field */,/* otp_preferred_delivery_field */,/* otp_phone_field */,/* otp_email_field */,/* reference_code_field */,/* product_id_field */,/* sub_product_id_field */,/* subject_unique_id_field */,/* first_name_field */,/* last_name_field */,/* country_field */,/* state_field */,/* otp_type_field */,/* otp_length_field */,/* mobile_phone_field */,/* mobile_phone_country_field */,/* mobile_phone_carrier_field */,/* work_phone_field */,/* work_phone_country_field */,/* home_phone_field */,/* home_phone_country_field */,/* otp_language_field */,/* date_added_field */,/* time_added_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
