IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Airmen_Cert_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 9;
  EXPORT NumRulesFromFieldType := 9;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 9;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Airmen_Cert_Layout_FAA)
    UNSIGNED1 date_first_seen_Invalid;
    UNSIGNED1 date_last_seen_Invalid;
    UNSIGNED1 current_flag_Invalid;
    UNSIGNED1 letter_Invalid;
    UNSIGNED1 unique_id_Invalid;
    UNSIGNED1 rec_type_Invalid;
    UNSIGNED1 cer_type_Invalid;
    UNSIGNED1 cer_level_Invalid;
    UNSIGNED1 cer_exp_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Airmen_Cert_Layout_FAA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Airmen_Cert_Layout_FAA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.date_first_seen_Invalid := Airmen_Cert_Fields.InValid_date_first_seen((SALT38.StrType)le.date_first_seen);
    SELF.date_last_seen_Invalid := Airmen_Cert_Fields.InValid_date_last_seen((SALT38.StrType)le.date_last_seen);
    SELF.current_flag_Invalid := Airmen_Cert_Fields.InValid_current_flag((SALT38.StrType)le.current_flag);
    SELF.letter_Invalid := Airmen_Cert_Fields.InValid_letter((SALT38.StrType)le.letter);
    SELF.unique_id_Invalid := Airmen_Cert_Fields.InValid_unique_id((SALT38.StrType)le.unique_id);
    SELF.rec_type_Invalid := Airmen_Cert_Fields.InValid_rec_type((SALT38.StrType)le.rec_type);
    SELF.cer_type_Invalid := Airmen_Cert_Fields.InValid_cer_type((SALT38.StrType)le.cer_type);
    SELF.cer_level_Invalid := Airmen_Cert_Fields.InValid_cer_level((SALT38.StrType)le.cer_level);
    SELF.cer_exp_date_Invalid := Airmen_Cert_Fields.InValid_cer_exp_date((SALT38.StrType)le.cer_exp_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Airmen_Cert_Layout_FAA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.date_first_seen_Invalid << 0 ) + ( le.date_last_seen_Invalid << 1 ) + ( le.current_flag_Invalid << 2 ) + ( le.letter_Invalid << 3 ) + ( le.unique_id_Invalid << 4 ) + ( le.rec_type_Invalid << 5 ) + ( le.cer_type_Invalid << 6 ) + ( le.cer_level_Invalid << 7 ) + ( le.cer_exp_date_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Airmen_Cert_Layout_FAA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.date_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.date_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.current_flag_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.letter_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.unique_id_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.rec_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.cer_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.cer_level_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.cer_exp_date_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    date_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_first_seen_Invalid=1);
    date_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.date_last_seen_Invalid=1);
    current_flag_ENUM_ErrorCount := COUNT(GROUP,h.current_flag_Invalid=1);
    letter_ENUM_ErrorCount := COUNT(GROUP,h.letter_Invalid=1);
    unique_id_ALLOW_ErrorCount := COUNT(GROUP,h.unique_id_Invalid=1);
    rec_type_ENUM_ErrorCount := COUNT(GROUP,h.rec_type_Invalid=1);
    cer_type_ENUM_ErrorCount := COUNT(GROUP,h.cer_type_Invalid=1);
    cer_level_ENUM_ErrorCount := COUNT(GROUP,h.cer_level_Invalid=1);
    cer_exp_date_ALLOW_ErrorCount := COUNT(GROUP,h.cer_exp_date_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.date_first_seen_Invalid > 0 OR h.date_last_seen_Invalid > 0 OR h.current_flag_Invalid > 0 OR h.letter_Invalid > 0 OR h.unique_id_Invalid > 0 OR h.rec_type_Invalid > 0 OR h.cer_type_Invalid > 0 OR h.cer_level_Invalid > 0 OR h.cer_exp_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.letter_ENUM_ErrorCount > 0, 1, 0) + IF(le.unique_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.cer_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.cer_level_ENUM_ErrorCount > 0, 1, 0) + IF(le.cer_exp_date_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.date_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.current_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.letter_ENUM_ErrorCount > 0, 1, 0) + IF(le.unique_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rec_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.cer_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.cer_level_ENUM_ErrorCount > 0, 1, 0) + IF(le.cer_exp_date_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.date_first_seen_Invalid,le.date_last_seen_Invalid,le.current_flag_Invalid,le.letter_Invalid,le.unique_id_Invalid,le.rec_type_Invalid,le.cer_type_Invalid,le.cer_level_Invalid,le.cer_exp_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Airmen_Cert_Fields.InvalidMessage_date_first_seen(le.date_first_seen_Invalid),Airmen_Cert_Fields.InvalidMessage_date_last_seen(le.date_last_seen_Invalid),Airmen_Cert_Fields.InvalidMessage_current_flag(le.current_flag_Invalid),Airmen_Cert_Fields.InvalidMessage_letter(le.letter_Invalid),Airmen_Cert_Fields.InvalidMessage_unique_id(le.unique_id_Invalid),Airmen_Cert_Fields.InvalidMessage_rec_type(le.rec_type_Invalid),Airmen_Cert_Fields.InvalidMessage_cer_type(le.cer_type_Invalid),Airmen_Cert_Fields.InvalidMessage_cer_level(le.cer_level_Invalid),Airmen_Cert_Fields.InvalidMessage_cer_exp_date(le.cer_exp_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.date_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.current_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.letter_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.unique_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rec_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cer_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cer_level_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cer_exp_date_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'date_first_seen','date_last_seen','current_flag','letter','unique_id','rec_type','cer_type','cer_level','cer_exp_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Flag','Invalid_LetterCode','Invalid_Num','Invalid_RecType','Invalid_CerType','Invalid_CerLevel','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.date_first_seen,(SALT38.StrType)le.date_last_seen,(SALT38.StrType)le.current_flag,(SALT38.StrType)le.letter,(SALT38.StrType)le.unique_id,(SALT38.StrType)le.rec_type,(SALT38.StrType)le.cer_type,(SALT38.StrType)le.cer_level,(SALT38.StrType)le.cer_exp_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Airmen_Cert_Layout_FAA) prevDS = DATASET([], Airmen_Cert_Layout_FAA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'date_first_seen:Invalid_Date:CUSTOM'
          ,'date_last_seen:Invalid_Date:CUSTOM'
          ,'current_flag:Invalid_Flag:ENUM'
          ,'letter:Invalid_LetterCode:ENUM'
          ,'unique_id:Invalid_Num:ALLOW'
          ,'rec_type:Invalid_RecType:ENUM'
          ,'cer_type:Invalid_CerType:ENUM'
          ,'cer_level:Invalid_CerLevel:ENUM'
          ,'cer_exp_date:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Airmen_Cert_Fields.InvalidMessage_date_first_seen(1)
          ,Airmen_Cert_Fields.InvalidMessage_date_last_seen(1)
          ,Airmen_Cert_Fields.InvalidMessage_current_flag(1)
          ,Airmen_Cert_Fields.InvalidMessage_letter(1)
          ,Airmen_Cert_Fields.InvalidMessage_unique_id(1)
          ,Airmen_Cert_Fields.InvalidMessage_rec_type(1)
          ,Airmen_Cert_Fields.InvalidMessage_cer_type(1)
          ,Airmen_Cert_Fields.InvalidMessage_cer_level(1)
          ,Airmen_Cert_Fields.InvalidMessage_cer_exp_date(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.current_flag_ENUM_ErrorCount
          ,le.letter_ENUM_ErrorCount
          ,le.unique_id_ALLOW_ErrorCount
          ,le.rec_type_ENUM_ErrorCount
          ,le.cer_type_ENUM_ErrorCount
          ,le.cer_level_ENUM_ErrorCount
          ,le.cer_exp_date_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.date_first_seen_CUSTOM_ErrorCount
          ,le.date_last_seen_CUSTOM_ErrorCount
          ,le.current_flag_ENUM_ErrorCount
          ,le.letter_ENUM_ErrorCount
          ,le.unique_id_ALLOW_ErrorCount
          ,le.rec_type_ENUM_ErrorCount
          ,le.cer_type_ENUM_ErrorCount
          ,le.cer_level_ENUM_ErrorCount
          ,le.cer_exp_date_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := Airmen_Cert_hygiene(PROJECT(h, Airmen_Cert_Layout_FAA));
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
          ,'date_first_seen:' + getFieldTypeText(h.date_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_last_seen:' + getFieldTypeText(h.date_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'current_flag:' + getFieldTypeText(h.current_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'letter:' + getFieldTypeText(h.letter) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unique_id:' + getFieldTypeText(h.unique_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rec_type:' + getFieldTypeText(h.rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cer_type:' + getFieldTypeText(h.cer_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cer_type_mapped:' + getFieldTypeText(h.cer_type_mapped) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cer_level:' + getFieldTypeText(h.cer_level) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cer_level_mapped:' + getFieldTypeText(h.cer_level_mapped) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cer_exp_date:' + getFieldTypeText(h.cer_exp_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ratings:' + getFieldTypeText(h.ratings) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler:' + getFieldTypeText(h.filler) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lfcr:' + getFieldTypeText(h.lfcr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'persistent_record_id:' + getFieldTypeText(h.persistent_record_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_date_first_seen_cnt
          ,le.populated_date_last_seen_cnt
          ,le.populated_current_flag_cnt
          ,le.populated_letter_cnt
          ,le.populated_unique_id_cnt
          ,le.populated_rec_type_cnt
          ,le.populated_cer_type_cnt
          ,le.populated_cer_type_mapped_cnt
          ,le.populated_cer_level_cnt
          ,le.populated_cer_level_mapped_cnt
          ,le.populated_cer_exp_date_cnt
          ,le.populated_ratings_cnt
          ,le.populated_filler_cnt
          ,le.populated_lfcr_cnt
          ,le.populated_persistent_record_id_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_date_first_seen_pcnt
          ,le.populated_date_last_seen_pcnt
          ,le.populated_current_flag_pcnt
          ,le.populated_letter_pcnt
          ,le.populated_unique_id_pcnt
          ,le.populated_rec_type_pcnt
          ,le.populated_cer_type_pcnt
          ,le.populated_cer_type_mapped_pcnt
          ,le.populated_cer_level_pcnt
          ,le.populated_cer_level_mapped_pcnt
          ,le.populated_cer_exp_date_pcnt
          ,le.populated_ratings_pcnt
          ,le.populated_filler_pcnt
          ,le.populated_lfcr_pcnt
          ,le.populated_persistent_record_id_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,15,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Airmen_Cert_Delta(prevDS, PROJECT(h, Airmen_Cert_Layout_FAA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),15,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Airmen_Cert_Layout_FAA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FAA, Airmen_Cert_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
