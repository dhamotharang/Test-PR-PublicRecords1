IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_PCNSR) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
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
    populated_fname_orig_cnt := COUNT(GROUP,h.fname_orig <> (TYPEOF(h.fname_orig))'');
    populated_fname_orig_pcnt := AVE(GROUP,IF(h.fname_orig = (TYPEOF(h.fname_orig))'',0,100));
    maxlength_fname_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname_orig)));
    avelength_fname_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fname_orig)),h.fname_orig<>(typeof(h.fname_orig))'');
    populated_mname_orig_cnt := COUNT(GROUP,h.mname_orig <> (TYPEOF(h.mname_orig))'');
    populated_mname_orig_pcnt := AVE(GROUP,IF(h.mname_orig = (TYPEOF(h.mname_orig))'',0,100));
    maxlength_mname_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname_orig)));
    avelength_mname_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.mname_orig)),h.mname_orig<>(typeof(h.mname_orig))'');
    populated_lname_orig_cnt := COUNT(GROUP,h.lname_orig <> (TYPEOF(h.lname_orig))'');
    populated_lname_orig_pcnt := AVE(GROUP,IF(h.lname_orig = (TYPEOF(h.lname_orig))'',0,100));
    maxlength_lname_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname_orig)));
    avelength_lname_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lname_orig)),h.lname_orig<>(typeof(h.lname_orig))'');
    populated_name_suffix_orig_cnt := COUNT(GROUP,h.name_suffix_orig <> (TYPEOF(h.name_suffix_orig))'');
    populated_name_suffix_orig_pcnt := AVE(GROUP,IF(h.name_suffix_orig = (TYPEOF(h.name_suffix_orig))'',0,100));
    maxlength_name_suffix_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix_orig)));
    avelength_name_suffix_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_suffix_orig)),h.name_suffix_orig<>(typeof(h.name_suffix_orig))'');
    populated_title_orig_cnt := COUNT(GROUP,h.title_orig <> (TYPEOF(h.title_orig))'');
    populated_title_orig_pcnt := AVE(GROUP,IF(h.title_orig = (TYPEOF(h.title_orig))'',0,100));
    maxlength_title_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_orig)));
    avelength_title_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.title_orig)),h.title_orig<>(typeof(h.title_orig))'');
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
    populated_hhid_cnt := COUNT(GROUP,h.hhid <> (TYPEOF(h.hhid))'');
    populated_hhid_pcnt := AVE(GROUP,IF(h.hhid = (TYPEOF(h.hhid))'',0,100));
    maxlength_hhid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.hhid)));
    avelength_hhid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.hhid)),h.hhid<>(typeof(h.hhid))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_phone_fordid_cnt := COUNT(GROUP,h.phone_fordid <> (TYPEOF(h.phone_fordid))'');
    populated_phone_fordid_pcnt := AVE(GROUP,IF(h.phone_fordid = (TYPEOF(h.phone_fordid))'',0,100));
    maxlength_phone_fordid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_fordid)));
    avelength_phone_fordid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_fordid)),h.phone_fordid<>(typeof(h.phone_fordid))'');
    populated_gender_cnt := COUNT(GROUP,h.gender <> (TYPEOF(h.gender))'');
    populated_gender_pcnt := AVE(GROUP,IF(h.gender = (TYPEOF(h.gender))'',0,100));
    maxlength_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)));
    avelength_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.gender)),h.gender<>(typeof(h.gender))'');
    populated_date_of_birth_cnt := COUNT(GROUP,h.date_of_birth <> (TYPEOF(h.date_of_birth))'');
    populated_date_of_birth_pcnt := AVE(GROUP,IF(h.date_of_birth = (TYPEOF(h.date_of_birth))'',0,100));
    maxlength_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_birth)));
    avelength_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_birth)),h.date_of_birth<>(typeof(h.date_of_birth))'');
    populated_address_type_cnt := COUNT(GROUP,h.address_type <> (TYPEOF(h.address_type))'');
    populated_address_type_pcnt := AVE(GROUP,IF(h.address_type = (TYPEOF(h.address_type))'',0,100));
    maxlength_address_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type)));
    avelength_address_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type)),h.address_type<>(typeof(h.address_type))'');
    populated_demographic_level_indicator_cnt := COUNT(GROUP,h.demographic_level_indicator <> (TYPEOF(h.demographic_level_indicator))'');
    populated_demographic_level_indicator_pcnt := AVE(GROUP,IF(h.demographic_level_indicator = (TYPEOF(h.demographic_level_indicator))'',0,100));
    maxlength_demographic_level_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.demographic_level_indicator)));
    avelength_demographic_level_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.demographic_level_indicator)),h.demographic_level_indicator<>(typeof(h.demographic_level_indicator))'');
    populated_length_of_residence_cnt := COUNT(GROUP,h.length_of_residence <> (TYPEOF(h.length_of_residence))'');
    populated_length_of_residence_pcnt := AVE(GROUP,IF(h.length_of_residence = (TYPEOF(h.length_of_residence))'',0,100));
    maxlength_length_of_residence := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.length_of_residence)));
    avelength_length_of_residence := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.length_of_residence)),h.length_of_residence<>(typeof(h.length_of_residence))'');
    populated_location_type_cnt := COUNT(GROUP,h.location_type <> (TYPEOF(h.location_type))'');
    populated_location_type_pcnt := AVE(GROUP,IF(h.location_type = (TYPEOF(h.location_type))'',0,100));
    maxlength_location_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_type)));
    avelength_location_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.location_type)),h.location_type<>(typeof(h.location_type))'');
    populated_dqi2_occupancy_count_cnt := COUNT(GROUP,h.dqi2_occupancy_count <> (TYPEOF(h.dqi2_occupancy_count))'');
    populated_dqi2_occupancy_count_pcnt := AVE(GROUP,IF(h.dqi2_occupancy_count = (TYPEOF(h.dqi2_occupancy_count))'',0,100));
    maxlength_dqi2_occupancy_count := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dqi2_occupancy_count)));
    avelength_dqi2_occupancy_count := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dqi2_occupancy_count)),h.dqi2_occupancy_count<>(typeof(h.dqi2_occupancy_count))'');
    populated_delivery_unit_size_cnt := COUNT(GROUP,h.delivery_unit_size <> (TYPEOF(h.delivery_unit_size))'');
    populated_delivery_unit_size_pcnt := AVE(GROUP,IF(h.delivery_unit_size = (TYPEOF(h.delivery_unit_size))'',0,100));
    maxlength_delivery_unit_size := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.delivery_unit_size)));
    avelength_delivery_unit_size := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.delivery_unit_size)),h.delivery_unit_size<>(typeof(h.delivery_unit_size))'');
    populated_household_arrival_date_cnt := COUNT(GROUP,h.household_arrival_date <> (TYPEOF(h.household_arrival_date))'');
    populated_household_arrival_date_pcnt := AVE(GROUP,IF(h.household_arrival_date = (TYPEOF(h.household_arrival_date))'',0,100));
    maxlength_household_arrival_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.household_arrival_date)));
    avelength_household_arrival_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.household_arrival_date)),h.household_arrival_date<>(typeof(h.household_arrival_date))'');
    populated_area_code_cnt := COUNT(GROUP,h.area_code <> (TYPEOF(h.area_code))'');
    populated_area_code_pcnt := AVE(GROUP,IF(h.area_code = (TYPEOF(h.area_code))'',0,100));
    maxlength_area_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.area_code)));
    avelength_area_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.area_code)),h.area_code<>(typeof(h.area_code))'');
    populated_phone_number_cnt := COUNT(GROUP,h.phone_number <> (TYPEOF(h.phone_number))'');
    populated_phone_number_pcnt := AVE(GROUP,IF(h.phone_number = (TYPEOF(h.phone_number))'',0,100));
    maxlength_phone_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)));
    avelength_phone_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_number)),h.phone_number<>(typeof(h.phone_number))'');
    populated_telephone_number_type_cnt := COUNT(GROUP,h.telephone_number_type <> (TYPEOF(h.telephone_number_type))'');
    populated_telephone_number_type_pcnt := AVE(GROUP,IF(h.telephone_number_type = (TYPEOF(h.telephone_number_type))'',0,100));
    maxlength_telephone_number_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone_number_type)));
    avelength_telephone_number_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone_number_type)),h.telephone_number_type<>(typeof(h.telephone_number_type))'');
    populated_phone2_number_cnt := COUNT(GROUP,h.phone2_number <> (TYPEOF(h.phone2_number))'');
    populated_phone2_number_pcnt := AVE(GROUP,IF(h.phone2_number = (TYPEOF(h.phone2_number))'',0,100));
    maxlength_phone2_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone2_number)));
    avelength_phone2_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone2_number)),h.phone2_number<>(typeof(h.phone2_number))'');
    populated_telephone2_number_type_cnt := COUNT(GROUP,h.telephone2_number_type <> (TYPEOF(h.telephone2_number_type))'');
    populated_telephone2_number_type_pcnt := AVE(GROUP,IF(h.telephone2_number_type = (TYPEOF(h.telephone2_number_type))'',0,100));
    maxlength_telephone2_number_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone2_number_type)));
    avelength_telephone2_number_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone2_number_type)),h.telephone2_number_type<>(typeof(h.telephone2_number_type))'');
    populated_time_zone_cnt := COUNT(GROUP,h.time_zone <> (TYPEOF(h.time_zone))'');
    populated_time_zone_pcnt := AVE(GROUP,IF(h.time_zone = (TYPEOF(h.time_zone))'',0,100));
    maxlength_time_zone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.time_zone)));
    avelength_time_zone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.time_zone)),h.time_zone<>(typeof(h.time_zone))'');
    populated_refresh_date_cnt := COUNT(GROUP,h.refresh_date <> (TYPEOF(h.refresh_date))'');
    populated_refresh_date_pcnt := AVE(GROUP,IF(h.refresh_date = (TYPEOF(h.refresh_date))'',0,100));
    maxlength_refresh_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.refresh_date)));
    avelength_refresh_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.refresh_date)),h.refresh_date<>(typeof(h.refresh_date))'');
    populated_name_address_verification_source_cnt := COUNT(GROUP,h.name_address_verification_source <> (TYPEOF(h.name_address_verification_source))'');
    populated_name_address_verification_source_pcnt := AVE(GROUP,IF(h.name_address_verification_source = (TYPEOF(h.name_address_verification_source))'',0,100));
    maxlength_name_address_verification_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_address_verification_source)));
    avelength_name_address_verification_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_address_verification_source)),h.name_address_verification_source<>(typeof(h.name_address_verification_source))'');
    populated_drop_indicator_cnt := COUNT(GROUP,h.drop_indicator <> (TYPEOF(h.drop_indicator))'');
    populated_drop_indicator_pcnt := AVE(GROUP,IF(h.drop_indicator = (TYPEOF(h.drop_indicator))'',0,100));
    maxlength_drop_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.drop_indicator)));
    avelength_drop_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.drop_indicator)),h.drop_indicator<>(typeof(h.drop_indicator))'');
    populated_do_not_mail_flag_cnt := COUNT(GROUP,h.do_not_mail_flag <> (TYPEOF(h.do_not_mail_flag))'');
    populated_do_not_mail_flag_pcnt := AVE(GROUP,IF(h.do_not_mail_flag = (TYPEOF(h.do_not_mail_flag))'',0,100));
    maxlength_do_not_mail_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.do_not_mail_flag)));
    avelength_do_not_mail_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.do_not_mail_flag)),h.do_not_mail_flag<>(typeof(h.do_not_mail_flag))'');
    populated_do_not_call_flag_cnt := COUNT(GROUP,h.do_not_call_flag <> (TYPEOF(h.do_not_call_flag))'');
    populated_do_not_call_flag_pcnt := AVE(GROUP,IF(h.do_not_call_flag = (TYPEOF(h.do_not_call_flag))'',0,100));
    maxlength_do_not_call_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.do_not_call_flag)));
    avelength_do_not_call_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.do_not_call_flag)),h.do_not_call_flag<>(typeof(h.do_not_call_flag))'');
    populated_business_file_hit_flag_cnt := COUNT(GROUP,h.business_file_hit_flag <> (TYPEOF(h.business_file_hit_flag))'');
    populated_business_file_hit_flag_pcnt := AVE(GROUP,IF(h.business_file_hit_flag = (TYPEOF(h.business_file_hit_flag))'',0,100));
    maxlength_business_file_hit_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_file_hit_flag)));
    avelength_business_file_hit_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.business_file_hit_flag)),h.business_file_hit_flag<>(typeof(h.business_file_hit_flag))'');
    populated_spouse_title_cnt := COUNT(GROUP,h.spouse_title <> (TYPEOF(h.spouse_title))'');
    populated_spouse_title_pcnt := AVE(GROUP,IF(h.spouse_title = (TYPEOF(h.spouse_title))'',0,100));
    maxlength_spouse_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_title)));
    avelength_spouse_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_title)),h.spouse_title<>(typeof(h.spouse_title))'');
    populated_spouse_fname_cnt := COUNT(GROUP,h.spouse_fname <> (TYPEOF(h.spouse_fname))'');
    populated_spouse_fname_pcnt := AVE(GROUP,IF(h.spouse_fname = (TYPEOF(h.spouse_fname))'',0,100));
    maxlength_spouse_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_fname)));
    avelength_spouse_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_fname)),h.spouse_fname<>(typeof(h.spouse_fname))'');
    populated_spouse_mname_cnt := COUNT(GROUP,h.spouse_mname <> (TYPEOF(h.spouse_mname))'');
    populated_spouse_mname_pcnt := AVE(GROUP,IF(h.spouse_mname = (TYPEOF(h.spouse_mname))'',0,100));
    maxlength_spouse_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_mname)));
    avelength_spouse_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_mname)),h.spouse_mname<>(typeof(h.spouse_mname))'');
    populated_spouse_lname_cnt := COUNT(GROUP,h.spouse_lname <> (TYPEOF(h.spouse_lname))'');
    populated_spouse_lname_pcnt := AVE(GROUP,IF(h.spouse_lname = (TYPEOF(h.spouse_lname))'',0,100));
    maxlength_spouse_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_lname)));
    avelength_spouse_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_lname)),h.spouse_lname<>(typeof(h.spouse_lname))'');
    populated_spouse_name_suffix_cnt := COUNT(GROUP,h.spouse_name_suffix <> (TYPEOF(h.spouse_name_suffix))'');
    populated_spouse_name_suffix_pcnt := AVE(GROUP,IF(h.spouse_name_suffix = (TYPEOF(h.spouse_name_suffix))'',0,100));
    maxlength_spouse_name_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_name_suffix)));
    avelength_spouse_name_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_name_suffix)),h.spouse_name_suffix<>(typeof(h.spouse_name_suffix))'');
    populated_spouse_fname_orig_cnt := COUNT(GROUP,h.spouse_fname_orig <> (TYPEOF(h.spouse_fname_orig))'');
    populated_spouse_fname_orig_pcnt := AVE(GROUP,IF(h.spouse_fname_orig = (TYPEOF(h.spouse_fname_orig))'',0,100));
    maxlength_spouse_fname_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_fname_orig)));
    avelength_spouse_fname_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_fname_orig)),h.spouse_fname_orig<>(typeof(h.spouse_fname_orig))'');
    populated_spouse_mname_orig_cnt := COUNT(GROUP,h.spouse_mname_orig <> (TYPEOF(h.spouse_mname_orig))'');
    populated_spouse_mname_orig_pcnt := AVE(GROUP,IF(h.spouse_mname_orig = (TYPEOF(h.spouse_mname_orig))'',0,100));
    maxlength_spouse_mname_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_mname_orig)));
    avelength_spouse_mname_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_mname_orig)),h.spouse_mname_orig<>(typeof(h.spouse_mname_orig))'');
    populated_spouse_lname_orig_cnt := COUNT(GROUP,h.spouse_lname_orig <> (TYPEOF(h.spouse_lname_orig))'');
    populated_spouse_lname_orig_pcnt := AVE(GROUP,IF(h.spouse_lname_orig = (TYPEOF(h.spouse_lname_orig))'',0,100));
    maxlength_spouse_lname_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_lname_orig)));
    avelength_spouse_lname_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_lname_orig)),h.spouse_lname_orig<>(typeof(h.spouse_lname_orig))'');
    populated_spouse_name_suffix_orig_cnt := COUNT(GROUP,h.spouse_name_suffix_orig <> (TYPEOF(h.spouse_name_suffix_orig))'');
    populated_spouse_name_suffix_orig_pcnt := AVE(GROUP,IF(h.spouse_name_suffix_orig = (TYPEOF(h.spouse_name_suffix_orig))'',0,100));
    maxlength_spouse_name_suffix_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_name_suffix_orig)));
    avelength_spouse_name_suffix_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_name_suffix_orig)),h.spouse_name_suffix_orig<>(typeof(h.spouse_name_suffix_orig))'');
    populated_spouse_title_orig_cnt := COUNT(GROUP,h.spouse_title_orig <> (TYPEOF(h.spouse_title_orig))'');
    populated_spouse_title_orig_pcnt := AVE(GROUP,IF(h.spouse_title_orig = (TYPEOF(h.spouse_title_orig))'',0,100));
    maxlength_spouse_title_orig := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_title_orig)));
    avelength_spouse_title_orig := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_title_orig)),h.spouse_title_orig<>(typeof(h.spouse_title_orig))'');
    populated_spouse_gender_cnt := COUNT(GROUP,h.spouse_gender <> (TYPEOF(h.spouse_gender))'');
    populated_spouse_gender_pcnt := AVE(GROUP,IF(h.spouse_gender = (TYPEOF(h.spouse_gender))'',0,100));
    maxlength_spouse_gender := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_gender)));
    avelength_spouse_gender := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_gender)),h.spouse_gender<>(typeof(h.spouse_gender))'');
    populated_spouse_date_of_birth_cnt := COUNT(GROUP,h.spouse_date_of_birth <> (TYPEOF(h.spouse_date_of_birth))'');
    populated_spouse_date_of_birth_pcnt := AVE(GROUP,IF(h.spouse_date_of_birth = (TYPEOF(h.spouse_date_of_birth))'',0,100));
    maxlength_spouse_date_of_birth := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_date_of_birth)));
    avelength_spouse_date_of_birth := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_date_of_birth)),h.spouse_date_of_birth<>(typeof(h.spouse_date_of_birth))'');
    populated_spouse_indicator_cnt := COUNT(GROUP,h.spouse_indicator <> (TYPEOF(h.spouse_indicator))'');
    populated_spouse_indicator_pcnt := AVE(GROUP,IF(h.spouse_indicator = (TYPEOF(h.spouse_indicator))'',0,100));
    maxlength_spouse_indicator := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_indicator)));
    avelength_spouse_indicator := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spouse_indicator)),h.spouse_indicator<>(typeof(h.spouse_indicator))'');
    populated_household_income_cnt := COUNT(GROUP,h.household_income <> (TYPEOF(h.household_income))'');
    populated_household_income_pcnt := AVE(GROUP,IF(h.household_income = (TYPEOF(h.household_income))'',0,100));
    maxlength_household_income := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.household_income)));
    avelength_household_income := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.household_income)),h.household_income<>(typeof(h.household_income))'');
    populated_find_income_in_1000s_cnt := COUNT(GROUP,h.find_income_in_1000s <> (TYPEOF(h.find_income_in_1000s))'');
    populated_find_income_in_1000s_pcnt := AVE(GROUP,IF(h.find_income_in_1000s = (TYPEOF(h.find_income_in_1000s))'',0,100));
    maxlength_find_income_in_1000s := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.find_income_in_1000s)));
    avelength_find_income_in_1000s := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.find_income_in_1000s)),h.find_income_in_1000s<>(typeof(h.find_income_in_1000s))'');
    populated_phhincomeunder25k_cnt := COUNT(GROUP,h.phhincomeunder25k <> (TYPEOF(h.phhincomeunder25k))'');
    populated_phhincomeunder25k_pcnt := AVE(GROUP,IF(h.phhincomeunder25k = (TYPEOF(h.phhincomeunder25k))'',0,100));
    maxlength_phhincomeunder25k := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phhincomeunder25k)));
    avelength_phhincomeunder25k := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phhincomeunder25k)),h.phhincomeunder25k<>(typeof(h.phhincomeunder25k))'');
    populated_phhincome50kplus_cnt := COUNT(GROUP,h.phhincome50kplus <> (TYPEOF(h.phhincome50kplus))'');
    populated_phhincome50kplus_pcnt := AVE(GROUP,IF(h.phhincome50kplus = (TYPEOF(h.phhincome50kplus))'',0,100));
    maxlength_phhincome50kplus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phhincome50kplus)));
    avelength_phhincome50kplus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phhincome50kplus)),h.phhincome50kplus<>(typeof(h.phhincome50kplus))'');
    populated_phhincome200kplus_cnt := COUNT(GROUP,h.phhincome200kplus <> (TYPEOF(h.phhincome200kplus))'');
    populated_phhincome200kplus_pcnt := AVE(GROUP,IF(h.phhincome200kplus = (TYPEOF(h.phhincome200kplus))'',0,100));
    maxlength_phhincome200kplus := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phhincome200kplus)));
    avelength_phhincome200kplus := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phhincome200kplus)),h.phhincome200kplus<>(typeof(h.phhincome200kplus))'');
    populated_medianhhincome_cnt := COUNT(GROUP,h.medianhhincome <> (TYPEOF(h.medianhhincome))'');
    populated_medianhhincome_pcnt := AVE(GROUP,IF(h.medianhhincome = (TYPEOF(h.medianhhincome))'',0,100));
    maxlength_medianhhincome := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.medianhhincome)));
    avelength_medianhhincome := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.medianhhincome)),h.medianhhincome<>(typeof(h.medianhhincome))'');
    populated_own_rent_cnt := COUNT(GROUP,h.own_rent <> (TYPEOF(h.own_rent))'');
    populated_own_rent_pcnt := AVE(GROUP,IF(h.own_rent = (TYPEOF(h.own_rent))'',0,100));
    maxlength_own_rent := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.own_rent)));
    avelength_own_rent := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.own_rent)),h.own_rent<>(typeof(h.own_rent))'');
    populated_homeowner_source_code_cnt := COUNT(GROUP,h.homeowner_source_code <> (TYPEOF(h.homeowner_source_code))'');
    populated_homeowner_source_code_pcnt := AVE(GROUP,IF(h.homeowner_source_code = (TYPEOF(h.homeowner_source_code))'',0,100));
    maxlength_homeowner_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.homeowner_source_code)));
    avelength_homeowner_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.homeowner_source_code)),h.homeowner_source_code<>(typeof(h.homeowner_source_code))'');
    populated_telephone_acquisition_date_cnt := COUNT(GROUP,h.telephone_acquisition_date <> (TYPEOF(h.telephone_acquisition_date))'');
    populated_telephone_acquisition_date_pcnt := AVE(GROUP,IF(h.telephone_acquisition_date = (TYPEOF(h.telephone_acquisition_date))'',0,100));
    maxlength_telephone_acquisition_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone_acquisition_date)));
    avelength_telephone_acquisition_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.telephone_acquisition_date)),h.telephone_acquisition_date<>(typeof(h.telephone_acquisition_date))'');
    populated_recency_date_cnt := COUNT(GROUP,h.recency_date <> (TYPEOF(h.recency_date))'');
    populated_recency_date_pcnt := AVE(GROUP,IF(h.recency_date = (TYPEOF(h.recency_date))'',0,100));
    maxlength_recency_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.recency_date)));
    avelength_recency_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.recency_date)),h.recency_date<>(typeof(h.recency_date))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_fname_orig_pcnt *   0.00 / 100 + T.Populated_mname_orig_pcnt *   0.00 / 100 + T.Populated_lname_orig_pcnt *   0.00 / 100 + T.Populated_name_suffix_orig_pcnt *   0.00 / 100 + T.Populated_title_orig_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_hhid_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_phone_fordid_pcnt *   0.00 / 100 + T.Populated_gender_pcnt *   0.00 / 100 + T.Populated_date_of_birth_pcnt *   0.00 / 100 + T.Populated_address_type_pcnt *   0.00 / 100 + T.Populated_demographic_level_indicator_pcnt *   0.00 / 100 + T.Populated_length_of_residence_pcnt *   0.00 / 100 + T.Populated_location_type_pcnt *   0.00 / 100 + T.Populated_dqi2_occupancy_count_pcnt *   0.00 / 100 + T.Populated_delivery_unit_size_pcnt *   0.00 / 100 + T.Populated_household_arrival_date_pcnt *   0.00 / 100 + T.Populated_area_code_pcnt *   0.00 / 100 + T.Populated_phone_number_pcnt *   0.00 / 100 + T.Populated_telephone_number_type_pcnt *   0.00 / 100 + T.Populated_phone2_number_pcnt *   0.00 / 100 + T.Populated_telephone2_number_type_pcnt *   0.00 / 100 + T.Populated_time_zone_pcnt *   0.00 / 100 + T.Populated_refresh_date_pcnt *   0.00 / 100 + T.Populated_name_address_verification_source_pcnt *   0.00 / 100 + T.Populated_drop_indicator_pcnt *   0.00 / 100 + T.Populated_do_not_mail_flag_pcnt *   0.00 / 100 + T.Populated_do_not_call_flag_pcnt *   0.00 / 100 + T.Populated_business_file_hit_flag_pcnt *   0.00 / 100 + T.Populated_spouse_title_pcnt *   0.00 / 100 + T.Populated_spouse_fname_pcnt *   0.00 / 100 + T.Populated_spouse_mname_pcnt *   0.00 / 100 + T.Populated_spouse_lname_pcnt *   0.00 / 100 + T.Populated_spouse_name_suffix_pcnt *   0.00 / 100 + T.Populated_spouse_fname_orig_pcnt *   0.00 / 100 + T.Populated_spouse_mname_orig_pcnt *   0.00 / 100 + T.Populated_spouse_lname_orig_pcnt *   0.00 / 100 + T.Populated_spouse_name_suffix_orig_pcnt *   0.00 / 100 + T.Populated_spouse_title_orig_pcnt *   0.00 / 100 + T.Populated_spouse_gender_pcnt *   0.00 / 100 + T.Populated_spouse_date_of_birth_pcnt *   0.00 / 100 + T.Populated_spouse_indicator_pcnt *   0.00 / 100 + T.Populated_household_income_pcnt *   0.00 / 100 + T.Populated_find_income_in_1000s_pcnt *   0.00 / 100 + T.Populated_phhincomeunder25k_pcnt *   0.00 / 100 + T.Populated_phhincome50kplus_pcnt *   0.00 / 100 + T.Populated_phhincome200kplus_pcnt *   0.00 / 100 + T.Populated_medianhhincome_pcnt *   0.00 / 100 + T.Populated_own_rent_pcnt *   0.00 / 100 + T.Populated_homeowner_source_code_pcnt *   0.00 / 100 + T.Populated_telephone_acquisition_date_pcnt *   0.00 / 100 + T.Populated_recency_date_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'title','fname','mname','lname','name_suffix','name_score','fname_orig','mname_orig','lname_orig','name_suffix_orig','title_orig','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','hhid','did','did_score','phone_fordid','gender','date_of_birth','address_type','demographic_level_indicator','length_of_residence','location_type','dqi2_occupancy_count','delivery_unit_size','household_arrival_date','area_code','phone_number','telephone_number_type','phone2_number','telephone2_number_type','time_zone','refresh_date','name_address_verification_source','drop_indicator','do_not_mail_flag','do_not_call_flag','business_file_hit_flag','spouse_title','spouse_fname','spouse_mname','spouse_lname','spouse_name_suffix','spouse_fname_orig','spouse_mname_orig','spouse_lname_orig','spouse_name_suffix_orig','spouse_title_orig','spouse_gender','spouse_date_of_birth','spouse_indicator','household_income','find_income_in_1000s','phhincomeunder25k','phhincome50kplus','phhincome200kplus','medianhhincome','own_rent','homeowner_source_code','telephone_acquisition_date','recency_date','source');
  SELF.populated_pcnt := CHOOSE(C,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_fname_orig_pcnt,le.populated_mname_orig_pcnt,le.populated_lname_orig_pcnt,le.populated_name_suffix_orig_pcnt,le.populated_title_orig_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt,le.populated_hhid_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_phone_fordid_pcnt,le.populated_gender_pcnt,le.populated_date_of_birth_pcnt,le.populated_address_type_pcnt,le.populated_demographic_level_indicator_pcnt,le.populated_length_of_residence_pcnt,le.populated_location_type_pcnt,le.populated_dqi2_occupancy_count_pcnt,le.populated_delivery_unit_size_pcnt,le.populated_household_arrival_date_pcnt,le.populated_area_code_pcnt,le.populated_phone_number_pcnt,le.populated_telephone_number_type_pcnt,le.populated_phone2_number_pcnt,le.populated_telephone2_number_type_pcnt,le.populated_time_zone_pcnt,le.populated_refresh_date_pcnt,le.populated_name_address_verification_source_pcnt,le.populated_drop_indicator_pcnt,le.populated_do_not_mail_flag_pcnt,le.populated_do_not_call_flag_pcnt,le.populated_business_file_hit_flag_pcnt,le.populated_spouse_title_pcnt,le.populated_spouse_fname_pcnt,le.populated_spouse_mname_pcnt,le.populated_spouse_lname_pcnt,le.populated_spouse_name_suffix_pcnt,le.populated_spouse_fname_orig_pcnt,le.populated_spouse_mname_orig_pcnt,le.populated_spouse_lname_orig_pcnt,le.populated_spouse_name_suffix_orig_pcnt,le.populated_spouse_title_orig_pcnt,le.populated_spouse_gender_pcnt,le.populated_spouse_date_of_birth_pcnt,le.populated_spouse_indicator_pcnt,le.populated_household_income_pcnt,le.populated_find_income_in_1000s_pcnt,le.populated_phhincomeunder25k_pcnt,le.populated_phhincome50kplus_pcnt,le.populated_phhincome200kplus_pcnt,le.populated_medianhhincome_pcnt,le.populated_own_rent_pcnt,le.populated_homeowner_source_code_pcnt,le.populated_telephone_acquisition_date_pcnt,le.populated_recency_date_pcnt,le.populated_source_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_fname_orig,le.maxlength_mname_orig,le.maxlength_lname_orig,le.maxlength_name_suffix_orig,le.maxlength_title_orig,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat,le.maxlength_hhid,le.maxlength_did,le.maxlength_did_score,le.maxlength_phone_fordid,le.maxlength_gender,le.maxlength_date_of_birth,le.maxlength_address_type,le.maxlength_demographic_level_indicator,le.maxlength_length_of_residence,le.maxlength_location_type,le.maxlength_dqi2_occupancy_count,le.maxlength_delivery_unit_size,le.maxlength_household_arrival_date,le.maxlength_area_code,le.maxlength_phone_number,le.maxlength_telephone_number_type,le.maxlength_phone2_number,le.maxlength_telephone2_number_type,le.maxlength_time_zone,le.maxlength_refresh_date,le.maxlength_name_address_verification_source,le.maxlength_drop_indicator,le.maxlength_do_not_mail_flag,le.maxlength_do_not_call_flag,le.maxlength_business_file_hit_flag,le.maxlength_spouse_title,le.maxlength_spouse_fname,le.maxlength_spouse_mname,le.maxlength_spouse_lname,le.maxlength_spouse_name_suffix,le.maxlength_spouse_fname_orig,le.maxlength_spouse_mname_orig,le.maxlength_spouse_lname_orig,le.maxlength_spouse_name_suffix_orig,le.maxlength_spouse_title_orig,le.maxlength_spouse_gender,le.maxlength_spouse_date_of_birth,le.maxlength_spouse_indicator,le.maxlength_household_income,le.maxlength_find_income_in_1000s,le.maxlength_phhincomeunder25k,le.maxlength_phhincome50kplus,le.maxlength_phhincome200kplus,le.maxlength_medianhhincome,le.maxlength_own_rent,le.maxlength_homeowner_source_code,le.maxlength_telephone_acquisition_date,le.maxlength_recency_date,le.maxlength_source);
  SELF.avelength := CHOOSE(C,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_fname_orig,le.avelength_mname_orig,le.avelength_lname_orig,le.avelength_name_suffix_orig,le.avelength_title_orig,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat,le.avelength_hhid,le.avelength_did,le.avelength_did_score,le.avelength_phone_fordid,le.avelength_gender,le.avelength_date_of_birth,le.avelength_address_type,le.avelength_demographic_level_indicator,le.avelength_length_of_residence,le.avelength_location_type,le.avelength_dqi2_occupancy_count,le.avelength_delivery_unit_size,le.avelength_household_arrival_date,le.avelength_area_code,le.avelength_phone_number,le.avelength_telephone_number_type,le.avelength_phone2_number,le.avelength_telephone2_number_type,le.avelength_time_zone,le.avelength_refresh_date,le.avelength_name_address_verification_source,le.avelength_drop_indicator,le.avelength_do_not_mail_flag,le.avelength_do_not_call_flag,le.avelength_business_file_hit_flag,le.avelength_spouse_title,le.avelength_spouse_fname,le.avelength_spouse_mname,le.avelength_spouse_lname,le.avelength_spouse_name_suffix,le.avelength_spouse_fname_orig,le.avelength_spouse_mname_orig,le.avelength_spouse_lname_orig,le.avelength_spouse_name_suffix_orig,le.avelength_spouse_title_orig,le.avelength_spouse_gender,le.avelength_spouse_date_of_birth,le.avelength_spouse_indicator,le.avelength_household_income,le.avelength_find_income_in_1000s,le.avelength_phhincomeunder25k,le.avelength_phhincome50kplus,le.avelength_phhincome200kplus,le.avelength_medianhhincome,le.avelength_own_rent,le.avelength_homeowner_source_code,le.avelength_telephone_acquisition_date,le.avelength_recency_date,le.avelength_source);
