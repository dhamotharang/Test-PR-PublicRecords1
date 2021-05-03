IMPORT SALT311,STD;
EXPORT Contacts_hygiene(dataset(Contacts_layout_Equifax_Business_Data) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_EFX_id_cnt := COUNT(GROUP,h.EFX_id <> (TYPEOF(h.EFX_id))'');
    populated_EFX_id_pcnt := AVE(GROUP,IF(h.EFX_id = (TYPEOF(h.EFX_id))'',0,100));
    maxlength_EFX_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_id)));
    avelength_EFX_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_id)),h.EFX_id<>(typeof(h.EFX_id))'');
    populated_EFX_CONTCT_cnt := COUNT(GROUP,h.EFX_CONTCT <> (TYPEOF(h.EFX_CONTCT))'');
    populated_EFX_CONTCT_pcnt := AVE(GROUP,IF(h.EFX_CONTCT = (TYPEOF(h.EFX_CONTCT))'',0,100));
    maxlength_EFX_CONTCT := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_CONTCT)));
    avelength_EFX_CONTCT := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_CONTCT)),h.EFX_CONTCT<>(typeof(h.EFX_CONTCT))'');
    populated_EFX_TITLECD_cnt := COUNT(GROUP,h.EFX_TITLECD <> (TYPEOF(h.EFX_TITLECD))'');
    populated_EFX_TITLECD_pcnt := AVE(GROUP,IF(h.EFX_TITLECD = (TYPEOF(h.EFX_TITLECD))'',0,100));
    maxlength_EFX_TITLECD := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_TITLECD)));
    avelength_EFX_TITLECD := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_TITLECD)),h.EFX_TITLECD<>(typeof(h.EFX_TITLECD))'');
    populated_EFX_TITLEDESC_cnt := COUNT(GROUP,h.EFX_TITLEDESC <> (TYPEOF(h.EFX_TITLEDESC))'');
    populated_EFX_TITLEDESC_pcnt := AVE(GROUP,IF(h.EFX_TITLEDESC = (TYPEOF(h.EFX_TITLEDESC))'',0,100));
    maxlength_EFX_TITLEDESC := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_TITLEDESC)));
    avelength_EFX_TITLEDESC := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_TITLEDESC)),h.EFX_TITLEDESC<>(typeof(h.EFX_TITLEDESC))'');
    populated_EFX_LASTNAM_cnt := COUNT(GROUP,h.EFX_LASTNAM <> (TYPEOF(h.EFX_LASTNAM))'');
    populated_EFX_LASTNAM_pcnt := AVE(GROUP,IF(h.EFX_LASTNAM = (TYPEOF(h.EFX_LASTNAM))'',0,100));
    maxlength_EFX_LASTNAM := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_LASTNAM)));
    avelength_EFX_LASTNAM := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_LASTNAM)),h.EFX_LASTNAM<>(typeof(h.EFX_LASTNAM))'');
    populated_EFX_FSTNAM_cnt := COUNT(GROUP,h.EFX_FSTNAM <> (TYPEOF(h.EFX_FSTNAM))'');
    populated_EFX_FSTNAM_pcnt := AVE(GROUP,IF(h.EFX_FSTNAM = (TYPEOF(h.EFX_FSTNAM))'',0,100));
    maxlength_EFX_FSTNAM := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_FSTNAM)));
    avelength_EFX_FSTNAM := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_FSTNAM)),h.EFX_FSTNAM<>(typeof(h.EFX_FSTNAM))'');
    populated_EFX_EMAIL_cnt := COUNT(GROUP,h.EFX_EMAIL <> (TYPEOF(h.EFX_EMAIL))'');
    populated_EFX_EMAIL_pcnt := AVE(GROUP,IF(h.EFX_EMAIL = (TYPEOF(h.EFX_EMAIL))'',0,100));
    maxlength_EFX_EMAIL := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_EMAIL)));
    avelength_EFX_EMAIL := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_EMAIL)),h.EFX_EMAIL<>(typeof(h.EFX_EMAIL))'');
    populated_EFX_DATE_cnt := COUNT(GROUP,h.EFX_DATE <> (TYPEOF(h.EFX_DATE))'');
    populated_EFX_DATE_pcnt := AVE(GROUP,IF(h.EFX_DATE = (TYPEOF(h.EFX_DATE))'',0,100));
    maxlength_EFX_DATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_DATE)));
    avelength_EFX_DATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EFX_DATE)),h.EFX_DATE<>(typeof(h.EFX_DATE))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_EFX_id_pcnt *   0.00 / 100 + T.Populated_EFX_CONTCT_pcnt *   0.00 / 100 + T.Populated_EFX_TITLECD_pcnt *   0.00 / 100 + T.Populated_EFX_TITLEDESC_pcnt *   0.00 / 100 + T.Populated_EFX_LASTNAM_pcnt *   0.00 / 100 + T.Populated_EFX_FSTNAM_pcnt *   0.00 / 100 + T.Populated_EFX_EMAIL_pcnt *   0.00 / 100 + T.Populated_EFX_DATE_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'EFX_id','EFX_CONTCT','EFX_TITLECD','EFX_TITLEDESC','EFX_LASTNAM','EFX_FSTNAM','EFX_EMAIL','EFX_DATE');
  SELF.populated_pcnt := CHOOSE(C,le.populated_EFX_id_pcnt,le.populated_EFX_CONTCT_pcnt,le.populated_EFX_TITLECD_pcnt,le.populated_EFX_TITLEDESC_pcnt,le.populated_EFX_LASTNAM_pcnt,le.populated_EFX_FSTNAM_pcnt,le.populated_EFX_EMAIL_pcnt,le.populated_EFX_DATE_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_EFX_id,le.maxlength_EFX_CONTCT,le.maxlength_EFX_TITLECD,le.maxlength_EFX_TITLEDESC,le.maxlength_EFX_LASTNAM,le.maxlength_EFX_FSTNAM,le.maxlength_EFX_EMAIL,le.maxlength_EFX_DATE);
  SELF.avelength := CHOOSE(C,le.avelength_EFX_id,le.avelength_EFX_CONTCT,le.avelength_EFX_TITLECD,le.avelength_EFX_TITLEDESC,le.avelength_EFX_LASTNAM,le.avelength_EFX_FSTNAM,le.avelength_EFX_EMAIL,le.avelength_EFX_DATE);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.EFX_id),TRIM((SALT311.StrType)le.EFX_CONTCT),TRIM((SALT311.StrType)le.EFX_TITLECD),TRIM((SALT311.StrType)le.EFX_TITLEDESC),TRIM((SALT311.StrType)le.EFX_LASTNAM),TRIM((SALT311.StrType)le.EFX_FSTNAM),TRIM((SALT311.StrType)le.EFX_EMAIL),TRIM((SALT311.StrType)le.EFX_DATE)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.EFX_id),TRIM((SALT311.StrType)le.EFX_CONTCT),TRIM((SALT311.StrType)le.EFX_TITLECD),TRIM((SALT311.StrType)le.EFX_TITLEDESC),TRIM((SALT311.StrType)le.EFX_LASTNAM),TRIM((SALT311.StrType)le.EFX_FSTNAM),TRIM((SALT311.StrType)le.EFX_EMAIL),TRIM((SALT311.StrType)le.EFX_DATE)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.EFX_id),TRIM((SALT311.StrType)le.EFX_CONTCT),TRIM((SALT311.StrType)le.EFX_TITLECD),TRIM((SALT311.StrType)le.EFX_TITLEDESC),TRIM((SALT311.StrType)le.EFX_LASTNAM),TRIM((SALT311.StrType)le.EFX_FSTNAM),TRIM((SALT311.StrType)le.EFX_EMAIL),TRIM((SALT311.StrType)le.EFX_DATE)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'EFX_id'}
      ,{2,'EFX_CONTCT'}
      ,{3,'EFX_TITLECD'}
      ,{4,'EFX_TITLEDESC'}
      ,{5,'EFX_LASTNAM'}
      ,{6,'EFX_FSTNAM'}
      ,{7,'EFX_EMAIL'}
      ,{8,'EFX_DATE'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Contacts_Fields.InValid_EFX_id((SALT311.StrType)le.EFX_id),
    Contacts_Fields.InValid_EFX_CONTCT((SALT311.StrType)le.EFX_CONTCT),
    Contacts_Fields.InValid_EFX_TITLECD((SALT311.StrType)le.EFX_TITLECD),
    Contacts_Fields.InValid_EFX_TITLEDESC((SALT311.StrType)le.EFX_TITLEDESC),
    Contacts_Fields.InValid_EFX_LASTNAM((SALT311.StrType)le.EFX_LASTNAM),
    Contacts_Fields.InValid_EFX_FSTNAM((SALT311.StrType)le.EFX_FSTNAM),
    Contacts_Fields.InValid_EFX_EMAIL((SALT311.StrType)le.EFX_EMAIL),
    Contacts_Fields.InValid_EFX_DATE((SALT311.StrType)le.EFX_DATE),
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
  FieldNme := Contacts_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_efx_id','invalid_mandatory','invalid_title','invalid_title_desc','invalid_last_name','invalid_first_name','Unknown','invalid_efx_date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Contacts_Fields.InValidMessage_EFX_id(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_EFX_CONTCT(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_EFX_TITLECD(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_EFX_TITLEDESC(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_EFX_LASTNAM(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_EFX_FSTNAM(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_EFX_EMAIL(TotalErrors.ErrorNum),Contacts_Fields.InValidMessage_EFX_DATE(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Equifax_Business_Data, Contacts_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
