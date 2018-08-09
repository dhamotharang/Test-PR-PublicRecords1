IMPORT SALT39,STD;
EXPORT MasterIdIndTypeIncl_hygiene(dataset(MasterIdIndTypeIncl_layout_MasterIdIndTypeIncl) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT39.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fdn_ind_type_gc_id_inclusion_cnt := COUNT(GROUP,h.fdn_ind_type_gc_id_inclusion <> (TYPEOF(h.fdn_ind_type_gc_id_inclusion))'');
    populated_fdn_ind_type_gc_id_inclusion_pcnt := AVE(GROUP,IF(h.fdn_ind_type_gc_id_inclusion = (TYPEOF(h.fdn_ind_type_gc_id_inclusion))'',0,100));
    maxlength_fdn_ind_type_gc_id_inclusion := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fdn_ind_type_gc_id_inclusion)));
    avelength_fdn_ind_type_gc_id_inclusion := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fdn_ind_type_gc_id_inclusion)),h.fdn_ind_type_gc_id_inclusion<>(typeof(h.fdn_ind_type_gc_id_inclusion))'');
    populated_fdn_file_info_id_cnt := COUNT(GROUP,h.fdn_file_info_id <> (TYPEOF(h.fdn_file_info_id))'');
    populated_fdn_file_info_id_pcnt := AVE(GROUP,IF(h.fdn_file_info_id = (TYPEOF(h.fdn_file_info_id))'',0,100));
    maxlength_fdn_file_info_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.fdn_file_info_id)));
    avelength_fdn_file_info_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.fdn_file_info_id)),h.fdn_file_info_id<>(typeof(h.fdn_file_info_id))'');
    populated_ind_type_cnt := COUNT(GROUP,h.ind_type <> (TYPEOF(h.ind_type))'');
    populated_ind_type_pcnt := AVE(GROUP,IF(h.ind_type = (TYPEOF(h.ind_type))'',0,100));
    maxlength_ind_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.ind_type)));
    avelength_ind_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.ind_type)),h.ind_type<>(typeof(h.ind_type))'');
    populated_inclusion_id_cnt := COUNT(GROUP,h.inclusion_id <> (TYPEOF(h.inclusion_id))'');
    populated_inclusion_id_pcnt := AVE(GROUP,IF(h.inclusion_id = (TYPEOF(h.inclusion_id))'',0,100));
    maxlength_inclusion_id := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.inclusion_id)));
    avelength_inclusion_id := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.inclusion_id)),h.inclusion_id<>(typeof(h.inclusion_id))'');
    populated_inclusion_type_cnt := COUNT(GROUP,h.inclusion_type <> (TYPEOF(h.inclusion_type))'');
    populated_inclusion_type_pcnt := AVE(GROUP,IF(h.inclusion_type = (TYPEOF(h.inclusion_type))'',0,100));
    maxlength_inclusion_type := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.inclusion_type)));
    avelength_inclusion_type := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.inclusion_type)),h.inclusion_type<>(typeof(h.inclusion_type))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_date_added_cnt := COUNT(GROUP,h.date_added <> (TYPEOF(h.date_added))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_user_added_cnt := COUNT(GROUP,h.user_added <> (TYPEOF(h.user_added))'');
    populated_user_added_pcnt := AVE(GROUP,IF(h.user_added = (TYPEOF(h.user_added))'',0,100));
    maxlength_user_added := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_added)));
    avelength_user_added := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_added)),h.user_added<>(typeof(h.user_added))'');
    populated_date_changed_cnt := COUNT(GROUP,h.date_changed <> (TYPEOF(h.date_changed))'');
    populated_date_changed_pcnt := AVE(GROUP,IF(h.date_changed = (TYPEOF(h.date_changed))'',0,100));
    maxlength_date_changed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_changed)));
    avelength_date_changed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.date_changed)),h.date_changed<>(typeof(h.date_changed))'');
    populated_user_changed_cnt := COUNT(GROUP,h.user_changed <> (TYPEOF(h.user_changed))'');
    populated_user_changed_pcnt := AVE(GROUP,IF(h.user_changed = (TYPEOF(h.user_changed))'',0,100));
    maxlength_user_changed := MAX(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_changed)));
    avelength_user_changed := AVE(GROUP,LENGTH(TRIM((SALT39.StrType)h.user_changed)),h.user_changed<>(typeof(h.user_changed))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_fdn_ind_type_gc_id_inclusion_pcnt *   0.00 / 100 + T.Populated_fdn_file_info_id_pcnt *   0.00 / 100 + T.Populated_ind_type_pcnt *   0.00 / 100 + T.Populated_inclusion_id_pcnt *   0.00 / 100 + T.Populated_inclusion_type_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_user_added_pcnt *   0.00 / 100 + T.Populated_date_changed_pcnt *   0.00 / 100 + T.Populated_user_changed_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
  invRec := RECORD
  UNSIGNED  FldNo;
  SALT39.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'fdn_ind_type_gc_id_inclusion','fdn_file_info_id','ind_type','inclusion_id','inclusion_type','status','date_added','user_added','date_changed','user_changed');
  SELF.populated_pcnt := CHOOSE(C,le.populated_fdn_ind_type_gc_id_inclusion_pcnt,le.populated_fdn_file_info_id_pcnt,le.populated_ind_type_pcnt,le.populated_inclusion_id_pcnt,le.populated_inclusion_type_pcnt,le.populated_status_pcnt,le.populated_date_added_pcnt,le.populated_user_added_pcnt,le.populated_date_changed_pcnt,le.populated_user_changed_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_fdn_ind_type_gc_id_inclusion,le.maxlength_fdn_file_info_id,le.maxlength_ind_type,le.maxlength_inclusion_id,le.maxlength_inclusion_type,le.maxlength_status,le.maxlength_date_added,le.maxlength_user_added,le.maxlength_date_changed,le.maxlength_user_changed);
  SELF.avelength := CHOOSE(C,le.avelength_fdn_ind_type_gc_id_inclusion,le.avelength_fdn_file_info_id,le.avelength_ind_type,le.avelength_inclusion_id,le.avelength_inclusion_type,le.avelength_status,le.avelength_date_added,le.avelength_user_added,le.avelength_date_changed,le.avelength_user_changed);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT39.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.fdn_ind_type_gc_id_inclusion <> 0,TRIM((SALT39.StrType)le.fdn_ind_type_gc_id_inclusion), ''),IF (le.fdn_file_info_id <> 0,TRIM((SALT39.StrType)le.fdn_file_info_id), ''),IF (le.ind_type <> 0,TRIM((SALT39.StrType)le.ind_type), ''),IF (le.inclusion_id <> 0,TRIM((SALT39.StrType)le.inclusion_id), ''),TRIM((SALT39.StrType)le.inclusion_type),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT39.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.fdn_ind_type_gc_id_inclusion <> 0,TRIM((SALT39.StrType)le.fdn_ind_type_gc_id_inclusion), ''),IF (le.fdn_file_info_id <> 0,TRIM((SALT39.StrType)le.fdn_file_info_id), ''),IF (le.ind_type <> 0,TRIM((SALT39.StrType)le.ind_type), ''),IF (le.inclusion_id <> 0,TRIM((SALT39.StrType)le.inclusion_id), ''),TRIM((SALT39.StrType)le.inclusion_type),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.fdn_ind_type_gc_id_inclusion <> 0,TRIM((SALT39.StrType)le.fdn_ind_type_gc_id_inclusion), ''),IF (le.fdn_file_info_id <> 0,TRIM((SALT39.StrType)le.fdn_file_info_id), ''),IF (le.ind_type <> 0,TRIM((SALT39.StrType)le.ind_type), ''),IF (le.inclusion_id <> 0,TRIM((SALT39.StrType)le.inclusion_id), ''),TRIM((SALT39.StrType)le.inclusion_type),IF (le.status <> 0,TRIM((SALT39.StrType)le.status), ''),TRIM((SALT39.StrType)le.date_added),TRIM((SALT39.StrType)le.user_added),TRIM((SALT39.StrType)le.date_changed),TRIM((SALT39.StrType)le.user_changed)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'fdn_ind_type_gc_id_inclusion'}
      ,{2,'fdn_file_info_id'}
      ,{3,'ind_type'}
      ,{4,'inclusion_id'}
      ,{5,'inclusion_type'}
      ,{6,'status'}
      ,{7,'date_added'}
      ,{8,'user_added'}
      ,{9,'date_changed'}
      ,{10,'user_changed'}],SALT39.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT39.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT39.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT39.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    MasterIdIndTypeIncl_Fields.InValid_fdn_ind_type_gc_id_inclusion((SALT39.StrType)le.fdn_ind_type_gc_id_inclusion),
    MasterIdIndTypeIncl_Fields.InValid_fdn_file_info_id((SALT39.StrType)le.fdn_file_info_id),
    MasterIdIndTypeIncl_Fields.InValid_ind_type((SALT39.StrType)le.ind_type),
    MasterIdIndTypeIncl_Fields.InValid_inclusion_id((SALT39.StrType)le.inclusion_id),
    MasterIdIndTypeIncl_Fields.InValid_inclusion_type((SALT39.StrType)le.inclusion_type),
    MasterIdIndTypeIncl_Fields.InValid_status((SALT39.StrType)le.status),
    MasterIdIndTypeIncl_Fields.InValid_date_added((SALT39.StrType)le.date_added),
    MasterIdIndTypeIncl_Fields.InValid_user_added((SALT39.StrType)le.user_added),
    MasterIdIndTypeIncl_Fields.InValid_date_changed((SALT39.StrType)le.date_changed),
    MasterIdIndTypeIncl_Fields.InValid_user_changed((SALT39.StrType)le.user_changed),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,10,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := MasterIdIndTypeIncl_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,MasterIdIndTypeIncl_Fields.InValidMessage_fdn_ind_type_gc_id_inclusion(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_fdn_file_info_id(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_ind_type(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_inclusion_id(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_inclusion_type(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_status(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_user_added(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_date_changed(TotalErrors.ErrorNum),MasterIdIndTypeIncl_Fields.InValidMessage_user_changed(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT39.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT39.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_MBS, MasterIdIndTypeIncl_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT39.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT39.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
