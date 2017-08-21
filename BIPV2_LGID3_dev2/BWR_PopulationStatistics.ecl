//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_LGID3_dev2.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT BIPV2_LGID3_dev2,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_LGID3_dev2.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source Field*/,/* nodes_total_field */,/* sbfe_id_field */,/* source_record_id_field */,/* company_name_field */,/* cnp_number_field */,/* active_duns_number_field */,/* duns_number_field */,/* duns_number_concept_field */,/* company_fein_field */,/* company_inc_state_field */,/* company_charter_number_field */,/* cnp_btype_field */,/* company_name_type_derived_field */,/* hist_duns_number_field */,/* active_domestic_corp_key_field */,/* hist_domestic_corp_key_field */,/* foreign_corp_key_field */,/* unk_corp_key_field */,/* cnp_name_field */,/* cnp_hasNumber_field */,/* cnp_lowv_field */,/* cnp_translated_field */,/* cnp_classid_field */,/* prim_range_field */,/* prim_name_field */,/* sec_range_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
