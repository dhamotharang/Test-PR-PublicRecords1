IMPORT SALT39,STD;
EXPORT In_Port_Daily_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(In_Port_Daily_Layout_PhonesInfo)
    UNSIGNED1 action_code_Invalid;
    UNSIGNED1 country_code_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 dial_type_Invalid;
    UNSIGNED1 spid_Invalid;
    UNSIGNED1 service_type_Invalid;
    UNSIGNED1 routing_code_Invalid;
    UNSIGNED1 porting_dt_Invalid;
    UNSIGNED1 country_abbr_Invalid;
    UNSIGNED1 filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(In_Port_Daily_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(In_Port_Daily_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.action_code_Invalid := In_Port_Daily_Fields.InValid_action_code((SALT39.StrType)le.action_code);
    SELF.country_code_Invalid := In_Port_Daily_Fields.InValid_country_code((SALT39.StrType)le.country_code);
    SELF.phone_Invalid := In_Port_Daily_Fields.InValid_phone((SALT39.StrType)le.phone);
    SELF.dial_type_Invalid := In_Port_Daily_Fields.InValid_dial_type((SALT39.StrType)le.dial_type);
    SELF.spid_Invalid := In_Port_Daily_Fields.InValid_spid((SALT39.StrType)le.spid);
    SELF.service_type_Invalid := In_Port_Daily_Fields.InValid_service_type((SALT39.StrType)le.service_type);
    SELF.routing_code_Invalid := In_Port_Daily_Fields.InValid_routing_code((SALT39.StrType)le.routing_code);
    SELF.porting_dt_Invalid := In_Port_Daily_Fields.InValid_porting_dt((SALT39.StrType)le.porting_dt);
    SELF.country_abbr_Invalid := In_Port_Daily_Fields.InValid_country_abbr((SALT39.StrType)le.country_abbr);
    SELF.filename_Invalid := In_Port_Daily_Fields.InValid_filename((SALT39.StrType)le.filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),In_Port_Daily_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.action_code_Invalid << 0 ) + ( le.country_code_Invalid << 1 ) + ( le.phone_Invalid << 2 ) + ( le.dial_type_Invalid << 3 ) + ( le.spid_Invalid << 4 ) + ( le.service_type_Invalid << 5 ) + ( le.routing_code_Invalid << 6 ) + ( le.porting_dt_Invalid << 7 ) + ( le.country_abbr_Invalid << 8 ) + ( le.filename_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,In_Port_Daily_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.action_code_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.country_code_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dial_type_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.spid_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.service_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.routing_code_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.porting_dt_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.country_abbr_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    action_code_ALLOW_ErrorCount := COUNT(GROUP,h.action_code_Invalid=1);
    country_code_ALLOW_ErrorCount := COUNT(GROUP,h.country_code_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    dial_type_ALLOW_ErrorCount := COUNT(GROUP,h.dial_type_Invalid=1);
    spid_ALLOW_ErrorCount := COUNT(GROUP,h.spid_Invalid=1);
    service_type_ALLOW_ErrorCount := COUNT(GROUP,h.service_type_Invalid=1);
    routing_code_ALLOW_ErrorCount := COUNT(GROUP,h.routing_code_Invalid=1);
    porting_dt_ALLOW_ErrorCount := COUNT(GROUP,h.porting_dt_Invalid=1);
    country_abbr_ALLOW_ErrorCount := COUNT(GROUP,h.country_abbr_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.action_code_Invalid > 0 OR h.country_code_Invalid > 0 OR h.phone_Invalid > 0 OR h.dial_type_Invalid > 0 OR h.spid_Invalid > 0 OR h.service_type_Invalid > 0 OR h.routing_code_Invalid > 0 OR h.porting_dt_Invalid > 0 OR h.country_abbr_Invalid > 0 OR h.filename_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.action_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dial_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.service_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.porting_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_abbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.action_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dial_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.spid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.service_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.routing_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.porting_dt_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_abbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
    SELF.Rules_NoErrors := NumRules - SELF.Rules_WithErrors;
    SELF := le;
  END;
  EXPORT SummaryStats := PROJECT(SummaryStats0, xAddErrSummary(LEFT));
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT39.StrType ErrorMessage;
    SALT39.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.action_code_Invalid,le.country_code_Invalid,le.phone_Invalid,le.dial_type_Invalid,le.spid_Invalid,le.service_type_Invalid,le.routing_code_Invalid,le.porting_dt_Invalid,le.country_abbr_Invalid,le.filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,In_Port_Daily_Fields.InvalidMessage_action_code(le.action_code_Invalid),In_Port_Daily_Fields.InvalidMessage_country_code(le.country_code_Invalid),In_Port_Daily_Fields.InvalidMessage_phone(le.phone_Invalid),In_Port_Daily_Fields.InvalidMessage_dial_type(le.dial_type_Invalid),In_Port_Daily_Fields.InvalidMessage_spid(le.spid_Invalid),In_Port_Daily_Fields.InvalidMessage_service_type(le.service_type_Invalid),In_Port_Daily_Fields.InvalidMessage_routing_code(le.routing_code_Invalid),In_Port_Daily_Fields.InvalidMessage_porting_dt(le.porting_dt_Invalid),In_Port_Daily_Fields.InvalidMessage_country_abbr(le.country_abbr_Invalid),In_Port_Daily_Fields.InvalidMessage_filename(le.filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.action_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dial_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.spid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.service_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.routing_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.porting_dt_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_abbr_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'action_code','country_code','phone','dial_type','spid','service_type','routing_code','porting_dt','country_abbr','filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Action_Code','Invalid_Num','Invalid_Num','Invalid_DCT','Invalid_Num','Invalid_TOS','Invalid_Num_Blank','Invalid_Port_Date','Invalid_ISO2','Invalid_Filename','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT39.StrType)le.action_code,(SALT39.StrType)le.country_code,(SALT39.StrType)le.phone,(SALT39.StrType)le.dial_type,(SALT39.StrType)le.spid,(SALT39.StrType)le.service_type,(SALT39.StrType)le.routing_code,(SALT39.StrType)le.porting_dt,(SALT39.StrType)le.country_abbr,(SALT39.StrType)le.filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(In_Port_Daily_Layout_PhonesInfo) prevDS = DATASET([], In_Port_Daily_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT39.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'action_code:Invalid_Action_Code:ALLOW'
          ,'country_code:Invalid_Num:ALLOW'
          ,'phone:Invalid_Num:ALLOW'
          ,'dial_type:Invalid_DCT:ALLOW'
          ,'spid:Invalid_Num:ALLOW'
          ,'service_type:Invalid_TOS:ALLOW'
          ,'routing_code:Invalid_Num_Blank:ALLOW'
          ,'porting_dt:Invalid_Port_Date:ALLOW'
          ,'country_abbr:Invalid_ISO2:ALLOW'
          ,'filename:Invalid_Filename:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,In_Port_Daily_Fields.InvalidMessage_action_code(1)
          ,In_Port_Daily_Fields.InvalidMessage_country_code(1)
          ,In_Port_Daily_Fields.InvalidMessage_phone(1)
          ,In_Port_Daily_Fields.InvalidMessage_dial_type(1)
          ,In_Port_Daily_Fields.InvalidMessage_spid(1)
          ,In_Port_Daily_Fields.InvalidMessage_service_type(1)
          ,In_Port_Daily_Fields.InvalidMessage_routing_code(1)
          ,In_Port_Daily_Fields.InvalidMessage_porting_dt(1)
          ,In_Port_Daily_Fields.InvalidMessage_country_abbr(1)
          ,In_Port_Daily_Fields.InvalidMessage_filename(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.action_code_ALLOW_ErrorCount
          ,le.country_code_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.dial_type_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.service_type_ALLOW_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.porting_dt_ALLOW_ErrorCount
          ,le.country_abbr_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.action_code_ALLOW_ErrorCount
          ,le.country_code_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.dial_type_ALLOW_ErrorCount
          ,le.spid_ALLOW_ErrorCount
          ,le.service_type_ALLOW_ErrorCount
          ,le.routing_code_ALLOW_ErrorCount
          ,le.porting_dt_ALLOW_ErrorCount
          ,le.country_abbr_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
      SALT39.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT39.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := In_Port_Daily_hygiene(PROJECT(h, In_Port_Daily_Layout_PhonesInfo));
    hygiene_summaryStats := mod_hygiene.Summary('');
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT39.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'action_code:' + getFieldTypeText(h.action_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country_code:' + getFieldTypeText(h.country_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dial_type:' + getFieldTypeText(h.dial_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'spid:' + getFieldTypeText(h.spid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'service_type:' + getFieldTypeText(h.service_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'routing_code:' + getFieldTypeText(h.routing_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'porting_dt:' + getFieldTypeText(h.porting_dt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country_abbr:' + getFieldTypeText(h.country_abbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_action_code_cnt
          ,le.populated_country_code_cnt
          ,le.populated_phone_cnt
          ,le.populated_dial_type_cnt
          ,le.populated_spid_cnt
          ,le.populated_service_type_cnt
          ,le.populated_routing_code_cnt
          ,le.populated_porting_dt_cnt
          ,le.populated_country_abbr_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_action_code_pcnt
          ,le.populated_country_code_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_dial_type_pcnt
          ,le.populated_spid_pcnt
          ,le.populated_service_type_pcnt
          ,le.populated_routing_code_pcnt
          ,le.populated_porting_dt_pcnt
          ,le.populated_country_abbr_pcnt
          ,le.populated_filename_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,10,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT39.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := In_Port_Daily_Delta(prevDS, PROJECT(h, In_Port_Daily_Layout_PhonesInfo));
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
 
EXPORT StandardStats(DATASET(In_Port_Daily_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT39.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, In_Port_Daily_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT39.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT39.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
