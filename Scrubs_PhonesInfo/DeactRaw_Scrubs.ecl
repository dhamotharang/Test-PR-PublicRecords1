IMPORT SALT38,STD;
EXPORT DeactRaw_Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 5;
  EXPORT NumRulesFromFieldType := 5;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 5;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(DeactRaw_Layout_PhonesInfo)
    UNSIGNED1 action_code_Invalid;
    UNSIGNED1 timestamp_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_swap_Invalid;
    UNSIGNED1 filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(DeactRaw_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(DeactRaw_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.action_code_Invalid := DeactRaw_Fields.InValid_action_code((SALT38.StrType)le.action_code);
    SELF.timestamp_Invalid := DeactRaw_Fields.InValid_timestamp((SALT38.StrType)le.timestamp);
    SELF.phone_Invalid := DeactRaw_Fields.InValid_phone((SALT38.StrType)le.phone);
    SELF.phone_swap_Invalid := DeactRaw_Fields.InValid_phone_swap((SALT38.StrType)le.phone_swap);
    SELF.filename_Invalid := DeactRaw_Fields.InValid_filename((SALT38.StrType)le.filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DeactRaw_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.action_code_Invalid << 0 ) + ( le.timestamp_Invalid << 1 ) + ( le.phone_Invalid << 2 ) + ( le.phone_swap_Invalid << 3 ) + ( le.filename_Invalid << 4 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DeactRaw_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.action_code_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.timestamp_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.phone_swap_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    action_code_ENUM_ErrorCount := COUNT(GROUP,h.action_code_Invalid=1);
    timestamp_ALLOW_ErrorCount := COUNT(GROUP,h.timestamp_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_swap_ALLOW_ErrorCount := COUNT(GROUP,h.phone_swap_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.action_code_Invalid > 0 OR h.timestamp_Invalid > 0 OR h.phone_Invalid > 0 OR h.phone_swap_Invalid > 0 OR h.filename_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.action_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.timestamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_swap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.action_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.timestamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_swap_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.action_code_Invalid,le.timestamp_Invalid,le.phone_Invalid,le.phone_swap_Invalid,le.filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DeactRaw_Fields.InvalidMessage_action_code(le.action_code_Invalid),DeactRaw_Fields.InvalidMessage_timestamp(le.timestamp_Invalid),DeactRaw_Fields.InvalidMessage_phone(le.phone_Invalid),DeactRaw_Fields.InvalidMessage_phone_swap(le.phone_swap_Invalid),DeactRaw_Fields.InvalidMessage_filename(le.filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.action_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.timestamp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_swap_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'action_code','timestamp','phone','phone_swap','filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Action_Code','Invalid_Num','Invalid_Num','Invalid_Num_Blank','Invalid_Filename','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.action_code,(SALT38.StrType)le.timestamp,(SALT38.StrType)le.phone,(SALT38.StrType)le.phone_swap,(SALT38.StrType)le.filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,5,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(DeactRaw_Layout_PhonesInfo) prevDS = DATASET([], DeactRaw_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'action_code:Invalid_Action_Code:ENUM'
          ,'timestamp:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'phone_swap:Invalid_Num_Blank:ALLOW'
          ,'filename:Invalid_Filename:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DeactRaw_Fields.InvalidMessage_action_code(1)
          ,DeactRaw_Fields.InvalidMessage_timestamp(1)
          ,DeactRaw_Fields.InvalidMessage_phone(1)
          ,DeactRaw_Fields.InvalidMessage_phone_swap(1)
          ,DeactRaw_Fields.InvalidMessage_filename(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.action_code_ENUM_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.action_code_ENUM_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.phone_swap_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);

    // field population stats
    mod_hygiene := DeactRaw_hygiene(PROJECT(h, DeactRaw_Layout_PhonesInfo));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'action_code:' + getFieldTypeText(h.action_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timestamp:' + getFieldTypeText(h.timestamp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_swap:' + getFieldTypeText(h.phone_swap) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_action_code_cnt
          ,le.populated_timestamp_cnt
          ,le.populated_phone_cnt
          ,le.populated_phone_swap_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_action_code_pcnt
          ,le.populated_timestamp_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_phone_swap_pcnt
          ,le.populated_filename_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,5,xNormHygieneStats(LEFT,COUNTER,'POP'));

  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));

    mod_Delta := DeactRaw_Delta(prevDS, PROJECT(h, DeactRaw_Layout_PhonesInfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),5,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(DeactRaw_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, DeactRaw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));

  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);

  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));

  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
