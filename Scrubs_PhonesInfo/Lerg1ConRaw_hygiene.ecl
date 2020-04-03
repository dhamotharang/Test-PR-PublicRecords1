IMPORT SALT311,STD;
EXPORT Lerg1ConRaw_hygiene(dataset(Lerg1ConRaw_layout_PhonesInfo) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_ocn_cnt := COUNT(GROUP,h.ocn <> (TYPEOF(h.ocn))'');
    populated_ocn_pcnt := AVE(GROUP,IF(h.ocn = (TYPEOF(h.ocn))'',0,100));
    maxlength_ocn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)));
    avelength_ocn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn)),h.ocn<>(typeof(h.ocn))'');
    populated_ocn_name_cnt := COUNT(GROUP,h.ocn_name <> (TYPEOF(h.ocn_name))'');
    populated_ocn_name_pcnt := AVE(GROUP,IF(h.ocn_name = (TYPEOF(h.ocn_name))'',0,100));
    maxlength_ocn_name := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_name)));
    avelength_ocn_name := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_name)),h.ocn_name<>(typeof(h.ocn_name))'');
    populated_ocn_state_cnt := COUNT(GROUP,h.ocn_state <> (TYPEOF(h.ocn_state))'');
    populated_ocn_state_pcnt := AVE(GROUP,IF(h.ocn_state = (TYPEOF(h.ocn_state))'',0,100));
    maxlength_ocn_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_state)));
    avelength_ocn_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ocn_state)),h.ocn_state<>(typeof(h.ocn_state))'');
    populated_contact_function_cnt := COUNT(GROUP,h.contact_function <> (TYPEOF(h.contact_function))'');
    populated_contact_function_pcnt := AVE(GROUP,IF(h.contact_function = (TYPEOF(h.contact_function))'',0,100));
    maxlength_contact_function := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_function)));
    avelength_contact_function := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_function)),h.contact_function<>(typeof(h.contact_function))'');
    populated_contact_phone_cnt := COUNT(GROUP,h.contact_phone <> (TYPEOF(h.contact_phone))'');
    populated_contact_phone_pcnt := AVE(GROUP,IF(h.contact_phone = (TYPEOF(h.contact_phone))'',0,100));
    maxlength_contact_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_phone)));
    avelength_contact_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_phone)),h.contact_phone<>(typeof(h.contact_phone))'');
    populated_contact_information_cnt := COUNT(GROUP,h.contact_information <> (TYPEOF(h.contact_information))'');
    populated_contact_information_pcnt := AVE(GROUP,IF(h.contact_information = (TYPEOF(h.contact_information))'',0,100));
    maxlength_contact_information := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_information)));
    avelength_contact_information := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_information)),h.contact_information<>(typeof(h.contact_information))'');
    populated_filler_cnt := COUNT(GROUP,h.filler <> (TYPEOF(h.filler))'');
    populated_filler_pcnt := AVE(GROUP,IF(h.filler = (TYPEOF(h.filler))'',0,100));
    maxlength_filler := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler)));
    avelength_filler := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filler)),h.filler<>(typeof(h.filler))'');
    populated_filename_cnt := COUNT(GROUP,h.filename <> (TYPEOF(h.filename))'');
    populated_filename_pcnt := AVE(GROUP,IF(h.filename = (TYPEOF(h.filename))'',0,100));
    maxlength_filename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)));
    avelength_filename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.filename)),h.filename<>(typeof(h.filename))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_ocn_pcnt *   0.00 / 100 + T.Populated_ocn_name_pcnt *   0.00 / 100 + T.Populated_ocn_state_pcnt *   0.00 / 100 + T.Populated_contact_function_pcnt *   0.00 / 100 + T.Populated_contact_phone_pcnt *   0.00 / 100 + T.Populated_contact_information_pcnt *   0.00 / 100 + T.Populated_filler_pcnt *   0.00 / 100 + T.Populated_filename_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'ocn','ocn_name','ocn_state','contact_function','contact_phone','contact_information','filler','filename');
  SELF.populated_pcnt := CHOOSE(C,le.populated_ocn_pcnt,le.populated_ocn_name_pcnt,le.populated_ocn_state_pcnt,le.populated_contact_function_pcnt,le.populated_contact_phone_pcnt,le.populated_contact_information_pcnt,le.populated_filler_pcnt,le.populated_filename_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_ocn,le.maxlength_ocn_name,le.maxlength_ocn_state,le.maxlength_contact_function,le.maxlength_contact_phone,le.maxlength_contact_information,le.maxlength_filler,le.maxlength_filename);
  SELF.avelength := CHOOSE(C,le.avelength_ocn,le.avelength_ocn_name,le.avelength_ocn_state,le.avelength_contact_function,le.avelength_contact_phone,le.avelength_contact_information,le.avelength_filler,le.avelength_filename);
