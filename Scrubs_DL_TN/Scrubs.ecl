IMPORT ut,SALT35;
IMPORT Scrubs,Scrubs_DL_TN; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_TN)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 orig_last_name_Invalid;
    UNSIGNED1 orig_street_address1_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_code_Invalid;
    UNSIGNED1 orig_dl_number_Invalid;
    UNSIGNED1 orig_license_type_Invalid;
    UNSIGNED1 orig_sex_Invalid;
    UNSIGNED1 orig_height_ft_Invalid;
    UNSIGNED1 orig_height_in_Invalid;
    UNSIGNED1 orig_weight_Invalid;
    UNSIGNED1 orig_eye_color_Invalid;
    UNSIGNED1 orig_hair_color_Invalid;
    UNSIGNED1 orig_restrictions1_Invalid;
    UNSIGNED1 orig_restrictions2_Invalid;
    UNSIGNED1 orig_restrictions3_Invalid;
    UNSIGNED1 orig_restrictions4_Invalid;
    UNSIGNED1 orig_restrictions5_Invalid;
    UNSIGNED1 orig_endorsements1_Invalid;
    UNSIGNED1 orig_endorsements2_Invalid;
    UNSIGNED1 orig_endorsements3_Invalid;
    UNSIGNED1 orig_endorsements4_Invalid;
    UNSIGNED1 orig_endorsements5_Invalid;
    UNSIGNED1 orig_dob_Invalid;
    UNSIGNED1 orig_issue_date_Invalid;
    UNSIGNED1 orig_expire_date_Invalid;
    UNSIGNED1 orig_non_cdl_status_Invalid;
    UNSIGNED1 orig_cdl_status_Invalid;
    UNSIGNED1 orig_race_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_TN)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_TN) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT35.StrType)le.process_date);
    SELF.orig_last_name_Invalid := Fields.InValid_orig_last_name((SALT35.StrType)le.orig_last_name,(SALT35.StrType)le.orig_first_name,(SALT35.StrType)le.orig_middle_name);
    SELF.orig_street_address1_Invalid := Fields.InValid_orig_street_address1((SALT35.StrType)le.orig_street_address1);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT35.StrType)le.orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT35.StrType)le.orig_state);
    SELF.orig_zip_code_Invalid := Fields.InValid_orig_zip_code((SALT35.StrType)le.orig_zip_code);
    SELF.orig_dl_number_Invalid := Fields.InValid_orig_dl_number((SALT35.StrType)le.orig_dl_number);
    SELF.orig_license_type_Invalid := Fields.InValid_orig_license_type((SALT35.StrType)le.orig_license_type);
    SELF.orig_sex_Invalid := Fields.InValid_orig_sex((SALT35.StrType)le.orig_sex);
    SELF.orig_height_ft_Invalid := Fields.InValid_orig_height_ft((SALT35.StrType)le.orig_height_ft,(SALT35.StrType)le.orig_height_in);
    SELF.orig_height_in_Invalid := Fields.InValid_orig_height_in((SALT35.StrType)le.orig_height_in);
    SELF.orig_weight_Invalid := Fields.InValid_orig_weight((SALT35.StrType)le.orig_weight);
    SELF.orig_eye_color_Invalid := Fields.InValid_orig_eye_color((SALT35.StrType)le.orig_eye_color);
    SELF.orig_hair_color_Invalid := Fields.InValid_orig_hair_color((SALT35.StrType)le.orig_hair_color);
    SELF.orig_restrictions1_Invalid := Fields.InValid_orig_restrictions1((SALT35.StrType)le.orig_restrictions1);
    SELF.orig_restrictions2_Invalid := Fields.InValid_orig_restrictions2((SALT35.StrType)le.orig_restrictions2);
    SELF.orig_restrictions3_Invalid := Fields.InValid_orig_restrictions3((SALT35.StrType)le.orig_restrictions3);
    SELF.orig_restrictions4_Invalid := Fields.InValid_orig_restrictions4((SALT35.StrType)le.orig_restrictions4);
    SELF.orig_restrictions5_Invalid := Fields.InValid_orig_restrictions5((SALT35.StrType)le.orig_restrictions5);
    SELF.orig_endorsements1_Invalid := Fields.InValid_orig_endorsements1((SALT35.StrType)le.orig_endorsements1);
    SELF.orig_endorsements2_Invalid := Fields.InValid_orig_endorsements2((SALT35.StrType)le.orig_endorsements2);
    SELF.orig_endorsements3_Invalid := Fields.InValid_orig_endorsements3((SALT35.StrType)le.orig_endorsements3);
    SELF.orig_endorsements4_Invalid := Fields.InValid_orig_endorsements4((SALT35.StrType)le.orig_endorsements4);
    SELF.orig_endorsements5_Invalid := Fields.InValid_orig_endorsements5((SALT35.StrType)le.orig_endorsements5);
    SELF.orig_dob_Invalid := Fields.InValid_orig_dob((SALT35.StrType)le.orig_dob);
    SELF.orig_issue_date_Invalid := Fields.InValid_orig_issue_date((SALT35.StrType)le.orig_issue_date);
    SELF.orig_expire_date_Invalid := Fields.InValid_orig_expire_date((SALT35.StrType)le.orig_expire_date);
    SELF.orig_non_cdl_status_Invalid := Fields.InValid_orig_non_cdl_status((SALT35.StrType)le.orig_non_cdl_status);
    SELF.orig_cdl_status_Invalid := Fields.InValid_orig_cdl_status((SALT35.StrType)le.orig_cdl_status);
    SELF.orig_race_Invalid := Fields.InValid_orig_race((SALT35.StrType)le.orig_race);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_TN);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.orig_last_name_Invalid << 2 ) + ( le.orig_street_address1_Invalid << 3 ) + ( le.orig_city_Invalid << 4 ) + ( le.orig_state_Invalid << 5 ) + ( le.orig_zip_code_Invalid << 6 ) + ( le.orig_dl_number_Invalid << 8 ) + ( le.orig_license_type_Invalid << 10 ) + ( le.orig_sex_Invalid << 11 ) + ( le.orig_height_ft_Invalid << 12 ) + ( le.orig_height_in_Invalid << 13 ) + ( le.orig_weight_Invalid << 14 ) + ( le.orig_eye_color_Invalid << 15 ) + ( le.orig_hair_color_Invalid << 16 ) + ( le.orig_restrictions1_Invalid << 17 ) + ( le.orig_restrictions2_Invalid << 19 ) + ( le.orig_restrictions3_Invalid << 21 ) + ( le.orig_restrictions4_Invalid << 23 ) + ( le.orig_restrictions5_Invalid << 25 ) + ( le.orig_endorsements1_Invalid << 27 ) + ( le.orig_endorsements2_Invalid << 28 ) + ( le.orig_endorsements3_Invalid << 29 ) + ( le.orig_endorsements4_Invalid << 30 ) + ( le.orig_endorsements5_Invalid << 31 ) + ( le.orig_dob_Invalid << 32 ) + ( le.orig_issue_date_Invalid << 34 ) + ( le.orig_expire_date_Invalid << 36 ) + ( le.orig_non_cdl_status_Invalid << 38 ) + ( le.orig_cdl_status_Invalid << 39 ) + ( le.orig_race_Invalid << 40 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_TN);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_last_name_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.orig_street_address1_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.orig_zip_code_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.orig_dl_number_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.orig_license_type_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.orig_sex_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.orig_height_ft_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.orig_height_in_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.orig_weight_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.orig_eye_color_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.orig_hair_color_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.orig_restrictions1_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.orig_restrictions2_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.orig_restrictions3_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.orig_restrictions4_Invalid := (le.ScrubsBits1 >> 23) & 3;
    SELF.orig_restrictions5_Invalid := (le.ScrubsBits1 >> 25) & 3;
    SELF.orig_endorsements1_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.orig_endorsements2_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.orig_endorsements3_Invalid := (le.ScrubsBits1 >> 29) & 1;
    SELF.orig_endorsements4_Invalid := (le.ScrubsBits1 >> 30) & 1;
    SELF.orig_endorsements5_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.orig_dob_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.orig_issue_date_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.orig_expire_date_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.orig_non_cdl_status_Invalid := (le.ScrubsBits1 >> 38) & 1;
    SELF.orig_cdl_status_Invalid := (le.ScrubsBits1 >> 39) & 1;
    SELF.orig_race_Invalid := (le.ScrubsBits1 >> 40) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
    orig_last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_last_name_Invalid=1);
    orig_street_address1_LENGTH_ErrorCount := COUNT(GROUP,h.orig_street_address1_Invalid=1);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_state_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_zip_code_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_code_Invalid=1);
    orig_zip_code_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip_code_Invalid=2);
    orig_zip_code_Total_ErrorCount := COUNT(GROUP,h.orig_zip_code_Invalid>0);
    orig_dl_number_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid=1);
    orig_dl_number_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid=2);
    orig_dl_number_Total_ErrorCount := COUNT(GROUP,h.orig_dl_number_Invalid>0);
    orig_license_type_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_license_type_Invalid=1);
    orig_sex_ENUM_ErrorCount := COUNT(GROUP,h.orig_sex_Invalid=1);
    orig_height_ft_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_height_ft_Invalid=1);
    orig_height_in_ALLOW_ErrorCount := COUNT(GROUP,h.orig_height_in_Invalid=1);
    orig_weight_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_weight_Invalid=1);
    orig_eye_color_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_eye_color_Invalid=1);
    orig_hair_color_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_hair_color_Invalid=1);
    orig_restrictions1_ALLOW_ErrorCount := COUNT(GROUP,h.orig_restrictions1_Invalid=1);
    orig_restrictions1_LENGTH_ErrorCount := COUNT(GROUP,h.orig_restrictions1_Invalid=2);
    orig_restrictions1_Total_ErrorCount := COUNT(GROUP,h.orig_restrictions1_Invalid>0);
    orig_restrictions2_ALLOW_ErrorCount := COUNT(GROUP,h.orig_restrictions2_Invalid=1);
    orig_restrictions2_LENGTH_ErrorCount := COUNT(GROUP,h.orig_restrictions2_Invalid=2);
    orig_restrictions2_Total_ErrorCount := COUNT(GROUP,h.orig_restrictions2_Invalid>0);
    orig_restrictions3_ALLOW_ErrorCount := COUNT(GROUP,h.orig_restrictions3_Invalid=1);
    orig_restrictions3_LENGTH_ErrorCount := COUNT(GROUP,h.orig_restrictions3_Invalid=2);
    orig_restrictions3_Total_ErrorCount := COUNT(GROUP,h.orig_restrictions3_Invalid>0);
    orig_restrictions4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_restrictions4_Invalid=1);
    orig_restrictions4_LENGTH_ErrorCount := COUNT(GROUP,h.orig_restrictions4_Invalid=2);
    orig_restrictions4_Total_ErrorCount := COUNT(GROUP,h.orig_restrictions4_Invalid>0);
    orig_restrictions5_ALLOW_ErrorCount := COUNT(GROUP,h.orig_restrictions5_Invalid=1);
    orig_restrictions5_LENGTH_ErrorCount := COUNT(GROUP,h.orig_restrictions5_Invalid=2);
    orig_restrictions5_Total_ErrorCount := COUNT(GROUP,h.orig_restrictions5_Invalid>0);
    orig_endorsements1_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_endorsements1_Invalid=1);
    orig_endorsements2_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_endorsements2_Invalid=1);
    orig_endorsements3_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_endorsements3_Invalid=1);
    orig_endorsements4_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_endorsements4_Invalid=1);
    orig_endorsements5_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_endorsements5_Invalid=1);
    orig_dob_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=1);
    orig_dob_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid=2);
    orig_dob_Total_ErrorCount := COUNT(GROUP,h.orig_dob_Invalid>0);
    orig_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_issue_date_Invalid=1);
    orig_issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_issue_date_Invalid=2);
    orig_issue_date_Total_ErrorCount := COUNT(GROUP,h.orig_issue_date_Invalid>0);
    orig_expire_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_expire_date_Invalid=1);
    orig_expire_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_expire_date_Invalid=2);
    orig_expire_date_Total_ErrorCount := COUNT(GROUP,h.orig_expire_date_Invalid>0);
    orig_non_cdl_status_ALLOW_ErrorCount := COUNT(GROUP,h.orig_non_cdl_status_Invalid=1);
    orig_cdl_status_ALLOW_ErrorCount := COUNT(GROUP,h.orig_cdl_status_Invalid=1);
    orig_race_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_race_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT35.StrType ErrorMessage;
    SALT35.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.orig_last_name_Invalid,le.orig_street_address1_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_code_Invalid,le.orig_dl_number_Invalid,le.orig_license_type_Invalid,le.orig_sex_Invalid,le.orig_height_ft_Invalid,le.orig_height_in_Invalid,le.orig_weight_Invalid,le.orig_eye_color_Invalid,le.orig_hair_color_Invalid,le.orig_restrictions1_Invalid,le.orig_restrictions2_Invalid,le.orig_restrictions3_Invalid,le.orig_restrictions4_Invalid,le.orig_restrictions5_Invalid,le.orig_endorsements1_Invalid,le.orig_endorsements2_Invalid,le.orig_endorsements3_Invalid,le.orig_endorsements4_Invalid,le.orig_endorsements5_Invalid,le.orig_dob_Invalid,le.orig_issue_date_Invalid,le.orig_expire_date_Invalid,le.orig_non_cdl_status_Invalid,le.orig_cdl_status_Invalid,le.orig_race_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_orig_last_name(le.orig_last_name_Invalid),Fields.InvalidMessage_orig_street_address1(le.orig_street_address1_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip_code(le.orig_zip_code_Invalid),Fields.InvalidMessage_orig_dl_number(le.orig_dl_number_Invalid),Fields.InvalidMessage_orig_license_type(le.orig_license_type_Invalid),Fields.InvalidMessage_orig_sex(le.orig_sex_Invalid),Fields.InvalidMessage_orig_height_ft(le.orig_height_ft_Invalid),Fields.InvalidMessage_orig_height_in(le.orig_height_in_Invalid),Fields.InvalidMessage_orig_weight(le.orig_weight_Invalid),Fields.InvalidMessage_orig_eye_color(le.orig_eye_color_Invalid),Fields.InvalidMessage_orig_hair_color(le.orig_hair_color_Invalid),Fields.InvalidMessage_orig_restrictions1(le.orig_restrictions1_Invalid),Fields.InvalidMessage_orig_restrictions2(le.orig_restrictions2_Invalid),Fields.InvalidMessage_orig_restrictions3(le.orig_restrictions3_Invalid),Fields.InvalidMessage_orig_restrictions4(le.orig_restrictions4_Invalid),Fields.InvalidMessage_orig_restrictions5(le.orig_restrictions5_Invalid),Fields.InvalidMessage_orig_endorsements1(le.orig_endorsements1_Invalid),Fields.InvalidMessage_orig_endorsements2(le.orig_endorsements2_Invalid),Fields.InvalidMessage_orig_endorsements3(le.orig_endorsements3_Invalid),Fields.InvalidMessage_orig_endorsements4(le.orig_endorsements4_Invalid),Fields.InvalidMessage_orig_endorsements5(le.orig_endorsements5_Invalid),Fields.InvalidMessage_orig_dob(le.orig_dob_Invalid),Fields.InvalidMessage_orig_issue_date(le.orig_issue_date_Invalid),Fields.InvalidMessage_orig_expire_date(le.orig_expire_date_Invalid),Fields.InvalidMessage_orig_non_cdl_status(le.orig_non_cdl_status_Invalid),Fields.InvalidMessage_orig_cdl_status(le.orig_cdl_status_Invalid),Fields.InvalidMessage_orig_race(le.orig_race_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_last_name_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_street_address1_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_zip_code_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dl_number_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_license_type_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_sex_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.orig_height_ft_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_height_in_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_weight_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_eye_color_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_hair_color_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_restrictions1_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_restrictions2_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_restrictions3_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_restrictions4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_restrictions5_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_endorsements1_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_endorsements2_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_endorsements3_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_endorsements4_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_endorsements5_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_dob_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_issue_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_expire_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_non_cdl_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_cdl_status_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_race_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','orig_last_name','orig_street_address1','orig_city','orig_state','orig_zip_code','orig_dl_number','orig_license_type','orig_sex','orig_height_ft','orig_height_in','orig_weight','orig_eye_color','orig_hair_color','orig_restrictions1','orig_restrictions2','orig_restrictions3','orig_restrictions4','orig_restrictions5','orig_endorsements1','orig_endorsements2','orig_endorsements3','orig_endorsements4','orig_endorsements5','orig_dob','orig_issue_date','orig_expire_date','orig_non_cdl_status','orig_cdl_status','orig_race','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_8pastdate','invalid_orig_name','invalid_mandatory','invalid_alpha_num_specials','invalid_orig_state','invalid_orig_zip_code','invalid_orig_dl_number','invalid_orig_license_type','invalid_orig_sex','invalid_orig_height_ft','invalid_numeric_blank','invalid_orig_weight','invalid_orig_eye_color','invalid_orig_hair_color','invalid_orig_restrictions','invalid_orig_restrictions','invalid_orig_restrictions','invalid_orig_restrictions','invalid_orig_restrictions','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_orig_endorsements','invalid_8pastdate','invalid_8pastdate','invalid_8generaldate','invalid_alpha_num','invalid_alpha_num','invalid_orig_race','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT35.StrType)le.process_date,(SALT35.StrType)le.orig_last_name,(SALT35.StrType)le.orig_street_address1,(SALT35.StrType)le.orig_city,(SALT35.StrType)le.orig_state,(SALT35.StrType)le.orig_zip_code,(SALT35.StrType)le.orig_dl_number,(SALT35.StrType)le.orig_license_type,(SALT35.StrType)le.orig_sex,(SALT35.StrType)le.orig_height_ft,(SALT35.StrType)le.orig_height_in,(SALT35.StrType)le.orig_weight,(SALT35.StrType)le.orig_eye_color,(SALT35.StrType)le.orig_hair_color,(SALT35.StrType)le.orig_restrictions1,(SALT35.StrType)le.orig_restrictions2,(SALT35.StrType)le.orig_restrictions3,(SALT35.StrType)le.orig_restrictions4,(SALT35.StrType)le.orig_restrictions5,(SALT35.StrType)le.orig_endorsements1,(SALT35.StrType)le.orig_endorsements2,(SALT35.StrType)le.orig_endorsements3,(SALT35.StrType)le.orig_endorsements4,(SALT35.StrType)le.orig_endorsements5,(SALT35.StrType)le.orig_dob,(SALT35.StrType)le.orig_issue_date,(SALT35.StrType)le.orig_expire_date,(SALT35.StrType)le.orig_non_cdl_status,(SALT35.StrType)le.orig_cdl_status,(SALT35.StrType)le.orig_race,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,30,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT35.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_8pastdate:CUSTOM','process_date:invalid_8pastdate:LENGTH'
          ,'orig_last_name:invalid_orig_name:CUSTOM'
          ,'orig_street_address1:invalid_mandatory:LENGTH'
          ,'orig_city:invalid_alpha_num_specials:ALLOW'
          ,'orig_state:invalid_orig_state:CUSTOM'
          ,'orig_zip_code:invalid_orig_zip_code:ALLOW','orig_zip_code:invalid_orig_zip_code:LENGTH'
          ,'orig_dl_number:invalid_orig_dl_number:ALLOW','orig_dl_number:invalid_orig_dl_number:LENGTH'
          ,'orig_license_type:invalid_orig_license_type:CUSTOM'
          ,'orig_sex:invalid_orig_sex:ENUM'
          ,'orig_height_ft:invalid_orig_height_ft:CUSTOM'
          ,'orig_height_in:invalid_numeric_blank:ALLOW'
          ,'orig_weight:invalid_orig_weight:CUSTOM'
          ,'orig_eye_color:invalid_orig_eye_color:CUSTOM'
          ,'orig_hair_color:invalid_orig_hair_color:CUSTOM'
          ,'orig_restrictions1:invalid_orig_restrictions:ALLOW','orig_restrictions1:invalid_orig_restrictions:LENGTH'
          ,'orig_restrictions2:invalid_orig_restrictions:ALLOW','orig_restrictions2:invalid_orig_restrictions:LENGTH'
          ,'orig_restrictions3:invalid_orig_restrictions:ALLOW','orig_restrictions3:invalid_orig_restrictions:LENGTH'
          ,'orig_restrictions4:invalid_orig_restrictions:ALLOW','orig_restrictions4:invalid_orig_restrictions:LENGTH'
          ,'orig_restrictions5:invalid_orig_restrictions:ALLOW','orig_restrictions5:invalid_orig_restrictions:LENGTH'
          ,'orig_endorsements1:invalid_orig_endorsements:CUSTOM'
          ,'orig_endorsements2:invalid_orig_endorsements:CUSTOM'
          ,'orig_endorsements3:invalid_orig_endorsements:CUSTOM'
          ,'orig_endorsements4:invalid_orig_endorsements:CUSTOM'
          ,'orig_endorsements5:invalid_orig_endorsements:CUSTOM'
          ,'orig_dob:invalid_8pastdate:CUSTOM','orig_dob:invalid_8pastdate:LENGTH'
          ,'orig_issue_date:invalid_8pastdate:CUSTOM','orig_issue_date:invalid_8pastdate:LENGTH'
          ,'orig_expire_date:invalid_8generaldate:CUSTOM','orig_expire_date:invalid_8generaldate:LENGTH'
          ,'orig_non_cdl_status:invalid_alpha_num:ALLOW'
          ,'orig_cdl_status:invalid_alpha_num:ALLOW'
          ,'orig_race:invalid_orig_race:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_orig_last_name(1)
          ,Fields.InvalidMessage_orig_street_address1(1)
          ,Fields.InvalidMessage_orig_city(1)
          ,Fields.InvalidMessage_orig_state(1)
          ,Fields.InvalidMessage_orig_zip_code(1),Fields.InvalidMessage_orig_zip_code(2)
          ,Fields.InvalidMessage_orig_dl_number(1),Fields.InvalidMessage_orig_dl_number(2)
          ,Fields.InvalidMessage_orig_license_type(1)
          ,Fields.InvalidMessage_orig_sex(1)
          ,Fields.InvalidMessage_orig_height_ft(1)
          ,Fields.InvalidMessage_orig_height_in(1)
          ,Fields.InvalidMessage_orig_weight(1)
          ,Fields.InvalidMessage_orig_eye_color(1)
          ,Fields.InvalidMessage_orig_hair_color(1)
          ,Fields.InvalidMessage_orig_restrictions1(1),Fields.InvalidMessage_orig_restrictions1(2)
          ,Fields.InvalidMessage_orig_restrictions2(1),Fields.InvalidMessage_orig_restrictions2(2)
          ,Fields.InvalidMessage_orig_restrictions3(1),Fields.InvalidMessage_orig_restrictions3(2)
          ,Fields.InvalidMessage_orig_restrictions4(1),Fields.InvalidMessage_orig_restrictions4(2)
          ,Fields.InvalidMessage_orig_restrictions5(1),Fields.InvalidMessage_orig_restrictions5(2)
          ,Fields.InvalidMessage_orig_endorsements1(1)
          ,Fields.InvalidMessage_orig_endorsements2(1)
          ,Fields.InvalidMessage_orig_endorsements3(1)
          ,Fields.InvalidMessage_orig_endorsements4(1)
          ,Fields.InvalidMessage_orig_endorsements5(1)
          ,Fields.InvalidMessage_orig_dob(1),Fields.InvalidMessage_orig_dob(2)
          ,Fields.InvalidMessage_orig_issue_date(1),Fields.InvalidMessage_orig_issue_date(2)
          ,Fields.InvalidMessage_orig_expire_date(1),Fields.InvalidMessage_orig_expire_date(2)
          ,Fields.InvalidMessage_orig_non_cdl_status(1)
          ,Fields.InvalidMessage_orig_cdl_status(1)
          ,Fields.InvalidMessage_orig_race(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.orig_last_name_CUSTOM_ErrorCount
          ,le.orig_street_address1_LENGTH_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_code_ALLOW_ErrorCount,le.orig_zip_code_LENGTH_ErrorCount
          ,le.orig_dl_number_ALLOW_ErrorCount,le.orig_dl_number_LENGTH_ErrorCount
          ,le.orig_license_type_CUSTOM_ErrorCount
          ,le.orig_sex_ENUM_ErrorCount
          ,le.orig_height_ft_CUSTOM_ErrorCount
          ,le.orig_height_in_ALLOW_ErrorCount
          ,le.orig_weight_CUSTOM_ErrorCount
          ,le.orig_eye_color_CUSTOM_ErrorCount
          ,le.orig_hair_color_CUSTOM_ErrorCount
          ,le.orig_restrictions1_ALLOW_ErrorCount,le.orig_restrictions1_LENGTH_ErrorCount
          ,le.orig_restrictions2_ALLOW_ErrorCount,le.orig_restrictions2_LENGTH_ErrorCount
          ,le.orig_restrictions3_ALLOW_ErrorCount,le.orig_restrictions3_LENGTH_ErrorCount
          ,le.orig_restrictions4_ALLOW_ErrorCount,le.orig_restrictions4_LENGTH_ErrorCount
          ,le.orig_restrictions5_ALLOW_ErrorCount,le.orig_restrictions5_LENGTH_ErrorCount
          ,le.orig_endorsements1_CUSTOM_ErrorCount
          ,le.orig_endorsements2_CUSTOM_ErrorCount
          ,le.orig_endorsements3_CUSTOM_ErrorCount
          ,le.orig_endorsements4_CUSTOM_ErrorCount
          ,le.orig_endorsements5_CUSTOM_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount,le.orig_dob_LENGTH_ErrorCount
          ,le.orig_issue_date_CUSTOM_ErrorCount,le.orig_issue_date_LENGTH_ErrorCount
          ,le.orig_expire_date_CUSTOM_ErrorCount,le.orig_expire_date_LENGTH_ErrorCount
          ,le.orig_non_cdl_status_ALLOW_ErrorCount
          ,le.orig_cdl_status_ALLOW_ErrorCount
          ,le.orig_race_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.orig_last_name_CUSTOM_ErrorCount
          ,le.orig_street_address1_LENGTH_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount
          ,le.orig_state_CUSTOM_ErrorCount
          ,le.orig_zip_code_ALLOW_ErrorCount,le.orig_zip_code_LENGTH_ErrorCount
          ,le.orig_dl_number_ALLOW_ErrorCount,le.orig_dl_number_LENGTH_ErrorCount
          ,le.orig_license_type_CUSTOM_ErrorCount
          ,le.orig_sex_ENUM_ErrorCount
          ,le.orig_height_ft_CUSTOM_ErrorCount
          ,le.orig_height_in_ALLOW_ErrorCount
          ,le.orig_weight_CUSTOM_ErrorCount
          ,le.orig_eye_color_CUSTOM_ErrorCount
          ,le.orig_hair_color_CUSTOM_ErrorCount
          ,le.orig_restrictions1_ALLOW_ErrorCount,le.orig_restrictions1_LENGTH_ErrorCount
          ,le.orig_restrictions2_ALLOW_ErrorCount,le.orig_restrictions2_LENGTH_ErrorCount
          ,le.orig_restrictions3_ALLOW_ErrorCount,le.orig_restrictions3_LENGTH_ErrorCount
          ,le.orig_restrictions4_ALLOW_ErrorCount,le.orig_restrictions4_LENGTH_ErrorCount
          ,le.orig_restrictions5_ALLOW_ErrorCount,le.orig_restrictions5_LENGTH_ErrorCount
          ,le.orig_endorsements1_CUSTOM_ErrorCount
          ,le.orig_endorsements2_CUSTOM_ErrorCount
          ,le.orig_endorsements3_CUSTOM_ErrorCount
          ,le.orig_endorsements4_CUSTOM_ErrorCount
          ,le.orig_endorsements5_CUSTOM_ErrorCount
          ,le.orig_dob_CUSTOM_ErrorCount,le.orig_dob_LENGTH_ErrorCount
          ,le.orig_issue_date_CUSTOM_ErrorCount,le.orig_issue_date_LENGTH_ErrorCount
          ,le.orig_expire_date_CUSTOM_ErrorCount,le.orig_expire_date_LENGTH_ErrorCount
          ,le.orig_non_cdl_status_ALLOW_ErrorCount
          ,le.orig_cdl_status_ALLOW_ErrorCount
          ,le.orig_race_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,41,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT35.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT35.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
