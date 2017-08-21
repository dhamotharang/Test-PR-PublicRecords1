IMPORT ut,SALT33;
IMPORT Scrubs,Scrubs_Crim; // Import modules for FieldTypes attribute definitions
EXPORT defendant_counties_Scrubs := MODULE
// The module to handle the case where no scrubs exist
  EXPORT  Expanded_Layout := RECORD(defendant_counties_Layout_crim)
    UNSIGNED1 recordid_Invalid;
    UNSIGNED1 statecode_Invalid;
    UNSIGNED1 inmatenumber_Invalid;
    UNSIGNED1 dob_Invalid;
    UNSIGNED1 birthcity_Invalid;
    UNSIGNED1 gender_Invalid;
    UNSIGNED1 race_Invalid;
    UNSIGNED1 dlstate_Invalid;
    UNSIGNED1 city_Invalid;
    UNSIGNED1 orig_zip_Invalid;
    UNSIGNED1 institutionreceiptdate_Invalid;
    UNSIGNED1 deceaseddate_Invalid;
    UNSIGNED1 sexoffenderregistrydate_Invalid;
    UNSIGNED1 sexoffenderregexpirationdate_Invalid;
  END;
  EXPORT  Bitmap_Layout := RECORD(defendant_counties_Layout_crim)
    UNSIGNED8 ScrubsBits1;
  END;
EXPORT FromNone(DATASET(defendant_counties_Layout_crim) h) := MODULE
  SHARED Expanded_Layout toExpanded(h le, BOOLEAN withOnfail) := TRANSFORM
    SELF.recordid_Invalid := defendant_counties_Fields.InValid_recordid((SALT33.StrType)le.recordid);
    SELF.statecode_Invalid := defendant_counties_Fields.InValid_statecode((SALT33.StrType)le.statecode);
    SELF.inmatenumber_Invalid := defendant_counties_Fields.InValid_inmatenumber((SALT33.StrType)le.inmatenumber);
    SELF.dob_Invalid := defendant_counties_Fields.InValid_dob((SALT33.StrType)le.dob);
    SELF.birthcity_Invalid := defendant_counties_Fields.InValid_birthcity((SALT33.StrType)le.birthcity);
    SELF.gender_Invalid := defendant_counties_Fields.InValid_gender((SALT33.StrType)le.gender);
    SELF.race_Invalid := defendant_counties_Fields.InValid_race((SALT33.StrType)le.race);
    SELF.dlstate_Invalid := defendant_counties_Fields.InValid_dlstate((SALT33.StrType)le.dlstate);
    SELF.city_Invalid := defendant_counties_Fields.InValid_city((SALT33.StrType)le.city);
    SELF.orig_zip_Invalid := defendant_counties_Fields.InValid_orig_zip((SALT33.StrType)le.orig_zip);
    SELF.institutionreceiptdate_Invalid := defendant_counties_Fields.InValid_institutionreceiptdate((SALT33.StrType)le.institutionreceiptdate);
    SELF.deceaseddate_Invalid := defendant_counties_Fields.InValid_deceaseddate((SALT33.StrType)le.deceaseddate);
    SELF.sexoffenderregistrydate_Invalid := defendant_counties_Fields.InValid_sexoffenderregistrydate((SALT33.StrType)le.sexoffenderregistrydate);
    SELF.sexoffenderregexpirationdate_Invalid := defendant_counties_Fields.InValid_sexoffenderregexpirationdate((SALT33.StrType)le.sexoffenderregexpirationdate);
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,toExpanded(LEFT,FALSE));
  EXPORT ProcessedInfile := PROJECT(PROJECT(h,toExpanded(LEFT,TRUE)),defendant_counties_Layout_crim);
  Bitmap_Layout Into(ExpandedInfile le) := TRANSFORM
    SELF.ScrubsBits1 := ( le.recordid_Invalid << 0 ) + ( le.statecode_Invalid << 1 ) + ( le.inmatenumber_Invalid << 2 ) + ( le.dob_Invalid << 3 ) + ( le.birthcity_Invalid << 4 ) + ( le.gender_Invalid << 5 ) + ( le.race_Invalid << 6 ) + ( le.dlstate_Invalid << 7 ) + ( le.city_Invalid << 8 ) + ( le.orig_zip_Invalid << 9 ) + ( le.institutionreceiptdate_Invalid << 10 ) + ( le.deceaseddate_Invalid << 11 ) + ( le.sexoffenderregistrydate_Invalid << 12 ) + ( le.sexoffenderregexpirationdate_Invalid << 13 );
    SELF := le;
  END;
  EXPORT BitmapInfile := PROJECT(ExpandedInfile,Into(LEFT));
