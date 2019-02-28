IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_Base) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_item_source_cnt := COUNT(GROUP,h.item_source <> (TYPEOF(h.item_source))'');
    populated_item_source_pcnt := AVE(GROUP,IF(h.item_source = (TYPEOF(h.item_source))'',0,100));
    maxlength_item_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_source)));
    avelength_item_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.item_source)),h.item_source<>(typeof(h.item_source))'');
    populated_source_code_cnt := COUNT(GROUP,h.source_code <> (TYPEOF(h.source_code))'');
    populated_source_code_pcnt := AVE(GROUP,IF(h.source_code = (TYPEOF(h.source_code))'',0,100));
    maxlength_source_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)));
    avelength_source_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source_code)),h.source_code<>(typeof(h.source_code))'');
    populated_display_name_cnt := COUNT(GROUP,h.display_name <> (TYPEOF(h.display_name))'');
    populated_display_name_pcnt := AVE(GROUP,IF(h.display_name = (TYPEOF(h.display_name))'',0,100));
    maxlength_display_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.display_name)));
    avelength_display_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.display_name)),h.display_name<>(typeof(h.display_name))'');
    populated_description_cnt := COUNT(GROUP,h.description <> (TYPEOF(h.description))'');
    populated_description_pcnt := AVE(GROUP,IF(h.description = (TYPEOF(h.description))'',0,100));
    maxlength_description := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.description)));
    avelength_description := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.description)),h.description<>(typeof(h.description))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_data_notes_cnt := COUNT(GROUP,h.data_notes <> (TYPEOF(h.data_notes))'');
    populated_data_notes_pcnt := AVE(GROUP,IF(h.data_notes = (TYPEOF(h.data_notes))'',0,100));
    maxlength_data_notes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_notes)));
    avelength_data_notes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.data_notes)),h.data_notes<>(typeof(h.data_notes))'');
    populated_coverage_1_cnt := COUNT(GROUP,h.coverage_1 <> (TYPEOF(h.coverage_1))'');
    populated_coverage_1_pcnt := AVE(GROUP,IF(h.coverage_1 = (TYPEOF(h.coverage_1))'',0,100));
    maxlength_coverage_1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverage_1)));
    avelength_coverage_1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverage_1)),h.coverage_1<>(typeof(h.coverage_1))'');
    populated_coverage_2_cnt := COUNT(GROUP,h.coverage_2 <> (TYPEOF(h.coverage_2))'');
    populated_coverage_2_pcnt := AVE(GROUP,IF(h.coverage_2 = (TYPEOF(h.coverage_2))'',0,100));
    maxlength_coverage_2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverage_2)));
    avelength_coverage_2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.coverage_2)),h.coverage_2<>(typeof(h.coverage_2))'');
    populated_orbit_item_name_cnt := COUNT(GROUP,h.orbit_item_name <> (TYPEOF(h.orbit_item_name))'');
    populated_orbit_item_name_pcnt := AVE(GROUP,IF(h.orbit_item_name = (TYPEOF(h.orbit_item_name))'',0,100));
    maxlength_orbit_item_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orbit_item_name)));
    avelength_orbit_item_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orbit_item_name)),h.orbit_item_name<>(typeof(h.orbit_item_name))'');
    populated_orbit_source_cnt := COUNT(GROUP,h.orbit_source <> (TYPEOF(h.orbit_source))'');
    populated_orbit_source_pcnt := AVE(GROUP,IF(h.orbit_source = (TYPEOF(h.orbit_source))'',0,100));
    maxlength_orbit_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orbit_source)));
    avelength_orbit_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orbit_source)),h.orbit_source<>(typeof(h.orbit_source))'');
    populated_orbit_number_cnt := COUNT(GROUP,h.orbit_number <> (TYPEOF(h.orbit_number))'');
    populated_orbit_number_pcnt := AVE(GROUP,IF(h.orbit_number = (TYPEOF(h.orbit_number))'',0,100));
    maxlength_orbit_number := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orbit_number)));
    avelength_orbit_number := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orbit_number)),h.orbit_number<>(typeof(h.orbit_number))'');
    populated_website_cnt := COUNT(GROUP,h.website <> (TYPEOF(h.website))'');
    populated_website_pcnt := AVE(GROUP,IF(h.website = (TYPEOF(h.website))'',0,100));
    maxlength_website := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)));
    avelength_website := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.website)),h.website<>(typeof(h.website))'');
    populated_notes_cnt := COUNT(GROUP,h.notes <> (TYPEOF(h.notes))'');
    populated_notes_pcnt := AVE(GROUP,IF(h.notes = (TYPEOF(h.notes))'',0,100));
    maxlength_notes := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.notes)));
    avelength_notes := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.notes)),h.notes<>(typeof(h.notes))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_input_file_id_cnt := COUNT(GROUP,h.input_file_id <> (TYPEOF(h.input_file_id))'');
    populated_input_file_id_pcnt := AVE(GROUP,IF(h.input_file_id = (TYPEOF(h.input_file_id))'',0,100));
    maxlength_input_file_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.input_file_id)));
    avelength_input_file_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.input_file_id)),h.input_file_id<>(typeof(h.input_file_id))'');
    populated_market_restrict_flag_cnt := COUNT(GROUP,h.market_restrict_flag <> (TYPEOF(h.market_restrict_flag))'');
    populated_market_restrict_flag_pcnt := AVE(GROUP,IF(h.market_restrict_flag = (TYPEOF(h.market_restrict_flag))'',0,100));
    maxlength_market_restrict_flag := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_restrict_flag)));
    avelength_market_restrict_flag := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.market_restrict_flag)),h.market_restrict_flag<>(typeof(h.market_restrict_flag))'');
    populated_clean_phone_cnt := COUNT(GROUP,h.clean_phone <> (TYPEOF(h.clean_phone))'');
    populated_clean_phone_pcnt := AVE(GROUP,IF(h.clean_phone = (TYPEOF(h.clean_phone))'',0,100));
    maxlength_clean_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phone)));
    avelength_clean_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_phone)),h.clean_phone<>(typeof(h.clean_phone))'');
    populated_clean_fax_cnt := COUNT(GROUP,h.clean_fax <> (TYPEOF(h.clean_fax))'');
    populated_clean_fax_pcnt := AVE(GROUP,IF(h.clean_fax = (TYPEOF(h.clean_fax))'',0,100));
    maxlength_clean_fax := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_fax)));
    avelength_clean_fax := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clean_fax)),h.clean_fax<>(typeof(h.clean_fax))'');
    populated_prepped_addr1_cnt := COUNT(GROUP,h.prepped_addr1 <> (TYPEOF(h.prepped_addr1))'');
    populated_prepped_addr1_pcnt := AVE(GROUP,IF(h.prepped_addr1 = (TYPEOF(h.prepped_addr1))'',0,100));
    maxlength_prepped_addr1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepped_addr1)));
    avelength_prepped_addr1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepped_addr1)),h.prepped_addr1<>(typeof(h.prepped_addr1))'');
    populated_prepped_addr2_cnt := COUNT(GROUP,h.prepped_addr2 <> (TYPEOF(h.prepped_addr2))'');
    populated_prepped_addr2_pcnt := AVE(GROUP,IF(h.prepped_addr2 = (TYPEOF(h.prepped_addr2))'',0,100));
    maxlength_prepped_addr2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepped_addr2)));
    avelength_prepped_addr2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prepped_addr2)),h.prepped_addr2<>(typeof(h.prepped_addr2))'');
    populated_v_prim_name_cnt := COUNT(GROUP,h.v_prim_name <> (TYPEOF(h.v_prim_name))'');
    populated_v_prim_name_pcnt := AVE(GROUP,IF(h.v_prim_name = (TYPEOF(h.v_prim_name))'',0,100));
    maxlength_v_prim_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_prim_name)));
    avelength_v_prim_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_prim_name)),h.v_prim_name<>(typeof(h.v_prim_name))'');
    populated_v_zip_cnt := COUNT(GROUP,h.v_zip <> (TYPEOF(h.v_zip))'');
    populated_v_zip_pcnt := AVE(GROUP,IF(h.v_zip = (TYPEOF(h.v_zip))'',0,100));
    maxlength_v_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_zip)));
    avelength_v_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_zip)),h.v_zip<>(typeof(h.v_zip))'');
    populated_v_zip4_cnt := COUNT(GROUP,h.v_zip4 <> (TYPEOF(h.v_zip4))'');
    populated_v_zip4_pcnt := AVE(GROUP,IF(h.v_zip4 = (TYPEOF(h.v_zip4))'',0,100));
    maxlength_v_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_zip4)));
    avelength_v_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.v_zip4)),h.v_zip4<>(typeof(h.v_zip4))'');
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
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_item_source_pcnt *   0.00 / 100 + T.Populated_source_code_pcnt *   0.00 / 100 + T.Populated_display_name_pcnt *   0.00 / 100 + T.Populated_description_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_data_notes_pcnt *   0.00 / 100 + T.Populated_coverage_1_pcnt *   0.00 / 100 + T.Populated_coverage_2_pcnt *   0.00 / 100 + T.Populated_orbit_item_name_pcnt *   0.00 / 100 + T.Populated_orbit_source_pcnt *   0.00 / 100 + T.Populated_orbit_number_pcnt *   0.00 / 100 + T.Populated_website_pcnt *   0.00 / 100 + T.Populated_notes_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_input_file_id_pcnt *   0.00 / 100 + T.Populated_market_restrict_flag_pcnt *   0.00 / 100 + T.Populated_clean_phone_pcnt *   0.00 / 100 + T.Populated_clean_fax_pcnt *   0.00 / 100 + T.Populated_prepped_addr1_pcnt *   0.00 / 100 + T.Populated_prepped_addr2_pcnt *   0.00 / 100 + T.Populated_v_prim_name_pcnt *   0.00 / 100 + T.Populated_v_zip_pcnt *   0.00 / 100 + T.Populated_v_zip4_pcnt *   0.00 / 100 + T.Populated_prim_range_pcnt *   0.00 / 100 + T.Populated_predir_pcnt *   0.00 / 100 + T.Populated_prim_name_pcnt *   0.00 / 100 + T.Populated_addr_suffix_pcnt *   0.00 / 100 + T.Populated_postdir_pcnt *   0.00 / 100 + T.Populated_unit_desig_pcnt *   0.00 / 100 + T.Populated_sec_range_pcnt *   0.00 / 100 + T.Populated_p_city_name_pcnt *   0.00 / 100 + T.Populated_v_city_name_pcnt *   0.00 / 100 + T.Populated_st_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_zip4_pcnt *   0.00 / 100 + T.Populated_cart_pcnt *   0.00 / 100 + T.Populated_cr_sort_sz_pcnt *   0.00 / 100 + T.Populated_lot_pcnt *   0.00 / 100 + T.Populated_lot_order_pcnt *   0.00 / 100 + T.Populated_dbpc_pcnt *   0.00 / 100 + T.Populated_chk_digit_pcnt *   0.00 / 100 + T.Populated_rec_type_pcnt *   0.00 / 100 + T.Populated_county_pcnt *   0.00 / 100 + T.Populated_geo_lat_pcnt *   0.00 / 100 + T.Populated_geo_long_pcnt *   0.00 / 100 + T.Populated_msa_pcnt *   0.00 / 100 + T.Populated_geo_blk_pcnt *   0.00 / 100 + T.Populated_geo_match_pcnt *   0.00 / 100 + T.Populated_err_stat_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'item_source','source_code','display_name','description','status','data_notes','coverage_1','coverage_2','orbit_item_name','orbit_source','orbit_number','website','notes','date_added','input_file_id','market_restrict_flag','clean_phone','clean_fax','prepped_addr1','prepped_addr2','v_prim_name','v_zip','v_zip4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat');
  SELF.populated_pcnt := CHOOSE(C,le.populated_item_source_pcnt,le.populated_source_code_pcnt,le.populated_display_name_pcnt,le.populated_description_pcnt,le.populated_status_pcnt,le.populated_data_notes_pcnt,le.populated_coverage_1_pcnt,le.populated_coverage_2_pcnt,le.populated_orbit_item_name_pcnt,le.populated_orbit_source_pcnt,le.populated_orbit_number_pcnt,le.populated_website_pcnt,le.populated_notes_pcnt,le.populated_date_added_pcnt,le.populated_input_file_id_pcnt,le.populated_market_restrict_flag_pcnt,le.populated_clean_phone_pcnt,le.populated_clean_fax_pcnt,le.populated_prepped_addr1_pcnt,le.populated_prepped_addr2_pcnt,le.populated_v_prim_name_pcnt,le.populated_v_zip_pcnt,le.populated_v_zip4_pcnt,le.populated_prim_range_pcnt,le.populated_predir_pcnt,le.populated_prim_name_pcnt,le.populated_addr_suffix_pcnt,le.populated_postdir_pcnt,le.populated_unit_desig_pcnt,le.populated_sec_range_pcnt,le.populated_p_city_name_pcnt,le.populated_v_city_name_pcnt,le.populated_st_pcnt,le.populated_zip_pcnt,le.populated_zip4_pcnt,le.populated_cart_pcnt,le.populated_cr_sort_sz_pcnt,le.populated_lot_pcnt,le.populated_lot_order_pcnt,le.populated_dbpc_pcnt,le.populated_chk_digit_pcnt,le.populated_rec_type_pcnt,le.populated_county_pcnt,le.populated_geo_lat_pcnt,le.populated_geo_long_pcnt,le.populated_msa_pcnt,le.populated_geo_blk_pcnt,le.populated_geo_match_pcnt,le.populated_err_stat_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_item_source,le.maxlength_source_code,le.maxlength_display_name,le.maxlength_description,le.maxlength_status,le.maxlength_data_notes,le.maxlength_coverage_1,le.maxlength_coverage_2,le.maxlength_orbit_item_name,le.maxlength_orbit_source,le.maxlength_orbit_number,le.maxlength_website,le.maxlength_notes,le.maxlength_date_added,le.maxlength_input_file_id,le.maxlength_market_restrict_flag,le.maxlength_clean_phone,le.maxlength_clean_fax,le.maxlength_prepped_addr1,le.maxlength_prepped_addr2,le.maxlength_v_prim_name,le.maxlength_v_zip,le.maxlength_v_zip4,le.maxlength_prim_range,le.maxlength_predir,le.maxlength_prim_name,le.maxlength_addr_suffix,le.maxlength_postdir,le.maxlength_unit_desig,le.maxlength_sec_range,le.maxlength_p_city_name,le.maxlength_v_city_name,le.maxlength_st,le.maxlength_zip,le.maxlength_zip4,le.maxlength_cart,le.maxlength_cr_sort_sz,le.maxlength_lot,le.maxlength_lot_order,le.maxlength_dbpc,le.maxlength_chk_digit,le.maxlength_rec_type,le.maxlength_county,le.maxlength_geo_lat,le.maxlength_geo_long,le.maxlength_msa,le.maxlength_geo_blk,le.maxlength_geo_match,le.maxlength_err_stat);
  SELF.avelength := CHOOSE(C,le.avelength_item_source,le.avelength_source_code,le.avelength_display_name,le.avelength_description,le.avelength_status,le.avelength_data_notes,le.avelength_coverage_1,le.avelength_coverage_2,le.avelength_orbit_item_name,le.avelength_orbit_source,le.avelength_orbit_number,le.avelength_website,le.avelength_notes,le.avelength_date_added,le.avelength_input_file_id,le.avelength_market_restrict_flag,le.avelength_clean_phone,le.avelength_clean_fax,le.avelength_prepped_addr1,le.avelength_prepped_addr2,le.avelength_v_prim_name,le.avelength_v_zip,le.avelength_v_zip4,le.avelength_prim_range,le.avelength_predir,le.avelength_prim_name,le.avelength_addr_suffix,le.avelength_postdir,le.avelength_unit_desig,le.avelength_sec_range,le.avelength_p_city_name,le.avelength_v_city_name,le.avelength_st,le.avelength_zip,le.avelength_zip4,le.avelength_cart,le.avelength_cr_sort_sz,le.avelength_lot,le.avelength_lot_order,le.avelength_dbpc,le.avelength_chk_digit,le.avelength_rec_type,le.avelength_county,le.avelength_geo_lat,le.avelength_geo_long,le.avelength_msa,le.avelength_geo_blk,le.avelength_geo_match,le.avelength_err_stat);