END;
EXPORT invSummary := NORMALIZE(summary0, 8, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.ocn_name),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.contact_function),TRIM((SALT311.StrType)le.contact_phone),TRIM((SALT311.StrType)le.contact_information),TRIM((SALT311.StrType)le.filler),TRIM((SALT311.StrType)le.filename)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,8,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 8);
  SELF.FldNo2 := 1 + (C % 8);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.ocn_name),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.contact_function),TRIM((SALT311.StrType)le.contact_phone),TRIM((SALT311.StrType)le.contact_information),TRIM((SALT311.StrType)le.filler),TRIM((SALT311.StrType)le.filename)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.ocn),TRIM((SALT311.StrType)le.ocn_name),TRIM((SALT311.StrType)le.ocn_state),TRIM((SALT311.StrType)le.contact_function),TRIM((SALT311.StrType)le.contact_phone),TRIM((SALT311.StrType)le.contact_information),TRIM((SALT311.StrType)le.filler),TRIM((SALT311.StrType)le.filename)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),8*8,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'ocn'}
      ,{2,'ocn_name'}
      ,{3,'ocn_state'}
      ,{4,'contact_function'}
      ,{5,'contact_phone'}
      ,{6,'contact_information'}
      ,{7,'filler'}
      ,{8,'filename'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Lerg1ConRaw_Fields.InValid_ocn((SALT311.StrType)le.ocn),
    Lerg1ConRaw_Fields.InValid_ocn_name((SALT311.StrType)le.ocn_name),
    Lerg1ConRaw_Fields.InValid_ocn_state((SALT311.StrType)le.ocn_state),
    Lerg1ConRaw_Fields.InValid_contact_function((SALT311.StrType)le.contact_function),
    Lerg1ConRaw_Fields.InValid_contact_phone((SALT311.StrType)le.contact_phone),
    Lerg1ConRaw_Fields.InValid_contact_information((SALT311.StrType)le.contact_information),
    Lerg1ConRaw_Fields.InValid_filler((SALT311.StrType)le.filler),
    Lerg1ConRaw_Fields.InValid_filename((SALT311.StrType)le.filename),
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
  FieldNme := Lerg1ConRaw_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_Ocn','Invalid_NotBlank','Invalid_Ocn_State','Invalid_NotBlank','Invalid_Phone','Unknown','Unknown','Invalid_Filename');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Lerg1ConRaw_Fields.InValidMessage_ocn(TotalErrors.ErrorNum),Lerg1ConRaw_Fields.InValidMessage_ocn_name(TotalErrors.ErrorNum),Lerg1ConRaw_Fields.InValidMessage_ocn_state(TotalErrors.ErrorNum),Lerg1ConRaw_Fields.InValidMessage_contact_function(TotalErrors.ErrorNum),Lerg1ConRaw_Fields.InValidMessage_contact_phone(TotalErrors.ErrorNum),Lerg1ConRaw_Fields.InValidMessage_contact_information(TotalErrors.ErrorNum),Lerg1ConRaw_Fields.InValidMessage_filler(TotalErrors.ErrorNum),Lerg1ConRaw_Fields.InValidMessage_filename(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_PhonesInfo, Lerg1ConRaw_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
