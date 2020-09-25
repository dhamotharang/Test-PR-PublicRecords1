IMPORT SALT311,STD;
EXPORT RelatedActivity_Raw_hygiene(dataset(RelatedActivity_Raw_Layout) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_activity_nr_cnt := COUNT(GROUP,h.activity_nr <> (TYPEOF(h.activity_nr))'');
    populated_activity_nr_pcnt := AVE(GROUP,IF(h.activity_nr = (TYPEOF(h.activity_nr))'',0,100));
    maxlength_activity_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)));
    avelength_activity_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)),h.activity_nr<>(typeof(h.activity_nr))'');
    populated_rel_act_nr_cnt := COUNT(GROUP,h.rel_act_nr <> (TYPEOF(h.rel_act_nr))'');
    populated_rel_act_nr_pcnt := AVE(GROUP,IF(h.rel_act_nr = (TYPEOF(h.rel_act_nr))'',0,100));
    maxlength_rel_act_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rel_act_nr)));
    avelength_rel_act_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rel_act_nr)),h.rel_act_nr<>(typeof(h.rel_act_nr))'');
    populated_rel_safety_cnt := COUNT(GROUP,h.rel_safety <> (TYPEOF(h.rel_safety))'');
    populated_rel_safety_pcnt := AVE(GROUP,IF(h.rel_safety = (TYPEOF(h.rel_safety))'',0,100));
    maxlength_rel_safety := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rel_safety)));
    avelength_rel_safety := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rel_safety)),h.rel_safety<>(typeof(h.rel_safety))'');
    populated_rel_health_cnt := COUNT(GROUP,h.rel_health <> (TYPEOF(h.rel_health))'');
    populated_rel_health_pcnt := AVE(GROUP,IF(h.rel_health = (TYPEOF(h.rel_health))'',0,100));
    maxlength_rel_health := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.rel_health)));
    avelength_rel_health := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.rel_health)),h.rel_health<>(typeof(h.rel_health))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_activity_nr_pcnt *   0.00 / 100 + T.Populated_rel_act_nr_pcnt *   0.00 / 100 + T.Populated_rel_safety_pcnt *   0.00 / 100 + T.Populated_rel_health_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'activity_nr','rel_act_nr','rel_safety','rel_health');
  SELF.populated_pcnt := CHOOSE(C,le.populated_activity_nr_pcnt,le.populated_rel_act_nr_pcnt,le.populated_rel_safety_pcnt,le.populated_rel_health_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_activity_nr,le.maxlength_rel_act_nr,le.maxlength_rel_safety,le.maxlength_rel_health);
  SELF.avelength := CHOOSE(C,le.avelength_activity_nr,le.avelength_rel_act_nr,le.avelength_rel_safety,le.avelength_rel_health);
END;
EXPORT invSummary := NORMALIZE(summary0, 4, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.rel_act_nr),TRIM((SALT311.StrType)le.rel_safety),TRIM((SALT311.StrType)le.rel_health)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,4,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 4);
  SELF.FldNo2 := 1 + (C % 4);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.rel_act_nr),TRIM((SALT311.StrType)le.rel_safety),TRIM((SALT311.StrType)le.rel_health)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.rel_act_nr),TRIM((SALT311.StrType)le.rel_safety),TRIM((SALT311.StrType)le.rel_health)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),4*4,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'activity_nr'}
      ,{2,'rel_act_nr'}
      ,{3,'rel_safety'}
      ,{4,'rel_health'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    RelatedActivity_Raw_Fields.InValid_activity_nr((SALT311.StrType)le.activity_nr),
    RelatedActivity_Raw_Fields.InValid_rel_act_nr((SALT311.StrType)le.rel_act_nr),
    RelatedActivity_Raw_Fields.InValid_rel_safety((SALT311.StrType)le.rel_safety),
    RelatedActivity_Raw_Fields.InValid_rel_health((SALT311.StrType)le.rel_health),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,4,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := RelatedActivity_Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','Invalid_X','Invalid_X');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,RelatedActivity_Raw_Fields.InValidMessage_activity_nr(TotalErrors.ErrorNum),RelatedActivity_Raw_Fields.InValidMessage_rel_act_nr(TotalErrors.ErrorNum),RelatedActivity_Raw_Fields.InValidMessage_rel_safety(TotalErrors.ErrorNum),RelatedActivity_Raw_Fields.InValidMessage_rel_health(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, RelatedActivity_Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
