//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Infutor_NARB.BWR_PopulationStatistics - Population Statistics - SALT V3.4.3');
IMPORT Scrubs_Infutor_NARB,SALT34;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Infutor_NARB.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* rcid_field */,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* did_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* process_date_field */,/* record_type_field */,/* pid_field */,/* address_type_code_field */,/* url_field */,/* sic1_field */,/* sic2_field */,/* sic3_field */,/* sic4_field */,/* sic5_field */,/* incorporation_state_field */,/* email_field */,/* contact_title_field */,/* normcompany_type_field */,/* clean_company_name_field */,/* clean_phone_field */,/* fname_field */,/* lname_field */,/* prim_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* prep_address_line1_field */,/* prep_address_line_last_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
