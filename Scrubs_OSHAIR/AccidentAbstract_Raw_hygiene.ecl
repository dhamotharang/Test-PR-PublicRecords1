IMPORT SALT311,STD;
EXPORT AccidentAbstract_Raw_hygiene(dataset(AccidentAbstract_Raw_Layout) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_summary_nr_cnt := COUNT(GROUP,h.summary_nr <> (TYPEOF(h.summary_nr))'');
    populated_summary_nr_pcnt := AVE(GROUP,IF(h.summary_nr = (TYPEOF(h.summary_nr))'',0,100));
    maxlength_summary_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.summary_nr)));
    avelength_summary_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.summary_nr)),h.summary_nr<>(typeof(h.summary_nr))'');
    populated_line_nr_cnt := COUNT(GROUP,h.line_nr <> (TYPEOF(h.line_nr))'');
    populated_line_nr_pcnt := AVE(GROUP,IF(h.line_nr = (TYPEOF(h.line_nr))'',0,100));
    maxlength_line_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.line_nr)));
    avelength_line_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.line_nr)),h.line_nr<>(typeof(h.line_nr))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_summary_nr_pcnt *   0.00 / 100 + T.Populated_line_nr_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'summary_nr','line_nr');
  SELF.populated_pcnt := CHOOSE(C,le.populated_summary_nr_pcnt,le.populated_line_nr_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_summary_nr,le.maxlength_line_nr);
  SELF.avelength := CHOOSE(C,le.avelength_summary_nr,le.avelength_line_nr);
END;
EXPORT invSummary := NORMALIZE(summary0, 2, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.line_nr)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,2,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 2);
  SELF.FldNo2 := 1 + (C % 2);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.line_nr)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.line_nr)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),2*2,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'summary_nr'}
      ,{2,'line_nr'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    AccidentAbstract_Raw_Fields.InValid_summary_nr((SALT311.StrType)le.summary_nr),
    AccidentAbstract_Raw_Fields.InValid_line_nr((SALT311.StrType)le.line_nr),
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
  FieldNme := AccidentAbstract_Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,AccidentAbstract_Raw_Fields.InValidMessage_summary_nr(TotalErrors.ErrorNum),AccidentAbstract_Raw_Fields.InValidMessage_line_nr(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, AccidentAbstract_Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
