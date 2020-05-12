IMPORT SALT311,STD;
IMPORT Scrubs_WorldCheck; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 23;
  EXPORT NumRulesFromFieldType := 23;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 22;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_WorldCheck)
    UNSIGNED1 uid_Invalid;
    UNSIGNED1 name_orig_Invalid;
    UNSIGNED1 name_type_Invalid;
    UNSIGNED1 last_name_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 category_Invalid;
    UNSIGNED1 title_Invalid;
    UNSIGNED1 sub_category_Invalid;
    UNSIGNED1 position_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 date_of_birth_Invalid;
    UNSIGNED1 places_of_birth_Invalid;
    UNSIGNED1 date_of_death_Invalid;
    UNSIGNED1 social_security_number_Invalid;
    UNSIGNED1 location_Invalid;
    UNSIGNED1 countries_Invalid;
    UNSIGNED1 e_i_ind_Invalid;
    UNSIGNED1 keywords_Invalid;
    UNSIGNED1 entered_Invalid;
    UNSIGNED1 updated_Invalid;
    UNSIGNED1 editor_Invalid;
    UNSIGNED1 age_as_of_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_WorldCheck)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(Layout_WorldCheck)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'uid:Invalid_No:ALLOW'
          ,'name_orig:Invalid_AlphaChar:CUSTOM'
          ,'name_type:Invalid_No:ALLOW'
          ,'last_name:Invalid_AlphaChar:CUSTOM'
          ,'first_name:Invalid_AlphaChar:CUSTOM'
          ,'category:Invalid_AlphaChar:CUSTOM'
          ,'title:Invalid_Alpha:ALLOW'
          ,'sub_category:Invalid_AlphaCaps:ALLOW'
          ,'position:Invalid_AlphaChar:CUSTOM'
          ,'age:Invalid_No:ALLOW'
          ,'date_of_birth:Invalid_Date:CUSTOM'
          ,'places_of_birth:Invalid_AlphaChar:CUSTOM'
          ,'date_of_death:Invalid_Date:CUSTOM'
          ,'social_security_number:Invalid_SSN:ALLOW','social_security_number:Invalid_SSN:LENGTHS'
          ,'location:Invalid_AlphaChar:CUSTOM'
          ,'countries:Invalid_AlphaChar:CUSTOM'
          ,'e_i_ind:Invalid_Ind:ENUM'
          ,'keywords:Invalid_Keywords:ALLOW'
          ,'entered:Invalid_Date:CUSTOM'
          ,'updated:Invalid_Date:CUSTOM'
          ,'editor:Invalid_AlphaChar:CUSTOM'
          ,'age_as_of_date:Invalid_Date:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,Fields.InvalidMessage_uid(1)
          ,Fields.InvalidMessage_name_orig(1)
          ,Fields.InvalidMessage_name_type(1)
          ,Fields.InvalidMessage_last_name(1)
          ,Fields.InvalidMessage_first_name(1)
          ,Fields.InvalidMessage_category(1)
          ,Fields.InvalidMessage_title(1)
          ,Fields.InvalidMessage_sub_category(1)
          ,Fields.InvalidMessage_position(1)
          ,Fields.InvalidMessage_age(1)
          ,Fields.InvalidMessage_date_of_birth(1)
          ,Fields.InvalidMessage_places_of_birth(1)
          ,Fields.InvalidMessage_date_of_death(1)
          ,Fields.InvalidMessage_social_security_number(1),Fields.InvalidMessage_social_security_number(2)
          ,Fields.InvalidMessage_location(1)
          ,Fields.InvalidMessage_countries(1)
          ,Fields.InvalidMessage_e_i_ind(1)
          ,Fields.InvalidMessage_keywords(1)
          ,Fields.InvalidMessage_entered(1)
          ,Fields.InvalidMessage_updated(1)
          ,Fields.InvalidMessage_editor(1)
          ,Fields.InvalidMessage_age_as_of_date(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(Layout_WorldCheck) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.uid_Invalid := Fields.InValid_uid((SALT311.StrType)le.uid);
    SELF.name_orig_Invalid := Fields.InValid_name_orig((SALT311.StrType)le.name_orig);
    SELF.name_type_Invalid := Fields.InValid_name_type((SALT311.StrType)le.name_type);
    SELF.last_name_Invalid := Fields.InValid_last_name((SALT311.StrType)le.last_name);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT311.StrType)le.first_name);
    SELF.category_Invalid := Fields.InValid_category((SALT311.StrType)le.category);
    SELF.title_Invalid := Fields.InValid_title((SALT311.StrType)le.title);
    SELF.sub_category_Invalid := Fields.InValid_sub_category((SALT311.StrType)le.sub_category);
    SELF.position_Invalid := Fields.InValid_position((SALT311.StrType)le.position);
    SELF.age_Invalid := Fields.InValid_age((SALT311.StrType)le.age);
    SELF.date_of_birth_Invalid := Fields.InValid_date_of_birth((SALT311.StrType)le.date_of_birth);
    SELF.places_of_birth_Invalid := Fields.InValid_places_of_birth((SALT311.StrType)le.places_of_birth);
    SELF.date_of_death_Invalid := Fields.InValid_date_of_death((SALT311.StrType)le.date_of_death);
    SELF.social_security_number_Invalid := Fields.InValid_social_security_number((SALT311.StrType)le.social_security_number);
    SELF.location_Invalid := Fields.InValid_location((SALT311.StrType)le.location);
    SELF.countries_Invalid := Fields.InValid_countries((SALT311.StrType)le.countries);
    SELF.e_i_ind_Invalid := Fields.InValid_e_i_ind((SALT311.StrType)le.e_i_ind);
    SELF.keywords_Invalid := Fields.InValid_keywords((SALT311.StrType)le.keywords);
    SELF.entered_Invalid := Fields.InValid_entered((SALT311.StrType)le.entered);
    SELF.updated_Invalid := Fields.InValid_updated((SALT311.StrType)le.updated);
    SELF.editor_Invalid := Fields.InValid_editor((SALT311.StrType)le.editor);
    SELF.age_as_of_date_Invalid := Fields.InValid_age_as_of_date((SALT311.StrType)le.age_as_of_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_WorldCheck);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.uid_Invalid << 0 ) + ( le.name_orig_Invalid << 1 ) + ( le.name_type_Invalid << 2 ) + ( le.last_name_Invalid << 3 ) + ( le.first_name_Invalid << 4 ) + ( le.category_Invalid << 5 ) + ( le.title_Invalid << 6 ) + ( le.sub_category_Invalid << 7 ) + ( le.position_Invalid << 8 ) + ( le.age_Invalid << 9 ) + ( le.date_of_birth_Invalid << 10 ) + ( le.places_of_birth_Invalid << 11 ) + ( le.date_of_death_Invalid << 12 ) + ( le.social_security_number_Invalid << 13 ) + ( le.location_Invalid << 15 ) + ( le.countries_Invalid << 16 ) + ( le.e_i_ind_Invalid << 17 ) + ( le.keywords_Invalid << 18 ) + ( le.entered_Invalid << 19 ) + ( le.updated_Invalid << 20 ) + ( le.editor_Invalid << 21 ) + ( le.age_as_of_date_Invalid << 22 );
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
  EXPORT Infile := PROJECT(h,Layout_WorldCheck);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.uid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.name_orig_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.name_type_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.last_name_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.category_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.title_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.sub_category_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.position_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.date_of_birth_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.places_of_birth_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.date_of_death_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.social_security_number_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.location_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.countries_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.e_i_ind_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.keywords_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.entered_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.updated_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.editor_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.age_as_of_date_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    uid_ALLOW_ErrorCount := COUNT(GROUP,h.uid_Invalid=1);
    name_orig_CUSTOM_ErrorCount := COUNT(GROUP,h.name_orig_Invalid=1);
    name_type_ALLOW_ErrorCount := COUNT(GROUP,h.name_type_Invalid=1);
    last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.last_name_Invalid=1);
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    category_CUSTOM_ErrorCount := COUNT(GROUP,h.category_Invalid=1);
    title_ALLOW_ErrorCount := COUNT(GROUP,h.title_Invalid=1);
    sub_category_ALLOW_ErrorCount := COUNT(GROUP,h.sub_category_Invalid=1);
    position_CUSTOM_ErrorCount := COUNT(GROUP,h.position_Invalid=1);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    date_of_birth_CUSTOM_ErrorCount := COUNT(GROUP,h.date_of_birth_Invalid=1);
    places_of_birth_CUSTOM_ErrorCount := COUNT(GROUP,h.places_of_birth_Invalid=1);
    date_of_death_CUSTOM_ErrorCount := COUNT(GROUP,h.date_of_death_Invalid=1);
    social_security_number_ALLOW_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=1);
    social_security_number_LENGTHS_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid=2);
    social_security_number_Total_ErrorCount := COUNT(GROUP,h.social_security_number_Invalid>0);
    location_CUSTOM_ErrorCount := COUNT(GROUP,h.location_Invalid=1);
    countries_CUSTOM_ErrorCount := COUNT(GROUP,h.countries_Invalid=1);
    e_i_ind_ENUM_ErrorCount := COUNT(GROUP,h.e_i_ind_Invalid=1);
    keywords_ALLOW_ErrorCount := COUNT(GROUP,h.keywords_Invalid=1);
    entered_CUSTOM_ErrorCount := COUNT(GROUP,h.entered_Invalid=1);
    updated_CUSTOM_ErrorCount := COUNT(GROUP,h.updated_Invalid=1);
    editor_CUSTOM_ErrorCount := COUNT(GROUP,h.editor_Invalid=1);
    age_as_of_date_CUSTOM_ErrorCount := COUNT(GROUP,h.age_as_of_date_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.uid_Invalid > 0 OR h.name_orig_Invalid > 0 OR h.name_type_Invalid > 0 OR h.last_name_Invalid > 0 OR h.first_name_Invalid > 0 OR h.category_Invalid > 0 OR h.title_Invalid > 0 OR h.sub_category_Invalid > 0 OR h.position_Invalid > 0 OR h.age_Invalid > 0 OR h.date_of_birth_Invalid > 0 OR h.places_of_birth_Invalid > 0 OR h.date_of_death_Invalid > 0 OR h.social_security_number_Invalid > 0 OR h.location_Invalid > 0 OR h.countries_Invalid > 0 OR h.e_i_ind_Invalid > 0 OR h.keywords_Invalid > 0 OR h.entered_Invalid > 0 OR h.updated_Invalid > 0 OR h.editor_Invalid > 0 OR h.age_as_of_date_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.uid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_orig_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.category_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sub_category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.position_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.places_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_death_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.social_security_number_Total_ErrorCount > 0, 1, 0) + IF(le.location_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.countries_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.e_i_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.keywords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entered_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.updated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.editor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.age_as_of_date_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.uid_ALLOW_ErrorCount > 0, 1, 0) + IF(le.name_orig_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.name_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.last_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.category_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.sub_category_ALLOW_ErrorCount > 0, 1, 0) + IF(le.position_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.age_ALLOW_ErrorCount > 0, 1, 0) + IF(le.date_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.places_of_birth_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.date_of_death_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.social_security_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.social_security_number_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.location_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.countries_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.e_i_ind_ENUM_ErrorCount > 0, 1, 0) + IF(le.keywords_ALLOW_ErrorCount > 0, 1, 0) + IF(le.entered_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.updated_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.editor_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.age_as_of_date_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.uid_Invalid,le.name_orig_Invalid,le.name_type_Invalid,le.last_name_Invalid,le.first_name_Invalid,le.category_Invalid,le.title_Invalid,le.sub_category_Invalid,le.position_Invalid,le.age_Invalid,le.date_of_birth_Invalid,le.places_of_birth_Invalid,le.date_of_death_Invalid,le.social_security_number_Invalid,le.location_Invalid,le.countries_Invalid,le.e_i_ind_Invalid,le.keywords_Invalid,le.entered_Invalid,le.updated_Invalid,le.editor_Invalid,le.age_as_of_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_uid(le.uid_Invalid),Fields.InvalidMessage_name_orig(le.name_orig_Invalid),Fields.InvalidMessage_name_type(le.name_type_Invalid),Fields.InvalidMessage_last_name(le.last_name_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_category(le.category_Invalid),Fields.InvalidMessage_title(le.title_Invalid),Fields.InvalidMessage_sub_category(le.sub_category_Invalid),Fields.InvalidMessage_position(le.position_Invalid),Fields.InvalidMessage_age(le.age_Invalid),Fields.InvalidMessage_date_of_birth(le.date_of_birth_Invalid),Fields.InvalidMessage_places_of_birth(le.places_of_birth_Invalid),Fields.InvalidMessage_date_of_death(le.date_of_death_Invalid),Fields.InvalidMessage_social_security_number(le.social_security_number_Invalid),Fields.InvalidMessage_location(le.location_Invalid),Fields.InvalidMessage_countries(le.countries_Invalid),Fields.InvalidMessage_e_i_ind(le.e_i_ind_Invalid),Fields.InvalidMessage_keywords(le.keywords_Invalid),Fields.InvalidMessage_entered(le.entered_Invalid),Fields.InvalidMessage_updated(le.updated_Invalid),Fields.InvalidMessage_editor(le.editor_Invalid),Fields.InvalidMessage_age_as_of_date(le.age_as_of_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.uid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_orig_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.name_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.category_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.title_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sub_category_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.position_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.date_of_birth_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.places_of_birth_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.date_of_death_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.social_security_number_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.location_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.countries_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.e_i_ind_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.keywords_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.entered_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.updated_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.editor_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.age_as_of_date_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'uid','name_orig','name_type','last_name','first_name','category','title','sub_category','position','age','date_of_birth','places_of_birth','date_of_death','social_security_number','location','countries','e_i_ind','keywords','entered','updated','editor','age_as_of_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_No','Invalid_AlphaChar','Invalid_No','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Alpha','Invalid_AlphaCaps','Invalid_AlphaChar','Invalid_No','Invalid_Date','Invalid_AlphaChar','Invalid_Date','Invalid_SSN','Invalid_AlphaChar','Invalid_AlphaChar','Invalid_Ind','Invalid_Keywords','Invalid_Date','Invalid_Date','Invalid_AlphaChar','Invalid_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.uid,(SALT311.StrType)le.name_orig,(SALT311.StrType)le.name_type,(SALT311.StrType)le.last_name,(SALT311.StrType)le.first_name,(SALT311.StrType)le.category,(SALT311.StrType)le.title,(SALT311.StrType)le.sub_category,(SALT311.StrType)le.position,(SALT311.StrType)le.age,(SALT311.StrType)le.date_of_birth,(SALT311.StrType)le.places_of_birth,(SALT311.StrType)le.date_of_death,(SALT311.StrType)le.social_security_number,(SALT311.StrType)le.location,(SALT311.StrType)le.countries,(SALT311.StrType)le.e_i_ind,(SALT311.StrType)le.keywords,(SALT311.StrType)le.entered,(SALT311.StrType)le.updated,(SALT311.StrType)le.editor,(SALT311.StrType)le.age_as_of_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_WorldCheck) prevDS = DATASET([], Layout_WorldCheck), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.uid_ALLOW_ErrorCount
          ,le.name_orig_CUSTOM_ErrorCount
          ,le.name_type_ALLOW_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.category_CUSTOM_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.sub_category_ALLOW_ErrorCount
          ,le.position_CUSTOM_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.date_of_birth_CUSTOM_ErrorCount
          ,le.places_of_birth_CUSTOM_ErrorCount
          ,le.date_of_death_CUSTOM_ErrorCount
          ,le.social_security_number_ALLOW_ErrorCount,le.social_security_number_LENGTHS_ErrorCount
          ,le.location_CUSTOM_ErrorCount
          ,le.countries_CUSTOM_ErrorCount
          ,le.e_i_ind_ENUM_ErrorCount
          ,le.keywords_ALLOW_ErrorCount
          ,le.entered_CUSTOM_ErrorCount
          ,le.updated_CUSTOM_ErrorCount
          ,le.editor_CUSTOM_ErrorCount
          ,le.age_as_of_date_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.uid_ALLOW_ErrorCount
          ,le.name_orig_CUSTOM_ErrorCount
          ,le.name_type_ALLOW_ErrorCount
          ,le.last_name_CUSTOM_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.category_CUSTOM_ErrorCount
          ,le.title_ALLOW_ErrorCount
          ,le.sub_category_ALLOW_ErrorCount
          ,le.position_CUSTOM_ErrorCount
          ,le.age_ALLOW_ErrorCount
          ,le.date_of_birth_CUSTOM_ErrorCount
          ,le.places_of_birth_CUSTOM_ErrorCount
          ,le.date_of_death_CUSTOM_ErrorCount
          ,le.social_security_number_ALLOW_ErrorCount,le.social_security_number_LENGTHS_ErrorCount
          ,le.location_CUSTOM_ErrorCount
          ,le.countries_CUSTOM_ErrorCount
          ,le.e_i_ind_ENUM_ErrorCount
          ,le.keywords_ALLOW_ErrorCount
          ,le.entered_CUSTOM_ErrorCount
          ,le.updated_CUSTOM_ErrorCount
          ,le.editor_CUSTOM_ErrorCount
          ,le.age_as_of_date_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_WorldCheck));
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
          ,'uid:' + getFieldTypeText(h.uid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'key:' + getFieldTypeText(h.key) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_orig:' + getFieldTypeText(h.name_orig) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'name_type:' + getFieldTypeText(h.name_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'category:' + getFieldTypeText(h.category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'title:' + getFieldTypeText(h.title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sub_category:' + getFieldTypeText(h.sub_category) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'position:' + getFieldTypeText(h.position) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'age:' + getFieldTypeText(h.age) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_birth:' + getFieldTypeText(h.date_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'places_of_birth:' + getFieldTypeText(h.places_of_birth) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'date_of_death:' + getFieldTypeText(h.date_of_death) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'passports:' + getFieldTypeText(h.passports) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'social_security_number:' + getFieldTypeText(h.social_security_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'location:' + getFieldTypeText(h.location) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'countries:' + getFieldTypeText(h.countries) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'e_i_ind:' + getFieldTypeText(h.e_i_ind) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'keywords:' + getFieldTypeText(h.keywords) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'entered:' + getFieldTypeText(h.entered) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'updated:' + getFieldTypeText(h.updated) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'editor:' + getFieldTypeText(h.editor) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'age_as_of_date:' + getFieldTypeText(h.age_as_of_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_uid_cnt
          ,le.populated_key_cnt
          ,le.populated_name_orig_cnt
          ,le.populated_name_type_cnt
          ,le.populated_last_name_cnt
          ,le.populated_first_name_cnt
          ,le.populated_category_cnt
          ,le.populated_title_cnt
          ,le.populated_sub_category_cnt
          ,le.populated_position_cnt
          ,le.populated_age_cnt
          ,le.populated_date_of_birth_cnt
          ,le.populated_places_of_birth_cnt
          ,le.populated_date_of_death_cnt
          ,le.populated_passports_cnt
          ,le.populated_social_security_number_cnt
          ,le.populated_location_cnt
          ,le.populated_countries_cnt
          ,le.populated_e_i_ind_cnt
          ,le.populated_keywords_cnt
          ,le.populated_entered_cnt
          ,le.populated_updated_cnt
          ,le.populated_editor_cnt
          ,le.populated_age_as_of_date_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_uid_pcnt
          ,le.populated_key_pcnt
          ,le.populated_name_orig_pcnt
          ,le.populated_name_type_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_category_pcnt
          ,le.populated_title_pcnt
          ,le.populated_sub_category_pcnt
          ,le.populated_position_pcnt
          ,le.populated_age_pcnt
          ,le.populated_date_of_birth_pcnt
          ,le.populated_places_of_birth_pcnt
          ,le.populated_date_of_death_pcnt
          ,le.populated_passports_pcnt
          ,le.populated_social_security_number_pcnt
          ,le.populated_location_pcnt
          ,le.populated_countries_pcnt
          ,le.populated_e_i_ind_pcnt
          ,le.populated_keywords_pcnt
          ,le.populated_entered_pcnt
          ,le.populated_updated_pcnt
          ,le.populated_editor_pcnt
          ,le.populated_age_as_of_date_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,24,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_WorldCheck));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),24,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_WorldCheck) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_WorldCheck, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
