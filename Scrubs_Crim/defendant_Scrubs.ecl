IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT defendant_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 14;
  EXPORT NumRulesFromFieldType := 14;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 14;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(defendant_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 inmatenumber_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 birthcity_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 race_Invalid;
    UNSIGNED1 dlstate_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 institutionreceiptdate_Invalid;
    UNSIGNED1 deceaseddate_Invalid;
    UNSIGNED1 sexoffenderregistrydate_Invalid;
    UNSIGNED1 sexoffenderregexpirationdate_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(defendant_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(defendant_Layout_crim)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'recordid:Invalid_Record_ID:ALLOW'
          ,'statecode:Invalid_State:ALLOW'
          ,'inmatenumber:Invalid_Inmate_Num:ALLOW'
          ,'dob:Invalid_Current_Date:CUSTOM'
          ,'birthcity:Invalid_City:ALLOW'
          ,'gender:Invalid_Gender:ENUM'
          ,'race:Invalid_Race:CUSTOM'
          ,'dlstate:Invalid_State:ALLOW'
          ,'city:Invalid_City:ALLOW'
          ,'orig_zip:Invalid_Zip:ALLOW'
          ,'institutionreceiptdate:Invalid_Current_Date:CUSTOM'
          ,'deceaseddate:Invalid_Future_Date:CUSTOM'
          ,'sexoffenderregistrydate:Invalid_Current_Date:CUSTOM'
          ,'sexoffenderregexpirationdate:Invalid_Future_Date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,defendant_Fields.InvalidMessage_recordid(1)
          ,defendant_Fields.InvalidMessage_statecode(1)
          ,defendant_Fields.InvalidMessage_inmatenumber(1)
          ,defendant_Fields.InvalidMessage_dob(1)
          ,defendant_Fields.InvalidMessage_birthcity(1)
          ,defendant_Fields.InvalidMessage_gender(1)
          ,defendant_Fields.InvalidMessage_race(1)
          ,defendant_Fields.InvalidMessage_dlstate(1)
          ,defendant_Fields.InvalidMessage_city(1)
          ,defendant_Fields.InvalidMessage_orig_zip(1)
          ,defendant_Fields.InvalidMessage_institutionreceiptdate(1)
          ,defendant_Fields.InvalidMessage_deceaseddate(1)
          ,defendant_Fields.InvalidMessage_sexoffenderregistrydate(1)
          ,defendant_Fields.InvalidMessage_sexoffenderregexpirationdate(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(defendant_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := defendant_Fields.InValid_recordid((SALT311.StrType)le.recordid);
    SELF.statecode_Invalid := defendant_Fields.InValid_statecode((SALT311.StrType)le.statecode);
    SELF.inmatenumber_Invalid := defendant_Fields.InValid_inmatenumber((SALT311.StrType)le.inmatenumber);
    SELF.dob_Invalid := defendant_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.birthcity_Invalid := defendant_Fields.InValid_birthcity((SALT311.StrType)le.birthcity);
    SELF.gender_Invalid := defendant_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.race_Invalid := defendant_Fields.InValid_race((SALT311.StrType)le.race);
    SELF.dlstate_Invalid := defendant_Fields.InValid_dlstate((SALT311.StrType)le.dlstate);
    SELF.city_Invalid := defendant_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.orig_zip_Invalid := defendant_Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip);
    SELF.institutionreceiptdate_Invalid := defendant_Fields.InValid_institutionreceiptdate((SALT311.StrType)le.institutionreceiptdate);
    SELF.deceaseddate_Invalid := defendant_Fields.InValid_deceaseddate((SALT311.StrType)le.deceaseddate);
    SELF.sexoffenderregistrydate_Invalid := defendant_Fields.InValid_sexoffenderregistrydate((SALT311.StrType)le.sexoffenderregistrydate);
    SELF.sexoffenderregexpirationdate_Invalid := defendant_Fields.InValid_sexoffenderregexpirationdate((SALT311.StrType)le.sexoffenderregexpirationdate);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),defendant_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.inmatenumber_Invalid << 2 ) + ( le.dob_Invalid << 3 ) + ( le.birthcity_Invalid << 4 ) + ( le.gender_Invalid << 5 ) + ( le.race_Invalid << 6 ) + ( le.dlstate_Invalid << 7 ) + ( le.city_Invalid << 8 ) + ( le.orig_zip_Invalid << 9 ) + ( le.institutionreceiptdate_Invalid << 10 ) + ( le.deceaseddate_Invalid << 11 ) + ( le.sexoffenderregistrydate_Invalid << 12 ) + ( le.sexoffenderregexpirationdate_Invalid << 13 );
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
  EXPORT Infile := PROJECT(h,defendant_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.inmatenumber_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.birthcity_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.race_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.dlstate_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.institutionreceiptdate_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.deceaseddate_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.sexoffenderregistrydate_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.sexoffenderregexpirationdate_Invalid := (le.ScrubsBits1 >> 13) & 1;
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
    inmatenumber_ALLOW_ErrorCount := COUNT(GROUP,h.inmatenumber_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    birthcity_ALLOW_ErrorCount := COUNT(GROUP,h.birthcity_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    race_CUSTOM_ErrorCount := COUNT(GROUP,h.race_Invalid=1);
    dlstate_ALLOW_ErrorCount := COUNT(GROUP,h.dlstate_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    institutionreceiptdate_CUSTOM_ErrorCount := COUNT(GROUP,h.institutionreceiptdate_Invalid=1);
    deceaseddate_CUSTOM_ErrorCount := COUNT(GROUP,h.deceaseddate_Invalid=1);
    sexoffenderregistrydate_CUSTOM_ErrorCount := COUNT(GROUP,h.sexoffenderregistrydate_Invalid=1);
    sexoffenderregexpirationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.sexoffenderregexpirationdate_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.recordid_Invalid > 0 OR h.statecode_Invalid > 0 OR h.inmatenumber_Invalid > 0 OR h.dob_Invalid > 0 OR h.birthcity_Invalid > 0 OR h.gender_Invalid > 0 OR h.race_Invalid > 0 OR h.dlstate_Invalid > 0 OR h.city_Invalid > 0 OR h.orig_zip_Invalid > 0 OR h.institutionreceiptdate_Invalid > 0 OR h.deceaseddate_Invalid > 0 OR h.sexoffenderregistrydate_Invalid > 0 OR h.sexoffenderregexpirationdate_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := IF(Glob, TABLE(h,r), TABLE(h,r,vendor,FEW));
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.recordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inmatenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.birthcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.race_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dlstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.institutionreceiptdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deceaseddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sexoffenderregistrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sexoffenderregexpirationdate_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.recordid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.statecode_ALLOW_ErrorCount > 0, 1, 0) + IF(le.inmatenumber_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.birthcity_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.race_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.dlstate_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.institutionreceiptdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.deceaseddate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sexoffenderregistrydate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sexoffenderregexpirationdate_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.inmatenumber_Invalid,le.dob_Invalid,le.birthcity_Invalid,le.gender_Invalid,le.race_Invalid,le.dlstate_Invalid,le.city_Invalid,le.orig_zip_Invalid,le.institutionreceiptdate_Invalid,le.deceaseddate_Invalid,le.sexoffenderregistrydate_Invalid,le.sexoffenderregexpirationdate_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,defendant_Fields.InvalidMessage_recordid(le.recordid_Invalid),defendant_Fields.InvalidMessage_statecode(le.statecode_Invalid),defendant_Fields.InvalidMessage_inmatenumber(le.inmatenumber_Invalid),defendant_Fields.InvalidMessage_dob(le.dob_Invalid),defendant_Fields.InvalidMessage_birthcity(le.birthcity_Invalid),defendant_Fields.InvalidMessage_gender(le.gender_Invalid),defendant_Fields.InvalidMessage_race(le.race_Invalid),defendant_Fields.InvalidMessage_dlstate(le.dlstate_Invalid),defendant_Fields.InvalidMessage_city(le.city_Invalid),defendant_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),defendant_Fields.InvalidMessage_institutionreceiptdate(le.institutionreceiptdate_Invalid),defendant_Fields.InvalidMessage_deceaseddate(le.deceaseddate_Invalid),defendant_Fields.InvalidMessage_sexoffenderregistrydate(le.sexoffenderregistrydate_Invalid),defendant_Fields.InvalidMessage_sexoffenderregexpirationdate(le.sexoffenderregexpirationdate_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inmatenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.birthcity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.race_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dlstate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.institutionreceiptdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deceaseddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sexoffenderregistrydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sexoffenderregexpirationdate_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','inmatenumber','dob','birthcity','gender','race','dlstate','city','orig_zip','institutionreceiptdate','deceaseddate','sexoffenderregistrydate','sexoffenderregexpirationdate','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_State','Invalid_Inmate_Num','Invalid_Current_Date','Invalid_City','Invalid_Gender','Invalid_Race','Invalid_State','Invalid_City','Invalid_Zip','Invalid_Current_Date','Invalid_Future_Date','Invalid_Current_Date','Invalid_Future_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.recordid,(SALT311.StrType)le.statecode,(SALT311.StrType)le.inmatenumber,(SALT311.StrType)le.dob,(SALT311.StrType)le.birthcity,(SALT311.StrType)le.gender,(SALT311.StrType)le.race,(SALT311.StrType)le.dlstate,(SALT311.StrType)le.city,(SALT311.StrType)le.orig_zip,(SALT311.StrType)le.institutionreceiptdate,(SALT311.StrType)le.deceaseddate,(SALT311.StrType)le.sexoffenderregistrydate,(SALT311.StrType)le.sexoffenderregexpirationdate,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,14,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(defendant_Layout_crim) prevDS = DATASET([], defendant_Layout_crim)):= FUNCTION
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
          ,le.inmatenumber_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.birthcity_ALLOW_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.race_CUSTOM_ErrorCount
          ,le.dlstate_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount
          ,le.institutionreceiptdate_CUSTOM_ErrorCount
          ,le.deceaseddate_CUSTOM_ErrorCount
          ,le.sexoffenderregistrydate_CUSTOM_ErrorCount
          ,le.sexoffenderregexpirationdate_CUSTOM_ErrorCount
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
          ,le.inmatenumber_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.birthcity_ALLOW_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.race_CUSTOM_ErrorCount
          ,le.dlstate_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount
          ,le.institutionreceiptdate_CUSTOM_ErrorCount
          ,le.deceaseddate_CUSTOM_ErrorCount
          ,le.sexoffenderregistrydate_CUSTOM_ErrorCount
          ,le.sexoffenderregexpirationdate_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := defendant_hygiene(PROJECT(h, defendant_Layout_crim));
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
          ,'sourcename:' + getFieldTypeText(h.sourcename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sourcetype:' + getFieldTypeText(h.sourcetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'statecode:' + getFieldTypeText(h.statecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recordtype:' + getFieldTypeText(h.recordtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recorduploaddate:' + getFieldTypeText(h.recorduploaddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'docnumber:' + getFieldTypeText(h.docnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fbinumber:' + getFieldTypeText(h.fbinumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'stateidnumber:' + getFieldTypeText(h.stateidnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'inmatenumber:' + getFieldTypeText(h.inmatenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'aliennumber:' + getFieldTypeText(h.aliennumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ssn:' + getFieldTypeText(h.orig_ssn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'nametype:' + getFieldTypeText(h.nametype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name:' + getFieldTypeText(h.name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastname:' + getFieldTypeText(h.lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firstname:' + getFieldTypeText(h.firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middlename:' + getFieldTypeText(h.middlename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'defendantstatus:' + getFieldTypeText(h.defendantstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'defendantadditionalinfo:' + getFieldTypeText(h.defendantadditionalinfo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'birthcity:' + getFieldTypeText(h.birthcity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'birthplace:' + getFieldTypeText(h.birthplace) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'age:' + getFieldTypeText(h.age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'height:' + getFieldTypeText(h.height) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'weight:' + getFieldTypeText(h.weight) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'haircolor:' + getFieldTypeText(h.haircolor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eyecolor:' + getFieldTypeText(h.eyecolor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'race:' + getFieldTypeText(h.race) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ethnicity:' + getFieldTypeText(h.ethnicity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'skincolor:' + getFieldTypeText(h.skincolor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bodymarks:' + getFieldTypeText(h.bodymarks) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'physicalbuild:' + getFieldTypeText(h.physicalbuild) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'photoname:' + getFieldTypeText(h.photoname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dlnumber:' + getFieldTypeText(h.dlnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dlstate:' + getFieldTypeText(h.dlstate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phonetype:' + getFieldTypeText(h.phonetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'uscitizenflag:' + getFieldTypeText(h.uscitizenflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'addresstype:' + getFieldTypeText(h.addresstype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street:' + getFieldTypeText(h.street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'unit:' + getFieldTypeText(h.unit) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county:' + getFieldTypeText(h.county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'institutionname:' + getFieldTypeText(h.institutionname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'institutiondetails:' + getFieldTypeText(h.institutiondetails) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'institutionreceiptdate:' + getFieldTypeText(h.institutionreceiptdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'releasetolocation:' + getFieldTypeText(h.releasetolocation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'releasetodetails:' + getFieldTypeText(h.releasetodetails) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deceasedflag:' + getFieldTypeText(h.deceasedflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'deceaseddate:' + getFieldTypeText(h.deceaseddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'healthflag:' + getFieldTypeText(h.healthflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'healthdesc:' + getFieldTypeText(h.healthdesc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'bloodtype:' + getFieldTypeText(h.bloodtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sexoffenderregistrydate:' + getFieldTypeText(h.sexoffenderregistrydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sexoffenderregexpirationdate:' + getFieldTypeText(h.sexoffenderregexpirationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sexoffenderregistrynumber:' + getFieldTypeText(h.sexoffenderregistrynumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sourceid:' + getFieldTypeText(h.sourceid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'vendor:' + getFieldTypeText(h.vendor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_recordid_cnt
          ,le.populated_sourcename_cnt
          ,le.populated_sourcetype_cnt
          ,le.populated_statecode_cnt
          ,le.populated_recordtype_cnt
          ,le.populated_recorduploaddate_cnt
          ,le.populated_docnumber_cnt
          ,le.populated_fbinumber_cnt
          ,le.populated_stateidnumber_cnt
          ,le.populated_inmatenumber_cnt
          ,le.populated_aliennumber_cnt
          ,le.populated_orig_ssn_cnt
          ,le.populated_nametype_cnt
          ,le.populated_name_cnt
          ,le.populated_lastname_cnt
          ,le.populated_firstname_cnt
          ,le.populated_middlename_cnt
          ,le.populated_suffix_cnt
          ,le.populated_defendantstatus_cnt
          ,le.populated_defendantadditionalinfo_cnt
          ,le.populated_dob_cnt
          ,le.populated_birthcity_cnt
          ,le.populated_birthplace_cnt
          ,le.populated_age_cnt
          ,le.populated_gender_cnt
          ,le.populated_height_cnt
          ,le.populated_weight_cnt
          ,le.populated_haircolor_cnt
          ,le.populated_eyecolor_cnt
          ,le.populated_race_cnt
          ,le.populated_ethnicity_cnt
          ,le.populated_skincolor_cnt
          ,le.populated_bodymarks_cnt
          ,le.populated_physicalbuild_cnt
          ,le.populated_photoname_cnt
          ,le.populated_dlnumber_cnt
          ,le.populated_dlstate_cnt
          ,le.populated_phone_cnt
          ,le.populated_phonetype_cnt
          ,le.populated_uscitizenflag_cnt
          ,le.populated_addresstype_cnt
          ,le.populated_street_cnt
          ,le.populated_unit_cnt
          ,le.populated_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_county_cnt
          ,le.populated_institutionname_cnt
          ,le.populated_institutiondetails_cnt
          ,le.populated_institutionreceiptdate_cnt
          ,le.populated_releasetolocation_cnt
          ,le.populated_releasetodetails_cnt
          ,le.populated_deceasedflag_cnt
          ,le.populated_deceaseddate_cnt
          ,le.populated_healthflag_cnt
          ,le.populated_healthdesc_cnt
          ,le.populated_bloodtype_cnt
          ,le.populated_sexoffenderregistrydate_cnt
          ,le.populated_sexoffenderregexpirationdate_cnt
          ,le.populated_sexoffenderregistrynumber_cnt
          ,le.populated_sourceid_cnt
          ,le.populated_vendor_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_recordid_pcnt
          ,le.populated_sourcename_pcnt
          ,le.populated_sourcetype_pcnt
          ,le.populated_statecode_pcnt
          ,le.populated_recordtype_pcnt
          ,le.populated_recorduploaddate_pcnt
          ,le.populated_docnumber_pcnt
          ,le.populated_fbinumber_pcnt
          ,le.populated_stateidnumber_pcnt
          ,le.populated_inmatenumber_pcnt
          ,le.populated_aliennumber_pcnt
          ,le.populated_orig_ssn_pcnt
          ,le.populated_nametype_pcnt
          ,le.populated_name_pcnt
          ,le.populated_lastname_pcnt
          ,le.populated_firstname_pcnt
          ,le.populated_middlename_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_defendantstatus_pcnt
          ,le.populated_defendantadditionalinfo_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_birthcity_pcnt
          ,le.populated_birthplace_pcnt
          ,le.populated_age_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_height_pcnt
          ,le.populated_weight_pcnt
          ,le.populated_haircolor_pcnt
          ,le.populated_eyecolor_pcnt
          ,le.populated_race_pcnt
          ,le.populated_ethnicity_pcnt
          ,le.populated_skincolor_pcnt
          ,le.populated_bodymarks_pcnt
          ,le.populated_physicalbuild_pcnt
          ,le.populated_photoname_pcnt
          ,le.populated_dlnumber_pcnt
          ,le.populated_dlstate_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_phonetype_pcnt
          ,le.populated_uscitizenflag_pcnt
          ,le.populated_addresstype_pcnt
          ,le.populated_street_pcnt
          ,le.populated_unit_pcnt
          ,le.populated_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_county_pcnt
          ,le.populated_institutionname_pcnt
          ,le.populated_institutiondetails_pcnt
          ,le.populated_institutionreceiptdate_pcnt
          ,le.populated_releasetolocation_pcnt
          ,le.populated_releasetodetails_pcnt
          ,le.populated_deceasedflag_pcnt
          ,le.populated_deceaseddate_pcnt
          ,le.populated_healthflag_pcnt
          ,le.populated_healthdesc_pcnt
          ,le.populated_bloodtype_pcnt
          ,le.populated_sexoffenderregistrydate_pcnt
          ,le.populated_sexoffenderregexpirationdate_pcnt
          ,le.populated_sexoffenderregistrynumber_pcnt
          ,le.populated_sourceid_pcnt
          ,le.populated_vendor_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,62,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := defendant_Delta(prevDS, PROJECT(h, defendant_Layout_crim));
    deltaHygieneSummary := mod_Delta.DifferenceSummary(Glob);
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),62,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(defendant_Layout_crim) inFile, BOOLEAN doErrorOverall = TRUE, BOOLEAN doErrorPerSrc = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedPerSource := FromExpanded(expandedFile, FALSE);
  mod_fromexpandedOverall := FromExpanded(expandedFile, TRUE);
  scrubsSummaryPerSource := mod_fromexpandedPerSource.SummaryStats;
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_Crim, defendant_Fields, 'RECORDOF(scrubsSummaryOverall)', 'vendor');
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
