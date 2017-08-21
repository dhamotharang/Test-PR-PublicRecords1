//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_DOTID_dev.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT BIPV2_DOTID_dev,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_DOTID_dev.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* company_name_field */,/* cnp_name_field */,/* corp_legal_name_field */,/* cnp_number_field */,/* cnp_btype_field */,/* cnp_lowv_field */,/* cnp_translated_field */,/* cnp_classid_field */,/* company_fein_field */,/* active_duns_number_field */,/* active_enterprise_number_field */,/* active_domestic_corp_key_field */,/* company_bdid_field */,/* company_phone_field */,/* prim_range_field */,/* prim_name_field */,/* sec_range_field */,/* st_field */,/* v_city_name_field */,/* zip_field */,/* csz_field */,/* addr1_field */,/* address_field */,/* isContact_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* contact_ssn_field */,/* contact_phone_field */,/* contact_email_field */,/* contact_job_title_raw_field */,/* company_department_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
