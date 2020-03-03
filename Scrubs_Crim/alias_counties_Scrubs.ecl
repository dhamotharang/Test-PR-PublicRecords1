IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT alias_counties_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 7;
  EXPORT NumRulesFromFieldType := 7;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 7;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(alias_counties_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 akaname_Invalid;
    UNSIGNED1 akalastname_Invalid;
    UNSIGNED1 akafirstname_Invalid;
    UNSIGNED1 akamiddlename_Invalid;
    UNSIGNED1 akadob_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(alias_counties_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(alias_counties_Layout_crim)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'recordid:Invalid_Record_ID:ALLOW'
          ,'statecode:Invalid_State:ALLOW'
          ,'akaname:AKA_Search:CUSTOM'
          ,'akalastname:AKA_Search:CUSTOM'
          ,'akafirstname:AKA_Search:CUSTOM'
          ,'akamiddlename:AKA_Search:CUSTOM'
          ,'akadob:Invalid_Date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,alias_counties_Fields.InvalidMessage_recordid(1)
          ,alias_counties_Fields.InvalidMessage_statecode(1)
          ,alias_counties_Fields.InvalidMessage_akaname(1)
          ,alias_counties_Fields.InvalidMessage_akalastname(1)
          ,alias_counties_Fields.InvalidMessage_akafirstname(1)
          ,alias_counties_Fields.InvalidMessage_akamiddlename(1)
          ,alias_counties_Fields.InvalidMessage_akadob(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(alias_counties_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := alias_counties_Fields.InValid_recordid((SALT311.StrType)le.recordid);
    SELF.statecode_Invalid := alias_counties_Fields.InValid_statecode((SALT311.StrType)le.statecode);
    SELF.akaname_Invalid := alias_counties_Fields.InValid_akaname((SALT311.StrType)le.akaname);
    SELF.akalastname_Invalid := alias_counties_Fields.InValid_akalastname((SALT311.StrType)le.akalastname);
    SELF.akafirstname_Invalid := alias_counties_Fields.InValid_akafirstname((SALT311.StrType)le.akafirstname);
    SELF.akamiddlename_Invalid := alias_counties_Fields.InValid_akamiddlename((SALT311.StrType)le.akamiddlename);
    SELF.akadob_Invalid := alias_counties_Fields.InValid_akadob((SALT311.StrType)le.akadob);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),alias_counties_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.akaname_Invalid << 2 ) + ( le.akalastname_Invalid << 3 ) + ( le.akafirstname_Invalid << 4 ) + ( le.akamiddlename_Invalid << 5 ) + ( le.akadob_Invalid << 6 );
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
  EXPORT Infile := PROJECT(h,alias_counties_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.akaname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.akalastname_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.akafirstname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.akamiddlename_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.akadob_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.vendor) vendor := IF(Glob, '', h.vendor);
    TotalCnt := COUNT(GROUP); // Number of records in total
    recordid_ALLOW_ErrorCount := COUNT(GROUP,h.recordid_Invalid=1);
    statecode_ALLOW_ErrorCount := COUNT(GROUP,h.statecode_Invalid=1);
    akaname_CUSTOM_ErrorCount := COUNT(GROUP,h.akaname_Invalid=1);
    akalastname_CUSTOM_ErrorCount := COUNT(GROUP,h.akalastname_Invalid=1);
    akafirstname_CUSTOM_ErrorCount := COUNT(GROUP,h.akafirstname_Invalid=1);
    akamiddlename_CUSTOM_ErrorCount := COUNT(GROUP,h.akamiddlename_Invalid=1);
    akadob_CUSTOM_ErrorCount := COUNT(GROUP,h.akadob_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.recordid_Invalid > 0 OR h.statecode_Invalid > 0 OR h.akaname_Invalid > 0 OR h.akalastname_Invalid > 0 OR h.akafirstname_Invalid > 0 OR h.akamiddlename_Invalid > 0 OR h.akadob_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,vendor,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.recordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.akaname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.akalastname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.akafirstname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.akamiddlename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.akadob_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.recordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.akaname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.akalastname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.akafirstname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.akamiddlename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.akadob_CUSTOM_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.akaname_Invalid,le.akalastname_Invalid,le.akafirstname_Invalid,le.akamiddlename_Invalid,le.akadob_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,alias_counties_Fields.InvalidMessage_recordid(le.recordid_Invalid),alias_counties_Fields.InvalidMessage_statecode(le.statecode_Invalid),alias_counties_Fields.InvalidMessage_akaname(le.akaname_Invalid),alias_counties_Fields.InvalidMessage_akalastname(le.akalastname_Invalid),alias_counties_Fields.InvalidMessage_akafirstname(le.akafirstname_Invalid),alias_counties_Fields.InvalidMessage_akamiddlename(le.akamiddlename_Invalid),alias_counties_Fields.InvalidMessage_akadob(le.akadob_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.akaname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.akalastname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.akafirstname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.akamiddlename_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.akadob_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','akaname','akalastname','akafirstname','akamiddlename','akadob','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_State','AKA_Search','AKA_Search','AKA_Search','AKA_Search','Invalid_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.recordid,(SALT311.StrType)le.statecode,(SALT311.StrType)le.akaname,(SALT311.StrType)le.akalastname,(SALT311.StrType)le.akafirstname,(SALT311.StrType)le.akamiddlename,(SALT311.StrType)le.akadob,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(alias_counties_Layout_crim) prevDS = DATASET([], alias_counties_Layout_crim)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.akaname_CUSTOM_ErrorCount
          ,le.akalastname_CUSTOM_ErrorCount
          ,le.akafirstname_CUSTOM_ErrorCount
          ,le.akamiddlename_CUSTOM_ErrorCount
          ,le.akadob_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.akaname_CUSTOM_ErrorCount
          ,le.akalastname_CUSTOM_ErrorCount
          ,le.akafirstname_CUSTOM_ErrorCount
          ,le.akamiddlename_CUSTOM_ErrorCount
          ,le.akadob_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := alias_counties_hygiene(PROJECT(h, alias_counties_Layout_crim));
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
          ,'recordid:' + getFieldTypeText(h.recordid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statecode:' + getFieldTypeText(h.statecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'akaname:' + getFieldTypeText(h.akaname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'akalastname:' + getFieldTypeText(h.akalastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'akafirstname:' + getFieldTypeText(h.akafirstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'akamiddlename:' + getFieldTypeText(h.akamiddlename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'akasuffix:' + getFieldTypeText(h.akasuffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'akadob:' + getFieldTypeText(h.akadob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sourcename:' + getFieldTypeText(h.sourcename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_recordid_cnt
          ,le.populated_statecode_cnt
          ,le.populated_akaname_cnt
          ,le.populated_akalastname_cnt
          ,le.populated_akafirstname_cnt
          ,le.populated_akamiddlename_cnt
          ,le.populated_akasuffix_cnt
          ,le.populated_akadob_cnt
          ,le.populated_sourcename_cnt
          ,le.populated_vendor_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_recordid_pcnt
          ,le.populated_statecode_pcnt
          ,le.populated_akaname_pcnt
          ,le.populated_akalastname_pcnt
          ,le.populated_akafirstname_pcnt
          ,le.populated_akamiddlename_pcnt
          ,le.populated_akasuffix_pcnt
          ,le.populated_akadob_pcnt
          ,le.populated_sourcename_pcnt
          ,le.populated_vendor_pcnt,0);
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
 
    mod_Delta := alias_counties_Delta(prevDS, PROJECT(h, alias_counties_Layout_crim));
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
 
EXPORT StandardStats(DATASET(alias_counties_Layout_crim) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Crim, alias_counties_Fields, 'RECORDOF(scrubsSummaryOverall)', 'vendor');
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
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, vendor, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
