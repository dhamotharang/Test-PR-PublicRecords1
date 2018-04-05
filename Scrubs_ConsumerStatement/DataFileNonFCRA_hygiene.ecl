IMPORT SALT38,STD;
EXPORT DataFileNonFCRA_hygiene(dataset(DataFileNonFCRA_layout_ConsumerStatement) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_statement_id_cnt := COUNT(GROUP,h.statement_id <> (TYPEOF(h.statement_id))'');
    populated_statement_id_pcnt := AVE(GROUP,IF(h.statement_id = (TYPEOF(h.statement_id))'',0,100));
    maxlength_statement_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.statement_id)));
    avelength_statement_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.statement_id)),h.statement_id<>(typeof(h.statement_id))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_mname_cnt := COUNT(GROUP,h.orig_mname <> (TYPEOF(h.orig_mname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_cname_cnt := COUNT(GROUP,h.orig_cname <> (TYPEOF(h.orig_cname))'');
    populated_orig_cname_pcnt := AVE(GROUP,IF(h.orig_cname = (TYPEOF(h.orig_cname))'',0,100));
    maxlength_orig_cname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_cname)));
    avelength_orig_cname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_cname)),h.orig_cname<>(typeof(h.orig_cname))'');
    populated_orig_address_cnt := COUNT(GROUP,h.orig_address <> (TYPEOF(h.orig_address))'');
    populated_orig_address_pcnt := AVE(GROUP,IF(h.orig_address = (TYPEOF(h.orig_address))'',0,100));
    maxlength_orig_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_address)));
    avelength_orig_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_address)),h.orig_address<>(typeof(h.orig_address))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_st_cnt := COUNT(GROUP,h.orig_st <> (TYPEOF(h.orig_st))'');
    populated_orig_st_pcnt := AVE(GROUP,IF(h.orig_st = (TYPEOF(h.orig_st))'',0,100));
    maxlength_orig_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_st)));
    avelength_orig_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_st)),h.orig_st<>(typeof(h.orig_st))'');
    populated_orig_zip_cnt := COUNT(GROUP,h.orig_zip <> (TYPEOF(h.orig_zip))'');
    populated_orig_zip_pcnt := AVE(GROUP,IF(h.orig_zip = (TYPEOF(h.orig_zip))'',0,100));
    maxlength_orig_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip)));
    avelength_orig_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip)),h.orig_zip<>(typeof(h.orig_zip))'');
    populated_orig_zip4_cnt := COUNT(GROUP,h.orig_zip4 <> (TYPEOF(h.orig_zip4))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_date_submitted_cnt := COUNT(GROUP,h.date_submitted <> (TYPEOF(h.date_submitted))'');
    populated_date_submitted_pcnt := AVE(GROUP,IF(h.date_submitted = (TYPEOF(h.date_submitted))'',0,100));
    maxlength_date_submitted := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_submitted)));
    avelength_date_submitted := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_submitted)),h.date_submitted<>(typeof(h.date_submitted))'');
    populated_date_created_cnt := COUNT(GROUP,h.date_created <> (TYPEOF(h.date_created))'');
    populated_date_created_pcnt := AVE(GROUP,IF(h.date_created = (TYPEOF(h.date_created))'',0,100));
    maxlength_date_created := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_created)));
    avelength_date_created := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_created)),h.date_created<>(typeof(h.date_created))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_consumer_text_cnt := COUNT(GROUP,h.consumer_text <> (TYPEOF(h.consumer_text))'');
    populated_consumer_text_pcnt := AVE(GROUP,IF(h.consumer_text = (TYPEOF(h.consumer_text))'',0,100));
    maxlength_consumer_text := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.consumer_text)));
    avelength_consumer_text := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.consumer_text)),h.consumer_text<>(typeof(h.consumer_text))'');
    populated_override_flag_cnt := COUNT(GROUP,h.override_flag <> (TYPEOF(h.override_flag))'');
    populated_override_flag_pcnt := AVE(GROUP,IF(h.override_flag = (TYPEOF(h.override_flag))'',0,100));
    maxlength_override_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.override_flag)));
    avelength_override_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.override_flag)),h.override_flag<>(typeof(h.override_flag))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_statement_id_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_cname_pcnt *   0.00 / 100 + T.Populated_orig_address_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_st_pcnt *   0.00 / 100 + T.Populated_orig_zip_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_date_submitted_pcnt *   0.00 / 100 + T.Populated_date_created_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_consumer_text_pcnt *   0.00 / 100 + T.Populated_override_flag_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'statement_id','orig_fname','orig_lname','orig_mname','orig_cname','orig_address','orig_city','orig_st','orig_zip','orig_zip4','phone','title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','date_submitted','date_created','did','consumer_text','override_flag');
  SELF.populated_pcnt := CHOOSE(C,le.populated_statement_id_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_cname_pcnt,le.populated_orig_address_pcnt,le.populated_orig_city_pcnt,le.populated_orig_st_pcnt,le.populated_orig_zip_pcnt,le.populated_orig_zip4_pcnt,le.populated_phone_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_date_submitted_pcnt,le.populated_date_created_pcnt,le.populated_did_pcnt,le.populated_consumer_text_pcnt,le.populated_override_flag_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_statement_id,le.maxlength_orig_fname,le.maxlength_orig_lname,le.maxlength_orig_mname,le.maxlength_orig_cname,le.maxlength_orig_address,le.maxlength_orig_city,le.maxlength_orig_st,le.maxlength_orig_zip,le.maxlength_orig_zip4,le.maxlength_phone,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_date_submitted,le.maxlength_date_created,le.maxlength_did,le.maxlength_consumer_text,le.maxlength_override_flag);
  SELF.avelength := CHOOSE(C,le.avelength_statement_id,le.avelength_orig_fname,le.avelength_orig_lname,le.avelength_orig_mname,le.avelength_orig_cname,le.avelength_orig_address,le.avelength_orig_city,le.avelength_orig_st,le.avelength_orig_zip,le.avelength_orig_zip4,le.avelength_phone,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_date_submitted,le.avelength_date_created,le.avelength_did,le.avelength_consumer_text,le.avelength_override_flag);
