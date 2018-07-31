IMPORT SALT311,STD;
EXPORT Ingest_hygiene(dataset(Ingest_layout_BIPV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.source_expanded))'', MAX(GROUP,h.source_expanded));
    NumberOfRecords := COUNT(GROUP);
    populated_source_expanded_cnt := COUNT(GROUP,h.source_expanded <> (TYPEOF(h.source_expanded))'');
    populated_source_expanded_pcnt := AVE(GROUP,IF(h.source_expanded = (TYPEOF(h.source_expanded))'',0,100));
    maxlength_source_expanded := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_expanded)));
    avelength_source_expanded := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_expanded)),h.source_expanded<>(typeof(h.source_expanded))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
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
    populated_rcid_cnt := COUNT(GROUP,h.rcid <> (TYPEOF(h.rcid))'');
    populated_rcid_pcnt := AVE(GROUP,IF(h.rcid = (TYPEOF(h.rcid))'',0,100));
    maxlength_rcid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rcid)));
    avelength_rcid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rcid)),h.rcid<>(typeof(h.rcid))'');
    populated_company_bdid_cnt := COUNT(GROUP,h.company_bdid <> (TYPEOF(h.company_bdid))'');
    populated_company_bdid_pcnt := AVE(GROUP,IF(h.company_bdid = (TYPEOF(h.company_bdid))'',0,100));
    maxlength_company_bdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_bdid)));
    avelength_company_bdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_bdid)),h.company_bdid<>(typeof(h.company_bdid))'');
    populated_company_name_cnt := COUNT(GROUP,h.company_name <> (TYPEOF(h.company_name))'');
    populated_company_name_pcnt := AVE(GROUP,IF(h.company_name = (TYPEOF(h.company_name))'',0,100));
    maxlength_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)));
    avelength_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name)),h.company_name<>(typeof(h.company_name))'');
    populated_company_name_type_raw_cnt := COUNT(GROUP,h.company_name_type_raw <> (TYPEOF(h.company_name_type_raw))'');
    populated_company_name_type_raw_pcnt := AVE(GROUP,IF(h.company_name_type_raw = (TYPEOF(h.company_name_type_raw))'',0,100));
    maxlength_company_name_type_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_raw)));
    avelength_company_name_type_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_raw)),h.company_name_type_raw<>(typeof(h.company_name_type_raw))'');
    populated_company_rawaid_cnt := COUNT(GROUP,h.company_rawaid <> (TYPEOF(h.company_rawaid))'');
    populated_company_rawaid_pcnt := AVE(GROUP,IF(h.company_rawaid = (TYPEOF(h.company_rawaid))'',0,100));
    maxlength_company_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_rawaid)));
    avelength_company_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_rawaid)),h.company_rawaid<>(typeof(h.company_rawaid))'');
    populated_company_address_prim_range_cnt := COUNT(GROUP,h.company_address_prim_range <> (TYPEOF(h.company_address_prim_range))'');
    populated_company_address_prim_range_pcnt := AVE(GROUP,IF(h.company_address_prim_range = (TYPEOF(h.company_address_prim_range))'',0,100));
    maxlength_company_address_prim_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_prim_range)));
    avelength_company_address_prim_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_prim_range)),h.company_address_prim_range<>(typeof(h.company_address_prim_range))'');
    populated_company_address_predir_cnt := COUNT(GROUP,h.company_address_predir <> (TYPEOF(h.company_address_predir))'');
    populated_company_address_predir_pcnt := AVE(GROUP,IF(h.company_address_predir = (TYPEOF(h.company_address_predir))'',0,100));
    maxlength_company_address_predir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_predir)));
    avelength_company_address_predir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_predir)),h.company_address_predir<>(typeof(h.company_address_predir))'');
    populated_company_address_prim_name_cnt := COUNT(GROUP,h.company_address_prim_name <> (TYPEOF(h.company_address_prim_name))'');
    populated_company_address_prim_name_pcnt := AVE(GROUP,IF(h.company_address_prim_name = (TYPEOF(h.company_address_prim_name))'',0,100));
    maxlength_company_address_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_prim_name)));
    avelength_company_address_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_prim_name)),h.company_address_prim_name<>(typeof(h.company_address_prim_name))'');
    populated_company_address_addr_suffix_cnt := COUNT(GROUP,h.company_address_addr_suffix <> (TYPEOF(h.company_address_addr_suffix))'');
    populated_company_address_addr_suffix_pcnt := AVE(GROUP,IF(h.company_address_addr_suffix = (TYPEOF(h.company_address_addr_suffix))'',0,100));
    maxlength_company_address_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_addr_suffix)));
    avelength_company_address_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_addr_suffix)),h.company_address_addr_suffix<>(typeof(h.company_address_addr_suffix))'');
    populated_company_address_postdir_cnt := COUNT(GROUP,h.company_address_postdir <> (TYPEOF(h.company_address_postdir))'');
    populated_company_address_postdir_pcnt := AVE(GROUP,IF(h.company_address_postdir = (TYPEOF(h.company_address_postdir))'',0,100));
    maxlength_company_address_postdir := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_postdir)));
    avelength_company_address_postdir := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_postdir)),h.company_address_postdir<>(typeof(h.company_address_postdir))'');
    populated_company_address_unit_desig_cnt := COUNT(GROUP,h.company_address_unit_desig <> (TYPEOF(h.company_address_unit_desig))'');
    populated_company_address_unit_desig_pcnt := AVE(GROUP,IF(h.company_address_unit_desig = (TYPEOF(h.company_address_unit_desig))'',0,100));
    maxlength_company_address_unit_desig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_unit_desig)));
    avelength_company_address_unit_desig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_unit_desig)),h.company_address_unit_desig<>(typeof(h.company_address_unit_desig))'');
    populated_company_address_sec_range_cnt := COUNT(GROUP,h.company_address_sec_range <> (TYPEOF(h.company_address_sec_range))'');
    populated_company_address_sec_range_pcnt := AVE(GROUP,IF(h.company_address_sec_range = (TYPEOF(h.company_address_sec_range))'',0,100));
    maxlength_company_address_sec_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_sec_range)));
    avelength_company_address_sec_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_sec_range)),h.company_address_sec_range<>(typeof(h.company_address_sec_range))'');
    populated_company_address_p_city_name_cnt := COUNT(GROUP,h.company_address_p_city_name <> (TYPEOF(h.company_address_p_city_name))'');
    populated_company_address_p_city_name_pcnt := AVE(GROUP,IF(h.company_address_p_city_name = (TYPEOF(h.company_address_p_city_name))'',0,100));
    maxlength_company_address_p_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_p_city_name)));
    avelength_company_address_p_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_p_city_name)),h.company_address_p_city_name<>(typeof(h.company_address_p_city_name))'');
    populated_company_address_v_city_name_cnt := COUNT(GROUP,h.company_address_v_city_name <> (TYPEOF(h.company_address_v_city_name))'');
    populated_company_address_v_city_name_pcnt := AVE(GROUP,IF(h.company_address_v_city_name = (TYPEOF(h.company_address_v_city_name))'',0,100));
    maxlength_company_address_v_city_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_v_city_name)));
    avelength_company_address_v_city_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_v_city_name)),h.company_address_v_city_name<>(typeof(h.company_address_v_city_name))'');
    populated_company_address_st_cnt := COUNT(GROUP,h.company_address_st <> (TYPEOF(h.company_address_st))'');
    populated_company_address_st_pcnt := AVE(GROUP,IF(h.company_address_st = (TYPEOF(h.company_address_st))'',0,100));
    maxlength_company_address_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_st)));
    avelength_company_address_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_st)),h.company_address_st<>(typeof(h.company_address_st))'');
    populated_company_address_zip_cnt := COUNT(GROUP,h.company_address_zip <> (TYPEOF(h.company_address_zip))'');
    populated_company_address_zip_pcnt := AVE(GROUP,IF(h.company_address_zip = (TYPEOF(h.company_address_zip))'',0,100));
    maxlength_company_address_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_zip)));
    avelength_company_address_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_zip)),h.company_address_zip<>(typeof(h.company_address_zip))'');
    populated_company_address_zip4_cnt := COUNT(GROUP,h.company_address_zip4 <> (TYPEOF(h.company_address_zip4))'');
    populated_company_address_zip4_pcnt := AVE(GROUP,IF(h.company_address_zip4 = (TYPEOF(h.company_address_zip4))'',0,100));
    maxlength_company_address_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_zip4)));
    avelength_company_address_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_zip4)),h.company_address_zip4<>(typeof(h.company_address_zip4))'');
    populated_company_address_cart_cnt := COUNT(GROUP,h.company_address_cart <> (TYPEOF(h.company_address_cart))'');
    populated_company_address_cart_pcnt := AVE(GROUP,IF(h.company_address_cart = (TYPEOF(h.company_address_cart))'',0,100));
    maxlength_company_address_cart := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_cart)));
    avelength_company_address_cart := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_cart)),h.company_address_cart<>(typeof(h.company_address_cart))'');
    populated_company_address_cr_sort_sz_cnt := COUNT(GROUP,h.company_address_cr_sort_sz <> (TYPEOF(h.company_address_cr_sort_sz))'');
    populated_company_address_cr_sort_sz_pcnt := AVE(GROUP,IF(h.company_address_cr_sort_sz = (TYPEOF(h.company_address_cr_sort_sz))'',0,100));
    maxlength_company_address_cr_sort_sz := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_cr_sort_sz)));
    avelength_company_address_cr_sort_sz := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_cr_sort_sz)),h.company_address_cr_sort_sz<>(typeof(h.company_address_cr_sort_sz))'');
    populated_company_address_lot_cnt := COUNT(GROUP,h.company_address_lot <> (TYPEOF(h.company_address_lot))'');
    populated_company_address_lot_pcnt := AVE(GROUP,IF(h.company_address_lot = (TYPEOF(h.company_address_lot))'',0,100));
    maxlength_company_address_lot := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_lot)));
    avelength_company_address_lot := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_lot)),h.company_address_lot<>(typeof(h.company_address_lot))'');
    populated_company_address_lot_order_cnt := COUNT(GROUP,h.company_address_lot_order <> (TYPEOF(h.company_address_lot_order))'');
    populated_company_address_lot_order_pcnt := AVE(GROUP,IF(h.company_address_lot_order = (TYPEOF(h.company_address_lot_order))'',0,100));
    maxlength_company_address_lot_order := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_lot_order)));
    avelength_company_address_lot_order := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_lot_order)),h.company_address_lot_order<>(typeof(h.company_address_lot_order))'');
    populated_company_address_dbpc_cnt := COUNT(GROUP,h.company_address_dbpc <> (TYPEOF(h.company_address_dbpc))'');
    populated_company_address_dbpc_pcnt := AVE(GROUP,IF(h.company_address_dbpc = (TYPEOF(h.company_address_dbpc))'',0,100));
    maxlength_company_address_dbpc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_dbpc)));
    avelength_company_address_dbpc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_dbpc)),h.company_address_dbpc<>(typeof(h.company_address_dbpc))'');
    populated_company_address_chk_digit_cnt := COUNT(GROUP,h.company_address_chk_digit <> (TYPEOF(h.company_address_chk_digit))'');
    populated_company_address_chk_digit_pcnt := AVE(GROUP,IF(h.company_address_chk_digit = (TYPEOF(h.company_address_chk_digit))'',0,100));
    maxlength_company_address_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_chk_digit)));
    avelength_company_address_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_chk_digit)),h.company_address_chk_digit<>(typeof(h.company_address_chk_digit))'');
    populated_company_address_rec_type_cnt := COUNT(GROUP,h.company_address_rec_type <> (TYPEOF(h.company_address_rec_type))'');
    populated_company_address_rec_type_pcnt := AVE(GROUP,IF(h.company_address_rec_type = (TYPEOF(h.company_address_rec_type))'',0,100));
    maxlength_company_address_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_rec_type)));
    avelength_company_address_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_rec_type)),h.company_address_rec_type<>(typeof(h.company_address_rec_type))'');
    populated_company_address_fips_state_cnt := COUNT(GROUP,h.company_address_fips_state <> (TYPEOF(h.company_address_fips_state))'');
    populated_company_address_fips_state_pcnt := AVE(GROUP,IF(h.company_address_fips_state = (TYPEOF(h.company_address_fips_state))'',0,100));
    maxlength_company_address_fips_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_fips_state)));
    avelength_company_address_fips_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_fips_state)),h.company_address_fips_state<>(typeof(h.company_address_fips_state))'');
    populated_company_address_fips_county_cnt := COUNT(GROUP,h.company_address_fips_county <> (TYPEOF(h.company_address_fips_county))'');
    populated_company_address_fips_county_pcnt := AVE(GROUP,IF(h.company_address_fips_county = (TYPEOF(h.company_address_fips_county))'',0,100));
    maxlength_company_address_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_fips_county)));
    avelength_company_address_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_fips_county)),h.company_address_fips_county<>(typeof(h.company_address_fips_county))'');
    populated_company_address_geo_lat_cnt := COUNT(GROUP,h.company_address_geo_lat <> (TYPEOF(h.company_address_geo_lat))'');
    populated_company_address_geo_lat_pcnt := AVE(GROUP,IF(h.company_address_geo_lat = (TYPEOF(h.company_address_geo_lat))'',0,100));
    maxlength_company_address_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_geo_lat)));
    avelength_company_address_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_geo_lat)),h.company_address_geo_lat<>(typeof(h.company_address_geo_lat))'');
    populated_company_address_geo_long_cnt := COUNT(GROUP,h.company_address_geo_long <> (TYPEOF(h.company_address_geo_long))'');
    populated_company_address_geo_long_pcnt := AVE(GROUP,IF(h.company_address_geo_long = (TYPEOF(h.company_address_geo_long))'',0,100));
    maxlength_company_address_geo_long := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_geo_long)));
    avelength_company_address_geo_long := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_geo_long)),h.company_address_geo_long<>(typeof(h.company_address_geo_long))'');
    populated_company_address_msa_cnt := COUNT(GROUP,h.company_address_msa <> (TYPEOF(h.company_address_msa))'');
    populated_company_address_msa_pcnt := AVE(GROUP,IF(h.company_address_msa = (TYPEOF(h.company_address_msa))'',0,100));
    maxlength_company_address_msa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_msa)));
    avelength_company_address_msa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_msa)),h.company_address_msa<>(typeof(h.company_address_msa))'');
    populated_company_address_geo_blk_cnt := COUNT(GROUP,h.company_address_geo_blk <> (TYPEOF(h.company_address_geo_blk))'');
    populated_company_address_geo_blk_pcnt := AVE(GROUP,IF(h.company_address_geo_blk = (TYPEOF(h.company_address_geo_blk))'',0,100));
    maxlength_company_address_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_geo_blk)));
    avelength_company_address_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_geo_blk)),h.company_address_geo_blk<>(typeof(h.company_address_geo_blk))'');
    populated_company_address_geo_match_cnt := COUNT(GROUP,h.company_address_geo_match <> (TYPEOF(h.company_address_geo_match))'');
    populated_company_address_geo_match_pcnt := AVE(GROUP,IF(h.company_address_geo_match = (TYPEOF(h.company_address_geo_match))'',0,100));
    maxlength_company_address_geo_match := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_geo_match)));
    avelength_company_address_geo_match := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_geo_match)),h.company_address_geo_match<>(typeof(h.company_address_geo_match))'');
    populated_company_address_err_stat_cnt := COUNT(GROUP,h.company_address_err_stat <> (TYPEOF(h.company_address_err_stat))'');
    populated_company_address_err_stat_pcnt := AVE(GROUP,IF(h.company_address_err_stat = (TYPEOF(h.company_address_err_stat))'',0,100));
    maxlength_company_address_err_stat := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_err_stat)));
    avelength_company_address_err_stat := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_err_stat)),h.company_address_err_stat<>(typeof(h.company_address_err_stat))'');
    populated_company_address_type_raw_cnt := COUNT(GROUP,h.company_address_type_raw <> (TYPEOF(h.company_address_type_raw))'');
    populated_company_address_type_raw_pcnt := AVE(GROUP,IF(h.company_address_type_raw = (TYPEOF(h.company_address_type_raw))'',0,100));
    maxlength_company_address_type_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_type_raw)));
    avelength_company_address_type_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_type_raw)),h.company_address_type_raw<>(typeof(h.company_address_type_raw))'');
    populated_company_address_category_cnt := COUNT(GROUP,h.company_address_category <> (TYPEOF(h.company_address_category))'');
    populated_company_address_category_pcnt := AVE(GROUP,IF(h.company_address_category = (TYPEOF(h.company_address_category))'',0,100));
    maxlength_company_address_category := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_category)));
    avelength_company_address_category := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_category)),h.company_address_category<>(typeof(h.company_address_category))'');
    populated_company_address_country_code_cnt := COUNT(GROUP,h.company_address_country_code <> (TYPEOF(h.company_address_country_code))'');
    populated_company_address_country_code_pcnt := AVE(GROUP,IF(h.company_address_country_code = (TYPEOF(h.company_address_country_code))'',0,100));
    maxlength_company_address_country_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_country_code)));
    avelength_company_address_country_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_country_code)),h.company_address_country_code<>(typeof(h.company_address_country_code))'');
    populated_company_fein_cnt := COUNT(GROUP,h.company_fein <> (TYPEOF(h.company_fein))'');
    populated_company_fein_pcnt := AVE(GROUP,IF(h.company_fein = (TYPEOF(h.company_fein))'',0,100));
    maxlength_company_fein := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_fein)));
    avelength_company_fein := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_fein)),h.company_fein<>(typeof(h.company_fein))'');
    populated_best_fein_indicator_cnt := COUNT(GROUP,h.best_fein_indicator <> (TYPEOF(h.best_fein_indicator))'');
    populated_best_fein_indicator_pcnt := AVE(GROUP,IF(h.best_fein_indicator = (TYPEOF(h.best_fein_indicator))'',0,100));
    maxlength_best_fein_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_fein_indicator)));
    avelength_best_fein_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.best_fein_indicator)),h.best_fein_indicator<>(typeof(h.best_fein_indicator))'');
    populated_company_phone_cnt := COUNT(GROUP,h.company_phone <> (TYPEOF(h.company_phone))'');
    populated_company_phone_pcnt := AVE(GROUP,IF(h.company_phone = (TYPEOF(h.company_phone))'',0,100));
    maxlength_company_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_phone)));
    avelength_company_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_phone)),h.company_phone<>(typeof(h.company_phone))'');
    populated_phone_type_cnt := COUNT(GROUP,h.phone_type <> (TYPEOF(h.phone_type))'');
    populated_phone_type_pcnt := AVE(GROUP,IF(h.phone_type = (TYPEOF(h.phone_type))'',0,100));
    maxlength_phone_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)));
    avelength_phone_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_type)),h.phone_type<>(typeof(h.phone_type))'');
    populated_company_org_structure_raw_cnt := COUNT(GROUP,h.company_org_structure_raw <> (TYPEOF(h.company_org_structure_raw))'');
    populated_company_org_structure_raw_pcnt := AVE(GROUP,IF(h.company_org_structure_raw = (TYPEOF(h.company_org_structure_raw))'',0,100));
    maxlength_company_org_structure_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_org_structure_raw)));
    avelength_company_org_structure_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_org_structure_raw)),h.company_org_structure_raw<>(typeof(h.company_org_structure_raw))'');
    populated_company_incorporation_date_cnt := COUNT(GROUP,h.company_incorporation_date <> (TYPEOF(h.company_incorporation_date))'');
    populated_company_incorporation_date_pcnt := AVE(GROUP,IF(h.company_incorporation_date = (TYPEOF(h.company_incorporation_date))'',0,100));
    maxlength_company_incorporation_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_incorporation_date)));
    avelength_company_incorporation_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_incorporation_date)),h.company_incorporation_date<>(typeof(h.company_incorporation_date))'');
    populated_company_sic_code1_cnt := COUNT(GROUP,h.company_sic_code1 <> (TYPEOF(h.company_sic_code1))'');
    populated_company_sic_code1_pcnt := AVE(GROUP,IF(h.company_sic_code1 = (TYPEOF(h.company_sic_code1))'',0,100));
    maxlength_company_sic_code1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code1)));
    avelength_company_sic_code1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code1)),h.company_sic_code1<>(typeof(h.company_sic_code1))'');
    populated_company_sic_code2_cnt := COUNT(GROUP,h.company_sic_code2 <> (TYPEOF(h.company_sic_code2))'');
    populated_company_sic_code2_pcnt := AVE(GROUP,IF(h.company_sic_code2 = (TYPEOF(h.company_sic_code2))'',0,100));
    maxlength_company_sic_code2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code2)));
    avelength_company_sic_code2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code2)),h.company_sic_code2<>(typeof(h.company_sic_code2))'');
    populated_company_sic_code3_cnt := COUNT(GROUP,h.company_sic_code3 <> (TYPEOF(h.company_sic_code3))'');
    populated_company_sic_code3_pcnt := AVE(GROUP,IF(h.company_sic_code3 = (TYPEOF(h.company_sic_code3))'',0,100));
    maxlength_company_sic_code3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code3)));
    avelength_company_sic_code3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code3)),h.company_sic_code3<>(typeof(h.company_sic_code3))'');
    populated_company_sic_code4_cnt := COUNT(GROUP,h.company_sic_code4 <> (TYPEOF(h.company_sic_code4))'');
    populated_company_sic_code4_pcnt := AVE(GROUP,IF(h.company_sic_code4 = (TYPEOF(h.company_sic_code4))'',0,100));
    maxlength_company_sic_code4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code4)));
    avelength_company_sic_code4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code4)),h.company_sic_code4<>(typeof(h.company_sic_code4))'');
    populated_company_sic_code5_cnt := COUNT(GROUP,h.company_sic_code5 <> (TYPEOF(h.company_sic_code5))'');
    populated_company_sic_code5_pcnt := AVE(GROUP,IF(h.company_sic_code5 = (TYPEOF(h.company_sic_code5))'',0,100));
    maxlength_company_sic_code5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code5)));
    avelength_company_sic_code5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_sic_code5)),h.company_sic_code5<>(typeof(h.company_sic_code5))'');
    populated_company_naics_code1_cnt := COUNT(GROUP,h.company_naics_code1 <> (TYPEOF(h.company_naics_code1))'');
    populated_company_naics_code1_pcnt := AVE(GROUP,IF(h.company_naics_code1 = (TYPEOF(h.company_naics_code1))'',0,100));
    maxlength_company_naics_code1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code1)));
    avelength_company_naics_code1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code1)),h.company_naics_code1<>(typeof(h.company_naics_code1))'');
    populated_company_naics_code2_cnt := COUNT(GROUP,h.company_naics_code2 <> (TYPEOF(h.company_naics_code2))'');
    populated_company_naics_code2_pcnt := AVE(GROUP,IF(h.company_naics_code2 = (TYPEOF(h.company_naics_code2))'',0,100));
    maxlength_company_naics_code2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code2)));
    avelength_company_naics_code2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code2)),h.company_naics_code2<>(typeof(h.company_naics_code2))'');
    populated_company_naics_code3_cnt := COUNT(GROUP,h.company_naics_code3 <> (TYPEOF(h.company_naics_code3))'');
    populated_company_naics_code3_pcnt := AVE(GROUP,IF(h.company_naics_code3 = (TYPEOF(h.company_naics_code3))'',0,100));
    maxlength_company_naics_code3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code3)));
    avelength_company_naics_code3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code3)),h.company_naics_code3<>(typeof(h.company_naics_code3))'');
    populated_company_naics_code4_cnt := COUNT(GROUP,h.company_naics_code4 <> (TYPEOF(h.company_naics_code4))'');
    populated_company_naics_code4_pcnt := AVE(GROUP,IF(h.company_naics_code4 = (TYPEOF(h.company_naics_code4))'',0,100));
    maxlength_company_naics_code4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code4)));
    avelength_company_naics_code4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code4)),h.company_naics_code4<>(typeof(h.company_naics_code4))'');
    populated_company_naics_code5_cnt := COUNT(GROUP,h.company_naics_code5 <> (TYPEOF(h.company_naics_code5))'');
    populated_company_naics_code5_pcnt := AVE(GROUP,IF(h.company_naics_code5 = (TYPEOF(h.company_naics_code5))'',0,100));
    maxlength_company_naics_code5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code5)));
    avelength_company_naics_code5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_naics_code5)),h.company_naics_code5<>(typeof(h.company_naics_code5))'');
    populated_company_ticker_cnt := COUNT(GROUP,h.company_ticker <> (TYPEOF(h.company_ticker))'');
    populated_company_ticker_pcnt := AVE(GROUP,IF(h.company_ticker = (TYPEOF(h.company_ticker))'',0,100));
    maxlength_company_ticker := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_ticker)));
    avelength_company_ticker := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_ticker)),h.company_ticker<>(typeof(h.company_ticker))'');
    populated_company_ticker_exchange_cnt := COUNT(GROUP,h.company_ticker_exchange <> (TYPEOF(h.company_ticker_exchange))'');
    populated_company_ticker_exchange_pcnt := AVE(GROUP,IF(h.company_ticker_exchange = (TYPEOF(h.company_ticker_exchange))'',0,100));
    maxlength_company_ticker_exchange := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_ticker_exchange)));
    avelength_company_ticker_exchange := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_ticker_exchange)),h.company_ticker_exchange<>(typeof(h.company_ticker_exchange))'');
    populated_company_foreign_domestic_cnt := COUNT(GROUP,h.company_foreign_domestic <> (TYPEOF(h.company_foreign_domestic))'');
    populated_company_foreign_domestic_pcnt := AVE(GROUP,IF(h.company_foreign_domestic = (TYPEOF(h.company_foreign_domestic))'',0,100));
    maxlength_company_foreign_domestic := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_foreign_domestic)));
    avelength_company_foreign_domestic := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_foreign_domestic)),h.company_foreign_domestic<>(typeof(h.company_foreign_domestic))'');
    populated_company_url_cnt := COUNT(GROUP,h.company_url <> (TYPEOF(h.company_url))'');
    populated_company_url_pcnt := AVE(GROUP,IF(h.company_url = (TYPEOF(h.company_url))'',0,100));
    maxlength_company_url := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_url)));
    avelength_company_url := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_url)),h.company_url<>(typeof(h.company_url))'');
    populated_company_inc_state_cnt := COUNT(GROUP,h.company_inc_state <> (TYPEOF(h.company_inc_state))'');
    populated_company_inc_state_pcnt := AVE(GROUP,IF(h.company_inc_state = (TYPEOF(h.company_inc_state))'',0,100));
    maxlength_company_inc_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_inc_state)));
    avelength_company_inc_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_inc_state)),h.company_inc_state<>(typeof(h.company_inc_state))'');
    populated_company_charter_number_cnt := COUNT(GROUP,h.company_charter_number <> (TYPEOF(h.company_charter_number))'');
    populated_company_charter_number_pcnt := AVE(GROUP,IF(h.company_charter_number = (TYPEOF(h.company_charter_number))'',0,100));
    maxlength_company_charter_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_charter_number)));
    avelength_company_charter_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_charter_number)),h.company_charter_number<>(typeof(h.company_charter_number))'');
    populated_company_filing_date_cnt := COUNT(GROUP,h.company_filing_date <> (TYPEOF(h.company_filing_date))'');
    populated_company_filing_date_pcnt := AVE(GROUP,IF(h.company_filing_date = (TYPEOF(h.company_filing_date))'',0,100));
    maxlength_company_filing_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_filing_date)));
    avelength_company_filing_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_filing_date)),h.company_filing_date<>(typeof(h.company_filing_date))'');
    populated_company_status_date_cnt := COUNT(GROUP,h.company_status_date <> (TYPEOF(h.company_status_date))'');
    populated_company_status_date_pcnt := AVE(GROUP,IF(h.company_status_date = (TYPEOF(h.company_status_date))'',0,100));
    maxlength_company_status_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_status_date)));
    avelength_company_status_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_status_date)),h.company_status_date<>(typeof(h.company_status_date))'');
    populated_company_foreign_date_cnt := COUNT(GROUP,h.company_foreign_date <> (TYPEOF(h.company_foreign_date))'');
    populated_company_foreign_date_pcnt := AVE(GROUP,IF(h.company_foreign_date = (TYPEOF(h.company_foreign_date))'',0,100));
    maxlength_company_foreign_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_foreign_date)));
    avelength_company_foreign_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_foreign_date)),h.company_foreign_date<>(typeof(h.company_foreign_date))'');
    populated_event_filing_date_cnt := COUNT(GROUP,h.event_filing_date <> (TYPEOF(h.event_filing_date))'');
    populated_event_filing_date_pcnt := AVE(GROUP,IF(h.event_filing_date = (TYPEOF(h.event_filing_date))'',0,100));
    maxlength_event_filing_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_filing_date)));
    avelength_event_filing_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_filing_date)),h.event_filing_date<>(typeof(h.event_filing_date))'');
    populated_company_name_status_raw_cnt := COUNT(GROUP,h.company_name_status_raw <> (TYPEOF(h.company_name_status_raw))'');
    populated_company_name_status_raw_pcnt := AVE(GROUP,IF(h.company_name_status_raw = (TYPEOF(h.company_name_status_raw))'',0,100));
    maxlength_company_name_status_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_status_raw)));
    avelength_company_name_status_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_status_raw)),h.company_name_status_raw<>(typeof(h.company_name_status_raw))'');
    populated_company_status_raw_cnt := COUNT(GROUP,h.company_status_raw <> (TYPEOF(h.company_status_raw))'');
    populated_company_status_raw_pcnt := AVE(GROUP,IF(h.company_status_raw = (TYPEOF(h.company_status_raw))'',0,100));
    maxlength_company_status_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_status_raw)));
    avelength_company_status_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_status_raw)),h.company_status_raw<>(typeof(h.company_status_raw))'');
    populated_dt_first_seen_company_name_cnt := COUNT(GROUP,h.dt_first_seen_company_name <> (TYPEOF(h.dt_first_seen_company_name))'');
    populated_dt_first_seen_company_name_pcnt := AVE(GROUP,IF(h.dt_first_seen_company_name = (TYPEOF(h.dt_first_seen_company_name))'',0,100));
    maxlength_dt_first_seen_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen_company_name)));
    avelength_dt_first_seen_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen_company_name)),h.dt_first_seen_company_name<>(typeof(h.dt_first_seen_company_name))'');
    populated_dt_last_seen_company_name_cnt := COUNT(GROUP,h.dt_last_seen_company_name <> (TYPEOF(h.dt_last_seen_company_name))'');
    populated_dt_last_seen_company_name_pcnt := AVE(GROUP,IF(h.dt_last_seen_company_name = (TYPEOF(h.dt_last_seen_company_name))'',0,100));
    maxlength_dt_last_seen_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen_company_name)));
    avelength_dt_last_seen_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen_company_name)),h.dt_last_seen_company_name<>(typeof(h.dt_last_seen_company_name))'');
    populated_dt_first_seen_company_address_cnt := COUNT(GROUP,h.dt_first_seen_company_address <> (TYPEOF(h.dt_first_seen_company_address))'');
    populated_dt_first_seen_company_address_pcnt := AVE(GROUP,IF(h.dt_first_seen_company_address = (TYPEOF(h.dt_first_seen_company_address))'',0,100));
    maxlength_dt_first_seen_company_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen_company_address)));
    avelength_dt_first_seen_company_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen_company_address)),h.dt_first_seen_company_address<>(typeof(h.dt_first_seen_company_address))'');
    populated_dt_last_seen_company_address_cnt := COUNT(GROUP,h.dt_last_seen_company_address <> (TYPEOF(h.dt_last_seen_company_address))'');
    populated_dt_last_seen_company_address_pcnt := AVE(GROUP,IF(h.dt_last_seen_company_address = (TYPEOF(h.dt_last_seen_company_address))'',0,100));
    maxlength_dt_last_seen_company_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen_company_address)));
    avelength_dt_last_seen_company_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen_company_address)),h.dt_last_seen_company_address<>(typeof(h.dt_last_seen_company_address))'');
    populated_vl_id_cnt := COUNT(GROUP,h.vl_id <> (TYPEOF(h.vl_id))'');
    populated_vl_id_pcnt := AVE(GROUP,IF(h.vl_id = (TYPEOF(h.vl_id))'',0,100));
    maxlength_vl_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vl_id)));
    avelength_vl_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vl_id)),h.vl_id<>(typeof(h.vl_id))'');
    populated_current_cnt := COUNT(GROUP,h.current <> (TYPEOF(h.current))'');
    populated_current_pcnt := AVE(GROUP,IF(h.current = (TYPEOF(h.current))'',0,100));
    maxlength_current := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current)));
    avelength_current := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current)),h.current<>(typeof(h.current))'');
    populated_source_record_id_cnt := COUNT(GROUP,h.source_record_id <> (TYPEOF(h.source_record_id))'');
    populated_source_record_id_pcnt := AVE(GROUP,IF(h.source_record_id = (TYPEOF(h.source_record_id))'',0,100));
    maxlength_source_record_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_record_id)));
    avelength_source_record_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_record_id)),h.source_record_id<>(typeof(h.source_record_id))'');
    populated_glb_cnt := COUNT(GROUP,h.glb <> (TYPEOF(h.glb))'');
    populated_glb_pcnt := AVE(GROUP,IF(h.glb = (TYPEOF(h.glb))'',0,100));
    maxlength_glb := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.glb)));
    avelength_glb := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.glb)),h.glb<>(typeof(h.glb))'');
    populated_dppa_cnt := COUNT(GROUP,h.dppa <> (TYPEOF(h.dppa))'');
    populated_dppa_pcnt := AVE(GROUP,IF(h.dppa = (TYPEOF(h.dppa))'',0,100));
    maxlength_dppa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dppa)));
    avelength_dppa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dppa)),h.dppa<>(typeof(h.dppa))'');
    populated_phone_score_cnt := COUNT(GROUP,h.phone_score <> (TYPEOF(h.phone_score))'');
    populated_phone_score_pcnt := AVE(GROUP,IF(h.phone_score = (TYPEOF(h.phone_score))'',0,100));
    maxlength_phone_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_score)));
    avelength_phone_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_score)),h.phone_score<>(typeof(h.phone_score))'');
    populated_match_company_name_cnt := COUNT(GROUP,h.match_company_name <> (TYPEOF(h.match_company_name))'');
    populated_match_company_name_pcnt := AVE(GROUP,IF(h.match_company_name = (TYPEOF(h.match_company_name))'',0,100));
    maxlength_match_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_company_name)));
    avelength_match_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_company_name)),h.match_company_name<>(typeof(h.match_company_name))'');
    populated_match_branch_city_cnt := COUNT(GROUP,h.match_branch_city <> (TYPEOF(h.match_branch_city))'');
    populated_match_branch_city_pcnt := AVE(GROUP,IF(h.match_branch_city = (TYPEOF(h.match_branch_city))'',0,100));
    maxlength_match_branch_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_branch_city)));
    avelength_match_branch_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_branch_city)),h.match_branch_city<>(typeof(h.match_branch_city))'');
    populated_match_geo_city_cnt := COUNT(GROUP,h.match_geo_city <> (TYPEOF(h.match_geo_city))'');
    populated_match_geo_city_pcnt := AVE(GROUP,IF(h.match_geo_city = (TYPEOF(h.match_geo_city))'',0,100));
    maxlength_match_geo_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_geo_city)));
    avelength_match_geo_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.match_geo_city)),h.match_geo_city<>(typeof(h.match_geo_city))'');
    populated_duns_number_cnt := COUNT(GROUP,h.duns_number <> (TYPEOF(h.duns_number))'');
    populated_duns_number_pcnt := AVE(GROUP,IF(h.duns_number = (TYPEOF(h.duns_number))'',0,100));
    maxlength_duns_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.duns_number)));
    avelength_duns_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.duns_number)),h.duns_number<>(typeof(h.duns_number))'');
    populated_source_docid_cnt := COUNT(GROUP,h.source_docid <> (TYPEOF(h.source_docid))'');
    populated_source_docid_pcnt := AVE(GROUP,IF(h.source_docid = (TYPEOF(h.source_docid))'',0,100));
    maxlength_source_docid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_docid)));
    avelength_source_docid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_docid)),h.source_docid<>(typeof(h.source_docid))'');
    populated_is_contact_cnt := COUNT(GROUP,h.is_contact <> (TYPEOF(h.is_contact))'');
    populated_is_contact_pcnt := AVE(GROUP,IF(h.is_contact = (TYPEOF(h.is_contact))'',0,100));
    maxlength_is_contact := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_contact)));
    avelength_is_contact := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_contact)),h.is_contact<>(typeof(h.is_contact))'');
    populated_dt_first_seen_contact_cnt := COUNT(GROUP,h.dt_first_seen_contact <> (TYPEOF(h.dt_first_seen_contact))'');
    populated_dt_first_seen_contact_pcnt := AVE(GROUP,IF(h.dt_first_seen_contact = (TYPEOF(h.dt_first_seen_contact))'',0,100));
    maxlength_dt_first_seen_contact := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen_contact)));
    avelength_dt_first_seen_contact := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen_contact)),h.dt_first_seen_contact<>(typeof(h.dt_first_seen_contact))'');
    populated_dt_last_seen_contact_cnt := COUNT(GROUP,h.dt_last_seen_contact <> (TYPEOF(h.dt_last_seen_contact))'');
    populated_dt_last_seen_contact_pcnt := AVE(GROUP,IF(h.dt_last_seen_contact = (TYPEOF(h.dt_last_seen_contact))'',0,100));
    maxlength_dt_last_seen_contact := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen_contact)));
    avelength_dt_last_seen_contact := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen_contact)),h.dt_last_seen_contact<>(typeof(h.dt_last_seen_contact))'');
    populated_contact_did_cnt := COUNT(GROUP,h.contact_did <> (TYPEOF(h.contact_did))'');
    populated_contact_did_pcnt := AVE(GROUP,IF(h.contact_did = (TYPEOF(h.contact_did))'',0,100));
    maxlength_contact_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_did)));
    avelength_contact_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_did)),h.contact_did<>(typeof(h.contact_did))'');
    populated_contact_name_title_cnt := COUNT(GROUP,h.contact_name_title <> (TYPEOF(h.contact_name_title))'');
    populated_contact_name_title_pcnt := AVE(GROUP,IF(h.contact_name_title = (TYPEOF(h.contact_name_title))'',0,100));
    maxlength_contact_name_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_title)));
    avelength_contact_name_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_title)),h.contact_name_title<>(typeof(h.contact_name_title))'');
    populated_contact_name_fname_cnt := COUNT(GROUP,h.contact_name_fname <> (TYPEOF(h.contact_name_fname))'');
    populated_contact_name_fname_pcnt := AVE(GROUP,IF(h.contact_name_fname = (TYPEOF(h.contact_name_fname))'',0,100));
    maxlength_contact_name_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_fname)));
    avelength_contact_name_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_fname)),h.contact_name_fname<>(typeof(h.contact_name_fname))'');
    populated_contact_name_lname_cnt := COUNT(GROUP,h.contact_name_lname <> (TYPEOF(h.contact_name_lname))'');
    populated_contact_name_lname_pcnt := AVE(GROUP,IF(h.contact_name_lname = (TYPEOF(h.contact_name_lname))'',0,100));
    maxlength_contact_name_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_lname)));
    avelength_contact_name_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_lname)),h.contact_name_lname<>(typeof(h.contact_name_lname))'');
    populated_contact_name_lname_cnt := COUNT(GROUP,h.contact_name_lname <> (TYPEOF(h.contact_name_lname))'');
    populated_contact_name_lname_pcnt := AVE(GROUP,IF(h.contact_name_lname = (TYPEOF(h.contact_name_lname))'',0,100));
    maxlength_contact_name_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_lname)));
    avelength_contact_name_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_lname)),h.contact_name_lname<>(typeof(h.contact_name_lname))'');
    populated_contact_name_name_suffix_cnt := COUNT(GROUP,h.contact_name_name_suffix <> (TYPEOF(h.contact_name_name_suffix))'');
    populated_contact_name_name_suffix_pcnt := AVE(GROUP,IF(h.contact_name_name_suffix = (TYPEOF(h.contact_name_name_suffix))'',0,100));
    maxlength_contact_name_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_name_suffix)));
    avelength_contact_name_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_name_suffix)),h.contact_name_name_suffix<>(typeof(h.contact_name_name_suffix))'');
    populated_contact_name_name_score_cnt := COUNT(GROUP,h.contact_name_name_score <> (TYPEOF(h.contact_name_name_score))'');
    populated_contact_name_name_score_pcnt := AVE(GROUP,IF(h.contact_name_name_score = (TYPEOF(h.contact_name_name_score))'',0,100));
    maxlength_contact_name_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_name_score)));
    avelength_contact_name_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_name_name_score)),h.contact_name_name_score<>(typeof(h.contact_name_name_score))'');
    populated_contact_type_raw_cnt := COUNT(GROUP,h.contact_type_raw <> (TYPEOF(h.contact_type_raw))'');
    populated_contact_type_raw_pcnt := AVE(GROUP,IF(h.contact_type_raw = (TYPEOF(h.contact_type_raw))'',0,100));
    maxlength_contact_type_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_type_raw)));
    avelength_contact_type_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_type_raw)),h.contact_type_raw<>(typeof(h.contact_type_raw))'');
    populated_contact_job_title_raw_cnt := COUNT(GROUP,h.contact_job_title_raw <> (TYPEOF(h.contact_job_title_raw))'');
    populated_contact_job_title_raw_pcnt := AVE(GROUP,IF(h.contact_job_title_raw = (TYPEOF(h.contact_job_title_raw))'',0,100));
    maxlength_contact_job_title_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_job_title_raw)));
    avelength_contact_job_title_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_job_title_raw)),h.contact_job_title_raw<>(typeof(h.contact_job_title_raw))'');
    populated_contact_ssn_cnt := COUNT(GROUP,h.contact_ssn <> (TYPEOF(h.contact_ssn))'');
    populated_contact_ssn_pcnt := AVE(GROUP,IF(h.contact_ssn = (TYPEOF(h.contact_ssn))'',0,100));
    maxlength_contact_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_ssn)));
    avelength_contact_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_ssn)),h.contact_ssn<>(typeof(h.contact_ssn))'');
    populated_contact_dob_cnt := COUNT(GROUP,h.contact_dob <> (TYPEOF(h.contact_dob))'');
    populated_contact_dob_pcnt := AVE(GROUP,IF(h.contact_dob = (TYPEOF(h.contact_dob))'',0,100));
    maxlength_contact_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_dob)));
    avelength_contact_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_dob)),h.contact_dob<>(typeof(h.contact_dob))'');
    populated_contact_status_raw_cnt := COUNT(GROUP,h.contact_status_raw <> (TYPEOF(h.contact_status_raw))'');
    populated_contact_status_raw_pcnt := AVE(GROUP,IF(h.contact_status_raw = (TYPEOF(h.contact_status_raw))'',0,100));
    maxlength_contact_status_raw := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_status_raw)));
    avelength_contact_status_raw := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_status_raw)),h.contact_status_raw<>(typeof(h.contact_status_raw))'');
    populated_contact_email_cnt := COUNT(GROUP,h.contact_email <> (TYPEOF(h.contact_email))'');
    populated_contact_email_pcnt := AVE(GROUP,IF(h.contact_email = (TYPEOF(h.contact_email))'',0,100));
    maxlength_contact_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_email)));
    avelength_contact_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_email)),h.contact_email<>(typeof(h.contact_email))'');
    populated_contact_email_username_cnt := COUNT(GROUP,h.contact_email_username <> (TYPEOF(h.contact_email_username))'');
    populated_contact_email_username_pcnt := AVE(GROUP,IF(h.contact_email_username = (TYPEOF(h.contact_email_username))'',0,100));
    maxlength_contact_email_username := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_email_username)));
    avelength_contact_email_username := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_email_username)),h.contact_email_username<>(typeof(h.contact_email_username))'');
    populated_contact_email_domain_cnt := COUNT(GROUP,h.contact_email_domain <> (TYPEOF(h.contact_email_domain))'');
    populated_contact_email_domain_pcnt := AVE(GROUP,IF(h.contact_email_domain = (TYPEOF(h.contact_email_domain))'',0,100));
    maxlength_contact_email_domain := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_email_domain)));
    avelength_contact_email_domain := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_email_domain)),h.contact_email_domain<>(typeof(h.contact_email_domain))'');
    populated_contact_phone_cnt := COUNT(GROUP,h.contact_phone <> (TYPEOF(h.contact_phone))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_cid_cnt := COUNT(GROUP,h.cid <> (TYPEOF(h.cid))'');
    populated_cid_pcnt := AVE(GROUP,IF(h.cid = (TYPEOF(h.cid))'',0,100));
    maxlength_cid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cid)));
    avelength_cid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cid)),h.cid<>(typeof(h.cid))'');
    populated_contact_score_cnt := COUNT(GROUP,h.contact_score <> (TYPEOF(h.contact_score))'');
    populated_contact_score_pcnt := AVE(GROUP,IF(h.contact_score = (TYPEOF(h.contact_score))'',0,100));
    maxlength_contact_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_score)));
    avelength_contact_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_score)),h.contact_score<>(typeof(h.contact_score))'');
    populated_from_hdr_cnt := COUNT(GROUP,h.from_hdr <> (TYPEOF(h.from_hdr))'');
    populated_from_hdr_pcnt := AVE(GROUP,IF(h.from_hdr = (TYPEOF(h.from_hdr))'',0,100));
    maxlength_from_hdr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.from_hdr)));
    avelength_from_hdr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.from_hdr)),h.from_hdr<>(typeof(h.from_hdr))'');
    populated_company_department_cnt := COUNT(GROUP,h.company_department <> (TYPEOF(h.company_department))'');
    populated_company_department_pcnt := AVE(GROUP,IF(h.company_department = (TYPEOF(h.company_department))'',0,100));
    maxlength_company_department := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_department)));
    avelength_company_department := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_department)),h.company_department<>(typeof(h.company_department))'');
    populated_company_aceaid_cnt := COUNT(GROUP,h.company_aceaid <> (TYPEOF(h.company_aceaid))'');
    populated_company_aceaid_pcnt := AVE(GROUP,IF(h.company_aceaid = (TYPEOF(h.company_aceaid))'',0,100));
    maxlength_company_aceaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_aceaid)));
    avelength_company_aceaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_aceaid)),h.company_aceaid<>(typeof(h.company_aceaid))'');
    populated_company_name_type_derived_cnt := COUNT(GROUP,h.company_name_type_derived <> (TYPEOF(h.company_name_type_derived))'');
    populated_company_name_type_derived_pcnt := AVE(GROUP,IF(h.company_name_type_derived = (TYPEOF(h.company_name_type_derived))'',0,100));
    maxlength_company_name_type_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_derived)));
    avelength_company_name_type_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_type_derived)),h.company_name_type_derived<>(typeof(h.company_name_type_derived))'');
    populated_company_address_type_derived_cnt := COUNT(GROUP,h.company_address_type_derived <> (TYPEOF(h.company_address_type_derived))'');
    populated_company_address_type_derived_pcnt := AVE(GROUP,IF(h.company_address_type_derived = (TYPEOF(h.company_address_type_derived))'',0,100));
    maxlength_company_address_type_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_type_derived)));
    avelength_company_address_type_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_address_type_derived)),h.company_address_type_derived<>(typeof(h.company_address_type_derived))'');
    populated_company_org_structure_derived_cnt := COUNT(GROUP,h.company_org_structure_derived <> (TYPEOF(h.company_org_structure_derived))'');
    populated_company_org_structure_derived_pcnt := AVE(GROUP,IF(h.company_org_structure_derived = (TYPEOF(h.company_org_structure_derived))'',0,100));
    maxlength_company_org_structure_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_org_structure_derived)));
    avelength_company_org_structure_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_org_structure_derived)),h.company_org_structure_derived<>(typeof(h.company_org_structure_derived))'');
    populated_company_name_status_derived_cnt := COUNT(GROUP,h.company_name_status_derived <> (TYPEOF(h.company_name_status_derived))'');
    populated_company_name_status_derived_pcnt := AVE(GROUP,IF(h.company_name_status_derived = (TYPEOF(h.company_name_status_derived))'',0,100));
    maxlength_company_name_status_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_status_derived)));
    avelength_company_name_status_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_name_status_derived)),h.company_name_status_derived<>(typeof(h.company_name_status_derived))'');
    populated_company_status_derived_cnt := COUNT(GROUP,h.company_status_derived <> (TYPEOF(h.company_status_derived))'');
    populated_company_status_derived_pcnt := AVE(GROUP,IF(h.company_status_derived = (TYPEOF(h.company_status_derived))'',0,100));
    maxlength_company_status_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_status_derived)));
    avelength_company_status_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.company_status_derived)),h.company_status_derived<>(typeof(h.company_status_derived))'');
    populated_proxid_status_private_cnt := COUNT(GROUP,h.proxid_status_private <> (TYPEOF(h.proxid_status_private))'');
    populated_proxid_status_private_pcnt := AVE(GROUP,IF(h.proxid_status_private = (TYPEOF(h.proxid_status_private))'',0,100));
    maxlength_proxid_status_private := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid_status_private)));
    avelength_proxid_status_private := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid_status_private)),h.proxid_status_private<>(typeof(h.proxid_status_private))'');
    populated_powid_status_private_cnt := COUNT(GROUP,h.powid_status_private <> (TYPEOF(h.powid_status_private))'');
    populated_powid_status_private_pcnt := AVE(GROUP,IF(h.powid_status_private = (TYPEOF(h.powid_status_private))'',0,100));
    maxlength_powid_status_private := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid_status_private)));
    avelength_powid_status_private := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid_status_private)),h.powid_status_private<>(typeof(h.powid_status_private))'');
    populated_seleid_status_private_cnt := COUNT(GROUP,h.seleid_status_private <> (TYPEOF(h.seleid_status_private))'');
    populated_seleid_status_private_pcnt := AVE(GROUP,IF(h.seleid_status_private = (TYPEOF(h.seleid_status_private))'',0,100));
    maxlength_seleid_status_private := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid_status_private)));
    avelength_seleid_status_private := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid_status_private)),h.seleid_status_private<>(typeof(h.seleid_status_private))'');
    populated_orgid_status_private_cnt := COUNT(GROUP,h.orgid_status_private <> (TYPEOF(h.orgid_status_private))'');
    populated_orgid_status_private_pcnt := AVE(GROUP,IF(h.orgid_status_private = (TYPEOF(h.orgid_status_private))'',0,100));
    maxlength_orgid_status_private := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid_status_private)));
    avelength_orgid_status_private := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid_status_private)),h.orgid_status_private<>(typeof(h.orgid_status_private))'');
    populated_ultid_status_private_cnt := COUNT(GROUP,h.ultid_status_private <> (TYPEOF(h.ultid_status_private))'');
    populated_ultid_status_private_pcnt := AVE(GROUP,IF(h.ultid_status_private = (TYPEOF(h.ultid_status_private))'',0,100));
    maxlength_ultid_status_private := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid_status_private)));
    avelength_ultid_status_private := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid_status_private)),h.ultid_status_private<>(typeof(h.ultid_status_private))'');
    populated_proxid_status_public_cnt := COUNT(GROUP,h.proxid_status_public <> (TYPEOF(h.proxid_status_public))'');
    populated_proxid_status_public_pcnt := AVE(GROUP,IF(h.proxid_status_public = (TYPEOF(h.proxid_status_public))'',0,100));
    maxlength_proxid_status_public := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid_status_public)));
    avelength_proxid_status_public := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.proxid_status_public)),h.proxid_status_public<>(typeof(h.proxid_status_public))'');
    populated_powid_status_public_cnt := COUNT(GROUP,h.powid_status_public <> (TYPEOF(h.powid_status_public))'');
    populated_powid_status_public_pcnt := AVE(GROUP,IF(h.powid_status_public = (TYPEOF(h.powid_status_public))'',0,100));
    maxlength_powid_status_public := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid_status_public)));
    avelength_powid_status_public := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.powid_status_public)),h.powid_status_public<>(typeof(h.powid_status_public))'');
    populated_seleid_status_public_cnt := COUNT(GROUP,h.seleid_status_public <> (TYPEOF(h.seleid_status_public))'');
    populated_seleid_status_public_pcnt := AVE(GROUP,IF(h.seleid_status_public = (TYPEOF(h.seleid_status_public))'',0,100));
    maxlength_seleid_status_public := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid_status_public)));
    avelength_seleid_status_public := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.seleid_status_public)),h.seleid_status_public<>(typeof(h.seleid_status_public))'');
    populated_orgid_status_public_cnt := COUNT(GROUP,h.orgid_status_public <> (TYPEOF(h.orgid_status_public))'');
    populated_orgid_status_public_pcnt := AVE(GROUP,IF(h.orgid_status_public = (TYPEOF(h.orgid_status_public))'',0,100));
    maxlength_orgid_status_public := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid_status_public)));
    avelength_orgid_status_public := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orgid_status_public)),h.orgid_status_public<>(typeof(h.orgid_status_public))'');
    populated_ultid_status_public_cnt := COUNT(GROUP,h.ultid_status_public <> (TYPEOF(h.ultid_status_public))'');
    populated_ultid_status_public_pcnt := AVE(GROUP,IF(h.ultid_status_public = (TYPEOF(h.ultid_status_public))'',0,100));
    maxlength_ultid_status_public := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid_status_public)));
    avelength_ultid_status_public := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ultid_status_public)),h.ultid_status_public<>(typeof(h.ultid_status_public))'');
    populated_contact_type_derived_cnt := COUNT(GROUP,h.contact_type_derived <> (TYPEOF(h.contact_type_derived))'');
    populated_contact_type_derived_pcnt := AVE(GROUP,IF(h.contact_type_derived = (TYPEOF(h.contact_type_derived))'',0,100));
    maxlength_contact_type_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_type_derived)));
    avelength_contact_type_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_type_derived)),h.contact_type_derived<>(typeof(h.contact_type_derived))'');
    populated_contact_job_title_derived_cnt := COUNT(GROUP,h.contact_job_title_derived <> (TYPEOF(h.contact_job_title_derived))'');
    populated_contact_job_title_derived_pcnt := AVE(GROUP,IF(h.contact_job_title_derived = (TYPEOF(h.contact_job_title_derived))'',0,100));
    maxlength_contact_job_title_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_job_title_derived)));
    avelength_contact_job_title_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_job_title_derived)),h.contact_job_title_derived<>(typeof(h.contact_job_title_derived))'');
    populated_contact_status_derived_cnt := COUNT(GROUP,h.contact_status_derived <> (TYPEOF(h.contact_status_derived))'');
    populated_contact_status_derived_pcnt := AVE(GROUP,IF(h.contact_status_derived = (TYPEOF(h.contact_status_derived))'',0,100));
    maxlength_contact_status_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_status_derived)));
    avelength_contact_status_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_status_derived)),h.contact_status_derived<>(typeof(h.contact_status_derived))'');
    populated_address_type_derived_cnt := COUNT(GROUP,h.address_type_derived <> (TYPEOF(h.address_type_derived))'');
    populated_address_type_derived_pcnt := AVE(GROUP,IF(h.address_type_derived = (TYPEOF(h.address_type_derived))'',0,100));
    maxlength_address_type_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type_derived)));
    avelength_address_type_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type_derived)),h.address_type_derived<>(typeof(h.address_type_derived))'');
    populated_is_vanity_name_derived_cnt := COUNT(GROUP,h.is_vanity_name_derived <> (TYPEOF(h.is_vanity_name_derived))'');
    populated_is_vanity_name_derived_pcnt := AVE(GROUP,IF(h.is_vanity_name_derived = (TYPEOF(h.is_vanity_name_derived))'',0,100));
    maxlength_is_vanity_name_derived := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_vanity_name_derived)));
    avelength_is_vanity_name_derived := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.is_vanity_name_derived)),h.is_vanity_name_derived<>(typeof(h.is_vanity_name_derived))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source_expanded,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_source_expanded_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_rcid_pcnt *   0.00 / 100 + T.Populated_company_bdid_pcnt *   0.00 / 100 + T.Populated_company_name_pcnt *   0.00 / 100 + T.Populated_company_name_type_raw_pcnt *   0.00 / 100 + T.Populated_company_rawaid_pcnt *   0.00 / 100 + T.Populated_company_address_prim_range_pcnt *   0.00 / 100 + T.Populated_company_address_predir_pcnt *   0.00 / 100 + T.Populated_company_address_prim_name_pcnt *   0.00 / 100 + T.Populated_company_address_addr_suffix_pcnt *   0.00 / 100 + T.Populated_company_address_postdir_pcnt *   0.00 / 100 + T.Populated_company_address_unit_desig_pcnt *   0.00 / 100 + T.Populated_company_address_sec_range_pcnt *   0.00 / 100 + T.Populated_company_address_p_city_name_pcnt *   0.00 / 100 + T.Populated_company_address_v_city_name_pcnt *   0.00 / 100 + T.Populated_company_address_st_pcnt *   0.00 / 100 + T.Populated_company_address_zip_pcnt *   0.00 / 100 + T.Populated_company_address_zip4_pcnt *   0.00 / 100 + T.Populated_company_address_cart_pcnt *   0.00 / 100 + T.Populated_company_address_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_company_address_lot_pcnt *   0.00 / 100 + T.Populated_company_address_lot_order_pcnt *   0.00 / 100 + T.Populated_company_address_dbpc_pcnt *   0.00 / 100 + T.Populated_company_address_chk_digit_pcnt *   0.00 / 100 + T.Populated_company_address_rec_type_pcnt *   0.00 / 100 + T.Populated_company_address_fips_state_pcnt *   0.00 / 100 + T.Populated_company_address_fips_county_pcnt *   0.00 / 100 + T.Populated_company_address_geo_lat_pcnt *   0.00 / 100 + T.Populated_company_address_geo_long_pcnt *   0.00 / 100 + T.Populated_company_address_msa_pcnt *   0.00 / 100 + T.Populated_company_address_geo_blk_pcnt *   0.00 / 100 + T.Populated_company_address_geo_match_pcnt *   0.00 / 100 + T.Populated_company_address_err_stat_pcnt *   0.00 / 100 + T.Populated_company_address_type_raw_pcnt *   0.00 / 100 + T.Populated_company_address_category_pcnt *   0.00 / 100 + T.Populated_company_address_country_code_pcnt *   0.00 / 100 + T.Populated_company_fein_pcnt *   0.00 / 100 + T.Populated_best_fein_indicator_pcnt *   0.00 / 100 + T.Populated_company_phone_pcnt *   0.00 / 100 + T.Populated_phone_type_pcnt *   0.00 / 100 + T.Populated_company_org_structure_raw_pcnt *   0.00 / 100 + T.Populated_company_incorporation_date_pcnt *   0.00 / 100 + T.Populated_company_sic_code1_pcnt *   0.00 / 100 + T.Populated_company_sic_code2_pcnt *   0.00 / 100 + T.Populated_company_sic_code3_pcnt *   0.00 / 100 + T.Populated_company_sic_code4_pcnt *   0.00 / 100 + T.Populated_company_sic_code5_pcnt *   0.00 / 100 + T.Populated_company_naics_code1_pcnt *   0.00 / 100 + T.Populated_company_naics_code2_pcnt *   0.00 / 100 + T.Populated_company_naics_code3_pcnt *   0.00 / 100 + T.Populated_company_naics_code4_pcnt *   0.00 / 100 + T.Populated_company_naics_code5_pcnt *   0.00 / 100 + T.Populated_company_ticker_pcnt *   0.00 / 100 + T.Populated_company_ticker_exchange_pcnt *   0.00 / 100 + T.Populated_company_foreign_domestic_pcnt *   0.00 / 100 + T.Populated_company_url_pcnt *   0.00 / 100 + T.Populated_company_inc_state_pcnt *   0.00 / 100 + T.Populated_company_charter_number_pcnt *   0.00 / 100 + T.Populated_company_filing_date_pcnt *   0.00 / 100 + T.Populated_company_status_date_pcnt *   0.00 / 100 + T.Populated_company_foreign_date_pcnt *   0.00 / 100 + T.Populated_event_filing_date_pcnt *   0.00 / 100 + T.Populated_company_name_status_raw_pcnt *   0.00 / 100 + T.Populated_company_status_raw_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_company_name_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_company_name_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_company_address_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_company_address_pcnt *   0.00 / 100 + T.Populated_vl_id_pcnt *   0.00 / 100 + T.Populated_current_pcnt *   0.00 / 100 + T.Populated_source_record_id_pcnt *   0.00 / 100 + T.Populated_glb_pcnt *   0.00 / 100 + T.Populated_dppa_pcnt *   0.00 / 100 + T.Populated_phone_score_pcnt *   0.00 / 100 + T.Populated_match_company_name_pcnt *   0.00 / 100 + T.Populated_match_branch_city_pcnt *   0.00 / 100 + T.Populated_match_geo_city_pcnt *   0.00 / 100 + T.Populated_duns_number_pcnt *   0.00 / 100 + T.Populated_source_docid_pcnt *   0.00 / 100 + T.Populated_is_contact_pcnt *   0.00 / 100 + T.Populated_dt_first_seen_contact_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_contact_pcnt *   0.00 / 100 + T.Populated_contact_did_pcnt *   0.00 / 100 + T.Populated_contact_name_title_pcnt *   0.00 / 100 + T.Populated_contact_name_fname_pcnt *   0.00 / 100 + T.Populated_contact_name_lname_pcnt *   0.00 / 100 + T.Populated_contact_name_lname_pcnt *   0.00 / 100 + T.Populated_contact_name_name_suffix_pcnt *   0.00 / 100 + T.Populated_contact_name_name_score_pcnt *   0.00 / 100 + T.Populated_contact_type_raw_pcnt *   0.00 / 100 + T.Populated_contact_job_title_raw_pcnt *   0.00 / 100 + T.Populated_contact_ssn_pcnt *   0.00 / 100 + T.Populated_contact_dob_pcnt *   0.00 / 100 + T.Populated_contact_status_raw_pcnt *   0.00 / 100 + T.Populated_contact_email_pcnt *   0.00 / 100 + T.Populated_contact_email_username_pcnt *   0.00 / 100 + T.Populated_contact_email_domain_pcnt *   0.00 / 100 + T.Populated_contact_phone_pcnt *   0.00 / 100 + T.Populated_cid_pcnt *   0.00 / 100 + T.Populated_contact_score_pcnt *   0.00 / 100 + T.Populated_from_hdr_pcnt *   0.00 / 100 + T.Populated_company_department_pcnt *   0.00 / 100 + T.Populated_company_aceaid_pcnt *   0.00 / 100 + T.Populated_company_name_type_derived_pcnt *   0.00 / 100 + T.Populated_company_address_type_derived_pcnt *   0.00 / 100 + T.Populated_company_org_structure_derived_pcnt *   0.00 / 100 + T.Populated_company_name_status_derived_pcnt *   0.00 / 100 + T.Populated_company_status_derived_pcnt *   0.00 / 100 + T.Populated_proxid_status_private_pcnt *   0.00 / 100 + T.Populated_powid_status_private_pcnt *   0.00 / 100 + T.Populated_seleid_status_private_pcnt *   0.00 / 100 + T.Populated_orgid_status_private_pcnt *   0.00 / 100 + T.Populated_ultid_status_private_pcnt *   0.00 / 100 + T.Populated_proxid_status_public_pcnt *   0.00 / 100 + T.Populated_powid_status_public_pcnt *   0.00 / 100 + T.Populated_seleid_status_public_pcnt *   0.00 / 100 + T.Populated_orgid_status_public_pcnt *   0.00 / 100 + T.Populated_ultid_status_public_pcnt *   0.00 / 100 + T.Populated_contact_type_derived_pcnt *   0.00 / 100 + T.Populated_contact_job_title_derived_pcnt *   0.00 / 100 + T.Populated_contact_status_derived_pcnt *   0.00 / 100 + T.Populated_address_type_derived_pcnt *   0.00 / 100 + T.Populated_is_vanity_name_derived_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING source_expanded1;
    STRING source_expanded2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source_expanded1 := le.Source;
    SELF.source_expanded2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_source_expanded_pcnt*ri.Populated_source_expanded_pcnt *   0.00 / 10000 + le.Populated_source_pcnt*ri.Populated_source_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_pcnt*ri.Populated_dt_first_seen_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_pcnt*ri.Populated_dt_last_seen_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_first_reported_pcnt*ri.Populated_dt_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_last_reported_pcnt*ri.Populated_dt_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_rcid_pcnt*ri.Populated_rcid_pcnt *   0.00 / 10000 + le.Populated_company_bdid_pcnt*ri.Populated_company_bdid_pcnt *   0.00 / 10000 + le.Populated_company_name_pcnt*ri.Populated_company_name_pcnt *   0.00 / 10000 + le.Populated_company_name_type_raw_pcnt*ri.Populated_company_name_type_raw_pcnt *   0.00 / 10000 + le.Populated_company_rawaid_pcnt*ri.Populated_company_rawaid_pcnt *   0.00 / 10000 + le.Populated_company_address_prim_range_pcnt*ri.Populated_company_address_prim_range_pcnt *   0.00 / 10000 + le.Populated_company_address_predir_pcnt*ri.Populated_company_address_predir_pcnt *   0.00 / 10000 + le.Populated_company_address_prim_name_pcnt*ri.Populated_company_address_prim_name_pcnt *   0.00 / 10000 + le.Populated_company_address_addr_suffix_pcnt*ri.Populated_company_address_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_company_address_postdir_pcnt*ri.Populated_company_address_postdir_pcnt *   0.00 / 10000 + le.Populated_company_address_unit_desig_pcnt*ri.Populated_company_address_unit_desig_pcnt *   0.00 / 10000 + le.Populated_company_address_sec_range_pcnt*ri.Populated_company_address_sec_range_pcnt *   0.00 / 10000 + le.Populated_company_address_p_city_name_pcnt*ri.Populated_company_address_p_city_name_pcnt *   0.00 / 10000 + le.Populated_company_address_v_city_name_pcnt*ri.Populated_company_address_v_city_name_pcnt *   0.00 / 10000 + le.Populated_company_address_st_pcnt*ri.Populated_company_address_st_pcnt *   0.00 / 10000 + le.Populated_company_address_zip_pcnt*ri.Populated_company_address_zip_pcnt *   0.00 / 10000 + le.Populated_company_address_zip4_pcnt*ri.Populated_company_address_zip4_pcnt *   0.00 / 10000 + le.Populated_company_address_cart_pcnt*ri.Populated_company_address_cart_pcnt *   0.00 / 10000 + le.Populated_company_address_cr_sort_sz_pcnt*ri.Populated_company_address_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_company_address_lot_pcnt*ri.Populated_company_address_lot_pcnt *   0.00 / 10000 + le.Populated_company_address_lot_order_pcnt*ri.Populated_company_address_lot_order_pcnt *   0.00 / 10000 + le.Populated_company_address_dbpc_pcnt*ri.Populated_company_address_dbpc_pcnt *   0.00 / 10000 + le.Populated_company_address_chk_digit_pcnt*ri.Populated_company_address_chk_digit_pcnt *   0.00 / 10000 + le.Populated_company_address_rec_type_pcnt*ri.Populated_company_address_rec_type_pcnt *   0.00 / 10000 + le.Populated_company_address_fips_state_pcnt*ri.Populated_company_address_fips_state_pcnt *   0.00 / 10000 + le.Populated_company_address_fips_county_pcnt*ri.Populated_company_address_fips_county_pcnt *   0.00 / 10000 + le.Populated_company_address_geo_lat_pcnt*ri.Populated_company_address_geo_lat_pcnt *   0.00 / 10000 + le.Populated_company_address_geo_long_pcnt*ri.Populated_company_address_geo_long_pcnt *   0.00 / 10000 + le.Populated_company_address_msa_pcnt*ri.Populated_company_address_msa_pcnt *   0.00 / 10000 + le.Populated_company_address_geo_blk_pcnt*ri.Populated_company_address_geo_blk_pcnt *   0.00 / 10000 + le.Populated_company_address_geo_match_pcnt*ri.Populated_company_address_geo_match_pcnt *   0.00 / 10000 + le.Populated_company_address_err_stat_pcnt*ri.Populated_company_address_err_stat_pcnt *   0.00 / 10000 + le.Populated_company_address_type_raw_pcnt*ri.Populated_company_address_type_raw_pcnt *   0.00 / 10000 + le.Populated_company_address_category_pcnt*ri.Populated_company_address_category_pcnt *   0.00 / 10000 + le.Populated_company_address_country_code_pcnt*ri.Populated_company_address_country_code_pcnt *   0.00 / 10000 + le.Populated_company_fein_pcnt*ri.Populated_company_fein_pcnt *   0.00 / 10000 + le.Populated_best_fein_indicator_pcnt*ri.Populated_best_fein_indicator_pcnt *   0.00 / 10000 + le.Populated_company_phone_pcnt*ri.Populated_company_phone_pcnt *   0.00 / 10000 + le.Populated_phone_type_pcnt*ri.Populated_phone_type_pcnt *   0.00 / 10000 + le.Populated_company_org_structure_raw_pcnt*ri.Populated_company_org_structure_raw_pcnt *   0.00 / 10000 + le.Populated_company_incorporation_date_pcnt*ri.Populated_company_incorporation_date_pcnt *   0.00 / 10000 + le.Populated_company_sic_code1_pcnt*ri.Populated_company_sic_code1_pcnt *   0.00 / 10000 + le.Populated_company_sic_code2_pcnt*ri.Populated_company_sic_code2_pcnt *   0.00 / 10000 + le.Populated_company_sic_code3_pcnt*ri.Populated_company_sic_code3_pcnt *   0.00 / 10000 + le.Populated_company_sic_code4_pcnt*ri.Populated_company_sic_code4_pcnt *   0.00 / 10000 + le.Populated_company_sic_code5_pcnt*ri.Populated_company_sic_code5_pcnt *   0.00 / 10000 + le.Populated_company_naics_code1_pcnt*ri.Populated_company_naics_code1_pcnt *   0.00 / 10000 + le.Populated_company_naics_code2_pcnt*ri.Populated_company_naics_code2_pcnt *   0.00 / 10000 + le.Populated_company_naics_code3_pcnt*ri.Populated_company_naics_code3_pcnt *   0.00 / 10000 + le.Populated_company_naics_code4_pcnt*ri.Populated_company_naics_code4_pcnt *   0.00 / 10000 + le.Populated_company_naics_code5_pcnt*ri.Populated_company_naics_code5_pcnt *   0.00 / 10000 + le.Populated_company_ticker_pcnt*ri.Populated_company_ticker_pcnt *   0.00 / 10000 + le.Populated_company_ticker_exchange_pcnt*ri.Populated_company_ticker_exchange_pcnt *   0.00 / 10000 + le.Populated_company_foreign_domestic_pcnt*ri.Populated_company_foreign_domestic_pcnt *   0.00 / 10000 + le.Populated_company_url_pcnt*ri.Populated_company_url_pcnt *   0.00 / 10000 + le.Populated_company_inc_state_pcnt*ri.Populated_company_inc_state_pcnt *   0.00 / 10000 + le.Populated_company_charter_number_pcnt*ri.Populated_company_charter_number_pcnt *   0.00 / 10000 + le.Populated_company_filing_date_pcnt*ri.Populated_company_filing_date_pcnt *   0.00 / 10000 + le.Populated_company_status_date_pcnt*ri.Populated_company_status_date_pcnt *   0.00 / 10000 + le.Populated_company_foreign_date_pcnt*ri.Populated_company_foreign_date_pcnt *   0.00 / 10000 + le.Populated_event_filing_date_pcnt*ri.Populated_event_filing_date_pcnt *   0.00 / 10000 + le.Populated_company_name_status_raw_pcnt*ri.Populated_company_name_status_raw_pcnt *   0.00 / 10000 + le.Populated_company_status_raw_pcnt*ri.Populated_company_status_raw_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_company_name_pcnt*ri.Populated_dt_first_seen_company_name_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_company_name_pcnt*ri.Populated_dt_last_seen_company_name_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_company_address_pcnt*ri.Populated_dt_first_seen_company_address_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_company_address_pcnt*ri.Populated_dt_last_seen_company_address_pcnt *   0.00 / 10000 + le.Populated_vl_id_pcnt*ri.Populated_vl_id_pcnt *   0.00 / 10000 + le.Populated_current_pcnt*ri.Populated_current_pcnt *   0.00 / 10000 + le.Populated_source_record_id_pcnt*ri.Populated_source_record_id_pcnt *   0.00 / 10000 + le.Populated_glb_pcnt*ri.Populated_glb_pcnt *   0.00 / 10000 + le.Populated_dppa_pcnt*ri.Populated_dppa_pcnt *   0.00 / 10000 + le.Populated_phone_score_pcnt*ri.Populated_phone_score_pcnt *   0.00 / 10000 + le.Populated_match_company_name_pcnt*ri.Populated_match_company_name_pcnt *   0.00 / 10000 + le.Populated_match_branch_city_pcnt*ri.Populated_match_branch_city_pcnt *   0.00 / 10000 + le.Populated_match_geo_city_pcnt*ri.Populated_match_geo_city_pcnt *   0.00 / 10000 + le.Populated_duns_number_pcnt*ri.Populated_duns_number_pcnt *   0.00 / 10000 + le.Populated_source_docid_pcnt*ri.Populated_source_docid_pcnt *   0.00 / 10000 + le.Populated_is_contact_pcnt*ri.Populated_is_contact_pcnt *   0.00 / 10000 + le.Populated_dt_first_seen_contact_pcnt*ri.Populated_dt_first_seen_contact_pcnt *   0.00 / 10000 + le.Populated_dt_last_seen_contact_pcnt*ri.Populated_dt_last_seen_contact_pcnt *   0.00 / 10000 + le.Populated_contact_did_pcnt*ri.Populated_contact_did_pcnt *   0.00 / 10000 + le.Populated_contact_name_title_pcnt*ri.Populated_contact_name_title_pcnt *   0.00 / 10000 + le.Populated_contact_name_fname_pcnt*ri.Populated_contact_name_fname_pcnt *   0.00 / 10000 + le.Populated_contact_name_lname_pcnt*ri.Populated_contact_name_lname_pcnt *   0.00 / 10000 + le.Populated_contact_name_lname_pcnt*ri.Populated_contact_name_lname_pcnt *   0.00 / 10000 + le.Populated_contact_name_name_suffix_pcnt*ri.Populated_contact_name_name_suffix_pcnt *   0.00 / 10000 + le.Populated_contact_name_name_score_pcnt*ri.Populated_contact_name_name_score_pcnt *   0.00 / 10000 + le.Populated_contact_type_raw_pcnt*ri.Populated_contact_type_raw_pcnt *   0.00 / 10000 + le.Populated_contact_job_title_raw_pcnt*ri.Populated_contact_job_title_raw_pcnt *   0.00 / 10000 + le.Populated_contact_ssn_pcnt*ri.Populated_contact_ssn_pcnt *   0.00 / 10000 + le.Populated_contact_dob_pcnt*ri.Populated_contact_dob_pcnt *   0.00 / 10000 + le.Populated_contact_status_raw_pcnt*ri.Populated_contact_status_raw_pcnt *   0.00 / 10000 + le.Populated_contact_email_pcnt*ri.Populated_contact_email_pcnt *   0.00 / 10000 + le.Populated_contact_email_username_pcnt*ri.Populated_contact_email_username_pcnt *   0.00 / 10000 + le.Populated_contact_email_domain_pcnt*ri.Populated_contact_email_domain_pcnt *   0.00 / 10000 + le.Populated_contact_phone_pcnt*ri.Populated_contact_phone_pcnt *   0.00 / 10000 + le.Populated_cid_pcnt*ri.Populated_cid_pcnt *   0.00 / 10000 + le.Populated_contact_score_pcnt*ri.Populated_contact_score_pcnt *   0.00 / 10000 + le.Populated_from_hdr_pcnt*ri.Populated_from_hdr_pcnt *   0.00 / 10000 + le.Populated_company_department_pcnt*ri.Populated_company_department_pcnt *   0.00 / 10000 + le.Populated_company_aceaid_pcnt*ri.Populated_company_aceaid_pcnt *   0.00 / 10000 + le.Populated_company_name_type_derived_pcnt*ri.Populated_company_name_type_derived_pcnt *   0.00 / 10000 + le.Populated_company_address_type_derived_pcnt*ri.Populated_company_address_type_derived_pcnt *   0.00 / 10000 + le.Populated_company_org_structure_derived_pcnt*ri.Populated_company_org_structure_derived_pcnt *   0.00 / 10000 + le.Populated_company_name_status_derived_pcnt*ri.Populated_company_name_status_derived_pcnt *   0.00 / 10000 + le.Populated_company_status_derived_pcnt*ri.Populated_company_status_derived_pcnt *   0.00 / 10000 + le.Populated_proxid_status_private_pcnt*ri.Populated_proxid_status_private_pcnt *   0.00 / 10000 + le.Populated_powid_status_private_pcnt*ri.Populated_powid_status_private_pcnt *   0.00 / 10000 + le.Populated_seleid_status_private_pcnt*ri.Populated_seleid_status_private_pcnt *   0.00 / 10000 + le.Populated_orgid_status_private_pcnt*ri.Populated_orgid_status_private_pcnt *   0.00 / 10000 + le.Populated_ultid_status_private_pcnt*ri.Populated_ultid_status_private_pcnt *   0.00 / 10000 + le.Populated_proxid_status_public_pcnt*ri.Populated_proxid_status_public_pcnt *   0.00 / 10000 + le.Populated_powid_status_public_pcnt*ri.Populated_powid_status_public_pcnt *   0.00 / 10000 + le.Populated_seleid_status_public_pcnt*ri.Populated_seleid_status_public_pcnt *   0.00 / 10000 + le.Populated_orgid_status_public_pcnt*ri.Populated_orgid_status_public_pcnt *   0.00 / 10000 + le.Populated_ultid_status_public_pcnt*ri.Populated_ultid_status_public_pcnt *   0.00 / 10000 + le.Populated_contact_type_derived_pcnt*ri.Populated_contact_type_derived_pcnt *   0.00 / 10000 + le.Populated_contact_job_title_derived_pcnt*ri.Populated_contact_job_title_derived_pcnt *   0.00 / 10000 + le.Populated_contact_status_derived_pcnt*ri.Populated_contact_status_derived_pcnt *   0.00 / 10000 + le.Populated_address_type_derived_pcnt*ri.Populated_address_type_derived_pcnt *   0.00 / 10000 + le.Populated_is_vanity_name_derived_pcnt*ri.Populated_is_vanity_name_derived_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'source_expanded','source','dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','rcid','company_bdid','company_name','company_name_type_raw','company_rawaid','company_address_prim_range','company_address_predir','company_address_prim_name','company_address_addr_suffix','company_address_postdir','company_address_unit_desig','company_address_sec_range','company_address_p_city_name','company_address_v_city_name','company_address_st','company_address_zip','company_address_zip4','company_address_cart','company_address_cr_sort_sz','company_address_lot','company_address_lot_order','company_address_dbpc','company_address_chk_digit','company_address_rec_type','company_address_fips_state','company_address_fips_county','company_address_geo_lat','company_address_geo_long','company_address_msa','company_address_geo_blk','company_address_geo_match','company_address_err_stat','company_address_type_raw','company_address_category','company_address_country_code','company_fein','best_fein_indicator','company_phone','phone_type','company_org_structure_raw','company_incorporation_date','company_sic_code1','company_sic_code2','company_sic_code3','company_sic_code4','company_sic_code5','company_naics_code1','company_naics_code2','company_naics_code3','company_naics_code4','company_naics_code5','company_ticker','company_ticker_exchange','company_foreign_domestic','company_url','company_inc_state','company_charter_number','company_filing_date','company_status_date','company_foreign_date','event_filing_date','company_name_status_raw','company_status_raw','dt_first_seen_company_name','dt_last_seen_company_name','dt_first_seen_company_address','dt_last_seen_company_address','vl_id','current','source_record_id','glb','dppa','phone_score','match_company_name','match_branch_city','match_geo_city','duns_number','source_docid','is_contact','dt_first_seen_contact','dt_last_seen_contact','contact_did','contact_name_title','contact_name_fname','contact_name_lname','contact_name_lname','contact_name_name_suffix','contact_name_name_score','contact_type_raw','contact_job_title_raw','contact_ssn','contact_dob','contact_status_raw','contact_email','contact_email_username','contact_email_domain','contact_phone','cid','contact_score','from_hdr','company_department','company_aceaid','company_name_type_derived','company_address_type_derived','company_org_structure_derived','company_name_status_derived','company_status_derived','proxid_status_private','powid_status_private','seleid_status_private','orgid_status_private','ultid_status_private','proxid_status_public','powid_status_public','seleid_status_public','orgid_status_public','ultid_status_public','contact_type_derived','contact_job_title_derived','contact_status_derived','address_type_derived','is_vanity_name_derived');
  SELF.populated_pcnt := CHOOSE(C,le.populated_source_expanded_pcnt,le.populated_source_pcnt,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_rcid_pcnt,le.populated_company_bdid_pcnt,le.populated_company_name_pcnt,le.populated_company_name_type_raw_pcnt,le.populated_company_rawaid_pcnt,le.populated_company_address_prim_range_pcnt,le.populated_company_address_predir_pcnt,le.populated_company_address_prim_name_pcnt,le.populated_company_address_addr_suffix_pcnt,le.populated_company_address_postdir_pcnt,le.populated_company_address_unit_desig_pcnt,le.populated_company_address_sec_range_pcnt,le.populated_company_address_p_city_name_pcnt,le.populated_company_address_v_city_name_pcnt,le.populated_company_address_st_pcnt,le.populated_company_address_zip_pcnt,le.populated_company_address_zip4_pcnt,le.populated_company_address_cart_pcnt,le.populated_company_address_cr_sort_sz_pcnt,le.populated_company_address_lot_pcnt,le.populated_company_address_lot_order_pcnt,le.populated_company_address_dbpc_pcnt,le.populated_company_address_chk_digit_pcnt,le.populated_company_address_rec_type_pcnt,le.populated_company_address_fips_state_pcnt,le.populated_company_address_fips_county_pcnt,le.populated_company_address_geo_lat_pcnt,le.populated_company_address_geo_long_pcnt,le.populated_company_address_msa_pcnt,le.populated_company_address_geo_blk_pcnt,le.populated_company_address_geo_match_pcnt,le.populated_company_address_err_stat_pcnt,le.populated_company_address_type_raw_pcnt,le.populated_company_address_category_pcnt,le.populated_company_address_country_code_pcnt,le.populated_company_fein_pcnt,le.populated_best_fein_indicator_pcnt,le.populated_company_phone_pcnt,le.populated_phone_type_pcnt,le.populated_company_org_structure_raw_pcnt,le.populated_company_incorporation_date_pcnt,le.populated_company_sic_code1_pcnt,le.populated_company_sic_code2_pcnt,le.populated_company_sic_code3_pcnt,le.populated_company_sic_code4_pcnt,le.populated_company_sic_code5_pcnt,le.populated_company_naics_code1_pcnt,le.populated_company_naics_code2_pcnt,le.populated_company_naics_code3_pcnt,le.populated_company_naics_code4_pcnt,le.populated_company_naics_code5_pcnt,le.populated_company_ticker_pcnt,le.populated_company_ticker_exchange_pcnt,le.populated_company_foreign_domestic_pcnt,le.populated_company_url_pcnt,le.populated_company_inc_state_pcnt,le.populated_company_charter_number_pcnt,le.populated_company_filing_date_pcnt,le.populated_company_status_date_pcnt,le.populated_company_foreign_date_pcnt,le.populated_event_filing_date_pcnt,le.populated_company_name_status_raw_pcnt,le.populated_company_status_raw_pcnt,le.populated_dt_first_seen_company_name_pcnt,le.populated_dt_last_seen_company_name_pcnt,le.populated_dt_first_seen_company_address_pcnt,le.populated_dt_last_seen_company_address_pcnt,le.populated_vl_id_pcnt,le.populated_current_pcnt,le.populated_source_record_id_pcnt,le.populated_glb_pcnt,le.populated_dppa_pcnt,le.populated_phone_score_pcnt,le.populated_match_company_name_pcnt,le.populated_match_branch_city_pcnt,le.populated_match_geo_city_pcnt,le.populated_duns_number_pcnt,le.populated_source_docid_pcnt,le.populated_is_contact_pcnt,le.populated_dt_first_seen_contact_pcnt,le.populated_dt_last_seen_contact_pcnt,le.populated_contact_did_pcnt,le.populated_contact_name_title_pcnt,le.populated_contact_name_fname_pcnt,le.populated_contact_name_lname_pcnt,le.populated_contact_name_lname_pcnt,le.populated_contact_name_name_suffix_pcnt,le.populated_contact_name_name_score_pcnt,le.populated_contact_type_raw_pcnt,le.populated_contact_job_title_raw_pcnt,le.populated_contact_ssn_pcnt,le.populated_contact_dob_pcnt,le.populated_contact_status_raw_pcnt,le.populated_contact_email_pcnt,le.populated_contact_email_username_pcnt,le.populated_contact_email_domain_pcnt,le.populated_contact_phone_pcnt,le.populated_cid_pcnt,le.populated_contact_score_pcnt,le.populated_from_hdr_pcnt,le.populated_company_department_pcnt,le.populated_company_aceaid_pcnt,le.populated_company_name_type_derived_pcnt,le.populated_company_address_type_derived_pcnt,le.populated_company_org_structure_derived_pcnt,le.populated_company_name_status_derived_pcnt,le.populated_company_status_derived_pcnt,le.populated_proxid_status_private_pcnt,le.populated_powid_status_private_pcnt,le.populated_seleid_status_private_pcnt,le.populated_orgid_status_private_pcnt,le.populated_ultid_status_private_pcnt,le.populated_proxid_status_public_pcnt,le.populated_powid_status_public_pcnt,le.populated_seleid_status_public_pcnt,le.populated_orgid_status_public_pcnt,le.populated_ultid_status_public_pcnt,le.populated_contact_type_derived_pcnt,le.populated_contact_job_title_derived_pcnt,le.populated_contact_status_derived_pcnt,le.populated_address_type_derived_pcnt,le.populated_is_vanity_name_derived_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_source_expanded,le.maxlength_source,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_rcid,le.maxlength_company_bdid,le.maxlength_company_name,le.maxlength_company_name_type_raw,le.maxlength_company_rawaid,le.maxlength_company_address_prim_range,le.maxlength_company_address_predir,le.maxlength_company_address_prim_name,le.maxlength_company_address_addr_suffix,le.maxlength_company_address_postdir,le.maxlength_company_address_unit_desig,le.maxlength_company_address_sec_range,le.maxlength_company_address_p_city_name,le.maxlength_company_address_v_city_name,le.maxlength_company_address_st,le.maxlength_company_address_zip,le.maxlength_company_address_zip4,le.maxlength_company_address_cart,le.maxlength_company_address_cr_sort_sz,le.maxlength_company_address_lot,le.maxlength_company_address_lot_order,le.maxlength_company_address_dbpc,le.maxlength_company_address_chk_digit,le.maxlength_company_address_rec_type,le.maxlength_company_address_fips_state,le.maxlength_company_address_fips_county,le.maxlength_company_address_geo_lat,le.maxlength_company_address_geo_long,le.maxlength_company_address_msa,le.maxlength_company_address_geo_blk,le.maxlength_company_address_geo_match,le.maxlength_company_address_err_stat,le.maxlength_company_address_type_raw,le.maxlength_company_address_category,le.maxlength_company_address_country_code,le.maxlength_company_fein,le.maxlength_best_fein_indicator,le.maxlength_company_phone,le.maxlength_phone_type,le.maxlength_company_org_structure_raw,le.maxlength_company_incorporation_date,le.maxlength_company_sic_code1,le.maxlength_company_sic_code2,le.maxlength_company_sic_code3,le.maxlength_company_sic_code4,le.maxlength_company_sic_code5,le.maxlength_company_naics_code1,le.maxlength_company_naics_code2,le.maxlength_company_naics_code3,le.maxlength_company_naics_code4,le.maxlength_company_naics_code5,le.maxlength_company_ticker,le.maxlength_company_ticker_exchange,le.maxlength_company_foreign_domestic,le.maxlength_company_url,le.maxlength_company_inc_state,le.maxlength_company_charter_number,le.maxlength_company_filing_date,le.maxlength_company_status_date,le.maxlength_company_foreign_date,le.maxlength_event_filing_date,le.maxlength_company_name_status_raw,le.maxlength_company_status_raw,le.maxlength_dt_first_seen_company_name,le.maxlength_dt_last_seen_company_name,le.maxlength_dt_first_seen_company_address,le.maxlength_dt_last_seen_company_address,le.maxlength_vl_id,le.maxlength_current,le.maxlength_source_record_id,le.maxlength_glb,le.maxlength_dppa,le.maxlength_phone_score,le.maxlength_match_company_name,le.maxlength_match_branch_city,le.maxlength_match_geo_city,le.maxlength_duns_number,le.maxlength_source_docid,le.maxlength_is_contact,le.maxlength_dt_first_seen_contact,le.maxlength_dt_last_seen_contact,le.maxlength_contact_did,le.maxlength_contact_name_title,le.maxlength_contact_name_fname,le.maxlength_contact_name_lname,le.maxlength_contact_name_lname,le.maxlength_contact_name_name_suffix,le.maxlength_contact_name_name_score,le.maxlength_contact_type_raw,le.maxlength_contact_job_title_raw,le.maxlength_contact_ssn,le.maxlength_contact_dob,le.maxlength_contact_status_raw,le.maxlength_contact_email,le.maxlength_contact_email_username,le.maxlength_contact_email_domain,le.maxlength_contact_phone,le.maxlength_cid,le.maxlength_contact_score,le.maxlength_from_hdr,le.maxlength_company_department,le.maxlength_company_aceaid,le.maxlength_company_name_type_derived,le.maxlength_company_address_type_derived,le.maxlength_company_org_structure_derived,le.maxlength_company_name_status_derived,le.maxlength_company_status_derived,le.maxlength_proxid_status_private,le.maxlength_powid_status_private,le.maxlength_seleid_status_private,le.maxlength_orgid_status_private,le.maxlength_ultid_status_private,le.maxlength_proxid_status_public,le.maxlength_powid_status_public,le.maxlength_seleid_status_public,le.maxlength_orgid_status_public,le.maxlength_ultid_status_public,le.maxlength_contact_type_derived,le.maxlength_contact_job_title_derived,le.maxlength_contact_status_derived,le.maxlength_address_type_derived,le.maxlength_is_vanity_name_derived);
  SELF.avelength := CHOOSE(C,le.avelength_source_expanded,le.avelength_source,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_rcid,le.avelength_company_bdid,le.avelength_company_name,le.avelength_company_name_type_raw,le.avelength_company_rawaid,le.avelength_company_address_prim_range,le.avelength_company_address_predir,le.avelength_company_address_prim_name,le.avelength_company_address_addr_suffix,le.avelength_company_address_postdir,le.avelength_company_address_unit_desig,le.avelength_company_address_sec_range,le.avelength_company_address_p_city_name,le.avelength_company_address_v_city_name,le.avelength_company_address_st,le.avelength_company_address_zip,le.avelength_company_address_zip4,le.avelength_company_address_cart,le.avelength_company_address_cr_sort_sz,le.avelength_company_address_lot,le.avelength_company_address_lot_order,le.avelength_company_address_dbpc,le.avelength_company_address_chk_digit,le.avelength_company_address_rec_type,le.avelength_company_address_fips_state,le.avelength_company_address_fips_county,le.avelength_company_address_geo_lat,le.avelength_company_address_geo_long,le.avelength_company_address_msa,le.avelength_company_address_geo_blk,le.avelength_company_address_geo_match,le.avelength_company_address_err_stat,le.avelength_company_address_type_raw,le.avelength_company_address_category,le.avelength_company_address_country_code,le.avelength_company_fein,le.avelength_best_fein_indicator,le.avelength_company_phone,le.avelength_phone_type,le.avelength_company_org_structure_raw,le.avelength_company_incorporation_date,le.avelength_company_sic_code1,le.avelength_company_sic_code2,le.avelength_company_sic_code3,le.avelength_company_sic_code4,le.avelength_company_sic_code5,le.avelength_company_naics_code1,le.avelength_company_naics_code2,le.avelength_company_naics_code3,le.avelength_company_naics_code4,le.avelength_company_naics_code5,le.avelength_company_ticker,le.avelength_company_ticker_exchange,le.avelength_company_foreign_domestic,le.avelength_company_url,le.avelength_company_inc_state,le.avelength_company_charter_number,le.avelength_company_filing_date,le.avelength_company_status_date,le.avelength_company_foreign_date,le.avelength_event_filing_date,le.avelength_company_name_status_raw,le.avelength_company_status_raw,le.avelength_dt_first_seen_company_name,le.avelength_dt_last_seen_company_name,le.avelength_dt_first_seen_company_address,le.avelength_dt_last_seen_company_address,le.avelength_vl_id,le.avelength_current,le.avelength_source_record_id,le.avelength_glb,le.avelength_dppa,le.avelength_phone_score,le.avelength_match_company_name,le.avelength_match_branch_city,le.avelength_match_geo_city,le.avelength_duns_number,le.avelength_source_docid,le.avelength_is_contact,le.avelength_dt_first_seen_contact,le.avelength_dt_last_seen_contact,le.avelength_contact_did,le.avelength_contact_name_title,le.avelength_contact_name_fname,le.avelength_contact_name_lname,le.avelength_contact_name_lname,le.avelength_contact_name_name_suffix,le.avelength_contact_name_name_score,le.avelength_contact_type_raw,le.avelength_contact_job_title_raw,le.avelength_contact_ssn,le.avelength_contact_dob,le.avelength_contact_status_raw,le.avelength_contact_email,le.avelength_contact_email_username,le.avelength_contact_email_domain,le.avelength_contact_phone,le.avelength_cid,le.avelength_contact_score,le.avelength_from_hdr,le.avelength_company_department,le.avelength_company_aceaid,le.avelength_company_name_type_derived,le.avelength_company_address_type_derived,le.avelength_company_org_structure_derived,le.avelength_company_name_status_derived,le.avelength_company_status_derived,le.avelength_proxid_status_private,le.avelength_powid_status_private,le.avelength_seleid_status_private,le.avelength_orgid_status_private,le.avelength_ultid_status_private,le.avelength_proxid_status_public,le.avelength_powid_status_public,le.avelength_seleid_status_public,le.avelength_orgid_status_public,le.avelength_ultid_status_public,le.avelength_contact_type_derived,le.avelength_contact_job_title_derived,le.avelength_contact_status_derived,le.avelength_address_type_derived,le.avelength_is_vanity_name_derived);
