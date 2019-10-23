IMPORT SALT38,STD;
EXPORT Medians_hygiene(dataset(Medians_layout_AVM) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_history_date_cnt := COUNT(GROUP,h.history_date <> (TYPEOF(h.history_date))'');
    populated_history_date_pcnt := AVE(GROUP,IF(h.history_date = (TYPEOF(h.history_date))'',0,100));
    maxlength_history_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_date)));
    avelength_history_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_date)),h.history_date<>(typeof(h.history_date))'');
    populated_fips_geo_12_cnt := COUNT(GROUP,h.fips_geo_12 <> (TYPEOF(h.fips_geo_12))'');
    populated_fips_geo_12_pcnt := AVE(GROUP,IF(h.fips_geo_12 = (TYPEOF(h.fips_geo_12))'',0,100));
    maxlength_fips_geo_12 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_geo_12)));
    avelength_fips_geo_12 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.fips_geo_12)),h.fips_geo_12<>(typeof(h.fips_geo_12))'');
    populated_median_valuation_cnt := COUNT(GROUP,h.median_valuation <> (TYPEOF(h.median_valuation))'');
    populated_median_valuation_pcnt := AVE(GROUP,IF(h.median_valuation = (TYPEOF(h.median_valuation))'',0,100));
    maxlength_median_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.median_valuation)));
    avelength_median_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.median_valuation)),h.median_valuation<>(typeof(h.median_valuation))'');
    populated_history_history_date_cnt := COUNT(GROUP,h.history_history_date <> (TYPEOF(h.history_history_date))'');
    populated_history_history_date_pcnt := AVE(GROUP,IF(h.history_history_date = (TYPEOF(h.history_history_date))'',0,100));
    maxlength_history_history_date := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_history_date)));
    avelength_history_history_date := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_history_date)),h.history_history_date<>(typeof(h.history_history_date))'');
    populated_history_median_valuation_cnt := COUNT(GROUP,h.history_median_valuation <> (TYPEOF(h.history_median_valuation))'');
    populated_history_median_valuation_pcnt := AVE(GROUP,IF(h.history_median_valuation = (TYPEOF(h.history_median_valuation))'',0,100));
    maxlength_history_median_valuation := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_median_valuation)));
    avelength_history_median_valuation := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.history_median_valuation)),h.history_median_valuation<>(typeof(h.history_median_valuation))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_history_date_pcnt *   0.00 / 100 + T.Populated_fips_geo_12_pcnt *   0.00 / 100 + T.Populated_median_valuation_pcnt *   0.00 / 100 + T.Populated_history_history_date_pcnt *   0.00 / 100 + T.Populated_history_median_valuation_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT38.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'history_date','fips_geo_12','median_valuation','history_history_date','history_median_valuation');
  SELF.populated_pcnt := CHOOSE(C,le.populated_history_date_pcnt,le.populated_fips_geo_12_pcnt,le.populated_median_valuation_pcnt,le.populated_history_history_date_pcnt,le.populated_history_median_valuation_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_history_date,le.maxlength_fips_geo_12,le.maxlength_median_valuation,le.maxlength_history_history_date,le.maxlength_history_median_valuation);
  SELF.avelength := CHOOSE(C,le.avelength_history_date,le.avelength_fips_geo_12,le.avelength_median_valuation,le.avelength_history_history_date,le.avelength_history_median_valuation);
END;
EXPORT invSummary := NORMALIZE(summary0, 5, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.history_date),TRIM((SALT38.StrType)le.fips_geo_12),IF (le.median_valuation <> 0,TRIM((SALT38.StrType)le.median_valuation), ''),TRIM((SALT38.StrType)le.history_history_date),IF (le.history_median_valuation <> 0,TRIM((SALT38.StrType)le.history_median_valuation), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,5,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 5);
  SELF.FldNo2 := 1 + (C % 5);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.history_date),TRIM((SALT38.StrType)le.fips_geo_12),IF (le.median_valuation <> 0,TRIM((SALT38.StrType)le.median_valuation), ''),TRIM((SALT38.StrType)le.history_history_date),IF (le.history_median_valuation <> 0,TRIM((SALT38.StrType)le.history_median_valuation), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.history_date),TRIM((SALT38.StrType)le.fips_geo_12),IF (le.median_valuation <> 0,TRIM((SALT38.StrType)le.median_valuation), ''),TRIM((SALT38.StrType)le.history_history_date),IF (le.history_median_valuation <> 0,TRIM((SALT38.StrType)le.history_median_valuation), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),5*5,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'history_date'}
      ,{2,'fips_geo_12'}
      ,{3,'median_valuation'}
      ,{4,'history_history_date'}
      ,{5,'history_median_valuation'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Medians_Fields.InValid_history_date((SALT38.StrType)le.history_date),
    Medians_Fields.InValid_fips_geo_12((SALT38.StrType)le.fips_geo_12),
    Medians_Fields.InValid_median_valuation((SALT38.StrType)le.median_valuation),
    Medians_Fields.InValid_history_history_date((SALT38.StrType)le.history_history_date),
    Medians_Fields.InValid_history_median_valuation((SALT38.StrType)le.history_median_valuation),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,5,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Medians_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Date','Invalid_Num','Invalid_Num','Invalid_Date','Invalid_Num');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Medians_Fields.InValidMessage_history_date(TotalErrors.ErrorNum),Medians_Fields.InValidMessage_fips_geo_12(TotalErrors.ErrorNum),Medians_Fields.InValidMessage_median_valuation(TotalErrors.ErrorNum),Medians_Fields.InValidMessage_history_history_date(TotalErrors.ErrorNum),Medians_Fields.InValidMessage_history_median_valuation(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_AVM, Medians_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
