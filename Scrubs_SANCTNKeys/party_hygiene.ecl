IMPORT SALT38,STD;
EXPORT party_hygiene(dataset(party_layout_SANCTNKeys) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_batch_number_cnt := COUNT(GROUP,h.batch_number <> (TYPEOF(h.batch_number))'');
    populated_batch_number_pcnt := AVE(GROUP,IF(h.batch_number = (TYPEOF(h.batch_number))'',0,100));
    maxlength_batch_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.batch_number)));
    avelength_batch_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.batch_number)),h.batch_number<>(typeof(h.batch_number))'');
    populated_incident_number_cnt := COUNT(GROUP,h.incident_number <> (TYPEOF(h.incident_number))'');
    populated_incident_number_pcnt := AVE(GROUP,IF(h.incident_number = (TYPEOF(h.incident_number))'',0,100));
    maxlength_incident_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_number)));
    avelength_incident_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.incident_number)),h.incident_number<>(typeof(h.incident_number))'');
    populated_party_number_cnt := COUNT(GROUP,h.party_number <> (TYPEOF(h.party_number))'');
    populated_party_number_pcnt := AVE(GROUP,IF(h.party_number = (TYPEOF(h.party_number))'',0,100));
    maxlength_party_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_number)));
    avelength_party_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_number)),h.party_number<>(typeof(h.party_number))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_order_number_cnt := COUNT(GROUP,h.order_number <> (TYPEOF(h.order_number))'');
    populated_order_number_pcnt := AVE(GROUP,IF(h.order_number = (TYPEOF(h.order_number))'',0,100));
    maxlength_order_number := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.order_number)));
    avelength_order_number := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.order_number)),h.order_number<>(typeof(h.order_number))'');
    populated_party_name_cnt := COUNT(GROUP,h.party_name <> (TYPEOF(h.party_name))'');
    populated_party_name_pcnt := AVE(GROUP,IF(h.party_name = (TYPEOF(h.party_name))'',0,100));
    maxlength_party_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_name)));
    avelength_party_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_name)),h.party_name<>(typeof(h.party_name))'');
    populated_party_position_cnt := COUNT(GROUP,h.party_position <> (TYPEOF(h.party_position))'');
    populated_party_position_pcnt := AVE(GROUP,IF(h.party_position = (TYPEOF(h.party_position))'',0,100));
    maxlength_party_position := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_position)));
    avelength_party_position := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_position)),h.party_position<>(typeof(h.party_position))'');
    populated_party_vocation_cnt := COUNT(GROUP,h.party_vocation <> (TYPEOF(h.party_vocation))'');
    populated_party_vocation_pcnt := AVE(GROUP,IF(h.party_vocation = (TYPEOF(h.party_vocation))'',0,100));
    maxlength_party_vocation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_vocation)));
    avelength_party_vocation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_vocation)),h.party_vocation<>(typeof(h.party_vocation))'');
    populated_party_firm_cnt := COUNT(GROUP,h.party_firm <> (TYPEOF(h.party_firm))'');
    populated_party_firm_pcnt := AVE(GROUP,IF(h.party_firm = (TYPEOF(h.party_firm))'',0,100));
    maxlength_party_firm := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_firm)));
    avelength_party_firm := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_firm)),h.party_firm<>(typeof(h.party_firm))'');
    populated_inaddress_cnt := COUNT(GROUP,h.inaddress <> (TYPEOF(h.inaddress))'');
    populated_inaddress_pcnt := AVE(GROUP,IF(h.inaddress = (TYPEOF(h.inaddress))'',0,100));
    maxlength_inaddress := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.inaddress)));
    avelength_inaddress := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.inaddress)),h.inaddress<>(typeof(h.inaddress))'');
    populated_incity_cnt := COUNT(GROUP,h.incity <> (TYPEOF(h.incity))'');
    populated_incity_pcnt := AVE(GROUP,IF(h.incity = (TYPEOF(h.incity))'',0,100));
    maxlength_incity := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.incity)));
    avelength_incity := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.incity)),h.incity<>(typeof(h.incity))'');
    populated_instate_cnt := COUNT(GROUP,h.instate <> (TYPEOF(h.instate))'');
    populated_instate_pcnt := AVE(GROUP,IF(h.instate = (TYPEOF(h.instate))'',0,100));
    maxlength_instate := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.instate)));
    avelength_instate := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.instate)),h.instate<>(typeof(h.instate))'');
    populated_inzip_cnt := COUNT(GROUP,h.inzip <> (TYPEOF(h.inzip))'');
    populated_inzip_pcnt := AVE(GROUP,IF(h.inzip = (TYPEOF(h.inzip))'',0,100));
    maxlength_inzip := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.inzip)));
    avelength_inzip := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.inzip)),h.inzip<>(typeof(h.inzip))'');
    populated_ssnumber_cnt := COUNT(GROUP,h.ssnumber <> (TYPEOF(h.ssnumber))'');
    populated_ssnumber_pcnt := AVE(GROUP,IF(h.ssnumber = (TYPEOF(h.ssnumber))'',0,100));
    maxlength_ssnumber := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssnumber)));
    avelength_ssnumber := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssnumber)),h.ssnumber<>(typeof(h.ssnumber))'');
    populated_fines_levied_cnt := COUNT(GROUP,h.fines_levied <> (TYPEOF(h.fines_levied))'');
    populated_fines_levied_pcnt := AVE(GROUP,IF(h.fines_levied = (TYPEOF(h.fines_levied))'',0,100));
    maxlength_fines_levied := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fines_levied)));
    avelength_fines_levied := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fines_levied)),h.fines_levied<>(typeof(h.fines_levied))'');
    populated_restitution_cnt := COUNT(GROUP,h.restitution <> (TYPEOF(h.restitution))'');
    populated_restitution_pcnt := AVE(GROUP,IF(h.restitution = (TYPEOF(h.restitution))'',0,100));
    maxlength_restitution := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.restitution)));
    avelength_restitution := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.restitution)),h.restitution<>(typeof(h.restitution))'');
    populated_ok_for_fcr_cnt := COUNT(GROUP,h.ok_for_fcr <> (TYPEOF(h.ok_for_fcr))'');
    populated_ok_for_fcr_pcnt := AVE(GROUP,IF(h.ok_for_fcr = (TYPEOF(h.ok_for_fcr))'',0,100));
    maxlength_ok_for_fcr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ok_for_fcr)));
    avelength_ok_for_fcr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ok_for_fcr)),h.ok_for_fcr<>(typeof(h.ok_for_fcr))'');
    populated_party_text_cnt := COUNT(GROUP,h.party_text <> (TYPEOF(h.party_text))'');
    populated_party_text_pcnt := AVE(GROUP,IF(h.party_text = (TYPEOF(h.party_text))'',0,100));
    maxlength_party_text := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_text)));
    avelength_party_text := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.party_text)),h.party_text<>(typeof(h.party_text))'');
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
    populated_cname_cnt := COUNT(GROUP,h.cname <> (TYPEOF(h.cname))'');
    populated_cname_pcnt := AVE(GROUP,IF(h.cname = (TYPEOF(h.cname))'',0,100));
    maxlength_cname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cname)));
    avelength_cname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cname)),h.cname<>(typeof(h.cname))'');
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
    populated_zip5_cnt := COUNT(GROUP,h.zip5 <> (TYPEOF(h.zip5))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip4_cnt := COUNT(GROUP,h.zip4 <> (TYPEOF(h.zip4))'');
    populated_zip4_pcnt := AVE(GROUP,IF(h.zip4 = (TYPEOF(h.zip4))'',0,100));
    maxlength_zip4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)));
    avelength_zip4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zip4)),h.zip4<>(typeof(h.zip4))'');
    populated_fips_state_cnt := COUNT(GROUP,h.fips_state <> (TYPEOF(h.fips_state))'');
    populated_fips_state_pcnt := AVE(GROUP,IF(h.fips_state = (TYPEOF(h.fips_state))'',0,100));
    maxlength_fips_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_state)));
    avelength_fips_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_state)),h.fips_state<>(typeof(h.fips_state))'');
    populated_fips_county_cnt := COUNT(GROUP,h.fips_county <> (TYPEOF(h.fips_county))'');
    populated_fips_county_pcnt := AVE(GROUP,IF(h.fips_county = (TYPEOF(h.fips_county))'',0,100));
    maxlength_fips_county := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)));
    avelength_fips_county := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_county)),h.fips_county<>(typeof(h.fips_county))'');
    populated_addr_rec_type_cnt := COUNT(GROUP,h.addr_rec_type <> (TYPEOF(h.addr_rec_type))'');
    populated_addr_rec_type_pcnt := AVE(GROUP,IF(h.addr_rec_type = (TYPEOF(h.addr_rec_type))'',0,100));
    maxlength_addr_rec_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_rec_type)));
    avelength_addr_rec_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.addr_rec_type)),h.addr_rec_type<>(typeof(h.addr_rec_type))'');
    populated_geo_lat_cnt := COUNT(GROUP,h.geo_lat <> (TYPEOF(h.geo_lat))'');
    populated_geo_lat_pcnt := AVE(GROUP,IF(h.geo_lat = (TYPEOF(h.geo_lat))'',0,100));
    maxlength_geo_lat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)));
    avelength_geo_lat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_lat)),h.geo_lat<>(typeof(h.geo_lat))'');
    populated_geo_long_cnt := COUNT(GROUP,h.geo_long <> (TYPEOF(h.geo_long))'');
    populated_geo_long_pcnt := AVE(GROUP,IF(h.geo_long = (TYPEOF(h.geo_long))'',0,100));
    maxlength_geo_long := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)));
    avelength_geo_long := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_long)),h.geo_long<>(typeof(h.geo_long))'');
    populated_cbsa_cnt := COUNT(GROUP,h.cbsa <> (TYPEOF(h.cbsa))'');
    populated_cbsa_pcnt := AVE(GROUP,IF(h.cbsa = (TYPEOF(h.cbsa))'',0,100));
    maxlength_cbsa := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.cbsa)));
    avelength_cbsa := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.cbsa)),h.cbsa<>(typeof(h.cbsa))'');
    populated_geo_blk_cnt := COUNT(GROUP,h.geo_blk <> (TYPEOF(h.geo_blk))'');
    populated_geo_blk_pcnt := AVE(GROUP,IF(h.geo_blk = (TYPEOF(h.geo_blk))'',0,100));
    maxlength_geo_blk := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)));
    avelength_geo_blk := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_blk)),h.geo_blk<>(typeof(h.geo_blk))'');
    populated_geo_match_cnt := COUNT(GROUP,h.geo_match <> (TYPEOF(h.geo_match))'');
    populated_geo_match_pcnt := AVE(GROUP,IF(h.geo_match = (TYPEOF(h.geo_match))'',0,100));
    maxlength_geo_match := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)));
    avelength_geo_match := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.geo_match)),h.geo_match<>(typeof(h.geo_match))'');
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
    populated_err_stat_cnt := COUNT(GROUP,h.err_stat <> (TYPEOF(h.err_stat))'');
    populated_err_stat_pcnt := AVE(GROUP,IF(h.err_stat = (TYPEOF(h.err_stat))'',0,100));
    maxlength_err_stat := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)));
    avelength_err_stat := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.err_stat)),h.err_stat<>(typeof(h.err_stat))'');
    populated_dotid_cnt := COUNT(GROUP,h.dotid <> (TYPEOF(h.dotid))'');
    populated_dotid_pcnt := AVE(GROUP,IF(h.dotid = (TYPEOF(h.dotid))'',0,100));
    maxlength_dotid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotid)));
    avelength_dotid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotid)),h.dotid<>(typeof(h.dotid))'');
    populated_dotscore_cnt := COUNT(GROUP,h.dotscore <> (TYPEOF(h.dotscore))'');
    populated_dotscore_pcnt := AVE(GROUP,IF(h.dotscore = (TYPEOF(h.dotscore))'',0,100));
    maxlength_dotscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotscore)));
    avelength_dotscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotscore)),h.dotscore<>(typeof(h.dotscore))'');
    populated_dotweight_cnt := COUNT(GROUP,h.dotweight <> (TYPEOF(h.dotweight))'');
    populated_dotweight_pcnt := AVE(GROUP,IF(h.dotweight = (TYPEOF(h.dotweight))'',0,100));
    maxlength_dotweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotweight)));
    avelength_dotweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dotweight)),h.dotweight<>(typeof(h.dotweight))'');
    populated_empid_cnt := COUNT(GROUP,h.empid <> (TYPEOF(h.empid))'');
    populated_empid_pcnt := AVE(GROUP,IF(h.empid = (TYPEOF(h.empid))'',0,100));
    maxlength_empid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empid)));
    avelength_empid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empid)),h.empid<>(typeof(h.empid))'');
    populated_empscore_cnt := COUNT(GROUP,h.empscore <> (TYPEOF(h.empscore))'');
    populated_empscore_pcnt := AVE(GROUP,IF(h.empscore = (TYPEOF(h.empscore))'',0,100));
    maxlength_empscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empscore)));
    avelength_empscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empscore)),h.empscore<>(typeof(h.empscore))'');
    populated_empweight_cnt := COUNT(GROUP,h.empweight <> (TYPEOF(h.empweight))'');
    populated_empweight_pcnt := AVE(GROUP,IF(h.empweight = (TYPEOF(h.empweight))'',0,100));
    maxlength_empweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.empweight)));
    avelength_empweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.empweight)),h.empweight<>(typeof(h.empweight))'');
    populated_powid_cnt := COUNT(GROUP,h.powid <> (TYPEOF(h.powid))'');
    populated_powid_pcnt := AVE(GROUP,IF(h.powid = (TYPEOF(h.powid))'',0,100));
    maxlength_powid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)));
    avelength_powid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powid)),h.powid<>(typeof(h.powid))'');
    populated_powscore_cnt := COUNT(GROUP,h.powscore <> (TYPEOF(h.powscore))'');
    populated_powscore_pcnt := AVE(GROUP,IF(h.powscore = (TYPEOF(h.powscore))'',0,100));
    maxlength_powscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powscore)));
    avelength_powscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powscore)),h.powscore<>(typeof(h.powscore))'');
    populated_powweight_cnt := COUNT(GROUP,h.powweight <> (TYPEOF(h.powweight))'');
    populated_powweight_pcnt := AVE(GROUP,IF(h.powweight = (TYPEOF(h.powweight))'',0,100));
    maxlength_powweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.powweight)));
    avelength_powweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.powweight)),h.powweight<>(typeof(h.powweight))'');
    populated_proxid_cnt := COUNT(GROUP,h.proxid <> (TYPEOF(h.proxid))'');
    populated_proxid_pcnt := AVE(GROUP,IF(h.proxid = (TYPEOF(h.proxid))'',0,100));
    maxlength_proxid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxid)));
    avelength_proxid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxid)),h.proxid<>(typeof(h.proxid))'');
    populated_proxscore_cnt := COUNT(GROUP,h.proxscore <> (TYPEOF(h.proxscore))'');
    populated_proxscore_pcnt := AVE(GROUP,IF(h.proxscore = (TYPEOF(h.proxscore))'',0,100));
    maxlength_proxscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxscore)));
    avelength_proxscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxscore)),h.proxscore<>(typeof(h.proxscore))'');
    populated_proxweight_cnt := COUNT(GROUP,h.proxweight <> (TYPEOF(h.proxweight))'');
    populated_proxweight_pcnt := AVE(GROUP,IF(h.proxweight = (TYPEOF(h.proxweight))'',0,100));
    maxlength_proxweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxweight)));
    avelength_proxweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.proxweight)),h.proxweight<>(typeof(h.proxweight))'');
    populated_seleid_cnt := COUNT(GROUP,h.seleid <> (TYPEOF(h.seleid))'');
    populated_seleid_pcnt := AVE(GROUP,IF(h.seleid = (TYPEOF(h.seleid))'',0,100));
    maxlength_seleid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleid)));
    avelength_seleid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleid)),h.seleid<>(typeof(h.seleid))'');
    populated_selescore_cnt := COUNT(GROUP,h.selescore <> (TYPEOF(h.selescore))'');
    populated_selescore_pcnt := AVE(GROUP,IF(h.selescore = (TYPEOF(h.selescore))'',0,100));
    maxlength_selescore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.selescore)));
    avelength_selescore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.selescore)),h.selescore<>(typeof(h.selescore))'');
    populated_seleweight_cnt := COUNT(GROUP,h.seleweight <> (TYPEOF(h.seleweight))'');
    populated_seleweight_pcnt := AVE(GROUP,IF(h.seleweight = (TYPEOF(h.seleweight))'',0,100));
    maxlength_seleweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleweight)));
    avelength_seleweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.seleweight)),h.seleweight<>(typeof(h.seleweight))'');
    populated_orgid_cnt := COUNT(GROUP,h.orgid <> (TYPEOF(h.orgid))'');
    populated_orgid_pcnt := AVE(GROUP,IF(h.orgid = (TYPEOF(h.orgid))'',0,100));
    maxlength_orgid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgid)));
    avelength_orgid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgid)),h.orgid<>(typeof(h.orgid))'');
    populated_orgscore_cnt := COUNT(GROUP,h.orgscore <> (TYPEOF(h.orgscore))'');
    populated_orgscore_pcnt := AVE(GROUP,IF(h.orgscore = (TYPEOF(h.orgscore))'',0,100));
    maxlength_orgscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgscore)));
    avelength_orgscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgscore)),h.orgscore<>(typeof(h.orgscore))'');
    populated_orgweight_cnt := COUNT(GROUP,h.orgweight <> (TYPEOF(h.orgweight))'');
    populated_orgweight_pcnt := AVE(GROUP,IF(h.orgweight = (TYPEOF(h.orgweight))'',0,100));
    maxlength_orgweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgweight)));
    avelength_orgweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.orgweight)),h.orgweight<>(typeof(h.orgweight))'');
    populated_ultid_cnt := COUNT(GROUP,h.ultid <> (TYPEOF(h.ultid))'');
    populated_ultid_pcnt := AVE(GROUP,IF(h.ultid = (TYPEOF(h.ultid))'',0,100));
    maxlength_ultid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultid)));
    avelength_ultid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultid)),h.ultid<>(typeof(h.ultid))'');
    populated_ultscore_cnt := COUNT(GROUP,h.ultscore <> (TYPEOF(h.ultscore))'');
    populated_ultscore_pcnt := AVE(GROUP,IF(h.ultscore = (TYPEOF(h.ultscore))'',0,100));
    maxlength_ultscore := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultscore)));
    avelength_ultscore := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultscore)),h.ultscore<>(typeof(h.ultscore))'');
    populated_ultweight_cnt := COUNT(GROUP,h.ultweight <> (TYPEOF(h.ultweight))'');
    populated_ultweight_pcnt := AVE(GROUP,IF(h.ultweight = (TYPEOF(h.ultweight))'',0,100));
    maxlength_ultweight := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultweight)));
    avelength_ultweight := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ultweight)),h.ultweight<>(typeof(h.ultweight))'');
    populated_source_rec_id_cnt := COUNT(GROUP,h.source_rec_id <> (TYPEOF(h.source_rec_id))'');
    populated_source_rec_id_pcnt := AVE(GROUP,IF(h.source_rec_id = (TYPEOF(h.source_rec_id))'',0,100));
    maxlength_source_rec_id := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_rec_id)));
    avelength_source_rec_id := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.source_rec_id)),h.source_rec_id<>(typeof(h.source_rec_id))'');
    populated_did_cnt := COUNT(GROUP,h.did <> (TYPEOF(h.did))'');
    populated_did_pcnt := AVE(GROUP,IF(h.did = (TYPEOF(h.did))'',0,100));
    maxlength_did := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)));
    avelength_did := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did)),h.did<>(typeof(h.did))'');
    populated_did_score_cnt := COUNT(GROUP,h.did_score <> (TYPEOF(h.did_score))'');
    populated_did_score_pcnt := AVE(GROUP,IF(h.did_score = (TYPEOF(h.did_score))'',0,100));
    maxlength_did_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_score)));
    avelength_did_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.did_score)),h.did_score<>(typeof(h.did_score))'');
    populated_bdid_cnt := COUNT(GROUP,h.bdid <> (TYPEOF(h.bdid))'');
    populated_bdid_pcnt := AVE(GROUP,IF(h.bdid = (TYPEOF(h.bdid))'',0,100));
    maxlength_bdid := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid)));
    avelength_bdid := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid)),h.bdid<>(typeof(h.bdid))'');
    populated_bdid_score_cnt := COUNT(GROUP,h.bdid_score <> (TYPEOF(h.bdid_score))'');
    populated_bdid_score_pcnt := AVE(GROUP,IF(h.bdid_score = (TYPEOF(h.bdid_score))'',0,100));
    maxlength_bdid_score := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid_score)));
    avelength_bdid_score := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.bdid_score)),h.bdid_score<>(typeof(h.bdid_score))'');
    populated_ssn_appended_cnt := COUNT(GROUP,h.ssn_appended <> (TYPEOF(h.ssn_appended))'');
    populated_ssn_appended_pcnt := AVE(GROUP,IF(h.ssn_appended = (TYPEOF(h.ssn_appended))'',0,100));
    maxlength_ssn_appended := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssn_appended)));
    avelength_ssn_appended := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ssn_appended)),h.ssn_appended<>(typeof(h.ssn_appended))'');
    populated_dba_name_cnt := COUNT(GROUP,h.dba_name <> (TYPEOF(h.dba_name))'');
    populated_dba_name_pcnt := AVE(GROUP,IF(h.dba_name = (TYPEOF(h.dba_name))'',0,100));
    maxlength_dba_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dba_name)));
    avelength_dba_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dba_name)),h.dba_name<>(typeof(h.dba_name))'');
    populated_contact_name_cnt := COUNT(GROUP,h.contact_name <> (TYPEOF(h.contact_name))'');
    populated_contact_name_pcnt := AVE(GROUP,IF(h.contact_name = (TYPEOF(h.contact_name))'',0,100));
    maxlength_contact_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.contact_name)));
    avelength_contact_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.contact_name)),h.contact_name<>(typeof(h.contact_name))'');
    populated_enh_did_src_cnt := COUNT(GROUP,h.enh_did_src <> (TYPEOF(h.enh_did_src))'');
    populated_enh_did_src_pcnt := AVE(GROUP,IF(h.enh_did_src = (TYPEOF(h.enh_did_src))'',0,100));
    maxlength_enh_did_src := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.enh_did_src)));
    avelength_enh_did_src := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.enh_did_src)),h.enh_did_src<>(typeof(h.enh_did_src))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_batch_number_pcnt *   0.00 / 100 + T.Populated_incident_number_pcnt *   0.00 / 100 + T.Populated_party_number_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_order_number_pcnt *   0.00 / 100 + T.Populated_party_name_pcnt *   0.00 / 100 + T.Populated_party_position_pcnt *   0.00 / 100 + T.Populated_party_vocation_pcnt *   0.00 / 100 + T.Populated_party_firm_pcnt *   0.00 / 100 + T.Populated_inaddress_pcnt *   0.00 / 100 + T.Populated_incity_pcnt *   0.00 / 100 + T.Populated_instate_pcnt *   0.00 / 100 + T.Populated_inzip_pcnt *   0.00 / 100 + T.Populated_ssnumber_pcnt *   0.00 / 100 + T.Populated_fines_levied_pcnt *   0.00 / 100 + T.Populated_restitution_pcnt *   0.00 / 100 + T.Populated_ok_for_fcr_pcnt *   0.00 / 100 + T.Populated_party_text_pcnt *   0.00 / 100 + T.Populated_title_pcnt *   0.00 / 100 + T.Populated_fname_pcnt *   0.00 / 100 + T.Populated_mname_pcnt *   0.00 / 100 + T.Populated_lname_pcnt *   0.00 / 100 + T.Populated_name_suffix_pcnt *   0.00 / 100 + T.Populated_name_score_pcnt *   0.00 / 100 + T.Populated_cname_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_fips_state_pcnt *   0.00 / 100 + T.Populated_fips_county_pcnt *   0.00 / 100 + T.Populated_addr_rec_type_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_cbsa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dpbc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100 + T.Populated_dotid_pcnt *   0.00 / 100 + T.Populated_dotscore_pcnt *   0.00 / 100 + T.Populated_dotweight_pcnt *   0.00 / 100 + T.Populated_empid_pcnt *   0.00 / 100 + T.Populated_empscore_pcnt *   0.00 / 100 + T.Populated_empweight_pcnt *   0.00 / 100 + T.Populated_powid_pcnt *   0.00 / 100 + T.Populated_powscore_pcnt *   0.00 / 100 + T.Populated_powweight_pcnt *   0.00 / 100 + T.Populated_proxid_pcnt *   0.00 / 100 + T.Populated_proxscore_pcnt *   0.00 / 100 + T.Populated_proxweight_pcnt *   0.00 / 100 + T.Populated_seleid_pcnt *   0.00 / 100 + T.Populated_selescore_pcnt *   0.00 / 100 + T.Populated_seleweight_pcnt *   0.00 / 100 + T.Populated_orgid_pcnt *   0.00 / 100 + T.Populated_orgscore_pcnt *   0.00 / 100 + T.Populated_orgweight_pcnt *   0.00 / 100 + T.Populated_ultid_pcnt *   0.00 / 100 + T.Populated_ultscore_pcnt *   0.00 / 100 + T.Populated_ultweight_pcnt *   0.00 / 100 + T.Populated_source_rec_id_pcnt *   0.00 / 100 + T.Populated_did_pcnt *   0.00 / 100 + T.Populated_did_score_pcnt *   0.00 / 100 + T.Populated_bdid_pcnt *   0.00 / 100 + T.Populated_bdid_score_pcnt *   0.00 / 100 + T.Populated_ssn_appended_pcnt *   0.00 / 100 + T.Populated_dba_name_pcnt *   0.00 / 100 + T.Populated_contact_name_pcnt *   0.00 / 100 + T.Populated_enh_did_src_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'batch_number','incident_number','party_number','record_type','order_number','party_name','party_position','party_vocation','party_firm','inaddress','incity','instate','inzip','ssnumber','fines_levied','restitution','ok_for_fcr','party_text','title','fname','mname','lname','name_suffix','name_score','cname','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','fips_state','fips_county','addr_rec_type','geo_lat','geo_long','cbsa','geo_blk','geo_match','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','err_stat','dotid','dotscore','dotweight','empid','empscore','empweight','powid','powscore','powweight','proxid','proxscore','proxweight','seleid','selescore','seleweight','orgid','orgscore','orgweight','ultid','ultscore','ultweight','source_rec_id','did','did_score','bdid','bdid_score','ssn_appended','dba_name','contact_name','enh_did_src');
  SELF.populated_pcnt := CHOOSE(C,le.populated_batch_number_pcnt,le.populated_incident_number_pcnt,le.populated_party_number_pcnt,le.populated_record_type_pcnt,le.populated_order_number_pcnt,le.populated_party_name_pcnt,le.populated_party_position_pcnt,le.populated_party_vocation_pcnt,le.populated_party_firm_pcnt,le.populated_inaddress_pcnt,le.populated_incity_pcnt,le.populated_instate_pcnt,le.populated_inzip_pcnt,le.populated_ssnumber_pcnt,le.populated_fines_levied_pcnt,le.populated_restitution_pcnt,le.populated_ok_for_fcr_pcnt,le.populated_party_text_pcnt,le.populated_title_pcnt,le.populated_fname_pcnt,le.populated_mname_pcnt,le.populated_lname_pcnt,le.populated_name_suffix_pcnt,le.populated_name_score_pcnt,le.populated_cname_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip5_pcnt,le.populated_zip4_pcnt,le.populated_fips_state_pcnt,le.populated_fips_county_pcnt,le.populated_addr_rec_type_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_cbsa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dpbc_pcnt,le.populated_chk_digit_pcnt,le.populated_err_stat_pcnt,le.populated_dotid_pcnt,le.populated_dotscore_pcnt,le.populated_dotweight_pcnt,le.populated_empid_pcnt,le.populated_empscore_pcnt,le.populated_empweight_pcnt,le.populated_powid_pcnt,le.populated_powscore_pcnt,le.populated_powweight_pcnt,le.populated_proxid_pcnt,le.populated_proxscore_pcnt,le.populated_proxweight_pcnt,le.populated_seleid_pcnt,le.populated_selescore_pcnt,le.populated_seleweight_pcnt,le.populated_orgid_pcnt,le.populated_orgscore_pcnt,le.populated_orgweight_pcnt,le.populated_ultid_pcnt,le.populated_ultscore_pcnt,le.populated_ultweight_pcnt,le.populated_source_rec_id_pcnt,le.populated_did_pcnt,le.populated_did_score_pcnt,le.populated_bdid_pcnt,le.populated_bdid_score_pcnt,le.populated_ssn_appended_pcnt,le.populated_dba_name_pcnt,le.populated_contact_name_pcnt,le.populated_enh_did_src_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_batch_number,le.maxlength_incident_number,le.maxlength_party_number,le.maxlength_record_type,le.maxlength_order_number,le.maxlength_party_name,le.maxlength_party_position,le.maxlength_party_vocation,le.maxlength_party_firm,le.maxlength_inaddress,le.maxlength_incity,le.maxlength_instate,le.maxlength_inzip,le.maxlength_ssnumber,le.maxlength_fines_levied,le.maxlength_restitution,le.maxlength_ok_for_fcr,le.maxlength_party_text,le.maxlength_title,le.maxlength_fname,le.maxlength_mname,le.maxlength_lname,le.maxlength_name_suffix,le.maxlength_name_score,le.maxlength_cname,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip5,le.maxlength_zip4,le.maxlength_fips_state,le.maxlength_fips_county,le.maxlength_addr_rec_type,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_cbsa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dpbc,le.maxlength_chk_digit,le.maxlength_err_stat,le.maxlength_dotid,le.maxlength_dotscore,le.maxlength_dotweight,le.maxlength_empid,le.maxlength_empscore,le.maxlength_empweight,le.maxlength_powid,le.maxlength_powscore,le.maxlength_powweight,le.maxlength_proxid,le.maxlength_proxscore,le.maxlength_proxweight,le.maxlength_seleid,le.maxlength_selescore,le.maxlength_seleweight,le.maxlength_orgid,le.maxlength_orgscore,le.maxlength_orgweight,le.maxlength_ultid,le.maxlength_ultscore,le.maxlength_ultweight,le.maxlength_source_rec_id,le.maxlength_did,le.maxlength_did_score,le.maxlength_bdid,le.maxlength_bdid_score,le.maxlength_ssn_appended,le.maxlength_dba_name,le.maxlength_contact_name,le.maxlength_enh_did_src);
  SELF.avelength := CHOOSE(C,le.avelength_batch_number,le.avelength_incident_number,le.avelength_party_number,le.avelength_record_type,le.avelength_order_number,le.avelength_party_name,le.avelength_party_position,le.avelength_party_vocation,le.avelength_party_firm,le.avelength_inaddress,le.avelength_incity,le.avelength_instate,le.avelength_inzip,le.avelength_ssnumber,le.avelength_fines_levied,le.avelength_restitution,le.avelength_ok_for_fcr,le.avelength_party_text,le.avelength_title,le.avelength_fname,le.avelength_mname,le.avelength_lname,le.avelength_name_suffix,le.avelength_name_score,le.avelength_cname,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip5,le.avelength_zip4,le.avelength_fips_state,le.avelength_fips_county,le.avelength_addr_rec_type,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_cbsa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dpbc,le.avelength_chk_digit,le.avelength_err_stat,le.avelength_dotid,le.avelength_dotscore,le.avelength_dotweight,le.avelength_empid,le.avelength_empscore,le.avelength_empweight,le.avelength_powid,le.avelength_powscore,le.avelength_powweight,le.avelength_proxid,le.avelength_proxscore,le.avelength_proxweight,le.avelength_seleid,le.avelength_selescore,le.avelength_seleweight,le.avelength_orgid,le.avelength_orgscore,le.avelength_orgweight,le.avelength_ultid,le.avelength_ultscore,le.avelength_ultweight,le.avelength_source_rec_id,le.avelength_did,le.avelength_did_score,le.avelength_bdid,le.avelength_bdid_score,le.avelength_ssn_appended,le.avelength_dba_name,le.avelength_contact_name,le.avelength_enh_did_src);
