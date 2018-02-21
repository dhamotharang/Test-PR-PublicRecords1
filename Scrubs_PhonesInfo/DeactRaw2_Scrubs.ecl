IMPORT SALT39,STD;
EXPORT DeactRaw2_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 6;
  EXPORT NumRulesFromFieldType := 6;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 6;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(DeactRaw2_Layout_Phonesinfo)
    UNSIGNED1 msisdn_Invalid;
    UNSIGNED1 timestamp_Invalid;
    UNSIGNED1 changeid_Invalid;
    UNSIGNED1 operatorid_Invalid;
    UNSIGNED1 msisdneid_Invalid;
    UNSIGNED1 msisdnnew_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(DeactRaw2_Layout_Phonesinfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(DeactRaw2_Layout_Phonesinfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.msisdn_Invalid := DeactRaw2_Fields.InValid_msisdn((SALT39.StrType)le.msisdn);
    SELF.timestamp_Invalid := DeactRaw2_Fields.InValid_timestamp((SALT39.StrType)le.timestamp);
    SELF.changeid_Invalid := DeactRaw2_Fields.InValid_changeid((SALT39.StrType)le.changeid);
    SELF.operatorid_Invalid := DeactRaw2_Fields.InValid_operatorid((SALT39.StrType)le.operatorid);
    SELF.msisdneid_Invalid := DeactRaw2_Fields.InValid_msisdneid((SALT39.StrType)le.msisdneid);
    SELF.msisdnnew_Invalid := DeactRaw2_Fields.InValid_msisdnnew((SALT39.StrType)le.msisdnnew);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DeactRaw2_Layout_Phonesinfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.msisdn_Invalid << 0 ) + ( le.timestamp_Invalid << 1 ) + ( le.changeid_Invalid << 2 ) + ( le.operatorid_Invalid << 3 ) + ( le.msisdneid_Invalid << 4 ) + ( le.msisdnnew_Invalid << 5 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DeactRaw2_Layout_Phonesinfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.msisdn_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.timestamp_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.changeid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.operatorid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.msisdneid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.msisdnnew_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    msisdn_ALLOW_ErrorCount := COUNT(GROUP,h.msisdn_Invalid=1);
    timestamp_ALLOW_ErrorCount := COUNT(GROUP,h.timestamp_Invalid=1);
    changeid_ALLOW_ErrorCount := COUNT(GROUP,h.changeid_Invalid=1);
    operatorid_ALLOW_ErrorCount := COUNT(GROUP,h.operatorid_Invalid=1);
    msisdneid_ALLOW_ErrorCount := COUNT(GROUP,h.msisdneid_Invalid=1);
    msisdnnew_ALLOW_ErrorCount := COUNT(GROUP,h.msisdnnew_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.msisdn_Invalid > 0 OR h.timestamp_Invalid > 0 OR h.changeid_Invalid > 0 OR h.operatorid_Invalid > 0 OR h.msisdneid_Invalid > 0 OR h.msisdnnew_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.msisdn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.timestamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.changeid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operatorid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msisdneid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msisdnnew_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.msisdn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.timestamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.changeid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.operatorid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msisdneid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.msisdnnew_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.msisdn_Invalid,le.timestamp_Invalid,le.changeid_Invalid,le.operatorid_Invalid,le.msisdneid_Invalid,le.msisdnnew_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DeactRaw2_Fields.InvalidMessage_msisdn(le.msisdn_Invalid),DeactRaw2_Fields.InvalidMessage_timestamp(le.timestamp_Invalid),DeactRaw2_Fields.InvalidMessage_changeid(le.changeid_Invalid),DeactRaw2_Fields.InvalidMessage_operatorid(le.operatorid_Invalid),DeactRaw2_Fields.InvalidMessage_msisdneid(le.msisdneid_Invalid),DeactRaw2_Fields.InvalidMessage_msisdnnew(le.msisdnnew_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.msisdn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.timestamp_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.changeid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.operatorid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msisdneid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.msisdnnew_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'msisdn','timestamp','changeid','operatorid','msisdneid','msisdnnew','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_TimeStamp','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.msisdn,(SALT39.StrType)le.timestamp,(SALT39.StrType)le.changeid,(SALT39.StrType)le.operatorid,(SALT39.StrType)le.msisdneid,(SALT39.StrType)le.msisdnnew,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,6,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(DeactRaw2_Layout_Phonesinfo) prevDS = DATASET([], DeactRaw2_Layout_Phonesinfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'msisdn:Invalid_Num:ALLOW'
          ,'timestamp:Invalid_TimeStamp:ALLOW'
          ,'changeid:Invalid_Num:ALLOW'
          ,'operatorid:Invalid_Num:ALLOW'
          ,'msisdneid:Invalid_Num:ALLOW'
          ,'msisdnnew:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DeactRaw2_Fields.InvalidMessage_msisdn(1)
          ,DeactRaw2_Fields.InvalidMessage_timestamp(1)
          ,DeactRaw2_Fields.InvalidMessage_changeid(1)
          ,DeactRaw2_Fields.InvalidMessage_operatorid(1)
          ,DeactRaw2_Fields.InvalidMessage_msisdneid(1)
          ,DeactRaw2_Fields.InvalidMessage_msisdnnew(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.msisdn_ALLOW_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.changeid_ALLOW_ErrorCount
          ,le.operatorid_ALLOW_ErrorCount
          ,le.msisdneid_ALLOW_ErrorCount
          ,le.msisdnnew_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.msisdn_ALLOW_ErrorCount
          ,le.timestamp_ALLOW_ErrorCount
          ,le.changeid_ALLOW_ErrorCount
          ,le.operatorid_ALLOW_ErrorCount
          ,le.msisdneid_ALLOW_ErrorCount
          ,le.msisdnnew_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := DeactRaw2_hygiene(PROJECT(h, DeactRaw2_Layout_Phonesinfo));
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
          ,'msisdn:' + getFieldTypeText(h.msisdn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timestamp:' + getFieldTypeText(h.timestamp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'changeid:' + getFieldTypeText(h.changeid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'operatorid:' + getFieldTypeText(h.operatorid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msisdneid:' + getFieldTypeText(h.msisdneid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msisdnnew:' + getFieldTypeText(h.msisdnnew) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_msisdn_cnt
          ,le.populated_timestamp_cnt
          ,le.populated_changeid_cnt
          ,le.populated_operatorid_cnt
          ,le.populated_msisdneid_cnt
          ,le.populated_msisdnnew_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_msisdn_pcnt
          ,le.populated_timestamp_pcnt
          ,le.populated_changeid_pcnt
          ,le.populated_operatorid_pcnt
          ,le.populated_msisdneid_pcnt
          ,le.populated_msisdnnew_pcnt
          ,le.populated_filename_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,7,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := DeactRaw2_Delta(prevDS, PROJECT(h, DeactRaw2_Layout_Phonesinfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),7,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(DeactRaw2_Layout_Phonesinfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Phonesinfo, DeactRaw2_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
