IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Property_Characteristics) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.vendor_source))'', MAX(GROUP,h.vendor_source));
    NumberOfRecords := COUNT(GROUP);
    populated_property_rid_cnt := COUNT(GROUP,h.property_rid <> (TYPEOF(h.property_rid))'');
    populated_property_rid_pcnt := AVE(GROUP,IF(h.property_rid = (TYPEOF(h.property_rid))'',0,100));
    maxlength_property_rid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_rid)));
    avelength_property_rid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_rid)),h.property_rid<>(typeof(h.property_rid))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_tax_sortby_date_cnt := COUNT(GROUP,h.tax_sortby_date <> (TYPEOF(h.tax_sortby_date))'');
    populated_tax_sortby_date_pcnt := AVE(GROUP,IF(h.tax_sortby_date = (TYPEOF(h.tax_sortby_date))'',0,100));
    maxlength_tax_sortby_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_sortby_date)));
    avelength_tax_sortby_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_sortby_date)),h.tax_sortby_date<>(typeof(h.tax_sortby_date))'');
    populated_deed_sortby_date_cnt := COUNT(GROUP,h.deed_sortby_date <> (TYPEOF(h.deed_sortby_date))'');
    populated_deed_sortby_date_pcnt := AVE(GROUP,IF(h.deed_sortby_date = (TYPEOF(h.deed_sortby_date))'',0,100));
    maxlength_deed_sortby_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_sortby_date)));
    avelength_deed_sortby_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_sortby_date)),h.deed_sortby_date<>(typeof(h.deed_sortby_date))'');
    populated_vendor_source_cnt := COUNT(GROUP,h.vendor_source <> (TYPEOF(h.vendor_source))'');
    populated_vendor_source_pcnt := AVE(GROUP,IF(h.vendor_source = (TYPEOF(h.vendor_source))'',0,100));
    maxlength_vendor_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_source)));
    avelength_vendor_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.vendor_source)),h.vendor_source<>(typeof(h.vendor_source))'');
    populated_fares_unformatted_apn_cnt := COUNT(GROUP,h.fares_unformatted_apn <> (TYPEOF(h.fares_unformatted_apn))'');
    populated_fares_unformatted_apn_pcnt := AVE(GROUP,IF(h.fares_unformatted_apn = (TYPEOF(h.fares_unformatted_apn))'',0,100));
    maxlength_fares_unformatted_apn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fares_unformatted_apn)));
    avelength_fares_unformatted_apn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fares_unformatted_apn)),h.fares_unformatted_apn<>(typeof(h.fares_unformatted_apn))'');
    populated_property_street_address_cnt := COUNT(GROUP,h.property_street_address <> (TYPEOF(h.property_street_address))'');
    populated_property_street_address_pcnt := AVE(GROUP,IF(h.property_street_address = (TYPEOF(h.property_street_address))'',0,100));
    maxlength_property_street_address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_street_address)));
    avelength_property_street_address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_street_address)),h.property_street_address<>(typeof(h.property_street_address))'');
    populated_property_city_state_zip_cnt := COUNT(GROUP,h.property_city_state_zip <> (TYPEOF(h.property_city_state_zip))'');
    populated_property_city_state_zip_pcnt := AVE(GROUP,IF(h.property_city_state_zip = (TYPEOF(h.property_city_state_zip))'',0,100));
    maxlength_property_city_state_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_city_state_zip)));
    avelength_property_city_state_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_city_state_zip)),h.property_city_state_zip<>(typeof(h.property_city_state_zip))'');
    populated_property_raw_aid_cnt := COUNT(GROUP,h.property_raw_aid <> (TYPEOF(h.property_raw_aid))'');
    populated_property_raw_aid_pcnt := AVE(GROUP,IF(h.property_raw_aid = (TYPEOF(h.property_raw_aid))'',0,100));
    maxlength_property_raw_aid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_raw_aid)));
    avelength_property_raw_aid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_raw_aid)),h.property_raw_aid<>(typeof(h.property_raw_aid))'');
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
    populated_addr_suffix_cnt := COUNT(GROUP,h.addr_suffix <> (TYPEOF(h.addr_suffix))'');
    populated_addr_suffix_pcnt := AVE(GROUP,IF(h.addr_suffix = (TYPEOF(h.addr_suffix))'',0,100));
    maxlength_addr_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)));
    avelength_addr_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addr_suffix)),h.addr_suffix<>(typeof(h.addr_suffix))'');
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
    populated_building_square_footage_cnt := COUNT(GROUP,h.building_square_footage <> (TYPEOF(h.building_square_footage))'');
    populated_building_square_footage_pcnt := AVE(GROUP,IF(h.building_square_footage = (TYPEOF(h.building_square_footage))'',0,100));
    maxlength_building_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_square_footage)));
    avelength_building_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.building_square_footage)),h.building_square_footage<>(typeof(h.building_square_footage))'');
    populated_src_building_square_footage_cnt := COUNT(GROUP,h.src_building_square_footage <> (TYPEOF(h.src_building_square_footage))'');
    populated_src_building_square_footage_pcnt := AVE(GROUP,IF(h.src_building_square_footage = (TYPEOF(h.src_building_square_footage))'',0,100));
    maxlength_src_building_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_building_square_footage)));
    avelength_src_building_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_building_square_footage)),h.src_building_square_footage<>(typeof(h.src_building_square_footage))'');
    populated_tax_dt_building_square_footage_cnt := COUNT(GROUP,h.tax_dt_building_square_footage <> (TYPEOF(h.tax_dt_building_square_footage))'');
    populated_tax_dt_building_square_footage_pcnt := AVE(GROUP,IF(h.tax_dt_building_square_footage = (TYPEOF(h.tax_dt_building_square_footage))'',0,100));
    maxlength_tax_dt_building_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_building_square_footage)));
    avelength_tax_dt_building_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_building_square_footage)),h.tax_dt_building_square_footage<>(typeof(h.tax_dt_building_square_footage))'');
    populated_air_conditioning_type_cnt := COUNT(GROUP,h.air_conditioning_type <> (TYPEOF(h.air_conditioning_type))'');
    populated_air_conditioning_type_pcnt := AVE(GROUP,IF(h.air_conditioning_type = (TYPEOF(h.air_conditioning_type))'',0,100));
    maxlength_air_conditioning_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_conditioning_type)));
    avelength_air_conditioning_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.air_conditioning_type)),h.air_conditioning_type<>(typeof(h.air_conditioning_type))'');
    populated_src_air_conditioning_type_cnt := COUNT(GROUP,h.src_air_conditioning_type <> (TYPEOF(h.src_air_conditioning_type))'');
    populated_src_air_conditioning_type_pcnt := AVE(GROUP,IF(h.src_air_conditioning_type = (TYPEOF(h.src_air_conditioning_type))'',0,100));
    maxlength_src_air_conditioning_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_air_conditioning_type)));
    avelength_src_air_conditioning_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_air_conditioning_type)),h.src_air_conditioning_type<>(typeof(h.src_air_conditioning_type))'');
    populated_tax_dt_air_conditioning_type_cnt := COUNT(GROUP,h.tax_dt_air_conditioning_type <> (TYPEOF(h.tax_dt_air_conditioning_type))'');
    populated_tax_dt_air_conditioning_type_pcnt := AVE(GROUP,IF(h.tax_dt_air_conditioning_type = (TYPEOF(h.tax_dt_air_conditioning_type))'',0,100));
    maxlength_tax_dt_air_conditioning_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_air_conditioning_type)));
    avelength_tax_dt_air_conditioning_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_air_conditioning_type)),h.tax_dt_air_conditioning_type<>(typeof(h.tax_dt_air_conditioning_type))'');
    populated_basement_finish_cnt := COUNT(GROUP,h.basement_finish <> (TYPEOF(h.basement_finish))'');
    populated_basement_finish_pcnt := AVE(GROUP,IF(h.basement_finish = (TYPEOF(h.basement_finish))'',0,100));
    maxlength_basement_finish := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.basement_finish)));
    avelength_basement_finish := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.basement_finish)),h.basement_finish<>(typeof(h.basement_finish))'');
    populated_src_basement_finish_cnt := COUNT(GROUP,h.src_basement_finish <> (TYPEOF(h.src_basement_finish))'');
    populated_src_basement_finish_pcnt := AVE(GROUP,IF(h.src_basement_finish = (TYPEOF(h.src_basement_finish))'',0,100));
    maxlength_src_basement_finish := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_basement_finish)));
    avelength_src_basement_finish := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_basement_finish)),h.src_basement_finish<>(typeof(h.src_basement_finish))'');
    populated_tax_dt_basement_finish_cnt := COUNT(GROUP,h.tax_dt_basement_finish <> (TYPEOF(h.tax_dt_basement_finish))'');
    populated_tax_dt_basement_finish_pcnt := AVE(GROUP,IF(h.tax_dt_basement_finish = (TYPEOF(h.tax_dt_basement_finish))'',0,100));
    maxlength_tax_dt_basement_finish := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_basement_finish)));
    avelength_tax_dt_basement_finish := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_basement_finish)),h.tax_dt_basement_finish<>(typeof(h.tax_dt_basement_finish))'');
    populated_construction_type_cnt := COUNT(GROUP,h.construction_type <> (TYPEOF(h.construction_type))'');
    populated_construction_type_pcnt := AVE(GROUP,IF(h.construction_type = (TYPEOF(h.construction_type))'',0,100));
    maxlength_construction_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.construction_type)));
    avelength_construction_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.construction_type)),h.construction_type<>(typeof(h.construction_type))'');
    populated_src_construction_type_cnt := COUNT(GROUP,h.src_construction_type <> (TYPEOF(h.src_construction_type))'');
    populated_src_construction_type_pcnt := AVE(GROUP,IF(h.src_construction_type = (TYPEOF(h.src_construction_type))'',0,100));
    maxlength_src_construction_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_construction_type)));
    avelength_src_construction_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_construction_type)),h.src_construction_type<>(typeof(h.src_construction_type))'');
    populated_tax_dt_construction_type_cnt := COUNT(GROUP,h.tax_dt_construction_type <> (TYPEOF(h.tax_dt_construction_type))'');
    populated_tax_dt_construction_type_pcnt := AVE(GROUP,IF(h.tax_dt_construction_type = (TYPEOF(h.tax_dt_construction_type))'',0,100));
    maxlength_tax_dt_construction_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_construction_type)));
    avelength_tax_dt_construction_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_construction_type)),h.tax_dt_construction_type<>(typeof(h.tax_dt_construction_type))'');
    populated_exterior_wall_cnt := COUNT(GROUP,h.exterior_wall <> (TYPEOF(h.exterior_wall))'');
    populated_exterior_wall_pcnt := AVE(GROUP,IF(h.exterior_wall = (TYPEOF(h.exterior_wall))'',0,100));
    maxlength_exterior_wall := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.exterior_wall)));
    avelength_exterior_wall := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.exterior_wall)),h.exterior_wall<>(typeof(h.exterior_wall))'');
    populated_src_exterior_wall_cnt := COUNT(GROUP,h.src_exterior_wall <> (TYPEOF(h.src_exterior_wall))'');
    populated_src_exterior_wall_pcnt := AVE(GROUP,IF(h.src_exterior_wall = (TYPEOF(h.src_exterior_wall))'',0,100));
    maxlength_src_exterior_wall := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_exterior_wall)));
    avelength_src_exterior_wall := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_exterior_wall)),h.src_exterior_wall<>(typeof(h.src_exterior_wall))'');
    populated_tax_dt_exterior_wall_cnt := COUNT(GROUP,h.tax_dt_exterior_wall <> (TYPEOF(h.tax_dt_exterior_wall))'');
    populated_tax_dt_exterior_wall_pcnt := AVE(GROUP,IF(h.tax_dt_exterior_wall = (TYPEOF(h.tax_dt_exterior_wall))'',0,100));
    maxlength_tax_dt_exterior_wall := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_exterior_wall)));
    avelength_tax_dt_exterior_wall := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_exterior_wall)),h.tax_dt_exterior_wall<>(typeof(h.tax_dt_exterior_wall))'');
    populated_fireplace_ind_cnt := COUNT(GROUP,h.fireplace_ind <> (TYPEOF(h.fireplace_ind))'');
    populated_fireplace_ind_pcnt := AVE(GROUP,IF(h.fireplace_ind = (TYPEOF(h.fireplace_ind))'',0,100));
    maxlength_fireplace_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fireplace_ind)));
    avelength_fireplace_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fireplace_ind)),h.fireplace_ind<>(typeof(h.fireplace_ind))'');
    populated_src_fireplace_ind_cnt := COUNT(GROUP,h.src_fireplace_ind <> (TYPEOF(h.src_fireplace_ind))'');
    populated_src_fireplace_ind_pcnt := AVE(GROUP,IF(h.src_fireplace_ind = (TYPEOF(h.src_fireplace_ind))'',0,100));
    maxlength_src_fireplace_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_fireplace_ind)));
    avelength_src_fireplace_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_fireplace_ind)),h.src_fireplace_ind<>(typeof(h.src_fireplace_ind))'');
    populated_tax_dt_fireplace_ind_cnt := COUNT(GROUP,h.tax_dt_fireplace_ind <> (TYPEOF(h.tax_dt_fireplace_ind))'');
    populated_tax_dt_fireplace_ind_pcnt := AVE(GROUP,IF(h.tax_dt_fireplace_ind = (TYPEOF(h.tax_dt_fireplace_ind))'',0,100));
    maxlength_tax_dt_fireplace_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_fireplace_ind)));
    avelength_tax_dt_fireplace_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_fireplace_ind)),h.tax_dt_fireplace_ind<>(typeof(h.tax_dt_fireplace_ind))'');
    populated_fireplace_type_cnt := COUNT(GROUP,h.fireplace_type <> (TYPEOF(h.fireplace_type))'');
    populated_fireplace_type_pcnt := AVE(GROUP,IF(h.fireplace_type = (TYPEOF(h.fireplace_type))'',0,100));
    maxlength_fireplace_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fireplace_type)));
    avelength_fireplace_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fireplace_type)),h.fireplace_type<>(typeof(h.fireplace_type))'');
    populated_src_fireplace_type_cnt := COUNT(GROUP,h.src_fireplace_type <> (TYPEOF(h.src_fireplace_type))'');
    populated_src_fireplace_type_pcnt := AVE(GROUP,IF(h.src_fireplace_type = (TYPEOF(h.src_fireplace_type))'',0,100));
    maxlength_src_fireplace_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_fireplace_type)));
    avelength_src_fireplace_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_fireplace_type)),h.src_fireplace_type<>(typeof(h.src_fireplace_type))'');
    populated_tax_dt_fireplace_type_cnt := COUNT(GROUP,h.tax_dt_fireplace_type <> (TYPEOF(h.tax_dt_fireplace_type))'');
    populated_tax_dt_fireplace_type_pcnt := AVE(GROUP,IF(h.tax_dt_fireplace_type = (TYPEOF(h.tax_dt_fireplace_type))'',0,100));
    maxlength_tax_dt_fireplace_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_fireplace_type)));
    avelength_tax_dt_fireplace_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_fireplace_type)),h.tax_dt_fireplace_type<>(typeof(h.tax_dt_fireplace_type))'');
    populated_flood_zone_panel_cnt := COUNT(GROUP,h.flood_zone_panel <> (TYPEOF(h.flood_zone_panel))'');
    populated_flood_zone_panel_pcnt := AVE(GROUP,IF(h.flood_zone_panel = (TYPEOF(h.flood_zone_panel))'',0,100));
    maxlength_flood_zone_panel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flood_zone_panel)));
    avelength_flood_zone_panel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flood_zone_panel)),h.flood_zone_panel<>(typeof(h.flood_zone_panel))'');
    populated_src_flood_zone_panel_cnt := COUNT(GROUP,h.src_flood_zone_panel <> (TYPEOF(h.src_flood_zone_panel))'');
    populated_src_flood_zone_panel_pcnt := AVE(GROUP,IF(h.src_flood_zone_panel = (TYPEOF(h.src_flood_zone_panel))'',0,100));
    maxlength_src_flood_zone_panel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_flood_zone_panel)));
    avelength_src_flood_zone_panel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_flood_zone_panel)),h.src_flood_zone_panel<>(typeof(h.src_flood_zone_panel))'');
    populated_tax_dt_flood_zone_panel_cnt := COUNT(GROUP,h.tax_dt_flood_zone_panel <> (TYPEOF(h.tax_dt_flood_zone_panel))'');
    populated_tax_dt_flood_zone_panel_pcnt := AVE(GROUP,IF(h.tax_dt_flood_zone_panel = (TYPEOF(h.tax_dt_flood_zone_panel))'',0,100));
    maxlength_tax_dt_flood_zone_panel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_flood_zone_panel)));
    avelength_tax_dt_flood_zone_panel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_flood_zone_panel)),h.tax_dt_flood_zone_panel<>(typeof(h.tax_dt_flood_zone_panel))'');
    populated_garage_cnt := COUNT(GROUP,h.garage <> (TYPEOF(h.garage))'');
    populated_garage_pcnt := AVE(GROUP,IF(h.garage = (TYPEOF(h.garage))'',0,100));
    maxlength_garage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.garage)));
    avelength_garage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.garage)),h.garage<>(typeof(h.garage))'');
    populated_src_garage_cnt := COUNT(GROUP,h.src_garage <> (TYPEOF(h.src_garage))'');
    populated_src_garage_pcnt := AVE(GROUP,IF(h.src_garage = (TYPEOF(h.src_garage))'',0,100));
    maxlength_src_garage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_garage)));
    avelength_src_garage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_garage)),h.src_garage<>(typeof(h.src_garage))'');
    populated_tax_dt_garage_cnt := COUNT(GROUP,h.tax_dt_garage <> (TYPEOF(h.tax_dt_garage))'');
    populated_tax_dt_garage_pcnt := AVE(GROUP,IF(h.tax_dt_garage = (TYPEOF(h.tax_dt_garage))'',0,100));
    maxlength_tax_dt_garage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_garage)));
    avelength_tax_dt_garage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_garage)),h.tax_dt_garage<>(typeof(h.tax_dt_garage))'');
    populated_first_floor_square_footage_cnt := COUNT(GROUP,h.first_floor_square_footage <> (TYPEOF(h.first_floor_square_footage))'');
    populated_first_floor_square_footage_pcnt := AVE(GROUP,IF(h.first_floor_square_footage = (TYPEOF(h.first_floor_square_footage))'',0,100));
    maxlength_first_floor_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_floor_square_footage)));
    avelength_first_floor_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_floor_square_footage)),h.first_floor_square_footage<>(typeof(h.first_floor_square_footage))'');
    populated_src_first_floor_square_footage_cnt := COUNT(GROUP,h.src_first_floor_square_footage <> (TYPEOF(h.src_first_floor_square_footage))'');
    populated_src_first_floor_square_footage_pcnt := AVE(GROUP,IF(h.src_first_floor_square_footage = (TYPEOF(h.src_first_floor_square_footage))'',0,100));
    maxlength_src_first_floor_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_first_floor_square_footage)));
    avelength_src_first_floor_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_first_floor_square_footage)),h.src_first_floor_square_footage<>(typeof(h.src_first_floor_square_footage))'');
    populated_tax_dt_first_floor_square_footage_cnt := COUNT(GROUP,h.tax_dt_first_floor_square_footage <> (TYPEOF(h.tax_dt_first_floor_square_footage))'');
    populated_tax_dt_first_floor_square_footage_pcnt := AVE(GROUP,IF(h.tax_dt_first_floor_square_footage = (TYPEOF(h.tax_dt_first_floor_square_footage))'',0,100));
    maxlength_tax_dt_first_floor_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_first_floor_square_footage)));
    avelength_tax_dt_first_floor_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_first_floor_square_footage)),h.tax_dt_first_floor_square_footage<>(typeof(h.tax_dt_first_floor_square_footage))'');
    populated_heating_cnt := COUNT(GROUP,h.heating <> (TYPEOF(h.heating))'');
    populated_heating_pcnt := AVE(GROUP,IF(h.heating = (TYPEOF(h.heating))'',0,100));
    maxlength_heating := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.heating)));
    avelength_heating := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.heating)),h.heating<>(typeof(h.heating))'');
    populated_src_heating_cnt := COUNT(GROUP,h.src_heating <> (TYPEOF(h.src_heating))'');
    populated_src_heating_pcnt := AVE(GROUP,IF(h.src_heating = (TYPEOF(h.src_heating))'',0,100));
    maxlength_src_heating := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_heating)));
    avelength_src_heating := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_heating)),h.src_heating<>(typeof(h.src_heating))'');
    populated_tax_dt_heating_cnt := COUNT(GROUP,h.tax_dt_heating <> (TYPEOF(h.tax_dt_heating))'');
    populated_tax_dt_heating_pcnt := AVE(GROUP,IF(h.tax_dt_heating = (TYPEOF(h.tax_dt_heating))'',0,100));
    maxlength_tax_dt_heating := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_heating)));
    avelength_tax_dt_heating := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_heating)),h.tax_dt_heating<>(typeof(h.tax_dt_heating))'');
    populated_living_area_square_footage_cnt := COUNT(GROUP,h.living_area_square_footage <> (TYPEOF(h.living_area_square_footage))'');
    populated_living_area_square_footage_pcnt := AVE(GROUP,IF(h.living_area_square_footage = (TYPEOF(h.living_area_square_footage))'',0,100));
    maxlength_living_area_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.living_area_square_footage)));
    avelength_living_area_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.living_area_square_footage)),h.living_area_square_footage<>(typeof(h.living_area_square_footage))'');
    populated_src_living_area_square_footage_cnt := COUNT(GROUP,h.src_living_area_square_footage <> (TYPEOF(h.src_living_area_square_footage))'');
    populated_src_living_area_square_footage_pcnt := AVE(GROUP,IF(h.src_living_area_square_footage = (TYPEOF(h.src_living_area_square_footage))'',0,100));
    maxlength_src_living_area_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_living_area_square_footage)));
    avelength_src_living_area_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_living_area_square_footage)),h.src_living_area_square_footage<>(typeof(h.src_living_area_square_footage))'');
    populated_tax_dt_living_area_square_footage_cnt := COUNT(GROUP,h.tax_dt_living_area_square_footage <> (TYPEOF(h.tax_dt_living_area_square_footage))'');
    populated_tax_dt_living_area_square_footage_pcnt := AVE(GROUP,IF(h.tax_dt_living_area_square_footage = (TYPEOF(h.tax_dt_living_area_square_footage))'',0,100));
    maxlength_tax_dt_living_area_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_living_area_square_footage)));
    avelength_tax_dt_living_area_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_living_area_square_footage)),h.tax_dt_living_area_square_footage<>(typeof(h.tax_dt_living_area_square_footage))'');
    populated_no_of_baths_cnt := COUNT(GROUP,h.no_of_baths <> (TYPEOF(h.no_of_baths))'');
    populated_no_of_baths_pcnt := AVE(GROUP,IF(h.no_of_baths = (TYPEOF(h.no_of_baths))'',0,100));
    maxlength_no_of_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_baths)));
    avelength_no_of_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_baths)),h.no_of_baths<>(typeof(h.no_of_baths))'');
    populated_src_no_of_baths_cnt := COUNT(GROUP,h.src_no_of_baths <> (TYPEOF(h.src_no_of_baths))'');
    populated_src_no_of_baths_pcnt := AVE(GROUP,IF(h.src_no_of_baths = (TYPEOF(h.src_no_of_baths))'',0,100));
    maxlength_src_no_of_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_baths)));
    avelength_src_no_of_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_baths)),h.src_no_of_baths<>(typeof(h.src_no_of_baths))'');
    populated_tax_dt_no_of_baths_cnt := COUNT(GROUP,h.tax_dt_no_of_baths <> (TYPEOF(h.tax_dt_no_of_baths))'');
    populated_tax_dt_no_of_baths_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_baths = (TYPEOF(h.tax_dt_no_of_baths))'',0,100));
    maxlength_tax_dt_no_of_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_baths)));
    avelength_tax_dt_no_of_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_baths)),h.tax_dt_no_of_baths<>(typeof(h.tax_dt_no_of_baths))'');
    populated_no_of_bedrooms_cnt := COUNT(GROUP,h.no_of_bedrooms <> (TYPEOF(h.no_of_bedrooms))'');
    populated_no_of_bedrooms_pcnt := AVE(GROUP,IF(h.no_of_bedrooms = (TYPEOF(h.no_of_bedrooms))'',0,100));
    maxlength_no_of_bedrooms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_bedrooms)));
    avelength_no_of_bedrooms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_bedrooms)),h.no_of_bedrooms<>(typeof(h.no_of_bedrooms))'');
    populated_src_no_of_bedrooms_cnt := COUNT(GROUP,h.src_no_of_bedrooms <> (TYPEOF(h.src_no_of_bedrooms))'');
    populated_src_no_of_bedrooms_pcnt := AVE(GROUP,IF(h.src_no_of_bedrooms = (TYPEOF(h.src_no_of_bedrooms))'',0,100));
    maxlength_src_no_of_bedrooms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_bedrooms)));
    avelength_src_no_of_bedrooms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_bedrooms)),h.src_no_of_bedrooms<>(typeof(h.src_no_of_bedrooms))'');
    populated_tax_dt_no_of_bedrooms_cnt := COUNT(GROUP,h.tax_dt_no_of_bedrooms <> (TYPEOF(h.tax_dt_no_of_bedrooms))'');
    populated_tax_dt_no_of_bedrooms_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_bedrooms = (TYPEOF(h.tax_dt_no_of_bedrooms))'',0,100));
    maxlength_tax_dt_no_of_bedrooms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_bedrooms)));
    avelength_tax_dt_no_of_bedrooms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_bedrooms)),h.tax_dt_no_of_bedrooms<>(typeof(h.tax_dt_no_of_bedrooms))'');
    populated_no_of_fireplaces_cnt := COUNT(GROUP,h.no_of_fireplaces <> (TYPEOF(h.no_of_fireplaces))'');
    populated_no_of_fireplaces_pcnt := AVE(GROUP,IF(h.no_of_fireplaces = (TYPEOF(h.no_of_fireplaces))'',0,100));
    maxlength_no_of_fireplaces := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_fireplaces)));
    avelength_no_of_fireplaces := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_fireplaces)),h.no_of_fireplaces<>(typeof(h.no_of_fireplaces))'');
    populated_src_no_of_fireplaces_cnt := COUNT(GROUP,h.src_no_of_fireplaces <> (TYPEOF(h.src_no_of_fireplaces))'');
    populated_src_no_of_fireplaces_pcnt := AVE(GROUP,IF(h.src_no_of_fireplaces = (TYPEOF(h.src_no_of_fireplaces))'',0,100));
    maxlength_src_no_of_fireplaces := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_fireplaces)));
    avelength_src_no_of_fireplaces := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_fireplaces)),h.src_no_of_fireplaces<>(typeof(h.src_no_of_fireplaces))'');
    populated_tax_dt_no_of_fireplaces_cnt := COUNT(GROUP,h.tax_dt_no_of_fireplaces <> (TYPEOF(h.tax_dt_no_of_fireplaces))'');
    populated_tax_dt_no_of_fireplaces_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_fireplaces = (TYPEOF(h.tax_dt_no_of_fireplaces))'',0,100));
    maxlength_tax_dt_no_of_fireplaces := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_fireplaces)));
    avelength_tax_dt_no_of_fireplaces := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_fireplaces)),h.tax_dt_no_of_fireplaces<>(typeof(h.tax_dt_no_of_fireplaces))'');
    populated_no_of_full_baths_cnt := COUNT(GROUP,h.no_of_full_baths <> (TYPEOF(h.no_of_full_baths))'');
    populated_no_of_full_baths_pcnt := AVE(GROUP,IF(h.no_of_full_baths = (TYPEOF(h.no_of_full_baths))'',0,100));
    maxlength_no_of_full_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_full_baths)));
    avelength_no_of_full_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_full_baths)),h.no_of_full_baths<>(typeof(h.no_of_full_baths))'');
    populated_src_no_of_full_baths_cnt := COUNT(GROUP,h.src_no_of_full_baths <> (TYPEOF(h.src_no_of_full_baths))'');
    populated_src_no_of_full_baths_pcnt := AVE(GROUP,IF(h.src_no_of_full_baths = (TYPEOF(h.src_no_of_full_baths))'',0,100));
    maxlength_src_no_of_full_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_full_baths)));
    avelength_src_no_of_full_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_full_baths)),h.src_no_of_full_baths<>(typeof(h.src_no_of_full_baths))'');
    populated_tax_dt_no_of_full_baths_cnt := COUNT(GROUP,h.tax_dt_no_of_full_baths <> (TYPEOF(h.tax_dt_no_of_full_baths))'');
    populated_tax_dt_no_of_full_baths_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_full_baths = (TYPEOF(h.tax_dt_no_of_full_baths))'',0,100));
    maxlength_tax_dt_no_of_full_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_full_baths)));
    avelength_tax_dt_no_of_full_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_full_baths)),h.tax_dt_no_of_full_baths<>(typeof(h.tax_dt_no_of_full_baths))'');
    populated_no_of_half_baths_cnt := COUNT(GROUP,h.no_of_half_baths <> (TYPEOF(h.no_of_half_baths))'');
    populated_no_of_half_baths_pcnt := AVE(GROUP,IF(h.no_of_half_baths = (TYPEOF(h.no_of_half_baths))'',0,100));
    maxlength_no_of_half_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_half_baths)));
    avelength_no_of_half_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_half_baths)),h.no_of_half_baths<>(typeof(h.no_of_half_baths))'');
    populated_src_no_of_half_baths_cnt := COUNT(GROUP,h.src_no_of_half_baths <> (TYPEOF(h.src_no_of_half_baths))'');
    populated_src_no_of_half_baths_pcnt := AVE(GROUP,IF(h.src_no_of_half_baths = (TYPEOF(h.src_no_of_half_baths))'',0,100));
    maxlength_src_no_of_half_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_half_baths)));
    avelength_src_no_of_half_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_half_baths)),h.src_no_of_half_baths<>(typeof(h.src_no_of_half_baths))'');
    populated_tax_dt_no_of_half_baths_cnt := COUNT(GROUP,h.tax_dt_no_of_half_baths <> (TYPEOF(h.tax_dt_no_of_half_baths))'');
    populated_tax_dt_no_of_half_baths_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_half_baths = (TYPEOF(h.tax_dt_no_of_half_baths))'',0,100));
    maxlength_tax_dt_no_of_half_baths := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_half_baths)));
    avelength_tax_dt_no_of_half_baths := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_half_baths)),h.tax_dt_no_of_half_baths<>(typeof(h.tax_dt_no_of_half_baths))'');
    populated_no_of_stories_cnt := COUNT(GROUP,h.no_of_stories <> (TYPEOF(h.no_of_stories))'');
    populated_no_of_stories_pcnt := AVE(GROUP,IF(h.no_of_stories = (TYPEOF(h.no_of_stories))'',0,100));
    maxlength_no_of_stories := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_stories)));
    avelength_no_of_stories := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_stories)),h.no_of_stories<>(typeof(h.no_of_stories))'');
    populated_src_no_of_stories_cnt := COUNT(GROUP,h.src_no_of_stories <> (TYPEOF(h.src_no_of_stories))'');
    populated_src_no_of_stories_pcnt := AVE(GROUP,IF(h.src_no_of_stories = (TYPEOF(h.src_no_of_stories))'',0,100));
    maxlength_src_no_of_stories := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_stories)));
    avelength_src_no_of_stories := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_stories)),h.src_no_of_stories<>(typeof(h.src_no_of_stories))'');
    populated_tax_dt_no_of_stories_cnt := COUNT(GROUP,h.tax_dt_no_of_stories <> (TYPEOF(h.tax_dt_no_of_stories))'');
    populated_tax_dt_no_of_stories_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_stories = (TYPEOF(h.tax_dt_no_of_stories))'',0,100));
    maxlength_tax_dt_no_of_stories := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_stories)));
    avelength_tax_dt_no_of_stories := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_stories)),h.tax_dt_no_of_stories<>(typeof(h.tax_dt_no_of_stories))'');
    populated_parking_type_cnt := COUNT(GROUP,h.parking_type <> (TYPEOF(h.parking_type))'');
    populated_parking_type_pcnt := AVE(GROUP,IF(h.parking_type = (TYPEOF(h.parking_type))'',0,100));
    maxlength_parking_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.parking_type)));
    avelength_parking_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.parking_type)),h.parking_type<>(typeof(h.parking_type))'');
    populated_src_parking_type_cnt := COUNT(GROUP,h.src_parking_type <> (TYPEOF(h.src_parking_type))'');
    populated_src_parking_type_pcnt := AVE(GROUP,IF(h.src_parking_type = (TYPEOF(h.src_parking_type))'',0,100));
    maxlength_src_parking_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_parking_type)));
    avelength_src_parking_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_parking_type)),h.src_parking_type<>(typeof(h.src_parking_type))'');
    populated_tax_dt_parking_type_cnt := COUNT(GROUP,h.tax_dt_parking_type <> (TYPEOF(h.tax_dt_parking_type))'');
    populated_tax_dt_parking_type_pcnt := AVE(GROUP,IF(h.tax_dt_parking_type = (TYPEOF(h.tax_dt_parking_type))'',0,100));
    maxlength_tax_dt_parking_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_parking_type)));
    avelength_tax_dt_parking_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_parking_type)),h.tax_dt_parking_type<>(typeof(h.tax_dt_parking_type))'');
    populated_pool_indicator_cnt := COUNT(GROUP,h.pool_indicator <> (TYPEOF(h.pool_indicator))'');
    populated_pool_indicator_pcnt := AVE(GROUP,IF(h.pool_indicator = (TYPEOF(h.pool_indicator))'',0,100));
    maxlength_pool_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pool_indicator)));
    avelength_pool_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pool_indicator)),h.pool_indicator<>(typeof(h.pool_indicator))'');
    populated_src_pool_indicator_cnt := COUNT(GROUP,h.src_pool_indicator <> (TYPEOF(h.src_pool_indicator))'');
    populated_src_pool_indicator_pcnt := AVE(GROUP,IF(h.src_pool_indicator = (TYPEOF(h.src_pool_indicator))'',0,100));
    maxlength_src_pool_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_pool_indicator)));
    avelength_src_pool_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_pool_indicator)),h.src_pool_indicator<>(typeof(h.src_pool_indicator))'');
    populated_tax_dt_pool_indicator_cnt := COUNT(GROUP,h.tax_dt_pool_indicator <> (TYPEOF(h.tax_dt_pool_indicator))'');
    populated_tax_dt_pool_indicator_pcnt := AVE(GROUP,IF(h.tax_dt_pool_indicator = (TYPEOF(h.tax_dt_pool_indicator))'',0,100));
    maxlength_tax_dt_pool_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_pool_indicator)));
    avelength_tax_dt_pool_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_pool_indicator)),h.tax_dt_pool_indicator<>(typeof(h.tax_dt_pool_indicator))'');
    populated_pool_type_cnt := COUNT(GROUP,h.pool_type <> (TYPEOF(h.pool_type))'');
    populated_pool_type_pcnt := AVE(GROUP,IF(h.pool_type = (TYPEOF(h.pool_type))'',0,100));
    maxlength_pool_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pool_type)));
    avelength_pool_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pool_type)),h.pool_type<>(typeof(h.pool_type))'');
    populated_src_pool_type_cnt := COUNT(GROUP,h.src_pool_type <> (TYPEOF(h.src_pool_type))'');
    populated_src_pool_type_pcnt := AVE(GROUP,IF(h.src_pool_type = (TYPEOF(h.src_pool_type))'',0,100));
    maxlength_src_pool_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_pool_type)));
    avelength_src_pool_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_pool_type)),h.src_pool_type<>(typeof(h.src_pool_type))'');
    populated_tax_dt_pool_type_cnt := COUNT(GROUP,h.tax_dt_pool_type <> (TYPEOF(h.tax_dt_pool_type))'');
    populated_tax_dt_pool_type_pcnt := AVE(GROUP,IF(h.tax_dt_pool_type = (TYPEOF(h.tax_dt_pool_type))'',0,100));
    maxlength_tax_dt_pool_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_pool_type)));
    avelength_tax_dt_pool_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_pool_type)),h.tax_dt_pool_type<>(typeof(h.tax_dt_pool_type))'');
    populated_roof_cover_cnt := COUNT(GROUP,h.roof_cover <> (TYPEOF(h.roof_cover))'');
    populated_roof_cover_pcnt := AVE(GROUP,IF(h.roof_cover = (TYPEOF(h.roof_cover))'',0,100));
    maxlength_roof_cover := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.roof_cover)));
    avelength_roof_cover := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.roof_cover)),h.roof_cover<>(typeof(h.roof_cover))'');
    populated_src_roof_cover_cnt := COUNT(GROUP,h.src_roof_cover <> (TYPEOF(h.src_roof_cover))'');
    populated_src_roof_cover_pcnt := AVE(GROUP,IF(h.src_roof_cover = (TYPEOF(h.src_roof_cover))'',0,100));
    maxlength_src_roof_cover := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_roof_cover)));
    avelength_src_roof_cover := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_roof_cover)),h.src_roof_cover<>(typeof(h.src_roof_cover))'');
    populated_tax_dt_roof_cover_cnt := COUNT(GROUP,h.tax_dt_roof_cover <> (TYPEOF(h.tax_dt_roof_cover))'');
    populated_tax_dt_roof_cover_pcnt := AVE(GROUP,IF(h.tax_dt_roof_cover = (TYPEOF(h.tax_dt_roof_cover))'',0,100));
    maxlength_tax_dt_roof_cover := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_roof_cover)));
    avelength_tax_dt_roof_cover := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_roof_cover)),h.tax_dt_roof_cover<>(typeof(h.tax_dt_roof_cover))'');
    populated_year_built_cnt := COUNT(GROUP,h.year_built <> (TYPEOF(h.year_built))'');
    populated_year_built_pcnt := AVE(GROUP,IF(h.year_built = (TYPEOF(h.year_built))'',0,100));
    maxlength_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_built)));
    avelength_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.year_built)),h.year_built<>(typeof(h.year_built))'');
    populated_src_year_built_cnt := COUNT(GROUP,h.src_year_built <> (TYPEOF(h.src_year_built))'');
    populated_src_year_built_pcnt := AVE(GROUP,IF(h.src_year_built = (TYPEOF(h.src_year_built))'',0,100));
    maxlength_src_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_year_built)));
    avelength_src_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_year_built)),h.src_year_built<>(typeof(h.src_year_built))'');
    populated_tax_dt_year_built_cnt := COUNT(GROUP,h.tax_dt_year_built <> (TYPEOF(h.tax_dt_year_built))'');
    populated_tax_dt_year_built_pcnt := AVE(GROUP,IF(h.tax_dt_year_built = (TYPEOF(h.tax_dt_year_built))'',0,100));
    maxlength_tax_dt_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_year_built)));
    avelength_tax_dt_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_year_built)),h.tax_dt_year_built<>(typeof(h.tax_dt_year_built))'');
    populated_foundation_cnt := COUNT(GROUP,h.foundation <> (TYPEOF(h.foundation))'');
    populated_foundation_pcnt := AVE(GROUP,IF(h.foundation = (TYPEOF(h.foundation))'',0,100));
    maxlength_foundation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.foundation)));
    avelength_foundation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.foundation)),h.foundation<>(typeof(h.foundation))'');
    populated_src_foundation_cnt := COUNT(GROUP,h.src_foundation <> (TYPEOF(h.src_foundation))'');
    populated_src_foundation_pcnt := AVE(GROUP,IF(h.src_foundation = (TYPEOF(h.src_foundation))'',0,100));
    maxlength_src_foundation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_foundation)));
    avelength_src_foundation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_foundation)),h.src_foundation<>(typeof(h.src_foundation))'');
    populated_tax_dt_foundation_cnt := COUNT(GROUP,h.tax_dt_foundation <> (TYPEOF(h.tax_dt_foundation))'');
    populated_tax_dt_foundation_pcnt := AVE(GROUP,IF(h.tax_dt_foundation = (TYPEOF(h.tax_dt_foundation))'',0,100));
    maxlength_tax_dt_foundation := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_foundation)));
    avelength_tax_dt_foundation := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_foundation)),h.tax_dt_foundation<>(typeof(h.tax_dt_foundation))'');
    populated_basement_square_footage_cnt := COUNT(GROUP,h.basement_square_footage <> (TYPEOF(h.basement_square_footage))'');
    populated_basement_square_footage_pcnt := AVE(GROUP,IF(h.basement_square_footage = (TYPEOF(h.basement_square_footage))'',0,100));
    maxlength_basement_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.basement_square_footage)));
    avelength_basement_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.basement_square_footage)),h.basement_square_footage<>(typeof(h.basement_square_footage))'');
    populated_src_basement_square_footage_cnt := COUNT(GROUP,h.src_basement_square_footage <> (TYPEOF(h.src_basement_square_footage))'');
    populated_src_basement_square_footage_pcnt := AVE(GROUP,IF(h.src_basement_square_footage = (TYPEOF(h.src_basement_square_footage))'',0,100));
    maxlength_src_basement_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_basement_square_footage)));
    avelength_src_basement_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_basement_square_footage)),h.src_basement_square_footage<>(typeof(h.src_basement_square_footage))'');
    populated_tax_dt_basement_square_footage_cnt := COUNT(GROUP,h.tax_dt_basement_square_footage <> (TYPEOF(h.tax_dt_basement_square_footage))'');
    populated_tax_dt_basement_square_footage_pcnt := AVE(GROUP,IF(h.tax_dt_basement_square_footage = (TYPEOF(h.tax_dt_basement_square_footage))'',0,100));
    maxlength_tax_dt_basement_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_basement_square_footage)));
    avelength_tax_dt_basement_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_basement_square_footage)),h.tax_dt_basement_square_footage<>(typeof(h.tax_dt_basement_square_footage))'');
    populated_effective_year_built_cnt := COUNT(GROUP,h.effective_year_built <> (TYPEOF(h.effective_year_built))'');
    populated_effective_year_built_pcnt := AVE(GROUP,IF(h.effective_year_built = (TYPEOF(h.effective_year_built))'',0,100));
    maxlength_effective_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.effective_year_built)));
    avelength_effective_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.effective_year_built)),h.effective_year_built<>(typeof(h.effective_year_built))'');
    populated_src_effective_year_built_cnt := COUNT(GROUP,h.src_effective_year_built <> (TYPEOF(h.src_effective_year_built))'');
    populated_src_effective_year_built_pcnt := AVE(GROUP,IF(h.src_effective_year_built = (TYPEOF(h.src_effective_year_built))'',0,100));
    maxlength_src_effective_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_effective_year_built)));
    avelength_src_effective_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_effective_year_built)),h.src_effective_year_built<>(typeof(h.src_effective_year_built))'');
    populated_tax_dt_effective_year_built_cnt := COUNT(GROUP,h.tax_dt_effective_year_built <> (TYPEOF(h.tax_dt_effective_year_built))'');
    populated_tax_dt_effective_year_built_pcnt := AVE(GROUP,IF(h.tax_dt_effective_year_built = (TYPEOF(h.tax_dt_effective_year_built))'',0,100));
    maxlength_tax_dt_effective_year_built := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_effective_year_built)));
    avelength_tax_dt_effective_year_built := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_effective_year_built)),h.tax_dt_effective_year_built<>(typeof(h.tax_dt_effective_year_built))'');
    populated_garage_square_footage_cnt := COUNT(GROUP,h.garage_square_footage <> (TYPEOF(h.garage_square_footage))'');
    populated_garage_square_footage_pcnt := AVE(GROUP,IF(h.garage_square_footage = (TYPEOF(h.garage_square_footage))'',0,100));
    maxlength_garage_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.garage_square_footage)));
    avelength_garage_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.garage_square_footage)),h.garage_square_footage<>(typeof(h.garage_square_footage))'');
    populated_src_garage_square_footage_cnt := COUNT(GROUP,h.src_garage_square_footage <> (TYPEOF(h.src_garage_square_footage))'');
    populated_src_garage_square_footage_pcnt := AVE(GROUP,IF(h.src_garage_square_footage = (TYPEOF(h.src_garage_square_footage))'',0,100));
    maxlength_src_garage_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_garage_square_footage)));
    avelength_src_garage_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_garage_square_footage)),h.src_garage_square_footage<>(typeof(h.src_garage_square_footage))'');
    populated_tax_dt_garage_square_footage_cnt := COUNT(GROUP,h.tax_dt_garage_square_footage <> (TYPEOF(h.tax_dt_garage_square_footage))'');
    populated_tax_dt_garage_square_footage_pcnt := AVE(GROUP,IF(h.tax_dt_garage_square_footage = (TYPEOF(h.tax_dt_garage_square_footage))'',0,100));
    maxlength_tax_dt_garage_square_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_garage_square_footage)));
    avelength_tax_dt_garage_square_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_garage_square_footage)),h.tax_dt_garage_square_footage<>(typeof(h.tax_dt_garage_square_footage))'');
    populated_stories_type_cnt := COUNT(GROUP,h.stories_type <> (TYPEOF(h.stories_type))'');
    populated_stories_type_pcnt := AVE(GROUP,IF(h.stories_type = (TYPEOF(h.stories_type))'',0,100));
    maxlength_stories_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.stories_type)));
    avelength_stories_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.stories_type)),h.stories_type<>(typeof(h.stories_type))'');
    populated_src_stories_type_cnt := COUNT(GROUP,h.src_stories_type <> (TYPEOF(h.src_stories_type))'');
    populated_src_stories_type_pcnt := AVE(GROUP,IF(h.src_stories_type = (TYPEOF(h.src_stories_type))'',0,100));
    maxlength_src_stories_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_stories_type)));
    avelength_src_stories_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_stories_type)),h.src_stories_type<>(typeof(h.src_stories_type))'');
    populated_tax_dt_stories_type_cnt := COUNT(GROUP,h.tax_dt_stories_type <> (TYPEOF(h.tax_dt_stories_type))'');
    populated_tax_dt_stories_type_pcnt := AVE(GROUP,IF(h.tax_dt_stories_type = (TYPEOF(h.tax_dt_stories_type))'',0,100));
    maxlength_tax_dt_stories_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_stories_type)));
    avelength_tax_dt_stories_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_stories_type)),h.tax_dt_stories_type<>(typeof(h.tax_dt_stories_type))'');
    populated_apn_number_cnt := COUNT(GROUP,h.apn_number <> (TYPEOF(h.apn_number))'');
    populated_apn_number_pcnt := AVE(GROUP,IF(h.apn_number = (TYPEOF(h.apn_number))'',0,100));
    maxlength_apn_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.apn_number)));
    avelength_apn_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.apn_number)),h.apn_number<>(typeof(h.apn_number))'');
    populated_src_apn_number_cnt := COUNT(GROUP,h.src_apn_number <> (TYPEOF(h.src_apn_number))'');
    populated_src_apn_number_pcnt := AVE(GROUP,IF(h.src_apn_number = (TYPEOF(h.src_apn_number))'',0,100));
    maxlength_src_apn_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_apn_number)));
    avelength_src_apn_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_apn_number)),h.src_apn_number<>(typeof(h.src_apn_number))'');
    populated_tax_dt_apn_number_cnt := COUNT(GROUP,h.tax_dt_apn_number <> (TYPEOF(h.tax_dt_apn_number))'');
    populated_tax_dt_apn_number_pcnt := AVE(GROUP,IF(h.tax_dt_apn_number = (TYPEOF(h.tax_dt_apn_number))'',0,100));
    maxlength_tax_dt_apn_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_apn_number)));
    avelength_tax_dt_apn_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_apn_number)),h.tax_dt_apn_number<>(typeof(h.tax_dt_apn_number))'');
    populated_census_tract_cnt := COUNT(GROUP,h.census_tract <> (TYPEOF(h.census_tract))'');
    populated_census_tract_pcnt := AVE(GROUP,IF(h.census_tract = (TYPEOF(h.census_tract))'',0,100));
    maxlength_census_tract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.census_tract)));
    avelength_census_tract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.census_tract)),h.census_tract<>(typeof(h.census_tract))'');
    populated_src_census_tract_cnt := COUNT(GROUP,h.src_census_tract <> (TYPEOF(h.src_census_tract))'');
    populated_src_census_tract_pcnt := AVE(GROUP,IF(h.src_census_tract = (TYPEOF(h.src_census_tract))'',0,100));
    maxlength_src_census_tract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_census_tract)));
    avelength_src_census_tract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_census_tract)),h.src_census_tract<>(typeof(h.src_census_tract))'');
    populated_tax_dt_census_tract_cnt := COUNT(GROUP,h.tax_dt_census_tract <> (TYPEOF(h.tax_dt_census_tract))'');
    populated_tax_dt_census_tract_pcnt := AVE(GROUP,IF(h.tax_dt_census_tract = (TYPEOF(h.tax_dt_census_tract))'',0,100));
    maxlength_tax_dt_census_tract := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_census_tract)));
    avelength_tax_dt_census_tract := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_census_tract)),h.tax_dt_census_tract<>(typeof(h.tax_dt_census_tract))'');
    populated_range_cnt := COUNT(GROUP,h.range <> (TYPEOF(h.range))'');
    populated_range_pcnt := AVE(GROUP,IF(h.range = (TYPEOF(h.range))'',0,100));
    maxlength_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.range)));
    avelength_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.range)),h.range<>(typeof(h.range))'');
    populated_src_range_cnt := COUNT(GROUP,h.src_range <> (TYPEOF(h.src_range))'');
    populated_src_range_pcnt := AVE(GROUP,IF(h.src_range = (TYPEOF(h.src_range))'',0,100));
    maxlength_src_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_range)));
    avelength_src_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_range)),h.src_range<>(typeof(h.src_range))'');
    populated_tax_dt_range_cnt := COUNT(GROUP,h.tax_dt_range <> (TYPEOF(h.tax_dt_range))'');
    populated_tax_dt_range_pcnt := AVE(GROUP,IF(h.tax_dt_range = (TYPEOF(h.tax_dt_range))'',0,100));
    maxlength_tax_dt_range := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_range)));
    avelength_tax_dt_range := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_range)),h.tax_dt_range<>(typeof(h.tax_dt_range))'');
    populated_zoning_cnt := COUNT(GROUP,h.zoning <> (TYPEOF(h.zoning))'');
    populated_zoning_pcnt := AVE(GROUP,IF(h.zoning = (TYPEOF(h.zoning))'',0,100));
    maxlength_zoning := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zoning)));
    avelength_zoning := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zoning)),h.zoning<>(typeof(h.zoning))'');
    populated_src_zoning_cnt := COUNT(GROUP,h.src_zoning <> (TYPEOF(h.src_zoning))'');
    populated_src_zoning_pcnt := AVE(GROUP,IF(h.src_zoning = (TYPEOF(h.src_zoning))'',0,100));
    maxlength_src_zoning := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_zoning)));
    avelength_src_zoning := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_zoning)),h.src_zoning<>(typeof(h.src_zoning))'');
    populated_tax_dt_zoning_cnt := COUNT(GROUP,h.tax_dt_zoning <> (TYPEOF(h.tax_dt_zoning))'');
    populated_tax_dt_zoning_pcnt := AVE(GROUP,IF(h.tax_dt_zoning = (TYPEOF(h.tax_dt_zoning))'',0,100));
    maxlength_tax_dt_zoning := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_zoning)));
    avelength_tax_dt_zoning := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_zoning)),h.tax_dt_zoning<>(typeof(h.tax_dt_zoning))'');
    populated_block_number_cnt := COUNT(GROUP,h.block_number <> (TYPEOF(h.block_number))'');
    populated_block_number_pcnt := AVE(GROUP,IF(h.block_number = (TYPEOF(h.block_number))'',0,100));
    maxlength_block_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.block_number)));
    avelength_block_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.block_number)),h.block_number<>(typeof(h.block_number))'');
    populated_src_block_number_cnt := COUNT(GROUP,h.src_block_number <> (TYPEOF(h.src_block_number))'');
    populated_src_block_number_pcnt := AVE(GROUP,IF(h.src_block_number = (TYPEOF(h.src_block_number))'',0,100));
    maxlength_src_block_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_block_number)));
    avelength_src_block_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_block_number)),h.src_block_number<>(typeof(h.src_block_number))'');
    populated_tax_dt_block_number_cnt := COUNT(GROUP,h.tax_dt_block_number <> (TYPEOF(h.tax_dt_block_number))'');
    populated_tax_dt_block_number_pcnt := AVE(GROUP,IF(h.tax_dt_block_number = (TYPEOF(h.tax_dt_block_number))'',0,100));
    maxlength_tax_dt_block_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_block_number)));
    avelength_tax_dt_block_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_block_number)),h.tax_dt_block_number<>(typeof(h.tax_dt_block_number))'');
    populated_county_name_cnt := COUNT(GROUP,h.county_name <> (TYPEOF(h.county_name))'');
    populated_county_name_pcnt := AVE(GROUP,IF(h.county_name = (TYPEOF(h.county_name))'',0,100));
    maxlength_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)));
    avelength_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.county_name)),h.county_name<>(typeof(h.county_name))'');
    populated_src_county_name_cnt := COUNT(GROUP,h.src_county_name <> (TYPEOF(h.src_county_name))'');
    populated_src_county_name_pcnt := AVE(GROUP,IF(h.src_county_name = (TYPEOF(h.src_county_name))'',0,100));
    maxlength_src_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_county_name)));
    avelength_src_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_county_name)),h.src_county_name<>(typeof(h.src_county_name))'');
    populated_tax_dt_county_name_cnt := COUNT(GROUP,h.tax_dt_county_name <> (TYPEOF(h.tax_dt_county_name))'');
    populated_tax_dt_county_name_pcnt := AVE(GROUP,IF(h.tax_dt_county_name = (TYPEOF(h.tax_dt_county_name))'',0,100));
    maxlength_tax_dt_county_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_county_name)));
    avelength_tax_dt_county_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_county_name)),h.tax_dt_county_name<>(typeof(h.tax_dt_county_name))'');
    populated_fips_code_cnt := COUNT(GROUP,h.fips_code <> (TYPEOF(h.fips_code))'');
    populated_fips_code_pcnt := AVE(GROUP,IF(h.fips_code = (TYPEOF(h.fips_code))'',0,100));
    maxlength_fips_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_code)));
    avelength_fips_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fips_code)),h.fips_code<>(typeof(h.fips_code))'');
    populated_src_fips_code_cnt := COUNT(GROUP,h.src_fips_code <> (TYPEOF(h.src_fips_code))'');
    populated_src_fips_code_pcnt := AVE(GROUP,IF(h.src_fips_code = (TYPEOF(h.src_fips_code))'',0,100));
    maxlength_src_fips_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_fips_code)));
    avelength_src_fips_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_fips_code)),h.src_fips_code<>(typeof(h.src_fips_code))'');
    populated_tax_dt_fips_code_cnt := COUNT(GROUP,h.tax_dt_fips_code <> (TYPEOF(h.tax_dt_fips_code))'');
    populated_tax_dt_fips_code_pcnt := AVE(GROUP,IF(h.tax_dt_fips_code = (TYPEOF(h.tax_dt_fips_code))'',0,100));
    maxlength_tax_dt_fips_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_fips_code)));
    avelength_tax_dt_fips_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_fips_code)),h.tax_dt_fips_code<>(typeof(h.tax_dt_fips_code))'');
    populated_subdivision_cnt := COUNT(GROUP,h.subdivision <> (TYPEOF(h.subdivision))'');
    populated_subdivision_pcnt := AVE(GROUP,IF(h.subdivision = (TYPEOF(h.subdivision))'',0,100));
    maxlength_subdivision := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.subdivision)));
    avelength_subdivision := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.subdivision)),h.subdivision<>(typeof(h.subdivision))'');
    populated_src_subdivision_cnt := COUNT(GROUP,h.src_subdivision <> (TYPEOF(h.src_subdivision))'');
    populated_src_subdivision_pcnt := AVE(GROUP,IF(h.src_subdivision = (TYPEOF(h.src_subdivision))'',0,100));
    maxlength_src_subdivision := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_subdivision)));
    avelength_src_subdivision := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_subdivision)),h.src_subdivision<>(typeof(h.src_subdivision))'');
    populated_tax_dt_subdivision_cnt := COUNT(GROUP,h.tax_dt_subdivision <> (TYPEOF(h.tax_dt_subdivision))'');
    populated_tax_dt_subdivision_pcnt := AVE(GROUP,IF(h.tax_dt_subdivision = (TYPEOF(h.tax_dt_subdivision))'',0,100));
    maxlength_tax_dt_subdivision := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_subdivision)));
    avelength_tax_dt_subdivision := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_subdivision)),h.tax_dt_subdivision<>(typeof(h.tax_dt_subdivision))'');
    populated_municipality_cnt := COUNT(GROUP,h.municipality <> (TYPEOF(h.municipality))'');
    populated_municipality_pcnt := AVE(GROUP,IF(h.municipality = (TYPEOF(h.municipality))'',0,100));
    maxlength_municipality := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.municipality)));
    avelength_municipality := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.municipality)),h.municipality<>(typeof(h.municipality))'');
    populated_src_municipality_cnt := COUNT(GROUP,h.src_municipality <> (TYPEOF(h.src_municipality))'');
    populated_src_municipality_pcnt := AVE(GROUP,IF(h.src_municipality = (TYPEOF(h.src_municipality))'',0,100));
    maxlength_src_municipality := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_municipality)));
    avelength_src_municipality := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_municipality)),h.src_municipality<>(typeof(h.src_municipality))'');
    populated_tax_dt_municipality_cnt := COUNT(GROUP,h.tax_dt_municipality <> (TYPEOF(h.tax_dt_municipality))'');
    populated_tax_dt_municipality_pcnt := AVE(GROUP,IF(h.tax_dt_municipality = (TYPEOF(h.tax_dt_municipality))'',0,100));
    maxlength_tax_dt_municipality := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_municipality)));
    avelength_tax_dt_municipality := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_municipality)),h.tax_dt_municipality<>(typeof(h.tax_dt_municipality))'');
    populated_township_cnt := COUNT(GROUP,h.township <> (TYPEOF(h.township))'');
    populated_township_pcnt := AVE(GROUP,IF(h.township = (TYPEOF(h.township))'',0,100));
    maxlength_township := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.township)));
    avelength_township := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.township)),h.township<>(typeof(h.township))'');
    populated_src_township_cnt := COUNT(GROUP,h.src_township <> (TYPEOF(h.src_township))'');
    populated_src_township_pcnt := AVE(GROUP,IF(h.src_township = (TYPEOF(h.src_township))'',0,100));
    maxlength_src_township := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_township)));
    avelength_src_township := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_township)),h.src_township<>(typeof(h.src_township))'');
    populated_tax_dt_township_cnt := COUNT(GROUP,h.tax_dt_township <> (TYPEOF(h.tax_dt_township))'');
    populated_tax_dt_township_pcnt := AVE(GROUP,IF(h.tax_dt_township = (TYPEOF(h.tax_dt_township))'',0,100));
    maxlength_tax_dt_township := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_township)));
    avelength_tax_dt_township := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_township)),h.tax_dt_township<>(typeof(h.tax_dt_township))'');
    populated_homestead_exemption_ind_cnt := COUNT(GROUP,h.homestead_exemption_ind <> (TYPEOF(h.homestead_exemption_ind))'');
    populated_homestead_exemption_ind_pcnt := AVE(GROUP,IF(h.homestead_exemption_ind = (TYPEOF(h.homestead_exemption_ind))'',0,100));
    maxlength_homestead_exemption_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homestead_exemption_ind)));
    avelength_homestead_exemption_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homestead_exemption_ind)),h.homestead_exemption_ind<>(typeof(h.homestead_exemption_ind))'');
    populated_src_homestead_exemption_ind_cnt := COUNT(GROUP,h.src_homestead_exemption_ind <> (TYPEOF(h.src_homestead_exemption_ind))'');
    populated_src_homestead_exemption_ind_pcnt := AVE(GROUP,IF(h.src_homestead_exemption_ind = (TYPEOF(h.src_homestead_exemption_ind))'',0,100));
    maxlength_src_homestead_exemption_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_homestead_exemption_ind)));
    avelength_src_homestead_exemption_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_homestead_exemption_ind)),h.src_homestead_exemption_ind<>(typeof(h.src_homestead_exemption_ind))'');
    populated_tax_dt_homestead_exemption_ind_cnt := COUNT(GROUP,h.tax_dt_homestead_exemption_ind <> (TYPEOF(h.tax_dt_homestead_exemption_ind))'');
    populated_tax_dt_homestead_exemption_ind_pcnt := AVE(GROUP,IF(h.tax_dt_homestead_exemption_ind = (TYPEOF(h.tax_dt_homestead_exemption_ind))'',0,100));
    maxlength_tax_dt_homestead_exemption_ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_homestead_exemption_ind)));
    avelength_tax_dt_homestead_exemption_ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_homestead_exemption_ind)),h.tax_dt_homestead_exemption_ind<>(typeof(h.tax_dt_homestead_exemption_ind))'');
    populated_land_use_code_cnt := COUNT(GROUP,h.land_use_code <> (TYPEOF(h.land_use_code))'');
    populated_land_use_code_pcnt := AVE(GROUP,IF(h.land_use_code = (TYPEOF(h.land_use_code))'',0,100));
    maxlength_land_use_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_use_code)));
    avelength_land_use_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.land_use_code)),h.land_use_code<>(typeof(h.land_use_code))'');
    populated_src_land_use_code_cnt := COUNT(GROUP,h.src_land_use_code <> (TYPEOF(h.src_land_use_code))'');
    populated_src_land_use_code_pcnt := AVE(GROUP,IF(h.src_land_use_code = (TYPEOF(h.src_land_use_code))'',0,100));
    maxlength_src_land_use_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_land_use_code)));
    avelength_src_land_use_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_land_use_code)),h.src_land_use_code<>(typeof(h.src_land_use_code))'');
    populated_tax_dt_land_use_code_cnt := COUNT(GROUP,h.tax_dt_land_use_code <> (TYPEOF(h.tax_dt_land_use_code))'');
    populated_tax_dt_land_use_code_pcnt := AVE(GROUP,IF(h.tax_dt_land_use_code = (TYPEOF(h.tax_dt_land_use_code))'',0,100));
    maxlength_tax_dt_land_use_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_land_use_code)));
    avelength_tax_dt_land_use_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_land_use_code)),h.tax_dt_land_use_code<>(typeof(h.tax_dt_land_use_code))'');
    populated_latitude_cnt := COUNT(GROUP,h.latitude <> (TYPEOF(h.latitude))'');
    populated_latitude_pcnt := AVE(GROUP,IF(h.latitude = (TYPEOF(h.latitude))'',0,100));
    maxlength_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)));
    avelength_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.latitude)),h.latitude<>(typeof(h.latitude))'');
    populated_src_latitude_cnt := COUNT(GROUP,h.src_latitude <> (TYPEOF(h.src_latitude))'');
    populated_src_latitude_pcnt := AVE(GROUP,IF(h.src_latitude = (TYPEOF(h.src_latitude))'',0,100));
    maxlength_src_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_latitude)));
    avelength_src_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_latitude)),h.src_latitude<>(typeof(h.src_latitude))'');
    populated_tax_dt_latitude_cnt := COUNT(GROUP,h.tax_dt_latitude <> (TYPEOF(h.tax_dt_latitude))'');
    populated_tax_dt_latitude_pcnt := AVE(GROUP,IF(h.tax_dt_latitude = (TYPEOF(h.tax_dt_latitude))'',0,100));
    maxlength_tax_dt_latitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_latitude)));
    avelength_tax_dt_latitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_latitude)),h.tax_dt_latitude<>(typeof(h.tax_dt_latitude))'');
    populated_longitude_cnt := COUNT(GROUP,h.longitude <> (TYPEOF(h.longitude))'');
    populated_longitude_pcnt := AVE(GROUP,IF(h.longitude = (TYPEOF(h.longitude))'',0,100));
    maxlength_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)));
    avelength_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.longitude)),h.longitude<>(typeof(h.longitude))'');
    populated_src_longitude_cnt := COUNT(GROUP,h.src_longitude <> (TYPEOF(h.src_longitude))'');
    populated_src_longitude_pcnt := AVE(GROUP,IF(h.src_longitude = (TYPEOF(h.src_longitude))'',0,100));
    maxlength_src_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_longitude)));
    avelength_src_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_longitude)),h.src_longitude<>(typeof(h.src_longitude))'');
    populated_tax_dt_longitude_cnt := COUNT(GROUP,h.tax_dt_longitude <> (TYPEOF(h.tax_dt_longitude))'');
    populated_tax_dt_longitude_pcnt := AVE(GROUP,IF(h.tax_dt_longitude = (TYPEOF(h.tax_dt_longitude))'',0,100));
    maxlength_tax_dt_longitude := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_longitude)));
    avelength_tax_dt_longitude := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_longitude)),h.tax_dt_longitude<>(typeof(h.tax_dt_longitude))'');
    populated_location_influence_code_cnt := COUNT(GROUP,h.location_influence_code <> (TYPEOF(h.location_influence_code))'');
    populated_location_influence_code_pcnt := AVE(GROUP,IF(h.location_influence_code = (TYPEOF(h.location_influence_code))'',0,100));
    maxlength_location_influence_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_influence_code)));
    avelength_location_influence_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_influence_code)),h.location_influence_code<>(typeof(h.location_influence_code))'');
    populated_src_location_influence_code_cnt := COUNT(GROUP,h.src_location_influence_code <> (TYPEOF(h.src_location_influence_code))'');
    populated_src_location_influence_code_pcnt := AVE(GROUP,IF(h.src_location_influence_code = (TYPEOF(h.src_location_influence_code))'',0,100));
    maxlength_src_location_influence_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_location_influence_code)));
    avelength_src_location_influence_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_location_influence_code)),h.src_location_influence_code<>(typeof(h.src_location_influence_code))'');
    populated_tax_dt_location_influence_code_cnt := COUNT(GROUP,h.tax_dt_location_influence_code <> (TYPEOF(h.tax_dt_location_influence_code))'');
    populated_tax_dt_location_influence_code_pcnt := AVE(GROUP,IF(h.tax_dt_location_influence_code = (TYPEOF(h.tax_dt_location_influence_code))'',0,100));
    maxlength_tax_dt_location_influence_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_location_influence_code)));
    avelength_tax_dt_location_influence_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_location_influence_code)),h.tax_dt_location_influence_code<>(typeof(h.tax_dt_location_influence_code))'');
    populated_acres_cnt := COUNT(GROUP,h.acres <> (TYPEOF(h.acres))'');
    populated_acres_pcnt := AVE(GROUP,IF(h.acres = (TYPEOF(h.acres))'',0,100));
    maxlength_acres := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.acres)));
    avelength_acres := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.acres)),h.acres<>(typeof(h.acres))'');
    populated_src_acres_cnt := COUNT(GROUP,h.src_acres <> (TYPEOF(h.src_acres))'');
    populated_src_acres_pcnt := AVE(GROUP,IF(h.src_acres = (TYPEOF(h.src_acres))'',0,100));
    maxlength_src_acres := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_acres)));
    avelength_src_acres := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_acres)),h.src_acres<>(typeof(h.src_acres))'');
    populated_tax_dt_acres_cnt := COUNT(GROUP,h.tax_dt_acres <> (TYPEOF(h.tax_dt_acres))'');
    populated_tax_dt_acres_pcnt := AVE(GROUP,IF(h.tax_dt_acres = (TYPEOF(h.tax_dt_acres))'',0,100));
    maxlength_tax_dt_acres := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_acres)));
    avelength_tax_dt_acres := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_acres)),h.tax_dt_acres<>(typeof(h.tax_dt_acres))'');
    populated_lot_depth_footage_cnt := COUNT(GROUP,h.lot_depth_footage <> (TYPEOF(h.lot_depth_footage))'');
    populated_lot_depth_footage_pcnt := AVE(GROUP,IF(h.lot_depth_footage = (TYPEOF(h.lot_depth_footage))'',0,100));
    maxlength_lot_depth_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_depth_footage)));
    avelength_lot_depth_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_depth_footage)),h.lot_depth_footage<>(typeof(h.lot_depth_footage))'');
    populated_src_lot_depth_footage_cnt := COUNT(GROUP,h.src_lot_depth_footage <> (TYPEOF(h.src_lot_depth_footage))'');
    populated_src_lot_depth_footage_pcnt := AVE(GROUP,IF(h.src_lot_depth_footage = (TYPEOF(h.src_lot_depth_footage))'',0,100));
    maxlength_src_lot_depth_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_lot_depth_footage)));
    avelength_src_lot_depth_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_lot_depth_footage)),h.src_lot_depth_footage<>(typeof(h.src_lot_depth_footage))'');
    populated_tax_dt_lot_depth_footage_cnt := COUNT(GROUP,h.tax_dt_lot_depth_footage <> (TYPEOF(h.tax_dt_lot_depth_footage))'');
    populated_tax_dt_lot_depth_footage_pcnt := AVE(GROUP,IF(h.tax_dt_lot_depth_footage = (TYPEOF(h.tax_dt_lot_depth_footage))'',0,100));
    maxlength_tax_dt_lot_depth_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_lot_depth_footage)));
    avelength_tax_dt_lot_depth_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_lot_depth_footage)),h.tax_dt_lot_depth_footage<>(typeof(h.tax_dt_lot_depth_footage))'');
    populated_lot_front_footage_cnt := COUNT(GROUP,h.lot_front_footage <> (TYPEOF(h.lot_front_footage))'');
    populated_lot_front_footage_pcnt := AVE(GROUP,IF(h.lot_front_footage = (TYPEOF(h.lot_front_footage))'',0,100));
    maxlength_lot_front_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_front_footage)));
    avelength_lot_front_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_front_footage)),h.lot_front_footage<>(typeof(h.lot_front_footage))'');
    populated_src_lot_front_footage_cnt := COUNT(GROUP,h.src_lot_front_footage <> (TYPEOF(h.src_lot_front_footage))'');
    populated_src_lot_front_footage_pcnt := AVE(GROUP,IF(h.src_lot_front_footage = (TYPEOF(h.src_lot_front_footage))'',0,100));
    maxlength_src_lot_front_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_lot_front_footage)));
    avelength_src_lot_front_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_lot_front_footage)),h.src_lot_front_footage<>(typeof(h.src_lot_front_footage))'');
    populated_tax_dt_lot_front_footage_cnt := COUNT(GROUP,h.tax_dt_lot_front_footage <> (TYPEOF(h.tax_dt_lot_front_footage))'');
    populated_tax_dt_lot_front_footage_pcnt := AVE(GROUP,IF(h.tax_dt_lot_front_footage = (TYPEOF(h.tax_dt_lot_front_footage))'',0,100));
    maxlength_tax_dt_lot_front_footage := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_lot_front_footage)));
    avelength_tax_dt_lot_front_footage := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_lot_front_footage)),h.tax_dt_lot_front_footage<>(typeof(h.tax_dt_lot_front_footage))'');
    populated_lot_number_cnt := COUNT(GROUP,h.lot_number <> (TYPEOF(h.lot_number))'');
    populated_lot_number_pcnt := AVE(GROUP,IF(h.lot_number = (TYPEOF(h.lot_number))'',0,100));
    maxlength_lot_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_number)));
    avelength_lot_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_number)),h.lot_number<>(typeof(h.lot_number))'');
    populated_src_lot_number_cnt := COUNT(GROUP,h.src_lot_number <> (TYPEOF(h.src_lot_number))'');
    populated_src_lot_number_pcnt := AVE(GROUP,IF(h.src_lot_number = (TYPEOF(h.src_lot_number))'',0,100));
    maxlength_src_lot_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_lot_number)));
    avelength_src_lot_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_lot_number)),h.src_lot_number<>(typeof(h.src_lot_number))'');
    populated_tax_dt_lot_number_cnt := COUNT(GROUP,h.tax_dt_lot_number <> (TYPEOF(h.tax_dt_lot_number))'');
    populated_tax_dt_lot_number_pcnt := AVE(GROUP,IF(h.tax_dt_lot_number = (TYPEOF(h.tax_dt_lot_number))'',0,100));
    maxlength_tax_dt_lot_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_lot_number)));
    avelength_tax_dt_lot_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_lot_number)),h.tax_dt_lot_number<>(typeof(h.tax_dt_lot_number))'');
    populated_lot_size_cnt := COUNT(GROUP,h.lot_size <> (TYPEOF(h.lot_size))'');
    populated_lot_size_pcnt := AVE(GROUP,IF(h.lot_size = (TYPEOF(h.lot_size))'',0,100));
    maxlength_lot_size := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size)));
    avelength_lot_size := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lot_size)),h.lot_size<>(typeof(h.lot_size))'');
    populated_src_lot_size_cnt := COUNT(GROUP,h.src_lot_size <> (TYPEOF(h.src_lot_size))'');
    populated_src_lot_size_pcnt := AVE(GROUP,IF(h.src_lot_size = (TYPEOF(h.src_lot_size))'',0,100));
    maxlength_src_lot_size := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_lot_size)));
    avelength_src_lot_size := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_lot_size)),h.src_lot_size<>(typeof(h.src_lot_size))'');
    populated_tax_dt_lot_size_cnt := COUNT(GROUP,h.tax_dt_lot_size <> (TYPEOF(h.tax_dt_lot_size))'');
    populated_tax_dt_lot_size_pcnt := AVE(GROUP,IF(h.tax_dt_lot_size = (TYPEOF(h.tax_dt_lot_size))'',0,100));
    maxlength_tax_dt_lot_size := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_lot_size)));
    avelength_tax_dt_lot_size := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_lot_size)),h.tax_dt_lot_size<>(typeof(h.tax_dt_lot_size))'');
    populated_property_type_code_cnt := COUNT(GROUP,h.property_type_code <> (TYPEOF(h.property_type_code))'');
    populated_property_type_code_pcnt := AVE(GROUP,IF(h.property_type_code = (TYPEOF(h.property_type_code))'',0,100));
    maxlength_property_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_type_code)));
    avelength_property_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.property_type_code)),h.property_type_code<>(typeof(h.property_type_code))'');
    populated_src_property_type_code_cnt := COUNT(GROUP,h.src_property_type_code <> (TYPEOF(h.src_property_type_code))'');
    populated_src_property_type_code_pcnt := AVE(GROUP,IF(h.src_property_type_code = (TYPEOF(h.src_property_type_code))'',0,100));
    maxlength_src_property_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_property_type_code)));
    avelength_src_property_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_property_type_code)),h.src_property_type_code<>(typeof(h.src_property_type_code))'');
    populated_tax_dt_property_type_code_cnt := COUNT(GROUP,h.tax_dt_property_type_code <> (TYPEOF(h.tax_dt_property_type_code))'');
    populated_tax_dt_property_type_code_pcnt := AVE(GROUP,IF(h.tax_dt_property_type_code = (TYPEOF(h.tax_dt_property_type_code))'',0,100));
    maxlength_tax_dt_property_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_property_type_code)));
    avelength_tax_dt_property_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_property_type_code)),h.tax_dt_property_type_code<>(typeof(h.tax_dt_property_type_code))'');
    populated_structure_quality_cnt := COUNT(GROUP,h.structure_quality <> (TYPEOF(h.structure_quality))'');
    populated_structure_quality_pcnt := AVE(GROUP,IF(h.structure_quality = (TYPEOF(h.structure_quality))'',0,100));
    maxlength_structure_quality := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.structure_quality)));
    avelength_structure_quality := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.structure_quality)),h.structure_quality<>(typeof(h.structure_quality))'');
    populated_src_structure_quality_cnt := COUNT(GROUP,h.src_structure_quality <> (TYPEOF(h.src_structure_quality))'');
    populated_src_structure_quality_pcnt := AVE(GROUP,IF(h.src_structure_quality = (TYPEOF(h.src_structure_quality))'',0,100));
    maxlength_src_structure_quality := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_structure_quality)));
    avelength_src_structure_quality := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_structure_quality)),h.src_structure_quality<>(typeof(h.src_structure_quality))'');
    populated_tax_dt_structure_quality_cnt := COUNT(GROUP,h.tax_dt_structure_quality <> (TYPEOF(h.tax_dt_structure_quality))'');
    populated_tax_dt_structure_quality_pcnt := AVE(GROUP,IF(h.tax_dt_structure_quality = (TYPEOF(h.tax_dt_structure_quality))'',0,100));
    maxlength_tax_dt_structure_quality := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_structure_quality)));
    avelength_tax_dt_structure_quality := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_structure_quality)),h.tax_dt_structure_quality<>(typeof(h.tax_dt_structure_quality))'');
    populated_water_cnt := COUNT(GROUP,h.water <> (TYPEOF(h.water))'');
    populated_water_pcnt := AVE(GROUP,IF(h.water = (TYPEOF(h.water))'',0,100));
    maxlength_water := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.water)));
    avelength_water := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.water)),h.water<>(typeof(h.water))'');
    populated_src_water_cnt := COUNT(GROUP,h.src_water <> (TYPEOF(h.src_water))'');
    populated_src_water_pcnt := AVE(GROUP,IF(h.src_water = (TYPEOF(h.src_water))'',0,100));
    maxlength_src_water := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_water)));
    avelength_src_water := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_water)),h.src_water<>(typeof(h.src_water))'');
    populated_tax_dt_water_cnt := COUNT(GROUP,h.tax_dt_water <> (TYPEOF(h.tax_dt_water))'');
    populated_tax_dt_water_pcnt := AVE(GROUP,IF(h.tax_dt_water = (TYPEOF(h.tax_dt_water))'',0,100));
    maxlength_tax_dt_water := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_water)));
    avelength_tax_dt_water := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_water)),h.tax_dt_water<>(typeof(h.tax_dt_water))'');
    populated_sewer_cnt := COUNT(GROUP,h.sewer <> (TYPEOF(h.sewer))'');
    populated_sewer_pcnt := AVE(GROUP,IF(h.sewer = (TYPEOF(h.sewer))'',0,100));
    maxlength_sewer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sewer)));
    avelength_sewer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sewer)),h.sewer<>(typeof(h.sewer))'');
    populated_src_sewer_cnt := COUNT(GROUP,h.src_sewer <> (TYPEOF(h.src_sewer))'');
    populated_src_sewer_pcnt := AVE(GROUP,IF(h.src_sewer = (TYPEOF(h.src_sewer))'',0,100));
    maxlength_src_sewer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_sewer)));
    avelength_src_sewer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_sewer)),h.src_sewer<>(typeof(h.src_sewer))'');
    populated_tax_dt_sewer_cnt := COUNT(GROUP,h.tax_dt_sewer <> (TYPEOF(h.tax_dt_sewer))'');
    populated_tax_dt_sewer_pcnt := AVE(GROUP,IF(h.tax_dt_sewer = (TYPEOF(h.tax_dt_sewer))'',0,100));
    maxlength_tax_dt_sewer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_sewer)));
    avelength_tax_dt_sewer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_sewer)),h.tax_dt_sewer<>(typeof(h.tax_dt_sewer))'');
    populated_assessed_land_value_cnt := COUNT(GROUP,h.assessed_land_value <> (TYPEOF(h.assessed_land_value))'');
    populated_assessed_land_value_pcnt := AVE(GROUP,IF(h.assessed_land_value = (TYPEOF(h.assessed_land_value))'',0,100));
    maxlength_assessed_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_land_value)));
    avelength_assessed_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_land_value)),h.assessed_land_value<>(typeof(h.assessed_land_value))'');
    populated_src_assessed_land_value_cnt := COUNT(GROUP,h.src_assessed_land_value <> (TYPEOF(h.src_assessed_land_value))'');
    populated_src_assessed_land_value_pcnt := AVE(GROUP,IF(h.src_assessed_land_value = (TYPEOF(h.src_assessed_land_value))'',0,100));
    maxlength_src_assessed_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_assessed_land_value)));
    avelength_src_assessed_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_assessed_land_value)),h.src_assessed_land_value<>(typeof(h.src_assessed_land_value))'');
    populated_tax_dt_assessed_land_value_cnt := COUNT(GROUP,h.tax_dt_assessed_land_value <> (TYPEOF(h.tax_dt_assessed_land_value))'');
    populated_tax_dt_assessed_land_value_pcnt := AVE(GROUP,IF(h.tax_dt_assessed_land_value = (TYPEOF(h.tax_dt_assessed_land_value))'',0,100));
    maxlength_tax_dt_assessed_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_assessed_land_value)));
    avelength_tax_dt_assessed_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_assessed_land_value)),h.tax_dt_assessed_land_value<>(typeof(h.tax_dt_assessed_land_value))'');
    populated_assessed_year_cnt := COUNT(GROUP,h.assessed_year <> (TYPEOF(h.assessed_year))'');
    populated_assessed_year_pcnt := AVE(GROUP,IF(h.assessed_year = (TYPEOF(h.assessed_year))'',0,100));
    maxlength_assessed_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_year)));
    avelength_assessed_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessed_year)),h.assessed_year<>(typeof(h.assessed_year))'');
    populated_src_assessed_year_cnt := COUNT(GROUP,h.src_assessed_year <> (TYPEOF(h.src_assessed_year))'');
    populated_src_assessed_year_pcnt := AVE(GROUP,IF(h.src_assessed_year = (TYPEOF(h.src_assessed_year))'',0,100));
    maxlength_src_assessed_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_assessed_year)));
    avelength_src_assessed_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_assessed_year)),h.src_assessed_year<>(typeof(h.src_assessed_year))'');
    populated_tax_dt_assessed_year_cnt := COUNT(GROUP,h.tax_dt_assessed_year <> (TYPEOF(h.tax_dt_assessed_year))'');
    populated_tax_dt_assessed_year_pcnt := AVE(GROUP,IF(h.tax_dt_assessed_year = (TYPEOF(h.tax_dt_assessed_year))'',0,100));
    maxlength_tax_dt_assessed_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_assessed_year)));
    avelength_tax_dt_assessed_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_assessed_year)),h.tax_dt_assessed_year<>(typeof(h.tax_dt_assessed_year))'');
    populated_tax_amount_cnt := COUNT(GROUP,h.tax_amount <> (TYPEOF(h.tax_amount))'');
    populated_tax_amount_pcnt := AVE(GROUP,IF(h.tax_amount = (TYPEOF(h.tax_amount))'',0,100));
    maxlength_tax_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_amount)));
    avelength_tax_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_amount)),h.tax_amount<>(typeof(h.tax_amount))'');
    populated_src_tax_amount_cnt := COUNT(GROUP,h.src_tax_amount <> (TYPEOF(h.src_tax_amount))'');
    populated_src_tax_amount_pcnt := AVE(GROUP,IF(h.src_tax_amount = (TYPEOF(h.src_tax_amount))'',0,100));
    maxlength_src_tax_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_tax_amount)));
    avelength_src_tax_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_tax_amount)),h.src_tax_amount<>(typeof(h.src_tax_amount))'');
    populated_tax_dt_tax_amount_cnt := COUNT(GROUP,h.tax_dt_tax_amount <> (TYPEOF(h.tax_dt_tax_amount))'');
    populated_tax_dt_tax_amount_pcnt := AVE(GROUP,IF(h.tax_dt_tax_amount = (TYPEOF(h.tax_dt_tax_amount))'',0,100));
    maxlength_tax_dt_tax_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_tax_amount)));
    avelength_tax_dt_tax_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_tax_amount)),h.tax_dt_tax_amount<>(typeof(h.tax_dt_tax_amount))'');
    populated_tax_year_cnt := COUNT(GROUP,h.tax_year <> (TYPEOF(h.tax_year))'');
    populated_tax_year_pcnt := AVE(GROUP,IF(h.tax_year = (TYPEOF(h.tax_year))'',0,100));
    maxlength_tax_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_year)));
    avelength_tax_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_year)),h.tax_year<>(typeof(h.tax_year))'');
    populated_src_tax_year_cnt := COUNT(GROUP,h.src_tax_year <> (TYPEOF(h.src_tax_year))'');
    populated_src_tax_year_pcnt := AVE(GROUP,IF(h.src_tax_year = (TYPEOF(h.src_tax_year))'',0,100));
    maxlength_src_tax_year := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_tax_year)));
    avelength_src_tax_year := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_tax_year)),h.src_tax_year<>(typeof(h.src_tax_year))'');
    populated_market_land_value_cnt := COUNT(GROUP,h.market_land_value <> (TYPEOF(h.market_land_value))'');
    populated_market_land_value_pcnt := AVE(GROUP,IF(h.market_land_value = (TYPEOF(h.market_land_value))'',0,100));
    maxlength_market_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_land_value)));
    avelength_market_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_land_value)),h.market_land_value<>(typeof(h.market_land_value))'');
    populated_src_market_land_value_cnt := COUNT(GROUP,h.src_market_land_value <> (TYPEOF(h.src_market_land_value))'');
    populated_src_market_land_value_pcnt := AVE(GROUP,IF(h.src_market_land_value = (TYPEOF(h.src_market_land_value))'',0,100));
    maxlength_src_market_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_market_land_value)));
    avelength_src_market_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_market_land_value)),h.src_market_land_value<>(typeof(h.src_market_land_value))'');
    populated_tax_dt_market_land_value_cnt := COUNT(GROUP,h.tax_dt_market_land_value <> (TYPEOF(h.tax_dt_market_land_value))'');
    populated_tax_dt_market_land_value_pcnt := AVE(GROUP,IF(h.tax_dt_market_land_value = (TYPEOF(h.tax_dt_market_land_value))'',0,100));
    maxlength_tax_dt_market_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_market_land_value)));
    avelength_tax_dt_market_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_market_land_value)),h.tax_dt_market_land_value<>(typeof(h.tax_dt_market_land_value))'');
    populated_improvement_value_cnt := COUNT(GROUP,h.improvement_value <> (TYPEOF(h.improvement_value))'');
    populated_improvement_value_pcnt := AVE(GROUP,IF(h.improvement_value = (TYPEOF(h.improvement_value))'',0,100));
    maxlength_improvement_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.improvement_value)));
    avelength_improvement_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.improvement_value)),h.improvement_value<>(typeof(h.improvement_value))'');
    populated_src_improvement_value_cnt := COUNT(GROUP,h.src_improvement_value <> (TYPEOF(h.src_improvement_value))'');
    populated_src_improvement_value_pcnt := AVE(GROUP,IF(h.src_improvement_value = (TYPEOF(h.src_improvement_value))'',0,100));
    maxlength_src_improvement_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_improvement_value)));
    avelength_src_improvement_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_improvement_value)),h.src_improvement_value<>(typeof(h.src_improvement_value))'');
    populated_tax_dt_improvement_value_cnt := COUNT(GROUP,h.tax_dt_improvement_value <> (TYPEOF(h.tax_dt_improvement_value))'');
    populated_tax_dt_improvement_value_pcnt := AVE(GROUP,IF(h.tax_dt_improvement_value = (TYPEOF(h.tax_dt_improvement_value))'',0,100));
    maxlength_tax_dt_improvement_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_improvement_value)));
    avelength_tax_dt_improvement_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_improvement_value)),h.tax_dt_improvement_value<>(typeof(h.tax_dt_improvement_value))'');
    populated_percent_improved_cnt := COUNT(GROUP,h.percent_improved <> (TYPEOF(h.percent_improved))'');
    populated_percent_improved_pcnt := AVE(GROUP,IF(h.percent_improved = (TYPEOF(h.percent_improved))'',0,100));
    maxlength_percent_improved := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.percent_improved)));
    avelength_percent_improved := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.percent_improved)),h.percent_improved<>(typeof(h.percent_improved))'');
    populated_src_percent_improved_cnt := COUNT(GROUP,h.src_percent_improved <> (TYPEOF(h.src_percent_improved))'');
    populated_src_percent_improved_pcnt := AVE(GROUP,IF(h.src_percent_improved = (TYPEOF(h.src_percent_improved))'',0,100));
    maxlength_src_percent_improved := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_percent_improved)));
    avelength_src_percent_improved := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_percent_improved)),h.src_percent_improved<>(typeof(h.src_percent_improved))'');
    populated_tax_dt_percent_improved_cnt := COUNT(GROUP,h.tax_dt_percent_improved <> (TYPEOF(h.tax_dt_percent_improved))'');
    populated_tax_dt_percent_improved_pcnt := AVE(GROUP,IF(h.tax_dt_percent_improved = (TYPEOF(h.tax_dt_percent_improved))'',0,100));
    maxlength_tax_dt_percent_improved := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_percent_improved)));
    avelength_tax_dt_percent_improved := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_percent_improved)),h.tax_dt_percent_improved<>(typeof(h.tax_dt_percent_improved))'');
    populated_total_assessed_value_cnt := COUNT(GROUP,h.total_assessed_value <> (TYPEOF(h.total_assessed_value))'');
    populated_total_assessed_value_pcnt := AVE(GROUP,IF(h.total_assessed_value = (TYPEOF(h.total_assessed_value))'',0,100));
    maxlength_total_assessed_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_assessed_value)));
    avelength_total_assessed_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_assessed_value)),h.total_assessed_value<>(typeof(h.total_assessed_value))'');
    populated_src_total_assessed_value_cnt := COUNT(GROUP,h.src_total_assessed_value <> (TYPEOF(h.src_total_assessed_value))'');
    populated_src_total_assessed_value_pcnt := AVE(GROUP,IF(h.src_total_assessed_value = (TYPEOF(h.src_total_assessed_value))'',0,100));
    maxlength_src_total_assessed_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_total_assessed_value)));
    avelength_src_total_assessed_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_total_assessed_value)),h.src_total_assessed_value<>(typeof(h.src_total_assessed_value))'');
    populated_tax_dt_total_assessed_value_cnt := COUNT(GROUP,h.tax_dt_total_assessed_value <> (TYPEOF(h.tax_dt_total_assessed_value))'');
    populated_tax_dt_total_assessed_value_pcnt := AVE(GROUP,IF(h.tax_dt_total_assessed_value = (TYPEOF(h.tax_dt_total_assessed_value))'',0,100));
    maxlength_tax_dt_total_assessed_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_total_assessed_value)));
    avelength_tax_dt_total_assessed_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_total_assessed_value)),h.tax_dt_total_assessed_value<>(typeof(h.tax_dt_total_assessed_value))'');
    populated_total_calculated_value_cnt := COUNT(GROUP,h.total_calculated_value <> (TYPEOF(h.total_calculated_value))'');
    populated_total_calculated_value_pcnt := AVE(GROUP,IF(h.total_calculated_value = (TYPEOF(h.total_calculated_value))'',0,100));
    maxlength_total_calculated_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_calculated_value)));
    avelength_total_calculated_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_calculated_value)),h.total_calculated_value<>(typeof(h.total_calculated_value))'');
    populated_src_total_calculated_value_cnt := COUNT(GROUP,h.src_total_calculated_value <> (TYPEOF(h.src_total_calculated_value))'');
    populated_src_total_calculated_value_pcnt := AVE(GROUP,IF(h.src_total_calculated_value = (TYPEOF(h.src_total_calculated_value))'',0,100));
    maxlength_src_total_calculated_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_total_calculated_value)));
    avelength_src_total_calculated_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_total_calculated_value)),h.src_total_calculated_value<>(typeof(h.src_total_calculated_value))'');
    populated_tax_dt_total_calculated_value_cnt := COUNT(GROUP,h.tax_dt_total_calculated_value <> (TYPEOF(h.tax_dt_total_calculated_value))'');
    populated_tax_dt_total_calculated_value_pcnt := AVE(GROUP,IF(h.tax_dt_total_calculated_value = (TYPEOF(h.tax_dt_total_calculated_value))'',0,100));
    maxlength_tax_dt_total_calculated_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_total_calculated_value)));
    avelength_tax_dt_total_calculated_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_total_calculated_value)),h.tax_dt_total_calculated_value<>(typeof(h.tax_dt_total_calculated_value))'');
    populated_total_land_value_cnt := COUNT(GROUP,h.total_land_value <> (TYPEOF(h.total_land_value))'');
    populated_total_land_value_pcnt := AVE(GROUP,IF(h.total_land_value = (TYPEOF(h.total_land_value))'',0,100));
    maxlength_total_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_land_value)));
    avelength_total_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_land_value)),h.total_land_value<>(typeof(h.total_land_value))'');
    populated_src_total_land_value_cnt := COUNT(GROUP,h.src_total_land_value <> (TYPEOF(h.src_total_land_value))'');
    populated_src_total_land_value_pcnt := AVE(GROUP,IF(h.src_total_land_value = (TYPEOF(h.src_total_land_value))'',0,100));
    maxlength_src_total_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_total_land_value)));
    avelength_src_total_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_total_land_value)),h.src_total_land_value<>(typeof(h.src_total_land_value))'');
    populated_tax_dt_total_land_value_cnt := COUNT(GROUP,h.tax_dt_total_land_value <> (TYPEOF(h.tax_dt_total_land_value))'');
    populated_tax_dt_total_land_value_pcnt := AVE(GROUP,IF(h.tax_dt_total_land_value = (TYPEOF(h.tax_dt_total_land_value))'',0,100));
    maxlength_tax_dt_total_land_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_total_land_value)));
    avelength_tax_dt_total_land_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_total_land_value)),h.tax_dt_total_land_value<>(typeof(h.tax_dt_total_land_value))'');
    populated_total_market_value_cnt := COUNT(GROUP,h.total_market_value <> (TYPEOF(h.total_market_value))'');
    populated_total_market_value_pcnt := AVE(GROUP,IF(h.total_market_value = (TYPEOF(h.total_market_value))'',0,100));
    maxlength_total_market_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_market_value)));
    avelength_total_market_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.total_market_value)),h.total_market_value<>(typeof(h.total_market_value))'');
    populated_src_total_market_value_cnt := COUNT(GROUP,h.src_total_market_value <> (TYPEOF(h.src_total_market_value))'');
    populated_src_total_market_value_pcnt := AVE(GROUP,IF(h.src_total_market_value = (TYPEOF(h.src_total_market_value))'',0,100));
    maxlength_src_total_market_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_total_market_value)));
    avelength_src_total_market_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_total_market_value)),h.src_total_market_value<>(typeof(h.src_total_market_value))'');
    populated_tax_dt_total_market_value_cnt := COUNT(GROUP,h.tax_dt_total_market_value <> (TYPEOF(h.tax_dt_total_market_value))'');
    populated_tax_dt_total_market_value_pcnt := AVE(GROUP,IF(h.tax_dt_total_market_value = (TYPEOF(h.tax_dt_total_market_value))'',0,100));
    maxlength_tax_dt_total_market_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_total_market_value)));
    avelength_tax_dt_total_market_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_total_market_value)),h.tax_dt_total_market_value<>(typeof(h.tax_dt_total_market_value))'');
    populated_floor_type_cnt := COUNT(GROUP,h.floor_type <> (TYPEOF(h.floor_type))'');
    populated_floor_type_pcnt := AVE(GROUP,IF(h.floor_type = (TYPEOF(h.floor_type))'',0,100));
    maxlength_floor_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.floor_type)));
    avelength_floor_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.floor_type)),h.floor_type<>(typeof(h.floor_type))'');
    populated_src_floor_type_cnt := COUNT(GROUP,h.src_floor_type <> (TYPEOF(h.src_floor_type))'');
    populated_src_floor_type_pcnt := AVE(GROUP,IF(h.src_floor_type = (TYPEOF(h.src_floor_type))'',0,100));
    maxlength_src_floor_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_floor_type)));
    avelength_src_floor_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_floor_type)),h.src_floor_type<>(typeof(h.src_floor_type))'');
    populated_tax_dt_floor_type_cnt := COUNT(GROUP,h.tax_dt_floor_type <> (TYPEOF(h.tax_dt_floor_type))'');
    populated_tax_dt_floor_type_pcnt := AVE(GROUP,IF(h.tax_dt_floor_type = (TYPEOF(h.tax_dt_floor_type))'',0,100));
    maxlength_tax_dt_floor_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_floor_type)));
    avelength_tax_dt_floor_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_floor_type)),h.tax_dt_floor_type<>(typeof(h.tax_dt_floor_type))'');
    populated_frame_type_cnt := COUNT(GROUP,h.frame_type <> (TYPEOF(h.frame_type))'');
    populated_frame_type_pcnt := AVE(GROUP,IF(h.frame_type = (TYPEOF(h.frame_type))'',0,100));
    maxlength_frame_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.frame_type)));
    avelength_frame_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.frame_type)),h.frame_type<>(typeof(h.frame_type))'');
    populated_src_frame_type_cnt := COUNT(GROUP,h.src_frame_type <> (TYPEOF(h.src_frame_type))'');
    populated_src_frame_type_pcnt := AVE(GROUP,IF(h.src_frame_type = (TYPEOF(h.src_frame_type))'',0,100));
    maxlength_src_frame_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_frame_type)));
    avelength_src_frame_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_frame_type)),h.src_frame_type<>(typeof(h.src_frame_type))'');
    populated_tax_dt_frame_type_cnt := COUNT(GROUP,h.tax_dt_frame_type <> (TYPEOF(h.tax_dt_frame_type))'');
    populated_tax_dt_frame_type_pcnt := AVE(GROUP,IF(h.tax_dt_frame_type = (TYPEOF(h.tax_dt_frame_type))'',0,100));
    maxlength_tax_dt_frame_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_frame_type)));
    avelength_tax_dt_frame_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_frame_type)),h.tax_dt_frame_type<>(typeof(h.tax_dt_frame_type))'');
    populated_fuel_type_cnt := COUNT(GROUP,h.fuel_type <> (TYPEOF(h.fuel_type))'');
    populated_fuel_type_pcnt := AVE(GROUP,IF(h.fuel_type = (TYPEOF(h.fuel_type))'',0,100));
    maxlength_fuel_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel_type)));
    avelength_fuel_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fuel_type)),h.fuel_type<>(typeof(h.fuel_type))'');
    populated_src_fuel_type_cnt := COUNT(GROUP,h.src_fuel_type <> (TYPEOF(h.src_fuel_type))'');
    populated_src_fuel_type_pcnt := AVE(GROUP,IF(h.src_fuel_type = (TYPEOF(h.src_fuel_type))'',0,100));
    maxlength_src_fuel_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_fuel_type)));
    avelength_src_fuel_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_fuel_type)),h.src_fuel_type<>(typeof(h.src_fuel_type))'');
    populated_tax_dt_fuel_type_cnt := COUNT(GROUP,h.tax_dt_fuel_type <> (TYPEOF(h.tax_dt_fuel_type))'');
    populated_tax_dt_fuel_type_pcnt := AVE(GROUP,IF(h.tax_dt_fuel_type = (TYPEOF(h.tax_dt_fuel_type))'',0,100));
    maxlength_tax_dt_fuel_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_fuel_type)));
    avelength_tax_dt_fuel_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_fuel_type)),h.tax_dt_fuel_type<>(typeof(h.tax_dt_fuel_type))'');
    populated_no_of_bath_fixtures_cnt := COUNT(GROUP,h.no_of_bath_fixtures <> (TYPEOF(h.no_of_bath_fixtures))'');
    populated_no_of_bath_fixtures_pcnt := AVE(GROUP,IF(h.no_of_bath_fixtures = (TYPEOF(h.no_of_bath_fixtures))'',0,100));
    maxlength_no_of_bath_fixtures := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_bath_fixtures)));
    avelength_no_of_bath_fixtures := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_bath_fixtures)),h.no_of_bath_fixtures<>(typeof(h.no_of_bath_fixtures))'');
    populated_src_no_of_bath_fixtures_cnt := COUNT(GROUP,h.src_no_of_bath_fixtures <> (TYPEOF(h.src_no_of_bath_fixtures))'');
    populated_src_no_of_bath_fixtures_pcnt := AVE(GROUP,IF(h.src_no_of_bath_fixtures = (TYPEOF(h.src_no_of_bath_fixtures))'',0,100));
    maxlength_src_no_of_bath_fixtures := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_bath_fixtures)));
    avelength_src_no_of_bath_fixtures := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_bath_fixtures)),h.src_no_of_bath_fixtures<>(typeof(h.src_no_of_bath_fixtures))'');
    populated_tax_dt_no_of_bath_fixtures_cnt := COUNT(GROUP,h.tax_dt_no_of_bath_fixtures <> (TYPEOF(h.tax_dt_no_of_bath_fixtures))'');
    populated_tax_dt_no_of_bath_fixtures_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_bath_fixtures = (TYPEOF(h.tax_dt_no_of_bath_fixtures))'',0,100));
    maxlength_tax_dt_no_of_bath_fixtures := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_bath_fixtures)));
    avelength_tax_dt_no_of_bath_fixtures := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_bath_fixtures)),h.tax_dt_no_of_bath_fixtures<>(typeof(h.tax_dt_no_of_bath_fixtures))'');
    populated_no_of_rooms_cnt := COUNT(GROUP,h.no_of_rooms <> (TYPEOF(h.no_of_rooms))'');
    populated_no_of_rooms_pcnt := AVE(GROUP,IF(h.no_of_rooms = (TYPEOF(h.no_of_rooms))'',0,100));
    maxlength_no_of_rooms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_rooms)));
    avelength_no_of_rooms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_rooms)),h.no_of_rooms<>(typeof(h.no_of_rooms))'');
    populated_src_no_of_rooms_cnt := COUNT(GROUP,h.src_no_of_rooms <> (TYPEOF(h.src_no_of_rooms))'');
    populated_src_no_of_rooms_pcnt := AVE(GROUP,IF(h.src_no_of_rooms = (TYPEOF(h.src_no_of_rooms))'',0,100));
    maxlength_src_no_of_rooms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_rooms)));
    avelength_src_no_of_rooms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_rooms)),h.src_no_of_rooms<>(typeof(h.src_no_of_rooms))'');
    populated_tax_dt_no_of_rooms_cnt := COUNT(GROUP,h.tax_dt_no_of_rooms <> (TYPEOF(h.tax_dt_no_of_rooms))'');
    populated_tax_dt_no_of_rooms_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_rooms = (TYPEOF(h.tax_dt_no_of_rooms))'',0,100));
    maxlength_tax_dt_no_of_rooms := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_rooms)));
    avelength_tax_dt_no_of_rooms := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_rooms)),h.tax_dt_no_of_rooms<>(typeof(h.tax_dt_no_of_rooms))'');
    populated_no_of_units_cnt := COUNT(GROUP,h.no_of_units <> (TYPEOF(h.no_of_units))'');
    populated_no_of_units_pcnt := AVE(GROUP,IF(h.no_of_units = (TYPEOF(h.no_of_units))'',0,100));
    maxlength_no_of_units := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_units)));
    avelength_no_of_units := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.no_of_units)),h.no_of_units<>(typeof(h.no_of_units))'');
    populated_src_no_of_units_cnt := COUNT(GROUP,h.src_no_of_units <> (TYPEOF(h.src_no_of_units))'');
    populated_src_no_of_units_pcnt := AVE(GROUP,IF(h.src_no_of_units = (TYPEOF(h.src_no_of_units))'',0,100));
    maxlength_src_no_of_units := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_units)));
    avelength_src_no_of_units := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_no_of_units)),h.src_no_of_units<>(typeof(h.src_no_of_units))'');
    populated_tax_dt_no_of_units_cnt := COUNT(GROUP,h.tax_dt_no_of_units <> (TYPEOF(h.tax_dt_no_of_units))'');
    populated_tax_dt_no_of_units_pcnt := AVE(GROUP,IF(h.tax_dt_no_of_units = (TYPEOF(h.tax_dt_no_of_units))'',0,100));
    maxlength_tax_dt_no_of_units := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_units)));
    avelength_tax_dt_no_of_units := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_no_of_units)),h.tax_dt_no_of_units<>(typeof(h.tax_dt_no_of_units))'');
    populated_style_type_cnt := COUNT(GROUP,h.style_type <> (TYPEOF(h.style_type))'');
    populated_style_type_pcnt := AVE(GROUP,IF(h.style_type = (TYPEOF(h.style_type))'',0,100));
    maxlength_style_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.style_type)));
    avelength_style_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.style_type)),h.style_type<>(typeof(h.style_type))'');
    populated_src_style_type_cnt := COUNT(GROUP,h.src_style_type <> (TYPEOF(h.src_style_type))'');
    populated_src_style_type_pcnt := AVE(GROUP,IF(h.src_style_type = (TYPEOF(h.src_style_type))'',0,100));
    maxlength_src_style_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_style_type)));
    avelength_src_style_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_style_type)),h.src_style_type<>(typeof(h.src_style_type))'');
    populated_tax_dt_style_type_cnt := COUNT(GROUP,h.tax_dt_style_type <> (TYPEOF(h.tax_dt_style_type))'');
    populated_tax_dt_style_type_pcnt := AVE(GROUP,IF(h.tax_dt_style_type = (TYPEOF(h.tax_dt_style_type))'',0,100));
    maxlength_tax_dt_style_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_style_type)));
    avelength_tax_dt_style_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_style_type)),h.tax_dt_style_type<>(typeof(h.tax_dt_style_type))'');
    populated_assessment_document_number_cnt := COUNT(GROUP,h.assessment_document_number <> (TYPEOF(h.assessment_document_number))'');
    populated_assessment_document_number_pcnt := AVE(GROUP,IF(h.assessment_document_number = (TYPEOF(h.assessment_document_number))'',0,100));
    maxlength_assessment_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessment_document_number)));
    avelength_assessment_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessment_document_number)),h.assessment_document_number<>(typeof(h.assessment_document_number))'');
    populated_src_assessment_document_number_cnt := COUNT(GROUP,h.src_assessment_document_number <> (TYPEOF(h.src_assessment_document_number))'');
    populated_src_assessment_document_number_pcnt := AVE(GROUP,IF(h.src_assessment_document_number = (TYPEOF(h.src_assessment_document_number))'',0,100));
    maxlength_src_assessment_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_assessment_document_number)));
    avelength_src_assessment_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_assessment_document_number)),h.src_assessment_document_number<>(typeof(h.src_assessment_document_number))'');
    populated_tax_dt_assessment_document_number_cnt := COUNT(GROUP,h.tax_dt_assessment_document_number <> (TYPEOF(h.tax_dt_assessment_document_number))'');
    populated_tax_dt_assessment_document_number_pcnt := AVE(GROUP,IF(h.tax_dt_assessment_document_number = (TYPEOF(h.tax_dt_assessment_document_number))'',0,100));
    maxlength_tax_dt_assessment_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_assessment_document_number)));
    avelength_tax_dt_assessment_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_assessment_document_number)),h.tax_dt_assessment_document_number<>(typeof(h.tax_dt_assessment_document_number))'');
    populated_assessment_recording_date_cnt := COUNT(GROUP,h.assessment_recording_date <> (TYPEOF(h.assessment_recording_date))'');
    populated_assessment_recording_date_pcnt := AVE(GROUP,IF(h.assessment_recording_date = (TYPEOF(h.assessment_recording_date))'',0,100));
    maxlength_assessment_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessment_recording_date)));
    avelength_assessment_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.assessment_recording_date)),h.assessment_recording_date<>(typeof(h.assessment_recording_date))'');
    populated_src_assessment_recording_date_cnt := COUNT(GROUP,h.src_assessment_recording_date <> (TYPEOF(h.src_assessment_recording_date))'');
    populated_src_assessment_recording_date_pcnt := AVE(GROUP,IF(h.src_assessment_recording_date = (TYPEOF(h.src_assessment_recording_date))'',0,100));
    maxlength_src_assessment_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_assessment_recording_date)));
    avelength_src_assessment_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_assessment_recording_date)),h.src_assessment_recording_date<>(typeof(h.src_assessment_recording_date))'');
    populated_tax_dt_assessment_recording_date_cnt := COUNT(GROUP,h.tax_dt_assessment_recording_date <> (TYPEOF(h.tax_dt_assessment_recording_date))'');
    populated_tax_dt_assessment_recording_date_pcnt := AVE(GROUP,IF(h.tax_dt_assessment_recording_date = (TYPEOF(h.tax_dt_assessment_recording_date))'',0,100));
    maxlength_tax_dt_assessment_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_assessment_recording_date)));
    avelength_tax_dt_assessment_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tax_dt_assessment_recording_date)),h.tax_dt_assessment_recording_date<>(typeof(h.tax_dt_assessment_recording_date))'');
    populated_deed_document_number_cnt := COUNT(GROUP,h.deed_document_number <> (TYPEOF(h.deed_document_number))'');
    populated_deed_document_number_pcnt := AVE(GROUP,IF(h.deed_document_number = (TYPEOF(h.deed_document_number))'',0,100));
    maxlength_deed_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_document_number)));
    avelength_deed_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_document_number)),h.deed_document_number<>(typeof(h.deed_document_number))'');
    populated_src_deed_document_number_cnt := COUNT(GROUP,h.src_deed_document_number <> (TYPEOF(h.src_deed_document_number))'');
    populated_src_deed_document_number_pcnt := AVE(GROUP,IF(h.src_deed_document_number = (TYPEOF(h.src_deed_document_number))'',0,100));
    maxlength_src_deed_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_deed_document_number)));
    avelength_src_deed_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_deed_document_number)),h.src_deed_document_number<>(typeof(h.src_deed_document_number))'');
    populated_rec_dt_deed_document_number_cnt := COUNT(GROUP,h.rec_dt_deed_document_number <> (TYPEOF(h.rec_dt_deed_document_number))'');
    populated_rec_dt_deed_document_number_pcnt := AVE(GROUP,IF(h.rec_dt_deed_document_number = (TYPEOF(h.rec_dt_deed_document_number))'',0,100));
    maxlength_rec_dt_deed_document_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_deed_document_number)));
    avelength_rec_dt_deed_document_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_deed_document_number)),h.rec_dt_deed_document_number<>(typeof(h.rec_dt_deed_document_number))'');
    populated_deed_recording_date_cnt := COUNT(GROUP,h.deed_recording_date <> (TYPEOF(h.deed_recording_date))'');
    populated_deed_recording_date_pcnt := AVE(GROUP,IF(h.deed_recording_date = (TYPEOF(h.deed_recording_date))'',0,100));
    maxlength_deed_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_recording_date)));
    avelength_deed_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deed_recording_date)),h.deed_recording_date<>(typeof(h.deed_recording_date))'');
    populated_src_deed_recording_date_cnt := COUNT(GROUP,h.src_deed_recording_date <> (TYPEOF(h.src_deed_recording_date))'');
    populated_src_deed_recording_date_pcnt := AVE(GROUP,IF(h.src_deed_recording_date = (TYPEOF(h.src_deed_recording_date))'',0,100));
    maxlength_src_deed_recording_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_deed_recording_date)));
    avelength_src_deed_recording_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_deed_recording_date)),h.src_deed_recording_date<>(typeof(h.src_deed_recording_date))'');
    populated_full_part_sale_cnt := COUNT(GROUP,h.full_part_sale <> (TYPEOF(h.full_part_sale))'');
    populated_full_part_sale_pcnt := AVE(GROUP,IF(h.full_part_sale = (TYPEOF(h.full_part_sale))'',0,100));
    maxlength_full_part_sale := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_part_sale)));
    avelength_full_part_sale := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.full_part_sale)),h.full_part_sale<>(typeof(h.full_part_sale))'');
    populated_src_full_part_sale_cnt := COUNT(GROUP,h.src_full_part_sale <> (TYPEOF(h.src_full_part_sale))'');
    populated_src_full_part_sale_pcnt := AVE(GROUP,IF(h.src_full_part_sale = (TYPEOF(h.src_full_part_sale))'',0,100));
    maxlength_src_full_part_sale := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_full_part_sale)));
    avelength_src_full_part_sale := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_full_part_sale)),h.src_full_part_sale<>(typeof(h.src_full_part_sale))'');
    populated_rec_dt_full_part_sale_cnt := COUNT(GROUP,h.rec_dt_full_part_sale <> (TYPEOF(h.rec_dt_full_part_sale))'');
    populated_rec_dt_full_part_sale_pcnt := AVE(GROUP,IF(h.rec_dt_full_part_sale = (TYPEOF(h.rec_dt_full_part_sale))'',0,100));
    maxlength_rec_dt_full_part_sale := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_full_part_sale)));
    avelength_rec_dt_full_part_sale := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_full_part_sale)),h.rec_dt_full_part_sale<>(typeof(h.rec_dt_full_part_sale))'');
    populated_sale_amount_cnt := COUNT(GROUP,h.sale_amount <> (TYPEOF(h.sale_amount))'');
    populated_sale_amount_pcnt := AVE(GROUP,IF(h.sale_amount = (TYPEOF(h.sale_amount))'',0,100));
    maxlength_sale_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sale_amount)));
    avelength_sale_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sale_amount)),h.sale_amount<>(typeof(h.sale_amount))'');
    populated_src_sale_amount_cnt := COUNT(GROUP,h.src_sale_amount <> (TYPEOF(h.src_sale_amount))'');
    populated_src_sale_amount_pcnt := AVE(GROUP,IF(h.src_sale_amount = (TYPEOF(h.src_sale_amount))'',0,100));
    maxlength_src_sale_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_sale_amount)));
    avelength_src_sale_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_sale_amount)),h.src_sale_amount<>(typeof(h.src_sale_amount))'');
    populated_rec_dt_sale_amount_cnt := COUNT(GROUP,h.rec_dt_sale_amount <> (TYPEOF(h.rec_dt_sale_amount))'');
    populated_rec_dt_sale_amount_pcnt := AVE(GROUP,IF(h.rec_dt_sale_amount = (TYPEOF(h.rec_dt_sale_amount))'',0,100));
    maxlength_rec_dt_sale_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_sale_amount)));
    avelength_rec_dt_sale_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_sale_amount)),h.rec_dt_sale_amount<>(typeof(h.rec_dt_sale_amount))'');
    populated_sale_date_cnt := COUNT(GROUP,h.sale_date <> (TYPEOF(h.sale_date))'');
    populated_sale_date_pcnt := AVE(GROUP,IF(h.sale_date = (TYPEOF(h.sale_date))'',0,100));
    maxlength_sale_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sale_date)));
    avelength_sale_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sale_date)),h.sale_date<>(typeof(h.sale_date))'');
    populated_src_sale_date_cnt := COUNT(GROUP,h.src_sale_date <> (TYPEOF(h.src_sale_date))'');
    populated_src_sale_date_pcnt := AVE(GROUP,IF(h.src_sale_date = (TYPEOF(h.src_sale_date))'',0,100));
    maxlength_src_sale_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_sale_date)));
    avelength_src_sale_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_sale_date)),h.src_sale_date<>(typeof(h.src_sale_date))'');
    populated_rec_dt_sale_date_cnt := COUNT(GROUP,h.rec_dt_sale_date <> (TYPEOF(h.rec_dt_sale_date))'');
    populated_rec_dt_sale_date_pcnt := AVE(GROUP,IF(h.rec_dt_sale_date = (TYPEOF(h.rec_dt_sale_date))'',0,100));
    maxlength_rec_dt_sale_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_sale_date)));
    avelength_rec_dt_sale_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_sale_date)),h.rec_dt_sale_date<>(typeof(h.rec_dt_sale_date))'');
    populated_sale_type_code_cnt := COUNT(GROUP,h.sale_type_code <> (TYPEOF(h.sale_type_code))'');
    populated_sale_type_code_pcnt := AVE(GROUP,IF(h.sale_type_code = (TYPEOF(h.sale_type_code))'',0,100));
    maxlength_sale_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sale_type_code)));
    avelength_sale_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sale_type_code)),h.sale_type_code<>(typeof(h.sale_type_code))'');
    populated_src_sale_type_code_cnt := COUNT(GROUP,h.src_sale_type_code <> (TYPEOF(h.src_sale_type_code))'');
    populated_src_sale_type_code_pcnt := AVE(GROUP,IF(h.src_sale_type_code = (TYPEOF(h.src_sale_type_code))'',0,100));
    maxlength_src_sale_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_sale_type_code)));
    avelength_src_sale_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_sale_type_code)),h.src_sale_type_code<>(typeof(h.src_sale_type_code))'');
    populated_rec_dt_sale_type_code_cnt := COUNT(GROUP,h.rec_dt_sale_type_code <> (TYPEOF(h.rec_dt_sale_type_code))'');
    populated_rec_dt_sale_type_code_pcnt := AVE(GROUP,IF(h.rec_dt_sale_type_code = (TYPEOF(h.rec_dt_sale_type_code))'',0,100));
    maxlength_rec_dt_sale_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_sale_type_code)));
    avelength_rec_dt_sale_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_sale_type_code)),h.rec_dt_sale_type_code<>(typeof(h.rec_dt_sale_type_code))'');
    populated_mortgage_company_name_cnt := COUNT(GROUP,h.mortgage_company_name <> (TYPEOF(h.mortgage_company_name))'');
    populated_mortgage_company_name_pcnt := AVE(GROUP,IF(h.mortgage_company_name = (TYPEOF(h.mortgage_company_name))'',0,100));
    maxlength_mortgage_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_company_name)));
    avelength_mortgage_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mortgage_company_name)),h.mortgage_company_name<>(typeof(h.mortgage_company_name))'');
    populated_src_mortgage_company_name_cnt := COUNT(GROUP,h.src_mortgage_company_name <> (TYPEOF(h.src_mortgage_company_name))'');
    populated_src_mortgage_company_name_pcnt := AVE(GROUP,IF(h.src_mortgage_company_name = (TYPEOF(h.src_mortgage_company_name))'',0,100));
    maxlength_src_mortgage_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_mortgage_company_name)));
    avelength_src_mortgage_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_mortgage_company_name)),h.src_mortgage_company_name<>(typeof(h.src_mortgage_company_name))'');
    populated_rec_dt_mortgage_company_name_cnt := COUNT(GROUP,h.rec_dt_mortgage_company_name <> (TYPEOF(h.rec_dt_mortgage_company_name))'');
    populated_rec_dt_mortgage_company_name_pcnt := AVE(GROUP,IF(h.rec_dt_mortgage_company_name = (TYPEOF(h.rec_dt_mortgage_company_name))'',0,100));
    maxlength_rec_dt_mortgage_company_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_mortgage_company_name)));
    avelength_rec_dt_mortgage_company_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_mortgage_company_name)),h.rec_dt_mortgage_company_name<>(typeof(h.rec_dt_mortgage_company_name))'');
    populated_loan_amount_cnt := COUNT(GROUP,h.loan_amount <> (TYPEOF(h.loan_amount))'');
    populated_loan_amount_pcnt := AVE(GROUP,IF(h.loan_amount = (TYPEOF(h.loan_amount))'',0,100));
    maxlength_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_amount)));
    avelength_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_amount)),h.loan_amount<>(typeof(h.loan_amount))'');
    populated_src_loan_amount_cnt := COUNT(GROUP,h.src_loan_amount <> (TYPEOF(h.src_loan_amount))'');
    populated_src_loan_amount_pcnt := AVE(GROUP,IF(h.src_loan_amount = (TYPEOF(h.src_loan_amount))'',0,100));
    maxlength_src_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_loan_amount)));
    avelength_src_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_loan_amount)),h.src_loan_amount<>(typeof(h.src_loan_amount))'');
    populated_rec_dt_loan_amount_cnt := COUNT(GROUP,h.rec_dt_loan_amount <> (TYPEOF(h.rec_dt_loan_amount))'');
    populated_rec_dt_loan_amount_pcnt := AVE(GROUP,IF(h.rec_dt_loan_amount = (TYPEOF(h.rec_dt_loan_amount))'',0,100));
    maxlength_rec_dt_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_loan_amount)));
    avelength_rec_dt_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_loan_amount)),h.rec_dt_loan_amount<>(typeof(h.rec_dt_loan_amount))'');
    populated_second_loan_amount_cnt := COUNT(GROUP,h.second_loan_amount <> (TYPEOF(h.second_loan_amount))'');
    populated_second_loan_amount_pcnt := AVE(GROUP,IF(h.second_loan_amount = (TYPEOF(h.second_loan_amount))'',0,100));
    maxlength_second_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_loan_amount)));
    avelength_second_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.second_loan_amount)),h.second_loan_amount<>(typeof(h.second_loan_amount))'');
    populated_src_second_loan_amount_cnt := COUNT(GROUP,h.src_second_loan_amount <> (TYPEOF(h.src_second_loan_amount))'');
    populated_src_second_loan_amount_pcnt := AVE(GROUP,IF(h.src_second_loan_amount = (TYPEOF(h.src_second_loan_amount))'',0,100));
    maxlength_src_second_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_second_loan_amount)));
    avelength_src_second_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_second_loan_amount)),h.src_second_loan_amount<>(typeof(h.src_second_loan_amount))'');
    populated_rec_dt_second_loan_amount_cnt := COUNT(GROUP,h.rec_dt_second_loan_amount <> (TYPEOF(h.rec_dt_second_loan_amount))'');
    populated_rec_dt_second_loan_amount_pcnt := AVE(GROUP,IF(h.rec_dt_second_loan_amount = (TYPEOF(h.rec_dt_second_loan_amount))'',0,100));
    maxlength_rec_dt_second_loan_amount := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_second_loan_amount)));
    avelength_rec_dt_second_loan_amount := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_second_loan_amount)),h.rec_dt_second_loan_amount<>(typeof(h.rec_dt_second_loan_amount))'');
    populated_loan_type_code_cnt := COUNT(GROUP,h.loan_type_code <> (TYPEOF(h.loan_type_code))'');
    populated_loan_type_code_pcnt := AVE(GROUP,IF(h.loan_type_code = (TYPEOF(h.loan_type_code))'',0,100));
    maxlength_loan_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_type_code)));
    avelength_loan_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.loan_type_code)),h.loan_type_code<>(typeof(h.loan_type_code))'');
    populated_src_loan_type_code_cnt := COUNT(GROUP,h.src_loan_type_code <> (TYPEOF(h.src_loan_type_code))'');
    populated_src_loan_type_code_pcnt := AVE(GROUP,IF(h.src_loan_type_code = (TYPEOF(h.src_loan_type_code))'',0,100));
    maxlength_src_loan_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_loan_type_code)));
    avelength_src_loan_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_loan_type_code)),h.src_loan_type_code<>(typeof(h.src_loan_type_code))'');
    populated_rec_dt_loan_type_code_cnt := COUNT(GROUP,h.rec_dt_loan_type_code <> (TYPEOF(h.rec_dt_loan_type_code))'');
    populated_rec_dt_loan_type_code_pcnt := AVE(GROUP,IF(h.rec_dt_loan_type_code = (TYPEOF(h.rec_dt_loan_type_code))'',0,100));
    maxlength_rec_dt_loan_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_loan_type_code)));
    avelength_rec_dt_loan_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_loan_type_code)),h.rec_dt_loan_type_code<>(typeof(h.rec_dt_loan_type_code))'');
    populated_interest_rate_type_code_cnt := COUNT(GROUP,h.interest_rate_type_code <> (TYPEOF(h.interest_rate_type_code))'');
    populated_interest_rate_type_code_pcnt := AVE(GROUP,IF(h.interest_rate_type_code = (TYPEOF(h.interest_rate_type_code))'',0,100));
    maxlength_interest_rate_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.interest_rate_type_code)));
    avelength_interest_rate_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.interest_rate_type_code)),h.interest_rate_type_code<>(typeof(h.interest_rate_type_code))'');
    populated_src_interest_rate_type_code_cnt := COUNT(GROUP,h.src_interest_rate_type_code <> (TYPEOF(h.src_interest_rate_type_code))'');
    populated_src_interest_rate_type_code_pcnt := AVE(GROUP,IF(h.src_interest_rate_type_code = (TYPEOF(h.src_interest_rate_type_code))'',0,100));
    maxlength_src_interest_rate_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_interest_rate_type_code)));
    avelength_src_interest_rate_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_interest_rate_type_code)),h.src_interest_rate_type_code<>(typeof(h.src_interest_rate_type_code))'');
    populated_rec_dt_interest_rate_type_code_cnt := COUNT(GROUP,h.rec_dt_interest_rate_type_code <> (TYPEOF(h.rec_dt_interest_rate_type_code))'');
    populated_rec_dt_interest_rate_type_code_pcnt := AVE(GROUP,IF(h.rec_dt_interest_rate_type_code = (TYPEOF(h.rec_dt_interest_rate_type_code))'',0,100));
    maxlength_rec_dt_interest_rate_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_interest_rate_type_code)));
    avelength_rec_dt_interest_rate_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_dt_interest_rate_type_code)),h.rec_dt_interest_rate_type_code<>(typeof(h.rec_dt_interest_rate_type_code))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,vendor_source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_property_rid_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_tax_sortby_date_pcnt *   0.00 / 100 + T.Populated_deed_sortby_date_pcnt *   0.00 / 100 + T.Populated_vendor_source_pcnt *   0.00 / 100 + T.Populated_fares_unformatted_apn_pcnt *   0.00 / 100 + T.Populated_property_street_address_pcnt *   0.00 / 100 + T.Populated_property_city_state_zip_pcnt *   0.00 / 100 + T.Populated_property_raw_aid_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_building_square_footage_pcnt *   0.00 / 100 + T.Populated_src_building_square_footage_pcnt *   0.00 / 100 + T.Populated_tax_dt_building_square_footage_pcnt *   0.00 / 100 + T.Populated_air_conditioning_type_pcnt *   0.00 / 100 + T.Populated_src_air_conditioning_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_air_conditioning_type_pcnt *   0.00 / 100 + T.Populated_basement_finish_pcnt *   0.00 / 100 + T.Populated_src_basement_finish_pcnt *   0.00 / 100 + T.Populated_tax_dt_basement_finish_pcnt *   0.00 / 100 + T.Populated_construction_type_pcnt *   0.00 / 100 + T.Populated_src_construction_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_construction_type_pcnt *   0.00 / 100 + T.Populated_exterior_wall_pcnt *   0.00 / 100 + T.Populated_src_exterior_wall_pcnt *   0.00 / 100 + T.Populated_tax_dt_exterior_wall_pcnt *   0.00 / 100 + T.Populated_fireplace_ind_pcnt *   0.00 / 100 + T.Populated_src_fireplace_ind_pcnt *   0.00 / 100 + T.Populated_tax_dt_fireplace_ind_pcnt *   0.00 / 100 + T.Populated_fireplace_type_pcnt *   0.00 / 100 + T.Populated_src_fireplace_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_fireplace_type_pcnt *   0.00 / 100 + T.Populated_flood_zone_panel_pcnt *   0.00 / 100 + T.Populated_src_flood_zone_panel_pcnt *   0.00 / 100 + T.Populated_tax_dt_flood_zone_panel_pcnt *   0.00 / 100 + T.Populated_garage_pcnt *   0.00 / 100 + T.Populated_src_garage_pcnt *   0.00 / 100 + T.Populated_tax_dt_garage_pcnt *   0.00 / 100 + T.Populated_first_floor_square_footage_pcnt *   0.00 / 100 + T.Populated_src_first_floor_square_footage_pcnt *   0.00 / 100 + T.Populated_tax_dt_first_floor_square_footage_pcnt *   0.00 / 100 + T.Populated_heating_pcnt *   0.00 / 100 + T.Populated_src_heating_pcnt *   0.00 / 100 + T.Populated_tax_dt_heating_pcnt *   0.00 / 100 + T.Populated_living_area_square_footage_pcnt *   0.00 / 100 + T.Populated_src_living_area_square_footage_pcnt *   0.00 / 100 + T.Populated_tax_dt_living_area_square_footage_pcnt *   0.00 / 100 + T.Populated_no_of_baths_pcnt *   0.00 / 100 + T.Populated_src_no_of_baths_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_baths_pcnt *   0.00 / 100 + T.Populated_no_of_bedrooms_pcnt *   0.00 / 100 + T.Populated_src_no_of_bedrooms_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_bedrooms_pcnt *   0.00 / 100 + T.Populated_no_of_fireplaces_pcnt *   0.00 / 100 + T.Populated_src_no_of_fireplaces_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_fireplaces_pcnt *   0.00 / 100 + T.Populated_no_of_full_baths_pcnt *   0.00 / 100 + T.Populated_src_no_of_full_baths_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_full_baths_pcnt *   0.00 / 100 + T.Populated_no_of_half_baths_pcnt *   0.00 / 100 + T.Populated_src_no_of_half_baths_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_half_baths_pcnt *   0.00 / 100 + T.Populated_no_of_stories_pcnt *   0.00 / 100 + T.Populated_src_no_of_stories_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_stories_pcnt *   0.00 / 100 + T.Populated_parking_type_pcnt *   0.00 / 100 + T.Populated_src_parking_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_parking_type_pcnt *   0.00 / 100 + T.Populated_pool_indicator_pcnt *   0.00 / 100 + T.Populated_src_pool_indicator_pcnt *   0.00 / 100 + T.Populated_tax_dt_pool_indicator_pcnt *   0.00 / 100 + T.Populated_pool_type_pcnt *   0.00 / 100 + T.Populated_src_pool_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_pool_type_pcnt *   0.00 / 100 + T.Populated_roof_cover_pcnt *   0.00 / 100 + T.Populated_src_roof_cover_pcnt *   0.00 / 100 + T.Populated_tax_dt_roof_cover_pcnt *   0.00 / 100 + T.Populated_year_built_pcnt *   0.00 / 100 + T.Populated_src_year_built_pcnt *   0.00 / 100 + T.Populated_tax_dt_year_built_pcnt *   0.00 / 100 + T.Populated_foundation_pcnt *   0.00 / 100 + T.Populated_src_foundation_pcnt *   0.00 / 100 + T.Populated_tax_dt_foundation_pcnt *   0.00 / 100 + T.Populated_basement_square_footage_pcnt *   0.00 / 100 + T.Populated_src_basement_square_footage_pcnt *   0.00 / 100 + T.Populated_tax_dt_basement_square_footage_pcnt *   0.00 / 100 + T.Populated_effective_year_built_pcnt *   0.00 / 100 + T.Populated_src_effective_year_built_pcnt *   0.00 / 100 + T.Populated_tax_dt_effective_year_built_pcnt *   0.00 / 100 + T.Populated_garage_square_footage_pcnt *   0.00 / 100 + T.Populated_src_garage_square_footage_pcnt *   0.00 / 100 + T.Populated_tax_dt_garage_square_footage_pcnt *   0.00 / 100 + T.Populated_stories_type_pcnt *   0.00 / 100 + T.Populated_src_stories_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_stories_type_pcnt *   0.00 / 100 + T.Populated_apn_number_pcnt *   0.00 / 100 + T.Populated_src_apn_number_pcnt *   0.00 / 100 + T.Populated_tax_dt_apn_number_pcnt *   0.00 / 100 + T.Populated_census_tract_pcnt *   0.00 / 100 + T.Populated_src_census_tract_pcnt *   0.00 / 100 + T.Populated_tax_dt_census_tract_pcnt *   0.00 / 100 + T.Populated_range_pcnt *   0.00 / 100 + T.Populated_src_range_pcnt *   0.00 / 100 + T.Populated_tax_dt_range_pcnt *   0.00 / 100 + T.Populated_zoning_pcnt *   0.00 / 100 + T.Populated_src_zoning_pcnt *   0.00 / 100 + T.Populated_tax_dt_zoning_pcnt *   0.00 / 100 + T.Populated_block_number_pcnt *   0.00 / 100 + T.Populated_src_block_number_pcnt *   0.00 / 100 + T.Populated_tax_dt_block_number_pcnt *   0.00 / 100 + T.Populated_county_name_pcnt *   0.00 / 100 + T.Populated_src_county_name_pcnt *   0.00 / 100 + T.Populated_tax_dt_county_name_pcnt *   0.00 / 100 + T.Populated_fips_code_pcnt *   0.00 / 100 + T.Populated_src_fips_code_pcnt *   0.00 / 100 + T.Populated_tax_dt_fips_code_pcnt *   0.00 / 100 + T.Populated_subdivision_pcnt *   0.00 / 100 + T.Populated_src_subdivision_pcnt *   0.00 / 100 + T.Populated_tax_dt_subdivision_pcnt *   0.00 / 100 + T.Populated_municipality_pcnt *   0.00 / 100 + T.Populated_src_municipality_pcnt *   0.00 / 100 + T.Populated_tax_dt_municipality_pcnt *   0.00 / 100 + T.Populated_township_pcnt *   0.00 / 100 + T.Populated_src_township_pcnt *   0.00 / 100 + T.Populated_tax_dt_township_pcnt *   0.00 / 100 + T.Populated_homestead_exemption_ind_pcnt *   0.00 / 100 + T.Populated_src_homestead_exemption_ind_pcnt *   0.00 / 100 + T.Populated_tax_dt_homestead_exemption_ind_pcnt *   0.00 / 100 + T.Populated_land_use_code_pcnt *   0.00 / 100 + T.Populated_src_land_use_code_pcnt *   0.00 / 100 + T.Populated_tax_dt_land_use_code_pcnt *   0.00 / 100 + T.Populated_latitude_pcnt *   0.00 / 100 + T.Populated_src_latitude_pcnt *   0.00 / 100 + T.Populated_tax_dt_latitude_pcnt *   0.00 / 100 + T.Populated_longitude_pcnt *   0.00 / 100 + T.Populated_src_longitude_pcnt *   0.00 / 100 + T.Populated_tax_dt_longitude_pcnt *   0.00 / 100 + T.Populated_location_influence_code_pcnt *   0.00 / 100 + T.Populated_src_location_influence_code_pcnt *   0.00 / 100 + T.Populated_tax_dt_location_influence_code_pcnt *   0.00 / 100 + T.Populated_acres_pcnt *   0.00 / 100 + T.Populated_src_acres_pcnt *   0.00 / 100 + T.Populated_tax_dt_acres_pcnt *   0.00 / 100 + T.Populated_lot_depth_footage_pcnt *   0.00 / 100 + T.Populated_src_lot_depth_footage_pcnt *   0.00 / 100 + T.Populated_tax_dt_lot_depth_footage_pcnt *   0.00 / 100 + T.Populated_lot_front_footage_pcnt *   0.00 / 100 + T.Populated_src_lot_front_footage_pcnt *   0.00 / 100 + T.Populated_tax_dt_lot_front_footage_pcnt *   0.00 / 100 + T.Populated_lot_number_pcnt *   0.00 / 100 + T.Populated_src_lot_number_pcnt *   0.00 / 100 + T.Populated_tax_dt_lot_number_pcnt *   0.00 / 100 + T.Populated_lot_size_pcnt *   0.00 / 100 + T.Populated_src_lot_size_pcnt *   0.00 / 100 + T.Populated_tax_dt_lot_size_pcnt *   0.00 / 100 + T.Populated_property_type_code_pcnt *   0.00 / 100 + T.Populated_src_property_type_code_pcnt *   0.00 / 100 + T.Populated_tax_dt_property_type_code_pcnt *   0.00 / 100 + T.Populated_structure_quality_pcnt *   0.00 / 100 + T.Populated_src_structure_quality_pcnt *   0.00 / 100 + T.Populated_tax_dt_structure_quality_pcnt *   0.00 / 100 + T.Populated_water_pcnt *   0.00 / 100 + T.Populated_src_water_pcnt *   0.00 / 100 + T.Populated_tax_dt_water_pcnt *   0.00 / 100 + T.Populated_sewer_pcnt *   0.00 / 100 + T.Populated_src_sewer_pcnt *   0.00 / 100 + T.Populated_tax_dt_sewer_pcnt *   0.00 / 100 + T.Populated_assessed_land_value_pcnt *   0.00 / 100 + T.Populated_src_assessed_land_value_pcnt *   0.00 / 100 + T.Populated_tax_dt_assessed_land_value_pcnt *   0.00 / 100 + T.Populated_assessed_year_pcnt *   0.00 / 100 + T.Populated_src_assessed_year_pcnt *   0.00 / 100 + T.Populated_tax_dt_assessed_year_pcnt *   0.00 / 100 + T.Populated_tax_amount_pcnt *   0.00 / 100 + T.Populated_src_tax_amount_pcnt *   0.00 / 100 + T.Populated_tax_dt_tax_amount_pcnt *   0.00 / 100 + T.Populated_tax_year_pcnt *   0.00 / 100 + T.Populated_src_tax_year_pcnt *   0.00 / 100 + T.Populated_market_land_value_pcnt *   0.00 / 100 + T.Populated_src_market_land_value_pcnt *   0.00 / 100 + T.Populated_tax_dt_market_land_value_pcnt *   0.00 / 100 + T.Populated_improvement_value_pcnt *   0.00 / 100 + T.Populated_src_improvement_value_pcnt *   0.00 / 100 + T.Populated_tax_dt_improvement_value_pcnt *   0.00 / 100 + T.Populated_percent_improved_pcnt *   0.00 / 100 + T.Populated_src_percent_improved_pcnt *   0.00 / 100 + T.Populated_tax_dt_percent_improved_pcnt *   0.00 / 100 + T.Populated_total_assessed_value_pcnt *   0.00 / 100 + T.Populated_src_total_assessed_value_pcnt *   0.00 / 100 + T.Populated_tax_dt_total_assessed_value_pcnt *   0.00 / 100 + T.Populated_total_calculated_value_pcnt *   0.00 / 100 + T.Populated_src_total_calculated_value_pcnt *   0.00 / 100 + T.Populated_tax_dt_total_calculated_value_pcnt *   0.00 / 100 + T.Populated_total_land_value_pcnt *   0.00 / 100 + T.Populated_src_total_land_value_pcnt *   0.00 / 100 + T.Populated_tax_dt_total_land_value_pcnt *   0.00 / 100 + T.Populated_total_market_value_pcnt *   0.00 / 100 + T.Populated_src_total_market_value_pcnt *   0.00 / 100 + T.Populated_tax_dt_total_market_value_pcnt *   0.00 / 100 + T.Populated_floor_type_pcnt *   0.00 / 100 + T.Populated_src_floor_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_floor_type_pcnt *   0.00 / 100 + T.Populated_frame_type_pcnt *   0.00 / 100 + T.Populated_src_frame_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_frame_type_pcnt *   0.00 / 100 + T.Populated_fuel_type_pcnt *   0.00 / 100 + T.Populated_src_fuel_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_fuel_type_pcnt *   0.00 / 100 + T.Populated_no_of_bath_fixtures_pcnt *   0.00 / 100 + T.Populated_src_no_of_bath_fixtures_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_bath_fixtures_pcnt *   0.00 / 100 + T.Populated_no_of_rooms_pcnt *   0.00 / 100 + T.Populated_src_no_of_rooms_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_rooms_pcnt *   0.00 / 100 + T.Populated_no_of_units_pcnt *   0.00 / 100 + T.Populated_src_no_of_units_pcnt *   0.00 / 100 + T.Populated_tax_dt_no_of_units_pcnt *   0.00 / 100 + T.Populated_style_type_pcnt *   0.00 / 100 + T.Populated_src_style_type_pcnt *   0.00 / 100 + T.Populated_tax_dt_style_type_pcnt *   0.00 / 100 + T.Populated_assessment_document_number_pcnt *   0.00 / 100 + T.Populated_src_assessment_document_number_pcnt *   0.00 / 100 + T.Populated_tax_dt_assessment_document_number_pcnt *   0.00 / 100 + T.Populated_assessment_recording_date_pcnt *   0.00 / 100 + T.Populated_src_assessment_recording_date_pcnt *   0.00 / 100 + T.Populated_tax_dt_assessment_recording_date_pcnt *   0.00 / 100 + T.Populated_deed_document_number_pcnt *   0.00 / 100 + T.Populated_src_deed_document_number_pcnt *   0.00 / 100 + T.Populated_rec_dt_deed_document_number_pcnt *   0.00 / 100 + T.Populated_deed_recording_date_pcnt *   0.00 / 100 + T.Populated_src_deed_recording_date_pcnt *   0.00 / 100 + T.Populated_full_part_sale_pcnt *   0.00 / 100 + T.Populated_src_full_part_sale_pcnt *   0.00 / 100 + T.Populated_rec_dt_full_part_sale_pcnt *   0.00 / 100 + T.Populated_sale_amount_pcnt *   0.00 / 100 + T.Populated_src_sale_amount_pcnt *   0.00 / 100 + T.Populated_rec_dt_sale_amount_pcnt *   0.00 / 100 + T.Populated_sale_date_pcnt *   0.00 / 100 + T.Populated_src_sale_date_pcnt *   0.00 / 100 + T.Populated_rec_dt_sale_date_pcnt *   0.00 / 100 + T.Populated_sale_type_code_pcnt *   0.00 / 100 + T.Populated_src_sale_type_code_pcnt *   0.00 / 100 + T.Populated_rec_dt_sale_type_code_pcnt *   0.00 / 100 + T.Populated_mortgage_company_name_pcnt *   0.00 / 100 + T.Populated_src_mortgage_company_name_pcnt *   0.00 / 100 + T.Populated_rec_dt_mortgage_company_name_pcnt *   0.00 / 100 + T.Populated_loan_amount_pcnt *   0.00 / 100 + T.Populated_src_loan_amount_pcnt *   0.00 / 100 + T.Populated_rec_dt_loan_amount_pcnt *   0.00 / 100 + T.Populated_second_loan_amount_pcnt *   0.00 / 100 + T.Populated_src_second_loan_amount_pcnt *   0.00 / 100 + T.Populated_rec_dt_second_loan_amount_pcnt *   0.00 / 100 + T.Populated_loan_type_code_pcnt *   0.00 / 100 + T.Populated_src_loan_type_code_pcnt *   0.00 / 100 + T.Populated_rec_dt_loan_type_code_pcnt *   0.00 / 100 + T.Populated_interest_rate_type_code_pcnt *   0.00 / 100 + T.Populated_src_interest_rate_type_code_pcnt *   0.00 / 100 + T.Populated_rec_dt_interest_rate_type_code_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING vendor_source1;
    STRING vendor_source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.vendor_source1 := le.Source;
    SELF.vendor_source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_property_rid_pcnt*ri.Populated_property_rid_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_first_reported_pcnt*ri.Populated_dt_vendor_first_reported_pcnt *   0.00 / 10000 + le.Populated_dt_vendor_last_reported_pcnt*ri.Populated_dt_vendor_last_reported_pcnt *   0.00 / 10000 + le.Populated_tax_sortby_date_pcnt*ri.Populated_tax_sortby_date_pcnt *   0.00 / 10000 + le.Populated_deed_sortby_date_pcnt*ri.Populated_deed_sortby_date_pcnt *   0.00 / 10000 + le.Populated_vendor_source_pcnt*ri.Populated_vendor_source_pcnt *   0.00 / 10000 + le.Populated_fares_unformatted_apn_pcnt*ri.Populated_fares_unformatted_apn_pcnt *   0.00 / 10000 + le.Populated_property_street_address_pcnt*ri.Populated_property_street_address_pcnt *   0.00 / 10000 + le.Populated_property_city_state_zip_pcnt*ri.Populated_property_city_state_zip_pcnt *   0.00 / 10000 + le.Populated_property_raw_aid_pcnt*ri.Populated_property_raw_aid_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_st_pcnt*ri.Populated_st_pcnt *   0.00 / 10000 + le.Populated_zip_pcnt*ri.Populated_zip_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dbpc_pcnt*ri.Populated_dbpc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_county_pcnt*ri.Populated_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_building_square_footage_pcnt*ri.Populated_building_square_footage_pcnt *   0.00 / 10000 + le.Populated_src_building_square_footage_pcnt*ri.Populated_src_building_square_footage_pcnt *   0.00 / 10000 + le.Populated_tax_dt_building_square_footage_pcnt*ri.Populated_tax_dt_building_square_footage_pcnt *   0.00 / 10000 + le.Populated_air_conditioning_type_pcnt*ri.Populated_air_conditioning_type_pcnt *   0.00 / 10000 + le.Populated_src_air_conditioning_type_pcnt*ri.Populated_src_air_conditioning_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_air_conditioning_type_pcnt*ri.Populated_tax_dt_air_conditioning_type_pcnt *   0.00 / 10000 + le.Populated_basement_finish_pcnt*ri.Populated_basement_finish_pcnt *   0.00 / 10000 + le.Populated_src_basement_finish_pcnt*ri.Populated_src_basement_finish_pcnt *   0.00 / 10000 + le.Populated_tax_dt_basement_finish_pcnt*ri.Populated_tax_dt_basement_finish_pcnt *   0.00 / 10000 + le.Populated_construction_type_pcnt*ri.Populated_construction_type_pcnt *   0.00 / 10000 + le.Populated_src_construction_type_pcnt*ri.Populated_src_construction_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_construction_type_pcnt*ri.Populated_tax_dt_construction_type_pcnt *   0.00 / 10000 + le.Populated_exterior_wall_pcnt*ri.Populated_exterior_wall_pcnt *   0.00 / 10000 + le.Populated_src_exterior_wall_pcnt*ri.Populated_src_exterior_wall_pcnt *   0.00 / 10000 + le.Populated_tax_dt_exterior_wall_pcnt*ri.Populated_tax_dt_exterior_wall_pcnt *   0.00 / 10000 + le.Populated_fireplace_ind_pcnt*ri.Populated_fireplace_ind_pcnt *   0.00 / 10000 + le.Populated_src_fireplace_ind_pcnt*ri.Populated_src_fireplace_ind_pcnt *   0.00 / 10000 + le.Populated_tax_dt_fireplace_ind_pcnt*ri.Populated_tax_dt_fireplace_ind_pcnt *   0.00 / 10000 + le.Populated_fireplace_type_pcnt*ri.Populated_fireplace_type_pcnt *   0.00 / 10000 + le.Populated_src_fireplace_type_pcnt*ri.Populated_src_fireplace_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_fireplace_type_pcnt*ri.Populated_tax_dt_fireplace_type_pcnt *   0.00 / 10000 + le.Populated_flood_zone_panel_pcnt*ri.Populated_flood_zone_panel_pcnt *   0.00 / 10000 + le.Populated_src_flood_zone_panel_pcnt*ri.Populated_src_flood_zone_panel_pcnt *   0.00 / 10000 + le.Populated_tax_dt_flood_zone_panel_pcnt*ri.Populated_tax_dt_flood_zone_panel_pcnt *   0.00 / 10000 + le.Populated_garage_pcnt*ri.Populated_garage_pcnt *   0.00 / 10000 + le.Populated_src_garage_pcnt*ri.Populated_src_garage_pcnt *   0.00 / 10000 + le.Populated_tax_dt_garage_pcnt*ri.Populated_tax_dt_garage_pcnt *   0.00 / 10000 + le.Populated_first_floor_square_footage_pcnt*ri.Populated_first_floor_square_footage_pcnt *   0.00 / 10000 + le.Populated_src_first_floor_square_footage_pcnt*ri.Populated_src_first_floor_square_footage_pcnt *   0.00 / 10000 + le.Populated_tax_dt_first_floor_square_footage_pcnt*ri.Populated_tax_dt_first_floor_square_footage_pcnt *   0.00 / 10000 + le.Populated_heating_pcnt*ri.Populated_heating_pcnt *   0.00 / 10000 + le.Populated_src_heating_pcnt*ri.Populated_src_heating_pcnt *   0.00 / 10000 + le.Populated_tax_dt_heating_pcnt*ri.Populated_tax_dt_heating_pcnt *   0.00 / 10000 + le.Populated_living_area_square_footage_pcnt*ri.Populated_living_area_square_footage_pcnt *   0.00 / 10000 + le.Populated_src_living_area_square_footage_pcnt*ri.Populated_src_living_area_square_footage_pcnt *   0.00 / 10000 + le.Populated_tax_dt_living_area_square_footage_pcnt*ri.Populated_tax_dt_living_area_square_footage_pcnt *   0.00 / 10000 + le.Populated_no_of_baths_pcnt*ri.Populated_no_of_baths_pcnt *   0.00 / 10000 + le.Populated_src_no_of_baths_pcnt*ri.Populated_src_no_of_baths_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_baths_pcnt*ri.Populated_tax_dt_no_of_baths_pcnt *   0.00 / 10000 + le.Populated_no_of_bedrooms_pcnt*ri.Populated_no_of_bedrooms_pcnt *   0.00 / 10000 + le.Populated_src_no_of_bedrooms_pcnt*ri.Populated_src_no_of_bedrooms_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_bedrooms_pcnt*ri.Populated_tax_dt_no_of_bedrooms_pcnt *   0.00 / 10000 + le.Populated_no_of_fireplaces_pcnt*ri.Populated_no_of_fireplaces_pcnt *   0.00 / 10000 + le.Populated_src_no_of_fireplaces_pcnt*ri.Populated_src_no_of_fireplaces_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_fireplaces_pcnt*ri.Populated_tax_dt_no_of_fireplaces_pcnt *   0.00 / 10000 + le.Populated_no_of_full_baths_pcnt*ri.Populated_no_of_full_baths_pcnt *   0.00 / 10000 + le.Populated_src_no_of_full_baths_pcnt*ri.Populated_src_no_of_full_baths_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_full_baths_pcnt*ri.Populated_tax_dt_no_of_full_baths_pcnt *   0.00 / 10000 + le.Populated_no_of_half_baths_pcnt*ri.Populated_no_of_half_baths_pcnt *   0.00 / 10000 + le.Populated_src_no_of_half_baths_pcnt*ri.Populated_src_no_of_half_baths_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_half_baths_pcnt*ri.Populated_tax_dt_no_of_half_baths_pcnt *   0.00 / 10000 + le.Populated_no_of_stories_pcnt*ri.Populated_no_of_stories_pcnt *   0.00 / 10000 + le.Populated_src_no_of_stories_pcnt*ri.Populated_src_no_of_stories_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_stories_pcnt*ri.Populated_tax_dt_no_of_stories_pcnt *   0.00 / 10000 + le.Populated_parking_type_pcnt*ri.Populated_parking_type_pcnt *   0.00 / 10000 + le.Populated_src_parking_type_pcnt*ri.Populated_src_parking_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_parking_type_pcnt*ri.Populated_tax_dt_parking_type_pcnt *   0.00 / 10000 + le.Populated_pool_indicator_pcnt*ri.Populated_pool_indicator_pcnt *   0.00 / 10000 + le.Populated_src_pool_indicator_pcnt*ri.Populated_src_pool_indicator_pcnt *   0.00 / 10000 + le.Populated_tax_dt_pool_indicator_pcnt*ri.Populated_tax_dt_pool_indicator_pcnt *   0.00 / 10000 + le.Populated_pool_type_pcnt*ri.Populated_pool_type_pcnt *   0.00 / 10000 + le.Populated_src_pool_type_pcnt*ri.Populated_src_pool_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_pool_type_pcnt*ri.Populated_tax_dt_pool_type_pcnt *   0.00 / 10000 + le.Populated_roof_cover_pcnt*ri.Populated_roof_cover_pcnt *   0.00 / 10000 + le.Populated_src_roof_cover_pcnt*ri.Populated_src_roof_cover_pcnt *   0.00 / 10000 + le.Populated_tax_dt_roof_cover_pcnt*ri.Populated_tax_dt_roof_cover_pcnt *   0.00 / 10000 + le.Populated_year_built_pcnt*ri.Populated_year_built_pcnt *   0.00 / 10000 + le.Populated_src_year_built_pcnt*ri.Populated_src_year_built_pcnt *   0.00 / 10000 + le.Populated_tax_dt_year_built_pcnt*ri.Populated_tax_dt_year_built_pcnt *   0.00 / 10000 + le.Populated_foundation_pcnt*ri.Populated_foundation_pcnt *   0.00 / 10000 + le.Populated_src_foundation_pcnt*ri.Populated_src_foundation_pcnt *   0.00 / 10000 + le.Populated_tax_dt_foundation_pcnt*ri.Populated_tax_dt_foundation_pcnt *   0.00 / 10000 + le.Populated_basement_square_footage_pcnt*ri.Populated_basement_square_footage_pcnt *   0.00 / 10000 + le.Populated_src_basement_square_footage_pcnt*ri.Populated_src_basement_square_footage_pcnt *   0.00 / 10000 + le.Populated_tax_dt_basement_square_footage_pcnt*ri.Populated_tax_dt_basement_square_footage_pcnt *   0.00 / 10000 + le.Populated_effective_year_built_pcnt*ri.Populated_effective_year_built_pcnt *   0.00 / 10000 + le.Populated_src_effective_year_built_pcnt*ri.Populated_src_effective_year_built_pcnt *   0.00 / 10000 + le.Populated_tax_dt_effective_year_built_pcnt*ri.Populated_tax_dt_effective_year_built_pcnt *   0.00 / 10000 + le.Populated_garage_square_footage_pcnt*ri.Populated_garage_square_footage_pcnt *   0.00 / 10000 + le.Populated_src_garage_square_footage_pcnt*ri.Populated_src_garage_square_footage_pcnt *   0.00 / 10000 + le.Populated_tax_dt_garage_square_footage_pcnt*ri.Populated_tax_dt_garage_square_footage_pcnt *   0.00 / 10000 + le.Populated_stories_type_pcnt*ri.Populated_stories_type_pcnt *   0.00 / 10000 + le.Populated_src_stories_type_pcnt*ri.Populated_src_stories_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_stories_type_pcnt*ri.Populated_tax_dt_stories_type_pcnt *   0.00 / 10000 + le.Populated_apn_number_pcnt*ri.Populated_apn_number_pcnt *   0.00 / 10000 + le.Populated_src_apn_number_pcnt*ri.Populated_src_apn_number_pcnt *   0.00 / 10000 + le.Populated_tax_dt_apn_number_pcnt*ri.Populated_tax_dt_apn_number_pcnt *   0.00 / 10000 + le.Populated_census_tract_pcnt*ri.Populated_census_tract_pcnt *   0.00 / 10000 + le.Populated_src_census_tract_pcnt*ri.Populated_src_census_tract_pcnt *   0.00 / 10000 + le.Populated_tax_dt_census_tract_pcnt*ri.Populated_tax_dt_census_tract_pcnt *   0.00 / 10000 + le.Populated_range_pcnt*ri.Populated_range_pcnt *   0.00 / 10000 + le.Populated_src_range_pcnt*ri.Populated_src_range_pcnt *   0.00 / 10000 + le.Populated_tax_dt_range_pcnt*ri.Populated_tax_dt_range_pcnt *   0.00 / 10000 + le.Populated_zoning_pcnt*ri.Populated_zoning_pcnt *   0.00 / 10000 + le.Populated_src_zoning_pcnt*ri.Populated_src_zoning_pcnt *   0.00 / 10000 + le.Populated_tax_dt_zoning_pcnt*ri.Populated_tax_dt_zoning_pcnt *   0.00 / 10000 + le.Populated_block_number_pcnt*ri.Populated_block_number_pcnt *   0.00 / 10000 + le.Populated_src_block_number_pcnt*ri.Populated_src_block_number_pcnt *   0.00 / 10000 + le.Populated_tax_dt_block_number_pcnt*ri.Populated_tax_dt_block_number_pcnt *   0.00 / 10000 + le.Populated_county_name_pcnt*ri.Populated_county_name_pcnt *   0.00 / 10000 + le.Populated_src_county_name_pcnt*ri.Populated_src_county_name_pcnt *   0.00 / 10000 + le.Populated_tax_dt_county_name_pcnt*ri.Populated_tax_dt_county_name_pcnt *   0.00 / 10000 + le.Populated_fips_code_pcnt*ri.Populated_fips_code_pcnt *   0.00 / 10000 + le.Populated_src_fips_code_pcnt*ri.Populated_src_fips_code_pcnt *   0.00 / 10000 + le.Populated_tax_dt_fips_code_pcnt*ri.Populated_tax_dt_fips_code_pcnt *   0.00 / 10000 + le.Populated_subdivision_pcnt*ri.Populated_subdivision_pcnt *   0.00 / 10000 + le.Populated_src_subdivision_pcnt*ri.Populated_src_subdivision_pcnt *   0.00 / 10000 + le.Populated_tax_dt_subdivision_pcnt*ri.Populated_tax_dt_subdivision_pcnt *   0.00 / 10000 + le.Populated_municipality_pcnt*ri.Populated_municipality_pcnt *   0.00 / 10000 + le.Populated_src_municipality_pcnt*ri.Populated_src_municipality_pcnt *   0.00 / 10000 + le.Populated_tax_dt_municipality_pcnt*ri.Populated_tax_dt_municipality_pcnt *   0.00 / 10000 + le.Populated_township_pcnt*ri.Populated_township_pcnt *   0.00 / 10000 + le.Populated_src_township_pcnt*ri.Populated_src_township_pcnt *   0.00 / 10000 + le.Populated_tax_dt_township_pcnt*ri.Populated_tax_dt_township_pcnt *   0.00 / 10000 + le.Populated_homestead_exemption_ind_pcnt*ri.Populated_homestead_exemption_ind_pcnt *   0.00 / 10000 + le.Populated_src_homestead_exemption_ind_pcnt*ri.Populated_src_homestead_exemption_ind_pcnt *   0.00 / 10000 + le.Populated_tax_dt_homestead_exemption_ind_pcnt*ri.Populated_tax_dt_homestead_exemption_ind_pcnt *   0.00 / 10000 + le.Populated_land_use_code_pcnt*ri.Populated_land_use_code_pcnt *   0.00 / 10000 + le.Populated_src_land_use_code_pcnt*ri.Populated_src_land_use_code_pcnt *   0.00 / 10000 + le.Populated_tax_dt_land_use_code_pcnt*ri.Populated_tax_dt_land_use_code_pcnt *   0.00 / 10000 + le.Populated_latitude_pcnt*ri.Populated_latitude_pcnt *   0.00 / 10000 + le.Populated_src_latitude_pcnt*ri.Populated_src_latitude_pcnt *   0.00 / 10000 + le.Populated_tax_dt_latitude_pcnt*ri.Populated_tax_dt_latitude_pcnt *   0.00 / 10000 + le.Populated_longitude_pcnt*ri.Populated_longitude_pcnt *   0.00 / 10000 + le.Populated_src_longitude_pcnt*ri.Populated_src_longitude_pcnt *   0.00 / 10000 + le.Populated_tax_dt_longitude_pcnt*ri.Populated_tax_dt_longitude_pcnt *   0.00 / 10000 + le.Populated_location_influence_code_pcnt*ri.Populated_location_influence_code_pcnt *   0.00 / 10000 + le.Populated_src_location_influence_code_pcnt*ri.Populated_src_location_influence_code_pcnt *   0.00 / 10000 + le.Populated_tax_dt_location_influence_code_pcnt*ri.Populated_tax_dt_location_influence_code_pcnt *   0.00 / 10000 + le.Populated_acres_pcnt*ri.Populated_acres_pcnt *   0.00 / 10000 + le.Populated_src_acres_pcnt*ri.Populated_src_acres_pcnt *   0.00 / 10000 + le.Populated_tax_dt_acres_pcnt*ri.Populated_tax_dt_acres_pcnt *   0.00 / 10000 + le.Populated_lot_depth_footage_pcnt*ri.Populated_lot_depth_footage_pcnt *   0.00 / 10000 + le.Populated_src_lot_depth_footage_pcnt*ri.Populated_src_lot_depth_footage_pcnt *   0.00 / 10000 + le.Populated_tax_dt_lot_depth_footage_pcnt*ri.Populated_tax_dt_lot_depth_footage_pcnt *   0.00 / 10000 + le.Populated_lot_front_footage_pcnt*ri.Populated_lot_front_footage_pcnt *   0.00 / 10000 + le.Populated_src_lot_front_footage_pcnt*ri.Populated_src_lot_front_footage_pcnt *   0.00 / 10000 + le.Populated_tax_dt_lot_front_footage_pcnt*ri.Populated_tax_dt_lot_front_footage_pcnt *   0.00 / 10000 + le.Populated_lot_number_pcnt*ri.Populated_lot_number_pcnt *   0.00 / 10000 + le.Populated_src_lot_number_pcnt*ri.Populated_src_lot_number_pcnt *   0.00 / 10000 + le.Populated_tax_dt_lot_number_pcnt*ri.Populated_tax_dt_lot_number_pcnt *   0.00 / 10000 + le.Populated_lot_size_pcnt*ri.Populated_lot_size_pcnt *   0.00 / 10000 + le.Populated_src_lot_size_pcnt*ri.Populated_src_lot_size_pcnt *   0.00 / 10000 + le.Populated_tax_dt_lot_size_pcnt*ri.Populated_tax_dt_lot_size_pcnt *   0.00 / 10000 + le.Populated_property_type_code_pcnt*ri.Populated_property_type_code_pcnt *   0.00 / 10000 + le.Populated_src_property_type_code_pcnt*ri.Populated_src_property_type_code_pcnt *   0.00 / 10000 + le.Populated_tax_dt_property_type_code_pcnt*ri.Populated_tax_dt_property_type_code_pcnt *   0.00 / 10000 + le.Populated_structure_quality_pcnt*ri.Populated_structure_quality_pcnt *   0.00 / 10000 + le.Populated_src_structure_quality_pcnt*ri.Populated_src_structure_quality_pcnt *   0.00 / 10000 + le.Populated_tax_dt_structure_quality_pcnt*ri.Populated_tax_dt_structure_quality_pcnt *   0.00 / 10000 + le.Populated_water_pcnt*ri.Populated_water_pcnt *   0.00 / 10000 + le.Populated_src_water_pcnt*ri.Populated_src_water_pcnt *   0.00 / 10000 + le.Populated_tax_dt_water_pcnt*ri.Populated_tax_dt_water_pcnt *   0.00 / 10000 + le.Populated_sewer_pcnt*ri.Populated_sewer_pcnt *   0.00 / 10000 + le.Populated_src_sewer_pcnt*ri.Populated_src_sewer_pcnt *   0.00 / 10000 + le.Populated_tax_dt_sewer_pcnt*ri.Populated_tax_dt_sewer_pcnt *   0.00 / 10000 + le.Populated_assessed_land_value_pcnt*ri.Populated_assessed_land_value_pcnt *   0.00 / 10000 + le.Populated_src_assessed_land_value_pcnt*ri.Populated_src_assessed_land_value_pcnt *   0.00 / 10000 + le.Populated_tax_dt_assessed_land_value_pcnt*ri.Populated_tax_dt_assessed_land_value_pcnt *   0.00 / 10000 + le.Populated_assessed_year_pcnt*ri.Populated_assessed_year_pcnt *   0.00 / 10000 + le.Populated_src_assessed_year_pcnt*ri.Populated_src_assessed_year_pcnt *   0.00 / 10000 + le.Populated_tax_dt_assessed_year_pcnt*ri.Populated_tax_dt_assessed_year_pcnt *   0.00 / 10000 + le.Populated_tax_amount_pcnt*ri.Populated_tax_amount_pcnt *   0.00 / 10000 + le.Populated_src_tax_amount_pcnt*ri.Populated_src_tax_amount_pcnt *   0.00 / 10000 + le.Populated_tax_dt_tax_amount_pcnt*ri.Populated_tax_dt_tax_amount_pcnt *   0.00 / 10000 + le.Populated_tax_year_pcnt*ri.Populated_tax_year_pcnt *   0.00 / 10000 + le.Populated_src_tax_year_pcnt*ri.Populated_src_tax_year_pcnt *   0.00 / 10000 + le.Populated_market_land_value_pcnt*ri.Populated_market_land_value_pcnt *   0.00 / 10000 + le.Populated_src_market_land_value_pcnt*ri.Populated_src_market_land_value_pcnt *   0.00 / 10000 + le.Populated_tax_dt_market_land_value_pcnt*ri.Populated_tax_dt_market_land_value_pcnt *   0.00 / 10000 + le.Populated_improvement_value_pcnt*ri.Populated_improvement_value_pcnt *   0.00 / 10000 + le.Populated_src_improvement_value_pcnt*ri.Populated_src_improvement_value_pcnt *   0.00 / 10000 + le.Populated_tax_dt_improvement_value_pcnt*ri.Populated_tax_dt_improvement_value_pcnt *   0.00 / 10000 + le.Populated_percent_improved_pcnt*ri.Populated_percent_improved_pcnt *   0.00 / 10000 + le.Populated_src_percent_improved_pcnt*ri.Populated_src_percent_improved_pcnt *   0.00 / 10000 + le.Populated_tax_dt_percent_improved_pcnt*ri.Populated_tax_dt_percent_improved_pcnt *   0.00 / 10000 + le.Populated_total_assessed_value_pcnt*ri.Populated_total_assessed_value_pcnt *   0.00 / 10000 + le.Populated_src_total_assessed_value_pcnt*ri.Populated_src_total_assessed_value_pcnt *   0.00 / 10000 + le.Populated_tax_dt_total_assessed_value_pcnt*ri.Populated_tax_dt_total_assessed_value_pcnt *   0.00 / 10000 + le.Populated_total_calculated_value_pcnt*ri.Populated_total_calculated_value_pcnt *   0.00 / 10000 + le.Populated_src_total_calculated_value_pcnt*ri.Populated_src_total_calculated_value_pcnt *   0.00 / 10000 + le.Populated_tax_dt_total_calculated_value_pcnt*ri.Populated_tax_dt_total_calculated_value_pcnt *   0.00 / 10000 + le.Populated_total_land_value_pcnt*ri.Populated_total_land_value_pcnt *   0.00 / 10000 + le.Populated_src_total_land_value_pcnt*ri.Populated_src_total_land_value_pcnt *   0.00 / 10000 + le.Populated_tax_dt_total_land_value_pcnt*ri.Populated_tax_dt_total_land_value_pcnt *   0.00 / 10000 + le.Populated_total_market_value_pcnt*ri.Populated_total_market_value_pcnt *   0.00 / 10000 + le.Populated_src_total_market_value_pcnt*ri.Populated_src_total_market_value_pcnt *   0.00 / 10000 + le.Populated_tax_dt_total_market_value_pcnt*ri.Populated_tax_dt_total_market_value_pcnt *   0.00 / 10000 + le.Populated_floor_type_pcnt*ri.Populated_floor_type_pcnt *   0.00 / 10000 + le.Populated_src_floor_type_pcnt*ri.Populated_src_floor_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_floor_type_pcnt*ri.Populated_tax_dt_floor_type_pcnt *   0.00 / 10000 + le.Populated_frame_type_pcnt*ri.Populated_frame_type_pcnt *   0.00 / 10000 + le.Populated_src_frame_type_pcnt*ri.Populated_src_frame_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_frame_type_pcnt*ri.Populated_tax_dt_frame_type_pcnt *   0.00 / 10000 + le.Populated_fuel_type_pcnt*ri.Populated_fuel_type_pcnt *   0.00 / 10000 + le.Populated_src_fuel_type_pcnt*ri.Populated_src_fuel_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_fuel_type_pcnt*ri.Populated_tax_dt_fuel_type_pcnt *   0.00 / 10000 + le.Populated_no_of_bath_fixtures_pcnt*ri.Populated_no_of_bath_fixtures_pcnt *   0.00 / 10000 + le.Populated_src_no_of_bath_fixtures_pcnt*ri.Populated_src_no_of_bath_fixtures_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_bath_fixtures_pcnt*ri.Populated_tax_dt_no_of_bath_fixtures_pcnt *   0.00 / 10000 + le.Populated_no_of_rooms_pcnt*ri.Populated_no_of_rooms_pcnt *   0.00 / 10000 + le.Populated_src_no_of_rooms_pcnt*ri.Populated_src_no_of_rooms_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_rooms_pcnt*ri.Populated_tax_dt_no_of_rooms_pcnt *   0.00 / 10000 + le.Populated_no_of_units_pcnt*ri.Populated_no_of_units_pcnt *   0.00 / 10000 + le.Populated_src_no_of_units_pcnt*ri.Populated_src_no_of_units_pcnt *   0.00 / 10000 + le.Populated_tax_dt_no_of_units_pcnt*ri.Populated_tax_dt_no_of_units_pcnt *   0.00 / 10000 + le.Populated_style_type_pcnt*ri.Populated_style_type_pcnt *   0.00 / 10000 + le.Populated_src_style_type_pcnt*ri.Populated_src_style_type_pcnt *   0.00 / 10000 + le.Populated_tax_dt_style_type_pcnt*ri.Populated_tax_dt_style_type_pcnt *   0.00 / 10000 + le.Populated_assessment_document_number_pcnt*ri.Populated_assessment_document_number_pcnt *   0.00 / 10000 + le.Populated_src_assessment_document_number_pcnt*ri.Populated_src_assessment_document_number_pcnt *   0.00 / 10000 + le.Populated_tax_dt_assessment_document_number_pcnt*ri.Populated_tax_dt_assessment_document_number_pcnt *   0.00 / 10000 + le.Populated_assessment_recording_date_pcnt*ri.Populated_assessment_recording_date_pcnt *   0.00 / 10000 + le.Populated_src_assessment_recording_date_pcnt*ri.Populated_src_assessment_recording_date_pcnt *   0.00 / 10000 + le.Populated_tax_dt_assessment_recording_date_pcnt*ri.Populated_tax_dt_assessment_recording_date_pcnt *   0.00 / 10000 + le.Populated_deed_document_number_pcnt*ri.Populated_deed_document_number_pcnt *   0.00 / 10000 + le.Populated_src_deed_document_number_pcnt*ri.Populated_src_deed_document_number_pcnt *   0.00 / 10000 + le.Populated_rec_dt_deed_document_number_pcnt*ri.Populated_rec_dt_deed_document_number_pcnt *   0.00 / 10000 + le.Populated_deed_recording_date_pcnt*ri.Populated_deed_recording_date_pcnt *   0.00 / 10000 + le.Populated_src_deed_recording_date_pcnt*ri.Populated_src_deed_recording_date_pcnt *   0.00 / 10000 + le.Populated_full_part_sale_pcnt*ri.Populated_full_part_sale_pcnt *   0.00 / 10000 + le.Populated_src_full_part_sale_pcnt*ri.Populated_src_full_part_sale_pcnt *   0.00 / 10000 + le.Populated_rec_dt_full_part_sale_pcnt*ri.Populated_rec_dt_full_part_sale_pcnt *   0.00 / 10000 + le.Populated_sale_amount_pcnt*ri.Populated_sale_amount_pcnt *   0.00 / 10000 + le.Populated_src_sale_amount_pcnt*ri.Populated_src_sale_amount_pcnt *   0.00 / 10000 + le.Populated_rec_dt_sale_amount_pcnt*ri.Populated_rec_dt_sale_amount_pcnt *   0.00 / 10000 + le.Populated_sale_date_pcnt*ri.Populated_sale_date_pcnt *   0.00 / 10000 + le.Populated_src_sale_date_pcnt*ri.Populated_src_sale_date_pcnt *   0.00 / 10000 + le.Populated_rec_dt_sale_date_pcnt*ri.Populated_rec_dt_sale_date_pcnt *   0.00 / 10000 + le.Populated_sale_type_code_pcnt*ri.Populated_sale_type_code_pcnt *   0.00 / 10000 + le.Populated_src_sale_type_code_pcnt*ri.Populated_src_sale_type_code_pcnt *   0.00 / 10000 + le.Populated_rec_dt_sale_type_code_pcnt*ri.Populated_rec_dt_sale_type_code_pcnt *   0.00 / 10000 + le.Populated_mortgage_company_name_pcnt*ri.Populated_mortgage_company_name_pcnt *   0.00 / 10000 + le.Populated_src_mortgage_company_name_pcnt*ri.Populated_src_mortgage_company_name_pcnt *   0.00 / 10000 + le.Populated_rec_dt_mortgage_company_name_pcnt*ri.Populated_rec_dt_mortgage_company_name_pcnt *   0.00 / 10000 + le.Populated_loan_amount_pcnt*ri.Populated_loan_amount_pcnt *   0.00 / 10000 + le.Populated_src_loan_amount_pcnt*ri.Populated_src_loan_amount_pcnt *   0.00 / 10000 + le.Populated_rec_dt_loan_amount_pcnt*ri.Populated_rec_dt_loan_amount_pcnt *   0.00 / 10000 + le.Populated_second_loan_amount_pcnt*ri.Populated_second_loan_amount_pcnt *   0.00 / 10000 + le.Populated_src_second_loan_amount_pcnt*ri.Populated_src_second_loan_amount_pcnt *   0.00 / 10000 + le.Populated_rec_dt_second_loan_amount_pcnt*ri.Populated_rec_dt_second_loan_amount_pcnt *   0.00 / 10000 + le.Populated_loan_type_code_pcnt*ri.Populated_loan_type_code_pcnt *   0.00 / 10000 + le.Populated_src_loan_type_code_pcnt*ri.Populated_src_loan_type_code_pcnt *   0.00 / 10000 + le.Populated_rec_dt_loan_type_code_pcnt*ri.Populated_rec_dt_loan_type_code_pcnt *   0.00 / 10000 + le.Populated_interest_rate_type_code_pcnt*ri.Populated_interest_rate_type_code_pcnt *   0.00 / 10000 + le.Populated_src_interest_rate_type_code_pcnt*ri.Populated_src_interest_rate_type_code_pcnt *   0.00 / 10000 + le.Populated_rec_dt_interest_rate_type_code_pcnt*ri.Populated_rec_dt_interest_rate_type_code_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'property_rid','dt_vendor_first_reported','dt_vendor_last_reported','tax_sortby_date','deed_sortby_date','vendor_source','fares_unformatted_apn','property_street_address','property_city_state_zip','property_raw_aid','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','building_square_footage','src_building_square_footage','tax_dt_building_square_footage','air_conditioning_type','src_air_conditioning_type','tax_dt_air_conditioning_type','basement_finish','src_basement_finish','tax_dt_basement_finish','construction_type','src_construction_type','tax_dt_construction_type','exterior_wall','src_exterior_wall','tax_dt_exterior_wall','fireplace_ind','src_fireplace_ind','tax_dt_fireplace_ind','fireplace_type','src_fireplace_type','tax_dt_fireplace_type','flood_zone_panel','src_flood_zone_panel','tax_dt_flood_zone_panel','garage','src_garage','tax_dt_garage','first_floor_square_footage','src_first_floor_square_footage','tax_dt_first_floor_square_footage','heating','src_heating','tax_dt_heating','living_area_square_footage','src_living_area_square_footage','tax_dt_living_area_square_footage','no_of_baths','src_no_of_baths','tax_dt_no_of_baths','no_of_bedrooms','src_no_of_bedrooms','tax_dt_no_of_bedrooms','no_of_fireplaces','src_no_of_fireplaces','tax_dt_no_of_fireplaces','no_of_full_baths','src_no_of_full_baths','tax_dt_no_of_full_baths','no_of_half_baths','src_no_of_half_baths','tax_dt_no_of_half_baths','no_of_stories','src_no_of_stories','tax_dt_no_of_stories','parking_type','src_parking_type','tax_dt_parking_type','pool_indicator','src_pool_indicator','tax_dt_pool_indicator','pool_type','src_pool_type','tax_dt_pool_type','roof_cover','src_roof_cover','tax_dt_roof_cover','year_built','src_year_built','tax_dt_year_built','foundation','src_foundation','tax_dt_foundation','basement_square_footage','src_basement_square_footage','tax_dt_basement_square_footage','effective_year_built','src_effective_year_built','tax_dt_effective_year_built','garage_square_footage','src_garage_square_footage','tax_dt_garage_square_footage','stories_type','src_stories_type','tax_dt_stories_type','apn_number','src_apn_number','tax_dt_apn_number','census_tract','src_census_tract','tax_dt_census_tract','range','src_range','tax_dt_range','zoning','src_zoning','tax_dt_zoning','block_number','src_block_number','tax_dt_block_number','county_name','src_county_name','tax_dt_county_name','fips_code','src_fips_code','tax_dt_fips_code','subdivision','src_subdivision','tax_dt_subdivision','municipality','src_municipality','tax_dt_municipality','township','src_township','tax_dt_township','homestead_exemption_ind','src_homestead_exemption_ind','tax_dt_homestead_exemption_ind','land_use_code','src_land_use_code','tax_dt_land_use_code','latitude','src_latitude','tax_dt_latitude','longitude','src_longitude','tax_dt_longitude','location_influence_code','src_location_influence_code','tax_dt_location_influence_code','acres','src_acres','tax_dt_acres','lot_depth_footage','src_lot_depth_footage','tax_dt_lot_depth_footage','lot_front_footage','src_lot_front_footage','tax_dt_lot_front_footage','lot_number','src_lot_number','tax_dt_lot_number','lot_size','src_lot_size','tax_dt_lot_size','property_type_code','src_property_type_code','tax_dt_property_type_code','structure_quality','src_structure_quality','tax_dt_structure_quality','water','src_water','tax_dt_water','sewer','src_sewer','tax_dt_sewer','assessed_land_value','src_assessed_land_value','tax_dt_assessed_land_value','assessed_year','src_assessed_year','tax_dt_assessed_year','tax_amount','src_tax_amount','tax_dt_tax_amount','tax_year','src_tax_year','market_land_value','src_market_land_value','tax_dt_market_land_value','improvement_value','src_improvement_value','tax_dt_improvement_value','percent_improved','src_percent_improved','tax_dt_percent_improved','total_assessed_value','src_total_assessed_value','tax_dt_total_assessed_value','total_calculated_value','src_total_calculated_value','tax_dt_total_calculated_value','total_land_value','src_total_land_value','tax_dt_total_land_value','total_market_value','src_total_market_value','tax_dt_total_market_value','floor_type','src_floor_type','tax_dt_floor_type','frame_type','src_frame_type','tax_dt_frame_type','fuel_type','src_fuel_type','tax_dt_fuel_type','no_of_bath_fixtures','src_no_of_bath_fixtures','tax_dt_no_of_bath_fixtures','no_of_rooms','src_no_of_rooms','tax_dt_no_of_rooms','no_of_units','src_no_of_units','tax_dt_no_of_units','style_type','src_style_type','tax_dt_style_type','assessment_document_number','src_assessment_document_number','tax_dt_assessment_document_number','assessment_recording_date','src_assessment_recording_date','tax_dt_assessment_recording_date','deed_document_number','src_deed_document_number','rec_dt_deed_document_number','deed_recording_date','src_deed_recording_date','full_part_sale','src_full_part_sale','rec_dt_full_part_sale','sale_amount','src_sale_amount','rec_dt_sale_amount','sale_date','src_sale_date','rec_dt_sale_date','sale_type_code','src_sale_type_code','rec_dt_sale_type_code','mortgage_company_name','src_mortgage_company_name','rec_dt_mortgage_company_name','loan_amount','src_loan_amount','rec_dt_loan_amount','second_loan_amount','src_second_loan_amount','rec_dt_second_loan_amount','loan_type_code','src_loan_type_code','rec_dt_loan_type_code','interest_rate_type_code','src_interest_rate_type_code','rec_dt_interest_rate_type_code');
  SELF.populated_pcnt := CHOOSE(C,le.populated_property_rid_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_tax_sortby_date_pcnt,le.populated_deed_sortby_date_pcnt,le.populated_vendor_source_pcnt,le.populated_fares_unformatted_apn_pcnt,le.populated_property_street_address_pcnt,le.populated_property_city_state_zip_pcnt,le.populated_property_raw_aid_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_building_square_footage_pcnt,le.populated_src_building_square_footage_pcnt,le.populated_tax_dt_building_square_footage_pcnt,le.populated_air_conditioning_type_pcnt,le.populated_src_air_conditioning_type_pcnt,le.populated_tax_dt_air_conditioning_type_pcnt,le.populated_basement_finish_pcnt,le.populated_src_basement_finish_pcnt,le.populated_tax_dt_basement_finish_pcnt,le.populated_construction_type_pcnt,le.populated_src_construction_type_pcnt,le.populated_tax_dt_construction_type_pcnt,le.populated_exterior_wall_pcnt,le.populated_src_exterior_wall_pcnt,le.populated_tax_dt_exterior_wall_pcnt,le.populated_fireplace_ind_pcnt,le.populated_src_fireplace_ind_pcnt,le.populated_tax_dt_fireplace_ind_pcnt,le.populated_fireplace_type_pcnt,le.populated_src_fireplace_type_pcnt,le.populated_tax_dt_fireplace_type_pcnt,le.populated_flood_zone_panel_pcnt,le.populated_src_flood_zone_panel_pcnt,le.populated_tax_dt_flood_zone_panel_pcnt,le.populated_garage_pcnt,le.populated_src_garage_pcnt,le.populated_tax_dt_garage_pcnt,le.populated_first_floor_square_footage_pcnt,le.populated_src_first_floor_square_footage_pcnt,le.populated_tax_dt_first_floor_square_footage_pcnt,le.populated_heating_pcnt,le.populated_src_heating_pcnt,le.populated_tax_dt_heating_pcnt,le.populated_living_area_square_footage_pcnt,le.populated_src_living_area_square_footage_pcnt,le.populated_tax_dt_living_area_square_footage_pcnt,le.populated_no_of_baths_pcnt,le.populated_src_no_of_baths_pcnt,le.populated_tax_dt_no_of_baths_pcnt,le.populated_no_of_bedrooms_pcnt,le.populated_src_no_of_bedrooms_pcnt,le.populated_tax_dt_no_of_bedrooms_pcnt,le.populated_no_of_fireplaces_pcnt,le.populated_src_no_of_fireplaces_pcnt,le.populated_tax_dt_no_of_fireplaces_pcnt,le.populated_no_of_full_baths_pcnt,le.populated_src_no_of_full_baths_pcnt,le.populated_tax_dt_no_of_full_baths_pcnt,le.populated_no_of_half_baths_pcnt,le.populated_src_no_of_half_baths_pcnt,le.populated_tax_dt_no_of_half_baths_pcnt,le.populated_no_of_stories_pcnt,le.populated_src_no_of_stories_pcnt,le.populated_tax_dt_no_of_stories_pcnt,le.populated_parking_type_pcnt,le.populated_src_parking_type_pcnt,le.populated_tax_dt_parking_type_pcnt,le.populated_pool_indicator_pcnt,le.populated_src_pool_indicator_pcnt,le.populated_tax_dt_pool_indicator_pcnt,le.populated_pool_type_pcnt,le.populated_src_pool_type_pcnt,le.populated_tax_dt_pool_type_pcnt,le.populated_roof_cover_pcnt,le.populated_src_roof_cover_pcnt,le.populated_tax_dt_roof_cover_pcnt,le.populated_year_built_pcnt,le.populated_src_year_built_pcnt,le.populated_tax_dt_year_built_pcnt,le.populated_foundation_pcnt,le.populated_src_foundation_pcnt,le.populated_tax_dt_foundation_pcnt,le.populated_basement_square_footage_pcnt,le.populated_src_basement_square_footage_pcnt,le.populated_tax_dt_basement_square_footage_pcnt,le.populated_effective_year_built_pcnt,le.populated_src_effective_year_built_pcnt,le.populated_tax_dt_effective_year_built_pcnt,le.populated_garage_square_footage_pcnt,le.populated_src_garage_square_footage_pcnt,le.populated_tax_dt_garage_square_footage_pcnt,le.populated_stories_type_pcnt,le.populated_src_stories_type_pcnt,le.populated_tax_dt_stories_type_pcnt,le.populated_apn_number_pcnt,le.populated_src_apn_number_pcnt,le.populated_tax_dt_apn_number_pcnt,le.populated_census_tract_pcnt,le.populated_src_census_tract_pcnt,le.populated_tax_dt_census_tract_pcnt,le.populated_range_pcnt,le.populated_src_range_pcnt,le.populated_tax_dt_range_pcnt,le.populated_zoning_pcnt,le.populated_src_zoning_pcnt,le.populated_tax_dt_zoning_pcnt,le.populated_block_number_pcnt,le.populated_src_block_number_pcnt,le.populated_tax_dt_block_number_pcnt,le.populated_county_name_pcnt,le.populated_src_county_name_pcnt,le.populated_tax_dt_county_name_pcnt,le.populated_fips_code_pcnt,le.populated_src_fips_code_pcnt,le.populated_tax_dt_fips_code_pcnt,le.populated_subdivision_pcnt,le.populated_src_subdivision_pcnt,le.populated_tax_dt_subdivision_pcnt,le.populated_municipality_pcnt,le.populated_src_municipality_pcnt,le.populated_tax_dt_municipality_pcnt,le.populated_township_pcnt,le.populated_src_township_pcnt,le.populated_tax_dt_township_pcnt,le.populated_homestead_exemption_ind_pcnt,le.populated_src_homestead_exemption_ind_pcnt,le.populated_tax_dt_homestead_exemption_ind_pcnt,le.populated_land_use_code_pcnt,le.populated_src_land_use_code_pcnt,le.populated_tax_dt_land_use_code_pcnt,le.populated_latitude_pcnt,le.populated_src_latitude_pcnt,le.populated_tax_dt_latitude_pcnt,le.populated_longitude_pcnt,le.populated_src_longitude_pcnt,le.populated_tax_dt_longitude_pcnt,le.populated_location_influence_code_pcnt,le.populated_src_location_influence_code_pcnt,le.populated_tax_dt_location_influence_code_pcnt,le.populated_acres_pcnt,le.populated_src_acres_pcnt,le.populated_tax_dt_acres_pcnt,le.populated_lot_depth_footage_pcnt,le.populated_src_lot_depth_footage_pcnt,le.populated_tax_dt_lot_depth_footage_pcnt,le.populated_lot_front_footage_pcnt,le.populated_src_lot_front_footage_pcnt,le.populated_tax_dt_lot_front_footage_pcnt,le.populated_lot_number_pcnt,le.populated_src_lot_number_pcnt,le.populated_tax_dt_lot_number_pcnt,le.populated_lot_size_pcnt,le.populated_src_lot_size_pcnt,le.populated_tax_dt_lot_size_pcnt,le.populated_property_type_code_pcnt,le.populated_src_property_type_code_pcnt,le.populated_tax_dt_property_type_code_pcnt,le.populated_structure_quality_pcnt,le.populated_src_structure_quality_pcnt,le.populated_tax_dt_structure_quality_pcnt,le.populated_water_pcnt,le.populated_src_water_pcnt,le.populated_tax_dt_water_pcnt,le.populated_sewer_pcnt,le.populated_src_sewer_pcnt,le.populated_tax_dt_sewer_pcnt,le.populated_assessed_land_value_pcnt,le.populated_src_assessed_land_value_pcnt,le.populated_tax_dt_assessed_land_value_pcnt,le.populated_assessed_year_pcnt,le.populated_src_assessed_year_pcnt,le.populated_tax_dt_assessed_year_pcnt,le.populated_tax_amount_pcnt,le.populated_src_tax_amount_pcnt,le.populated_tax_dt_tax_amount_pcnt,le.populated_tax_year_pcnt,le.populated_src_tax_year_pcnt,le.populated_market_land_value_pcnt,le.populated_src_market_land_value_pcnt,le.populated_tax_dt_market_land_value_pcnt,le.populated_improvement_value_pcnt,le.populated_src_improvement_value_pcnt,le.populated_tax_dt_improvement_value_pcnt,le.populated_percent_improved_pcnt,le.populated_src_percent_improved_pcnt,le.populated_tax_dt_percent_improved_pcnt,le.populated_total_assessed_value_pcnt,le.populated_src_total_assessed_value_pcnt,le.populated_tax_dt_total_assessed_value_pcnt,le.populated_total_calculated_value_pcnt,le.populated_src_total_calculated_value_pcnt,le.populated_tax_dt_total_calculated_value_pcnt,le.populated_total_land_value_pcnt,le.populated_src_total_land_value_pcnt,le.populated_tax_dt_total_land_value_pcnt,le.populated_total_market_value_pcnt,le.populated_src_total_market_value_pcnt,le.populated_tax_dt_total_market_value_pcnt,le.populated_floor_type_pcnt,le.populated_src_floor_type_pcnt,le.populated_tax_dt_floor_type_pcnt,le.populated_frame_type_pcnt,le.populated_src_frame_type_pcnt,le.populated_tax_dt_frame_type_pcnt,le.populated_fuel_type_pcnt,le.populated_src_fuel_type_pcnt,le.populated_tax_dt_fuel_type_pcnt,le.populated_no_of_bath_fixtures_pcnt,le.populated_src_no_of_bath_fixtures_pcnt,le.populated_tax_dt_no_of_bath_fixtures_pcnt,le.populated_no_of_rooms_pcnt,le.populated_src_no_of_rooms_pcnt,le.populated_tax_dt_no_of_rooms_pcnt,le.populated_no_of_units_pcnt,le.populated_src_no_of_units_pcnt,le.populated_tax_dt_no_of_units_pcnt,le.populated_style_type_pcnt,le.populated_src_style_type_pcnt,le.populated_tax_dt_style_type_pcnt,le.populated_assessment_document_number_pcnt,le.populated_src_assessment_document_number_pcnt,le.populated_tax_dt_assessment_document_number_pcnt,le.populated_assessment_recording_date_pcnt,le.populated_src_assessment_recording_date_pcnt,le.populated_tax_dt_assessment_recording_date_pcnt,le.populated_deed_document_number_pcnt,le.populated_src_deed_document_number_pcnt,le.populated_rec_dt_deed_document_number_pcnt,le.populated_deed_recording_date_pcnt,le.populated_src_deed_recording_date_pcnt,le.populated_full_part_sale_pcnt,le.populated_src_full_part_sale_pcnt,le.populated_rec_dt_full_part_sale_pcnt,le.populated_sale_amount_pcnt,le.populated_src_sale_amount_pcnt,le.populated_rec_dt_sale_amount_pcnt,le.populated_sale_date_pcnt,le.populated_src_sale_date_pcnt,le.populated_rec_dt_sale_date_pcnt,le.populated_sale_type_code_pcnt,le.populated_src_sale_type_code_pcnt,le.populated_rec_dt_sale_type_code_pcnt,le.populated_mortgage_company_name_pcnt,le.populated_src_mortgage_company_name_pcnt,le.populated_rec_dt_mortgage_company_name_pcnt,le.populated_loan_amount_pcnt,le.populated_src_loan_amount_pcnt,le.populated_rec_dt_loan_amount_pcnt,le.populated_second_loan_amount_pcnt,le.populated_src_second_loan_amount_pcnt,le.populated_rec_dt_second_loan_amount_pcnt,le.populated_loan_type_code_pcnt,le.populated_src_loan_type_code_pcnt,le.populated_rec_dt_loan_type_code_pcnt,le.populated_interest_rate_type_code_pcnt,le.populated_src_interest_rate_type_code_pcnt,le.populated_rec_dt_interest_rate_type_code_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_property_rid,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_tax_sortby_date,le.maxlength_deed_sortby_date,le.maxlength_vendor_source,le.maxlength_fares_unformatted_apn,le.maxlength_property_street_address,le.maxlength_property_city_state_zip,le.maxlength_property_raw_aid,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_building_square_footage,le.maxlength_src_building_square_footage,le.maxlength_tax_dt_building_square_footage,le.maxlength_air_conditioning_type,le.maxlength_src_air_conditioning_type,le.maxlength_tax_dt_air_conditioning_type,le.maxlength_basement_finish,le.maxlength_src_basement_finish,le.maxlength_tax_dt_basement_finish,le.maxlength_construction_type,le.maxlength_src_construction_type,le.maxlength_tax_dt_construction_type,le.maxlength_exterior_wall,le.maxlength_src_exterior_wall,le.maxlength_tax_dt_exterior_wall,le.maxlength_fireplace_ind,le.maxlength_src_fireplace_ind,le.maxlength_tax_dt_fireplace_ind,le.maxlength_fireplace_type,le.maxlength_src_fireplace_type,le.maxlength_tax_dt_fireplace_type,le.maxlength_flood_zone_panel,le.maxlength_src_flood_zone_panel,le.maxlength_tax_dt_flood_zone_panel,le.maxlength_garage,le.maxlength_src_garage,le.maxlength_tax_dt_garage,le.maxlength_first_floor_square_footage,le.maxlength_src_first_floor_square_footage,le.maxlength_tax_dt_first_floor_square_footage,le.maxlength_heating,le.maxlength_src_heating,le.maxlength_tax_dt_heating,le.maxlength_living_area_square_footage,le.maxlength_src_living_area_square_footage,le.maxlength_tax_dt_living_area_square_footage,le.maxlength_no_of_baths,le.maxlength_src_no_of_baths,le.maxlength_tax_dt_no_of_baths,le.maxlength_no_of_bedrooms,le.maxlength_src_no_of_bedrooms,le.maxlength_tax_dt_no_of_bedrooms,le.maxlength_no_of_fireplaces,le.maxlength_src_no_of_fireplaces,le.maxlength_tax_dt_no_of_fireplaces,le.maxlength_no_of_full_baths,le.maxlength_src_no_of_full_baths,le.maxlength_tax_dt_no_of_full_baths,le.maxlength_no_of_half_baths,le.maxlength_src_no_of_half_baths,le.maxlength_tax_dt_no_of_half_baths,le.maxlength_no_of_stories,le.maxlength_src_no_of_stories,le.maxlength_tax_dt_no_of_stories,le.maxlength_parking_type,le.maxlength_src_parking_type,le.maxlength_tax_dt_parking_type,le.maxlength_pool_indicator,le.maxlength_src_pool_indicator,le.maxlength_tax_dt_pool_indicator,le.maxlength_pool_type,le.maxlength_src_pool_type,le.maxlength_tax_dt_pool_type,le.maxlength_roof_cover,le.maxlength_src_roof_cover,le.maxlength_tax_dt_roof_cover,le.maxlength_year_built,le.maxlength_src_year_built,le.maxlength_tax_dt_year_built,le.maxlength_foundation,le.maxlength_src_foundation,le.maxlength_tax_dt_foundation,le.maxlength_basement_square_footage,le.maxlength_src_basement_square_footage,le.maxlength_tax_dt_basement_square_footage,le.maxlength_effective_year_built,le.maxlength_src_effective_year_built,le.maxlength_tax_dt_effective_year_built,le.maxlength_garage_square_footage,le.maxlength_src_garage_square_footage,le.maxlength_tax_dt_garage_square_footage,le.maxlength_stories_type,le.maxlength_src_stories_type,le.maxlength_tax_dt_stories_type,le.maxlength_apn_number,le.maxlength_src_apn_number,le.maxlength_tax_dt_apn_number,le.maxlength_census_tract,le.maxlength_src_census_tract,le.maxlength_tax_dt_census_tract,le.maxlength_range,le.maxlength_src_range,le.maxlength_tax_dt_range,le.maxlength_zoning,le.maxlength_src_zoning,le.maxlength_tax_dt_zoning,le.maxlength_block_number,le.maxlength_src_block_number,le.maxlength_tax_dt_block_number,le.maxlength_county_name,le.maxlength_src_county_name,le.maxlength_tax_dt_county_name,le.maxlength_fips_code,le.maxlength_src_fips_code,le.maxlength_tax_dt_fips_code,le.maxlength_subdivision,le.maxlength_src_subdivision,le.maxlength_tax_dt_subdivision,le.maxlength_municipality,le.maxlength_src_municipality,le.maxlength_tax_dt_municipality,le.maxlength_township,le.maxlength_src_township,le.maxlength_tax_dt_township,le.maxlength_homestead_exemption_ind,le.maxlength_src_homestead_exemption_ind,le.maxlength_tax_dt_homestead_exemption_ind,le.maxlength_land_use_code,le.maxlength_src_land_use_code,le.maxlength_tax_dt_land_use_code,le.maxlength_latitude,le.maxlength_src_latitude,le.maxlength_tax_dt_latitude,le.maxlength_longitude,le.maxlength_src_longitude,le.maxlength_tax_dt_longitude,le.maxlength_location_influence_code,le.maxlength_src_location_influence_code,le.maxlength_tax_dt_location_influence_code,le.maxlength_acres,le.maxlength_src_acres,le.maxlength_tax_dt_acres,le.maxlength_lot_depth_footage,le.maxlength_src_lot_depth_footage,le.maxlength_tax_dt_lot_depth_footage,le.maxlength_lot_front_footage,le.maxlength_src_lot_front_footage,le.maxlength_tax_dt_lot_front_footage,le.maxlength_lot_number,le.maxlength_src_lot_number,le.maxlength_tax_dt_lot_number,le.maxlength_lot_size,le.maxlength_src_lot_size,le.maxlength_tax_dt_lot_size,le.maxlength_property_type_code,le.maxlength_src_property_type_code,le.maxlength_tax_dt_property_type_code,le.maxlength_structure_quality,le.maxlength_src_structure_quality,le.maxlength_tax_dt_structure_quality,le.maxlength_water,le.maxlength_src_water,le.maxlength_tax_dt_water,le.maxlength_sewer,le.maxlength_src_sewer,le.maxlength_tax_dt_sewer,le.maxlength_assessed_land_value,le.maxlength_src_assessed_land_value,le.maxlength_tax_dt_assessed_land_value,le.maxlength_assessed_year,le.maxlength_src_assessed_year,le.maxlength_tax_dt_assessed_year,le.maxlength_tax_amount,le.maxlength_src_tax_amount,le.maxlength_tax_dt_tax_amount,le.maxlength_tax_year,le.maxlength_src_tax_year,le.maxlength_market_land_value,le.maxlength_src_market_land_value,le.maxlength_tax_dt_market_land_value,le.maxlength_improvement_value,le.maxlength_src_improvement_value,le.maxlength_tax_dt_improvement_value,le.maxlength_percent_improved,le.maxlength_src_percent_improved,le.maxlength_tax_dt_percent_improved,le.maxlength_total_assessed_value,le.maxlength_src_total_assessed_value,le.maxlength_tax_dt_total_assessed_value,le.maxlength_total_calculated_value,le.maxlength_src_total_calculated_value,le.maxlength_tax_dt_total_calculated_value,le.maxlength_total_land_value,le.maxlength_src_total_land_value,le.maxlength_tax_dt_total_land_value,le.maxlength_total_market_value,le.maxlength_src_total_market_value,le.maxlength_tax_dt_total_market_value,le.maxlength_floor_type,le.maxlength_src_floor_type,le.maxlength_tax_dt_floor_type,le.maxlength_frame_type,le.maxlength_src_frame_type,le.maxlength_tax_dt_frame_type,le.maxlength_fuel_type,le.maxlength_src_fuel_type,le.maxlength_tax_dt_fuel_type,le.maxlength_no_of_bath_fixtures,le.maxlength_src_no_of_bath_fixtures,le.maxlength_tax_dt_no_of_bath_fixtures,le.maxlength_no_of_rooms,le.maxlength_src_no_of_rooms,le.maxlength_tax_dt_no_of_rooms,le.maxlength_no_of_units,le.maxlength_src_no_of_units,le.maxlength_tax_dt_no_of_units,le.maxlength_style_type,le.maxlength_src_style_type,le.maxlength_tax_dt_style_type,le.maxlength_assessment_document_number,le.maxlength_src_assessment_document_number,le.maxlength_tax_dt_assessment_document_number,le.maxlength_assessment_recording_date,le.maxlength_src_assessment_recording_date,le.maxlength_tax_dt_assessment_recording_date,le.maxlength_deed_document_number,le.maxlength_src_deed_document_number,le.maxlength_rec_dt_deed_document_number,le.maxlength_deed_recording_date,le.maxlength_src_deed_recording_date,le.maxlength_full_part_sale,le.maxlength_src_full_part_sale,le.maxlength_rec_dt_full_part_sale,le.maxlength_sale_amount,le.maxlength_src_sale_amount,le.maxlength_rec_dt_sale_amount,le.maxlength_sale_date,le.maxlength_src_sale_date,le.maxlength_rec_dt_sale_date,le.maxlength_sale_type_code,le.maxlength_src_sale_type_code,le.maxlength_rec_dt_sale_type_code,le.maxlength_mortgage_company_name,le.maxlength_src_mortgage_company_name,le.maxlength_rec_dt_mortgage_company_name,le.maxlength_loan_amount,le.maxlength_src_loan_amount,le.maxlength_rec_dt_loan_amount,le.maxlength_second_loan_amount,le.maxlength_src_second_loan_amount,le.maxlength_rec_dt_second_loan_amount,le.maxlength_loan_type_code,le.maxlength_src_loan_type_code,le.maxlength_rec_dt_loan_type_code,le.maxlength_interest_rate_type_code,le.maxlength_src_interest_rate_type_code,le.maxlength_rec_dt_interest_rate_type_code);
  SELF.avelength := CHOOSE(C,le.avelength_property_rid,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_tax_sortby_date,le.avelength_deed_sortby_date,le.avelength_vendor_source,le.avelength_fares_unformatted_apn,le.avelength_property_street_address,le.avelength_property_city_state_zip,le.avelength_property_raw_aid,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_building_square_footage,le.avelength_src_building_square_footage,le.avelength_tax_dt_building_square_footage,le.avelength_air_conditioning_type,le.avelength_src_air_conditioning_type,le.avelength_tax_dt_air_conditioning_type,le.avelength_basement_finish,le.avelength_src_basement_finish,le.avelength_tax_dt_basement_finish,le.avelength_construction_type,le.avelength_src_construction_type,le.avelength_tax_dt_construction_type,le.avelength_exterior_wall,le.avelength_src_exterior_wall,le.avelength_tax_dt_exterior_wall,le.avelength_fireplace_ind,le.avelength_src_fireplace_ind,le.avelength_tax_dt_fireplace_ind,le.avelength_fireplace_type,le.avelength_src_fireplace_type,le.avelength_tax_dt_fireplace_type,le.avelength_flood_zone_panel,le.avelength_src_flood_zone_panel,le.avelength_tax_dt_flood_zone_panel,le.avelength_garage,le.avelength_src_garage,le.avelength_tax_dt_garage,le.avelength_first_floor_square_footage,le.avelength_src_first_floor_square_footage,le.avelength_tax_dt_first_floor_square_footage,le.avelength_heating,le.avelength_src_heating,le.avelength_tax_dt_heating,le.avelength_living_area_square_footage,le.avelength_src_living_area_square_footage,le.avelength_tax_dt_living_area_square_footage,le.avelength_no_of_baths,le.avelength_src_no_of_baths,le.avelength_tax_dt_no_of_baths,le.avelength_no_of_bedrooms,le.avelength_src_no_of_bedrooms,le.avelength_tax_dt_no_of_bedrooms,le.avelength_no_of_fireplaces,le.avelength_src_no_of_fireplaces,le.avelength_tax_dt_no_of_fireplaces,le.avelength_no_of_full_baths,le.avelength_src_no_of_full_baths,le.avelength_tax_dt_no_of_full_baths,le.avelength_no_of_half_baths,le.avelength_src_no_of_half_baths,le.avelength_tax_dt_no_of_half_baths,le.avelength_no_of_stories,le.avelength_src_no_of_stories,le.avelength_tax_dt_no_of_stories,le.avelength_parking_type,le.avelength_src_parking_type,le.avelength_tax_dt_parking_type,le.avelength_pool_indicator,le.avelength_src_pool_indicator,le.avelength_tax_dt_pool_indicator,le.avelength_pool_type,le.avelength_src_pool_type,le.avelength_tax_dt_pool_type,le.avelength_roof_cover,le.avelength_src_roof_cover,le.avelength_tax_dt_roof_cover,le.avelength_year_built,le.avelength_src_year_built,le.avelength_tax_dt_year_built,le.avelength_foundation,le.avelength_src_foundation,le.avelength_tax_dt_foundation,le.avelength_basement_square_footage,le.avelength_src_basement_square_footage,le.avelength_tax_dt_basement_square_footage,le.avelength_effective_year_built,le.avelength_src_effective_year_built,le.avelength_tax_dt_effective_year_built,le.avelength_garage_square_footage,le.avelength_src_garage_square_footage,le.avelength_tax_dt_garage_square_footage,le.avelength_stories_type,le.avelength_src_stories_type,le.avelength_tax_dt_stories_type,le.avelength_apn_number,le.avelength_src_apn_number,le.avelength_tax_dt_apn_number,le.avelength_census_tract,le.avelength_src_census_tract,le.avelength_tax_dt_census_tract,le.avelength_range,le.avelength_src_range,le.avelength_tax_dt_range,le.avelength_zoning,le.avelength_src_zoning,le.avelength_tax_dt_zoning,le.avelength_block_number,le.avelength_src_block_number,le.avelength_tax_dt_block_number,le.avelength_county_name,le.avelength_src_county_name,le.avelength_tax_dt_county_name,le.avelength_fips_code,le.avelength_src_fips_code,le.avelength_tax_dt_fips_code,le.avelength_subdivision,le.avelength_src_subdivision,le.avelength_tax_dt_subdivision,le.avelength_municipality,le.avelength_src_municipality,le.avelength_tax_dt_municipality,le.avelength_township,le.avelength_src_township,le.avelength_tax_dt_township,le.avelength_homestead_exemption_ind,le.avelength_src_homestead_exemption_ind,le.avelength_tax_dt_homestead_exemption_ind,le.avelength_land_use_code,le.avelength_src_land_use_code,le.avelength_tax_dt_land_use_code,le.avelength_latitude,le.avelength_src_latitude,le.avelength_tax_dt_latitude,le.avelength_longitude,le.avelength_src_longitude,le.avelength_tax_dt_longitude,le.avelength_location_influence_code,le.avelength_src_location_influence_code,le.avelength_tax_dt_location_influence_code,le.avelength_acres,le.avelength_src_acres,le.avelength_tax_dt_acres,le.avelength_lot_depth_footage,le.avelength_src_lot_depth_footage,le.avelength_tax_dt_lot_depth_footage,le.avelength_lot_front_footage,le.avelength_src_lot_front_footage,le.avelength_tax_dt_lot_front_footage,le.avelength_lot_number,le.avelength_src_lot_number,le.avelength_tax_dt_lot_number,le.avelength_lot_size,le.avelength_src_lot_size,le.avelength_tax_dt_lot_size,le.avelength_property_type_code,le.avelength_src_property_type_code,le.avelength_tax_dt_property_type_code,le.avelength_structure_quality,le.avelength_src_structure_quality,le.avelength_tax_dt_structure_quality,le.avelength_water,le.avelength_src_water,le.avelength_tax_dt_water,le.avelength_sewer,le.avelength_src_sewer,le.avelength_tax_dt_sewer,le.avelength_assessed_land_value,le.avelength_src_assessed_land_value,le.avelength_tax_dt_assessed_land_value,le.avelength_assessed_year,le.avelength_src_assessed_year,le.avelength_tax_dt_assessed_year,le.avelength_tax_amount,le.avelength_src_tax_amount,le.avelength_tax_dt_tax_amount,le.avelength_tax_year,le.avelength_src_tax_year,le.avelength_market_land_value,le.avelength_src_market_land_value,le.avelength_tax_dt_market_land_value,le.avelength_improvement_value,le.avelength_src_improvement_value,le.avelength_tax_dt_improvement_value,le.avelength_percent_improved,le.avelength_src_percent_improved,le.avelength_tax_dt_percent_improved,le.avelength_total_assessed_value,le.avelength_src_total_assessed_value,le.avelength_tax_dt_total_assessed_value,le.avelength_total_calculated_value,le.avelength_src_total_calculated_value,le.avelength_tax_dt_total_calculated_value,le.avelength_total_land_value,le.avelength_src_total_land_value,le.avelength_tax_dt_total_land_value,le.avelength_total_market_value,le.avelength_src_total_market_value,le.avelength_tax_dt_total_market_value,le.avelength_floor_type,le.avelength_src_floor_type,le.avelength_tax_dt_floor_type,le.avelength_frame_type,le.avelength_src_frame_type,le.avelength_tax_dt_frame_type,le.avelength_fuel_type,le.avelength_src_fuel_type,le.avelength_tax_dt_fuel_type,le.avelength_no_of_bath_fixtures,le.avelength_src_no_of_bath_fixtures,le.avelength_tax_dt_no_of_bath_fixtures,le.avelength_no_of_rooms,le.avelength_src_no_of_rooms,le.avelength_tax_dt_no_of_rooms,le.avelength_no_of_units,le.avelength_src_no_of_units,le.avelength_tax_dt_no_of_units,le.avelength_style_type,le.avelength_src_style_type,le.avelength_tax_dt_style_type,le.avelength_assessment_document_number,le.avelength_src_assessment_document_number,le.avelength_tax_dt_assessment_document_number,le.avelength_assessment_recording_date,le.avelength_src_assessment_recording_date,le.avelength_tax_dt_assessment_recording_date,le.avelength_deed_document_number,le.avelength_src_deed_document_number,le.avelength_rec_dt_deed_document_number,le.avelength_deed_recording_date,le.avelength_src_deed_recording_date,le.avelength_full_part_sale,le.avelength_src_full_part_sale,le.avelength_rec_dt_full_part_sale,le.avelength_sale_amount,le.avelength_src_sale_amount,le.avelength_rec_dt_sale_amount,le.avelength_sale_date,le.avelength_src_sale_date,le.avelength_rec_dt_sale_date,le.avelength_sale_type_code,le.avelength_src_sale_type_code,le.avelength_rec_dt_sale_type_code,le.avelength_mortgage_company_name,le.avelength_src_mortgage_company_name,le.avelength_rec_dt_mortgage_company_name,le.avelength_loan_amount,le.avelength_src_loan_amount,le.avelength_rec_dt_loan_amount,le.avelength_second_loan_amount,le.avelength_src_second_loan_amount,le.avelength_rec_dt_second_loan_amount,le.avelength_loan_type_code,le.avelength_src_loan_type_code,le.avelength_rec_dt_loan_type_code,le.avelength_interest_rate_type_code,le.avelength_src_interest_rate_type_code,le.avelength_rec_dt_interest_rate_type_code);
