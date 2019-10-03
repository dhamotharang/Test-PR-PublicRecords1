IMPORT SALT311,STD;
EXPORT OptOut_hygiene(dataset(OptOut_layout_Suppress) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_entry_type_cnt := COUNT(GROUP,h.entry_type <> (TYPEOF(h.entry_type))'');
    populated_entry_type_pcnt := AVE(GROUP,IF(h.entry_type = (TYPEOF(h.entry_type))'',0,100));
    maxlength_entry_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.entry_type)));
    avelength_entry_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.entry_type)),h.entry_type<>(typeof(h.entry_type))'');
    populated_lexid_cnt := COUNT(GROUP,h.lexid <> (TYPEOF(h.lexid))'');
    populated_lexid_pcnt := AVE(GROUP,IF(h.lexid = (TYPEOF(h.lexid))'',0,100));
    maxlength_lexid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)));
    avelength_lexid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lexid)),h.lexid<>(typeof(h.lexid))'');
    populated_prof_data_cnt := COUNT(GROUP,h.prof_data <> (TYPEOF(h.prof_data))'');
    populated_prof_data_pcnt := AVE(GROUP,IF(h.prof_data = (TYPEOF(h.prof_data))'',0,100));
    maxlength_prof_data := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prof_data)));
    avelength_prof_data := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prof_data)),h.prof_data<>(typeof(h.prof_data))'');
    populated_state_act_cnt := COUNT(GROUP,h.state_act <> (TYPEOF(h.state_act))'');
    populated_state_act_pcnt := AVE(GROUP,IF(h.state_act = (TYPEOF(h.state_act))'',0,100));
    maxlength_state_act := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_act)));
    avelength_state_act := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state_act)),h.state_act<>(typeof(h.state_act))'');
    populated_date_of_request_cnt := COUNT(GROUP,h.date_of_request <> (TYPEOF(h.date_of_request))'');
    populated_date_of_request_pcnt := AVE(GROUP,IF(h.date_of_request = (TYPEOF(h.date_of_request))'',0,100));
    maxlength_date_of_request := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_request)));
    avelength_date_of_request := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.date_of_request)),h.date_of_request<>(typeof(h.date_of_request))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_entry_type_pcnt *   0.00 / 100 + T.Populated_lexid_pcnt *   0.00 / 100 + T.Populated_prof_data_pcnt *   0.00 / 100 + T.Populated_state_act_pcnt *   0.00 / 100 + T.Populated_date_of_request_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'entry_type','lexid','prof_data','state_act','date_of_request');
  SELF.populated_pcnt := CHOOSE(C,le.populated_entry_type_pcnt,le.populated_lexid_pcnt,le.populated_prof_data_pcnt,le.populated_state_act_pcnt,le.populated_date_of_request_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_entry_type,le.maxlength_lexid,le.maxlength_prof_data,le.maxlength_state_act,le.maxlength_date_of_request);
  SELF.avelength := CHOOSE(C,le.avelength_entry_type,le.avelength_lexid,le.avelength_prof_data,le.avelength_state_act,le.avelength_date_of_request);
END;
EXPORT invSummary := NORMALIZE(summary0, 5, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.entry_type),IF (le.lexid <> 0,TRIM((SALT311.StrType)le.lexid), ''),TRIM((SALT311.StrType)le.prof_data),TRIM((SALT311.StrType)le.state_act),TRIM((SALT311.StrType)le.date_of_request)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,5,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 5);
  SELF.FldNo2 := 1 + (C % 5);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.entry_type),IF (le.lexid <> 0,TRIM((SALT311.StrType)le.lexid), ''),TRIM((SALT311.StrType)le.prof_data),TRIM((SALT311.StrType)le.state_act),TRIM((SALT311.StrType)le.date_of_request)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.entry_type),IF (le.lexid <> 0,TRIM((SALT311.StrType)le.lexid), ''),TRIM((SALT311.StrType)le.prof_data),TRIM((SALT311.StrType)le.state_act),TRIM((SALT311.StrType)le.date_of_request)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),5*5,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'entry_type'}
      ,{2,'lexid'}
      ,{3,'prof_data'}
      ,{4,'state_act'}
      ,{5,'date_of_request'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    OptOut_Fields.InValid_entry_type((SALT311.StrType)le.entry_type),
    OptOut_Fields.InValid_lexid((SALT311.StrType)le.lexid),
    OptOut_Fields.InValid_prof_data((SALT311.StrType)le.prof_data),
    OptOut_Fields.InValid_state_act((SALT311.StrType)le.state_act),
    OptOut_Fields.InValid_date_of_request((SALT311.StrType)le.date_of_request),
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
  FieldNme := OptOut_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Entry_Type','Invalid_Nums','Invalid_Prof_Data','invalid_state_Act','Invalid_Nums');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,OptOut_Fields.InValidMessage_entry_type(TotalErrors.ErrorNum),OptOut_Fields.InValidMessage_lexid(TotalErrors.ErrorNum),OptOut_Fields.InValidMessage_prof_data(TotalErrors.ErrorNum),OptOut_Fields.InValidMessage_state_act(TotalErrors.ErrorNum),OptOut_Fields.InValidMessage_date_of_request(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Suppress, OptOut_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
