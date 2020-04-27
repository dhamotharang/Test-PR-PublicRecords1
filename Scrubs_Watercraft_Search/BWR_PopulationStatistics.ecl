﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_Watercraft_Search.BWR_PopulationStatistics - Population Statistics - SALT V3.11.9');
IMPORT Scrubs_Watercraft_Search,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_Watercraft_Search.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/*source_code Field*/,/* date_first_seen_field */,/* date_last_seen_field */,/* date_vendor_first_reported_field */,/* date_vendor_last_reported_field */,/* watercraft_key_field */,/* sequence_key_field */,/* state_origin_field */,/* source_code_field */,/* dppa_flag_field */,/* orig_name_field */,/* orig_name_type_code_field */,/* orig_name_type_description_field */,/* orig_name_first_field */,/* orig_name_middle_field */,/* orig_name_last_field */,/* orig_name_suffix_field */,/* orig_address_1_field */,/* orig_address_2_field */,/* orig_city_field */,/* orig_state_field */,/* orig_zip_field */,/* orig_fips_field */,/* orig_province_field */,/* orig_country_field */,/* dob_field */,/* orig_ssn_field */,/* orig_fein_field */,/* gender_field */,/* phone_1_field */,/* phone_2_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* name_cleaning_score_field */,/* company_name_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip5_field */,/* zip4_field */,/* county_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dpbc_field */,/* chk_digit_field */,/* rec_type_field */,/* ace_fips_st_field */,/* ace_fips_county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* bdid_field */,/* fein_field */,/* did_field */,/* did_score_field */,/* ssn_field */,/* history_flag_field */,/* rawaid_field */,/* reg_owner_name_2_field */,/* persistent_record_id_field */,/* source_rec_id_field */,/* dotscore_field */,/* dotweight_field */,/* empid_field */,/* empscore_field */,/* empweight_field */,/* powid_field */,/* powscore_field */,/* powweight_field */,/* proxid_field */,/* proxscore_field */,/* proxweight_field */,/* seleid_field */,/* selescore_field */,/* seleweight_field */,/* orgid_field */,/* orgscore_field */,/* orgweight_field */,/* ultid_field */,/* ultscore_field */,/* ultweight_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
