IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_In_WI) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_append_process_date_pcnt := AVE(GROUP,IF(h.append_process_date = (TYPEOF(h.append_process_date))'',0,100));
    maxlength_append_process_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_process_date)));
    avelength_append_process_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_process_date)),h.append_process_date<>(typeof(h.append_process_date))'');
    populated_orig_dl_number_pcnt := AVE(GROUP,IF(h.orig_dl_number = (TYPEOF(h.orig_dl_number))'',0,100));
    maxlength_orig_dl_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dl_number)));
    avelength_orig_dl_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dl_number)),h.orig_dl_number<>(typeof(h.orig_dl_number))'');
    populated_orig_last_name_pcnt := AVE(GROUP,IF(h.orig_last_name = (TYPEOF(h.orig_last_name))'',0,100));
    maxlength_orig_last_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_last_name)));
    avelength_orig_last_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_last_name)),h.orig_last_name<>(typeof(h.orig_last_name))'');
    populated_orig_first_name_pcnt := AVE(GROUP,IF(h.orig_first_name = (TYPEOF(h.orig_first_name))'',0,100));
    maxlength_orig_first_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_first_name)));
    avelength_orig_first_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_first_name)),h.orig_first_name<>(typeof(h.orig_first_name))'');
    populated_orig_middle_initial_pcnt := AVE(GROUP,IF(h.orig_middle_initial = (TYPEOF(h.orig_middle_initial))'',0,100));
    maxlength_orig_middle_initial := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_middle_initial)));
    avelength_orig_middle_initial := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_middle_initial)),h.orig_middle_initial<>(typeof(h.orig_middle_initial))'');
    populated_orig_sex_pcnt := AVE(GROUP,IF(h.orig_sex = (TYPEOF(h.orig_sex))'',0,100));
    maxlength_orig_sex := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_sex)));
    avelength_orig_sex := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_sex)),h.orig_sex<>(typeof(h.orig_sex))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_address1_pcnt := AVE(GROUP,IF(h.orig_address1 = (TYPEOF(h.orig_address1))'',0,100));
    maxlength_orig_address1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_address1)));
    avelength_orig_address1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_address1)),h.orig_address1<>(typeof(h.orig_address1))'');
    populated_orig_address2_pcnt := AVE(GROUP,IF(h.orig_address2 = (TYPEOF(h.orig_address2))'',0,100));
    maxlength_orig_address2 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_address2)));
    avelength_orig_address2 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_address2)),h.orig_address2<>(typeof(h.orig_address2))'');
    populated_append_po_box_pcnt := AVE(GROUP,IF(h.append_po_box = (TYPEOF(h.append_po_box))'',0,100));
    maxlength_append_po_box := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_po_box)));
    avelength_append_po_box := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_po_box)),h.append_po_box<>(typeof(h.append_po_box))'');
    populated_orig_county_name_pcnt := AVE(GROUP,IF(h.orig_county_name = (TYPEOF(h.orig_county_name))'',0,100));
    maxlength_orig_county_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_county_name)));
    avelength_orig_county_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_county_name)),h.orig_county_name<>(typeof(h.orig_county_name))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_code_pcnt := AVE(GROUP,IF(h.orig_zip_code = (TYPEOF(h.orig_zip_code))'',0,100));
    maxlength_orig_zip_code := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_zip_code)));
    avelength_orig_zip_code := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_zip_code)),h.orig_zip_code<>(typeof(h.orig_zip_code))'');
    populated_orig_opt_out_code_pcnt := AVE(GROUP,IF(h.orig_opt_out_code = (TYPEOF(h.orig_opt_out_code))'',0,100));
    maxlength_orig_opt_out_code := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_opt_out_code)));
    avelength_orig_opt_out_code := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_opt_out_code)),h.orig_opt_out_code<>(typeof(h.orig_opt_out_code))'');
    populated_orig_license_counter_pcnt := AVE(GROUP,IF(h.orig_license_counter = (TYPEOF(h.orig_license_counter))'',0,100));
    maxlength_orig_license_counter := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_license_counter)));
    avelength_orig_license_counter := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_license_counter)),h.orig_license_counter<>(typeof(h.orig_license_counter))'');
    populated_append_license_type_pcnt := AVE(GROUP,IF(h.append_license_type = (TYPEOF(h.append_license_type))'',0,100));
    maxlength_append_license_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_license_type)));
    avelength_append_license_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_license_type)),h.append_license_type<>(typeof(h.append_license_type))'');
    populated_append_classes_pcnt := AVE(GROUP,IF(h.append_classes = (TYPEOF(h.append_classes))'',0,100));
    maxlength_append_classes := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_classes)));
    avelength_append_classes := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_classes)),h.append_classes<>(typeof(h.append_classes))'');
    populated_append_endorsements_pcnt := AVE(GROUP,IF(h.append_endorsements = (TYPEOF(h.append_endorsements))'',0,100));
    maxlength_append_endorsements := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_endorsements)));
    avelength_append_endorsements := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_endorsements)),h.append_endorsements<>(typeof(h.append_endorsements))'');
    populated_append_issue_date_pcnt := AVE(GROUP,IF(h.append_issue_date = (TYPEOF(h.append_issue_date))'',0,100));
    maxlength_append_issue_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_issue_date)));
    avelength_append_issue_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_issue_date)),h.append_issue_date<>(typeof(h.append_issue_date))'');
    populated_append_expiration_date_pcnt := AVE(GROUP,IF(h.append_expiration_date = (TYPEOF(h.append_expiration_date))'',0,100));
    maxlength_append_expiration_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_expiration_date)));
    avelength_append_expiration_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_expiration_date)),h.append_expiration_date<>(typeof(h.append_expiration_date))'');
    populated_clean_name_prefix_pcnt := AVE(GROUP,IF(h.clean_name_prefix = (TYPEOF(h.clean_name_prefix))'',0,100));
    maxlength_clean_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_prefix)));
    avelength_clean_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_prefix)),h.clean_name_prefix<>(typeof(h.clean_name_prefix))'');
    populated_clean_name_first_pcnt := AVE(GROUP,IF(h.clean_name_first = (TYPEOF(h.clean_name_first))'',0,100));
    maxlength_clean_name_first := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_first)));
    avelength_clean_name_first := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_first)),h.clean_name_first<>(typeof(h.clean_name_first))'');
    populated_clean_name_middle_pcnt := AVE(GROUP,IF(h.clean_name_middle = (TYPEOF(h.clean_name_middle))'',0,100));
    maxlength_clean_name_middle := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_middle)));
    avelength_clean_name_middle := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_middle)),h.clean_name_middle<>(typeof(h.clean_name_middle))'');
    populated_clean_name_last_pcnt := AVE(GROUP,IF(h.clean_name_last = (TYPEOF(h.clean_name_last))'',0,100));
    maxlength_clean_name_last := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_last)));
    avelength_clean_name_last := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_last)),h.clean_name_last<>(typeof(h.clean_name_last))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
    populated_clean_prim_range_pcnt := AVE(GROUP,IF(h.clean_prim_range = (TYPEOF(h.clean_prim_range))'',0,100));
    maxlength_clean_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_prim_range)));
    avelength_clean_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_prim_range)),h.clean_prim_range<>(typeof(h.clean_prim_range))'');
    populated_clean_predir_pcnt := AVE(GROUP,IF(h.clean_predir = (TYPEOF(h.clean_predir))'',0,100));
    maxlength_clean_predir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_predir)));
    avelength_clean_predir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_predir)),h.clean_predir<>(typeof(h.clean_predir))'');
    populated_clean_prim_name_pcnt := AVE(GROUP,IF(h.clean_prim_name = (TYPEOF(h.clean_prim_name))'',0,100));
    maxlength_clean_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_prim_name)));
    avelength_clean_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_prim_name)),h.clean_prim_name<>(typeof(h.clean_prim_name))'');
    populated_clean_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_addr_suffix = (TYPEOF(h.clean_addr_suffix))'',0,100));
    maxlength_clean_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_addr_suffix)));
    avelength_clean_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_addr_suffix)),h.clean_addr_suffix<>(typeof(h.clean_addr_suffix))'');
    populated_clean_postdir_pcnt := AVE(GROUP,IF(h.clean_postdir = (TYPEOF(h.clean_postdir))'',0,100));
    maxlength_clean_postdir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_postdir)));
    avelength_clean_postdir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_postdir)),h.clean_postdir<>(typeof(h.clean_postdir))'');
    populated_clean_unit_desig_pcnt := AVE(GROUP,IF(h.clean_unit_desig = (TYPEOF(h.clean_unit_desig))'',0,100));
    maxlength_clean_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_unit_desig)));
    avelength_clean_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_unit_desig)),h.clean_unit_desig<>(typeof(h.clean_unit_desig))'');
    populated_clean_sec_range_pcnt := AVE(GROUP,IF(h.clean_sec_range = (TYPEOF(h.clean_sec_range))'',0,100));
    maxlength_clean_sec_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_sec_range)));
    avelength_clean_sec_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_sec_range)),h.clean_sec_range<>(typeof(h.clean_sec_range))'');
    populated_clean_p_city_name_pcnt := AVE(GROUP,IF(h.clean_p_city_name = (TYPEOF(h.clean_p_city_name))'',0,100));
    maxlength_clean_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_city_name)));
    avelength_clean_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_city_name)),h.clean_p_city_name<>(typeof(h.clean_p_city_name))'');
    populated_clean_v_city_name_pcnt := AVE(GROUP,IF(h.clean_v_city_name = (TYPEOF(h.clean_v_city_name))'',0,100));
    maxlength_clean_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_v_city_name)));
    avelength_clean_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_v_city_name)),h.clean_v_city_name<>(typeof(h.clean_v_city_name))'');
    populated_clean_st_pcnt := AVE(GROUP,IF(h.clean_st = (TYPEOF(h.clean_st))'',0,100));
    maxlength_clean_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_st)));
    avelength_clean_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_st)),h.clean_st<>(typeof(h.clean_st))'');
    populated_clean_zip_pcnt := AVE(GROUP,IF(h.clean_zip = (TYPEOF(h.clean_zip))'',0,100));
    maxlength_clean_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_zip)));
    avelength_clean_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_zip)),h.clean_zip<>(typeof(h.clean_zip))'');
    populated_clean_zip4_pcnt := AVE(GROUP,IF(h.clean_zip4 = (TYPEOF(h.clean_zip4))'',0,100));
    maxlength_clean_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_zip4)));
    avelength_clean_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_zip4)),h.clean_zip4<>(typeof(h.clean_zip4))'');
    populated_clean_cart_pcnt := AVE(GROUP,IF(h.clean_cart = (TYPEOF(h.clean_cart))'',0,100));
    maxlength_clean_cart := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_cart)));
    avelength_clean_cart := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_cart)),h.clean_cart<>(typeof(h.clean_cart))'');
    populated_clean_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_cr_sort_sz = (TYPEOF(h.clean_cr_sort_sz))'',0,100));
    maxlength_clean_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_cr_sort_sz)));
    avelength_clean_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_cr_sort_sz)),h.clean_cr_sort_sz<>(typeof(h.clean_cr_sort_sz))'');
    populated_clean_lot_pcnt := AVE(GROUP,IF(h.clean_lot = (TYPEOF(h.clean_lot))'',0,100));
    maxlength_clean_lot := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_lot)));
    avelength_clean_lot := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_lot)),h.clean_lot<>(typeof(h.clean_lot))'');
    populated_clean_lot_order_pcnt := AVE(GROUP,IF(h.clean_lot_order = (TYPEOF(h.clean_lot_order))'',0,100));
    maxlength_clean_lot_order := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_lot_order)));
    avelength_clean_lot_order := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_lot_order)),h.clean_lot_order<>(typeof(h.clean_lot_order))'');
    populated_clean_dpbc_pcnt := AVE(GROUP,IF(h.clean_dpbc = (TYPEOF(h.clean_dpbc))'',0,100));
    maxlength_clean_dpbc := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_dpbc)));
    avelength_clean_dpbc := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_dpbc)),h.clean_dpbc<>(typeof(h.clean_dpbc))'');
    populated_clean_chk_digit_pcnt := AVE(GROUP,IF(h.clean_chk_digit = (TYPEOF(h.clean_chk_digit))'',0,100));
    maxlength_clean_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_chk_digit)));
    avelength_clean_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_chk_digit)),h.clean_chk_digit<>(typeof(h.clean_chk_digit))'');
    populated_clean_record_type_pcnt := AVE(GROUP,IF(h.clean_record_type = (TYPEOF(h.clean_record_type))'',0,100));
    maxlength_clean_record_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_record_type)));
    avelength_clean_record_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_record_type)),h.clean_record_type<>(typeof(h.clean_record_type))'');
    populated_clean_ace_fips_st_pcnt := AVE(GROUP,IF(h.clean_ace_fips_st = (TYPEOF(h.clean_ace_fips_st))'',0,100));
    maxlength_clean_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_ace_fips_st)));
    avelength_clean_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_ace_fips_st)),h.clean_ace_fips_st<>(typeof(h.clean_ace_fips_st))'');
    populated_clean_fipscounty_pcnt := AVE(GROUP,IF(h.clean_fipscounty = (TYPEOF(h.clean_fipscounty))'',0,100));
    maxlength_clean_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_fipscounty)));
    avelength_clean_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_fipscounty)),h.clean_fipscounty<>(typeof(h.clean_fipscounty))'');
    populated_clean_geo_lat_pcnt := AVE(GROUP,IF(h.clean_geo_lat = (TYPEOF(h.clean_geo_lat))'',0,100));
    maxlength_clean_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_geo_lat)));
    avelength_clean_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_geo_lat)),h.clean_geo_lat<>(typeof(h.clean_geo_lat))'');
    populated_clean_geo_long_pcnt := AVE(GROUP,IF(h.clean_geo_long = (TYPEOF(h.clean_geo_long))'',0,100));
    maxlength_clean_geo_long := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_geo_long)));
    avelength_clean_geo_long := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_geo_long)),h.clean_geo_long<>(typeof(h.clean_geo_long))'');
    populated_clean_msa_pcnt := AVE(GROUP,IF(h.clean_msa = (TYPEOF(h.clean_msa))'',0,100));
    maxlength_clean_msa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_msa)));
    avelength_clean_msa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_msa)),h.clean_msa<>(typeof(h.clean_msa))'');
    populated_clean_geo_blk_pcnt := AVE(GROUP,IF(h.clean_geo_blk = (TYPEOF(h.clean_geo_blk))'',0,100));
    maxlength_clean_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_geo_blk)));
    avelength_clean_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_geo_blk)),h.clean_geo_blk<>(typeof(h.clean_geo_blk))'');
    populated_clean_geo_match_pcnt := AVE(GROUP,IF(h.clean_geo_match = (TYPEOF(h.clean_geo_match))'',0,100));
    maxlength_clean_geo_match := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_geo_match)));
    avelength_clean_geo_match := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_geo_match)),h.clean_geo_match<>(typeof(h.clean_geo_match))'');
    populated_clean_err_stat_pcnt := AVE(GROUP,IF(h.clean_err_stat = (TYPEOF(h.clean_err_stat))'',0,100));
    maxlength_clean_err_stat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_err_stat)));
    avelength_clean_err_stat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_err_stat)),h.clean_err_stat<>(typeof(h.clean_err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_process_date_pcnt *   0.00 / 100 + T.Populated_orig_dl_number_pcnt *   0.00 / 100 + T.Populated_orig_last_name_pcnt *   0.00 / 100 + T.Populated_orig_first_name_pcnt *   0.00 / 100 + T.Populated_orig_middle_initial_pcnt *   0.00 / 100 + T.Populated_orig_sex_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_address1_pcnt *   0.00 / 100 + T.Populated_orig_address2_pcnt *   0.00 / 100 + T.Populated_append_po_box_pcnt *   0.00 / 100 + T.Populated_orig_county_name_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_code_pcnt *   0.00 / 100 + T.Populated_orig_opt_out_code_pcnt *   0.00 / 100 + T.Populated_orig_license_counter_pcnt *   0.00 / 100 + T.Populated_append_license_type_pcnt *   0.00 / 100 + T.Populated_append_classes_pcnt *   0.00 / 100 + T.Populated_append_endorsements_pcnt *   0.00 / 100 + T.Populated_append_issue_date_pcnt *   0.00 / 100 + T.Populated_append_expiration_date_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_name_first_pcnt *   0.00 / 100 + T.Populated_clean_name_middle_pcnt *   0.00 / 100 + T.Populated_clean_name_last_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100 + T.Populated_clean_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_predir_pcnt *   0.00 / 100 + T.Populated_clean_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_postdir_pcnt *   0.00 / 100 + T.Populated_clean_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_st_pcnt *   0.00 / 100 + T.Populated_clean_zip_pcnt *   0.00 / 100 + T.Populated_clean_zip4_pcnt *   0.00 / 100 + T.Populated_clean_cart_pcnt *   0.00 / 100 + T.Populated_clean_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_lot_pcnt *   0.00 / 100 + T.Populated_clean_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_dpbc_pcnt *   0.00 / 100 + T.Populated_clean_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_record_type_pcnt *   0.00 / 100 + T.Populated_clean_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_clean_fipscounty_pcnt *   0.00 / 100 + T.Populated_clean_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_msa_pcnt *   0.00 / 100 + T.Populated_clean_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_err_stat_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT35.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'append_process_date','orig_dl_number','orig_last_name','orig_first_name','orig_middle_initial','orig_sex','orig_dob','orig_city','orig_address1','orig_address2','append_po_box','orig_county_name','orig_state','orig_zip_code','orig_opt_out_code','orig_license_counter','append_license_type','append_classes','append_endorsements','append_issue_date','append_expiration_date','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_process_date_pcnt,le.populated_orig_dl_number_pcnt,le.populated_orig_last_name_pcnt,le.populated_orig_first_name_pcnt,le.populated_orig_middle_initial_pcnt,le.populated_orig_sex_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_city_pcnt,le.populated_orig_address1_pcnt,le.populated_orig_address2_pcnt,le.populated_append_po_box_pcnt,le.populated_orig_county_name_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_code_pcnt,le.populated_orig_opt_out_code_pcnt,le.populated_orig_license_counter_pcnt,le.populated_append_license_type_pcnt,le.populated_append_classes_pcnt,le.populated_append_endorsements_pcnt,le.populated_append_issue_date_pcnt,le.populated_append_expiration_date_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_name_first_pcnt,le.populated_clean_name_middle_pcnt,le.populated_clean_name_last_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt,le.populated_clean_prim_range_pcnt,le.populated_clean_predir_pcnt,le.populated_clean_prim_name_pcnt,le.populated_clean_addr_suffix_pcnt,le.populated_clean_postdir_pcnt,le.populated_clean_unit_desig_pcnt,le.populated_clean_sec_range_pcnt,le.populated_clean_p_city_name_pcnt,le.populated_clean_v_city_name_pcnt,le.populated_clean_st_pcnt,le.populated_clean_zip_pcnt,le.populated_clean_zip4_pcnt,le.populated_clean_cart_pcnt,le.populated_clean_cr_sort_sz_pcnt,le.populated_clean_lot_pcnt,le.populated_clean_lot_order_pcnt,le.populated_clean_dpbc_pcnt,le.populated_clean_chk_digit_pcnt,le.populated_clean_record_type_pcnt,le.populated_clean_ace_fips_st_pcnt,le.populated_clean_fipscounty_pcnt,le.populated_clean_geo_lat_pcnt,le.populated_clean_geo_long_pcnt,le.populated_clean_msa_pcnt,le.populated_clean_geo_blk_pcnt,le.populated_clean_geo_match_pcnt,le.populated_clean_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_process_date,le.maxlength_orig_dl_number,le.maxlength_orig_last_name,le.maxlength_orig_first_name,le.maxlength_orig_middle_initial,le.maxlength_orig_sex,le.maxlength_orig_dob,le.maxlength_orig_city,le.maxlength_orig_address1,le.maxlength_orig_address2,le.maxlength_append_po_box,le.maxlength_orig_county_name,le.maxlength_orig_state,le.maxlength_orig_zip_code,le.maxlength_orig_opt_out_code,le.maxlength_orig_license_counter,le.maxlength_append_license_type,le.maxlength_append_classes,le.maxlength_append_endorsements,le.maxlength_append_issue_date,le.maxlength_append_expiration_date,le.maxlength_clean_name_prefix,le.maxlength_clean_name_first,le.maxlength_clean_name_middle,le.maxlength_clean_name_last,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score,le.maxlength_clean_prim_range,le.maxlength_clean_predir,le.maxlength_clean_prim_name,le.maxlength_clean_addr_suffix,le.maxlength_clean_postdir,le.maxlength_clean_unit_desig,le.maxlength_clean_sec_range,le.maxlength_clean_p_city_name,le.maxlength_clean_v_city_name,le.maxlength_clean_st,le.maxlength_clean_zip,le.maxlength_clean_zip4,le.maxlength_clean_cart,le.maxlength_clean_cr_sort_sz,le.maxlength_clean_lot,le.maxlength_clean_lot_order,le.maxlength_clean_dpbc,le.maxlength_clean_chk_digit,le.maxlength_clean_record_type,le.maxlength_clean_ace_fips_st,le.maxlength_clean_fipscounty,le.maxlength_clean_geo_lat,le.maxlength_clean_geo_long,le.maxlength_clean_msa,le.maxlength_clean_geo_blk,le.maxlength_clean_geo_match,le.maxlength_clean_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_append_process_date,le.avelength_orig_dl_number,le.avelength_orig_last_name,le.avelength_orig_first_name,le.avelength_orig_middle_initial,le.avelength_orig_sex,le.avelength_orig_dob,le.avelength_orig_city,le.avelength_orig_address1,le.avelength_orig_address2,le.avelength_append_po_box,le.avelength_orig_county_name,le.avelength_orig_state,le.avelength_orig_zip_code,le.avelength_orig_opt_out_code,le.avelength_orig_license_counter,le.avelength_append_license_type,le.avelength_append_classes,le.avelength_append_endorsements,le.avelength_append_issue_date,le.avelength_append_expiration_date,le.avelength_clean_name_prefix,le.avelength_clean_name_first,le.avelength_clean_name_middle,le.avelength_clean_name_last,le.avelength_clean_name_suffix,le.avelength_clean_name_score,le.avelength_clean_prim_range,le.avelength_clean_predir,le.avelength_clean_prim_name,le.avelength_clean_addr_suffix,le.avelength_clean_postdir,le.avelength_clean_unit_desig,le.avelength_clean_sec_range,le.avelength_clean_p_city_name,le.avelength_clean_v_city_name,le.avelength_clean_st,le.avelength_clean_zip,le.avelength_clean_zip4,le.avelength_clean_cart,le.avelength_clean_cr_sort_sz,le.avelength_clean_lot,le.avelength_clean_lot_order,le.avelength_clean_dpbc,le.avelength_clean_chk_digit,le.avelength_clean_record_type,le.avelength_clean_ace_fips_st,le.avelength_clean_fipscounty,le.avelength_clean_geo_lat,le.avelength_clean_geo_long,le.avelength_clean_msa,le.avelength_clean_geo_blk,le.avelength_clean_geo_match,le.avelength_clean_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 54, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.append_process_date),TRIM((SALT35.StrType)le.orig_dl_number),TRIM((SALT35.StrType)le.orig_last_name),TRIM((SALT35.StrType)le.orig_first_name),TRIM((SALT35.StrType)le.orig_middle_initial),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_address1),TRIM((SALT35.StrType)le.orig_address2),TRIM((SALT35.StrType)le.append_po_box),TRIM((SALT35.StrType)le.orig_county_name),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip_code),TRIM((SALT35.StrType)le.orig_opt_out_code),TRIM((SALT35.StrType)le.orig_license_counter),TRIM((SALT35.StrType)le.append_license_type),TRIM((SALT35.StrType)le.append_classes),TRIM((SALT35.StrType)le.append_endorsements),TRIM((SALT35.StrType)le.append_issue_date),TRIM((SALT35.StrType)le.append_expiration_date),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_prim_range),TRIM((SALT35.StrType)le.clean_predir),TRIM((SALT35.StrType)le.clean_prim_name),TRIM((SALT35.StrType)le.clean_addr_suffix),TRIM((SALT35.StrType)le.clean_postdir),TRIM((SALT35.StrType)le.clean_unit_desig),TRIM((SALT35.StrType)le.clean_sec_range),TRIM((SALT35.StrType)le.clean_p_city_name),TRIM((SALT35.StrType)le.clean_v_city_name),TRIM((SALT35.StrType)le.clean_st),TRIM((SALT35.StrType)le.clean_zip),TRIM((SALT35.StrType)le.clean_zip4),TRIM((SALT35.StrType)le.clean_cart),TRIM((SALT35.StrType)le.clean_cr_sort_sz),TRIM((SALT35.StrType)le.clean_lot),TRIM((SALT35.StrType)le.clean_lot_order),TRIM((SALT35.StrType)le.clean_dpbc),TRIM((SALT35.StrType)le.clean_chk_digit),TRIM((SALT35.StrType)le.clean_record_type),TRIM((SALT35.StrType)le.clean_ace_fips_st),TRIM((SALT35.StrType)le.clean_fipscounty),TRIM((SALT35.StrType)le.clean_geo_lat),TRIM((SALT35.StrType)le.clean_geo_long),TRIM((SALT35.StrType)le.clean_msa),TRIM((SALT35.StrType)le.clean_geo_blk),TRIM((SALT35.StrType)le.clean_geo_match),TRIM((SALT35.StrType)le.clean_err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,54,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 54);
  SELF.FldNo2 := 1 + (C % 54);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.append_process_date),TRIM((SALT35.StrType)le.orig_dl_number),TRIM((SALT35.StrType)le.orig_last_name),TRIM((SALT35.StrType)le.orig_first_name),TRIM((SALT35.StrType)le.orig_middle_initial),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_address1),TRIM((SALT35.StrType)le.orig_address2),TRIM((SALT35.StrType)le.append_po_box),TRIM((SALT35.StrType)le.orig_county_name),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip_code),TRIM((SALT35.StrType)le.orig_opt_out_code),TRIM((SALT35.StrType)le.orig_license_counter),TRIM((SALT35.StrType)le.append_license_type),TRIM((SALT35.StrType)le.append_classes),TRIM((SALT35.StrType)le.append_endorsements),TRIM((SALT35.StrType)le.append_issue_date),TRIM((SALT35.StrType)le.append_expiration_date),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_prim_range),TRIM((SALT35.StrType)le.clean_predir),TRIM((SALT35.StrType)le.clean_prim_name),TRIM((SALT35.StrType)le.clean_addr_suffix),TRIM((SALT35.StrType)le.clean_postdir),TRIM((SALT35.StrType)le.clean_unit_desig),TRIM((SALT35.StrType)le.clean_sec_range),TRIM((SALT35.StrType)le.clean_p_city_name),TRIM((SALT35.StrType)le.clean_v_city_name),TRIM((SALT35.StrType)le.clean_st),TRIM((SALT35.StrType)le.clean_zip),TRIM((SALT35.StrType)le.clean_zip4),TRIM((SALT35.StrType)le.clean_cart),TRIM((SALT35.StrType)le.clean_cr_sort_sz),TRIM((SALT35.StrType)le.clean_lot),TRIM((SALT35.StrType)le.clean_lot_order),TRIM((SALT35.StrType)le.clean_dpbc),TRIM((SALT35.StrType)le.clean_chk_digit),TRIM((SALT35.StrType)le.clean_record_type),TRIM((SALT35.StrType)le.clean_ace_fips_st),TRIM((SALT35.StrType)le.clean_fipscounty),TRIM((SALT35.StrType)le.clean_geo_lat),TRIM((SALT35.StrType)le.clean_geo_long),TRIM((SALT35.StrType)le.clean_msa),TRIM((SALT35.StrType)le.clean_geo_blk),TRIM((SALT35.StrType)le.clean_geo_match),TRIM((SALT35.StrType)le.clean_err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.append_process_date),TRIM((SALT35.StrType)le.orig_dl_number),TRIM((SALT35.StrType)le.orig_last_name),TRIM((SALT35.StrType)le.orig_first_name),TRIM((SALT35.StrType)le.orig_middle_initial),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_address1),TRIM((SALT35.StrType)le.orig_address2),TRIM((SALT35.StrType)le.append_po_box),TRIM((SALT35.StrType)le.orig_county_name),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip_code),TRIM((SALT35.StrType)le.orig_opt_out_code),TRIM((SALT35.StrType)le.orig_license_counter),TRIM((SALT35.StrType)le.append_license_type),TRIM((SALT35.StrType)le.append_classes),TRIM((SALT35.StrType)le.append_endorsements),TRIM((SALT35.StrType)le.append_issue_date),TRIM((SALT35.StrType)le.append_expiration_date),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_prim_range),TRIM((SALT35.StrType)le.clean_predir),TRIM((SALT35.StrType)le.clean_prim_name),TRIM((SALT35.StrType)le.clean_addr_suffix),TRIM((SALT35.StrType)le.clean_postdir),TRIM((SALT35.StrType)le.clean_unit_desig),TRIM((SALT35.StrType)le.clean_sec_range),TRIM((SALT35.StrType)le.clean_p_city_name),TRIM((SALT35.StrType)le.clean_v_city_name),TRIM((SALT35.StrType)le.clean_st),TRIM((SALT35.StrType)le.clean_zip),TRIM((SALT35.StrType)le.clean_zip4),TRIM((SALT35.StrType)le.clean_cart),TRIM((SALT35.StrType)le.clean_cr_sort_sz),TRIM((SALT35.StrType)le.clean_lot),TRIM((SALT35.StrType)le.clean_lot_order),TRIM((SALT35.StrType)le.clean_dpbc),TRIM((SALT35.StrType)le.clean_chk_digit),TRIM((SALT35.StrType)le.clean_record_type),TRIM((SALT35.StrType)le.clean_ace_fips_st),TRIM((SALT35.StrType)le.clean_fipscounty),TRIM((SALT35.StrType)le.clean_geo_lat),TRIM((SALT35.StrType)le.clean_geo_long),TRIM((SALT35.StrType)le.clean_msa),TRIM((SALT35.StrType)le.clean_geo_blk),TRIM((SALT35.StrType)le.clean_geo_match),TRIM((SALT35.StrType)le.clean_err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),54*54,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_process_date'}
      ,{2,'orig_dl_number'}
      ,{3,'orig_last_name'}
      ,{4,'orig_first_name'}
      ,{5,'orig_middle_initial'}
      ,{6,'orig_sex'}
      ,{7,'orig_dob'}
      ,{8,'orig_city'}
      ,{9,'orig_address1'}
      ,{10,'orig_address2'}
      ,{11,'append_po_box'}
      ,{12,'orig_county_name'}
      ,{13,'orig_state'}
      ,{14,'orig_zip_code'}
      ,{15,'orig_opt_out_code'}
      ,{16,'orig_license_counter'}
      ,{17,'append_license_type'}
      ,{18,'append_classes'}
      ,{19,'append_endorsements'}
      ,{20,'append_issue_date'}
      ,{21,'append_expiration_date'}
      ,{22,'clean_name_prefix'}
      ,{23,'clean_name_first'}
      ,{24,'clean_name_middle'}
      ,{25,'clean_name_last'}
      ,{26,'clean_name_suffix'}
      ,{27,'clean_name_score'}
      ,{28,'clean_prim_range'}
      ,{29,'clean_predir'}
      ,{30,'clean_prim_name'}
      ,{31,'clean_addr_suffix'}
      ,{32,'clean_postdir'}
      ,{33,'clean_unit_desig'}
      ,{34,'clean_sec_range'}
      ,{35,'clean_p_city_name'}
      ,{36,'clean_v_city_name'}
      ,{37,'clean_st'}
      ,{38,'clean_zip'}
      ,{39,'clean_zip4'}
      ,{40,'clean_cart'}
      ,{41,'clean_cr_sort_sz'}
      ,{42,'clean_lot'}
      ,{43,'clean_lot_order'}
      ,{44,'clean_dpbc'}
      ,{45,'clean_chk_digit'}
      ,{46,'clean_record_type'}
      ,{47,'clean_ace_fips_st'}
      ,{48,'clean_fipscounty'}
      ,{49,'clean_geo_lat'}
      ,{50,'clean_geo_long'}
      ,{51,'clean_msa'}
      ,{52,'clean_geo_blk'}
      ,{53,'clean_geo_match'}
      ,{54,'clean_err_stat'}],SALT35.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT35.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT35.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT35.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_append_process_date((SALT35.StrType)le.append_process_date),
    Fields.InValid_orig_dl_number((SALT35.StrType)le.orig_dl_number),
    Fields.InValid_orig_last_name((SALT35.StrType)le.orig_last_name,(SALT35.StrType)le.orig_first_name,(SALT35.StrType)le.orig_middle_initial),
    Fields.InValid_orig_first_name((SALT35.StrType)le.orig_first_name),
    Fields.InValid_orig_middle_initial((SALT35.StrType)le.orig_middle_initial),
    Fields.InValid_orig_sex((SALT35.StrType)le.orig_sex),
    Fields.InValid_orig_dob((SALT35.StrType)le.orig_dob),
    Fields.InValid_orig_city((SALT35.StrType)le.orig_city),
    Fields.InValid_orig_address1((SALT35.StrType)le.orig_address1),
    Fields.InValid_orig_address2((SALT35.StrType)le.orig_address2),
    Fields.InValid_append_po_box((SALT35.StrType)le.append_po_box),
    Fields.InValid_orig_county_name((SALT35.StrType)le.orig_county_name),
    Fields.InValid_orig_state((SALT35.StrType)le.orig_state),
    Fields.InValid_orig_zip_code((SALT35.StrType)le.orig_zip_code),
    Fields.InValid_orig_opt_out_code((SALT35.StrType)le.orig_opt_out_code),
    Fields.InValid_orig_license_counter((SALT35.StrType)le.orig_license_counter),
    Fields.InValid_append_license_type((SALT35.StrType)le.append_license_type),
    Fields.InValid_append_classes((SALT35.StrType)le.append_classes),
    Fields.InValid_append_endorsements((SALT35.StrType)le.append_endorsements),
    Fields.InValid_append_issue_date((SALT35.StrType)le.append_issue_date),
    Fields.InValid_append_expiration_date((SALT35.StrType)le.append_expiration_date),
    Fields.InValid_clean_name_prefix((SALT35.StrType)le.clean_name_prefix),
    Fields.InValid_clean_name_first((SALT35.StrType)le.clean_name_first),
    Fields.InValid_clean_name_middle((SALT35.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_last((SALT35.StrType)le.clean_name_last,(SALT35.StrType)le.clean_name_first,(SALT35.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_suffix((SALT35.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT35.StrType)le.clean_name_score),
    Fields.InValid_clean_prim_range((SALT35.StrType)le.clean_prim_range),
    Fields.InValid_clean_predir((SALT35.StrType)le.clean_predir),
    Fields.InValid_clean_prim_name((SALT35.StrType)le.clean_prim_name),
    Fields.InValid_clean_addr_suffix((SALT35.StrType)le.clean_addr_suffix),
    Fields.InValid_clean_postdir((SALT35.StrType)le.clean_postdir),
    Fields.InValid_clean_unit_desig((SALT35.StrType)le.clean_unit_desig),
    Fields.InValid_clean_sec_range((SALT35.StrType)le.clean_sec_range),
    Fields.InValid_clean_p_city_name((SALT35.StrType)le.clean_p_city_name),
    Fields.InValid_clean_v_city_name((SALT35.StrType)le.clean_v_city_name),
    Fields.InValid_clean_st((SALT35.StrType)le.clean_st),
    Fields.InValid_clean_zip((SALT35.StrType)le.clean_zip),
    Fields.InValid_clean_zip4((SALT35.StrType)le.clean_zip4),
    Fields.InValid_clean_cart((SALT35.StrType)le.clean_cart),
    Fields.InValid_clean_cr_sort_sz((SALT35.StrType)le.clean_cr_sort_sz),
    Fields.InValid_clean_lot((SALT35.StrType)le.clean_lot),
    Fields.InValid_clean_lot_order((SALT35.StrType)le.clean_lot_order),
    Fields.InValid_clean_dpbc((SALT35.StrType)le.clean_dpbc),
    Fields.InValid_clean_chk_digit((SALT35.StrType)le.clean_chk_digit),
    Fields.InValid_clean_record_type((SALT35.StrType)le.clean_record_type),
    Fields.InValid_clean_ace_fips_st((SALT35.StrType)le.clean_ace_fips_st),
    Fields.InValid_clean_fipscounty((SALT35.StrType)le.clean_fipscounty),
    Fields.InValid_clean_geo_lat((SALT35.StrType)le.clean_geo_lat),
    Fields.InValid_clean_geo_long((SALT35.StrType)le.clean_geo_long),
    Fields.InValid_clean_msa((SALT35.StrType)le.clean_msa),
    Fields.InValid_clean_geo_blk((SALT35.StrType)le.clean_geo_blk),
    Fields.InValid_clean_geo_match((SALT35.StrType)le.clean_geo_match),
    Fields.InValid_clean_err_stat((SALT35.StrType)le.clean_err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,54,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_orig_dl_number','invalid_orig_name','Unknown','Unknown','invalid_orig_sex','invalid_8pastdate','invalid_alpha_blank','invalid_mandatory','Unknown','Unknown','invalid_alpha_num_specials','invalid_state','invalid_orig_zip_code','invalid_orig_opt_out_code','invalid_orig_license_counter','invalid_append_license_type','invalid_append_classes','invalid_append_endorsements','invalid_8pastdate','invalid_8generaldate','Unknown','Unknown','Unknown','invalid_clean_name','Unknown','invalid_numeric','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_alpha_blank','invalid_alpha_blank','invalid_state','invalid_zip_code5','invalid_zip_code4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_append_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_middle_initial(TotalErrors.ErrorNum),Fields.InValidMessage_orig_sex(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2(TotalErrors.ErrorNum),Fields.InValidMessage_append_po_box(TotalErrors.ErrorNum),Fields.InValidMessage_orig_county_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_opt_out_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_license_counter(TotalErrors.ErrorNum),Fields.InValidMessage_append_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_append_classes(TotalErrors.ErrorNum),Fields.InValidMessage_append_endorsements(TotalErrors.ErrorNum),Fields.InValidMessage_append_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_append_expiration_date(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fipscounty(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
