IMPORT SALT311,STD;
EXPORT Source_Level_Base_hygiene(dataset(Layout_Source_Level_Base) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.source))'', MAX(GROUP,h.source));
    NumberOfRecords := COUNT(GROUP);
    populated_cellphoneidkey_cnt := COUNT(GROUP,h.cellphoneidkey <> (TYPEOF(h.cellphoneidkey))'');
    populated_cellphoneidkey_pcnt := AVE(GROUP,IF(h.cellphoneidkey = (TYPEOF(h.cellphoneidkey))'',0,100));
    maxlength_cellphoneidkey := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cellphoneidkey)));
    avelength_cellphoneidkey := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cellphoneidkey)),h.cellphoneidkey<>(typeof(h.cellphoneidkey))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_src_bitmap_cnt := COUNT(GROUP,h.src_bitmap <> (TYPEOF(h.src_bitmap))'');
    populated_src_bitmap_pcnt := AVE(GROUP,IF(h.src_bitmap = (TYPEOF(h.src_bitmap))'',0,100));
    maxlength_src_bitmap := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_bitmap)));
    avelength_src_bitmap := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.src_bitmap)),h.src_bitmap<>(typeof(h.src_bitmap))'');
    populated_household_flag_cnt := COUNT(GROUP,h.household_flag <> (TYPEOF(h.household_flag))'');
    populated_household_flag_pcnt := AVE(GROUP,IF(h.household_flag = (TYPEOF(h.household_flag))'',0,100));
    maxlength_household_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.household_flag)));
    avelength_household_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.household_flag)),h.household_flag<>(typeof(h.household_flag))'');
    populated_rules_cnt := COUNT(GROUP,h.rules <> (TYPEOF(h.rules))'');
    populated_rules_pcnt := AVE(GROUP,IF(h.rules = (TYPEOF(h.rules))'',0,100));
    maxlength_rules := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rules)));
    avelength_rules := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rules)),h.rules<>(typeof(h.rules))'');
    populated_cellphone_cnt := COUNT(GROUP,h.cellphone <> (TYPEOF(h.cellphone))'');
    populated_cellphone_pcnt := AVE(GROUP,IF(h.cellphone = (TYPEOF(h.cellphone))'',0,100));
    maxlength_cellphone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cellphone)));
    avelength_cellphone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cellphone)),h.cellphone<>(typeof(h.cellphone))'');
    populated_npa_cnt := COUNT(GROUP,h.npa <> (TYPEOF(h.npa))'');
    populated_npa_pcnt := AVE(GROUP,IF(h.npa = (TYPEOF(h.npa))'',0,100));
    maxlength_npa := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.npa)));
    avelength_npa := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.npa)),h.npa<>(typeof(h.npa))'');
    populated_phone7_cnt := COUNT(GROUP,h.phone7 <> (TYPEOF(h.phone7))'');
    populated_phone7_pcnt := AVE(GROUP,IF(h.phone7 = (TYPEOF(h.phone7))'',0,100));
    maxlength_phone7 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone7)));
    avelength_phone7 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone7)),h.phone7<>(typeof(h.phone7))'');
    populated_phone7_did_key_cnt := COUNT(GROUP,h.phone7_did_key <> (TYPEOF(h.phone7_did_key))'');
    populated_phone7_did_key_pcnt := AVE(GROUP,IF(h.phone7_did_key = (TYPEOF(h.phone7_did_key))'',0,100));
    maxlength_phone7_did_key := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone7_did_key)));
    avelength_phone7_did_key := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone7_did_key)),h.phone7_did_key<>(typeof(h.phone7_did_key))'');
    populated_pdid_cnt := COUNT(GROUP,h.pdid <> (TYPEOF(h.pdid))'');
    populated_pdid_pcnt := AVE(GROUP,IF(h.pdid = (TYPEOF(h.pdid))'',0,100));
    maxlength_pdid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pdid)));
    avelength_pdid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pdid)),h.pdid<>(typeof(h.pdid))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_datefirstseen_cnt := COUNT(GROUP,h.datefirstseen <> (TYPEOF(h.datefirstseen))'');
    populated_datefirstseen_pcnt := AVE(GROUP,IF(h.datefirstseen = (TYPEOF(h.datefirstseen))'',0,100));
    maxlength_datefirstseen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datefirstseen)));
    avelength_datefirstseen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datefirstseen)),h.datefirstseen<>(typeof(h.datefirstseen))'');
    populated_datelastseen_cnt := COUNT(GROUP,h.datelastseen <> (TYPEOF(h.datelastseen))'');
    populated_datelastseen_pcnt := AVE(GROUP,IF(h.datelastseen = (TYPEOF(h.datelastseen))'',0,100));
    maxlength_datelastseen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datelastseen)));
    avelength_datelastseen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datelastseen)),h.datelastseen<>(typeof(h.datelastseen))'');
    populated_datevendorfirstreported_cnt := COUNT(GROUP,h.datevendorfirstreported <> (TYPEOF(h.datevendorfirstreported))'');
    populated_datevendorfirstreported_pcnt := AVE(GROUP,IF(h.datevendorfirstreported = (TYPEOF(h.datevendorfirstreported))'',0,100));
    maxlength_datevendorfirstreported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datevendorfirstreported)));
    avelength_datevendorfirstreported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datevendorfirstreported)),h.datevendorfirstreported<>(typeof(h.datevendorfirstreported))'');
    populated_datevendorlastreported_cnt := COUNT(GROUP,h.datevendorlastreported <> (TYPEOF(h.datevendorlastreported))'');
    populated_datevendorlastreported_pcnt := AVE(GROUP,IF(h.datevendorlastreported = (TYPEOF(h.datevendorlastreported))'',0,100));
    maxlength_datevendorlastreported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datevendorlastreported)));
    avelength_datevendorlastreported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datevendorlastreported)),h.datevendorlastreported<>(typeof(h.datevendorlastreported))'');
    populated_dt_nonglb_last_seen_cnt := COUNT(GROUP,h.dt_nonglb_last_seen <> (TYPEOF(h.dt_nonglb_last_seen))'');
    populated_dt_nonglb_last_seen_pcnt := AVE(GROUP,IF(h.dt_nonglb_last_seen = (TYPEOF(h.dt_nonglb_last_seen))'',0,100));
    maxlength_dt_nonglb_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_nonglb_last_seen)));
    avelength_dt_nonglb_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_nonglb_last_seen)),h.dt_nonglb_last_seen<>(typeof(h.dt_nonglb_last_seen))'');
    populated_glb_dppa_flag_cnt := COUNT(GROUP,h.glb_dppa_flag <> (TYPEOF(h.glb_dppa_flag))'');
    populated_glb_dppa_flag_pcnt := AVE(GROUP,IF(h.glb_dppa_flag = (TYPEOF(h.glb_dppa_flag))'',0,100));
    maxlength_glb_dppa_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.glb_dppa_flag)));
    avelength_glb_dppa_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.glb_dppa_flag)),h.glb_dppa_flag<>(typeof(h.glb_dppa_flag))'');
    populated_did_type_cnt := COUNT(GROUP,h.did_type <> (TYPEOF(h.did_type))'');
    populated_did_type_pcnt := AVE(GROUP,IF(h.did_type = (TYPEOF(h.did_type))'',0,100));
    maxlength_did_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_type)));
    avelength_did_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_type)),h.did_type<>(typeof(h.did_type))'');
    populated_origname_cnt := COUNT(GROUP,h.origname <> (TYPEOF(h.origname))'');
    populated_origname_pcnt := AVE(GROUP,IF(h.origname = (TYPEOF(h.origname))'',0,100));
    maxlength_origname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origname)));
    avelength_origname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origname)),h.origname<>(typeof(h.origname))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_origcity_cnt := COUNT(GROUP,h.origcity <> (TYPEOF(h.origcity))'');
    populated_origcity_pcnt := AVE(GROUP,IF(h.origcity = (TYPEOF(h.origcity))'',0,100));
    maxlength_origcity := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origcity)));
    avelength_origcity := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origcity)),h.origcity<>(typeof(h.origcity))'');
    populated_origstate_cnt := COUNT(GROUP,h.origstate <> (TYPEOF(h.origstate))'');
    populated_origstate_pcnt := AVE(GROUP,IF(h.origstate = (TYPEOF(h.origstate))'',0,100));
    maxlength_origstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origstate)));
    avelength_origstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origstate)),h.origstate<>(typeof(h.origstate))'');
    populated_origzip_cnt := COUNT(GROUP,h.origzip <> (TYPEOF(h.origzip))'');
    populated_origzip_pcnt := AVE(GROUP,IF(h.origzip = (TYPEOF(h.origzip))'',0,100));
    maxlength_origzip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.origzip)));
    avelength_origzip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.origzip)),h.origzip<>(typeof(h.origzip))'');
    populated_orig_phone_cnt := COUNT(GROUP,h.orig_phone <> (TYPEOF(h.orig_phone))'');
    populated_orig_phone_pcnt := AVE(GROUP,IF(h.orig_phone = (TYPEOF(h.orig_phone))'',0,100));
    maxlength_orig_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_phone)));
    avelength_orig_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_phone)),h.orig_phone<>(typeof(h.orig_phone))'');
    populated_orig_carrier_name_cnt := COUNT(GROUP,h.orig_carrier_name <> (TYPEOF(h.orig_carrier_name))'');
    populated_orig_carrier_name_pcnt := AVE(GROUP,IF(h.orig_carrier_name = (TYPEOF(h.orig_carrier_name))'',0,100));
    maxlength_orig_carrier_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_carrier_name)));
    avelength_orig_carrier_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_carrier_name)),h.orig_carrier_name<>(typeof(h.orig_carrier_name))'');
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
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip5_cnt := COUNT(GROUP,h.zip5 <> (TYPEOF(h.zip5))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
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
    populated_dpbc_cnt := COUNT(GROUP,h.dpbc <> (TYPEOF(h.dpbc))'');
    populated_dpbc_pcnt := AVE(GROUP,IF(h.dpbc = (TYPEOF(h.dpbc))'',0,100));
    maxlength_dpbc := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)));
    avelength_dpbc := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dpbc)),h.dpbc<>(typeof(h.dpbc))'');
    populated_chk_digit_cnt := COUNT(GROUP,h.chk_digit <> (TYPEOF(h.chk_digit))'');
    populated_chk_digit_pcnt := AVE(GROUP,IF(h.chk_digit = (TYPEOF(h.chk_digit))'',0,100));
    maxlength_chk_digit := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)));
    avelength_chk_digit := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.chk_digit)),h.chk_digit<>(typeof(h.chk_digit))'');
    populated_rec_type_cnt := COUNT(GROUP,h.rec_type <> (TYPEOF(h.rec_type))'');
    populated_rec_type_pcnt := AVE(GROUP,IF(h.rec_type = (TYPEOF(h.rec_type))'',0,100));
    maxlength_rec_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)));
    avelength_rec_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rec_type)),h.rec_type<>(typeof(h.rec_type))'');
    populated_ace_fips_st_cnt := COUNT(GROUP,h.ace_fips_st <> (TYPEOF(h.ace_fips_st))'');
    populated_ace_fips_st_pcnt := AVE(GROUP,IF(h.ace_fips_st = (TYPEOF(h.ace_fips_st))'',0,100));
    maxlength_ace_fips_st := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)));
    avelength_ace_fips_st := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_st)),h.ace_fips_st<>(typeof(h.ace_fips_st))'');
    populated_ace_fips_county_cnt := COUNT(GROUP,h.ace_fips_county <> (TYPEOF(h.ace_fips_county))'');
    populated_ace_fips_county_pcnt := AVE(GROUP,IF(h.ace_fips_county = (TYPEOF(h.ace_fips_county))'',0,100));
    maxlength_ace_fips_county := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_county)));
    avelength_ace_fips_county := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ace_fips_county)),h.ace_fips_county<>(typeof(h.ace_fips_county))'');
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
    populated_name_score_cnt := COUNT(GROUP,h.name_score <> (TYPEOF(h.name_score))'');
    populated_name_score_pcnt := AVE(GROUP,IF(h.name_score = (TYPEOF(h.name_score))'',0,100));
    maxlength_name_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)));
    avelength_name_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_score)),h.name_score<>(typeof(h.name_score))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_rawaid_cnt := COUNT(GROUP,h.rawaid <> (TYPEOF(h.rawaid))'');
    populated_rawaid_pcnt := AVE(GROUP,IF(h.rawaid = (TYPEOF(h.rawaid))'',0,100));
    maxlength_rawaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)));
    avelength_rawaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rawaid)),h.rawaid<>(typeof(h.rawaid))'');
    populated_cleanaid_cnt := COUNT(GROUP,h.cleanaid <> (TYPEOF(h.cleanaid))'');
    populated_cleanaid_pcnt := AVE(GROUP,IF(h.cleanaid = (TYPEOF(h.cleanaid))'',0,100));
    maxlength_cleanaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanaid)));
    avelength_cleanaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cleanaid)),h.cleanaid<>(typeof(h.cleanaid))'');
    populated_current_rec_cnt := COUNT(GROUP,h.current_rec <> (TYPEOF(h.current_rec))'');
    populated_current_rec_pcnt := AVE(GROUP,IF(h.current_rec = (TYPEOF(h.current_rec))'',0,100));
    maxlength_current_rec := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)));
    avelength_current_rec := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.current_rec)),h.current_rec<>(typeof(h.current_rec))'');
    populated_first_build_date_cnt := COUNT(GROUP,h.first_build_date <> (TYPEOF(h.first_build_date))'');
    populated_first_build_date_pcnt := AVE(GROUP,IF(h.first_build_date = (TYPEOF(h.first_build_date))'',0,100));
    maxlength_first_build_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_build_date)));
    avelength_first_build_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.first_build_date)),h.first_build_date<>(typeof(h.first_build_date))'');
    populated_last_build_date_cnt := COUNT(GROUP,h.last_build_date <> (TYPEOF(h.last_build_date))'');
    populated_last_build_date_pcnt := AVE(GROUP,IF(h.last_build_date = (TYPEOF(h.last_build_date))'',0,100));
    maxlength_last_build_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_build_date)));
    avelength_last_build_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.last_build_date)),h.last_build_date<>(typeof(h.last_build_date))'');
    populated_ingest_tpe_cnt := COUNT(GROUP,h.ingest_tpe <> (TYPEOF(h.ingest_tpe))'');
    populated_ingest_tpe_pcnt := AVE(GROUP,IF(h.ingest_tpe = (TYPEOF(h.ingest_tpe))'',0,100));
    maxlength_ingest_tpe := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ingest_tpe)));
    avelength_ingest_tpe := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ingest_tpe)),h.ingest_tpe<>(typeof(h.ingest_tpe))'');
    populated_verified_cnt := COUNT(GROUP,h.verified <> (TYPEOF(h.verified))'');
    populated_verified_pcnt := AVE(GROUP,IF(h.verified = (TYPEOF(h.verified))'',0,100));
    maxlength_verified := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified)));
    avelength_verified := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.verified)),h.verified<>(typeof(h.verified))'');
    populated_cord_cutter_cnt := COUNT(GROUP,h.cord_cutter <> (TYPEOF(h.cord_cutter))'');
    populated_cord_cutter_pcnt := AVE(GROUP,IF(h.cord_cutter = (TYPEOF(h.cord_cutter))'',0,100));
    maxlength_cord_cutter := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.cord_cutter)));
    avelength_cord_cutter := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.cord_cutter)),h.cord_cutter<>(typeof(h.cord_cutter))'');
    populated_activity_status_cnt := COUNT(GROUP,h.activity_status <> (TYPEOF(h.activity_status))'');
    populated_activity_status_pcnt := AVE(GROUP,IF(h.activity_status = (TYPEOF(h.activity_status))'',0,100));
    maxlength_activity_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_status)));
    avelength_activity_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_status)),h.activity_status<>(typeof(h.activity_status))'');
    populated_prepaid_cnt := COUNT(GROUP,h.prepaid <> (TYPEOF(h.prepaid))'');
    populated_prepaid_pcnt := AVE(GROUP,IF(h.prepaid = (TYPEOF(h.prepaid))'',0,100));
    maxlength_prepaid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepaid)));
    avelength_prepaid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepaid)),h.prepaid<>(typeof(h.prepaid))'');
    populated_global_sid_cnt := COUNT(GROUP,h.global_sid <> (TYPEOF(h.global_sid))'');
    populated_global_sid_pcnt := AVE(GROUP,IF(h.global_sid = (TYPEOF(h.global_sid))'',0,100));
    maxlength_global_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)));
    avelength_global_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.global_sid)),h.global_sid<>(typeof(h.global_sid))'');
    populated_record_sid_cnt := COUNT(GROUP,h.record_sid <> (TYPEOF(h.record_sid))'');
    populated_record_sid_pcnt := AVE(GROUP,IF(h.record_sid = (TYPEOF(h.record_sid))'',0,100));
    maxlength_record_sid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)));
    avelength_record_sid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_sid)),h.record_sid<>(typeof(h.record_sid))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,source,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_cellphoneidkey_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_src_bitmap_pcnt *   0.00 / 100 + T.Populated_household_flag_pcnt *   0.00 / 100 + T.Populated_rules_pcnt *   0.00 / 100 + T.Populated_cellphone_pcnt *   0.00 / 100 + T.Populated_npa_pcnt *   0.00 / 100 + T.Populated_phone7_pcnt *   0.00 / 100 + T.Populated_phone7_did_key_pcnt *   0.00 / 100 + T.Populated_pdid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_datefirstseen_pcnt *   0.00 / 100 + T.Populated_datelastseen_pcnt *   0.00 / 100 + T.Populated_datevendorfirstreported_pcnt *   0.00 / 100 + T.Populated_datevendorlastreported_pcnt *   0.00 / 100 + T.Populated_dt_nonglb_last_seen_pcnt *   0.00 / 100 + T.Populated_glb_dppa_flag_pcnt *   0.00 / 100 + T.Populated_did_type_pcnt *   0.00 / 100 + T.Populated_origname_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_origcity_pcnt *   0.00 / 100 + T.Populated_origstate_pcnt *   0.00 / 100 + T.Populated_origzip_pcnt *   0.00 / 100 + T.Populated_orig_phone_pcnt *   0.00 / 100 + T.Populated_orig_carrier_name_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_ace_fips_st_pcnt *   0.00 / 100 + T.Populated_ace_fips_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_rawaid_pcnt *   0.00 / 100 + T.Populated_cleanaid_pcnt *   0.00 / 100 + T.Populated_current_rec_pcnt *   0.00 / 100 + T.Populated_first_build_date_pcnt *   0.00 / 100 + T.Populated_last_build_date_pcnt *   0.00 / 100 + T.Populated_ingest_tpe_pcnt *   0.00 / 100 + T.Populated_verified_pcnt *   0.00 / 100 + T.Populated_cord_cutter_pcnt *   0.00 / 100 + T.Populated_activity_status_pcnt *   0.00 / 100 + T.Populated_prepaid_pcnt *   0.00 / 100 + T.Populated_global_sid_pcnt *   0.00 / 100 + T.Populated_record_sid_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING source1;
    STRING source2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.source1 := le.Source;
    SELF.source2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_cellphoneidkey_pcnt*ri.Populated_cellphoneidkey_pcnt *   0.00 / 10000 + le.Populated_source_pcnt*ri.Populated_source_pcnt *   0.00 / 10000 + le.Populated_src_bitmap_pcnt*ri.Populated_src_bitmap_pcnt *   0.00 / 10000 + le.Populated_household_flag_pcnt*ri.Populated_household_flag_pcnt *   0.00 / 10000 + le.Populated_rules_pcnt*ri.Populated_rules_pcnt *   0.00 / 10000 + le.Populated_cellphone_pcnt*ri.Populated_cellphone_pcnt *   0.00 / 10000 + le.Populated_npa_pcnt*ri.Populated_npa_pcnt *   0.00 / 10000 + le.Populated_phone7_pcnt*ri.Populated_phone7_pcnt *   0.00 / 10000 + le.Populated_phone7_did_key_pcnt*ri.Populated_phone7_did_key_pcnt *   0.00 / 10000 + le.Populated_pdid_pcnt*ri.Populated_pdid_pcnt *   0.00 / 10000 + le.Populated_did_pcnt*ri.Populated_did_pcnt *   0.00 / 10000 + le.Populated_did_score_pcnt*ri.Populated_did_score_pcnt *   0.00 / 10000 + le.Populated_datefirstseen_pcnt*ri.Populated_datefirstseen_pcnt *   0.00 / 10000 + le.Populated_datelastseen_pcnt*ri.Populated_datelastseen_pcnt *   0.00 / 10000 + le.Populated_datevendorfirstreported_pcnt*ri.Populated_datevendorfirstreported_pcnt *   0.00 / 10000 + le.Populated_datevendorlastreported_pcnt*ri.Populated_datevendorlastreported_pcnt *   0.00 / 10000 + le.Populated_dt_nonglb_last_seen_pcnt*ri.Populated_dt_nonglb_last_seen_pcnt *   0.00 / 10000 + le.Populated_glb_dppa_flag_pcnt*ri.Populated_glb_dppa_flag_pcnt *   0.00 / 10000 + le.Populated_did_type_pcnt*ri.Populated_did_type_pcnt *   0.00 / 10000 + le.Populated_origname_pcnt*ri.Populated_origname_pcnt *   0.00 / 10000 + le.Populated_address1_pcnt*ri.Populated_address1_pcnt *   0.00 / 10000 + le.Populated_address2_pcnt*ri.Populated_address2_pcnt *   0.00 / 10000 + le.Populated_origcity_pcnt*ri.Populated_origcity_pcnt *   0.00 / 10000 + le.Populated_origstate_pcnt*ri.Populated_origstate_pcnt *   0.00 / 10000 + le.Populated_origzip_pcnt*ri.Populated_origzip_pcnt *   0.00 / 10000 + le.Populated_orig_phone_pcnt*ri.Populated_orig_phone_pcnt *   0.00 / 10000 + le.Populated_orig_carrier_name_pcnt*ri.Populated_orig_carrier_name_pcnt *   0.00 / 10000 + le.Populated_prim_range_pcnt*ri.Populated_prim_range_pcnt *   0.00 / 10000 + le.Populated_predir_pcnt*ri.Populated_predir_pcnt *   0.00 / 10000 + le.Populated_prim_name_pcnt*ri.Populated_prim_name_pcnt *   0.00 / 10000 + le.Populated_addr_suffix_pcnt*ri.Populated_addr_suffix_pcnt *   0.00 / 10000 + le.Populated_postdir_pcnt*ri.Populated_postdir_pcnt *   0.00 / 10000 + le.Populated_unit_desig_pcnt*ri.Populated_unit_desig_pcnt *   0.00 / 10000 + le.Populated_sec_range_pcnt*ri.Populated_sec_range_pcnt *   0.00 / 10000 + le.Populated_p_city_name_pcnt*ri.Populated_p_city_name_pcnt *   0.00 / 10000 + le.Populated_v_city_name_pcnt*ri.Populated_v_city_name_pcnt *   0.00 / 10000 + le.Populated_state_pcnt*ri.Populated_state_pcnt *   0.00 / 10000 + le.Populated_zip5_pcnt*ri.Populated_zip5_pcnt *   0.00 / 10000 + le.Populated_zip4_pcnt*ri.Populated_zip4_pcnt *   0.00 / 10000 + le.Populated_cart_pcnt*ri.Populated_cart_pcnt *   0.00 / 10000 + le.Populated_cr_sort_sz_pcnt*ri.Populated_cr_sort_sz_pcnt *   0.00 / 10000 + le.Populated_lot_pcnt*ri.Populated_lot_pcnt *   0.00 / 10000 + le.Populated_lot_order_pcnt*ri.Populated_lot_order_pcnt *   0.00 / 10000 + le.Populated_dpbc_pcnt*ri.Populated_dpbc_pcnt *   0.00 / 10000 + le.Populated_chk_digit_pcnt*ri.Populated_chk_digit_pcnt *   0.00 / 10000 + le.Populated_rec_type_pcnt*ri.Populated_rec_type_pcnt *   0.00 / 10000 + le.Populated_ace_fips_st_pcnt*ri.Populated_ace_fips_st_pcnt *   0.00 / 10000 + le.Populated_ace_fips_county_pcnt*ri.Populated_ace_fips_county_pcnt *   0.00 / 10000 + le.Populated_geo_lat_pcnt*ri.Populated_geo_lat_pcnt *   0.00 / 10000 + le.Populated_geo_long_pcnt*ri.Populated_geo_long_pcnt *   0.00 / 10000 + le.Populated_msa_pcnt*ri.Populated_msa_pcnt *   0.00 / 10000 + le.Populated_geo_blk_pcnt*ri.Populated_geo_blk_pcnt *   0.00 / 10000 + le.Populated_geo_match_pcnt*ri.Populated_geo_match_pcnt *   0.00 / 10000 + le.Populated_err_stat_pcnt*ri.Populated_err_stat_pcnt *   0.00 / 10000 + le.Populated_title_pcnt*ri.Populated_title_pcnt *   0.00 / 10000 + le.Populated_fname_pcnt*ri.Populated_fname_pcnt *   0.00 / 10000 + le.Populated_mname_pcnt*ri.Populated_mname_pcnt *   0.00 / 10000 + le.Populated_lname_pcnt*ri.Populated_lname_pcnt *   0.00 / 10000 + le.Populated_name_suffix_pcnt*ri.Populated_name_suffix_pcnt *   0.00 / 10000 + le.Populated_name_score_pcnt*ri.Populated_name_score_pcnt *   0.00 / 10000 + le.Populated_dob_pcnt*ri.Populated_dob_pcnt *   0.00 / 10000 + le.Populated_rawaid_pcnt*ri.Populated_rawaid_pcnt *   0.00 / 10000 + le.Populated_cleanaid_pcnt*ri.Populated_cleanaid_pcnt *   0.00 / 10000 + le.Populated_current_rec_pcnt*ri.Populated_current_rec_pcnt *   0.00 / 10000 + le.Populated_first_build_date_pcnt*ri.Populated_first_build_date_pcnt *   0.00 / 10000 + le.Populated_last_build_date_pcnt*ri.Populated_last_build_date_pcnt *   0.00 / 10000 + le.Populated_ingest_tpe_pcnt*ri.Populated_ingest_tpe_pcnt *   0.00 / 10000 + le.Populated_verified_pcnt*ri.Populated_verified_pcnt *   0.00 / 10000 + le.Populated_cord_cutter_pcnt*ri.Populated_cord_cutter_pcnt *   0.00 / 10000 + le.Populated_activity_status_pcnt*ri.Populated_activity_status_pcnt *   0.00 / 10000 + le.Populated_prepaid_pcnt*ri.Populated_prepaid_pcnt *   0.00 / 10000 + le.Populated_global_sid_pcnt*ri.Populated_global_sid_pcnt *   0.00 / 10000 + le.Populated_record_sid_pcnt*ri.Populated_record_sid_pcnt *   0.00 / 10000;
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
  SELF.FieldName := CHOOSE(C,'cellphoneidkey','source','src_bitmap','household_flag','rules','cellphone','npa','phone7','phone7_did_key','pdid','did','did_score','datefirstseen','datelastseen','datevendorfirstreported','datevendorlastreported','dt_nonglb_last_seen','glb_dppa_flag','did_type','origname','address1','address2','origcity','origstate','origzip','orig_phone','orig_carrier_name','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','ace_fips_county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','title','fname','mname','lname','name_suffix','name_score','dob','rawaid','cleanaid','current_rec','first_build_date','last_build_date','ingest_tpe','verified','cord_cutter','activity_status','prepaid','global_sid','record_sid');
  SELF.populated_pcnt := CHOOSE(C,le.populated_cellphoneidkey_pcnt,le.populated_source_pcnt,le.populated_src_bitmap_pcnt,le.populated_household_flag_pcnt,le.populated_rules_pcnt,le.populated_cellphone_pcnt,le.populated_npa_pcnt,le.populated_phone7_pcnt,le.populated_phone7_did_key_pcnt,le.populated_pdid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_datefirstseen_pcnt,le.populated_datelastseen_pcnt,le.populated_datevendorfirstreported_pcnt,le.populated_datevendorlastreported_pcnt,le.populated_dt_nonglb_last_seen_pcnt,le.populated_glb_dppa_flag_pcnt,le.populated_did_type_pcnt,le.populated_origname_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_origcity_pcnt,le.populated_origstate_pcnt,le.populated_origzip_pcnt,le.populated_orig_phone_pcnt,le.populated_orig_carrier_name_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_state_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_ace_fips_st_pcnt,le.populated_ace_fips_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_dob_pcnt,le.populated_rawaid_pcnt,le.populated_cleanaid_pcnt,le.populated_current_rec_pcnt,le.populated_first_build_date_pcnt,le.populated_last_build_date_pcnt,le.populated_ingest_tpe_pcnt,le.populated_verified_pcnt,le.populated_cord_cutter_pcnt,le.populated_activity_status_pcnt,le.populated_prepaid_pcnt,le.populated_global_sid_pcnt,le.populated_record_sid_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_cellphoneidkey,le.maxlength_source,le.maxlength_src_bitmap,le.maxlength_household_flag,le.maxlength_rules,le.maxlength_cellphone,le.maxlength_npa,le.maxlength_phone7,le.maxlength_phone7_did_key,le.maxlength_pdid,le.maxlength_did,le.maxlength_did_score,le.maxlength_datefirstseen,le.maxlength_datelastseen,le.maxlength_datevendorfirstreported,le.maxlength_datevendorlastreported,le.maxlength_dt_nonglb_last_seen,le.maxlength_glb_dppa_flag,le.maxlength_did_type,le.maxlength_origname,le.maxlength_address1,le.maxlength_address2,le.maxlength_origcity,le.maxlength_origstate,le.maxlength_origzip,le.maxlength_orig_phone,le.maxlength_orig_carrier_name,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_state,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_ace_fips_st,le.maxlength_ace_fips_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_dob,le.maxlength_rawaid,le.maxlength_cleanaid,le.maxlength_current_rec,le.maxlength_first_build_date,le.maxlength_last_build_date,le.maxlength_ingest_tpe,le.maxlength_verified,le.maxlength_cord_cutter,le.maxlength_activity_status,le.maxlength_prepaid,le.maxlength_global_sid,le.maxlength_record_sid);
  SELF.avelength := CHOOSE(C,le.avelength_cellphoneidkey,le.avelength_source,le.avelength_src_bitmap,le.avelength_household_flag,le.avelength_rules,le.avelength_cellphone,le.avelength_npa,le.avelength_phone7,le.avelength_phone7_did_key,le.avelength_pdid,le.avelength_did,le.avelength_did_score,le.avelength_datefirstseen,le.avelength_datelastseen,le.avelength_datevendorfirstreported,le.avelength_datevendorlastreported,le.avelength_dt_nonglb_last_seen,le.avelength_glb_dppa_flag,le.avelength_did_type,le.avelength_origname,le.avelength_address1,le.avelength_address2,le.avelength_origcity,le.avelength_origstate,le.avelength_origzip,le.avelength_orig_phone,le.avelength_orig_carrier_name,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_state,le.avelength_zip5,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_ace_fips_st,le.avelength_ace_fips_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_dob,le.avelength_rawaid,le.avelength_cleanaid,le.avelength_current_rec,le.avelength_first_build_date,le.avelength_last_build_date,le.avelength_ingest_tpe,le.avelength_verified,le.avelength_cord_cutter,le.avelength_activity_status,le.avelength_prepaid,le.avelength_global_sid,le.avelength_record_sid);
