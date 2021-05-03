IMPORT SALT311,STD;
IMPORT Scrubs,Scrubs_DL_OH; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 26;
  EXPORT NumRulesFromFieldType := 26;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 22;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_In_oh)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 key_number_Invalid;
    UNSIGNED1 license_number_Invalid;
    UNSIGNED1 license_class_Invalid;
    UNSIGNED1 donor_flag_Invalid;
    UNSIGNED1 hair_color_Invalid;
    UNSIGNED1 eye_color_Invalid;
    UNSIGNED1 weight_l_Invalid;
    UNSIGNED1 height_feet_Invalid;
    UNSIGNED1 sex_gender_Invalid;
    UNSIGNED1 permanent_license_issue_date_Invalid;
    UNSIGNED1 license_expiration_date_Invalid;
    UNSIGNED1 restriction_codes_Invalid;
    UNSIGNED1 endorsement_codes_Invalid;
    UNSIGNED1 first_name_Invalid;
    UNSIGNED1 street_address_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_code_Invalid;
    UNSIGNED1 county_number_Invalid;
    UNSIGNED1 birth_date_Invalid;
    UNSIGNED1 clean_fname_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_oh)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_oh) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT311.StrType)le.process_date);
    SELF.key_number_Invalid := Fields.InValid_key_number((SALT311.StrType)le.key_number);
    SELF.license_number_Invalid := Fields.InValid_license_number((SALT311.StrType)le.license_number);
    SELF.license_class_Invalid := Fields.InValid_license_class((SALT311.StrType)le.license_class);
    SELF.donor_flag_Invalid := Fields.InValid_donor_flag((SALT311.StrType)le.donor_flag);
    SELF.hair_color_Invalid := Fields.InValid_hair_color((SALT311.StrType)le.hair_color);
    SELF.eye_color_Invalid := Fields.InValid_eye_color((SALT311.StrType)le.eye_color);
    SELF.weight_l_Invalid := Fields.InValid_weight_l((SALT311.StrType)le.weight_l);
    SELF.height_feet_Invalid := Fields.InValid_height_feet((SALT311.StrType)le.height_feet,(SALT311.StrType)le.height_inches);
    SELF.sex_gender_Invalid := Fields.InValid_sex_gender((SALT311.StrType)le.sex_gender);
    SELF.permanent_license_issue_date_Invalid := Fields.InValid_permanent_license_issue_date((SALT311.StrType)le.permanent_license_issue_date);
    SELF.license_expiration_date_Invalid := Fields.InValid_license_expiration_date((SALT311.StrType)le.license_expiration_date);
    SELF.restriction_codes_Invalid := Fields.InValid_restriction_codes((SALT311.StrType)le.restriction_codes);
    SELF.endorsement_codes_Invalid := Fields.InValid_endorsement_codes((SALT311.StrType)le.endorsement_codes);
    SELF.first_name_Invalid := Fields.InValid_first_name((SALT311.StrType)le.first_name,(SALT311.StrType)le.middle_name,(SALT311.StrType)le.last_name);
    SELF.street_address_Invalid := Fields.InValid_street_address((SALT311.StrType)le.street_address);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.zip_code_Invalid := Fields.InValid_zip_code((SALT311.StrType)le.zip_code);
    SELF.county_number_Invalid := Fields.InValid_county_number((SALT311.StrType)le.county_number);
    SELF.birth_date_Invalid := Fields.InValid_birth_date((SALT311.StrType)le.birth_date);
    SELF.clean_fname_Invalid := Fields.InValid_clean_fname((SALT311.StrType)le.clean_fname,(SALT311.StrType)le.clean_mname,(SALT311.StrType)le.clean_lname);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_oh);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.key_number_Invalid << 2 ) + ( le.license_number_Invalid << 3 ) + ( le.license_class_Invalid << 4 ) + ( le.donor_flag_Invalid << 5 ) + ( le.hair_color_Invalid << 6 ) + ( le.eye_color_Invalid << 7 ) + ( le.weight_l_Invalid << 8 ) + ( le.height_feet_Invalid << 9 ) + ( le.sex_gender_Invalid << 10 ) + ( le.permanent_license_issue_date_Invalid << 11 ) + ( le.license_expiration_date_Invalid << 13 ) + ( le.restriction_codes_Invalid << 15 ) + ( le.endorsement_codes_Invalid << 16 ) + ( le.first_name_Invalid << 17 ) + ( le.street_address_Invalid << 18 ) + ( le.city_Invalid << 19 ) + ( le.state_Invalid << 20 ) + ( le.zip_code_Invalid << 21 ) + ( le.county_number_Invalid << 22 ) + ( le.birth_date_Invalid << 23 ) + ( le.clean_fname_Invalid << 25 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_oh);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.key_number_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.license_number_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.license_class_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.donor_flag_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.hair_color_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.eye_color_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.weight_l_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.height_feet_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.sex_gender_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.permanent_license_issue_date_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.license_expiration_date_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.restriction_codes_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.endorsement_codes_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.first_name_Invalid := (le.ScrubsBits1 >> 17) & 1;
    SELF.street_address_Invalid := (le.ScrubsBits1 >> 18) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.zip_code_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.county_number_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.birth_date_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.clean_fname_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTHS_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    key_number_CUSTOM_ErrorCount := COUNT(GROUP,h.key_number_Invalid=1);
    license_number_CUSTOM_ErrorCount := COUNT(GROUP,h.license_number_Invalid=1);
    license_class_ENUM_ErrorCount := COUNT(GROUP,h.license_class_Invalid=1);
    donor_flag_ENUM_ErrorCount := COUNT(GROUP,h.donor_flag_Invalid=1);
    hair_color_CUSTOM_ErrorCount := COUNT(GROUP,h.hair_color_Invalid=1);
    eye_color_CUSTOM_ErrorCount := COUNT(GROUP,h.eye_color_Invalid=1);
    weight_l_CUSTOM_ErrorCount := COUNT(GROUP,h.weight_l_Invalid=1);
    height_feet_CUSTOM_ErrorCount := COUNT(GROUP,h.height_feet_Invalid=1);
    sex_gender_ENUM_ErrorCount := COUNT(GROUP,h.sex_gender_Invalid=1);
    permanent_license_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.permanent_license_issue_date_Invalid=1);
    permanent_license_issue_date_LENGTHS_ErrorCount := COUNT(GROUP,h.permanent_license_issue_date_Invalid=2);
    permanent_license_issue_date_Total_ErrorCount := COUNT(GROUP,h.permanent_license_issue_date_Invalid>0);
    license_expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.license_expiration_date_Invalid=1);
    license_expiration_date_LENGTHS_ErrorCount := COUNT(GROUP,h.license_expiration_date_Invalid=2);
    license_expiration_date_Total_ErrorCount := COUNT(GROUP,h.license_expiration_date_Invalid>0);
    restriction_codes_ALLOW_ErrorCount := COUNT(GROUP,h.restriction_codes_Invalid=1);
    endorsement_codes_ALLOW_ErrorCount := COUNT(GROUP,h.endorsement_codes_Invalid=1);
    first_name_CUSTOM_ErrorCount := COUNT(GROUP,h.first_name_Invalid=1);
    street_address_ALLOW_ErrorCount := COUNT(GROUP,h.street_address_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_CUSTOM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    zip_code_CUSTOM_ErrorCount := COUNT(GROUP,h.zip_code_Invalid=1);
    county_number_ALLOW_ErrorCount := COUNT(GROUP,h.county_number_Invalid=1);
    birth_date_CUSTOM_ErrorCount := COUNT(GROUP,h.birth_date_Invalid=1);
    birth_date_LENGTHS_ErrorCount := COUNT(GROUP,h.birth_date_Invalid=2);
    birth_date_Total_ErrorCount := COUNT(GROUP,h.birth_date_Invalid>0);
    clean_fname_CUSTOM_ErrorCount := COUNT(GROUP,h.clean_fname_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.process_date_Invalid > 0 OR h.key_number_Invalid > 0 OR h.license_number_Invalid > 0 OR h.license_class_Invalid > 0 OR h.donor_flag_Invalid > 0 OR h.hair_color_Invalid > 0 OR h.eye_color_Invalid > 0 OR h.weight_l_Invalid > 0 OR h.height_feet_Invalid > 0 OR h.sex_gender_Invalid > 0 OR h.permanent_license_issue_date_Invalid > 0 OR h.license_expiration_date_Invalid > 0 OR h.restriction_codes_Invalid > 0 OR h.endorsement_codes_Invalid > 0 OR h.first_name_Invalid > 0 OR h.street_address_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.zip_code_Invalid > 0 OR h.county_number_Invalid > 0 OR h.birth_date_Invalid > 0 OR h.clean_fname_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.process_date_Total_ErrorCount > 0, 1, 0) + IF(le.key_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_class_ENUM_ErrorCount > 0, 1, 0) + IF(le.donor_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.hair_color_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eye_color_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.weight_l_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.height_feet_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sex_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.permanent_license_issue_date_Total_ErrorCount > 0, 1, 0) + IF(le.license_expiration_date_Total_ErrorCount > 0, 1, 0) + IF(le.restriction_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.endorsement_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.birth_date_Total_ErrorCount > 0, 1, 0) + IF(le.clean_fname_CUSTOM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.process_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.process_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.key_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_number_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_class_ENUM_ErrorCount > 0, 1, 0) + IF(le.donor_flag_ENUM_ErrorCount > 0, 1, 0) + IF(le.hair_color_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.eye_color_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.weight_l_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.height_feet_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.sex_gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.permanent_license_issue_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.permanent_license_issue_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.license_expiration_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.license_expiration_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.restriction_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.endorsement_codes_ALLOW_ErrorCount > 0, 1, 0) + IF(le.first_name_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.street_address_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.zip_code_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.county_number_ALLOW_ErrorCount > 0, 1, 0) + IF(le.birth_date_CUSTOM_ErrorCount > 0, 1, 0) + IF(le.birth_date_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.clean_fname_CUSTOM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.key_number_Invalid,le.license_number_Invalid,le.license_class_Invalid,le.donor_flag_Invalid,le.hair_color_Invalid,le.eye_color_Invalid,le.weight_l_Invalid,le.height_feet_Invalid,le.sex_gender_Invalid,le.permanent_license_issue_date_Invalid,le.license_expiration_date_Invalid,le.restriction_codes_Invalid,le.endorsement_codes_Invalid,le.first_name_Invalid,le.street_address_Invalid,le.city_Invalid,le.state_Invalid,le.zip_code_Invalid,le.county_number_Invalid,le.birth_date_Invalid,le.clean_fname_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_key_number(le.key_number_Invalid),Fields.InvalidMessage_license_number(le.license_number_Invalid),Fields.InvalidMessage_license_class(le.license_class_Invalid),Fields.InvalidMessage_donor_flag(le.donor_flag_Invalid),Fields.InvalidMessage_hair_color(le.hair_color_Invalid),Fields.InvalidMessage_eye_color(le.eye_color_Invalid),Fields.InvalidMessage_weight_l(le.weight_l_Invalid),Fields.InvalidMessage_height_feet(le.height_feet_Invalid),Fields.InvalidMessage_sex_gender(le.sex_gender_Invalid),Fields.InvalidMessage_permanent_license_issue_date(le.permanent_license_issue_date_Invalid),Fields.InvalidMessage_license_expiration_date(le.license_expiration_date_Invalid),Fields.InvalidMessage_restriction_codes(le.restriction_codes_Invalid),Fields.InvalidMessage_endorsement_codes(le.endorsement_codes_Invalid),Fields.InvalidMessage_first_name(le.first_name_Invalid),Fields.InvalidMessage_street_address(le.street_address_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip_code(le.zip_code_Invalid),Fields.InvalidMessage_county_number(le.county_number_Invalid),Fields.InvalidMessage_birth_date(le.birth_date_Invalid),Fields.InvalidMessage_clean_fname(le.clean_fname_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.key_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_number_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_class_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.donor_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.hair_color_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.eye_color_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.weight_l_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.height_feet_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sex_gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.permanent_license_issue_date_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.license_expiration_date_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.restriction_codes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.endorsement_codes_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.first_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.street_address_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.zip_code_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.county_number_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.birth_date_Invalid,'CUSTOM','LENGTHS','UNKNOWN')
          ,CHOOSE(le.clean_fname_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','key_number','license_number','license_class','donor_flag','hair_color','eye_color','weight_l','height_feet','sex_gender','permanent_license_issue_date','license_expiration_date','restriction_codes','endorsement_codes','first_name','street_address','city','state','zip_code','county_number','birth_date','clean_fname','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_dl_number_check','invalid_dl_number_check','invalid_license_class','invalid_donor_flag','invalid_hair_color','invalid_eye_color','invalid_wgt','invalid_height','invalid_gender','invalid_8pastdate','invalid_8generaldate','invalid_restrictions','invalid_endorsements','invalid_name','invalid_street','invalid_city','invalid_state','invalid_zip','invalid_numeric','invalid_8pastdate','invalid_clean_name','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.process_date,(SALT311.StrType)le.key_number,(SALT311.StrType)le.license_number,(SALT311.StrType)le.license_class,(SALT311.StrType)le.donor_flag,(SALT311.StrType)le.hair_color,(SALT311.StrType)le.eye_color,(SALT311.StrType)le.weight_l,(SALT311.StrType)le.height_feet,(SALT311.StrType)le.sex_gender,(SALT311.StrType)le.permanent_license_issue_date,(SALT311.StrType)le.license_expiration_date,(SALT311.StrType)le.restriction_codes,(SALT311.StrType)le.endorsement_codes,(SALT311.StrType)le.first_name,(SALT311.StrType)le.street_address,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.zip_code,(SALT311.StrType)le.county_number,(SALT311.StrType)le.birth_date,(SALT311.StrType)le.clean_fname,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_In_oh) prevDS = DATASET([], Layout_In_oh), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_8pastdate:CUSTOM','process_date:invalid_8pastdate:LENGTHS'
          ,'key_number:invalid_dl_number_check:CUSTOM'
          ,'license_number:invalid_dl_number_check:CUSTOM'
          ,'license_class:invalid_license_class:ENUM'
          ,'donor_flag:invalid_donor_flag:ENUM'
          ,'hair_color:invalid_hair_color:CUSTOM'
          ,'eye_color:invalid_eye_color:CUSTOM'
          ,'weight_l:invalid_wgt:CUSTOM'
          ,'height_feet:invalid_height:CUSTOM'
          ,'sex_gender:invalid_gender:ENUM'
          ,'permanent_license_issue_date:invalid_8pastdate:CUSTOM','permanent_license_issue_date:invalid_8pastdate:LENGTHS'
          ,'license_expiration_date:invalid_8generaldate:CUSTOM','license_expiration_date:invalid_8generaldate:LENGTHS'
          ,'restriction_codes:invalid_restrictions:ALLOW'
          ,'endorsement_codes:invalid_endorsements:ALLOW'
          ,'first_name:invalid_name:CUSTOM'
          ,'street_address:invalid_street:ALLOW'
          ,'city:invalid_city:ALLOW'
          ,'state:invalid_state:CUSTOM'
          ,'zip_code:invalid_zip:CUSTOM'
          ,'county_number:invalid_numeric:ALLOW'
          ,'birth_date:invalid_8pastdate:CUSTOM','birth_date:invalid_8pastdate:LENGTHS'
          ,'clean_fname:invalid_clean_name:CUSTOM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_key_number(1)
          ,Fields.InvalidMessage_license_number(1)
          ,Fields.InvalidMessage_license_class(1)
          ,Fields.InvalidMessage_donor_flag(1)
          ,Fields.InvalidMessage_hair_color(1)
          ,Fields.InvalidMessage_eye_color(1)
          ,Fields.InvalidMessage_weight_l(1)
          ,Fields.InvalidMessage_height_feet(1)
          ,Fields.InvalidMessage_sex_gender(1)
          ,Fields.InvalidMessage_permanent_license_issue_date(1),Fields.InvalidMessage_permanent_license_issue_date(2)
          ,Fields.InvalidMessage_license_expiration_date(1),Fields.InvalidMessage_license_expiration_date(2)
          ,Fields.InvalidMessage_restriction_codes(1)
          ,Fields.InvalidMessage_endorsement_codes(1)
          ,Fields.InvalidMessage_first_name(1)
          ,Fields.InvalidMessage_street_address(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1)
          ,Fields.InvalidMessage_zip_code(1)
          ,Fields.InvalidMessage_county_number(1)
          ,Fields.InvalidMessage_birth_date(1),Fields.InvalidMessage_birth_date(2)
          ,Fields.InvalidMessage_clean_fname(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.key_number_CUSTOM_ErrorCount
          ,le.license_number_CUSTOM_ErrorCount
          ,le.license_class_ENUM_ErrorCount
          ,le.donor_flag_ENUM_ErrorCount
          ,le.hair_color_CUSTOM_ErrorCount
          ,le.eye_color_CUSTOM_ErrorCount
          ,le.weight_l_CUSTOM_ErrorCount
          ,le.height_feet_CUSTOM_ErrorCount
          ,le.sex_gender_ENUM_ErrorCount
          ,le.permanent_license_issue_date_CUSTOM_ErrorCount,le.permanent_license_issue_date_LENGTHS_ErrorCount
          ,le.license_expiration_date_CUSTOM_ErrorCount,le.license_expiration_date_LENGTHS_ErrorCount
          ,le.restriction_codes_ALLOW_ErrorCount
          ,le.endorsement_codes_ALLOW_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.street_address_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.county_number_ALLOW_ErrorCount
          ,le.birth_date_CUSTOM_ErrorCount,le.birth_date_LENGTHS_ErrorCount
          ,le.clean_fname_CUSTOM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTHS_ErrorCount
          ,le.key_number_CUSTOM_ErrorCount
          ,le.license_number_CUSTOM_ErrorCount
          ,le.license_class_ENUM_ErrorCount
          ,le.donor_flag_ENUM_ErrorCount
          ,le.hair_color_CUSTOM_ErrorCount
          ,le.eye_color_CUSTOM_ErrorCount
          ,le.weight_l_CUSTOM_ErrorCount
          ,le.height_feet_CUSTOM_ErrorCount
          ,le.sex_gender_ENUM_ErrorCount
          ,le.permanent_license_issue_date_CUSTOM_ErrorCount,le.permanent_license_issue_date_LENGTHS_ErrorCount
          ,le.license_expiration_date_CUSTOM_ErrorCount,le.license_expiration_date_LENGTHS_ErrorCount
          ,le.restriction_codes_ALLOW_ErrorCount
          ,le.endorsement_codes_ALLOW_ErrorCount
          ,le.first_name_CUSTOM_ErrorCount
          ,le.street_address_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_CUSTOM_ErrorCount
          ,le.zip_code_CUSTOM_ErrorCount
          ,le.county_number_ALLOW_ErrorCount
          ,le.birth_date_CUSTOM_ErrorCount,le.birth_date_LENGTHS_ErrorCount
          ,le.clean_fname_CUSTOM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_In_oh));
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
          ,'process_date:' + getFieldTypeText(h.process_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'key_number:' + getFieldTypeText(h.key_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_number:' + getFieldTypeText(h.license_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_class:' + getFieldTypeText(h.license_class) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'donor_flag:' + getFieldTypeText(h.donor_flag) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'hair_color:' + getFieldTypeText(h.hair_color) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'eye_color:' + getFieldTypeText(h.eye_color) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'weight_l:' + getFieldTypeText(h.weight_l) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'height_feet:' + getFieldTypeText(h.height_feet) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'height_inches:' + getFieldTypeText(h.height_inches) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'sex_gender:' + getFieldTypeText(h.sex_gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'permanent_license_issue_date:' + getFieldTypeText(h.permanent_license_issue_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'license_expiration_date:' + getFieldTypeText(h.license_expiration_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'restriction_codes:' + getFieldTypeText(h.restriction_codes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'endorsement_codes:' + getFieldTypeText(h.endorsement_codes) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'first_name:' + getFieldTypeText(h.first_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'middle_name:' + getFieldTypeText(h.middle_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'last_name:' + getFieldTypeText(h.last_name) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_address:' + getFieldTypeText(h.street_address) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip_code:' + getFieldTypeText(h.zip_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'county_number:' + getFieldTypeText(h.county_number) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'birth_date:' + getFieldTypeText(h.birth_date) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_name_prefix:' + getFieldTypeText(h.clean_name_prefix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_fname:' + getFieldTypeText(h.clean_fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_mname:' + getFieldTypeText(h.clean_mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'clean_lname:' + getFieldTypeText(h.clean_lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_process_date_cnt
          ,le.populated_key_number_cnt
          ,le.populated_license_number_cnt
          ,le.populated_license_class_cnt
          ,le.populated_donor_flag_cnt
          ,le.populated_hair_color_cnt
          ,le.populated_eye_color_cnt
          ,le.populated_weight_l_cnt
          ,le.populated_height_feet_cnt
          ,le.populated_height_inches_cnt
          ,le.populated_sex_gender_cnt
          ,le.populated_permanent_license_issue_date_cnt
          ,le.populated_license_expiration_date_cnt
          ,le.populated_restriction_codes_cnt
          ,le.populated_endorsement_codes_cnt
          ,le.populated_first_name_cnt
          ,le.populated_middle_name_cnt
          ,le.populated_last_name_cnt
          ,le.populated_street_address_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_zip_code_cnt
          ,le.populated_county_number_cnt
          ,le.populated_birth_date_cnt
          ,le.populated_clean_name_prefix_cnt
          ,le.populated_clean_fname_cnt
          ,le.populated_clean_mname_cnt
          ,le.populated_clean_lname_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_process_date_pcnt
          ,le.populated_key_number_pcnt
          ,le.populated_license_number_pcnt
          ,le.populated_license_class_pcnt
          ,le.populated_donor_flag_pcnt
          ,le.populated_hair_color_pcnt
          ,le.populated_eye_color_pcnt
          ,le.populated_weight_l_pcnt
          ,le.populated_height_feet_pcnt
          ,le.populated_height_inches_pcnt
          ,le.populated_sex_gender_pcnt
          ,le.populated_permanent_license_issue_date_pcnt
          ,le.populated_license_expiration_date_pcnt
          ,le.populated_restriction_codes_pcnt
          ,le.populated_endorsement_codes_pcnt
          ,le.populated_first_name_pcnt
          ,le.populated_middle_name_pcnt
          ,le.populated_last_name_pcnt
          ,le.populated_street_address_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_zip_code_pcnt
          ,le.populated_county_number_pcnt
          ,le.populated_birth_date_pcnt
          ,le.populated_clean_name_prefix_pcnt
          ,le.populated_clean_fname_pcnt
          ,le.populated_clean_mname_pcnt
          ,le.populated_clean_lname_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,28,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_In_oh));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),28,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_In_oh) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_DL_OH, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
