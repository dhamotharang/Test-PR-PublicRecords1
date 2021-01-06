IMPORT SALT311,STD;
EXPORT PortData_ValidateIn_hygiene(dataset(PortData_ValidateIn_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_tid_cnt := COUNT(GROUP,h.tid <> (TYPEOF(h.tid))'');
    populated_tid_pcnt := AVE(GROUP,IF(h.tid = (TYPEOF(h.tid))'',0,100));
    maxlength_tid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.tid)));
    avelength_tid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.tid)),h.tid<>(typeof(h.tid))'');
    populated_action_cnt := COUNT(GROUP,h.action <> (TYPEOF(h.action))'');
    populated_action_pcnt := AVE(GROUP,IF(h.action = (TYPEOF(h.action))'',0,100));
    maxlength_action := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.action)));
    avelength_action := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.action)),h.action<>(typeof(h.action))'');
    populated_actts_cnt := COUNT(GROUP,h.actts <> (TYPEOF(h.actts))'');
    populated_actts_pcnt := AVE(GROUP,IF(h.actts = (TYPEOF(h.actts))'',0,100));
    maxlength_actts := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.actts)));
    avelength_actts := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.actts)),h.actts<>(typeof(h.actts))'');
    populated_digits_cnt := COUNT(GROUP,h.digits <> (TYPEOF(h.digits))'');
    populated_digits_pcnt := AVE(GROUP,IF(h.digits = (TYPEOF(h.digits))'',0,100));
    maxlength_digits := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.digits)));
    avelength_digits := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.digits)),h.digits<>(typeof(h.digits))'');
    populated_spid_cnt := COUNT(GROUP,h.spid <> (TYPEOF(h.spid))'');
    populated_spid_pcnt := AVE(GROUP,IF(h.spid = (TYPEOF(h.spid))'',0,100));
    maxlength_spid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.spid)));
    avelength_spid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.spid)),h.spid<>(typeof(h.spid))'');
    populated_altspid_cnt := COUNT(GROUP,h.altspid <> (TYPEOF(h.altspid))'');
    populated_altspid_pcnt := AVE(GROUP,IF(h.altspid = (TYPEOF(h.altspid))'',0,100));
    maxlength_altspid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.altspid)));
    avelength_altspid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.altspid)),h.altspid<>(typeof(h.altspid))'');
    populated_laltspid_cnt := COUNT(GROUP,h.laltspid <> (TYPEOF(h.laltspid))'');
    populated_laltspid_pcnt := AVE(GROUP,IF(h.laltspid = (TYPEOF(h.laltspid))'',0,100));
    maxlength_laltspid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.laltspid)));
    avelength_laltspid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.laltspid)),h.laltspid<>(typeof(h.laltspid))'');
    populated_linetype_cnt := COUNT(GROUP,h.linetype <> (TYPEOF(h.linetype))'');
    populated_linetype_pcnt := AVE(GROUP,IF(h.linetype = (TYPEOF(h.linetype))'',0,100));
    maxlength_linetype := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.linetype)));
    avelength_linetype := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.linetype)),h.linetype<>(typeof(h.linetype))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_tid_pcnt *   0.00 / 100 + T.Populated_action_pcnt *   0.00 / 100 + T.Populated_actts_pcnt *   0.00 / 100 + T.Populated_digits_pcnt *   0.00 / 100 + T.Populated_spid_pcnt *   0.00 / 100 + T.Populated_altspid_pcnt *   0.00 / 100 + T.Populated_laltspid_pcnt *   0.00 / 100 + T.Populated_linetype_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT311.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'tid','action','actts','digits','spid','altspid','laltspid','linetype');
  SELF.populated_pcnt := CHOOSE(C,le.populated_tid_pcnt,le.populated_action_pcnt,le.populated_actts_pcnt,le.populated_digits_pcnt,le.populated_spid_pcnt,le.populated_altspid_pcnt,le.populated_laltspid_pcnt,le.populated_linetype_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_tid,le.maxlength_action,le.maxlength_actts,le.maxlength_digits,le.maxlength_spid,le.maxlength_altspid,le.maxlength_laltspid,le.maxlength_linetype);
  SELF.avelength := CHOOSE(C,le.avelength_tid,le.avelength_action,le.avelength_actts,le.avelength_digits,le.avelength_spid,le.avelength_altspid,le.avelength_laltspid,le.avelength_linetype);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.tid),TRIM((SALT311.StrType)le.action),TRIM((SALT311.StrType)le.actts),TRIM((SALT311.StrType)le.digits),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.altspid),TRIM((SALT311.StrType)le.laltspid),TRIM((SALT311.StrType)le.linetype)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.tid),TRIM((SALT311.StrType)le.action),TRIM((SALT311.StrType)le.actts),TRIM((SALT311.StrType)le.digits),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.altspid),TRIM((SALT311.StrType)le.laltspid),TRIM((SALT311.StrType)le.linetype)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.tid),TRIM((SALT311.StrType)le.action),TRIM((SALT311.StrType)le.actts),TRIM((SALT311.StrType)le.digits),TRIM((SALT311.StrType)le.spid),TRIM((SALT311.StrType)le.altspid),TRIM((SALT311.StrType)le.laltspid),TRIM((SALT311.StrType)le.linetype)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'tid'}
      ,{2,'action'}
      ,{3,'actts'}
      ,{4,'digits'}
      ,{5,'spid'}
      ,{6,'altspid'}
      ,{7,'laltspid'}
      ,{8,'linetype'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    PortData_ValidateIn_Fields.InValid_tid((SALT311.StrType)le.tid),
    PortData_ValidateIn_Fields.InValid_action((SALT311.StrType)le.action),
    PortData_ValidateIn_Fields.InValid_actts((SALT311.StrType)le.actts),
    PortData_ValidateIn_Fields.InValid_digits((SALT311.StrType)le.digits),
    PortData_ValidateIn_Fields.InValid_spid((SALT311.StrType)le.spid),
    PortData_ValidateIn_Fields.InValid_altspid((SALT311.StrType)le.altspid),
    PortData_ValidateIn_Fields.InValid_laltspid((SALT311.StrType)le.laltspid),
    PortData_ValidateIn_Fields.InValid_linetype((SALT311.StrType)le.linetype),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,8,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := PortData_ValidateIn_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Num','Invalid_Action','Invalid_AlphaNum','Invalid_Num','Invalid_AlphaNum_Spc','Invalid_AlphaNum_Spc','Invalid_AlphaNum_Spc','Invalid_Type');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,PortData_ValidateIn_Fields.InValidMessage_tid(TotalErrors.ErrorNum),PortData_ValidateIn_Fields.InValidMessage_action(TotalErrors.ErrorNum),PortData_ValidateIn_Fields.InValidMessage_actts(TotalErrors.ErrorNum),PortData_ValidateIn_Fields.InValidMessage_digits(TotalErrors.ErrorNum),PortData_ValidateIn_Fields.InValidMessage_spid(TotalErrors.ErrorNum),PortData_ValidateIn_Fields.InValidMessage_altspid(TotalErrors.ErrorNum),PortData_ValidateIn_Fields.InValidMessage_laltspid(TotalErrors.ErrorNum),PortData_ValidateIn_Fields.InValidMessage_linetype(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, PortData_ValidateIn_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
