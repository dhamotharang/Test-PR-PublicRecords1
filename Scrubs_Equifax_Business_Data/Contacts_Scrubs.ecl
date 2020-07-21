IMPORT SALT311,STD;
IMPORT Scrubs_Equifax_Business_Data; // Import modules for FieldTypes attribute definitions
EXPORT Contacts_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 7;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Contacts_Layout_Equifax_Business_Data)
    UNSIGNED1 EFX_id_Invalid;
    UNSIGNED1 EFX_CONTCT_Invalid;
    UNSIGNED1 EFX_TITLECD_Invalid;
    UNSIGNED1 EFX_TITLEDESC_Invalid;
    UNSIGNED1 EFX_LASTNAM_Invalid;
    UNSIGNED1 EFX_FSTNAM_Invalid;
    UNSIGNED1 EFX_DATE_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Contacts_Layout_Equifax_Business_Data)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Contacts_Layout_Equifax_Business_Data) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.EFX_id_Invalid := Contacts_Fields.InValid_EFX_id((SALT311.StrType)le.EFX_id);
    SELF.EFX_CONTCT_Invalid := Contacts_Fields.InValid_EFX_CONTCT((SALT311.StrType)le.EFX_CONTCT);
    SELF.EFX_TITLECD_Invalid := Contacts_Fields.InValid_EFX_TITLECD((SALT311.StrType)le.EFX_TITLECD);
    SELF.EFX_TITLEDESC_Invalid := Contacts_Fields.InValid_EFX_TITLEDESC((SALT311.StrType)le.EFX_TITLEDESC);
    SELF.EFX_LASTNAM_Invalid := Contacts_Fields.InValid_EFX_LASTNAM((SALT311.StrType)le.EFX_LASTNAM);
    SELF.EFX_FSTNAM_Invalid := Contacts_Fields.InValid_EFX_FSTNAM((SALT311.StrType)le.EFX_FSTNAM);
    SELF.EFX_DATE_Invalid := Contacts_Fields.InValid_EFX_DATE((SALT311.StrType)le.EFX_DATE);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Contacts_Layout_Equifax_Business_Data);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.EFX_id_Invalid << 0 ) + ( le.EFX_CONTCT_Invalid << 2 ) + ( le.EFX_TITLECD_Invalid << 3 ) + ( le.EFX_TITLEDESC_Invalid << 4 ) + ( le.EFX_LASTNAM_Invalid << 5 ) + ( le.EFX_FSTNAM_Invalid << 6 ) + ( le.EFX_DATE_Invalid << 7 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Contacts_Layout_Equifax_Business_Data);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.EFX_id_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.EFX_CONTCT_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.EFX_TITLECD_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.EFX_TITLEDESC_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.EFX_LASTNAM_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.EFX_FSTNAM_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.EFX_DATE_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    EFX_id_ALLOW_ErrorCount := COUNT(GROUP,h.EFX_id_Invalid=1);
    EFX_id_LENGTHS_ErrorCount := COUNT(GROUP,h.EFX_id_Invalid=2);
    EFX_id_Total_ErrorCount := COUNT(GROUP,h.EFX_id_Invalid>0);
    EFX_CONTCT_LENGTHS_ErrorCount := COUNT(GROUP,h.EFX_CONTCT_Invalid=1);
    EFX_TITLECD_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_TITLECD_Invalid=1);
    EFX_TITLEDESC_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_TITLEDESC_Invalid=1);
    EFX_LASTNAM_ALLOW_ErrorCount := COUNT(GROUP,h.EFX_LASTNAM_Invalid=1);
    EFX_FSTNAM_ALLOW_ErrorCount := COUNT(GROUP,h.EFX_FSTNAM_Invalid=1);
    EFX_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.EFX_DATE_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.EFX_id_Invalid > 0 OR h.EFX_CONTCT_Invalid > 0 OR h.EFX_TITLECD_Invalid > 0 OR h.EFX_TITLEDESC_Invalid > 0 OR h.EFX_LASTNAM_Invalid > 0 OR h.EFX_FSTNAM_Invalid > 0 OR h.EFX_DATE_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.EFX_id_Total_ErrorCount > 0, 1, 0) + IF(le.EFX_CONTCT_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.EFX_TITLECD_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.EFX_TITLEDESC_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.EFX_LASTNAM_ALLOW_ErrorCount > 0, 1, 0) + IF(le.EFX_FSTNAM_ALLOW_ErrorCount > 0, 1, 0) + IF(le.EFX_DATE_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.EFX_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.EFX_id_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.EFX_CONTCT_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.EFX_TITLECD_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.EFX_TITLEDESC_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.EFX_LASTNAM_ALLOW_ErrorCount > 0, 1, 0) + IF(le.EFX_FSTNAM_ALLOW_ErrorCount > 0, 1, 0) + IF(le.EFX_DATE_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.EFX_id_Invalid,le.EFX_CONTCT_Invalid,le.EFX_TITLECD_Invalid,le.EFX_TITLEDESC_Invalid,le.EFX_LASTNAM_Invalid,le.EFX_FSTNAM_Invalid,le.EFX_DATE_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Contacts_Fields.InvalidMessage_EFX_id(le.EFX_id_Invalid),Contacts_Fields.InvalidMessage_EFX_CONTCT(le.EFX_CONTCT_Invalid),Contacts_Fields.InvalidMessage_EFX_TITLECD(le.EFX_TITLECD_Invalid),Contacts_Fields.InvalidMessage_EFX_TITLEDESC(le.EFX_TITLEDESC_Invalid),Contacts_Fields.InvalidMessage_EFX_LASTNAM(le.EFX_LASTNAM_Invalid),Contacts_Fields.InvalidMessage_EFX_FSTNAM(le.EFX_FSTNAM_Invalid),Contacts_Fields.InvalidMessage_EFX_DATE(le.EFX_DATE_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.EFX_id_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.EFX_CONTCT_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.EFX_TITLECD_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_TITLEDESC_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.EFX_LASTNAM_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.EFX_FSTNAM_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.EFX_DATE_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'EFX_id','EFX_CONTCT','EFX_TITLECD','EFX_TITLEDESC','EFX_LASTNAM','EFX_FSTNAM','EFX_DATE','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_efx_id','invalid_mandatory','invalid_title','invalid_title_desc','invalid_last_name','invalid_first_name','invalid_efx_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.EFX_id,(SALT311.StrType)le.EFX_CONTCT,(SALT311.StrType)le.EFX_TITLECD,(SALT311.StrType)le.EFX_TITLEDESC,(SALT311.StrType)le.EFX_LASTNAM,(SALT311.StrType)le.EFX_FSTNAM,(SALT311.StrType)le.EFX_DATE,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,7,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Contacts_Layout_Equifax_Business_Data) prevDS = DATASET([], Contacts_Layout_Equifax_Business_Data), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'EFX_id:invalid_efx_id:ALLOW','EFX_id:invalid_efx_id:LENGTHS'
          ,'EFX_CONTCT:invalid_mandatory:LENGTHS'
          ,'EFX_TITLECD:invalid_title:CUSTOM'
          ,'EFX_TITLEDESC:invalid_title_desc:CUSTOM'
          ,'EFX_LASTNAM:invalid_last_name:ALLOW'
          ,'EFX_FSTNAM:invalid_first_name:ALLOW'
          ,'EFX_DATE:invalid_efx_date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Contacts_Fields.InvalidMessage_EFX_id(1),Contacts_Fields.InvalidMessage_EFX_id(2)
          ,Contacts_Fields.InvalidMessage_EFX_CONTCT(1)
          ,Contacts_Fields.InvalidMessage_EFX_TITLECD(1)
          ,Contacts_Fields.InvalidMessage_EFX_TITLEDESC(1)
          ,Contacts_Fields.InvalidMessage_EFX_LASTNAM(1)
          ,Contacts_Fields.InvalidMessage_EFX_FSTNAM(1)
          ,Contacts_Fields.InvalidMessage_EFX_DATE(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.EFX_id_ALLOW_ErrorCount,le.EFX_id_LENGTHS_ErrorCount
          ,le.EFX_CONTCT_LENGTHS_ErrorCount
          ,le.EFX_TITLECD_CUSTOM_ErrorCount
          ,le.EFX_TITLEDESC_CUSTOM_ErrorCount
          ,le.EFX_LASTNAM_ALLOW_ErrorCount
          ,le.EFX_FSTNAM_ALLOW_ErrorCount
          ,le.EFX_DATE_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.EFX_id_ALLOW_ErrorCount,le.EFX_id_LENGTHS_ErrorCount
          ,le.EFX_CONTCT_LENGTHS_ErrorCount
          ,le.EFX_TITLECD_CUSTOM_ErrorCount
          ,le.EFX_TITLEDESC_CUSTOM_ErrorCount
          ,le.EFX_LASTNAM_ALLOW_ErrorCount
          ,le.EFX_FSTNAM_ALLOW_ErrorCount
          ,le.EFX_DATE_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Contacts_hygiene(PROJECT(h, Contacts_Layout_Equifax_Business_Data));
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
          ,'EFX_id:' + getFieldTypeText(h.EFX_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EFX_CONTCT:' + getFieldTypeText(h.EFX_CONTCT) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EFX_TITLECD:' + getFieldTypeText(h.EFX_TITLECD) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EFX_TITLEDESC:' + getFieldTypeText(h.EFX_TITLEDESC) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EFX_LASTNAM:' + getFieldTypeText(h.EFX_LASTNAM) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EFX_FSTNAM:' + getFieldTypeText(h.EFX_FSTNAM) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EFX_EMAIL:' + getFieldTypeText(h.EFX_EMAIL) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EFX_DATE:' + getFieldTypeText(h.EFX_DATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_EFX_id_cnt
          ,le.populated_EFX_CONTCT_cnt
          ,le.populated_EFX_TITLECD_cnt
          ,le.populated_EFX_TITLEDESC_cnt
          ,le.populated_EFX_LASTNAM_cnt
          ,le.populated_EFX_FSTNAM_cnt
          ,le.populated_EFX_EMAIL_cnt
          ,le.populated_EFX_DATE_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_EFX_id_pcnt
          ,le.populated_EFX_CONTCT_pcnt
          ,le.populated_EFX_TITLECD_pcnt
          ,le.populated_EFX_TITLEDESC_pcnt
          ,le.populated_EFX_LASTNAM_pcnt
          ,le.populated_EFX_FSTNAM_pcnt
          ,le.populated_EFX_EMAIL_pcnt
          ,le.populated_EFX_DATE_pcnt,0);
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
 
    mod_Delta := Contacts_Delta(prevDS, PROJECT(h, Contacts_Layout_Equifax_Business_Data));
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
 
EXPORT StandardStats(DATASET(Contacts_Layout_Equifax_Business_Data) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Equifax_Business_Data, Contacts_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
