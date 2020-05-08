IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 13;
  EXPORT NumRulesFromFieldType := 13;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 12;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_CrashCarrier)
    UNSIGNED1 carrier_id_Invalid;
    UNSIGNED1 crash_id_Invalid;
    UNSIGNED1 carrier_name_Invalid;
    UNSIGNED1 carrier_street_Invalid;
    UNSIGNED1 carrier_city_Invalid;
    UNSIGNED1 carrier_state_Invalid;
    UNSIGNED1 carrier_zip_code_Invalid;
    UNSIGNED1 docket_number_Invalid;
    UNSIGNED1 interstate_Invalid;
    UNSIGNED1 no_id_flag_Invalid;
    UNSIGNED1 state_number_Invalid;
    UNSIGNED1 state_issuing_number_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_CrashCarrier)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_CrashCarrier) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.carrier_id_Invalid := Fields.InValid_carrier_id((SALT311.StrType)le.carrier_id);
    SELF.crash_id_Invalid := Fields.InValid_crash_id((SALT311.StrType)le.crash_id);
    SELF.carrier_name_Invalid := Fields.InValid_carrier_name((SALT311.StrType)le.carrier_name);
    SELF.carrier_street_Invalid := Fields.InValid_carrier_street((SALT311.StrType)le.carrier_street);
    SELF.carrier_city_Invalid := Fields.InValid_carrier_city((SALT311.StrType)le.carrier_city);
    SELF.carrier_state_Invalid := Fields.InValid_carrier_state((SALT311.StrType)le.carrier_state);
    SELF.carrier_zip_code_Invalid := Fields.InValid_carrier_zip_code((SALT311.StrType)le.carrier_zip_code);
    SELF.docket_number_Invalid := Fields.InValid_docket_number((SALT311.StrType)le.docket_number);
    SELF.interstate_Invalid := Fields.InValid_interstate((SALT311.StrType)le.interstate);
    SELF.no_id_flag_Invalid := Fields.InValid_no_id_flag((SALT311.StrType)le.no_id_flag);
    SELF.state_number_Invalid := Fields.InValid_state_number((SALT311.StrType)le.state_number);
    SELF.state_issuing_number_Invalid := Fields.InValid_state_issuing_number((SALT311.StrType)le.state_issuing_number);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_CrashCarrier);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.carrier_id_Invalid << 0 ) + ( le.crash_id_Invalid << 1 ) + ( le.carrier_name_Invalid << 2 ) + ( le.carrier_street_Invalid << 4 ) + ( le.carrier_city_Invalid << 5 ) + ( le.carrier_state_Invalid << 6 ) + ( le.carrier_zip_code_Invalid << 7 ) + ( le.docket_number_Invalid << 8 ) + ( le.interstate_Invalid << 9 ) + ( le.no_id_flag_Invalid << 10 ) + ( le.state_number_Invalid << 11 ) + ( le.state_issuing_number_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_CrashCarrier);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.carrier_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.crash_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.carrier_name_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.carrier_street_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.carrier_city_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.carrier_state_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.carrier_zip_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.docket_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.interstate_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.no_id_flag_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.state_number_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.state_issuing_number_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    carrier_id_CUSTOM_ErrorCount := COUNT(GROUP,h.carrier_id_Invalid=1);
    crash_id_CUSTOM_ErrorCount := COUNT(GROUP,h.crash_id_Invalid=1);
    carrier_name_CUSTOM_ErrorCount := COUNT(GROUP,h.carrier_name_Invalid=1);
    carrier_name_LENGTHS_ErrorCount := COUNT(GROUP,h.carrier_name_Invalid=2);
    carrier_name_Total_ErrorCount := COUNT(GROUP,h.carrier_name_Invalid>0);
    carrier_street_CUSTOM_ErrorCount := COUNT(GROUP,h.carrier_street_Invalid=1);
    carrier_city_CUSTOM_ErrorCount := COUNT(GROUP,h.carrier_city_Invalid=1);
    carrier_state_CUSTOM_ErrorCount := COUNT(GROUP,h.carrier_state_Invalid=1);
    carrier_zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.carrier_zip_code_Invalid=1);
    docket_number_ALLOW_ErrorCount := COUNT(GROUP,h.docket_number_Invalid=1);
    interstate_ENUM_ErrorCount := COUNT(GROUP,h.interstate_Invalid=1);
    no_id_flag_ENUM_ErrorCount := COUNT(GROUP,h.no_id_flag_Invalid=1);
    state_number_CUSTOM_ErrorCount := COUNT(GROUP,h.state_number_Invalid=1);
    state_issuing_number_CUSTOM_ErrorCount := COUNT(GROUP,h.state_issuing_number_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.carrier_id_Invalid > 0 OR h.crash_id_Invalid > 0 OR h.carrier_name_Invalid > 0 OR h.carrier_street_Invalid > 0 OR h.carrier_city_Invalid > 0 OR h.carrier_state_Invalid > 0 OR h.carrier_zip_code_Invalid > 0 OR h.docket_number_Invalid > 0 OR h.interstate_Invalid > 0 OR h.no_id_flag_Invalid > 0 OR h.state_number_Invalid > 0 OR h.state_issuing_number_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.carrier_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.crash_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_name_Total_ErrorCount > 0, 1, 0) + IF(le.carrier_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.docket_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.interstate_ENUM_ErrorCount > 0, 1, 0) + IF(le.no_id_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.state_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_issuing_number_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.carrier_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.crash_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.carrier_street_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.carrier_zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.docket_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.interstate_ENUM_ErrorCount > 0, 1, 0) + IF(le.no_id_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.state_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_issuing_number_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.carrier_id_Invalid,le.crash_id_Invalid,le.carrier_name_Invalid,le.carrier_street_Invalid,le.carrier_city_Invalid,le.carrier_state_Invalid,le.carrier_zip_code_Invalid,le.docket_number_Invalid,le.interstate_Invalid,le.no_id_flag_Invalid,le.state_number_Invalid,le.state_issuing_number_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_carrier_id(le.carrier_id_Invalid),Fields.InvalidMessage_crash_id(le.crash_id_Invalid),Fields.InvalidMessage_carrier_name(le.carrier_name_Invalid),Fields.InvalidMessage_carrier_street(le.carrier_street_Invalid),Fields.InvalidMessage_carrier_city(le.carrier_city_Invalid),Fields.InvalidMessage_carrier_state(le.carrier_state_Invalid),Fields.InvalidMessage_carrier_zip_code(le.carrier_zip_code_Invalid),Fields.InvalidMessage_docket_number(le.docket_number_Invalid),Fields.InvalidMessage_interstate(le.interstate_Invalid),Fields.InvalidMessage_no_id_flag(le.no_id_flag_Invalid),Fields.InvalidMessage_state_number(le.state_number_Invalid),Fields.InvalidMessage_state_issuing_number(le.state_issuing_number_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.carrier_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.crash_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.carrier_name_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.carrier_street_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.carrier_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.carrier_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.carrier_zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.docket_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.interstate_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.no_id_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.state_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_issuing_number_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'carrier_id','crash_id','carrier_name','carrier_street','carrier_city','carrier_state','carrier_zip_code','docket_number','interstate','no_id_flag','state_number','state_issuing_number','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_id','Invalid_id','Invalid_mandatory_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_alpha','Invalid_Numeric_Optional','Invalid_interstate','Invalid_no_id_flag','Invalid_alpha','Invalid_alpha','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.carrier_id,(SALT311.StrType)le.crash_id,(SALT311.StrType)le.carrier_name,(SALT311.StrType)le.carrier_street,(SALT311.StrType)le.carrier_city,(SALT311.StrType)le.carrier_state,(SALT311.StrType)le.carrier_zip_code,(SALT311.StrType)le.docket_number,(SALT311.StrType)le.interstate,(SALT311.StrType)le.no_id_flag,(SALT311.StrType)le.state_number,(SALT311.StrType)le.state_issuing_number,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,12,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_CrashCarrier) prevDS = DATASET([], Layout_In_CrashCarrier), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'carrier_id:Invalid_id:CUSTOM'
          ,'crash_id:Invalid_id:CUSTOM'
          ,'carrier_name:Invalid_mandatory_alpha:CUSTOM','carrier_name:Invalid_mandatory_alpha:LENGTHS'
          ,'carrier_street:Invalid_alpha:CUSTOM'
          ,'carrier_city:Invalid_alpha:CUSTOM'
          ,'carrier_state:Invalid_alpha:CUSTOM'
          ,'carrier_zip_code:Invalid_alpha:CUSTOM'
          ,'docket_number:Invalid_Numeric_Optional:ALLOW'
          ,'interstate:Invalid_interstate:ENUM'
          ,'no_id_flag:Invalid_no_id_flag:ENUM'
          ,'state_number:Invalid_alpha:CUSTOM'
          ,'state_issuing_number:Invalid_alpha:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_carrier_id(1)
          ,Fields.InvalidMessage_crash_id(1)
          ,Fields.InvalidMessage_carrier_name(1),Fields.InvalidMessage_carrier_name(2)
          ,Fields.InvalidMessage_carrier_street(1)
          ,Fields.InvalidMessage_carrier_city(1)
          ,Fields.InvalidMessage_carrier_state(1)
          ,Fields.InvalidMessage_carrier_zip_code(1)
          ,Fields.InvalidMessage_docket_number(1)
          ,Fields.InvalidMessage_interstate(1)
          ,Fields.InvalidMessage_no_id_flag(1)
          ,Fields.InvalidMessage_state_number(1)
          ,Fields.InvalidMessage_state_issuing_number(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.carrier_id_CUSTOM_ErrorCount
          ,le.crash_id_CUSTOM_ErrorCount
          ,le.carrier_name_CUSTOM_ErrorCount,le.carrier_name_LENGTHS_ErrorCount
          ,le.carrier_street_CUSTOM_ErrorCount
          ,le.carrier_city_CUSTOM_ErrorCount
          ,le.carrier_state_CUSTOM_ErrorCount
          ,le.carrier_zip_code_CUSTOM_ErrorCount
          ,le.docket_number_ALLOW_ErrorCount
          ,le.interstate_ENUM_ErrorCount
          ,le.no_id_flag_ENUM_ErrorCount
          ,le.state_number_CUSTOM_ErrorCount
          ,le.state_issuing_number_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.carrier_id_CUSTOM_ErrorCount
          ,le.crash_id_CUSTOM_ErrorCount
          ,le.carrier_name_CUSTOM_ErrorCount,le.carrier_name_LENGTHS_ErrorCount
          ,le.carrier_street_CUSTOM_ErrorCount
          ,le.carrier_city_CUSTOM_ErrorCount
          ,le.carrier_state_CUSTOM_ErrorCount
          ,le.carrier_zip_code_CUSTOM_ErrorCount
          ,le.docket_number_ALLOW_ErrorCount
          ,le.interstate_ENUM_ErrorCount
          ,le.no_id_flag_ENUM_ErrorCount
          ,le.state_number_CUSTOM_ErrorCount
          ,le.state_issuing_number_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_In_CrashCarrier));
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
          ,'carrier_id:' + getFieldTypeText(h.carrier_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crash_id:' + getFieldTypeText(h.crash_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_source_code:' + getFieldTypeText(h.carrier_source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_name:' + getFieldTypeText(h.carrier_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_street:' + getFieldTypeText(h.carrier_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_city:' + getFieldTypeText(h.carrier_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_city_code:' + getFieldTypeText(h.carrier_city_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_state:' + getFieldTypeText(h.carrier_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier_zip_code:' + getFieldTypeText(h.carrier_zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crash_colonia:' + getFieldTypeText(h.crash_colonia) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'docket_number:' + getFieldTypeText(h.docket_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'interstate:' + getFieldTypeText(h.interstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'no_id_flag:' + getFieldTypeText(h.no_id_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_number:' + getFieldTypeText(h.state_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_issuing_number:' + getFieldTypeText(h.state_issuing_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_carrier_id_cnt
          ,le.populated_crash_id_cnt
          ,le.populated_carrier_source_code_cnt
          ,le.populated_carrier_name_cnt
          ,le.populated_carrier_street_cnt
          ,le.populated_carrier_city_cnt
          ,le.populated_carrier_city_code_cnt
          ,le.populated_carrier_state_cnt
          ,le.populated_carrier_zip_code_cnt
          ,le.populated_crash_colonia_cnt
          ,le.populated_docket_number_cnt
          ,le.populated_interstate_cnt
          ,le.populated_no_id_flag_cnt
          ,le.populated_state_number_cnt
          ,le.populated_state_issuing_number_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_carrier_id_pcnt
          ,le.populated_crash_id_pcnt
          ,le.populated_carrier_source_code_pcnt
          ,le.populated_carrier_name_pcnt
          ,le.populated_carrier_street_pcnt
          ,le.populated_carrier_city_pcnt
          ,le.populated_carrier_city_code_pcnt
          ,le.populated_carrier_state_pcnt
          ,le.populated_carrier_zip_code_pcnt
          ,le.populated_crash_colonia_pcnt
          ,le.populated_docket_number_pcnt
          ,le.populated_interstate_pcnt
          ,le.populated_no_id_flag_pcnt
          ,le.populated_state_number_pcnt
          ,le.populated_state_issuing_number_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,15,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_CrashCarrier));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),15,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_CrashCarrier) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_CrashCarrier, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
