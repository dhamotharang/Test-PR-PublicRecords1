//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_EMPID_Platform.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT BIPV2_EMPID_Platform,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_EMPID_Platform.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* isCorpEnhanced_field */,/* contact_job_title_derived_field */,/* cname_devanitize_field */,/* prim_range_field */,/* prim_name_field */,/* zip_field */,/* zip4_field */,/* fname_field */,/* lname_field */,/* contact_phone_field */,/* contact_did_field */,/* contact_ssn_field */,/* company_name_field */,/* sec_range_field */,/* v_city_name_field */,/* st_field */,/* company_inc_state_field */,/* company_charter_number_field */,/* active_duns_number_field */,/* hist_duns_number_field */,/* active_domestic_corp_key_field */,/* hist_domestic_corp_key_field */,/* foreign_corp_key_field */,/* unk_corp_key_field */,/* company_fein_field */,/* cnp_btype_field */,/* cnp_name_field */,/* company_name_type_derived_field */,/* company_bdid_field */,/* nodes_total_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
