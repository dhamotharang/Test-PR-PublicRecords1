IMPORT SALT311,STD;
EXPORT raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 9;
  EXPORT NumRulesFromFieldType := 9;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 9;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(raw_Layout_Fed_Bureau_Prisons)
    UNSIGNED1 name_Invalid;
    UNSIGNED1 lastname_Invalid;
    UNSIGNED1 firstname_Invalid;
    UNSIGNED1 middlename_Invalid;
    UNSIGNED1 suffix_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 race_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(raw_Layout_Fed_Bureau_Prisons)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(raw_Layout_Fed_Bureau_Prisons) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.name_Invalid := raw_Fields.InValid_name((SALT311.StrType)le.name);
    SELF.lastname_Invalid := raw_Fields.InValid_lastname((SALT311.StrType)le.lastname);
    SELF.firstname_Invalid := raw_Fields.InValid_firstname((SALT311.StrType)le.firstname);
    SELF.middlename_Invalid := raw_Fields.InValid_middlename((SALT311.StrType)le.middlename);
    SELF.suffix_Invalid := raw_Fields.InValid_suffix((SALT311.StrType)le.suffix);
    SELF.dob_Invalid := raw_Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.age_Invalid := raw_Fields.InValid_age((SALT311.StrType)le.age);
    SELF.gender_Invalid := raw_Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.race_Invalid := raw_Fields.InValid_race((SALT311.StrType)le.race);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),raw_Layout_Fed_Bureau_Prisons);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.name_Invalid << 0 ) + ( le.lastname_Invalid << 1 ) + ( le.firstname_Invalid << 2 ) + ( le.middlename_Invalid << 3 ) + ( le.suffix_Invalid << 4 ) + ( le.dob_Invalid << 5 ) + ( le.age_Invalid << 6 ) + ( le.gender_Invalid << 7 ) + ( le.race_Invalid << 8 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,raw_Layout_Fed_Bureau_Prisons);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.name_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.lastname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.firstname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.middlename_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.suffix_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.race_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    name_ALLOW_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    lastname_ALLOW_ErrorCount := COUNT(GROUP,h.lastname_Invalid=1);
    firstname_ALLOW_ErrorCount := COUNT(GROUP,h.firstname_Invalid=1);
    middlename_ALLOW_ErrorCount := COUNT(GROUP,h.middlename_Invalid=1);
    suffix_ALLOW_ErrorCount := COUNT(GROUP,h.suffix_Invalid=1);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    gender_ALLOW_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    race_ALLOW_ErrorCount := COUNT(GROUP,h.race_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.name_Invalid > 0 OR h.lastname_Invalid > 0 OR h.firstname_Invalid > 0 OR h.middlename_Invalid > 0 OR h.suffix_Invalid > 0 OR h.dob_Invalid > 0 OR h.age_Invalid > 0 OR h.gender_Invalid > 0 OR h.race_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middlename_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.race_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.name_ALLOW_ErrorCount > 0, 1, 0) + IF(le.lastname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.firstname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.middlename_ALLOW_ErrorCount > 0, 1, 0) + IF(le.suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.gender_ALLOW_ErrorCount > 0, 1, 0) + IF(le.race_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.name_Invalid,le.lastname_Invalid,le.firstname_Invalid,le.middlename_Invalid,le.suffix_Invalid,le.dob_Invalid,le.age_Invalid,le.gender_Invalid,le.race_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,raw_Fields.InvalidMessage_name(le.name_Invalid),raw_Fields.InvalidMessage_lastname(le.lastname_Invalid),raw_Fields.InvalidMessage_firstname(le.firstname_Invalid),raw_Fields.InvalidMessage_middlename(le.middlename_Invalid),raw_Fields.InvalidMessage_suffix(le.suffix_Invalid),raw_Fields.InvalidMessage_dob(le.dob_Invalid),raw_Fields.InvalidMessage_age(le.age_Invalid),raw_Fields.InvalidMessage_gender(le.gender_Invalid),raw_Fields.InvalidMessage_race(le.race_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.name_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.lastname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.firstname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.middlename_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.race_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'name','lastname','firstname','middlename','suffix','dob','age','gender','race','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_orig_name','invalid_orig_parsed_name','invalid_orig_parsed_name','invalid_orig_parsed_name','invalid_orig_parsed_name','invalid_number','invalid_number','invalid_alpha','invalid_race','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.name,(SALT311.StrType)le.lastname,(SALT311.StrType)le.firstname,(SALT311.StrType)le.middlename,(SALT311.StrType)le.suffix,(SALT311.StrType)le.dob,(SALT311.StrType)le.age,(SALT311.StrType)le.gender,(SALT311.StrType)le.race,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,9,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(raw_Layout_Fed_Bureau_Prisons) prevDS = DATASET([], raw_Layout_Fed_Bureau_Prisons), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'name:invalid_orig_name:ALLOW'
          ,'lastname:invalid_orig_parsed_name:ALLOW'
          ,'firstname:invalid_orig_parsed_name:ALLOW'
          ,'middlename:invalid_orig_parsed_name:ALLOW'
          ,'suffix:invalid_orig_parsed_name:ALLOW'
          ,'dob:invalid_number:ALLOW'
          ,'age:invalid_number:ALLOW'
          ,'gender:invalid_alpha:ALLOW'
          ,'race:invalid_race:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,raw_Fields.InvalidMessage_name(1)
          ,raw_Fields.InvalidMessage_lastname(1)
          ,raw_Fields.InvalidMessage_firstname(1)
          ,raw_Fields.InvalidMessage_middlename(1)
          ,raw_Fields.InvalidMessage_suffix(1)
          ,raw_Fields.InvalidMessage_dob(1)
          ,raw_Fields.InvalidMessage_age(1)
          ,raw_Fields.InvalidMessage_gender(1)
          ,raw_Fields.InvalidMessage_race(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.name_ALLOW_ErrorCount
          ,le.lastname_ALLOW_ErrorCount
          ,le.firstname_ALLOW_ErrorCount
          ,le.middlename_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.race_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.name_ALLOW_ErrorCount
          ,le.lastname_ALLOW_ErrorCount
          ,le.firstname_ALLOW_ErrorCount
          ,le.middlename_ALLOW_ErrorCount
          ,le.suffix_ALLOW_ErrorCount
          ,le.dob_ALLOW_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.gender_ALLOW_ErrorCount
          ,le.race_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := raw_hygiene(PROJECT(h, raw_Layout_Fed_Bureau_Prisons));
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
          ,'caseid:' + getFieldTypeText(h.caseid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casenumber:' + getFieldTypeText(h.casenumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casetitle:' + getFieldTypeText(h.casetitle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casetype:' + getFieldTypeText(h.casetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casestatus:' + getFieldTypeText(h.casestatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casestatusdate:' + getFieldTypeText(h.casestatusdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'casecomments:' + getFieldTypeText(h.casecomments) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fileddate:' + getFieldTypeText(h.fileddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'caseinfo:' + getFieldTypeText(h.caseinfo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'docketnumber:' + getFieldTypeText(h.docketnumber) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offensecode:' + getFieldTypeText(h.offensecode) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offensedesc:' + getFieldTypeText(h.offensedesc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offensedate:' + getFieldTypeText(h.offensedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offensetype:' + getFieldTypeText(h.offensetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offensedegree:' + getFieldTypeText(h.offensedegree) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offenseclass:' + getFieldTypeText(h.offenseclass) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dispositionstatus:' + getFieldTypeText(h.dispositionstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dispositionstatusdate:' + getFieldTypeText(h.dispositionstatusdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'disposition:' + getFieldTypeText(h.disposition) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dispositiondate:' + getFieldTypeText(h.dispositiondate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offenselocation:' + getFieldTypeText(h.offenselocation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'finaloffense:' + getFieldTypeText(h.finaloffense) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'finaloffensedate:' + getFieldTypeText(h.finaloffensedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'offensecount:' + getFieldTypeText(h.offensecount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'victimunder18:' + getFieldTypeText(h.victimunder18) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prioroffenseflag:' + getFieldTypeText(h.prioroffenseflag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'initialplea:' + getFieldTypeText(h.initialplea) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'initialpleadate:' + getFieldTypeText(h.initialpleadate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'finalruling:' + getFieldTypeText(h.finalruling) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'finalrulingdate:' + getFieldTypeText(h.finalrulingdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appealstatus:' + getFieldTypeText(h.appealstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'appealdate:' + getFieldTypeText(h.appealdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtname:' + getFieldTypeText(h.courtname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fineamount:' + getFieldTypeText(h.fineamount) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtfee:' + getFieldTypeText(h.courtfee) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'restitution:' + getFieldTypeText(h.restitution) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'trialtype:' + getFieldTypeText(h.trialtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'courtdate:' + getFieldTypeText(h.courtdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'classification_code:' + getFieldTypeText(h.classification_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sub_classification_code:' + getFieldTypeText(h.sub_classification_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sourceid2:' + getFieldTypeText(h.sourceid2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencedate:' + getFieldTypeText(h.sentencedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencebegindate:' + getFieldTypeText(h.sentencebegindate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentenceenddate:' + getFieldTypeText(h.sentenceenddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencetype:' + getFieldTypeText(h.sentencetype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencemaxyears:' + getFieldTypeText(h.sentencemaxyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencemaxmonths:' + getFieldTypeText(h.sentencemaxmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencemaxdays:' + getFieldTypeText(h.sentencemaxdays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentenceminyears:' + getFieldTypeText(h.sentenceminyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentenceminmonths:' + getFieldTypeText(h.sentenceminmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencemindays:' + getFieldTypeText(h.sentencemindays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'scheduledreleasedate:' + getFieldTypeText(h.scheduledreleasedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'actualreleasedate:' + getFieldTypeText(h.actualreleasedate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentencestatus:' + getFieldTypeText(h.sentencestatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timeservedyears:' + getFieldTypeText(h.timeservedyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timeservedmonths:' + getFieldTypeText(h.timeservedmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'timeserveddays:' + getFieldTypeText(h.timeserveddays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'publicservicehours:' + getFieldTypeText(h.publicservicehours) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sentenceadditionalinfo:' + getFieldTypeText(h.sentenceadditionalinfo) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'communitysupervisioncounty:' + getFieldTypeText(h.communitysupervisioncounty) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'communitysupervisionyears:' + getFieldTypeText(h.communitysupervisionyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'communitysupervisionmonths:' + getFieldTypeText(h.communitysupervisionmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'communitysupervisiondays:' + getFieldTypeText(h.communitysupervisiondays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolebegindate:' + getFieldTypeText(h.parolebegindate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleenddate:' + getFieldTypeText(h.paroleenddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleeligibilitydate:' + getFieldTypeText(h.paroleeligibilitydate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolehearingdate:' + getFieldTypeText(h.parolehearingdate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolemaxyears:' + getFieldTypeText(h.parolemaxyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolemaxmonths:' + getFieldTypeText(h.parolemaxmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolemaxdays:' + getFieldTypeText(h.parolemaxdays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleminyears:' + getFieldTypeText(h.paroleminyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleminmonths:' + getFieldTypeText(h.paroleminmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolemindays:' + getFieldTypeText(h.parolemindays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'parolestatus:' + getFieldTypeText(h.parolestatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleofficer:' + getFieldTypeText(h.paroleofficer) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'paroleoffcerphone:' + getFieldTypeText(h.paroleoffcerphone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationbegindate:' + getFieldTypeText(h.probationbegindate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationenddate:' + getFieldTypeText(h.probationenddate) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationmaxyears:' + getFieldTypeText(h.probationmaxyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationmaxmonths:' + getFieldTypeText(h.probationmaxmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationmaxdays:' + getFieldTypeText(h.probationmaxdays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationminyears:' + getFieldTypeText(h.probationminyears) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationminmonths:' + getFieldTypeText(h.probationminmonths) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationmindays:' + getFieldTypeText(h.probationmindays) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'probationstatus:' + getFieldTypeText(h.probationstatus) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
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
          ,le.populated_caseid_cnt
          ,le.populated_casenumber_cnt
          ,le.populated_casetitle_cnt
          ,le.populated_casetype_cnt
          ,le.populated_casestatus_cnt
          ,le.populated_casestatusdate_cnt
          ,le.populated_casecomments_cnt
          ,le.populated_fileddate_cnt
          ,le.populated_caseinfo_cnt
          ,le.populated_docketnumber_cnt
          ,le.populated_offensecode_cnt
          ,le.populated_offensedesc_cnt
          ,le.populated_offensedate_cnt
          ,le.populated_offensetype_cnt
          ,le.populated_offensedegree_cnt
          ,le.populated_offenseclass_cnt
          ,le.populated_dispositionstatus_cnt
          ,le.populated_dispositionstatusdate_cnt
          ,le.populated_disposition_cnt
          ,le.populated_dispositiondate_cnt
          ,le.populated_offenselocation_cnt
          ,le.populated_finaloffense_cnt
          ,le.populated_finaloffensedate_cnt
          ,le.populated_offensecount_cnt
          ,le.populated_victimunder18_cnt
          ,le.populated_prioroffenseflag_cnt
          ,le.populated_initialplea_cnt
          ,le.populated_initialpleadate_cnt
          ,le.populated_finalruling_cnt
          ,le.populated_finalrulingdate_cnt
          ,le.populated_appealstatus_cnt
          ,le.populated_appealdate_cnt
          ,le.populated_courtname_cnt
          ,le.populated_fineamount_cnt
          ,le.populated_courtfee_cnt
          ,le.populated_restitution_cnt
          ,le.populated_trialtype_cnt
          ,le.populated_courtdate_cnt
          ,le.populated_classification_code_cnt
          ,le.populated_sub_classification_code_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_cnt
          ,le.populated_sourceid2_cnt
          ,le.populated_sentencedate_cnt
          ,le.populated_sentencebegindate_cnt
          ,le.populated_sentenceenddate_cnt
          ,le.populated_sentencetype_cnt
          ,le.populated_sentencemaxyears_cnt
          ,le.populated_sentencemaxmonths_cnt
          ,le.populated_sentencemaxdays_cnt
          ,le.populated_sentenceminyears_cnt
          ,le.populated_sentenceminmonths_cnt
          ,le.populated_sentencemindays_cnt
          ,le.populated_scheduledreleasedate_cnt
          ,le.populated_actualreleasedate_cnt
          ,le.populated_sentencestatus_cnt
          ,le.populated_timeservedyears_cnt
          ,le.populated_timeservedmonths_cnt
          ,le.populated_timeserveddays_cnt
          ,le.populated_publicservicehours_cnt
          ,le.populated_sentenceadditionalinfo_cnt
          ,le.populated_communitysupervisioncounty_cnt
          ,le.populated_communitysupervisionyears_cnt
          ,le.populated_communitysupervisionmonths_cnt
          ,le.populated_communitysupervisiondays_cnt
          ,le.populated_parolebegindate_cnt
          ,le.populated_paroleenddate_cnt
          ,le.populated_paroleeligibilitydate_cnt
          ,le.populated_parolehearingdate_cnt
          ,le.populated_parolemaxyears_cnt
          ,le.populated_parolemaxmonths_cnt
          ,le.populated_parolemaxdays_cnt
          ,le.populated_paroleminyears_cnt
          ,le.populated_paroleminmonths_cnt
          ,le.populated_parolemindays_cnt
          ,le.populated_parolestatus_cnt
          ,le.populated_paroleofficer_cnt
          ,le.populated_paroleoffcerphone_cnt
          ,le.populated_probationbegindate_cnt
          ,le.populated_probationenddate_cnt
          ,le.populated_probationmaxyears_cnt
          ,le.populated_probationmaxmonths_cnt
          ,le.populated_probationmaxdays_cnt
          ,le.populated_probationminyears_cnt
          ,le.populated_probationminmonths_cnt
          ,le.populated_probationmindays_cnt
          ,le.populated_probationstatus_cnt,0);
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
          ,le.populated_caseid_pcnt
          ,le.populated_casenumber_pcnt
          ,le.populated_casetitle_pcnt
          ,le.populated_casetype_pcnt
          ,le.populated_casestatus_pcnt
          ,le.populated_casestatusdate_pcnt
          ,le.populated_casecomments_pcnt
          ,le.populated_fileddate_pcnt
          ,le.populated_caseinfo_pcnt
          ,le.populated_docketnumber_pcnt
          ,le.populated_offensecode_pcnt
          ,le.populated_offensedesc_pcnt
          ,le.populated_offensedate_pcnt
          ,le.populated_offensetype_pcnt
          ,le.populated_offensedegree_pcnt
          ,le.populated_offenseclass_pcnt
          ,le.populated_dispositionstatus_pcnt
          ,le.populated_dispositionstatusdate_pcnt
          ,le.populated_disposition_pcnt
          ,le.populated_dispositiondate_pcnt
          ,le.populated_offenselocation_pcnt
          ,le.populated_finaloffense_pcnt
          ,le.populated_finaloffensedate_pcnt
          ,le.populated_offensecount_pcnt
          ,le.populated_victimunder18_pcnt
          ,le.populated_prioroffenseflag_pcnt
          ,le.populated_initialplea_pcnt
          ,le.populated_initialpleadate_pcnt
          ,le.populated_finalruling_pcnt
          ,le.populated_finalrulingdate_pcnt
          ,le.populated_appealstatus_pcnt
          ,le.populated_appealdate_pcnt
          ,le.populated_courtname_pcnt
          ,le.populated_fineamount_pcnt
          ,le.populated_courtfee_pcnt
          ,le.populated_restitution_pcnt
          ,le.populated_trialtype_pcnt
          ,le.populated_courtdate_pcnt
          ,le.populated_classification_code_pcnt
          ,le.populated_sub_classification_code_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_sourceid2_pcnt
          ,le.populated_sentencedate_pcnt
          ,le.populated_sentencebegindate_pcnt
          ,le.populated_sentenceenddate_pcnt
          ,le.populated_sentencetype_pcnt
          ,le.populated_sentencemaxyears_pcnt
          ,le.populated_sentencemaxmonths_pcnt
          ,le.populated_sentencemaxdays_pcnt
          ,le.populated_sentenceminyears_pcnt
          ,le.populated_sentenceminmonths_pcnt
          ,le.populated_sentencemindays_pcnt
          ,le.populated_scheduledreleasedate_pcnt
          ,le.populated_actualreleasedate_pcnt
          ,le.populated_sentencestatus_pcnt
          ,le.populated_timeservedyears_pcnt
          ,le.populated_timeservedmonths_pcnt
          ,le.populated_timeserveddays_pcnt
          ,le.populated_publicservicehours_pcnt
          ,le.populated_sentenceadditionalinfo_pcnt
          ,le.populated_communitysupervisioncounty_pcnt
          ,le.populated_communitysupervisionyears_pcnt
          ,le.populated_communitysupervisionmonths_pcnt
          ,le.populated_communitysupervisiondays_pcnt
          ,le.populated_parolebegindate_pcnt
          ,le.populated_paroleenddate_pcnt
          ,le.populated_paroleeligibilitydate_pcnt
          ,le.populated_parolehearingdate_pcnt
          ,le.populated_parolemaxyears_pcnt
          ,le.populated_parolemaxmonths_pcnt
          ,le.populated_parolemaxdays_pcnt
          ,le.populated_paroleminyears_pcnt
          ,le.populated_paroleminmonths_pcnt
          ,le.populated_parolemindays_pcnt
          ,le.populated_parolestatus_pcnt
          ,le.populated_paroleofficer_pcnt
          ,le.populated_paroleoffcerphone_pcnt
          ,le.populated_probationbegindate_pcnt
          ,le.populated_probationenddate_pcnt
          ,le.populated_probationmaxyears_pcnt
          ,le.populated_probationmaxmonths_pcnt
          ,le.populated_probationmaxdays_pcnt
          ,le.populated_probationminyears_pcnt
          ,le.populated_probationminmonths_pcnt
          ,le.populated_probationmindays_pcnt
          ,le.populated_probationstatus_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,148,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := raw_Delta(prevDS, PROJECT(h, raw_Layout_Fed_Bureau_Prisons));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),148,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(raw_Layout_Fed_Bureau_Prisons) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(scrubs_Fed_Bureau_Prisons, raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
