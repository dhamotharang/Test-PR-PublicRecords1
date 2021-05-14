IMPORT SALT311,STD;
EXPORT PortData_ValidateIn_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(PortData_ValidateIn_Layout_PhonesInfo)
    UNSIGNED1 tid_Invalid;
    UNSIGNED1 action_Invalid;
    UNSIGNED1 actts_Invalid;
    UNSIGNED1 digits_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 altspid_Invalid;
    UNSIGNED1 laltspid_Invalid;
    UNSIGNED1 linetype_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(PortData_ValidateIn_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(PortData_ValidateIn_Layout_PhonesInfo)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'tid:Invalid_Num:ALLOW'
          ,'action:Invalid_Action:ALLOW'
          ,'actts:Invalid_AlphaNum:ALLOW'
          ,'digits:Invalid_Num:ALLOW'
          ,'spid:Invalid_AlphaNum_Spc:ALLOW'
          ,'altspid:Invalid_AlphaNum_Spc:ALLOW'
          ,'laltspid:Invalid_AlphaNum_Spc:ALLOW'
          ,'linetype:Invalid_Type:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,PortData_ValidateIn_Fields.InvalidMessage_tid(1)
          ,PortData_ValidateIn_Fields.InvalidMessage_action(1)
          ,PortData_ValidateIn_Fields.InvalidMessage_actts(1)
          ,PortData_ValidateIn_Fields.InvalidMessage_digits(1)
          ,PortData_ValidateIn_Fields.InvalidMessage_spid(1)
          ,PortData_ValidateIn_Fields.InvalidMessage_altspid(1)
          ,PortData_ValidateIn_Fields.InvalidMessage_laltspid(1)
          ,PortData_ValidateIn_Fields.InvalidMessage_linetype(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(PortData_ValidateIn_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.tid_Invalid := PortData_ValidateIn_Fields.InValid_tid((SALT311.StrType)le.tid);
    SELF.action_Invalid := PortData_ValidateIn_Fields.InValid_action((SALT311.StrType)le.action);
    SELF.actts_Invalid := PortData_ValidateIn_Fields.InValid_actts((SALT311.StrType)le.actts);
    SELF.digits_Invalid := PortData_ValidateIn_Fields.InValid_digits((SALT311.StrType)le.digits);
    SELF.spid_Invalid := PortData_ValidateIn_Fields.InValid_spid((SALT311.StrType)le.spid);
    SELF.altspid_Invalid := PortData_ValidateIn_Fields.InValid_altspid((SALT311.StrType)le.altspid);
    SELF.laltspid_Invalid := PortData_ValidateIn_Fields.InValid_laltspid((SALT311.StrType)le.laltspid);
    SELF.linetype_Invalid := PortData_ValidateIn_Fields.InValid_linetype((SALT311.StrType)le.linetype);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),PortData_ValidateIn_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.tid_Invalid << 0 ) + ( le.action_Invalid << 1 ) + ( le.actts_Invalid << 2 ) + ( le.digits_Invalid << 3 ) + ( le.spid_Invalid << 4 ) + ( le.altspid_Invalid << 5 ) + ( le.laltspid_Invalid << 6 ) + ( le.linetype_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
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
  EXPORT Infile := PROJECT(h,PortData_ValidateIn_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.tid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.action_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.actts_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.digits_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.altspid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.laltspid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.linetype_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    tid_ALLOW_ErrorCount := COUNT(GROUP,h.tid_Invalid=1);
    action_ALLOW_ErrorCount := COUNT(GROUP,h.action_Invalid=1);
    actts_ALLOW_ErrorCount := COUNT(GROUP,h.actts_Invalid=1);
    digits_ALLOW_ErrorCount := COUNT(GROUP,h.digits_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    altspid_ALLOW_ErrorCount := COUNT(GROUP,h.altspid_Invalid=1);
    laltspid_ALLOW_ErrorCount := COUNT(GROUP,h.laltspid_Invalid=1);
    linetype_ALLOW_ErrorCount := COUNT(GROUP,h.linetype_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.tid_Invalid > 0 OR h.action_Invalid > 0 OR h.actts_Invalid > 0 OR h.digits_Invalid > 0 OR h.spid_Invalid > 0 OR h.altspid_Invalid > 0 OR h.laltspid_Invalid > 0 OR h.linetype_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.tid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.action_ALLOW_ErrorCount > 0, 1, 0) + IF(le.actts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.digits_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.altspid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.laltspid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.linetype_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.tid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.action_ALLOW_ErrorCount > 0, 1, 0) + IF(le.actts_ALLOW_ErrorCount > 0, 1, 0) + IF(le.digits_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.altspid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.laltspid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.linetype_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.tid_Invalid,le.action_Invalid,le.actts_Invalid,le.digits_Invalid,le.spid_Invalid,le.altspid_Invalid,le.laltspid_Invalid,le.linetype_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,PortData_ValidateIn_Fields.InvalidMessage_tid(le.tid_Invalid),PortData_ValidateIn_Fields.InvalidMessage_action(le.action_Invalid),PortData_ValidateIn_Fields.InvalidMessage_actts(le.actts_Invalid),PortData_ValidateIn_Fields.InvalidMessage_digits(le.digits_Invalid),PortData_ValidateIn_Fields.InvalidMessage_spid(le.spid_Invalid),PortData_ValidateIn_Fields.InvalidMessage_altspid(le.altspid_Invalid),PortData_ValidateIn_Fields.InvalidMessage_laltspid(le.laltspid_Invalid),PortData_ValidateIn_Fields.InvalidMessage_linetype(le.linetype_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.tid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.action_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.actts_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.digits_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.altspid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.laltspid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.linetype_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'tid','action','actts','digits','spid','altspid','laltspid','linetype','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Action','Invalid_AlphaNum','Invalid_Num','Invalid_AlphaNum_Spc','Invalid_AlphaNum_Spc','Invalid_AlphaNum_Spc','Invalid_Type','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.tid,(SALT311.StrType)le.action,(SALT311.StrType)le.actts,(SALT311.StrType)le.digits,(SALT311.StrType)le.spid,(SALT311.StrType)le.altspid,(SALT311.StrType)le.laltspid,(SALT311.StrType)le.linetype,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(PortData_ValidateIn_Layout_PhonesInfo) prevDS = DATASET([], PortData_ValidateIn_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.tid_ALLOW_ErrorCount
          ,le.action_ALLOW_ErrorCount
          ,le.actts_ALLOW_ErrorCount
          ,le.digits_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.altspid_ALLOW_ErrorCount
          ,le.laltspid_ALLOW_ErrorCount
          ,le.linetype_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.tid_ALLOW_ErrorCount
          ,le.action_ALLOW_ErrorCount
          ,le.actts_ALLOW_ErrorCount
          ,le.digits_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.altspid_ALLOW_ErrorCount
          ,le.laltspid_ALLOW_ErrorCount
          ,le.linetype_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := PortData_ValidateIn_hygiene(PROJECT(h, PortData_ValidateIn_Layout_PhonesInfo));
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
          ,'tid:' + getFieldTypeText(h.tid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'action:' + getFieldTypeText(h.action) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'actts:' + getFieldTypeText(h.actts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'digits:' + getFieldTypeText(h.digits) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spid:' + getFieldTypeText(h.spid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'altspid:' + getFieldTypeText(h.altspid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'laltspid:' + getFieldTypeText(h.laltspid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'linetype:' + getFieldTypeText(h.linetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_tid_cnt
          ,le.populated_action_cnt
          ,le.populated_actts_cnt
          ,le.populated_digits_cnt
          ,le.populated_spid_cnt
          ,le.populated_altspid_cnt
          ,le.populated_laltspid_cnt
          ,le.populated_linetype_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_tid_pcnt
          ,le.populated_action_pcnt
          ,le.populated_actts_pcnt
          ,le.populated_digits_pcnt
          ,le.populated_spid_pcnt
          ,le.populated_altspid_pcnt
          ,le.populated_laltspid_pcnt
          ,le.populated_linetype_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,8,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := PortData_ValidateIn_Delta(prevDS, PROJECT(h, PortData_ValidateIn_Layout_PhonesInfo));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),8,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(PortData_ValidateIn_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, PortData_ValidateIn_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