END;
EXPORT invSummary := NORMALIZE(summary0, 128, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source_expanded;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.source_expanded),TRIM((SALT311.StrType)le.source),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.rcid <> 0,TRIM((SALT311.StrType)le.rcid), ''),IF (le.company_bdid <> 0,TRIM((SALT311.StrType)le.company_bdid), ''),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.company_name_type_raw),IF (le.company_rawaid <> 0,TRIM((SALT311.StrType)le.company_rawaid), ''),TRIM((SALT311.StrType)le.company_address_prim_range),TRIM((SALT311.StrType)le.company_address_predir),TRIM((SALT311.StrType)le.company_address_prim_name),TRIM((SALT311.StrType)le.company_address_addr_suffix),TRIM((SALT311.StrType)le.company_address_postdir),TRIM((SALT311.StrType)le.company_address_unit_desig),TRIM((SALT311.StrType)le.company_address_sec_range),TRIM((SALT311.StrType)le.company_address_p_city_name),TRIM((SALT311.StrType)le.company_address_v_city_name),TRIM((SALT311.StrType)le.company_address_st),TRIM((SALT311.StrType)le.company_address_zip),TRIM((SALT311.StrType)le.company_address_zip4),TRIM((SALT311.StrType)le.company_address_cart),TRIM((SALT311.StrType)le.company_address_cr_sort_sz),TRIM((SALT311.StrType)le.company_address_lot),TRIM((SALT311.StrType)le.company_address_lot_order),TRIM((SALT311.StrType)le.company_address_dbpc),TRIM((SALT311.StrType)le.company_address_chk_digit),TRIM((SALT311.StrType)le.company_address_rec_type),TRIM((SALT311.StrType)le.company_address_fips_state),TRIM((SALT311.StrType)le.company_address_fips_county),TRIM((SALT311.StrType)le.company_address_geo_lat),TRIM((SALT311.StrType)le.company_address_geo_long),TRIM((SALT311.StrType)le.company_address_msa),TRIM((SALT311.StrType)le.company_address_geo_blk),TRIM((SALT311.StrType)le.company_address_geo_match),TRIM((SALT311.StrType)le.company_address_err_stat),TRIM((SALT311.StrType)le.company_address_type_raw),TRIM((SALT311.StrType)le.company_address_category),TRIM((SALT311.StrType)le.company_address_country_code),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.best_fein_indicator),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.company_org_structure_raw),IF (le.company_incorporation_date <> 0,TRIM((SALT311.StrType)le.company_incorporation_date), ''),TRIM((SALT311.StrType)le.company_sic_code1),TRIM((SALT311.StrType)le.company_sic_code2),TRIM((SALT311.StrType)le.company_sic_code3),TRIM((SALT311.StrType)le.company_sic_code4),TRIM((SALT311.StrType)le.company_sic_code5),TRIM((SALT311.StrType)le.company_naics_code1),TRIM((SALT311.StrType)le.company_naics_code2),TRIM((SALT311.StrType)le.company_naics_code3),TRIM((SALT311.StrType)le.company_naics_code4),TRIM((SALT311.StrType)le.company_naics_code5),TRIM((SALT311.StrType)le.company_ticker),TRIM((SALT311.StrType)le.company_ticker_exchange),TRIM((SALT311.StrType)le.company_foreign_domestic),TRIM((SALT311.StrType)le.company_url),TRIM((SALT311.StrType)le.company_inc_state),TRIM((SALT311.StrType)le.company_charter_number),IF (le.company_filing_date <> 0,TRIM((SALT311.StrType)le.company_filing_date), ''),IF (le.company_status_date <> 0,TRIM((SALT311.StrType)le.company_status_date), ''),IF (le.company_foreign_date <> 0,TRIM((SALT311.StrType)le.company_foreign_date), ''),IF (le.event_filing_date <> 0,TRIM((SALT311.StrType)le.event_filing_date), ''),TRIM((SALT311.StrType)le.company_name_status_raw),TRIM((SALT311.StrType)le.company_status_raw),IF (le.dt_first_seen_company_name <> 0,TRIM((SALT311.StrType)le.dt_first_seen_company_name), ''),IF (le.dt_last_seen_company_name <> 0,TRIM((SALT311.StrType)le.dt_last_seen_company_name), ''),IF (le.dt_first_seen_company_address <> 0,TRIM((SALT311.StrType)le.dt_first_seen_company_address), ''),IF (le.dt_last_seen_company_address <> 0,TRIM((SALT311.StrType)le.dt_last_seen_company_address), ''),TRIM((SALT311.StrType)le.vl_id),TRIM((SALT311.StrType)le.current),IF (le.source_record_id <> 0,TRIM((SALT311.StrType)le.source_record_id), ''),TRIM((SALT311.StrType)le.glb),TRIM((SALT311.StrType)le.dppa),IF (le.phone_score <> 0,TRIM((SALT311.StrType)le.phone_score), ''),TRIM((SALT311.StrType)le.match_company_name),TRIM((SALT311.StrType)le.match_branch_city),TRIM((SALT311.StrType)le.match_geo_city),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.source_docid),TRIM((SALT311.StrType)le.is_contact),IF (le.dt_first_seen_contact <> 0,TRIM((SALT311.StrType)le.dt_first_seen_contact), ''),IF (le.dt_last_seen_contact <> 0,TRIM((SALT311.StrType)le.dt_last_seen_contact), ''),IF (le.contact_did <> 0,TRIM((SALT311.StrType)le.contact_did), ''),TRIM((SALT311.StrType)le.contact_name_title),TRIM((SALT311.StrType)le.contact_name_fname),TRIM((SALT311.StrType)le.contact_name_lname),TRIM((SALT311.StrType)le.contact_name_lname),TRIM((SALT311.StrType)le.contact_name_name_suffix),TRIM((SALT311.StrType)le.contact_name_name_score),TRIM((SALT311.StrType)le.contact_type_raw),TRIM((SALT311.StrType)le.contact_job_title_raw),TRIM((SALT311.StrType)le.contact_ssn),IF (le.contact_dob <> 0,TRIM((SALT311.StrType)le.contact_dob), ''),TRIM((SALT311.StrType)le.contact_status_raw),TRIM((SALT311.StrType)le.contact_email),TRIM((SALT311.StrType)le.contact_email_username),TRIM((SALT311.StrType)le.contact_email_domain),TRIM((SALT311.StrType)le.contact_phone),IF (le.cid <> 0,TRIM((SALT311.StrType)le.cid), ''),IF (le.contact_score <> 0,TRIM((SALT311.StrType)le.contact_score), ''),TRIM((SALT311.StrType)le.from_hdr),TRIM((SALT311.StrType)le.company_department),IF (le.company_aceaid <> 0,TRIM((SALT311.StrType)le.company_aceaid), ''),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.company_address_type_derived),TRIM((SALT311.StrType)le.company_org_structure_derived),TRIM((SALT311.StrType)le.company_name_status_derived),TRIM((SALT311.StrType)le.company_status_derived),TRIM((SALT311.StrType)le.proxid_status_private),TRIM((SALT311.StrType)le.powid_status_private),TRIM((SALT311.StrType)le.seleid_status_private),TRIM((SALT311.StrType)le.orgid_status_private),TRIM((SALT311.StrType)le.ultid_status_private),TRIM((SALT311.StrType)le.proxid_status_public),TRIM((SALT311.StrType)le.powid_status_public),TRIM((SALT311.StrType)le.seleid_status_public),TRIM((SALT311.StrType)le.orgid_status_public),TRIM((SALT311.StrType)le.ultid_status_public),TRIM((SALT311.StrType)le.contact_type_derived),TRIM((SALT311.StrType)le.contact_job_title_derived),TRIM((SALT311.StrType)le.contact_status_derived),TRIM((SALT311.StrType)le.address_type_derived),TRIM((SALT311.StrType)le.is_vanity_name_derived)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,128,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 128);
  SELF.FldNo2 := 1 + (C % 128);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.source_expanded),TRIM((SALT311.StrType)le.source),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.rcid <> 0,TRIM((SALT311.StrType)le.rcid), ''),IF (le.company_bdid <> 0,TRIM((SALT311.StrType)le.company_bdid), ''),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.company_name_type_raw),IF (le.company_rawaid <> 0,TRIM((SALT311.StrType)le.company_rawaid), ''),TRIM((SALT311.StrType)le.company_address_prim_range),TRIM((SALT311.StrType)le.company_address_predir),TRIM((SALT311.StrType)le.company_address_prim_name),TRIM((SALT311.StrType)le.company_address_addr_suffix),TRIM((SALT311.StrType)le.company_address_postdir),TRIM((SALT311.StrType)le.company_address_unit_desig),TRIM((SALT311.StrType)le.company_address_sec_range),TRIM((SALT311.StrType)le.company_address_p_city_name),TRIM((SALT311.StrType)le.company_address_v_city_name),TRIM((SALT311.StrType)le.company_address_st),TRIM((SALT311.StrType)le.company_address_zip),TRIM((SALT311.StrType)le.company_address_zip4),TRIM((SALT311.StrType)le.company_address_cart),TRIM((SALT311.StrType)le.company_address_cr_sort_sz),TRIM((SALT311.StrType)le.company_address_lot),TRIM((SALT311.StrType)le.company_address_lot_order),TRIM((SALT311.StrType)le.company_address_dbpc),TRIM((SALT311.StrType)le.company_address_chk_digit),TRIM((SALT311.StrType)le.company_address_rec_type),TRIM((SALT311.StrType)le.company_address_fips_state),TRIM((SALT311.StrType)le.company_address_fips_county),TRIM((SALT311.StrType)le.company_address_geo_lat),TRIM((SALT311.StrType)le.company_address_geo_long),TRIM((SALT311.StrType)le.company_address_msa),TRIM((SALT311.StrType)le.company_address_geo_blk),TRIM((SALT311.StrType)le.company_address_geo_match),TRIM((SALT311.StrType)le.company_address_err_stat),TRIM((SALT311.StrType)le.company_address_type_raw),TRIM((SALT311.StrType)le.company_address_category),TRIM((SALT311.StrType)le.company_address_country_code),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.best_fein_indicator),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.company_org_structure_raw),IF (le.company_incorporation_date <> 0,TRIM((SALT311.StrType)le.company_incorporation_date), ''),TRIM((SALT311.StrType)le.company_sic_code1),TRIM((SALT311.StrType)le.company_sic_code2),TRIM((SALT311.StrType)le.company_sic_code3),TRIM((SALT311.StrType)le.company_sic_code4),TRIM((SALT311.StrType)le.company_sic_code5),TRIM((SALT311.StrType)le.company_naics_code1),TRIM((SALT311.StrType)le.company_naics_code2),TRIM((SALT311.StrType)le.company_naics_code3),TRIM((SALT311.StrType)le.company_naics_code4),TRIM((SALT311.StrType)le.company_naics_code5),TRIM((SALT311.StrType)le.company_ticker),TRIM((SALT311.StrType)le.company_ticker_exchange),TRIM((SALT311.StrType)le.company_foreign_domestic),TRIM((SALT311.StrType)le.company_url),TRIM((SALT311.StrType)le.company_inc_state),TRIM((SALT311.StrType)le.company_charter_number),IF (le.company_filing_date <> 0,TRIM((SALT311.StrType)le.company_filing_date), ''),IF (le.company_status_date <> 0,TRIM((SALT311.StrType)le.company_status_date), ''),IF (le.company_foreign_date <> 0,TRIM((SALT311.StrType)le.company_foreign_date), ''),IF (le.event_filing_date <> 0,TRIM((SALT311.StrType)le.event_filing_date), ''),TRIM((SALT311.StrType)le.company_name_status_raw),TRIM((SALT311.StrType)le.company_status_raw),IF (le.dt_first_seen_company_name <> 0,TRIM((SALT311.StrType)le.dt_first_seen_company_name), ''),IF (le.dt_last_seen_company_name <> 0,TRIM((SALT311.StrType)le.dt_last_seen_company_name), ''),IF (le.dt_first_seen_company_address <> 0,TRIM((SALT311.StrType)le.dt_first_seen_company_address), ''),IF (le.dt_last_seen_company_address <> 0,TRIM((SALT311.StrType)le.dt_last_seen_company_address), ''),TRIM((SALT311.StrType)le.vl_id),TRIM((SALT311.StrType)le.current),IF (le.source_record_id <> 0,TRIM((SALT311.StrType)le.source_record_id), ''),TRIM((SALT311.StrType)le.glb),TRIM((SALT311.StrType)le.dppa),IF (le.phone_score <> 0,TRIM((SALT311.StrType)le.phone_score), ''),TRIM((SALT311.StrType)le.match_company_name),TRIM((SALT311.StrType)le.match_branch_city),TRIM((SALT311.StrType)le.match_geo_city),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.source_docid),TRIM((SALT311.StrType)le.is_contact),IF (le.dt_first_seen_contact <> 0,TRIM((SALT311.StrType)le.dt_first_seen_contact), ''),IF (le.dt_last_seen_contact <> 0,TRIM((SALT311.StrType)le.dt_last_seen_contact), ''),IF (le.contact_did <> 0,TRIM((SALT311.StrType)le.contact_did), ''),TRIM((SALT311.StrType)le.contact_name_title),TRIM((SALT311.StrType)le.contact_name_fname),TRIM((SALT311.StrType)le.contact_name_lname),TRIM((SALT311.StrType)le.contact_name_lname),TRIM((SALT311.StrType)le.contact_name_name_suffix),TRIM((SALT311.StrType)le.contact_name_name_score),TRIM((SALT311.StrType)le.contact_type_raw),TRIM((SALT311.StrType)le.contact_job_title_raw),TRIM((SALT311.StrType)le.contact_ssn),IF (le.contact_dob <> 0,TRIM((SALT311.StrType)le.contact_dob), ''),TRIM((SALT311.StrType)le.contact_status_raw),TRIM((SALT311.StrType)le.contact_email),TRIM((SALT311.StrType)le.contact_email_username),TRIM((SALT311.StrType)le.contact_email_domain),TRIM((SALT311.StrType)le.contact_phone),IF (le.cid <> 0,TRIM((SALT311.StrType)le.cid), ''),IF (le.contact_score <> 0,TRIM((SALT311.StrType)le.contact_score), ''),TRIM((SALT311.StrType)le.from_hdr),TRIM((SALT311.StrType)le.company_department),IF (le.company_aceaid <> 0,TRIM((SALT311.StrType)le.company_aceaid), ''),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.company_address_type_derived),TRIM((SALT311.StrType)le.company_org_structure_derived),TRIM((SALT311.StrType)le.company_name_status_derived),TRIM((SALT311.StrType)le.company_status_derived),TRIM((SALT311.StrType)le.proxid_status_private),TRIM((SALT311.StrType)le.powid_status_private),TRIM((SALT311.StrType)le.seleid_status_private),TRIM((SALT311.StrType)le.orgid_status_private),TRIM((SALT311.StrType)le.ultid_status_private),TRIM((SALT311.StrType)le.proxid_status_public),TRIM((SALT311.StrType)le.powid_status_public),TRIM((SALT311.StrType)le.seleid_status_public),TRIM((SALT311.StrType)le.orgid_status_public),TRIM((SALT311.StrType)le.ultid_status_public),TRIM((SALT311.StrType)le.contact_type_derived),TRIM((SALT311.StrType)le.contact_job_title_derived),TRIM((SALT311.StrType)le.contact_status_derived),TRIM((SALT311.StrType)le.address_type_derived),TRIM((SALT311.StrType)le.is_vanity_name_derived)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.source_expanded),TRIM((SALT311.StrType)le.source),IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.rcid <> 0,TRIM((SALT311.StrType)le.rcid), ''),IF (le.company_bdid <> 0,TRIM((SALT311.StrType)le.company_bdid), ''),TRIM((SALT311.StrType)le.company_name),TRIM((SALT311.StrType)le.company_name_type_raw),IF (le.company_rawaid <> 0,TRIM((SALT311.StrType)le.company_rawaid), ''),TRIM((SALT311.StrType)le.company_address_prim_range),TRIM((SALT311.StrType)le.company_address_predir),TRIM((SALT311.StrType)le.company_address_prim_name),TRIM((SALT311.StrType)le.company_address_addr_suffix),TRIM((SALT311.StrType)le.company_address_postdir),TRIM((SALT311.StrType)le.company_address_unit_desig),TRIM((SALT311.StrType)le.company_address_sec_range),TRIM((SALT311.StrType)le.company_address_p_city_name),TRIM((SALT311.StrType)le.company_address_v_city_name),TRIM((SALT311.StrType)le.company_address_st),TRIM((SALT311.StrType)le.company_address_zip),TRIM((SALT311.StrType)le.company_address_zip4),TRIM((SALT311.StrType)le.company_address_cart),TRIM((SALT311.StrType)le.company_address_cr_sort_sz),TRIM((SALT311.StrType)le.company_address_lot),TRIM((SALT311.StrType)le.company_address_lot_order),TRIM((SALT311.StrType)le.company_address_dbpc),TRIM((SALT311.StrType)le.company_address_chk_digit),TRIM((SALT311.StrType)le.company_address_rec_type),TRIM((SALT311.StrType)le.company_address_fips_state),TRIM((SALT311.StrType)le.company_address_fips_county),TRIM((SALT311.StrType)le.company_address_geo_lat),TRIM((SALT311.StrType)le.company_address_geo_long),TRIM((SALT311.StrType)le.company_address_msa),TRIM((SALT311.StrType)le.company_address_geo_blk),TRIM((SALT311.StrType)le.company_address_geo_match),TRIM((SALT311.StrType)le.company_address_err_stat),TRIM((SALT311.StrType)le.company_address_type_raw),TRIM((SALT311.StrType)le.company_address_category),TRIM((SALT311.StrType)le.company_address_country_code),TRIM((SALT311.StrType)le.company_fein),TRIM((SALT311.StrType)le.best_fein_indicator),TRIM((SALT311.StrType)le.company_phone),TRIM((SALT311.StrType)le.phone_type),TRIM((SALT311.StrType)le.company_org_structure_raw),IF (le.company_incorporation_date <> 0,TRIM((SALT311.StrType)le.company_incorporation_date), ''),TRIM((SALT311.StrType)le.company_sic_code1),TRIM((SALT311.StrType)le.company_sic_code2),TRIM((SALT311.StrType)le.company_sic_code3),TRIM((SALT311.StrType)le.company_sic_code4),TRIM((SALT311.StrType)le.company_sic_code5),TRIM((SALT311.StrType)le.company_naics_code1),TRIM((SALT311.StrType)le.company_naics_code2),TRIM((SALT311.StrType)le.company_naics_code3),TRIM((SALT311.StrType)le.company_naics_code4),TRIM((SALT311.StrType)le.company_naics_code5),TRIM((SALT311.StrType)le.company_ticker),TRIM((SALT311.StrType)le.company_ticker_exchange),TRIM((SALT311.StrType)le.company_foreign_domestic),TRIM((SALT311.StrType)le.company_url),TRIM((SALT311.StrType)le.company_inc_state),TRIM((SALT311.StrType)le.company_charter_number),IF (le.company_filing_date <> 0,TRIM((SALT311.StrType)le.company_filing_date), ''),IF (le.company_status_date <> 0,TRIM((SALT311.StrType)le.company_status_date), ''),IF (le.company_foreign_date <> 0,TRIM((SALT311.StrType)le.company_foreign_date), ''),IF (le.event_filing_date <> 0,TRIM((SALT311.StrType)le.event_filing_date), ''),TRIM((SALT311.StrType)le.company_name_status_raw),TRIM((SALT311.StrType)le.company_status_raw),IF (le.dt_first_seen_company_name <> 0,TRIM((SALT311.StrType)le.dt_first_seen_company_name), ''),IF (le.dt_last_seen_company_name <> 0,TRIM((SALT311.StrType)le.dt_last_seen_company_name), ''),IF (le.dt_first_seen_company_address <> 0,TRIM((SALT311.StrType)le.dt_first_seen_company_address), ''),IF (le.dt_last_seen_company_address <> 0,TRIM((SALT311.StrType)le.dt_last_seen_company_address), ''),TRIM((SALT311.StrType)le.vl_id),TRIM((SALT311.StrType)le.current),IF (le.source_record_id <> 0,TRIM((SALT311.StrType)le.source_record_id), ''),TRIM((SALT311.StrType)le.glb),TRIM((SALT311.StrType)le.dppa),IF (le.phone_score <> 0,TRIM((SALT311.StrType)le.phone_score), ''),TRIM((SALT311.StrType)le.match_company_name),TRIM((SALT311.StrType)le.match_branch_city),TRIM((SALT311.StrType)le.match_geo_city),TRIM((SALT311.StrType)le.duns_number),TRIM((SALT311.StrType)le.source_docid),TRIM((SALT311.StrType)le.is_contact),IF (le.dt_first_seen_contact <> 0,TRIM((SALT311.StrType)le.dt_first_seen_contact), ''),IF (le.dt_last_seen_contact <> 0,TRIM((SALT311.StrType)le.dt_last_seen_contact), ''),IF (le.contact_did <> 0,TRIM((SALT311.StrType)le.contact_did), ''),TRIM((SALT311.StrType)le.contact_name_title),TRIM((SALT311.StrType)le.contact_name_fname),TRIM((SALT311.StrType)le.contact_name_lname),TRIM((SALT311.StrType)le.contact_name_lname),TRIM((SALT311.StrType)le.contact_name_name_suffix),TRIM((SALT311.StrType)le.contact_name_name_score),TRIM((SALT311.StrType)le.contact_type_raw),TRIM((SALT311.StrType)le.contact_job_title_raw),TRIM((SALT311.StrType)le.contact_ssn),IF (le.contact_dob <> 0,TRIM((SALT311.StrType)le.contact_dob), ''),TRIM((SALT311.StrType)le.contact_status_raw),TRIM((SALT311.StrType)le.contact_email),TRIM((SALT311.StrType)le.contact_email_username),TRIM((SALT311.StrType)le.contact_email_domain),TRIM((SALT311.StrType)le.contact_phone),IF (le.cid <> 0,TRIM((SALT311.StrType)le.cid), ''),IF (le.contact_score <> 0,TRIM((SALT311.StrType)le.contact_score), ''),TRIM((SALT311.StrType)le.from_hdr),TRIM((SALT311.StrType)le.company_department),IF (le.company_aceaid <> 0,TRIM((SALT311.StrType)le.company_aceaid), ''),TRIM((SALT311.StrType)le.company_name_type_derived),TRIM((SALT311.StrType)le.company_address_type_derived),TRIM((SALT311.StrType)le.company_org_structure_derived),TRIM((SALT311.StrType)le.company_name_status_derived),TRIM((SALT311.StrType)le.company_status_derived),TRIM((SALT311.StrType)le.proxid_status_private),TRIM((SALT311.StrType)le.powid_status_private),TRIM((SALT311.StrType)le.seleid_status_private),TRIM((SALT311.StrType)le.orgid_status_private),TRIM((SALT311.StrType)le.ultid_status_private),TRIM((SALT311.StrType)le.proxid_status_public),TRIM((SALT311.StrType)le.powid_status_public),TRIM((SALT311.StrType)le.seleid_status_public),TRIM((SALT311.StrType)le.orgid_status_public),TRIM((SALT311.StrType)le.ultid_status_public),TRIM((SALT311.StrType)le.contact_type_derived),TRIM((SALT311.StrType)le.contact_job_title_derived),TRIM((SALT311.StrType)le.contact_status_derived),TRIM((SALT311.StrType)le.address_type_derived),TRIM((SALT311.StrType)le.is_vanity_name_derived)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),128*128,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'source_expanded'}
      ,{2,'source'}
      ,{3,'dt_first_seen'}
      ,{4,'dt_last_seen'}
      ,{5,'dt_vendor_first_reported'}
      ,{6,'dt_vendor_last_reported'}
      ,{7,'rcid'}
      ,{8,'company_bdid'}
      ,{9,'company_name'}
      ,{10,'company_name_type_raw'}
      ,{11,'company_rawaid'}
      ,{12,'company_address_prim_range'}
      ,{13,'company_address_predir'}
      ,{14,'company_address_prim_name'}
      ,{15,'company_address_addr_suffix'}
      ,{16,'company_address_postdir'}
      ,{17,'company_address_unit_desig'}
      ,{18,'company_address_sec_range'}
      ,{19,'company_address_p_city_name'}
      ,{20,'company_address_v_city_name'}
      ,{21,'company_address_st'}
      ,{22,'company_address_zip'}
      ,{23,'company_address_zip4'}
      ,{24,'company_address_cart'}
      ,{25,'company_address_cr_sort_sz'}
      ,{26,'company_address_lot'}
      ,{27,'company_address_lot_order'}
      ,{28,'company_address_dbpc'}
      ,{29,'company_address_chk_digit'}
      ,{30,'company_address_rec_type'}
      ,{31,'company_address_fips_state'}
      ,{32,'company_address_fips_county'}
      ,{33,'company_address_geo_lat'}
      ,{34,'company_address_geo_long'}
      ,{35,'company_address_msa'}
      ,{36,'company_address_geo_blk'}
      ,{37,'company_address_geo_match'}
      ,{38,'company_address_err_stat'}
      ,{39,'company_address_type_raw'}
      ,{40,'company_address_category'}
      ,{41,'company_address_country_code'}
      ,{42,'company_fein'}
      ,{43,'best_fein_indicator'}
      ,{44,'company_phone'}
      ,{45,'phone_type'}
      ,{46,'company_org_structure_raw'}
      ,{47,'company_incorporation_date'}
      ,{48,'company_sic_code1'}
      ,{49,'company_sic_code2'}
      ,{50,'company_sic_code3'}
      ,{51,'company_sic_code4'}
      ,{52,'company_sic_code5'}
      ,{53,'company_naics_code1'}
      ,{54,'company_naics_code2'}
      ,{55,'company_naics_code3'}
      ,{56,'company_naics_code4'}
      ,{57,'company_naics_code5'}
      ,{58,'company_ticker'}
      ,{59,'company_ticker_exchange'}
      ,{60,'company_foreign_domestic'}
      ,{61,'company_url'}
      ,{62,'company_inc_state'}
      ,{63,'company_charter_number'}
      ,{64,'company_filing_date'}
      ,{65,'company_status_date'}
      ,{66,'company_foreign_date'}
      ,{67,'event_filing_date'}
      ,{68,'company_name_status_raw'}
      ,{69,'company_status_raw'}
      ,{70,'dt_first_seen_company_name'}
      ,{71,'dt_last_seen_company_name'}
      ,{72,'dt_first_seen_company_address'}
      ,{73,'dt_last_seen_company_address'}
      ,{74,'vl_id'}
      ,{75,'current'}
      ,{76,'source_record_id'}
      ,{77,'glb'}
      ,{78,'dppa'}
      ,{79,'phone_score'}
      ,{80,'match_company_name'}
      ,{81,'match_branch_city'}
      ,{82,'match_geo_city'}
      ,{83,'duns_number'}
      ,{84,'source_docid'}
      ,{85,'is_contact'}
      ,{86,'dt_first_seen_contact'}
      ,{87,'dt_last_seen_contact'}
      ,{88,'contact_did'}
      ,{89,'contact_name_title'}
      ,{90,'contact_name_fname'}
      ,{91,'contact_name_lname'}
      ,{92,'contact_name_lname'}
      ,{93,'contact_name_name_suffix'}
      ,{94,'contact_name_name_score'}
      ,{95,'contact_type_raw'}
      ,{96,'contact_job_title_raw'}
      ,{97,'contact_ssn'}
      ,{98,'contact_dob'}
      ,{99,'contact_status_raw'}
      ,{100,'contact_email'}
      ,{101,'contact_email_username'}
      ,{102,'contact_email_domain'}
      ,{103,'contact_phone'}
      ,{104,'cid'}
      ,{105,'contact_score'}
      ,{106,'from_hdr'}
      ,{107,'company_department'}
      ,{108,'company_aceaid'}
      ,{109,'company_name_type_derived'}
      ,{110,'company_address_type_derived'}
      ,{111,'company_org_structure_derived'}
      ,{112,'company_name_status_derived'}
      ,{113,'company_status_derived'}
      ,{114,'proxid_status_private'}
      ,{115,'powid_status_private'}
      ,{116,'seleid_status_private'}
      ,{117,'orgid_status_private'}
      ,{118,'ultid_status_private'}
      ,{119,'proxid_status_public'}
      ,{120,'powid_status_public'}
      ,{121,'seleid_status_public'}
      ,{122,'orgid_status_public'}
      ,{123,'ultid_status_public'}
      ,{124,'contact_type_derived'}
      ,{125,'contact_job_title_derived'}
      ,{126,'contact_status_derived'}
      ,{127,'address_type_derived'}
      ,{128,'is_vanity_name_derived'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source_expanded) source_expanded; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Ingest_Fields.InValid_source_expanded((SALT311.StrType)le.source_expanded),
    Ingest_Fields.InValid_source((SALT311.StrType)le.source),
    Ingest_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen),
    Ingest_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Ingest_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported),
    Ingest_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Ingest_Fields.InValid_rcid((SALT311.StrType)le.rcid),
    Ingest_Fields.InValid_company_bdid((SALT311.StrType)le.company_bdid),
    Ingest_Fields.InValid_company_name((SALT311.StrType)le.company_name),
    Ingest_Fields.InValid_company_name_type_raw((SALT311.StrType)le.company_name_type_raw,(SALT311.StrType)le.company_name_type_derived),
    Ingest_Fields.InValid_company_rawaid((SALT311.StrType)le.company_rawaid),
    Ingest_Fields.InValid_company_address_prim_range((SALT311.StrType)le.company_address_prim_range),
    Ingest_Fields.InValid_company_address_predir((SALT311.StrType)le.company_address_predir),
    Ingest_Fields.InValid_company_address_prim_name((SALT311.StrType)le.company_address_prim_name),
    Ingest_Fields.InValid_company_address_addr_suffix((SALT311.StrType)le.company_address_addr_suffix),
    Ingest_Fields.InValid_company_address_postdir((SALT311.StrType)le.company_address_postdir),
    Ingest_Fields.InValid_company_address_unit_desig((SALT311.StrType)le.company_address_unit_desig),
    Ingest_Fields.InValid_company_address_sec_range((SALT311.StrType)le.company_address_sec_range),
    Ingest_Fields.InValid_company_address_p_city_name((SALT311.StrType)le.company_address_p_city_name,(SALT311.StrType)le.company_address_v_city_name),
    Ingest_Fields.InValid_company_address_v_city_name((SALT311.StrType)le.company_address_v_city_name,(SALT311.StrType)le.company_address_p_city_name),
    Ingest_Fields.InValid_company_address_st((SALT311.StrType)le.company_address_st),
    Ingest_Fields.InValid_company_address_zip((SALT311.StrType)le.company_address_zip),
    Ingest_Fields.InValid_company_address_zip4((SALT311.StrType)le.company_address_zip4),
    Ingest_Fields.InValid_company_address_cart((SALT311.StrType)le.company_address_cart),
    Ingest_Fields.InValid_company_address_cr_sort_sz((SALT311.StrType)le.company_address_cr_sort_sz),
    Ingest_Fields.InValid_company_address_lot((SALT311.StrType)le.company_address_lot),
    Ingest_Fields.InValid_company_address_lot_order((SALT311.StrType)le.company_address_lot_order),
    Ingest_Fields.InValid_company_address_dbpc((SALT311.StrType)le.company_address_dbpc),
    Ingest_Fields.InValid_company_address_chk_digit((SALT311.StrType)le.company_address_chk_digit),
    Ingest_Fields.InValid_company_address_rec_type((SALT311.StrType)le.company_address_rec_type),
    Ingest_Fields.InValid_company_address_fips_state((SALT311.StrType)le.company_address_fips_state),
    Ingest_Fields.InValid_company_address_fips_county((SALT311.StrType)le.company_address_fips_county),
    Ingest_Fields.InValid_company_address_geo_lat((SALT311.StrType)le.company_address_geo_lat),
    Ingest_Fields.InValid_company_address_geo_long((SALT311.StrType)le.company_address_geo_long),
    Ingest_Fields.InValid_company_address_msa((SALT311.StrType)le.company_address_msa),
    Ingest_Fields.InValid_company_address_geo_blk((SALT311.StrType)le.company_address_geo_blk),
    Ingest_Fields.InValid_company_address_geo_match((SALT311.StrType)le.company_address_geo_match),
    Ingest_Fields.InValid_company_address_err_stat((SALT311.StrType)le.company_address_err_stat),
    Ingest_Fields.InValid_company_address_type_raw((SALT311.StrType)le.company_address_type_raw,(SALT311.StrType)le.company_address_type_derived),
    Ingest_Fields.InValid_company_address_category((SALT311.StrType)le.company_address_category),
    Ingest_Fields.InValid_company_address_country_code((SALT311.StrType)le.company_address_country_code),
    Ingest_Fields.InValid_company_fein((SALT311.StrType)le.company_fein),
    Ingest_Fields.InValid_best_fein_indicator((SALT311.StrType)le.best_fein_indicator),
    Ingest_Fields.InValid_company_phone((SALT311.StrType)le.company_phone),
    Ingest_Fields.InValid_phone_type((SALT311.StrType)le.phone_type),
    Ingest_Fields.InValid_company_org_structure_raw((SALT311.StrType)le.company_org_structure_raw,(SALT311.StrType)le.company_org_structure_derived),
    Ingest_Fields.InValid_company_incorporation_date((SALT311.StrType)le.company_incorporation_date),
    Ingest_Fields.InValid_company_sic_code1((SALT311.StrType)le.company_sic_code1),
    Ingest_Fields.InValid_company_sic_code2((SALT311.StrType)le.company_sic_code2),
    Ingest_Fields.InValid_company_sic_code3((SALT311.StrType)le.company_sic_code3),
    Ingest_Fields.InValid_company_sic_code4((SALT311.StrType)le.company_sic_code4),
    Ingest_Fields.InValid_company_sic_code5((SALT311.StrType)le.company_sic_code5),
    Ingest_Fields.InValid_company_naics_code1((SALT311.StrType)le.company_naics_code1),
    Ingest_Fields.InValid_company_naics_code2((SALT311.StrType)le.company_naics_code2),
    Ingest_Fields.InValid_company_naics_code3((SALT311.StrType)le.company_naics_code3),
    Ingest_Fields.InValid_company_naics_code4((SALT311.StrType)le.company_naics_code4),
    Ingest_Fields.InValid_company_naics_code5((SALT311.StrType)le.company_naics_code5),
    Ingest_Fields.InValid_company_ticker((SALT311.StrType)le.company_ticker,(SALT311.StrType)le.company_ticker_exchange),
    Ingest_Fields.InValid_company_ticker_exchange((SALT311.StrType)le.company_ticker_exchange,(SALT311.StrType)le.company_ticker),
    Ingest_Fields.InValid_company_foreign_domestic((SALT311.StrType)le.company_foreign_domestic),
    Ingest_Fields.InValid_company_url((SALT311.StrType)le.company_url),
    Ingest_Fields.InValid_company_inc_state((SALT311.StrType)le.company_inc_state),
    Ingest_Fields.InValid_company_charter_number((SALT311.StrType)le.company_charter_number),
    Ingest_Fields.InValid_company_filing_date((SALT311.StrType)le.company_filing_date),
    Ingest_Fields.InValid_company_status_date((SALT311.StrType)le.company_status_date),
    Ingest_Fields.InValid_company_foreign_date((SALT311.StrType)le.company_foreign_date),
    Ingest_Fields.InValid_event_filing_date((SALT311.StrType)le.event_filing_date),
    Ingest_Fields.InValid_company_name_status_raw((SALT311.StrType)le.company_name_status_raw),
    Ingest_Fields.InValid_company_status_raw((SALT311.StrType)le.company_status_raw,(SALT311.StrType)le.company_status_derived),
    Ingest_Fields.InValid_dt_first_seen_company_name((SALT311.StrType)le.dt_first_seen_company_name),
    Ingest_Fields.InValid_dt_last_seen_company_name((SALT311.StrType)le.dt_last_seen_company_name),
    Ingest_Fields.InValid_dt_first_seen_company_address((SALT311.StrType)le.dt_first_seen_company_address),
    Ingest_Fields.InValid_dt_last_seen_company_address((SALT311.StrType)le.dt_last_seen_company_address),
    Ingest_Fields.InValid_vl_id((SALT311.StrType)le.vl_id),
    Ingest_Fields.InValid_current((SALT311.StrType)le.current),
    Ingest_Fields.InValid_source_record_id((SALT311.StrType)le.source_record_id),
    Ingest_Fields.InValid_glb((SALT311.StrType)le.glb),
    Ingest_Fields.InValid_dppa((SALT311.StrType)le.dppa),
    Ingest_Fields.InValid_phone_score((SALT311.StrType)le.phone_score),
    Ingest_Fields.InValid_match_company_name((SALT311.StrType)le.match_company_name),
    Ingest_Fields.InValid_match_branch_city((SALT311.StrType)le.match_branch_city),
    Ingest_Fields.InValid_match_geo_city((SALT311.StrType)le.match_geo_city),
    Ingest_Fields.InValid_duns_number((SALT311.StrType)le.duns_number),
    Ingest_Fields.InValid_source_docid((SALT311.StrType)le.source_docid),
    Ingest_Fields.InValid_is_contact((SALT311.StrType)le.is_contact,(SALT311.StrType)le.contact_name_fname,(SALT311.StrType)le.contact_name_lname),
    Ingest_Fields.InValid_dt_first_seen_contact((SALT311.StrType)le.dt_first_seen_contact),
    Ingest_Fields.InValid_dt_last_seen_contact((SALT311.StrType)le.dt_last_seen_contact),
    Ingest_Fields.InValid_contact_did((SALT311.StrType)le.contact_did,(SALT311.StrType)le.contact_name_fname,(SALT311.StrType)le.contact_name_lname),
    Ingest_Fields.InValid_contact_name_title((SALT311.StrType)le.contact_name_title),
    Ingest_Fields.InValid_contact_name_fname((SALT311.StrType)le.contact_name_fname,(SALT311.StrType)le.contact_name_lname),
    Ingest_Fields.InValid_contact_name_lname((SALT311.StrType)le.contact_name_lname,(SALT311.StrType)le.contact_name_fname),
    Ingest_Fields.InValid_contact_name_lname((SALT311.StrType)le.contact_name_lname),
    Ingest_Fields.InValid_contact_name_name_suffix((SALT311.StrType)le.contact_name_name_suffix),
    Ingest_Fields.InValid_contact_name_name_score((SALT311.StrType)le.contact_name_name_score),
    Ingest_Fields.InValid_contact_type_raw((SALT311.StrType)le.contact_type_raw,(SALT311.StrType)le.contact_type_derived),
    Ingest_Fields.InValid_contact_job_title_raw((SALT311.StrType)le.contact_job_title_raw,(SALT311.StrType)le.contact_job_title_derived),
    Ingest_Fields.InValid_contact_ssn((SALT311.StrType)le.contact_ssn),
    Ingest_Fields.InValid_contact_dob((SALT311.StrType)le.contact_dob),
    Ingest_Fields.InValid_contact_status_raw((SALT311.StrType)le.contact_status_raw),
    Ingest_Fields.InValid_contact_email((SALT311.StrType)le.contact_email),
    Ingest_Fields.InValid_contact_email_username((SALT311.StrType)le.contact_email_username),
    Ingest_Fields.InValid_contact_email_domain((SALT311.StrType)le.contact_email_domain),
    Ingest_Fields.InValid_contact_phone((SALT311.StrType)le.contact_phone),
    Ingest_Fields.InValid_cid((SALT311.StrType)le.cid),
    Ingest_Fields.InValid_contact_score((SALT311.StrType)le.contact_score),
    Ingest_Fields.InValid_from_hdr((SALT311.StrType)le.from_hdr),
    Ingest_Fields.InValid_company_department((SALT311.StrType)le.company_department),
    Ingest_Fields.InValid_company_aceaid((SALT311.StrType)le.company_aceaid),
    Ingest_Fields.InValid_company_name_type_derived((SALT311.StrType)le.company_name_type_derived,(SALT311.StrType)le.company_name_type_raw),
    Ingest_Fields.InValid_company_address_type_derived((SALT311.StrType)le.company_address_type_derived,(SALT311.StrType)le.company_address_type_raw),
    Ingest_Fields.InValid_company_org_structure_derived((SALT311.StrType)le.company_org_structure_derived,(SALT311.StrType)le.company_org_structure_raw),
    Ingest_Fields.InValid_company_name_status_derived((SALT311.StrType)le.company_name_status_derived,(SALT311.StrType)le.company_name_status_raw),
    Ingest_Fields.InValid_company_status_derived((SALT311.StrType)le.company_status_derived,(SALT311.StrType)le.company_status_raw),
    Ingest_Fields.InValid_proxid_status_private((SALT311.StrType)le.proxid_status_private),
    Ingest_Fields.InValid_powid_status_private((SALT311.StrType)le.powid_status_private),
    Ingest_Fields.InValid_seleid_status_private((SALT311.StrType)le.seleid_status_private),
    Ingest_Fields.InValid_orgid_status_private((SALT311.StrType)le.orgid_status_private),
    Ingest_Fields.InValid_ultid_status_private((SALT311.StrType)le.ultid_status_private),
    Ingest_Fields.InValid_proxid_status_public((SALT311.StrType)le.proxid_status_public),
    Ingest_Fields.InValid_powid_status_public((SALT311.StrType)le.powid_status_public),
    Ingest_Fields.InValid_seleid_status_public((SALT311.StrType)le.seleid_status_public),
    Ingest_Fields.InValid_orgid_status_public((SALT311.StrType)le.orgid_status_public),
    Ingest_Fields.InValid_ultid_status_public((SALT311.StrType)le.ultid_status_public),
    Ingest_Fields.InValid_contact_type_derived((SALT311.StrType)le.contact_type_derived,(SALT311.StrType)le.contact_type_raw),
    Ingest_Fields.InValid_contact_job_title_derived((SALT311.StrType)le.contact_job_title_derived,(SALT311.StrType)le.contact_job_title_raw),
    Ingest_Fields.InValid_contact_status_derived((SALT311.StrType)le.contact_status_derived,(SALT311.StrType)le.contact_status_raw),
    Ingest_Fields.InValid_address_type_derived((SALT311.StrType)le.address_type_derived),
    Ingest_Fields.InValid_is_vanity_name_derived((SALT311.StrType)le.is_vanity_name_derived),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source_expanded := le.source_expanded;
