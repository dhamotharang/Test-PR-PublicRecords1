IMPORT SALT311,STD;
EXPORT DEDI_hygiene(dataset(DEDI_layout_DEDI) h) := MODULE
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_domain_cnt := COUNT(GROUP,h.domain <> (TYPEOF(h.domain))'');
    populated_domain_pcnt := AVE(GROUP,IF(h.domain = (TYPEOF(h.domain))'',0,100));
    maxlength_domain := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.domain)));
    avelength_domain := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.domain)),h.domain<>(typeof(h.domain))'');
    populated_dispsblemail_cnt := COUNT(GROUP,h.dispsblemail <> (TYPEOF(h.dispsblemail))'');
    populated_dispsblemail_pcnt := AVE(GROUP,IF(h.dispsblemail = (TYPEOF(h.dispsblemail))'',0,100));
    maxlength_dispsblemail := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispsblemail)));
    avelength_dispsblemail := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dispsblemail)),h.dispsblemail<>(typeof(h.dispsblemail))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_domain_pcnt *   0.00 / 100 + T.Populated_dispsblemail_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'domain','dispsblemail');
  SELF.populated_pcnt := CHOOSE(C,le.populated_domain_pcnt,le.populated_dispsblemail_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_domain,le.maxlength_dispsblemail);
  SELF.avelength := CHOOSE(C,le.avelength_domain,le.avelength_dispsblemail);
END;
EXPORT invSummary := NORMALIZE(summary0, 2, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.domain),TRIM((SALT311.StrType)le.dispsblemail)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,2,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 2);
  SELF.FldNo2 := 1 + (C % 2);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.domain),TRIM((SALT311.StrType)le.dispsblemail)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.domain),TRIM((SALT311.StrType)le.dispsblemail)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),2*2,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'domain'}
      ,{2,'dispsblemail'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    DEDI_Fields.InValid_domain((SALT311.StrType)le.domain),
    DEDI_Fields.InValid_dispsblemail((SALT311.StrType)le.dispsblemail),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,2,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := DEDI_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_alphanumeric','invalid_alpha');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,DEDI_Fields.InValidMessage_domain(TotalErrors.ErrorNum),DEDI_Fields.InValidMessage_dispsblemail(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, DEDI_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
