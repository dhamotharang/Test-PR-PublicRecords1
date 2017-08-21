IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_In_MI) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_append_process_date_pcnt := AVE(GROUP,IF(h.append_process_date = (TYPEOF(h.append_process_date))'',0,100));
    maxlength_append_process_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_process_date)));
    avelength_append_process_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.append_process_date)),h.append_process_date<>(typeof(h.append_process_date))'');
    populated_orig_reccode_pcnt := AVE(GROUP,IF(h.orig_reccode = (TYPEOF(h.orig_reccode))'',0,100));
    maxlength_orig_reccode := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_reccode)));
    avelength_orig_reccode := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_reccode)),h.orig_reccode<>(typeof(h.orig_reccode))'');
    populated_orig_clientidnum_pcnt := AVE(GROUP,IF(h.orig_clientidnum = (TYPEOF(h.orig_clientidnum))'',0,100));
    maxlength_orig_clientidnum := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_clientidnum)));
    avelength_orig_clientidnum := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_clientidnum)),h.orig_clientidnum<>(typeof(h.orig_clientidnum))'');
    populated_orig_dlnum_pcnt := AVE(GROUP,IF(h.orig_dlnum = (TYPEOF(h.orig_dlnum))'',0,100));
    maxlength_orig_dlnum := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dlnum)));
    avelength_orig_dlnum := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dlnum)),h.orig_dlnum<>(typeof(h.orig_dlnum))'');
    populated_orig_personalidnum_pcnt := AVE(GROUP,IF(h.orig_personalidnum = (TYPEOF(h.orig_personalidnum))'',0,100));
    maxlength_orig_personalidnum := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_personalidnum)));
    avelength_orig_personalidnum := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_personalidnum)),h.orig_personalidnum<>(typeof(h.orig_personalidnum))'');
    populated_orig_name_pcnt := AVE(GROUP,IF(h.orig_name = (TYPEOF(h.orig_name))'',0,100));
    maxlength_orig_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_name)));
    avelength_orig_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_name)),h.orig_name<>(typeof(h.orig_name))'');
    populated_orig_street_pcnt := AVE(GROUP,IF(h.orig_street = (TYPEOF(h.orig_street))'',0,100));
    maxlength_orig_street := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_street)));
    avelength_orig_street := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_street)),h.orig_street<>(typeof(h.orig_street))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_sex_pcnt := AVE(GROUP,IF(h.orig_sex = (TYPEOF(h.orig_sex))'',0,100));
    maxlength_orig_sex := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_sex)));
    avelength_orig_sex := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_sex)),h.orig_sex<>(typeof(h.orig_sex))'');
    populated_orig_county_pcnt := AVE(GROUP,IF(h.orig_county = (TYPEOF(h.orig_county))'',0,100));
    maxlength_orig_county := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_county)));
    avelength_orig_county := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_county)),h.orig_county<>(typeof(h.orig_county))'');
    populated_orig_dlnorpidindicator_pcnt := AVE(GROUP,IF(h.orig_dlnorpidindicator = (TYPEOF(h.orig_dlnorpidindicator))'',0,100));
    maxlength_orig_dlnorpidindicator := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dlnorpidindicator)));
    avelength_orig_dlnorpidindicator := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dlnorpidindicator)),h.orig_dlnorpidindicator<>(typeof(h.orig_dlnorpidindicator))'');
    populated_orig_mailingstreet_pcnt := AVE(GROUP,IF(h.orig_mailingstreet = (TYPEOF(h.orig_mailingstreet))'',0,100));
    maxlength_orig_mailingstreet := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_mailingstreet)));
    avelength_orig_mailingstreet := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_mailingstreet)),h.orig_mailingstreet<>(typeof(h.orig_mailingstreet))'');
    populated_orig_mailingcity_pcnt := AVE(GROUP,IF(h.orig_mailingcity = (TYPEOF(h.orig_mailingcity))'',0,100));
    maxlength_orig_mailingcity := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_mailingcity)));
    avelength_orig_mailingcity := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_mailingcity)),h.orig_mailingcity<>(typeof(h.orig_mailingcity))'');
    populated_orig_mailingstate_pcnt := AVE(GROUP,IF(h.orig_mailingstate = (TYPEOF(h.orig_mailingstate))'',0,100));
    maxlength_orig_mailingstate := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_mailingstate)));
    avelength_orig_mailingstate := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_mailingstate)),h.orig_mailingstate<>(typeof(h.orig_mailingstate))'');
    populated_orig_mailingzip_pcnt := AVE(GROUP,IF(h.orig_mailingzip = (TYPEOF(h.orig_mailingzip))'',0,100));
    maxlength_orig_mailingzip := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_mailingzip)));
    avelength_orig_mailingzip := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_mailingzip)),h.orig_mailingzip<>(typeof(h.orig_mailingzip))'');
    populated_orig_optoutindicator_pcnt := AVE(GROUP,IF(h.orig_optoutindicator = (TYPEOF(h.orig_optoutindicator))'',0,100));
    maxlength_orig_optoutindicator := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_optoutindicator)));
    avelength_orig_optoutindicator := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_optoutindicator)),h.orig_optoutindicator<>(typeof(h.orig_optoutindicator))'');
    populated_orig_lf_pcnt := AVE(GROUP,IF(h.orig_lf = (TYPEOF(h.orig_lf))'',0,100));
    maxlength_orig_lf := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_lf)));
    avelength_orig_lf := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_lf)),h.orig_lf<>(typeof(h.orig_lf))'');
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
    populated_addr_type_pcnt := AVE(GROUP,IF(h.addr_type = (TYPEOF(h.addr_type))'',0,100));
    maxlength_addr_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.addr_type)));
    avelength_addr_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.addr_type)),h.addr_type<>(typeof(h.addr_type))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_process_date_pcnt *   0.00 / 100 + T.Populated_orig_reccode_pcnt *   0.00 / 100 + T.Populated_orig_clientidnum_pcnt *   0.00 / 100 + T.Populated_orig_dlnum_pcnt *   0.00 / 100 + T.Populated_orig_personalidnum_pcnt *   0.00 / 100 + T.Populated_orig_name_pcnt *   0.00 / 100 + T.Populated_orig_street_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_sex_pcnt *   0.00 / 100 + T.Populated_orig_county_pcnt *   0.00 / 100 + T.Populated_orig_dlnorpidindicator_pcnt *   0.00 / 100 + T.Populated_orig_mailingstreet_pcnt *   0.00 / 100 + T.Populated_orig_mailingcity_pcnt *   0.00 / 100 + T.Populated_orig_mailingstate_pcnt *   0.00 / 100 + T.Populated_orig_mailingzip_pcnt *   0.00 / 100 + T.Populated_orig_optoutindicator_pcnt *   0.00 / 100 + T.Populated_orig_lf_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_name_first_pcnt *   0.00 / 100 + T.Populated_clean_name_middle_pcnt *   0.00 / 100 + T.Populated_clean_name_last_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100 + T.Populated_clean_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_predir_pcnt *   0.00 / 100 + T.Populated_clean_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_postdir_pcnt *   0.00 / 100 + T.Populated_clean_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_st_pcnt *   0.00 / 100 + T.Populated_clean_zip_pcnt *   0.00 / 100 + T.Populated_clean_zip4_pcnt *   0.00 / 100 + T.Populated_clean_cart_pcnt *   0.00 / 100 + T.Populated_clean_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_lot_pcnt *   0.00 / 100 + T.Populated_clean_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_dpbc_pcnt *   0.00 / 100 + T.Populated_clean_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_record_type_pcnt *   0.00 / 100 + T.Populated_clean_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_clean_fipscounty_pcnt *   0.00 / 100 + T.Populated_clean_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_msa_pcnt *   0.00 / 100 + T.Populated_clean_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_err_stat_pcnt *   0.00 / 100 + T.Populated_addr_type_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'append_process_date','orig_reccode','orig_clientidnum','orig_dlnum','orig_personalidnum','orig_name','orig_street','orig_city','orig_state','orig_zip','orig_dob','orig_sex','orig_county','orig_dlnorpidindicator','orig_mailingstreet','orig_mailingcity','orig_mailingstate','orig_mailingzip','orig_optoutindicator','orig_lf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat','addr_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_process_date_pcnt,le.populated_orig_reccode_pcnt,le.populated_orig_clientidnum_pcnt,le.populated_orig_dlnum_pcnt,le.populated_orig_personalidnum_pcnt,le.populated_orig_name_pcnt,le.populated_orig_street_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_sex_pcnt,le.populated_orig_county_pcnt,le.populated_orig_dlnorpidindicator_pcnt,le.populated_orig_mailingstreet_pcnt,le.populated_orig_mailingcity_pcnt,le.populated_orig_mailingstate_pcnt,le.populated_orig_mailingzip_pcnt,le.populated_orig_optoutindicator_pcnt,le.populated_orig_lf_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_name_first_pcnt,le.populated_clean_name_middle_pcnt,le.populated_clean_name_last_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt,le.populated_clean_prim_range_pcnt,le.populated_clean_predir_pcnt,le.populated_clean_prim_name_pcnt,le.populated_clean_addr_suffix_pcnt,le.populated_clean_postdir_pcnt,le.populated_clean_unit_desig_pcnt,le.populated_clean_sec_range_pcnt,le.populated_clean_p_city_name_pcnt,le.populated_clean_v_city_name_pcnt,le.populated_clean_st_pcnt,le.populated_clean_zip_pcnt,le.populated_clean_zip4_pcnt,le.populated_clean_cart_pcnt,le.populated_clean_cr_sort_sz_pcnt,le.populated_clean_lot_pcnt,le.populated_clean_lot_order_pcnt,le.populated_clean_dpbc_pcnt,le.populated_clean_chk_digit_pcnt,le.populated_clean_record_type_pcnt,le.populated_clean_ace_fips_st_pcnt,le.populated_clean_fipscounty_pcnt,le.populated_clean_geo_lat_pcnt,le.populated_clean_geo_long_pcnt,le.populated_clean_msa_pcnt,le.populated_clean_geo_blk_pcnt,le.populated_clean_geo_match_pcnt,le.populated_clean_err_stat_pcnt,le.populated_addr_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_process_date,le.maxlength_orig_reccode,le.maxlength_orig_clientidnum,le.maxlength_orig_dlnum,le.maxlength_orig_personalidnum,le.maxlength_orig_name,le.maxlength_orig_street,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip,le.maxlength_orig_dob,le.maxlength_orig_sex,le.maxlength_orig_county,le.maxlength_orig_dlnorpidindicator,le.maxlength_orig_mailingstreet,le.maxlength_orig_mailingcity,le.maxlength_orig_mailingstate,le.maxlength_orig_mailingzip,le.maxlength_orig_optoutindicator,le.maxlength_orig_lf,le.maxlength_clean_name_prefix,le.maxlength_clean_name_first,le.maxlength_clean_name_middle,le.maxlength_clean_name_last,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score,le.maxlength_clean_prim_range,le.maxlength_clean_predir,le.maxlength_clean_prim_name,le.maxlength_clean_addr_suffix,le.maxlength_clean_postdir,le.maxlength_clean_unit_desig,le.maxlength_clean_sec_range,le.maxlength_clean_p_city_name,le.maxlength_clean_v_city_name,le.maxlength_clean_st,le.maxlength_clean_zip,le.maxlength_clean_zip4,le.maxlength_clean_cart,le.maxlength_clean_cr_sort_sz,le.maxlength_clean_lot,le.maxlength_clean_lot_order,le.maxlength_clean_dpbc,le.maxlength_clean_chk_digit,le.maxlength_clean_record_type,le.maxlength_clean_ace_fips_st,le.maxlength_clean_fipscounty,le.maxlength_clean_geo_lat,le.maxlength_clean_geo_long,le.maxlength_clean_msa,le.maxlength_clean_geo_blk,le.maxlength_clean_geo_match,le.maxlength_clean_err_stat,le.maxlength_addr_type);
  SELF.avelength := CHOOSE(C,le.avelength_append_process_date,le.avelength_orig_reccode,le.avelength_orig_clientidnum,le.avelength_orig_dlnum,le.avelength_orig_personalidnum,le.avelength_orig_name,le.avelength_orig_street,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip,le.avelength_orig_dob,le.avelength_orig_sex,le.avelength_orig_county,le.avelength_orig_dlnorpidindicator,le.avelength_orig_mailingstreet,le.avelength_orig_mailingcity,le.avelength_orig_mailingstate,le.avelength_orig_mailingzip,le.avelength_orig_optoutindicator,le.avelength_orig_lf,le.avelength_clean_name_prefix,le.avelength_clean_name_first,le.avelength_clean_name_middle,le.avelength_clean_name_last,le.avelength_clean_name_suffix,le.avelength_clean_name_score,le.avelength_clean_prim_range,le.avelength_clean_predir,le.avelength_clean_prim_name,le.avelength_clean_addr_suffix,le.avelength_clean_postdir,le.avelength_clean_unit_desig,le.avelength_clean_sec_range,le.avelength_clean_p_city_name,le.avelength_clean_v_city_name,le.avelength_clean_st,le.avelength_clean_zip,le.avelength_clean_zip4,le.avelength_clean_cart,le.avelength_clean_cr_sort_sz,le.avelength_clean_lot,le.avelength_clean_lot_order,le.avelength_clean_dpbc,le.avelength_clean_chk_digit,le.avelength_clean_record_type,le.avelength_clean_ace_fips_st,le.avelength_clean_fipscounty,le.avelength_clean_geo_lat,le.avelength_clean_geo_long,le.avelength_clean_msa,le.avelength_clean_geo_blk,le.avelength_clean_geo_match,le.avelength_clean_err_stat,le.avelength_addr_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 54, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.append_process_date),TRIM((SALT35.StrType)le.orig_reccode),TRIM((SALT35.StrType)le.orig_clientidnum),TRIM((SALT35.StrType)le.orig_dlnum),TRIM((SALT35.StrType)le.orig_personalidnum),TRIM((SALT35.StrType)le.orig_name),TRIM((SALT35.StrType)le.orig_street),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_county),TRIM((SALT35.StrType)le.orig_dlnorpidindicator),TRIM((SALT35.StrType)le.orig_mailingstreet),TRIM((SALT35.StrType)le.orig_mailingcity),TRIM((SALT35.StrType)le.orig_mailingstate),TRIM((SALT35.StrType)le.orig_mailingzip),TRIM((SALT35.StrType)le.orig_optoutindicator),TRIM((SALT35.StrType)le.orig_lf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_prim_range),TRIM((SALT35.StrType)le.clean_predir),TRIM((SALT35.StrType)le.clean_prim_name),TRIM((SALT35.StrType)le.clean_addr_suffix),TRIM((SALT35.StrType)le.clean_postdir),TRIM((SALT35.StrType)le.clean_unit_desig),TRIM((SALT35.StrType)le.clean_sec_range),TRIM((SALT35.StrType)le.clean_p_city_name),TRIM((SALT35.StrType)le.clean_v_city_name),TRIM((SALT35.StrType)le.clean_st),TRIM((SALT35.StrType)le.clean_zip),TRIM((SALT35.StrType)le.clean_zip4),TRIM((SALT35.StrType)le.clean_cart),TRIM((SALT35.StrType)le.clean_cr_sort_sz),TRIM((SALT35.StrType)le.clean_lot),TRIM((SALT35.StrType)le.clean_lot_order),TRIM((SALT35.StrType)le.clean_dpbc),TRIM((SALT35.StrType)le.clean_chk_digit),TRIM((SALT35.StrType)le.clean_record_type),TRIM((SALT35.StrType)le.clean_ace_fips_st),TRIM((SALT35.StrType)le.clean_fipscounty),TRIM((SALT35.StrType)le.clean_geo_lat),TRIM((SALT35.StrType)le.clean_geo_long),TRIM((SALT35.StrType)le.clean_msa),TRIM((SALT35.StrType)le.clean_geo_blk),TRIM((SALT35.StrType)le.clean_geo_match),TRIM((SALT35.StrType)le.clean_err_stat),TRIM((SALT35.StrType)le.addr_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,54,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 54);
  SELF.FldNo2 := 1 + (C % 54);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.append_process_date),TRIM((SALT35.StrType)le.orig_reccode),TRIM((SALT35.StrType)le.orig_clientidnum),TRIM((SALT35.StrType)le.orig_dlnum),TRIM((SALT35.StrType)le.orig_personalidnum),TRIM((SALT35.StrType)le.orig_name),TRIM((SALT35.StrType)le.orig_street),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_county),TRIM((SALT35.StrType)le.orig_dlnorpidindicator),TRIM((SALT35.StrType)le.orig_mailingstreet),TRIM((SALT35.StrType)le.orig_mailingcity),TRIM((SALT35.StrType)le.orig_mailingstate),TRIM((SALT35.StrType)le.orig_mailingzip),TRIM((SALT35.StrType)le.orig_optoutindicator),TRIM((SALT35.StrType)le.orig_lf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_prim_range),TRIM((SALT35.StrType)le.clean_predir),TRIM((SALT35.StrType)le.clean_prim_name),TRIM((SALT35.StrType)le.clean_addr_suffix),TRIM((SALT35.StrType)le.clean_postdir),TRIM((SALT35.StrType)le.clean_unit_desig),TRIM((SALT35.StrType)le.clean_sec_range),TRIM((SALT35.StrType)le.clean_p_city_name),TRIM((SALT35.StrType)le.clean_v_city_name),TRIM((SALT35.StrType)le.clean_st),TRIM((SALT35.StrType)le.clean_zip),TRIM((SALT35.StrType)le.clean_zip4),TRIM((SALT35.StrType)le.clean_cart),TRIM((SALT35.StrType)le.clean_cr_sort_sz),TRIM((SALT35.StrType)le.clean_lot),TRIM((SALT35.StrType)le.clean_lot_order),TRIM((SALT35.StrType)le.clean_dpbc),TRIM((SALT35.StrType)le.clean_chk_digit),TRIM((SALT35.StrType)le.clean_record_type),TRIM((SALT35.StrType)le.clean_ace_fips_st),TRIM((SALT35.StrType)le.clean_fipscounty),TRIM((SALT35.StrType)le.clean_geo_lat),TRIM((SALT35.StrType)le.clean_geo_long),TRIM((SALT35.StrType)le.clean_msa),TRIM((SALT35.StrType)le.clean_geo_blk),TRIM((SALT35.StrType)le.clean_geo_match),TRIM((SALT35.StrType)le.clean_err_stat),TRIM((SALT35.StrType)le.addr_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.append_process_date),TRIM((SALT35.StrType)le.orig_reccode),TRIM((SALT35.StrType)le.orig_clientidnum),TRIM((SALT35.StrType)le.orig_dlnum),TRIM((SALT35.StrType)le.orig_personalidnum),TRIM((SALT35.StrType)le.orig_name),TRIM((SALT35.StrType)le.orig_street),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_county),TRIM((SALT35.StrType)le.orig_dlnorpidindicator),TRIM((SALT35.StrType)le.orig_mailingstreet),TRIM((SALT35.StrType)le.orig_mailingcity),TRIM((SALT35.StrType)le.orig_mailingstate),TRIM((SALT35.StrType)le.orig_mailingzip),TRIM((SALT35.StrType)le.orig_optoutindicator),TRIM((SALT35.StrType)le.orig_lf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.clean_name_score),TRIM((SALT35.StrType)le.clean_prim_range),TRIM((SALT35.StrType)le.clean_predir),TRIM((SALT35.StrType)le.clean_prim_name),TRIM((SALT35.StrType)le.clean_addr_suffix),TRIM((SALT35.StrType)le.clean_postdir),TRIM((SALT35.StrType)le.clean_unit_desig),TRIM((SALT35.StrType)le.clean_sec_range),TRIM((SALT35.StrType)le.clean_p_city_name),TRIM((SALT35.StrType)le.clean_v_city_name),TRIM((SALT35.StrType)le.clean_st),TRIM((SALT35.StrType)le.clean_zip),TRIM((SALT35.StrType)le.clean_zip4),TRIM((SALT35.StrType)le.clean_cart),TRIM((SALT35.StrType)le.clean_cr_sort_sz),TRIM((SALT35.StrType)le.clean_lot),TRIM((SALT35.StrType)le.clean_lot_order),TRIM((SALT35.StrType)le.clean_dpbc),TRIM((SALT35.StrType)le.clean_chk_digit),TRIM((SALT35.StrType)le.clean_record_type),TRIM((SALT35.StrType)le.clean_ace_fips_st),TRIM((SALT35.StrType)le.clean_fipscounty),TRIM((SALT35.StrType)le.clean_geo_lat),TRIM((SALT35.StrType)le.clean_geo_long),TRIM((SALT35.StrType)le.clean_msa),TRIM((SALT35.StrType)le.clean_geo_blk),TRIM((SALT35.StrType)le.clean_geo_match),TRIM((SALT35.StrType)le.clean_err_stat),TRIM((SALT35.StrType)le.addr_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),54*54,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_process_date'}
      ,{2,'orig_reccode'}
      ,{3,'orig_clientidnum'}
      ,{4,'orig_dlnum'}
      ,{5,'orig_personalidnum'}
      ,{6,'orig_name'}
      ,{7,'orig_street'}
      ,{8,'orig_city'}
      ,{9,'orig_state'}
      ,{10,'orig_zip'}
      ,{11,'orig_dob'}
      ,{12,'orig_sex'}
      ,{13,'orig_county'}
      ,{14,'orig_dlnorpidindicator'}
      ,{15,'orig_mailingstreet'}
      ,{16,'orig_mailingcity'}
      ,{17,'orig_mailingstate'}
      ,{18,'orig_mailingzip'}
      ,{19,'orig_optoutindicator'}
      ,{20,'orig_lf'}
      ,{21,'clean_name_prefix'}
      ,{22,'clean_name_first'}
      ,{23,'clean_name_middle'}
      ,{24,'clean_name_last'}
      ,{25,'clean_name_suffix'}
      ,{26,'clean_name_score'}
      ,{27,'clean_prim_range'}
      ,{28,'clean_predir'}
      ,{29,'clean_prim_name'}
      ,{30,'clean_addr_suffix'}
      ,{31,'clean_postdir'}
      ,{32,'clean_unit_desig'}
      ,{33,'clean_sec_range'}
      ,{34,'clean_p_city_name'}
      ,{35,'clean_v_city_name'}
      ,{36,'clean_st'}
      ,{37,'clean_zip'}
      ,{38,'clean_zip4'}
      ,{39,'clean_cart'}
      ,{40,'clean_cr_sort_sz'}
      ,{41,'clean_lot'}
      ,{42,'clean_lot_order'}
      ,{43,'clean_dpbc'}
      ,{44,'clean_chk_digit'}
      ,{45,'clean_record_type'}
      ,{46,'clean_ace_fips_st'}
      ,{47,'clean_fipscounty'}
      ,{48,'clean_geo_lat'}
      ,{49,'clean_geo_long'}
      ,{50,'clean_msa'}
      ,{51,'clean_geo_blk'}
      ,{52,'clean_geo_match'}
      ,{53,'clean_err_stat'}
      ,{54,'addr_type'}],SALT35.MAC_Character_Counts.Field_Identification);
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
    Fields.InValid_orig_reccode((SALT35.StrType)le.orig_reccode),
    Fields.InValid_orig_clientidnum((SALT35.StrType)le.orig_clientidnum),
    Fields.InValid_orig_dlnum((SALT35.StrType)le.orig_dlnum),
    Fields.InValid_orig_personalidnum((SALT35.StrType)le.orig_personalidnum),
    Fields.InValid_orig_name((SALT35.StrType)le.orig_name),
    Fields.InValid_orig_street((SALT35.StrType)le.orig_street),
    Fields.InValid_orig_city((SALT35.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT35.StrType)le.orig_state),
    Fields.InValid_orig_zip((SALT35.StrType)le.orig_zip),
    Fields.InValid_orig_dob((SALT35.StrType)le.orig_dob),
    Fields.InValid_orig_sex((SALT35.StrType)le.orig_sex),
    Fields.InValid_orig_county((SALT35.StrType)le.orig_county),
    Fields.InValid_orig_dlnorpidindicator((SALT35.StrType)le.orig_dlnorpidindicator,(SALT35.StrType)le.orig_dlnum,(SALT35.StrType)le.orig_personalidnum),
    Fields.InValid_orig_mailingstreet((SALT35.StrType)le.orig_mailingstreet),
    Fields.InValid_orig_mailingcity((SALT35.StrType)le.orig_mailingcity),
    Fields.InValid_orig_mailingstate((SALT35.StrType)le.orig_mailingstate),
    Fields.InValid_orig_mailingzip((SALT35.StrType)le.orig_mailingzip),
    Fields.InValid_orig_optoutindicator((SALT35.StrType)le.orig_optoutindicator),
    Fields.InValid_orig_lf((SALT35.StrType)le.orig_lf),
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
    Fields.InValid_addr_type((SALT35.StrType)le.addr_type),
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_orig_reccode','invalid_orig_clientidnum','invalid_dlnum_pid','invalid_dlnum_pid','invalid_orig_name','invalid_wordbag','invalid_alpha_specials','invalid_state','invalid_zip','invalid_orig_dob','invalid_orig_sex','invalid_orig_county','invalid_orig_dlnorpidindicator','invalid_wordbag','invalid_alpha_specials','invalid_state','invalid_zip','Unknown','Unknown','invalid_alpha_specials','invalid_wordbag','invalid_wordbag','invalid_clean_name','invalid_wordbag','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_addr_type');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_append_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_reccode(TotalErrors.ErrorNum),Fields.InValidMessage_orig_clientidnum(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dlnum(TotalErrors.ErrorNum),Fields.InValidMessage_orig_personalidnum(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_street(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_sex(TotalErrors.ErrorNum),Fields.InValidMessage_orig_county(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dlnorpidindicator(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mailingstreet(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mailingcity(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mailingstate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mailingzip(TotalErrors.ErrorNum),Fields.InValidMessage_orig_optoutindicator(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lf(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fipscounty(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_addr_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
