IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_NE; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_NE)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 dln_Invalid;
    UNSIGNED1 name_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 address_street_Invalid;
    UNSIGNED1 address_city_Invalid;
    UNSIGNED1 address_state_Invalid;
    UNSIGNED1 address_zip5_Invalid;
    UNSIGNED1 address_zip4_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 height_Invalid;
    UNSIGNED1 weight_Invalid;
    UNSIGNED1 eye_color_Invalid;
    UNSIGNED1 hair_color_Invalid;
    UNSIGNED1 license_type_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 cleaning_score_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 cart_Invalid;
    UNSIGNED1 cr_sort_sz_Invalid;
    UNSIGNED1 lot_Invalid;
    UNSIGNED1 lot_order_Invalid;
    UNSIGNED1 dpbc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 ace_fips_st_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 geo_blk_Invalid;
    UNSIGNED1 geo_match_Invalid;
    UNSIGNED1 err_stat_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_NE)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_NE) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT35.StrType)le.process_date);
    SELF.dln_Invalid := Fields.InValid_dln((SALT35.StrType)le.dln);
    SELF.name_Invalid := Fields.InValid_name((SALT35.StrType)le.name);
    SELF.dob_Invalid := Fields.InValid_dob((SALT35.StrType)le.dob);
    SELF.address_street_Invalid := Fields.InValid_address_street((SALT35.StrType)le.address_street);
    SELF.address_city_Invalid := Fields.InValid_address_city((SALT35.StrType)le.address_city);
    SELF.address_state_Invalid := Fields.InValid_address_state((SALT35.StrType)le.address_state);
    SELF.address_zip5_Invalid := Fields.InValid_address_zip5((SALT35.StrType)le.address_zip5);
    SELF.address_zip4_Invalid := Fields.InValid_address_zip4((SALT35.StrType)le.address_zip4);
    SELF.gender_Invalid := Fields.InValid_gender((SALT35.StrType)le.gender);
    SELF.height_Invalid := Fields.InValid_height((SALT35.StrType)le.height);
    SELF.weight_Invalid := Fields.InValid_weight((SALT35.StrType)le.weight);
    SELF.eye_color_Invalid := Fields.InValid_eye_color((SALT35.StrType)le.eye_color);
    SELF.hair_color_Invalid := Fields.InValid_hair_color((SALT35.StrType)le.hair_color);
    SELF.license_type_Invalid := Fields.InValid_license_type((SALT35.StrType)le.license_type);
    SELF.lname_Invalid := Fields.InValid_lname((SALT35.StrType)le.lname,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname);
    SELF.cleaning_score_Invalid := Fields.InValid_cleaning_score((SALT35.StrType)le.cleaning_score);
    SELF.predir_Invalid := Fields.InValid_predir((SALT35.StrType)le.predir);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT35.StrType)le.suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT35.StrType)le.postdir);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT35.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name);
    SELF.state_Invalid := Fields.InValid_state((SALT35.StrType)le.state);
    SELF.zip_Invalid := Fields.InValid_zip((SALT35.StrType)le.zip);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT35.StrType)le.zip4);
    SELF.cart_Invalid := Fields.InValid_cart((SALT35.StrType)le.cart);
    SELF.cr_sort_sz_Invalid := Fields.InValid_cr_sort_sz((SALT35.StrType)le.cr_sort_sz);
    SELF.lot_Invalid := Fields.InValid_lot((SALT35.StrType)le.lot);
    SELF.lot_order_Invalid := Fields.InValid_lot_order((SALT35.StrType)le.lot_order);
    SELF.dpbc_Invalid := Fields.InValid_dpbc((SALT35.StrType)le.dpbc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT35.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT35.StrType)le.rec_type);
    SELF.ace_fips_st_Invalid := Fields.InValid_ace_fips_st((SALT35.StrType)le.ace_fips_st);
    SELF.county_Invalid := Fields.InValid_county((SALT35.StrType)le.county);
    SELF.geo_lat_Invalid := Fields.InValid_geo_lat((SALT35.StrType)le.geo_lat);
    SELF.geo_long_Invalid := Fields.InValid_geo_long((SALT35.StrType)le.geo_long);
    SELF.msa_Invalid := Fields.InValid_msa((SALT35.StrType)le.msa);
    SELF.geo_blk_Invalid := Fields.InValid_geo_blk((SALT35.StrType)le.geo_blk);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT35.StrType)le.geo_match);
    SELF.err_stat_Invalid := Fields.InValid_err_stat((SALT35.StrType)le.err_stat);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_NE);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.dln_Invalid << 2 ) + ( le.name_Invalid << 4 ) + ( le.dob_Invalid << 5 ) + ( le.address_street_Invalid << 7 ) + ( le.address_city_Invalid << 8 ) + ( le.address_state_Invalid << 9 ) + ( le.address_zip5_Invalid << 10 ) + ( le.address_zip4_Invalid << 12 ) + ( le.gender_Invalid << 14 ) + ( le.height_Invalid << 15 ) + ( le.weight_Invalid << 17 ) + ( le.eye_color_Invalid << 19 ) + ( le.hair_color_Invalid << 20 ) + ( le.license_type_Invalid << 21 ) + ( le.lname_Invalid << 22 ) + ( le.cleaning_score_Invalid << 24 ) + ( le.predir_Invalid << 25 ) + ( le.suffix_Invalid << 26 ) + ( le.postdir_Invalid << 27 ) + ( le.p_city_name_Invalid << 28 ) + ( le.v_city_name_Invalid << 29 ) + ( le.state_Invalid << 30 ) + ( le.zip_Invalid << 31 ) + ( le.zip4_Invalid << 33 ) + ( le.cart_Invalid << 35 ) + ( le.cr_sort_sz_Invalid << 37 ) + ( le.lot_Invalid << 38 ) + ( le.lot_order_Invalid << 40 ) + ( le.dpbc_Invalid << 42 ) + ( le.chk_digit_Invalid << 44 ) + ( le.rec_type_Invalid << 46 ) + ( le.ace_fips_st_Invalid << 47 ) + ( le.county_Invalid << 49 ) + ( le.geo_lat_Invalid << 51 ) + ( le.geo_long_Invalid << 52 ) + ( le.msa_Invalid << 53 ) + ( le.geo_blk_Invalid << 55 ) + ( le.geo_match_Invalid << 57 ) + ( le.err_stat_Invalid << 59 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_NE);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dln_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.address_street_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.address_city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.address_state_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.address_zip5_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.address_zip4_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.height_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.weight_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.eye_color_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.hair_color_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.license_type_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.cleaning_score_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.dpbc_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 46) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits1 >> 47) & 3;
    SELF.county_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 51) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 55) & 3;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 57) & 3;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 59) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    dln_CUSTOM_ErrorCount := COUNT(GROUP,h.dln_Invalid=1);
    dln_LENGTH_ErrorCount := COUNT(GROUP,h.dln_Invalid=2);
    dln_Total_ErrorCount := COUNT(GROUP,h.dln_Invalid>0);
    name_LENGTH_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    address_street_LENGTH_ErrorCount := COUNT(GROUP,h.address_street_Invalid=1);
    address_city_LENGTH_ErrorCount := COUNT(GROUP,h.address_city_Invalid=1);
    address_state_CUSTOM_ErrorCount := COUNT(GROUP,h.address_state_Invalid=1);
    address_zip5_ALLOW_ErrorCount := COUNT(GROUP,h.address_zip5_Invalid=1);
    address_zip5_LENGTH_ErrorCount := COUNT(GROUP,h.address_zip5_Invalid=2);
    address_zip5_Total_ErrorCount := COUNT(GROUP,h.address_zip5_Invalid>0);
    address_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.address_zip4_Invalid=1);
    address_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.address_zip4_Invalid=2);
    address_zip4_Total_ErrorCount := COUNT(GROUP,h.address_zip4_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    height_CUSTOM_ErrorCount := COUNT(GROUP,h.height_Invalid=1);
    height_LENGTH_ErrorCount := COUNT(GROUP,h.height_Invalid=2);
    height_Total_ErrorCount := COUNT(GROUP,h.height_Invalid>0);
    weight_CUSTOM_ErrorCount := COUNT(GROUP,h.weight_Invalid=1);
    weight_LENGTH_ErrorCount := COUNT(GROUP,h.weight_Invalid=2);
    weight_Total_ErrorCount := COUNT(GROUP,h.weight_Invalid>0);
    eye_color_CUSTOM_ErrorCount := COUNT(GROUP,h.eye_color_Invalid=1);
    hair_color_CUSTOM_ErrorCount := COUNT(GROUP,h.hair_color_Invalid=1);
    license_type_CUSTOM_ErrorCount := COUNT(GROUP,h.license_type_Invalid=1);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    cleaning_score_ALLOW_ErrorCount := COUNT(GROUP,h.cleaning_score_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cart_LENGTH_ErrorCount := COUNT(GROUP,h.cart_Invalid=2);
    cart_Total_ErrorCount := COUNT(GROUP,h.cart_Invalid>0);
    cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_LENGTH_ErrorCount := COUNT(GROUP,h.lot_Invalid=2);
    lot_Total_ErrorCount := COUNT(GROUP,h.lot_Invalid>0);
    lot_order_ALLOW_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    lot_order_LENGTH_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=2);
    lot_order_Total_ErrorCount := COUNT(GROUP,h.lot_order_Invalid>0);
    dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=1);
    dpbc_LENGTH_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=2);
    dpbc_Total_ErrorCount := COUNT(GROUP,h.dpbc_Invalid>0);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    chk_digit_LENGTH_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=2);
    chk_digit_Total_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid>0);
    rec_type_CUSTOM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=1);
    ace_fips_st_LENGTH_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=2);
    ace_fips_st_Total_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid>0);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    county_LENGTH_ErrorCount := COUNT(GROUP,h.county_Invalid=2);
    county_Total_ErrorCount := COUNT(GROUP,h.county_Invalid>0);
    geo_lat_ALLOW_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    geo_long_ALLOW_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    msa_ALLOW_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    msa_LENGTH_ErrorCount := COUNT(GROUP,h.msa_Invalid=2);
    msa_Total_ErrorCount := COUNT(GROUP,h.msa_Invalid>0);
    geo_blk_ALLOW_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=1);
    geo_blk_LENGTH_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid=2);
    geo_blk_Total_ErrorCount := COUNT(GROUP,h.geo_blk_Invalid>0);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    geo_match_LENGTH_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=2);
    geo_match_Total_ErrorCount := COUNT(GROUP,h.geo_match_Invalid>0);
    err_stat_ALLOW_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=1);
    err_stat_LENGTH_ErrorCount := COUNT(GROUP,h.err_stat_Invalid=2);
    err_stat_Total_ErrorCount := COUNT(GROUP,h.err_stat_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT35.StrType ErrorMessage;
    SALT35.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.dln_Invalid,le.name_Invalid,le.dob_Invalid,le.address_street_Invalid,le.address_city_Invalid,le.address_state_Invalid,le.address_zip5_Invalid,le.address_zip4_Invalid,le.gender_Invalid,le.height_Invalid,le.weight_Invalid,le.eye_color_Invalid,le.hair_color_Invalid,le.license_type_Invalid,le.lname_Invalid,le.cleaning_score_Invalid,le.predir_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.state_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.ace_fips_st_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_dln(le.dln_Invalid),Fields.InvalidMessage_name(le.name_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_address_street(le.address_street_Invalid),Fields.InvalidMessage_address_city(le.address_city_Invalid),Fields.InvalidMessage_address_state(le.address_state_Invalid),Fields.InvalidMessage_address_zip5(le.address_zip5_Invalid),Fields.InvalidMessage_address_zip4(le.address_zip4_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_height(le.height_Invalid),Fields.InvalidMessage_weight(le.weight_Invalid),Fields.InvalidMessage_eye_color(le.eye_color_Invalid),Fields.InvalidMessage_hair_color(le.hair_color_Invalid),Fields.InvalidMessage_license_type(le.license_type_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_cleaning_score(le.cleaning_score_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dln_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_street_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.address_city_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.address_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_zip5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.height_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.weight_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.eye_color_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.hair_color_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.cleaning_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dpbc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','dln','name','dob','address_street','address_city','address_state','address_zip5','address_zip4','gender','height','weight','eye_color','hair_color','license_type','lname','cleaning_score','predir','suffix','postdir','p_city_name','v_city_name','state','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_dln','invalid_mandatory','invalid_8pastdate','invalid_mandatory','invalid_mandatory','invalid_state','invalid_zip5','invalid_zip4','invalid_gender','invalid_height','invalid_weight','invalid_eye_color','invalid_hair_color','invalid_license_type','invalid_name','invalid_numeric','invalid_direction','invalid_alpha_specials','invalid_direction','invalid_alpha_specials','invalid_alpha_specials','invalid_state','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.process_date,(SALT35.StrType)le.dln,(SALT35.StrType)le.name,(SALT35.StrType)le.dob,(SALT35.StrType)le.address_street,(SALT35.StrType)le.address_city,(SALT35.StrType)le.address_state,(SALT35.StrType)le.address_zip5,(SALT35.StrType)le.address_zip4,(SALT35.StrType)le.gender,(SALT35.StrType)le.height,(SALT35.StrType)le.weight,(SALT35.StrType)le.eye_color,(SALT35.StrType)le.hair_color,(SALT35.StrType)le.license_type,(SALT35.StrType)le.lname,(SALT35.StrType)le.cleaning_score,(SALT35.StrType)le.predir,(SALT35.StrType)le.suffix,(SALT35.StrType)le.postdir,(SALT35.StrType)le.p_city_name,(SALT35.StrType)le.v_city_name,(SALT35.StrType)le.state,(SALT35.StrType)le.zip,(SALT35.StrType)le.zip4,(SALT35.StrType)le.cart,(SALT35.StrType)le.cr_sort_sz,(SALT35.StrType)le.lot,(SALT35.StrType)le.lot_order,(SALT35.StrType)le.dpbc,(SALT35.StrType)le.chk_digit,(SALT35.StrType)le.rec_type,(SALT35.StrType)le.ace_fips_st,(SALT35.StrType)le.county,(SALT35.StrType)le.geo_lat,(SALT35.StrType)le.geo_long,(SALT35.StrType)le.msa,(SALT35.StrType)le.geo_blk,(SALT35.StrType)le.geo_match,(SALT35.StrType)le.err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,40,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT35.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_8pastdate:CUSTOM','process_date:invalid_8pastdate:LENGTH'
          ,'dln:invalid_dln:CUSTOM','dln:invalid_dln:LENGTH'
          ,'name:invalid_mandatory:LENGTH'
          ,'dob:invalid_8pastdate:CUSTOM','dob:invalid_8pastdate:LENGTH'
          ,'address_street:invalid_mandatory:LENGTH'
          ,'address_city:invalid_mandatory:LENGTH'
          ,'address_state:invalid_state:CUSTOM'
          ,'address_zip5:invalid_zip5:ALLOW','address_zip5:invalid_zip5:LENGTH'
          ,'address_zip4:invalid_zip4:ALLOW','address_zip4:invalid_zip4:LENGTH'
          ,'gender:invalid_gender:ENUM'
          ,'height:invalid_height:CUSTOM','height:invalid_height:LENGTH'
          ,'weight:invalid_weight:CUSTOM','weight:invalid_weight:LENGTH'
          ,'eye_color:invalid_eye_color:CUSTOM'
          ,'hair_color:invalid_hair_color:CUSTOM'
          ,'license_type:invalid_license_type:CUSTOM'
          ,'lname:invalid_name:CAPS','lname:invalid_name:ALLOW','lname:invalid_name:CUSTOM'
          ,'cleaning_score:invalid_numeric:ALLOW'
          ,'predir:invalid_direction:ALLOW'
          ,'suffix:invalid_alpha_specials:ALLOW'
          ,'postdir:invalid_direction:ALLOW'
          ,'p_city_name:invalid_alpha_specials:ALLOW'
          ,'v_city_name:invalid_alpha_specials:ALLOW'
          ,'state:invalid_state:CUSTOM'
          ,'zip:invalid_zip5:ALLOW','zip:invalid_zip5:LENGTH'
          ,'zip4:invalid_zip4:ALLOW','zip4:invalid_zip4:LENGTH'
          ,'cart:invalid_cart:ALLOW','cart:invalid_cart:LENGTH'
          ,'cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'lot:invalid_lot:ALLOW','lot:invalid_lot:LENGTH'
          ,'lot_order:invalid_lot_order:ALLOW','lot_order:invalid_lot_order:LENGTH'
          ,'dpbc:invalid_dpbc:ALLOW','dpbc:invalid_dpbc:LENGTH'
          ,'chk_digit:invalid_chk_digit:ALLOW','chk_digit:invalid_chk_digit:LENGTH'
          ,'rec_type:invalid_record_type:CUSTOM'
          ,'ace_fips_st:invalid_ace_fips_st:ALLOW','ace_fips_st:invalid_ace_fips_st:LENGTH'
          ,'county:invalid_fipscounty:ALLOW','county:invalid_fipscounty:LENGTH'
          ,'geo_lat:invalid_geo:ALLOW'
          ,'geo_long:invalid_geo:ALLOW'
          ,'msa:invalid_msa:ALLOW','msa:invalid_msa:LENGTH'
          ,'geo_blk:invalid_geo_blk:ALLOW','geo_blk:invalid_geo_blk:LENGTH'
          ,'geo_match:invalid_geo_match:ALLOW','geo_match:invalid_geo_match:LENGTH'
          ,'err_stat:invalid_err_stat:ALLOW','err_stat:invalid_err_stat:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_dln(1),Fields.InvalidMessage_dln(2)
          ,Fields.InvalidMessage_name(1)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2)
          ,Fields.InvalidMessage_address_street(1)
          ,Fields.InvalidMessage_address_city(1)
          ,Fields.InvalidMessage_address_state(1)
          ,Fields.InvalidMessage_address_zip5(1),Fields.InvalidMessage_address_zip5(2)
          ,Fields.InvalidMessage_address_zip4(1),Fields.InvalidMessage_address_zip4(2)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_height(1),Fields.InvalidMessage_height(2)
          ,Fields.InvalidMessage_weight(1),Fields.InvalidMessage_weight(2)
          ,Fields.InvalidMessage_eye_color(1)
          ,Fields.InvalidMessage_hair_color(1)
          ,Fields.InvalidMessage_license_type(1)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3)
          ,Fields.InvalidMessage_cleaning_score(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_suffix(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_state(1)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2)
          ,Fields.InvalidMessage_cart(1),Fields.InvalidMessage_cart(2)
          ,Fields.InvalidMessage_cr_sort_sz(1)
          ,Fields.InvalidMessage_lot(1),Fields.InvalidMessage_lot(2)
          ,Fields.InvalidMessage_lot_order(1),Fields.InvalidMessage_lot_order(2)
          ,Fields.InvalidMessage_dpbc(1),Fields.InvalidMessage_dpbc(2)
          ,Fields.InvalidMessage_chk_digit(1),Fields.InvalidMessage_chk_digit(2)
          ,Fields.InvalidMessage_rec_type(1)
          ,Fields.InvalidMessage_ace_fips_st(1),Fields.InvalidMessage_ace_fips_st(2)
          ,Fields.InvalidMessage_county(1),Fields.InvalidMessage_county(2)
          ,Fields.InvalidMessage_geo_lat(1)
          ,Fields.InvalidMessage_geo_long(1)
          ,Fields.InvalidMessage_msa(1),Fields.InvalidMessage_msa(2)
          ,Fields.InvalidMessage_geo_blk(1),Fields.InvalidMessage_geo_blk(2)
          ,Fields.InvalidMessage_geo_match(1),Fields.InvalidMessage_geo_match(2)
          ,Fields.InvalidMessage_err_stat(1),Fields.InvalidMessage_err_stat(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.dln_CUSTOM_ErrorCount,le.dln_LENGTH_ErrorCount
          ,le.name_LENGTH_ErrorCount
          ,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.address_street_LENGTH_ErrorCount
          ,le.address_city_LENGTH_ErrorCount
          ,le.address_state_CUSTOM_ErrorCount
          ,le.address_zip5_ALLOW_ErrorCount,le.address_zip5_LENGTH_ErrorCount
          ,le.address_zip4_ALLOW_ErrorCount,le.address_zip4_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.height_CUSTOM_ErrorCount,le.height_LENGTH_ErrorCount
          ,le.weight_CUSTOM_ErrorCount,le.weight_LENGTH_ErrorCount
          ,le.eye_color_CUSTOM_ErrorCount
          ,le.hair_color_CUSTOM_ErrorCount
          ,le.license_type_CUSTOM_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_CUSTOM_ErrorCount
          ,le.cleaning_score_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount,le.dpbc_LENGTH_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount,le.ace_fips_st_LENGTH_ErrorCount
          ,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.dln_CUSTOM_ErrorCount,le.dln_LENGTH_ErrorCount
          ,le.name_LENGTH_ErrorCount
          ,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.address_street_LENGTH_ErrorCount
          ,le.address_city_LENGTH_ErrorCount
          ,le.address_state_CUSTOM_ErrorCount
          ,le.address_zip5_ALLOW_ErrorCount,le.address_zip5_LENGTH_ErrorCount
          ,le.address_zip4_ALLOW_ErrorCount,le.address_zip4_LENGTH_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.height_CUSTOM_ErrorCount,le.height_LENGTH_ErrorCount
          ,le.weight_CUSTOM_ErrorCount,le.weight_LENGTH_ErrorCount
          ,le.eye_color_CUSTOM_ErrorCount
          ,le.hair_color_CUSTOM_ErrorCount
          ,le.license_type_CUSTOM_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_CUSTOM_ErrorCount
          ,le.cleaning_score_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount,le.dpbc_LENGTH_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount,le.ace_fips_st_LENGTH_ErrorCount
          ,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,62,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT35.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT35.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
