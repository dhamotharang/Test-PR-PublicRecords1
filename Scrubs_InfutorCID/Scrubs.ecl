IMPORT ut,SALT30;
EXPORT Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(Layout_InfutorCidBase)
    UNSIGNED1 orig_phone_Invalid;
    UNSIGNED1 orig_phonetype_Invalid;
    UNSIGNED1 orig_directindial_Invalid;
    UNSIGNED1 orig_recordtype_Invalid;
    UNSIGNED1 orig_firstdate_Invalid;
    UNSIGNED1 orig_lastdate_Invalid;
    UNSIGNED1 orig_telconame_Invalid;
    UNSIGNED1 orig_businessname_Invalid;
    UNSIGNED1 orig_firstname_Invalid;
    UNSIGNED1 orig_mi_Invalid;
    UNSIGNED1 orig_lastname_Invalid;
    UNSIGNED1 orig_city_Invalid;
    UNSIGNED1 orig_state_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 orig_zip4_Invalid;
    UNSIGNED1 orig_dpbc_Invalid;
    UNSIGNED1 orig_z4type_Invalid;
    UNSIGNED1 orig_dpv_Invalid;
    UNSIGNED1 orig_maildeliverabilitycode_Invalid;
    UNSIGNED1 orig_addressvalidationdate_Invalid;
    UNSIGNED1 orig_directoryassistanceflag_Invalid;
    UNSIGNED1 orig_telephoneconfidencescore_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(Layout_InfutorCidBase)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(Layout_InfutorCidBase) h) := MODULE
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_phone_Invalid := Fields.InValid_orig_phone((SALT30.StrType)le.orig_phone);
    SELF.orig_phonetype_Invalid := Fields.InValid_orig_phonetype((SALT30.StrType)le.orig_phonetype);
    SELF.orig_directindial_Invalid := Fields.InValid_orig_directindial((SALT30.StrType)le.orig_directindial);
    SELF.orig_recordtype_Invalid := Fields.InValid_orig_recordtype((SALT30.StrType)le.orig_recordtype);
    SELF.orig_firstdate_Invalid := Fields.InValid_orig_firstdate((SALT30.StrType)le.orig_firstdate);
    SELF.orig_lastdate_Invalid := Fields.InValid_orig_lastdate((SALT30.StrType)le.orig_lastdate);
    SELF.orig_telconame_Invalid := Fields.InValid_orig_telconame((SALT30.StrType)le.orig_telconame);
    SELF.orig_businessname_Invalid := Fields.InValid_orig_businessname((SALT30.StrType)le.orig_businessname);
    SELF.orig_firstname_Invalid := Fields.InValid_orig_firstname((SALT30.StrType)le.orig_firstname);
    SELF.orig_mi_Invalid := Fields.InValid_orig_mi((SALT30.StrType)le.orig_mi);
    SELF.orig_lastname_Invalid := Fields.InValid_orig_lastname((SALT30.StrType)le.orig_lastname);
    SELF.orig_city_Invalid := Fields.InValid_orig_city((SALT30.StrType)le.orig_city);
    SELF.orig_state_Invalid := Fields.InValid_orig_state((SALT30.StrType)le.orig_state);
    SELF.orig_zip_Invalid := Fields.InValid_orig_zip((SALT30.StrType)le.orig_zip);
    SELF.orig_zip4_Invalid := Fields.InValid_orig_zip4((SALT30.StrType)le.orig_zip4);
    SELF.orig_dpbc_Invalid := Fields.InValid_orig_dpbc((SALT30.StrType)le.orig_dpbc);
    SELF.orig_z4type_Invalid := Fields.InValid_orig_z4type((SALT30.StrType)le.orig_z4type);
    SELF.orig_dpv_Invalid := Fields.InValid_orig_dpv((SALT30.StrType)le.orig_dpv);
    SELF.orig_maildeliverabilitycode_Invalid := Fields.InValid_orig_maildeliverabilitycode((SALT30.StrType)le.orig_maildeliverabilitycode);
    SELF.orig_addressvalidationdate_Invalid := Fields.InValid_orig_addressvalidationdate((SALT30.StrType)le.orig_addressvalidationdate);
    SELF.orig_directoryassistanceflag_Invalid := Fields.InValid_orig_directoryassistanceflag((SALT30.StrType)le.orig_directoryassistanceflag);
    SELF.orig_telephoneconfidencescore_Invalid := Fields.InValid_orig_telephoneconfidencescore((SALT30.StrType)le.orig_telephoneconfidencescore);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.orig_phone_Invalid << 0 ) + ( le.orig_phonetype_Invalid << 2 ) + ( le.orig_directindial_Invalid << 4 ) + ( le.orig_recordtype_Invalid << 6 ) + ( le.orig_firstdate_Invalid << 8 ) + ( le.orig_lastdate_Invalid << 10 ) + ( le.orig_telconame_Invalid << 12 ) + ( le.orig_businessname_Invalid << 14 ) + ( le.orig_firstname_Invalid << 16 ) + ( le.orig_mi_Invalid << 18 ) + ( le.orig_lastname_Invalid << 20 ) + ( le.orig_city_Invalid << 22 ) + ( le.orig_state_Invalid << 24 ) + ( le.orig_zip_Invalid << 26 ) + ( le.orig_zip4_Invalid << 28 ) + ( le.orig_dpbc_Invalid << 30 ) + ( le.orig_z4type_Invalid << 32 ) + ( le.orig_dpv_Invalid << 34 ) + ( le.orig_maildeliverabilitycode_Invalid << 36 ) + ( le.orig_addressvalidationdate_Invalid << 38 ) + ( le.orig_directoryassistanceflag_Invalid << 40 ) + ( le.orig_telephoneconfidencescore_Invalid << 42 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,Layout_InfutorCidBase);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.orig_phone_Invalid := (le.ScrubsBits1 >> 0) & 3;
    SELF.orig_phonetype_Invalid := (le.ScrubsBits1 >> 2) & 3;
    SELF.orig_directindial_Invalid := (le.ScrubsBits1 >> 4) & 3;
    SELF.orig_recordtype_Invalid := (le.ScrubsBits1 >> 6) & 3;
    SELF.orig_firstdate_Invalid := (le.ScrubsBits1 >> 8) & 3;
    SELF.orig_lastdate_Invalid := (le.ScrubsBits1 >> 10) & 3;
    SELF.orig_telconame_Invalid := (le.ScrubsBits1 >> 12) & 3;
    SELF.orig_businessname_Invalid := (le.ScrubsBits1 >> 14) & 3;
    SELF.orig_firstname_Invalid := (le.ScrubsBits1 >> 16) & 3;
    SELF.orig_mi_Invalid := (le.ScrubsBits1 >> 18) & 3;
    SELF.orig_lastname_Invalid := (le.ScrubsBits1 >> 20) & 3;
    SELF.orig_city_Invalid := (le.ScrubsBits1 >> 22) & 3;
    SELF.orig_state_Invalid := (le.ScrubsBits1 >> 24) & 3;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 26) & 3;
    SELF.orig_zip4_Invalid := (le.ScrubsBits1 >> 28) & 3;
    SELF.orig_dpbc_Invalid := (le.ScrubsBits1 >> 30) & 3;
    SELF.orig_z4type_Invalid := (le.ScrubsBits1 >> 32) & 3;
    SELF.orig_dpv_Invalid := (le.ScrubsBits1 >> 34) & 3;
    SELF.orig_maildeliverabilitycode_Invalid := (le.ScrubsBits1 >> 36) & 3;
    SELF.orig_addressvalidationdate_Invalid := (le.ScrubsBits1 >> 38) & 3;
    SELF.orig_directoryassistanceflag_Invalid := (le.ScrubsBits1 >> 40) & 3;
    SELF.orig_telephoneconfidencescore_Invalid := (le.ScrubsBits1 >> 42) & 3;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    TotalCnt := COUNT(GROUP); // Number of records in total
    orig_phone_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=1);
    orig_phone_LENGTH_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid=2);
    orig_phone_Total_ErrorCount := COUNT(GROUP,h.orig_phone_Invalid>0);
    orig_phonetype_ALLOW_ErrorCount := COUNT(GROUP,h.orig_phonetype_Invalid=1);
    orig_phonetype_LENGTH_ErrorCount := COUNT(GROUP,h.orig_phonetype_Invalid=2);
    orig_phonetype_Total_ErrorCount := COUNT(GROUP,h.orig_phonetype_Invalid>0);
    orig_directindial_ALLOW_ErrorCount := COUNT(GROUP,h.orig_directindial_Invalid=1);
    orig_directindial_LENGTH_ErrorCount := COUNT(GROUP,h.orig_directindial_Invalid=2);
    orig_directindial_Total_ErrorCount := COUNT(GROUP,h.orig_directindial_Invalid>0);
    orig_recordtype_ALLOW_ErrorCount := COUNT(GROUP,h.orig_recordtype_Invalid=1);
    orig_recordtype_LENGTH_ErrorCount := COUNT(GROUP,h.orig_recordtype_Invalid=2);
    orig_recordtype_Total_ErrorCount := COUNT(GROUP,h.orig_recordtype_Invalid>0);
    orig_firstdate_ALLOW_ErrorCount := COUNT(GROUP,h.orig_firstdate_Invalid=1);
    orig_firstdate_LENGTH_ErrorCount := COUNT(GROUP,h.orig_firstdate_Invalid=2);
    orig_firstdate_Total_ErrorCount := COUNT(GROUP,h.orig_firstdate_Invalid>0);
    orig_lastdate_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lastdate_Invalid=1);
    orig_lastdate_LENGTH_ErrorCount := COUNT(GROUP,h.orig_lastdate_Invalid=2);
    orig_lastdate_Total_ErrorCount := COUNT(GROUP,h.orig_lastdate_Invalid>0);
    orig_telconame_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telconame_Invalid=1);
    orig_telconame_LENGTH_ErrorCount := COUNT(GROUP,h.orig_telconame_Invalid=2);
    orig_telconame_Total_ErrorCount := COUNT(GROUP,h.orig_telconame_Invalid>0);
    orig_businessname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_businessname_Invalid=1);
    orig_businessname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_businessname_Invalid=2);
    orig_businessname_Total_ErrorCount := COUNT(GROUP,h.orig_businessname_Invalid>0);
    orig_firstname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_firstname_Invalid=1);
    orig_firstname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_firstname_Invalid=2);
    orig_firstname_Total_ErrorCount := COUNT(GROUP,h.orig_firstname_Invalid>0);
    orig_mi_ALLOW_ErrorCount := COUNT(GROUP,h.orig_mi_Invalid=1);
    orig_mi_LENGTH_ErrorCount := COUNT(GROUP,h.orig_mi_Invalid=2);
    orig_mi_Total_ErrorCount := COUNT(GROUP,h.orig_mi_Invalid>0);
    orig_lastname_ALLOW_ErrorCount := COUNT(GROUP,h.orig_lastname_Invalid=1);
    orig_lastname_LENGTH_ErrorCount := COUNT(GROUP,h.orig_lastname_Invalid=2);
    orig_lastname_Total_ErrorCount := COUNT(GROUP,h.orig_lastname_Invalid>0);
    orig_city_ALLOW_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=1);
    orig_city_LENGTH_ErrorCount := COUNT(GROUP,h.orig_city_Invalid=2);
    orig_city_Total_ErrorCount := COUNT(GROUP,h.orig_city_Invalid>0);
    orig_state_ALLOW_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=1);
    orig_state_LENGTH_ErrorCount := COUNT(GROUP,h.orig_state_Invalid=2);
    orig_state_Total_ErrorCount := COUNT(GROUP,h.orig_state_Invalid>0);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    orig_zip_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=2);
    orig_zip_Total_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid>0);
    orig_zip4_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=1);
    orig_zip4_LENGTH_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid=2);
    orig_zip4_Total_ErrorCount := COUNT(GROUP,h.orig_zip4_Invalid>0);
    orig_dpbc_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dpbc_Invalid=1);
    orig_dpbc_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dpbc_Invalid=2);
    orig_dpbc_Total_ErrorCount := COUNT(GROUP,h.orig_dpbc_Invalid>0);
    orig_z4type_ALLOW_ErrorCount := COUNT(GROUP,h.orig_z4type_Invalid=1);
    orig_z4type_LENGTH_ErrorCount := COUNT(GROUP,h.orig_z4type_Invalid=2);
    orig_z4type_Total_ErrorCount := COUNT(GROUP,h.orig_z4type_Invalid>0);
    orig_dpv_ALLOW_ErrorCount := COUNT(GROUP,h.orig_dpv_Invalid=1);
    orig_dpv_LENGTH_ErrorCount := COUNT(GROUP,h.orig_dpv_Invalid=2);
    orig_dpv_Total_ErrorCount := COUNT(GROUP,h.orig_dpv_Invalid>0);
    orig_maildeliverabilitycode_ALLOW_ErrorCount := COUNT(GROUP,h.orig_maildeliverabilitycode_Invalid=1);
    orig_maildeliverabilitycode_LENGTH_ErrorCount := COUNT(GROUP,h.orig_maildeliverabilitycode_Invalid=2);
    orig_maildeliverabilitycode_Total_ErrorCount := COUNT(GROUP,h.orig_maildeliverabilitycode_Invalid>0);
    orig_addressvalidationdate_ALLOW_ErrorCount := COUNT(GROUP,h.orig_addressvalidationdate_Invalid=1);
    orig_addressvalidationdate_LENGTH_ErrorCount := COUNT(GROUP,h.orig_addressvalidationdate_Invalid=2);
    orig_addressvalidationdate_Total_ErrorCount := COUNT(GROUP,h.orig_addressvalidationdate_Invalid>0);
    orig_directoryassistanceflag_ALLOW_ErrorCount := COUNT(GROUP,h.orig_directoryassistanceflag_Invalid=1);
    orig_directoryassistanceflag_LENGTH_ErrorCount := COUNT(GROUP,h.orig_directoryassistanceflag_Invalid=2);
    orig_directoryassistanceflag_Total_ErrorCount := COUNT(GROUP,h.orig_directoryassistanceflag_Invalid>0);
    orig_telephoneconfidencescore_ALLOW_ErrorCount := COUNT(GROUP,h.orig_telephoneconfidencescore_Invalid=1);
    orig_telephoneconfidencescore_LENGTH_ErrorCount := COUNT(GROUP,h.orig_telephoneconfidencescore_Invalid=2);
    orig_telephoneconfidencescore_Total_ErrorCount := COUNT(GROUP,h.orig_telephoneconfidencescore_Invalid>0);
  END;
  EXPORT SummaryStats := TABLE(h,r);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT30.StrType ErrorMessage;
    SALT30.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  ''; // Source not provided
    UNSIGNED1 ErrNum := CHOOSE(c,le.orig_phone_Invalid,le.orig_phonetype_Invalid,le.orig_directindial_Invalid,le.orig_recordtype_Invalid,le.orig_firstdate_Invalid,le.orig_lastdate_Invalid,le.orig_telconame_Invalid,le.orig_businessname_Invalid,le.orig_firstname_Invalid,le.orig_mi_Invalid,le.orig_lastname_Invalid,le.orig_city_Invalid,le.orig_state_Invalid,le.orig_zip_Invalid,le.orig_zip4_Invalid,le.orig_dpbc_Invalid,le.orig_z4type_Invalid,le.orig_dpv_Invalid,le.orig_maildeliverabilitycode_Invalid,le.orig_addressvalidationdate_Invalid,le.orig_directoryassistanceflag_Invalid,le.orig_telephoneconfidencescore_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,Fields.InvalidMessage_orig_phone(le.orig_phone_Invalid),Fields.InvalidMessage_orig_phonetype(le.orig_phonetype_Invalid),Fields.InvalidMessage_orig_directindial(le.orig_directindial_Invalid),Fields.InvalidMessage_orig_recordtype(le.orig_recordtype_Invalid),Fields.InvalidMessage_orig_firstdate(le.orig_firstdate_Invalid),Fields.InvalidMessage_orig_lastdate(le.orig_lastdate_Invalid),Fields.InvalidMessage_orig_telconame(le.orig_telconame_Invalid),Fields.InvalidMessage_orig_businessname(le.orig_businessname_Invalid),Fields.InvalidMessage_orig_firstname(le.orig_firstname_Invalid),Fields.InvalidMessage_orig_mi(le.orig_mi_Invalid),Fields.InvalidMessage_orig_lastname(le.orig_lastname_Invalid),Fields.InvalidMessage_orig_city(le.orig_city_Invalid),Fields.InvalidMessage_orig_state(le.orig_state_Invalid),Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),Fields.InvalidMessage_orig_zip4(le.orig_zip4_Invalid),Fields.InvalidMessage_orig_dpbc(le.orig_dpbc_Invalid),Fields.InvalidMessage_orig_z4type(le.orig_z4type_Invalid),Fields.InvalidMessage_orig_dpv(le.orig_dpv_Invalid),Fields.InvalidMessage_orig_maildeliverabilitycode(le.orig_maildeliverabilitycode_Invalid),Fields.InvalidMessage_orig_addressvalidationdate(le.orig_addressvalidationdate_Invalid),Fields.InvalidMessage_orig_directoryassistanceflag(le.orig_directoryassistanceflag_Invalid),Fields.InvalidMessage_orig_telephoneconfidencescore(le.orig_telephoneconfidencescore_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.orig_phone_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_phonetype_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_directindial_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_recordtype_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_firstdate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_lastdate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_telconame_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_businessname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_firstname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_mi_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_lastname_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_city_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_state_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_zip4_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dpbc_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_z4type_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_dpv_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_maildeliverabilitycode_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_addressvalidationdate_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_directoryassistanceflag_Invalid,'ALLOW','LENGTH','UNKNOWN')
          ,CHOOSE(le.orig_telephoneconfidencescore_Invalid,'ALLOW','LENGTH','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'orig_phone','orig_phonetype','orig_directindial','orig_recordtype','orig_firstdate','orig_lastdate','orig_telconame','orig_businessname','orig_firstname','orig_mi','orig_lastname','orig_city','orig_state','orig_zip','orig_zip4','orig_dpbc','orig_z4type','orig_dpv','orig_maildeliverabilitycode','orig_addressvalidationdate','orig_directoryassistanceflag','orig_telephoneconfidencescore','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'invalid_phone','invalid_phonetype','invalid_directindial','invalid_recordtype','invalid_date','invalid_date','invalid_namealpha','invalid_namealpha','invalid_namealpha','invalid_namealpha','invalid_namealpha','invalid_orig_city','invalid_state','invalid_zip','invalid_zip','invalid_dpbc','invalid_z4type','invalid_dpv','invalid_maildeliverabilitycode','invalid_date','invalid_directoryassistanceflag','invalid_telephoneconfidencescore','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT30.StrType)le.orig_phone,(SALT30.StrType)le.orig_phonetype,(SALT30.StrType)le.orig_directindial,(SALT30.StrType)le.orig_recordtype,(SALT30.StrType)le.orig_firstdate,(SALT30.StrType)le.orig_lastdate,(SALT30.StrType)le.orig_telconame,(SALT30.StrType)le.orig_businessname,(SALT30.StrType)le.orig_firstname,(SALT30.StrType)le.orig_mi,(SALT30.StrType)le.orig_lastname,(SALT30.StrType)le.orig_city,(SALT30.StrType)le.orig_state,(SALT30.StrType)le.orig_zip,(SALT30.StrType)le.orig_zip4,(SALT30.StrType)le.orig_dpbc,(SALT30.StrType)le.orig_z4type,(SALT30.StrType)le.orig_dpv,(SALT30.StrType)le.orig_maildeliverabilitycode,(SALT30.StrType)le.orig_addressvalidationdate,(SALT30.StrType)le.orig_directoryassistanceflag,(SALT30.StrType)le.orig_telephoneconfidencescore,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,22,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD(),STRING10 Src='UNK') := FUNCTION
    SALT30.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := src;
      SELF.ruledesc := CHOOSE(c
          ,'orig_phone:invalid_phone:ALLOW','orig_phone:invalid_phone:LENGTH'
          ,'orig_phonetype:invalid_phonetype:ALLOW','orig_phonetype:invalid_phonetype:LENGTH'
          ,'orig_directindial:invalid_directindial:ALLOW','orig_directindial:invalid_directindial:LENGTH'
          ,'orig_recordtype:invalid_recordtype:ALLOW','orig_recordtype:invalid_recordtype:LENGTH'
          ,'orig_firstdate:invalid_date:ALLOW','orig_firstdate:invalid_date:LENGTH'
          ,'orig_lastdate:invalid_date:ALLOW','orig_lastdate:invalid_date:LENGTH'
          ,'orig_telconame:invalid_namealpha:ALLOW','orig_telconame:invalid_namealpha:LENGTH'
          ,'orig_businessname:invalid_namealpha:ALLOW','orig_businessname:invalid_namealpha:LENGTH'
          ,'orig_firstname:invalid_namealpha:ALLOW','orig_firstname:invalid_namealpha:LENGTH'
          ,'orig_mi:invalid_namealpha:ALLOW','orig_mi:invalid_namealpha:LENGTH'
          ,'orig_lastname:invalid_namealpha:ALLOW','orig_lastname:invalid_namealpha:LENGTH'
          ,'orig_city:invalid_orig_city:ALLOW','orig_city:invalid_orig_city:LENGTH'
          ,'orig_state:invalid_state:ALLOW','orig_state:invalid_state:LENGTH'
          ,'orig_zip:invalid_zip:ALLOW','orig_zip:invalid_zip:LENGTH'
          ,'orig_zip4:invalid_zip:ALLOW','orig_zip4:invalid_zip:LENGTH'
          ,'orig_dpbc:invalid_dpbc:ALLOW','orig_dpbc:invalid_dpbc:LENGTH'
          ,'orig_z4type:invalid_z4type:ALLOW','orig_z4type:invalid_z4type:LENGTH'
          ,'orig_dpv:invalid_dpv:ALLOW','orig_dpv:invalid_dpv:LENGTH'
          ,'orig_maildeliverabilitycode:invalid_maildeliverabilitycode:ALLOW','orig_maildeliverabilitycode:invalid_maildeliverabilitycode:LENGTH'
          ,'orig_addressvalidationdate:invalid_date:ALLOW','orig_addressvalidationdate:invalid_date:LENGTH'
          ,'orig_directoryassistanceflag:invalid_directoryassistanceflag:ALLOW','orig_directoryassistanceflag:invalid_directoryassistanceflag:LENGTH'
          ,'orig_telephoneconfidencescore:invalid_telephoneconfidencescore:ALLOW','orig_telephoneconfidencescore:invalid_telephoneconfidencescore:LENGTH','UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTH_ErrorCount
          ,le.orig_phonetype_ALLOW_ErrorCount,le.orig_phonetype_LENGTH_ErrorCount
          ,le.orig_directindial_ALLOW_ErrorCount,le.orig_directindial_LENGTH_ErrorCount
          ,le.orig_recordtype_ALLOW_ErrorCount,le.orig_recordtype_LENGTH_ErrorCount
          ,le.orig_firstdate_ALLOW_ErrorCount,le.orig_firstdate_LENGTH_ErrorCount
          ,le.orig_lastdate_ALLOW_ErrorCount,le.orig_lastdate_LENGTH_ErrorCount
          ,le.orig_telconame_ALLOW_ErrorCount,le.orig_telconame_LENGTH_ErrorCount
          ,le.orig_businessname_ALLOW_ErrorCount,le.orig_businessname_LENGTH_ErrorCount
          ,le.orig_firstname_ALLOW_ErrorCount,le.orig_firstname_LENGTH_ErrorCount
          ,le.orig_mi_ALLOW_ErrorCount,le.orig_mi_LENGTH_ErrorCount
          ,le.orig_lastname_ALLOW_ErrorCount,le.orig_lastname_LENGTH_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_LENGTH_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTH_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount,le.orig_zip4_LENGTH_ErrorCount
          ,le.orig_dpbc_ALLOW_ErrorCount,le.orig_dpbc_LENGTH_ErrorCount
          ,le.orig_z4type_ALLOW_ErrorCount,le.orig_z4type_LENGTH_ErrorCount
          ,le.orig_dpv_ALLOW_ErrorCount,le.orig_dpv_LENGTH_ErrorCount
          ,le.orig_maildeliverabilitycode_ALLOW_ErrorCount,le.orig_maildeliverabilitycode_LENGTH_ErrorCount
          ,le.orig_addressvalidationdate_ALLOW_ErrorCount,le.orig_addressvalidationdate_LENGTH_ErrorCount
          ,le.orig_directoryassistanceflag_ALLOW_ErrorCount,le.orig_directoryassistanceflag_LENGTH_ErrorCount
          ,le.orig_telephoneconfidencescore_ALLOW_ErrorCount,le.orig_telephoneconfidencescore_LENGTH_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.orig_phone_ALLOW_ErrorCount,le.orig_phone_LENGTH_ErrorCount
          ,le.orig_phonetype_ALLOW_ErrorCount,le.orig_phonetype_LENGTH_ErrorCount
          ,le.orig_directindial_ALLOW_ErrorCount,le.orig_directindial_LENGTH_ErrorCount
          ,le.orig_recordtype_ALLOW_ErrorCount,le.orig_recordtype_LENGTH_ErrorCount
          ,le.orig_firstdate_ALLOW_ErrorCount,le.orig_firstdate_LENGTH_ErrorCount
          ,le.orig_lastdate_ALLOW_ErrorCount,le.orig_lastdate_LENGTH_ErrorCount
          ,le.orig_telconame_ALLOW_ErrorCount,le.orig_telconame_LENGTH_ErrorCount
          ,le.orig_businessname_ALLOW_ErrorCount,le.orig_businessname_LENGTH_ErrorCount
          ,le.orig_firstname_ALLOW_ErrorCount,le.orig_firstname_LENGTH_ErrorCount
          ,le.orig_mi_ALLOW_ErrorCount,le.orig_mi_LENGTH_ErrorCount
          ,le.orig_lastname_ALLOW_ErrorCount,le.orig_lastname_LENGTH_ErrorCount
          ,le.orig_city_ALLOW_ErrorCount,le.orig_city_LENGTH_ErrorCount
          ,le.orig_state_ALLOW_ErrorCount,le.orig_state_LENGTH_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount,le.orig_zip_LENGTH_ErrorCount
          ,le.orig_zip4_ALLOW_ErrorCount,le.orig_zip4_LENGTH_ErrorCount
          ,le.orig_dpbc_ALLOW_ErrorCount,le.orig_dpbc_LENGTH_ErrorCount
          ,le.orig_z4type_ALLOW_ErrorCount,le.orig_z4type_LENGTH_ErrorCount
          ,le.orig_dpv_ALLOW_ErrorCount,le.orig_dpv_LENGTH_ErrorCount
          ,le.orig_maildeliverabilitycode_ALLOW_ErrorCount,le.orig_maildeliverabilitycode_LENGTH_ErrorCount
          ,le.orig_addressvalidationdate_ALLOW_ErrorCount,le.orig_addressvalidationdate_LENGTH_ErrorCount
          ,le.orig_directoryassistanceflag_ALLOW_ErrorCount,le.orig_directoryassistanceflag_LENGTH_ErrorCount
          ,le.orig_telephoneconfidencescore_ALLOW_ErrorCount,le.orig_telephoneconfidencescore_LENGTH_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,44,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      SALT30.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT30.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
