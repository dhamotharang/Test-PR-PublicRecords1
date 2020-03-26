IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 30;
  EXPORT NumRulesFromFieldType := 30;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_DunnData_Email)
    UNSIGNED1 name_full_Invalid;
    UNSIGNED1 address1_Invalid;
    UNSIGNED1 address2_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 ipaddr_Invalid;
    UNSIGNED1 datestamp_Invalid;
    UNSIGNED1 url_Invalid;
    UNSIGNED1 lastdate_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_DunnData_Email)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_DunnData_Email) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.name_full_Invalid := Fields.InValid_name_full((SALT311.StrType)le.name_full);
    SELF.address1_Invalid := Fields.InValid_address1((SALT311.StrType)le.address1);
    SELF.address2_Invalid := Fields.InValid_address2((SALT311.StrType)le.address2);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT311.StrType)le.zip5);
    SELF.ipaddr_Invalid := Fields.InValid_ipaddr((SALT311.StrType)le.ipaddr);
    SELF.datestamp_Invalid := Fields.InValid_datestamp((SALT311.StrType)le.datestamp);
    SELF.url_Invalid := Fields.InValid_url((SALT311.StrType)le.url);
    SELF.lastdate_Invalid := Fields.InValid_lastdate((SALT311.StrType)le.lastdate);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_DunnData_Email);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.name_full_Invalid << 0 ) + ( le.address1_Invalid << 2 ) + ( le.address2_Invalid << 4 ) + ( le.city_Invalid << 6 ) + ( le.state_Invalid << 8 ) + ( le.zip5_Invalid << 10 ) + ( le.ipaddr_Invalid << 12 ) + ( le.datestamp_Invalid << 14 ) + ( le.url_Invalid << 16 ) + ( le.lastdate_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_DunnData_Email);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.name_full_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.address1_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.address2_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.city_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.state_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.ipaddr_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.datestamp_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.url_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.lastdate_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    name_full_LEFTTRIM_ErrorCount := COUNT(GROUP,h.name_full_Invalid=1);
    name_full_ALLOW_ErrorCount := COUNT(GROUP,h.name_full_Invalid=2);
    name_full_WORDS_ErrorCount := COUNT(GROUP,h.name_full_Invalid=3);
    name_full_Total_ErrorCount := COUNT(GROUP,h.name_full_Invalid>0);
    address1_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address1_Invalid=1);
    address1_ALLOW_ErrorCount := COUNT(GROUP,h.address1_Invalid=2);
    address1_LENGTHS_ErrorCount := COUNT(GROUP,h.address1_Invalid=3);
    address1_Total_ErrorCount := COUNT(GROUP,h.address1_Invalid>0);
    address2_LEFTTRIM_ErrorCount := COUNT(GROUP,h.address2_Invalid=1);
    address2_ALLOW_ErrorCount := COUNT(GROUP,h.address2_Invalid=2);
    address2_LENGTHS_ErrorCount := COUNT(GROUP,h.address2_Invalid=3);
    address2_Total_ErrorCount := COUNT(GROUP,h.address2_Invalid>0);
    city_LEFTTRIM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=2);
    city_LENGTHS_ErrorCount := COUNT(GROUP,h.city_Invalid=3);
    city_Total_ErrorCount := COUNT(GROUP,h.city_Invalid>0);
    state_LEFTTRIM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=3);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip5_LEFTTRIM_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=2);
    zip5_LENGTHS_ErrorCount := COUNT(GROUP,h.zip5_Invalid=3);
    zip5_Total_ErrorCount := COUNT(GROUP,h.zip5_Invalid>0);
    ipaddr_LEFTTRIM_ErrorCount := COUNT(GROUP,h.ipaddr_Invalid=1);
    ipaddr_ALLOW_ErrorCount := COUNT(GROUP,h.ipaddr_Invalid=2);
    ipaddr_LENGTHS_ErrorCount := COUNT(GROUP,h.ipaddr_Invalid=3);
    ipaddr_Total_ErrorCount := COUNT(GROUP,h.ipaddr_Invalid>0);
    datestamp_LEFTTRIM_ErrorCount := COUNT(GROUP,h.datestamp_Invalid=1);
    datestamp_ALLOW_ErrorCount := COUNT(GROUP,h.datestamp_Invalid=2);
    datestamp_LENGTHS_ErrorCount := COUNT(GROUP,h.datestamp_Invalid=3);
    datestamp_Total_ErrorCount := COUNT(GROUP,h.datestamp_Invalid>0);
    url_LEFTTRIM_ErrorCount := COUNT(GROUP,h.url_Invalid=1);
    url_ALLOW_ErrorCount := COUNT(GROUP,h.url_Invalid=2);
    url_LENGTHS_ErrorCount := COUNT(GROUP,h.url_Invalid=3);
    url_Total_ErrorCount := COUNT(GROUP,h.url_Invalid>0);
    lastdate_LEFTTRIM_ErrorCount := COUNT(GROUP,h.lastdate_Invalid=1);
    lastdate_ALLOW_ErrorCount := COUNT(GROUP,h.lastdate_Invalid=2);
    lastdate_LENGTHS_ErrorCount := COUNT(GROUP,h.lastdate_Invalid=3);
    lastdate_Total_ErrorCount := COUNT(GROUP,h.lastdate_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.name_full_Invalid > 0 OR h.address1_Invalid > 0 OR h.address2_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip5_Invalid > 0 OR h.ipaddr_Invalid > 0 OR h.datestamp_Invalid > 0 OR h.url_Invalid > 0 OR h.lastdate_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.name_full_Total_ErrorCount > 0, 1, 0) + IF(le.address1_Total_ErrorCount > 0, 1, 0) + IF(le.address2_Total_ErrorCount > 0, 1, 0) + IF(le.city_Total_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.zip5_Total_ErrorCount > 0, 1, 0) + IF(le.ipaddr_Total_ErrorCount > 0, 1, 0) + IF(le.datestamp_Total_ErrorCount > 0, 1, 0) + IF(le.url_Total_ErrorCount > 0, 1, 0) + IF(le.lastdate_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.name_full_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.name_full_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_full_WORDS_ErrorCount > 0, 1, 0) + IF(le.address1_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.address2_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.address2_ALLOW_ErrorCount > 0, 1, 0) + IF(le.address2_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.city_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.state_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.zip5_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip5_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ipaddr_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.ipaddr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ipaddr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.datestamp_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.datestamp_ALLOW_ErrorCount > 0, 1, 0) + IF(le.datestamp_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.url_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.url_ALLOW_ErrorCount > 0, 1, 0) + IF(le.url_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.lastdate_LEFTTRIM_ErrorCount > 0, 1, 0) + IF(le.lastdate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastdate_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.name_full_Invalid,le.address1_Invalid,le.address2_Invalid,le.city_Invalid,le.state_Invalid,le.zip5_Invalid,le.ipaddr_Invalid,le.datestamp_Invalid,le.url_Invalid,le.lastdate_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_name_full(le.name_full_Invalid),Fields.InvalidMessage_address1(le.address1_Invalid),Fields.InvalidMessage_address2(le.address2_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_ipaddr(le.ipaddr_Invalid),Fields.InvalidMessage_datestamp(le.datestamp_Invalid),Fields.InvalidMessage_url(le.url_Invalid),Fields.InvalidMessage_lastdate(le.lastdate_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.name_full_Invalid,'LEFTTRIM','ALLOW','WORDS','UNKNOWN')
          ,CHOOSE(le.address1_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.address2_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ipaddr_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.datestamp_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.url_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.lastdate_Invalid,'LEFTTRIM','ALLOW','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'name_full','address1','address2','city','state','zip5','ipaddr','datestamp','url','lastdate','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_name','invalid_address1','invalid_address2','invalid_city','invalid_state','invalid_zip','invalid_ip','invalid_datestamp','invalid_url','invalid_lastdate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.name_full,(SALT311.StrType)le.address1,(SALT311.StrType)le.address2,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip5,(SALT311.StrType)le.ipaddr,(SALT311.StrType)le.datestamp,(SALT311.StrType)le.url,(SALT311.StrType)le.lastdate,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_DunnData_Email) prevDS = DATASET([], Layout_DunnData_Email), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'name_full:invalid_name:LEFTTRIM','name_full:invalid_name:ALLOW','name_full:invalid_name:WORDS'
          ,'address1:invalid_address1:LEFTTRIM','address1:invalid_address1:ALLOW','address1:invalid_address1:LENGTHS'
          ,'address2:invalid_address2:LEFTTRIM','address2:invalid_address2:ALLOW','address2:invalid_address2:LENGTHS'
          ,'city:invalid_city:LEFTTRIM','city:invalid_city:ALLOW','city:invalid_city:LENGTHS'
          ,'state:invalid_state:LEFTTRIM','state:invalid_state:ALLOW','state:invalid_state:LENGTHS'
          ,'zip5:invalid_zip:LEFTTRIM','zip5:invalid_zip:ALLOW','zip5:invalid_zip:LENGTHS'
          ,'ipaddr:invalid_ip:LEFTTRIM','ipaddr:invalid_ip:ALLOW','ipaddr:invalid_ip:LENGTHS'
          ,'datestamp:invalid_datestamp:LEFTTRIM','datestamp:invalid_datestamp:ALLOW','datestamp:invalid_datestamp:LENGTHS'
          ,'url:invalid_url:LEFTTRIM','url:invalid_url:ALLOW','url:invalid_url:LENGTHS'
          ,'lastdate:invalid_lastdate:LEFTTRIM','lastdate:invalid_lastdate:ALLOW','lastdate:invalid_lastdate:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_name_full(1),Fields.InvalidMessage_name_full(2),Fields.InvalidMessage_name_full(3)
          ,Fields.InvalidMessage_address1(1),Fields.InvalidMessage_address1(2),Fields.InvalidMessage_address1(3)
          ,Fields.InvalidMessage_address2(1),Fields.InvalidMessage_address2(2),Fields.InvalidMessage_address2(3)
          ,Fields.InvalidMessage_city(1),Fields.InvalidMessage_city(2),Fields.InvalidMessage_city(3)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2),Fields.InvalidMessage_state(3)
          ,Fields.InvalidMessage_zip5(1),Fields.InvalidMessage_zip5(2),Fields.InvalidMessage_zip5(3)
          ,Fields.InvalidMessage_ipaddr(1),Fields.InvalidMessage_ipaddr(2),Fields.InvalidMessage_ipaddr(3)
          ,Fields.InvalidMessage_datestamp(1),Fields.InvalidMessage_datestamp(2),Fields.InvalidMessage_datestamp(3)
          ,Fields.InvalidMessage_url(1),Fields.InvalidMessage_url(2),Fields.InvalidMessage_url(3)
          ,Fields.InvalidMessage_lastdate(1),Fields.InvalidMessage_lastdate(2),Fields.InvalidMessage_lastdate(3)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.name_full_LEFTTRIM_ErrorCount,le.name_full_ALLOW_ErrorCount,le.name_full_WORDS_ErrorCount
          ,le.address1_LEFTTRIM_ErrorCount,le.address1_ALLOW_ErrorCount,le.address1_LENGTHS_ErrorCount
          ,le.address2_LEFTTRIM_ErrorCount,le.address2_ALLOW_ErrorCount,le.address2_LENGTHS_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount,le.city_LENGTHS_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip5_LEFTTRIM_ErrorCount,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTHS_ErrorCount
          ,le.ipaddr_LEFTTRIM_ErrorCount,le.ipaddr_ALLOW_ErrorCount,le.ipaddr_LENGTHS_ErrorCount
          ,le.datestamp_LEFTTRIM_ErrorCount,le.datestamp_ALLOW_ErrorCount,le.datestamp_LENGTHS_ErrorCount
          ,le.url_LEFTTRIM_ErrorCount,le.url_ALLOW_ErrorCount,le.url_LENGTHS_ErrorCount
          ,le.lastdate_LEFTTRIM_ErrorCount,le.lastdate_ALLOW_ErrorCount,le.lastdate_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.name_full_LEFTTRIM_ErrorCount,le.name_full_ALLOW_ErrorCount,le.name_full_WORDS_ErrorCount
          ,le.address1_LEFTTRIM_ErrorCount,le.address1_ALLOW_ErrorCount,le.address1_LENGTHS_ErrorCount
          ,le.address2_LEFTTRIM_ErrorCount,le.address2_ALLOW_ErrorCount,le.address2_LENGTHS_ErrorCount
          ,le.city_LEFTTRIM_ErrorCount,le.city_ALLOW_ErrorCount,le.city_LENGTHS_ErrorCount
          ,le.state_LEFTTRIM_ErrorCount,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.zip5_LEFTTRIM_ErrorCount,le.zip5_ALLOW_ErrorCount,le.zip5_LENGTHS_ErrorCount
          ,le.ipaddr_LEFTTRIM_ErrorCount,le.ipaddr_ALLOW_ErrorCount,le.ipaddr_LENGTHS_ErrorCount
          ,le.datestamp_LEFTTRIM_ErrorCount,le.datestamp_ALLOW_ErrorCount,le.datestamp_LENGTHS_ErrorCount
          ,le.url_LEFTTRIM_ErrorCount,le.url_ALLOW_ErrorCount,le.url_LENGTHS_ErrorCount
          ,le.lastdate_LEFTTRIM_ErrorCount,le.lastdate_ALLOW_ErrorCount,le.lastdate_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_DunnData_Email));
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
          ,'dtmatch:' + getFieldTypeText(h.dtmatch) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_full:' + getFieldTypeText(h.name_full) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_ext:' + getFieldTypeText(h.zip_ext) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ipaddr:' + getFieldTypeText(h.ipaddr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'datestamp:' + getFieldTypeText(h.datestamp) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'url:' + getFieldTypeText(h.url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastdate:' + getFieldTypeText(h.lastdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'em_src_cnt:' + getFieldTypeText(h.em_src_cnt) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'num_emails:' + getFieldTypeText(h.num_emails) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'num_indiv:' + getFieldTypeText(h.num_indiv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dtmatch_cnt
          ,le.populated_email_cnt
          ,le.populated_name_full_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip5_cnt
          ,le.populated_zip_ext_cnt
          ,le.populated_ipaddr_cnt
          ,le.populated_datestamp_cnt
          ,le.populated_url_cnt
          ,le.populated_lastdate_cnt
          ,le.populated_em_src_cnt_cnt
          ,le.populated_num_emails_cnt
          ,le.populated_num_indiv_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dtmatch_pcnt
          ,le.populated_email_pcnt
          ,le.populated_name_full_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip5_pcnt
          ,le.populated_zip_ext_pcnt
          ,le.populated_ipaddr_pcnt
          ,le.populated_datestamp_pcnt
          ,le.populated_url_pcnt
          ,le.populated_lastdate_pcnt
          ,le.populated_em_src_cnt_pcnt
          ,le.populated_num_emails_pcnt
          ,le.populated_num_indiv_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,16,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_DunnData_Email));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),16,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_DunnData_Email) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DunnData_Email, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
