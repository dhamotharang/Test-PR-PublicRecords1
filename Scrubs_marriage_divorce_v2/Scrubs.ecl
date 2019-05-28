IMPORT SALT311,STD;
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 82;
  EXPORT NumRulesFromFieldType := 82;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 40;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Marriage_Divorce_V2_Profile)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 record_id_Invalid;
    UNSIGNED1 filing_type_Invalid;
    UNSIGNED1 vendor_Invalid;
    UNSIGNED1 source_file_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 party1_type_Invalid;
    UNSIGNED1 party1_name_format_Invalid;
    UNSIGNED1 party1_name_Invalid;
    UNSIGNED1 party1_alias_Invalid;
    UNSIGNED1 party1_dob_Invalid;
    UNSIGNED1 party1_birth_state_Invalid;
    UNSIGNED1 party1_race_Invalid;
    UNSIGNED1 party1_addr1_Invalid;
    UNSIGNED1 party1_county_Invalid;
    UNSIGNED1 party1_last_marriage_end_dt_Invalid;
    UNSIGNED1 party2_type_Invalid;
    UNSIGNED1 party2_name_format_Invalid;
    UNSIGNED1 party2_name_Invalid;
    UNSIGNED1 party2_dob_Invalid;
    UNSIGNED1 party2_birth_state_Invalid;
    UNSIGNED1 party2_addr1_Invalid;
    UNSIGNED1 party2_county_Invalid;
    UNSIGNED1 party2_last_marriage_end_dt_Invalid;
    UNSIGNED1 marriage_filing_dt_Invalid;
    UNSIGNED1 marriage_dt_Invalid;
    UNSIGNED1 marriage_city_Invalid;
    UNSIGNED1 marriage_county_Invalid;
    UNSIGNED1 marriage_filing_number_Invalid;
    UNSIGNED1 marriage_docket_volume_Invalid;
    UNSIGNED1 divorce_filing_dt_Invalid;
    UNSIGNED1 divorce_dt_Invalid;
    UNSIGNED1 divorce_docket_volume_Invalid;
    UNSIGNED1 divorce_filing_number_Invalid;
    UNSIGNED1 divorce_city_Invalid;
    UNSIGNED1 divorce_county_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Marriage_Divorce_V2_Profile)
    UNSIGNED8 ScrubsBits1;
    UNSIGNED8 ScrubsBits2;
  END;
