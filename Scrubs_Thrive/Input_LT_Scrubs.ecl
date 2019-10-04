IMPORT SALT311,STD;
IMPORT Scrubs_Thrive,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_LT_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 11;
  EXPORT NumRulesFromFieldType := 11;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 11;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_LT_Layout_Thrive)
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_addr_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_zip4_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip5_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 employer_Invalid;
    UNSIGNED1 dt_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_LT_Layout_Thrive)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_LT_Layout_Thrive) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_fname_Invalid := Input_LT_Fields.InValid_orig_fname((SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_lname);
    SELF.orig_lname_Invalid := Input_LT_Fields.InValid_orig_lname((SALT311.StrType)le.orig_lname,(SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_lname);
    SELF.orig_addr_Invalid := Input_LT_Fields.InValid_orig_addr((SALT311.StrType)le.orig_addr);
    SELF.orig_city_Invalid := Input_LT_Fields.InValid_orig_city((SALT311.StrType)le.orig_city);
    SELF.orig_zip4_Invalid := Input_LT_Fields.InValid_orig_zip4((SALT311.StrType)le.orig_zip4);
    SELF.orig_state_Invalid := Input_LT_Fields.InValid_orig_state((SALT311.StrType)le.orig_state);
    SELF.orig_zip5_Invalid := Input_LT_Fields.InValid_orig_zip5((SALT311.StrType)le.orig_zip5);
    SELF.email_Invalid := Input_LT_Fields.InValid_email((SALT311.StrType)le.email);
    SELF.phone_Invalid := Input_LT_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.employer_Invalid := Input_LT_Fields.InValid_employer((SALT311.StrType)le.employer);
    SELF.dt_Invalid := Input_LT_Fields.InValid_dt((SALT311.StrType)le.dt);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_LT_Layout_Thrive);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_fname_Invalid << 0 ) + ( le.orig_lname_Invalid << 1 ) + ( le.orig_addr_Invalid << 2 ) + ( le.orig_city_Invalid << 3 ) + ( le.orig_zip4_Invalid << 4 ) + ( le.orig_state_Invalid << 5 ) + ( le.orig_zip5_Invalid << 6 ) + ( le.email_Invalid << 7 ) + ( le.phone_Invalid << 8 ) + ( le.employer_Invalid << 9 ) + ( le.dt_Invalid << 10 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_LT_Layout_Thrive);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.orig_addr_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_zip4_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_zip5_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.email_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.employer_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.dt_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_lname_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_addr_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_addr_Invalid=1);
    orig_city_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_zip4_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip5_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_zip5_Invalid=1);
    email_CUSTOM_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    employer_CUSTOM_ErrorCount := COUNT(GROUP,h.employer_Invalid=1);
    dt_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.orig_fname_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_addr_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_zip4_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip5_Invalid > 0 OR h.email_Invalid > 0 OR h.phone_Invalid > 0 OR h.employer_Invalid > 0 OR h.dt_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.orig_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_addr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.employer_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.orig_fname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_lname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_addr_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.orig_zip5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.employer_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_fname_Invalid,le.orig_lname_Invalid,le.orig_addr_Invalid,le.orig_city_Invalid,le.orig_zip4_Invalid,le.orig_state_Invalid,le.orig_zip5_Invalid,le.email_Invalid,le.phone_Invalid,le.employer_Invalid,le.dt_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_LT_Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),Input_LT_Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),Input_LT_Fields.InvalidMessage_orig_addr(le.orig_addr_Invalid),Input_LT_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Input_LT_Fields.InvalidMessage_orig_zip4(le.orig_zip4_Invalid),Input_LT_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Input_LT_Fields.InvalidMessage_orig_zip5(le.orig_zip5_Invalid),Input_LT_Fields.InvalidMessage_email(le.email_Invalid),Input_LT_Fields.InvalidMessage_phone(le.phone_Invalid),Input_LT_Fields.InvalidMessage_employer(le.employer_Invalid),Input_LT_Fields.InvalidMessage_dt(le.dt_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_fname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_addr_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.employer_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_fname','orig_lname','orig_addr','orig_city','orig_zip4','orig_state','orig_zip5','email','phone','employer','dt','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_fname','invalid_lname','invalid_addr','invalid_city','invalid_zip4','invalid_state','invalid_zip5','invalid_email','invalid_phone','invalid_employer','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_lname,(SALT311.StrType)le.orig_addr,(SALT311.StrType)le.orig_city,(SALT311.StrType)le.orig_zip4,(SALT311.StrType)le.orig_state,(SALT311.StrType)le.orig_zip5,(SALT311.StrType)le.email,(SALT311.StrType)le.phone,(SALT311.StrType)le.employer,(SALT311.StrType)le.dt,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,11,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_LT_Layout_Thrive) prevDS = DATASET([], Input_LT_Layout_Thrive), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'orig_fname:invalid_fname:CUSTOM'
          ,'orig_lname:invalid_lname:CUSTOM'
          ,'orig_addr:invalid_addr:CUSTOM'
          ,'orig_city:invalid_city:CUSTOM'
          ,'orig_zip4:invalid_zip4:CUSTOM'
          ,'orig_state:invalid_state:CUSTOM'
          ,'orig_zip5:invalid_zip5:CUSTOM'
          ,'email:invalid_email:CUSTOM'
          ,'phone:invalid_phone:CUSTOM'
          ,'employer:invalid_employer:CUSTOM'
          ,'dt:invalid_date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_LT_Fields.InvalidMessage_orig_fname(1)
          ,Input_LT_Fields.InvalidMessage_orig_lname(1)
          ,Input_LT_Fields.InvalidMessage_orig_addr(1)
          ,Input_LT_Fields.InvalidMessage_orig_city(1)
          ,Input_LT_Fields.InvalidMessage_orig_zip4(1)
          ,Input_LT_Fields.InvalidMessage_orig_state(1)
          ,Input_LT_Fields.InvalidMessage_orig_zip5(1)
          ,Input_LT_Fields.InvalidMessage_email(1)
          ,Input_LT_Fields.InvalidMessage_phone(1)
          ,Input_LT_Fields.InvalidMessage_employer(1)
          ,Input_LT_Fields.InvalidMessage_dt(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.orig_fname_CUSTOM_ErrorCount
          ,le.orig_lname_CUSTOM_ErrorCount
          ,le.orig_addr_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_zip4_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip5_CUSTOM_ErrorCount
          ,le.email_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.employer_CUSTOM_ErrorCount
          ,le.dt_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.orig_fname_CUSTOM_ErrorCount
          ,le.orig_lname_CUSTOM_ErrorCount
          ,le.orig_addr_CUSTOM_ErrorCount
          ,le.orig_city_CUSTOM_ErrorCount
          ,le.orig_zip4_CUSTOM_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip5_CUSTOM_ErrorCount
          ,le.email_CUSTOM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.employer_CUSTOM_ErrorCount
          ,le.dt_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_LT_hygiene(PROJECT(h, Input_LT_Layout_Thrive));
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
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_addr:' + getFieldTypeText(h.orig_addr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip4:' + getFieldTypeText(h.orig_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip5:' + getFieldTypeText(h.orig_zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'employer:' + getFieldTypeText(h.employer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt:' + getFieldTypeText(h.dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_addr_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_zip4_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip5_cnt
          ,le.populated_email_cnt
          ,le.populated_phone_cnt
          ,le.populated_employer_cnt
          ,le.populated_dt_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_addr_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_zip4_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip5_pcnt
          ,le.populated_email_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_employer_pcnt
          ,le.populated_dt_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,11,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_LT_Delta(prevDS, PROJECT(h, Input_LT_Layout_Thrive));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),11,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_LT_Layout_Thrive) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Thrive, Input_LT_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
