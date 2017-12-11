IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT incident_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 13;
  EXPORT NumRulesFromFieldType := 13;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 12;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(incident_Layout_SANCTNKeys)
    UNSIGNED1 batch_number_Invalid;
    UNSIGNED1 incident_number_Invalid;
    UNSIGNED1 party_number_Invalid;
    UNSIGNED1 order_number_Invalid;
    UNSIGNED1 incident_date_Invalid;
    UNSIGNED1 fcr_date_Invalid;
    UNSIGNED1 modified_date_Invalid;
    UNSIGNED1 load_date_Invalid;
    UNSIGNED1 incident_date_clean_Invalid;
    UNSIGNED1 fcr_date_clean_Invalid;
    UNSIGNED1 cln_modified_date_Invalid;
    UNSIGNED1 cln_load_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(incident_Layout_SANCTNKeys)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(incident_Layout_SANCTNKeys) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.batch_number_Invalid := incident_Fields.InValid_batch_number((SALT38.StrType)le.batch_number);
    SELF.incident_number_Invalid := incident_Fields.InValid_incident_number((SALT38.StrType)le.incident_number);
    SELF.party_number_Invalid := incident_Fields.InValid_party_number((SALT38.StrType)le.party_number);
    SELF.order_number_Invalid := incident_Fields.InValid_order_number((SALT38.StrType)le.order_number);
    SELF.incident_date_Invalid := incident_Fields.InValid_incident_date((SALT38.StrType)le.incident_date);
    SELF.fcr_date_Invalid := incident_Fields.InValid_fcr_date((SALT38.StrType)le.fcr_date);
    SELF.modified_date_Invalid := incident_Fields.InValid_modified_date((SALT38.StrType)le.modified_date);
    SELF.load_date_Invalid := incident_Fields.InValid_load_date((SALT38.StrType)le.load_date);
    SELF.incident_date_clean_Invalid := incident_Fields.InValid_incident_date_clean((SALT38.StrType)le.incident_date_clean);
    SELF.fcr_date_clean_Invalid := incident_Fields.InValid_fcr_date_clean((SALT38.StrType)le.fcr_date_clean);
    SELF.cln_modified_date_Invalid := incident_Fields.InValid_cln_modified_date((SALT38.StrType)le.cln_modified_date);
    SELF.cln_load_date_Invalid := incident_Fields.InValid_cln_load_date((SALT38.StrType)le.cln_load_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),incident_Layout_SANCTNKeys);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.batch_number_Invalid << 0 ) + ( le.incident_number_Invalid << 2 ) + ( le.party_number_Invalid << 3 ) + ( le.order_number_Invalid << 4 ) + ( le.incident_date_Invalid << 5 ) + ( le.fcr_date_Invalid << 6 ) + ( le.modified_date_Invalid << 7 ) + ( le.load_date_Invalid << 8 ) + ( le.incident_date_clean_Invalid << 9 ) + ( le.fcr_date_clean_Invalid << 10 ) + ( le.cln_modified_date_Invalid << 11 ) + ( le.cln_load_date_Invalid << 12 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,incident_Layout_SANCTNKeys);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.batch_number_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.incident_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.party_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.order_number_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.incident_date_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.fcr_date_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.modified_date_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.load_date_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.incident_date_clean_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.fcr_date_clean_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.cln_modified_date_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.cln_load_date_Invalid := (le.ScrubsBits1 >> 12) & 1;
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
    incident_date_ALLOW_ErrorCount := COUNT(GROUP,h.incident_date_Invalid=1);
    fcr_date_ALLOW_ErrorCount := COUNT(GROUP,h.fcr_date_Invalid=1);
    modified_date_ALLOW_ErrorCount := COUNT(GROUP,h.modified_date_Invalid=1);
    load_date_ALLOW_ErrorCount := COUNT(GROUP,h.load_date_Invalid=1);
    incident_date_clean_CUSTOM_ErrorCount := COUNT(GROUP,h.incident_date_clean_Invalid=1);
    fcr_date_clean_CUSTOM_ErrorCount := COUNT(GROUP,h.fcr_date_clean_Invalid=1);
    cln_modified_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cln_modified_date_Invalid=1);
    cln_load_date_CUSTOM_ErrorCount := COUNT(GROUP,h.cln_load_date_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.batch_number_Invalid > 0 OR h.incident_number_Invalid > 0 OR h.party_number_Invalid > 0 OR h.order_number_Invalid > 0 OR h.incident_date_Invalid > 0 OR h.fcr_date_Invalid > 0 OR h.modified_date_Invalid > 0 OR h.load_date_Invalid > 0 OR h.incident_date_clean_Invalid > 0 OR h.fcr_date_clean_Invalid > 0 OR h.cln_modified_date_Invalid > 0 OR h.cln_load_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.batch_number_Total_ErrorCount > 0, 1, 0) + IF(le.incident_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.order_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.incident_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fcr_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.modified_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.load_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.incident_date_clean_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcr_date_clean_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_modified_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_load_date_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.batch_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_number_LENGTH_ErrorCount > 0, 1, 0) + IF(le.incident_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.party_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.order_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.incident_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fcr_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.modified_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.load_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.incident_date_clean_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fcr_date_clean_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_modified_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.cln_load_date_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.batch_number_Invalid,le.incident_number_Invalid,le.party_number_Invalid,le.order_number_Invalid,le.incident_date_Invalid,le.fcr_date_Invalid,le.modified_date_Invalid,le.load_date_Invalid,le.incident_date_clean_Invalid,le.fcr_date_clean_Invalid,le.cln_modified_date_Invalid,le.cln_load_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,incident_Fields.InvalidMessage_batch_number(le.batch_number_Invalid),incident_Fields.InvalidMessage_incident_number(le.incident_number_Invalid),incident_Fields.InvalidMessage_party_number(le.party_number_Invalid),incident_Fields.InvalidMessage_order_number(le.order_number_Invalid),incident_Fields.InvalidMessage_incident_date(le.incident_date_Invalid),incident_Fields.InvalidMessage_fcr_date(le.fcr_date_Invalid),incident_Fields.InvalidMessage_modified_date(le.modified_date_Invalid),incident_Fields.InvalidMessage_load_date(le.load_date_Invalid),incident_Fields.InvalidMessage_incident_date_clean(le.incident_date_clean_Invalid),incident_Fields.InvalidMessage_fcr_date_clean(le.fcr_date_clean_Invalid),incident_Fields.InvalidMessage_cln_modified_date(le.cln_modified_date_Invalid),incident_Fields.InvalidMessage_cln_load_date(le.cln_load_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.batch_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.incident_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.party_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.order_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.incident_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fcr_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.modified_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.load_date_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.incident_date_clean_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fcr_date_clean_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_modified_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.cln_load_date_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'batch_number','incident_number','party_number','order_number','incident_date','fcr_date','modified_date','load_date','incident_date_clean','fcr_date_clean','cln_modified_date','cln_load_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Batch','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_CleanDate','Invalid_CleanDate','Invalid_CleanDate','Invalid_CleanDate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.batch_number,(SALT38.StrType)le.incident_number,(SALT38.StrType)le.party_number,(SALT38.StrType)le.order_number,(SALT38.StrType)le.incident_date,(SALT38.StrType)le.fcr_date,(SALT38.StrType)le.modified_date,(SALT38.StrType)le.load_date,(SALT38.StrType)le.incident_date_clean,(SALT38.StrType)le.fcr_date_clean,(SALT38.StrType)le.cln_modified_date,(SALT38.StrType)le.cln_load_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,12,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(incident_Layout_SANCTNKeys) prevDS = DATASET([], incident_Layout_SANCTNKeys), STRING10 Src='UNK'):= FUNCTION
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
          ,'incident_date:Invalid_Date:ALLOW'
          ,'fcr_date:Invalid_Date:ALLOW'
          ,'modified_date:Invalid_Date:ALLOW'
          ,'load_date:Invalid_Date:ALLOW'
          ,'incident_date_clean:Invalid_CleanDate:CUSTOM'
          ,'fcr_date_clean:Invalid_CleanDate:CUSTOM'
          ,'cln_modified_date:Invalid_CleanDate:CUSTOM'
          ,'cln_load_date:Invalid_CleanDate:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,incident_Fields.InvalidMessage_batch_number(1),incident_Fields.InvalidMessage_batch_number(2)
          ,incident_Fields.InvalidMessage_incident_number(1)
          ,incident_Fields.InvalidMessage_party_number(1)
          ,incident_Fields.InvalidMessage_order_number(1)
          ,incident_Fields.InvalidMessage_incident_date(1)
          ,incident_Fields.InvalidMessage_fcr_date(1)
          ,incident_Fields.InvalidMessage_modified_date(1)
          ,incident_Fields.InvalidMessage_load_date(1)
          ,incident_Fields.InvalidMessage_incident_date_clean(1)
          ,incident_Fields.InvalidMessage_fcr_date_clean(1)
          ,incident_Fields.InvalidMessage_cln_modified_date(1)
          ,incident_Fields.InvalidMessage_cln_load_date(1)
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
          ,le.incident_date_ALLOW_ErrorCount
          ,le.fcr_date_ALLOW_ErrorCount
          ,le.modified_date_ALLOW_ErrorCount
          ,le.load_date_ALLOW_ErrorCount
          ,le.incident_date_clean_CUSTOM_ErrorCount
          ,le.fcr_date_clean_CUSTOM_ErrorCount
          ,le.cln_modified_date_CUSTOM_ErrorCount
          ,le.cln_load_date_CUSTOM_ErrorCount
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
          ,le.incident_date_ALLOW_ErrorCount
          ,le.fcr_date_ALLOW_ErrorCount
          ,le.modified_date_ALLOW_ErrorCount
          ,le.load_date_ALLOW_ErrorCount
          ,le.incident_date_clean_CUSTOM_ErrorCount
          ,le.fcr_date_clean_CUSTOM_ErrorCount
          ,le.cln_modified_date_CUSTOM_ErrorCount
          ,le.cln_load_date_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := incident_hygiene(PROJECT(h, incident_Layout_SANCTNKeys));
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
          ,'ag_code:' + getFieldTypeText(h.ag_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'case_number:' + getFieldTypeText(h.case_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incident_date:' + getFieldTypeText(h.incident_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'jurisdiction:' + getFieldTypeText(h.jurisdiction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_document:' + getFieldTypeText(h.source_document) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'additional_info:' + getFieldTypeText(h.additional_info) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'agency:' + getFieldTypeText(h.agency) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'alleged_amount:' + getFieldTypeText(h.alleged_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'estimated_loss:' + getFieldTypeText(h.estimated_loss) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcr_date:' + getFieldTypeText(h.fcr_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ok_for_fcr:' + getFieldTypeText(h.ok_for_fcr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'modified_date:' + getFieldTypeText(h.modified_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'load_date:' + getFieldTypeText(h.load_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incident_text:' + getFieldTypeText(h.incident_text) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incident_date_clean:' + getFieldTypeText(h.incident_date_clean) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fcr_date_clean:' + getFieldTypeText(h.fcr_date_clean) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_modified_date:' + getFieldTypeText(h.cln_modified_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cln_load_date:' + getFieldTypeText(h.cln_load_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_batch_number_cnt
          ,le.populated_incident_number_cnt
          ,le.populated_party_number_cnt
          ,le.populated_record_type_cnt
          ,le.populated_order_number_cnt
          ,le.populated_ag_code_cnt
          ,le.populated_case_number_cnt
          ,le.populated_incident_date_cnt
          ,le.populated_jurisdiction_cnt
          ,le.populated_source_document_cnt
          ,le.populated_additional_info_cnt
          ,le.populated_agency_cnt
          ,le.populated_alleged_amount_cnt
          ,le.populated_estimated_loss_cnt
          ,le.populated_fcr_date_cnt
          ,le.populated_ok_for_fcr_cnt
          ,le.populated_modified_date_cnt
          ,le.populated_load_date_cnt
          ,le.populated_incident_text_cnt
          ,le.populated_incident_date_clean_cnt
          ,le.populated_fcr_date_clean_cnt
          ,le.populated_cln_modified_date_cnt
          ,le.populated_cln_load_date_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_batch_number_pcnt
          ,le.populated_incident_number_pcnt
          ,le.populated_party_number_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_order_number_pcnt
          ,le.populated_ag_code_pcnt
          ,le.populated_case_number_pcnt
          ,le.populated_incident_date_pcnt
          ,le.populated_jurisdiction_pcnt
          ,le.populated_source_document_pcnt
          ,le.populated_additional_info_pcnt
          ,le.populated_agency_pcnt
          ,le.populated_alleged_amount_pcnt
          ,le.populated_estimated_loss_pcnt
          ,le.populated_fcr_date_pcnt
          ,le.populated_ok_for_fcr_pcnt
          ,le.populated_modified_date_pcnt
          ,le.populated_load_date_pcnt
          ,le.populated_incident_text_pcnt
          ,le.populated_incident_date_clean_pcnt
          ,le.populated_fcr_date_clean_pcnt
          ,le.populated_cln_modified_date_pcnt
          ,le.populated_cln_load_date_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,23,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := incident_Delta(prevDS, PROJECT(h, incident_Layout_SANCTNKeys));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),23,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(incident_Layout_SANCTNKeys) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_SANCTNKeys, incident_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
