IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 17;
  EXPORT NumRulesFromFieldType := 17;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 16;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_LaborActions_EBSA)
    UNSIGNED1 dart_id_Invalid;
    UNSIGNED1 date_added_Invalid;
    UNSIGNED1 date_updated_Invalid;
    UNSIGNED1 website_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 casetype_Invalid;
    UNSIGNED1 plan_ein_Invalid;
    UNSIGNED1 plan_no_Invalid;
    UNSIGNED1 plan_year_Invalid;
    UNSIGNED1 plan_name_Invalid;
    UNSIGNED1 plan_administrator_Invalid;
    UNSIGNED1 admin_state_Invalid;
    UNSIGNED1 admin_zip_code_Invalid;
    UNSIGNED1 admin_zip_code4_Invalid;
    UNSIGNED1 closing_reason_Invalid;
    UNSIGNED1 closing_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_LaborActions_EBSA)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_LaborActions_EBSA)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'dart_id:Invalid_No:ALLOW'
          ,'date_added:Invalid_Date:CUSTOM'
          ,'date_updated:Invalid_Date:CUSTOM'
          ,'website:Invalid_Alpha:ALLOW'
          ,'state:Invalid_State:ALLOW','state:Invalid_State:LENGTHS'
          ,'casetype:Invalid_Alpha:ALLOW'
          ,'plan_ein:Invalid_Float:ALLOW'
          ,'plan_no:Invalid_No:ALLOW'
          ,'plan_year:Invalid_Float:ALLOW'
          ,'plan_name:Invalid_AlphaNumChar:ALLOW'
          ,'plan_administrator:Invalid_AlphaNumChar:ALLOW'
          ,'admin_state:Invalid_Alpha:ALLOW'
          ,'admin_zip_code:Invalid_No:ALLOW'
          ,'admin_zip_code4:Invalid_No:ALLOW'
          ,'closing_reason:Invalid_Alpha:ALLOW'
          ,'closing_date:Invalid_Date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_dart_id(1)
          ,Fields.InvalidMessage_date_added(1)
          ,Fields.InvalidMessage_date_updated(1)
          ,Fields.InvalidMessage_website(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_casetype(1)
          ,Fields.InvalidMessage_plan_ein(1)
          ,Fields.InvalidMessage_plan_no(1)
          ,Fields.InvalidMessage_plan_year(1)
          ,Fields.InvalidMessage_plan_name(1)
          ,Fields.InvalidMessage_plan_administrator(1)
          ,Fields.InvalidMessage_admin_state(1)
          ,Fields.InvalidMessage_admin_zip_code(1)
          ,Fields.InvalidMessage_admin_zip_code4(1)
          ,Fields.InvalidMessage_closing_reason(1)
          ,Fields.InvalidMessage_closing_date(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_LaborActions_EBSA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.dart_id_Invalid := Fields.InValid_dart_id((SALT311.StrType)le.dart_id);
    SELF.date_added_Invalid := Fields.InValid_date_added((SALT311.StrType)le.date_added);
    SELF.date_updated_Invalid := Fields.InValid_date_updated((SALT311.StrType)le.date_updated);
    SELF.website_Invalid := Fields.InValid_website((SALT311.StrType)le.website);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.casetype_Invalid := Fields.InValid_casetype((SALT311.StrType)le.casetype);
    SELF.plan_ein_Invalid := Fields.InValid_plan_ein((SALT311.StrType)le.plan_ein);
    SELF.plan_no_Invalid := Fields.InValid_plan_no((SALT311.StrType)le.plan_no);
    SELF.plan_year_Invalid := Fields.InValid_plan_year((SALT311.StrType)le.plan_year);
    SELF.plan_name_Invalid := Fields.InValid_plan_name((SALT311.StrType)le.plan_name);
    SELF.plan_administrator_Invalid := Fields.InValid_plan_administrator((SALT311.StrType)le.plan_administrator);
    SELF.admin_state_Invalid := Fields.InValid_admin_state((SALT311.StrType)le.admin_state);
    SELF.admin_zip_code_Invalid := Fields.InValid_admin_zip_code((SALT311.StrType)le.admin_zip_code);
    SELF.admin_zip_code4_Invalid := Fields.InValid_admin_zip_code4((SALT311.StrType)le.admin_zip_code4);
    SELF.closing_reason_Invalid := Fields.InValid_closing_reason((SALT311.StrType)le.closing_reason);
    SELF.closing_date_Invalid := Fields.InValid_closing_date((SALT311.StrType)le.closing_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_LaborActions_EBSA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.dart_id_Invalid << 0 ) + ( le.date_added_Invalid << 1 ) + ( le.date_updated_Invalid << 2 ) + ( le.website_Invalid << 3 ) + ( le.state_Invalid << 4 ) + ( le.casetype_Invalid << 6 ) + ( le.plan_ein_Invalid << 7 ) + ( le.plan_no_Invalid << 8 ) + ( le.plan_year_Invalid << 9 ) + ( le.plan_name_Invalid << 10 ) + ( le.plan_administrator_Invalid << 11 ) + ( le.admin_state_Invalid << 12 ) + ( le.admin_zip_code_Invalid << 13 ) + ( le.admin_zip_code4_Invalid << 14 ) + ( le.closing_reason_Invalid << 15 ) + ( le.closing_date_Invalid << 16 );
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
  EXPORT Infile := PROJECT(h,Layout_LaborActions_EBSA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.dart_id_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.date_added_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.date_updated_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.website_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.casetype_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.plan_ein_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.plan_no_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.plan_year_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.plan_name_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.plan_administrator_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.admin_state_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.admin_zip_code_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.admin_zip_code4_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.closing_reason_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.closing_date_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    dart_id_ALLOW_ErrorCount := COUNT(GROUP,h.dart_id_Invalid=1);
    date_added_CUSTOM_ErrorCount := COUNT(GROUP,h.date_added_Invalid=1);
    date_updated_CUSTOM_ErrorCount := COUNT(GROUP,h.date_updated_Invalid=1);
    website_ALLOW_ErrorCount := COUNT(GROUP,h.website_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTHS_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    casetype_ALLOW_ErrorCount := COUNT(GROUP,h.casetype_Invalid=1);
    plan_ein_ALLOW_ErrorCount := COUNT(GROUP,h.plan_ein_Invalid=1);
    plan_no_ALLOW_ErrorCount := COUNT(GROUP,h.plan_no_Invalid=1);
    plan_year_ALLOW_ErrorCount := COUNT(GROUP,h.plan_year_Invalid=1);
    plan_name_ALLOW_ErrorCount := COUNT(GROUP,h.plan_name_Invalid=1);
    plan_administrator_ALLOW_ErrorCount := COUNT(GROUP,h.plan_administrator_Invalid=1);
    admin_state_ALLOW_ErrorCount := COUNT(GROUP,h.admin_state_Invalid=1);
    admin_zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.admin_zip_code_Invalid=1);
    admin_zip_code4_ALLOW_ErrorCount := COUNT(GROUP,h.admin_zip_code4_Invalid=1);
    closing_reason_ALLOW_ErrorCount := COUNT(GROUP,h.closing_reason_Invalid=1);
    closing_date_CUSTOM_ErrorCount := COUNT(GROUP,h.closing_date_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.dart_id_Invalid > 0 OR h.date_added_Invalid > 0 OR h.date_updated_Invalid > 0 OR h.website_Invalid > 0 OR h.state_Invalid > 0 OR h.casetype_Invalid > 0 OR h.plan_ein_Invalid > 0 OR h.plan_no_Invalid > 0 OR h.plan_year_Invalid > 0 OR h.plan_name_Invalid > 0 OR h.plan_administrator_Invalid > 0 OR h.admin_state_Invalid > 0 OR h.admin_zip_code_Invalid > 0 OR h.admin_zip_code4_Invalid > 0 OR h.closing_reason_Invalid > 0 OR h.closing_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.dart_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_updated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_Total_ErrorCount > 0, 1, 0) + IF(le.casetype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_ein_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_no_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_administrator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_zip_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_zip_code4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.closing_reason_ALLOW_ErrorCount > 0, 1, 0) + IF(le.closing_date_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.dart_id_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_added_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_updated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.website_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.casetype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_ein_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_no_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_year_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plan_administrator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_zip_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.admin_zip_code4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.closing_reason_ALLOW_ErrorCount > 0, 1, 0) + IF(le.closing_date_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.dart_id_Invalid,le.date_added_Invalid,le.date_updated_Invalid,le.website_Invalid,le.state_Invalid,le.casetype_Invalid,le.plan_ein_Invalid,le.plan_no_Invalid,le.plan_year_Invalid,le.plan_name_Invalid,le.plan_administrator_Invalid,le.admin_state_Invalid,le.admin_zip_code_Invalid,le.admin_zip_code4_Invalid,le.closing_reason_Invalid,le.closing_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_dart_id(le.dart_id_Invalid),Fields.InvalidMessage_date_added(le.date_added_Invalid),Fields.InvalidMessage_date_updated(le.date_updated_Invalid),Fields.InvalidMessage_website(le.website_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_casetype(le.casetype_Invalid),Fields.InvalidMessage_plan_ein(le.plan_ein_Invalid),Fields.InvalidMessage_plan_no(le.plan_no_Invalid),Fields.InvalidMessage_plan_year(le.plan_year_Invalid),Fields.InvalidMessage_plan_name(le.plan_name_Invalid),Fields.InvalidMessage_plan_administrator(le.plan_administrator_Invalid),Fields.InvalidMessage_admin_state(le.admin_state_Invalid),Fields.InvalidMessage_admin_zip_code(le.admin_zip_code_Invalid),Fields.InvalidMessage_admin_zip_code4(le.admin_zip_code4_Invalid),Fields.InvalidMessage_closing_reason(le.closing_reason_Invalid),Fields.InvalidMessage_closing_date(le.closing_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.dart_id_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_added_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_updated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.website_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.casetype_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plan_ein_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plan_no_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plan_year_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plan_name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.plan_administrator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.admin_state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.admin_zip_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.admin_zip_code4_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.closing_reason_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.closing_date_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'dart_id','date_added','date_updated','website','state','casetype','plan_ein','plan_no','plan_year','plan_name','plan_administrator','admin_state','admin_zip_code','admin_zip_code4','closing_reason','closing_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_Date','Invalid_Date','Invalid_Alpha','Invalid_State','Invalid_Alpha','Invalid_Float','Invalid_No','Invalid_Float','Invalid_AlphaNumChar','Invalid_AlphaNumChar','Invalid_Alpha','Invalid_No','Invalid_No','Invalid_Alpha','Invalid_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.dart_id,(SALT311.StrType)le.date_added,(SALT311.StrType)le.date_updated,(SALT311.StrType)le.website,(SALT311.StrType)le.state,(SALT311.StrType)le.casetype,(SALT311.StrType)le.plan_ein,(SALT311.StrType)le.plan_no,(SALT311.StrType)le.plan_year,(SALT311.StrType)le.plan_name,(SALT311.StrType)le.plan_administrator,(SALT311.StrType)le.admin_state,(SALT311.StrType)le.admin_zip_code,(SALT311.StrType)le.admin_zip_code4,(SALT311.StrType)le.closing_reason,(SALT311.StrType)le.closing_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,16,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_LaborActions_EBSA) prevDS = DATASET([], Layout_LaborActions_EBSA), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.dart_id_ALLOW_ErrorCount
          ,le.date_added_CUSTOM_ErrorCount
          ,le.date_updated_CUSTOM_ErrorCount
          ,le.website_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.casetype_ALLOW_ErrorCount
          ,le.plan_ein_ALLOW_ErrorCount
          ,le.plan_no_ALLOW_ErrorCount
          ,le.plan_year_ALLOW_ErrorCount
          ,le.plan_name_ALLOW_ErrorCount
          ,le.plan_administrator_ALLOW_ErrorCount
          ,le.admin_state_ALLOW_ErrorCount
          ,le.admin_zip_code_ALLOW_ErrorCount
          ,le.admin_zip_code4_ALLOW_ErrorCount
          ,le.closing_reason_ALLOW_ErrorCount
          ,le.closing_date_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.dart_id_ALLOW_ErrorCount
          ,le.date_added_CUSTOM_ErrorCount
          ,le.date_updated_CUSTOM_ErrorCount
          ,le.website_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTHS_ErrorCount
          ,le.casetype_ALLOW_ErrorCount
          ,le.plan_ein_ALLOW_ErrorCount
          ,le.plan_no_ALLOW_ErrorCount
          ,le.plan_year_ALLOW_ErrorCount
          ,le.plan_name_ALLOW_ErrorCount
          ,le.plan_administrator_ALLOW_ErrorCount
          ,le.admin_state_ALLOW_ErrorCount
          ,le.admin_zip_code_ALLOW_ErrorCount
          ,le.admin_zip_code4_ALLOW_ErrorCount
          ,le.closing_reason_ALLOW_ErrorCount
          ,le.closing_date_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_LaborActions_EBSA));
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
          ,'dart_id:' + getFieldTypeText(h.dart_id) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_added:' + getFieldTypeText(h.date_added) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_updated:' + getFieldTypeText(h.date_updated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'website:' + getFieldTypeText(h.website) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casetype:' + getFieldTypeText(h.casetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plan_ein:' + getFieldTypeText(h.plan_ein) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plan_no:' + getFieldTypeText(h.plan_no) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plan_year:' + getFieldTypeText(h.plan_year) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plan_name:' + getFieldTypeText(h.plan_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plan_administrator:' + getFieldTypeText(h.plan_administrator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_state:' + getFieldTypeText(h.admin_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_zip_code:' + getFieldTypeText(h.admin_zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'admin_zip_code4:' + getFieldTypeText(h.admin_zip_code4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'closing_reason:' + getFieldTypeText(h.closing_reason) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'closing_date:' + getFieldTypeText(h.closing_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'penalty_amount:' + getFieldTypeText(h.penalty_amount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_dart_id_cnt
          ,le.populated_date_added_cnt
          ,le.populated_date_updated_cnt
          ,le.populated_website_cnt
          ,le.populated_state_cnt
          ,le.populated_casetype_cnt
          ,le.populated_plan_ein_cnt
          ,le.populated_plan_no_cnt
          ,le.populated_plan_year_cnt
          ,le.populated_plan_name_cnt
          ,le.populated_plan_administrator_cnt
          ,le.populated_admin_state_cnt
          ,le.populated_admin_zip_code_cnt
          ,le.populated_admin_zip_code4_cnt
          ,le.populated_closing_reason_cnt
          ,le.populated_closing_date_cnt
          ,le.populated_penalty_amount_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_dart_id_pcnt
          ,le.populated_date_added_pcnt
          ,le.populated_date_updated_pcnt
          ,le.populated_website_pcnt
          ,le.populated_state_pcnt
          ,le.populated_casetype_pcnt
          ,le.populated_plan_ein_pcnt
          ,le.populated_plan_no_pcnt
          ,le.populated_plan_year_pcnt
          ,le.populated_plan_name_pcnt
          ,le.populated_plan_administrator_pcnt
          ,le.populated_admin_state_pcnt
          ,le.populated_admin_zip_code_pcnt
          ,le.populated_admin_zip_code4_pcnt
          ,le.populated_closing_reason_pcnt
          ,le.populated_closing_date_pcnt
          ,le.populated_penalty_amount_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,17,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_LaborActions_EBSA));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),17,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_LaborActions_EBSA) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_LaborActions_EBSA, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
