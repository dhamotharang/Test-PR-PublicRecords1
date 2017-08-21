IMPORT ut,SALT31;
EXPORT DeactPattern_hygiene(dataset(DeactPattern_layout_PhonesInfo) h) := MODULE
//A simple summary record
EXPORT Summary(SALT31.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_patternfield_pcnt := AVE(GROUP,IF(h.patternfield = (TYPEOF(h.patternfield))'',0,100));
    maxlength_patternfield := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.patternfield)));
    avelength_patternfield := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.patternfield)),h.patternfield<>(typeof(h.patternfield))'');
    populated_population_pcnt := AVE(GROUP,IF(h.population = (TYPEOF(h.population))'',0,100));
    maxlength_population := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.population)));
    avelength_population := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.population)),h.population<>(typeof(h.population))'');
    populated_total_pcnt := AVE(GROUP,IF(h.total = (TYPEOF(h.total))'',0,100));
    maxlength_total := MAX(GROUP,LENGTH(TRIM((SALT31.StrType)h.total)));
    avelength_total := AVE(GROUP,LENGTH(TRIM((SALT31.StrType)h.total)),h.total<>(typeof(h.total))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_patternfield_pcnt *   0.00 / 100 + T.Populated_population_pcnt *   0.00 / 100 + T.Populated_total_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT31.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'patternfield','population','total');
  SELF.populated_pcnt := CHOOSE(C,le.populated_patternfield_pcnt,le.populated_population_pcnt,le.populated_total_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_patternfield,le.maxlength_population,le.maxlength_total);
  SELF.avelength := CHOOSE(C,le.avelength_patternfield,le.avelength_population,le.avelength_total);
END;
EXPORT invSummary := NORMALIZE(summary0, 3, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT31.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT31.StrType)le.patternfield),TRIM((SALT31.StrType)le.population),TRIM((SALT31.StrType)le.total)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,3,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT31.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 3);
  SELF.FldNo2 := 1 + (C % 3);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT31.StrType)le.patternfield),TRIM((SALT31.StrType)le.population),TRIM((SALT31.StrType)le.total)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT31.StrType)le.patternfield),TRIM((SALT31.StrType)le.population),TRIM((SALT31.StrType)le.total)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),3*3,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'patternfield'}
      ,{2,'population'}
      ,{3,'total'}],SALT31.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT31.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
EXPORT SrcProfiles := SALT31.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
EXPORT Correlations := SALT31.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    DeactPattern_Fields.InValid_patternfield((SALT31.StrType)le.patternfield),
    DeactPattern_Fields.InValid_population((SALT31.StrType)le.population,(SALT31.StrType)le.patternfield,(SALT31.StrType)le.total),
    DeactPattern_Fields.InValid_total((SALT31.StrType)le.total),
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
  FieldNme := DeactPattern_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Invalid_Population','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,DeactPattern_Fields.InValidMessage_patternfield(TotalErrors.ErrorNum),DeactPattern_Fields.InValidMessage_population(TotalErrors.ErrorNum),DeactPattern_Fields.InValidMessage_total(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
