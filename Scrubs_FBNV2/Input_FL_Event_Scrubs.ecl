IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_FL_Event_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_FL_Event_Layout_FBNV2)
    UNSIGNED1 EVENT_DOC_NUMBER_Invalid;
    UNSIGNED1 EVENT_ORIG_DOC_NUMBER_Invalid;
    UNSIGNED1 EVENT_DATE_Invalid;
    UNSIGNED1 ACTION_OWN_NAME_Invalid;
    UNSIGNED1 prep_old_addr_line1_Invalid;
    UNSIGNED1 prep_old_addr_line_last_Invalid;
    UNSIGNED1 prep_new_addr_line1_Invalid;
    UNSIGNED1 prep_new_addr_line_last_Invalid;
    UNSIGNED1 prep_owner_addr_line1_Invalid;
    UNSIGNED1 prep_owner_addr_line_last_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_FL_Event_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_FL_Event_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.EVENT_DOC_NUMBER_Invalid := Input_FL_Event_Fields.InValid_EVENT_DOC_NUMBER((SALT311.StrType)le.EVENT_DOC_NUMBER);
    SELF.EVENT_ORIG_DOC_NUMBER_Invalid := Input_FL_Event_Fields.InValid_EVENT_ORIG_DOC_NUMBER((SALT311.StrType)le.EVENT_ORIG_DOC_NUMBER);
    SELF.EVENT_DATE_Invalid := Input_FL_Event_Fields.InValid_EVENT_DATE((SALT311.StrType)le.EVENT_DATE);
    SELF.ACTION_OWN_NAME_Invalid := Input_FL_Event_Fields.InValid_ACTION_OWN_NAME((SALT311.StrType)le.ACTION_OWN_NAME);
    SELF.prep_old_addr_line1_Invalid := Input_FL_Event_Fields.InValid_prep_old_addr_line1((SALT311.StrType)le.prep_old_addr_line1);
    SELF.prep_old_addr_line_last_Invalid := Input_FL_Event_Fields.InValid_prep_old_addr_line_last((SALT311.StrType)le.prep_old_addr_line_last);
    SELF.prep_new_addr_line1_Invalid := Input_FL_Event_Fields.InValid_prep_new_addr_line1((SALT311.StrType)le.prep_new_addr_line1);
    SELF.prep_new_addr_line_last_Invalid := Input_FL_Event_Fields.InValid_prep_new_addr_line_last((SALT311.StrType)le.prep_new_addr_line_last);
    SELF.prep_owner_addr_line1_Invalid := Input_FL_Event_Fields.InValid_prep_owner_addr_line1((SALT311.StrType)le.prep_owner_addr_line1);
    SELF.prep_owner_addr_line_last_Invalid := Input_FL_Event_Fields.InValid_prep_owner_addr_line_last((SALT311.StrType)le.prep_owner_addr_line_last);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_FL_Event_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.EVENT_DOC_NUMBER_Invalid << 0 ) + ( le.EVENT_ORIG_DOC_NUMBER_Invalid << 1 ) + ( le.EVENT_DATE_Invalid << 2 ) + ( le.ACTION_OWN_NAME_Invalid << 3 ) + ( le.prep_old_addr_line1_Invalid << 4 ) + ( le.prep_old_addr_line_last_Invalid << 5 ) + ( le.prep_new_addr_line1_Invalid << 6 ) + ( le.prep_new_addr_line_last_Invalid << 7 ) + ( le.prep_owner_addr_line1_Invalid << 8 ) + ( le.prep_owner_addr_line_last_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_FL_Event_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.EVENT_DOC_NUMBER_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.EVENT_ORIG_DOC_NUMBER_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.EVENT_DATE_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.ACTION_OWN_NAME_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.prep_old_addr_line1_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.prep_old_addr_line_last_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.prep_new_addr_line1_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prep_new_addr_line_last_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.prep_owner_addr_line1_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.prep_owner_addr_line_last_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    EVENT_DOC_NUMBER_LENGTHS_ErrorCount := COUNT(GROUP,h.EVENT_DOC_NUMBER_Invalid=1);
    EVENT_ORIG_DOC_NUMBER_LENGTHS_ErrorCount := COUNT(GROUP,h.EVENT_ORIG_DOC_NUMBER_Invalid=1);
    EVENT_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.EVENT_DATE_Invalid=1);
    ACTION_OWN_NAME_LENGTHS_ErrorCount := COUNT(GROUP,h.ACTION_OWN_NAME_Invalid=1);
    prep_old_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_old_addr_line1_Invalid=1);
    prep_old_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_old_addr_line_last_Invalid=1);
    prep_new_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_new_addr_line1_Invalid=1);
    prep_new_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_new_addr_line_last_Invalid=1);
    prep_owner_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line1_Invalid=1);
    prep_owner_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line_last_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.EVENT_DOC_NUMBER_Invalid > 0 OR h.EVENT_ORIG_DOC_NUMBER_Invalid > 0 OR h.EVENT_DATE_Invalid > 0 OR h.ACTION_OWN_NAME_Invalid > 0 OR h.prep_old_addr_line1_Invalid > 0 OR h.prep_old_addr_line_last_Invalid > 0 OR h.prep_new_addr_line1_Invalid > 0 OR h.prep_new_addr_line_last_Invalid > 0 OR h.prep_owner_addr_line1_Invalid > 0 OR h.prep_owner_addr_line_last_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.EVENT_DOC_NUMBER_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.EVENT_ORIG_DOC_NUMBER_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.EVENT_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ACTION_OWN_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_old_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_old_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_new_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_new_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.EVENT_DOC_NUMBER_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.EVENT_ORIG_DOC_NUMBER_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.EVENT_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.ACTION_OWN_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_old_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_old_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_new_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_new_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.EVENT_DOC_NUMBER_Invalid,le.EVENT_ORIG_DOC_NUMBER_Invalid,le.EVENT_DATE_Invalid,le.ACTION_OWN_NAME_Invalid,le.prep_old_addr_line1_Invalid,le.prep_old_addr_line_last_Invalid,le.prep_new_addr_line1_Invalid,le.prep_new_addr_line_last_Invalid,le.prep_owner_addr_line1_Invalid,le.prep_owner_addr_line_last_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_FL_Event_Fields.InvalidMessage_EVENT_DOC_NUMBER(le.EVENT_DOC_NUMBER_Invalid),Input_FL_Event_Fields.InvalidMessage_EVENT_ORIG_DOC_NUMBER(le.EVENT_ORIG_DOC_NUMBER_Invalid),Input_FL_Event_Fields.InvalidMessage_EVENT_DATE(le.EVENT_DATE_Invalid),Input_FL_Event_Fields.InvalidMessage_ACTION_OWN_NAME(le.ACTION_OWN_NAME_Invalid),Input_FL_Event_Fields.InvalidMessage_prep_old_addr_line1(le.prep_old_addr_line1_Invalid),Input_FL_Event_Fields.InvalidMessage_prep_old_addr_line_last(le.prep_old_addr_line_last_Invalid),Input_FL_Event_Fields.InvalidMessage_prep_new_addr_line1(le.prep_new_addr_line1_Invalid),Input_FL_Event_Fields.InvalidMessage_prep_new_addr_line_last(le.prep_new_addr_line_last_Invalid),Input_FL_Event_Fields.InvalidMessage_prep_owner_addr_line1(le.prep_owner_addr_line1_Invalid),Input_FL_Event_Fields.InvalidMessage_prep_owner_addr_line_last(le.prep_owner_addr_line_last_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.EVENT_DOC_NUMBER_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.EVENT_ORIG_DOC_NUMBER_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.EVENT_DATE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.ACTION_OWN_NAME_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_old_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_old_addr_line_last_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_new_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_new_addr_line_last_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line_last_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'EVENT_DOC_NUMBER','EVENT_ORIG_DOC_NUMBER','EVENT_DATE','ACTION_OWN_NAME','prep_old_addr_line1','prep_old_addr_line_last','prep_new_addr_line1','prep_new_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.EVENT_DOC_NUMBER,(SALT311.StrType)le.EVENT_ORIG_DOC_NUMBER,(SALT311.StrType)le.EVENT_DATE,(SALT311.StrType)le.ACTION_OWN_NAME,(SALT311.StrType)le.prep_old_addr_line1,(SALT311.StrType)le.prep_old_addr_line_last,(SALT311.StrType)le.prep_new_addr_line1,(SALT311.StrType)le.prep_new_addr_line_last,(SALT311.StrType)le.prep_owner_addr_line1,(SALT311.StrType)le.prep_owner_addr_line_last,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_FL_Event_Layout_FBNV2) prevDS = DATASET([], Input_FL_Event_Layout_FBNV2), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'EVENT_DOC_NUMBER:invalid_mandatory:LENGTHS'
          ,'EVENT_ORIG_DOC_NUMBER:invalid_mandatory:LENGTHS'
          ,'EVENT_DATE:invalid_past_date:CUSTOM'
          ,'ACTION_OWN_NAME:invalid_mandatory:LENGTHS'
          ,'prep_old_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_old_addr_line_last:invalid_mandatory:LENGTHS'
          ,'prep_new_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_new_addr_line_last:invalid_mandatory:LENGTHS'
          ,'prep_owner_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_owner_addr_line_last:invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_FL_Event_Fields.InvalidMessage_EVENT_DOC_NUMBER(1)
          ,Input_FL_Event_Fields.InvalidMessage_EVENT_ORIG_DOC_NUMBER(1)
          ,Input_FL_Event_Fields.InvalidMessage_EVENT_DATE(1)
          ,Input_FL_Event_Fields.InvalidMessage_ACTION_OWN_NAME(1)
          ,Input_FL_Event_Fields.InvalidMessage_prep_old_addr_line1(1)
          ,Input_FL_Event_Fields.InvalidMessage_prep_old_addr_line_last(1)
          ,Input_FL_Event_Fields.InvalidMessage_prep_new_addr_line1(1)
          ,Input_FL_Event_Fields.InvalidMessage_prep_new_addr_line_last(1)
          ,Input_FL_Event_Fields.InvalidMessage_prep_owner_addr_line1(1)
          ,Input_FL_Event_Fields.InvalidMessage_prep_owner_addr_line_last(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.EVENT_DOC_NUMBER_LENGTHS_ErrorCount
          ,le.EVENT_ORIG_DOC_NUMBER_LENGTHS_ErrorCount
          ,le.EVENT_DATE_CUSTOM_ErrorCount
          ,le.ACTION_OWN_NAME_LENGTHS_ErrorCount
          ,le.prep_old_addr_line1_LENGTHS_ErrorCount
          ,le.prep_old_addr_line_last_LENGTHS_ErrorCount
          ,le.prep_new_addr_line1_LENGTHS_ErrorCount
          ,le.prep_new_addr_line_last_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line1_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.EVENT_DOC_NUMBER_LENGTHS_ErrorCount
          ,le.EVENT_ORIG_DOC_NUMBER_LENGTHS_ErrorCount
          ,le.EVENT_DATE_CUSTOM_ErrorCount
          ,le.ACTION_OWN_NAME_LENGTHS_ErrorCount
          ,le.prep_old_addr_line1_LENGTHS_ErrorCount
          ,le.prep_old_addr_line_last_LENGTHS_ErrorCount
          ,le.prep_new_addr_line1_LENGTHS_ErrorCount
          ,le.prep_new_addr_line_last_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line1_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_FL_Event_hygiene(PROJECT(h, Input_FL_Event_Layout_FBNV2));
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
          ,'EVENT_DOC_NUMBER:' + getFieldTypeText(h.EVENT_DOC_NUMBER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EVENT_ORIG_DOC_NUMBER:' + getFieldTypeText(h.EVENT_ORIG_DOC_NUMBER) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'EVENT_DATE:' + getFieldTypeText(h.EVENT_DATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ACTION_OWN_NAME:' + getFieldTypeText(h.ACTION_OWN_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_old_addr_line1:' + getFieldTypeText(h.prep_old_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_old_addr_line_last:' + getFieldTypeText(h.prep_old_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_new_addr_line1:' + getFieldTypeText(h.prep_new_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_new_addr_line_last:' + getFieldTypeText(h.prep_new_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_owner_addr_line1:' + getFieldTypeText(h.prep_owner_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_owner_addr_line_last:' + getFieldTypeText(h.prep_owner_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_EVENT_DOC_NUMBER_cnt
          ,le.populated_EVENT_ORIG_DOC_NUMBER_cnt
          ,le.populated_EVENT_DATE_cnt
          ,le.populated_ACTION_OWN_NAME_cnt
          ,le.populated_prep_old_addr_line1_cnt
          ,le.populated_prep_old_addr_line_last_cnt
          ,le.populated_prep_new_addr_line1_cnt
          ,le.populated_prep_new_addr_line_last_cnt
          ,le.populated_prep_owner_addr_line1_cnt
          ,le.populated_prep_owner_addr_line_last_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_EVENT_DOC_NUMBER_pcnt
          ,le.populated_EVENT_ORIG_DOC_NUMBER_pcnt
          ,le.populated_EVENT_DATE_pcnt
          ,le.populated_ACTION_OWN_NAME_pcnt
          ,le.populated_prep_old_addr_line1_pcnt
          ,le.populated_prep_old_addr_line_last_pcnt
          ,le.populated_prep_new_addr_line1_pcnt
          ,le.populated_prep_new_addr_line_last_pcnt
          ,le.populated_prep_owner_addr_line1_pcnt
          ,le.populated_prep_owner_addr_line_last_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,10,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_FL_Event_Delta(prevDS, PROJECT(h, Input_FL_Event_Layout_FBNV2));
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
 
EXPORT StandardStats(DATASET(Input_FL_Event_Layout_FBNV2) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FBNV2, Input_FL_Event_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
