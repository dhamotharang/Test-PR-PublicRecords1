IMPORT SALT38,STD;
IMPORT Scrubs,Scrubs_SANCTNKeys; // Import modules for FieldTypes attribute definitions
EXPORT license_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 9;
  EXPORT NumRulesFromFieldType := 9;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(license_Layout_SANCTNKeys)
    UNSIGNED1 batch_number_Invalid;
    UNSIGNED1 incident_number_Invalid;
    UNSIGNED1 party_number_Invalid;
    UNSIGNED1 order_number_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 license_type_Invalid;
    UNSIGNED1 license_state_Invalid;
    UNSIGNED1 cln_license_number_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(license_Layout_SANCTNKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(license_Layout_SANCTNKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_number_Invalid := license_Fields.InValid_batch_number((SALT38.StrType)le.batch_number);
    SELF.incident_number_Invalid := license_Fields.InValid_incident_number((SALT38.StrType)le.incident_number);
    SELF.party_number_Invalid := license_Fields.InValid_party_number((SALT38.StrType)le.party_number);
    SELF.order_number_Invalid := license_Fields.InValid_order_number((SALT38.StrType)le.order_number);
    SELF.license_number_Invalid := license_Fields.InValid_license_number((SALT38.StrType)le.license_number);
    SELF.license_type_Invalid := license_Fields.InValid_license_type((SALT38.StrType)le.license_type);
    SELF.license_state_Invalid := license_Fields.InValid_license_state((SALT38.StrType)le.license_state);
    SELF.cln_license_number_Invalid := license_Fields.InValid_cln_license_number((SALT38.StrType)le.cln_license_number);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),license_Layout_SANCTNKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_number_Invalid << 0 ) + ( le.incident_number_Invalid << 2 ) + ( le.party_number_Invalid << 3 ) + ( le.order_number_Invalid << 4 ) + ( le.license_number_Invalid << 5 ) + ( le.license_type_Invalid << 6 ) + ( le.license_state_Invalid << 7 ) + ( le.cln_license_number_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,license_Layout_SANCTNKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_number_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.incident_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.party_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.order_number_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.license_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.license_state_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.cln_license_number_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    batch_number_ALLOW_ErrorCount := COUNT(GROUP,h.batch_number_Invalid=1);
    batch_number_LENGTH_ErrorCount := COUNT(GROUP,h.batch_number_Invalid=2);
    batch_number_Total_ErrorCount := COUNT(GROUP,h.batch_number_Invalid>0);
    incident_number_ALLOW_ErrorCount := COUNT(GROUP,h.incident_number_Invalid=1);
    party_number_ALLOW_ErrorCount := COUNT(GROUP,h.party_number_Invalid=1);
    order_number_ALLOW_ErrorCount := COUNT(GROUP,h.order_number_Invalid=1);
    license_number_ALLOW_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    license_type_CUSTOM_ErrorCount := COUNT(GROUP,h.license_type_Invalid=1);
    license_state_CUSTOM_ErrorCount := COUNT(GROUP,h.license_state_Invalid=1);
    cln_license_number_ALLOW_ErrorCount := COUNT(GROUP,h.cln_license_number_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.batch_number_Invalid > 0 OR h.incident_number_Invalid > 0 OR h.party_number_Invalid > 0 OR h.order_number_Invalid > 0 OR h.license_number_Invalid > 0 OR h.license_type_Invalid > 0 OR h.license_state_Invalid > 0 OR h.cln_license_number_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.batch_number_Total_ErrorCount > 0, 1, 0) + IF(le.incident_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.order_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_license_number_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.batch_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_number_LENGTH_ErrorCount > 0, 1, 0) + IF(le.incident_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.order_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.license_type_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_license_number_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_number_Invalid,le.incident_number_Invalid,le.party_number_Invalid,le.order_number_Invalid,le.license_number_Invalid,le.license_type_Invalid,le.license_state_Invalid,le.cln_license_number_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,license_Fields.InvalidMessage_batch_number(le.batch_number_Invalid),license_Fields.InvalidMessage_incident_number(le.incident_number_Invalid),license_Fields.InvalidMessage_party_number(le.party_number_Invalid),license_Fields.InvalidMessage_order_number(le.order_number_Invalid),license_Fields.InvalidMessage_license_number(le.license_number_Invalid),license_Fields.InvalidMessage_license_type(le.license_type_Invalid),license_Fields.InvalidMessage_license_state(le.license_state_Invalid),license_Fields.InvalidMessage_cln_license_number(le.cln_license_number_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.incident_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.order_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.license_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_license_number_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch_number','incident_number','party_number','order_number','license_number','license_type','license_state','cln_license_number','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_LicenseNumber','Invalid_LicenseType','Invalid_State','Invalid_ClnLicenseNumber','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.batch_number,(SALT38.StrType)le.incident_number,(SALT38.StrType)le.party_number,(SALT38.StrType)le.order_number,(SALT38.StrType)le.license_number,(SALT38.StrType)le.license_type,(SALT38.StrType)le.license_state,(SALT38.StrType)le.cln_license_number,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(license_Layout_SANCTNKeys) prevDS = DATASET([], license_Layout_SANCTNKeys), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'batch_number:Invalid_Batch:ALLOW','batch_number:Invalid_Batch:LENGTH'
          ,'incident_number:Invalid_Num:ALLOW'
          ,'party_number:Invalid_Num:ALLOW'
          ,'order_number:Invalid_Num:ALLOW'
          ,'license_number:Invalid_LicenseNumber:ALLOW'
          ,'license_type:Invalid_LicenseType:CUSTOM'
          ,'license_state:Invalid_State:CUSTOM'
          ,'cln_license_number:Invalid_ClnLicenseNumber:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,license_Fields.InvalidMessage_batch_number(1),license_Fields.InvalidMessage_batch_number(2)
          ,license_Fields.InvalidMessage_incident_number(1)
          ,license_Fields.InvalidMessage_party_number(1)
          ,license_Fields.InvalidMessage_order_number(1)
          ,license_Fields.InvalidMessage_license_number(1)
          ,license_Fields.InvalidMessage_license_type(1)
          ,license_Fields.InvalidMessage_license_state(1)
          ,license_Fields.InvalidMessage_cln_license_number(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.batch_number_ALLOW_ErrorCount,le.batch_number_LENGTH_ErrorCount
          ,le.incident_number_ALLOW_ErrorCount
          ,le.party_number_ALLOW_ErrorCount
          ,le.order_number_ALLOW_ErrorCount
          ,le.license_number_ALLOW_ErrorCount
          ,le.license_type_CUSTOM_ErrorCount
          ,le.license_state_CUSTOM_ErrorCount
          ,le.cln_license_number_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.batch_number_ALLOW_ErrorCount,le.batch_number_LENGTH_ErrorCount
          ,le.incident_number_ALLOW_ErrorCount
          ,le.party_number_ALLOW_ErrorCount
          ,le.order_number_ALLOW_ErrorCount
          ,le.license_number_ALLOW_ErrorCount
          ,le.license_type_CUSTOM_ErrorCount
          ,le.license_state_CUSTOM_ErrorCount
          ,le.cln_license_number_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := license_hygiene(PROJECT(h, license_Layout_SANCTNKeys));
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
          ,'batch_number:' + getFieldTypeText(h.batch_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incident_number:' + getFieldTypeText(h.incident_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'party_number:' + getFieldTypeText(h.party_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'order_number:' + getFieldTypeText(h.order_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_number:' + getFieldTypeText(h.license_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_type:' + getFieldTypeText(h.license_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_state:' + getFieldTypeText(h.license_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_license_number:' + getFieldTypeText(h.cln_license_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'std_type_desc:' + getFieldTypeText(h.std_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_batch_number_cnt
          ,le.populated_incident_number_cnt
          ,le.populated_party_number_cnt
          ,le.populated_record_type_cnt
          ,le.populated_order_number_cnt
          ,le.populated_license_number_cnt
          ,le.populated_license_type_cnt
          ,le.populated_license_state_cnt
          ,le.populated_cln_license_number_cnt
          ,le.populated_std_type_desc_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_batch_number_pcnt
          ,le.populated_incident_number_pcnt
          ,le.populated_party_number_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_order_number_pcnt
          ,le.populated_license_number_pcnt
          ,le.populated_license_type_pcnt
          ,le.populated_license_state_pcnt
          ,le.populated_cln_license_number_pcnt
          ,le.populated_std_type_desc_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,10,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := license_Delta(prevDS, PROJECT(h, license_Layout_SANCTNKeys));
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
 
EXPORT StandardStats(DATASET(license_Layout_SANCTNKeys) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_SANCTNKeys, license_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
