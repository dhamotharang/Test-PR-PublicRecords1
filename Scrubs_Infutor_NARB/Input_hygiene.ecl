IMPORT SALT311,STD;
EXPORT Input_hygiene(dataset(Input_layout_Infutor_NARB) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dt_first_seen_cnt := COUNT(GROUP,h.dt_first_seen <> (TYPEOF(h.dt_first_seen))'');
    populated_dt_first_seen_pcnt := AVE(GROUP,IF(h.dt_first_seen = (TYPEOF(h.dt_first_seen))'',0,100));
    maxlength_dt_first_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)));
    avelength_dt_first_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_first_seen)),h.dt_first_seen<>(typeof(h.dt_first_seen))'');
    populated_dt_last_seen_cnt := COUNT(GROUP,h.dt_last_seen <> (TYPEOF(h.dt_last_seen))'');
    populated_dt_last_seen_pcnt := AVE(GROUP,IF(h.dt_last_seen = (TYPEOF(h.dt_last_seen))'',0,100));
    maxlength_dt_last_seen := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)));
    avelength_dt_last_seen := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_last_seen)),h.dt_last_seen<>(typeof(h.dt_last_seen))'');
    populated_dt_vendor_first_reported_cnt := COUNT(GROUP,h.dt_vendor_first_reported <> (TYPEOF(h.dt_vendor_first_reported))'');
    populated_dt_vendor_first_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_first_reported = (TYPEOF(h.dt_vendor_first_reported))'',0,100));
    maxlength_dt_vendor_first_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)));
    avelength_dt_vendor_first_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_first_reported)),h.dt_vendor_first_reported<>(typeof(h.dt_vendor_first_reported))'');
    populated_dt_vendor_last_reported_cnt := COUNT(GROUP,h.dt_vendor_last_reported <> (TYPEOF(h.dt_vendor_last_reported))'');
    populated_dt_vendor_last_reported_pcnt := AVE(GROUP,IF(h.dt_vendor_last_reported = (TYPEOF(h.dt_vendor_last_reported))'',0,100));
    maxlength_dt_vendor_last_reported := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)));
    avelength_dt_vendor_last_reported := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt_vendor_last_reported)),h.dt_vendor_last_reported<>(typeof(h.dt_vendor_last_reported))'');
    populated_process_date_cnt := COUNT(GROUP,h.process_date <> (TYPEOF(h.process_date))'');
    populated_process_date_pcnt := AVE(GROUP,IF(h.process_date = (TYPEOF(h.process_date))'',0,100));
    maxlength_process_date := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)));
    avelength_process_date := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.process_date)),h.process_date<>(typeof(h.process_date))'');
    populated_record_type_cnt := COUNT(GROUP,h.record_type <> (TYPEOF(h.record_type))'');
    populated_record_type_pcnt := AVE(GROUP,IF(h.record_type = (TYPEOF(h.record_type))'',0,100));
    maxlength_record_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)));
    avelength_record_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.record_type)),h.record_type<>(typeof(h.record_type))'');
    populated_pid_cnt := COUNT(GROUP,h.pid <> (TYPEOF(h.pid))'');
    populated_pid_pcnt := AVE(GROUP,IF(h.pid = (TYPEOF(h.pid))'',0,100));
    maxlength_pid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.pid)));
    avelength_pid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.pid)),h.pid<>(typeof(h.pid))'');
    populated_address_type_code_cnt := COUNT(GROUP,h.address_type_code <> (TYPEOF(h.address_type_code))'');
    populated_address_type_code_pcnt := AVE(GROUP,IF(h.address_type_code = (TYPEOF(h.address_type_code))'',0,100));
    maxlength_address_type_code := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type_code)));
    avelength_address_type_code := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address_type_code)),h.address_type_code<>(typeof(h.address_type_code))'');
    populated_url_cnt := COUNT(GROUP,h.url <> (TYPEOF(h.url))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_sic1_cnt := COUNT(GROUP,h.sic1 <> (TYPEOF(h.sic1))'');
    populated_sic1_pcnt := AVE(GROUP,IF(h.sic1 = (TYPEOF(h.sic1))'',0,100));
    maxlength_sic1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic1)));
    avelength_sic1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic1)),h.sic1<>(typeof(h.sic1))'');
    populated_sic2_cnt := COUNT(GROUP,h.sic2 <> (TYPEOF(h.sic2))'');
    populated_sic2_pcnt := AVE(GROUP,IF(h.sic2 = (TYPEOF(h.sic2))'',0,100));
    maxlength_sic2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic2)));
    avelength_sic2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic2)),h.sic2<>(typeof(h.sic2))'');
    populated_sic3_cnt := COUNT(GROUP,h.sic3 <> (TYPEOF(h.sic3))'');
    populated_sic3_pcnt := AVE(GROUP,IF(h.sic3 = (TYPEOF(h.sic3))'',0,100));
    maxlength_sic3 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic3)));
    avelength_sic3 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic3)),h.sic3<>(typeof(h.sic3))'');
    populated_sic4_cnt := COUNT(GROUP,h.sic4 <> (TYPEOF(h.sic4))'');
    populated_sic4_pcnt := AVE(GROUP,IF(h.sic4 = (TYPEOF(h.sic4))'',0,100));
    maxlength_sic4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic4)));
    avelength_sic4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic4)),h.sic4<>(typeof(h.sic4))'');
    populated_sic5_cnt := COUNT(GROUP,h.sic5 <> (TYPEOF(h.sic5))'');
    populated_sic5_pcnt := AVE(GROUP,IF(h.sic5 = (TYPEOF(h.sic5))'',0,100));
    maxlength_sic5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic5)));
    avelength_sic5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.sic5)),h.sic5<>(typeof(h.sic5))'');
    populated_incorporation_state_cnt := COUNT(GROUP,h.incorporation_state <> (TYPEOF(h.incorporation_state))'');
    populated_incorporation_state_pcnt := AVE(GROUP,IF(h.incorporation_state = (TYPEOF(h.incorporation_state))'',0,100));
    maxlength_incorporation_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.incorporation_state)));
    avelength_incorporation_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.incorporation_state)),h.incorporation_state<>(typeof(h.incorporation_state))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_contact_title_cnt := COUNT(GROUP,h.contact_title <> (TYPEOF(h.contact_title))'');
    populated_contact_title_pcnt := AVE(GROUP,IF(h.contact_title = (TYPEOF(h.contact_title))'',0,100));
    maxlength_contact_title := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_title)));
    avelength_contact_title := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.contact_title)),h.contact_title<>(typeof(h.contact_title))'');
    populated_normcompany_type_cnt := COUNT(GROUP,h.normcompany_type <> (TYPEOF(h.normcompany_type))'');
    populated_normcompany_type_pcnt := AVE(GROUP,IF(h.normcompany_type = (TYPEOF(h.normcompany_type))'',0,100));
    maxlength_normcompany_type := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.normcompany_type)));
    avelength_normcompany_type := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.normcompany_type)),h.normcompany_type<>(typeof(h.normcompany_type))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dt_first_seen_pcnt *   0.00 / 100 + T.Populated_dt_last_seen_pcnt *   0.00 / 100 + T.Populated_dt_vendor_first_reported_pcnt *   0.00 / 100 + T.Populated_dt_vendor_last_reported_pcnt *   0.00 / 100 + T.Populated_process_date_pcnt *   0.00 / 100 + T.Populated_record_type_pcnt *   0.00 / 100 + T.Populated_pid_pcnt *   0.00 / 100 + T.Populated_address_type_code_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_sic1_pcnt *   0.00 / 100 + T.Populated_sic2_pcnt *   0.00 / 100 + T.Populated_sic3_pcnt *   0.00 / 100 + T.Populated_sic4_pcnt *   0.00 / 100 + T.Populated_sic5_pcnt *   0.00 / 100 + T.Populated_incorporation_state_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_contact_title_pcnt *   0.00 / 100 + T.Populated_normcompany_type_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dt_first_seen','dt_last_seen','dt_vendor_first_reported','dt_vendor_last_reported','process_date','record_type','pid','address_type_code','url','sic1','sic2','sic3','sic4','sic5','incorporation_state','email','contact_title','normcompany_type');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dt_first_seen_pcnt,le.populated_dt_last_seen_pcnt,le.populated_dt_vendor_first_reported_pcnt,le.populated_dt_vendor_last_reported_pcnt,le.populated_process_date_pcnt,le.populated_record_type_pcnt,le.populated_pid_pcnt,le.populated_address_type_code_pcnt,le.populated_url_pcnt,le.populated_sic1_pcnt,le.populated_sic2_pcnt,le.populated_sic3_pcnt,le.populated_sic4_pcnt,le.populated_sic5_pcnt,le.populated_incorporation_state_pcnt,le.populated_email_pcnt,le.populated_contact_title_pcnt,le.populated_normcompany_type_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dt_first_seen,le.maxlength_dt_last_seen,le.maxlength_dt_vendor_first_reported,le.maxlength_dt_vendor_last_reported,le.maxlength_process_date,le.maxlength_record_type,le.maxlength_pid,le.maxlength_address_type_code,le.maxlength_url,le.maxlength_sic1,le.maxlength_sic2,le.maxlength_sic3,le.maxlength_sic4,le.maxlength_sic5,le.maxlength_incorporation_state,le.maxlength_email,le.maxlength_contact_title,le.maxlength_normcompany_type);
  SELF.avelength := CHOOSE(C,le.avelength_dt_first_seen,le.avelength_dt_last_seen,le.avelength_dt_vendor_first_reported,le.avelength_dt_vendor_last_reported,le.avelength_process_date,le.avelength_record_type,le.avelength_pid,le.avelength_address_type_code,le.avelength_url,le.avelength_sic1,le.avelength_sic2,le.avelength_sic3,le.avelength_sic4,le.avelength_sic5,le.avelength_incorporation_state,le.avelength_email,le.avelength_contact_title,le.avelength_normcompany_type);
