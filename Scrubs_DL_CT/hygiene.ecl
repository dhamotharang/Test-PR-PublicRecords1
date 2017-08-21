IMPORT ut,SALT34;
EXPORT hygiene(dataset(layout_In_CT) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT34.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_append_process_date_pcnt := AVE(GROUP,IF(h.append_process_date = (TYPEOF(h.append_process_date))'',0,100));
    maxlength_append_process_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.append_process_date)));
    avelength_append_process_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.append_process_date)),h.append_process_date<>(typeof(h.append_process_date))'');
    populated_orig_dlstate_pcnt := AVE(GROUP,IF(h.orig_dlstate = (TYPEOF(h.orig_dlstate))'',0,100));
    maxlength_orig_dlstate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_dlstate)));
    avelength_orig_dlstate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_dlstate)),h.orig_dlstate<>(typeof(h.orig_dlstate))'');
    populated_orig_dlnumber_pcnt := AVE(GROUP,IF(h.orig_dlnumber = (TYPEOF(h.orig_dlnumber))'',0,100));
    maxlength_orig_dlnumber := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_dlnumber)));
    avelength_orig_dlnumber := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_dlnumber)),h.orig_dlnumber<>(typeof(h.orig_dlnumber))'');
    populated_orig_name_pcnt := AVE(GROUP,IF(h.orig_name = (TYPEOF(h.orig_name))'',0,100));
    maxlength_orig_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_name)));
    avelength_orig_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_name)),h.orig_name<>(typeof(h.orig_name))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_sex_pcnt := AVE(GROUP,IF(h.orig_sex = (TYPEOF(h.orig_sex))'',0,100));
    maxlength_orig_sex := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_sex)));
    avelength_orig_sex := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_sex)),h.orig_sex<>(typeof(h.orig_sex))'');
    populated_orig_height1_pcnt := AVE(GROUP,IF(h.orig_height1 = (TYPEOF(h.orig_height1))'',0,100));
    maxlength_orig_height1 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_height1)));
    avelength_orig_height1 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_height1)),h.orig_height1<>(typeof(h.orig_height1))'');
    populated_orig_height2_pcnt := AVE(GROUP,IF(h.orig_height2 = (TYPEOF(h.orig_height2))'',0,100));
    maxlength_orig_height2 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_height2)));
    avelength_orig_height2 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_height2)),h.orig_height2<>(typeof(h.orig_height2))'');
    populated_orig_eye_color_pcnt := AVE(GROUP,IF(h.orig_eye_color = (TYPEOF(h.orig_eye_color))'',0,100));
    maxlength_orig_eye_color := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_eye_color)));
    avelength_orig_eye_color := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_eye_color)),h.orig_eye_color<>(typeof(h.orig_eye_color))'');
    populated_orig_mailaddress_pcnt := AVE(GROUP,IF(h.orig_mailaddress = (TYPEOF(h.orig_mailaddress))'',0,100));
    maxlength_orig_mailaddress := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_mailaddress)));
    avelength_orig_mailaddress := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_mailaddress)),h.orig_mailaddress<>(typeof(h.orig_mailaddress))'');
    populated_orig_classification_pcnt := AVE(GROUP,IF(h.orig_classification = (TYPEOF(h.orig_classification))'',0,100));
    maxlength_orig_classification := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_classification)));
    avelength_orig_classification := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_classification)),h.orig_classification<>(typeof(h.orig_classification))'');
    populated_orig_endorsements_pcnt := AVE(GROUP,IF(h.orig_endorsements = (TYPEOF(h.orig_endorsements))'',0,100));
    maxlength_orig_endorsements := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_endorsements)));
    avelength_orig_endorsements := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_endorsements)),h.orig_endorsements<>(typeof(h.orig_endorsements))'');
    populated_orig_issue_date_pcnt := AVE(GROUP,IF(h.orig_issue_date = (TYPEOF(h.orig_issue_date))'',0,100));
    maxlength_orig_issue_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_issue_date)));
    avelength_orig_issue_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_issue_date)),h.orig_issue_date<>(typeof(h.orig_issue_date))'');
    populated_orig_issue_date_dd_pcnt := AVE(GROUP,IF(h.orig_issue_date_dd = (TYPEOF(h.orig_issue_date_dd))'',0,100));
    maxlength_orig_issue_date_dd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_issue_date_dd)));
    avelength_orig_issue_date_dd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_issue_date_dd)),h.orig_issue_date_dd<>(typeof(h.orig_issue_date_dd))'');
    populated_orig_expire_date_pcnt := AVE(GROUP,IF(h.orig_expire_date = (TYPEOF(h.orig_expire_date))'',0,100));
    maxlength_orig_expire_date := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_expire_date)));
    avelength_orig_expire_date := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_expire_date)),h.orig_expire_date<>(typeof(h.orig_expire_date))'');
    populated_orig_expire_date_dd_pcnt := AVE(GROUP,IF(h.orig_expire_date_dd = (TYPEOF(h.orig_expire_date_dd))'',0,100));
    maxlength_orig_expire_date_dd := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_expire_date_dd)));
    avelength_orig_expire_date_dd := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_expire_date_dd)),h.orig_expire_date_dd<>(typeof(h.orig_expire_date_dd))'');
    populated_orig_noncdlstatus_pcnt := AVE(GROUP,IF(h.orig_noncdlstatus = (TYPEOF(h.orig_noncdlstatus))'',0,100));
    maxlength_orig_noncdlstatus := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_noncdlstatus)));
    avelength_orig_noncdlstatus := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_noncdlstatus)),h.orig_noncdlstatus<>(typeof(h.orig_noncdlstatus))'');
    populated_orig_cdlstatus_pcnt := AVE(GROUP,IF(h.orig_cdlstatus = (TYPEOF(h.orig_cdlstatus))'',0,100));
    maxlength_orig_cdlstatus := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_cdlstatus)));
    avelength_orig_cdlstatus := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_cdlstatus)),h.orig_cdlstatus<>(typeof(h.orig_cdlstatus))'');
    populated_orig_restrictions_pcnt := AVE(GROUP,IF(h.orig_restrictions = (TYPEOF(h.orig_restrictions))'',0,100));
    maxlength_orig_restrictions := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_restrictions)));
    avelength_orig_restrictions := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_restrictions)),h.orig_restrictions<>(typeof(h.orig_restrictions))'');
    populated_orig_origdate_pcnt := AVE(GROUP,IF(h.orig_origdate = (TYPEOF(h.orig_origdate))'',0,100));
    maxlength_orig_origdate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_origdate)));
    avelength_orig_origdate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_origdate)),h.orig_origdate<>(typeof(h.orig_origdate))'');
    populated_orig_origcdldate_pcnt := AVE(GROUP,IF(h.orig_origcdldate = (TYPEOF(h.orig_origcdldate))'',0,100));
    maxlength_orig_origcdldate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_origcdldate)));
    avelength_orig_origcdldate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_origcdldate)),h.orig_origcdldate<>(typeof(h.orig_origcdldate))'');
    populated_orig_cancelst_pcnt := AVE(GROUP,IF(h.orig_cancelst = (TYPEOF(h.orig_cancelst))'',0,100));
    maxlength_orig_cancelst := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_cancelst)));
    avelength_orig_cancelst := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_cancelst)),h.orig_cancelst<>(typeof(h.orig_cancelst))'');
    populated_orig_canceldate_pcnt := AVE(GROUP,IF(h.orig_canceldate = (TYPEOF(h.orig_canceldate))'',0,100));
    maxlength_orig_canceldate := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_canceldate)));
    avelength_orig_canceldate := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_canceldate)),h.orig_canceldate<>(typeof(h.orig_canceldate))'');
    populated_orig_crlf_pcnt := AVE(GROUP,IF(h.orig_crlf = (TYPEOF(h.orig_crlf))'',0,100));
    maxlength_orig_crlf := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_crlf)));
    avelength_orig_crlf := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.orig_crlf)),h.orig_crlf<>(typeof(h.orig_crlf))'');
    populated_clean_name_prefix_pcnt := AVE(GROUP,IF(h.clean_name_prefix = (TYPEOF(h.clean_name_prefix))'',0,100));
    maxlength_clean_name_prefix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_prefix)));
    avelength_clean_name_prefix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_prefix)),h.clean_name_prefix<>(typeof(h.clean_name_prefix))'');
    populated_clean_name_first_pcnt := AVE(GROUP,IF(h.clean_name_first = (TYPEOF(h.clean_name_first))'',0,100));
    maxlength_clean_name_first := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_first)));
    avelength_clean_name_first := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_first)),h.clean_name_first<>(typeof(h.clean_name_first))'');
    populated_clean_name_middle_pcnt := AVE(GROUP,IF(h.clean_name_middle = (TYPEOF(h.clean_name_middle))'',0,100));
    maxlength_clean_name_middle := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_middle)));
    avelength_clean_name_middle := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_middle)),h.clean_name_middle<>(typeof(h.clean_name_middle))'');
    populated_clean_name_last_pcnt := AVE(GROUP,IF(h.clean_name_last = (TYPEOF(h.clean_name_last))'',0,100));
    maxlength_clean_name_last := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_last)));
    avelength_clean_name_last := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_last)),h.clean_name_last<>(typeof(h.clean_name_last))'');
    populated_clean_name_suffix_pcnt := AVE(GROUP,IF(h.clean_name_suffix = (TYPEOF(h.clean_name_suffix))'',0,100));
    maxlength_clean_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_suffix)));
    avelength_clean_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_suffix)),h.clean_name_suffix<>(typeof(h.clean_name_suffix))'');
    populated_clean_name_score_pcnt := AVE(GROUP,IF(h.clean_name_score = (TYPEOF(h.clean_name_score))'',0,100));
    maxlength_clean_name_score := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_score)));
    avelength_clean_name_score := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_name_score)),h.clean_name_score<>(typeof(h.clean_name_score))'');
    populated_clean_prim_range_pcnt := AVE(GROUP,IF(h.clean_prim_range = (TYPEOF(h.clean_prim_range))'',0,100));
    maxlength_clean_prim_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_prim_range)));
    avelength_clean_prim_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_prim_range)),h.clean_prim_range<>(typeof(h.clean_prim_range))'');
    populated_clean_predir_pcnt := AVE(GROUP,IF(h.clean_predir = (TYPEOF(h.clean_predir))'',0,100));
    maxlength_clean_predir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_predir)));
    avelength_clean_predir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_predir)),h.clean_predir<>(typeof(h.clean_predir))'');
    populated_clean_prim_name_pcnt := AVE(GROUP,IF(h.clean_prim_name = (TYPEOF(h.clean_prim_name))'',0,100));
    maxlength_clean_prim_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_prim_name)));
    avelength_clean_prim_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_prim_name)),h.clean_prim_name<>(typeof(h.clean_prim_name))'');
    populated_clean_addr_suffix_pcnt := AVE(GROUP,IF(h.clean_addr_suffix = (TYPEOF(h.clean_addr_suffix))'',0,100));
    maxlength_clean_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_addr_suffix)));
    avelength_clean_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_addr_suffix)),h.clean_addr_suffix<>(typeof(h.clean_addr_suffix))'');
    populated_clean_postdir_pcnt := AVE(GROUP,IF(h.clean_postdir = (TYPEOF(h.clean_postdir))'',0,100));
    maxlength_clean_postdir := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_postdir)));
    avelength_clean_postdir := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_postdir)),h.clean_postdir<>(typeof(h.clean_postdir))'');
    populated_clean_unit_desig_pcnt := AVE(GROUP,IF(h.clean_unit_desig = (TYPEOF(h.clean_unit_desig))'',0,100));
    maxlength_clean_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_unit_desig)));
    avelength_clean_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_unit_desig)),h.clean_unit_desig<>(typeof(h.clean_unit_desig))'');
    populated_clean_sec_range_pcnt := AVE(GROUP,IF(h.clean_sec_range = (TYPEOF(h.clean_sec_range))'',0,100));
    maxlength_clean_sec_range := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_sec_range)));
    avelength_clean_sec_range := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_sec_range)),h.clean_sec_range<>(typeof(h.clean_sec_range))'');
    populated_clean_p_city_name_pcnt := AVE(GROUP,IF(h.clean_p_city_name = (TYPEOF(h.clean_p_city_name))'',0,100));
    maxlength_clean_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_p_city_name)));
    avelength_clean_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_p_city_name)),h.clean_p_city_name<>(typeof(h.clean_p_city_name))'');
    populated_clean_v_city_name_pcnt := AVE(GROUP,IF(h.clean_v_city_name = (TYPEOF(h.clean_v_city_name))'',0,100));
    maxlength_clean_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_v_city_name)));
    avelength_clean_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_v_city_name)),h.clean_v_city_name<>(typeof(h.clean_v_city_name))'');
    populated_clean_st_pcnt := AVE(GROUP,IF(h.clean_st = (TYPEOF(h.clean_st))'',0,100));
    maxlength_clean_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_st)));
    avelength_clean_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_st)),h.clean_st<>(typeof(h.clean_st))'');
    populated_clean_zip_pcnt := AVE(GROUP,IF(h.clean_zip = (TYPEOF(h.clean_zip))'',0,100));
    maxlength_clean_zip := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_zip)));
    avelength_clean_zip := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_zip)),h.clean_zip<>(typeof(h.clean_zip))'');
    populated_clean_zip4_pcnt := AVE(GROUP,IF(h.clean_zip4 = (TYPEOF(h.clean_zip4))'',0,100));
    maxlength_clean_zip4 := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_zip4)));
    avelength_clean_zip4 := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_zip4)),h.clean_zip4<>(typeof(h.clean_zip4))'');
    populated_clean_cart_pcnt := AVE(GROUP,IF(h.clean_cart = (TYPEOF(h.clean_cart))'',0,100));
    maxlength_clean_cart := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_cart)));
    avelength_clean_cart := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_cart)),h.clean_cart<>(typeof(h.clean_cart))'');
    populated_clean_cr_sort_sz_pcnt := AVE(GROUP,IF(h.clean_cr_sort_sz = (TYPEOF(h.clean_cr_sort_sz))'',0,100));
    maxlength_clean_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_cr_sort_sz)));
    avelength_clean_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_cr_sort_sz)),h.clean_cr_sort_sz<>(typeof(h.clean_cr_sort_sz))'');
    populated_clean_lot_pcnt := AVE(GROUP,IF(h.clean_lot = (TYPEOF(h.clean_lot))'',0,100));
    maxlength_clean_lot := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_lot)));
    avelength_clean_lot := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_lot)),h.clean_lot<>(typeof(h.clean_lot))'');
    populated_clean_lot_order_pcnt := AVE(GROUP,IF(h.clean_lot_order = (TYPEOF(h.clean_lot_order))'',0,100));
    maxlength_clean_lot_order := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_lot_order)));
    avelength_clean_lot_order := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_lot_order)),h.clean_lot_order<>(typeof(h.clean_lot_order))'');
    populated_clean_dpbc_pcnt := AVE(GROUP,IF(h.clean_dpbc = (TYPEOF(h.clean_dpbc))'',0,100));
    maxlength_clean_dpbc := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_dpbc)));
    avelength_clean_dpbc := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_dpbc)),h.clean_dpbc<>(typeof(h.clean_dpbc))'');
    populated_clean_chk_digit_pcnt := AVE(GROUP,IF(h.clean_chk_digit = (TYPEOF(h.clean_chk_digit))'',0,100));
    maxlength_clean_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_chk_digit)));
    avelength_clean_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_chk_digit)),h.clean_chk_digit<>(typeof(h.clean_chk_digit))'');
    populated_clean_record_type_pcnt := AVE(GROUP,IF(h.clean_record_type = (TYPEOF(h.clean_record_type))'',0,100));
    maxlength_clean_record_type := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_record_type)));
    avelength_clean_record_type := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_record_type)),h.clean_record_type<>(typeof(h.clean_record_type))'');
    populated_clean_ace_fips_st_pcnt := AVE(GROUP,IF(h.clean_ace_fips_st = (TYPEOF(h.clean_ace_fips_st))'',0,100));
    maxlength_clean_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_ace_fips_st)));
    avelength_clean_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_ace_fips_st)),h.clean_ace_fips_st<>(typeof(h.clean_ace_fips_st))'');
    populated_clean_fipscounty_pcnt := AVE(GROUP,IF(h.clean_fipscounty = (TYPEOF(h.clean_fipscounty))'',0,100));
    maxlength_clean_fipscounty := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_fipscounty)));
    avelength_clean_fipscounty := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_fipscounty)),h.clean_fipscounty<>(typeof(h.clean_fipscounty))'');
    populated_clean_geo_lat_pcnt := AVE(GROUP,IF(h.clean_geo_lat = (TYPEOF(h.clean_geo_lat))'',0,100));
    maxlength_clean_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_geo_lat)));
    avelength_clean_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_geo_lat)),h.clean_geo_lat<>(typeof(h.clean_geo_lat))'');
    populated_clean_geo_long_pcnt := AVE(GROUP,IF(h.clean_geo_long = (TYPEOF(h.clean_geo_long))'',0,100));
    maxlength_clean_geo_long := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_geo_long)));
    avelength_clean_geo_long := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_geo_long)),h.clean_geo_long<>(typeof(h.clean_geo_long))'');
    populated_clean_msa_pcnt := AVE(GROUP,IF(h.clean_msa = (TYPEOF(h.clean_msa))'',0,100));
    maxlength_clean_msa := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_msa)));
    avelength_clean_msa := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_msa)),h.clean_msa<>(typeof(h.clean_msa))'');
    populated_clean_geo_blk_pcnt := AVE(GROUP,IF(h.clean_geo_blk = (TYPEOF(h.clean_geo_blk))'',0,100));
    maxlength_clean_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_geo_blk)));
    avelength_clean_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_geo_blk)),h.clean_geo_blk<>(typeof(h.clean_geo_blk))'');
    populated_clean_geo_match_pcnt := AVE(GROUP,IF(h.clean_geo_match = (TYPEOF(h.clean_geo_match))'',0,100));
    maxlength_clean_geo_match := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_geo_match)));
    avelength_clean_geo_match := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_geo_match)),h.clean_geo_match<>(typeof(h.clean_geo_match))'');
    populated_clean_err_stat_pcnt := AVE(GROUP,IF(h.clean_err_stat = (TYPEOF(h.clean_err_stat))'',0,100));
    maxlength_clean_err_stat := MAX(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_err_stat)));
    avelength_clean_err_stat := AVE(GROUP,LENGTH(TRIM((SALT34.StrType)h.clean_err_stat)),h.clean_err_stat<>(typeof(h.clean_err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_append_process_date_pcnt *   0.00 / 100 + T.Populated_orig_dlstate_pcnt *   0.00 / 100 + T.Populated_orig_dlnumber_pcnt *   0.00 / 100 + T.Populated_orig_name_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_sex_pcnt *   0.00 / 100 + T.Populated_orig_height1_pcnt *   0.00 / 100 + T.Populated_orig_height2_pcnt *   0.00 / 100 + T.Populated_orig_eye_color_pcnt *   0.00 / 100 + T.Populated_orig_mailaddress_pcnt *   0.00 / 100 + T.Populated_orig_classification_pcnt *   0.00 / 100 + T.Populated_orig_endorsements_pcnt *   0.00 / 100 + T.Populated_orig_issue_date_pcnt *   0.00 / 100 + T.Populated_orig_issue_date_dd_pcnt *   0.00 / 100 + T.Populated_orig_expire_date_pcnt *   0.00 / 100 + T.Populated_orig_expire_date_dd_pcnt *   0.00 / 100 + T.Populated_orig_noncdlstatus_pcnt *   0.00 / 100 + T.Populated_orig_cdlstatus_pcnt *   0.00 / 100 + T.Populated_orig_restrictions_pcnt *   0.00 / 100 + T.Populated_orig_origdate_pcnt *   0.00 / 100 + T.Populated_orig_origcdldate_pcnt *   0.00 / 100 + T.Populated_orig_cancelst_pcnt *   0.00 / 100 + T.Populated_orig_canceldate_pcnt *   0.00 / 100 + T.Populated_orig_crlf_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_name_first_pcnt *   0.00 / 100 + T.Populated_clean_name_middle_pcnt *   0.00 / 100 + T.Populated_clean_name_last_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_clean_name_score_pcnt *   0.00 / 100 + T.Populated_clean_prim_range_pcnt *   0.00 / 100 + T.Populated_clean_predir_pcnt *   0.00 / 100 + T.Populated_clean_prim_name_pcnt *   0.00 / 100 + T.Populated_clean_addr_suffix_pcnt *   0.00 / 100 + T.Populated_clean_postdir_pcnt *   0.00 / 100 + T.Populated_clean_unit_desig_pcnt *   0.00 / 100 + T.Populated_clean_sec_range_pcnt *   0.00 / 100 + T.Populated_clean_p_city_name_pcnt *   0.00 / 100 + T.Populated_clean_v_city_name_pcnt *   0.00 / 100 + T.Populated_clean_st_pcnt *   0.00 / 100 + T.Populated_clean_zip_pcnt *   0.00 / 100 + T.Populated_clean_zip4_pcnt *   0.00 / 100 + T.Populated_clean_cart_pcnt *   0.00 / 100 + T.Populated_clean_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_clean_lot_pcnt *   0.00 / 100 + T.Populated_clean_lot_order_pcnt *   0.00 / 100 + T.Populated_clean_dpbc_pcnt *   0.00 / 100 + T.Populated_clean_chk_digit_pcnt *   0.00 / 100 + T.Populated_clean_record_type_pcnt *   0.00 / 100 + T.Populated_clean_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_clean_fipscounty_pcnt *   0.00 / 100 + T.Populated_clean_geo_lat_pcnt *   0.00 / 100 + T.Populated_clean_geo_long_pcnt *   0.00 / 100 + T.Populated_clean_msa_pcnt *   0.00 / 100 + T.Populated_clean_geo_blk_pcnt *   0.00 / 100 + T.Populated_clean_geo_match_pcnt *   0.00 / 100 + T.Populated_clean_err_stat_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT34.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'append_process_date','orig_dlstate','orig_dlnumber','orig_name','orig_dob','orig_sex','orig_height1','orig_height2','orig_eye_color','orig_mailaddress','orig_classification','orig_endorsements','orig_issue_date','orig_issue_date_dd','orig_expire_date','orig_expire_date_dd','orig_noncdlstatus','orig_cdlstatus','orig_restrictions','orig_origdate','orig_origcdldate','orig_cancelst','orig_canceldate','orig_crlf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','clean_name_score','clean_prim_range','clean_predir','clean_prim_name','clean_addr_suffix','clean_postdir','clean_unit_desig','clean_sec_range','clean_p_city_name','clean_v_city_name','clean_st','clean_zip','clean_zip4','clean_cart','clean_cr_sort_sz','clean_lot','clean_lot_order','clean_dpbc','clean_chk_digit','clean_record_type','clean_ace_fips_st','clean_fipscounty','clean_geo_lat','clean_geo_long','clean_msa','clean_geo_blk','clean_geo_match','clean_err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_append_process_date_pcnt,le.populated_orig_dlstate_pcnt,le.populated_orig_dlnumber_pcnt,le.populated_orig_name_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_sex_pcnt,le.populated_orig_height1_pcnt,le.populated_orig_height2_pcnt,le.populated_orig_eye_color_pcnt,le.populated_orig_mailaddress_pcnt,le.populated_orig_classification_pcnt,le.populated_orig_endorsements_pcnt,le.populated_orig_issue_date_pcnt,le.populated_orig_issue_date_dd_pcnt,le.populated_orig_expire_date_pcnt,le.populated_orig_expire_date_dd_pcnt,le.populated_orig_noncdlstatus_pcnt,le.populated_orig_cdlstatus_pcnt,le.populated_orig_restrictions_pcnt,le.populated_orig_origdate_pcnt,le.populated_orig_origcdldate_pcnt,le.populated_orig_cancelst_pcnt,le.populated_orig_canceldate_pcnt,le.populated_orig_crlf_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_name_first_pcnt,le.populated_clean_name_middle_pcnt,le.populated_clean_name_last_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_clean_name_score_pcnt,le.populated_clean_prim_range_pcnt,le.populated_clean_predir_pcnt,le.populated_clean_prim_name_pcnt,le.populated_clean_addr_suffix_pcnt,le.populated_clean_postdir_pcnt,le.populated_clean_unit_desig_pcnt,le.populated_clean_sec_range_pcnt,le.populated_clean_p_city_name_pcnt,le.populated_clean_v_city_name_pcnt,le.populated_clean_st_pcnt,le.populated_clean_zip_pcnt,le.populated_clean_zip4_pcnt,le.populated_clean_cart_pcnt,le.populated_clean_cr_sort_sz_pcnt,le.populated_clean_lot_pcnt,le.populated_clean_lot_order_pcnt,le.populated_clean_dpbc_pcnt,le.populated_clean_chk_digit_pcnt,le.populated_clean_record_type_pcnt,le.populated_clean_ace_fips_st_pcnt,le.populated_clean_fipscounty_pcnt,le.populated_clean_geo_lat_pcnt,le.populated_clean_geo_long_pcnt,le.populated_clean_msa_pcnt,le.populated_clean_geo_blk_pcnt,le.populated_clean_geo_match_pcnt,le.populated_clean_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_append_process_date,le.maxlength_orig_dlstate,le.maxlength_orig_dlnumber,le.maxlength_orig_name,le.maxlength_orig_dob,le.maxlength_orig_sex,le.maxlength_orig_height1,le.maxlength_orig_height2,le.maxlength_orig_eye_color,le.maxlength_orig_mailaddress,le.maxlength_orig_classification,le.maxlength_orig_endorsements,le.maxlength_orig_issue_date,le.maxlength_orig_issue_date_dd,le.maxlength_orig_expire_date,le.maxlength_orig_expire_date_dd,le.maxlength_orig_noncdlstatus,le.maxlength_orig_cdlstatus,le.maxlength_orig_restrictions,le.maxlength_orig_origdate,le.maxlength_orig_origcdldate,le.maxlength_orig_cancelst,le.maxlength_orig_canceldate,le.maxlength_orig_crlf,le.maxlength_clean_name_prefix,le.maxlength_clean_name_first,le.maxlength_clean_name_middle,le.maxlength_clean_name_last,le.maxlength_clean_name_suffix,le.maxlength_clean_name_score,le.maxlength_clean_prim_range,le.maxlength_clean_predir,le.maxlength_clean_prim_name,le.maxlength_clean_addr_suffix,le.maxlength_clean_postdir,le.maxlength_clean_unit_desig,le.maxlength_clean_sec_range,le.maxlength_clean_p_city_name,le.maxlength_clean_v_city_name,le.maxlength_clean_st,le.maxlength_clean_zip,le.maxlength_clean_zip4,le.maxlength_clean_cart,le.maxlength_clean_cr_sort_sz,le.maxlength_clean_lot,le.maxlength_clean_lot_order,le.maxlength_clean_dpbc,le.maxlength_clean_chk_digit,le.maxlength_clean_record_type,le.maxlength_clean_ace_fips_st,le.maxlength_clean_fipscounty,le.maxlength_clean_geo_lat,le.maxlength_clean_geo_long,le.maxlength_clean_msa,le.maxlength_clean_geo_blk,le.maxlength_clean_geo_match,le.maxlength_clean_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_append_process_date,le.avelength_orig_dlstate,le.avelength_orig_dlnumber,le.avelength_orig_name,le.avelength_orig_dob,le.avelength_orig_sex,le.avelength_orig_height1,le.avelength_orig_height2,le.avelength_orig_eye_color,le.avelength_orig_mailaddress,le.avelength_orig_classification,le.avelength_orig_endorsements,le.avelength_orig_issue_date,le.avelength_orig_issue_date_dd,le.avelength_orig_expire_date,le.avelength_orig_expire_date_dd,le.avelength_orig_noncdlstatus,le.avelength_orig_cdlstatus,le.avelength_orig_restrictions,le.avelength_orig_origdate,le.avelength_orig_origcdldate,le.avelength_orig_cancelst,le.avelength_orig_canceldate,le.avelength_orig_crlf,le.avelength_clean_name_prefix,le.avelength_clean_name_first,le.avelength_clean_name_middle,le.avelength_clean_name_last,le.avelength_clean_name_suffix,le.avelength_clean_name_score,le.avelength_clean_prim_range,le.avelength_clean_predir,le.avelength_clean_prim_name,le.avelength_clean_addr_suffix,le.avelength_clean_postdir,le.avelength_clean_unit_desig,le.avelength_clean_sec_range,le.avelength_clean_p_city_name,le.avelength_clean_v_city_name,le.avelength_clean_st,le.avelength_clean_zip,le.avelength_clean_zip4,le.avelength_clean_cart,le.avelength_clean_cr_sort_sz,le.avelength_clean_lot,le.avelength_clean_lot_order,le.avelength_clean_dpbc,le.avelength_clean_chk_digit,le.avelength_clean_record_type,le.avelength_clean_ace_fips_st,le.avelength_clean_fipscounty,le.avelength_clean_geo_lat,le.avelength_clean_geo_long,le.avelength_clean_msa,le.avelength_clean_geo_blk,le.avelength_clean_geo_match,le.avelength_clean_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 57, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT34.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT34.StrType)le.append_process_date),TRIM((SALT34.StrType)le.orig_dlstate),TRIM((SALT34.StrType)le.orig_dlnumber),TRIM((SALT34.StrType)le.orig_name),TRIM((SALT34.StrType)le.orig_dob),TRIM((SALT34.StrType)le.orig_sex),TRIM((SALT34.StrType)le.orig_height1),TRIM((SALT34.StrType)le.orig_height2),TRIM((SALT34.StrType)le.orig_eye_color),TRIM((SALT34.StrType)le.orig_mailaddress),TRIM((SALT34.StrType)le.orig_classification),TRIM((SALT34.StrType)le.orig_endorsements),TRIM((SALT34.StrType)le.orig_issue_date),TRIM((SALT34.StrType)le.orig_issue_date_dd),TRIM((SALT34.StrType)le.orig_expire_date),TRIM((SALT34.StrType)le.orig_expire_date_dd),TRIM((SALT34.StrType)le.orig_noncdlstatus),TRIM((SALT34.StrType)le.orig_cdlstatus),TRIM((SALT34.StrType)le.orig_restrictions),TRIM((SALT34.StrType)le.orig_origdate),TRIM((SALT34.StrType)le.orig_origcdldate),TRIM((SALT34.StrType)le.orig_cancelst),TRIM((SALT34.StrType)le.orig_canceldate),TRIM((SALT34.StrType)le.orig_crlf),TRIM((SALT34.StrType)le.clean_name_prefix),TRIM((SALT34.StrType)le.clean_name_first),TRIM((SALT34.StrType)le.clean_name_middle),TRIM((SALT34.StrType)le.clean_name_last),TRIM((SALT34.StrType)le.clean_name_suffix),TRIM((SALT34.StrType)le.clean_name_score),TRIM((SALT34.StrType)le.clean_prim_range),TRIM((SALT34.StrType)le.clean_predir),TRIM((SALT34.StrType)le.clean_prim_name),TRIM((SALT34.StrType)le.clean_addr_suffix),TRIM((SALT34.StrType)le.clean_postdir),TRIM((SALT34.StrType)le.clean_unit_desig),TRIM((SALT34.StrType)le.clean_sec_range),TRIM((SALT34.StrType)le.clean_p_city_name),TRIM((SALT34.StrType)le.clean_v_city_name),TRIM((SALT34.StrType)le.clean_st),TRIM((SALT34.StrType)le.clean_zip),TRIM((SALT34.StrType)le.clean_zip4),TRIM((SALT34.StrType)le.clean_cart),TRIM((SALT34.StrType)le.clean_cr_sort_sz),TRIM((SALT34.StrType)le.clean_lot),TRIM((SALT34.StrType)le.clean_lot_order),TRIM((SALT34.StrType)le.clean_dpbc),TRIM((SALT34.StrType)le.clean_chk_digit),TRIM((SALT34.StrType)le.clean_record_type),TRIM((SALT34.StrType)le.clean_ace_fips_st),TRIM((SALT34.StrType)le.clean_fipscounty),TRIM((SALT34.StrType)le.clean_geo_lat),TRIM((SALT34.StrType)le.clean_geo_long),TRIM((SALT34.StrType)le.clean_msa),TRIM((SALT34.StrType)le.clean_geo_blk),TRIM((SALT34.StrType)le.clean_geo_match),TRIM((SALT34.StrType)le.clean_err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,57,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT34.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 57);
  SELF.FldNo2 := 1 + (C % 57);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT34.StrType)le.append_process_date),TRIM((SALT34.StrType)le.orig_dlstate),TRIM((SALT34.StrType)le.orig_dlnumber),TRIM((SALT34.StrType)le.orig_name),TRIM((SALT34.StrType)le.orig_dob),TRIM((SALT34.StrType)le.orig_sex),TRIM((SALT34.StrType)le.orig_height1),TRIM((SALT34.StrType)le.orig_height2),TRIM((SALT34.StrType)le.orig_eye_color),TRIM((SALT34.StrType)le.orig_mailaddress),TRIM((SALT34.StrType)le.orig_classification),TRIM((SALT34.StrType)le.orig_endorsements),TRIM((SALT34.StrType)le.orig_issue_date),TRIM((SALT34.StrType)le.orig_issue_date_dd),TRIM((SALT34.StrType)le.orig_expire_date),TRIM((SALT34.StrType)le.orig_expire_date_dd),TRIM((SALT34.StrType)le.orig_noncdlstatus),TRIM((SALT34.StrType)le.orig_cdlstatus),TRIM((SALT34.StrType)le.orig_restrictions),TRIM((SALT34.StrType)le.orig_origdate),TRIM((SALT34.StrType)le.orig_origcdldate),TRIM((SALT34.StrType)le.orig_cancelst),TRIM((SALT34.StrType)le.orig_canceldate),TRIM((SALT34.StrType)le.orig_crlf),TRIM((SALT34.StrType)le.clean_name_prefix),TRIM((SALT34.StrType)le.clean_name_first),TRIM((SALT34.StrType)le.clean_name_middle),TRIM((SALT34.StrType)le.clean_name_last),TRIM((SALT34.StrType)le.clean_name_suffix),TRIM((SALT34.StrType)le.clean_name_score),TRIM((SALT34.StrType)le.clean_prim_range),TRIM((SALT34.StrType)le.clean_predir),TRIM((SALT34.StrType)le.clean_prim_name),TRIM((SALT34.StrType)le.clean_addr_suffix),TRIM((SALT34.StrType)le.clean_postdir),TRIM((SALT34.StrType)le.clean_unit_desig),TRIM((SALT34.StrType)le.clean_sec_range),TRIM((SALT34.StrType)le.clean_p_city_name),TRIM((SALT34.StrType)le.clean_v_city_name),TRIM((SALT34.StrType)le.clean_st),TRIM((SALT34.StrType)le.clean_zip),TRIM((SALT34.StrType)le.clean_zip4),TRIM((SALT34.StrType)le.clean_cart),TRIM((SALT34.StrType)le.clean_cr_sort_sz),TRIM((SALT34.StrType)le.clean_lot),TRIM((SALT34.StrType)le.clean_lot_order),TRIM((SALT34.StrType)le.clean_dpbc),TRIM((SALT34.StrType)le.clean_chk_digit),TRIM((SALT34.StrType)le.clean_record_type),TRIM((SALT34.StrType)le.clean_ace_fips_st),TRIM((SALT34.StrType)le.clean_fipscounty),TRIM((SALT34.StrType)le.clean_geo_lat),TRIM((SALT34.StrType)le.clean_geo_long),TRIM((SALT34.StrType)le.clean_msa),TRIM((SALT34.StrType)le.clean_geo_blk),TRIM((SALT34.StrType)le.clean_geo_match),TRIM((SALT34.StrType)le.clean_err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT34.StrType)le.append_process_date),TRIM((SALT34.StrType)le.orig_dlstate),TRIM((SALT34.StrType)le.orig_dlnumber),TRIM((SALT34.StrType)le.orig_name),TRIM((SALT34.StrType)le.orig_dob),TRIM((SALT34.StrType)le.orig_sex),TRIM((SALT34.StrType)le.orig_height1),TRIM((SALT34.StrType)le.orig_height2),TRIM((SALT34.StrType)le.orig_eye_color),TRIM((SALT34.StrType)le.orig_mailaddress),TRIM((SALT34.StrType)le.orig_classification),TRIM((SALT34.StrType)le.orig_endorsements),TRIM((SALT34.StrType)le.orig_issue_date),TRIM((SALT34.StrType)le.orig_issue_date_dd),TRIM((SALT34.StrType)le.orig_expire_date),TRIM((SALT34.StrType)le.orig_expire_date_dd),TRIM((SALT34.StrType)le.orig_noncdlstatus),TRIM((SALT34.StrType)le.orig_cdlstatus),TRIM((SALT34.StrType)le.orig_restrictions),TRIM((SALT34.StrType)le.orig_origdate),TRIM((SALT34.StrType)le.orig_origcdldate),TRIM((SALT34.StrType)le.orig_cancelst),TRIM((SALT34.StrType)le.orig_canceldate),TRIM((SALT34.StrType)le.orig_crlf),TRIM((SALT34.StrType)le.clean_name_prefix),TRIM((SALT34.StrType)le.clean_name_first),TRIM((SALT34.StrType)le.clean_name_middle),TRIM((SALT34.StrType)le.clean_name_last),TRIM((SALT34.StrType)le.clean_name_suffix),TRIM((SALT34.StrType)le.clean_name_score),TRIM((SALT34.StrType)le.clean_prim_range),TRIM((SALT34.StrType)le.clean_predir),TRIM((SALT34.StrType)le.clean_prim_name),TRIM((SALT34.StrType)le.clean_addr_suffix),TRIM((SALT34.StrType)le.clean_postdir),TRIM((SALT34.StrType)le.clean_unit_desig),TRIM((SALT34.StrType)le.clean_sec_range),TRIM((SALT34.StrType)le.clean_p_city_name),TRIM((SALT34.StrType)le.clean_v_city_name),TRIM((SALT34.StrType)le.clean_st),TRIM((SALT34.StrType)le.clean_zip),TRIM((SALT34.StrType)le.clean_zip4),TRIM((SALT34.StrType)le.clean_cart),TRIM((SALT34.StrType)le.clean_cr_sort_sz),TRIM((SALT34.StrType)le.clean_lot),TRIM((SALT34.StrType)le.clean_lot_order),TRIM((SALT34.StrType)le.clean_dpbc),TRIM((SALT34.StrType)le.clean_chk_digit),TRIM((SALT34.StrType)le.clean_record_type),TRIM((SALT34.StrType)le.clean_ace_fips_st),TRIM((SALT34.StrType)le.clean_fipscounty),TRIM((SALT34.StrType)le.clean_geo_lat),TRIM((SALT34.StrType)le.clean_geo_long),TRIM((SALT34.StrType)le.clean_msa),TRIM((SALT34.StrType)le.clean_geo_blk),TRIM((SALT34.StrType)le.clean_geo_match),TRIM((SALT34.StrType)le.clean_err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),57*57,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'append_process_date'}
      ,{2,'orig_dlstate'}
      ,{3,'orig_dlnumber'}
      ,{4,'orig_name'}
      ,{5,'orig_dob'}
      ,{6,'orig_sex'}
      ,{7,'orig_height1'}
      ,{8,'orig_height2'}
      ,{9,'orig_eye_color'}
      ,{10,'orig_mailaddress'}
      ,{11,'orig_classification'}
      ,{12,'orig_endorsements'}
      ,{13,'orig_issue_date'}
      ,{14,'orig_issue_date_dd'}
      ,{15,'orig_expire_date'}
      ,{16,'orig_expire_date_dd'}
      ,{17,'orig_noncdlstatus'}
      ,{18,'orig_cdlstatus'}
      ,{19,'orig_restrictions'}
      ,{20,'orig_origdate'}
      ,{21,'orig_origcdldate'}
      ,{22,'orig_cancelst'}
      ,{23,'orig_canceldate'}
      ,{24,'orig_crlf'}
      ,{25,'clean_name_prefix'}
      ,{26,'clean_name_first'}
      ,{27,'clean_name_middle'}
      ,{28,'clean_name_last'}
      ,{29,'clean_name_suffix'}
      ,{30,'clean_name_score'}
      ,{31,'clean_prim_range'}
      ,{32,'clean_predir'}
      ,{33,'clean_prim_name'}
      ,{34,'clean_addr_suffix'}
      ,{35,'clean_postdir'}
      ,{36,'clean_unit_desig'}
      ,{37,'clean_sec_range'}
      ,{38,'clean_p_city_name'}
      ,{39,'clean_v_city_name'}
      ,{40,'clean_st'}
      ,{41,'clean_zip'}
      ,{42,'clean_zip4'}
      ,{43,'clean_cart'}
      ,{44,'clean_cr_sort_sz'}
      ,{45,'clean_lot'}
      ,{46,'clean_lot_order'}
      ,{47,'clean_dpbc'}
      ,{48,'clean_chk_digit'}
      ,{49,'clean_record_type'}
      ,{50,'clean_ace_fips_st'}
      ,{51,'clean_fipscounty'}
      ,{52,'clean_geo_lat'}
      ,{53,'clean_geo_long'}
      ,{54,'clean_msa'}
      ,{55,'clean_geo_blk'}
      ,{56,'clean_geo_match'}
      ,{57,'clean_err_stat'}],SALT34.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT34.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT34.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT34.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_append_process_date((SALT34.StrType)le.append_process_date),
    Fields.InValid_orig_dlstate((SALT34.StrType)le.orig_dlstate),
    Fields.InValid_orig_dlnumber((SALT34.StrType)le.orig_dlnumber),
    Fields.InValid_orig_name((SALT34.StrType)le.orig_name),
    Fields.InValid_orig_dob((SALT34.StrType)le.orig_dob),
    Fields.InValid_orig_sex((SALT34.StrType)le.orig_sex),
    Fields.InValid_orig_height1((SALT34.StrType)le.orig_height1,(SALT34.StrType)le.orig_height2),
    Fields.InValid_orig_height2((SALT34.StrType)le.orig_height2),
    Fields.InValid_orig_eye_color((SALT34.StrType)le.orig_eye_color),
    Fields.InValid_orig_mailaddress((SALT34.StrType)le.orig_mailaddress),
    Fields.InValid_orig_classification((SALT34.StrType)le.orig_classification),
    Fields.InValid_orig_endorsements((SALT34.StrType)le.orig_endorsements),
    Fields.InValid_orig_issue_date((SALT34.StrType)le.orig_issue_date,(SALT34.StrType)le.orig_issue_date_dd),
    Fields.InValid_orig_issue_date_dd((SALT34.StrType)le.orig_issue_date_dd),
    Fields.InValid_orig_expire_date((SALT34.StrType)le.orig_expire_date,(SALT34.StrType)le.orig_expire_date_dd),
    Fields.InValid_orig_expire_date_dd((SALT34.StrType)le.orig_expire_date_dd),
    Fields.InValid_orig_noncdlstatus((SALT34.StrType)le.orig_noncdlstatus),
    Fields.InValid_orig_cdlstatus((SALT34.StrType)le.orig_cdlstatus),
    Fields.InValid_orig_restrictions((SALT34.StrType)le.orig_restrictions),
    Fields.InValid_orig_origdate((SALT34.StrType)le.orig_origdate),
    Fields.InValid_orig_origcdldate((SALT34.StrType)le.orig_origcdldate),
    Fields.InValid_orig_cancelst((SALT34.StrType)le.orig_cancelst),
    Fields.InValid_orig_canceldate((SALT34.StrType)le.orig_canceldate),
    Fields.InValid_orig_crlf((SALT34.StrType)le.orig_crlf),
    Fields.InValid_clean_name_prefix((SALT34.StrType)le.clean_name_prefix),
    Fields.InValid_clean_name_first((SALT34.StrType)le.clean_name_first),
    Fields.InValid_clean_name_middle((SALT34.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_last((SALT34.StrType)le.clean_name_last,(SALT34.StrType)le.clean_name_first,(SALT34.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_suffix((SALT34.StrType)le.clean_name_suffix),
    Fields.InValid_clean_name_score((SALT34.StrType)le.clean_name_score),
    Fields.InValid_clean_prim_range((SALT34.StrType)le.clean_prim_range),
    Fields.InValid_clean_predir((SALT34.StrType)le.clean_predir),
    Fields.InValid_clean_prim_name((SALT34.StrType)le.clean_prim_name),
    Fields.InValid_clean_addr_suffix((SALT34.StrType)le.clean_addr_suffix),
    Fields.InValid_clean_postdir((SALT34.StrType)le.clean_postdir),
    Fields.InValid_clean_unit_desig((SALT34.StrType)le.clean_unit_desig),
    Fields.InValid_clean_sec_range((SALT34.StrType)le.clean_sec_range),
    Fields.InValid_clean_p_city_name((SALT34.StrType)le.clean_p_city_name),
    Fields.InValid_clean_v_city_name((SALT34.StrType)le.clean_v_city_name),
    Fields.InValid_clean_st((SALT34.StrType)le.clean_st),
    Fields.InValid_clean_zip((SALT34.StrType)le.clean_zip),
    Fields.InValid_clean_zip4((SALT34.StrType)le.clean_zip4),
    Fields.InValid_clean_cart((SALT34.StrType)le.clean_cart),
    Fields.InValid_clean_cr_sort_sz((SALT34.StrType)le.clean_cr_sort_sz),
    Fields.InValid_clean_lot((SALT34.StrType)le.clean_lot),
    Fields.InValid_clean_lot_order((SALT34.StrType)le.clean_lot_order),
    Fields.InValid_clean_dpbc((SALT34.StrType)le.clean_dpbc),
    Fields.InValid_clean_chk_digit((SALT34.StrType)le.clean_chk_digit),
    Fields.InValid_clean_record_type((SALT34.StrType)le.clean_record_type),
    Fields.InValid_clean_ace_fips_st((SALT34.StrType)le.clean_ace_fips_st),
    Fields.InValid_clean_fipscounty((SALT34.StrType)le.clean_fipscounty),
    Fields.InValid_clean_geo_lat((SALT34.StrType)le.clean_geo_lat),
    Fields.InValid_clean_geo_long((SALT34.StrType)le.clean_geo_long),
    Fields.InValid_clean_msa((SALT34.StrType)le.clean_msa),
    Fields.InValid_clean_geo_blk((SALT34.StrType)le.clean_geo_blk),
    Fields.InValid_clean_geo_match((SALT34.StrType)le.clean_geo_match),
    Fields.InValid_clean_err_stat((SALT34.StrType)le.clean_err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,57,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_orig_dlstate','invalid_orig_dlnumber','invalid_orig_name','invalid_8pastdate','invalid_orig_sex','invalid_orig_height','invalid_inches','invalid_orig_eye_color','invalid_wordbag','invalid_orig_classification','Unknown','invalid_orig_issue_date','invalid_day','invalid_orig_expire_date','invalid_day','invalid_orig_status','invalid_orig_status','invalid_orig_restrictions','invalid_08pastdate','invalid_08pastdate','invalid_state','invalid_08pastdate','Unknown','Unknown','Unknown','Unknown','invalid_clean_name','Unknown','Unknown','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty','invalid_empty');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_append_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dlstate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dlnumber(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_sex(TotalErrors.ErrorNum),Fields.InValidMessage_orig_height1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_height2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_eye_color(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mailaddress(TotalErrors.ErrorNum),Fields.InValidMessage_orig_classification(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements(TotalErrors.ErrorNum),Fields.InValidMessage_orig_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_issue_date_dd(TotalErrors.ErrorNum),Fields.InValidMessage_orig_expire_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_expire_date_dd(TotalErrors.ErrorNum),Fields.InValidMessage_orig_noncdlstatus(TotalErrors.ErrorNum),Fields.InValidMessage_orig_cdlstatus(TotalErrors.ErrorNum),Fields.InValidMessage_orig_restrictions(TotalErrors.ErrorNum),Fields.InValidMessage_orig_origdate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_origcdldate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_cancelst(TotalErrors.ErrorNum),Fields.InValidMessage_orig_canceldate(TotalErrors.ErrorNum),Fields.InValidMessage_orig_crlf(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_predir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_clean_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_clean_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_clean_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_clean_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip(TotalErrors.ErrorNum),Fields.InValidMessage_clean_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cart(TotalErrors.ErrorNum),Fields.InValidMessage_clean_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot(TotalErrors.ErrorNum),Fields.InValidMessage_clean_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_clean_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_clean_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_clean_record_type(TotalErrors.ErrorNum),Fields.InValidMessage_clean_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fipscounty(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_clean_msa(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_clean_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_clean_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
