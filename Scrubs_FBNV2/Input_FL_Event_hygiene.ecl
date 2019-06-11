IMPORT SALT37;
EXPORT Input_FL_Event_hygiene(dataset(Input_FL_Event_layout_FBNV2) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT37.Str30Type txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_action_OWN_name_pcnt := AVE(GROUP,IF(h.action_OWN_name = (TYPEOF(h.action_OWN_name))'',0,100));
    maxlength_action_OWN_name := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_OWN_name)));
    avelength_action_OWN_name := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.action_OWN_name)),h.action_OWN_name<>(typeof(h.action_OWN_name))'');
    populated_event_date_pcnt := AVE(GROUP,IF(h.event_date = (TYPEOF(h.event_date))'',0,100));
    maxlength_event_date := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_date)));
    avelength_event_date := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_date)),h.event_date<>(typeof(h.event_date))'');
    populated_event_doc_number_pcnt := AVE(GROUP,IF(h.event_doc_number = (TYPEOF(h.event_doc_number))'',0,100));
    maxlength_event_doc_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_doc_number)));
    avelength_event_doc_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_doc_number)),h.event_doc_number<>(typeof(h.event_doc_number))'');
    populated_event_orig_doc_number_pcnt := AVE(GROUP,IF(h.event_orig_doc_number = (TYPEOF(h.event_orig_doc_number))'',0,100));
    maxlength_event_orig_doc_number := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_orig_doc_number)));
    avelength_event_orig_doc_number := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.event_orig_doc_number)),h.event_orig_doc_number<>(typeof(h.event_orig_doc_number))'');
    populated_prep_old_addr_line1_pcnt := AVE(GROUP,IF(h.prep_old_addr_line1 = (TYPEOF(h.prep_old_addr_line1))'',0,100));
    maxlength_prep_old_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_old_addr_line1)));
    avelength_prep_old_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_old_addr_line1)),h.prep_old_addr_line1<>(typeof(h.prep_old_addr_line1))'');
    populated_prep_old_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_old_addr_line_last = (TYPEOF(h.prep_old_addr_line_last))'',0,100));
    maxlength_prep_old_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_old_addr_line_last)));
    avelength_prep_old_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_old_addr_line_last)),h.prep_old_addr_line_last<>(typeof(h.prep_old_addr_line_last))'');
    populated_prep_new_addr_line1_pcnt := AVE(GROUP,IF(h.prep_new_addr_line1 = (TYPEOF(h.prep_new_addr_line1))'',0,100));
    maxlength_prep_new_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_new_addr_line1)));
    avelength_prep_new_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_new_addr_line1)),h.prep_new_addr_line1<>(typeof(h.prep_new_addr_line1))'');
    populated_prep_new_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_new_addr_line_last = (TYPEOF(h.prep_new_addr_line_last))'',0,100));
    maxlength_prep_new_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_new_addr_line_last)));
    avelength_prep_new_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_new_addr_line_last)),h.prep_new_addr_line_last<>(typeof(h.prep_new_addr_line_last))'');
    populated_prep_owner_addr_line1_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line1 = (TYPEOF(h.prep_owner_addr_line1))'',0,100));
    maxlength_prep_owner_addr_line1 := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)));
    avelength_prep_owner_addr_line1 := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line1)),h.prep_owner_addr_line1<>(typeof(h.prep_owner_addr_line1))'');
    populated_prep_owner_addr_line_last_pcnt := AVE(GROUP,IF(h.prep_owner_addr_line_last = (TYPEOF(h.prep_owner_addr_line_last))'',0,100));
    maxlength_prep_owner_addr_line_last := MAX(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)));
    avelength_prep_owner_addr_line_last := AVE(GROUP,LENGTH(TRIM((SALT37.StrType)h.prep_owner_addr_line_last)),h.prep_owner_addr_line_last<>(typeof(h.prep_owner_addr_line_last))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_action_OWN_name_pcnt *   0.00 / 100 + T.Populated_event_date_pcnt *   0.00 / 100 + T.Populated_event_doc_number_pcnt *   0.00 / 100 + T.Populated_event_orig_doc_number_pcnt *   0.00 / 100 + T.Populated_prep_old_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_old_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_new_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_new_addr_line_last_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line1_pcnt *   0.00 / 100 + T.Populated_prep_owner_addr_line_last_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'action_OWN_name','event_date','event_doc_number','event_orig_doc_number','prep_old_addr_line1','prep_old_addr_line_last','prep_new_addr_line1','prep_new_addr_line_last','prep_owner_addr_line1','prep_owner_addr_line_last');
  SELF.populated_pcnt := CHOOSE(C,le.populated_action_OWN_name_pcnt,le.populated_event_date_pcnt,le.populated_event_doc_number_pcnt,le.populated_event_orig_doc_number_pcnt,le.populated_prep_old_addr_line1_pcnt,le.populated_prep_old_addr_line_last_pcnt,le.populated_prep_new_addr_line1_pcnt,le.populated_prep_new_addr_line_last_pcnt,le.populated_prep_owner_addr_line1_pcnt,le.populated_prep_owner_addr_line_last_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_action_OWN_name,le.maxlength_event_date,le.maxlength_event_doc_number,le.maxlength_event_orig_doc_number,le.maxlength_prep_old_addr_line1,le.maxlength_prep_old_addr_line_last,le.maxlength_prep_new_addr_line1,le.maxlength_prep_new_addr_line_last,le.maxlength_prep_owner_addr_line1,le.maxlength_prep_owner_addr_line_last);
  SELF.avelength := CHOOSE(C,le.avelength_action_OWN_name,le.avelength_event_date,le.avelength_event_doc_number,le.avelength_event_orig_doc_number,le.avelength_prep_old_addr_line1,le.avelength_prep_old_addr_line_last,le.avelength_prep_new_addr_line1,le.avelength_prep_new_addr_line_last,le.avelength_prep_owner_addr_line1,le.avelength_prep_owner_addr_line_last);
