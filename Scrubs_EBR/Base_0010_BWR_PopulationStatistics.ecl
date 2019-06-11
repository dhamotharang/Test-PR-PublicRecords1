//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_EBR.Base_0010_BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_EBR,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_EBR.Base_0010_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* powid_field */,/* proxid_field */,/* seleid_field */,/* orgid_field */,/* ultid_field */,/* bdid_field */,/* date_first_seen_field */,/* date_last_seen_field */,/* process_date_first_seen_field */,/* process_date_last_seen_field */,/* record_type_field */,/* process_date_field */,/* file_number_field */,/* orig_extract_date_mdy_field */,/* company_name_field */,/* phone_number_field */,/* sic_code_field */,/* business_desc_field */,/* extract_date_field */,/* file_estab_date_field */,/* prep_addr_line1_field */,/* prep_addr_last_line_field */,/* source_rec_id_field */,/* clean_address_prim_name_field */,/* clean_address_p_city_name_field */,/* clean_address_v_city_name_field */,/* clean_address_st_field */,/* clean_address_zip_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
