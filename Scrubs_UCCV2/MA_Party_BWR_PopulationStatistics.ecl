﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_UCCV2.MA_Party_BWR_PopulationStatistics - Population Statistics - SALT V3.9.0');
IMPORT Scrubs_UCCV2,SALT39;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_UCCV2.MA_Party_MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* tmsid_field */,/* rmsid_field */,/* orig_name_field */,/* orig_lname_field */,/* orig_fname_field */,/* orig_mname_field */,/* orig_suffix_field */,/* duns_number_field */,/* hq_duns_number_field */,/* ssn_field */,/* fein_field */,/* incorp_state_field */,/* corp_number_field */,/* corp_type_field */,/* orig_address1_field */,/* orig_address2_field */,/* orig_city_field */,/* orig_state_field */,/* orig_zip5_field */,/* orig_zip4_field */,/* orig_country_field */,/* orig_province_field */,/* orig_postal_code_field */,/* foreign_indc_field */,/* party_type_field */,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_last_reported_field */,/* dt_vendor_first_reported_field */,/* process_date_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* name_score_field */,/* company_name_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip5_field */,/* zip4_field */,/* county_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dpbc_field */,/* chk_digit_field */,/* rec_type_field */,/* ace_fips_st_field */,/* ace_fips_county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* bdid_field */,/* did_field */,/* did_score_field */,/* bdid_score_field */,/* source_rec_id_field */,/* dotid_field */,/* dotscore_field */,/* dotweight_field */,/* empid_field */,/* empscore_field */,/* empweight_field */,/* powid_field */,/* powscore_field */,/* powweight_field */,/* proxid_field */,/* proxscore_field */,/* proxweight_field */,/* seleid_field */,/* selescore_field */,/* seleweight_field */,/* orgid_field */,/* orgscore_field */,/* orgweight_field */,/* ultid_field */,/* ultscore_field */,/* ultweight_field */,/* prep_addr_line1_field */,/* prep_addr_last_line_field */,/* rawaid_field */,/* aceaid_field */,/* persistent_record_id_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
