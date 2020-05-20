IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 84;
  EXPORT NumRulesFromFieldType := 84;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 38;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Watercraft_Search)
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 date_vendor_first_reported_Invalid;
    UNSIGNED1 date_vendor_last_reported_Invalid;
    UNSIGNED1 watercraft_key_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 dppa_flag_Invalid;
    UNSIGNED1 orig_name_type_code_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 phone_1_Invalid;
    UNSIGNED1 phone_2_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 mname_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 name_suffix_Invalid;
    UNSIGNED1 company_name_Invalid;
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
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 ace_fips_st_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 fein_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 history_flag_Invalid;
    UNSIGNED1 rawaid_Invalid;
    UNSIGNED1 persistent_record_id_Invalid;
    UNSIGNED1 source_rec_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Watercraft_Search)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
  EXPORT Rule_Layout := RECORD(Layout_Watercraft_Search)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'date_first_seen:invalid_date:ALLOW'
          ,'date_last_seen:invalid_date:ALLOW'
          ,'date_vendor_first_reported:invalid_date:ALLOW'
          ,'date_vendor_last_reported:invalid_date:ALLOW'
          ,'watercraft_key:invalid_blank:LENGTHS'
          ,'state_origin:invalid_state:ALLOW','state_origin:invalid_state:LENGTHS'
          ,'source_code:invalid_source_code:ALLOW','source_code:invalid_source_code:LENGTHS'
          ,'dppa_flag:invalid_dppa_flag:ENUM','dppa_flag:invalid_dppa_flag:LENGTHS'
          ,'orig_name_type_code:invalid_owner_type:ENUM','orig_name_type_code:invalid_owner_type:LENGTHS'
          ,'dob:invalid_date:ALLOW'
          ,'phone_1:invalid_phone:ALLOW','phone_1:invalid_phone:LENGTHS'
          ,'phone_2:invalid_phone:ALLOW','phone_2:invalid_phone:LENGTHS'
          ,'fname:invalid_name:CAPS','fname:invalid_name:ALLOW','fname:invalid_name:LENGTHS'
          ,'mname:invalid_name:CAPS','mname:invalid_name:ALLOW','mname:invalid_name:LENGTHS'
          ,'lname:invalid_name:CAPS','lname:invalid_name:ALLOW','lname:invalid_name:LENGTHS'
          ,'name_suffix:invalid_name:CAPS','name_suffix:invalid_name:ALLOW','name_suffix:invalid_name:LENGTHS'
          ,'company_name:invalid_company:CAPS','company_name:invalid_company:ALLOW','company_name:invalid_company:LENGTHS'
          ,'prim_range:invalid_address:CAPS','prim_range:invalid_address:ALLOW','prim_range:invalid_address:LENGTHS'
          ,'predir:invalid_address:CAPS','predir:invalid_address:ALLOW','predir:invalid_address:LENGTHS'
          ,'prim_name:invalid_address:CAPS','prim_name:invalid_address:ALLOW','prim_name:invalid_address:LENGTHS'
          ,'suffix:invalid_address:CAPS','suffix:invalid_address:ALLOW','suffix:invalid_address:LENGTHS'
          ,'postdir:invalid_address:CAPS','postdir:invalid_address:ALLOW','postdir:invalid_address:LENGTHS'
          ,'unit_desig:invalid_address:CAPS','unit_desig:invalid_address:ALLOW','unit_desig:invalid_address:LENGTHS'
          ,'sec_range:invalid_address:CAPS','sec_range:invalid_address:ALLOW','sec_range:invalid_address:LENGTHS'
          ,'p_city_name:invalid_alpha:CAPS','p_city_name:invalid_alpha:ALLOW','p_city_name:invalid_alpha:LENGTHS'
          ,'v_city_name:invalid_alpha:CAPS','v_city_name:invalid_alpha:ALLOW','v_city_name:invalid_alpha:LENGTHS'
          ,'st:invalid_state:ALLOW','st:invalid_state:LENGTHS'
          ,'zip5:invalid_numeric:ALLOW','zip5:invalid_numeric:LENGTHS'
          ,'zip4:invalid_numeric:ALLOW','zip4:invalid_numeric:LENGTHS'
          ,'ace_fips_st:invalid_fips:ALLOW','ace_fips_st:invalid_fips:LENGTHS'
          ,'bdid:invalid_numeric:ALLOW','bdid:invalid_numeric:LENGTHS'
          ,'fein:invalid_ssn_fein:ALLOW','fein:invalid_ssn_fein:LENGTHS'
          ,'did:invalid_numeric:ALLOW','did:invalid_numeric:LENGTHS'
          ,'ssn:invalid_ssn_fein:ALLOW','ssn:invalid_ssn_fein:LENGTHS'
          ,'history_flag:invalid_history_flag:ENUM','history_flag:invalid_history_flag:LENGTHS'
          ,'rawaid:invalid_numeric:ALLOW','rawaid:invalid_numeric:LENGTHS'
          ,'persistent_record_id:invalid_numeric:ALLOW','persistent_record_id:invalid_numeric:LENGTHS'
          ,'source_rec_id:invalid_numeric:ALLOW','source_rec_id:invalid_numeric:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_date_first_seen(1)
          ,Fields.InvalidMessage_date_last_seen(1)
          ,Fields.InvalidMessage_date_vendor_first_reported(1)
          ,Fields.InvalidMessage_date_vendor_last_reported(1)
          ,Fields.InvalidMessage_watercraft_key(1)
          ,Fields.InvalidMessage_state_origin(1),Fields.InvalidMessage_state_origin(2)
          ,Fields.InvalidMessage_source_code(1),Fields.InvalidMessage_source_code(2)
          ,Fields.InvalidMessage_dppa_flag(1),Fields.InvalidMessage_dppa_flag(2)
          ,Fields.InvalidMessage_orig_name_type_code(1),Fields.InvalidMessage_orig_name_type_code(2)
          ,Fields.InvalidMessage_dob(1)
          ,Fields.InvalidMessage_phone_1(1),Fields.InvalidMessage_phone_1(2)
          ,Fields.InvalidMessage_phone_2(1),Fields.InvalidMessage_phone_2(2)
          ,Fields.InvalidMessage_fname(1),Fields.InvalidMessage_fname(2),Fields.InvalidMessage_fname(3)
          ,Fields.InvalidMessage_mname(1),Fields.InvalidMessage_mname(2),Fields.InvalidMessage_mname(3)
          ,Fields.InvalidMessage_lname(1),Fields.InvalidMessage_lname(2),Fields.InvalidMessage_lname(3)
          ,Fields.InvalidMessage_name_suffix(1),Fields.InvalidMessage_name_suffix(2),Fields.InvalidMessage_name_suffix(3)
          ,Fields.InvalidMessage_company_name(1),Fields.InvalidMessage_company_name(2),Fields.InvalidMessage_company_name(3)
          ,Fields.InvalidMessage_prim_range(1),Fields.InvalidMessage_prim_range(2),Fields.InvalidMessage_prim_range(3)
          ,Fields.InvalidMessage_predir(1),Fields.InvalidMessage_predir(2),Fields.InvalidMessage_predir(3)
          ,Fields.InvalidMessage_prim_name(1),Fields.InvalidMessage_prim_name(2),Fields.InvalidMessage_prim_name(3)
          ,Fields.InvalidMessage_suffix(1),Fields.InvalidMessage_suffix(2),Fields.InvalidMessage_suffix(3)
          ,Fields.InvalidMessage_postdir(1),Fields.InvalidMessage_postdir(2),Fields.InvalidMessage_postdir(3)
          ,Fields.InvalidMessage_unit_desig(1),Fields.InvalidMessage_unit_desig(2),Fields.InvalidMessage_unit_desig(3)
          ,Fields.InvalidMessage_sec_range(1),Fields.InvalidMessage_sec_range(2),Fields.InvalidMessage_sec_range(3)
          ,Fields.InvalidMessage_p_city_name(1),Fields.InvalidMessage_p_city_name(2),Fields.InvalidMessage_p_city_name(3)
          ,Fields.InvalidMessage_v_city_name(1),Fields.InvalidMessage_v_city_name(2),Fields.InvalidMessage_v_city_name(3)
          ,Fields.InvalidMessage_st(1),Fields.InvalidMessage_st(2)
          ,Fields.InvalidMessage_zip5(1),Fields.InvalidMessage_zip5(2)
          ,Fields.InvalidMessage_zip4(1),Fields.InvalidMessage_zip4(2)
          ,Fields.InvalidMessage_ace_fips_st(1),Fields.InvalidMessage_ace_fips_st(2)
          ,Fields.InvalidMessage_bdid(1),Fields.InvalidMessage_bdid(2)
          ,Fields.InvalidMessage_fein(1),Fields.InvalidMessage_fein(2)
          ,Fields.InvalidMessage_did(1),Fields.InvalidMessage_did(2)
          ,Fields.InvalidMessage_ssn(1),Fields.InvalidMessage_ssn(2)
          ,Fields.InvalidMessage_history_flag(1),Fields.InvalidMessage_history_flag(2)
          ,Fields.InvalidMessage_rawaid(1),Fields.InvalidMessage_rawaid(2)
          ,Fields.InvalidMessage_persistent_record_id(1),Fields.InvalidMessage_persistent_record_id(2)
          ,Fields.InvalidMessage_source_rec_id(1),Fields.InvalidMessage_source_rec_id(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_Watercraft_Search) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT311.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT311.StrType)le.date_vendor_last_reported);
    SELF.watercraft_key_Invalid := Fields.InValid_watercraft_key((SALT311.StrType)le.watercraft_key);
    SELF.state_origin_Invalid := Fields.InValid_state_origin((SALT311.StrType)le.state_origin);
    SELF.source_code_Invalid := Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.dppa_flag_Invalid := Fields.InValid_dppa_flag((SALT311.StrType)le.dppa_flag);
    SELF.orig_name_type_code_Invalid := Fields.InValid_orig_name_type_code((SALT311.StrType)le.orig_name_type_code);
    SELF.dob_Invalid := Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.phone_1_Invalid := Fields.InValid_phone_1((SALT311.StrType)le.phone_1);
    SELF.phone_2_Invalid := Fields.InValid_phone_2((SALT311.StrType)le.phone_2);
    SELF.fname_Invalid := Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT311.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT311.StrType)le.name_suffix);
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT311.StrType)le.company_name);
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
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT311.StrType)le.zip5);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.ace_fips_st_Invalid := Fields.InValid_ace_fips_st((SALT311.StrType)le.ace_fips_st);
    SELF.bdid_Invalid := Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.fein_Invalid := Fields.InValid_fein((SALT311.StrType)le.fein);
    SELF.did_Invalid := Fields.InValid_did((SALT311.StrType)le.did);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT311.StrType)le.ssn);
    SELF.history_flag_Invalid := Fields.InValid_history_flag((SALT311.StrType)le.history_flag);
    SELF.rawaid_Invalid := Fields.InValid_rawaid((SALT311.StrType)le.rawaid);
    SELF.persistent_record_id_Invalid := Fields.InValid_persistent_record_id((SALT311.StrType)le.persistent_record_id);
    SELF.source_rec_id_Invalid := Fields.InValid_source_rec_id((SALT311.StrType)le.source_rec_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Watercraft_Search);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.date_first_seen_Invalid << 0 ) + ( le.date_last_seen_Invalid << 1 ) + ( le.date_vendor_first_reported_Invalid << 2 ) + ( le.date_vendor_last_reported_Invalid << 3 ) + ( le.watercraft_key_Invalid << 4 ) + ( le.state_origin_Invalid << 5 ) + ( le.source_code_Invalid << 7 ) + ( le.dppa_flag_Invalid << 9 ) + ( le.orig_name_type_code_Invalid << 11 ) + ( le.dob_Invalid << 13 ) + ( le.phone_1_Invalid << 14 ) + ( le.phone_2_Invalid << 16 ) + ( le.fname_Invalid << 18 ) + ( le.mname_Invalid << 20 ) + ( le.lname_Invalid << 22 ) + ( le.name_suffix_Invalid << 24 ) + ( le.company_name_Invalid << 26 ) + ( le.prim_range_Invalid << 28 ) + ( le.predir_Invalid << 30 ) + ( le.prim_name_Invalid << 32 ) + ( le.suffix_Invalid << 34 ) + ( le.postdir_Invalid << 36 ) + ( le.unit_desig_Invalid << 38 ) + ( le.sec_range_Invalid << 40 ) + ( le.p_city_name_Invalid << 42 ) + ( le.v_city_name_Invalid << 44 ) + ( le.st_Invalid << 46 ) + ( le.zip5_Invalid << 48 ) + ( le.zip4_Invalid << 50 ) + ( le.ace_fips_st_Invalid << 52 ) + ( le.bdid_Invalid << 54 ) + ( le.fein_Invalid << 56 ) + ( le.did_Invalid << 58 ) + ( le.ssn_Invalid << 60 ) + ( le.history_flag_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.rawaid_Invalid << 0 ) + ( le.persistent_record_id_Invalid << 2 ) + ( le.source_rec_id_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0 OR (mask&le.ScrubsBits2)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND le.ScrubsBits2=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,Layout_Watercraft_Search);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.date_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.date_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.watercraft_key_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.dppa_flag_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.orig_name_type_code_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.phone_1_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.phone_2_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.mname_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.name_suffix_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.prim_range_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.prim_name_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.unit_desig_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.sec_range_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.p_city_name_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.v_city_name_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.st_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.ace_fips_st_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.fein_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.did_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.history_flag_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.rawaid_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.persistent_record_id_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.source_rec_id_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.source_code) source_code := IF(Glob, '', h.source_code);
    TotalCnt := COUNT(GROUP); // Number of records in total
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    watercraft_key_LENGTHS_ErrorCount := COUNT(GROUP,h.watercraft_key_Invalid=1);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    state_origin_LENGTHS_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=2);
    state_origin_Total_ErrorCount := COUNT(GROUP,h.state_origin_Invalid>0);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    source_code_LENGTHS_ErrorCount := COUNT(GROUP,h.source_code_Invalid=2);
    source_code_Total_ErrorCount := COUNT(GROUP,h.source_code_Invalid>0);
    dppa_flag_ENUM_ErrorCount := COUNT(GROUP,h.dppa_flag_Invalid=1);
    dppa_flag_LENGTHS_ErrorCount := COUNT(GROUP,h.dppa_flag_Invalid=2);
    dppa_flag_Total_ErrorCount := COUNT(GROUP,h.dppa_flag_Invalid>0);
    orig_name_type_code_ENUM_ErrorCount := COUNT(GROUP,h.orig_name_type_code_Invalid=1);
    orig_name_type_code_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_name_type_code_Invalid=2);
    orig_name_type_code_Total_ErrorCount := COUNT(GROUP,h.orig_name_type_code_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    phone_1_ALLOW_ErrorCount := COUNT(GROUP,h.phone_1_Invalid=1);
    phone_1_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_1_Invalid=2);
    phone_1_Total_ErrorCount := COUNT(GROUP,h.phone_1_Invalid>0);
    phone_2_ALLOW_ErrorCount := COUNT(GROUP,h.phone_2_Invalid=1);
    phone_2_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_2_Invalid=2);
    phone_2_Total_ErrorCount := COUNT(GROUP,h.phone_2_Invalid>0);
    fname_CAPS_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_LENGTHS_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_CAPS_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_LENGTHS_ErrorCount := COUNT(GROUP,h.mname_Invalid=3);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_LENGTHS_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_CAPS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    company_name_CAPS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=2);
    company_name_LENGTHS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=3);
    company_name_Total_ErrorCount := COUNT(GROUP,h.company_name_Invalid>0);
    prim_range_CAPS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_LENGTHS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=3);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    predir_CAPS_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_LENGTHS_ErrorCount := COUNT(GROUP,h.predir_Invalid=3);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_CAPS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_LENGTHS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=3);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    suffix_CAPS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=3);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    postdir_CAPS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_LENGTHS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=3);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_CAPS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_LENGTHS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=3);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_CAPS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_LENGTHS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=3);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_CAPS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_LENGTHS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=3);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_CAPS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_LENGTHS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=3);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTHS_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTHS_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=1);
    ace_fips_st_LENGTHS_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=2);
    ace_fips_st_Total_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid>0);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_LENGTHS_ErrorCount := COUNT(GROUP,h.bdid_Invalid=2);
    bdid_Total_ErrorCount := COUNT(GROUP,h.bdid_Invalid>0);
    fein_ALLOW_ErrorCount := COUNT(GROUP,h.fein_Invalid=1);
    fein_LENGTHS_ErrorCount := COUNT(GROUP,h.fein_Invalid=2);
    fein_Total_ErrorCount := COUNT(GROUP,h.fein_Invalid>0);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_LENGTHS_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTHS_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    history_flag_ENUM_ErrorCount := COUNT(GROUP,h.history_flag_Invalid=1);
    history_flag_LENGTHS_ErrorCount := COUNT(GROUP,h.history_flag_Invalid=2);
    history_flag_Total_ErrorCount := COUNT(GROUP,h.history_flag_Invalid>0);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_LENGTHS_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    persistent_record_id_ALLOW_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
    persistent_record_id_LENGTHS_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=2);
    persistent_record_id_Total_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid>0);
    source_rec_id_ALLOW_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    source_rec_id_LENGTHS_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=2);
    source_rec_id_Total_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.date_vendor_first_reported_Invalid > 0 OR h.date_vendor_last_reported_Invalid > 0 OR h.watercraft_key_Invalid > 0 OR h.state_origin_Invalid > 0 OR h.source_code_Invalid > 0 OR h.dppa_flag_Invalid > 0 OR h.orig_name_type_code_Invalid > 0 OR h.dob_Invalid > 0 OR h.phone_1_Invalid > 0 OR h.phone_2_Invalid > 0 OR h.fname_Invalid > 0 OR h.mname_Invalid > 0 OR h.lname_Invalid > 0 OR h.name_suffix_Invalid > 0 OR h.company_name_Invalid > 0 OR h.prim_range_Invalid > 0 OR h.predir_Invalid > 0 OR h.prim_name_Invalid > 0 OR h.suffix_Invalid > 0 OR h.postdir_Invalid > 0 OR h.unit_desig_Invalid > 0 OR h.sec_range_Invalid > 0 OR h.p_city_name_Invalid > 0 OR h.v_city_name_Invalid > 0 OR h.st_Invalid > 0 OR h.zip5_Invalid > 0 OR h.zip4_Invalid > 0 OR h.ace_fips_st_Invalid > 0 OR h.bdid_Invalid > 0 OR h.fein_Invalid > 0 OR h.did_Invalid > 0 OR h.ssn_Invalid > 0 OR h.history_flag_Invalid > 0 OR h.rawaid_Invalid > 0 OR h.persistent_record_id_Invalid > 0 OR h.source_rec_id_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,source_code,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.date_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.watercraft_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_origin_Total_ErrorCount > 0, 1, 0) + IF(le.source_code_Total_ErrorCount > 0, 1, 0) + IF(le.dppa_flag_Total_ErrorCount > 0, 1, 0) + IF(le.orig_name_type_code_Total_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_1_Total_ErrorCount > 0, 1, 0) + IF(le.phone_2_Total_ErrorCount > 0, 1, 0) + IF(le.fname_Total_ErrorCount > 0, 1, 0) + IF(le.mname_Total_ErrorCount > 0, 1, 0) + IF(le.lname_Total_ErrorCount > 0, 1, 0) + IF(le.name_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.company_name_Total_ErrorCount > 0, 1, 0) + IF(le.prim_range_Total_ErrorCount > 0, 1, 0) + IF(le.predir_Total_ErrorCount > 0, 1, 0) + IF(le.prim_name_Total_ErrorCount > 0, 1, 0) + IF(le.suffix_Total_ErrorCount > 0, 1, 0) + IF(le.postdir_Total_ErrorCount > 0, 1, 0) + IF(le.unit_desig_Total_ErrorCount > 0, 1, 0) + IF(le.sec_range_Total_ErrorCount > 0, 1, 0) + IF(le.p_city_name_Total_ErrorCount > 0, 1, 0) + IF(le.v_city_name_Total_ErrorCount > 0, 1, 0) + IF(le.st_Total_ErrorCount > 0, 1, 0) + IF(le.zip5_Total_ErrorCount > 0, 1, 0) + IF(le.zip4_Total_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_Total_ErrorCount > 0, 1, 0) + IF(le.bdid_Total_ErrorCount > 0, 1, 0) + IF(le.fein_Total_ErrorCount > 0, 1, 0) + IF(le.did_Total_ErrorCount > 0, 1, 0) + IF(le.ssn_Total_ErrorCount > 0, 1, 0) + IF(le.history_flag_Total_ErrorCount > 0, 1, 0) + IF(le.rawaid_Total_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_Total_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.date_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.watercraft_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dppa_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.dppa_flag_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orig_name_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_name_type_code_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.phone_2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fname_CAPS_ErrorCount > 0, 1, 0) + IF(le.fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.mname_CAPS_ErrorCount > 0, 1, 0) + IF(le.mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lname_CAPS_ErrorCount > 0, 1, 0) + IF(le.lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_CAPS_ErrorCount > 0, 1, 0) + IF(le.name_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.company_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.company_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_range_CAPS_ErrorCount > 0, 1, 0) + IF(le.prim_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.predir_CAPS_ErrorCount > 0, 1, 0) + IF(le.predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.predir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prim_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.prim_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.prim_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.suffix_CAPS_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.postdir_CAPS_ErrorCount > 0, 1, 0) + IF(le.postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postdir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.unit_desig_CAPS_ErrorCount > 0, 1, 0) + IF(le.unit_desig_ALLOW_ErrorCount > 0, 1, 0) + IF(le.unit_desig_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.sec_range_CAPS_ErrorCount > 0, 1, 0) + IF(le.sec_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sec_range_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_city_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.p_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.p_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.v_city_name_CAPS_ErrorCount > 0, 1, 0) + IF(le.v_city_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.v_city_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ace_fips_st_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bdid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fein_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fein_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.history_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.history_flag_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.rawaid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawaid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.persistent_record_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_rec_id_LENGTHS_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  le.source_code;
    UNSIGNED1 ErrNum := CHOOSE(c,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.date_vendor_first_reported_Invalid,le.date_vendor_last_reported_Invalid,le.watercraft_key_Invalid,le.state_origin_Invalid,le.source_code_Invalid,le.dppa_flag_Invalid,le.orig_name_type_code_Invalid,le.dob_Invalid,le.phone_1_Invalid,le.phone_2_Invalid,le.fname_Invalid,le.mname_Invalid,le.lname_Invalid,le.name_suffix_Invalid,le.company_name_Invalid,le.prim_range_Invalid,le.predir_Invalid,le.prim_name_Invalid,le.suffix_Invalid,le.postdir_Invalid,le.unit_desig_Invalid,le.sec_range_Invalid,le.p_city_name_Invalid,le.v_city_name_Invalid,le.st_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.ace_fips_st_Invalid,le.bdid_Invalid,le.fein_Invalid,le.did_Invalid,le.ssn_Invalid,le.history_flag_Invalid,le.rawaid_Invalid,le.persistent_record_id_Invalid,le.source_rec_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Fields.InvalidMessage_date_vendor_first_reported(le.date_vendor_first_reported_Invalid),Fields.InvalidMessage_date_vendor_last_reported(le.date_vendor_last_reported_Invalid),Fields.InvalidMessage_watercraft_key(le.watercraft_key_Invalid),Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Fields.InvalidMessage_source_code(le.source_code_Invalid),Fields.InvalidMessage_dppa_flag(le.dppa_flag_Invalid),Fields.InvalidMessage_orig_name_type_code(le.orig_name_type_code_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_phone_1(le.phone_1_Invalid),Fields.InvalidMessage_phone_2(le.phone_2_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),Fields.InvalidMessage_mname(le.mname_Invalid),Fields.InvalidMessage_lname(le.lname_Invalid),Fields.InvalidMessage_name_suffix(le.name_suffix_Invalid),Fields.InvalidMessage_company_name(le.company_name_Invalid),Fields.InvalidMessage_prim_range(le.prim_range_Invalid),Fields.InvalidMessage_predir(le.predir_Invalid),Fields.InvalidMessage_prim_name(le.prim_name_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_postdir(le.postdir_Invalid),Fields.InvalidMessage_unit_desig(le.unit_desig_Invalid),Fields.InvalidMessage_sec_range(le.sec_range_Invalid),Fields.InvalidMessage_p_city_name(le.p_city_name_Invalid),Fields.InvalidMessage_v_city_name(le.v_city_name_Invalid),Fields.InvalidMessage_st(le.st_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_ace_fips_st(le.ace_fips_st_Invalid),Fields.InvalidMessage_bdid(le.bdid_Invalid),Fields.InvalidMessage_fein(le.fein_Invalid),Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_history_flag(le.history_flag_Invalid),Fields.InvalidMessage_rawaid(le.rawaid_Invalid),Fields.InvalidMessage_persistent_record_id(le.persistent_record_id_Invalid),Fields.InvalidMessage_source_rec_id(le.source_rec_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.date_first_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_vendor_first_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_vendor_last_reported_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.watercraft_key_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dppa_flag_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.orig_name_type_code_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_1_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.phone_2_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fein_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.history_flag_Invalid,'ENUM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','watercraft_key','state_origin','source_code','dppa_flag','orig_name_type_code','dob','phone_1','phone_2','fname','mname','lname','name_suffix','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','ace_fips_st','bdid','fein','did','ssn','history_flag','rawaid','persistent_record_id','source_rec_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_blank','invalid_state','invalid_source_code','invalid_dppa_flag','invalid_owner_type','invalid_date','invalid_phone','invalid_phone','invalid_name','invalid_name','invalid_name','invalid_name','invalid_company','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alpha','invalid_state','invalid_numeric','invalid_numeric','invalid_fips','invalid_numeric','invalid_ssn_fein','invalid_numeric','invalid_ssn_fein','invalid_history_flag','invalid_numeric','invalid_numeric','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.date_vendor_first_reported,(SALT311.StrType)le.date_vendor_last_reported,(SALT311.StrType)le.watercraft_key,(SALT311.StrType)le.state_origin,(SALT311.StrType)le.source_code,(SALT311.StrType)le.dppa_flag,(SALT311.StrType)le.orig_name_type_code,(SALT311.StrType)le.dob,(SALT311.StrType)le.phone_1,(SALT311.StrType)le.phone_2,(SALT311.StrType)le.fname,(SALT311.StrType)le.mname,(SALT311.StrType)le.lname,(SALT311.StrType)le.name_suffix,(SALT311.StrType)le.company_name,(SALT311.StrType)le.prim_range,(SALT311.StrType)le.predir,(SALT311.StrType)le.prim_name,(SALT311.StrType)le.suffix,(SALT311.StrType)le.postdir,(SALT311.StrType)le.unit_desig,(SALT311.StrType)le.sec_range,(SALT311.StrType)le.p_city_name,(SALT311.StrType)le.v_city_name,(SALT311.StrType)le.st,(SALT311.StrType)le.zip5,(SALT311.StrType)le.zip4,(SALT311.StrType)le.ace_fips_st,(SALT311.StrType)le.bdid,(SALT311.StrType)le.fein,(SALT311.StrType)le.did,(SALT311.StrType)le.ssn,(SALT311.StrType)le.history_flag,(SALT311.StrType)le.rawaid,(SALT311.StrType)le.persistent_record_id,(SALT311.StrType)le.source_rec_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,38,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Watercraft_Search) prevDS = DATASET([], Layout_Watercraft_Search)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_code;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.date_first_seen_ALLOW_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount
          ,le.watercraft_key_LENGTHS_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTHS_ErrorCount
          ,le.source_code_ALLOW_ErrorCount,le.source_code_LENGTHS_ErrorCount
          ,le.dppa_flag_ENUM_ErrorCount,le.dppa_flag_LENGTHS_ErrorCount
          ,le.orig_name_type_code_ENUM_ErrorCount,le.orig_name_type_code_LENGTHS_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.phone_1_ALLOW_ErrorCount,le.phone_1_LENGTHS_ErrorCount
          ,le.phone_2_ALLOW_ErrorCount,le.phone_2_LENGTHS_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTHS_ErrorCount
          ,le.mname_CAPS_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTHS_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTHS_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTHS_ErrorCount
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount,le.company_name_LENGTHS_ErrorCount
          ,le.prim_range_CAPS_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTHS_ErrorCount
          ,le.predir_CAPS_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTHS_ErrorCount
          ,le.prim_name_CAPS_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTHS_ErrorCount
          ,le.suffix_CAPS_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTHS_ErrorCount
          ,le.postdir_CAPS_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTHS_ErrorCount
          ,le.unit_desig_CAPS_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTHS_ErrorCount
          ,le.sec_range_CAPS_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTHS_ErrorCount
          ,le.p_city_name_CAPS_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTHS_ErrorCount
          ,le.v_city_name_CAPS_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTHS_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount,le.ace_fips_st_LENGTHS_ErrorCount
          ,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTHS_ErrorCount
          ,le.fein_ALLOW_ErrorCount,le.fein_LENGTHS_ErrorCount
          ,le.did_ALLOW_ErrorCount,le.did_LENGTHS_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.history_flag_ENUM_ErrorCount,le.history_flag_LENGTHS_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTHS_ErrorCount
          ,le.persistent_record_id_ALLOW_ErrorCount,le.persistent_record_id_LENGTHS_ErrorCount
          ,le.source_rec_id_ALLOW_ErrorCount,le.source_rec_id_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.date_first_seen_ALLOW_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount
          ,le.watercraft_key_LENGTHS_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTHS_ErrorCount
          ,le.source_code_ALLOW_ErrorCount,le.source_code_LENGTHS_ErrorCount
          ,le.dppa_flag_ENUM_ErrorCount,le.dppa_flag_LENGTHS_ErrorCount
          ,le.orig_name_type_code_ENUM_ErrorCount,le.orig_name_type_code_LENGTHS_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.phone_1_ALLOW_ErrorCount,le.phone_1_LENGTHS_ErrorCount
          ,le.phone_2_ALLOW_ErrorCount,le.phone_2_LENGTHS_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTHS_ErrorCount
          ,le.mname_CAPS_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTHS_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTHS_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTHS_ErrorCount
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount,le.company_name_LENGTHS_ErrorCount
          ,le.prim_range_CAPS_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTHS_ErrorCount
          ,le.predir_CAPS_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTHS_ErrorCount
          ,le.prim_name_CAPS_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTHS_ErrorCount
          ,le.suffix_CAPS_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTHS_ErrorCount
          ,le.postdir_CAPS_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTHS_ErrorCount
          ,le.unit_desig_CAPS_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTHS_ErrorCount
          ,le.sec_range_CAPS_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTHS_ErrorCount
          ,le.p_city_name_CAPS_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTHS_ErrorCount
          ,le.v_city_name_CAPS_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTHS_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTHS_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTHS_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTHS_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount,le.ace_fips_st_LENGTHS_ErrorCount
          ,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTHS_ErrorCount
          ,le.fein_ALLOW_ErrorCount,le.fein_LENGTHS_ErrorCount
          ,le.did_ALLOW_ErrorCount,le.did_LENGTHS_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTHS_ErrorCount
          ,le.history_flag_ENUM_ErrorCount,le.history_flag_LENGTHS_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTHS_ErrorCount
          ,le.persistent_record_id_ALLOW_ErrorCount,le.persistent_record_id_LENGTHS_ErrorCount
          ,le.source_rec_id_ALLOW_ErrorCount,le.source_rec_id_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_Watercraft_Search));
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
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_first_reported:' + getFieldTypeText(h.date_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_vendor_last_reported:' + getFieldTypeText(h.date_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'watercraft_key:' + getFieldTypeText(h.watercraft_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sequence_key:' + getFieldTypeText(h.sequence_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dppa_flag:' + getFieldTypeText(h.dppa_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name:' + getFieldTypeText(h.orig_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_type_code:' + getFieldTypeText(h.orig_name_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_type_description:' + getFieldTypeText(h.orig_name_type_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_first:' + getFieldTypeText(h.orig_name_first) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_middle:' + getFieldTypeText(h.orig_name_middle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_last:' + getFieldTypeText(h.orig_name_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_name_suffix:' + getFieldTypeText(h.orig_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address_1:' + getFieldTypeText(h.orig_address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address_2:' + getFieldTypeText(h.orig_address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fips:' + getFieldTypeText(h.orig_fips) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_province:' + getFieldTypeText(h.orig_province) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_country:' + getFieldTypeText(h.orig_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn:' + getFieldTypeText(h.orig_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fein:' + getFieldTypeText(h.orig_fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_1:' + getFieldTypeText(h.phone_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_2:' + getFieldTypeText(h.phone_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_cleaning_score:' + getFieldTypeText(h.name_cleaning_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_county:' + getFieldTypeText(h.ace_fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fein:' + getFieldTypeText(h.fein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'history_flag:' + getFieldTypeText(h.history_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawaid:' + getFieldTypeText(h.rawaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reg_owner_name_2:' + getFieldTypeText(h.reg_owner_name_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_rec_id:' + getFieldTypeText(h.source_rec_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'ultweight:' + getFieldTypeText(h.ultweight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_date_vendor_first_reported_cnt
          ,le.populated_date_vendor_last_reported_cnt
          ,le.populated_watercraft_key_cnt
          ,le.populated_sequence_key_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_source_code_cnt
          ,le.populated_dppa_flag_cnt
          ,le.populated_orig_name_cnt
          ,le.populated_orig_name_type_code_cnt
          ,le.populated_orig_name_type_description_cnt
          ,le.populated_orig_name_first_cnt
          ,le.populated_orig_name_middle_cnt
          ,le.populated_orig_name_last_cnt
          ,le.populated_orig_name_suffix_cnt
          ,le.populated_orig_address_1_cnt
          ,le.populated_orig_address_2_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_fips_cnt
          ,le.populated_orig_province_cnt
          ,le.populated_orig_country_cnt
          ,le.populated_dob_cnt
          ,le.populated_orig_ssn_cnt
          ,le.populated_orig_fein_cnt
          ,le.populated_gender_cnt
          ,le.populated_phone_1_cnt
          ,le.populated_phone_2_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_name_cleaning_score_cnt
          ,le.populated_company_name_cnt
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
          ,le.populated_zip5_cnt
          ,le.populated_zip4_cnt
          ,le.populated_county_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_ace_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_bdid_cnt
          ,le.populated_fein_cnt
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_ssn_cnt
          ,le.populated_history_flag_cnt
          ,le.populated_rawaid_cnt
          ,le.populated_reg_owner_name_2_cnt
          ,le.populated_persistent_record_id_cnt
          ,le.populated_source_rec_id_cnt
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
          ,le.populated_ultweight_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_date_vendor_first_reported_pcnt
          ,le.populated_date_vendor_last_reported_pcnt
          ,le.populated_watercraft_key_pcnt
          ,le.populated_sequence_key_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_dppa_flag_pcnt
          ,le.populated_orig_name_pcnt
          ,le.populated_orig_name_type_code_pcnt
          ,le.populated_orig_name_type_description_pcnt
          ,le.populated_orig_name_first_pcnt
          ,le.populated_orig_name_middle_pcnt
          ,le.populated_orig_name_last_pcnt
          ,le.populated_orig_name_suffix_pcnt
          ,le.populated_orig_address_1_pcnt
          ,le.populated_orig_address_2_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_fips_pcnt
          ,le.populated_orig_province_pcnt
          ,le.populated_orig_country_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_orig_ssn_pcnt
          ,le.populated_orig_fein_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_phone_1_pcnt
          ,le.populated_phone_2_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_name_cleaning_score_pcnt
          ,le.populated_company_name_pcnt
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
          ,le.populated_zip5_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_county_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_ace_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_fein_pcnt
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_history_flag_pcnt
          ,le.populated_rawaid_pcnt
          ,le.populated_reg_owner_name_2_pcnt
          ,le.populated_persistent_record_id_pcnt
          ,le.populated_source_rec_id_pcnt
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
          ,le.populated_ultweight_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,95,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Watercraft_Search));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),95,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_Watercraft_Search) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Watercraft_Search, Fields, 'RECORDOF(scrubsSummaryOverall)', 'source_code');
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
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, source_code, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
