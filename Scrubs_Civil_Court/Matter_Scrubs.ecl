IMPORT SALT39,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Matter_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 23;
  EXPORT NumRulesFromFieldType := 23;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 23;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Matter_Layout_Civil_Court)
    UNSIGNED1 dt_first_reported_Invalid;
    UNSIGNED1 dt_last_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 vendor_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 case_key_Invalid;
    UNSIGNED1 parent_case_key_Invalid;
    UNSIGNED1 court_code_Invalid;
    UNSIGNED1 case_number_Invalid;
    UNSIGNED1 case_type_code_Invalid;
    UNSIGNED1 case_cause_code_Invalid;
    UNSIGNED1 manner_of_filing_code_Invalid;
    UNSIGNED1 filing_date_Invalid;
    UNSIGNED1 manner_of_judgmt_code_Invalid;
    UNSIGNED1 judgmt_date_Invalid;
    UNSIGNED1 ruled_for_against_code_Invalid;
    UNSIGNED1 judgmt_type_code_Invalid;
    UNSIGNED1 judgmt_disposition_date_Invalid;
    UNSIGNED1 judgmt_disposition_code_Invalid;
    UNSIGNED1 disposition_code_Invalid;
    UNSIGNED1 disposition_date_Invalid;
    UNSIGNED1 suit_amount_Invalid;
    UNSIGNED1 award_amount_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Matter_Layout_Civil_Court)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Matter_Layout_Civil_Court) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_reported_Invalid := Matter_Fields.InValid_dt_first_reported((SALT39.StrType)le.dt_first_reported);
    SELF.dt_last_reported_Invalid := Matter_Fields.InValid_dt_last_reported((SALT39.StrType)le.dt_last_reported);
    SELF.process_date_Invalid := Matter_Fields.InValid_process_date((SALT39.StrType)le.process_date);
    SELF.vendor_Invalid := Matter_Fields.InValid_vendor((SALT39.StrType)le.vendor);
    SELF.state_origin_Invalid := Matter_Fields.InValid_state_origin((SALT39.StrType)le.state_origin);
    SELF.case_key_Invalid := Matter_Fields.InValid_case_key((SALT39.StrType)le.case_key);
    SELF.parent_case_key_Invalid := Matter_Fields.InValid_parent_case_key((SALT39.StrType)le.parent_case_key);
    SELF.court_code_Invalid := Matter_Fields.InValid_court_code((SALT39.StrType)le.court_code);
    SELF.case_number_Invalid := Matter_Fields.InValid_case_number((SALT39.StrType)le.case_number);
    SELF.case_type_code_Invalid := Matter_Fields.InValid_case_type_code((SALT39.StrType)le.case_type_code);
    SELF.case_cause_code_Invalid := Matter_Fields.InValid_case_cause_code((SALT39.StrType)le.case_cause_code);
    SELF.manner_of_filing_code_Invalid := Matter_Fields.InValid_manner_of_filing_code((SALT39.StrType)le.manner_of_filing_code);
    SELF.filing_date_Invalid := Matter_Fields.InValid_filing_date((SALT39.StrType)le.filing_date);
    SELF.manner_of_judgmt_code_Invalid := Matter_Fields.InValid_manner_of_judgmt_code((SALT39.StrType)le.manner_of_judgmt_code);
    SELF.judgmt_date_Invalid := Matter_Fields.InValid_judgmt_date((SALT39.StrType)le.judgmt_date);
    SELF.ruled_for_against_code_Invalid := Matter_Fields.InValid_ruled_for_against_code((SALT39.StrType)le.ruled_for_against_code);
    SELF.judgmt_type_code_Invalid := Matter_Fields.InValid_judgmt_type_code((SALT39.StrType)le.judgmt_type_code);
    SELF.judgmt_disposition_date_Invalid := Matter_Fields.InValid_judgmt_disposition_date((SALT39.StrType)le.judgmt_disposition_date);
    SELF.judgmt_disposition_code_Invalid := Matter_Fields.InValid_judgmt_disposition_code((SALT39.StrType)le.judgmt_disposition_code);
    SELF.disposition_code_Invalid := Matter_Fields.InValid_disposition_code((SALT39.StrType)le.disposition_code);
    SELF.disposition_date_Invalid := Matter_Fields.InValid_disposition_date((SALT39.StrType)le.disposition_date);
    SELF.suit_amount_Invalid := Matter_Fields.InValid_suit_amount((SALT39.StrType)le.suit_amount);
    SELF.award_amount_Invalid := Matter_Fields.InValid_award_amount((SALT39.StrType)le.award_amount);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Matter_Layout_Civil_Court);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_reported_Invalid << 0 ) + ( le.dt_last_reported_Invalid << 1 ) + ( le.process_date_Invalid << 2 ) + ( le.vendor_Invalid << 3 ) + ( le.state_origin_Invalid << 4 ) + ( le.case_key_Invalid << 5 ) + ( le.parent_case_key_Invalid << 6 ) + ( le.court_code_Invalid << 7 ) + ( le.case_number_Invalid << 8 ) + ( le.case_type_code_Invalid << 9 ) + ( le.case_cause_code_Invalid << 10 ) + ( le.manner_of_filing_code_Invalid << 11 ) + ( le.filing_date_Invalid << 12 ) + ( le.manner_of_judgmt_code_Invalid << 13 ) + ( le.judgmt_date_Invalid << 14 ) + ( le.ruled_for_against_code_Invalid << 15 ) + ( le.judgmt_type_code_Invalid << 16 ) + ( le.judgmt_disposition_date_Invalid << 17 ) + ( le.judgmt_disposition_code_Invalid << 18 ) + ( le.disposition_code_Invalid << 19 ) + ( le.disposition_date_Invalid << 20 ) + ( le.suit_amount_Invalid << 21 ) + ( le.award_amount_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Matter_Layout_Civil_Court);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_reported_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_reported_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.vendor_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.case_key_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.parent_case_key_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.court_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.case_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.case_type_code_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.case_cause_code_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.manner_of_filing_code_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.filing_date_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.manner_of_judgmt_code_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.judgmt_date_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.ruled_for_against_code_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.judgmt_type_code_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.judgmt_disposition_date_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.judgmt_disposition_code_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.disposition_code_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.disposition_date_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.suit_amount_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.award_amount_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_reported_Invalid=1);
    dt_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_reported_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    vendor_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    state_origin_ALLOW_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    case_key_ALLOW_ErrorCount := COUNT(GROUP,h.case_key_Invalid=1);
    parent_case_key_ALLOW_ErrorCount := COUNT(GROUP,h.parent_case_key_Invalid=1);
    court_code_ALLOW_ErrorCount := COUNT(GROUP,h.court_code_Invalid=1);
    case_number_ALLOW_ErrorCount := COUNT(GROUP,h.case_number_Invalid=1);
    case_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.case_type_code_Invalid=1);
    case_cause_code_ALLOW_ErrorCount := COUNT(GROUP,h.case_cause_code_Invalid=1);
    manner_of_filing_code_ALLOW_ErrorCount := COUNT(GROUP,h.manner_of_filing_code_Invalid=1);
    filing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.filing_date_Invalid=1);
    manner_of_judgmt_code_ALLOW_ErrorCount := COUNT(GROUP,h.manner_of_judgmt_code_Invalid=1);
    judgmt_date_CUSTOM_ErrorCount := COUNT(GROUP,h.judgmt_date_Invalid=1);
    ruled_for_against_code_ALLOW_ErrorCount := COUNT(GROUP,h.ruled_for_against_code_Invalid=1);
    judgmt_type_code_ALLOW_ErrorCount := COUNT(GROUP,h.judgmt_type_code_Invalid=1);
    judgmt_disposition_date_CUSTOM_ErrorCount := COUNT(GROUP,h.judgmt_disposition_date_Invalid=1);
    judgmt_disposition_code_ALLOW_ErrorCount := COUNT(GROUP,h.judgmt_disposition_code_Invalid=1);
    disposition_code_ALLOW_ErrorCount := COUNT(GROUP,h.disposition_code_Invalid=1);
    disposition_date_CUSTOM_ErrorCount := COUNT(GROUP,h.disposition_date_Invalid=1);
    suit_amount_ALLOW_ErrorCount := COUNT(GROUP,h.suit_amount_Invalid=1);
    award_amount_ALLOW_ErrorCount := COUNT(GROUP,h.award_amount_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_reported_Invalid > 0 OR h.dt_last_reported_Invalid > 0 OR h.process_date_Invalid > 0 OR h.vendor_Invalid > 0 OR h.state_origin_Invalid > 0 OR h.case_key_Invalid > 0 OR h.parent_case_key_Invalid > 0 OR h.court_code_Invalid > 0 OR h.case_number_Invalid > 0 OR h.case_type_code_Invalid > 0 OR h.case_cause_code_Invalid > 0 OR h.manner_of_filing_code_Invalid > 0 OR h.filing_date_Invalid > 0 OR h.manner_of_judgmt_code_Invalid > 0 OR h.judgmt_date_Invalid > 0 OR h.ruled_for_against_code_Invalid > 0 OR h.judgmt_type_code_Invalid > 0 OR h.judgmt_disposition_date_Invalid > 0 OR h.judgmt_disposition_code_Invalid > 0 OR h.disposition_code_Invalid > 0 OR h.disposition_date_Invalid > 0 OR h.suit_amount_Invalid > 0 OR h.award_amount_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parent_case_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.court_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_cause_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.manner_of_filing_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.manner_of_judgmt_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judgmt_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ruled_for_against_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judgmt_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judgmt_disposition_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judgmt_disposition_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.disposition_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.disposition_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.suit_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.award_amount_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.parent_case_key_ALLOW_ErrorCount > 0, 1, 0) + IF(le.court_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.case_cause_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.manner_of_filing_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filing_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.manner_of_judgmt_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judgmt_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ruled_for_against_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judgmt_type_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.judgmt_disposition_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.judgmt_disposition_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.disposition_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.disposition_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.suit_amount_ALLOW_ErrorCount > 0, 1, 0) + IF(le.award_amount_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_reported_Invalid,le.dt_last_reported_Invalid,le.process_date_Invalid,le.vendor_Invalid,le.state_origin_Invalid,le.case_key_Invalid,le.parent_case_key_Invalid,le.court_code_Invalid,le.case_number_Invalid,le.case_type_code_Invalid,le.case_cause_code_Invalid,le.manner_of_filing_code_Invalid,le.filing_date_Invalid,le.manner_of_judgmt_code_Invalid,le.judgmt_date_Invalid,le.ruled_for_against_code_Invalid,le.judgmt_type_code_Invalid,le.judgmt_disposition_date_Invalid,le.judgmt_disposition_code_Invalid,le.disposition_code_Invalid,le.disposition_date_Invalid,le.suit_amount_Invalid,le.award_amount_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Matter_Fields.InvalidMessage_dt_first_reported(le.dt_first_reported_Invalid),Matter_Fields.InvalidMessage_dt_last_reported(le.dt_last_reported_Invalid),Matter_Fields.InvalidMessage_process_date(le.process_date_Invalid),Matter_Fields.InvalidMessage_vendor(le.vendor_Invalid),Matter_Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Matter_Fields.InvalidMessage_case_key(le.case_key_Invalid),Matter_Fields.InvalidMessage_parent_case_key(le.parent_case_key_Invalid),Matter_Fields.InvalidMessage_court_code(le.court_code_Invalid),Matter_Fields.InvalidMessage_case_number(le.case_number_Invalid),Matter_Fields.InvalidMessage_case_type_code(le.case_type_code_Invalid),Matter_Fields.InvalidMessage_case_cause_code(le.case_cause_code_Invalid),Matter_Fields.InvalidMessage_manner_of_filing_code(le.manner_of_filing_code_Invalid),Matter_Fields.InvalidMessage_filing_date(le.filing_date_Invalid),Matter_Fields.InvalidMessage_manner_of_judgmt_code(le.manner_of_judgmt_code_Invalid),Matter_Fields.InvalidMessage_judgmt_date(le.judgmt_date_Invalid),Matter_Fields.InvalidMessage_ruled_for_against_code(le.ruled_for_against_code_Invalid),Matter_Fields.InvalidMessage_judgmt_type_code(le.judgmt_type_code_Invalid),Matter_Fields.InvalidMessage_judgmt_disposition_date(le.judgmt_disposition_date_Invalid),Matter_Fields.InvalidMessage_judgmt_disposition_code(le.judgmt_disposition_code_Invalid),Matter_Fields.InvalidMessage_disposition_code(le.disposition_code_Invalid),Matter_Fields.InvalidMessage_disposition_date(le.disposition_date_Invalid),Matter_Fields.InvalidMessage_suit_amount(le.suit_amount_Invalid),Matter_Fields.InvalidMessage_award_amount(le.award_amount_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.case_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.parent_case_key_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.court_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.case_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.case_type_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.case_cause_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.manner_of_filing_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filing_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.manner_of_judgmt_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.judgmt_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ruled_for_against_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.judgmt_type_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.judgmt_disposition_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.judgmt_disposition_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.disposition_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.disposition_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.suit_amount_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.award_amount_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_reported','dt_last_reported','process_date','vendor','state_origin','case_key','parent_case_key','court_code','case_number','case_type_code','case_cause_code','manner_of_filing_code','filing_date','manner_of_judgmt_code','judgmt_date','ruled_for_against_code','judgmt_type_code','judgmt_disposition_date','judgmt_disposition_code','disposition_code','disposition_date','suit_amount','award_amount','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_CapLetter','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_Char','Invalid_CapLetter','Invalid_Date','Invalid_Char','Invalid_Date','Invalid_CapLetter','Invalid_CapLetter','Invalid_Date','Invalid_CapLetter','Invalid_Char','Invalid_Date','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.dt_first_reported,(SALT39.StrType)le.dt_last_reported,(SALT39.StrType)le.process_date,(SALT39.StrType)le.vendor,(SALT39.StrType)le.state_origin,(SALT39.StrType)le.case_key,(SALT39.StrType)le.parent_case_key,(SALT39.StrType)le.court_code,(SALT39.StrType)le.case_number,(SALT39.StrType)le.case_type_code,(SALT39.StrType)le.case_cause_code,(SALT39.StrType)le.manner_of_filing_code,(SALT39.StrType)le.filing_date,(SALT39.StrType)le.manner_of_judgmt_code,(SALT39.StrType)le.judgmt_date,(SALT39.StrType)le.ruled_for_against_code,(SALT39.StrType)le.judgmt_type_code,(SALT39.StrType)le.judgmt_disposition_date,(SALT39.StrType)le.judgmt_disposition_code,(SALT39.StrType)le.disposition_code,(SALT39.StrType)le.disposition_date,(SALT39.StrType)le.suit_amount,(SALT39.StrType)le.award_amount,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,23,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Matter_Layout_Civil_Court) prevDS = DATASET([], Matter_Layout_Civil_Court), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_reported:Invalid_Date:CUSTOM'
          ,'dt_last_reported:Invalid_Date:CUSTOM'
          ,'process_date:Invalid_Date:CUSTOM'
          ,'vendor:Invalid_Num:ALLOW'
          ,'state_origin:Invalid_CapLetter:ALLOW'
          ,'case_key:Invalid_Char:ALLOW'
          ,'parent_case_key:Invalid_Char:ALLOW'
          ,'court_code:Invalid_Char:ALLOW'
          ,'case_number:Invalid_Char:ALLOW'
          ,'case_type_code:Invalid_Char:ALLOW'
          ,'case_cause_code:Invalid_Char:ALLOW'
          ,'manner_of_filing_code:Invalid_CapLetter:ALLOW'
          ,'filing_date:Invalid_Date:CUSTOM'
          ,'manner_of_judgmt_code:Invalid_Char:ALLOW'
          ,'judgmt_date:Invalid_Date:CUSTOM'
          ,'ruled_for_against_code:Invalid_CapLetter:ALLOW'
          ,'judgmt_type_code:Invalid_CapLetter:ALLOW'
          ,'judgmt_disposition_date:Invalid_Date:CUSTOM'
          ,'judgmt_disposition_code:Invalid_CapLetter:ALLOW'
          ,'disposition_code:Invalid_Char:ALLOW'
          ,'disposition_date:Invalid_Date:CUSTOM'
          ,'suit_amount:Invalid_Num:ALLOW'
          ,'award_amount:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Matter_Fields.InvalidMessage_dt_first_reported(1)
          ,Matter_Fields.InvalidMessage_dt_last_reported(1)
          ,Matter_Fields.InvalidMessage_process_date(1)
          ,Matter_Fields.InvalidMessage_vendor(1)
          ,Matter_Fields.InvalidMessage_state_origin(1)
          ,Matter_Fields.InvalidMessage_case_key(1)
          ,Matter_Fields.InvalidMessage_parent_case_key(1)
          ,Matter_Fields.InvalidMessage_court_code(1)
          ,Matter_Fields.InvalidMessage_case_number(1)
          ,Matter_Fields.InvalidMessage_case_type_code(1)
          ,Matter_Fields.InvalidMessage_case_cause_code(1)
          ,Matter_Fields.InvalidMessage_manner_of_filing_code(1)
          ,Matter_Fields.InvalidMessage_filing_date(1)
          ,Matter_Fields.InvalidMessage_manner_of_judgmt_code(1)
          ,Matter_Fields.InvalidMessage_judgmt_date(1)
          ,Matter_Fields.InvalidMessage_ruled_for_against_code(1)
          ,Matter_Fields.InvalidMessage_judgmt_type_code(1)
          ,Matter_Fields.InvalidMessage_judgmt_disposition_date(1)
          ,Matter_Fields.InvalidMessage_judgmt_disposition_code(1)
          ,Matter_Fields.InvalidMessage_disposition_code(1)
          ,Matter_Fields.InvalidMessage_disposition_date(1)
          ,Matter_Fields.InvalidMessage_suit_amount(1)
          ,Matter_Fields.InvalidMessage_award_amount(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_reported_CUSTOM_ErrorCount
          ,le.dt_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.vendor_ALLOW_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount
          ,le.case_key_ALLOW_ErrorCount
          ,le.parent_case_key_ALLOW_ErrorCount
          ,le.court_code_ALLOW_ErrorCount
          ,le.case_number_ALLOW_ErrorCount
          ,le.case_type_code_ALLOW_ErrorCount
          ,le.case_cause_code_ALLOW_ErrorCount
          ,le.manner_of_filing_code_ALLOW_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.manner_of_judgmt_code_ALLOW_ErrorCount
          ,le.judgmt_date_CUSTOM_ErrorCount
          ,le.ruled_for_against_code_ALLOW_ErrorCount
          ,le.judgmt_type_code_ALLOW_ErrorCount
          ,le.judgmt_disposition_date_CUSTOM_ErrorCount
          ,le.judgmt_disposition_code_ALLOW_ErrorCount
          ,le.disposition_code_ALLOW_ErrorCount
          ,le.disposition_date_CUSTOM_ErrorCount
          ,le.suit_amount_ALLOW_ErrorCount
          ,le.award_amount_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_reported_CUSTOM_ErrorCount
          ,le.dt_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.vendor_ALLOW_ErrorCount
          ,le.state_origin_ALLOW_ErrorCount
          ,le.case_key_ALLOW_ErrorCount
          ,le.parent_case_key_ALLOW_ErrorCount
          ,le.court_code_ALLOW_ErrorCount
          ,le.case_number_ALLOW_ErrorCount
          ,le.case_type_code_ALLOW_ErrorCount
          ,le.case_cause_code_ALLOW_ErrorCount
          ,le.manner_of_filing_code_ALLOW_ErrorCount
          ,le.filing_date_CUSTOM_ErrorCount
          ,le.manner_of_judgmt_code_ALLOW_ErrorCount
          ,le.judgmt_date_CUSTOM_ErrorCount
          ,le.ruled_for_against_code_ALLOW_ErrorCount
          ,le.judgmt_type_code_ALLOW_ErrorCount
          ,le.judgmt_disposition_date_CUSTOM_ErrorCount
          ,le.judgmt_disposition_code_ALLOW_ErrorCount
          ,le.disposition_code_ALLOW_ErrorCount
          ,le.disposition_date_CUSTOM_ErrorCount
          ,le.suit_amount_ALLOW_ErrorCount
          ,le.award_amount_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := Matter_hygiene(PROJECT(h, Matter_Layout_Civil_Court));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_reported:' + getFieldTypeText(h.dt_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_reported:' + getFieldTypeText(h.dt_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_file:' + getFieldTypeText(h.source_file) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_key:' + getFieldTypeText(h.case_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parent_case_key:' + getFieldTypeText(h.parent_case_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_code:' + getFieldTypeText(h.court_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court:' + getFieldTypeText(h.court) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_number:' + getFieldTypeText(h.case_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_type_code:' + getFieldTypeText(h.case_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_type:' + getFieldTypeText(h.case_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_title:' + getFieldTypeText(h.case_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_cause_code:' + getFieldTypeText(h.case_cause_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_cause:' + getFieldTypeText(h.case_cause) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manner_of_filing_code:' + getFieldTypeText(h.manner_of_filing_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manner_of_filing:' + getFieldTypeText(h.manner_of_filing) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filing_date:' + getFieldTypeText(h.filing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manner_of_judgmt_code:' + getFieldTypeText(h.manner_of_judgmt_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'manner_of_judgmt:' + getFieldTypeText(h.manner_of_judgmt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgmt_date:' + getFieldTypeText(h.judgmt_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ruled_for_against_code:' + getFieldTypeText(h.ruled_for_against_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ruled_for_against:' + getFieldTypeText(h.ruled_for_against) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgmt_type_code:' + getFieldTypeText(h.judgmt_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgmt_type:' + getFieldTypeText(h.judgmt_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgmt_disposition_date:' + getFieldTypeText(h.judgmt_disposition_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgmt_disposition_code:' + getFieldTypeText(h.judgmt_disposition_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'judgmt_disposition:' + getFieldTypeText(h.judgmt_disposition) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'disposition_code:' + getFieldTypeText(h.disposition_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'disposition_description:' + getFieldTypeText(h.disposition_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'disposition_date:' + getFieldTypeText(h.disposition_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suit_amount:' + getFieldTypeText(h.suit_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'award_amount:' + getFieldTypeText(h.award_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_reported_cnt
          ,le.populated_dt_last_reported_cnt
          ,le.populated_process_date_cnt
          ,le.populated_vendor_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_source_file_cnt
          ,le.populated_case_key_cnt
          ,le.populated_parent_case_key_cnt
          ,le.populated_court_code_cnt
          ,le.populated_court_cnt
          ,le.populated_case_number_cnt
          ,le.populated_case_type_code_cnt
          ,le.populated_case_type_cnt
          ,le.populated_case_title_cnt
          ,le.populated_case_cause_code_cnt
          ,le.populated_case_cause_cnt
          ,le.populated_manner_of_filing_code_cnt
          ,le.populated_manner_of_filing_cnt
          ,le.populated_filing_date_cnt
          ,le.populated_manner_of_judgmt_code_cnt
          ,le.populated_manner_of_judgmt_cnt
          ,le.populated_judgmt_date_cnt
          ,le.populated_ruled_for_against_code_cnt
          ,le.populated_ruled_for_against_cnt
          ,le.populated_judgmt_type_code_cnt
          ,le.populated_judgmt_type_cnt
          ,le.populated_judgmt_disposition_date_cnt
          ,le.populated_judgmt_disposition_code_cnt
          ,le.populated_judgmt_disposition_cnt
          ,le.populated_disposition_code_cnt
          ,le.populated_disposition_description_cnt
          ,le.populated_disposition_date_cnt
          ,le.populated_suit_amount_cnt
          ,le.populated_award_amount_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_reported_pcnt
          ,le.populated_dt_last_reported_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_vendor_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_source_file_pcnt
          ,le.populated_case_key_pcnt
          ,le.populated_parent_case_key_pcnt
          ,le.populated_court_code_pcnt
          ,le.populated_court_pcnt
          ,le.populated_case_number_pcnt
          ,le.populated_case_type_code_pcnt
          ,le.populated_case_type_pcnt
          ,le.populated_case_title_pcnt
          ,le.populated_case_cause_code_pcnt
          ,le.populated_case_cause_pcnt
          ,le.populated_manner_of_filing_code_pcnt
          ,le.populated_manner_of_filing_pcnt
          ,le.populated_filing_date_pcnt
          ,le.populated_manner_of_judgmt_code_pcnt
          ,le.populated_manner_of_judgmt_pcnt
          ,le.populated_judgmt_date_pcnt
          ,le.populated_ruled_for_against_code_pcnt
          ,le.populated_ruled_for_against_pcnt
          ,le.populated_judgmt_type_code_pcnt
          ,le.populated_judgmt_type_pcnt
          ,le.populated_judgmt_disposition_date_pcnt
          ,le.populated_judgmt_disposition_code_pcnt
          ,le.populated_judgmt_disposition_pcnt
          ,le.populated_disposition_code_pcnt
          ,le.populated_disposition_description_pcnt
          ,le.populated_disposition_date_pcnt
          ,le.populated_suit_amount_pcnt
          ,le.populated_award_amount_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,34,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := Matter_Delta(prevDS, PROJECT(h, Matter_Layout_Civil_Court));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),34,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Matter_Layout_Civil_Court) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Civil_Court, Matter_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
