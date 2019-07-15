IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 28;
  EXPORT NumRulesFromFieldType := 28;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 28;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_DoNotMail)
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 name_score_Invalid;
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
    UNSIGNED1 dpbc_Invalid;
    UNSIGNED1 chk_digit_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 ace_fips_st_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 geo_match_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_DoNotMail)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_DoNotMail) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.title_Invalid := Fields.InValid_title((SALT311.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.name_score_Invalid := Fields.InValid_name_score((SALT311.StrType)le.name_score);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT311.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT311.StrType)le.prim_name);
    SELF.addr_suffix_Invalid := Fields.InValid_addr_suffix((SALT311.StrType)le.addr_suffix);
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
    SELF.dpbc_Invalid := Fields.InValid_dpbc((SALT311.StrType)le.dpbc);
    SELF.chk_digit_Invalid := Fields.InValid_chk_digit((SALT311.StrType)le.chk_digit);
    SELF.rec_type_Invalid := Fields.InValid_rec_type((SALT311.StrType)le.rec_type);
    SELF.ace_fips_st_Invalid := Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st);
    SELF.fips_county_Invalid := Fields.InValid_fips_county((SALT311.StrType)le.fips_county);
    SELF.geo_match_Invalid := Fields.InValid_geo_match((SALT311.StrType)le.geo_match);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_DoNotMail);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.title_Invalid << 0 ) + ( le.fname_Invalid << 1 ) + ( le.mname_Invalid << 2 ) + ( le.lname_Invalid << 3 ) + ( le.name_suffix_Invalid << 4 ) + ( le.name_score_Invalid << 5 ) + ( le.prim_range_Invalid << 6 ) + ( le.predir_Invalid << 7 ) + ( le.prim_name_Invalid << 8 ) + ( le.addr_suffix_Invalid << 9 ) + ( le.postdir_Invalid << 10 ) + ( le.unit_desig_Invalid << 11 ) + ( le.sec_range_Invalid << 12 ) + ( le.p_city_name_Invalid << 13 ) + ( le.v_city_name_Invalid << 14 ) + ( le.st_Invalid << 15 ) + ( le.zip_Invalid << 16 ) + ( le.zip4_Invalid << 17 ) + ( le.cart_Invalid << 18 ) + ( le.cr_sort_sz_Invalid << 19 ) + ( le.lot_Invalid << 20 ) + ( le.lot_order_Invalid << 21 ) + ( le.dpbc_Invalid << 22 ) + ( le.chk_digit_Invalid << 23 ) + ( le.rec_type_Invalid << 24 ) + ( le.ace_fips_st_Invalid << 25 ) + ( le.fips_county_Invalid << 26 ) + ( le.geo_match_Invalid << 27 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_DoNotMail);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.title_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.name_score_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.addr_suffix_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.st_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.cart_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.cr_sort_sz_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.lot_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.lot_order_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.dpbc_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.chk_digit_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.geo_match_Invalid := (le.ScrubsBits1 >> 27) & 1;
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
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_score_ALLOW_ErrorCount := COUNT(GROUP,h.name_score_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_ENUM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_ENUM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    cart_ALLOW_ErrorCount := COUNT(GROUP,h.cart_Invalid=1);
    cr_sort_sz_ENUM_ErrorCount := COUNT(GROUP,h.cr_sort_sz_Invalid=1);
    lot_ALLOW_ErrorCount := COUNT(GROUP,h.lot_Invalid=1);
    lot_order_ENUM_ErrorCount := COUNT(GROUP,h.lot_order_Invalid=1);
    dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.dpbc_Invalid=1);
    chk_digit_ALLOW_ErrorCount := COUNT(GROUP,h.chk_digit_Invalid=1);
    rec_type_ENUM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=1);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    geo_match_ALLOW_ErrorCount := COUNT(GROUP,h.geo_match_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.name_score_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0 OR h.cart_Invalid > 0 OR h.cr_sort_sz_Invalid > 0 OR h.lot_Invalid > 0 OR h.lot_order_Invalid > 0 OR h.dpbc_Invalid > 0 OR h.chk_digit_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.ace_fips_st_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.geo_match_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cart_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cr_sort_sz_ENUM_ErrorCount > 0, 1, 0) + IF(le.lot_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lot_order_ENUM_ErrorCount > 0, 1, 0) + IF(le.dpbc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.chk_digit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.geo_match_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.name_score_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,le.cart_Invalid,le.cr_sort_sz_Invalid,le.lot_Invalid,le.lot_order_Invalid,le.dpbc_Invalid,le.chk_digit_Invalid,le.rec_type_Invalid,le.ace_fips_st_Invalid,le.fips_county_Invalid,le.geo_match_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_name_score(le.name_score_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_cart(le.cart_Invalid),Fields.InvalidMessage_cr_sort_sz(le.cr_sort_sz_Invalid),Fields.InvalidMessage_lot(le.lot_Invalid),Fields.InvalidMessage_lot_order(le.lot_order_Invalid),Fields.InvalidMessage_dpbc(le.dpbc_Invalid),Fields.InvalidMessage_chk_digit(le.chk_digit_Invalid),Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Fields.InvalidMessage_geo_match(le.geo_match_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cart_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cr_sort_sz_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lot_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lot_order_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dpbc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.chk_digit_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.geo_match_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'title','fname','mname','lname','name_suffix','name_score','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','cart','cr_sort_sz','lot','lot_order','dpbc','chk_digit','rec_type','ace_fips_st','fips_county','geo_match','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Dir','Invalid_Char','Invalid_Char','Invalid_Dir','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_State','Invalid_Num','Invalid_Num','Invalid_Char','Invalid_CR','Invalid_Num','Invalid_LotOrder','Invalid_Num','Invalid_Num','Invalid_RecType','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.name_score,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,(SALT311.StrType)le.cart,(SALT311.StrType)le.cr_sort_sz,(SALT311.StrType)le.lot,(SALT311.StrType)le.lot_order,(SALT311.StrType)le.dpbc,(SALT311.StrType)le.chk_digit,(SALT311.StrType)le.rec_type,(SALT311.StrType)le.ace_fips_st,(SALT311.StrType)le.fips_county,(SALT311.StrType)le.geo_match,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,28,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_DoNotMail) prevDS = DATASET([], Layout_DoNotMail), STRING10 Src='UNK'):= FUNCTION
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
          ,'name_suffix:Invalid_Char:ALLOW'
          ,'name_score:Invalid_Num:ALLOW'
          ,'prim_range:Invalid_Char:ALLOW'
          ,'predir:Invalid_Dir:ENUM'
          ,'prim_name:Invalid_Char:ALLOW'
          ,'addr_suffix:Invalid_Char:ALLOW'
          ,'postdir:Invalid_Dir:ENUM'
          ,'unit_desig:Invalid_Char:ALLOW'
          ,'sec_range:Invalid_Char:ALLOW'
          ,'p_city_name:Invalid_Char:ALLOW'
          ,'v_city_name:Invalid_Char:ALLOW'
          ,'st:Invalid_State:ALLOW'
          ,'zip:Invalid_Num:ALLOW'
          ,'zip4:Invalid_Num:ALLOW'
          ,'cart:Invalid_Char:ALLOW'
          ,'cr_sort_sz:Invalid_CR:ENUM'
          ,'lot:Invalid_Num:ALLOW'
          ,'lot_order:Invalid_LotOrder:ENUM'
          ,'dpbc:Invalid_Num:ALLOW'
          ,'chk_digit:Invalid_Num:ALLOW'
          ,'rec_type:Invalid_RecType:ENUM'
          ,'ace_fips_st:Invalid_Num:ALLOW'
          ,'fips_county:Invalid_Num:ALLOW'
          ,'geo_match:Invalid_Num:ALLOW'
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
          ,Fields.InvalidMessage_name_suffix(1)
          ,Fields.InvalidMessage_name_score(1)
          ,Fields.InvalidMessage_prim_range(1)
          ,Fields.InvalidMessage_predir(1)
          ,Fields.InvalidMessage_prim_name(1)
          ,Fields.InvalidMessage_addr_suffix(1)
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
          ,Fields.InvalidMessage_dpbc(1)
          ,Fields.InvalidMessage_chk_digit(1)
          ,Fields.InvalidMessage_rec_type(1)
          ,Fields.InvalidMessage_ace_fips_st(1)
          ,Fields.InvalidMessage_fips_county(1)
          ,Fields.InvalidMessage_geo_match(1)
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
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_ENUM_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount
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
          ,le.name_suffix_ALLOW_ErrorCount
          ,le.name_score_ALLOW_ErrorCount
          ,le.prim_range_ALLOW_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.prim_name_ALLOW_ErrorCount
          ,le.addr_suffix_ALLOW_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.unit_desig_ALLOW_ErrorCount
          ,le.sec_range_ALLOW_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.cart_ALLOW_ErrorCount
          ,le.cr_sort_sz_ENUM_ErrorCount
          ,le.lot_ALLOW_ErrorCount
          ,le.lot_order_ENUM_ErrorCount
          ,le.dpbc_ALLOW_ErrorCount
          ,le.chk_digit_ALLOW_ErrorCount
          ,le.rec_type_ENUM_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount
          ,le.geo_match_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_DoNotMail));
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
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_score_cnt
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
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_score_pcnt
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
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,32,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_DoNotMail));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),32,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_DoNotMail) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DoNotMail, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
