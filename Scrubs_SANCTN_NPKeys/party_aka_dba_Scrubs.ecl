IMPORT SALT311,STD;
EXPORT party_aka_dba_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 7;
  EXPORT NumRulesFromFieldType := 7;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 6;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(party_aka_dba_Layout_SANCTN_NPKeys)
    UNSIGNED1 batch_Invalid;
    UNSIGNED1 dbcode_Invalid;
    UNSIGNED1 incident_num_Invalid;
    UNSIGNED1 party_num_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 party_key_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(party_aka_dba_Layout_SANCTN_NPKeys)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(party_aka_dba_Layout_SANCTN_NPKeys)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'batch:Invalid_Batch:ALLOW','batch:Invalid_Batch:LENGTHS'
          ,'dbcode:Invalid_DBCode:ENUM'
          ,'incident_num:Invalid_Num:ALLOW'
          ,'party_num:Invalid_Num:ALLOW'
          ,'name_type:Invalid_NameType:ENUM'
          ,'party_key:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,party_aka_dba_Fields.InvalidMessage_batch(1),party_aka_dba_Fields.InvalidMessage_batch(2)
          ,party_aka_dba_Fields.InvalidMessage_dbcode(1)
          ,party_aka_dba_Fields.InvalidMessage_incident_num(1)
          ,party_aka_dba_Fields.InvalidMessage_party_num(1)
          ,party_aka_dba_Fields.InvalidMessage_name_type(1)
          ,party_aka_dba_Fields.InvalidMessage_party_key(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(party_aka_dba_Layout_SANCTN_NPKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_Invalid := party_aka_dba_Fields.InValid_batch((SALT311.StrType)le.batch);
    SELF.dbcode_Invalid := party_aka_dba_Fields.InValid_dbcode((SALT311.StrType)le.dbcode);
    SELF.incident_num_Invalid := party_aka_dba_Fields.InValid_incident_num((SALT311.StrType)le.incident_num);
    SELF.party_num_Invalid := party_aka_dba_Fields.InValid_party_num((SALT311.StrType)le.party_num);
    SELF.name_type_Invalid := party_aka_dba_Fields.InValid_name_type((SALT311.StrType)le.name_type);
    SELF.party_key_Invalid := party_aka_dba_Fields.InValid_party_key((SALT311.StrType)le.party_key);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),party_aka_dba_Layout_SANCTN_NPKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_Invalid << 0 ) + ( le.dbcode_Invalid << 2 ) + ( le.incident_num_Invalid << 3 ) + ( le.party_num_Invalid << 4 ) + ( le.name_type_Invalid << 5 ) + ( le.party_key_Invalid << 6 );
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
  EXPORT Infile := PROJECT(h,party_aka_dba_Layout_SANCTN_NPKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.dbcode_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.incident_num_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.party_num_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.name_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.party_key_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.dbcode) dbcode := IF(Glob, '', h.dbcode);
    TotalCnt := COUNT(GROUP); // Number of records in total
    batch_ALLOW_ErrorCount := COUNT(GROUP,h.batch_Invalid=1);
    batch_LENGTHS_ErrorCount := COUNT(GROUP,h.batch_Invalid=2);
    batch_Total_ErrorCount := COUNT(GROUP,h.batch_Invalid>0);
    dbcode_ENUM_ErrorCount := COUNT(GROUP,h.dbcode_Invalid=1);
    incident_num_ALLOW_ErrorCount := COUNT(GROUP,h.incident_num_Invalid=1);
    party_num_ALLOW_ErrorCount := COUNT(GROUP,h.party_num_Invalid=1);
    name_type_ENUM_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    party_key_ALLOW_ErrorCount := COUNT(GROUP,h.party_key_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.batch_Invalid > 0 OR h.dbcode_Invalid > 0 OR h.incident_num_Invalid > 0 OR h.party_num_Invalid > 0 OR h.name_type_Invalid > 0 OR h.party_key_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,dbcode,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.batch_Total_ErrorCount > 0, 1, 0) + IF(le.dbcode_ENUM_ErrorCount > 0, 1, 0) + IF(le.incident_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.party_key_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.batch_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dbcode_ENUM_ErrorCount > 0, 1, 0) + IF(le.incident_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.party_key_ALLOW_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  le.dbcode;
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_Invalid,le.dbcode_Invalid,le.incident_num_Invalid,le.party_num_Invalid,le.name_type_Invalid,le.party_key_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,party_aka_dba_Fields.InvalidMessage_batch(le.batch_Invalid),party_aka_dba_Fields.InvalidMessage_dbcode(le.dbcode_Invalid),party_aka_dba_Fields.InvalidMessage_incident_num(le.incident_num_Invalid),party_aka_dba_Fields.InvalidMessage_party_num(le.party_num_Invalid),party_aka_dba_Fields.InvalidMessage_name_type(le.name_type_Invalid),party_aka_dba_Fields.InvalidMessage_party_key(le.party_key_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dbcode_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.incident_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.party_key_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch','dbcode','incident_num','party_num','name_type','party_key','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_DBCode','Invalid_Num','Invalid_Num','Invalid_NameType','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.batch,(SALT311.StrType)le.dbcode,(SALT311.StrType)le.incident_num,(SALT311.StrType)le.party_num,(SALT311.StrType)le.name_type,(SALT311.StrType)le.party_key,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,6,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(party_aka_dba_Layout_SANCTN_NPKeys) prevDS = DATASET([], party_aka_dba_Layout_SANCTN_NPKeys)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.dbcode;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTHS_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.party_num_ALLOW_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.party_key_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.batch_ALLOW_ErrorCount,le.batch_LENGTHS_ErrorCount
          ,le.dbcode_ENUM_ErrorCount
          ,le.incident_num_ALLOW_ErrorCount
          ,le.party_num_ALLOW_ErrorCount
          ,le.name_type_ENUM_ErrorCount
          ,le.party_key_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := party_aka_dba_hygiene(PROJECT(h, party_aka_dba_Layout_SANCTN_NPKeys));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'batch:' + getFieldTypeText(h.batch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dbcode:' + getFieldTypeText(h.dbcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incident_num:' + getFieldTypeText(h.incident_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_num:' + getFieldTypeText(h.party_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_type:' + getFieldTypeText(h.name_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_name:' + getFieldTypeText(h.middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aka_dba_text:' + getFieldTypeText(h.aka_dba_text) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_key:' + getFieldTypeText(h.party_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_batch_cnt
          ,le.populated_dbcode_cnt
          ,le.populated_incident_num_cnt
          ,le.populated_party_num_cnt
          ,le.populated_name_type_cnt
          ,le.populated_first_name_cnt
          ,le.populated_middle_name_cnt
          ,le.populated_last_name_cnt
          ,le.populated_aka_dba_text_cnt
          ,le.populated_party_key_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_batch_pcnt
          ,le.populated_dbcode_pcnt
          ,le.populated_incident_num_pcnt
          ,le.populated_party_num_pcnt
          ,le.populated_name_type_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_middle_name_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_aka_dba_text_pcnt
          ,le.populated_party_key_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,10,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := party_aka_dba_Delta(prevDS, PROJECT(h, party_aka_dba_Layout_SANCTN_NPKeys));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),10,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(party_aka_dba_Layout_SANCTN_NPKeys) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_SANCTN_NPKeys, party_aka_dba_Fields, 'RECORDOF(scrubsSummaryOverall)', 'dbcode');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, dbcode, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
