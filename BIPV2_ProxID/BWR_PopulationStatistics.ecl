//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_ProxID.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT BIPV2_ProxID,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_ProxID.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* active_duns_number_field */,/* active_enterprise_number_field */,/* active_domestic_corp_key_field */,/* hist_enterprise_number_field */,/* hist_duns_number_field */,/* hist_domestic_corp_key_field */,/* foreign_corp_key_field */,/* unk_corp_key_field */,/* ebr_file_number_field */,/* company_fein_field */,/* company_name_field */,/* cnp_name_field */,/* company_name_type_raw_field */,/* company_name_type_derived_field */,/* cnp_hasnumber_field */,/* cnp_number_field */,/* cnp_btype_field */,/* cnp_lowv_field */,/* cnp_translated_field */,/* cnp_classid_field */,/* company_foreign_domestic_field */,/* company_bdid_field */,/* company_phone_field */,/* prim_name_field */,/* prim_name_derived_field */,/* sec_range_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* prim_range_field */,/* prim_range_derived_field */,/* company_csz_field */,/* company_addr1_field */,/* company_address_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
