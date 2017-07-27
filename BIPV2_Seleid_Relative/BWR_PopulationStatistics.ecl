//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','BIPV2_Seleid_Relative.BWR_PopulationStatistics - Population Statistics - SALT V3.0 Gold');
IMPORT BIPV2_Seleid_Relative,SALT30;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  BIPV2_Seleid_Relative.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* cnp_name_field */,/* company_inc_state_field */,/* company_charter_number_field */,/* company_fein_field */,/* prim_range_field */,/* prim_name_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* v_city_name_field */,/* st_field */,/* active_duns_number_field */,/* active_enterprise_number_field */,/* source_field */,/* source_record_id_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* contact_ssn_field */,/* contact_phone_field */,/* company_department_field */,/* contact_email_username_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
