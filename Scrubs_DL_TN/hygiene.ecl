IMPORT ut,SALT35;
EXPORT hygiene(dataset(layout_In_TN) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT35.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_orig_last_name_pcnt := AVE(GROUP,IF(h.orig_last_name = (TYPEOF(h.orig_last_name))'',0,100));
    maxlength_orig_last_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_last_name)));
    avelength_orig_last_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_last_name)),h.orig_last_name<>(typeof(h.orig_last_name))'');
    populated_orig_first_name_pcnt := AVE(GROUP,IF(h.orig_first_name = (TYPEOF(h.orig_first_name))'',0,100));
    maxlength_orig_first_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_first_name)));
    avelength_orig_first_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_first_name)),h.orig_first_name<>(typeof(h.orig_first_name))'');
    populated_orig_middle_name_pcnt := AVE(GROUP,IF(h.orig_middle_name = (TYPEOF(h.orig_middle_name))'',0,100));
    maxlength_orig_middle_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_middle_name)));
    avelength_orig_middle_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_middle_name)),h.orig_middle_name<>(typeof(h.orig_middle_name))'');
    populated_orig_name_suffix_pcnt := AVE(GROUP,IF(h.orig_name_suffix = (TYPEOF(h.orig_name_suffix))'',0,100));
    maxlength_orig_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_name_suffix)));
    avelength_orig_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_name_suffix)),h.orig_name_suffix<>(typeof(h.orig_name_suffix))'');
    populated_orig_street_address1_pcnt := AVE(GROUP,IF(h.orig_street_address1 = (TYPEOF(h.orig_street_address1))'',0,100));
    maxlength_orig_street_address1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_street_address1)));
    avelength_orig_street_address1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_street_address1)),h.orig_street_address1<>(typeof(h.orig_street_address1))'');
    populated_orig_street_address2_pcnt := AVE(GROUP,IF(h.orig_street_address2 = (TYPEOF(h.orig_street_address2))'',0,100));
    maxlength_orig_street_address2 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_street_address2)));
    avelength_orig_street_address2 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_street_address2)),h.orig_street_address2<>(typeof(h.orig_street_address2))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip_code_pcnt := AVE(GROUP,IF(h.orig_zip_code = (TYPEOF(h.orig_zip_code))'',0,100));
    maxlength_orig_zip_code := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_zip_code)));
    avelength_orig_zip_code := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_zip_code)),h.orig_zip_code<>(typeof(h.orig_zip_code))'');
    populated_orig_dl_number_pcnt := AVE(GROUP,IF(h.orig_dl_number = (TYPEOF(h.orig_dl_number))'',0,100));
    maxlength_orig_dl_number := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dl_number)));
    avelength_orig_dl_number := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dl_number)),h.orig_dl_number<>(typeof(h.orig_dl_number))'');
    populated_orig_license_type_pcnt := AVE(GROUP,IF(h.orig_license_type = (TYPEOF(h.orig_license_type))'',0,100));
    maxlength_orig_license_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_license_type)));
    avelength_orig_license_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_license_type)),h.orig_license_type<>(typeof(h.orig_license_type))'');
    populated_orig_sex_pcnt := AVE(GROUP,IF(h.orig_sex = (TYPEOF(h.orig_sex))'',0,100));
    maxlength_orig_sex := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_sex)));
    avelength_orig_sex := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_sex)),h.orig_sex<>(typeof(h.orig_sex))'');
    populated_orig_height_ft_pcnt := AVE(GROUP,IF(h.orig_height_ft = (TYPEOF(h.orig_height_ft))'',0,100));
    maxlength_orig_height_ft := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_height_ft)));
    avelength_orig_height_ft := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_height_ft)),h.orig_height_ft<>(typeof(h.orig_height_ft))'');
    populated_orig_height_in_pcnt := AVE(GROUP,IF(h.orig_height_in = (TYPEOF(h.orig_height_in))'',0,100));
    maxlength_orig_height_in := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_height_in)));
    avelength_orig_height_in := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_height_in)),h.orig_height_in<>(typeof(h.orig_height_in))'');
    populated_orig_weight_pcnt := AVE(GROUP,IF(h.orig_weight = (TYPEOF(h.orig_weight))'',0,100));
    maxlength_orig_weight := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_weight)));
    avelength_orig_weight := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_weight)),h.orig_weight<>(typeof(h.orig_weight))'');
    populated_orig_eye_color_pcnt := AVE(GROUP,IF(h.orig_eye_color = (TYPEOF(h.orig_eye_color))'',0,100));
    maxlength_orig_eye_color := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_eye_color)));
    avelength_orig_eye_color := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_eye_color)),h.orig_eye_color<>(typeof(h.orig_eye_color))'');
    populated_orig_hair_color_pcnt := AVE(GROUP,IF(h.orig_hair_color = (TYPEOF(h.orig_hair_color))'',0,100));
    maxlength_orig_hair_color := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_hair_color)));
    avelength_orig_hair_color := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_hair_color)),h.orig_hair_color<>(typeof(h.orig_hair_color))'');
    populated_orig_restrictions1_pcnt := AVE(GROUP,IF(h.orig_restrictions1 = (TYPEOF(h.orig_restrictions1))'',0,100));
    maxlength_orig_restrictions1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions1)));
    avelength_orig_restrictions1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions1)),h.orig_restrictions1<>(typeof(h.orig_restrictions1))'');
    populated_orig_restrictions2_pcnt := AVE(GROUP,IF(h.orig_restrictions2 = (TYPEOF(h.orig_restrictions2))'',0,100));
    maxlength_orig_restrictions2 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions2)));
    avelength_orig_restrictions2 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions2)),h.orig_restrictions2<>(typeof(h.orig_restrictions2))'');
    populated_orig_restrictions3_pcnt := AVE(GROUP,IF(h.orig_restrictions3 = (TYPEOF(h.orig_restrictions3))'',0,100));
    maxlength_orig_restrictions3 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions3)));
    avelength_orig_restrictions3 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions3)),h.orig_restrictions3<>(typeof(h.orig_restrictions3))'');
    populated_orig_restrictions4_pcnt := AVE(GROUP,IF(h.orig_restrictions4 = (TYPEOF(h.orig_restrictions4))'',0,100));
    maxlength_orig_restrictions4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions4)));
    avelength_orig_restrictions4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions4)),h.orig_restrictions4<>(typeof(h.orig_restrictions4))'');
    populated_orig_restrictions5_pcnt := AVE(GROUP,IF(h.orig_restrictions5 = (TYPEOF(h.orig_restrictions5))'',0,100));
    maxlength_orig_restrictions5 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions5)));
    avelength_orig_restrictions5 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_restrictions5)),h.orig_restrictions5<>(typeof(h.orig_restrictions5))'');
    populated_orig_endorsements1_pcnt := AVE(GROUP,IF(h.orig_endorsements1 = (TYPEOF(h.orig_endorsements1))'',0,100));
    maxlength_orig_endorsements1 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements1)));
    avelength_orig_endorsements1 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements1)),h.orig_endorsements1<>(typeof(h.orig_endorsements1))'');
    populated_orig_endorsements2_pcnt := AVE(GROUP,IF(h.orig_endorsements2 = (TYPEOF(h.orig_endorsements2))'',0,100));
    maxlength_orig_endorsements2 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements2)));
    avelength_orig_endorsements2 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements2)),h.orig_endorsements2<>(typeof(h.orig_endorsements2))'');
    populated_orig_endorsements3_pcnt := AVE(GROUP,IF(h.orig_endorsements3 = (TYPEOF(h.orig_endorsements3))'',0,100));
    maxlength_orig_endorsements3 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements3)));
    avelength_orig_endorsements3 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements3)),h.orig_endorsements3<>(typeof(h.orig_endorsements3))'');
    populated_orig_endorsements4_pcnt := AVE(GROUP,IF(h.orig_endorsements4 = (TYPEOF(h.orig_endorsements4))'',0,100));
    maxlength_orig_endorsements4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements4)));
    avelength_orig_endorsements4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements4)),h.orig_endorsements4<>(typeof(h.orig_endorsements4))'');
    populated_orig_endorsements5_pcnt := AVE(GROUP,IF(h.orig_endorsements5 = (TYPEOF(h.orig_endorsements5))'',0,100));
    maxlength_orig_endorsements5 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements5)));
    avelength_orig_endorsements5 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_endorsements5)),h.orig_endorsements5<>(typeof(h.orig_endorsements5))'');
    populated_orig_dob_pcnt := AVE(GROUP,IF(h.orig_dob = (TYPEOF(h.orig_dob))'',0,100));
    maxlength_orig_dob := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dob)));
    avelength_orig_dob := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_dob)),h.orig_dob<>(typeof(h.orig_dob))'');
    populated_orig_issue_date_pcnt := AVE(GROUP,IF(h.orig_issue_date = (TYPEOF(h.orig_issue_date))'',0,100));
    maxlength_orig_issue_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_issue_date)));
    avelength_orig_issue_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_issue_date)),h.orig_issue_date<>(typeof(h.orig_issue_date))'');
    populated_orig_expire_date_pcnt := AVE(GROUP,IF(h.orig_expire_date = (TYPEOF(h.orig_expire_date))'',0,100));
    maxlength_orig_expire_date := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_expire_date)));
    avelength_orig_expire_date := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_expire_date)),h.orig_expire_date<>(typeof(h.orig_expire_date))'');
    populated_orig_non_cdl_status_pcnt := AVE(GROUP,IF(h.orig_non_cdl_status = (TYPEOF(h.orig_non_cdl_status))'',0,100));
    maxlength_orig_non_cdl_status := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_non_cdl_status)));
    avelength_orig_non_cdl_status := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_non_cdl_status)),h.orig_non_cdl_status<>(typeof(h.orig_non_cdl_status))'');
    populated_orig_cdl_status_pcnt := AVE(GROUP,IF(h.orig_cdl_status = (TYPEOF(h.orig_cdl_status))'',0,100));
    maxlength_orig_cdl_status := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_cdl_status)));
    avelength_orig_cdl_status := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_cdl_status)),h.orig_cdl_status<>(typeof(h.orig_cdl_status))'');
    populated_orig_race_pcnt := AVE(GROUP,IF(h.orig_race = (TYPEOF(h.orig_race))'',0,100));
    maxlength_orig_race := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_race)));
    avelength_orig_race := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_race)),h.orig_race<>(typeof(h.orig_race))'');
    populated_orig_crlf_pcnt := AVE(GROUP,IF(h.orig_crlf = (TYPEOF(h.orig_crlf))'',0,100));
    maxlength_orig_crlf := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_crlf)));
    avelength_orig_crlf := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.orig_crlf)),h.orig_crlf<>(typeof(h.orig_crlf))'');
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
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_cln_zip5_pcnt := AVE(GROUP,IF(h.cln_zip5 = (TYPEOF(h.cln_zip5))'',0,100));
    maxlength_cln_zip5 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cln_zip5)));
    avelength_cln_zip5 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cln_zip5)),h.cln_zip5<>(typeof(h.cln_zip5))'');
    populated_cln_zip4_pcnt := AVE(GROUP,IF(h.cln_zip4 = (TYPEOF(h.cln_zip4))'',0,100));
    maxlength_cln_zip4 := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cln_zip4)));
    avelength_cln_zip4 := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cln_zip4)),h.cln_zip4<>(typeof(h.cln_zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT35.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT35.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_orig_last_name_pcnt *   0.00 / 100 + T.Populated_orig_first_name_pcnt *   0.00 / 100 + T.Populated_orig_middle_name_pcnt *   0.00 / 100 + T.Populated_orig_name_suffix_pcnt *   0.00 / 100 + T.Populated_orig_street_address1_pcnt *   0.00 / 100 + T.Populated_orig_street_address2_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip_code_pcnt *   0.00 / 100 + T.Populated_orig_dl_number_pcnt *   0.00 / 100 + T.Populated_orig_license_type_pcnt *   0.00 / 100 + T.Populated_orig_sex_pcnt *   0.00 / 100 + T.Populated_orig_height_ft_pcnt *   0.00 / 100 + T.Populated_orig_height_in_pcnt *   0.00 / 100 + T.Populated_orig_weight_pcnt *   0.00 / 100 + T.Populated_orig_eye_color_pcnt *   0.00 / 100 + T.Populated_orig_hair_color_pcnt *   0.00 / 100 + T.Populated_orig_restrictions1_pcnt *   0.00 / 100 + T.Populated_orig_restrictions2_pcnt *   0.00 / 100 + T.Populated_orig_restrictions3_pcnt *   0.00 / 100 + T.Populated_orig_restrictions4_pcnt *   0.00 / 100 + T.Populated_orig_restrictions5_pcnt *   0.00 / 100 + T.Populated_orig_endorsements1_pcnt *   0.00 / 100 + T.Populated_orig_endorsements2_pcnt *   0.00 / 100 + T.Populated_orig_endorsements3_pcnt *   0.00 / 100 + T.Populated_orig_endorsements4_pcnt *   0.00 / 100 + T.Populated_orig_endorsements5_pcnt *   0.00 / 100 + T.Populated_orig_dob_pcnt *   0.00 / 100 + T.Populated_orig_issue_date_pcnt *   0.00 / 100 + T.Populated_orig_expire_date_pcnt *   0.00 / 100 + T.Populated_orig_non_cdl_status_pcnt *   0.00 / 100 + T.Populated_orig_cdl_status_pcnt *   0.00 / 100 + T.Populated_orig_race_pcnt *   0.00 / 100 + T.Populated_orig_crlf_pcnt *   0.00 / 100 + T.Populated_clean_name_prefix_pcnt *   0.00 / 100 + T.Populated_clean_name_first_pcnt *   0.00 / 100 + T.Populated_clean_name_middle_pcnt *   0.00 / 100 + T.Populated_clean_name_last_pcnt *   0.00 / 100 + T.Populated_clean_name_suffix_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_cln_zip5_pcnt *   0.00 / 100 + T.Populated_cln_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'process_date','orig_last_name','orig_first_name','orig_middle_name','orig_name_suffix','orig_street_address1','orig_street_address2','orig_city','orig_state','orig_zip_code','orig_dl_number','orig_license_type','orig_sex','orig_height_ft','orig_height_in','orig_weight','orig_eye_color','orig_hair_color','orig_restrictions1','orig_restrictions2','orig_restrictions3','orig_restrictions4','orig_restrictions5','orig_endorsements1','orig_endorsements2','orig_endorsements3','orig_endorsements4','orig_endorsements5','orig_dob','orig_issue_date','orig_expire_date','orig_non_cdl_status','orig_cdl_status','orig_race','orig_crlf','clean_name_prefix','clean_name_first','clean_name_middle','clean_name_last','clean_name_suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','cln_zip5','cln_zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_process_date_pcnt,le.populated_orig_last_name_pcnt,le.populated_orig_first_name_pcnt,le.populated_orig_middle_name_pcnt,le.populated_orig_name_suffix_pcnt,le.populated_orig_street_address1_pcnt,le.populated_orig_street_address2_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip_code_pcnt,le.populated_orig_dl_number_pcnt,le.populated_orig_license_type_pcnt,le.populated_orig_sex_pcnt,le.populated_orig_height_ft_pcnt,le.populated_orig_height_in_pcnt,le.populated_orig_weight_pcnt,le.populated_orig_eye_color_pcnt,le.populated_orig_hair_color_pcnt,le.populated_orig_restrictions1_pcnt,le.populated_orig_restrictions2_pcnt,le.populated_orig_restrictions3_pcnt,le.populated_orig_restrictions4_pcnt,le.populated_orig_restrictions5_pcnt,le.populated_orig_endorsements1_pcnt,le.populated_orig_endorsements2_pcnt,le.populated_orig_endorsements3_pcnt,le.populated_orig_endorsements4_pcnt,le.populated_orig_endorsements5_pcnt,le.populated_orig_dob_pcnt,le.populated_orig_issue_date_pcnt,le.populated_orig_expire_date_pcnt,le.populated_orig_non_cdl_status_pcnt,le.populated_orig_cdl_status_pcnt,le.populated_orig_race_pcnt,le.populated_orig_crlf_pcnt,le.populated_clean_name_prefix_pcnt,le.populated_clean_name_first_pcnt,le.populated_clean_name_middle_pcnt,le.populated_clean_name_last_pcnt,le.populated_clean_name_suffix_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_cln_zip5_pcnt,le.populated_cln_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_process_date,le.maxlength_orig_last_name,le.maxlength_orig_first_name,le.maxlength_orig_middle_name,le.maxlength_orig_name_suffix,le.maxlength_orig_street_address1,le.maxlength_orig_street_address2,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip_code,le.maxlength_orig_dl_number,le.maxlength_orig_license_type,le.maxlength_orig_sex,le.maxlength_orig_height_ft,le.maxlength_orig_height_in,le.maxlength_orig_weight,le.maxlength_orig_eye_color,le.maxlength_orig_hair_color,le.maxlength_orig_restrictions1,le.maxlength_orig_restrictions2,le.maxlength_orig_restrictions3,le.maxlength_orig_restrictions4,le.maxlength_orig_restrictions5,le.maxlength_orig_endorsements1,le.maxlength_orig_endorsements2,le.maxlength_orig_endorsements3,le.maxlength_orig_endorsements4,le.maxlength_orig_endorsements5,le.maxlength_orig_dob,le.maxlength_orig_issue_date,le.maxlength_orig_expire_date,le.maxlength_orig_non_cdl_status,le.maxlength_orig_cdl_status,le.maxlength_orig_race,le.maxlength_orig_crlf,le.maxlength_clean_name_prefix,le.maxlength_clean_name_first,le.maxlength_clean_name_middle,le.maxlength_clean_name_last,le.maxlength_clean_name_suffix,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_cln_zip5,le.maxlength_cln_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_process_date,le.avelength_orig_last_name,le.avelength_orig_first_name,le.avelength_orig_middle_name,le.avelength_orig_name_suffix,le.avelength_orig_street_address1,le.avelength_orig_street_address2,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip_code,le.avelength_orig_dl_number,le.avelength_orig_license_type,le.avelength_orig_sex,le.avelength_orig_height_ft,le.avelength_orig_height_in,le.avelength_orig_weight,le.avelength_orig_eye_color,le.avelength_orig_hair_color,le.avelength_orig_restrictions1,le.avelength_orig_restrictions2,le.avelength_orig_restrictions3,le.avelength_orig_restrictions4,le.avelength_orig_restrictions5,le.avelength_orig_endorsements1,le.avelength_orig_endorsements2,le.avelength_orig_endorsements3,le.avelength_orig_endorsements4,le.avelength_orig_endorsements5,le.avelength_orig_dob,le.avelength_orig_issue_date,le.avelength_orig_expire_date,le.avelength_orig_non_cdl_status,le.avelength_orig_cdl_status,le.avelength_orig_race,le.avelength_orig_crlf,le.avelength_clean_name_prefix,le.avelength_clean_name_first,le.avelength_clean_name_middle,le.avelength_clean_name_last,le.avelength_clean_name_suffix,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_cln_zip5,le.avelength_cln_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 67, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT35.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.orig_last_name),TRIM((SALT35.StrType)le.orig_first_name),TRIM((SALT35.StrType)le.orig_middle_name),TRIM((SALT35.StrType)le.orig_name_suffix),TRIM((SALT35.StrType)le.orig_street_address1),TRIM((SALT35.StrType)le.orig_street_address2),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip_code),TRIM((SALT35.StrType)le.orig_dl_number),TRIM((SALT35.StrType)le.orig_license_type),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_height_ft),TRIM((SALT35.StrType)le.orig_height_in),TRIM((SALT35.StrType)le.orig_weight),TRIM((SALT35.StrType)le.orig_eye_color),TRIM((SALT35.StrType)le.orig_hair_color),TRIM((SALT35.StrType)le.orig_restrictions1),TRIM((SALT35.StrType)le.orig_restrictions2),TRIM((SALT35.StrType)le.orig_restrictions3),TRIM((SALT35.StrType)le.orig_restrictions4),TRIM((SALT35.StrType)le.orig_restrictions5),TRIM((SALT35.StrType)le.orig_endorsements1),TRIM((SALT35.StrType)le.orig_endorsements2),TRIM((SALT35.StrType)le.orig_endorsements3),TRIM((SALT35.StrType)le.orig_endorsements4),TRIM((SALT35.StrType)le.orig_endorsements5),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_issue_date),TRIM((SALT35.StrType)le.orig_expire_date),TRIM((SALT35.StrType)le.orig_non_cdl_status),TRIM((SALT35.StrType)le.orig_cdl_status),TRIM((SALT35.StrType)le.orig_race),TRIM((SALT35.StrType)le.orig_crlf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.cln_zip5),TRIM((SALT35.StrType)le.cln_zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,67,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT35.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 67);
  SELF.FldNo2 := 1 + (C % 67);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.orig_last_name),TRIM((SALT35.StrType)le.orig_first_name),TRIM((SALT35.StrType)le.orig_middle_name),TRIM((SALT35.StrType)le.orig_name_suffix),TRIM((SALT35.StrType)le.orig_street_address1),TRIM((SALT35.StrType)le.orig_street_address2),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip_code),TRIM((SALT35.StrType)le.orig_dl_number),TRIM((SALT35.StrType)le.orig_license_type),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_height_ft),TRIM((SALT35.StrType)le.orig_height_in),TRIM((SALT35.StrType)le.orig_weight),TRIM((SALT35.StrType)le.orig_eye_color),TRIM((SALT35.StrType)le.orig_hair_color),TRIM((SALT35.StrType)le.orig_restrictions1),TRIM((SALT35.StrType)le.orig_restrictions2),TRIM((SALT35.StrType)le.orig_restrictions3),TRIM((SALT35.StrType)le.orig_restrictions4),TRIM((SALT35.StrType)le.orig_restrictions5),TRIM((SALT35.StrType)le.orig_endorsements1),TRIM((SALT35.StrType)le.orig_endorsements2),TRIM((SALT35.StrType)le.orig_endorsements3),TRIM((SALT35.StrType)le.orig_endorsements4),TRIM((SALT35.StrType)le.orig_endorsements5),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_issue_date),TRIM((SALT35.StrType)le.orig_expire_date),TRIM((SALT35.StrType)le.orig_non_cdl_status),TRIM((SALT35.StrType)le.orig_cdl_status),TRIM((SALT35.StrType)le.orig_race),TRIM((SALT35.StrType)le.orig_crlf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.cln_zip5),TRIM((SALT35.StrType)le.cln_zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT35.StrType)le.process_date),TRIM((SALT35.StrType)le.orig_last_name),TRIM((SALT35.StrType)le.orig_first_name),TRIM((SALT35.StrType)le.orig_middle_name),TRIM((SALT35.StrType)le.orig_name_suffix),TRIM((SALT35.StrType)le.orig_street_address1),TRIM((SALT35.StrType)le.orig_street_address2),TRIM((SALT35.StrType)le.orig_city),TRIM((SALT35.StrType)le.orig_state),TRIM((SALT35.StrType)le.orig_zip_code),TRIM((SALT35.StrType)le.orig_dl_number),TRIM((SALT35.StrType)le.orig_license_type),TRIM((SALT35.StrType)le.orig_sex),TRIM((SALT35.StrType)le.orig_height_ft),TRIM((SALT35.StrType)le.orig_height_in),TRIM((SALT35.StrType)le.orig_weight),TRIM((SALT35.StrType)le.orig_eye_color),TRIM((SALT35.StrType)le.orig_hair_color),TRIM((SALT35.StrType)le.orig_restrictions1),TRIM((SALT35.StrType)le.orig_restrictions2),TRIM((SALT35.StrType)le.orig_restrictions3),TRIM((SALT35.StrType)le.orig_restrictions4),TRIM((SALT35.StrType)le.orig_restrictions5),TRIM((SALT35.StrType)le.orig_endorsements1),TRIM((SALT35.StrType)le.orig_endorsements2),TRIM((SALT35.StrType)le.orig_endorsements3),TRIM((SALT35.StrType)le.orig_endorsements4),TRIM((SALT35.StrType)le.orig_endorsements5),TRIM((SALT35.StrType)le.orig_dob),TRIM((SALT35.StrType)le.orig_issue_date),TRIM((SALT35.StrType)le.orig_expire_date),TRIM((SALT35.StrType)le.orig_non_cdl_status),TRIM((SALT35.StrType)le.orig_cdl_status),TRIM((SALT35.StrType)le.orig_race),TRIM((SALT35.StrType)le.orig_crlf),TRIM((SALT35.StrType)le.clean_name_prefix),TRIM((SALT35.StrType)le.clean_name_first),TRIM((SALT35.StrType)le.clean_name_middle),TRIM((SALT35.StrType)le.clean_name_last),TRIM((SALT35.StrType)le.clean_name_suffix),TRIM((SALT35.StrType)le.prim_range),TRIM((SALT35.StrType)le.predir),TRIM((SALT35.StrType)le.prim_name),TRIM((SALT35.StrType)le.addr_suffix),TRIM((SALT35.StrType)le.postdir),TRIM((SALT35.StrType)le.unit_desig),TRIM((SALT35.StrType)le.sec_range),TRIM((SALT35.StrType)le.p_city_name),TRIM((SALT35.StrType)le.v_city_name),TRIM((SALT35.StrType)le.st),TRIM((SALT35.StrType)le.cln_zip5),TRIM((SALT35.StrType)le.cln_zip4),TRIM((SALT35.StrType)le.cart),TRIM((SALT35.StrType)le.cr_sort_sz),TRIM((SALT35.StrType)le.lot),TRIM((SALT35.StrType)le.lot_order),TRIM((SALT35.StrType)le.dpbc),TRIM((SALT35.StrType)le.chk_digit),TRIM((SALT35.StrType)le.rec_type),TRIM((SALT35.StrType)le.ace_fips_st),TRIM((SALT35.StrType)le.county),TRIM((SALT35.StrType)le.geo_lat),TRIM((SALT35.StrType)le.geo_long),TRIM((SALT35.StrType)le.msa),TRIM((SALT35.StrType)le.geo_blk),TRIM((SALT35.StrType)le.geo_match),TRIM((SALT35.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),67*67,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'process_date'}
      ,{2,'orig_last_name'}
      ,{3,'orig_first_name'}
      ,{4,'orig_middle_name'}
      ,{5,'orig_name_suffix'}
      ,{6,'orig_street_address1'}
      ,{7,'orig_street_address2'}
      ,{8,'orig_city'}
      ,{9,'orig_state'}
      ,{10,'orig_zip_code'}
      ,{11,'orig_dl_number'}
      ,{12,'orig_license_type'}
      ,{13,'orig_sex'}
      ,{14,'orig_height_ft'}
      ,{15,'orig_height_in'}
      ,{16,'orig_weight'}
      ,{17,'orig_eye_color'}
      ,{18,'orig_hair_color'}
      ,{19,'orig_restrictions1'}
      ,{20,'orig_restrictions2'}
      ,{21,'orig_restrictions3'}
      ,{22,'orig_restrictions4'}
      ,{23,'orig_restrictions5'}
      ,{24,'orig_endorsements1'}
      ,{25,'orig_endorsements2'}
      ,{26,'orig_endorsements3'}
      ,{27,'orig_endorsements4'}
      ,{28,'orig_endorsements5'}
      ,{29,'orig_dob'}
      ,{30,'orig_issue_date'}
      ,{31,'orig_expire_date'}
      ,{32,'orig_non_cdl_status'}
      ,{33,'orig_cdl_status'}
      ,{34,'orig_race'}
      ,{35,'orig_crlf'}
      ,{36,'clean_name_prefix'}
      ,{37,'clean_name_first'}
      ,{38,'clean_name_middle'}
      ,{39,'clean_name_last'}
      ,{40,'clean_name_suffix'}
      ,{41,'prim_range'}
      ,{42,'predir'}
      ,{43,'prim_name'}
      ,{44,'addr_suffix'}
      ,{45,'postdir'}
      ,{46,'unit_desig'}
      ,{47,'sec_range'}
      ,{48,'p_city_name'}
      ,{49,'v_city_name'}
      ,{50,'st'}
      ,{51,'cln_zip5'}
      ,{52,'cln_zip4'}
      ,{53,'cart'}
      ,{54,'cr_sort_sz'}
      ,{55,'lot'}
      ,{56,'lot_order'}
      ,{57,'dpbc'}
      ,{58,'chk_digit'}
      ,{59,'rec_type'}
      ,{60,'ace_fips_st'}
      ,{61,'county'}
      ,{62,'geo_lat'}
      ,{63,'geo_long'}
      ,{64,'msa'}
      ,{65,'geo_blk'}
      ,{66,'geo_match'}
      ,{67,'err_stat'}],SALT35.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT35.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT35.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT35.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_process_date((SALT35.StrType)le.process_date),
    Fields.InValid_orig_last_name((SALT35.StrType)le.orig_last_name,(SALT35.StrType)le.orig_first_name,(SALT35.StrType)le.orig_middle_name),
    Fields.InValid_orig_first_name((SALT35.StrType)le.orig_first_name),
    Fields.InValid_orig_middle_name((SALT35.StrType)le.orig_middle_name),
    Fields.InValid_orig_name_suffix((SALT35.StrType)le.orig_name_suffix),
    Fields.InValid_orig_street_address1((SALT35.StrType)le.orig_street_address1),
    Fields.InValid_orig_street_address2((SALT35.StrType)le.orig_street_address2),
    Fields.InValid_orig_city((SALT35.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT35.StrType)le.orig_state),
    Fields.InValid_orig_zip_code((SALT35.StrType)le.orig_zip_code),
    Fields.InValid_orig_dl_number((SALT35.StrType)le.orig_dl_number),
    Fields.InValid_orig_license_type((SALT35.StrType)le.orig_license_type),
    Fields.InValid_orig_sex((SALT35.StrType)le.orig_sex),
    Fields.InValid_orig_height_ft((SALT35.StrType)le.orig_height_ft,(SALT35.StrType)le.orig_height_in),
    Fields.InValid_orig_height_in((SALT35.StrType)le.orig_height_in),
    Fields.InValid_orig_weight((SALT35.StrType)le.orig_weight),
    Fields.InValid_orig_eye_color((SALT35.StrType)le.orig_eye_color),
    Fields.InValid_orig_hair_color((SALT35.StrType)le.orig_hair_color),
    Fields.InValid_orig_restrictions1((SALT35.StrType)le.orig_restrictions1),
    Fields.InValid_orig_restrictions2((SALT35.StrType)le.orig_restrictions2),
    Fields.InValid_orig_restrictions3((SALT35.StrType)le.orig_restrictions3),
    Fields.InValid_orig_restrictions4((SALT35.StrType)le.orig_restrictions4),
    Fields.InValid_orig_restrictions5((SALT35.StrType)le.orig_restrictions5),
    Fields.InValid_orig_endorsements1((SALT35.StrType)le.orig_endorsements1),
    Fields.InValid_orig_endorsements2((SALT35.StrType)le.orig_endorsements2),
    Fields.InValid_orig_endorsements3((SALT35.StrType)le.orig_endorsements3),
    Fields.InValid_orig_endorsements4((SALT35.StrType)le.orig_endorsements4),
    Fields.InValid_orig_endorsements5((SALT35.StrType)le.orig_endorsements5),
    Fields.InValid_orig_dob((SALT35.StrType)le.orig_dob),
    Fields.InValid_orig_issue_date((SALT35.StrType)le.orig_issue_date),
    Fields.InValid_orig_expire_date((SALT35.StrType)le.orig_expire_date),
    Fields.InValid_orig_non_cdl_status((SALT35.StrType)le.orig_non_cdl_status),
    Fields.InValid_orig_cdl_status((SALT35.StrType)le.orig_cdl_status),
    Fields.InValid_orig_race((SALT35.StrType)le.orig_race),
    Fields.InValid_orig_crlf((SALT35.StrType)le.orig_crlf),
    Fields.InValid_clean_name_prefix((SALT35.StrType)le.clean_name_prefix),
    Fields.InValid_clean_name_first((SALT35.StrType)le.clean_name_first),
    Fields.InValid_clean_name_middle((SALT35.StrType)le.clean_name_middle),
    Fields.InValid_clean_name_last((SALT35.StrType)le.clean_name_last),
    Fields.InValid_clean_name_suffix((SALT35.StrType)le.clean_name_suffix),
    Fields.InValid_prim_range((SALT35.StrType)le.prim_range),
    Fields.InValid_predir((SALT35.StrType)le.predir),
    Fields.InValid_prim_name((SALT35.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT35.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT35.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT35.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT35.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT35.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name),
    Fields.InValid_st((SALT35.StrType)le.st),
    Fields.InValid_cln_zip5((SALT35.StrType)le.cln_zip5),
    Fields.InValid_cln_zip4((SALT35.StrType)le.cln_zip4),
    Fields.InValid_cart((SALT35.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT35.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT35.StrType)le.lot),
    Fields.InValid_lot_order((SALT35.StrType)le.lot_order),
    Fields.InValid_dpbc((SALT35.StrType)le.dpbc),
    Fields.InValid_chk_digit((SALT35.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT35.StrType)le.rec_type),
    Fields.InValid_ace_fips_st((SALT35.StrType)le.ace_fips_st),
    Fields.InValid_county((SALT35.StrType)le.county),
    Fields.InValid_geo_lat((SALT35.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT35.StrType)le.geo_long),
    Fields.InValid_msa((SALT35.StrType)le.msa),
    Fields.InValid_geo_blk((SALT35.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT35.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT35.StrType)le.err_stat),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,67,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_8pastdate','invalid_orig_name','Unknown','Unknown','Unknown','invalid_mandatory','Unknown','invalid_alpha_num_specials','invalid_orig_state','invalid_orig_zip_code','invalid_orig_dl_number','invalid_orig_license_type','invalid_orig_sex','invalid_orig_height_ft','invalid_numeric_blank','invalid_orig_weight','invalid_orig_eye_color','invalid_orig_hair_color','invalid_orig_restrictions','invalid_orig_restrictions','invalid_orig_restrictions','invalid_orig_restrictions','invalid_orig_restrictions','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_8pastdate','invalid_8pastdate','invalid_8generaldate','invalid_alpha_num','invalid_alpha_num','invalid_orig_race','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_last_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_first_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_middle_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_orig_street_address1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_street_address2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip_code(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dl_number(TotalErrors.ErrorNum),Fields.InValidMessage_orig_license_type(TotalErrors.ErrorNum),Fields.InValidMessage_orig_sex(TotalErrors.ErrorNum),Fields.InValidMessage_orig_height_ft(TotalErrors.ErrorNum),Fields.InValidMessage_orig_height_in(TotalErrors.ErrorNum),Fields.InValidMessage_orig_weight(TotalErrors.ErrorNum),Fields.InValidMessage_orig_eye_color(TotalErrors.ErrorNum),Fields.InValidMessage_orig_hair_color(TotalErrors.ErrorNum),Fields.InValidMessage_orig_restrictions1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_restrictions2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_restrictions3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_restrictions4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_restrictions5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements3(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_endorsements5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_dob(TotalErrors.ErrorNum),Fields.InValidMessage_orig_issue_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_expire_date(TotalErrors.ErrorNum),Fields.InValidMessage_orig_non_cdl_status(TotalErrors.ErrorNum),Fields.InValidMessage_orig_cdl_status(TotalErrors.ErrorNum),Fields.InValidMessage_orig_race(TotalErrors.ErrorNum),Fields.InValidMessage_orig_crlf(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_prefix(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_first(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_middle(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_last(TotalErrors.ErrorNum),Fields.InValidMessage_clean_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_cln_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_cln_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
