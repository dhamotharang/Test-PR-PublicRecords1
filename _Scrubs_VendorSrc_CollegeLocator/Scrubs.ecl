IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 9;
  EXPORT NumRulesFromFieldType := 9;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 9;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_CollegeLocator)
    UNSIGNED1 lnfilecategory_Invalid;
    UNSIGNED1 lnsourcetcode_Invalid;
    UNSIGNED1 vendorname_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 address2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 phone_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_CollegeLocator)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_CollegeLocator) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.lnfilecategory_Invalid := Fields.InValid_lnfilecategory((SALT311.StrType)le.lnfilecategory);
    SELF.lnsourcetcode_Invalid := Fields.InValid_lnsourcetcode((SALT311.StrType)le.lnsourcetcode);
    SELF.vendorname_Invalid := Fields.InValid_vendorname((SALT311.StrType)le.vendorname);
    SELF.address1_Invalid := Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.address2_Invalid := Fields.InValid_address2((SALT311.StrType)le.address2);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zipcode_Invalid := Fields.InValid_zipcode((SALT311.StrType)le.zipcode);
    SELF.phone_Invalid := Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_CollegeLocator);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.lnfilecategory_Invalid << 0 ) + ( le.lnsourcetcode_Invalid << 1 ) + ( le.vendorname_Invalid << 2 ) + ( le.address1_Invalid << 3 ) + ( le.address2_Invalid << 4 ) + ( le.city_Invalid << 5 ) + ( le.state_Invalid << 6 ) + ( le.zipcode_Invalid << 7 ) + ( le.phone_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_CollegeLocator);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.lnfilecategory_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.lnsourcetcode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.vendorname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.address2_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    lnfilecategory_ALLOW_ErrorCount := COUNT(GROUP,h.lnfilecategory_Invalid=1);
    lnsourcetcode_ALLOW_ErrorCount := COUNT(GROUP,h.lnsourcetcode_Invalid=1);
    vendorname_ALLOW_ErrorCount := COUNT(GROUP,h.vendorname_Invalid=1);
    address1_ALLOW_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    address2_ALLOW_ErrorCount := COUNT(GROUP,h.address2_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.lnfilecategory_Invalid > 0 OR h.lnsourcetcode_Invalid > 0 OR h.vendorname_Invalid > 0 OR h.address1_Invalid > 0 OR h.address2_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zipcode_Invalid > 0 OR h.phone_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.lnfilecategory_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lnsourcetcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendorname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.lnfilecategory_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lnsourcetcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.vendorname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.lnfilecategory_Invalid,le.lnsourcetcode_Invalid,le.vendorname_Invalid,le.address1_Invalid,le.address2_Invalid,le.city_Invalid,le.state_Invalid,le.zipcode_Invalid,le.phone_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_lnfilecategory(le.lnfilecategory_Invalid),Fields.InvalidMessage_lnsourcetcode(le.lnsourcetcode_Invalid),Fields.InvalidMessage_vendorname(le.vendorname_Invalid),Fields.InvalidMessage_address1(le.address1_Invalid),Fields.InvalidMessage_address2(le.address2_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Fields.InvalidMessage_phone(le.phone_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.lnfilecategory_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lnsourcetcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.vendorname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address2_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'lnfilecategory','lnsourcetcode','vendorname','address1','address2','city','state','zipcode','phone','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_lnfilecategory','Invalid_lnsourcetcode','Invalid_vendorname','Invalid_address1','Invalid_address2','Invalid_city','Invalid_state','Invalid_numbers','Invalid_numbers','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.lnfilecategory,(SALT311.StrType)le.lnsourcetcode,(SALT311.StrType)le.vendorname,(SALT311.StrType)le.address1,(SALT311.StrType)le.address2,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zipcode,(SALT311.StrType)le.phone,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_CollegeLocator) prevDS = DATASET([], Layout_CollegeLocator), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'lnfilecategory:Invalid_lnfilecategory:ALLOW'
          ,'lnsourcetcode:Invalid_lnsourcetcode:ALLOW'
          ,'vendorname:Invalid_vendorname:ALLOW'
          ,'address1:Invalid_address1:ALLOW'
          ,'address2:Invalid_address2:ALLOW'
          ,'city:Invalid_city:ALLOW'
          ,'state:Invalid_state:ALLOW'
          ,'zipcode:Invalid_numbers:ALLOW'
          ,'phone:Invalid_numbers:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_lnfilecategory(1)
          ,Fields.InvalidMessage_lnsourcetcode(1)
          ,Fields.InvalidMessage_vendorname(1)
          ,Fields.InvalidMessage_address1(1)
          ,Fields.InvalidMessage_address2(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1)
          ,Fields.InvalidMessage_zipcode(1)
          ,Fields.InvalidMessage_phone(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.lnfilecategory_ALLOW_ErrorCount
          ,le.lnsourcetcode_ALLOW_ErrorCount
          ,le.vendorname_ALLOW_ErrorCount
          ,le.address1_ALLOW_ErrorCount
          ,le.address2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.lnfilecategory_ALLOW_ErrorCount
          ,le.lnsourcetcode_ALLOW_ErrorCount
          ,le.vendorname_ALLOW_ErrorCount
          ,le.address1_ALLOW_ErrorCount
          ,le.address2_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_CollegeLocator));
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
          ,'lnfilecategory:' + getFieldTypeText(h.lnfilecategory) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lnsourcetcode:' + getFieldTypeText(h.lnsourcetcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendorname:' + getFieldTypeText(h.vendorname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipcode:' + getFieldTypeText(h.zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_lnfilecategory_cnt
          ,le.populated_lnsourcetcode_cnt
          ,le.populated_vendorname_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zipcode_cnt
          ,le.populated_phone_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_lnfilecategory_pcnt
          ,le.populated_lnsourcetcode_pcnt
          ,le.populated_vendorname_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zipcode_pcnt
          ,le.populated_phone_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,9,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_CollegeLocator));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),9,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_CollegeLocator) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(_Scrubs_VendorSrc_CollegeLocator, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
