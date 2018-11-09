IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Airmen_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 16;
  EXPORT NumRulesFromFieldType := 16;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 13;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Airmen_Layout_FAA)
    UNSIGNED1 d_score_Invalid;
    UNSIGNED1 best_ssn_Invalid;
    UNSIGNED1 did_out_Invalid;
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 current_flag_Invalid;
    UNSIGNED1 letter_code_Invalid;
    UNSIGNED1 unique_id_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 region_Invalid;
    UNSIGNED1 med_class_Invalid;
    UNSIGNED1 med_date_Invalid;
    UNSIGNED1 med_exp_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Airmen_Layout_FAA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Airmen_Layout_FAA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.d_score_Invalid := Airmen_Fields.InValid_d_score((SALT38.StrType)le.d_score);
    SELF.best_ssn_Invalid := Airmen_Fields.InValid_best_ssn((SALT38.StrType)le.best_ssn);
    SELF.did_out_Invalid := Airmen_Fields.InValid_did_out((SALT38.StrType)le.did_out);
    SELF.date_first_seen_Invalid := Airmen_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Airmen_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen);
    SELF.current_flag_Invalid := Airmen_Fields.InValid_current_flag((SALT38.StrType)le.current_flag);
    SELF.letter_code_Invalid := Airmen_Fields.InValid_letter_code((SALT38.StrType)le.letter_code);
    SELF.unique_id_Invalid := Airmen_Fields.InValid_unique_id((SALT38.StrType)le.unique_id);
    SELF.state_Invalid := Airmen_Fields.InValid_state((SALT38.StrType)le.state);
    SELF.region_Invalid := Airmen_Fields.InValid_region((SALT38.StrType)le.region);
    SELF.med_class_Invalid := Airmen_Fields.InValid_med_class((SALT38.StrType)le.med_class);
    SELF.med_date_Invalid := Airmen_Fields.InValid_med_date((SALT38.StrType)le.med_date);
    SELF.med_exp_date_Invalid := Airmen_Fields.InValid_med_exp_date((SALT38.StrType)le.med_exp_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Airmen_Layout_FAA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.d_score_Invalid << 0 ) + ( le.best_ssn_Invalid << 1 ) + ( le.did_out_Invalid << 3 ) + ( le.date_first_seen_Invalid << 4 ) + ( le.date_last_seen_Invalid << 5 ) + ( le.current_flag_Invalid << 6 ) + ( le.letter_code_Invalid << 7 ) + ( le.unique_id_Invalid << 8 ) + ( le.state_Invalid << 9 ) + ( le.region_Invalid << 10 ) + ( le.med_class_Invalid << 11 ) + ( le.med_date_Invalid << 12 ) + ( le.med_exp_date_Invalid << 14 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Airmen_Layout_FAA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.d_score_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.best_ssn_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.did_out_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.current_flag_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.letter_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.unique_id_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.region_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.med_class_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.med_date_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.med_exp_date_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    d_score_ALLOW_ErrorCount := COUNT(GROUP,h.d_score_Invalid=1);
    best_ssn_ALLOW_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=1);
    best_ssn_LENGTH_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid=2);
    best_ssn_Total_ErrorCount := COUNT(GROUP,h.best_ssn_Invalid>0);
    did_out_ALLOW_ErrorCount := COUNT(GROUP,h.did_out_Invalid=1);
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    current_flag_ENUM_ErrorCount := COUNT(GROUP,h.current_flag_Invalid=1);
    letter_code_ENUM_ErrorCount := COUNT(GROUP,h.letter_code_Invalid=1);
    unique_id_ALLOW_ErrorCount := COUNT(GROUP,h.unique_id_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    region_ALLOW_ErrorCount := COUNT(GROUP,h.region_Invalid=1);
    med_class_ENUM_ErrorCount := COUNT(GROUP,h.med_class_Invalid=1);
    med_date_ALLOW_ErrorCount := COUNT(GROUP,h.med_date_Invalid=1);
    med_date_LENGTH_ErrorCount := COUNT(GROUP,h.med_date_Invalid=2);
    med_date_Total_ErrorCount := COUNT(GROUP,h.med_date_Invalid>0);
    med_exp_date_ALLOW_ErrorCount := COUNT(GROUP,h.med_exp_date_Invalid=1);
    med_exp_date_LENGTH_ErrorCount := COUNT(GROUP,h.med_exp_date_Invalid=2);
    med_exp_date_Total_ErrorCount := COUNT(GROUP,h.med_exp_date_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.d_score_Invalid > 0 OR h.best_ssn_Invalid > 0 OR h.did_out_Invalid > 0 OR h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.current_flag_Invalid > 0 OR h.letter_code_Invalid > 0 OR h.unique_id_Invalid > 0 OR h.state_Invalid > 0 OR h.region_Invalid > 0 OR h.med_class_Invalid > 0 OR h.med_date_Invalid > 0 OR h.med_exp_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.d_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_Total_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.letter_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.unique_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region_ALLOW_ErrorCount > 0, 1, 0) + IF(le.med_class_ENUM_ErrorCount > 0, 1, 0) + IF(le.med_date_Total_ErrorCount > 0, 1, 0) + IF(le.med_exp_date_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.d_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.best_ssn_LENGTH_ErrorCount > 0, 1, 0) + IF(le.did_out_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.letter_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.unique_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.region_ALLOW_ErrorCount > 0, 1, 0) + IF(le.med_class_ENUM_ErrorCount > 0, 1, 0) + IF(le.med_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.med_date_LENGTH_ErrorCount > 0, 1, 0) + IF(le.med_exp_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.med_exp_date_LENGTH_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.d_score_Invalid,le.best_ssn_Invalid,le.did_out_Invalid,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.current_flag_Invalid,le.letter_code_Invalid,le.unique_id_Invalid,le.state_Invalid,le.region_Invalid,le.med_class_Invalid,le.med_date_Invalid,le.med_exp_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Airmen_Fields.InvalidMessage_d_score(le.d_score_Invalid),Airmen_Fields.InvalidMessage_best_ssn(le.best_ssn_Invalid),Airmen_Fields.InvalidMessage_did_out(le.did_out_Invalid),Airmen_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Airmen_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Airmen_Fields.InvalidMessage_current_flag(le.current_flag_Invalid),Airmen_Fields.InvalidMessage_letter_code(le.letter_code_Invalid),Airmen_Fields.InvalidMessage_unique_id(le.unique_id_Invalid),Airmen_Fields.InvalidMessage_state(le.state_Invalid),Airmen_Fields.InvalidMessage_region(le.region_Invalid),Airmen_Fields.InvalidMessage_med_class(le.med_class_Invalid),Airmen_Fields.InvalidMessage_med_date(le.med_date_Invalid),Airmen_Fields.InvalidMessage_med_exp_date(le.med_exp_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.d_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.best_ssn_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.did_out_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.letter_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.unique_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.region_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.med_class_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.med_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.med_exp_date_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'d_score','best_ssn','did_out','date_first_seen','date_last_seen','current_flag','letter_code','unique_id','state','region','med_class','med_date','med_exp_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_SSN','Invalid_Num','Invalid_Date','Invalid_Date','Invalid_Flag','Invalid_LetterCode','Invalid_Num','Invalid_Letter','Invalid_Letter','Invalid_MedClass','Invalid_MedDate','Invalid_MedDate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.d_score,(SALT38.StrType)le.best_ssn,(SALT38.StrType)le.did_out,(SALT38.StrType)le.date_first_seen,(SALT38.StrType)le.date_last_seen,(SALT38.StrType)le.current_flag,(SALT38.StrType)le.letter_code,(SALT38.StrType)le.unique_id,(SALT38.StrType)le.state,(SALT38.StrType)le.region,(SALT38.StrType)le.med_class,(SALT38.StrType)le.med_date,(SALT38.StrType)le.med_exp_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Airmen_Layout_FAA) prevDS = DATASET([], Airmen_Layout_FAA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'d_score:Invalid_Num:ALLOW'
          ,'best_ssn:Invalid_SSN:ALLOW','best_ssn:Invalid_SSN:LENGTH'
          ,'did_out:Invalid_Num:ALLOW'
          ,'date_first_seen:Invalid_Date:CUSTOM'
          ,'date_last_seen:Invalid_Date:CUSTOM'
          ,'current_flag:Invalid_Flag:ENUM'
          ,'letter_code:Invalid_LetterCode:ENUM'
          ,'unique_id:Invalid_Num:ALLOW'
          ,'state:Invalid_Letter:ALLOW'
          ,'region:Invalid_Letter:ALLOW'
          ,'med_class:Invalid_MedClass:ENUM'
          ,'med_date:Invalid_MedDate:ALLOW','med_date:Invalid_MedDate:LENGTH'
          ,'med_exp_date:Invalid_MedDate:ALLOW','med_exp_date:Invalid_MedDate:LENGTH'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Airmen_Fields.InvalidMessage_d_score(1)
          ,Airmen_Fields.InvalidMessage_best_ssn(1),Airmen_Fields.InvalidMessage_best_ssn(2)
          ,Airmen_Fields.InvalidMessage_did_out(1)
          ,Airmen_Fields.InvalidMessage_date_first_seen(1)
          ,Airmen_Fields.InvalidMessage_date_last_seen(1)
          ,Airmen_Fields.InvalidMessage_current_flag(1)
          ,Airmen_Fields.InvalidMessage_letter_code(1)
          ,Airmen_Fields.InvalidMessage_unique_id(1)
          ,Airmen_Fields.InvalidMessage_state(1)
          ,Airmen_Fields.InvalidMessage_region(1)
          ,Airmen_Fields.InvalidMessage_med_class(1)
          ,Airmen_Fields.InvalidMessage_med_date(1),Airmen_Fields.InvalidMessage_med_date(2)
          ,Airmen_Fields.InvalidMessage_med_exp_date(1),Airmen_Fields.InvalidMessage_med_exp_date(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.d_score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.current_flag_ENUM_ErrorCount
          ,le.letter_code_ENUM_ErrorCount
          ,le.unique_id_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.region_ALLOW_ErrorCount
          ,le.med_class_ENUM_ErrorCount
          ,le.med_date_ALLOW_ErrorCount,le.med_date_LENGTH_ErrorCount
          ,le.med_exp_date_ALLOW_ErrorCount,le.med_exp_date_LENGTH_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.d_score_ALLOW_ErrorCount
          ,le.best_ssn_ALLOW_ErrorCount,le.best_ssn_LENGTH_ErrorCount
          ,le.did_out_ALLOW_ErrorCount
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.current_flag_ENUM_ErrorCount
          ,le.letter_code_ENUM_ErrorCount
          ,le.unique_id_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.region_ALLOW_ErrorCount
          ,le.med_class_ENUM_ErrorCount
          ,le.med_date_ALLOW_ErrorCount,le.med_date_LENGTH_ErrorCount
          ,le.med_exp_date_ALLOW_ErrorCount,le.med_exp_date_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := Airmen_hygiene(PROJECT(h, Airmen_Layout_FAA));
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
          ,'d_score:' + getFieldTypeText(h.d_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'best_ssn:' + getFieldTypeText(h.best_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_out:' + getFieldTypeText(h.did_out) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_flag:' + getFieldTypeText(h.current_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'letter_code:' + getFieldTypeText(h.letter_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unique_id:' + getFieldTypeText(h.unique_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_rec_type:' + getFieldTypeText(h.orig_rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street1:' + getFieldTypeText(h.street1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street2:' + getFieldTypeText(h.street2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'region:' + getFieldTypeText(h.region) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'med_class:' + getFieldTypeText(h.med_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'med_date:' + getFieldTypeText(h.med_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'med_exp_date:' + getFieldTypeText(h.med_exp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_range:' + getFieldTypeText(h.prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'predir:' + getFieldTypeText(h.predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prim_name:' + getFieldTypeText(h.prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
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
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_name:' + getFieldTypeText(h.county_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_lat:' + getFieldTypeText(h.geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_long:' + getFieldTypeText(h.geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'msa:' + getFieldTypeText(h.msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_blk:' + getFieldTypeText(h.geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'geo_match:' + getFieldTypeText(h.geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'err_stat:' + getFieldTypeText(h.err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'oer:' + getFieldTypeText(h.oer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source:' + getFieldTypeText(h.source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_d_score_cnt
          ,le.populated_best_ssn_cnt
          ,le.populated_did_out_cnt
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_current_flag_cnt
          ,le.populated_record_type_cnt
          ,le.populated_letter_code_cnt
          ,le.populated_unique_id_cnt
          ,le.populated_orig_rec_type_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_street1_cnt
          ,le.populated_street2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_country_cnt
          ,le.populated_region_cnt
          ,le.populated_med_class_cnt
          ,le.populated_med_date_cnt
          ,le.populated_med_exp_date_cnt
          ,le.populated_prim_range_cnt
          ,le.populated_predir_cnt
          ,le.populated_prim_name_cnt
          ,le.populated_suffix_cnt
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
          ,le.populated_county_cnt
          ,le.populated_county_name_cnt
          ,le.populated_geo_lat_cnt
          ,le.populated_geo_long_cnt
          ,le.populated_msa_cnt
          ,le.populated_geo_blk_cnt
          ,le.populated_geo_match_cnt
          ,le.populated_err_stat_cnt
          ,le.populated_title_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_oer_cnt
          ,le.populated_source_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_d_score_pcnt
          ,le.populated_best_ssn_pcnt
          ,le.populated_did_out_pcnt
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_current_flag_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_letter_code_pcnt
          ,le.populated_unique_id_pcnt
          ,le.populated_orig_rec_type_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_street1_pcnt
          ,le.populated_street2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_country_pcnt
          ,le.populated_region_pcnt
          ,le.populated_med_class_pcnt
          ,le.populated_med_date_pcnt
          ,le.populated_med_exp_date_pcnt
          ,le.populated_prim_range_pcnt
          ,le.populated_predir_pcnt
          ,le.populated_prim_name_pcnt
          ,le.populated_suffix_pcnt
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
          ,le.populated_county_pcnt
          ,le.populated_county_name_pcnt
          ,le.populated_geo_lat_pcnt
          ,le.populated_geo_long_pcnt
          ,le.populated_msa_pcnt
          ,le.populated_geo_blk_pcnt
          ,le.populated_geo_match_pcnt
          ,le.populated_err_stat_pcnt
          ,le.populated_title_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_oer_pcnt
          ,le.populated_source_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,57,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Airmen_Delta(prevDS, PROJECT(h, Airmen_Layout_FAA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),57,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Airmen_Layout_FAA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FAA, Airmen_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
