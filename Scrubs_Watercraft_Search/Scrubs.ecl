IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_Watercraft_Search)
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
EXPORT FromNone(DATASET(Layout_Watercraft_Search) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_first_seen_Invalid := Fields.InValid_date_first_seen((SALT30.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Fields.InValid_date_last_seen((SALT30.StrType)le.date_last_seen);
    SELF.date_vendor_first_reported_Invalid := Fields.InValid_date_vendor_first_reported((SALT30.StrType)le.date_vendor_first_reported);
    SELF.date_vendor_last_reported_Invalid := Fields.InValid_date_vendor_last_reported((SALT30.StrType)le.date_vendor_last_reported);
    SELF.watercraft_key_Invalid := Fields.InValid_watercraft_key((SALT30.StrType)le.watercraft_key);
    SELF.state_origin_Invalid := Fields.InValid_state_origin((SALT30.StrType)le.state_origin);
    SELF.source_code_Invalid := Fields.InValid_source_code((SALT30.StrType)le.source_code);
    SELF.dppa_flag_Invalid := Fields.InValid_dppa_flag((SALT30.StrType)le.dppa_flag);
    SELF.orig_name_type_code_Invalid := Fields.InValid_orig_name_type_code((SALT30.StrType)le.orig_name_type_code);
    SELF.dob_Invalid := Fields.InValid_dob((SALT30.StrType)le.dob);
    SELF.phone_1_Invalid := Fields.InValid_phone_1((SALT30.StrType)le.phone_1);
    SELF.phone_2_Invalid := Fields.InValid_phone_2((SALT30.StrType)le.phone_2);
    SELF.fname_Invalid := Fields.InValid_fname((SALT30.StrType)le.fname);
    SELF.mname_Invalid := Fields.InValid_mname((SALT30.StrType)le.mname);
    SELF.lname_Invalid := Fields.InValid_lname((SALT30.StrType)le.lname);
    SELF.name_suffix_Invalid := Fields.InValid_name_suffix((SALT30.StrType)le.name_suffix);
    SELF.company_name_Invalid := Fields.InValid_company_name((SALT30.StrType)le.company_name);
    SELF.prim_range_Invalid := Fields.InValid_prim_range((SALT30.StrType)le.prim_range);
    SELF.predir_Invalid := Fields.InValid_predir((SALT30.StrType)le.predir);
    SELF.prim_name_Invalid := Fields.InValid_prim_name((SALT30.StrType)le.prim_name);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT30.StrType)le.suffix);
    SELF.postdir_Invalid := Fields.InValid_postdir((SALT30.StrType)le.postdir);
    SELF.unit_desig_Invalid := Fields.InValid_unit_desig((SALT30.StrType)le.unit_desig);
    SELF.sec_range_Invalid := Fields.InValid_sec_range((SALT30.StrType)le.sec_range);
    SELF.p_city_name_Invalid := Fields.InValid_p_city_name((SALT30.StrType)le.p_city_name);
    SELF.v_city_name_Invalid := Fields.InValid_v_city_name((SALT30.StrType)le.v_city_name);
    SELF.st_Invalid := Fields.InValid_st((SALT30.StrType)le.st);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT30.StrType)le.zip5);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT30.StrType)le.zip4);
    SELF.ace_fips_st_Invalid := Fields.InValid_ace_fips_st((SALT30.StrType)le.ace_fips_st);
    SELF.bdid_Invalid := Fields.InValid_bdid((SALT30.StrType)le.bdid);
    SELF.fein_Invalid := Fields.InValid_fein((SALT30.StrType)le.fein);
    SELF.did_Invalid := Fields.InValid_did((SALT30.StrType)le.did);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT30.StrType)le.ssn);
    SELF.history_flag_Invalid := Fields.InValid_history_flag((SALT30.StrType)le.history_flag);
    SELF.rawaid_Invalid := Fields.InValid_rawaid((SALT30.StrType)le.rawaid);
    SELF.persistent_record_id_Invalid := Fields.InValid_persistent_record_id((SALT30.StrType)le.persistent_record_id);
    SELF.source_rec_id_Invalid := Fields.InValid_source_rec_id((SALT30.StrType)le.source_rec_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.date_first_seen_Invalid << 0 ) + ( le.date_last_seen_Invalid << 1 ) + ( le.date_vendor_first_reported_Invalid << 2 ) + ( le.date_vendor_last_reported_Invalid << 3 ) + ( le.watercraft_key_Invalid << 4 ) + ( le.state_origin_Invalid << 5 ) + ( le.source_code_Invalid << 7 ) + ( le.dppa_flag_Invalid << 9 ) + ( le.orig_name_type_code_Invalid << 11 ) + ( le.dob_Invalid << 13 ) + ( le.phone_1_Invalid << 14 ) + ( le.phone_2_Invalid << 16 ) + ( le.fname_Invalid << 18 ) + ( le.mname_Invalid << 20 ) + ( le.lname_Invalid << 22 ) + ( le.name_suffix_Invalid << 24 ) + ( le.company_name_Invalid << 26 ) + ( le.prim_range_Invalid << 28 ) + ( le.predir_Invalid << 30 ) + ( le.prim_name_Invalid << 32 ) + ( le.suffix_Invalid << 34 ) + ( le.postdir_Invalid << 36 ) + ( le.unit_desig_Invalid << 38 ) + ( le.sec_range_Invalid << 40 ) + ( le.p_city_name_Invalid << 42 ) + ( le.v_city_name_Invalid << 44 ) + ( le.st_Invalid << 46 ) + ( le.zip5_Invalid << 48 ) + ( le.zip4_Invalid << 50 ) + ( le.ace_fips_st_Invalid << 52 ) + ( le.bdid_Invalid << 54 ) + ( le.fein_Invalid << 56 ) + ( le.did_Invalid << 58 ) + ( le.ssn_Invalid << 60 ) + ( le.history_flag_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.rawaid_Invalid << 0 ) + ( le.persistent_record_id_Invalid << 2 ) + ( le.source_rec_id_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
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
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.source_code;
    TotalCnt := COUNT(GROUP); // Number of records in total
    date_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    date_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_first_reported_Invalid=1);
    date_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.date_vendor_last_reported_Invalid=1);
    watercraft_key_LENGTH_ErrorCount := COUNT(GROUP,h.watercraft_key_Invalid=1);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    state_origin_LENGTH_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=2);
    state_origin_Total_ErrorCount := COUNT(GROUP,h.state_origin_Invalid>0);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    source_code_LENGTH_ErrorCount := COUNT(GROUP,h.source_code_Invalid=2);
    source_code_Total_ErrorCount := COUNT(GROUP,h.source_code_Invalid>0);
    dppa_flag_ENUM_ErrorCount := COUNT(GROUP,h.dppa_flag_Invalid=1);
    dppa_flag_LENGTH_ErrorCount := COUNT(GROUP,h.dppa_flag_Invalid=2);
    dppa_flag_Total_ErrorCount := COUNT(GROUP,h.dppa_flag_Invalid>0);
    orig_name_type_code_ENUM_ErrorCount := COUNT(GROUP,h.orig_name_type_code_Invalid=1);
    orig_name_type_code_LENGTH_ErrorCount := COUNT(GROUP,h.orig_name_type_code_Invalid=2);
    orig_name_type_code_Total_ErrorCount := COUNT(GROUP,h.orig_name_type_code_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    phone_1_ALLOW_ErrorCount := COUNT(GROUP,h.phone_1_Invalid=1);
    phone_1_LENGTH_ErrorCount := COUNT(GROUP,h.phone_1_Invalid=2);
    phone_1_Total_ErrorCount := COUNT(GROUP,h.phone_1_Invalid>0);
    phone_2_ALLOW_ErrorCount := COUNT(GROUP,h.phone_2_Invalid=1);
    phone_2_LENGTH_ErrorCount := COUNT(GROUP,h.phone_2_Invalid=2);
    phone_2_Total_ErrorCount := COUNT(GROUP,h.phone_2_Invalid>0);
    fname_CAPS_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    fname_ALLOW_ErrorCount := COUNT(GROUP,h.fname_Invalid=2);
    fname_LENGTH_ErrorCount := COUNT(GROUP,h.fname_Invalid=3);
    fname_Total_ErrorCount := COUNT(GROUP,h.fname_Invalid>0);
    mname_CAPS_ErrorCount := COUNT(GROUP,h.mname_Invalid=1);
    mname_ALLOW_ErrorCount := COUNT(GROUP,h.mname_Invalid=2);
    mname_LENGTH_ErrorCount := COUNT(GROUP,h.mname_Invalid=3);
    mname_Total_ErrorCount := COUNT(GROUP,h.mname_Invalid>0);
    lname_CAPS_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    lname_ALLOW_ErrorCount := COUNT(GROUP,h.lname_Invalid=2);
    lname_LENGTH_ErrorCount := COUNT(GROUP,h.lname_Invalid=3);
    lname_Total_ErrorCount := COUNT(GROUP,h.lname_Invalid>0);
    name_suffix_CAPS_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=1);
    name_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=2);
    name_suffix_LENGTH_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid=3);
    name_suffix_Total_ErrorCount := COUNT(GROUP,h.name_suffix_Invalid>0);
    company_name_CAPS_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    company_name_ALLOW_ErrorCount := COUNT(GROUP,h.company_name_Invalid=2);
    company_name_LENGTH_ErrorCount := COUNT(GROUP,h.company_name_Invalid=3);
    company_name_Total_ErrorCount := COUNT(GROUP,h.company_name_Invalid>0);
    prim_range_CAPS_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=1);
    prim_range_ALLOW_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=2);
    prim_range_LENGTH_ErrorCount := COUNT(GROUP,h.prim_range_Invalid=3);
    prim_range_Total_ErrorCount := COUNT(GROUP,h.prim_range_Invalid>0);
    predir_CAPS_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    predir_ALLOW_ErrorCount := COUNT(GROUP,h.predir_Invalid=2);
    predir_LENGTH_ErrorCount := COUNT(GROUP,h.predir_Invalid=3);
    predir_Total_ErrorCount := COUNT(GROUP,h.predir_Invalid>0);
    prim_name_CAPS_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=1);
    prim_name_ALLOW_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=2);
    prim_name_LENGTH_ErrorCount := COUNT(GROUP,h.prim_name_Invalid=3);
    prim_name_Total_ErrorCount := COUNT(GROUP,h.prim_name_Invalid>0);
    suffix_CAPS_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_LENGTH_ErrorCount := COUNT(GROUP,h.suffix_Invalid=3);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    postdir_CAPS_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    postdir_ALLOW_ErrorCount := COUNT(GROUP,h.postdir_Invalid=2);
    postdir_LENGTH_ErrorCount := COUNT(GROUP,h.postdir_Invalid=3);
    postdir_Total_ErrorCount := COUNT(GROUP,h.postdir_Invalid>0);
    unit_desig_CAPS_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=1);
    unit_desig_ALLOW_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=2);
    unit_desig_LENGTH_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid=3);
    unit_desig_Total_ErrorCount := COUNT(GROUP,h.unit_desig_Invalid>0);
    sec_range_CAPS_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=1);
    sec_range_ALLOW_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=2);
    sec_range_LENGTH_ErrorCount := COUNT(GROUP,h.sec_range_Invalid=3);
    sec_range_Total_ErrorCount := COUNT(GROUP,h.sec_range_Invalid>0);
    p_city_name_CAPS_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=1);
    p_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=2);
    p_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid=3);
    p_city_name_Total_ErrorCount := COUNT(GROUP,h.p_city_name_Invalid>0);
    v_city_name_CAPS_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=1);
    v_city_name_ALLOW_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=2);
    v_city_name_LENGTH_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid=3);
    v_city_name_Total_ErrorCount := COUNT(GROUP,h.v_city_name_Invalid>0);
    st_ALLOW_ErrorCount := COUNT(GROUP,h.st_Invalid=1);
    st_LENGTH_ErrorCount := COUNT(GROUP,h.st_Invalid=2);
    st_Total_ErrorCount := COUNT(GROUP,h.st_Invalid>0);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_LENGTH_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    zip4_LENGTH_ErrorCount := COUNT(GROUP,h.zip4_Invalid=2);
    zip4_Total_ErrorCount := COUNT(GROUP,h.zip4_Invalid>0);
    ace_fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=1);
    ace_fips_st_LENGTH_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid=2);
    ace_fips_st_Total_ErrorCount := COUNT(GROUP,h.ace_fips_st_Invalid>0);
    bdid_ALLOW_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    bdid_LENGTH_ErrorCount := COUNT(GROUP,h.bdid_Invalid=2);
    bdid_Total_ErrorCount := COUNT(GROUP,h.bdid_Invalid>0);
    fein_ALLOW_ErrorCount := COUNT(GROUP,h.fein_Invalid=1);
    fein_LENGTH_ErrorCount := COUNT(GROUP,h.fein_Invalid=2);
    fein_Total_ErrorCount := COUNT(GROUP,h.fein_Invalid>0);
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_LENGTH_ErrorCount := COUNT(GROUP,h.did_Invalid=2);
    did_Total_ErrorCount := COUNT(GROUP,h.did_Invalid>0);
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=2);
    ssn_Total_ErrorCount := COUNT(GROUP,h.ssn_Invalid>0);
    history_flag_ENUM_ErrorCount := COUNT(GROUP,h.history_flag_Invalid=1);
    history_flag_LENGTH_ErrorCount := COUNT(GROUP,h.history_flag_Invalid=2);
    history_flag_Total_ErrorCount := COUNT(GROUP,h.history_flag_Invalid>0);
    rawaid_ALLOW_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=1);
    rawaid_LENGTH_ErrorCount := COUNT(GROUP,h.rawaid_Invalid=2);
    rawaid_Total_ErrorCount := COUNT(GROUP,h.rawaid_Invalid>0);
    persistent_record_id_ALLOW_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=1);
    persistent_record_id_LENGTH_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid=2);
    persistent_record_id_Total_ErrorCount := COUNT(GROUP,h.persistent_record_id_Invalid>0);
    source_rec_id_ALLOW_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=1);
    source_rec_id_LENGTH_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid=2);
    source_rec_id_Total_ErrorCount := COUNT(GROUP,h.source_rec_id_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r,source_code,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
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
          ,CHOOSE(le.watercraft_key_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dppa_flag_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_name_type_code_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.mname_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.name_suffix_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.prim_range_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.prim_name_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.unit_desig_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sec_range_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.p_city_name_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.v_city_name_Invalid,'CAPS','ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ace_fips_st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fein_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.history_flag_Invalid,'ENUM','LENGTH','UNKNOWN')
          ,CHOOSE(le.rawaid_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.persistent_record_id_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.source_rec_id_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'date_first_seen','date_last_seen','date_vendor_first_reported','date_vendor_last_reported','watercraft_key','state_origin','source_code','dppa_flag','orig_name_type_code','dob','phone_1','phone_2','fname','mname','lname','name_suffix','company_name','prim_range','predir','prim_name','suffix','postdir','unit_desig','sec_range','p_city_name','v_city_name','st','zip5','zip4','ace_fips_st','bdid','fein','did','ssn','history_flag','rawaid','persistent_record_id','source_rec_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_blank','invalid_state','invalid_source_code','invalid_dppa_flag','invalid_owner_type','invalid_date','invalid_phone','invalid_phone','invalid_name','invalid_name','invalid_name','invalid_name','invalid_company','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_alpha','invalid_alpha','invalid_state','invalid_numeric','invalid_numeric','invalid_fips','invalid_numeric','invalid_ssn_fein','invalid_numeric','invalid_ssn_fein','invalid_history_flag','invalid_numeric','invalid_numeric','invalid_numeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.date_first_seen,(SALT30.StrType)le.date_last_seen,(SALT30.StrType)le.date_vendor_first_reported,(SALT30.StrType)le.date_vendor_last_reported,(SALT30.StrType)le.watercraft_key,(SALT30.StrType)le.state_origin,(SALT30.StrType)le.source_code,(SALT30.StrType)le.dppa_flag,(SALT30.StrType)le.orig_name_type_code,(SALT30.StrType)le.dob,(SALT30.StrType)le.phone_1,(SALT30.StrType)le.phone_2,(SALT30.StrType)le.fname,(SALT30.StrType)le.mname,(SALT30.StrType)le.lname,(SALT30.StrType)le.name_suffix,(SALT30.StrType)le.company_name,(SALT30.StrType)le.prim_range,(SALT30.StrType)le.predir,(SALT30.StrType)le.prim_name,(SALT30.StrType)le.suffix,(SALT30.StrType)le.postdir,(SALT30.StrType)le.unit_desig,(SALT30.StrType)le.sec_range,(SALT30.StrType)le.p_city_name,(SALT30.StrType)le.v_city_name,(SALT30.StrType)le.st,(SALT30.StrType)le.zip5,(SALT30.StrType)le.zip4,(SALT30.StrType)le.ace_fips_st,(SALT30.StrType)le.bdid,(SALT30.StrType)le.fein,(SALT30.StrType)le.did,(SALT30.StrType)le.ssn,(SALT30.StrType)le.history_flag,(SALT30.StrType)le.rawaid,(SALT30.StrType)le.persistent_record_id,(SALT30.StrType)le.source_rec_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,38,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.source_code;
      SELF.ruledesc := CHOOSE(c
          ,'date_first_seen:invalid_date:ALLOW'
          ,'date_last_seen:invalid_date:ALLOW'
          ,'date_vendor_first_reported:invalid_date:ALLOW'
          ,'date_vendor_last_reported:invalid_date:ALLOW'
          ,'watercraft_key:invalid_blank:LENGTH'
          ,'state_origin:invalid_state:ALLOW','state_origin:invalid_state:LENGTH'
          ,'source_code:invalid_source_code:ALLOW','source_code:invalid_source_code:LENGTH'
          ,'dppa_flag:invalid_dppa_flag:ENUM','dppa_flag:invalid_dppa_flag:LENGTH'
          ,'orig_name_type_code:invalid_owner_type:ENUM','orig_name_type_code:invalid_owner_type:LENGTH'
          ,'dob:invalid_date:ALLOW'
          ,'phone_1:invalid_phone:ALLOW','phone_1:invalid_phone:LENGTH'
          ,'phone_2:invalid_phone:ALLOW','phone_2:invalid_phone:LENGTH'
          ,'fname:invalid_name:CAPS','fname:invalid_name:ALLOW','fname:invalid_name:LENGTH'
          ,'mname:invalid_name:CAPS','mname:invalid_name:ALLOW','mname:invalid_name:LENGTH'
          ,'lname:invalid_name:CAPS','lname:invalid_name:ALLOW','lname:invalid_name:LENGTH'
          ,'name_suffix:invalid_name:CAPS','name_suffix:invalid_name:ALLOW','name_suffix:invalid_name:LENGTH'
          ,'company_name:invalid_company:CAPS','company_name:invalid_company:ALLOW','company_name:invalid_company:LENGTH'
          ,'prim_range:invalid_address:CAPS','prim_range:invalid_address:ALLOW','prim_range:invalid_address:LENGTH'
          ,'predir:invalid_address:CAPS','predir:invalid_address:ALLOW','predir:invalid_address:LENGTH'
          ,'prim_name:invalid_address:CAPS','prim_name:invalid_address:ALLOW','prim_name:invalid_address:LENGTH'
          ,'suffix:invalid_address:CAPS','suffix:invalid_address:ALLOW','suffix:invalid_address:LENGTH'
          ,'postdir:invalid_address:CAPS','postdir:invalid_address:ALLOW','postdir:invalid_address:LENGTH'
          ,'unit_desig:invalid_address:CAPS','unit_desig:invalid_address:ALLOW','unit_desig:invalid_address:LENGTH'
          ,'sec_range:invalid_address:CAPS','sec_range:invalid_address:ALLOW','sec_range:invalid_address:LENGTH'
          ,'p_city_name:invalid_alpha:CAPS','p_city_name:invalid_alpha:ALLOW','p_city_name:invalid_alpha:LENGTH'
          ,'v_city_name:invalid_alpha:CAPS','v_city_name:invalid_alpha:ALLOW','v_city_name:invalid_alpha:LENGTH'
          ,'st:invalid_state:ALLOW','st:invalid_state:LENGTH'
          ,'zip5:invalid_numeric:ALLOW','zip5:invalid_numeric:LENGTH'
          ,'zip4:invalid_numeric:ALLOW','zip4:invalid_numeric:LENGTH'
          ,'ace_fips_st:invalid_fips:ALLOW','ace_fips_st:invalid_fips:LENGTH'
          ,'bdid:invalid_numeric:ALLOW','bdid:invalid_numeric:LENGTH'
          ,'fein:invalid_ssn_fein:ALLOW','fein:invalid_ssn_fein:LENGTH'
          ,'did:invalid_numeric:ALLOW','did:invalid_numeric:LENGTH'
          ,'ssn:invalid_ssn_fein:ALLOW','ssn:invalid_ssn_fein:LENGTH'
          ,'history_flag:invalid_history_flag:ENUM','history_flag:invalid_history_flag:LENGTH'
          ,'rawaid:invalid_numeric:ALLOW','rawaid:invalid_numeric:LENGTH'
          ,'persistent_record_id:invalid_numeric:ALLOW','persistent_record_id:invalid_numeric:LENGTH'
          ,'source_rec_id:invalid_numeric:ALLOW','source_rec_id:invalid_numeric:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.date_first_seen_ALLOW_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount
          ,le.watercraft_key_LENGTH_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTH_ErrorCount
          ,le.source_code_ALLOW_ErrorCount,le.source_code_LENGTH_ErrorCount
          ,le.dppa_flag_ENUM_ErrorCount,le.dppa_flag_LENGTH_ErrorCount
          ,le.orig_name_type_code_ENUM_ErrorCount,le.orig_name_type_code_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.phone_1_ALLOW_ErrorCount,le.phone_1_LENGTH_ErrorCount
          ,le.phone_2_ALLOW_ErrorCount,le.phone_2_LENGTH_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_CAPS_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount,le.company_name_LENGTH_ErrorCount
          ,le.prim_range_CAPS_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTH_ErrorCount
          ,le.predir_CAPS_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount
          ,le.prim_name_CAPS_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount
          ,le.suffix_CAPS_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount
          ,le.postdir_CAPS_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount
          ,le.unit_desig_CAPS_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount
          ,le.sec_range_CAPS_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount
          ,le.p_city_name_CAPS_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount
          ,le.v_city_name_CAPS_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount,le.ace_fips_st_LENGTH_ErrorCount
          ,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTH_ErrorCount
          ,le.fein_ALLOW_ErrorCount,le.fein_LENGTH_ErrorCount
          ,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.history_flag_ENUM_ErrorCount,le.history_flag_LENGTH_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount
          ,le.persistent_record_id_ALLOW_ErrorCount,le.persistent_record_id_LENGTH_ErrorCount
          ,le.source_rec_id_ALLOW_ErrorCount,le.source_rec_id_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.date_first_seen_ALLOW_ErrorCount
          ,le.date_last_seen_ALLOW_ErrorCount
          ,le.date_vendor_first_reported_ALLOW_ErrorCount
          ,le.date_vendor_last_reported_ALLOW_ErrorCount
          ,le.watercraft_key_LENGTH_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTH_ErrorCount
          ,le.source_code_ALLOW_ErrorCount,le.source_code_LENGTH_ErrorCount
          ,le.dppa_flag_ENUM_ErrorCount,le.dppa_flag_LENGTH_ErrorCount
          ,le.orig_name_type_code_ENUM_ErrorCount,le.orig_name_type_code_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.phone_1_ALLOW_ErrorCount,le.phone_1_LENGTH_ErrorCount
          ,le.phone_2_ALLOW_ErrorCount,le.phone_2_LENGTH_ErrorCount
          ,le.fname_CAPS_ErrorCount,le.fname_ALLOW_ErrorCount,le.fname_LENGTH_ErrorCount
          ,le.mname_CAPS_ErrorCount,le.mname_ALLOW_ErrorCount,le.mname_LENGTH_ErrorCount
          ,le.lname_CAPS_ErrorCount,le.lname_ALLOW_ErrorCount,le.lname_LENGTH_ErrorCount
          ,le.name_suffix_CAPS_ErrorCount,le.name_suffix_ALLOW_ErrorCount,le.name_suffix_LENGTH_ErrorCount
          ,le.company_name_CAPS_ErrorCount,le.company_name_ALLOW_ErrorCount,le.company_name_LENGTH_ErrorCount
          ,le.prim_range_CAPS_ErrorCount,le.prim_range_ALLOW_ErrorCount,le.prim_range_LENGTH_ErrorCount
          ,le.predir_CAPS_ErrorCount,le.predir_ALLOW_ErrorCount,le.predir_LENGTH_ErrorCount
          ,le.prim_name_CAPS_ErrorCount,le.prim_name_ALLOW_ErrorCount,le.prim_name_LENGTH_ErrorCount
          ,le.suffix_CAPS_ErrorCount,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount
          ,le.postdir_CAPS_ErrorCount,le.postdir_ALLOW_ErrorCount,le.postdir_LENGTH_ErrorCount
          ,le.unit_desig_CAPS_ErrorCount,le.unit_desig_ALLOW_ErrorCount,le.unit_desig_LENGTH_ErrorCount
          ,le.sec_range_CAPS_ErrorCount,le.sec_range_ALLOW_ErrorCount,le.sec_range_LENGTH_ErrorCount
          ,le.p_city_name_CAPS_ErrorCount,le.p_city_name_ALLOW_ErrorCount,le.p_city_name_LENGTH_ErrorCount
          ,le.v_city_name_CAPS_ErrorCount,le.v_city_name_ALLOW_ErrorCount,le.v_city_name_LENGTH_ErrorCount
          ,le.st_ALLOW_ErrorCount,le.st_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount
          ,le.zip4_ALLOW_ErrorCount,le.zip4_LENGTH_ErrorCount
          ,le.ace_fips_st_ALLOW_ErrorCount,le.ace_fips_st_LENGTH_ErrorCount
          ,le.bdid_ALLOW_ErrorCount,le.bdid_LENGTH_ErrorCount
          ,le.fein_ALLOW_ErrorCount,le.fein_LENGTH_ErrorCount
          ,le.did_ALLOW_ErrorCount,le.did_LENGTH_ErrorCount
          ,le.ssn_ALLOW_ErrorCount,le.ssn_LENGTH_ErrorCount
          ,le.history_flag_ENUM_ErrorCount,le.history_flag_LENGTH_ErrorCount
          ,le.rawaid_ALLOW_ErrorCount,le.rawaid_LENGTH_ErrorCount
          ,le.persistent_record_id_ALLOW_ErrorCount,le.persistent_record_id_LENGTH_ErrorCount
          ,le.source_rec_id_ALLOW_ErrorCount,le.source_rec_id_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,84,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