END;
EXPORT invSummary := NORMALIZE(summary0, 283, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.vendor_source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.property_rid),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.tax_sortby_date),TRIM((SALT311.StrType)le.deed_sortby_date),TRIM((SALT311.StrType)le.vendor_source),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.property_street_address),TRIM((SALT311.StrType)le.property_city_state_zip),TRIM((SALT311.StrType)le.property_raw_aid),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.building_square_footage),TRIM((SALT311.StrType)le.src_building_square_footage),TRIM((SALT311.StrType)le.tax_dt_building_square_footage),TRIM((SALT311.StrType)le.air_conditioning_type),TRIM((SALT311.StrType)le.src_air_conditioning_type),TRIM((SALT311.StrType)le.tax_dt_air_conditioning_type),TRIM((SALT311.StrType)le.basement_finish),TRIM((SALT311.StrType)le.src_basement_finish),TRIM((SALT311.StrType)le.tax_dt_basement_finish),TRIM((SALT311.StrType)le.construction_type),TRIM((SALT311.StrType)le.src_construction_type),TRIM((SALT311.StrType)le.tax_dt_construction_type),TRIM((SALT311.StrType)le.exterior_wall),TRIM((SALT311.StrType)le.src_exterior_wall),TRIM((SALT311.StrType)le.tax_dt_exterior_wall),TRIM((SALT311.StrType)le.fireplace_ind),TRIM((SALT311.StrType)le.src_fireplace_ind),TRIM((SALT311.StrType)le.tax_dt_fireplace_ind),TRIM((SALT311.StrType)le.fireplace_type),TRIM((SALT311.StrType)le.src_fireplace_type),TRIM((SALT311.StrType)le.tax_dt_fireplace_type),TRIM((SALT311.StrType)le.flood_zone_panel),TRIM((SALT311.StrType)le.src_flood_zone_panel),TRIM((SALT311.StrType)le.tax_dt_flood_zone_panel),TRIM((SALT311.StrType)le.garage),TRIM((SALT311.StrType)le.src_garage),TRIM((SALT311.StrType)le.tax_dt_garage),TRIM((SALT311.StrType)le.first_floor_square_footage),TRIM((SALT311.StrType)le.src_first_floor_square_footage),TRIM((SALT311.StrType)le.tax_dt_first_floor_square_footage),TRIM((SALT311.StrType)le.heating),TRIM((SALT311.StrType)le.src_heating),TRIM((SALT311.StrType)le.tax_dt_heating),TRIM((SALT311.StrType)le.living_area_square_footage),TRIM((SALT311.StrType)le.src_living_area_square_footage),TRIM((SALT311.StrType)le.tax_dt_living_area_square_footage),TRIM((SALT311.StrType)le.no_of_baths),TRIM((SALT311.StrType)le.src_no_of_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_baths),TRIM((SALT311.StrType)le.no_of_bedrooms),TRIM((SALT311.StrType)le.src_no_of_bedrooms),TRIM((SALT311.StrType)le.tax_dt_no_of_bedrooms),TRIM((SALT311.StrType)le.no_of_fireplaces),TRIM((SALT311.StrType)le.src_no_of_fireplaces),TRIM((SALT311.StrType)le.tax_dt_no_of_fireplaces),TRIM((SALT311.StrType)le.no_of_full_baths),TRIM((SALT311.StrType)le.src_no_of_full_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_full_baths),TRIM((SALT311.StrType)le.no_of_half_baths),TRIM((SALT311.StrType)le.src_no_of_half_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_half_baths),TRIM((SALT311.StrType)le.no_of_stories),TRIM((SALT311.StrType)le.src_no_of_stories),TRIM((SALT311.StrType)le.tax_dt_no_of_stories),TRIM((SALT311.StrType)le.parking_type),TRIM((SALT311.StrType)le.src_parking_type),TRIM((SALT311.StrType)le.tax_dt_parking_type),TRIM((SALT311.StrType)le.pool_indicator),TRIM((SALT311.StrType)le.src_pool_indicator),TRIM((SALT311.StrType)le.tax_dt_pool_indicator),TRIM((SALT311.StrType)le.pool_type),TRIM((SALT311.StrType)le.src_pool_type),TRIM((SALT311.StrType)le.tax_dt_pool_type),TRIM((SALT311.StrType)le.roof_cover),TRIM((SALT311.StrType)le.src_roof_cover),TRIM((SALT311.StrType)le.tax_dt_roof_cover),TRIM((SALT311.StrType)le.year_built),TRIM((SALT311.StrType)le.src_year_built),TRIM((SALT311.StrType)le.tax_dt_year_built),TRIM((SALT311.StrType)le.foundation),TRIM((SALT311.StrType)le.src_foundation),TRIM((SALT311.StrType)le.tax_dt_foundation),TRIM((SALT311.StrType)le.basement_square_footage),TRIM((SALT311.StrType)le.src_basement_square_footage),TRIM((SALT311.StrType)le.tax_dt_basement_square_footage),TRIM((SALT311.StrType)le.effective_year_built),TRIM((SALT311.StrType)le.src_effective_year_built),TRIM((SALT311.StrType)le.tax_dt_effective_year_built),TRIM((SALT311.StrType)le.garage_square_footage),TRIM((SALT311.StrType)le.src_garage_square_footage),TRIM((SALT311.StrType)le.tax_dt_garage_square_footage),TRIM((SALT311.StrType)le.stories_type),TRIM((SALT311.StrType)le.src_stories_type),TRIM((SALT311.StrType)le.tax_dt_stories_type),TRIM((SALT311.StrType)le.apn_number),TRIM((SALT311.StrType)le.src_apn_number),TRIM((SALT311.StrType)le.tax_dt_apn_number),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.src_census_tract),TRIM((SALT311.StrType)le.tax_dt_census_tract),TRIM((SALT311.StrType)le.range),TRIM((SALT311.StrType)le.src_range),TRIM((SALT311.StrType)le.tax_dt_range),TRIM((SALT311.StrType)le.zoning),TRIM((SALT311.StrType)le.src_zoning),TRIM((SALT311.StrType)le.tax_dt_zoning),TRIM((SALT311.StrType)le.block_number),TRIM((SALT311.StrType)le.src_block_number),TRIM((SALT311.StrType)le.tax_dt_block_number),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.src_county_name),TRIM((SALT311.StrType)le.tax_dt_county_name),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.src_fips_code),TRIM((SALT311.StrType)le.tax_dt_fips_code),TRIM((SALT311.StrType)le.subdivision),TRIM((SALT311.StrType)le.src_subdivision),TRIM((SALT311.StrType)le.tax_dt_subdivision),TRIM((SALT311.StrType)le.municipality),TRIM((SALT311.StrType)le.src_municipality),TRIM((SALT311.StrType)le.tax_dt_municipality),TRIM((SALT311.StrType)le.township),TRIM((SALT311.StrType)le.src_township),TRIM((SALT311.StrType)le.tax_dt_township),TRIM((SALT311.StrType)le.homestead_exemption_ind),TRIM((SALT311.StrType)le.src_homestead_exemption_ind),TRIM((SALT311.StrType)le.tax_dt_homestead_exemption_ind),TRIM((SALT311.StrType)le.land_use_code),TRIM((SALT311.StrType)le.src_land_use_code),TRIM((SALT311.StrType)le.tax_dt_land_use_code),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.src_latitude),TRIM((SALT311.StrType)le.tax_dt_latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.src_longitude),TRIM((SALT311.StrType)le.tax_dt_longitude),TRIM((SALT311.StrType)le.location_influence_code),TRIM((SALT311.StrType)le.src_location_influence_code),TRIM((SALT311.StrType)le.tax_dt_location_influence_code),TRIM((SALT311.StrType)le.acres),TRIM((SALT311.StrType)le.src_acres),TRIM((SALT311.StrType)le.tax_dt_acres),TRIM((SALT311.StrType)le.lot_depth_footage),TRIM((SALT311.StrType)le.src_lot_depth_footage),TRIM((SALT311.StrType)le.tax_dt_lot_depth_footage),TRIM((SALT311.StrType)le.lot_front_footage),TRIM((SALT311.StrType)le.src_lot_front_footage),TRIM((SALT311.StrType)le.tax_dt_lot_front_footage),TRIM((SALT311.StrType)le.lot_number),TRIM((SALT311.StrType)le.src_lot_number),TRIM((SALT311.StrType)le.tax_dt_lot_number),TRIM((SALT311.StrType)le.lot_size),TRIM((SALT311.StrType)le.src_lot_size),TRIM((SALT311.StrType)le.tax_dt_lot_size),TRIM((SALT311.StrType)le.property_type_code),TRIM((SALT311.StrType)le.src_property_type_code),TRIM((SALT311.StrType)le.tax_dt_property_type_code),TRIM((SALT311.StrType)le.structure_quality),TRIM((SALT311.StrType)le.src_structure_quality),TRIM((SALT311.StrType)le.tax_dt_structure_quality),TRIM((SALT311.StrType)le.water),TRIM((SALT311.StrType)le.src_water),TRIM((SALT311.StrType)le.tax_dt_water),TRIM((SALT311.StrType)le.sewer),TRIM((SALT311.StrType)le.src_sewer),TRIM((SALT311.StrType)le.tax_dt_sewer),TRIM((SALT311.StrType)le.assessed_land_value),TRIM((SALT311.StrType)le.src_assessed_land_value),TRIM((SALT311.StrType)le.tax_dt_assessed_land_value),TRIM((SALT311.StrType)le.assessed_year),TRIM((SALT311.StrType)le.src_assessed_year),TRIM((SALT311.StrType)le.tax_dt_assessed_year),TRIM((SALT311.StrType)le.tax_amount),TRIM((SALT311.StrType)le.src_tax_amount),TRIM((SALT311.StrType)le.tax_dt_tax_amount),TRIM((SALT311.StrType)le.tax_year),TRIM((SALT311.StrType)le.src_tax_year),TRIM((SALT311.StrType)le.market_land_value),TRIM((SALT311.StrType)le.src_market_land_value),TRIM((SALT311.StrType)le.tax_dt_market_land_value),TRIM((SALT311.StrType)le.improvement_value),TRIM((SALT311.StrType)le.src_improvement_value),TRIM((SALT311.StrType)le.tax_dt_improvement_value),TRIM((SALT311.StrType)le.percent_improved),TRIM((SALT311.StrType)le.src_percent_improved),TRIM((SALT311.StrType)le.tax_dt_percent_improved),TRIM((SALT311.StrType)le.total_assessed_value),TRIM((SALT311.StrType)le.src_total_assessed_value),TRIM((SALT311.StrType)le.tax_dt_total_assessed_value),TRIM((SALT311.StrType)le.total_calculated_value),TRIM((SALT311.StrType)le.src_total_calculated_value),TRIM((SALT311.StrType)le.tax_dt_total_calculated_value),TRIM((SALT311.StrType)le.total_land_value),TRIM((SALT311.StrType)le.src_total_land_value),TRIM((SALT311.StrType)le.tax_dt_total_land_value),TRIM((SALT311.StrType)le.total_market_value),TRIM((SALT311.StrType)le.src_total_market_value),TRIM((SALT311.StrType)le.tax_dt_total_market_value),TRIM((SALT311.StrType)le.floor_type),TRIM((SALT311.StrType)le.src_floor_type),TRIM((SALT311.StrType)le.tax_dt_floor_type),TRIM((SALT311.StrType)le.frame_type),TRIM((SALT311.StrType)le.src_frame_type),TRIM((SALT311.StrType)le.tax_dt_frame_type),TRIM((SALT311.StrType)le.fuel_type),TRIM((SALT311.StrType)le.src_fuel_type),TRIM((SALT311.StrType)le.tax_dt_fuel_type),TRIM((SALT311.StrType)le.no_of_bath_fixtures),TRIM((SALT311.StrType)le.src_no_of_bath_fixtures),TRIM((SALT311.StrType)le.tax_dt_no_of_bath_fixtures),TRIM((SALT311.StrType)le.no_of_rooms),TRIM((SALT311.StrType)le.src_no_of_rooms),TRIM((SALT311.StrType)le.tax_dt_no_of_rooms),TRIM((SALT311.StrType)le.no_of_units),TRIM((SALT311.StrType)le.src_no_of_units),TRIM((SALT311.StrType)le.tax_dt_no_of_units),TRIM((SALT311.StrType)le.style_type),TRIM((SALT311.StrType)le.src_style_type),TRIM((SALT311.StrType)le.tax_dt_style_type),TRIM((SALT311.StrType)le.assessment_document_number),TRIM((SALT311.StrType)le.src_assessment_document_number),TRIM((SALT311.StrType)le.tax_dt_assessment_document_number),TRIM((SALT311.StrType)le.assessment_recording_date),TRIM((SALT311.StrType)le.src_assessment_recording_date),TRIM((SALT311.StrType)le.tax_dt_assessment_recording_date),TRIM((SALT311.StrType)le.deed_document_number),TRIM((SALT311.StrType)le.src_deed_document_number),TRIM((SALT311.StrType)le.rec_dt_deed_document_number),TRIM((SALT311.StrType)le.deed_recording_date),TRIM((SALT311.StrType)le.src_deed_recording_date),TRIM((SALT311.StrType)le.full_part_sale),TRIM((SALT311.StrType)le.src_full_part_sale),TRIM((SALT311.StrType)le.rec_dt_full_part_sale),TRIM((SALT311.StrType)le.sale_amount),TRIM((SALT311.StrType)le.src_sale_amount),TRIM((SALT311.StrType)le.rec_dt_sale_amount),TRIM((SALT311.StrType)le.sale_date),TRIM((SALT311.StrType)le.src_sale_date),TRIM((SALT311.StrType)le.rec_dt_sale_date),TRIM((SALT311.StrType)le.sale_type_code),TRIM((SALT311.StrType)le.src_sale_type_code),TRIM((SALT311.StrType)le.rec_dt_sale_type_code),TRIM((SALT311.StrType)le.mortgage_company_name),TRIM((SALT311.StrType)le.src_mortgage_company_name),TRIM((SALT311.StrType)le.rec_dt_mortgage_company_name),TRIM((SALT311.StrType)le.loan_amount),TRIM((SALT311.StrType)le.src_loan_amount),TRIM((SALT311.StrType)le.rec_dt_loan_amount),TRIM((SALT311.StrType)le.second_loan_amount),TRIM((SALT311.StrType)le.src_second_loan_amount),TRIM((SALT311.StrType)le.rec_dt_second_loan_amount),TRIM((SALT311.StrType)le.loan_type_code),TRIM((SALT311.StrType)le.src_loan_type_code),TRIM((SALT311.StrType)le.rec_dt_loan_type_code),TRIM((SALT311.StrType)le.interest_rate_type_code),TRIM((SALT311.StrType)le.src_interest_rate_type_code),TRIM((SALT311.StrType)le.rec_dt_interest_rate_type_code)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,283,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 283);
  SELF.FldNo2 := 1 + (C % 283);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.property_rid),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.tax_sortby_date),TRIM((SALT311.StrType)le.deed_sortby_date),TRIM((SALT311.StrType)le.vendor_source),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.property_street_address),TRIM((SALT311.StrType)le.property_city_state_zip),TRIM((SALT311.StrType)le.property_raw_aid),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.building_square_footage),TRIM((SALT311.StrType)le.src_building_square_footage),TRIM((SALT311.StrType)le.tax_dt_building_square_footage),TRIM((SALT311.StrType)le.air_conditioning_type),TRIM((SALT311.StrType)le.src_air_conditioning_type),TRIM((SALT311.StrType)le.tax_dt_air_conditioning_type),TRIM((SALT311.StrType)le.basement_finish),TRIM((SALT311.StrType)le.src_basement_finish),TRIM((SALT311.StrType)le.tax_dt_basement_finish),TRIM((SALT311.StrType)le.construction_type),TRIM((SALT311.StrType)le.src_construction_type),TRIM((SALT311.StrType)le.tax_dt_construction_type),TRIM((SALT311.StrType)le.exterior_wall),TRIM((SALT311.StrType)le.src_exterior_wall),TRIM((SALT311.StrType)le.tax_dt_exterior_wall),TRIM((SALT311.StrType)le.fireplace_ind),TRIM((SALT311.StrType)le.src_fireplace_ind),TRIM((SALT311.StrType)le.tax_dt_fireplace_ind),TRIM((SALT311.StrType)le.fireplace_type),TRIM((SALT311.StrType)le.src_fireplace_type),TRIM((SALT311.StrType)le.tax_dt_fireplace_type),TRIM((SALT311.StrType)le.flood_zone_panel),TRIM((SALT311.StrType)le.src_flood_zone_panel),TRIM((SALT311.StrType)le.tax_dt_flood_zone_panel),TRIM((SALT311.StrType)le.garage),TRIM((SALT311.StrType)le.src_garage),TRIM((SALT311.StrType)le.tax_dt_garage),TRIM((SALT311.StrType)le.first_floor_square_footage),TRIM((SALT311.StrType)le.src_first_floor_square_footage),TRIM((SALT311.StrType)le.tax_dt_first_floor_square_footage),TRIM((SALT311.StrType)le.heating),TRIM((SALT311.StrType)le.src_heating),TRIM((SALT311.StrType)le.tax_dt_heating),TRIM((SALT311.StrType)le.living_area_square_footage),TRIM((SALT311.StrType)le.src_living_area_square_footage),TRIM((SALT311.StrType)le.tax_dt_living_area_square_footage),TRIM((SALT311.StrType)le.no_of_baths),TRIM((SALT311.StrType)le.src_no_of_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_baths),TRIM((SALT311.StrType)le.no_of_bedrooms),TRIM((SALT311.StrType)le.src_no_of_bedrooms),TRIM((SALT311.StrType)le.tax_dt_no_of_bedrooms),TRIM((SALT311.StrType)le.no_of_fireplaces),TRIM((SALT311.StrType)le.src_no_of_fireplaces),TRIM((SALT311.StrType)le.tax_dt_no_of_fireplaces),TRIM((SALT311.StrType)le.no_of_full_baths),TRIM((SALT311.StrType)le.src_no_of_full_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_full_baths),TRIM((SALT311.StrType)le.no_of_half_baths),TRIM((SALT311.StrType)le.src_no_of_half_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_half_baths),TRIM((SALT311.StrType)le.no_of_stories),TRIM((SALT311.StrType)le.src_no_of_stories),TRIM((SALT311.StrType)le.tax_dt_no_of_stories),TRIM((SALT311.StrType)le.parking_type),TRIM((SALT311.StrType)le.src_parking_type),TRIM((SALT311.StrType)le.tax_dt_parking_type),TRIM((SALT311.StrType)le.pool_indicator),TRIM((SALT311.StrType)le.src_pool_indicator),TRIM((SALT311.StrType)le.tax_dt_pool_indicator),TRIM((SALT311.StrType)le.pool_type),TRIM((SALT311.StrType)le.src_pool_type),TRIM((SALT311.StrType)le.tax_dt_pool_type),TRIM((SALT311.StrType)le.roof_cover),TRIM((SALT311.StrType)le.src_roof_cover),TRIM((SALT311.StrType)le.tax_dt_roof_cover),TRIM((SALT311.StrType)le.year_built),TRIM((SALT311.StrType)le.src_year_built),TRIM((SALT311.StrType)le.tax_dt_year_built),TRIM((SALT311.StrType)le.foundation),TRIM((SALT311.StrType)le.src_foundation),TRIM((SALT311.StrType)le.tax_dt_foundation),TRIM((SALT311.StrType)le.basement_square_footage),TRIM((SALT311.StrType)le.src_basement_square_footage),TRIM((SALT311.StrType)le.tax_dt_basement_square_footage),TRIM((SALT311.StrType)le.effective_year_built),TRIM((SALT311.StrType)le.src_effective_year_built),TRIM((SALT311.StrType)le.tax_dt_effective_year_built),TRIM((SALT311.StrType)le.garage_square_footage),TRIM((SALT311.StrType)le.src_garage_square_footage),TRIM((SALT311.StrType)le.tax_dt_garage_square_footage),TRIM((SALT311.StrType)le.stories_type),TRIM((SALT311.StrType)le.src_stories_type),TRIM((SALT311.StrType)le.tax_dt_stories_type),TRIM((SALT311.StrType)le.apn_number),TRIM((SALT311.StrType)le.src_apn_number),TRIM((SALT311.StrType)le.tax_dt_apn_number),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.src_census_tract),TRIM((SALT311.StrType)le.tax_dt_census_tract),TRIM((SALT311.StrType)le.range),TRIM((SALT311.StrType)le.src_range),TRIM((SALT311.StrType)le.tax_dt_range),TRIM((SALT311.StrType)le.zoning),TRIM((SALT311.StrType)le.src_zoning),TRIM((SALT311.StrType)le.tax_dt_zoning),TRIM((SALT311.StrType)le.block_number),TRIM((SALT311.StrType)le.src_block_number),TRIM((SALT311.StrType)le.tax_dt_block_number),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.src_county_name),TRIM((SALT311.StrType)le.tax_dt_county_name),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.src_fips_code),TRIM((SALT311.StrType)le.tax_dt_fips_code),TRIM((SALT311.StrType)le.subdivision),TRIM((SALT311.StrType)le.src_subdivision),TRIM((SALT311.StrType)le.tax_dt_subdivision),TRIM((SALT311.StrType)le.municipality),TRIM((SALT311.StrType)le.src_municipality),TRIM((SALT311.StrType)le.tax_dt_municipality),TRIM((SALT311.StrType)le.township),TRIM((SALT311.StrType)le.src_township),TRIM((SALT311.StrType)le.tax_dt_township),TRIM((SALT311.StrType)le.homestead_exemption_ind),TRIM((SALT311.StrType)le.src_homestead_exemption_ind),TRIM((SALT311.StrType)le.tax_dt_homestead_exemption_ind),TRIM((SALT311.StrType)le.land_use_code),TRIM((SALT311.StrType)le.src_land_use_code),TRIM((SALT311.StrType)le.tax_dt_land_use_code),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.src_latitude),TRIM((SALT311.StrType)le.tax_dt_latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.src_longitude),TRIM((SALT311.StrType)le.tax_dt_longitude),TRIM((SALT311.StrType)le.location_influence_code),TRIM((SALT311.StrType)le.src_location_influence_code),TRIM((SALT311.StrType)le.tax_dt_location_influence_code),TRIM((SALT311.StrType)le.acres),TRIM((SALT311.StrType)le.src_acres),TRIM((SALT311.StrType)le.tax_dt_acres),TRIM((SALT311.StrType)le.lot_depth_footage),TRIM((SALT311.StrType)le.src_lot_depth_footage),TRIM((SALT311.StrType)le.tax_dt_lot_depth_footage),TRIM((SALT311.StrType)le.lot_front_footage),TRIM((SALT311.StrType)le.src_lot_front_footage),TRIM((SALT311.StrType)le.tax_dt_lot_front_footage),TRIM((SALT311.StrType)le.lot_number),TRIM((SALT311.StrType)le.src_lot_number),TRIM((SALT311.StrType)le.tax_dt_lot_number),TRIM((SALT311.StrType)le.lot_size),TRIM((SALT311.StrType)le.src_lot_size),TRIM((SALT311.StrType)le.tax_dt_lot_size),TRIM((SALT311.StrType)le.property_type_code),TRIM((SALT311.StrType)le.src_property_type_code),TRIM((SALT311.StrType)le.tax_dt_property_type_code),TRIM((SALT311.StrType)le.structure_quality),TRIM((SALT311.StrType)le.src_structure_quality),TRIM((SALT311.StrType)le.tax_dt_structure_quality),TRIM((SALT311.StrType)le.water),TRIM((SALT311.StrType)le.src_water),TRIM((SALT311.StrType)le.tax_dt_water),TRIM((SALT311.StrType)le.sewer),TRIM((SALT311.StrType)le.src_sewer),TRIM((SALT311.StrType)le.tax_dt_sewer),TRIM((SALT311.StrType)le.assessed_land_value),TRIM((SALT311.StrType)le.src_assessed_land_value),TRIM((SALT311.StrType)le.tax_dt_assessed_land_value),TRIM((SALT311.StrType)le.assessed_year),TRIM((SALT311.StrType)le.src_assessed_year),TRIM((SALT311.StrType)le.tax_dt_assessed_year),TRIM((SALT311.StrType)le.tax_amount),TRIM((SALT311.StrType)le.src_tax_amount),TRIM((SALT311.StrType)le.tax_dt_tax_amount),TRIM((SALT311.StrType)le.tax_year),TRIM((SALT311.StrType)le.src_tax_year),TRIM((SALT311.StrType)le.market_land_value),TRIM((SALT311.StrType)le.src_market_land_value),TRIM((SALT311.StrType)le.tax_dt_market_land_value),TRIM((SALT311.StrType)le.improvement_value),TRIM((SALT311.StrType)le.src_improvement_value),TRIM((SALT311.StrType)le.tax_dt_improvement_value),TRIM((SALT311.StrType)le.percent_improved),TRIM((SALT311.StrType)le.src_percent_improved),TRIM((SALT311.StrType)le.tax_dt_percent_improved),TRIM((SALT311.StrType)le.total_assessed_value),TRIM((SALT311.StrType)le.src_total_assessed_value),TRIM((SALT311.StrType)le.tax_dt_total_assessed_value),TRIM((SALT311.StrType)le.total_calculated_value),TRIM((SALT311.StrType)le.src_total_calculated_value),TRIM((SALT311.StrType)le.tax_dt_total_calculated_value),TRIM((SALT311.StrType)le.total_land_value),TRIM((SALT311.StrType)le.src_total_land_value),TRIM((SALT311.StrType)le.tax_dt_total_land_value),TRIM((SALT311.StrType)le.total_market_value),TRIM((SALT311.StrType)le.src_total_market_value),TRIM((SALT311.StrType)le.tax_dt_total_market_value),TRIM((SALT311.StrType)le.floor_type),TRIM((SALT311.StrType)le.src_floor_type),TRIM((SALT311.StrType)le.tax_dt_floor_type),TRIM((SALT311.StrType)le.frame_type),TRIM((SALT311.StrType)le.src_frame_type),TRIM((SALT311.StrType)le.tax_dt_frame_type),TRIM((SALT311.StrType)le.fuel_type),TRIM((SALT311.StrType)le.src_fuel_type),TRIM((SALT311.StrType)le.tax_dt_fuel_type),TRIM((SALT311.StrType)le.no_of_bath_fixtures),TRIM((SALT311.StrType)le.src_no_of_bath_fixtures),TRIM((SALT311.StrType)le.tax_dt_no_of_bath_fixtures),TRIM((SALT311.StrType)le.no_of_rooms),TRIM((SALT311.StrType)le.src_no_of_rooms),TRIM((SALT311.StrType)le.tax_dt_no_of_rooms),TRIM((SALT311.StrType)le.no_of_units),TRIM((SALT311.StrType)le.src_no_of_units),TRIM((SALT311.StrType)le.tax_dt_no_of_units),TRIM((SALT311.StrType)le.style_type),TRIM((SALT311.StrType)le.src_style_type),TRIM((SALT311.StrType)le.tax_dt_style_type),TRIM((SALT311.StrType)le.assessment_document_number),TRIM((SALT311.StrType)le.src_assessment_document_number),TRIM((SALT311.StrType)le.tax_dt_assessment_document_number),TRIM((SALT311.StrType)le.assessment_recording_date),TRIM((SALT311.StrType)le.src_assessment_recording_date),TRIM((SALT311.StrType)le.tax_dt_assessment_recording_date),TRIM((SALT311.StrType)le.deed_document_number),TRIM((SALT311.StrType)le.src_deed_document_number),TRIM((SALT311.StrType)le.rec_dt_deed_document_number),TRIM((SALT311.StrType)le.deed_recording_date),TRIM((SALT311.StrType)le.src_deed_recording_date),TRIM((SALT311.StrType)le.full_part_sale),TRIM((SALT311.StrType)le.src_full_part_sale),TRIM((SALT311.StrType)le.rec_dt_full_part_sale),TRIM((SALT311.StrType)le.sale_amount),TRIM((SALT311.StrType)le.src_sale_amount),TRIM((SALT311.StrType)le.rec_dt_sale_amount),TRIM((SALT311.StrType)le.sale_date),TRIM((SALT311.StrType)le.src_sale_date),TRIM((SALT311.StrType)le.rec_dt_sale_date),TRIM((SALT311.StrType)le.sale_type_code),TRIM((SALT311.StrType)le.src_sale_type_code),TRIM((SALT311.StrType)le.rec_dt_sale_type_code),TRIM((SALT311.StrType)le.mortgage_company_name),TRIM((SALT311.StrType)le.src_mortgage_company_name),TRIM((SALT311.StrType)le.rec_dt_mortgage_company_name),TRIM((SALT311.StrType)le.loan_amount),TRIM((SALT311.StrType)le.src_loan_amount),TRIM((SALT311.StrType)le.rec_dt_loan_amount),TRIM((SALT311.StrType)le.second_loan_amount),TRIM((SALT311.StrType)le.src_second_loan_amount),TRIM((SALT311.StrType)le.rec_dt_second_loan_amount),TRIM((SALT311.StrType)le.loan_type_code),TRIM((SALT311.StrType)le.src_loan_type_code),TRIM((SALT311.StrType)le.rec_dt_loan_type_code),TRIM((SALT311.StrType)le.interest_rate_type_code),TRIM((SALT311.StrType)le.src_interest_rate_type_code),TRIM((SALT311.StrType)le.rec_dt_interest_rate_type_code)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.property_rid),TRIM((SALT311.StrType)le.dt_vendor_first_reported),TRIM((SALT311.StrType)le.dt_vendor_last_reported),TRIM((SALT311.StrType)le.tax_sortby_date),TRIM((SALT311.StrType)le.deed_sortby_date),TRIM((SALT311.StrType)le.vendor_source),TRIM((SALT311.StrType)le.fares_unformatted_apn),TRIM((SALT311.StrType)le.property_street_address),TRIM((SALT311.StrType)le.property_city_state_zip),TRIM((SALT311.StrType)le.property_raw_aid),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.building_square_footage),TRIM((SALT311.StrType)le.src_building_square_footage),TRIM((SALT311.StrType)le.tax_dt_building_square_footage),TRIM((SALT311.StrType)le.air_conditioning_type),TRIM((SALT311.StrType)le.src_air_conditioning_type),TRIM((SALT311.StrType)le.tax_dt_air_conditioning_type),TRIM((SALT311.StrType)le.basement_finish),TRIM((SALT311.StrType)le.src_basement_finish),TRIM((SALT311.StrType)le.tax_dt_basement_finish),TRIM((SALT311.StrType)le.construction_type),TRIM((SALT311.StrType)le.src_construction_type),TRIM((SALT311.StrType)le.tax_dt_construction_type),TRIM((SALT311.StrType)le.exterior_wall),TRIM((SALT311.StrType)le.src_exterior_wall),TRIM((SALT311.StrType)le.tax_dt_exterior_wall),TRIM((SALT311.StrType)le.fireplace_ind),TRIM((SALT311.StrType)le.src_fireplace_ind),TRIM((SALT311.StrType)le.tax_dt_fireplace_ind),TRIM((SALT311.StrType)le.fireplace_type),TRIM((SALT311.StrType)le.src_fireplace_type),TRIM((SALT311.StrType)le.tax_dt_fireplace_type),TRIM((SALT311.StrType)le.flood_zone_panel),TRIM((SALT311.StrType)le.src_flood_zone_panel),TRIM((SALT311.StrType)le.tax_dt_flood_zone_panel),TRIM((SALT311.StrType)le.garage),TRIM((SALT311.StrType)le.src_garage),TRIM((SALT311.StrType)le.tax_dt_garage),TRIM((SALT311.StrType)le.first_floor_square_footage),TRIM((SALT311.StrType)le.src_first_floor_square_footage),TRIM((SALT311.StrType)le.tax_dt_first_floor_square_footage),TRIM((SALT311.StrType)le.heating),TRIM((SALT311.StrType)le.src_heating),TRIM((SALT311.StrType)le.tax_dt_heating),TRIM((SALT311.StrType)le.living_area_square_footage),TRIM((SALT311.StrType)le.src_living_area_square_footage),TRIM((SALT311.StrType)le.tax_dt_living_area_square_footage),TRIM((SALT311.StrType)le.no_of_baths),TRIM((SALT311.StrType)le.src_no_of_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_baths),TRIM((SALT311.StrType)le.no_of_bedrooms),TRIM((SALT311.StrType)le.src_no_of_bedrooms),TRIM((SALT311.StrType)le.tax_dt_no_of_bedrooms),TRIM((SALT311.StrType)le.no_of_fireplaces),TRIM((SALT311.StrType)le.src_no_of_fireplaces),TRIM((SALT311.StrType)le.tax_dt_no_of_fireplaces),TRIM((SALT311.StrType)le.no_of_full_baths),TRIM((SALT311.StrType)le.src_no_of_full_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_full_baths),TRIM((SALT311.StrType)le.no_of_half_baths),TRIM((SALT311.StrType)le.src_no_of_half_baths),TRIM((SALT311.StrType)le.tax_dt_no_of_half_baths),TRIM((SALT311.StrType)le.no_of_stories),TRIM((SALT311.StrType)le.src_no_of_stories),TRIM((SALT311.StrType)le.tax_dt_no_of_stories),TRIM((SALT311.StrType)le.parking_type),TRIM((SALT311.StrType)le.src_parking_type),TRIM((SALT311.StrType)le.tax_dt_parking_type),TRIM((SALT311.StrType)le.pool_indicator),TRIM((SALT311.StrType)le.src_pool_indicator),TRIM((SALT311.StrType)le.tax_dt_pool_indicator),TRIM((SALT311.StrType)le.pool_type),TRIM((SALT311.StrType)le.src_pool_type),TRIM((SALT311.StrType)le.tax_dt_pool_type),TRIM((SALT311.StrType)le.roof_cover),TRIM((SALT311.StrType)le.src_roof_cover),TRIM((SALT311.StrType)le.tax_dt_roof_cover),TRIM((SALT311.StrType)le.year_built),TRIM((SALT311.StrType)le.src_year_built),TRIM((SALT311.StrType)le.tax_dt_year_built),TRIM((SALT311.StrType)le.foundation),TRIM((SALT311.StrType)le.src_foundation),TRIM((SALT311.StrType)le.tax_dt_foundation),TRIM((SALT311.StrType)le.basement_square_footage),TRIM((SALT311.StrType)le.src_basement_square_footage),TRIM((SALT311.StrType)le.tax_dt_basement_square_footage),TRIM((SALT311.StrType)le.effective_year_built),TRIM((SALT311.StrType)le.src_effective_year_built),TRIM((SALT311.StrType)le.tax_dt_effective_year_built),TRIM((SALT311.StrType)le.garage_square_footage),TRIM((SALT311.StrType)le.src_garage_square_footage),TRIM((SALT311.StrType)le.tax_dt_garage_square_footage),TRIM((SALT311.StrType)le.stories_type),TRIM((SALT311.StrType)le.src_stories_type),TRIM((SALT311.StrType)le.tax_dt_stories_type),TRIM((SALT311.StrType)le.apn_number),TRIM((SALT311.StrType)le.src_apn_number),TRIM((SALT311.StrType)le.tax_dt_apn_number),TRIM((SALT311.StrType)le.census_tract),TRIM((SALT311.StrType)le.src_census_tract),TRIM((SALT311.StrType)le.tax_dt_census_tract),TRIM((SALT311.StrType)le.range),TRIM((SALT311.StrType)le.src_range),TRIM((SALT311.StrType)le.tax_dt_range),TRIM((SALT311.StrType)le.zoning),TRIM((SALT311.StrType)le.src_zoning),TRIM((SALT311.StrType)le.tax_dt_zoning),TRIM((SALT311.StrType)le.block_number),TRIM((SALT311.StrType)le.src_block_number),TRIM((SALT311.StrType)le.tax_dt_block_number),TRIM((SALT311.StrType)le.county_name),TRIM((SALT311.StrType)le.src_county_name),TRIM((SALT311.StrType)le.tax_dt_county_name),TRIM((SALT311.StrType)le.fips_code),TRIM((SALT311.StrType)le.src_fips_code),TRIM((SALT311.StrType)le.tax_dt_fips_code),TRIM((SALT311.StrType)le.subdivision),TRIM((SALT311.StrType)le.src_subdivision),TRIM((SALT311.StrType)le.tax_dt_subdivision),TRIM((SALT311.StrType)le.municipality),TRIM((SALT311.StrType)le.src_municipality),TRIM((SALT311.StrType)le.tax_dt_municipality),TRIM((SALT311.StrType)le.township),TRIM((SALT311.StrType)le.src_township),TRIM((SALT311.StrType)le.tax_dt_township),TRIM((SALT311.StrType)le.homestead_exemption_ind),TRIM((SALT311.StrType)le.src_homestead_exemption_ind),TRIM((SALT311.StrType)le.tax_dt_homestead_exemption_ind),TRIM((SALT311.StrType)le.land_use_code),TRIM((SALT311.StrType)le.src_land_use_code),TRIM((SALT311.StrType)le.tax_dt_land_use_code),TRIM((SALT311.StrType)le.latitude),TRIM((SALT311.StrType)le.src_latitude),TRIM((SALT311.StrType)le.tax_dt_latitude),TRIM((SALT311.StrType)le.longitude),TRIM((SALT311.StrType)le.src_longitude),TRIM((SALT311.StrType)le.tax_dt_longitude),TRIM((SALT311.StrType)le.location_influence_code),TRIM((SALT311.StrType)le.src_location_influence_code),TRIM((SALT311.StrType)le.tax_dt_location_influence_code),TRIM((SALT311.StrType)le.acres),TRIM((SALT311.StrType)le.src_acres),TRIM((SALT311.StrType)le.tax_dt_acres),TRIM((SALT311.StrType)le.lot_depth_footage),TRIM((SALT311.StrType)le.src_lot_depth_footage),TRIM((SALT311.StrType)le.tax_dt_lot_depth_footage),TRIM((SALT311.StrType)le.lot_front_footage),TRIM((SALT311.StrType)le.src_lot_front_footage),TRIM((SALT311.StrType)le.tax_dt_lot_front_footage),TRIM((SALT311.StrType)le.lot_number),TRIM((SALT311.StrType)le.src_lot_number),TRIM((SALT311.StrType)le.tax_dt_lot_number),TRIM((SALT311.StrType)le.lot_size),TRIM((SALT311.StrType)le.src_lot_size),TRIM((SALT311.StrType)le.tax_dt_lot_size),TRIM((SALT311.StrType)le.property_type_code),TRIM((SALT311.StrType)le.src_property_type_code),TRIM((SALT311.StrType)le.tax_dt_property_type_code),TRIM((SALT311.StrType)le.structure_quality),TRIM((SALT311.StrType)le.src_structure_quality),TRIM((SALT311.StrType)le.tax_dt_structure_quality),TRIM((SALT311.StrType)le.water),TRIM((SALT311.StrType)le.src_water),TRIM((SALT311.StrType)le.tax_dt_water),TRIM((SALT311.StrType)le.sewer),TRIM((SALT311.StrType)le.src_sewer),TRIM((SALT311.StrType)le.tax_dt_sewer),TRIM((SALT311.StrType)le.assessed_land_value),TRIM((SALT311.StrType)le.src_assessed_land_value),TRIM((SALT311.StrType)le.tax_dt_assessed_land_value),TRIM((SALT311.StrType)le.assessed_year),TRIM((SALT311.StrType)le.src_assessed_year),TRIM((SALT311.StrType)le.tax_dt_assessed_year),TRIM((SALT311.StrType)le.tax_amount),TRIM((SALT311.StrType)le.src_tax_amount),TRIM((SALT311.StrType)le.tax_dt_tax_amount),TRIM((SALT311.StrType)le.tax_year),TRIM((SALT311.StrType)le.src_tax_year),TRIM((SALT311.StrType)le.market_land_value),TRIM((SALT311.StrType)le.src_market_land_value),TRIM((SALT311.StrType)le.tax_dt_market_land_value),TRIM((SALT311.StrType)le.improvement_value),TRIM((SALT311.StrType)le.src_improvement_value),TRIM((SALT311.StrType)le.tax_dt_improvement_value),TRIM((SALT311.StrType)le.percent_improved),TRIM((SALT311.StrType)le.src_percent_improved),TRIM((SALT311.StrType)le.tax_dt_percent_improved),TRIM((SALT311.StrType)le.total_assessed_value),TRIM((SALT311.StrType)le.src_total_assessed_value),TRIM((SALT311.StrType)le.tax_dt_total_assessed_value),TRIM((SALT311.StrType)le.total_calculated_value),TRIM((SALT311.StrType)le.src_total_calculated_value),TRIM((SALT311.StrType)le.tax_dt_total_calculated_value),TRIM((SALT311.StrType)le.total_land_value),TRIM((SALT311.StrType)le.src_total_land_value),TRIM((SALT311.StrType)le.tax_dt_total_land_value),TRIM((SALT311.StrType)le.total_market_value),TRIM((SALT311.StrType)le.src_total_market_value),TRIM((SALT311.StrType)le.tax_dt_total_market_value),TRIM((SALT311.StrType)le.floor_type),TRIM((SALT311.StrType)le.src_floor_type),TRIM((SALT311.StrType)le.tax_dt_floor_type),TRIM((SALT311.StrType)le.frame_type),TRIM((SALT311.StrType)le.src_frame_type),TRIM((SALT311.StrType)le.tax_dt_frame_type),TRIM((SALT311.StrType)le.fuel_type),TRIM((SALT311.StrType)le.src_fuel_type),TRIM((SALT311.StrType)le.tax_dt_fuel_type),TRIM((SALT311.StrType)le.no_of_bath_fixtures),TRIM((SALT311.StrType)le.src_no_of_bath_fixtures),TRIM((SALT311.StrType)le.tax_dt_no_of_bath_fixtures),TRIM((SALT311.StrType)le.no_of_rooms),TRIM((SALT311.StrType)le.src_no_of_rooms),TRIM((SALT311.StrType)le.tax_dt_no_of_rooms),TRIM((SALT311.StrType)le.no_of_units),TRIM((SALT311.StrType)le.src_no_of_units),TRIM((SALT311.StrType)le.tax_dt_no_of_units),TRIM((SALT311.StrType)le.style_type),TRIM((SALT311.StrType)le.src_style_type),TRIM((SALT311.StrType)le.tax_dt_style_type),TRIM((SALT311.StrType)le.assessment_document_number),TRIM((SALT311.StrType)le.src_assessment_document_number),TRIM((SALT311.StrType)le.tax_dt_assessment_document_number),TRIM((SALT311.StrType)le.assessment_recording_date),TRIM((SALT311.StrType)le.src_assessment_recording_date),TRIM((SALT311.StrType)le.tax_dt_assessment_recording_date),TRIM((SALT311.StrType)le.deed_document_number),TRIM((SALT311.StrType)le.src_deed_document_number),TRIM((SALT311.StrType)le.rec_dt_deed_document_number),TRIM((SALT311.StrType)le.deed_recording_date),TRIM((SALT311.StrType)le.src_deed_recording_date),TRIM((SALT311.StrType)le.full_part_sale),TRIM((SALT311.StrType)le.src_full_part_sale),TRIM((SALT311.StrType)le.rec_dt_full_part_sale),TRIM((SALT311.StrType)le.sale_amount),TRIM((SALT311.StrType)le.src_sale_amount),TRIM((SALT311.StrType)le.rec_dt_sale_amount),TRIM((SALT311.StrType)le.sale_date),TRIM((SALT311.StrType)le.src_sale_date),TRIM((SALT311.StrType)le.rec_dt_sale_date),TRIM((SALT311.StrType)le.sale_type_code),TRIM((SALT311.StrType)le.src_sale_type_code),TRIM((SALT311.StrType)le.rec_dt_sale_type_code),TRIM((SALT311.StrType)le.mortgage_company_name),TRIM((SALT311.StrType)le.src_mortgage_company_name),TRIM((SALT311.StrType)le.rec_dt_mortgage_company_name),TRIM((SALT311.StrType)le.loan_amount),TRIM((SALT311.StrType)le.src_loan_amount),TRIM((SALT311.StrType)le.rec_dt_loan_amount),TRIM((SALT311.StrType)le.second_loan_amount),TRIM((SALT311.StrType)le.src_second_loan_amount),TRIM((SALT311.StrType)le.rec_dt_second_loan_amount),TRIM((SALT311.StrType)le.loan_type_code),TRIM((SALT311.StrType)le.src_loan_type_code),TRIM((SALT311.StrType)le.rec_dt_loan_type_code),TRIM((SALT311.StrType)le.interest_rate_type_code),TRIM((SALT311.StrType)le.src_interest_rate_type_code),TRIM((SALT311.StrType)le.rec_dt_interest_rate_type_code)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),283*283,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'property_rid'}
      ,{2,'dt_vendor_first_reported'}
      ,{3,'dt_vendor_last_reported'}
      ,{4,'tax_sortby_date'}
      ,{5,'deed_sortby_date'}
      ,{6,'vendor_source'}
      ,{7,'fares_unformatted_apn'}
      ,{8,'property_street_address'}
      ,{9,'property_city_state_zip'}
      ,{10,'property_raw_aid'}
      ,{11,'prim_range'}
      ,{12,'predir'}
      ,{13,'prim_name'}
      ,{14,'addr_suffix'}
      ,{15,'postdir'}
      ,{16,'unit_desig'}
      ,{17,'sec_range'}
      ,{18,'p_city_name'}
      ,{19,'v_city_name'}
      ,{20,'st'}
      ,{21,'zip'}
      ,{22,'zip4'}
      ,{23,'cart'}
      ,{24,'cr_sort_sz'}
      ,{25,'lot'}
      ,{26,'lot_order'}
      ,{27,'dbpc'}
      ,{28,'chk_digit'}
      ,{29,'rec_type'}
      ,{30,'county'}
      ,{31,'geo_lat'}
      ,{32,'geo_long'}
      ,{33,'msa'}
      ,{34,'geo_blk'}
      ,{35,'geo_match'}
      ,{36,'err_stat'}
      ,{37,'building_square_footage'}
      ,{38,'src_building_square_footage'}
      ,{39,'tax_dt_building_square_footage'}
      ,{40,'air_conditioning_type'}
      ,{41,'src_air_conditioning_type'}
      ,{42,'tax_dt_air_conditioning_type'}
      ,{43,'basement_finish'}
      ,{44,'src_basement_finish'}
      ,{45,'tax_dt_basement_finish'}
      ,{46,'construction_type'}
      ,{47,'src_construction_type'}
      ,{48,'tax_dt_construction_type'}
      ,{49,'exterior_wall'}
      ,{50,'src_exterior_wall'}
      ,{51,'tax_dt_exterior_wall'}
      ,{52,'fireplace_ind'}
      ,{53,'src_fireplace_ind'}
      ,{54,'tax_dt_fireplace_ind'}
      ,{55,'fireplace_type'}
      ,{56,'src_fireplace_type'}
      ,{57,'tax_dt_fireplace_type'}
      ,{58,'flood_zone_panel'}
      ,{59,'src_flood_zone_panel'}
      ,{60,'tax_dt_flood_zone_panel'}
      ,{61,'garage'}
      ,{62,'src_garage'}
      ,{63,'tax_dt_garage'}
      ,{64,'first_floor_square_footage'}
      ,{65,'src_first_floor_square_footage'}
      ,{66,'tax_dt_first_floor_square_footage'}
      ,{67,'heating'}
      ,{68,'src_heating'}
      ,{69,'tax_dt_heating'}
      ,{70,'living_area_square_footage'}
      ,{71,'src_living_area_square_footage'}
      ,{72,'tax_dt_living_area_square_footage'}
      ,{73,'no_of_baths'}
      ,{74,'src_no_of_baths'}
      ,{75,'tax_dt_no_of_baths'}
      ,{76,'no_of_bedrooms'}
      ,{77,'src_no_of_bedrooms'}
      ,{78,'tax_dt_no_of_bedrooms'}
      ,{79,'no_of_fireplaces'}
      ,{80,'src_no_of_fireplaces'}
      ,{81,'tax_dt_no_of_fireplaces'}
      ,{82,'no_of_full_baths'}
      ,{83,'src_no_of_full_baths'}
      ,{84,'tax_dt_no_of_full_baths'}
      ,{85,'no_of_half_baths'}
      ,{86,'src_no_of_half_baths'}
      ,{87,'tax_dt_no_of_half_baths'}
      ,{88,'no_of_stories'}
      ,{89,'src_no_of_stories'}
      ,{90,'tax_dt_no_of_stories'}
      ,{91,'parking_type'}
      ,{92,'src_parking_type'}
      ,{93,'tax_dt_parking_type'}
      ,{94,'pool_indicator'}
      ,{95,'src_pool_indicator'}
      ,{96,'tax_dt_pool_indicator'}
      ,{97,'pool_type'}
      ,{98,'src_pool_type'}
      ,{99,'tax_dt_pool_type'}
      ,{100,'roof_cover'}
      ,{101,'src_roof_cover'}
      ,{102,'tax_dt_roof_cover'}
      ,{103,'year_built'}
      ,{104,'src_year_built'}
      ,{105,'tax_dt_year_built'}
      ,{106,'foundation'}
      ,{107,'src_foundation'}
      ,{108,'tax_dt_foundation'}
      ,{109,'basement_square_footage'}
      ,{110,'src_basement_square_footage'}
      ,{111,'tax_dt_basement_square_footage'}
      ,{112,'effective_year_built'}
      ,{113,'src_effective_year_built'}
      ,{114,'tax_dt_effective_year_built'}
      ,{115,'garage_square_footage'}
      ,{116,'src_garage_square_footage'}
      ,{117,'tax_dt_garage_square_footage'}
      ,{118,'stories_type'}
      ,{119,'src_stories_type'}
      ,{120,'tax_dt_stories_type'}
      ,{121,'apn_number'}
      ,{122,'src_apn_number'}
      ,{123,'tax_dt_apn_number'}
      ,{124,'census_tract'}
      ,{125,'src_census_tract'}
      ,{126,'tax_dt_census_tract'}
      ,{127,'range'}
      ,{128,'src_range'}
      ,{129,'tax_dt_range'}
      ,{130,'zoning'}
      ,{131,'src_zoning'}
      ,{132,'tax_dt_zoning'}
      ,{133,'block_number'}
      ,{134,'src_block_number'}
      ,{135,'tax_dt_block_number'}
      ,{136,'county_name'}
      ,{137,'src_county_name'}
      ,{138,'tax_dt_county_name'}
      ,{139,'fips_code'}
      ,{140,'src_fips_code'}
      ,{141,'tax_dt_fips_code'}
      ,{142,'subdivision'}
      ,{143,'src_subdivision'}
      ,{144,'tax_dt_subdivision'}
      ,{145,'municipality'}
      ,{146,'src_municipality'}
      ,{147,'tax_dt_municipality'}
      ,{148,'township'}
      ,{149,'src_township'}
      ,{150,'tax_dt_township'}
      ,{151,'homestead_exemption_ind'}
      ,{152,'src_homestead_exemption_ind'}
      ,{153,'tax_dt_homestead_exemption_ind'}
      ,{154,'land_use_code'}
      ,{155,'src_land_use_code'}
      ,{156,'tax_dt_land_use_code'}
      ,{157,'latitude'}
      ,{158,'src_latitude'}
      ,{159,'tax_dt_latitude'}
      ,{160,'longitude'}
      ,{161,'src_longitude'}
      ,{162,'tax_dt_longitude'}
      ,{163,'location_influence_code'}
      ,{164,'src_location_influence_code'}
      ,{165,'tax_dt_location_influence_code'}
      ,{166,'acres'}
      ,{167,'src_acres'}
      ,{168,'tax_dt_acres'}
      ,{169,'lot_depth_footage'}
      ,{170,'src_lot_depth_footage'}
      ,{171,'tax_dt_lot_depth_footage'}
      ,{172,'lot_front_footage'}
      ,{173,'src_lot_front_footage'}
      ,{174,'tax_dt_lot_front_footage'}
      ,{175,'lot_number'}
      ,{176,'src_lot_number'}
      ,{177,'tax_dt_lot_number'}
      ,{178,'lot_size'}
      ,{179,'src_lot_size'}
      ,{180,'tax_dt_lot_size'}
      ,{181,'property_type_code'}
      ,{182,'src_property_type_code'}
      ,{183,'tax_dt_property_type_code'}
      ,{184,'structure_quality'}
      ,{185,'src_structure_quality'}
      ,{186,'tax_dt_structure_quality'}
      ,{187,'water'}
      ,{188,'src_water'}
      ,{189,'tax_dt_water'}
      ,{190,'sewer'}
      ,{191,'src_sewer'}
      ,{192,'tax_dt_sewer'}
      ,{193,'assessed_land_value'}
      ,{194,'src_assessed_land_value'}
      ,{195,'tax_dt_assessed_land_value'}
      ,{196,'assessed_year'}
      ,{197,'src_assessed_year'}
      ,{198,'tax_dt_assessed_year'}
      ,{199,'tax_amount'}
      ,{200,'src_tax_amount'}
      ,{201,'tax_dt_tax_amount'}
      ,{202,'tax_year'}
      ,{203,'src_tax_year'}
      ,{204,'market_land_value'}
      ,{205,'src_market_land_value'}
      ,{206,'tax_dt_market_land_value'}
      ,{207,'improvement_value'}
      ,{208,'src_improvement_value'}
      ,{209,'tax_dt_improvement_value'}
      ,{210,'percent_improved'}
      ,{211,'src_percent_improved'}
      ,{212,'tax_dt_percent_improved'}
      ,{213,'total_assessed_value'}
      ,{214,'src_total_assessed_value'}
      ,{215,'tax_dt_total_assessed_value'}
      ,{216,'total_calculated_value'}
      ,{217,'src_total_calculated_value'}
      ,{218,'tax_dt_total_calculated_value'}
      ,{219,'total_land_value'}
      ,{220,'src_total_land_value'}
      ,{221,'tax_dt_total_land_value'}
      ,{222,'total_market_value'}
      ,{223,'src_total_market_value'}
      ,{224,'tax_dt_total_market_value'}
      ,{225,'floor_type'}
      ,{226,'src_floor_type'}
      ,{227,'tax_dt_floor_type'}
      ,{228,'frame_type'}
      ,{229,'src_frame_type'}
      ,{230,'tax_dt_frame_type'}
      ,{231,'fuel_type'}
      ,{232,'src_fuel_type'}
      ,{233,'tax_dt_fuel_type'}
      ,{234,'no_of_bath_fixtures'}
      ,{235,'src_no_of_bath_fixtures'}
      ,{236,'tax_dt_no_of_bath_fixtures'}
      ,{237,'no_of_rooms'}
      ,{238,'src_no_of_rooms'}
      ,{239,'tax_dt_no_of_rooms'}
      ,{240,'no_of_units'}
      ,{241,'src_no_of_units'}
      ,{242,'tax_dt_no_of_units'}
      ,{243,'style_type'}
      ,{244,'src_style_type'}
      ,{245,'tax_dt_style_type'}
      ,{246,'assessment_document_number'}
      ,{247,'src_assessment_document_number'}
      ,{248,'tax_dt_assessment_document_number'}
      ,{249,'assessment_recording_date'}
      ,{250,'src_assessment_recording_date'}
      ,{251,'tax_dt_assessment_recording_date'}
      ,{252,'deed_document_number'}
      ,{253,'src_deed_document_number'}
      ,{254,'rec_dt_deed_document_number'}
      ,{255,'deed_recording_date'}
      ,{256,'src_deed_recording_date'}
      ,{257,'full_part_sale'}
      ,{258,'src_full_part_sale'}
      ,{259,'rec_dt_full_part_sale'}
      ,{260,'sale_amount'}
      ,{261,'src_sale_amount'}
      ,{262,'rec_dt_sale_amount'}
      ,{263,'sale_date'}
      ,{264,'src_sale_date'}
      ,{265,'rec_dt_sale_date'}
      ,{266,'sale_type_code'}
      ,{267,'src_sale_type_code'}
      ,{268,'rec_dt_sale_type_code'}
      ,{269,'mortgage_company_name'}
      ,{270,'src_mortgage_company_name'}
      ,{271,'rec_dt_mortgage_company_name'}
      ,{272,'loan_amount'}
      ,{273,'src_loan_amount'}
      ,{274,'rec_dt_loan_amount'}
      ,{275,'second_loan_amount'}
      ,{276,'src_second_loan_amount'}
      ,{277,'rec_dt_second_loan_amount'}
      ,{278,'loan_type_code'}
      ,{279,'src_loan_type_code'}
      ,{280,'rec_dt_loan_type_code'}
      ,{281,'interest_rate_type_code'}
      ,{282,'src_interest_rate_type_code'}
      ,{283,'rec_dt_interest_rate_type_code'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED2 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.vendor_source) vendor_source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED2 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_property_rid((SALT311.StrType)le.property_rid),
    Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Fields.InValid_tax_sortby_date((SALT311.StrType)le.tax_sortby_date),
    Fields.InValid_deed_sortby_date((SALT311.StrType)le.deed_sortby_date),
    Fields.InValid_vendor_source((SALT311.StrType)le.vendor_source),
    Fields.InValid_fares_unformatted_apn((SALT311.StrType)le.fares_unformatted_apn),
    Fields.InValid_property_street_address((SALT311.StrType)le.property_street_address),
    Fields.InValid_property_city_state_zip((SALT311.StrType)le.property_city_state_zip),
    Fields.InValid_property_raw_aid((SALT311.StrType)le.property_raw_aid),
    Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Fields.InValid_predir((SALT311.StrType)le.predir),
    Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
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
    Fields.InValid_building_square_footage((SALT311.StrType)le.building_square_footage),
    Fields.InValid_src_building_square_footage((SALT311.StrType)le.src_building_square_footage),
    Fields.InValid_tax_dt_building_square_footage((SALT311.StrType)le.tax_dt_building_square_footage),
    Fields.InValid_air_conditioning_type((SALT311.StrType)le.air_conditioning_type),
    Fields.InValid_src_air_conditioning_type((SALT311.StrType)le.src_air_conditioning_type),
    Fields.InValid_tax_dt_air_conditioning_type((SALT311.StrType)le.tax_dt_air_conditioning_type),
    Fields.InValid_basement_finish((SALT311.StrType)le.basement_finish),
    Fields.InValid_src_basement_finish((SALT311.StrType)le.src_basement_finish),
    Fields.InValid_tax_dt_basement_finish((SALT311.StrType)le.tax_dt_basement_finish),
    Fields.InValid_construction_type((SALT311.StrType)le.construction_type),
    Fields.InValid_src_construction_type((SALT311.StrType)le.src_construction_type),
    Fields.InValid_tax_dt_construction_type((SALT311.StrType)le.tax_dt_construction_type),
    Fields.InValid_exterior_wall((SALT311.StrType)le.exterior_wall),
    Fields.InValid_src_exterior_wall((SALT311.StrType)le.src_exterior_wall),
    Fields.InValid_tax_dt_exterior_wall((SALT311.StrType)le.tax_dt_exterior_wall),
    Fields.InValid_fireplace_ind((SALT311.StrType)le.fireplace_ind),
    Fields.InValid_src_fireplace_ind((SALT311.StrType)le.src_fireplace_ind),
    Fields.InValid_tax_dt_fireplace_ind((SALT311.StrType)le.tax_dt_fireplace_ind),
    Fields.InValid_fireplace_type((SALT311.StrType)le.fireplace_type),
    Fields.InValid_src_fireplace_type((SALT311.StrType)le.src_fireplace_type),
    Fields.InValid_tax_dt_fireplace_type((SALT311.StrType)le.tax_dt_fireplace_type),
    Fields.InValid_flood_zone_panel((SALT311.StrType)le.flood_zone_panel),
    Fields.InValid_src_flood_zone_panel((SALT311.StrType)le.src_flood_zone_panel),
    Fields.InValid_tax_dt_flood_zone_panel((SALT311.StrType)le.tax_dt_flood_zone_panel),
    Fields.InValid_garage((SALT311.StrType)le.garage),
    Fields.InValid_src_garage((SALT311.StrType)le.src_garage),
    Fields.InValid_tax_dt_garage((SALT311.StrType)le.tax_dt_garage),
    Fields.InValid_first_floor_square_footage((SALT311.StrType)le.first_floor_square_footage),
    Fields.InValid_src_first_floor_square_footage((SALT311.StrType)le.src_first_floor_square_footage),
    Fields.InValid_tax_dt_first_floor_square_footage((SALT311.StrType)le.tax_dt_first_floor_square_footage),
    Fields.InValid_heating((SALT311.StrType)le.heating),
    Fields.InValid_src_heating((SALT311.StrType)le.src_heating),
    Fields.InValid_tax_dt_heating((SALT311.StrType)le.tax_dt_heating),
    Fields.InValid_living_area_square_footage((SALT311.StrType)le.living_area_square_footage),
    Fields.InValid_src_living_area_square_footage((SALT311.StrType)le.src_living_area_square_footage),
    Fields.InValid_tax_dt_living_area_square_footage((SALT311.StrType)le.tax_dt_living_area_square_footage),
    Fields.InValid_no_of_baths((SALT311.StrType)le.no_of_baths),
    Fields.InValid_src_no_of_baths((SALT311.StrType)le.src_no_of_baths),
    Fields.InValid_tax_dt_no_of_baths((SALT311.StrType)le.tax_dt_no_of_baths),
    Fields.InValid_no_of_bedrooms((SALT311.StrType)le.no_of_bedrooms),
    Fields.InValid_src_no_of_bedrooms((SALT311.StrType)le.src_no_of_bedrooms),
    Fields.InValid_tax_dt_no_of_bedrooms((SALT311.StrType)le.tax_dt_no_of_bedrooms),
    Fields.InValid_no_of_fireplaces((SALT311.StrType)le.no_of_fireplaces),
    Fields.InValid_src_no_of_fireplaces((SALT311.StrType)le.src_no_of_fireplaces),
    Fields.InValid_tax_dt_no_of_fireplaces((SALT311.StrType)le.tax_dt_no_of_fireplaces),
    Fields.InValid_no_of_full_baths((SALT311.StrType)le.no_of_full_baths),
    Fields.InValid_src_no_of_full_baths((SALT311.StrType)le.src_no_of_full_baths),
    Fields.InValid_tax_dt_no_of_full_baths((SALT311.StrType)le.tax_dt_no_of_full_baths),
    Fields.InValid_no_of_half_baths((SALT311.StrType)le.no_of_half_baths),
    Fields.InValid_src_no_of_half_baths((SALT311.StrType)le.src_no_of_half_baths),
    Fields.InValid_tax_dt_no_of_half_baths((SALT311.StrType)le.tax_dt_no_of_half_baths),
    Fields.InValid_no_of_stories((SALT311.StrType)le.no_of_stories),
    Fields.InValid_src_no_of_stories((SALT311.StrType)le.src_no_of_stories),
    Fields.InValid_tax_dt_no_of_stories((SALT311.StrType)le.tax_dt_no_of_stories),
    Fields.InValid_parking_type((SALT311.StrType)le.parking_type),
    Fields.InValid_src_parking_type((SALT311.StrType)le.src_parking_type),
    Fields.InValid_tax_dt_parking_type((SALT311.StrType)le.tax_dt_parking_type),
    Fields.InValid_pool_indicator((SALT311.StrType)le.pool_indicator),
    Fields.InValid_src_pool_indicator((SALT311.StrType)le.src_pool_indicator),
    Fields.InValid_tax_dt_pool_indicator((SALT311.StrType)le.tax_dt_pool_indicator),
    Fields.InValid_pool_type((SALT311.StrType)le.pool_type),
    Fields.InValid_src_pool_type((SALT311.StrType)le.src_pool_type),
    Fields.InValid_tax_dt_pool_type((SALT311.StrType)le.tax_dt_pool_type),
    Fields.InValid_roof_cover((SALT311.StrType)le.roof_cover),
    Fields.InValid_src_roof_cover((SALT311.StrType)le.src_roof_cover),
    Fields.InValid_tax_dt_roof_cover((SALT311.StrType)le.tax_dt_roof_cover),
    Fields.InValid_year_built((SALT311.StrType)le.year_built),
    Fields.InValid_src_year_built((SALT311.StrType)le.src_year_built),
    Fields.InValid_tax_dt_year_built((SALT311.StrType)le.tax_dt_year_built),
    Fields.InValid_foundation((SALT311.StrType)le.foundation),
    Fields.InValid_src_foundation((SALT311.StrType)le.src_foundation),
    Fields.InValid_tax_dt_foundation((SALT311.StrType)le.tax_dt_foundation),
    Fields.InValid_basement_square_footage((SALT311.StrType)le.basement_square_footage),
    Fields.InValid_src_basement_square_footage((SALT311.StrType)le.src_basement_square_footage),
    Fields.InValid_tax_dt_basement_square_footage((SALT311.StrType)le.tax_dt_basement_square_footage),
    Fields.InValid_effective_year_built((SALT311.StrType)le.effective_year_built),
    Fields.InValid_src_effective_year_built((SALT311.StrType)le.src_effective_year_built),
    Fields.InValid_tax_dt_effective_year_built((SALT311.StrType)le.tax_dt_effective_year_built),
    Fields.InValid_garage_square_footage((SALT311.StrType)le.garage_square_footage),
    Fields.InValid_src_garage_square_footage((SALT311.StrType)le.src_garage_square_footage),
    Fields.InValid_tax_dt_garage_square_footage((SALT311.StrType)le.tax_dt_garage_square_footage),
    Fields.InValid_stories_type((SALT311.StrType)le.stories_type),
    Fields.InValid_src_stories_type((SALT311.StrType)le.src_stories_type),
    Fields.InValid_tax_dt_stories_type((SALT311.StrType)le.tax_dt_stories_type),
    Fields.InValid_apn_number((SALT311.StrType)le.apn_number),
    Fields.InValid_src_apn_number((SALT311.StrType)le.src_apn_number),
    Fields.InValid_tax_dt_apn_number((SALT311.StrType)le.tax_dt_apn_number),
    Fields.InValid_census_tract((SALT311.StrType)le.census_tract),
    Fields.InValid_src_census_tract((SALT311.StrType)le.src_census_tract),
    Fields.InValid_tax_dt_census_tract((SALT311.StrType)le.tax_dt_census_tract),
    Fields.InValid_range((SALT311.StrType)le.range),
    Fields.InValid_src_range((SALT311.StrType)le.src_range),
    Fields.InValid_tax_dt_range((SALT311.StrType)le.tax_dt_range),
    Fields.InValid_zoning((SALT311.StrType)le.zoning),
    Fields.InValid_src_zoning((SALT311.StrType)le.src_zoning),
    Fields.InValid_tax_dt_zoning((SALT311.StrType)le.tax_dt_zoning),
    Fields.InValid_block_number((SALT311.StrType)le.block_number),
    Fields.InValid_src_block_number((SALT311.StrType)le.src_block_number),
    Fields.InValid_tax_dt_block_number((SALT311.StrType)le.tax_dt_block_number),
    Fields.InValid_county_name((SALT311.StrType)le.county_name),
    Fields.InValid_src_county_name((SALT311.StrType)le.src_county_name),
    Fields.InValid_tax_dt_county_name((SALT311.StrType)le.tax_dt_county_name),
    Fields.InValid_fips_code((SALT311.StrType)le.fips_code),
    Fields.InValid_src_fips_code((SALT311.StrType)le.src_fips_code),
    Fields.InValid_tax_dt_fips_code((SALT311.StrType)le.tax_dt_fips_code),
    Fields.InValid_subdivision((SALT311.StrType)le.subdivision),
    Fields.InValid_src_subdivision((SALT311.StrType)le.src_subdivision),
    Fields.InValid_tax_dt_subdivision((SALT311.StrType)le.tax_dt_subdivision),
    Fields.InValid_municipality((SALT311.StrType)le.municipality),
    Fields.InValid_src_municipality((SALT311.StrType)le.src_municipality),
    Fields.InValid_tax_dt_municipality((SALT311.StrType)le.tax_dt_municipality),
    Fields.InValid_township((SALT311.StrType)le.township),
    Fields.InValid_src_township((SALT311.StrType)le.src_township),
    Fields.InValid_tax_dt_township((SALT311.StrType)le.tax_dt_township),
    Fields.InValid_homestead_exemption_ind((SALT311.StrType)le.homestead_exemption_ind),
    Fields.InValid_src_homestead_exemption_ind((SALT311.StrType)le.src_homestead_exemption_ind),
    Fields.InValid_tax_dt_homestead_exemption_ind((SALT311.StrType)le.tax_dt_homestead_exemption_ind),
    Fields.InValid_land_use_code((SALT311.StrType)le.land_use_code),
    Fields.InValid_src_land_use_code((SALT311.StrType)le.src_land_use_code),
    Fields.InValid_tax_dt_land_use_code((SALT311.StrType)le.tax_dt_land_use_code),
    Fields.InValid_latitude((SALT311.StrType)le.latitude),
    Fields.InValid_src_latitude((SALT311.StrType)le.src_latitude),
    Fields.InValid_tax_dt_latitude((SALT311.StrType)le.tax_dt_latitude),
    Fields.InValid_longitude((SALT311.StrType)le.longitude),
    Fields.InValid_src_longitude((SALT311.StrType)le.src_longitude),
    Fields.InValid_tax_dt_longitude((SALT311.StrType)le.tax_dt_longitude),
    Fields.InValid_location_influence_code((SALT311.StrType)le.location_influence_code),
    Fields.InValid_src_location_influence_code((SALT311.StrType)le.src_location_influence_code),
    Fields.InValid_tax_dt_location_influence_code((SALT311.StrType)le.tax_dt_location_influence_code),
    Fields.InValid_acres((SALT311.StrType)le.acres),
    Fields.InValid_src_acres((SALT311.StrType)le.src_acres),
    Fields.InValid_tax_dt_acres((SALT311.StrType)le.tax_dt_acres),
    Fields.InValid_lot_depth_footage((SALT311.StrType)le.lot_depth_footage),
    Fields.InValid_src_lot_depth_footage((SALT311.StrType)le.src_lot_depth_footage),
    Fields.InValid_tax_dt_lot_depth_footage((SALT311.StrType)le.tax_dt_lot_depth_footage),
    Fields.InValid_lot_front_footage((SALT311.StrType)le.lot_front_footage),
    Fields.InValid_src_lot_front_footage((SALT311.StrType)le.src_lot_front_footage),
    Fields.InValid_tax_dt_lot_front_footage((SALT311.StrType)le.tax_dt_lot_front_footage),
    Fields.InValid_lot_number((SALT311.StrType)le.lot_number),
    Fields.InValid_src_lot_number((SALT311.StrType)le.src_lot_number),
    Fields.InValid_tax_dt_lot_number((SALT311.StrType)le.tax_dt_lot_number),
    Fields.InValid_lot_size((SALT311.StrType)le.lot_size),
    Fields.InValid_src_lot_size((SALT311.StrType)le.src_lot_size),
    Fields.InValid_tax_dt_lot_size((SALT311.StrType)le.tax_dt_lot_size),
    Fields.InValid_property_type_code((SALT311.StrType)le.property_type_code),
    Fields.InValid_src_property_type_code((SALT311.StrType)le.src_property_type_code),
    Fields.InValid_tax_dt_property_type_code((SALT311.StrType)le.tax_dt_property_type_code),
    Fields.InValid_structure_quality((SALT311.StrType)le.structure_quality),
    Fields.InValid_src_structure_quality((SALT311.StrType)le.src_structure_quality),
    Fields.InValid_tax_dt_structure_quality((SALT311.StrType)le.tax_dt_structure_quality),
    Fields.InValid_water((SALT311.StrType)le.water),
    Fields.InValid_src_water((SALT311.StrType)le.src_water),
    Fields.InValid_tax_dt_water((SALT311.StrType)le.tax_dt_water),
    Fields.InValid_sewer((SALT311.StrType)le.sewer),
    Fields.InValid_src_sewer((SALT311.StrType)le.src_sewer),
    Fields.InValid_tax_dt_sewer((SALT311.StrType)le.tax_dt_sewer),
    Fields.InValid_assessed_land_value((SALT311.StrType)le.assessed_land_value),
    Fields.InValid_src_assessed_land_value((SALT311.StrType)le.src_assessed_land_value),
    Fields.InValid_tax_dt_assessed_land_value((SALT311.StrType)le.tax_dt_assessed_land_value),
    Fields.InValid_assessed_year((SALT311.StrType)le.assessed_year),
    Fields.InValid_src_assessed_year((SALT311.StrType)le.src_assessed_year),
    Fields.InValid_tax_dt_assessed_year((SALT311.StrType)le.tax_dt_assessed_year),
    Fields.InValid_tax_amount((SALT311.StrType)le.tax_amount),
    Fields.InValid_src_tax_amount((SALT311.StrType)le.src_tax_amount),
    Fields.InValid_tax_dt_tax_amount((SALT311.StrType)le.tax_dt_tax_amount),
    Fields.InValid_tax_year((SALT311.StrType)le.tax_year),
    Fields.InValid_src_tax_year((SALT311.StrType)le.src_tax_year),
    Fields.InValid_market_land_value((SALT311.StrType)le.market_land_value),
    Fields.InValid_src_market_land_value((SALT311.StrType)le.src_market_land_value),
    Fields.InValid_tax_dt_market_land_value((SALT311.StrType)le.tax_dt_market_land_value),
    Fields.InValid_improvement_value((SALT311.StrType)le.improvement_value),
    Fields.InValid_src_improvement_value((SALT311.StrType)le.src_improvement_value),
    Fields.InValid_tax_dt_improvement_value((SALT311.StrType)le.tax_dt_improvement_value),
    Fields.InValid_percent_improved((SALT311.StrType)le.percent_improved),
    Fields.InValid_src_percent_improved((SALT311.StrType)le.src_percent_improved),
    Fields.InValid_tax_dt_percent_improved((SALT311.StrType)le.tax_dt_percent_improved),
    Fields.InValid_total_assessed_value((SALT311.StrType)le.total_assessed_value),
    Fields.InValid_src_total_assessed_value((SALT311.StrType)le.src_total_assessed_value),
    Fields.InValid_tax_dt_total_assessed_value((SALT311.StrType)le.tax_dt_total_assessed_value),
    Fields.InValid_total_calculated_value((SALT311.StrType)le.total_calculated_value),
    Fields.InValid_src_total_calculated_value((SALT311.StrType)le.src_total_calculated_value),
    Fields.InValid_tax_dt_total_calculated_value((SALT311.StrType)le.tax_dt_total_calculated_value),
    Fields.InValid_total_land_value((SALT311.StrType)le.total_land_value),
    Fields.InValid_src_total_land_value((SALT311.StrType)le.src_total_land_value),
    Fields.InValid_tax_dt_total_land_value((SALT311.StrType)le.tax_dt_total_land_value),
    Fields.InValid_total_market_value((SALT311.StrType)le.total_market_value),
    Fields.InValid_src_total_market_value((SALT311.StrType)le.src_total_market_value),
    Fields.InValid_tax_dt_total_market_value((SALT311.StrType)le.tax_dt_total_market_value),
    Fields.InValid_floor_type((SALT311.StrType)le.floor_type),
    Fields.InValid_src_floor_type((SALT311.StrType)le.src_floor_type),
    Fields.InValid_tax_dt_floor_type((SALT311.StrType)le.tax_dt_floor_type),
    Fields.InValid_frame_type((SALT311.StrType)le.frame_type),
    Fields.InValid_src_frame_type((SALT311.StrType)le.src_frame_type),
    Fields.InValid_tax_dt_frame_type((SALT311.StrType)le.tax_dt_frame_type),
    Fields.InValid_fuel_type((SALT311.StrType)le.fuel_type),
    Fields.InValid_src_fuel_type((SALT311.StrType)le.src_fuel_type),
    Fields.InValid_tax_dt_fuel_type((SALT311.StrType)le.tax_dt_fuel_type),
    Fields.InValid_no_of_bath_fixtures((SALT311.StrType)le.no_of_bath_fixtures),
    Fields.InValid_src_no_of_bath_fixtures((SALT311.StrType)le.src_no_of_bath_fixtures),
    Fields.InValid_tax_dt_no_of_bath_fixtures((SALT311.StrType)le.tax_dt_no_of_bath_fixtures),
    Fields.InValid_no_of_rooms((SALT311.StrType)le.no_of_rooms),
    Fields.InValid_src_no_of_rooms((SALT311.StrType)le.src_no_of_rooms),
    Fields.InValid_tax_dt_no_of_rooms((SALT311.StrType)le.tax_dt_no_of_rooms),
    Fields.InValid_no_of_units((SALT311.StrType)le.no_of_units),
    Fields.InValid_src_no_of_units((SALT311.StrType)le.src_no_of_units),
    Fields.InValid_tax_dt_no_of_units((SALT311.StrType)le.tax_dt_no_of_units),
    Fields.InValid_style_type((SALT311.StrType)le.style_type),
    Fields.InValid_src_style_type((SALT311.StrType)le.src_style_type),
    Fields.InValid_tax_dt_style_type((SALT311.StrType)le.tax_dt_style_type),
    Fields.InValid_assessment_document_number((SALT311.StrType)le.assessment_document_number),
    Fields.InValid_src_assessment_document_number((SALT311.StrType)le.src_assessment_document_number),
    Fields.InValid_tax_dt_assessment_document_number((SALT311.StrType)le.tax_dt_assessment_document_number),
    Fields.InValid_assessment_recording_date((SALT311.StrType)le.assessment_recording_date),
    Fields.InValid_src_assessment_recording_date((SALT311.StrType)le.src_assessment_recording_date),
    Fields.InValid_tax_dt_assessment_recording_date((SALT311.StrType)le.tax_dt_assessment_recording_date),
    Fields.InValid_deed_document_number((SALT311.StrType)le.deed_document_number),
    Fields.InValid_src_deed_document_number((SALT311.StrType)le.src_deed_document_number),
    Fields.InValid_rec_dt_deed_document_number((SALT311.StrType)le.rec_dt_deed_document_number),
    Fields.InValid_deed_recording_date((SALT311.StrType)le.deed_recording_date),
    Fields.InValid_src_deed_recording_date((SALT311.StrType)le.src_deed_recording_date),
    Fields.InValid_full_part_sale((SALT311.StrType)le.full_part_sale),
    Fields.InValid_src_full_part_sale((SALT311.StrType)le.src_full_part_sale),
    Fields.InValid_rec_dt_full_part_sale((SALT311.StrType)le.rec_dt_full_part_sale),
    Fields.InValid_sale_amount((SALT311.StrType)le.sale_amount),
    Fields.InValid_src_sale_amount((SALT311.StrType)le.src_sale_amount),
    Fields.InValid_rec_dt_sale_amount((SALT311.StrType)le.rec_dt_sale_amount),
    Fields.InValid_sale_date((SALT311.StrType)le.sale_date),
    Fields.InValid_src_sale_date((SALT311.StrType)le.src_sale_date),
    Fields.InValid_rec_dt_sale_date((SALT311.StrType)le.rec_dt_sale_date),
    Fields.InValid_sale_type_code((SALT311.StrType)le.sale_type_code),
    Fields.InValid_src_sale_type_code((SALT311.StrType)le.src_sale_type_code),
    Fields.InValid_rec_dt_sale_type_code((SALT311.StrType)le.rec_dt_sale_type_code),
    Fields.InValid_mortgage_company_name((SALT311.StrType)le.mortgage_company_name),
    Fields.InValid_src_mortgage_company_name((SALT311.StrType)le.src_mortgage_company_name),
    Fields.InValid_rec_dt_mortgage_company_name((SALT311.StrType)le.rec_dt_mortgage_company_name),
    Fields.InValid_loan_amount((SALT311.StrType)le.loan_amount),
    Fields.InValid_src_loan_amount((SALT311.StrType)le.src_loan_amount),
    Fields.InValid_rec_dt_loan_amount((SALT311.StrType)le.rec_dt_loan_amount),
    Fields.InValid_second_loan_amount((SALT311.StrType)le.second_loan_amount),
    Fields.InValid_src_second_loan_amount((SALT311.StrType)le.src_second_loan_amount),
    Fields.InValid_rec_dt_second_loan_amount((SALT311.StrType)le.rec_dt_second_loan_amount),
    Fields.InValid_loan_type_code((SALT311.StrType)le.loan_type_code),
    Fields.InValid_src_loan_type_code((SALT311.StrType)le.src_loan_type_code),
    Fields.InValid_rec_dt_loan_type_code((SALT311.StrType)le.rec_dt_loan_type_code),
    Fields.InValid_interest_rate_type_code((SALT311.StrType)le.interest_rate_type_code),
    Fields.InValid_src_interest_rate_type_code((SALT311.StrType)le.src_interest_rate_type_code),
    Fields.InValid_rec_dt_interest_rate_type_code((SALT311.StrType)le.rec_dt_interest_rate_type_code),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.vendor_source := le.vendor_source;
