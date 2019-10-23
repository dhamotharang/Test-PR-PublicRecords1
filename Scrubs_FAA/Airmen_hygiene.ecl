IMPORT SALT38,STD;
EXPORT Airmen_hygiene(dataset(Airmen_layout_FAA) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_d_score_cnt := COUNT(GROUP,h.d_score <> (TYPEOF(h.d_score))'');
    populated_d_score_pcnt := AVE(GROUP,IF(h.d_score = (TYPEOF(h.d_score))'',0,100));
    maxlength_d_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.d_score)));
    avelength_d_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.d_score)),h.d_score<>(typeof(h.d_score))'');
    populated_best_ssn_cnt := COUNT(GROUP,h.best_ssn <> (TYPEOF(h.best_ssn))'');
    populated_best_ssn_pcnt := AVE(GROUP,IF(h.best_ssn = (TYPEOF(h.best_ssn))'',0,100));
    maxlength_best_ssn := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.best_ssn)));
    avelength_best_ssn := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.best_ssn)),h.best_ssn<>(typeof(h.best_ssn))'');
    populated_did_out_cnt := COUNT(GROUP,h.did_out <> (TYPEOF(h.did_out))'');
    populated_did_out_pcnt := AVE(GROUP,IF(h.did_out = (TYPEOF(h.did_out))'',0,100));
    maxlength_did_out := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_out)));
    avelength_did_out := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_out)),h.did_out<>(typeof(h.did_out))'');
    populated_date_first_seen_cnt := COUNT(GROUP,h.date_first_seen <> (TYPEOF(h.date_first_seen))'');
    populated_date_first_seen_pcnt := AVE(GROUP,IF(h.date_first_seen = (TYPEOF(h.date_first_seen))'',0,100));
    maxlength_date_first_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)));
    avelength_date_first_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_first_seen)),h.date_first_seen<>(typeof(h.date_first_seen))'');
    populated_date_last_seen_cnt := COUNT(GROUP,h.date_last_seen <> (TYPEOF(h.date_last_seen))'');
    populated_date_last_seen_pcnt := AVE(GROUP,IF(h.date_last_seen = (TYPEOF(h.date_last_seen))'',0,100));
    maxlength_date_last_seen := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)));
    avelength_date_last_seen := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.date_last_seen)),h.date_last_seen<>(typeof(h.date_last_seen))'');
    populated_current_flag_cnt := COUNT(GROUP,h.current_flag <> (TYPEOF(h.current_flag))'');
    populated_current_flag_pcnt := AVE(GROUP,IF(h.current_flag = (TYPEOF(h.current_flag))'',0,100));
    maxlength_current_flag := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.current_flag)));
    avelength_current_flag := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.current_flag)),h.current_flag<>(typeof(h.current_flag))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_letter_code_cnt := COUNT(GROUP,h.letter_code <> (TYPEOF(h.letter_code))'');
    populated_letter_code_pcnt := AVE(GROUP,IF(h.letter_code = (TYPEOF(h.letter_code))'',0,100));
    maxlength_letter_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.letter_code)));
    avelength_letter_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.letter_code)),h.letter_code<>(typeof(h.letter_code))'');
    populated_unique_id_cnt := COUNT(GROUP,h.unique_id <> (TYPEOF(h.unique_id))'');
    populated_unique_id_pcnt := AVE(GROUP,IF(h.unique_id = (TYPEOF(h.unique_id))'',0,100));
    maxlength_unique_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.unique_id)));
    avelength_unique_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.unique_id)),h.unique_id<>(typeof(h.unique_id))'');
    populated_orig_rec_type_cnt := COUNT(GROUP,h.orig_rec_type <> (TYPEOF(h.orig_rec_type))'');
    populated_orig_rec_type_pcnt := AVE(GROUP,IF(h.orig_rec_type = (TYPEOF(h.orig_rec_type))'',0,100));
    maxlength_orig_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_rec_type)));
    avelength_orig_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_rec_type)),h.orig_rec_type<>(typeof(h.orig_rec_type))'');
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_street1_cnt := COUNT(GROUP,h.street1 <> (TYPEOF(h.street1))'');
    populated_street1_pcnt := AVE(GROUP,IF(h.street1 = (TYPEOF(h.street1))'',0,100));
    maxlength_street1 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street1)));
    avelength_street1 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street1)),h.street1<>(typeof(h.street1))'');
    populated_street2_cnt := COUNT(GROUP,h.street2 <> (TYPEOF(h.street2))'');
    populated_street2_pcnt := AVE(GROUP,IF(h.street2 = (TYPEOF(h.street2))'',0,100));
    maxlength_street2 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.street2)));
    avelength_street2 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.street2)),h.street2<>(typeof(h.street2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_code_cnt := COUNT(GROUP,h.zip_code <> (TYPEOF(h.zip_code))'');
    populated_zip_code_pcnt := AVE(GROUP,IF(h.zip_code = (TYPEOF(h.zip_code))'',0,100));
    maxlength_zip_code := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)));
    avelength_zip_code := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip_code)),h.zip_code<>(typeof(h.zip_code))'');
    populated_country_cnt := COUNT(GROUP,h.country <> (TYPEOF(h.country))'');
    populated_country_pcnt := AVE(GROUP,IF(h.country = (TYPEOF(h.country))'',0,100));
    maxlength_country := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.country)));
    avelength_country := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.country)),h.country<>(typeof(h.country))'');
    populated_region_cnt := COUNT(GROUP,h.region <> (TYPEOF(h.region))'');
    populated_region_pcnt := AVE(GROUP,IF(h.region = (TYPEOF(h.region))'',0,100));
    maxlength_region := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.region)));
    avelength_region := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.region)),h.region<>(typeof(h.region))'');
    populated_med_class_cnt := COUNT(GROUP,h.med_class <> (TYPEOF(h.med_class))'');
    populated_med_class_pcnt := AVE(GROUP,IF(h.med_class = (TYPEOF(h.med_class))'',0,100));
    maxlength_med_class := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_class)));
    avelength_med_class := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_class)),h.med_class<>(typeof(h.med_class))'');
    populated_med_date_cnt := COUNT(GROUP,h.med_date <> (TYPEOF(h.med_date))'');
    populated_med_date_pcnt := AVE(GROUP,IF(h.med_date = (TYPEOF(h.med_date))'',0,100));
    maxlength_med_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_date)));
    avelength_med_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_date)),h.med_date<>(typeof(h.med_date))'');
    populated_med_exp_date_cnt := COUNT(GROUP,h.med_exp_date <> (TYPEOF(h.med_exp_date))'');
    populated_med_exp_date_pcnt := AVE(GROUP,IF(h.med_exp_date = (TYPEOF(h.med_exp_date))'',0,100));
    maxlength_med_exp_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_exp_date)));
    avelength_med_exp_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.med_exp_date)),h.med_exp_date<>(typeof(h.med_exp_date))'');
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
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
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
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_county_cnt := COUNT(GROUP,h.county <> (TYPEOF(h.county))'');
    populated_county_pcnt := AVE(GROUP,IF(h.county = (TYPEOF(h.county))'',0,100));
    maxlength_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)));
    avelength_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county)),h.county<>(typeof(h.county))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
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
    populated_oer_cnt := COUNT(GROUP,h.oer <> (TYPEOF(h.oer))'');
    populated_oer_pcnt := AVE(GROUP,IF(h.oer = (TYPEOF(h.oer))'',0,100));
    maxlength_oer := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.oer)));
    avelength_oer := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.oer)),h.oer<>(typeof(h.oer))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source)),h.source<>(typeof(h.source))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_d_score_pcnt *   0.00 / 100 + T.Populated_best_ssn_pcnt *   0.00 / 100 + T.Populated_did_out_pcnt *   0.00 / 100 + T.Populated_date_first_seen_pcnt *   0.00 / 100 + T.Populated_date_last_seen_pcnt *   0.00 / 100 + T.Populated_current_flag_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_letter_code_pcnt *   0.00 / 100 + T.Populated_unique_id_pcnt *   0.00 / 100 + T.Populated_orig_rec_type_pcnt *   0.00 / 100 + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_street1_pcnt *   0.00 / 100 + T.Populated_street2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_code_pcnt *   0.00 / 100 + T.Populated_country_pcnt *   0.00 / 100 + T.Populated_region_pcnt *   0.00 / 100 + T.Populated_med_class_pcnt *   0.00 / 100 + T.Populated_med_date_pcnt *   0.00 / 100 + T.Populated_med_exp_date_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_oer_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'d_score','best_ssn','did_out','date_first_seen','date_last_seen','current_flag','record_type','letter_code','unique_id','orig_rec_type','orig_fname','orig_lname','street1','street2','city','state','zip_code','country','region','med_class','med_date','med_exp_date','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','county_name','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','oer','source');
  SELF.populated_pcnt := CHOOSE(C,le.populated_d_score_pcnt,le.populated_best_ssn_pcnt,le.populated_did_out_pcnt,le.populated_date_first_seen_pcnt,le.populated_date_last_seen_pcnt,le.populated_current_flag_pcnt,le.populated_record_type_pcnt,le.populated_letter_code_pcnt,le.populated_unique_id_pcnt,le.populated_orig_rec_type_pcnt,le.populated_orig_fname_pcnt,le.populated_orig_lname_pcnt,le.populated_street1_pcnt,le.populated_street2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_code_pcnt,le.populated_country_pcnt,le.populated_region_pcnt,le.populated_med_class_pcnt,le.populated_med_date_pcnt,le.populated_med_exp_date_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_county_pcnt,le.populated_county_name_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_oer_pcnt,le.populated_source_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_d_score,le.maxlength_best_ssn,le.maxlength_did_out,le.maxlength_date_first_seen,le.maxlength_date_last_seen,le.maxlength_current_flag,le.maxlength_record_type,le.maxlength_letter_code,le.maxlength_unique_id,le.maxlength_orig_rec_type,le.maxlength_orig_fname,le.maxlength_orig_lname,le.maxlength_street1,le.maxlength_street2,le.maxlength_city,le.maxlength_state,le.maxlength_zip_code,le.maxlength_country,le.maxlength_region,le.maxlength_med_class,le.maxlength_med_date,le.maxlength_med_exp_date,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_county,le.maxlength_county_name,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_oer,le.maxlength_source);
  SELF.avelength := CHOOSE(C,le.avelength_d_score,le.avelength_best_ssn,le.avelength_did_out,le.avelength_date_first_seen,le.avelength_date_last_seen,le.avelength_current_flag,le.avelength_record_type,le.avelength_letter_code,le.avelength_unique_id,le.avelength_orig_rec_type,le.avelength_orig_fname,le.avelength_orig_lname,le.avelength_street1,le.avelength_street2,le.avelength_city,le.avelength_state,le.avelength_zip_code,le.avelength_country,le.avelength_region,le.avelength_med_class,le.avelength_med_date,le.avelength_med_exp_date,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_county,le.avelength_county_name,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_oer,le.avelength_source);
