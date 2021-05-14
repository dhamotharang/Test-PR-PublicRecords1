IMPORT SALT311,STD;
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 4;
  EXPORT NumRulesFromFieldType := 4;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 4;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_tris_lnssi)
    UNSIGNED1 contrib_risk_field_Invalid;
    UNSIGNED1 contrib_risk_value_Invalid;
    UNSIGNED1 contrib_risk_attr_Invalid;
    UNSIGNED1 contrib_state_excl_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_tris_lnssi)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_tris_lnssi)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'contrib_risk_field:Invalid_AlphaNumDash:ALLOW'
          ,'contrib_risk_value:Invalid_AlphaNumPunc:ALLOW'
          ,'contrib_risk_attr:Invalid_num:ALLOW'
          ,'contrib_state_excl:Invalid_AlphaState:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_contrib_risk_field(1)
          ,Fields.InvalidMessage_contrib_risk_value(1)
          ,Fields.InvalidMessage_contrib_risk_attr(1)
          ,Fields.InvalidMessage_contrib_state_excl(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_tris_lnssi) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.contrib_risk_field_Invalid := Fields.InValid_contrib_risk_field((SALT311.StrType)le.contrib_risk_field);
    SELF.contrib_risk_value_Invalid := Fields.InValid_contrib_risk_value((SALT311.StrType)le.contrib_risk_value);
    SELF.contrib_risk_attr_Invalid := Fields.InValid_contrib_risk_attr((SALT311.StrType)le.contrib_risk_attr);
    SELF.contrib_state_excl_Invalid := Fields.InValid_contrib_state_excl((SALT311.StrType)le.contrib_state_excl);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_tris_lnssi);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.contrib_risk_field_Invalid << 0 ) + ( le.contrib_risk_value_Invalid << 1 ) + ( le.contrib_risk_attr_Invalid << 2 ) + ( le.contrib_state_excl_Invalid << 3 );
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
  EXPORT Infile := PROJECT(h,Layout_tris_lnssi);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.contrib_risk_field_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.contrib_risk_value_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.contrib_risk_attr_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.contrib_state_excl_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    contrib_risk_field_ALLOW_ErrorCount := COUNT(GROUP,h.contrib_risk_field_Invalid=1);
    contrib_risk_value_ALLOW_ErrorCount := COUNT(GROUP,h.contrib_risk_value_Invalid=1);
    contrib_risk_attr_ALLOW_ErrorCount := COUNT(GROUP,h.contrib_risk_attr_Invalid=1);
    contrib_state_excl_ALLOW_ErrorCount := COUNT(GROUP,h.contrib_state_excl_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.contrib_risk_field_Invalid > 0 OR h.contrib_risk_value_Invalid > 0 OR h.contrib_risk_attr_Invalid > 0 OR h.contrib_state_excl_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.contrib_risk_field_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contrib_risk_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contrib_risk_attr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contrib_state_excl_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.contrib_risk_field_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contrib_risk_value_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contrib_risk_attr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contrib_state_excl_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.contrib_risk_field_Invalid,le.contrib_risk_value_Invalid,le.contrib_risk_attr_Invalid,le.contrib_state_excl_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_contrib_risk_field(le.contrib_risk_field_Invalid),Fields.InvalidMessage_contrib_risk_value(le.contrib_risk_value_Invalid),Fields.InvalidMessage_contrib_risk_attr(le.contrib_risk_attr_Invalid),Fields.InvalidMessage_contrib_state_excl(le.contrib_state_excl_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.contrib_risk_field_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contrib_risk_value_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contrib_risk_attr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contrib_state_excl_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'contrib_risk_field','contrib_risk_value','contrib_risk_attr','contrib_state_excl','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_AlphaNumDash','Invalid_AlphaNumPunc','Invalid_num','Invalid_AlphaState','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.contrib_risk_field,(SALT311.StrType)le.contrib_risk_value,(SALT311.StrType)le.contrib_risk_attr,(SALT311.StrType)le.contrib_state_excl,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,4,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_tris_lnssi) prevDS = DATASET([], Layout_tris_lnssi), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.contrib_risk_field_ALLOW_ErrorCount
          ,le.contrib_risk_value_ALLOW_ErrorCount
          ,le.contrib_risk_attr_ALLOW_ErrorCount
          ,le.contrib_state_excl_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.contrib_risk_field_ALLOW_ErrorCount
          ,le.contrib_risk_value_ALLOW_ErrorCount
          ,le.contrib_risk_attr_ALLOW_ErrorCount
          ,le.contrib_state_excl_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_tris_lnssi));
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
          ,'contrib_risk_field:' + getFieldTypeText(h.contrib_risk_field) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contrib_risk_value:' + getFieldTypeText(h.contrib_risk_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contrib_risk_attr:' + getFieldTypeText(h.contrib_risk_attr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contrib_state_excl:' + getFieldTypeText(h.contrib_state_excl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_contrib_risk_field_cnt
          ,le.populated_contrib_risk_value_cnt
          ,le.populated_contrib_risk_attr_cnt
          ,le.populated_contrib_state_excl_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_contrib_risk_field_pcnt
          ,le.populated_contrib_risk_value_pcnt
          ,le.populated_contrib_risk_attr_pcnt
          ,le.populated_contrib_state_excl_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,4,xNormHygieneStats(LEFT,COUNTER,'POP'));

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

    mod_Delta := Delta(prevDS, PROJECT(h, Layout_tris_lnssi));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),4,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Layout_tris_lnssi) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(scrubs_tris_lnssi, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
