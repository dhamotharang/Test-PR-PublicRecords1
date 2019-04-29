IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_LN_PropertyV2_Search) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_vendor_source_flag_cnt := COUNT(GROUP,h.vendor_source_flag <> (TYPEOF(h.vendor_source_flag))'');
    populated_vendor_source_flag_pcnt := AVE(GROUP,IF(h.vendor_source_flag = (TYPEOF(h.vendor_source_flag))'',0,100));
    maxlength_vendor_source_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_source_flag)));
    avelength_vendor_source_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_source_flag)),h.vendor_source_flag<>(typeof(h.vendor_source_flag))'');
    populated_ln_fares_id_cnt := COUNT(GROUP,h.ln_fares_id <> (TYPEOF(h.ln_fares_id))'');
    populated_ln_fares_id_pcnt := AVE(GROUP,IF(h.ln_fares_id = (TYPEOF(h.ln_fares_id))'',0,100));
    maxlength_ln_fares_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_fares_id)));
    avelength_ln_fares_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_fares_id)),h.ln_fares_id<>(typeof(h.ln_fares_id))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_source_code_cnt := COUNT(GROUP,h.source_code <> (TYPEOF(h.source_code))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_which_orig_cnt := COUNT(GROUP,h.which_orig <> (TYPEOF(h.which_orig))'');
    populated_which_orig_pcnt := AVE(GROUP,IF(h.which_orig = (TYPEOF(h.which_orig))'',0,100));
    maxlength_which_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.which_orig)));
    avelength_which_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.which_orig)),h.which_orig<>(typeof(h.which_orig))'');
    populated_conjunctive_name_seq_cnt := COUNT(GROUP,h.conjunctive_name_seq <> (TYPEOF(h.conjunctive_name_seq))'');
    populated_conjunctive_name_seq_pcnt := AVE(GROUP,IF(h.conjunctive_name_seq = (TYPEOF(h.conjunctive_name_seq))'',0,100));
    maxlength_conjunctive_name_seq := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.conjunctive_name_seq)));
    avelength_conjunctive_name_seq := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.conjunctive_name_seq)),h.conjunctive_name_seq<>(typeof(h.conjunctive_name_seq))'');
    populated_title_cnt := COUNT(GROUP,h.title <> (TYPEOF(h.title))'');
    populated_title_pcnt := AVE(GROUP,IF(h.title = (TYPEOF(h.title))'',0,100));
    maxlength_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)));
    avelength_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title)),h.title<>(typeof(h.title))'');
    populated_fname_cnt := COUNT(GROUP,h.fname <> (TYPEOF(h.fname))'');
    populated_fname_pcnt := AVE(GROUP,IF(h.fname = (TYPEOF(h.fname))'',0,100));
    maxlength_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)));
    avelength_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname)),h.fname<>(typeof(h.fname))'');
    populated_mname_cnt := COUNT(GROUP,h.mname <> (TYPEOF(h.mname))'');
    populated_mname_pcnt := AVE(GROUP,IF(h.mname = (TYPEOF(h.mname))'',0,100));
    maxlength_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)));
    avelength_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname)),h.mname<>(typeof(h.mname))'');
    populated_lname_cnt := COUNT(GROUP,h.lname <> (TYPEOF(h.lname))'');
    populated_lname_pcnt := AVE(GROUP,IF(h.lname = (TYPEOF(h.lname))'',0,100));
    maxlength_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)));
    avelength_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname)),h.lname<>(typeof(h.lname))'');
    populated_name_suffix_cnt := COUNT(GROUP,h.name_suffix <> (TYPEOF(h.name_suffix))'');
    populated_name_suffix_pcnt := AVE(GROUP,IF(h.name_suffix = (TYPEOF(h.name_suffix))'',0,100));
    maxlength_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)));
    avelength_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix)),h.name_suffix<>(typeof(h.name_suffix))'');
    populated_cname_cnt := COUNT(GROUP,h.cname <> (TYPEOF(h.cname))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
    populated_nameasis_cnt := COUNT(GROUP,h.nameasis <> (TYPEOF(h.nameasis))'');
    populated_nameasis_pcnt := AVE(GROUP,IF(h.nameasis = (TYPEOF(h.nameasis))'',0,100));
    maxlength_nameasis := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nameasis)));
    avelength_nameasis := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nameasis)),h.nameasis<>(typeof(h.nameasis))'');
    populated_append_prepaddr1_cnt := COUNT(GROUP,h.append_prepaddr1 <> (TYPEOF(h.append_prepaddr1))'');
    populated_append_prepaddr1_pcnt := AVE(GROUP,IF(h.append_prepaddr1 = (TYPEOF(h.append_prepaddr1))'',0,100));
    maxlength_append_prepaddr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prepaddr1)));
    avelength_append_prepaddr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prepaddr1)),h.append_prepaddr1<>(typeof(h.append_prepaddr1))'');
    populated_append_prepaddr2_cnt := COUNT(GROUP,h.append_prepaddr2 <> (TYPEOF(h.append_prepaddr2))'');
    populated_append_prepaddr2_pcnt := AVE(GROUP,IF(h.append_prepaddr2 = (TYPEOF(h.append_prepaddr2))'',0,100));
    maxlength_append_prepaddr2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prepaddr2)));
    avelength_append_prepaddr2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_prepaddr2)),h.append_prepaddr2<>(typeof(h.append_prepaddr2))'');
    populated_append_rawaid_cnt := COUNT(GROUP,h.append_rawaid <> (TYPEOF(h.append_rawaid))'');
    populated_append_rawaid_pcnt := AVE(GROUP,IF(h.append_rawaid = (TYPEOF(h.append_rawaid))'',0,100));
    maxlength_append_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)));
    avelength_append_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.append_rawaid)),h.append_rawaid<>(typeof(h.append_rawaid))'');
    populated_prim_range_cnt := COUNT(GROUP,h.prim_range <> (TYPEOF(h.prim_range))'');
    populated_prim_range_pcnt := AVE(GROUP,IF(h.prim_range = (TYPEOF(h.prim_range))'',0,100));
    maxlength_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)));
    avelength_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_range)),h.prim_range<>(typeof(h.prim_range))'');
    populated_predir_cnt := COUNT(GROUP,h.predir <> (TYPEOF(h.predir))'');
    populated_predir_pcnt := AVE(GROUP,IF(h.predir = (TYPEOF(h.predir))'',0,100));
    maxlength_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)));
    avelength_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.predir)),h.predir<>(typeof(h.predir))'');
    populated_prim_name_cnt := COUNT(GROUP,h.prim_name <> (TYPEOF(h.prim_name))'');
    populated_prim_name_pcnt := AVE(GROUP,IF(h.prim_name = (TYPEOF(h.prim_name))'',0,100));
    maxlength_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)));
    avelength_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prim_name)),h.prim_name<>(typeof(h.prim_name))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_postdir_cnt := COUNT(GROUP,h.postdir <> (TYPEOF(h.postdir))'');
    populated_postdir_pcnt := AVE(GROUP,IF(h.postdir = (TYPEOF(h.postdir))'',0,100));
    maxlength_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)));
    avelength_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.postdir)),h.postdir<>(typeof(h.postdir))'');
    populated_unit_desig_cnt := COUNT(GROUP,h.unit_desig <> (TYPEOF(h.unit_desig))'');
    populated_unit_desig_pcnt := AVE(GROUP,IF(h.unit_desig = (TYPEOF(h.unit_desig))'',0,100));
    maxlength_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)));
    avelength_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.unit_desig)),h.unit_desig<>(typeof(h.unit_desig))'');
    populated_sec_range_cnt := COUNT(GROUP,h.sec_range <> (TYPEOF(h.sec_range))'');
    populated_sec_range_pcnt := AVE(GROUP,IF(h.sec_range = (TYPEOF(h.sec_range))'',0,100));
    maxlength_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)));
    avelength_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sec_range)),h.sec_range<>(typeof(h.sec_range))'');
    populated_p_city_name_cnt := COUNT(GROUP,h.p_city_name <> (TYPEOF(h.p_city_name))'');
    populated_p_city_name_pcnt := AVE(GROUP,IF(h.p_city_name = (TYPEOF(h.p_city_name))'',0,100));
    maxlength_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)));
    avelength_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.p_city_name)),h.p_city_name<>(typeof(h.p_city_name))'');
    populated_v_city_name_cnt := COUNT(GROUP,h.v_city_name <> (TYPEOF(h.v_city_name))'');
    populated_v_city_name_pcnt := AVE(GROUP,IF(h.v_city_name = (TYPEOF(h.v_city_name))'',0,100));
    maxlength_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)));
    avelength_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_city_name)),h.v_city_name<>(typeof(h.v_city_name))'');
    populated_st_cnt := COUNT(GROUP,h.st <> (TYPEOF(h.st))'');
    populated_st_pcnt := AVE(GROUP,IF(h.st = (TYPEOF(h.st))'',0,100));
    maxlength_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)));
    avelength_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.st)),h.st<>(typeof(h.st))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_cart_cnt := COUNT(GROUP,h.cart <> (TYPEOF(h.cart))'');
    populated_cart_pcnt := AVE(GROUP,IF(h.cart = (TYPEOF(h.cart))'',0,100));
    maxlength_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)));
    avelength_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cart)),h.cart<>(typeof(h.cart))'');
    populated_cr_sort_sz_cnt := COUNT(GROUP,h.cr_sort_sz <> (TYPEOF(h.cr_sort_sz))'');
    populated_cr_sort_sz_pcnt := AVE(GROUP,IF(h.cr_sort_sz = (TYPEOF(h.cr_sort_sz))'',0,100));
    maxlength_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)));
    avelength_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cr_sort_sz)),h.cr_sort_sz<>(typeof(h.cr_sort_sz))'');
    populated_lot_cnt := COUNT(GROUP,h.lot <> (TYPEOF(h.lot))'');
    populated_lot_pcnt := AVE(GROUP,IF(h.lot = (TYPEOF(h.lot))'',0,100));
    maxlength_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)));
    avelength_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot)),h.lot<>(typeof(h.lot))'');
    populated_lot_order_cnt := COUNT(GROUP,h.lot_order <> (TYPEOF(h.lot_order))'');
    populated_lot_order_pcnt := AVE(GROUP,IF(h.lot_order = (TYPEOF(h.lot_order))'',0,100));
    maxlength_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)));
    avelength_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_order)),h.lot_order<>(typeof(h.lot_order))'');
    populated_dbpc_cnt := COUNT(GROUP,h.dbpc <> (TYPEOF(h.dbpc))'');
    populated_dbpc_pcnt := AVE(GROUP,IF(h.dbpc = (TYPEOF(h.dbpc))'',0,100));
    maxlength_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)));
    avelength_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dbpc)),h.dbpc<>(typeof(h.dbpc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_msa_cnt := COUNT(GROUP,h.msa <> (TYPEOF(h.msa))'');
    populated_msa_pcnt := AVE(GROUP,IF(h.msa = (TYPEOF(h.msa))'',0,100));
    maxlength_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)));
    avelength_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.msa)),h.msa<>(typeof(h.msa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_phone_number_cnt := COUNT(GROUP,h.phone_number <> (TYPEOF(h.phone_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_name_type_cnt := COUNT(GROUP,h.name_type <> (TYPEOF(h.name_type))'');
    populated_name_type_pcnt := AVE(GROUP,IF(h.name_type = (TYPEOF(h.name_type))'',0,100));
    maxlength_name_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_type)));
    avelength_name_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_type)),h.name_type<>(typeof(h.name_type))'');
    populated_prop_addr_propagated_ind_cnt := COUNT(GROUP,h.prop_addr_propagated_ind <> (TYPEOF(h.prop_addr_propagated_ind))'');
    populated_prop_addr_propagated_ind_pcnt := AVE(GROUP,IF(h.prop_addr_propagated_ind = (TYPEOF(h.prop_addr_propagated_ind))'',0,100));
    maxlength_prop_addr_propagated_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_propagated_ind)));
    avelength_prop_addr_propagated_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prop_addr_propagated_ind)),h.prop_addr_propagated_ind<>(typeof(h.prop_addr_propagated_ind))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_app_ssn_cnt := COUNT(GROUP,h.app_ssn <> (TYPEOF(h.app_ssn))'');
    populated_app_ssn_pcnt := AVE(GROUP,IF(h.app_ssn = (TYPEOF(h.app_ssn))'',0,100));
    maxlength_app_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.app_ssn)));
    avelength_app_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.app_ssn)),h.app_ssn<>(typeof(h.app_ssn))'');
    populated_app_tax_id_cnt := COUNT(GROUP,h.app_tax_id <> (TYPEOF(h.app_tax_id))'');
    populated_app_tax_id_pcnt := AVE(GROUP,IF(h.app_tax_id = (TYPEOF(h.app_tax_id))'',0,100));
    maxlength_app_tax_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.app_tax_id)));
    avelength_app_tax_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.app_tax_id)),h.app_tax_id<>(typeof(h.app_tax_id))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_ln_party_status_cnt := COUNT(GROUP,h.ln_party_status <> (TYPEOF(h.ln_party_status))'');
    populated_ln_party_status_pcnt := AVE(GROUP,IF(h.ln_party_status = (TYPEOF(h.ln_party_status))'',0,100));
    maxlength_ln_party_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_party_status)));
    avelength_ln_party_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_party_status)),h.ln_party_status<>(typeof(h.ln_party_status))'');
    populated_ln_percentage_ownership_cnt := COUNT(GROUP,h.ln_percentage_ownership <> (TYPEOF(h.ln_percentage_ownership))'');
    populated_ln_percentage_ownership_pcnt := AVE(GROUP,IF(h.ln_percentage_ownership = (TYPEOF(h.ln_percentage_ownership))'',0,100));
    maxlength_ln_percentage_ownership := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_percentage_ownership)));
    avelength_ln_percentage_ownership := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_percentage_ownership)),h.ln_percentage_ownership<>(typeof(h.ln_percentage_ownership))'');
    populated_ln_entity_type_cnt := COUNT(GROUP,h.ln_entity_type <> (TYPEOF(h.ln_entity_type))'');
    populated_ln_entity_type_pcnt := AVE(GROUP,IF(h.ln_entity_type = (TYPEOF(h.ln_entity_type))'',0,100));
    maxlength_ln_entity_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_entity_type)));
    avelength_ln_entity_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_entity_type)),h.ln_entity_type<>(typeof(h.ln_entity_type))'');
    populated_ln_estate_trust_date_cnt := COUNT(GROUP,h.ln_estate_trust_date <> (TYPEOF(h.ln_estate_trust_date))'');
    populated_ln_estate_trust_date_pcnt := AVE(GROUP,IF(h.ln_estate_trust_date = (TYPEOF(h.ln_estate_trust_date))'',0,100));
    maxlength_ln_estate_trust_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_estate_trust_date)));
    avelength_ln_estate_trust_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_estate_trust_date)),h.ln_estate_trust_date<>(typeof(h.ln_estate_trust_date))'');
    populated_ln_goverment_type_cnt := COUNT(GROUP,h.ln_goverment_type <> (TYPEOF(h.ln_goverment_type))'');
    populated_ln_goverment_type_pcnt := AVE(GROUP,IF(h.ln_goverment_type = (TYPEOF(h.ln_goverment_type))'',0,100));
    maxlength_ln_goverment_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_goverment_type)));
    avelength_ln_goverment_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ln_goverment_type)),h.ln_goverment_type<>(typeof(h.ln_goverment_type))'');
    populated_xadl2_weight_cnt := COUNT(GROUP,h.xadl2_weight <> (TYPEOF(h.xadl2_weight))'');
    populated_xadl2_weight_pcnt := AVE(GROUP,IF(h.xadl2_weight = (TYPEOF(h.xadl2_weight))'',0,100));
    maxlength_xadl2_weight := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_weight)));
    avelength_xadl2_weight := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.xadl2_weight)),h.xadl2_weight<>(typeof(h.xadl2_weight))'');
    populated_addr_ind_cnt := COUNT(GROUP,h.addr_ind <> (TYPEOF(h.addr_ind))'');
    populated_addr_ind_pcnt := AVE(GROUP,IF(h.addr_ind = (TYPEOF(h.addr_ind))'',0,100));
    maxlength_addr_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_ind)));
    avelength_addr_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_ind)),h.addr_ind<>(typeof(h.addr_ind))'');
    populated_best_addr_ind_cnt := COUNT(GROUP,h.best_addr_ind <> (TYPEOF(h.best_addr_ind))'');
    populated_best_addr_ind_pcnt := AVE(GROUP,IF(h.best_addr_ind = (TYPEOF(h.best_addr_ind))'',0,100));
    maxlength_best_addr_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_addr_ind)));
    avelength_best_addr_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_addr_ind)),h.best_addr_ind<>(typeof(h.best_addr_ind))'');
    populated_addr_tx_id_cnt := COUNT(GROUP,h.addr_tx_id <> (TYPEOF(h.addr_tx_id))'');
    populated_addr_tx_id_pcnt := AVE(GROUP,IF(h.addr_tx_id = (TYPEOF(h.addr_tx_id))'',0,100));
    maxlength_addr_tx_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_tx_id)));
    avelength_addr_tx_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_tx_id)),h.addr_tx_id<>(typeof(h.addr_tx_id))'');
    populated_best_addr_tx_id_cnt := COUNT(GROUP,h.best_addr_tx_id <> (TYPEOF(h.best_addr_tx_id))'');
    populated_best_addr_tx_id_pcnt := AVE(GROUP,IF(h.best_addr_tx_id = (TYPEOF(h.best_addr_tx_id))'',0,100));
    maxlength_best_addr_tx_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_addr_tx_id)));
    avelength_best_addr_tx_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_addr_tx_id)),h.best_addr_tx_id<>(typeof(h.best_addr_tx_id))'');
    populated_location_id_cnt := COUNT(GROUP,h.location_id <> (TYPEOF(h.location_id))'');
    populated_location_id_pcnt := AVE(GROUP,IF(h.location_id = (TYPEOF(h.location_id))'',0,100));
    maxlength_location_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_id)));
    avelength_location_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_id)),h.location_id<>(typeof(h.location_id))'');
    populated_best_locid_cnt := COUNT(GROUP,h.best_locid <> (TYPEOF(h.best_locid))'');
    populated_best_locid_pcnt := AVE(GROUP,IF(h.best_locid = (TYPEOF(h.best_locid))'',0,100));
    maxlength_best_locid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_locid)));
    avelength_best_locid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_locid)),h.best_locid<>(typeof(h.best_locid))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_vendor_source_flag_pcnt *   0.00 / 100 + T.Populated_ln_fares_id_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_which_orig_pcnt *   0.00 / 100 + T.Populated_conjunctive_name_seq_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_nameasis_pcnt *   0.00 / 100 + T.Populated_append_prepaddr1_pcnt *   0.00 / 100 + T.Populated_append_prepaddr2_pcnt *   0.00 / 100 + T.Populated_append_rawaid_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_name_type_pcnt *   0.00 / 100 + T.Populated_prop_addr_propagated_ind_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_app_ssn_pcnt *   0.00 / 100 + T.Populated_app_tax_id_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_ln_party_status_pcnt *   0.00 / 100 + T.Populated_ln_percentage_ownership_pcnt *   0.00 / 100 + T.Populated_ln_entity_type_pcnt *   0.00 / 100 + T.Populated_ln_estate_trust_date_pcnt *   0.00 / 100 + T.Populated_ln_goverment_type_pcnt *   0.00 / 100 + T.Populated_xadl2_weight_pcnt *   0.00 / 100 + T.Populated_addr_ind_pcnt *   0.00 / 100 + T.Populated_best_addr_ind_pcnt *   0.00 / 100 + T.Populated_addr_tx_id_pcnt *   0.00 / 100 + T.Populated_best_addr_tx_id_pcnt *   0.00 / 100 + T.Populated_location_id_pcnt *   0.00 / 100 + T.Populated_best_locid_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','vendor_source_flag','ln_fares_id','process_date','source_code','which_orig','conjunctive_name_seq','title','fname','mname','lname','name_suffix','cname','nameasis','append_prepaddr1','append_prepaddr2','append_rawaid','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','phone_number','name_type','prop_addr_propagated_ind','did','bdid','app_ssn','app_tax_id','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','ln_party_status','ln_percentage_ownership','ln_entity_type','ln_estate_trust_date','ln_goverment_type','xadl2_weight','addr_ind','best_addr_ind','addr_tx_id','best_addr_tx_id','location_id','best_locid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_vendor_source_flag_pcnt,le.populated_ln_fares_id_pcnt,le.populated_process_date_pcnt,le.populated_source_code_pcnt,le.populated_which_orig_pcnt,le.populated_conjunctive_name_seq_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_cname_pcnt,le.populated_nameasis_pcnt,le.populated_append_prepaddr1_pcnt,le.populated_append_prepaddr2_pcnt,le.populated_append_rawaid_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_phone_number_pcnt,le.populated_name_type_pcnt,le.populated_prop_addr_propagated_ind_pcnt,le.populated_did_pcnt,le.populated_bdid_pcnt,le.populated_app_ssn_pcnt,le.populated_app_tax_id_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_source_rec_id_pcnt,le.populated_ln_party_status_pcnt,le.populated_ln_percentage_ownership_pcnt,le.populated_ln_entity_type_pcnt,le.populated_ln_estate_trust_date_pcnt,le.populated_ln_goverment_type_pcnt,le.populated_xadl2_weight_pcnt,le.populated_addr_ind_pcnt,le.populated_best_addr_ind_pcnt,le.populated_addr_tx_id_pcnt,le.populated_best_addr_tx_id_pcnt,le.populated_location_id_pcnt,le.populated_best_locid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_vendor_source_flag,le.maxlength_ln_fares_id,le.maxlength_process_date,le.maxlength_source_code,le.maxlength_which_orig,le.maxlength_conjunctive_name_seq,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_cname,le.maxlength_nameasis,le.maxlength_append_prepaddr1,le.maxlength_append_prepaddr2,le.maxlength_append_rawaid,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_phone_number,le.maxlength_name_type,le.maxlength_prop_addr_propagated_ind,le.maxlength_did,le.maxlength_bdid,le.maxlength_app_ssn,le.maxlength_app_tax_id,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_source_rec_id,le.maxlength_ln_party_status,le.maxlength_ln_percentage_ownership,le.maxlength_ln_entity_type,le.maxlength_ln_estate_trust_date,le.maxlength_ln_goverment_type,le.maxlength_xadl2_weight,le.maxlength_addr_ind,le.maxlength_best_addr_ind,le.maxlength_addr_tx_id,le.maxlength_best_addr_tx_id,le.maxlength_location_id,le.maxlength_best_locid);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_vendor_source_flag,le.avelength_ln_fares_id,le.avelength_process_date,le.avelength_source_code,le.avelength_which_orig,le.avelength_conjunctive_name_seq,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_cname,le.avelength_nameasis,le.avelength_append_prepaddr1,le.avelength_append_prepaddr2,le.avelength_append_rawaid,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_phone_number,le.avelength_name_type,le.avelength_prop_addr_propagated_ind,le.avelength_did,le.avelength_bdid,le.avelength_app_ssn,le.avelength_app_tax_id,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_source_rec_id,le.avelength_ln_party_status,le.avelength_ln_percentage_ownership,le.avelength_ln_entity_type,le.avelength_ln_estate_trust_date,le.avelength_ln_goverment_type,le.avelength_xadl2_weight,le.avelength_addr_ind,le.avelength_best_addr_ind,le.avelength_addr_tx_id,le.avelength_best_addr_tx_id,le.avelength_location_id,le.avelength_best_locid);
