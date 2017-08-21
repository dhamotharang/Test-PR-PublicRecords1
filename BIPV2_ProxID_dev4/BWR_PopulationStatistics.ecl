//This is the code to execute in a builder window
#workunit('name','BIPV2_ProxID_dev4.BWR_PopulationStatistics - Population Statistics - SALT V2.7 Alpha 11');
IMPORT BIPV2_ProxID_dev4,SALT27;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_ProxID_dev4.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* cnp_number_field */,/* prim_range_field */,/* prim_name_field */,/* st_field */,/* ebr_file_number_field */,/* hist_enterprise_number_field */,/* hist_domestic_corp_key_field */,/* unk_corp_key_field */,/* active_enterprise_number_field */,/* active_domestic_corp_key_field */,/* hist_duns_number_field */,/* active_duns_number_field */,/* company_fein_field */,/* company_phone_field */,/* foreign_corp_key_field */,/* company_name_field */,/* zip_field */,/* company_csz_field */,/* sec_range_field */,/* v_city_name_field */,/* cnp_btype_field */,/* iscorp_field */,/* cnp_hasnumber_field */,/* cnp_lowv_field */,/* cnp_translated_field */,/* cnp_classid_field */,/* company_foreign_domestic_field */,/* company_bdid_field */,/* company_addr1_field */,/* company_address_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));

