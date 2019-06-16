IMPORT SALT311,STD;
IMPORT Scrubs_BBB2; // Import modules for FieldTypes attribute definitions
EXPORT raw_NonMember_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(raw_NonMember_Layout_BBB2)
    UNSIGNED1 bbb_id_Invalid;
    UNSIGNED1 company_name_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 phone_type_Invalid;
    UNSIGNED1 listing_year_Invalid;
    UNSIGNED1 http_link_Invalid;
    UNSIGNED1 non_member_title_Invalid;
    UNSIGNED1 non_member_category_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(raw_NonMember_Layout_BBB2)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(raw_NonMember_Layout_BBB2) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.bbb_id_Invalid := raw_NonMember_Fields.InValid_bbb_id((SALT311.StrType)le.bbb_id);
    SELF.company_name_Invalid := raw_NonMember_Fields.InValid_company_name((SALT311.StrType)le.company_name);
    SELF.address_Invalid := raw_NonMember_Fields.InValid_address((SALT311.StrType)le.address);
    SELF.country_Invalid := raw_NonMember_Fields.InValid_country((SALT311.StrType)le.country);
    SELF.phone_Invalid := raw_NonMember_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.phone_type_Invalid := raw_NonMember_Fields.InValid_phone_type((SALT311.StrType)le.phone_type);
    SELF.listing_year_Invalid := raw_NonMember_Fields.InValid_listing_year((SALT311.StrType)le.listing_year,(SALT311.StrType)le.listing_month,(SALT311.StrType)le.listing_day);
    SELF.http_link_Invalid := raw_NonMember_Fields.InValid_http_link((SALT311.StrType)le.http_link);
    SELF.non_member_title_Invalid := raw_NonMember_Fields.InValid_non_member_title((SALT311.StrType)le.non_member_title);
    SELF.non_member_category_Invalid := raw_NonMember_Fields.InValid_non_member_category((SALT311.StrType)le.non_member_category);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),raw_NonMember_Layout_BBB2);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.bbb_id_Invalid << 0 ) + ( le.company_name_Invalid << 1 ) + ( le.address_Invalid << 2 ) + ( le.country_Invalid << 3 ) + ( le.phone_Invalid << 4 ) + ( le.phone_type_Invalid << 5 ) + ( le.listing_year_Invalid << 6 ) + ( le.http_link_Invalid << 7 ) + ( le.non_member_title_Invalid << 8 ) + ( le.non_member_category_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,raw_NonMember_Layout_BBB2);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.bbb_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.company_name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.address_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.phone_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.listing_year_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.http_link_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.non_member_title_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.non_member_category_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    bbb_id_CUSTOM_ErrorCount := COUNT(GROUP,h.bbb_id_Invalid=1);
    company_name_CUSTOM_ErrorCount := COUNT(GROUP,h.company_name_Invalid=1);
    address_CUSTOM_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    country_ENUM_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    phone_CUSTOM_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_type_ENUM_ErrorCount := COUNT(GROUP,h.phone_type_Invalid=1);
    listing_year_CUSTOM_ErrorCount := COUNT(GROUP,h.listing_year_Invalid=1);
    http_link_CUSTOM_ErrorCount := COUNT(GROUP,h.http_link_Invalid=1);
    non_member_title_CUSTOM_ErrorCount := COUNT(GROUP,h.non_member_title_Invalid=1);
    non_member_category_CUSTOM_ErrorCount := COUNT(GROUP,h.non_member_category_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.bbb_id_Invalid > 0 OR h.company_name_Invalid > 0 OR h.address_Invalid > 0 OR h.country_Invalid > 0 OR h.phone_Invalid > 0 OR h.phone_type_Invalid > 0 OR h.listing_year_Invalid > 0 OR h.http_link_Invalid > 0 OR h.non_member_title_Invalid > 0 OR h.non_member_category_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.bbb_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.country_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.listing_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.http_link_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.non_member_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.non_member_category_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.bbb_id_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.company_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.country_ENUM_ErrorCount > 0, 1, 0) + IF(le.phone_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.phone_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.listing_year_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.http_link_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.non_member_title_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.non_member_category_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.bbb_id_Invalid,le.company_name_Invalid,le.address_Invalid,le.country_Invalid,le.phone_Invalid,le.phone_type_Invalid,le.listing_year_Invalid,le.http_link_Invalid,le.non_member_title_Invalid,le.non_member_category_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,raw_NonMember_Fields.InvalidMessage_bbb_id(le.bbb_id_Invalid),raw_NonMember_Fields.InvalidMessage_company_name(le.company_name_Invalid),raw_NonMember_Fields.InvalidMessage_address(le.address_Invalid),raw_NonMember_Fields.InvalidMessage_country(le.country_Invalid),raw_NonMember_Fields.InvalidMessage_phone(le.phone_Invalid),raw_NonMember_Fields.InvalidMessage_phone_type(le.phone_type_Invalid),raw_NonMember_Fields.InvalidMessage_listing_year(le.listing_year_Invalid),raw_NonMember_Fields.InvalidMessage_http_link(le.http_link_Invalid),raw_NonMember_Fields.InvalidMessage_non_member_title(le.non_member_title_Invalid),raw_NonMember_Fields.InvalidMessage_non_member_category(le.non_member_category_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.bbb_id_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.company_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.phone_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.listing_year_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.http_link_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.non_member_title_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.non_member_category_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'bbb_id','company_name','address','country','phone','phone_type','listing_year','http_link','non_member_title','non_member_category','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_bbb_id','invalid_chk_blanks','invalid_chk_addr','invalid_country','invalid_phone','invalid_phone_type','invalid_listing_year','invalid_http_link','invalid_chk_blanks','invalid_chk_blanks','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.bbb_id,(SALT311.StrType)le.company_name,(SALT311.StrType)le.address,(SALT311.StrType)le.country,(SALT311.StrType)le.phone,(SALT311.StrType)le.phone_type,(SALT311.StrType)le.listing_year,(SALT311.StrType)le.http_link,(SALT311.StrType)le.non_member_title,(SALT311.StrType)le.non_member_category,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(raw_NonMember_Layout_BBB2) prevDS = DATASET([], raw_NonMember_Layout_BBB2), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'bbb_id:invalid_bbb_id:CUSTOM'
          ,'company_name:invalid_chk_blanks:CUSTOM'
          ,'address:invalid_chk_addr:CUSTOM'
          ,'country:invalid_country:ENUM'
          ,'phone:invalid_phone:CUSTOM'
          ,'phone_type:invalid_phone_type:ENUM'
          ,'listing_year:invalid_listing_year:CUSTOM'
          ,'http_link:invalid_http_link:CUSTOM'
          ,'non_member_title:invalid_chk_blanks:CUSTOM'
          ,'non_member_category:invalid_chk_blanks:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,raw_NonMember_Fields.InvalidMessage_bbb_id(1)
          ,raw_NonMember_Fields.InvalidMessage_company_name(1)
          ,raw_NonMember_Fields.InvalidMessage_address(1)
          ,raw_NonMember_Fields.InvalidMessage_country(1)
          ,raw_NonMember_Fields.InvalidMessage_phone(1)
          ,raw_NonMember_Fields.InvalidMessage_phone_type(1)
          ,raw_NonMember_Fields.InvalidMessage_listing_year(1)
          ,raw_NonMember_Fields.InvalidMessage_http_link(1)
          ,raw_NonMember_Fields.InvalidMessage_non_member_title(1)
          ,raw_NonMember_Fields.InvalidMessage_non_member_category(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.bbb_id_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.address_CUSTOM_ErrorCount
          ,le.country_ENUM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.listing_year_CUSTOM_ErrorCount
          ,le.http_link_CUSTOM_ErrorCount
          ,le.non_member_title_CUSTOM_ErrorCount
          ,le.non_member_category_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.bbb_id_CUSTOM_ErrorCount
          ,le.company_name_CUSTOM_ErrorCount
          ,le.address_CUSTOM_ErrorCount
          ,le.country_ENUM_ErrorCount
          ,le.phone_CUSTOM_ErrorCount
          ,le.phone_type_ENUM_ErrorCount
          ,le.listing_year_CUSTOM_ErrorCount
          ,le.http_link_CUSTOM_ErrorCount
          ,le.non_member_title_CUSTOM_ErrorCount
          ,le.non_member_category_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := raw_NonMember_hygiene(PROJECT(h, raw_NonMember_Layout_BBB2));
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
          ,'bbb_id:' + getFieldTypeText(h.bbb_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_type:' + getFieldTypeText(h.phone_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'listing_month:' + getFieldTypeText(h.listing_month) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'listing_day:' + getFieldTypeText(h.listing_day) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'listing_year:' + getFieldTypeText(h.listing_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'http_link:' + getFieldTypeText(h.http_link) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_member_title:' + getFieldTypeText(h.non_member_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'non_member_category:' + getFieldTypeText(h.non_member_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_bbb_id_cnt
          ,le.populated_company_name_cnt
          ,le.populated_address_cnt
          ,le.populated_country_cnt
          ,le.populated_phone_cnt
          ,le.populated_phone_type_cnt
          ,le.populated_listing_month_cnt
          ,le.populated_listing_day_cnt
          ,le.populated_listing_year_cnt
          ,le.populated_http_link_cnt
          ,le.populated_non_member_title_cnt
          ,le.populated_non_member_category_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_bbb_id_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_address_pcnt
          ,le.populated_country_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_phone_type_pcnt
          ,le.populated_listing_month_pcnt
          ,le.populated_listing_day_pcnt
          ,le.populated_listing_year_pcnt
          ,le.populated_http_link_pcnt
          ,le.populated_non_member_title_pcnt
          ,le.populated_non_member_category_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,12,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := raw_NonMember_Delta(prevDS, PROJECT(h, raw_NonMember_Layout_BBB2));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),12,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(raw_NonMember_Layout_BBB2) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_BBB2, raw_NonMember_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