END;
EXPORT invSummary := NORMALIZE(summary0, 87, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.which_orig),TRIM((SALT311.StrType)le.conjunctive_name_seq),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.cname),TRIM((SALT311.StrType)le.nameasis),TRIM((SALT311.StrType)le.append_prepaddr1),TRIM((SALT311.StrType)le.append_prepaddr2),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.app_ssn),TRIM((SALT311.StrType)le.app_tax_id),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),TRIM((SALT311.StrType)le.ln_party_status),TRIM((SALT311.StrType)le.ln_percentage_ownership),TRIM((SALT311.StrType)le.ln_entity_type),TRIM((SALT311.StrType)le.ln_estate_trust_date),TRIM((SALT311.StrType)le.ln_goverment_type),IF (le.xadl2_weight <> 0,TRIM((SALT311.StrType)le.xadl2_weight), ''),TRIM((SALT311.StrType)le.addr_ind),TRIM((SALT311.StrType)le.best_addr_ind),IF (le.addr_tx_id <> 0,TRIM((SALT311.StrType)le.addr_tx_id), ''),TRIM((SALT311.StrType)le.best_addr_tx_id),IF (le.location_id <> 0,TRIM((SALT311.StrType)le.location_id), ''),TRIM((SALT311.StrType)le.best_locid)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,87,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 87);
  SELF.FldNo2 := 1 + (C % 87);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.which_orig),TRIM((SALT311.StrType)le.conjunctive_name_seq),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.cname),TRIM((SALT311.StrType)le.nameasis),TRIM((SALT311.StrType)le.append_prepaddr1),TRIM((SALT311.StrType)le.append_prepaddr2),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.app_ssn),TRIM((SALT311.StrType)le.app_tax_id),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),TRIM((SALT311.StrType)le.ln_party_status),TRIM((SALT311.StrType)le.ln_percentage_ownership),TRIM((SALT311.StrType)le.ln_entity_type),TRIM((SALT311.StrType)le.ln_estate_trust_date),TRIM((SALT311.StrType)le.ln_goverment_type),IF (le.xadl2_weight <> 0,TRIM((SALT311.StrType)le.xadl2_weight), ''),TRIM((SALT311.StrType)le.addr_ind),TRIM((SALT311.StrType)le.best_addr_ind),IF (le.addr_tx_id <> 0,TRIM((SALT311.StrType)le.addr_tx_id), ''),TRIM((SALT311.StrType)le.best_addr_tx_id),IF (le.location_id <> 0,TRIM((SALT311.StrType)le.location_id), ''),TRIM((SALT311.StrType)le.best_locid)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),TRIM((SALT311.StrType)le.vendor_source_flag),TRIM((SALT311.StrType)le.ln_fares_id),TRIM((SALT311.StrType)le.process_date),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.which_orig),TRIM((SALT311.StrType)le.conjunctive_name_seq),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.cname),TRIM((SALT311.StrType)le.nameasis),TRIM((SALT311.StrType)le.append_prepaddr1),TRIM((SALT311.StrType)le.append_prepaddr2),IF (le.append_rawaid <> 0,TRIM((SALT311.StrType)le.append_rawaid), ''),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.name_type),TRIM((SALT311.StrType)le.prop_addr_propagated_ind),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.bdid <> 0,TRIM((SALT311.StrType)le.bdid), ''),TRIM((SALT311.StrType)le.app_ssn),TRIM((SALT311.StrType)le.app_tax_id),IF (le.dotid <> 0,TRIM((SALT311.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT311.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT311.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT311.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT311.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT311.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT311.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT311.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT311.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT311.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT311.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT311.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT311.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT311.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT311.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT311.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT311.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT311.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT311.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT311.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT311.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT311.StrType)le.source_rec_id), ''),TRIM((SALT311.StrType)le.ln_party_status),TRIM((SALT311.StrType)le.ln_percentage_ownership),TRIM((SALT311.StrType)le.ln_entity_type),TRIM((SALT311.StrType)le.ln_estate_trust_date),TRIM((SALT311.StrType)le.ln_goverment_type),IF (le.xadl2_weight <> 0,TRIM((SALT311.StrType)le.xadl2_weight), ''),TRIM((SALT311.StrType)le.addr_ind),TRIM((SALT311.StrType)le.best_addr_ind),IF (le.addr_tx_id <> 0,TRIM((SALT311.StrType)le.addr_tx_id), ''),TRIM((SALT311.StrType)le.best_addr_tx_id),IF (le.location_id <> 0,TRIM((SALT311.StrType)le.location_id), ''),TRIM((SALT311.StrType)le.best_locid)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),87*87,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'vendor_source_flag'}
      ,{6,'ln_fares_id'}
      ,{7,'process_date'}
      ,{8,'source_code'}
      ,{9,'which_orig'}
      ,{10,'conjunctive_name_seq'}
      ,{11,'title'}
      ,{12,'fname'}
      ,{13,'mname'}
      ,{14,'lname'}
      ,{15,'name_suffix'}
      ,{16,'cname'}
      ,{17,'nameasis'}
      ,{18,'append_prepaddr1'}
      ,{19,'append_prepaddr2'}
      ,{20,'append_rawaid'}
      ,{21,'prim_range'}
      ,{22,'predir'}
      ,{23,'prim_name'}
      ,{24,'suffix'}
      ,{25,'postdir'}
      ,{26,'unit_desig'}
      ,{27,'sec_range'}
      ,{28,'p_city_name'}
      ,{29,'v_city_name'}
      ,{30,'st'}
      ,{31,'zip'}
      ,{32,'zip4'}
      ,{33,'cart'}
      ,{34,'cr_sort_sz'}
      ,{35,'lot'}
      ,{36,'lot_order'}
      ,{37,'dbpc'}
      ,{38,'chk_digit'}
      ,{39,'rec_type'}
      ,{40,'county'}
      ,{41,'geo_lat'}
      ,{42,'geo_long'}
      ,{43,'msa'}
      ,{44,'geo_blk'}
      ,{45,'geo_match'}
      ,{46,'err_stat'}
      ,{47,'phone_number'}
      ,{48,'name_type'}
      ,{49,'prop_addr_propagated_ind'}
      ,{50,'did'}
      ,{51,'bdid'}
      ,{52,'app_ssn'}
      ,{53,'app_tax_id'}
      ,{54,'dotid'}
      ,{55,'dotscore'}
      ,{56,'dotweight'}
      ,{57,'empid'}
      ,{58,'empscore'}
      ,{59,'empweight'}
      ,{60,'powid'}
      ,{61,'powscore'}
      ,{62,'powweight'}
      ,{63,'proxid'}
      ,{64,'proxscore'}
      ,{65,'proxweight'}
      ,{66,'seleid'}
      ,{67,'selescore'}
      ,{68,'seleweight'}
      ,{69,'orgid'}
      ,{70,'orgscore'}
      ,{71,'orgweight'}
      ,{72,'ultid'}
      ,{73,'ultscore'}
      ,{74,'ultweight'}
      ,{75,'source_rec_id'}
      ,{76,'ln_party_status'}
      ,{77,'ln_percentage_ownership'}
      ,{78,'ln_entity_type'}
      ,{79,'ln_estate_trust_date'}
      ,{80,'ln_goverment_type'}
      ,{81,'xadl2_weight'}
      ,{82,'addr_ind'}
      ,{83,'best_addr_ind'}
      ,{84,'addr_tx_id'}
      ,{85,'best_addr_tx_id'}
      ,{86,'location_id'}
      ,{87,'best_locid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_vendor_source_flag((SALT311.StrType)le.vendor_source_flag),
    Fields.InValid_ln_fares_id((SALT311.StrType)le.ln_fares_id),
    Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Fields.InValid_source_code((SALT311.StrType)le.source_code),
    Fields.InValid_which_orig((SALT311.StrType)le.which_orig),
    Fields.InValid_conjunctive_name_seq((SALT311.StrType)le.conjunctive_name_seq),
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_cname((SALT311.StrType)le.cname),
    Fields.InValid_nameasis((SALT311.StrType)le.nameasis),
    Fields.InValid_append_prepaddr1((SALT311.StrType)le.append_prepaddr1),
    Fields.InValid_append_prepaddr2((SALT311.StrType)le.append_prepaddr2),
    Fields.InValid_append_rawaid((SALT311.StrType)le.append_rawaid),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_suffix((SALT311.StrType)le.suffix),
    Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Fields.InValid_st((SALT311.StrType)le.st),
    Fields.InValid_zip((SALT311.StrType)le.zip),
    Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Fields.InValid_cart((SALT311.StrType)le.cart),
    Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Fields.InValid_lot((SALT311.StrType)le.lot),
    Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Fields.InValid_dbpc((SALT311.StrType)le.dbpc),
    Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Fields.InValid_county((SALT311.StrType)le.county),
    Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Fields.InValid_msa((SALT311.StrType)le.msa),
    Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Fields.InValid_phone_number((SALT311.StrType)le.phone_number),
    Fields.InValid_name_type((SALT311.StrType)le.name_type),
    Fields.InValid_prop_addr_propagated_ind((SALT311.StrType)le.prop_addr_propagated_ind),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_bdid((SALT311.StrType)le.bdid),
    Fields.InValid_app_ssn((SALT311.StrType)le.app_ssn),
    Fields.InValid_app_tax_id((SALT311.StrType)le.app_tax_id),
    Fields.InValid_dotid((SALT311.StrType)le.dotid),
    Fields.InValid_dotscore((SALT311.StrType)le.dotscore),
    Fields.InValid_dotweight((SALT311.StrType)le.dotweight),
    Fields.InValid_empid((SALT311.StrType)le.empid),
    Fields.InValid_empscore((SALT311.StrType)le.empscore),
    Fields.InValid_empweight((SALT311.StrType)le.empweight),
    Fields.InValid_powid((SALT311.StrType)le.powid),
    Fields.InValid_powscore((SALT311.StrType)le.powscore),
    Fields.InValid_powweight((SALT311.StrType)le.powweight),
    Fields.InValid_proxid((SALT311.StrType)le.proxid),
    Fields.InValid_proxscore((SALT311.StrType)le.proxscore),
    Fields.InValid_proxweight((SALT311.StrType)le.proxweight),
    Fields.InValid_seleid((SALT311.StrType)le.seleid),
    Fields.InValid_selescore((SALT311.StrType)le.selescore),
    Fields.InValid_seleweight((SALT311.StrType)le.seleweight),
    Fields.InValid_orgid((SALT311.StrType)le.orgid),
    Fields.InValid_orgscore((SALT311.StrType)le.orgscore),
    Fields.InValid_orgweight((SALT311.StrType)le.orgweight),
    Fields.InValid_ultid((SALT311.StrType)le.ultid),
    Fields.InValid_ultscore((SALT311.StrType)le.ultscore),
    Fields.InValid_ultweight((SALT311.StrType)le.ultweight),
    Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id),
    Fields.InValid_ln_party_status((SALT311.StrType)le.ln_party_status),
    Fields.InValid_ln_percentage_ownership((SALT311.StrType)le.ln_percentage_ownership),
    Fields.InValid_ln_entity_type((SALT311.StrType)le.ln_entity_type),
    Fields.InValid_ln_estate_trust_date((SALT311.StrType)le.ln_estate_trust_date),
    Fields.InValid_ln_goverment_type((SALT311.StrType)le.ln_goverment_type),
    Fields.InValid_xadl2_weight((SALT311.StrType)le.xadl2_weight),
    Fields.InValid_addr_ind((SALT311.StrType)le.addr_ind),
    Fields.InValid_best_addr_ind((SALT311.StrType)le.best_addr_ind),
    Fields.InValid_addr_tx_id((SALT311.StrType)le.addr_tx_id),
    Fields.InValid_best_addr_tx_id((SALT311.StrType)le.best_addr_tx_id),
    Fields.InValid_location_id((SALT311.StrType)le.location_id),
    Fields.InValid_best_locid((SALT311.StrType)le.best_locid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,87,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Unknown','Invalid_LNFaresID','Invalid_Date','Invalid_SourceCode','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_RecType','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Num','Invalid_PartyStatus','Invalid_Percent','Invalid_LNEntityType','Invalid_Num','Unknown','Unknown','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_source_flag(TotalErrors.ErrorNum),Fields.InValidMessage_ln_fares_id(TotalErrors.ErrorNum),Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_which_orig(TotalErrors.ErrorNum),Fields.InValidMessage_conjunctive_name_seq(TotalErrors.ErrorNum),Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_cname(TotalErrors.ErrorNum),Fields.InValidMessage_nameasis(TotalErrors.ErrorNum),Fields.InValidMessage_append_prepaddr1(TotalErrors.ErrorNum),Fields.InValidMessage_append_prepaddr2(TotalErrors.ErrorNum),Fields.InValidMessage_append_rawaid(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_name_type(TotalErrors.ErrorNum),Fields.InValidMessage_prop_addr_propagated_ind(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_bdid(TotalErrors.ErrorNum),Fields.InValidMessage_app_ssn(TotalErrors.ErrorNum),Fields.InValidMessage_app_tax_id(TotalErrors.ErrorNum),Fields.InValidMessage_dotid(TotalErrors.ErrorNum),Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),Fields.InValidMessage_empid(TotalErrors.ErrorNum),Fields.InValidMessage_empscore(TotalErrors.ErrorNum),Fields.InValidMessage_empweight(TotalErrors.ErrorNum),Fields.InValidMessage_powid(TotalErrors.ErrorNum),Fields.InValidMessage_powscore(TotalErrors.ErrorNum),Fields.InValidMessage_powweight(TotalErrors.ErrorNum),Fields.InValidMessage_proxid(TotalErrors.ErrorNum),Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),Fields.InValidMessage_seleid(TotalErrors.ErrorNum),Fields.InValidMessage_selescore(TotalErrors.ErrorNum),Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),Fields.InValidMessage_orgid(TotalErrors.ErrorNum),Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),Fields.InValidMessage_ultid(TotalErrors.ErrorNum),Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),Fields.InValidMessage_ln_party_status(TotalErrors.ErrorNum),Fields.InValidMessage_ln_percentage_ownership(TotalErrors.ErrorNum),Fields.InValidMessage_ln_entity_type(TotalErrors.ErrorNum),Fields.InValidMessage_ln_estate_trust_date(TotalErrors.ErrorNum),Fields.InValidMessage_ln_goverment_type(TotalErrors.ErrorNum),Fields.InValidMessage_xadl2_weight(TotalErrors.ErrorNum),Fields.InValidMessage_addr_ind(TotalErrors.ErrorNum),Fields.InValidMessage_best_addr_ind(TotalErrors.ErrorNum),Fields.InValidMessage_addr_tx_id(TotalErrors.ErrorNum),Fields.InValidMessage_best_addr_tx_id(TotalErrors.ErrorNum),Fields.InValidMessage_location_id(TotalErrors.ErrorNum),Fields.InValidMessage_best_locid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_LN_PropertyV2_Search, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
