IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_PAW; // Import modules for FieldTypes attribute definitions
EXPORT Base_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 36;
  EXPORT NumRulesFromFieldType := 36;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 36;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_Layout_PAW)
    UNSIGNED1 contact_id_Invalid;
    UNSIGNED1 company_phone_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 active_phone_flag_Invalid;
    UNSIGNED1 source_count_Invalid;
    UNSIGNED1 source_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 record_sid_Invalid;
    UNSIGNED1 global_sid_Invalid;
    UNSIGNED1 GLB_Invalid;
    UNSIGNED1 lname_Invalid;
    UNSIGNED1 fname_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 RawAid_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 geo_long_Invalid;
    UNSIGNED1 geo_lat_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 company_zip_Invalid;
    UNSIGNED1 company_state_Invalid;
    UNSIGNED1 Company_RawAid_Invalid;
    UNSIGNED1 company_zip4_Invalid;
    UNSIGNED1 msa_Invalid;
    UNSIGNED1 did_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 predir_Invalid;
    UNSIGNED1 company_predir_Invalid;
    UNSIGNED1 company_postdir_Invalid;
    UNSIGNED1 postdir_Invalid;
    UNSIGNED1 from_hdr_Invalid;
    UNSIGNED1 dead_flag_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_Layout_PAW)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_Layout_PAW) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.contact_id_Invalid := Base_Fields.InValid_contact_id((SALT311.StrType)le.contact_id);
    SELF.company_phone_Invalid := Base_Fields.InValid_company_phone((SALT311.StrType)le.company_phone);
    SELF.company_name_Invalid := Base_Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.active_phone_flag_Invalid := Base_Fields.InValid_active_phone_flag((SALT311.StrType)le.active_phone_flag);
    SELF.source_count_Invalid := Base_Fields.InValid_source_count((SALT311.StrType)le.source_count);
    SELF.source_Invalid := Base_Fields.InValid_source((SALT311.StrType)le.source);
    SELF.record_type_Invalid := Base_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.record_sid_Invalid := Base_Fields.InValid_record_sid((SALT311.StrType)le.record_sid);
    SELF.global_sid_Invalid := Base_Fields.InValid_global_sid((SALT311.StrType)le.global_sid);
    SELF.GLB_Invalid := Base_Fields.InValid_GLB((SALT311.StrType)le.GLB);
    SELF.lname_Invalid := Base_Fields.InValid_lname((SALT311.StrType)le.lname);
    SELF.fname_Invalid := Base_Fields.InValid_fname((SALT311.StrType)le.fname);
    SELF.dt_last_seen_Invalid := Base_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_first_seen_Invalid := Base_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.RawAid_Invalid := Base_Fields.InValid_RawAid((SALT311.StrType)le.RawAid);
    SELF.zip_Invalid := Base_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.state_Invalid := Base_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.bdid_Invalid := Base_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.zip4_Invalid := Base_Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.geo_long_Invalid := Base_Fields.InValid_geo_long((SALT311.StrType)le.geo_long);
    SELF.geo_lat_Invalid := Base_Fields.InValid_geo_lat((SALT311.StrType)le.geo_lat);
    SELF.county_Invalid := Base_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.company_zip_Invalid := Base_Fields.InValid_company_zip((SALT311.StrType)le.company_zip);
    SELF.company_state_Invalid := Base_Fields.InValid_company_state((SALT311.StrType)le.company_state);
    SELF.Company_RawAid_Invalid := Base_Fields.InValid_Company_RawAid((SALT311.StrType)le.Company_RawAid);
    SELF.company_zip4_Invalid := Base_Fields.InValid_company_zip4((SALT311.StrType)le.company_zip4);
    SELF.msa_Invalid := Base_Fields.InValid_msa((SALT311.StrType)le.msa);
    SELF.did_Invalid := Base_Fields.InValid_did((SALT311.StrType)le.did);
    SELF.ssn_Invalid := Base_Fields.InValid_ssn((SALT311.StrType)le.ssn);
    SELF.phone_Invalid := Base_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.predir_Invalid := Base_Fields.InValid_predir((SALT311.StrType)le.predir);
    SELF.company_predir_Invalid := Base_Fields.InValid_company_predir((SALT311.StrType)le.company_predir);
    SELF.company_postdir_Invalid := Base_Fields.InValid_company_postdir((SALT311.StrType)le.company_postdir);
    SELF.postdir_Invalid := Base_Fields.InValid_postdir((SALT311.StrType)le.postdir);
    SELF.from_hdr_Invalid := Base_Fields.InValid_from_hdr((SALT311.StrType)le.from_hdr);
    SELF.dead_flag_Invalid := Base_Fields.InValid_dead_flag((SALT311.StrType)le.dead_flag);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_Layout_PAW);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.contact_id_Invalid << 0 ) + ( le.company_phone_Invalid << 1 ) + ( le.company_name_Invalid << 2 ) + ( le.active_phone_flag_Invalid << 3 ) + ( le.source_count_Invalid << 4 ) + ( le.source_Invalid << 5 ) + ( le.record_type_Invalid << 6 ) + ( le.record_sid_Invalid << 7 ) + ( le.global_sid_Invalid << 8 ) + ( le.GLB_Invalid << 9 ) + ( le.lname_Invalid << 10 ) + ( le.fname_Invalid << 11 ) + ( le.dt_last_seen_Invalid << 12 ) + ( le.dt_first_seen_Invalid << 13 ) + ( le.RawAid_Invalid << 14 ) + ( le.zip_Invalid << 15 ) + ( le.state_Invalid << 16 ) + ( le.bdid_Invalid << 17 ) + ( le.zip4_Invalid << 18 ) + ( le.geo_long_Invalid << 19 ) + ( le.geo_lat_Invalid << 20 ) + ( le.county_Invalid << 21 ) + ( le.company_zip_Invalid << 22 ) + ( le.company_state_Invalid << 23 ) + ( le.Company_RawAid_Invalid << 24 ) + ( le.company_zip4_Invalid << 25 ) + ( le.msa_Invalid << 26 ) + ( le.did_Invalid << 27 ) + ( le.ssn_Invalid << 28 ) + ( le.phone_Invalid << 29 ) + ( le.predir_Invalid << 30 ) + ( le.company_predir_Invalid << 31 ) + ( le.company_postdir_Invalid << 32 ) + ( le.postdir_Invalid << 33 ) + ( le.from_hdr_Invalid << 34 ) + ( le.dead_flag_Invalid << 35 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_Layout_PAW);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.contact_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.company_phone_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.active_phone_flag_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.source_count_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.source_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.record_sid_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.global_sid_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.GLB_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.lname_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.RawAid_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.geo_long_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.geo_lat_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.company_zip_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.company_state_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.Company_RawAid_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.company_zip4_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.msa_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.did_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.predir_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.company_predir_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.company_postdir_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.postdir_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.from_hdr_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.dead_flag_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    contact_id_CUSTOM_ErrorCount := COUNT(GROUP,h.contact_id_Invalid=1);
    company_phone_CUSTOM_ErrorCount := COUNT(GROUP,h.company_phone_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    active_phone_flag_ENUM_ErrorCount := COUNT(GROUP,h.active_phone_flag_Invalid=1);
    source_count_CUSTOM_ErrorCount := COUNT(GROUP,h.source_count_Invalid=1);
    source_LENGTHS_ErrorCount := COUNT(GROUP,h.source_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    record_sid_CUSTOM_ErrorCount := COUNT(GROUP,h.record_sid_Invalid=1);
    global_sid_CUSTOM_ErrorCount := COUNT(GROUP,h.global_sid_Invalid=1);
    GLB_ENUM_ErrorCount := COUNT(GROUP,h.GLB_Invalid=1);
    lname_CUSTOM_ErrorCount := COUNT(GROUP,h.lname_Invalid=1);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    RawAid_CUSTOM_ErrorCount := COUNT(GROUP,h.RawAid_Invalid=1);
    zip_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    bdid_LENGTHS_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    geo_long_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_long_Invalid=1);
    geo_lat_CUSTOM_ErrorCount := COUNT(GROUP,h.geo_lat_Invalid=1);
    county_CUSTOM_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    company_zip_CUSTOM_ErrorCount := COUNT(GROUP,h.company_zip_Invalid=1);
    company_state_CUSTOM_ErrorCount := COUNT(GROUP,h.company_state_Invalid=1);
    Company_RawAid_CUSTOM_ErrorCount := COUNT(GROUP,h.Company_RawAid_Invalid=1);
    company_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.company_zip4_Invalid=1);
    msa_CUSTOM_ErrorCount := COUNT(GROUP,h.msa_Invalid=1);
    did_LENGTHS_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    ssn_CUSTOM_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    predir_ENUM_ErrorCount := COUNT(GROUP,h.predir_Invalid=1);
    company_predir_ENUM_ErrorCount := COUNT(GROUP,h.company_predir_Invalid=1);
    company_postdir_ENUM_ErrorCount := COUNT(GROUP,h.company_postdir_Invalid=1);
    postdir_ENUM_ErrorCount := COUNT(GROUP,h.postdir_Invalid=1);
    from_hdr_ENUM_ErrorCount := COUNT(GROUP,h.from_hdr_Invalid=1);
    dead_flag_ENUM_ErrorCount := COUNT(GROUP,h.dead_flag_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.contact_id_Invalid > 0 OR h.company_phone_Invalid > 0 OR h.company_name_Invalid > 0 OR h.active_phone_flag_Invalid > 0 OR h.source_count_Invalid > 0 OR h.source_Invalid > 0 OR h.record_type_Invalid > 0 OR h.record_sid_Invalid > 0 OR h.global_sid_Invalid > 0 OR h.GLB_Invalid > 0 OR h.lname_Invalid > 0 OR h.fname_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.RawAid_Invalid > 0 OR h.zip_Invalid > 0 OR h.state_Invalid > 0 OR h.bdid_Invalid > 0 OR h.zip4_Invalid > 0 OR h.geo_long_Invalid > 0 OR h.geo_lat_Invalid > 0 OR h.county_Invalid > 0 OR h.company_zip_Invalid > 0 OR h.company_state_Invalid > 0 OR h.Company_RawAid_Invalid > 0 OR h.company_zip4_Invalid > 0 OR h.msa_Invalid > 0 OR h.did_Invalid > 0 OR h.ssn_Invalid > 0 OR h.phone_Invalid > 0 OR h.predir_Invalid > 0 OR h.company_predir_Invalid > 0 OR h.company_postdir_Invalid > 0 OR h.postdir_Invalid > 0 OR h.from_hdr_Invalid > 0 OR h.dead_flag_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.contact_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.active_phone_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.source_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.record_sid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.global_sid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.GLB_ENUM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.RawAid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.Company_RawAid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.from_hdr_ENUM_ErrorCount > 0, 1, 0) + IF(le.dead_flag_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.contact_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.active_phone_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.source_count_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.source_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.record_sid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.global_sid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.GLB_ENUM_ErrorCount > 0, 1, 0) + IF(le.lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.RawAid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bdid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_long_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.geo_lat_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_zip_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.Company_RawAid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.msa_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.did_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ssn_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_predir_ENUM_ErrorCount > 0, 1, 0) + IF(le.company_postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.postdir_ENUM_ErrorCount > 0, 1, 0) + IF(le.from_hdr_ENUM_ErrorCount > 0, 1, 0) + IF(le.dead_flag_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.contact_id_Invalid,le.company_phone_Invalid,le.company_name_Invalid,le.active_phone_flag_Invalid,le.source_count_Invalid,le.source_Invalid,le.record_type_Invalid,le.record_sid_Invalid,le.global_sid_Invalid,le.GLB_Invalid,le.lname_Invalid,le.fname_Invalid,le.dt_last_seen_Invalid,le.dt_first_seen_Invalid,le.RawAid_Invalid,le.zip_Invalid,le.state_Invalid,le.bdid_Invalid,le.zip4_Invalid,le.geo_long_Invalid,le.geo_lat_Invalid,le.county_Invalid,le.company_zip_Invalid,le.company_state_Invalid,le.Company_RawAid_Invalid,le.company_zip4_Invalid,le.msa_Invalid,le.did_Invalid,le.ssn_Invalid,le.phone_Invalid,le.predir_Invalid,le.company_predir_Invalid,le.company_postdir_Invalid,le.postdir_Invalid,le.from_hdr_Invalid,le.dead_flag_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_Fields.InvalidMessage_contact_id(le.contact_id_Invalid),Base_Fields.InvalidMessage_company_phone(le.company_phone_Invalid),Base_Fields.InvalidMessage_company_name(le.company_name_Invalid),Base_Fields.InvalidMessage_active_phone_flag(le.active_phone_flag_Invalid),Base_Fields.InvalidMessage_source_count(le.source_count_Invalid),Base_Fields.InvalidMessage_source(le.source_Invalid),Base_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_Fields.InvalidMessage_record_sid(le.record_sid_Invalid),Base_Fields.InvalidMessage_global_sid(le.global_sid_Invalid),Base_Fields.InvalidMessage_GLB(le.GLB_Invalid),Base_Fields.InvalidMessage_lname(le.lname_Invalid),Base_Fields.InvalidMessage_fname(le.fname_Invalid),Base_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Base_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Base_Fields.InvalidMessage_RawAid(le.RawAid_Invalid),Base_Fields.InvalidMessage_zip(le.zip_Invalid),Base_Fields.InvalidMessage_state(le.state_Invalid),Base_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_Fields.InvalidMessage_zip4(le.zip4_Invalid),Base_Fields.InvalidMessage_geo_long(le.geo_long_Invalid),Base_Fields.InvalidMessage_geo_lat(le.geo_lat_Invalid),Base_Fields.InvalidMessage_county(le.county_Invalid),Base_Fields.InvalidMessage_company_zip(le.company_zip_Invalid),Base_Fields.InvalidMessage_company_state(le.company_state_Invalid),Base_Fields.InvalidMessage_Company_RawAid(le.Company_RawAid_Invalid),Base_Fields.InvalidMessage_company_zip4(le.company_zip4_Invalid),Base_Fields.InvalidMessage_msa(le.msa_Invalid),Base_Fields.InvalidMessage_did(le.did_Invalid),Base_Fields.InvalidMessage_ssn(le.ssn_Invalid),Base_Fields.InvalidMessage_phone(le.phone_Invalid),Base_Fields.InvalidMessage_predir(le.predir_Invalid),Base_Fields.InvalidMessage_company_predir(le.company_predir_Invalid),Base_Fields.InvalidMessage_company_postdir(le.company_postdir_Invalid),Base_Fields.InvalidMessage_postdir(le.postdir_Invalid),Base_Fields.InvalidMessage_from_hdr(le.from_hdr_Invalid),Base_Fields.InvalidMessage_dead_flag(le.dead_flag_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.contact_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.active_phone_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.source_count_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.source_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.record_sid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.global_sid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.GLB_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.RawAid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_long_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.geo_lat_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_zip_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.Company_RawAid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.msa_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.did_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.predir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_predir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.company_postdir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.postdir_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.from_hdr_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dead_flag_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'contact_id','company_phone','company_name','active_phone_flag','source_count','source','record_type','record_sid','global_sid','GLB','lname','fname','dt_last_seen','dt_first_seen','RawAid','zip','state','bdid','zip4','geo_long','geo_lat','county','company_zip','company_state','Company_RawAid','company_zip4','msa','did','ssn','phone','predir','company_predir','company_postdir','postdir','from_hdr','dead_flag','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_phone','invalid_name','invalid_phone_flag','invalid_numeric','invalid_mandatory','invalid_record_type','invalid_numeric_or_blank','invalid_numeric_or_blank','invalid_glb','invalid_name','invalid_name','invalid_reformated_date','invalid_reformated_date','invalid_numeric','invalid_zip5','invalid_st','invalid_mandatory','invalid_zip4','invalid_geo','invalid_geo','invalid_county','invalid_zip5','invalid_st','invalid_numeric','invalid_zip4','invalid_msa','invalid_mandatory','invalid_numeric_or_blank','invalid_phone','invalid_direction','invalid_direction','invalid_direction','invalid_direction','invalid_from_hdr','invalid_dead_flag','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.contact_id,(SALT311.StrType)le.company_phone,(SALT311.StrType)le.company_name,(SALT311.StrType)le.active_phone_flag,(SALT311.StrType)le.source_count,(SALT311.StrType)le.source,(SALT311.StrType)le.record_type,(SALT311.StrType)le.record_sid,(SALT311.StrType)le.global_sid,(SALT311.StrType)le.GLB,(SALT311.StrType)le.lname,(SALT311.StrType)le.fname,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.RawAid,(SALT311.StrType)le.zip,(SALT311.StrType)le.state,(SALT311.StrType)le.bdid,(SALT311.StrType)le.zip4,(SALT311.StrType)le.geo_long,(SALT311.StrType)le.geo_lat,(SALT311.StrType)le.county,(SALT311.StrType)le.company_zip,(SALT311.StrType)le.company_state,(SALT311.StrType)le.Company_RawAid,(SALT311.StrType)le.company_zip4,(SALT311.StrType)le.msa,(SALT311.StrType)le.did,(SALT311.StrType)le.ssn,(SALT311.StrType)le.phone,(SALT311.StrType)le.predir,(SALT311.StrType)le.company_predir,(SALT311.StrType)le.company_postdir,(SALT311.StrType)le.postdir,(SALT311.StrType)le.from_hdr,(SALT311.StrType)le.dead_flag,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,36,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_Layout_PAW) prevDS = DATASET([], Base_Layout_PAW), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'contact_id:invalid_numeric:CUSTOM'
          ,'company_phone:invalid_phone:CUSTOM'
          ,'company_name:invalid_name:CUSTOM'
          ,'active_phone_flag:invalid_phone_flag:ENUM'
          ,'source_count:invalid_numeric:CUSTOM'
          ,'source:invalid_mandatory:LENGTHS'
          ,'record_type:invalid_record_type:ENUM'
          ,'record_sid:invalid_numeric_or_blank:CUSTOM'
          ,'global_sid:invalid_numeric_or_blank:CUSTOM'
          ,'GLB:invalid_glb:ENUM'
          ,'lname:invalid_name:CUSTOM'
          ,'fname:invalid_name:CUSTOM'
          ,'dt_last_seen:invalid_reformated_date:CUSTOM'
          ,'dt_first_seen:invalid_reformated_date:CUSTOM'
          ,'RawAid:invalid_numeric:CUSTOM'
          ,'zip:invalid_zip5:CUSTOM'
          ,'state:invalid_st:CUSTOM'
          ,'bdid:invalid_mandatory:LENGTHS'
          ,'zip4:invalid_zip4:CUSTOM'
          ,'geo_long:invalid_geo:CUSTOM'
          ,'geo_lat:invalid_geo:CUSTOM'
          ,'county:invalid_county:CUSTOM'
          ,'company_zip:invalid_zip5:CUSTOM'
          ,'company_state:invalid_st:CUSTOM'
          ,'Company_RawAid:invalid_numeric:CUSTOM'
          ,'company_zip4:invalid_zip4:CUSTOM'
          ,'msa:invalid_msa:CUSTOM'
          ,'did:invalid_mandatory:LENGTHS'
          ,'ssn:invalid_numeric_or_blank:CUSTOM'
          ,'phone:invalid_phone:CUSTOM'
          ,'predir:invalid_direction:ENUM'
          ,'company_predir:invalid_direction:ENUM'
          ,'company_postdir:invalid_direction:ENUM'
          ,'postdir:invalid_direction:ENUM'
          ,'from_hdr:invalid_from_hdr:ENUM'
          ,'dead_flag:invalid_dead_flag:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_Fields.InvalidMessage_contact_id(1)
          ,Base_Fields.InvalidMessage_company_phone(1)
          ,Base_Fields.InvalidMessage_company_name(1)
          ,Base_Fields.InvalidMessage_active_phone_flag(1)
          ,Base_Fields.InvalidMessage_source_count(1)
          ,Base_Fields.InvalidMessage_source(1)
          ,Base_Fields.InvalidMessage_record_type(1)
          ,Base_Fields.InvalidMessage_record_sid(1)
          ,Base_Fields.InvalidMessage_global_sid(1)
          ,Base_Fields.InvalidMessage_GLB(1)
          ,Base_Fields.InvalidMessage_lname(1)
          ,Base_Fields.InvalidMessage_fname(1)
          ,Base_Fields.InvalidMessage_dt_last_seen(1)
          ,Base_Fields.InvalidMessage_dt_first_seen(1)
          ,Base_Fields.InvalidMessage_RawAid(1)
          ,Base_Fields.InvalidMessage_zip(1)
          ,Base_Fields.InvalidMessage_state(1)
          ,Base_Fields.InvalidMessage_bdid(1)
          ,Base_Fields.InvalidMessage_zip4(1)
          ,Base_Fields.InvalidMessage_geo_long(1)
          ,Base_Fields.InvalidMessage_geo_lat(1)
          ,Base_Fields.InvalidMessage_county(1)
          ,Base_Fields.InvalidMessage_company_zip(1)
          ,Base_Fields.InvalidMessage_company_state(1)
          ,Base_Fields.InvalidMessage_Company_RawAid(1)
          ,Base_Fields.InvalidMessage_company_zip4(1)
          ,Base_Fields.InvalidMessage_msa(1)
          ,Base_Fields.InvalidMessage_did(1)
          ,Base_Fields.InvalidMessage_ssn(1)
          ,Base_Fields.InvalidMessage_phone(1)
          ,Base_Fields.InvalidMessage_predir(1)
          ,Base_Fields.InvalidMessage_company_predir(1)
          ,Base_Fields.InvalidMessage_company_postdir(1)
          ,Base_Fields.InvalidMessage_postdir(1)
          ,Base_Fields.InvalidMessage_from_hdr(1)
          ,Base_Fields.InvalidMessage_dead_flag(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.contact_id_CUSTOM_ErrorCount
          ,le.company_phone_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.active_phone_flag_ENUM_ErrorCount
          ,le.source_count_CUSTOM_ErrorCount
          ,le.source_LENGTHS_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.record_sid_CUSTOM_ErrorCount
          ,le.global_sid_CUSTOM_ErrorCount
          ,le.GLB_ENUM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.RawAid_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.bdid_LENGTHS_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.county_CUSTOM_ErrorCount
          ,le.company_zip_CUSTOM_ErrorCount
          ,le.company_state_CUSTOM_ErrorCount
          ,le.Company_RawAid_CUSTOM_ErrorCount
          ,le.company_zip4_CUSTOM_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.did_LENGTHS_ErrorCount
          ,le.ssn_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.company_predir_ENUM_ErrorCount
          ,le.company_postdir_ENUM_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.from_hdr_ENUM_ErrorCount
          ,le.dead_flag_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.contact_id_CUSTOM_ErrorCount
          ,le.company_phone_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.active_phone_flag_ENUM_ErrorCount
          ,le.source_count_CUSTOM_ErrorCount
          ,le.source_LENGTHS_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.record_sid_CUSTOM_ErrorCount
          ,le.global_sid_CUSTOM_ErrorCount
          ,le.GLB_ENUM_ErrorCount
          ,le.lname_CUSTOM_ErrorCount
          ,le.fname_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.RawAid_CUSTOM_ErrorCount
          ,le.zip_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.bdid_LENGTHS_ErrorCount
          ,le.zip4_CUSTOM_ErrorCount
          ,le.geo_long_CUSTOM_ErrorCount
          ,le.geo_lat_CUSTOM_ErrorCount
          ,le.county_CUSTOM_ErrorCount
          ,le.company_zip_CUSTOM_ErrorCount
          ,le.company_state_CUSTOM_ErrorCount
          ,le.Company_RawAid_CUSTOM_ErrorCount
          ,le.company_zip4_CUSTOM_ErrorCount
          ,le.msa_CUSTOM_ErrorCount
          ,le.did_LENGTHS_ErrorCount
          ,le.ssn_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.predir_ENUM_ErrorCount
          ,le.company_predir_ENUM_ErrorCount
          ,le.company_postdir_ENUM_ErrorCount
          ,le.postdir_ENUM_ErrorCount
          ,le.from_hdr_ENUM_ErrorCount
          ,le.dead_flag_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_hygiene(PROJECT(h, Base_Layout_PAW));
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
          ,'contact_id:' + getFieldTypeText(h.contact_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_phone:' + getFieldTypeText(h.company_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'active_phone_flag:' + getFieldTypeText(h.active_phone_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_count:' + getFieldTypeText(h.source_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'GLB:' + getFieldTypeText(h.GLB) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'RawAid:' + getFieldTypeText(h.RawAid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_zip:' + getFieldTypeText(h.company_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_state:' + getFieldTypeText(h.company_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'Company_RawAid:' + getFieldTypeText(h.Company_RawAid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_zip4:' + getFieldTypeText(h.company_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_predir:' + getFieldTypeText(h.company_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_postdir:' + getFieldTypeText(h.company_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'from_hdr:' + getFieldTypeText(h.from_hdr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dead_flag:' + getFieldTypeText(h.dead_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_contact_id_cnt
          ,le.populated_company_phone_cnt
          ,le.populated_company_name_cnt
          ,le.populated_active_phone_flag_cnt
          ,le.populated_source_count_cnt
          ,le.populated_source_cnt
          ,le.populated_record_type_cnt
          ,le.populated_record_sid_cnt
          ,le.populated_global_sid_cnt
          ,le.populated_GLB_cnt
          ,le.populated_lname_cnt
          ,le.populated_fname_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_RawAid_cnt
          ,le.populated_zip_cnt
          ,le.populated_state_cnt
          ,le.populated_bdid_cnt
          ,le.populated_zip4_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_county_cnt
          ,le.populated_company_zip_cnt
          ,le.populated_company_state_cnt
          ,le.populated_Company_RawAid_cnt
          ,le.populated_company_zip4_cnt
          ,le.populated_msa_cnt
          ,le.populated_did_cnt
          ,le.populated_ssn_cnt
          ,le.populated_phone_cnt
          ,le.populated_predir_cnt
          ,le.populated_company_predir_cnt
          ,le.populated_company_postdir_cnt
          ,le.populated_postdir_cnt
          ,le.populated_from_hdr_cnt
          ,le.populated_dead_flag_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_contact_id_pcnt
          ,le.populated_company_phone_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_active_phone_flag_pcnt
          ,le.populated_source_count_pcnt
          ,le.populated_source_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_record_sid_pcnt
          ,le.populated_global_sid_pcnt
          ,le.populated_GLB_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_RawAid_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_state_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_county_pcnt
          ,le.populated_company_zip_pcnt
          ,le.populated_company_state_pcnt
          ,le.populated_Company_RawAid_pcnt
          ,le.populated_company_zip4_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_did_pcnt
          ,le.populated_ssn_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_company_predir_pcnt
          ,le.populated_company_postdir_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_from_hdr_pcnt
          ,le.populated_dead_flag_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,36,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_Delta(prevDS, PROJECT(h, Base_Layout_PAW));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),36,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_Layout_PAW) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PAW, Base_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
