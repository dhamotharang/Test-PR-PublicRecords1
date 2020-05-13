IMPORT SALT311,STD;
EXPORT Transactions_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 14;
  EXPORT NumRulesFromFieldType := 14;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 14;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Transactions_Layout_PhoneFinder)
    UNSIGNED1 transaction_id_Invalid;
    UNSIGNED1 user_id_Invalid;
    UNSIGNED1 product_code_Invalid;
    UNSIGNED1 company_id_Invalid;
    UNSIGNED1 source_code_Invalid;
    UNSIGNED1 batch_job_id_Invalid;
    UNSIGNED1 batch_acctno_Invalid;
    UNSIGNED1 response_time_Invalid;
    UNSIGNED1 phonefinder_type_Invalid;
    UNSIGNED1 submitted_lexid_Invalid;
    UNSIGNED1 submitted_phonenumber_Invalid;
    UNSIGNED1 submitted_firstname_Invalid;
    UNSIGNED1 submitted_lastname_Invalid;
    UNSIGNED1 submitted_middlename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Transactions_Layout_PhoneFinder)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Transactions_Layout_PhoneFinder)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'transaction_id:Invalid_ID:ALLOW'
          ,'user_id:Invalid_Alpha:ALLOW'
          ,'product_code:Invalid_Alpha:ALLOW'
          ,'company_id:Invalid_No:ALLOW'
          ,'source_code:Invalid_Code:ALLOW'
          ,'batch_job_id:Invalid_Code:ALLOW'
          ,'batch_acctno:Invalid_No:ALLOW'
          ,'response_time:Invalid_No:ALLOW'
          ,'phonefinder_type:Invalid_Alpha:ALLOW'
          ,'submitted_lexid:Invalid_Code:ALLOW'
          ,'submitted_phonenumber:Invalid_Code:ALLOW'
          ,'submitted_firstname:Invalid_AlphaChar:ALLOW'
          ,'submitted_lastname:Invalid_AlphaChar:ALLOW'
          ,'submitted_middlename:Invalid_AlphaChar:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Transactions_Fields.InvalidMessage_transaction_id(1)
          ,Transactions_Fields.InvalidMessage_user_id(1)
          ,Transactions_Fields.InvalidMessage_product_code(1)
          ,Transactions_Fields.InvalidMessage_company_id(1)
          ,Transactions_Fields.InvalidMessage_source_code(1)
          ,Transactions_Fields.InvalidMessage_batch_job_id(1)
          ,Transactions_Fields.InvalidMessage_batch_acctno(1)
          ,Transactions_Fields.InvalidMessage_response_time(1)
          ,Transactions_Fields.InvalidMessage_phonefinder_type(1)
          ,Transactions_Fields.InvalidMessage_submitted_lexid(1)
          ,Transactions_Fields.InvalidMessage_submitted_phonenumber(1)
          ,Transactions_Fields.InvalidMessage_submitted_firstname(1)
          ,Transactions_Fields.InvalidMessage_submitted_lastname(1)
          ,Transactions_Fields.InvalidMessage_submitted_middlename(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Transactions_Layout_PhoneFinder) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.transaction_id_Invalid := Transactions_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id);
    SELF.user_id_Invalid := Transactions_Fields.InValid_user_id((SALT311.StrType)le.user_id);
    SELF.product_code_Invalid := Transactions_Fields.InValid_product_code((SALT311.StrType)le.product_code);
    SELF.company_id_Invalid := Transactions_Fields.InValid_company_id((SALT311.StrType)le.company_id);
    SELF.source_code_Invalid := Transactions_Fields.InValid_source_code((SALT311.StrType)le.source_code);
    SELF.batch_job_id_Invalid := Transactions_Fields.InValid_batch_job_id((SALT311.StrType)le.batch_job_id);
    SELF.batch_acctno_Invalid := Transactions_Fields.InValid_batch_acctno((SALT311.StrType)le.batch_acctno);
    SELF.response_time_Invalid := Transactions_Fields.InValid_response_time((SALT311.StrType)le.response_time);
    SELF.phonefinder_type_Invalid := Transactions_Fields.InValid_phonefinder_type((SALT311.StrType)le.phonefinder_type);
    SELF.submitted_lexid_Invalid := Transactions_Fields.InValid_submitted_lexid((SALT311.StrType)le.submitted_lexid);
    SELF.submitted_phonenumber_Invalid := Transactions_Fields.InValid_submitted_phonenumber((SALT311.StrType)le.submitted_phonenumber);
    SELF.submitted_firstname_Invalid := Transactions_Fields.InValid_submitted_firstname((SALT311.StrType)le.submitted_firstname);
    SELF.submitted_lastname_Invalid := Transactions_Fields.InValid_submitted_lastname((SALT311.StrType)le.submitted_lastname);
    SELF.submitted_middlename_Invalid := Transactions_Fields.InValid_submitted_middlename((SALT311.StrType)le.submitted_middlename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Transactions_Layout_PhoneFinder);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.transaction_id_Invalid << 0 ) + ( le.user_id_Invalid << 1 ) + ( le.product_code_Invalid << 2 ) + ( le.company_id_Invalid << 3 ) + ( le.source_code_Invalid << 4 ) + ( le.batch_job_id_Invalid << 5 ) + ( le.batch_acctno_Invalid << 6 ) + ( le.response_time_Invalid << 7 ) + ( le.phonefinder_type_Invalid << 8 ) + ( le.submitted_lexid_Invalid << 9 ) + ( le.submitted_phonenumber_Invalid << 10 ) + ( le.submitted_firstname_Invalid << 11 ) + ( le.submitted_lastname_Invalid << 12 ) + ( le.submitted_middlename_Invalid << 13 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
  STRING escQuotes(STRING s) := STD.Str.FindReplace(s,'\'','\\\'');
  Rule_Layout IntoRule(BitmapInfile le, UNSIGNED c) := TRANSFORM
    mask := 1<<(c-1);
    hasError := (mask&le.ScrubsBits1)>0;
    SELF.Rules := IF(hasError,TRIM(toRuleDesc(c))+':\''+escQuotes(TRIM(toErrorMessage(c)))+'\'',IF(le.ScrubsBits1=0 AND c=1,'',SKIP));
    SELF := le;
  END;
  unrolled := NORMALIZE(BitmapInfile,NumRules,IntoRule(LEFT,COUNTER));
  Rule_Layout toRoll(Rule_Layout le,Rule_Layout ri) := TRANSFORM
    SELF.Rules := TRIM(le.Rules) + IF(LENGTH(TRIM(le.Rules))>0 AND LENGTH(TRIM(ri.Rules))>0,',','') + TRIM(ri.Rules);
    SELF := le;
  END;
  EXPORT RulesInfile := ROLLUP(unrolled,toRoll(LEFT,RIGHT),EXCEPT Rules);
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Transactions_Layout_PhoneFinder);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.user_id_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.product_code_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.company_id_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.source_code_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.batch_job_id_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.batch_acctno_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.response_time_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phonefinder_type_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.submitted_lexid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.submitted_phonenumber_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.submitted_firstname_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.submitted_lastname_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.submitted_middlename_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    user_id_ALLOW_ErrorCount := COUNT(GROUP,h.user_id_Invalid=1);
    product_code_ALLOW_ErrorCount := COUNT(GROUP,h.product_code_Invalid=1);
    company_id_ALLOW_ErrorCount := COUNT(GROUP,h.company_id_Invalid=1);
    source_code_ALLOW_ErrorCount := COUNT(GROUP,h.source_code_Invalid=1);
    batch_job_id_ALLOW_ErrorCount := COUNT(GROUP,h.batch_job_id_Invalid=1);
    batch_acctno_ALLOW_ErrorCount := COUNT(GROUP,h.batch_acctno_Invalid=1);
    response_time_ALLOW_ErrorCount := COUNT(GROUP,h.response_time_Invalid=1);
    phonefinder_type_ALLOW_ErrorCount := COUNT(GROUP,h.phonefinder_type_Invalid=1);
    submitted_lexid_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_lexid_Invalid=1);
    submitted_phonenumber_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_phonenumber_Invalid=1);
    submitted_firstname_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_firstname_Invalid=1);
    submitted_lastname_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_lastname_Invalid=1);
    submitted_middlename_ALLOW_ErrorCount := COUNT(GROUP,h.submitted_middlename_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.transaction_id_Invalid > 0 OR h.user_id_Invalid > 0 OR h.product_code_Invalid > 0 OR h.company_id_Invalid > 0 OR h.source_code_Invalid > 0 OR h.batch_job_id_Invalid > 0 OR h.batch_acctno_Invalid > 0 OR h.response_time_Invalid > 0 OR h.phonefinder_type_Invalid > 0 OR h.submitted_lexid_Invalid > 0 OR h.submitted_phonenumber_Invalid > 0 OR h.submitted_firstname_Invalid > 0 OR h.submitted_lastname_Invalid > 0 OR h.submitted_middlename_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.user_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.product_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_job_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_acctno_ALLOW_ErrorCount > 0, 1, 0) + IF(le.response_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phonefinder_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_lexid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_phonenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_middlename_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.user_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.product_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.company_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.source_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_job_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.batch_acctno_ALLOW_ErrorCount > 0, 1, 0) + IF(le.response_time_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phonefinder_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_lexid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_phonenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.submitted_middlename_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.transaction_id_Invalid,le.user_id_Invalid,le.product_code_Invalid,le.company_id_Invalid,le.source_code_Invalid,le.batch_job_id_Invalid,le.batch_acctno_Invalid,le.response_time_Invalid,le.phonefinder_type_Invalid,le.submitted_lexid_Invalid,le.submitted_phonenumber_Invalid,le.submitted_firstname_Invalid,le.submitted_lastname_Invalid,le.submitted_middlename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Transactions_Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),Transactions_Fields.InvalidMessage_user_id(le.user_id_Invalid),Transactions_Fields.InvalidMessage_product_code(le.product_code_Invalid),Transactions_Fields.InvalidMessage_company_id(le.company_id_Invalid),Transactions_Fields.InvalidMessage_source_code(le.source_code_Invalid),Transactions_Fields.InvalidMessage_batch_job_id(le.batch_job_id_Invalid),Transactions_Fields.InvalidMessage_batch_acctno(le.batch_acctno_Invalid),Transactions_Fields.InvalidMessage_response_time(le.response_time_Invalid),Transactions_Fields.InvalidMessage_phonefinder_type(le.phonefinder_type_Invalid),Transactions_Fields.InvalidMessage_submitted_lexid(le.submitted_lexid_Invalid),Transactions_Fields.InvalidMessage_submitted_phonenumber(le.submitted_phonenumber_Invalid),Transactions_Fields.InvalidMessage_submitted_firstname(le.submitted_firstname_Invalid),Transactions_Fields.InvalidMessage_submitted_lastname(le.submitted_lastname_Invalid),Transactions_Fields.InvalidMessage_submitted_middlename(le.submitted_middlename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.transaction_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.user_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.product_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.company_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.source_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.batch_job_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.batch_acctno_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.response_time_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phonefinder_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_lexid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_phonenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_firstname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_lastname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.submitted_middlename_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'transaction_id','user_id','product_code','company_id','source_code','batch_job_id','batch_acctno','response_time','phonefinder_type','submitted_lexid','submitted_phonenumber','submitted_firstname','submitted_lastname','submitted_middlename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_ID','Invalid_Alpha','Invalid_Alpha','Invalid_No','Invalid_Code','Invalid_Code','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Code','Invalid_Code','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.transaction_id,(SALT311.StrType)le.user_id,(SALT311.StrType)le.product_code,(SALT311.StrType)le.company_id,(SALT311.StrType)le.source_code,(SALT311.StrType)le.batch_job_id,(SALT311.StrType)le.batch_acctno,(SALT311.StrType)le.response_time,(SALT311.StrType)le.phonefinder_type,(SALT311.StrType)le.submitted_lexid,(SALT311.StrType)le.submitted_phonenumber,(SALT311.StrType)le.submitted_firstname,(SALT311.StrType)le.submitted_lastname,(SALT311.StrType)le.submitted_middlename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,14,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Transactions_Layout_PhoneFinder) prevDS = DATASET([], Transactions_Layout_PhoneFinder), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.user_id_ALLOW_ErrorCount
          ,le.product_code_ALLOW_ErrorCount
          ,le.company_id_ALLOW_ErrorCount
          ,le.source_code_ALLOW_ErrorCount
          ,le.batch_job_id_ALLOW_ErrorCount
          ,le.batch_acctno_ALLOW_ErrorCount
          ,le.response_time_ALLOW_ErrorCount
          ,le.phonefinder_type_ALLOW_ErrorCount
          ,le.submitted_lexid_ALLOW_ErrorCount
          ,le.submitted_phonenumber_ALLOW_ErrorCount
          ,le.submitted_firstname_ALLOW_ErrorCount
          ,le.submitted_lastname_ALLOW_ErrorCount
          ,le.submitted_middlename_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.user_id_ALLOW_ErrorCount
          ,le.product_code_ALLOW_ErrorCount
          ,le.company_id_ALLOW_ErrorCount
          ,le.source_code_ALLOW_ErrorCount
          ,le.batch_job_id_ALLOW_ErrorCount
          ,le.batch_acctno_ALLOW_ErrorCount
          ,le.response_time_ALLOW_ErrorCount
          ,le.phonefinder_type_ALLOW_ErrorCount
          ,le.submitted_lexid_ALLOW_ErrorCount
          ,le.submitted_phonenumber_ALLOW_ErrorCount
          ,le.submitted_firstname_ALLOW_ErrorCount
          ,le.submitted_lastname_ALLOW_ErrorCount
          ,le.submitted_middlename_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Transactions_hygiene(PROJECT(h, Transactions_Layout_PhoneFinder));
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
          ,'transaction_id:' + getFieldTypeText(h.transaction_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'transaction_date:' + getFieldTypeText(h.transaction_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'user_id:' + getFieldTypeText(h.user_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'product_code:' + getFieldTypeText(h.product_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_id:' + getFieldTypeText(h.company_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_code:' + getFieldTypeText(h.source_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'batch_job_id:' + getFieldTypeText(h.batch_job_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'batch_acctno:' + getFieldTypeText(h.batch_acctno) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'response_time:' + getFieldTypeText(h.response_time) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'reference_code:' + getFieldTypeText(h.reference_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phonefinder_type:' + getFieldTypeText(h.phonefinder_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_lexid:' + getFieldTypeText(h.submitted_lexid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_phonenumber:' + getFieldTypeText(h.submitted_phonenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_firstname:' + getFieldTypeText(h.submitted_firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_lastname:' + getFieldTypeText(h.submitted_lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_middlename:' + getFieldTypeText(h.submitted_middlename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_streetaddress1:' + getFieldTypeText(h.submitted_streetaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_city:' + getFieldTypeText(h.submitted_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_state:' + getFieldTypeText(h.submitted_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'submitted_zip:' + getFieldTypeText(h.submitted_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phonenumber:' + getFieldTypeText(h.phonenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'data_source:' + getFieldTypeText(h.data_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'royalty_used:' + getFieldTypeText(h.royalty_used) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'carrier:' + getFieldTypeText(h.carrier) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'risk_indicator:' + getFieldTypeText(h.risk_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_type:' + getFieldTypeText(h.phone_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_status:' + getFieldTypeText(h.phone_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ported_count:' + getFieldTypeText(h.ported_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_ported_date:' + getFieldTypeText(h.last_ported_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'otp_count:' + getFieldTypeText(h.otp_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_otp_date:' + getFieldTypeText(h.last_otp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spoof_count:' + getFieldTypeText(h.spoof_count) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_spoof_date:' + getFieldTypeText(h.last_spoof_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_forwarded:' + getFieldTypeText(h.phone_forwarded) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_transaction_id_cnt
          ,le.populated_transaction_date_cnt
          ,le.populated_user_id_cnt
          ,le.populated_product_code_cnt
          ,le.populated_company_id_cnt
          ,le.populated_source_code_cnt
          ,le.populated_batch_job_id_cnt
          ,le.populated_batch_acctno_cnt
          ,le.populated_response_time_cnt
          ,le.populated_reference_code_cnt
          ,le.populated_phonefinder_type_cnt
          ,le.populated_submitted_lexid_cnt
          ,le.populated_submitted_phonenumber_cnt
          ,le.populated_submitted_firstname_cnt
          ,le.populated_submitted_lastname_cnt
          ,le.populated_submitted_middlename_cnt
          ,le.populated_submitted_streetaddress1_cnt
          ,le.populated_submitted_city_cnt
          ,le.populated_submitted_state_cnt
          ,le.populated_submitted_zip_cnt
          ,le.populated_phonenumber_cnt
          ,le.populated_data_source_cnt
          ,le.populated_royalty_used_cnt
          ,le.populated_carrier_cnt
          ,le.populated_risk_indicator_cnt
          ,le.populated_phone_type_cnt
          ,le.populated_phone_status_cnt
          ,le.populated_ported_count_cnt
          ,le.populated_last_ported_date_cnt
          ,le.populated_otp_count_cnt
          ,le.populated_last_otp_date_cnt
          ,le.populated_spoof_count_cnt
          ,le.populated_last_spoof_date_cnt
          ,le.populated_phone_forwarded_cnt
          ,le.populated_date_added_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_transaction_id_pcnt
          ,le.populated_transaction_date_pcnt
          ,le.populated_user_id_pcnt
          ,le.populated_product_code_pcnt
          ,le.populated_company_id_pcnt
          ,le.populated_source_code_pcnt
          ,le.populated_batch_job_id_pcnt
          ,le.populated_batch_acctno_pcnt
          ,le.populated_response_time_pcnt
          ,le.populated_reference_code_pcnt
          ,le.populated_phonefinder_type_pcnt
          ,le.populated_submitted_lexid_pcnt
          ,le.populated_submitted_phonenumber_pcnt
          ,le.populated_submitted_firstname_pcnt
          ,le.populated_submitted_lastname_pcnt
          ,le.populated_submitted_middlename_pcnt
          ,le.populated_submitted_streetaddress1_pcnt
          ,le.populated_submitted_city_pcnt
          ,le.populated_submitted_state_pcnt
          ,le.populated_submitted_zip_pcnt
          ,le.populated_phonenumber_pcnt
          ,le.populated_data_source_pcnt
          ,le.populated_royalty_used_pcnt
          ,le.populated_carrier_pcnt
          ,le.populated_risk_indicator_pcnt
          ,le.populated_phone_type_pcnt
          ,le.populated_phone_status_pcnt
          ,le.populated_ported_count_pcnt
          ,le.populated_last_ported_date_pcnt
          ,le.populated_otp_count_pcnt
          ,le.populated_last_otp_date_pcnt
          ,le.populated_spoof_count_pcnt
          ,le.populated_last_spoof_date_pcnt
          ,le.populated_phone_forwarded_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_filename_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,36,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Transactions_Delta(prevDS, PROJECT(h, Transactions_Layout_PhoneFinder));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),36,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Transactions_Layout_PhoneFinder) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhoneFinder, Transactions_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
