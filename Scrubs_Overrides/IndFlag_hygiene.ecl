IMPORT SALT311,STD;
EXPORT IndFlag_hygiene(dataset(IndFlag_layout_Overrides) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt,BOOLEAN Glob=TRUE) := FUNCTION
  SummaryLayout := RECORD
    txt;
    Source := IF(Glob, (TYPEOF(h.Key_Ind))'', MAX(GROUP,h.Key_Ind));
    NumberOfRecords := COUNT(GROUP);
    populated_Key_Ind_cnt := COUNT(GROUP,h.Key_Ind <> (TYPEOF(h.Key_Ind))'');
    populated_Key_Ind_pcnt := AVE(GROUP,IF(h.Key_Ind = (TYPEOF(h.Key_Ind))'',0,100));
    maxlength_Key_Ind := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Key_Ind)));
    avelength_Key_Ind := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Key_Ind)),h.Key_Ind<>(typeof(h.Key_Ind))'');
    populated_flag_file_id_cnt := COUNT(GROUP,h.flag_file_id <> (TYPEOF(h.flag_file_id))'');
    populated_flag_file_id_pcnt := AVE(GROUP,IF(h.flag_file_id = (TYPEOF(h.flag_file_id))'',0,100));
    maxlength_flag_file_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.flag_file_id)));
    avelength_flag_file_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.flag_file_id)),h.flag_file_id<>(typeof(h.flag_file_id))'');
  END;
    T := IF(Glob,TABLE(h,SummaryLayout),TABLE(h,SummaryLayout,Key_Ind,FEW));
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_Key_Ind_pcnt *   0.00 / 100 + T.Populated_flag_file_id_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
EXPORT SourceCounts := Summary('SummaryBySource',FALSE);
  R := RECORD
    STRING Key_Ind1;
    STRING Key_Ind2;
    UNSIGNED LinkingPotential;
  END;
  R T(SourceCounts le, SourceCounts ri) := TRANSFORM
    SELF.Key_Ind1 := le.Source;
    SELF.Key_Ind2 := ri.Source;
    SELF.LinkingPotential := 0 + le.Populated_Key_Ind_pcnt*ri.Populated_Key_Ind_pcnt *   0.00 / 10000 + le.Populated_flag_file_id_pcnt*ri.Populated_flag_file_id_pcnt *   0.00 / 10000;
  END;
EXPORT CrossLinkingPotential := JOIN(SourceCounts,SourceCounts,LEFT.Source<>RIGHT.Source,T(LEFT,RIGHT),ALL);
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
  SELF.FieldName := CHOOSE(C,'Key_Ind','flag_file_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_Key_Ind_pcnt,le.populated_flag_file_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_Key_Ind,le.maxlength_flag_file_id);
  SELF.avelength := CHOOSE(C,le.avelength_Key_Ind,le.avelength_flag_file_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 2, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Src := le.Key_Ind;
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.Key_Ind),TRIM((SALT311.StrType)le.flag_file_id)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,2,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 2);
  SELF.FldNo2 := 1 + (C % 2);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.Key_Ind),TRIM((SALT311.StrType)le.flag_file_id)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.Key_Ind),TRIM((SALT311.StrType)le.flag_file_id)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),2*2,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'Key_Ind'}
      ,{2,'flag_file_id'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
  TYPEOF(h.Key_Ind) Key_Ind; // Track errors by source
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    IndFlag_Fields.InValid_Key_Ind((SALT311.StrType)le.Key_Ind),
    IndFlag_Fields.InValid_flag_file_id((SALT311.StrType)le.flag_file_id),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
  SELF.Key_Ind := le.Key_Ind;
END;
Errors := NORMALIZE(h,2,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
  Errors.Key_Ind;
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,Key_Ind,FEW);
PrettyErrorTotals := RECORD
  TotalErrors.Key_Ind;
  FieldNme := IndFlag_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Invalid_FlagID');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,IndFlag_Fields.InValidMessage_Key_Ind(TotalErrors.ErrorNum),IndFlag_Fields.InValidMessage_flag_file_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := JOIN(ValErr,TABLE(SourceCounts,{Source,NumberOfRecords}),LEFT.Key_Ind=RIGHT.Source,LOOKUP); // Add source group counts for STRATA compliance
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doSummaryPerSrc = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
  fieldPopulationPerSource := Summary('', FALSE);
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Overrides, IndFlag_Fields, 'RECORDOF(fieldPopulationOverall)', TRUE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationPerSource_Standard := IF(doSummaryPerSrc, NORMALIZE(fieldPopulationPerSource, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'src', 'src')));
 
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', TRUE, 'all'));
  fieldPopulationPerSource_TotalRecs_Standard := IF(doSummaryPerSrc, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationPerSource, myTimeStamp, 'src', TRUE, 'src'));
 
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & fieldPopulationPerSource_Standard & fieldPopulationPerSource_TotalRecs_Standard & allProfiles_Standard;
END;
END;