END;
EXPORT invSummary := NORMALIZE(summary0, 48, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.statement_id <> 0,TRIM((SALT38.StrType)le.statement_id), ''),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_mname),TRIM((SALT38.StrType)le.orig_cname),TRIM((SALT38.StrType)le.orig_address),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_st),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_zip4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.date_submitted),TRIM((SALT38.StrType)le.date_created),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),TRIM((SALT38.StrType)le.consumer_text),IF (le.override_flag <> 0,TRIM((SALT38.StrType)le.override_flag), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,48,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 48);
  SELF.FldNo2 := 1 + (C % 48);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.statement_id <> 0,TRIM((SALT38.StrType)le.statement_id), ''),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_mname),TRIM((SALT38.StrType)le.orig_cname),TRIM((SALT38.StrType)le.orig_address),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_st),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_zip4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.date_submitted),TRIM((SALT38.StrType)le.date_created),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),TRIM((SALT38.StrType)le.consumer_text),IF (le.override_flag <> 0,TRIM((SALT38.StrType)le.override_flag), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.statement_id <> 0,TRIM((SALT38.StrType)le.statement_id), ''),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.orig_mname),TRIM((SALT38.StrType)le.orig_cname),TRIM((SALT38.StrType)le.orig_address),TRIM((SALT38.StrType)le.orig_city),TRIM((SALT38.StrType)le.orig_st),TRIM((SALT38.StrType)le.orig_zip),TRIM((SALT38.StrType)le.orig_zip4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dbpc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.date_submitted),TRIM((SALT38.StrType)le.date_created),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),TRIM((SALT38.StrType)le.consumer_text),IF (le.override_flag <> 0,TRIM((SALT38.StrType)le.override_flag), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),48*48,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'statement_id'}
      ,{2,'orig_fname'}
      ,{3,'orig_lname'}
      ,{4,'orig_mname'}
      ,{5,'orig_cname'}
      ,{6,'orig_address'}
      ,{7,'orig_city'}
      ,{8,'orig_st'}
      ,{9,'orig_zip'}
      ,{10,'orig_zip4'}
      ,{11,'phone'}
      ,{12,'title'}
      ,{13,'fname'}
      ,{14,'mname'}
      ,{15,'lname'}
      ,{16,'name_suffix'}
      ,{17,'name_score'}
      ,{18,'prim_range'}
      ,{19,'predir'}
      ,{20,'prim_name'}
      ,{21,'addr_suffix'}
      ,{22,'postdir'}
      ,{23,'unit_desig'}
      ,{24,'sec_range'}
      ,{25,'p_city_name'}
      ,{26,'v_city_name'}
      ,{27,'st'}
      ,{28,'zip'}
      ,{29,'zip4'}
      ,{30,'cart'}
      ,{31,'cr_sort_sz'}
      ,{32,'lot'}
      ,{33,'lot_order'}
      ,{34,'dbpc'}
      ,{35,'chk_digit'}
      ,{36,'rec_type'}
      ,{37,'county'}
      ,{38,'geo_lat'}
      ,{39,'geo_long'}
      ,{40,'msa'}
      ,{41,'geo_blk'}
      ,{42,'geo_match'}
      ,{43,'err_stat'}
      ,{44,'date_submitted'}
      ,{45,'date_created'}
      ,{46,'did'}
      ,{47,'consumer_text'}
      ,{48,'override_flag'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    DataFileNonFCRA_Fields.InValid_statement_id((SALT38.StrType)le.statement_id),
    DataFileNonFCRA_Fields.InValid_orig_fname((SALT38.StrType)le.orig_fname),
    DataFileNonFCRA_Fields.InValid_orig_lname((SALT38.StrType)le.orig_lname),
    DataFileNonFCRA_Fields.InValid_orig_mname((SALT38.StrType)le.orig_mname),
    DataFileNonFCRA_Fields.InValid_orig_cname((SALT38.StrType)le.orig_cname),
    DataFileNonFCRA_Fields.InValid_orig_address((SALT38.StrType)le.orig_address),
    DataFileNonFCRA_Fields.InValid_orig_city((SALT38.StrType)le.orig_city),
    DataFileNonFCRA_Fields.InValid_orig_st((SALT38.StrType)le.orig_st),
    DataFileNonFCRA_Fields.InValid_orig_zip((SALT38.StrType)le.orig_zip),
    DataFileNonFCRA_Fields.InValid_orig_zip4((SALT38.StrType)le.orig_zip4),
    DataFileNonFCRA_Fields.InValid_phone((SALT38.StrType)le.phone),
    DataFileNonFCRA_Fields.InValid_title((SALT38.StrType)le.title),
    DataFileNonFCRA_Fields.InValid_fname((SALT38.StrType)le.fname),
    DataFileNonFCRA_Fields.InValid_mname((SALT38.StrType)le.mname),
    DataFileNonFCRA_Fields.InValid_lname((SALT38.StrType)le.lname),
    DataFileNonFCRA_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    DataFileNonFCRA_Fields.InValid_name_score((SALT38.StrType)le.name_score),
    DataFileNonFCRA_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    DataFileNonFCRA_Fields.InValid_predir((SALT38.StrType)le.predir),
    DataFileNonFCRA_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    DataFileNonFCRA_Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix),
    DataFileNonFCRA_Fields.InValid_postdir((SALT38.StrType)le.postdir),
    DataFileNonFCRA_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    DataFileNonFCRA_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    DataFileNonFCRA_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    DataFileNonFCRA_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    DataFileNonFCRA_Fields.InValid_st((SALT38.StrType)le.st),
    DataFileNonFCRA_Fields.InValid_zip((SALT38.StrType)le.zip),
    DataFileNonFCRA_Fields.InValid_zip4((SALT38.StrType)le.zip4),
    DataFileNonFCRA_Fields.InValid_cart((SALT38.StrType)le.cart),
    DataFileNonFCRA_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    DataFileNonFCRA_Fields.InValid_lot((SALT38.StrType)le.lot),
    DataFileNonFCRA_Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    DataFileNonFCRA_Fields.InValid_dbpc((SALT38.StrType)le.dbpc),
    DataFileNonFCRA_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    DataFileNonFCRA_Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    DataFileNonFCRA_Fields.InValid_county((SALT38.StrType)le.county),
    DataFileNonFCRA_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    DataFileNonFCRA_Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    DataFileNonFCRA_Fields.InValid_msa((SALT38.StrType)le.msa),
    DataFileNonFCRA_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    DataFileNonFCRA_Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    DataFileNonFCRA_Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    DataFileNonFCRA_Fields.InValid_date_submitted((SALT38.StrType)le.date_submitted),
    DataFileNonFCRA_Fields.InValid_date_created((SALT38.StrType)le.date_created),
    DataFileNonFCRA_Fields.InValid_did((SALT38.StrType)le.did),
    DataFileNonFCRA_Fields.InValid_consumer_text((SALT38.StrType)le.consumer_text),
    DataFileNonFCRA_Fields.InValid_override_flag((SALT38.StrType)le.override_flag),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,48,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := DataFileNonFCRA_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Number','Invalid_Name','Invalid_Name','Invalid_Name','Invalid_Name','Unknown','Unknown','Invalid_State','Invalid_Number','Invalid_Number','Invalid_Phone','Unknown','Invalid_Name','Invalid_Name','Invalid_Name','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_State','Invalid_Number','Invalid_Number','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Date','Invalid_Date','Invalid_Number','Unknown','Invalid_Number');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,DataFileNonFCRA_Fields.InValidMessage_statement_id(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_cname(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_address(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_st(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_zip(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_phone(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_title(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_fname(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_mname(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_lname(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_predir(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_st(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_zip(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_cart(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_lot(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_county(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_msa(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_date_submitted(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_date_created(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_did(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_consumer_text(TotalErrors.ErrorNum),DataFileNonFCRA_Fields.InValidMessage_override_flag(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_ConsumerStatement, DataFileNonFCRA_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
