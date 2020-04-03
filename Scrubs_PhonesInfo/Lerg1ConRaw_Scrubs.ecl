IMPORT SALT311,STD;
EXPORT Lerg1ConRaw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 6;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Lerg1ConRaw_Layout_PhonesInfo)
    UNSIGNED1 ocn_Invalid;
    UNSIGNED1 ocn_name_Invalid;
    UNSIGNED1 ocn_state_Invalid;
    UNSIGNED1 contact_function_Invalid;
    UNSIGNED1 contact_phone_Invalid;
    UNSIGNED1 filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Lerg1ConRaw_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Lerg1ConRaw_Layout_PhonesInfo)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'ocn:Invalid_Ocn:ALLOW','ocn:Invalid_Ocn:LENGTHS'
          ,'ocn_name:Invalid_NotBlank:LENGTHS'
          ,'ocn_state:Invalid_Ocn_State:ALLOW','ocn_state:Invalid_Ocn_State:LENGTHS'
          ,'contact_function:Invalid_NotBlank:LENGTHS'
          ,'contact_phone:Invalid_Phone:ALLOW'
          ,'filename:Invalid_Filename:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Lerg1ConRaw_Fields.InvalidMessage_ocn(1),Lerg1ConRaw_Fields.InvalidMessage_ocn(2)
          ,Lerg1ConRaw_Fields.InvalidMessage_ocn_name(1)
          ,Lerg1ConRaw_Fields.InvalidMessage_ocn_state(1),Lerg1ConRaw_Fields.InvalidMessage_ocn_state(2)
          ,Lerg1ConRaw_Fields.InvalidMessage_contact_function(1)
          ,Lerg1ConRaw_Fields.InvalidMessage_contact_phone(1)
          ,Lerg1ConRaw_Fields.InvalidMessage_filename(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Lerg1ConRaw_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ocn_Invalid := Lerg1ConRaw_Fields.InValid_ocn((SALT311.StrType)le.ocn);
    SELF.ocn_name_Invalid := Lerg1ConRaw_Fields.InValid_ocn_name((SALT311.StrType)le.ocn_name);
    SELF.ocn_state_Invalid := Lerg1ConRaw_Fields.InValid_ocn_state((SALT311.StrType)le.ocn_state);
    SELF.contact_function_Invalid := Lerg1ConRaw_Fields.InValid_contact_function((SALT311.StrType)le.contact_function);
    SELF.contact_phone_Invalid := Lerg1ConRaw_Fields.InValid_contact_phone((SALT311.StrType)le.contact_phone);
    SELF.filename_Invalid := Lerg1ConRaw_Fields.InValid_filename((SALT311.StrType)le.filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Lerg1ConRaw_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ocn_Invalid << 0 ) + ( le.ocn_name_Invalid << 2 ) + ( le.ocn_state_Invalid << 3 ) + ( le.contact_function_Invalid << 5 ) + ( le.contact_phone_Invalid << 6 ) + ( le.filename_Invalid << 7 );
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
  EXPORT Infile := PROJECT(h,Lerg1ConRaw_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ocn_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.ocn_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.ocn_state_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.contact_function_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.contact_phone_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ocn_ALLOW_ErrorCount := COUNT(GROUP,h.ocn_Invalid=1);
    ocn_LENGTHS_ErrorCount := COUNT(GROUP,h.ocn_Invalid=2);
    ocn_Total_ErrorCount := COUNT(GROUP,h.ocn_Invalid>0);
    ocn_name_LENGTHS_ErrorCount := COUNT(GROUP,h.ocn_name_Invalid=1);
    ocn_state_ALLOW_ErrorCount := COUNT(GROUP,h.ocn_state_Invalid=1);
    ocn_state_LENGTHS_ErrorCount := COUNT(GROUP,h.ocn_state_Invalid=2);
    ocn_state_Total_ErrorCount := COUNT(GROUP,h.ocn_state_Invalid>0);
    contact_function_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_function_Invalid=1);
    contact_phone_ALLOW_ErrorCount := COUNT(GROUP,h.contact_phone_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ocn_Invalid > 0 OR h.ocn_name_Invalid > 0 OR h.ocn_state_Invalid > 0 OR h.contact_function_Invalid > 0 OR h.contact_phone_Invalid > 0 OR h.filename_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ocn_Total_ErrorCount > 0, 1, 0) + IF(le.ocn_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocn_state_Total_ErrorCount > 0, 1, 0) + IF(le.contact_function_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocn_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocn_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_function_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.contact_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ocn_Invalid,le.ocn_name_Invalid,le.ocn_state_Invalid,le.contact_function_Invalid,le.contact_phone_Invalid,le.filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Lerg1ConRaw_Fields.InvalidMessage_ocn(le.ocn_Invalid),Lerg1ConRaw_Fields.InvalidMessage_ocn_name(le.ocn_name_Invalid),Lerg1ConRaw_Fields.InvalidMessage_ocn_state(le.ocn_state_Invalid),Lerg1ConRaw_Fields.InvalidMessage_contact_function(le.contact_function_Invalid),Lerg1ConRaw_Fields.InvalidMessage_contact_phone(le.contact_phone_Invalid),Lerg1ConRaw_Fields.InvalidMessage_filename(le.filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ocn_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ocn_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ocn_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.contact_function_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.contact_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ocn','ocn_name','ocn_state','contact_function','contact_phone','filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Ocn','Invalid_NotBlank','Invalid_Ocn_State','Invalid_NotBlank','Invalid_Phone','Invalid_Filename','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ocn,(SALT311.StrType)le.ocn_name,(SALT311.StrType)le.ocn_state,(SALT311.StrType)le.contact_function,(SALT311.StrType)le.contact_phone,(SALT311.StrType)le.filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,6,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Lerg1ConRaw_Layout_PhonesInfo) prevDS = DATASET([], Lerg1ConRaw_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.ocn_ALLOW_ErrorCount,le.ocn_LENGTHS_ErrorCount
          ,le.ocn_name_LENGTHS_ErrorCount
          ,le.ocn_state_ALLOW_ErrorCount,le.ocn_state_LENGTHS_ErrorCount
          ,le.contact_function_LENGTHS_ErrorCount
          ,le.contact_phone_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ocn_ALLOW_ErrorCount,le.ocn_LENGTHS_ErrorCount
          ,le.ocn_name_LENGTHS_ErrorCount
          ,le.ocn_state_ALLOW_ErrorCount,le.ocn_state_LENGTHS_ErrorCount
          ,le.contact_function_LENGTHS_ErrorCount
          ,le.contact_phone_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Lerg1ConRaw_hygiene(PROJECT(h, Lerg1ConRaw_Layout_PhonesInfo));
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
          ,'ocn:' + getFieldTypeText(h.ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn_name:' + getFieldTypeText(h.ocn_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn_state:' + getFieldTypeText(h.ocn_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_function:' + getFieldTypeText(h.contact_function) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_phone:' + getFieldTypeText(h.contact_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_information:' + getFieldTypeText(h.contact_information) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler:' + getFieldTypeText(h.filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ocn_cnt
          ,le.populated_ocn_name_cnt
          ,le.populated_ocn_state_cnt
          ,le.populated_contact_function_cnt
          ,le.populated_contact_phone_cnt
          ,le.populated_contact_information_cnt
          ,le.populated_filler_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ocn_pcnt
          ,le.populated_ocn_name_pcnt
          ,le.populated_ocn_state_pcnt
          ,le.populated_contact_function_pcnt
          ,le.populated_contact_phone_pcnt
          ,le.populated_contact_information_pcnt
          ,le.populated_filler_pcnt
          ,le.populated_filename_pcnt,0);
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
 
    mod_Delta := Lerg1ConRaw_Delta(prevDS, PROJECT(h, Lerg1ConRaw_Layout_PhonesInfo));
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
 
EXPORT StandardStats(DATASET(Lerg1ConRaw_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, Lerg1ConRaw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
