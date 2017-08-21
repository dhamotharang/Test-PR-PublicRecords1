IMPORT ut,SALT32;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_File)
    UNSIGNED1 mbslayout_company_id_Invalid;
    UNSIGNED1 mbslayout_global_company_id_Invalid;
    UNSIGNED1 allowlayout_allowflags_Invalid;
    UNSIGNED1 businfolayout_primary_market_code_Invalid;
    UNSIGNED1 businfolayout_secondary_market_code_Invalid;
    UNSIGNED1 businfolayout_industry_1_code_Invalid;
    UNSIGNED1 businfolayout_industry_2_code_Invalid;
    UNSIGNED1 businfolayout_sub_market_Invalid;
    UNSIGNED1 businfolayout_vertical_Invalid;
    UNSIGNED1 businfolayout_use_Invalid;
    UNSIGNED1 businfolayout_industry_Invalid;
    UNSIGNED1 persondatalayout_full_name_Invalid;
    UNSIGNED1 persondatalayout_first_name_Invalid;
    UNSIGNED1 persondatalayout_middle_name_Invalid;
    UNSIGNED1 persondatalayout_last_name_Invalid;
    UNSIGNED1 persondatalayout_address_Invalid;
    UNSIGNED1 persondatalayout_city_Invalid;
    UNSIGNED1 persondatalayout_state_Invalid;
    UNSIGNED1 persondatalayout_zip_Invalid;
    UNSIGNED1 persondatalayout_personal_phone_Invalid;
    UNSIGNED1 persondatalayout_work_phone_Invalid;
    UNSIGNED1 persondatalayout_dob_Invalid;
    UNSIGNED1 persondatalayout_dl_Invalid;
    UNSIGNED1 persondatalayout_dl_st_Invalid;
    UNSIGNED1 persondatalayout_email_address_Invalid;
    UNSIGNED1 persondatalayout_ssn_Invalid;
    UNSIGNED1 persondatalayout_linkid_Invalid;
    UNSIGNED1 persondatalayout_ipaddr_Invalid;
    UNSIGNED1 persondatalayout_title_Invalid;
    UNSIGNED1 persondatalayout_fname_Invalid;
    UNSIGNED1 persondatalayout_mname_Invalid;
    UNSIGNED1 persondatalayout_lname_Invalid;
    UNSIGNED1 persondatalayout_name_suffix_Invalid;
    UNSIGNED1 persondatalayout_prim_range_Invalid;
    UNSIGNED1 persondatalayout_predir_Invalid;
    UNSIGNED1 persondatalayout_prim_name_Invalid;
    UNSIGNED1 persondatalayout_addr_suffix_Invalid;
    UNSIGNED1 persondatalayout_postdir_Invalid;
    UNSIGNED1 persondatalayout_unit_desig_Invalid;
    UNSIGNED1 persondatalayout_sec_range_Invalid;
    UNSIGNED1 persondatalayout_v_city_name_Invalid;
    UNSIGNED1 persondatalayout_st_Invalid;
    UNSIGNED1 persondatalayout_zip5_Invalid;
    UNSIGNED1 persondatalayout_zip4_Invalid;
    UNSIGNED1 persondatalayout_addr_rec_type_Invalid;
    UNSIGNED1 persondatalayout_fips_state_Invalid;
    UNSIGNED1 persondatalayout_fips_county_Invalid;
    UNSIGNED1 persondatalayout_geo_lat_Invalid;
    UNSIGNED1 persondatalayout_geo_long_Invalid;
    UNSIGNED1 persondatalayout_cbsa_Invalid;
    UNSIGNED1 persondatalayout_geo_blk_Invalid;
    UNSIGNED1 persondatalayout_geo_match_Invalid;
    UNSIGNED1 persondatalayout_err_stat_Invalid;
    UNSIGNED1 persondatalayout_appended_ssn_Invalid;
    UNSIGNED1 persondatalayout_appended_adl_Invalid;
    UNSIGNED1 permissablelayout_glb_purpose_Invalid;
    UNSIGNED1 permissablelayout_dppa_purpose_Invalid;
    UNSIGNED1 permissablelayout_fcra_purpose_Invalid;
    UNSIGNED1 searchlayout_datetime_Invalid;
    UNSIGNED1 searchlayout_start_monitor_Invalid;
    UNSIGNED1 searchlayout_stop_monitor_Invalid;
    UNSIGNED1 searchlayout_login_history_id_Invalid;
    UNSIGNED1 searchlayout_transaction_id_Invalid;
    UNSIGNED1 searchlayout_sequence_number_Invalid;
    UNSIGNED1 searchlayout_method_Invalid;
    UNSIGNED1 searchlayout_product_code_Invalid;
    UNSIGNED1 searchlayout_transaction_type_Invalid;
    UNSIGNED1 searchlayout_function_description_Invalid;
    UNSIGNED1 searchlayout_ipaddr_Invalid;
    UNSIGNED1 fraudpoint_score_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_File)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
    UNSIGNED8 ScrubsBits3;
    UNSIGNED8 ScrubsBits4;
  END;
