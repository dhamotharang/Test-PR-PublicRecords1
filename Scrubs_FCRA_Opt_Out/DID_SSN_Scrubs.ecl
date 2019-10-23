IMPORT SALT38,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT DID_SSN_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 14;
  EXPORT NumRulesFromFieldType := 14;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(DID_SSN_Layout_FCRA_Opt_Out)
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 julian_date_Invalid;
    UNSIGNED1 inname_first_Invalid;
    UNSIGNED1 inname_last_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 ssn_append_Invalid;
    UNSIGNED1 permanent_flag_Invalid;
    UNSIGNED1 opt_back_in_Invalid;
    UNSIGNED1 date_yyyymmdd_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(DID_SSN_Layout_FCRA_Opt_Out)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(DID_SSN_Layout_FCRA_Opt_Out) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ssn_Invalid := DID_SSN_Fields.InValid_ssn((SALT38.StrType)le.ssn);
    SELF.julian_date_Invalid := DID_SSN_Fields.InValid_julian_date((SALT38.StrType)le.julian_date);
    SELF.inname_first_Invalid := DID_SSN_Fields.InValid_inname_first((SALT38.StrType)le.inname_first);
    SELF.inname_last_Invalid := DID_SSN_Fields.InValid_inname_last((SALT38.StrType)le.inname_last);
    SELF.state_Invalid := DID_SSN_Fields.InValid_state((SALT38.StrType)le.state);
    SELF.zip5_Invalid := DID_SSN_Fields.InValid_zip5((SALT38.StrType)le.zip5);
    SELF.ssn_append_Invalid := DID_SSN_Fields.InValid_ssn_append((SALT38.StrType)le.ssn_append);
    SELF.permanent_flag_Invalid := DID_SSN_Fields.InValid_permanent_flag((SALT38.StrType)le.permanent_flag);
    SELF.opt_back_in_Invalid := DID_SSN_Fields.InValid_opt_back_in((SALT38.StrType)le.opt_back_in);
    SELF.date_yyyymmdd_Invalid := DID_SSN_Fields.InValid_date_yyyymmdd((SALT38.StrType)le.date_yyyymmdd);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),DID_SSN_Layout_FCRA_Opt_Out);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ssn_Invalid << 0 ) + ( le.julian_date_Invalid << 1 ) + ( le.inname_first_Invalid << 3 ) + ( le.inname_last_Invalid << 4 ) + ( le.state_Invalid << 5 ) + ( le.zip5_Invalid << 7 ) + ( le.ssn_append_Invalid << 9 ) + ( le.permanent_flag_Invalid << 11 ) + ( le.opt_back_in_Invalid << 12 ) + ( le.date_yyyymmdd_Invalid << 13 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,DID_SSN_Layout_FCRA_Opt_Out);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.julian_date_Invalid := (le.ScrubsBits1 >> 1) & 3;
    SELF.inname_first_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.inname_last_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 5) & 3;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 7) & 3;
    SELF.ssn_append_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.permanent_flag_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.opt_back_in_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.date_yyyymmdd_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ssn_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    julian_date_ALLOW_ErrorCount := COUNT(GROUP,h.julian_date_Invalid=1);
    julian_date_LENGTH_ErrorCount := COUNT(GROUP,h.julian_date_Invalid=2);
    julian_date_Total_ErrorCount := COUNT(GROUP,h.julian_date_Invalid>0);
    inname_first_ALLOW_ErrorCount := COUNT(GROUP,h.inname_first_Invalid=1);
    inname_last_ALLOW_ErrorCount := COUNT(GROUP,h.inname_last_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_LENGTH_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
    ssn_append_ALLOW_ErrorCount := COUNT(GROUP,h.ssn_append_Invalid=1);
    ssn_append_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_append_Invalid=2);
    ssn_append_Total_ErrorCount := COUNT(GROUP,h.ssn_append_Invalid>0);
    permanent_flag_ENUM_ErrorCount := COUNT(GROUP,h.permanent_flag_Invalid=1);
    opt_back_in_ENUM_ErrorCount := COUNT(GROUP,h.opt_back_in_Invalid=1);
    date_yyyymmdd_CUSTOM_ErrorCount := COUNT(GROUP,h.date_yyyymmdd_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ssn_Invalid > 0 OR h.julian_date_Invalid > 0 OR h.inname_first_Invalid > 0 OR h.inname_last_Invalid > 0 OR h.state_Invalid > 0 OR h.zip5_Invalid > 0 OR h.ssn_append_Invalid > 0 OR h.permanent_flag_Invalid > 0 OR h.opt_back_in_Invalid > 0 OR h.date_yyyymmdd_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.julian_date_Total_ErrorCount > 0, 1, 0) + IF(le.inname_first_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inname_last_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zip5_Total_ErrorCount > 0, 1, 0) + IF(le.ssn_append_Total_ErrorCount > 0, 1, 0) + IF(le.permanent_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.opt_back_in_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_yyyymmdd_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ssn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.julian_date_ALLOW_ErrorCount > 0, 1, 0) + IF(le.julian_date_LENGTH_ErrorCount > 0, 1, 0) + IF(le.inname_first_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inname_last_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip5_LENGTH_ErrorCount > 0, 1, 0) + IF(le.ssn_append_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ssn_append_LENGTH_ErrorCount > 0, 1, 0) + IF(le.permanent_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.opt_back_in_ENUM_ErrorCount > 0, 1, 0) + IF(le.date_yyyymmdd_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ssn_Invalid,le.julian_date_Invalid,le.inname_first_Invalid,le.inname_last_Invalid,le.state_Invalid,le.zip5_Invalid,le.ssn_append_Invalid,le.permanent_flag_Invalid,le.opt_back_in_Invalid,le.date_yyyymmdd_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,DID_SSN_Fields.InvalidMessage_ssn(le.ssn_Invalid),DID_SSN_Fields.InvalidMessage_julian_date(le.julian_date_Invalid),DID_SSN_Fields.InvalidMessage_inname_first(le.inname_first_Invalid),DID_SSN_Fields.InvalidMessage_inname_last(le.inname_last_Invalid),DID_SSN_Fields.InvalidMessage_state(le.state_Invalid),DID_SSN_Fields.InvalidMessage_zip5(le.zip5_Invalid),DID_SSN_Fields.InvalidMessage_ssn_append(le.ssn_append_Invalid),DID_SSN_Fields.InvalidMessage_permanent_flag(le.permanent_flag_Invalid),DID_SSN_Fields.InvalidMessage_opt_back_in(le.opt_back_in_Invalid),DID_SSN_Fields.InvalidMessage_date_yyyymmdd(le.date_yyyymmdd_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ssn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.julian_date_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.inname_first_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inname_last_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_append_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.permanent_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.opt_back_in_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.date_yyyymmdd_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ssn','julian_date','inname_first','inname_last','state','zip5','ssn_append','permanent_flag','opt_back_in','date_yyyymmdd','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_SSN','Invalid_JullianDate','Invalid_Inname','Invalid_Inname','Invalid_State','Invalid_Zip','Invalid_SSN_append','Invalid_Flag','Invalid_Flag','Invalid_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.ssn,(SALT38.StrType)le.julian_date,(SALT38.StrType)le.inname_first,(SALT38.StrType)le.inname_last,(SALT38.StrType)le.state,(SALT38.StrType)le.zip5,(SALT38.StrType)le.ssn_append,(SALT38.StrType)le.permanent_flag,(SALT38.StrType)le.opt_back_in,(SALT38.StrType)le.date_yyyymmdd,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(DID_SSN_Layout_FCRA_Opt_Out) prevDS = DATASET([], DID_SSN_Layout_FCRA_Opt_Out), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'ssn:Invalid_SSN:ALLOW'
          ,'julian_date:Invalid_JullianDate:ALLOW','julian_date:Invalid_JullianDate:LENGTH'
          ,'inname_first:Invalid_Inname:ALLOW'
          ,'inname_last:Invalid_Inname:ALLOW'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTH'
          ,'zip5:Invalid_Zip:ALLOW','zip5:Invalid_Zip:LENGTH'
          ,'ssn_append:Invalid_SSN_append:ALLOW','ssn_append:Invalid_SSN_append:LENGTH'
          ,'permanent_flag:Invalid_Flag:ENUM'
          ,'opt_back_in:Invalid_Flag:ENUM'
          ,'date_yyyymmdd:Invalid_Date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,DID_SSN_Fields.InvalidMessage_ssn(1)
          ,DID_SSN_Fields.InvalidMessage_julian_date(1),DID_SSN_Fields.InvalidMessage_julian_date(2)
          ,DID_SSN_Fields.InvalidMessage_inname_first(1)
          ,DID_SSN_Fields.InvalidMessage_inname_last(1)
          ,DID_SSN_Fields.InvalidMessage_state(1),DID_SSN_Fields.InvalidMessage_state(2)
          ,DID_SSN_Fields.InvalidMessage_zip5(1),DID_SSN_Fields.InvalidMessage_zip5(2)
          ,DID_SSN_Fields.InvalidMessage_ssn_append(1),DID_SSN_Fields.InvalidMessage_ssn_append(2)
          ,DID_SSN_Fields.InvalidMessage_permanent_flag(1)
          ,DID_SSN_Fields.InvalidMessage_opt_back_in(1)
          ,DID_SSN_Fields.InvalidMessage_date_yyyymmdd(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.ssn_ALLOW_ErrorCount
          ,le.julian_date_ALLOW_ErrorCount,le.julian_date_LENGTH_ErrorCount
          ,le.inname_first_ALLOW_ErrorCount
          ,le.inname_last_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount
          ,le.ssn_append_ALLOW_ErrorCount,le.ssn_append_LENGTH_ErrorCount
          ,le.permanent_flag_ENUM_ErrorCount
          ,le.opt_back_in_ENUM_ErrorCount
          ,le.date_yyyymmdd_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ssn_ALLOW_ErrorCount
          ,le.julian_date_ALLOW_ErrorCount,le.julian_date_LENGTH_ErrorCount
          ,le.inname_first_ALLOW_ErrorCount
          ,le.inname_last_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTH_ErrorCount
          ,le.ssn_append_ALLOW_ErrorCount,le.ssn_append_LENGTH_ErrorCount
          ,le.permanent_flag_ENUM_ErrorCount
          ,le.opt_back_in_ENUM_ErrorCount
          ,le.date_yyyymmdd_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := DID_SSN_hygiene(PROJECT(h, DID_SSN_Layout_FCRA_Opt_Out));
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
          ,'ssn:' + getFieldTypeText(h.ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'source_flag:' + getFieldTypeText(h.source_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'julian_date:' + getFieldTypeText(h.julian_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inname_first:' + getFieldTypeText(h.inname_first) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inname_last:' + getFieldTypeText(h.inname_last) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ssn_append:' + getFieldTypeText(h.ssn_append) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permanent_flag:' + getFieldTypeText(h.permanent_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'opt_back_in:' + getFieldTypeText(h.opt_back_in) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_yyyymmdd:' + getFieldTypeText(h.date_yyyymmdd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ssn_cnt
          ,le.populated_did_cnt
          ,le.populated_source_flag_cnt
          ,le.populated_julian_date_cnt
          ,le.populated_inname_first_cnt
          ,le.populated_inname_last_cnt
          ,le.populated_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip5_cnt
          ,le.populated_did_score_cnt
          ,le.populated_ssn_append_cnt
          ,le.populated_permanent_flag_cnt
          ,le.populated_opt_back_in_cnt
          ,le.populated_date_yyyymmdd_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ssn_pcnt
          ,le.populated_did_pcnt
          ,le.populated_source_flag_pcnt
          ,le.populated_julian_date_pcnt
          ,le.populated_inname_first_pcnt
          ,le.populated_inname_last_pcnt
          ,le.populated_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip5_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_ssn_append_pcnt
          ,le.populated_permanent_flag_pcnt
          ,le.populated_opt_back_in_pcnt
          ,le.populated_date_yyyymmdd_pcnt,0);
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
 
    mod_Delta := DID_SSN_Delta(prevDS, PROJECT(h, DID_SSN_Layout_FCRA_Opt_Out));
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
 
EXPORT StandardStats(DATASET(DID_SSN_Layout_FCRA_Opt_Out) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_FCRA_Opt_Out, DID_SSN_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