END;
EXPORT invSummary := NORMALIZE(summary0, 57, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.d_score),TRIM((SALT38.StrType)le.best_ssn),TRIM((SALT38.StrType)le.did_out),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.letter_code),TRIM((SALT38.StrType)le.unique_id),TRIM((SALT38.StrType)le.orig_rec_type),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.street1),TRIM((SALT38.StrType)le.street2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.region),TRIM((SALT38.StrType)le.med_class),TRIM((SALT38.StrType)le.med_date),TRIM((SALT38.StrType)le.med_exp_date),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.oer),TRIM((SALT38.StrType)le.source)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,57,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 57);
  SELF.FldNo2 := 1 + (C % 57);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.d_score),TRIM((SALT38.StrType)le.best_ssn),TRIM((SALT38.StrType)le.did_out),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.letter_code),TRIM((SALT38.StrType)le.unique_id),TRIM((SALT38.StrType)le.orig_rec_type),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.street1),TRIM((SALT38.StrType)le.street2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.region),TRIM((SALT38.StrType)le.med_class),TRIM((SALT38.StrType)le.med_date),TRIM((SALT38.StrType)le.med_exp_date),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.oer),TRIM((SALT38.StrType)le.source)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.d_score),TRIM((SALT38.StrType)le.best_ssn),TRIM((SALT38.StrType)le.did_out),TRIM((SALT38.StrType)le.date_first_seen),TRIM((SALT38.StrType)le.date_last_seen),TRIM((SALT38.StrType)le.current_flag),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.letter_code),TRIM((SALT38.StrType)le.unique_id),TRIM((SALT38.StrType)le.orig_rec_type),TRIM((SALT38.StrType)le.orig_fname),TRIM((SALT38.StrType)le.orig_lname),TRIM((SALT38.StrType)le.street1),TRIM((SALT38.StrType)le.street2),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zip_code),TRIM((SALT38.StrType)le.country),TRIM((SALT38.StrType)le.region),TRIM((SALT38.StrType)le.med_class),TRIM((SALT38.StrType)le.med_date),TRIM((SALT38.StrType)le.med_exp_date),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.rec_type),TRIM((SALT38.StrType)le.ace_fips_st),TRIM((SALT38.StrType)le.county),TRIM((SALT38.StrType)le.county_name),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.msa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.err_stat),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.oer),TRIM((SALT38.StrType)le.source)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),57*57,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'d_score'}
      ,{2,'best_ssn'}
      ,{3,'did_out'}
      ,{4,'date_first_seen'}
      ,{5,'date_last_seen'}
      ,{6,'current_flag'}
      ,{7,'record_type'}
      ,{8,'letter_code'}
      ,{9,'unique_id'}
      ,{10,'orig_rec_type'}
      ,{11,'orig_fname'}
      ,{12,'orig_lname'}
      ,{13,'street1'}
      ,{14,'street2'}
      ,{15,'city'}
      ,{16,'state'}
      ,{17,'zip_code'}
      ,{18,'country'}
      ,{19,'region'}
      ,{20,'med_class'}
      ,{21,'med_date'}
      ,{22,'med_exp_date'}
      ,{23,'prim_range'}
      ,{24,'predir'}
      ,{25,'prim_name'}
      ,{26,'suffix'}
      ,{27,'postdir'}
      ,{28,'unit_desig'}
      ,{29,'sec_range'}
      ,{30,'p_city_name'}
      ,{31,'v_city_name'}
      ,{32,'st'}
      ,{33,'zip'}
      ,{34,'zip4'}
      ,{35,'cart'}
      ,{36,'cr_sort_sz'}
      ,{37,'lot'}
      ,{38,'lot_order'}
      ,{39,'dpbc'}
      ,{40,'chk_digit'}
      ,{41,'rec_type'}
      ,{42,'ace_fips_st'}
      ,{43,'county'}
      ,{44,'county_name'}
      ,{45,'geo_lat'}
      ,{46,'geo_long'}
      ,{47,'msa'}
      ,{48,'geo_blk'}
      ,{49,'geo_match'}
      ,{50,'err_stat'}
      ,{51,'title'}
      ,{52,'fname'}
      ,{53,'mname'}
      ,{54,'lname'}
      ,{55,'name_suffix'}
      ,{56,'oer'}
      ,{57,'source'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Airmen_Fields.InValid_d_score((SALT38.StrType)le.d_score),
    Airmen_Fields.InValid_best_ssn((SALT38.StrType)le.best_ssn),
    Airmen_Fields.InValid_did_out((SALT38.StrType)le.did_out),
    Airmen_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen),
    Airmen_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen),
    Airmen_Fields.InValid_current_flag((SALT38.StrType)le.current_flag),
    Airmen_Fields.InValid_record_type((SALT38.StrType)le.record_type),
    Airmen_Fields.InValid_letter_code((SALT38.StrType)le.letter_code),
    Airmen_Fields.InValid_unique_id((SALT38.StrType)le.unique_id),
    Airmen_Fields.InValid_orig_rec_type((SALT38.StrType)le.orig_rec_type),
    Airmen_Fields.InValid_orig_fname((SALT38.StrType)le.orig_fname),
    Airmen_Fields.InValid_orig_lname((SALT38.StrType)le.orig_lname),
    Airmen_Fields.InValid_street1((SALT38.StrType)le.street1),
    Airmen_Fields.InValid_street2((SALT38.StrType)le.street2),
    Airmen_Fields.InValid_city((SALT38.StrType)le.city),
    Airmen_Fields.InValid_state((SALT38.StrType)le.state),
    Airmen_Fields.InValid_zip_code((SALT38.StrType)le.zip_code),
    Airmen_Fields.InValid_country((SALT38.StrType)le.country),
    Airmen_Fields.InValid_region((SALT38.StrType)le.region),
    Airmen_Fields.InValid_med_class((SALT38.StrType)le.med_class),
    Airmen_Fields.InValid_med_date((SALT38.StrType)le.med_date),
    Airmen_Fields.InValid_med_exp_date((SALT38.StrType)le.med_exp_date),
    Airmen_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    Airmen_Fields.InValid_predir((SALT38.StrType)le.predir),
    Airmen_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    Airmen_Fields.InValid_suffix((SALT38.StrType)le.suffix),
    Airmen_Fields.InValid_postdir((SALT38.StrType)le.postdir),
    Airmen_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    Airmen_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    Airmen_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    Airmen_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    Airmen_Fields.InValid_st((SALT38.StrType)le.st),
    Airmen_Fields.InValid_zip((SALT38.StrType)le.zip),
    Airmen_Fields.InValid_zip4((SALT38.StrType)le.zip4),
    Airmen_Fields.InValid_cart((SALT38.StrType)le.cart),
    Airmen_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    Airmen_Fields.InValid_lot((SALT38.StrType)le.lot),
    Airmen_Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    Airmen_Fields.InValid_dpbc((SALT38.StrType)le.dpbc),
    Airmen_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    Airmen_Fields.InValid_rec_type((SALT38.StrType)le.rec_type),
    Airmen_Fields.InValid_ace_fips_st((SALT38.StrType)le.ace_fips_st),
    Airmen_Fields.InValid_county((SALT38.StrType)le.county),
    Airmen_Fields.InValid_county_name((SALT38.StrType)le.county_name),
    Airmen_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    Airmen_Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    Airmen_Fields.InValid_msa((SALT38.StrType)le.msa),
    Airmen_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    Airmen_Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    Airmen_Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    Airmen_Fields.InValid_title((SALT38.StrType)le.title),
    Airmen_Fields.InValid_fname((SALT38.StrType)le.fname),
    Airmen_Fields.InValid_mname((SALT38.StrType)le.mname),
    Airmen_Fields.InValid_lname((SALT38.StrType)le.lname),
    Airmen_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    Airmen_Fields.InValid_oer((SALT38.StrType)le.oer),
    Airmen_Fields.InValid_source((SALT38.StrType)le.source),
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
  FieldNme := Airmen_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_SSN','Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Flag','Unknown','Invalid_LetterCode','Invalid_Num','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Letter','Unknown','Unknown','Invalid_Letter','Invalid_MedClass','Invalid_MedDate','Invalid_MedDate','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Airmen_Fields.InValidMessage_d_score(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_best_ssn(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_did_out(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_date_first_seen(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_date_last_seen(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_current_flag(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_letter_code(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_unique_id(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_orig_rec_type(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_street1(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_street2(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_city(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_state(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_zip_code(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_country(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_region(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_med_class(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_med_date(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_med_exp_date(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_st(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_zip(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_county(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_title(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_oer(TotalErrors.ErrorNum),Airmen_Fields.InValidMessage_source(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FAA, Airmen_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