EXPORT FromNone(DATASET(Layout_File) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.mbslayout_company_id_Invalid := Fields.InValid_mbslayout_company_id((SALT32.StrType)le.mbslayout_company_id);
      clean_mbslayout_company_id := (TYPEOF(le.mbslayout_company_id))Fields.Make_mbslayout_company_id((SALT32.StrType)le.mbslayout_company_id);
      clean_mbslayout_company_id_Invalid := Fields.InValid_mbslayout_company_id((SALT32.StrType)clean_mbslayout_company_id);
      SELF.mbslayout_company_id := IF(withOnfail, clean_mbslayout_company_id, le.mbslayout_company_id); // ONFAIL(CLEAN)
    SELF.mbslayout_global_company_id_Invalid := Fields.InValid_mbslayout_global_company_id((SALT32.StrType)le.mbslayout_global_company_id);
      clean_mbslayout_global_company_id := (TYPEOF(le.mbslayout_global_company_id))Fields.Make_mbslayout_global_company_id((SALT32.StrType)le.mbslayout_global_company_id);
      clean_mbslayout_global_company_id_Invalid := Fields.InValid_mbslayout_global_company_id((SALT32.StrType)clean_mbslayout_global_company_id);
      SELF.mbslayout_global_company_id := IF(withOnfail, clean_mbslayout_global_company_id, le.mbslayout_global_company_id); // ONFAIL(CLEAN)
    SELF.allowlayout_allowflags_Invalid := Fields.InValid_allowlayout_allowflags((SALT32.StrType)le.allowlayout_allowflags);
      clean_allowlayout_allowflags := (TYPEOF(le.allowlayout_allowflags))Fields.Make_allowlayout_allowflags((SALT32.StrType)le.allowlayout_allowflags);
      clean_allowlayout_allowflags_Invalid := Fields.InValid_allowlayout_allowflags((SALT32.StrType)clean_allowlayout_allowflags);
      SELF.allowlayout_allowflags := IF(withOnfail, clean_allowlayout_allowflags, le.allowlayout_allowflags); // ONFAIL(CLEAN)
    SELF.businfolayout_primary_market_code_Invalid := Fields.InValid_businfolayout_primary_market_code((SALT32.StrType)le.businfolayout_primary_market_code);
      clean_businfolayout_primary_market_code := (TYPEOF(le.businfolayout_primary_market_code))Fields.Make_businfolayout_primary_market_code((SALT32.StrType)le.businfolayout_primary_market_code);
      clean_businfolayout_primary_market_code_Invalid := Fields.InValid_businfolayout_primary_market_code((SALT32.StrType)clean_businfolayout_primary_market_code);
      SELF.businfolayout_primary_market_code := IF(withOnfail, clean_businfolayout_primary_market_code, le.businfolayout_primary_market_code); // ONFAIL(CLEAN)
    SELF.businfolayout_secondary_market_code_Invalid := Fields.InValid_businfolayout_secondary_market_code((SALT32.StrType)le.businfolayout_secondary_market_code);
      clean_businfolayout_secondary_market_code := (TYPEOF(le.businfolayout_secondary_market_code))Fields.Make_businfolayout_secondary_market_code((SALT32.StrType)le.businfolayout_secondary_market_code);
      clean_businfolayout_secondary_market_code_Invalid := Fields.InValid_businfolayout_secondary_market_code((SALT32.StrType)clean_businfolayout_secondary_market_code);
      SELF.businfolayout_secondary_market_code := IF(withOnfail, clean_businfolayout_secondary_market_code, le.businfolayout_secondary_market_code); // ONFAIL(CLEAN)
    SELF.businfolayout_industry_1_code_Invalid := Fields.InValid_businfolayout_industry_1_code((SALT32.StrType)le.businfolayout_industry_1_code);
      clean_businfolayout_industry_1_code := (TYPEOF(le.businfolayout_industry_1_code))Fields.Make_businfolayout_industry_1_code((SALT32.StrType)le.businfolayout_industry_1_code);
      clean_businfolayout_industry_1_code_Invalid := Fields.InValid_businfolayout_industry_1_code((SALT32.StrType)clean_businfolayout_industry_1_code);
      SELF.businfolayout_industry_1_code := IF(withOnfail, clean_businfolayout_industry_1_code, le.businfolayout_industry_1_code); // ONFAIL(CLEAN)
    SELF.businfolayout_industry_2_code_Invalid := Fields.InValid_businfolayout_industry_2_code((SALT32.StrType)le.businfolayout_industry_2_code);
      clean_businfolayout_industry_2_code := (TYPEOF(le.businfolayout_industry_2_code))Fields.Make_businfolayout_industry_2_code((SALT32.StrType)le.businfolayout_industry_2_code);
      clean_businfolayout_industry_2_code_Invalid := Fields.InValid_businfolayout_industry_2_code((SALT32.StrType)clean_businfolayout_industry_2_code);
      SELF.businfolayout_industry_2_code := IF(withOnfail, clean_businfolayout_industry_2_code, le.businfolayout_industry_2_code); // ONFAIL(CLEAN)
    SELF.businfolayout_sub_market_Invalid := Fields.InValid_businfolayout_sub_market((SALT32.StrType)le.businfolayout_sub_market);
      clean_businfolayout_sub_market := (TYPEOF(le.businfolayout_sub_market))Fields.Make_businfolayout_sub_market((SALT32.StrType)le.businfolayout_sub_market);
      clean_businfolayout_sub_market_Invalid := Fields.InValid_businfolayout_sub_market((SALT32.StrType)clean_businfolayout_sub_market);
      SELF.businfolayout_sub_market := IF(withOnfail, clean_businfolayout_sub_market, le.businfolayout_sub_market); // ONFAIL(CLEAN)
    SELF.businfolayout_vertical_Invalid := Fields.InValid_businfolayout_vertical((SALT32.StrType)le.businfolayout_vertical);
      clean_businfolayout_vertical := (TYPEOF(le.businfolayout_vertical))Fields.Make_businfolayout_vertical((SALT32.StrType)le.businfolayout_vertical);
      clean_businfolayout_vertical_Invalid := Fields.InValid_businfolayout_vertical((SALT32.StrType)clean_businfolayout_vertical);
      SELF.businfolayout_vertical := IF(withOnfail, clean_businfolayout_vertical, le.businfolayout_vertical); // ONFAIL(CLEAN)
    SELF.businfolayout_use_Invalid := Fields.InValid_businfolayout_use((SALT32.StrType)le.businfolayout_use);
      clean_businfolayout_use := (TYPEOF(le.businfolayout_use))Fields.Make_businfolayout_use((SALT32.StrType)le.businfolayout_use);
      clean_businfolayout_use_Invalid := Fields.InValid_businfolayout_use((SALT32.StrType)clean_businfolayout_use);
      SELF.businfolayout_use := IF(withOnfail, clean_businfolayout_use, le.businfolayout_use); // ONFAIL(CLEAN)
    SELF.businfolayout_industry_Invalid := Fields.InValid_businfolayout_industry((SALT32.StrType)le.businfolayout_industry);
      clean_businfolayout_industry := (TYPEOF(le.businfolayout_industry))Fields.Make_businfolayout_industry((SALT32.StrType)le.businfolayout_industry);
      clean_businfolayout_industry_Invalid := Fields.InValid_businfolayout_industry((SALT32.StrType)clean_businfolayout_industry);
      SELF.businfolayout_industry := IF(withOnfail, clean_businfolayout_industry, le.businfolayout_industry); // ONFAIL(CLEAN)
    SELF.persondatalayout_full_name_Invalid := Fields.InValid_persondatalayout_full_name((SALT32.StrType)le.persondatalayout_full_name);
      clean_persondatalayout_full_name := (TYPEOF(le.persondatalayout_full_name))Fields.Make_persondatalayout_full_name((SALT32.StrType)le.persondatalayout_full_name);
      clean_persondatalayout_full_name_Invalid := Fields.InValid_persondatalayout_full_name((SALT32.StrType)clean_persondatalayout_full_name);
      SELF.persondatalayout_full_name := IF(withOnfail, clean_persondatalayout_full_name, le.persondatalayout_full_name); // ONFAIL(CLEAN)
    SELF.persondatalayout_first_name_Invalid := Fields.InValid_persondatalayout_first_name((SALT32.StrType)le.persondatalayout_first_name);
      clean_persondatalayout_first_name := (TYPEOF(le.persondatalayout_first_name))Fields.Make_persondatalayout_first_name((SALT32.StrType)le.persondatalayout_first_name);
      clean_persondatalayout_first_name_Invalid := Fields.InValid_persondatalayout_first_name((SALT32.StrType)clean_persondatalayout_first_name);
      SELF.persondatalayout_first_name := IF(withOnfail, clean_persondatalayout_first_name, le.persondatalayout_first_name); // ONFAIL(CLEAN)
    SELF.persondatalayout_middle_name_Invalid := Fields.InValid_persondatalayout_middle_name((SALT32.StrType)le.persondatalayout_middle_name);
      clean_persondatalayout_middle_name := (TYPEOF(le.persondatalayout_middle_name))Fields.Make_persondatalayout_middle_name((SALT32.StrType)le.persondatalayout_middle_name);
      clean_persondatalayout_middle_name_Invalid := Fields.InValid_persondatalayout_middle_name((SALT32.StrType)clean_persondatalayout_middle_name);
      SELF.persondatalayout_middle_name := IF(withOnfail, clean_persondatalayout_middle_name, le.persondatalayout_middle_name); // ONFAIL(CLEAN)
    SELF.persondatalayout_last_name_Invalid := Fields.InValid_persondatalayout_last_name((SALT32.StrType)le.persondatalayout_last_name);
      clean_persondatalayout_last_name := (TYPEOF(le.persondatalayout_last_name))Fields.Make_persondatalayout_last_name((SALT32.StrType)le.persondatalayout_last_name);
      clean_persondatalayout_last_name_Invalid := Fields.InValid_persondatalayout_last_name((SALT32.StrType)clean_persondatalayout_last_name);
      SELF.persondatalayout_last_name := IF(withOnfail, clean_persondatalayout_last_name, le.persondatalayout_last_name); // ONFAIL(CLEAN)
    SELF.persondatalayout_address_Invalid := Fields.InValid_persondatalayout_address((SALT32.StrType)le.persondatalayout_address);
      clean_persondatalayout_address := (TYPEOF(le.persondatalayout_address))Fields.Make_persondatalayout_address((SALT32.StrType)le.persondatalayout_address);
      clean_persondatalayout_address_Invalid := Fields.InValid_persondatalayout_address((SALT32.StrType)clean_persondatalayout_address);
      SELF.persondatalayout_address := IF(withOnfail, clean_persondatalayout_address, le.persondatalayout_address); // ONFAIL(CLEAN)
    SELF.persondatalayout_city_Invalid := Fields.InValid_persondatalayout_city((SALT32.StrType)le.persondatalayout_city);
      clean_persondatalayout_city := (TYPEOF(le.persondatalayout_city))Fields.Make_persondatalayout_city((SALT32.StrType)le.persondatalayout_city);
      clean_persondatalayout_city_Invalid := Fields.InValid_persondatalayout_city((SALT32.StrType)clean_persondatalayout_city);
      SELF.persondatalayout_city := IF(withOnfail, clean_persondatalayout_city, le.persondatalayout_city); // ONFAIL(CLEAN)
    SELF.persondatalayout_state_Invalid := Fields.InValid_persondatalayout_state((SALT32.StrType)le.persondatalayout_state);
      clean_persondatalayout_state := (TYPEOF(le.persondatalayout_state))Fields.Make_persondatalayout_state((SALT32.StrType)le.persondatalayout_state);
      clean_persondatalayout_state_Invalid := Fields.InValid_persondatalayout_state((SALT32.StrType)clean_persondatalayout_state);
      SELF.persondatalayout_state := IF(withOnfail, clean_persondatalayout_state, le.persondatalayout_state); // ONFAIL(CLEAN)
    SELF.persondatalayout_zip_Invalid := Fields.InValid_persondatalayout_zip((SALT32.StrType)le.persondatalayout_zip);
      clean_persondatalayout_zip := (TYPEOF(le.persondatalayout_zip))Fields.Make_persondatalayout_zip((SALT32.StrType)le.persondatalayout_zip);
      clean_persondatalayout_zip_Invalid := Fields.InValid_persondatalayout_zip((SALT32.StrType)clean_persondatalayout_zip);
      SELF.persondatalayout_zip := IF(withOnfail, clean_persondatalayout_zip, le.persondatalayout_zip); // ONFAIL(CLEAN)
    SELF.persondatalayout_personal_phone_Invalid := Fields.InValid_persondatalayout_personal_phone((SALT32.StrType)le.persondatalayout_personal_phone);
      clean_persondatalayout_personal_phone := (TYPEOF(le.persondatalayout_personal_phone))Fields.Make_persondatalayout_personal_phone((SALT32.StrType)le.persondatalayout_personal_phone);
      clean_persondatalayout_personal_phone_Invalid := Fields.InValid_persondatalayout_personal_phone((SALT32.StrType)clean_persondatalayout_personal_phone);
      SELF.persondatalayout_personal_phone := IF(withOnfail, clean_persondatalayout_personal_phone, le.persondatalayout_personal_phone); // ONFAIL(CLEAN)
    SELF.persondatalayout_work_phone_Invalid := Fields.InValid_persondatalayout_work_phone((SALT32.StrType)le.persondatalayout_work_phone);
      clean_persondatalayout_work_phone := (TYPEOF(le.persondatalayout_work_phone))Fields.Make_persondatalayout_work_phone((SALT32.StrType)le.persondatalayout_work_phone);
      clean_persondatalayout_work_phone_Invalid := Fields.InValid_persondatalayout_work_phone((SALT32.StrType)clean_persondatalayout_work_phone);
      SELF.persondatalayout_work_phone := IF(withOnfail, clean_persondatalayout_work_phone, le.persondatalayout_work_phone); // ONFAIL(CLEAN)
    SELF.persondatalayout_dob_Invalid := Fields.InValid_persondatalayout_dob((SALT32.StrType)le.persondatalayout_dob);
      clean_persondatalayout_dob := (TYPEOF(le.persondatalayout_dob))Fields.Make_persondatalayout_dob((SALT32.StrType)le.persondatalayout_dob);
      clean_persondatalayout_dob_Invalid := Fields.InValid_persondatalayout_dob((SALT32.StrType)clean_persondatalayout_dob);
      SELF.persondatalayout_dob := IF(withOnfail, clean_persondatalayout_dob, le.persondatalayout_dob); // ONFAIL(CLEAN)
    SELF.persondatalayout_dl_Invalid := Fields.InValid_persondatalayout_dl((SALT32.StrType)le.persondatalayout_dl);
      clean_persondatalayout_dl := (TYPEOF(le.persondatalayout_dl))Fields.Make_persondatalayout_dl((SALT32.StrType)le.persondatalayout_dl);
      clean_persondatalayout_dl_Invalid := Fields.InValid_persondatalayout_dl((SALT32.StrType)clean_persondatalayout_dl);
      SELF.persondatalayout_dl := IF(withOnfail, clean_persondatalayout_dl, le.persondatalayout_dl); // ONFAIL(CLEAN)
    SELF.persondatalayout_dl_st_Invalid := Fields.InValid_persondatalayout_dl_st((SALT32.StrType)le.persondatalayout_dl_st);
      clean_persondatalayout_dl_st := (TYPEOF(le.persondatalayout_dl_st))Fields.Make_persondatalayout_dl_st((SALT32.StrType)le.persondatalayout_dl_st);
      clean_persondatalayout_dl_st_Invalid := Fields.InValid_persondatalayout_dl_st((SALT32.StrType)clean_persondatalayout_dl_st);
      SELF.persondatalayout_dl_st := IF(withOnfail, clean_persondatalayout_dl_st, le.persondatalayout_dl_st); // ONFAIL(CLEAN)
    SELF.persondatalayout_email_address_Invalid := Fields.InValid_persondatalayout_email_address((SALT32.StrType)le.persondatalayout_email_address);
      clean_persondatalayout_email_address := (TYPEOF(le.persondatalayout_email_address))Fields.Make_persondatalayout_email_address((SALT32.StrType)le.persondatalayout_email_address);
      clean_persondatalayout_email_address_Invalid := Fields.InValid_persondatalayout_email_address((SALT32.StrType)clean_persondatalayout_email_address);
      SELF.persondatalayout_email_address := IF(withOnfail, clean_persondatalayout_email_address, le.persondatalayout_email_address); // ONFAIL(CLEAN)
    SELF.persondatalayout_ssn_Invalid := Fields.InValid_persondatalayout_ssn((SALT32.StrType)le.persondatalayout_ssn);
      clean_persondatalayout_ssn := (TYPEOF(le.persondatalayout_ssn))Fields.Make_persondatalayout_ssn((SALT32.StrType)le.persondatalayout_ssn);
      clean_persondatalayout_ssn_Invalid := Fields.InValid_persondatalayout_ssn((SALT32.StrType)clean_persondatalayout_ssn);
      SELF.persondatalayout_ssn := IF(withOnfail, clean_persondatalayout_ssn, le.persondatalayout_ssn); // ONFAIL(CLEAN)
    SELF.persondatalayout_linkid_Invalid := Fields.InValid_persondatalayout_linkid((SALT32.StrType)le.persondatalayout_linkid);
      clean_persondatalayout_linkid := (TYPEOF(le.persondatalayout_linkid))Fields.Make_persondatalayout_linkid((SALT32.StrType)le.persondatalayout_linkid);
      clean_persondatalayout_linkid_Invalid := Fields.InValid_persondatalayout_linkid((SALT32.StrType)clean_persondatalayout_linkid);
      SELF.persondatalayout_linkid := IF(withOnfail, clean_persondatalayout_linkid, le.persondatalayout_linkid); // ONFAIL(CLEAN)
    SELF.persondatalayout_ipaddr_Invalid := Fields.InValid_persondatalayout_ipaddr((SALT32.StrType)le.persondatalayout_ipaddr);
      clean_persondatalayout_ipaddr := (TYPEOF(le.persondatalayout_ipaddr))Fields.Make_persondatalayout_ipaddr((SALT32.StrType)le.persondatalayout_ipaddr);
      clean_persondatalayout_ipaddr_Invalid := Fields.InValid_persondatalayout_ipaddr((SALT32.StrType)clean_persondatalayout_ipaddr);
      SELF.persondatalayout_ipaddr := IF(withOnfail, clean_persondatalayout_ipaddr, le.persondatalayout_ipaddr); // ONFAIL(CLEAN)
    SELF.persondatalayout_title_Invalid := Fields.InValid_persondatalayout_title((SALT32.StrType)le.persondatalayout_title);
      clean_persondatalayout_title := (TYPEOF(le.persondatalayout_title))Fields.Make_persondatalayout_title((SALT32.StrType)le.persondatalayout_title);
      clean_persondatalayout_title_Invalid := Fields.InValid_persondatalayout_title((SALT32.StrType)clean_persondatalayout_title);
      SELF.persondatalayout_title := IF(withOnfail, clean_persondatalayout_title, le.persondatalayout_title); // ONFAIL(CLEAN)
    SELF.persondatalayout_fname_Invalid := Fields.InValid_persondatalayout_fname((SALT32.StrType)le.persondatalayout_fname);
      clean_persondatalayout_fname := (TYPEOF(le.persondatalayout_fname))Fields.Make_persondatalayout_fname((SALT32.StrType)le.persondatalayout_fname);
      clean_persondatalayout_fname_Invalid := Fields.InValid_persondatalayout_fname((SALT32.StrType)clean_persondatalayout_fname);
      SELF.persondatalayout_fname := IF(withOnfail, clean_persondatalayout_fname, le.persondatalayout_fname); // ONFAIL(CLEAN)
    SELF.persondatalayout_mname_Invalid := Fields.InValid_persondatalayout_mname((SALT32.StrType)le.persondatalayout_mname);
      clean_persondatalayout_mname := (TYPEOF(le.persondatalayout_mname))Fields.Make_persondatalayout_mname((SALT32.StrType)le.persondatalayout_mname);
      clean_persondatalayout_mname_Invalid := Fields.InValid_persondatalayout_mname((SALT32.StrType)clean_persondatalayout_mname);
      SELF.persondatalayout_mname := IF(withOnfail, clean_persondatalayout_mname, le.persondatalayout_mname); // ONFAIL(CLEAN)
    SELF.persondatalayout_lname_Invalid := Fields.InValid_persondatalayout_lname((SALT32.StrType)le.persondatalayout_lname);
      clean_persondatalayout_lname := (TYPEOF(le.persondatalayout_lname))Fields.Make_persondatalayout_lname((SALT32.StrType)le.persondatalayout_lname);
      clean_persondatalayout_lname_Invalid := Fields.InValid_persondatalayout_lname((SALT32.StrType)clean_persondatalayout_lname);
      SELF.persondatalayout_lname := IF(withOnfail, clean_persondatalayout_lname, le.persondatalayout_lname); // ONFAIL(CLEAN)
    SELF.persondatalayout_name_suffix_Invalid := Fields.InValid_persondatalayout_name_suffix((SALT32.StrType)le.persondatalayout_name_suffix);
      clean_persondatalayout_name_suffix := (TYPEOF(le.persondatalayout_name_suffix))Fields.Make_persondatalayout_name_suffix((SALT32.StrType)le.persondatalayout_name_suffix);
      clean_persondatalayout_name_suffix_Invalid := Fields.InValid_persondatalayout_name_suffix((SALT32.StrType)clean_persondatalayout_name_suffix);
      SELF.persondatalayout_name_suffix := IF(withOnfail, clean_persondatalayout_name_suffix, le.persondatalayout_name_suffix); // ONFAIL(CLEAN)
    SELF.persondatalayout_prim_range_Invalid := Fields.InValid_persondatalayout_prim_range((SALT32.StrType)le.persondatalayout_prim_range);
      clean_persondatalayout_prim_range := (TYPEOF(le.persondatalayout_prim_range))Fields.Make_persondatalayout_prim_range((SALT32.StrType)le.persondatalayout_prim_range);
      clean_persondatalayout_prim_range_Invalid := Fields.InValid_persondatalayout_prim_range((SALT32.StrType)clean_persondatalayout_prim_range);
      SELF.persondatalayout_prim_range := IF(withOnfail, clean_persondatalayout_prim_range, le.persondatalayout_prim_range); // ONFAIL(CLEAN)
    SELF.persondatalayout_predir_Invalid := Fields.InValid_persondatalayout_predir((SALT32.StrType)le.persondatalayout_predir);
      clean_persondatalayout_predir := (TYPEOF(le.persondatalayout_predir))Fields.Make_persondatalayout_predir((SALT32.StrType)le.persondatalayout_predir);
      clean_persondatalayout_predir_Invalid := Fields.InValid_persondatalayout_predir((SALT32.StrType)clean_persondatalayout_predir);
      SELF.persondatalayout_predir := IF(withOnfail, clean_persondatalayout_predir, le.persondatalayout_predir); // ONFAIL(CLEAN)
    SELF.persondatalayout_prim_name_Invalid := Fields.InValid_persondatalayout_prim_name((SALT32.StrType)le.persondatalayout_prim_name);
      clean_persondatalayout_prim_name := (TYPEOF(le.persondatalayout_prim_name))Fields.Make_persondatalayout_prim_name((SALT32.StrType)le.persondatalayout_prim_name);
      clean_persondatalayout_prim_name_Invalid := Fields.InValid_persondatalayout_prim_name((SALT32.StrType)clean_persondatalayout_prim_name);
      SELF.persondatalayout_prim_name := IF(withOnfail, clean_persondatalayout_prim_name, le.persondatalayout_prim_name); // ONFAIL(CLEAN)
    SELF.persondatalayout_addr_suffix_Invalid := Fields.InValid_persondatalayout_addr_suffix((SALT32.StrType)le.persondatalayout_addr_suffix);
      clean_persondatalayout_addr_suffix := (TYPEOF(le.persondatalayout_addr_suffix))Fields.Make_persondatalayout_addr_suffix((SALT32.StrType)le.persondatalayout_addr_suffix);
      clean_persondatalayout_addr_suffix_Invalid := Fields.InValid_persondatalayout_addr_suffix((SALT32.StrType)clean_persondatalayout_addr_suffix);
      SELF.persondatalayout_addr_suffix := IF(withOnfail, clean_persondatalayout_addr_suffix, le.persondatalayout_addr_suffix); // ONFAIL(CLEAN)
    SELF.persondatalayout_postdir_Invalid := Fields.InValid_persondatalayout_postdir((SALT32.StrType)le.persondatalayout_postdir);
      clean_persondatalayout_postdir := (TYPEOF(le.persondatalayout_postdir))Fields.Make_persondatalayout_postdir((SALT32.StrType)le.persondatalayout_postdir);
      clean_persondatalayout_postdir_Invalid := Fields.InValid_persondatalayout_postdir((SALT32.StrType)clean_persondatalayout_postdir);
      SELF.persondatalayout_postdir := IF(withOnfail, clean_persondatalayout_postdir, le.persondatalayout_postdir); // ONFAIL(CLEAN)
    SELF.persondatalayout_unit_desig_Invalid := Fields.InValid_persondatalayout_unit_desig((SALT32.StrType)le.persondatalayout_unit_desig);
      clean_persondatalayout_unit_desig := (TYPEOF(le.persondatalayout_unit_desig))Fields.Make_persondatalayout_unit_desig((SALT32.StrType)le.persondatalayout_unit_desig);
      clean_persondatalayout_unit_desig_Invalid := Fields.InValid_persondatalayout_unit_desig((SALT32.StrType)clean_persondatalayout_unit_desig);
      SELF.persondatalayout_unit_desig := IF(withOnfail, clean_persondatalayout_unit_desig, le.persondatalayout_unit_desig); // ONFAIL(CLEAN)
    SELF.persondatalayout_sec_range_Invalid := Fields.InValid_persondatalayout_sec_range((SALT32.StrType)le.persondatalayout_sec_range);
      clean_persondatalayout_sec_range := (TYPEOF(le.persondatalayout_sec_range))Fields.Make_persondatalayout_sec_range((SALT32.StrType)le.persondatalayout_sec_range);
      clean_persondatalayout_sec_range_Invalid := Fields.InValid_persondatalayout_sec_range((SALT32.StrType)clean_persondatalayout_sec_range);
      SELF.persondatalayout_sec_range := IF(withOnfail, clean_persondatalayout_sec_range, le.persondatalayout_sec_range); // ONFAIL(CLEAN)
    SELF.persondatalayout_v_city_name_Invalid := Fields.InValid_persondatalayout_v_city_name((SALT32.StrType)le.persondatalayout_v_city_name);
      clean_persondatalayout_v_city_name := (TYPEOF(le.persondatalayout_v_city_name))Fields.Make_persondatalayout_v_city_name((SALT32.StrType)le.persondatalayout_v_city_name);
      clean_persondatalayout_v_city_name_Invalid := Fields.InValid_persondatalayout_v_city_name((SALT32.StrType)clean_persondatalayout_v_city_name);
      SELF.persondatalayout_v_city_name := IF(withOnfail, clean_persondatalayout_v_city_name, le.persondatalayout_v_city_name); // ONFAIL(CLEAN)
    SELF.persondatalayout_st_Invalid := Fields.InValid_persondatalayout_st((SALT32.StrType)le.persondatalayout_st);
      clean_persondatalayout_st := (TYPEOF(le.persondatalayout_st))Fields.Make_persondatalayout_st((SALT32.StrType)le.persondatalayout_st);
      clean_persondatalayout_st_Invalid := Fields.InValid_persondatalayout_st((SALT32.StrType)clean_persondatalayout_st);
      SELF.persondatalayout_st := IF(withOnfail, clean_persondatalayout_st, le.persondatalayout_st); // ONFAIL(CLEAN)
    SELF.persondatalayout_zip5_Invalid := Fields.InValid_persondatalayout_zip5((SALT32.StrType)le.persondatalayout_zip5);
      clean_persondatalayout_zip5 := (TYPEOF(le.persondatalayout_zip5))Fields.Make_persondatalayout_zip5((SALT32.StrType)le.persondatalayout_zip5);
      clean_persondatalayout_zip5_Invalid := Fields.InValid_persondatalayout_zip5((SALT32.StrType)clean_persondatalayout_zip5);
      SELF.persondatalayout_zip5 := IF(withOnfail, clean_persondatalayout_zip5, le.persondatalayout_zip5); // ONFAIL(CLEAN)
    SELF.persondatalayout_zip4_Invalid := Fields.InValid_persondatalayout_zip4((SALT32.StrType)le.persondatalayout_zip4);
      clean_persondatalayout_zip4 := (TYPEOF(le.persondatalayout_zip4))Fields.Make_persondatalayout_zip4((SALT32.StrType)le.persondatalayout_zip4);
      clean_persondatalayout_zip4_Invalid := Fields.InValid_persondatalayout_zip4((SALT32.StrType)clean_persondatalayout_zip4);
      SELF.persondatalayout_zip4 := IF(withOnfail, clean_persondatalayout_zip4, le.persondatalayout_zip4); // ONFAIL(CLEAN)
    SELF.persondatalayout_addr_rec_type_Invalid := Fields.InValid_persondatalayout_addr_rec_type((SALT32.StrType)le.persondatalayout_addr_rec_type);
      clean_persondatalayout_addr_rec_type := (TYPEOF(le.persondatalayout_addr_rec_type))Fields.Make_persondatalayout_addr_rec_type((SALT32.StrType)le.persondatalayout_addr_rec_type);
      clean_persondatalayout_addr_rec_type_Invalid := Fields.InValid_persondatalayout_addr_rec_type((SALT32.StrType)clean_persondatalayout_addr_rec_type);
      SELF.persondatalayout_addr_rec_type := IF(withOnfail, clean_persondatalayout_addr_rec_type, le.persondatalayout_addr_rec_type); // ONFAIL(CLEAN)
    SELF.persondatalayout_fips_state_Invalid := Fields.InValid_persondatalayout_fips_state((SALT32.StrType)le.persondatalayout_fips_state);
      clean_persondatalayout_fips_state := (TYPEOF(le.persondatalayout_fips_state))Fields.Make_persondatalayout_fips_state((SALT32.StrType)le.persondatalayout_fips_state);
      clean_persondatalayout_fips_state_Invalid := Fields.InValid_persondatalayout_fips_state((SALT32.StrType)clean_persondatalayout_fips_state);
      SELF.persondatalayout_fips_state := IF(withOnfail, clean_persondatalayout_fips_state, le.persondatalayout_fips_state); // ONFAIL(CLEAN)
    SELF.persondatalayout_fips_county_Invalid := Fields.InValid_persondatalayout_fips_county((SALT32.StrType)le.persondatalayout_fips_county);
      clean_persondatalayout_fips_county := (TYPEOF(le.persondatalayout_fips_county))Fields.Make_persondatalayout_fips_county((SALT32.StrType)le.persondatalayout_fips_county);
      clean_persondatalayout_fips_county_Invalid := Fields.InValid_persondatalayout_fips_county((SALT32.StrType)clean_persondatalayout_fips_county);
      SELF.persondatalayout_fips_county := IF(withOnfail, clean_persondatalayout_fips_county, le.persondatalayout_fips_county); // ONFAIL(CLEAN)
    SELF.persondatalayout_geo_lat_Invalid := Fields.InValid_persondatalayout_geo_lat((SALT32.StrType)le.persondatalayout_geo_lat);
      clean_persondatalayout_geo_lat := (TYPEOF(le.persondatalayout_geo_lat))Fields.Make_persondatalayout_geo_lat((SALT32.StrType)le.persondatalayout_geo_lat);
      clean_persondatalayout_geo_lat_Invalid := Fields.InValid_persondatalayout_geo_lat((SALT32.StrType)clean_persondatalayout_geo_lat);
      SELF.persondatalayout_geo_lat := IF(withOnfail, clean_persondatalayout_geo_lat, le.persondatalayout_geo_lat); // ONFAIL(CLEAN)
    SELF.persondatalayout_geo_long_Invalid := Fields.InValid_persondatalayout_geo_long((SALT32.StrType)le.persondatalayout_geo_long);
      clean_persondatalayout_geo_long := (TYPEOF(le.persondatalayout_geo_long))Fields.Make_persondatalayout_geo_long((SALT32.StrType)le.persondatalayout_geo_long);
      clean_persondatalayout_geo_long_Invalid := Fields.InValid_persondatalayout_geo_long((SALT32.StrType)clean_persondatalayout_geo_long);
      SELF.persondatalayout_geo_long := IF(withOnfail, clean_persondatalayout_geo_long, le.persondatalayout_geo_long); // ONFAIL(CLEAN)
    SELF.persondatalayout_cbsa_Invalid := Fields.InValid_persondatalayout_cbsa((SALT32.StrType)le.persondatalayout_cbsa);
      clean_persondatalayout_cbsa := (TYPEOF(le.persondatalayout_cbsa))Fields.Make_persondatalayout_cbsa((SALT32.StrType)le.persondatalayout_cbsa);
      clean_persondatalayout_cbsa_Invalid := Fields.InValid_persondatalayout_cbsa((SALT32.StrType)clean_persondatalayout_cbsa);
      SELF.persondatalayout_cbsa := IF(withOnfail, clean_persondatalayout_cbsa, le.persondatalayout_cbsa); // ONFAIL(CLEAN)
    SELF.persondatalayout_geo_blk_Invalid := Fields.InValid_persondatalayout_geo_blk((SALT32.StrType)le.persondatalayout_geo_blk);
      clean_persondatalayout_geo_blk := (TYPEOF(le.persondatalayout_geo_blk))Fields.Make_persondatalayout_geo_blk((SALT32.StrType)le.persondatalayout_geo_blk);
      clean_persondatalayout_geo_blk_Invalid := Fields.InValid_persondatalayout_geo_blk((SALT32.StrType)clean_persondatalayout_geo_blk);
      SELF.persondatalayout_geo_blk := IF(withOnfail, clean_persondatalayout_geo_blk, le.persondatalayout_geo_blk); // ONFAIL(CLEAN)
    SELF.persondatalayout_geo_match_Invalid := Fields.InValid_persondatalayout_geo_match((SALT32.StrType)le.persondatalayout_geo_match);
      clean_persondatalayout_geo_match := (TYPEOF(le.persondatalayout_geo_match))Fields.Make_persondatalayout_geo_match((SALT32.StrType)le.persondatalayout_geo_match);
      clean_persondatalayout_geo_match_Invalid := Fields.InValid_persondatalayout_geo_match((SALT32.StrType)clean_persondatalayout_geo_match);
      SELF.persondatalayout_geo_match := IF(withOnfail, clean_persondatalayout_geo_match, le.persondatalayout_geo_match); // ONFAIL(CLEAN)
    SELF.persondatalayout_err_stat_Invalid := Fields.InValid_persondatalayout_err_stat((SALT32.StrType)le.persondatalayout_err_stat);
      clean_persondatalayout_err_stat := (TYPEOF(le.persondatalayout_err_stat))Fields.Make_persondatalayout_err_stat((SALT32.StrType)le.persondatalayout_err_stat);
      clean_persondatalayout_err_stat_Invalid := Fields.InValid_persondatalayout_err_stat((SALT32.StrType)clean_persondatalayout_err_stat);
      SELF.persondatalayout_err_stat := IF(withOnfail, clean_persondatalayout_err_stat, le.persondatalayout_err_stat); // ONFAIL(CLEAN)
    SELF.persondatalayout_appended_ssn_Invalid := Fields.InValid_persondatalayout_appended_ssn((SALT32.StrType)le.persondatalayout_appended_ssn);
      clean_persondatalayout_appended_ssn := (TYPEOF(le.persondatalayout_appended_ssn))Fields.Make_persondatalayout_appended_ssn((SALT32.StrType)le.persondatalayout_appended_ssn);
      clean_persondatalayout_appended_ssn_Invalid := Fields.InValid_persondatalayout_appended_ssn((SALT32.StrType)clean_persondatalayout_appended_ssn);
      SELF.persondatalayout_appended_ssn := IF(withOnfail, clean_persondatalayout_appended_ssn, le.persondatalayout_appended_ssn); // ONFAIL(CLEAN)
    SELF.persondatalayout_appended_adl_Invalid := Fields.InValid_persondatalayout_appended_adl((SALT32.StrType)le.persondatalayout_appended_adl);
      clean_persondatalayout_appended_adl := (TYPEOF(le.persondatalayout_appended_adl))Fields.Make_persondatalayout_appended_adl((SALT32.StrType)le.persondatalayout_appended_adl);
      clean_persondatalayout_appended_adl_Invalid := Fields.InValid_persondatalayout_appended_adl((SALT32.StrType)clean_persondatalayout_appended_adl);
      SELF.persondatalayout_appended_adl := IF(withOnfail, clean_persondatalayout_appended_adl, le.persondatalayout_appended_adl); // ONFAIL(CLEAN)
    SELF.permissablelayout_glb_purpose_Invalid := Fields.InValid_permissablelayout_glb_purpose((SALT32.StrType)le.permissablelayout_glb_purpose);
      clean_permissablelayout_glb_purpose := (TYPEOF(le.permissablelayout_glb_purpose))Fields.Make_permissablelayout_glb_purpose((SALT32.StrType)le.permissablelayout_glb_purpose);
      clean_permissablelayout_glb_purpose_Invalid := Fields.InValid_permissablelayout_glb_purpose((SALT32.StrType)clean_permissablelayout_glb_purpose);
      SELF.permissablelayout_glb_purpose := IF(withOnfail, clean_permissablelayout_glb_purpose, le.permissablelayout_glb_purpose); // ONFAIL(CLEAN)
    SELF.permissablelayout_dppa_purpose_Invalid := Fields.InValid_permissablelayout_dppa_purpose((SALT32.StrType)le.permissablelayout_dppa_purpose);
      clean_permissablelayout_dppa_purpose := (TYPEOF(le.permissablelayout_dppa_purpose))Fields.Make_permissablelayout_dppa_purpose((SALT32.StrType)le.permissablelayout_dppa_purpose);
      clean_permissablelayout_dppa_purpose_Invalid := Fields.InValid_permissablelayout_dppa_purpose((SALT32.StrType)clean_permissablelayout_dppa_purpose);
      SELF.permissablelayout_dppa_purpose := IF(withOnfail, clean_permissablelayout_dppa_purpose, le.permissablelayout_dppa_purpose); // ONFAIL(CLEAN)
    SELF.permissablelayout_fcra_purpose_Invalid := Fields.InValid_permissablelayout_fcra_purpose((SALT32.StrType)le.permissablelayout_fcra_purpose);
      clean_permissablelayout_fcra_purpose := (TYPEOF(le.permissablelayout_fcra_purpose))Fields.Make_permissablelayout_fcra_purpose((SALT32.StrType)le.permissablelayout_fcra_purpose);
      clean_permissablelayout_fcra_purpose_Invalid := Fields.InValid_permissablelayout_fcra_purpose((SALT32.StrType)clean_permissablelayout_fcra_purpose);
      SELF.permissablelayout_fcra_purpose := IF(withOnfail, clean_permissablelayout_fcra_purpose, le.permissablelayout_fcra_purpose); // ONFAIL(CLEAN)
    SELF.searchlayout_datetime_Invalid := Fields.InValid_searchlayout_datetime((SALT32.StrType)le.searchlayout_datetime);
      clean_searchlayout_datetime := (TYPEOF(le.searchlayout_datetime))Fields.Make_searchlayout_datetime((SALT32.StrType)le.searchlayout_datetime);
      clean_searchlayout_datetime_Invalid := Fields.InValid_searchlayout_datetime((SALT32.StrType)clean_searchlayout_datetime);
      SELF.searchlayout_datetime := IF(withOnfail, clean_searchlayout_datetime, le.searchlayout_datetime); // ONFAIL(CLEAN)
    SELF.searchlayout_start_monitor_Invalid := Fields.InValid_searchlayout_start_monitor((SALT32.StrType)le.searchlayout_start_monitor);
      clean_searchlayout_start_monitor := (TYPEOF(le.searchlayout_start_monitor))Fields.Make_searchlayout_start_monitor((SALT32.StrType)le.searchlayout_start_monitor);
      clean_searchlayout_start_monitor_Invalid := Fields.InValid_searchlayout_start_monitor((SALT32.StrType)clean_searchlayout_start_monitor);
      SELF.searchlayout_start_monitor := IF(withOnfail, clean_searchlayout_start_monitor, le.searchlayout_start_monitor); // ONFAIL(CLEAN)
    SELF.searchlayout_stop_monitor_Invalid := Fields.InValid_searchlayout_stop_monitor((SALT32.StrType)le.searchlayout_stop_monitor);
      clean_searchlayout_stop_monitor := (TYPEOF(le.searchlayout_stop_monitor))Fields.Make_searchlayout_stop_monitor((SALT32.StrType)le.searchlayout_stop_monitor);
      clean_searchlayout_stop_monitor_Invalid := Fields.InValid_searchlayout_stop_monitor((SALT32.StrType)clean_searchlayout_stop_monitor);
      SELF.searchlayout_stop_monitor := IF(withOnfail, clean_searchlayout_stop_monitor, le.searchlayout_stop_monitor); // ONFAIL(CLEAN)
    SELF.searchlayout_login_history_id_Invalid := Fields.InValid_searchlayout_login_history_id((SALT32.StrType)le.searchlayout_login_history_id);
      clean_searchlayout_login_history_id := (TYPEOF(le.searchlayout_login_history_id))Fields.Make_searchlayout_login_history_id((SALT32.StrType)le.searchlayout_login_history_id);
      clean_searchlayout_login_history_id_Invalid := Fields.InValid_searchlayout_login_history_id((SALT32.StrType)clean_searchlayout_login_history_id);
      SELF.searchlayout_login_history_id := IF(withOnfail, clean_searchlayout_login_history_id, le.searchlayout_login_history_id); // ONFAIL(CLEAN)
    SELF.searchlayout_transaction_id_Invalid := Fields.InValid_searchlayout_transaction_id((SALT32.StrType)le.searchlayout_transaction_id);
      clean_searchlayout_transaction_id := (TYPEOF(le.searchlayout_transaction_id))Fields.Make_searchlayout_transaction_id((SALT32.StrType)le.searchlayout_transaction_id);
      clean_searchlayout_transaction_id_Invalid := Fields.InValid_searchlayout_transaction_id((SALT32.StrType)clean_searchlayout_transaction_id);
      SELF.searchlayout_transaction_id := IF(withOnfail, clean_searchlayout_transaction_id, le.searchlayout_transaction_id); // ONFAIL(CLEAN)
    SELF.searchlayout_sequence_number_Invalid := Fields.InValid_searchlayout_sequence_number((SALT32.StrType)le.searchlayout_sequence_number);
      clean_searchlayout_sequence_number := (TYPEOF(le.searchlayout_sequence_number))Fields.Make_searchlayout_sequence_number((SALT32.StrType)le.searchlayout_sequence_number);
      clean_searchlayout_sequence_number_Invalid := Fields.InValid_searchlayout_sequence_number((SALT32.StrType)clean_searchlayout_sequence_number);
      SELF.searchlayout_sequence_number := IF(withOnfail, clean_searchlayout_sequence_number, le.searchlayout_sequence_number); // ONFAIL(CLEAN)
    SELF.searchlayout_method_Invalid := Fields.InValid_searchlayout_method((SALT32.StrType)le.searchlayout_method);
      clean_searchlayout_method := (TYPEOF(le.searchlayout_method))Fields.Make_searchlayout_method((SALT32.StrType)le.searchlayout_method);
      clean_searchlayout_method_Invalid := Fields.InValid_searchlayout_method((SALT32.StrType)clean_searchlayout_method);
      SELF.searchlayout_method := IF(withOnfail, clean_searchlayout_method, le.searchlayout_method); // ONFAIL(CLEAN)
    SELF.searchlayout_product_code_Invalid := Fields.InValid_searchlayout_product_code((SALT32.StrType)le.searchlayout_product_code);
      clean_searchlayout_product_code := (TYPEOF(le.searchlayout_product_code))Fields.Make_searchlayout_product_code((SALT32.StrType)le.searchlayout_product_code);
      clean_searchlayout_product_code_Invalid := Fields.InValid_searchlayout_product_code((SALT32.StrType)clean_searchlayout_product_code);
      SELF.searchlayout_product_code := IF(withOnfail, clean_searchlayout_product_code, le.searchlayout_product_code); // ONFAIL(CLEAN)
    SELF.searchlayout_transaction_type_Invalid := Fields.InValid_searchlayout_transaction_type((SALT32.StrType)le.searchlayout_transaction_type);
      clean_searchlayout_transaction_type := (TYPEOF(le.searchlayout_transaction_type))Fields.Make_searchlayout_transaction_type((SALT32.StrType)le.searchlayout_transaction_type);
      clean_searchlayout_transaction_type_Invalid := Fields.InValid_searchlayout_transaction_type((SALT32.StrType)clean_searchlayout_transaction_type);
      SELF.searchlayout_transaction_type := IF(withOnfail, clean_searchlayout_transaction_type, le.searchlayout_transaction_type); // ONFAIL(CLEAN)
    SELF.searchlayout_function_description_Invalid := Fields.InValid_searchlayout_function_description((SALT32.StrType)le.searchlayout_function_description);
      clean_searchlayout_function_description := (TYPEOF(le.searchlayout_function_description))Fields.Make_searchlayout_function_description((SALT32.StrType)le.searchlayout_function_description);
      clean_searchlayout_function_description_Invalid := Fields.InValid_searchlayout_function_description((SALT32.StrType)clean_searchlayout_function_description);
      SELF.searchlayout_function_description := IF(withOnfail, clean_searchlayout_function_description, le.searchlayout_function_description); // ONFAIL(CLEAN)
    SELF.searchlayout_ipaddr_Invalid := Fields.InValid_searchlayout_ipaddr((SALT32.StrType)le.searchlayout_ipaddr);
      clean_searchlayout_ipaddr := (TYPEOF(le.searchlayout_ipaddr))Fields.Make_searchlayout_ipaddr((SALT32.StrType)le.searchlayout_ipaddr);
      clean_searchlayout_ipaddr_Invalid := Fields.InValid_searchlayout_ipaddr((SALT32.StrType)clean_searchlayout_ipaddr);
      SELF.searchlayout_ipaddr := IF(withOnfail, clean_searchlayout_ipaddr, le.searchlayout_ipaddr); // ONFAIL(CLEAN)
    SELF.fraudpoint_score_Invalid := Fields.InValid_fraudpoint_score((SALT32.StrType)le.fraudpoint_score);
      clean_fraudpoint_score := (TYPEOF(le.fraudpoint_score))Fields.Make_fraudpoint_score((SALT32.StrType)le.fraudpoint_score);
      clean_fraudpoint_score_Invalid := Fields.InValid_fraudpoint_score((SALT32.StrType)clean_fraudpoint_score);
      SELF.fraudpoint_score := IF(withOnfail, clean_fraudpoint_score, le.fraudpoint_score); // ONFAIL(CLEAN)
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_File);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.mbslayout_company_id_Invalid << 0 ) + ( le.mbslayout_global_company_id_Invalid << 3 ) + ( le.allowlayout_allowflags_Invalid << 6 ) + ( le.businfolayout_primary_market_code_Invalid << 9 ) + ( le.businfolayout_secondary_market_code_Invalid << 12 ) + ( le.businfolayout_industry_1_code_Invalid << 15 ) + ( le.businfolayout_industry_2_code_Invalid << 18 ) + ( le.businfolayout_sub_market_Invalid << 21 ) + ( le.businfolayout_vertical_Invalid << 24 ) + ( le.businfolayout_use_Invalid << 27 ) + ( le.businfolayout_industry_Invalid << 30 ) + ( le.persondatalayout_full_name_Invalid << 33 ) + ( le.persondatalayout_first_name_Invalid << 36 ) + ( le.persondatalayout_middle_name_Invalid << 39 ) + ( le.persondatalayout_last_name_Invalid << 42 ) + ( le.persondatalayout_address_Invalid << 45 ) + ( le.persondatalayout_city_Invalid << 48 ) + ( le.persondatalayout_state_Invalid << 51 ) + ( le.persondatalayout_zip_Invalid << 54 ) + ( le.persondatalayout_personal_phone_Invalid << 57 ) + ( le.persondatalayout_work_phone_Invalid << 59 ) + ( le.persondatalayout_dob_Invalid << 61 );
    SELF.ScrubsBits2 := ( le.persondatalayout_dl_Invalid << 0 ) + ( le.persondatalayout_dl_st_Invalid << 3 ) + ( le.persondatalayout_email_address_Invalid << 6 ) + ( le.persondatalayout_ssn_Invalid << 9 ) + ( le.persondatalayout_linkid_Invalid << 11 ) + ( le.persondatalayout_ipaddr_Invalid << 14 ) + ( le.persondatalayout_title_Invalid << 17 ) + ( le.persondatalayout_fname_Invalid << 20 ) + ( le.persondatalayout_mname_Invalid << 22 ) + ( le.persondatalayout_lname_Invalid << 24 ) + ( le.persondatalayout_name_suffix_Invalid << 27 ) + ( le.persondatalayout_prim_range_Invalid << 29 ) + ( le.persondatalayout_predir_Invalid << 32 ) + ( le.persondatalayout_prim_name_Invalid << 35 ) + ( le.persondatalayout_addr_suffix_Invalid << 38 ) + ( le.persondatalayout_postdir_Invalid << 41 ) + ( le.persondatalayout_unit_desig_Invalid << 44 ) + ( le.persondatalayout_sec_range_Invalid << 47 ) + ( le.persondatalayout_v_city_name_Invalid << 50 ) + ( le.persondatalayout_st_Invalid << 53 ) + ( le.persondatalayout_zip5_Invalid << 56 ) + ( le.persondatalayout_zip4_Invalid << 59 );
    SELF.ScrubsBits3 := ( le.persondatalayout_addr_rec_type_Invalid << 0 ) + ( le.persondatalayout_fips_state_Invalid << 3 ) + ( le.persondatalayout_fips_county_Invalid << 6 ) + ( le.persondatalayout_geo_lat_Invalid << 9 ) + ( le.persondatalayout_geo_long_Invalid << 12 ) + ( le.persondatalayout_cbsa_Invalid << 15 ) + ( le.persondatalayout_geo_blk_Invalid << 18 ) + ( le.persondatalayout_geo_match_Invalid << 21 ) + ( le.persondatalayout_err_stat_Invalid << 24 ) + ( le.persondatalayout_appended_ssn_Invalid << 27 ) + ( le.persondatalayout_appended_adl_Invalid << 30 ) + ( le.permissablelayout_glb_purpose_Invalid << 33 ) + ( le.permissablelayout_dppa_purpose_Invalid << 36 ) + ( le.permissablelayout_fcra_purpose_Invalid << 39 ) + ( le.searchlayout_datetime_Invalid << 42 ) + ( le.searchlayout_start_monitor_Invalid << 45 ) + ( le.searchlayout_stop_monitor_Invalid << 48 ) + ( le.searchlayout_login_history_id_Invalid << 51 ) + ( le.searchlayout_transaction_id_Invalid << 54 ) + ( le.searchlayout_sequence_number_Invalid << 57 ) + ( le.searchlayout_method_Invalid << 60 );
    SELF.ScrubsBits4 := ( le.searchlayout_product_code_Invalid << 0 ) + ( le.searchlayout_transaction_type_Invalid << 3 ) + ( le.searchlayout_function_description_Invalid << 6 ) + ( le.searchlayout_ipaddr_Invalid << 9 ) + ( le.fraudpoint_score_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_File);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.mbslayout_company_id_Invalid := (le.ScrubsBits1 >> 0) & 7;
    SELF.mbslayout_global_company_id_Invalid := (le.ScrubsBits1 >> 3) & 7;
    SELF.allowlayout_allowflags_Invalid := (le.ScrubsBits1 >> 6) & 7;
    SELF.businfolayout_primary_market_code_Invalid := (le.ScrubsBits1 >> 9) & 7;
    SELF.businfolayout_secondary_market_code_Invalid := (le.ScrubsBits1 >> 12) & 7;
    SELF.businfolayout_industry_1_code_Invalid := (le.ScrubsBits1 >> 15) & 7;
    SELF.businfolayout_industry_2_code_Invalid := (le.ScrubsBits1 >> 18) & 7;
    SELF.businfolayout_sub_market_Invalid := (le.ScrubsBits1 >> 21) & 7;
    SELF.businfolayout_vertical_Invalid := (le.ScrubsBits1 >> 24) & 7;
    SELF.businfolayout_use_Invalid := (le.ScrubsBits1 >> 27) & 7;
    SELF.businfolayout_industry_Invalid := (le.ScrubsBits1 >> 30) & 7;
    SELF.persondatalayout_full_name_Invalid := (le.ScrubsBits1 >> 33) & 7;
    SELF.persondatalayout_first_name_Invalid := (le.ScrubsBits1 >> 36) & 7;
    SELF.persondatalayout_middle_name_Invalid := (le.ScrubsBits1 >> 39) & 7;
    SELF.persondatalayout_last_name_Invalid := (le.ScrubsBits1 >> 42) & 7;
    SELF.persondatalayout_address_Invalid := (le.ScrubsBits1 >> 45) & 7;
    SELF.persondatalayout_city_Invalid := (le.ScrubsBits1 >> 48) & 7;
    SELF.persondatalayout_state_Invalid := (le.ScrubsBits1 >> 51) & 7;
    SELF.persondatalayout_zip_Invalid := (le.ScrubsBits1 >> 54) & 7;
    SELF.persondatalayout_personal_phone_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.persondatalayout_work_phone_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF.persondatalayout_dob_Invalid := (le.ScrubsBits1 >> 61) & 7;
    SELF.persondatalayout_dl_Invalid := (le.ScrubsBits2 >> 0) & 7;
    SELF.persondatalayout_dl_st_Invalid := (le.ScrubsBits2 >> 3) & 7;
    SELF.persondatalayout_email_address_Invalid := (le.ScrubsBits2 >> 6) & 7;
    SELF.persondatalayout_ssn_Invalid := (le.ScrubsBits2 >> 9) & 3;
    SELF.persondatalayout_linkid_Invalid := (le.ScrubsBits2 >> 11) & 7;
    SELF.persondatalayout_ipaddr_Invalid := (le.ScrubsBits2 >> 14) & 7;
    SELF.persondatalayout_title_Invalid := (le.ScrubsBits2 >> 17) & 7;
    SELF.persondatalayout_fname_Invalid := (le.ScrubsBits2 >> 20) & 3;
    SELF.persondatalayout_mname_Invalid := (le.ScrubsBits2 >> 22) & 3;
    SELF.persondatalayout_lname_Invalid := (le.ScrubsBits2 >> 24) & 7;
    SELF.persondatalayout_name_suffix_Invalid := (le.ScrubsBits2 >> 27) & 3;
    SELF.persondatalayout_prim_range_Invalid := (le.ScrubsBits2 >> 29) & 7;
    SELF.persondatalayout_predir_Invalid := (le.ScrubsBits2 >> 32) & 7;
    SELF.persondatalayout_prim_name_Invalid := (le.ScrubsBits2 >> 35) & 7;
    SELF.persondatalayout_addr_suffix_Invalid := (le.ScrubsBits2 >> 38) & 7;
    SELF.persondatalayout_postdir_Invalid := (le.ScrubsBits2 >> 41) & 7;
    SELF.persondatalayout_unit_desig_Invalid := (le.ScrubsBits2 >> 44) & 7;
    SELF.persondatalayout_sec_range_Invalid := (le.ScrubsBits2 >> 47) & 7;
    SELF.persondatalayout_v_city_name_Invalid := (le.ScrubsBits2 >> 50) & 7;
    SELF.persondatalayout_st_Invalid := (le.ScrubsBits2 >> 53) & 7;
    SELF.persondatalayout_zip5_Invalid := (le.ScrubsBits2 >> 56) & 7;
    SELF.persondatalayout_zip4_Invalid := (le.ScrubsBits2 >> 59) & 7;
    SELF.persondatalayout_addr_rec_type_Invalid := (le.ScrubsBits3 >> 0) & 7;
    SELF.persondatalayout_fips_state_Invalid := (le.ScrubsBits3 >> 3) & 7;
    SELF.persondatalayout_fips_county_Invalid := (le.ScrubsBits3 >> 6) & 7;
    SELF.persondatalayout_geo_lat_Invalid := (le.ScrubsBits3 >> 9) & 7;
    SELF.persondatalayout_geo_long_Invalid := (le.ScrubsBits3 >> 12) & 7;
    SELF.persondatalayout_cbsa_Invalid := (le.ScrubsBits3 >> 15) & 7;
    SELF.persondatalayout_geo_blk_Invalid := (le.ScrubsBits3 >> 18) & 7;
    SELF.persondatalayout_geo_match_Invalid := (le.ScrubsBits3 >> 21) & 7;
    SELF.persondatalayout_err_stat_Invalid := (le.ScrubsBits3 >> 24) & 7;
    SELF.persondatalayout_appended_ssn_Invalid := (le.ScrubsBits3 >> 27) & 7;
    SELF.persondatalayout_appended_adl_Invalid := (le.ScrubsBits3 >> 30) & 7;
    SELF.permissablelayout_glb_purpose_Invalid := (le.ScrubsBits3 >> 33) & 7;
    SELF.permissablelayout_dppa_purpose_Invalid := (le.ScrubsBits3 >> 36) & 7;
    SELF.permissablelayout_fcra_purpose_Invalid := (le.ScrubsBits3 >> 39) & 7;
    SELF.searchlayout_datetime_Invalid := (le.ScrubsBits3 >> 42) & 7;
    SELF.searchlayout_start_monitor_Invalid := (le.ScrubsBits3 >> 45) & 7;
    SELF.searchlayout_stop_monitor_Invalid := (le.ScrubsBits3 >> 48) & 7;
    SELF.searchlayout_login_history_id_Invalid := (le.ScrubsBits3 >> 51) & 7;
    SELF.searchlayout_transaction_id_Invalid := (le.ScrubsBits3 >> 54) & 7;
    SELF.searchlayout_sequence_number_Invalid := (le.ScrubsBits3 >> 57) & 7;
    SELF.searchlayout_method_Invalid := (le.ScrubsBits3 >> 60) & 7;
    SELF.searchlayout_product_code_Invalid := (le.ScrubsBits4 >> 0) & 7;
    SELF.searchlayout_transaction_type_Invalid := (le.ScrubsBits4 >> 3) & 7;
    SELF.searchlayout_function_description_Invalid := (le.ScrubsBits4 >> 6) & 7;
    SELF.searchlayout_ipaddr_Invalid := (le.ScrubsBits4 >> 9) & 7;
    SELF.fraudpoint_score_Invalid := (le.ScrubsBits4 >> 12) & 7;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    mbslayout_company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mbslayout_company_id_Invalid=1);
    mbslayout_company_id_ALLOW_ErrorCount := COUNT(GROUP,h.mbslayout_company_id_Invalid=2);
    mbslayout_company_id_LENGTH_ErrorCount := COUNT(GROUP,h.mbslayout_company_id_Invalid=3);
    mbslayout_company_id_WORDS_ErrorCount := COUNT(GROUP,h.mbslayout_company_id_Invalid=4);
    mbslayout_company_id_Total_ErrorCount := COUNT(GROUP,h.mbslayout_company_id_Invalid>0);
    mbslayout_global_company_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.mbslayout_global_company_id_Invalid=1);
    mbslayout_global_company_id_ALLOW_ErrorCount := COUNT(GROUP,h.mbslayout_global_company_id_Invalid=2);
    mbslayout_global_company_id_LENGTH_ErrorCount := COUNT(GROUP,h.mbslayout_global_company_id_Invalid=3);
    mbslayout_global_company_id_WORDS_ErrorCount := COUNT(GROUP,h.mbslayout_global_company_id_Invalid=4);
    mbslayout_global_company_id_Total_ErrorCount := COUNT(GROUP,h.mbslayout_global_company_id_Invalid>0);
    allowlayout_allowflags_LEFTTRIM_ErrorCount := COUNT(GROUP,h.allowlayout_allowflags_Invalid=1);
    allowlayout_allowflags_ALLOW_ErrorCount := COUNT(GROUP,h.allowlayout_allowflags_Invalid=2);
    allowlayout_allowflags_LENGTH_ErrorCount := COUNT(GROUP,h.allowlayout_allowflags_Invalid=3);
    allowlayout_allowflags_WORDS_ErrorCount := COUNT(GROUP,h.allowlayout_allowflags_Invalid=4);
    allowlayout_allowflags_Total_ErrorCount := COUNT(GROUP,h.allowlayout_allowflags_Invalid>0);
    businfolayout_primary_market_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.businfolayout_primary_market_code_Invalid=1);
    businfolayout_primary_market_code_ALLOW_ErrorCount := COUNT(GROUP,h.businfolayout_primary_market_code_Invalid=2);
    businfolayout_primary_market_code_LENGTH_ErrorCount := COUNT(GROUP,h.businfolayout_primary_market_code_Invalid=3);
    businfolayout_primary_market_code_WORDS_ErrorCount := COUNT(GROUP,h.businfolayout_primary_market_code_Invalid=4);
    businfolayout_primary_market_code_Total_ErrorCount := COUNT(GROUP,h.businfolayout_primary_market_code_Invalid>0);
    businfolayout_secondary_market_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.businfolayout_secondary_market_code_Invalid=1);
    businfolayout_secondary_market_code_ALLOW_ErrorCount := COUNT(GROUP,h.businfolayout_secondary_market_code_Invalid=2);
    businfolayout_secondary_market_code_LENGTH_ErrorCount := COUNT(GROUP,h.businfolayout_secondary_market_code_Invalid=3);
    businfolayout_secondary_market_code_WORDS_ErrorCount := COUNT(GROUP,h.businfolayout_secondary_market_code_Invalid=4);
    businfolayout_secondary_market_code_Total_ErrorCount := COUNT(GROUP,h.businfolayout_secondary_market_code_Invalid>0);
    businfolayout_industry_1_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.businfolayout_industry_1_code_Invalid=1);
    businfolayout_industry_1_code_ALLOW_ErrorCount := COUNT(GROUP,h.businfolayout_industry_1_code_Invalid=2);
    businfolayout_industry_1_code_LENGTH_ErrorCount := COUNT(GROUP,h.businfolayout_industry_1_code_Invalid=3);
    businfolayout_industry_1_code_WORDS_ErrorCount := COUNT(GROUP,h.businfolayout_industry_1_code_Invalid=4);
    businfolayout_industry_1_code_Total_ErrorCount := COUNT(GROUP,h.businfolayout_industry_1_code_Invalid>0);
    businfolayout_industry_2_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.businfolayout_industry_2_code_Invalid=1);
    businfolayout_industry_2_code_ALLOW_ErrorCount := COUNT(GROUP,h.businfolayout_industry_2_code_Invalid=2);
    businfolayout_industry_2_code_LENGTH_ErrorCount := COUNT(GROUP,h.businfolayout_industry_2_code_Invalid=3);
    businfolayout_industry_2_code_WORDS_ErrorCount := COUNT(GROUP,h.businfolayout_industry_2_code_Invalid=4);
    businfolayout_industry_2_code_Total_ErrorCount := COUNT(GROUP,h.businfolayout_industry_2_code_Invalid>0);
    businfolayout_sub_market_LEFTTRIM_ErrorCount := COUNT(GROUP,h.businfolayout_sub_market_Invalid=1);
    businfolayout_sub_market_ALLOW_ErrorCount := COUNT(GROUP,h.businfolayout_sub_market_Invalid=2);
    businfolayout_sub_market_LENGTH_ErrorCount := COUNT(GROUP,h.businfolayout_sub_market_Invalid=3);
    businfolayout_sub_market_WORDS_ErrorCount := COUNT(GROUP,h.businfolayout_sub_market_Invalid=4);
    businfolayout_sub_market_Total_ErrorCount := COUNT(GROUP,h.businfolayout_sub_market_Invalid>0);
    businfolayout_vertical_LEFTTRIM_ErrorCount := COUNT(GROUP,h.businfolayout_vertical_Invalid=1);
    businfolayout_vertical_ALLOW_ErrorCount := COUNT(GROUP,h.businfolayout_vertical_Invalid=2);
    businfolayout_vertical_LENGTH_ErrorCount := COUNT(GROUP,h.businfolayout_vertical_Invalid=3);
    businfolayout_vertical_WORDS_ErrorCount := COUNT(GROUP,h.businfolayout_vertical_Invalid=4);
    businfolayout_vertical_Total_ErrorCount := COUNT(GROUP,h.businfolayout_vertical_Invalid>0);
    businfolayout_use_LEFTTRIM_ErrorCount := COUNT(GROUP,h.businfolayout_use_Invalid=1);
    businfolayout_use_ALLOW_ErrorCount := COUNT(GROUP,h.businfolayout_use_Invalid=2);
    businfolayout_use_LENGTH_ErrorCount := COUNT(GROUP,h.businfolayout_use_Invalid=3);
    businfolayout_use_WORDS_ErrorCount := COUNT(GROUP,h.businfolayout_use_Invalid=4);
    businfolayout_use_Total_ErrorCount := COUNT(GROUP,h.businfolayout_use_Invalid>0);
    businfolayout_industry_LEFTTRIM_ErrorCount := COUNT(GROUP,h.businfolayout_industry_Invalid=1);
    businfolayout_industry_ALLOW_ErrorCount := COUNT(GROUP,h.businfolayout_industry_Invalid=2);
    businfolayout_industry_LENGTH_ErrorCount := COUNT(GROUP,h.businfolayout_industry_Invalid=3);
    businfolayout_industry_WORDS_ErrorCount := COUNT(GROUP,h.businfolayout_industry_Invalid=4);
    businfolayout_industry_Total_ErrorCount := COUNT(GROUP,h.businfolayout_industry_Invalid>0);
    persondatalayout_full_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_full_name_Invalid=1);
    persondatalayout_full_name_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_full_name_Invalid=2);
    persondatalayout_full_name_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_full_name_Invalid=3);
    persondatalayout_full_name_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_full_name_Invalid=4);
    persondatalayout_full_name_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_full_name_Invalid>0);
    persondatalayout_first_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_first_name_Invalid=1);
    persondatalayout_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_first_name_Invalid=2);
    persondatalayout_first_name_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_first_name_Invalid=3);
    persondatalayout_first_name_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_first_name_Invalid=4);
    persondatalayout_first_name_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_first_name_Invalid>0);
    persondatalayout_middle_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_middle_name_Invalid=1);
    persondatalayout_middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_middle_name_Invalid=2);
    persondatalayout_middle_name_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_middle_name_Invalid=3);
    persondatalayout_middle_name_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_middle_name_Invalid=4);
    persondatalayout_middle_name_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_middle_name_Invalid>0);
    persondatalayout_last_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_last_name_Invalid=1);
    persondatalayout_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_last_name_Invalid=2);
    persondatalayout_last_name_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_last_name_Invalid=3);
    persondatalayout_last_name_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_last_name_Invalid=4);
    persondatalayout_last_name_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_last_name_Invalid>0);
    persondatalayout_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_address_Invalid=1);
    persondatalayout_address_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_address_Invalid=2);
    persondatalayout_address_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_address_Invalid=3);
    persondatalayout_address_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_address_Invalid=4);
    persondatalayout_address_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_address_Invalid>0);
    persondatalayout_city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_city_Invalid=1);
    persondatalayout_city_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_city_Invalid=2);
    persondatalayout_city_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_city_Invalid=3);
    persondatalayout_city_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_city_Invalid=4);
    persondatalayout_city_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_city_Invalid>0);
    persondatalayout_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_state_Invalid=1);
    persondatalayout_state_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_state_Invalid=2);
    persondatalayout_state_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_state_Invalid=3);
    persondatalayout_state_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_state_Invalid=4);
    persondatalayout_state_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_state_Invalid>0);
    persondatalayout_zip_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_zip_Invalid=1);
    persondatalayout_zip_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_zip_Invalid=2);
    persondatalayout_zip_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_zip_Invalid=3);
    persondatalayout_zip_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_zip_Invalid=4);
    persondatalayout_zip_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_zip_Invalid>0);
    persondatalayout_personal_phone_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_personal_phone_Invalid=1);
    persondatalayout_personal_phone_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_personal_phone_Invalid=2);
    persondatalayout_personal_phone_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_personal_phone_Invalid=3);
    persondatalayout_personal_phone_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_personal_phone_Invalid>0);
    persondatalayout_work_phone_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_work_phone_Invalid=1);
    persondatalayout_work_phone_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_work_phone_Invalid=2);
    persondatalayout_work_phone_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_work_phone_Invalid=3);
    persondatalayout_work_phone_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_work_phone_Invalid>0);
    persondatalayout_dob_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_dob_Invalid=1);
    persondatalayout_dob_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_dob_Invalid=2);
    persondatalayout_dob_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_dob_Invalid=3);
    persondatalayout_dob_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_dob_Invalid=4);
    persondatalayout_dob_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_dob_Invalid>0);
    persondatalayout_dl_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_Invalid=1);
    persondatalayout_dl_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_Invalid=2);
    persondatalayout_dl_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_Invalid=3);
    persondatalayout_dl_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_Invalid=4);
    persondatalayout_dl_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_Invalid>0);
    persondatalayout_dl_st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_st_Invalid=1);
    persondatalayout_dl_st_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_st_Invalid=2);
    persondatalayout_dl_st_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_st_Invalid=3);
    persondatalayout_dl_st_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_st_Invalid=4);
    persondatalayout_dl_st_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_dl_st_Invalid>0);
    persondatalayout_email_address_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_email_address_Invalid=1);
    persondatalayout_email_address_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_email_address_Invalid=2);
    persondatalayout_email_address_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_email_address_Invalid=3);
    persondatalayout_email_address_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_email_address_Invalid=4);
    persondatalayout_email_address_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_email_address_Invalid>0);
    persondatalayout_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_ssn_Invalid=1);
    persondatalayout_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_ssn_Invalid=2);
    persondatalayout_ssn_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_ssn_Invalid=3);
    persondatalayout_ssn_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_ssn_Invalid>0);
    persondatalayout_linkid_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_linkid_Invalid=1);
    persondatalayout_linkid_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_linkid_Invalid=2);
    persondatalayout_linkid_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_linkid_Invalid=3);
    persondatalayout_linkid_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_linkid_Invalid=4);
    persondatalayout_linkid_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_linkid_Invalid>0);
    persondatalayout_ipaddr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_ipaddr_Invalid=1);
    persondatalayout_ipaddr_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_ipaddr_Invalid=2);
    persondatalayout_ipaddr_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_ipaddr_Invalid=3);
    persondatalayout_ipaddr_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_ipaddr_Invalid=4);
    persondatalayout_ipaddr_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_ipaddr_Invalid>0);
    persondatalayout_title_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_title_Invalid=1);
    persondatalayout_title_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_title_Invalid=2);
    persondatalayout_title_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_title_Invalid=3);
    persondatalayout_title_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_title_Invalid=4);
    persondatalayout_title_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_title_Invalid>0);
    persondatalayout_fname_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_fname_Invalid=1);
    persondatalayout_fname_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_fname_Invalid=2);
    persondatalayout_fname_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_fname_Invalid=3);
    persondatalayout_fname_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_fname_Invalid>0);
    persondatalayout_mname_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_mname_Invalid=1);
    persondatalayout_mname_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_mname_Invalid=2);
    persondatalayout_mname_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_mname_Invalid=3);
    persondatalayout_mname_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_mname_Invalid>0);
    persondatalayout_lname_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_lname_Invalid=1);
    persondatalayout_lname_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_lname_Invalid=2);
    persondatalayout_lname_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_lname_Invalid=3);
    persondatalayout_lname_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_lname_Invalid=4);
    persondatalayout_lname_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_lname_Invalid>0);
    persondatalayout_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_name_suffix_Invalid=1);
    persondatalayout_name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_name_suffix_Invalid=2);
    persondatalayout_name_suffix_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_name_suffix_Invalid=3);
    persondatalayout_name_suffix_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_name_suffix_Invalid>0);
    persondatalayout_prim_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_range_Invalid=1);
    persondatalayout_prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_range_Invalid=2);
    persondatalayout_prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_range_Invalid=3);
    persondatalayout_prim_range_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_range_Invalid=4);
    persondatalayout_prim_range_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_range_Invalid>0);
    persondatalayout_predir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_predir_Invalid=1);
    persondatalayout_predir_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_predir_Invalid=2);
    persondatalayout_predir_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_predir_Invalid=3);
    persondatalayout_predir_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_predir_Invalid=4);
    persondatalayout_predir_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_predir_Invalid>0);
    persondatalayout_prim_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_name_Invalid=1);
    persondatalayout_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_name_Invalid=2);
    persondatalayout_prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_name_Invalid=3);
    persondatalayout_prim_name_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_name_Invalid=4);
    persondatalayout_prim_name_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_prim_name_Invalid>0);
    persondatalayout_addr_suffix_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_suffix_Invalid=1);
    persondatalayout_addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_suffix_Invalid=2);
    persondatalayout_addr_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_suffix_Invalid=3);
    persondatalayout_addr_suffix_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_suffix_Invalid=4);
    persondatalayout_addr_suffix_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_suffix_Invalid>0);
    persondatalayout_postdir_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_postdir_Invalid=1);
    persondatalayout_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_postdir_Invalid=2);
    persondatalayout_postdir_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_postdir_Invalid=3);
    persondatalayout_postdir_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_postdir_Invalid=4);
    persondatalayout_postdir_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_postdir_Invalid>0);
    persondatalayout_unit_desig_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_unit_desig_Invalid=1);
    persondatalayout_unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_unit_desig_Invalid=2);
    persondatalayout_unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_unit_desig_Invalid=3);
    persondatalayout_unit_desig_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_unit_desig_Invalid=4);
    persondatalayout_unit_desig_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_unit_desig_Invalid>0);
    persondatalayout_sec_range_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_sec_range_Invalid=1);
    persondatalayout_sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_sec_range_Invalid=2);
    persondatalayout_sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_sec_range_Invalid=3);
    persondatalayout_sec_range_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_sec_range_Invalid=4);
    persondatalayout_sec_range_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_sec_range_Invalid>0);
    persondatalayout_v_city_name_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_v_city_name_Invalid=1);
    persondatalayout_v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_v_city_name_Invalid=2);
    persondatalayout_v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_v_city_name_Invalid=3);
    persondatalayout_v_city_name_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_v_city_name_Invalid=4);
    persondatalayout_v_city_name_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_v_city_name_Invalid>0);
    persondatalayout_st_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_st_Invalid=1);
    persondatalayout_st_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_st_Invalid=2);
    persondatalayout_st_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_st_Invalid=3);
    persondatalayout_st_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_st_Invalid=4);
    persondatalayout_st_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_st_Invalid>0);
    persondatalayout_zip5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_zip5_Invalid=1);
    persondatalayout_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_zip5_Invalid=2);
    persondatalayout_zip5_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_zip5_Invalid=3);
    persondatalayout_zip5_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_zip5_Invalid=4);
    persondatalayout_zip5_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_zip5_Invalid>0);
    persondatalayout_zip4_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_zip4_Invalid=1);
    persondatalayout_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_zip4_Invalid=2);
    persondatalayout_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_zip4_Invalid=3);
    persondatalayout_zip4_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_zip4_Invalid=4);
    persondatalayout_zip4_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_zip4_Invalid>0);
    persondatalayout_addr_rec_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_rec_type_Invalid=1);
    persondatalayout_addr_rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_rec_type_Invalid=2);
    persondatalayout_addr_rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_rec_type_Invalid=3);
    persondatalayout_addr_rec_type_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_rec_type_Invalid=4);
    persondatalayout_addr_rec_type_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_addr_rec_type_Invalid>0);
    persondatalayout_fips_state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_state_Invalid=1);
    persondatalayout_fips_state_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_state_Invalid=2);
    persondatalayout_fips_state_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_state_Invalid=3);
    persondatalayout_fips_state_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_state_Invalid=4);
    persondatalayout_fips_state_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_state_Invalid>0);
    persondatalayout_fips_county_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_county_Invalid=1);
    persondatalayout_fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_county_Invalid=2);
    persondatalayout_fips_county_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_county_Invalid=3);
    persondatalayout_fips_county_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_county_Invalid=4);
    persondatalayout_fips_county_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_fips_county_Invalid>0);
    persondatalayout_geo_lat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_lat_Invalid=1);
    persondatalayout_geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_lat_Invalid=2);
    persondatalayout_geo_lat_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_lat_Invalid=3);
    persondatalayout_geo_lat_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_lat_Invalid=4);
    persondatalayout_geo_lat_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_lat_Invalid>0);
    persondatalayout_geo_long_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_long_Invalid=1);
    persondatalayout_geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_long_Invalid=2);
    persondatalayout_geo_long_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_long_Invalid=3);
    persondatalayout_geo_long_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_long_Invalid=4);
    persondatalayout_geo_long_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_long_Invalid>0);
    persondatalayout_cbsa_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_cbsa_Invalid=1);
    persondatalayout_cbsa_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_cbsa_Invalid=2);
    persondatalayout_cbsa_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_cbsa_Invalid=3);
    persondatalayout_cbsa_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_cbsa_Invalid=4);
    persondatalayout_cbsa_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_cbsa_Invalid>0);
    persondatalayout_geo_blk_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_blk_Invalid=1);
    persondatalayout_geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_blk_Invalid=2);
    persondatalayout_geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_blk_Invalid=3);
    persondatalayout_geo_blk_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_blk_Invalid=4);
    persondatalayout_geo_blk_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_blk_Invalid>0);
    persondatalayout_geo_match_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_match_Invalid=1);
    persondatalayout_geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_match_Invalid=2);
    persondatalayout_geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_match_Invalid=3);
    persondatalayout_geo_match_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_match_Invalid=4);
    persondatalayout_geo_match_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_geo_match_Invalid>0);
    persondatalayout_err_stat_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_err_stat_Invalid=1);
    persondatalayout_err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_err_stat_Invalid=2);
    persondatalayout_err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_err_stat_Invalid=3);
    persondatalayout_err_stat_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_err_stat_Invalid=4);
    persondatalayout_err_stat_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_err_stat_Invalid>0);
    persondatalayout_appended_ssn_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_ssn_Invalid=1);
    persondatalayout_appended_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_ssn_Invalid=2);
    persondatalayout_appended_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_ssn_Invalid=3);
    persondatalayout_appended_ssn_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_ssn_Invalid=4);
    persondatalayout_appended_ssn_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_ssn_Invalid>0);
    persondatalayout_appended_adl_LEFTTRIM_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_adl_Invalid=1);
    persondatalayout_appended_adl_ALLOW_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_adl_Invalid=2);
    persondatalayout_appended_adl_LENGTH_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_adl_Invalid=3);
    persondatalayout_appended_adl_WORDS_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_adl_Invalid=4);
    persondatalayout_appended_adl_Total_ErrorCount := COUNT(GROUP,h.persondatalayout_appended_adl_Invalid>0);
    permissablelayout_glb_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.permissablelayout_glb_purpose_Invalid=1);
    permissablelayout_glb_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.permissablelayout_glb_purpose_Invalid=2);
    permissablelayout_glb_purpose_LENGTH_ErrorCount := COUNT(GROUP,h.permissablelayout_glb_purpose_Invalid=3);
    permissablelayout_glb_purpose_WORDS_ErrorCount := COUNT(GROUP,h.permissablelayout_glb_purpose_Invalid=4);
    permissablelayout_glb_purpose_Total_ErrorCount := COUNT(GROUP,h.permissablelayout_glb_purpose_Invalid>0);
    permissablelayout_dppa_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.permissablelayout_dppa_purpose_Invalid=1);
    permissablelayout_dppa_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.permissablelayout_dppa_purpose_Invalid=2);
    permissablelayout_dppa_purpose_LENGTH_ErrorCount := COUNT(GROUP,h.permissablelayout_dppa_purpose_Invalid=3);
    permissablelayout_dppa_purpose_WORDS_ErrorCount := COUNT(GROUP,h.permissablelayout_dppa_purpose_Invalid=4);
    permissablelayout_dppa_purpose_Total_ErrorCount := COUNT(GROUP,h.permissablelayout_dppa_purpose_Invalid>0);
    permissablelayout_fcra_purpose_LEFTTRIM_ErrorCount := COUNT(GROUP,h.permissablelayout_fcra_purpose_Invalid=1);
    permissablelayout_fcra_purpose_ALLOW_ErrorCount := COUNT(GROUP,h.permissablelayout_fcra_purpose_Invalid=2);
    permissablelayout_fcra_purpose_LENGTH_ErrorCount := COUNT(GROUP,h.permissablelayout_fcra_purpose_Invalid=3);
    permissablelayout_fcra_purpose_WORDS_ErrorCount := COUNT(GROUP,h.permissablelayout_fcra_purpose_Invalid=4);
    permissablelayout_fcra_purpose_Total_ErrorCount := COUNT(GROUP,h.permissablelayout_fcra_purpose_Invalid>0);
    searchlayout_datetime_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_datetime_Invalid=1);
    searchlayout_datetime_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_datetime_Invalid=2);
    searchlayout_datetime_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_datetime_Invalid=3);
    searchlayout_datetime_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_datetime_Invalid=4);
    searchlayout_datetime_Total_ErrorCount := COUNT(GROUP,h.searchlayout_datetime_Invalid>0);
    searchlayout_start_monitor_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_start_monitor_Invalid=1);
    searchlayout_start_monitor_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_start_monitor_Invalid=2);
    searchlayout_start_monitor_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_start_monitor_Invalid=3);
    searchlayout_start_monitor_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_start_monitor_Invalid=4);
    searchlayout_start_monitor_Total_ErrorCount := COUNT(GROUP,h.searchlayout_start_monitor_Invalid>0);
    searchlayout_stop_monitor_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_stop_monitor_Invalid=1);
    searchlayout_stop_monitor_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_stop_monitor_Invalid=2);
    searchlayout_stop_monitor_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_stop_monitor_Invalid=3);
    searchlayout_stop_monitor_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_stop_monitor_Invalid=4);
    searchlayout_stop_monitor_Total_ErrorCount := COUNT(GROUP,h.searchlayout_stop_monitor_Invalid>0);
    searchlayout_login_history_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_login_history_id_Invalid=1);
    searchlayout_login_history_id_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_login_history_id_Invalid=2);
    searchlayout_login_history_id_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_login_history_id_Invalid=3);
    searchlayout_login_history_id_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_login_history_id_Invalid=4);
    searchlayout_login_history_id_Total_ErrorCount := COUNT(GROUP,h.searchlayout_login_history_id_Invalid>0);
    searchlayout_transaction_id_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_id_Invalid=1);
    searchlayout_transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_id_Invalid=2);
    searchlayout_transaction_id_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_id_Invalid=3);
    searchlayout_transaction_id_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_id_Invalid=4);
    searchlayout_transaction_id_Total_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_id_Invalid>0);
    searchlayout_sequence_number_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_sequence_number_Invalid=1);
    searchlayout_sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_sequence_number_Invalid=2);
    searchlayout_sequence_number_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_sequence_number_Invalid=3);
    searchlayout_sequence_number_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_sequence_number_Invalid=4);
    searchlayout_sequence_number_Total_ErrorCount := COUNT(GROUP,h.searchlayout_sequence_number_Invalid>0);
    searchlayout_method_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_method_Invalid=1);
    searchlayout_method_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_method_Invalid=2);
    searchlayout_method_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_method_Invalid=3);
    searchlayout_method_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_method_Invalid=4);
    searchlayout_method_Total_ErrorCount := COUNT(GROUP,h.searchlayout_method_Invalid>0);
    searchlayout_product_code_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_product_code_Invalid=1);
    searchlayout_product_code_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_product_code_Invalid=2);
    searchlayout_product_code_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_product_code_Invalid=3);
    searchlayout_product_code_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_product_code_Invalid=4);
    searchlayout_product_code_Total_ErrorCount := COUNT(GROUP,h.searchlayout_product_code_Invalid>0);
    searchlayout_transaction_type_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_type_Invalid=1);
    searchlayout_transaction_type_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_type_Invalid=2);
    searchlayout_transaction_type_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_type_Invalid=3);
    searchlayout_transaction_type_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_type_Invalid=4);
    searchlayout_transaction_type_Total_ErrorCount := COUNT(GROUP,h.searchlayout_transaction_type_Invalid>0);
    searchlayout_function_description_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_function_description_Invalid=1);
    searchlayout_function_description_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_function_description_Invalid=2);
    searchlayout_function_description_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_function_description_Invalid=3);
    searchlayout_function_description_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_function_description_Invalid=4);
    searchlayout_function_description_Total_ErrorCount := COUNT(GROUP,h.searchlayout_function_description_Invalid>0);
    searchlayout_ipaddr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.searchlayout_ipaddr_Invalid=1);
    searchlayout_ipaddr_ALLOW_ErrorCount := COUNT(GROUP,h.searchlayout_ipaddr_Invalid=2);
    searchlayout_ipaddr_LENGTH_ErrorCount := COUNT(GROUP,h.searchlayout_ipaddr_Invalid=3);
    searchlayout_ipaddr_WORDS_ErrorCount := COUNT(GROUP,h.searchlayout_ipaddr_Invalid=4);
    searchlayout_ipaddr_Total_ErrorCount := COUNT(GROUP,h.searchlayout_ipaddr_Invalid>0);
    fraudpoint_score_LEFTTRIM_ErrorCount := COUNT(GROUP,h.fraudpoint_score_Invalid=1);
    fraudpoint_score_ALLOW_ErrorCount := COUNT(GROUP,h.fraudpoint_score_Invalid=2);
    fraudpoint_score_LENGTH_ErrorCount := COUNT(GROUP,h.fraudpoint_score_Invalid=3);
    fraudpoint_score_WORDS_ErrorCount := COUNT(GROUP,h.fraudpoint_score_Invalid=4);
    fraudpoint_score_Total_ErrorCount := COUNT(GROUP,h.fraudpoint_score_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT32.StrType ErrorMessage;
    SALT32.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.mbslayout_company_id_Invalid,le.mbslayout_global_company_id_Invalid,le.allowlayout_allowflags_Invalid,le.businfolayout_primary_market_code_Invalid,le.businfolayout_secondary_market_code_Invalid,le.businfolayout_industry_1_code_Invalid,le.businfolayout_industry_2_code_Invalid,le.businfolayout_sub_market_Invalid,le.businfolayout_vertical_Invalid,le.businfolayout_use_Invalid,le.businfolayout_industry_Invalid,le.persondatalayout_full_name_Invalid,le.persondatalayout_first_name_Invalid,le.persondatalayout_middle_name_Invalid,le.persondatalayout_last_name_Invalid,le.persondatalayout_address_Invalid,le.persondatalayout_city_Invalid,le.persondatalayout_state_Invalid,le.persondatalayout_zip_Invalid,le.persondatalayout_personal_phone_Invalid,le.persondatalayout_work_phone_Invalid,le.persondatalayout_dob_Invalid,le.persondatalayout_dl_Invalid,le.persondatalayout_dl_st_Invalid,le.persondatalayout_email_address_Invalid,le.persondatalayout_ssn_Invalid,le.persondatalayout_linkid_Invalid,le.persondatalayout_ipaddr_Invalid,le.persondatalayout_title_Invalid,le.persondatalayout_fname_Invalid,le.persondatalayout_mname_Invalid,le.persondatalayout_lname_Invalid,le.persondatalayout_name_suffix_Invalid,le.persondatalayout_prim_range_Invalid,le.persondatalayout_predir_Invalid,le.persondatalayout_prim_name_Invalid,le.persondatalayout_addr_suffix_Invalid,le.persondatalayout_postdir_Invalid,le.persondatalayout_unit_desig_Invalid,le.persondatalayout_sec_range_Invalid,le.persondatalayout_v_city_name_Invalid,le.persondatalayout_st_Invalid,le.persondatalayout_zip5_Invalid,le.persondatalayout_zip4_Invalid,le.persondatalayout_addr_rec_type_Invalid,le.persondatalayout_fips_state_Invalid,le.persondatalayout_fips_county_Invalid,le.persondatalayout_geo_lat_Invalid,le.persondatalayout_geo_long_Invalid,le.persondatalayout_cbsa_Invalid,le.persondatalayout_geo_blk_Invalid,le.persondatalayout_geo_match_Invalid,le.persondatalayout_err_stat_Invalid,le.persondatalayout_appended_ssn_Invalid,le.persondatalayout_appended_adl_Invalid,le.permissablelayout_glb_purpose_Invalid,le.permissablelayout_dppa_purpose_Invalid,le.permissablelayout_fcra_purpose_Invalid,le.searchlayout_datetime_Invalid,le.searchlayout_start_monitor_Invalid,le.searchlayout_stop_monitor_Invalid,le.searchlayout_login_history_id_Invalid,le.searchlayout_transaction_id_Invalid,le.searchlayout_sequence_number_Invalid,le.searchlayout_method_Invalid,le.searchlayout_product_code_Invalid,le.searchlayout_transaction_type_Invalid,le.searchlayout_function_description_Invalid,le.searchlayout_ipaddr_Invalid,le.fraudpoint_score_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_mbslayout_company_id(le.mbslayout_company_id_Invalid),Fields.InvalidMessage_mbslayout_global_company_id(le.mbslayout_global_company_id_Invalid),Fields.InvalidMessage_allowlayout_allowflags(le.allowlayout_allowflags_Invalid),Fields.InvalidMessage_businfolayout_primary_market_code(le.businfolayout_primary_market_code_Invalid),Fields.InvalidMessage_businfolayout_secondary_market_code(le.businfolayout_secondary_market_code_Invalid),Fields.InvalidMessage_businfolayout_industry_1_code(le.businfolayout_industry_1_code_Invalid),Fields.InvalidMessage_businfolayout_industry_2_code(le.businfolayout_industry_2_code_Invalid),Fields.InvalidMessage_businfolayout_sub_market(le.businfolayout_sub_market_Invalid),Fields.InvalidMessage_businfolayout_vertical(le.businfolayout_vertical_Invalid),Fields.InvalidMessage_businfolayout_use(le.businfolayout_use_Invalid),Fields.InvalidMessage_businfolayout_industry(le.businfolayout_industry_Invalid),Fields.InvalidMessage_persondatalayout_full_name(le.persondatalayout_full_name_Invalid),Fields.InvalidMessage_persondatalayout_first_name(le.persondatalayout_first_name_Invalid),Fields.InvalidMessage_persondatalayout_middle_name(le.persondatalayout_middle_name_Invalid),Fields.InvalidMessage_persondatalayout_last_name(le.persondatalayout_last_name_Invalid),Fields.InvalidMessage_persondatalayout_address(le.persondatalayout_address_Invalid),Fields.InvalidMessage_persondatalayout_city(le.persondatalayout_city_Invalid),Fields.InvalidMessage_persondatalayout_state(le.persondatalayout_state_Invalid),Fields.InvalidMessage_persondatalayout_zip(le.persondatalayout_zip_Invalid),Fields.InvalidMessage_persondatalayout_personal_phone(le.persondatalayout_personal_phone_Invalid),Fields.InvalidMessage_persondatalayout_work_phone(le.persondatalayout_work_phone_Invalid),Fields.InvalidMessage_persondatalayout_dob(le.persondatalayout_dob_Invalid),Fields.InvalidMessage_persondatalayout_dl(le.persondatalayout_dl_Invalid),Fields.InvalidMessage_persondatalayout_dl_st(le.persondatalayout_dl_st_Invalid),Fields.InvalidMessage_persondatalayout_email_address(le.persondatalayout_email_address_Invalid),Fields.InvalidMessage_persondatalayout_ssn(le.persondatalayout_ssn_Invalid),Fields.InvalidMessage_persondatalayout_linkid(le.persondatalayout_linkid_Invalid),Fields.InvalidMessage_persondatalayout_ipaddr(le.persondatalayout_ipaddr_Invalid),Fields.InvalidMessage_persondatalayout_title(le.persondatalayout_title_Invalid),Fields.InvalidMessage_persondatalayout_fname(le.persondatalayout_fname_Invalid),Fields.InvalidMessage_persondatalayout_mname(le.persondatalayout_mname_Invalid),Fields.InvalidMessage_persondatalayout_lname(le.persondatalayout_lname_Invalid),Fields.InvalidMessage_persondatalayout_name_suffix(le.persondatalayout_name_suffix_Invalid),Fields.InvalidMessage_persondatalayout_prim_range(le.persondatalayout_prim_range_Invalid),Fields.InvalidMessage_persondatalayout_predir(le.persondatalayout_predir_Invalid),Fields.InvalidMessage_persondatalayout_prim_name(le.persondatalayout_prim_name_Invalid),Fields.InvalidMessage_persondatalayout_addr_suffix(le.persondatalayout_addr_suffix_Invalid),Fields.InvalidMessage_persondatalayout_postdir(le.persondatalayout_postdir_Invalid),Fields.InvalidMessage_persondatalayout_unit_desig(le.persondatalayout_unit_desig_Invalid),Fields.InvalidMessage_persondatalayout_sec_range(le.persondatalayout_sec_range_Invalid),Fields.InvalidMessage_persondatalayout_v_city_name(le.persondatalayout_v_city_name_Invalid),Fields.InvalidMessage_persondatalayout_st(le.persondatalayout_st_Invalid),Fields.InvalidMessage_persondatalayout_zip5(le.persondatalayout_zip5_Invalid),Fields.InvalidMessage_persondatalayout_zip4(le.persondatalayout_zip4_Invalid),Fields.InvalidMessage_persondatalayout_addr_rec_type(le.persondatalayout_addr_rec_type_Invalid),Fields.InvalidMessage_persondatalayout_fips_state(le.persondatalayout_fips_state_Invalid),Fields.InvalidMessage_persondatalayout_fips_county(le.persondatalayout_fips_county_Invalid),Fields.InvalidMessage_persondatalayout_geo_lat(le.persondatalayout_geo_lat_Invalid),Fields.InvalidMessage_persondatalayout_geo_long(le.persondatalayout_geo_long_Invalid),Fields.InvalidMessage_persondatalayout_cbsa(le.persondatalayout_cbsa_Invalid),Fields.InvalidMessage_persondatalayout_geo_blk(le.persondatalayout_geo_blk_Invalid),Fields.InvalidMessage_persondatalayout_geo_match(le.persondatalayout_geo_match_Invalid),Fields.InvalidMessage_persondatalayout_err_stat(le.persondatalayout_err_stat_Invalid),Fields.InvalidMessage_persondatalayout_appended_ssn(le.persondatalayout_appended_ssn_Invalid),Fields.InvalidMessage_persondatalayout_appended_adl(le.persondatalayout_appended_adl_Invalid),Fields.InvalidMessage_permissablelayout_glb_purpose(le.permissablelayout_glb_purpose_Invalid),Fields.InvalidMessage_permissablelayout_dppa_purpose(le.permissablelayout_dppa_purpose_Invalid),Fields.InvalidMessage_permissablelayout_fcra_purpose(le.permissablelayout_fcra_purpose_Invalid),Fields.InvalidMessage_searchlayout_datetime(le.searchlayout_datetime_Invalid),Fields.InvalidMessage_searchlayout_start_monitor(le.searchlayout_start_monitor_Invalid),Fields.InvalidMessage_searchlayout_stop_monitor(le.searchlayout_stop_monitor_Invalid),Fields.InvalidMessage_searchlayout_login_history_id(le.searchlayout_login_history_id_Invalid),Fields.InvalidMessage_searchlayout_transaction_id(le.searchlayout_transaction_id_Invalid),Fields.InvalidMessage_searchlayout_sequence_number(le.searchlayout_sequence_number_Invalid),Fields.InvalidMessage_searchlayout_method(le.searchlayout_method_Invalid),Fields.InvalidMessage_searchlayout_product_code(le.searchlayout_product_code_Invalid),Fields.InvalidMessage_searchlayout_transaction_type(le.searchlayout_transaction_type_Invalid),Fields.InvalidMessage_searchlayout_function_description(le.searchlayout_function_description_Invalid),Fields.InvalidMessage_searchlayout_ipaddr(le.searchlayout_ipaddr_Invalid),Fields.InvalidMessage_fraudpoint_score(le.fraudpoint_score_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.mbslayout_company_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.mbslayout_global_company_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.allowlayout_allowflags_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.businfolayout_primary_market_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.businfolayout_secondary_market_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.businfolayout_industry_1_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.businfolayout_industry_2_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.businfolayout_sub_market_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.businfolayout_vertical_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.businfolayout_use_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.businfolayout_industry_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_full_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_first_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_middle_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_last_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_address_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_city_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_zip_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_personal_phone_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_work_phone_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_dob_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_dl_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_dl_st_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_email_address_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_ssn_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_linkid_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_ipaddr_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_title_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_fname_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_mname_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_lname_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_name_suffix_Invalid,'ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_prim_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_predir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_prim_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_addr_suffix_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_postdir_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_unit_desig_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_sec_range_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_v_city_name_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_st_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_zip5_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_zip4_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_addr_rec_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_fips_state_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_fips_county_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_geo_lat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_geo_long_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_cbsa_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_geo_blk_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_geo_match_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_err_stat_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_appended_ssn_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.persondatalayout_appended_adl_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.permissablelayout_glb_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.permissablelayout_dppa_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.permissablelayout_fcra_purpose_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_datetime_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_start_monitor_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_stop_monitor_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_login_history_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_transaction_id_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_sequence_number_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_method_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_product_code_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_transaction_type_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_function_description_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.searchlayout_ipaddr_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN')
          ,CHOOSE(le.fraudpoint_score_Invalid,'LEFTTRIM','ALLOW','LENGTH','WORDS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'mbslayout_company_id','mbslayout_global_company_id','allowlayout_allowflags','businfolayout_primary_market_code','businfolayout_secondary_market_code','businfolayout_industry_1_code','businfolayout_industry_2_code','businfolayout_sub_market','businfolayout_vertical','businfolayout_use','businfolayout_industry','persondatalayout_full_name','persondatalayout_first_name','persondatalayout_middle_name','persondatalayout_last_name','persondatalayout_address','persondatalayout_city','persondatalayout_state','persondatalayout_zip','persondatalayout_personal_phone','persondatalayout_work_phone','persondatalayout_dob','persondatalayout_dl','persondatalayout_dl_st','persondatalayout_email_address','persondatalayout_ssn','persondatalayout_linkid','persondatalayout_ipaddr','persondatalayout_title','persondatalayout_fname','persondatalayout_mname','persondatalayout_lname','persondatalayout_name_suffix','persondatalayout_prim_range','persondatalayout_predir','persondatalayout_prim_name','persondatalayout_addr_suffix','persondatalayout_postdir','persondatalayout_unit_desig','persondatalayout_sec_range','persondatalayout_v_city_name','persondatalayout_st','persondatalayout_zip5','persondatalayout_zip4','persondatalayout_addr_rec_type','persondatalayout_fips_state','persondatalayout_fips_county','persondatalayout_geo_lat','persondatalayout_geo_long','persondatalayout_cbsa','persondatalayout_geo_blk','persondatalayout_geo_match','persondatalayout_err_stat','persondatalayout_appended_ssn','persondatalayout_appended_adl','permissablelayout_glb_purpose','permissablelayout_dppa_purpose','permissablelayout_fcra_purpose','searchlayout_datetime','searchlayout_start_monitor','searchlayout_stop_monitor','searchlayout_login_history_id','searchlayout_transaction_id','searchlayout_sequence_number','searchlayout_method','searchlayout_product_code','searchlayout_transaction_type','searchlayout_function_description','searchlayout_ipaddr','fraudpoint_score','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'mbslayout_company_id','mbslayout_global_company_id','allowlayout_allowflags','businfolayout_primary_market_code','businfolayout_secondary_market_code','businfolayout_industry_1_code','businfolayout_industry_2_code','businfolayout_sub_market','businfolayout_vertical','businfolayout_use','businfolayout_industry','persondatalayout_full_name','persondatalayout_first_name','persondatalayout_middle_name','persondatalayout_last_name','persondatalayout_address','persondatalayout_city','persondatalayout_state','persondatalayout_zip','persondatalayout_personal_phone','persondatalayout_work_phone','persondatalayout_dob','persondatalayout_dl','persondatalayout_dl_st','persondatalayout_email_address','persondatalayout_ssn','persondatalayout_linkid','persondatalayout_ipaddr','persondatalayout_title','persondatalayout_fname','persondatalayout_mname','persondatalayout_lname','persondatalayout_name_suffix','persondatalayout_prim_range','persondatalayout_predir','persondatalayout_prim_name','persondatalayout_addr_suffix','persondatalayout_postdir','persondatalayout_unit_desig','persondatalayout_sec_range','persondatalayout_v_city_name','persondatalayout_st','persondatalayout_zip5','persondatalayout_zip4','persondatalayout_addr_rec_type','persondatalayout_fips_state','persondatalayout_fips_county','persondatalayout_geo_lat','persondatalayout_geo_long','persondatalayout_cbsa','persondatalayout_geo_blk','persondatalayout_geo_match','persondatalayout_err_stat','persondatalayout_appended_ssn','persondatalayout_appended_adl','permissablelayout_glb_purpose','permissablelayout_dppa_purpose','permissablelayout_fcra_purpose','searchlayout_datetime','searchlayout_start_monitor','searchlayout_stop_monitor','searchlayout_login_history_id','searchlayout_transaction_id','searchlayout_sequence_number','searchlayout_method','searchlayout_product_code','searchlayout_transaction_type','searchlayout_function_description','searchlayout_ipaddr','fraudpoint_score','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT32.StrType)le.mbslayout_company_id,(SALT32.StrType)le.mbslayout_global_company_id,(SALT32.StrType)le.allowlayout_allowflags,(SALT32.StrType)le.businfolayout_primary_market_code,(SALT32.StrType)le.businfolayout_secondary_market_code,(SALT32.StrType)le.businfolayout_industry_1_code,(SALT32.StrType)le.businfolayout_industry_2_code,(SALT32.StrType)le.businfolayout_sub_market,(SALT32.StrType)le.businfolayout_vertical,(SALT32.StrType)le.businfolayout_use,(SALT32.StrType)le.businfolayout_industry,(SALT32.StrType)le.persondatalayout_full_name,(SALT32.StrType)le.persondatalayout_first_name,(SALT32.StrType)le.persondatalayout_middle_name,(SALT32.StrType)le.persondatalayout_last_name,(SALT32.StrType)le.persondatalayout_address,(SALT32.StrType)le.persondatalayout_city,(SALT32.StrType)le.persondatalayout_state,(SALT32.StrType)le.persondatalayout_zip,(SALT32.StrType)le.persondatalayout_personal_phone,(SALT32.StrType)le.persondatalayout_work_phone,(SALT32.StrType)le.persondatalayout_dob,(SALT32.StrType)le.persondatalayout_dl,(SALT32.StrType)le.persondatalayout_dl_st,(SALT32.StrType)le.persondatalayout_email_address,(SALT32.StrType)le.persondatalayout_ssn,(SALT32.StrType)le.persondatalayout_linkid,(SALT32.StrType)le.persondatalayout_ipaddr,(SALT32.StrType)le.persondatalayout_title,(SALT32.StrType)le.persondatalayout_fname,(SALT32.StrType)le.persondatalayout_mname,(SALT32.StrType)le.persondatalayout_lname,(SALT32.StrType)le.persondatalayout_name_suffix,(SALT32.StrType)le.persondatalayout_prim_range,(SALT32.StrType)le.persondatalayout_predir,(SALT32.StrType)le.persondatalayout_prim_name,(SALT32.StrType)le.persondatalayout_addr_suffix,(SALT32.StrType)le.persondatalayout_postdir,(SALT32.StrType)le.persondatalayout_unit_desig,(SALT32.StrType)le.persondatalayout_sec_range,(SALT32.StrType)le.persondatalayout_v_city_name,(SALT32.StrType)le.persondatalayout_st,(SALT32.StrType)le.persondatalayout_zip5,(SALT32.StrType)le.persondatalayout_zip4,(SALT32.StrType)le.persondatalayout_addr_rec_type,(SALT32.StrType)le.persondatalayout_fips_state,(SALT32.StrType)le.persondatalayout_fips_county,(SALT32.StrType)le.persondatalayout_geo_lat,(SALT32.StrType)le.persondatalayout_geo_long,(SALT32.StrType)le.persondatalayout_cbsa,(SALT32.StrType)le.persondatalayout_geo_blk,(SALT32.StrType)le.persondatalayout_geo_match,(SALT32.StrType)le.persondatalayout_err_stat,(SALT32.StrType)le.persondatalayout_appended_ssn,(SALT32.StrType)le.persondatalayout_appended_adl,(SALT32.StrType)le.permissablelayout_glb_purpose,(SALT32.StrType)le.permissablelayout_dppa_purpose,(SALT32.StrType)le.permissablelayout_fcra_purpose,(SALT32.StrType)le.searchlayout_datetime,(SALT32.StrType)le.searchlayout_start_monitor,(SALT32.StrType)le.searchlayout_stop_monitor,(SALT32.StrType)le.searchlayout_login_history_id,(SALT32.StrType)le.searchlayout_transaction_id,(SALT32.StrType)le.searchlayout_sequence_number,(SALT32.StrType)le.searchlayout_method,(SALT32.StrType)le.searchlayout_product_code,(SALT32.StrType)le.searchlayout_transaction_type,(SALT32.StrType)le.searchlayout_function_description,(SALT32.StrType)le.searchlayout_ipaddr,(SALT32.StrType)le.fraudpoint_score,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,70,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT32.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'mbslayout_company_id:mbslayout_company_id:LEFTTRIM','mbslayout_company_id:mbslayout_company_id:ALLOW','mbslayout_company_id:mbslayout_company_id:LENGTH','mbslayout_company_id:mbslayout_company_id:WORDS'
          ,'mbslayout_global_company_id:mbslayout_global_company_id:LEFTTRIM','mbslayout_global_company_id:mbslayout_global_company_id:ALLOW','mbslayout_global_company_id:mbslayout_global_company_id:LENGTH','mbslayout_global_company_id:mbslayout_global_company_id:WORDS'
          ,'allowlayout_allowflags:allowlayout_allowflags:LEFTTRIM','allowlayout_allowflags:allowlayout_allowflags:ALLOW','allowlayout_allowflags:allowlayout_allowflags:LENGTH','allowlayout_allowflags:allowlayout_allowflags:WORDS'
          ,'businfolayout_primary_market_code:businfolayout_primary_market_code:LEFTTRIM','businfolayout_primary_market_code:businfolayout_primary_market_code:ALLOW','businfolayout_primary_market_code:businfolayout_primary_market_code:LENGTH','businfolayout_primary_market_code:businfolayout_primary_market_code:WORDS'
          ,'businfolayout_secondary_market_code:businfolayout_secondary_market_code:LEFTTRIM','businfolayout_secondary_market_code:businfolayout_secondary_market_code:ALLOW','businfolayout_secondary_market_code:businfolayout_secondary_market_code:LENGTH','businfolayout_secondary_market_code:businfolayout_secondary_market_code:WORDS'
          ,'businfolayout_industry_1_code:businfolayout_industry_1_code:LEFTTRIM','businfolayout_industry_1_code:businfolayout_industry_1_code:ALLOW','businfolayout_industry_1_code:businfolayout_industry_1_code:LENGTH','businfolayout_industry_1_code:businfolayout_industry_1_code:WORDS'
          ,'businfolayout_industry_2_code:businfolayout_industry_2_code:LEFTTRIM','businfolayout_industry_2_code:businfolayout_industry_2_code:ALLOW','businfolayout_industry_2_code:businfolayout_industry_2_code:LENGTH','businfolayout_industry_2_code:businfolayout_industry_2_code:WORDS'
          ,'businfolayout_sub_market:businfolayout_sub_market:LEFTTRIM','businfolayout_sub_market:businfolayout_sub_market:ALLOW','businfolayout_sub_market:businfolayout_sub_market:LENGTH','businfolayout_sub_market:businfolayout_sub_market:WORDS'
          ,'businfolayout_vertical:businfolayout_vertical:LEFTTRIM','businfolayout_vertical:businfolayout_vertical:ALLOW','businfolayout_vertical:businfolayout_vertical:LENGTH','businfolayout_vertical:businfolayout_vertical:WORDS'
          ,'businfolayout_use:businfolayout_use:LEFTTRIM','businfolayout_use:businfolayout_use:ALLOW','businfolayout_use:businfolayout_use:LENGTH','businfolayout_use:businfolayout_use:WORDS'
          ,'businfolayout_industry:businfolayout_industry:LEFTTRIM','businfolayout_industry:businfolayout_industry:ALLOW','businfolayout_industry:businfolayout_industry:LENGTH','businfolayout_industry:businfolayout_industry:WORDS'
          ,'persondatalayout_full_name:persondatalayout_full_name:LEFTTRIM','persondatalayout_full_name:persondatalayout_full_name:ALLOW','persondatalayout_full_name:persondatalayout_full_name:LENGTH','persondatalayout_full_name:persondatalayout_full_name:WORDS'
          ,'persondatalayout_first_name:persondatalayout_first_name:LEFTTRIM','persondatalayout_first_name:persondatalayout_first_name:ALLOW','persondatalayout_first_name:persondatalayout_first_name:LENGTH','persondatalayout_first_name:persondatalayout_first_name:WORDS'
          ,'persondatalayout_middle_name:persondatalayout_middle_name:LEFTTRIM','persondatalayout_middle_name:persondatalayout_middle_name:ALLOW','persondatalayout_middle_name:persondatalayout_middle_name:LENGTH','persondatalayout_middle_name:persondatalayout_middle_name:WORDS'
          ,'persondatalayout_last_name:persondatalayout_last_name:LEFTTRIM','persondatalayout_last_name:persondatalayout_last_name:ALLOW','persondatalayout_last_name:persondatalayout_last_name:LENGTH','persondatalayout_last_name:persondatalayout_last_name:WORDS'
          ,'persondatalayout_address:persondatalayout_address:LEFTTRIM','persondatalayout_address:persondatalayout_address:ALLOW','persondatalayout_address:persondatalayout_address:LENGTH','persondatalayout_address:persondatalayout_address:WORDS'
          ,'persondatalayout_city:persondatalayout_city:LEFTTRIM','persondatalayout_city:persondatalayout_city:ALLOW','persondatalayout_city:persondatalayout_city:LENGTH','persondatalayout_city:persondatalayout_city:WORDS'
          ,'persondatalayout_state:persondatalayout_state:LEFTTRIM','persondatalayout_state:persondatalayout_state:ALLOW','persondatalayout_state:persondatalayout_state:LENGTH','persondatalayout_state:persondatalayout_state:WORDS'
          ,'persondatalayout_zip:persondatalayout_zip:LEFTTRIM','persondatalayout_zip:persondatalayout_zip:ALLOW','persondatalayout_zip:persondatalayout_zip:LENGTH','persondatalayout_zip:persondatalayout_zip:WORDS'
          ,'persondatalayout_personal_phone:persondatalayout_personal_phone:ALLOW','persondatalayout_personal_phone:persondatalayout_personal_phone:LENGTH','persondatalayout_personal_phone:persondatalayout_personal_phone:WORDS'
          ,'persondatalayout_work_phone:persondatalayout_work_phone:ALLOW','persondatalayout_work_phone:persondatalayout_work_phone:LENGTH','persondatalayout_work_phone:persondatalayout_work_phone:WORDS'
          ,'persondatalayout_dob:persondatalayout_dob:LEFTTRIM','persondatalayout_dob:persondatalayout_dob:ALLOW','persondatalayout_dob:persondatalayout_dob:LENGTH','persondatalayout_dob:persondatalayout_dob:WORDS'
          ,'persondatalayout_dl:persondatalayout_dl:LEFTTRIM','persondatalayout_dl:persondatalayout_dl:ALLOW','persondatalayout_dl:persondatalayout_dl:LENGTH','persondatalayout_dl:persondatalayout_dl:WORDS'
          ,'persondatalayout_dl_st:persondatalayout_dl_st:LEFTTRIM','persondatalayout_dl_st:persondatalayout_dl_st:ALLOW','persondatalayout_dl_st:persondatalayout_dl_st:LENGTH','persondatalayout_dl_st:persondatalayout_dl_st:WORDS'
          ,'persondatalayout_email_address:persondatalayout_email_address:LEFTTRIM','persondatalayout_email_address:persondatalayout_email_address:ALLOW','persondatalayout_email_address:persondatalayout_email_address:LENGTH','persondatalayout_email_address:persondatalayout_email_address:WORDS'
          ,'persondatalayout_ssn:persondatalayout_ssn:ALLOW','persondatalayout_ssn:persondatalayout_ssn:LENGTH','persondatalayout_ssn:persondatalayout_ssn:WORDS'
          ,'persondatalayout_linkid:persondatalayout_linkid:LEFTTRIM','persondatalayout_linkid:persondatalayout_linkid:ALLOW','persondatalayout_linkid:persondatalayout_linkid:LENGTH','persondatalayout_linkid:persondatalayout_linkid:WORDS'
          ,'persondatalayout_ipaddr:persondatalayout_ipaddr:LEFTTRIM','persondatalayout_ipaddr:persondatalayout_ipaddr:ALLOW','persondatalayout_ipaddr:persondatalayout_ipaddr:LENGTH','persondatalayout_ipaddr:persondatalayout_ipaddr:WORDS'
          ,'persondatalayout_title:persondatalayout_title:LEFTTRIM','persondatalayout_title:persondatalayout_title:ALLOW','persondatalayout_title:persondatalayout_title:LENGTH','persondatalayout_title:persondatalayout_title:WORDS'
          ,'persondatalayout_fname:persondatalayout_fname:ALLOW','persondatalayout_fname:persondatalayout_fname:LENGTH','persondatalayout_fname:persondatalayout_fname:WORDS'
          ,'persondatalayout_mname:persondatalayout_mname:ALLOW','persondatalayout_mname:persondatalayout_mname:LENGTH','persondatalayout_mname:persondatalayout_mname:WORDS'
          ,'persondatalayout_lname:persondatalayout_lname:LEFTTRIM','persondatalayout_lname:persondatalayout_lname:ALLOW','persondatalayout_lname:persondatalayout_lname:LENGTH','persondatalayout_lname:persondatalayout_lname:WORDS'
          ,'persondatalayout_name_suffix:persondatalayout_name_suffix:ALLOW','persondatalayout_name_suffix:persondatalayout_name_suffix:LENGTH','persondatalayout_name_suffix:persondatalayout_name_suffix:WORDS'
          ,'persondatalayout_prim_range:persondatalayout_prim_range:LEFTTRIM','persondatalayout_prim_range:persondatalayout_prim_range:ALLOW','persondatalayout_prim_range:persondatalayout_prim_range:LENGTH','persondatalayout_prim_range:persondatalayout_prim_range:WORDS'
          ,'persondatalayout_predir:persondatalayout_predir:LEFTTRIM','persondatalayout_predir:persondatalayout_predir:ALLOW','persondatalayout_predir:persondatalayout_predir:LENGTH','persondatalayout_predir:persondatalayout_predir:WORDS'
          ,'persondatalayout_prim_name:persondatalayout_prim_name:LEFTTRIM','persondatalayout_prim_name:persondatalayout_prim_name:ALLOW','persondatalayout_prim_name:persondatalayout_prim_name:LENGTH','persondatalayout_prim_name:persondatalayout_prim_name:WORDS'
          ,'persondatalayout_addr_suffix:persondatalayout_addr_suffix:LEFTTRIM','persondatalayout_addr_suffix:persondatalayout_addr_suffix:ALLOW','persondatalayout_addr_suffix:persondatalayout_addr_suffix:LENGTH','persondatalayout_addr_suffix:persondatalayout_addr_suffix:WORDS'
          ,'persondatalayout_postdir:persondatalayout_postdir:LEFTTRIM','persondatalayout_postdir:persondatalayout_postdir:ALLOW','persondatalayout_postdir:persondatalayout_postdir:LENGTH','persondatalayout_postdir:persondatalayout_postdir:WORDS'
          ,'persondatalayout_unit_desig:persondatalayout_unit_desig:LEFTTRIM','persondatalayout_unit_desig:persondatalayout_unit_desig:ALLOW','persondatalayout_unit_desig:persondatalayout_unit_desig:LENGTH','persondatalayout_unit_desig:persondatalayout_unit_desig:WORDS'
          ,'persondatalayout_sec_range:persondatalayout_sec_range:LEFTTRIM','persondatalayout_sec_range:persondatalayout_sec_range:ALLOW','persondatalayout_sec_range:persondatalayout_sec_range:LENGTH','persondatalayout_sec_range:persondatalayout_sec_range:WORDS'
          ,'persondatalayout_v_city_name:persondatalayout_v_city_name:LEFTTRIM','persondatalayout_v_city_name:persondatalayout_v_city_name:ALLOW','persondatalayout_v_city_name:persondatalayout_v_city_name:LENGTH','persondatalayout_v_city_name:persondatalayout_v_city_name:WORDS'
          ,'persondatalayout_st:persondatalayout_st:LEFTTRIM','persondatalayout_st:persondatalayout_st:ALLOW','persondatalayout_st:persondatalayout_st:LENGTH','persondatalayout_st:persondatalayout_st:WORDS'
          ,'persondatalayout_zip5:persondatalayout_zip5:LEFTTRIM','persondatalayout_zip5:persondatalayout_zip5:ALLOW','persondatalayout_zip5:persondatalayout_zip5:LENGTH','persondatalayout_zip5:persondatalayout_zip5:WORDS'
          ,'persondatalayout_zip4:persondatalayout_zip4:LEFTTRIM','persondatalayout_zip4:persondatalayout_zip4:ALLOW','persondatalayout_zip4:persondatalayout_zip4:LENGTH','persondatalayout_zip4:persondatalayout_zip4:WORDS'
          ,'persondatalayout_addr_rec_type:persondatalayout_addr_rec_type:LEFTTRIM','persondatalayout_addr_rec_type:persondatalayout_addr_rec_type:ALLOW','persondatalayout_addr_rec_type:persondatalayout_addr_rec_type:LENGTH','persondatalayout_addr_rec_type:persondatalayout_addr_rec_type:WORDS'
          ,'persondatalayout_fips_state:persondatalayout_fips_state:LEFTTRIM','persondatalayout_fips_state:persondatalayout_fips_state:ALLOW','persondatalayout_fips_state:persondatalayout_fips_state:LENGTH','persondatalayout_fips_state:persondatalayout_fips_state:WORDS'
          ,'persondatalayout_fips_county:persondatalayout_fips_county:LEFTTRIM','persondatalayout_fips_county:persondatalayout_fips_county:ALLOW','persondatalayout_fips_county:persondatalayout_fips_county:LENGTH','persondatalayout_fips_county:persondatalayout_fips_county:WORDS'
          ,'persondatalayout_geo_lat:persondatalayout_geo_lat:LEFTTRIM','persondatalayout_geo_lat:persondatalayout_geo_lat:ALLOW','persondatalayout_geo_lat:persondatalayout_geo_lat:LENGTH','persondatalayout_geo_lat:persondatalayout_geo_lat:WORDS'
          ,'persondatalayout_geo_long:persondatalayout_geo_long:LEFTTRIM','persondatalayout_geo_long:persondatalayout_geo_long:ALLOW','persondatalayout_geo_long:persondatalayout_geo_long:LENGTH','persondatalayout_geo_long:persondatalayout_geo_long:WORDS'
          ,'persondatalayout_cbsa:persondatalayout_cbsa:LEFTTRIM','persondatalayout_cbsa:persondatalayout_cbsa:ALLOW','persondatalayout_cbsa:persondatalayout_cbsa:LENGTH','persondatalayout_cbsa:persondatalayout_cbsa:WORDS'
          ,'persondatalayout_geo_blk:persondatalayout_geo_blk:LEFTTRIM','persondatalayout_geo_blk:persondatalayout_geo_blk:ALLOW','persondatalayout_geo_blk:persondatalayout_geo_blk:LENGTH','persondatalayout_geo_blk:persondatalayout_geo_blk:WORDS'
          ,'persondatalayout_geo_match:persondatalayout_geo_match:LEFTTRIM','persondatalayout_geo_match:persondatalayout_geo_match:ALLOW','persondatalayout_geo_match:persondatalayout_geo_match:LENGTH','persondatalayout_geo_match:persondatalayout_geo_match:WORDS'
          ,'persondatalayout_err_stat:persondatalayout_err_stat:LEFTTRIM','persondatalayout_err_stat:persondatalayout_err_stat:ALLOW','persondatalayout_err_stat:persondatalayout_err_stat:LENGTH','persondatalayout_err_stat:persondatalayout_err_stat:WORDS'
          ,'persondatalayout_appended_ssn:persondatalayout_appended_ssn:LEFTTRIM','persondatalayout_appended_ssn:persondatalayout_appended_ssn:ALLOW','persondatalayout_appended_ssn:persondatalayout_appended_ssn:LENGTH','persondatalayout_appended_ssn:persondatalayout_appended_ssn:WORDS'
          ,'persondatalayout_appended_adl:persondatalayout_appended_adl:LEFTTRIM','persondatalayout_appended_adl:persondatalayout_appended_adl:ALLOW','persondatalayout_appended_adl:persondatalayout_appended_adl:LENGTH','persondatalayout_appended_adl:persondatalayout_appended_adl:WORDS'
          ,'permissablelayout_glb_purpose:permissablelayout_glb_purpose:LEFTTRIM','permissablelayout_glb_purpose:permissablelayout_glb_purpose:ALLOW','permissablelayout_glb_purpose:permissablelayout_glb_purpose:LENGTH','permissablelayout_glb_purpose:permissablelayout_glb_purpose:WORDS'
          ,'permissablelayout_dppa_purpose:permissablelayout_dppa_purpose:LEFTTRIM','permissablelayout_dppa_purpose:permissablelayout_dppa_purpose:ALLOW','permissablelayout_dppa_purpose:permissablelayout_dppa_purpose:LENGTH','permissablelayout_dppa_purpose:permissablelayout_dppa_purpose:WORDS'
          ,'permissablelayout_fcra_purpose:permissablelayout_fcra_purpose:LEFTTRIM','permissablelayout_fcra_purpose:permissablelayout_fcra_purpose:ALLOW','permissablelayout_fcra_purpose:permissablelayout_fcra_purpose:LENGTH','permissablelayout_fcra_purpose:permissablelayout_fcra_purpose:WORDS'
          ,'searchlayout_datetime:searchlayout_datetime:LEFTTRIM','searchlayout_datetime:searchlayout_datetime:ALLOW','searchlayout_datetime:searchlayout_datetime:LENGTH','searchlayout_datetime:searchlayout_datetime:WORDS'
          ,'searchlayout_start_monitor:searchlayout_start_monitor:LEFTTRIM','searchlayout_start_monitor:searchlayout_start_monitor:ALLOW','searchlayout_start_monitor:searchlayout_start_monitor:LENGTH','searchlayout_start_monitor:searchlayout_start_monitor:WORDS'
          ,'searchlayout_stop_monitor:searchlayout_stop_monitor:LEFTTRIM','searchlayout_stop_monitor:searchlayout_stop_monitor:ALLOW','searchlayout_stop_monitor:searchlayout_stop_monitor:LENGTH','searchlayout_stop_monitor:searchlayout_stop_monitor:WORDS'
          ,'searchlayout_login_history_id:searchlayout_login_history_id:LEFTTRIM','searchlayout_login_history_id:searchlayout_login_history_id:ALLOW','searchlayout_login_history_id:searchlayout_login_history_id:LENGTH','searchlayout_login_history_id:searchlayout_login_history_id:WORDS'
          ,'searchlayout_transaction_id:searchlayout_transaction_id:LEFTTRIM','searchlayout_transaction_id:searchlayout_transaction_id:ALLOW','searchlayout_transaction_id:searchlayout_transaction_id:LENGTH','searchlayout_transaction_id:searchlayout_transaction_id:WORDS'
          ,'searchlayout_sequence_number:searchlayout_sequence_number:LEFTTRIM','searchlayout_sequence_number:searchlayout_sequence_number:ALLOW','searchlayout_sequence_number:searchlayout_sequence_number:LENGTH','searchlayout_sequence_number:searchlayout_sequence_number:WORDS'
          ,'searchlayout_method:searchlayout_method:LEFTTRIM','searchlayout_method:searchlayout_method:ALLOW','searchlayout_method:searchlayout_method:LENGTH','searchlayout_method:searchlayout_method:WORDS'
          ,'searchlayout_product_code:searchlayout_product_code:LEFTTRIM','searchlayout_product_code:searchlayout_product_code:ALLOW','searchlayout_product_code:searchlayout_product_code:LENGTH','searchlayout_product_code:searchlayout_product_code:WORDS'
          ,'searchlayout_transaction_type:searchlayout_transaction_type:LEFTTRIM','searchlayout_transaction_type:searchlayout_transaction_type:ALLOW','searchlayout_transaction_type:searchlayout_transaction_type:LENGTH','searchlayout_transaction_type:searchlayout_transaction_type:WORDS'
          ,'searchlayout_function_description:searchlayout_function_description:LEFTTRIM','searchlayout_function_description:searchlayout_function_description:ALLOW','searchlayout_function_description:searchlayout_function_description:LENGTH','searchlayout_function_description:searchlayout_function_description:WORDS'
          ,'searchlayout_ipaddr:searchlayout_ipaddr:LEFTTRIM','searchlayout_ipaddr:searchlayout_ipaddr:ALLOW','searchlayout_ipaddr:searchlayout_ipaddr:LENGTH','searchlayout_ipaddr:searchlayout_ipaddr:WORDS'
          ,'fraudpoint_score:fraudpoint_score:LEFTTRIM','fraudpoint_score:fraudpoint_score:ALLOW','fraudpoint_score:fraudpoint_score:LENGTH','fraudpoint_score:fraudpoint_score:WORDS','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_mbslayout_company_id(1),Fields.InvalidMessage_mbslayout_company_id(2),Fields.InvalidMessage_mbslayout_company_id(3),Fields.InvalidMessage_mbslayout_company_id(4)
          ,Fields.InvalidMessage_mbslayout_global_company_id(1),Fields.InvalidMessage_mbslayout_global_company_id(2),Fields.InvalidMessage_mbslayout_global_company_id(3),Fields.InvalidMessage_mbslayout_global_company_id(4)
          ,Fields.InvalidMessage_allowlayout_allowflags(1),Fields.InvalidMessage_allowlayout_allowflags(2),Fields.InvalidMessage_allowlayout_allowflags(3),Fields.InvalidMessage_allowlayout_allowflags(4)
          ,Fields.InvalidMessage_businfolayout_primary_market_code(1),Fields.InvalidMessage_businfolayout_primary_market_code(2),Fields.InvalidMessage_businfolayout_primary_market_code(3),Fields.InvalidMessage_businfolayout_primary_market_code(4)
          ,Fields.InvalidMessage_businfolayout_secondary_market_code(1),Fields.InvalidMessage_businfolayout_secondary_market_code(2),Fields.InvalidMessage_businfolayout_secondary_market_code(3),Fields.InvalidMessage_businfolayout_secondary_market_code(4)
          ,Fields.InvalidMessage_businfolayout_industry_1_code(1),Fields.InvalidMessage_businfolayout_industry_1_code(2),Fields.InvalidMessage_businfolayout_industry_1_code(3),Fields.InvalidMessage_businfolayout_industry_1_code(4)
          ,Fields.InvalidMessage_businfolayout_industry_2_code(1),Fields.InvalidMessage_businfolayout_industry_2_code(2),Fields.InvalidMessage_businfolayout_industry_2_code(3),Fields.InvalidMessage_businfolayout_industry_2_code(4)
          ,Fields.InvalidMessage_businfolayout_sub_market(1),Fields.InvalidMessage_businfolayout_sub_market(2),Fields.InvalidMessage_businfolayout_sub_market(3),Fields.InvalidMessage_businfolayout_sub_market(4)
          ,Fields.InvalidMessage_businfolayout_vertical(1),Fields.InvalidMessage_businfolayout_vertical(2),Fields.InvalidMessage_businfolayout_vertical(3),Fields.InvalidMessage_businfolayout_vertical(4)
          ,Fields.InvalidMessage_businfolayout_use(1),Fields.InvalidMessage_businfolayout_use(2),Fields.InvalidMessage_businfolayout_use(3),Fields.InvalidMessage_businfolayout_use(4)
          ,Fields.InvalidMessage_businfolayout_industry(1),Fields.InvalidMessage_businfolayout_industry(2),Fields.InvalidMessage_businfolayout_industry(3),Fields.InvalidMessage_businfolayout_industry(4)
          ,Fields.InvalidMessage_persondatalayout_full_name(1),Fields.InvalidMessage_persondatalayout_full_name(2),Fields.InvalidMessage_persondatalayout_full_name(3),Fields.InvalidMessage_persondatalayout_full_name(4)
          ,Fields.InvalidMessage_persondatalayout_first_name(1),Fields.InvalidMessage_persondatalayout_first_name(2),Fields.InvalidMessage_persondatalayout_first_name(3),Fields.InvalidMessage_persondatalayout_first_name(4)
          ,Fields.InvalidMessage_persondatalayout_middle_name(1),Fields.InvalidMessage_persondatalayout_middle_name(2),Fields.InvalidMessage_persondatalayout_middle_name(3),Fields.InvalidMessage_persondatalayout_middle_name(4)
          ,Fields.InvalidMessage_persondatalayout_last_name(1),Fields.InvalidMessage_persondatalayout_last_name(2),Fields.InvalidMessage_persondatalayout_last_name(3),Fields.InvalidMessage_persondatalayout_last_name(4)
          ,Fields.InvalidMessage_persondatalayout_address(1),Fields.InvalidMessage_persondatalayout_address(2),Fields.InvalidMessage_persondatalayout_address(3),Fields.InvalidMessage_persondatalayout_address(4)
          ,Fields.InvalidMessage_persondatalayout_city(1),Fields.InvalidMessage_persondatalayout_city(2),Fields.InvalidMessage_persondatalayout_city(3),Fields.InvalidMessage_persondatalayout_city(4)
          ,Fields.InvalidMessage_persondatalayout_state(1),Fields.InvalidMessage_persondatalayout_state(2),Fields.InvalidMessage_persondatalayout_state(3),Fields.InvalidMessage_persondatalayout_state(4)
          ,Fields.InvalidMessage_persondatalayout_zip(1),Fields.InvalidMessage_persondatalayout_zip(2),Fields.InvalidMessage_persondatalayout_zip(3),Fields.InvalidMessage_persondatalayout_zip(4)
          ,Fields.InvalidMessage_persondatalayout_personal_phone(1),Fields.InvalidMessage_persondatalayout_personal_phone(2),Fields.InvalidMessage_persondatalayout_personal_phone(3)
          ,Fields.InvalidMessage_persondatalayout_work_phone(1),Fields.InvalidMessage_persondatalayout_work_phone(2),Fields.InvalidMessage_persondatalayout_work_phone(3)
          ,Fields.InvalidMessage_persondatalayout_dob(1),Fields.InvalidMessage_persondatalayout_dob(2),Fields.InvalidMessage_persondatalayout_dob(3),Fields.InvalidMessage_persondatalayout_dob(4)
          ,Fields.InvalidMessage_persondatalayout_dl(1),Fields.InvalidMessage_persondatalayout_dl(2),Fields.InvalidMessage_persondatalayout_dl(3),Fields.InvalidMessage_persondatalayout_dl(4)
          ,Fields.InvalidMessage_persondatalayout_dl_st(1),Fields.InvalidMessage_persondatalayout_dl_st(2),Fields.InvalidMessage_persondatalayout_dl_st(3),Fields.InvalidMessage_persondatalayout_dl_st(4)
          ,Fields.InvalidMessage_persondatalayout_email_address(1),Fields.InvalidMessage_persondatalayout_email_address(2),Fields.InvalidMessage_persondatalayout_email_address(3),Fields.InvalidMessage_persondatalayout_email_address(4)
          ,Fields.InvalidMessage_persondatalayout_ssn(1),Fields.InvalidMessage_persondatalayout_ssn(2),Fields.InvalidMessage_persondatalayout_ssn(3)
          ,Fields.InvalidMessage_persondatalayout_linkid(1),Fields.InvalidMessage_persondatalayout_linkid(2),Fields.InvalidMessage_persondatalayout_linkid(3),Fields.InvalidMessage_persondatalayout_linkid(4)
          ,Fields.InvalidMessage_persondatalayout_ipaddr(1),Fields.InvalidMessage_persondatalayout_ipaddr(2),Fields.InvalidMessage_persondatalayout_ipaddr(3),Fields.InvalidMessage_persondatalayout_ipaddr(4)
          ,Fields.InvalidMessage_persondatalayout_title(1),Fields.InvalidMessage_persondatalayout_title(2),Fields.InvalidMessage_persondatalayout_title(3),Fields.InvalidMessage_persondatalayout_title(4)
          ,Fields.InvalidMessage_persondatalayout_fname(1),Fields.InvalidMessage_persondatalayout_fname(2),Fields.InvalidMessage_persondatalayout_fname(3)
          ,Fields.InvalidMessage_persondatalayout_mname(1),Fields.InvalidMessage_persondatalayout_mname(2),Fields.InvalidMessage_persondatalayout_mname(3)
          ,Fields.InvalidMessage_persondatalayout_lname(1),Fields.InvalidMessage_persondatalayout_lname(2),Fields.InvalidMessage_persondatalayout_lname(3),Fields.InvalidMessage_persondatalayout_lname(4)
          ,Fields.InvalidMessage_persondatalayout_name_suffix(1),Fields.InvalidMessage_persondatalayout_name_suffix(2),Fields.InvalidMessage_persondatalayout_name_suffix(3)
          ,Fields.InvalidMessage_persondatalayout_prim_range(1),Fields.InvalidMessage_persondatalayout_prim_range(2),Fields.InvalidMessage_persondatalayout_prim_range(3),Fields.InvalidMessage_persondatalayout_prim_range(4)
          ,Fields.InvalidMessage_persondatalayout_predir(1),Fields.InvalidMessage_persondatalayout_predir(2),Fields.InvalidMessage_persondatalayout_predir(3),Fields.InvalidMessage_persondatalayout_predir(4)
          ,Fields.InvalidMessage_persondatalayout_prim_name(1),Fields.InvalidMessage_persondatalayout_prim_name(2),Fields.InvalidMessage_persondatalayout_prim_name(3),Fields.InvalidMessage_persondatalayout_prim_name(4)
          ,Fields.InvalidMessage_persondatalayout_addr_suffix(1),Fields.InvalidMessage_persondatalayout_addr_suffix(2),Fields.InvalidMessage_persondatalayout_addr_suffix(3),Fields.InvalidMessage_persondatalayout_addr_suffix(4)
          ,Fields.InvalidMessage_persondatalayout_postdir(1),Fields.InvalidMessage_persondatalayout_postdir(2),Fields.InvalidMessage_persondatalayout_postdir(3),Fields.InvalidMessage_persondatalayout_postdir(4)
          ,Fields.InvalidMessage_persondatalayout_unit_desig(1),Fields.InvalidMessage_persondatalayout_unit_desig(2),Fields.InvalidMessage_persondatalayout_unit_desig(3),Fields.InvalidMessage_persondatalayout_unit_desig(4)
          ,Fields.InvalidMessage_persondatalayout_sec_range(1),Fields.InvalidMessage_persondatalayout_sec_range(2),Fields.InvalidMessage_persondatalayout_sec_range(3),Fields.InvalidMessage_persondatalayout_sec_range(4)
          ,Fields.InvalidMessage_persondatalayout_v_city_name(1),Fields.InvalidMessage_persondatalayout_v_city_name(2),Fields.InvalidMessage_persondatalayout_v_city_name(3),Fields.InvalidMessage_persondatalayout_v_city_name(4)
          ,Fields.InvalidMessage_persondatalayout_st(1),Fields.InvalidMessage_persondatalayout_st(2),Fields.InvalidMessage_persondatalayout_st(3),Fields.InvalidMessage_persondatalayout_st(4)
          ,Fields.InvalidMessage_persondatalayout_zip5(1),Fields.InvalidMessage_persondatalayout_zip5(2),Fields.InvalidMessage_persondatalayout_zip5(3),Fields.InvalidMessage_persondatalayout_zip5(4)
          ,Fields.InvalidMessage_persondatalayout_zip4(1),Fields.InvalidMessage_persondatalayout_zip4(2),Fields.InvalidMessage_persondatalayout_zip4(3),Fields.InvalidMessage_persondatalayout_zip4(4)
          ,Fields.InvalidMessage_persondatalayout_addr_rec_type(1),Fields.InvalidMessage_persondatalayout_addr_rec_type(2),Fields.InvalidMessage_persondatalayout_addr_rec_type(3),Fields.InvalidMessage_persondatalayout_addr_rec_type(4)
          ,Fields.InvalidMessage_persondatalayout_fips_state(1),Fields.InvalidMessage_persondatalayout_fips_state(2),Fields.InvalidMessage_persondatalayout_fips_state(3),Fields.InvalidMessage_persondatalayout_fips_state(4)
          ,Fields.InvalidMessage_persondatalayout_fips_county(1),Fields.InvalidMessage_persondatalayout_fips_county(2),Fields.InvalidMessage_persondatalayout_fips_county(3),Fields.InvalidMessage_persondatalayout_fips_county(4)
          ,Fields.InvalidMessage_persondatalayout_geo_lat(1),Fields.InvalidMessage_persondatalayout_geo_lat(2),Fields.InvalidMessage_persondatalayout_geo_lat(3),Fields.InvalidMessage_persondatalayout_geo_lat(4)
          ,Fields.InvalidMessage_persondatalayout_geo_long(1),Fields.InvalidMessage_persondatalayout_geo_long(2),Fields.InvalidMessage_persondatalayout_geo_long(3),Fields.InvalidMessage_persondatalayout_geo_long(4)
          ,Fields.InvalidMessage_persondatalayout_cbsa(1),Fields.InvalidMessage_persondatalayout_cbsa(2),Fields.InvalidMessage_persondatalayout_cbsa(3),Fields.InvalidMessage_persondatalayout_cbsa(4)
          ,Fields.InvalidMessage_persondatalayout_geo_blk(1),Fields.InvalidMessage_persondatalayout_geo_blk(2),Fields.InvalidMessage_persondatalayout_geo_blk(3),Fields.InvalidMessage_persondatalayout_geo_blk(4)
          ,Fields.InvalidMessage_persondatalayout_geo_match(1),Fields.InvalidMessage_persondatalayout_geo_match(2),Fields.InvalidMessage_persondatalayout_geo_match(3),Fields.InvalidMessage_persondatalayout_geo_match(4)
          ,Fields.InvalidMessage_persondatalayout_err_stat(1),Fields.InvalidMessage_persondatalayout_err_stat(2),Fields.InvalidMessage_persondatalayout_err_stat(3),Fields.InvalidMessage_persondatalayout_err_stat(4)
          ,Fields.InvalidMessage_persondatalayout_appended_ssn(1),Fields.InvalidMessage_persondatalayout_appended_ssn(2),Fields.InvalidMessage_persondatalayout_appended_ssn(3),Fields.InvalidMessage_persondatalayout_appended_ssn(4)
          ,Fields.InvalidMessage_persondatalayout_appended_adl(1),Fields.InvalidMessage_persondatalayout_appended_adl(2),Fields.InvalidMessage_persondatalayout_appended_adl(3),Fields.InvalidMessage_persondatalayout_appended_adl(4)
          ,Fields.InvalidMessage_permissablelayout_glb_purpose(1),Fields.InvalidMessage_permissablelayout_glb_purpose(2),Fields.InvalidMessage_permissablelayout_glb_purpose(3),Fields.InvalidMessage_permissablelayout_glb_purpose(4)
          ,Fields.InvalidMessage_permissablelayout_dppa_purpose(1),Fields.InvalidMessage_permissablelayout_dppa_purpose(2),Fields.InvalidMessage_permissablelayout_dppa_purpose(3),Fields.InvalidMessage_permissablelayout_dppa_purpose(4)
          ,Fields.InvalidMessage_permissablelayout_fcra_purpose(1),Fields.InvalidMessage_permissablelayout_fcra_purpose(2),Fields.InvalidMessage_permissablelayout_fcra_purpose(3),Fields.InvalidMessage_permissablelayout_fcra_purpose(4)
          ,Fields.InvalidMessage_searchlayout_datetime(1),Fields.InvalidMessage_searchlayout_datetime(2),Fields.InvalidMessage_searchlayout_datetime(3),Fields.InvalidMessage_searchlayout_datetime(4)
          ,Fields.InvalidMessage_searchlayout_start_monitor(1),Fields.InvalidMessage_searchlayout_start_monitor(2),Fields.InvalidMessage_searchlayout_start_monitor(3),Fields.InvalidMessage_searchlayout_start_monitor(4)
          ,Fields.InvalidMessage_searchlayout_stop_monitor(1),Fields.InvalidMessage_searchlayout_stop_monitor(2),Fields.InvalidMessage_searchlayout_stop_monitor(3),Fields.InvalidMessage_searchlayout_stop_monitor(4)
          ,Fields.InvalidMessage_searchlayout_login_history_id(1),Fields.InvalidMessage_searchlayout_login_history_id(2),Fields.InvalidMessage_searchlayout_login_history_id(3),Fields.InvalidMessage_searchlayout_login_history_id(4)
          ,Fields.InvalidMessage_searchlayout_transaction_id(1),Fields.InvalidMessage_searchlayout_transaction_id(2),Fields.InvalidMessage_searchlayout_transaction_id(3),Fields.InvalidMessage_searchlayout_transaction_id(4)
          ,Fields.InvalidMessage_searchlayout_sequence_number(1),Fields.InvalidMessage_searchlayout_sequence_number(2),Fields.InvalidMessage_searchlayout_sequence_number(3),Fields.InvalidMessage_searchlayout_sequence_number(4)
          ,Fields.InvalidMessage_searchlayout_method(1),Fields.InvalidMessage_searchlayout_method(2),Fields.InvalidMessage_searchlayout_method(3),Fields.InvalidMessage_searchlayout_method(4)
          ,Fields.InvalidMessage_searchlayout_product_code(1),Fields.InvalidMessage_searchlayout_product_code(2),Fields.InvalidMessage_searchlayout_product_code(3),Fields.InvalidMessage_searchlayout_product_code(4)
          ,Fields.InvalidMessage_searchlayout_transaction_type(1),Fields.InvalidMessage_searchlayout_transaction_type(2),Fields.InvalidMessage_searchlayout_transaction_type(3),Fields.InvalidMessage_searchlayout_transaction_type(4)
          ,Fields.InvalidMessage_searchlayout_function_description(1),Fields.InvalidMessage_searchlayout_function_description(2),Fields.InvalidMessage_searchlayout_function_description(3),Fields.InvalidMessage_searchlayout_function_description(4)
          ,Fields.InvalidMessage_searchlayout_ipaddr(1),Fields.InvalidMessage_searchlayout_ipaddr(2),Fields.InvalidMessage_searchlayout_ipaddr(3),Fields.InvalidMessage_searchlayout_ipaddr(4)
          ,Fields.InvalidMessage_fraudpoint_score(1),Fields.InvalidMessage_fraudpoint_score(2),Fields.InvalidMessage_fraudpoint_score(3),Fields.InvalidMessage_fraudpoint_score(4),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.mbslayout_company_id_LEFTTRIM_ErrorCount,le.mbslayout_company_id_ALLOW_ErrorCount,le.mbslayout_company_id_LENGTH_ErrorCount,le.mbslayout_company_id_WORDS_ErrorCount
          ,le.mbslayout_global_company_id_LEFTTRIM_ErrorCount,le.mbslayout_global_company_id_ALLOW_ErrorCount,le.mbslayout_global_company_id_LENGTH_ErrorCount,le.mbslayout_global_company_id_WORDS_ErrorCount
          ,le.allowlayout_allowflags_LEFTTRIM_ErrorCount,le.allowlayout_allowflags_ALLOW_ErrorCount,le.allowlayout_allowflags_LENGTH_ErrorCount,le.allowlayout_allowflags_WORDS_ErrorCount
          ,le.businfolayout_primary_market_code_LEFTTRIM_ErrorCount,le.businfolayout_primary_market_code_ALLOW_ErrorCount,le.businfolayout_primary_market_code_LENGTH_ErrorCount,le.businfolayout_primary_market_code_WORDS_ErrorCount
          ,le.businfolayout_secondary_market_code_LEFTTRIM_ErrorCount,le.businfolayout_secondary_market_code_ALLOW_ErrorCount,le.businfolayout_secondary_market_code_LENGTH_ErrorCount,le.businfolayout_secondary_market_code_WORDS_ErrorCount
          ,le.businfolayout_industry_1_code_LEFTTRIM_ErrorCount,le.businfolayout_industry_1_code_ALLOW_ErrorCount,le.businfolayout_industry_1_code_LENGTH_ErrorCount,le.businfolayout_industry_1_code_WORDS_ErrorCount
          ,le.businfolayout_industry_2_code_LEFTTRIM_ErrorCount,le.businfolayout_industry_2_code_ALLOW_ErrorCount,le.businfolayout_industry_2_code_LENGTH_ErrorCount,le.businfolayout_industry_2_code_WORDS_ErrorCount
          ,le.businfolayout_sub_market_LEFTTRIM_ErrorCount,le.businfolayout_sub_market_ALLOW_ErrorCount,le.businfolayout_sub_market_LENGTH_ErrorCount,le.businfolayout_sub_market_WORDS_ErrorCount
          ,le.businfolayout_vertical_LEFTTRIM_ErrorCount,le.businfolayout_vertical_ALLOW_ErrorCount,le.businfolayout_vertical_LENGTH_ErrorCount,le.businfolayout_vertical_WORDS_ErrorCount
          ,le.businfolayout_use_LEFTTRIM_ErrorCount,le.businfolayout_use_ALLOW_ErrorCount,le.businfolayout_use_LENGTH_ErrorCount,le.businfolayout_use_WORDS_ErrorCount
          ,le.businfolayout_industry_LEFTTRIM_ErrorCount,le.businfolayout_industry_ALLOW_ErrorCount,le.businfolayout_industry_LENGTH_ErrorCount,le.businfolayout_industry_WORDS_ErrorCount
          ,le.persondatalayout_full_name_LEFTTRIM_ErrorCount,le.persondatalayout_full_name_ALLOW_ErrorCount,le.persondatalayout_full_name_LENGTH_ErrorCount,le.persondatalayout_full_name_WORDS_ErrorCount
          ,le.persondatalayout_first_name_LEFTTRIM_ErrorCount,le.persondatalayout_first_name_ALLOW_ErrorCount,le.persondatalayout_first_name_LENGTH_ErrorCount,le.persondatalayout_first_name_WORDS_ErrorCount
          ,le.persondatalayout_middle_name_LEFTTRIM_ErrorCount,le.persondatalayout_middle_name_ALLOW_ErrorCount,le.persondatalayout_middle_name_LENGTH_ErrorCount,le.persondatalayout_middle_name_WORDS_ErrorCount
          ,le.persondatalayout_last_name_LEFTTRIM_ErrorCount,le.persondatalayout_last_name_ALLOW_ErrorCount,le.persondatalayout_last_name_LENGTH_ErrorCount,le.persondatalayout_last_name_WORDS_ErrorCount
          ,le.persondatalayout_address_LEFTTRIM_ErrorCount,le.persondatalayout_address_ALLOW_ErrorCount,le.persondatalayout_address_LENGTH_ErrorCount,le.persondatalayout_address_WORDS_ErrorCount
          ,le.persondatalayout_city_LEFTTRIM_ErrorCount,le.persondatalayout_city_ALLOW_ErrorCount,le.persondatalayout_city_LENGTH_ErrorCount,le.persondatalayout_city_WORDS_ErrorCount
          ,le.persondatalayout_state_LEFTTRIM_ErrorCount,le.persondatalayout_state_ALLOW_ErrorCount,le.persondatalayout_state_LENGTH_ErrorCount,le.persondatalayout_state_WORDS_ErrorCount
          ,le.persondatalayout_zip_LEFTTRIM_ErrorCount,le.persondatalayout_zip_ALLOW_ErrorCount,le.persondatalayout_zip_LENGTH_ErrorCount,le.persondatalayout_zip_WORDS_ErrorCount
          ,le.persondatalayout_personal_phone_ALLOW_ErrorCount,le.persondatalayout_personal_phone_LENGTH_ErrorCount,le.persondatalayout_personal_phone_WORDS_ErrorCount
          ,le.persondatalayout_work_phone_ALLOW_ErrorCount,le.persondatalayout_work_phone_LENGTH_ErrorCount,le.persondatalayout_work_phone_WORDS_ErrorCount
          ,le.persondatalayout_dob_LEFTTRIM_ErrorCount,le.persondatalayout_dob_ALLOW_ErrorCount,le.persondatalayout_dob_LENGTH_ErrorCount,le.persondatalayout_dob_WORDS_ErrorCount
          ,le.persondatalayout_dl_LEFTTRIM_ErrorCount,le.persondatalayout_dl_ALLOW_ErrorCount,le.persondatalayout_dl_LENGTH_ErrorCount,le.persondatalayout_dl_WORDS_ErrorCount
          ,le.persondatalayout_dl_st_LEFTTRIM_ErrorCount,le.persondatalayout_dl_st_ALLOW_ErrorCount,le.persondatalayout_dl_st_LENGTH_ErrorCount,le.persondatalayout_dl_st_WORDS_ErrorCount
          ,le.persondatalayout_email_address_LEFTTRIM_ErrorCount,le.persondatalayout_email_address_ALLOW_ErrorCount,le.persondatalayout_email_address_LENGTH_ErrorCount,le.persondatalayout_email_address_WORDS_ErrorCount
          ,le.persondatalayout_ssn_ALLOW_ErrorCount,le.persondatalayout_ssn_LENGTH_ErrorCount,le.persondatalayout_ssn_WORDS_ErrorCount
          ,le.persondatalayout_linkid_LEFTTRIM_ErrorCount,le.persondatalayout_linkid_ALLOW_ErrorCount,le.persondatalayout_linkid_LENGTH_ErrorCount,le.persondatalayout_linkid_WORDS_ErrorCount
          ,le.persondatalayout_ipaddr_LEFTTRIM_ErrorCount,le.persondatalayout_ipaddr_ALLOW_ErrorCount,le.persondatalayout_ipaddr_LENGTH_ErrorCount,le.persondatalayout_ipaddr_WORDS_ErrorCount
          ,le.persondatalayout_title_LEFTTRIM_ErrorCount,le.persondatalayout_title_ALLOW_ErrorCount,le.persondatalayout_title_LENGTH_ErrorCount,le.persondatalayout_title_WORDS_ErrorCount
          ,le.persondatalayout_fname_ALLOW_ErrorCount,le.persondatalayout_fname_LENGTH_ErrorCount,le.persondatalayout_fname_WORDS_ErrorCount
          ,le.persondatalayout_mname_ALLOW_ErrorCount,le.persondatalayout_mname_LENGTH_ErrorCount,le.persondatalayout_mname_WORDS_ErrorCount
          ,le.persondatalayout_lname_LEFTTRIM_ErrorCount,le.persondatalayout_lname_ALLOW_ErrorCount,le.persondatalayout_lname_LENGTH_ErrorCount,le.persondatalayout_lname_WORDS_ErrorCount
          ,le.persondatalayout_name_suffix_ALLOW_ErrorCount,le.persondatalayout_name_suffix_LENGTH_ErrorCount,le.persondatalayout_name_suffix_WORDS_ErrorCount
          ,le.persondatalayout_prim_range_LEFTTRIM_ErrorCount,le.persondatalayout_prim_range_ALLOW_ErrorCount,le.persondatalayout_prim_range_LENGTH_ErrorCount,le.persondatalayout_prim_range_WORDS_ErrorCount
          ,le.persondatalayout_predir_LEFTTRIM_ErrorCount,le.persondatalayout_predir_ALLOW_ErrorCount,le.persondatalayout_predir_LENGTH_ErrorCount,le.persondatalayout_predir_WORDS_ErrorCount
          ,le.persondatalayout_prim_name_LEFTTRIM_ErrorCount,le.persondatalayout_prim_name_ALLOW_ErrorCount,le.persondatalayout_prim_name_LENGTH_ErrorCount,le.persondatalayout_prim_name_WORDS_ErrorCount
          ,le.persondatalayout_addr_suffix_LEFTTRIM_ErrorCount,le.persondatalayout_addr_suffix_ALLOW_ErrorCount,le.persondatalayout_addr_suffix_LENGTH_ErrorCount,le.persondatalayout_addr_suffix_WORDS_ErrorCount
          ,le.persondatalayout_postdir_LEFTTRIM_ErrorCount,le.persondatalayout_postdir_ALLOW_ErrorCount,le.persondatalayout_postdir_LENGTH_ErrorCount,le.persondatalayout_postdir_WORDS_ErrorCount
          ,le.persondatalayout_unit_desig_LEFTTRIM_ErrorCount,le.persondatalayout_unit_desig_ALLOW_ErrorCount,le.persondatalayout_unit_desig_LENGTH_ErrorCount,le.persondatalayout_unit_desig_WORDS_ErrorCount
          ,le.persondatalayout_sec_range_LEFTTRIM_ErrorCount,le.persondatalayout_sec_range_ALLOW_ErrorCount,le.persondatalayout_sec_range_LENGTH_ErrorCount,le.persondatalayout_sec_range_WORDS_ErrorCount
          ,le.persondatalayout_v_city_name_LEFTTRIM_ErrorCount,le.persondatalayout_v_city_name_ALLOW_ErrorCount,le.persondatalayout_v_city_name_LENGTH_ErrorCount,le.persondatalayout_v_city_name_WORDS_ErrorCount
          ,le.persondatalayout_st_LEFTTRIM_ErrorCount,le.persondatalayout_st_ALLOW_ErrorCount,le.persondatalayout_st_LENGTH_ErrorCount,le.persondatalayout_st_WORDS_ErrorCount
          ,le.persondatalayout_zip5_LEFTTRIM_ErrorCount,le.persondatalayout_zip5_ALLOW_ErrorCount,le.persondatalayout_zip5_LENGTH_ErrorCount,le.persondatalayout_zip5_WORDS_ErrorCount
          ,le.persondatalayout_zip4_LEFTTRIM_ErrorCount,le.persondatalayout_zip4_ALLOW_ErrorCount,le.persondatalayout_zip4_LENGTH_ErrorCount,le.persondatalayout_zip4_WORDS_ErrorCount
          ,le.persondatalayout_addr_rec_type_LEFTTRIM_ErrorCount,le.persondatalayout_addr_rec_type_ALLOW_ErrorCount,le.persondatalayout_addr_rec_type_LENGTH_ErrorCount,le.persondatalayout_addr_rec_type_WORDS_ErrorCount
          ,le.persondatalayout_fips_state_LEFTTRIM_ErrorCount,le.persondatalayout_fips_state_ALLOW_ErrorCount,le.persondatalayout_fips_state_LENGTH_ErrorCount,le.persondatalayout_fips_state_WORDS_ErrorCount
          ,le.persondatalayout_fips_county_LEFTTRIM_ErrorCount,le.persondatalayout_fips_county_ALLOW_ErrorCount,le.persondatalayout_fips_county_LENGTH_ErrorCount,le.persondatalayout_fips_county_WORDS_ErrorCount
          ,le.persondatalayout_geo_lat_LEFTTRIM_ErrorCount,le.persondatalayout_geo_lat_ALLOW_ErrorCount,le.persondatalayout_geo_lat_LENGTH_ErrorCount,le.persondatalayout_geo_lat_WORDS_ErrorCount
          ,le.persondatalayout_geo_long_LEFTTRIM_ErrorCount,le.persondatalayout_geo_long_ALLOW_ErrorCount,le.persondatalayout_geo_long_LENGTH_ErrorCount,le.persondatalayout_geo_long_WORDS_ErrorCount
          ,le.persondatalayout_cbsa_LEFTTRIM_ErrorCount,le.persondatalayout_cbsa_ALLOW_ErrorCount,le.persondatalayout_cbsa_LENGTH_ErrorCount,le.persondatalayout_cbsa_WORDS_ErrorCount
          ,le.persondatalayout_geo_blk_LEFTTRIM_ErrorCount,le.persondatalayout_geo_blk_ALLOW_ErrorCount,le.persondatalayout_geo_blk_LENGTH_ErrorCount,le.persondatalayout_geo_blk_WORDS_ErrorCount
          ,le.persondatalayout_geo_match_LEFTTRIM_ErrorCount,le.persondatalayout_geo_match_ALLOW_ErrorCount,le.persondatalayout_geo_match_LENGTH_ErrorCount,le.persondatalayout_geo_match_WORDS_ErrorCount
          ,le.persondatalayout_err_stat_LEFTTRIM_ErrorCount,le.persondatalayout_err_stat_ALLOW_ErrorCount,le.persondatalayout_err_stat_LENGTH_ErrorCount,le.persondatalayout_err_stat_WORDS_ErrorCount
          ,le.persondatalayout_appended_ssn_LEFTTRIM_ErrorCount,le.persondatalayout_appended_ssn_ALLOW_ErrorCount,le.persondatalayout_appended_ssn_LENGTH_ErrorCount,le.persondatalayout_appended_ssn_WORDS_ErrorCount
          ,le.persondatalayout_appended_adl_LEFTTRIM_ErrorCount,le.persondatalayout_appended_adl_ALLOW_ErrorCount,le.persondatalayout_appended_adl_LENGTH_ErrorCount,le.persondatalayout_appended_adl_WORDS_ErrorCount
          ,le.permissablelayout_glb_purpose_LEFTTRIM_ErrorCount,le.permissablelayout_glb_purpose_ALLOW_ErrorCount,le.permissablelayout_glb_purpose_LENGTH_ErrorCount,le.permissablelayout_glb_purpose_WORDS_ErrorCount
          ,le.permissablelayout_dppa_purpose_LEFTTRIM_ErrorCount,le.permissablelayout_dppa_purpose_ALLOW_ErrorCount,le.permissablelayout_dppa_purpose_LENGTH_ErrorCount,le.permissablelayout_dppa_purpose_WORDS_ErrorCount
          ,le.permissablelayout_fcra_purpose_LEFTTRIM_ErrorCount,le.permissablelayout_fcra_purpose_ALLOW_ErrorCount,le.permissablelayout_fcra_purpose_LENGTH_ErrorCount,le.permissablelayout_fcra_purpose_WORDS_ErrorCount
          ,le.searchlayout_datetime_LEFTTRIM_ErrorCount,le.searchlayout_datetime_ALLOW_ErrorCount,le.searchlayout_datetime_LENGTH_ErrorCount,le.searchlayout_datetime_WORDS_ErrorCount
          ,le.searchlayout_start_monitor_LEFTTRIM_ErrorCount,le.searchlayout_start_monitor_ALLOW_ErrorCount,le.searchlayout_start_monitor_LENGTH_ErrorCount,le.searchlayout_start_monitor_WORDS_ErrorCount
          ,le.searchlayout_stop_monitor_LEFTTRIM_ErrorCount,le.searchlayout_stop_monitor_ALLOW_ErrorCount,le.searchlayout_stop_monitor_LENGTH_ErrorCount,le.searchlayout_stop_monitor_WORDS_ErrorCount
          ,le.searchlayout_login_history_id_LEFTTRIM_ErrorCount,le.searchlayout_login_history_id_ALLOW_ErrorCount,le.searchlayout_login_history_id_LENGTH_ErrorCount,le.searchlayout_login_history_id_WORDS_ErrorCount
          ,le.searchlayout_transaction_id_LEFTTRIM_ErrorCount,le.searchlayout_transaction_id_ALLOW_ErrorCount,le.searchlayout_transaction_id_LENGTH_ErrorCount,le.searchlayout_transaction_id_WORDS_ErrorCount
          ,le.searchlayout_sequence_number_LEFTTRIM_ErrorCount,le.searchlayout_sequence_number_ALLOW_ErrorCount,le.searchlayout_sequence_number_LENGTH_ErrorCount,le.searchlayout_sequence_number_WORDS_ErrorCount
          ,le.searchlayout_method_LEFTTRIM_ErrorCount,le.searchlayout_method_ALLOW_ErrorCount,le.searchlayout_method_LENGTH_ErrorCount,le.searchlayout_method_WORDS_ErrorCount
          ,le.searchlayout_product_code_LEFTTRIM_ErrorCount,le.searchlayout_product_code_ALLOW_ErrorCount,le.searchlayout_product_code_LENGTH_ErrorCount,le.searchlayout_product_code_WORDS_ErrorCount
          ,le.searchlayout_transaction_type_LEFTTRIM_ErrorCount,le.searchlayout_transaction_type_ALLOW_ErrorCount,le.searchlayout_transaction_type_LENGTH_ErrorCount,le.searchlayout_transaction_type_WORDS_ErrorCount
          ,le.searchlayout_function_description_LEFTTRIM_ErrorCount,le.searchlayout_function_description_ALLOW_ErrorCount,le.searchlayout_function_description_LENGTH_ErrorCount,le.searchlayout_function_description_WORDS_ErrorCount
          ,le.searchlayout_ipaddr_LEFTTRIM_ErrorCount,le.searchlayout_ipaddr_ALLOW_ErrorCount,le.searchlayout_ipaddr_LENGTH_ErrorCount,le.searchlayout_ipaddr_WORDS_ErrorCount
          ,le.fraudpoint_score_LEFTTRIM_ErrorCount,le.fraudpoint_score_ALLOW_ErrorCount,le.fraudpoint_score_LENGTH_ErrorCount,le.fraudpoint_score_WORDS_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.mbslayout_company_id_LEFTTRIM_ErrorCount,le.mbslayout_company_id_ALLOW_ErrorCount,le.mbslayout_company_id_LENGTH_ErrorCount,le.mbslayout_company_id_WORDS_ErrorCount
          ,le.mbslayout_global_company_id_LEFTTRIM_ErrorCount,le.mbslayout_global_company_id_ALLOW_ErrorCount,le.mbslayout_global_company_id_LENGTH_ErrorCount,le.mbslayout_global_company_id_WORDS_ErrorCount
          ,le.allowlayout_allowflags_LEFTTRIM_ErrorCount,le.allowlayout_allowflags_ALLOW_ErrorCount,le.allowlayout_allowflags_LENGTH_ErrorCount,le.allowlayout_allowflags_WORDS_ErrorCount
          ,le.businfolayout_primary_market_code_LEFTTRIM_ErrorCount,le.businfolayout_primary_market_code_ALLOW_ErrorCount,le.businfolayout_primary_market_code_LENGTH_ErrorCount,le.businfolayout_primary_market_code_WORDS_ErrorCount
          ,le.businfolayout_secondary_market_code_LEFTTRIM_ErrorCount,le.businfolayout_secondary_market_code_ALLOW_ErrorCount,le.businfolayout_secondary_market_code_LENGTH_ErrorCount,le.businfolayout_secondary_market_code_WORDS_ErrorCount
          ,le.businfolayout_industry_1_code_LEFTTRIM_ErrorCount,le.businfolayout_industry_1_code_ALLOW_ErrorCount,le.businfolayout_industry_1_code_LENGTH_ErrorCount,le.businfolayout_industry_1_code_WORDS_ErrorCount
          ,le.businfolayout_industry_2_code_LEFTTRIM_ErrorCount,le.businfolayout_industry_2_code_ALLOW_ErrorCount,le.businfolayout_industry_2_code_LENGTH_ErrorCount,le.businfolayout_industry_2_code_WORDS_ErrorCount
          ,le.businfolayout_sub_market_LEFTTRIM_ErrorCount,le.businfolayout_sub_market_ALLOW_ErrorCount,le.businfolayout_sub_market_LENGTH_ErrorCount,le.businfolayout_sub_market_WORDS_ErrorCount
          ,le.businfolayout_vertical_LEFTTRIM_ErrorCount,le.businfolayout_vertical_ALLOW_ErrorCount,le.businfolayout_vertical_LENGTH_ErrorCount,le.businfolayout_vertical_WORDS_ErrorCount
          ,le.businfolayout_use_LEFTTRIM_ErrorCount,le.businfolayout_use_ALLOW_ErrorCount,le.businfolayout_use_LENGTH_ErrorCount,le.businfolayout_use_WORDS_ErrorCount
          ,le.businfolayout_industry_LEFTTRIM_ErrorCount,le.businfolayout_industry_ALLOW_ErrorCount,le.businfolayout_industry_LENGTH_ErrorCount,le.businfolayout_industry_WORDS_ErrorCount
          ,le.persondatalayout_full_name_LEFTTRIM_ErrorCount,le.persondatalayout_full_name_ALLOW_ErrorCount,le.persondatalayout_full_name_LENGTH_ErrorCount,le.persondatalayout_full_name_WORDS_ErrorCount
          ,le.persondatalayout_first_name_LEFTTRIM_ErrorCount,le.persondatalayout_first_name_ALLOW_ErrorCount,le.persondatalayout_first_name_LENGTH_ErrorCount,le.persondatalayout_first_name_WORDS_ErrorCount
          ,le.persondatalayout_middle_name_LEFTTRIM_ErrorCount,le.persondatalayout_middle_name_ALLOW_ErrorCount,le.persondatalayout_middle_name_LENGTH_ErrorCount,le.persondatalayout_middle_name_WORDS_ErrorCount
          ,le.persondatalayout_last_name_LEFTTRIM_ErrorCount,le.persondatalayout_last_name_ALLOW_ErrorCount,le.persondatalayout_last_name_LENGTH_ErrorCount,le.persondatalayout_last_name_WORDS_ErrorCount
          ,le.persondatalayout_address_LEFTTRIM_ErrorCount,le.persondatalayout_address_ALLOW_ErrorCount,le.persondatalayout_address_LENGTH_ErrorCount,le.persondatalayout_address_WORDS_ErrorCount
          ,le.persondatalayout_city_LEFTTRIM_ErrorCount,le.persondatalayout_city_ALLOW_ErrorCount,le.persondatalayout_city_LENGTH_ErrorCount,le.persondatalayout_city_WORDS_ErrorCount
          ,le.persondatalayout_state_LEFTTRIM_ErrorCount,le.persondatalayout_state_ALLOW_ErrorCount,le.persondatalayout_state_LENGTH_ErrorCount,le.persondatalayout_state_WORDS_ErrorCount
          ,le.persondatalayout_zip_LEFTTRIM_ErrorCount,le.persondatalayout_zip_ALLOW_ErrorCount,le.persondatalayout_zip_LENGTH_ErrorCount,le.persondatalayout_zip_WORDS_ErrorCount
          ,le.persondatalayout_personal_phone_ALLOW_ErrorCount,le.persondatalayout_personal_phone_LENGTH_ErrorCount,le.persondatalayout_personal_phone_WORDS_ErrorCount
          ,le.persondatalayout_work_phone_ALLOW_ErrorCount,le.persondatalayout_work_phone_LENGTH_ErrorCount,le.persondatalayout_work_phone_WORDS_ErrorCount
          ,le.persondatalayout_dob_LEFTTRIM_ErrorCount,le.persondatalayout_dob_ALLOW_ErrorCount,le.persondatalayout_dob_LENGTH_ErrorCount,le.persondatalayout_dob_WORDS_ErrorCount
          ,le.persondatalayout_dl_LEFTTRIM_ErrorCount,le.persondatalayout_dl_ALLOW_ErrorCount,le.persondatalayout_dl_LENGTH_ErrorCount,le.persondatalayout_dl_WORDS_ErrorCount
          ,le.persondatalayout_dl_st_LEFTTRIM_ErrorCount,le.persondatalayout_dl_st_ALLOW_ErrorCount,le.persondatalayout_dl_st_LENGTH_ErrorCount,le.persondatalayout_dl_st_WORDS_ErrorCount
          ,le.persondatalayout_email_address_LEFTTRIM_ErrorCount,le.persondatalayout_email_address_ALLOW_ErrorCount,le.persondatalayout_email_address_LENGTH_ErrorCount,le.persondatalayout_email_address_WORDS_ErrorCount
          ,le.persondatalayout_ssn_ALLOW_ErrorCount,le.persondatalayout_ssn_LENGTH_ErrorCount,le.persondatalayout_ssn_WORDS_ErrorCount
          ,le.persondatalayout_linkid_LEFTTRIM_ErrorCount,le.persondatalayout_linkid_ALLOW_ErrorCount,le.persondatalayout_linkid_LENGTH_ErrorCount,le.persondatalayout_linkid_WORDS_ErrorCount
          ,le.persondatalayout_ipaddr_LEFTTRIM_ErrorCount,le.persondatalayout_ipaddr_ALLOW_ErrorCount,le.persondatalayout_ipaddr_LENGTH_ErrorCount,le.persondatalayout_ipaddr_WORDS_ErrorCount
          ,le.persondatalayout_title_LEFTTRIM_ErrorCount,le.persondatalayout_title_ALLOW_ErrorCount,le.persondatalayout_title_LENGTH_ErrorCount,le.persondatalayout_title_WORDS_ErrorCount
          ,le.persondatalayout_fname_ALLOW_ErrorCount,le.persondatalayout_fname_LENGTH_ErrorCount,le.persondatalayout_fname_WORDS_ErrorCount
          ,le.persondatalayout_mname_ALLOW_ErrorCount,le.persondatalayout_mname_LENGTH_ErrorCount,le.persondatalayout_mname_WORDS_ErrorCount
          ,le.persondatalayout_lname_LEFTTRIM_ErrorCount,le.persondatalayout_lname_ALLOW_ErrorCount,le.persondatalayout_lname_LENGTH_ErrorCount,le.persondatalayout_lname_WORDS_ErrorCount
          ,le.persondatalayout_name_suffix_ALLOW_ErrorCount,le.persondatalayout_name_suffix_LENGTH_ErrorCount,le.persondatalayout_name_suffix_WORDS_ErrorCount
          ,le.persondatalayout_prim_range_LEFTTRIM_ErrorCount,le.persondatalayout_prim_range_ALLOW_ErrorCount,le.persondatalayout_prim_range_LENGTH_ErrorCount,le.persondatalayout_prim_range_WORDS_ErrorCount
          ,le.persondatalayout_predir_LEFTTRIM_ErrorCount,le.persondatalayout_predir_ALLOW_ErrorCount,le.persondatalayout_predir_LENGTH_ErrorCount,le.persondatalayout_predir_WORDS_ErrorCount
          ,le.persondatalayout_prim_name_LEFTTRIM_ErrorCount,le.persondatalayout_prim_name_ALLOW_ErrorCount,le.persondatalayout_prim_name_LENGTH_ErrorCount,le.persondatalayout_prim_name_WORDS_ErrorCount
          ,le.persondatalayout_addr_suffix_LEFTTRIM_ErrorCount,le.persondatalayout_addr_suffix_ALLOW_ErrorCount,le.persondatalayout_addr_suffix_LENGTH_ErrorCount,le.persondatalayout_addr_suffix_WORDS_ErrorCount
          ,le.persondatalayout_postdir_LEFTTRIM_ErrorCount,le.persondatalayout_postdir_ALLOW_ErrorCount,le.persondatalayout_postdir_LENGTH_ErrorCount,le.persondatalayout_postdir_WORDS_ErrorCount
          ,le.persondatalayout_unit_desig_LEFTTRIM_ErrorCount,le.persondatalayout_unit_desig_ALLOW_ErrorCount,le.persondatalayout_unit_desig_LENGTH_ErrorCount,le.persondatalayout_unit_desig_WORDS_ErrorCount
          ,le.persondatalayout_sec_range_LEFTTRIM_ErrorCount,le.persondatalayout_sec_range_ALLOW_ErrorCount,le.persondatalayout_sec_range_LENGTH_ErrorCount,le.persondatalayout_sec_range_WORDS_ErrorCount
          ,le.persondatalayout_v_city_name_LEFTTRIM_ErrorCount,le.persondatalayout_v_city_name_ALLOW_ErrorCount,le.persondatalayout_v_city_name_LENGTH_ErrorCount,le.persondatalayout_v_city_name_WORDS_ErrorCount
          ,le.persondatalayout_st_LEFTTRIM_ErrorCount,le.persondatalayout_st_ALLOW_ErrorCount,le.persondatalayout_st_LENGTH_ErrorCount,le.persondatalayout_st_WORDS_ErrorCount
          ,le.persondatalayout_zip5_LEFTTRIM_ErrorCount,le.persondatalayout_zip5_ALLOW_ErrorCount,le.persondatalayout_zip5_LENGTH_ErrorCount,le.persondatalayout_zip5_WORDS_ErrorCount
          ,le.persondatalayout_zip4_LEFTTRIM_ErrorCount,le.persondatalayout_zip4_ALLOW_ErrorCount,le.persondatalayout_zip4_LENGTH_ErrorCount,le.persondatalayout_zip4_WORDS_ErrorCount
          ,le.persondatalayout_addr_rec_type_LEFTTRIM_ErrorCount,le.persondatalayout_addr_rec_type_ALLOW_ErrorCount,le.persondatalayout_addr_rec_type_LENGTH_ErrorCount,le.persondatalayout_addr_rec_type_WORDS_ErrorCount
          ,le.persondatalayout_fips_state_LEFTTRIM_ErrorCount,le.persondatalayout_fips_state_ALLOW_ErrorCount,le.persondatalayout_fips_state_LENGTH_ErrorCount,le.persondatalayout_fips_state_WORDS_ErrorCount
          ,le.persondatalayout_fips_county_LEFTTRIM_ErrorCount,le.persondatalayout_fips_county_ALLOW_ErrorCount,le.persondatalayout_fips_county_LENGTH_ErrorCount,le.persondatalayout_fips_county_WORDS_ErrorCount
          ,le.persondatalayout_geo_lat_LEFTTRIM_ErrorCount,le.persondatalayout_geo_lat_ALLOW_ErrorCount,le.persondatalayout_geo_lat_LENGTH_ErrorCount,le.persondatalayout_geo_lat_WORDS_ErrorCount
          ,le.persondatalayout_geo_long_LEFTTRIM_ErrorCount,le.persondatalayout_geo_long_ALLOW_ErrorCount,le.persondatalayout_geo_long_LENGTH_ErrorCount,le.persondatalayout_geo_long_WORDS_ErrorCount
          ,le.persondatalayout_cbsa_LEFTTRIM_ErrorCount,le.persondatalayout_cbsa_ALLOW_ErrorCount,le.persondatalayout_cbsa_LENGTH_ErrorCount,le.persondatalayout_cbsa_WORDS_ErrorCount
          ,le.persondatalayout_geo_blk_LEFTTRIM_ErrorCount,le.persondatalayout_geo_blk_ALLOW_ErrorCount,le.persondatalayout_geo_blk_LENGTH_ErrorCount,le.persondatalayout_geo_blk_WORDS_ErrorCount
          ,le.persondatalayout_geo_match_LEFTTRIM_ErrorCount,le.persondatalayout_geo_match_ALLOW_ErrorCount,le.persondatalayout_geo_match_LENGTH_ErrorCount,le.persondatalayout_geo_match_WORDS_ErrorCount
          ,le.persondatalayout_err_stat_LEFTTRIM_ErrorCount,le.persondatalayout_err_stat_ALLOW_ErrorCount,le.persondatalayout_err_stat_LENGTH_ErrorCount,le.persondatalayout_err_stat_WORDS_ErrorCount
          ,le.persondatalayout_appended_ssn_LEFTTRIM_ErrorCount,le.persondatalayout_appended_ssn_ALLOW_ErrorCount,le.persondatalayout_appended_ssn_LENGTH_ErrorCount,le.persondatalayout_appended_ssn_WORDS_ErrorCount
          ,le.persondatalayout_appended_adl_LEFTTRIM_ErrorCount,le.persondatalayout_appended_adl_ALLOW_ErrorCount,le.persondatalayout_appended_adl_LENGTH_ErrorCount,le.persondatalayout_appended_adl_WORDS_ErrorCount
          ,le.permissablelayout_glb_purpose_LEFTTRIM_ErrorCount,le.permissablelayout_glb_purpose_ALLOW_ErrorCount,le.permissablelayout_glb_purpose_LENGTH_ErrorCount,le.permissablelayout_glb_purpose_WORDS_ErrorCount
          ,le.permissablelayout_dppa_purpose_LEFTTRIM_ErrorCount,le.permissablelayout_dppa_purpose_ALLOW_ErrorCount,le.permissablelayout_dppa_purpose_LENGTH_ErrorCount,le.permissablelayout_dppa_purpose_WORDS_ErrorCount
          ,le.permissablelayout_fcra_purpose_LEFTTRIM_ErrorCount,le.permissablelayout_fcra_purpose_ALLOW_ErrorCount,le.permissablelayout_fcra_purpose_LENGTH_ErrorCount,le.permissablelayout_fcra_purpose_WORDS_ErrorCount
          ,le.searchlayout_datetime_LEFTTRIM_ErrorCount,le.searchlayout_datetime_ALLOW_ErrorCount,le.searchlayout_datetime_LENGTH_ErrorCount,le.searchlayout_datetime_WORDS_ErrorCount
          ,le.searchlayout_start_monitor_LEFTTRIM_ErrorCount,le.searchlayout_start_monitor_ALLOW_ErrorCount,le.searchlayout_start_monitor_LENGTH_ErrorCount,le.searchlayout_start_monitor_WORDS_ErrorCount
          ,le.searchlayout_stop_monitor_LEFTTRIM_ErrorCount,le.searchlayout_stop_monitor_ALLOW_ErrorCount,le.searchlayout_stop_monitor_LENGTH_ErrorCount,le.searchlayout_stop_monitor_WORDS_ErrorCount
          ,le.searchlayout_login_history_id_LEFTTRIM_ErrorCount,le.searchlayout_login_history_id_ALLOW_ErrorCount,le.searchlayout_login_history_id_LENGTH_ErrorCount,le.searchlayout_login_history_id_WORDS_ErrorCount
          ,le.searchlayout_transaction_id_LEFTTRIM_ErrorCount,le.searchlayout_transaction_id_ALLOW_ErrorCount,le.searchlayout_transaction_id_LENGTH_ErrorCount,le.searchlayout_transaction_id_WORDS_ErrorCount
          ,le.searchlayout_sequence_number_LEFTTRIM_ErrorCount,le.searchlayout_sequence_number_ALLOW_ErrorCount,le.searchlayout_sequence_number_LENGTH_ErrorCount,le.searchlayout_sequence_number_WORDS_ErrorCount
          ,le.searchlayout_method_LEFTTRIM_ErrorCount,le.searchlayout_method_ALLOW_ErrorCount,le.searchlayout_method_LENGTH_ErrorCount,le.searchlayout_method_WORDS_ErrorCount
          ,le.searchlayout_product_code_LEFTTRIM_ErrorCount,le.searchlayout_product_code_ALLOW_ErrorCount,le.searchlayout_product_code_LENGTH_ErrorCount,le.searchlayout_product_code_WORDS_ErrorCount
          ,le.searchlayout_transaction_type_LEFTTRIM_ErrorCount,le.searchlayout_transaction_type_ALLOW_ErrorCount,le.searchlayout_transaction_type_LENGTH_ErrorCount,le.searchlayout_transaction_type_WORDS_ErrorCount
          ,le.searchlayout_function_description_LEFTTRIM_ErrorCount,le.searchlayout_function_description_ALLOW_ErrorCount,le.searchlayout_function_description_LENGTH_ErrorCount,le.searchlayout_function_description_WORDS_ErrorCount
          ,le.searchlayout_ipaddr_LEFTTRIM_ErrorCount,le.searchlayout_ipaddr_ALLOW_ErrorCount,le.searchlayout_ipaddr_LENGTH_ErrorCount,le.searchlayout_ipaddr_WORDS_ErrorCount
          ,le.fraudpoint_score_LEFTTRIM_ErrorCount,le.fraudpoint_score_ALLOW_ErrorCount,le.fraudpoint_score_LENGTH_ErrorCount,le.fraudpoint_score_WORDS_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,274,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT32.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT32.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
