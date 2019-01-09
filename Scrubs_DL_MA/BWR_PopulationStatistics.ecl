//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DL_MA.BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_DL_MA,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DL_MA.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* pers_surrogate_field */,/* filler1_field */,/* license_licno_field */,/* filler2_field */,/* license_bdate_yyyymmdd_field */,/* license_edate_yyyymmdd_field */,/* license_lic_class_field */,/* license_height_field */,/* license_sex_field */,/* license_last_name_field */,/* license_first_name_field */,/* license_middle_name_field */,/* licmail_street1_field */,/* licmail_street2_field */,/* licmail_city_field */,/* licmail_state_field */,/* licmail_zip_field */,/* licresi_street1_field */,/* licresi_street2_field */,/* licresi_city_field */,/* licresi_state_field */,/* licresi_zip_field */,/* issue_date_yyyymmdd_field */,/* license_status_field */,/* clean_status_field */,/* process_date_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
