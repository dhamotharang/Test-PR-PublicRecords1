IMPORT SALT311,STD;
IMPORT Scrubs; // Import modules for FieldTypes attribute definitions
EXPORT charge_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(charge_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 caseid_Invalid;
    UNSIGNED1 arrestdate_Invalid;
    UNSIGNED1 bookingdate_Invalid;
    UNSIGNED1 custodydate_Invalid;
    UNSIGNED1 initialchargedate_Invalid;
    UNSIGNED1 chargedisposeddate_Invalid;
    UNSIGNED1 amendedchargedate_Invalid;
    UNSIGNED1 sourceid_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(charge_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(charge_Layout_crim)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'recordid:Invalid_Record_ID:ALLOW'
          ,'statecode:Invalid_State:ALLOW'
          ,'caseid:Invalid_Case_ID:ALLOW'
          ,'arrestdate:Invalid_Current_Date:CUSTOM'
          ,'bookingdate:Invalid_Future_Date:CUSTOM'
          ,'custodydate:Invalid_Current_Date:CUSTOM'
          ,'initialchargedate:Invalid_Current_Date:CUSTOM'
          ,'chargedisposeddate:Invalid_Future_Date:CUSTOM'
          ,'amendedchargedate:Invalid_Current_Date:CUSTOM'
          ,'sourceid:Invalid_Source_ID:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,charge_Fields.InvalidMessage_recordid(1)
          ,charge_Fields.InvalidMessage_statecode(1)
          ,charge_Fields.InvalidMessage_caseid(1)
          ,charge_Fields.InvalidMessage_arrestdate(1)
          ,charge_Fields.InvalidMessage_bookingdate(1)
          ,charge_Fields.InvalidMessage_custodydate(1)
          ,charge_Fields.InvalidMessage_initialchargedate(1)
          ,charge_Fields.InvalidMessage_chargedisposeddate(1)
          ,charge_Fields.InvalidMessage_amendedchargedate(1)
          ,charge_Fields.InvalidMessage_sourceid(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(charge_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := charge_Fields.InValid_recordid((SALT311.StrType)le.recordid);
    SELF.statecode_Invalid := charge_Fields.InValid_statecode((SALT311.StrType)le.statecode);
    SELF.caseid_Invalid := charge_Fields.InValid_caseid((SALT311.StrType)le.caseid);
    SELF.arrestdate_Invalid := charge_Fields.InValid_arrestdate((SALT311.StrType)le.arrestdate);
    SELF.bookingdate_Invalid := charge_Fields.InValid_bookingdate((SALT311.StrType)le.bookingdate);
    SELF.custodydate_Invalid := charge_Fields.InValid_custodydate((SALT311.StrType)le.custodydate);
    SELF.initialchargedate_Invalid := charge_Fields.InValid_initialchargedate((SALT311.StrType)le.initialchargedate);
    SELF.chargedisposeddate_Invalid := charge_Fields.InValid_chargedisposeddate((SALT311.StrType)le.chargedisposeddate);
    SELF.amendedchargedate_Invalid := charge_Fields.InValid_amendedchargedate((SALT311.StrType)le.amendedchargedate);
    SELF.sourceid_Invalid := charge_Fields.InValid_sourceid((SALT311.StrType)le.sourceid);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),charge_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.caseid_Invalid << 2 ) + ( le.arrestdate_Invalid << 3 ) + ( le.bookingdate_Invalid << 4 ) + ( le.custodydate_Invalid << 5 ) + ( le.initialchargedate_Invalid << 6 ) + ( le.chargedisposeddate_Invalid << 7 ) + ( le.amendedchargedate_Invalid << 8 ) + ( le.sourceid_Invalid << 9 );
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
  EXPORT Infile := PROJECT(h,charge_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.caseid_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.arrestdate_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.bookingdate_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.custodydate_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.initialchargedate_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.chargedisposeddate_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.amendedchargedate_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.sourceid_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h, BOOLEAN Glob = FALSE) := MODULE
  r := RECORD
    TYPEOF(h.vendor) vendor := IF(Glob, '', h.vendor);
    TotalCnt := COUNT(GROUP); // Number of records in total
    recordid_ALLOW_ErrorCount := COUNT(GROUP,h.recordid_Invalid=1);
    statecode_ALLOW_ErrorCount := COUNT(GROUP,h.statecode_Invalid=1);
    caseid_ALLOW_ErrorCount := COUNT(GROUP,h.caseid_Invalid=1);
    arrestdate_CUSTOM_ErrorCount := COUNT(GROUP,h.arrestdate_Invalid=1);
    bookingdate_CUSTOM_ErrorCount := COUNT(GROUP,h.bookingdate_Invalid=1);
    custodydate_CUSTOM_ErrorCount := COUNT(GROUP,h.custodydate_Invalid=1);
    initialchargedate_CUSTOM_ErrorCount := COUNT(GROUP,h.initialchargedate_Invalid=1);
    chargedisposeddate_CUSTOM_ErrorCount := COUNT(GROUP,h.chargedisposeddate_Invalid=1);
    amendedchargedate_CUSTOM_ErrorCount := COUNT(GROUP,h.amendedchargedate_Invalid=1);
    sourceid_ALLOW_ErrorCount := COUNT(GROUP,h.sourceid_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.recordid_Invalid > 0 OR h.statecode_Invalid > 0 OR h.caseid_Invalid > 0 OR h.arrestdate_Invalid > 0 OR h.bookingdate_Invalid > 0 OR h.custodydate_Invalid > 0 OR h.initialchargedate_Invalid > 0 OR h.chargedisposeddate_Invalid > 0 OR h.amendedchargedate_Invalid > 0 OR h.sourceid_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,vendor,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.recordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.caseid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.arrestdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bookingdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.custodydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.initialchargedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chargedisposeddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amendedchargedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sourceid_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.recordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.caseid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.arrestdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.bookingdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.custodydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.initialchargedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.chargedisposeddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.amendedchargedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sourceid_ALLOW_ErrorCount > 0, 1, 0);
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
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.caseid_Invalid,le.arrestdate_Invalid,le.bookingdate_Invalid,le.custodydate_Invalid,le.initialchargedate_Invalid,le.chargedisposeddate_Invalid,le.amendedchargedate_Invalid,le.sourceid_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,charge_Fields.InvalidMessage_recordid(le.recordid_Invalid),charge_Fields.InvalidMessage_statecode(le.statecode_Invalid),charge_Fields.InvalidMessage_caseid(le.caseid_Invalid),charge_Fields.InvalidMessage_arrestdate(le.arrestdate_Invalid),charge_Fields.InvalidMessage_bookingdate(le.bookingdate_Invalid),charge_Fields.InvalidMessage_custodydate(le.custodydate_Invalid),charge_Fields.InvalidMessage_initialchargedate(le.initialchargedate_Invalid),charge_Fields.InvalidMessage_chargedisposeddate(le.chargedisposeddate_Invalid),charge_Fields.InvalidMessage_amendedchargedate(le.amendedchargedate_Invalid),charge_Fields.InvalidMessage_sourceid(le.sourceid_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.caseid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.arrestdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.bookingdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.custodydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.initialchargedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.chargedisposeddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.amendedchargedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sourceid_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','caseid','arrestdate','bookingdate','custodydate','initialchargedate','chargedisposeddate','amendedchargedate','sourceid','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_State','Invalid_Case_ID','Invalid_Current_Date','Invalid_Future_Date','Invalid_Current_Date','Invalid_Current_Date','Invalid_Future_Date','Invalid_Current_Date','Invalid_Source_ID','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.recordid,(SALT311.StrType)le.statecode,(SALT311.StrType)le.caseid,(SALT311.StrType)le.arrestdate,(SALT311.StrType)le.bookingdate,(SALT311.StrType)le.custodydate,(SALT311.StrType)le.initialchargedate,(SALT311.StrType)le.chargedisposeddate,(SALT311.StrType)le.amendedchargedate,(SALT311.StrType)le.sourceid,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(charge_Layout_crim) prevDS = DATASET([], charge_Layout_crim)):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_ALLOW_ErrorCount
          ,le.arrestdate_CUSTOM_ErrorCount
          ,le.bookingdate_CUSTOM_ErrorCount
          ,le.custodydate_CUSTOM_ErrorCount
          ,le.initialchargedate_CUSTOM_ErrorCount
          ,le.chargedisposeddate_CUSTOM_ErrorCount
          ,le.amendedchargedate_CUSTOM_ErrorCount
          ,le.sourceid_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.caseid_ALLOW_ErrorCount
          ,le.arrestdate_CUSTOM_ErrorCount
          ,le.bookingdate_CUSTOM_ErrorCount
          ,le.custodydate_CUSTOM_ErrorCount
          ,le.initialchargedate_CUSTOM_ErrorCount
          ,le.chargedisposeddate_CUSTOM_ErrorCount
          ,le.amendedchargedate_CUSTOM_ErrorCount
          ,le.sourceid_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    jGlob := JOIN(SummaryInfo,gt,LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    jSrc := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    j := IF(Glob, jGlob, jSrc);
    FieldErrorStats := IF(examples>0,j,SummaryInfo);
 
    // field population stats
    mod_hygiene := charge_hygiene(PROJECT(h, charge_Layout_crim));
    hygiene_summaryStats := mod_hygiene.Summary('', Glob);
    getFieldTypeText(infield) := FUNCTIONMACRO
      isNumField := (STRING)((TYPEOF(infield))'') = '0';
      RETURN IF(isNumField, 'nonzero', 'nonblank');
    ENDMACRO;
    SALT311.ScrubsOrbitLayout xNormHygieneStats(hygiene_summaryStats le, UNSIGNED c, STRING suffix) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := CHOOSE(c
          ,'recordid:' + getFieldTypeText(h.recordid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statecode:' + getFieldTypeText(h.statecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'caseid:' + getFieldTypeText(h.caseid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'warrantnumber:' + getFieldTypeText(h.warrantnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'warrantdate:' + getFieldTypeText(h.warrantdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'warrantdesc:' + getFieldTypeText(h.warrantdesc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'warrantissuedate:' + getFieldTypeText(h.warrantissuedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'warrantissuingagency:' + getFieldTypeText(h.warrantissuingagency) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'warrantstatus:' + getFieldTypeText(h.warrantstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'citationnumber:' + getFieldTypeText(h.citationnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bookingnumber:' + getFieldTypeText(h.bookingnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arrestdate:' + getFieldTypeText(h.arrestdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'arrestingagency:' + getFieldTypeText(h.arrestingagency) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bookingdate:' + getFieldTypeText(h.bookingdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'custodydate:' + getFieldTypeText(h.custodydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'custodylocation:' + getFieldTypeText(h.custodylocation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'initialcharge:' + getFieldTypeText(h.initialcharge) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'initialchargedate:' + getFieldTypeText(h.initialchargedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'initialchargecancelleddate:' + getFieldTypeText(h.initialchargecancelleddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chargedisposed:' + getFieldTypeText(h.chargedisposed) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chargedisposeddate:' + getFieldTypeText(h.chargedisposeddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chargeseverity:' + getFieldTypeText(h.chargeseverity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'chargedisposition:' + getFieldTypeText(h.chargedisposition) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amendedcharge:' + getFieldTypeText(h.amendedcharge) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'amendedchargedate:' + getFieldTypeText(h.amendedchargedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bondsman:' + getFieldTypeText(h.bondsman) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bondamount:' + getFieldTypeText(h.bondamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bondtype:' + getFieldTypeText(h.bondtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sourcename:' + getFieldTypeText(h.sourcename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sourceid:' + getFieldTypeText(h.sourceid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_recordid_cnt
          ,le.populated_statecode_cnt
          ,le.populated_caseid_cnt
          ,le.populated_warrantnumber_cnt
          ,le.populated_warrantdate_cnt
          ,le.populated_warrantdesc_cnt
          ,le.populated_warrantissuedate_cnt
          ,le.populated_warrantissuingagency_cnt
          ,le.populated_warrantstatus_cnt
          ,le.populated_citationnumber_cnt
          ,le.populated_bookingnumber_cnt
          ,le.populated_arrestdate_cnt
          ,le.populated_arrestingagency_cnt
          ,le.populated_bookingdate_cnt
          ,le.populated_custodydate_cnt
          ,le.populated_custodylocation_cnt
          ,le.populated_initialcharge_cnt
          ,le.populated_initialchargedate_cnt
          ,le.populated_initialchargecancelleddate_cnt
          ,le.populated_chargedisposed_cnt
          ,le.populated_chargedisposeddate_cnt
          ,le.populated_chargeseverity_cnt
          ,le.populated_chargedisposition_cnt
          ,le.populated_amendedcharge_cnt
          ,le.populated_amendedchargedate_cnt
          ,le.populated_bondsman_cnt
          ,le.populated_bondamount_cnt
          ,le.populated_bondtype_cnt
          ,le.populated_sourcename_cnt
          ,le.populated_sourceid_cnt
          ,le.populated_vendor_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_recordid_pcnt
          ,le.populated_statecode_pcnt
          ,le.populated_caseid_pcnt
          ,le.populated_warrantnumber_pcnt
          ,le.populated_warrantdate_pcnt
          ,le.populated_warrantdesc_pcnt
          ,le.populated_warrantissuedate_pcnt
          ,le.populated_warrantissuingagency_pcnt
          ,le.populated_warrantstatus_pcnt
          ,le.populated_citationnumber_pcnt
          ,le.populated_bookingnumber_pcnt
          ,le.populated_arrestdate_pcnt
          ,le.populated_arrestingagency_pcnt
          ,le.populated_bookingdate_pcnt
          ,le.populated_custodydate_pcnt
          ,le.populated_custodylocation_pcnt
          ,le.populated_initialcharge_pcnt
          ,le.populated_initialchargedate_pcnt
          ,le.populated_initialchargecancelleddate_pcnt
          ,le.populated_chargedisposed_pcnt
          ,le.populated_chargedisposeddate_pcnt
          ,le.populated_chargeseverity_pcnt
          ,le.populated_chargedisposition_pcnt
          ,le.populated_amendedcharge_pcnt
          ,le.populated_amendedchargedate_pcnt
          ,le.populated_bondsman_pcnt
          ,le.populated_bondamount_pcnt
          ,le.populated_bondtype_pcnt
          ,le.populated_sourcename_pcnt
          ,le.populated_sourceid_pcnt
          ,le.populated_vendor_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,31,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
  // record count stats
    SALT311.ScrubsOrbitLayout xTotalRecs(hygiene_summaryStats le, STRING inRuleDesc) := TRANSFORM
      SELF.recordstotal := le.NumberOfRecords;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.Source;
      SELF.ruledesc := inRuleDesc;
      SELF.ErrorMessage := '';
      SELF.rulecnt := le.NumberOfRecords;
      SELF.rulepcnt := 0;
    END;
    TotalRecsStats := PROJECT(hygiene_summaryStats, xTotalRecs(LEFT, 'records:total_records:POP'));
 
    mod_Delta := charge_Delta(prevDS, PROJECT(h, charge_Layout_crim));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),31,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(charge_Layout_crim) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Crim, charge_Fields, 'RECORDOF(scrubsSummaryOverall)', 'vendor');
  scrubsSummaryPerSource_Standard := NORMALIZE(scrubsSummaryPerSource, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard := NORMALIZE(scrubsSummaryOverall, (NumRulesFromFieldType + NumFieldsWithRules) * 4, xSummaryStats(LEFT, COUNTER, myTimeStamp, 'all', 'all'));
 
  allErrsPerSource := mod_fromexpandedPerSource.AllErrors;
  tErrsPerSource := TABLE(DISTRIBUTE(allErrsPerSource, HASH(src, FieldName, ErrorType)), {src, FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, src, FieldName, ErrorType, FieldContents, LOCAL);
  allErrsOverall := mod_fromexpandedOverall.AllErrors;
  tErrsOverall := TABLE(DISTRIBUTE(allErrsOverall, HASH(FieldName, ErrorType)), {FieldName, ErrorType, FieldContents, cntExamples := COUNT(GROUP)}, FieldName, ErrorType, FieldContents, LOCAL);
 
  scrubsSummaryPerSource_Standard_addErr := IF(doErrorPerSrc,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryPerSource_Standard, HASH(source, field, ruletype)), source, field, ruletype, LOCAL),
  	                                                       SORT(tErrsPerSource, src, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.source = RIGHT.src AND LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryOverall_Standard_addErr   := IF(doErrorOverall,
                                               DENORMALIZE(SORT(DISTRIBUTE(scrubsSummaryOverall_Standard, HASH(field, ruletype)), field, ruletype, LOCAL),
  	                                                       SORT(tErrsOverall, FieldName, ErrorType, -cntExamples, FieldContents, LOCAL),
  	                                                       LEFT.field = RIGHT.FieldName AND LEFT.ruletype = RIGHT.ErrorType AND LEFT.MeasureType = 'CntRecs',
  	                                                       TRANSFORM(RECORDOF(LEFT),
  	                                                       SELF.dsExamples := LEFT.dsExamples & DATASET([{RIGHT.FieldContents, RIGHT.cntExamples, IF(LEFT.StatValue > 0, RIGHT.cntExamples/LEFT.StatValue * 100, 0)}], SALT311.Layout_Stats_Standard.Examples);
  	                                                       SELF := LEFT),
  	                                                       KEEP(10), LEFT OUTER, LOCAL, NOSORT));
  scrubsSummaryPerSource_Standard_GeneralErrs := IF(doErrorPerSrc, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryPerSource, vendor, myTimeStamp, 'src', 'src'));
  scrubsSummaryOverall_Standard_GeneralErrs := IF(doErrorOverall, SALT311.mod_StandardStatsTransforms.scrubsSummaryStatsGeneral(scrubsSummaryOverall,, myTimeStamp, 'all', 'all'));
 
  RETURN scrubsSummaryPerSource_Standard_addErr & scrubsSummaryPerSource_Standard_GeneralErrs & scrubsSummaryOverall_Standard_addErr & scrubsSummaryOverall_Standard_GeneralErrs;
END;
END;