EXPORT FromNone(DATASET(Layout_Marriage_Divorce_V2_Profile) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.record_id_Invalid := Fields.InValid_record_id((SALT311.StrType)le.record_id);
    SELF.filing_type_Invalid := Fields.InValid_filing_type((SALT311.StrType)le.filing_type);
    SELF.vendor_Invalid := Fields.InValid_vendor((SALT311.StrType)le.vendor);
    SELF.source_file_Invalid := Fields.InValid_source_file((SALT311.StrType)le.source_file);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.state_origin_Invalid := Fields.InValid_state_origin((SALT311.StrType)le.state_origin);
    SELF.party1_type_Invalid := Fields.InValid_party1_type((SALT311.StrType)le.party1_type);
    SELF.party1_name_format_Invalid := Fields.InValid_party1_name_format((SALT311.StrType)le.party1_name_format);
    SELF.party1_name_Invalid := Fields.InValid_party1_name((SALT311.StrType)le.party1_name);
    SELF.party1_alias_Invalid := Fields.InValid_party1_alias((SALT311.StrType)le.party1_alias);
    SELF.party1_dob_Invalid := Fields.InValid_party1_dob((SALT311.StrType)le.party1_dob);
    SELF.party1_birth_state_Invalid := Fields.InValid_party1_birth_state((SALT311.StrType)le.party1_birth_state);
    SELF.party1_race_Invalid := Fields.InValid_party1_race((SALT311.StrType)le.party1_race);
    SELF.party1_addr1_Invalid := Fields.InValid_party1_addr1((SALT311.StrType)le.party1_addr1);
    SELF.party1_county_Invalid := Fields.InValid_party1_county((SALT311.StrType)le.party1_county);
    SELF.party1_last_marriage_end_dt_Invalid := Fields.InValid_party1_last_marriage_end_dt((SALT311.StrType)le.party1_last_marriage_end_dt);
    SELF.party2_type_Invalid := Fields.InValid_party2_type((SALT311.StrType)le.party2_type);
    SELF.party2_name_format_Invalid := Fields.InValid_party2_name_format((SALT311.StrType)le.party2_name_format);
    SELF.party2_name_Invalid := Fields.InValid_party2_name((SALT311.StrType)le.party2_name);
    SELF.party2_dob_Invalid := Fields.InValid_party2_dob((SALT311.StrType)le.party2_dob);
    SELF.party2_birth_state_Invalid := Fields.InValid_party2_birth_state((SALT311.StrType)le.party2_birth_state);
    SELF.party2_addr1_Invalid := Fields.InValid_party2_addr1((SALT311.StrType)le.party2_addr1);
    SELF.party2_county_Invalid := Fields.InValid_party2_county((SALT311.StrType)le.party2_county);
    SELF.party2_last_marriage_end_dt_Invalid := Fields.InValid_party2_last_marriage_end_dt((SALT311.StrType)le.party2_last_marriage_end_dt);
    SELF.marriage_filing_dt_Invalid := Fields.InValid_marriage_filing_dt((SALT311.StrType)le.marriage_filing_dt);
    SELF.marriage_dt_Invalid := Fields.InValid_marriage_dt((SALT311.StrType)le.marriage_dt);
    SELF.marriage_city_Invalid := Fields.InValid_marriage_city((SALT311.StrType)le.marriage_city);
    SELF.marriage_county_Invalid := Fields.InValid_marriage_county((SALT311.StrType)le.marriage_county);
    SELF.marriage_filing_number_Invalid := Fields.InValid_marriage_filing_number((SALT311.StrType)le.marriage_filing_number);
    SELF.marriage_docket_volume_Invalid := Fields.InValid_marriage_docket_volume((SALT311.StrType)le.marriage_docket_volume);
    SELF.divorce_filing_dt_Invalid := Fields.InValid_divorce_filing_dt((SALT311.StrType)le.divorce_filing_dt);
    SELF.divorce_dt_Invalid := Fields.InValid_divorce_dt((SALT311.StrType)le.divorce_dt);
    SELF.divorce_docket_volume_Invalid := Fields.InValid_divorce_docket_volume((SALT311.StrType)le.divorce_docket_volume);
    SELF.divorce_filing_number_Invalid := Fields.InValid_divorce_filing_number((SALT311.StrType)le.divorce_filing_number);
    SELF.divorce_city_Invalid := Fields.InValid_divorce_city((SALT311.StrType)le.divorce_city);
    SELF.divorce_county_Invalid := Fields.InValid_divorce_county((SALT311.StrType)le.divorce_county);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Marriage_Divorce_V2_Profile);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 2 ) + ( le.dt_vendor_first_reported_Invalid << 4 ) + ( le.dt_vendor_last_reported_Invalid << 6 ) + ( le.record_id_Invalid << 8 ) + ( le.filing_type_Invalid << 10 ) + ( le.vendor_Invalid << 12 ) + ( le.source_file_Invalid << 14 ) + ( le.process_date_Invalid << 16 ) + ( le.state_origin_Invalid << 18 ) + ( le.party1_type_Invalid << 20 ) + ( le.party1_name_format_Invalid << 22 ) + ( le.party1_name_Invalid << 23 ) + ( le.party1_alias_Invalid << 25 ) + ( le.party1_dob_Invalid << 27 ) + ( le.party1_birth_state_Invalid << 29 ) + ( le.party1_race_Invalid << 31 ) + ( le.party1_addr1_Invalid << 33 ) + ( le.party1_county_Invalid << 35 ) + ( le.party1_last_marriage_end_dt_Invalid << 37 ) + ( le.party2_type_Invalid << 39 ) + ( le.party2_name_format_Invalid << 41 ) + ( le.party2_name_Invalid << 42 ) + ( le.party2_dob_Invalid << 44 ) + ( le.party2_birth_state_Invalid << 46 ) + ( le.party2_addr1_Invalid << 48 ) + ( le.party2_county_Invalid << 50 ) + ( le.party2_last_marriage_end_dt_Invalid << 52 ) + ( le.marriage_filing_dt_Invalid << 54 ) + ( le.marriage_dt_Invalid << 56 ) + ( le.marriage_city_Invalid << 58 ) + ( le.marriage_county_Invalid << 60 ) + ( le.marriage_filing_number_Invalid << 62 );
    SELF.ScrubsBits2 := ( le.marriage_docket_volume_Invalid << 0 ) + ( le.divorce_filing_dt_Invalid << 2 ) + ( le.divorce_dt_Invalid << 4 ) + ( le.divorce_docket_volume_Invalid << 6 ) + ( le.divorce_filing_number_Invalid << 8 ) + ( le.divorce_city_Invalid << 10 ) + ( le.divorce_county_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Marriage_Divorce_V2_Profile);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.record_id_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.filing_type_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.vendor_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.source_file_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.party1_type_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.party1_name_format_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.party1_name_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.party1_alias_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.party1_dob_Invalid := (le.ScrubsBits1 >> 27) & 3;
    SELF.party1_birth_state_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.party1_race_Invalid := (le.ScrubsBits1 >> 31) & 3;
    SELF.party1_addr1_Invalid := (le.ScrubsBits1 >> 33) & 3;
    SELF.party1_county_Invalid := (le.ScrubsBits1 >> 35) & 3;
    SELF.party1_last_marriage_end_dt_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.party2_type_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.party2_name_format_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.party2_name_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF.party2_dob_Invalid := (le.ScrubsBits1 >> 44) & 3;
    SELF.party2_birth_state_Invalid := (le.ScrubsBits1 >> 46) & 3;
    SELF.party2_addr1_Invalid := (le.ScrubsBits1 >> 48) & 3;
    SELF.party2_county_Invalid := (le.ScrubsBits1 >> 50) & 3;
    SELF.party2_last_marriage_end_dt_Invalid := (le.ScrubsBits1 >> 52) & 3;
    SELF.marriage_filing_dt_Invalid := (le.ScrubsBits1 >> 54) & 3;
    SELF.marriage_dt_Invalid := (le.ScrubsBits1 >> 56) & 3;
    SELF.marriage_city_Invalid := (le.ScrubsBits1 >> 58) & 3;
    SELF.marriage_county_Invalid := (le.ScrubsBits1 >> 60) & 3;
    SELF.marriage_filing_number_Invalid := (le.ScrubsBits1 >> 62) & 3;
    SELF.marriage_docket_volume_Invalid := (le.ScrubsBits2 >> 0) & 3;
    SELF.divorce_filing_dt_Invalid := (le.ScrubsBits2 >> 2) & 3;
    SELF.divorce_dt_Invalid := (le.ScrubsBits2 >> 4) & 3;
    SELF.divorce_docket_volume_Invalid := (le.ScrubsBits2 >> 6) & 3;
    SELF.divorce_filing_number_Invalid := (le.ScrubsBits2 >> 8) & 3;
    SELF.divorce_city_Invalid := (le.ScrubsBits2 >> 10) & 3;
    SELF.divorce_county_Invalid := (le.ScrubsBits2 >> 12) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_first_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=2);
    dt_first_seen_Total_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid>0);
    dt_last_seen_ALLOW_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_last_seen_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=2);
    dt_last_seen_Total_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid>0);
    dt_vendor_first_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_first_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=2);
    dt_vendor_first_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid>0);
    dt_vendor_last_reported_ALLOW_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    dt_vendor_last_reported_LENGTHS_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=2);
    dt_vendor_last_reported_Total_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid>0);
    record_id_ALLOW_ErrorCount := COUNT(GROUP,h.record_id_Invalid=1);
    record_id_LENGTHS_ErrorCount := COUNT(GROUP,h.record_id_Invalid=2);
    record_id_Total_ErrorCount := COUNT(GROUP,h.record_id_Invalid>0);
    filing_type_ALLOW_ErrorCount := COUNT(GROUP,h.filing_type_Invalid=1);
    filing_type_LENGTHS_ErrorCount := COUNT(GROUP,h.filing_type_Invalid=2);
    filing_type_Total_ErrorCount := COUNT(GROUP,h.filing_type_Invalid>0);
    vendor_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    vendor_LENGTHS_ErrorCount := COUNT(GROUP,h.vendor_Invalid=2);
    vendor_Total_ErrorCount := COUNT(GROUP,h.vendor_Invalid>0);
    source_file_ALLOW_ErrorCount := COUNT(GROUP,h.source_file_Invalid=1);
    source_file_LENGTHS_ErrorCount := COUNT(GROUP,h.source_file_Invalid=2);
    source_file_Total_ErrorCount := COUNT(GROUP,h.source_file_Invalid>0);
    process_date_ALLOW_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    state_origin_LENGTHS_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=2);
    state_origin_Total_ErrorCount := COUNT(GROUP,h.state_origin_Invalid>0);
    party1_type_CAPS_ErrorCount := COUNT(GROUP,h.party1_type_Invalid=1);
    party1_type_ALLOW_ErrorCount := COUNT(GROUP,h.party1_type_Invalid=2);
    party1_type_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_type_Invalid=3);
    party1_type_Total_ErrorCount := COUNT(GROUP,h.party1_type_Invalid>0);
    party1_name_format_ENUM_ErrorCount := COUNT(GROUP,h.party1_name_format_Invalid=1);
    party1_name_ALLOW_ErrorCount := COUNT(GROUP,h.party1_name_Invalid=1);
    party1_name_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_name_Invalid=2);
    party1_name_Total_ErrorCount := COUNT(GROUP,h.party1_name_Invalid>0);
    party1_alias_ALLOW_ErrorCount := COUNT(GROUP,h.party1_alias_Invalid=1);
    party1_alias_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_alias_Invalid=2);
    party1_alias_Total_ErrorCount := COUNT(GROUP,h.party1_alias_Invalid>0);
    party1_dob_ALLOW_ErrorCount := COUNT(GROUP,h.party1_dob_Invalid=1);
    party1_dob_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_dob_Invalid=2);
    party1_dob_Total_ErrorCount := COUNT(GROUP,h.party1_dob_Invalid>0);
    party1_birth_state_ALLOW_ErrorCount := COUNT(GROUP,h.party1_birth_state_Invalid=1);
    party1_birth_state_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_birth_state_Invalid=2);
    party1_birth_state_Total_ErrorCount := COUNT(GROUP,h.party1_birth_state_Invalid>0);
    party1_race_ALLOW_ErrorCount := COUNT(GROUP,h.party1_race_Invalid=1);
    party1_race_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_race_Invalid=2);
    party1_race_Total_ErrorCount := COUNT(GROUP,h.party1_race_Invalid>0);
    party1_addr1_CAPS_ErrorCount := COUNT(GROUP,h.party1_addr1_Invalid=1);
    party1_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.party1_addr1_Invalid=2);
    party1_addr1_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_addr1_Invalid=3);
    party1_addr1_Total_ErrorCount := COUNT(GROUP,h.party1_addr1_Invalid>0);
    party1_county_ALLOW_ErrorCount := COUNT(GROUP,h.party1_county_Invalid=1);
    party1_county_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_county_Invalid=2);
    party1_county_Total_ErrorCount := COUNT(GROUP,h.party1_county_Invalid>0);
    party1_last_marriage_end_dt_ALLOW_ErrorCount := COUNT(GROUP,h.party1_last_marriage_end_dt_Invalid=1);
    party1_last_marriage_end_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.party1_last_marriage_end_dt_Invalid=2);
    party1_last_marriage_end_dt_Total_ErrorCount := COUNT(GROUP,h.party1_last_marriage_end_dt_Invalid>0);
    party2_type_CAPS_ErrorCount := COUNT(GROUP,h.party2_type_Invalid=1);
    party2_type_ALLOW_ErrorCount := COUNT(GROUP,h.party2_type_Invalid=2);
    party2_type_LENGTHS_ErrorCount := COUNT(GROUP,h.party2_type_Invalid=3);
    party2_type_Total_ErrorCount := COUNT(GROUP,h.party2_type_Invalid>0);
    party2_name_format_ENUM_ErrorCount := COUNT(GROUP,h.party2_name_format_Invalid=1);
    party2_name_ALLOW_ErrorCount := COUNT(GROUP,h.party2_name_Invalid=1);
    party2_name_LENGTHS_ErrorCount := COUNT(GROUP,h.party2_name_Invalid=2);
    party2_name_Total_ErrorCount := COUNT(GROUP,h.party2_name_Invalid>0);
    party2_dob_ALLOW_ErrorCount := COUNT(GROUP,h.party2_dob_Invalid=1);
    party2_dob_LENGTHS_ErrorCount := COUNT(GROUP,h.party2_dob_Invalid=2);
    party2_dob_Total_ErrorCount := COUNT(GROUP,h.party2_dob_Invalid>0);
    party2_birth_state_ALLOW_ErrorCount := COUNT(GROUP,h.party2_birth_state_Invalid=1);
    party2_birth_state_LENGTHS_ErrorCount := COUNT(GROUP,h.party2_birth_state_Invalid=2);
    party2_birth_state_Total_ErrorCount := COUNT(GROUP,h.party2_birth_state_Invalid>0);
    party2_addr1_CAPS_ErrorCount := COUNT(GROUP,h.party2_addr1_Invalid=1);
    party2_addr1_ALLOW_ErrorCount := COUNT(GROUP,h.party2_addr1_Invalid=2);
    party2_addr1_LENGTHS_ErrorCount := COUNT(GROUP,h.party2_addr1_Invalid=3);
    party2_addr1_Total_ErrorCount := COUNT(GROUP,h.party2_addr1_Invalid>0);
    party2_county_ALLOW_ErrorCount := COUNT(GROUP,h.party2_county_Invalid=1);
    party2_county_LENGTHS_ErrorCount := COUNT(GROUP,h.party2_county_Invalid=2);
    party2_county_Total_ErrorCount := COUNT(GROUP,h.party2_county_Invalid>0);
    party2_last_marriage_end_dt_ALLOW_ErrorCount := COUNT(GROUP,h.party2_last_marriage_end_dt_Invalid=1);
    party2_last_marriage_end_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.party2_last_marriage_end_dt_Invalid=2);
    party2_last_marriage_end_dt_Total_ErrorCount := COUNT(GROUP,h.party2_last_marriage_end_dt_Invalid>0);
    marriage_filing_dt_ALLOW_ErrorCount := COUNT(GROUP,h.marriage_filing_dt_Invalid=1);
    marriage_filing_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.marriage_filing_dt_Invalid=2);
    marriage_filing_dt_Total_ErrorCount := COUNT(GROUP,h.marriage_filing_dt_Invalid>0);
    marriage_dt_ALLOW_ErrorCount := COUNT(GROUP,h.marriage_dt_Invalid=1);
    marriage_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.marriage_dt_Invalid=2);
    marriage_dt_Total_ErrorCount := COUNT(GROUP,h.marriage_dt_Invalid>0);
    marriage_city_ALLOW_ErrorCount := COUNT(GROUP,h.marriage_city_Invalid=1);
    marriage_city_LENGTHS_ErrorCount := COUNT(GROUP,h.marriage_city_Invalid=2);
    marriage_city_Total_ErrorCount := COUNT(GROUP,h.marriage_city_Invalid>0);
    marriage_county_ALLOW_ErrorCount := COUNT(GROUP,h.marriage_county_Invalid=1);
    marriage_county_LENGTHS_ErrorCount := COUNT(GROUP,h.marriage_county_Invalid=2);
    marriage_county_Total_ErrorCount := COUNT(GROUP,h.marriage_county_Invalid>0);
    marriage_filing_number_ALLOW_ErrorCount := COUNT(GROUP,h.marriage_filing_number_Invalid=1);
    marriage_filing_number_LENGTHS_ErrorCount := COUNT(GROUP,h.marriage_filing_number_Invalid=2);
    marriage_filing_number_Total_ErrorCount := COUNT(GROUP,h.marriage_filing_number_Invalid>0);
    marriage_docket_volume_ALLOW_ErrorCount := COUNT(GROUP,h.marriage_docket_volume_Invalid=1);
    marriage_docket_volume_LENGTHS_ErrorCount := COUNT(GROUP,h.marriage_docket_volume_Invalid=2);
    marriage_docket_volume_Total_ErrorCount := COUNT(GROUP,h.marriage_docket_volume_Invalid>0);
    divorce_filing_dt_ALLOW_ErrorCount := COUNT(GROUP,h.divorce_filing_dt_Invalid=1);
    divorce_filing_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.divorce_filing_dt_Invalid=2);
    divorce_filing_dt_Total_ErrorCount := COUNT(GROUP,h.divorce_filing_dt_Invalid>0);
    divorce_dt_ALLOW_ErrorCount := COUNT(GROUP,h.divorce_dt_Invalid=1);
    divorce_dt_LENGTHS_ErrorCount := COUNT(GROUP,h.divorce_dt_Invalid=2);
    divorce_dt_Total_ErrorCount := COUNT(GROUP,h.divorce_dt_Invalid>0);
    divorce_docket_volume_ALLOW_ErrorCount := COUNT(GROUP,h.divorce_docket_volume_Invalid=1);
    divorce_docket_volume_LENGTHS_ErrorCount := COUNT(GROUP,h.divorce_docket_volume_Invalid=2);
    divorce_docket_volume_Total_ErrorCount := COUNT(GROUP,h.divorce_docket_volume_Invalid>0);
    divorce_filing_number_ALLOW_ErrorCount := COUNT(GROUP,h.divorce_filing_number_Invalid=1);
    divorce_filing_number_LENGTHS_ErrorCount := COUNT(GROUP,h.divorce_filing_number_Invalid=2);
    divorce_filing_number_Total_ErrorCount := COUNT(GROUP,h.divorce_filing_number_Invalid>0);
    divorce_city_ALLOW_ErrorCount := COUNT(GROUP,h.divorce_city_Invalid=1);
    divorce_city_LENGTHS_ErrorCount := COUNT(GROUP,h.divorce_city_Invalid=2);
    divorce_city_Total_ErrorCount := COUNT(GROUP,h.divorce_city_Invalid>0);
    divorce_county_ALLOW_ErrorCount := COUNT(GROUP,h.divorce_county_Invalid=1);
    divorce_county_LENGTHS_ErrorCount := COUNT(GROUP,h.divorce_county_Invalid=2);
    divorce_county_Total_ErrorCount := COUNT(GROUP,h.divorce_county_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.record_id_Invalid > 0 OR h.filing_type_Invalid > 0 OR h.vendor_Invalid > 0 OR h.source_file_Invalid > 0 OR h.process_date_Invalid > 0 OR h.state_origin_Invalid > 0 OR h.party1_type_Invalid > 0 OR h.party1_name_format_Invalid > 0 OR h.party1_name_Invalid > 0 OR h.party1_alias_Invalid > 0 OR h.party1_dob_Invalid > 0 OR h.party1_birth_state_Invalid > 0 OR h.party1_race_Invalid > 0 OR h.party1_addr1_Invalid > 0 OR h.party1_county_Invalid > 0 OR h.party1_last_marriage_end_dt_Invalid > 0 OR h.party2_type_Invalid > 0 OR h.party2_name_format_Invalid > 0 OR h.party2_name_Invalid > 0 OR h.party2_dob_Invalid > 0 OR h.party2_birth_state_Invalid > 0 OR h.party2_addr1_Invalid > 0 OR h.party2_county_Invalid > 0 OR h.party2_last_marriage_end_dt_Invalid > 0 OR h.marriage_filing_dt_Invalid > 0 OR h.marriage_dt_Invalid > 0 OR h.marriage_city_Invalid > 0 OR h.marriage_county_Invalid > 0 OR h.marriage_filing_number_Invalid > 0 OR h.marriage_docket_volume_Invalid > 0 OR h.divorce_filing_dt_Invalid > 0 OR h.divorce_dt_Invalid > 0 OR h.divorce_docket_volume_Invalid > 0 OR h.divorce_filing_number_Invalid > 0 OR h.divorce_city_Invalid > 0 OR h.divorce_county_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_Total_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_Total_ErrorCount > 0, 1, 0) + IF(le.record_id_Total_ErrorCount > 0, 1, 0) + IF(le.filing_type_Total_ErrorCount > 0, 1, 0) + IF(le.vendor_Total_ErrorCount > 0, 1, 0) + IF(le.source_file_Total_ErrorCount > 0, 1, 0) + IF(le.process_date_Total_ErrorCount > 0, 1, 0) + IF(le.state_origin_Total_ErrorCount > 0, 1, 0) + IF(le.party1_type_Total_ErrorCount > 0, 1, 0) + IF(le.party1_name_format_ENUM_ErrorCount > 0, 1, 0) + IF(le.party1_name_Total_ErrorCount > 0, 1, 0) + IF(le.party1_alias_Total_ErrorCount > 0, 1, 0) + IF(le.party1_dob_Total_ErrorCount > 0, 1, 0) + IF(le.party1_birth_state_Total_ErrorCount > 0, 1, 0) + IF(le.party1_race_Total_ErrorCount > 0, 1, 0) + IF(le.party1_addr1_Total_ErrorCount > 0, 1, 0) + IF(le.party1_county_Total_ErrorCount > 0, 1, 0) + IF(le.party1_last_marriage_end_dt_Total_ErrorCount > 0, 1, 0) + IF(le.party2_type_Total_ErrorCount > 0, 1, 0) + IF(le.party2_name_format_ENUM_ErrorCount > 0, 1, 0) + IF(le.party2_name_Total_ErrorCount > 0, 1, 0) + IF(le.party2_dob_Total_ErrorCount > 0, 1, 0) + IF(le.party2_birth_state_Total_ErrorCount > 0, 1, 0) + IF(le.party2_addr1_Total_ErrorCount > 0, 1, 0) + IF(le.party2_county_Total_ErrorCount > 0, 1, 0) + IF(le.party2_last_marriage_end_dt_Total_ErrorCount > 0, 1, 0) + IF(le.marriage_filing_dt_Total_ErrorCount > 0, 1, 0) + IF(le.marriage_dt_Total_ErrorCount > 0, 1, 0) + IF(le.marriage_city_Total_ErrorCount > 0, 1, 0) + IF(le.marriage_county_Total_ErrorCount > 0, 1, 0) + IF(le.marriage_filing_number_Total_ErrorCount > 0, 1, 0) + IF(le.marriage_docket_volume_Total_ErrorCount > 0, 1, 0) + IF(le.divorce_filing_dt_Total_ErrorCount > 0, 1, 0) + IF(le.divorce_dt_Total_ErrorCount > 0, 1, 0) + IF(le.divorce_docket_volume_Total_ErrorCount > 0, 1, 0) + IF(le.divorce_filing_number_Total_ErrorCount > 0, 1, 0) + IF(le.divorce_city_Total_ErrorCount > 0, 1, 0) + IF(le.divorce_county_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.record_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.record_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.filing_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filing_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendor_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.source_file_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_file_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.process_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_type_CAPS_ErrorCount > 0, 1, 0) + IF(le.party1_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_name_format_ENUM_ErrorCount > 0, 1, 0) + IF(le.party1_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_alias_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_alias_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_birth_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_birth_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_race_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_race_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_addr1_CAPS_ErrorCount > 0, 1, 0) + IF(le.party1_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_addr1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_county_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party1_last_marriage_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party1_last_marriage_end_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party2_type_CAPS_ErrorCount > 0, 1, 0) + IF(le.party2_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party2_type_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party2_name_format_ENUM_ErrorCount > 0, 1, 0) + IF(le.party2_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party2_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party2_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party2_dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party2_birth_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party2_birth_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party2_addr1_CAPS_ErrorCount > 0, 1, 0) + IF(le.party2_addr1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party2_addr1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party2_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party2_county_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.party2_last_marriage_end_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party2_last_marriage_end_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.marriage_filing_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.marriage_filing_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.marriage_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.marriage_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.marriage_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.marriage_city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.marriage_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.marriage_county_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.marriage_filing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.marriage_filing_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.marriage_docket_volume_ALLOW_ErrorCount > 0, 1, 0) + IF(le.marriage_docket_volume_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.divorce_filing_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.divorce_filing_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.divorce_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.divorce_dt_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.divorce_docket_volume_ALLOW_ErrorCount > 0, 1, 0) + IF(le.divorce_docket_volume_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.divorce_filing_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.divorce_filing_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.divorce_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.divorce_city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.divorce_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.divorce_county_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.record_id_Invalid,le.filing_type_Invalid,le.vendor_Invalid,le.source_file_Invalid,le.process_date_Invalid,le.state_origin_Invalid,le.party1_type_Invalid,le.party1_name_format_Invalid,le.party1_name_Invalid,le.party1_alias_Invalid,le.party1_dob_Invalid,le.party1_birth_state_Invalid,le.party1_race_Invalid,le.party1_addr1_Invalid,le.party1_county_Invalid,le.party1_last_marriage_end_dt_Invalid,le.party2_type_Invalid,le.party2_name_format_Invalid,le.party2_name_Invalid,le.party2_dob_Invalid,le.party2_birth_state_Invalid,le.party2_addr1_Invalid,le.party2_county_Invalid,le.party2_last_marriage_end_dt_Invalid,le.marriage_filing_dt_Invalid,le.marriage_dt_Invalid,le.marriage_city_Invalid,le.marriage_county_Invalid,le.marriage_filing_number_Invalid,le.marriage_docket_volume_Invalid,le.divorce_filing_dt_Invalid,le.divorce_dt_Invalid,le.divorce_docket_volume_Invalid,le.divorce_filing_number_Invalid,le.divorce_city_Invalid,le.divorce_county_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Fields.InvalidMessage_record_id(le.record_id_Invalid),Fields.InvalidMessage_filing_type(le.filing_type_Invalid),Fields.InvalidMessage_vendor(le.vendor_Invalid),Fields.InvalidMessage_source_file(le.source_file_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Fields.InvalidMessage_party1_type(le.party1_type_Invalid),Fields.InvalidMessage_party1_name_format(le.party1_name_format_Invalid),Fields.InvalidMessage_party1_name(le.party1_name_Invalid),Fields.InvalidMessage_party1_alias(le.party1_alias_Invalid),Fields.InvalidMessage_party1_dob(le.party1_dob_Invalid),Fields.InvalidMessage_party1_birth_state(le.party1_birth_state_Invalid),Fields.InvalidMessage_party1_race(le.party1_race_Invalid),Fields.InvalidMessage_party1_addr1(le.party1_addr1_Invalid),Fields.InvalidMessage_party1_county(le.party1_county_Invalid),Fields.InvalidMessage_party1_last_marriage_end_dt(le.party1_last_marriage_end_dt_Invalid),Fields.InvalidMessage_party2_type(le.party2_type_Invalid),Fields.InvalidMessage_party2_name_format(le.party2_name_format_Invalid),Fields.InvalidMessage_party2_name(le.party2_name_Invalid),Fields.InvalidMessage_party2_dob(le.party2_dob_Invalid),Fields.InvalidMessage_party2_birth_state(le.party2_birth_state_Invalid),Fields.InvalidMessage_party2_addr1(le.party2_addr1_Invalid),Fields.InvalidMessage_party2_county(le.party2_county_Invalid),Fields.InvalidMessage_party2_last_marriage_end_dt(le.party2_last_marriage_end_dt_Invalid),Fields.InvalidMessage_marriage_filing_dt(le.marriage_filing_dt_Invalid),Fields.InvalidMessage_marriage_dt(le.marriage_dt_Invalid),Fields.InvalidMessage_marriage_city(le.marriage_city_Invalid),Fields.InvalidMessage_marriage_county(le.marriage_county_Invalid),Fields.InvalidMessage_marriage_filing_number(le.marriage_filing_number_Invalid),Fields.InvalidMessage_marriage_docket_volume(le.marriage_docket_volume_Invalid),Fields.InvalidMessage_divorce_filing_dt(le.divorce_filing_dt_Invalid),Fields.InvalidMessage_divorce_dt(le.divorce_dt_Invalid),Fields.InvalidMessage_divorce_docket_volume(le.divorce_docket_volume_Invalid),Fields.InvalidMessage_divorce_filing_number(le.divorce_filing_number_Invalid),Fields.InvalidMessage_divorce_city(le.divorce_city_Invalid),Fields.InvalidMessage_divorce_county(le.divorce_county_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.record_id_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.filing_type_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.source_file_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_type_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_name_format_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.party1_name_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_alias_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_dob_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_birth_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_race_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_addr1_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_county_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party1_last_marriage_end_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party2_type_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party2_name_format_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.party2_name_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party2_dob_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party2_birth_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party2_addr1_Invalid,'CAPS','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party2_county_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.party2_last_marriage_end_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.marriage_filing_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.marriage_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.marriage_city_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.marriage_county_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.marriage_filing_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.marriage_docket_volume_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.divorce_filing_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.divorce_dt_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.divorce_docket_volume_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.divorce_filing_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.divorce_city_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.divorce_county_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_id','filing_type','vendor','source_file','process_date','state_origin','party1_type','party1_name_format','party1_name','party1_alias','party1_dob','party1_birth_state','party1_race','party1_addr1','party1_county','party1_last_marriage_end_dt','party2_type','party2_name_format','party2_name','party2_dob','party2_birth_state','party2_addr1','party2_county','party2_last_marriage_end_dt','marriage_filing_dt','marriage_dt','marriage_city','marriage_county','marriage_filing_number','marriage_docket_volume','divorce_filing_dt','divorce_dt','divorce_docket_volume','divorce_filing_number','divorce_city','divorce_county','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_date','invalid_date','invalid_date','invalid_date','invalid_Num','invalid_filing_type','invalid_vendor','invalid_source_file','invalid_date','invalid_state','invalid_party_type','invalid_name_format','invalid_name','invalid_name','invalid_date','invalid_state','invalid_race','invalid_address','invalid_county','invalid_date','invalid_party_type','invalid_name_format','invalid_name','invalid_date','invalid_state','invalid_address','invalid_county','invalid_date','invalid_date','invalid_date','invalid_city','invalid_county','invalid_filing_number','invalid_docket_volume','invalid_date','invalid_date','invalid_docket_volume','invalid_filing_number','invalid_city','invalid_county','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.record_id,(SALT311.StrType)le.filing_type,(SALT311.StrType)le.vendor,(SALT311.StrType)le.source_file,(SALT311.StrType)le.process_date,(SALT311.StrType)le.state_origin,(SALT311.StrType)le.party1_type,(SALT311.StrType)le.party1_name_format,(SALT311.StrType)le.party1_name,(SALT311.StrType)le.party1_alias,(SALT311.StrType)le.party1_dob,(SALT311.StrType)le.party1_birth_state,(SALT311.StrType)le.party1_race,(SALT311.StrType)le.party1_addr1,(SALT311.StrType)le.party1_county,(SALT311.StrType)le.party1_last_marriage_end_dt,(SALT311.StrType)le.party2_type,(SALT311.StrType)le.party2_name_format,(SALT311.StrType)le.party2_name,(SALT311.StrType)le.party2_dob,(SALT311.StrType)le.party2_birth_state,(SALT311.StrType)le.party2_addr1,(SALT311.StrType)le.party2_county,(SALT311.StrType)le.party2_last_marriage_end_dt,(SALT311.StrType)le.marriage_filing_dt,(SALT311.StrType)le.marriage_dt,(SALT311.StrType)le.marriage_city,(SALT311.StrType)le.marriage_county,(SALT311.StrType)le.marriage_filing_number,(SALT311.StrType)le.marriage_docket_volume,(SALT311.StrType)le.divorce_filing_dt,(SALT311.StrType)le.divorce_dt,(SALT311.StrType)le.divorce_docket_volume,(SALT311.StrType)le.divorce_filing_number,(SALT311.StrType)le.divorce_city,(SALT311.StrType)le.divorce_county,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,40,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Marriage_Divorce_V2_Profile) prevDS = DATASET([], Layout_Marriage_Divorce_V2_Profile), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:invalid_date:ALLOW','dt_first_seen:invalid_date:LENGTHS'
          ,'dt_last_seen:invalid_date:ALLOW','dt_last_seen:invalid_date:LENGTHS'
          ,'dt_vendor_first_reported:invalid_date:ALLOW','dt_vendor_first_reported:invalid_date:LENGTHS'
          ,'dt_vendor_last_reported:invalid_date:ALLOW','dt_vendor_last_reported:invalid_date:LENGTHS'
          ,'record_id:invalid_Num:ALLOW','record_id:invalid_Num:LENGTHS'
          ,'filing_type:invalid_filing_type:ALLOW','filing_type:invalid_filing_type:LENGTHS'
          ,'vendor:invalid_vendor:ALLOW','vendor:invalid_vendor:LENGTHS'
          ,'source_file:invalid_source_file:ALLOW','source_file:invalid_source_file:LENGTHS'
          ,'process_date:invalid_date:ALLOW','process_date:invalid_date:LENGTHS'
          ,'state_origin:invalid_state:ALLOW','state_origin:invalid_state:LENGTHS'
          ,'party1_type:invalid_party_type:CAPS','party1_type:invalid_party_type:ALLOW','party1_type:invalid_party_type:LENGTHS'
          ,'party1_name_format:invalid_name_format:ENUM'
          ,'party1_name:invalid_name:ALLOW','party1_name:invalid_name:LENGTHS'
          ,'party1_alias:invalid_name:ALLOW','party1_alias:invalid_name:LENGTHS'
          ,'party1_dob:invalid_date:ALLOW','party1_dob:invalid_date:LENGTHS'
          ,'party1_birth_state:invalid_state:ALLOW','party1_birth_state:invalid_state:LENGTHS'
          ,'party1_race:invalid_race:ALLOW','party1_race:invalid_race:LENGTHS'
          ,'party1_addr1:invalid_address:CAPS','party1_addr1:invalid_address:ALLOW','party1_addr1:invalid_address:LENGTHS'
          ,'party1_county:invalid_county:ALLOW','party1_county:invalid_county:LENGTHS'
          ,'party1_last_marriage_end_dt:invalid_date:ALLOW','party1_last_marriage_end_dt:invalid_date:LENGTHS'
          ,'party2_type:invalid_party_type:CAPS','party2_type:invalid_party_type:ALLOW','party2_type:invalid_party_type:LENGTHS'
          ,'party2_name_format:invalid_name_format:ENUM'
          ,'party2_name:invalid_name:ALLOW','party2_name:invalid_name:LENGTHS'
          ,'party2_dob:invalid_date:ALLOW','party2_dob:invalid_date:LENGTHS'
          ,'party2_birth_state:invalid_state:ALLOW','party2_birth_state:invalid_state:LENGTHS'
          ,'party2_addr1:invalid_address:CAPS','party2_addr1:invalid_address:ALLOW','party2_addr1:invalid_address:LENGTHS'
          ,'party2_county:invalid_county:ALLOW','party2_county:invalid_county:LENGTHS'
          ,'party2_last_marriage_end_dt:invalid_date:ALLOW','party2_last_marriage_end_dt:invalid_date:LENGTHS'
          ,'marriage_filing_dt:invalid_date:ALLOW','marriage_filing_dt:invalid_date:LENGTHS'
          ,'marriage_dt:invalid_date:ALLOW','marriage_dt:invalid_date:LENGTHS'
          ,'marriage_city:invalid_city:ALLOW','marriage_city:invalid_city:LENGTHS'
          ,'marriage_county:invalid_county:ALLOW','marriage_county:invalid_county:LENGTHS'
          ,'marriage_filing_number:invalid_filing_number:ALLOW','marriage_filing_number:invalid_filing_number:LENGTHS'
          ,'marriage_docket_volume:invalid_docket_volume:ALLOW','marriage_docket_volume:invalid_docket_volume:LENGTHS'
          ,'divorce_filing_dt:invalid_date:ALLOW','divorce_filing_dt:invalid_date:LENGTHS'
          ,'divorce_dt:invalid_date:ALLOW','divorce_dt:invalid_date:LENGTHS'
          ,'divorce_docket_volume:invalid_docket_volume:ALLOW','divorce_docket_volume:invalid_docket_volume:LENGTHS'
          ,'divorce_filing_number:invalid_filing_number:ALLOW','divorce_filing_number:invalid_filing_number:LENGTHS'
          ,'divorce_city:invalid_city:ALLOW','divorce_city:invalid_city:LENGTHS'
          ,'divorce_county:invalid_county:ALLOW','divorce_county:invalid_county:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_dt_first_seen(1),Fields.InvalidMessage_dt_first_seen(2)
          ,Fields.InvalidMessage_dt_last_seen(1),Fields.InvalidMessage_dt_last_seen(2)
          ,Fields.InvalidMessage_dt_vendor_first_reported(1),Fields.InvalidMessage_dt_vendor_first_reported(2)
          ,Fields.InvalidMessage_dt_vendor_last_reported(1),Fields.InvalidMessage_dt_vendor_last_reported(2)
          ,Fields.InvalidMessage_record_id(1),Fields.InvalidMessage_record_id(2)
          ,Fields.InvalidMessage_filing_type(1),Fields.InvalidMessage_filing_type(2)
          ,Fields.InvalidMessage_vendor(1),Fields.InvalidMessage_vendor(2)
          ,Fields.InvalidMessage_source_file(1),Fields.InvalidMessage_source_file(2)
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_state_origin(1),Fields.InvalidMessage_state_origin(2)
          ,Fields.InvalidMessage_party1_type(1),Fields.InvalidMessage_party1_type(2),Fields.InvalidMessage_party1_type(3)
          ,Fields.InvalidMessage_party1_name_format(1)
          ,Fields.InvalidMessage_party1_name(1),Fields.InvalidMessage_party1_name(2)
          ,Fields.InvalidMessage_party1_alias(1),Fields.InvalidMessage_party1_alias(2)
          ,Fields.InvalidMessage_party1_dob(1),Fields.InvalidMessage_party1_dob(2)
          ,Fields.InvalidMessage_party1_birth_state(1),Fields.InvalidMessage_party1_birth_state(2)
          ,Fields.InvalidMessage_party1_race(1),Fields.InvalidMessage_party1_race(2)
          ,Fields.InvalidMessage_party1_addr1(1),Fields.InvalidMessage_party1_addr1(2),Fields.InvalidMessage_party1_addr1(3)
          ,Fields.InvalidMessage_party1_county(1),Fields.InvalidMessage_party1_county(2)
          ,Fields.InvalidMessage_party1_last_marriage_end_dt(1),Fields.InvalidMessage_party1_last_marriage_end_dt(2)
          ,Fields.InvalidMessage_party2_type(1),Fields.InvalidMessage_party2_type(2),Fields.InvalidMessage_party2_type(3)
          ,Fields.InvalidMessage_party2_name_format(1)
          ,Fields.InvalidMessage_party2_name(1),Fields.InvalidMessage_party2_name(2)
          ,Fields.InvalidMessage_party2_dob(1),Fields.InvalidMessage_party2_dob(2)
          ,Fields.InvalidMessage_party2_birth_state(1),Fields.InvalidMessage_party2_birth_state(2)
          ,Fields.InvalidMessage_party2_addr1(1),Fields.InvalidMessage_party2_addr1(2),Fields.InvalidMessage_party2_addr1(3)
          ,Fields.InvalidMessage_party2_county(1),Fields.InvalidMessage_party2_county(2)
          ,Fields.InvalidMessage_party2_last_marriage_end_dt(1),Fields.InvalidMessage_party2_last_marriage_end_dt(2)
          ,Fields.InvalidMessage_marriage_filing_dt(1),Fields.InvalidMessage_marriage_filing_dt(2)
          ,Fields.InvalidMessage_marriage_dt(1),Fields.InvalidMessage_marriage_dt(2)
          ,Fields.InvalidMessage_marriage_city(1),Fields.InvalidMessage_marriage_city(2)
          ,Fields.InvalidMessage_marriage_county(1),Fields.InvalidMessage_marriage_county(2)
          ,Fields.InvalidMessage_marriage_filing_number(1),Fields.InvalidMessage_marriage_filing_number(2)
          ,Fields.InvalidMessage_marriage_docket_volume(1),Fields.InvalidMessage_marriage_docket_volume(2)
          ,Fields.InvalidMessage_divorce_filing_dt(1),Fields.InvalidMessage_divorce_filing_dt(2)
          ,Fields.InvalidMessage_divorce_dt(1),Fields.InvalidMessage_divorce_dt(2)
          ,Fields.InvalidMessage_divorce_docket_volume(1),Fields.InvalidMessage_divorce_docket_volume(2)
          ,Fields.InvalidMessage_divorce_filing_number(1),Fields.InvalidMessage_divorce_filing_number(2)
          ,Fields.InvalidMessage_divorce_city(1),Fields.InvalidMessage_divorce_city(2)
          ,Fields.InvalidMessage_divorce_county(1),Fields.InvalidMessage_divorce_county(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTHS_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTHS_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTHS_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTHS_ErrorCount
          ,le.record_id_ALLOW_ErrorCount,le.record_id_LENGTHS_ErrorCount
          ,le.filing_type_ALLOW_ErrorCount,le.filing_type_LENGTHS_ErrorCount
          ,le.vendor_ALLOW_ErrorCount,le.vendor_LENGTHS_ErrorCount
          ,le.source_file_ALLOW_ErrorCount,le.source_file_LENGTHS_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTHS_ErrorCount
          ,le.party1_type_CAPS_ErrorCount,le.party1_type_ALLOW_ErrorCount,le.party1_type_LENGTHS_ErrorCount
          ,le.party1_name_format_ENUM_ErrorCount
          ,le.party1_name_ALLOW_ErrorCount,le.party1_name_LENGTHS_ErrorCount
          ,le.party1_alias_ALLOW_ErrorCount,le.party1_alias_LENGTHS_ErrorCount
          ,le.party1_dob_ALLOW_ErrorCount,le.party1_dob_LENGTHS_ErrorCount
          ,le.party1_birth_state_ALLOW_ErrorCount,le.party1_birth_state_LENGTHS_ErrorCount
          ,le.party1_race_ALLOW_ErrorCount,le.party1_race_LENGTHS_ErrorCount
          ,le.party1_addr1_CAPS_ErrorCount,le.party1_addr1_ALLOW_ErrorCount,le.party1_addr1_LENGTHS_ErrorCount
          ,le.party1_county_ALLOW_ErrorCount,le.party1_county_LENGTHS_ErrorCount
          ,le.party1_last_marriage_end_dt_ALLOW_ErrorCount,le.party1_last_marriage_end_dt_LENGTHS_ErrorCount
          ,le.party2_type_CAPS_ErrorCount,le.party2_type_ALLOW_ErrorCount,le.party2_type_LENGTHS_ErrorCount
          ,le.party2_name_format_ENUM_ErrorCount
          ,le.party2_name_ALLOW_ErrorCount,le.party2_name_LENGTHS_ErrorCount
          ,le.party2_dob_ALLOW_ErrorCount,le.party2_dob_LENGTHS_ErrorCount
          ,le.party2_birth_state_ALLOW_ErrorCount,le.party2_birth_state_LENGTHS_ErrorCount
          ,le.party2_addr1_CAPS_ErrorCount,le.party2_addr1_ALLOW_ErrorCount,le.party2_addr1_LENGTHS_ErrorCount
          ,le.party2_county_ALLOW_ErrorCount,le.party2_county_LENGTHS_ErrorCount
          ,le.party2_last_marriage_end_dt_ALLOW_ErrorCount,le.party2_last_marriage_end_dt_LENGTHS_ErrorCount
          ,le.marriage_filing_dt_ALLOW_ErrorCount,le.marriage_filing_dt_LENGTHS_ErrorCount
          ,le.marriage_dt_ALLOW_ErrorCount,le.marriage_dt_LENGTHS_ErrorCount
          ,le.marriage_city_ALLOW_ErrorCount,le.marriage_city_LENGTHS_ErrorCount
          ,le.marriage_county_ALLOW_ErrorCount,le.marriage_county_LENGTHS_ErrorCount
          ,le.marriage_filing_number_ALLOW_ErrorCount,le.marriage_filing_number_LENGTHS_ErrorCount
          ,le.marriage_docket_volume_ALLOW_ErrorCount,le.marriage_docket_volume_LENGTHS_ErrorCount
          ,le.divorce_filing_dt_ALLOW_ErrorCount,le.divorce_filing_dt_LENGTHS_ErrorCount
          ,le.divorce_dt_ALLOW_ErrorCount,le.divorce_dt_LENGTHS_ErrorCount
          ,le.divorce_docket_volume_ALLOW_ErrorCount,le.divorce_docket_volume_LENGTHS_ErrorCount
          ,le.divorce_filing_number_ALLOW_ErrorCount,le.divorce_filing_number_LENGTHS_ErrorCount
          ,le.divorce_city_ALLOW_ErrorCount,le.divorce_city_LENGTHS_ErrorCount
          ,le.divorce_county_ALLOW_ErrorCount,le.divorce_county_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_seen_ALLOW_ErrorCount,le.dt_first_seen_LENGTHS_ErrorCount
          ,le.dt_last_seen_ALLOW_ErrorCount,le.dt_last_seen_LENGTHS_ErrorCount
          ,le.dt_vendor_first_reported_ALLOW_ErrorCount,le.dt_vendor_first_reported_LENGTHS_ErrorCount
          ,le.dt_vendor_last_reported_ALLOW_ErrorCount,le.dt_vendor_last_reported_LENGTHS_ErrorCount
          ,le.record_id_ALLOW_ErrorCount,le.record_id_LENGTHS_ErrorCount
          ,le.filing_type_ALLOW_ErrorCount,le.filing_type_LENGTHS_ErrorCount
          ,le.vendor_ALLOW_ErrorCount,le.vendor_LENGTHS_ErrorCount
          ,le.source_file_ALLOW_ErrorCount,le.source_file_LENGTHS_ErrorCount
          ,le.process_date_ALLOW_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount,le.state_origin_LENGTHS_ErrorCount
          ,le.party1_type_CAPS_ErrorCount,le.party1_type_ALLOW_ErrorCount,le.party1_type_LENGTHS_ErrorCount
          ,le.party1_name_format_ENUM_ErrorCount
          ,le.party1_name_ALLOW_ErrorCount,le.party1_name_LENGTHS_ErrorCount
          ,le.party1_alias_ALLOW_ErrorCount,le.party1_alias_LENGTHS_ErrorCount
          ,le.party1_dob_ALLOW_ErrorCount,le.party1_dob_LENGTHS_ErrorCount
          ,le.party1_birth_state_ALLOW_ErrorCount,le.party1_birth_state_LENGTHS_ErrorCount
          ,le.party1_race_ALLOW_ErrorCount,le.party1_race_LENGTHS_ErrorCount
          ,le.party1_addr1_CAPS_ErrorCount,le.party1_addr1_ALLOW_ErrorCount,le.party1_addr1_LENGTHS_ErrorCount
          ,le.party1_county_ALLOW_ErrorCount,le.party1_county_LENGTHS_ErrorCount
          ,le.party1_last_marriage_end_dt_ALLOW_ErrorCount,le.party1_last_marriage_end_dt_LENGTHS_ErrorCount
          ,le.party2_type_CAPS_ErrorCount,le.party2_type_ALLOW_ErrorCount,le.party2_type_LENGTHS_ErrorCount
          ,le.party2_name_format_ENUM_ErrorCount
          ,le.party2_name_ALLOW_ErrorCount,le.party2_name_LENGTHS_ErrorCount
          ,le.party2_dob_ALLOW_ErrorCount,le.party2_dob_LENGTHS_ErrorCount
          ,le.party2_birth_state_ALLOW_ErrorCount,le.party2_birth_state_LENGTHS_ErrorCount
          ,le.party2_addr1_CAPS_ErrorCount,le.party2_addr1_ALLOW_ErrorCount,le.party2_addr1_LENGTHS_ErrorCount
          ,le.party2_county_ALLOW_ErrorCount,le.party2_county_LENGTHS_ErrorCount
          ,le.party2_last_marriage_end_dt_ALLOW_ErrorCount,le.party2_last_marriage_end_dt_LENGTHS_ErrorCount
          ,le.marriage_filing_dt_ALLOW_ErrorCount,le.marriage_filing_dt_LENGTHS_ErrorCount
          ,le.marriage_dt_ALLOW_ErrorCount,le.marriage_dt_LENGTHS_ErrorCount
          ,le.marriage_city_ALLOW_ErrorCount,le.marriage_city_LENGTHS_ErrorCount
          ,le.marriage_county_ALLOW_ErrorCount,le.marriage_county_LENGTHS_ErrorCount
          ,le.marriage_filing_number_ALLOW_ErrorCount,le.marriage_filing_number_LENGTHS_ErrorCount
          ,le.marriage_docket_volume_ALLOW_ErrorCount,le.marriage_docket_volume_LENGTHS_ErrorCount
          ,le.divorce_filing_dt_ALLOW_ErrorCount,le.divorce_filing_dt_LENGTHS_ErrorCount
          ,le.divorce_dt_ALLOW_ErrorCount,le.divorce_dt_LENGTHS_ErrorCount
          ,le.divorce_docket_volume_ALLOW_ErrorCount,le.divorce_docket_volume_LENGTHS_ErrorCount
          ,le.divorce_filing_number_ALLOW_ErrorCount,le.divorce_filing_number_LENGTHS_ErrorCount
          ,le.divorce_city_ALLOW_ErrorCount,le.divorce_city_LENGTHS_ErrorCount
          ,le.divorce_county_ALLOW_ErrorCount,le.divorce_county_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_Marriage_Divorce_V2_Profile));
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
          ,'record_id:' + getFieldTypeText(h.record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_type:' + getFieldTypeText(h.filing_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_subtype:' + getFieldTypeText(h.filing_subtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_file:' + getFieldTypeText(h.source_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_type:' + getFieldTypeText(h.party1_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_name_format:' + getFieldTypeText(h.party1_name_format) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_name:' + getFieldTypeText(h.party1_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_alias:' + getFieldTypeText(h.party1_alias) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_dob:' + getFieldTypeText(h.party1_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_birth_state:' + getFieldTypeText(h.party1_birth_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_age:' + getFieldTypeText(h.party1_age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_race:' + getFieldTypeText(h.party1_race) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_addr1:' + getFieldTypeText(h.party1_addr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_csz:' + getFieldTypeText(h.party1_csz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_county:' + getFieldTypeText(h.party1_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_previous_marital_status:' + getFieldTypeText(h.party1_previous_marital_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_how_marriage_ended:' + getFieldTypeText(h.party1_how_marriage_ended) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_times_married:' + getFieldTypeText(h.party1_times_married) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party1_last_marriage_end_dt:' + getFieldTypeText(h.party1_last_marriage_end_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_type:' + getFieldTypeText(h.party2_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_name_format:' + getFieldTypeText(h.party2_name_format) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_name:' + getFieldTypeText(h.party2_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_alias:' + getFieldTypeText(h.party2_alias) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_dob:' + getFieldTypeText(h.party2_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_birth_state:' + getFieldTypeText(h.party2_birth_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_age:' + getFieldTypeText(h.party2_age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_race:' + getFieldTypeText(h.party2_race) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_addr1:' + getFieldTypeText(h.party2_addr1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_csz:' + getFieldTypeText(h.party2_csz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_county:' + getFieldTypeText(h.party2_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_previous_marital_status:' + getFieldTypeText(h.party2_previous_marital_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_how_marriage_ended:' + getFieldTypeText(h.party2_how_marriage_ended) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_times_married:' + getFieldTypeText(h.party2_times_married) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party2_last_marriage_end_dt:' + getFieldTypeText(h.party2_last_marriage_end_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'number_of_children:' + getFieldTypeText(h.number_of_children) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriage_filing_dt:' + getFieldTypeText(h.marriage_filing_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriage_dt:' + getFieldTypeText(h.marriage_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriage_city:' + getFieldTypeText(h.marriage_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriage_county:' + getFieldTypeText(h.marriage_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'place_of_marriage:' + getFieldTypeText(h.place_of_marriage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_of_ceremony:' + getFieldTypeText(h.type_of_ceremony) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriage_filing_number:' + getFieldTypeText(h.marriage_filing_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriage_docket_volume:' + getFieldTypeText(h.marriage_docket_volume) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'divorce_filing_dt:' + getFieldTypeText(h.divorce_filing_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'divorce_dt:' + getFieldTypeText(h.divorce_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'divorce_docket_volume:' + getFieldTypeText(h.divorce_docket_volume) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'divorce_filing_number:' + getFieldTypeText(h.divorce_filing_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'divorce_city:' + getFieldTypeText(h.divorce_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'divorce_county:' + getFieldTypeText(h.divorce_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'grounds_for_divorce:' + getFieldTypeText(h.grounds_for_divorce) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriage_duration_cd:' + getFieldTypeText(h.marriage_duration_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'marriage_duration:' + getFieldTypeText(h.marriage_duration) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_record_id_cnt
          ,le.populated_filing_type_cnt
          ,le.populated_filing_subtype_cnt
          ,le.populated_vendor_cnt
          ,le.populated_source_file_cnt
          ,le.populated_process_date_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_party1_type_cnt
          ,le.populated_party1_name_format_cnt
          ,le.populated_party1_name_cnt
          ,le.populated_party1_alias_cnt
          ,le.populated_party1_dob_cnt
          ,le.populated_party1_birth_state_cnt
          ,le.populated_party1_age_cnt
          ,le.populated_party1_race_cnt
          ,le.populated_party1_addr1_cnt
          ,le.populated_party1_csz_cnt
          ,le.populated_party1_county_cnt
          ,le.populated_party1_previous_marital_status_cnt
          ,le.populated_party1_how_marriage_ended_cnt
          ,le.populated_party1_times_married_cnt
          ,le.populated_party1_last_marriage_end_dt_cnt
          ,le.populated_party2_type_cnt
          ,le.populated_party2_name_format_cnt
          ,le.populated_party2_name_cnt
          ,le.populated_party2_alias_cnt
          ,le.populated_party2_dob_cnt
          ,le.populated_party2_birth_state_cnt
          ,le.populated_party2_age_cnt
          ,le.populated_party2_race_cnt
          ,le.populated_party2_addr1_cnt
          ,le.populated_party2_csz_cnt
          ,le.populated_party2_county_cnt
          ,le.populated_party2_previous_marital_status_cnt
          ,le.populated_party2_how_marriage_ended_cnt
          ,le.populated_party2_times_married_cnt
          ,le.populated_party2_last_marriage_end_dt_cnt
          ,le.populated_number_of_children_cnt
          ,le.populated_marriage_filing_dt_cnt
          ,le.populated_marriage_dt_cnt
          ,le.populated_marriage_city_cnt
          ,le.populated_marriage_county_cnt
          ,le.populated_place_of_marriage_cnt
          ,le.populated_type_of_ceremony_cnt
          ,le.populated_marriage_filing_number_cnt
          ,le.populated_marriage_docket_volume_cnt
          ,le.populated_divorce_filing_dt_cnt
          ,le.populated_divorce_dt_cnt
          ,le.populated_divorce_docket_volume_cnt
          ,le.populated_divorce_filing_number_cnt
          ,le.populated_divorce_city_cnt
          ,le.populated_divorce_county_cnt
          ,le.populated_grounds_for_divorce_cnt
          ,le.populated_marriage_duration_cd_cnt
          ,le.populated_marriage_duration_cnt
          ,le.populated_persistent_record_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_record_id_pcnt
          ,le.populated_filing_type_pcnt
          ,le.populated_filing_subtype_pcnt
          ,le.populated_vendor_pcnt
          ,le.populated_source_file_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_party1_type_pcnt
          ,le.populated_party1_name_format_pcnt
          ,le.populated_party1_name_pcnt
          ,le.populated_party1_alias_pcnt
          ,le.populated_party1_dob_pcnt
          ,le.populated_party1_birth_state_pcnt
          ,le.populated_party1_age_pcnt
          ,le.populated_party1_race_pcnt
          ,le.populated_party1_addr1_pcnt
          ,le.populated_party1_csz_pcnt
          ,le.populated_party1_county_pcnt
          ,le.populated_party1_previous_marital_status_pcnt
          ,le.populated_party1_how_marriage_ended_pcnt
          ,le.populated_party1_times_married_pcnt
          ,le.populated_party1_last_marriage_end_dt_pcnt
          ,le.populated_party2_type_pcnt
          ,le.populated_party2_name_format_pcnt
          ,le.populated_party2_name_pcnt
          ,le.populated_party2_alias_pcnt
          ,le.populated_party2_dob_pcnt
          ,le.populated_party2_birth_state_pcnt
          ,le.populated_party2_age_pcnt
          ,le.populated_party2_race_pcnt
          ,le.populated_party2_addr1_pcnt
          ,le.populated_party2_csz_pcnt
          ,le.populated_party2_county_pcnt
          ,le.populated_party2_previous_marital_status_pcnt
          ,le.populated_party2_how_marriage_ended_pcnt
          ,le.populated_party2_times_married_pcnt
          ,le.populated_party2_last_marriage_end_dt_pcnt
          ,le.populated_number_of_children_pcnt
          ,le.populated_marriage_filing_dt_pcnt
          ,le.populated_marriage_dt_pcnt
          ,le.populated_marriage_city_pcnt
          ,le.populated_marriage_county_pcnt
          ,le.populated_place_of_marriage_pcnt
          ,le.populated_type_of_ceremony_pcnt
          ,le.populated_marriage_filing_number_pcnt
          ,le.populated_marriage_docket_volume_pcnt
          ,le.populated_divorce_filing_dt_pcnt
          ,le.populated_divorce_dt_pcnt
          ,le.populated_divorce_docket_volume_pcnt
          ,le.populated_divorce_filing_number_pcnt
          ,le.populated_divorce_city_pcnt
          ,le.populated_divorce_county_pcnt
          ,le.populated_grounds_for_divorce_pcnt
          ,le.populated_marriage_duration_cd_pcnt
          ,le.populated_marriage_duration_pcnt
          ,le.populated_persistent_record_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,60,xNormHygieneStats(LEFT,COUNTER,'POP'));

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

    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Marriage_Divorce_V2_Profile));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),60,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Layout_Marriage_Divorce_V2_Profile) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Marriage_Divorce_V2, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
