//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_Seleid_Relative.BWR_PopulationStatistics - Population Statistics - SALT V3.1.3');
IMPORT BIPV2_Seleid_Relative,SALT31;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_Seleid_Relative.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* active_duns_number_field */,/* active_enterprise_number_field */,/* company_charter_number_field */,/* company_fein_field */,/* source_record_id_field */,/* contact_ssn_field */,/* contact_phone_field */,/* contact_email_username_field */,/* cnp_name_field */,/* lname_field */,/* prim_name_field */,/* prim_range_field */,/* sec_range_field */,/* v_city_name_field */,/* fname_field */,/* mname_field */,/* company_inc_state_field */,/* postdir_field */,/* st_field */,/* source_field */,/* unit_desig_field */,/* company_department_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_first_seen_contact_field */,/* dt_last_seen_contact_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));