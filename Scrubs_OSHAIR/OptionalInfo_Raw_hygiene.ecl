﻿IMPORT SALT311,STD;
EXPORT OptionalInfo_Raw_hygiene(dataset(OptionalInfo_Raw_Layout) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_activity_nr_cnt := COUNT(GROUP,h.activity_nr <> (TYPEOF(h.activity_nr))'');
    populated_activity_nr_pcnt := AVE(GROUP,IF(h.activity_nr = (TYPEOF(h.activity_nr))'',0,100));
    maxlength_activity_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)));
    avelength_activity_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.activity_nr)),h.activity_nr<>(typeof(h.activity_nr))'');
    populated_opt_type_cnt := COUNT(GROUP,h.opt_type <> (TYPEOF(h.opt_type))'');
    populated_opt_type_pcnt := AVE(GROUP,IF(h.opt_type = (TYPEOF(h.opt_type))'',0,100));
    maxlength_opt_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.opt_type)));
    avelength_opt_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.opt_type)),h.opt_type<>(typeof(h.opt_type))'');
    populated_opt_id_cnt := COUNT(GROUP,h.opt_id <> (TYPEOF(h.opt_id))'');
    populated_opt_id_pcnt := AVE(GROUP,IF(h.opt_id = (TYPEOF(h.opt_id))'',0,100));
    maxlength_opt_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.opt_id)));
    avelength_opt_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.opt_id)),h.opt_id<>(typeof(h.opt_id))'');
    populated_opt_info_id_cnt := COUNT(GROUP,h.opt_info_id <> (TYPEOF(h.opt_info_id))'');
    populated_opt_info_id_pcnt := AVE(GROUP,IF(h.opt_info_id = (TYPEOF(h.opt_info_id))'',0,100));
    maxlength_opt_info_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.opt_info_id)));
    avelength_opt_info_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.opt_info_id)),h.opt_info_id<>(typeof(h.opt_info_id))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_activity_nr_pcnt *   0.00 / 100 + T.Populated_opt_type_pcnt *   0.00 / 100 + T.Populated_opt_id_pcnt *   0.00 / 100 + T.Populated_opt_info_id_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'activity_nr','opt_type','opt_id','opt_info_id');
  SELF.populated_pcnt := CHOOSE(C,le.populated_activity_nr_pcnt,le.populated_opt_type_pcnt,le.populated_opt_id_pcnt,le.populated_opt_info_id_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_activity_nr,le.maxlength_opt_type,le.maxlength_opt_id,le.maxlength_opt_info_id);
  SELF.avelength := CHOOSE(C,le.avelength_activity_nr,le.avelength_opt_type,le.avelength_opt_id,le.avelength_opt_info_id);
END;
EXPORT invSummary := NORMALIZE(summary0, 4, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.opt_type),TRIM((SALT311.StrType)le.opt_id),TRIM((SALT311.StrType)le.opt_info_id)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,4,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 4);
  SELF.FldNo2 := 1 + (C % 4);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.opt_type),TRIM((SALT311.StrType)le.opt_id),TRIM((SALT311.StrType)le.opt_info_id)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.activity_nr),TRIM((SALT311.StrType)le.opt_type),TRIM((SALT311.StrType)le.opt_id),TRIM((SALT311.StrType)le.opt_info_id)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),4*4,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'activity_nr'}
      ,{2,'opt_type'}
      ,{3,'opt_id'}
      ,{4,'opt_info_id'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    OptionalInfo_Raw_Fields.InValid_activity_nr((SALT311.StrType)le.activity_nr),
    OptionalInfo_Raw_Fields.InValid_opt_type((SALT311.StrType)le.opt_type),
    OptionalInfo_Raw_Fields.InValid_opt_id((SALT311.StrType)le.opt_id),
    OptionalInfo_Raw_Fields.InValid_opt_info_id((SALT311.StrType)le.opt_info_id),
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
  FieldNme := OptionalInfo_Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','Invalid_opt_type','invalid_numeric','Invalid_opt_info_id');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,OptionalInfo_Raw_Fields.InValidMessage_activity_nr(TotalErrors.ErrorNum),OptionalInfo_Raw_Fields.InValidMessage_opt_type(TotalErrors.ErrorNum),OptionalInfo_Raw_Fields.InValidMessage_opt_id(TotalErrors.ErrorNum),OptionalInfo_Raw_Fields.InValidMessage_opt_info_id(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, OptionalInfo_Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
