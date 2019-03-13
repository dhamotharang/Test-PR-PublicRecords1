﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_LN_PropertyV2_Search.BWR_PopulationStatistics - Population Statistics - SALT V3.11.4');
IMPORT Scrubs_LN_PropertyV2_Search,SALT311;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_LN_PropertyV2_Search.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* dt_first_seen_field */,/* dt_last_seen_field */,/* dt_vendor_first_reported_field */,/* dt_vendor_last_reported_field */,/* vendor_source_flag_field */,/* ln_fares_id_field */,/* process_date_field */,/* source_code_field */,/* which_orig_field */,/* conjunctive_name_seq_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* cname_field */,/* nameasis_field */,/* append_prepaddr1_field */,/* append_prepaddr2_field */,/* append_rawaid_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* zip_field */,/* zip4_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dbpc_field */,/* chk_digit_field */,/* rec_type_field */,/* county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* phone_number_field */,/* name_type_field */,/* prop_addr_propagated_ind_field */,/* did_field */,/* bdid_field */,/* app_ssn_field */,/* app_tax_id_field */,/* dotid_field */,/* dotscore_field */,/* dotweight_field */,/* empid_field */,/* empscore_field */,/* empweight_field */,/* powid_field */,/* powscore_field */,/* powweight_field */,/* proxid_field */,/* proxscore_field */,/* proxweight_field */,/* seleid_field */,/* selescore_field */,/* seleweight_field */,/* orgid_field */,/* orgscore_field */,/* orgweight_field */,/* ultid_field */,/* ultscore_field */,/* ultweight_field */,/* source_rec_id_field */,/* ln_party_status_field */,/* ln_percentage_ownership_field */,/* ln_entity_type_field */,/* ln_estate_trust_date_field */,/* ln_goverment_type_field */,/* xadl2_weight_field */,/* addr_ind_field */,/* best_addr_ind_field */,/* addr_tx_id_field */,/* best_addr_tx_id_field */,/* location_id_field */,/* best_locid_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
