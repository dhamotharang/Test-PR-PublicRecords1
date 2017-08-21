IMPORT ut,SALT31;
EXPORT Individuals_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Individuals_Layout_Individuals)
    UNSIGNED1 hms_piid_Invalid;
    UNSIGNED1 first_Invalid;
    UNSIGNED1 middle_Invalid;
    UNSIGNED1 last_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 cred_Invalid;
    UNSIGNED1 practitioner_type_Invalid;
    UNSIGNED1 active_Invalid;
    UNSIGNED1 vendible_Invalid;
    UNSIGNED1 npi_num_Invalid;
    UNSIGNED1 npi_enumeration_date_Invalid;
    UNSIGNED1 npi_deactivation_date_Invalid;
    UNSIGNED1 npi_reactivation_date_Invalid;
    UNSIGNED1 npi_taxonomy_code_Invalid;
    UNSIGNED1 upin_Invalid;
    UNSIGNED1 medicare_participation_flag_Invalid;
    UNSIGNED1 date_born_Invalid;
    UNSIGNED1 date_died_Invalid;
    UNSIGNED1 pid_Invalid;
    UNSIGNED1 src_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 source_rid_Invalid;
    UNSIGNED1 lnpid_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 nametype_Invalid;
    UNSIGNED1 nid_Invalid;
    UNSIGNED1 clean_npi_enumeration_date_Invalid;
    UNSIGNED1 clean_npi_deactivation_date_Invalid;
    UNSIGNED1 clean_npi_reactivation_date_Invalid;
    UNSIGNED1 clean_date_born_Invalid;
    UNSIGNED1 clean_date_died_Invalid;
    UNSIGNED1 clean_company_name_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dbpc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 fips_st_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
    UNSIGNED1 rawaid_Invalid;
    UNSIGNED1 aceaid_Invalid;
    UNSIGNED1 firm_name_Invalid;
    UNSIGNED1 lid_Invalid;
    UNSIGNED1 agid_Invalid;
    UNSIGNED1 address_std_code_Invalid;
    UNSIGNED1 latitude_Invalid;
    UNSIGNED1 longitude_Invalid;
    UNSIGNED1 prepped_addr1_Invalid;
    UNSIGNED1 prepped_addr2_Invalid;
    UNSIGNED1 addr_type_Invalid;
    UNSIGNED1 state_license_state_Invalid;
    UNSIGNED1 state_license_number_Invalid;
    UNSIGNED1 state_license_type_Invalid;
    UNSIGNED1 state_license_active_Invalid;
    UNSIGNED1 state_license_expire_Invalid;
    UNSIGNED1 state_license_qualifier_Invalid;
    UNSIGNED1 state_license_sub_qualifier_Invalid;
    UNSIGNED1 state_license_issued_Invalid;
    UNSIGNED1 clean_state_license_expire_Invalid;
    UNSIGNED1 clean_state_license_issued_Invalid;
    UNSIGNED1 dea_num_Invalid;
    UNSIGNED1 dea_bac_Invalid;
    UNSIGNED1 dea_sub_bac_Invalid;
    UNSIGNED1 dea_schedule_Invalid;
    UNSIGNED1 dea_expire_Invalid;
    UNSIGNED1 dea_active_Invalid;
    UNSIGNED1 clean_dea_expire_Invalid;
    UNSIGNED1 csr_number_Invalid;
    UNSIGNED1 csr_state_Invalid;
    UNSIGNED1 csr_expire_date_Invalid;
    UNSIGNED1 csr_issue_date_Invalid;
    UNSIGNED1 dsa_lvl_2_Invalid;
    UNSIGNED1 dsa_lvl_2n_Invalid;
    UNSIGNED1 dsa_lvl_3_Invalid;
    UNSIGNED1 dsa_lvl_3n_Invalid;
    UNSIGNED1 dsa_lvl_4_Invalid;
    UNSIGNED1 dsa_lvl_5_Invalid;
    UNSIGNED1 csr_raw1_Invalid;
    UNSIGNED1 csr_raw2_Invalid;
    UNSIGNED1 csr_raw3_Invalid;
    UNSIGNED1 csr_raw4_Invalid;
    UNSIGNED1 clean_csr_expire_date_Invalid;
    UNSIGNED1 clean_csr_issue_date_Invalid;
    UNSIGNED1 sanction_id_Invalid;
    UNSIGNED1 sanction_action_code_Invalid;
    UNSIGNED1 sanction_action_description_Invalid;
    UNSIGNED1 sanction_board_code_Invalid;
    UNSIGNED1 sanction_board_description_Invalid;
    UNSIGNED1 action_date_Invalid;
    UNSIGNED1 sanction_period_start_date_Invalid;
    UNSIGNED1 sanction_period_end_date_Invalid;
    UNSIGNED1 month_duration_Invalid;
    UNSIGNED1 fine_amount_Invalid;
    UNSIGNED1 offense_code_Invalid;
    UNSIGNED1 offense_description_Invalid;
    UNSIGNED1 offense_date_Invalid;
    UNSIGNED1 clean_offense_date_Invalid;
    UNSIGNED1 clean_action_date_Invalid;
    UNSIGNED1 clean_sanction_period_start_date_Invalid;
    UNSIGNED1 clean_sanction_period_end_date_Invalid;
    UNSIGNED1 gsa_sanction_id_Invalid;
    UNSIGNED1 gsa_first_Invalid;
    UNSIGNED1 gsa_middle_Invalid;
    UNSIGNED1 gsa_last_Invalid;
    UNSIGNED1 gsa_suffix_Invalid;
    UNSIGNED1 gsa_city_Invalid;
    UNSIGNED1 gsa_state_Invalid;
    UNSIGNED1 gsa_zip_Invalid;
    UNSIGNED1 date_Invalid;
    UNSIGNED1 agency_Invalid;
    UNSIGNED1 confidence_Invalid;
    UNSIGNED1 clean_gsa_first_Invalid;
    UNSIGNED1 clean_gsa_middle_Invalid;
    UNSIGNED1 clean_gsa_last_Invalid;
    UNSIGNED1 clean_gsa_suffix_Invalid;
    UNSIGNED1 clean_gsa_city_Invalid;
    UNSIGNED1 clean_gsa_state_Invalid;
    UNSIGNED1 clean_gsa_zip_Invalid;
    UNSIGNED1 clean_gsa_action_date_Invalid;
    UNSIGNED1 clean_gsa_date_Invalid;
    UNSIGNED1 fax_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 certification_code_Invalid;
    UNSIGNED1 certification_description_Invalid;
    UNSIGNED1 board_code_Invalid;
    UNSIGNED1 board_description_Invalid;
    UNSIGNED1 expiration_year_Invalid;
    UNSIGNED1 issue_year_Invalid;
    UNSIGNED1 renewal_year_Invalid;
    UNSIGNED1 lifetime_flag_Invalid;
    UNSIGNED1 covered_recipient_id_Invalid;
    UNSIGNED1 cov_rcp_raw_state_code_Invalid;
    UNSIGNED1 cov_rcp_raw_full_name_Invalid;
    UNSIGNED1 cov_rcp_raw_attribute1_Invalid;
    UNSIGNED1 cov_rcp_raw_attribute2_Invalid;
    UNSIGNED1 cov_rcp_raw_attribute3_Invalid;
    UNSIGNED1 cov_rcp_raw_attribute4_Invalid;
    UNSIGNED1 hms_scid_Invalid;
    UNSIGNED1 school_name_Invalid;
    UNSIGNED1 grad_year_Invalid;
    UNSIGNED1 lang_code_Invalid;
    UNSIGNED1 language_Invalid;
    UNSIGNED1 specialty_description_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 bdid_score_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 clean_dob_Invalid;
    UNSIGNED1 best_dob_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 rec_deactivated_date_Invalid;
    UNSIGNED1 superceeding_piid_Invalid;
    UNSIGNED1 dotid_Invalid;
    UNSIGNED1 dotscore_Invalid;
    UNSIGNED1 dotweight_Invalid;
    UNSIGNED1 empid_Invalid;
    UNSIGNED1 empscore_Invalid;
    UNSIGNED1 empweight_Invalid;
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 powscore_Invalid;
    UNSIGNED1 powweight_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 proxscore_Invalid;
    UNSIGNED1 proxweight_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 selescore_Invalid;
    UNSIGNED1 seleweight_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 orgscore_Invalid;
    UNSIGNED1 orgweight_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 ultscore_Invalid;
    UNSIGNED1 ultweight_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Individuals_Layout_Individuals)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
    UNSIGNED8 ScrubsBits5;
    UNSIGNED8 ScrubsBits6;
    UNSIGNED8 ScrubsBits7;
  END;