END;
EXPORT invSummary := NORMALIZE(summary0, 18, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.address_type_code),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.sic1),TRIM((SALT311.StrType)le.sic2),TRIM((SALT311.StrType)le.sic3),TRIM((SALT311.StrType)le.sic4),TRIM((SALT311.StrType)le.sic5),TRIM((SALT311.StrType)le.incorporation_state),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.contact_title),TRIM((SALT311.StrType)le.normcompany_type)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,18,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 18);
  SELF.FldNo2 := 1 + (C % 18);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.address_type_code),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.sic1),TRIM((SALT311.StrType)le.sic2),TRIM((SALT311.StrType)le.sic3),TRIM((SALT311.StrType)le.sic4),TRIM((SALT311.StrType)le.sic5),TRIM((SALT311.StrType)le.incorporation_state),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.contact_title),TRIM((SALT311.StrType)le.normcompany_type)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,IF (le.dt_first_seen <> 0,TRIM((SALT311.StrType)le.dt_first_seen), ''),IF (le.dt_last_seen <> 0,TRIM((SALT311.StrType)le.dt_last_seen), ''),IF (le.dt_vendor_first_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_first_reported), ''),IF (le.dt_vendor_last_reported <> 0,TRIM((SALT311.StrType)le.dt_vendor_last_reported), ''),IF (le.process_date <> 0,TRIM((SALT311.StrType)le.process_date), ''),TRIM((SALT311.StrType)le.record_type),TRIM((SALT311.StrType)le.pid),TRIM((SALT311.StrType)le.address_type_code),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.sic1),TRIM((SALT311.StrType)le.sic2),TRIM((SALT311.StrType)le.sic3),TRIM((SALT311.StrType)le.sic4),TRIM((SALT311.StrType)le.sic5),TRIM((SALT311.StrType)le.incorporation_state),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.contact_title),TRIM((SALT311.StrType)le.normcompany_type)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),18*18,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dt_first_seen'}
      ,{2,'dt_last_seen'}
      ,{3,'dt_vendor_first_reported'}
      ,{4,'dt_vendor_last_reported'}
      ,{5,'process_date'}
      ,{6,'record_type'}
      ,{7,'pid'}
      ,{8,'address_type_code'}
      ,{9,'url'}
      ,{10,'sic1'}
      ,{11,'sic2'}
      ,{12,'sic3'}
      ,{13,'sic4'}
      ,{14,'sic5'}
      ,{15,'incorporation_state'}
      ,{16,'email'}
      ,{17,'contact_title'}
      ,{18,'normcompany_type'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_Fields.InValid_dt_first_seen((SALT311.StrType)le.dt_first_seen),
    Input_Fields.InValid_dt_last_seen((SALT311.StrType)le.dt_last_seen),
    Input_Fields.InValid_dt_vendor_first_reported((SALT311.StrType)le.dt_vendor_first_reported),
    Input_Fields.InValid_dt_vendor_last_reported((SALT311.StrType)le.dt_vendor_last_reported),
    Input_Fields.InValid_process_date((SALT311.StrType)le.process_date),
    Input_Fields.InValid_record_type((SALT311.StrType)le.record_type),
    Input_Fields.InValid_pid((SALT311.StrType)le.pid),
    Input_Fields.InValid_address_type_code((SALT311.StrType)le.address_type_code),
    Input_Fields.InValid_url((SALT311.StrType)le.url),
    Input_Fields.InValid_sic1((SALT311.StrType)le.sic1),
    Input_Fields.InValid_sic2((SALT311.StrType)le.sic2),
    Input_Fields.InValid_sic3((SALT311.StrType)le.sic3),
    Input_Fields.InValid_sic4((SALT311.StrType)le.sic4),
    Input_Fields.InValid_sic5((SALT311.StrType)le.sic5),
    Input_Fields.InValid_incorporation_state((SALT311.StrType)le.incorporation_state),
    Input_Fields.InValid_email((SALT311.StrType)le.email),
    Input_Fields.InValid_contact_title((SALT311.StrType)le.contact_title),
    Input_Fields.InValid_normcompany_type((SALT311.StrType)le.normcompany_type),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,18,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_pastdate8','invalid_record_type','invalid_numeric','invalid_address_type_code','invalid_url','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_sic','invalid_st','invalid_email','invalid_mandatory','invalid_norm_type');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_Fields.InValidMessage_dt_first_seen(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dt_last_seen(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dt_vendor_first_reported(TotalErrors.ErrorNum),Input_Fields.InValidMessage_dt_vendor_last_reported(TotalErrors.ErrorNum),Input_Fields.InValidMessage_process_date(TotalErrors.ErrorNum),Input_Fields.InValidMessage_record_type(TotalErrors.ErrorNum),Input_Fields.InValidMessage_pid(TotalErrors.ErrorNum),Input_Fields.InValidMessage_address_type_code(TotalErrors.ErrorNum),Input_Fields.InValidMessage_url(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic1(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic2(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic3(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic4(TotalErrors.ErrorNum),Input_Fields.InValidMessage_sic5(TotalErrors.ErrorNum),Input_Fields.InValidMessage_incorporation_state(TotalErrors.ErrorNum),Input_Fields.InValidMessage_email(TotalErrors.ErrorNum),Input_Fields.InValidMessage_contact_title(TotalErrors.ErrorNum),Input_Fields.InValidMessage_normcompany_type(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Infutor_NARB, Input_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