END;
EXPORT invSummary := NORMALIZE(summary0, 10, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT37.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT37.StrType)le.action_OWN_name),TRIM((SALT37.StrType)le.event_date),TRIM((SALT37.StrType)le.event_doc_number),TRIM((SALT37.StrType)le.event_orig_doc_number),TRIM((SALT37.StrType)le.prep_old_addr_line1),TRIM((SALT37.StrType)le.prep_old_addr_line_last),TRIM((SALT37.StrType)le.prep_new_addr_line1),TRIM((SALT37.StrType)le.prep_new_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,10,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT37.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 10);
  SELF.FldNo2 := 1 + (C % 10);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT37.StrType)le.action_OWN_name),TRIM((SALT37.StrType)le.event_date),TRIM((SALT37.StrType)le.event_doc_number),TRIM((SALT37.StrType)le.event_orig_doc_number),TRIM((SALT37.StrType)le.prep_old_addr_line1),TRIM((SALT37.StrType)le.prep_old_addr_line_last),TRIM((SALT37.StrType)le.prep_new_addr_line1),TRIM((SALT37.StrType)le.prep_new_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT37.StrType)le.action_OWN_name),TRIM((SALT37.StrType)le.event_date),TRIM((SALT37.StrType)le.event_doc_number),TRIM((SALT37.StrType)le.event_orig_doc_number),TRIM((SALT37.StrType)le.prep_old_addr_line1),TRIM((SALT37.StrType)le.prep_old_addr_line_last),TRIM((SALT37.StrType)le.prep_new_addr_line1),TRIM((SALT37.StrType)le.prep_new_addr_line_last),TRIM((SALT37.StrType)le.prep_owner_addr_line1),TRIM((SALT37.StrType)le.prep_owner_addr_line_last)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),10*10,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'action_OWN_name'}
      ,{2,'event_date'}
      ,{3,'event_doc_number'}
      ,{4,'event_orig_doc_number'}
      ,{5,'prep_old_addr_line1'}
      ,{6,'prep_old_addr_line_last'}
      ,{7,'prep_new_addr_line1'}
      ,{8,'prep_new_addr_line_last'}
      ,{9,'prep_owner_addr_line1'}
      ,{10,'prep_owner_addr_line_last'}],SALT37.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT37.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT37.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT37.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_FL_Event_Fields.InValid_action_OWN_name((SALT37.StrType)le.action_OWN_name),
    Input_FL_Event_Fields.InValid_event_date((SALT37.StrType)le.event_date),
    Input_FL_Event_Fields.InValid_event_doc_number((SALT37.StrType)le.event_doc_number),
    Input_FL_Event_Fields.InValid_event_orig_doc_number((SALT37.StrType)le.event_orig_doc_number),
    Input_FL_Event_Fields.InValid_prep_old_addr_line1((SALT37.StrType)le.prep_old_addr_line1),
    Input_FL_Event_Fields.InValid_prep_old_addr_line_last((SALT37.StrType)le.prep_old_addr_line_last),
    Input_FL_Event_Fields.InValid_prep_new_addr_line1((SALT37.StrType)le.prep_new_addr_line1),
    Input_FL_Event_Fields.InValid_prep_new_addr_line_last((SALT37.StrType)le.prep_new_addr_line_last),
    Input_FL_Event_Fields.InValid_prep_owner_addr_line1((SALT37.StrType)le.prep_owner_addr_line1),
    Input_FL_Event_Fields.InValid_prep_owner_addr_line_last((SALT37.StrType)le.prep_owner_addr_line_last),
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
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_mandatory','invalid_general_date','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory','invalid_mandatory');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_FL_Event_Fields.InValidMessage_action_OWN_name(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_event_date(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_event_doc_number(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_event_orig_doc_number(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_old_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_old_addr_line_last(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_new_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_new_addr_line_last(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_owner_addr_line1(TotalErrors.ErrorNum),Input_FL_Event_Fields.InValidMessage_prep_owner_addr_line_last(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
END;
