IMPORT SALT37;
EXPORT NewGcIdExcl_hygiene(dataset(NewGcIdExcl_layout_NewGcIdExcl) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_fdn_file_gc_exclusion_id_pcnt := AVE(GROUP,IF(h.fdn_file_gc_exclusion_id = (TYPEOF(h.fdn_file_gc_exclusion_id))'',0,100));
    maxlength_fdn_file_gc_exclusion_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fdn_file_gc_exclusion_id)));
    avelength_fdn_file_gc_exclusion_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fdn_file_gc_exclusion_id)),h.fdn_file_gc_exclusion_id<>(typeof(h.fdn_file_gc_exclusion_id))'');
    populated_fdn_file_info_id_pcnt := AVE(GROUP,IF(h.fdn_file_info_id = (TYPEOF(h.fdn_file_info_id))'',0,100));
    maxlength_fdn_file_info_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.fdn_file_info_id)));
    avelength_fdn_file_info_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.fdn_file_info_id)),h.fdn_file_info_id<>(typeof(h.fdn_file_info_id))'');
    populated_exclusion_id_pcnt := AVE(GROUP,IF(h.exclusion_id = (TYPEOF(h.exclusion_id))'',0,100));
    maxlength_exclusion_id := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.exclusion_id)));
    avelength_exclusion_id := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.exclusion_id)),h.exclusion_id<>(typeof(h.exclusion_id))'');
    populated_exclusion_id_type_pcnt := AVE(GROUP,IF(h.exclusion_id_type = (TYPEOF(h.exclusion_id_type))'',0,100));
    maxlength_exclusion_id_type := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.exclusion_id_type)));
    avelength_exclusion_id_type := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.exclusion_id_type)),h.exclusion_id_type<>(typeof(h.exclusion_id_type))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_date_added_pcnt := AVE(GROUP,IF(h.date_added = (TYPEOF(h.date_added))'',0,100));
    maxlength_date_added := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_added)));
    avelength_date_added := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_added)),h.date_added<>(typeof(h.date_added))'');
    populated_user_added_pcnt := AVE(GROUP,IF(h.user_added = (TYPEOF(h.user_added))'',0,100));
    maxlength_user_added := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.user_added)));
    avelength_user_added := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.user_added)),h.user_added<>(typeof(h.user_added))'');
    populated_date_changed_pcnt := AVE(GROUP,IF(h.date_changed = (TYPEOF(h.date_changed))'',0,100));
    maxlength_date_changed := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_changed)));
    avelength_date_changed := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.date_changed)),h.date_changed<>(typeof(h.date_changed))'');
    populated_user_changed_pcnt := AVE(GROUP,IF(h.user_changed = (TYPEOF(h.user_changed))'',0,100));
    maxlength_user_changed := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.user_changed)));
    avelength_user_changed := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.user_changed)),h.user_changed<>(typeof(h.user_changed))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_fdn_file_gc_exclusion_id_pcnt *   0.00 / 100 + T.Populated_fdn_file_info_id_pcnt *   0.00 / 100 + T.Populated_exclusion_id_pcnt *   0.00 / 100 + T.Populated_exclusion_id_type_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_date_added_pcnt *   0.00 / 100 + T.Populated_user_added_pcnt *   0.00 / 100 + T.Populated_date_changed_pcnt *   0.00 / 100 + T.Populated_user_changed_pcnt *   0.00 / 100;
    T;
  END;
  RETURN TABLE(T,R1);
END;
 
summary0 := Summary('Summary');
invRec := RECORD
  UNSIGNED  FldNo;
  SALT37.StrType FieldName;
  UNSIGNED NumberOfRecords;
  REAL8  populated_pcnt;
  UNSIGNED  maxlength;
  REAL8  avelength;
END;
invRec invert(summary0 le, INTEGER C) := TRANSFORM
  SELF.FldNo := C;
  SELF.NumberOfRecords := le.NumberOfRecords;
  SELF.FieldName := CHOOSE(C,'fdn_file_gc_exclusion_id','fdn_file_info_id','exclusion_id','exclusion_id_type','status','date_added','user_added','date_changed','user_changed');
  SELF.populated_pcnt := CHOOSE(C,le.populated_fdn_file_gc_exclusion_id_pcnt,le.populated_fdn_file_info_id_pcnt,le.populated_exclusion_id_pcnt,le.populated_exclusion_id_type_pcnt,le.populated_status_pcnt,le.populated_date_added_pcnt,le.populated_user_added_pcnt,le.populated_date_changed_pcnt,le.populated_user_changed_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_fdn_file_gc_exclusion_id,le.maxlength_fdn_file_info_id,le.maxlength_exclusion_id,le.maxlength_exclusion_id_type,le.maxlength_status,le.maxlength_date_added,le.maxlength_user_added,le.maxlength_date_changed,le.maxlength_user_changed);
  SELF.avelength := CHOOSE(C,le.avelength_fdn_file_gc_exclusion_id,le.avelength_fdn_file_info_id,le.avelength_exclusion_id,le.avelength_exclusion_id_type,le.avelength_status,le.avelength_date_added,le.avelength_user_added,le.avelength_date_changed,le.avelength_user_changed);
