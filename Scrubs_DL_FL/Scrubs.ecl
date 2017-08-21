IMPORT ut,SALT34;
IMPORT Scrubs,Scrubs_DL_FL; // Import modules for FieldTypes attribute definitions
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_In_FL)
    UNSIGNED1 process_date_Invalid;
    UNSIGNED1 issuance_Invalid;
    UNSIGNED1 address_change_Invalid;
    UNSIGNED1 name_change_Invalid;
    UNSIGNED1 dob_change_Invalid;
    UNSIGNED1 sex_change_Invalid;
    UNSIGNED1 name_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 race_Invalid;
    UNSIGNED1 sex_flag_Invalid;
    UNSIGNED1 license_type_Invalid;
    UNSIGNED1 attention_flag_Invalid;
    UNSIGNED1 dod_Invalid;
    UNSIGNED1 restrictions_Invalid;
    UNSIGNED1 orig_expiration_date_Invalid;
    UNSIGNED1 lic_issue_date_Invalid;
    UNSIGNED1 lic_endorsement_Invalid;
    UNSIGNED1 dl_number_Invalid;
    UNSIGNED1 ssn_Invalid;
    UNSIGNED1 age_Invalid;
    UNSIGNED1 new_dl_number_Invalid;
    UNSIGNED1 personal_info_flag_Invalid;
    UNSIGNED1 dl_orig_issue_date_Invalid;
    UNSIGNED1 height_Invalid;
    UNSIGNED1 oos_previous_st_Invalid;
    UNSIGNED1 fname_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_In_FL)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_In_FL) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.process_date_Invalid := Fields.InValid_process_date((SALT34.StrType)le.process_date);
    SELF.issuance_Invalid := Fields.InValid_issuance((SALT34.StrType)le.issuance);
    SELF.address_change_Invalid := Fields.InValid_address_change((SALT34.StrType)le.address_change);
    SELF.name_change_Invalid := Fields.InValid_name_change((SALT34.StrType)le.name_change);
    SELF.dob_change_Invalid := Fields.InValid_dob_change((SALT34.StrType)le.dob_change);
    SELF.sex_change_Invalid := Fields.InValid_sex_change((SALT34.StrType)le.sex_change);
    SELF.name_Invalid := Fields.InValid_name((SALT34.StrType)le.name);
    SELF.city_Invalid := Fields.InValid_city((SALT34.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT34.StrType)le.state);
    SELF.zip_Invalid := Fields.InValid_zip((SALT34.StrType)le.zip);
    SELF.dob_Invalid := Fields.InValid_dob((SALT34.StrType)le.dob);
    SELF.race_Invalid := Fields.InValid_race((SALT34.StrType)le.race);
    SELF.sex_flag_Invalid := Fields.InValid_sex_flag((SALT34.StrType)le.sex_flag);
    SELF.license_type_Invalid := Fields.InValid_license_type((SALT34.StrType)le.license_type);
    SELF.attention_flag_Invalid := Fields.InValid_attention_flag((SALT34.StrType)le.attention_flag);
    SELF.dod_Invalid := Fields.InValid_dod((SALT34.StrType)le.dod);
    SELF.restrictions_Invalid := Fields.InValid_restrictions((SALT34.StrType)le.restrictions);
    SELF.orig_expiration_date_Invalid := Fields.InValid_orig_expiration_date((SALT34.StrType)le.orig_expiration_date);
    SELF.lic_issue_date_Invalid := Fields.InValid_lic_issue_date((SALT34.StrType)le.lic_issue_date);
    SELF.lic_endorsement_Invalid := Fields.InValid_lic_endorsement((SALT34.StrType)le.lic_endorsement);
    SELF.dl_number_Invalid := Fields.InValid_dl_number((SALT34.StrType)le.dl_number);
    SELF.ssn_Invalid := Fields.InValid_ssn((SALT34.StrType)le.ssn);
    SELF.age_Invalid := Fields.InValid_age((SALT34.StrType)le.age);
    SELF.new_dl_number_Invalid := Fields.InValid_new_dl_number((SALT34.StrType)le.new_dl_number);
    SELF.personal_info_flag_Invalid := Fields.InValid_personal_info_flag((SALT34.StrType)le.personal_info_flag);
    SELF.dl_orig_issue_date_Invalid := Fields.InValid_dl_orig_issue_date((SALT34.StrType)le.dl_orig_issue_date);
    SELF.height_Invalid := Fields.InValid_height((SALT34.StrType)le.height);
    SELF.oos_previous_st_Invalid := Fields.InValid_oos_previous_st((SALT34.StrType)le.oos_previous_st);
    SELF.fname_Invalid := Fields.InValid_fname((SALT34.StrType)le.fname,(SALT34.StrType)le.mname,(SALT34.StrType)le.lname);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_In_FL);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.process_date_Invalid << 0 ) + ( le.issuance_Invalid << 2 ) + ( le.address_change_Invalid << 3 ) + ( le.name_change_Invalid << 4 ) + ( le.dob_change_Invalid << 5 ) + ( le.sex_change_Invalid << 6 ) + ( le.name_Invalid << 7 ) + ( le.city_Invalid << 8 ) + ( le.state_Invalid << 9 ) + ( le.zip_Invalid << 11 ) + ( le.dob_Invalid << 13 ) + ( le.race_Invalid << 15 ) + ( le.sex_flag_Invalid << 17 ) + ( le.license_type_Invalid << 19 ) + ( le.attention_flag_Invalid << 20 ) + ( le.dod_Invalid << 21 ) + ( le.restrictions_Invalid << 23 ) + ( le.orig_expiration_date_Invalid << 24 ) + ( le.lic_issue_date_Invalid << 26 ) + ( le.lic_endorsement_Invalid << 28 ) + ( le.dl_number_Invalid << 29 ) + ( le.ssn_Invalid << 31 ) + ( le.age_Invalid << 32 ) + ( le.new_dl_number_Invalid << 34 ) + ( le.personal_info_flag_Invalid << 36 ) + ( le.dl_orig_issue_date_Invalid << 37 ) + ( le.height_Invalid << 39 ) + ( le.oos_previous_st_Invalid << 41 ) + ( le.fname_Invalid << 43 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_In_FL);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.process_date_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.issuance_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.address_change_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.name_change_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.dob_change_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.sex_change_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.name_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 13) & 3;
    SELF.race_Invalid := (le.ScrubsBits1 >> 15) & 3;
    SELF.sex_flag_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.license_type_Invalid := (le.ScrubsBits1 >> 19) & 1;
    SELF.attention_flag_Invalid := (le.ScrubsBits1 >> 20) & 1;
    SELF.dod_Invalid := (le.ScrubsBits1 >> 21) & 3;
    SELF.restrictions_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.orig_expiration_date_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.lic_issue_date_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.lic_endorsement_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF.dl_number_Invalid := (le.ScrubsBits1 >> 29) & 3;
    SELF.ssn_Invalid := (le.ScrubsBits1 >> 31) & 1;
    SELF.age_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.new_dl_number_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.personal_info_flag_Invalid := (le.ScrubsBits1 >> 36) & 1;
    SELF.dl_orig_issue_date_Invalid := (le.ScrubsBits1 >> 37) & 3;
    SELF.height_Invalid := (le.ScrubsBits1 >> 39) & 3;
    SELF.oos_previous_st_Invalid := (le.ScrubsBits1 >> 41) & 3;
    SELF.fname_Invalid := (le.ScrubsBits1 >> 43) & 1;
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
    issuance_ALLOW_ErrorCount := COUNT(GROUP,h.issuance_Invalid=1);
    address_change_ALLOW_ErrorCount := COUNT(GROUP,h.address_change_Invalid=1);
    name_change_ALLOW_ErrorCount := COUNT(GROUP,h.name_change_Invalid=1);
    dob_change_ALLOW_ErrorCount := COUNT(GROUP,h.dob_change_Invalid=1);
    sex_change_ALLOW_ErrorCount := COUNT(GROUP,h.sex_change_Invalid=1);
    name_LENGTH_ErrorCount := COUNT(GROUP,h.name_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ALLOW_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    state_LENGTH_ErrorCount := COUNT(GROUP,h.state_Invalid=2);
    state_Total_ErrorCount := COUNT(GROUP,h.state_Invalid>0);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTH_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTH_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    race_ALLOW_ErrorCount := COUNT(GROUP,h.race_Invalid=1);
    race_LENGTH_ErrorCount := COUNT(GROUP,h.race_Invalid=2);
    race_Total_ErrorCount := COUNT(GROUP,h.race_Invalid>0);
    sex_flag_ALLOW_ErrorCount := COUNT(GROUP,h.sex_flag_Invalid=1);
    sex_flag_LENGTH_ErrorCount := COUNT(GROUP,h.sex_flag_Invalid=2);
    sex_flag_Total_ErrorCount := COUNT(GROUP,h.sex_flag_Invalid>0);
    license_type_ENUM_ErrorCount := COUNT(GROUP,h.license_type_Invalid=1);
    attention_flag_ENUM_ErrorCount := COUNT(GROUP,h.attention_flag_Invalid=1);
    dod_ALLOW_ErrorCount := COUNT(GROUP,h.dod_Invalid=1);
    dod_LENGTH_ErrorCount := COUNT(GROUP,h.dod_Invalid=2);
    dod_Total_ErrorCount := COUNT(GROUP,h.dod_Invalid>0);
    restrictions_CUSTOM_ErrorCount := COUNT(GROUP,h.restrictions_Invalid=1);
    orig_expiration_date_CUSTOM_ErrorCount := COUNT(GROUP,h.orig_expiration_date_Invalid=1);
    orig_expiration_date_LENGTH_ErrorCount := COUNT(GROUP,h.orig_expiration_date_Invalid=2);
    orig_expiration_date_Total_ErrorCount := COUNT(GROUP,h.orig_expiration_date_Invalid>0);
    lic_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.lic_issue_date_Invalid=1);
    lic_issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.lic_issue_date_Invalid=2);
    lic_issue_date_Total_ErrorCount := COUNT(GROUP,h.lic_issue_date_Invalid>0);
    lic_endorsement_CUSTOM_ErrorCount := COUNT(GROUP,h.lic_endorsement_Invalid=1);
    dl_number_CUSTOM_ErrorCount := COUNT(GROUP,h.dl_number_Invalid=1);
    dl_number_LENGTH_ErrorCount := COUNT(GROUP,h.dl_number_Invalid=2);
    dl_number_Total_ErrorCount := COUNT(GROUP,h.dl_number_Invalid>0);
    ssn_LENGTH_ErrorCount := COUNT(GROUP,h.ssn_Invalid=1);
    age_ALLOW_ErrorCount := COUNT(GROUP,h.age_Invalid=1);
    age_LENGTH_ErrorCount := COUNT(GROUP,h.age_Invalid=2);
    age_Total_ErrorCount := COUNT(GROUP,h.age_Invalid>0);
    new_dl_number_CUSTOM_ErrorCount := COUNT(GROUP,h.new_dl_number_Invalid=1);
    new_dl_number_LENGTH_ErrorCount := COUNT(GROUP,h.new_dl_number_Invalid=2);
    new_dl_number_Total_ErrorCount := COUNT(GROUP,h.new_dl_number_Invalid>0);
    personal_info_flag_LENGTH_ErrorCount := COUNT(GROUP,h.personal_info_flag_Invalid=1);
    dl_orig_issue_date_CUSTOM_ErrorCount := COUNT(GROUP,h.dl_orig_issue_date_Invalid=1);
    dl_orig_issue_date_LENGTH_ErrorCount := COUNT(GROUP,h.dl_orig_issue_date_Invalid=2);
    dl_orig_issue_date_Total_ErrorCount := COUNT(GROUP,h.dl_orig_issue_date_Invalid>0);
    height_ALLOW_ErrorCount := COUNT(GROUP,h.height_Invalid=1);
    height_LENGTH_ErrorCount := COUNT(GROUP,h.height_Invalid=2);
    height_Total_ErrorCount := COUNT(GROUP,h.height_Invalid>0);
    oos_previous_st_ALLOW_ErrorCount := COUNT(GROUP,h.oos_previous_st_Invalid=1);
    oos_previous_st_LENGTH_ErrorCount := COUNT(GROUP,h.oos_previous_st_Invalid=2);
    oos_previous_st_Total_ErrorCount := COUNT(GROUP,h.oos_previous_st_Invalid>0);
    fname_CUSTOM_ErrorCount := COUNT(GROUP,h.fname_Invalid=1);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.process_date_Invalid,le.issuance_Invalid,le.address_change_Invalid,le.name_change_Invalid,le.dob_change_Invalid,le.sex_change_Invalid,le.name_Invalid,le.city_Invalid,le.state_Invalid,le.zip_Invalid,le.dob_Invalid,le.race_Invalid,le.sex_flag_Invalid,le.license_type_Invalid,le.attention_flag_Invalid,le.dod_Invalid,le.restrictions_Invalid,le.orig_expiration_date_Invalid,le.lic_issue_date_Invalid,le.lic_endorsement_Invalid,le.dl_number_Invalid,le.ssn_Invalid,le.age_Invalid,le.new_dl_number_Invalid,le.personal_info_flag_Invalid,le.dl_orig_issue_date_Invalid,le.height_Invalid,le.oos_previous_st_Invalid,le.fname_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_process_date(le.process_date_Invalid),Fields.InvalidMessage_issuance(le.issuance_Invalid),Fields.InvalidMessage_address_change(le.address_change_Invalid),Fields.InvalidMessage_name_change(le.name_change_Invalid),Fields.InvalidMessage_dob_change(le.dob_change_Invalid),Fields.InvalidMessage_sex_change(le.sex_change_Invalid),Fields.InvalidMessage_name(le.name_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_race(le.race_Invalid),Fields.InvalidMessage_sex_flag(le.sex_flag_Invalid),Fields.InvalidMessage_license_type(le.license_type_Invalid),Fields.InvalidMessage_attention_flag(le.attention_flag_Invalid),Fields.InvalidMessage_dod(le.dod_Invalid),Fields.InvalidMessage_restrictions(le.restrictions_Invalid),Fields.InvalidMessage_orig_expiration_date(le.orig_expiration_date_Invalid),Fields.InvalidMessage_lic_issue_date(le.lic_issue_date_Invalid),Fields.InvalidMessage_lic_endorsement(le.lic_endorsement_Invalid),Fields.InvalidMessage_dl_number(le.dl_number_Invalid),Fields.InvalidMessage_ssn(le.ssn_Invalid),Fields.InvalidMessage_age(le.age_Invalid),Fields.InvalidMessage_new_dl_number(le.new_dl_number_Invalid),Fields.InvalidMessage_personal_info_flag(le.personal_info_flag_Invalid),Fields.InvalidMessage_dl_orig_issue_date(le.dl_orig_issue_date_Invalid),Fields.InvalidMessage_height(le.height_Invalid),Fields.InvalidMessage_oos_previous_st(le.oos_previous_st_Invalid),Fields.InvalidMessage_fname(le.fname_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.process_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.issuance_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.address_change_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_change_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_change_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.sex_change_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.name_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.race_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.sex_flag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.license_type_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.attention_flag_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dod_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.restrictions_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.orig_expiration_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.lic_issue_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.lic_endorsement_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dl_number_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.ssn_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.age_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.new_dl_number_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.personal_info_flag_Invalid,'LENGTH','UNKNOWN')
          ,CHOOSE(le.dl_orig_issue_date_Invalid,'CUSTOM','LENGTH','UNKNOWN')
          ,CHOOSE(le.height_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.oos_previous_st_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.fname_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'process_date','issuance','address_change','name_change','dob_change','sex_change','name','city','state','zip','dob','race','sex_flag','license_type','attention_flag','dod','restrictions','orig_expiration_date','lic_issue_date','lic_endorsement','dl_number','ssn','age','new_dl_number','personal_info_flag','dl_orig_issue_date','height','oos_previous_st','fname','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_process_date','invalid_issuance','invalid_boolean_yes_no','invalid_boolean_yes_no','invalid_boolean_yes_no','invalid_boolean_yes_no','invalid_mandatory','invalid_specials','invalid_state','invalid_zip','invalid_8pastdate','invalid_race','invalid_sex_flag','invalid_license_type','invalid_attention_flag','invalid_dod','invalid_restrictions','invalid_08date','invalid_8pastdate','invalid_lic_endorsement','invalid_dl_number','invalid_empty','invalid_age','invalid_new_dl_number','invalid_empty','invalid_8pastdate','invalid_height','invalid_oos_previous_st','invalid_name','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT34.StrType)le.process_date,(SALT34.StrType)le.issuance,(SALT34.StrType)le.address_change,(SALT34.StrType)le.name_change,(SALT34.StrType)le.dob_change,(SALT34.StrType)le.sex_change,(SALT34.StrType)le.name,(SALT34.StrType)le.city,(SALT34.StrType)le.state,(SALT34.StrType)le.zip,(SALT34.StrType)le.dob,(SALT34.StrType)le.race,(SALT34.StrType)le.sex_flag,(SALT34.StrType)le.license_type,(SALT34.StrType)le.attention_flag,(SALT34.StrType)le.dod,(SALT34.StrType)le.restrictions,(SALT34.StrType)le.orig_expiration_date,(SALT34.StrType)le.lic_issue_date,(SALT34.StrType)le.lic_endorsement,(SALT34.StrType)le.dl_number,(SALT34.StrType)le.ssn,(SALT34.StrType)le.age,(SALT34.StrType)le.new_dl_number,(SALT34.StrType)le.personal_info_flag,(SALT34.StrType)le.dl_orig_issue_date,(SALT34.StrType)le.height,(SALT34.StrType)le.oos_previous_st,(SALT34.StrType)le.fname,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,29,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT34.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'process_date:invalid_process_date:CUSTOM','process_date:invalid_process_date:LENGTH'
          ,'issuance:invalid_issuance:ALLOW'
          ,'address_change:invalid_boolean_yes_no:ALLOW'
          ,'name_change:invalid_boolean_yes_no:ALLOW'
          ,'dob_change:invalid_boolean_yes_no:ALLOW'
          ,'sex_change:invalid_boolean_yes_no:ALLOW'
          ,'name:invalid_mandatory:LENGTH'
          ,'city:invalid_specials:ALLOW'
          ,'state:invalid_state:ALLOW','state:invalid_state:LENGTH'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTH'
          ,'dob:invalid_8pastdate:CUSTOM','dob:invalid_8pastdate:LENGTH'
          ,'race:invalid_race:ALLOW','race:invalid_race:LENGTH'
          ,'sex_flag:invalid_sex_flag:ALLOW','sex_flag:invalid_sex_flag:LENGTH'
          ,'license_type:invalid_license_type:ENUM'
          ,'attention_flag:invalid_attention_flag:ENUM'
          ,'dod:invalid_dod:ALLOW','dod:invalid_dod:LENGTH'
          ,'restrictions:invalid_restrictions:CUSTOM'
          ,'orig_expiration_date:invalid_08date:CUSTOM','orig_expiration_date:invalid_08date:LENGTH'
          ,'lic_issue_date:invalid_8pastdate:CUSTOM','lic_issue_date:invalid_8pastdate:LENGTH'
          ,'lic_endorsement:invalid_lic_endorsement:CUSTOM'
          ,'dl_number:invalid_dl_number:CUSTOM','dl_number:invalid_dl_number:LENGTH'
          ,'ssn:invalid_empty:LENGTH'
          ,'age:invalid_age:ALLOW','age:invalid_age:LENGTH'
          ,'new_dl_number:invalid_new_dl_number:CUSTOM','new_dl_number:invalid_new_dl_number:LENGTH'
          ,'personal_info_flag:invalid_empty:LENGTH'
          ,'dl_orig_issue_date:invalid_8pastdate:CUSTOM','dl_orig_issue_date:invalid_8pastdate:LENGTH'
          ,'height:invalid_height:ALLOW','height:invalid_height:LENGTH'
          ,'oos_previous_st:invalid_oos_previous_st:ALLOW','oos_previous_st:invalid_oos_previous_st:LENGTH'
          ,'fname:invalid_name:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_process_date(1),Fields.InvalidMessage_process_date(2)
          ,Fields.InvalidMessage_issuance(1)
          ,Fields.InvalidMessage_address_change(1)
          ,Fields.InvalidMessage_name_change(1)
          ,Fields.InvalidMessage_dob_change(1)
          ,Fields.InvalidMessage_sex_change(1)
          ,Fields.InvalidMessage_name(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1),Fields.InvalidMessage_state(2)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2)
          ,Fields.InvalidMessage_race(1),Fields.InvalidMessage_race(2)
          ,Fields.InvalidMessage_sex_flag(1),Fields.InvalidMessage_sex_flag(2)
          ,Fields.InvalidMessage_license_type(1)
          ,Fields.InvalidMessage_attention_flag(1)
          ,Fields.InvalidMessage_dod(1),Fields.InvalidMessage_dod(2)
          ,Fields.InvalidMessage_restrictions(1)
          ,Fields.InvalidMessage_orig_expiration_date(1),Fields.InvalidMessage_orig_expiration_date(2)
          ,Fields.InvalidMessage_lic_issue_date(1),Fields.InvalidMessage_lic_issue_date(2)
          ,Fields.InvalidMessage_lic_endorsement(1)
          ,Fields.InvalidMessage_dl_number(1),Fields.InvalidMessage_dl_number(2)
          ,Fields.InvalidMessage_ssn(1)
          ,Fields.InvalidMessage_age(1),Fields.InvalidMessage_age(2)
          ,Fields.InvalidMessage_new_dl_number(1),Fields.InvalidMessage_new_dl_number(2)
          ,Fields.InvalidMessage_personal_info_flag(1)
          ,Fields.InvalidMessage_dl_orig_issue_date(1),Fields.InvalidMessage_dl_orig_issue_date(2)
          ,Fields.InvalidMessage_height(1),Fields.InvalidMessage_height(2)
          ,Fields.InvalidMessage_oos_previous_st(1),Fields.InvalidMessage_oos_previous_st(2)
          ,Fields.InvalidMessage_fname(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.issuance_ALLOW_ErrorCount
          ,le.address_change_ALLOW_ErrorCount
          ,le.name_change_ALLOW_ErrorCount
          ,le.dob_change_ALLOW_ErrorCount
          ,le.sex_change_ALLOW_ErrorCount
          ,le.name_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.race_ALLOW_ErrorCount,le.race_LENGTH_ErrorCount
          ,le.sex_flag_ALLOW_ErrorCount,le.sex_flag_LENGTH_ErrorCount
          ,le.license_type_ENUM_ErrorCount
          ,le.attention_flag_ENUM_ErrorCount
          ,le.dod_ALLOW_ErrorCount,le.dod_LENGTH_ErrorCount
          ,le.restrictions_CUSTOM_ErrorCount
          ,le.orig_expiration_date_CUSTOM_ErrorCount,le.orig_expiration_date_LENGTH_ErrorCount
          ,le.lic_issue_date_CUSTOM_ErrorCount,le.lic_issue_date_LENGTH_ErrorCount
          ,le.lic_endorsement_CUSTOM_ErrorCount
          ,le.dl_number_CUSTOM_ErrorCount,le.dl_number_LENGTH_ErrorCount
          ,le.ssn_LENGTH_ErrorCount
          ,le.age_ALLOW_ErrorCount,le.age_LENGTH_ErrorCount
          ,le.new_dl_number_CUSTOM_ErrorCount,le.new_dl_number_LENGTH_ErrorCount
          ,le.personal_info_flag_LENGTH_ErrorCount
          ,le.dl_orig_issue_date_CUSTOM_ErrorCount,le.dl_orig_issue_date_LENGTH_ErrorCount
          ,le.height_ALLOW_ErrorCount,le.height_LENGTH_ErrorCount
          ,le.oos_previous_st_ALLOW_ErrorCount,le.oos_previous_st_LENGTH_ErrorCount
          ,le.fname_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.process_date_CUSTOM_ErrorCount,le.process_date_LENGTH_ErrorCount
          ,le.issuance_ALLOW_ErrorCount
          ,le.address_change_ALLOW_ErrorCount
          ,le.name_change_ALLOW_ErrorCount
          ,le.dob_change_ALLOW_ErrorCount
          ,le.sex_change_ALLOW_ErrorCount
          ,le.name_LENGTH_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ALLOW_ErrorCount,le.state_LENGTH_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTH_ErrorCount
          ,le.dob_CUSTOM_ErrorCount,le.dob_LENGTH_ErrorCount
          ,le.race_ALLOW_ErrorCount,le.race_LENGTH_ErrorCount
          ,le.sex_flag_ALLOW_ErrorCount,le.sex_flag_LENGTH_ErrorCount
          ,le.license_type_ENUM_ErrorCount
          ,le.attention_flag_ENUM_ErrorCount
          ,le.dod_ALLOW_ErrorCount,le.dod_LENGTH_ErrorCount
          ,le.restrictions_CUSTOM_ErrorCount
          ,le.orig_expiration_date_CUSTOM_ErrorCount,le.orig_expiration_date_LENGTH_ErrorCount
          ,le.lic_issue_date_CUSTOM_ErrorCount,le.lic_issue_date_LENGTH_ErrorCount
          ,le.lic_endorsement_CUSTOM_ErrorCount
          ,le.dl_number_CUSTOM_ErrorCount,le.dl_number_LENGTH_ErrorCount
          ,le.ssn_LENGTH_ErrorCount
          ,le.age_ALLOW_ErrorCount,le.age_LENGTH_ErrorCount
          ,le.new_dl_number_CUSTOM_ErrorCount,le.new_dl_number_LENGTH_ErrorCount
          ,le.personal_info_flag_LENGTH_ErrorCount
          ,le.dl_orig_issue_date_CUSTOM_ErrorCount,le.dl_orig_issue_date_LENGTH_ErrorCount
          ,le.height_ALLOW_ErrorCount,le.height_LENGTH_ErrorCount
          ,le.oos_previous_st_ALLOW_ErrorCount,le.oos_previous_st_LENGTH_ErrorCount
          ,le.fname_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,44,Into(LEFT,COUNTER));
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
