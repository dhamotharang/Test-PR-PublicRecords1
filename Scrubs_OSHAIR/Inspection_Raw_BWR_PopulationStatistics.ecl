//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_OSHAIR.Inspection_Raw_BWR_PopulationStatistics - Population Statistics - SALT V3.11.8');
IMPORT Scrubs_OSHAIR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_OSHAIR.Inspection_Raw_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* activity_nr_field */,/* reporting_id_field */,/* state_flag_field */,/* site_state_field */,/* site_zip_field */,/* owner_type_field */,/* owner_code_field */,/* adv_notice_field */,/* safety_hlth_field */,/* sic_code_field */,/* naics_code_field */,/* insp_type_field */,/* insp_scope_field */,/* why_no_insp_field */,/* union_status_field */,/* safety_manuf_field */,/* safety_const_field */,/* safety_marit_field */,/* health_manuf_field */,/* health_const_field */,/* health_marit_field */,/* migrant_field */,/* mail_state_field */,/* mail_zip_field */,/* host_est_key_field */,/* nr_in_estab_field */,/* open_date_field */,/* case_mod_date_field */,/* close_conf_date_field */,/* close_case_date_field */,/* open_year_field */,/* case_mod_year_field */,/* close_conf_year_field */,/* close_case_year_field */,/* estab_name_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