END;
EXPORT invSummary := NORMALIZE(summary0, 49, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.item_source),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.display_name),TRIM((SALT311.StrType)le.description),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.data_notes),TRIM((SALT311.StrType)le.coverage_1),TRIM((SALT311.StrType)le.coverage_2),TRIM((SALT311.StrType)le.orbit_item_name),TRIM((SALT311.StrType)le.orbit_source),TRIM((SALT311.StrType)le.orbit_number),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.notes),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.input_file_id),TRIM((SALT311.StrType)le.market_restrict_flag),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_fax),TRIM((SALT311.StrType)le.prepped_addr1),TRIM((SALT311.StrType)le.prepped_addr2),TRIM((SALT311.StrType)le.v_prim_name),TRIM((SALT311.StrType)le.v_zip),TRIM((SALT311.StrType)le.v_zip4),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,49,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 49);
  SELF.FldNo2 := 1 + (C % 49);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.item_source),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.display_name),TRIM((SALT311.StrType)le.description),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.data_notes),TRIM((SALT311.StrType)le.coverage_1),TRIM((SALT311.StrType)le.coverage_2),TRIM((SALT311.StrType)le.orbit_item_name),TRIM((SALT311.StrType)le.orbit_source),TRIM((SALT311.StrType)le.orbit_number),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.notes),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.input_file_id),TRIM((SALT311.StrType)le.market_restrict_flag),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_fax),TRIM((SALT311.StrType)le.prepped_addr1),TRIM((SALT311.StrType)le.prepped_addr2),TRIM((SALT311.StrType)le.v_prim_name),TRIM((SALT311.StrType)le.v_zip),TRIM((SALT311.StrType)le.v_zip4),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.item_source),TRIM((SALT311.StrType)le.source_code),TRIM((SALT311.StrType)le.display_name),TRIM((SALT311.StrType)le.description),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.data_notes),TRIM((SALT311.StrType)le.coverage_1),TRIM((SALT311.StrType)le.coverage_2),TRIM((SALT311.StrType)le.orbit_item_name),TRIM((SALT311.StrType)le.orbit_source),TRIM((SALT311.StrType)le.orbit_number),TRIM((SALT311.StrType)le.website),TRIM((SALT311.StrType)le.notes),TRIM((SALT311.StrType)le.date_added),TRIM((SALT311.StrType)le.input_file_id),TRIM((SALT311.StrType)le.market_restrict_flag),TRIM((SALT311.StrType)le.clean_phone),TRIM((SALT311.StrType)le.clean_fax),TRIM((SALT311.StrType)le.prepped_addr1),TRIM((SALT311.StrType)le.prepped_addr2),TRIM((SALT311.StrType)le.v_prim_name),TRIM((SALT311.StrType)le.v_zip),TRIM((SALT311.StrType)le.v_zip4),TRIM((SALT311.StrType)le.prim_range),TRIM((SALT311.StrType)le.predir),TRIM((SALT311.StrType)le.prim_name),TRIM((SALT311.StrType)le.addr_suffix),TRIM((SALT311.StrType)le.postdir),TRIM((SALT311.StrType)le.unit_desig),TRIM((SALT311.StrType)le.sec_range),TRIM((SALT311.StrType)le.p_city_name),TRIM((SALT311.StrType)le.v_city_name),TRIM((SALT311.StrType)le.st),TRIM((SALT311.StrType)le.zip),TRIM((SALT311.StrType)le.zip4),TRIM((SALT311.StrType)le.cart),TRIM((SALT311.StrType)le.cr_sort_sz),TRIM((SALT311.StrType)le.lot),TRIM((SALT311.StrType)le.lot_order),TRIM((SALT311.StrType)le.dbpc),TRIM((SALT311.StrType)le.chk_digit),TRIM((SALT311.StrType)le.rec_type),TRIM((SALT311.StrType)le.county),TRIM((SALT311.StrType)le.geo_lat),TRIM((SALT311.StrType)le.geo_long),TRIM((SALT311.StrType)le.msa),TRIM((SALT311.StrType)le.geo_blk),TRIM((SALT311.StrType)le.geo_match),TRIM((SALT311.StrType)le.err_stat)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),49*49,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'item_source'}
      ,{2,'source_code'}
      ,{3,'display_name'}
      ,{4,'description'}
      ,{5,'status'}
      ,{6,'data_notes'}
      ,{7,'coverage_1'}
      ,{8,'coverage_2'}
      ,{9,'orbit_item_name'}
      ,{10,'orbit_source'}
      ,{11,'orbit_number'}
      ,{12,'website'}
      ,{13,'notes'}
      ,{14,'date_added'}
      ,{15,'input_file_id'}
      ,{16,'market_restrict_flag'}
      ,{17,'clean_phone'}
      ,{18,'clean_fax'}
      ,{19,'prepped_addr1'}
      ,{20,'prepped_addr2'}
      ,{21,'v_prim_name'}
      ,{22,'v_zip'}
      ,{23,'v_zip4'}
      ,{24,'prim_range'}
      ,{25,'predir'}
      ,{26,'prim_name'}
      ,{27,'addr_suffix'}
      ,{28,'postdir'}
      ,{29,'unit_desig'}
      ,{30,'sec_range'}
      ,{31,'p_city_name'}
      ,{32,'v_city_name'}
      ,{33,'st'}
      ,{34,'zip'}
      ,{35,'zip4'}
      ,{36,'cart'}
      ,{37,'cr_sort_sz'}
      ,{38,'lot'}
      ,{39,'lot_order'}
      ,{40,'dbpc'}
      ,{41,'chk_digit'}
      ,{42,'rec_type'}
      ,{43,'county'}
      ,{44,'geo_lat'}
      ,{45,'geo_long'}
      ,{46,'msa'}
      ,{47,'geo_blk'}
      ,{48,'geo_match'}
      ,{49,'err_stat'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_item_source((SALT311.StrType)le.item_source),
    Fields.InValid_source_code((SALT311.StrType)le.source_code),
    Fields.InValid_display_name((SALT311.StrType)le.display_name),
    Fields.InValid_description((SALT311.StrType)le.description),
    Fields.InValid_status((SALT311.StrType)le.status),
    Fields.InValid_data_notes((SALT311.StrType)le.data_notes),
    Fields.InValid_coverage_1((SALT311.StrType)le.coverage_1),
    Fields.InValid_coverage_2((SALT311.StrType)le.coverage_2),
    Fields.InValid_orbit_item_name((SALT311.StrType)le.orbit_item_name),
    Fields.InValid_orbit_source((SALT311.StrType)le.orbit_source),
    Fields.InValid_orbit_number((SALT311.StrType)le.orbit_number),
    Fields.InValid_website((SALT311.StrType)le.website),
    Fields.InValid_notes((SALT311.StrType)le.notes),
    Fields.InValid_date_added((SALT311.StrType)le.date_added),
    Fields.InValid_input_file_id((SALT311.StrType)le.input_file_id),
    Fields.InValid_market_restrict_flag((SALT311.StrType)le.market_restrict_flag),
    Fields.InValid_clean_phone((SALT311.StrType)le.clean_phone),
    Fields.InValid_clean_fax((SALT311.StrType)le.clean_fax),
    Fields.InValid_prepped_addr1((SALT311.StrType)le.prepped_addr1),
    Fields.InValid_prepped_addr2((SALT311.StrType)le.prepped_addr2),
    Fields.InValid_v_prim_name((SALT311.StrType)le.v_prim_name),
    Fields.InValid_v_zip((SALT311.StrType)le.v_zip),
    Fields.InValid_v_zip4((SALT311.StrType)le.v_zip4),
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
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,49,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_source','Invalid_source','Invalid_display_name','Invalid_description','Unknown','Unknown','Invalid_coverage','Invalid_coverage','Unknown','Unknown','Unknown','Invalid_website','Unknown','Invalid_date_added','Unknown','Invalid_market_restrict_flag','Invalid_clean_phone','Unknown','Invalid_prepped_addr1','Invalid_prepped_addr2','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_city_name','Invalid_city_name','Invalid_st','Invalid_numbers','Invalid_numbers','Unknown','Unknown','Invalid_numbers','Unknown','Invalid_numbers','Invalid_numbers','Unknown','Invalid_numbers','Invalid_geo_lat','Invalid_geo_long','Invalid_msa','Invalid_numbers','Invalid_geo_match','Invalid_err_stat');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_item_source(TotalErrors.ErrorNum),Fields.InValidMessage_source_code(TotalErrors.ErrorNum),Fields.InValidMessage_display_name(TotalErrors.ErrorNum),Fields.InValidMessage_description(TotalErrors.ErrorNum),Fields.InValidMessage_status(TotalErrors.ErrorNum),Fields.InValidMessage_data_notes(TotalErrors.ErrorNum),Fields.InValidMessage_coverage_1(TotalErrors.ErrorNum),Fields.InValidMessage_coverage_2(TotalErrors.ErrorNum),Fields.InValidMessage_orbit_item_name(TotalErrors.ErrorNum),Fields.InValidMessage_orbit_source(TotalErrors.ErrorNum),Fields.InValidMessage_orbit_number(TotalErrors.ErrorNum),Fields.InValidMessage_website(TotalErrors.ErrorNum),Fields.InValidMessage_notes(TotalErrors.ErrorNum),Fields.InValidMessage_date_added(TotalErrors.ErrorNum),Fields.InValidMessage_input_file_id(TotalErrors.ErrorNum),Fields.InValidMessage_market_restrict_flag(TotalErrors.ErrorNum),Fields.InValidMessage_clean_phone(TotalErrors.ErrorNum),Fields.InValidMessage_clean_fax(TotalErrors.ErrorNum),Fields.InValidMessage_prepped_addr1(TotalErrors.ErrorNum),Fields.InValidMessage_prepped_addr2(TotalErrors.ErrorNum),Fields.InValidMessage_v_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_zip(TotalErrors.ErrorNum),Fields.InValidMessage_v_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_prim_range(TotalErrors.ErrorNum),Fields.InValidMessage_predir(TotalErrors.ErrorNum),Fields.InValidMessage_prim_name(TotalErrors.ErrorNum),Fields.InValidMessage_addr_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_postdir(TotalErrors.ErrorNum),Fields.InValidMessage_unit_desig(TotalErrors.ErrorNum),Fields.InValidMessage_sec_range(TotalErrors.ErrorNum),Fields.InValidMessage_p_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_v_city_name(TotalErrors.ErrorNum),Fields.InValidMessage_st(TotalErrors.ErrorNum),Fields.InValidMessage_zip(TotalErrors.ErrorNum),Fields.InValidMessage_zip4(TotalErrors.ErrorNum),Fields.InValidMessage_cart(TotalErrors.ErrorNum),Fields.InValidMessage_cr_sort_sz(TotalErrors.ErrorNum),Fields.InValidMessage_lot(TotalErrors.ErrorNum),Fields.InValidMessage_lot_order(TotalErrors.ErrorNum),Fields.InValidMessage_dbpc(TotalErrors.ErrorNum),Fields.InValidMessage_chk_digit(TotalErrors.ErrorNum),Fields.InValidMessage_rec_type(TotalErrors.ErrorNum),Fields.InValidMessage_county(TotalErrors.ErrorNum),Fields.InValidMessage_geo_lat(TotalErrors.ErrorNum),Fields.InValidMessage_geo_long(TotalErrors.ErrorNum),Fields.InValidMessage_msa(TotalErrors.ErrorNum),Fields.InValidMessage_geo_blk(TotalErrors.ErrorNum),Fields.InValidMessage_geo_match(TotalErrors.ErrorNum),Fields.InValidMessage_err_stat(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(_Scrubs_VendorSrc_Base, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
