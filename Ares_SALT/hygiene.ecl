IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_area) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_deleted_cnt := COUNT(GROUP,h.deleted <> (TYPEOF(h.deleted))'');
    populated_deleted_pcnt := AVE(GROUP,IF(h.deleted = (TYPEOF(h.deleted))'',0,100));
    maxlength_deleted := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.deleted)));
    avelength_deleted := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.deleted)),h.deleted<>(typeof(h.deleted))'');
    populated_fid_cnt := COUNT(GROUP,h.fid <> (TYPEOF(h.fid))'');
    populated_fid_pcnt := AVE(GROUP,IF(h.fid = (TYPEOF(h.fid))'',0,100));
    maxlength_fid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fid)));
    avelength_fid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fid)),h.fid<>(typeof(h.fid))'');
    populated_id_cnt := COUNT(GROUP,h.id <> (TYPEOF(h.id))'');
    populated_id_pcnt := AVE(GROUP,IF(h.id = (TYPEOF(h.id))'',0,100));
    maxlength_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.id)));
    avelength_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.id)),h.id<>(typeof(h.id))'');
    populated_resource_cnt := COUNT(GROUP,h.resource <> (TYPEOF(h.resource))'');
    populated_resource_pcnt := AVE(GROUP,IF(h.resource = (TYPEOF(h.resource))'',0,100));
    maxlength_resource := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.resource)));
    avelength_resource := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.resource)),h.resource<>(typeof(h.resource))'');
    populated_source_cnt := COUNT(GROUP,h.source <> (TYPEOF(h.source))'');
    populated_source_pcnt := AVE(GROUP,IF(h.source = (TYPEOF(h.source))'',0,100));
    maxlength_source := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)));
    avelength_source := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.source)),h.source<>(typeof(h.source))'');
    populated_summary_type_cnt := COUNT(GROUP,h.summary.type <> (TYPEOF(h.summary.type))'');
    populated_summary_type_pcnt := AVE(GROUP,IF(h.summary.type = (TYPEOF(h.summary.type))'',0,100));
    maxlength_summary_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.summary.type)));
    avelength_summary_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.summary.type)),h.summary.type<>(typeof(h.summary.type))'');
    populated_type_cnt := COUNT(GROUP,h.type <> (TYPEOF(h.type))'');
    populated_type_pcnt := AVE(GROUP,IF(h.type = (TYPEOF(h.type))'',0,100));
    maxlength_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.type)));
    avelength_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.type)),h.type<>(typeof(h.type))'');
    populated_value_cnt := COUNT(GROUP,h.value <> (TYPEOF(h.value))'');
    populated_value_pcnt := AVE(GROUP,IF(h.value = (TYPEOF(h.value))'',0,100));
    maxlength_value := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.value)));
    avelength_value := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.value)),h.value<>(typeof(h.value))'');
    populated_status_cnt := COUNT(GROUP,h.status <> (TYPEOF(h.status))'');
    populated_status_pcnt := AVE(GROUP,IF(h.status = (TYPEOF(h.status))'',0,100));
    maxlength_status := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)));
    avelength_status := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.status)),h.status<>(typeof(h.status))'');
    populated_useinaddress_cnt := COUNT(GROUP,h.useinaddress <> (TYPEOF(h.useinaddress))'');
    populated_useinaddress_pcnt := AVE(GROUP,IF(h.useinaddress = (TYPEOF(h.useinaddress))'',0,100));
    maxlength_useinaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.useinaddress)));
    avelength_useinaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.useinaddress)),h.useinaddress<>(typeof(h.useinaddress))'');
    populated_link_href_cnt := COUNT(GROUP,h.link_href <> (TYPEOF(h.link_href))'');
    populated_link_href_pcnt := AVE(GROUP,IF(h.link_href = (TYPEOF(h.link_href))'',0,100));
    maxlength_link_href := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.link_href)));
    avelength_link_href := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.link_href)),h.link_href<>(typeof(h.link_href))'');
    populated_link_rel_cnt := COUNT(GROUP,h.link_rel <> (TYPEOF(h.link_rel))'');
    populated_link_rel_pcnt := AVE(GROUP,IF(h.link_rel = (TYPEOF(h.link_rel))'',0,100));
    maxlength_link_rel := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.link_rel)));
    avelength_link_rel := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.link_rel)),h.link_rel<>(typeof(h.link_rel))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_deleted_pcnt *   0.00 / 100 + T.Populated_fid_pcnt *   0.00 / 100 + T.Populated_id_pcnt *   0.00 / 100 + T.Populated_resource_pcnt *   0.00 / 100 + T.Populated_source_pcnt *   0.00 / 100 + T.Populated_summary_type_pcnt *   0.00 / 100 + T.Populated_type_pcnt *   0.00 / 100 + T.Populated_value_pcnt *   0.00 / 100 + T.Populated_status_pcnt *   0.00 / 100 + T.Populated_useinaddress_pcnt *   0.00 / 100 + T.Populated_link_href_pcnt *   0.00 / 100 + T.Populated_link_rel_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'deleted','fid','id','resource','source','summary.type','type','value','status','useinaddress','link_href','link_rel');
  SELF.populated_pcnt := CHOOSE(C,le.populated_deleted_pcnt,le.populated_fid_pcnt,le.populated_id_pcnt,le.populated_resource_pcnt,le.populated_source_pcnt,le.populated_summary_type_pcnt,le.populated_type_pcnt,le.populated_value_pcnt,le.populated_status_pcnt,le.populated_useinaddress_pcnt,le.populated_link_href_pcnt,le.populated_link_rel_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_deleted,le.maxlength_fid,le.maxlength_id,le.maxlength_resource,le.maxlength_source,le.maxlength_summary_type,le.maxlength_type,le.maxlength_value,le.maxlength_status,le.maxlength_useinaddress,le.maxlength_link_href,le.maxlength_link_rel);
  SELF.avelength := CHOOSE(C,le.avelength_deleted,le.avelength_fid,le.avelength_id,le.avelength_resource,le.avelength_source,le.avelength_summary_type,le.avelength_type,le.avelength_value,le.avelength_status,le.avelength_useinaddress,le.avelength_link_href,le.avelength_link_rel);