END;
Errors := NORMALIZE(h,283,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.vendor_source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,vendor_source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.vendor_source;
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','invalid_date','invalid_date','invalid_date','invalid_date','Unknown','invalid_apn','invalid_address','invalid_csz','Unknown','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_csz','invalid_csz','Unknown','invalid_nums','invalid_nums','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','invalid_nums','invalid_vendor_source','invalid_date','invalid_air_conditioning_type_code','invalid_vendor_source','invalid_date','invalid_basement_finish_type_code','invalid_vendor_source','invalid_date','invalid_construction_type_code','invalid_vendor_source','invalid_date','invalid_exterior_walls_code','invalid_vendor_source','invalid_date','invalid_fireplace_indicator','invalid_vendor_source','invalid_date','invalid_fireplace_type','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','invalid_garage_type','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_heating_type','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_parking_type','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','invalid_pool_type','invalid_vendor_source','invalid_date','invalid_roof_type','invalid_vendor_source','invalid_date','invalid_year','invalid_vendor_source','invalid_date','invalid_foundation_type','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_year','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_stories_type','invalid_vendor_source','invalid_date','invalid_apn','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','invalid_county_name','invalid_vendor_source','invalid_date','invalid_fips','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','invalid_land_use','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','invalid_location_code','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','invalid_property_code','invalid_vendor_source','invalid_date','invalid_structure_quality_code','invalid_vendor_source','invalid_date','invalid_water_type','invalid_vendor_source','invalid_date','invalid_sewer_type','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_year','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_year','invalid_vendor_source','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','Unknown','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_floor_cover_code','invalid_vendor_source','invalid_date','invalid_frame_code','invalid_vendor_source','invalid_date','invalid_heating_fuel_type','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_nums','invalid_vendor_source','invalid_date','invalid_style_type','invalid_vendor_source','invalid_date','invalid_document_number','invalid_vendor_source','invalid_date','invalid_date','invalid_vendor_source','invalid_date','invalid_document_number','invalid_vendor_source','invalid_date','invalid_date','invalid_vendor_source','invalid_sale_code','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_date','invalid_vendor_source','invalid_date','invalid_sale_tran_code','invalid_vendor_source','invalid_date','invalid_alpha','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_tax_amount','invalid_vendor_source','invalid_date','invalid_mortgage_loan_type_code','invalid_vendor_source','invalid_date','invalid_financing_type_code','invalid_vendor_source','invalid_date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_property_rid(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Fields.InValidMessage_tax_sortby_date(TotalErrors.ErrorNum),Fields.InValidMessage_deed_sortby_date(TotalErrors.ErrorNum),Fields.InValidMessage_vendor_source(TotalErrors.ErrorNum),Fields.InValidMessage_fares_unformatted_apn(TotalErrors.ErrorNum),Fields.InValidMessage_property_street_address(TotalErrors.ErrorNum),Fields.InValidMessage_property_city_state_zip(TotalErrors.ErrorNum),Fields.InValidMessage_property_raw_aid(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_building_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_src_building_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_building_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_air_conditioning_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_air_conditioning_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_air_conditioning_type(TotalErrors.ErrorNum),Fields.InValidMessage_basement_finish(TotalErrors.ErrorNum),Fields.InValidMessage_src_basement_finish(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_basement_finish(TotalErrors.ErrorNum),Fields.InValidMessage_construction_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_construction_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_construction_type(TotalErrors.ErrorNum),Fields.InValidMessage_exterior_wall(TotalErrors.ErrorNum),Fields.InValidMessage_src_exterior_wall(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_exterior_wall(TotalErrors.ErrorNum),Fields.InValidMessage_fireplace_ind(TotalErrors.ErrorNum),Fields.InValidMessage_src_fireplace_ind(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_fireplace_ind(TotalErrors.ErrorNum),Fields.InValidMessage_fireplace_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_fireplace_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_fireplace_type(TotalErrors.ErrorNum),Fields.InValidMessage_flood_zone_panel(TotalErrors.ErrorNum),Fields.InValidMessage_src_flood_zone_panel(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_flood_zone_panel(TotalErrors.ErrorNum),Fields.InValidMessage_garage(TotalErrors.ErrorNum),Fields.InValidMessage_src_garage(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_garage(TotalErrors.ErrorNum),Fields.InValidMessage_first_floor_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_src_first_floor_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_first_floor_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_heating(TotalErrors.ErrorNum),Fields.InValidMessage_src_heating(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_heating(TotalErrors.ErrorNum),Fields.InValidMessage_living_area_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_src_living_area_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_living_area_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_baths(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_baths(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_baths(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_bedrooms(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_bedrooms(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_bedrooms(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_fireplaces(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_fireplaces(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_fireplaces(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_full_baths(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_full_baths(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_full_baths(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_half_baths(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_half_baths(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_half_baths(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_stories(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_stories(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_stories(TotalErrors.ErrorNum),Fields.InValidMessage_parking_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_parking_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_parking_type(TotalErrors.ErrorNum),Fields.InValidMessage_pool_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_src_pool_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_pool_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_pool_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_pool_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_pool_type(TotalErrors.ErrorNum),Fields.InValidMessage_roof_cover(TotalErrors.ErrorNum),Fields.InValidMessage_src_roof_cover(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_roof_cover(TotalErrors.ErrorNum),Fields.InValidMessage_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_src_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_foundation(TotalErrors.ErrorNum),Fields.InValidMessage_src_foundation(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_foundation(TotalErrors.ErrorNum),Fields.InValidMessage_basement_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_src_basement_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_basement_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_effective_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_src_effective_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_effective_year_built(TotalErrors.ErrorNum),Fields.InValidMessage_garage_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_src_garage_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_garage_square_footage(TotalErrors.ErrorNum),Fields.InValidMessage_stories_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_stories_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_stories_type(TotalErrors.ErrorNum),Fields.InValidMessage_apn_number(TotalErrors.ErrorNum),Fields.InValidMessage_src_apn_number(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_apn_number(TotalErrors.ErrorNum),Fields.InValidMessage_census_tract(TotalErrors.ErrorNum),Fields.InValidMessage_src_census_tract(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_census_tract(TotalErrors.ErrorNum),Fields.InValidMessage_range(TotalErrors.ErrorNum),Fields.InValidMessage_src_range(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_range(TotalErrors.ErrorNum),Fields.InValidMessage_zoning(TotalErrors.ErrorNum),Fields.InValidMessage_src_zoning(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_zoning(TotalErrors.ErrorNum),Fields.InValidMessage_block_number(TotalErrors.ErrorNum),Fields.InValidMessage_src_block_number(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_block_number(TotalErrors.ErrorNum),Fields.InValidMessage_county_name(TotalErrors.ErrorNum),Fields.InValidMessage_src_county_name(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_county_name(TotalErrors.ErrorNum),Fields.InValidMessage_fips_code(TotalErrors.ErrorNum),Fields.InValidMessage_src_fips_code(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_fips_code(TotalErrors.ErrorNum),Fields.InValidMessage_subdivision(TotalErrors.ErrorNum),Fields.InValidMessage_src_subdivision(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_subdivision(TotalErrors.ErrorNum),Fields.InValidMessage_municipality(TotalErrors.ErrorNum),Fields.InValidMessage_src_municipality(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_municipality(TotalErrors.ErrorNum),Fields.InValidMessage_township(TotalErrors.ErrorNum),Fields.InValidMessage_src_township(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_township(TotalErrors.ErrorNum),Fields.InValidMessage_homestead_exemption_ind(TotalErrors.ErrorNum),Fields.InValidMessage_src_homestead_exemption_ind(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_homestead_exemption_ind(TotalErrors.ErrorNum),Fields.InValidMessage_land_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_src_land_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_land_use_code(TotalErrors.ErrorNum),Fields.InValidMessage_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_src_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_latitude(TotalErrors.ErrorNum),Fields.InValidMessage_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_src_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_longitude(TotalErrors.ErrorNum),Fields.InValidMessage_location_influence_code(TotalErrors.ErrorNum),Fields.InValidMessage_src_location_influence_code(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_location_influence_code(TotalErrors.ErrorNum),Fields.InValidMessage_acres(TotalErrors.ErrorNum),Fields.InValidMessage_src_acres(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_acres(TotalErrors.ErrorNum),Fields.InValidMessage_lot_depth_footage(TotalErrors.ErrorNum),Fields.InValidMessage_src_lot_depth_footage(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_lot_depth_footage(TotalErrors.ErrorNum),Fields.InValidMessage_lot_front_footage(TotalErrors.ErrorNum),Fields.InValidMessage_src_lot_front_footage(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_lot_front_footage(TotalErrors.ErrorNum),Fields.InValidMessage_lot_number(TotalErrors.ErrorNum),Fields.InValidMessage_src_lot_number(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_lot_number(TotalErrors.ErrorNum),Fields.InValidMessage_lot_size(TotalErrors.ErrorNum),Fields.InValidMessage_src_lot_size(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_lot_size(TotalErrors.ErrorNum),Fields.InValidMessage_property_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_src_property_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_property_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_structure_quality(TotalErrors.ErrorNum),Fields.InValidMessage_src_structure_quality(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_structure_quality(TotalErrors.ErrorNum),Fields.InValidMessage_water(TotalErrors.ErrorNum),Fields.InValidMessage_src_water(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_water(TotalErrors.ErrorNum),Fields.InValidMessage_sewer(TotalErrors.ErrorNum),Fields.InValidMessage_src_sewer(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_sewer(TotalErrors.ErrorNum),Fields.InValidMessage_assessed_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_src_assessed_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_assessed_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_assessed_year(TotalErrors.ErrorNum),Fields.InValidMessage_src_assessed_year(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_assessed_year(TotalErrors.ErrorNum),Fields.InValidMessage_tax_amount(TotalErrors.ErrorNum),Fields.InValidMessage_src_tax_amount(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_tax_amount(TotalErrors.ErrorNum),Fields.InValidMessage_tax_year(TotalErrors.ErrorNum),Fields.InValidMessage_src_tax_year(TotalErrors.ErrorNum),Fields.InValidMessage_market_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_src_market_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_market_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_improvement_value(TotalErrors.ErrorNum),Fields.InValidMessage_src_improvement_value(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_improvement_value(TotalErrors.ErrorNum),Fields.InValidMessage_percent_improved(TotalErrors.ErrorNum),Fields.InValidMessage_src_percent_improved(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_percent_improved(TotalErrors.ErrorNum),Fields.InValidMessage_total_assessed_value(TotalErrors.ErrorNum),Fields.InValidMessage_src_total_assessed_value(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_total_assessed_value(TotalErrors.ErrorNum),Fields.InValidMessage_total_calculated_value(TotalErrors.ErrorNum),Fields.InValidMessage_src_total_calculated_value(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_total_calculated_value(TotalErrors.ErrorNum),Fields.InValidMessage_total_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_src_total_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_total_land_value(TotalErrors.ErrorNum),Fields.InValidMessage_total_market_value(TotalErrors.ErrorNum),Fields.InValidMessage_src_total_market_value(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_total_market_value(TotalErrors.ErrorNum),Fields.InValidMessage_floor_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_floor_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_floor_type(TotalErrors.ErrorNum),Fields.InValidMessage_frame_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_frame_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_frame_type(TotalErrors.ErrorNum),Fields.InValidMessage_fuel_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_fuel_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_fuel_type(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_bath_fixtures(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_bath_fixtures(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_bath_fixtures(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_rooms(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_rooms(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_rooms(TotalErrors.ErrorNum),Fields.InValidMessage_no_of_units(TotalErrors.ErrorNum),Fields.InValidMessage_src_no_of_units(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_no_of_units(TotalErrors.ErrorNum),Fields.InValidMessage_style_type(TotalErrors.ErrorNum),Fields.InValidMessage_src_style_type(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_style_type(TotalErrors.ErrorNum),Fields.InValidMessage_assessment_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_src_assessment_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_assessment_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_assessment_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_src_assessment_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_tax_dt_assessment_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_deed_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_src_deed_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_deed_document_number(TotalErrors.ErrorNum),Fields.InValidMessage_deed_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_src_deed_recording_date(TotalErrors.ErrorNum),Fields.InValidMessage_full_part_sale(TotalErrors.ErrorNum),Fields.InValidMessage_src_full_part_sale(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_full_part_sale(TotalErrors.ErrorNum),Fields.InValidMessage_sale_amount(TotalErrors.ErrorNum),Fields.InValidMessage_src_sale_amount(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_sale_amount(TotalErrors.ErrorNum),Fields.InValidMessage_sale_date(TotalErrors.ErrorNum),Fields.InValidMessage_src_sale_date(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_sale_date(TotalErrors.ErrorNum),Fields.InValidMessage_sale_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_src_sale_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_sale_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_mortgage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_src_mortgage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_mortgage_company_name(TotalErrors.ErrorNum),Fields.InValidMessage_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_src_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_second_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_src_second_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_second_loan_amount(TotalErrors.ErrorNum),Fields.InValidMessage_loan_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_src_loan_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_loan_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_interest_rate_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_src_interest_rate_type_code(TotalErrors.ErrorNum),Fields.InValidMessage_rec_dt_interest_rate_type_code(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.vendor_source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Property_Characteristics, Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
