﻿IMPORT SALT311,STD;
EXPORT Identities_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 11;
  EXPORT NumRulesFromFieldType := 11;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 9;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Identities_Layout_PhoneFinder)
    UNSIGNED1 transaction_id_Invalid;
    UNSIGNED1 sequence_number_Invalid;
    UNSIGNED1 lexid_Invalid;
    UNSIGNED1 full_name_Invalid;
    UNSIGNED1 full_address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 verified_carrier_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Identities_Layout_PhoneFinder)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Identities_Layout_PhoneFinder)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'transaction_id:Invalid_ID:ALLOW'
          ,'sequence_number:Invalid_No:ALLOW'
          ,'lexid:Invalid_No:ALLOW'
          ,'full_name:Invalid_AlphaChar:ALLOW'
          ,'full_address:Invalid_AlphaNumChar:ALLOW'
          ,'city:Invalid_AlphaChar:ALLOW'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'zip:Invalid_Zip:ALLOW','zip:Invalid_Zip:LENGTHS'
          ,'verified_carrier:Invalid_No:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Identities_Fields.InvalidMessage_transaction_id(1)
          ,Identities_Fields.InvalidMessage_sequence_number(1)
          ,Identities_Fields.InvalidMessage_lexid(1)
          ,Identities_Fields.InvalidMessage_full_name(1)
          ,Identities_Fields.InvalidMessage_full_address(1)
          ,Identities_Fields.InvalidMessage_city(1)
          ,Identities_Fields.InvalidMessage_state(1),Identities_Fields.InvalidMessage_state(2)
          ,Identities_Fields.InvalidMessage_zip(1),Identities_Fields.InvalidMessage_zip(2)
          ,Identities_Fields.InvalidMessage_verified_carrier(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Identities_Layout_PhoneFinder) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.transaction_id_Invalid := Identities_Fields.InValid_transaction_id((SALT311.StrType)le.transaction_id);
    SELF.sequence_number_Invalid := Identities_Fields.InValid_sequence_number((SALT311.StrType)le.sequence_number);
    SELF.lexid_Invalid := Identities_Fields.InValid_lexid((SALT311.StrType)le.lexid);
    SELF.full_name_Invalid := Identities_Fields.InValid_full_name((SALT311.StrType)le.full_name);
    SELF.full_address_Invalid := Identities_Fields.InValid_full_address((SALT311.StrType)le.full_address);
    SELF.city_Invalid := Identities_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Identities_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_Invalid := Identities_Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.verified_carrier_Invalid := Identities_Fields.InValid_verified_carrier((SALT311.StrType)le.verified_carrier);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Identities_Layout_PhoneFinder);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.transaction_id_Invalid << 0 ) + ( le.sequence_number_Invalid << 1 ) + ( le.lexid_Invalid << 2 ) + ( le.full_name_Invalid << 3 ) + ( le.full_address_Invalid << 4 ) + ( le.city_Invalid << 5 ) + ( le.state_Invalid << 6 ) + ( le.zip_Invalid << 8 ) + ( le.verified_carrier_Invalid << 10 );
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
  EXPORT Infile := PROJECT(h,Identities_Layout_PhoneFinder);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.transaction_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.sequence_number_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.lexid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.full_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.full_address_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.verified_carrier_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    transaction_id_ALLOW_ErrorCount := COUNT(GROUP,h.transaction_id_Invalid=1);
    sequence_number_ALLOW_ErrorCount := COUNT(GROUP,h.sequence_number_Invalid=1);
    lexid_ALLOW_ErrorCount := COUNT(GROUP,h.lexid_Invalid=1);
    full_name_ALLOW_ErrorCount := COUNT(GROUP,h.full_name_Invalid=1);
    full_address_ALLOW_ErrorCount := COUNT(GROUP,h.full_address_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    verified_carrier_ALLOW_ErrorCount := COUNT(GROUP,h.verified_carrier_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.transaction_id_Invalid > 0 OR h.sequence_number_Invalid > 0 OR h.lexid_Invalid > 0 OR h.full_name_Invalid > 0 OR h.full_address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_Invalid > 0 OR h.verified_carrier_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sequence_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lexid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.full_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.verified_carrier_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.transaction_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sequence_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lexid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.full_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.full_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.verified_carrier_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.transaction_id_Invalid,le.sequence_number_Invalid,le.lexid_Invalid,le.full_name_Invalid,le.full_address_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.verified_carrier_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Identities_Fields.InvalidMessage_transaction_id(le.transaction_id_Invalid),Identities_Fields.InvalidMessage_sequence_number(le.sequence_number_Invalid),Identities_Fields.InvalidMessage_lexid(le.lexid_Invalid),Identities_Fields.InvalidMessage_full_name(le.full_name_Invalid),Identities_Fields.InvalidMessage_full_address(le.full_address_Invalid),Identities_Fields.InvalidMessage_city(le.city_Invalid),Identities_Fields.InvalidMessage_state(le.state_Invalid),Identities_Fields.InvalidMessage_zip(le.zip_Invalid),Identities_Fields.InvalidMessage_verified_carrier(le.verified_carrier_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.transaction_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sequence_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lexid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.full_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.full_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.verified_carrier_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'transaction_id','sequence_number','lexid','full_name','full_address','city','state','zip','verified_carrier','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_ID','Invalid_No','Invalid_No','Invalid_AlphaChar','Invalid_AlphaNumChar','Invalid_AlphaChar','Invalid_State','Invalid_Zip','Invalid_No','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.transaction_id,(SALT311.StrType)le.sequence_number,(SALT311.StrType)le.lexid,(SALT311.StrType)le.full_name,(SALT311.StrType)le.full_address,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip,(SALT311.StrType)le.verified_carrier,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Identities_Layout_PhoneFinder) prevDS = DATASET([], Identities_Layout_PhoneFinder), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.sequence_number_ALLOW_ErrorCount
          ,le.lexid_ALLOW_ErrorCount
          ,le.full_name_ALLOW_ErrorCount
          ,le.full_address_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.verified_carrier_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.transaction_id_ALLOW_ErrorCount
          ,le.sequence_number_ALLOW_ErrorCount
          ,le.lexid_ALLOW_ErrorCount
          ,le.full_name_ALLOW_ErrorCount
          ,le.full_address_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.verified_carrier_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Identities_hygiene(PROJECT(h, Identities_Layout_PhoneFinder));
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
          ,'sequence_number:' + getFieldTypeText(h.sequence_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lexid:' + getFieldTypeText(h.lexid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_name:' + getFieldTypeText(h.full_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'full_address:' + getFieldTypeText(h.full_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'verified_carrier:' + getFieldTypeText(h.verified_carrier) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_transaction_id_cnt
          ,le.populated_sequence_number_cnt
          ,le.populated_lexid_cnt
          ,le.populated_full_name_cnt
          ,le.populated_full_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_verified_carrier_cnt
          ,le.populated_date_added_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_transaction_id_pcnt
          ,le.populated_sequence_number_pcnt
          ,le.populated_lexid_pcnt
          ,le.populated_full_name_pcnt
          ,le.populated_full_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_verified_carrier_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_filename_pcnt,0);
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
 
    mod_Delta := Identities_Delta(prevDS, PROJECT(h, Identities_Layout_PhoneFinder));
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
 
EXPORT StandardStats(DATASET(Identities_Layout_PhoneFinder) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhoneFinder, Identities_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
