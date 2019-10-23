IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 54;
  EXPORT NumRulesFromFieldType := 54;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 54;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_LN_PropertyV2_Search)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 ln_fares_id_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 which_orig_Invalid;
    UNSIGNED1 conjunctive_name_seq_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 cname_Invalid;
    UNSIGNED1 nameasis_Invalid;
    UNSIGNED1 append_prepaddr1_Invalid;
    UNSIGNED1 append_prepaddr2_Invalid;
    UNSIGNED1 append_rawaid_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 suffix_Invalid;
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
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 app_ssn_Invalid;
    UNSIGNED1 app_tax_id_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
    UNSIGNED1 ln_party_status_Invalid;
    UNSIGNED1 ln_percentage_ownership_Invalid;
    UNSIGNED1 ln_entity_type_Invalid;
    UNSIGNED1 ln_estate_trust_date_Invalid;
    UNSIGNED1 addr_ind_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_LN_PropertyV2_Search)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_LN_PropertyV2_Search) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.ln_fares_id_Invalid := Fields.InValid_ln_fares_id((SALT311.StrType)le.ln_fares_id);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.source_code_Invalid := Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.which_orig_Invalid := Fields.InValid_which_orig((SALT311.StrType)le.which_orig);
    SELF.conjunctive_name_seq_Invalid := Fields.InValid_conjunctive_name_seq((SALT311.StrType)le.conjunctive_name_seq);
    SELF.title_Invalid := Fields.InValid_title((SALT311.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.cname_Invalid := Fields.InValid_cname((SALT311.StrType)le.cname);
    SELF.nameasis_Invalid := Fields.InValid_nameasis((SALT311.StrType)le.nameasis);
    SELF.append_prepaddr1_Invalid := Fields.InValid_append_prepaddr1((SALT311.StrType)le.append_prepaddr1);
    SELF.append_prepaddr2_Invalid := Fields.InValid_append_prepaddr2((SALT311.StrType)le.append_prepaddr2);
    SELF.append_rawaid_Invalid := Fields.InValid_append_rawaid((SALT311.StrType)le.append_rawaid);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT311.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT311.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT311.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT311.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT311.StrType)le.st);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT311.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT311.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT311.StrType)le.lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT311.StrType)le.lot_order);
    SELF.dbpc_Invalid := Fields.InValid_dbpc((SALT311.StrType)le.dbpc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT311.StrType)le.rec_type);
    SELF.county_Invalid := Fields.InValid_county((SALT311.StrType)le.county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT311.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT311.StrType)le.err_stat);
    SELF.phone_number_Invalid := Fields.InValid_phone_number((SALT311.StrType)le.phone_number);
    SELF.app_ssn_Invalid := Fields.InValid_app_ssn((SALT311.StrType)le.app_ssn);
    SELF.app_tax_id_Invalid := Fields.InValid_app_tax_id((SALT311.StrType)le.app_tax_id);
    SELF.source_rec_id_Invalid := Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id);
    SELF.ln_party_status_Invalid := Fields.InValid_ln_party_status((SALT311.StrType)le.ln_party_status);
    SELF.ln_percentage_ownership_Invalid := Fields.InValid_ln_percentage_ownership((SALT311.StrType)le.ln_percentage_ownership);
    SELF.ln_entity_type_Invalid := Fields.InValid_ln_entity_type((SALT311.StrType)le.ln_entity_type);
    SELF.ln_estate_trust_date_Invalid := Fields.InValid_ln_estate_trust_date((SALT311.StrType)le.ln_estate_trust_date);
    SELF.addr_ind_Invalid := Fields.InValid_addr_ind((SALT311.StrType)le.addr_ind);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_LN_PropertyV2_Search);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.ln_fares_id_Invalid << 4 ) + ( le.process_date_Invalid << 5 ) + ( le.source_code_Invalid << 6 ) + ( le.which_orig_Invalid << 7 ) + ( le.conjunctive_name_seq_Invalid << 8 ) + ( le.title_Invalid << 9 ) + ( le.fname_Invalid << 10 ) + ( le.mname_Invalid << 11 ) + ( le.lname_Invalid << 12 ) + ( le.name_suffix_Invalid << 13 ) + ( le.cname_Invalid << 14 ) + ( le.nameasis_Invalid << 15 ) + ( le.append_prepaddr1_Invalid << 16 ) + ( le.append_prepaddr2_Invalid << 17 ) + ( le.append_rawaid_Invalid << 18 ) + ( le.prim_range_Invalid << 19 ) + ( le.predir_Invalid << 20 ) + ( le.prim_name_Invalid << 21 ) + ( le.suffix_Invalid << 22 ) + ( le.postdir_Invalid << 23 ) + ( le.unit_desig_Invalid << 24 ) + ( le.sec_range_Invalid << 25 ) + ( le.p_city_name_Invalid << 26 ) + ( le.v_city_name_Invalid << 27 ) + ( le.st_Invalid << 28 ) + ( le.zip_Invalid << 29 ) + ( le.zip4_Invalid << 30 ) + ( le.cart_Invalid << 31 ) + ( le.cr_sort_sz_Invalid << 32 ) + ( le.lot_Invalid << 33 ) + ( le.lot_order_Invalid << 34 ) + ( le.dbpc_Invalid << 35 ) + ( le.chk_digit_Invalid << 36 ) + ( le.rec_type_Invalid << 37 ) + ( le.county_Invalid << 38 ) + ( le.geo_lat_Invalid << 39 ) + ( le.geo_long_Invalid << 40 ) + ( le.msa_Invalid << 41 ) + ( le.geo_blk_Invalid << 42 ) + ( le.geo_match_Invalid << 43 ) + ( le.err_stat_Invalid << 44 ) + ( le.phone_number_Invalid << 45 ) + ( le.app_ssn_Invalid << 46 ) + ( le.app_tax_id_Invalid << 47 ) + ( le.source_rec_id_Invalid << 48 ) + ( le.ln_party_status_Invalid << 49 ) + ( le.ln_percentage_ownership_Invalid << 50 ) + ( le.ln_entity_type_Invalid << 51 ) + ( le.ln_estate_trust_date_Invalid << 52 ) + ( le.addr_ind_Invalid << 53 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_LN_PropertyV2_Search);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.ln_fares_id_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.which_orig_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.conjunctive_name_seq_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.cname_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.nameasis_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.append_prepaddr1_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.append_prepaddr2_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.append_rawaid_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.dbpc_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.app_ssn_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.app_tax_id_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.source_rec_id_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.ln_party_status_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.ln_percentage_ownership_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.ln_entity_type_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.ln_estate_trust_date_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.addr_ind_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    ln_fares_id_ALLOW_ErrorCount := COUNT(GROUP,h.ln_fares_id_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    source_code_ENUM_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    which_orig_ALLOW_ErrorCount := COUNT(GROUP,h.which_orig_Invalid=1);
    conjunctive_name_seq_ALLOW_ErrorCount := COUNT(GROUP,h.conjunctive_name_seq_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    cname_ALLOW_ErrorCount := COUNT(GROUP,h.cname_Invalid=1);
    nameasis_ALLOW_ErrorCount := COUNT(GROUP,h.nameasis_Invalid=1);
    append_prepaddr1_ALLOW_ErrorCount := COUNT(GROUP,h.append_prepaddr1_Invalid=1);
    append_prepaddr2_ALLOW_ErrorCount := COUNT(GROUP,h.append_prepaddr2_Invalid=1);
    append_rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.append_rawaid_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
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
    rec_type_ENUM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    app_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.app_ssn_Invalid=1);
    app_tax_id_ALLOW_ErrorCount := COUNT(GROUP,h.app_tax_id_Invalid=1);
    source_rec_id_ALLOW_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    ln_party_status_ENUM_ErrorCount := COUNT(GROUP,h.ln_party_status_Invalid=1);
    ln_percentage_ownership_ALLOW_ErrorCount := COUNT(GROUP,h.ln_percentage_ownership_Invalid=1);
    ln_entity_type_ENUM_ErrorCount := COUNT(GROUP,h.ln_entity_type_Invalid=1);
    ln_estate_trust_date_ALLOW_ErrorCount := COUNT(GROUP,h.ln_estate_trust_date_Invalid=1);
    addr_ind_ALLOW_ErrorCount := COUNT(GROUP,h.addr_ind_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.ln_fares_id_Invalid > 0 OR h.process_date_Invalid > 0 OR h.source_code_Invalid > 0 OR h.which_orig_Invalid > 0 OR h.conjunctive_name_seq_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.cname_Invalid > 0 OR h.nameasis_Invalid > 0 OR h.append_prepaddr1_Invalid > 0 OR h.append_prepaddr2_Invalid > 0 OR h.append_rawaid_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.phone_number_Invalid > 0 OR h.app_ssn_Invalid > 0 OR h.app_tax_id_Invalid > 0 OR h.source_rec_id_Invalid > 0 OR h.ln_party_status_Invalid > 0 OR h.ln_percentage_ownership_Invalid > 0 OR h.ln_entity_type_Invalid > 0 OR h.ln_estate_trust_date_Invalid > 0 OR h.addr_ind_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ln_fares_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.which_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.conjunctive_name_seq_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nameasis_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prepaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prepaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.app_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.app_tax_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_party_status_ENUM_ErrorCount > 0, 1, 0) + IF(le.ln_percentage_ownership_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_entity_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ln_estate_trust_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_ind_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ln_fares_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.which_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.conjunctive_name_seq_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nameasis_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prepaddr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_prepaddr2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.append_rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.app_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.app_tax_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_party_status_ENUM_ErrorCount > 0, 1, 0) + IF(le.ln_percentage_ownership_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ln_entity_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ln_estate_trust_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_ind_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.ln_fares_id_Invalid,le.process_date_Invalid,le.source_code_Invalid,le.which_orig_Invalid,le.conjunctive_name_seq_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.cname_Invalid,le.nameasis_Invalid,le.append_prepaddr1_Invalid,le.append_prepaddr2_Invalid,le.append_rawaid_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.phone_number_Invalid,le.app_ssn_Invalid,le.app_tax_id_Invalid,le.source_rec_id_Invalid,le.ln_party_status_Invalid,le.ln_percentage_ownership_Invalid,le.ln_entity_type_Invalid,le.ln_estate_trust_date_Invalid,le.addr_ind_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_ln_fares_id(le.ln_fares_id_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_source_code(le.source_code_Invalid),Fields.InvalidMessage_which_orig(le.which_orig_Invalid),Fields.InvalidMessage_conjunctive_name_seq(le.conjunctive_name_seq_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_cname(le.cname_Invalid),Fields.InvalidMessage_nameasis(le.nameasis_Invalid),Fields.InvalidMessage_append_prepaddr1(le.append_prepaddr1_Invalid),Fields.InvalidMessage_append_prepaddr2(le.append_prepaddr2_Invalid),Fields.InvalidMessage_append_rawaid(le.append_rawaid_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Fields.InvalidMessage_app_ssn(le.app_ssn_Invalid),Fields.InvalidMessage_app_tax_id(le.app_tax_id_Invalid),Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),Fields.InvalidMessage_ln_party_status(le.ln_party_status_Invalid),Fields.InvalidMessage_ln_percentage_ownership(le.ln_percentage_ownership_Invalid),Fields.InvalidMessage_ln_entity_type(le.ln_entity_type_Invalid),Fields.InvalidMessage_ln_estate_trust_date(le.ln_estate_trust_date_Invalid),Fields.InvalidMessage_addr_ind(le.addr_ind_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ln_fares_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.which_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.conjunctive_name_seq_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nameasis_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prepaddr1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_prepaddr2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.append_rawaid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
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
          ,CHOOSE(le.rec_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.app_ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.app_tax_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ln_party_status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ln_percentage_ownership_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ln_entity_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ln_estate_trust_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_ind_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','ln_fares_id','process_date','source_code','which_orig','conjunctive_name_seq','title','fname','mname','lname','name_suffix','cname','nameasis','append_prepaddr1','append_prepaddr2','append_rawaid','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','phone_number','app_ssn','app_tax_id','source_rec_id','ln_party_status','ln_percentage_ownership','ln_entity_type','ln_estate_trust_date','addr_ind','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_LNFaresID','Invalid_Date','Invalid_SourceCode','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_RecType','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_PartyStatus','Invalid_Percent','Invalid_LNEntityType','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.ln_fares_id,(SALT311.StrType)le.process_date,(SALT311.StrType)le.source_code,(SALT311.StrType)le.which_orig,(SALT311.StrType)le.conjunctive_name_seq,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.cname,(SALT311.StrType)le.nameasis,(SALT311.StrType)le.append_prepaddr1,(SALT311.StrType)le.append_prepaddr2,(SALT311.StrType)le.append_rawaid,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dbpc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.county,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,(SALT311.StrType)le.phone_number,(SALT311.StrType)le.app_ssn,(SALT311.StrType)le.app_tax_id,(SALT311.StrType)le.source_rec_id,(SALT311.StrType)le.ln_party_status,(SALT311.StrType)le.ln_percentage_ownership,(SALT311.StrType)le.ln_entity_type,(SALT311.StrType)le.ln_estate_trust_date,(SALT311.StrType)le.addr_ind,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,54,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_LN_PropertyV2_Search) prevDS = DATASET([], Layout_LN_PropertyV2_Search), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:Invalid_Date:CUSTOM'
          ,'dt_last_seen:Invalid_Date:CUSTOM'
          ,'dt_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'dt_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'ln_fares_id:Invalid_LNFaresID:ALLOW'
          ,'process_date:Invalid_Date:CUSTOM'
          ,'source_code:Invalid_SourceCode:ENUM'
          ,'which_orig:Invalid_Num:ALLOW'
          ,'conjunctive_name_seq:Invalid_Num:ALLOW'
          ,'title:Invalid_Char:ALLOW'
          ,'fname:Invalid_Char:ALLOW'
          ,'mname:Invalid_Char:ALLOW'
          ,'lname:Invalid_Char:ALLOW'
          ,'name_suffix:Invalid_Char:ALLOW'
          ,'cname:Invalid_Char:ALLOW'
          ,'nameasis:Invalid_Char:ALLOW'
          ,'append_prepaddr1:Invalid_Char:ALLOW'
          ,'append_prepaddr2:Invalid_Char:ALLOW'
          ,'append_rawaid:Invalid_Num:ALLOW'
          ,'prim_range:Invalid_Char:ALLOW'
          ,'predir:Invalid_Char:ALLOW'
          ,'prim_name:Invalid_Char:ALLOW'
          ,'suffix:Invalid_Char:ALLOW'
          ,'postdir:Invalid_Char:ALLOW'
          ,'unit_desig:Invalid_Char:ALLOW'
          ,'sec_range:Invalid_Char:ALLOW'
          ,'p_city_name:Invalid_Char:ALLOW'
          ,'v_city_name:Invalid_Char:ALLOW'
          ,'st:Invalid_Char:ALLOW'
          ,'zip:Invalid_Num:ALLOW'
          ,'zip4:Invalid_Num:ALLOW'
          ,'cart:Invalid_Char:ALLOW'
          ,'cr_sort_sz:Invalid_Char:ALLOW'
          ,'lot:Invalid_Num:ALLOW'
          ,'lot_order:Invalid_Num:ALLOW'
          ,'dbpc:Invalid_Num:ALLOW'
          ,'chk_digit:Invalid_Num:ALLOW'
          ,'rec_type:Invalid_RecType:ENUM'
          ,'county:Invalid_Num:ALLOW'
          ,'geo_lat:Invalid_Num:ALLOW'
          ,'geo_long:Invalid_Num:ALLOW'
          ,'msa:Invalid_Num:ALLOW'
          ,'geo_blk:Invalid_Num:ALLOW'
          ,'geo_match:Invalid_Num:ALLOW'
          ,'err_stat:Invalid_Char:ALLOW'
          ,'phone_number:Invalid_Num:ALLOW'
          ,'app_ssn:Invalid_Num:ALLOW'
          ,'app_tax_id:Invalid_Num:ALLOW'
          ,'source_rec_id:Invalid_Num:ALLOW'
          ,'ln_party_status:Invalid_PartyStatus:ENUM'
          ,'ln_percentage_ownership:Invalid_Percent:ALLOW'
          ,'ln_entity_type:Invalid_LNEntityType:ENUM'
          ,'ln_estate_trust_date:Invalid_Num:ALLOW'
          ,'addr_ind:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_dt_first_seen(1)
          ,Fields.InvalidMessage_dt_last_seen(1)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Fields.InvalidMessage_ln_fares_id(1)
          ,Fields.InvalidMessage_process_date(1)
          ,Fields.InvalidMessage_source_code(1)
          ,Fields.InvalidMessage_which_orig(1)
          ,Fields.InvalidMessage_conjunctive_name_seq(1)
          ,Fields.InvalidMessage_title(1)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_name_suffix(1)
          ,Fields.InvalidMessage_cname(1)
          ,Fields.InvalidMessage_nameasis(1)
          ,Fields.InvalidMessage_append_prepaddr1(1)
          ,Fields.InvalidMessage_append_prepaddr2(1)
          ,Fields.InvalidMessage_append_rawaid(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_unit_desig(1)
          ,Fields.InvalidMessage_sec_range(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_st(1)
          ,Fields.InvalidMessage_zip(1)
          ,Fields.InvalidMessage_zip4(1)
          ,Fields.InvalidMessage_cart(1)
          ,Fields.InvalidMessage_cr_sort_sz(1)
          ,Fields.InvalidMessage_lot(1)
          ,Fields.InvalidMessage_lot_order(1)
          ,Fields.InvalidMessage_dbpc(1)
          ,Fields.InvalidMessage_chk_digit(1)
          ,Fields.InvalidMessage_rec_type(1)
          ,Fields.InvalidMessage_county(1)
          ,Fields.InvalidMessage_geo_lat(1)
          ,Fields.InvalidMessage_geo_long(1)
          ,Fields.InvalidMessage_msa(1)
          ,Fields.InvalidMessage_geo_blk(1)
          ,Fields.InvalidMessage_geo_match(1)
          ,Fields.InvalidMessage_err_stat(1)
          ,Fields.InvalidMessage_phone_number(1)
          ,Fields.InvalidMessage_app_ssn(1)
          ,Fields.InvalidMessage_app_tax_id(1)
          ,Fields.InvalidMessage_source_rec_id(1)
          ,Fields.InvalidMessage_ln_party_status(1)
          ,Fields.InvalidMessage_ln_percentage_ownership(1)
          ,Fields.InvalidMessage_ln_entity_type(1)
          ,Fields.InvalidMessage_ln_estate_trust_date(1)
          ,Fields.InvalidMessage_addr_ind(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.ln_fares_id_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.source_code_ENUM_ErrorCount
          ,le.which_orig_ALLOW_ErrorCount
          ,le.conjunctive_name_seq_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.cname_ALLOW_ErrorCount
          ,le.nameasis_ALLOW_ErrorCount
          ,le.append_prepaddr1_ALLOW_ErrorCount
          ,le.append_prepaddr2_ALLOW_ErrorCount
          ,le.append_rawaid_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
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
          ,le.rec_type_ENUM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.app_ssn_ALLOW_ErrorCount
          ,le.app_tax_id_ALLOW_ErrorCount
          ,le.source_rec_id_ALLOW_ErrorCount
          ,le.ln_party_status_ENUM_ErrorCount
          ,le.ln_percentage_ownership_ALLOW_ErrorCount
          ,le.ln_entity_type_ENUM_ErrorCount
          ,le.ln_estate_trust_date_ALLOW_ErrorCount
          ,le.addr_ind_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.ln_fares_id_ALLOW_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.source_code_ENUM_ErrorCount
          ,le.which_orig_ALLOW_ErrorCount
          ,le.conjunctive_name_seq_ALLOW_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.cname_ALLOW_ErrorCount
          ,le.nameasis_ALLOW_ErrorCount
          ,le.append_prepaddr1_ALLOW_ErrorCount
          ,le.append_prepaddr2_ALLOW_ErrorCount
          ,le.append_rawaid_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
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
          ,le.rec_type_ENUM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.app_ssn_ALLOW_ErrorCount
          ,le.app_tax_id_ALLOW_ErrorCount
          ,le.source_rec_id_ALLOW_ErrorCount
          ,le.ln_party_status_ENUM_ErrorCount
          ,le.ln_percentage_ownership_ALLOW_ErrorCount
          ,le.ln_entity_type_ENUM_ErrorCount
          ,le.ln_estate_trust_date_ALLOW_ErrorCount
          ,le.addr_ind_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_LN_PropertyV2_Search));
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
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor_source_flag:' + getFieldTypeText(h.vendor_source_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_fares_id:' + getFieldTypeText(h.ln_fares_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'which_orig:' + getFieldTypeText(h.which_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'conjunctive_name_seq:' + getFieldTypeText(h.conjunctive_name_seq) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname:' + getFieldTypeText(h.cname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nameasis:' + getFieldTypeText(h.nameasis) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prepaddr1:' + getFieldTypeText(h.append_prepaddr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_prepaddr2:' + getFieldTypeText(h.append_prepaddr2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_rawaid:' + getFieldTypeText(h.append_rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_type:' + getFieldTypeText(h.name_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prop_addr_propagated_ind:' + getFieldTypeText(h.prop_addr_propagated_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'app_ssn:' + getFieldTypeText(h.app_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'app_tax_id:' + getFieldTypeText(h.app_tax_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotid:' + getFieldTypeText(h.dotid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotscore:' + getFieldTypeText(h.dotscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dotweight:' + getFieldTypeText(h.dotweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empid:' + getFieldTypeText(h.empid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empscore:' + getFieldTypeText(h.empscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'empweight:' + getFieldTypeText(h.empweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powscore:' + getFieldTypeText(h.powscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'powweight:' + getFieldTypeText(h.powweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxscore:' + getFieldTypeText(h.proxscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxweight:' + getFieldTypeText(h.proxweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'selescore:' + getFieldTypeText(h.selescore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleweight:' + getFieldTypeText(h.seleweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgscore:' + getFieldTypeText(h.orgscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgweight:' + getFieldTypeText(h.orgweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultscore:' + getFieldTypeText(h.ultscore) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_party_status:' + getFieldTypeText(h.ln_party_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_percentage_ownership:' + getFieldTypeText(h.ln_percentage_ownership) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_entity_type:' + getFieldTypeText(h.ln_entity_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_estate_trust_date:' + getFieldTypeText(h.ln_estate_trust_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ln_goverment_type:' + getFieldTypeText(h.ln_goverment_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'xadl2_weight:' + getFieldTypeText(h.xadl2_weight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_ind:' + getFieldTypeText(h.addr_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'best_addr_ind:' + getFieldTypeText(h.best_addr_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_tx_id:' + getFieldTypeText(h.addr_tx_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'best_addr_tx_id:' + getFieldTypeText(h.best_addr_tx_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_id:' + getFieldTypeText(h.location_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'best_locid:' + getFieldTypeText(h.best_locid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_vendor_source_flag_cnt
          ,le.populated_ln_fares_id_cnt
          ,le.populated_process_date_cnt
          ,le.populated_source_code_cnt
          ,le.populated_which_orig_cnt
          ,le.populated_conjunctive_name_seq_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_cname_cnt
          ,le.populated_nameasis_cnt
          ,le.populated_append_prepaddr1_cnt
          ,le.populated_append_prepaddr2_cnt
          ,le.populated_append_rawaid_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_suffix_cnt
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
          ,le.populated_err_stat_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_name_type_cnt
          ,le.populated_prop_addr_propagated_ind_cnt
          ,le.populated_did_cnt
          ,le.populated_bdid_cnt
          ,le.populated_app_ssn_cnt
          ,le.populated_app_tax_id_cnt
          ,le.populated_dotid_cnt
          ,le.populated_dotscore_cnt
          ,le.populated_dotweight_cnt
          ,le.populated_empid_cnt
          ,le.populated_empscore_cnt
          ,le.populated_empweight_cnt
          ,le.populated_powid_cnt
          ,le.populated_powscore_cnt
          ,le.populated_powweight_cnt
          ,le.populated_proxid_cnt
          ,le.populated_proxscore_cnt
          ,le.populated_proxweight_cnt
          ,le.populated_seleid_cnt
          ,le.populated_selescore_cnt
          ,le.populated_seleweight_cnt
          ,le.populated_orgid_cnt
          ,le.populated_orgscore_cnt
          ,le.populated_orgweight_cnt
          ,le.populated_ultid_cnt
          ,le.populated_ultscore_cnt
          ,le.populated_ultweight_cnt
          ,le.populated_source_rec_id_cnt
          ,le.populated_ln_party_status_cnt
          ,le.populated_ln_percentage_ownership_cnt
          ,le.populated_ln_entity_type_cnt
          ,le.populated_ln_estate_trust_date_cnt
          ,le.populated_ln_goverment_type_cnt
          ,le.populated_xadl2_weight_cnt
          ,le.populated_addr_ind_cnt
          ,le.populated_best_addr_ind_cnt
          ,le.populated_addr_tx_id_cnt
          ,le.populated_best_addr_tx_id_cnt
          ,le.populated_location_id_cnt
          ,le.populated_best_locid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_vendor_source_flag_pcnt
          ,le.populated_ln_fares_id_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_which_orig_pcnt
          ,le.populated_conjunctive_name_seq_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_cname_pcnt
          ,le.populated_nameasis_pcnt
          ,le.populated_append_prepaddr1_pcnt
          ,le.populated_append_prepaddr2_pcnt
          ,le.populated_append_rawaid_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_suffix_pcnt
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
          ,le.populated_err_stat_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_name_type_pcnt
          ,le.populated_prop_addr_propagated_ind_pcnt
          ,le.populated_did_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_app_ssn_pcnt
          ,le.populated_app_tax_id_pcnt
          ,le.populated_dotid_pcnt
          ,le.populated_dotscore_pcnt
          ,le.populated_dotweight_pcnt
          ,le.populated_empid_pcnt
          ,le.populated_empscore_pcnt
          ,le.populated_empweight_pcnt
          ,le.populated_powid_pcnt
          ,le.populated_powscore_pcnt
          ,le.populated_powweight_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_proxscore_pcnt
          ,le.populated_proxweight_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_selescore_pcnt
          ,le.populated_seleweight_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_orgscore_pcnt
          ,le.populated_orgweight_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_ultscore_pcnt
          ,le.populated_ultweight_pcnt
          ,le.populated_source_rec_id_pcnt
          ,le.populated_ln_party_status_pcnt
          ,le.populated_ln_percentage_ownership_pcnt
          ,le.populated_ln_entity_type_pcnt
          ,le.populated_ln_estate_trust_date_pcnt
          ,le.populated_ln_goverment_type_pcnt
          ,le.populated_xadl2_weight_pcnt
          ,le.populated_addr_ind_pcnt
          ,le.populated_best_addr_ind_pcnt
          ,le.populated_addr_tx_id_pcnt
          ,le.populated_best_addr_tx_id_pcnt
          ,le.populated_location_id_pcnt
          ,le.populated_best_locid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,87,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_LN_PropertyV2_Search));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),87,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_LN_PropertyV2_Search) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_LN_PropertyV2_Search, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
