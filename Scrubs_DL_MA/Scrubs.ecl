IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_DL_MA; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_MA)
    UNSIGNED1 pers_surrogate_Invalid;
    UNSIGNED1 license_licno_Invalid;
    UNSIGNED1 license_bdate_yyyymmdd_Invalid;
    UNSIGNED1 license_edate_yyyymmdd_Invalid;
    UNSIGNED1 license_lic_class_Invalid;
    UNSIGNED1 license_height_Invalid;
    UNSIGNED1 license_sex_Invalid;
    UNSIGNED1 license_last_name_Invalid;
    UNSIGNED1 license_first_name_Invalid;
    UNSIGNED1 license_middle_name_Invalid;
    UNSIGNED1 licmail_state_Invalid;
    UNSIGNED1 licmail_zip_Invalid;
    UNSIGNED1 licresi_street1_Invalid;
    UNSIGNED1 licresi_street2_Invalid;
    UNSIGNED1 licresi_city_Invalid;
    UNSIGNED1 licresi_state_Invalid;
    UNSIGNED1 licresi_zip_Invalid;
    UNSIGNED1 issue_date_yyyymmdd_Invalid;
    UNSIGNED1 license_status_Invalid;
    UNSIGNED1 process_date_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_MA)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_MA) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.pers_surrogate_Invalid := Fields.InValid_pers_surrogate((SALT34.StrType)le.pers_surrogate);
    SELF.license_licno_Invalid := Fields.InValid_license_licno((SALT34.StrType)le.license_licno);
    SELF.license_bdate_yyyymmdd_Invalid := Fields.InValid_license_bdate_yyyymmdd((SALT34.StrType)le.license_bdate_yyyymmdd);
    SELF.license_edate_yyyymmdd_Invalid := Fields.InValid_license_edate_yyyymmdd((SALT34.StrType)le.license_edate_yyyymmdd);
    SELF.license_lic_class_Invalid := Fields.InValid_license_lic_class((SALT34.StrType)le.license_lic_class);
    SELF.license_height_Invalid := Fields.InValid_license_height((SALT34.StrType)le.license_height);
    SELF.license_sex_Invalid := Fields.InValid_license_sex((SALT34.StrType)le.license_sex);
    SELF.license_last_name_Invalid := Fields.InValid_license_last_name((SALT34.StrType)le.license_last_name,(SALT34.StrType)le.license_first_name,(SALT34.StrType)le.license_middle_name);
    SELF.license_first_name_Invalid := Fields.InValid_license_first_name((SALT34.StrType)le.license_first_name);
    SELF.license_middle_name_Invalid := Fields.InValid_license_middle_name((SALT34.StrType)le.license_middle_name);
    SELF.licmail_state_Invalid := Fields.InValid_licmail_state((SALT34.StrType)le.licmail_state);
    SELF.licmail_zip_Invalid := Fields.InValid_licmail_zip((SALT34.StrType)le.licmail_zip);
    SELF.licresi_street1_Invalid := Fields.InValid_licresi_street1((SALT34.StrType)le.licresi_street1);
    SELF.licresi_street2_Invalid := Fields.InValid_licresi_street2((SALT34.StrType)le.licresi_street2);
    SELF.licresi_city_Invalid := Fields.InValid_licresi_city((SALT34.StrType)le.licresi_city);
    SELF.licresi_state_Invalid := Fields.InValid_licresi_state((SALT34.StrType)le.licresi_state);
    SELF.licresi_zip_Invalid := Fields.InValid_licresi_zip((SALT34.StrType)le.licresi_zip);
    SELF.issue_date_yyyymmdd_Invalid := Fields.InValid_issue_date_yyyymmdd((SALT34.StrType)le.issue_date_yyyymmdd);
    SELF.license_status_Invalid := Fields.InValid_license_status((SALT34.StrType)le.license_status);
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT34.StrType)le.process_date);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_MA);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.pers_surrogate_Invalid << 0 ) + ( le.license_licno_Invalid << 2 ) + ( le.license_bdate_yyyymmdd_Invalid << 4 ) + ( le.license_edate_yyyymmdd_Invalid << 6 ) + ( le.license_lic_class_Invalid << 8 ) + ( le.license_height_Invalid << 10 ) + ( le.license_sex_Invalid << 11 ) + ( le.license_last_name_Invalid << 12 ) + ( le.license_first_name_Invalid << 14 ) + ( le.license_middle_name_Invalid << 16 ) + ( le.licmail_state_Invalid << 18 ) + ( le.licmail_zip_Invalid << 20 ) + ( le.licresi_street1_Invalid << 22 ) + ( le.licresi_street2_Invalid << 24 ) + ( le.licresi_city_Invalid << 26 ) + ( le.licresi_state_Invalid << 28 ) + ( le.licresi_zip_Invalid << 30 ) + ( le.issue_date_yyyymmdd_Invalid << 32 ) + ( le.license_status_Invalid << 34 ) + ( le.process_date_Invalid << 36 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_MA);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.pers_surrogate_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.license_licno_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.license_bdate_yyyymmdd_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.license_edate_yyyymmdd_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.license_lic_class_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.license_height_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.license_sex_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.license_last_name_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.license_first_name_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.license_middle_name_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.licmail_state_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.licmail_zip_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.licresi_street1_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.licresi_street2_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.licresi_city_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.licresi_state_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.licresi_zip_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.issue_date_yyyymmdd_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.license_status_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    pers_surrogate_ALLOW_ErrorCount := COUNT(GROUP,h.pers_surrogate_Invalid=1);
    pers_surrogate_LENGTH_ErrorCount := COUNT(GROUP,h.pers_surrogate_Invalid=2);
    pers_surrogate_Total_ErrorCount := COUNT(GROUP,h.pers_surrogate_Invalid>0);
    license_licno_CUSTOM_ErrorCount := COUNT(GROUP,h.license_licno_Invalid=1);
    license_licno_LENGTH_ErrorCount := COUNT(GROUP,h.license_licno_Invalid=2);
    license_licno_Total_ErrorCount := COUNT(GROUP,h.license_licno_Invalid>0);
    license_bdate_yyyymmdd_CUSTOM_ErrorCount := COUNT(GROUP,h.license_bdate_yyyymmdd_Invalid=1);
    license_bdate_yyyymmdd_LENGTH_ErrorCount := COUNT(GROUP,h.license_bdate_yyyymmdd_Invalid=2);
    license_bdate_yyyymmdd_Total_ErrorCount := COUNT(GROUP,h.license_bdate_yyyymmdd_Invalid>0);
    license_edate_yyyymmdd_CUSTOM_ErrorCount := COUNT(GROUP,h.license_edate_yyyymmdd_Invalid=1);
    license_edate_yyyymmdd_LENGTH_ErrorCount := COUNT(GROUP,h.license_edate_yyyymmdd_Invalid=2);
    license_edate_yyyymmdd_Total_ErrorCount := COUNT(GROUP,h.license_edate_yyyymmdd_Invalid>0);
    license_lic_class_CUSTOM_ErrorCount := COUNT(GROUP,h.license_lic_class_Invalid=1);
    license_lic_class_LENGTH_ErrorCount := COUNT(GROUP,h.license_lic_class_Invalid=2);
    license_lic_class_Total_ErrorCount := COUNT(GROUP,h.license_lic_class_Invalid>0);
    license_height_CUSTOM_ErrorCount := COUNT(GROUP,h.license_height_Invalid=1);
    license_sex_ENUM_ErrorCount := COUNT(GROUP,h.license_sex_Invalid=1);
    license_last_name_CAPS_ErrorCount := COUNT(GROUP,h.license_last_name_Invalid=1);
    license_last_name_ALLOW_ErrorCount := COUNT(GROUP,h.license_last_name_Invalid=2);
    license_last_name_CUSTOM_ErrorCount := COUNT(GROUP,h.license_last_name_Invalid=3);
    license_last_name_Total_ErrorCount := COUNT(GROUP,h.license_last_name_Invalid>0);
    license_first_name_CAPS_ErrorCount := COUNT(GROUP,h.license_first_name_Invalid=1);
    license_first_name_ALLOW_ErrorCount := COUNT(GROUP,h.license_first_name_Invalid=2);
    license_first_name_Total_ErrorCount := COUNT(GROUP,h.license_first_name_Invalid>0);
    license_middle_name_CAPS_ErrorCount := COUNT(GROUP,h.license_middle_name_Invalid=1);
    license_middle_name_ALLOW_ErrorCount := COUNT(GROUP,h.license_middle_name_Invalid=2);
    license_middle_name_Total_ErrorCount := COUNT(GROUP,h.license_middle_name_Invalid>0);
    licmail_state_CUSTOM_ErrorCount := COUNT(GROUP,h.licmail_state_Invalid=1);
    licmail_state_LENGTH_ErrorCount := COUNT(GROUP,h.licmail_state_Invalid=2);
    licmail_state_Total_ErrorCount := COUNT(GROUP,h.licmail_state_Invalid>0);
    licmail_zip_ALLOW_ErrorCount := COUNT(GROUP,h.licmail_zip_Invalid=1);
    licmail_zip_LENGTH_ErrorCount := COUNT(GROUP,h.licmail_zip_Invalid=2);
    licmail_zip_Total_ErrorCount := COUNT(GROUP,h.licmail_zip_Invalid>0);
    licresi_street1_CAPS_ErrorCount := COUNT(GROUP,h.licresi_street1_Invalid=1);
    licresi_street1_ALLOW_ErrorCount := COUNT(GROUP,h.licresi_street1_Invalid=2);
    licresi_street1_Total_ErrorCount := COUNT(GROUP,h.licresi_street1_Invalid>0);
    licresi_street2_CAPS_ErrorCount := COUNT(GROUP,h.licresi_street2_Invalid=1);
    licresi_street2_ALLOW_ErrorCount := COUNT(GROUP,h.licresi_street2_Invalid=2);
    licresi_street2_Total_ErrorCount := COUNT(GROUP,h.licresi_street2_Invalid>0);
    licresi_city_CAPS_ErrorCount := COUNT(GROUP,h.licresi_city_Invalid=1);
    licresi_city_ALLOW_ErrorCount := COUNT(GROUP,h.licresi_city_Invalid=2);
    licresi_city_Total_ErrorCount := COUNT(GROUP,h.licresi_city_Invalid>0);
    licresi_state_CUSTOM_ErrorCount := COUNT(GROUP,h.licresi_state_Invalid=1);
    licresi_state_LENGTH_ErrorCount := COUNT(GROUP,h.licresi_state_Invalid=2);
    licresi_state_Total_ErrorCount := COUNT(GROUP,h.licresi_state_Invalid>0);
    licresi_zip_ALLOW_ErrorCount := COUNT(GROUP,h.licresi_zip_Invalid=1);
    licresi_zip_LENGTH_ErrorCount := COUNT(GROUP,h.licresi_zip_Invalid=2);
    licresi_zip_Total_ErrorCount := COUNT(GROUP,h.licresi_zip_Invalid>0);
    issue_date_yyyymmdd_CUSTOM_ErrorCount := COUNT(GROUP,h.issue_date_yyyymmdd_Invalid=1);
    issue_date_yyyymmdd_LENGTH_ErrorCount := COUNT(GROUP,h.issue_date_yyyymmdd_Invalid=2);
    issue_date_yyyymmdd_Total_ErrorCount := COUNT(GROUP,h.issue_date_yyyymmdd_Invalid>0);
    license_status_ALLOW_ErrorCount := COUNT(GROUP,h.license_status_Invalid=1);
    license_status_LENGTH_ErrorCount := COUNT(GROUP,h.license_status_Invalid=2);
    license_status_Total_ErrorCount := COUNT(GROUP,h.license_status_Invalid>0);
    process_date_CUSTOM_ErrorCount := COUNT(GROUP,h.process_date_Invalid=1);
    process_date_LENGTH_ErrorCount := COUNT(GROUP,h.process_date_Invalid=2);
    process_date_Total_ErrorCount := COUNT(GROUP,h.process_date_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT34.StrType ErrorMessage;
    SALT34.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.pers_surrogate_Invalid,le.license_licno_Invalid,le.license_bdate_yyyymmdd_Invalid,le.license_edate_yyyymmdd_Invalid,le.license_lic_class_Invalid,le.license_height_Invalid,le.license_sex_Invalid,le.license_last_name_Invalid,le.license_first_name_Invalid,le.license_middle_name_Invalid,le.licmail_state_Invalid,le.licmail_zip_Invalid,le.licresi_street1_Invalid,le.licresi_street2_Invalid,le.licresi_city_Invalid,le.licresi_state_Invalid,le.licresi_zip_Invalid,le.issue_date_yyyymmdd_Invalid,le.license_status_Invalid,le.process_date_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_pers_surrogate(le.pers_surrogate_Invalid),Fields.InvalidMessage_license_licno(le.license_licno_Invalid),Fields.InvalidMessage_license_bdate_yyyymmdd(le.license_bdate_yyyymmdd_Invalid),Fields.InvalidMessage_license_edate_yyyymmdd(le.license_edate_yyyymmdd_Invalid),Fields.InvalidMessage_license_lic_class(le.license_lic_class_Invalid),Fields.InvalidMessage_license_height(le.license_height_Invalid),Fields.InvalidMessage_license_sex(le.license_sex_Invalid),Fields.InvalidMessage_license_last_name(le.license_last_name_Invalid),Fields.InvalidMessage_license_first_name(le.license_first_name_Invalid),Fields.InvalidMessage_license_middle_name(le.license_middle_name_Invalid),Fields.InvalidMessage_licmail_state(le.licmail_state_Invalid),Fields.InvalidMessage_licmail_zip(le.licmail_zip_Invalid),Fields.InvalidMessage_licresi_street1(le.licresi_street1_Invalid),Fields.InvalidMessage_licresi_street2(le.licresi_street2_Invalid),Fields.InvalidMessage_licresi_city(le.licresi_city_Invalid),Fields.InvalidMessage_licresi_state(le.licresi_state_Invalid),Fields.InvalidMessage_licresi_zip(le.licresi_zip_Invalid),Fields.InvalidMessage_issue_date_yyyymmdd(le.issue_date_yyyymmdd_Invalid),Fields.InvalidMessage_license_status(le.license_status_Invalid),Fields.InvalidMessage_process_date(le.process_date_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.pers_surrogate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_licno_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_bdate_yyyymmdd_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_edate_yyyymmdd_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_lic_class_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_height_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_sex_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.license_last_name_Invalid,'CAPS','ALLOW','CUSTOM','UNKNOWN')
          ,CHOOSE(le.license_first_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.license_middle_name_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.licmail_state_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.licmail_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.licresi_street1_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.licresi_street2_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.licresi_city_Invalid,'CAPS','ALLOW','UNKNOWN')
          ,CHOOSE(le.licresi_state_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.licresi_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.issue_date_yyyymmdd_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_status_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'pers_surrogate','license_licno','license_bdate_yyyymmdd','license_edate_yyyymmdd','license_lic_class','license_height','license_sex','license_last_name','license_first_name','license_middle_name','licmail_state','licmail_zip','licresi_street1','licresi_street2','licresi_city','licresi_state','licresi_zip','issue_date_yyyymmdd','license_status','process_date','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_pers_surrogate','invalid_license_licno','invalid_8pastdate','invalid_8date','invalid_license_lic_class','invalid_license_height','invalid_license_sex','invalid_license_name','invalid_wordbag','invalid_wordbag','invalid_licmail_state','invalid_mailzip','invalid_wordbag','invalid_wordbag','invalid_wordbag','invalid_licresi_state','invalid_resizip','invalid_08pastdate','invalid_license_status','invalid_8pastdate','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.pers_surrogate,(SALT34.StrType)le.license_licno,(SALT34.StrType)le.license_bdate_yyyymmdd,(SALT34.StrType)le.license_edate_yyyymmdd,(SALT34.StrType)le.license_lic_class,(SALT34.StrType)le.license_height,(SALT34.StrType)le.license_sex,(SALT34.StrType)le.license_last_name,(SALT34.StrType)le.license_first_name,(SALT34.StrType)le.license_middle_name,(SALT34.StrType)le.licmail_state,(SALT34.StrType)le.licmail_zip,(SALT34.StrType)le.licresi_street1,(SALT34.StrType)le.licresi_street2,(SALT34.StrType)le.licresi_city,(SALT34.StrType)le.licresi_state,(SALT34.StrType)le.licresi_zip,(SALT34.StrType)le.issue_date_yyyymmdd,(SALT34.StrType)le.license_status,(SALT34.StrType)le.process_date,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,20,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'pers_surrogate:invalid_pers_surrogate:ALLOW','pers_surrogate:invalid_pers_surrogate:LENGTH'
          ,'license_licno:invalid_license_licno:CUSTOM','license_licno:invalid_license_licno:LENGTH'
          ,'license_bdate_yyyymmdd:invalid_8pastdate:CUSTOM','license_bdate_yyyymmdd:invalid_8pastdate:LENGTH'
          ,'license_edate_yyyymmdd:invalid_8date:CUSTOM','license_edate_yyyymmdd:invalid_8date:LENGTH'
          ,'license_lic_class:invalid_license_lic_class:CUSTOM','license_lic_class:invalid_license_lic_class:LENGTH'
          ,'license_height:invalid_license_height:CUSTOM'
          ,'license_sex:invalid_license_sex:ENUM'
          ,'license_last_name:invalid_license_name:CAPS','license_last_name:invalid_license_name:ALLOW','license_last_name:invalid_license_name:CUSTOM'
          ,'license_first_name:invalid_wordbag:CAPS','license_first_name:invalid_wordbag:ALLOW'
          ,'license_middle_name:invalid_wordbag:CAPS','license_middle_name:invalid_wordbag:ALLOW'
          ,'licmail_state:invalid_licmail_state:CUSTOM','licmail_state:invalid_licmail_state:LENGTH'
          ,'licmail_zip:invalid_mailzip:ALLOW','licmail_zip:invalid_mailzip:LENGTH'
          ,'licresi_street1:invalid_wordbag:CAPS','licresi_street1:invalid_wordbag:ALLOW'
          ,'licresi_street2:invalid_wordbag:CAPS','licresi_street2:invalid_wordbag:ALLOW'
          ,'licresi_city:invalid_wordbag:CAPS','licresi_city:invalid_wordbag:ALLOW'
          ,'licresi_state:invalid_licresi_state:CUSTOM','licresi_state:invalid_licresi_state:LENGTH'
          ,'licresi_zip:invalid_resizip:ALLOW','licresi_zip:invalid_resizip:LENGTH'
          ,'issue_date_yyyymmdd:invalid_08pastdate:CUSTOM','issue_date_yyyymmdd:invalid_08pastdate:LENGTH'
          ,'license_status:invalid_license_status:ALLOW','license_status:invalid_license_status:LENGTH'
          ,'process_date:invalid_8pastdate:CUSTOM','process_date:invalid_8pastdate:LENGTH','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_pers_surrogate(1),Fields.InvalidMessage_pers_surrogate(2)
          ,Fields.InvalidMessage_license_licno(1),Fields.InvalidMessage_license_licno(2)
          ,Fields.InvalidMessage_license_bdate_yyyymmdd(1),Fields.InvalidMessage_license_bdate_yyyymmdd(2)
          ,Fields.InvalidMessage_license_edate_yyyymmdd(1),Fields.InvalidMessage_license_edate_yyyymmdd(2)
          ,Fields.InvalidMessage_license_lic_class(1),Fields.InvalidMessage_license_lic_class(2)
          ,Fields.InvalidMessage_license_height(1)
          ,Fields.InvalidMessage_license_sex(1)
          ,Fields.InvalidMessage_license_last_name(1),Fields.InvalidMessage_license_last_name(2),Fields.InvalidMessage_license_last_name(3)
          ,Fields.InvalidMessage_license_first_name(1),Fields.InvalidMessage_license_first_name(2)
          ,Fields.InvalidMessage_license_middle_name(1),Fields.InvalidMessage_license_middle_name(2)
          ,Fields.InvalidMessage_licmail_state(1),Fields.InvalidMessage_licmail_state(2)
          ,Fields.InvalidMessage_licmail_zip(1),Fields.InvalidMessage_licmail_zip(2)
          ,Fields.InvalidMessage_licresi_street1(1),Fields.InvalidMessage_licresi_street1(2)
          ,Fields.InvalidMessage_licresi_street2(1),Fields.InvalidMessage_licresi_street2(2)
          ,Fields.InvalidMessage_licresi_city(1),Fields.InvalidMessage_licresi_city(2)
          ,Fields.InvalidMessage_licresi_state(1),Fields.InvalidMessage_licresi_state(2)
          ,Fields.InvalidMessage_licresi_zip(1),Fields.InvalidMessage_licresi_zip(2)
          ,Fields.InvalidMessage_issue_date_yyyymmdd(1),Fields.InvalidMessage_issue_date_yyyymmdd(2)
          ,Fields.InvalidMessage_license_status(1),Fields.InvalidMessage_license_status(2)
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.pers_surrogate_ALLOW_ErrorCount,le.pers_surrogate_LENGTH_ErrorCount
          ,le.license_licno_CUSTOM_ErrorCount,le.license_licno_LENGTH_ErrorCount
          ,le.license_bdate_yyyymmdd_CUSTOM_ErrorCount,le.license_bdate_yyyymmdd_LENGTH_ErrorCount
          ,le.license_edate_yyyymmdd_CUSTOM_ErrorCount,le.license_edate_yyyymmdd_LENGTH_ErrorCount
          ,le.license_lic_class_CUSTOM_ErrorCount,le.license_lic_class_LENGTH_ErrorCount
          ,le.license_height_CUSTOM_ErrorCount
          ,le.license_sex_ENUM_ErrorCount
          ,le.license_last_name_CAPS_ErrorCount,le.license_last_name_ALLOW_ErrorCount,le.license_last_name_CUSTOM_ErrorCount
          ,le.license_first_name_CAPS_ErrorCount,le.license_first_name_ALLOW_ErrorCount
          ,le.license_middle_name_CAPS_ErrorCount,le.license_middle_name_ALLOW_ErrorCount
          ,le.licmail_state_CUSTOM_ErrorCount,le.licmail_state_LENGTH_ErrorCount
          ,le.licmail_zip_ALLOW_ErrorCount,le.licmail_zip_LENGTH_ErrorCount
          ,le.licresi_street1_CAPS_ErrorCount,le.licresi_street1_ALLOW_ErrorCount
          ,le.licresi_street2_CAPS_ErrorCount,le.licresi_street2_ALLOW_ErrorCount
          ,le.licresi_city_CAPS_ErrorCount,le.licresi_city_ALLOW_ErrorCount
          ,le.licresi_state_CUSTOM_ErrorCount,le.licresi_state_LENGTH_ErrorCount
          ,le.licresi_zip_ALLOW_ErrorCount,le.licresi_zip_LENGTH_ErrorCount
          ,le.issue_date_yyyymmdd_CUSTOM_ErrorCount,le.issue_date_yyyymmdd_LENGTH_ErrorCount
          ,le.license_status_ALLOW_ErrorCount,le.license_status_LENGTH_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.pers_surrogate_ALLOW_ErrorCount,le.pers_surrogate_LENGTH_ErrorCount
          ,le.license_licno_CUSTOM_ErrorCount,le.license_licno_LENGTH_ErrorCount
          ,le.license_bdate_yyyymmdd_CUSTOM_ErrorCount,le.license_bdate_yyyymmdd_LENGTH_ErrorCount
          ,le.license_edate_yyyymmdd_CUSTOM_ErrorCount,le.license_edate_yyyymmdd_LENGTH_ErrorCount
          ,le.license_lic_class_CUSTOM_ErrorCount,le.license_lic_class_LENGTH_ErrorCount
          ,le.license_height_CUSTOM_ErrorCount
          ,le.license_sex_ENUM_ErrorCount
          ,le.license_last_name_CAPS_ErrorCount,le.license_last_name_ALLOW_ErrorCount,le.license_last_name_CUSTOM_ErrorCount
          ,le.license_first_name_CAPS_ErrorCount,le.license_first_name_ALLOW_ErrorCount
          ,le.license_middle_name_CAPS_ErrorCount,le.license_middle_name_ALLOW_ErrorCount
          ,le.licmail_state_CUSTOM_ErrorCount,le.licmail_state_LENGTH_ErrorCount
          ,le.licmail_zip_ALLOW_ErrorCount,le.licmail_zip_LENGTH_ErrorCount
          ,le.licresi_street1_CAPS_ErrorCount,le.licresi_street1_ALLOW_ErrorCount
          ,le.licresi_street2_CAPS_ErrorCount,le.licresi_street2_ALLOW_ErrorCount
          ,le.licresi_city_CAPS_ErrorCount,le.licresi_city_ALLOW_ErrorCount
          ,le.licresi_state_CUSTOM_ErrorCount,le.licresi_state_LENGTH_ErrorCount
          ,le.licresi_zip_ALLOW_ErrorCount,le.licresi_zip_LENGTH_ErrorCount
          ,le.issue_date_yyyymmdd_CUSTOM_ErrorCount,le.issue_date_yyyymmdd_LENGTH_ErrorCount
          ,le.license_status_ALLOW_ErrorCount,le.license_status_LENGTH_ErrorCount
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,39,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT34.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT34.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
