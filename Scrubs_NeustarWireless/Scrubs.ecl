IMPORT SALT311,STD;
EXPORT Scrubs := MODULE
 
// The module to handle the case where no scrubs exist
  EXPORT NumRules := 29;
  EXPORT NumRulesFromFieldType := 29;
  EXPORT NumRulesFromRecordType := 0;
  EXPORT NumFieldsWithRules := 23;
  EXPORT NumFieldsWithPossibleEdits := 0;
  EXPORT NumRulesWithPossibleEdits := 0;
  EXPORT Expanded_Layout := RECORD(Layout_NeustarWireless)
    UNSIGNED1 phone_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 pre_dir_Invalid;
    UNSIGNED1 street_type_Invalid;
    UNSIGNED1 post_dir_Invalid;
    UNSIGNED1 apt_type_Invalid;
    UNSIGNED1 zip_Invalid;
    UNSIGNED1 plus4_Invalid;
    UNSIGNED1 dpc_Invalid;
    UNSIGNED1 z4_type_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 state_Invalid;
    UNSIGNED1 fips_state_Invalid;
    UNSIGNED1 fips_county_Invalid;
    UNSIGNED1 cbsa_Invalid;
    UNSIGNED1 latitude_Invalid;
    UNSIGNED1 longitude_Invalid;
    UNSIGNED1 email_Invalid;
    UNSIGNED1 verified_Invalid;
    UNSIGNED1 activity_status_Invalid;
    UNSIGNED1 prepaid_Invalid;
    UNSIGNED1 cord_cutter_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_NeustarWireless)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_NeustarWireless) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.phone_Invalid := Fields.InValid_phone((SALT311.StrType)le.phone);
    SELF.gender_Invalid := Fields.InValid_gender((SALT311.StrType)le.gender);
    SELF.dob_Invalid := Fields.InValid_dob((SALT311.StrType)le.dob);
    SELF.pre_dir_Invalid := Fields.InValid_pre_dir((SALT311.StrType)le.pre_dir);
    SELF.street_type_Invalid := Fields.InValid_street_type((SALT311.StrType)le.street_type);
    SELF.post_dir_Invalid := Fields.InValid_post_dir((SALT311.StrType)le.post_dir);
    SELF.apt_type_Invalid := Fields.InValid_apt_type((SALT311.StrType)le.apt_type);
    SELF.zip_Invalid := Fields.InValid_zip((SALT311.StrType)le.zip);
    SELF.plus4_Invalid := Fields.InValid_plus4((SALT311.StrType)le.plus4);
    SELF.dpc_Invalid := Fields.InValid_dpc((SALT311.StrType)le.dpc);
    SELF.z4_type_Invalid := Fields.InValid_z4_type((SALT311.StrType)le.z4_type);
    SELF.city_Invalid := Fields.InValid_city((SALT311.StrType)le.city);
    SELF.state_Invalid := Fields.InValid_state((SALT311.StrType)le.state);
    SELF.fips_state_Invalid := Fields.InValid_fips_state((SALT311.StrType)le.fips_state);
    SELF.fips_county_Invalid := Fields.InValid_fips_county((SALT311.StrType)le.fips_county);
    SELF.cbsa_Invalid := Fields.InValid_cbsa((SALT311.StrType)le.cbsa);
    SELF.latitude_Invalid := Fields.InValid_latitude((SALT311.StrType)le.latitude);
    SELF.longitude_Invalid := Fields.InValid_longitude((SALT311.StrType)le.longitude);
    SELF.email_Invalid := Fields.InValid_email((SALT311.StrType)le.email);
    SELF.verified_Invalid := Fields.InValid_verified((SALT311.StrType)le.verified);
    SELF.activity_status_Invalid := Fields.InValid_activity_status((SALT311.StrType)le.activity_status);
    SELF.prepaid_Invalid := Fields.InValid_prepaid((SALT311.StrType)le.prepaid);
    SELF.cord_cutter_Invalid := Fields.InValid_cord_cutter((SALT311.StrType)le.cord_cutter);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),Layout_NeustarWireless);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.phone_Invalid << 0 ) + ( le.gender_Invalid << 2 ) + ( le.dob_Invalid << 3 ) + ( le.pre_dir_Invalid << 5 ) + ( le.street_type_Invalid << 6 ) + ( le.post_dir_Invalid << 7 ) + ( le.apt_type_Invalid << 8 ) + ( le.zip_Invalid << 9 ) + ( le.plus4_Invalid << 11 ) + ( le.dpc_Invalid << 13 ) + ( le.z4_type_Invalid << 14 ) + ( le.city_Invalid << 15 ) + ( le.state_Invalid << 16 ) + ( le.fips_state_Invalid << 17 ) + ( le.fips_county_Invalid << 19 ) + ( le.cbsa_Invalid << 21 ) + ( le.latitude_Invalid << 22 ) + ( le.longitude_Invalid << 23 ) + ( le.email_Invalid << 24 ) + ( le.verified_Invalid << 25 ) + ( le.activity_status_Invalid << 26 ) + ( le.prepaid_Invalid << 27 ) + ( le.cord_cutter_Invalid << 28 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_NeustarWireless);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.phone_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 3) & 3;
    SELF.pre_dir_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.street_type_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.post_dir_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.apt_type_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.zip_Invalid := (le.ScrubsBits1 >> 9) & 3;
    SELF.plus4_Invalid := (le.ScrubsBits1 >> 11) & 3;
    SELF.dpc_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF.z4_type_Invalid := (le.ScrubsBits1 >> 14) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 15) & 1;
    SELF.state_Invalid := (le.ScrubsBits1 >> 16) & 1;
    SELF.fips_state_Invalid := (le.ScrubsBits1 >> 17) & 3;
    SELF.fips_county_Invalid := (le.ScrubsBits1 >> 19) & 3;
    SELF.cbsa_Invalid := (le.ScrubsBits1 >> 21) & 1;
    SELF.latitude_Invalid := (le.ScrubsBits1 >> 22) & 1;
    SELF.longitude_Invalid := (le.ScrubsBits1 >> 23) & 1;
    SELF.email_Invalid := (le.ScrubsBits1 >> 24) & 1;
    SELF.verified_Invalid := (le.ScrubsBits1 >> 25) & 1;
    SELF.activity_status_Invalid := (le.ScrubsBits1 >> 26) & 1;
    SELF.prepaid_Invalid := (le.ScrubsBits1 >> 27) & 1;
    SELF.cord_cutter_Invalid := (le.ScrubsBits1 >> 28) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    phone_ALLOW_ErrorCount := COUNT(GROUP,h.phone_Invalid=1);
    phone_LENGTHS_ErrorCount := COUNT(GROUP,h.phone_Invalid=2);
    phone_Total_ErrorCount := COUNT(GROUP,h.phone_Invalid>0);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    dob_ALLOW_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    dob_LENGTHS_ErrorCount := COUNT(GROUP,h.dob_Invalid=2);
    dob_Total_ErrorCount := COUNT(GROUP,h.dob_Invalid>0);
    pre_dir_ALLOW_ErrorCount := COUNT(GROUP,h.pre_dir_Invalid=1);
    street_type_ALLOW_ErrorCount := COUNT(GROUP,h.street_type_Invalid=1);
    post_dir_ALLOW_ErrorCount := COUNT(GROUP,h.post_dir_Invalid=1);
    apt_type_ALLOW_ErrorCount := COUNT(GROUP,h.apt_type_Invalid=1);
    zip_ALLOW_ErrorCount := COUNT(GROUP,h.zip_Invalid=1);
    zip_LENGTHS_ErrorCount := COUNT(GROUP,h.zip_Invalid=2);
    zip_Total_ErrorCount := COUNT(GROUP,h.zip_Invalid>0);
    plus4_ALLOW_ErrorCount := COUNT(GROUP,h.plus4_Invalid=1);
    plus4_LENGTHS_ErrorCount := COUNT(GROUP,h.plus4_Invalid=2);
    plus4_Total_ErrorCount := COUNT(GROUP,h.plus4_Invalid>0);
    dpc_ALLOW_ErrorCount := COUNT(GROUP,h.dpc_Invalid=1);
    z4_type_ALLOW_ErrorCount := COUNT(GROUP,h.z4_type_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    state_ENUM_ErrorCount := COUNT(GROUP,h.state_Invalid=1);
    fips_state_ALLOW_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=1);
    fips_state_LENGTHS_ErrorCount := COUNT(GROUP,h.fips_state_Invalid=2);
    fips_state_Total_ErrorCount := COUNT(GROUP,h.fips_state_Invalid>0);
    fips_county_ALLOW_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=1);
    fips_county_LENGTHS_ErrorCount := COUNT(GROUP,h.fips_county_Invalid=2);
    fips_county_Total_ErrorCount := COUNT(GROUP,h.fips_county_Invalid>0);
    cbsa_ALLOW_ErrorCount := COUNT(GROUP,h.cbsa_Invalid=1);
    latitude_ALLOW_ErrorCount := COUNT(GROUP,h.latitude_Invalid=1);
    longitude_ALLOW_ErrorCount := COUNT(GROUP,h.longitude_Invalid=1);
    email_ALLOW_ErrorCount := COUNT(GROUP,h.email_Invalid=1);
    verified_ALLOW_ErrorCount := COUNT(GROUP,h.verified_Invalid=1);
    activity_status_ENUM_ErrorCount := COUNT(GROUP,h.activity_status_Invalid=1);
    prepaid_ENUM_ErrorCount := COUNT(GROUP,h.prepaid_Invalid=1);
    cord_cutter_ENUM_ErrorCount := COUNT(GROUP,h.cord_cutter_Invalid=1);
    AnyRule_WithErrorsCount := COUNT(GROUP, h.phone_Invalid > 0 OR h.gender_Invalid > 0 OR h.dob_Invalid > 0 OR h.pre_dir_Invalid > 0 OR h.street_type_Invalid > 0 OR h.post_dir_Invalid > 0 OR h.apt_type_Invalid > 0 OR h.zip_Invalid > 0 OR h.plus4_Invalid > 0 OR h.dpc_Invalid > 0 OR h.z4_type_Invalid > 0 OR h.city_Invalid > 0 OR h.state_Invalid > 0 OR h.fips_state_Invalid > 0 OR h.fips_county_Invalid > 0 OR h.cbsa_Invalid > 0 OR h.latitude_Invalid > 0 OR h.longitude_Invalid > 0 OR h.email_Invalid > 0 OR h.verified_Invalid > 0 OR h.activity_status_Invalid > 0 OR h.prepaid_Invalid > 0 OR h.cord_cutter_Invalid > 0);
    FieldsChecked_WithErrors := 0;
    FieldsChecked_NoErrors := 0;
    Rules_WithErrors := 0;
    Rules_NoErrors := 0;
  END;
  SummaryStats0 := TABLE(h,r);
  SummaryStats0 xAddErrSummary(SummaryStats0 le) := TRANSFORM
    SELF.FieldsChecked_WithErrors := IF(le.phone_Total_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.dob_Total_ErrorCount > 0, 1, 0) + IF(le.pre_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.post_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apt_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_Total_ErrorCount > 0, 1, 0) + IF(le.plus4_Total_ErrorCount > 0, 1, 0) + IF(le.dpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.z4_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ENUM_ErrorCount > 0, 1, 0) + IF(le.fips_state_Total_ErrorCount > 0, 1, 0) + IF(le.fips_county_Total_ErrorCount > 0, 1, 0) + IF(le.cbsa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.latitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.longitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.verified_ALLOW_ErrorCount > 0, 1, 0) + IF(le.activity_status_ENUM_ErrorCount > 0, 1, 0) + IF(le.prepaid_ENUM_ErrorCount > 0, 1, 0) + IF(le.cord_cutter_ENUM_ErrorCount > 0, 1, 0);
    SELF.FieldsChecked_NoErrors := NumFieldsWithRules - SELF.FieldsChecked_WithErrors;
    SELF.Rules_WithErrors := IF(le.phone_ALLOW_ErrorCount > 0, 1, 0) + IF(le.phone_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.gender_ENUM_ErrorCount > 0, 1, 0) + IF(le.dob_ALLOW_ErrorCount > 0, 1, 0) + IF(le.dob_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.pre_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.street_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.post_dir_ALLOW_ErrorCount > 0, 1, 0) + IF(le.apt_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_ALLOW_ErrorCount > 0, 1, 0) + IF(le.zip_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.plus4_ALLOW_ErrorCount > 0, 1, 0) + IF(le.plus4_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.dpc_ALLOW_ErrorCount > 0, 1, 0) + IF(le.z4_type_ALLOW_ErrorCount > 0, 1, 0) + IF(le.city_ALLOW_ErrorCount > 0, 1, 0) + IF(le.state_ENUM_ErrorCount > 0, 1, 0) + IF(le.fips_state_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_state_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.fips_county_ALLOW_ErrorCount > 0, 1, 0) + IF(le.fips_county_LENGTHS_ErrorCount > 0, 1, 0) + IF(le.cbsa_ALLOW_ErrorCount > 0, 1, 0) + IF(le.latitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.longitude_ALLOW_ErrorCount > 0, 1, 0) + IF(le.email_ALLOW_ErrorCount > 0, 1, 0) + IF(le.verified_ALLOW_ErrorCount > 0, 1, 0) + IF(le.activity_status_ENUM_ErrorCount > 0, 1, 0) + IF(le.prepaid_ENUM_ErrorCount > 0, 1, 0) + IF(le.cord_cutter_ENUM_ErrorCount > 0, 1, 0);
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
    UNSIGNED1 ErrNum := CHOOSE(c,le.phone_Invalid,le.gender_Invalid,le.dob_Invalid,le.pre_dir_Invalid,le.street_type_Invalid,le.post_dir_Invalid,le.apt_type_Invalid,le.zip_Invalid,le.plus4_Invalid,le.dpc_Invalid,le.z4_type_Invalid,le.city_Invalid,le.state_Invalid,le.fips_state_Invalid,le.fips_county_Invalid,le.cbsa_Invalid,le.latitude_Invalid,le.longitude_Invalid,le.email_Invalid,le.verified_Invalid,le.activity_status_Invalid,le.prepaid_Invalid,le.cord_cutter_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_phone(le.phone_Invalid),Fields.InvalidMessage_gender(le.gender_Invalid),Fields.InvalidMessage_dob(le.dob_Invalid),Fields.InvalidMessage_pre_dir(le.pre_dir_Invalid),Fields.InvalidMessage_street_type(le.street_type_Invalid),Fields.InvalidMessage_post_dir(le.post_dir_Invalid),Fields.InvalidMessage_apt_type(le.apt_type_Invalid),Fields.InvalidMessage_zip(le.zip_Invalid),Fields.InvalidMessage_plus4(le.plus4_Invalid),Fields.InvalidMessage_dpc(le.dpc_Invalid),Fields.InvalidMessage_z4_type(le.z4_type_Invalid),Fields.InvalidMessage_city(le.city_Invalid),Fields.InvalidMessage_state(le.state_Invalid),Fields.InvalidMessage_fips_state(le.fips_state_Invalid),Fields.InvalidMessage_fips_county(le.fips_county_Invalid),Fields.InvalidMessage_cbsa(le.cbsa_Invalid),Fields.InvalidMessage_latitude(le.latitude_Invalid),Fields.InvalidMessage_longitude(le.longitude_Invalid),Fields.InvalidMessage_email(le.email_Invalid),Fields.InvalidMessage_verified(le.verified_Invalid),Fields.InvalidMessage_activity_status(le.activity_status_Invalid),Fields.InvalidMessage_prepaid(le.prepaid_Invalid),Fields.InvalidMessage_cord_cutter(le.cord_cutter_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.phone_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.pre_dir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.street_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.post_dir_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.apt_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.zip_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.plus4_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.dpc_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.z4_type_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.state_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.fips_state_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.fips_county_Invalid,'ALLOW','LENGTHS','UNKNOWN')
          ,CHOOSE(le.cbsa_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.latitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.longitude_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.email_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.verified_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.activity_status_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.prepaid_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.cord_cutter_Invalid,'ENUM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'phone','gender','dob','pre_dir','street_type','post_dir','apt_type','zip','plus4','dpc','z4_type','city','state','fips_state','fips_county','cbsa','latitude','longitude','email','verified','activity_status','prepaid','cord_cutter','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_phone','invalid_gender','invalid_dob','invalid_predir_postdir','invalid_street_type','invalid_predir_postdir','invalid_apt_type','invalid_zip','invalid_plus4','invalid_dpc','invalid_z4_type','invalid_city','invalid_state','invalid_fips_state','invalid_fips_county','invalid_cbsa','invalid_lat_long','invalid_lat_long','invalid_email','invalid_verified','invalid_activity_status','invalid_Y_N','invalid_Y_N','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT311.StrType)le.phone,(SALT311.StrType)le.gender,(SALT311.StrType)le.dob,(SALT311.StrType)le.pre_dir,(SALT311.StrType)le.street_type,(SALT311.StrType)le.post_dir,(SALT311.StrType)le.apt_type,(SALT311.StrType)le.zip,(SALT311.StrType)le.plus4,(SALT311.StrType)le.dpc,(SALT311.StrType)le.z4_type,(SALT311.StrType)le.city,(SALT311.StrType)le.state,(SALT311.StrType)le.fips_state,(SALT311.StrType)le.fips_county,(SALT311.StrType)le.cbsa,(SALT311.StrType)le.latitude,(SALT311.StrType)le.longitude,(SALT311.StrType)le.email,(SALT311.StrType)le.verified,(SALT311.StrType)le.activity_status,(SALT311.StrType)le.prepaid,(SALT311.StrType)le.cord_cutter,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,23,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10, UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(), DATASET(Layout_NeustarWireless) prevDS = DATASET([], Layout_NeustarWireless), STRING10 Src='UNK'):= FUNCTION
  // field error stats
    SALT311.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'phone:invalid_phone:ALLOW','phone:invalid_phone:LENGTHS'
          ,'gender:invalid_gender:ENUM'
          ,'dob:invalid_dob:ALLOW','dob:invalid_dob:LENGTHS'
          ,'pre_dir:invalid_predir_postdir:ALLOW'
          ,'street_type:invalid_street_type:ALLOW'
          ,'post_dir:invalid_predir_postdir:ALLOW'
          ,'apt_type:invalid_apt_type:ALLOW'
          ,'zip:invalid_zip:ALLOW','zip:invalid_zip:LENGTHS'
          ,'plus4:invalid_plus4:ALLOW','plus4:invalid_plus4:LENGTHS'
          ,'dpc:invalid_dpc:ALLOW'
          ,'z4_type:invalid_z4_type:ALLOW'
          ,'city:invalid_city:ALLOW'
          ,'state:invalid_state:ENUM'
          ,'fips_state:invalid_fips_state:ALLOW','fips_state:invalid_fips_state:LENGTHS'
          ,'fips_county:invalid_fips_county:ALLOW','fips_county:invalid_fips_county:LENGTHS'
          ,'cbsa:invalid_cbsa:ALLOW'
          ,'latitude:invalid_lat_long:ALLOW'
          ,'longitude:invalid_lat_long:ALLOW'
          ,'email:invalid_email:ALLOW'
          ,'verified:invalid_verified:ALLOW'
          ,'activity_status:invalid_activity_status:ENUM'
          ,'prepaid:invalid_Y_N:ENUM'
          ,'cord_cutter:invalid_Y_N:ENUM'
          ,'field:Number_Errored_Fields:SUMMARY'
          ,'field:Number_Perfect_Fields:SUMMARY'
          ,'rule:Number_Errored_Rules:SUMMARY'
          ,'rule:Number_Perfect_Rules:SUMMARY'
          ,'rule:Number_OnFail_Rules:SUMMARY'
          ,'record:Number_Errored_Records:SUMMARY'
          ,'record:Number_Perfect_Records:SUMMARY','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,Fields.InvalidMessage_phone(1),Fields.InvalidMessage_phone(2)
          ,Fields.InvalidMessage_gender(1)
          ,Fields.InvalidMessage_dob(1),Fields.InvalidMessage_dob(2)
          ,Fields.InvalidMessage_pre_dir(1)
          ,Fields.InvalidMessage_street_type(1)
          ,Fields.InvalidMessage_post_dir(1)
          ,Fields.InvalidMessage_apt_type(1)
          ,Fields.InvalidMessage_zip(1),Fields.InvalidMessage_zip(2)
          ,Fields.InvalidMessage_plus4(1),Fields.InvalidMessage_plus4(2)
          ,Fields.InvalidMessage_dpc(1)
          ,Fields.InvalidMessage_z4_type(1)
          ,Fields.InvalidMessage_city(1)
          ,Fields.InvalidMessage_state(1)
          ,Fields.InvalidMessage_fips_state(1),Fields.InvalidMessage_fips_state(2)
          ,Fields.InvalidMessage_fips_county(1),Fields.InvalidMessage_fips_county(2)
          ,Fields.InvalidMessage_cbsa(1)
          ,Fields.InvalidMessage_latitude(1)
          ,Fields.InvalidMessage_longitude(1)
          ,Fields.InvalidMessage_email(1)
          ,Fields.InvalidMessage_verified(1)
          ,Fields.InvalidMessage_activity_status(1)
          ,Fields.InvalidMessage_prepaid(1)
          ,Fields.InvalidMessage_cord_cutter(1)
          ,'Fields with errors'
          ,'Fields without errors'
          ,'Rules with errors'
          ,'Rules without errors'
          ,'Rules with possible edits'
          ,'Records with at least one error'
          ,'Records without errors','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTHS_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount
          ,le.pre_dir_ALLOW_ErrorCount
          ,le.street_type_ALLOW_ErrorCount
          ,le.post_dir_ALLOW_ErrorCount
          ,le.apt_type_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.plus4_ALLOW_ErrorCount,le.plus4_LENGTHS_ErrorCount
          ,le.dpc_ALLOW_ErrorCount
          ,le.z4_type_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ENUM_ErrorCount
          ,le.fips_state_ALLOW_ErrorCount,le.fips_state_LENGTHS_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTHS_ErrorCount
          ,le.cbsa_ALLOW_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.verified_ALLOW_ErrorCount
          ,le.activity_status_ENUM_ErrorCount
          ,le.prepaid_ENUM_ErrorCount
          ,le.cord_cutter_ENUM_ErrorCount
          ,le.FieldsChecked_WithErrors
          ,le.FieldsChecked_NoErrors
          ,le.Rules_WithErrors
          ,le.Rules_NoErrors
          ,NumRulesWithPossibleEdits
          ,le.AnyRule_WithErrorsCount
          ,SELF.recordstotal - le.AnyRule_WithErrorsCount,0);
      SELF.rulepcnt := IF(c <= NumRules, 100 * CHOOSE(c
          ,le.phone_ALLOW_ErrorCount,le.phone_LENGTHS_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.dob_ALLOW_ErrorCount,le.dob_LENGTHS_ErrorCount
          ,le.pre_dir_ALLOW_ErrorCount
          ,le.street_type_ALLOW_ErrorCount
          ,le.post_dir_ALLOW_ErrorCount
          ,le.apt_type_ALLOW_ErrorCount
          ,le.zip_ALLOW_ErrorCount,le.zip_LENGTHS_ErrorCount
          ,le.plus4_ALLOW_ErrorCount,le.plus4_LENGTHS_ErrorCount
          ,le.dpc_ALLOW_ErrorCount
          ,le.z4_type_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.state_ENUM_ErrorCount
          ,le.fips_state_ALLOW_ErrorCount,le.fips_state_LENGTHS_ErrorCount
          ,le.fips_county_ALLOW_ErrorCount,le.fips_county_LENGTHS_ErrorCount
          ,le.cbsa_ALLOW_ErrorCount
          ,le.latitude_ALLOW_ErrorCount
          ,le.longitude_ALLOW_ErrorCount
          ,le.email_ALLOW_ErrorCount
          ,le.verified_ALLOW_ErrorCount
          ,le.activity_status_ENUM_ErrorCount
          ,le.prepaid_ENUM_ErrorCount
          ,le.cord_cutter_ENUM_ErrorCount,0) / le.TotalCnt, CHOOSE(c - NumRules
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
    mod_hygiene := hygiene(PROJECT(h, Layout_NeustarWireless));
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
          ,'phone:' + getFieldTypeText(h.phone) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fname:' + getFieldTypeText(h.fname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'mname:' + getFieldTypeText(h.mname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'lname:' + getFieldTypeText(h.lname) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'salutation:' + getFieldTypeText(h.salutation) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'suffix:' + getFieldTypeText(h.suffix) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'gender:' + getFieldTypeText(h.gender) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dob:' + getFieldTypeText(h.dob) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'house:' + getFieldTypeText(h.house) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'pre_dir:' + getFieldTypeText(h.pre_dir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street:' + getFieldTypeText(h.street) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'street_type:' + getFieldTypeText(h.street_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'post_dir:' + getFieldTypeText(h.post_dir) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apt_type:' + getFieldTypeText(h.apt_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'apt_nbr:' + getFieldTypeText(h.apt_nbr) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'zip:' + getFieldTypeText(h.zip) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'plus4:' + getFieldTypeText(h.plus4) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpc:' + getFieldTypeText(h.dpc) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'z4_type:' + getFieldTypeText(h.z4_type) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'crte:' + getFieldTypeText(h.crte) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'city:' + getFieldTypeText(h.city) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'state:' + getFieldTypeText(h.state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpvcmra:' + getFieldTypeText(h.dpvcmra) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'dpvconf:' + getFieldTypeText(h.dpvconf) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_state:' + getFieldTypeText(h.fips_state) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'fips_county:' + getFieldTypeText(h.fips_county) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'census_tract:' + getFieldTypeText(h.census_tract) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'census_block_group:' + getFieldTypeText(h.census_block_group) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cbsa:' + getFieldTypeText(h.cbsa) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'match_code:' + getFieldTypeText(h.match_code) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'latitude:' + getFieldTypeText(h.latitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'longitude:' + getFieldTypeText(h.longitude) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'email:' + getFieldTypeText(h.email) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler1:' + getFieldTypeText(h.filler1) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'filler2:' + getFieldTypeText(h.filler2) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'verified:' + getFieldTypeText(h.verified) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'activity_status:' + getFieldTypeText(h.activity_status) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'prepaid:' + getFieldTypeText(h.prepaid) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix
          ,'cord_cutter:' + getFieldTypeText(h.cord_cutter) + IF(TRIM(le.txt) > '', '_' + TRIM(le.txt), '') + ':' + suffix,'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.populated_phone_cnt
          ,le.populated_fname_cnt
          ,le.populated_mname_cnt
          ,le.populated_lname_cnt
          ,le.populated_salutation_cnt
          ,le.populated_suffix_cnt
          ,le.populated_gender_cnt
          ,le.populated_dob_cnt
          ,le.populated_house_cnt
          ,le.populated_pre_dir_cnt
          ,le.populated_street_cnt
          ,le.populated_street_type_cnt
          ,le.populated_post_dir_cnt
          ,le.populated_apt_type_cnt
          ,le.populated_apt_nbr_cnt
          ,le.populated_zip_cnt
          ,le.populated_plus4_cnt
          ,le.populated_dpc_cnt
          ,le.populated_z4_type_cnt
          ,le.populated_crte_cnt
          ,le.populated_city_cnt
          ,le.populated_state_cnt
          ,le.populated_dpvcmra_cnt
          ,le.populated_dpvconf_cnt
          ,le.populated_fips_state_cnt
          ,le.populated_fips_county_cnt
          ,le.populated_census_tract_cnt
          ,le.populated_census_block_group_cnt
          ,le.populated_cbsa_cnt
          ,le.populated_match_code_cnt
          ,le.populated_latitude_cnt
          ,le.populated_longitude_cnt
          ,le.populated_email_cnt
          ,le.populated_filler1_cnt
          ,le.populated_filler2_cnt
          ,le.populated_verified_cnt
          ,le.populated_activity_status_cnt
          ,le.populated_prepaid_cnt
          ,le.populated_cord_cutter_cnt,0);
      SELF.rulepcnt := CHOOSE(c
          ,le.populated_phone_pcnt
          ,le.populated_fname_pcnt
          ,le.populated_mname_pcnt
          ,le.populated_lname_pcnt
          ,le.populated_salutation_pcnt
          ,le.populated_suffix_pcnt
          ,le.populated_gender_pcnt
          ,le.populated_dob_pcnt
          ,le.populated_house_pcnt
          ,le.populated_pre_dir_pcnt
          ,le.populated_street_pcnt
          ,le.populated_street_type_pcnt
          ,le.populated_post_dir_pcnt
          ,le.populated_apt_type_pcnt
          ,le.populated_apt_nbr_pcnt
          ,le.populated_zip_pcnt
          ,le.populated_plus4_pcnt
          ,le.populated_dpc_pcnt
          ,le.populated_z4_type_pcnt
          ,le.populated_crte_pcnt
          ,le.populated_city_pcnt
          ,le.populated_state_pcnt
          ,le.populated_dpvcmra_pcnt
          ,le.populated_dpvconf_pcnt
          ,le.populated_fips_state_pcnt
          ,le.populated_fips_county_pcnt
          ,le.populated_census_tract_pcnt
          ,le.populated_census_block_group_pcnt
          ,le.populated_cbsa_pcnt
          ,le.populated_match_code_pcnt
          ,le.populated_latitude_pcnt
          ,le.populated_longitude_pcnt
          ,le.populated_email_pcnt
          ,le.populated_filler1_pcnt
          ,le.populated_filler2_pcnt
          ,le.populated_verified_pcnt
          ,le.populated_activity_status_pcnt
          ,le.populated_prepaid_pcnt
          ,le.populated_cord_cutter_pcnt,0);
      SELF.ErrorMessage := '';
    END;
    FieldPopStats := NORMALIZE(hygiene_summaryStats,39,xNormHygieneStats(LEFT,COUNTER,'POP'));
 
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
 
    mod_Delta := Delta(prevDS, PROJECT(h, Layout_NeustarWireless));
    deltaHygieneSummary := mod_Delta.DifferenceSummary;
    DeltaFieldPopStats := NORMALIZE(deltaHygieneSummary(txt <> 'New'),39,xNormHygieneStats(LEFT,COUNTER,'DELTA'));
    deltaStatName(STRING inTxt) := IF(STD.Str.Find(inTxt, 'Updates_') > 0,
                                      'Updates:count_Updates:DELTA',
                                      TRIM(inTxt) + ':count_' + TRIM(inTxt) + ':DELTA');
    DeltaTotalRecsStats := PROJECT(deltaHygieneSummary(txt <> 'Updates_OldFile'), xTotalRecs(LEFT, deltaStatName(LEFT.txt)));
    DeltaStats := IF(COUNT(prevDS) > 0, DeltaFieldPopStats + DeltaTotalRecsStats);
 
    RETURN FieldErrorStats & FieldPopStats & TotalRecsStats & DeltaStats;
  END;
END;
 
EXPORT StandardStats(DATASET(Layout_NeustarWireless) inFile, BOOLEAN doErrorOverall = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  expandedFile := FromNone(inFile).ExpandedInfile;
  mod_fromexpandedOverall := FromExpanded(expandedFile);
  scrubsSummaryOverall := mod_fromexpandedOverall.SummaryStats;
 
  SALT311.mod_StandardStatsTransforms.mac_scrubsSummaryStatsFieldErrTransform(Scrubs_NeustarWireless, Fields, 'RECORDOF(scrubsSummaryOverall)', '');
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
