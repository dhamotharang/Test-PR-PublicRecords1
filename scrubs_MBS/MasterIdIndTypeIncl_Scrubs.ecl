IMPORT SALT39,STD;
EXPORT MasterIdIndTypeIncl_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl)
    UNSIGNED1 fdn_ind_type_gc_id_inclusion_Invalid;
    UNSIGNED1 fdn_file_info_id_Invalid;
    UNSIGNED1 ind_type_Invalid;
    UNSIGNED1 inclusion_id_Invalid;
    UNSIGNED1 inclusion_type_Invalid;
    UNSIGNED1 status_Invalid;
    UNSIGNED1 date_added_Invalid;
    UNSIGNED1 user_added_Invalid;
    UNSIGNED1 date_changed_Invalid;
    UNSIGNED1 user_changed_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.fdn_ind_type_gc_id_inclusion_Invalid := MasterIdIndTypeIncl_Fields.InValid_fdn_ind_type_gc_id_inclusion((SALT39.StrType)le.fdn_ind_type_gc_id_inclusion);
    SELF.fdn_file_info_id_Invalid := MasterIdIndTypeIncl_Fields.InValid_fdn_file_info_id((SALT39.StrType)le.fdn_file_info_id);
    SELF.ind_type_Invalid := MasterIdIndTypeIncl_Fields.InValid_ind_type((SALT39.StrType)le.ind_type);
    SELF.inclusion_id_Invalid := MasterIdIndTypeIncl_Fields.InValid_inclusion_id((SALT39.StrType)le.inclusion_id);
    SELF.inclusion_type_Invalid := MasterIdIndTypeIncl_Fields.InValid_inclusion_type((SALT39.StrType)le.inclusion_type);
    SELF.status_Invalid := MasterIdIndTypeIncl_Fields.InValid_status((SALT39.StrType)le.status);
    SELF.date_added_Invalid := MasterIdIndTypeIncl_Fields.InValid_date_added((SALT39.StrType)le.date_added);
    SELF.user_added_Invalid := MasterIdIndTypeIncl_Fields.InValid_user_added((SALT39.StrType)le.user_added);
    SELF.date_changed_Invalid := MasterIdIndTypeIncl_Fields.InValid_date_changed((SALT39.StrType)le.date_changed);
    SELF.user_changed_Invalid := MasterIdIndTypeIncl_Fields.InValid_user_changed((SALT39.StrType)le.user_changed);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.fdn_ind_type_gc_id_inclusion_Invalid << 0 ) + ( le.fdn_file_info_id_Invalid << 1 ) + ( le.ind_type_Invalid << 2 ) + ( le.inclusion_id_Invalid << 3 ) + ( le.inclusion_type_Invalid << 4 ) + ( le.status_Invalid << 5 ) + ( le.date_added_Invalid << 6 ) + ( le.user_added_Invalid << 7 ) + ( le.date_changed_Invalid << 8 ) + ( le.user_changed_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.fdn_ind_type_gc_id_inclusion_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.fdn_file_info_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.ind_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.inclusion_id_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.inclusion_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.status_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.user_added_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.date_changed_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.user_changed_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    fdn_ind_type_gc_id_inclusion_ALLOW_ErrorCount := COUNT(GROUP,h.fdn_ind_type_gc_id_inclusion_Invalid=1);
    fdn_file_info_id_ALLOW_ErrorCount := COUNT(GROUP,h.fdn_file_info_id_Invalid=1);
    ind_type_ALLOW_ErrorCount := COUNT(GROUP,h.ind_type_Invalid=1);
    inclusion_id_ALLOW_ErrorCount := COUNT(GROUP,h.inclusion_id_Invalid=1);
    inclusion_type_ALLOW_ErrorCount := COUNT(GROUP,h.inclusion_type_Invalid=1);
    status_ALLOW_ErrorCount := COUNT(GROUP,h.status_Invalid=1);
    date_added_ALLOW_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
    user_added_ALLOW_ErrorCount := COUNT(GROUP,h.user_added_Invalid=1);
    date_changed_ALLOW_ErrorCount := COUNT(GROUP,h.date_changed_Invalid=1);
    user_changed_ALLOW_ErrorCount := COUNT(GROUP,h.user_changed_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.fdn_ind_type_gc_id_inclusion_Invalid > 0 OR h.fdn_file_info_id_Invalid > 0 OR h.ind_type_Invalid > 0 OR h.inclusion_id_Invalid > 0 OR h.inclusion_type_Invalid > 0 OR h.status_Invalid > 0 OR h.date_added_Invalid > 0 OR h.user_added_Invalid > 0 OR h.date_changed_Invalid > 0 OR h.user_changed_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.fdn_ind_type_gc_id_inclusion_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fdn_file_info_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ind_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inclusion_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inclusion_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_ALLOW_ErrorCount > 0, 1, 0) + IF(le.user_added_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_changed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.user_changed_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.fdn_ind_type_gc_id_inclusion_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fdn_file_info_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ind_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inclusion_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inclusion_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.status_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_ALLOW_ErrorCount > 0, 1, 0) + IF(le.user_added_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_changed_ALLOW_ErrorCount > 0, 1, 0) + IF(le.user_changed_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.fdn_ind_type_gc_id_inclusion_Invalid,le.fdn_file_info_id_Invalid,le.ind_type_Invalid,le.inclusion_id_Invalid,le.inclusion_type_Invalid,le.status_Invalid,le.date_added_Invalid,le.user_added_Invalid,le.date_changed_Invalid,le.user_changed_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,MasterIdIndTypeIncl_Fields.InvalidMessage_fdn_ind_type_gc_id_inclusion(le.fdn_ind_type_gc_id_inclusion_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_fdn_file_info_id(le.fdn_file_info_id_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_ind_type(le.ind_type_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_inclusion_id(le.inclusion_id_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_inclusion_type(le.inclusion_type_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_status(le.status_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_date_added(le.date_added_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_user_added(le.user_added_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_date_changed(le.date_changed_Invalid),MasterIdIndTypeIncl_Fields.InvalidMessage_user_changed(le.user_changed_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.fdn_ind_type_gc_id_inclusion_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fdn_file_info_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ind_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inclusion_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inclusion_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.user_added_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_changed_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.user_changed_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'fdn_ind_type_gc_id_inclusion','fdn_file_info_id','ind_type','inclusion_id','inclusion_type','status','date_added','user_added','date_changed','user_changed','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.fdn_ind_type_gc_id_inclusion,(SALT39.StrType)le.fdn_file_info_id,(SALT39.StrType)le.ind_type,(SALT39.StrType)le.inclusion_id,(SALT39.StrType)le.inclusion_type,(SALT39.StrType)le.status,(SALT39.StrType)le.date_added,(SALT39.StrType)le.user_added,(SALT39.StrType)le.date_changed,(SALT39.StrType)le.user_changed,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl) prevDS = DATASET([], MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'fdn_ind_type_gc_id_inclusion:invalid_numeric:ALLOW'
          ,'fdn_file_info_id:invalid_numeric:ALLOW'
          ,'ind_type:invalid_numeric:ALLOW'
          ,'inclusion_id:invalid_numeric:ALLOW'
          ,'inclusion_type:invalid_alphanumeric:ALLOW'
          ,'status:invalid_numeric:ALLOW'
          ,'date_added:invalid_alphanumeric:ALLOW'
          ,'user_added:invalid_alphanumeric:ALLOW'
          ,'date_changed:invalid_alphanumeric:ALLOW'
          ,'user_changed:invalid_alphanumeric:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_fdn_ind_type_gc_id_inclusion(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_fdn_file_info_id(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_ind_type(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_inclusion_id(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_inclusion_type(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_status(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_date_added(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_user_added(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_date_changed(1)
          ,MasterIdIndTypeIncl_Fields.InvalidMessage_user_changed(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.fdn_ind_type_gc_id_inclusion_ALLOW_ErrorCount
          ,le.fdn_file_info_id_ALLOW_ErrorCount
          ,le.ind_type_ALLOW_ErrorCount
          ,le.inclusion_id_ALLOW_ErrorCount
          ,le.inclusion_type_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount
          ,le.user_added_ALLOW_ErrorCount
          ,le.date_changed_ALLOW_ErrorCount
          ,le.user_changed_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.fdn_ind_type_gc_id_inclusion_ALLOW_ErrorCount
          ,le.fdn_file_info_id_ALLOW_ErrorCount
          ,le.ind_type_ALLOW_ErrorCount
          ,le.inclusion_id_ALLOW_ErrorCount
          ,le.inclusion_type_ALLOW_ErrorCount
          ,le.status_ALLOW_ErrorCount
          ,le.date_added_ALLOW_ErrorCount
          ,le.user_added_ALLOW_ErrorCount
          ,le.date_changed_ALLOW_ErrorCount
          ,le.user_changed_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := MasterIdIndTypeIncl_hygiene(PROJECT(h, MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl));
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
          ,'fdn_ind_type_gc_id_inclusion:' + getFieldTypeText(h.fdn_ind_type_gc_id_inclusion) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fdn_file_info_id:' + getFieldTypeText(h.fdn_file_info_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ind_type:' + getFieldTypeText(h.ind_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inclusion_id:' + getFieldTypeText(h.inclusion_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inclusion_type:' + getFieldTypeText(h.inclusion_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'status:' + getFieldTypeText(h.status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'user_added:' + getFieldTypeText(h.user_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_changed:' + getFieldTypeText(h.date_changed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'user_changed:' + getFieldTypeText(h.user_changed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_fdn_ind_type_gc_id_inclusion_cnt
          ,le.populated_fdn_file_info_id_cnt
          ,le.populated_ind_type_cnt
          ,le.populated_inclusion_id_cnt
          ,le.populated_inclusion_type_cnt
          ,le.populated_status_cnt
          ,le.populated_date_added_cnt
          ,le.populated_user_added_cnt
          ,le.populated_date_changed_cnt
          ,le.populated_user_changed_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_fdn_ind_type_gc_id_inclusion_pcnt
          ,le.populated_fdn_file_info_id_pcnt
          ,le.populated_ind_type_pcnt
          ,le.populated_inclusion_id_pcnt
          ,le.populated_inclusion_type_pcnt
          ,le.populated_status_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_user_added_pcnt
          ,le.populated_date_changed_pcnt
          ,le.populated_user_changed_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,10,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := MasterIdIndTypeIncl_Delta(prevDS, PROJECT(h, MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl));
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
 
EXPORT StandardStats(DATASET(MasterIdIndTypeIncl_Layout_MasterIdIndTypeIncl) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_MBS, MasterIdIndTypeIncl_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
