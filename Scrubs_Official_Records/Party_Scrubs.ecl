IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Official_Records; // Import modules for FieldTypes attribute definitions
EXPORT Party_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 43;
  EXPORT NumRulesFromFieldType := 43;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 43;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Party_Layout_Official_Records)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 vendor_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 official_record_key_Invalid;
    UNSIGNED1 doc_filed_dt_Invalid;
    UNSIGNED1 doc_type_desc_Invalid;
    UNSIGNED1 entity_type_cd_Invalid;
    UNSIGNED1 title1_Invalid;
    UNSIGNED1 fname1_Invalid;
    UNSIGNED1 mname1_Invalid;
    UNSIGNED1 lname1_Invalid;
    UNSIGNED1 suffix1_Invalid;
    UNSIGNED1 pname1_score_Invalid;
    UNSIGNED1 cname1_Invalid;
    UNSIGNED1 title2_Invalid;
    UNSIGNED1 fname2_Invalid;
    UNSIGNED1 mname2_Invalid;
    UNSIGNED1 lname2_Invalid;
    UNSIGNED1 suffix2_Invalid;
    UNSIGNED1 pname2_score_Invalid;
    UNSIGNED1 cname2_Invalid;
    UNSIGNED1 title3_Invalid;
    UNSIGNED1 fname3_Invalid;
    UNSIGNED1 mname3_Invalid;
    UNSIGNED1 lname3_Invalid;
    UNSIGNED1 suffix3_Invalid;
    UNSIGNED1 pname3_score_Invalid;
    UNSIGNED1 cname3_Invalid;
    UNSIGNED1 title4_Invalid;
    UNSIGNED1 fname4_Invalid;
    UNSIGNED1 mname4_Invalid;
    UNSIGNED1 lname4_Invalid;
    UNSIGNED1 suffix4_Invalid;
    UNSIGNED1 pname4_score_Invalid;
    UNSIGNED1 cname4_Invalid;
    UNSIGNED1 title5_Invalid;
    UNSIGNED1 fname5_Invalid;
    UNSIGNED1 mname5_Invalid;
    UNSIGNED1 lname5_Invalid;
    UNSIGNED1 suffix5_Invalid;
    UNSIGNED1 pname5_score_Invalid;
    UNSIGNED1 cname5_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Party_Layout_Official_Records)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Party_Layout_Official_Records) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Party_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.vendor_Invalid := Party_Fields.InValid_vendor((SALT311.StrType)le.vendor);
    SELF.state_origin_Invalid := Party_Fields.InValid_state_origin((SALT311.StrType)le.state_origin);
    SELF.county_name_Invalid := Party_Fields.InValid_county_name((SALT311.StrType)le.county_name);
    SELF.official_record_key_Invalid := Party_Fields.InValid_official_record_key((SALT311.StrType)le.official_record_key);
    SELF.doc_filed_dt_Invalid := Party_Fields.InValid_doc_filed_dt((SALT311.StrType)le.doc_filed_dt);
    SELF.doc_type_desc_Invalid := Party_Fields.InValid_doc_type_desc((SALT311.StrType)le.doc_type_desc);
    SELF.entity_type_cd_Invalid := Party_Fields.InValid_entity_type_cd((SALT311.StrType)le.entity_type_cd);
    SELF.title1_Invalid := Party_Fields.InValid_title1((SALT311.StrType)le.title1);
    SELF.fname1_Invalid := Party_Fields.InValid_fname1((SALT311.StrType)le.fname1);
    SELF.mname1_Invalid := Party_Fields.InValid_mname1((SALT311.StrType)le.mname1);
    SELF.lname1_Invalid := Party_Fields.InValid_lname1((SALT311.StrType)le.lname1);
    SELF.suffix1_Invalid := Party_Fields.InValid_suffix1((SALT311.StrType)le.suffix1);
    SELF.pname1_score_Invalid := Party_Fields.InValid_pname1_score((SALT311.StrType)le.pname1_score);
    SELF.cname1_Invalid := Party_Fields.InValid_cname1((SALT311.StrType)le.cname1);
    SELF.title2_Invalid := Party_Fields.InValid_title2((SALT311.StrType)le.title2);
    SELF.fname2_Invalid := Party_Fields.InValid_fname2((SALT311.StrType)le.fname2);
    SELF.mname2_Invalid := Party_Fields.InValid_mname2((SALT311.StrType)le.mname2);
    SELF.lname2_Invalid := Party_Fields.InValid_lname2((SALT311.StrType)le.lname2);
    SELF.suffix2_Invalid := Party_Fields.InValid_suffix2((SALT311.StrType)le.suffix2);
    SELF.pname2_score_Invalid := Party_Fields.InValid_pname2_score((SALT311.StrType)le.pname2_score);
    SELF.cname2_Invalid := Party_Fields.InValid_cname2((SALT311.StrType)le.cname2);
    SELF.title3_Invalid := Party_Fields.InValid_title3((SALT311.StrType)le.title3);
    SELF.fname3_Invalid := Party_Fields.InValid_fname3((SALT311.StrType)le.fname3);
    SELF.mname3_Invalid := Party_Fields.InValid_mname3((SALT311.StrType)le.mname3);
    SELF.lname3_Invalid := Party_Fields.InValid_lname3((SALT311.StrType)le.lname3);
    SELF.suffix3_Invalid := Party_Fields.InValid_suffix3((SALT311.StrType)le.suffix3);
    SELF.pname3_score_Invalid := Party_Fields.InValid_pname3_score((SALT311.StrType)le.pname3_score);
    SELF.cname3_Invalid := Party_Fields.InValid_cname3((SALT311.StrType)le.cname3);
    SELF.title4_Invalid := Party_Fields.InValid_title4((SALT311.StrType)le.title4);
    SELF.fname4_Invalid := Party_Fields.InValid_fname4((SALT311.StrType)le.fname4);
    SELF.mname4_Invalid := Party_Fields.InValid_mname4((SALT311.StrType)le.mname4);
    SELF.lname4_Invalid := Party_Fields.InValid_lname4((SALT311.StrType)le.lname4);
    SELF.suffix4_Invalid := Party_Fields.InValid_suffix4((SALT311.StrType)le.suffix4);
    SELF.pname4_score_Invalid := Party_Fields.InValid_pname4_score((SALT311.StrType)le.pname4_score);
    SELF.cname4_Invalid := Party_Fields.InValid_cname4((SALT311.StrType)le.cname4);
    SELF.title5_Invalid := Party_Fields.InValid_title5((SALT311.StrType)le.title5);
    SELF.fname5_Invalid := Party_Fields.InValid_fname5((SALT311.StrType)le.fname5);
    SELF.mname5_Invalid := Party_Fields.InValid_mname5((SALT311.StrType)le.mname5);
    SELF.lname5_Invalid := Party_Fields.InValid_lname5((SALT311.StrType)le.lname5);
    SELF.suffix5_Invalid := Party_Fields.InValid_suffix5((SALT311.StrType)le.suffix5);
    SELF.pname5_score_Invalid := Party_Fields.InValid_pname5_score((SALT311.StrType)le.pname5_score);
    SELF.cname5_Invalid := Party_Fields.InValid_cname5((SALT311.StrType)le.cname5);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Party_Layout_Official_Records);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.vendor_Invalid << 1 ) + ( le.state_origin_Invalid << 2 ) + ( le.county_name_Invalid << 3 ) + ( le.official_record_key_Invalid << 4 ) + ( le.doc_filed_dt_Invalid << 5 ) + ( le.doc_type_desc_Invalid << 6 ) + ( le.entity_type_cd_Invalid << 7 ) + ( le.title1_Invalid << 8 ) + ( le.fname1_Invalid << 9 ) + ( le.mname1_Invalid << 10 ) + ( le.lname1_Invalid << 11 ) + ( le.suffix1_Invalid << 12 ) + ( le.pname1_score_Invalid << 13 ) + ( le.cname1_Invalid << 14 ) + ( le.title2_Invalid << 15 ) + ( le.fname2_Invalid << 16 ) + ( le.mname2_Invalid << 17 ) + ( le.lname2_Invalid << 18 ) + ( le.suffix2_Invalid << 19 ) + ( le.pname2_score_Invalid << 20 ) + ( le.cname2_Invalid << 21 ) + ( le.title3_Invalid << 22 ) + ( le.fname3_Invalid << 23 ) + ( le.mname3_Invalid << 24 ) + ( le.lname3_Invalid << 25 ) + ( le.suffix3_Invalid << 26 ) + ( le.pname3_score_Invalid << 27 ) + ( le.cname3_Invalid << 28 ) + ( le.title4_Invalid << 29 ) + ( le.fname4_Invalid << 30 ) + ( le.mname4_Invalid << 31 ) + ( le.lname4_Invalid << 32 ) + ( le.suffix4_Invalid << 33 ) + ( le.pname4_score_Invalid << 34 ) + ( le.cname4_Invalid << 35 ) + ( le.title5_Invalid << 36 ) + ( le.fname5_Invalid << 37 ) + ( le.mname5_Invalid << 38 ) + ( le.lname5_Invalid << 39 ) + ( le.suffix5_Invalid << 40 ) + ( le.pname5_score_Invalid << 41 ) + ( le.cname5_Invalid << 42 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Party_Layout_Official_Records);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.vendor_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.official_record_key_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.doc_filed_dt_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.doc_type_desc_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.entity_type_cd_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.title1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.fname1_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.mname1_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.lname1_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.suffix1_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.pname1_score_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.cname1_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.title2_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.fname2_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.mname2_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.lname2_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.suffix2_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.pname2_score_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.cname2_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.title3_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.fname3_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.mname3_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.lname3_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.suffix3_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.pname3_score_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.cname3_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.title4_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.fname4_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.mname4_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.lname4_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.suffix4_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.pname4_score_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.cname4_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.title5_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.fname5_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.mname5_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.lname5_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.suffix5_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF.pname5_score_Invalid := (le.ScrubsBits1 >> 41) & 1;
    SELF.cname5_Invalid := (le.ScrubsBits1 >> 42) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    vendor_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    state_origin_ENUM_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    county_name_CUSTOM_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    official_record_key_LENGTHS_ErrorCount := COUNT(GROUP,h.official_record_key_Invalid=1);
    doc_filed_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.doc_filed_dt_Invalid=1);
    doc_type_desc_LENGTHS_ErrorCount := COUNT(GROUP,h.doc_type_desc_Invalid=1);
    entity_type_cd_LENGTHS_ErrorCount := COUNT(GROUP,h.entity_type_cd_Invalid=1);
    title1_ALLOW_ErrorCount := COUNT(GROUP,h.title1_Invalid=1);
    fname1_ALLOW_ErrorCount := COUNT(GROUP,h.fname1_Invalid=1);
    mname1_ALLOW_ErrorCount := COUNT(GROUP,h.mname1_Invalid=1);
    lname1_ALLOW_ErrorCount := COUNT(GROUP,h.lname1_Invalid=1);
    suffix1_ALLOW_ErrorCount := COUNT(GROUP,h.suffix1_Invalid=1);
    pname1_score_ALLOW_ErrorCount := COUNT(GROUP,h.pname1_score_Invalid=1);
    cname1_ALLOW_ErrorCount := COUNT(GROUP,h.cname1_Invalid=1);
    title2_ALLOW_ErrorCount := COUNT(GROUP,h.title2_Invalid=1);
    fname2_ALLOW_ErrorCount := COUNT(GROUP,h.fname2_Invalid=1);
    mname2_ALLOW_ErrorCount := COUNT(GROUP,h.mname2_Invalid=1);
    lname2_ALLOW_ErrorCount := COUNT(GROUP,h.lname2_Invalid=1);
    suffix2_ALLOW_ErrorCount := COUNT(GROUP,h.suffix2_Invalid=1);
    pname2_score_ALLOW_ErrorCount := COUNT(GROUP,h.pname2_score_Invalid=1);
    cname2_ALLOW_ErrorCount := COUNT(GROUP,h.cname2_Invalid=1);
    title3_ALLOW_ErrorCount := COUNT(GROUP,h.title3_Invalid=1);
    fname3_ALLOW_ErrorCount := COUNT(GROUP,h.fname3_Invalid=1);
    mname3_ALLOW_ErrorCount := COUNT(GROUP,h.mname3_Invalid=1);
    lname3_ALLOW_ErrorCount := COUNT(GROUP,h.lname3_Invalid=1);
    suffix3_ALLOW_ErrorCount := COUNT(GROUP,h.suffix3_Invalid=1);
    pname3_score_ALLOW_ErrorCount := COUNT(GROUP,h.pname3_score_Invalid=1);
    cname3_ALLOW_ErrorCount := COUNT(GROUP,h.cname3_Invalid=1);
    title4_ALLOW_ErrorCount := COUNT(GROUP,h.title4_Invalid=1);
    fname4_ALLOW_ErrorCount := COUNT(GROUP,h.fname4_Invalid=1);
    mname4_ALLOW_ErrorCount := COUNT(GROUP,h.mname4_Invalid=1);
    lname4_ALLOW_ErrorCount := COUNT(GROUP,h.lname4_Invalid=1);
    suffix4_ALLOW_ErrorCount := COUNT(GROUP,h.suffix4_Invalid=1);
    pname4_score_ALLOW_ErrorCount := COUNT(GROUP,h.pname4_score_Invalid=1);
    cname4_ALLOW_ErrorCount := COUNT(GROUP,h.cname4_Invalid=1);
    title5_ALLOW_ErrorCount := COUNT(GROUP,h.title5_Invalid=1);
    fname5_ALLOW_ErrorCount := COUNT(GROUP,h.fname5_Invalid=1);
    mname5_ALLOW_ErrorCount := COUNT(GROUP,h.mname5_Invalid=1);
    lname5_ALLOW_ErrorCount := COUNT(GROUP,h.lname5_Invalid=1);
    suffix5_ALLOW_ErrorCount := COUNT(GROUP,h.suffix5_Invalid=1);
    pname5_score_ALLOW_ErrorCount := COUNT(GROUP,h.pname5_score_Invalid=1);
    cname5_ALLOW_ErrorCount := COUNT(GROUP,h.cname5_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.vendor_Invalid > 0 OR h.state_origin_Invalid > 0 OR h.county_name_Invalid > 0 OR h.official_record_key_Invalid > 0 OR h.doc_filed_dt_Invalid > 0 OR h.doc_type_desc_Invalid > 0 OR h.entity_type_cd_Invalid > 0 OR h.title1_Invalid > 0 OR h.fname1_Invalid > 0 OR h.mname1_Invalid > 0 OR h.lname1_Invalid > 0 OR h.suffix1_Invalid > 0 OR h.pname1_score_Invalid > 0 OR h.cname1_Invalid > 0 OR h.title2_Invalid > 0 OR h.fname2_Invalid > 0 OR h.mname2_Invalid > 0 OR h.lname2_Invalid > 0 OR h.suffix2_Invalid > 0 OR h.pname2_score_Invalid > 0 OR h.cname2_Invalid > 0 OR h.title3_Invalid > 0 OR h.fname3_Invalid > 0 OR h.mname3_Invalid > 0 OR h.lname3_Invalid > 0 OR h.suffix3_Invalid > 0 OR h.pname3_score_Invalid > 0 OR h.cname3_Invalid > 0 OR h.title4_Invalid > 0 OR h.fname4_Invalid > 0 OR h.mname4_Invalid > 0 OR h.lname4_Invalid > 0 OR h.suffix4_Invalid > 0 OR h.pname4_score_Invalid > 0 OR h.cname4_Invalid > 0 OR h.title5_Invalid > 0 OR h.fname5_Invalid > 0 OR h.mname5_Invalid > 0 OR h.lname5_Invalid > 0 OR h.suffix5_Invalid > 0 OR h.pname5_score_Invalid > 0 OR h.cname5_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.official_record_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.doc_filed_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.doc_type_desc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.entity_type_cd_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname1_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname2_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname3_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname4_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname5_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname5_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.official_record_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.doc_filed_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.doc_type_desc_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.entity_type_cd_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.title1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname1_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname2_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname3_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname3_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname4_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.title5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lname5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pname5_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.cname5_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.vendor_Invalid,le.state_origin_Invalid,le.county_name_Invalid,le.official_record_key_Invalid,le.doc_filed_dt_Invalid,le.doc_type_desc_Invalid,le.entity_type_cd_Invalid,le.title1_Invalid,le.fname1_Invalid,le.mname1_Invalid,le.lname1_Invalid,le.suffix1_Invalid,le.pname1_score_Invalid,le.cname1_Invalid,le.title2_Invalid,le.fname2_Invalid,le.mname2_Invalid,le.lname2_Invalid,le.suffix2_Invalid,le.pname2_score_Invalid,le.cname2_Invalid,le.title3_Invalid,le.fname3_Invalid,le.mname3_Invalid,le.lname3_Invalid,le.suffix3_Invalid,le.pname3_score_Invalid,le.cname3_Invalid,le.title4_Invalid,le.fname4_Invalid,le.mname4_Invalid,le.lname4_Invalid,le.suffix4_Invalid,le.pname4_score_Invalid,le.cname4_Invalid,le.title5_Invalid,le.fname5_Invalid,le.mname5_Invalid,le.lname5_Invalid,le.suffix5_Invalid,le.pname5_score_Invalid,le.cname5_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Party_Fields.InvalidMessage_process_date(le.process_date_Invalid),Party_Fields.InvalidMessage_vendor(le.vendor_Invalid),Party_Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Party_Fields.InvalidMessage_county_name(le.county_name_Invalid),Party_Fields.InvalidMessage_official_record_key(le.official_record_key_Invalid),Party_Fields.InvalidMessage_doc_filed_dt(le.doc_filed_dt_Invalid),Party_Fields.InvalidMessage_doc_type_desc(le.doc_type_desc_Invalid),Party_Fields.InvalidMessage_entity_type_cd(le.entity_type_cd_Invalid),Party_Fields.InvalidMessage_title1(le.title1_Invalid),Party_Fields.InvalidMessage_fname1(le.fname1_Invalid),Party_Fields.InvalidMessage_mname1(le.mname1_Invalid),Party_Fields.InvalidMessage_lname1(le.lname1_Invalid),Party_Fields.InvalidMessage_suffix1(le.suffix1_Invalid),Party_Fields.InvalidMessage_pname1_score(le.pname1_score_Invalid),Party_Fields.InvalidMessage_cname1(le.cname1_Invalid),Party_Fields.InvalidMessage_title2(le.title2_Invalid),Party_Fields.InvalidMessage_fname2(le.fname2_Invalid),Party_Fields.InvalidMessage_mname2(le.mname2_Invalid),Party_Fields.InvalidMessage_lname2(le.lname2_Invalid),Party_Fields.InvalidMessage_suffix2(le.suffix2_Invalid),Party_Fields.InvalidMessage_pname2_score(le.pname2_score_Invalid),Party_Fields.InvalidMessage_cname2(le.cname2_Invalid),Party_Fields.InvalidMessage_title3(le.title3_Invalid),Party_Fields.InvalidMessage_fname3(le.fname3_Invalid),Party_Fields.InvalidMessage_mname3(le.mname3_Invalid),Party_Fields.InvalidMessage_lname3(le.lname3_Invalid),Party_Fields.InvalidMessage_suffix3(le.suffix3_Invalid),Party_Fields.InvalidMessage_pname3_score(le.pname3_score_Invalid),Party_Fields.InvalidMessage_cname3(le.cname3_Invalid),Party_Fields.InvalidMessage_title4(le.title4_Invalid),Party_Fields.InvalidMessage_fname4(le.fname4_Invalid),Party_Fields.InvalidMessage_mname4(le.mname4_Invalid),Party_Fields.InvalidMessage_lname4(le.lname4_Invalid),Party_Fields.InvalidMessage_suffix4(le.suffix4_Invalid),Party_Fields.InvalidMessage_pname4_score(le.pname4_score_Invalid),Party_Fields.InvalidMessage_cname4(le.cname4_Invalid),Party_Fields.InvalidMessage_title5(le.title5_Invalid),Party_Fields.InvalidMessage_fname5(le.fname5_Invalid),Party_Fields.InvalidMessage_mname5(le.mname5_Invalid),Party_Fields.InvalidMessage_lname5(le.lname5_Invalid),Party_Fields.InvalidMessage_suffix5(le.suffix5_Invalid),Party_Fields.InvalidMessage_pname5_score(le.pname5_score_Invalid),Party_Fields.InvalidMessage_cname5(le.cname5_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.official_record_key_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.doc_filed_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.doc_type_desc_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.entity_type_cd_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.title1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pname1_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cname1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pname2_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cname2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pname3_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cname3_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pname4_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cname4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.title5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fname5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mname5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lname5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pname5_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.cname5_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','vendor','state_origin','county_name','official_record_key','doc_filed_dt','doc_type_desc','entity_type_cd','title1','fname1','mname1','lname1','suffix1','pname1_score','cname1','title2','fname2','mname2','lname2','suffix2','pname2_score','cname2','title3','fname3','mname3','lname3','suffix3','pname3_score','cname3','title4','fname4','mname4','lname4','suffix4','pname4_score','cname4','title5','fname5','mname5','lname5','suffix5','pname5_score','cname5','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Num','Invalid_State','Invalid_County','Invalid_NonBlank','Invalid_Date','Invalid_NonBlank','Invalid_NonBlank','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Num','Invalid_Char','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.vendor,(SALT311.StrType)le.state_origin,(SALT311.StrType)le.county_name,(SALT311.StrType)le.official_record_key,(SALT311.StrType)le.doc_filed_dt,(SALT311.StrType)le.doc_type_desc,(SALT311.StrType)le.entity_type_cd,(SALT311.StrType)le.title1,(SALT311.StrType)le.fname1,(SALT311.StrType)le.mname1,(SALT311.StrType)le.lname1,(SALT311.StrType)le.suffix1,(SALT311.StrType)le.pname1_score,(SALT311.StrType)le.cname1,(SALT311.StrType)le.title2,(SALT311.StrType)le.fname2,(SALT311.StrType)le.mname2,(SALT311.StrType)le.lname2,(SALT311.StrType)le.suffix2,(SALT311.StrType)le.pname2_score,(SALT311.StrType)le.cname2,(SALT311.StrType)le.title3,(SALT311.StrType)le.fname3,(SALT311.StrType)le.mname3,(SALT311.StrType)le.lname3,(SALT311.StrType)le.suffix3,(SALT311.StrType)le.pname3_score,(SALT311.StrType)le.cname3,(SALT311.StrType)le.title4,(SALT311.StrType)le.fname4,(SALT311.StrType)le.mname4,(SALT311.StrType)le.lname4,(SALT311.StrType)le.suffix4,(SALT311.StrType)le.pname4_score,(SALT311.StrType)le.cname4,(SALT311.StrType)le.title5,(SALT311.StrType)le.fname5,(SALT311.StrType)le.mname5,(SALT311.StrType)le.lname5,(SALT311.StrType)le.suffix5,(SALT311.StrType)le.pname5_score,(SALT311.StrType)le.cname5,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,43,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Party_Layout_Official_Records) prevDS = DATASET([], Party_Layout_Official_Records), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:Invalid_Date:CUSTOM'
          ,'vendor:Invalid_Num:ALLOW'
          ,'state_origin:Invalid_State:ENUM'
          ,'county_name:Invalid_County:CUSTOM'
          ,'official_record_key:Invalid_NonBlank:LENGTHS'
          ,'doc_filed_dt:Invalid_Date:CUSTOM'
          ,'doc_type_desc:Invalid_NonBlank:LENGTHS'
          ,'entity_type_cd:Invalid_NonBlank:LENGTHS'
          ,'title1:Invalid_Char:ALLOW'
          ,'fname1:Invalid_Char:ALLOW'
          ,'mname1:Invalid_Char:ALLOW'
          ,'lname1:Invalid_Char:ALLOW'
          ,'suffix1:Invalid_Char:ALLOW'
          ,'pname1_score:Invalid_Num:ALLOW'
          ,'cname1:Invalid_Char:ALLOW'
          ,'title2:Invalid_Char:ALLOW'
          ,'fname2:Invalid_Char:ALLOW'
          ,'mname2:Invalid_Char:ALLOW'
          ,'lname2:Invalid_Char:ALLOW'
          ,'suffix2:Invalid_Char:ALLOW'
          ,'pname2_score:Invalid_Num:ALLOW'
          ,'cname2:Invalid_Char:ALLOW'
          ,'title3:Invalid_Char:ALLOW'
          ,'fname3:Invalid_Char:ALLOW'
          ,'mname3:Invalid_Char:ALLOW'
          ,'lname3:Invalid_Char:ALLOW'
          ,'suffix3:Invalid_Char:ALLOW'
          ,'pname3_score:Invalid_Num:ALLOW'
          ,'cname3:Invalid_Char:ALLOW'
          ,'title4:Invalid_Char:ALLOW'
          ,'fname4:Invalid_Char:ALLOW'
          ,'mname4:Invalid_Char:ALLOW'
          ,'lname4:Invalid_Char:ALLOW'
          ,'suffix4:Invalid_Char:ALLOW'
          ,'pname4_score:Invalid_Num:ALLOW'
          ,'cname4:Invalid_Char:ALLOW'
          ,'title5:Invalid_Char:ALLOW'
          ,'fname5:Invalid_Char:ALLOW'
          ,'mname5:Invalid_Char:ALLOW'
          ,'lname5:Invalid_Char:ALLOW'
          ,'suffix5:Invalid_Char:ALLOW'
          ,'pname5_score:Invalid_Num:ALLOW'
          ,'cname5:Invalid_Char:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Party_Fields.InvalidMessage_process_date(1)
          ,Party_Fields.InvalidMessage_vendor(1)
          ,Party_Fields.InvalidMessage_state_origin(1)
          ,Party_Fields.InvalidMessage_county_name(1)
          ,Party_Fields.InvalidMessage_official_record_key(1)
          ,Party_Fields.InvalidMessage_doc_filed_dt(1)
          ,Party_Fields.InvalidMessage_doc_type_desc(1)
          ,Party_Fields.InvalidMessage_entity_type_cd(1)
          ,Party_Fields.InvalidMessage_title1(1)
          ,Party_Fields.InvalidMessage_fname1(1)
          ,Party_Fields.InvalidMessage_mname1(1)
          ,Party_Fields.InvalidMessage_lname1(1)
          ,Party_Fields.InvalidMessage_suffix1(1)
          ,Party_Fields.InvalidMessage_pname1_score(1)
          ,Party_Fields.InvalidMessage_cname1(1)
          ,Party_Fields.InvalidMessage_title2(1)
          ,Party_Fields.InvalidMessage_fname2(1)
          ,Party_Fields.InvalidMessage_mname2(1)
          ,Party_Fields.InvalidMessage_lname2(1)
          ,Party_Fields.InvalidMessage_suffix2(1)
          ,Party_Fields.InvalidMessage_pname2_score(1)
          ,Party_Fields.InvalidMessage_cname2(1)
          ,Party_Fields.InvalidMessage_title3(1)
          ,Party_Fields.InvalidMessage_fname3(1)
          ,Party_Fields.InvalidMessage_mname3(1)
          ,Party_Fields.InvalidMessage_lname3(1)
          ,Party_Fields.InvalidMessage_suffix3(1)
          ,Party_Fields.InvalidMessage_pname3_score(1)
          ,Party_Fields.InvalidMessage_cname3(1)
          ,Party_Fields.InvalidMessage_title4(1)
          ,Party_Fields.InvalidMessage_fname4(1)
          ,Party_Fields.InvalidMessage_mname4(1)
          ,Party_Fields.InvalidMessage_lname4(1)
          ,Party_Fields.InvalidMessage_suffix4(1)
          ,Party_Fields.InvalidMessage_pname4_score(1)
          ,Party_Fields.InvalidMessage_cname4(1)
          ,Party_Fields.InvalidMessage_title5(1)
          ,Party_Fields.InvalidMessage_fname5(1)
          ,Party_Fields.InvalidMessage_mname5(1)
          ,Party_Fields.InvalidMessage_lname5(1)
          ,Party_Fields.InvalidMessage_suffix5(1)
          ,Party_Fields.InvalidMessage_pname5_score(1)
          ,Party_Fields.InvalidMessage_cname5(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.vendor_ALLOW_ErrorCount
          ,le.state_origin_ENUM_ErrorCount
          ,le.county_name_CUSTOM_ErrorCount
          ,le.official_record_key_LENGTHS_ErrorCount
          ,le.doc_filed_dt_CUSTOM_ErrorCount
          ,le.doc_type_desc_LENGTHS_ErrorCount
          ,le.entity_type_cd_LENGTHS_ErrorCount
          ,le.title1_ALLOW_ErrorCount
          ,le.fname1_ALLOW_ErrorCount
          ,le.mname1_ALLOW_ErrorCount
          ,le.lname1_ALLOW_ErrorCount
          ,le.suffix1_ALLOW_ErrorCount
          ,le.pname1_score_ALLOW_ErrorCount
          ,le.cname1_ALLOW_ErrorCount
          ,le.title2_ALLOW_ErrorCount
          ,le.fname2_ALLOW_ErrorCount
          ,le.mname2_ALLOW_ErrorCount
          ,le.lname2_ALLOW_ErrorCount
          ,le.suffix2_ALLOW_ErrorCount
          ,le.pname2_score_ALLOW_ErrorCount
          ,le.cname2_ALLOW_ErrorCount
          ,le.title3_ALLOW_ErrorCount
          ,le.fname3_ALLOW_ErrorCount
          ,le.mname3_ALLOW_ErrorCount
          ,le.lname3_ALLOW_ErrorCount
          ,le.suffix3_ALLOW_ErrorCount
          ,le.pname3_score_ALLOW_ErrorCount
          ,le.cname3_ALLOW_ErrorCount
          ,le.title4_ALLOW_ErrorCount
          ,le.fname4_ALLOW_ErrorCount
          ,le.mname4_ALLOW_ErrorCount
          ,le.lname4_ALLOW_ErrorCount
          ,le.suffix4_ALLOW_ErrorCount
          ,le.pname4_score_ALLOW_ErrorCount
          ,le.cname4_ALLOW_ErrorCount
          ,le.title5_ALLOW_ErrorCount
          ,le.fname5_ALLOW_ErrorCount
          ,le.mname5_ALLOW_ErrorCount
          ,le.lname5_ALLOW_ErrorCount
          ,le.suffix5_ALLOW_ErrorCount
          ,le.pname5_score_ALLOW_ErrorCount
          ,le.cname5_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.vendor_ALLOW_ErrorCount
          ,le.state_origin_ENUM_ErrorCount
          ,le.county_name_CUSTOM_ErrorCount
          ,le.official_record_key_LENGTHS_ErrorCount
          ,le.doc_filed_dt_CUSTOM_ErrorCount
          ,le.doc_type_desc_LENGTHS_ErrorCount
          ,le.entity_type_cd_LENGTHS_ErrorCount
          ,le.title1_ALLOW_ErrorCount
          ,le.fname1_ALLOW_ErrorCount
          ,le.mname1_ALLOW_ErrorCount
          ,le.lname1_ALLOW_ErrorCount
          ,le.suffix1_ALLOW_ErrorCount
          ,le.pname1_score_ALLOW_ErrorCount
          ,le.cname1_ALLOW_ErrorCount
          ,le.title2_ALLOW_ErrorCount
          ,le.fname2_ALLOW_ErrorCount
          ,le.mname2_ALLOW_ErrorCount
          ,le.lname2_ALLOW_ErrorCount
          ,le.suffix2_ALLOW_ErrorCount
          ,le.pname2_score_ALLOW_ErrorCount
          ,le.cname2_ALLOW_ErrorCount
          ,le.title3_ALLOW_ErrorCount
          ,le.fname3_ALLOW_ErrorCount
          ,le.mname3_ALLOW_ErrorCount
          ,le.lname3_ALLOW_ErrorCount
          ,le.suffix3_ALLOW_ErrorCount
          ,le.pname3_score_ALLOW_ErrorCount
          ,le.cname3_ALLOW_ErrorCount
          ,le.title4_ALLOW_ErrorCount
          ,le.fname4_ALLOW_ErrorCount
          ,le.mname4_ALLOW_ErrorCount
          ,le.lname4_ALLOW_ErrorCount
          ,le.suffix4_ALLOW_ErrorCount
          ,le.pname4_score_ALLOW_ErrorCount
          ,le.cname4_ALLOW_ErrorCount
          ,le.title5_ALLOW_ErrorCount
          ,le.fname5_ALLOW_ErrorCount
          ,le.mname5_ALLOW_ErrorCount
          ,le.lname5_ALLOW_ErrorCount
          ,le.suffix5_ALLOW_ErrorCount
          ,le.pname5_score_ALLOW_ErrorCount
          ,le.cname5_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Party_hygiene(PROJECT(h, Party_Layout_Official_Records));
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
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'official_record_key:' + getFieldTypeText(h.official_record_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_instrument_or_clerk_filing_num:' + getFieldTypeText(h.doc_instrument_or_clerk_filing_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_filed_dt:' + getFieldTypeText(h.doc_filed_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_type_desc:' + getFieldTypeText(h.doc_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_sequence:' + getFieldTypeText(h.entity_sequence) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type_cd:' + getFieldTypeText(h.entity_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_type_desc:' + getFieldTypeText(h.entity_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_nm:' + getFieldTypeText(h.entity_nm) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_nm_format:' + getFieldTypeText(h.entity_nm_format) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_dob:' + getFieldTypeText(h.entity_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entity_ssn:' + getFieldTypeText(h.entity_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title1:' + getFieldTypeText(h.title1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname1:' + getFieldTypeText(h.fname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname1:' + getFieldTypeText(h.mname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname1:' + getFieldTypeText(h.lname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix1:' + getFieldTypeText(h.suffix1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pname1_score:' + getFieldTypeText(h.pname1_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname1:' + getFieldTypeText(h.cname1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title2:' + getFieldTypeText(h.title2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname2:' + getFieldTypeText(h.fname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname2:' + getFieldTypeText(h.mname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname2:' + getFieldTypeText(h.lname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix2:' + getFieldTypeText(h.suffix2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pname2_score:' + getFieldTypeText(h.pname2_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname2:' + getFieldTypeText(h.cname2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title3:' + getFieldTypeText(h.title3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname3:' + getFieldTypeText(h.fname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname3:' + getFieldTypeText(h.mname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname3:' + getFieldTypeText(h.lname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix3:' + getFieldTypeText(h.suffix3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pname3_score:' + getFieldTypeText(h.pname3_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname3:' + getFieldTypeText(h.cname3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title4:' + getFieldTypeText(h.title4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname4:' + getFieldTypeText(h.fname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname4:' + getFieldTypeText(h.mname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname4:' + getFieldTypeText(h.lname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix4:' + getFieldTypeText(h.suffix4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pname4_score:' + getFieldTypeText(h.pname4_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname4:' + getFieldTypeText(h.cname4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title5:' + getFieldTypeText(h.title5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname5:' + getFieldTypeText(h.fname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname5:' + getFieldTypeText(h.mname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname5:' + getFieldTypeText(h.lname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix5:' + getFieldTypeText(h.suffix5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pname5_score:' + getFieldTypeText(h.pname5_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cname5:' + getFieldTypeText(h.cname5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'master_party_type_cd:' + getFieldTypeText(h.master_party_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_vendor_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_county_name_cnt
          ,le.populated_official_record_key_cnt
          ,le.populated_doc_instrument_or_clerk_filing_num_cnt
          ,le.populated_doc_filed_dt_cnt
          ,le.populated_doc_type_desc_cnt
          ,le.populated_entity_sequence_cnt
          ,le.populated_entity_type_cd_cnt
          ,le.populated_entity_type_desc_cnt
          ,le.populated_entity_nm_cnt
          ,le.populated_entity_nm_format_cnt
          ,le.populated_entity_dob_cnt
          ,le.populated_entity_ssn_cnt
          ,le.populated_title1_cnt
          ,le.populated_fname1_cnt
          ,le.populated_mname1_cnt
          ,le.populated_lname1_cnt
          ,le.populated_suffix1_cnt
          ,le.populated_pname1_score_cnt
          ,le.populated_cname1_cnt
          ,le.populated_title2_cnt
          ,le.populated_fname2_cnt
          ,le.populated_mname2_cnt
          ,le.populated_lname2_cnt
          ,le.populated_suffix2_cnt
          ,le.populated_pname2_score_cnt
          ,le.populated_cname2_cnt
          ,le.populated_title3_cnt
          ,le.populated_fname3_cnt
          ,le.populated_mname3_cnt
          ,le.populated_lname3_cnt
          ,le.populated_suffix3_cnt
          ,le.populated_pname3_score_cnt
          ,le.populated_cname3_cnt
          ,le.populated_title4_cnt
          ,le.populated_fname4_cnt
          ,le.populated_mname4_cnt
          ,le.populated_lname4_cnt
          ,le.populated_suffix4_cnt
          ,le.populated_pname4_score_cnt
          ,le.populated_cname4_cnt
          ,le.populated_title5_cnt
          ,le.populated_fname5_cnt
          ,le.populated_mname5_cnt
          ,le.populated_lname5_cnt
          ,le.populated_suffix5_cnt
          ,le.populated_pname5_score_cnt
          ,le.populated_cname5_cnt
          ,le.populated_master_party_type_cd_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_vendor_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_official_record_key_pcnt
          ,le.populated_doc_instrument_or_clerk_filing_num_pcnt
          ,le.populated_doc_filed_dt_pcnt
          ,le.populated_doc_type_desc_pcnt
          ,le.populated_entity_sequence_pcnt
          ,le.populated_entity_type_cd_pcnt
          ,le.populated_entity_type_desc_pcnt
          ,le.populated_entity_nm_pcnt
          ,le.populated_entity_nm_format_pcnt
          ,le.populated_entity_dob_pcnt
          ,le.populated_entity_ssn_pcnt
          ,le.populated_title1_pcnt
          ,le.populated_fname1_pcnt
          ,le.populated_mname1_pcnt
          ,le.populated_lname1_pcnt
          ,le.populated_suffix1_pcnt
          ,le.populated_pname1_score_pcnt
          ,le.populated_cname1_pcnt
          ,le.populated_title2_pcnt
          ,le.populated_fname2_pcnt
          ,le.populated_mname2_pcnt
          ,le.populated_lname2_pcnt
          ,le.populated_suffix2_pcnt
          ,le.populated_pname2_score_pcnt
          ,le.populated_cname2_pcnt
          ,le.populated_title3_pcnt
          ,le.populated_fname3_pcnt
          ,le.populated_mname3_pcnt
          ,le.populated_lname3_pcnt
          ,le.populated_suffix3_pcnt
          ,le.populated_pname3_score_pcnt
          ,le.populated_cname3_pcnt
          ,le.populated_title4_pcnt
          ,le.populated_fname4_pcnt
          ,le.populated_mname4_pcnt
          ,le.populated_lname4_pcnt
          ,le.populated_suffix4_pcnt
          ,le.populated_pname4_score_pcnt
          ,le.populated_cname4_pcnt
          ,le.populated_title5_pcnt
          ,le.populated_fname5_pcnt
          ,le.populated_mname5_pcnt
          ,le.populated_lname5_pcnt
          ,le.populated_suffix5_pcnt
          ,le.populated_pname5_score_pcnt
          ,le.populated_cname5_pcnt
          ,le.populated_master_party_type_cd_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,51,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Party_Delta(prevDS, PROJECT(h, Party_Layout_Official_Records));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),51,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Party_Layout_Official_Records) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Official_Records, Party_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
