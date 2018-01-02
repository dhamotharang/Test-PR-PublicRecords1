IMPORT SALT38,STD;
EXPORT KeyGrowth_hygiene(dataset(KeyGrowth_layout_Risk_Indicators) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dataset_name_cnt := COUNT(GROUP,h.dataset_name <> (TYPEOF(h.dataset_name))'');
    populated_dataset_name_pcnt := AVE(GROUP,IF(h.dataset_name = (TYPEOF(h.dataset_name))'',0,100));
    maxlength_dataset_name := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dataset_name)));
    avelength_dataset_name := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dataset_name)),h.dataset_name<>(typeof(h.dataset_name))'');
    populated_file_type_cnt := COUNT(GROUP,h.file_type <> (TYPEOF(h.file_type))'');
    populated_file_type_pcnt := AVE(GROUP,IF(h.file_type = (TYPEOF(h.file_type))'',0,100));
    maxlength_file_type := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.file_type)));
    avelength_file_type := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.file_type)),h.file_type<>(typeof(h.file_type))'');
    populated_version_cnt := COUNT(GROUP,h.version <> (TYPEOF(h.version))'');
    populated_version_pcnt := AVE(GROUP,IF(h.version = (TYPEOF(h.version))'',0,100));
    maxlength_version := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.version)));
    avelength_version := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.version)),h.version<>(typeof(h.version))'');
    populated_wu_cnt := COUNT(GROUP,h.wu <> (TYPEOF(h.wu))'');
    populated_wu_pcnt := AVE(GROUP,IF(h.wu = (TYPEOF(h.wu))'',0,100));
    maxlength_wu := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.wu)));
    avelength_wu := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.wu)),h.wu<>(typeof(h.wu))'');
    populated_count_oldfile_cnt := COUNT(GROUP,h.count_oldfile <> (TYPEOF(h.count_oldfile))'');
    populated_count_oldfile_pcnt := AVE(GROUP,IF(h.count_oldfile = (TYPEOF(h.count_oldfile))'',0,100));
    maxlength_count_oldfile := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.count_oldfile)));
    avelength_count_oldfile := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.count_oldfile)),h.count_oldfile<>(typeof(h.count_oldfile))'');
    populated_count_newfile_cnt := COUNT(GROUP,h.count_newfile <> (TYPEOF(h.count_newfile))'');
    populated_count_newfile_pcnt := AVE(GROUP,IF(h.count_newfile = (TYPEOF(h.count_newfile))'',0,100));
    maxlength_count_newfile := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.count_newfile)));
    avelength_count_newfile := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.count_newfile)),h.count_newfile<>(typeof(h.count_newfile))'');
    populated_count_deduped_combined_cnt := COUNT(GROUP,h.count_deduped_combined <> (TYPEOF(h.count_deduped_combined))'');
    populated_count_deduped_combined_pcnt := AVE(GROUP,IF(h.count_deduped_combined = (TYPEOF(h.count_deduped_combined))'',0,100));
    maxlength_count_deduped_combined := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.count_deduped_combined)));
    avelength_count_deduped_combined := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.count_deduped_combined)),h.count_deduped_combined<>(typeof(h.count_deduped_combined))'');
    populated_percent_change_cnt := COUNT(GROUP,h.percent_change <> (TYPEOF(h.percent_change))'');
    populated_percent_change_pcnt := AVE(GROUP,IF(h.percent_change = (TYPEOF(h.percent_change))'',0,100));
    maxlength_percent_change := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.percent_change)));
    avelength_percent_change := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.percent_change)),h.percent_change<>(typeof(h.percent_change))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dataset_name_pcnt *   0.00 / 100 + T.Populated_file_type_pcnt *   0.00 / 100 + T.Populated_version_pcnt *   0.00 / 100 + T.Populated_wu_pcnt *   0.00 / 100 + T.Populated_count_oldfile_pcnt *   0.00 / 100 + T.Populated_count_newfile_pcnt *   0.00 / 100 + T.Populated_count_deduped_combined_pcnt *   0.00 / 100 + T.Populated_percent_change_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dataset_name','file_type','version','wu','count_oldfile','count_newfile','count_deduped_combined','percent_change');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dataset_name_pcnt,le.populated_file_type_pcnt,le.populated_version_pcnt,le.populated_wu_pcnt,le.populated_count_oldfile_pcnt,le.populated_count_newfile_pcnt,le.populated_count_deduped_combined_pcnt,le.populated_percent_change_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dataset_name,le.maxlength_file_type,le.maxlength_version,le.maxlength_wu,le.maxlength_count_oldfile,le.maxlength_count_newfile,le.maxlength_count_deduped_combined,le.maxlength_percent_change);
  SELF.avelength := CHOOSE(C,le.avelength_dataset_name,le.avelength_file_type,le.avelength_version,le.avelength_wu,le.avelength_count_oldfile,le.avelength_count_newfile,le.avelength_count_deduped_combined,le.avelength_percent_change);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.dataset_name),TRIM((SALT38.StrType)le.file_type),TRIM((SALT38.StrType)le.version),TRIM((SALT38.StrType)le.wu),IF (le.count_oldfile <> 0,TRIM((SALT38.StrType)le.count_oldfile), ''),IF (le.count_newfile <> 0,TRIM((SALT38.StrType)le.count_newfile), ''),IF (le.count_deduped_combined <> 0,TRIM((SALT38.StrType)le.count_deduped_combined), ''),IF (le.percent_change <> 0,TRIM((SALT38.StrType)le.percent_change), '')));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.dataset_name),TRIM((SALT38.StrType)le.file_type),TRIM((SALT38.StrType)le.version),TRIM((SALT38.StrType)le.wu),IF (le.count_oldfile <> 0,TRIM((SALT38.StrType)le.count_oldfile), ''),IF (le.count_newfile <> 0,TRIM((SALT38.StrType)le.count_newfile), ''),IF (le.count_deduped_combined <> 0,TRIM((SALT38.StrType)le.count_deduped_combined), ''),IF (le.percent_change <> 0,TRIM((SALT38.StrType)le.percent_change), '')));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.dataset_name),TRIM((SALT38.StrType)le.file_type),TRIM((SALT38.StrType)le.version),TRIM((SALT38.StrType)le.wu),IF (le.count_oldfile <> 0,TRIM((SALT38.StrType)le.count_oldfile), ''),IF (le.count_newfile <> 0,TRIM((SALT38.StrType)le.count_newfile), ''),IF (le.count_deduped_combined <> 0,TRIM((SALT38.StrType)le.count_deduped_combined), ''),IF (le.percent_change <> 0,TRIM((SALT38.StrType)le.percent_change), '')));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dataset_name'}
      ,{2,'file_type'}
      ,{3,'version'}
      ,{4,'wu'}
      ,{5,'count_oldfile'}
      ,{6,'count_newfile'}
      ,{7,'count_deduped_combined'}
      ,{8,'percent_change'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    KeyGrowth_Fields.InValid_dataset_name((SALT38.StrType)le.dataset_name),
    KeyGrowth_Fields.InValid_file_type((SALT38.StrType)le.file_type),
    KeyGrowth_Fields.InValid_version((SALT38.StrType)le.version),
    KeyGrowth_Fields.InValid_wu((SALT38.StrType)le.wu),
    KeyGrowth_Fields.InValid_count_oldfile((SALT38.StrType)le.count_oldfile),
    KeyGrowth_Fields.InValid_count_newfile((SALT38.StrType)le.count_newfile),
    KeyGrowth_Fields.InValid_count_deduped_combined((SALT38.StrType)le.count_deduped_combined),
    KeyGrowth_Fields.InValid_percent_change((SALT38.StrType)le.percent_change),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,8,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := KeyGrowth_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Unknown','Invalid_Growth');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,KeyGrowth_Fields.InValidMessage_dataset_name(TotalErrors.ErrorNum),KeyGrowth_Fields.InValidMessage_file_type(TotalErrors.ErrorNum),KeyGrowth_Fields.InValidMessage_version(TotalErrors.ErrorNum),KeyGrowth_Fields.InValidMessage_wu(TotalErrors.ErrorNum),KeyGrowth_Fields.InValidMessage_count_oldfile(TotalErrors.ErrorNum),KeyGrowth_Fields.InValidMessage_count_newfile(TotalErrors.ErrorNum),KeyGrowth_Fields.InValidMessage_count_deduped_combined(TotalErrors.ErrorNum),KeyGrowth_Fields.InValidMessage_percent_change(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Risk_Indicators, KeyGrowth_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
