IMPORT SALT311,STD;
EXPORT Input_FL_Event_hygiene(dataset(Input_FL_Event_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_EVENT_DOC_NUMBER_cnt := COUNT(GROUP,h.EVENT_DOC_NUMBER <> (TYPEOF(h.EVENT_DOC_NUMBER))'');
    populated_EVENT_DOC_NUMBER_pcnt := AVE(GROUP,IF(h.EVENT_DOC_NUMBER = (TYPEOF(h.EVENT_DOC_NUMBER))'',0,100));
    maxlength_EVENT_DOC_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EVENT_DOC_NUMBER)));
    avelength_EVENT_DOC_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EVENT_DOC_NUMBER)),h.EVENT_DOC_NUMBER<>(typeof(h.EVENT_DOC_NUMBER))'');
    populated_EVENT_ORIG_DOC_NUMBER_cnt := COUNT(GROUP,h.EVENT_ORIG_DOC_NUMBER <> (TYPEOF(h.EVENT_ORIG_DOC_NUMBER))'');
    populated_EVENT_ORIG_DOC_NUMBER_pcnt := AVE(GROUP,IF(h.EVENT_ORIG_DOC_NUMBER = (TYPEOF(h.EVENT_ORIG_DOC_NUMBER))'',0,100));
    maxlength_EVENT_ORIG_DOC_NUMBER := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EVENT_ORIG_DOC_NUMBER)));
    avelength_EVENT_ORIG_DOC_NUMBER := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EVENT_ORIG_DOC_NUMBER)),h.EVENT_ORIG_DOC_NUMBER<>(typeof(h.EVENT_ORIG_DOC_NUMBER))'');
    populated_EVENT_DATE_cnt := COUNT(GROUP,h.EVENT_DATE <> (TYPEOF(h.EVENT_DATE))'');
    populated_EVENT_DATE_pcnt := AVE(GROUP,IF(h.EVENT_DATE = (TYPEOF(h.EVENT_DATE))'',0,100));
    maxlength_EVENT_DATE := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.EVENT_DATE)));
    avelength_EVENT_DATE := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.EVENT_DATE)),h.EVENT_DATE<>(typeof(h.EVENT_DATE))'');
    populated_ACTION_OWN_NAME_cnt := COUNT(GROUP,h.ACTION_OWN_NAME <> (TYPEOF(h.ACTION_OWN_NAME))'');
    populated_ACTION_OWN_NAME_pcnt := AVE(GROUP,IF(h.ACTION_OWN_NAME = (TYPEOF(h.ACTION_OWN_NAME))'',0,100));
    maxlength_ACTION_OWN_NAME := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ACTION_OWN_NAME)));
    avelength_ACTION_OWN_NAME := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ACTION_OWN_NAME)),h.ACTION_OWN_NAME<>(typeof(h.ACTION_OWN_NAME))'');
    populated_prep_old_addr_line1_cnt := COUNT(GROUP,h.prep_old_addr_line1 <> (TYPEOF(h.prep_old_addr_line1))'');
    populated_prep_old_addr_line1_pcnt := AVE(GROUP,IF(h.prep_old_addr_line1 = (TYPEOF(h.prep_old_addr_line1))'',0,100));
    maxlength_prep_old_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_old_addr_line1)));
    avelength_prep_old_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_old_addr_line1)),h.prep_old_addr_line1<>(typeof(h.prep_old_addr_line1))'');
    populated_prep_old_addr_line_last_cnt := COUNT(GROUP,h.prep_old_addr_line_last <> (TYPEOF(h.prep_old_addr_line_last))'');
    populated_prep_old_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_old_addr_line_last = (TYPEOF(h.prep_old_addr_line_last))'',0,100));
    maxlength_prep_old_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_old_addr_line_last)));
    avelength_prep_old_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_old_addr_line_last)),h.prep_old_addr_line_last<>(typeof(h.prep_old_addr_line_last))'');
    populated_prep_new_addr_line1_cnt := COUNT(GROUP,h.prep_new_addr_line1 <> (TYPEOF(h.prep_new_addr_line1))'');
    populated_prep_new_addr_line1_pcnt := AVE(GROUP,IF(h.prep_new_addr_line1 = (TYPEOF(h.prep_new_addr_line1))'',0,100));
    maxlength_prep_new_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_new_addr_line1)));
    avelength_prep_new_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_new_addr_line1)),h.prep_new_addr_line1<>(typeof(h.prep_new_addr_line1))'');
    populated_prep_new_addr_line_last_cnt := COUNT(GROUP,h.prep_new_addr_line_last <> (TYPEOF(h.prep_new_addr_line_last))'');
    populated_prep_new_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_new_addr_line_last = (TYPEOF(h.prep_new_addr_line_last))'',0,100));
    maxlength_prep_new_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_new_addr_line_last)));
    avelength_prep_new_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_new_addr_line_last)),h.prep_new_addr_line_last<>(typeof(h.prep_new_addr_line_last))'');
    populated_prep_owner_addr_line1_cnt := COUNT(GROUP,h.prep_owner_addr_line1 <> (TYPEOF(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_cnt := COUNT(GROUP,h.prep_owner_addr_line_last <> (TYPEOF(h.prep_owner_addr_line_last))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_EVENT_DOC_NUMBER_pcnt *   0.00 / 100 + T.Populated_EVENT_ORIG_DOC_NUMBER_pcnt *   0.00 / 100 + T.Populated_EVENT_DATE_pcnt *   0.00 / 100 + T.Populated_ACTION_OWN_NAME_pcnt *   0.00 / 100 + T.Populated_prep_old_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_old_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_new_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_new_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'EVENT_DOC_NUMBER','EVENT_ORIG_DOC_NUMBER','EVENT_DATE','ACTION_OWN_NAME','prep_old_addr_line1','prep_old_addr_line_last','prep_new_addr_line1','prep_new_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_EVENT_DOC_NUMBER_pcnt,le.populated_EVENT_ORIG_DOC_NUMBER_pcnt,le.populated_EVENT_DATE_pcnt,le.populated_ACTION_OWN_NAME_pcnt,le.populated_prep_old_addr_line1_pcnt,le.populated_prep_old_addr_line_last_pcnt,le.populated_prep_new_addr_line1_pcnt,le.populated_prep_new_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_EVENT_DOC_NUMBER,le.maxlength_EVENT_ORIG_DOC_NUMBER,le.maxlength_EVENT_DATE,le.maxlength_ACTION_OWN_NAME,le.maxlength_prep_old_addr_line1,le.maxlength_prep_old_addr_line_last,le.maxlength_prep_new_addr_line1,le.maxlength_prep_new_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_EVENT_DOC_NUMBER,le.avelength_EVENT_ORIG_DOC_NUMBER,le.avelength_EVENT_DATE,le.avelength_ACTION_OWN_NAME,le.avelength_prep_old_addr_line1,le.avelength_prep_old_addr_line_last,le.avelength_prep_new_addr_line1,le.avelength_prep_new_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.EVENT_DOC_NUMBER),TRIM((SALT311.StrType)le.EVENT_ORIG_DOC_NUMBER),TRIM((SALT311.StrType)le.EVENT_DATE),TRIM((SALT311.StrType)le.ACTION_OWN_NAME),TRIM((SALT311.StrType)le.prep_old_addr_line1),TRIM((SALT311.StrType)le.prep_old_addr_line_last),TRIM((SALT311.StrType)le.prep_new_addr_line1),TRIM((SALT311.StrType)le.prep_new_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.EVENT_DOC_NUMBER),TRIM((SALT311.StrType)le.EVENT_ORIG_DOC_NUMBER),TRIM((SALT311.StrType)le.EVENT_DATE),TRIM((SALT311.StrType)le.ACTION_OWN_NAME),TRIM((SALT311.StrType)le.prep_old_addr_line1),TRIM((SALT311.StrType)le.prep_old_addr_line_last),TRIM((SALT311.StrType)le.prep_new_addr_line1),TRIM((SALT311.StrType)le.prep_new_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.EVENT_DOC_NUMBER),TRIM((SALT311.StrType)le.EVENT_ORIG_DOC_NUMBER),TRIM((SALT311.StrType)le.EVENT_DATE),TRIM((SALT311.StrType)le.ACTION_OWN_NAME),TRIM((SALT311.StrType)le.prep_old_addr_line1),TRIM((SALT311.StrType)le.prep_old_addr_line_last),TRIM((SALT311.StrType)le.prep_new_addr_line1),TRIM((SALT311.StrType)le.prep_new_addr_line_last),TRIM((SALT311.StrType)le.prep_owner_addr_line1),TRIM((SALT311.StrType)le.prep_owner_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'EVENT_DOC_NUMBER'}
      ,{2,'EVENT_ORIG_DOC_NUMBER'}
      ,{3,'EVENT_DATE'}
      ,{4,'ACTION_OWN_NAME'}
      ,{5,'prep_old_addr_line1'}
      ,{6,'prep_old_addr_line_last'}
      ,{7,'prep_new_addr_line1'}
      ,{8,'prep_new_addr_line_last'}
      ,{9,'prep_owner_addr_line1'}
      ,{10,'prep_owner_addr_line_last'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_FL_Event_Fields.InValid_EVENT_DOC_NUMBER((SALT311.StrType)le.EVENT_DOC_NUMBER),
    Input_FL_Event_Fields.InValid_EVENT_ORIG_DOC_NUMBER((SALT311.StrType)le.EVENT_ORIG_DOC_NUMBER),
    Input_FL_Event_Fields.InValid_EVENT_DATE((SALT311.StrType)le.EVENT_DATE),
    Input_FL_Event_Fields.InValid_ACTION_OWN_NAME((SALT311.StrType)le.ACTION_OWN_NAME),
    Input_FL_Event_Fields.InValid_prep_old_addr_line1((SALT311.StrType)le.prep_old_addr_line1),
    Input_FL_Event_Fields.InValid_prep_old_addr_line_last((SALT311.StrType)le.prep_old_addr_line_last),
    Input_FL_Event_Fields.InValid_prep_new_addr_line1((SALT311.StrType)le.prep_new_addr_line1),
    Input_FL_Event_Fields.InValid_prep_new_addr_line_last((SALT311.StrType)le.prep_new_addr_line_last),
    Input_FL_Event_Fields.InValid_prep_owner_addr_line1((SALT311.StrType)le.prep_owner_addr_line1),
    Input_FL_Event_Fields.InValid_prep_owner_addr_line_last((SALT311.StrType)le.prep_owner_addr_line_last),
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
  FieldNme := Input_FL_Event_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_mandatory','invalid_past_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_FL_Event_Fields.InValidMessage_EVENT_DOC_NUMBER(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_EVENT_ORIG_DOC_NUMBER(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_EVENT_DATE(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_ACTION_OWN_NAME(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_old_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_old_addr_line_last(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_new_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_new_addr_line_last(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FBNV2, Input_FL_Event_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
