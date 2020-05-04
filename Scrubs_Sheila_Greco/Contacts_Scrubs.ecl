IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Contacts_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 8;
  EXPORT NumRulesFromFieldType := 8;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 8;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Contacts_Layout_Sheila_Greco)
    UNSIGNED1 dt_first_seen_Invalid;
    UNSIGNED1 dt_last_seen_Invalid;
    UNSIGNED1 dt_vendor_first_reported_Invalid;
    UNSIGNED1 dt_vendor_last_reported_Invalid;
    UNSIGNED1 record_type_Invalid;
    UNSIGNED1 rawfields_maincontactid_Invalid;
    UNSIGNED1 rawfields_maincompanyid_Invalid;
    UNSIGNED1 rawfields_active_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Contacts_Layout_Sheila_Greco)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Contacts_Layout_Sheila_Greco)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dt_first_seen:Invalid_Date:CUSTOM'
          ,'dt_last_seen:Invalid_Date:CUSTOM'
          ,'dt_vendor_first_reported:Invalid_Date:CUSTOM'
          ,'dt_vendor_last_reported:Invalid_Date:CUSTOM'
          ,'record_type:Invalid_AlphaCaps:ALLOW'
          ,'rawfields_maincontactid:Invalid_No:ALLOW'
          ,'rawfields_maincompanyid:Invalid_No:ALLOW'
          ,'rawfields_active:Invalid_No:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Contacts_Fields.InvalidMessage_dt_first_seen(1)
          ,Contacts_Fields.InvalidMessage_dt_last_seen(1)
          ,Contacts_Fields.InvalidMessage_dt_vendor_first_reported(1)
          ,Contacts_Fields.InvalidMessage_dt_vendor_last_reported(1)
          ,Contacts_Fields.InvalidMessage_record_type(1)
          ,Contacts_Fields.InvalidMessage_rawfields_maincontactid(1)
          ,Contacts_Fields.InvalidMessage_rawfields_maincompanyid(1)
          ,Contacts_Fields.InvalidMessage_rawfields_active(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Contacts_Layout_Sheila_Greco) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dt_first_seen_Invalid := Contacts_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen);
    SELF.dt_last_seen_Invalid := Contacts_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen);
    SELF.dt_vendor_first_reported_Invalid := Contacts_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported);
    SELF.dt_vendor_last_reported_Invalid := Contacts_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported);
    SELF.record_type_Invalid := Contacts_Fields.InValid_record_type((SALT311.StrType)le.record_type);
    SELF.rawfields_maincontactid_Invalid := Contacts_Fields.InValid_rawfields_maincontactid((SALT311.StrType)le.rawfields_maincontactid);
    SELF.rawfields_maincompanyid_Invalid := Contacts_Fields.InValid_rawfields_maincompanyid((SALT311.StrType)le.rawfields_maincompanyid);
    SELF.rawfields_active_Invalid := Contacts_Fields.InValid_rawfields_active((SALT311.StrType)le.rawfields_active);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Contacts_Layout_Sheila_Greco);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dt_first_seen_Invalid << 0 ) + ( le.dt_last_seen_Invalid << 1 ) + ( le.dt_vendor_first_reported_Invalid << 2 ) + ( le.dt_vendor_last_reported_Invalid << 3 ) + ( le.record_type_Invalid << 4 ) + ( le.rawfields_maincontactid_Invalid << 5 ) + ( le.rawfields_maincompanyid_Invalid << 6 ) + ( le.rawfields_active_Invalid << 7 );
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
  EXPORT Infile := PROJECT(h,Contacts_Layout_Sheila_Greco);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dt_first_seen_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.dt_last_seen_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.dt_vendor_first_reported_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dt_vendor_last_reported_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.record_type_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.rawfields_maincontactid_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.rawfields_maincompanyid_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.rawfields_active_Invalid := (le.ScrubsBits1 >> 7) & 1;
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
    record_type_ALLOW_ErrorCount := COUNT(GROUP,h.record_type_Invalid=1);
    rawfields_maincontactid_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_maincontactid_Invalid=1);
    rawfields_maincompanyid_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_maincompanyid_Invalid=1);
    rawfields_active_ALLOW_ErrorCount := COUNT(GROUP,h.rawfields_active_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dt_first_seen_Invalid > 0 OR h.dt_last_seen_Invalid > 0 OR h.dt_vendor_first_reported_Invalid > 0 OR h.dt_vendor_last_reported_Invalid > 0 OR h.record_type_Invalid > 0 OR h.rawfields_maincontactid_Invalid > 0 OR h.rawfields_maincompanyid_Invalid > 0 OR h.rawfields_active_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincontactid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincompanyid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_active_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dt_first_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_last_seen_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_first_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dt_vendor_last_reported_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.record_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincontactid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_maincompanyid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rawfields_active_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dt_first_seen_Invalid,le.dt_last_seen_Invalid,le.dt_vendor_first_reported_Invalid,le.dt_vendor_last_reported_Invalid,le.record_type_Invalid,le.rawfields_maincontactid_Invalid,le.rawfields_maincompanyid_Invalid,le.rawfields_active_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Contacts_Fields.InvalidMessage_dt_first_seen(le.dt_first_seen_Invalid),Contacts_Fields.InvalidMessage_dt_last_seen(le.dt_last_seen_Invalid),Contacts_Fields.InvalidMessage_dt_vendor_first_reported(le.dt_vendor_first_reported_Invalid),Contacts_Fields.InvalidMessage_dt_vendor_last_reported(le.dt_vendor_last_reported_Invalid),Contacts_Fields.InvalidMessage_record_type(le.record_type_Invalid),Contacts_Fields.InvalidMessage_rawfields_maincontactid(le.rawfields_maincontactid_Invalid),Contacts_Fields.InvalidMessage_rawfields_maincompanyid(le.rawfields_maincompanyid_Invalid),Contacts_Fields.InvalidMessage_rawfields_active(le.rawfields_active_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dt_first_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_last_seen_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_first_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dt_vendor_last_reported_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.record_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_maincontactid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_maincompanyid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rawfields_active_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','record_type','rawfields_maincontactid','rawfields_maincompanyid','rawfields_active','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_AlphaCaps','Invalid_No','Invalid_No','Invalid_No','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dt_first_seen,(SALT311.StrType)le.dt_last_seen,(SALT311.StrType)le.dt_vendor_first_reported,(SALT311.StrType)le.dt_vendor_last_reported,(SALT311.StrType)le.record_type,(SALT311.StrType)le.rawfields_maincontactid,(SALT311.StrType)le.rawfields_maincompanyid,(SALT311.StrType)le.rawfields_active,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,8,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Contacts_Layout_Sheila_Greco) prevDS = DATASET([], Contacts_Layout_Sheila_Greco), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dt_first_seen_CUSTOM_ErrorCount
          ,le.dt_last_seen_CUSTOM_ErrorCount
          ,le.dt_vendor_first_reported_CUSTOM_ErrorCount
          ,le.dt_vendor_last_reported_CUSTOM_ErrorCount
          ,le.record_type_ALLOW_ErrorCount
          ,le.rawfields_maincontactid_ALLOW_ErrorCount
          ,le.rawfields_maincompanyid_ALLOW_ErrorCount
          ,le.rawfields_active_ALLOW_ErrorCount
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
          ,le.record_type_ALLOW_ErrorCount
          ,le.rawfields_maincontactid_ALLOW_ErrorCount
          ,le.rawfields_maincompanyid_ALLOW_ErrorCount
          ,le.rawfields_active_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Contacts_hygiene(PROJECT(h, Contacts_Layout_Sheila_Greco));
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
          ,'bdid:' + getFieldTypeText(h.bdid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bdid_score:' + getFieldTypeText(h.bdid_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'raw_aid:' + getFieldTypeText(h.raw_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ace_aid:' + getFieldTypeText(h.ace_aid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_first_seen:' + getFieldTypeText(h.dt_first_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_last_seen:' + getFieldTypeText(h.dt_last_seen) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_first_reported:' + getFieldTypeText(h.dt_vendor_first_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dt_vendor_last_reported:' + getFieldTypeText(h.dt_vendor_last_reported) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_type:' + getFieldTypeText(h.record_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_maincontactid:' + getFieldTypeText(h.rawfields_maincontactid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_maincompanyid:' + getFieldTypeText(h.rawfields_maincompanyid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_active:' + getFieldTypeText(h.rawfields_active) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_firstname:' + getFieldTypeText(h.rawfields_firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_midinital:' + getFieldTypeText(h.rawfields_midinital) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_lastname:' + getFieldTypeText(h.rawfields_lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_age:' + getFieldTypeText(h.rawfields_age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_gender:' + getFieldTypeText(h.rawfields_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_primarytitle:' + getFieldTypeText(h.rawfields_primarytitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_titlelevel1:' + getFieldTypeText(h.rawfields_titlelevel1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_primarydept:' + getFieldTypeText(h.rawfields_primarydept) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_secondtitle:' + getFieldTypeText(h.rawfields_secondtitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_titlelevel2:' + getFieldTypeText(h.rawfields_titlelevel2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_seconddept:' + getFieldTypeText(h.rawfields_seconddept) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_thirdtitle:' + getFieldTypeText(h.rawfields_thirdtitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_titlelevel3:' + getFieldTypeText(h.rawfields_titlelevel3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_thirddept:' + getFieldTypeText(h.rawfields_thirddept) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_skillcategory:' + getFieldTypeText(h.rawfields_skillcategory) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_skillsubcategory:' + getFieldTypeText(h.rawfields_skillsubcategory) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_reportto:' + getFieldTypeText(h.rawfields_reportto) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officephone:' + getFieldTypeText(h.rawfields_officephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officeext:' + getFieldTypeText(h.rawfields_officeext) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officefax:' + getFieldTypeText(h.rawfields_officefax) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officeemail:' + getFieldTypeText(h.rawfields_officeemail) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_directdial:' + getFieldTypeText(h.rawfields_directdial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_mobilephone:' + getFieldTypeText(h.rawfields_mobilephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officeaddress1:' + getFieldTypeText(h.rawfields_officeaddress1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officeaddress2:' + getFieldTypeText(h.rawfields_officeaddress2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officecity:' + getFieldTypeText(h.rawfields_officecity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officestate:' + getFieldTypeText(h.rawfields_officestate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officezip:' + getFieldTypeText(h.rawfields_officezip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_officecountry:' + getFieldTypeText(h.rawfields_officecountry) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_school:' + getFieldTypeText(h.rawfields_school) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_degree:' + getFieldTypeText(h.rawfields_degree) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_graduationyear:' + getFieldTypeText(h.rawfields_graduationyear) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_country:' + getFieldTypeText(h.rawfields_country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_salary:' + getFieldTypeText(h.rawfields_salary) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_bonus:' + getFieldTypeText(h.rawfields_bonus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_compensation:' + getFieldTypeText(h.rawfields_compensation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_citizenship:' + getFieldTypeText(h.rawfields_citizenship) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_diversitycandidate:' + getFieldTypeText(h.rawfields_diversitycandidate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_entrydate:' + getFieldTypeText(h.rawfields_entrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_lastupdate:' + getFieldTypeText(h.rawfields_lastupdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rawfields_biography:' + getFieldTypeText(h.rawfields_biography) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_title:' + getFieldTypeText(h.clean_contact_name_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_fname:' + getFieldTypeText(h.clean_contact_name_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_mname:' + getFieldTypeText(h.clean_contact_name_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_lname:' + getFieldTypeText(h.clean_contact_name_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_name_suffix:' + getFieldTypeText(h.clean_contact_name_name_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_name_name_score:' + getFieldTypeText(h.clean_contact_name_name_score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_prim_range:' + getFieldTypeText(h.clean_contact_address_prim_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_predir:' + getFieldTypeText(h.clean_contact_address_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_prim_name:' + getFieldTypeText(h.clean_contact_address_prim_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_addr_suffix:' + getFieldTypeText(h.clean_contact_address_addr_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_postdir:' + getFieldTypeText(h.clean_contact_address_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_unit_desig:' + getFieldTypeText(h.clean_contact_address_unit_desig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_sec_range:' + getFieldTypeText(h.clean_contact_address_sec_range) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_p_city_name:' + getFieldTypeText(h.clean_contact_address_p_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_v_city_name:' + getFieldTypeText(h.clean_contact_address_v_city_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_st:' + getFieldTypeText(h.clean_contact_address_st) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_zip:' + getFieldTypeText(h.clean_contact_address_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_zip4:' + getFieldTypeText(h.clean_contact_address_zip4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_cart:' + getFieldTypeText(h.clean_contact_address_cart) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_cr_sort_sz:' + getFieldTypeText(h.clean_contact_address_cr_sort_sz) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_lot:' + getFieldTypeText(h.clean_contact_address_lot) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_lot_order:' + getFieldTypeText(h.clean_contact_address_lot_order) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_dbpc:' + getFieldTypeText(h.clean_contact_address_dbpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_chk_digit:' + getFieldTypeText(h.clean_contact_address_chk_digit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_rec_type:' + getFieldTypeText(h.clean_contact_address_rec_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_fips_state:' + getFieldTypeText(h.clean_contact_address_fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_fips_county:' + getFieldTypeText(h.clean_contact_address_fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_geo_lat:' + getFieldTypeText(h.clean_contact_address_geo_lat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_geo_long:' + getFieldTypeText(h.clean_contact_address_geo_long) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_msa:' + getFieldTypeText(h.clean_contact_address_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_geo_blk:' + getFieldTypeText(h.clean_contact_address_geo_blk) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_geo_match:' + getFieldTypeText(h.clean_contact_address_geo_match) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_contact_address_err_stat:' + getFieldTypeText(h.clean_contact_address_err_stat) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dates_entrydate:' + getFieldTypeText(h.clean_dates_entrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_dates_lastupdate:' + getFieldTypeText(h.clean_dates_lastupdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phones_officephone:' + getFieldTypeText(h.clean_phones_officephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phones_directdial:' + getFieldTypeText(h.clean_phones_directdial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_phones_mobilephone:' + getFieldTypeText(h.clean_phones_mobilephone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'global_sid:' + getFieldTypeText(h.global_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'record_sid:' + getFieldTypeText(h.record_sid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_did_cnt
          ,le.populated_did_score_cnt
          ,le.populated_bdid_cnt
          ,le.populated_bdid_score_cnt
          ,le.populated_raw_aid_cnt
          ,le.populated_ace_aid_cnt
          ,le.populated_dt_first_seen_cnt
          ,le.populated_dt_last_seen_cnt
          ,le.populated_dt_vendor_first_reported_cnt
          ,le.populated_dt_vendor_last_reported_cnt
          ,le.populated_record_type_cnt
          ,le.populated_rawfields_maincontactid_cnt
          ,le.populated_rawfields_maincompanyid_cnt
          ,le.populated_rawfields_active_cnt
          ,le.populated_rawfields_firstname_cnt
          ,le.populated_rawfields_midinital_cnt
          ,le.populated_rawfields_lastname_cnt
          ,le.populated_rawfields_age_cnt
          ,le.populated_rawfields_gender_cnt
          ,le.populated_rawfields_primarytitle_cnt
          ,le.populated_rawfields_titlelevel1_cnt
          ,le.populated_rawfields_primarydept_cnt
          ,le.populated_rawfields_secondtitle_cnt
          ,le.populated_rawfields_titlelevel2_cnt
          ,le.populated_rawfields_seconddept_cnt
          ,le.populated_rawfields_thirdtitle_cnt
          ,le.populated_rawfields_titlelevel3_cnt
          ,le.populated_rawfields_thirddept_cnt
          ,le.populated_rawfields_skillcategory_cnt
          ,le.populated_rawfields_skillsubcategory_cnt
          ,le.populated_rawfields_reportto_cnt
          ,le.populated_rawfields_officephone_cnt
          ,le.populated_rawfields_officeext_cnt
          ,le.populated_rawfields_officefax_cnt
          ,le.populated_rawfields_officeemail_cnt
          ,le.populated_rawfields_directdial_cnt
          ,le.populated_rawfields_mobilephone_cnt
          ,le.populated_rawfields_officeaddress1_cnt
          ,le.populated_rawfields_officeaddress2_cnt
          ,le.populated_rawfields_officecity_cnt
          ,le.populated_rawfields_officestate_cnt
          ,le.populated_rawfields_officezip_cnt
          ,le.populated_rawfields_officecountry_cnt
          ,le.populated_rawfields_school_cnt
          ,le.populated_rawfields_degree_cnt
          ,le.populated_rawfields_graduationyear_cnt
          ,le.populated_rawfields_country_cnt
          ,le.populated_rawfields_salary_cnt
          ,le.populated_rawfields_bonus_cnt
          ,le.populated_rawfields_compensation_cnt
          ,le.populated_rawfields_citizenship_cnt
          ,le.populated_rawfields_diversitycandidate_cnt
          ,le.populated_rawfields_entrydate_cnt
          ,le.populated_rawfields_lastupdate_cnt
          ,le.populated_rawfields_biography_cnt
          ,le.populated_clean_contact_name_title_cnt
          ,le.populated_clean_contact_name_fname_cnt
          ,le.populated_clean_contact_name_mname_cnt
          ,le.populated_clean_contact_name_lname_cnt
          ,le.populated_clean_contact_name_name_suffix_cnt
          ,le.populated_clean_contact_name_name_score_cnt
          ,le.populated_clean_contact_address_prim_range_cnt
          ,le.populated_clean_contact_address_predir_cnt
          ,le.populated_clean_contact_address_prim_name_cnt
          ,le.populated_clean_contact_address_addr_suffix_cnt
          ,le.populated_clean_contact_address_postdir_cnt
          ,le.populated_clean_contact_address_unit_desig_cnt
          ,le.populated_clean_contact_address_sec_range_cnt
          ,le.populated_clean_contact_address_p_city_name_cnt
          ,le.populated_clean_contact_address_v_city_name_cnt
          ,le.populated_clean_contact_address_st_cnt
          ,le.populated_clean_contact_address_zip_cnt
          ,le.populated_clean_contact_address_zip4_cnt
          ,le.populated_clean_contact_address_cart_cnt
          ,le.populated_clean_contact_address_cr_sort_sz_cnt
          ,le.populated_clean_contact_address_lot_cnt
          ,le.populated_clean_contact_address_lot_order_cnt
          ,le.populated_clean_contact_address_dbpc_cnt
          ,le.populated_clean_contact_address_chk_digit_cnt
          ,le.populated_clean_contact_address_rec_type_cnt
          ,le.populated_clean_contact_address_fips_state_cnt
          ,le.populated_clean_contact_address_fips_county_cnt
          ,le.populated_clean_contact_address_geo_lat_cnt
          ,le.populated_clean_contact_address_geo_long_cnt
          ,le.populated_clean_contact_address_msa_cnt
          ,le.populated_clean_contact_address_geo_blk_cnt
          ,le.populated_clean_contact_address_geo_match_cnt
          ,le.populated_clean_contact_address_err_stat_cnt
          ,le.populated_clean_dates_entrydate_cnt
          ,le.populated_clean_dates_lastupdate_cnt
          ,le.populated_clean_phones_officephone_cnt
          ,le.populated_clean_phones_directdial_cnt
          ,le.populated_clean_phones_mobilephone_cnt
          ,le.populated_global_sid_cnt
          ,le.populated_record_sid_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_did_pcnt
          ,le.populated_did_score_pcnt
          ,le.populated_bdid_pcnt
          ,le.populated_bdid_score_pcnt
          ,le.populated_raw_aid_pcnt
          ,le.populated_ace_aid_pcnt
          ,le.populated_dt_first_seen_pcnt
          ,le.populated_dt_last_seen_pcnt
          ,le.populated_dt_vendor_first_reported_pcnt
          ,le.populated_dt_vendor_last_reported_pcnt
          ,le.populated_record_type_pcnt
          ,le.populated_rawfields_maincontactid_pcnt
          ,le.populated_rawfields_maincompanyid_pcnt
          ,le.populated_rawfields_active_pcnt
          ,le.populated_rawfields_firstname_pcnt
          ,le.populated_rawfields_midinital_pcnt
          ,le.populated_rawfields_lastname_pcnt
          ,le.populated_rawfields_age_pcnt
          ,le.populated_rawfields_gender_pcnt
          ,le.populated_rawfields_primarytitle_pcnt
          ,le.populated_rawfields_titlelevel1_pcnt
          ,le.populated_rawfields_primarydept_pcnt
          ,le.populated_rawfields_secondtitle_pcnt
          ,le.populated_rawfields_titlelevel2_pcnt
          ,le.populated_rawfields_seconddept_pcnt
          ,le.populated_rawfields_thirdtitle_pcnt
          ,le.populated_rawfields_titlelevel3_pcnt
          ,le.populated_rawfields_thirddept_pcnt
          ,le.populated_rawfields_skillcategory_pcnt
          ,le.populated_rawfields_skillsubcategory_pcnt
          ,le.populated_rawfields_reportto_pcnt
          ,le.populated_rawfields_officephone_pcnt
          ,le.populated_rawfields_officeext_pcnt
          ,le.populated_rawfields_officefax_pcnt
          ,le.populated_rawfields_officeemail_pcnt
          ,le.populated_rawfields_directdial_pcnt
          ,le.populated_rawfields_mobilephone_pcnt
          ,le.populated_rawfields_officeaddress1_pcnt
          ,le.populated_rawfields_officeaddress2_pcnt
          ,le.populated_rawfields_officecity_pcnt
          ,le.populated_rawfields_officestate_pcnt
          ,le.populated_rawfields_officezip_pcnt
          ,le.populated_rawfields_officecountry_pcnt
          ,le.populated_rawfields_school_pcnt
          ,le.populated_rawfields_degree_pcnt
          ,le.populated_rawfields_graduationyear_pcnt
          ,le.populated_rawfields_country_pcnt
          ,le.populated_rawfields_salary_pcnt
          ,le.populated_rawfields_bonus_pcnt
          ,le.populated_rawfields_compensation_pcnt
          ,le.populated_rawfields_citizenship_pcnt
          ,le.populated_rawfields_diversitycandidate_pcnt
          ,le.populated_rawfields_entrydate_pcnt
          ,le.populated_rawfields_lastupdate_pcnt
          ,le.populated_rawfields_biography_pcnt
          ,le.populated_clean_contact_name_title_pcnt
          ,le.populated_clean_contact_name_fname_pcnt
          ,le.populated_clean_contact_name_mname_pcnt
          ,le.populated_clean_contact_name_lname_pcnt
          ,le.populated_clean_contact_name_name_suffix_pcnt
          ,le.populated_clean_contact_name_name_score_pcnt
          ,le.populated_clean_contact_address_prim_range_pcnt
          ,le.populated_clean_contact_address_predir_pcnt
          ,le.populated_clean_contact_address_prim_name_pcnt
          ,le.populated_clean_contact_address_addr_suffix_pcnt
          ,le.populated_clean_contact_address_postdir_pcnt
          ,le.populated_clean_contact_address_unit_desig_pcnt
          ,le.populated_clean_contact_address_sec_range_pcnt
          ,le.populated_clean_contact_address_p_city_name_pcnt
          ,le.populated_clean_contact_address_v_city_name_pcnt
          ,le.populated_clean_contact_address_st_pcnt
          ,le.populated_clean_contact_address_zip_pcnt
          ,le.populated_clean_contact_address_zip4_pcnt
          ,le.populated_clean_contact_address_cart_pcnt
          ,le.populated_clean_contact_address_cr_sort_sz_pcnt
          ,le.populated_clean_contact_address_lot_pcnt
          ,le.populated_clean_contact_address_lot_order_pcnt
          ,le.populated_clean_contact_address_dbpc_pcnt
          ,le.populated_clean_contact_address_chk_digit_pcnt
          ,le.populated_clean_contact_address_rec_type_pcnt
          ,le.populated_clean_contact_address_fips_state_pcnt
          ,le.populated_clean_contact_address_fips_county_pcnt
          ,le.populated_clean_contact_address_geo_lat_pcnt
          ,le.populated_clean_contact_address_geo_long_pcnt
          ,le.populated_clean_contact_address_msa_pcnt
          ,le.populated_clean_contact_address_geo_blk_pcnt
          ,le.populated_clean_contact_address_geo_match_pcnt
          ,le.populated_clean_contact_address_err_stat_pcnt
          ,le.populated_clean_dates_entrydate_pcnt
          ,le.populated_clean_dates_lastupdate_pcnt
          ,le.populated_clean_phones_officephone_pcnt
          ,le.populated_clean_phones_directdial_pcnt
          ,le.populated_clean_phones_mobilephone_pcnt
          ,le.populated_global_sid_pcnt
          ,le.populated_record_sid_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,95,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Contacts_Delta(prevDS, PROJECT(h, Contacts_Layout_Sheila_Greco));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),95,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Contacts_Layout_Sheila_Greco) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Sheila_Greco, Contacts_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
