IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_In_NV) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_append_process_date_pcnt := AVE(GROUP,IF(h.append_process_date = (TYPEOF(h.append_process_date))'',0,100));
    maxlength_append_process_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_process_date)));
    avelength_append_process_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_process_date)),h.append_process_date<>(typeof(h.append_process_date))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_lst_name_pcnt := AVE(GROUP,IF(h.lst_name = (TYPEOF(h.lst_name))'',0,100));
    maxlength_lst_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lst_name)));
    avelength_lst_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lst_name)),h.lst_name<>(typeof(h.lst_name))'');
    populated_fst_name_pcnt := AVE(GROUP,IF(h.fst_name = (TYPEOF(h.fst_name))'',0,100));
    maxlength_fst_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.fst_name)));
    avelength_fst_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.fst_name)),h.fst_name<>(typeof(h.fst_name))'');
    populated_mid_name_pcnt := AVE(GROUP,IF(h.mid_name = (TYPEOF(h.mid_name))'',0,100));
    maxlength_mid_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.mid_name)));
    avelength_mid_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.mid_name)),h.mid_name<>(typeof(h.mid_name))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_dln_pcnt := AVE(GROUP,IF(h.dln = (TYPEOF(h.dln))'',0,100));
    maxlength_dln := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dln)));
    avelength_dln := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dln)),h.dln<>(typeof(h.dln))'');
    populated_perm_cd_1_pcnt := AVE(GROUP,IF(h.perm_cd_1 = (TYPEOF(h.perm_cd_1))'',0,100));
    maxlength_perm_cd_1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.perm_cd_1)));
    avelength_perm_cd_1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.perm_cd_1)),h.perm_cd_1<>(typeof(h.perm_cd_1))'');
    populated_perm_cd_2_pcnt := AVE(GROUP,IF(h.perm_cd_2 = (TYPEOF(h.perm_cd_2))'',0,100));
    maxlength_perm_cd_2 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.perm_cd_2)));
    avelength_perm_cd_2 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.perm_cd_2)),h.perm_cd_2<>(typeof(h.perm_cd_2))'');
    populated_perm_cd_3_pcnt := AVE(GROUP,IF(h.perm_cd_3 = (TYPEOF(h.perm_cd_3))'',0,100));
    maxlength_perm_cd_3 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.perm_cd_3)));
    avelength_perm_cd_3 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.perm_cd_3)),h.perm_cd_3<>(typeof(h.perm_cd_3))'');
    populated_perm_cd_4_pcnt := AVE(GROUP,IF(h.perm_cd_4 = (TYPEOF(h.perm_cd_4))'',0,100));
    maxlength_perm_cd_4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.perm_cd_4)));
    avelength_perm_cd_4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.perm_cd_4)),h.perm_cd_4<>(typeof(h.perm_cd_4))'');
    populated_eff_dt_pcnt := AVE(GROUP,IF(h.eff_dt = (TYPEOF(h.eff_dt))'',0,100));
    maxlength_eff_dt := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.eff_dt)));
    avelength_eff_dt := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.eff_dt)),h.eff_dt<>(typeof(h.eff_dt))'');
    populated_m_addr_pcnt := AVE(GROUP,IF(h.m_addr = (TYPEOF(h.m_addr))'',0,100));
    maxlength_m_addr := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.m_addr)));
    avelength_m_addr := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.m_addr)),h.m_addr<>(typeof(h.m_addr))'');
    populated_m_city_pcnt := AVE(GROUP,IF(h.m_city = (TYPEOF(h.m_city))'',0,100));
    maxlength_m_city := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.m_city)));
    avelength_m_city := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.m_city)),h.m_city<>(typeof(h.m_city))'');
    populated_m_state_pcnt := AVE(GROUP,IF(h.m_state = (TYPEOF(h.m_state))'',0,100));
    maxlength_m_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.m_state)));
    avelength_m_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.m_state)),h.m_state<>(typeof(h.m_state))'');
    populated_m_zip_pcnt := AVE(GROUP,IF(h.m_zip = (TYPEOF(h.m_zip))'',0,100));
    maxlength_m_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.m_zip)));
    avelength_m_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.m_zip)),h.m_zip<>(typeof(h.m_zip))'');
    populated_p_addr_pcnt := AVE(GROUP,IF(h.p_addr = (TYPEOF(h.p_addr))'',0,100));
    maxlength_p_addr := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_addr)));
    avelength_p_addr := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_addr)),h.p_addr<>(typeof(h.p_addr))'');
    populated_p_city_pcnt := AVE(GROUP,IF(h.p_city = (TYPEOF(h.p_city))'',0,100));
    maxlength_p_city := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city)));
    avelength_p_city := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city)),h.p_city<>(typeof(h.p_city))'');
    populated_p_state_pcnt := AVE(GROUP,IF(h.p_state = (TYPEOF(h.p_state))'',0,100));
    maxlength_p_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_state)));
    avelength_p_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_state)),h.p_state<>(typeof(h.p_state))'');
    populated_p_zip_pcnt := AVE(GROUP,IF(h.p_zip = (TYPEOF(h.p_zip))'',0,100));
    maxlength_p_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_zip)));
    avelength_p_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_zip)),h.p_zip<>(typeof(h.p_zip))'');
    populated_lf_pcnt := AVE(GROUP,IF(h.lf = (TYPEOF(h.lf))'',0,100));
    maxlength_lf := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lf)));
    avelength_lf := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lf)),h.lf<>(typeof(h.lf))'');
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
    populated_clean_m_prim_range_pcnt := AVE(GROUP,IF(h.clean_m_prim_range = (TYPEOF(h.clean_m_prim_range))'',0,100));
    maxlength_clean_m_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_prim_range)));
    avelength_clean_m_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_prim_range)),h.clean_m_prim_range<>(typeof(h.clean_m_prim_range))'');
    populated_clean_m_predir_pcnt := AVE(GROUP,IF(h.clean_m_predir = (TYPEOF(h.clean_m_predir))'',0,100));
    maxlength_clean_m_predir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_predir)));
    avelength_clean_m_predir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_predir)),h.clean_m_predir<>(typeof(h.clean_m_predir))'');
    populated_clean_m_prim_name_pcnt := AVE(GROUP,IF(h.clean_m_prim_name = (TYPEOF(h.clean_m_prim_name))'',0,100));
    maxlength_clean_m_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_prim_name)));
    avelength_clean_m_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_prim_name)),h.clean_m_prim_name<>(typeof(h.clean_m_prim_name))'');
    populated_clean_m_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_m_addr_suffix = (TYPEOF(h.clean_m_addr_suffix))'',0,100));
    maxlength_clean_m_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_addr_suffix)));
    avelength_clean_m_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_addr_suffix)),h.clean_m_addr_suffix<>(typeof(h.clean_m_addr_suffix))'');
    populated_clean_m_postdir_pcnt := AVE(GROUP,IF(h.clean_m_postdir = (TYPEOF(h.clean_m_postdir))'',0,100));
    maxlength_clean_m_postdir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_postdir)));
    avelength_clean_m_postdir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_postdir)),h.clean_m_postdir<>(typeof(h.clean_m_postdir))'');
    populated_clean_m_unit_desig_pcnt := AVE(GROUP,IF(h.clean_m_unit_desig = (TYPEOF(h.clean_m_unit_desig))'',0,100));
    maxlength_clean_m_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_unit_desig)));
    avelength_clean_m_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_unit_desig)),h.clean_m_unit_desig<>(typeof(h.clean_m_unit_desig))'');
    populated_clean_m_sec_range_pcnt := AVE(GROUP,IF(h.clean_m_sec_range = (TYPEOF(h.clean_m_sec_range))'',0,100));
    maxlength_clean_m_sec_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_sec_range)));
    avelength_clean_m_sec_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_sec_range)),h.clean_m_sec_range<>(typeof(h.clean_m_sec_range))'');
    populated_clean_m_p_city_name_pcnt := AVE(GROUP,IF(h.clean_m_p_city_name = (TYPEOF(h.clean_m_p_city_name))'',0,100));
    maxlength_clean_m_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_p_city_name)));
    avelength_clean_m_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_p_city_name)),h.clean_m_p_city_name<>(typeof(h.clean_m_p_city_name))'');
    populated_clean_m_v_city_name_pcnt := AVE(GROUP,IF(h.clean_m_v_city_name = (TYPEOF(h.clean_m_v_city_name))'',0,100));
    maxlength_clean_m_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_v_city_name)));
    avelength_clean_m_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_v_city_name)),h.clean_m_v_city_name<>(typeof(h.clean_m_v_city_name))'');
    populated_clean_m_st_pcnt := AVE(GROUP,IF(h.clean_m_st = (TYPEOF(h.clean_m_st))'',0,100));
    maxlength_clean_m_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_st)));
    avelength_clean_m_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_st)),h.clean_m_st<>(typeof(h.clean_m_st))'');
    populated_clean_m_zip_pcnt := AVE(GROUP,IF(h.clean_m_zip = (TYPEOF(h.clean_m_zip))'',0,100));
    maxlength_clean_m_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_zip)));
    avelength_clean_m_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_zip)),h.clean_m_zip<>(typeof(h.clean_m_zip))'');
    populated_clean_m_zip4_pcnt := AVE(GROUP,IF(h.clean_m_zip4 = (TYPEOF(h.clean_m_zip4))'',0,100));
    maxlength_clean_m_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_zip4)));
    avelength_clean_m_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_zip4)),h.clean_m_zip4<>(typeof(h.clean_m_zip4))'');
    populated_clean_m_cart_pcnt := AVE(GROUP,IF(h.clean_m_cart = (TYPEOF(h.clean_m_cart))'',0,100));
    maxlength_clean_m_cart := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_cart)));
    avelength_clean_m_cart := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_cart)),h.clean_m_cart<>(typeof(h.clean_m_cart))'');
    populated_clean_m_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_m_cr_sort_sz = (TYPEOF(h.clean_m_cr_sort_sz))'',0,100));
    maxlength_clean_m_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_cr_sort_sz)));
    avelength_clean_m_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_cr_sort_sz)),h.clean_m_cr_sort_sz<>(typeof(h.clean_m_cr_sort_sz))'');
    populated_clean_m_lot_pcnt := AVE(GROUP,IF(h.clean_m_lot = (TYPEOF(h.clean_m_lot))'',0,100));
    maxlength_clean_m_lot := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_lot)));
    avelength_clean_m_lot := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_lot)),h.clean_m_lot<>(typeof(h.clean_m_lot))'');
    populated_clean_m_lot_order_pcnt := AVE(GROUP,IF(h.clean_m_lot_order = (TYPEOF(h.clean_m_lot_order))'',0,100));
    maxlength_clean_m_lot_order := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_lot_order)));
    avelength_clean_m_lot_order := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_lot_order)),h.clean_m_lot_order<>(typeof(h.clean_m_lot_order))'');
    populated_clean_m_dpbc_pcnt := AVE(GROUP,IF(h.clean_m_dpbc = (TYPEOF(h.clean_m_dpbc))'',0,100));
    maxlength_clean_m_dpbc := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_dpbc)));
    avelength_clean_m_dpbc := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_dpbc)),h.clean_m_dpbc<>(typeof(h.clean_m_dpbc))'');
    populated_clean_m_chk_digit_pcnt := AVE(GROUP,IF(h.clean_m_chk_digit = (TYPEOF(h.clean_m_chk_digit))'',0,100));
    maxlength_clean_m_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_chk_digit)));
    avelength_clean_m_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_chk_digit)),h.clean_m_chk_digit<>(typeof(h.clean_m_chk_digit))'');
    populated_clean_m_record_type_pcnt := AVE(GROUP,IF(h.clean_m_record_type = (TYPEOF(h.clean_m_record_type))'',0,100));
    maxlength_clean_m_record_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_record_type)));
    avelength_clean_m_record_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_record_type)),h.clean_m_record_type<>(typeof(h.clean_m_record_type))'');
    populated_clean_m_ace_fips_st_pcnt := AVE(GROUP,IF(h.clean_m_ace_fips_st = (TYPEOF(h.clean_m_ace_fips_st))'',0,100));
    maxlength_clean_m_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_ace_fips_st)));
    avelength_clean_m_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_ace_fips_st)),h.clean_m_ace_fips_st<>(typeof(h.clean_m_ace_fips_st))'');
    populated_clean_m_fipscounty_pcnt := AVE(GROUP,IF(h.clean_m_fipscounty = (TYPEOF(h.clean_m_fipscounty))'',0,100));
    maxlength_clean_m_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_fipscounty)));
    avelength_clean_m_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_fipscounty)),h.clean_m_fipscounty<>(typeof(h.clean_m_fipscounty))'');
    populated_clean_m_geo_lat_pcnt := AVE(GROUP,IF(h.clean_m_geo_lat = (TYPEOF(h.clean_m_geo_lat))'',0,100));
    maxlength_clean_m_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_geo_lat)));
    avelength_clean_m_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_geo_lat)),h.clean_m_geo_lat<>(typeof(h.clean_m_geo_lat))'');
    populated_clean_m_geo_long_pcnt := AVE(GROUP,IF(h.clean_m_geo_long = (TYPEOF(h.clean_m_geo_long))'',0,100));
    maxlength_clean_m_geo_long := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_geo_long)));
    avelength_clean_m_geo_long := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_geo_long)),h.clean_m_geo_long<>(typeof(h.clean_m_geo_long))'');
    populated_clean_m_msa_pcnt := AVE(GROUP,IF(h.clean_m_msa = (TYPEOF(h.clean_m_msa))'',0,100));
    maxlength_clean_m_msa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_msa)));
    avelength_clean_m_msa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_msa)),h.clean_m_msa<>(typeof(h.clean_m_msa))'');
    populated_clean_m_geo_blk_pcnt := AVE(GROUP,IF(h.clean_m_geo_blk = (TYPEOF(h.clean_m_geo_blk))'',0,100));
    maxlength_clean_m_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_geo_blk)));
    avelength_clean_m_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_geo_blk)),h.clean_m_geo_blk<>(typeof(h.clean_m_geo_blk))'');
    populated_clean_m_geo_match_pcnt := AVE(GROUP,IF(h.clean_m_geo_match = (TYPEOF(h.clean_m_geo_match))'',0,100));
    maxlength_clean_m_geo_match := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_geo_match)));
    avelength_clean_m_geo_match := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_geo_match)),h.clean_m_geo_match<>(typeof(h.clean_m_geo_match))'');
    populated_clean_m_err_stat_pcnt := AVE(GROUP,IF(h.clean_m_err_stat = (TYPEOF(h.clean_m_err_stat))'',0,100));
    maxlength_clean_m_err_stat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_err_stat)));
    avelength_clean_m_err_stat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_m_err_stat)),h.clean_m_err_stat<>(typeof(h.clean_m_err_stat))'');
    populated_clean_p_prim_range_pcnt := AVE(GROUP,IF(h.clean_p_prim_range = (TYPEOF(h.clean_p_prim_range))'',0,100));
    maxlength_clean_p_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_prim_range)));
    avelength_clean_p_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_prim_range)),h.clean_p_prim_range<>(typeof(h.clean_p_prim_range))'');
    populated_clean_p_predir_pcnt := AVE(GROUP,IF(h.clean_p_predir = (TYPEOF(h.clean_p_predir))'',0,100));
    maxlength_clean_p_predir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_predir)));
    avelength_clean_p_predir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_predir)),h.clean_p_predir<>(typeof(h.clean_p_predir))'');
    populated_clean_p_prim_name_pcnt := AVE(GROUP,IF(h.clean_p_prim_name = (TYPEOF(h.clean_p_prim_name))'',0,100));
    maxlength_clean_p_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_prim_name)));
    avelength_clean_p_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_prim_name)),h.clean_p_prim_name<>(typeof(h.clean_p_prim_name))'');
    populated_clean_p_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_p_addr_suffix = (TYPEOF(h.clean_p_addr_suffix))'',0,100));
    maxlength_clean_p_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_addr_suffix)));
    avelength_clean_p_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_addr_suffix)),h.clean_p_addr_suffix<>(typeof(h.clean_p_addr_suffix))'');
    populated_clean_p_postdir_pcnt := AVE(GROUP,IF(h.clean_p_postdir = (TYPEOF(h.clean_p_postdir))'',0,100));
    maxlength_clean_p_postdir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_postdir)));
    avelength_clean_p_postdir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_postdir)),h.clean_p_postdir<>(typeof(h.clean_p_postdir))'');
    populated_clean_p_unit_desig_pcnt := AVE(GROUP,IF(h.clean_p_unit_desig = (TYPEOF(h.clean_p_unit_desig))'',0,100));
    maxlength_clean_p_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_unit_desig)));
    avelength_clean_p_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_unit_desig)),h.clean_p_unit_desig<>(typeof(h.clean_p_unit_desig))'');
    populated_clean_p_sec_range_pcnt := AVE(GROUP,IF(h.clean_p_sec_range = (TYPEOF(h.clean_p_sec_range))'',0,100));
    maxlength_clean_p_sec_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_sec_range)));
    avelength_clean_p_sec_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_sec_range)),h.clean_p_sec_range<>(typeof(h.clean_p_sec_range))'');
    populated_clean_p_p_city_name_pcnt := AVE(GROUP,IF(h.clean_p_p_city_name = (TYPEOF(h.clean_p_p_city_name))'',0,100));
    maxlength_clean_p_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_p_city_name)));
    avelength_clean_p_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_p_city_name)),h.clean_p_p_city_name<>(typeof(h.clean_p_p_city_name))'');
    populated_clean_p_v_city_name_pcnt := AVE(GROUP,IF(h.clean_p_v_city_name = (TYPEOF(h.clean_p_v_city_name))'',0,100));
    maxlength_clean_p_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_v_city_name)));
    avelength_clean_p_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_v_city_name)),h.clean_p_v_city_name<>(typeof(h.clean_p_v_city_name))'');
    populated_clean_p_st_pcnt := AVE(GROUP,IF(h.clean_p_st = (TYPEOF(h.clean_p_st))'',0,100));
    maxlength_clean_p_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_st)));
    avelength_clean_p_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_st)),h.clean_p_st<>(typeof(h.clean_p_st))'');
    populated_clean_p_zip_pcnt := AVE(GROUP,IF(h.clean_p_zip = (TYPEOF(h.clean_p_zip))'',0,100));
    maxlength_clean_p_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_zip)));
    avelength_clean_p_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_zip)),h.clean_p_zip<>(typeof(h.clean_p_zip))'');
    populated_clean_p_zip4_pcnt := AVE(GROUP,IF(h.clean_p_zip4 = (TYPEOF(h.clean_p_zip4))'',0,100));
    maxlength_clean_p_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_zip4)));
    avelength_clean_p_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_zip4)),h.clean_p_zip4<>(typeof(h.clean_p_zip4))'');
    populated_clean_p_cart_pcnt := AVE(GROUP,IF(h.clean_p_cart = (TYPEOF(h.clean_p_cart))'',0,100));
    maxlength_clean_p_cart := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_cart)));
    avelength_clean_p_cart := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_cart)),h.clean_p_cart<>(typeof(h.clean_p_cart))'');
    populated_clean_p_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_p_cr_sort_sz = (TYPEOF(h.clean_p_cr_sort_sz))'',0,100));
    maxlength_clean_p_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_cr_sort_sz)));
    avelength_clean_p_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_cr_sort_sz)),h.clean_p_cr_sort_sz<>(typeof(h.clean_p_cr_sort_sz))'');
    populated_clean_p_lot_pcnt := AVE(GROUP,IF(h.clean_p_lot = (TYPEOF(h.clean_p_lot))'',0,100));
    maxlength_clean_p_lot := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_lot)));
    avelength_clean_p_lot := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_lot)),h.clean_p_lot<>(typeof(h.clean_p_lot))'');
    populated_clean_p_lot_order_pcnt := AVE(GROUP,IF(h.clean_p_lot_order = (TYPEOF(h.clean_p_lot_order))'',0,100));
    maxlength_clean_p_lot_order := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_lot_order)));
    avelength_clean_p_lot_order := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_lot_order)),h.clean_p_lot_order<>(typeof(h.clean_p_lot_order))'');
    populated_clean_p_dpbc_pcnt := AVE(GROUP,IF(h.clean_p_dpbc = (TYPEOF(h.clean_p_dpbc))'',0,100));
    maxlength_clean_p_dpbc := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_dpbc)));
    avelength_clean_p_dpbc := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_dpbc)),h.clean_p_dpbc<>(typeof(h.clean_p_dpbc))'');
    populated_clean_p_chk_digit_pcnt := AVE(GROUP,IF(h.clean_p_chk_digit = (TYPEOF(h.clean_p_chk_digit))'',0,100));
    maxlength_clean_p_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_chk_digit)));
    avelength_clean_p_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_chk_digit)),h.clean_p_chk_digit<>(typeof(h.clean_p_chk_digit))'');
    populated_clean_p_record_type_pcnt := AVE(GROUP,IF(h.clean_p_record_type = (TYPEOF(h.clean_p_record_type))'',0,100));
    maxlength_clean_p_record_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_record_type)));
    avelength_clean_p_record_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_record_type)),h.clean_p_record_type<>(typeof(h.clean_p_record_type))'');
    populated_clean_p_ace_fips_st_pcnt := AVE(GROUP,IF(h.clean_p_ace_fips_st = (TYPEOF(h.clean_p_ace_fips_st))'',0,100));
    maxlength_clean_p_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_ace_fips_st)));
    avelength_clean_p_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_ace_fips_st)),h.clean_p_ace_fips_st<>(typeof(h.clean_p_ace_fips_st))'');
    populated_clean_p_fipscounty_pcnt := AVE(GROUP,IF(h.clean_p_fipscounty = (TYPEOF(h.clean_p_fipscounty))'',0,100));
    maxlength_clean_p_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_fipscounty)));
    avelength_clean_p_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_fipscounty)),h.clean_p_fipscounty<>(typeof(h.clean_p_fipscounty))'');
    populated_clean_p_geo_lat_pcnt := AVE(GROUP,IF(h.clean_p_geo_lat = (TYPEOF(h.clean_p_geo_lat))'',0,100));
    maxlength_clean_p_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_geo_lat)));
    avelength_clean_p_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_geo_lat)),h.clean_p_geo_lat<>(typeof(h.clean_p_geo_lat))'');
    populated_clean_p_geo_long_pcnt := AVE(GROUP,IF(h.clean_p_geo_long = (TYPEOF(h.clean_p_geo_long))'',0,100));
    maxlength_clean_p_geo_long := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_geo_long)));
    avelength_clean_p_geo_long := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_geo_long)),h.clean_p_geo_long<>(typeof(h.clean_p_geo_long))'');
    populated_clean_p_msa_pcnt := AVE(GROUP,IF(h.clean_p_msa = (TYPEOF(h.clean_p_msa))'',0,100));
    maxlength_clean_p_msa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_msa)));
    avelength_clean_p_msa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_msa)),h.clean_p_msa<>(typeof(h.clean_p_msa))'');
    populated_clean_p_geo_blk_pcnt := AVE(GROUP,IF(h.clean_p_geo_blk = (TYPEOF(h.clean_p_geo_blk))'',0,100));
    maxlength_clean_p_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_geo_blk)));
    avelength_clean_p_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_geo_blk)),h.clean_p_geo_blk<>(typeof(h.clean_p_geo_blk))'');
    populated_clean_p_geo_match_pcnt := AVE(GROUP,IF(h.clean_p_geo_match = (TYPEOF(h.clean_p_geo_match))'',0,100));
    maxlength_clean_p_geo_match := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_geo_match)));
    avelength_clean_p_geo_match := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_geo_match)),h.clean_p_geo_match<>(typeof(h.clean_p_geo_match))'');
    populated_clean_p_err_stat_pcnt := AVE(GROUP,IF(h.clean_p_err_stat = (TYPEOF(h.clean_p_err_stat))'',0,100));
    maxlength_clean_p_err_stat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_err_stat)));
    avelength_clean_p_err_stat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.clean_p_err_stat)),h.clean_p_err_stat<>(typeof(h.clean_p_err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_process_date_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_lst_name_pcnt *   0.00 / 100 + T.Populated_fst_name_pcnt *   0.00 / 100 + T.Populated_mid_name_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_dln_pcnt *   0.00 / 100 + T.Populated_perm_cd_1_pcnt *   0.00 / 100 + T.Populated_perm_cd_2_pcnt *   0.00 / 100 + T.Populated_perm_cd_3_pcnt *   0.00 / 100 + T.Populated_perm_cd_4_pcnt *   0.00 / 100 + T.Populated_eff_dt_pcnt *   0.00 / 100 + T.Populated_m_addr_pcnt *   0.00 / 100 + T.Populated_m_city_pcnt *   0.00 / 100 + T.Populated_m_state_pcnt *   0.00 / 100 + T.Populated_m_zip_pcnt *   0.00 / 100 + T.Populated_p_addr_pcnt *   0.00 / 100 + T.Populated_p_city_pcnt *   0.00 / 100 + T.Populated_p_state_pcnt *   0.00 / 100 + T.Populated_p_zip_pcnt *   0.00 / 100 + T.Populated_lf_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_name_first_pcnt *   0.00 / 100 + T.Populated_clean_name_middle_pcnt *   0.00 / 100 + T.Populated_clean_name_last_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100 + T.Populated_clean_m_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_m_predir_pcnt *   0.00 / 100 + T.Populated_clean_m_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_m_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_m_postdir_pcnt *   0.00 / 100 + T.Populated_clean_m_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_m_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_m_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_m_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_m_st_pcnt *   0.00 / 100 + T.Populated_clean_m_zip_pcnt *   0.00 / 100 + T.Populated_clean_m_zip4_pcnt *   0.00 / 100 + T.Populated_clean_m_cart_pcnt *   0.00 / 100 + T.Populated_clean_m_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_m_lot_pcnt *   0.00 / 100 + T.Populated_clean_m_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_m_dpbc_pcnt *   0.00 / 100 + T.Populated_clean_m_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_m_record_type_pcnt *   0.00 / 100 + T.Populated_clean_m_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_clean_m_fipscounty_pcnt *   0.00 / 100 + T.Populated_clean_m_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_m_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_m_msa_pcnt *   0.00 / 100 + T.Populated_clean_m_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_m_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_m_err_stat_pcnt *   0.00 / 100 + T.Populated_clean_p_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_p_predir_pcnt *   0.00 / 100 + T.Populated_clean_p_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_p_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_p_postdir_pcnt *   0.00 / 100 + T.Populated_clean_p_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_p_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_p_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_p_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_p_st_pcnt *   0.00 / 100 + T.Populated_clean_p_zip_pcnt *   0.00 / 100 + T.Populated_clean_p_zip4_pcnt *   0.00 / 100 + T.Populated_clean_p_cart_pcnt *   0.00 / 100 + T.Populated_clean_p_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_p_lot_pcnt *   0.00 / 100 + T.Populated_clean_p_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_p_dpbc_pcnt *   0.00 / 100 + T.Populated_clean_p_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_p_record_type_pcnt *   0.00 / 100 + T.Populated_clean_p_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_clean_p_fipscounty_pcnt *   0.00 / 100 + T.Populated_clean_p_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_p_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_p_msa_pcnt *   0.00 / 100 + T.Populated_clean_p_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_p_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_p_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'append_process_date','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','lst_name','fst_name','mid_name','dob','dln','perm_cd_1','perm_cd_2','perm_cd_3','perm_cd_4','eff_dt','m_addr','m_city','m_state','m_zip','p_addr','p_city','p_state','p_zip','lf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_m_prim_range','clean_m_predir','clean_m_prim_name','clean_m_addr_suffix','clean_m_postdir','clean_m_unit_desig','clean_m_sec_range','clean_m_p_city_name','clean_m_v_city_name','clean_m_st','clean_m_zip','clean_m_zip4','clean_m_cart','clean_m_cr_sort_sz','clean_m_lot','clean_m_lot_order','clean_m_dpbc','clean_m_chk_digit','clean_m_record_type','clean_m_ace_fips_st','clean_m_fipscounty','clean_m_geo_lat','clean_m_geo_long','clean_m_msa','clean_m_geo_blk','clean_m_geo_match','clean_m_err_stat','clean_p_prim_range','clean_p_predir','clean_p_prim_name','clean_p_addr_suffix','clean_p_postdir','clean_p_unit_desig','clean_p_sec_range','clean_p_p_city_name','clean_p_v_city_name','clean_p_st','clean_p_zip','clean_p_zip4','clean_p_cart','clean_p_cr_sort_sz','clean_p_lot','clean_p_lot_order','clean_p_dpbc','clean_p_chk_digit','clean_p_record_type','clean_p_ace_fips_st','clean_p_fipscounty','clean_p_geo_lat','clean_p_geo_long','clean_p_msa','clean_p_geo_blk','clean_p_geo_match','clean_p_err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_process_date_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_lst_name_pcnt,le.populated_fst_name_pcnt,le.populated_mid_name_pcnt,le.populated_dob_pcnt,le.populated_dln_pcnt,le.populated_perm_cd_1_pcnt,le.populated_perm_cd_2_pcnt,le.populated_perm_cd_3_pcnt,le.populated_perm_cd_4_pcnt,le.populated_eff_dt_pcnt,le.populated_m_addr_pcnt,le.populated_m_city_pcnt,le.populated_m_state_pcnt,le.populated_m_zip_pcnt,le.populated_p_addr_pcnt,le.populated_p_city_pcnt,le.populated_p_state_pcnt,le.populated_p_zip_pcnt,le.populated_lf_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_name_first_pcnt,le.populated_clean_name_middle_pcnt,le.populated_clean_name_last_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt,le.populated_clean_m_prim_range_pcnt,le.populated_clean_m_predir_pcnt,le.populated_clean_m_prim_name_pcnt,le.populated_clean_m_addr_suffix_pcnt,le.populated_clean_m_postdir_pcnt,le.populated_clean_m_unit_desig_pcnt,le.populated_clean_m_sec_range_pcnt,le.populated_clean_m_p_city_name_pcnt,le.populated_clean_m_v_city_name_pcnt,le.populated_clean_m_st_pcnt,le.populated_clean_m_zip_pcnt,le.populated_clean_m_zip4_pcnt,le.populated_clean_m_cart_pcnt,le.populated_clean_m_cr_sort_sz_pcnt,le.populated_clean_m_lot_pcnt,le.populated_clean_m_lot_order_pcnt,le.populated_clean_m_dpbc_pcnt,le.populated_clean_m_chk_digit_pcnt,le.populated_clean_m_record_type_pcnt,le.populated_clean_m_ace_fips_st_pcnt,le.populated_clean_m_fipscounty_pcnt,le.populated_clean_m_geo_lat_pcnt,le.populated_clean_m_geo_long_pcnt,le.populated_clean_m_msa_pcnt,le.populated_clean_m_geo_blk_pcnt,le.populated_clean_m_geo_match_pcnt,le.populated_clean_m_err_stat_pcnt,le.populated_clean_p_prim_range_pcnt,le.populated_clean_p_predir_pcnt,le.populated_clean_p_prim_name_pcnt,le.populated_clean_p_addr_suffix_pcnt,le.populated_clean_p_postdir_pcnt,le.populated_clean_p_unit_desig_pcnt,le.populated_clean_p_sec_range_pcnt,le.populated_clean_p_p_city_name_pcnt,le.populated_clean_p_v_city_name_pcnt,le.populated_clean_p_st_pcnt,le.populated_clean_p_zip_pcnt,le.populated_clean_p_zip4_pcnt,le.populated_clean_p_cart_pcnt,le.populated_clean_p_cr_sort_sz_pcnt,le.populated_clean_p_lot_pcnt,le.populated_clean_p_lot_order_pcnt,le.populated_clean_p_dpbc_pcnt,le.populated_clean_p_chk_digit_pcnt,le.populated_clean_p_record_type_pcnt,le.populated_clean_p_ace_fips_st_pcnt,le.populated_clean_p_fipscounty_pcnt,le.populated_clean_p_geo_lat_pcnt,le.populated_clean_p_geo_long_pcnt,le.populated_clean_p_msa_pcnt,le.populated_clean_p_geo_blk_pcnt,le.populated_clean_p_geo_match_pcnt,le.populated_clean_p_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_process_date,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_lst_name,le.maxlength_fst_name,le.maxlength_mid_name,le.maxlength_dob,le.maxlength_dln,le.maxlength_perm_cd_1,le.maxlength_perm_cd_2,le.maxlength_perm_cd_3,le.maxlength_perm_cd_4,le.maxlength_eff_dt,le.maxlength_m_addr,le.maxlength_m_city,le.maxlength_m_state,le.maxlength_m_zip,le.maxlength_p_addr,le.maxlength_p_city,le.maxlength_p_state,le.maxlength_p_zip,le.maxlength_lf,le.maxlength_clean_name_prefix,le.maxlength_clean_name_first,le.maxlength_clean_name_middle,le.maxlength_clean_name_last,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score,le.maxlength_clean_m_prim_range,le.maxlength_clean_m_predir,le.maxlength_clean_m_prim_name,le.maxlength_clean_m_addr_suffix,le.maxlength_clean_m_postdir,le.maxlength_clean_m_unit_desig,le.maxlength_clean_m_sec_range,le.maxlength_clean_m_p_city_name,le.maxlength_clean_m_v_city_name,le.maxlength_clean_m_st,le.maxlength_clean_m_zip,le.maxlength_clean_m_zip4,le.maxlength_clean_m_cart,le.maxlength_clean_m_cr_sort_sz,le.maxlength_clean_m_lot,le.maxlength_clean_m_lot_order,le.maxlength_clean_m_dpbc,le.maxlength_clean_m_chk_digit,le.maxlength_clean_m_record_type,le.maxlength_clean_m_ace_fips_st,le.maxlength_clean_m_fipscounty,le.maxlength_clean_m_geo_lat,le.maxlength_clean_m_geo_long,le.maxlength_clean_m_msa,le.maxlength_clean_m_geo_blk,le.maxlength_clean_m_geo_match,le.maxlength_clean_m_err_stat,le.maxlength_clean_p_prim_range,le.maxlength_clean_p_predir,le.maxlength_clean_p_prim_name,le.maxlength_clean_p_addr_suffix,le.maxlength_clean_p_postdir,le.maxlength_clean_p_unit_desig,le.maxlength_clean_p_sec_range,le.maxlength_clean_p_p_city_name,le.maxlength_clean_p_v_city_name,le.maxlength_clean_p_st,le.maxlength_clean_p_zip,le.maxlength_clean_p_zip4,le.maxlength_clean_p_cart,le.maxlength_clean_p_cr_sort_sz,le.maxlength_clean_p_lot,le.maxlength_clean_p_lot_order,le.maxlength_clean_p_dpbc,le.maxlength_clean_p_chk_digit,le.maxlength_clean_p_record_type,le.maxlength_clean_p_ace_fips_st,le.maxlength_clean_p_fipscounty,le.maxlength_clean_p_geo_lat,le.maxlength_clean_p_geo_long,le.maxlength_clean_p_msa,le.maxlength_clean_p_geo_blk,le.maxlength_clean_p_geo_match,le.maxlength_clean_p_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_append_process_date,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_lst_name,le.avelength_fst_name,le.avelength_mid_name,le.avelength_dob,le.avelength_dln,le.avelength_perm_cd_1,le.avelength_perm_cd_2,le.avelength_perm_cd_3,le.avelength_perm_cd_4,le.avelength_eff_dt,le.avelength_m_addr,le.avelength_m_city,le.avelength_m_state,le.avelength_m_zip,le.avelength_p_addr,le.avelength_p_city,le.avelength_p_state,le.avelength_p_zip,le.avelength_lf,le.avelength_clean_name_prefix,le.avelength_clean_name_first,le.avelength_clean_name_middle,le.avelength_clean_name_last,le.avelength_clean_name_suffix,le.avelength_clean_name_score,le.avelength_clean_m_prim_range,le.avelength_clean_m_predir,le.avelength_clean_m_prim_name,le.avelength_clean_m_addr_suffix,le.avelength_clean_m_postdir,le.avelength_clean_m_unit_desig,le.avelength_clean_m_sec_range,le.avelength_clean_m_p_city_name,le.avelength_clean_m_v_city_name,le.avelength_clean_m_st,le.avelength_clean_m_zip,le.avelength_clean_m_zip4,le.avelength_clean_m_cart,le.avelength_clean_m_cr_sort_sz,le.avelength_clean_m_lot,le.avelength_clean_m_lot_order,le.avelength_clean_m_dpbc,le.avelength_clean_m_chk_digit,le.avelength_clean_m_record_type,le.avelength_clean_m_ace_fips_st,le.avelength_clean_m_fipscounty,le.avelength_clean_m_geo_lat,le.avelength_clean_m_geo_long,le.avelength_clean_m_msa,le.avelength_clean_m_geo_blk,le.avelength_clean_m_geo_match,le.avelength_clean_m_err_stat,le.avelength_clean_p_prim_range,le.avelength_clean_p_predir,le.avelength_clean_p_prim_name,le.avelength_clean_p_addr_suffix,le.avelength_clean_p_postdir,le.avelength_clean_p_unit_desig,le.avelength_clean_p_sec_range,le.avelength_clean_p_p_city_name,le.avelength_clean_p_v_city_name,le.avelength_clean_p_st,le.avelength_clean_p_zip,le.avelength_clean_p_zip4,le.avelength_clean_p_cart,le.avelength_clean_p_cr_sort_sz,le.avelength_clean_p_lot,le.avelength_clean_p_lot_order,le.avelength_clean_p_dpbc,le.avelength_clean_p_chk_digit,le.avelength_clean_p_record_type,le.avelength_clean_p_ace_fips_st,le.avelength_clean_p_fipscounty,le.avelength_clean_p_geo_lat,le.avelength_clean_p_geo_long,le.avelength_clean_p_msa,le.avelength_clean_p_geo_blk,le.avelength_clean_p_geo_match,le.avelength_clean_p_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 84, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.append_process_date),IF (le.dt_first_seen <> 0,TRIM((SALT35.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT35.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT35.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT35.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT35.StrType)le.lst_name),TRIM((SALT35.StrType)le.fst_name),TRIM((SALT35.StrType)le.mid_name),TRIM((SALT35.StrType)le.dob),TRIM((SALT35.StrType)le.dln),TRIM((SALT35.StrType)le.perm_cd_1),TRIM((SALT35.StrType)le.perm_cd_2),TRIM((SALT35.StrType)le.perm_cd_3),TRIM((SALT35.StrType)le.perm_cd_4),TRIM((SALT35.StrType)le.eff_dt),TRIM((SALT35.StrType)le.m_addr),TRIM((SALT35.StrType)le.m_city),TRIM((SALT35.StrType)le.m_state),TRIM((SALT35.StrType)le.m_zip),TRIM((SALT35.StrType)le.p_addr),TRIM((SALT35.StrType)le.p_city),TRIM((SALT35.StrType)le.p_state),TRIM((SALT35.StrType)le.p_zip),TRIM((SALT35.StrType)le.lf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_m_prim_range),TRIM((SALT35.StrType)le.clean_m_predir),TRIM((SALT35.StrType)le.clean_m_prim_name),TRIM((SALT35.StrType)le.clean_m_addr_suffix),TRIM((SALT35.StrType)le.clean_m_postdir),TRIM((SALT35.StrType)le.clean_m_unit_desig),TRIM((SALT35.StrType)le.clean_m_sec_range),TRIM((SALT35.StrType)le.clean_m_p_city_name),TRIM((SALT35.StrType)le.clean_m_v_city_name),TRIM((SALT35.StrType)le.clean_m_st),TRIM((SALT35.StrType)le.clean_m_zip),TRIM((SALT35.StrType)le.clean_m_zip4),TRIM((SALT35.StrType)le.clean_m_cart),TRIM((SALT35.StrType)le.clean_m_cr_sort_sz),TRIM((SALT35.StrType)le.clean_m_lot),TRIM((SALT35.StrType)le.clean_m_lot_order),TRIM((SALT35.StrType)le.clean_m_dpbc),TRIM((SALT35.StrType)le.clean_m_chk_digit),TRIM((SALT35.StrType)le.clean_m_record_type),TRIM((SALT35.StrType)le.clean_m_ace_fips_st),TRIM((SALT35.StrType)le.clean_m_fipscounty),TRIM((SALT35.StrType)le.clean_m_geo_lat),TRIM((SALT35.StrType)le.clean_m_geo_long),TRIM((SALT35.StrType)le.clean_m_msa),TRIM((SALT35.StrType)le.clean_m_geo_blk),TRIM((SALT35.StrType)le.clean_m_geo_match),TRIM((SALT35.StrType)le.clean_m_err_stat),TRIM((SALT35.StrType)le.clean_p_prim_range),TRIM((SALT35.StrType)le.clean_p_predir),TRIM((SALT35.StrType)le.clean_p_prim_name),TRIM((SALT35.StrType)le.clean_p_addr_suffix),TRIM((SALT35.StrType)le.clean_p_postdir),TRIM((SALT35.StrType)le.clean_p_unit_desig),TRIM((SALT35.StrType)le.clean_p_sec_range),TRIM((SALT35.StrType)le.clean_p_p_city_name),TRIM((SALT35.StrType)le.clean_p_v_city_name),TRIM((SALT35.StrType)le.clean_p_st),TRIM((SALT35.StrType)le.clean_p_zip),TRIM((SALT35.StrType)le.clean_p_zip4),TRIM((SALT35.StrType)le.clean_p_cart),TRIM((SALT35.StrType)le.clean_p_cr_sort_sz),TRIM((SALT35.StrType)le.clean_p_lot),TRIM((SALT35.StrType)le.clean_p_lot_order),TRIM((SALT35.StrType)le.clean_p_dpbc),TRIM((SALT35.StrType)le.clean_p_chk_digit),TRIM((SALT35.StrType)le.clean_p_record_type),TRIM((SALT35.StrType)le.clean_p_ace_fips_st),TRIM((SALT35.StrType)le.clean_p_fipscounty),TRIM((SALT35.StrType)le.clean_p_geo_lat),TRIM((SALT35.StrType)le.clean_p_geo_long),TRIM((SALT35.StrType)le.clean_p_msa),TRIM((SALT35.StrType)le.clean_p_geo_blk),TRIM((SALT35.StrType)le.clean_p_geo_match),TRIM((SALT35.StrType)le.clean_p_err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,84,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 84);
  SELF.FldNo2 := 1 + (C % 84);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.append_process_date),IF (le.dt_first_seen <> 0,TRIM((SALT35.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT35.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT35.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT35.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT35.StrType)le.lst_name),TRIM((SALT35.StrType)le.fst_name),TRIM((SALT35.StrType)le.mid_name),TRIM((SALT35.StrType)le.dob),TRIM((SALT35.StrType)le.dln),TRIM((SALT35.StrType)le.perm_cd_1),TRIM((SALT35.StrType)le.perm_cd_2),TRIM((SALT35.StrType)le.perm_cd_3),TRIM((SALT35.StrType)le.perm_cd_4),TRIM((SALT35.StrType)le.eff_dt),TRIM((SALT35.StrType)le.m_addr),TRIM((SALT35.StrType)le.m_city),TRIM((SALT35.StrType)le.m_state),TRIM((SALT35.StrType)le.m_zip),TRIM((SALT35.StrType)le.p_addr),TRIM((SALT35.StrType)le.p_city),TRIM((SALT35.StrType)le.p_state),TRIM((SALT35.StrType)le.p_zip),TRIM((SALT35.StrType)le.lf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_m_prim_range),TRIM((SALT35.StrType)le.clean_m_predir),TRIM((SALT35.StrType)le.clean_m_prim_name),TRIM((SALT35.StrType)le.clean_m_addr_suffix),TRIM((SALT35.StrType)le.clean_m_postdir),TRIM((SALT35.StrType)le.clean_m_unit_desig),TRIM((SALT35.StrType)le.clean_m_sec_range),TRIM((SALT35.StrType)le.clean_m_p_city_name),TRIM((SALT35.StrType)le.clean_m_v_city_name),TRIM((SALT35.StrType)le.clean_m_st),TRIM((SALT35.StrType)le.clean_m_zip),TRIM((SALT35.StrType)le.clean_m_zip4),TRIM((SALT35.StrType)le.clean_m_cart),TRIM((SALT35.StrType)le.clean_m_cr_sort_sz),TRIM((SALT35.StrType)le.clean_m_lot),TRIM((SALT35.StrType)le.clean_m_lot_order),TRIM((SALT35.StrType)le.clean_m_dpbc),TRIM((SALT35.StrType)le.clean_m_chk_digit),TRIM((SALT35.StrType)le.clean_m_record_type),TRIM((SALT35.StrType)le.clean_m_ace_fips_st),TRIM((SALT35.StrType)le.clean_m_fipscounty),TRIM((SALT35.StrType)le.clean_m_geo_lat),TRIM((SALT35.StrType)le.clean_m_geo_long),TRIM((SALT35.StrType)le.clean_m_msa),TRIM((SALT35.StrType)le.clean_m_geo_blk),TRIM((SALT35.StrType)le.clean_m_geo_match),TRIM((SALT35.StrType)le.clean_m_err_stat),TRIM((SALT35.StrType)le.clean_p_prim_range),TRIM((SALT35.StrType)le.clean_p_predir),TRIM((SALT35.StrType)le.clean_p_prim_name),TRIM((SALT35.StrType)le.clean_p_addr_suffix),TRIM((SALT35.StrType)le.clean_p_postdir),TRIM((SALT35.StrType)le.clean_p_unit_desig),TRIM((SALT35.StrType)le.clean_p_sec_range),TRIM((SALT35.StrType)le.clean_p_p_city_name),TRIM((SALT35.StrType)le.clean_p_v_city_name),TRIM((SALT35.StrType)le.clean_p_st),TRIM((SALT35.StrType)le.clean_p_zip),TRIM((SALT35.StrType)le.clean_p_zip4),TRIM((SALT35.StrType)le.clean_p_cart),TRIM((SALT35.StrType)le.clean_p_cr_sort_sz),TRIM((SALT35.StrType)le.clean_p_lot),TRIM((SALT35.StrType)le.clean_p_lot_order),TRIM((SALT35.StrType)le.clean_p_dpbc),TRIM((SALT35.StrType)le.clean_p_chk_digit),TRIM((SALT35.StrType)le.clean_p_record_type),TRIM((SALT35.StrType)le.clean_p_ace_fips_st),TRIM((SALT35.StrType)le.clean_p_fipscounty),TRIM((SALT35.StrType)le.clean_p_geo_lat),TRIM((SALT35.StrType)le.clean_p_geo_long),TRIM((SALT35.StrType)le.clean_p_msa),TRIM((SALT35.StrType)le.clean_p_geo_blk),TRIM((SALT35.StrType)le.clean_p_geo_match),TRIM((SALT35.StrType)le.clean_p_err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.append_process_date),IF (le.dt_first_seen <> 0,TRIM((SALT35.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT35.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT35.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT35.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT35.StrType)le.lst_name),TRIM((SALT35.StrType)le.fst_name),TRIM((SALT35.StrType)le.mid_name),TRIM((SALT35.StrType)le.dob),TRIM((SALT35.StrType)le.dln),TRIM((SALT35.StrType)le.perm_cd_1),TRIM((SALT35.StrType)le.perm_cd_2),TRIM((SALT35.StrType)le.perm_cd_3),TRIM((SALT35.StrType)le.perm_cd_4),TRIM((SALT35.StrType)le.eff_dt),TRIM((SALT35.StrType)le.m_addr),TRIM((SALT35.StrType)le.m_city),TRIM((SALT35.StrType)le.m_state),TRIM((SALT35.StrType)le.m_zip),TRIM((SALT35.StrType)le.p_addr),TRIM((SALT35.StrType)le.p_city),TRIM((SALT35.StrType)le.p_state),TRIM((SALT35.StrType)le.p_zip),TRIM((SALT35.StrType)le.lf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_m_prim_range),TRIM((SALT35.StrType)le.clean_m_predir),TRIM((SALT35.StrType)le.clean_m_prim_name),TRIM((SALT35.StrType)le.clean_m_addr_suffix),TRIM((SALT35.StrType)le.clean_m_postdir),TRIM((SALT35.StrType)le.clean_m_unit_desig),TRIM((SALT35.StrType)le.clean_m_sec_range),TRIM((SALT35.StrType)le.clean_m_p_city_name),TRIM((SALT35.StrType)le.clean_m_v_city_name),TRIM((SALT35.StrType)le.clean_m_st),TRIM((SALT35.StrType)le.clean_m_zip),TRIM((SALT35.StrType)le.clean_m_zip4),TRIM((SALT35.StrType)le.clean_m_cart),TRIM((SALT35.StrType)le.clean_m_cr_sort_sz),TRIM((SALT35.StrType)le.clean_m_lot),TRIM((SALT35.StrType)le.clean_m_lot_order),TRIM((SALT35.StrType)le.clean_m_dpbc),TRIM((SALT35.StrType)le.clean_m_chk_digit),TRIM((SALT35.StrType)le.clean_m_record_type),TRIM((SALT35.StrType)le.clean_m_ace_fips_st),TRIM((SALT35.StrType)le.clean_m_fipscounty),TRIM((SALT35.StrType)le.clean_m_geo_lat),TRIM((SALT35.StrType)le.clean_m_geo_long),TRIM((SALT35.StrType)le.clean_m_msa),TRIM((SALT35.StrType)le.clean_m_geo_blk),TRIM((SALT35.StrType)le.clean_m_geo_match),TRIM((SALT35.StrType)le.clean_m_err_stat),TRIM((SALT35.StrType)le.clean_p_prim_range),TRIM((SALT35.StrType)le.clean_p_predir),TRIM((SALT35.StrType)le.clean_p_prim_name),TRIM((SALT35.StrType)le.clean_p_addr_suffix),TRIM((SALT35.StrType)le.clean_p_postdir),TRIM((SALT35.StrType)le.clean_p_unit_desig),TRIM((SALT35.StrType)le.clean_p_sec_range),TRIM((SALT35.StrType)le.clean_p_p_city_name),TRIM((SALT35.StrType)le.clean_p_v_city_name),TRIM((SALT35.StrType)le.clean_p_st),TRIM((SALT35.StrType)le.clean_p_zip),TRIM((SALT35.StrType)le.clean_p_zip4),TRIM((SALT35.StrType)le.clean_p_cart),TRIM((SALT35.StrType)le.clean_p_cr_sort_sz),TRIM((SALT35.StrType)le.clean_p_lot),TRIM((SALT35.StrType)le.clean_p_lot_order),TRIM((SALT35.StrType)le.clean_p_dpbc),TRIM((SALT35.StrType)le.clean_p_chk_digit),TRIM((SALT35.StrType)le.clean_p_record_type),TRIM((SALT35.StrType)le.clean_p_ace_fips_st),TRIM((SALT35.StrType)le.clean_p_fipscounty),TRIM((SALT35.StrType)le.clean_p_geo_lat),TRIM((SALT35.StrType)le.clean_p_geo_long),TRIM((SALT35.StrType)le.clean_p_msa),TRIM((SALT35.StrType)le.clean_p_geo_blk),TRIM((SALT35.StrType)le.clean_p_geo_match),TRIM((SALT35.StrType)le.clean_p_err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),84*84,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_process_date'}
      ,{2,'dt_first_seen'}
      ,{3,'dt_last_seen'}
      ,{4,'dt_vendor_first_reported'}
      ,{5,'dt_vendor_last_reported'}
      ,{6,'lst_name'}
      ,{7,'fst_name'}
      ,{8,'mid_name'}
      ,{9,'dob'}
      ,{10,'dln'}
      ,{11,'perm_cd_1'}
      ,{12,'perm_cd_2'}
      ,{13,'perm_cd_3'}
      ,{14,'perm_cd_4'}
      ,{15,'eff_dt'}
      ,{16,'m_addr'}
      ,{17,'m_city'}
      ,{18,'m_state'}
      ,{19,'m_zip'}
      ,{20,'p_addr'}
      ,{21,'p_city'}
      ,{22,'p_state'}
      ,{23,'p_zip'}
      ,{24,'lf'}
      ,{25,'clean_name_prefix'}
      ,{26,'clean_name_first'}
      ,{27,'clean_name_middle'}
      ,{28,'clean_name_last'}
      ,{29,'clean_name_suffix'}
      ,{30,'clean_name_score'}
      ,{31,'clean_m_prim_range'}
      ,{32,'clean_m_predir'}
      ,{33,'clean_m_prim_name'}
      ,{34,'clean_m_addr_suffix'}
      ,{35,'clean_m_postdir'}
      ,{36,'clean_m_unit_desig'}
      ,{37,'clean_m_sec_range'}
      ,{38,'clean_m_p_city_name'}
      ,{39,'clean_m_v_city_name'}
      ,{40,'clean_m_st'}
      ,{41,'clean_m_zip'}
      ,{42,'clean_m_zip4'}
      ,{43,'clean_m_cart'}
      ,{44,'clean_m_cr_sort_sz'}
      ,{45,'clean_m_lot'}
      ,{46,'clean_m_lot_order'}
      ,{47,'clean_m_dpbc'}
      ,{48,'clean_m_chk_digit'}
      ,{49,'clean_m_record_type'}
      ,{50,'clean_m_ace_fips_st'}
      ,{51,'clean_m_fipscounty'}
      ,{52,'clean_m_geo_lat'}
      ,{53,'clean_m_geo_long'}
      ,{54,'clean_m_msa'}
      ,{55,'clean_m_geo_blk'}
      ,{56,'clean_m_geo_match'}
      ,{57,'clean_m_err_stat'}
      ,{58,'clean_p_prim_range'}
      ,{59,'clean_p_predir'}
      ,{60,'clean_p_prim_name'}
      ,{61,'clean_p_addr_suffix'}
      ,{62,'clean_p_postdir'}
      ,{63,'clean_p_unit_desig'}
      ,{64,'clean_p_sec_range'}
      ,{65,'clean_p_p_city_name'}
      ,{66,'clean_p_v_city_name'}
      ,{67,'clean_p_st'}
      ,{68,'clean_p_zip'}
      ,{69,'clean_p_zip4'}
      ,{70,'clean_p_cart'}
      ,{71,'clean_p_cr_sort_sz'}
      ,{72,'clean_p_lot'}
      ,{73,'clean_p_lot_order'}
      ,{74,'clean_p_dpbc'}
      ,{75,'clean_p_chk_digit'}
      ,{76,'clean_p_record_type'}
      ,{77,'clean_p_ace_fips_st'}
      ,{78,'clean_p_fipscounty'}
      ,{79,'clean_p_geo_lat'}
      ,{80,'clean_p_geo_long'}
      ,{81,'clean_p_msa'}
      ,{82,'clean_p_geo_blk'}
      ,{83,'clean_p_geo_match'}
      ,{84,'clean_p_err_stat'}],SALT35.MAC_Character_Counts.Field_Identification);
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
    Fields.InValid_dt_first_seen((SALT35.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT35.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT35.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT35.StrType)le.dt_vendor_last_reported),
    Fields.InValid_lst_name((SALT35.StrType)le.lst_name,(SALT35.StrType)le.fst_name,(SALT35.StrType)le.mid_name),
    Fields.InValid_fst_name((SALT35.StrType)le.fst_name),
    Fields.InValid_mid_name((SALT35.StrType)le.mid_name),
    Fields.InValid_dob((SALT35.StrType)le.dob),
    Fields.InValid_dln((SALT35.StrType)le.dln),
    Fields.InValid_perm_cd_1((SALT35.StrType)le.perm_cd_1),
    Fields.InValid_perm_cd_2((SALT35.StrType)le.perm_cd_2),
    Fields.InValid_perm_cd_3((SALT35.StrType)le.perm_cd_3),
    Fields.InValid_perm_cd_4((SALT35.StrType)le.perm_cd_4),
    Fields.InValid_eff_dt((SALT35.StrType)le.eff_dt),
    Fields.InValid_m_addr((SALT35.StrType)le.m_addr),
    Fields.InValid_m_city((SALT35.StrType)le.m_city),
    Fields.InValid_m_state((SALT35.StrType)le.m_state),
    Fields.InValid_m_zip((SALT35.StrType)le.m_zip),
    Fields.InValid_p_addr((SALT35.StrType)le.p_addr),
    Fields.InValid_p_city((SALT35.StrType)le.p_city),
    Fields.InValid_p_state((SALT35.StrType)le.p_state),
    Fields.InValid_p_zip((SALT35.StrType)le.p_zip),
    Fields.InValid_lf((SALT35.StrType)le.lf),
    Fields.InValid_clean_name_prefix((SALT35.StrType)le.clean_name_prefix),
    Fields.InValid_clean_name_first((SALT35.StrType)le.clean_name_first),
    Fields.InValid_clean_name_middle((SALT35.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_last((SALT35.StrType)le.clean_name_last,(SALT35.StrType)le.clean_name_first,(SALT35.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_suffix((SALT35.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT35.StrType)le.clean_name_score),
    Fields.InValid_clean_m_prim_range((SALT35.StrType)le.clean_m_prim_range),
    Fields.InValid_clean_m_predir((SALT35.StrType)le.clean_m_predir),
    Fields.InValid_clean_m_prim_name((SALT35.StrType)le.clean_m_prim_name),
    Fields.InValid_clean_m_addr_suffix((SALT35.StrType)le.clean_m_addr_suffix),
    Fields.InValid_clean_m_postdir((SALT35.StrType)le.clean_m_postdir),
    Fields.InValid_clean_m_unit_desig((SALT35.StrType)le.clean_m_unit_desig),
    Fields.InValid_clean_m_sec_range((SALT35.StrType)le.clean_m_sec_range),
    Fields.InValid_clean_m_p_city_name((SALT35.StrType)le.clean_m_p_city_name),
    Fields.InValid_clean_m_v_city_name((SALT35.StrType)le.clean_m_v_city_name),
    Fields.InValid_clean_m_st((SALT35.StrType)le.clean_m_st),
    Fields.InValid_clean_m_zip((SALT35.StrType)le.clean_m_zip),
    Fields.InValid_clean_m_zip4((SALT35.StrType)le.clean_m_zip4),
    Fields.InValid_clean_m_cart((SALT35.StrType)le.clean_m_cart),
    Fields.InValid_clean_m_cr_sort_sz((SALT35.StrType)le.clean_m_cr_sort_sz),
    Fields.InValid_clean_m_lot((SALT35.StrType)le.clean_m_lot),
    Fields.InValid_clean_m_lot_order((SALT35.StrType)le.clean_m_lot_order),
    Fields.InValid_clean_m_dpbc((SALT35.StrType)le.clean_m_dpbc),
    Fields.InValid_clean_m_chk_digit((SALT35.StrType)le.clean_m_chk_digit),
    Fields.InValid_clean_m_record_type((SALT35.StrType)le.clean_m_record_type),
    Fields.InValid_clean_m_ace_fips_st((SALT35.StrType)le.clean_m_ace_fips_st),
    Fields.InValid_clean_m_fipscounty((SALT35.StrType)le.clean_m_fipscounty),
    Fields.InValid_clean_m_geo_lat((SALT35.StrType)le.clean_m_geo_lat),
    Fields.InValid_clean_m_geo_long((SALT35.StrType)le.clean_m_geo_long),
    Fields.InValid_clean_m_msa((SALT35.StrType)le.clean_m_msa),
    Fields.InValid_clean_m_geo_blk((SALT35.StrType)le.clean_m_geo_blk),
    Fields.InValid_clean_m_geo_match((SALT35.StrType)le.clean_m_geo_match),
    Fields.InValid_clean_m_err_stat((SALT35.StrType)le.clean_m_err_stat),
    Fields.InValid_clean_p_prim_range((SALT35.StrType)le.clean_p_prim_range),
    Fields.InValid_clean_p_predir((SALT35.StrType)le.clean_p_predir),
    Fields.InValid_clean_p_prim_name((SALT35.StrType)le.clean_p_prim_name),
    Fields.InValid_clean_p_addr_suffix((SALT35.StrType)le.clean_p_addr_suffix),
    Fields.InValid_clean_p_postdir((SALT35.StrType)le.clean_p_postdir),
    Fields.InValid_clean_p_unit_desig((SALT35.StrType)le.clean_p_unit_desig),
    Fields.InValid_clean_p_sec_range((SALT35.StrType)le.clean_p_sec_range),
    Fields.InValid_clean_p_p_city_name((SALT35.StrType)le.clean_p_p_city_name),
    Fields.InValid_clean_p_v_city_name((SALT35.StrType)le.clean_p_v_city_name),
    Fields.InValid_clean_p_st((SALT35.StrType)le.clean_p_st),
    Fields.InValid_clean_p_zip((SALT35.StrType)le.clean_p_zip),
    Fields.InValid_clean_p_zip4((SALT35.StrType)le.clean_p_zip4),
    Fields.InValid_clean_p_cart((SALT35.StrType)le.clean_p_cart),
    Fields.InValid_clean_p_cr_sort_sz((SALT35.StrType)le.clean_p_cr_sort_sz),
    Fields.InValid_clean_p_lot((SALT35.StrType)le.clean_p_lot),
    Fields.InValid_clean_p_lot_order((SALT35.StrType)le.clean_p_lot_order),
    Fields.InValid_clean_p_dpbc((SALT35.StrType)le.clean_p_dpbc),
    Fields.InValid_clean_p_chk_digit((SALT35.StrType)le.clean_p_chk_digit),
    Fields.InValid_clean_p_record_type((SALT35.StrType)le.clean_p_record_type),
    Fields.InValid_clean_p_ace_fips_st((SALT35.StrType)le.clean_p_ace_fips_st),
    Fields.InValid_clean_p_fipscounty((SALT35.StrType)le.clean_p_fipscounty),
    Fields.InValid_clean_p_geo_lat((SALT35.StrType)le.clean_p_geo_lat),
    Fields.InValid_clean_p_geo_long((SALT35.StrType)le.clean_p_geo_long),
    Fields.InValid_clean_p_msa((SALT35.StrType)le.clean_p_msa),
    Fields.InValid_clean_p_geo_blk((SALT35.StrType)le.clean_p_geo_blk),
    Fields.InValid_clean_p_geo_match((SALT35.StrType)le.clean_p_geo_match),
    Fields.InValid_clean_p_err_stat((SALT35.StrType)le.clean_p_err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,84,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_6pastdate','invalid_6pastdate','invalid_6pastdate','invalid_6pastdate','invalid_name','Unknown','Unknown','invalid_8pastdate','invalid_dln','invalid_perm_cd','invalid_perm_cd','invalid_perm_cd','invalid_perm_cd','invalid_8pastdate','invalid_mandatory','invalid_alpha_num_specials','invalid_state','invalid_zip5','Unknown','invalid_alpha_num_specials','invalid_state','invalid_zip5','Unknown','Unknown','Unknown','Unknown','invalid_clean_name','Unknown','Unknown','Unknown','invalid_direction','Unknown','Unknown','invalid_direction','Unknown','Unknown','invalid_alpha_num_specials','invalid_alpha_num_specials','invalid_state','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','Unknown','invalid_direction','Unknown','Unknown','invalid_direction','Unknown','Unknown','invalid_alpha_num_specials','invalid_alpha_num_specials','invalid_state','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_append_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_lst_name(TotalErrors.ErrorNum),Fields.InValidMessage_fst_name(TotalErrors.ErrorNum),Fields.InValidMessage_mid_name(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_dln(TotalErrors.ErrorNum),Fields.InValidMessage_perm_cd_1(TotalErrors.ErrorNum),Fields.InValidMessage_perm_cd_2(TotalErrors.ErrorNum),Fields.InValidMessage_perm_cd_3(TotalErrors.ErrorNum),Fields.InValidMessage_perm_cd_4(TotalErrors.ErrorNum),Fields.InValidMessage_eff_dt(TotalErrors.ErrorNum),Fields.InValidMessage_m_addr(TotalErrors.ErrorNum),Fields.InValidMessage_m_city(TotalErrors.ErrorNum),Fields.InValidMessage_m_state(TotalErrors.ErrorNum),Fields.InValidMessage_m_zip(TotalErrors.ErrorNum),Fields.InValidMessage_p_addr(TotalErrors.ErrorNum),Fields.InValidMessage_p_city(TotalErrors.ErrorNum),Fields.InValidMessage_p_state(TotalErrors.ErrorNum),Fields.InValidMessage_p_zip(TotalErrors.ErrorNum),Fields.InValidMessage_lf(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_fipscounty(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_m_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_fipscounty(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
