IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT BaseFile2_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 9;
  EXPORT NumRulesFromFieldType := 9;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 9;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(BaseFile2_Layout_Phone_TCPA)
    UNSIGNED1 num_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 end_range_Invalid;
    UNSIGNED1 expand_end_range_Invalid;
    UNSIGNED1 expand_range_max_count_Invalid;
    UNSIGNED1 expand_phone_Invalid;
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 phone_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(BaseFile2_Layout_Phone_TCPA)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(BaseFile2_Layout_Phone_TCPA)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'num:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'end_range:Invalid_Num_Space:ALLOW'
          ,'expand_end_range:Invalid_Num_Space:ALLOW'
          ,'expand_range_max_count:Invalid_Num_Space:ALLOW'
          ,'expand_phone:Invalid_Num:ALLOW'
          ,'dt_first_seen:Invalid_Date:CUSTOM'
          ,'dt_last_seen:Invalid_Date:CUSTOM'
          ,'phone_type:Invalid_PType:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,BaseFile2_Fields.InvalidMessage_num(1)
          ,BaseFile2_Fields.InvalidMessage_phone(1)
          ,BaseFile2_Fields.InvalidMessage_end_range(1)
          ,BaseFile2_Fields.InvalidMessage_expand_end_range(1)
          ,BaseFile2_Fields.InvalidMessage_expand_range_max_count(1)
          ,BaseFile2_Fields.InvalidMessage_expand_phone(1)
          ,BaseFile2_Fields.InvalidMessage_dt_first_seen(1)
          ,BaseFile2_Fields.InvalidMessage_dt_last_seen(1)
          ,BaseFile2_Fields.InvalidMessage_phone_type(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(BaseFile2_Layout_Phone_TCPA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.num_Invalid := BaseFile2_Fields.InValid_num((SALT311.StrType)le.num);
    SELF.phone_Invalid := BaseFile2_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.end_range_Invalid := BaseFile2_Fields.InValid_end_range((SALT311.StrType)le.end_range);
    SELF.expand_end_range_Invalid := BaseFile2_Fields.InValid_expand_end_range((SALT311.StrType)le.expand_end_range);
    SELF.expand_range_max_count_Invalid := BaseFile2_Fields.InValid_expand_range_max_count((SALT311.StrType)le.expand_range_max_count);
    SELF.expand_phone_Invalid := BaseFile2_Fields.InValid_expand_phone((SALT311.StrType)le.expand_phone);
    SELF.dt_first_seen_Invalid := BaseFile2_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := BaseFile2_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.phone_type_Invalid := BaseFile2_Fields.InValid_phone_type((SALT311.StrType)le.phone_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),BaseFile2_Layout_Phone_TCPA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.num_Invalid << 0 ) + ( le.phone_Invalid << 1 ) + ( le.end_range_Invalid << 2 ) + ( le.expand_end_range_Invalid << 3 ) + ( le.expand_range_max_count_Invalid << 4 ) + ( le.expand_phone_Invalid << 5 ) + ( le.dt_first_seen_Invalid << 6 ) + ( le.dt_last_seen_Invalid << 7 ) + ( le.phone_type_Invalid << 8 );
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
  EXPORT Infile := PROJECT(h,BaseFile2_Layout_Phone_TCPA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.num_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.end_range_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.expand_end_range_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.expand_range_max_count_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.expand_phone_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phone_type_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    num_ALLOW_ErrorCount := COUNT(GROUP,h.num_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    end_range_ALLOW_ErrorCount := COUNT(GROUP,h.end_range_Invalid=1);
    expand_end_range_ALLOW_ErrorCount := COUNT(GROUP,h.expand_end_range_Invalid=1);
    expand_range_max_count_ALLOW_ErrorCount := COUNT(GROUP,h.expand_range_max_count_Invalid=1);
    expand_phone_ALLOW_ErrorCount := COUNT(GROUP,h.expand_phone_Invalid=1);
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    phone_type_ALLOW_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.num_Invalid > 0 OR h.phone_Invalid > 0 OR h.end_range_Invalid > 0 OR h.expand_end_range_Invalid > 0 OR h.expand_range_max_count_Invalid > 0 OR h.expand_phone_Invalid > 0 OR h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.phone_type_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.end_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expand_end_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expand_range_max_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expand_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_type_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.end_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expand_end_range_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expand_range_max_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.expand_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_type_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.num_Invalid,le.phone_Invalid,le.end_range_Invalid,le.expand_end_range_Invalid,le.expand_range_max_count_Invalid,le.expand_phone_Invalid,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.phone_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,BaseFile2_Fields.InvalidMessage_num(le.num_Invalid),BaseFile2_Fields.InvalidMessage_phone(le.phone_Invalid),BaseFile2_Fields.InvalidMessage_end_range(le.end_range_Invalid),BaseFile2_Fields.InvalidMessage_expand_end_range(le.expand_end_range_Invalid),BaseFile2_Fields.InvalidMessage_expand_range_max_count(le.expand_range_max_count_Invalid),BaseFile2_Fields.InvalidMessage_expand_phone(le.expand_phone_Invalid),BaseFile2_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),BaseFile2_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),BaseFile2_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.end_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expand_end_range_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expand_range_max_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.expand_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'num','phone','end_range','expand_end_range','expand_range_max_count','expand_phone','dt_first_seen','dt_last_seen','phone_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_Num_Space','Invalid_Num_Space','Invalid_Num_Space','Invalid_Num','Invalid_Date','Invalid_Date','Invalid_PType','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.num,(SALT311.StrType)le.phone,(SALT311.StrType)le.end_range,(SALT311.StrType)le.expand_end_range,(SALT311.StrType)le.expand_range_max_count,(SALT311.StrType)le.expand_phone,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.phone_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(BaseFile2_Layout_Phone_TCPA) prevDS = DATASET([], BaseFile2_Layout_Phone_TCPA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.num_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.end_range_ALLOW_ErrorCount
          ,le.expand_end_range_ALLOW_ErrorCount
          ,le.expand_range_max_count_ALLOW_ErrorCount
          ,le.expand_phone_ALLOW_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.phone_type_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.num_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.end_range_ALLOW_ErrorCount
          ,le.expand_end_range_ALLOW_ErrorCount
          ,le.expand_range_max_count_ALLOW_ErrorCount
          ,le.expand_phone_ALLOW_ErrorCount
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.phone_type_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := BaseFile2_hygiene(PROJECT(h, BaseFile2_Layout_Phone_TCPA));
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
          ,'num:' + getFieldTypeText(h.num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'end_range:' + getFieldTypeText(h.end_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'expand_end_range:' + getFieldTypeText(h.expand_end_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'expand_range_max_count:' + getFieldTypeText(h.expand_range_max_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'expand_phone:' + getFieldTypeText(h.expand_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'is_current:' + getFieldTypeText(h.is_current) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_type:' + getFieldTypeText(h.phone_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_num_cnt
          ,le.populated_phone_cnt
          ,le.populated_end_range_cnt
          ,le.populated_expand_end_range_cnt
          ,le.populated_expand_range_max_count_cnt
          ,le.populated_expand_phone_cnt
          ,le.populated_is_current_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_phone_type_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_num_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_end_range_pcnt
          ,le.populated_expand_end_range_pcnt
          ,le.populated_expand_range_max_count_pcnt
          ,le.populated_expand_phone_pcnt
          ,le.populated_is_current_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_phone_type_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,10,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := BaseFile2_Delta(prevDS, PROJECT(h, BaseFile2_Layout_Phone_TCPA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),10,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(BaseFile2_Layout_Phone_TCPA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Phone_TCPA, BaseFile2_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