EXPORT FromNone(DATASET(Individuals_Layout_Individuals) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.hms_piid_Invalid := Individuals_Fields.InValid_hms_piid((SALT31.StrType)le.hms_piid);
    SELF.first_Invalid := Individuals_Fields.InValid_first((SALT31.StrType)le.first);
    SELF.middle_Invalid := Individuals_Fields.InValid_middle((SALT31.StrType)le.middle);
    SELF.last_Invalid := Individuals_Fields.InValid_last((SALT31.StrType)le.last);
    SELF.suffix_Invalid := Individuals_Fields.InValid_suffix((SALT31.StrType)le.suffix);
    SELF.cred_Invalid := Individuals_Fields.InValid_cred((SALT31.StrType)le.cred);
    SELF.practitioner_type_Invalid := Individuals_Fields.InValid_practitioner_type((SALT31.StrType)le.practitioner_type);
    SELF.active_Invalid := Individuals_Fields.InValid_active((SALT31.StrType)le.active);
    SELF.vendible_Invalid := Individuals_Fields.InValid_vendible((SALT31.StrType)le.vendible);
    SELF.npi_num_Invalid := Individuals_Fields.InValid_npi_num((SALT31.StrType)le.npi_num);
    SELF.npi_enumeration_date_Invalid := Individuals_Fields.InValid_npi_enumeration_date((SALT31.StrType)le.npi_enumeration_date);
    SELF.npi_deactivation_date_Invalid := Individuals_Fields.InValid_npi_deactivation_date((SALT31.StrType)le.npi_deactivation_date);
    SELF.npi_reactivation_date_Invalid := Individuals_Fields.InValid_npi_reactivation_date((SALT31.StrType)le.npi_reactivation_date);
    SELF.npi_taxonomy_code_Invalid := Individuals_Fields.InValid_npi_taxonomy_code((SALT31.StrType)le.npi_taxonomy_code);
    SELF.upin_Invalid := Individuals_Fields.InValid_upin((SALT31.StrType)le.upin);
    SELF.medicare_participation_flag_Invalid := Individuals_Fields.InValid_medicare_participation_flag((SALT31.StrType)le.medicare_participation_flag);
    SELF.date_born_Invalid := Individuals_Fields.InValid_date_born((SALT31.StrType)le.date_born);
    SELF.date_died_Invalid := Individuals_Fields.InValid_date_died((SALT31.StrType)le.date_died);
    SELF.pid_Invalid := Individuals_Fields.InValid_pid((SALT31.StrType)le.pid);
    SELF.src_Invalid := Individuals_Fields.InValid_src((SALT31.StrType)le.src);
    SELF.date_vendor_first_reported_Invalid := Individuals_Fields.InValid_date_vendor_first_reported((SALT31.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Individuals_Fields.InValid_date_vendor_last_reported((SALT31.StrType)le.date_vendor_last_reported);
    SELF.date_first_seen_Invalid := Individuals_Fields.InValid_date_first_seen((SALT31.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Individuals_Fields.InValid_date_last_seen((SALT31.StrType)le.date_last_seen);
    SELF.record_type_Invalid := Individuals_Fields.InValid_record_type((SALT31.StrType)le.record_type);
    SELF.source_rid_Invalid := Individuals_Fields.InValid_source_rid((SALT31.StrType)le.source_rid);
    SELF.lnpid_Invalid := Individuals_Fields.InValid_lnpid((SALT31.StrType)le.lnpid);
    SELF.fname_Invalid := Individuals_Fields.InValid_fname((SALT31.StrType)le.fname);
    SELF.mname_Invalid := Individuals_Fields.InValid_mname((SALT31.StrType)le.mname);
    SELF.lname_Invalid := Individuals_Fields.InValid_lname((SALT31.StrType)le.lname);
    SELF.name_suffix_Invalid := Individuals_Fields.InValid_name_suffix((SALT31.StrType)le.name_suffix);
    SELF.nametype_Invalid := Individuals_Fields.InValid_nametype((SALT31.StrType)le.nametype);
    SELF.nid_Invalid := Individuals_Fields.InValid_nid((SALT31.StrType)le.nid);
    SELF.clean_npi_enumeration_date_Invalid := Individuals_Fields.InValid_clean_npi_enumeration_date((SALT31.StrType)le.clean_npi_enumeration_date);
    SELF.clean_npi_deactivation_date_Invalid := Individuals_Fields.InValid_clean_npi_deactivation_date((SALT31.StrType)le.clean_npi_deactivation_date);
    SELF.clean_npi_reactivation_date_Invalid := Individuals_Fields.InValid_clean_npi_reactivation_date((SALT31.StrType)le.clean_npi_reactivation_date);
    SELF.clean_date_born_Invalid := Individuals_Fields.InValid_clean_date_born((SALT31.StrType)le.clean_date_born);
    SELF.clean_date_died_Invalid := Individuals_Fields.InValid_clean_date_died((SALT31.StrType)le.clean_date_died);
    SELF.clean_company_name_Invalid := Individuals_Fields.InValid_clean_company_name((SALT31.StrType)le.clean_company_name);
    SELF.prim_range_Invalid := Individuals_Fields.InValid_prim_range((SALT31.StrType)le.prim_range);
    SELF.predir_Invalid := Individuals_Fields.InValid_predir((SALT31.StrType)le.predir);
    SELF.prim_name_Invalid := Individuals_Fields.InValid_prim_name((SALT31.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Individuals_Fields.InValid_addr_suffix((SALT31.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Individuals_Fields.InValid_postdir((SALT31.StrType)le.postdir);
    SELF.unit_desig_Invalid := Individuals_Fields.InValid_unit_desig((SALT31.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Individuals_Fields.InValid_sec_range((SALT31.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Individuals_Fields.InValid_p_city_name((SALT31.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Individuals_Fields.InValid_v_city_name((SALT31.StrType)le.v_city_name);
    SELF.st_Invalid := Individuals_Fields.InValid_st((SALT31.StrType)le.st);
    SELF.zip_Invalid := Individuals_Fields.InValid_zip((SALT31.StrType)le.zip);
    SELF.zip4_Invalid := Individuals_Fields.InValid_zip4((SALT31.StrType)le.zip4);
    SELF.cart_Invalid := Individuals_Fields.InValid_cart((SALT31.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Individuals_Fields.InValid_cr_sort_sz((SALT31.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Individuals_Fields.InValid_lot((SALT31.StrType)le.lot);
    SELF.lot_order_Invalid := Individuals_Fields.InValid_lot_order((SALT31.StrType)le.lot_order);
    SELF.dbpc_Invalid := Individuals_Fields.InValid_dbpc((SALT31.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Individuals_Fields.InValid_chk_digit((SALT31.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Individuals_Fields.InValid_rec_type((SALT31.StrType)le.rec_type);
    SELF.fips_st_Invalid := Individuals_Fields.InValid_fips_st((SALT31.StrType)le.fips_st);
    SELF.fips_county_Invalid := Individuals_Fields.InValid_fips_county((SALT31.StrType)le.fips_county);
    SELF.geo_lat_Invalid := Individuals_Fields.InValid_geo_lat((SALT31.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Individuals_Fields.InValid_geo_long((SALT31.StrType)le.geo_long);
    SELF.msa_Invalid := Individuals_Fields.InValid_msa((SALT31.StrType)le.msa);
    SELF.geo_blk_Invalid := Individuals_Fields.InValid_geo_blk((SALT31.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Individuals_Fields.InValid_geo_match((SALT31.StrType)le.geo_match);
    SELF.err_stat_Invalid := Individuals_Fields.InValid_err_stat((SALT31.StrType)le.err_stat);
    SELF.rawaid_Invalid := Individuals_Fields.InValid_rawaid((SALT31.StrType)le.rawaid);
    SELF.aceaid_Invalid := Individuals_Fields.InValid_aceaid((SALT31.StrType)le.aceaid);
    SELF.firm_name_Invalid := Individuals_Fields.InValid_firm_name((SALT31.StrType)le.firm_name);
    SELF.lid_Invalid := Individuals_Fields.InValid_lid((SALT31.StrType)le.lid);
    SELF.agid_Invalid := Individuals_Fields.InValid_agid((SALT31.StrType)le.agid);
    SELF.address_std_code_Invalid := Individuals_Fields.InValid_address_std_code((SALT31.StrType)le.address_std_code);
    SELF.latitude_Invalid := Individuals_Fields.InValid_latitude((SALT31.StrType)le.latitude);
    SELF.longitude_Invalid := Individuals_Fields.InValid_longitude((SALT31.StrType)le.longitude);
    SELF.prepped_addr1_Invalid := Individuals_Fields.InValid_prepped_addr1((SALT31.StrType)le.prepped_addr1);
    SELF.prepped_addr2_Invalid := Individuals_Fields.InValid_prepped_addr2((SALT31.StrType)le.prepped_addr2);
    SELF.addr_type_Invalid := Individuals_Fields.InValid_addr_type((SALT31.StrType)le.addr_type);
    SELF.state_license_state_Invalid := Individuals_Fields.InValid_state_license_state((SALT31.StrType)le.state_license_state);
    SELF.state_license_number_Invalid := Individuals_Fields.InValid_state_license_number((SALT31.StrType)le.state_license_number);
    SELF.state_license_type_Invalid := Individuals_Fields.InValid_state_license_type((SALT31.StrType)le.state_license_type);
    SELF.state_license_active_Invalid := Individuals_Fields.InValid_state_license_active((SALT31.StrType)le.state_license_active);
    SELF.state_license_expire_Invalid := Individuals_Fields.InValid_state_license_expire((SALT31.StrType)le.state_license_expire);
    SELF.state_license_qualifier_Invalid := Individuals_Fields.InValid_state_license_qualifier((SALT31.StrType)le.state_license_qualifier);
    SELF.state_license_sub_qualifier_Invalid := Individuals_Fields.InValid_state_license_sub_qualifier((SALT31.StrType)le.state_license_sub_qualifier);
    SELF.state_license_issued_Invalid := Individuals_Fields.InValid_state_license_issued((SALT31.StrType)le.state_license_issued);
    SELF.clean_state_license_expire_Invalid := Individuals_Fields.InValid_clean_state_license_expire((SALT31.StrType)le.clean_state_license_expire);
    SELF.clean_state_license_issued_Invalid := Individuals_Fields.InValid_clean_state_license_issued((SALT31.StrType)le.clean_state_license_issued);
    SELF.dea_num_Invalid := Individuals_Fields.InValid_dea_num((SALT31.StrType)le.dea_num);
    SELF.dea_bac_Invalid := Individuals_Fields.InValid_dea_bac((SALT31.StrType)le.dea_bac);
    SELF.dea_sub_bac_Invalid := Individuals_Fields.InValid_dea_sub_bac((SALT31.StrType)le.dea_sub_bac);
    SELF.dea_schedule_Invalid := Individuals_Fields.InValid_dea_schedule((SALT31.StrType)le.dea_schedule);
    SELF.dea_expire_Invalid := Individuals_Fields.InValid_dea_expire((SALT31.StrType)le.dea_expire);
    SELF.dea_active_Invalid := Individuals_Fields.InValid_dea_active((SALT31.StrType)le.dea_active);
    SELF.clean_dea_expire_Invalid := Individuals_Fields.InValid_clean_dea_expire((SALT31.StrType)le.clean_dea_expire);
    SELF.csr_number_Invalid := Individuals_Fields.InValid_csr_number((SALT31.StrType)le.csr_number);
    SELF.csr_state_Invalid := Individuals_Fields.InValid_csr_state((SALT31.StrType)le.csr_state);
    SELF.csr_expire_date_Invalid := Individuals_Fields.InValid_csr_expire_date((SALT31.StrType)le.csr_expire_date);
    SELF.csr_issue_date_Invalid := Individuals_Fields.InValid_csr_issue_date((SALT31.StrType)le.csr_issue_date);
    SELF.dsa_lvl_2_Invalid := Individuals_Fields.InValid_dsa_lvl_2((SALT31.StrType)le.dsa_lvl_2);
    SELF.dsa_lvl_2n_Invalid := Individuals_Fields.InValid_dsa_lvl_2n((SALT31.StrType)le.dsa_lvl_2n);
    SELF.dsa_lvl_3_Invalid := Individuals_Fields.InValid_dsa_lvl_3((SALT31.StrType)le.dsa_lvl_3);
    SELF.dsa_lvl_3n_Invalid := Individuals_Fields.InValid_dsa_lvl_3n((SALT31.StrType)le.dsa_lvl_3n);
    SELF.dsa_lvl_4_Invalid := Individuals_Fields.InValid_dsa_lvl_4((SALT31.StrType)le.dsa_lvl_4);
    SELF.dsa_lvl_5_Invalid := Individuals_Fields.InValid_dsa_lvl_5((SALT31.StrType)le.dsa_lvl_5);
    SELF.csr_raw1_Invalid := Individuals_Fields.InValid_csr_raw1((SALT31.StrType)le.csr_raw1);
    SELF.csr_raw2_Invalid := Individuals_Fields.InValid_csr_raw2((SALT31.StrType)le.csr_raw2);
    SELF.csr_raw3_Invalid := Individuals_Fields.InValid_csr_raw3((SALT31.StrType)le.csr_raw3);
    SELF.csr_raw4_Invalid := Individuals_Fields.InValid_csr_raw4((SALT31.StrType)le.csr_raw4);
    SELF.clean_csr_expire_date_Invalid := Individuals_Fields.InValid_clean_csr_expire_date((SALT31.StrType)le.clean_csr_expire_date);
    SELF.clean_csr_issue_date_Invalid := Individuals_Fields.InValid_clean_csr_issue_date((SALT31.StrType)le.clean_csr_issue_date);
    SELF.sanction_id_Invalid := Individuals_Fields.InValid_sanction_id((SALT31.StrType)le.sanction_id);
    SELF.sanction_action_code_Invalid := Individuals_Fields.InValid_sanction_action_code((SALT31.StrType)le.sanction_action_code);
    SELF.sanction_action_description_Invalid := Individuals_Fields.InValid_sanction_action_description((SALT31.StrType)le.sanction_action_description);
    SELF.sanction_board_code_Invalid := Individuals_Fields.InValid_sanction_board_code((SALT31.StrType)le.sanction_board_code);
    SELF.sanction_board_description_Invalid := Individuals_Fields.InValid_sanction_board_description((SALT31.StrType)le.sanction_board_description);
    SELF.action_date_Invalid := Individuals_Fields.InValid_action_date((SALT31.StrType)le.action_date);
    SELF.sanction_period_start_date_Invalid := Individuals_Fields.InValid_sanction_period_start_date((SALT31.StrType)le.sanction_period_start_date);
    SELF.sanction_period_end_date_Invalid := Individuals_Fields.InValid_sanction_period_end_date((SALT31.StrType)le.sanction_period_end_date);
    SELF.month_duration_Invalid := Individuals_Fields.InValid_month_duration((SALT31.StrType)le.month_duration);
    SELF.fine_amount_Invalid := Individuals_Fields.InValid_fine_amount((SALT31.StrType)le.fine_amount);
    SELF.offense_code_Invalid := Individuals_Fields.InValid_offense_code((SALT31.StrType)le.offense_code);
    SELF.offense_description_Invalid := Individuals_Fields.InValid_offense_description((SALT31.StrType)le.offense_description);
    SELF.offense_date_Invalid := Individuals_Fields.InValid_offense_date((SALT31.StrType)le.offense_date);
    SELF.clean_offense_date_Invalid := Individuals_Fields.InValid_clean_offense_date((SALT31.StrType)le.clean_offense_date);
    SELF.clean_action_date_Invalid := Individuals_Fields.InValid_clean_action_date((SALT31.StrType)le.clean_action_date);
    SELF.clean_sanction_period_start_date_Invalid := Individuals_Fields.InValid_clean_sanction_period_start_date((SALT31.StrType)le.clean_sanction_period_start_date);
    SELF.clean_sanction_period_end_date_Invalid := Individuals_Fields.InValid_clean_sanction_period_end_date((SALT31.StrType)le.clean_sanction_period_end_date);
    SELF.gsa_sanction_id_Invalid := Individuals_Fields.InValid_gsa_sanction_id((SALT31.StrType)le.gsa_sanction_id);
    SELF.gsa_first_Invalid := Individuals_Fields.InValid_gsa_first((SALT31.StrType)le.gsa_first);
    SELF.gsa_middle_Invalid := Individuals_Fields.InValid_gsa_middle((SALT31.StrType)le.gsa_middle);
    SELF.gsa_last_Invalid := Individuals_Fields.InValid_gsa_last((SALT31.StrType)le.gsa_last);
    SELF.gsa_suffix_Invalid := Individuals_Fields.InValid_gsa_suffix((SALT31.StrType)le.gsa_suffix);
    SELF.gsa_city_Invalid := Individuals_Fields.InValid_gsa_city((SALT31.StrType)le.gsa_city);
    SELF.gsa_state_Invalid := Individuals_Fields.InValid_gsa_state((SALT31.StrType)le.gsa_state);
    SELF.gsa_zip_Invalid := Individuals_Fields.InValid_gsa_zip((SALT31.StrType)le.gsa_zip);
    SELF.date_Invalid := Individuals_Fields.InValid_date((SALT31.StrType)le.date);
    SELF.agency_Invalid := Individuals_Fields.InValid_agency((SALT31.StrType)le.agency);
    SELF.confidence_Invalid := Individuals_Fields.InValid_confidence((SALT31.StrType)le.confidence);
    SELF.clean_gsa_first_Invalid := Individuals_Fields.InValid_clean_gsa_first((SALT31.StrType)le.clean_gsa_first);
    SELF.clean_gsa_middle_Invalid := Individuals_Fields.InValid_clean_gsa_middle((SALT31.StrType)le.clean_gsa_middle);
    SELF.clean_gsa_last_Invalid := Individuals_Fields.InValid_clean_gsa_last((SALT31.StrType)le.clean_gsa_last);
    SELF.clean_gsa_suffix_Invalid := Individuals_Fields.InValid_clean_gsa_suffix((SALT31.StrType)le.clean_gsa_suffix);
    SELF.clean_gsa_city_Invalid := Individuals_Fields.InValid_clean_gsa_city((SALT31.StrType)le.clean_gsa_city);
    SELF.clean_gsa_state_Invalid := Individuals_Fields.InValid_clean_gsa_state((SALT31.StrType)le.clean_gsa_state);
    SELF.clean_gsa_zip_Invalid := Individuals_Fields.InValid_clean_gsa_zip((SALT31.StrType)le.clean_gsa_zip);
    SELF.clean_gsa_action_date_Invalid := Individuals_Fields.InValid_clean_gsa_action_date((SALT31.StrType)le.clean_gsa_action_date);
    SELF.clean_gsa_date_Invalid := Individuals_Fields.InValid_clean_gsa_date((SALT31.StrType)le.clean_gsa_date);
    SELF.fax_Invalid := Individuals_Fields.InValid_fax((SALT31.StrType)le.fax);
    SELF.phone_Invalid := Individuals_Fields.InValid_phone((SALT31.StrType)le.phone);
    SELF.certification_code_Invalid := Individuals_Fields.InValid_certification_code((SALT31.StrType)le.certification_code);
    SELF.certification_description_Invalid := Individuals_Fields.InValid_certification_description((SALT31.StrType)le.certification_description);
    SELF.board_code_Invalid := Individuals_Fields.InValid_board_code((SALT31.StrType)le.board_code);
    SELF.board_description_Invalid := Individuals_Fields.InValid_board_description((SALT31.StrType)le.board_description);
    SELF.expiration_year_Invalid := Individuals_Fields.InValid_expiration_year((SALT31.StrType)le.expiration_year);
    SELF.issue_year_Invalid := Individuals_Fields.InValid_issue_year((SALT31.StrType)le.issue_year);
    SELF.renewal_year_Invalid := Individuals_Fields.InValid_renewal_year((SALT31.StrType)le.renewal_year);
    SELF.lifetime_flag_Invalid := Individuals_Fields.InValid_lifetime_flag((SALT31.StrType)le.lifetime_flag);
    SELF.covered_recipient_id_Invalid := Individuals_Fields.InValid_covered_recipient_id((SALT31.StrType)le.covered_recipient_id);
    SELF.cov_rcp_raw_state_code_Invalid := Individuals_Fields.InValid_cov_rcp_raw_state_code((SALT31.StrType)le.cov_rcp_raw_state_code);
    SELF.cov_rcp_raw_full_name_Invalid := Individuals_Fields.InValid_cov_rcp_raw_full_name((SALT31.StrType)le.cov_rcp_raw_full_name);
    SELF.cov_rcp_raw_attribute1_Invalid := Individuals_Fields.InValid_cov_rcp_raw_attribute1((SALT31.StrType)le.cov_rcp_raw_attribute1);
    SELF.cov_rcp_raw_attribute2_Invalid := Individuals_Fields.InValid_cov_rcp_raw_attribute2((SALT31.StrType)le.cov_rcp_raw_attribute2);
    SELF.cov_rcp_raw_attribute3_Invalid := Individuals_Fields.InValid_cov_rcp_raw_attribute3((SALT31.StrType)le.cov_rcp_raw_attribute3);
    SELF.cov_rcp_raw_attribute4_Invalid := Individuals_Fields.InValid_cov_rcp_raw_attribute4((SALT31.StrType)le.cov_rcp_raw_attribute4);
    SELF.hms_scid_Invalid := Individuals_Fields.InValid_hms_scid((SALT31.StrType)le.hms_scid);
    SELF.school_name_Invalid := Individuals_Fields.InValid_school_name((SALT31.StrType)le.school_name);
    SELF.grad_year_Invalid := Individuals_Fields.InValid_grad_year((SALT31.StrType)le.grad_year);
    SELF.lang_code_Invalid := Individuals_Fields.InValid_lang_code((SALT31.StrType)le.lang_code);
    SELF.language_Invalid := Individuals_Fields.InValid_language((SALT31.StrType)le.language);
    SELF.specialty_description_Invalid := Individuals_Fields.InValid_specialty_description((SALT31.StrType)le.specialty_description);
    SELF.clean_phone_Invalid := Individuals_Fields.InValid_clean_phone((SALT31.StrType)le.clean_phone);
    SELF.bdid_Invalid := Individuals_Fields.InValid_bdid((SALT31.StrType)le.bdid);
    SELF.bdid_score_Invalid := Individuals_Fields.InValid_bdid_score((SALT31.StrType)le.bdid_score);
    SELF.did_Invalid := Individuals_Fields.InValid_did((SALT31.StrType)le.did);
    SELF.did_score_Invalid := Individuals_Fields.InValid_did_score((SALT31.StrType)le.did_score);
    SELF.clean_dob_Invalid := Individuals_Fields.InValid_clean_dob((SALT31.StrType)le.clean_dob);
    SELF.best_dob_Invalid := Individuals_Fields.InValid_best_dob((SALT31.StrType)le.best_dob);
    SELF.best_ssn_Invalid := Individuals_Fields.InValid_best_ssn((SALT31.StrType)le.best_ssn);
    SELF.rec_deactivated_date_Invalid := Individuals_Fields.InValid_rec_deactivated_date((SALT31.StrType)le.rec_deactivated_date);
    SELF.superceeding_piid_Invalid := Individuals_Fields.InValid_superceeding_piid((SALT31.StrType)le.superceeding_piid);
    SELF.dotid_Invalid := Individuals_Fields.InValid_dotid((SALT31.StrType)le.dotid);
    SELF.dotscore_Invalid := Individuals_Fields.InValid_dotscore((SALT31.StrType)le.dotscore);
    SELF.dotweight_Invalid := Individuals_Fields.InValid_dotweight((SALT31.StrType)le.dotweight);
    SELF.empid_Invalid := Individuals_Fields.InValid_empid((SALT31.StrType)le.empid);
    SELF.empscore_Invalid := Individuals_Fields.InValid_empscore((SALT31.StrType)le.empscore);
    SELF.empweight_Invalid := Individuals_Fields.InValid_empweight((SALT31.StrType)le.empweight);
    SELF.powid_Invalid := Individuals_Fields.InValid_powid((SALT31.StrType)le.powid);
    SELF.powscore_Invalid := Individuals_Fields.InValid_powscore((SALT31.StrType)le.powscore);
    SELF.powweight_Invalid := Individuals_Fields.InValid_powweight((SALT31.StrType)le.powweight);
    SELF.proxid_Invalid := Individuals_Fields.InValid_proxid((SALT31.StrType)le.proxid);
    SELF.proxscore_Invalid := Individuals_Fields.InValid_proxscore((SALT31.StrType)le.proxscore);
    SELF.proxweight_Invalid := Individuals_Fields.InValid_proxweight((SALT31.StrType)le.proxweight);
    SELF.seleid_Invalid := Individuals_Fields.InValid_seleid((SALT31.StrType)le.seleid);
    SELF.selescore_Invalid := Individuals_Fields.InValid_selescore((SALT31.StrType)le.selescore);
    SELF.seleweight_Invalid := Individuals_Fields.InValid_seleweight((SALT31.StrType)le.seleweight);
    SELF.orgid_Invalid := Individuals_Fields.InValid_orgid((SALT31.StrType)le.orgid);
    SELF.orgscore_Invalid := Individuals_Fields.InValid_orgscore((SALT31.StrType)le.orgscore);
    SELF.orgweight_Invalid := Individuals_Fields.InValid_orgweight((SALT31.StrType)le.orgweight);
    SELF.ultid_Invalid := Individuals_Fields.InValid_ultid((SALT31.StrType)le.ultid);
    SELF.ultscore_Invalid := Individuals_Fields.InValid_ultscore((SALT31.StrType)le.ultscore);
    SELF.ultweight_Invalid := Individuals_Fields.InValid_ultweight((SALT31.StrType)le.ultweight);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.hms_piid_Invalid << 0 ) + ( le.first_Invalid << 2 ) + ( le.middle_Invalid << 4 ) + ( le.last_Invalid << 6 ) + ( le.suffix_Invalid << 8 ) + ( le.cred_Invalid << 10 ) + ( le.practitioner_type_Invalid << 12 ) + ( le.active_Invalid << 14 ) + ( le.vendible_Invalid << 16 ) + ( le.npi_num_Invalid << 18 ) + ( le.npi_enumeration_date_Invalid << 20 ) + ( le.npi_deactivation_date_Invalid << 22 ) + ( le.npi_reactivation_date_Invalid << 24 ) + ( le.npi_taxonomy_code_Invalid << 26 ) + ( le.upin_Invalid << 28 ) + ( le.medicare_participation_flag_Invalid << 30 ) + ( le.date_born_Invalid << 32 ) + ( le.date_died_Invalid << 34 ) + ( le.pid_Invalid << 36 ) + ( le.src_Invalid << 38 ) + ( le.date_vendor_first_reported_Invalid << 40 ) + ( le.date_vendor_last_reported_Invalid << 42 ) + ( le.date_first_seen_Invalid << 44 ) + ( le.date_last_seen_Invalid << 46 ) + ( le.record_type_Invalid << 48 ) + ( le.source_rid_Invalid << 50 ) + ( le.lnpid_Invalid << 52 ) + ( le.fname_Invalid << 54 ) + ( le.mname_Invalid << 56 ) + ( le.lname_Invalid << 58 ) + ( le.name_suffix_Invalid << 60 ) + ( le.nametype_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.nid_Invalid << 0 ) + ( le.clean_npi_enumeration_date_Invalid << 2 ) + ( le.clean_npi_deactivation_date_Invalid << 4 ) + ( le.clean_npi_reactivation_date_Invalid << 6 ) + ( le.clean_date_born_Invalid << 8 ) + ( le.clean_date_died_Invalid << 10 ) + ( le.clean_company_name_Invalid << 12 ) + ( le.prim_range_Invalid << 14 ) + ( le.predir_Invalid << 16 ) + ( le.prim_name_Invalid << 18 ) + ( le.addr_suffix_Invalid << 20 ) + ( le.postdir_Invalid << 22 ) + ( le.unit_desig_Invalid << 24 ) + ( le.sec_range_Invalid << 26 ) + ( le.p_city_name_Invalid << 28 ) + ( le.v_city_name_Invalid << 30 ) + ( le.st_Invalid << 32 ) + ( le.zip_Invalid << 34 ) + ( le.zip4_Invalid << 36 ) + ( le.cart_Invalid << 38 ) + ( le.cr_sort_sz_Invalid << 40 ) + ( le.lot_Invalid << 42 ) + ( le.lot_order_Invalid << 44 ) + ( le.dbpc_Invalid << 46 ) + ( le.chk_digit_Invalid << 48 ) + ( le.rec_type_Invalid << 50 ) + ( le.fips_st_Invalid << 52 ) + ( le.fips_county_Invalid << 54 ) + ( le.geo_lat_Invalid << 56 ) + ( le.geo_long_Invalid << 58 ) + ( le.msa_Invalid << 60 ) + ( le.geo_blk_Invalid << 62 );
    SELF.ScrubsBits3 := ( le.geo_match_Invalid << 0 ) + ( le.err_stat_Invalid << 2 ) + ( le.rawaid_Invalid << 4 ) + ( le.aceaid_Invalid << 6 ) + ( le.firm_name_Invalid << 8 ) + ( le.lid_Invalid << 10 ) + ( le.agid_Invalid << 12 ) + ( le.address_std_code_Invalid << 14 ) + ( le.latitude_Invalid << 16 ) + ( le.longitude_Invalid << 18 ) + ( le.prepped_addr1_Invalid << 20 ) + ( le.prepped_addr2_Invalid << 22 ) + ( le.addr_type_Invalid << 24 ) + ( le.state_license_state_Invalid << 26 ) + ( le.state_license_number_Invalid << 28 ) + ( le.state_license_type_Invalid << 30 ) + ( le.state_license_active_Invalid << 32 ) + ( le.state_license_expire_Invalid << 34 ) + ( le.state_license_qualifier_Invalid << 36 ) + ( le.state_license_sub_qualifier_Invalid << 38 ) + ( le.state_license_issued_Invalid << 40 ) + ( le.clean_state_license_expire_Invalid << 42 ) + ( le.clean_state_license_issued_Invalid << 44 ) + ( le.dea_num_Invalid << 46 ) + ( le.dea_bac_Invalid << 48 ) + ( le.dea_sub_bac_Invalid << 50 ) + ( le.dea_schedule_Invalid << 52 ) + ( le.dea_expire_Invalid << 54 ) + ( le.dea_active_Invalid << 56 ) + ( le.clean_dea_expire_Invalid << 58 ) + ( le.csr_number_Invalid << 60 ) + ( le.csr_state_Invalid << 62 );
    SELF.ScrubsBits4 := ( le.csr_expire_date_Invalid << 0 ) + ( le.csr_issue_date_Invalid << 2 ) + ( le.dsa_lvl_2_Invalid << 4 ) + ( le.dsa_lvl_2n_Invalid << 6 ) + ( le.dsa_lvl_3_Invalid << 8 ) + ( le.dsa_lvl_3n_Invalid << 10 ) + ( le.dsa_lvl_4_Invalid << 12 ) + ( le.dsa_lvl_5_Invalid << 14 ) + ( le.csr_raw1_Invalid << 16 ) + ( le.csr_raw2_Invalid << 18 ) + ( le.csr_raw3_Invalid << 20 ) + ( le.csr_raw4_Invalid << 22 ) + ( le.clean_csr_expire_date_Invalid << 24 ) + ( le.clean_csr_issue_date_Invalid << 26 ) + ( le.sanction_id_Invalid << 28 ) + ( le.sanction_action_code_Invalid << 30 ) + ( le.sanction_action_description_Invalid << 32 ) + ( le.sanction_board_code_Invalid << 34 ) + ( le.sanction_board_description_Invalid << 36 ) + ( le.action_date_Invalid << 38 ) + ( le.sanction_period_start_date_Invalid << 40 ) + ( le.sanction_period_end_date_Invalid << 42 ) + ( le.month_duration_Invalid << 44 ) + ( le.fine_amount_Invalid << 46 ) + ( le.offense_code_Invalid << 48 ) + ( le.offense_description_Invalid << 50 ) + ( le.offense_date_Invalid << 52 ) + ( le.clean_offense_date_Invalid << 54 ) + ( le.clean_action_date_Invalid << 56 ) + ( le.clean_sanction_period_start_date_Invalid << 58 ) + ( le.clean_sanction_period_end_date_Invalid << 60 ) + ( le.gsa_sanction_id_Invalid << 62 );
    SELF.ScrubsBits5 := ( le.gsa_first_Invalid << 0 ) + ( le.gsa_middle_Invalid << 2 ) + ( le.gsa_last_Invalid << 4 ) + ( le.gsa_suffix_Invalid << 6 ) + ( le.gsa_city_Invalid << 8 ) + ( le.gsa_state_Invalid << 10 ) + ( le.gsa_zip_Invalid << 12 ) + ( le.date_Invalid << 14 ) + ( le.agency_Invalid << 16 ) + ( le.confidence_Invalid << 18 ) + ( le.clean_gsa_first_Invalid << 20 ) + ( le.clean_gsa_middle_Invalid << 22 ) + ( le.clean_gsa_last_Invalid << 24 ) + ( le.clean_gsa_suffix_Invalid << 26 ) + ( le.clean_gsa_city_Invalid << 28 ) + ( le.clean_gsa_state_Invalid << 30 ) + ( le.clean_gsa_zip_Invalid << 32 ) + ( le.clean_gsa_action_date_Invalid << 34 ) + ( le.clean_gsa_date_Invalid << 36 ) + ( le.fax_Invalid << 38 ) + ( le.phone_Invalid << 40 ) + ( le.certification_code_Invalid << 42 ) + ( le.certification_description_Invalid << 44 ) + ( le.board_code_Invalid << 46 ) + ( le.board_description_Invalid << 48 ) + ( le.expiration_year_Invalid << 50 ) + ( le.issue_year_Invalid << 52 ) + ( le.renewal_year_Invalid << 54 ) + ( le.lifetime_flag_Invalid << 56 ) + ( le.covered_recipient_id_Invalid << 58 ) + ( le.cov_rcp_raw_state_code_Invalid << 60 ) + ( le.cov_rcp_raw_full_name_Invalid << 62 );
    SELF.ScrubsBits6 := ( le.cov_rcp_raw_attribute1_Invalid << 0 ) + ( le.cov_rcp_raw_attribute2_Invalid << 2 ) + ( le.cov_rcp_raw_attribute3_Invalid << 4 ) + ( le.cov_rcp_raw_attribute4_Invalid << 6 ) + ( le.hms_scid_Invalid << 8 ) + ( le.school_name_Invalid << 10 ) + ( le.grad_year_Invalid << 12 ) + ( le.lang_code_Invalid << 14 ) + ( le.language_Invalid << 16 ) + ( le.specialty_description_Invalid << 18 ) + ( le.clean_phone_Invalid << 20 ) + ( le.bdid_Invalid << 22 ) + ( le.bdid_score_Invalid << 24 ) + ( le.did_Invalid << 26 ) + ( le.did_score_Invalid << 28 ) + ( le.clean_dob_Invalid << 30 ) + ( le.best_dob_Invalid << 32 ) + ( le.best_ssn_Invalid << 34 ) + ( le.rec_deactivated_date_Invalid << 36 ) + ( le.superceeding_piid_Invalid << 38 ) + ( le.dotid_Invalid << 40 ) + ( le.dotscore_Invalid << 42 ) + ( le.dotweight_Invalid << 44 ) + ( le.empid_Invalid << 46 ) + ( le.empscore_Invalid << 48 ) + ( le.empweight_Invalid << 50 ) + ( le.powid_Invalid << 52 ) + ( le.powscore_Invalid << 54 ) + ( le.powweight_Invalid << 56 ) + ( le.proxid_Invalid << 58 ) + ( le.proxscore_Invalid << 60 ) + ( le.proxweight_Invalid << 62 );
    SELF.ScrubsBits7 := ( le.seleid_Invalid << 0 ) + ( le.selescore_Invalid << 2 ) + ( le.seleweight_Invalid << 4 ) + ( le.orgid_Invalid << 6 ) + ( le.orgscore_Invalid << 8 ) + ( le.orgweight_Invalid << 10 ) + ( le.ultid_Invalid << 12 ) + ( le.ultscore_Invalid << 14 ) + ( le.ultweight_Invalid << 16 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Individuals_Layout_Individuals);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.hms_piid_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.first_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.middle_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.last_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.cred_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.practitioner_type_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.active_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.vendible_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.npi_num_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.npi_enumeration_date_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.npi_deactivation_date_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.npi_reactivation_date_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.npi_taxonomy_code_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.upin_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.medicare_participation_flag_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.date_born_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.date_died_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.pid_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.src_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.source_rid_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.lnpid_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.nametype_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.nid_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.clean_npi_enumeration_date_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.clean_npi_deactivation_date_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.clean_npi_reactivation_date_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.clean_date_born_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.clean_date_died_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.clean_company_name_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF.prim_range_Invalid := (le.ScrubsBits2 >> 14) & 3;
    SELF.predir_Invalid := (le.ScrubsBits2 >> 16) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits2 >> 18) & 3;
    SELF.addr_suffix_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.postdir_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.unit_desig_Invalid := (le.ScrubsBits2 >> 24) & 3;
    SELF.sec_range_Invalid := (le.ScrubsBits2 >> 26) & 3;
    SELF.p_city_name_Invalid := (le.ScrubsBits2 >> 28) & 3;
    SELF.v_city_name_Invalid := (le.ScrubsBits2 >> 30) & 3;
    SELF.st_Invalid := (le.ScrubsBits2 >> 32) & 3;
    SELF.zip_Invalid := (le.ScrubsBits2 >> 34) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits2 >> 36) & 3;
    SELF.cart_Invalid := (le.ScrubsBits2 >> 38) & 3;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits2 >> 40) & 3;
    SELF.lot_Invalid := (le.ScrubsBits2 >> 42) & 3;
    SELF.lot_order_Invalid := (le.ScrubsBits2 >> 44) & 3;
    SELF.dbpc_Invalid := (le.ScrubsBits2 >> 46) & 3;
    SELF.chk_digit_Invalid := (le.ScrubsBits2 >> 48) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits2 >> 50) & 3;
    SELF.fips_st_Invalid := (le.ScrubsBits2 >> 52) & 3;
    SELF.fips_county_Invalid := (le.ScrubsBits2 >> 54) & 3;
    SELF.geo_lat_Invalid := (le.ScrubsBits2 >> 56) & 3;
    SELF.geo_long_Invalid := (le.ScrubsBits2 >> 58) & 3;
    SELF.msa_Invalid := (le.ScrubsBits2 >> 60) & 3;
    SELF.geo_blk_Invalid := (le.ScrubsBits2 >> 62) & 3;
    SELF.geo_match_Invalid := (le.ScrubsBits3 >> 0) & 3;
    SELF.err_stat_Invalid := (le.ScrubsBits3 >> 2) & 3;
    SELF.rawaid_Invalid := (le.ScrubsBits3 >> 4) & 3;
    SELF.aceaid_Invalid := (le.ScrubsBits3 >> 6) & 3;
    SELF.firm_name_Invalid := (le.ScrubsBits3 >> 8) & 3;
    SELF.lid_Invalid := (le.ScrubsBits3 >> 10) & 3;
    SELF.agid_Invalid := (le.ScrubsBits3 >> 12) & 3;
    SELF.address_std_code_Invalid := (le.ScrubsBits3 >> 14) & 3;
    SELF.latitude_Invalid := (le.ScrubsBits3 >> 16) & 3;
    SELF.longitude_Invalid := (le.ScrubsBits3 >> 18) & 3;
    SELF.prepped_addr1_Invalid := (le.ScrubsBits3 >> 20) & 3;
    SELF.prepped_addr2_Invalid := (le.ScrubsBits3 >> 22) & 3;
    SELF.addr_type_Invalid := (le.ScrubsBits3 >> 24) & 3;
    SELF.state_license_state_Invalid := (le.ScrubsBits3 >> 26) & 3;
    SELF.state_license_number_Invalid := (le.ScrubsBits3 >> 28) & 3;
    SELF.state_license_type_Invalid := (le.ScrubsBits3 >> 30) & 3;
    SELF.state_license_active_Invalid := (le.ScrubsBits3 >> 32) & 3;
    SELF.state_license_expire_Invalid := (le.ScrubsBits3 >> 34) & 3;
    SELF.state_license_qualifier_Invalid := (le.ScrubsBits3 >> 36) & 3;
    SELF.state_license_sub_qualifier_Invalid := (le.ScrubsBits3 >> 38) & 3;
    SELF.state_license_issued_Invalid := (le.ScrubsBits3 >> 40) & 3;
    SELF.clean_state_license_expire_Invalid := (le.ScrubsBits3 >> 42) & 3;
    SELF.clean_state_license_issued_Invalid := (le.ScrubsBits3 >> 44) & 3;
    SELF.dea_num_Invalid := (le.ScrubsBits3 >> 46) & 3;
    SELF.dea_bac_Invalid := (le.ScrubsBits3 >> 48) & 3;
    SELF.dea_sub_bac_Invalid := (le.ScrubsBits3 >> 50) & 3;
    SELF.dea_schedule_Invalid := (le.ScrubsBits3 >> 52) & 3;
    SELF.dea_expire_Invalid := (le.ScrubsBits3 >> 54) & 3;
    SELF.dea_active_Invalid := (le.ScrubsBits3 >> 56) & 3;
    SELF.clean_dea_expire_Invalid := (le.ScrubsBits3 >> 58) & 3;
    SELF.csr_number_Invalid := (le.ScrubsBits3 >> 60) & 3;
    SELF.csr_state_Invalid := (le.ScrubsBits3 >> 62) & 3;
    SELF.csr_expire_date_Invalid := (le.ScrubsBits4 >> 0) & 3;
    SELF.csr_issue_date_Invalid := (le.ScrubsBits4 >> 2) & 3;
    SELF.dsa_lvl_2_Invalid := (le.ScrubsBits4 >> 4) & 3;
    SELF.dsa_lvl_2n_Invalid := (le.ScrubsBits4 >> 6) & 3;
    SELF.dsa_lvl_3_Invalid := (le.ScrubsBits4 >> 8) & 3;
    SELF.dsa_lvl_3n_Invalid := (le.ScrubsBits4 >> 10) & 3;
    SELF.dsa_lvl_4_Invalid := (le.ScrubsBits4 >> 12) & 3;
    SELF.dsa_lvl_5_Invalid := (le.ScrubsBits4 >> 14) & 3;
    SELF.csr_raw1_Invalid := (le.ScrubsBits4 >> 16) & 3;
    SELF.csr_raw2_Invalid := (le.ScrubsBits4 >> 18) & 3;
    SELF.csr_raw3_Invalid := (le.ScrubsBits4 >> 20) & 3;
    SELF.csr_raw4_Invalid := (le.ScrubsBits4 >> 22) & 3;
    SELF.clean_csr_expire_date_Invalid := (le.ScrubsBits4 >> 24) & 3;
    SELF.clean_csr_issue_date_Invalid := (le.ScrubsBits4 >> 26) & 3;
    SELF.sanction_id_Invalid := (le.ScrubsBits4 >> 28) & 3;
    SELF.sanction_action_code_Invalid := (le.ScrubsBits4 >> 30) & 3;
    SELF.sanction_action_description_Invalid := (le.ScrubsBits4 >> 32) & 3;
    SELF.sanction_board_code_Invalid := (le.ScrubsBits4 >> 34) & 3;
    SELF.sanction_board_description_Invalid := (le.ScrubsBits4 >> 36) & 3;
    SELF.action_date_Invalid := (le.ScrubsBits4 >> 38) & 3;
    SELF.sanction_period_start_date_Invalid := (le.ScrubsBits4 >> 40) & 3;
    SELF.sanction_period_end_date_Invalid := (le.ScrubsBits4 >> 42) & 3;
    SELF.month_duration_Invalid := (le.ScrubsBits4 >> 44) & 3;
    SELF.fine_amount_Invalid := (le.ScrubsBits4 >> 46) & 3;
    SELF.offense_code_Invalid := (le.ScrubsBits4 >> 48) & 3;
    SELF.offense_description_Invalid := (le.ScrubsBits4 >> 50) & 3;
    SELF.offense_date_Invalid := (le.ScrubsBits4 >> 52) & 3;
    SELF.clean_offense_date_Invalid := (le.ScrubsBits4 >> 54) & 3;
    SELF.clean_action_date_Invalid := (le.ScrubsBits4 >> 56) & 3;
    SELF.clean_sanction_period_start_date_Invalid := (le.ScrubsBits4 >> 58) & 3;
    SELF.clean_sanction_period_end_date_Invalid := (le.ScrubsBits4 >> 60) & 3;
    SELF.gsa_sanction_id_Invalid := (le.ScrubsBits4 >> 62) & 3;
    SELF.gsa_first_Invalid := (le.ScrubsBits5 >> 0) & 3;
    SELF.gsa_middle_Invalid := (le.ScrubsBits5 >> 2) & 3;
    SELF.gsa_last_Invalid := (le.ScrubsBits5 >> 4) & 3;
    SELF.gsa_suffix_Invalid := (le.ScrubsBits5 >> 6) & 3;
    SELF.gsa_city_Invalid := (le.ScrubsBits5 >> 8) & 3;
    SELF.gsa_state_Invalid := (le.ScrubsBits5 >> 10) & 3;
    SELF.gsa_zip_Invalid := (le.ScrubsBits5 >> 12) & 3;
    SELF.date_Invalid := (le.ScrubsBits5 >> 14) & 3;
    SELF.agency_Invalid := (le.ScrubsBits5 >> 16) & 3;
    SELF.confidence_Invalid := (le.ScrubsBits5 >> 18) & 3;
    SELF.clean_gsa_first_Invalid := (le.ScrubsBits5 >> 20) & 3;
    SELF.clean_gsa_middle_Invalid := (le.ScrubsBits5 >> 22) & 3;
    SELF.clean_gsa_last_Invalid := (le.ScrubsBits5 >> 24) & 3;
    SELF.clean_gsa_suffix_Invalid := (le.ScrubsBits5 >> 26) & 3;
    SELF.clean_gsa_city_Invalid := (le.ScrubsBits5 >> 28) & 3;
    SELF.clean_gsa_state_Invalid := (le.ScrubsBits5 >> 30) & 3;
    SELF.clean_gsa_zip_Invalid := (le.ScrubsBits5 >> 32) & 3;
    SELF.clean_gsa_action_date_Invalid := (le.ScrubsBits5 >> 34) & 3;
    SELF.clean_gsa_date_Invalid := (le.ScrubsBits5 >> 36) & 3;
    SELF.fax_Invalid := (le.ScrubsBits5 >> 38) & 3;
    SELF.phone_Invalid := (le.ScrubsBits5 >> 40) & 3;
    SELF.certification_code_Invalid := (le.ScrubsBits5 >> 42) & 3;
    SELF.certification_description_Invalid := (le.ScrubsBits5 >> 44) & 3;
    SELF.board_code_Invalid := (le.ScrubsBits5 >> 46) & 3;
    SELF.board_description_Invalid := (le.ScrubsBits5 >> 48) & 3;
    SELF.expiration_year_Invalid := (le.ScrubsBits5 >> 50) & 3;
    SELF.issue_year_Invalid := (le.ScrubsBits5 >> 52) & 3;
    SELF.renewal_year_Invalid := (le.ScrubsBits5 >> 54) & 3;
    SELF.lifetime_flag_Invalid := (le.ScrubsBits5 >> 56) & 3;
    SELF.covered_recipient_id_Invalid := (le.ScrubsBits5 >> 58) & 3;
    SELF.cov_rcp_raw_state_code_Invalid := (le.ScrubsBits5 >> 60) & 3;
    SELF.cov_rcp_raw_full_name_Invalid := (le.ScrubsBits5 >> 62) & 3;
    SELF.cov_rcp_raw_attribute1_Invalid := (le.ScrubsBits6 >> 0) & 3;
    SELF.cov_rcp_raw_attribute2_Invalid := (le.ScrubsBits6 >> 2) & 3;
    SELF.cov_rcp_raw_attribute3_Invalid := (le.ScrubsBits6 >> 4) & 3;
    SELF.cov_rcp_raw_attribute4_Invalid := (le.ScrubsBits6 >> 6) & 3;
    SELF.hms_scid_Invalid := (le.ScrubsBits6 >> 8) & 3;
    SELF.school_name_Invalid := (le.ScrubsBits6 >> 10) & 3;
    SELF.grad_year_Invalid := (le.ScrubsBits6 >> 12) & 3;
    SELF.lang_code_Invalid := (le.ScrubsBits6 >> 14) & 3;
    SELF.language_Invalid := (le.ScrubsBits6 >> 16) & 3;
    SELF.specialty_description_Invalid := (le.ScrubsBits6 >> 18) & 3;
    SELF.clean_phone_Invalid := (le.ScrubsBits6 >> 20) & 3;
    SELF.bdid_Invalid := (le.ScrubsBits6 >> 22) & 3;
    SELF.bdid_score_Invalid := (le.ScrubsBits6 >> 24) & 3;
    SELF.did_Invalid := (le.ScrubsBits6 >> 26) & 3;
    SELF.did_score_Invalid := (le.ScrubsBits6 >> 28) & 3;
    SELF.clean_dob_Invalid := (le.ScrubsBits6 >> 30) & 3;
    SELF.best_dob_Invalid := (le.ScrubsBits6 >> 32) & 3;
    SELF.best_ssn_Invalid := (le.ScrubsBits6 >> 34) & 3;
    SELF.rec_deactivated_date_Invalid := (le.ScrubsBits6 >> 36) & 3;
    SELF.superceeding_piid_Invalid := (le.ScrubsBits6 >> 38) & 3;
    SELF.dotid_Invalid := (le.ScrubsBits6 >> 40) & 3;
    SELF.dotscore_Invalid := (le.ScrubsBits6 >> 42) & 3;
    SELF.dotweight_Invalid := (le.ScrubsBits6 >> 44) & 3;
    SELF.empid_Invalid := (le.ScrubsBits6 >> 46) & 3;
    SELF.empscore_Invalid := (le.ScrubsBits6 >> 48) & 3;
    SELF.empweight_Invalid := (le.ScrubsBits6 >> 50) & 3;
    SELF.powid_Invalid := (le.ScrubsBits6 >> 52) & 3;
    SELF.powscore_Invalid := (le.ScrubsBits6 >> 54) & 3;
    SELF.powweight_Invalid := (le.ScrubsBits6 >> 56) & 3;
    SELF.proxid_Invalid := (le.ScrubsBits6 >> 58) & 3;
    SELF.proxscore_Invalid := (le.ScrubsBits6 >> 60) & 3;
    SELF.proxweight_Invalid := (le.ScrubsBits6 >> 62) & 3;
    SELF.seleid_Invalid := (le.ScrubsBits7 >> 0) & 3;
    SELF.selescore_Invalid := (le.ScrubsBits7 >> 2) & 3;
    SELF.seleweight_Invalid := (le.ScrubsBits7 >> 4) & 3;
    SELF.orgid_Invalid := (le.ScrubsBits7 >> 6) & 3;
    SELF.orgscore_Invalid := (le.ScrubsBits7 >> 8) & 3;
    SELF.orgweight_Invalid := (le.ScrubsBits7 >> 10) & 3;
    SELF.ultid_Invalid := (le.ScrubsBits7 >> 12) & 3;
    SELF.ultscore_Invalid := (le.ScrubsBits7 >> 14) & 3;
    SELF.ultweight_Invalid := (le.ScrubsBits7 >> 16) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
    FromNew := FromNone(InFile).ExpandedInfile;
  EXPORT Changed := JOIN(ExpandedInfile,FromNew, LEFT.source_rid=RIGHT.source_rid AND (LEFT.hms_piid_Invalid <> RIGHT.hms_piid_Invalid OR LEFT.first_Invalid <> RIGHT.first_Invalid OR LEFT.middle_Invalid <> RIGHT.middle_Invalid OR LEFT.last_Invalid <> RIGHT.last_Invalid OR LEFT.suffix_Invalid <> RIGHT.suffix_Invalid OR LEFT.cred_Invalid <> RIGHT.cred_Invalid OR LEFT.practitioner_type_Invalid <> RIGHT.practitioner_type_Invalid OR LEFT.active_Invalid <> RIGHT.active_Invalid OR LEFT.vendible_Invalid <> RIGHT.vendible_Invalid OR LEFT.npi_num_Invalid <> RIGHT.npi_num_Invalid OR LEFT.npi_enumeration_date_Invalid <> RIGHT.npi_enumeration_date_Invalid OR LEFT.npi_deactivation_date_Invalid <> RIGHT.npi_deactivation_date_Invalid OR LEFT.npi_reactivation_date_Invalid <> RIGHT.npi_reactivation_date_Invalid OR LEFT.npi_taxonomy_code_Invalid <> RIGHT.npi_taxonomy_code_Invalid OR LEFT.upin_Invalid <> RIGHT.upin_Invalid OR LEFT.medicare_participation_flag_Invalid <> RIGHT.medicare_participation_flag_Invalid OR LEFT.date_born_Invalid <> RIGHT.date_born_Invalid OR LEFT.date_died_Invalid <> RIGHT.date_died_Invalid OR LEFT.pid_Invalid <> RIGHT.pid_Invalid OR LEFT.src_Invalid <> RIGHT.src_Invalid OR LEFT.date_vendor_first_reported_Invalid <> RIGHT.date_vendor_first_reported_Invalid OR LEFT.date_vendor_last_reported_Invalid <> RIGHT.date_vendor_last_reported_Invalid OR LEFT.date_first_seen_Invalid <> RIGHT.date_first_seen_Invalid OR LEFT.date_last_seen_Invalid <> RIGHT.date_last_seen_Invalid OR LEFT.record_type_Invalid <> RIGHT.record_type_Invalid OR LEFT.source_rid_Invalid <> RIGHT.source_rid_Invalid OR LEFT.lnpid_Invalid <> RIGHT.lnpid_Invalid OR LEFT.fname_Invalid <> RIGHT.fname_Invalid OR LEFT.mname_Invalid <> RIGHT.mname_Invalid OR LEFT.lname_Invalid <> RIGHT.lname_Invalid OR LEFT.name_suffix_Invalid <> RIGHT.name_suffix_Invalid OR LEFT.nametype_Invalid <> RIGHT.nametype_Invalid OR LEFT.nid_Invalid <> RIGHT.nid_Invalid OR LEFT.clean_npi_enumeration_date_Invalid <> RIGHT.clean_npi_enumeration_date_Invalid OR LEFT.clean_npi_deactivation_date_Invalid <> RIGHT.clean_npi_deactivation_date_Invalid OR LEFT.clean_npi_reactivation_date_Invalid <> RIGHT.clean_npi_reactivation_date_Invalid OR LEFT.clean_date_born_Invalid <> RIGHT.clean_date_born_Invalid OR LEFT.clean_date_died_Invalid <> RIGHT.clean_date_died_Invalid OR LEFT.clean_company_name_Invalid <> RIGHT.clean_company_name_Invalid OR LEFT.prim_range_Invalid <> RIGHT.prim_range_Invalid OR LEFT.predir_Invalid <> RIGHT.predir_Invalid OR LEFT.prim_name_Invalid <> RIGHT.prim_name_Invalid OR LEFT.addr_suffix_Invalid <> RIGHT.addr_suffix_Invalid OR LEFT.postdir_Invalid <> RIGHT.postdir_Invalid OR LEFT.unit_desig_Invalid <> RIGHT.unit_desig_Invalid OR LEFT.sec_range_Invalid <> RIGHT.sec_range_Invalid OR LEFT.p_city_name_Invalid <> RIGHT.p_city_name_Invalid OR LEFT.v_city_name_Invalid <> RIGHT.v_city_name_Invalid OR LEFT.st_Invalid <> RIGHT.st_Invalid OR LEFT.zip_Invalid <> RIGHT.zip_Invalid OR LEFT.zip4_Invalid <> RIGHT.zip4_Invalid OR LEFT.cart_Invalid <> RIGHT.cart_Invalid OR LEFT.cr_sort_sz_Invalid <> RIGHT.cr_sort_sz_Invalid OR LEFT.lot_Invalid <> RIGHT.lot_Invalid OR LEFT.lot_order_Invalid <> RIGHT.lot_order_Invalid OR LEFT.dbpc_Invalid <> RIGHT.dbpc_Invalid OR LEFT.chk_digit_Invalid <> RIGHT.chk_digit_Invalid OR LEFT.rec_type_Invalid <> RIGHT.rec_type_Invalid OR LEFT.fips_st_Invalid <> RIGHT.fips_st_Invalid OR LEFT.fips_county_Invalid <> RIGHT.fips_county_Invalid OR LEFT.geo_lat_Invalid <> RIGHT.geo_lat_Invalid OR LEFT.geo_long_Invalid <> RIGHT.geo_long_Invalid OR LEFT.msa_Invalid <> RIGHT.msa_Invalid OR LEFT.geo_blk_Invalid <> RIGHT.geo_blk_Invalid OR LEFT.geo_match_Invalid <> RIGHT.geo_match_Invalid OR LEFT.err_stat_Invalid <> RIGHT.err_stat_Invalid OR LEFT.rawaid_Invalid <> RIGHT.rawaid_Invalid OR LEFT.aceaid_Invalid <> RIGHT.aceaid_Invalid OR LEFT.firm_name_Invalid <> RIGHT.firm_name_Invalid OR LEFT.lid_Invalid <> RIGHT.lid_Invalid OR LEFT.agid_Invalid <> RIGHT.agid_Invalid OR LEFT.address_std_code_Invalid <> RIGHT.address_std_code_Invalid OR LEFT.latitude_Invalid <> RIGHT.latitude_Invalid OR LEFT.longitude_Invalid <> RIGHT.longitude_Invalid OR LEFT.prepped_addr1_Invalid <> RIGHT.prepped_addr1_Invalid OR LEFT.prepped_addr2_Invalid <> RIGHT.prepped_addr2_Invalid OR LEFT.addr_type_Invalid <> RIGHT.addr_type_Invalid OR LEFT.state_license_state_Invalid <> RIGHT.state_license_state_Invalid OR LEFT.state_license_number_Invalid <> RIGHT.state_license_number_Invalid OR LEFT.state_license_type_Invalid <> RIGHT.state_license_type_Invalid OR LEFT.state_license_active_Invalid <> RIGHT.state_license_active_Invalid OR LEFT.state_license_expire_Invalid <> RIGHT.state_license_expire_Invalid OR LEFT.state_license_qualifier_Invalid <> RIGHT.state_license_qualifier_Invalid OR LEFT.state_license_sub_qualifier_Invalid <> RIGHT.state_license_sub_qualifier_Invalid OR LEFT.state_license_issued_Invalid <> RIGHT.state_license_issued_Invalid OR LEFT.clean_state_license_expire_Invalid <> RIGHT.clean_state_license_expire_Invalid OR LEFT.clean_state_license_issued_Invalid <> RIGHT.clean_state_license_issued_Invalid OR LEFT.dea_num_Invalid <> RIGHT.dea_num_Invalid OR LEFT.dea_bac_Invalid <> RIGHT.dea_bac_Invalid OR LEFT.dea_sub_bac_Invalid <> RIGHT.dea_sub_bac_Invalid OR LEFT.dea_schedule_Invalid <> RIGHT.dea_schedule_Invalid OR LEFT.dea_expire_Invalid <> RIGHT.dea_expire_Invalid OR LEFT.dea_active_Invalid <> RIGHT.dea_active_Invalid OR LEFT.clean_dea_expire_Invalid <> RIGHT.clean_dea_expire_Invalid OR LEFT.csr_number_Invalid <> RIGHT.csr_number_Invalid OR LEFT.csr_state_Invalid <> RIGHT.csr_state_Invalid OR LEFT.csr_expire_date_Invalid <> RIGHT.csr_expire_date_Invalid OR LEFT.csr_issue_date_Invalid <> RIGHT.csr_issue_date_Invalid OR LEFT.dsa_lvl_2_Invalid <> RIGHT.dsa_lvl_2_Invalid OR LEFT.dsa_lvl_2n_Invalid <> RIGHT.dsa_lvl_2n_Invalid OR LEFT.dsa_lvl_3_Invalid <> RIGHT.dsa_lvl_3_Invalid OR LEFT.dsa_lvl_3n_Invalid <> RIGHT.dsa_lvl_3n_Invalid OR LEFT.dsa_lvl_4_Invalid <> RIGHT.dsa_lvl_4_Invalid OR LEFT.dsa_lvl_5_Invalid <> RIGHT.dsa_lvl_5_Invalid OR LEFT.csr_raw1_Invalid <> RIGHT.csr_raw1_Invalid OR LEFT.csr_raw2_Invalid <> RIGHT.csr_raw2_Invalid OR LEFT.csr_raw3_Invalid <> RIGHT.csr_raw3_Invalid OR LEFT.csr_raw4_Invalid <> RIGHT.csr_raw4_Invalid OR LEFT.clean_csr_expire_date_Invalid <> RIGHT.clean_csr_expire_date_Invalid OR LEFT.clean_csr_issue_date_Invalid <> RIGHT.clean_csr_issue_date_Invalid OR LEFT.sanction_id_Invalid <> RIGHT.sanction_id_Invalid OR LEFT.sanction_action_code_Invalid <> RIGHT.sanction_action_code_Invalid OR LEFT.sanction_action_description_Invalid <> RIGHT.sanction_action_description_Invalid OR LEFT.sanction_board_code_Invalid <> RIGHT.sanction_board_code_Invalid OR LEFT.sanction_board_description_Invalid <> RIGHT.sanction_board_description_Invalid OR LEFT.action_date_Invalid <> RIGHT.action_date_Invalid OR LEFT.sanction_period_start_date_Invalid <> RIGHT.sanction_period_start_date_Invalid OR LEFT.sanction_period_end_date_Invalid <> RIGHT.sanction_period_end_date_Invalid OR LEFT.month_duration_Invalid <> RIGHT.month_duration_Invalid OR LEFT.fine_amount_Invalid <> RIGHT.fine_amount_Invalid OR LEFT.offense_code_Invalid <> RIGHT.offense_code_Invalid OR LEFT.offense_description_Invalid <> RIGHT.offense_description_Invalid OR LEFT.offense_date_Invalid <> RIGHT.offense_date_Invalid OR LEFT.clean_offense_date_Invalid <> RIGHT.clean_offense_date_Invalid OR LEFT.clean_action_date_Invalid <> RIGHT.clean_action_date_Invalid OR LEFT.clean_sanction_period_start_date_Invalid <> RIGHT.clean_sanction_period_start_date_Invalid OR LEFT.clean_sanction_period_end_date_Invalid <> RIGHT.clean_sanction_period_end_date_Invalid OR LEFT.gsa_sanction_id_Invalid <> RIGHT.gsa_sanction_id_Invalid OR LEFT.gsa_first_Invalid <> RIGHT.gsa_first_Invalid OR LEFT.gsa_middle_Invalid <> RIGHT.gsa_middle_Invalid OR LEFT.gsa_last_Invalid <> RIGHT.gsa_last_Invalid OR LEFT.gsa_suffix_Invalid <> RIGHT.gsa_suffix_Invalid OR LEFT.gsa_city_Invalid <> RIGHT.gsa_city_Invalid OR LEFT.gsa_state_Invalid <> RIGHT.gsa_state_Invalid OR LEFT.gsa_zip_Invalid <> RIGHT.gsa_zip_Invalid OR LEFT.date_Invalid <> RIGHT.date_Invalid OR LEFT.agency_Invalid <> RIGHT.agency_Invalid OR LEFT.confidence_Invalid <> RIGHT.confidence_Invalid OR LEFT.clean_gsa_first_Invalid <> RIGHT.clean_gsa_first_Invalid OR LEFT.clean_gsa_middle_Invalid <> RIGHT.clean_gsa_middle_Invalid OR LEFT.clean_gsa_last_Invalid <> RIGHT.clean_gsa_last_Invalid OR LEFT.clean_gsa_suffix_Invalid <> RIGHT.clean_gsa_suffix_Invalid OR LEFT.clean_gsa_city_Invalid <> RIGHT.clean_gsa_city_Invalid OR LEFT.clean_gsa_state_Invalid <> RIGHT.clean_gsa_state_Invalid OR LEFT.clean_gsa_zip_Invalid <> RIGHT.clean_gsa_zip_Invalid OR LEFT.clean_gsa_action_date_Invalid <> RIGHT.clean_gsa_action_date_Invalid OR LEFT.clean_gsa_date_Invalid <> RIGHT.clean_gsa_date_Invalid OR LEFT.fax_Invalid <> RIGHT.fax_Invalid OR LEFT.phone_Invalid <> RIGHT.phone_Invalid OR LEFT.certification_code_Invalid <> RIGHT.certification_code_Invalid OR LEFT.certification_description_Invalid <> RIGHT.certification_description_Invalid OR LEFT.board_code_Invalid <> RIGHT.board_code_Invalid OR LEFT.board_description_Invalid <> RIGHT.board_description_Invalid OR LEFT.expiration_year_Invalid <> RIGHT.expiration_year_Invalid OR LEFT.issue_year_Invalid <> RIGHT.issue_year_Invalid OR LEFT.renewal_year_Invalid <> RIGHT.renewal_year_Invalid OR LEFT.lifetime_flag_Invalid <> RIGHT.lifetime_flag_Invalid OR LEFT.covered_recipient_id_Invalid <> RIGHT.covered_recipient_id_Invalid OR LEFT.cov_rcp_raw_state_code_Invalid <> RIGHT.cov_rcp_raw_state_code_Invalid OR LEFT.cov_rcp_raw_full_name_Invalid <> RIGHT.cov_rcp_raw_full_name_Invalid OR LEFT.cov_rcp_raw_attribute1_Invalid <> RIGHT.cov_rcp_raw_attribute1_Invalid OR LEFT.cov_rcp_raw_attribute2_Invalid <> RIGHT.cov_rcp_raw_attribute2_Invalid OR LEFT.cov_rcp_raw_attribute3_Invalid <> RIGHT.cov_rcp_raw_attribute3_Invalid OR LEFT.cov_rcp_raw_attribute4_Invalid <> RIGHT.cov_rcp_raw_attribute4_Invalid OR LEFT.hms_scid_Invalid <> RIGHT.hms_scid_Invalid OR LEFT.school_name_Invalid <> RIGHT.school_name_Invalid OR LEFT.grad_year_Invalid <> RIGHT.grad_year_Invalid OR LEFT.lang_code_Invalid <> RIGHT.lang_code_Invalid OR LEFT.language_Invalid <> RIGHT.language_Invalid OR LEFT.specialty_description_Invalid <> RIGHT.specialty_description_Invalid OR LEFT.clean_phone_Invalid <> RIGHT.clean_phone_Invalid OR LEFT.bdid_Invalid <> RIGHT.bdid_Invalid OR LEFT.bdid_score_Invalid <> RIGHT.bdid_score_Invalid OR LEFT.did_Invalid <> RIGHT.did_Invalid OR LEFT.did_score_Invalid <> RIGHT.did_score_Invalid OR LEFT.clean_dob_Invalid <> RIGHT.clean_dob_Invalid OR LEFT.best_dob_Invalid <> RIGHT.best_dob_Invalid OR LEFT.best_ssn_Invalid <> RIGHT.best_ssn_Invalid OR LEFT.rec_deactivated_date_Invalid <> RIGHT.rec_deactivated_date_Invalid OR LEFT.superceeding_piid_Invalid <> RIGHT.superceeding_piid_Invalid OR LEFT.dotid_Invalid <> RIGHT.dotid_Invalid OR LEFT.dotscore_Invalid <> RIGHT.dotscore_Invalid OR LEFT.dotweight_Invalid <> RIGHT.dotweight_Invalid OR LEFT.empid_Invalid <> RIGHT.empid_Invalid OR LEFT.empscore_Invalid <> RIGHT.empscore_Invalid OR LEFT.empweight_Invalid <> RIGHT.empweight_Invalid OR LEFT.powid_Invalid <> RIGHT.powid_Invalid OR LEFT.powscore_Invalid <> RIGHT.powscore_Invalid OR LEFT.powweight_Invalid <> RIGHT.powweight_Invalid OR LEFT.proxid_Invalid <> RIGHT.proxid_Invalid OR LEFT.proxscore_Invalid <> RIGHT.proxscore_Invalid OR LEFT.proxweight_Invalid <> RIGHT.proxweight_Invalid OR LEFT.seleid_Invalid <> RIGHT.seleid_Invalid OR LEFT.selescore_Invalid <> RIGHT.selescore_Invalid OR LEFT.seleweight_Invalid <> RIGHT.seleweight_Invalid OR LEFT.orgid_Invalid <> RIGHT.orgid_Invalid OR LEFT.orgscore_Invalid <> RIGHT.orgscore_Invalid OR LEFT.orgweight_Invalid <> RIGHT.orgweight_Invalid OR LEFT.ultid_Invalid <> RIGHT.ultid_Invalid OR LEFT.ultscore_Invalid <> RIGHT.ultscore_Invalid OR LEFT.ultweight_Invalid <> RIGHT.ultweight_Invalid),TRANSFORM(RIGHT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    hms_piid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.hms_piid_Invalid=1);
    hms_piid_ALLOW_ErrorCount := COUNT(GROUP,h.hms_piid_Invalid=2);
    hms_piid_Total_ErrorCount := COUNT(GROUP,h.hms_piid_Invalid>0);
    first_LEFTTRIM_ErrorCount := COUNT(GROUP,h.first_Invalid=1);
    first_ALLOW_ErrorCount := COUNT(GROUP,h.first_Invalid=2);
    first_Total_ErrorCount := COUNT(GROUP,h.first_Invalid>0);
    middle_LEFTTRIM_ErrorCount := COUNT(GROUP,h.middle_Invalid=1);
    middle_ALLOW_ErrorCount := COUNT(GROUP,h.middle_Invalid=2);
    middle_Total_ErrorCount := COUNT(GROUP,h.middle_Invalid>0);
    last_LEFTTRIM_ErrorCount := COUNT(GROUP,h.last_Invalid=1);
    last_ALLOW_ErrorCount := COUNT(GROUP,h.last_Invalid=2);
    last_Total_ErrorCount := COUNT(GROUP,h.last_Invalid>0);
    suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    cred_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cred_Invalid=1);
    cred_ALLOW_ErrorCount := COUNT(GROUP,h.cred_Invalid=2);
    cred_Total_ErrorCount := COUNT(GROUP,h.cred_Invalid>0);
    practitioner_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.practitioner_type_Invalid=1);
    practitioner_type_ALLOW_ErrorCount := COUNT(GROUP,h.practitioner_type_Invalid=2);
    practitioner_type_Total_ErrorCount := COUNT(GROUP,h.practitioner_type_Invalid>0);
    active_LEFTTRIM_ErrorCount := COUNT(GROUP,h.active_Invalid=1);
    active_ALLOW_ErrorCount := COUNT(GROUP,h.active_Invalid=2);
    active_Total_ErrorCount := COUNT(GROUP,h.active_Invalid>0);
    vendible_LEFTTRIM_ErrorCount := COUNT(GROUP,h.vendible_Invalid=1);
    vendible_ALLOW_ErrorCount := COUNT(GROUP,h.vendible_Invalid=2);
    vendible_Total_ErrorCount := COUNT(GROUP,h.vendible_Invalid>0);
    npi_num_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_num_Invalid=1);
    npi_num_ALLOW_ErrorCount := COUNT(GROUP,h.npi_num_Invalid=2);
    npi_num_Total_ErrorCount := COUNT(GROUP,h.npi_num_Invalid>0);
    npi_enumeration_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_enumeration_date_Invalid=1);
    npi_enumeration_date_ALLOW_ErrorCount := COUNT(GROUP,h.npi_enumeration_date_Invalid=2);
    npi_enumeration_date_Total_ErrorCount := COUNT(GROUP,h.npi_enumeration_date_Invalid>0);
    npi_deactivation_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_deactivation_date_Invalid=1);
    npi_deactivation_date_ALLOW_ErrorCount := COUNT(GROUP,h.npi_deactivation_date_Invalid=2);
    npi_deactivation_date_Total_ErrorCount := COUNT(GROUP,h.npi_deactivation_date_Invalid>0);
    npi_reactivation_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_reactivation_date_Invalid=1);
    npi_reactivation_date_ALLOW_ErrorCount := COUNT(GROUP,h.npi_reactivation_date_Invalid=2);
    npi_reactivation_date_Total_ErrorCount := COUNT(GROUP,h.npi_reactivation_date_Invalid>0);
    npi_taxonomy_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.npi_taxonomy_code_Invalid=1);
    npi_taxonomy_code_ALLOW_ErrorCount := COUNT(GROUP,h.npi_taxonomy_code_Invalid=2);
    npi_taxonomy_code_Total_ErrorCount := COUNT(GROUP,h.npi_taxonomy_code_Invalid>0);
    upin_LEFTTRIM_ErrorCount := COUNT(GROUP,h.upin_Invalid=1);
    upin_ALLOW_ErrorCount := COUNT(GROUP,h.upin_Invalid=2);
    upin_Total_ErrorCount := COUNT(GROUP,h.upin_Invalid>0);
    medicare_participation_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.medicare_participation_flag_Invalid=1);
    medicare_participation_flag_ALLOW_ErrorCount := COUNT(GROUP,h.medicare_participation_flag_Invalid=2);
    medicare_participation_flag_Total_ErrorCount := COUNT(GROUP,h.medicare_participation_flag_Invalid>0);
    date_born_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_born_Invalid=1);
    date_born_ALLOW_ErrorCount := COUNT(GROUP,h.date_born_Invalid=2);
    date_born_Total_ErrorCount := COUNT(GROUP,h.date_born_Invalid>0);
    date_died_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_died_Invalid=1);
    date_died_ALLOW_ErrorCount := COUNT(GROUP,h.date_died_Invalid=2);
    date_died_Total_ErrorCount := COUNT(GROUP,h.date_died_Invalid>0);
    pid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.pid_Invalid=1);
    pid_ALLOW_ErrorCount := COUNT(GROUP,h.pid_Invalid=2);
    pid_Total_ErrorCount := COUNT(GROUP,h.pid_Invalid>0);
    src_LEFTTRIM_ErrorCount := COUNT(GROUP,h.src_Invalid=1);
    src_ALLOW_ErrorCount := COUNT(GROUP,h.src_Invalid=2);
    src_Total_ErrorCount := COUNT(GROUP,h.src_Invalid>0);
    date_vendor_first_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=2);
    date_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid>0);
    date_vendor_last_reported_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=2);
    date_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid>0);
    date_first_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=2);
    date_first_seen_Total_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid>0);
    date_last_seen_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=2);
    date_last_seen_Total_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid>0);
    record_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=2);
    record_type_Total_ErrorCount := COUNT(GROUP,h.record_type_Invalid>0);
    source_rid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.source_rid_Invalid=1);
    source_rid_ALLOW_ErrorCount := COUNT(GROUP,h.source_rid_Invalid=2);
    source_rid_Total_ErrorCount := COUNT(GROUP,h.source_rid_Invalid>0);
    lnpid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=1);
    lnpid_ALLOW_ErrorCount := COUNT(GROUP,h.lnpid_Invalid=2);
    lnpid_Total_ErrorCount := COUNT(GROUP,h.lnpid_Invalid>0);
    fname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    nametype_LEFTTRIM_ErrorCount := COUNT(GROUP,h.nametype_Invalid=1);
    nametype_ALLOW_ErrorCount := COUNT(GROUP,h.nametype_Invalid=2);
    nametype_Total_ErrorCount := COUNT(GROUP,h.nametype_Invalid>0);
    nid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.nid_Invalid=1);
    nid_ALLOW_ErrorCount := COUNT(GROUP,h.nid_Invalid=2);
    nid_Total_ErrorCount := COUNT(GROUP,h.nid_Invalid>0);
    clean_npi_enumeration_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_npi_enumeration_date_Invalid=1);
    clean_npi_enumeration_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_npi_enumeration_date_Invalid=2);
    clean_npi_enumeration_date_Total_ErrorCount := COUNT(GROUP,h.clean_npi_enumeration_date_Invalid>0);
    clean_npi_deactivation_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_npi_deactivation_date_Invalid=1);
    clean_npi_deactivation_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_npi_deactivation_date_Invalid=2);
    clean_npi_deactivation_date_Total_ErrorCount := COUNT(GROUP,h.clean_npi_deactivation_date_Invalid>0);
    clean_npi_reactivation_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_npi_reactivation_date_Invalid=1);
    clean_npi_reactivation_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_npi_reactivation_date_Invalid=2);
    clean_npi_reactivation_date_Total_ErrorCount := COUNT(GROUP,h.clean_npi_reactivation_date_Invalid>0);
    clean_date_born_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_date_born_Invalid=1);
    clean_date_born_ALLOW_ErrorCount := COUNT(GROUP,h.clean_date_born_Invalid=2);
    clean_date_born_Total_ErrorCount := COUNT(GROUP,h.clean_date_born_Invalid>0);
    clean_date_died_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_date_died_Invalid=1);
    clean_date_died_ALLOW_ErrorCount := COUNT(GROUP,h.clean_date_died_Invalid=2);
    clean_date_died_Total_ErrorCount := COUNT(GROUP,h.clean_date_died_Invalid>0);
    clean_company_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=1);
    clean_company_name_ALLOW_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid=2);
    clean_company_name_Total_ErrorCount := COUNT(GROUP,h.clean_company_name_Invalid>0);
    prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=2);
    addr_suffix_Total_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid>0);
    postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=2);
    cr_sort_sz_Total_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid>0);
    lot_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
    dbpc_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=2);
    dbpc_Total_ErrorCount := COUNT(GROUP,h.dbpc_Invalid>0);
    chk_digit_LEFTTRIM_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=2);
    chk_digit_Total_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid>0);
    rec_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
    fips_st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fips_st_Invalid=1);
    fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.fips_st_Invalid=2);
    fips_st_Total_ErrorCount := COUNT(GROUP,h.fips_st_Invalid>0);
    fips_county_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=2);
    fips_county_Total_ErrorCount := COUNT(GROUP,h.fips_county_Invalid>0);
    geo_lat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=2);
    geo_lat_Total_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid>0);
    geo_long_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=2);
    geo_long_Total_ErrorCount := COUNT(GROUP,h.geo_long_Invalid>0);
    msa_LEFTTRIM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=2);
    msa_Total_ErrorCount := COUNT(GROUP,h.msa_Invalid>0);
    geo_blk_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    geo_match_LEFTTRIM_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=2);
    geo_match_Total_ErrorCount := COUNT(GROUP,h.geo_match_Invalid>0);
    err_stat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
    rawaid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    aceaid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=1);
    aceaid_ALLOW_ErrorCount := COUNT(GROUP,h.aceaid_Invalid=2);
    aceaid_Total_ErrorCount := COUNT(GROUP,h.aceaid_Invalid>0);
    firm_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.firm_name_Invalid=1);
    firm_name_ALLOW_ErrorCount := COUNT(GROUP,h.firm_name_Invalid=2);
    firm_name_Total_ErrorCount := COUNT(GROUP,h.firm_name_Invalid>0);
    lid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lid_Invalid=1);
    lid_ALLOW_ErrorCount := COUNT(GROUP,h.lid_Invalid=2);
    lid_Total_ErrorCount := COUNT(GROUP,h.lid_Invalid>0);
    agid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.agid_Invalid=1);
    agid_ALLOW_ErrorCount := COUNT(GROUP,h.agid_Invalid=2);
    agid_Total_ErrorCount := COUNT(GROUP,h.agid_Invalid>0);
    address_std_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address_std_code_Invalid=1);
    address_std_code_ALLOW_ErrorCount := COUNT(GROUP,h.address_std_code_Invalid=2);
    address_std_code_Total_ErrorCount := COUNT(GROUP,h.address_std_code_Invalid>0);
    latitude_LEFTTRIM_ErrorCount := COUNT(GROUP,h.latitude_Invalid=1);
    latitude_ALLOW_ErrorCount := COUNT(GROUP,h.latitude_Invalid=2);
    latitude_Total_ErrorCount := COUNT(GROUP,h.latitude_Invalid>0);
    longitude_LEFTTRIM_ErrorCount := COUNT(GROUP,h.longitude_Invalid=1);
    longitude_ALLOW_ErrorCount := COUNT(GROUP,h.longitude_Invalid=2);
    longitude_Total_ErrorCount := COUNT(GROUP,h.longitude_Invalid>0);
    prepped_addr1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=1);
    prepped_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=2);
    prepped_addr1_Total_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid>0);
    prepped_addr2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=1);
    prepped_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=2);
    prepped_addr2_Total_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid>0);
    addr_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.addr_type_Invalid=1);
    addr_type_ALLOW_ErrorCount := COUNT(GROUP,h.addr_type_Invalid=2);
    addr_type_Total_ErrorCount := COUNT(GROUP,h.addr_type_Invalid>0);
    state_license_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_license_state_Invalid=1);
    state_license_state_ALLOW_ErrorCount := COUNT(GROUP,h.state_license_state_Invalid=2);
    state_license_state_Total_ErrorCount := COUNT(GROUP,h.state_license_state_Invalid>0);
    state_license_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_license_number_Invalid=1);
    state_license_number_ALLOW_ErrorCount := COUNT(GROUP,h.state_license_number_Invalid=2);
    state_license_number_Total_ErrorCount := COUNT(GROUP,h.state_license_number_Invalid>0);
    state_license_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_license_type_Invalid=1);
    state_license_type_ALLOW_ErrorCount := COUNT(GROUP,h.state_license_type_Invalid=2);
    state_license_type_Total_ErrorCount := COUNT(GROUP,h.state_license_type_Invalid>0);
    state_license_active_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_license_active_Invalid=1);
    state_license_active_ALLOW_ErrorCount := COUNT(GROUP,h.state_license_active_Invalid=2);
    state_license_active_Total_ErrorCount := COUNT(GROUP,h.state_license_active_Invalid>0);
    state_license_expire_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_license_expire_Invalid=1);
    state_license_expire_ALLOW_ErrorCount := COUNT(GROUP,h.state_license_expire_Invalid=2);
    state_license_expire_Total_ErrorCount := COUNT(GROUP,h.state_license_expire_Invalid>0);
    state_license_qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_license_qualifier_Invalid=1);
    state_license_qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.state_license_qualifier_Invalid=2);
    state_license_qualifier_Total_ErrorCount := COUNT(GROUP,h.state_license_qualifier_Invalid>0);
    state_license_sub_qualifier_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_license_sub_qualifier_Invalid=1);
    state_license_sub_qualifier_ALLOW_ErrorCount := COUNT(GROUP,h.state_license_sub_qualifier_Invalid=2);
    state_license_sub_qualifier_Total_ErrorCount := COUNT(GROUP,h.state_license_sub_qualifier_Invalid>0);
    state_license_issued_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_license_issued_Invalid=1);
    state_license_issued_ALLOW_ErrorCount := COUNT(GROUP,h.state_license_issued_Invalid=2);
    state_license_issued_Total_ErrorCount := COUNT(GROUP,h.state_license_issued_Invalid>0);
    clean_state_license_expire_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_state_license_expire_Invalid=1);
    clean_state_license_expire_ALLOW_ErrorCount := COUNT(GROUP,h.clean_state_license_expire_Invalid=2);
    clean_state_license_expire_Total_ErrorCount := COUNT(GROUP,h.clean_state_license_expire_Invalid>0);
    clean_state_license_issued_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_state_license_issued_Invalid=1);
    clean_state_license_issued_ALLOW_ErrorCount := COUNT(GROUP,h.clean_state_license_issued_Invalid=2);
    clean_state_license_issued_Total_ErrorCount := COUNT(GROUP,h.clean_state_license_issued_Invalid>0);
    dea_num_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_num_Invalid=1);
    dea_num_ALLOW_ErrorCount := COUNT(GROUP,h.dea_num_Invalid=2);
    dea_num_Total_ErrorCount := COUNT(GROUP,h.dea_num_Invalid>0);
    dea_bac_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_bac_Invalid=1);
    dea_bac_ALLOW_ErrorCount := COUNT(GROUP,h.dea_bac_Invalid=2);
    dea_bac_Total_ErrorCount := COUNT(GROUP,h.dea_bac_Invalid>0);
    dea_sub_bac_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_sub_bac_Invalid=1);
    dea_sub_bac_ALLOW_ErrorCount := COUNT(GROUP,h.dea_sub_bac_Invalid=2);
    dea_sub_bac_Total_ErrorCount := COUNT(GROUP,h.dea_sub_bac_Invalid>0);
    dea_schedule_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_schedule_Invalid=1);
    dea_schedule_ALLOW_ErrorCount := COUNT(GROUP,h.dea_schedule_Invalid=2);
    dea_schedule_Total_ErrorCount := COUNT(GROUP,h.dea_schedule_Invalid>0);
    dea_expire_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_expire_Invalid=1);
    dea_expire_ALLOW_ErrorCount := COUNT(GROUP,h.dea_expire_Invalid=2);
    dea_expire_Total_ErrorCount := COUNT(GROUP,h.dea_expire_Invalid>0);
    dea_active_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dea_active_Invalid=1);
    dea_active_ALLOW_ErrorCount := COUNT(GROUP,h.dea_active_Invalid=2);
    dea_active_Total_ErrorCount := COUNT(GROUP,h.dea_active_Invalid>0);
    clean_dea_expire_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_dea_expire_Invalid=1);
    clean_dea_expire_ALLOW_ErrorCount := COUNT(GROUP,h.clean_dea_expire_Invalid=2);
    clean_dea_expire_Total_ErrorCount := COUNT(GROUP,h.clean_dea_expire_Invalid>0);
    csr_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=1);
    csr_number_ALLOW_ErrorCount := COUNT(GROUP,h.csr_number_Invalid=2);
    csr_number_Total_ErrorCount := COUNT(GROUP,h.csr_number_Invalid>0);
    csr_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_state_Invalid=1);
    csr_state_ALLOW_ErrorCount := COUNT(GROUP,h.csr_state_Invalid=2);
    csr_state_Total_ErrorCount := COUNT(GROUP,h.csr_state_Invalid>0);
    csr_expire_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_expire_date_Invalid=1);
    csr_expire_date_ALLOW_ErrorCount := COUNT(GROUP,h.csr_expire_date_Invalid=2);
    csr_expire_date_Total_ErrorCount := COUNT(GROUP,h.csr_expire_date_Invalid>0);
    csr_issue_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_issue_date_Invalid=1);
    csr_issue_date_ALLOW_ErrorCount := COUNT(GROUP,h.csr_issue_date_Invalid=2);
    csr_issue_date_Total_ErrorCount := COUNT(GROUP,h.csr_issue_date_Invalid>0);
    dsa_lvl_2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dsa_lvl_2_Invalid=1);
    dsa_lvl_2_ALLOW_ErrorCount := COUNT(GROUP,h.dsa_lvl_2_Invalid=2);
    dsa_lvl_2_Total_ErrorCount := COUNT(GROUP,h.dsa_lvl_2_Invalid>0);
    dsa_lvl_2n_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dsa_lvl_2n_Invalid=1);
    dsa_lvl_2n_ALLOW_ErrorCount := COUNT(GROUP,h.dsa_lvl_2n_Invalid=2);
    dsa_lvl_2n_Total_ErrorCount := COUNT(GROUP,h.dsa_lvl_2n_Invalid>0);
    dsa_lvl_3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dsa_lvl_3_Invalid=1);
    dsa_lvl_3_ALLOW_ErrorCount := COUNT(GROUP,h.dsa_lvl_3_Invalid=2);
    dsa_lvl_3_Total_ErrorCount := COUNT(GROUP,h.dsa_lvl_3_Invalid>0);
    dsa_lvl_3n_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dsa_lvl_3n_Invalid=1);
    dsa_lvl_3n_ALLOW_ErrorCount := COUNT(GROUP,h.dsa_lvl_3n_Invalid=2);
    dsa_lvl_3n_Total_ErrorCount := COUNT(GROUP,h.dsa_lvl_3n_Invalid>0);
    dsa_lvl_4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dsa_lvl_4_Invalid=1);
    dsa_lvl_4_ALLOW_ErrorCount := COUNT(GROUP,h.dsa_lvl_4_Invalid=2);
    dsa_lvl_4_Total_ErrorCount := COUNT(GROUP,h.dsa_lvl_4_Invalid>0);
    dsa_lvl_5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dsa_lvl_5_Invalid=1);
    dsa_lvl_5_ALLOW_ErrorCount := COUNT(GROUP,h.dsa_lvl_5_Invalid=2);
    dsa_lvl_5_Total_ErrorCount := COUNT(GROUP,h.dsa_lvl_5_Invalid>0);
    csr_raw1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_raw1_Invalid=1);
    csr_raw1_ALLOW_ErrorCount := COUNT(GROUP,h.csr_raw1_Invalid=2);
    csr_raw1_Total_ErrorCount := COUNT(GROUP,h.csr_raw1_Invalid>0);
    csr_raw2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_raw2_Invalid=1);
    csr_raw2_ALLOW_ErrorCount := COUNT(GROUP,h.csr_raw2_Invalid=2);
    csr_raw2_Total_ErrorCount := COUNT(GROUP,h.csr_raw2_Invalid>0);
    csr_raw3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_raw3_Invalid=1);
    csr_raw3_ALLOW_ErrorCount := COUNT(GROUP,h.csr_raw3_Invalid=2);
    csr_raw3_Total_ErrorCount := COUNT(GROUP,h.csr_raw3_Invalid>0);
    csr_raw4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.csr_raw4_Invalid=1);
    csr_raw4_ALLOW_ErrorCount := COUNT(GROUP,h.csr_raw4_Invalid=2);
    csr_raw4_Total_ErrorCount := COUNT(GROUP,h.csr_raw4_Invalid>0);
    clean_csr_expire_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_csr_expire_date_Invalid=1);
    clean_csr_expire_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_csr_expire_date_Invalid=2);
    clean_csr_expire_date_Total_ErrorCount := COUNT(GROUP,h.clean_csr_expire_date_Invalid>0);
    clean_csr_issue_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_csr_issue_date_Invalid=1);
    clean_csr_issue_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_csr_issue_date_Invalid=2);
    clean_csr_issue_date_Total_ErrorCount := COUNT(GROUP,h.clean_csr_issue_date_Invalid>0);
    sanction_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sanction_id_Invalid=1);
    sanction_id_ALLOW_ErrorCount := COUNT(GROUP,h.sanction_id_Invalid=2);
    sanction_id_Total_ErrorCount := COUNT(GROUP,h.sanction_id_Invalid>0);
    sanction_action_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sanction_action_code_Invalid=1);
    sanction_action_code_ALLOW_ErrorCount := COUNT(GROUP,h.sanction_action_code_Invalid=2);
    sanction_action_code_Total_ErrorCount := COUNT(GROUP,h.sanction_action_code_Invalid>0);
    sanction_action_description_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sanction_action_description_Invalid=1);
    sanction_action_description_ALLOW_ErrorCount := COUNT(GROUP,h.sanction_action_description_Invalid=2);
    sanction_action_description_Total_ErrorCount := COUNT(GROUP,h.sanction_action_description_Invalid>0);
    sanction_board_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sanction_board_code_Invalid=1);
    sanction_board_code_ALLOW_ErrorCount := COUNT(GROUP,h.sanction_board_code_Invalid=2);
    sanction_board_code_Total_ErrorCount := COUNT(GROUP,h.sanction_board_code_Invalid>0);
    sanction_board_description_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sanction_board_description_Invalid=1);
    sanction_board_description_ALLOW_ErrorCount := COUNT(GROUP,h.sanction_board_description_Invalid=2);
    sanction_board_description_Total_ErrorCount := COUNT(GROUP,h.sanction_board_description_Invalid>0);
    action_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.action_date_Invalid=1);
    action_date_ALLOW_ErrorCount := COUNT(GROUP,h.action_date_Invalid=2);
    action_date_Total_ErrorCount := COUNT(GROUP,h.action_date_Invalid>0);
    sanction_period_start_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sanction_period_start_date_Invalid=1);
    sanction_period_start_date_ALLOW_ErrorCount := COUNT(GROUP,h.sanction_period_start_date_Invalid=2);
    sanction_period_start_date_Total_ErrorCount := COUNT(GROUP,h.sanction_period_start_date_Invalid>0);
    sanction_period_end_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.sanction_period_end_date_Invalid=1);
    sanction_period_end_date_ALLOW_ErrorCount := COUNT(GROUP,h.sanction_period_end_date_Invalid=2);
    sanction_period_end_date_Total_ErrorCount := COUNT(GROUP,h.sanction_period_end_date_Invalid>0);
    month_duration_LEFTTRIM_ErrorCount := COUNT(GROUP,h.month_duration_Invalid=1);
    month_duration_ALLOW_ErrorCount := COUNT(GROUP,h.month_duration_Invalid=2);
    month_duration_Total_ErrorCount := COUNT(GROUP,h.month_duration_Invalid>0);
    fine_amount_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fine_amount_Invalid=1);
    fine_amount_ALLOW_ErrorCount := COUNT(GROUP,h.fine_amount_Invalid=2);
    fine_amount_Total_ErrorCount := COUNT(GROUP,h.fine_amount_Invalid>0);
    offense_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.offense_code_Invalid=1);
    offense_code_ALLOW_ErrorCount := COUNT(GROUP,h.offense_code_Invalid=2);
    offense_code_Total_ErrorCount := COUNT(GROUP,h.offense_code_Invalid>0);
    offense_description_LEFTTRIM_ErrorCount := COUNT(GROUP,h.offense_description_Invalid=1);
    offense_description_ALLOW_ErrorCount := COUNT(GROUP,h.offense_description_Invalid=2);
    offense_description_Total_ErrorCount := COUNT(GROUP,h.offense_description_Invalid>0);
    offense_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.offense_date_Invalid=1);
    offense_date_ALLOW_ErrorCount := COUNT(GROUP,h.offense_date_Invalid=2);
    offense_date_Total_ErrorCount := COUNT(GROUP,h.offense_date_Invalid>0);
    clean_offense_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_offense_date_Invalid=1);
    clean_offense_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_offense_date_Invalid=2);
    clean_offense_date_Total_ErrorCount := COUNT(GROUP,h.clean_offense_date_Invalid>0);
    clean_action_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_action_date_Invalid=1);
    clean_action_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_action_date_Invalid=2);
    clean_action_date_Total_ErrorCount := COUNT(GROUP,h.clean_action_date_Invalid>0);
    clean_sanction_period_start_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_sanction_period_start_date_Invalid=1);
    clean_sanction_period_start_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_sanction_period_start_date_Invalid=2);
    clean_sanction_period_start_date_Total_ErrorCount := COUNT(GROUP,h.clean_sanction_period_start_date_Invalid>0);
    clean_sanction_period_end_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_sanction_period_end_date_Invalid=1);
    clean_sanction_period_end_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_sanction_period_end_date_Invalid=2);
    clean_sanction_period_end_date_Total_ErrorCount := COUNT(GROUP,h.clean_sanction_period_end_date_Invalid>0);
    gsa_sanction_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gsa_sanction_id_Invalid=1);
    gsa_sanction_id_ALLOW_ErrorCount := COUNT(GROUP,h.gsa_sanction_id_Invalid=2);
    gsa_sanction_id_Total_ErrorCount := COUNT(GROUP,h.gsa_sanction_id_Invalid>0);
    gsa_first_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gsa_first_Invalid=1);
    gsa_first_ALLOW_ErrorCount := COUNT(GROUP,h.gsa_first_Invalid=2);
    gsa_first_Total_ErrorCount := COUNT(GROUP,h.gsa_first_Invalid>0);
    gsa_middle_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gsa_middle_Invalid=1);
    gsa_middle_ALLOW_ErrorCount := COUNT(GROUP,h.gsa_middle_Invalid=2);
    gsa_middle_Total_ErrorCount := COUNT(GROUP,h.gsa_middle_Invalid>0);
    gsa_last_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gsa_last_Invalid=1);
    gsa_last_ALLOW_ErrorCount := COUNT(GROUP,h.gsa_last_Invalid=2);
    gsa_last_Total_ErrorCount := COUNT(GROUP,h.gsa_last_Invalid>0);
    gsa_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gsa_suffix_Invalid=1);
    gsa_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.gsa_suffix_Invalid=2);
    gsa_suffix_Total_ErrorCount := COUNT(GROUP,h.gsa_suffix_Invalid>0);
    gsa_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gsa_city_Invalid=1);
    gsa_city_ALLOW_ErrorCount := COUNT(GROUP,h.gsa_city_Invalid=2);
    gsa_city_Total_ErrorCount := COUNT(GROUP,h.gsa_city_Invalid>0);
    gsa_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gsa_state_Invalid=1);
    gsa_state_ALLOW_ErrorCount := COUNT(GROUP,h.gsa_state_Invalid=2);
    gsa_state_Total_ErrorCount := COUNT(GROUP,h.gsa_state_Invalid>0);
    gsa_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.gsa_zip_Invalid=1);
    gsa_zip_ALLOW_ErrorCount := COUNT(GROUP,h.gsa_zip_Invalid=2);
    gsa_zip_Total_ErrorCount := COUNT(GROUP,h.gsa_zip_Invalid>0);
    date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.date_Invalid=1);
    date_ALLOW_ErrorCount := COUNT(GROUP,h.date_Invalid=2);
    date_Total_ErrorCount := COUNT(GROUP,h.date_Invalid>0);
    agency_LEFTTRIM_ErrorCount := COUNT(GROUP,h.agency_Invalid=1);
    agency_ALLOW_ErrorCount := COUNT(GROUP,h.agency_Invalid=2);
    agency_Total_ErrorCount := COUNT(GROUP,h.agency_Invalid>0);
    confidence_LEFTTRIM_ErrorCount := COUNT(GROUP,h.confidence_Invalid=1);
    confidence_ALLOW_ErrorCount := COUNT(GROUP,h.confidence_Invalid=2);
    confidence_Total_ErrorCount := COUNT(GROUP,h.confidence_Invalid>0);
    clean_gsa_first_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_first_Invalid=1);
    clean_gsa_first_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_first_Invalid=2);
    clean_gsa_first_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_first_Invalid>0);
    clean_gsa_middle_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_middle_Invalid=1);
    clean_gsa_middle_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_middle_Invalid=2);
    clean_gsa_middle_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_middle_Invalid>0);
    clean_gsa_last_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_last_Invalid=1);
    clean_gsa_last_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_last_Invalid=2);
    clean_gsa_last_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_last_Invalid>0);
    clean_gsa_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_suffix_Invalid=1);
    clean_gsa_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_suffix_Invalid=2);
    clean_gsa_suffix_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_suffix_Invalid>0);
    clean_gsa_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_city_Invalid=1);
    clean_gsa_city_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_city_Invalid=2);
    clean_gsa_city_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_city_Invalid>0);
    clean_gsa_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_state_Invalid=1);
    clean_gsa_state_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_state_Invalid=2);
    clean_gsa_state_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_state_Invalid>0);
    clean_gsa_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_zip_Invalid=1);
    clean_gsa_zip_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_zip_Invalid=2);
    clean_gsa_zip_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_zip_Invalid>0);
    clean_gsa_action_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_action_date_Invalid=1);
    clean_gsa_action_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_action_date_Invalid=2);
    clean_gsa_action_date_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_action_date_Invalid>0);
    clean_gsa_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_gsa_date_Invalid=1);
    clean_gsa_date_ALLOW_ErrorCount := COUNT(GROUP,h.clean_gsa_date_Invalid=2);
    clean_gsa_date_Total_ErrorCount := COUNT(GROUP,h.clean_gsa_date_Invalid>0);
    fax_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fax_Invalid=1);
    fax_ALLOW_ErrorCount := COUNT(GROUP,h.fax_Invalid=2);
    fax_Total_ErrorCount := COUNT(GROUP,h.fax_Invalid>0);
    phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    certification_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.certification_code_Invalid=1);
    certification_code_ALLOW_ErrorCount := COUNT(GROUP,h.certification_code_Invalid=2);
    certification_code_Total_ErrorCount := COUNT(GROUP,h.certification_code_Invalid>0);
    certification_description_LEFTTRIM_ErrorCount := COUNT(GROUP,h.certification_description_Invalid=1);
    certification_description_ALLOW_ErrorCount := COUNT(GROUP,h.certification_description_Invalid=2);
    certification_description_Total_ErrorCount := COUNT(GROUP,h.certification_description_Invalid>0);
    board_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.board_code_Invalid=1);
    board_code_ALLOW_ErrorCount := COUNT(GROUP,h.board_code_Invalid=2);
    board_code_Total_ErrorCount := COUNT(GROUP,h.board_code_Invalid>0);
    board_description_LEFTTRIM_ErrorCount := COUNT(GROUP,h.board_description_Invalid=1);
    board_description_ALLOW_ErrorCount := COUNT(GROUP,h.board_description_Invalid=2);
    board_description_Total_ErrorCount := COUNT(GROUP,h.board_description_Invalid>0);
    expiration_year_LEFTTRIM_ErrorCount := COUNT(GROUP,h.expiration_year_Invalid=1);
    expiration_year_ALLOW_ErrorCount := COUNT(GROUP,h.expiration_year_Invalid=2);
    expiration_year_Total_ErrorCount := COUNT(GROUP,h.expiration_year_Invalid>0);
    issue_year_LEFTTRIM_ErrorCount := COUNT(GROUP,h.issue_year_Invalid=1);
    issue_year_ALLOW_ErrorCount := COUNT(GROUP,h.issue_year_Invalid=2);
    issue_year_Total_ErrorCount := COUNT(GROUP,h.issue_year_Invalid>0);
    renewal_year_LEFTTRIM_ErrorCount := COUNT(GROUP,h.renewal_year_Invalid=1);
    renewal_year_ALLOW_ErrorCount := COUNT(GROUP,h.renewal_year_Invalid=2);
    renewal_year_Total_ErrorCount := COUNT(GROUP,h.renewal_year_Invalid>0);
    lifetime_flag_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lifetime_flag_Invalid=1);
    lifetime_flag_ALLOW_ErrorCount := COUNT(GROUP,h.lifetime_flag_Invalid=2);
    lifetime_flag_Total_ErrorCount := COUNT(GROUP,h.lifetime_flag_Invalid>0);
    covered_recipient_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.covered_recipient_id_Invalid=1);
    covered_recipient_id_ALLOW_ErrorCount := COUNT(GROUP,h.covered_recipient_id_Invalid=2);
    covered_recipient_id_Total_ErrorCount := COUNT(GROUP,h.covered_recipient_id_Invalid>0);
    cov_rcp_raw_state_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_state_code_Invalid=1);
    cov_rcp_raw_state_code_ALLOW_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_state_code_Invalid=2);
    cov_rcp_raw_state_code_Total_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_state_code_Invalid>0);
    cov_rcp_raw_full_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_full_name_Invalid=1);
    cov_rcp_raw_full_name_ALLOW_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_full_name_Invalid=2);
    cov_rcp_raw_full_name_Total_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_full_name_Invalid>0);
    cov_rcp_raw_attribute1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute1_Invalid=1);
    cov_rcp_raw_attribute1_ALLOW_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute1_Invalid=2);
    cov_rcp_raw_attribute1_Total_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute1_Invalid>0);
    cov_rcp_raw_attribute2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute2_Invalid=1);
    cov_rcp_raw_attribute2_ALLOW_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute2_Invalid=2);
    cov_rcp_raw_attribute2_Total_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute2_Invalid>0);
    cov_rcp_raw_attribute3_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute3_Invalid=1);
    cov_rcp_raw_attribute3_ALLOW_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute3_Invalid=2);
    cov_rcp_raw_attribute3_Total_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute3_Invalid>0);
    cov_rcp_raw_attribute4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute4_Invalid=1);
    cov_rcp_raw_attribute4_ALLOW_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute4_Invalid=2);
    cov_rcp_raw_attribute4_Total_ErrorCount := COUNT(GROUP,h.cov_rcp_raw_attribute4_Invalid>0);
    hms_scid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.hms_scid_Invalid=1);
    hms_scid_ALLOW_ErrorCount := COUNT(GROUP,h.hms_scid_Invalid=2);
    hms_scid_Total_ErrorCount := COUNT(GROUP,h.hms_scid_Invalid>0);
    school_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.school_name_Invalid=1);
    school_name_ALLOW_ErrorCount := COUNT(GROUP,h.school_name_Invalid=2);
    school_name_Total_ErrorCount := COUNT(GROUP,h.school_name_Invalid>0);
    grad_year_LEFTTRIM_ErrorCount := COUNT(GROUP,h.grad_year_Invalid=1);
    grad_year_ALLOW_ErrorCount := COUNT(GROUP,h.grad_year_Invalid=2);
    grad_year_Total_ErrorCount := COUNT(GROUP,h.grad_year_Invalid>0);
    lang_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lang_code_Invalid=1);
    lang_code_ALLOW_ErrorCount := COUNT(GROUP,h.lang_code_Invalid=2);
    lang_code_Total_ErrorCount := COUNT(GROUP,h.lang_code_Invalid>0);
    language_LEFTTRIM_ErrorCount := COUNT(GROUP,h.language_Invalid=1);
    language_ALLOW_ErrorCount := COUNT(GROUP,h.language_Invalid=2);
    language_Total_ErrorCount := COUNT(GROUP,h.language_Invalid>0);
    specialty_description_LEFTTRIM_ErrorCount := COUNT(GROUP,h.specialty_description_Invalid=1);
    specialty_description_ALLOW_ErrorCount := COUNT(GROUP,h.specialty_description_Invalid=2);
    specialty_description_Total_ErrorCount := COUNT(GROUP,h.specialty_description_Invalid>0);
    clean_phone_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_phone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=2);
    clean_phone_Total_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid>0);
    bdid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=2);
    bdid_Total_ErrorCount := COUNT(GROUP,h.bdid_Invalid>0);
    bdid_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=1);
    bdid_score_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid=2);
    bdid_score_Total_ErrorCount := COUNT(GROUP,h.bdid_score_Invalid>0);
    did_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    did_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=2);
    did_score_Total_ErrorCount := COUNT(GROUP,h.did_score_Invalid>0);
    clean_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid=1);
    clean_dob_ALLOW_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid=2);
    clean_dob_Total_ErrorCount := COUNT(GROUP,h.clean_dob_Invalid>0);
    best_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=1);
    best_dob_ALLOW_ErrorCount := COUNT(GROUP,h.best_dob_Invalid=2);
    best_dob_Total_ErrorCount := COUNT(GROUP,h.best_dob_Invalid>0);
    best_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=2);
    best_ssn_Total_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid>0);
    rec_deactivated_date_LEFTTRIM_ErrorCount := COUNT(GROUP,h.rec_deactivated_date_Invalid=1);
    rec_deactivated_date_ALLOW_ErrorCount := COUNT(GROUP,h.rec_deactivated_date_Invalid=2);
    rec_deactivated_date_Total_ErrorCount := COUNT(GROUP,h.rec_deactivated_date_Invalid>0);
    superceeding_piid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.superceeding_piid_Invalid=1);
    superceeding_piid_ALLOW_ErrorCount := COUNT(GROUP,h.superceeding_piid_Invalid=2);
    superceeding_piid_Total_ErrorCount := COUNT(GROUP,h.superceeding_piid_Invalid>0);
    dotid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dotid_Invalid=1);
    dotid_ALLOW_ErrorCount := COUNT(GROUP,h.dotid_Invalid=2);
    dotid_Total_ErrorCount := COUNT(GROUP,h.dotid_Invalid>0);
    dotscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=1);
    dotscore_ALLOW_ErrorCount := COUNT(GROUP,h.dotscore_Invalid=2);
    dotscore_Total_ErrorCount := COUNT(GROUP,h.dotscore_Invalid>0);
    dotweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=1);
    dotweight_ALLOW_ErrorCount := COUNT(GROUP,h.dotweight_Invalid=2);
    dotweight_Total_ErrorCount := COUNT(GROUP,h.dotweight_Invalid>0);
    empid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.empid_Invalid=1);
    empid_ALLOW_ErrorCount := COUNT(GROUP,h.empid_Invalid=2);
    empid_Total_ErrorCount := COUNT(GROUP,h.empid_Invalid>0);
    empscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.empscore_Invalid=1);
    empscore_ALLOW_ErrorCount := COUNT(GROUP,h.empscore_Invalid=2);
    empscore_Total_ErrorCount := COUNT(GROUP,h.empscore_Invalid>0);
    empweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.empweight_Invalid=1);
    empweight_ALLOW_ErrorCount := COUNT(GROUP,h.empweight_Invalid=2);
    empweight_Total_ErrorCount := COUNT(GROUP,h.empweight_Invalid>0);
    powid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    powid_ALLOW_ErrorCount := COUNT(GROUP,h.powid_Invalid=2);
    powid_Total_ErrorCount := COUNT(GROUP,h.powid_Invalid>0);
    powscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.powscore_Invalid=1);
    powscore_ALLOW_ErrorCount := COUNT(GROUP,h.powscore_Invalid=2);
    powscore_Total_ErrorCount := COUNT(GROUP,h.powscore_Invalid>0);
    powweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.powweight_Invalid=1);
    powweight_ALLOW_ErrorCount := COUNT(GROUP,h.powweight_Invalid=2);
    powweight_Total_ErrorCount := COUNT(GROUP,h.powweight_Invalid>0);
    proxid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    proxid_ALLOW_ErrorCount := COUNT(GROUP,h.proxid_Invalid=2);
    proxid_Total_ErrorCount := COUNT(GROUP,h.proxid_Invalid>0);
    proxscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=1);
    proxscore_ALLOW_ErrorCount := COUNT(GROUP,h.proxscore_Invalid=2);
    proxscore_Total_ErrorCount := COUNT(GROUP,h.proxscore_Invalid>0);
    proxweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=1);
    proxweight_ALLOW_ErrorCount := COUNT(GROUP,h.proxweight_Invalid=2);
    proxweight_Total_ErrorCount := COUNT(GROUP,h.proxweight_Invalid>0);
    seleid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    seleid_ALLOW_ErrorCount := COUNT(GROUP,h.seleid_Invalid=2);
    seleid_Total_ErrorCount := COUNT(GROUP,h.seleid_Invalid>0);
    selescore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.selescore_Invalid=1);
    selescore_ALLOW_ErrorCount := COUNT(GROUP,h.selescore_Invalid=2);
    selescore_Total_ErrorCount := COUNT(GROUP,h.selescore_Invalid>0);
    seleweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=1);
    seleweight_ALLOW_ErrorCount := COUNT(GROUP,h.seleweight_Invalid=2);
    seleweight_Total_ErrorCount := COUNT(GROUP,h.seleweight_Invalid>0);
    orgid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    orgid_ALLOW_ErrorCount := COUNT(GROUP,h.orgid_Invalid=2);
    orgid_Total_ErrorCount := COUNT(GROUP,h.orgid_Invalid>0);
    orgscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=1);
    orgscore_ALLOW_ErrorCount := COUNT(GROUP,h.orgscore_Invalid=2);
    orgscore_Total_ErrorCount := COUNT(GROUP,h.orgscore_Invalid>0);
    orgweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=1);
    orgweight_ALLOW_ErrorCount := COUNT(GROUP,h.orgweight_Invalid=2);
    orgweight_Total_ErrorCount := COUNT(GROUP,h.orgweight_Invalid>0);
    ultid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    ultid_ALLOW_ErrorCount := COUNT(GROUP,h.ultid_Invalid=2);
    ultid_Total_ErrorCount := COUNT(GROUP,h.ultid_Invalid>0);
    ultscore_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=1);
    ultscore_ALLOW_ErrorCount := COUNT(GROUP,h.ultscore_Invalid=2);
    ultscore_Total_ErrorCount := COUNT(GROUP,h.ultscore_Invalid>0);
    ultweight_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=1);
    ultweight_ALLOW_ErrorCount := COUNT(GROUP,h.ultweight_Invalid=2);
    ultweight_Total_ErrorCount := COUNT(GROUP,h.ultweight_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT31.StrType ErrorMessage;
    SALT31.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.hms_piid_Invalid,le.first_Invalid,le.middle_Invalid,le.last_Invalid,le.suffix_Invalid,le.cred_Invalid,le.practitioner_type_Invalid,le.active_Invalid,le.vendible_Invalid,le.npi_num_Invalid,le.npi_enumeration_date_Invalid,le.npi_deactivation_date_Invalid,le.npi_reactivation_date_Invalid,le.npi_taxonomy_code_Invalid,le.upin_Invalid,le.medicare_participation_flag_Invalid,le.date_born_Invalid,le.date_died_Invalid,le.pid_Invalid,le.src_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.record_type_Invalid,le.source_rid_Invalid,le.lnpid_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.nametype_Invalid,le.nid_Invalid,le.clean_npi_enumeration_date_Invalid,le.clean_npi_deactivation_date_Invalid,le.clean_npi_reactivation_date_Invalid,le.clean_date_born_Invalid,le.clean_date_died_Invalid,le.clean_company_name_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.fips_st_Invalid,le.fips_county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.rawaid_Invalid,le.aceaid_Invalid,le.firm_name_Invalid,le.lid_Invalid,le.agid_Invalid,le.address_std_code_Invalid,le.latitude_Invalid,le.longitude_Invalid,le.prepped_addr1_Invalid,le.prepped_addr2_Invalid,le.addr_type_Invalid,le.state_license_state_Invalid,le.state_license_number_Invalid,le.state_license_type_Invalid,le.state_license_active_Invalid,le.state_license_expire_Invalid,le.state_license_qualifier_Invalid,le.state_license_sub_qualifier_Invalid,le.state_license_issued_Invalid,le.clean_state_license_expire_Invalid,le.clean_state_license_issued_Invalid,le.dea_num_Invalid,le.dea_bac_Invalid,le.dea_sub_bac_Invalid,le.dea_schedule_Invalid,le.dea_expire_Invalid,le.dea_active_Invalid,le.clean_dea_expire_Invalid,le.csr_number_Invalid,le.csr_state_Invalid,le.csr_expire_date_Invalid,le.csr_issue_date_Invalid,le.dsa_lvl_2_Invalid,le.dsa_lvl_2n_Invalid,le.dsa_lvl_3_Invalid,le.dsa_lvl_3n_Invalid,le.dsa_lvl_4_Invalid,le.dsa_lvl_5_Invalid,le.csr_raw1_Invalid,le.csr_raw2_Invalid,le.csr_raw3_Invalid,le.csr_raw4_Invalid,le.clean_csr_expire_date_Invalid,le.clean_csr_issue_date_Invalid,le.sanction_id_Invalid,le.sanction_action_code_Invalid,le.sanction_action_description_Invalid,le.sanction_board_code_Invalid,le.sanction_board_description_Invalid,le.action_date_Invalid,le.sanction_period_start_date_Invalid,le.sanction_period_end_date_Invalid,le.month_duration_Invalid,le.fine_amount_Invalid,le.offense_code_Invalid,le.offense_description_Invalid,le.offense_date_Invalid,le.clean_offense_date_Invalid,le.clean_action_date_Invalid,le.clean_sanction_period_start_date_Invalid,le.clean_sanction_period_end_date_Invalid,le.gsa_sanction_id_Invalid,le.gsa_first_Invalid,le.gsa_middle_Invalid,le.gsa_last_Invalid,le.gsa_suffix_Invalid,le.gsa_city_Invalid,le.gsa_state_Invalid,le.gsa_zip_Invalid,le.date_Invalid,le.agency_Invalid,le.confidence_Invalid,le.clean_gsa_first_Invalid,le.clean_gsa_middle_Invalid,le.clean_gsa_last_Invalid,le.clean_gsa_suffix_Invalid,le.clean_gsa_city_Invalid,le.clean_gsa_state_Invalid,le.clean_gsa_zip_Invalid,le.clean_gsa_action_date_Invalid,le.clean_gsa_date_Invalid,le.fax_Invalid,le.phone_Invalid,le.certification_code_Invalid,le.certification_description_Invalid,le.board_code_Invalid,le.board_description_Invalid,le.expiration_year_Invalid,le.issue_year_Invalid,le.renewal_year_Invalid,le.lifetime_flag_Invalid,le.covered_recipient_id_Invalid,le.cov_rcp_raw_state_code_Invalid,le.cov_rcp_raw_full_name_Invalid,le.cov_rcp_raw_attribute1_Invalid,le.cov_rcp_raw_attribute2_Invalid,le.cov_rcp_raw_attribute3_Invalid,le.cov_rcp_raw_attribute4_Invalid,le.hms_scid_Invalid,le.school_name_Invalid,le.grad_year_Invalid,le.lang_code_Invalid,le.language_Invalid,le.specialty_description_Invalid,le.clean_phone_Invalid,le.bdid_Invalid,le.bdid_score_Invalid,le.did_Invalid,le.did_score_Invalid,le.clean_dob_Invalid,le.best_dob_Invalid,le.best_ssn_Invalid,le.rec_deactivated_date_Invalid,le.superceeding_piid_Invalid,le.dotid_Invalid,le.dotscore_Invalid,le.dotweight_Invalid,le.empid_Invalid,le.empscore_Invalid,le.empweight_Invalid,le.powid_Invalid,le.powscore_Invalid,le.powweight_Invalid,le.proxid_Invalid,le.proxscore_Invalid,le.proxweight_Invalid,le.seleid_Invalid,le.selescore_Invalid,le.seleweight_Invalid,le.orgid_Invalid,le.orgscore_Invalid,le.orgweight_Invalid,le.ultid_Invalid,le.ultscore_Invalid,le.ultweight_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Individuals_Fields.InvalidMessage_hms_piid(le.hms_piid_Invalid),Individuals_Fields.InvalidMessage_first(le.first_Invalid),Individuals_Fields.InvalidMessage_middle(le.middle_Invalid),Individuals_Fields.InvalidMessage_last(le.last_Invalid),Individuals_Fields.InvalidMessage_suffix(le.suffix_Invalid),Individuals_Fields.InvalidMessage_cred(le.cred_Invalid),Individuals_Fields.InvalidMessage_practitioner_type(le.practitioner_type_Invalid),Individuals_Fields.InvalidMessage_active(le.active_Invalid),Individuals_Fields.InvalidMessage_vendible(le.vendible_Invalid),Individuals_Fields.InvalidMessage_npi_num(le.npi_num_Invalid),Individuals_Fields.InvalidMessage_npi_enumeration_date(le.npi_enumeration_date_Invalid),Individuals_Fields.InvalidMessage_npi_deactivation_date(le.npi_deactivation_date_Invalid),Individuals_Fields.InvalidMessage_npi_reactivation_date(le.npi_reactivation_date_Invalid),Individuals_Fields.InvalidMessage_npi_taxonomy_code(le.npi_taxonomy_code_Invalid),Individuals_Fields.InvalidMessage_upin(le.upin_Invalid),Individuals_Fields.InvalidMessage_medicare_participation_flag(le.medicare_participation_flag_Invalid),Individuals_Fields.InvalidMessage_date_born(le.date_born_Invalid),Individuals_Fields.InvalidMessage_date_died(le.date_died_Invalid),Individuals_Fields.InvalidMessage_pid(le.pid_Invalid),Individuals_Fields.InvalidMessage_src(le.src_Invalid),Individuals_Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Individuals_Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Individuals_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Individuals_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Individuals_Fields.InvalidMessage_record_type(le.record_type_Invalid),Individuals_Fields.InvalidMessage_source_rid(le.source_rid_Invalid),Individuals_Fields.InvalidMessage_lnpid(le.lnpid_Invalid),Individuals_Fields.InvalidMessage_fname(le.fname_Invalid),Individuals_Fields.InvalidMessage_mname(le.mname_Invalid),Individuals_Fields.InvalidMessage_lname(le.lname_Invalid),Individuals_Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Individuals_Fields.InvalidMessage_nametype(le.nametype_Invalid),Individuals_Fields.InvalidMessage_nid(le.nid_Invalid),Individuals_Fields.InvalidMessage_clean_npi_enumeration_date(le.clean_npi_enumeration_date_Invalid),Individuals_Fields.InvalidMessage_clean_npi_deactivation_date(le.clean_npi_deactivation_date_Invalid),Individuals_Fields.InvalidMessage_clean_npi_reactivation_date(le.clean_npi_reactivation_date_Invalid),Individuals_Fields.InvalidMessage_clean_date_born(le.clean_date_born_Invalid),Individuals_Fields.InvalidMessage_clean_date_died(le.clean_date_died_Invalid),Individuals_Fields.InvalidMessage_clean_company_name(le.clean_company_name_Invalid),Individuals_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Individuals_Fields.InvalidMessage_predir(le.predir_Invalid),Individuals_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Individuals_Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Individuals_Fields.InvalidMessage_postdir(le.postdir_Invalid),Individuals_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Individuals_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Individuals_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Individuals_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Individuals_Fields.InvalidMessage_st(le.st_Invalid),Individuals_Fields.InvalidMessage_zip(le.zip_Invalid),Individuals_Fields.InvalidMessage_zip4(le.zip4_Invalid),Individuals_Fields.InvalidMessage_cart(le.cart_Invalid),Individuals_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Individuals_Fields.InvalidMessage_lot(le.lot_Invalid),Individuals_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Individuals_Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Individuals_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Individuals_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Individuals_Fields.InvalidMessage_fips_st(le.fips_st_Invalid),Individuals_Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Individuals_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Individuals_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Individuals_Fields.InvalidMessage_msa(le.msa_Invalid),Individuals_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Individuals_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Individuals_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Individuals_Fields.InvalidMessage_rawaid(le.rawaid_Invalid),Individuals_Fields.InvalidMessage_aceaid(le.aceaid_Invalid),Individuals_Fields.InvalidMessage_firm_name(le.firm_name_Invalid),Individuals_Fields.InvalidMessage_lid(le.lid_Invalid),Individuals_Fields.InvalidMessage_agid(le.agid_Invalid),Individuals_Fields.InvalidMessage_address_std_code(le.address_std_code_Invalid),Individuals_Fields.InvalidMessage_latitude(le.latitude_Invalid),Individuals_Fields.InvalidMessage_longitude(le.longitude_Invalid),Individuals_Fields.InvalidMessage_prepped_addr1(le.prepped_addr1_Invalid),Individuals_Fields.InvalidMessage_prepped_addr2(le.prepped_addr2_Invalid),Individuals_Fields.InvalidMessage_addr_type(le.addr_type_Invalid),Individuals_Fields.InvalidMessage_state_license_state(le.state_license_state_Invalid),Individuals_Fields.InvalidMessage_state_license_number(le.state_license_number_Invalid),Individuals_Fields.InvalidMessage_state_license_type(le.state_license_type_Invalid),Individuals_Fields.InvalidMessage_state_license_active(le.state_license_active_Invalid),Individuals_Fields.InvalidMessage_state_license_expire(le.state_license_expire_Invalid),Individuals_Fields.InvalidMessage_state_license_qualifier(le.state_license_qualifier_Invalid),Individuals_Fields.InvalidMessage_state_license_sub_qualifier(le.state_license_sub_qualifier_Invalid),Individuals_Fields.InvalidMessage_state_license_issued(le.state_license_issued_Invalid),Individuals_Fields.InvalidMessage_clean_state_license_expire(le.clean_state_license_expire_Invalid),Individuals_Fields.InvalidMessage_clean_state_license_issued(le.clean_state_license_issued_Invalid),Individuals_Fields.InvalidMessage_dea_num(le.dea_num_Invalid),Individuals_Fields.InvalidMessage_dea_bac(le.dea_bac_Invalid),Individuals_Fields.InvalidMessage_dea_sub_bac(le.dea_sub_bac_Invalid),Individuals_Fields.InvalidMessage_dea_schedule(le.dea_schedule_Invalid),Individuals_Fields.InvalidMessage_dea_expire(le.dea_expire_Invalid),Individuals_Fields.InvalidMessage_dea_active(le.dea_active_Invalid),Individuals_Fields.InvalidMessage_clean_dea_expire(le.clean_dea_expire_Invalid),Individuals_Fields.InvalidMessage_csr_number(le.csr_number_Invalid),Individuals_Fields.InvalidMessage_csr_state(le.csr_state_Invalid),Individuals_Fields.InvalidMessage_csr_expire_date(le.csr_expire_date_Invalid),Individuals_Fields.InvalidMessage_csr_issue_date(le.csr_issue_date_Invalid),Individuals_Fields.InvalidMessage_dsa_lvl_2(le.dsa_lvl_2_Invalid),Individuals_Fields.InvalidMessage_dsa_lvl_2n(le.dsa_lvl_2n_Invalid),Individuals_Fields.InvalidMessage_dsa_lvl_3(le.dsa_lvl_3_Invalid),Individuals_Fields.InvalidMessage_dsa_lvl_3n(le.dsa_lvl_3n_Invalid),Individuals_Fields.InvalidMessage_dsa_lvl_4(le.dsa_lvl_4_Invalid),Individuals_Fields.InvalidMessage_dsa_lvl_5(le.dsa_lvl_5_Invalid),Individuals_Fields.InvalidMessage_csr_raw1(le.csr_raw1_Invalid),Individuals_Fields.InvalidMessage_csr_raw2(le.csr_raw2_Invalid),Individuals_Fields.InvalidMessage_csr_raw3(le.csr_raw3_Invalid),Individuals_Fields.InvalidMessage_csr_raw4(le.csr_raw4_Invalid),Individuals_Fields.InvalidMessage_clean_csr_expire_date(le.clean_csr_expire_date_Invalid),Individuals_Fields.InvalidMessage_clean_csr_issue_date(le.clean_csr_issue_date_Invalid),Individuals_Fields.InvalidMessage_sanction_id(le.sanction_id_Invalid),Individuals_Fields.InvalidMessage_sanction_action_code(le.sanction_action_code_Invalid),Individuals_Fields.InvalidMessage_sanction_action_description(le.sanction_action_description_Invalid),Individuals_Fields.InvalidMessage_sanction_board_code(le.sanction_board_code_Invalid),Individuals_Fields.InvalidMessage_sanction_board_description(le.sanction_board_description_Invalid),Individuals_Fields.InvalidMessage_action_date(le.action_date_Invalid),Individuals_Fields.InvalidMessage_sanction_period_start_date(le.sanction_period_start_date_Invalid),Individuals_Fields.InvalidMessage_sanction_period_end_date(le.sanction_period_end_date_Invalid),Individuals_Fields.InvalidMessage_month_duration(le.month_duration_Invalid),Individuals_Fields.InvalidMessage_fine_amount(le.fine_amount_Invalid),Individuals_Fields.InvalidMessage_offense_code(le.offense_code_Invalid),Individuals_Fields.InvalidMessage_offense_description(le.offense_description_Invalid),Individuals_Fields.InvalidMessage_offense_date(le.offense_date_Invalid),Individuals_Fields.InvalidMessage_clean_offense_date(le.clean_offense_date_Invalid),Individuals_Fields.InvalidMessage_clean_action_date(le.clean_action_date_Invalid),Individuals_Fields.InvalidMessage_clean_sanction_period_start_date(le.clean_sanction_period_start_date_Invalid),Individuals_Fields.InvalidMessage_clean_sanction_period_end_date(le.clean_sanction_period_end_date_Invalid),Individuals_Fields.InvalidMessage_gsa_sanction_id(le.gsa_sanction_id_Invalid),Individuals_Fields.InvalidMessage_gsa_first(le.gsa_first_Invalid),Individuals_Fields.InvalidMessage_gsa_middle(le.gsa_middle_Invalid),Individuals_Fields.InvalidMessage_gsa_last(le.gsa_last_Invalid),Individuals_Fields.InvalidMessage_gsa_suffix(le.gsa_suffix_Invalid),Individuals_Fields.InvalidMessage_gsa_city(le.gsa_city_Invalid),Individuals_Fields.InvalidMessage_gsa_state(le.gsa_state_Invalid),Individuals_Fields.InvalidMessage_gsa_zip(le.gsa_zip_Invalid),Individuals_Fields.InvalidMessage_date(le.date_Invalid),Individuals_Fields.InvalidMessage_agency(le.agency_Invalid),Individuals_Fields.InvalidMessage_confidence(le.confidence_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_first(le.clean_gsa_first_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_middle(le.clean_gsa_middle_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_last(le.clean_gsa_last_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_suffix(le.clean_gsa_suffix_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_city(le.clean_gsa_city_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_state(le.clean_gsa_state_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_zip(le.clean_gsa_zip_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_action_date(le.clean_gsa_action_date_Invalid),Individuals_Fields.InvalidMessage_clean_gsa_date(le.clean_gsa_date_Invalid),Individuals_Fields.InvalidMessage_fax(le.fax_Invalid),Individuals_Fields.InvalidMessage_phone(le.phone_Invalid),Individuals_Fields.InvalidMessage_certification_code(le.certification_code_Invalid),Individuals_Fields.InvalidMessage_certification_description(le.certification_description_Invalid),Individuals_Fields.InvalidMessage_board_code(le.board_code_Invalid),Individuals_Fields.InvalidMessage_board_description(le.board_description_Invalid),Individuals_Fields.InvalidMessage_expiration_year(le.expiration_year_Invalid),Individuals_Fields.InvalidMessage_issue_year(le.issue_year_Invalid),Individuals_Fields.InvalidMessage_renewal_year(le.renewal_year_Invalid),Individuals_Fields.InvalidMessage_lifetime_flag(le.lifetime_flag_Invalid),Individuals_Fields.InvalidMessage_covered_recipient_id(le.covered_recipient_id_Invalid),Individuals_Fields.InvalidMessage_cov_rcp_raw_state_code(le.cov_rcp_raw_state_code_Invalid),Individuals_Fields.InvalidMessage_cov_rcp_raw_full_name(le.cov_rcp_raw_full_name_Invalid),Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute1(le.cov_rcp_raw_attribute1_Invalid),Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute2(le.cov_rcp_raw_attribute2_Invalid),Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute3(le.cov_rcp_raw_attribute3_Invalid),Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute4(le.cov_rcp_raw_attribute4_Invalid),Individuals_Fields.InvalidMessage_hms_scid(le.hms_scid_Invalid),Individuals_Fields.InvalidMessage_school_name(le.school_name_Invalid),Individuals_Fields.InvalidMessage_grad_year(le.grad_year_Invalid),Individuals_Fields.InvalidMessage_lang_code(le.lang_code_Invalid),Individuals_Fields.InvalidMessage_language(le.language_Invalid),Individuals_Fields.InvalidMessage_specialty_description(le.specialty_description_Invalid),Individuals_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Individuals_Fields.InvalidMessage_bdid(le.bdid_Invalid),Individuals_Fields.InvalidMessage_bdid_score(le.bdid_score_Invalid),Individuals_Fields.InvalidMessage_did(le.did_Invalid),Individuals_Fields.InvalidMessage_did_score(le.did_score_Invalid),Individuals_Fields.InvalidMessage_clean_dob(le.clean_dob_Invalid),Individuals_Fields.InvalidMessage_best_dob(le.best_dob_Invalid),Individuals_Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),Individuals_Fields.InvalidMessage_rec_deactivated_date(le.rec_deactivated_date_Invalid),Individuals_Fields.InvalidMessage_superceeding_piid(le.superceeding_piid_Invalid),Individuals_Fields.InvalidMessage_dotid(le.dotid_Invalid),Individuals_Fields.InvalidMessage_dotscore(le.dotscore_Invalid),Individuals_Fields.InvalidMessage_dotweight(le.dotweight_Invalid),Individuals_Fields.InvalidMessage_empid(le.empid_Invalid),Individuals_Fields.InvalidMessage_empscore(le.empscore_Invalid),Individuals_Fields.InvalidMessage_empweight(le.empweight_Invalid),Individuals_Fields.InvalidMessage_powid(le.powid_Invalid),Individuals_Fields.InvalidMessage_powscore(le.powscore_Invalid),Individuals_Fields.InvalidMessage_powweight(le.powweight_Invalid),Individuals_Fields.InvalidMessage_proxid(le.proxid_Invalid),Individuals_Fields.InvalidMessage_proxscore(le.proxscore_Invalid),Individuals_Fields.InvalidMessage_proxweight(le.proxweight_Invalid),Individuals_Fields.InvalidMessage_seleid(le.seleid_Invalid),Individuals_Fields.InvalidMessage_selescore(le.selescore_Invalid),Individuals_Fields.InvalidMessage_seleweight(le.seleweight_Invalid),Individuals_Fields.InvalidMessage_orgid(le.orgid_Invalid),Individuals_Fields.InvalidMessage_orgscore(le.orgscore_Invalid),Individuals_Fields.InvalidMessage_orgweight(le.orgweight_Invalid),Individuals_Fields.InvalidMessage_ultid(le.ultid_Invalid),Individuals_Fields.InvalidMessage_ultscore(le.ultscore_Invalid),Individuals_Fields.InvalidMessage_ultweight(le.ultweight_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.hms_piid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.first_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.middle_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.last_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cred_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.practitioner_type_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.active_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.vendible_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.npi_num_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.npi_enumeration_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.npi_deactivation_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.npi_reactivation_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.npi_taxonomy_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.upin_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.medicare_participation_flag_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.date_born_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.date_died_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.pid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.src_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.source_rid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lnpid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.nametype_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.nid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_npi_enumeration_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_npi_deactivation_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_npi_reactivation_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_date_born_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_date_died_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_company_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_st_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.aceaid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.firm_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.agid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.address_std_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.latitude_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.longitude_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prepped_addr1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.prepped_addr2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_type_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_license_state_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_license_number_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_license_type_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_license_active_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_license_expire_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_license_qualifier_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_license_sub_qualifier_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.state_license_issued_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_state_license_expire_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_state_license_issued_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dea_num_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dea_bac_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dea_sub_bac_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dea_schedule_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dea_expire_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dea_active_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_dea_expire_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.csr_number_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.csr_state_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.csr_expire_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.csr_issue_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dsa_lvl_2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dsa_lvl_2n_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dsa_lvl_3_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dsa_lvl_3n_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dsa_lvl_4_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dsa_lvl_5_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.csr_raw1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.csr_raw2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.csr_raw3_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.csr_raw4_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_csr_expire_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_csr_issue_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sanction_id_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sanction_action_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sanction_action_description_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sanction_board_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sanction_board_description_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.action_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sanction_period_start_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.sanction_period_end_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.month_duration_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.fine_amount_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.offense_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.offense_description_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.offense_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_offense_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_action_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_sanction_period_start_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_sanction_period_end_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.gsa_sanction_id_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.gsa_first_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.gsa_middle_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.gsa_last_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.gsa_suffix_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.gsa_city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.gsa_state_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.gsa_zip_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.agency_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.confidence_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_first_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_middle_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_last_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_suffix_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_city_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_state_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_zip_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_action_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_gsa_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.fax_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.certification_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.certification_description_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.board_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.board_description_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.expiration_year_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.issue_year_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.renewal_year_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lifetime_flag_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.covered_recipient_id_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cov_rcp_raw_state_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cov_rcp_raw_full_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cov_rcp_raw_attribute1_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cov_rcp_raw_attribute2_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cov_rcp_raw_attribute3_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.cov_rcp_raw_attribute4_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.hms_scid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.school_name_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.grad_year_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.lang_code_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.language_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.specialty_description_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.bdid_score_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_dob_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.best_dob_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.rec_deactivated_date_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.superceeding_piid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dotid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dotscore_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.dotweight_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.empid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.empscore_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.empweight_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.powid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.powscore_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.powweight_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.proxscore_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.proxweight_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.selescore_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.seleweight_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.orgscore_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.orgweight_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ultscore_Invalid,'LEFTTRIM','ALLOW','UNKNOWN')
          ,CHOOSE(le.ultweight_Invalid,'LEFTTRIM','ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'hms_piid','first','middle','last','suffix','cred','practitioner_type','active','vendible','npi_num','npi_enumeration_date','npi_deactivation_date','npi_reactivation_date','npi_taxonomy_code','upin','medicare_participation_flag','date_born','date_died','pid','src','date_vendor_first_reported','date_vendor_last_reported','date_first_seen','date_last_seen','record_type','source_rid','lnpid','fname','mname','lname','name_suffix','nametype','nid','clean_npi_enumeration_date','clean_npi_deactivation_date','clean_npi_reactivation_date','clean_date_born','clean_date_died','clean_company_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','firm_name','lid','agid','address_std_code','latitude','longitude','prepped_addr1','prepped_addr2','addr_type','state_license_state','state_license_number','state_license_type','state_license_active','state_license_expire','state_license_qualifier','state_license_sub_qualifier','state_license_issued','clean_state_license_expire','clean_state_license_issued','dea_num','dea_bac','dea_sub_bac','dea_schedule','dea_expire','dea_active','clean_dea_expire','csr_number','csr_state','csr_expire_date','csr_issue_date','dsa_lvl_2','dsa_lvl_2n','dsa_lvl_3','dsa_lvl_3n','dsa_lvl_4','dsa_lvl_5','csr_raw1','csr_raw2','csr_raw3','csr_raw4','clean_csr_expire_date','clean_csr_issue_date','sanction_id','sanction_action_code','sanction_action_description','sanction_board_code','sanction_board_description','action_date','sanction_period_start_date','sanction_period_end_date','month_duration','fine_amount','offense_code','offense_description','offense_date','clean_offense_date','clean_action_date','clean_sanction_period_start_date','clean_sanction_period_end_date','gsa_sanction_id','gsa_first','gsa_middle','gsa_last','gsa_suffix','gsa_city','gsa_state','gsa_zip','date','agency','confidence','clean_gsa_first','clean_gsa_middle','clean_gsa_last','clean_gsa_suffix','clean_gsa_city','clean_gsa_state','clean_gsa_zip','clean_gsa_action_date','clean_gsa_date','fax','phone','certification_code','certification_description','board_code','board_description','expiration_year','issue_year','renewal_year','lifetime_flag','covered_recipient_id','cov_rcp_raw_state_code','cov_rcp_raw_full_name','cov_rcp_raw_attribute1','cov_rcp_raw_attribute2','cov_rcp_raw_attribute3','cov_rcp_raw_attribute4','hms_scid','school_name','grad_year','lang_code','language','specialty_description','clean_phone','bdid','bdid_score','did','did_score','clean_dob','best_dob','best_ssn','rec_deactivated_date','superceeding_piid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'hms_piid','first','middle','last','suffix','cred','practitioner_type','active','vendible','npi_num','npi_enumeration_date','npi_deactivation_date','npi_reactivation_date','npi_taxonomy_code','upin','medicare_participation_flag','date_born','date_died','pid','src','date_vendor_first_reported','date_vendor_last_reported','date_first_seen','date_last_seen','record_type','source_rid','lnpid','fname','mname','lname','name_suffix','nametype','nid','clean_npi_enumeration_date','clean_npi_deactivation_date','clean_npi_reactivation_date','clean_date_born','clean_date_died','clean_company_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','fips_st','fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','rawaid','aceaid','firm_name','lid','agid','address_std_code','latitude','longitude','prepped_addr1','prepped_addr2','addr_type','state_license_state','state_license_number','state_license_type','state_license_active','state_license_expire','state_license_qualifier','state_license_sub_qualifier','state_license_issued','clean_state_license_expire','clean_state_license_issued','dea_num','dea_bac','dea_sub_bac','dea_schedule','dea_expire','dea_active','clean_dea_expire','csr_number','csr_state','csr_expire_date','csr_issue_date','dsa_lvl_2','dsa_lvl_2n','dsa_lvl_3','dsa_lvl_3n','dsa_lvl_4','dsa_lvl_5','csr_raw1','csr_raw2','csr_raw3','csr_raw4','clean_csr_expire_date','clean_csr_issue_date','sanction_id','sanction_action_code','sanction_action_description','sanction_board_code','sanction_board_description','action_date','sanction_period_start_date','sanction_period_end_date','month_duration','fine_amount','offense_code','offense_description','offense_date','clean_offense_date','clean_action_date','clean_sanction_period_start_date','clean_sanction_period_end_date','gsa_sanction_id','gsa_first','gsa_middle','gsa_last','gsa_suffix','gsa_city','gsa_state','gsa_zip','date','agency','confidence','clean_gsa_first','clean_gsa_middle','clean_gsa_last','clean_gsa_suffix','clean_gsa_city','clean_gsa_state','clean_gsa_zip','clean_gsa_action_date','clean_gsa_date','fax','phone','certification_code','certification_description','board_code','board_description','expiration_year','issue_year','renewal_year','lifetime_flag','covered_recipient_id','cov_rcp_raw_state_code','cov_rcp_raw_full_name','cov_rcp_raw_attribute1','cov_rcp_raw_attribute2','cov_rcp_raw_attribute3','cov_rcp_raw_attribute4','hms_scid','school_name','grad_year','lang_code','language','specialty_description','clean_phone','bdid','bdid_score','did','did_score','clean_dob','best_dob','best_ssn','rec_deactivated_date','superceeding_piid','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT31.StrType)le.hms_piid,(SALT31.StrType)le.first,(SALT31.StrType)le.middle,(SALT31.StrType)le.last,(SALT31.StrType)le.suffix,(SALT31.StrType)le.cred,(SALT31.StrType)le.practitioner_type,(SALT31.StrType)le.active,(SALT31.StrType)le.vendible,(SALT31.StrType)le.npi_num,(SALT31.StrType)le.npi_enumeration_date,(SALT31.StrType)le.npi_deactivation_date,(SALT31.StrType)le.npi_reactivation_date,(SALT31.StrType)le.npi_taxonomy_code,(SALT31.StrType)le.upin,(SALT31.StrType)le.medicare_participation_flag,(SALT31.StrType)le.date_born,(SALT31.StrType)le.date_died,(SALT31.StrType)le.pid,(SALT31.StrType)le.src,(SALT31.StrType)le.date_vendor_first_reported,(SALT31.StrType)le.date_vendor_last_reported,(SALT31.StrType)le.date_first_seen,(SALT31.StrType)le.date_last_seen,(SALT31.StrType)le.record_type,(SALT31.StrType)le.source_rid,(SALT31.StrType)le.lnpid,(SALT31.StrType)le.fname,(SALT31.StrType)le.mname,(SALT31.StrType)le.lname,(SALT31.StrType)le.name_suffix,(SALT31.StrType)le.nametype,(SALT31.StrType)le.nid,(SALT31.StrType)le.clean_npi_enumeration_date,(SALT31.StrType)le.clean_npi_deactivation_date,(SALT31.StrType)le.clean_npi_reactivation_date,(SALT31.StrType)le.clean_date_born,(SALT31.StrType)le.clean_date_died,(SALT31.StrType)le.clean_company_name,(SALT31.StrType)le.prim_range,(SALT31.StrType)le.predir,(SALT31.StrType)le.prim_name,(SALT31.StrType)le.addr_suffix,(SALT31.StrType)le.postdir,(SALT31.StrType)le.unit_desig,(SALT31.StrType)le.sec_range,(SALT31.StrType)le.p_city_name,(SALT31.StrType)le.v_city_name,(SALT31.StrType)le.st,(SALT31.StrType)le.zip,(SALT31.StrType)le.zip4,(SALT31.StrType)le.cart,(SALT31.StrType)le.cr_sort_sz,(SALT31.StrType)le.lot,(SALT31.StrType)le.lot_order,(SALT31.StrType)le.dbpc,(SALT31.StrType)le.chk_digit,(SALT31.StrType)le.rec_type,(SALT31.StrType)le.fips_st,(SALT31.StrType)le.fips_county,(SALT31.StrType)le.geo_lat,(SALT31.StrType)le.geo_long,(SALT31.StrType)le.msa,(SALT31.StrType)le.geo_blk,(SALT31.StrType)le.geo_match,(SALT31.StrType)le.err_stat,(SALT31.StrType)le.rawaid,(SALT31.StrType)le.aceaid,(SALT31.StrType)le.firm_name,(SALT31.StrType)le.lid,(SALT31.StrType)le.agid,(SALT31.StrType)le.address_std_code,(SALT31.StrType)le.latitude,(SALT31.StrType)le.longitude,(SALT31.StrType)le.prepped_addr1,(SALT31.StrType)le.prepped_addr2,(SALT31.StrType)le.addr_type,(SALT31.StrType)le.state_license_state,(SALT31.StrType)le.state_license_number,(SALT31.StrType)le.state_license_type,(SALT31.StrType)le.state_license_active,(SALT31.StrType)le.state_license_expire,(SALT31.StrType)le.state_license_qualifier,(SALT31.StrType)le.state_license_sub_qualifier,(SALT31.StrType)le.state_license_issued,(SALT31.StrType)le.clean_state_license_expire,(SALT31.StrType)le.clean_state_license_issued,(SALT31.StrType)le.dea_num,(SALT31.StrType)le.dea_bac,(SALT31.StrType)le.dea_sub_bac,(SALT31.StrType)le.dea_schedule,(SALT31.StrType)le.dea_expire,(SALT31.StrType)le.dea_active,(SALT31.StrType)le.clean_dea_expire,(SALT31.StrType)le.csr_number,(SALT31.StrType)le.csr_state,(SALT31.StrType)le.csr_expire_date,(SALT31.StrType)le.csr_issue_date,(SALT31.StrType)le.dsa_lvl_2,(SALT31.StrType)le.dsa_lvl_2n,(SALT31.StrType)le.dsa_lvl_3,(SALT31.StrType)le.dsa_lvl_3n,(SALT31.StrType)le.dsa_lvl_4,(SALT31.StrType)le.dsa_lvl_5,(SALT31.StrType)le.csr_raw1,(SALT31.StrType)le.csr_raw2,(SALT31.StrType)le.csr_raw3,(SALT31.StrType)le.csr_raw4,(SALT31.StrType)le.clean_csr_expire_date,(SALT31.StrType)le.clean_csr_issue_date,(SALT31.StrType)le.sanction_id,(SALT31.StrType)le.sanction_action_code,(SALT31.StrType)le.sanction_action_description,(SALT31.StrType)le.sanction_board_code,(SALT31.StrType)le.sanction_board_description,(SALT31.StrType)le.action_date,(SALT31.StrType)le.sanction_period_start_date,(SALT31.StrType)le.sanction_period_end_date,(SALT31.StrType)le.month_duration,(SALT31.StrType)le.fine_amount,(SALT31.StrType)le.offense_code,(SALT31.StrType)le.offense_description,(SALT31.StrType)le.offense_date,(SALT31.StrType)le.clean_offense_date,(SALT31.StrType)le.clean_action_date,(SALT31.StrType)le.clean_sanction_period_start_date,(SALT31.StrType)le.clean_sanction_period_end_date,(SALT31.StrType)le.gsa_sanction_id,(SALT31.StrType)le.gsa_first,(SALT31.StrType)le.gsa_middle,(SALT31.StrType)le.gsa_last,(SALT31.StrType)le.gsa_suffix,(SALT31.StrType)le.gsa_city,(SALT31.StrType)le.gsa_state,(SALT31.StrType)le.gsa_zip,(SALT31.StrType)le.date,(SALT31.StrType)le.agency,(SALT31.StrType)le.confidence,(SALT31.StrType)le.clean_gsa_first,(SALT31.StrType)le.clean_gsa_middle,(SALT31.StrType)le.clean_gsa_last,(SALT31.StrType)le.clean_gsa_suffix,(SALT31.StrType)le.clean_gsa_city,(SALT31.StrType)le.clean_gsa_state,(SALT31.StrType)le.clean_gsa_zip,(SALT31.StrType)le.clean_gsa_action_date,(SALT31.StrType)le.clean_gsa_date,(SALT31.StrType)le.fax,(SALT31.StrType)le.phone,(SALT31.StrType)le.certification_code,(SALT31.StrType)le.certification_description,(SALT31.StrType)le.board_code,(SALT31.StrType)le.board_description,(SALT31.StrType)le.expiration_year,(SALT31.StrType)le.issue_year,(SALT31.StrType)le.renewal_year,(SALT31.StrType)le.lifetime_flag,(SALT31.StrType)le.covered_recipient_id,(SALT31.StrType)le.cov_rcp_raw_state_code,(SALT31.StrType)le.cov_rcp_raw_full_name,(SALT31.StrType)le.cov_rcp_raw_attribute1,(SALT31.StrType)le.cov_rcp_raw_attribute2,(SALT31.StrType)le.cov_rcp_raw_attribute3,(SALT31.StrType)le.cov_rcp_raw_attribute4,(SALT31.StrType)le.hms_scid,(SALT31.StrType)le.school_name,(SALT31.StrType)le.grad_year,(SALT31.StrType)le.lang_code,(SALT31.StrType)le.language,(SALT31.StrType)le.specialty_description,(SALT31.StrType)le.clean_phone,(SALT31.StrType)le.bdid,(SALT31.StrType)le.bdid_score,(SALT31.StrType)le.did,(SALT31.StrType)le.did_score,(SALT31.StrType)le.clean_dob,(SALT31.StrType)le.best_dob,(SALT31.StrType)le.best_ssn,(SALT31.StrType)le.rec_deactivated_date,(SALT31.StrType)le.superceeding_piid,(SALT31.StrType)le.dotid,(SALT31.StrType)le.dotscore,(SALT31.StrType)le.dotweight,(SALT31.StrType)le.empid,(SALT31.StrType)le.empscore,(SALT31.StrType)le.empweight,(SALT31.StrType)le.powid,(SALT31.StrType)le.powscore,(SALT31.StrType)le.powweight,(SALT31.StrType)le.proxid,(SALT31.StrType)le.proxscore,(SALT31.StrType)le.proxweight,(SALT31.StrType)le.seleid,(SALT31.StrType)le.selescore,(SALT31.StrType)le.seleweight,(SALT31.StrType)le.orgid,(SALT31.StrType)le.orgscore,(SALT31.StrType)le.orgweight,(SALT31.StrType)le.ultid,(SALT31.StrType)le.ultscore,(SALT31.StrType)le.ultweight,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,201,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT31.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'hms_piid:hms_piid:LEFTTRIM','hms_piid:hms_piid:ALLOW'
          ,'first:first:LEFTTRIM','first:first:ALLOW'
          ,'middle:middle:LEFTTRIM','middle:middle:ALLOW'
          ,'last:last:LEFTTRIM','last:last:ALLOW'
          ,'suffix:suffix:LEFTTRIM','suffix:suffix:ALLOW'
          ,'cred:cred:LEFTTRIM','cred:cred:ALLOW'
          ,'practitioner_type:practitioner_type:LEFTTRIM','practitioner_type:practitioner_type:ALLOW'
          ,'active:active:LEFTTRIM','active:active:ALLOW'
          ,'vendible:vendible:LEFTTRIM','vendible:vendible:ALLOW'
          ,'npi_num:npi_num:LEFTTRIM','npi_num:npi_num:ALLOW'
          ,'npi_enumeration_date:npi_enumeration_date:LEFTTRIM','npi_enumeration_date:npi_enumeration_date:ALLOW'
          ,'npi_deactivation_date:npi_deactivation_date:LEFTTRIM','npi_deactivation_date:npi_deactivation_date:ALLOW'
          ,'npi_reactivation_date:npi_reactivation_date:LEFTTRIM','npi_reactivation_date:npi_reactivation_date:ALLOW'
          ,'npi_taxonomy_code:npi_taxonomy_code:LEFTTRIM','npi_taxonomy_code:npi_taxonomy_code:ALLOW'
          ,'upin:upin:LEFTTRIM','upin:upin:ALLOW'
          ,'medicare_participation_flag:medicare_participation_flag:LEFTTRIM','medicare_participation_flag:medicare_participation_flag:ALLOW'
          ,'date_born:date_born:LEFTTRIM','date_born:date_born:ALLOW'
          ,'date_died:date_died:LEFTTRIM','date_died:date_died:ALLOW'
          ,'pid:pid:LEFTTRIM','pid:pid:ALLOW'
          ,'src:src:LEFTTRIM','src:src:ALLOW'
          ,'date_vendor_first_reported:date_vendor_first_reported:LEFTTRIM','date_vendor_first_reported:date_vendor_first_reported:ALLOW'
          ,'date_vendor_last_reported:date_vendor_last_reported:LEFTTRIM','date_vendor_last_reported:date_vendor_last_reported:ALLOW'
          ,'date_first_seen:date_first_seen:LEFTTRIM','date_first_seen:date_first_seen:ALLOW'
          ,'date_last_seen:date_last_seen:LEFTTRIM','date_last_seen:date_last_seen:ALLOW'
          ,'record_type:record_type:LEFTTRIM','record_type:record_type:ALLOW'
          ,'source_rid:source_rid:LEFTTRIM','source_rid:source_rid:ALLOW'
          ,'lnpid:lnpid:LEFTTRIM','lnpid:lnpid:ALLOW'
          ,'fname:fname:LEFTTRIM','fname:fname:ALLOW'
          ,'mname:mname:LEFTTRIM','mname:mname:ALLOW'
          ,'lname:lname:LEFTTRIM','lname:lname:ALLOW'
          ,'name_suffix:name_suffix:LEFTTRIM','name_suffix:name_suffix:ALLOW'
          ,'nametype:nametype:LEFTTRIM','nametype:nametype:ALLOW'
          ,'nid:nid:LEFTTRIM','nid:nid:ALLOW'
          ,'clean_npi_enumeration_date:clean_npi_enumeration_date:LEFTTRIM','clean_npi_enumeration_date:clean_npi_enumeration_date:ALLOW'
          ,'clean_npi_deactivation_date:clean_npi_deactivation_date:LEFTTRIM','clean_npi_deactivation_date:clean_npi_deactivation_date:ALLOW'
          ,'clean_npi_reactivation_date:clean_npi_reactivation_date:LEFTTRIM','clean_npi_reactivation_date:clean_npi_reactivation_date:ALLOW'
          ,'clean_date_born:clean_date_born:LEFTTRIM','clean_date_born:clean_date_born:ALLOW'
          ,'clean_date_died:clean_date_died:LEFTTRIM','clean_date_died:clean_date_died:ALLOW'
          ,'clean_company_name:clean_company_name:LEFTTRIM','clean_company_name:clean_company_name:ALLOW'
          ,'prim_range:prim_range:LEFTTRIM','prim_range:prim_range:ALLOW'
          ,'predir:predir:LEFTTRIM','predir:predir:ALLOW'
          ,'prim_name:prim_name:LEFTTRIM','prim_name:prim_name:ALLOW'
          ,'addr_suffix:addr_suffix:LEFTTRIM','addr_suffix:addr_suffix:ALLOW'
          ,'postdir:postdir:LEFTTRIM','postdir:postdir:ALLOW'
          ,'unit_desig:unit_desig:LEFTTRIM','unit_desig:unit_desig:ALLOW'
          ,'sec_range:sec_range:LEFTTRIM','sec_range:sec_range:ALLOW'
          ,'p_city_name:p_city_name:LEFTTRIM','p_city_name:p_city_name:ALLOW'
          ,'v_city_name:v_city_name:LEFTTRIM','v_city_name:v_city_name:ALLOW'
          ,'st:st:LEFTTRIM','st:st:ALLOW'
          ,'zip:zip:LEFTTRIM','zip:zip:ALLOW'
          ,'zip4:zip4:LEFTTRIM','zip4:zip4:ALLOW'
          ,'cart:cart:LEFTTRIM','cart:cart:ALLOW'
          ,'cr_sort_sz:cr_sort_sz:LEFTTRIM','cr_sort_sz:cr_sort_sz:ALLOW'
          ,'lot:lot:LEFTTRIM','lot:lot:ALLOW'
          ,'lot_order:lot_order:LEFTTRIM','lot_order:lot_order:ALLOW'
          ,'dbpc:dbpc:LEFTTRIM','dbpc:dbpc:ALLOW'
          ,'chk_digit:chk_digit:LEFTTRIM','chk_digit:chk_digit:ALLOW'
          ,'rec_type:rec_type:LEFTTRIM','rec_type:rec_type:ALLOW'
          ,'fips_st:fips_st:LEFTTRIM','fips_st:fips_st:ALLOW'
          ,'fips_county:fips_county:LEFTTRIM','fips_county:fips_county:ALLOW'
          ,'geo_lat:geo_lat:LEFTTRIM','geo_lat:geo_lat:ALLOW'
          ,'geo_long:geo_long:LEFTTRIM','geo_long:geo_long:ALLOW'
          ,'msa:msa:LEFTTRIM','msa:msa:ALLOW'
          ,'geo_blk:geo_blk:LEFTTRIM','geo_blk:geo_blk:ALLOW'
          ,'geo_match:geo_match:LEFTTRIM','geo_match:geo_match:ALLOW'
          ,'err_stat:err_stat:LEFTTRIM','err_stat:err_stat:ALLOW'
          ,'rawaid:rawaid:LEFTTRIM','rawaid:rawaid:ALLOW'
          ,'aceaid:aceaid:LEFTTRIM','aceaid:aceaid:ALLOW'
          ,'firm_name:firm_name:LEFTTRIM','firm_name:firm_name:ALLOW'
          ,'lid:lid:LEFTTRIM','lid:lid:ALLOW'
          ,'agid:agid:LEFTTRIM','agid:agid:ALLOW'
          ,'address_std_code:address_std_code:LEFTTRIM','address_std_code:address_std_code:ALLOW'
          ,'latitude:latitude:LEFTTRIM','latitude:latitude:ALLOW'
          ,'longitude:longitude:LEFTTRIM','longitude:longitude:ALLOW'
          ,'prepped_addr1:prepped_addr1:LEFTTRIM','prepped_addr1:prepped_addr1:ALLOW'
          ,'prepped_addr2:prepped_addr2:LEFTTRIM','prepped_addr2:prepped_addr2:ALLOW'
          ,'addr_type:addr_type:LEFTTRIM','addr_type:addr_type:ALLOW'
          ,'state_license_state:state_license_state:LEFTTRIM','state_license_state:state_license_state:ALLOW'
          ,'state_license_number:state_license_number:LEFTTRIM','state_license_number:state_license_number:ALLOW'
          ,'state_license_type:state_license_type:LEFTTRIM','state_license_type:state_license_type:ALLOW'
          ,'state_license_active:state_license_active:LEFTTRIM','state_license_active:state_license_active:ALLOW'
          ,'state_license_expire:state_license_expire:LEFTTRIM','state_license_expire:state_license_expire:ALLOW'
          ,'state_license_qualifier:state_license_qualifier:LEFTTRIM','state_license_qualifier:state_license_qualifier:ALLOW'
          ,'state_license_sub_qualifier:state_license_sub_qualifier:LEFTTRIM','state_license_sub_qualifier:state_license_sub_qualifier:ALLOW'
          ,'state_license_issued:state_license_issued:LEFTTRIM','state_license_issued:state_license_issued:ALLOW'
          ,'clean_state_license_expire:clean_state_license_expire:LEFTTRIM','clean_state_license_expire:clean_state_license_expire:ALLOW'
          ,'clean_state_license_issued:clean_state_license_issued:LEFTTRIM','clean_state_license_issued:clean_state_license_issued:ALLOW'
          ,'dea_num:dea_num:LEFTTRIM','dea_num:dea_num:ALLOW'
          ,'dea_bac:dea_bac:LEFTTRIM','dea_bac:dea_bac:ALLOW'
          ,'dea_sub_bac:dea_sub_bac:LEFTTRIM','dea_sub_bac:dea_sub_bac:ALLOW'
          ,'dea_schedule:dea_schedule:LEFTTRIM','dea_schedule:dea_schedule:ALLOW'
          ,'dea_expire:dea_expire:LEFTTRIM','dea_expire:dea_expire:ALLOW'
          ,'dea_active:dea_active:LEFTTRIM','dea_active:dea_active:ALLOW'
          ,'clean_dea_expire:clean_dea_expire:LEFTTRIM','clean_dea_expire:clean_dea_expire:ALLOW'
          ,'csr_number:csr_number:LEFTTRIM','csr_number:csr_number:ALLOW'
          ,'csr_state:csr_state:LEFTTRIM','csr_state:csr_state:ALLOW'
          ,'csr_expire_date:csr_expire_date:LEFTTRIM','csr_expire_date:csr_expire_date:ALLOW'
          ,'csr_issue_date:csr_issue_date:LEFTTRIM','csr_issue_date:csr_issue_date:ALLOW'
          ,'dsa_lvl_2:dsa_lvl_2:LEFTTRIM','dsa_lvl_2:dsa_lvl_2:ALLOW'
          ,'dsa_lvl_2n:dsa_lvl_2n:LEFTTRIM','dsa_lvl_2n:dsa_lvl_2n:ALLOW'
          ,'dsa_lvl_3:dsa_lvl_3:LEFTTRIM','dsa_lvl_3:dsa_lvl_3:ALLOW'
          ,'dsa_lvl_3n:dsa_lvl_3n:LEFTTRIM','dsa_lvl_3n:dsa_lvl_3n:ALLOW'
          ,'dsa_lvl_4:dsa_lvl_4:LEFTTRIM','dsa_lvl_4:dsa_lvl_4:ALLOW'
          ,'dsa_lvl_5:dsa_lvl_5:LEFTTRIM','dsa_lvl_5:dsa_lvl_5:ALLOW'
          ,'csr_raw1:csr_raw1:LEFTTRIM','csr_raw1:csr_raw1:ALLOW'
          ,'csr_raw2:csr_raw2:LEFTTRIM','csr_raw2:csr_raw2:ALLOW'
          ,'csr_raw3:csr_raw3:LEFTTRIM','csr_raw3:csr_raw3:ALLOW'
          ,'csr_raw4:csr_raw4:LEFTTRIM','csr_raw4:csr_raw4:ALLOW'
          ,'clean_csr_expire_date:clean_csr_expire_date:LEFTTRIM','clean_csr_expire_date:clean_csr_expire_date:ALLOW'
          ,'clean_csr_issue_date:clean_csr_issue_date:LEFTTRIM','clean_csr_issue_date:clean_csr_issue_date:ALLOW'
          ,'sanction_id:sanction_id:LEFTTRIM','sanction_id:sanction_id:ALLOW'
          ,'sanction_action_code:sanction_action_code:LEFTTRIM','sanction_action_code:sanction_action_code:ALLOW'
          ,'sanction_action_description:sanction_action_description:LEFTTRIM','sanction_action_description:sanction_action_description:ALLOW'
          ,'sanction_board_code:sanction_board_code:LEFTTRIM','sanction_board_code:sanction_board_code:ALLOW'
          ,'sanction_board_description:sanction_board_description:LEFTTRIM','sanction_board_description:sanction_board_description:ALLOW'
          ,'action_date:action_date:LEFTTRIM','action_date:action_date:ALLOW'
          ,'sanction_period_start_date:sanction_period_start_date:LEFTTRIM','sanction_period_start_date:sanction_period_start_date:ALLOW'
          ,'sanction_period_end_date:sanction_period_end_date:LEFTTRIM','sanction_period_end_date:sanction_period_end_date:ALLOW'
          ,'month_duration:month_duration:LEFTTRIM','month_duration:month_duration:ALLOW'
          ,'fine_amount:fine_amount:LEFTTRIM','fine_amount:fine_amount:ALLOW'
          ,'offense_code:offense_code:LEFTTRIM','offense_code:offense_code:ALLOW'
          ,'offense_description:offense_description:LEFTTRIM','offense_description:offense_description:ALLOW'
          ,'offense_date:offense_date:LEFTTRIM','offense_date:offense_date:ALLOW'
          ,'clean_offense_date:clean_offense_date:LEFTTRIM','clean_offense_date:clean_offense_date:ALLOW'
          ,'clean_action_date:clean_action_date:LEFTTRIM','clean_action_date:clean_action_date:ALLOW'
          ,'clean_sanction_period_start_date:clean_sanction_period_start_date:LEFTTRIM','clean_sanction_period_start_date:clean_sanction_period_start_date:ALLOW'
          ,'clean_sanction_period_end_date:clean_sanction_period_end_date:LEFTTRIM','clean_sanction_period_end_date:clean_sanction_period_end_date:ALLOW'
          ,'gsa_sanction_id:gsa_sanction_id:LEFTTRIM','gsa_sanction_id:gsa_sanction_id:ALLOW'
          ,'gsa_first:gsa_first:LEFTTRIM','gsa_first:gsa_first:ALLOW'
          ,'gsa_middle:gsa_middle:LEFTTRIM','gsa_middle:gsa_middle:ALLOW'
          ,'gsa_last:gsa_last:LEFTTRIM','gsa_last:gsa_last:ALLOW'
          ,'gsa_suffix:gsa_suffix:LEFTTRIM','gsa_suffix:gsa_suffix:ALLOW'
          ,'gsa_city:gsa_city:LEFTTRIM','gsa_city:gsa_city:ALLOW'
          ,'gsa_state:gsa_state:LEFTTRIM','gsa_state:gsa_state:ALLOW'
          ,'gsa_zip:gsa_zip:LEFTTRIM','gsa_zip:gsa_zip:ALLOW'
          ,'date:date:LEFTTRIM','date:date:ALLOW'
          ,'agency:agency:LEFTTRIM','agency:agency:ALLOW'
          ,'confidence:confidence:LEFTTRIM','confidence:confidence:ALLOW'
          ,'clean_gsa_first:clean_gsa_first:LEFTTRIM','clean_gsa_first:clean_gsa_first:ALLOW'
          ,'clean_gsa_middle:clean_gsa_middle:LEFTTRIM','clean_gsa_middle:clean_gsa_middle:ALLOW'
          ,'clean_gsa_last:clean_gsa_last:LEFTTRIM','clean_gsa_last:clean_gsa_last:ALLOW'
          ,'clean_gsa_suffix:clean_gsa_suffix:LEFTTRIM','clean_gsa_suffix:clean_gsa_suffix:ALLOW'
          ,'clean_gsa_city:clean_gsa_city:LEFTTRIM','clean_gsa_city:clean_gsa_city:ALLOW'
          ,'clean_gsa_state:clean_gsa_state:LEFTTRIM','clean_gsa_state:clean_gsa_state:ALLOW'
          ,'clean_gsa_zip:clean_gsa_zip:LEFTTRIM','clean_gsa_zip:clean_gsa_zip:ALLOW'
          ,'clean_gsa_action_date:clean_gsa_action_date:LEFTTRIM','clean_gsa_action_date:clean_gsa_action_date:ALLOW'
          ,'clean_gsa_date:clean_gsa_date:LEFTTRIM','clean_gsa_date:clean_gsa_date:ALLOW'
          ,'fax:fax:LEFTTRIM','fax:fax:ALLOW'
          ,'phone:phone:LEFTTRIM','phone:phone:ALLOW'
          ,'certification_code:certification_code:LEFTTRIM','certification_code:certification_code:ALLOW'
          ,'certification_description:certification_description:LEFTTRIM','certification_description:certification_description:ALLOW'
          ,'board_code:board_code:LEFTTRIM','board_code:board_code:ALLOW'
          ,'board_description:board_description:LEFTTRIM','board_description:board_description:ALLOW'
          ,'expiration_year:expiration_year:LEFTTRIM','expiration_year:expiration_year:ALLOW'
          ,'issue_year:issue_year:LEFTTRIM','issue_year:issue_year:ALLOW'
          ,'renewal_year:renewal_year:LEFTTRIM','renewal_year:renewal_year:ALLOW'
          ,'lifetime_flag:lifetime_flag:LEFTTRIM','lifetime_flag:lifetime_flag:ALLOW'
          ,'covered_recipient_id:covered_recipient_id:LEFTTRIM','covered_recipient_id:covered_recipient_id:ALLOW'
          ,'cov_rcp_raw_state_code:cov_rcp_raw_state_code:LEFTTRIM','cov_rcp_raw_state_code:cov_rcp_raw_state_code:ALLOW'
          ,'cov_rcp_raw_full_name:cov_rcp_raw_full_name:LEFTTRIM','cov_rcp_raw_full_name:cov_rcp_raw_full_name:ALLOW'
          ,'cov_rcp_raw_attribute1:cov_rcp_raw_attribute1:LEFTTRIM','cov_rcp_raw_attribute1:cov_rcp_raw_attribute1:ALLOW'
          ,'cov_rcp_raw_attribute2:cov_rcp_raw_attribute2:LEFTTRIM','cov_rcp_raw_attribute2:cov_rcp_raw_attribute2:ALLOW'
          ,'cov_rcp_raw_attribute3:cov_rcp_raw_attribute3:LEFTTRIM','cov_rcp_raw_attribute3:cov_rcp_raw_attribute3:ALLOW'
          ,'cov_rcp_raw_attribute4:cov_rcp_raw_attribute4:LEFTTRIM','cov_rcp_raw_attribute4:cov_rcp_raw_attribute4:ALLOW'
          ,'hms_scid:hms_scid:LEFTTRIM','hms_scid:hms_scid:ALLOW'
          ,'school_name:school_name:LEFTTRIM','school_name:school_name:ALLOW'
          ,'grad_year:grad_year:LEFTTRIM','grad_year:grad_year:ALLOW'
          ,'lang_code:lang_code:LEFTTRIM','lang_code:lang_code:ALLOW'
          ,'language:language:LEFTTRIM','language:language:ALLOW'
          ,'specialty_description:specialty_description:LEFTTRIM','specialty_description:specialty_description:ALLOW'
          ,'clean_phone:clean_phone:LEFTTRIM','clean_phone:clean_phone:ALLOW'
          ,'bdid:bdid:LEFTTRIM','bdid:bdid:ALLOW'
          ,'bdid_score:bdid_score:LEFTTRIM','bdid_score:bdid_score:ALLOW'
          ,'did:did:LEFTTRIM','did:did:ALLOW'
          ,'did_score:did_score:LEFTTRIM','did_score:did_score:ALLOW'
          ,'clean_dob:clean_dob:LEFTTRIM','clean_dob:clean_dob:ALLOW'
          ,'best_dob:best_dob:LEFTTRIM','best_dob:best_dob:ALLOW'
          ,'best_ssn:best_ssn:LEFTTRIM','best_ssn:best_ssn:ALLOW'
          ,'rec_deactivated_date:rec_deactivated_date:LEFTTRIM','rec_deactivated_date:rec_deactivated_date:ALLOW'
          ,'superceeding_piid:superceeding_piid:LEFTTRIM','superceeding_piid:superceeding_piid:ALLOW'
          ,'dotid:dotid:LEFTTRIM','dotid:dotid:ALLOW'
          ,'dotscore:dotscore:LEFTTRIM','dotscore:dotscore:ALLOW'
          ,'dotweight:dotweight:LEFTTRIM','dotweight:dotweight:ALLOW'
          ,'empid:empid:LEFTTRIM','empid:empid:ALLOW'
          ,'empscore:empscore:LEFTTRIM','empscore:empscore:ALLOW'
          ,'empweight:empweight:LEFTTRIM','empweight:empweight:ALLOW'
          ,'powid:powid:LEFTTRIM','powid:powid:ALLOW'
          ,'powscore:powscore:LEFTTRIM','powscore:powscore:ALLOW'
          ,'powweight:powweight:LEFTTRIM','powweight:powweight:ALLOW'
          ,'proxid:proxid:LEFTTRIM','proxid:proxid:ALLOW'
          ,'proxscore:proxscore:LEFTTRIM','proxscore:proxscore:ALLOW'
          ,'proxweight:proxweight:LEFTTRIM','proxweight:proxweight:ALLOW'
          ,'seleid:seleid:LEFTTRIM','seleid:seleid:ALLOW'
          ,'selescore:selescore:LEFTTRIM','selescore:selescore:ALLOW'
          ,'seleweight:seleweight:LEFTTRIM','seleweight:seleweight:ALLOW'
          ,'orgid:orgid:LEFTTRIM','orgid:orgid:ALLOW'
          ,'orgscore:orgscore:LEFTTRIM','orgscore:orgscore:ALLOW'
          ,'orgweight:orgweight:LEFTTRIM','orgweight:orgweight:ALLOW'
          ,'ultid:ultid:LEFTTRIM','ultid:ultid:ALLOW'
          ,'ultscore:ultscore:LEFTTRIM','ultscore:ultscore:ALLOW'
          ,'ultweight:ultweight:LEFTTRIM','ultweight:ultweight:ALLOW','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Individuals_Fields.InvalidMessage_hms_piid(1),Individuals_Fields.InvalidMessage_hms_piid(2)
          ,Individuals_Fields.InvalidMessage_first(1),Individuals_Fields.InvalidMessage_first(2)
          ,Individuals_Fields.InvalidMessage_middle(1),Individuals_Fields.InvalidMessage_middle(2)
          ,Individuals_Fields.InvalidMessage_last(1),Individuals_Fields.InvalidMessage_last(2)
          ,Individuals_Fields.InvalidMessage_suffix(1),Individuals_Fields.InvalidMessage_suffix(2)
          ,Individuals_Fields.InvalidMessage_cred(1),Individuals_Fields.InvalidMessage_cred(2)
          ,Individuals_Fields.InvalidMessage_practitioner_type(1),Individuals_Fields.InvalidMessage_practitioner_type(2)
          ,Individuals_Fields.InvalidMessage_active(1),Individuals_Fields.InvalidMessage_active(2)
          ,Individuals_Fields.InvalidMessage_vendible(1),Individuals_Fields.InvalidMessage_vendible(2)
          ,Individuals_Fields.InvalidMessage_npi_num(1),Individuals_Fields.InvalidMessage_npi_num(2)
          ,Individuals_Fields.InvalidMessage_npi_enumeration_date(1),Individuals_Fields.InvalidMessage_npi_enumeration_date(2)
          ,Individuals_Fields.InvalidMessage_npi_deactivation_date(1),Individuals_Fields.InvalidMessage_npi_deactivation_date(2)
          ,Individuals_Fields.InvalidMessage_npi_reactivation_date(1),Individuals_Fields.InvalidMessage_npi_reactivation_date(2)
          ,Individuals_Fields.InvalidMessage_npi_taxonomy_code(1),Individuals_Fields.InvalidMessage_npi_taxonomy_code(2)
          ,Individuals_Fields.InvalidMessage_upin(1),Individuals_Fields.InvalidMessage_upin(2)
          ,Individuals_Fields.InvalidMessage_medicare_participation_flag(1),Individuals_Fields.InvalidMessage_medicare_participation_flag(2)
          ,Individuals_Fields.InvalidMessage_date_born(1),Individuals_Fields.InvalidMessage_date_born(2)
          ,Individuals_Fields.InvalidMessage_date_died(1),Individuals_Fields.InvalidMessage_date_died(2)
          ,Individuals_Fields.InvalidMessage_pid(1),Individuals_Fields.InvalidMessage_pid(2)
          ,Individuals_Fields.InvalidMessage_src(1),Individuals_Fields.InvalidMessage_src(2)
          ,Individuals_Fields.InvalidMessage_date_vendor_first_reported(1),Individuals_Fields.InvalidMessage_date_vendor_first_reported(2)
          ,Individuals_Fields.InvalidMessage_date_vendor_last_reported(1),Individuals_Fields.InvalidMessage_date_vendor_last_reported(2)
          ,Individuals_Fields.InvalidMessage_date_first_seen(1),Individuals_Fields.InvalidMessage_date_first_seen(2)
          ,Individuals_Fields.InvalidMessage_date_last_seen(1),Individuals_Fields.InvalidMessage_date_last_seen(2)
          ,Individuals_Fields.InvalidMessage_record_type(1),Individuals_Fields.InvalidMessage_record_type(2)
          ,Individuals_Fields.InvalidMessage_source_rid(1),Individuals_Fields.InvalidMessage_source_rid(2)
          ,Individuals_Fields.InvalidMessage_lnpid(1),Individuals_Fields.InvalidMessage_lnpid(2)
          ,Individuals_Fields.InvalidMessage_fname(1),Individuals_Fields.InvalidMessage_fname(2)
          ,Individuals_Fields.InvalidMessage_mname(1),Individuals_Fields.InvalidMessage_mname(2)
          ,Individuals_Fields.InvalidMessage_lname(1),Individuals_Fields.InvalidMessage_lname(2)
          ,Individuals_Fields.InvalidMessage_name_suffix(1),Individuals_Fields.InvalidMessage_name_suffix(2)
          ,Individuals_Fields.InvalidMessage_nametype(1),Individuals_Fields.InvalidMessage_nametype(2)
          ,Individuals_Fields.InvalidMessage_nid(1),Individuals_Fields.InvalidMessage_nid(2)
          ,Individuals_Fields.InvalidMessage_clean_npi_enumeration_date(1),Individuals_Fields.InvalidMessage_clean_npi_enumeration_date(2)
          ,Individuals_Fields.InvalidMessage_clean_npi_deactivation_date(1),Individuals_Fields.InvalidMessage_clean_npi_deactivation_date(2)
          ,Individuals_Fields.InvalidMessage_clean_npi_reactivation_date(1),Individuals_Fields.InvalidMessage_clean_npi_reactivation_date(2)
          ,Individuals_Fields.InvalidMessage_clean_date_born(1),Individuals_Fields.InvalidMessage_clean_date_born(2)
          ,Individuals_Fields.InvalidMessage_clean_date_died(1),Individuals_Fields.InvalidMessage_clean_date_died(2)
          ,Individuals_Fields.InvalidMessage_clean_company_name(1),Individuals_Fields.InvalidMessage_clean_company_name(2)
          ,Individuals_Fields.InvalidMessage_prim_range(1),Individuals_Fields.InvalidMessage_prim_range(2)
          ,Individuals_Fields.InvalidMessage_predir(1),Individuals_Fields.InvalidMessage_predir(2)
          ,Individuals_Fields.InvalidMessage_prim_name(1),Individuals_Fields.InvalidMessage_prim_name(2)
          ,Individuals_Fields.InvalidMessage_addr_suffix(1),Individuals_Fields.InvalidMessage_addr_suffix(2)
          ,Individuals_Fields.InvalidMessage_postdir(1),Individuals_Fields.InvalidMessage_postdir(2)
          ,Individuals_Fields.InvalidMessage_unit_desig(1),Individuals_Fields.InvalidMessage_unit_desig(2)
          ,Individuals_Fields.InvalidMessage_sec_range(1),Individuals_Fields.InvalidMessage_sec_range(2)
          ,Individuals_Fields.InvalidMessage_p_city_name(1),Individuals_Fields.InvalidMessage_p_city_name(2)
          ,Individuals_Fields.InvalidMessage_v_city_name(1),Individuals_Fields.InvalidMessage_v_city_name(2)
          ,Individuals_Fields.InvalidMessage_st(1),Individuals_Fields.InvalidMessage_st(2)
          ,Individuals_Fields.InvalidMessage_zip(1),Individuals_Fields.InvalidMessage_zip(2)
          ,Individuals_Fields.InvalidMessage_zip4(1),Individuals_Fields.InvalidMessage_zip4(2)
          ,Individuals_Fields.InvalidMessage_cart(1),Individuals_Fields.InvalidMessage_cart(2)
          ,Individuals_Fields.InvalidMessage_cr_sort_sz(1),Individuals_Fields.InvalidMessage_cr_sort_sz(2)
          ,Individuals_Fields.InvalidMessage_lot(1),Individuals_Fields.InvalidMessage_lot(2)
          ,Individuals_Fields.InvalidMessage_lot_order(1),Individuals_Fields.InvalidMessage_lot_order(2)
          ,Individuals_Fields.InvalidMessage_dbpc(1),Individuals_Fields.InvalidMessage_dbpc(2)
          ,Individuals_Fields.InvalidMessage_chk_digit(1),Individuals_Fields.InvalidMessage_chk_digit(2)
          ,Individuals_Fields.InvalidMessage_rec_type(1),Individuals_Fields.InvalidMessage_rec_type(2)
          ,Individuals_Fields.InvalidMessage_fips_st(1),Individuals_Fields.InvalidMessage_fips_st(2)
          ,Individuals_Fields.InvalidMessage_fips_county(1),Individuals_Fields.InvalidMessage_fips_county(2)
          ,Individuals_Fields.InvalidMessage_geo_lat(1),Individuals_Fields.InvalidMessage_geo_lat(2)
          ,Individuals_Fields.InvalidMessage_geo_long(1),Individuals_Fields.InvalidMessage_geo_long(2)
          ,Individuals_Fields.InvalidMessage_msa(1),Individuals_Fields.InvalidMessage_msa(2)
          ,Individuals_Fields.InvalidMessage_geo_blk(1),Individuals_Fields.InvalidMessage_geo_blk(2)
          ,Individuals_Fields.InvalidMessage_geo_match(1),Individuals_Fields.InvalidMessage_geo_match(2)
          ,Individuals_Fields.InvalidMessage_err_stat(1),Individuals_Fields.InvalidMessage_err_stat(2)
          ,Individuals_Fields.InvalidMessage_rawaid(1),Individuals_Fields.InvalidMessage_rawaid(2)
          ,Individuals_Fields.InvalidMessage_aceaid(1),Individuals_Fields.InvalidMessage_aceaid(2)
          ,Individuals_Fields.InvalidMessage_firm_name(1),Individuals_Fields.InvalidMessage_firm_name(2)
          ,Individuals_Fields.InvalidMessage_lid(1),Individuals_Fields.InvalidMessage_lid(2)
          ,Individuals_Fields.InvalidMessage_agid(1),Individuals_Fields.InvalidMessage_agid(2)
          ,Individuals_Fields.InvalidMessage_address_std_code(1),Individuals_Fields.InvalidMessage_address_std_code(2)
          ,Individuals_Fields.InvalidMessage_latitude(1),Individuals_Fields.InvalidMessage_latitude(2)
          ,Individuals_Fields.InvalidMessage_longitude(1),Individuals_Fields.InvalidMessage_longitude(2)
          ,Individuals_Fields.InvalidMessage_prepped_addr1(1),Individuals_Fields.InvalidMessage_prepped_addr1(2)
          ,Individuals_Fields.InvalidMessage_prepped_addr2(1),Individuals_Fields.InvalidMessage_prepped_addr2(2)
          ,Individuals_Fields.InvalidMessage_addr_type(1),Individuals_Fields.InvalidMessage_addr_type(2)
          ,Individuals_Fields.InvalidMessage_state_license_state(1),Individuals_Fields.InvalidMessage_state_license_state(2)
          ,Individuals_Fields.InvalidMessage_state_license_number(1),Individuals_Fields.InvalidMessage_state_license_number(2)
          ,Individuals_Fields.InvalidMessage_state_license_type(1),Individuals_Fields.InvalidMessage_state_license_type(2)
          ,Individuals_Fields.InvalidMessage_state_license_active(1),Individuals_Fields.InvalidMessage_state_license_active(2)
          ,Individuals_Fields.InvalidMessage_state_license_expire(1),Individuals_Fields.InvalidMessage_state_license_expire(2)
          ,Individuals_Fields.InvalidMessage_state_license_qualifier(1),Individuals_Fields.InvalidMessage_state_license_qualifier(2)
          ,Individuals_Fields.InvalidMessage_state_license_sub_qualifier(1),Individuals_Fields.InvalidMessage_state_license_sub_qualifier(2)
          ,Individuals_Fields.InvalidMessage_state_license_issued(1),Individuals_Fields.InvalidMessage_state_license_issued(2)
          ,Individuals_Fields.InvalidMessage_clean_state_license_expire(1),Individuals_Fields.InvalidMessage_clean_state_license_expire(2)
          ,Individuals_Fields.InvalidMessage_clean_state_license_issued(1),Individuals_Fields.InvalidMessage_clean_state_license_issued(2)
          ,Individuals_Fields.InvalidMessage_dea_num(1),Individuals_Fields.InvalidMessage_dea_num(2)
          ,Individuals_Fields.InvalidMessage_dea_bac(1),Individuals_Fields.InvalidMessage_dea_bac(2)
          ,Individuals_Fields.InvalidMessage_dea_sub_bac(1),Individuals_Fields.InvalidMessage_dea_sub_bac(2)
          ,Individuals_Fields.InvalidMessage_dea_schedule(1),Individuals_Fields.InvalidMessage_dea_schedule(2)
          ,Individuals_Fields.InvalidMessage_dea_expire(1),Individuals_Fields.InvalidMessage_dea_expire(2)
          ,Individuals_Fields.InvalidMessage_dea_active(1),Individuals_Fields.InvalidMessage_dea_active(2)
          ,Individuals_Fields.InvalidMessage_clean_dea_expire(1),Individuals_Fields.InvalidMessage_clean_dea_expire(2)
          ,Individuals_Fields.InvalidMessage_csr_number(1),Individuals_Fields.InvalidMessage_csr_number(2)
          ,Individuals_Fields.InvalidMessage_csr_state(1),Individuals_Fields.InvalidMessage_csr_state(2)
          ,Individuals_Fields.InvalidMessage_csr_expire_date(1),Individuals_Fields.InvalidMessage_csr_expire_date(2)
          ,Individuals_Fields.InvalidMessage_csr_issue_date(1),Individuals_Fields.InvalidMessage_csr_issue_date(2)
          ,Individuals_Fields.InvalidMessage_dsa_lvl_2(1),Individuals_Fields.InvalidMessage_dsa_lvl_2(2)
          ,Individuals_Fields.InvalidMessage_dsa_lvl_2n(1),Individuals_Fields.InvalidMessage_dsa_lvl_2n(2)
          ,Individuals_Fields.InvalidMessage_dsa_lvl_3(1),Individuals_Fields.InvalidMessage_dsa_lvl_3(2)
          ,Individuals_Fields.InvalidMessage_dsa_lvl_3n(1),Individuals_Fields.InvalidMessage_dsa_lvl_3n(2)
          ,Individuals_Fields.InvalidMessage_dsa_lvl_4(1),Individuals_Fields.InvalidMessage_dsa_lvl_4(2)
          ,Individuals_Fields.InvalidMessage_dsa_lvl_5(1),Individuals_Fields.InvalidMessage_dsa_lvl_5(2)
          ,Individuals_Fields.InvalidMessage_csr_raw1(1),Individuals_Fields.InvalidMessage_csr_raw1(2)
          ,Individuals_Fields.InvalidMessage_csr_raw2(1),Individuals_Fields.InvalidMessage_csr_raw2(2)
          ,Individuals_Fields.InvalidMessage_csr_raw3(1),Individuals_Fields.InvalidMessage_csr_raw3(2)
          ,Individuals_Fields.InvalidMessage_csr_raw4(1),Individuals_Fields.InvalidMessage_csr_raw4(2)
          ,Individuals_Fields.InvalidMessage_clean_csr_expire_date(1),Individuals_Fields.InvalidMessage_clean_csr_expire_date(2)
          ,Individuals_Fields.InvalidMessage_clean_csr_issue_date(1),Individuals_Fields.InvalidMessage_clean_csr_issue_date(2)
          ,Individuals_Fields.InvalidMessage_sanction_id(1),Individuals_Fields.InvalidMessage_sanction_id(2)
          ,Individuals_Fields.InvalidMessage_sanction_action_code(1),Individuals_Fields.InvalidMessage_sanction_action_code(2)
          ,Individuals_Fields.InvalidMessage_sanction_action_description(1),Individuals_Fields.InvalidMessage_sanction_action_description(2)
          ,Individuals_Fields.InvalidMessage_sanction_board_code(1),Individuals_Fields.InvalidMessage_sanction_board_code(2)
          ,Individuals_Fields.InvalidMessage_sanction_board_description(1),Individuals_Fields.InvalidMessage_sanction_board_description(2)
          ,Individuals_Fields.InvalidMessage_action_date(1),Individuals_Fields.InvalidMessage_action_date(2)
          ,Individuals_Fields.InvalidMessage_sanction_period_start_date(1),Individuals_Fields.InvalidMessage_sanction_period_start_date(2)
          ,Individuals_Fields.InvalidMessage_sanction_period_end_date(1),Individuals_Fields.InvalidMessage_sanction_period_end_date(2)
          ,Individuals_Fields.InvalidMessage_month_duration(1),Individuals_Fields.InvalidMessage_month_duration(2)
          ,Individuals_Fields.InvalidMessage_fine_amount(1),Individuals_Fields.InvalidMessage_fine_amount(2)
          ,Individuals_Fields.InvalidMessage_offense_code(1),Individuals_Fields.InvalidMessage_offense_code(2)
          ,Individuals_Fields.InvalidMessage_offense_description(1),Individuals_Fields.InvalidMessage_offense_description(2)
          ,Individuals_Fields.InvalidMessage_offense_date(1),Individuals_Fields.InvalidMessage_offense_date(2)
          ,Individuals_Fields.InvalidMessage_clean_offense_date(1),Individuals_Fields.InvalidMessage_clean_offense_date(2)
          ,Individuals_Fields.InvalidMessage_clean_action_date(1),Individuals_Fields.InvalidMessage_clean_action_date(2)
          ,Individuals_Fields.InvalidMessage_clean_sanction_period_start_date(1),Individuals_Fields.InvalidMessage_clean_sanction_period_start_date(2)
          ,Individuals_Fields.InvalidMessage_clean_sanction_period_end_date(1),Individuals_Fields.InvalidMessage_clean_sanction_period_end_date(2)
          ,Individuals_Fields.InvalidMessage_gsa_sanction_id(1),Individuals_Fields.InvalidMessage_gsa_sanction_id(2)
          ,Individuals_Fields.InvalidMessage_gsa_first(1),Individuals_Fields.InvalidMessage_gsa_first(2)
          ,Individuals_Fields.InvalidMessage_gsa_middle(1),Individuals_Fields.InvalidMessage_gsa_middle(2)
          ,Individuals_Fields.InvalidMessage_gsa_last(1),Individuals_Fields.InvalidMessage_gsa_last(2)
          ,Individuals_Fields.InvalidMessage_gsa_suffix(1),Individuals_Fields.InvalidMessage_gsa_suffix(2)
          ,Individuals_Fields.InvalidMessage_gsa_city(1),Individuals_Fields.InvalidMessage_gsa_city(2)
          ,Individuals_Fields.InvalidMessage_gsa_state(1),Individuals_Fields.InvalidMessage_gsa_state(2)
          ,Individuals_Fields.InvalidMessage_gsa_zip(1),Individuals_Fields.InvalidMessage_gsa_zip(2)
          ,Individuals_Fields.InvalidMessage_date(1),Individuals_Fields.InvalidMessage_date(2)
          ,Individuals_Fields.InvalidMessage_agency(1),Individuals_Fields.InvalidMessage_agency(2)
          ,Individuals_Fields.InvalidMessage_confidence(1),Individuals_Fields.InvalidMessage_confidence(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_first(1),Individuals_Fields.InvalidMessage_clean_gsa_first(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_middle(1),Individuals_Fields.InvalidMessage_clean_gsa_middle(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_last(1),Individuals_Fields.InvalidMessage_clean_gsa_last(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_suffix(1),Individuals_Fields.InvalidMessage_clean_gsa_suffix(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_city(1),Individuals_Fields.InvalidMessage_clean_gsa_city(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_state(1),Individuals_Fields.InvalidMessage_clean_gsa_state(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_zip(1),Individuals_Fields.InvalidMessage_clean_gsa_zip(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_action_date(1),Individuals_Fields.InvalidMessage_clean_gsa_action_date(2)
          ,Individuals_Fields.InvalidMessage_clean_gsa_date(1),Individuals_Fields.InvalidMessage_clean_gsa_date(2)
          ,Individuals_Fields.InvalidMessage_fax(1),Individuals_Fields.InvalidMessage_fax(2)
          ,Individuals_Fields.InvalidMessage_phone(1),Individuals_Fields.InvalidMessage_phone(2)
          ,Individuals_Fields.InvalidMessage_certification_code(1),Individuals_Fields.InvalidMessage_certification_code(2)
          ,Individuals_Fields.InvalidMessage_certification_description(1),Individuals_Fields.InvalidMessage_certification_description(2)
          ,Individuals_Fields.InvalidMessage_board_code(1),Individuals_Fields.InvalidMessage_board_code(2)
          ,Individuals_Fields.InvalidMessage_board_description(1),Individuals_Fields.InvalidMessage_board_description(2)
          ,Individuals_Fields.InvalidMessage_expiration_year(1),Individuals_Fields.InvalidMessage_expiration_year(2)
          ,Individuals_Fields.InvalidMessage_issue_year(1),Individuals_Fields.InvalidMessage_issue_year(2)
          ,Individuals_Fields.InvalidMessage_renewal_year(1),Individuals_Fields.InvalidMessage_renewal_year(2)
          ,Individuals_Fields.InvalidMessage_lifetime_flag(1),Individuals_Fields.InvalidMessage_lifetime_flag(2)
          ,Individuals_Fields.InvalidMessage_covered_recipient_id(1),Individuals_Fields.InvalidMessage_covered_recipient_id(2)
          ,Individuals_Fields.InvalidMessage_cov_rcp_raw_state_code(1),Individuals_Fields.InvalidMessage_cov_rcp_raw_state_code(2)
          ,Individuals_Fields.InvalidMessage_cov_rcp_raw_full_name(1),Individuals_Fields.InvalidMessage_cov_rcp_raw_full_name(2)
          ,Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute1(1),Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute1(2)
          ,Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute2(1),Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute2(2)
          ,Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute3(1),Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute3(2)
          ,Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute4(1),Individuals_Fields.InvalidMessage_cov_rcp_raw_attribute4(2)
          ,Individuals_Fields.InvalidMessage_hms_scid(1),Individuals_Fields.InvalidMessage_hms_scid(2)
          ,Individuals_Fields.InvalidMessage_school_name(1),Individuals_Fields.InvalidMessage_school_name(2)
          ,Individuals_Fields.InvalidMessage_grad_year(1),Individuals_Fields.InvalidMessage_grad_year(2)
          ,Individuals_Fields.InvalidMessage_lang_code(1),Individuals_Fields.InvalidMessage_lang_code(2)
          ,Individuals_Fields.InvalidMessage_language(1),Individuals_Fields.InvalidMessage_language(2)
          ,Individuals_Fields.InvalidMessage_specialty_description(1),Individuals_Fields.InvalidMessage_specialty_description(2)
          ,Individuals_Fields.InvalidMessage_clean_phone(1),Individuals_Fields.InvalidMessage_clean_phone(2)
          ,Individuals_Fields.InvalidMessage_bdid(1),Individuals_Fields.InvalidMessage_bdid(2)
          ,Individuals_Fields.InvalidMessage_bdid_score(1),Individuals_Fields.InvalidMessage_bdid_score(2)
          ,Individuals_Fields.InvalidMessage_did(1),Individuals_Fields.InvalidMessage_did(2)
          ,Individuals_Fields.InvalidMessage_did_score(1),Individuals_Fields.InvalidMessage_did_score(2)
          ,Individuals_Fields.InvalidMessage_clean_dob(1),Individuals_Fields.InvalidMessage_clean_dob(2)
          ,Individuals_Fields.InvalidMessage_best_dob(1),Individuals_Fields.InvalidMessage_best_dob(2)
          ,Individuals_Fields.InvalidMessage_best_ssn(1),Individuals_Fields.InvalidMessage_best_ssn(2)
          ,Individuals_Fields.InvalidMessage_rec_deactivated_date(1),Individuals_Fields.InvalidMessage_rec_deactivated_date(2)
          ,Individuals_Fields.InvalidMessage_superceeding_piid(1),Individuals_Fields.InvalidMessage_superceeding_piid(2)
          ,Individuals_Fields.InvalidMessage_dotid(1),Individuals_Fields.InvalidMessage_dotid(2)
          ,Individuals_Fields.InvalidMessage_dotscore(1),Individuals_Fields.InvalidMessage_dotscore(2)
          ,Individuals_Fields.InvalidMessage_dotweight(1),Individuals_Fields.InvalidMessage_dotweight(2)
          ,Individuals_Fields.InvalidMessage_empid(1),Individuals_Fields.InvalidMessage_empid(2)
          ,Individuals_Fields.InvalidMessage_empscore(1),Individuals_Fields.InvalidMessage_empscore(2)
          ,Individuals_Fields.InvalidMessage_empweight(1),Individuals_Fields.InvalidMessage_empweight(2)
          ,Individuals_Fields.InvalidMessage_powid(1),Individuals_Fields.InvalidMessage_powid(2)
          ,Individuals_Fields.InvalidMessage_powscore(1),Individuals_Fields.InvalidMessage_powscore(2)
          ,Individuals_Fields.InvalidMessage_powweight(1),Individuals_Fields.InvalidMessage_powweight(2)
          ,Individuals_Fields.InvalidMessage_proxid(1),Individuals_Fields.InvalidMessage_proxid(2)
          ,Individuals_Fields.InvalidMessage_proxscore(1),Individuals_Fields.InvalidMessage_proxscore(2)
          ,Individuals_Fields.InvalidMessage_proxweight(1),Individuals_Fields.InvalidMessage_proxweight(2)
          ,Individuals_Fields.InvalidMessage_seleid(1),Individuals_Fields.InvalidMessage_seleid(2)
          ,Individuals_Fields.InvalidMessage_selescore(1),Individuals_Fields.InvalidMessage_selescore(2)
          ,Individuals_Fields.InvalidMessage_seleweight(1),Individuals_Fields.InvalidMessage_seleweight(2)
          ,Individuals_Fields.InvalidMessage_orgid(1),Individuals_Fields.InvalidMessage_orgid(2)
          ,Individuals_Fields.InvalidMessage_orgscore(1),Individuals_Fields.InvalidMessage_orgscore(2)
          ,Individuals_Fields.InvalidMessage_orgweight(1),Individuals_Fields.InvalidMessage_orgweight(2)
          ,Individuals_Fields.InvalidMessage_ultid(1),Individuals_Fields.InvalidMessage_ultid(2)
          ,Individuals_Fields.InvalidMessage_ultscore(1),Individuals_Fields.InvalidMessage_ultscore(2)
          ,Individuals_Fields.InvalidMessage_ultweight(1),Individuals_Fields.InvalidMessage_ultweight(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.hms_piid_LEFTTRIM_ErrorCount,le.hms_piid_ALLOW_ErrorCount
          ,le.first_LEFTTRIM_ErrorCount,le.first_ALLOW_ErrorCount
          ,le.middle_LEFTTRIM_ErrorCount,le.middle_ALLOW_ErrorCount
          ,le.last_LEFTTRIM_ErrorCount,le.last_ALLOW_ErrorCount
          ,le.suffix_LEFTTRIM_ErrorCount,le.suffix_ALLOW_ErrorCount
          ,le.cred_LEFTTRIM_ErrorCount,le.cred_ALLOW_ErrorCount
          ,le.practitioner_type_LEFTTRIM_ErrorCount,le.practitioner_type_ALLOW_ErrorCount
          ,le.active_LEFTTRIM_ErrorCount,le.active_ALLOW_ErrorCount
          ,le.vendible_LEFTTRIM_ErrorCount,le.vendible_ALLOW_ErrorCount
          ,le.npi_num_LEFTTRIM_ErrorCount,le.npi_num_ALLOW_ErrorCount
          ,le.npi_enumeration_date_LEFTTRIM_ErrorCount,le.npi_enumeration_date_ALLOW_ErrorCount
          ,le.npi_deactivation_date_LEFTTRIM_ErrorCount,le.npi_deactivation_date_ALLOW_ErrorCount
          ,le.npi_reactivation_date_LEFTTRIM_ErrorCount,le.npi_reactivation_date_ALLOW_ErrorCount
          ,le.npi_taxonomy_code_LEFTTRIM_ErrorCount,le.npi_taxonomy_code_ALLOW_ErrorCount
          ,le.upin_LEFTTRIM_ErrorCount,le.upin_ALLOW_ErrorCount
          ,le.medicare_participation_flag_LEFTTRIM_ErrorCount,le.medicare_participation_flag_ALLOW_ErrorCount
          ,le.date_born_LEFTTRIM_ErrorCount,le.date_born_ALLOW_ErrorCount
          ,le.date_died_LEFTTRIM_ErrorCount,le.date_died_ALLOW_ErrorCount
          ,le.pid_LEFTTRIM_ErrorCount,le.pid_ALLOW_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount
          ,le.date_vendor_first_reported_LEFTTRIM_ErrorCount,le.date_vendor_first_reported_ALLOW_ErrorCount
          ,le.date_vendor_last_reported_LEFTTRIM_ErrorCount,le.date_vendor_last_reported_ALLOW_ErrorCount
          ,le.date_first_seen_LEFTTRIM_ErrorCount,le.date_first_seen_ALLOW_ErrorCount
          ,le.date_last_seen_LEFTTRIM_ErrorCount,le.date_last_seen_ALLOW_ErrorCount
          ,le.record_type_LEFTTRIM_ErrorCount,le.record_type_ALLOW_ErrorCount
          ,le.source_rid_LEFTTRIM_ErrorCount,le.source_rid_ALLOW_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount
          ,le.nametype_LEFTTRIM_ErrorCount,le.nametype_ALLOW_ErrorCount
          ,le.nid_LEFTTRIM_ErrorCount,le.nid_ALLOW_ErrorCount
          ,le.clean_npi_enumeration_date_LEFTTRIM_ErrorCount,le.clean_npi_enumeration_date_ALLOW_ErrorCount
          ,le.clean_npi_deactivation_date_LEFTTRIM_ErrorCount,le.clean_npi_deactivation_date_ALLOW_ErrorCount
          ,le.clean_npi_reactivation_date_LEFTTRIM_ErrorCount,le.clean_npi_reactivation_date_ALLOW_ErrorCount
          ,le.clean_date_born_LEFTTRIM_ErrorCount,le.clean_date_born_ALLOW_ErrorCount
          ,le.clean_date_died_LEFTTRIM_ErrorCount,le.clean_date_died_ALLOW_ErrorCount
          ,le.clean_company_name_LEFTTRIM_ErrorCount,le.clean_company_name_ALLOW_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount
          ,le.fips_st_LEFTTRIM_ErrorCount,le.fips_st_ALLOW_ErrorCount
          ,le.fips_county_LEFTTRIM_ErrorCount,le.fips_county_ALLOW_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount
          ,le.rawaid_LEFTTRIM_ErrorCount,le.rawaid_ALLOW_ErrorCount
          ,le.aceaid_LEFTTRIM_ErrorCount,le.aceaid_ALLOW_ErrorCount
          ,le.firm_name_LEFTTRIM_ErrorCount,le.firm_name_ALLOW_ErrorCount
          ,le.lid_LEFTTRIM_ErrorCount,le.lid_ALLOW_ErrorCount
          ,le.agid_LEFTTRIM_ErrorCount,le.agid_ALLOW_ErrorCount
          ,le.address_std_code_LEFTTRIM_ErrorCount,le.address_std_code_ALLOW_ErrorCount
          ,le.latitude_LEFTTRIM_ErrorCount,le.latitude_ALLOW_ErrorCount
          ,le.longitude_LEFTTRIM_ErrorCount,le.longitude_ALLOW_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount
          ,le.addr_type_LEFTTRIM_ErrorCount,le.addr_type_ALLOW_ErrorCount
          ,le.state_license_state_LEFTTRIM_ErrorCount,le.state_license_state_ALLOW_ErrorCount
          ,le.state_license_number_LEFTTRIM_ErrorCount,le.state_license_number_ALLOW_ErrorCount
          ,le.state_license_type_LEFTTRIM_ErrorCount,le.state_license_type_ALLOW_ErrorCount
          ,le.state_license_active_LEFTTRIM_ErrorCount,le.state_license_active_ALLOW_ErrorCount
          ,le.state_license_expire_LEFTTRIM_ErrorCount,le.state_license_expire_ALLOW_ErrorCount
          ,le.state_license_qualifier_LEFTTRIM_ErrorCount,le.state_license_qualifier_ALLOW_ErrorCount
          ,le.state_license_sub_qualifier_LEFTTRIM_ErrorCount,le.state_license_sub_qualifier_ALLOW_ErrorCount
          ,le.state_license_issued_LEFTTRIM_ErrorCount,le.state_license_issued_ALLOW_ErrorCount
          ,le.clean_state_license_expire_LEFTTRIM_ErrorCount,le.clean_state_license_expire_ALLOW_ErrorCount
          ,le.clean_state_license_issued_LEFTTRIM_ErrorCount,le.clean_state_license_issued_ALLOW_ErrorCount
          ,le.dea_num_LEFTTRIM_ErrorCount,le.dea_num_ALLOW_ErrorCount
          ,le.dea_bac_LEFTTRIM_ErrorCount,le.dea_bac_ALLOW_ErrorCount
          ,le.dea_sub_bac_LEFTTRIM_ErrorCount,le.dea_sub_bac_ALLOW_ErrorCount
          ,le.dea_schedule_LEFTTRIM_ErrorCount,le.dea_schedule_ALLOW_ErrorCount
          ,le.dea_expire_LEFTTRIM_ErrorCount,le.dea_expire_ALLOW_ErrorCount
          ,le.dea_active_LEFTTRIM_ErrorCount,le.dea_active_ALLOW_ErrorCount
          ,le.clean_dea_expire_LEFTTRIM_ErrorCount,le.clean_dea_expire_ALLOW_ErrorCount
          ,le.csr_number_LEFTTRIM_ErrorCount,le.csr_number_ALLOW_ErrorCount
          ,le.csr_state_LEFTTRIM_ErrorCount,le.csr_state_ALLOW_ErrorCount
          ,le.csr_expire_date_LEFTTRIM_ErrorCount,le.csr_expire_date_ALLOW_ErrorCount
          ,le.csr_issue_date_LEFTTRIM_ErrorCount,le.csr_issue_date_ALLOW_ErrorCount
          ,le.dsa_lvl_2_LEFTTRIM_ErrorCount,le.dsa_lvl_2_ALLOW_ErrorCount
          ,le.dsa_lvl_2n_LEFTTRIM_ErrorCount,le.dsa_lvl_2n_ALLOW_ErrorCount
          ,le.dsa_lvl_3_LEFTTRIM_ErrorCount,le.dsa_lvl_3_ALLOW_ErrorCount
          ,le.dsa_lvl_3n_LEFTTRIM_ErrorCount,le.dsa_lvl_3n_ALLOW_ErrorCount
          ,le.dsa_lvl_4_LEFTTRIM_ErrorCount,le.dsa_lvl_4_ALLOW_ErrorCount
          ,le.dsa_lvl_5_LEFTTRIM_ErrorCount,le.dsa_lvl_5_ALLOW_ErrorCount
          ,le.csr_raw1_LEFTTRIM_ErrorCount,le.csr_raw1_ALLOW_ErrorCount
          ,le.csr_raw2_LEFTTRIM_ErrorCount,le.csr_raw2_ALLOW_ErrorCount
          ,le.csr_raw3_LEFTTRIM_ErrorCount,le.csr_raw3_ALLOW_ErrorCount
          ,le.csr_raw4_LEFTTRIM_ErrorCount,le.csr_raw4_ALLOW_ErrorCount
          ,le.clean_csr_expire_date_LEFTTRIM_ErrorCount,le.clean_csr_expire_date_ALLOW_ErrorCount
          ,le.clean_csr_issue_date_LEFTTRIM_ErrorCount,le.clean_csr_issue_date_ALLOW_ErrorCount
          ,le.sanction_id_LEFTTRIM_ErrorCount,le.sanction_id_ALLOW_ErrorCount
          ,le.sanction_action_code_LEFTTRIM_ErrorCount,le.sanction_action_code_ALLOW_ErrorCount
          ,le.sanction_action_description_LEFTTRIM_ErrorCount,le.sanction_action_description_ALLOW_ErrorCount
          ,le.sanction_board_code_LEFTTRIM_ErrorCount,le.sanction_board_code_ALLOW_ErrorCount
          ,le.sanction_board_description_LEFTTRIM_ErrorCount,le.sanction_board_description_ALLOW_ErrorCount
          ,le.action_date_LEFTTRIM_ErrorCount,le.action_date_ALLOW_ErrorCount
          ,le.sanction_period_start_date_LEFTTRIM_ErrorCount,le.sanction_period_start_date_ALLOW_ErrorCount
          ,le.sanction_period_end_date_LEFTTRIM_ErrorCount,le.sanction_period_end_date_ALLOW_ErrorCount
          ,le.month_duration_LEFTTRIM_ErrorCount,le.month_duration_ALLOW_ErrorCount
          ,le.fine_amount_LEFTTRIM_ErrorCount,le.fine_amount_ALLOW_ErrorCount
          ,le.offense_code_LEFTTRIM_ErrorCount,le.offense_code_ALLOW_ErrorCount
          ,le.offense_description_LEFTTRIM_ErrorCount,le.offense_description_ALLOW_ErrorCount
          ,le.offense_date_LEFTTRIM_ErrorCount,le.offense_date_ALLOW_ErrorCount
          ,le.clean_offense_date_LEFTTRIM_ErrorCount,le.clean_offense_date_ALLOW_ErrorCount
          ,le.clean_action_date_LEFTTRIM_ErrorCount,le.clean_action_date_ALLOW_ErrorCount
          ,le.clean_sanction_period_start_date_LEFTTRIM_ErrorCount,le.clean_sanction_period_start_date_ALLOW_ErrorCount
          ,le.clean_sanction_period_end_date_LEFTTRIM_ErrorCount,le.clean_sanction_period_end_date_ALLOW_ErrorCount
          ,le.gsa_sanction_id_LEFTTRIM_ErrorCount,le.gsa_sanction_id_ALLOW_ErrorCount
          ,le.gsa_first_LEFTTRIM_ErrorCount,le.gsa_first_ALLOW_ErrorCount
          ,le.gsa_middle_LEFTTRIM_ErrorCount,le.gsa_middle_ALLOW_ErrorCount
          ,le.gsa_last_LEFTTRIM_ErrorCount,le.gsa_last_ALLOW_ErrorCount
          ,le.gsa_suffix_LEFTTRIM_ErrorCount,le.gsa_suffix_ALLOW_ErrorCount
          ,le.gsa_city_LEFTTRIM_ErrorCount,le.gsa_city_ALLOW_ErrorCount
          ,le.gsa_state_LEFTTRIM_ErrorCount,le.gsa_state_ALLOW_ErrorCount
          ,le.gsa_zip_LEFTTRIM_ErrorCount,le.gsa_zip_ALLOW_ErrorCount
          ,le.date_LEFTTRIM_ErrorCount,le.date_ALLOW_ErrorCount
          ,le.agency_LEFTTRIM_ErrorCount,le.agency_ALLOW_ErrorCount
          ,le.confidence_LEFTTRIM_ErrorCount,le.confidence_ALLOW_ErrorCount
          ,le.clean_gsa_first_LEFTTRIM_ErrorCount,le.clean_gsa_first_ALLOW_ErrorCount
          ,le.clean_gsa_middle_LEFTTRIM_ErrorCount,le.clean_gsa_middle_ALLOW_ErrorCount
          ,le.clean_gsa_last_LEFTTRIM_ErrorCount,le.clean_gsa_last_ALLOW_ErrorCount
          ,le.clean_gsa_suffix_LEFTTRIM_ErrorCount,le.clean_gsa_suffix_ALLOW_ErrorCount
          ,le.clean_gsa_city_LEFTTRIM_ErrorCount,le.clean_gsa_city_ALLOW_ErrorCount
          ,le.clean_gsa_state_LEFTTRIM_ErrorCount,le.clean_gsa_state_ALLOW_ErrorCount
          ,le.clean_gsa_zip_LEFTTRIM_ErrorCount,le.clean_gsa_zip_ALLOW_ErrorCount
          ,le.clean_gsa_action_date_LEFTTRIM_ErrorCount,le.clean_gsa_action_date_ALLOW_ErrorCount
          ,le.clean_gsa_date_LEFTTRIM_ErrorCount,le.clean_gsa_date_ALLOW_ErrorCount
          ,le.fax_LEFTTRIM_ErrorCount,le.fax_ALLOW_ErrorCount
          ,le.phone_LEFTTRIM_ErrorCount,le.phone_ALLOW_ErrorCount
          ,le.certification_code_LEFTTRIM_ErrorCount,le.certification_code_ALLOW_ErrorCount
          ,le.certification_description_LEFTTRIM_ErrorCount,le.certification_description_ALLOW_ErrorCount
          ,le.board_code_LEFTTRIM_ErrorCount,le.board_code_ALLOW_ErrorCount
          ,le.board_description_LEFTTRIM_ErrorCount,le.board_description_ALLOW_ErrorCount
          ,le.expiration_year_LEFTTRIM_ErrorCount,le.expiration_year_ALLOW_ErrorCount
          ,le.issue_year_LEFTTRIM_ErrorCount,le.issue_year_ALLOW_ErrorCount
          ,le.renewal_year_LEFTTRIM_ErrorCount,le.renewal_year_ALLOW_ErrorCount
          ,le.lifetime_flag_LEFTTRIM_ErrorCount,le.lifetime_flag_ALLOW_ErrorCount
          ,le.covered_recipient_id_LEFTTRIM_ErrorCount,le.covered_recipient_id_ALLOW_ErrorCount
          ,le.cov_rcp_raw_state_code_LEFTTRIM_ErrorCount,le.cov_rcp_raw_state_code_ALLOW_ErrorCount
          ,le.cov_rcp_raw_full_name_LEFTTRIM_ErrorCount,le.cov_rcp_raw_full_name_ALLOW_ErrorCount
          ,le.cov_rcp_raw_attribute1_LEFTTRIM_ErrorCount,le.cov_rcp_raw_attribute1_ALLOW_ErrorCount
          ,le.cov_rcp_raw_attribute2_LEFTTRIM_ErrorCount,le.cov_rcp_raw_attribute2_ALLOW_ErrorCount
          ,le.cov_rcp_raw_attribute3_LEFTTRIM_ErrorCount,le.cov_rcp_raw_attribute3_ALLOW_ErrorCount
          ,le.cov_rcp_raw_attribute4_LEFTTRIM_ErrorCount,le.cov_rcp_raw_attribute4_ALLOW_ErrorCount
          ,le.hms_scid_LEFTTRIM_ErrorCount,le.hms_scid_ALLOW_ErrorCount
          ,le.school_name_LEFTTRIM_ErrorCount,le.school_name_ALLOW_ErrorCount
          ,le.grad_year_LEFTTRIM_ErrorCount,le.grad_year_ALLOW_ErrorCount
          ,le.lang_code_LEFTTRIM_ErrorCount,le.lang_code_ALLOW_ErrorCount
          ,le.language_LEFTTRIM_ErrorCount,le.language_ALLOW_ErrorCount
          ,le.specialty_description_LEFTTRIM_ErrorCount,le.specialty_description_ALLOW_ErrorCount
          ,le.clean_phone_LEFTTRIM_ErrorCount,le.clean_phone_ALLOW_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount
          ,le.clean_dob_LEFTTRIM_ErrorCount,le.clean_dob_ALLOW_ErrorCount
          ,le.best_dob_LEFTTRIM_ErrorCount,le.best_dob_ALLOW_ErrorCount
          ,le.best_ssn_LEFTTRIM_ErrorCount,le.best_ssn_ALLOW_ErrorCount
          ,le.rec_deactivated_date_LEFTTRIM_ErrorCount,le.rec_deactivated_date_ALLOW_ErrorCount
          ,le.superceeding_piid_LEFTTRIM_ErrorCount,le.superceeding_piid_ALLOW_ErrorCount
          ,le.dotid_LEFTTRIM_ErrorCount,le.dotid_ALLOW_ErrorCount
          ,le.dotscore_LEFTTRIM_ErrorCount,le.dotscore_ALLOW_ErrorCount
          ,le.dotweight_LEFTTRIM_ErrorCount,le.dotweight_ALLOW_ErrorCount
          ,le.empid_LEFTTRIM_ErrorCount,le.empid_ALLOW_ErrorCount
          ,le.empscore_LEFTTRIM_ErrorCount,le.empscore_ALLOW_ErrorCount
          ,le.empweight_LEFTTRIM_ErrorCount,le.empweight_ALLOW_ErrorCount
          ,le.powid_LEFTTRIM_ErrorCount,le.powid_ALLOW_ErrorCount
          ,le.powscore_LEFTTRIM_ErrorCount,le.powscore_ALLOW_ErrorCount
          ,le.powweight_LEFTTRIM_ErrorCount,le.powweight_ALLOW_ErrorCount
          ,le.proxid_LEFTTRIM_ErrorCount,le.proxid_ALLOW_ErrorCount
          ,le.proxscore_LEFTTRIM_ErrorCount,le.proxscore_ALLOW_ErrorCount
          ,le.proxweight_LEFTTRIM_ErrorCount,le.proxweight_ALLOW_ErrorCount
          ,le.seleid_LEFTTRIM_ErrorCount,le.seleid_ALLOW_ErrorCount
          ,le.selescore_LEFTTRIM_ErrorCount,le.selescore_ALLOW_ErrorCount
          ,le.seleweight_LEFTTRIM_ErrorCount,le.seleweight_ALLOW_ErrorCount
          ,le.orgid_LEFTTRIM_ErrorCount,le.orgid_ALLOW_ErrorCount
          ,le.orgscore_LEFTTRIM_ErrorCount,le.orgscore_ALLOW_ErrorCount
          ,le.orgweight_LEFTTRIM_ErrorCount,le.orgweight_ALLOW_ErrorCount
          ,le.ultid_LEFTTRIM_ErrorCount,le.ultid_ALLOW_ErrorCount
          ,le.ultscore_LEFTTRIM_ErrorCount,le.ultscore_ALLOW_ErrorCount
          ,le.ultweight_LEFTTRIM_ErrorCount,le.ultweight_ALLOW_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.hms_piid_LEFTTRIM_ErrorCount,le.hms_piid_ALLOW_ErrorCount
          ,le.first_LEFTTRIM_ErrorCount,le.first_ALLOW_ErrorCount
          ,le.middle_LEFTTRIM_ErrorCount,le.middle_ALLOW_ErrorCount
          ,le.last_LEFTTRIM_ErrorCount,le.last_ALLOW_ErrorCount
          ,le.suffix_LEFTTRIM_ErrorCount,le.suffix_ALLOW_ErrorCount
          ,le.cred_LEFTTRIM_ErrorCount,le.cred_ALLOW_ErrorCount
          ,le.practitioner_type_LEFTTRIM_ErrorCount,le.practitioner_type_ALLOW_ErrorCount
          ,le.active_LEFTTRIM_ErrorCount,le.active_ALLOW_ErrorCount
          ,le.vendible_LEFTTRIM_ErrorCount,le.vendible_ALLOW_ErrorCount
          ,le.npi_num_LEFTTRIM_ErrorCount,le.npi_num_ALLOW_ErrorCount
          ,le.npi_enumeration_date_LEFTTRIM_ErrorCount,le.npi_enumeration_date_ALLOW_ErrorCount
          ,le.npi_deactivation_date_LEFTTRIM_ErrorCount,le.npi_deactivation_date_ALLOW_ErrorCount
          ,le.npi_reactivation_date_LEFTTRIM_ErrorCount,le.npi_reactivation_date_ALLOW_ErrorCount
          ,le.npi_taxonomy_code_LEFTTRIM_ErrorCount,le.npi_taxonomy_code_ALLOW_ErrorCount
          ,le.upin_LEFTTRIM_ErrorCount,le.upin_ALLOW_ErrorCount
          ,le.medicare_participation_flag_LEFTTRIM_ErrorCount,le.medicare_participation_flag_ALLOW_ErrorCount
          ,le.date_born_LEFTTRIM_ErrorCount,le.date_born_ALLOW_ErrorCount
          ,le.date_died_LEFTTRIM_ErrorCount,le.date_died_ALLOW_ErrorCount
          ,le.pid_LEFTTRIM_ErrorCount,le.pid_ALLOW_ErrorCount
          ,le.src_LEFTTRIM_ErrorCount,le.src_ALLOW_ErrorCount
          ,le.date_vendor_first_reported_LEFTTRIM_ErrorCount,le.date_vendor_first_reported_ALLOW_ErrorCount
          ,le.date_vendor_last_reported_LEFTTRIM_ErrorCount,le.date_vendor_last_reported_ALLOW_ErrorCount
          ,le.date_first_seen_LEFTTRIM_ErrorCount,le.date_first_seen_ALLOW_ErrorCount
          ,le.date_last_seen_LEFTTRIM_ErrorCount,le.date_last_seen_ALLOW_ErrorCount
          ,le.record_type_LEFTTRIM_ErrorCount,le.record_type_ALLOW_ErrorCount
          ,le.source_rid_LEFTTRIM_ErrorCount,le.source_rid_ALLOW_ErrorCount
          ,le.lnpid_LEFTTRIM_ErrorCount,le.lnpid_ALLOW_ErrorCount
          ,le.fname_LEFTTRIM_ErrorCount,le.fname_ALLOW_ErrorCount
          ,le.mname_LEFTTRIM_ErrorCount,le.mname_ALLOW_ErrorCount
          ,le.lname_LEFTTRIM_ErrorCount,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_LEFTTRIM_ErrorCount,le.name_suffix_ALLOW_ErrorCount
          ,le.nametype_LEFTTRIM_ErrorCount,le.nametype_ALLOW_ErrorCount
          ,le.nid_LEFTTRIM_ErrorCount,le.nid_ALLOW_ErrorCount
          ,le.clean_npi_enumeration_date_LEFTTRIM_ErrorCount,le.clean_npi_enumeration_date_ALLOW_ErrorCount
          ,le.clean_npi_deactivation_date_LEFTTRIM_ErrorCount,le.clean_npi_deactivation_date_ALLOW_ErrorCount
          ,le.clean_npi_reactivation_date_LEFTTRIM_ErrorCount,le.clean_npi_reactivation_date_ALLOW_ErrorCount
          ,le.clean_date_born_LEFTTRIM_ErrorCount,le.clean_date_born_ALLOW_ErrorCount
          ,le.clean_date_died_LEFTTRIM_ErrorCount,le.clean_date_died_ALLOW_ErrorCount
          ,le.clean_company_name_LEFTTRIM_ErrorCount,le.clean_company_name_ALLOW_ErrorCount
          ,le.prim_range_LEFTTRIM_ErrorCount,le.prim_range_ALLOW_ErrorCount
          ,le.predir_LEFTTRIM_ErrorCount,le.predir_ALLOW_ErrorCount
          ,le.prim_name_LEFTTRIM_ErrorCount,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_LEFTTRIM_ErrorCount,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_LEFTTRIM_ErrorCount,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_LEFTTRIM_ErrorCount,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_LEFTTRIM_ErrorCount,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_LEFTTRIM_ErrorCount,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_LEFTTRIM_ErrorCount,le.v_city_name_ALLOW_ErrorCount
          ,le.st_LEFTTRIM_ErrorCount,le.st_ALLOW_ErrorCount
          ,le.zip_LEFTTRIM_ErrorCount,le.zip_ALLOW_ErrorCount
          ,le.zip4_LEFTTRIM_ErrorCount,le.zip4_ALLOW_ErrorCount
          ,le.cart_LEFTTRIM_ErrorCount,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_LEFTTRIM_ErrorCount,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_LEFTTRIM_ErrorCount,le.lot_ALLOW_ErrorCount
          ,le.lot_order_LEFTTRIM_ErrorCount,le.lot_order_ALLOW_ErrorCount
          ,le.dbpc_LEFTTRIM_ErrorCount,le.dbpc_ALLOW_ErrorCount
          ,le.chk_digit_LEFTTRIM_ErrorCount,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_LEFTTRIM_ErrorCount,le.rec_type_ALLOW_ErrorCount
          ,le.fips_st_LEFTTRIM_ErrorCount,le.fips_st_ALLOW_ErrorCount
          ,le.fips_county_LEFTTRIM_ErrorCount,le.fips_county_ALLOW_ErrorCount
          ,le.geo_lat_LEFTTRIM_ErrorCount,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_LEFTTRIM_ErrorCount,le.geo_long_ALLOW_ErrorCount
          ,le.msa_LEFTTRIM_ErrorCount,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_LEFTTRIM_ErrorCount,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_LEFTTRIM_ErrorCount,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_LEFTTRIM_ErrorCount,le.err_stat_ALLOW_ErrorCount
          ,le.rawaid_LEFTTRIM_ErrorCount,le.rawaid_ALLOW_ErrorCount
          ,le.aceaid_LEFTTRIM_ErrorCount,le.aceaid_ALLOW_ErrorCount
          ,le.firm_name_LEFTTRIM_ErrorCount,le.firm_name_ALLOW_ErrorCount
          ,le.lid_LEFTTRIM_ErrorCount,le.lid_ALLOW_ErrorCount
          ,le.agid_LEFTTRIM_ErrorCount,le.agid_ALLOW_ErrorCount
          ,le.address_std_code_LEFTTRIM_ErrorCount,le.address_std_code_ALLOW_ErrorCount
          ,le.latitude_LEFTTRIM_ErrorCount,le.latitude_ALLOW_ErrorCount
          ,le.longitude_LEFTTRIM_ErrorCount,le.longitude_ALLOW_ErrorCount
          ,le.prepped_addr1_LEFTTRIM_ErrorCount,le.prepped_addr1_ALLOW_ErrorCount
          ,le.prepped_addr2_LEFTTRIM_ErrorCount,le.prepped_addr2_ALLOW_ErrorCount
          ,le.addr_type_LEFTTRIM_ErrorCount,le.addr_type_ALLOW_ErrorCount
          ,le.state_license_state_LEFTTRIM_ErrorCount,le.state_license_state_ALLOW_ErrorCount
          ,le.state_license_number_LEFTTRIM_ErrorCount,le.state_license_number_ALLOW_ErrorCount
          ,le.state_license_type_LEFTTRIM_ErrorCount,le.state_license_type_ALLOW_ErrorCount
          ,le.state_license_active_LEFTTRIM_ErrorCount,le.state_license_active_ALLOW_ErrorCount
          ,le.state_license_expire_LEFTTRIM_ErrorCount,le.state_license_expire_ALLOW_ErrorCount
          ,le.state_license_qualifier_LEFTTRIM_ErrorCount,le.state_license_qualifier_ALLOW_ErrorCount
          ,le.state_license_sub_qualifier_LEFTTRIM_ErrorCount,le.state_license_sub_qualifier_ALLOW_ErrorCount
          ,le.state_license_issued_LEFTTRIM_ErrorCount,le.state_license_issued_ALLOW_ErrorCount
          ,le.clean_state_license_expire_LEFTTRIM_ErrorCount,le.clean_state_license_expire_ALLOW_ErrorCount
          ,le.clean_state_license_issued_LEFTTRIM_ErrorCount,le.clean_state_license_issued_ALLOW_ErrorCount
          ,le.dea_num_LEFTTRIM_ErrorCount,le.dea_num_ALLOW_ErrorCount
          ,le.dea_bac_LEFTTRIM_ErrorCount,le.dea_bac_ALLOW_ErrorCount
          ,le.dea_sub_bac_LEFTTRIM_ErrorCount,le.dea_sub_bac_ALLOW_ErrorCount
          ,le.dea_schedule_LEFTTRIM_ErrorCount,le.dea_schedule_ALLOW_ErrorCount
          ,le.dea_expire_LEFTTRIM_ErrorCount,le.dea_expire_ALLOW_ErrorCount
          ,le.dea_active_LEFTTRIM_ErrorCount,le.dea_active_ALLOW_ErrorCount
          ,le.clean_dea_expire_LEFTTRIM_ErrorCount,le.clean_dea_expire_ALLOW_ErrorCount
          ,le.csr_number_LEFTTRIM_ErrorCount,le.csr_number_ALLOW_ErrorCount
          ,le.csr_state_LEFTTRIM_ErrorCount,le.csr_state_ALLOW_ErrorCount
          ,le.csr_expire_date_LEFTTRIM_ErrorCount,le.csr_expire_date_ALLOW_ErrorCount
          ,le.csr_issue_date_LEFTTRIM_ErrorCount,le.csr_issue_date_ALLOW_ErrorCount
          ,le.dsa_lvl_2_LEFTTRIM_ErrorCount,le.dsa_lvl_2_ALLOW_ErrorCount
          ,le.dsa_lvl_2n_LEFTTRIM_ErrorCount,le.dsa_lvl_2n_ALLOW_ErrorCount
          ,le.dsa_lvl_3_LEFTTRIM_ErrorCount,le.dsa_lvl_3_ALLOW_ErrorCount
          ,le.dsa_lvl_3n_LEFTTRIM_ErrorCount,le.dsa_lvl_3n_ALLOW_ErrorCount
          ,le.dsa_lvl_4_LEFTTRIM_ErrorCount,le.dsa_lvl_4_ALLOW_ErrorCount
          ,le.dsa_lvl_5_LEFTTRIM_ErrorCount,le.dsa_lvl_5_ALLOW_ErrorCount
          ,le.csr_raw1_LEFTTRIM_ErrorCount,le.csr_raw1_ALLOW_ErrorCount
          ,le.csr_raw2_LEFTTRIM_ErrorCount,le.csr_raw2_ALLOW_ErrorCount
          ,le.csr_raw3_LEFTTRIM_ErrorCount,le.csr_raw3_ALLOW_ErrorCount
          ,le.csr_raw4_LEFTTRIM_ErrorCount,le.csr_raw4_ALLOW_ErrorCount
          ,le.clean_csr_expire_date_LEFTTRIM_ErrorCount,le.clean_csr_expire_date_ALLOW_ErrorCount
          ,le.clean_csr_issue_date_LEFTTRIM_ErrorCount,le.clean_csr_issue_date_ALLOW_ErrorCount
          ,le.sanction_id_LEFTTRIM_ErrorCount,le.sanction_id_ALLOW_ErrorCount
          ,le.sanction_action_code_LEFTTRIM_ErrorCount,le.sanction_action_code_ALLOW_ErrorCount
          ,le.sanction_action_description_LEFTTRIM_ErrorCount,le.sanction_action_description_ALLOW_ErrorCount
          ,le.sanction_board_code_LEFTTRIM_ErrorCount,le.sanction_board_code_ALLOW_ErrorCount
          ,le.sanction_board_description_LEFTTRIM_ErrorCount,le.sanction_board_description_ALLOW_ErrorCount
          ,le.action_date_LEFTTRIM_ErrorCount,le.action_date_ALLOW_ErrorCount
          ,le.sanction_period_start_date_LEFTTRIM_ErrorCount,le.sanction_period_start_date_ALLOW_ErrorCount
          ,le.sanction_period_end_date_LEFTTRIM_ErrorCount,le.sanction_period_end_date_ALLOW_ErrorCount
          ,le.month_duration_LEFTTRIM_ErrorCount,le.month_duration_ALLOW_ErrorCount
          ,le.fine_amount_LEFTTRIM_ErrorCount,le.fine_amount_ALLOW_ErrorCount
          ,le.offense_code_LEFTTRIM_ErrorCount,le.offense_code_ALLOW_ErrorCount
          ,le.offense_description_LEFTTRIM_ErrorCount,le.offense_description_ALLOW_ErrorCount
          ,le.offense_date_LEFTTRIM_ErrorCount,le.offense_date_ALLOW_ErrorCount
          ,le.clean_offense_date_LEFTTRIM_ErrorCount,le.clean_offense_date_ALLOW_ErrorCount
          ,le.clean_action_date_LEFTTRIM_ErrorCount,le.clean_action_date_ALLOW_ErrorCount
          ,le.clean_sanction_period_start_date_LEFTTRIM_ErrorCount,le.clean_sanction_period_start_date_ALLOW_ErrorCount
          ,le.clean_sanction_period_end_date_LEFTTRIM_ErrorCount,le.clean_sanction_period_end_date_ALLOW_ErrorCount
          ,le.gsa_sanction_id_LEFTTRIM_ErrorCount,le.gsa_sanction_id_ALLOW_ErrorCount
          ,le.gsa_first_LEFTTRIM_ErrorCount,le.gsa_first_ALLOW_ErrorCount
          ,le.gsa_middle_LEFTTRIM_ErrorCount,le.gsa_middle_ALLOW_ErrorCount
          ,le.gsa_last_LEFTTRIM_ErrorCount,le.gsa_last_ALLOW_ErrorCount
          ,le.gsa_suffix_LEFTTRIM_ErrorCount,le.gsa_suffix_ALLOW_ErrorCount
          ,le.gsa_city_LEFTTRIM_ErrorCount,le.gsa_city_ALLOW_ErrorCount
          ,le.gsa_state_LEFTTRIM_ErrorCount,le.gsa_state_ALLOW_ErrorCount
          ,le.gsa_zip_LEFTTRIM_ErrorCount,le.gsa_zip_ALLOW_ErrorCount
          ,le.date_LEFTTRIM_ErrorCount,le.date_ALLOW_ErrorCount
          ,le.agency_LEFTTRIM_ErrorCount,le.agency_ALLOW_ErrorCount
          ,le.confidence_LEFTTRIM_ErrorCount,le.confidence_ALLOW_ErrorCount
          ,le.clean_gsa_first_LEFTTRIM_ErrorCount,le.clean_gsa_first_ALLOW_ErrorCount
          ,le.clean_gsa_middle_LEFTTRIM_ErrorCount,le.clean_gsa_middle_ALLOW_ErrorCount
          ,le.clean_gsa_last_LEFTTRIM_ErrorCount,le.clean_gsa_last_ALLOW_ErrorCount
          ,le.clean_gsa_suffix_LEFTTRIM_ErrorCount,le.clean_gsa_suffix_ALLOW_ErrorCount
          ,le.clean_gsa_city_LEFTTRIM_ErrorCount,le.clean_gsa_city_ALLOW_ErrorCount
          ,le.clean_gsa_state_LEFTTRIM_ErrorCount,le.clean_gsa_state_ALLOW_ErrorCount
          ,le.clean_gsa_zip_LEFTTRIM_ErrorCount,le.clean_gsa_zip_ALLOW_ErrorCount
          ,le.clean_gsa_action_date_LEFTTRIM_ErrorCount,le.clean_gsa_action_date_ALLOW_ErrorCount
          ,le.clean_gsa_date_LEFTTRIM_ErrorCount,le.clean_gsa_date_ALLOW_ErrorCount
          ,le.fax_LEFTTRIM_ErrorCount,le.fax_ALLOW_ErrorCount
          ,le.phone_LEFTTRIM_ErrorCount,le.phone_ALLOW_ErrorCount
          ,le.certification_code_LEFTTRIM_ErrorCount,le.certification_code_ALLOW_ErrorCount
          ,le.certification_description_LEFTTRIM_ErrorCount,le.certification_description_ALLOW_ErrorCount
          ,le.board_code_LEFTTRIM_ErrorCount,le.board_code_ALLOW_ErrorCount
          ,le.board_description_LEFTTRIM_ErrorCount,le.board_description_ALLOW_ErrorCount
          ,le.expiration_year_LEFTTRIM_ErrorCount,le.expiration_year_ALLOW_ErrorCount
          ,le.issue_year_LEFTTRIM_ErrorCount,le.issue_year_ALLOW_ErrorCount
          ,le.renewal_year_LEFTTRIM_ErrorCount,le.renewal_year_ALLOW_ErrorCount
          ,le.lifetime_flag_LEFTTRIM_ErrorCount,le.lifetime_flag_ALLOW_ErrorCount
          ,le.covered_recipient_id_LEFTTRIM_ErrorCount,le.covered_recipient_id_ALLOW_ErrorCount
          ,le.cov_rcp_raw_state_code_LEFTTRIM_ErrorCount,le.cov_rcp_raw_state_code_ALLOW_ErrorCount
          ,le.cov_rcp_raw_full_name_LEFTTRIM_ErrorCount,le.cov_rcp_raw_full_name_ALLOW_ErrorCount
          ,le.cov_rcp_raw_attribute1_LEFTTRIM_ErrorCount,le.cov_rcp_raw_attribute1_ALLOW_ErrorCount
          ,le.cov_rcp_raw_attribute2_LEFTTRIM_ErrorCount,le.cov_rcp_raw_attribute2_ALLOW_ErrorCount
          ,le.cov_rcp_raw_attribute3_LEFTTRIM_ErrorCount,le.cov_rcp_raw_attribute3_ALLOW_ErrorCount
          ,le.cov_rcp_raw_attribute4_LEFTTRIM_ErrorCount,le.cov_rcp_raw_attribute4_ALLOW_ErrorCount
          ,le.hms_scid_LEFTTRIM_ErrorCount,le.hms_scid_ALLOW_ErrorCount
          ,le.school_name_LEFTTRIM_ErrorCount,le.school_name_ALLOW_ErrorCount
          ,le.grad_year_LEFTTRIM_ErrorCount,le.grad_year_ALLOW_ErrorCount
          ,le.lang_code_LEFTTRIM_ErrorCount,le.lang_code_ALLOW_ErrorCount
          ,le.language_LEFTTRIM_ErrorCount,le.language_ALLOW_ErrorCount
          ,le.specialty_description_LEFTTRIM_ErrorCount,le.specialty_description_ALLOW_ErrorCount
          ,le.clean_phone_LEFTTRIM_ErrorCount,le.clean_phone_ALLOW_ErrorCount
          ,le.bdid_LEFTTRIM_ErrorCount,le.bdid_ALLOW_ErrorCount
          ,le.bdid_score_LEFTTRIM_ErrorCount,le.bdid_score_ALLOW_ErrorCount
          ,le.did_LEFTTRIM_ErrorCount,le.did_ALLOW_ErrorCount
          ,le.did_score_LEFTTRIM_ErrorCount,le.did_score_ALLOW_ErrorCount
          ,le.clean_dob_LEFTTRIM_ErrorCount,le.clean_dob_ALLOW_ErrorCount
          ,le.best_dob_LEFTTRIM_ErrorCount,le.best_dob_ALLOW_ErrorCount
          ,le.best_ssn_LEFTTRIM_ErrorCount,le.best_ssn_ALLOW_ErrorCount
          ,le.rec_deactivated_date_LEFTTRIM_ErrorCount,le.rec_deactivated_date_ALLOW_ErrorCount
          ,le.superceeding_piid_LEFTTRIM_ErrorCount,le.superceeding_piid_ALLOW_ErrorCount
          ,le.dotid_LEFTTRIM_ErrorCount,le.dotid_ALLOW_ErrorCount
          ,le.dotscore_LEFTTRIM_ErrorCount,le.dotscore_ALLOW_ErrorCount
          ,le.dotweight_LEFTTRIM_ErrorCount,le.dotweight_ALLOW_ErrorCount
          ,le.empid_LEFTTRIM_ErrorCount,le.empid_ALLOW_ErrorCount
          ,le.empscore_LEFTTRIM_ErrorCount,le.empscore_ALLOW_ErrorCount
          ,le.empweight_LEFTTRIM_ErrorCount,le.empweight_ALLOW_ErrorCount
          ,le.powid_LEFTTRIM_ErrorCount,le.powid_ALLOW_ErrorCount
          ,le.powscore_LEFTTRIM_ErrorCount,le.powscore_ALLOW_ErrorCount
          ,le.powweight_LEFTTRIM_ErrorCount,le.powweight_ALLOW_ErrorCount
          ,le.proxid_LEFTTRIM_ErrorCount,le.proxid_ALLOW_ErrorCount
          ,le.proxscore_LEFTTRIM_ErrorCount,le.proxscore_ALLOW_ErrorCount
          ,le.proxweight_LEFTTRIM_ErrorCount,le.proxweight_ALLOW_ErrorCount
          ,le.seleid_LEFTTRIM_ErrorCount,le.seleid_ALLOW_ErrorCount
          ,le.selescore_LEFTTRIM_ErrorCount,le.selescore_ALLOW_ErrorCount
          ,le.seleweight_LEFTTRIM_ErrorCount,le.seleweight_ALLOW_ErrorCount
          ,le.orgid_LEFTTRIM_ErrorCount,le.orgid_ALLOW_ErrorCount
          ,le.orgscore_LEFTTRIM_ErrorCount,le.orgscore_ALLOW_ErrorCount
          ,le.orgweight_LEFTTRIM_ErrorCount,le.orgweight_ALLOW_ErrorCount
          ,le.ultid_LEFTTRIM_ErrorCount,le.ultid_ALLOW_ErrorCount
          ,le.ultscore_LEFTTRIM_ErrorCount,le.ultscore_ALLOW_ErrorCount
          ,le.ultweight_LEFTTRIM_ErrorCount,le.ultweight_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,402,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT31.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT31.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
