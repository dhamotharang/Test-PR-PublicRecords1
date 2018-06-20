IMPORT SALT38,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 24;
  EXPORT NumRulesFromFieldType := 24;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 12;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_RealSource)
    UNSIGNED1 firstname_Invalid;
    UNSIGNED1 middleinit_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 zipplus4_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 datestamp_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_RealSource)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_RealSource) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.firstname_Invalid := Fields.InValid_firstname((SALT38.StrType)le.firstname);
    SELF.middleinit_Invalid := Fields.InValid_middleinit((SALT38.StrType)le.middleinit);
    SELF.lastname_Invalid := Fields.InValid_lastname((SALT38.StrType)le.lastname);
    SELF.suffix_Invalid := Fields.InValid_suffix((SALT38.StrType)le.suffix);
    SELF.address_Invalid := Fields.InValid_address((SALT38.StrType)le.address);
    SELF.city_Invalid := Fields.InValid_city((SALT38.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT38.StrType)le.state);
    SELF.zipcode_Invalid := Fields.InValid_zipcode((SALT38.StrType)le.zipcode);
    SELF.zipplus4_Invalid := Fields.InValid_zipplus4((SALT38.StrType)le.zipplus4);
    SELF.phone_Invalid := Fields.InValid_phone((SALT38.StrType)le.phone);
    SELF.dob_Invalid := Fields.InValid_dob((SALT38.StrType)le.dob);
    SELF.datestamp_Invalid := Fields.InValid_datestamp((SALT38.StrType)le.datestamp);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_RealSource);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.firstname_Invalid << 0 ) + ( le.middleinit_Invalid << 2 ) + ( le.lastname_Invalid << 4 ) + ( le.suffix_Invalid << 6 ) + ( le.address_Invalid << 8 ) + ( le.city_Invalid << 10 ) + ( le.state_Invalid << 12 ) + ( le.zipcode_Invalid << 14 ) + ( le.zipplus4_Invalid << 16 ) + ( le.phone_Invalid << 18 ) + ( le.dob_Invalid << 20 ) + ( le.datestamp_Invalid << 22 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_RealSource);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.firstname_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.middleinit_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.address_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.zipplus4_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.datestamp_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    firstname_ALLOW_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
    firstname_LENGTH_ErrorCount := COUNT(GROUP,h.firstname_Invalid=2);
    firstname_Total_ErrorCount := COUNT(GROUP,h.firstname_Invalid>0);
    middleinit_ALLOW_ErrorCount := COUNT(GROUP,h.middleinit_Invalid=1);
    middleinit_LENGTH_ErrorCount := COUNT(GROUP,h.middleinit_Invalid=2);
    middleinit_Total_ErrorCount := COUNT(GROUP,h.middleinit_Invalid>0);
    lastname_ALLOW_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    lastname_LENGTH_ErrorCount := COUNT(GROUP,h.lastname_Invalid=2);
    lastname_Total_ErrorCount := COUNT(GROUP,h.lastname_Invalid>0);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    suffix_LENGTH_ErrorCount := COUNT(GROUP,h.suffix_Invalid=2);
    suffix_Total_ErrorCount := COUNT(GROUP,h.suffix_Invalid>0);
    address_ALLOW_ErrorCount := COUNT(GROUP,h.address_Invalid=1);
    address_LENGTH_ErrorCount := COUNT(GROUP,h.address_Invalid=2);
    address_Total_ErrorCount := COUNT(GROUP,h.address_Invalid>0);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_LENGTH_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zipcode_ALLOW_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    zipcode_LENGTH_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=2);
    zipcode_Total_ErrorCount := COUNT(GROUP,h.zipcode_Invalid>0);
    zipplus4_ALLOW_ErrorCount := COUNT(GROUP,h.zipplus4_Invalid=1);
    zipplus4_LENGTH_ErrorCount := COUNT(GROUP,h.zipplus4_Invalid=2);
    zipplus4_Total_ErrorCount := COUNT(GROUP,h.zipplus4_Invalid>0);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTH_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    datestamp_ALLOW_ErrorCount := COUNT(GROUP,h.datestamp_Invalid=1);
    datestamp_LENGTH_ErrorCount := COUNT(GROUP,h.datestamp_Invalid=2);
    datestamp_Total_ErrorCount := COUNT(GROUP,h.datestamp_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.firstname_Invalid > 0 OR h.middleinit_Invalid > 0 OR h.lastname_Invalid > 0 OR h.suffix_Invalid > 0 OR h.address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zipcode_Invalid > 0 OR h.zipplus4_Invalid > 0 OR h.phone_Invalid > 0 OR h.dob_Invalid > 0 OR h.datestamp_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.firstname_Total_ErrorCount > 0, 1, 0) + IF(le.middleinit_Total_ErrorCount > 0, 1, 0) + IF(le.lastname_Total_ErrorCount > 0, 1, 0) + IF(le.suffix_Total_ErrorCount > 0, 1, 0) + IF(le.address_Total_ErrorCount > 0, 1, 0) + IF(le.city_Total_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zipcode_Total_ErrorCount > 0, 1, 0) + IF(le.zipplus4_Total_ErrorCount > 0, 1, 0) + IF(le.phone_Total_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.datestamp_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firstname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.middleinit_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middleinit_LENGTH_ErrorCount > 0, 1, 0) + IF(le.lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastname_LENGTH_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_LENGTH_ErrorCount > 0, 1, 0) + IF(le.address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address_LENGTH_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_LENGTH_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zipcode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zipcode_LENGTH_ErrorCount > 0, 1, 0) + IF(le.zipplus4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zipplus4_LENGTH_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_LENGTH_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_LENGTH_ErrorCount > 0, 1, 0) + IF(le.datestamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datestamp_LENGTH_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.firstname_Invalid,le.middleinit_Invalid,le.lastname_Invalid,le.suffix_Invalid,le.address_Invalid,le.city_Invalid,le.state_Invalid,le.zipcode_Invalid,le.zipplus4_Invalid,le.phone_Invalid,le.dob_Invalid,le.datestamp_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_firstname(le.firstname_Invalid),Fields.InvalidMessage_middleinit(le.middleinit_Invalid),Fields.InvalidMessage_lastname(le.lastname_Invalid),Fields.InvalidMessage_suffix(le.suffix_Invalid),Fields.InvalidMessage_address(le.address_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Fields.InvalidMessage_zipplus4(le.zipplus4_Invalid),Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_datestamp(le.datestamp_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.firstname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.middleinit_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.address_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zipplus4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.datestamp_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'firstname','middleinit','lastname','suffix','address','city','state','zipcode','zipplus4','phone','dob','datestamp','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_name','invalid_name','invalid_name','invalid_suffix','invalid_alnum','invalid_alpha','invalid_state','invalid_zip5','invalid_zip4','invalid_phone','invalid_date','invalid_date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT38.StrType)le.firstname,(SALT38.StrType)le.middleinit,(SALT38.StrType)le.lastname,(SALT38.StrType)le.suffix,(SALT38.StrType)le.address,(SALT38.StrType)le.city,(SALT38.StrType)le.state,(SALT38.StrType)le.zipcode,(SALT38.StrType)le.zipplus4,(SALT38.StrType)le.phone,(SALT38.StrType)le.dob,(SALT38.StrType)le.datestamp,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,12,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_RealSource) prevDS = DATASET([], Layout_RealSource), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT38.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'firstname:invalid_name:ALLOW','firstname:invalid_name:LENGTH'
          ,'middleinit:invalid_name:ALLOW','middleinit:invalid_name:LENGTH'
          ,'lastname:invalid_name:ALLOW','lastname:invalid_name:LENGTH'
          ,'suffix:invalid_suffix:ALLOW','suffix:invalid_suffix:LENGTH'
          ,'address:invalid_alnum:ALLOW','address:invalid_alnum:LENGTH'
          ,'city:invalid_alpha:ALLOW','city:invalid_alpha:LENGTH'
          ,'state:invalid_state:ALLOW','state:invalid_state:LENGTH'
          ,'zipcode:invalid_zip5:ALLOW','zipcode:invalid_zip5:LENGTH'
          ,'zipplus4:invalid_zip4:ALLOW','zipplus4:invalid_zip4:LENGTH'
          ,'phone:invalid_phone:ALLOW','phone:invalid_phone:LENGTH'
          ,'dob:invalid_date:ALLOW','dob:invalid_date:LENGTH'
          ,'datestamp:invalid_date:ALLOW','datestamp:invalid_date:LENGTH'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_firstname(1),Fields.InvalidMessage_firstname(2)
          ,Fields.InvalidMessage_middleinit(1),Fields.InvalidMessage_middleinit(2)
          ,Fields.InvalidMessage_lastname(1),Fields.InvalidMessage_lastname(2)
          ,Fields.InvalidMessage_suffix(1),Fields.InvalidMessage_suffix(2)
          ,Fields.InvalidMessage_address(1),Fields.InvalidMessage_address(2)
          ,Fields.InvalidMessage_city(1),Fields.InvalidMessage_city(2)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_zipcode(1),Fields.InvalidMessage_zipcode(2)
          ,Fields.InvalidMessage_zipplus4(1),Fields.InvalidMessage_zipplus4(2)
          ,Fields.InvalidMessage_phone(1),Fields.InvalidMessage_phone(2)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2)
          ,Fields.InvalidMessage_datestamp(1),Fields.InvalidMessage_datestamp(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.firstname_ALLOW_ErrorCount,le.firstname_LENGTH_ErrorCount
          ,le.middleinit_ALLOW_ErrorCount,le.middleinit_LENGTH_ErrorCount
          ,le.lastname_ALLOW_ErrorCount,le.lastname_LENGTH_ErrorCount
          ,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount
          ,le.address_ALLOW_ErrorCount,le.address_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount
          ,le.zipplus4_ALLOW_ErrorCount,le.zipplus4_LENGTH_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.datestamp_ALLOW_ErrorCount,le.datestamp_LENGTH_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.firstname_ALLOW_ErrorCount,le.firstname_LENGTH_ErrorCount
          ,le.middleinit_ALLOW_ErrorCount,le.middleinit_LENGTH_ErrorCount
          ,le.lastname_ALLOW_ErrorCount,le.lastname_LENGTH_ErrorCount
          ,le.suffix_ALLOW_ErrorCount,le.suffix_LENGTH_ErrorCount
          ,le.address_ALLOW_ErrorCount,le.address_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount,le.city_LENGTH_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zipcode_ALLOW_ErrorCount,le.zipcode_LENGTH_ErrorCount
          ,le.zipplus4_ALLOW_ErrorCount,le.zipplus4_LENGTH_ErrorCount
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTH_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.datestamp_ALLOW_ErrorCount,le.datestamp_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_RealSource));
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
          ,'firstname:' + getFieldTypeText(h.firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middleinit:' + getFieldTypeText(h.middleinit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastname:' + getFieldTypeText(h.lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address:' + getFieldTypeText(h.address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipcode:' + getFieldTypeText(h.zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipplus4:' + getFieldTypeText(h.zipplus4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ipaddr:' + getFieldTypeText(h.ipaddr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'datestamp:' + getFieldTypeText(h.datestamp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'url:' + getFieldTypeText(h.url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_firstname_cnt
          ,le.populated_middleinit_cnt
          ,le.populated_lastname_cnt
          ,le.populated_suffix_cnt
          ,le.populated_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zipcode_cnt
          ,le.populated_zipplus4_cnt
          ,le.populated_phone_cnt
          ,le.populated_dob_cnt
          ,le.populated_email_cnt
          ,le.populated_ipaddr_cnt
          ,le.populated_datestamp_cnt
          ,le.populated_url_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_firstname_pcnt
          ,le.populated_middleinit_pcnt
          ,le.populated_lastname_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zipcode_pcnt
          ,le.populated_zipplus4_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_email_pcnt
          ,le.populated_ipaddr_pcnt
          ,le.populated_datestamp_pcnt
          ,le.populated_url_pcnt,0);
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_RealSource));
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
 
EXPORT StandardStats(DATASET(Layout_RealSource) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT38.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_RealSource, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