END;
EXPORT invSummary := NORMALIZE(summary0, 86, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.fname_orig),TRIM((SALT311.StrType)le.mname_orig),TRIM((SALT311.StrType)le.lname_orig),TRIM((SALT311.StrType)le.name_suffix_orig),TRIM((SALT311.StrType)le.title_orig),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.phone_fordid),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.demographic_level_indicator),TRIM((SALT311.StrType)le.length_of_residence),TRIM((SALT311.StrType)le.location_type),TRIM((SALT311.StrType)le.dqi2_occupancy_count),TRIM((SALT311.StrType)le.delivery_unit_size),TRIM((SALT311.StrType)le.household_arrival_date),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.telephone_number_type),TRIM((SALT311.StrType)le.phone2_number),TRIM((SALT311.StrType)le.telephone2_number_type),TRIM((SALT311.StrType)le.time_zone),TRIM((SALT311.StrType)le.refresh_date),TRIM((SALT311.StrType)le.name_address_verification_source),TRIM((SALT311.StrType)le.drop_indicator),TRIM((SALT311.StrType)le.do_not_mail_flag),TRIM((SALT311.StrType)le.do_not_call_flag),TRIM((SALT311.StrType)le.business_file_hit_flag),TRIM((SALT311.StrType)le.spouse_title),TRIM((SALT311.StrType)le.spouse_fname),TRIM((SALT311.StrType)le.spouse_mname),TRIM((SALT311.StrType)le.spouse_lname),TRIM((SALT311.StrType)le.spouse_name_suffix),TRIM((SALT311.StrType)le.spouse_fname_orig),TRIM((SALT311.StrType)le.spouse_mname_orig),TRIM((SALT311.StrType)le.spouse_lname_orig),TRIM((SALT311.StrType)le.spouse_name_suffix_orig),TRIM((SALT311.StrType)le.spouse_title_orig),TRIM((SALT311.StrType)le.spouse_gender),TRIM((SALT311.StrType)le.spouse_date_of_birth),TRIM((SALT311.StrType)le.spouse_indicator),TRIM((SALT311.StrType)le.household_income),TRIM((SALT311.StrType)le.find_income_in_1000s),TRIM((SALT311.StrType)le.phhincomeunder25k),TRIM((SALT311.StrType)le.phhincome50kplus),TRIM((SALT311.StrType)le.phhincome200kplus),TRIM((SALT311.StrType)le.medianhhincome),TRIM((SALT311.StrType)le.own_rent),TRIM((SALT311.StrType)le.homeowner_source_code),TRIM((SALT311.StrType)le.telephone_acquisition_date),TRIM((SALT311.StrType)le.recency_date),TRIM((SALT311.StrType)le.source)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,86,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 86);
  SELF.FldNo2 := 1 + (C % 86);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.fname_orig),TRIM((SALT311.StrType)le.mname_orig),TRIM((SALT311.StrType)le.lname_orig),TRIM((SALT311.StrType)le.name_suffix_orig),TRIM((SALT311.StrType)le.title_orig),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.phone_fordid),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.demographic_level_indicator),TRIM((SALT311.StrType)le.length_of_residence),TRIM((SALT311.StrType)le.location_type),TRIM((SALT311.StrType)le.dqi2_occupancy_count),TRIM((SALT311.StrType)le.delivery_unit_size),TRIM((SALT311.StrType)le.household_arrival_date),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.telephone_number_type),TRIM((SALT311.StrType)le.phone2_number),TRIM((SALT311.StrType)le.telephone2_number_type),TRIM((SALT311.StrType)le.time_zone),TRIM((SALT311.StrType)le.refresh_date),TRIM((SALT311.StrType)le.name_address_verification_source),TRIM((SALT311.StrType)le.drop_indicator),TRIM((SALT311.StrType)le.do_not_mail_flag),TRIM((SALT311.StrType)le.do_not_call_flag),TRIM((SALT311.StrType)le.business_file_hit_flag),TRIM((SALT311.StrType)le.spouse_title),TRIM((SALT311.StrType)le.spouse_fname),TRIM((SALT311.StrType)le.spouse_mname),TRIM((SALT311.StrType)le.spouse_lname),TRIM((SALT311.StrType)le.spouse_name_suffix),TRIM((SALT311.StrType)le.spouse_fname_orig),TRIM((SALT311.StrType)le.spouse_mname_orig),TRIM((SALT311.StrType)le.spouse_lname_orig),TRIM((SALT311.StrType)le.spouse_name_suffix_orig),TRIM((SALT311.StrType)le.spouse_title_orig),TRIM((SALT311.StrType)le.spouse_gender),TRIM((SALT311.StrType)le.spouse_date_of_birth),TRIM((SALT311.StrType)le.spouse_indicator),TRIM((SALT311.StrType)le.household_income),TRIM((SALT311.StrType)le.find_income_in_1000s),TRIM((SALT311.StrType)le.phhincomeunder25k),TRIM((SALT311.StrType)le.phhincome50kplus),TRIM((SALT311.StrType)le.phhincome200kplus),TRIM((SALT311.StrType)le.medianhhincome),TRIM((SALT311.StrType)le.own_rent),TRIM((SALT311.StrType)le.homeowner_source_code),TRIM((SALT311.StrType)le.telephone_acquisition_date),TRIM((SALT311.StrType)le.recency_date),TRIM((SALT311.StrType)le.source)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.title),TRIM((SALT311.StrType)le.fname),TRIM((SALT311.StrType)le.mname),TRIM((SALT311.StrType)le.lname),TRIM((SALT311.StrType)le.name_suffix),TRIM((SALT311.StrType)le.name_score),TRIM((SALT311.StrType)le.fname_orig),TRIM((SALT311.StrType)le.mname_orig),TRIM((SALT311.StrType)le.lname_orig),TRIM((SALT311.StrType)le.name_suffix_orig),TRIM((SALT311.StrType)le.title_orig),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat),IF (le.hhid <> 0,TRIM((SALT311.StrType)le.hhid), ''),IF (le.did <> 0,TRIM((SALT311.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT311.StrType)le.did_score), ''),TRIM((SALT311.StrType)le.phone_fordid),TRIM((SALT311.StrType)le.gender),TRIM((SALT311.StrType)le.date_of_birth),TRIM((SALT311.StrType)le.address_type),TRIM((SALT311.StrType)le.demographic_level_indicator),TRIM((SALT311.StrType)le.length_of_residence),TRIM((SALT311.StrType)le.location_type),TRIM((SALT311.StrType)le.dqi2_occupancy_count),TRIM((SALT311.StrType)le.delivery_unit_size),TRIM((SALT311.StrType)le.household_arrival_date),TRIM((SALT311.StrType)le.area_code),TRIM((SALT311.StrType)le.phone_number),TRIM((SALT311.StrType)le.telephone_number_type),TRIM((SALT311.StrType)le.phone2_number),TRIM((SALT311.StrType)le.telephone2_number_type),TRIM((SALT311.StrType)le.time_zone),TRIM((SALT311.StrType)le.refresh_date),TRIM((SALT311.StrType)le.name_address_verification_source),TRIM((SALT311.StrType)le.drop_indicator),TRIM((SALT311.StrType)le.do_not_mail_flag),TRIM((SALT311.StrType)le.do_not_call_flag),TRIM((SALT311.StrType)le.business_file_hit_flag),TRIM((SALT311.StrType)le.spouse_title),TRIM((SALT311.StrType)le.spouse_fname),TRIM((SALT311.StrType)le.spouse_mname),TRIM((SALT311.StrType)le.spouse_lname),TRIM((SALT311.StrType)le.spouse_name_suffix),TRIM((SALT311.StrType)le.spouse_fname_orig),TRIM((SALT311.StrType)le.spouse_mname_orig),TRIM((SALT311.StrType)le.spouse_lname_orig),TRIM((SALT311.StrType)le.spouse_name_suffix_orig),TRIM((SALT311.StrType)le.spouse_title_orig),TRIM((SALT311.StrType)le.spouse_gender),TRIM((SALT311.StrType)le.spouse_date_of_birth),TRIM((SALT311.StrType)le.spouse_indicator),TRIM((SALT311.StrType)le.household_income),TRIM((SALT311.StrType)le.find_income_in_1000s),TRIM((SALT311.StrType)le.phhincomeunder25k),TRIM((SALT311.StrType)le.phhincome50kplus),TRIM((SALT311.StrType)le.phhincome200kplus),TRIM((SALT311.StrType)le.medianhhincome),TRIM((SALT311.StrType)le.own_rent),TRIM((SALT311.StrType)le.homeowner_source_code),TRIM((SALT311.StrType)le.telephone_acquisition_date),TRIM((SALT311.StrType)le.recency_date),TRIM((SALT311.StrType)le.source)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),86*86,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'title'}
      ,{2,'fname'}
      ,{3,'mname'}
      ,{4,'lname'}
      ,{5,'name_suffix'}
      ,{6,'name_score'}
      ,{7,'fname_orig'}
      ,{8,'mname_orig'}
      ,{9,'lname_orig'}
      ,{10,'name_suffix_orig'}
      ,{11,'title_orig'}
      ,{12,'prim_range'}
      ,{13,'predir'}
      ,{14,'prim_name'}
      ,{15,'addr_suffix'}
      ,{16,'postdir'}
      ,{17,'unit_desig'}
      ,{18,'sec_range'}
      ,{19,'p_city_name'}
      ,{20,'v_city_name'}
      ,{21,'st'}
      ,{22,'zip'}
      ,{23,'zip4'}
      ,{24,'cart'}
      ,{25,'cr_sort_sz'}
      ,{26,'lot'}
      ,{27,'lot_order'}
      ,{28,'dbpc'}
      ,{29,'chk_digit'}
      ,{30,'rec_type'}
      ,{31,'county'}
      ,{32,'geo_lat'}
      ,{33,'geo_long'}
      ,{34,'msa'}
      ,{35,'geo_blk'}
      ,{36,'geo_match'}
      ,{37,'err_stat'}
      ,{38,'hhid'}
      ,{39,'did'}
      ,{40,'did_score'}
      ,{41,'phone_fordid'}
      ,{42,'gender'}
      ,{43,'date_of_birth'}
      ,{44,'address_type'}
      ,{45,'demographic_level_indicator'}
      ,{46,'length_of_residence'}
      ,{47,'location_type'}
      ,{48,'dqi2_occupancy_count'}
      ,{49,'delivery_unit_size'}
      ,{50,'household_arrival_date'}
      ,{51,'area_code'}
      ,{52,'phone_number'}
      ,{53,'telephone_number_type'}
      ,{54,'phone2_number'}
      ,{55,'telephone2_number_type'}
      ,{56,'time_zone'}
      ,{57,'refresh_date'}
      ,{58,'name_address_verification_source'}
      ,{59,'drop_indicator'}
      ,{60,'do_not_mail_flag'}
      ,{61,'do_not_call_flag'}
      ,{62,'business_file_hit_flag'}
      ,{63,'spouse_title'}
      ,{64,'spouse_fname'}
      ,{65,'spouse_mname'}
      ,{66,'spouse_lname'}
      ,{67,'spouse_name_suffix'}
      ,{68,'spouse_fname_orig'}
      ,{69,'spouse_mname_orig'}
      ,{70,'spouse_lname_orig'}
      ,{71,'spouse_name_suffix_orig'}
      ,{72,'spouse_title_orig'}
      ,{73,'spouse_gender'}
      ,{74,'spouse_date_of_birth'}
      ,{75,'spouse_indicator'}
      ,{76,'household_income'}
      ,{77,'find_income_in_1000s'}
      ,{78,'phhincomeunder25k'}
      ,{79,'phhincome50kplus'}
      ,{80,'phhincome200kplus'}
      ,{81,'medianhhincome'}
      ,{82,'own_rent'}
      ,{83,'homeowner_source_code'}
      ,{84,'telephone_acquisition_date'}
      ,{85,'recency_date'}
      ,{86,'source'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_title((SALT311.StrType)le.title),
    Fields.InValid_fname((SALT311.StrType)le.fname),
    Fields.InValid_mname((SALT311.StrType)le.mname),
    Fields.InValid_lname((SALT311.StrType)le.lname),
    Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix),
    Fields.InValid_name_score((SALT311.StrType)le.name_score),
    Fields.InValid_fname_orig((SALT311.StrType)le.fname_orig),
    Fields.InValid_mname_orig((SALT311.StrType)le.mname_orig),
    Fields.InValid_lname_orig((SALT311.StrType)le.lname_orig),
    Fields.InValid_name_suffix_orig((SALT311.StrType)le.name_suffix_orig),
    Fields.InValid_title_orig((SALT311.StrType)le.title_orig),
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
    Fields.InValid_hhid((SALT311.StrType)le.hhid),
    Fields.InValid_did((SALT311.StrType)le.did),
    Fields.InValid_did_score((SALT311.StrType)le.did_score),
    Fields.InValid_phone_fordid((SALT311.StrType)le.phone_fordid),
    Fields.InValid_gender((SALT311.StrType)le.gender),
    Fields.InValid_date_of_birth((SALT311.StrType)le.date_of_birth),
    Fields.InValid_address_type((SALT311.StrType)le.address_type),
    Fields.InValid_demographic_level_indicator((SALT311.StrType)le.demographic_level_indicator),
    Fields.InValid_length_of_residence((SALT311.StrType)le.length_of_residence),
    Fields.InValid_location_type((SALT311.StrType)le.location_type),
    Fields.InValid_dqi2_occupancy_count((SALT311.StrType)le.dqi2_occupancy_count),
    Fields.InValid_delivery_unit_size((SALT311.StrType)le.delivery_unit_size),
    Fields.InValid_household_arrival_date((SALT311.StrType)le.household_arrival_date),
    Fields.InValid_area_code((SALT311.StrType)le.area_code),
    Fields.InValid_phone_number((SALT311.StrType)le.phone_number),
    Fields.InValid_telephone_number_type((SALT311.StrType)le.telephone_number_type),
    Fields.InValid_phone2_number((SALT311.StrType)le.phone2_number),
    Fields.InValid_telephone2_number_type((SALT311.StrType)le.telephone2_number_type),
    Fields.InValid_time_zone((SALT311.StrType)le.time_zone),
    Fields.InValid_refresh_date((SALT311.StrType)le.refresh_date),
    Fields.InValid_name_address_verification_source((SALT311.StrType)le.name_address_verification_source),
    Fields.InValid_drop_indicator((SALT311.StrType)le.drop_indicator),
    Fields.InValid_do_not_mail_flag((SALT311.StrType)le.do_not_mail_flag),
    Fields.InValid_do_not_call_flag((SALT311.StrType)le.do_not_call_flag),
    Fields.InValid_business_file_hit_flag((SALT311.StrType)le.business_file_hit_flag),
    Fields.InValid_spouse_title((SALT311.StrType)le.spouse_title),
    Fields.InValid_spouse_fname((SALT311.StrType)le.spouse_fname),
    Fields.InValid_spouse_mname((SALT311.StrType)le.spouse_mname),
    Fields.InValid_spouse_lname((SALT311.StrType)le.spouse_lname),
    Fields.InValid_spouse_name_suffix((SALT311.StrType)le.spouse_name_suffix),
    Fields.InValid_spouse_fname_orig((SALT311.StrType)le.spouse_fname_orig),
    Fields.InValid_spouse_mname_orig((SALT311.StrType)le.spouse_mname_orig),
    Fields.InValid_spouse_lname_orig((SALT311.StrType)le.spouse_lname_orig),
    Fields.InValid_spouse_name_suffix_orig((SALT311.StrType)le.spouse_name_suffix_orig),
    Fields.InValid_spouse_title_orig((SALT311.StrType)le.spouse_title_orig),
    Fields.InValid_spouse_gender((SALT311.StrType)le.spouse_gender),
    Fields.InValid_spouse_date_of_birth((SALT311.StrType)le.spouse_date_of_birth),
    Fields.InValid_spouse_indicator((SALT311.StrType)le.spouse_indicator),
    Fields.InValid_household_income((SALT311.StrType)le.household_income),
    Fields.InValid_find_income_in_1000s((SALT311.StrType)le.find_income_in_1000s),
    Fields.InValid_phhincomeunder25k((SALT311.StrType)le.phhincomeunder25k),
    Fields.InValid_phhincome50kplus((SALT311.StrType)le.phhincome50kplus),
    Fields.InValid_phhincome200kplus((SALT311.StrType)le.phhincome200kplus),
    Fields.InValid_medianhhincome((SALT311.StrType)le.medianhhincome),
    Fields.InValid_own_rent((SALT311.StrType)le.own_rent),
    Fields.InValid_homeowner_source_code((SALT311.StrType)le.homeowner_source_code),
    Fields.InValid_telephone_acquisition_date((SALT311.StrType)le.telephone_acquisition_date),
    Fields.InValid_recency_date((SALT311.StrType)le.recency_date),
    Fields.InValid_source((SALT311.StrType)le.source),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,86,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Unknown','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_CRSORT','Invalid_Num','Invalid_LotOrder','Invalid_Num','Invalid_Num','Invalid_RecType','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Gender','Invalid_Num','Invalid_Num','Invalid_DemographicIndicator','Invalid_Num','Invalid_LocationType','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_TelephoneNumberType','Invalid_Num','Invalid_TelephoneNumberType','Invalid_TimeZone','Invalid_Num','Invalid_YN','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_YN','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Unknown','Invalid_Num','Unknown','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_HomeownerCode','Invalid_Num','Invalid_Num','Invalid_Source');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_title(TotalErrors.ErrorNum),Fields.InValidMessage_fname(TotalErrors.ErrorNum),Fields.InValidMessage_mname(TotalErrors.ErrorNum),Fields.InValidMessage_lname(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_name_score(TotalErrors.ErrorNum),Fields.InValidMessage_fname_orig(TotalErrors.ErrorNum),Fields.InValidMessage_mname_orig(TotalErrors.ErrorNum),Fields.InValidMessage_lname_orig(TotalErrors.ErrorNum),Fields.InValidMessage_name_suffix_orig(TotalErrors.ErrorNum),Fields.InValidMessage_title_orig(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),Fields.InValidMessage_hhid(TotalErrors.ErrorNum),Fields.InValidMessage_did(TotalErrors.ErrorNum),Fields.InValidMessage_did_score(TotalErrors.ErrorNum),Fields.InValidMessage_phone_fordid(TotalErrors.ErrorNum),Fields.InValidMessage_gender(TotalErrors.ErrorNum),Fields.InValidMessage_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_address_type(TotalErrors.ErrorNum),Fields.InValidMessage_demographic_level_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_length_of_residence(TotalErrors.ErrorNum),Fields.InValidMessage_location_type(TotalErrors.ErrorNum),Fields.InValidMessage_dqi2_occupancy_count(TotalErrors.ErrorNum),Fields.InValidMessage_delivery_unit_size(TotalErrors.ErrorNum),Fields.InValidMessage_household_arrival_date(TotalErrors.ErrorNum),Fields.InValidMessage_area_code(TotalErrors.ErrorNum),Fields.InValidMessage_phone_number(TotalErrors.ErrorNum),Fields.InValidMessage_telephone_number_type(TotalErrors.ErrorNum),Fields.InValidMessage_phone2_number(TotalErrors.ErrorNum),Fields.InValidMessage_telephone2_number_type(TotalErrors.ErrorNum),Fields.InValidMessage_time_zone(TotalErrors.ErrorNum),Fields.InValidMessage_refresh_date(TotalErrors.ErrorNum),Fields.InValidMessage_name_address_verification_source(TotalErrors.ErrorNum),Fields.InValidMessage_drop_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_do_not_mail_flag(TotalErrors.ErrorNum),Fields.InValidMessage_do_not_call_flag(TotalErrors.ErrorNum),Fields.InValidMessage_business_file_hit_flag(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_title(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_fname(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_mname(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_lname(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_name_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_fname_orig(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_mname_orig(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_lname_orig(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_name_suffix_orig(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_title_orig(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_gender(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_date_of_birth(TotalErrors.ErrorNum),Fields.InValidMessage_spouse_indicator(TotalErrors.ErrorNum),Fields.InValidMessage_household_income(TotalErrors.ErrorNum),Fields.InValidMessage_find_income_in_1000s(TotalErrors.ErrorNum),Fields.InValidMessage_phhincomeunder25k(TotalErrors.ErrorNum),Fields.InValidMessage_phhincome50kplus(TotalErrors.ErrorNum),Fields.InValidMessage_phhincome200kplus(TotalErrors.ErrorNum),Fields.InValidMessage_medianhhincome(TotalErrors.ErrorNum),Fields.InValidMessage_own_rent(TotalErrors.ErrorNum),Fields.InValidMessage_homeowner_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_telephone_acquisition_date(TotalErrors.ErrorNum),Fields.InValidMessage_recency_date(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PCNSR, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
