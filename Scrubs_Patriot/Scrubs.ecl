IMPORT SALT311,STD;
IMPORT Scrubs_Patriot; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 37;
  EXPORT NumRulesFromFieldType := 37;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 33;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Patriot)
    UNSIGNED1 pty_key_Invalid;
    UNSIGNED1 source_Invalid;
    UNSIGNED1 orig_pty_name_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 addr_1_Invalid;
    UNSIGNED1 addr_2_Invalid;
    UNSIGNED1 addr_3_Invalid;
    UNSIGNED1 addr_4_Invalid;
    UNSIGNED1 addr_5_Invalid;
    UNSIGNED1 addr_6_Invalid;
    UNSIGNED1 addr_7_Invalid;
    UNSIGNED1 addr_8_Invalid;
    UNSIGNED1 addr_9_Invalid;
    UNSIGNED1 addr_10_Invalid;
    UNSIGNED1 cname_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 suffix_Invalid;
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
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Patriot)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_Patriot)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'pty_key:invalid_source_code:ALLOW','pty_key:invalid_source_code:CUSTOM'
          ,'source:invalid_source:CUSTOM'
          ,'orig_pty_name:invalid_name:CUSTOM'
          ,'country:invalid_country_name:QUOTES','country:invalid_country_name:ALLOW'
          ,'name_type:invalid_name_type:ENUM'
          ,'addr_1:invalid_address:CUSTOM'
          ,'addr_2:invalid_address:CUSTOM'
          ,'addr_3:invalid_address:CUSTOM'
          ,'addr_4:invalid_address:CUSTOM'
          ,'addr_5:invalid_address:CUSTOM'
          ,'addr_6:invalid_address:CUSTOM'
          ,'addr_7:invalid_address:CUSTOM'
          ,'addr_8:invalid_address:CUSTOM'
          ,'addr_9:invalid_address:CUSTOM'
          ,'addr_10:invalid_address:CUSTOM'
          ,'cname:invalid_alphanumeric:ALLOW'
          ,'title:invalid_name:CUSTOM'
          ,'fname:invalid_name:CUSTOM'
          ,'mname:invalid_name:CUSTOM'
          ,'lname:invalid_name:CUSTOM'
          ,'suffix:invalid_suffix:ENUM'
          ,'prim_range:invalid_address:CUSTOM'
          ,'predir:invalid_address:CUSTOM'
          ,'prim_name:invalid_address:CUSTOM'
          ,'addr_suffix:invalid_address:CUSTOM'
          ,'postdir:invalid_address:CUSTOM'
          ,'unit_desig:invalid_address:CUSTOM'
          ,'sec_range:invalid_address:CUSTOM'
          ,'p_city_name:invalid_alpha:ALLOW'
          ,'v_city_name:invalid_alpha:ALLOW'
          ,'st:invalid_alpha:ALLOW'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTHS'
          ,'zip4:invalid_zip4:ALLOW','zip4:invalid_zip4:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_pty_key(1),Fields.InvalidMessage_pty_key(2)
          ,Fields.InvalidMessage_source(1)
          ,Fields.InvalidMessage_orig_pty_name(1)
          ,Fields.InvalidMessage_country(1),Fields.InvalidMessage_country(2)
          ,Fields.InvalidMessage_name_type(1)
          ,Fields.InvalidMessage_addr_1(1)
          ,Fields.InvalidMessage_addr_2(1)
          ,Fields.InvalidMessage_addr_3(1)
          ,Fields.InvalidMessage_addr_4(1)
          ,Fields.InvalidMessage_addr_5(1)
          ,Fields.InvalidMessage_addr_6(1)
          ,Fields.InvalidMessage_addr_7(1)
          ,Fields.InvalidMessage_addr_8(1)
          ,Fields.InvalidMessage_addr_9(1)
          ,Fields.InvalidMessage_addr_10(1)
          ,Fields.InvalidMessage_cname(1)
          ,Fields.InvalidMessage_title(1)
          ,Fields.InvalidMessage_fname(1)
          ,Fields.InvalidMessage_mname(1)
          ,Fields.InvalidMessage_lname(1)
          ,Fields.InvalidMessage_suffix(1)
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
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_Patriot) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.pty_key_Invalid := Fields.InValid_pty_key((SALT311.StrType)le.pty_key);
    SELF.source_Invalid := Fields.InValid_source((SALT311.StrType)le.source);
    SELF.orig_pty_name_Invalid := Fields.InValid_orig_pty_name((SALT311.StrType)le.orig_pty_name);
    SELF.country_Invalid := Fields.InValid_country((SALT311.StrType)le.country);
    SELF.name_type_Invalid := Fields.InValid_name_type((SALT311.StrType)le.name_type);
    SELF.addr_1_Invalid := Fields.InValid_addr_1((SALT311.StrType)le.addr_1);
    SELF.addr_2_Invalid := Fields.InValid_addr_2((SALT311.StrType)le.addr_2);
    SELF.addr_3_Invalid := Fields.InValid_addr_3((SALT311.StrType)le.addr_3);
    SELF.addr_4_Invalid := Fields.InValid_addr_4((SALT311.StrType)le.addr_4);
    SELF.addr_5_Invalid := Fields.InValid_addr_5((SALT311.StrType)le.addr_5);
    SELF.addr_6_Invalid := Fields.InValid_addr_6((SALT311.StrType)le.addr_6);
    SELF.addr_7_Invalid := Fields.InValid_addr_7((SALT311.StrType)le.addr_7);
    SELF.addr_8_Invalid := Fields.InValid_addr_8((SALT311.StrType)le.addr_8);
    SELF.addr_9_Invalid := Fields.InValid_addr_9((SALT311.StrType)le.addr_9);
    SELF.addr_10_Invalid := Fields.InValid_addr_10((SALT311.StrType)le.addr_10);
    SELF.cname_Invalid := Fields.InValid_cname((SALT311.StrType)le.cname);
    SELF.title_Invalid := Fields.InValid_title((SALT311.StrType)le.title);
    SELF.fname_Invalid := Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT311.StrType)le.suffix);
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
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Patriot);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.pty_key_Invalid << 0 ) + ( le.source_Invalid << 2 ) + ( le.orig_pty_name_Invalid << 3 ) + ( le.country_Invalid << 4 ) + ( le.name_type_Invalid << 6 ) + ( le.addr_1_Invalid << 7 ) + ( le.addr_2_Invalid << 8 ) + ( le.addr_3_Invalid << 9 ) + ( le.addr_4_Invalid << 10 ) + ( le.addr_5_Invalid << 11 ) + ( le.addr_6_Invalid << 12 ) + ( le.addr_7_Invalid << 13 ) + ( le.addr_8_Invalid << 14 ) + ( le.addr_9_Invalid << 15 ) + ( le.addr_10_Invalid << 16 ) + ( le.cname_Invalid << 17 ) + ( le.title_Invalid << 18 ) + ( le.fname_Invalid << 19 ) + ( le.mname_Invalid << 20 ) + ( le.lname_Invalid << 21 ) + ( le.suffix_Invalid << 22 ) + ( le.prim_range_Invalid << 23 ) + ( le.predir_Invalid << 24 ) + ( le.prim_name_Invalid << 25 ) + ( le.addr_suffix_Invalid << 26 ) + ( le.postdir_Invalid << 27 ) + ( le.unit_desig_Invalid << 28 ) + ( le.sec_range_Invalid << 29 ) + ( le.p_city_name_Invalid << 30 ) + ( le.v_city_name_Invalid << 31 ) + ( le.st_Invalid << 32 ) + ( le.zip_Invalid << 33 ) + ( le.zip4_Invalid << 35 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Patriot);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.pty_key_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.source_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_pty_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.name_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.addr_1_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.addr_2_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.addr_3_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.addr_4_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.addr_5_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.addr_6_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.addr_7_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.addr_8_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.addr_9_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.addr_10_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.cname_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 22) & 1;
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
    SELF.zip_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.src_key) src_key := IF(Glob, '', h.src_key);
    TotalCnt := COUNT(GROUP); // Number of records in total
    pty_key_ALLOW_ErrorCount := COUNT(GROUP,h.pty_key_Invalid=1);
    pty_key_CUSTOM_ErrorCount := COUNT(GROUP,h.pty_key_Invalid=2);
    pty_key_Total_ErrorCount := COUNT(GROUP,h.pty_key_Invalid>0);
    source_CUSTOM_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    orig_pty_name_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_pty_name_Invalid=1);
    country_QUOTES_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    country_ALLOW_ErrorCount := COUNT(GROUP,h.country_Invalid=2);
    country_Total_ErrorCount := COUNT(GROUP,h.country_Invalid>0);
    name_type_ENUM_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    addr_1_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_1_Invalid=1);
    addr_2_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_2_Invalid=1);
    addr_3_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_3_Invalid=1);
    addr_4_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_4_Invalid=1);
    addr_5_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_5_Invalid=1);
    addr_6_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_6_Invalid=1);
    addr_7_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_7_Invalid=1);
    addr_8_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_8_Invalid=1);
    addr_9_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_9_Invalid=1);
    addr_10_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_10_Invalid=1);
    cname_ALLOW_ErrorCount := COUNT(GROUP,h.cname_Invalid=1);
    title_CUSTOM_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    mname_CUSTOM_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    suffix_ENUM_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    prim_range_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    predir_CUSTOM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    prim_name_CUSTOM_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    addr_suffix_CUSTOM_ErrorCount := COUNT(GROUP,h.addr_suffix_Invalid=1);
    postdir_CUSTOM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    unit_desig_CUSTOM_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    sec_range_CUSTOM_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.pty_key_Invalid > 0 OR h.source_Invalid > 0 OR h.orig_pty_name_Invalid > 0 OR h.country_Invalid > 0 OR h.name_type_Invalid > 0 OR h.addr_1_Invalid > 0 OR h.addr_2_Invalid > 0 OR h.addr_3_Invalid > 0 OR h.addr_4_Invalid > 0 OR h.addr_5_Invalid > 0 OR h.addr_6_Invalid > 0 OR h.addr_7_Invalid > 0 OR h.addr_8_Invalid > 0 OR h.addr_9_Invalid > 0 OR h.addr_10_Invalid > 0 OR h.cname_Invalid > 0 OR h.title_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.suffix_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.addr_suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip_Invalid > 0 OR h.zip4_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,src_key,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.pty_key_Total_ErrorCount > 0, 1, 0) + IF(le.source_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_pty_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.country_Total_ErrorCount > 0, 1, 0) + IF(le.name_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.addr_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_9_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_10_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.suffix_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_desig_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.pty_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pty_key_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_pty_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.country_QUOTES_ErrorCount > 0, 1, 0) + IF(le.country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.addr_1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_7_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_8_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_9_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_10_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.suffix_ENUM_ErrorCount > 0, 1, 0) + IF(le.prim_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.prim_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.addr_suffix_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.postdir_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.unit_desig_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sec_range_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_LENGTHS_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  le.src_key;
    UNSIGNED1 ErrNum := CHOOSE(c,le.pty_key_Invalid,le.source_Invalid,le.orig_pty_name_Invalid,le.country_Invalid,le.name_type_Invalid,le.addr_1_Invalid,le.addr_2_Invalid,le.addr_3_Invalid,le.addr_4_Invalid,le.addr_5_Invalid,le.addr_6_Invalid,le.addr_7_Invalid,le.addr_8_Invalid,le.addr_9_Invalid,le.addr_10_Invalid,le.cname_Invalid,le.title_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.suffix_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.addr_suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip_Invalid,le.zip4_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_pty_key(le.pty_key_Invalid),Fields.InvalidMessage_source(le.source_Invalid),Fields.InvalidMessage_orig_pty_name(le.orig_pty_name_Invalid),Fields.InvalidMessage_country(le.country_Invalid),Fields.InvalidMessage_name_type(le.name_type_Invalid),Fields.InvalidMessage_addr_1(le.addr_1_Invalid),Fields.InvalidMessage_addr_2(le.addr_2_Invalid),Fields.InvalidMessage_addr_3(le.addr_3_Invalid),Fields.InvalidMessage_addr_4(le.addr_4_Invalid),Fields.InvalidMessage_addr_5(le.addr_5_Invalid),Fields.InvalidMessage_addr_6(le.addr_6_Invalid),Fields.InvalidMessage_addr_7(le.addr_7_Invalid),Fields.InvalidMessage_addr_8(le.addr_8_Invalid),Fields.InvalidMessage_addr_9(le.addr_9_Invalid),Fields.InvalidMessage_addr_10(le.addr_10_Invalid),Fields.InvalidMessage_cname(le.cname_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_addr_suffix(le.addr_suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.pty_key_Invalid,'ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_pty_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'QUOTES','ALLOW','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.addr_1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_7_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_8_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_9_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_10_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.addr_suffix_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'pty_key','source','orig_pty_name','country','name_type','addr_1','addr_2','addr_3','addr_4','addr_5','addr_6','addr_7','addr_8','addr_9','addr_10','cname','title','fname','mname','lname','suffix','prim_range','predir','prim_name','addr_suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip','zip4','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_source_code','invalid_source','invalid_name','invalid_country_name','invalid_name_type','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alphanumeric','invalid_name','invalid_name','invalid_name','invalid_name','invalid_suffix','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alpha','invalid_alpha','invalid_zip','invalid_zip4','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.pty_key,(SALT311.StrType)le.source,(SALT311.StrType)le.orig_pty_name,(SALT311.StrType)le.country,(SALT311.StrType)le.name_type,(SALT311.StrType)le.addr_1,(SALT311.StrType)le.addr_2,(SALT311.StrType)le.addr_3,(SALT311.StrType)le.addr_4,(SALT311.StrType)le.addr_5,(SALT311.StrType)le.addr_6,(SALT311.StrType)le.addr_7,(SALT311.StrType)le.addr_8,(SALT311.StrType)le.addr_9,(SALT311.StrType)le.addr_10,(SALT311.StrType)le.cname,(SALT311.StrType)le.title,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.suffix,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.addr_suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip,(SALT311.StrType)le.zip4,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,33,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Patriot) prevDS = DATASET([], Layout_Patriot)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.src_key;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.pty_key_ALLOW_ErrorCount,le.pty_key_CUSTOM_ErrorCount
          ,le.source_CUSTOM_ErrorCount
          ,le.orig_pty_name_CUSTOM_ErrorCount
          ,le.country_QUOTES_ErrorCount,le.country_ALLOW_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.addr_1_CUSTOM_ErrorCount
          ,le.addr_2_CUSTOM_ErrorCount
          ,le.addr_3_CUSTOM_ErrorCount
          ,le.addr_4_CUSTOM_ErrorCount
          ,le.addr_5_CUSTOM_ErrorCount
          ,le.addr_6_CUSTOM_ErrorCount
          ,le.addr_7_CUSTOM_ErrorCount
          ,le.addr_8_CUSTOM_ErrorCount
          ,le.addr_9_CUSTOM_ErrorCount
          ,le.addr_10_CUSTOM_ErrorCount
          ,le.cname_ALLOW_ErrorCount
          ,le.title_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.suffix_ENUM_ErrorCount
          ,le.prim_range_CUSTOM_ErrorCount
          ,le.predir_CUSTOM_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.addr_suffix_CUSTOM_ErrorCount
          ,le.postdir_CUSTOM_ErrorCount
          ,le.unit_desig_CUSTOM_ErrorCount
          ,le.sec_range_CUSTOM_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.pty_key_ALLOW_ErrorCount,le.pty_key_CUSTOM_ErrorCount
          ,le.source_CUSTOM_ErrorCount
          ,le.orig_pty_name_CUSTOM_ErrorCount
          ,le.country_QUOTES_ErrorCount,le.country_ALLOW_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.addr_1_CUSTOM_ErrorCount
          ,le.addr_2_CUSTOM_ErrorCount
          ,le.addr_3_CUSTOM_ErrorCount
          ,le.addr_4_CUSTOM_ErrorCount
          ,le.addr_5_CUSTOM_ErrorCount
          ,le.addr_6_CUSTOM_ErrorCount
          ,le.addr_7_CUSTOM_ErrorCount
          ,le.addr_8_CUSTOM_ErrorCount
          ,le.addr_9_CUSTOM_ErrorCount
          ,le.addr_10_CUSTOM_ErrorCount
          ,le.cname_ALLOW_ErrorCount
          ,le.title_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.mname_CUSTOM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.suffix_ENUM_ErrorCount
          ,le.prim_range_CUSTOM_ErrorCount
          ,le.predir_CUSTOM_ErrorCount
          ,le.prim_name_CUSTOM_ErrorCount
          ,le.addr_suffix_CUSTOM_ErrorCount
          ,le.postdir_CUSTOM_ErrorCount
          ,le.unit_desig_CUSTOM_ErrorCount
          ,le.sec_range_CUSTOM_ErrorCount
          ,le.p_city_name_ALLOW_ErrorCount
          ,le.v_city_name_ALLOW_ErrorCount
          ,le.st_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := hygiene(PROJECT(h, Layout_Patriot));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'pty_key:' + getFieldTypeText(h.pty_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pty_name:' + getFieldTypeText(h.orig_pty_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_vessel_name:' + getFieldTypeText(h.orig_vessel_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_type:' + getFieldTypeText(h.name_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_1:' + getFieldTypeText(h.addr_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_2:' + getFieldTypeText(h.addr_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_3:' + getFieldTypeText(h.addr_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_4:' + getFieldTypeText(h.addr_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_5:' + getFieldTypeText(h.addr_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_6:' + getFieldTypeText(h.addr_6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_7:' + getFieldTypeText(h.addr_7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_8:' + getFieldTypeText(h.addr_8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_9:' + getFieldTypeText(h.addr_9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_10:' + getFieldTypeText(h.addr_10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_1:' + getFieldTypeText(h.remarks_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_2:' + getFieldTypeText(h.remarks_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_3:' + getFieldTypeText(h.remarks_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_4:' + getFieldTypeText(h.remarks_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_5:' + getFieldTypeText(h.remarks_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_6:' + getFieldTypeText(h.remarks_6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_7:' + getFieldTypeText(h.remarks_7) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_8:' + getFieldTypeText(h.remarks_8) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_9:' + getFieldTypeText(h.remarks_9) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_10:' + getFieldTypeText(h.remarks_10) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_11:' + getFieldTypeText(h.remarks_11) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_12:' + getFieldTypeText(h.remarks_12) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_13:' + getFieldTypeText(h.remarks_13) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_14:' + getFieldTypeText(h.remarks_14) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_15:' + getFieldTypeText(h.remarks_15) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_16:' + getFieldTypeText(h.remarks_16) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_17:' + getFieldTypeText(h.remarks_17) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_18:' + getFieldTypeText(h.remarks_18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_19:' + getFieldTypeText(h.remarks_19) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_20:' + getFieldTypeText(h.remarks_20) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_21:' + getFieldTypeText(h.remarks_21) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_22:' + getFieldTypeText(h.remarks_22) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_23:' + getFieldTypeText(h.remarks_23) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_24:' + getFieldTypeText(h.remarks_24) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_25:' + getFieldTypeText(h.remarks_25) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_26:' + getFieldTypeText(h.remarks_26) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_27:' + getFieldTypeText(h.remarks_27) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_28:' + getFieldTypeText(h.remarks_28) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_29:' + getFieldTypeText(h.remarks_29) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'remarks_30:' + getFieldTypeText(h.remarks_30) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname:' + getFieldTypeText(h.cname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'a_score:' + getFieldTypeText(h.a_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_prim_range:' + getFieldTypeText(h.aid_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_predir:' + getFieldTypeText(h.aid_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_prim_name:' + getFieldTypeText(h.aid_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_addr_suffix:' + getFieldTypeText(h.aid_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_postdir:' + getFieldTypeText(h.aid_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_unit_desig:' + getFieldTypeText(h.aid_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_sec_range:' + getFieldTypeText(h.aid_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_p_city_name:' + getFieldTypeText(h.aid_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_v_city_name:' + getFieldTypeText(h.aid_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_st:' + getFieldTypeText(h.aid_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_zip:' + getFieldTypeText(h.aid_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_zip4:' + getFieldTypeText(h.aid_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_cart:' + getFieldTypeText(h.aid_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_cr_sort_sz:' + getFieldTypeText(h.aid_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_lot:' + getFieldTypeText(h.aid_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_lot_order:' + getFieldTypeText(h.aid_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_dpbc:' + getFieldTypeText(h.aid_dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_chk_digit:' + getFieldTypeText(h.aid_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_record_type:' + getFieldTypeText(h.aid_record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_fips_st:' + getFieldTypeText(h.aid_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_county:' + getFieldTypeText(h.aid_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_geo_lat:' + getFieldTypeText(h.aid_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_geo_long:' + getFieldTypeText(h.aid_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_msa:' + getFieldTypeText(h.aid_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_geo_blk:' + getFieldTypeText(h.aid_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_geo_match:' + getFieldTypeText(h.aid_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aid_err_stat:' + getFieldTypeText(h.aid_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'append_rawaid:' + getFieldTypeText(h.append_rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_pty_key_cnt
          ,le.populated_source_cnt
          ,le.populated_orig_pty_name_cnt
          ,le.populated_orig_vessel_name_cnt
          ,le.populated_country_cnt
          ,le.populated_name_type_cnt
          ,le.populated_addr_1_cnt
          ,le.populated_addr_2_cnt
          ,le.populated_addr_3_cnt
          ,le.populated_addr_4_cnt
          ,le.populated_addr_5_cnt
          ,le.populated_addr_6_cnt
          ,le.populated_addr_7_cnt
          ,le.populated_addr_8_cnt
          ,le.populated_addr_9_cnt
          ,le.populated_addr_10_cnt
          ,le.populated_remarks_1_cnt
          ,le.populated_remarks_2_cnt
          ,le.populated_remarks_3_cnt
          ,le.populated_remarks_4_cnt
          ,le.populated_remarks_5_cnt
          ,le.populated_remarks_6_cnt
          ,le.populated_remarks_7_cnt
          ,le.populated_remarks_8_cnt
          ,le.populated_remarks_9_cnt
          ,le.populated_remarks_10_cnt
          ,le.populated_remarks_11_cnt
          ,le.populated_remarks_12_cnt
          ,le.populated_remarks_13_cnt
          ,le.populated_remarks_14_cnt
          ,le.populated_remarks_15_cnt
          ,le.populated_remarks_16_cnt
          ,le.populated_remarks_17_cnt
          ,le.populated_remarks_18_cnt
          ,le.populated_remarks_19_cnt
          ,le.populated_remarks_20_cnt
          ,le.populated_remarks_21_cnt
          ,le.populated_remarks_22_cnt
          ,le.populated_remarks_23_cnt
          ,le.populated_remarks_24_cnt
          ,le.populated_remarks_25_cnt
          ,le.populated_remarks_26_cnt
          ,le.populated_remarks_27_cnt
          ,le.populated_remarks_28_cnt
          ,le.populated_remarks_29_cnt
          ,le.populated_remarks_30_cnt
          ,le.populated_cname_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_suffix_cnt
          ,le.populated_a_score_cnt
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
          ,le.populated_record_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_global_sid_cnt
          ,le.populated_record_sid_cnt
          ,le.populated_did_cnt
          ,le.populated_aid_prim_range_cnt
          ,le.populated_aid_predir_cnt
          ,le.populated_aid_prim_name_cnt
          ,le.populated_aid_addr_suffix_cnt
          ,le.populated_aid_postdir_cnt
          ,le.populated_aid_unit_desig_cnt
          ,le.populated_aid_sec_range_cnt
          ,le.populated_aid_p_city_name_cnt
          ,le.populated_aid_v_city_name_cnt
          ,le.populated_aid_st_cnt
          ,le.populated_aid_zip_cnt
          ,le.populated_aid_zip4_cnt
          ,le.populated_aid_cart_cnt
          ,le.populated_aid_cr_sort_sz_cnt
          ,le.populated_aid_lot_cnt
          ,le.populated_aid_lot_order_cnt
          ,le.populated_aid_dpbc_cnt
          ,le.populated_aid_chk_digit_cnt
          ,le.populated_aid_record_type_cnt
          ,le.populated_aid_fips_st_cnt
          ,le.populated_aid_county_cnt
          ,le.populated_aid_geo_lat_cnt
          ,le.populated_aid_geo_long_cnt
          ,le.populated_aid_msa_cnt
          ,le.populated_aid_geo_blk_cnt
          ,le.populated_aid_geo_match_cnt
          ,le.populated_aid_err_stat_cnt
          ,le.populated_append_rawaid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_pty_key_pcnt
          ,le.populated_source_pcnt
          ,le.populated_orig_pty_name_pcnt
          ,le.populated_orig_vessel_name_pcnt
          ,le.populated_country_pcnt
          ,le.populated_name_type_pcnt
          ,le.populated_addr_1_pcnt
          ,le.populated_addr_2_pcnt
          ,le.populated_addr_3_pcnt
          ,le.populated_addr_4_pcnt
          ,le.populated_addr_5_pcnt
          ,le.populated_addr_6_pcnt
          ,le.populated_addr_7_pcnt
          ,le.populated_addr_8_pcnt
          ,le.populated_addr_9_pcnt
          ,le.populated_addr_10_pcnt
          ,le.populated_remarks_1_pcnt
          ,le.populated_remarks_2_pcnt
          ,le.populated_remarks_3_pcnt
          ,le.populated_remarks_4_pcnt
          ,le.populated_remarks_5_pcnt
          ,le.populated_remarks_6_pcnt
          ,le.populated_remarks_7_pcnt
          ,le.populated_remarks_8_pcnt
          ,le.populated_remarks_9_pcnt
          ,le.populated_remarks_10_pcnt
          ,le.populated_remarks_11_pcnt
          ,le.populated_remarks_12_pcnt
          ,le.populated_remarks_13_pcnt
          ,le.populated_remarks_14_pcnt
          ,le.populated_remarks_15_pcnt
          ,le.populated_remarks_16_pcnt
          ,le.populated_remarks_17_pcnt
          ,le.populated_remarks_18_pcnt
          ,le.populated_remarks_19_pcnt
          ,le.populated_remarks_20_pcnt
          ,le.populated_remarks_21_pcnt
          ,le.populated_remarks_22_pcnt
          ,le.populated_remarks_23_pcnt
          ,le.populated_remarks_24_pcnt
          ,le.populated_remarks_25_pcnt
          ,le.populated_remarks_26_pcnt
          ,le.populated_remarks_27_pcnt
          ,le.populated_remarks_28_pcnt
          ,le.populated_remarks_29_pcnt
          ,le.populated_remarks_30_pcnt
          ,le.populated_cname_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_a_score_pcnt
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
          ,le.populated_record_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_global_sid_pcnt
          ,le.populated_record_sid_pcnt
          ,le.populated_did_pcnt
          ,le.populated_aid_prim_range_pcnt
          ,le.populated_aid_predir_pcnt
          ,le.populated_aid_prim_name_pcnt
          ,le.populated_aid_addr_suffix_pcnt
          ,le.populated_aid_postdir_pcnt
          ,le.populated_aid_unit_desig_pcnt
          ,le.populated_aid_sec_range_pcnt
          ,le.populated_aid_p_city_name_pcnt
          ,le.populated_aid_v_city_name_pcnt
          ,le.populated_aid_st_pcnt
          ,le.populated_aid_zip_pcnt
          ,le.populated_aid_zip4_pcnt
          ,le.populated_aid_cart_pcnt
          ,le.populated_aid_cr_sort_sz_pcnt
          ,le.populated_aid_lot_pcnt
          ,le.populated_aid_lot_order_pcnt
          ,le.populated_aid_dpbc_pcnt
          ,le.populated_aid_chk_digit_pcnt
          ,le.populated_aid_record_type_pcnt
          ,le.populated_aid_fips_st_pcnt
          ,le.populated_aid_county_pcnt
          ,le.populated_aid_geo_lat_pcnt
          ,le.populated_aid_geo_long_pcnt
          ,le.populated_aid_msa_pcnt
          ,le.populated_aid_geo_blk_pcnt
          ,le.populated_aid_geo_match_pcnt
          ,le.populated_aid_err_stat_pcnt
          ,le.populated_append_rawaid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,111,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Patriot));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),111,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Patriot) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Patriot, Fields, 'RECORDOF(scrubsSummaryOverall)', 'src_key');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, src_key, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
