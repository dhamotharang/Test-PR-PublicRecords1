IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_NC; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_NC)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 customer_id_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 licensetype_Invalid;
    UNSIGNED1 issuedate_Invalid;
    UNSIGNED1 expiration_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 cleaning_score_Invalid;
    UNSIGNED1 prim_range_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 st_Invalid;
    UNSIGNED1 zip5_Invalid;
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
  EXPORT  Bitmap_Layout := RECORD(Layout_In_NC)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_NC) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT35.StrType)le.process_date);
    SELF.customer_id_Invalid := Fields.InValid_customer_id((SALT35.StrType)le.customer_id);
    SELF.license_number_Invalid := Fields.InValid_license_number((SALT35.StrType)le.license_number);
    SELF.lastname_Invalid := Fields.InValid_lastname((SALT35.StrType)le.lastname,(SALT35.StrType)le.firstname,(SALT35.StrType)le.middlename);
    SELF.city_Invalid := Fields.InValid_city((SALT35.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT35.StrType)le.state);
    SELF.zip_Invalid := Fields.InValid_zip((SALT35.StrType)le.zip);
    SELF.dob_Invalid := Fields.InValid_dob((SALT35.StrType)le.dob);
    SELF.licensetype_Invalid := Fields.InValid_licensetype((SALT35.StrType)le.licensetype);
    SELF.issuedate_Invalid := Fields.InValid_issuedate((SALT35.StrType)le.issuedate);
    SELF.expiration_Invalid := Fields.InValid_expiration((SALT35.StrType)le.expiration);
    SELF.status_Invalid := Fields.InValid_status((SALT35.StrType)le.status);
    SELF.lname_Invalid := Fields.InValid_lname((SALT35.StrType)le.lname,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname);
    SELF.cleaning_score_Invalid := Fields.InValid_cleaning_score((SALT35.StrType)le.cleaning_score);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT35.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT35.StrType)le.predir);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT35.StrType)le.postdir);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT35.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT35.StrType)le.st);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT35.StrType)le.zip5);
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
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_NC);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.customer_id_Invalid << 2 ) + ( le.license_number_Invalid << 4 ) + ( le.lastname_Invalid << 6 ) + ( le.city_Invalid << 8 ) + ( le.state_Invalid << 9 ) + ( le.zip_Invalid << 11 ) + ( le.dob_Invalid << 13 ) + ( le.licensetype_Invalid << 15 ) + ( le.issuedate_Invalid << 16 ) + ( le.expiration_Invalid << 18 ) + ( le.status_Invalid << 20 ) + ( le.lname_Invalid << 21 ) + ( le.cleaning_score_Invalid << 23 ) + ( le.prim_range_Invalid << 24 ) + ( le.predir_Invalid << 25 ) + ( le.postdir_Invalid << 26 ) + ( le.p_city_name_Invalid << 27 ) + ( le.v_city_name_Invalid << 28 ) + ( le.st_Invalid << 29 ) + ( le.zip5_Invalid << 31 ) + ( le.zip4_Invalid << 33 ) + ( le.cart_Invalid << 35 ) + ( le.cr_sort_sz_Invalid << 37 ) + ( le.lot_Invalid << 38 ) + ( le.lot_order_Invalid << 40 ) + ( le.dpbc_Invalid << 42 ) + ( le.chk_digit_Invalid << 44 ) + ( le.rec_type_Invalid << 46 ) + ( le.ace_fips_st_Invalid << 48 ) + ( le.county_Invalid << 50 ) + ( le.geo_lat_Invalid << 52 ) + ( le.geo_long_Invalid << 53 ) + ( le.msa_Invalid << 54 ) + ( le.geo_blk_Invalid << 56 ) + ( le.geo_match_Invalid << 58 ) + ( le.err_stat_Invalid << 60 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_NC);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.customer_id_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.licensetype_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.issuedate_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.expiration_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.status_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.cleaning_score_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.dpbc_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.county_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 52) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 53) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 60) & 3;
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
    customer_id_CAPS_ErrorCount := COUNT(GROUP,h.customer_id_Invalid=1);
    customer_id_ALLOW_ErrorCount := COUNT(GROUP,h.customer_id_Invalid=2);
    customer_id_Total_ErrorCount := COUNT(GROUP,h.customer_id_Invalid>0);
    license_number_ALLOW_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    license_number_LENGTH_ErrorCount := COUNT(GROUP,h.license_number_Invalid=2);
    license_number_Total_ErrorCount := COUNT(GROUP,h.license_number_Invalid>0);
    lastname_CAPS_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    lastname_ALLOW_ErrorCount := COUNT(GROUP,h.lastname_Invalid=2);
    lastname_CUSTOM_ErrorCount := COUNT(GROUP,h.lastname_Invalid=3);
    lastname_Total_ErrorCount := COUNT(GROUP,h.lastname_Invalid>0);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    licensetype_CUSTOM_ErrorCount := COUNT(GROUP,h.licensetype_Invalid=1);
    issuedate_CUSTOM_ErrorCount := COUNT(GROUP,h.issuedate_Invalid=1);
    issuedate_LENGTH_ErrorCount := COUNT(GROUP,h.issuedate_Invalid=2);
    issuedate_Total_ErrorCount := COUNT(GROUP,h.issuedate_Invalid>0);
    expiration_CUSTOM_ErrorCount := COUNT(GROUP,h.expiration_Invalid=1);
    expiration_LENGTH_ErrorCount := COUNT(GROUP,h.expiration_Invalid=2);
    expiration_Total_ErrorCount := COUNT(GROUP,h.expiration_Invalid>0);
    status_CUSTOM_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    cleaning_score_ALLOW_ErrorCount := COUNT(GROUP,h.cleaning_score_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_LENGTH_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
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
    rec_type_LENGTH_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=2);
    rec_type_Total_ErrorCount := COUNT(GROUP,h.rec_type_Invalid>0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.customer_id_Invalid,le.license_number_Invalid,le.lastname_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.dob_Invalid,le.licensetype_Invalid,le.issuedate_Invalid,le.expiration_Invalid,le.status_Invalid,le.lname_Invalid,le.cleaning_score_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.postdir_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.ace_fips_st_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_customer_id(le.customer_id_Invalid),Fields.InvalidMessage_license_number(le.license_number_Invalid),Fields.InvalidMessage_lastname(le.lastname_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_licensetype(le.licensetype_Invalid),Fields.InvalidMessage_issuedate(le.issuedate_Invalid),Fields.InvalidMessage_expiration(le.expiration_Invalid),Fields.InvalidMessage_status(le.status_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_cleaning_score(le.cleaning_score_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.customer_id_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'CAPS','ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.licensetype_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.issuedate_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.expiration_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.cleaning_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dpbc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_blk_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.err_stat_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','customer_id','license_number','lastname','city','state','zip','dob','licensetype','issuedate','expiration','status','lname','cleaning_score','prim_range','predir','postdir','p_city_name','v_city_name','st','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_wordbag','invalid_license_number','invalid_name','invalid_alpha_num_specials','invalid_state','invalid_zip','invalid_8pastdate','invalid_licensetype','invalid_8pastdate','invalid_8generaldate','invalid_status','invalid_clean_name','invalid_numeric','invalid_alpha_num_specials','invalid_direction','invalid_direction','invalid_alpha_num_specials','invalid_alpha_num_specials','invalid_state','invalid_zip5','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.process_date,(SALT35.StrType)le.customer_id,(SALT35.StrType)le.license_number,(SALT35.StrType)le.lastname,(SALT35.StrType)le.city,(SALT35.StrType)le.state,(SALT35.StrType)le.zip,(SALT35.StrType)le.dob,(SALT35.StrType)le.licensetype,(SALT35.StrType)le.issuedate,(SALT35.StrType)le.expiration,(SALT35.StrType)le.status,(SALT35.StrType)le.lname,(SALT35.StrType)le.cleaning_score,(SALT35.StrType)le.prim_range,(SALT35.StrType)le.predir,(SALT35.StrType)le.postdir,(SALT35.StrType)le.p_city_name,(SALT35.StrType)le.v_city_name,(SALT35.StrType)le.st,(SALT35.StrType)le.zip5,(SALT35.StrType)le.zip4,(SALT35.StrType)le.cart,(SALT35.StrType)le.cr_sort_sz,(SALT35.StrType)le.lot,(SALT35.StrType)le.lot_order,(SALT35.StrType)le.dpbc,(SALT35.StrType)le.chk_digit,(SALT35.StrType)le.rec_type,(SALT35.StrType)le.ace_fips_st,(SALT35.StrType)le.county,(SALT35.StrType)le.geo_lat,(SALT35.StrType)le.geo_long,(SALT35.StrType)le.msa,(SALT35.StrType)le.geo_blk,(SALT35.StrType)le.geo_match,(SALT35.StrType)le.err_stat,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,37,Into(LEFT,COUNTER));
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
          ,'customer_id:invalid_wordbag:CAPS','customer_id:invalid_wordbag:ALLOW'
          ,'license_number:invalid_license_number:ALLOW','license_number:invalid_license_number:LENGTH'
          ,'lastname:invalid_name:CAPS','lastname:invalid_name:ALLOW','lastname:invalid_name:CUSTOM'
          ,'city:invalid_alpha_num_specials:ALLOW'
          ,'state:invalid_state:ALLOW','state:invalid_state:LENGTH'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTH'
          ,'dob:invalid_8pastdate:CUSTOM','dob:invalid_8pastdate:LENGTH'
          ,'licensetype:invalid_licensetype:CUSTOM'
          ,'issuedate:invalid_8pastdate:CUSTOM','issuedate:invalid_8pastdate:LENGTH'
          ,'expiration:invalid_8generaldate:CUSTOM','expiration:invalid_8generaldate:LENGTH'
          ,'status:invalid_status:CUSTOM'
          ,'lname:invalid_clean_name:CAPS','lname:invalid_clean_name:ALLOW','lname:invalid_clean_name:CUSTOM'
          ,'cleaning_score:invalid_numeric:ALLOW'
          ,'prim_range:invalid_alpha_num_specials:ALLOW'
          ,'predir:invalid_direction:ALLOW'
          ,'postdir:invalid_direction:ALLOW'
          ,'p_city_name:invalid_alpha_num_specials:ALLOW'
          ,'v_city_name:invalid_alpha_num_specials:ALLOW'
          ,'st:invalid_state:ALLOW','st:invalid_state:LENGTH'
          ,'zip5:invalid_zip5:ALLOW','zip5:invalid_zip5:LENGTH'
          ,'zip4:invalid_zip4:ALLOW','zip4:invalid_zip4:LENGTH'
          ,'cart:invalid_cart:ALLOW','cart:invalid_cart:LENGTH'
          ,'cr_sort_sz:invalid_cr_sort_sz:ENUM'
          ,'lot:invalid_lot:ALLOW','lot:invalid_lot:LENGTH'
          ,'lot_order:invalid_lot_order:ALLOW','lot_order:invalid_lot_order:LENGTH'
          ,'dpbc:invalid_dpbc:ALLOW','dpbc:invalid_dpbc:LENGTH'
          ,'chk_digit:invalid_chk_digit:ALLOW','chk_digit:invalid_chk_digit:LENGTH'
          ,'rec_type:invalid_record_type:CUSTOM','rec_type:invalid_record_type:LENGTH'
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
          ,Fields.InvalidMessage_customer_id(1),Fields.InvalidMessage_customer_id(2)
          ,Fields.InvalidMessage_license_number(1),Fields.InvalidMessage_license_number(2)
          ,Fields.InvalidMessage_lastname(1),Fields.InvalidMessage_lastname(2),Fields.InvalidMessage_lastname(3)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2)
          ,Fields.InvalidMessage_licensetype(1)
          ,Fields.InvalidMessage_issuedate(1),Fields.InvalidMessage_issuedate(2)
          ,Fields.InvalidMessage_expiration(1),Fields.InvalidMessage_expiration(2)
          ,Fields.InvalidMessage_status(1)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3)
          ,Fields.InvalidMessage_cleaning_score(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip5(1),Fields.InvalidMessage_zip5(2)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2)
          ,Fields.InvalidMessage_cart(1),Fields.InvalidMessage_cart(2)
          ,Fields.InvalidMessage_cr_sort_sz(1)
          ,Fields.InvalidMessage_lot(1),Fields.InvalidMessage_lot(2)
          ,Fields.InvalidMessage_lot_order(1),Fields.InvalidMessage_lot_order(2)
          ,Fields.InvalidMessage_dpbc(1),Fields.InvalidMessage_dpbc(2)
          ,Fields.InvalidMessage_chk_digit(1),Fields.InvalidMessage_chk_digit(2)
          ,Fields.InvalidMessage_rec_type(1),Fields.InvalidMessage_rec_type(2)
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
          ,le.customer_id_CAPS_ErrorCount,le.customer_id_ALLOW_ErrorCount
          ,le.license_number_ALLOW_ErrorCount,le.license_number_LENGTH_ErrorCount
          ,le.lastname_CAPS_ErrorCount,le.lastname_ALLOW_ErrorCount,le.lastname_CUSTOM_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.licensetype_CUSTOM_ErrorCount
          ,le.issuedate_CUSTOM_ErrorCount,le.issuedate_LENGTH_ErrorCount
          ,le.expiration_CUSTOM_ErrorCount,le.expiration_LENGTH_ErrorCount
          ,le.status_CUSTOM_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_CUSTOM_ErrorCount
          ,le.cleaning_score_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount,le.dpbc_LENGTH_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount,le.rec_type_LENGTH_ErrorCount
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
          ,le.customer_id_CAPS_ErrorCount,le.customer_id_ALLOW_ErrorCount
          ,le.license_number_ALLOW_ErrorCount,le.license_number_LENGTH_ErrorCount
          ,le.lastname_CAPS_ErrorCount,le.lastname_ALLOW_ErrorCount,le.lastname_CUSTOM_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.licensetype_CUSTOM_ErrorCount
          ,le.issuedate_CUSTOM_ErrorCount,le.issuedate_LENGTH_ErrorCount
          ,le.expiration_CUSTOM_ErrorCount,le.expiration_LENGTH_ErrorCount
          ,le.status_CUSTOM_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_CUSTOM_ErrorCount
          ,le.cleaning_score_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.cart_ALLOW_ErrorCount,le.cart_LENGTH_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_ALLOW_ErrorCount,le.lot_LENGTH_ErrorCount
          ,le.lot_order_ALLOW_ErrorCount,le.lot_order_LENGTH_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount,le.dpbc_LENGTH_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount,le.chk_digit_LENGTH_ErrorCount
          ,le.rec_type_CUSTOM_ErrorCount,le.rec_type_LENGTH_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount,le.ace_fips_st_LENGTH_ErrorCount
          ,le.county_ALLOW_ErrorCount,le.county_LENGTH_ErrorCount
          ,le.geo_lat_ALLOW_ErrorCount
          ,le.geo_long_ALLOW_ErrorCount
          ,le.msa_ALLOW_ErrorCount,le.msa_LENGTH_ErrorCount
          ,le.geo_blk_ALLOW_ErrorCount,le.geo_blk_LENGTH_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount,le.geo_match_LENGTH_ErrorCount
          ,le.err_stat_ALLOW_ErrorCount,le.err_stat_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,64,Into(LEFT,COUNTER));
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