END;
EXPORT invSummary := NORMALIZE(summary0, 9, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.fdn_file_gc_exclusion_id <> 0,TRIM((SALT37.StrType)le.fdn_file_gc_exclusion_id), ''),IF (le.fdn_file_info_id <> 0,TRIM((SALT37.StrType)le.fdn_file_info_id), ''),IF (le.exclusion_id <> 0,TRIM((SALT37.StrType)le.exclusion_id), ''),TRIM((SALT37.StrType)le.exclusion_id_type),IF (le.status <> 0,TRIM((SALT37.StrType)le.status), ''),TRIM((SALT37.StrType)le.date_added),TRIM((SALT37.StrType)le.user_added),TRIM((SALT37.StrType)le.date_changed),TRIM((SALT37.StrType)le.user_changed)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,9,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 9);
  SELF.FldNo2 := 1 + (C % 9);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.fdn_file_gc_exclusion_id <> 0,TRIM((SALT37.StrType)le.fdn_file_gc_exclusion_id), ''),IF (le.fdn_file_info_id <> 0,TRIM((SALT37.StrType)le.fdn_file_info_id), ''),IF (le.exclusion_id <> 0,TRIM((SALT37.StrType)le.exclusion_id), ''),TRIM((SALT37.StrType)le.exclusion_id_type),IF (le.status <> 0,TRIM((SALT37.StrType)le.status), ''),TRIM((SALT37.StrType)le.date_added),TRIM((SALT37.StrType)le.user_added),TRIM((SALT37.StrType)le.date_changed),TRIM((SALT37.StrType)le.user_changed)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.fdn_file_gc_exclusion_id <> 0,TRIM((SALT37.StrType)le.fdn_file_gc_exclusion_id), ''),IF (le.fdn_file_info_id <> 0,TRIM((SALT37.StrType)le.fdn_file_info_id), ''),IF (le.exclusion_id <> 0,TRIM((SALT37.StrType)le.exclusion_id), ''),TRIM((SALT37.StrType)le.exclusion_id_type),IF (le.status <> 0,TRIM((SALT37.StrType)le.status), ''),TRIM((SALT37.StrType)le.date_added),TRIM((SALT37.StrType)le.user_added),TRIM((SALT37.StrType)le.date_changed),TRIM((SALT37.StrType)le.user_changed)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),9*9,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'fdn_file_gc_exclusion_id'}
      ,{2,'fdn_file_info_id'}
      ,{3,'exclusion_id'}
      ,{4,'exclusion_id_type'}
      ,{5,'status'}
      ,{6,'date_added'}
      ,{7,'user_added'}
      ,{8,'date_changed'}
      ,{9,'user_changed'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    NewGcIdExcl_Fields.InValid_fdn_file_gc_exclusion_id((SALT37.StrType)le.fdn_file_gc_exclusion_id),
    NewGcIdExcl_Fields.InValid_fdn_file_info_id((SALT37.StrType)le.fdn_file_info_id),
    NewGcIdExcl_Fields.InValid_exclusion_id((SALT37.StrType)le.exclusion_id),
    NewGcIdExcl_Fields.InValid_exclusion_id_type((SALT37.StrType)le.exclusion_id_type),
    NewGcIdExcl_Fields.InValid_status((SALT37.StrType)le.status),
    NewGcIdExcl_Fields.InValid_date_added((SALT37.StrType)le.date_added),
    NewGcIdExcl_Fields.InValid_user_added((SALT37.StrType)le.user_added),
    NewGcIdExcl_Fields.InValid_date_changed((SALT37.StrType)le.date_changed),
    NewGcIdExcl_Fields.InValid_user_changed((SALT37.StrType)le.user_changed),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,9,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := NewGcIdExcl_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_numeric','invalid_alphanumeric','invalid_numeric','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,NewGcIdExcl_Fields.InValidMessage_fdn_file_gc_exclusion_id(TotalErrors.ErrorNum),NewGcIdExcl_Fields.InValidMessage_fdn_file_info_id(TotalErrors.ErrorNum),NewGcIdExcl_Fields.InValidMessage_exclusion_id(TotalErrors.ErrorNum),NewGcIdExcl_Fields.InValidMessage_exclusion_id_type(TotalErrors.ErrorNum),NewGcIdExcl_Fields.InValidMessage_status(TotalErrors.ErrorNum),NewGcIdExcl_Fields.InValidMessage_date_added(TotalErrors.ErrorNum),NewGcIdExcl_Fields.InValidMessage_user_added(TotalErrors.ErrorNum),NewGcIdExcl_Fields.InValidMessage_date_changed(TotalErrors.ErrorNum),NewGcIdExcl_Fields.InValidMessage_user_changed(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
