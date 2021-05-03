IMPORT SALT311,STD;
IMPORT Scrubs_SAM; // Import modules for FieldTypes attribute definitions
EXPORT Input_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 18;
  EXPORT NumRulesFromFieldType := 18;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 18;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Input_Layout_SAM)
    UNSIGNED1 classification_Invalid;
    UNSIGNED1 name_Invalid;
    UNSIGNED1 firstname_Invalid;
    UNSIGNED1 middlename_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 address_2_Invalid;
    UNSIGNED1 address_3_Invalid;
    UNSIGNED1 address_4_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 country_Invalid;
    UNSIGNED1 zipcode_Invalid;
    UNSIGNED1 exclusionprogram_Invalid;
    UNSIGNED1 excludingagency_Invalid;
    UNSIGNED1 exclusiontype_Invalid;
    UNSIGNED1 activedate_Invalid;
    UNSIGNED1 terminationdate_Invalid;
    UNSIGNED1 samnumber_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Input_Layout_SAM)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Input_Layout_SAM)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'classification:invalid_mandatory:CUSTOM'
          ,'name:invalid_name:CUSTOM'
          ,'firstname:invalid_firstname:CUSTOM'
          ,'middlename:invalid_middlename:CUSTOM'
          ,'lastname:invalid_lastname:CUSTOM'
          ,'address_2:invalid_address_2:CUSTOM'
          ,'address_3:invalid_address_3:CUSTOM'
          ,'address_4:invalid_address_4:CUSTOM'
          ,'city:invalid_city:CUSTOM'
          ,'state:invalid_state:CUSTOM'
          ,'country:invalid_country:CUSTOM'
          ,'zipcode:invalid_zipcode:CUSTOM'
          ,'exclusionprogram:invalid_exclusionprogram:CUSTOM'
          ,'excludingagency:invalid_mandatory:CUSTOM'
          ,'exclusiontype:invalid_exclusiontype:CUSTOM'
          ,'activedate:invalid_activedate:CUSTOM'
          ,'terminationdate:invalid_terminationdate:CUSTOM'
          ,'samnumber:invalid_samnumber:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Input_Fields.InvalidMessage_classification(1)
          ,Input_Fields.InvalidMessage_name(1)
          ,Input_Fields.InvalidMessage_firstname(1)
          ,Input_Fields.InvalidMessage_middlename(1)
          ,Input_Fields.InvalidMessage_lastname(1)
          ,Input_Fields.InvalidMessage_address_2(1)
          ,Input_Fields.InvalidMessage_address_3(1)
          ,Input_Fields.InvalidMessage_address_4(1)
          ,Input_Fields.InvalidMessage_city(1)
          ,Input_Fields.InvalidMessage_state(1)
          ,Input_Fields.InvalidMessage_country(1)
          ,Input_Fields.InvalidMessage_zipcode(1)
          ,Input_Fields.InvalidMessage_exclusionprogram(1)
          ,Input_Fields.InvalidMessage_excludingagency(1)
          ,Input_Fields.InvalidMessage_exclusiontype(1)
          ,Input_Fields.InvalidMessage_activedate(1)
          ,Input_Fields.InvalidMessage_terminationdate(1)
          ,Input_Fields.InvalidMessage_samnumber(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Input_Layout_SAM) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.classification_Invalid := Input_Fields.InValid_classification((SALT311.StrType)le.classification);
    SELF.name_Invalid := Input_Fields.InValid_name((SALT311.StrType)le.name,(SALT311.StrType)le.firstname,(SALT311.StrType)le.lastname);
    SELF.firstname_Invalid := Input_Fields.InValid_firstname((SALT311.StrType)le.firstname,(SALT311.StrType)le.name,(SALT311.StrType)le.lastname);
    SELF.middlename_Invalid := Input_Fields.InValid_middlename((SALT311.StrType)le.middlename,(SALT311.StrType)le.name,(SALT311.StrType)le.firstname,(SALT311.StrType)le.lastname);
    SELF.lastname_Invalid := Input_Fields.InValid_lastname((SALT311.StrType)le.lastname,(SALT311.StrType)le.name,(SALT311.StrType)le.lastname);
    SELF.address_2_Invalid := Input_Fields.InValid_address_2((SALT311.StrType)le.address_2,(SALT311.StrType)le.address_1);
    SELF.address_3_Invalid := Input_Fields.InValid_address_3((SALT311.StrType)le.address_3,(SALT311.StrType)le.address_1,(SALT311.StrType)le.address_2);
    SELF.address_4_Invalid := Input_Fields.InValid_address_4((SALT311.StrType)le.address_4,(SALT311.StrType)le.address_1,(SALT311.StrType)le.address_2,(SALT311.StrType)le.address_3);
    SELF.city_Invalid := Input_Fields.InValid_city((SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.country,(SALT311.StrType)le.zipcode);
    SELF.state_Invalid := Input_Fields.InValid_state((SALT311.StrType)le.state,(SALT311.StrType)le.country);
    SELF.country_Invalid := Input_Fields.InValid_country((SALT311.StrType)le.country);
    SELF.zipcode_Invalid := Input_Fields.InValid_zipcode((SALT311.StrType)le.zipcode);
    SELF.exclusionprogram_Invalid := Input_Fields.InValid_exclusionprogram((SALT311.StrType)le.exclusionprogram);
    SELF.excludingagency_Invalid := Input_Fields.InValid_excludingagency((SALT311.StrType)le.excludingagency);
    SELF.exclusiontype_Invalid := Input_Fields.InValid_exclusiontype((SALT311.StrType)le.exclusiontype);
    SELF.activedate_Invalid := Input_Fields.InValid_activedate((SALT311.StrType)le.activedate);
    SELF.terminationdate_Invalid := Input_Fields.InValid_terminationdate((SALT311.StrType)le.terminationdate);
    SELF.samnumber_Invalid := Input_Fields.InValid_samnumber((SALT311.StrType)le.samnumber);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Input_Layout_SAM);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.classification_Invalid << 0 ) + ( le.name_Invalid << 1 ) + ( le.firstname_Invalid << 2 ) + ( le.middlename_Invalid << 3 ) + ( le.lastname_Invalid << 4 ) + ( le.address_2_Invalid << 5 ) + ( le.address_3_Invalid << 6 ) + ( le.address_4_Invalid << 7 ) + ( le.city_Invalid << 8 ) + ( le.state_Invalid << 9 ) + ( le.country_Invalid << 10 ) + ( le.zipcode_Invalid << 11 ) + ( le.exclusionprogram_Invalid << 12 ) + ( le.excludingagency_Invalid << 13 ) + ( le.exclusiontype_Invalid << 14 ) + ( le.activedate_Invalid << 15 ) + ( le.terminationdate_Invalid << 16 ) + ( le.samnumber_Invalid << 17 );
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
  EXPORT Infile := PROJECT(h,Input_Layout_SAM);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.classification_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.name_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.firstname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.middlename_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.address_2_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.address_3_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.address_4_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.country_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.zipcode_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.exclusionprogram_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.excludingagency_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.exclusiontype_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.activedate_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.terminationdate_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.samnumber_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    classification_CUSTOM_ErrorCount := COUNT(GROUP,h.classification_Invalid=1);
    name_CUSTOM_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    firstname_CUSTOM_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
    middlename_CUSTOM_ErrorCount := COUNT(GROUP,h.middlename_Invalid=1);
    lastname_CUSTOM_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    address_2_CUSTOM_ErrorCount := COUNT(GROUP,h.address_2_Invalid=1);
    address_3_CUSTOM_ErrorCount := COUNT(GROUP,h.address_3_Invalid=1);
    address_4_CUSTOM_ErrorCount := COUNT(GROUP,h.address_4_Invalid=1);
    city_CUSTOM_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    country_CUSTOM_ErrorCount := COUNT(GROUP,h.country_Invalid=1);
    zipcode_CUSTOM_ErrorCount := COUNT(GROUP,h.zipcode_Invalid=1);
    exclusionprogram_CUSTOM_ErrorCount := COUNT(GROUP,h.exclusionprogram_Invalid=1);
    excludingagency_CUSTOM_ErrorCount := COUNT(GROUP,h.excludingagency_Invalid=1);
    exclusiontype_CUSTOM_ErrorCount := COUNT(GROUP,h.exclusiontype_Invalid=1);
    activedate_CUSTOM_ErrorCount := COUNT(GROUP,h.activedate_Invalid=1);
    terminationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.terminationdate_Invalid=1);
    samnumber_CUSTOM_ErrorCount := COUNT(GROUP,h.samnumber_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.classification_Invalid > 0 OR h.name_Invalid > 0 OR h.firstname_Invalid > 0 OR h.middlename_Invalid > 0 OR h.lastname_Invalid > 0 OR h.address_2_Invalid > 0 OR h.address_3_Invalid > 0 OR h.address_4_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.country_Invalid > 0 OR h.zipcode_Invalid > 0 OR h.exclusionprogram_Invalid > 0 OR h.excludingagency_Invalid > 0 OR h.exclusiontype_Invalid > 0 OR h.activedate_Invalid > 0 OR h.terminationdate_Invalid > 0 OR h.samnumber_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.classification_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.firstname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.middlename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.country_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exclusionprogram_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.excludingagency_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exclusiontype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.activedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.terminationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.samnumber_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.classification_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.firstname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.middlename_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.lastname_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_2_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_3_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.address_4_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.city_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.country_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zipcode_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exclusionprogram_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.excludingagency_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.exclusiontype_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.activedate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.terminationdate_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.samnumber_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.classification_Invalid,le.name_Invalid,le.firstname_Invalid,le.middlename_Invalid,le.lastname_Invalid,le.address_2_Invalid,le.address_3_Invalid,le.address_4_Invalid,le.city_Invalid,le.state_Invalid,le.country_Invalid,le.zipcode_Invalid,le.exclusionprogram_Invalid,le.excludingagency_Invalid,le.exclusiontype_Invalid,le.activedate_Invalid,le.terminationdate_Invalid,le.samnumber_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Input_Fields.InvalidMessage_classification(le.classification_Invalid),Input_Fields.InvalidMessage_name(le.name_Invalid),Input_Fields.InvalidMessage_firstname(le.firstname_Invalid),Input_Fields.InvalidMessage_middlename(le.middlename_Invalid),Input_Fields.InvalidMessage_lastname(le.lastname_Invalid),Input_Fields.InvalidMessage_address_2(le.address_2_Invalid),Input_Fields.InvalidMessage_address_3(le.address_3_Invalid),Input_Fields.InvalidMessage_address_4(le.address_4_Invalid),Input_Fields.InvalidMessage_city(le.city_Invalid),Input_Fields.InvalidMessage_state(le.state_Invalid),Input_Fields.InvalidMessage_country(le.country_Invalid),Input_Fields.InvalidMessage_zipcode(le.zipcode_Invalid),Input_Fields.InvalidMessage_exclusionprogram(le.exclusionprogram_Invalid),Input_Fields.InvalidMessage_excludingagency(le.excludingagency_Invalid),Input_Fields.InvalidMessage_exclusiontype(le.exclusiontype_Invalid),Input_Fields.InvalidMessage_activedate(le.activedate_Invalid),Input_Fields.InvalidMessage_terminationdate(le.terminationdate_Invalid),Input_Fields.InvalidMessage_samnumber(le.samnumber_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.classification_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.firstname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.middlename_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.address_4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.country_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zipcode_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.exclusionprogram_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.excludingagency_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.exclusiontype_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.activedate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.terminationdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.samnumber_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'classification','name','firstname','middlename','lastname','address_2','address_3','address_4','city','state','country','zipcode','exclusionprogram','excludingagency','exclusiontype','activedate','terminationdate','samnumber','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_mandatory','invalid_name','invalid_firstname','invalid_middlename','invalid_lastname','invalid_address_2','invalid_address_3','invalid_address_4','invalid_city','invalid_state','invalid_country','invalid_zipcode','invalid_exclusionprogram','invalid_mandatory','invalid_exclusiontype','invalid_activedate','invalid_terminationdate','invalid_samnumber','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.classification,(SALT311.StrType)le.name,(SALT311.StrType)le.firstname,(SALT311.StrType)le.middlename,(SALT311.StrType)le.lastname,(SALT311.StrType)le.address_2,(SALT311.StrType)le.address_3,(SALT311.StrType)le.address_4,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.country,(SALT311.StrType)le.zipcode,(SALT311.StrType)le.exclusionprogram,(SALT311.StrType)le.excludingagency,(SALT311.StrType)le.exclusiontype,(SALT311.StrType)le.activedate,(SALT311.StrType)le.terminationdate,(SALT311.StrType)le.samnumber,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,18,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Input_Layout_SAM) prevDS = DATASET([], Input_Layout_SAM), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.classification_CUSTOM_ErrorCount
          ,le.name_CUSTOM_ErrorCount
          ,le.firstname_CUSTOM_ErrorCount
          ,le.middlename_CUSTOM_ErrorCount
          ,le.lastname_CUSTOM_ErrorCount
          ,le.address_2_CUSTOM_ErrorCount
          ,le.address_3_CUSTOM_ErrorCount
          ,le.address_4_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.country_CUSTOM_ErrorCount
          ,le.zipcode_CUSTOM_ErrorCount
          ,le.exclusionprogram_CUSTOM_ErrorCount
          ,le.excludingagency_CUSTOM_ErrorCount
          ,le.exclusiontype_CUSTOM_ErrorCount
          ,le.activedate_CUSTOM_ErrorCount
          ,le.terminationdate_CUSTOM_ErrorCount
          ,le.samnumber_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.classification_CUSTOM_ErrorCount
          ,le.name_CUSTOM_ErrorCount
          ,le.firstname_CUSTOM_ErrorCount
          ,le.middlename_CUSTOM_ErrorCount
          ,le.lastname_CUSTOM_ErrorCount
          ,le.address_2_CUSTOM_ErrorCount
          ,le.address_3_CUSTOM_ErrorCount
          ,le.address_4_CUSTOM_ErrorCount
          ,le.city_CUSTOM_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.country_CUSTOM_ErrorCount
          ,le.zipcode_CUSTOM_ErrorCount
          ,le.exclusionprogram_CUSTOM_ErrorCount
          ,le.excludingagency_CUSTOM_ErrorCount
          ,le.exclusiontype_CUSTOM_ErrorCount
          ,le.activedate_CUSTOM_ErrorCount
          ,le.terminationdate_CUSTOM_ErrorCount
          ,le.samnumber_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Input_hygiene(PROJECT(h, Input_Layout_SAM));
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
          ,'classification:' + getFieldTypeText(h.classification) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name:' + getFieldTypeText(h.name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prefix:' + getFieldTypeText(h.prefix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'firstname:' + getFieldTypeText(h.firstname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middlename:' + getFieldTypeText(h.middlename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lastname:' + getFieldTypeText(h.lastname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_1:' + getFieldTypeText(h.address_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_2:' + getFieldTypeText(h.address_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_3:' + getFieldTypeText(h.address_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address_4:' + getFieldTypeText(h.address_4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'country:' + getFieldTypeText(h.country) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zipcode:' + getFieldTypeText(h.zipcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'duns:' + getFieldTypeText(h.duns) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exclusionprogram:' + getFieldTypeText(h.exclusionprogram) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'excludingagency:' + getFieldTypeText(h.excludingagency) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ctcode:' + getFieldTypeText(h.ctcode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'exclusiontype:' + getFieldTypeText(h.exclusiontype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'additionalcomments:' + getFieldTypeText(h.additionalcomments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'activedate:' + getFieldTypeText(h.activedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'terminationdate:' + getFieldTypeText(h.terminationdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'recordstatus:' + getFieldTypeText(h.recordstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crossreference:' + getFieldTypeText(h.crossreference) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'samnumber:' + getFieldTypeText(h.samnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cage:' + getFieldTypeText(h.cage) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_classification_cnt
          ,le.populated_name_cnt
          ,le.populated_prefix_cnt
          ,le.populated_firstname_cnt
          ,le.populated_middlename_cnt
          ,le.populated_lastname_cnt
          ,le.populated_suffix_cnt
          ,le.populated_address_1_cnt
          ,le.populated_address_2_cnt
          ,le.populated_address_3_cnt
          ,le.populated_address_4_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_country_cnt
          ,le.populated_zipcode_cnt
          ,le.populated_duns_cnt
          ,le.populated_exclusionprogram_cnt
          ,le.populated_excludingagency_cnt
          ,le.populated_ctcode_cnt
          ,le.populated_exclusiontype_cnt
          ,le.populated_additionalcomments_cnt
          ,le.populated_activedate_cnt
          ,le.populated_terminationdate_cnt
          ,le.populated_recordstatus_cnt
          ,le.populated_crossreference_cnt
          ,le.populated_samnumber_cnt
          ,le.populated_cage_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_classification_pcnt
          ,le.populated_name_pcnt
          ,le.populated_prefix_pcnt
          ,le.populated_firstname_pcnt
          ,le.populated_middlename_pcnt
          ,le.populated_lastname_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_address_1_pcnt
          ,le.populated_address_2_pcnt
          ,le.populated_address_3_pcnt
          ,le.populated_address_4_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_country_pcnt
          ,le.populated_zipcode_pcnt
          ,le.populated_duns_pcnt
          ,le.populated_exclusionprogram_pcnt
          ,le.populated_excludingagency_pcnt
          ,le.populated_ctcode_pcnt
          ,le.populated_exclusiontype_pcnt
          ,le.populated_additionalcomments_pcnt
          ,le.populated_activedate_pcnt
          ,le.populated_terminationdate_pcnt
          ,le.populated_recordstatus_pcnt
          ,le.populated_crossreference_pcnt
          ,le.populated_samnumber_pcnt
          ,le.populated_cage_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,27,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Input_Delta(prevDS, PROJECT(h, Input_Layout_SAM));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),27,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Input_Layout_SAM) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_SAM, Input_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
