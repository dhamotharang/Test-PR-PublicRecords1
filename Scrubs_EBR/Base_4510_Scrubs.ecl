IMPORT SALT311,STD;
IMPORT Scrubs_EBR; // Import modules for FieldTypes attribute definitions
EXPORT Base_4510_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 39;
  EXPORT NumRulesFromFieldType := 39;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 38;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_4510_Layout_EBR)
    UNSIGNED1 powid_Invalid;
    UNSIGNED1 proxid_Invalid;
    UNSIGNED1 seleid_Invalid;
    UNSIGNED1 orgid_Invalid;
    UNSIGNED1 ultid_Invalid;
    UNSIGNED1 bdid_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 process_date_first_seen_Invalid;
    UNSIGNED1 process_date_last_seen_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 file_number_Invalid;
    UNSIGNED1 segment_code_Invalid;
    UNSIGNED1 sequence_number_Invalid;
    UNSIGNED1 orig_date_filed_yymmdd_Invalid;
    UNSIGNED1 type_code_Invalid;
    UNSIGNED1 type_desc_Invalid;
    UNSIGNED1 action_code_Invalid;
    UNSIGNED1 action_desc_Invalid;
    UNSIGNED1 document_number_Invalid;
    UNSIGNED1 filing_location_Invalid;
    UNSIGNED1 coll_code1_Invalid;
    UNSIGNED1 coll_desc1_Invalid;
    UNSIGNED1 coll_code2_Invalid;
    UNSIGNED1 coll_desc2_Invalid;
    UNSIGNED1 coll_code3_Invalid;
    UNSIGNED1 coll_desc3_Invalid;
    UNSIGNED1 coll_code4_Invalid;
    UNSIGNED1 coll_desc4_Invalid;
    UNSIGNED1 coll_code5_Invalid;
    UNSIGNED1 coll_desc5_Invalid;
    UNSIGNED1 coll_code6_Invalid;
    UNSIGNED1 coll_desc6_Invalid;
    UNSIGNED1 orig_file_state_code_Invalid;
    UNSIGNED1 orig_file_state_desc_Invalid;
    UNSIGNED1 orig_file_number_Invalid;
    UNSIGNED1 date_filed_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_4510_Layout_EBR)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_4510_Layout_EBR) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.powid_Invalid := Base_4510_Fields.InValid_powid((SALT311.StrType)le.powid);
    SELF.proxid_Invalid := Base_4510_Fields.InValid_proxid((SALT311.StrType)le.proxid);
    SELF.seleid_Invalid := Base_4510_Fields.InValid_seleid((SALT311.StrType)le.seleid);
    SELF.orgid_Invalid := Base_4510_Fields.InValid_orgid((SALT311.StrType)le.orgid);
    SELF.ultid_Invalid := Base_4510_Fields.InValid_ultid((SALT311.StrType)le.ultid);
    SELF.bdid_Invalid := Base_4510_Fields.InValid_bdid((SALT311.StrType)le.bdid);
    SELF.date_first_seen_Invalid := Base_4510_Fields.InValid_date_first_seen((SALT311.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Base_4510_Fields.InValid_date_last_seen((SALT311.StrType)le.date_last_seen);
    SELF.process_date_first_seen_Invalid := Base_4510_Fields.InValid_process_date_first_seen((SALT311.StrType)le.process_date_first_seen);
    SELF.process_date_last_seen_Invalid := Base_4510_Fields.InValid_process_date_last_seen((SALT311.StrType)le.process_date_last_seen);
    SELF.record_type_Invalid := Base_4510_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.process_date_Invalid := Base_4510_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.file_number_Invalid := Base_4510_Fields.InValid_file_number((SALT311.StrType)le.file_number);
    SELF.segment_code_Invalid := Base_4510_Fields.InValid_segment_code((SALT311.StrType)le.segment_code);
    SELF.sequence_number_Invalid := Base_4510_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number);
    SELF.orig_date_filed_yymmdd_Invalid := Base_4510_Fields.InValid_orig_date_filed_yymmdd((SALT311.StrType)le.orig_date_filed_yymmdd);
    SELF.type_code_Invalid := Base_4510_Fields.InValid_type_code((SALT311.StrType)le.type_code);
    SELF.type_desc_Invalid := Base_4510_Fields.InValid_type_desc((SALT311.StrType)le.type_desc);
    SELF.action_code_Invalid := Base_4510_Fields.InValid_action_code((SALT311.StrType)le.action_code);
    SELF.action_desc_Invalid := Base_4510_Fields.InValid_action_desc((SALT311.StrType)le.action_desc);
    SELF.document_number_Invalid := Base_4510_Fields.InValid_document_number((SALT311.StrType)le.document_number);
    SELF.filing_location_Invalid := Base_4510_Fields.InValid_filing_location((SALT311.StrType)le.filing_location);
    SELF.coll_code1_Invalid := Base_4510_Fields.InValid_coll_code1((SALT311.StrType)le.coll_code1);
    SELF.coll_desc1_Invalid := Base_4510_Fields.InValid_coll_desc1((SALT311.StrType)le.coll_desc1);
    SELF.coll_code2_Invalid := Base_4510_Fields.InValid_coll_code2((SALT311.StrType)le.coll_code2);
    SELF.coll_desc2_Invalid := Base_4510_Fields.InValid_coll_desc2((SALT311.StrType)le.coll_desc2);
    SELF.coll_code3_Invalid := Base_4510_Fields.InValid_coll_code3((SALT311.StrType)le.coll_code3);
    SELF.coll_desc3_Invalid := Base_4510_Fields.InValid_coll_desc3((SALT311.StrType)le.coll_desc3);
    SELF.coll_code4_Invalid := Base_4510_Fields.InValid_coll_code4((SALT311.StrType)le.coll_code4);
    SELF.coll_desc4_Invalid := Base_4510_Fields.InValid_coll_desc4((SALT311.StrType)le.coll_desc4);
    SELF.coll_code5_Invalid := Base_4510_Fields.InValid_coll_code5((SALT311.StrType)le.coll_code5);
    SELF.coll_desc5_Invalid := Base_4510_Fields.InValid_coll_desc5((SALT311.StrType)le.coll_desc5);
    SELF.coll_code6_Invalid := Base_4510_Fields.InValid_coll_code6((SALT311.StrType)le.coll_code6);
    SELF.coll_desc6_Invalid := Base_4510_Fields.InValid_coll_desc6((SALT311.StrType)le.coll_desc6);
    SELF.orig_file_state_code_Invalid := Base_4510_Fields.InValid_orig_file_state_code((SALT311.StrType)le.orig_file_state_code);
    SELF.orig_file_state_desc_Invalid := Base_4510_Fields.InValid_orig_file_state_desc((SALT311.StrType)le.orig_file_state_desc);
    SELF.orig_file_number_Invalid := Base_4510_Fields.InValid_orig_file_number((SALT311.StrType)le.orig_file_number);
    SELF.date_filed_Invalid := Base_4510_Fields.InValid_date_filed((SALT311.StrType)le.date_filed);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_4510_Layout_EBR);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.powid_Invalid << 0 ) + ( le.proxid_Invalid << 1 ) + ( le.seleid_Invalid << 2 ) + ( le.orgid_Invalid << 3 ) + ( le.ultid_Invalid << 4 ) + ( le.bdid_Invalid << 5 ) + ( le.date_first_seen_Invalid << 6 ) + ( le.date_last_seen_Invalid << 7 ) + ( le.process_date_first_seen_Invalid << 8 ) + ( le.process_date_last_seen_Invalid << 9 ) + ( le.record_type_Invalid << 10 ) + ( le.process_date_Invalid << 11 ) + ( le.file_number_Invalid << 12 ) + ( le.segment_code_Invalid << 14 ) + ( le.sequence_number_Invalid << 15 ) + ( le.orig_date_filed_yymmdd_Invalid << 16 ) + ( le.type_code_Invalid << 17 ) + ( le.type_desc_Invalid << 18 ) + ( le.action_code_Invalid << 19 ) + ( le.action_desc_Invalid << 20 ) + ( le.document_number_Invalid << 21 ) + ( le.filing_location_Invalid << 22 ) + ( le.coll_code1_Invalid << 23 ) + ( le.coll_desc1_Invalid << 24 ) + ( le.coll_code2_Invalid << 25 ) + ( le.coll_desc2_Invalid << 26 ) + ( le.coll_code3_Invalid << 27 ) + ( le.coll_desc3_Invalid << 28 ) + ( le.coll_code4_Invalid << 29 ) + ( le.coll_desc4_Invalid << 30 ) + ( le.coll_code5_Invalid << 31 ) + ( le.coll_desc5_Invalid << 32 ) + ( le.coll_code6_Invalid << 33 ) + ( le.coll_desc6_Invalid << 34 ) + ( le.orig_file_state_code_Invalid << 35 ) + ( le.orig_file_state_desc_Invalid << 36 ) + ( le.orig_file_number_Invalid << 37 ) + ( le.date_filed_Invalid << 38 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_4510_Layout_EBR);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.powid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.proxid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.seleid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orgid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.ultid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.bdid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.process_date_first_seen_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.process_date_last_seen_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.file_number_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.segment_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.sequence_number_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_date_filed_yymmdd_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.type_code_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.type_desc_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.action_code_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.action_desc_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.document_number_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.filing_location_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.coll_code1_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.coll_desc1_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.coll_code2_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.coll_desc2_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.coll_code3_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.coll_desc3_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.coll_code4_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.coll_desc4_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.coll_code5_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.coll_desc5_Invalid := (le.ScrubsBits1 >> 32) & 1;
    SELF.coll_code6_Invalid := (le.ScrubsBits1 >> 33) & 1;
    SELF.coll_desc6_Invalid := (le.ScrubsBits1 >> 34) & 1;
    SELF.orig_file_state_code_Invalid := (le.ScrubsBits1 >> 35) & 1;
    SELF.orig_file_state_desc_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.orig_file_number_Invalid := (le.ScrubsBits1 >> 37) & 1;
    SELF.date_filed_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    powid_LENGTHS_ErrorCount := COUNT(GROUP,h.powid_Invalid=1);
    proxid_LENGTHS_ErrorCount := COUNT(GROUP,h.proxid_Invalid=1);
    seleid_LENGTHS_ErrorCount := COUNT(GROUP,h.seleid_Invalid=1);
    orgid_LENGTHS_ErrorCount := COUNT(GROUP,h.orgid_Invalid=1);
    ultid_LENGTHS_ErrorCount := COUNT(GROUP,h.ultid_Invalid=1);
    bdid_CUSTOM_ErrorCount := COUNT(GROUP,h.bdid_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    process_date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_first_seen_Invalid=1);
    process_date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_last_seen_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    file_number_ALLOW_ErrorCount := COUNT(GROUP,h.file_number_Invalid=1);
    file_number_LENGTHS_ErrorCount := COUNT(GROUP,h.file_number_Invalid=2);
    file_number_Total_ErrorCount := COUNT(GROUP,h.file_number_Invalid>0);
    segment_code_ENUM_ErrorCount := COUNT(GROUP,h.segment_code_Invalid=1);
    sequence_number_CUSTOM_ErrorCount := COUNT(GROUP,h.sequence_number_Invalid=1);
    orig_date_filed_yymmdd_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_date_filed_yymmdd_Invalid=1);
    type_code_ENUM_ErrorCount := COUNT(GROUP,h.type_code_Invalid=1);
    type_desc_ENUM_ErrorCount := COUNT(GROUP,h.type_desc_Invalid=1);
    action_code_CUSTOM_ErrorCount := COUNT(GROUP,h.action_code_Invalid=1);
    action_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.action_desc_Invalid=1);
    document_number_LENGTHS_ErrorCount := COUNT(GROUP,h.document_number_Invalid=1);
    filing_location_LENGTHS_ErrorCount := COUNT(GROUP,h.filing_location_Invalid=1);
    coll_code1_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_code1_Invalid=1);
    coll_desc1_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_desc1_Invalid=1);
    coll_code2_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_code2_Invalid=1);
    coll_desc2_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_desc2_Invalid=1);
    coll_code3_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_code3_Invalid=1);
    coll_desc3_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_desc3_Invalid=1);
    coll_code4_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_code4_Invalid=1);
    coll_desc4_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_desc4_Invalid=1);
    coll_code5_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_code5_Invalid=1);
    coll_desc5_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_desc5_Invalid=1);
    coll_code6_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_code6_Invalid=1);
    coll_desc6_CUSTOM_ErrorCount := COUNT(GROUP,h.coll_desc6_Invalid=1);
    orig_file_state_code_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_file_state_code_Invalid=1);
    orig_file_state_desc_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_file_state_desc_Invalid=1);
    orig_file_number_LENGTHS_ErrorCount := COUNT(GROUP,h.orig_file_number_Invalid=1);
    date_filed_CUSTOM_ErrorCount := COUNT(GROUP,h.date_filed_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.powid_Invalid > 0 OR h.proxid_Invalid > 0 OR h.seleid_Invalid > 0 OR h.orgid_Invalid > 0 OR h.ultid_Invalid > 0 OR h.bdid_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.process_date_first_seen_Invalid > 0 OR h.process_date_last_seen_Invalid > 0 OR h.record_type_Invalid > 0 OR h.process_date_Invalid > 0 OR h.file_number_Invalid > 0 OR h.segment_code_Invalid > 0 OR h.sequence_number_Invalid > 0 OR h.orig_date_filed_yymmdd_Invalid > 0 OR h.type_code_Invalid > 0 OR h.type_desc_Invalid > 0 OR h.action_code_Invalid > 0 OR h.action_desc_Invalid > 0 OR h.document_number_Invalid > 0 OR h.filing_location_Invalid > 0 OR h.coll_code1_Invalid > 0 OR h.coll_desc1_Invalid > 0 OR h.coll_code2_Invalid > 0 OR h.coll_desc2_Invalid > 0 OR h.coll_code3_Invalid > 0 OR h.coll_desc3_Invalid > 0 OR h.coll_code4_Invalid > 0 OR h.coll_desc4_Invalid > 0 OR h.coll_code5_Invalid > 0 OR h.coll_desc5_Invalid > 0 OR h.coll_code6_Invalid > 0 OR h.coll_desc6_Invalid > 0 OR h.orig_file_state_code_Invalid > 0 OR h.orig_file_state_desc_Invalid > 0 OR h.orig_file_number_Invalid > 0 OR h.date_filed_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_Total_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sequence_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_date_filed_yymmdd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.type_desc_ENUM_ErrorCount > 0, 1, 0) + IF(le.action_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.document_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.filing_location_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coll_code1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_file_state_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_file_state_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_filed_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.powid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.proxid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seleid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.orgid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ultid_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.bdid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.file_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.segment_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.sequence_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_date_filed_yymmdd_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.type_desc_ENUM_ErrorCount > 0, 1, 0) + IF(le.action_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.action_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.document_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.filing_location_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.coll_code1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_code6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.coll_desc6_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_file_state_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_file_state_desc_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_file_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.date_filed_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.powid_Invalid,le.proxid_Invalid,le.seleid_Invalid,le.orgid_Invalid,le.ultid_Invalid,le.bdid_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.process_date_first_seen_Invalid,le.process_date_last_seen_Invalid,le.record_type_Invalid,le.process_date_Invalid,le.file_number_Invalid,le.segment_code_Invalid,le.sequence_number_Invalid,le.orig_date_filed_yymmdd_Invalid,le.type_code_Invalid,le.type_desc_Invalid,le.action_code_Invalid,le.action_desc_Invalid,le.document_number_Invalid,le.filing_location_Invalid,le.coll_code1_Invalid,le.coll_desc1_Invalid,le.coll_code2_Invalid,le.coll_desc2_Invalid,le.coll_code3_Invalid,le.coll_desc3_Invalid,le.coll_code4_Invalid,le.coll_desc4_Invalid,le.coll_code5_Invalid,le.coll_desc5_Invalid,le.coll_code6_Invalid,le.coll_desc6_Invalid,le.orig_file_state_code_Invalid,le.orig_file_state_desc_Invalid,le.orig_file_number_Invalid,le.date_filed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_4510_Fields.InvalidMessage_powid(le.powid_Invalid),Base_4510_Fields.InvalidMessage_proxid(le.proxid_Invalid),Base_4510_Fields.InvalidMessage_seleid(le.seleid_Invalid),Base_4510_Fields.InvalidMessage_orgid(le.orgid_Invalid),Base_4510_Fields.InvalidMessage_ultid(le.ultid_Invalid),Base_4510_Fields.InvalidMessage_bdid(le.bdid_Invalid),Base_4510_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Base_4510_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Base_4510_Fields.InvalidMessage_process_date_first_seen(le.process_date_first_seen_Invalid),Base_4510_Fields.InvalidMessage_process_date_last_seen(le.process_date_last_seen_Invalid),Base_4510_Fields.InvalidMessage_record_type(le.record_type_Invalid),Base_4510_Fields.InvalidMessage_process_date(le.process_date_Invalid),Base_4510_Fields.InvalidMessage_file_number(le.file_number_Invalid),Base_4510_Fields.InvalidMessage_segment_code(le.segment_code_Invalid),Base_4510_Fields.InvalidMessage_sequence_number(le.sequence_number_Invalid),Base_4510_Fields.InvalidMessage_orig_date_filed_yymmdd(le.orig_date_filed_yymmdd_Invalid),Base_4510_Fields.InvalidMessage_type_code(le.type_code_Invalid),Base_4510_Fields.InvalidMessage_type_desc(le.type_desc_Invalid),Base_4510_Fields.InvalidMessage_action_code(le.action_code_Invalid),Base_4510_Fields.InvalidMessage_action_desc(le.action_desc_Invalid),Base_4510_Fields.InvalidMessage_document_number(le.document_number_Invalid),Base_4510_Fields.InvalidMessage_filing_location(le.filing_location_Invalid),Base_4510_Fields.InvalidMessage_coll_code1(le.coll_code1_Invalid),Base_4510_Fields.InvalidMessage_coll_desc1(le.coll_desc1_Invalid),Base_4510_Fields.InvalidMessage_coll_code2(le.coll_code2_Invalid),Base_4510_Fields.InvalidMessage_coll_desc2(le.coll_desc2_Invalid),Base_4510_Fields.InvalidMessage_coll_code3(le.coll_code3_Invalid),Base_4510_Fields.InvalidMessage_coll_desc3(le.coll_desc3_Invalid),Base_4510_Fields.InvalidMessage_coll_code4(le.coll_code4_Invalid),Base_4510_Fields.InvalidMessage_coll_desc4(le.coll_desc4_Invalid),Base_4510_Fields.InvalidMessage_coll_code5(le.coll_code5_Invalid),Base_4510_Fields.InvalidMessage_coll_desc5(le.coll_desc5_Invalid),Base_4510_Fields.InvalidMessage_coll_code6(le.coll_code6_Invalid),Base_4510_Fields.InvalidMessage_coll_desc6(le.coll_desc6_Invalid),Base_4510_Fields.InvalidMessage_orig_file_state_code(le.orig_file_state_code_Invalid),Base_4510_Fields.InvalidMessage_orig_file_state_desc(le.orig_file_state_desc_Invalid),Base_4510_Fields.InvalidMessage_orig_file_number(le.orig_file_number_Invalid),Base_4510_Fields.InvalidMessage_date_filed(le.date_filed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.powid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.proxid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.seleid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.orgid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ultid_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.bdid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.file_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.segment_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.sequence_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_date_filed_yymmdd_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.type_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.type_desc_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.action_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.action_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.document_number_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.filing_location_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.coll_code1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_desc1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_code2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_desc2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_code3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_desc3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_code4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_desc4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_code5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_desc5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_code6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.coll_desc6_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_file_state_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_file_state_desc_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_file_number_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.date_filed_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'powid','proxid','seleid','orgid','ultid','bdid','date_first_seen','date_last_seen','process_date_first_seen','process_date_last_seen','record_type','process_date','file_number','segment_code','sequence_number','orig_date_filed_yymmdd','type_code','type_desc','action_code','action_desc','document_number','filing_location','coll_code1','coll_desc1','coll_code2','coll_desc2','coll_code3','coll_desc3','coll_code4','coll_desc4','coll_code5','coll_desc5','coll_code6','coll_desc6','orig_file_state_code','orig_file_state_desc','orig_file_number','date_filed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_numeric','invalid_dt_first_seen','invalid_pastdate','invalid_pastdate','invalid_pastdate','invalid_record_type','invalid_pastdate','invalid_file_number','invalid_segment','invalid_numeric_or_allzeros','invalid_dt_yymmdd','invalid_type_code','invalid_type_desc','invalid_action_code','invalid_action_desc','invalid_mandatory','invalid_mandatory','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_coll_code','invalid_coll_desc','invalid_state','invalid_state_desc','invalid_mandatory','invalid_pastdate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.powid,(SALT311.StrType)le.proxid,(SALT311.StrType)le.seleid,(SALT311.StrType)le.orgid,(SALT311.StrType)le.ultid,(SALT311.StrType)le.bdid,(SALT311.StrType)le.date_first_seen,(SALT311.StrType)le.date_last_seen,(SALT311.StrType)le.process_date_first_seen,(SALT311.StrType)le.process_date_last_seen,(SALT311.StrType)le.record_type,(SALT311.StrType)le.process_date,(SALT311.StrType)le.file_number,(SALT311.StrType)le.segment_code,(SALT311.StrType)le.sequence_number,(SALT311.StrType)le.orig_date_filed_yymmdd,(SALT311.StrType)le.type_code,(SALT311.StrType)le.type_desc,(SALT311.StrType)le.action_code,(SALT311.StrType)le.action_desc,(SALT311.StrType)le.document_number,(SALT311.StrType)le.filing_location,(SALT311.StrType)le.coll_code1,(SALT311.StrType)le.coll_desc1,(SALT311.StrType)le.coll_code2,(SALT311.StrType)le.coll_desc2,(SALT311.StrType)le.coll_code3,(SALT311.StrType)le.coll_desc3,(SALT311.StrType)le.coll_code4,(SALT311.StrType)le.coll_desc4,(SALT311.StrType)le.coll_code5,(SALT311.StrType)le.coll_desc5,(SALT311.StrType)le.coll_code6,(SALT311.StrType)le.coll_desc6,(SALT311.StrType)le.orig_file_state_code,(SALT311.StrType)le.orig_file_state_desc,(SALT311.StrType)le.orig_file_number,(SALT311.StrType)le.date_filed,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,38,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_4510_Layout_EBR) prevDS = DATASET([], Base_4510_Layout_EBR), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'powid:invalid_mandatory:LENGTHS'
          ,'proxid:invalid_mandatory:LENGTHS'
          ,'seleid:invalid_mandatory:LENGTHS'
          ,'orgid:invalid_mandatory:LENGTHS'
          ,'ultid:invalid_mandatory:LENGTHS'
          ,'bdid:invalid_numeric:CUSTOM'
          ,'date_first_seen:invalid_dt_first_seen:CUSTOM'
          ,'date_last_seen:invalid_pastdate:CUSTOM'
          ,'process_date_first_seen:invalid_pastdate:CUSTOM'
          ,'process_date_last_seen:invalid_pastdate:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'process_date:invalid_pastdate:CUSTOM'
          ,'file_number:invalid_file_number:ALLOW','file_number:invalid_file_number:LENGTHS'
          ,'segment_code:invalid_segment:ENUM'
          ,'sequence_number:invalid_numeric_or_allzeros:CUSTOM'
          ,'orig_date_filed_yymmdd:invalid_dt_yymmdd:CUSTOM'
          ,'type_code:invalid_type_code:ENUM'
          ,'type_desc:invalid_type_desc:ENUM'
          ,'action_code:invalid_action_code:CUSTOM'
          ,'action_desc:invalid_action_desc:CUSTOM'
          ,'document_number:invalid_mandatory:LENGTHS'
          ,'filing_location:invalid_mandatory:LENGTHS'
          ,'coll_code1:invalid_coll_code:CUSTOM'
          ,'coll_desc1:invalid_coll_desc:CUSTOM'
          ,'coll_code2:invalid_coll_code:CUSTOM'
          ,'coll_desc2:invalid_coll_desc:CUSTOM'
          ,'coll_code3:invalid_coll_code:CUSTOM'
          ,'coll_desc3:invalid_coll_desc:CUSTOM'
          ,'coll_code4:invalid_coll_code:CUSTOM'
          ,'coll_desc4:invalid_coll_desc:CUSTOM'
          ,'coll_code5:invalid_coll_code:CUSTOM'
          ,'coll_desc5:invalid_coll_desc:CUSTOM'
          ,'coll_code6:invalid_coll_code:CUSTOM'
          ,'coll_desc6:invalid_coll_desc:CUSTOM'
          ,'orig_file_state_code:invalid_state:CUSTOM'
          ,'orig_file_state_desc:invalid_state_desc:CUSTOM'
          ,'orig_file_number:invalid_mandatory:LENGTHS'
          ,'date_filed:invalid_pastdate:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_4510_Fields.InvalidMessage_powid(1)
          ,Base_4510_Fields.InvalidMessage_proxid(1)
          ,Base_4510_Fields.InvalidMessage_seleid(1)
          ,Base_4510_Fields.InvalidMessage_orgid(1)
          ,Base_4510_Fields.InvalidMessage_ultid(1)
          ,Base_4510_Fields.InvalidMessage_bdid(1)
          ,Base_4510_Fields.InvalidMessage_date_first_seen(1)
          ,Base_4510_Fields.InvalidMessage_date_last_seen(1)
          ,Base_4510_Fields.InvalidMessage_process_date_first_seen(1)
          ,Base_4510_Fields.InvalidMessage_process_date_last_seen(1)
          ,Base_4510_Fields.InvalidMessage_record_type(1)
          ,Base_4510_Fields.InvalidMessage_process_date(1)
          ,Base_4510_Fields.InvalidMessage_file_number(1),Base_4510_Fields.InvalidMessage_file_number(2)
          ,Base_4510_Fields.InvalidMessage_segment_code(1)
          ,Base_4510_Fields.InvalidMessage_sequence_number(1)
          ,Base_4510_Fields.InvalidMessage_orig_date_filed_yymmdd(1)
          ,Base_4510_Fields.InvalidMessage_type_code(1)
          ,Base_4510_Fields.InvalidMessage_type_desc(1)
          ,Base_4510_Fields.InvalidMessage_action_code(1)
          ,Base_4510_Fields.InvalidMessage_action_desc(1)
          ,Base_4510_Fields.InvalidMessage_document_number(1)
          ,Base_4510_Fields.InvalidMessage_filing_location(1)
          ,Base_4510_Fields.InvalidMessage_coll_code1(1)
          ,Base_4510_Fields.InvalidMessage_coll_desc1(1)
          ,Base_4510_Fields.InvalidMessage_coll_code2(1)
          ,Base_4510_Fields.InvalidMessage_coll_desc2(1)
          ,Base_4510_Fields.InvalidMessage_coll_code3(1)
          ,Base_4510_Fields.InvalidMessage_coll_desc3(1)
          ,Base_4510_Fields.InvalidMessage_coll_code4(1)
          ,Base_4510_Fields.InvalidMessage_coll_desc4(1)
          ,Base_4510_Fields.InvalidMessage_coll_code5(1)
          ,Base_4510_Fields.InvalidMessage_coll_desc5(1)
          ,Base_4510_Fields.InvalidMessage_coll_code6(1)
          ,Base_4510_Fields.InvalidMessage_coll_desc6(1)
          ,Base_4510_Fields.InvalidMessage_orig_file_state_code(1)
          ,Base_4510_Fields.InvalidMessage_orig_file_state_desc(1)
          ,Base_4510_Fields.InvalidMessage_orig_file_number(1)
          ,Base_4510_Fields.InvalidMessage_date_filed(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.powid_LENGTHS_ErrorCount
          ,le.proxid_LENGTHS_ErrorCount
          ,le.seleid_LENGTHS_ErrorCount
          ,le.orgid_LENGTHS_ErrorCount
          ,le.ultid_LENGTHS_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.process_date_first_seen_CUSTOM_ErrorCount
          ,le.process_date_last_seen_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_number_ALLOW_ErrorCount,le.file_number_LENGTHS_ErrorCount
          ,le.segment_code_ENUM_ErrorCount
          ,le.sequence_number_CUSTOM_ErrorCount
          ,le.orig_date_filed_yymmdd_CUSTOM_ErrorCount
          ,le.type_code_ENUM_ErrorCount
          ,le.type_desc_ENUM_ErrorCount
          ,le.action_code_CUSTOM_ErrorCount
          ,le.action_desc_CUSTOM_ErrorCount
          ,le.document_number_LENGTHS_ErrorCount
          ,le.filing_location_LENGTHS_ErrorCount
          ,le.coll_code1_CUSTOM_ErrorCount
          ,le.coll_desc1_CUSTOM_ErrorCount
          ,le.coll_code2_CUSTOM_ErrorCount
          ,le.coll_desc2_CUSTOM_ErrorCount
          ,le.coll_code3_CUSTOM_ErrorCount
          ,le.coll_desc3_CUSTOM_ErrorCount
          ,le.coll_code4_CUSTOM_ErrorCount
          ,le.coll_desc4_CUSTOM_ErrorCount
          ,le.coll_code5_CUSTOM_ErrorCount
          ,le.coll_desc5_CUSTOM_ErrorCount
          ,le.coll_code6_CUSTOM_ErrorCount
          ,le.coll_desc6_CUSTOM_ErrorCount
          ,le.orig_file_state_code_CUSTOM_ErrorCount
          ,le.orig_file_state_desc_CUSTOM_ErrorCount
          ,le.orig_file_number_LENGTHS_ErrorCount
          ,le.date_filed_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.powid_LENGTHS_ErrorCount
          ,le.proxid_LENGTHS_ErrorCount
          ,le.seleid_LENGTHS_ErrorCount
          ,le.orgid_LENGTHS_ErrorCount
          ,le.ultid_LENGTHS_ErrorCount
          ,le.bdid_CUSTOM_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.process_date_first_seen_CUSTOM_ErrorCount
          ,le.process_date_last_seen_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.file_number_ALLOW_ErrorCount,le.file_number_LENGTHS_ErrorCount
          ,le.segment_code_ENUM_ErrorCount
          ,le.sequence_number_CUSTOM_ErrorCount
          ,le.orig_date_filed_yymmdd_CUSTOM_ErrorCount
          ,le.type_code_ENUM_ErrorCount
          ,le.type_desc_ENUM_ErrorCount
          ,le.action_code_CUSTOM_ErrorCount
          ,le.action_desc_CUSTOM_ErrorCount
          ,le.document_number_LENGTHS_ErrorCount
          ,le.filing_location_LENGTHS_ErrorCount
          ,le.coll_code1_CUSTOM_ErrorCount
          ,le.coll_desc1_CUSTOM_ErrorCount
          ,le.coll_code2_CUSTOM_ErrorCount
          ,le.coll_desc2_CUSTOM_ErrorCount
          ,le.coll_code3_CUSTOM_ErrorCount
          ,le.coll_desc3_CUSTOM_ErrorCount
          ,le.coll_code4_CUSTOM_ErrorCount
          ,le.coll_desc4_CUSTOM_ErrorCount
          ,le.coll_code5_CUSTOM_ErrorCount
          ,le.coll_desc5_CUSTOM_ErrorCount
          ,le.coll_code6_CUSTOM_ErrorCount
          ,le.coll_desc6_CUSTOM_ErrorCount
          ,le.orig_file_state_code_CUSTOM_ErrorCount
          ,le.orig_file_state_desc_CUSTOM_ErrorCount
          ,le.orig_file_number_LENGTHS_ErrorCount
          ,le.date_filed_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Base_4510_hygiene(PROJECT(h, Base_4510_Layout_EBR));
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
          ,'powid:' + getFieldTypeText(h.powid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proxid:' + getFieldTypeText(h.proxid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seleid:' + getFieldTypeText(h.seleid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orgid:' + getFieldTypeText(h.orgid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ultid:' + getFieldTypeText(h.ultid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date_first_seen:' + getFieldTypeText(h.process_date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date_last_seen:' + getFieldTypeText(h.process_date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_number:' + getFieldTypeText(h.file_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'segment_code:' + getFieldTypeText(h.segment_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sequence_number:' + getFieldTypeText(h.sequence_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_date_filed_yymmdd:' + getFieldTypeText(h.orig_date_filed_yymmdd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_code:' + getFieldTypeText(h.type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'type_desc:' + getFieldTypeText(h.type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action_code:' + getFieldTypeText(h.action_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action_desc:' + getFieldTypeText(h.action_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'document_number:' + getFieldTypeText(h.document_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_location:' + getFieldTypeText(h.filing_location) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_code1:' + getFieldTypeText(h.coll_code1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_desc1:' + getFieldTypeText(h.coll_desc1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_code2:' + getFieldTypeText(h.coll_code2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_desc2:' + getFieldTypeText(h.coll_desc2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_code3:' + getFieldTypeText(h.coll_code3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_desc3:' + getFieldTypeText(h.coll_desc3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_code4:' + getFieldTypeText(h.coll_code4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_desc4:' + getFieldTypeText(h.coll_desc4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_code5:' + getFieldTypeText(h.coll_code5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_desc5:' + getFieldTypeText(h.coll_desc5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_code6:' + getFieldTypeText(h.coll_code6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coll_desc6:' + getFieldTypeText(h.coll_desc6) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_file_state_code:' + getFieldTypeText(h.orig_file_state_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_file_state_desc:' + getFieldTypeText(h.orig_file_state_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_file_number:' + getFieldTypeText(h.orig_file_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_filed:' + getFieldTypeText(h.date_filed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_powid_cnt
          ,le.populated_proxid_cnt
          ,le.populated_seleid_cnt
          ,le.populated_orgid_cnt
          ,le.populated_ultid_cnt
          ,le.populated_bdid_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_process_date_first_seen_cnt
          ,le.populated_process_date_last_seen_cnt
          ,le.populated_record_type_cnt
          ,le.populated_process_date_cnt
          ,le.populated_file_number_cnt
          ,le.populated_segment_code_cnt
          ,le.populated_sequence_number_cnt
          ,le.populated_orig_date_filed_yymmdd_cnt
          ,le.populated_type_code_cnt
          ,le.populated_type_desc_cnt
          ,le.populated_action_code_cnt
          ,le.populated_action_desc_cnt
          ,le.populated_document_number_cnt
          ,le.populated_filing_location_cnt
          ,le.populated_coll_code1_cnt
          ,le.populated_coll_desc1_cnt
          ,le.populated_coll_code2_cnt
          ,le.populated_coll_desc2_cnt
          ,le.populated_coll_code3_cnt
          ,le.populated_coll_desc3_cnt
          ,le.populated_coll_code4_cnt
          ,le.populated_coll_desc4_cnt
          ,le.populated_coll_code5_cnt
          ,le.populated_coll_desc5_cnt
          ,le.populated_coll_code6_cnt
          ,le.populated_coll_desc6_cnt
          ,le.populated_orig_file_state_code_cnt
          ,le.populated_orig_file_state_desc_cnt
          ,le.populated_orig_file_number_cnt
          ,le.populated_date_filed_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_powid_pcnt
          ,le.populated_proxid_pcnt
          ,le.populated_seleid_pcnt
          ,le.populated_orgid_pcnt
          ,le.populated_ultid_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_process_date_first_seen_pcnt
          ,le.populated_process_date_last_seen_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_file_number_pcnt
          ,le.populated_segment_code_pcnt
          ,le.populated_sequence_number_pcnt
          ,le.populated_orig_date_filed_yymmdd_pcnt
          ,le.populated_type_code_pcnt
          ,le.populated_type_desc_pcnt
          ,le.populated_action_code_pcnt
          ,le.populated_action_desc_pcnt
          ,le.populated_document_number_pcnt
          ,le.populated_filing_location_pcnt
          ,le.populated_coll_code1_pcnt
          ,le.populated_coll_desc1_pcnt
          ,le.populated_coll_code2_pcnt
          ,le.populated_coll_desc2_pcnt
          ,le.populated_coll_code3_pcnt
          ,le.populated_coll_desc3_pcnt
          ,le.populated_coll_code4_pcnt
          ,le.populated_coll_desc4_pcnt
          ,le.populated_coll_code5_pcnt
          ,le.populated_coll_desc5_pcnt
          ,le.populated_coll_code6_pcnt
          ,le.populated_coll_desc6_pcnt
          ,le.populated_orig_file_state_code_pcnt
          ,le.populated_orig_file_state_desc_pcnt
          ,le.populated_orig_file_number_pcnt
          ,le.populated_date_filed_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,38,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_4510_Delta(prevDS, PROJECT(h, Base_4510_Layout_EBR));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),38,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_4510_Layout_EBR) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_EBR, Base_4510_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
