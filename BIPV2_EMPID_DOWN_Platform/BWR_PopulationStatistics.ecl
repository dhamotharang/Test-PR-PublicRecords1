//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_EMPID_DOWN_Platform.BWR_PopulationStatistics - Population Statistics - SALT V3.2.0');
IMPORT BIPV2_EMPID_DOWN_Platform,SALT32;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_EMPID_DOWN_Platform.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* orgid_field */,/* contact_ssn_field */,/* contact_did_field */,/* lname_field */,/* mname_field */,/* fname_field */,/* name_suffix_field */,/* isContact_field */,/* contact_phone_field */,/* contact_email_field */,/* company_name_field */,/* prim_range_field */,/* prim_name_field */,/* sec_range_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* active_duns_number_field */,/* hist_duns_number_field */,/* active_domestic_corp_key_field */,/* hist_domestic_corp_key_field */,/* foreign_corp_key_field */,/* unk_corp_key_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
