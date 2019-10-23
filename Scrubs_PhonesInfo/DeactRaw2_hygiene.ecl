IMPORT SALT39,STD;
EXPORT DeactRaw2_hygiene(dataset(DeactRaw2_layout_Phonesinfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_msisdn_cnt := COUNT(GROUP,h.msisdn <> (TYPEOF(h.msisdn))'');
    populated_msisdn_pcnt := AVE(GROUP,IF(h.msisdn = (TYPEOF(h.msisdn))'',0,100));
    maxlength_msisdn := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.msisdn)));
    avelength_msisdn := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.msisdn)),h.msisdn<>(typeof(h.msisdn))'');
    populated_timestamp_cnt := COUNT(GROUP,h.timestamp <> (TYPEOF(h.timestamp))'');
    populated_timestamp_pcnt := AVE(GROUP,IF(h.timestamp = (TYPEOF(h.timestamp))'',0,100));
    maxlength_timestamp := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.timestamp)));
    avelength_timestamp := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.timestamp)),h.timestamp<>(typeof(h.timestamp))'');
    populated_changeid_cnt := COUNT(GROUP,h.changeid <> (TYPEOF(h.changeid))'');
    populated_changeid_pcnt := AVE(GROUP,IF(h.changeid = (TYPEOF(h.changeid))'',0,100));
    maxlength_changeid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.changeid)));
    avelength_changeid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.changeid)),h.changeid<>(typeof(h.changeid))'');
    populated_operatorid_cnt := COUNT(GROUP,h.operatorid <> (TYPEOF(h.operatorid))'');
    populated_operatorid_pcnt := AVE(GROUP,IF(h.operatorid = (TYPEOF(h.operatorid))'',0,100));
    maxlength_operatorid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.operatorid)));
    avelength_operatorid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.operatorid)),h.operatorid<>(typeof(h.operatorid))'');
    populated_msisdneid_cnt := COUNT(GROUP,h.msisdneid <> (TYPEOF(h.msisdneid))'');
    populated_msisdneid_pcnt := AVE(GROUP,IF(h.msisdneid = (TYPEOF(h.msisdneid))'',0,100));
    maxlength_msisdneid := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.msisdneid)));
    avelength_msisdneid := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.msisdneid)),h.msisdneid<>(typeof(h.msisdneid))'');
    populated_msisdnnew_cnt := COUNT(GROUP,h.msisdnnew <> (TYPEOF(h.msisdnnew))'');
    populated_msisdnnew_pcnt := AVE(GROUP,IF(h.msisdnnew = (TYPEOF(h.msisdnnew))'',0,100));
    maxlength_msisdnnew := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.msisdnnew)));
    avelength_msisdnnew := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.msisdnnew)),h.msisdnnew<>(typeof(h.msisdnnew))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_msisdn_pcnt *   0.00 / 100 + T.Populated_timestamp_pcnt *   0.00 / 100 + T.Populated_changeid_pcnt *   0.00 / 100 + T.Populated_operatorid_pcnt *   0.00 / 100 + T.Populated_msisdneid_pcnt *   0.00 / 100 + T.Populated_msisdnnew_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'msisdn','timestamp','changeid','operatorid','msisdneid','msisdnnew','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_msisdn_pcnt,le.populated_timestamp_pcnt,le.populated_changeid_pcnt,le.populated_operatorid_pcnt,le.populated_msisdneid_pcnt,le.populated_msisdnnew_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_msisdn,le.maxlength_timestamp,le.maxlength_changeid,le.maxlength_operatorid,le.maxlength_msisdneid,le.maxlength_msisdnnew,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_msisdn,le.avelength_timestamp,le.avelength_changeid,le.avelength_operatorid,le.avelength_msisdneid,le.avelength_msisdnnew,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 7, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT39.StrType)le.msisdn),TRIM((SALT39.StrType)le.timestamp),TRIM((SALT39.StrType)le.changeid),TRIM((SALT39.StrType)le.operatorid),TRIM((SALT39.StrType)le.msisdneid),TRIM((SALT39.StrType)le.msisdnnew),TRIM((SALT39.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,7,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 7);
  SELF.FldNo2 := 1 + (C % 7);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT39.StrType)le.msisdn),TRIM((SALT39.StrType)le.timestamp),TRIM((SALT39.StrType)le.changeid),TRIM((SALT39.StrType)le.operatorid),TRIM((SALT39.StrType)le.msisdneid),TRIM((SALT39.StrType)le.msisdnnew),TRIM((SALT39.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT39.StrType)le.msisdn),TRIM((SALT39.StrType)le.timestamp),TRIM((SALT39.StrType)le.changeid),TRIM((SALT39.StrType)le.operatorid),TRIM((SALT39.StrType)le.msisdneid),TRIM((SALT39.StrType)le.msisdnnew),TRIM((SALT39.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),7*7,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'msisdn'}
      ,{2,'timestamp'}
      ,{3,'changeid'}
      ,{4,'operatorid'}
      ,{5,'msisdneid'}
      ,{6,'msisdnnew'}
      ,{7,'filename'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    DeactRaw2_Fields.InValid_msisdn((SALT39.StrType)le.msisdn),
    DeactRaw2_Fields.InValid_timestamp((SALT39.StrType)le.timestamp),
    DeactRaw2_Fields.InValid_changeid((SALT39.StrType)le.changeid),
    DeactRaw2_Fields.InValid_operatorid((SALT39.StrType)le.operatorid),
    DeactRaw2_Fields.InValid_msisdneid((SALT39.StrType)le.msisdneid),
    DeactRaw2_Fields.InValid_msisdnnew((SALT39.StrType)le.msisdnnew),
    DeactRaw2_Fields.InValid_filename((SALT39.StrType)le.filename),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,7,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := DeactRaw2_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_TimeStamp','Invalid_Num','Invalid_Num','Invalid_Num','Invalid_Num','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,DeactRaw2_Fields.InValidMessage_msisdn(TotalErrors.ErrorNum),DeactRaw2_Fields.InValidMessage_timestamp(TotalErrors.ErrorNum),DeactRaw2_Fields.InValidMessage_changeid(TotalErrors.ErrorNum),DeactRaw2_Fields.InValidMessage_operatorid(TotalErrors.ErrorNum),DeactRaw2_Fields.InValidMessage_msisdneid(TotalErrors.ErrorNum),DeactRaw2_Fields.InValidMessage_msisdnnew(TotalErrors.ErrorNum),DeactRaw2_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Phonesinfo, DeactRaw2_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