END;
// Module to use if you already have a scrubs bitmap you wish to expand or compare
EXPORT FromBits(DATASET(Bitmap_Layout) h) := MODULE
  EXPORT Infile := PROJECT(h,defendant_counties_Layout_crim);
  Expanded_Layout into(h le) := TRANSFORM
    SELF.recordid_Invalid := (le.ScrubsBits1 >> 0) & 1;
    SELF.statecode_Invalid := (le.ScrubsBits1 >> 1) & 1;
    SELF.inmatenumber_Invalid := (le.ScrubsBits1 >> 2) & 1;
    SELF.dob_Invalid := (le.ScrubsBits1 >> 3) & 1;
    SELF.birthcity_Invalid := (le.ScrubsBits1 >> 4) & 1;
    SELF.gender_Invalid := (le.ScrubsBits1 >> 5) & 1;
    SELF.race_Invalid := (le.ScrubsBits1 >> 6) & 1;
    SELF.dlstate_Invalid := (le.ScrubsBits1 >> 7) & 1;
    SELF.city_Invalid := (le.ScrubsBits1 >> 8) & 1;
    SELF.orig_zip_Invalid := (le.ScrubsBits1 >> 9) & 1;
    SELF.institutionreceiptdate_Invalid := (le.ScrubsBits1 >> 10) & 1;
    SELF.deceaseddate_Invalid := (le.ScrubsBits1 >> 11) & 1;
    SELF.sexoffenderregistrydate_Invalid := (le.ScrubsBits1 >> 12) & 1;
    SELF.sexoffenderregexpirationdate_Invalid := (le.ScrubsBits1 >> 13) & 1;
    SELF := le;
  END;
  EXPORT ExpandedInfile := PROJECT(h,Into(LEFT));
