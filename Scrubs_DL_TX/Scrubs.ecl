IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_TX; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_TX)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 trans_indicator_Invalid;
    UNSIGNED1 card_type_Invalid;
    UNSIGNED1 dl_number_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 date_of_birth_Invalid;
    UNSIGNED1 street_addr1_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 in_state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 in_zip4_Invalid;
    UNSIGNED1 issue_date_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_score_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 prim_name_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 p_city_name_Invalid;
    UNSIGNED1 v_city_name_Invalid;
    UNSIGNED1 state_Invalid;
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
  EXPORT  Bitmap_Layout := RECORD(Layout_In_TX)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_TX) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT35.StrType)le.process_date);
    SELF.trans_indicator_Invalid := Fields.InValid_trans_indicator((SALT35.StrType)le.trans_indicator);
    SELF.card_type_Invalid := Fields.InValid_card_type((SALT35.StrType)le.card_type);
    SELF.dl_number_Invalid := Fields.InValid_dl_number((SALT35.StrType)le.dl_number);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT35.StrType)le.last_name,(SALT35.StrType)le.first_name,(SALT35.StrType)le.middle_name);
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT35.StrType)le.date_of_birth);
    SELF.street_addr1_Invalid := Fields.InValid_street_addr1((SALT35.StrType)le.street_addr1);
    SELF.city_Invalid := Fields.InValid_city((SALT35.StrType)le.city);
    SELF.in_state_Invalid := Fields.InValid_in_state((SALT35.StrType)le.in_state);
    SELF.zip_Invalid := Fields.InValid_zip((SALT35.StrType)le.zip);
    SELF.in_zip4_Invalid := Fields.InValid_in_zip4((SALT35.StrType)le.in_zip4);
    SELF.issue_date_Invalid := Fields.InValid_issue_date((SALT35.StrType)le.issue_date);
    SELF.lname_Invalid := Fields.InValid_lname((SALT35.StrType)le.lname,(SALT35.StrType)le.fname,(SALT35.StrType)le.mname);
    SELF.name_score_Invalid := Fields.InValid_name_score((SALT35.StrType)le.name_score);
    SELF.predir_Invalid := Fields.InValid_predir((SALT35.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT35.StrType)le.prim_name);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT35.StrType)le.postdir);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT35.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT35.StrType)le.v_city_name);
    SELF.state_Invalid := Fields.InValid_state((SALT35.StrType)le.state);
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
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_TX);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.trans_indicator_Invalid << 2 ) + ( le.card_type_Invalid << 3 ) + ( le.dl_number_Invalid << 4 ) + ( le.last_name_Invalid << 6 ) + ( le.date_of_birth_Invalid << 7 ) + ( le.street_addr1_Invalid << 9 ) + ( le.city_Invalid << 10 ) + ( le.in_state_Invalid << 11 ) + ( le.zip_Invalid << 12 ) + ( le.in_zip4_Invalid << 14 ) + ( le.issue_date_Invalid << 16 ) + ( le.lname_Invalid << 18 ) + ( le.name_score_Invalid << 19 ) + ( le.predir_Invalid << 20 ) + ( le.prim_name_Invalid << 21 ) + ( le.postdir_Invalid << 22 ) + ( le.p_city_name_Invalid << 23 ) + ( le.v_city_name_Invalid << 24 ) + ( le.state_Invalid << 25 ) + ( le.zip5_Invalid << 26 ) + ( le.zip4_Invalid << 28 ) + ( le.cart_Invalid << 30 ) + ( le.cr_sort_sz_Invalid << 32 ) + ( le.lot_Invalid << 33 ) + ( le.lot_order_Invalid << 35 ) + ( le.dpbc_Invalid << 37 ) + ( le.chk_digit_Invalid << 39 ) + ( le.rec_type_Invalid << 41 ) + ( le.ace_fips_st_Invalid << 43 ) + ( le.county_Invalid << 45 ) + ( le.geo_lat_Invalid << 47 ) + ( le.geo_long_Invalid << 48 ) + ( le.msa_Invalid << 49 ) + ( le.geo_blk_Invalid << 51 ) + ( le.geo_match_Invalid << 53 ) + ( le.err_stat_Invalid << 55 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_TX);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.trans_indicator_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.card_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.dl_number_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.date_of_birth_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.street_addr1_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.in_state_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.in_zip4_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.issue_date_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.name_score_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.dpbc_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits1 >> 43) & 3;
    SELF.county_Invalid := (le.ScrubsBits1 >> 45) & 3;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 47) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 48) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 49) & 3;
    SELF.geo_blk_Invalid := (le.ScrubsBits1 >> 51) & 3;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 53) & 3;
    SELF.err_stat_Invalid := (le.ScrubsBits1 >> 55) & 3;
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
    trans_indicator_ENUM_ErrorCount := COUNT(GROUP,h.trans_indicator_Invalid=1);
    card_type_ENUM_ErrorCount := COUNT(GROUP,h.card_type_Invalid=1);
    dl_number_ALLOW_ErrorCount := COUNT(GROUP,h.dl_number_Invalid=1);
    dl_number_LENGTH_ErrorCount := COUNT(GROUP,h.dl_number_Invalid=2);
    dl_number_Total_ErrorCount := COUNT(GROUP,h.dl_number_Invalid>0);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    date_of_birth_CUSTOM_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    date_of_birth_LENGTH_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=2);
    date_of_birth_Total_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid>0);
    street_addr1_LENGTH_ErrorCount := COUNT(GROUP,h.street_addr1_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    in_state_CUSTOM_ErrorCount := COUNT(GROUP,h.in_state_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    in_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.in_zip4_Invalid=1);
    in_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.in_zip4_Invalid=2);
    in_zip4_Total_ErrorCount := COUNT(GROUP,h.in_zip4_Invalid>0);
    issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=1);
    issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.issue_date_Invalid=2);
    issue_date_Total_ErrorCount := COUNT(GROUP,h.issue_date_Invalid>0);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.trans_indicator_Invalid,le.card_type_Invalid,le.dl_number_Invalid,le.last_name_Invalid,le.date_of_birth_Invalid,le.street_addr1_Invalid,le.city_Invalid,le.in_state_Invalid,le.zip_Invalid,le.in_zip4_Invalid,le.issue_date_Invalid,le.lname_Invalid,le.name_score_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.postdir_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.state_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.ace_fips_st_Invalid,le.county_Invalid,le.geo_lat_Invalid,le.geo_long_Invalid,le.msa_Invalid,le.geo_blk_Invalid,le.geo_match_Invalid,le.err_stat_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_trans_indicator(le.trans_indicator_Invalid),Fields.InvalidMessage_card_type(le.card_type_Invalid),Fields.InvalidMessage_dl_number(le.dl_number_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_street_addr1(le.street_addr1_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_in_state(le.in_state_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_in_zip4(le.in_zip4_Invalid),Fields.InvalidMessage_issue_date(le.issue_date_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Fields.InvalidMessage_msa(le.msa_Invalid),Fields.InvalidMessage_geo_blk(le.geo_blk_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),Fields.InvalidMessage_err_stat(le.err_stat_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.trans_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.card_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dl_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.street_addr1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.in_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.in_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.issue_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
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
    SELF.FieldName := CHOOSE(c,'process_date','trans_indicator','card_type','dl_number','last_name','date_of_birth','street_addr1','city','in_state','zip','in_zip4','issue_date','lname','name_score','predir','prim_name','postdir','p_city_name','v_city_name','state','zip5','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','county','geo_lat','geo_long','msa','geo_blk','geo_match','err_stat','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_trans_indicator','invalid_card_type','invalid_dl_number','invalid_name','invalid_past_date','invalid_mandatory','invalid_alpha_num','invalid_state','invalid_zip','invalid_zip4','invalid_date','invalid_name2','invalid_numeric','invalid_direction','invalid_mandatory','invalid_direction','invalid_alpha_num_specials','invalid_alpha_num_specials','invalid_state','invalid_zip','invalid_zip4','invalid_cart','invalid_cr_sort_sz','invalid_lot','invalid_lot_order','invalid_dpbc','invalid_chk_digit','invalid_record_type','invalid_ace_fips_st','invalid_fipscounty','invalid_geo','invalid_geo','invalid_msa','invalid_geo_blk','invalid_geo_match','invalid_err_stat','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.process_date,(SALT35.StrType)le.trans_indicator,(SALT35.StrType)le.card_type,(SALT35.StrType)le.dl_number,(SALT35.StrType)le.last_name,(SALT35.StrType)le.date_of_birth,(SALT35.StrType)le.street_addr1,(SALT35.StrType)le.city,(SALT35.StrType)le.in_state,(SALT35.StrType)le.zip,(SALT35.StrType)le.in_zip4,(SALT35.StrType)le.issue_date,(SALT35.StrType)le.lname,(SALT35.StrType)le.name_score,(SALT35.StrType)le.predir,(SALT35.StrType)le.prim_name,(SALT35.StrType)le.postdir,(SALT35.StrType)le.p_city_name,(SALT35.StrType)le.v_city_name,(SALT35.StrType)le.state,(SALT35.StrType)le.zip5,(SALT35.StrType)le.zip4,(SALT35.StrType)le.cart,(SALT35.StrType)le.cr_sort_sz,(SALT35.StrType)le.lot,(SALT35.StrType)le.lot_order,(SALT35.StrType)le.dpbc,(SALT35.StrType)le.chk_digit,(SALT35.StrType)le.rec_type,(SALT35.StrType)le.ace_fips_st,(SALT35.StrType)le.county,(SALT35.StrType)le.geo_lat,(SALT35.StrType)le.geo_long,(SALT35.StrType)le.msa,(SALT35.StrType)le.geo_blk,(SALT35.StrType)le.geo_match,(SALT35.StrType)le.err_stat,'***SALTBUG***');
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
          ,'trans_indicator:invalid_trans_indicator:ENUM'
          ,'card_type:invalid_card_type:ENUM'
          ,'dl_number:invalid_dl_number:ALLOW','dl_number:invalid_dl_number:LENGTH'
          ,'last_name:invalid_name:CUSTOM'
          ,'date_of_birth:invalid_past_date:CUSTOM','date_of_birth:invalid_past_date:LENGTH'
          ,'street_addr1:invalid_mandatory:LENGTH'
          ,'city:invalid_alpha_num:ALLOW'
          ,'in_state:invalid_state:CUSTOM'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTH'
          ,'in_zip4:invalid_zip4:ALLOW','in_zip4:invalid_zip4:LENGTH'
          ,'issue_date:invalid_date:CUSTOM','issue_date:invalid_date:LENGTH'
          ,'lname:invalid_name2:CUSTOM'
          ,'name_score:invalid_numeric:ALLOW'
          ,'predir:invalid_direction:ALLOW'
          ,'prim_name:invalid_mandatory:LENGTH'
          ,'postdir:invalid_direction:ALLOW'
          ,'p_city_name:invalid_alpha_num_specials:ALLOW'
          ,'v_city_name:invalid_alpha_num_specials:ALLOW'
          ,'state:invalid_state:CUSTOM'
          ,'zip5:invalid_zip:ALLOW','zip5:invalid_zip:LENGTH'
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
          ,Fields.InvalidMessage_trans_indicator(1)
          ,Fields.InvalidMessage_card_type(1)
          ,Fields.InvalidMessage_dl_number(1),Fields.InvalidMessage_dl_number(2)
          ,Fields.InvalidMessage_last_name(1)
          ,Fields.InvalidMessage_date_of_birth(1),Fields.InvalidMessage_date_of_birth(2)
          ,Fields.InvalidMessage_street_addr1(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_in_state(1)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_in_zip4(1),Fields.InvalidMessage_in_zip4(2)
          ,Fields.InvalidMessage_issue_date(1),Fields.InvalidMessage_issue_date(2)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_name_score(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_postdir(1)
          ,Fields.InvalidMessage_p_city_name(1)
          ,Fields.InvalidMessage_v_city_name(1)
          ,Fields.InvalidMessage_state(1)
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
          ,le.trans_indicator_ENUM_ErrorCount
          ,le.card_type_ENUM_ErrorCount
          ,le.dl_number_ALLOW_ErrorCount,le.dl_number_LENGTH_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.date_of_birth_CUSTOM_ErrorCount,le.date_of_birth_LENGTH_ErrorCount
          ,le.street_addr1_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.in_state_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.in_zip4_ALLOW_ErrorCount,le.in_zip4_LENGTH_ErrorCount
          ,le.issue_date_CUSTOM_ErrorCount,le.issue_date_LENGTH_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_LENGTH_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
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
          ,le.trans_indicator_ENUM_ErrorCount
          ,le.card_type_ENUM_ErrorCount
          ,le.dl_number_ALLOW_ErrorCount,le.dl_number_LENGTH_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.date_of_birth_CUSTOM_ErrorCount,le.date_of_birth_LENGTH_ErrorCount
          ,le.street_addr1_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.in_state_CUSTOM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.in_zip4_ALLOW_ErrorCount,le.in_zip4_LENGTH_ErrorCount
          ,le.issue_date_CUSTOM_ErrorCount,le.issue_date_LENGTH_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
          ,le.predir_ALLOW_ErrorCount
          ,le.prim_name_LENGTH_ErrorCount
          ,le.postdir_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
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
    SummaryInfo := NORMALIZE(SummaryStats,57,Into(LEFT,COUNTER));
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
