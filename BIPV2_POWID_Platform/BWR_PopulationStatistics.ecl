//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_POWID_Platform.BWR_PopulationStatistics - Population Statistics - SALT V3.2.0');
IMPORT BIPV2_POWID_Platform,SALT32;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_POWID_Platform.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* prim_range_field */,/* prim_name_field */,/* RID_If_Big_Biz_field */,/* cnp_name_field */,/* company_name_field */,/* cnp_number_field */,/* zip_field */,/* num_legal_names_field */,/* num_incs_field */,/* nodes_total_field */,/* zip4_field */,/* sec_range_field */,/* v_city_name_field */,/* st_field */,/* company_inc_state_field */,/* company_charter_number_field */,/* active_duns_number_field */,/* hist_duns_number_field */,/* active_domestic_corp_key_field */,/* hist_domestic_corp_key_field */,/* foreign_corp_key_field */,/* unk_corp_key_field */,/* company_fein_field */,/* cnp_btype_field */,/* company_name_type_derived_field */,/* company_bdid_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
