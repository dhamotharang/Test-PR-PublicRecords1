IMPORT SALT311,STD;
IMPORT Scrubs_OPM; // Import modules for FieldTypes attribute definitions
EXPORT raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(raw_Layout_OPM)
    UNSIGNED1 employee_name_Invalid;
    UNSIGNED1 duty_station_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 agency_Invalid;
    UNSIGNED1 agency_sub_element_Invalid;
    UNSIGNED1 computation_date_Invalid;
    UNSIGNED1 occupational_series_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(raw_Layout_OPM)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(raw_Layout_OPM) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.employee_name_Invalid := raw_Fields.InValid_employee_name((SALT311.StrType)le.employee_name);
    SELF.duty_station_Invalid := raw_Fields.InValid_duty_station((SALT311.StrType)le.duty_station);
    SELF.country_Invalid := raw_Fields.InValid_country((SALT311.StrType)le.country);
    SELF.state_Invalid := raw_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.city_Invalid := raw_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.county_Invalid := raw_Fields.InValid_county((SALT311.StrType)le.county);
    SELF.agency_Invalid := raw_Fields.InValid_agency((SALT311.StrType)le.agency);
    SELF.agency_sub_element_Invalid := raw_Fields.InValid_agency_sub_element((SALT311.StrType)le.agency_sub_element);
    SELF.computation_date_Invalid := raw_Fields.InValid_computation_date((SALT311.StrType)le.computation_date);
    SELF.occupational_series_Invalid := raw_Fields.InValid_occupational_series((SALT311.StrType)le.occupational_series);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),raw_Layout_OPM);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.employee_name_Invalid << 0 ) + ( le.duty_station_Invalid << 1 ) + ( le.country_Invalid << 2 ) + ( le.state_Invalid << 3 ) + ( le.city_Invalid << 4 ) + ( le.county_Invalid << 5 ) + ( le.agency_Invalid << 6 ) + ( le.agency_sub_element_Invalid << 7 ) + ( le.computation_date_Invalid << 8 ) + ( le.occupational_series_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,raw_Layout_OPM);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.employee_name_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.duty_station_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.agency_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.agency_sub_element_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.computation_date_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.occupational_series_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    employee_name_ALLOW_ErrorCount := COUNT(GROUP,h.employee_name_Invalid=1);
    duty_station_ALLOW_ErrorCount := COUNT(GROUP,h.duty_station_Invalid=1);
    country_ALLOW_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    agency_ALLOW_ErrorCount := COUNT(GROUP,h.agency_Invalid=1);
    agency_sub_element_ALLOW_ErrorCount := COUNT(GROUP,h.agency_sub_element_Invalid=1);
    computation_date_CUSTOM_ErrorCount := COUNT(GROUP,h.computation_date_Invalid=1);
    occupational_series_CUSTOM_ErrorCount := COUNT(GROUP,h.occupational_series_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.employee_name_Invalid > 0 OR h.duty_station_Invalid > 0 OR h.country_Invalid > 0 OR h.state_Invalid > 0 OR h.city_Invalid > 0 OR h.county_Invalid > 0 OR h.agency_Invalid > 0 OR h.agency_sub_element_Invalid > 0 OR h.computation_date_Invalid > 0 OR h.occupational_series_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.employee_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.duty_station_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.agency_ALLOW_ErrorCount > 0, 1, 0) + IF(le.agency_sub_element_ALLOW_ErrorCount > 0, 1, 0) + IF(le.computation_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occupational_series_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.employee_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.duty_station_ALLOW_ErrorCount > 0, 1, 0) + IF(le.country_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.agency_ALLOW_ErrorCount > 0, 1, 0) + IF(le.agency_sub_element_ALLOW_ErrorCount > 0, 1, 0) + IF(le.computation_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.occupational_series_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.employee_name_Invalid,le.duty_station_Invalid,le.country_Invalid,le.state_Invalid,le.city_Invalid,le.county_Invalid,le.agency_Invalid,le.agency_sub_element_Invalid,le.computation_date_Invalid,le.occupational_series_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,raw_Fields.InvalidMessage_employee_name(le.employee_name_Invalid),raw_Fields.InvalidMessage_duty_station(le.duty_station_Invalid),raw_Fields.InvalidMessage_country(le.country_Invalid),raw_Fields.InvalidMessage_state(le.state_Invalid),raw_Fields.InvalidMessage_city(le.city_Invalid),raw_Fields.InvalidMessage_county(le.county_Invalid),raw_Fields.InvalidMessage_agency(le.agency_Invalid),raw_Fields.InvalidMessage_agency_sub_element(le.agency_sub_element_Invalid),raw_Fields.InvalidMessage_computation_date(le.computation_date_Invalid),raw_Fields.InvalidMessage_occupational_series(le.occupational_series_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.employee_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.duty_station_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.agency_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.agency_sub_element_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.computation_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.occupational_series_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'employee_name','duty_station','country','state','city','county','agency','agency_sub_element','computation_date','occupational_series','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_name','invalid_alpha_num','invalid_country','invalid_alpha_blank','invalid_alpha_blank_sp','invalid_alpha_blank_sp','invalid_alpha_num_sp','invalid_alpha_num_sp','invalid_past_date','invalid_occu_Series_cd','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.employee_name,(SALT311.StrType)le.duty_station,(SALT311.StrType)le.country,(SALT311.StrType)le.state,(SALT311.StrType)le.city,(SALT311.StrType)le.county,(SALT311.StrType)le.agency,(SALT311.StrType)le.agency_sub_element,(SALT311.StrType)le.computation_date,(SALT311.StrType)le.occupational_series,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(raw_Layout_OPM) prevDS = DATASET([], raw_Layout_OPM), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'employee_name:invalid_name:ALLOW'
          ,'duty_station:invalid_alpha_num:ALLOW'
          ,'country:invalid_country:ALLOW'
          ,'state:invalid_alpha_blank:ALLOW'
          ,'city:invalid_alpha_blank_sp:ALLOW'
          ,'county:invalid_alpha_blank_sp:ALLOW'
          ,'agency:invalid_alpha_num_sp:ALLOW'
          ,'agency_sub_element:invalid_alpha_num_sp:ALLOW'
          ,'computation_date:invalid_past_date:CUSTOM'
          ,'occupational_series:invalid_occu_Series_cd:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,raw_Fields.InvalidMessage_employee_name(1)
          ,raw_Fields.InvalidMessage_duty_station(1)
          ,raw_Fields.InvalidMessage_country(1)
          ,raw_Fields.InvalidMessage_state(1)
          ,raw_Fields.InvalidMessage_city(1)
          ,raw_Fields.InvalidMessage_county(1)
          ,raw_Fields.InvalidMessage_agency(1)
          ,raw_Fields.InvalidMessage_agency_sub_element(1)
          ,raw_Fields.InvalidMessage_computation_date(1)
          ,raw_Fields.InvalidMessage_occupational_series(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.employee_name_ALLOW_ErrorCount
          ,le.duty_station_ALLOW_ErrorCount
          ,le.country_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.agency_ALLOW_ErrorCount
          ,le.agency_sub_element_ALLOW_ErrorCount
          ,le.computation_date_CUSTOM_ErrorCount
          ,le.occupational_series_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.employee_name_ALLOW_ErrorCount
          ,le.duty_station_ALLOW_ErrorCount
          ,le.country_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.agency_ALLOW_ErrorCount
          ,le.agency_sub_element_ALLOW_ErrorCount
          ,le.computation_date_CUSTOM_ErrorCount
          ,le.occupational_series_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := raw_hygiene(PROJECT(h, raw_Layout_OPM));
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
          ,'employee_name:' + getFieldTypeText(h.employee_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duty_station:' + getFieldTypeText(h.duty_station) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'agency:' + getFieldTypeText(h.agency) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'agency_sub_element:' + getFieldTypeText(h.agency_sub_element) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'computation_date:' + getFieldTypeText(h.computation_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'occupational_series:' + getFieldTypeText(h.occupational_series) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'file_date:' + getFieldTypeText(h.file_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_employee_name_cnt
          ,le.populated_duty_station_cnt
          ,le.populated_country_cnt
          ,le.populated_state_cnt
          ,le.populated_city_cnt
          ,le.populated_county_cnt
          ,le.populated_agency_cnt
          ,le.populated_agency_sub_element_cnt
          ,le.populated_computation_date_cnt
          ,le.populated_occupational_series_cnt
          ,le.populated_file_date_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_employee_name_pcnt
          ,le.populated_duty_station_pcnt
          ,le.populated_country_pcnt
          ,le.populated_state_pcnt
          ,le.populated_city_pcnt
          ,le.populated_county_pcnt
          ,le.populated_agency_pcnt
          ,le.populated_agency_sub_element_pcnt
          ,le.populated_computation_date_pcnt
          ,le.populated_occupational_series_pcnt
          ,le.populated_file_date_pcnt,0);
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
 
    mod_Delta := raw_Delta(prevDS, PROJECT(h, raw_Layout_OPM));
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
 
EXPORT StandardStats(DATASET(raw_Layout_OPM) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_OPM, raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