END;
EXPORT invSummary := NORMALIZE(summary0, 82, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.party_name),TRIM((SALT38.StrType)le.party_position),TRIM((SALT38.StrType)le.party_vocation),TRIM((SALT38.StrType)le.party_firm),TRIM((SALT38.StrType)le.inaddress),TRIM((SALT38.StrType)le.incity),TRIM((SALT38.StrType)le.instate),TRIM((SALT38.StrType)le.inzip),TRIM((SALT38.StrType)le.ssnumber),TRIM((SALT38.StrType)le.fines_levied),TRIM((SALT38.StrType)le.restitution),TRIM((SALT38.StrType)le.ok_for_fcr),TRIM((SALT38.StrType)le.party_text),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.cname),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip5),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.addr_rec_type),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.cbsa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.err_stat),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),TRIM((SALT38.StrType)le.ssn_appended),TRIM((SALT38.StrType)le.dba_name),TRIM((SALT38.StrType)le.contact_name),TRIM((SALT38.StrType)le.enh_did_src)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,82,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 82);
  SELF.FldNo2 := 1 + (C % 82);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.party_name),TRIM((SALT38.StrType)le.party_position),TRIM((SALT38.StrType)le.party_vocation),TRIM((SALT38.StrType)le.party_firm),TRIM((SALT38.StrType)le.inaddress),TRIM((SALT38.StrType)le.incity),TRIM((SALT38.StrType)le.instate),TRIM((SALT38.StrType)le.inzip),TRIM((SALT38.StrType)le.ssnumber),TRIM((SALT38.StrType)le.fines_levied),TRIM((SALT38.StrType)le.restitution),TRIM((SALT38.StrType)le.ok_for_fcr),TRIM((SALT38.StrType)le.party_text),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.cname),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip5),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.addr_rec_type),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.cbsa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.err_stat),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),TRIM((SALT38.StrType)le.ssn_appended),TRIM((SALT38.StrType)le.dba_name),TRIM((SALT38.StrType)le.contact_name),TRIM((SALT38.StrType)le.enh_did_src)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.batch_number),TRIM((SALT38.StrType)le.incident_number),TRIM((SALT38.StrType)le.party_number),TRIM((SALT38.StrType)le.record_type),TRIM((SALT38.StrType)le.order_number),TRIM((SALT38.StrType)le.party_name),TRIM((SALT38.StrType)le.party_position),TRIM((SALT38.StrType)le.party_vocation),TRIM((SALT38.StrType)le.party_firm),TRIM((SALT38.StrType)le.inaddress),TRIM((SALT38.StrType)le.incity),TRIM((SALT38.StrType)le.instate),TRIM((SALT38.StrType)le.inzip),TRIM((SALT38.StrType)le.ssnumber),TRIM((SALT38.StrType)le.fines_levied),TRIM((SALT38.StrType)le.restitution),TRIM((SALT38.StrType)le.ok_for_fcr),TRIM((SALT38.StrType)le.party_text),TRIM((SALT38.StrType)le.title),TRIM((SALT38.StrType)le.fname),TRIM((SALT38.StrType)le.mname),TRIM((SALT38.StrType)le.lname),TRIM((SALT38.StrType)le.name_suffix),TRIM((SALT38.StrType)le.name_score),TRIM((SALT38.StrType)le.cname),TRIM((SALT38.StrType)le.prim_range),TRIM((SALT38.StrType)le.predir),TRIM((SALT38.StrType)le.prim_name),TRIM((SALT38.StrType)le.addr_suffix),TRIM((SALT38.StrType)le.postdir),TRIM((SALT38.StrType)le.unit_desig),TRIM((SALT38.StrType)le.sec_range),TRIM((SALT38.StrType)le.p_city_name),TRIM((SALT38.StrType)le.v_city_name),TRIM((SALT38.StrType)le.st),TRIM((SALT38.StrType)le.zip5),TRIM((SALT38.StrType)le.zip4),TRIM((SALT38.StrType)le.fips_state),TRIM((SALT38.StrType)le.fips_county),TRIM((SALT38.StrType)le.addr_rec_type),TRIM((SALT38.StrType)le.geo_lat),TRIM((SALT38.StrType)le.geo_long),TRIM((SALT38.StrType)le.cbsa),TRIM((SALT38.StrType)le.geo_blk),TRIM((SALT38.StrType)le.geo_match),TRIM((SALT38.StrType)le.cart),TRIM((SALT38.StrType)le.cr_sort_sz),TRIM((SALT38.StrType)le.lot),TRIM((SALT38.StrType)le.lot_order),TRIM((SALT38.StrType)le.dpbc),TRIM((SALT38.StrType)le.chk_digit),TRIM((SALT38.StrType)le.err_stat),IF (le.dotid <> 0,TRIM((SALT38.StrType)le.dotid), ''),IF (le.dotscore <> 0,TRIM((SALT38.StrType)le.dotscore), ''),IF (le.dotweight <> 0,TRIM((SALT38.StrType)le.dotweight), ''),IF (le.empid <> 0,TRIM((SALT38.StrType)le.empid), ''),IF (le.empscore <> 0,TRIM((SALT38.StrType)le.empscore), ''),IF (le.empweight <> 0,TRIM((SALT38.StrType)le.empweight), ''),IF (le.powid <> 0,TRIM((SALT38.StrType)le.powid), ''),IF (le.powscore <> 0,TRIM((SALT38.StrType)le.powscore), ''),IF (le.powweight <> 0,TRIM((SALT38.StrType)le.powweight), ''),IF (le.proxid <> 0,TRIM((SALT38.StrType)le.proxid), ''),IF (le.proxscore <> 0,TRIM((SALT38.StrType)le.proxscore), ''),IF (le.proxweight <> 0,TRIM((SALT38.StrType)le.proxweight), ''),IF (le.seleid <> 0,TRIM((SALT38.StrType)le.seleid), ''),IF (le.selescore <> 0,TRIM((SALT38.StrType)le.selescore), ''),IF (le.seleweight <> 0,TRIM((SALT38.StrType)le.seleweight), ''),IF (le.orgid <> 0,TRIM((SALT38.StrType)le.orgid), ''),IF (le.orgscore <> 0,TRIM((SALT38.StrType)le.orgscore), ''),IF (le.orgweight <> 0,TRIM((SALT38.StrType)le.orgweight), ''),IF (le.ultid <> 0,TRIM((SALT38.StrType)le.ultid), ''),IF (le.ultscore <> 0,TRIM((SALT38.StrType)le.ultscore), ''),IF (le.ultweight <> 0,TRIM((SALT38.StrType)le.ultweight), ''),IF (le.source_rec_id <> 0,TRIM((SALT38.StrType)le.source_rec_id), ''),IF (le.did <> 0,TRIM((SALT38.StrType)le.did), ''),IF (le.did_score <> 0,TRIM((SALT38.StrType)le.did_score), ''),IF (le.bdid <> 0,TRIM((SALT38.StrType)le.bdid), ''),IF (le.bdid_score <> 0,TRIM((SALT38.StrType)le.bdid_score), ''),TRIM((SALT38.StrType)le.ssn_appended),TRIM((SALT38.StrType)le.dba_name),TRIM((SALT38.StrType)le.contact_name),TRIM((SALT38.StrType)le.enh_did_src)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),82*82,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'batch_number'}
      ,{2,'incident_number'}
      ,{3,'party_number'}
      ,{4,'record_type'}
      ,{5,'order_number'}
      ,{6,'party_name'}
      ,{7,'party_position'}
      ,{8,'party_vocation'}
      ,{9,'party_firm'}
      ,{10,'inaddress'}
      ,{11,'incity'}
      ,{12,'instate'}
      ,{13,'inzip'}
      ,{14,'ssnumber'}
      ,{15,'fines_levied'}
      ,{16,'restitution'}
      ,{17,'ok_for_fcr'}
      ,{18,'party_text'}
      ,{19,'title'}
      ,{20,'fname'}
      ,{21,'mname'}
      ,{22,'lname'}
      ,{23,'name_suffix'}
      ,{24,'name_score'}
      ,{25,'cname'}
      ,{26,'prim_range'}
      ,{27,'predir'}
      ,{28,'prim_name'}
      ,{29,'addr_suffix'}
      ,{30,'postdir'}
      ,{31,'unit_desig'}
      ,{32,'sec_range'}
      ,{33,'p_city_name'}
      ,{34,'v_city_name'}
      ,{35,'st'}
      ,{36,'zip5'}
      ,{37,'zip4'}
      ,{38,'fips_state'}
      ,{39,'fips_county'}
      ,{40,'addr_rec_type'}
      ,{41,'geo_lat'}
      ,{42,'geo_long'}
      ,{43,'cbsa'}
      ,{44,'geo_blk'}
      ,{45,'geo_match'}
      ,{46,'cart'}
      ,{47,'cr_sort_sz'}
      ,{48,'lot'}
      ,{49,'lot_order'}
      ,{50,'dpbc'}
      ,{51,'chk_digit'}
      ,{52,'err_stat'}
      ,{53,'dotid'}
      ,{54,'dotscore'}
      ,{55,'dotweight'}
      ,{56,'empid'}
      ,{57,'empscore'}
      ,{58,'empweight'}
      ,{59,'powid'}
      ,{60,'powscore'}
      ,{61,'powweight'}
      ,{62,'proxid'}
      ,{63,'proxscore'}
      ,{64,'proxweight'}
      ,{65,'seleid'}
      ,{66,'selescore'}
      ,{67,'seleweight'}
      ,{68,'orgid'}
      ,{69,'orgscore'}
      ,{70,'orgweight'}
      ,{71,'ultid'}
      ,{72,'ultscore'}
      ,{73,'ultweight'}
      ,{74,'source_rec_id'}
      ,{75,'did'}
      ,{76,'did_score'}
      ,{77,'bdid'}
      ,{78,'bdid_score'}
      ,{79,'ssn_appended'}
      ,{80,'dba_name'}
      ,{81,'contact_name'}
      ,{82,'enh_did_src'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    party_Fields.InValid_batch_number((SALT38.StrType)le.batch_number),
    party_Fields.InValid_incident_number((SALT38.StrType)le.incident_number),
    party_Fields.InValid_party_number((SALT38.StrType)le.party_number),
    party_Fields.InValid_record_type((SALT38.StrType)le.record_type),
    party_Fields.InValid_order_number((SALT38.StrType)le.order_number),
    party_Fields.InValid_party_name((SALT38.StrType)le.party_name),
    party_Fields.InValid_party_position((SALT38.StrType)le.party_position),
    party_Fields.InValid_party_vocation((SALT38.StrType)le.party_vocation),
    party_Fields.InValid_party_firm((SALT38.StrType)le.party_firm),
    party_Fields.InValid_inaddress((SALT38.StrType)le.inaddress),
    party_Fields.InValid_incity((SALT38.StrType)le.incity),
    party_Fields.InValid_instate((SALT38.StrType)le.instate),
    party_Fields.InValid_inzip((SALT38.StrType)le.inzip),
    party_Fields.InValid_ssnumber((SALT38.StrType)le.ssnumber),
    party_Fields.InValid_fines_levied((SALT38.StrType)le.fines_levied),
    party_Fields.InValid_restitution((SALT38.StrType)le.restitution),
    party_Fields.InValid_ok_for_fcr((SALT38.StrType)le.ok_for_fcr),
    party_Fields.InValid_party_text((SALT38.StrType)le.party_text),
    party_Fields.InValid_title((SALT38.StrType)le.title),
    party_Fields.InValid_fname((SALT38.StrType)le.fname),
    party_Fields.InValid_mname((SALT38.StrType)le.mname),
    party_Fields.InValid_lname((SALT38.StrType)le.lname),
    party_Fields.InValid_name_suffix((SALT38.StrType)le.name_suffix),
    party_Fields.InValid_name_score((SALT38.StrType)le.name_score),
    party_Fields.InValid_cname((SALT38.StrType)le.cname),
    party_Fields.InValid_prim_range((SALT38.StrType)le.prim_range),
    party_Fields.InValid_predir((SALT38.StrType)le.predir),
    party_Fields.InValid_prim_name((SALT38.StrType)le.prim_name),
    party_Fields.InValid_addr_suffix((SALT38.StrType)le.addr_suffix),
    party_Fields.InValid_postdir((SALT38.StrType)le.postdir),
    party_Fields.InValid_unit_desig((SALT38.StrType)le.unit_desig),
    party_Fields.InValid_sec_range((SALT38.StrType)le.sec_range),
    party_Fields.InValid_p_city_name((SALT38.StrType)le.p_city_name),
    party_Fields.InValid_v_city_name((SALT38.StrType)le.v_city_name),
    party_Fields.InValid_st((SALT38.StrType)le.st),
    party_Fields.InValid_zip5((SALT38.StrType)le.zip5),
    party_Fields.InValid_zip4((SALT38.StrType)le.zip4),
    party_Fields.InValid_fips_state((SALT38.StrType)le.fips_state),
    party_Fields.InValid_fips_county((SALT38.StrType)le.fips_county),
    party_Fields.InValid_addr_rec_type((SALT38.StrType)le.addr_rec_type),
    party_Fields.InValid_geo_lat((SALT38.StrType)le.geo_lat),
    party_Fields.InValid_geo_long((SALT38.StrType)le.geo_long),
    party_Fields.InValid_cbsa((SALT38.StrType)le.cbsa),
    party_Fields.InValid_geo_blk((SALT38.StrType)le.geo_blk),
    party_Fields.InValid_geo_match((SALT38.StrType)le.geo_match),
    party_Fields.InValid_cart((SALT38.StrType)le.cart),
    party_Fields.InValid_cr_sort_sz((SALT38.StrType)le.cr_sort_sz),
    party_Fields.InValid_lot((SALT38.StrType)le.lot),
    party_Fields.InValid_lot_order((SALT38.StrType)le.lot_order),
    party_Fields.InValid_dpbc((SALT38.StrType)le.dpbc),
    party_Fields.InValid_chk_digit((SALT38.StrType)le.chk_digit),
    party_Fields.InValid_err_stat((SALT38.StrType)le.err_stat),
    party_Fields.InValid_dotid((SALT38.StrType)le.dotid),
    party_Fields.InValid_dotscore((SALT38.StrType)le.dotscore),
    party_Fields.InValid_dotweight((SALT38.StrType)le.dotweight),
    party_Fields.InValid_empid((SALT38.StrType)le.empid),
    party_Fields.InValid_empscore((SALT38.StrType)le.empscore),
    party_Fields.InValid_empweight((SALT38.StrType)le.empweight),
    party_Fields.InValid_powid((SALT38.StrType)le.powid),
    party_Fields.InValid_powscore((SALT38.StrType)le.powscore),
    party_Fields.InValid_powweight((SALT38.StrType)le.powweight),
    party_Fields.InValid_proxid((SALT38.StrType)le.proxid),
    party_Fields.InValid_proxscore((SALT38.StrType)le.proxscore),
    party_Fields.InValid_proxweight((SALT38.StrType)le.proxweight),
    party_Fields.InValid_seleid((SALT38.StrType)le.seleid),
    party_Fields.InValid_selescore((SALT38.StrType)le.selescore),
    party_Fields.InValid_seleweight((SALT38.StrType)le.seleweight),
    party_Fields.InValid_orgid((SALT38.StrType)le.orgid),
    party_Fields.InValid_orgscore((SALT38.StrType)le.orgscore),
    party_Fields.InValid_orgweight((SALT38.StrType)le.orgweight),
    party_Fields.InValid_ultid((SALT38.StrType)le.ultid),
    party_Fields.InValid_ultscore((SALT38.StrType)le.ultscore),
    party_Fields.InValid_ultweight((SALT38.StrType)le.ultweight),
    party_Fields.InValid_source_rec_id((SALT38.StrType)le.source_rec_id),
    party_Fields.InValid_did((SALT38.StrType)le.did),
    party_Fields.InValid_did_score((SALT38.StrType)le.did_score),
    party_Fields.InValid_bdid((SALT38.StrType)le.bdid),
    party_Fields.InValid_bdid_score((SALT38.StrType)le.bdid_score),
    party_Fields.InValid_ssn_appended((SALT38.StrType)le.ssn_appended),
    party_Fields.InValid_dba_name((SALT38.StrType)le.dba_name),
    party_Fields.InValid_contact_name((SALT38.StrType)le.contact_name),
    party_Fields.InValid_enh_did_src((SALT38.StrType)le.enh_did_src),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,82,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := party_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Batch','Invalid_Num','Invalid_Num','Unknown','Invalid_Num','Non_Blank','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Zip','Invalid_SSN','Invalid_Money','Invalid_Money','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_State','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,party_Fields.InValidMessage_batch_number(TotalErrors.ErrorNum),party_Fields.InValidMessage_incident_number(TotalErrors.ErrorNum),party_Fields.InValidMessage_party_number(TotalErrors.ErrorNum),party_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),party_Fields.InValidMessage_order_number(TotalErrors.ErrorNum),party_Fields.InValidMessage_party_name(TotalErrors.ErrorNum),party_Fields.InValidMessage_party_position(TotalErrors.ErrorNum),party_Fields.InValidMessage_party_vocation(TotalErrors.ErrorNum),party_Fields.InValidMessage_party_firm(TotalErrors.ErrorNum),party_Fields.InValidMessage_inaddress(TotalErrors.ErrorNum),party_Fields.InValidMessage_incity(TotalErrors.ErrorNum),party_Fields.InValidMessage_instate(TotalErrors.ErrorNum),party_Fields.InValidMessage_inzip(TotalErrors.ErrorNum),party_Fields.InValidMessage_ssnumber(TotalErrors.ErrorNum),party_Fields.InValidMessage_fines_levied(TotalErrors.ErrorNum),party_Fields.InValidMessage_restitution(TotalErrors.ErrorNum),party_Fields.InValidMessage_ok_for_fcr(TotalErrors.ErrorNum),party_Fields.InValidMessage_party_text(TotalErrors.ErrorNum),party_Fields.InValidMessage_title(TotalErrors.ErrorNum),party_Fields.InValidMessage_fname(TotalErrors.ErrorNum),party_Fields.InValidMessage_mname(TotalErrors.ErrorNum),party_Fields.InValidMessage_lname(TotalErrors.ErrorNum),party_Fields.InValidMessage_name_suffix(TotalErrors.ErrorNum),party_Fields.InValidMessage_name_score(TotalErrors.ErrorNum),party_Fields.InValidMessage_cname(TotalErrors.ErrorNum),party_Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),party_Fields.InValidMessage_predir(TotalErrors.ErrorNum),party_Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),party_Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),party_Fields.InValidMessage_postdir(TotalErrors.ErrorNum),party_Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),party_Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),party_Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),party_Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),party_Fields.InValidMessage_st(TotalErrors.ErrorNum),party_Fields.InValidMessage_zip5(TotalErrors.ErrorNum),party_Fields.InValidMessage_zip4(TotalErrors.ErrorNum),party_Fields.InValidMessage_fips_state(TotalErrors.ErrorNum),party_Fields.InValidMessage_fips_county(TotalErrors.ErrorNum),party_Fields.InValidMessage_addr_rec_type(TotalErrors.ErrorNum),party_Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),party_Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),party_Fields.InValidMessage_cbsa(TotalErrors.ErrorNum),party_Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),party_Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),party_Fields.InValidMessage_cart(TotalErrors.ErrorNum),party_Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),party_Fields.InValidMessage_lot(TotalErrors.ErrorNum),party_Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),party_Fields.InValidMessage_dpbc(TotalErrors.ErrorNum),party_Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),party_Fields.InValidMessage_err_stat(TotalErrors.ErrorNum),party_Fields.InValidMessage_dotid(TotalErrors.ErrorNum),party_Fields.InValidMessage_dotscore(TotalErrors.ErrorNum),party_Fields.InValidMessage_dotweight(TotalErrors.ErrorNum),party_Fields.InValidMessage_empid(TotalErrors.ErrorNum),party_Fields.InValidMessage_empscore(TotalErrors.ErrorNum),party_Fields.InValidMessage_empweight(TotalErrors.ErrorNum),party_Fields.InValidMessage_powid(TotalErrors.ErrorNum),party_Fields.InValidMessage_powscore(TotalErrors.ErrorNum),party_Fields.InValidMessage_powweight(TotalErrors.ErrorNum),party_Fields.InValidMessage_proxid(TotalErrors.ErrorNum),party_Fields.InValidMessage_proxscore(TotalErrors.ErrorNum),party_Fields.InValidMessage_proxweight(TotalErrors.ErrorNum),party_Fields.InValidMessage_seleid(TotalErrors.ErrorNum),party_Fields.InValidMessage_selescore(TotalErrors.ErrorNum),party_Fields.InValidMessage_seleweight(TotalErrors.ErrorNum),party_Fields.InValidMessage_orgid(TotalErrors.ErrorNum),party_Fields.InValidMessage_orgscore(TotalErrors.ErrorNum),party_Fields.InValidMessage_orgweight(TotalErrors.ErrorNum),party_Fields.InValidMessage_ultid(TotalErrors.ErrorNum),party_Fields.InValidMessage_ultscore(TotalErrors.ErrorNum),party_Fields.InValidMessage_ultweight(TotalErrors.ErrorNum),party_Fields.InValidMessage_source_rec_id(TotalErrors.ErrorNum),party_Fields.InValidMessage_did(TotalErrors.ErrorNum),party_Fields.InValidMessage_did_score(TotalErrors.ErrorNum),party_Fields.InValidMessage_bdid(TotalErrors.ErrorNum),party_Fields.InValidMessage_bdid_score(TotalErrors.ErrorNum),party_Fields.InValidMessage_ssn_appended(TotalErrors.ErrorNum),party_Fields.InValidMessage_dba_name(TotalErrors.ErrorNum),party_Fields.InValidMessage_contact_name(TotalErrors.ErrorNum),party_Fields.InValidMessage_enh_did_src(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_SANCTNKeys, party_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
