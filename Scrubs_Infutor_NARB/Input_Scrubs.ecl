IMPORT SALT311,STD;
IMPORT Scrubs_Infutor_NARB,Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 18;
  EXPORT NumRulesFromFieldType := 18;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 18;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_Infutor_NARB)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 pid_Invalid;
    UNSIGNED1 address_type_code_Invalid;
    UNSIGNED1 url_Invalid;
    UNSIGNED1 sic1_Invalid;
    UNSIGNED1 sic2_Invalid;
    UNSIGNED1 sic3_Invalid;
    UNSIGNED1 sic4_Invalid;
    UNSIGNED1 sic5_Invalid;
    UNSIGNED1 incorporation_state_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 contact_title_Invalid;
    UNSIGNED1 normcompany_type_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_Infutor_NARB)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Input_Layout_Infutor_NARB) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Input_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Input_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Input_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Input_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.process_date_Invalid := Input_Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.record_type_Invalid := Input_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.pid_Invalid := Input_Fields.InValid_pid((SALT311.StrType)le.pid);
    SELF.address_type_code_Invalid := Input_Fields.InValid_address_type_code((SALT311.StrType)le.address_type_code);
    SELF.url_Invalid := Input_Fields.InValid_url((SALT311.StrType)le.url);
    SELF.sic1_Invalid := Input_Fields.InValid_sic1((SALT311.StrType)le.sic1);
    SELF.sic2_Invalid := Input_Fields.InValid_sic2((SALT311.StrType)le.sic2);
    SELF.sic3_Invalid := Input_Fields.InValid_sic3((SALT311.StrType)le.sic3);
    SELF.sic4_Invalid := Input_Fields.InValid_sic4((SALT311.StrType)le.sic4);
    SELF.sic5_Invalid := Input_Fields.InValid_sic5((SALT311.StrType)le.sic5);
    SELF.incorporation_state_Invalid := Input_Fields.InValid_incorporation_state((SALT311.StrType)le.incorporation_state);
    SELF.email_Invalid := Input_Fields.InValid_email((SALT311.StrType)le.email);
    SELF.contact_title_Invalid := Input_Fields.InValid_contact_title((SALT311.StrType)le.contact_title);
    SELF.normcompany_type_Invalid := Input_Fields.InValid_normcompany_type((SALT311.StrType)le.normcompany_type);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_Infutor_NARB);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.process_date_Invalid << 4 ) + ( le.record_type_Invalid << 5 ) + ( le.pid_Invalid << 6 ) + ( le.address_type_code_Invalid << 7 ) + ( le.url_Invalid << 8 ) + ( le.sic1_Invalid << 9 ) + ( le.sic2_Invalid << 10 ) + ( le.sic3_Invalid << 11 ) + ( le.sic4_Invalid << 12 ) + ( le.sic5_Invalid << 13 ) + ( le.incorporation_state_Invalid << 14 ) + ( le.email_Invalid << 15 ) + ( le.contact_title_Invalid << 16 ) + ( le.normcompany_type_Invalid << 17 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Input_Layout_Infutor_NARB);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.pid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.address_type_code_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.url_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sic1_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.sic2_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.sic3_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.sic4_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.sic5_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.incorporation_state_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.email_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.contact_title_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.normcompany_type_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dt_first_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_first_seen_Invalid=1);
    dt_last_seen_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_last_seen_Invalid=1);
    dt_vendor_first_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_first_reported_Invalid=1);
    dt_vendor_last_reported_CUSTOM_ErrorCount := COUNT(GROUP,h.dt_vendor_last_reported_Invalid=1);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    record_type_ENUM_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    pid_CUSTOM_ErrorCount := COUNT(GROUP,h.pid_Invalid=1);
    address_type_code_ENUM_ErrorCount := COUNT(GROUP,h.address_type_code_Invalid=1);
    url_CUSTOM_ErrorCount := COUNT(GROUP,h.url_Invalid=1);
    sic1_CUSTOM_ErrorCount := COUNT(GROUP,h.sic1_Invalid=1);
    sic2_CUSTOM_ErrorCount := COUNT(GROUP,h.sic2_Invalid=1);
    sic3_CUSTOM_ErrorCount := COUNT(GROUP,h.sic3_Invalid=1);
    sic4_CUSTOM_ErrorCount := COUNT(GROUP,h.sic4_Invalid=1);
    sic5_CUSTOM_ErrorCount := COUNT(GROUP,h.sic5_Invalid=1);
    incorporation_state_CUSTOM_ErrorCount := COUNT(GROUP,h.incorporation_state_Invalid=1);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    contact_title_LENGTHS_ErrorCount := COUNT(GROUP,h.contact_title_Invalid=1);
    normcompany_type_ENUM_ErrorCount := COUNT(GROUP,h.normcompany_type_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.process_date_Invalid > 0 OR h.record_type_Invalid > 0 OR h.pid_Invalid > 0 OR h.address_type_code_Invalid > 0 OR h.url_Invalid > 0 OR h.sic1_Invalid > 0 OR h.sic2_Invalid > 0 OR h.sic3_Invalid > 0 OR h.sic4_Invalid > 0 OR h.sic5_Invalid > 0 OR h.incorporation_state_Invalid > 0 OR h.email_Invalid > 0 OR h.contact_title_Invalid > 0 OR h.normcompany_type_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.pid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.incorporation_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.normcompany_type_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ENUM_ErrorCount > 0, 1, 0) + IF(le.pid_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_type_code_ENUM_ErrorCount > 0, 1, 0) + IF(le.url_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic1_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sic5_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.incorporation_state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.contact_title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.normcompany_type_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.process_date_Invalid,le.record_type_Invalid,le.pid_Invalid,le.address_type_code_Invalid,le.url_Invalid,le.sic1_Invalid,le.sic2_Invalid,le.sic3_Invalid,le.sic4_Invalid,le.sic5_Invalid,le.incorporation_state_Invalid,le.email_Invalid,le.contact_title_Invalid,le.normcompany_type_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Input_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Input_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Input_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Input_Fields.InvalidMessage_process_date(le.process_date_Invalid),Input_Fields.InvalidMessage_record_type(le.record_type_Invalid),Input_Fields.InvalidMessage_pid(le.pid_Invalid),Input_Fields.InvalidMessage_address_type_code(le.address_type_code_Invalid),Input_Fields.InvalidMessage_url(le.url_Invalid),Input_Fields.InvalidMessage_sic1(le.sic1_Invalid),Input_Fields.InvalidMessage_sic2(le.sic2_Invalid),Input_Fields.InvalidMessage_sic3(le.sic3_Invalid),Input_Fields.InvalidMessage_sic4(le.sic4_Invalid),Input_Fields.InvalidMessage_sic5(le.sic5_Invalid),Input_Fields.InvalidMessage_incorporation_state(le.incorporation_state_Invalid),Input_Fields.InvalidMessage_email(le.email_Invalid),Input_Fields.InvalidMessage_contact_title(le.contact_title_Invalid),Input_Fields.InvalidMessage_normcompany_type(le.normcompany_type_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.pid_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_type_code_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.url_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sic5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.incorporation_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.contact_title_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.normcompany_type_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','pid','address_type_code','url','sic1','sic2','sic3','sic4','sic5','incorporation_state','email','contact_title','normcompany_type','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_numeric','invalid_address_type_code','invalid_url','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_st','invalid_email','invalid_mandatory','invalid_norm_type','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.process_date,(SALT311.StrType)le.record_type,(SALT311.StrType)le.pid,(SALT311.StrType)le.address_type_code,(SALT311.StrType)le.url,(SALT311.StrType)le.sic1,(SALT311.StrType)le.sic2,(SALT311.StrType)le.sic3,(SALT311.StrType)le.sic4,(SALT311.StrType)le.sic5,(SALT311.StrType)le.incorporation_state,(SALT311.StrType)le.email,(SALT311.StrType)le.contact_title,(SALT311.StrType)le.normcompany_type,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_Infutor_NARB) prevDS = DATASET([], Input_Layout_Infutor_NARB), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'dt_first_seen:invalid_pastdate8:CUSTOM'
          ,'dt_last_seen:invalid_pastdate8:CUSTOM'
          ,'dt_vendor_first_reported:invalid_pastdate8:CUSTOM'
          ,'dt_vendor_last_reported:invalid_pastdate8:CUSTOM'
          ,'process_date:invalid_pastdate8:CUSTOM'
          ,'record_type:invalid_record_type:ENUM'
          ,'pid:invalid_numeric:CUSTOM'
          ,'address_type_code:invalid_address_type_code:ENUM'
          ,'url:invalid_url:CUSTOM'
          ,'sic1:invalid_sic:CUSTOM'
          ,'sic2:invalid_sic:CUSTOM'
          ,'sic3:invalid_sic:CUSTOM'
          ,'sic4:invalid_sic:CUSTOM'
          ,'sic5:invalid_sic:CUSTOM'
          ,'incorporation_state:invalid_st:CUSTOM'
          ,'email:invalid_email:ALLOW'
          ,'contact_title:invalid_mandatory:LENGTHS'
          ,'normcompany_type:invalid_norm_type:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Input_Fields.InvalidMessage_dt_first_seen(1)
          ,Input_Fields.InvalidMessage_dt_last_seen(1)
          ,Input_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Input_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Input_Fields.InvalidMessage_process_date(1)
          ,Input_Fields.InvalidMessage_record_type(1)
          ,Input_Fields.InvalidMessage_pid(1)
          ,Input_Fields.InvalidMessage_address_type_code(1)
          ,Input_Fields.InvalidMessage_url(1)
          ,Input_Fields.InvalidMessage_sic1(1)
          ,Input_Fields.InvalidMessage_sic2(1)
          ,Input_Fields.InvalidMessage_sic3(1)
          ,Input_Fields.InvalidMessage_sic4(1)
          ,Input_Fields.InvalidMessage_sic5(1)
          ,Input_Fields.InvalidMessage_incorporation_state(1)
          ,Input_Fields.InvalidMessage_email(1)
          ,Input_Fields.InvalidMessage_contact_title(1)
          ,Input_Fields.InvalidMessage_normcompany_type(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.pid_CUSTOM_ErrorCount
          ,le.address_type_code_ENUM_ErrorCount
          ,le.url_CUSTOM_ErrorCount
          ,le.sic1_CUSTOM_ErrorCount
          ,le.sic2_CUSTOM_ErrorCount
          ,le.sic3_CUSTOM_ErrorCount
          ,le.sic4_CUSTOM_ErrorCount
          ,le.sic5_CUSTOM_ErrorCount
          ,le.incorporation_state_CUSTOM_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.contact_title_LENGTHS_ErrorCount
          ,le.normcompany_type_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount
          ,le.record_type_ENUM_ErrorCount
          ,le.pid_CUSTOM_ErrorCount
          ,le.address_type_code_ENUM_ErrorCount
          ,le.url_CUSTOM_ErrorCount
          ,le.sic1_CUSTOM_ErrorCount
          ,le.sic2_CUSTOM_ErrorCount
          ,le.sic3_CUSTOM_ErrorCount
          ,le.sic4_CUSTOM_ErrorCount
          ,le.sic5_CUSTOM_ErrorCount
          ,le.incorporation_state_CUSTOM_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.contact_title_LENGTHS_ErrorCount
          ,le.normcompany_type_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_Infutor_NARB));
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
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pid:' + getFieldTypeText(h.pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_type_code:' + getFieldTypeText(h.address_type_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'url:' + getFieldTypeText(h.url) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic1:' + getFieldTypeText(h.sic1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic2:' + getFieldTypeText(h.sic2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic3:' + getFieldTypeText(h.sic3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic4:' + getFieldTypeText(h.sic4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sic5:' + getFieldTypeText(h.sic5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'incorporation_state:' + getFieldTypeText(h.incorporation_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'contact_title:' + getFieldTypeText(h.contact_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'normcompany_type:' + getFieldTypeText(h.normcompany_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_process_date_cnt
          ,le.populated_record_type_cnt
          ,le.populated_pid_cnt
          ,le.populated_address_type_code_cnt
          ,le.populated_url_cnt
          ,le.populated_sic1_cnt
          ,le.populated_sic2_cnt
          ,le.populated_sic3_cnt
          ,le.populated_sic4_cnt
          ,le.populated_sic5_cnt
          ,le.populated_incorporation_state_cnt
          ,le.populated_email_cnt
          ,le.populated_contact_title_cnt
          ,le.populated_normcompany_type_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_process_date_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_pid_pcnt
          ,le.populated_address_type_code_pcnt
          ,le.populated_url_pcnt
          ,le.populated_sic1_pcnt
          ,le.populated_sic2_pcnt
          ,le.populated_sic3_pcnt
          ,le.populated_sic4_pcnt
          ,le.populated_sic5_pcnt
          ,le.populated_incorporation_state_pcnt
          ,le.populated_email_pcnt
          ,le.populated_contact_title_pcnt
          ,le.populated_normcompany_type_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,18,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_Infutor_NARB));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),18,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_Infutor_NARB) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Infutor_NARB, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
