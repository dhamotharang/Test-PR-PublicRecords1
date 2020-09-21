IMPORT SALT311,STD;
EXPORT Accident_Raw_hygiene(dataset(Accident_Raw_Layout) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_summary_nr_cnt := COUNT(GROUP,h.summary_nr <> (TYPEOF(h.summary_nr))'');
    populated_summary_nr_pcnt := AVE(GROUP,IF(h.summary_nr = (TYPEOF(h.summary_nr))'',0,100));
    maxlength_summary_nr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.summary_nr)));
    avelength_summary_nr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.summary_nr)),h.summary_nr<>(typeof(h.summary_nr))'');
    populated_report_id_cnt := COUNT(GROUP,h.report_id <> (TYPEOF(h.report_id))'');
    populated_report_id_pcnt := AVE(GROUP,IF(h.report_id = (TYPEOF(h.report_id))'',0,100));
    maxlength_report_id := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.report_id)));
    avelength_report_id := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.report_id)),h.report_id<>(typeof(h.report_id))'');
    populated_event_date_time_cnt := COUNT(GROUP,h.event_date_time <> (TYPEOF(h.event_date_time))'');
    populated_event_date_time_pcnt := AVE(GROUP,IF(h.event_date_time = (TYPEOF(h.event_date_time))'',0,100));
    maxlength_event_date_time := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_date_time)));
    avelength_event_date_time := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.event_date_time)),h.event_date_time<>(typeof(h.event_date_time))'');
    populated_const_end_use_cnt := COUNT(GROUP,h.const_end_use <> (TYPEOF(h.const_end_use))'');
    populated_const_end_use_pcnt := AVE(GROUP,IF(h.const_end_use = (TYPEOF(h.const_end_use))'',0,100));
    maxlength_const_end_use := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.const_end_use)));
    avelength_const_end_use := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.const_end_use)),h.const_end_use<>(typeof(h.const_end_use))'');
    populated_build_stories_cnt := COUNT(GROUP,h.build_stories <> (TYPEOF(h.build_stories))'');
    populated_build_stories_pcnt := AVE(GROUP,IF(h.build_stories = (TYPEOF(h.build_stories))'',0,100));
    maxlength_build_stories := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.build_stories)));
    avelength_build_stories := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.build_stories)),h.build_stories<>(typeof(h.build_stories))'');
    populated_nonbuild_ht_cnt := COUNT(GROUP,h.nonbuild_ht <> (TYPEOF(h.nonbuild_ht))'');
    populated_nonbuild_ht_pcnt := AVE(GROUP,IF(h.nonbuild_ht = (TYPEOF(h.nonbuild_ht))'',0,100));
    maxlength_nonbuild_ht := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.nonbuild_ht)));
    avelength_nonbuild_ht := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.nonbuild_ht)),h.nonbuild_ht<>(typeof(h.nonbuild_ht))'');
    populated_project_cost_cnt := COUNT(GROUP,h.project_cost <> (TYPEOF(h.project_cost))'');
    populated_project_cost_pcnt := AVE(GROUP,IF(h.project_cost = (TYPEOF(h.project_cost))'',0,100));
    maxlength_project_cost := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.project_cost)));
    avelength_project_cost := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.project_cost)),h.project_cost<>(typeof(h.project_cost))'');
    populated_project_type_cnt := COUNT(GROUP,h.project_type <> (TYPEOF(h.project_type))'');
    populated_project_type_pcnt := AVE(GROUP,IF(h.project_type = (TYPEOF(h.project_type))'',0,100));
    maxlength_project_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.project_type)));
    avelength_project_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.project_type)),h.project_type<>(typeof(h.project_type))'');
    populated_sic_list_cnt := COUNT(GROUP,h.sic_list <> (TYPEOF(h.sic_list))'');
    populated_sic_list_pcnt := AVE(GROUP,IF(h.sic_list = (TYPEOF(h.sic_list))'',0,100));
    maxlength_sic_list := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_list)));
    avelength_sic_list := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic_list)),h.sic_list<>(typeof(h.sic_list))'');
    populated_fatality_cnt := COUNT(GROUP,h.fatality <> (TYPEOF(h.fatality))'');
    populated_fatality_pcnt := AVE(GROUP,IF(h.fatality = (TYPEOF(h.fatality))'',0,100));
    maxlength_fatality := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.fatality)));
    avelength_fatality := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.fatality)),h.fatality<>(typeof(h.fatality))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_summary_nr_pcnt *   0.00 / 100 + T.Populated_report_id_pcnt *   0.00 / 100 + T.Populated_event_date_time_pcnt *   0.00 / 100 + T.Populated_const_end_use_pcnt *   0.00 / 100 + T.Populated_build_stories_pcnt *   0.00 / 100 + T.Populated_nonbuild_ht_pcnt *   0.00 / 100 + T.Populated_project_cost_pcnt *   0.00 / 100 + T.Populated_project_type_pcnt *   0.00 / 100 + T.Populated_sic_list_pcnt *   0.00 / 100 + T.Populated_fatality_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'summary_nr','report_id','event_date_time','const_end_use','build_stories','nonbuild_ht','project_cost','project_type','sic_list','fatality');
  SELF.populated_pcnt := CHOOSE(C,le.populated_summary_nr_pcnt,le.populated_report_id_pcnt,le.populated_event_date_time_pcnt,le.populated_const_end_use_pcnt,le.populated_build_stories_pcnt,le.populated_nonbuild_ht_pcnt,le.populated_project_cost_pcnt,le.populated_project_type_pcnt,le.populated_sic_list_pcnt,le.populated_fatality_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_summary_nr,le.maxlength_report_id,le.maxlength_event_date_time,le.maxlength_const_end_use,le.maxlength_build_stories,le.maxlength_nonbuild_ht,le.maxlength_project_cost,le.maxlength_project_type,le.maxlength_sic_list,le.maxlength_fatality);
  SELF.avelength := CHOOSE(C,le.avelength_summary_nr,le.avelength_report_id,le.avelength_event_date_time,le.avelength_const_end_use,le.avelength_build_stories,le.avelength_nonbuild_ht,le.avelength_project_cost,le.avelength_project_type,le.avelength_sic_list,le.avelength_fatality);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.report_id),TRIM((SALT311.StrType)le.event_date_time),TRIM((SALT311.StrType)le.const_end_use),TRIM((SALT311.StrType)le.build_stories),TRIM((SALT311.StrType)le.nonbuild_ht),TRIM((SALT311.StrType)le.project_cost),TRIM((SALT311.StrType)le.project_type),TRIM((SALT311.StrType)le.sic_list),TRIM((SALT311.StrType)le.fatality)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.report_id),TRIM((SALT311.StrType)le.event_date_time),TRIM((SALT311.StrType)le.const_end_use),TRIM((SALT311.StrType)le.build_stories),TRIM((SALT311.StrType)le.nonbuild_ht),TRIM((SALT311.StrType)le.project_cost),TRIM((SALT311.StrType)le.project_type),TRIM((SALT311.StrType)le.sic_list),TRIM((SALT311.StrType)le.fatality)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.summary_nr),TRIM((SALT311.StrType)le.report_id),TRIM((SALT311.StrType)le.event_date_time),TRIM((SALT311.StrType)le.const_end_use),TRIM((SALT311.StrType)le.build_stories),TRIM((SALT311.StrType)le.nonbuild_ht),TRIM((SALT311.StrType)le.project_cost),TRIM((SALT311.StrType)le.project_type),TRIM((SALT311.StrType)le.sic_list),TRIM((SALT311.StrType)le.fatality)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'summary_nr'}
      ,{2,'report_id'}
      ,{3,'event_date_time'}
      ,{4,'const_end_use'}
      ,{5,'build_stories'}
      ,{6,'nonbuild_ht'}
      ,{7,'project_cost'}
      ,{8,'project_type'}
      ,{9,'sic_list'}
      ,{10,'fatality'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Accident_Raw_Fields.InValid_summary_nr((SALT311.StrType)le.summary_nr),
    Accident_Raw_Fields.InValid_report_id((SALT311.StrType)le.report_id),
    Accident_Raw_Fields.InValid_event_date_time((SALT311.StrType)le.event_date_time),
    Accident_Raw_Fields.InValid_const_end_use((SALT311.StrType)le.const_end_use),
    Accident_Raw_Fields.InValid_build_stories((SALT311.StrType)le.build_stories),
    Accident_Raw_Fields.InValid_nonbuild_ht((SALT311.StrType)le.nonbuild_ht),
    Accident_Raw_Fields.InValid_project_cost((SALT311.StrType)le.project_cost),
    Accident_Raw_Fields.InValid_project_type((SALT311.StrType)le.project_type),
    Accident_Raw_Fields.InValid_sic_list((SALT311.StrType)le.sic_list),
    Accident_Raw_Fields.InValid_fatality((SALT311.StrType)le.fatality),
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
  FieldNme := Accident_Raw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_numeric','invalid_date_time','invalid_const_end_use','invalid_numeric_blank','invalid_numeric_blank','invalid_project_cost','invalid_project_type','invalid_sic_list','invalid_fatality');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Accident_Raw_Fields.InValidMessage_summary_nr(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_report_id(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_event_date_time(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_const_end_use(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_build_stories(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_nonbuild_ht(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_project_cost(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_project_type(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_sic_list(TotalErrors.ErrorNum),Accident_Raw_Fields.InValidMessage_fatality(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_OSHAIR, Accident_Raw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