END;
EXPORT invSummary := NORMALIZE(summary0, 12, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.deleted),TRIM((SALT311.StrType)le.fid),TRIM((SALT311.StrType)le.id),TRIM((SALT311.StrType)le.resource),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.summary.type),TRIM((SALT311.StrType)le.type),TRIM((SALT311.StrType)le.value),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.useinaddress),TRIM((SALT311.StrType)le.link_href),TRIM((SALT311.StrType)le.link_rel)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,12,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 12);
  SELF.FldNo2 := 1 + (C % 12);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.deleted),TRIM((SALT311.StrType)le.fid),TRIM((SALT311.StrType)le.id),TRIM((SALT311.StrType)le.resource),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.summary.type),TRIM((SALT311.StrType)le.type),TRIM((SALT311.StrType)le.value),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.useinaddress),TRIM((SALT311.StrType)le.link_href),TRIM((SALT311.StrType)le.link_rel)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.deleted),TRIM((SALT311.StrType)le.fid),TRIM((SALT311.StrType)le.id),TRIM((SALT311.StrType)le.resource),TRIM((SALT311.StrType)le.source),TRIM((SALT311.StrType)le.summary.type),TRIM((SALT311.StrType)le.type),TRIM((SALT311.StrType)le.value),TRIM((SALT311.StrType)le.status),TRIM((SALT311.StrType)le.useinaddress),TRIM((SALT311.StrType)le.link_href),TRIM((SALT311.StrType)le.link_rel)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),12*12,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'deleted'}
      ,{2,'fid'}
      ,{3,'id'}
      ,{4,'resource'}
      ,{5,'source'}
      ,{6,'summary.type'}
      ,{7,'type'}
      ,{8,'value'}
      ,{9,'status'}
      ,{10,'useinaddress'}
      ,{11,'link_href'}
      ,{12,'link_rel'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_deleted((SALT311.StrType)le.deleted),
    Fields.InValid_fid((SALT311.StrType)le.fid),
    Fields.InValid_id((SALT311.StrType)le.id),
    Fields.InValid_resource((SALT311.StrType)le.resource),
    Fields.InValid_source((SALT311.StrType)le.source),
    Fields.InValid_summary_type((SALT311.StrType)le.summary.type),
    Fields.InValid_type((SALT311.StrType)le.type),
    Fields.InValid_value((SALT311.StrType)le.value),
    Fields.InValid_status((SALT311.StrType)le.status),
    Fields.InValid_useinaddress((SALT311.StrType)le.useinaddress),
    Fields.InValid_link_href((SALT311.StrType)le.link_href),
    Fields.InValid_link_rel((SALT311.StrType)le.link_rel),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,12,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_deleted(TotalErrors.ErrorNum),Fields.InValidMessage_fid(TotalErrors.ErrorNum),Fields.InValidMessage_id(TotalErrors.ErrorNum),Fields.InValidMessage_resource(TotalErrors.ErrorNum),Fields.InValidMessage_source(TotalErrors.ErrorNum),Fields.InValidMessage_summary_type(TotalErrors.ErrorNum),Fields.InValidMessage_type(TotalErrors.ErrorNum),Fields.InValidMessage_value(TotalErrors.ErrorNum),Fields.InValidMessage_status(TotalErrors.ErrorNum),Fields.InValidMessage_useinaddress(TotalErrors.ErrorNum),Fields.InValidMessage_link_href(TotalErrors.ErrorNum),Fields.InValidMessage_link_rel(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Ares_SALT, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
