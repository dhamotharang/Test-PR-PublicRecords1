IMPORT SALT311,STD;
EXPORT InfutorWP_Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 34;
  EXPORT NumRulesFromFieldType := 34;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 17;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(InfutorWP_Layout_CanadianPhones)
    UNSIGNED1 can_phone_Invalid;
    UNSIGNED1 can_title_Invalid;
    UNSIGNED1 can_fname_Invalid;
    UNSIGNED1 can_lname_Invalid;
    UNSIGNED1 can_suffix_Invalid;
    UNSIGNED1 can_address1_Invalid;
    UNSIGNED1 can_house_Invalid;
    UNSIGNED1 can_predir_Invalid;
    UNSIGNED1 can_street_Invalid;
    UNSIGNED1 can_strtype_Invalid;
    UNSIGNED1 can_postdir_Invalid;
    UNSIGNED1 can_apttype_Invalid;
    UNSIGNED1 can_aptnbr_Invalid;
    UNSIGNED1 can_city_Invalid;
    UNSIGNED1 can_province_Invalid;
    UNSIGNED1 can_postalcd_Invalid;
    UNSIGNED1 can_rectype_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(InfutorWP_Layout_CanadianPhones)
    UNSIGNED8 ScrubsBits1;
  END;
  EXPORT Rule_Layout := RECORD(InfutorWP_Layout_CanadianPhones)
    STRING Rules {MAXLENGTH(1000)};
  END;
  SHARED toRuleDesc(UNSIGNED c) := CHOOSE(c
          ,'can_phone:invalid_phone:ALLOW','can_phone:invalid_phone:LENGTHS'
          ,'can_title:invalid_alpha:ALLOW','can_title:invalid_alpha:LENGTHS'
          ,'can_fname:invalid_alpha:ALLOW','can_fname:invalid_alpha:LENGTHS'
          ,'can_lname:invalid_name:ALLOW','can_lname:invalid_name:LENGTHS'
          ,'can_suffix:invalid_alpha:ALLOW','can_suffix:invalid_alpha:LENGTHS'
          ,'can_address1:invalid_address:ALLOW','can_address1:invalid_address:LENGTHS'
          ,'can_house:invalid_address:ALLOW','can_house:invalid_address:LENGTHS'
          ,'can_predir:invalid_address:ALLOW','can_predir:invalid_address:LENGTHS'
          ,'can_street:invalid_address:ALLOW','can_street:invalid_address:LENGTHS'
          ,'can_strtype:invalid_address:ALLOW','can_strtype:invalid_address:LENGTHS'
          ,'can_postdir:invalid_address:ALLOW','can_postdir:invalid_address:LENGTHS'
          ,'can_apttype:invalid_address:ALLOW','can_apttype:invalid_address:LENGTHS'
          ,'can_aptnbr:invalid_address:ALLOW','can_aptnbr:invalid_address:LENGTHS'
          ,'can_city:invalid_city:ALLOW','can_city:invalid_city:LENGTHS'
          ,'can_province:invalid_province:ALLOW','can_province:invalid_province:LENGTHS'
          ,'can_postalcd:invalid_canadian_zip:ALLOW','can_postalcd:invalid_canadian_zip:LENGTHS'
          ,'can_rectype:invalid_record_type:ENUM','can_rectype:invalid_record_type:LENGTHS'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
  SHARED toErrorMessage(UNSIGNED c) := CHOOSE(c
          ,InfutorWP_Fields.InvalidMessage_can_phone(1),InfutorWP_Fields.InvalidMessage_can_phone(2)
          ,InfutorWP_Fields.InvalidMessage_can_title(1),InfutorWP_Fields.InvalidMessage_can_title(2)
          ,InfutorWP_Fields.InvalidMessage_can_fname(1),InfutorWP_Fields.InvalidMessage_can_fname(2)
          ,InfutorWP_Fields.InvalidMessage_can_lname(1),InfutorWP_Fields.InvalidMessage_can_lname(2)
          ,InfutorWP_Fields.InvalidMessage_can_suffix(1),InfutorWP_Fields.InvalidMessage_can_suffix(2)
          ,InfutorWP_Fields.InvalidMessage_can_address1(1),InfutorWP_Fields.InvalidMessage_can_address1(2)
          ,InfutorWP_Fields.InvalidMessage_can_house(1),InfutorWP_Fields.InvalidMessage_can_house(2)
          ,InfutorWP_Fields.InvalidMessage_can_predir(1),InfutorWP_Fields.InvalidMessage_can_predir(2)
          ,InfutorWP_Fields.InvalidMessage_can_street(1),InfutorWP_Fields.InvalidMessage_can_street(2)
          ,InfutorWP_Fields.InvalidMessage_can_strtype(1),InfutorWP_Fields.InvalidMessage_can_strtype(2)
          ,InfutorWP_Fields.InvalidMessage_can_postdir(1),InfutorWP_Fields.InvalidMessage_can_postdir(2)
          ,InfutorWP_Fields.InvalidMessage_can_apttype(1),InfutorWP_Fields.InvalidMessage_can_apttype(2)
          ,InfutorWP_Fields.InvalidMessage_can_aptnbr(1),InfutorWP_Fields.InvalidMessage_can_aptnbr(2)
          ,InfutorWP_Fields.InvalidMessage_can_city(1),InfutorWP_Fields.InvalidMessage_can_city(2)
          ,InfutorWP_Fields.InvalidMessage_can_province(1),InfutorWP_Fields.InvalidMessage_can_province(2)
          ,InfutorWP_Fields.InvalidMessage_can_postalcd(1),InfutorWP_Fields.InvalidMessage_can_postalcd(2)
          ,InfutorWP_Fields.InvalidMessage_can_rectype(1),InfutorWP_Fields.InvalidMessage_can_rectype(2)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
EXPORT FromNone(DATASET(InfutorWP_Layout_CanadianPhones) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.can_phone_Invalid := InfutorWP_Fields.InValid_can_phone((SALT311.StrType)le.can_phone);
    SELF.can_title_Invalid := InfutorWP_Fields.InValid_can_title((SALT311.StrType)le.can_title);
    SELF.can_fname_Invalid := InfutorWP_Fields.InValid_can_fname((SALT311.StrType)le.can_fname);
    SELF.can_lname_Invalid := InfutorWP_Fields.InValid_can_lname((SALT311.StrType)le.can_lname);
    SELF.can_suffix_Invalid := InfutorWP_Fields.InValid_can_suffix((SALT311.StrType)le.can_suffix);
    SELF.can_address1_Invalid := InfutorWP_Fields.InValid_can_address1((SALT311.StrType)le.can_address1);
    SELF.can_house_Invalid := InfutorWP_Fields.InValid_can_house((SALT311.StrType)le.can_house);
    SELF.can_predir_Invalid := InfutorWP_Fields.InValid_can_predir((SALT311.StrType)le.can_predir);
    SELF.can_street_Invalid := InfutorWP_Fields.InValid_can_street((SALT311.StrType)le.can_street);
    SELF.can_strtype_Invalid := InfutorWP_Fields.InValid_can_strtype((SALT311.StrType)le.can_strtype);
    SELF.can_postdir_Invalid := InfutorWP_Fields.InValid_can_postdir((SALT311.StrType)le.can_postdir);
    SELF.can_apttype_Invalid := InfutorWP_Fields.InValid_can_apttype((SALT311.StrType)le.can_apttype);
    SELF.can_aptnbr_Invalid := InfutorWP_Fields.InValid_can_aptnbr((SALT311.StrType)le.can_aptnbr);
    SELF.can_city_Invalid := InfutorWP_Fields.InValid_can_city((SALT311.StrType)le.can_city);
    SELF.can_province_Invalid := InfutorWP_Fields.InValid_can_province((SALT311.StrType)le.can_province);
    SELF.can_postalcd_Invalid := InfutorWP_Fields.InValid_can_postalcd((SALT311.StrType)le.can_postalcd);
    SELF.can_rectype_Invalid := InfutorWP_Fields.InValid_can_rectype((SALT311.StrType)le.can_rectype);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),InfutorWP_Layout_CanadianPhones);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.can_phone_Invalid << 0 ) + ( le.can_title_Invalid << 2 ) + ( le.can_fname_Invalid << 4 ) + ( le.can_lname_Invalid << 6 ) + ( le.can_suffix_Invalid << 8 ) + ( le.can_address1_Invalid << 10 ) + ( le.can_house_Invalid << 12 ) + ( le.can_predir_Invalid << 14 ) + ( le.can_street_Invalid << 16 ) + ( le.can_strtype_Invalid << 18 ) + ( le.can_postdir_Invalid << 20 ) + ( le.can_apttype_Invalid << 22 ) + ( le.can_aptnbr_Invalid << 24 ) + ( le.can_city_Invalid << 26 ) + ( le.can_province_Invalid << 28 ) + ( le.can_postalcd_Invalid << 30 ) + ( le.can_rectype_Invalid << 32 );
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
  EXPORT Infile := PROJECT(h,InfutorWP_Layout_CanadianPhones);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.can_phone_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.can_title_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.can_fname_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.can_lname_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.can_suffix_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.can_address1_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.can_house_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.can_predir_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.can_street_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.can_strtype_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.can_postdir_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.can_apttype_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.can_aptnbr_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.can_city_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.can_province_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.can_postalcd_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.can_rectype_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    can_phone_ALLOW_ErrorCount := COUNT(GROUP,h.can_phone_Invalid=1);
    can_phone_LENGTHS_ErrorCount := COUNT(GROUP,h.can_phone_Invalid=2);
    can_phone_Total_ErrorCount := COUNT(GROUP,h.can_phone_Invalid>0);
    can_title_ALLOW_ErrorCount := COUNT(GROUP,h.can_title_Invalid=1);
    can_title_LENGTHS_ErrorCount := COUNT(GROUP,h.can_title_Invalid=2);
    can_title_Total_ErrorCount := COUNT(GROUP,h.can_title_Invalid>0);
    can_fname_ALLOW_ErrorCount := COUNT(GROUP,h.can_fname_Invalid=1);
    can_fname_LENGTHS_ErrorCount := COUNT(GROUP,h.can_fname_Invalid=2);
    can_fname_Total_ErrorCount := COUNT(GROUP,h.can_fname_Invalid>0);
    can_lname_ALLOW_ErrorCount := COUNT(GROUP,h.can_lname_Invalid=1);
    can_lname_LENGTHS_ErrorCount := COUNT(GROUP,h.can_lname_Invalid=2);
    can_lname_Total_ErrorCount := COUNT(GROUP,h.can_lname_Invalid>0);
    can_suffix_ALLOW_ErrorCount := COUNT(GROUP,h.can_suffix_Invalid=1);
    can_suffix_LENGTHS_ErrorCount := COUNT(GROUP,h.can_suffix_Invalid=2);
    can_suffix_Total_ErrorCount := COUNT(GROUP,h.can_suffix_Invalid>0);
    can_address1_ALLOW_ErrorCount := COUNT(GROUP,h.can_address1_Invalid=1);
    can_address1_LENGTHS_ErrorCount := COUNT(GROUP,h.can_address1_Invalid=2);
    can_address1_Total_ErrorCount := COUNT(GROUP,h.can_address1_Invalid>0);
    can_house_ALLOW_ErrorCount := COUNT(GROUP,h.can_house_Invalid=1);
    can_house_LENGTHS_ErrorCount := COUNT(GROUP,h.can_house_Invalid=2);
    can_house_Total_ErrorCount := COUNT(GROUP,h.can_house_Invalid>0);
    can_predir_ALLOW_ErrorCount := COUNT(GROUP,h.can_predir_Invalid=1);
    can_predir_LENGTHS_ErrorCount := COUNT(GROUP,h.can_predir_Invalid=2);
    can_predir_Total_ErrorCount := COUNT(GROUP,h.can_predir_Invalid>0);
    can_street_ALLOW_ErrorCount := COUNT(GROUP,h.can_street_Invalid=1);
    can_street_LENGTHS_ErrorCount := COUNT(GROUP,h.can_street_Invalid=2);
    can_street_Total_ErrorCount := COUNT(GROUP,h.can_street_Invalid>0);
    can_strtype_ALLOW_ErrorCount := COUNT(GROUP,h.can_strtype_Invalid=1);
    can_strtype_LENGTHS_ErrorCount := COUNT(GROUP,h.can_strtype_Invalid=2);
    can_strtype_Total_ErrorCount := COUNT(GROUP,h.can_strtype_Invalid>0);
    can_postdir_ALLOW_ErrorCount := COUNT(GROUP,h.can_postdir_Invalid=1);
    can_postdir_LENGTHS_ErrorCount := COUNT(GROUP,h.can_postdir_Invalid=2);
    can_postdir_Total_ErrorCount := COUNT(GROUP,h.can_postdir_Invalid>0);
    can_apttype_ALLOW_ErrorCount := COUNT(GROUP,h.can_apttype_Invalid=1);
    can_apttype_LENGTHS_ErrorCount := COUNT(GROUP,h.can_apttype_Invalid=2);
    can_apttype_Total_ErrorCount := COUNT(GROUP,h.can_apttype_Invalid>0);
    can_aptnbr_ALLOW_ErrorCount := COUNT(GROUP,h.can_aptnbr_Invalid=1);
    can_aptnbr_LENGTHS_ErrorCount := COUNT(GROUP,h.can_aptnbr_Invalid=2);
    can_aptnbr_Total_ErrorCount := COUNT(GROUP,h.can_aptnbr_Invalid>0);
    can_city_ALLOW_ErrorCount := COUNT(GROUP,h.can_city_Invalid=1);
    can_city_LENGTHS_ErrorCount := COUNT(GROUP,h.can_city_Invalid=2);
    can_city_Total_ErrorCount := COUNT(GROUP,h.can_city_Invalid>0);
    can_province_ALLOW_ErrorCount := COUNT(GROUP,h.can_province_Invalid=1);
    can_province_LENGTHS_ErrorCount := COUNT(GROUP,h.can_province_Invalid=2);
    can_province_Total_ErrorCount := COUNT(GROUP,h.can_province_Invalid>0);
    can_postalcd_ALLOW_ErrorCount := COUNT(GROUP,h.can_postalcd_Invalid=1);
    can_postalcd_LENGTHS_ErrorCount := COUNT(GROUP,h.can_postalcd_Invalid=2);
    can_postalcd_Total_ErrorCount := COUNT(GROUP,h.can_postalcd_Invalid>0);
    can_rectype_ENUM_ErrorCount := COUNT(GROUP,h.can_rectype_Invalid=1);
    can_rectype_LENGTHS_ErrorCount := COUNT(GROUP,h.can_rectype_Invalid=2);
    can_rectype_Total_ErrorCount := COUNT(GROUP,h.can_rectype_Invalid>0);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.can_phone_Invalid > 0 OR h.can_title_Invalid > 0 OR h.can_fname_Invalid > 0 OR h.can_lname_Invalid > 0 OR h.can_suffix_Invalid > 0 OR h.can_address1_Invalid > 0 OR h.can_house_Invalid > 0 OR h.can_predir_Invalid > 0 OR h.can_street_Invalid > 0 OR h.can_strtype_Invalid > 0 OR h.can_postdir_Invalid > 0 OR h.can_apttype_Invalid > 0 OR h.can_aptnbr_Invalid > 0 OR h.can_city_Invalid > 0 OR h.can_province_Invalid > 0 OR h.can_postalcd_Invalid > 0 OR h.can_rectype_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.can_phone_Total_ErrorCount > 0, 1, 0) + IF(le.can_title_Total_ErrorCount > 0, 1, 0) + IF(le.can_fname_Total_ErrorCount > 0, 1, 0) + IF(le.can_lname_Total_ErrorCount > 0, 1, 0) + IF(le.can_suffix_Total_ErrorCount > 0, 1, 0) + IF(le.can_address1_Total_ErrorCount > 0, 1, 0) + IF(le.can_house_Total_ErrorCount > 0, 1, 0) + IF(le.can_predir_Total_ErrorCount > 0, 1, 0) + IF(le.can_street_Total_ErrorCount > 0, 1, 0) + IF(le.can_strtype_Total_ErrorCount > 0, 1, 0) + IF(le.can_postdir_Total_ErrorCount > 0, 1, 0) + IF(le.can_apttype_Total_ErrorCount > 0, 1, 0) + IF(le.can_aptnbr_Total_ErrorCount > 0, 1, 0) + IF(le.can_city_Total_ErrorCount > 0, 1, 0) + IF(le.can_province_Total_ErrorCount > 0, 1, 0) + IF(le.can_postalcd_Total_ErrorCount > 0, 1, 0) + IF(le.can_rectype_Total_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.can_phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_title_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_title_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_fname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_fname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_lname_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_lname_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_suffix_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_suffix_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_address1_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_address1_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_house_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_house_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_predir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_predir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_street_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_street_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_strtype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_strtype_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_postdir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_postdir_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_apttype_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_apttype_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_aptnbr_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_aptnbr_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_city_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_province_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_province_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_postalcd_ALLOW_ErrorCount > 0, 1, 0) + IF(le.can_postalcd_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.can_rectype_ENUM_ErrorCount > 0, 1, 0) + IF(le.can_rectype_LENGTHS_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.can_phone_Invalid,le.can_title_Invalid,le.can_fname_Invalid,le.can_lname_Invalid,le.can_suffix_Invalid,le.can_address1_Invalid,le.can_house_Invalid,le.can_predir_Invalid,le.can_street_Invalid,le.can_strtype_Invalid,le.can_postdir_Invalid,le.can_apttype_Invalid,le.can_aptnbr_Invalid,le.can_city_Invalid,le.can_province_Invalid,le.can_postalcd_Invalid,le.can_rectype_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,InfutorWP_Fields.InvalidMessage_can_phone(le.can_phone_Invalid),InfutorWP_Fields.InvalidMessage_can_title(le.can_title_Invalid),InfutorWP_Fields.InvalidMessage_can_fname(le.can_fname_Invalid),InfutorWP_Fields.InvalidMessage_can_lname(le.can_lname_Invalid),InfutorWP_Fields.InvalidMessage_can_suffix(le.can_suffix_Invalid),InfutorWP_Fields.InvalidMessage_can_address1(le.can_address1_Invalid),InfutorWP_Fields.InvalidMessage_can_house(le.can_house_Invalid),InfutorWP_Fields.InvalidMessage_can_predir(le.can_predir_Invalid),InfutorWP_Fields.InvalidMessage_can_street(le.can_street_Invalid),InfutorWP_Fields.InvalidMessage_can_strtype(le.can_strtype_Invalid),InfutorWP_Fields.InvalidMessage_can_postdir(le.can_postdir_Invalid),InfutorWP_Fields.InvalidMessage_can_apttype(le.can_apttype_Invalid),InfutorWP_Fields.InvalidMessage_can_aptnbr(le.can_aptnbr_Invalid),InfutorWP_Fields.InvalidMessage_can_city(le.can_city_Invalid),InfutorWP_Fields.InvalidMessage_can_province(le.can_province_Invalid),InfutorWP_Fields.InvalidMessage_can_postalcd(le.can_postalcd_Invalid),InfutorWP_Fields.InvalidMessage_can_rectype(le.can_rectype_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.can_phone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_title_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_fname_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_lname_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_suffix_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_address1_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_house_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_predir_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_street_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_strtype_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_postdir_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_apttype_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_aptnbr_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_city_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_province_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_postalcd_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.can_rectype_Invalid,'ENUM','LENGTHS','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'can_phone','can_title','can_fname','can_lname','can_suffix','can_address1','can_house','can_predir','can_street','can_strtype','can_postdir','can_apttype','can_aptnbr','can_city','can_province','can_postalcd','can_rectype','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_phone','invalid_alpha','invalid_alpha','invalid_name','invalid_alpha','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_address','invalid_city','invalid_province','invalid_canadian_zip','invalid_record_type','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.can_phone,(SALT311.StrType)le.can_title,(SALT311.StrType)le.can_fname,(SALT311.StrType)le.can_lname,(SALT311.StrType)le.can_suffix,(SALT311.StrType)le.can_address1,(SALT311.StrType)le.can_house,(SALT311.StrType)le.can_predir,(SALT311.StrType)le.can_street,(SALT311.StrType)le.can_strtype,(SALT311.StrType)le.can_postdir,(SALT311.StrType)le.can_apttype,(SALT311.StrType)le.can_aptnbr,(SALT311.StrType)le.can_city,(SALT311.StrType)le.can_province,(SALT311.StrType)le.can_postalcd,(SALT311.StrType)le.can_rectype,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,17,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(InfutorWP_Layout_CanadianPhones) prevDS = DATASET([], InfutorWP_Layout_CanadianPhones), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := toRuleDesc(c);
      SELF.ErrorMessage := toErrorMessage(c);
      SELF.rulecnt := CHOOSE(c
          ,le.can_phone_ALLOW_ErrorCount,le.can_phone_LENGTHS_ErrorCount
          ,le.can_title_ALLOW_ErrorCount,le.can_title_LENGTHS_ErrorCount
          ,le.can_fname_ALLOW_ErrorCount,le.can_fname_LENGTHS_ErrorCount
          ,le.can_lname_ALLOW_ErrorCount,le.can_lname_LENGTHS_ErrorCount
          ,le.can_suffix_ALLOW_ErrorCount,le.can_suffix_LENGTHS_ErrorCount
          ,le.can_address1_ALLOW_ErrorCount,le.can_address1_LENGTHS_ErrorCount
          ,le.can_house_ALLOW_ErrorCount,le.can_house_LENGTHS_ErrorCount
          ,le.can_predir_ALLOW_ErrorCount,le.can_predir_LENGTHS_ErrorCount
          ,le.can_street_ALLOW_ErrorCount,le.can_street_LENGTHS_ErrorCount
          ,le.can_strtype_ALLOW_ErrorCount,le.can_strtype_LENGTHS_ErrorCount
          ,le.can_postdir_ALLOW_ErrorCount,le.can_postdir_LENGTHS_ErrorCount
          ,le.can_apttype_ALLOW_ErrorCount,le.can_apttype_LENGTHS_ErrorCount
          ,le.can_aptnbr_ALLOW_ErrorCount,le.can_aptnbr_LENGTHS_ErrorCount
          ,le.can_city_ALLOW_ErrorCount,le.can_city_LENGTHS_ErrorCount
          ,le.can_province_ALLOW_ErrorCount,le.can_province_LENGTHS_ErrorCount
          ,le.can_postalcd_ALLOW_ErrorCount,le.can_postalcd_LENGTHS_ErrorCount
          ,le.can_rectype_ENUM_ErrorCount,le.can_rectype_LENGTHS_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.can_phone_ALLOW_ErrorCount,le.can_phone_LENGTHS_ErrorCount
          ,le.can_title_ALLOW_ErrorCount,le.can_title_LENGTHS_ErrorCount
          ,le.can_fname_ALLOW_ErrorCount,le.can_fname_LENGTHS_ErrorCount
          ,le.can_lname_ALLOW_ErrorCount,le.can_lname_LENGTHS_ErrorCount
          ,le.can_suffix_ALLOW_ErrorCount,le.can_suffix_LENGTHS_ErrorCount
          ,le.can_address1_ALLOW_ErrorCount,le.can_address1_LENGTHS_ErrorCount
          ,le.can_house_ALLOW_ErrorCount,le.can_house_LENGTHS_ErrorCount
          ,le.can_predir_ALLOW_ErrorCount,le.can_predir_LENGTHS_ErrorCount
          ,le.can_street_ALLOW_ErrorCount,le.can_street_LENGTHS_ErrorCount
          ,le.can_strtype_ALLOW_ErrorCount,le.can_strtype_LENGTHS_ErrorCount
          ,le.can_postdir_ALLOW_ErrorCount,le.can_postdir_LENGTHS_ErrorCount
          ,le.can_apttype_ALLOW_ErrorCount,le.can_apttype_LENGTHS_ErrorCount
          ,le.can_aptnbr_ALLOW_ErrorCount,le.can_aptnbr_LENGTHS_ErrorCount
          ,le.can_city_ALLOW_ErrorCount,le.can_city_LENGTHS_ErrorCount
          ,le.can_province_ALLOW_ErrorCount,le.can_province_LENGTHS_ErrorCount
          ,le.can_postalcd_ALLOW_ErrorCount,le.can_postalcd_LENGTHS_ErrorCount
          ,le.can_rectype_ENUM_ErrorCount,le.can_rectype_LENGTHS_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := InfutorWP_hygiene(PROJECT(h, InfutorWP_Layout_CanadianPhones));
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
          ,'can_phone:' + getFieldTypeText(h.can_phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_title:' + getFieldTypeText(h.can_title) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_fname:' + getFieldTypeText(h.can_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_lname:' + getFieldTypeText(h.can_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_suffix:' + getFieldTypeText(h.can_suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_address1:' + getFieldTypeText(h.can_address1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_house:' + getFieldTypeText(h.can_house) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_predir:' + getFieldTypeText(h.can_predir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_street:' + getFieldTypeText(h.can_street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_strtype:' + getFieldTypeText(h.can_strtype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_postdir:' + getFieldTypeText(h.can_postdir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_apttype:' + getFieldTypeText(h.can_apttype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_aptnbr:' + getFieldTypeText(h.can_aptnbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_city:' + getFieldTypeText(h.can_city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_province:' + getFieldTypeText(h.can_province) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_postalcd:' + getFieldTypeText(h.can_postalcd) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_lang:' + getFieldTypeText(h.can_lang) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'can_rectype:' + getFieldTypeText(h.can_rectype) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_can_phone_cnt
          ,le.populated_can_title_cnt
          ,le.populated_can_fname_cnt
          ,le.populated_can_lname_cnt
          ,le.populated_can_suffix_cnt
          ,le.populated_can_address1_cnt
          ,le.populated_can_house_cnt
          ,le.populated_can_predir_cnt
          ,le.populated_can_street_cnt
          ,le.populated_can_strtype_cnt
          ,le.populated_can_postdir_cnt
          ,le.populated_can_apttype_cnt
          ,le.populated_can_aptnbr_cnt
          ,le.populated_can_city_cnt
          ,le.populated_can_province_cnt
          ,le.populated_can_postalcd_cnt
          ,le.populated_can_lang_cnt
          ,le.populated_can_rectype_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_can_phone_pcnt
          ,le.populated_can_title_pcnt
          ,le.populated_can_fname_pcnt
          ,le.populated_can_lname_pcnt
          ,le.populated_can_suffix_pcnt
          ,le.populated_can_address1_pcnt
          ,le.populated_can_house_pcnt
          ,le.populated_can_predir_pcnt
          ,le.populated_can_street_pcnt
          ,le.populated_can_strtype_pcnt
          ,le.populated_can_postdir_pcnt
          ,le.populated_can_apttype_pcnt
          ,le.populated_can_aptnbr_pcnt
          ,le.populated_can_city_pcnt
          ,le.populated_can_province_pcnt
          ,le.populated_can_postalcd_pcnt
          ,le.populated_can_lang_pcnt
          ,le.populated_can_rectype_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,18,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := InfutorWP_Delta(prevDS, PROJECT(h, InfutorWP_Layout_CanadianPhones));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),18,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(InfutorWP_Layout_CanadianPhones) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_CanadianPhones, InfutorWP_Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