END;
// This can be thought of as the 'reporting module' - if you don't have an expanded; the other two modules create them ...
EXPORT FromExpanded(DATASET(Expanded_Layout) h) := MODULE
  r := RECORD
    h.vendor;
    TotalCnt := COUNT(GROUP); // Number of records in total
    recordid_ALLOW_ErrorCount := COUNT(GROUP,h.recordid_Invalid=1);
    statecode_ALLOW_ErrorCount := COUNT(GROUP,h.statecode_Invalid=1);
    inmatenumber_ALLOW_ErrorCount := COUNT(GROUP,h.inmatenumber_Invalid=1);
    dob_CUSTOM_ErrorCount := COUNT(GROUP,h.dob_Invalid=1);
    birthcity_ALLOW_ErrorCount := COUNT(GROUP,h.birthcity_Invalid=1);
    gender_ENUM_ErrorCount := COUNT(GROUP,h.gender_Invalid=1);
    race_CUSTOM_ErrorCount := COUNT(GROUP,h.race_Invalid=1);
    dlstate_ALLOW_ErrorCount := COUNT(GROUP,h.dlstate_Invalid=1);
    city_ALLOW_ErrorCount := COUNT(GROUP,h.city_Invalid=1);
    orig_zip_ALLOW_ErrorCount := COUNT(GROUP,h.orig_zip_Invalid=1);
    institutionreceiptdate_CUSTOM_ErrorCount := COUNT(GROUP,h.institutionreceiptdate_Invalid=1);
    deceaseddate_CUSTOM_ErrorCount := COUNT(GROUP,h.deceaseddate_Invalid=1);
    sexoffenderregistrydate_CUSTOM_ErrorCount := COUNT(GROUP,h.sexoffenderregistrydate_Invalid=1);
    sexoffenderregexpirationdate_CUSTOM_ErrorCount := COUNT(GROUP,h.sexoffenderregexpirationdate_Invalid=1);
  END;
  EXPORT SummaryStats := TABLE(h,r,vendor,FEW);
  r := RECORD
    STRING10 Src;
    STRING FieldName;
    STRING FieldType;
    STRING ErrorType;
    SALT33.StrType ErrorMessage;
    SALT33.StrType FieldContents;
  END;
  r into(h le,UNSIGNED c) := TRANSFORM
    SELF.Src :=  le.vendor;
    UNSIGNED1 ErrNum := CHOOSE(c,le.recordid_Invalid,le.statecode_Invalid,le.inmatenumber_Invalid,le.dob_Invalid,le.birthcity_Invalid,le.gender_Invalid,le.race_Invalid,le.dlstate_Invalid,le.city_Invalid,le.orig_zip_Invalid,le.institutionreceiptdate_Invalid,le.deceaseddate_Invalid,le.sexoffenderregistrydate_Invalid,le.sexoffenderregexpirationdate_Invalid,100);
    SELF.ErrorMessage := IF ( ErrNum = 0, SKIP, CHOOSE(c,defendant_counties_Fields.InvalidMessage_recordid(le.recordid_Invalid),defendant_counties_Fields.InvalidMessage_statecode(le.statecode_Invalid),defendant_counties_Fields.InvalidMessage_inmatenumber(le.inmatenumber_Invalid),defendant_counties_Fields.InvalidMessage_dob(le.dob_Invalid),defendant_counties_Fields.InvalidMessage_birthcity(le.birthcity_Invalid),defendant_counties_Fields.InvalidMessage_gender(le.gender_Invalid),defendant_counties_Fields.InvalidMessage_race(le.race_Invalid),defendant_counties_Fields.InvalidMessage_dlstate(le.dlstate_Invalid),defendant_counties_Fields.InvalidMessage_city(le.city_Invalid),defendant_counties_Fields.InvalidMessage_orig_zip(le.orig_zip_Invalid),defendant_counties_Fields.InvalidMessage_institutionreceiptdate(le.institutionreceiptdate_Invalid),defendant_counties_Fields.InvalidMessage_deceaseddate(le.deceaseddate_Invalid),defendant_counties_Fields.InvalidMessage_sexoffenderregistrydate(le.sexoffenderregistrydate_Invalid),defendant_counties_Fields.InvalidMessage_sexoffenderregexpirationdate(le.sexoffenderregexpirationdate_Invalid),'UNKNOWN'));
    SELF.ErrorType := IF ( ErrNum = 0, SKIP, CHOOSE(c
          ,CHOOSE(le.recordid_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.statecode_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.inmatenumber_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.dob_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.birthcity_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.gender_Invalid,'ENUM','UNKNOWN')
          ,CHOOSE(le.race_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.dlstate_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.city_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.orig_zip_Invalid,'ALLOW','UNKNOWN')
          ,CHOOSE(le.institutionreceiptdate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.deceaseddate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sexoffenderregistrydate_Invalid,'CUSTOM','UNKNOWN')
          ,CHOOSE(le.sexoffenderregexpirationdate_Invalid,'CUSTOM','UNKNOWN'),'UNKNOWN'));
    SELF.FieldName := CHOOSE(c,'recordid','statecode','inmatenumber','dob','birthcity','gender','race','dlstate','city','orig_zip','institutionreceiptdate','deceaseddate','sexoffenderregistrydate','sexoffenderregexpirationdate','UNKNOWN');
    SELF.FieldType := CHOOSE(c,'Invalid_Record_ID','Invalid_State','Invalid_Inmate_Num','Invalid_Current_Date','Invalid_City','Invalid_Gender','Invalid_Race','Invalid_State','Invalid_City','Invalid_Zip','Invalid_Current_Date','Invalid_Future_Date','Invalid_Current_Date','Invalid_Future_Date','UNKNOWN');
    SELF.FieldContents := CHOOSE(c,(SALT33.StrType)le.recordid,(SALT33.StrType)le.statecode,(SALT33.StrType)le.inmatenumber,(SALT33.StrType)le.dob,(SALT33.StrType)le.birthcity,(SALT33.StrType)le.gender,(SALT33.StrType)le.race,(SALT33.StrType)le.dlstate,(SALT33.StrType)le.city,(SALT33.StrType)le.orig_zip,(SALT33.StrType)le.institutionreceiptdate,(SALT33.StrType)le.deceaseddate,(SALT33.StrType)le.sexoffenderregistrydate,(SALT33.StrType)le.sexoffenderregexpirationdate,'***SALTBUG***');
  END;
  EXPORT AllErrors := NORMALIZE(h,14,Into(LEFT,COUNTER));
   bv := TABLE(AllErrors,{FieldContents, FieldName, Cnt := COUNT(GROUP)},FieldContents, FieldName,MERGE);
  EXPORT BadValues := TOPN(bv,1000,-Cnt);
  // Particular form of stats required for Orbit
  EXPORT OrbitStats(UNSIGNED examples = 10,UNSIGNED Pdate=(UNSIGNED)StringLib.getdateYYYYMMDD()) := FUNCTION
    SALT33.ScrubsOrbitLayout Into(SummaryStats le, UNSIGNED c) := TRANSFORM
      SELF.recordstotal := le.TotalCnt;
      SELF.processdate := Pdate;
      SELF.sourcecode := le.vendor;
      SELF.ruledesc := CHOOSE(c
          ,'recordid:Invalid_Record_ID:ALLOW'
          ,'statecode:Invalid_State:ALLOW'
          ,'inmatenumber:Invalid_Inmate_Num:ALLOW'
          ,'dob:Invalid_Current_Date:CUSTOM'
          ,'birthcity:Invalid_City:ALLOW'
          ,'gender:Invalid_Gender:ENUM'
          ,'race:Invalid_Race:CUSTOM'
          ,'dlstate:Invalid_State:ALLOW'
          ,'city:Invalid_City:ALLOW'
          ,'orig_zip:Invalid_Zip:ALLOW'
          ,'institutionreceiptdate:Invalid_Current_Date:CUSTOM'
          ,'deceaseddate:Invalid_Future_Date:CUSTOM'
          ,'sexoffenderregistrydate:Invalid_Current_Date:CUSTOM'
          ,'sexoffenderregexpirationdate:Invalid_Future_Date:CUSTOM','UNKNOWN');
      SELF.ErrorMessage := CHOOSE(c
          ,defendant_counties_Fields.InvalidMessage_recordid(1)
          ,defendant_counties_Fields.InvalidMessage_statecode(1)
          ,defendant_counties_Fields.InvalidMessage_inmatenumber(1)
          ,defendant_counties_Fields.InvalidMessage_dob(1)
          ,defendant_counties_Fields.InvalidMessage_birthcity(1)
          ,defendant_counties_Fields.InvalidMessage_gender(1)
          ,defendant_counties_Fields.InvalidMessage_race(1)
          ,defendant_counties_Fields.InvalidMessage_dlstate(1)
          ,defendant_counties_Fields.InvalidMessage_city(1)
          ,defendant_counties_Fields.InvalidMessage_orig_zip(1)
          ,defendant_counties_Fields.InvalidMessage_institutionreceiptdate(1)
          ,defendant_counties_Fields.InvalidMessage_deceaseddate(1)
          ,defendant_counties_Fields.InvalidMessage_sexoffenderregistrydate(1)
          ,defendant_counties_Fields.InvalidMessage_sexoffenderregexpirationdate(1),'UNKNOWN');
      SELF.rulecnt := CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.inmatenumber_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.birthcity_ALLOW_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.race_CUSTOM_ErrorCount
          ,le.dlstate_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount
          ,le.institutionreceiptdate_CUSTOM_ErrorCount
          ,le.deceaseddate_CUSTOM_ErrorCount
          ,le.sexoffenderregistrydate_CUSTOM_ErrorCount
          ,le.sexoffenderregexpirationdate_CUSTOM_ErrorCount,0);
      SELF.rulepcnt := 100 * CHOOSE(c
          ,le.recordid_ALLOW_ErrorCount
          ,le.statecode_ALLOW_ErrorCount
          ,le.inmatenumber_ALLOW_ErrorCount
          ,le.dob_CUSTOM_ErrorCount
          ,le.birthcity_ALLOW_ErrorCount
          ,le.gender_ENUM_ErrorCount
          ,le.race_CUSTOM_ErrorCount
          ,le.dlstate_ALLOW_ErrorCount
          ,le.city_ALLOW_ErrorCount
          ,le.orig_zip_ALLOW_ErrorCount
          ,le.institutionreceiptdate_CUSTOM_ErrorCount
          ,le.deceaseddate_CUSTOM_ErrorCount
          ,le.sexoffenderregistrydate_CUSTOM_ErrorCount
          ,le.sexoffenderregexpirationdate_CUSTOM_ErrorCount,0) / le.TotalCnt + 0.5;
    END;
    SummaryInfo := NORMALIZE(SummaryStats,14,Into(LEFT,COUNTER));
    orb_r := RECORD
      AllErrors.Src;
      STRING RuleDesc := TRIM(AllErrors.FieldName)+':'+TRIM(AllErrors.FieldType)+':'+AllErrors.ErrorType;
      STRING ErrorMessage := TRIM(AllErrors.errormessage);
      SALT33.StrType RawCodeMissing := AllErrors.FieldContents;
    END;
    tab := TABLE(AllErrors,orb_r);
    orb_sum := TABLE(tab,{src,ruledesc,ErrorMessage,rawcodemissing,rawcodemissingcnt := COUNT(GROUP)},src,ruledesc,ErrorMessage,rawcodemissing,MERGE);
    gt := GROUP(TOPN(GROUP(orb_sum,src,ruledesc,ALL),examples,-rawcodemissingcnt));
    SALT33.ScrubsOrbitLayout jn(SummaryInfo le, gt ri) := TRANSFORM
      SELF.rawcodemissing := ri.rawcodemissing;
      SELF.rawcodemissingcnt := ri.rawcodemissingcnt;
      SELF := le;
    END;
    j := JOIN(SummaryInfo,gt,LEFT.SourceCode=RIGHT.SRC AND LEFT.ruledesc=RIGHT.ruledesc,jn(LEFT,RIGHT),HASH,LEFT OUTER);
    RETURN IF(examples>0,j,SummaryInfo);
  END;
END;
END;
