IMPORT ut,SALT32;
EXPORT hygiene(dataset(layout_in_file) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT32.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_corp_key_pcnt := AVE(GROUP,IF(h.corp_key = (TYPEOF(h.corp_key))'',0,100));
    maxlength_corp_key := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.corp_key)));
    avelength_corp_key := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.corp_key)),h.corp_key<>(typeof(h.corp_key))'');
    populated_corp_sos_charter_nbr_pcnt := AVE(GROUP,IF(h.corp_sos_charter_nbr = (TYPEOF(h.corp_sos_charter_nbr))'',0,100));
    maxlength_corp_sos_charter_nbr := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.corp_sos_charter_nbr)));
    avelength_corp_sos_charter_nbr := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.corp_sos_charter_nbr)),h.corp_sos_charter_nbr<>(typeof(h.corp_sos_charter_nbr))'');
    populated_event_revocation_comment1_pcnt := AVE(GROUP,IF(h.event_revocation_comment1 = (TYPEOF(h.event_revocation_comment1))'',0,100));
    maxlength_event_revocation_comment1 := MAX(GROUP,LENGTH(TRIM((SALT32.StrType)h.event_revocation_comment1)));
    avelength_event_revocation_comment1 := AVE(GROUP,LENGTH(TRIM((SALT32.StrType)h.event_revocation_comment1)),h.event_revocation_comment1<>(typeof(h.event_revocation_comment1))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_corp_key_pcnt *   0.00 / 100 + T.Populated_corp_sos_charter_nbr_pcnt *   0.00 / 100 + T.Populated_event_revocation_comment1_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT32.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'corp_key','corp_sos_charter_nbr','event_revocation_comment1');
  SELF.populated_pcnt := CHOOSE(C,le.populated_corp_key_pcnt,le.populated_corp_sos_charter_nbr_pcnt,le.populated_event_revocation_comment1_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_corp_key,le.maxlength_corp_sos_charter_nbr,le.maxlength_event_revocation_comment1);
  SELF.avelength := CHOOSE(C,le.avelength_corp_key,le.avelength_corp_sos_charter_nbr,le.avelength_event_revocation_comment1);
END;
EXPORT invSummary := NORMALIZE(summary0, 3, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT32.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT32.StrType)le.corp_key),TRIM((SALT32.StrType)le.corp_sos_charter_nbr),TRIM((SALT32.StrType)le.event_revocation_comment1)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,3,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT32.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 3);
  SELF.FldNo2 := 1 + (C % 3);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT32.StrType)le.corp_key),TRIM((SALT32.StrType)le.corp_sos_charter_nbr),TRIM((SALT32.StrType)le.event_revocation_comment1)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT32.StrType)le.corp_key),TRIM((SALT32.StrType)le.corp_sos_charter_nbr),TRIM((SALT32.StrType)le.event_revocation_comment1)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),3*3,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'corp_key'}
      ,{2,'corp_sos_charter_nbr'}
      ,{3,'event_revocation_comment1'}],SALT32.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT32.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT32.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT32.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_corp_key((SALT32.StrType)le.corp_key),
    Fields.InValid_corp_sos_charter_nbr((SALT32.StrType)le.corp_sos_charter_nbr),
    Fields.InValid_event_revocation_comment1((SALT32.StrType)le.event_revocation_comment1),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,3,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_corp_key','invalid_charter','invalid_cd');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_corp_key(TotalErrors.ErrorNum),Fields.InValidMessage_corp_sos_charter_nbr(TotalErrors.ErrorNum),Fields.InValidMessage_event_revocation_comment1(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
