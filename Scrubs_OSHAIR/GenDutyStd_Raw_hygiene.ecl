IMPORT SALT311,STD;
EXPORT GenDutyStd_Raw_hygiene(dataset(GenDutyStd_Raw_Layout) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_activity_nr_cnt := COUNT(GROUP,h.activity_nr <> (TYPEOF(h.activity_nr))'');
    populated_activity_nr_pcnt := AVE(GROUP,IF(h.activity_nr = (TYPEOF(h.activity_nr))'',0,100));
    maxlength_activity_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)));
    avelength_activity_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)),h.activity_nr<>(typeof(h.activity_nr))'');
    populated_citation_id_cnt := COUNT(GROUP,h.citation_id <> (TYPEOF(h.citation_id))'');
    populated_citation_id_pcnt := AVE(GROUP,IF(h.citation_id = (TYPEOF(h.citation_id))'',0,100));
    maxlength_citation_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.citation_id)));
    avelength_citation_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.citation_id)),h.citation_id<>(typeof(h.citation_id))'');
    populated_line_nr_cnt := COUNT(GROUP,h.line_nr <> (TYPEOF(h.line_nr))'');
    populated_line_nr_pcnt := AVE(GROUP,IF(h.line_nr = (TYPEOF(h.line_nr))'',0,100));
    maxlength_line_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.line_nr)));
    avelength_line_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.line_nr)),h.line_nr<>(typeof(h.line_nr))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_activity_nr_pcnt *   0.00 / 100 + T.Populated_citation_id_pcnt *   0.00 / 100 + T.Populated_line_nr_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'activity_nr','citation_id','line_nr');
  SELF.populated_pcnt := CHOOSE(C,le.populated_activity_nr_pcnt,le.populated_citation_id_pcnt,le.populated_line_nr_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_activity_nr,le.maxlength_citation_id,le.maxlength_line_nr);
  SELF.avelength := CHOOSE(C,le.avelength_activity_nr,le.avelength_citation_id,le.avelength_line_nr);
END;
EXPORT invSummary := NORMALIZE(summary0, 3, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.citation_id),TRIM((SALT311.StrType)le.line_nr)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,3,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 3);
  SELF.FldNo2 := 1 + (C % 3);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.citation_id),TRIM((SALT311.StrType)le.line_nr)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.citation_id),TRIM((SALT311.StrType)le.line_nr)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),3*3,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'activity_nr'}
      ,{2,'citation_id'}
      ,{3,'line_nr'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    GenDutyStd_Raw_Fields.InValid_activity_nr((SALT311.StrType)le.activity_nr),
    GenDutyStd_Raw_Fields.InValid_citation_id((SALT311.StrType)le.citation_id),
    GenDutyStd_Raw_Fields.InValid_line_nr((SALT311.StrType)le.line_nr),
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
  FieldNme := GenDutyStd_Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_alpha_numeric','invalid_numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,GenDutyStd_Raw_Fields.InValidMessage_activity_nr(TotalErrors.ErrorNum),GenDutyStd_Raw_Fields.InValidMessage_citation_id(TotalErrors.ErrorNum),GenDutyStd_Raw_Fields.InValidMessage_line_nr(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, GenDutyStd_Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
