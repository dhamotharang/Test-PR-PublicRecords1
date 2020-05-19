IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_BK_Events; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 23;
  EXPORT NumRulesFromFieldType := 23;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 23;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_BK_Events)
    UNSIGNED1 dractivitytypecode_Invalid;
    UNSIGNED1 docketentryid_Invalid;
    UNSIGNED1 courtid_Invalid;
    UNSIGNED1 casekey_Invalid;
    UNSIGNED1 casetype_Invalid;
    UNSIGNED1 bkcasenumber_Invalid;
    UNSIGNED1 bkcasenumberurl_Invalid;
    UNSIGNED1 proceedingscasenumber_Invalid;
    UNSIGNED1 proceedingscasenumberurl_Invalid;
    UNSIGNED1 caseid_Invalid;
    UNSIGNED1 pacercaseid_Invalid;
    UNSIGNED1 attachmenturl_Invalid;
    UNSIGNED1 entrynumber_Invalid;
    UNSIGNED1 entereddate_Invalid;
    UNSIGNED1 pacer_entereddate_Invalid;
    UNSIGNED1 fileddate_Invalid;
    UNSIGNED1 score_Invalid;
    UNSIGNED1 drcategoryeventid_Invalid;
    UNSIGNED1 court_code_Invalid;
    UNSIGNED1 district_Invalid;
    UNSIGNED1 boca_court_Invalid;
    UNSIGNED1 catevent_description_Invalid;
    UNSIGNED1 catevent_category_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_BK_Events)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_BK_Events)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dractivitytypecode:Invalid_Alpha:CUSTOM'
          ,'docketentryid:Invalid_No:ALLOW'
          ,'courtid:Invalid_No:ALLOW'
          ,'casekey:Invalid_No:ALLOW'
          ,'casetype:Invalid_Alpha:CUSTOM'
          ,'bkcasenumber:Invalid_CaseNo:ALLOW'
          ,'bkcasenumberurl:Invalid_URL:ALLOW'
          ,'proceedingscasenumber:Invalid_CaseNo:ALLOW'
          ,'proceedingscasenumberurl:Invalid_URL:ALLOW'
          ,'caseid:Invalid_No:ALLOW'
          ,'pacercaseid:Invalid_Int:ALLOW'
          ,'attachmenturl:Invalid_URL:ALLOW'
          ,'entrynumber:Invalid_Int:ALLOW'
          ,'entereddate:Invalid_Date:CUSTOM'
          ,'pacer_entereddate:Invalid_Date:CUSTOM'
          ,'fileddate:Invalid_Date:CUSTOM'
          ,'score:Invalid_Float:ALLOW'
          ,'drcategoryeventid:Invalid_No:ALLOW'
          ,'court_code:Invalid_AlphaNum:CUSTOM'
          ,'district:Invalid_Alpha:CUSTOM'
          ,'boca_court:Invalid_Alpha:CUSTOM'
          ,'catevent_description:Invalid_AlphaNumChar:CUSTOM'
          ,'catevent_category:Invalid_AlphaNumChar:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_dractivitytypecode(1)
          ,Fields.InvalidMessage_docketentryid(1)
          ,Fields.InvalidMessage_courtid(1)
          ,Fields.InvalidMessage_casekey(1)
          ,Fields.InvalidMessage_casetype(1)
          ,Fields.InvalidMessage_bkcasenumber(1)
          ,Fields.InvalidMessage_bkcasenumberurl(1)
          ,Fields.InvalidMessage_proceedingscasenumber(1)
          ,Fields.InvalidMessage_proceedingscasenumberurl(1)
          ,Fields.InvalidMessage_caseid(1)
          ,Fields.InvalidMessage_pacercaseid(1)
          ,Fields.InvalidMessage_attachmenturl(1)
          ,Fields.InvalidMessage_entrynumber(1)
          ,Fields.InvalidMessage_entereddate(1)
          ,Fields.InvalidMessage_pacer_entereddate(1)
          ,Fields.InvalidMessage_fileddate(1)
          ,Fields.InvalidMessage_score(1)
          ,Fields.InvalidMessage_drcategoryeventid(1)
          ,Fields.InvalidMessage_court_code(1)
          ,Fields.InvalidMessage_district(1)
          ,Fields.InvalidMessage_boca_court(1)
          ,Fields.InvalidMessage_catevent_description(1)
          ,Fields.InvalidMessage_catevent_category(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_BK_Events) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dractivitytypecode_Invalid := Fields.InValid_dractivitytypecode((SALT311.StrType)le.dractivitytypecode);
    SELF.docketentryid_Invalid := Fields.InValid_docketentryid((SALT311.StrType)le.docketentryid);
    SELF.courtid_Invalid := Fields.InValid_courtid((SALT311.StrType)le.courtid);
    SELF.casekey_Invalid := Fields.InValid_casekey((SALT311.StrType)le.casekey);
    SELF.casetype_Invalid := Fields.InValid_casetype((SALT311.StrType)le.casetype);
    SELF.bkcasenumber_Invalid := Fields.InValid_bkcasenumber((SALT311.StrType)le.bkcasenumber);
    SELF.bkcasenumberurl_Invalid := Fields.InValid_bkcasenumberurl((SALT311.StrType)le.bkcasenumberurl);
    SELF.proceedingscasenumber_Invalid := Fields.InValid_proceedingscasenumber((SALT311.StrType)le.proceedingscasenumber);
    SELF.proceedingscasenumberurl_Invalid := Fields.InValid_proceedingscasenumberurl((SALT311.StrType)le.proceedingscasenumberurl);
    SELF.caseid_Invalid := Fields.InValid_caseid((SALT311.StrType)le.caseid);
    SELF.pacercaseid_Invalid := Fields.InValid_pacercaseid((SALT311.StrType)le.pacercaseid);
    SELF.attachmenturl_Invalid := Fields.InValid_attachmenturl((SALT311.StrType)le.attachmenturl);
    SELF.entrynumber_Invalid := Fields.InValid_entrynumber((SALT311.StrType)le.entrynumber);
    SELF.entereddate_Invalid := Fields.InValid_entereddate((SALT311.StrType)le.entereddate);
    SELF.pacer_entereddate_Invalid := Fields.InValid_pacer_entereddate((SALT311.StrType)le.pacer_entereddate);
    SELF.fileddate_Invalid := Fields.InValid_fileddate((SALT311.StrType)le.fileddate);
    SELF.score_Invalid := Fields.InValid_score((SALT311.StrType)le.score);
    SELF.drcategoryeventid_Invalid := Fields.InValid_drcategoryeventid((SALT311.StrType)le.drcategoryeventid);
    SELF.court_code_Invalid := Fields.InValid_court_code((SALT311.StrType)le.court_code);
    SELF.district_Invalid := Fields.InValid_district((SALT311.StrType)le.district);
    SELF.boca_court_Invalid := Fields.InValid_boca_court((SALT311.StrType)le.boca_court);
    SELF.catevent_description_Invalid := Fields.InValid_catevent_description((SALT311.StrType)le.catevent_description);
    SELF.catevent_category_Invalid := Fields.InValid_catevent_category((SALT311.StrType)le.catevent_category);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_BK_Events);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dractivitytypecode_Invalid << 0 ) + ( le.docketentryid_Invalid << 1 ) + ( le.courtid_Invalid << 2 ) + ( le.casekey_Invalid << 3 ) + ( le.casetype_Invalid << 4 ) + ( le.bkcasenumber_Invalid << 5 ) + ( le.bkcasenumberurl_Invalid << 6 ) + ( le.proceedingscasenumber_Invalid << 7 ) + ( le.proceedingscasenumberurl_Invalid << 8 ) + ( le.caseid_Invalid << 9 ) + ( le.pacercaseid_Invalid << 10 ) + ( le.attachmenturl_Invalid << 11 ) + ( le.entrynumber_Invalid << 12 ) + ( le.entereddate_Invalid << 13 ) + ( le.pacer_entereddate_Invalid << 14 ) + ( le.fileddate_Invalid << 15 ) + ( le.score_Invalid << 16 ) + ( le.drcategoryeventid_Invalid << 17 ) + ( le.court_code_Invalid << 18 ) + ( le.district_Invalid << 19 ) + ( le.boca_court_Invalid << 20 ) + ( le.catevent_description_Invalid << 21 ) + ( le.catevent_category_Invalid << 22 );
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
  EXPORT Infile := PROJECT(h,Layout_BK_Events);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dractivitytypecode_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.docketentryid_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.courtid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.casekey_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.casetype_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.bkcasenumber_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.bkcasenumberurl_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.proceedingscasenumber_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.proceedingscasenumberurl_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.caseid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.pacercaseid_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.attachmenturl_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.entrynumber_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.entereddate_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.pacer_entereddate_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.fileddate_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.score_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.drcategoryeventid_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.court_code_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.district_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.boca_court_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.catevent_description_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.catevent_category_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dractivitytypecode_CUSTOM_ErrorCount := COUNT(GROUP,h.dractivitytypecode_Invalid=1);
    docketentryid_ALLOW_ErrorCount := COUNT(GROUP,h.docketentryid_Invalid=1);
    courtid_ALLOW_ErrorCount := COUNT(GROUP,h.courtid_Invalid=1);
    casekey_ALLOW_ErrorCount := COUNT(GROUP,h.casekey_Invalid=1);
    casetype_CUSTOM_ErrorCount := COUNT(GROUP,h.casetype_Invalid=1);
    bkcasenumber_ALLOW_ErrorCount := COUNT(GROUP,h.bkcasenumber_Invalid=1);
    bkcasenumberurl_ALLOW_ErrorCount := COUNT(GROUP,h.bkcasenumberurl_Invalid=1);
    proceedingscasenumber_ALLOW_ErrorCount := COUNT(GROUP,h.proceedingscasenumber_Invalid=1);
    proceedingscasenumberurl_ALLOW_ErrorCount := COUNT(GROUP,h.proceedingscasenumberurl_Invalid=1);
    caseid_ALLOW_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
    pacercaseid_ALLOW_ErrorCount := COUNT(GROUP,h.pacercaseid_Invalid=1);
    attachmenturl_ALLOW_ErrorCount := COUNT(GROUP,h.attachmenturl_Invalid=1);
    entrynumber_ALLOW_ErrorCount := COUNT(GROUP,h.entrynumber_Invalid=1);
    entereddate_CUSTOM_ErrorCount := COUNT(GROUP,h.entereddate_Invalid=1);
    pacer_entereddate_CUSTOM_ErrorCount := COUNT(GROUP,h.pacer_entereddate_Invalid=1);
    fileddate_CUSTOM_ErrorCount := COUNT(GROUP,h.fileddate_Invalid=1);
    score_ALLOW_ErrorCount := COUNT(GROUP,h.score_Invalid=1);
    drcategoryeventid_ALLOW_ErrorCount := COUNT(GROUP,h.drcategoryeventid_Invalid=1);
    court_code_CUSTOM_ErrorCount := COUNT(GROUP,h.court_code_Invalid=1);
    district_CUSTOM_ErrorCount := COUNT(GROUP,h.district_Invalid=1);
    boca_court_CUSTOM_ErrorCount := COUNT(GROUP,h.boca_court_Invalid=1);
    catevent_description_CUSTOM_ErrorCount := COUNT(GROUP,h.catevent_description_Invalid=1);
    catevent_category_CUSTOM_ErrorCount := COUNT(GROUP,h.catevent_category_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dractivitytypecode_Invalid > 0 OR h.docketentryid_Invalid > 0 OR h.courtid_Invalid > 0 OR h.casekey_Invalid > 0 OR h.casetype_Invalid > 0 OR h.bkcasenumber_Invalid > 0 OR h.bkcasenumberurl_Invalid > 0 OR h.proceedingscasenumber_Invalid > 0 OR h.proceedingscasenumberurl_Invalid > 0 OR h.caseid_Invalid > 0 OR h.pacercaseid_Invalid > 0 OR h.attachmenturl_Invalid > 0 OR h.entrynumber_Invalid > 0 OR h.entereddate_Invalid > 0 OR h.pacer_entereddate_Invalid > 0 OR h.fileddate_Invalid > 0 OR h.score_Invalid > 0 OR h.drcategoryeventid_Invalid > 0 OR h.court_code_Invalid > 0 OR h.district_Invalid > 0 OR h.boca_court_Invalid > 0 OR h.catevent_description_Invalid > 0 OR h.catevent_category_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dractivitytypecode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.docketentryid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.courtid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casekey_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casetype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkcasenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bkcasenumberurl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proceedingscasenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proceedingscasenumberurl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.caseid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pacercaseid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attachmenturl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entrynumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entereddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pacer_entereddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fileddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drcategoryeventid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.court_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.district_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.boca_court_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.catevent_description_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.catevent_category_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dractivitytypecode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.docketentryid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.courtid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casekey_ALLOW_ErrorCount > 0, 1, 0) + IF(le.casetype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bkcasenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.bkcasenumberurl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proceedingscasenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.proceedingscasenumberurl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.caseid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.pacercaseid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.attachmenturl_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entrynumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entereddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.pacer_entereddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.fileddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.score_ALLOW_ErrorCount > 0, 1, 0) + IF(le.drcategoryeventid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.court_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.district_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.boca_court_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.catevent_description_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.catevent_category_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dractivitytypecode_Invalid,le.docketentryid_Invalid,le.courtid_Invalid,le.casekey_Invalid,le.casetype_Invalid,le.bkcasenumber_Invalid,le.bkcasenumberurl_Invalid,le.proceedingscasenumber_Invalid,le.proceedingscasenumberurl_Invalid,le.caseid_Invalid,le.pacercaseid_Invalid,le.attachmenturl_Invalid,le.entrynumber_Invalid,le.entereddate_Invalid,le.pacer_entereddate_Invalid,le.fileddate_Invalid,le.score_Invalid,le.drcategoryeventid_Invalid,le.court_code_Invalid,le.district_Invalid,le.boca_court_Invalid,le.catevent_description_Invalid,le.catevent_category_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dractivitytypecode(le.dractivitytypecode_Invalid),Fields.InvalidMessage_docketentryid(le.docketentryid_Invalid),Fields.InvalidMessage_courtid(le.courtid_Invalid),Fields.InvalidMessage_casekey(le.casekey_Invalid),Fields.InvalidMessage_casetype(le.casetype_Invalid),Fields.InvalidMessage_bkcasenumber(le.bkcasenumber_Invalid),Fields.InvalidMessage_bkcasenumberurl(le.bkcasenumberurl_Invalid),Fields.InvalidMessage_proceedingscasenumber(le.proceedingscasenumber_Invalid),Fields.InvalidMessage_proceedingscasenumberurl(le.proceedingscasenumberurl_Invalid),Fields.InvalidMessage_caseid(le.caseid_Invalid),Fields.InvalidMessage_pacercaseid(le.pacercaseid_Invalid),Fields.InvalidMessage_attachmenturl(le.attachmenturl_Invalid),Fields.InvalidMessage_entrynumber(le.entrynumber_Invalid),Fields.InvalidMessage_entereddate(le.entereddate_Invalid),Fields.InvalidMessage_pacer_entereddate(le.pacer_entereddate_Invalid),Fields.InvalidMessage_fileddate(le.fileddate_Invalid),Fields.InvalidMessage_score(le.score_Invalid),Fields.InvalidMessage_drcategoryeventid(le.drcategoryeventid_Invalid),Fields.InvalidMessage_court_code(le.court_code_Invalid),Fields.InvalidMessage_district(le.district_Invalid),Fields.InvalidMessage_boca_court(le.boca_court_Invalid),Fields.InvalidMessage_catevent_description(le.catevent_description_Invalid),Fields.InvalidMessage_catevent_category(le.catevent_category_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dractivitytypecode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.docketentryid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.courtid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.casekey_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.casetype_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bkcasenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.bkcasenumberurl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proceedingscasenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.proceedingscasenumberurl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.pacercaseid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.attachmenturl_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.entrynumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.entereddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.pacer_entereddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.fileddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.score_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.drcategoryeventid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.court_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.district_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.boca_court_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.catevent_description_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.catevent_category_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dractivitytypecode','docketentryid','courtid','casekey','casetype','bkcasenumber','bkcasenumberurl','proceedingscasenumber','proceedingscasenumberurl','caseid','pacercaseid','attachmenturl','entrynumber','entereddate','pacer_entereddate','fileddate','score','drcategoryeventid','court_code','district','boca_court','catevent_description','catevent_category','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Alpha','Invalid_No','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_CaseNo','Invalid_URL','Invalid_CaseNo','Invalid_URL','Invalid_No','Invalid_Int','Invalid_URL','Invalid_Int','Invalid_Date','Invalid_Date','Invalid_Date','Invalid_Float','Invalid_No','Invalid_AlphaNum','Invalid_Alpha','Invalid_Alpha','Invalid_AlphaNumChar','Invalid_AlphaNumChar','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dractivitytypecode,(SALT311.StrType)le.docketentryid,(SALT311.StrType)le.courtid,(SALT311.StrType)le.casekey,(SALT311.StrType)le.casetype,(SALT311.StrType)le.bkcasenumber,(SALT311.StrType)le.bkcasenumberurl,(SALT311.StrType)le.proceedingscasenumber,(SALT311.StrType)le.proceedingscasenumberurl,(SALT311.StrType)le.caseid,(SALT311.StrType)le.pacercaseid,(SALT311.StrType)le.attachmenturl,(SALT311.StrType)le.entrynumber,(SALT311.StrType)le.entereddate,(SALT311.StrType)le.pacer_entereddate,(SALT311.StrType)le.fileddate,(SALT311.StrType)le.score,(SALT311.StrType)le.drcategoryeventid,(SALT311.StrType)le.court_code,(SALT311.StrType)le.district,(SALT311.StrType)le.boca_court,(SALT311.StrType)le.catevent_description,(SALT311.StrType)le.catevent_category,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,23,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_BK_Events) prevDS = DATASET([], Layout_BK_Events), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dractivitytypecode_CUSTOM_ErrorCount
          ,le.docketentryid_ALLOW_ErrorCount
          ,le.courtid_ALLOW_ErrorCount
          ,le.casekey_ALLOW_ErrorCount
          ,le.casetype_CUSTOM_ErrorCount
          ,le.bkcasenumber_ALLOW_ErrorCount
          ,le.bkcasenumberurl_ALLOW_ErrorCount
          ,le.proceedingscasenumber_ALLOW_ErrorCount
          ,le.proceedingscasenumberurl_ALLOW_ErrorCount
          ,le.caseid_ALLOW_ErrorCount
          ,le.pacercaseid_ALLOW_ErrorCount
          ,le.attachmenturl_ALLOW_ErrorCount
          ,le.entrynumber_ALLOW_ErrorCount
          ,le.entereddate_CUSTOM_ErrorCount
          ,le.pacer_entereddate_CUSTOM_ErrorCount
          ,le.fileddate_CUSTOM_ErrorCount
          ,le.score_ALLOW_ErrorCount
          ,le.drcategoryeventid_ALLOW_ErrorCount
          ,le.court_code_CUSTOM_ErrorCount
          ,le.district_CUSTOM_ErrorCount
          ,le.boca_court_CUSTOM_ErrorCount
          ,le.catevent_description_CUSTOM_ErrorCount
          ,le.catevent_category_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dractivitytypecode_CUSTOM_ErrorCount
          ,le.docketentryid_ALLOW_ErrorCount
          ,le.courtid_ALLOW_ErrorCount
          ,le.casekey_ALLOW_ErrorCount
          ,le.casetype_CUSTOM_ErrorCount
          ,le.bkcasenumber_ALLOW_ErrorCount
          ,le.bkcasenumberurl_ALLOW_ErrorCount
          ,le.proceedingscasenumber_ALLOW_ErrorCount
          ,le.proceedingscasenumberurl_ALLOW_ErrorCount
          ,le.caseid_ALLOW_ErrorCount
          ,le.pacercaseid_ALLOW_ErrorCount
          ,le.attachmenturl_ALLOW_ErrorCount
          ,le.entrynumber_ALLOW_ErrorCount
          ,le.entereddate_CUSTOM_ErrorCount
          ,le.pacer_entereddate_CUSTOM_ErrorCount
          ,le.fileddate_CUSTOM_ErrorCount
          ,le.score_ALLOW_ErrorCount
          ,le.drcategoryeventid_ALLOW_ErrorCount
          ,le.court_code_CUSTOM_ErrorCount
          ,le.district_CUSTOM_ErrorCount
          ,le.boca_court_CUSTOM_ErrorCount
          ,le.catevent_description_CUSTOM_ErrorCount
          ,le.catevent_category_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_BK_Events));
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
          ,'dractivitytypecode:' + getFieldTypeText(h.dractivitytypecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'docketentryid:' + getFieldTypeText(h.docketentryid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtid:' + getFieldTypeText(h.courtid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casekey:' + getFieldTypeText(h.casekey) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casetype:' + getFieldTypeText(h.casetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkcasenumber:' + getFieldTypeText(h.bkcasenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bkcasenumberurl:' + getFieldTypeText(h.bkcasenumberurl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proceedingscasenumber:' + getFieldTypeText(h.proceedingscasenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'proceedingscasenumberurl:' + getFieldTypeText(h.proceedingscasenumberurl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'caseid:' + getFieldTypeText(h.caseid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pacercaseid:' + getFieldTypeText(h.pacercaseid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'attachmenturl:' + getFieldTypeText(h.attachmenturl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entrynumber:' + getFieldTypeText(h.entrynumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entereddate:' + getFieldTypeText(h.entereddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pacer_entereddate:' + getFieldTypeText(h.pacer_entereddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fileddate:' + getFieldTypeText(h.fileddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'score:' + getFieldTypeText(h.score) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'drcategoryeventid:' + getFieldTypeText(h.drcategoryeventid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'court_code:' + getFieldTypeText(h.court_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'district:' + getFieldTypeText(h.district) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'boca_court:' + getFieldTypeText(h.boca_court) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'catevent_description:' + getFieldTypeText(h.catevent_description) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'catevent_category:' + getFieldTypeText(h.catevent_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dractivitytypecode_cnt
          ,le.populated_docketentryid_cnt
          ,le.populated_courtid_cnt
          ,le.populated_casekey_cnt
          ,le.populated_casetype_cnt
          ,le.populated_bkcasenumber_cnt
          ,le.populated_bkcasenumberurl_cnt
          ,le.populated_proceedingscasenumber_cnt
          ,le.populated_proceedingscasenumberurl_cnt
          ,le.populated_caseid_cnt
          ,le.populated_pacercaseid_cnt
          ,le.populated_attachmenturl_cnt
          ,le.populated_entrynumber_cnt
          ,le.populated_entereddate_cnt
          ,le.populated_pacer_entereddate_cnt
          ,le.populated_fileddate_cnt
          ,le.populated_score_cnt
          ,le.populated_drcategoryeventid_cnt
          ,le.populated_court_code_cnt
          ,le.populated_district_cnt
          ,le.populated_boca_court_cnt
          ,le.populated_catevent_description_cnt
          ,le.populated_catevent_category_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dractivitytypecode_pcnt
          ,le.populated_docketentryid_pcnt
          ,le.populated_courtid_pcnt
          ,le.populated_casekey_pcnt
          ,le.populated_casetype_pcnt
          ,le.populated_bkcasenumber_pcnt
          ,le.populated_bkcasenumberurl_pcnt
          ,le.populated_proceedingscasenumber_pcnt
          ,le.populated_proceedingscasenumberurl_pcnt
          ,le.populated_caseid_pcnt
          ,le.populated_pacercaseid_pcnt
          ,le.populated_attachmenturl_pcnt
          ,le.populated_entrynumber_pcnt
          ,le.populated_entereddate_pcnt
          ,le.populated_pacer_entereddate_pcnt
          ,le.populated_fileddate_pcnt
          ,le.populated_score_pcnt
          ,le.populated_drcategoryeventid_pcnt
          ,le.populated_court_code_pcnt
          ,le.populated_district_pcnt
          ,le.populated_boca_court_pcnt
          ,le.populated_catevent_description_pcnt
          ,le.populated_catevent_category_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,23,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_BK_Events));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),23,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_BK_Events) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_BK_Events, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
