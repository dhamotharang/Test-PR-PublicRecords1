IMPORT SALT311,STD;
EXPORT Lerg1Raw_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 20;
  EXPORT NumRulesFromFieldType := 20;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Lerg1Raw_Layout_PhonesInfo)
    UNSIGNED1 ocn_Invalid;
    UNSIGNED1 ocn_name_Invalid;
    UNSIGNED1 ocn_abbr_name_Invalid;
    UNSIGNED1 ocn_state_Invalid;
    UNSIGNED1 category_Invalid;
    UNSIGNED1 overall_ocn_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 middle_initial_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 postal_code_Invalid;
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 target_ocn_Invalid;
    UNSIGNED1 overall_target_ocn_Invalid;
    UNSIGNED1 rural_lec_indicator_Invalid;
    UNSIGNED1 filename_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Lerg1Raw_Layout_PhonesInfo)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Lerg1Raw_Layout_PhonesInfo)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'ocn:Invalid_Ocn:ALLOW','ocn:Invalid_Ocn:LENGTHS'
          ,'ocn_name:Invalid_NotBlank:LENGTHS'
          ,'ocn_abbr_name:Invalid_NotBlank:LENGTHS'
          ,'ocn_state:Invalid_Ocn_State:ALLOW','ocn_state:Invalid_Ocn_State:LENGTHS'
          ,'category:Invalid_Category:ALLOW','category:Invalid_Category:LENGTHS'
          ,'overall_ocn:Invalid_AlphaNum:ALLOW'
          ,'last_name:Invalid_NotBlank:LENGTHS'
          ,'first_name:Invalid_NotBlank:LENGTHS'
          ,'middle_initial:Invalid_Alpha:ALLOW'
          ,'city:Invalid_Char:ALLOW'
          ,'state:Invalid_Alpha:ALLOW'
          ,'postal_code:Invalid_AlphaNum:ALLOW'
          ,'phone:Invalid_Phone:ALLOW'
          ,'target_ocn:Invalid_AlphaNum:ALLOW'
          ,'overall_target_ocn:Invalid_AlphaNum:ALLOW'
          ,'rural_lec_indicator:Invalid_Indicator:ALLOW'
          ,'filename:Invalid_Filename:ALLOW'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Lerg1Raw_Fields.InvalidMessage_ocn(1),Lerg1Raw_Fields.InvalidMessage_ocn(2)
          ,Lerg1Raw_Fields.InvalidMessage_ocn_name(1)
          ,Lerg1Raw_Fields.InvalidMessage_ocn_abbr_name(1)
          ,Lerg1Raw_Fields.InvalidMessage_ocn_state(1),Lerg1Raw_Fields.InvalidMessage_ocn_state(2)
          ,Lerg1Raw_Fields.InvalidMessage_category(1),Lerg1Raw_Fields.InvalidMessage_category(2)
          ,Lerg1Raw_Fields.InvalidMessage_overall_ocn(1)
          ,Lerg1Raw_Fields.InvalidMessage_last_name(1)
          ,Lerg1Raw_Fields.InvalidMessage_first_name(1)
          ,Lerg1Raw_Fields.InvalidMessage_middle_initial(1)
          ,Lerg1Raw_Fields.InvalidMessage_city(1)
          ,Lerg1Raw_Fields.InvalidMessage_state(1)
          ,Lerg1Raw_Fields.InvalidMessage_postal_code(1)
          ,Lerg1Raw_Fields.InvalidMessage_phone(1)
          ,Lerg1Raw_Fields.InvalidMessage_target_ocn(1)
          ,Lerg1Raw_Fields.InvalidMessage_overall_target_ocn(1)
          ,Lerg1Raw_Fields.InvalidMessage_rural_lec_indicator(1)
          ,Lerg1Raw_Fields.InvalidMessage_filename(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Lerg1Raw_Layout_PhonesInfo) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.ocn_Invalid := Lerg1Raw_Fields.InValid_ocn((SALT311.StrType)le.ocn);
    SELF.ocn_name_Invalid := Lerg1Raw_Fields.InValid_ocn_name((SALT311.StrType)le.ocn_name);
    SELF.ocn_abbr_name_Invalid := Lerg1Raw_Fields.InValid_ocn_abbr_name((SALT311.StrType)le.ocn_abbr_name);
    SELF.ocn_state_Invalid := Lerg1Raw_Fields.InValid_ocn_state((SALT311.StrType)le.ocn_state);
    SELF.category_Invalid := Lerg1Raw_Fields.InValid_category((SALT311.StrType)le.category);
    SELF.overall_ocn_Invalid := Lerg1Raw_Fields.InValid_overall_ocn((SALT311.StrType)le.overall_ocn);
    SELF.last_name_Invalid := Lerg1Raw_Fields.InValid_last_name((SALT311.StrType)le.last_name);
    SELF.first_name_Invalid := Lerg1Raw_Fields.InValid_first_name((SALT311.StrType)le.first_name);
    SELF.middle_initial_Invalid := Lerg1Raw_Fields.InValid_middle_initial((SALT311.StrType)le.middle_initial);
    SELF.city_Invalid := Lerg1Raw_Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Lerg1Raw_Fields.InValid_state((SALT311.StrType)le.state);
    SELF.postal_code_Invalid := Lerg1Raw_Fields.InValid_postal_code((SALT311.StrType)le.postal_code);
    SELF.phone_Invalid := Lerg1Raw_Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.target_ocn_Invalid := Lerg1Raw_Fields.InValid_target_ocn((SALT311.StrType)le.target_ocn);
    SELF.overall_target_ocn_Invalid := Lerg1Raw_Fields.InValid_overall_target_ocn((SALT311.StrType)le.overall_target_ocn);
    SELF.rural_lec_indicator_Invalid := Lerg1Raw_Fields.InValid_rural_lec_indicator((SALT311.StrType)le.rural_lec_indicator);
    SELF.filename_Invalid := Lerg1Raw_Fields.InValid_filename((SALT311.StrType)le.filename);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Lerg1Raw_Layout_PhonesInfo);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.ocn_Invalid << 0 ) + ( le.ocn_name_Invalid << 2 ) + ( le.ocn_abbr_name_Invalid << 3 ) + ( le.ocn_state_Invalid << 4 ) + ( le.category_Invalid << 6 ) + ( le.overall_ocn_Invalid << 8 ) + ( le.last_name_Invalid << 9 ) + ( le.first_name_Invalid << 10 ) + ( le.middle_initial_Invalid << 11 ) + ( le.city_Invalid << 12 ) + ( le.state_Invalid << 13 ) + ( le.postal_code_Invalid << 14 ) + ( le.phone_Invalid << 15 ) + ( le.target_ocn_Invalid << 16 ) + ( le.overall_target_ocn_Invalid << 17 ) + ( le.rural_lec_indicator_Invalid << 18 ) + ( le.filename_Invalid << 19 );
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
  EXPORT Infile := PROJECT(h,Lerg1Raw_Layout_PhonesInfo);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.ocn_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.ocn_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.ocn_abbr_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.ocn_state_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.category_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.overall_ocn_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.middle_initial_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.postal_code_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.phone_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.target_ocn_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.overall_target_ocn_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.rural_lec_indicator_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.filename_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    ocn_ALLOW_ErrorCount := COUNT(GROUP,h.ocn_Invalid=1);
    ocn_LENGTHS_ErrorCount := COUNT(GROUP,h.ocn_Invalid=2);
    ocn_Total_ErrorCount := COUNT(GROUP,h.ocn_Invalid>0);
    ocn_name_LENGTHS_ErrorCount := COUNT(GROUP,h.ocn_name_Invalid=1);
    ocn_abbr_name_LENGTHS_ErrorCount := COUNT(GROUP,h.ocn_abbr_name_Invalid=1);
    ocn_state_ALLOW_ErrorCount := COUNT(GROUP,h.ocn_state_Invalid=1);
    ocn_state_LENGTHS_ErrorCount := COUNT(GROUP,h.ocn_state_Invalid=2);
    ocn_state_Total_ErrorCount := COUNT(GROUP,h.ocn_state_Invalid>0);
    category_ALLOW_ErrorCount := COUNT(GROUP,h.category_Invalid=1);
    category_LENGTHS_ErrorCount := COUNT(GROUP,h.category_Invalid=2);
    category_Total_ErrorCount := COUNT(GROUP,h.category_Invalid>0);
    overall_ocn_ALLOW_ErrorCount := COUNT(GROUP,h.overall_ocn_Invalid=1);
    last_name_LENGTHS_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    first_name_LENGTHS_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    middle_initial_ALLOW_ErrorCount := COUNT(GROUP,h.middle_initial_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    postal_code_ALLOW_ErrorCount := COUNT(GROUP,h.postal_code_Invalid=1);
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    target_ocn_ALLOW_ErrorCount := COUNT(GROUP,h.target_ocn_Invalid=1);
    overall_target_ocn_ALLOW_ErrorCount := COUNT(GROUP,h.overall_target_ocn_Invalid=1);
    rural_lec_indicator_ALLOW_ErrorCount := COUNT(GROUP,h.rural_lec_indicator_Invalid=1);
    filename_ALLOW_ErrorCount := COUNT(GROUP,h.filename_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.ocn_Invalid > 0 OR h.ocn_name_Invalid > 0 OR h.ocn_abbr_name_Invalid > 0 OR h.ocn_state_Invalid > 0 OR h.category_Invalid > 0 OR h.overall_ocn_Invalid > 0 OR h.last_name_Invalid > 0 OR h.first_name_Invalid > 0 OR h.middle_initial_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.postal_code_Invalid > 0 OR h.phone_Invalid > 0 OR h.target_ocn_Invalid > 0 OR h.overall_target_ocn_Invalid > 0 OR h.rural_lec_indicator_Invalid > 0 OR h.filename_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.ocn_Total_ErrorCount > 0, 1, 0) + IF(le.ocn_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocn_abbr_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocn_state_Total_ErrorCount > 0, 1, 0) + IF(le.category_Total_ErrorCount > 0, 1, 0) + IF(le.overall_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.first_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.middle_initial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postal_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.target_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.overall_target_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rural_lec_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocn_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocn_abbr_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.ocn_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.ocn_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.category_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.overall_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.first_name_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.middle_initial_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.postal_code_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.target_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.overall_target_ocn_ALLOW_ErrorCount > 0, 1, 0) + IF(le.rural_lec_indicator_ALLOW_ErrorCount > 0, 1, 0) + IF(le.filename_ALLOW_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.ocn_Invalid,le.ocn_name_Invalid,le.ocn_abbr_name_Invalid,le.ocn_state_Invalid,le.category_Invalid,le.overall_ocn_Invalid,le.last_name_Invalid,le.first_name_Invalid,le.middle_initial_Invalid,le.city_Invalid,le.state_Invalid,le.postal_code_Invalid,le.phone_Invalid,le.target_ocn_Invalid,le.overall_target_ocn_Invalid,le.rural_lec_indicator_Invalid,le.filename_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Lerg1Raw_Fields.InvalidMessage_ocn(le.ocn_Invalid),Lerg1Raw_Fields.InvalidMessage_ocn_name(le.ocn_name_Invalid),Lerg1Raw_Fields.InvalidMessage_ocn_abbr_name(le.ocn_abbr_name_Invalid),Lerg1Raw_Fields.InvalidMessage_ocn_state(le.ocn_state_Invalid),Lerg1Raw_Fields.InvalidMessage_category(le.category_Invalid),Lerg1Raw_Fields.InvalidMessage_overall_ocn(le.overall_ocn_Invalid),Lerg1Raw_Fields.InvalidMessage_last_name(le.last_name_Invalid),Lerg1Raw_Fields.InvalidMessage_first_name(le.first_name_Invalid),Lerg1Raw_Fields.InvalidMessage_middle_initial(le.middle_initial_Invalid),Lerg1Raw_Fields.InvalidMessage_city(le.city_Invalid),Lerg1Raw_Fields.InvalidMessage_state(le.state_Invalid),Lerg1Raw_Fields.InvalidMessage_postal_code(le.postal_code_Invalid),Lerg1Raw_Fields.InvalidMessage_phone(le.phone_Invalid),Lerg1Raw_Fields.InvalidMessage_target_ocn(le.target_ocn_Invalid),Lerg1Raw_Fields.InvalidMessage_overall_target_ocn(le.overall_target_ocn_Invalid),Lerg1Raw_Fields.InvalidMessage_rural_lec_indicator(le.rural_lec_indicator_Invalid),Lerg1Raw_Fields.InvalidMessage_filename(le.filename_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.ocn_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.ocn_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ocn_abbr_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.ocn_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.category_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.overall_ocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'LENGTHS','UNKNOWN')
          ,CHOOSE(le.middle_initial_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.postal_code_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.phone_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.target_ocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.overall_target_ocn_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.rural_lec_indicator_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.filename_Invalid,'ALLOW','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'ocn','ocn_name','ocn_abbr_name','ocn_state','category','overall_ocn','last_name','first_name','middle_initial','city','state','postal_code','phone','target_ocn','overall_target_ocn','rural_lec_indicator','filename','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Ocn','Invalid_NotBlank','Invalid_NotBlank','Invalid_Ocn_State','Invalid_Category','Invalid_AlphaNum','Invalid_NotBlank','Invalid_NotBlank','Invalid_Alpha','Invalid_Char','Invalid_Alpha','Invalid_AlphaNum','Invalid_Phone','Invalid_AlphaNum','Invalid_AlphaNum','Invalid_Indicator','Invalid_Filename','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.ocn,(SALT311.StrType)le.ocn_name,(SALT311.StrType)le.ocn_abbr_name,(SALT311.StrType)le.ocn_state,(SALT311.StrType)le.category,(SALT311.StrType)le.overall_ocn,(SALT311.StrType)le.last_name,(SALT311.StrType)le.first_name,(SALT311.StrType)le.middle_initial,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.postal_code,(SALT311.StrType)le.phone,(SALT311.StrType)le.target_ocn,(SALT311.StrType)le.overall_target_ocn,(SALT311.StrType)le.rural_lec_indicator,(SALT311.StrType)le.filename,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Lerg1Raw_Layout_PhonesInfo) prevDS = DATASET([], Lerg1Raw_Layout_PhonesInfo), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.ocn_ALLOW_ErrorCount,le.ocn_LENGTHS_ErrorCount
          ,le.ocn_name_LENGTHS_ErrorCount
          ,le.ocn_abbr_name_LENGTHS_ErrorCount
          ,le.ocn_state_ALLOW_ErrorCount,le.ocn_state_LENGTHS_ErrorCount
          ,le.category_ALLOW_ErrorCount,le.category_LENGTHS_ErrorCount
          ,le.overall_ocn_ALLOW_ErrorCount
          ,le.last_name_LENGTHS_ErrorCount
          ,le.first_name_LENGTHS_ErrorCount
          ,le.middle_initial_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.postal_code_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.target_ocn_ALLOW_ErrorCount
          ,le.overall_target_ocn_ALLOW_ErrorCount
          ,le.rural_lec_indicator_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.ocn_ALLOW_ErrorCount,le.ocn_LENGTHS_ErrorCount
          ,le.ocn_name_LENGTHS_ErrorCount
          ,le.ocn_abbr_name_LENGTHS_ErrorCount
          ,le.ocn_state_ALLOW_ErrorCount,le.ocn_state_LENGTHS_ErrorCount
          ,le.category_ALLOW_ErrorCount,le.category_LENGTHS_ErrorCount
          ,le.overall_ocn_ALLOW_ErrorCount
          ,le.last_name_LENGTHS_ErrorCount
          ,le.first_name_LENGTHS_ErrorCount
          ,le.middle_initial_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount
          ,le.postal_code_ALLOW_ErrorCount
          ,le.phone_ALLOW_ErrorCount
          ,le.target_ocn_ALLOW_ErrorCount
          ,le.overall_target_ocn_ALLOW_ErrorCount
          ,le.rural_lec_indicator_ALLOW_ErrorCount
          ,le.filename_ALLOW_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := Lerg1Raw_hygiene(PROJECT(h, Lerg1Raw_Layout_PhonesInfo));
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
          ,'ocn:' + getFieldTypeText(h.ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn_name:' + getFieldTypeText(h.ocn_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn_abbr_name:' + getFieldTypeText(h.ocn_abbr_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'ocn_state:' + getFieldTypeText(h.ocn_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'category:' + getFieldTypeText(h.category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'overall_ocn:' + getFieldTypeText(h.overall_ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler1:' + getFieldTypeText(h.filler1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler2:' + getFieldTypeText(h.filler2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_initial:' + getFieldTypeText(h.middle_initial) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'company_name:' + getFieldTypeText(h.company_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address1:' + getFieldTypeText(h.address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'address2:' + getFieldTypeText(h.address2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'floor:' + getFieldTypeText(h.floor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'room:' + getFieldTypeText(h.room) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'postal_code:' + getFieldTypeText(h.postal_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'target_ocn:' + getFieldTypeText(h.target_ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'overall_target_ocn:' + getFieldTypeText(h.overall_target_ocn) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'rural_lec_indicator:' + getFieldTypeText(h.rural_lec_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'small_ilec_indicator:' + getFieldTypeText(h.small_ilec_indicator) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filename:' + getFieldTypeText(h.filename) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_ocn_cnt
          ,le.populated_ocn_name_cnt
          ,le.populated_ocn_abbr_name_cnt
          ,le.populated_ocn_state_cnt
          ,le.populated_category_cnt
          ,le.populated_overall_ocn_cnt
          ,le.populated_filler1_cnt
          ,le.populated_filler2_cnt
          ,le.populated_last_name_cnt
          ,le.populated_first_name_cnt
          ,le.populated_middle_initial_cnt
          ,le.populated_company_name_cnt
          ,le.populated_title_cnt
          ,le.populated_address1_cnt
          ,le.populated_address2_cnt
          ,le.populated_floor_cnt
          ,le.populated_room_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_postal_code_cnt
          ,le.populated_phone_cnt
          ,le.populated_target_ocn_cnt
          ,le.populated_overall_target_ocn_cnt
          ,le.populated_rural_lec_indicator_cnt
          ,le.populated_small_ilec_indicator_cnt
          ,le.populated_filename_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_ocn_pcnt
          ,le.populated_ocn_name_pcnt
          ,le.populated_ocn_abbr_name_pcnt
          ,le.populated_ocn_state_pcnt
          ,le.populated_category_pcnt
          ,le.populated_overall_ocn_pcnt
          ,le.populated_filler1_pcnt
          ,le.populated_filler2_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_middle_initial_pcnt
          ,le.populated_company_name_pcnt
          ,le.populated_title_pcnt
          ,le.populated_address1_pcnt
          ,le.populated_address2_pcnt
          ,le.populated_floor_pcnt
          ,le.populated_room_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_postal_code_pcnt
          ,le.populated_phone_pcnt
          ,le.populated_target_ocn_pcnt
          ,le.populated_overall_target_ocn_pcnt
          ,le.populated_rural_lec_indicator_pcnt
          ,le.populated_small_ilec_indicator_pcnt
          ,le.populated_filename_pcnt,0);
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
 
    mod_Delta := Lerg1Raw_Delta(prevDS, PROJECT(h, Lerg1Raw_Layout_PhonesInfo));
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
 
EXPORT StandardStats(DATASET(Lerg1Raw_Layout_PhonesInfo) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_PhonesInfo, Lerg1Raw_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
