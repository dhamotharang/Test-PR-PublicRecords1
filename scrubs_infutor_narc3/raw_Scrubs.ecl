IMPORT SALT311,STD;
EXPORT raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 10;
  EXPORT NumRulesFromFieldType := 10;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 10;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(raw_Layout_infutor_narc3)
    UNSIGNED1 orig_fname_Invalid;
    UNSIGNED1 orig_mname_Invalid;
    UNSIGNED1 orig_lname_Invalid;
    UNSIGNED1 orig_suffix_Invalid;
    UNSIGNED1 orig_gender_Invalid;
    UNSIGNED1 orig_age_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(raw_Layout_infutor_narc3)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(raw_Layout_infutor_narc3) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.orig_fname_Invalid := raw_Fields.InValid_orig_fname((SALT311.StrType)le.orig_fname);
    SELF.orig_mname_Invalid := raw_Fields.InValid_orig_mname((SALT311.StrType)le.orig_mname);
    SELF.orig_lname_Invalid := raw_Fields.InValid_orig_lname((SALT311.StrType)le.orig_lname);
    SELF.orig_suffix_Invalid := raw_Fields.InValid_orig_suffix((SALT311.StrType)le.orig_suffix);
    SELF.orig_gender_Invalid := raw_Fields.InValid_orig_gender((SALT311.StrType)le.orig_gender);
    SELF.orig_age_Invalid := raw_Fields.InValid_orig_age((SALT311.StrType)le.orig_age);
    SELF.orig_dob_Invalid := raw_Fields.InValid_orig_dob((SALT311.StrType)le.orig_dob);
    SELF.orig_city_Invalid := raw_Fields.InValid_orig_city((SALT311.StrType)le.orig_city);
    SELF.orig_state_Invalid := raw_Fields.InValid_orig_state((SALT311.StrType)le.orig_state);
    SELF.orig_zip_Invalid := raw_Fields.InValid_orig_zip((SALT311.StrType)le.orig_zip);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),raw_Layout_infutor_narc3);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_fname_Invalid << 0 ) + ( le.orig_mname_Invalid << 1 ) + ( le.orig_lname_Invalid << 2 ) + ( le.orig_suffix_Invalid << 3 ) + ( le.orig_gender_Invalid << 4 ) + ( le.orig_age_Invalid << 5 ) + ( le.orig_dob_Invalid << 6 ) + ( le.orig_city_Invalid << 7 ) + ( le.orig_state_Invalid << 8 ) + ( le.orig_zip_Invalid << 9 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,raw_Layout_infutor_narc3);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_fname_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.orig_mname_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.orig_lname_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_suffix_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_gender_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_age_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_fname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_fname_Invalid=1);
    orig_mname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mname_Invalid=1);
    orig_lname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lname_Invalid=1);
    orig_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.orig_suffix_Invalid=1);
    orig_gender_ENUM_ErrorCount := COUNT(GROUP,h.orig_gender_Invalid=1);
    orig_age_ALLOW_ErrorCount := COUNT(GROUP,h.orig_age_Invalid=1);
    orig_dob_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_ENUM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.orig_fname_Invalid > 0 OR h.orig_mname_Invalid > 0 OR h.orig_lname_Invalid > 0 OR h.orig_suffix_Invalid > 0 OR h.orig_gender_Invalid > 0 OR h.orig_age_Invalid > 0 OR h.orig_dob_Invalid > 0 OR h.orig_city_Invalid > 0 OR h.orig_state_Invalid > 0 OR h.orig_zip_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.orig_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_mname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.orig_state_ENUM_ErrorCount > 0, 1, 0) + IF(le.orig_zip_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_fname_Invalid,le.orig_mname_Invalid,le.orig_lname_Invalid,le.orig_suffix_Invalid,le.orig_gender_Invalid,le.orig_age_Invalid,le.orig_dob_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,raw_Fields.InvalidMessage_orig_fname(le.orig_fname_Invalid),raw_Fields.InvalidMessage_orig_mname(le.orig_mname_Invalid),raw_Fields.InvalidMessage_orig_lname(le.orig_lname_Invalid),raw_Fields.InvalidMessage_orig_suffix(le.orig_suffix_Invalid),raw_Fields.InvalidMessage_orig_gender(le.orig_gender_Invalid),raw_Fields.InvalidMessage_orig_age(le.orig_age_Invalid),raw_Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),raw_Fields.InvalidMessage_orig_city(le.orig_city_Invalid),raw_Fields.InvalidMessage_orig_state(le.orig_state_Invalid),raw_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_fname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_mname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_lname_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_suffix_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_fname','orig_mname','orig_lname','orig_suffix','orig_gender','orig_age','orig_dob','orig_city','orig_state','orig_zip','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_name','invalid_name','invalid_name','invalid_name','invalid_gender','invalid_age','invalid_dob','invalid_city','invalid_state','invalid_zip','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_mname,(SALT311.StrType)le.orig_lname,(SALT311.StrType)le.orig_suffix,(SALT311.StrType)le.orig_gender,(SALT311.StrType)le.orig_age,(SALT311.StrType)le.orig_dob,(SALT311.StrType)le.orig_city,(SALT311.StrType)le.orig_state,(SALT311.StrType)le.orig_zip,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,10,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(raw_Layout_infutor_narc3) prevDS = DATASET([], raw_Layout_infutor_narc3), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'orig_fname:invalid_name:ALLOW'
          ,'orig_mname:invalid_name:ALLOW'
          ,'orig_lname:invalid_name:ALLOW'
          ,'orig_suffix:invalid_name:ALLOW'
          ,'orig_gender:invalid_gender:ENUM'
          ,'orig_age:invalid_age:ALLOW'
          ,'orig_dob:invalid_dob:ALLOW'
          ,'orig_city:invalid_city:ALLOW'
          ,'orig_state:invalid_state:ENUM'
          ,'orig_zip:invalid_zip:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,raw_Fields.InvalidMessage_orig_fname(1)
          ,raw_Fields.InvalidMessage_orig_mname(1)
          ,raw_Fields.InvalidMessage_orig_lname(1)
          ,raw_Fields.InvalidMessage_orig_suffix(1)
          ,raw_Fields.InvalidMessage_orig_gender(1)
          ,raw_Fields.InvalidMessage_orig_age(1)
          ,raw_Fields.InvalidMessage_orig_dob(1)
          ,raw_Fields.InvalidMessage_orig_city(1)
          ,raw_Fields.InvalidMessage_orig_state(1)
          ,raw_Fields.InvalidMessage_orig_zip(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.orig_fname_ALLOW_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount
          ,le.orig_suffix_ALLOW_ErrorCount
          ,le.orig_gender_ENUM_ErrorCount
          ,le.orig_age_ALLOW_ErrorCount
          ,le.orig_dob_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_ENUM_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.orig_fname_ALLOW_ErrorCount
          ,le.orig_mname_ALLOW_ErrorCount
          ,le.orig_lname_ALLOW_ErrorCount
          ,le.orig_suffix_ALLOW_ErrorCount
          ,le.orig_gender_ENUM_ErrorCount
          ,le.orig_age_ALLOW_ErrorCount
          ,le.orig_dob_ALLOW_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_ENUM_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := raw_hygiene(PROJECT(h, raw_Layout_infutor_narc3));
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
          ,'orig_hhid:' + getFieldTypeText(h.orig_hhid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pid:' + getFieldTypeText(h.orig_pid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fname:' + getFieldTypeText(h.orig_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mname:' + getFieldTypeText(h.orig_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_lname:' + getFieldTypeText(h.orig_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_suffix:' + getFieldTypeText(h.orig_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_gender:' + getFieldTypeText(h.orig_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_age:' + getFieldTypeText(h.orig_age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dob:' + getFieldTypeText(h.orig_dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_hhnbr:' + getFieldTypeText(h.orig_hhnbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_addrid:' + getFieldTypeText(h.orig_addrid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_address:' + getFieldTypeText(h.orig_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_house:' + getFieldTypeText(h.orig_house) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_predir:' + getFieldTypeText(h.orig_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_street:' + getFieldTypeText(h.orig_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_strtype:' + getFieldTypeText(h.orig_strtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_postdir:' + getFieldTypeText(h.orig_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_apttype:' + getFieldTypeText(h.orig_apttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_aptnbr:' + getFieldTypeText(h.orig_aptnbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_city:' + getFieldTypeText(h.orig_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_state:' + getFieldTypeText(h.orig_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_zip:' + getFieldTypeText(h.orig_zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_z4:' + getFieldTypeText(h.orig_z4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dpc:' + getFieldTypeText(h.orig_dpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_z4type:' + getFieldTypeText(h.orig_z4type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_crte:' + getFieldTypeText(h.orig_crte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dpv:' + getFieldTypeText(h.orig_dpv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_vacant:' + getFieldTypeText(h.orig_vacant) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_msa:' + getFieldTypeText(h.orig_msa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_cbsa:' + getFieldTypeText(h.orig_cbsa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma:' + getFieldTypeText(h.orig_dma) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_county_code:' + getFieldTypeText(h.orig_county_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_time_zone:' + getFieldTypeText(h.orig_time_zone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_daylight_savings:' + getFieldTypeText(h.orig_daylight_savings) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_latitude:' + getFieldTypeText(h.orig_latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_longitude:' + getFieldTypeText(h.orig_longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephone_number_1:' + getFieldTypeText(h.orig_telephone_number_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_1:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephone_number_2:' + getFieldTypeText(h.orig_telephone_number_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_2:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_telephone_number_3:' + getFieldTypeText(h.orig_telephone_number_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dma_tps_dnc_flag_3:' + getFieldTypeText(h.orig_dma_tps_dnc_flag_3) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_length_of_residence:' + getFieldTypeText(h.orig_length_of_residence) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_homeowner_renter:' + getFieldTypeText(h.orig_homeowner_renter) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_year_built:' + getFieldTypeText(h.orig_year_built) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mobile_home_indicator:' + getFieldTypeText(h.orig_mobile_home_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pool_owner:' + getFieldTypeText(h.orig_pool_owner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_fireplace_in_home:' + getFieldTypeText(h.orig_fireplace_in_home) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_estimated_income:' + getFieldTypeText(h.orig_estimated_income) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_marital_status:' + getFieldTypeText(h.orig_marital_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_single_parent:' + getFieldTypeText(h.orig_single_parent) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_senior_in_hh:' + getFieldTypeText(h.orig_senior_in_hh) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_credit_card_user:' + getFieldTypeText(h.orig_credit_card_user) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_wealth_score_estimated_net_worth:' + getFieldTypeText(h.orig_wealth_score_estimated_net_worth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_donator_to_charity_or_causes:' + getFieldTypeText(h.orig_donator_to_charity_or_causes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_dwelling_type:' + getFieldTypeText(h.orig_dwelling_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_home_market_value:' + getFieldTypeText(h.orig_home_market_value) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_education:' + getFieldTypeText(h.orig_education) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_ethnicity:' + getFieldTypeText(h.orig_ethnicity) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_child:' + getFieldTypeText(h.orig_child) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_child_age_ranges:' + getFieldTypeText(h.orig_child_age_ranges) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_number_of_children_in_hh:' + getFieldTypeText(h.orig_number_of_children_in_hh) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_luxury_vehicle_owner:' + getFieldTypeText(h.orig_luxury_vehicle_owner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_suv_owner:' + getFieldTypeText(h.orig_suv_owner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pickup_truck_owner:' + getFieldTypeText(h.orig_pickup_truck_owner) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_price_club_and_value_purchasing_indicator:' + getFieldTypeText(h.orig_price_club_and_value_purchasing_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_womens_apparel_purchasing_indicator:' + getFieldTypeText(h.orig_womens_apparel_purchasing_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mens_apparel_purchasing_indcator:' + getFieldTypeText(h.orig_mens_apparel_purchasing_indcator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_parenting_and_childrens_interest_bundle:' + getFieldTypeText(h.orig_parenting_and_childrens_interest_bundle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_pet_lovers_or_owners:' + getFieldTypeText(h.orig_pet_lovers_or_owners) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_book_buyers:' + getFieldTypeText(h.orig_book_buyers) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_book_readers:' + getFieldTypeText(h.orig_book_readers) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_hi_tech_enthusiasts:' + getFieldTypeText(h.orig_hi_tech_enthusiasts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_arts_bundle:' + getFieldTypeText(h.orig_arts_bundle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_collectibles_bundle:' + getFieldTypeText(h.orig_collectibles_bundle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_hobbies_home_and_garden_bundle:' + getFieldTypeText(h.orig_hobbies_home_and_garden_bundle) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_home_improvement:' + getFieldTypeText(h.orig_home_improvement) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_cooking_and_wine:' + getFieldTypeText(h.orig_cooking_and_wine) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_gaming_and_gambling_enthusiast:' + getFieldTypeText(h.orig_gaming_and_gambling_enthusiast) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_travel_enthusiasts:' + getFieldTypeText(h.orig_travel_enthusiasts) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_physical_fitness:' + getFieldTypeText(h.orig_physical_fitness) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_self_improvement:' + getFieldTypeText(h.orig_self_improvement) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_automotive_diy:' + getFieldTypeText(h.orig_automotive_diy) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_spectator_sports_interest:' + getFieldTypeText(h.orig_spectator_sports_interest) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_outdoors:' + getFieldTypeText(h.orig_outdoors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_avid_investors:' + getFieldTypeText(h.orig_avid_investors) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_avid_interest_in_boating:' + getFieldTypeText(h.orig_avid_interest_in_boating) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_avid_interest_in_motorcycling:' + getFieldTypeText(h.orig_avid_interest_in_motorcycling) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_black:' + getFieldTypeText(h.orig_percent_range_black) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_white:' + getFieldTypeText(h.orig_percent_range_white) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_hispanic:' + getFieldTypeText(h.orig_percent_range_hispanic) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_asian:' + getFieldTypeText(h.orig_percent_range_asian) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_english_speaking:' + getFieldTypeText(h.orig_percent_range_english_speaking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percnt_range_spanish_speaking:' + getFieldTypeText(h.orig_percnt_range_spanish_speaking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_asian_speaking:' + getFieldTypeText(h.orig_percent_range_asian_speaking) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_sfdu:' + getFieldTypeText(h.orig_percent_range_sfdu) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_percent_range_mfdu:' + getFieldTypeText(h.orig_percent_range_mfdu) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mhv:' + getFieldTypeText(h.orig_mhv) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_mor:' + getFieldTypeText(h.orig_mor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_car:' + getFieldTypeText(h.orig_car) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_medschl:' + getFieldTypeText(h.orig_medschl) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_penetration_range_white_collar:' + getFieldTypeText(h.orig_penetration_range_white_collar) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_penetration_range_blue_collar:' + getFieldTypeText(h.orig_penetration_range_blue_collar) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_penetration_range_other_occupation:' + getFieldTypeText(h.orig_penetration_range_other_occupation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'orig_demolevel:' + getFieldTypeText(h.orig_demolevel) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_orig_hhid_cnt
          ,le.populated_orig_pid_cnt
          ,le.populated_orig_fname_cnt
          ,le.populated_orig_mname_cnt
          ,le.populated_orig_lname_cnt
          ,le.populated_orig_suffix_cnt
          ,le.populated_orig_gender_cnt
          ,le.populated_orig_age_cnt
          ,le.populated_orig_dob_cnt
          ,le.populated_orig_hhnbr_cnt
          ,le.populated_orig_addrid_cnt
          ,le.populated_orig_address_cnt
          ,le.populated_orig_house_cnt
          ,le.populated_orig_predir_cnt
          ,le.populated_orig_street_cnt
          ,le.populated_orig_strtype_cnt
          ,le.populated_orig_postdir_cnt
          ,le.populated_orig_apttype_cnt
          ,le.populated_orig_aptnbr_cnt
          ,le.populated_orig_city_cnt
          ,le.populated_orig_state_cnt
          ,le.populated_orig_zip_cnt
          ,le.populated_orig_z4_cnt
          ,le.populated_orig_dpc_cnt
          ,le.populated_orig_z4type_cnt
          ,le.populated_orig_crte_cnt
          ,le.populated_orig_dpv_cnt
          ,le.populated_orig_vacant_cnt
          ,le.populated_orig_msa_cnt
          ,le.populated_orig_cbsa_cnt
          ,le.populated_orig_dma_cnt
          ,le.populated_orig_county_code_cnt
          ,le.populated_orig_time_zone_cnt
          ,le.populated_orig_daylight_savings_cnt
          ,le.populated_orig_latitude_cnt
          ,le.populated_orig_longitude_cnt
          ,le.populated_orig_telephone_number_1_cnt
          ,le.populated_orig_dma_tps_dnc_flag_1_cnt
          ,le.populated_orig_telephone_number_2_cnt
          ,le.populated_orig_dma_tps_dnc_flag_2_cnt
          ,le.populated_orig_telephone_number_3_cnt
          ,le.populated_orig_dma_tps_dnc_flag_3_cnt
          ,le.populated_orig_length_of_residence_cnt
          ,le.populated_orig_homeowner_renter_cnt
          ,le.populated_orig_year_built_cnt
          ,le.populated_orig_mobile_home_indicator_cnt
          ,le.populated_orig_pool_owner_cnt
          ,le.populated_orig_fireplace_in_home_cnt
          ,le.populated_orig_estimated_income_cnt
          ,le.populated_orig_marital_status_cnt
          ,le.populated_orig_single_parent_cnt
          ,le.populated_orig_senior_in_hh_cnt
          ,le.populated_orig_credit_card_user_cnt
          ,le.populated_orig_wealth_score_estimated_net_worth_cnt
          ,le.populated_orig_donator_to_charity_or_causes_cnt
          ,le.populated_orig_dwelling_type_cnt
          ,le.populated_orig_home_market_value_cnt
          ,le.populated_orig_education_cnt
          ,le.populated_orig_ethnicity_cnt
          ,le.populated_orig_child_cnt
          ,le.populated_orig_child_age_ranges_cnt
          ,le.populated_orig_number_of_children_in_hh_cnt
          ,le.populated_orig_luxury_vehicle_owner_cnt
          ,le.populated_orig_suv_owner_cnt
          ,le.populated_orig_pickup_truck_owner_cnt
          ,le.populated_orig_price_club_and_value_purchasing_indicator_cnt
          ,le.populated_orig_womens_apparel_purchasing_indicator_cnt
          ,le.populated_orig_mens_apparel_purchasing_indcator_cnt
          ,le.populated_orig_parenting_and_childrens_interest_bundle_cnt
          ,le.populated_orig_pet_lovers_or_owners_cnt
          ,le.populated_orig_book_buyers_cnt
          ,le.populated_orig_book_readers_cnt
          ,le.populated_orig_hi_tech_enthusiasts_cnt
          ,le.populated_orig_arts_bundle_cnt
          ,le.populated_orig_collectibles_bundle_cnt
          ,le.populated_orig_hobbies_home_and_garden_bundle_cnt
          ,le.populated_orig_home_improvement_cnt
          ,le.populated_orig_cooking_and_wine_cnt
          ,le.populated_orig_gaming_and_gambling_enthusiast_cnt
          ,le.populated_orig_travel_enthusiasts_cnt
          ,le.populated_orig_physical_fitness_cnt
          ,le.populated_orig_self_improvement_cnt
          ,le.populated_orig_automotive_diy_cnt
          ,le.populated_orig_spectator_sports_interest_cnt
          ,le.populated_orig_outdoors_cnt
          ,le.populated_orig_avid_investors_cnt
          ,le.populated_orig_avid_interest_in_boating_cnt
          ,le.populated_orig_avid_interest_in_motorcycling_cnt
          ,le.populated_orig_percent_range_black_cnt
          ,le.populated_orig_percent_range_white_cnt
          ,le.populated_orig_percent_range_hispanic_cnt
          ,le.populated_orig_percent_range_asian_cnt
          ,le.populated_orig_percent_range_english_speaking_cnt
          ,le.populated_orig_percnt_range_spanish_speaking_cnt
          ,le.populated_orig_percent_range_asian_speaking_cnt
          ,le.populated_orig_percent_range_sfdu_cnt
          ,le.populated_orig_percent_range_mfdu_cnt
          ,le.populated_orig_mhv_cnt
          ,le.populated_orig_mor_cnt
          ,le.populated_orig_car_cnt
          ,le.populated_orig_medschl_cnt
          ,le.populated_orig_penetration_range_white_collar_cnt
          ,le.populated_orig_penetration_range_blue_collar_cnt
          ,le.populated_orig_penetration_range_other_occupation_cnt
          ,le.populated_orig_demolevel_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_orig_hhid_pcnt
          ,le.populated_orig_pid_pcnt
          ,le.populated_orig_fname_pcnt
          ,le.populated_orig_mname_pcnt
          ,le.populated_orig_lname_pcnt
          ,le.populated_orig_suffix_pcnt
          ,le.populated_orig_gender_pcnt
          ,le.populated_orig_age_pcnt
          ,le.populated_orig_dob_pcnt
          ,le.populated_orig_hhnbr_pcnt
          ,le.populated_orig_addrid_pcnt
          ,le.populated_orig_address_pcnt
          ,le.populated_orig_house_pcnt
          ,le.populated_orig_predir_pcnt
          ,le.populated_orig_street_pcnt
          ,le.populated_orig_strtype_pcnt
          ,le.populated_orig_postdir_pcnt
          ,le.populated_orig_apttype_pcnt
          ,le.populated_orig_aptnbr_pcnt
          ,le.populated_orig_city_pcnt
          ,le.populated_orig_state_pcnt
          ,le.populated_orig_zip_pcnt
          ,le.populated_orig_z4_pcnt
          ,le.populated_orig_dpc_pcnt
          ,le.populated_orig_z4type_pcnt
          ,le.populated_orig_crte_pcnt
          ,le.populated_orig_dpv_pcnt
          ,le.populated_orig_vacant_pcnt
          ,le.populated_orig_msa_pcnt
          ,le.populated_orig_cbsa_pcnt
          ,le.populated_orig_dma_pcnt
          ,le.populated_orig_county_code_pcnt
          ,le.populated_orig_time_zone_pcnt
          ,le.populated_orig_daylight_savings_pcnt
          ,le.populated_orig_latitude_pcnt
          ,le.populated_orig_longitude_pcnt
          ,le.populated_orig_telephone_number_1_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_1_pcnt
          ,le.populated_orig_telephone_number_2_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_2_pcnt
          ,le.populated_orig_telephone_number_3_pcnt
          ,le.populated_orig_dma_tps_dnc_flag_3_pcnt
          ,le.populated_orig_length_of_residence_pcnt
          ,le.populated_orig_homeowner_renter_pcnt
          ,le.populated_orig_year_built_pcnt
          ,le.populated_orig_mobile_home_indicator_pcnt
          ,le.populated_orig_pool_owner_pcnt
          ,le.populated_orig_fireplace_in_home_pcnt
          ,le.populated_orig_estimated_income_pcnt
          ,le.populated_orig_marital_status_pcnt
          ,le.populated_orig_single_parent_pcnt
          ,le.populated_orig_senior_in_hh_pcnt
          ,le.populated_orig_credit_card_user_pcnt
          ,le.populated_orig_wealth_score_estimated_net_worth_pcnt
          ,le.populated_orig_donator_to_charity_or_causes_pcnt
          ,le.populated_orig_dwelling_type_pcnt
          ,le.populated_orig_home_market_value_pcnt
          ,le.populated_orig_education_pcnt
          ,le.populated_orig_ethnicity_pcnt
          ,le.populated_orig_child_pcnt
          ,le.populated_orig_child_age_ranges_pcnt
          ,le.populated_orig_number_of_children_in_hh_pcnt
          ,le.populated_orig_luxury_vehicle_owner_pcnt
          ,le.populated_orig_suv_owner_pcnt
          ,le.populated_orig_pickup_truck_owner_pcnt
          ,le.populated_orig_price_club_and_value_purchasing_indicator_pcnt
          ,le.populated_orig_womens_apparel_purchasing_indicator_pcnt
          ,le.populated_orig_mens_apparel_purchasing_indcator_pcnt
          ,le.populated_orig_parenting_and_childrens_interest_bundle_pcnt
          ,le.populated_orig_pet_lovers_or_owners_pcnt
          ,le.populated_orig_book_buyers_pcnt
          ,le.populated_orig_book_readers_pcnt
          ,le.populated_orig_hi_tech_enthusiasts_pcnt
          ,le.populated_orig_arts_bundle_pcnt
          ,le.populated_orig_collectibles_bundle_pcnt
          ,le.populated_orig_hobbies_home_and_garden_bundle_pcnt
          ,le.populated_orig_home_improvement_pcnt
          ,le.populated_orig_cooking_and_wine_pcnt
          ,le.populated_orig_gaming_and_gambling_enthusiast_pcnt
          ,le.populated_orig_travel_enthusiasts_pcnt
          ,le.populated_orig_physical_fitness_pcnt
          ,le.populated_orig_self_improvement_pcnt
          ,le.populated_orig_automotive_diy_pcnt
          ,le.populated_orig_spectator_sports_interest_pcnt
          ,le.populated_orig_outdoors_pcnt
          ,le.populated_orig_avid_investors_pcnt
          ,le.populated_orig_avid_interest_in_boating_pcnt
          ,le.populated_orig_avid_interest_in_motorcycling_pcnt
          ,le.populated_orig_percent_range_black_pcnt
          ,le.populated_orig_percent_range_white_pcnt
          ,le.populated_orig_percent_range_hispanic_pcnt
          ,le.populated_orig_percent_range_asian_pcnt
          ,le.populated_orig_percent_range_english_speaking_pcnt
          ,le.populated_orig_percnt_range_spanish_speaking_pcnt
          ,le.populated_orig_percent_range_asian_speaking_pcnt
          ,le.populated_orig_percent_range_sfdu_pcnt
          ,le.populated_orig_percent_range_mfdu_pcnt
          ,le.populated_orig_mhv_pcnt
          ,le.populated_orig_mor_pcnt
          ,le.populated_orig_car_pcnt
          ,le.populated_orig_medschl_pcnt
          ,le.populated_orig_penetration_range_white_collar_pcnt
          ,le.populated_orig_penetration_range_blue_collar_pcnt
          ,le.populated_orig_penetration_range_other_occupation_pcnt
          ,le.populated_orig_demolevel_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,105,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := raw_Delta(prevDS, PROJECT(h, raw_Layout_infutor_narc3));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),105,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(raw_Layout_infutor_narc3) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(scrubs_infutor_narc3, raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
