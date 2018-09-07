IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 73;
  EXPORT NumRulesFromFieldType := 73;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 73;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_PCNSR)
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_score_Invalid;
    UNSIGNED1 fname_orig_Invalid;
    UNSIGNED1 mname_orig_Invalid;
    UNSIGNED1 lname_orig_Invalid;
    UNSIGNED1 name_suffix_orig_Invalid;
    UNSIGNED1 title_orig_Invalid;
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
    UNSIGNED1 hhid_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 phone_fordid_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 date_of_birth_Invalid;
    UNSIGNED1 address_type_Invalid;
    UNSIGNED1 demographic_level_indicator_Invalid;
    UNSIGNED1 length_of_residence_Invalid;
    UNSIGNED1 location_type_Invalid;
    UNSIGNED1 dqi2_occupancy_count_Invalid;
    UNSIGNED1 delivery_unit_size_Invalid;
    UNSIGNED1 household_arrival_date_Invalid;
    UNSIGNED1 area_code_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 telephone_number_type_Invalid;
    UNSIGNED1 phone2_number_Invalid;
    UNSIGNED1 telephone2_number_type_Invalid;
    UNSIGNED1 time_zone_Invalid;
    UNSIGNED1 refresh_date_Invalid;
    UNSIGNED1 name_address_verification_source_Invalid;
    UNSIGNED1 drop_indicator_Invalid;
    UNSIGNED1 do_not_mail_flag_Invalid;
    UNSIGNED1 do_not_call_flag_Invalid;
    UNSIGNED1 business_file_hit_flag_Invalid;
    UNSIGNED1 spouse_title_Invalid;
    UNSIGNED1 spouse_fname_Invalid;
    UNSIGNED1 spouse_mname_Invalid;
    UNSIGNED1 spouse_lname_Invalid;
    UNSIGNED1 spouse_name_suffix_Invalid;
    UNSIGNED1 spouse_fname_orig_Invalid;
    UNSIGNED1 spouse_mname_orig_Invalid;
    UNSIGNED1 spouse_lname_orig_Invalid;
    UNSIGNED1 spouse_name_suffix_orig_Invalid;
    UNSIGNED1 spouse_title_orig_Invalid;
    UNSIGNED1 spouse_date_of_birth_Invalid;
    UNSIGNED1 find_income_in_1000s_Invalid;
    UNSIGNED1 phhincomeunder25k_Invalid;
    UNSIGNED1 phhincome50kplus_Invalid;
    UNSIGNED1 phhincome200kplus_Invalid;
    UNSIGNED1 medianhhincome_Invalid;
    UNSIGNED1 own_rent_Invalid;
    UNSIGNED1 homeowner_source_code_Invalid;
    UNSIGNED1 telephone_acquisition_date_Invalid;
    UNSIGNED1 recency_date_Invalid;
    UNSIGNED1 source_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_PCNSR)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_PCNSR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.title_Invalid := Fields.InValid_title((SALT311.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_score_Invalid := Fields.InValid_name_score((SALT311.StrType)le.name_score);
    SELF.fname_orig_Invalid := Fields.InValid_fname_orig((SALT311.StrType)le.fname_orig);
    SELF.mname_orig_Invalid := Fields.InValid_mname_orig((SALT311.StrType)le.mname_orig);
    SELF.lname_orig_Invalid := Fields.InValid_lname_orig((SALT311.StrType)le.lname_orig);
    SELF.name_suffix_orig_Invalid := Fields.InValid_name_suffix_orig((SALT311.StrType)le.name_suffix_orig);
    SELF.title_orig_Invalid := Fields.InValid_title_orig((SALT311.StrType)le.title_orig);
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
    SELF.hhid_Invalid := Fields.InValid_hhid((SALT311.StrType)le.hhid);
    SELF.did_Invalid := Fields.InValid_did((SALT311.StrType)le.did);
    SELF.did_score_Invalid := Fields.InValid_did_score((SALT311.StrType)le.did_score);
    SELF.phone_fordid_Invalid := Fields.InValid_phone_fordid((SALT311.StrType)le.phone_fordid);
    SELF.gender_Invalid := Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT311.StrType)le.date_of_birth);
    SELF.address_type_Invalid := Fields.InValid_address_type((SALT311.StrType)le.address_type);
    SELF.demographic_level_indicator_Invalid := Fields.InValid_demographic_level_indicator((SALT311.StrType)le.demographic_level_indicator);
    SELF.length_of_residence_Invalid := Fields.InValid_length_of_residence((SALT311.StrType)le.length_of_residence);
    SELF.location_type_Invalid := Fields.InValid_location_type((SALT311.StrType)le.location_type);
    SELF.dqi2_occupancy_count_Invalid := Fields.InValid_dqi2_occupancy_count((SALT311.StrType)le.dqi2_occupancy_count);
    SELF.delivery_unit_size_Invalid := Fields.InValid_delivery_unit_size((SALT311.StrType)le.delivery_unit_size);
    SELF.household_arrival_date_Invalid := Fields.InValid_household_arrival_date((SALT311.StrType)le.household_arrival_date);
    SELF.area_code_Invalid := Fields.InValid_area_code((SALT311.StrType)le.area_code);
    SELF.phone_number_Invalid := Fields.InValid_phone_number((SALT311.StrType)le.phone_number);
    SELF.telephone_number_type_Invalid := Fields.InValid_telephone_number_type((SALT311.StrType)le.telephone_number_type);
    SELF.phone2_number_Invalid := Fields.InValid_phone2_number((SALT311.StrType)le.phone2_number);
    SELF.telephone2_number_type_Invalid := Fields.InValid_telephone2_number_type((SALT311.StrType)le.telephone2_number_type);
    SELF.time_zone_Invalid := Fields.InValid_time_zone((SALT311.StrType)le.time_zone);
    SELF.refresh_date_Invalid := Fields.InValid_refresh_date((SALT311.StrType)le.refresh_date);
    SELF.name_address_verification_source_Invalid := Fields.InValid_name_address_verification_source((SALT311.StrType)le.name_address_verification_source);
    SELF.drop_indicator_Invalid := Fields.InValid_drop_indicator((SALT311.StrType)le.drop_indicator);
    SELF.do_not_mail_flag_Invalid := Fields.InValid_do_not_mail_flag((SALT311.StrType)le.do_not_mail_flag);
    SELF.do_not_call_flag_Invalid := Fields.InValid_do_not_call_flag((SALT311.StrType)le.do_not_call_flag);
    SELF.business_file_hit_flag_Invalid := Fields.InValid_business_file_hit_flag((SALT311.StrType)le.business_file_hit_flag);
    SELF.spouse_title_Invalid := Fields.InValid_spouse_title((SALT311.StrType)le.spouse_title);
    SELF.spouse_fname_Invalid := Fields.InValid_spouse_fname((SALT311.StrType)le.spouse_fname);
    SELF.spouse_mname_Invalid := Fields.InValid_spouse_mname((SALT311.StrType)le.spouse_mname);
    SELF.spouse_lname_Invalid := Fields.InValid_spouse_lname((SALT311.StrType)le.spouse_lname);
    SELF.spouse_name_suffix_Invalid := Fields.InValid_spouse_name_suffix((SALT311.StrType)le.spouse_name_suffix);
    SELF.spouse_fname_orig_Invalid := Fields.InValid_spouse_fname_orig((SALT311.StrType)le.spouse_fname_orig);
    SELF.spouse_mname_orig_Invalid := Fields.InValid_spouse_mname_orig((SALT311.StrType)le.spouse_mname_orig);
    SELF.spouse_lname_orig_Invalid := Fields.InValid_spouse_lname_orig((SALT311.StrType)le.spouse_lname_orig);
    SELF.spouse_name_suffix_orig_Invalid := Fields.InValid_spouse_name_suffix_orig((SALT311.StrType)le.spouse_name_suffix_orig);
    SELF.spouse_title_orig_Invalid := Fields.InValid_spouse_title_orig((SALT311.StrType)le.spouse_title_orig);
    SELF.spouse_date_of_birth_Invalid := Fields.InValid_spouse_date_of_birth((SALT311.StrType)le.spouse_date_of_birth);
    SELF.find_income_in_1000s_Invalid := Fields.InValid_find_income_in_1000s((SALT311.StrType)le.find_income_in_1000s);
    SELF.phhincomeunder25k_Invalid := Fields.InValid_phhincomeunder25k((SALT311.StrType)le.phhincomeunder25k);
    SELF.phhincome50kplus_Invalid := Fields.InValid_phhincome50kplus((SALT311.StrType)le.phhincome50kplus);
    SELF.phhincome200kplus_Invalid := Fields.InValid_phhincome200kplus((SALT311.StrType)le.phhincome200kplus);
    SELF.medianhhincome_Invalid := Fields.InValid_medianhhincome((SALT311.StrType)le.medianhhincome);
    SELF.own_rent_Invalid := Fields.InValid_own_rent((SALT311.StrType)le.own_rent);
    SELF.homeowner_source_code_Invalid := Fields.InValid_homeowner_source_code((SALT311.StrType)le.homeowner_source_code);
    SELF.telephone_acquisition_date_Invalid := Fields.InValid_telephone_acquisition_date((SALT311.StrType)le.telephone_acquisition_date);
    SELF.recency_date_Invalid := Fields.InValid_recency_date((SALT311.StrType)le.recency_date);
    SELF.source_Invalid := Fields.InValid_source((SALT311.StrType)le.source);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_PCNSR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.title_Invalid << 0 ) + ( le.fname_Invalid << 1 ) + ( le.mname_Invalid << 2 ) + ( le.lname_Invalid << 3 ) + ( le.name_score_Invalid << 4 ) + ( le.fname_orig_Invalid << 5 ) + ( le.mname_orig_Invalid << 6 ) + ( le.lname_orig_Invalid << 7 ) + ( le.name_suffix_orig_Invalid << 8 ) + ( le.title_orig_Invalid << 9 ) + ( le.st_Invalid << 10 ) + ( le.zip_Invalid << 11 ) + ( le.zip4_Invalid << 12 ) + ( le.cart_Invalid << 13 ) + ( le.cr_sort_sz_Invalid << 14 ) + ( le.lot_Invalid << 15 ) + ( le.lot_order_Invalid << 16 ) + ( le.dbpc_Invalid << 17 ) + ( le.chk_digit_Invalid << 18 ) + ( le.rec_type_Invalid << 19 ) + ( le.county_Invalid << 20 ) + ( le.geo_lat_Invalid << 21 ) + ( le.geo_long_Invalid << 22 ) + ( le.msa_Invalid << 23 ) + ( le.geo_blk_Invalid << 24 ) + ( le.geo_match_Invalid << 25 ) + ( le.err_stat_Invalid << 26 ) + ( le.hhid_Invalid << 27 ) + ( le.did_Invalid << 28 ) + ( le.did_score_Invalid << 29 ) + ( le.phone_fordid_Invalid << 30 ) + ( le.gender_Invalid << 31 ) + ( le.date_of_birth_Invalid << 32 ) + ( le.address_type_Invalid << 33 ) + ( le.demographic_level_indicator_Invalid << 34 ) + ( le.length_of_residence_Invalid << 35 ) + ( le.location_type_Invalid << 36 ) + ( le.dqi2_occupancy_count_Invalid << 37 ) + ( le.delivery_unit_size_Invalid << 38 ) + ( le.household_arrival_date_Invalid << 39 ) + ( le.area_code_Invalid << 40 ) + ( le.phone_number_Invalid << 41 ) + ( le.telephone_number_type_Invalid << 42 ) + ( le.phone2_number_Invalid << 43 ) + ( le.telephone2_number_type_Invalid << 44 ) + ( le.time_zone_Invalid << 45 ) + ( le.refresh_date_Invalid << 46 ) + ( le.name_address_verification_source_Invalid << 47 ) + ( le.drop_indicator_Invalid << 48 ) + ( le.do_not_mail_flag_Invalid << 49 ) + ( le.do_not_call_flag_Invalid << 50 ) + ( le.business_file_hit_flag_Invalid << 51 ) + ( le.spouse_title_Invalid << 52 ) + ( le.spouse_fname_Invalid << 53 ) + ( le.spouse_mname_Invalid << 54 ) + ( le.spouse_lname_Invalid << 55 ) + ( le.spouse_name_suffix_Invalid << 56 ) + ( le.spouse_fname_orig_Invalid << 57 ) + ( le.spouse_mname_orig_Invalid << 58 ) + ( le.spouse_lname_orig_Invalid << 59 ) + ( le.spouse_name_suffix_orig_Invalid << 60 ) + ( le.spouse_title_orig_Invalid << 61 ) + ( le.spouse_date_of_birth_Invalid << 62 ) + ( le.find_income_in_1000s_Invalid << 63 );
    SELF.ScrubsBits2 := ( le.phhincomeunder25k_Invalid << 0 ) + ( le.phhincome50kplus_Invalid << 1 ) + ( le.phhincome200kplus_Invalid << 2 ) + ( le.medianhhincome_Invalid << 3 ) + ( le.own_rent_Invalid << 4 ) + ( le.homeowner_source_code_Invalid << 5 ) + ( le.telephone_acquisition_date_Invalid << 6 ) + ( le.recency_date_Invalid << 7 ) + ( le.source_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_PCNSR);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.title_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.name_score_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.fname_orig_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.mname_orig_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.lname_orig_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.name_suffix_orig_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.title_orig_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.dbpc_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.hhid_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.phone_fordid_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.date_of_birth_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.address_type_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.demographic_level_indicator_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.length_of_residence_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.location_type_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.dqi2_occupancy_count_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.delivery_unit_size_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.household_arrival_date_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.area_code_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.telephone_number_type_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF.phone2_number_Invalid := (le.ScrubsBits1 >> 43) & 1;
    SELF.telephone2_number_type_Invalid := (le.ScrubsBits1 >> 44) & 1;
    SELF.time_zone_Invalid := (le.ScrubsBits1 >> 45) & 1;
    SELF.refresh_date_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.name_address_verification_source_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.drop_indicator_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.do_not_mail_flag_Invalid := (le.ScrubsBits1 >> 49) & 1;
    SELF.do_not_call_flag_Invalid := (le.ScrubsBits1 >> 50) & 1;
    SELF.business_file_hit_flag_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.spouse_title_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.spouse_fname_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.spouse_mname_Invalid := (le.ScrubsBits1 >> 54) & 1;
    SELF.spouse_lname_Invalid := (le.ScrubsBits1 >> 55) & 1;
    SELF.spouse_name_suffix_Invalid := (le.ScrubsBits1 >> 56) & 1;
    SELF.spouse_fname_orig_Invalid := (le.ScrubsBits1 >> 57) & 1;
    SELF.spouse_mname_orig_Invalid := (le.ScrubsBits1 >> 58) & 1;
    SELF.spouse_lname_orig_Invalid := (le.ScrubsBits1 >> 59) & 1;
    SELF.spouse_name_suffix_orig_Invalid := (le.ScrubsBits1 >> 60) & 1;
    SELF.spouse_title_orig_Invalid := (le.ScrubsBits1 >> 61) & 1;
    SELF.spouse_date_of_birth_Invalid := (le.ScrubsBits1 >> 62) & 1;
    SELF.find_income_in_1000s_Invalid := (le.ScrubsBits1 >> 63) & 1;
    SELF.phhincomeunder25k_Invalid := (le.ScrubsBits2 >> 0) & 1;
    SELF.phhincome50kplus_Invalid := (le.ScrubsBits2 >> 1) & 1;
    SELF.phhincome200kplus_Invalid := (le.ScrubsBits2 >> 2) & 1;
    SELF.medianhhincome_Invalid := (le.ScrubsBits2 >> 3) & 1;
    SELF.own_rent_Invalid := (le.ScrubsBits2 >> 4) & 1;
    SELF.homeowner_source_code_Invalid := (le.ScrubsBits2 >> 5) & 1;
    SELF.telephone_acquisition_date_Invalid := (le.ScrubsBits2 >> 6) & 1;
    SELF.recency_date_Invalid := (le.ScrubsBits2 >> 7) & 1;
    SELF.source_Invalid := (le.ScrubsBits2 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
    fname_orig_ALLOW_ErrorCount := COUNT(GROUP,h.fname_orig_Invalid=1);
    mname_orig_ALLOW_ErrorCount := COUNT(GROUP,h.mname_orig_Invalid=1);
    lname_orig_ALLOW_ErrorCount := COUNT(GROUP,h.lname_orig_Invalid=1);
    name_suffix_orig_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_orig_Invalid=1);
    title_orig_ALLOW_ErrorCount := COUNT(GROUP,h.title_orig_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ENUM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
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
    hhid_ALLOW_ErrorCount := COUNT(GROUP,h.hhid_Invalid=1);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    phone_fordid_ALLOW_ErrorCount := COUNT(GROUP,h.phone_fordid_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    date_of_birth_ALLOW_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    address_type_ALLOW_ErrorCount := COUNT(GROUP,h.address_type_Invalid=1);
    demographic_level_indicator_ENUM_ErrorCount := COUNT(GROUP,h.demographic_level_indicator_Invalid=1);
    length_of_residence_ALLOW_ErrorCount := COUNT(GROUP,h.length_of_residence_Invalid=1);
    location_type_ENUM_ErrorCount := COUNT(GROUP,h.location_type_Invalid=1);
    dqi2_occupancy_count_ALLOW_ErrorCount := COUNT(GROUP,h.dqi2_occupancy_count_Invalid=1);
    delivery_unit_size_ALLOW_ErrorCount := COUNT(GROUP,h.delivery_unit_size_Invalid=1);
    household_arrival_date_ALLOW_ErrorCount := COUNT(GROUP,h.household_arrival_date_Invalid=1);
    area_code_ALLOW_ErrorCount := COUNT(GROUP,h.area_code_Invalid=1);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    telephone_number_type_ENUM_ErrorCount := COUNT(GROUP,h.telephone_number_type_Invalid=1);
    phone2_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone2_number_Invalid=1);
    telephone2_number_type_ENUM_ErrorCount := COUNT(GROUP,h.telephone2_number_type_Invalid=1);
    time_zone_ENUM_ErrorCount := COUNT(GROUP,h.time_zone_Invalid=1);
    refresh_date_ALLOW_ErrorCount := COUNT(GROUP,h.refresh_date_Invalid=1);
    name_address_verification_source_ENUM_ErrorCount := COUNT(GROUP,h.name_address_verification_source_Invalid=1);
    drop_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.drop_indicator_Invalid=1);
    do_not_mail_flag_ALLOW_ErrorCount := COUNT(GROUP,h.do_not_mail_flag_Invalid=1);
    do_not_call_flag_ALLOW_ErrorCount := COUNT(GROUP,h.do_not_call_flag_Invalid=1);
    business_file_hit_flag_ENUM_ErrorCount := COUNT(GROUP,h.business_file_hit_flag_Invalid=1);
    spouse_title_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_title_Invalid=1);
    spouse_fname_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_fname_Invalid=1);
    spouse_mname_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_mname_Invalid=1);
    spouse_lname_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_lname_Invalid=1);
    spouse_name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_name_suffix_Invalid=1);
    spouse_fname_orig_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_fname_orig_Invalid=1);
    spouse_mname_orig_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_mname_orig_Invalid=1);
    spouse_lname_orig_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_lname_orig_Invalid=1);
    spouse_name_suffix_orig_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_name_suffix_orig_Invalid=1);
    spouse_title_orig_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_title_orig_Invalid=1);
    spouse_date_of_birth_ALLOW_ErrorCount := COUNT(GROUP,h.spouse_date_of_birth_Invalid=1);
    find_income_in_1000s_ALLOW_ErrorCount := COUNT(GROUP,h.find_income_in_1000s_Invalid=1);
    phhincomeunder25k_ALLOW_ErrorCount := COUNT(GROUP,h.phhincomeunder25k_Invalid=1);
    phhincome50kplus_ALLOW_ErrorCount := COUNT(GROUP,h.phhincome50kplus_Invalid=1);
    phhincome200kplus_ALLOW_ErrorCount := COUNT(GROUP,h.phhincome200kplus_Invalid=1);
    medianhhincome_ALLOW_ErrorCount := COUNT(GROUP,h.medianhhincome_Invalid=1);
    own_rent_ALLOW_ErrorCount := COUNT(GROUP,h.own_rent_Invalid=1);
    homeowner_source_code_ENUM_ErrorCount := COUNT(GROUP,h.homeowner_source_code_Invalid=1);
    telephone_acquisition_date_ALLOW_ErrorCount := COUNT(GROUP,h.telephone_acquisition_date_Invalid=1);
    recency_date_ALLOW_ErrorCount := COUNT(GROUP,h.recency_date_Invalid=1);
    source_ENUM_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_score_Invalid > 0 OR h.fname_orig_Invalid > 0 OR h.mname_orig_Invalid > 0 OR h.lname_orig_Invalid > 0 OR h.name_suffix_orig_Invalid > 0 OR h.title_orig_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dbpc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.county_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.msa_Invalid > 0 OR h.geo_blk_Invalid > 0 OR h.geo_match_Invalid > 0 OR h.err_stat_Invalid > 0 OR h.hhid_Invalid > 0 OR h.did_Invalid > 0 OR h.did_score_Invalid > 0 OR h.phone_fordid_Invalid > 0 OR h.gender_Invalid > 0 OR h.date_of_birth_Invalid > 0 OR h.address_type_Invalid > 0 OR h.demographic_level_indicator_Invalid > 0 OR h.length_of_residence_Invalid > 0 OR h.location_type_Invalid > 0 OR h.dqi2_occupancy_count_Invalid > 0 OR h.delivery_unit_size_Invalid > 0 OR h.household_arrival_date_Invalid > 0 OR h.area_code_Invalid > 0 OR h.phone_number_Invalid > 0 OR h.telephone_number_type_Invalid > 0 OR h.phone2_number_Invalid > 0 OR h.telephone2_number_type_Invalid > 0 OR h.time_zone_Invalid > 0 OR h.refresh_date_Invalid > 0 OR h.name_address_verification_source_Invalid > 0 OR h.drop_indicator_Invalid > 0 OR h.do_not_mail_flag_Invalid > 0 OR h.do_not_call_flag_Invalid > 0 OR h.business_file_hit_flag_Invalid > 0 OR h.spouse_title_Invalid > 0 OR h.spouse_fname_Invalid > 0 OR h.spouse_mname_Invalid > 0 OR h.spouse_lname_Invalid > 0 OR h.spouse_name_suffix_Invalid > 0 OR h.spouse_fname_orig_Invalid > 0 OR h.spouse_mname_orig_Invalid > 0 OR h.spouse_lname_orig_Invalid > 0 OR h.spouse_name_suffix_orig_Invalid > 0 OR h.spouse_title_orig_Invalid > 0 OR h.spouse_date_of_birth_Invalid > 0 OR h.find_income_in_1000s_Invalid > 0 OR h.phhincomeunder25k_Invalid > 0 OR h.phhincome50kplus_Invalid > 0 OR h.phhincome200kplus_Invalid > 0 OR h.medianhhincome_Invalid > 0 OR h.own_rent_Invalid > 0 OR h.homeowner_source_code_Invalid > 0 OR h.telephone_acquisition_date_Invalid > 0 OR h.recency_date_Invalid > 0 OR h.source_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hhid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_fordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.demographic_level_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.length_of_residence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.location_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.dqi2_occupancy_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.delivery_unit_size_ALLOW_ErrorCount > 0, 1, 0) + IF(le.household_arrival_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.area_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone_number_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone2_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone2_number_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.time_zone_ENUM_ErrorCount > 0, 1, 0) + IF(le.refresh_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_address_verification_source_ENUM_ErrorCount > 0, 1, 0) + IF(le.drop_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.do_not_mail_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.do_not_call_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.business_file_hit_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.spouse_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_fname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_mname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_lname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_name_suffix_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_title_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_date_of_birth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.find_income_in_1000s_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phhincomeunder25k_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phhincome50kplus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phhincome200kplus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.medianhhincome_ALLOW_ErrorCount > 0, 1, 0) + IF(le.own_rent_ALLOW_ErrorCount > 0, 1, 0) + IF(le.homeowner_source_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.telephone_acquisition_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recency_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dbpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_lat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_long_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_blk_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0) + IF(le.err_stat_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hhid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_fordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.demographic_level_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.length_of_residence_ALLOW_ErrorCount > 0, 1, 0) + IF(le.location_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.dqi2_occupancy_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.delivery_unit_size_ALLOW_ErrorCount > 0, 1, 0) + IF(le.household_arrival_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.area_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone_number_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone2_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.telephone2_number_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.time_zone_ENUM_ErrorCount > 0, 1, 0) + IF(le.refresh_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_address_verification_source_ENUM_ErrorCount > 0, 1, 0) + IF(le.drop_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.do_not_mail_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.do_not_call_flag_ALLOW_ErrorCount > 0, 1, 0) + IF(le.business_file_hit_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.spouse_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_fname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_mname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_lname_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_name_suffix_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_title_orig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spouse_date_of_birth_ALLOW_ErrorCount > 0, 1, 0) + IF(le.find_income_in_1000s_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phhincomeunder25k_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phhincome50kplus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phhincome200kplus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.medianhhincome_ALLOW_ErrorCount > 0, 1, 0) + IF(le.own_rent_ALLOW_ErrorCount > 0, 1, 0) + IF(le.homeowner_source_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.telephone_acquisition_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.recency_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_score_Invalid,le.fname_orig_Invalid,le.mname_orig_Invalid,le.lname_orig_Invalid,le.name_suffix_orig_Invalid,le.title_orig_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dbpc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,le.hhid_Invalid,le.did_Invalid,le.did_score_Invalid,le.phone_fordid_Invalid,le.gender_Invalid,le.date_of_birth_Invalid,le.address_type_Invalid,le.demographic_level_indicator_Invalid,le.length_of_residence_Invalid,le.location_type_Invalid,le.dqi2_occupancy_count_Invalid,le.delivery_unit_size_Invalid,le.household_arrival_date_Invalid,le.area_code_Invalid,le.phone_number_Invalid,le.telephone_number_type_Invalid,le.phone2_number_Invalid,le.telephone2_number_type_Invalid,le.time_zone_Invalid,le.refresh_date_Invalid,le.name_address_verification_source_Invalid,le.drop_indicator_Invalid,le.do_not_mail_flag_Invalid,le.do_not_call_flag_Invalid,le.business_file_hit_flag_Invalid,le.spouse_title_Invalid,le.spouse_fname_Invalid,le.spouse_mname_Invalid,le.spouse_lname_Invalid,le.spouse_name_suffix_Invalid,le.spouse_fname_orig_Invalid,le.spouse_mname_orig_Invalid,le.spouse_lname_orig_Invalid,le.spouse_name_suffix_orig_Invalid,le.spouse_title_orig_Invalid,le.spouse_date_of_birth_Invalid,le.find_income_in_1000s_Invalid,le.phhincomeunder25k_Invalid,le.phhincome50kplus_Invalid,le.phhincome200kplus_Invalid,le.medianhhincome_Invalid,le.own_rent_Invalid,le.homeowner_source_code_Invalid,le.telephone_acquisition_date_Invalid,le.recency_date_Invalid,le.source_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_fname_orig(le.fname_orig_Invalid),Fields.InvalidMessage_mname_orig(le.mname_orig_Invalid),Fields.InvalidMessage_lname_orig(le.lname_orig_Invalid),Fields.InvalidMessage_name_suffix_orig(le.name_suffix_orig_Invalid),Fields.InvalidMessage_title_orig(le.title_orig_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dbpc(le.dbpc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),Fields.InvalidMessage_hhid(le.hhid_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_did_score(le.did_score_Invalid),Fields.InvalidMessage_phone_fordid(le.phone_fordid_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_address_type(le.address_type_Invalid),Fields.InvalidMessage_demographic_level_indicator(le.demographic_level_indicator_Invalid),Fields.InvalidMessage_length_of_residence(le.length_of_residence_Invalid),Fields.InvalidMessage_location_type(le.location_type_Invalid),Fields.InvalidMessage_dqi2_occupancy_count(le.dqi2_occupancy_count_Invalid),Fields.InvalidMessage_delivery_unit_size(le.delivery_unit_size_Invalid),Fields.InvalidMessage_household_arrival_date(le.household_arrival_date_Invalid),Fields.InvalidMessage_area_code(le.area_code_Invalid),Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Fields.InvalidMessage_telephone_number_type(le.telephone_number_type_Invalid),Fields.InvalidMessage_phone2_number(le.phone2_number_Invalid),Fields.InvalidMessage_telephone2_number_type(le.telephone2_number_type_Invalid),Fields.InvalidMessage_time_zone(le.time_zone_Invalid),Fields.InvalidMessage_refresh_date(le.refresh_date_Invalid),Fields.InvalidMessage_name_address_verification_source(le.name_address_verification_source_Invalid),Fields.InvalidMessage_drop_indicator(le.drop_indicator_Invalid),Fields.InvalidMessage_do_not_mail_flag(le.do_not_mail_flag_Invalid),Fields.InvalidMessage_do_not_call_flag(le.do_not_call_flag_Invalid),Fields.InvalidMessage_business_file_hit_flag(le.business_file_hit_flag_Invalid),Fields.InvalidMessage_spouse_title(le.spouse_title_Invalid),Fields.InvalidMessage_spouse_fname(le.spouse_fname_Invalid),Fields.InvalidMessage_spouse_mname(le.spouse_mname_Invalid),Fields.InvalidMessage_spouse_lname(le.spouse_lname_Invalid),Fields.InvalidMessage_spouse_name_suffix(le.spouse_name_suffix_Invalid),Fields.InvalidMessage_spouse_fname_orig(le.spouse_fname_orig_Invalid),Fields.InvalidMessage_spouse_mname_orig(le.spouse_mname_orig_Invalid),Fields.InvalidMessage_spouse_lname_orig(le.spouse_lname_orig_Invalid),Fields.InvalidMessage_spouse_name_suffix_orig(le.spouse_name_suffix_orig_Invalid),Fields.InvalidMessage_spouse_title_orig(le.spouse_title_orig_Invalid),Fields.InvalidMessage_spouse_date_of_birth(le.spouse_date_of_birth_Invalid),Fields.InvalidMessage_find_income_in_1000s(le.find_income_in_1000s_Invalid),Fields.InvalidMessage_phhincomeunder25k(le.phhincomeunder25k_Invalid),Fields.InvalidMessage_phhincome50kplus(le.phhincome50kplus_Invalid),Fields.InvalidMessage_phhincome200kplus(le.phhincome200kplus_Invalid),Fields.InvalidMessage_medianhhincome(le.medianhhincome_Invalid),Fields.InvalidMessage_own_rent(le.own_rent_Invalid),Fields.InvalidMessage_homeowner_source_code(le.homeowner_source_code_Invalid),Fields.InvalidMessage_telephone_acquisition_date(le.telephone_acquisition_date_Invalid),Fields.InvalidMessage_recency_date(le.recency_date_Invalid),Fields.InvalidMessage_source(le.source_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ENUM','UNKNOWN')
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
          ,CHOOSE(le.hhid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_fordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.demographic_level_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.length_of_residence_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.location_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dqi2_occupancy_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.delivery_unit_size_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.household_arrival_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.area_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.telephone_number_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone2_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.telephone2_number_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.time_zone_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.refresh_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_address_verification_source_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.drop_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.do_not_mail_flag_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.do_not_call_flag_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.business_file_hit_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.spouse_title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_fname_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_mname_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_lname_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_name_suffix_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_title_orig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spouse_date_of_birth_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.find_income_in_1000s_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phhincomeunder25k_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phhincome50kplus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phhincome200kplus_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.medianhhincome_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.own_rent_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.homeowner_source_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.telephone_acquisition_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.recency_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'title','fname','mname','lname','name_score','fname_orig','mname_orig','lname_orig','name_suffix_orig','title_orig','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dbpc','chk_digit','rec_type','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','hhid','did','did_score','phone_fordid','gender','date_of_birth','address_type','demographic_level_indicator','length_of_residence','location_type','dqi2_occupancy_count','delivery_unit_size','household_arrival_date','area_code','phone_number','telephone_number_type','phone2_number','telephone2_number_type','time_zone','refresh_date','name_address_verification_source','drop_indicator','do_not_mail_flag','do_not_call_flag','business_file_hit_flag','spouse_title','spouse_fname','spouse_mname','spouse_lname','spouse_name_suffix','spouse_fname_orig','spouse_mname_orig','spouse_lname_orig','spouse_name_suffix_orig','spouse_title_orig','spouse_date_of_birth','find_income_in_1000s','phhincomeunder25k','phhincome50kplus','phhincome200kplus','medianhhincome','own_rent','homeowner_source_code','telephone_acquisition_date','recency_date','source','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_CRSORT','Invalid_Num','Invalid_LotOrder','Invalid_Num','Invalid_Num','Invalid_RecType','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Gender','Invalid_Num','Invalid_Num','Invalid_DemographicIndicator','Invalid_Num','Invalid_LocationType','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_TelephoneNumberType','Invalid_Num','Invalid_TelephoneNumberType','Invalid_TimeZone','Invalid_Num','Invalid_YN','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_YN','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_HomeownerCode','Invalid_Num','Invalid_Num','Invalid_Source','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_score,(SALT311.StrType)le.fname_orig,(SALT311.StrType)le.mname_orig,(SALT311.StrType)le.lname_orig,(SALT311.StrType)le.name_suffix_orig,(SALT311.StrType)le.title_orig,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dbpc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.county,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.msa,(SALT311.StrType)le.geo_blk,(SALT311.StrType)le.geo_match,(SALT311.StrType)le.err_stat,(SALT311.StrType)le.hhid,(SALT311.StrType)le.did,(SALT311.StrType)le.did_score,(SALT311.StrType)le.phone_fordid,(SALT311.StrType)le.gender,(SALT311.StrType)le.date_of_birth,(SALT311.StrType)le.address_type,(SALT311.StrType)le.demographic_level_indicator,(SALT311.StrType)le.length_of_residence,(SALT311.StrType)le.location_type,(SALT311.StrType)le.dqi2_occupancy_count,(SALT311.StrType)le.delivery_unit_size,(SALT311.StrType)le.household_arrival_date,(SALT311.StrType)le.area_code,(SALT311.StrType)le.phone_number,(SALT311.StrType)le.telephone_number_type,(SALT311.StrType)le.phone2_number,(SALT311.StrType)le.telephone2_number_type,(SALT311.StrType)le.time_zone,(SALT311.StrType)le.refresh_date,(SALT311.StrType)le.name_address_verification_source,(SALT311.StrType)le.drop_indicator,(SALT311.StrType)le.do_not_mail_flag,(SALT311.StrType)le.do_not_call_flag,(SALT311.StrType)le.business_file_hit_flag,(SALT311.StrType)le.spouse_title,(SALT311.StrType)le.spouse_fname,(SALT311.StrType)le.spouse_mname,(SALT311.StrType)le.spouse_lname,(SALT311.StrType)le.spouse_name_suffix,(SALT311.StrType)le.spouse_fname_orig,(SALT311.StrType)le.spouse_mname_orig,(SALT311.StrType)le.spouse_lname_orig,(SALT311.StrType)le.spouse_name_suffix_orig,(SALT311.StrType)le.spouse_title_orig,(SALT311.StrType)le.spouse_date_of_birth,(SALT311.StrType)le.find_income_in_1000s,(SALT311.StrType)le.phhincomeunder25k,(SALT311.StrType)le.phhincome50kplus,(SALT311.StrType)le.phhincome200kplus,(SALT311.StrType)le.medianhhincome,(SALT311.StrType)le.own_rent,(SALT311.StrType)le.homeowner_source_code,(SALT311.StrType)le.telephone_acquisition_date,(SALT311.StrType)le.recency_date,(SALT311.StrType)le.source,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,73,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_PCNSR) prevDS = DATASET([], Layout_PCNSR), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'title:Invalid_Char:ALLOW'
          ,'fname:Invalid_Char:ALLOW'
          ,'mname:Invalid_Char:ALLOW'
          ,'lname:Invalid_Char:ALLOW'
          ,'name_score:Invalid_Char:ALLOW'
          ,'fname_orig:Invalid_Char:ALLOW'
          ,'mname_orig:Invalid_Char:ALLOW'
          ,'lname_orig:Invalid_Char:ALLOW'
          ,'name_suffix_orig:Invalid_Char:ALLOW'
          ,'title_orig:Invalid_Char:ALLOW'
          ,'st:Invalid_Char:ALLOW'
          ,'zip:Invalid_Num:ALLOW'
          ,'zip4:Invalid_Num:ALLOW'
          ,'cart:Invalid_Char:ALLOW'
          ,'cr_sort_sz:Invalid_CRSORT:ENUM'
          ,'lot:Invalid_Num:ALLOW'
          ,'lot_order:Invalid_LotOrder:ENUM'
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
          ,'hhid:Invalid_Num:ALLOW'
          ,'did:Invalid_Num:ALLOW'
          ,'did_score:Invalid_Num:ALLOW'
          ,'phone_fordid:Invalid_Num:ALLOW'
          ,'gender:Invalid_Gender:ENUM'
          ,'date_of_birth:Invalid_Num:ALLOW'
          ,'address_type:Invalid_Num:ALLOW'
          ,'demographic_level_indicator:Invalid_DemographicIndicator:ENUM'
          ,'length_of_residence:Invalid_Num:ALLOW'
          ,'location_type:Invalid_LocationType:ENUM'
          ,'dqi2_occupancy_count:Invalid_Num:ALLOW'
          ,'delivery_unit_size:Invalid_Num:ALLOW'
          ,'household_arrival_date:Invalid_Num:ALLOW'
          ,'area_code:Invalid_Num:ALLOW'
          ,'phone_number:Invalid_Num:ALLOW'
          ,'telephone_number_type:Invalid_TelephoneNumberType:ENUM'
          ,'phone2_number:Invalid_Num:ALLOW'
          ,'telephone2_number_type:Invalid_TelephoneNumberType:ENUM'
          ,'time_zone:Invalid_TimeZone:ENUM'
          ,'refresh_date:Invalid_Num:ALLOW'
          ,'name_address_verification_source:Invalid_YN:ENUM'
          ,'drop_indicator:Invalid_Num:ALLOW'
          ,'do_not_mail_flag:Invalid_Num:ALLOW'
          ,'do_not_call_flag:Invalid_Num:ALLOW'
          ,'business_file_hit_flag:Invalid_YN:ENUM'
          ,'spouse_title:Invalid_Char:ALLOW'
          ,'spouse_fname:Invalid_Char:ALLOW'
          ,'spouse_mname:Invalid_Char:ALLOW'
          ,'spouse_lname:Invalid_Char:ALLOW'
          ,'spouse_name_suffix:Invalid_Char:ALLOW'
          ,'spouse_fname_orig:Invalid_Char:ALLOW'
          ,'spouse_mname_orig:Invalid_Char:ALLOW'
          ,'spouse_lname_orig:Invalid_Char:ALLOW'
          ,'spouse_name_suffix_orig:Invalid_Char:ALLOW'
          ,'spouse_title_orig:Invalid_Char:ALLOW'
          ,'spouse_date_of_birth:Invalid_Num:ALLOW'
          ,'find_income_in_1000s:Invalid_Num:ALLOW'
          ,'phhincomeunder25k:Invalid_Num:ALLOW'
          ,'phhincome50kplus:Invalid_Num:ALLOW'
          ,'phhincome200kplus:Invalid_Num:ALLOW'
          ,'medianhhincome:Invalid_Num:ALLOW'
          ,'own_rent:Invalid_Num:ALLOW'
          ,'homeowner_source_code:Invalid_HomeownerCode:ENUM'
          ,'telephone_acquisition_date:Invalid_Num:ALLOW'
          ,'recency_date:Invalid_Num:ALLOW'
          ,'source:Invalid_Source:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_title(1)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_name_score(1)
          ,Fields.InvalidMessage_fname_orig(1)
          ,Fields.InvalidMessage_mname_orig(1)
          ,Fields.InvalidMessage_lname_orig(1)
          ,Fields.InvalidMessage_name_suffix_orig(1)
          ,Fields.InvalidMessage_title_orig(1)
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
          ,Fields.InvalidMessage_hhid(1)
          ,Fields.InvalidMessage_did(1)
          ,Fields.InvalidMessage_did_score(1)
          ,Fields.InvalidMessage_phone_fordid(1)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_date_of_birth(1)
          ,Fields.InvalidMessage_address_type(1)
          ,Fields.InvalidMessage_demographic_level_indicator(1)
          ,Fields.InvalidMessage_length_of_residence(1)
          ,Fields.InvalidMessage_location_type(1)
          ,Fields.InvalidMessage_dqi2_occupancy_count(1)
          ,Fields.InvalidMessage_delivery_unit_size(1)
          ,Fields.InvalidMessage_household_arrival_date(1)
          ,Fields.InvalidMessage_area_code(1)
          ,Fields.InvalidMessage_phone_number(1)
          ,Fields.InvalidMessage_telephone_number_type(1)
          ,Fields.InvalidMessage_phone2_number(1)
          ,Fields.InvalidMessage_telephone2_number_type(1)
          ,Fields.InvalidMessage_time_zone(1)
          ,Fields.InvalidMessage_refresh_date(1)
          ,Fields.InvalidMessage_name_address_verification_source(1)
          ,Fields.InvalidMessage_drop_indicator(1)
          ,Fields.InvalidMessage_do_not_mail_flag(1)
          ,Fields.InvalidMessage_do_not_call_flag(1)
          ,Fields.InvalidMessage_business_file_hit_flag(1)
          ,Fields.InvalidMessage_spouse_title(1)
          ,Fields.InvalidMessage_spouse_fname(1)
          ,Fields.InvalidMessage_spouse_mname(1)
          ,Fields.InvalidMessage_spouse_lname(1)
          ,Fields.InvalidMessage_spouse_name_suffix(1)
          ,Fields.InvalidMessage_spouse_fname_orig(1)
          ,Fields.InvalidMessage_spouse_mname_orig(1)
          ,Fields.InvalidMessage_spouse_lname_orig(1)
          ,Fields.InvalidMessage_spouse_name_suffix_orig(1)
          ,Fields.InvalidMessage_spouse_title_orig(1)
          ,Fields.InvalidMessage_spouse_date_of_birth(1)
          ,Fields.InvalidMessage_find_income_in_1000s(1)
          ,Fields.InvalidMessage_phhincomeunder25k(1)
          ,Fields.InvalidMessage_phhincome50kplus(1)
          ,Fields.InvalidMessage_phhincome200kplus(1)
          ,Fields.InvalidMessage_medianhhincome(1)
          ,Fields.InvalidMessage_own_rent(1)
          ,Fields.InvalidMessage_homeowner_source_code(1)
          ,Fields.InvalidMessage_telephone_acquisition_date(1)
          ,Fields.InvalidMessage_recency_date(1)
          ,Fields.InvalidMessage_source(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
          ,le.fname_orig_ALLOW_ErrorCount
          ,le.mname_orig_ALLOW_ErrorCount
          ,le.lname_orig_ALLOW_ErrorCount
          ,le.name_suffix_orig_ALLOW_ErrorCount
          ,le.title_orig_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
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
          ,le.hhid_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.phone_fordid_ALLOW_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.date_of_birth_ALLOW_ErrorCount
          ,le.address_type_ALLOW_ErrorCount
          ,le.demographic_level_indicator_ENUM_ErrorCount
          ,le.length_of_residence_ALLOW_ErrorCount
          ,le.location_type_ENUM_ErrorCount
          ,le.dqi2_occupancy_count_ALLOW_ErrorCount
          ,le.delivery_unit_size_ALLOW_ErrorCount
          ,le.household_arrival_date_ALLOW_ErrorCount
          ,le.area_code_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.telephone_number_type_ENUM_ErrorCount
          ,le.phone2_number_ALLOW_ErrorCount
          ,le.telephone2_number_type_ENUM_ErrorCount
          ,le.time_zone_ENUM_ErrorCount
          ,le.refresh_date_ALLOW_ErrorCount
          ,le.name_address_verification_source_ENUM_ErrorCount
          ,le.drop_indicator_ALLOW_ErrorCount
          ,le.do_not_mail_flag_ALLOW_ErrorCount
          ,le.do_not_call_flag_ALLOW_ErrorCount
          ,le.business_file_hit_flag_ENUM_ErrorCount
          ,le.spouse_title_ALLOW_ErrorCount
          ,le.spouse_fname_ALLOW_ErrorCount
          ,le.spouse_mname_ALLOW_ErrorCount
          ,le.spouse_lname_ALLOW_ErrorCount
          ,le.spouse_name_suffix_ALLOW_ErrorCount
          ,le.spouse_fname_orig_ALLOW_ErrorCount
          ,le.spouse_mname_orig_ALLOW_ErrorCount
          ,le.spouse_lname_orig_ALLOW_ErrorCount
          ,le.spouse_name_suffix_orig_ALLOW_ErrorCount
          ,le.spouse_title_orig_ALLOW_ErrorCount
          ,le.spouse_date_of_birth_ALLOW_ErrorCount
          ,le.find_income_in_1000s_ALLOW_ErrorCount
          ,le.phhincomeunder25k_ALLOW_ErrorCount
          ,le.phhincome50kplus_ALLOW_ErrorCount
          ,le.phhincome200kplus_ALLOW_ErrorCount
          ,le.medianhhincome_ALLOW_ErrorCount
          ,le.own_rent_ALLOW_ErrorCount
          ,le.homeowner_source_code_ENUM_ErrorCount
          ,le.telephone_acquisition_date_ALLOW_ErrorCount
          ,le.recency_date_ALLOW_ErrorCount
          ,le.source_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.title_ALLOW_ErrorCount
          ,le.fname_ALLOW_ErrorCount
          ,le.mname_ALLOW_ErrorCount
          ,le.lname_ALLOW_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
          ,le.fname_orig_ALLOW_ErrorCount
          ,le.mname_orig_ALLOW_ErrorCount
          ,le.lname_orig_ALLOW_ErrorCount
          ,le.name_suffix_orig_ALLOW_ErrorCount
          ,le.title_orig_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
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
          ,le.hhid_ALLOW_ErrorCount
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.phone_fordid_ALLOW_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.date_of_birth_ALLOW_ErrorCount
          ,le.address_type_ALLOW_ErrorCount
          ,le.demographic_level_indicator_ENUM_ErrorCount
          ,le.length_of_residence_ALLOW_ErrorCount
          ,le.location_type_ENUM_ErrorCount
          ,le.dqi2_occupancy_count_ALLOW_ErrorCount
          ,le.delivery_unit_size_ALLOW_ErrorCount
          ,le.household_arrival_date_ALLOW_ErrorCount
          ,le.area_code_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.telephone_number_type_ENUM_ErrorCount
          ,le.phone2_number_ALLOW_ErrorCount
          ,le.telephone2_number_type_ENUM_ErrorCount
          ,le.time_zone_ENUM_ErrorCount
          ,le.refresh_date_ALLOW_ErrorCount
          ,le.name_address_verification_source_ENUM_ErrorCount
          ,le.drop_indicator_ALLOW_ErrorCount
          ,le.do_not_mail_flag_ALLOW_ErrorCount
          ,le.do_not_call_flag_ALLOW_ErrorCount
          ,le.business_file_hit_flag_ENUM_ErrorCount
          ,le.spouse_title_ALLOW_ErrorCount
          ,le.spouse_fname_ALLOW_ErrorCount
          ,le.spouse_mname_ALLOW_ErrorCount
          ,le.spouse_lname_ALLOW_ErrorCount
          ,le.spouse_name_suffix_ALLOW_ErrorCount
          ,le.spouse_fname_orig_ALLOW_ErrorCount
          ,le.spouse_mname_orig_ALLOW_ErrorCount
          ,le.spouse_lname_orig_ALLOW_ErrorCount
          ,le.spouse_name_suffix_orig_ALLOW_ErrorCount
          ,le.spouse_title_orig_ALLOW_ErrorCount
          ,le.spouse_date_of_birth_ALLOW_ErrorCount
          ,le.find_income_in_1000s_ALLOW_ErrorCount
          ,le.phhincomeunder25k_ALLOW_ErrorCount
          ,le.phhincome50kplus_ALLOW_ErrorCount
          ,le.phhincome200kplus_ALLOW_ErrorCount
          ,le.medianhhincome_ALLOW_ErrorCount
          ,le.own_rent_ALLOW_ErrorCount
          ,le.homeowner_source_code_ENUM_ErrorCount
          ,le.telephone_acquisition_date_ALLOW_ErrorCount
          ,le.recency_date_ALLOW_ErrorCount
          ,le.source_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_PCNSR));
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
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_score:' + getFieldTypeText(h.name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname_orig:' + getFieldTypeText(h.fname_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname_orig:' + getFieldTypeText(h.mname_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname_orig:' + getFieldTypeText(h.lname_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix_orig:' + getFieldTypeText(h.name_suffix_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title_orig:' + getFieldTypeText(h.title_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hhid:' + getFieldTypeText(h.hhid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_fordid:' + getFieldTypeText(h.phone_fordid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_birth:' + getFieldTypeText(h.date_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type:' + getFieldTypeText(h.address_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'demographic_level_indicator:' + getFieldTypeText(h.demographic_level_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'length_of_residence:' + getFieldTypeText(h.length_of_residence) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location_type:' + getFieldTypeText(h.location_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dqi2_occupancy_count:' + getFieldTypeText(h.dqi2_occupancy_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'delivery_unit_size:' + getFieldTypeText(h.delivery_unit_size) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'household_arrival_date:' + getFieldTypeText(h.household_arrival_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'area_code:' + getFieldTypeText(h.area_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone_number_type:' + getFieldTypeText(h.telephone_number_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone2_number:' + getFieldTypeText(h.phone2_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone2_number_type:' + getFieldTypeText(h.telephone2_number_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'time_zone:' + getFieldTypeText(h.time_zone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'refresh_date:' + getFieldTypeText(h.refresh_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_address_verification_source:' + getFieldTypeText(h.name_address_verification_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'drop_indicator:' + getFieldTypeText(h.drop_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'do_not_mail_flag:' + getFieldTypeText(h.do_not_mail_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'do_not_call_flag:' + getFieldTypeText(h.do_not_call_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'business_file_hit_flag:' + getFieldTypeText(h.business_file_hit_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_title:' + getFieldTypeText(h.spouse_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_fname:' + getFieldTypeText(h.spouse_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_mname:' + getFieldTypeText(h.spouse_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_lname:' + getFieldTypeText(h.spouse_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_name_suffix:' + getFieldTypeText(h.spouse_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_fname_orig:' + getFieldTypeText(h.spouse_fname_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_mname_orig:' + getFieldTypeText(h.spouse_mname_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_lname_orig:' + getFieldTypeText(h.spouse_lname_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_name_suffix_orig:' + getFieldTypeText(h.spouse_name_suffix_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_title_orig:' + getFieldTypeText(h.spouse_title_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_gender:' + getFieldTypeText(h.spouse_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_date_of_birth:' + getFieldTypeText(h.spouse_date_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spouse_indicator:' + getFieldTypeText(h.spouse_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'household_income:' + getFieldTypeText(h.household_income) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'find_income_in_1000s:' + getFieldTypeText(h.find_income_in_1000s) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phhincomeunder25k:' + getFieldTypeText(h.phhincomeunder25k) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phhincome50kplus:' + getFieldTypeText(h.phhincome50kplus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phhincome200kplus:' + getFieldTypeText(h.phhincome200kplus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'medianhhincome:' + getFieldTypeText(h.medianhhincome) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'own_rent:' + getFieldTypeText(h.own_rent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'homeowner_source_code:' + getFieldTypeText(h.homeowner_source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'telephone_acquisition_date:' + getFieldTypeText(h.telephone_acquisition_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recency_date:' + getFieldTypeText(h.recency_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
          ,le.populated_fname_orig_cnt
          ,le.populated_mname_orig_cnt
          ,le.populated_lname_orig_cnt
          ,le.populated_name_suffix_orig_cnt
          ,le.populated_title_orig_cnt
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
          ,le.populated_err_stat_cnt
          ,le.populated_hhid_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_phone_fordid_cnt
          ,le.populated_gender_cnt
          ,le.populated_date_of_birth_cnt
          ,le.populated_address_type_cnt
          ,le.populated_demographic_level_indicator_cnt
          ,le.populated_length_of_residence_cnt
          ,le.populated_location_type_cnt
          ,le.populated_dqi2_occupancy_count_cnt
          ,le.populated_delivery_unit_size_cnt
          ,le.populated_household_arrival_date_cnt
          ,le.populated_area_code_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_telephone_number_type_cnt
          ,le.populated_phone2_number_cnt
          ,le.populated_telephone2_number_type_cnt
          ,le.populated_time_zone_cnt
          ,le.populated_refresh_date_cnt
          ,le.populated_name_address_verification_source_cnt
          ,le.populated_drop_indicator_cnt
          ,le.populated_do_not_mail_flag_cnt
          ,le.populated_do_not_call_flag_cnt
          ,le.populated_business_file_hit_flag_cnt
          ,le.populated_spouse_title_cnt
          ,le.populated_spouse_fname_cnt
          ,le.populated_spouse_mname_cnt
          ,le.populated_spouse_lname_cnt
          ,le.populated_spouse_name_suffix_cnt
          ,le.populated_spouse_fname_orig_cnt
          ,le.populated_spouse_mname_orig_cnt
          ,le.populated_spouse_lname_orig_cnt
          ,le.populated_spouse_name_suffix_orig_cnt
          ,le.populated_spouse_title_orig_cnt
          ,le.populated_spouse_gender_cnt
          ,le.populated_spouse_date_of_birth_cnt
          ,le.populated_spouse_indicator_cnt
          ,le.populated_household_income_cnt
          ,le.populated_find_income_in_1000s_cnt
          ,le.populated_phhincomeunder25k_cnt
          ,le.populated_phhincome50kplus_cnt
          ,le.populated_phhincome200kplus_cnt
          ,le.populated_medianhhincome_cnt
          ,le.populated_own_rent_cnt
          ,le.populated_homeowner_source_code_cnt
          ,le.populated_telephone_acquisition_date_cnt
          ,le.populated_recency_date_cnt
          ,le.populated_source_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
          ,le.populated_fname_orig_pcnt
          ,le.populated_mname_orig_pcnt
          ,le.populated_lname_orig_pcnt
          ,le.populated_name_suffix_orig_pcnt
          ,le.populated_title_orig_pcnt
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
          ,le.populated_err_stat_pcnt
          ,le.populated_hhid_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_phone_fordid_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_date_of_birth_pcnt
          ,le.populated_address_type_pcnt
          ,le.populated_demographic_level_indicator_pcnt
          ,le.populated_length_of_residence_pcnt
          ,le.populated_location_type_pcnt
          ,le.populated_dqi2_occupancy_count_pcnt
          ,le.populated_delivery_unit_size_pcnt
          ,le.populated_household_arrival_date_pcnt
          ,le.populated_area_code_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_telephone_number_type_pcnt
          ,le.populated_phone2_number_pcnt
          ,le.populated_telephone2_number_type_pcnt
          ,le.populated_time_zone_pcnt
          ,le.populated_refresh_date_pcnt
          ,le.populated_name_address_verification_source_pcnt
          ,le.populated_drop_indicator_pcnt
          ,le.populated_do_not_mail_flag_pcnt
          ,le.populated_do_not_call_flag_pcnt
          ,le.populated_business_file_hit_flag_pcnt
          ,le.populated_spouse_title_pcnt
          ,le.populated_spouse_fname_pcnt
          ,le.populated_spouse_mname_pcnt
          ,le.populated_spouse_lname_pcnt
          ,le.populated_spouse_name_suffix_pcnt
          ,le.populated_spouse_fname_orig_pcnt
          ,le.populated_spouse_mname_orig_pcnt
          ,le.populated_spouse_lname_orig_pcnt
          ,le.populated_spouse_name_suffix_orig_pcnt
          ,le.populated_spouse_title_orig_pcnt
          ,le.populated_spouse_gender_pcnt
          ,le.populated_spouse_date_of_birth_pcnt
          ,le.populated_spouse_indicator_pcnt
          ,le.populated_household_income_pcnt
          ,le.populated_find_income_in_1000s_pcnt
          ,le.populated_phhincomeunder25k_pcnt
          ,le.populated_phhincome50kplus_pcnt
          ,le.populated_phhincome200kplus_pcnt
          ,le.populated_medianhhincome_pcnt
          ,le.populated_own_rent_pcnt
          ,le.populated_homeowner_source_code_pcnt
          ,le.populated_telephone_acquisition_date_pcnt
          ,le.populated_recency_date_pcnt
          ,le.populated_source_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,86,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_PCNSR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),86,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_PCNSR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PCNSR, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
