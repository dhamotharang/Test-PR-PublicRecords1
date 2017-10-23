IMPORT SALT38,STD;
EXPORT New_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 6;
  EXPORT NumRulesFromFieldType := 6;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 6;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(New_Layout_Suppress)
    UNSIGNED1 product_Invalid;
    UNSIGNED1 linking_type_Invalid;
    UNSIGNED1 linking_id_Invalid;
    UNSIGNED1 document_type_Invalid;
    UNSIGNED1 document_id_Invalid;
    UNSIGNED1 compliance_id_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(New_Layout_Suppress)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(New_Layout_Suppress) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.product_Invalid := New_Fields.InValid_product((SALT38.StrType)le.product);
    SELF.linking_type_Invalid := New_Fields.InValid_linking_type((SALT38.StrType)le.linking_type);
    SELF.linking_id_Invalid := New_Fields.InValid_linking_id((SALT38.StrType)le.linking_id);
    SELF.document_type_Invalid := New_Fields.InValid_document_type((SALT38.StrType)le.document_type);
    SELF.document_id_Invalid := New_Fields.InValid_document_id((SALT38.StrType)le.document_id);
    SELF.compliance_id_Invalid := New_Fields.InValid_compliance_id((SALT38.StrType)le.compliance_id);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),New_Layout_Suppress);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.product_Invalid << 0 ) + ( le.linking_type_Invalid << 1 ) + ( le.linking_id_Invalid << 2 ) + ( le.document_type_Invalid << 3 ) + ( le.document_id_Invalid << 4 ) + ( le.compliance_id_Invalid << 5 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,New_Layout_Suppress);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.product_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.linking_type_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.linking_id_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.document_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.document_id_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.compliance_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    product_ENUM_ErrorCount := COUNT(GROUP,h.product_Invalid=1);
    linking_type_ENUM_ErrorCount := COUNT(GROUP,h.linking_type_Invalid=1);
    linking_id_ALLOW_ErrorCount := COUNT(GROUP,h.linking_id_Invalid=1);
    document_type_ENUM_ErrorCount := COUNT(GROUP,h.document_type_Invalid=1);
    document_id_ALLOW_ErrorCount := COUNT(GROUP,h.document_id_Invalid=1);
    compliance_id_ALLOW_ErrorCount := COUNT(GROUP,h.compliance_id_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.product_Invalid > 0 OR h.linking_type_Invalid > 0 OR h.linking_id_Invalid > 0 OR h.document_type_Invalid > 0 OR h.document_id_Invalid > 0 OR h.compliance_id_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.product_ENUM_ErrorCount > 0, 1, 0) + IF(le.linking_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.linking_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.document_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.document_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.compliance_id_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.product_ENUM_ErrorCount > 0, 1, 0) + IF(le.linking_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.linking_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.document_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.document_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.compliance_id_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT38.StrType ErrorMessage;
    SALT38.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.product_Invalid,le.linking_type_Invalid,le.linking_id_Invalid,le.document_type_Invalid,le.document_id_Invalid,le.compliance_id_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,New_Fields.InvalidMessage_product(le.product_Invalid),New_Fields.InvalidMessage_linking_type(le.linking_type_Invalid),New_Fields.InvalidMessage_linking_id(le.linking_id_Invalid),New_Fields.InvalidMessage_document_type(le.document_type_Invalid),New_Fields.InvalidMessage_document_id(le.document_id_Invalid),New_Fields.InvalidMessage_compliance_id(le.compliance_id_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.product_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.linking_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.linking_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.document_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.document_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.compliance_id_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'product','linking_type','linking_id','document_type','document_id','compliance_id','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_product','invalid_linking_type','invalid_num','invalid_document_type','invlid_document_id','invalid_num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.product,(SALT38.StrType)le.linking_type,(SALT38.StrType)le.linking_id,(SALT38.StrType)le.document_type,(SALT38.StrType)le.document_id,(SALT38.StrType)le.compliance_id,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,6,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(New_Layout_Suppress) prevDS = DATASET([], New_Layout_Suppress), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'product:invalid_product:ENUM'
          ,'linking_type:invalid_linking_type:ENUM'
          ,'linking_id:invalid_num:ALLOW'
          ,'document_type:invalid_document_type:ENUM'
          ,'document_id:invlid_document_id:ALLOW'
          ,'compliance_id:invalid_num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,New_Fields.InvalidMessage_product(1)
          ,New_Fields.InvalidMessage_linking_type(1)
          ,New_Fields.InvalidMessage_linking_id(1)
          ,New_Fields.InvalidMessage_document_type(1)
          ,New_Fields.InvalidMessage_document_id(1)
          ,New_Fields.InvalidMessage_compliance_id(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.product_ENUM_ErrorCount
          ,le.linking_type_ENUM_ErrorCount
          ,le.linking_id_ALLOW_ErrorCount
          ,le.document_type_ENUM_ErrorCount
          ,le.document_id_ALLOW_ErrorCount
          ,le.compliance_id_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.product_ENUM_ErrorCount
          ,le.linking_type_ENUM_ErrorCount
          ,le.linking_id_ALLOW_ErrorCount
          ,le.document_type_ENUM_ErrorCount
          ,le.document_id_ALLOW_ErrorCount
          ,le.compliance_id_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT38.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT38.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := New_hygiene(PROJECT(h, New_Layout_Suppress));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT38.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'product:' + getFieldTypeText(h.product) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'linking_type:' + getFieldTypeText(h.linking_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'linking_id:' + getFieldTypeText(h.linking_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'document_type:' + getFieldTypeText(h.document_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'document_id:' + getFieldTypeText(h.document_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'user:' + getFieldTypeText(h.user) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'compliance_id:' + getFieldTypeText(h.compliance_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'comment:' + getFieldTypeText(h.comment) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_product_cnt
          ,le.populated_linking_type_cnt
          ,le.populated_linking_id_cnt
          ,le.populated_document_type_cnt
          ,le.populated_document_id_cnt
          ,le.populated_date_added_cnt
          ,le.populated_user_cnt
          ,le.populated_compliance_id_cnt
          ,le.populated_comment_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_product_pcnt
          ,le.populated_linking_type_pcnt
          ,le.populated_linking_id_pcnt
          ,le.populated_document_type_pcnt
          ,le.populated_document_id_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_user_pcnt
          ,le.populated_compliance_id_pcnt
          ,le.populated_comment_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,9,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT38.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := New_Delta(prevDS, PROJECT(h, New_Layout_Suppress));
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
 
EXPORT StandardStats(DATASET(New_Layout_Suppress) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Suppress, New_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT38.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT38.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
