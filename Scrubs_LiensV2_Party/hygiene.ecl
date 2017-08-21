IMPORT ut,SALT30;
EXPORT hygiene(dataset(layout_Liens_Party) h) := MODULE
//A simple summary record
EXPORT Summary(SALT30.Str30Type txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := MAX(GROUP,h.source_file);    NumberOfRecords := COUNT(GROUP);
    populated_tmsid_pcnt := AVE(GROUP,IF(h.tmsid = (TYPEOF(h.tmsid))'',0,100));
    maxlength_tmsid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.tmsid)));
    avelength_tmsid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.tmsid)),h.tmsid<>(typeof(h.tmsid))'');
    populated_rmsid_pcnt := AVE(GROUP,IF(h.rmsid = (TYPEOF(h.rmsid))'',0,100));
    maxlength_rmsid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rmsid)));
    avelength_rmsid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rmsid)),h.rmsid<>(typeof(h.rmsid))'');
    populated_orig_rmsid_pcnt := AVE(GROUP,IF(h.orig_rmsid = (TYPEOF(h.orig_rmsid))'',0,100));
    maxlength_orig_rmsid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_rmsid)));
    avelength_orig_rmsid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_rmsid)),h.orig_rmsid<>(typeof(h.orig_rmsid))'');
    populated_orig_full_debtorname_pcnt := AVE(GROUP,IF(h.orig_full_debtorname = (TYPEOF(h.orig_full_debtorname))'',0,100));
    maxlength_orig_full_debtorname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_full_debtorname)));
    avelength_orig_full_debtorname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_full_debtorname)),h.orig_full_debtorname<>(typeof(h.orig_full_debtorname))'');
    populated_orig_name_pcnt := AVE(GROUP,IF(h.orig_name = (TYPEOF(h.orig_name))'',0,100));
    maxlength_orig_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_name)));
    avelength_orig_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_name)),h.orig_name<>(typeof(h.orig_name))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_suffix_pcnt := AVE(GROUP,IF(h.orig_suffix = (TYPEOF(h.orig_suffix))'',0,100));
    maxlength_orig_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_suffix)));
    avelength_orig_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_suffix)),h.orig_suffix<>(typeof(h.orig_suffix))'');
    populated_tax_id_pcnt := AVE(GROUP,IF(h.tax_id = (TYPEOF(h.tax_id))'',0,100));
    maxlength_tax_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.tax_id)));
    avelength_tax_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.tax_id)),h.tax_id<>(typeof(h.tax_id))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_orig_address1_pcnt := AVE(GROUP,IF(h.orig_address1 = (TYPEOF(h.orig_address1))'',0,100));
    maxlength_orig_address1 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_address1)));
    avelength_orig_address1 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_address1)),h.orig_address1<>(typeof(h.orig_address1))'');
    populated_orig_address2_pcnt := AVE(GROUP,IF(h.orig_address2 = (TYPEOF(h.orig_address2))'',0,100));
    maxlength_orig_address2 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_address2)));
    avelength_orig_address2 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_address2)),h.orig_address2<>(typeof(h.orig_address2))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip5_pcnt := AVE(GROUP,IF(h.orig_zip5 = (TYPEOF(h.orig_zip5))'',0,100));
    maxlength_orig_zip5 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_zip5)));
    avelength_orig_zip5 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_zip5)),h.orig_zip5<>(typeof(h.orig_zip5))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_orig_county_pcnt := AVE(GROUP,IF(h.orig_county = (TYPEOF(h.orig_county))'',0,100));
    maxlength_orig_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_county)));
    avelength_orig_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_county)),h.orig_county<>(typeof(h.orig_county))'');
    populated_orig_country_pcnt := AVE(GROUP,IF(h.orig_country = (TYPEOF(h.orig_country))'',0,100));
    maxlength_orig_country := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_country)));
    avelength_orig_country := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.orig_country)),h.orig_country<>(typeof(h.orig_country))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_date_vendor_first_reported_pcnt := AVE(GROUP,IF(h.date_vendor_first_reported = (TYPEOF(h.date_vendor_first_reported))'',0,100));
    maxlength_date_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_first_reported)));
    avelength_date_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_first_reported)),h.date_vendor_first_reported<>(typeof(h.date_vendor_first_reported))'');
    populated_date_vendor_last_reported_pcnt := AVE(GROUP,IF(h.date_vendor_last_reported = (TYPEOF(h.date_vendor_last_reported))'',0,100));
    maxlength_date_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_last_reported)));
    avelength_date_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.date_vendor_last_reported)),h.date_vendor_last_reported<>(typeof(h.date_vendor_last_reported))'');
    populated_persistent_record_id_pcnt := AVE(GROUP,IF(h.persistent_record_id = (TYPEOF(h.persistent_record_id))'',0,100));
    maxlength_persistent_record_id := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistent_record_id)));
    avelength_persistent_record_id := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.persistent_record_id)),h.persistent_record_id<>(typeof(h.persistent_record_id))'');
    populated_source_file_pcnt := AVE(GROUP,IF(h.source_file = (TYPEOF(h.source_file))'',0,100));
    maxlength_source_file := MAX(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_file)));
    avelength_source_file := AVE(GROUP,LENGTH(TRIM((SALT30.StrType)h.source_file)),h.source_file<>(typeof(h.source_file))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_file,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_tmsid_pcnt *   0.00 / 100 + T.Populated_rmsid_pcnt *   0.00 / 100 + T.Populated_orig_rmsid_pcnt *   0.00 / 100 + T.Populated_orig_full_debtorname_pcnt *   0.00 / 100 + T.Populated_orig_name_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_suffix_pcnt *   0.00 / 100 + T.Populated_tax_id_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_orig_address1_pcnt *   0.00 / 100 + T.Populated_orig_address2_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip5_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_orig_county_pcnt *   0.00 / 100 + T.Populated_orig_country_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_date_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_date_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_persistent_record_id_pcnt *   0.00 / 100 + T.Populated_source_file_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);  R := RECORD
    STRING source_file1;
    STRING source_file2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_file1 := le.Source;
    SELF.source_file2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_tmsid_pcnt*ri.Populated_tmsid_pcnt *   0.00 / 10000 + le.Populated_rmsid_pcnt*ri.Populated_rmsid_pcnt *   0.00 / 10000 + le.Populated_orig_rmsid_pcnt*ri.Populated_orig_rmsid_pcnt *   0.00 / 10000 + le.Populated_orig_full_debtorname_pcnt*ri.Populated_orig_full_debtorname_pcnt *   0.00 / 10000 + le.Populated_orig_name_pcnt*ri.Populated_orig_name_pcnt *   0.00 / 10000 + le.Populated_orig_lname_pcnt*ri.Populated_orig_lname_pcnt *   0.00 / 10000 + le.Populated_orig_fname_pcnt*ri.Populated_orig_fname_pcnt *   0.00 / 10000 + le.Populated_orig_mname_pcnt*ri.Populated_orig_mname_pcnt *   0.00 / 10000 + le.Populated_orig_suffix_pcnt*ri.Populated_orig_suffix_pcnt *   0.00 / 10000 + le.Populated_tax_id_pcnt*ri.Populated_tax_id_pcnt *   0.00 / 10000 + le.Populated_ssn_pcnt*ri.Populated_ssn_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_cname_pcnt*ri.Populated_cname_pcnt *   0.00 / 10000 + le.Populated_orig_address1_pcnt*ri.Populated_orig_address1_pcnt *   0.00 / 10000 + le.Populated_orig_address2_pcnt*ri.Populated_orig_address2_pcnt *   0.00 / 10000 + le.Populated_orig_city_pcnt*ri.Populated_orig_city_pcnt *   0.00 / 10000 + le.Populated_orig_state_pcnt*ri.Populated_orig_state_pcnt *   0.00 / 10000 + le.Populated_orig_zip5_pcnt*ri.Populated_orig_zip5_pcnt *   0.00 / 10000 + le.Populated_orig_zip4_pcnt*ri.Populated_orig_zip4_pcnt *   0.00 / 10000 + le.Populated_orig_county_pcnt*ri.Populated_orig_county_pcnt *   0.00 / 10000 + le.Populated_orig_country_pcnt*ri.Populated_orig_country_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_phone_pcnt*ri.Populated_phone_pcnt *   0.00 / 10000 + le.Populated_name_type_pcnt*ri.Populated_name_type_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_bdid_pcnt*ri.Populated_bdid_pcnt *   0.00 / 10000 + le.Populated_date_first_seen_pcnt*ri.Populated_date_first_seen_pcnt *   0.00 / 10000 + le.Populated_date_last_seen_pcnt*ri.Populated_date_last_seen_pcnt *   0.00 / 10000 + le.Populated_date_vendor_first_reported_pcnt*ri.Populated_date_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_date_vendor_last_reported_pcnt*ri.Populated_date_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_persistent_record_id_pcnt*ri.Populated_persistent_record_id_pcnt *   0.00 / 10000 + le.Populated_source_file_pcnt*ri.Populated_source_file_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT30.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'tmsid','rmsid','orig_rmsid','orig_full_debtorname','orig_name','orig_lname','orig_fname','orig_mname','orig_suffix','tax_id','ssn','title','fname','mname','lname','name_suffix','name_score','cname','orig_address1','orig_address2','orig_city','orig_state','orig_zip5','orig_zip4','orig_county','orig_country','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','phone','name_type','did','bdid','date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','persistent_record_id','source_file');
  SELF.populated_pcnt := CHOOSE(C,le.populated_tmsid_pcnt,le.populated_rmsid_pcnt,le.populated_orig_rmsid_pcnt,le.populated_orig_full_debtorname_pcnt,le.populated_orig_name_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_suffix_pcnt,le.populated_tax_id_pcnt,le.populated_ssn_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_cname_pcnt,le.populated_orig_address1_pcnt,le.populated_orig_address2_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip5_pcnt,le.populated_orig_zip4_pcnt,le.populated_orig_county_pcnt,le.populated_orig_country_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_phone_pcnt,le.populated_name_type_pcnt,le.populated_did_pcnt,le.populated_bdid_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_date_vendor_first_reported_pcnt,le.populated_date_vendor_last_reported_pcnt,le.populated_persistent_record_id_pcnt,le.populated_source_file_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_tmsid,le.maxlength_rmsid,le.maxlength_orig_rmsid,le.maxlength_orig_full_debtorname,le.maxlength_orig_name,le.maxlength_orig_lname,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_suffix,le.maxlength_tax_id,le.maxlength_ssn,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_cname,le.maxlength_orig_address1,le.maxlength_orig_address2,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip5,le.maxlength_orig_zip4,le.maxlength_orig_county,le.maxlength_orig_country,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_phone,le.maxlength_name_type,le.maxlength_did,le.maxlength_bdid,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_date_vendor_first_reported,le.maxlength_date_vendor_last_reported,le.maxlength_persistent_record_id,le.maxlength_source_file);
  SELF.avelength := CHOOSE(C,le.avelength_tmsid,le.avelength_rmsid,le.avelength_orig_rmsid,le.avelength_orig_full_debtorname,le.avelength_orig_name,le.avelength_orig_lname,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_suffix,le.avelength_tax_id,le.avelength_ssn,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_cname,le.avelength_orig_address1,le.avelength_orig_address2,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip5,le.avelength_orig_zip4,le.avelength_orig_county,le.avelength_orig_country,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_phone,le.avelength_name_type,le.avelength_did,le.avelength_bdid,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_date_vendor_first_reported,le.avelength_date_vendor_last_reported,le.avelength_persistent_record_id,le.avelength_source_file);
