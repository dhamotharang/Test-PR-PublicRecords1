IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_TelcordiaTDS)
    UNSIGNED1 npa_Invalid;
    UNSIGNED1 nxx_Invalid;
    UNSIGNED1 tb_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 timezone_Invalid;
    UNSIGNED1 coctype_Invalid;
    UNSIGNED1 ssc_Invalid;
    UNSIGNED1 wireless_ind_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_TelcordiaTDS)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_TelcordiaTDS) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.npa_Invalid := Fields.InValid_npa((SALT311.StrType)le.npa);
    SELF.nxx_Invalid := Fields.InValid_nxx((SALT311.StrType)le.nxx);
    SELF.tb_Invalid := Fields.InValid_tb((SALT311.StrType)le.tb);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.timezone_Invalid := Fields.InValid_timezone((SALT311.StrType)le.timezone);
    SELF.coctype_Invalid := Fields.InValid_coctype((SALT311.StrType)le.coctype);
    SELF.ssc_Invalid := Fields.InValid_ssc((SALT311.StrType)le.ssc);
    SELF.wireless_ind_Invalid := Fields.InValid_wireless_ind((SALT311.StrType)le.wireless_ind);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_TelcordiaTDS);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.npa_Invalid << 0 ) + ( le.nxx_Invalid << 1 ) + ( le.tb_Invalid << 2 ) + ( le.state_Invalid << 3 ) + ( le.timezone_Invalid << 4 ) + ( le.coctype_Invalid << 5 ) + ( le.ssc_Invalid << 6 ) + ( le.wireless_ind_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_TelcordiaTDS);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.npa_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.nxx_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.tb_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.timezone_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.coctype_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.ssc_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.wireless_ind_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    npa_ALLOW_ErrorCount := COUNT(GROUP,h.npa_Invalid=1);
    nxx_ALLOW_ErrorCount := COUNT(GROUP,h.nxx_Invalid=1);
    tb_ALLOW_ErrorCount := COUNT(GROUP,h.tb_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    timezone_ALLOW_ErrorCount := COUNT(GROUP,h.timezone_Invalid=1);
    coctype_ENUM_ErrorCount := COUNT(GROUP,h.coctype_Invalid=1);
    ssc_ALLOW_ErrorCount := COUNT(GROUP,h.ssc_Invalid=1);
    wireless_ind_ENUM_ErrorCount := COUNT(GROUP,h.wireless_ind_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.npa_Invalid > 0 OR h.nxx_Invalid > 0 OR h.tb_Invalid > 0 OR h.state_Invalid > 0 OR h.timezone_Invalid > 0 OR h.coctype_Invalid > 0 OR h.ssc_Invalid > 0 OR h.wireless_ind_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.npa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nxx_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tb_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.timezone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coctype_ENUM_ErrorCount > 0, 1, 0) + IF(le.ssc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.wireless_ind_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.npa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nxx_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tb_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.timezone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.coctype_ENUM_ErrorCount > 0, 1, 0) + IF(le.ssc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.wireless_ind_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.npa_Invalid,le.nxx_Invalid,le.tb_Invalid,le.state_Invalid,le.timezone_Invalid,le.coctype_Invalid,le.ssc_Invalid,le.wireless_ind_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_npa(le.npa_Invalid),Fields.InvalidMessage_nxx(le.nxx_Invalid),Fields.InvalidMessage_tb(le.tb_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_timezone(le.timezone_Invalid),Fields.InvalidMessage_coctype(le.coctype_Invalid),Fields.InvalidMessage_ssc(le.ssc_Invalid),Fields.InvalidMessage_wireless_ind(le.wireless_ind_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.npa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nxx_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tb_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.timezone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.coctype_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.ssc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.wireless_ind_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'npa','nxx','tb','state','timezone','coctype','ssc','wireless_ind','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Letter','Invalid_Num','Invalid_Coctype','Invalid_Char','Invalid_Wireless','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.npa,(SALT311.StrType)le.nxx,(SALT311.StrType)le.tb,(SALT311.StrType)le.state,(SALT311.StrType)le.timezone,(SALT311.StrType)le.coctype,(SALT311.StrType)le.ssc,(SALT311.StrType)le.wireless_ind,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_TelcordiaTDS) prevDS = DATASET([], Layout_TelcordiaTDS), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'npa:Invalid_Num:ALLOW'
          ,'nxx:Invalid_Num:ALLOW'
          ,'tb:Invalid_Num:ALLOW'
          ,'state:Invalid_Letter:ALLOW'
          ,'timezone:Invalid_Num:ALLOW'
          ,'coctype:Invalid_Coctype:ENUM'
          ,'ssc:Invalid_Char:ALLOW'
          ,'wireless_ind:Invalid_Wireless:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_npa(1)
          ,Fields.InvalidMessage_nxx(1)
          ,Fields.InvalidMessage_tb(1)
          ,Fields.InvalidMessage_state(1)
          ,Fields.InvalidMessage_timezone(1)
          ,Fields.InvalidMessage_coctype(1)
          ,Fields.InvalidMessage_ssc(1)
          ,Fields.InvalidMessage_wireless_ind(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.npa_ALLOW_ErrorCount
          ,le.nxx_ALLOW_ErrorCount
          ,le.tb_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.timezone_ALLOW_ErrorCount
          ,le.coctype_ENUM_ErrorCount
          ,le.ssc_ALLOW_ErrorCount
          ,le.wireless_ind_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.npa_ALLOW_ErrorCount
          ,le.nxx_ALLOW_ErrorCount
          ,le.tb_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.timezone_ALLOW_ErrorCount
          ,le.coctype_ENUM_ErrorCount
          ,le.ssc_ALLOW_ErrorCount
          ,le.wireless_ind_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_TelcordiaTDS));
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
          ,'npa:' + getFieldTypeText(h.npa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nxx:' + getFieldTypeText(h.nxx) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'tb:' + getFieldTypeText(h.tb) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timezone:' + getFieldTypeText(h.timezone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'coctype:' + getFieldTypeText(h.coctype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssc:' + getFieldTypeText(h.ssc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'wireless_ind:' + getFieldTypeText(h.wireless_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_npa_cnt
          ,le.populated_nxx_cnt
          ,le.populated_tb_cnt
          ,le.populated_state_cnt
          ,le.populated_timezone_cnt
          ,le.populated_coctype_cnt
          ,le.populated_ssc_cnt
          ,le.populated_wireless_ind_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_npa_pcnt
          ,le.populated_nxx_pcnt
          ,le.populated_tb_pcnt
          ,le.populated_state_pcnt
          ,le.populated_timezone_pcnt
          ,le.populated_coctype_pcnt
          ,le.populated_ssc_pcnt
          ,le.populated_wireless_ind_pcnt,0);
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_TelcordiaTDS));
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
 
EXPORT StandardStats(DATASET(Layout_TelcordiaTDS) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_TelcordiaTDS, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
