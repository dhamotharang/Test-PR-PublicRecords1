IMPORT SALT311,STD;
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 49;
  EXPORT NumRulesFromFieldType := 49;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 49;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_Vendor_Src)
    UNSIGNED1 item_source_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 display_name_Invalid;
    UNSIGNED1 description_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 data_notes_Invalid;
    UNSIGNED1 coverage_1_Invalid;
    UNSIGNED1 coverage_2_Invalid;
    UNSIGNED1 orbit_item_name_Invalid;
    UNSIGNED1 orbit_source_Invalid;
    UNSIGNED1 orbit_number_Invalid;
    UNSIGNED1 website_Invalid;
    UNSIGNED1 notes_Invalid;
    UNSIGNED1 date_added_Invalid;
    UNSIGNED1 input_file_id_Invalid;
    UNSIGNED1 market_restrict_flag_Invalid;
    UNSIGNED1 clean_phone_Invalid;
    UNSIGNED1 clean_fax_Invalid;
    UNSIGNED1 prepped_addr1_Invalid;
    UNSIGNED1 prepped_addr2_Invalid;
    UNSIGNED1 v_prim_name_Invalid;
    UNSIGNED1 v_zip_Invalid;
    UNSIGNED1 v_zip4_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 addr_suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 unit_desig_Invalid;
    UNSIGNED1 sec_range_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dbpc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_Vendor_Src)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_Vendor_Src) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.item_source_Invalid := Base_Fields.InValid_item_source((SALT311.StrType)le.item_source);
    SELF.source_code_Invalid := Base_Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.display_name_Invalid := Base_Fields.InValid_display_name((SALT311.StrType)le.display_name);
    SELF.description_Invalid := Base_Fields.InValid_description((SALT311.StrType)le.description);
    SELF.status_Invalid := Base_Fields.InValid_status((SALT311.StrType)le.status);
    SELF.data_notes_Invalid := Base_Fields.InValid_data_notes((SALT311.StrType)le.data_notes);
    SELF.coverage_1_Invalid := Base_Fields.InValid_coverage_1((SALT311.StrType)le.coverage_1);
    SELF.coverage_2_Invalid := Base_Fields.InValid_coverage_2((SALT311.StrType)le.coverage_2);
    SELF.orbit_item_name_Invalid := Base_Fields.InValid_orbit_item_name((SALT311.StrType)le.orbit_item_name);
    SELF.orbit_source_Invalid := Base_Fields.InValid_orbit_source((SALT311.StrType)le.orbit_source);
    SELF.orbit_number_Invalid := Base_Fields.InValid_orbit_number((SALT311.StrType)le.orbit_number);
    SELF.website_Invalid := Base_Fields.InValid_website((SALT311.StrType)le.website);
    SELF.notes_Invalid := Base_Fields.InValid_notes((SALT311.StrType)le.notes);
    SELF.date_added_Invalid := Base_Fields.InValid_date_added((SALT311.StrType)le.date_added);
    SELF.input_file_id_Invalid := Base_Fields.InValid_input_file_id((SALT311.StrType)le.input_file_id);
    SELF.market_restrict_flag_Invalid := Base_Fields.InValid_market_restrict_flag((SALT311.StrType)le.market_restrict_flag);
    SELF.clean_phone_Invalid := Base_Fields.InValid_clean_phone((SALT311.StrType)le.clean_phone);
    SELF.clean_fax_Invalid := Base_Fields.InValid_clean_fax((SALT311.StrType)le.clean_fax);
    SELF.prepped_addr1_Invalid := Base_Fields.InValid_prepped_addr1((SALT311.StrType)le.prepped_addr1);
    SELF.prepped_addr2_Invalid := Base_Fields.InValid_prepped_addr2((SALT311.StrType)le.prepped_addr2);
    SELF.v_prim_name_Invalid := Base_Fields.InValid_v_prim_name((SALT311.StrType)le.v_prim_name);
    SELF.v_zip_Invalid := Base_Fields.InValid_v_zip((SALT311.StrType)le.v_zip);
    SELF.v_zip4_Invalid := Base_Fields.InValid_v_zip4((SALT311.StrType)le.v_zip4);
    SELF.prim_range_Invalid := Base_Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Base_Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Base_Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Base_Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
    SELF.postdir_Invalid := Base_Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Base_Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Base_Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Base_Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Base_Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.st_Invalid := Base_Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := Base_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.cart_Invalid := Base_Fields.InValid_cart((SALT311.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Base_Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Base_Fields.InValid_lot((SALT311.StrType)le.lot);
    SELF.lot_order_Invalid := Base_Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    SELF.dbpc_Invalid := Base_Fields.InValid_dbpc((SALT311.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Base_Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Base_Fields.InValid_rec_type((SALT311.StrType)le.rec_type);
    SELF.county_Invalid := Base_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.geo_lat_Invalid := Base_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Base_Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.msa_Invalid := Base_Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.geo_blk_Invalid := Base_Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Base_Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF.err_stat_Invalid := Base_Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_Vendor_Src);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.item_source_Invalid << 0 ) + ( le.source_code_Invalid << 1 ) + ( le.display_name_Invalid << 2 ) + ( le.description_Invalid << 3 ) + ( le.status_Invalid << 4 ) + ( le.data_notes_Invalid << 5 ) + ( le.coverage_1_Invalid << 6 ) + ( le.coverage_2_Invalid << 7 ) + ( le.orbit_item_name_Invalid << 8 ) + ( le.orbit_source_Invalid << 9 ) + ( le.orbit_number_Invalid << 10 ) + ( le.website_Invalid << 11 ) + ( le.notes_Invalid << 12 ) + ( le.date_added_Invalid << 13 ) + ( le.input_file_id_Invalid << 14 ) + ( le.market_restrict_flag_Invalid << 15 ) + ( le.clean_phone_Invalid << 16 ) + ( le.clean_fax_Invalid << 17 ) + ( le.prepped_addr1_Invalid << 18 ) + ( le.prepped_addr2_Invalid << 19 ) + ( le.v_prim_name_Invalid << 20 ) + ( le.v_zip_Invalid << 21 ) + ( le.v_zip4_Invalid << 22 ) + ( le.prim_range_Invalid << 23 ) + ( le.predir_Invalid << 24 ) + ( le.prim_name_Invalid << 25 ) + ( le.addr_suffix_Invalid << 26 ) + ( le.postdir_Invalid << 27 ) + ( le.unit_desig_Invalid << 28 ) + ( le.sec_range_Invalid << 29 ) + ( le.p_city_name_Invalid << 30 ) + ( le.v_city_name_Invalid << 31 ) + ( le.st_Invalid << 32 ) + ( le.zip_Invalid << 33 ) + ( le.zip4_Invalid << 34 ) + ( le.cart_Invalid << 35 ) + ( le.cr_sort_sz_Invalid << 36 ) + ( le.lot_Invalid << 37 ) + ( le.lot_order_Invalid << 38 ) + ( le.dbpc_Invalid << 39 ) + ( le.chk_digit_Invalid << 40 ) + ( le.rec_type_Invalid << 41 ) + ( le.county_Invalid << 42 ) + ( le.geo_lat_Invalid << 43 ) + ( le.geo_long_Invalid << 44 ) + ( le.msa_Invalid << 45 ) + ( le.geo_blk_Invalid << 46 ) + ( le.geo_match_Invalid << 47 ) + ( le.err_stat_Invalid << 48 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_Vendor_Src);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.item_source_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.display_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.description_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.data_notes_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.coverage_1_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.coverage_2_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orbit_item_name_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orbit_source_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.orbit_number_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.website_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.notes_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.input_file_id_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.market_restrict_flag_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.clean_phone_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.clean_fax_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.prepped_addr1_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.prepped_addr2_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.v_prim_name_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.v_zip_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.v_zip4_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.dbpc_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    item_source_ALLOW_ErrorCount := COUNT(GROUP,h.item_source_Invalid=1);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    display_name_ALLOW_ErrorCount := COUNT(GROUP,h.display_name_Invalid=1);
    description_ALLOW_ErrorCount := COUNT(GROUP,h.description_Invalid=1);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    data_notes_ALLOW_ErrorCount := COUNT(GROUP,h.data_notes_Invalid=1);
    coverage_1_ALLOW_ErrorCount := COUNT(GROUP,h.coverage_1_Invalid=1);
    coverage_2_ALLOW_ErrorCount := COUNT(GROUP,h.coverage_2_Invalid=1);
    orbit_item_name_ALLOW_ErrorCount := COUNT(GROUP,h.orbit_item_name_Invalid=1);
    orbit_source_ALLOW_ErrorCount := COUNT(GROUP,h.orbit_source_Invalid=1);
    orbit_number_ALLOW_ErrorCount := COUNT(GROUP,h.orbit_number_Invalid=1);
    website_ALLOW_ErrorCount := COUNT(GROUP,h.website_Invalid=1);
    notes_ALLOW_ErrorCount := COUNT(GROUP,h.notes_Invalid=1);
    date_added_ALLOW_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
    input_file_id_ALLOW_ErrorCount := COUNT(GROUP,h.input_file_id_Invalid=1);
    market_restrict_flag_ALLOW_ErrorCount := COUNT(GROUP,h.market_restrict_flag_Invalid=1);
    clean_phone_ALLOW_ErrorCount := COUNT(GROUP,h.clean_phone_Invalid=1);
    clean_fax_ALLOW_ErrorCount := COUNT(GROUP,h.clean_fax_Invalid=1);
    prepped_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr1_Invalid=1);
    prepped_addr2_ALLOW_ErrorCount := COUNT(GROUP,h.prepped_addr2_Invalid=1);
    v_prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_prim_name_Invalid=1);
    v_zip_ALLOW_ErrorCount := COUNT(GROUP,h.v_zip_Invalid=1);
    v_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.v_zip4_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ALLOW_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dbpc_ALLOW_ErrorCount := COUNT(GROUP,h.dbpc_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    rec_type_ALLOW_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.item_source_Invalid > 0 OR h.source_code_Invalid > 0 OR h.display_name_Invalid > 0 OR h.description_Invalid > 0 OR h.status_Invalid > 0 OR h.data_notes_Invalid > 0 OR h.coverage_1_Invalid > 0 OR h.coverage_2_Invalid > 0 OR h.orbit_item_name_Invalid > 0 OR h.orbit_source_Invalid > 0 OR h.orbit_number_Invalid > 0 OR h.website_Invalid > 0 OR h.notes_Invalid > 0 OR h.date_added_Invalid > 0 OR h.input_file_id_Invalid > 0 OR h.market_restrict_flag_Invalid > 0 OR h.clean_phone_Invalid > 0 OR h.clean_fax_Invalid > 0 OR h.prepped_addr1_Invalid > 0 OR h.prepped_addr2_Invalid > 0 OR h.v_prim_name_Invalid > 0 OR h.v_zip_Invalid > 0 OR h.v_zip4_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.item_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.display_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.description_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.data_notes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coverage_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coverage_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orbit_item_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orbit_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orbit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.notes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_ALLOW_ErrorCount > 0, 1, 0) + IF(le.input_file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_restrict_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_fax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prepped_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prepped_addr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.item_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.display_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.description_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.data_notes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coverage_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coverage_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orbit_item_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orbit_source_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orbit_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.notes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_ALLOW_ErrorCount > 0, 1, 0) + IF(le.input_file_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.market_restrict_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.clean_fax_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prepped_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prepped_addr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT311.StrType ErrorMessage;
    SALT311.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.item_source_Invalid,le.source_code_Invalid,le.display_name_Invalid,le.description_Invalid,le.status_Invalid,le.data_notes_Invalid,le.coverage_1_Invalid,le.coverage_2_Invalid,le.orbit_item_name_Invalid,le.orbit_source_Invalid,le.orbit_number_Invalid,le.website_Invalid,le.notes_Invalid,le.date_added_Invalid,le.input_file_id_Invalid,le.market_restrict_flag_Invalid,le.clean_phone_Invalid,le.clean_fax_Invalid,le.prepped_addr1_Invalid,le.prepped_addr2_Invalid,le.v_prim_name_Invalid,le.v_zip_Invalid,le.v_zip4_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_item_source(le.item_source_Invalid),Base_Fields.InvalidMessage_source_code(le.source_code_Invalid),Base_Fields.InvalidMessage_display_name(le.display_name_Invalid),Base_Fields.InvalidMessage_description(le.description_Invalid),Base_Fields.InvalidMessage_status(le.status_Invalid),Base_Fields.InvalidMessage_data_notes(le.data_notes_Invalid),Base_Fields.InvalidMessage_coverage_1(le.coverage_1_Invalid),Base_Fields.InvalidMessage_coverage_2(le.coverage_2_Invalid),Base_Fields.InvalidMessage_orbit_item_name(le.orbit_item_name_Invalid),Base_Fields.InvalidMessage_orbit_source(le.orbit_source_Invalid),Base_Fields.InvalidMessage_orbit_number(le.orbit_number_Invalid),Base_Fields.InvalidMessage_website(le.website_Invalid),Base_Fields.InvalidMessage_notes(le.notes_Invalid),Base_Fields.InvalidMessage_date_added(le.date_added_Invalid),Base_Fields.InvalidMessage_input_file_id(le.input_file_id_Invalid),Base_Fields.InvalidMessage_market_restrict_flag(le.market_restrict_flag_Invalid),Base_Fields.InvalidMessage_clean_phone(le.clean_phone_Invalid),Base_Fields.InvalidMessage_clean_fax(le.clean_fax_Invalid),Base_Fields.InvalidMessage_prepped_addr1(le.prepped_addr1_Invalid),Base_Fields.InvalidMessage_prepped_addr2(le.prepped_addr2_Invalid),Base_Fields.InvalidMessage_v_prim_name(le.v_prim_name_Invalid),Base_Fields.InvalidMessage_v_zip(le.v_zip_Invalid),Base_Fields.InvalidMessage_v_zip4(le.v_zip4_Invalid),Base_Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Base_Fields.InvalidMessage_predir(le.predir_Invalid),Base_Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Base_Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Base_Fields.InvalidMessage_postdir(le.postdir_Invalid),Base_Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Base_Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Base_Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Base_Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Base_Fields.InvalidMessage_st(le.st_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_zip4(le.zip4_Invalid),Base_Fields.InvalidMessage_cart(le.cart_Invalid),Base_Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Base_Fields.InvalidMessage_lot(le.lot_Invalid),Base_Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Base_Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Base_Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Base_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Base_Fields.InvalidMessage_county(le.county_Invalid),Base_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Base_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Base_Fields.InvalidMessage_msa(le.msa_Invalid),Base_Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Base_Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Base_Fields.InvalidMessage_err_stat(le.err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.item_source_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.display_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.description_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.data_notes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coverage_1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coverage_2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orbit_item_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orbit_source_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orbit_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.website_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.notes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.input_file_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.market_restrict_flag_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.clean_fax_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prepped_addr1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prepped_addr2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dbpc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'item_source','source_code','display_name','description','status','data_notes','coverage_1','coverage_2','orbit_item_name','orbit_source','orbit_number','website','notes','date_added','input_file_id','market_restrict_flag','clean_phone','clean_fax','prepped_addr1','prepped_addr2','v_prim_name','v_zip','v_zip4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'item_source','source_code','display_name','description','status','data_notes','coverage_1','coverage_2','orbit_item_name','orbit_source','orbit_number','website','notes','date_added','input_file_id','market_restrict_flag','clean_phone','clean_fax','prepped_addr1','prepped_addr2','v_prim_name','v_zip','v_zip4','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.item_source,(SALT311.StrType)le.source_code,(SALT311.StrType)le.display_name,(SALT311.StrType)le.description,(SALT311.StrType)le.status,(SALT311.StrType)le.data_notes,(SALT311.StrType)le.coverage_1,(SALT311.StrType)le.coverage_2,(SALT311.StrType)le.orbit_item_name,(SALT311.StrType)le.orbit_source,(SALT311.StrType)le.orbit_number,(SALT311.StrType)le.website,(SALT311.StrType)le.notes,(SALT311.StrType)le.date_added,(SALT311.StrType)le.input_file_id,(SALT311.StrType)le.market_restrict_flag,(SALT311.StrType)le.clean_phone,(SALT311.StrType)le.clean_fax,(SALT311.StrType)le.prepped_addr1,(SALT311.StrType)le.prepped_addr2,(SALT311.StrType)le.v_prim_name,(SALT311.StrType)le.v_zip,(SALT311.StrType)le.v_zip4,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dbpc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.county,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,49,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_Vendor_Src) prevDS = DATASET([], Base_Layout_Vendor_Src), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'item_source:item_source:ALLOW'
          ,'source_code:source_code:ALLOW'
          ,'display_name:display_name:ALLOW'
          ,'description:description:ALLOW'
          ,'status:status:ALLOW'
          ,'data_notes:data_notes:ALLOW'
          ,'coverage_1:coverage_1:ALLOW'
          ,'coverage_2:coverage_2:ALLOW'
          ,'orbit_item_name:orbit_item_name:ALLOW'
          ,'orbit_source:orbit_source:ALLOW'
          ,'orbit_number:orbit_number:ALLOW'
          ,'website:website:ALLOW'
          ,'notes:notes:ALLOW'
          ,'date_added:date_added:ALLOW'
          ,'input_file_id:input_file_id:ALLOW'
          ,'market_restrict_flag:market_restrict_flag:ALLOW'
          ,'clean_phone:clean_phone:ALLOW'
          ,'clean_fax:clean_fax:ALLOW'
          ,'prepped_addr1:prepped_addr1:ALLOW'
          ,'prepped_addr2:prepped_addr2:ALLOW'
          ,'v_prim_name:v_prim_name:ALLOW'
          ,'v_zip:v_zip:ALLOW'
          ,'v_zip4:v_zip4:ALLOW'
          ,'prim_range:prim_range:ALLOW'
          ,'predir:predir:ALLOW'
          ,'prim_name:prim_name:ALLOW'
          ,'addr_suffix:addr_suffix:ALLOW'
          ,'postdir:postdir:ALLOW'
          ,'unit_desig:unit_desig:ALLOW'
          ,'sec_range:sec_range:ALLOW'
          ,'p_city_name:p_city_name:ALLOW'
          ,'v_city_name:v_city_name:ALLOW'
          ,'st:st:ALLOW'
          ,'zip:zip:ALLOW'
          ,'zip4:zip4:ALLOW'
          ,'cart:cart:ALLOW'
          ,'cr_sort_sz:cr_sort_sz:ALLOW'
          ,'lot:lot:ALLOW'
          ,'lot_order:lot_order:ALLOW'
          ,'dbpc:dbpc:ALLOW'
          ,'chk_digit:chk_digit:ALLOW'
          ,'rec_type:rec_type:ALLOW'
          ,'county:county:ALLOW'
          ,'geo_lat:geo_lat:ALLOW'
          ,'geo_long:geo_long:ALLOW'
          ,'msa:msa:ALLOW'
          ,'geo_blk:geo_blk:ALLOW'
          ,'geo_match:geo_match:ALLOW'
          ,'err_stat:err_stat:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_item_source(1)
          ,Base_Fields.InvalidMessage_source_code(1)
          ,Base_Fields.InvalidMessage_display_name(1)
          ,Base_Fields.InvalidMessage_description(1)
          ,Base_Fields.InvalidMessage_status(1)
          ,Base_Fields.InvalidMessage_data_notes(1)
          ,Base_Fields.InvalidMessage_coverage_1(1)
          ,Base_Fields.InvalidMessage_coverage_2(1)
          ,Base_Fields.InvalidMessage_orbit_item_name(1)
          ,Base_Fields.InvalidMessage_orbit_source(1)
          ,Base_Fields.InvalidMessage_orbit_number(1)
          ,Base_Fields.InvalidMessage_website(1)
          ,Base_Fields.InvalidMessage_notes(1)
          ,Base_Fields.InvalidMessage_date_added(1)
          ,Base_Fields.InvalidMessage_input_file_id(1)
          ,Base_Fields.InvalidMessage_market_restrict_flag(1)
          ,Base_Fields.InvalidMessage_clean_phone(1)
          ,Base_Fields.InvalidMessage_clean_fax(1)
          ,Base_Fields.InvalidMessage_prepped_addr1(1)
          ,Base_Fields.InvalidMessage_prepped_addr2(1)
          ,Base_Fields.InvalidMessage_v_prim_name(1)
          ,Base_Fields.InvalidMessage_v_zip(1)
          ,Base_Fields.InvalidMessage_v_zip4(1)
          ,Base_Fields.InvalidMessage_prim_range(1)
          ,Base_Fields.InvalidMessage_predir(1)
          ,Base_Fields.InvalidMessage_prim_name(1)
          ,Base_Fields.InvalidMessage_addr_suffix(1)
          ,Base_Fields.InvalidMessage_postdir(1)
          ,Base_Fields.InvalidMessage_unit_desig(1)
          ,Base_Fields.InvalidMessage_sec_range(1)
          ,Base_Fields.InvalidMessage_p_city_name(1)
          ,Base_Fields.InvalidMessage_v_city_name(1)
          ,Base_Fields.InvalidMessage_st(1)
          ,Base_Fields.InvalidMessage_zip(1)
          ,Base_Fields.InvalidMessage_zip4(1)
          ,Base_Fields.InvalidMessage_cart(1)
          ,Base_Fields.InvalidMessage_cr_sort_sz(1)
          ,Base_Fields.InvalidMessage_lot(1)
          ,Base_Fields.InvalidMessage_lot_order(1)
          ,Base_Fields.InvalidMessage_dbpc(1)
          ,Base_Fields.InvalidMessage_chk_digit(1)
          ,Base_Fields.InvalidMessage_rec_type(1)
          ,Base_Fields.InvalidMessage_county(1)
          ,Base_Fields.InvalidMessage_geo_lat(1)
          ,Base_Fields.InvalidMessage_geo_long(1)
          ,Base_Fields.InvalidMessage_msa(1)
          ,Base_Fields.InvalidMessage_geo_blk(1)
          ,Base_Fields.InvalidMessage_geo_match(1)
          ,Base_Fields.InvalidMessage_err_stat(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.item_source_ALLOW_ErrorCount
          ,le.source_code_ALLOW_ErrorCount
          ,le.display_name_ALLOW_ErrorCount
          ,le.description_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.data_notes_ALLOW_ErrorCount
          ,le.coverage_1_ALLOW_ErrorCount
          ,le.coverage_2_ALLOW_ErrorCount
          ,le.orbit_item_name_ALLOW_ErrorCount
          ,le.orbit_source_ALLOW_ErrorCount
          ,le.orbit_number_ALLOW_ErrorCount
          ,le.website_ALLOW_ErrorCount
          ,le.notes_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount
          ,le.input_file_id_ALLOW_ErrorCount
          ,le.market_restrict_flag_ALLOW_ErrorCount
          ,le.clean_phone_ALLOW_ErrorCount
          ,le.clean_fax_ALLOW_ErrorCount
          ,le.prepped_addr1_ALLOW_ErrorCount
          ,le.prepped_addr2_ALLOW_ErrorCount
          ,le.v_prim_name_ALLOW_ErrorCount
          ,le.v_zip_ALLOW_ErrorCount
          ,le.v_zip4_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount
          ,le.dbpc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.item_source_ALLOW_ErrorCount
          ,le.source_code_ALLOW_ErrorCount
          ,le.display_name_ALLOW_ErrorCount
          ,le.description_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.data_notes_ALLOW_ErrorCount
          ,le.coverage_1_ALLOW_ErrorCount
          ,le.coverage_2_ALLOW_ErrorCount
          ,le.orbit_item_name_ALLOW_ErrorCount
          ,le.orbit_source_ALLOW_ErrorCount
          ,le.orbit_number_ALLOW_ErrorCount
          ,le.website_ALLOW_ErrorCount
          ,le.notes_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount
          ,le.input_file_id_ALLOW_ErrorCount
          ,le.market_restrict_flag_ALLOW_ErrorCount
          ,le.clean_phone_ALLOW_ErrorCount
          ,le.clean_fax_ALLOW_ErrorCount
          ,le.prepped_addr1_ALLOW_ErrorCount
          ,le.prepped_addr2_ALLOW_ErrorCount
          ,le.v_prim_name_ALLOW_ErrorCount
          ,le.v_zip_ALLOW_ErrorCount
          ,le.v_zip4_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ALLOW_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount
          ,le.dbpc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_ALLOW_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_WithErrors/NumFieldsWithRules * 100)
          ,IF(NumFieldsWithRules = 0, 0, le.FieldsChecked_NoErrors/NumFieldsWithRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_WithErrors/NumRules * 100)
          ,IF(NumRules = 0, 0, le.Rules_NoErrors/NumRules * 100)
          ,0
          ,IF(SELF.recordstotal = 0, 0, le.AnyRule_WithErrorsCount/SELF.recordstotal * 100)
          ,IF(SELF.recordstotal = 0, 0, (SELF.recordstotal - le.AnyRule_WithErrorsCount)/SELF.recordstotal * 100),0));
    END;
    SummaryInfo := NORMALIZE(SummaryStats,NumRules + 7,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT311.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT311.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_Vendor_Src));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'item_source:' + getFieldTypeText(h.item_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'display_name:' + getFieldTypeText(h.display_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'description:' + getFieldTypeText(h.description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status:' + getFieldTypeText(h.status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'data_notes:' + getFieldTypeText(h.data_notes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coverage_1:' + getFieldTypeText(h.coverage_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coverage_2:' + getFieldTypeText(h.coverage_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orbit_item_name:' + getFieldTypeText(h.orbit_item_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orbit_source:' + getFieldTypeText(h.orbit_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orbit_number:' + getFieldTypeText(h.orbit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'website:' + getFieldTypeText(h.website) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'notes:' + getFieldTypeText(h.notes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'input_file_id:' + getFieldTypeText(h.input_file_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'market_restrict_flag:' + getFieldTypeText(h.market_restrict_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phone:' + getFieldTypeText(h.clean_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_fax:' + getFieldTypeText(h.clean_fax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepped_addr1:' + getFieldTypeText(h.prepped_addr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepped_addr2:' + getFieldTypeText(h.prepped_addr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_prim_name:' + getFieldTypeText(h.v_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_zip:' + getFieldTypeText(h.v_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_zip4:' + getFieldTypeText(h.v_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbpc:' + getFieldTypeText(h.dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_item_source_cnt
          ,le.populated_source_code_cnt
          ,le.populated_display_name_cnt
          ,le.populated_description_cnt
          ,le.populated_status_cnt
          ,le.populated_data_notes_cnt
          ,le.populated_coverage_1_cnt
          ,le.populated_coverage_2_cnt
          ,le.populated_orbit_item_name_cnt
          ,le.populated_orbit_source_cnt
          ,le.populated_orbit_number_cnt
          ,le.populated_website_cnt
          ,le.populated_notes_cnt
          ,le.populated_date_added_cnt
          ,le.populated_input_file_id_cnt
          ,le.populated_market_restrict_flag_cnt
          ,le.populated_clean_phone_cnt
          ,le.populated_clean_fax_cnt
          ,le.populated_prepped_addr1_cnt
          ,le.populated_prepped_addr2_cnt
          ,le.populated_v_prim_name_cnt
          ,le.populated_v_zip_cnt
          ,le.populated_v_zip4_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dbpc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_item_source_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_display_name_pcnt
          ,le.populated_description_pcnt
          ,le.populated_status_pcnt
          ,le.populated_data_notes_pcnt
          ,le.populated_coverage_1_pcnt
          ,le.populated_coverage_2_pcnt
          ,le.populated_orbit_item_name_pcnt
          ,le.populated_orbit_source_pcnt
          ,le.populated_orbit_number_pcnt
          ,le.populated_website_pcnt
          ,le.populated_notes_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_input_file_id_pcnt
          ,le.populated_market_restrict_flag_pcnt
          ,le.populated_clean_phone_pcnt
          ,le.populated_clean_fax_pcnt
          ,le.populated_prepped_addr1_pcnt
          ,le.populated_prepped_addr2_pcnt
          ,le.populated_v_prim_name_pcnt
          ,le.populated_v_zip_pcnt
          ,le.populated_v_zip4_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dbpc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,49,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_Vendor_Src));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),49,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_Vendor_Src) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Vendor_Src, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
