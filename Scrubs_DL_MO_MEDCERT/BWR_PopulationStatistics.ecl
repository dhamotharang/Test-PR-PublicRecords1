﻿//This is the code to execute in a builder window
#OPTION('multiplePersistInstances', FALSE);
#workunit('name','Scrubs_DL_MO_MEDCERT.BWR_PopulationStatistics - Population Statistics - SALT V3.8.0');
IMPORT Scrubs_DL_MO_MEDCERT,SALT38;
// In the line below substitute the file you want statistics for; and substitute any field names you can
  Scrubs_DL_MO_MEDCERT.MAC_PopulationStatistics(YourFileName,/*Reference Field*/,/* process_date_field */,/* unique_key_field */,/* license_number_field */,/* last_name_field */,/* first_name_field */,/* middle_name_field */,/* suffix_field */,/* date_of_birth_field */,/* gender_field */,/* address_field */,/* city_field */,/* state_field */,/* zip5_field */,/* zip4_field */,/* mailing_address1_field */,/* mailing_address2_field */,/* mailing_city_field */,/* mailing_state_field */,/* mailing_zip_field */,/* height_field */,/* eye_color_field */,/* operator_status_field */,/* commercial_status_field */,/* sch_bus_status_field */,/* pending_act_code_field */,/* must_test_ind_field */,/* deceased_ind_field */,/* prev_cdl_class_field */,/* cdl_ptr_field */,/* pdps_ptr_field */,/* mvr_privacy_code_field */,/* brc_status_code_field */,/* brc_status_date_field */,/* lic_iss_code_field */,/* license_class_field */,/* lic_exp_date_field */,/* lic_seq_number_field */,/* lic_surrender_to_field */,/* new_out_of_st_dl_num_field */,/* license_endorsements_field */,/* license_restrictions_field */,/* license_trans_type_field */,/* lic_print_date_field */,/* permit_iss_code_field */,/* permit_class_field */,/* permit_exp_date_field */,/* permit_seq_number_field */,/* permit_endorse_codes_field */,/* permit_restric_codes_field */,/* permit_trans_type_field */,/* permit_print_date_field */,/* non_driver_code_field */,/* non_driver_exp_date_field */,/* non_driver_seq_num_field */,/* non_driver_trans_type_field */,/* non_driver_print_date_field */,/* action_surrender_date_field */,/* action_counts_field */,/* driv_priv_counts_field */,/* conv_counts_field */,/* accidents_counts_field */,/* aka_counts_field */,/* title_field */,/* fname_field */,/* mname_field */,/* lname_field */,/* name_suffix_field */,/* cleaning_score_field */,/* prim_range_field */,/* predir_field */,/* prim_name_field */,/* addr_suffix_field */,/* postdir_field */,/* unit_desig_field */,/* sec_range_field */,/* p_city_name_field */,/* v_city_name_field */,/* st_field */,/* cln_zip5_field */,/* cln_zip4_field */,/* cart_field */,/* cr_sort_sz_field */,/* lot_field */,/* lot_order_field */,/* dpbc_field */,/* chk_digit_field */,/* rec_type_field */,/* ace_fips_st_field */,/* county_field */,/* geo_lat_field */,/* geo_long_field */,/* msa_field */,/* geo_blk_field */,/* geo_match_field */,/* err_stat_field */,/* previous_dl_number_field */,/* previous_st_field */,/* old_dl_number_field */,outfile);
  OUTPUT(outfile,NAMED('PopulationStatistics'));
