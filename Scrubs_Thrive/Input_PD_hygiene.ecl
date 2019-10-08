IMPORT SALT311,STD;
EXPORT Input_PD_hygiene(dataset(Input_PD_layout_Thrive) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_orig_fname_cnt := COUNT(GROUP,h.orig_fname <> (TYPEOF(h.orig_fname))'');
    populated_orig_fname_pcnt := AVE(GROUP,IF(h.orig_fname = (TYPEOF(h.orig_fname))'',0,100));
    maxlength_orig_fname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fname)));
    avelength_orig_fname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_fname)),h.orig_fname<>(typeof(h.orig_fname))'');
    populated_orig_mname_cnt := COUNT(GROUP,h.orig_mname <> (TYPEOF(h.orig_mname))'');
    populated_orig_mname_pcnt := AVE(GROUP,IF(h.orig_mname = (TYPEOF(h.orig_mname))'',0,100));
    maxlength_orig_mname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mname)));
    avelength_orig_mname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_mname)),h.orig_mname<>(typeof(h.orig_mname))'');
    populated_orig_lname_cnt := COUNT(GROUP,h.orig_lname <> (TYPEOF(h.orig_lname))'');
    populated_orig_lname_pcnt := AVE(GROUP,IF(h.orig_lname = (TYPEOF(h.orig_lname))'',0,100));
    maxlength_orig_lname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lname)));
    avelength_orig_lname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_lname)),h.orig_lname<>(typeof(h.orig_lname))'');
    populated_orig_addr_cnt := COUNT(GROUP,h.orig_addr <> (TYPEOF(h.orig_addr))'');
    populated_orig_addr_pcnt := AVE(GROUP,IF(h.orig_addr = (TYPEOF(h.orig_addr))'',0,100));
    maxlength_orig_addr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_addr)));
    avelength_orig_addr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_addr)),h.orig_addr<>(typeof(h.orig_addr))'');
    populated_orig_city_cnt := COUNT(GROUP,h.orig_city <> (TYPEOF(h.orig_city))'');
    populated_orig_city_pcnt := AVE(GROUP,IF(h.orig_city = (TYPEOF(h.orig_city))'',0,100));
    maxlength_orig_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)));
    avelength_orig_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_city)),h.orig_city<>(typeof(h.orig_city))'');
    populated_orig_state_cnt := COUNT(GROUP,h.orig_state <> (TYPEOF(h.orig_state))'');
    populated_orig_state_pcnt := AVE(GROUP,IF(h.orig_state = (TYPEOF(h.orig_state))'',0,100));
    maxlength_orig_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)));
    avelength_orig_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_state)),h.orig_state<>(typeof(h.orig_state))'');
    populated_orig_zip5_cnt := COUNT(GROUP,h.orig_zip5 <> (TYPEOF(h.orig_zip5))'');
    populated_orig_zip5_pcnt := AVE(GROUP,IF(h.orig_zip5 = (TYPEOF(h.orig_zip5))'',0,100));
    maxlength_orig_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip5)));
    avelength_orig_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip5)),h.orig_zip5<>(typeof(h.orig_zip5))'');
    populated_orig_zip4_cnt := COUNT(GROUP,h.orig_zip4 <> (TYPEOF(h.orig_zip4))'');
    populated_orig_zip4_pcnt := AVE(GROUP,IF(h.orig_zip4 = (TYPEOF(h.orig_zip4))'',0,100));
    maxlength_orig_zip4 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip4)));
    avelength_orig_zip4 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.orig_zip4)),h.orig_zip4<>(typeof(h.orig_zip4))'');
    populated_phone_home_cnt := COUNT(GROUP,h.phone_home <> (TYPEOF(h.phone_home))'');
    populated_phone_home_pcnt := AVE(GROUP,IF(h.phone_home = (TYPEOF(h.phone_home))'',0,100));
    maxlength_phone_home := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_home)));
    avelength_phone_home := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_home)),h.phone_home<>(typeof(h.phone_home))'');
    populated_phone_cell_cnt := COUNT(GROUP,h.phone_cell <> (TYPEOF(h.phone_cell))'');
    populated_phone_cell_pcnt := AVE(GROUP,IF(h.phone_cell = (TYPEOF(h.phone_cell))'',0,100));
    maxlength_phone_cell := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_cell)));
    avelength_phone_cell := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_cell)),h.phone_cell<>(typeof(h.phone_cell))'');
    populated_phone_work_cnt := COUNT(GROUP,h.phone_work <> (TYPEOF(h.phone_work))'');
    populated_phone_work_pcnt := AVE(GROUP,IF(h.phone_work = (TYPEOF(h.phone_work))'',0,100));
    maxlength_phone_work := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_work)));
    avelength_phone_work := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone_work)),h.phone_work<>(typeof(h.phone_work))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_employer_cnt := COUNT(GROUP,h.employer <> (TYPEOF(h.employer))'');
    populated_employer_pcnt := AVE(GROUP,IF(h.employer = (TYPEOF(h.employer))'',0,100));
    maxlength_employer := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.employer)));
    avelength_employer := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.employer)),h.employer<>(typeof(h.employer))'');
    populated_dt_cnt := COUNT(GROUP,h.dt <> (TYPEOF(h.dt))'');
    populated_dt_pcnt := AVE(GROUP,IF(h.dt = (TYPEOF(h.dt))'',0,100));
    maxlength_dt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt)));
    avelength_dt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dt)),h.dt<>(typeof(h.dt))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_orig_fname_pcnt *   0.00 / 100 + T.Populated_orig_mname_pcnt *   0.00 / 100 + T.Populated_orig_lname_pcnt *   0.00 / 100 + T.Populated_orig_addr_pcnt *   0.00 / 100 + T.Populated_orig_city_pcnt *   0.00 / 100 + T.Populated_orig_state_pcnt *   0.00 / 100 + T.Populated_orig_zip5_pcnt *   0.00 / 100 + T.Populated_orig_zip4_pcnt *   0.00 / 100 + T.Populated_phone_home_pcnt *   0.00 / 100 + T.Populated_phone_cell_pcnt *   0.00 / 100 + T.Populated_phone_work_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_employer_pcnt *   0.00 / 100 + T.Populated_dt_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'orig_fname','orig_mname','orig_lname','orig_addr','orig_city','orig_state','orig_zip5','orig_zip4','phone_home','phone_cell','phone_work','email','dob','employer','dt');
  SELF.populated_pcnt := CHOOSE(C,le.populated_orig_fname_pcnt,le.populated_orig_mname_pcnt,le.populated_orig_lname_pcnt,le.populated_orig_addr_pcnt,le.populated_orig_city_pcnt,le.populated_orig_state_pcnt,le.populated_orig_zip5_pcnt,le.populated_orig_zip4_pcnt,le.populated_phone_home_pcnt,le.populated_phone_cell_pcnt,le.populated_phone_work_pcnt,le.populated_email_pcnt,le.populated_dob_pcnt,le.populated_employer_pcnt,le.populated_dt_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_orig_fname,le.maxlength_orig_mname,le.maxlength_orig_lname,le.maxlength_orig_addr,le.maxlength_orig_city,le.maxlength_orig_state,le.maxlength_orig_zip5,le.maxlength_orig_zip4,le.maxlength_phone_home,le.maxlength_phone_cell,le.maxlength_phone_work,le.maxlength_email,le.maxlength_dob,le.maxlength_employer,le.maxlength_dt);
  SELF.avelength := CHOOSE(C,le.avelength_orig_fname,le.avelength_orig_mname,le.avelength_orig_lname,le.avelength_orig_addr,le.avelength_orig_city,le.avelength_orig_state,le.avelength_orig_zip5,le.avelength_orig_zip4,le.avelength_phone_home,le.avelength_phone_cell,le.avelength_phone_work,le.avelength_email,le.avelength_dob,le.avelength_employer,le.avelength_dt);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_addr),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip5),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.phone_home),TRIM((SALT311.StrType)le.phone_cell),TRIM((SALT311.StrType)le.phone_work),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.employer),TRIM((SALT311.StrType)le.dt)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_addr),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip5),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.phone_home),TRIM((SALT311.StrType)le.phone_cell),TRIM((SALT311.StrType)le.phone_work),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.employer),TRIM((SALT311.StrType)le.dt)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.orig_fname),TRIM((SALT311.StrType)le.orig_mname),TRIM((SALT311.StrType)le.orig_lname),TRIM((SALT311.StrType)le.orig_addr),TRIM((SALT311.StrType)le.orig_city),TRIM((SALT311.StrType)le.orig_state),TRIM((SALT311.StrType)le.orig_zip5),TRIM((SALT311.StrType)le.orig_zip4),TRIM((SALT311.StrType)le.phone_home),TRIM((SALT311.StrType)le.phone_cell),TRIM((SALT311.StrType)le.phone_work),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.dob),TRIM((SALT311.StrType)le.employer),TRIM((SALT311.StrType)le.dt)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'orig_fname'}
      ,{2,'orig_mname'}
      ,{3,'orig_lname'}
      ,{4,'orig_addr'}
      ,{5,'orig_city'}
      ,{6,'orig_state'}
      ,{7,'orig_zip5'}
      ,{8,'orig_zip4'}
      ,{9,'phone_home'}
      ,{10,'phone_cell'}
      ,{11,'phone_work'}
      ,{12,'email'}
      ,{13,'dob'}
      ,{14,'employer'}
      ,{15,'dt'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Input_PD_Fields.InValid_orig_fname((SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_mname,(SALT311.StrType)le.orig_lname),
    Input_PD_Fields.InValid_orig_mname((SALT311.StrType)le.orig_mname,(SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_mname,(SALT311.StrType)le.orig_lname),
    Input_PD_Fields.InValid_orig_lname((SALT311.StrType)le.orig_lname,(SALT311.StrType)le.orig_fname,(SALT311.StrType)le.orig_mname,(SALT311.StrType)le.orig_lname),
    Input_PD_Fields.InValid_orig_addr((SALT311.StrType)le.orig_addr),
    Input_PD_Fields.InValid_orig_city((SALT311.StrType)le.orig_city),
    Input_PD_Fields.InValid_orig_state((SALT311.StrType)le.orig_state),
    Input_PD_Fields.InValid_orig_zip5((SALT311.StrType)le.orig_zip5),
    Input_PD_Fields.InValid_orig_zip4((SALT311.StrType)le.orig_zip4),
    Input_PD_Fields.InValid_phone_home((SALT311.StrType)le.phone_home),
    Input_PD_Fields.InValid_phone_cell((SALT311.StrType)le.phone_cell),
    Input_PD_Fields.InValid_phone_work((SALT311.StrType)le.phone_work),
    Input_PD_Fields.InValid_email((SALT311.StrType)le.email),
    Input_PD_Fields.InValid_dob((SALT311.StrType)le.dob),
    Input_PD_Fields.InValid_employer((SALT311.StrType)le.employer),
    Input_PD_Fields.InValid_dt((SALT311.StrType)le.dt),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,15,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Input_PD_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_fname','invalid_mname','invalid_lname','invalid_addr','invalid_city','invalid_state','invalid_zip5','invalid_zip4','invalid_hmphone','invalid_cellphone','invalid_wrkphone','invalid_email','invalid_dob','invalid_employer','invalid_date');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Input_PD_Fields.InValidMessage_orig_fname(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_orig_mname(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_orig_lname(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_orig_addr(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_orig_city(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_orig_state(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_orig_zip5(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_orig_zip4(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_phone_home(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_phone_cell(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_phone_work(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_email(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_dob(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_employer(TotalErrors.ErrorNum),Input_PD_Fields.InValidMessage_dt(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_Thrive, Input_PD_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
