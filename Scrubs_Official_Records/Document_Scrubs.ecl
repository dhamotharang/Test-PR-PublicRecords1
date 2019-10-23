IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Official_Records; // Import modules for FieldTypes attribute definitions
EXPORT Document_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 15;
  EXPORT NumRulesFromFieldType := 15;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 15;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Document_Layout_Official_Records)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 vendor_Invalid;
    UNSIGNED1 state_origin_Invalid;
    UNSIGNED1 county_name_Invalid;
    UNSIGNED1 official_record_key_Invalid;
    UNSIGNED1 fips_st_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 batch_id_Invalid;
    UNSIGNED1 doc_serial_num_Invalid;
    UNSIGNED1 doc_instrument_or_clerk_filing_num_Invalid;
    UNSIGNED1 doc_filed_dt_Invalid;
    UNSIGNED1 doc_record_dt_Invalid;
    UNSIGNED1 doc_page_count_Invalid;
    UNSIGNED1 doc_names_count_Invalid;
    UNSIGNED1 execution_dt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Document_Layout_Official_Records)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Document_Layout_Official_Records) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Document_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.vendor_Invalid := Document_Fields.InValid_vendor((SALT311.StrType)le.vendor);
    SELF.state_origin_Invalid := Document_Fields.InValid_state_origin((SALT311.StrType)le.state_origin);
    SELF.county_name_Invalid := Document_Fields.InValid_county_name((SALT311.StrType)le.county_name);
    SELF.official_record_key_Invalid := Document_Fields.InValid_official_record_key((SALT311.StrType)le.official_record_key);
    SELF.fips_st_Invalid := Document_Fields.InValid_fips_st((SALT311.StrType)le.fips_st);
    SELF.fips_county_Invalid := Document_Fields.InValid_fips_county((SALT311.StrType)le.fips_county);
    SELF.batch_id_Invalid := Document_Fields.InValid_batch_id((SALT311.StrType)le.batch_id);
    SELF.doc_serial_num_Invalid := Document_Fields.InValid_doc_serial_num((SALT311.StrType)le.doc_serial_num);
    SELF.doc_instrument_or_clerk_filing_num_Invalid := Document_Fields.InValid_doc_instrument_or_clerk_filing_num((SALT311.StrType)le.doc_instrument_or_clerk_filing_num);
    SELF.doc_filed_dt_Invalid := Document_Fields.InValid_doc_filed_dt((SALT311.StrType)le.doc_filed_dt);
    SELF.doc_record_dt_Invalid := Document_Fields.InValid_doc_record_dt((SALT311.StrType)le.doc_record_dt);
    SELF.doc_page_count_Invalid := Document_Fields.InValid_doc_page_count((SALT311.StrType)le.doc_page_count);
    SELF.doc_names_count_Invalid := Document_Fields.InValid_doc_names_count((SALT311.StrType)le.doc_names_count);
    SELF.execution_dt_Invalid := Document_Fields.InValid_execution_dt((SALT311.StrType)le.execution_dt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Document_Layout_Official_Records);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.vendor_Invalid << 1 ) + ( le.state_origin_Invalid << 2 ) + ( le.county_name_Invalid << 3 ) + ( le.official_record_key_Invalid << 4 ) + ( le.fips_st_Invalid << 5 ) + ( le.fips_county_Invalid << 6 ) + ( le.batch_id_Invalid << 7 ) + ( le.doc_serial_num_Invalid << 8 ) + ( le.doc_instrument_or_clerk_filing_num_Invalid << 9 ) + ( le.doc_filed_dt_Invalid << 10 ) + ( le.doc_record_dt_Invalid << 11 ) + ( le.doc_page_count_Invalid << 12 ) + ( le.doc_names_count_Invalid << 13 ) + ( le.execution_dt_Invalid << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Document_Layout_Official_Records);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.vendor_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.state_origin_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.county_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.official_record_key_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.fips_st_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.fips_county_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.batch_id_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.doc_serial_num_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.doc_instrument_or_clerk_filing_num_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.doc_filed_dt_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.doc_record_dt_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.doc_page_count_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.doc_names_count_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.execution_dt_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    vendor_ALLOW_ErrorCount := COUNT(GROUP,h.vendor_Invalid=1);
    state_origin_ENUM_ErrorCount := COUNT(GROUP,h.state_origin_Invalid=1);
    county_name_CUSTOM_ErrorCount := COUNT(GROUP,h.county_name_Invalid=1);
    official_record_key_LENGTHS_ErrorCount := COUNT(GROUP,h.official_record_key_Invalid=1);
    fips_st_ALLOW_ErrorCount := COUNT(GROUP,h.fips_st_Invalid=1);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    batch_id_ALLOW_ErrorCount := COUNT(GROUP,h.batch_id_Invalid=1);
    doc_serial_num_ALLOW_ErrorCount := COUNT(GROUP,h.doc_serial_num_Invalid=1);
    doc_instrument_or_clerk_filing_num_LENGTHS_ErrorCount := COUNT(GROUP,h.doc_instrument_or_clerk_filing_num_Invalid=1);
    doc_filed_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.doc_filed_dt_Invalid=1);
    doc_record_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.doc_record_dt_Invalid=1);
    doc_page_count_ALLOW_ErrorCount := COUNT(GROUP,h.doc_page_count_Invalid=1);
    doc_names_count_ALLOW_ErrorCount := COUNT(GROUP,h.doc_names_count_Invalid=1);
    execution_dt_CUSTOM_ErrorCount := COUNT(GROUP,h.execution_dt_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.vendor_Invalid > 0 OR h.state_origin_Invalid > 0 OR h.county_name_Invalid > 0 OR h.official_record_key_Invalid > 0 OR h.fips_st_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.batch_id_Invalid > 0 OR h.doc_serial_num_Invalid > 0 OR h.doc_instrument_or_clerk_filing_num_Invalid > 0 OR h.doc_filed_dt_Invalid > 0 OR h.doc_record_dt_Invalid > 0 OR h.doc_page_count_Invalid > 0 OR h.doc_names_count_Invalid > 0 OR h.execution_dt_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.official_record_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.doc_serial_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.doc_instrument_or_clerk_filing_num_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.doc_filed_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.doc_record_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.doc_page_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.doc_names_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.execution_dt_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.vendor_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_origin_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.official_record_key_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_st_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.doc_serial_num_ALLOW_ErrorCount > 0, 1, 0) + IF(le.doc_instrument_or_clerk_filing_num_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.doc_filed_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.doc_record_dt_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.doc_page_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.doc_names_count_ALLOW_ErrorCount > 0, 1, 0) + IF(le.execution_dt_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.vendor_Invalid,le.state_origin_Invalid,le.county_name_Invalid,le.official_record_key_Invalid,le.fips_st_Invalid,le.fips_county_Invalid,le.batch_id_Invalid,le.doc_serial_num_Invalid,le.doc_instrument_or_clerk_filing_num_Invalid,le.doc_filed_dt_Invalid,le.doc_record_dt_Invalid,le.doc_page_count_Invalid,le.doc_names_count_Invalid,le.execution_dt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Document_Fields.InvalidMessage_process_date(le.process_date_Invalid),Document_Fields.InvalidMessage_vendor(le.vendor_Invalid),Document_Fields.InvalidMessage_state_origin(le.state_origin_Invalid),Document_Fields.InvalidMessage_county_name(le.county_name_Invalid),Document_Fields.InvalidMessage_official_record_key(le.official_record_key_Invalid),Document_Fields.InvalidMessage_fips_st(le.fips_st_Invalid),Document_Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Document_Fields.InvalidMessage_batch_id(le.batch_id_Invalid),Document_Fields.InvalidMessage_doc_serial_num(le.doc_serial_num_Invalid),Document_Fields.InvalidMessage_doc_instrument_or_clerk_filing_num(le.doc_instrument_or_clerk_filing_num_Invalid),Document_Fields.InvalidMessage_doc_filed_dt(le.doc_filed_dt_Invalid),Document_Fields.InvalidMessage_doc_record_dt(le.doc_record_dt_Invalid),Document_Fields.InvalidMessage_doc_page_count(le.doc_page_count_Invalid),Document_Fields.InvalidMessage_doc_names_count(le.doc_names_count_Invalid),Document_Fields.InvalidMessage_execution_dt(le.execution_dt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.vendor_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_origin_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.county_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.official_record_key_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.fips_st_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.batch_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.doc_serial_num_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.doc_instrument_or_clerk_filing_num_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.doc_filed_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.doc_record_dt_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.doc_page_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.doc_names_count_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.execution_dt_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','vendor','state_origin','county_name','official_record_key','fips_st','fips_county','batch_id','doc_serial_num','doc_instrument_or_clerk_filing_num','doc_filed_dt','doc_record_dt','doc_page_count','doc_names_count','execution_dt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Num','Invalid_State','Invalid_County','Invalid_NonBlank','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_NonBlank','Invalid_Date','Invalid_Date','Invalid_Num','Invalid_Num','Invalid_FutureDate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.vendor,(SALT311.StrType)le.state_origin,(SALT311.StrType)le.county_name,(SALT311.StrType)le.official_record_key,(SALT311.StrType)le.fips_st,(SALT311.StrType)le.fips_county,(SALT311.StrType)le.batch_id,(SALT311.StrType)le.doc_serial_num,(SALT311.StrType)le.doc_instrument_or_clerk_filing_num,(SALT311.StrType)le.doc_filed_dt,(SALT311.StrType)le.doc_record_dt,(SALT311.StrType)le.doc_page_count,(SALT311.StrType)le.doc_names_count,(SALT311.StrType)le.execution_dt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,15,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Document_Layout_Official_Records) prevDS = DATASET([], Document_Layout_Official_Records), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:Invalid_Date:CUSTOM'
          ,'vendor:Invalid_Num:ALLOW'
          ,'state_origin:Invalid_State:ENUM'
          ,'county_name:Invalid_County:CUSTOM'
          ,'official_record_key:Invalid_NonBlank:LENGTHS'
          ,'fips_st:Invalid_Num:ALLOW'
          ,'fips_county:Invalid_Num:ALLOW'
          ,'batch_id:Invalid_Num:ALLOW'
          ,'doc_serial_num:Invalid_Num:ALLOW'
          ,'doc_instrument_or_clerk_filing_num:Invalid_NonBlank:LENGTHS'
          ,'doc_filed_dt:Invalid_Date:CUSTOM'
          ,'doc_record_dt:Invalid_Date:CUSTOM'
          ,'doc_page_count:Invalid_Num:ALLOW'
          ,'doc_names_count:Invalid_Num:ALLOW'
          ,'execution_dt:Invalid_FutureDate:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Document_Fields.InvalidMessage_process_date(1)
          ,Document_Fields.InvalidMessage_vendor(1)
          ,Document_Fields.InvalidMessage_state_origin(1)
          ,Document_Fields.InvalidMessage_county_name(1)
          ,Document_Fields.InvalidMessage_official_record_key(1)
          ,Document_Fields.InvalidMessage_fips_st(1)
          ,Document_Fields.InvalidMessage_fips_county(1)
          ,Document_Fields.InvalidMessage_batch_id(1)
          ,Document_Fields.InvalidMessage_doc_serial_num(1)
          ,Document_Fields.InvalidMessage_doc_instrument_or_clerk_filing_num(1)
          ,Document_Fields.InvalidMessage_doc_filed_dt(1)
          ,Document_Fields.InvalidMessage_doc_record_dt(1)
          ,Document_Fields.InvalidMessage_doc_page_count(1)
          ,Document_Fields.InvalidMessage_doc_names_count(1)
          ,Document_Fields.InvalidMessage_execution_dt(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.vendor_ALLOW_ErrorCount
          ,le.state_origin_ENUM_ErrorCount
          ,le.county_name_CUSTOM_ErrorCount
          ,le.official_record_key_LENGTHS_ErrorCount
          ,le.fips_st_ALLOW_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount
          ,le.batch_id_ALLOW_ErrorCount
          ,le.doc_serial_num_ALLOW_ErrorCount
          ,le.doc_instrument_or_clerk_filing_num_LENGTHS_ErrorCount
          ,le.doc_filed_dt_CUSTOM_ErrorCount
          ,le.doc_record_dt_CUSTOM_ErrorCount
          ,le.doc_page_count_ALLOW_ErrorCount
          ,le.doc_names_count_ALLOW_ErrorCount
          ,le.execution_dt_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount
          ,le.vendor_ALLOW_ErrorCount
          ,le.state_origin_ENUM_ErrorCount
          ,le.county_name_CUSTOM_ErrorCount
          ,le.official_record_key_LENGTHS_ErrorCount
          ,le.fips_st_ALLOW_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount
          ,le.batch_id_ALLOW_ErrorCount
          ,le.doc_serial_num_ALLOW_ErrorCount
          ,le.doc_instrument_or_clerk_filing_num_LENGTHS_ErrorCount
          ,le.doc_filed_dt_CUSTOM_ErrorCount
          ,le.doc_record_dt_CUSTOM_ErrorCount
          ,le.doc_page_count_ALLOW_ErrorCount
          ,le.doc_names_count_ALLOW_ErrorCount
          ,le.execution_dt_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Document_hygiene(PROJECT(h, Document_Layout_Official_Records));
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
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state_origin:' + getFieldTypeText(h.state_origin) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'official_record_key:' + getFieldTypeText(h.official_record_key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_st:' + getFieldTypeText(h.fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'batch_id:' + getFieldTypeText(h.batch_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_serial_num:' + getFieldTypeText(h.doc_serial_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_instrument_or_clerk_filing_num:' + getFieldTypeText(h.doc_instrument_or_clerk_filing_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_num_dummy_flag:' + getFieldTypeText(h.doc_num_dummy_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_filed_dt:' + getFieldTypeText(h.doc_filed_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_record_dt:' + getFieldTypeText(h.doc_record_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_type_cd:' + getFieldTypeText(h.doc_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_type_desc:' + getFieldTypeText(h.doc_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_other_desc:' + getFieldTypeText(h.doc_other_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_page_count:' + getFieldTypeText(h.doc_page_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_names_count:' + getFieldTypeText(h.doc_names_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_status_cd:' + getFieldTypeText(h.doc_status_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_status_desc:' + getFieldTypeText(h.doc_status_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_amend_cd:' + getFieldTypeText(h.doc_amend_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_amend_desc:' + getFieldTypeText(h.doc_amend_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'execution_dt:' + getFieldTypeText(h.execution_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'consideration_amt:' + getFieldTypeText(h.consideration_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'assumption_amt:' + getFieldTypeText(h.assumption_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'certified_mail_fee:' + getFieldTypeText(h.certified_mail_fee) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'service_charge:' + getFieldTypeText(h.service_charge) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trust_amt:' + getFieldTypeText(h.trust_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transfer_:' + getFieldTypeText(h.transfer_) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mortgage:' + getFieldTypeText(h.mortgage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'intangible_tax_amt:' + getFieldTypeText(h.intangible_tax_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'intangible_tax_penalty:' + getFieldTypeText(h.intangible_tax_penalty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'excise_tax_amt:' + getFieldTypeText(h.excise_tax_amt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recording_fee:' + getFieldTypeText(h.recording_fee) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'documentary_stamps_fee:' + getFieldTypeText(h.documentary_stamps_fee) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'doc_stamps_mtg_fee:' + getFieldTypeText(h.doc_stamps_mtg_fee) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'book_num:' + getFieldTypeText(h.book_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'page_num:' + getFieldTypeText(h.page_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'book_type_cd:' + getFieldTypeText(h.book_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'book_type_desc:' + getFieldTypeText(h.book_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parcel_or_case_num:' + getFieldTypeText(h.parcel_or_case_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'formatted_parcel_num:' + getFieldTypeText(h.formatted_parcel_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_desc_1:' + getFieldTypeText(h.legal_desc_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_desc_2:' + getFieldTypeText(h.legal_desc_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_desc_3:' + getFieldTypeText(h.legal_desc_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_desc_4:' + getFieldTypeText(h.legal_desc_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'legal_desc_5:' + getFieldTypeText(h.legal_desc_5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'verified_flag:' + getFieldTypeText(h.verified_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_1:' + getFieldTypeText(h.address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_2:' + getFieldTypeText(h.address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_3:' + getFieldTypeText(h.address_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_4:' + getFieldTypeText(h.address_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_doc_file_num:' + getFieldTypeText(h.prior_doc_file_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_doc_type_cd:' + getFieldTypeText(h.prior_doc_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_doc_type_desc:' + getFieldTypeText(h.prior_doc_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_book_num:' + getFieldTypeText(h.prior_book_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_page_num:' + getFieldTypeText(h.prior_page_num) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_book_type_cd:' + getFieldTypeText(h.prior_book_type_cd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prior_book_type_desc:' + getFieldTypeText(h.prior_book_type_desc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addr_suffix:' + getFieldTypeText(h.addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postdir:' + getFieldTypeText(h.postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_desig:' + getFieldTypeText(h.unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sec_range:' + getFieldTypeText(h.sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'p_city_name:' + getFieldTypeText(h.p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'v_city_name:' + getFieldTypeText(h.v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'st:' + getFieldTypeText(h.st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cart:' + getFieldTypeText(h.cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cr_sort_sz:' + getFieldTypeText(h.cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot:' + getFieldTypeText(h.lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lot_order:' + getFieldTypeText(h.lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpbc:' + getFieldTypeText(h.dpbc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chk_digit:' + getFieldTypeText(h.chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_st:' + getFieldTypeText(h.ace_fips_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_fips_county:' + getFieldTypeText(h.ace_fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_vendor_cnt
          ,le.populated_state_origin_cnt
          ,le.populated_county_name_cnt
          ,le.populated_official_record_key_cnt
          ,le.populated_fips_st_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_batch_id_cnt
          ,le.populated_doc_serial_num_cnt
          ,le.populated_doc_instrument_or_clerk_filing_num_cnt
          ,le.populated_doc_num_dummy_flag_cnt
          ,le.populated_doc_filed_dt_cnt
          ,le.populated_doc_record_dt_cnt
          ,le.populated_doc_type_cd_cnt
          ,le.populated_doc_type_desc_cnt
          ,le.populated_doc_other_desc_cnt
          ,le.populated_doc_page_count_cnt
          ,le.populated_doc_names_count_cnt
          ,le.populated_doc_status_cd_cnt
          ,le.populated_doc_status_desc_cnt
          ,le.populated_doc_amend_cd_cnt
          ,le.populated_doc_amend_desc_cnt
          ,le.populated_execution_dt_cnt
          ,le.populated_consideration_amt_cnt
          ,le.populated_assumption_amt_cnt
          ,le.populated_certified_mail_fee_cnt
          ,le.populated_service_charge_cnt
          ,le.populated_trust_amt_cnt
          ,le.populated_transfer__cnt
          ,le.populated_mortgage_cnt
          ,le.populated_intangible_tax_amt_cnt
          ,le.populated_intangible_tax_penalty_cnt
          ,le.populated_excise_tax_amt_cnt
          ,le.populated_recording_fee_cnt
          ,le.populated_documentary_stamps_fee_cnt
          ,le.populated_doc_stamps_mtg_fee_cnt
          ,le.populated_book_num_cnt
          ,le.populated_page_num_cnt
          ,le.populated_book_type_cd_cnt
          ,le.populated_book_type_desc_cnt
          ,le.populated_parcel_or_case_num_cnt
          ,le.populated_formatted_parcel_num_cnt
          ,le.populated_legal_desc_1_cnt
          ,le.populated_legal_desc_2_cnt
          ,le.populated_legal_desc_3_cnt
          ,le.populated_legal_desc_4_cnt
          ,le.populated_legal_desc_5_cnt
          ,le.populated_verified_flag_cnt
          ,le.populated_address_1_cnt
          ,le.populated_address_2_cnt
          ,le.populated_address_3_cnt
          ,le.populated_address_4_cnt
          ,le.populated_prior_doc_file_num_cnt
          ,le.populated_prior_doc_type_cd_cnt
          ,le.populated_prior_doc_type_desc_cnt
          ,le.populated_prior_book_num_cnt
          ,le.populated_prior_page_num_cnt
          ,le.populated_prior_book_type_cd_cnt
          ,le.populated_prior_book_type_desc_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_addr_suffix_cnt
          ,le.populated_postdir_cnt
          ,le.populated_unit_desig_cnt
          ,le.populated_sec_range_cnt
          ,le.populated_p_city_name_cnt
          ,le.populated_v_city_name_cnt
          ,le.populated_st_cnt
          ,le.populated_zip_cnt
          ,le.populated_zip4_cnt
          ,le.populated_cart_cnt
          ,le.populated_cr_sort_sz_cnt
          ,le.populated_lot_cnt
          ,le.populated_lot_order_cnt
          ,le.populated_dpbc_cnt
          ,le.populated_chk_digit_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_ace_fips_st_cnt
          ,le.populated_ace_fips_county_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_vendor_pcnt
          ,le.populated_state_origin_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_official_record_key_pcnt
          ,le.populated_fips_st_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_batch_id_pcnt
          ,le.populated_doc_serial_num_pcnt
          ,le.populated_doc_instrument_or_clerk_filing_num_pcnt
          ,le.populated_doc_num_dummy_flag_pcnt
          ,le.populated_doc_filed_dt_pcnt
          ,le.populated_doc_record_dt_pcnt
          ,le.populated_doc_type_cd_pcnt
          ,le.populated_doc_type_desc_pcnt
          ,le.populated_doc_other_desc_pcnt
          ,le.populated_doc_page_count_pcnt
          ,le.populated_doc_names_count_pcnt
          ,le.populated_doc_status_cd_pcnt
          ,le.populated_doc_status_desc_pcnt
          ,le.populated_doc_amend_cd_pcnt
          ,le.populated_doc_amend_desc_pcnt
          ,le.populated_execution_dt_pcnt
          ,le.populated_consideration_amt_pcnt
          ,le.populated_assumption_amt_pcnt
          ,le.populated_certified_mail_fee_pcnt
          ,le.populated_service_charge_pcnt
          ,le.populated_trust_amt_pcnt
          ,le.populated_transfer__pcnt
          ,le.populated_mortgage_pcnt
          ,le.populated_intangible_tax_amt_pcnt
          ,le.populated_intangible_tax_penalty_pcnt
          ,le.populated_excise_tax_amt_pcnt
          ,le.populated_recording_fee_pcnt
          ,le.populated_documentary_stamps_fee_pcnt
          ,le.populated_doc_stamps_mtg_fee_pcnt
          ,le.populated_book_num_pcnt
          ,le.populated_page_num_pcnt
          ,le.populated_book_type_cd_pcnt
          ,le.populated_book_type_desc_pcnt
          ,le.populated_parcel_or_case_num_pcnt
          ,le.populated_formatted_parcel_num_pcnt
          ,le.populated_legal_desc_1_pcnt
          ,le.populated_legal_desc_2_pcnt
          ,le.populated_legal_desc_3_pcnt
          ,le.populated_legal_desc_4_pcnt
          ,le.populated_legal_desc_5_pcnt
          ,le.populated_verified_flag_pcnt
          ,le.populated_address_1_pcnt
          ,le.populated_address_2_pcnt
          ,le.populated_address_3_pcnt
          ,le.populated_address_4_pcnt
          ,le.populated_prior_doc_file_num_pcnt
          ,le.populated_prior_doc_type_cd_pcnt
          ,le.populated_prior_doc_type_desc_pcnt
          ,le.populated_prior_book_num_pcnt
          ,le.populated_prior_page_num_pcnt
          ,le.populated_prior_book_type_cd_pcnt
          ,le.populated_prior_book_type_desc_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_addr_suffix_pcnt
          ,le.populated_postdir_pcnt
          ,le.populated_unit_desig_pcnt
          ,le.populated_sec_range_pcnt
          ,le.populated_p_city_name_pcnt
          ,le.populated_v_city_name_pcnt
          ,le.populated_st_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_cart_pcnt
          ,le.populated_cr_sort_sz_pcnt
          ,le.populated_lot_pcnt
          ,le.populated_lot_order_pcnt
          ,le.populated_dpbc_pcnt
          ,le.populated_chk_digit_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_ace_fips_st_pcnt
          ,le.populated_ace_fips_county_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,86,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Document_Delta(prevDS, PROJECT(h, Document_Layout_Official_Records));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),86,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Document_Layout_Official_Records) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Official_Records, Document_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
