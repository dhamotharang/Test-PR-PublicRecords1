IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_DL_MI; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 19;
  EXPORT NumRulesFromFieldType := 19;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_MI)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 code_Invalid;
    UNSIGNED1 customer_dln_pid_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 street_address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 date_of_birth_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 county_Invalid;
    UNSIGNED1 dln_pid_indicator_Invalid;
    UNSIGNED1 mailing_street_address_Invalid;
    UNSIGNED1 mailing_city_Invalid;
    UNSIGNED1 mailing_state_Invalid;
    UNSIGNED1 mailing_zipcode_Invalid;
    UNSIGNED1 clean_fname_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_MI)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_MI) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.code_Invalid := Fields.InValid_code((SALT311.StrType)le.code);
    SELF.customer_dln_pid_Invalid := Fields.InValid_customer_dln_pid((SALT311.StrType)le.customer_dln_pid);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT311.StrType)le.first_name,(SALT311.StrType)le.middle_name,(SALT311.StrType)le.last_name);
    SELF.street_address_Invalid := Fields.InValid_street_address((SALT311.StrType)le.street_address);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zipcode_Invalid := Fields.InValid_zipcode((SALT311.StrType)le.zipcode);
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT311.StrType)le.date_of_birth);
    SELF.gender_Invalid := Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.county_Invalid := Fields.InValid_county((SALT311.StrType)le.county);
    SELF.dln_pid_indicator_Invalid := Fields.InValid_dln_pid_indicator((SALT311.StrType)le.dln_pid_indicator);
    SELF.mailing_street_address_Invalid := Fields.InValid_mailing_street_address((SALT311.StrType)le.mailing_street_address);
    SELF.mailing_city_Invalid := Fields.InValid_mailing_city((SALT311.StrType)le.mailing_city);
    SELF.mailing_state_Invalid := Fields.InValid_mailing_state((SALT311.StrType)le.mailing_state);
    SELF.mailing_zipcode_Invalid := Fields.InValid_mailing_zipcode((SALT311.StrType)le.mailing_zipcode);
    SELF.clean_fname_Invalid := Fields.InValid_clean_fname((SALT311.StrType)le.clean_fname,(SALT311.StrType)le.clean_mname,(SALT311.StrType)le.clean_lname);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_MI);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.code_Invalid << 2 ) + ( le.customer_dln_pid_Invalid << 3 ) + ( le.first_name_Invalid << 4 ) + ( le.street_address_Invalid << 5 ) + ( le.city_Invalid << 6 ) + ( le.state_Invalid << 7 ) + ( le.zipcode_Invalid << 8 ) + ( le.date_of_birth_Invalid << 9 ) + ( le.gender_Invalid << 11 ) + ( le.county_Invalid << 12 ) + ( le.dln_pid_indicator_Invalid << 13 ) + ( le.mailing_street_address_Invalid << 14 ) + ( le.mailing_city_Invalid << 15 ) + ( le.mailing_state_Invalid << 16 ) + ( le.mailing_zipcode_Invalid << 17 ) + ( le.clean_fname_Invalid << 18 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_MI);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.code_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.customer_dln_pid_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.street_address_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.date_of_birth_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.county_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.dln_pid_indicator_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.mailing_street_address_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.mailing_city_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.mailing_state_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.mailing_zipcode_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.clean_fname_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    code_ENUM_ErrorCount := COUNT(GROUP,h.code_Invalid=1);
    customer_dln_pid_CUSTOM_ErrorCount := COUNT(GROUP,h.customer_dln_pid_Invalid=1);
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    street_address_ALLOW_ErrorCount := COUNT(GROUP,h.street_address_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zipcode_CUSTOM_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    date_of_birth_CUSTOM_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    date_of_birth_LENGTHS_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=2);
    date_of_birth_Total_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    county_ALLOW_ErrorCount := COUNT(GROUP,h.county_Invalid=1);
    dln_pid_indicator_ENUM_ErrorCount := COUNT(GROUP,h.dln_pid_indicator_Invalid=1);
    mailing_street_address_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_street_address_Invalid=1);
    mailing_city_ALLOW_ErrorCount := COUNT(GROUP,h.mailing_city_Invalid=1);
    mailing_state_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_state_Invalid=1);
    mailing_zipcode_CUSTOM_ErrorCount := COUNT(GROUP,h.mailing_zipcode_Invalid=1);
    clean_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.code_Invalid > 0 OR h.customer_dln_pid_Invalid > 0 OR h.first_name_Invalid > 0 OR h.street_address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zipcode_Invalid > 0 OR h.date_of_birth_Invalid > 0 OR h.gender_Invalid > 0 OR h.county_Invalid > 0 OR h.dln_pid_indicator_Invalid > 0 OR h.mailing_street_address_Invalid > 0 OR h.mailing_city_Invalid > 0 OR h.mailing_state_Invalid > 0 OR h.mailing_zipcode_Invalid > 0 OR h.clean_fname_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_Total_ErrorCount > 0, 1, 0) + IF(le.code_ENUM_ErrorCount > 0, 1, 0) + IF(le.customer_dln_pid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_Total_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dln_pid_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.mailing_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_fname_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.code_ENUM_ErrorCount > 0, 1, 0) + IF(le.customer_dln_pid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dln_pid_indicator_ENUM_ErrorCount > 0, 1, 0) + IF(le.mailing_street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.mailing_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.mailing_zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.clean_fname_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.code_Invalid,le.customer_dln_pid_Invalid,le.first_name_Invalid,le.street_address_Invalid,le.city_Invalid,le.state_Invalid,le.zipcode_Invalid,le.date_of_birth_Invalid,le.gender_Invalid,le.county_Invalid,le.dln_pid_indicator_Invalid,le.mailing_street_address_Invalid,le.mailing_city_Invalid,le.mailing_state_Invalid,le.mailing_zipcode_Invalid,le.clean_fname_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_code(le.code_Invalid),Fields.InvalidMessage_customer_dln_pid(le.customer_dln_pid_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_street_address(le.street_address_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_county(le.county_Invalid),Fields.InvalidMessage_dln_pid_indicator(le.dln_pid_indicator_Invalid),Fields.InvalidMessage_mailing_street_address(le.mailing_street_address_Invalid),Fields.InvalidMessage_mailing_city(le.mailing_city_Invalid),Fields.InvalidMessage_mailing_state(le.mailing_state_Invalid),Fields.InvalidMessage_mailing_zipcode(le.mailing_zipcode_Invalid),Fields.InvalidMessage_clean_fname(le.clean_fname_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.customer_dln_pid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.county_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dln_pid_indicator_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.mailing_street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.mailing_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.mailing_zipcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.clean_fname_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','code','customer_dln_pid','first_name','street_address','city','state','zipcode','date_of_birth','gender','county','dln_pid_indicator','mailing_street_address','mailing_city','mailing_state','mailing_zipcode','clean_fname','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_past_date','invalid_code','invalid_dl_number_check','invalid_name','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_past_date','invalid_gender','invalid_numeric','invalid_dln_pid_indi','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_clean_name','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.code,(SALT311.StrType)le.customer_dln_pid,(SALT311.StrType)le.first_name,(SALT311.StrType)le.street_address,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zipcode,(SALT311.StrType)le.date_of_birth,(SALT311.StrType)le.gender,(SALT311.StrType)le.county,(SALT311.StrType)le.dln_pid_indicator,(SALT311.StrType)le.mailing_street_address,(SALT311.StrType)le.mailing_city,(SALT311.StrType)le.mailing_state,(SALT311.StrType)le.mailing_zipcode,(SALT311.StrType)le.clean_fname,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_MI) prevDS = DATASET([], Layout_In_MI), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_past_date:CUSTOM','process_date:invalid_past_date:LENGTHS'
          ,'code:invalid_code:ENUM'
          ,'customer_dln_pid:invalid_dl_number_check:CUSTOM'
          ,'first_name:invalid_name:CUSTOM'
          ,'street_address:invalid_street:ALLOW'
          ,'city:invalid_city:ALLOW'
          ,'state:invalid_state:CUSTOM'
          ,'zipcode:invalid_zip:CUSTOM'
          ,'date_of_birth:invalid_past_date:CUSTOM','date_of_birth:invalid_past_date:LENGTHS'
          ,'gender:invalid_gender:ENUM'
          ,'county:invalid_numeric:ALLOW'
          ,'dln_pid_indicator:invalid_dln_pid_indi:ENUM'
          ,'mailing_street_address:invalid_street:ALLOW'
          ,'mailing_city:invalid_city:ALLOW'
          ,'mailing_state:invalid_state:CUSTOM'
          ,'mailing_zipcode:invalid_zip:CUSTOM'
          ,'clean_fname:invalid_clean_name:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_code(1)
          ,Fields.InvalidMessage_customer_dln_pid(1)
          ,Fields.InvalidMessage_first_name(1)
          ,Fields.InvalidMessage_street_address(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1)
          ,Fields.InvalidMessage_zipcode(1)
          ,Fields.InvalidMessage_date_of_birth(1),Fields.InvalidMessage_date_of_birth(2)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_county(1)
          ,Fields.InvalidMessage_dln_pid_indicator(1)
          ,Fields.InvalidMessage_mailing_street_address(1)
          ,Fields.InvalidMessage_mailing_city(1)
          ,Fields.InvalidMessage_mailing_state(1)
          ,Fields.InvalidMessage_mailing_zipcode(1)
          ,Fields.InvalidMessage_clean_fname(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.code_ENUM_ErrorCount
          ,le.customer_dln_pid_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.street_address_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zipcode_CUSTOM_ErrorCount
          ,le.date_of_birth_CUSTOM_ErrorCount,le.date_of_birth_LENGTHS_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.dln_pid_indicator_ENUM_ErrorCount
          ,le.mailing_street_address_ALLOW_ErrorCount
          ,le.mailing_city_ALLOW_ErrorCount
          ,le.mailing_state_CUSTOM_ErrorCount
          ,le.mailing_zipcode_CUSTOM_ErrorCount
          ,le.clean_fname_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.code_ENUM_ErrorCount
          ,le.customer_dln_pid_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.street_address_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zipcode_CUSTOM_ErrorCount
          ,le.date_of_birth_CUSTOM_ErrorCount,le.date_of_birth_LENGTHS_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.county_ALLOW_ErrorCount
          ,le.dln_pid_indicator_ENUM_ErrorCount
          ,le.mailing_street_address_ALLOW_ErrorCount
          ,le.mailing_city_ALLOW_ErrorCount
          ,le.mailing_state_CUSTOM_ErrorCount
          ,le.mailing_zipcode_CUSTOM_ErrorCount
          ,le.clean_fname_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_In_MI));
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
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'code:' + getFieldTypeText(h.code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customer_dln_pid:' + getFieldTypeText(h.customer_dln_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_name:' + getFieldTypeText(h.middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_suffix:' + getFieldTypeText(h.name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_address:' + getFieldTypeText(h.street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipcode:' + getFieldTypeText(h.zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_birth:' + getFieldTypeText(h.date_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dln_pid_indicator:' + getFieldTypeText(h.dln_pid_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_street_address:' + getFieldTypeText(h.mailing_street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_city:' + getFieldTypeText(h.mailing_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_state:' + getFieldTypeText(h.mailing_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mailing_zipcode:' + getFieldTypeText(h.mailing_zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'blob:' + getFieldTypeText(h.blob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_prefix:' + getFieldTypeText(h.clean_name_prefix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_fname:' + getFieldTypeText(h.clean_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_mname:' + getFieldTypeText(h.clean_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_lname:' + getFieldTypeText(h.clean_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_suffix:' + getFieldTypeText(h.clean_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_score:' + getFieldTypeText(h.clean_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_code_cnt
          ,le.populated_customer_dln_pid_cnt
          ,le.populated_last_name_cnt
          ,le.populated_first_name_cnt
          ,le.populated_middle_name_cnt
          ,le.populated_name_suffix_cnt
          ,le.populated_street_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zipcode_cnt
          ,le.populated_date_of_birth_cnt
          ,le.populated_gender_cnt
          ,le.populated_county_cnt
          ,le.populated_dln_pid_indicator_cnt
          ,le.populated_mailing_street_address_cnt
          ,le.populated_mailing_city_cnt
          ,le.populated_mailing_state_cnt
          ,le.populated_mailing_zipcode_cnt
          ,le.populated_blob_cnt
          ,le.populated_clean_name_prefix_cnt
          ,le.populated_clean_fname_cnt
          ,le.populated_clean_mname_cnt
          ,le.populated_clean_lname_cnt
          ,le.populated_clean_name_suffix_cnt
          ,le.populated_clean_name_score_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_code_pcnt
          ,le.populated_customer_dln_pid_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_middle_name_pcnt
          ,le.populated_name_suffix_pcnt
          ,le.populated_street_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zipcode_pcnt
          ,le.populated_date_of_birth_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_county_pcnt
          ,le.populated_dln_pid_indicator_pcnt
          ,le.populated_mailing_street_address_pcnt
          ,le.populated_mailing_city_pcnt
          ,le.populated_mailing_state_pcnt
          ,le.populated_mailing_zipcode_pcnt
          ,le.populated_blob_pcnt
          ,le.populated_clean_name_prefix_pcnt
          ,le.populated_clean_fname_pcnt
          ,le.populated_clean_mname_pcnt
          ,le.populated_clean_lname_pcnt
          ,le.populated_clean_name_suffix_pcnt
          ,le.populated_clean_name_score_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,26,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_MI));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),26,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_MI) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DL_MI, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
