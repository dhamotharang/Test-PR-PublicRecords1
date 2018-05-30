IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_TelcordiaTPM)
    UNSIGNED1 npa_Invalid;
    UNSIGNED1 nxx_Invalid;
    UNSIGNED1 tb_Invalid;
    UNSIGNED1 company_type_Invalid;
    UNSIGNED1 nxx_type_Invalid;
    UNSIGNED1 dial_ind_Invalid;
    UNSIGNED1 point_id_Invalid;
    UNSIGNED1 zip_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_TelcordiaTPM)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_TelcordiaTPM) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.npa_Invalid := Fields.InValid_npa((SALT311.StrType)le.npa);
    SELF.nxx_Invalid := Fields.InValid_nxx((SALT311.StrType)le.nxx);
    SELF.tb_Invalid := Fields.InValid_tb((SALT311.StrType)le.tb);
    SELF.company_type_Invalid := Fields.InValid_company_type((SALT311.StrType)le.company_type);
    SELF.nxx_type_Invalid := Fields.InValid_nxx_type((SALT311.StrType)le.nxx_type);
    SELF.dial_ind_Invalid := Fields.InValid_dial_ind((SALT311.StrType)le.dial_ind);
    SELF.point_id_Invalid := Fields.InValid_point_id((SALT311.StrType)le.point_id);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_TelcordiaTPM);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.npa_Invalid << 0 ) + ( le.nxx_Invalid << 1 ) + ( le.tb_Invalid << 2 ) + ( le.company_type_Invalid << 3 ) + ( le.nxx_type_Invalid << 4 ) + ( le.dial_ind_Invalid << 5 ) + ( le.point_id_Invalid << 6 ) + ( le.zip_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_TelcordiaTPM);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.npa_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.nxx_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.tb_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.company_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.nxx_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dial_ind_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.point_id_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 7) & 1;
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
    company_type_ENUM_ErrorCount := COUNT(GROUP,h.company_type_Invalid=1);
    nxx_type_ALLOW_ErrorCount := COUNT(GROUP,h.nxx_type_Invalid=1);
    dial_ind_ENUM_ErrorCount := COUNT(GROUP,h.dial_ind_Invalid=1);
    point_id_ENUM_ErrorCount := COUNT(GROUP,h.point_id_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.npa_Invalid > 0 OR h.nxx_Invalid > 0 OR h.tb_Invalid > 0 OR h.company_type_Invalid > 0 OR h.nxx_type_Invalid > 0 OR h.dial_ind_Invalid > 0 OR h.point_id_Invalid > 0 OR h.zip_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.npa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nxx_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tb_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.nxx_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dial_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.point_id_ENUM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.npa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.nxx_ALLOW_ErrorCount > 0, 1, 0) + IF(le.tb_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.nxx_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dial_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.point_id_ENUM_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.npa_Invalid,le.nxx_Invalid,le.tb_Invalid,le.company_type_Invalid,le.nxx_type_Invalid,le.dial_ind_Invalid,le.point_id_Invalid,le.zip_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_npa(le.npa_Invalid),Fields.InvalidMessage_nxx(le.nxx_Invalid),Fields.InvalidMessage_tb(le.tb_Invalid),Fields.InvalidMessage_company_type(le.company_type_Invalid),Fields.InvalidMessage_nxx_type(le.nxx_type_Invalid),Fields.InvalidMessage_dial_ind(le.dial_ind_Invalid),Fields.InvalidMessage_point_id(le.point_id_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.npa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.nxx_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.tb_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.nxx_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dial_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.point_id_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'npa','nxx','tb','company_type','nxx_type','dial_ind','point_id','zip','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_TB','Invalid_CompanyType','Invalid_Num','Invalid_dialind','Invalid_PointID','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.npa,(SALT311.StrType)le.nxx,(SALT311.StrType)le.tb,(SALT311.StrType)le.company_type,(SALT311.StrType)le.nxx_type,(SALT311.StrType)le.dial_ind,(SALT311.StrType)le.point_id,(SALT311.StrType)le.zip,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_TelcordiaTPM) prevDS = DATASET([], Layout_TelcordiaTPM), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'npa:Invalid_Num:ALLOW'
          ,'nxx:Invalid_Num:ALLOW'
          ,'tb:Invalid_TB:ALLOW'
          ,'company_type:Invalid_CompanyType:ENUM'
          ,'nxx_type:Invalid_Num:ALLOW'
          ,'dial_ind:Invalid_dialind:ENUM'
          ,'point_id:Invalid_PointID:ENUM'
          ,'zip:Invalid_Num:ALLOW'
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
          ,Fields.InvalidMessage_company_type(1)
          ,Fields.InvalidMessage_nxx_type(1)
          ,Fields.InvalidMessage_dial_ind(1)
          ,Fields.InvalidMessage_point_id(1)
          ,Fields.InvalidMessage_zip(1)
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
          ,le.company_type_ENUM_ErrorCount
          ,le.nxx_type_ALLOW_ErrorCount
          ,le.dial_ind_ENUM_ErrorCount
          ,le.point_id_ENUM_ErrorCount
          ,le.zip_ALLOW_ErrorCount
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
          ,le.company_type_ENUM_ErrorCount
          ,le.nxx_type_ALLOW_ErrorCount
          ,le.dial_ind_ENUM_ErrorCount
          ,le.point_id_ENUM_ErrorCount
          ,le.zip_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_TelcordiaTPM));
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
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn:' + getFieldTypeText(h.ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_type:' + getFieldTypeText(h.company_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nxx_type:' + getFieldTypeText(h.nxx_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dial_ind:' + getFieldTypeText(h.dial_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'point_id:' + getFieldTypeText(h.point_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lf:' + getFieldTypeText(h.lf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_npa_cnt
          ,le.populated_nxx_cnt
          ,le.populated_tb_cnt
          ,le.populated_city_cnt
          ,le.populated_st_cnt
          ,le.populated_ocn_cnt
          ,le.populated_company_type_cnt
          ,le.populated_nxx_type_cnt
          ,le.populated_dial_ind_cnt
          ,le.populated_point_id_cnt
          ,le.populated_lf_cnt
          ,le.populated_zip_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_npa_pcnt
          ,le.populated_nxx_pcnt
          ,le.populated_tb_pcnt
          ,le.populated_city_pcnt
          ,le.populated_st_pcnt
          ,le.populated_ocn_pcnt
          ,le.populated_company_type_pcnt
          ,le.populated_nxx_type_pcnt
          ,le.populated_dial_ind_pcnt
          ,le.populated_point_id_pcnt
          ,le.populated_lf_pcnt
          ,le.populated_zip_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,12,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_TelcordiaTPM));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),12,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_TelcordiaTPM) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_TelcordiaTPM, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
