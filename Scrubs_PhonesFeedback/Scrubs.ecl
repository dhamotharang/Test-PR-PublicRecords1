IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 14;
  EXPORT NumRulesFromFieldType := 14;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 13;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_PhonesFeedback)
    UNSIGNED1 did_Invalid;
    UNSIGNED1 did_score_Invalid;
    UNSIGNED1 hhid_Invalid;
    UNSIGNED1 phone_number_Invalid;
    UNSIGNED1 login_history_id_Invalid;
    UNSIGNED1 street_pre_direction_Invalid;
    UNSIGNED1 street_post_direction_Invalid;
    UNSIGNED1 zip5_Invalid;
    UNSIGNED1 zip4_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 alt_phone_Invalid;
    UNSIGNED1 phone_contact_type_Invalid;
    UNSIGNED1 feedback_source_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_PhonesFeedback)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_PhonesFeedback) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.did_Invalid := Fields.InValid_did((SALT311.StrType)le.did);
    SELF.did_score_Invalid := Fields.InValid_did_score((SALT311.StrType)le.did_score);
    SELF.hhid_Invalid := Fields.InValid_hhid((SALT311.StrType)le.hhid);
    SELF.phone_number_Invalid := Fields.InValid_phone_number((SALT311.StrType)le.phone_number);
    SELF.login_history_id_Invalid := Fields.InValid_login_history_id((SALT311.StrType)le.login_history_id);
    SELF.street_pre_direction_Invalid := Fields.InValid_street_pre_direction((SALT311.StrType)le.street_pre_direction);
    SELF.street_post_direction_Invalid := Fields.InValid_street_post_direction((SALT311.StrType)le.street_post_direction);
    SELF.zip5_Invalid := Fields.InValid_zip5((SALT311.StrType)le.zip5);
    SELF.zip4_Invalid := Fields.InValid_zip4((SALT311.StrType)le.zip4);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.alt_phone_Invalid := Fields.InValid_alt_phone((SALT311.StrType)le.alt_phone);
    SELF.phone_contact_type_Invalid := Fields.InValid_phone_contact_type((SALT311.StrType)le.phone_contact_type);
    SELF.feedback_source_Invalid := Fields.InValid_feedback_source((SALT311.StrType)le.feedback_source);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_PhonesFeedback);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.did_Invalid << 0 ) + ( le.did_score_Invalid << 1 ) + ( le.hhid_Invalid << 2 ) + ( le.phone_number_Invalid << 3 ) + ( le.login_history_id_Invalid << 4 ) + ( le.street_pre_direction_Invalid << 5 ) + ( le.street_post_direction_Invalid << 6 ) + ( le.zip5_Invalid << 7 ) + ( le.zip4_Invalid << 8 ) + ( le.state_Invalid << 9 ) + ( le.alt_phone_Invalid << 11 ) + ( le.phone_contact_type_Invalid << 12 ) + ( le.feedback_source_Invalid << 13 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_PhonesFeedback);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.did_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.did_score_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.hhid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.phone_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.login_history_id_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.street_pre_direction_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.street_post_direction_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.zip5_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.zip4_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.alt_phone_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.phone_contact_type_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.feedback_source_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    did_ALLOW_ErrorCount := COUNT(GROUP,h.did_Invalid=1);
    did_score_ALLOW_ErrorCount := COUNT(GROUP,h.did_score_Invalid=1);
    hhid_ALLOW_ErrorCount := COUNT(GROUP,h.hhid_Invalid=1);
    phone_number_ALLOW_ErrorCount := COUNT(GROUP,h.phone_number_Invalid=1);
    login_history_id_ALLOW_ErrorCount := COUNT(GROUP,h.login_history_id_Invalid=1);
    street_pre_direction_ENUM_ErrorCount := COUNT(GROUP,h.street_pre_direction_Invalid=1);
    street_post_direction_ENUM_ErrorCount := COUNT(GROUP,h.street_post_direction_Invalid=1);
    zip5_ALLOW_ErrorCount := COUNT(GROUP,h.zip5_Invalid=1);
    zip4_ALLOW_ErrorCount := COUNT(GROUP,h.zip4_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    alt_phone_ALLOW_ErrorCount := COUNT(GROUP,h.alt_phone_Invalid=1);
    phone_contact_type_ALLOW_ErrorCount := COUNT(GROUP,h.phone_contact_type_Invalid=1);
    feedback_source_ALLOW_ErrorCount := COUNT(GROUP,h.feedback_source_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.did_Invalid > 0 OR h.did_score_Invalid > 0 OR h.hhid_Invalid > 0 OR h.phone_number_Invalid > 0 OR h.login_history_id_Invalid > 0 OR h.street_pre_direction_Invalid > 0 OR h.street_post_direction_Invalid > 0 OR h.zip5_Invalid > 0 OR h.zip4_Invalid > 0 OR h.state_Invalid > 0 OR h.alt_phone_Invalid > 0 OR h.phone_contact_type_Invalid > 0 OR h.feedback_source_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hhid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.login_history_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_pre_direction_ENUM_ErrorCount > 0, 1, 0) + IF(le.street_post_direction_ENUM_ErrorCount > 0, 1, 0) + IF(le.zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.alt_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_contact_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.feedback_source_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.did_ALLOW_ErrorCount > 0, 1, 0) + IF(le.did_score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.hhid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.login_history_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_pre_direction_ENUM_ErrorCount > 0, 1, 0) + IF(le.street_post_direction_ENUM_ErrorCount > 0, 1, 0) + IF(le.zip5_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.alt_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_contact_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.feedback_source_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.did_Invalid,le.did_score_Invalid,le.hhid_Invalid,le.phone_number_Invalid,le.login_history_id_Invalid,le.street_pre_direction_Invalid,le.street_post_direction_Invalid,le.zip5_Invalid,le.zip4_Invalid,le.state_Invalid,le.alt_phone_Invalid,le.phone_contact_type_Invalid,le.feedback_source_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_did(le.did_Invalid),Fields.InvalidMessage_did_score(le.did_score_Invalid),Fields.InvalidMessage_hhid(le.hhid_Invalid),Fields.InvalidMessage_phone_number(le.phone_number_Invalid),Fields.InvalidMessage_login_history_id(le.login_history_id_Invalid),Fields.InvalidMessage_street_pre_direction(le.street_pre_direction_Invalid),Fields.InvalidMessage_street_post_direction(le.street_post_direction_Invalid),Fields.InvalidMessage_zip5(le.zip5_Invalid),Fields.InvalidMessage_zip4(le.zip4_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_alt_phone(le.alt_phone_Invalid),Fields.InvalidMessage_phone_contact_type(le.phone_contact_type_Invalid),Fields.InvalidMessage_feedback_source(le.feedback_source_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.did_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.did_score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.hhid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.login_history_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_pre_direction_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.street_post_direction_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.zip5_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.alt_phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_contact_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.feedback_source_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'did','did_score','hhid','phone_number','login_history_id','street_pre_direction','street_post_direction','zip5','zip4','state','alt_phone','phone_contact_type','feedback_source','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Direction','Invalid_Direction','Invalid_Num','Invalid_Num','Invalid_State','Invalid_Num','Invalid_Num','Invalid_Num','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.did,(SALT311.StrType)le.did_score,(SALT311.StrType)le.hhid,(SALT311.StrType)le.phone_number,(SALT311.StrType)le.login_history_id,(SALT311.StrType)le.street_pre_direction,(SALT311.StrType)le.street_post_direction,(SALT311.StrType)le.zip5,(SALT311.StrType)le.zip4,(SALT311.StrType)le.state,(SALT311.StrType)le.alt_phone,(SALT311.StrType)le.phone_contact_type,(SALT311.StrType)le.feedback_source,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,13,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_PhonesFeedback) prevDS = DATASET([], Layout_PhonesFeedback), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'did:Invalid_Num:ALLOW'
          ,'did_score:Invalid_Num:ALLOW'
          ,'hhid:Invalid_Num:ALLOW'
          ,'phone_number:Invalid_Num:ALLOW'
          ,'login_history_id:Invalid_Num:ALLOW'
          ,'street_pre_direction:Invalid_Direction:ENUM'
          ,'street_post_direction:Invalid_Direction:ENUM'
          ,'zip5:Invalid_Num:ALLOW'
          ,'zip4:Invalid_Num:ALLOW'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'alt_phone:Invalid_Num:ALLOW'
          ,'phone_contact_type:Invalid_Num:ALLOW'
          ,'feedback_source:Invalid_Num:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_did(1)
          ,Fields.InvalidMessage_did_score(1)
          ,Fields.InvalidMessage_hhid(1)
          ,Fields.InvalidMessage_phone_number(1)
          ,Fields.InvalidMessage_login_history_id(1)
          ,Fields.InvalidMessage_street_pre_direction(1)
          ,Fields.InvalidMessage_street_post_direction(1)
          ,Fields.InvalidMessage_zip5(1)
          ,Fields.InvalidMessage_zip4(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_alt_phone(1)
          ,Fields.InvalidMessage_phone_contact_type(1)
          ,Fields.InvalidMessage_feedback_source(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.hhid_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.login_history_id_ALLOW_ErrorCount
          ,le.street_pre_direction_ENUM_ErrorCount
          ,le.street_post_direction_ENUM_ErrorCount
          ,le.zip5_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.alt_phone_ALLOW_ErrorCount
          ,le.phone_contact_type_ALLOW_ErrorCount
          ,le.feedback_source_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.did_ALLOW_ErrorCount
          ,le.did_score_ALLOW_ErrorCount
          ,le.hhid_ALLOW_ErrorCount
          ,le.phone_number_ALLOW_ErrorCount
          ,le.login_history_id_ALLOW_ErrorCount
          ,le.street_pre_direction_ENUM_ErrorCount
          ,le.street_post_direction_ENUM_ErrorCount
          ,le.zip5_ALLOW_ErrorCount
          ,le.zip4_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.alt_phone_ALLOW_ErrorCount
          ,le.phone_contact_type_ALLOW_ErrorCount
          ,le.feedback_source_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_PhonesFeedback));
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
          ,'did:' + getFieldTypeText(h.did) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'did_score:' + getFieldTypeText(h.did_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hhid:' + getFieldTypeText(h.hhid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_number:' + getFieldTypeText(h.phone_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'login_history_id:' + getFieldTypeText(h.login_history_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_pre_direction:' + getFieldTypeText(h.street_pre_direction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_post_direction:' + getFieldTypeText(h.street_post_direction) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_number:' + getFieldTypeText(h.street_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_name:' + getFieldTypeText(h.street_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_suffix:' + getFieldTypeText(h.street_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_number:' + getFieldTypeText(h.unit_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit_designation:' + getFieldTypeText(h.unit_designation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip5:' + getFieldTypeText(h.zip5) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip4:' + getFieldTypeText(h.zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'alt_phone:' + getFieldTypeText(h.alt_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'other_info:' + getFieldTypeText(h.other_info) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone_contact_type:' + getFieldTypeText(h.phone_contact_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'feedback_source:' + getFieldTypeText(h.feedback_source) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_time_added:' + getFieldTypeText(h.date_time_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'loginid:' + getFieldTypeText(h.loginid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'customerid:' + getFieldTypeText(h.customerid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_hhid_cnt
          ,le.populated_phone_number_cnt
          ,le.populated_login_history_id_cnt
          ,le.populated_fname_cnt
          ,le.populated_lname_cnt
          ,le.populated_mname_cnt
          ,le.populated_street_pre_direction_cnt
          ,le.populated_street_post_direction_cnt
          ,le.populated_street_number_cnt
          ,le.populated_street_name_cnt
          ,le.populated_street_suffix_cnt
          ,le.populated_unit_number_cnt
          ,le.populated_unit_designation_cnt
          ,le.populated_zip5_cnt
          ,le.populated_zip4_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_alt_phone_cnt
          ,le.populated_other_info_cnt
          ,le.populated_phone_contact_type_cnt
          ,le.populated_feedback_source_cnt
          ,le.populated_date_time_added_cnt
          ,le.populated_loginid_cnt
          ,le.populated_customerid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_hhid_pcnt
          ,le.populated_phone_number_pcnt
          ,le.populated_login_history_id_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_street_pre_direction_pcnt
          ,le.populated_street_post_direction_pcnt
          ,le.populated_street_number_pcnt
          ,le.populated_street_name_pcnt
          ,le.populated_street_suffix_pcnt
          ,le.populated_unit_number_pcnt
          ,le.populated_unit_designation_pcnt
          ,le.populated_zip5_pcnt
          ,le.populated_zip4_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_alt_phone_pcnt
          ,le.populated_other_info_pcnt
          ,le.populated_phone_contact_type_pcnt
          ,le.populated_feedback_source_pcnt
          ,le.populated_date_time_added_pcnt
          ,le.populated_loginid_pcnt
          ,le.populated_customerid_pcnt,0);
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_PhonesFeedback));
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
 
EXPORT StandardStats(DATASET(Layout_PhonesFeedback) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesFeedback, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