END;
Errors := NORMALIZE(h,128,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source_expanded;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source_expanded,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source_expanded;
  FieldNme := Ingest_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_source','invalid_dt_first_seen','invalid_opt_pastdate8','invalid_dt_vendor_first_reported','invalid_pastdate8','invalid_empty','invalid_mandatory','invalid_mandatory','invalid_company_name_type_raw','invalid_company_rawaid','Unknown','invalid_direction','invalid_mandatory','Unknown','invalid_direction','Unknown','Unknown','invalid_company_address_p_city_name','invalid_company_address_v_city_name','invalid_st','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_rec_type','invalid_fips_state','invalid_fips_county','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','invalid_company_address_type_raw','Unknown','Unknown','invalid_company_fein','invalid_best_fein_indicator','invalid_company_phone','invalid_phone_type','invalid_company_org_structure_raw','invalid_opt_pastdate8','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_naics','invalid_company_ticker','invalid_company_ticker_exchange','invalid_company_foreign_domestic','invalid_company_url','invalid_company_inc_state','Unknown','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_company_name_status_raw','invalid_company_status_raw','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_mandatory','invalid_boolean_1','invalid_mandatory_numeric','invalid_boolean_1','invalid_boolean_1','Unknown','Unknown','Unknown','Unknown','invalid_duns_number','Unknown','invalid_is_contact','invalid_opt_pastdate8','invalid_opt_pastdate8','invalid_contact_did','Unknown','invalid_contact_name_fname','invalid_contact_name_lname','Unknown','Unknown','invalid_percentage','invalid_contact_type_raw','invalid_contact_job_title_raw','invalid_contact_ssn','invalid_contact_dob','invalid_contact_status_raw','Unknown','Unknown','Unknown','invalid_contact_phone','Unknown','Unknown','invalid_boolean','Unknown','Unknown','invalid_company_name_type_derived','invalid_company_address_type_derived','invalid_company_org_structure_derived','invalid_company_name_status_derived','invalid_company_status_derived','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_contact_type_derived','invalid_contact_job_title_derived','invalid_contact_status_derived','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Ingest_Fields.InValidMessage_source_expanded(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_source(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_rcid(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_bdid(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_name(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_name_type_raw(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_rawaid(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_prim_range(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_predir(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_prim_name(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_addr_suffix(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_postdir(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_unit_desig(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_sec_range(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_p_city_name(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_v_city_name(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_st(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_zip(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_zip4(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_cart(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_cr_sort_sz(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_lot(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_lot_order(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_dbpc(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_chk_digit(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_rec_type(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_fips_state(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_fips_county(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_geo_lat(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_geo_long(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_msa(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_geo_blk(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_geo_match(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_err_stat(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_type_raw(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_category(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_country_code(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_fein(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_best_fein_indicator(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_phone(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_phone_type(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_org_structure_raw(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_incorporation_date(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_sic_code1(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_sic_code2(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_sic_code3(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_sic_code4(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_sic_code5(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_naics_code1(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_naics_code2(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_naics_code3(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_naics_code4(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_naics_code5(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_ticker(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_ticker_exchange(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_foreign_domestic(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_url(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_inc_state(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_charter_number(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_filing_date(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_status_date(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_foreign_date(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_event_filing_date(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_name_status_raw(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_status_raw(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_first_seen_company_name(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_last_seen_company_name(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_first_seen_company_address(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_last_seen_company_address(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_vl_id(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_current(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_source_record_id(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_glb(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dppa(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_phone_score(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_match_company_name(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_match_branch_city(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_match_geo_city(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_duns_number(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_source_docid(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_is_contact(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_first_seen_contact(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_dt_last_seen_contact(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_did(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_name_title(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_name_fname(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_name_lname(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_name_lname(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_name_name_suffix(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_name_name_score(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_type_raw(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_job_title_raw(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_ssn(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_dob(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_status_raw(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_email(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_email_username(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_email_domain(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_cid(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_score(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_from_hdr(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_department(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_aceaid(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_name_type_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_address_type_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_org_structure_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_name_status_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_company_status_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_proxid_status_private(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_powid_status_private(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_seleid_status_private(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_orgid_status_private(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_ultid_status_private(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_proxid_status_public(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_powid_status_public(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_seleid_status_public(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_orgid_status_public(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_ultid_status_public(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_type_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_job_title_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_contact_status_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_address_type_derived(TotalErrors.ErrorNum),Ingest_Fields.InValidMessage_is_vanity_name_derived(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source_expanded=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_BIPV2, Ingest_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