END;
EXPORT invSummary := NORMALIZE(summary0, 62, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT30.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source_file;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT30.StrType)le.tmsid),TRIM((SALT30.StrType)le.rmsid),TRIM((SALT30.StrType)le.orig_rmsid),TRIM((SALT30.StrType)le.orig_full_debtorname),TRIM((SALT30.StrType)le.orig_name),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.orig_suffix),TRIM((SALT30.StrType)le.tax_id),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.cname),TRIM((SALT30.StrType)le.orig_address1),TRIM((SALT30.StrType)le.orig_address2),TRIM((SALT30.StrType)le.orig_city),TRIM((SALT30.StrType)le.orig_state),TRIM((SALT30.StrType)le.orig_zip5),TRIM((SALT30.StrType)le.orig_zip4),TRIM((SALT30.StrType)le.orig_county),TRIM((SALT30.StrType)le.orig_country),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.name_type),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.persistent_record_id),TRIM((SALT30.StrType)le.source_file)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,62,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT30.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 62);
  SELF.FldNo2 := 1 + (C % 62);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT30.StrType)le.tmsid),TRIM((SALT30.StrType)le.rmsid),TRIM((SALT30.StrType)le.orig_rmsid),TRIM((SALT30.StrType)le.orig_full_debtorname),TRIM((SALT30.StrType)le.orig_name),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.orig_suffix),TRIM((SALT30.StrType)le.tax_id),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.cname),TRIM((SALT30.StrType)le.orig_address1),TRIM((SALT30.StrType)le.orig_address2),TRIM((SALT30.StrType)le.orig_city),TRIM((SALT30.StrType)le.orig_state),TRIM((SALT30.StrType)le.orig_zip5),TRIM((SALT30.StrType)le.orig_zip4),TRIM((SALT30.StrType)le.orig_county),TRIM((SALT30.StrType)le.orig_country),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.name_type),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.persistent_record_id),TRIM((SALT30.StrType)le.source_file)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT30.StrType)le.tmsid),TRIM((SALT30.StrType)le.rmsid),TRIM((SALT30.StrType)le.orig_rmsid),TRIM((SALT30.StrType)le.orig_full_debtorname),TRIM((SALT30.StrType)le.orig_name),TRIM((SALT30.StrType)le.orig_lname),TRIM((SALT30.StrType)le.orig_fname),TRIM((SALT30.StrType)le.orig_mname),TRIM((SALT30.StrType)le.orig_suffix),TRIM((SALT30.StrType)le.tax_id),TRIM((SALT30.StrType)le.ssn),TRIM((SALT30.StrType)le.title),TRIM((SALT30.StrType)le.fname),TRIM((SALT30.StrType)le.mname),TRIM((SALT30.StrType)le.lname),TRIM((SALT30.StrType)le.name_suffix),TRIM((SALT30.StrType)le.name_score),TRIM((SALT30.StrType)le.cname),TRIM((SALT30.StrType)le.orig_address1),TRIM((SALT30.StrType)le.orig_address2),TRIM((SALT30.StrType)le.orig_city),TRIM((SALT30.StrType)le.orig_state),TRIM((SALT30.StrType)le.orig_zip5),TRIM((SALT30.StrType)le.orig_zip4),TRIM((SALT30.StrType)le.orig_county),TRIM((SALT30.StrType)le.orig_country),TRIM((SALT30.StrType)le.prim_range),TRIM((SALT30.StrType)le.predir),TRIM((SALT30.StrType)le.prim_name),TRIM((SALT30.StrType)le.addr_suffix),TRIM((SALT30.StrType)le.postdir),TRIM((SALT30.StrType)le.unit_desig),TRIM((SALT30.StrType)le.sec_range),TRIM((SALT30.StrType)le.p_city_name),TRIM((SALT30.StrType)le.v_city_name),TRIM((SALT30.StrType)le.st),TRIM((SALT30.StrType)le.zip),TRIM((SALT30.StrType)le.zip4),TRIM((SALT30.StrType)le.cart),TRIM((SALT30.StrType)le.cr_sort_sz),TRIM((SALT30.StrType)le.lot),TRIM((SALT30.StrType)le.lot_order),TRIM((SALT30.StrType)le.dbpc),TRIM((SALT30.StrType)le.chk_digit),TRIM((SALT30.StrType)le.rec_type),TRIM((SALT30.StrType)le.county),TRIM((SALT30.StrType)le.geo_lat),TRIM((SALT30.StrType)le.geo_long),TRIM((SALT30.StrType)le.msa),TRIM((SALT30.StrType)le.geo_blk),TRIM((SALT30.StrType)le.geo_match),TRIM((SALT30.StrType)le.err_stat),TRIM((SALT30.StrType)le.phone),TRIM((SALT30.StrType)le.name_type),TRIM((SALT30.StrType)le.did),TRIM((SALT30.StrType)le.bdid),TRIM((SALT30.StrType)le.date_first_seen),TRIM((SALT30.StrType)le.date_last_seen),TRIM((SALT30.StrType)le.date_vendor_first_reported),TRIM((SALT30.StrType)le.date_vendor_last_reported),TRIM((SALT30.StrType)le.persistent_record_id),TRIM((SALT30.StrType)le.source_file)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),62*62,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'tmsid'}
      ,{2,'rmsid'}
      ,{3,'orig_rmsid'}
      ,{4,'orig_full_debtorname'}
      ,{5,'orig_name'}
      ,{6,'orig_lname'}
      ,{7,'orig_fname'}
      ,{8,'orig_mname'}
      ,{9,'orig_suffix'}
      ,{10,'tax_id'}
      ,{11,'ssn'}
      ,{12,'title'}
      ,{13,'fname'}
      ,{14,'mname'}
      ,{15,'lname'}
      ,{16,'name_suffix'}
      ,{17,'name_score'}
      ,{18,'cname'}
      ,{19,'orig_address1'}
      ,{20,'orig_address2'}
      ,{21,'orig_city'}
      ,{22,'orig_state'}
      ,{23,'orig_zip5'}
      ,{24,'orig_zip4'}
      ,{25,'orig_county'}
      ,{26,'orig_country'}
      ,{27,'prim_range'}
      ,{28,'predir'}
      ,{29,'prim_name'}
      ,{30,'addr_suffix'}
      ,{31,'postdir'}
      ,{32,'unit_desig'}
      ,{33,'sec_range'}
      ,{34,'p_city_name'}
      ,{35,'v_city_name'}
      ,{36,'st'}
      ,{37,'zip'}
      ,{38,'zip4'}
      ,{39,'cart'}
      ,{40,'cr_sort_sz'}
      ,{41,'lot'}
      ,{42,'lot_order'}
      ,{43,'dbpc'}
      ,{44,'chk_digit'}
      ,{45,'rec_type'}
      ,{46,'county'}
      ,{47,'geo_lat'}
      ,{48,'geo_long'}
      ,{49,'msa'}
      ,{50,'geo_blk'}
      ,{51,'geo_match'}
      ,{52,'err_stat'}
      ,{53,'phone'}
      ,{54,'name_type'}
      ,{55,'did'}
      ,{56,'bdid'}
      ,{57,'date_first_seen'}
      ,{58,'date_last_seen'}
      ,{59,'date_vendor_first_reported'}
      ,{60,'date_vendor_last_reported'}
      ,{61,'persistent_record_id'}
      ,{62,'source_file'}],SALT30.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT30.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT30.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT30.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_file) source_file; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_tmsid((SALT30.StrType)le.tmsid),
    Fields.InValid_rmsid((SALT30.StrType)le.rmsid),
    Fields.InValid_orig_rmsid((SALT30.StrType)le.orig_rmsid),
    Fields.InValid_orig_full_debtorname((SALT30.StrType)le.orig_full_debtorname),
    Fields.InValid_orig_name((SALT30.StrType)le.orig_name),
    Fields.InValid_orig_lname((SALT30.StrType)le.orig_lname),
    Fields.InValid_orig_fname((SALT30.StrType)le.orig_fname),
    Fields.InValid_orig_mname((SALT30.StrType)le.orig_mname),
    Fields.InValid_orig_suffix((SALT30.StrType)le.orig_suffix),
    Fields.InValid_tax_id((SALT30.StrType)le.tax_id),
    Fields.InValid_ssn((SALT30.StrType)le.ssn),
    Fields.InValid_title((SALT30.StrType)le.title),
    Fields.InValid_fname((SALT30.StrType)le.fname),
    Fields.InValid_mname((SALT30.StrType)le.mname),
    Fields.InValid_lname((SALT30.StrType)le.lname),
    Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT30.StrType)le.name_score),
    Fields.InValid_cname((SALT30.StrType)le.cname),
    Fields.InValid_orig_address1((SALT30.StrType)le.orig_address1),
    Fields.InValid_orig_address2((SALT30.StrType)le.orig_address2),
    Fields.InValid_orig_city((SALT30.StrType)le.orig_city),
    Fields.InValid_orig_state((SALT30.StrType)le.orig_state),
    Fields.InValid_orig_zip5((SALT30.StrType)le.orig_zip5),
    Fields.InValid_orig_zip4((SALT30.StrType)le.orig_zip4),
    Fields.InValid_orig_county((SALT30.StrType)le.orig_county),
    Fields.InValid_orig_country((SALT30.StrType)le.orig_country),
    Fields.InValid_prim_range((SALT30.StrType)le.prim_range),
    Fields.InValid_predir((SALT30.StrType)le.predir),
    Fields.InValid_prim_name((SALT30.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT30.StrType)le.addr_suffix),
    Fields.InValid_postdir((SALT30.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT30.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name),
    Fields.InValid_st((SALT30.StrType)le.st),
    Fields.InValid_zip((SALT30.StrType)le.zip),
    Fields.InValid_zip4((SALT30.StrType)le.zip4),
    Fields.InValid_cart((SALT30.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT30.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT30.StrType)le.lot),
    Fields.InValid_lot_order((SALT30.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT30.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT30.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT30.StrType)le.rec_type),
    Fields.InValid_county((SALT30.StrType)le.county),
    Fields.InValid_geo_lat((SALT30.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT30.StrType)le.geo_long),
    Fields.InValid_msa((SALT30.StrType)le.msa),
    Fields.InValid_geo_blk((SALT30.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT30.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT30.StrType)le.err_stat),
    Fields.InValid_phone((SALT30.StrType)le.phone),
    Fields.InValid_name_type((SALT30.StrType)le.name_type),
    Fields.InValid_did((SALT30.StrType)le.did),
    Fields.InValid_bdid((SALT30.StrType)le.bdid),
    Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen),
    Fields.InValid_date_last_seen((SALT30.StrType)le.date_last_seen),
    Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported),
    Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported),
    Fields.InValid_persistent_record_id((SALT30.StrType)le.persistent_record_id),
    Fields.InValid_source_file((SALT30.StrType)le.source_file),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_file := le.source_file;
END;
Errors := NORMALIZE(h,62,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_file;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_file,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_file;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','invalid_alpha','invalid_alpha','invalid_name','Unknown','Unknown','invalid_name_suffix','invalid_ssn','invalid_ssn','Unknown','Unknown','Unknown','Unknown','invalid_name_suffix','Unknown','Unknown','invalid_alpha','invalid_alpha','invalid_only_alpha','invalid_only_alpha','invalid_zip','Unknown','invalid_only_alpha','invalid_only_alpha','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_date','invalid_date','invalid_date','invalid_date','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_tmsid(TotalErrors.ErrorNum),Fields.InValidMessage_rmsid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_rmsid(TotalErrors.ErrorNum),Fields.InValidMessage_orig_full_debtorname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_name(TotalErrors.ErrorNum),Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_cname(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address1(TotalErrors.ErrorNum),Fields.InValidMessage_orig_address2(TotalErrors.ErrorNum),Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_orig_county(TotalErrors.ErrorNum),Fields.InValidMessage_orig_country(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_date_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_persistent_record_id(TotalErrors.ErrorNum),Fields.InValidMessage_source_file(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_file=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
END;
