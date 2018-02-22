IMPORT SALT39,STD;
IMPORT Scrubs_Voters; // Import modules for FieldTypes attribute definitions
EXPORT Base_History_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 4;
  EXPORT NumRulesFromFieldType := 4;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 4;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Base_History_Layout_Voters)
    UNSIGNED1 vtid_Invalid;
    UNSIGNED1 voted_year_Invalid;
    UNSIGNED1 pres_Invalid;
    UNSIGNED1 vote_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Base_History_Layout_Voters)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Base_History_Layout_Voters) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.vtid_Invalid := Base_History_Fields.InValid_vtid((SALT39.StrType)le.vtid);
    SELF.voted_year_Invalid := Base_History_Fields.InValid_voted_year((SALT39.StrType)le.voted_year);
    SELF.pres_Invalid := Base_History_Fields.InValid_pres((SALT39.StrType)le.pres,(SALT39.StrType)le.primary,(SALT39.StrType)le.special_1,(SALT39.StrType)le.other,(SALT39.StrType)le.special_2,(SALT39.StrType)le.general);
    SELF.vote_date_Invalid := Base_History_Fields.InValid_vote_date((SALT39.StrType)le.vote_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Base_History_Layout_Voters);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.vtid_Invalid << 0 ) + ( le.voted_year_Invalid << 1 ) + ( le.pres_Invalid << 2 ) + ( le.vote_date_Invalid << 3 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Base_History_Layout_Voters);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.vtid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.voted_year_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.pres_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.vote_date_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    vtid_CUSTOM_ErrorCount := COUNT(GROUP,h.vtid_Invalid=1);
    voted_year_CUSTOM_ErrorCount := COUNT(GROUP,h.voted_year_Invalid=1);
    pres_CUSTOM_ErrorCount := COUNT(GROUP,h.pres_Invalid=1);
    vote_date_CUSTOM_ErrorCount := COUNT(GROUP,h.vote_date_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.vtid_Invalid > 0 OR h.voted_year_Invalid > 0 OR h.pres_Invalid > 0 OR h.vote_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.vtid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.voted_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pres_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vote_date_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.vtid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.voted_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pres_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vote_date_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.vtid_Invalid,le.voted_year_Invalid,le.pres_Invalid,le.vote_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Base_History_Fields.InvalidMessage_vtid(le.vtid_Invalid),Base_History_Fields.InvalidMessage_voted_year(le.voted_year_Invalid),Base_History_Fields.InvalidMessage_pres(le.pres_Invalid),Base_History_Fields.InvalidMessage_vote_date(le.vote_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.vtid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.voted_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pres_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vote_date_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'vtid','voted_year','pres','vote_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_voted_year','invalid_pres','invalid_vote_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.vtid,(SALT39.StrType)le.voted_year,(SALT39.StrType)le.pres,(SALT39.StrType)le.vote_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,4,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Base_History_Layout_Voters) prevDS = DATASET([], Base_History_Layout_Voters), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'vtid:invalid_numeric:CUSTOM'
          ,'voted_year:invalid_voted_year:CUSTOM'
          ,'pres:invalid_pres:CUSTOM'
          ,'vote_date:invalid_vote_date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Base_History_Fields.InvalidMessage_vtid(1)
          ,Base_History_Fields.InvalidMessage_voted_year(1)
          ,Base_History_Fields.InvalidMessage_pres(1)
          ,Base_History_Fields.InvalidMessage_vote_date(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.vtid_CUSTOM_ErrorCount
          ,le.voted_year_CUSTOM_ErrorCount
          ,le.pres_CUSTOM_ErrorCount
          ,le.vote_date_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.vtid_CUSTOM_ErrorCount
          ,le.voted_year_CUSTOM_ErrorCount
          ,le.pres_CUSTOM_ErrorCount
          ,le.vote_date_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := Base_History_hygiene(PROJECT(h, Base_History_Layout_Voters));
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
          ,'vtid:' + getFieldTypeText(h.vtid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'voted_year:' + getFieldTypeText(h.voted_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'primary:' + getFieldTypeText(h.primary) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special_1:' + getFieldTypeText(h.special_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other:' + getFieldTypeText(h.other) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'special_2:' + getFieldTypeText(h.special_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'general:' + getFieldTypeText(h.general) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pres:' + getFieldTypeText(h.pres) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vote_date:' + getFieldTypeText(h.vote_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_vtid_cnt
          ,le.populated_voted_year_cnt
          ,le.populated_primary_cnt
          ,le.populated_special_1_cnt
          ,le.populated_other_cnt
          ,le.populated_special_2_cnt
          ,le.populated_general_cnt
          ,le.populated_pres_cnt
          ,le.populated_vote_date_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_vtid_pcnt
          ,le.populated_voted_year_pcnt
          ,le.populated_primary_pcnt
          ,le.populated_special_1_pcnt
          ,le.populated_other_pcnt
          ,le.populated_special_2_pcnt
          ,le.populated_general_pcnt
          ,le.populated_pres_pcnt
          ,le.populated_vote_date_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,9,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Base_History_Delta(prevDS, PROJECT(h, Base_History_Layout_Voters));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),9,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Base_History_Layout_Voters) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Voters, Base_History_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