END;
EXPORT invSummary := NORMALIZE(summary0, 73, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.source;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.cellphoneidkey),TRIM((SALT311.StrType)le.source),IF (le.src_bitmap <> 0,TRIM((SALT311.StrType)le.src_bitmap), ''),TRIM((SALT311.StrType)le.household_flag),IF (le.rules <> 0,TRIM((SALT311.StrType)le.rules), ''),TRIM((SALT311.StrType)le.cellphone),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.phone7),TRIM((SALT311.StrType)le.phone7_did_key),IF (le.pdid <> 0,TRIM((SALT311.StrType)le.pdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.did_score),IF (le.datefirstseen <> 0,TRIM((SALT311.StrType)le.datefirstseen), ''),IF (le.datelastseen <> 0,TRIM((SALT311.StrType)le.datelastseen), ''),IF (le.datevendorfirstreported <> 0,TRIM((SALT311.StrType)le.datevendorfirstreported), ''),IF (le.datevendorlastreported <> 0,TRIM((SALT311.StrType)le.datevendorlastreported), ''),IF (le.dt_nonglb_last_seen <> 0,TRIM((SALT311.StrType)le.dt_nonglb_last_seen), ''),TRIM((SALT311.StrType)le.glb_dppa_flag),TRIM((SALT311.StrType)le.did_type),TRIM((SALT311.StrType)le.origname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.origcity),TRIM((SALT311.StrType)le.origstate),TRIM((SALT311.StrType)le.origzip),TRIM((SALT311.StrType)le.orig_phone),TRIM((SALT311.StrType)le.orig_carrier_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.dob),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.cleanaid <> 0,TRIM((SALT311.StrType)le.cleanaid), ''),TRIM((SALT311.StrType)le.current_rec),IF (le.first_build_date <> 0,TRIM((SALT311.StrType)le.first_build_date), ''),IF (le.last_build_date <> 0,TRIM((SALT311.StrType)le.last_build_date), ''),IF (le.ingest_tpe <> 0,TRIM((SALT311.StrType)le.ingest_tpe), ''),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.cord_cutter),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,73,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 73);
  SELF.FldNo2 := 1 + (C % 73);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.cellphoneidkey),TRIM((SALT311.StrType)le.source),IF (le.src_bitmap <> 0,TRIM((SALT311.StrType)le.src_bitmap), ''),TRIM((SALT311.StrType)le.household_flag),IF (le.rules <> 0,TRIM((SALT311.StrType)le.rules), ''),TRIM((SALT311.StrType)le.cellphone),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.phone7),TRIM((SALT311.StrType)le.phone7_did_key),IF (le.pdid <> 0,TRIM((SALT311.StrType)le.pdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.did_score),IF (le.datefirstseen <> 0,TRIM((SALT311.StrType)le.datefirstseen), ''),IF (le.datelastseen <> 0,TRIM((SALT311.StrType)le.datelastseen), ''),IF (le.datevendorfirstreported <> 0,TRIM((SALT311.StrType)le.datevendorfirstreported), ''),IF (le.datevendorlastreported <> 0,TRIM((SALT311.StrType)le.datevendorlastreported), ''),IF (le.dt_nonglb_last_seen <> 0,TRIM((SALT311.StrType)le.dt_nonglb_last_seen), ''),TRIM((SALT311.StrType)le.glb_dppa_flag),TRIM((SALT311.StrType)le.did_type),TRIM((SALT311.StrType)le.origname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.origcity),TRIM((SALT311.StrType)le.origstate),TRIM((SALT311.StrType)le.origzip),TRIM((SALT311.StrType)le.orig_phone),TRIM((SALT311.StrType)le.orig_carrier_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.dob),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.cleanaid <> 0,TRIM((SALT311.StrType)le.cleanaid), ''),TRIM((SALT311.StrType)le.current_rec),IF (le.first_build_date <> 0,TRIM((SALT311.StrType)le.first_build_date), ''),IF (le.last_build_date <> 0,TRIM((SALT311.StrType)le.last_build_date), ''),IF (le.ingest_tpe <> 0,TRIM((SALT311.StrType)le.ingest_tpe), ''),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.cord_cutter),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.cellphoneidkey),TRIM((SALT311.StrType)le.source),IF (le.src_bitmap <> 0,TRIM((SALT311.StrType)le.src_bitmap), ''),TRIM((SALT311.StrType)le.household_flag),IF (le.rules <> 0,TRIM((SALT311.StrType)le.rules), ''),TRIM((SALT311.StrType)le.cellphone),TRIM((SALT311.StrType)le.npa),TRIM((SALT311.StrType)le.phone7),TRIM((SALT311.StrType)le.phone7_did_key),IF (le.pdid <> 0,TRIM((SALT311.StrType)le.pdid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),TRIM((SALT311.StrType)le.did_score),IF (le.datefirstseen <> 0,TRIM((SALT311.StrType)le.datefirstseen), ''),IF (le.datelastseen <> 0,TRIM((SALT311.StrType)le.datelastseen), ''),IF (le.datevendorfirstreported <> 0,TRIM((SALT311.StrType)le.datevendorfirstreported), ''),IF (le.datevendorlastreported <> 0,TRIM((SALT311.StrType)le.datevendorlastreported), ''),IF (le.dt_nonglb_last_seen <> 0,TRIM((SALT311.StrType)le.dt_nonglb_last_seen), ''),TRIM((SALT311.StrType)le.glb_dppa_flag),TRIM((SALT311.StrType)le.did_type),TRIM((SALT311.StrType)le.origname),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.origcity),TRIM((SALT311.StrType)le.origstate),TRIM((SALT311.StrType)le.origzip),TRIM((SALT311.StrType)le.orig_phone),TRIM((SALT311.StrType)le.orig_carrier_name),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dpbc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.ace_fips_st),TRIM((SALT311.StrType)le.ace_fips_county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.dob),IF (le.rawaid <> 0,TRIM((SALT311.StrType)le.rawaid), ''),IF (le.cleanaid <> 0,TRIM((SALT311.StrType)le.cleanaid), ''),TRIM((SALT311.StrType)le.current_rec),IF (le.first_build_date <> 0,TRIM((SALT311.StrType)le.first_build_date), ''),IF (le.last_build_date <> 0,TRIM((SALT311.StrType)le.last_build_date), ''),IF (le.ingest_tpe <> 0,TRIM((SALT311.StrType)le.ingest_tpe), ''),TRIM((SALT311.StrType)le.verified),TRIM((SALT311.StrType)le.cord_cutter),TRIM((SALT311.StrType)le.activity_status),TRIM((SALT311.StrType)le.prepaid),IF (le.global_sid <> 0,TRIM((SALT311.StrType)le.global_sid), ''),IF (le.record_sid <> 0,TRIM((SALT311.StrType)le.record_sid), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),73*73,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'cellphoneidkey'}
      ,{2,'source'}
      ,{3,'src_bitmap'}
      ,{4,'household_flag'}
      ,{5,'rules'}
      ,{6,'cellphone'}
      ,{7,'npa'}
      ,{8,'phone7'}
      ,{9,'phone7_did_key'}
      ,{10,'pdid'}
      ,{11,'did'}
      ,{12,'did_score'}
      ,{13,'datefirstseen'}
      ,{14,'datelastseen'}
      ,{15,'datevendorfirstreported'}
      ,{16,'datevendorlastreported'}
      ,{17,'dt_nonglb_last_seen'}
      ,{18,'glb_dppa_flag'}
      ,{19,'did_type'}
      ,{20,'origname'}
      ,{21,'address1'}
      ,{22,'address2'}
      ,{23,'origcity'}
      ,{24,'origstate'}
      ,{25,'origzip'}
      ,{26,'orig_phone'}
      ,{27,'orig_carrier_name'}
      ,{28,'prim_range'}
      ,{29,'predir'}
      ,{30,'prim_name'}
      ,{31,'addr_suffix'}
      ,{32,'postdir'}
      ,{33,'unit_desig'}
      ,{34,'sec_range'}
      ,{35,'p_city_name'}
      ,{36,'v_city_name'}
      ,{37,'state'}
      ,{38,'zip5'}
      ,{39,'zip4'}
      ,{40,'cart'}
      ,{41,'cr_sort_sz'}
      ,{42,'lot'}
      ,{43,'lot_order'}
      ,{44,'dpbc'}
      ,{45,'chk_digit'}
      ,{46,'rec_type'}
      ,{47,'ace_fips_st'}
      ,{48,'ace_fips_county'}
      ,{49,'geo_lat'}
      ,{50,'geo_long'}
      ,{51,'msa'}
      ,{52,'geo_blk'}
      ,{53,'geo_match'}
      ,{54,'err_stat'}
      ,{55,'title'}
      ,{56,'fname'}
      ,{57,'mname'}
      ,{58,'lname'}
      ,{59,'name_suffix'}
      ,{60,'name_score'}
      ,{61,'dob'}
      ,{62,'rawaid'}
      ,{63,'cleanaid'}
      ,{64,'current_rec'}
      ,{65,'first_build_date'}
      ,{66,'last_build_date'}
      ,{67,'ingest_tpe'}
      ,{68,'verified'}
      ,{69,'cord_cutter'}
      ,{70,'activity_status'}
      ,{71,'prepaid'}
      ,{72,'global_sid'}
      ,{73,'record_sid'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.source) source; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Source_Level_Base_Fields.InValid_cellphoneidkey((SALT311.StrType)le.cellphoneidkey),
    Source_Level_Base_Fields.InValid_source((SALT311.StrType)le.source),
    Source_Level_Base_Fields.InValid_src_bitmap((SALT311.StrType)le.src_bitmap),
    Source_Level_Base_Fields.InValid_household_flag((SALT311.StrType)le.household_flag),
    Source_Level_Base_Fields.InValid_rules((SALT311.StrType)le.rules),
    Source_Level_Base_Fields.InValid_cellphone((SALT311.StrType)le.cellphone),
    Source_Level_Base_Fields.InValid_npa((SALT311.StrType)le.npa),
    Source_Level_Base_Fields.InValid_phone7((SALT311.StrType)le.phone7),
    Source_Level_Base_Fields.InValid_phone7_did_key((SALT311.StrType)le.phone7_did_key),
    Source_Level_Base_Fields.InValid_pdid((SALT311.StrType)le.pdid),
    Source_Level_Base_Fields.InValid_did((SALT311.StrType)le.did),
    Source_Level_Base_Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Source_Level_Base_Fields.InValid_datefirstseen((SALT311.StrType)le.datefirstseen),
    Source_Level_Base_Fields.InValid_datelastseen((SALT311.StrType)le.datelastseen),
    Source_Level_Base_Fields.InValid_datevendorfirstreported((SALT311.StrType)le.datevendorfirstreported),
    Source_Level_Base_Fields.InValid_datevendorlastreported((SALT311.StrType)le.datevendorlastreported),
    Source_Level_Base_Fields.InValid_dt_nonglb_last_seen((SALT311.StrType)le.dt_nonglb_last_seen),
    Source_Level_Base_Fields.InValid_glb_dppa_flag((SALT311.StrType)le.glb_dppa_flag),
    Source_Level_Base_Fields.InValid_did_type((SALT311.StrType)le.did_type),
    Source_Level_Base_Fields.InValid_origname((SALT311.StrType)le.origname),
    Source_Level_Base_Fields.InValid_address1((SALT311.StrType)le.address1),
    Source_Level_Base_Fields.InValid_address2((SALT311.StrType)le.address2),
    Source_Level_Base_Fields.InValid_origcity((SALT311.StrType)le.origcity),
    Source_Level_Base_Fields.InValid_origstate((SALT311.StrType)le.origstate),
    Source_Level_Base_Fields.InValid_origzip((SALT311.StrType)le.origzip),
    Source_Level_Base_Fields.InValid_orig_phone((SALT311.StrType)le.orig_phone),
    Source_Level_Base_Fields.InValid_orig_carrier_name((SALT311.StrType)le.orig_carrier_name),
    Source_Level_Base_Fields.InValid_prim_range((SALT311.StrType)le.prim_range),
    Source_Level_Base_Fields.InValid_predir((SALT311.StrType)le.predir),
    Source_Level_Base_Fields.InValid_prim_name((SALT311.StrType)le.prim_name),
    Source_Level_Base_Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix),
    Source_Level_Base_Fields.InValid_postdir((SALT311.StrType)le.postdir),
    Source_Level_Base_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig),
    Source_Level_Base_Fields.InValid_sec_range((SALT311.StrType)le.sec_range),
    Source_Level_Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name),
    Source_Level_Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name),
    Source_Level_Base_Fields.InValid_state((SALT311.StrType)le.state),
    Source_Level_Base_Fields.InValid_zip5((SALT311.StrType)le.zip5),
    Source_Level_Base_Fields.InValid_zip4((SALT311.StrType)le.zip4),
    Source_Level_Base_Fields.InValid_cart((SALT311.StrType)le.cart),
    Source_Level_Base_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz),
    Source_Level_Base_Fields.InValid_lot((SALT311.StrType)le.lot),
    Source_Level_Base_Fields.InValid_lot_order((SALT311.StrType)le.lot_order),
    Source_Level_Base_Fields.InValid_dpbc((SALT311.StrType)le.dpbc),
    Source_Level_Base_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit),
    Source_Level_Base_Fields.InValid_rec_type((SALT311.StrType)le.rec_type),
    Source_Level_Base_Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st),
    Source_Level_Base_Fields.InValid_ace_fips_county((SALT311.StrType)le.ace_fips_county),
    Source_Level_Base_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat),
    Source_Level_Base_Fields.InValid_geo_long((SALT311.StrType)le.geo_long),
    Source_Level_Base_Fields.InValid_msa((SALT311.StrType)le.msa),
    Source_Level_Base_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk),
    Source_Level_Base_Fields.InValid_geo_match((SALT311.StrType)le.geo_match),
    Source_Level_Base_Fields.InValid_err_stat((SALT311.StrType)le.err_stat),
    Source_Level_Base_Fields.InValid_title((SALT311.StrType)le.title),
    Source_Level_Base_Fields.InValid_fname((SALT311.StrType)le.fname),
    Source_Level_Base_Fields.InValid_mname((SALT311.StrType)le.mname),
    Source_Level_Base_Fields.InValid_lname((SALT311.StrType)le.lname),
    Source_Level_Base_Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Source_Level_Base_Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Source_Level_Base_Fields.InValid_dob((SALT311.StrType)le.dob),
    Source_Level_Base_Fields.InValid_rawaid((SALT311.StrType)le.rawaid),
    Source_Level_Base_Fields.InValid_cleanaid((SALT311.StrType)le.cleanaid),
    Source_Level_Base_Fields.InValid_current_rec((SALT311.StrType)le.current_rec),
    Source_Level_Base_Fields.InValid_first_build_date((SALT311.StrType)le.first_build_date),
    Source_Level_Base_Fields.InValid_last_build_date((SALT311.StrType)le.last_build_date),
    Source_Level_Base_Fields.InValid_ingest_tpe((SALT311.StrType)le.ingest_tpe),
    Source_Level_Base_Fields.InValid_verified((SALT311.StrType)le.verified),
    Source_Level_Base_Fields.InValid_cord_cutter((SALT311.StrType)le.cord_cutter),
    Source_Level_Base_Fields.InValid_activity_status((SALT311.StrType)le.activity_status),
    Source_Level_Base_Fields.InValid_prepaid((SALT311.StrType)le.prepaid),
    Source_Level_Base_Fields.InValid_global_sid((SALT311.StrType)le.global_sid),
    Source_Level_Base_Fields.InValid_record_sid((SALT311.StrType)le.record_sid),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.source := le.source;
END;
Errors := NORMALIZE(h,73,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.source;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,source,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.source;
  FieldNme := Source_Level_Base_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Source_Level_Base_Fields.InValidMessage_cellphoneidkey(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_source(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_src_bitmap(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_household_flag(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_rules(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_cellphone(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_npa(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_phone7(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_phone7_did_key(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_pdid(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_did(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_datefirstseen(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_datelastseen(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_datevendorfirstreported(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_datevendorlastreported(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_dt_nonglb_last_seen(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_glb_dppa_flag(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_did_type(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_origname(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_address1(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_address2(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_origcity(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_origstate(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_origzip(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_orig_phone(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_orig_carrier_name(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_predir(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_state(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_cart(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_lot(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_ace_fips_st(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_ace_fips_county(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_msa(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_title(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_fname(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_mname(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_lname(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_rawaid(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_cleanaid(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_current_rec(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_first_build_date(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_last_build_date(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_ingest_tpe(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_verified(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_cord_cutter(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_activity_status(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_prepaid(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_global_sid(TotalErrors.ErrorNum),Source_Level_Base_Fields.InValidMessage_record_sid(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.source=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(PhonesPlus_V2, Source_Level_Base_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
