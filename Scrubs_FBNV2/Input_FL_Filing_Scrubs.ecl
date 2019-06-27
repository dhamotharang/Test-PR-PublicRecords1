IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_FL_Filing_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 12;
  EXPORT NumRulesFromFieldType := 12;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 12;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_FL_Filing_Layout_FBNV2)
    UNSIGNED1 FIC_FIL_DOC_NUM_Invalid;
    UNSIGNED1 FIC_FIL_NAME_Invalid;
    UNSIGNED1 FIC_FIL_DATE_Invalid;
    UNSIGNED1 FIC_OWNER_DOC_NUM_Invalid;
    UNSIGNED1 FIC_OWNER_NAME_Invalid;
    UNSIGNED1 p_owner_name_Invalid;
    UNSIGNED1 c_owner_name_Invalid;
    UNSIGNED1 prep_addr_line1_Invalid;
    UNSIGNED1 prep_addr_line_last_Invalid;
    UNSIGNED1 prep_owner_addr_line1_Invalid;
    UNSIGNED1 prep_owner_addr_line_last_Invalid;
    UNSIGNED1 seq_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_FL_Filing_Layout_FBNV2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_FL_Filing_Layout_FBNV2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.FIC_FIL_DOC_NUM_Invalid := Input_FL_Filing_Fields.InValid_FIC_FIL_DOC_NUM((SALT311.StrType)le.FIC_FIL_DOC_NUM);
    SELF.FIC_FIL_NAME_Invalid := Input_FL_Filing_Fields.InValid_FIC_FIL_NAME((SALT311.StrType)le.FIC_FIL_NAME);
    SELF.FIC_FIL_DATE_Invalid := Input_FL_Filing_Fields.InValid_FIC_FIL_DATE((SALT311.StrType)le.FIC_FIL_DATE);
    SELF.FIC_OWNER_DOC_NUM_Invalid := Input_FL_Filing_Fields.InValid_FIC_OWNER_DOC_NUM((SALT311.StrType)le.FIC_OWNER_DOC_NUM);
    SELF.FIC_OWNER_NAME_Invalid := Input_FL_Filing_Fields.InValid_FIC_OWNER_NAME((SALT311.StrType)le.FIC_OWNER_NAME);
    SELF.p_owner_name_Invalid := Input_FL_Filing_Fields.InValid_p_owner_name((SALT311.StrType)le.p_owner_name);
    SELF.c_owner_name_Invalid := Input_FL_Filing_Fields.InValid_c_owner_name((SALT311.StrType)le.c_owner_name);
    SELF.prep_addr_line1_Invalid := Input_FL_Filing_Fields.InValid_prep_addr_line1((SALT311.StrType)le.prep_addr_line1);
    SELF.prep_addr_line_last_Invalid := Input_FL_Filing_Fields.InValid_prep_addr_line_last((SALT311.StrType)le.prep_addr_line_last);
    SELF.prep_owner_addr_line1_Invalid := Input_FL_Filing_Fields.InValid_prep_owner_addr_line1((SALT311.StrType)le.prep_owner_addr_line1);
    SELF.prep_owner_addr_line_last_Invalid := Input_FL_Filing_Fields.InValid_prep_owner_addr_line_last((SALT311.StrType)le.prep_owner_addr_line_last);
    SELF.seq_Invalid := Input_FL_Filing_Fields.InValid_seq((SALT311.StrType)le.seq);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_FL_Filing_Layout_FBNV2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.FIC_FIL_DOC_NUM_Invalid << 0 ) + ( le.FIC_FIL_NAME_Invalid << 1 ) + ( le.FIC_FIL_DATE_Invalid << 2 ) + ( le.FIC_OWNER_DOC_NUM_Invalid << 3 ) + ( le.FIC_OWNER_NAME_Invalid << 4 ) + ( le.p_owner_name_Invalid << 5 ) + ( le.c_owner_name_Invalid << 6 ) + ( le.prep_addr_line1_Invalid << 7 ) + ( le.prep_addr_line_last_Invalid << 8 ) + ( le.prep_owner_addr_line1_Invalid << 9 ) + ( le.prep_owner_addr_line_last_Invalid << 10 ) + ( le.seq_Invalid << 11 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_FL_Filing_Layout_FBNV2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.FIC_FIL_DOC_NUM_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.FIC_FIL_NAME_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.FIC_FIL_DATE_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.FIC_OWNER_DOC_NUM_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.FIC_OWNER_NAME_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.p_owner_name_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.c_owner_name_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.prep_addr_line1_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.prep_addr_line_last_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.prep_owner_addr_line1_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.prep_owner_addr_line_last_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.seq_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    FIC_FIL_DOC_NUM_LENGTHS_ErrorCount := COUNT(GROUP,h.FIC_FIL_DOC_NUM_Invalid=1);
    FIC_FIL_NAME_LENGTHS_ErrorCount := COUNT(GROUP,h.FIC_FIL_NAME_Invalid=1);
    FIC_FIL_DATE_CUSTOM_ErrorCount := COUNT(GROUP,h.FIC_FIL_DATE_Invalid=1);
    FIC_OWNER_DOC_NUM_LENGTHS_ErrorCount := COUNT(GROUP,h.FIC_OWNER_DOC_NUM_Invalid=1);
    FIC_OWNER_NAME_LENGTHS_ErrorCount := COUNT(GROUP,h.FIC_OWNER_NAME_Invalid=1);
    p_owner_name_LENGTHS_ErrorCount := COUNT(GROUP,h.p_owner_name_Invalid=1);
    c_owner_name_LENGTHS_ErrorCount := COUNT(GROUP,h.c_owner_name_Invalid=1);
    prep_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr_line1_Invalid=1);
    prep_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_addr_line_last_Invalid=1);
    prep_owner_addr_line1_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line1_Invalid=1);
    prep_owner_addr_line_last_LENGTHS_ErrorCount := COUNT(GROUP,h.prep_owner_addr_line_last_Invalid=1);
    seq_LENGTHS_ErrorCount := COUNT(GROUP,h.seq_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.FIC_FIL_DOC_NUM_Invalid > 0 OR h.FIC_FIL_NAME_Invalid > 0 OR h.FIC_FIL_DATE_Invalid > 0 OR h.FIC_OWNER_DOC_NUM_Invalid > 0 OR h.FIC_OWNER_NAME_Invalid > 0 OR h.p_owner_name_Invalid > 0 OR h.c_owner_name_Invalid > 0 OR h.prep_addr_line1_Invalid > 0 OR h.prep_addr_line_last_Invalid > 0 OR h.prep_owner_addr_line1_Invalid > 0 OR h.prep_owner_addr_line_last_Invalid > 0 OR h.seq_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.FIC_FIL_DOC_NUM_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.FIC_FIL_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.FIC_FIL_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FIC_OWNER_DOC_NUM_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.FIC_OWNER_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_owner_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.c_owner_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seq_LENGTHS_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.FIC_FIL_DOC_NUM_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.FIC_FIL_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.FIC_FIL_DATE_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.FIC_OWNER_DOC_NUM_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.FIC_OWNER_NAME_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.p_owner_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.c_owner_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.prep_owner_addr_line_last_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.seq_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.FIC_FIL_DOC_NUM_Invalid,le.FIC_FIL_NAME_Invalid,le.FIC_FIL_DATE_Invalid,le.FIC_OWNER_DOC_NUM_Invalid,le.FIC_OWNER_NAME_Invalid,le.p_owner_name_Invalid,le.c_owner_name_Invalid,le.prep_addr_line1_Invalid,le.prep_addr_line_last_Invalid,le.prep_owner_addr_line1_Invalid,le.prep_owner_addr_line_last_Invalid,le.seq_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_FL_Filing_Fields.InvalidMessage_FIC_FIL_DOC_NUM(le.FIC_FIL_DOC_NUM_Invalid),Input_FL_Filing_Fields.InvalidMessage_FIC_FIL_NAME(le.FIC_FIL_NAME_Invalid),Input_FL_Filing_Fields.InvalidMessage_FIC_FIL_DATE(le.FIC_FIL_DATE_Invalid),Input_FL_Filing_Fields.InvalidMessage_FIC_OWNER_DOC_NUM(le.FIC_OWNER_DOC_NUM_Invalid),Input_FL_Filing_Fields.InvalidMessage_FIC_OWNER_NAME(le.FIC_OWNER_NAME_Invalid),Input_FL_Filing_Fields.InvalidMessage_p_owner_name(le.p_owner_name_Invalid),Input_FL_Filing_Fields.InvalidMessage_c_owner_name(le.c_owner_name_Invalid),Input_FL_Filing_Fields.InvalidMessage_prep_addr_line1(le.prep_addr_line1_Invalid),Input_FL_Filing_Fields.InvalidMessage_prep_addr_line_last(le.prep_addr_line_last_Invalid),Input_FL_Filing_Fields.InvalidMessage_prep_owner_addr_line1(le.prep_owner_addr_line1_Invalid),Input_FL_Filing_Fields.InvalidMessage_prep_owner_addr_line_last(le.prep_owner_addr_line_last_Invalid),Input_FL_Filing_Fields.InvalidMessage_seq(le.seq_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.FIC_FIL_DOC_NUM_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.FIC_FIL_NAME_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.FIC_FIL_DATE_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.FIC_OWNER_DOC_NUM_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.FIC_OWNER_NAME_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.p_owner_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.c_owner_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_addr_line_last_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line1_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.prep_owner_addr_line_last_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.seq_Invalid,'LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'FIC_FIL_DOC_NUM','FIC_FIL_NAME','FIC_FIL_DATE','FIC_OWNER_DOC_NUM','FIC_OWNER_NAME','p_owner_name','c_owner_name','prep_addr_line1','prep_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last','seq','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.FIC_FIL_DOC_NUM,(SALT311.StrType)le.FIC_FIL_NAME,(SALT311.StrType)le.FIC_FIL_DATE,(SALT311.StrType)le.FIC_OWNER_DOC_NUM,(SALT311.StrType)le.FIC_OWNER_NAME,(SALT311.StrType)le.p_owner_name,(SALT311.StrType)le.c_owner_name,(SALT311.StrType)le.prep_addr_line1,(SALT311.StrType)le.prep_addr_line_last,(SALT311.StrType)le.prep_owner_addr_line1,(SALT311.StrType)le.prep_owner_addr_line_last,(SALT311.StrType)le.seq,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,12,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_FL_Filing_Layout_FBNV2) prevDS = DATASET([], Input_FL_Filing_Layout_FBNV2), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'FIC_FIL_DOC_NUM:invalid_mandatory:LENGTHS'
          ,'FIC_FIL_NAME:invalid_mandatory:LENGTHS'
          ,'FIC_FIL_DATE:invalid_past_date:CUSTOM'
          ,'FIC_OWNER_DOC_NUM:invalid_mandatory:LENGTHS'
          ,'FIC_OWNER_NAME:invalid_mandatory:LENGTHS'
          ,'p_owner_name:invalid_mandatory:LENGTHS'
          ,'c_owner_name:invalid_mandatory:LENGTHS'
          ,'prep_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_addr_line_last:invalid_mandatory:LENGTHS'
          ,'prep_owner_addr_line1:invalid_mandatory:LENGTHS'
          ,'prep_owner_addr_line_last:invalid_mandatory:LENGTHS'
          ,'seq:invalid_mandatory:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_FL_Filing_Fields.InvalidMessage_FIC_FIL_DOC_NUM(1)
          ,Input_FL_Filing_Fields.InvalidMessage_FIC_FIL_NAME(1)
          ,Input_FL_Filing_Fields.InvalidMessage_FIC_FIL_DATE(1)
          ,Input_FL_Filing_Fields.InvalidMessage_FIC_OWNER_DOC_NUM(1)
          ,Input_FL_Filing_Fields.InvalidMessage_FIC_OWNER_NAME(1)
          ,Input_FL_Filing_Fields.InvalidMessage_p_owner_name(1)
          ,Input_FL_Filing_Fields.InvalidMessage_c_owner_name(1)
          ,Input_FL_Filing_Fields.InvalidMessage_prep_addr_line1(1)
          ,Input_FL_Filing_Fields.InvalidMessage_prep_addr_line_last(1)
          ,Input_FL_Filing_Fields.InvalidMessage_prep_owner_addr_line1(1)
          ,Input_FL_Filing_Fields.InvalidMessage_prep_owner_addr_line_last(1)
          ,Input_FL_Filing_Fields.InvalidMessage_seq(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.FIC_FIL_DOC_NUM_LENGTHS_ErrorCount
          ,le.FIC_FIL_NAME_LENGTHS_ErrorCount
          ,le.FIC_FIL_DATE_CUSTOM_ErrorCount
          ,le.FIC_OWNER_DOC_NUM_LENGTHS_ErrorCount
          ,le.FIC_OWNER_NAME_LENGTHS_ErrorCount
          ,le.p_owner_name_LENGTHS_ErrorCount
          ,le.c_owner_name_LENGTHS_ErrorCount
          ,le.prep_addr_line1_LENGTHS_ErrorCount
          ,le.prep_addr_line_last_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line1_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTHS_ErrorCount
          ,le.seq_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.FIC_FIL_DOC_NUM_LENGTHS_ErrorCount
          ,le.FIC_FIL_NAME_LENGTHS_ErrorCount
          ,le.FIC_FIL_DATE_CUSTOM_ErrorCount
          ,le.FIC_OWNER_DOC_NUM_LENGTHS_ErrorCount
          ,le.FIC_OWNER_NAME_LENGTHS_ErrorCount
          ,le.p_owner_name_LENGTHS_ErrorCount
          ,le.c_owner_name_LENGTHS_ErrorCount
          ,le.prep_addr_line1_LENGTHS_ErrorCount
          ,le.prep_addr_line_last_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line1_LENGTHS_ErrorCount
          ,le.prep_owner_addr_line_last_LENGTHS_ErrorCount
          ,le.seq_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_FL_Filing_hygiene(PROJECT(h, Input_FL_Filing_Layout_FBNV2));
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
          ,'FIC_FIL_DOC_NUM:' + getFieldTypeText(h.FIC_FIL_DOC_NUM) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FIC_FIL_NAME:' + getFieldTypeText(h.FIC_FIL_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FIC_FIL_DATE:' + getFieldTypeText(h.FIC_FIL_DATE) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FIC_OWNER_DOC_NUM:' + getFieldTypeText(h.FIC_OWNER_DOC_NUM) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'FIC_OWNER_NAME:' + getFieldTypeText(h.FIC_OWNER_NAME) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_owner_name:' + getFieldTypeText(h.p_owner_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'c_owner_name:' + getFieldTypeText(h.c_owner_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line1:' + getFieldTypeText(h.prep_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_addr_line_last:' + getFieldTypeText(h.prep_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_owner_addr_line1:' + getFieldTypeText(h.prep_owner_addr_line1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prep_owner_addr_line_last:' + getFieldTypeText(h.prep_owner_addr_line_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'seq:' + getFieldTypeText(h.seq) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_FIC_FIL_DOC_NUM_cnt
          ,le.populated_FIC_FIL_NAME_cnt
          ,le.populated_FIC_FIL_DATE_cnt
          ,le.populated_FIC_OWNER_DOC_NUM_cnt
          ,le.populated_FIC_OWNER_NAME_cnt
          ,le.populated_p_owner_name_cnt
          ,le.populated_c_owner_name_cnt
          ,le.populated_prep_addr_line1_cnt
          ,le.populated_prep_addr_line_last_cnt
          ,le.populated_prep_owner_addr_line1_cnt
          ,le.populated_prep_owner_addr_line_last_cnt
          ,le.populated_seq_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_FIC_FIL_DOC_NUM_pcnt
          ,le.populated_FIC_FIL_NAME_pcnt
          ,le.populated_FIC_FIL_DATE_pcnt
          ,le.populated_FIC_OWNER_DOC_NUM_pcnt
          ,le.populated_FIC_OWNER_NAME_pcnt
          ,le.populated_p_owner_name_pcnt
          ,le.populated_c_owner_name_pcnt
          ,le.populated_prep_addr_line1_pcnt
          ,le.populated_prep_addr_line_last_pcnt
          ,le.populated_prep_owner_addr_line1_pcnt
          ,le.populated_prep_owner_addr_line_last_pcnt
          ,le.populated_seq_pcnt,0);
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
 
    mod_Delta := Input_FL_Filing_Delta(prevDS, PROJECT(h, Input_FL_Filing_Layout_FBNV2));
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
 
EXPORT StandardStats(DATASET(Input_FL_Filing_Layout_FBNV2) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FBNV2, Input_FL_Filing_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
