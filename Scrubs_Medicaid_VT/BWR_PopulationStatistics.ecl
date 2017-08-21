//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Medicaid_VT.BWR_PopulationStatistics - Population Statistics - SALT V3.1.3');
IMPORT Scrubs_Medicaid_VT,SALT31;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Medicaid_VT.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* did_field */,/* did_score_field */,/* bdid_field */,/* bdid_score_field */,/* best_dob_field */,/* best_ssn_field */,/* data_state_field */,/* provider_id_field */,/* npi_field */,/* taxonomy_field */,/* provider_name_field */,/* provider_address_field */,/* phone_field */,/* entity_type_code_field */,/* firstname_field */,/* lastname_field */,/* companyname_field */,/* src_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* record_type_field */,/* source_rid_field */,/* lnpid_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* name_type_field */,/* nid_field */,/* clean_clinic_name_field */,/* prepped_addr1_field */,/* prepped_addr2_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dbpc_field */,/* chk_digit_field */,/* rec_type_field */,/* fips_st_field */,/* fips_county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* rawaid_field */,/* aceaid_field */,/* clean_phone_field */,/* dotid_field */,/* dotscore_field */,/* dotweight_field */,/* empid_field */,/* empscore_field */,/* empweight_field */,/* powid_field */,/* powscore_field */,/* powweight_field */,/* proxid_field */,/* proxscore_field */,/* proxweight_field */,/* seleid_field */,/* selescore_field */,/* seleweight_field */,/* orgid_field */,/* orgscore_field */,/* orgweight_field */,/* ultid_field */,/* ultscore_field */,/* ultweight_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
