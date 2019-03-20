IMPORT SALT311,STD;
EXPORT Scrubs := MODULE

// The module to handle the case where no scrubs exist
  EXPORT NumRules := 21;
  EXPORT NumRulesFromFieldType := 21;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 11;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_Cortera_Tradeline)
    UNSIGNED1 link_id_Invalid;
    UNSIGNED1 ar_date_Invalid;
    UNSIGNED1 total_ar_Invalid;
    UNSIGNED1 current_ar_Invalid;
    UNSIGNED1 aging_1to30_Invalid;
    UNSIGNED1 aging_31to60_Invalid;
    UNSIGNED1 aging_61to90_Invalid;
    UNSIGNED1 aging_91plus_Invalid;
    UNSIGNED1 credit_limit_Invalid;
    UNSIGNED1 first_sale_date_Invalid;
    UNSIGNED1 last_sale_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_Cortera_Tradeline)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_Cortera_Tradeline) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.link_id_Invalid := Fields.InValid_link_id((SALT311.StrType)le.link_id);
    SELF.ar_date_Invalid := Fields.InValid_ar_date((SALT311.StrType)le.ar_date);
    SELF.total_ar_Invalid := Fields.InValid_total_ar((SALT311.StrType)le.total_ar);
    SELF.current_ar_Invalid := Fields.InValid_current_ar((SALT311.StrType)le.current_ar);
    SELF.aging_1to30_Invalid := Fields.InValid_aging_1to30((SALT311.StrType)le.aging_1to30);
    SELF.aging_31to60_Invalid := Fields.InValid_aging_31to60((SALT311.StrType)le.aging_31to60);
    SELF.aging_61to90_Invalid := Fields.InValid_aging_61to90((SALT311.StrType)le.aging_61to90);
    SELF.aging_91plus_Invalid := Fields.InValid_aging_91plus((SALT311.StrType)le.aging_91plus);
    SELF.credit_limit_Invalid := Fields.InValid_credit_limit((SALT311.StrType)le.credit_limit);
    SELF.first_sale_date_Invalid := Fields.InValid_first_sale_date((SALT311.StrType)le.first_sale_date);
    SELF.last_sale_date_Invalid := Fields.InValid_last_sale_date((SALT311.StrType)le.last_sale_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_Cortera_Tradeline);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.link_id_Invalid << 0 ) + ( le.ar_date_Invalid << 1 ) + ( le.total_ar_Invalid << 3 ) + ( le.current_ar_Invalid << 5 ) + ( le.aging_1to30_Invalid << 7 ) + ( le.aging_31to60_Invalid << 9 ) + ( le.aging_61to90_Invalid << 11 ) + ( le.aging_91plus_Invalid << 13 ) + ( le.credit_limit_Invalid << 15 ) + ( le.first_sale_date_Invalid << 17 ) + ( le.last_sale_date_Invalid << 19 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_Cortera_Tradeline);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.link_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.ar_date_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.total_ar_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.current_ar_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.aging_1to30_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.aging_31to60_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.aging_61to90_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.aging_91plus_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.credit_limit_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.first_sale_date_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.last_sale_date_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    link_id_ALLOW_ErrorCount := COUNT(GROUP,h.link_id_Invalid=1);
    ar_date_ALLOW_ErrorCount := COUNT(GROUP,h.ar_date_Invalid=1);
    ar_date_LENGTHS_ErrorCount := COUNT(GROUP,h.ar_date_Invalid=2);
    ar_date_Total_ErrorCount := COUNT(GROUP,h.ar_date_Invalid>0);
    total_ar_ALLOW_ErrorCount := COUNT(GROUP,h.total_ar_Invalid=1);
    total_ar_LENGTHS_ErrorCount := COUNT(GROUP,h.total_ar_Invalid=2);
    total_ar_Total_ErrorCount := COUNT(GROUP,h.total_ar_Invalid>0);
    current_ar_ALLOW_ErrorCount := COUNT(GROUP,h.current_ar_Invalid=1);
    current_ar_LENGTHS_ErrorCount := COUNT(GROUP,h.current_ar_Invalid=2);
    current_ar_Total_ErrorCount := COUNT(GROUP,h.current_ar_Invalid>0);
    aging_1to30_ALLOW_ErrorCount := COUNT(GROUP,h.aging_1to30_Invalid=1);
    aging_1to30_LENGTHS_ErrorCount := COUNT(GROUP,h.aging_1to30_Invalid=2);
    aging_1to30_Total_ErrorCount := COUNT(GROUP,h.aging_1to30_Invalid>0);
    aging_31to60_ALLOW_ErrorCount := COUNT(GROUP,h.aging_31to60_Invalid=1);
    aging_31to60_LENGTHS_ErrorCount := COUNT(GROUP,h.aging_31to60_Invalid=2);
    aging_31to60_Total_ErrorCount := COUNT(GROUP,h.aging_31to60_Invalid>0);
    aging_61to90_ALLOW_ErrorCount := COUNT(GROUP,h.aging_61to90_Invalid=1);
    aging_61to90_LENGTHS_ErrorCount := COUNT(GROUP,h.aging_61to90_Invalid=2);
    aging_61to90_Total_ErrorCount := COUNT(GROUP,h.aging_61to90_Invalid>0);
    aging_91plus_ALLOW_ErrorCount := COUNT(GROUP,h.aging_91plus_Invalid=1);
    aging_91plus_LENGTHS_ErrorCount := COUNT(GROUP,h.aging_91plus_Invalid=2);
    aging_91plus_Total_ErrorCount := COUNT(GROUP,h.aging_91plus_Invalid>0);
    credit_limit_ALLOW_ErrorCount := COUNT(GROUP,h.credit_limit_Invalid=1);
    credit_limit_LENGTHS_ErrorCount := COUNT(GROUP,h.credit_limit_Invalid=2);
    credit_limit_Total_ErrorCount := COUNT(GROUP,h.credit_limit_Invalid>0);
    first_sale_date_ALLOW_ErrorCount := COUNT(GROUP,h.first_sale_date_Invalid=1);
    first_sale_date_LENGTHS_ErrorCount := COUNT(GROUP,h.first_sale_date_Invalid=2);
    first_sale_date_Total_ErrorCount := COUNT(GROUP,h.first_sale_date_Invalid>0);
    last_sale_date_ALLOW_ErrorCount := COUNT(GROUP,h.last_sale_date_Invalid=1);
    last_sale_date_LENGTHS_ErrorCount := COUNT(GROUP,h.last_sale_date_Invalid=2);
    last_sale_date_Total_ErrorCount := COUNT(GROUP,h.last_sale_date_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.link_id_Invalid > 0 OR h.ar_date_Invalid > 0 OR h.total_ar_Invalid > 0 OR h.current_ar_Invalid > 0 OR h.aging_1to30_Invalid > 0 OR h.aging_31to60_Invalid > 0 OR h.aging_61to90_Invalid > 0 OR h.aging_91plus_Invalid > 0 OR h.credit_limit_Invalid > 0 OR h.first_sale_date_Invalid > 0 OR h.last_sale_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.link_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ar_date_Total_ErrorCount > 0, 1, 0) + IF(le.total_ar_Total_ErrorCount > 0, 1, 0) + IF(le.current_ar_Total_ErrorCount > 0, 1, 0) + IF(le.aging_1to30_Total_ErrorCount > 0, 1, 0) + IF(le.aging_31to60_Total_ErrorCount > 0, 1, 0) + IF(le.aging_61to90_Total_ErrorCount > 0, 1, 0) + IF(le.aging_91plus_Total_ErrorCount > 0, 1, 0) + IF(le.credit_limit_Total_ErrorCount > 0, 1, 0) + IF(le.first_sale_date_Total_ErrorCount > 0, 1, 0) + IF(le.last_sale_date_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.link_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ar_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ar_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.total_ar_ALLOW_ErrorCount > 0, 1, 0) + IF(le.total_ar_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.current_ar_ALLOW_ErrorCount > 0, 1, 0) + IF(le.current_ar_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aging_1to30_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aging_1to30_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aging_31to60_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aging_31to60_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aging_61to90_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aging_61to90_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.aging_91plus_ALLOW_ErrorCount > 0, 1, 0) + IF(le.aging_91plus_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.credit_limit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.credit_limit_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.first_sale_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_sale_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.last_sale_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_sale_date_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.link_id_Invalid,le.ar_date_Invalid,le.total_ar_Invalid,le.current_ar_Invalid,le.aging_1to30_Invalid,le.aging_31to60_Invalid,le.aging_61to90_Invalid,le.aging_91plus_Invalid,le.credit_limit_Invalid,le.first_sale_date_Invalid,le.last_sale_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_link_id(le.link_id_Invalid),Fields.InvalidMessage_ar_date(le.ar_date_Invalid),Fields.InvalidMessage_total_ar(le.total_ar_Invalid),Fields.InvalidMessage_current_ar(le.current_ar_Invalid),Fields.InvalidMessage_aging_1to30(le.aging_1to30_Invalid),Fields.InvalidMessage_aging_31to60(le.aging_31to60_Invalid),Fields.InvalidMessage_aging_61to90(le.aging_61to90_Invalid),Fields.InvalidMessage_aging_91plus(le.aging_91plus_Invalid),Fields.InvalidMessage_credit_limit(le.credit_limit_Invalid),Fields.InvalidMessage_first_sale_date(le.first_sale_date_Invalid),Fields.InvalidMessage_last_sale_date(le.last_sale_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.link_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.ar_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.total_ar_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.current_ar_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aging_1to30_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aging_31to60_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aging_61to90_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.aging_91plus_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.credit_limit_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.first_sale_date_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.last_sale_date_Invalid,'ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'link_id','ar_date','total_ar','current_ar','aging_1to30','aging_31to60','aging_61to90','aging_91plus','credit_limit','first_sale_date','last_sale_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'numeric','date','number','number','number','number','number','number','number','date','date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.link_id,(SALT311.StrType)le.ar_date,(SALT311.StrType)le.total_ar,(SALT311.StrType)le.current_ar,(SALT311.StrType)le.aging_1to30,(SALT311.StrType)le.aging_31to60,(SALT311.StrType)le.aging_61to90,(SALT311.StrType)le.aging_91plus,(SALT311.StrType)le.credit_limit,(SALT311.StrType)le.first_sale_date,(SALT311.StrType)le.last_sale_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,11,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_Cortera_Tradeline) prevDS = DATASET([], Layout_Cortera_Tradeline), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'link_id:numeric:ALLOW'
          ,'ar_date:date:ALLOW','ar_date:date:LENGTHS'
          ,'total_ar:number:ALLOW','total_ar:number:LENGTHS'
          ,'current_ar:number:ALLOW','current_ar:number:LENGTHS'
          ,'aging_1to30:number:ALLOW','aging_1to30:number:LENGTHS'
          ,'aging_31to60:number:ALLOW','aging_31to60:number:LENGTHS'
          ,'aging_61to90:number:ALLOW','aging_61to90:number:LENGTHS'
          ,'aging_91plus:number:ALLOW','aging_91plus:number:LENGTHS'
          ,'credit_limit:number:ALLOW','credit_limit:number:LENGTHS'
          ,'first_sale_date:date:ALLOW','first_sale_date:date:LENGTHS'
          ,'last_sale_date:date:ALLOW','last_sale_date:date:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_link_id(1)
          ,Fields.InvalidMessage_ar_date(1),Fields.InvalidMessage_ar_date(2)
          ,Fields.InvalidMessage_total_ar(1),Fields.InvalidMessage_total_ar(2)
          ,Fields.InvalidMessage_current_ar(1),Fields.InvalidMessage_current_ar(2)
          ,Fields.InvalidMessage_aging_1to30(1),Fields.InvalidMessage_aging_1to30(2)
          ,Fields.InvalidMessage_aging_31to60(1),Fields.InvalidMessage_aging_31to60(2)
          ,Fields.InvalidMessage_aging_61to90(1),Fields.InvalidMessage_aging_61to90(2)
          ,Fields.InvalidMessage_aging_91plus(1),Fields.InvalidMessage_aging_91plus(2)
          ,Fields.InvalidMessage_credit_limit(1),Fields.InvalidMessage_credit_limit(2)
          ,Fields.InvalidMessage_first_sale_date(1),Fields.InvalidMessage_first_sale_date(2)
          ,Fields.InvalidMessage_last_sale_date(1),Fields.InvalidMessage_last_sale_date(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.link_id_ALLOW_ErrorCount
          ,le.ar_date_ALLOW_ErrorCount,le.ar_date_LENGTHS_ErrorCount
          ,le.total_ar_ALLOW_ErrorCount,le.total_ar_LENGTHS_ErrorCount
          ,le.current_ar_ALLOW_ErrorCount,le.current_ar_LENGTHS_ErrorCount
          ,le.aging_1to30_ALLOW_ErrorCount,le.aging_1to30_LENGTHS_ErrorCount
          ,le.aging_31to60_ALLOW_ErrorCount,le.aging_31to60_LENGTHS_ErrorCount
          ,le.aging_61to90_ALLOW_ErrorCount,le.aging_61to90_LENGTHS_ErrorCount
          ,le.aging_91plus_ALLOW_ErrorCount,le.aging_91plus_LENGTHS_ErrorCount
          ,le.credit_limit_ALLOW_ErrorCount,le.credit_limit_LENGTHS_ErrorCount
          ,le.first_sale_date_ALLOW_ErrorCount,le.first_sale_date_LENGTHS_ErrorCount
          ,le.last_sale_date_ALLOW_ErrorCount,le.last_sale_date_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.link_id_ALLOW_ErrorCount
          ,le.ar_date_ALLOW_ErrorCount,le.ar_date_LENGTHS_ErrorCount
          ,le.total_ar_ALLOW_ErrorCount,le.total_ar_LENGTHS_ErrorCount
          ,le.current_ar_ALLOW_ErrorCount,le.current_ar_LENGTHS_ErrorCount
          ,le.aging_1to30_ALLOW_ErrorCount,le.aging_1to30_LENGTHS_ErrorCount
          ,le.aging_31to60_ALLOW_ErrorCount,le.aging_31to60_LENGTHS_ErrorCount
          ,le.aging_61to90_ALLOW_ErrorCount,le.aging_61to90_LENGTHS_ErrorCount
          ,le.aging_91plus_ALLOW_ErrorCount,le.aging_91plus_LENGTHS_ErrorCount
          ,le.credit_limit_ALLOW_ErrorCount,le.credit_limit_LENGTHS_ErrorCount
          ,le.first_sale_date_ALLOW_ErrorCount,le.first_sale_date_LENGTHS_ErrorCount
          ,le.last_sale_date_ALLOW_ErrorCount,le.last_sale_date_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_Cortera_Tradeline));
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
          ,'link_id:' + getFieldTypeText(h.link_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'account_key:' + getFieldTypeText(h.account_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'segment_id:' + getFieldTypeText(h.segment_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ar_date:' + getFieldTypeText(h.ar_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'total_ar:' + getFieldTypeText(h.total_ar) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_ar:' + getFieldTypeText(h.current_ar) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aging_1to30:' + getFieldTypeText(h.aging_1to30) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aging_31to60:' + getFieldTypeText(h.aging_31to60) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aging_61to90:' + getFieldTypeText(h.aging_61to90) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aging_91plus:' + getFieldTypeText(h.aging_91plus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'credit_limit:' + getFieldTypeText(h.credit_limit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_sale_date:' + getFieldTypeText(h.first_sale_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_sale_date:' + getFieldTypeText(h.last_sale_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_link_id_cnt
          ,le.populated_account_key_cnt
          ,le.populated_segment_id_cnt
          ,le.populated_ar_date_cnt
          ,le.populated_total_ar_cnt
          ,le.populated_current_ar_cnt
          ,le.populated_aging_1to30_cnt
          ,le.populated_aging_31to60_cnt
          ,le.populated_aging_61to90_cnt
          ,le.populated_aging_91plus_cnt
          ,le.populated_credit_limit_cnt
          ,le.populated_first_sale_date_cnt
          ,le.populated_last_sale_date_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_link_id_pcnt
          ,le.populated_account_key_pcnt
          ,le.populated_segment_id_pcnt
          ,le.populated_ar_date_pcnt
          ,le.populated_total_ar_pcnt
          ,le.populated_current_ar_pcnt
          ,le.populated_aging_1to30_pcnt
          ,le.populated_aging_31to60_pcnt
          ,le.populated_aging_61to90_pcnt
          ,le.populated_aging_91plus_pcnt
          ,le.populated_credit_limit_pcnt
          ,le.populated_first_sale_date_pcnt
          ,le.populated_last_sale_date_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,13,xNormHygieneStats(LEFT,COUNTER,'POP'));

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

    mod_Delta := Delta(prevDS, PROJECT(h, Layout_Cortera_Tradeline));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),13,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);

    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;

EXPORT StandardStats(DATASET(Layout_Cortera_Tradeline) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;

  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Cortera_Tradeline, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
