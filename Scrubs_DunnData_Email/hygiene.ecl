IMPORT SALT311,STD;
EXPORT hygiene(dataset(layout_DunnData_Email) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_dtmatch_cnt := COUNT(GROUP,h.dtmatch <> (TYPEOF(h.dtmatch))'');
    populated_dtmatch_pcnt := AVE(GROUP,IF(h.dtmatch = (TYPEOF(h.dtmatch))'',0,100));
    maxlength_dtmatch := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dtmatch)));
    avelength_dtmatch := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dtmatch)),h.dtmatch<>(typeof(h.dtmatch))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_name_full_cnt := COUNT(GROUP,h.name_full <> (TYPEOF(h.name_full))'');
    populated_name_full_pcnt := AVE(GROUP,IF(h.name_full = (TYPEOF(h.name_full))'',0,100));
    maxlength_name_full := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_full)));
    avelength_name_full := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.name_full)),h.name_full<>(typeof(h.name_full))'');
    populated_address1_cnt := COUNT(GROUP,h.address1 <> (TYPEOF(h.address1))'');
    populated_address1_pcnt := AVE(GROUP,IF(h.address1 = (TYPEOF(h.address1))'',0,100));
    maxlength_address1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)));
    avelength_address1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address1)),h.address1<>(typeof(h.address1))'');
    populated_address2_cnt := COUNT(GROUP,h.address2 <> (TYPEOF(h.address2))'');
    populated_address2_pcnt := AVE(GROUP,IF(h.address2 = (TYPEOF(h.address2))'',0,100));
    maxlength_address2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)));
    avelength_address2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.address2)),h.address2<>(typeof(h.address2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip5_cnt := COUNT(GROUP,h.zip5 <> (TYPEOF(h.zip5))'');
    populated_zip5_pcnt := AVE(GROUP,IF(h.zip5 = (TYPEOF(h.zip5))'',0,100));
    maxlength_zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5)));
    avelength_zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip5)),h.zip5<>(typeof(h.zip5))'');
    populated_zip_ext_cnt := COUNT(GROUP,h.zip_ext <> (TYPEOF(h.zip_ext))'');
    populated_zip_ext_pcnt := AVE(GROUP,IF(h.zip_ext = (TYPEOF(h.zip_ext))'',0,100));
    maxlength_zip_ext := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_ext)));
    avelength_zip_ext := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip_ext)),h.zip_ext<>(typeof(h.zip_ext))'');
    populated_ipaddr_cnt := COUNT(GROUP,h.ipaddr <> (TYPEOF(h.ipaddr))'');
    populated_ipaddr_pcnt := AVE(GROUP,IF(h.ipaddr = (TYPEOF(h.ipaddr))'',0,100));
    maxlength_ipaddr := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ipaddr)));
    avelength_ipaddr := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ipaddr)),h.ipaddr<>(typeof(h.ipaddr))'');
    populated_datestamp_cnt := COUNT(GROUP,h.datestamp <> (TYPEOF(h.datestamp))'');
    populated_datestamp_pcnt := AVE(GROUP,IF(h.datestamp = (TYPEOF(h.datestamp))'',0,100));
    maxlength_datestamp := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.datestamp)));
    avelength_datestamp := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.datestamp)),h.datestamp<>(typeof(h.datestamp))'');
    populated_url_cnt := COUNT(GROUP,h.url <> (TYPEOF(h.url))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.url)),h.url<>(typeof(h.url))'');
    populated_lastdate_cnt := COUNT(GROUP,h.lastdate <> (TYPEOF(h.lastdate))'');
    populated_lastdate_pcnt := AVE(GROUP,IF(h.lastdate = (TYPEOF(h.lastdate))'',0,100));
    maxlength_lastdate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdate)));
    avelength_lastdate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastdate)),h.lastdate<>(typeof(h.lastdate))'');
    populated_em_src_cnt_cnt := COUNT(GROUP,h.em_src_cnt <> (TYPEOF(h.em_src_cnt))'');
    populated_em_src_cnt_pcnt := AVE(GROUP,IF(h.em_src_cnt = (TYPEOF(h.em_src_cnt))'',0,100));
    maxlength_em_src_cnt := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.em_src_cnt)));
    avelength_em_src_cnt := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.em_src_cnt)),h.em_src_cnt<>(typeof(h.em_src_cnt))'');
    populated_num_emails_cnt := COUNT(GROUP,h.num_emails <> (TYPEOF(h.num_emails))'');
    populated_num_emails_pcnt := AVE(GROUP,IF(h.num_emails = (TYPEOF(h.num_emails))'',0,100));
    maxlength_num_emails := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_emails)));
    avelength_num_emails := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_emails)),h.num_emails<>(typeof(h.num_emails))'');
    populated_num_indiv_cnt := COUNT(GROUP,h.num_indiv <> (TYPEOF(h.num_indiv))'');
    populated_num_indiv_pcnt := AVE(GROUP,IF(h.num_indiv = (TYPEOF(h.num_indiv))'',0,100));
    maxlength_num_indiv := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_indiv)));
    avelength_num_indiv := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.num_indiv)),h.num_indiv<>(typeof(h.num_indiv))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_dtmatch_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_name_full_pcnt *   0.00 / 100 + T.Populated_address1_pcnt *   0.00 / 100 + T.Populated_address2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip5_pcnt *   0.00 / 100 + T.Populated_zip_ext_pcnt *   0.00 / 100 + T.Populated_ipaddr_pcnt *   0.00 / 100 + T.Populated_datestamp_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100 + T.Populated_lastdate_pcnt *   0.00 / 100 + T.Populated_em_src_cnt_pcnt *   0.00 / 100 + T.Populated_num_emails_pcnt *   0.00 / 100 + T.Populated_num_indiv_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'dtmatch','email','name_full','address1','address2','city','state','zip5','zip_ext','ipaddr','datestamp','url','lastdate','em_src_cnt','num_emails','num_indiv');
  SELF.populated_pcnt := CHOOSE(C,le.populated_dtmatch_pcnt,le.populated_email_pcnt,le.populated_name_full_pcnt,le.populated_address1_pcnt,le.populated_address2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip5_pcnt,le.populated_zip_ext_pcnt,le.populated_ipaddr_pcnt,le.populated_datestamp_pcnt,le.populated_url_pcnt,le.populated_lastdate_pcnt,le.populated_em_src_cnt_pcnt,le.populated_num_emails_pcnt,le.populated_num_indiv_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_dtmatch,le.maxlength_email,le.maxlength_name_full,le.maxlength_address1,le.maxlength_address2,le.maxlength_city,le.maxlength_state,le.maxlength_zip5,le.maxlength_zip_ext,le.maxlength_ipaddr,le.maxlength_datestamp,le.maxlength_url,le.maxlength_lastdate,le.maxlength_em_src_cnt,le.maxlength_num_emails,le.maxlength_num_indiv);
  SELF.avelength := CHOOSE(C,le.avelength_dtmatch,le.avelength_email,le.avelength_name_full,le.avelength_address1,le.avelength_address2,le.avelength_city,le.avelength_state,le.avelength_zip5,le.avelength_zip_ext,le.avelength_ipaddr,le.avelength_datestamp,le.avelength_url,le.avelength_lastdate,le.avelength_em_src_cnt,le.avelength_num_emails,le.avelength_num_indiv);
END;
EXPORT invSummary := NORMALIZE(summary0, 16, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.dtmatch),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.name_full),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip_ext),TRIM((SALT311.StrType)le.ipaddr),TRIM((SALT311.StrType)le.datestamp),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.lastdate),TRIM((SALT311.StrType)le.em_src_cnt),TRIM((SALT311.StrType)le.num_emails),TRIM((SALT311.StrType)le.num_indiv)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,16,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 16);
  SELF.FldNo2 := 1 + (C % 16);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.dtmatch),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.name_full),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip_ext),TRIM((SALT311.StrType)le.ipaddr),TRIM((SALT311.StrType)le.datestamp),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.lastdate),TRIM((SALT311.StrType)le.em_src_cnt),TRIM((SALT311.StrType)le.num_emails),TRIM((SALT311.StrType)le.num_indiv)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.dtmatch),TRIM((SALT311.StrType)le.email),TRIM((SALT311.StrType)le.name_full),TRIM((SALT311.StrType)le.address1),TRIM((SALT311.StrType)le.address2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),TRIM((SALT311.StrType)le.zip5),TRIM((SALT311.StrType)le.zip_ext),TRIM((SALT311.StrType)le.ipaddr),TRIM((SALT311.StrType)le.datestamp),TRIM((SALT311.StrType)le.url),TRIM((SALT311.StrType)le.lastdate),TRIM((SALT311.StrType)le.em_src_cnt),TRIM((SALT311.StrType)le.num_emails),TRIM((SALT311.StrType)le.num_indiv)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),16*16,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'dtmatch'}
      ,{2,'email'}
      ,{3,'name_full'}
      ,{4,'address1'}
      ,{5,'address2'}
      ,{6,'city'}
      ,{7,'state'}
      ,{8,'zip5'}
      ,{9,'zip_ext'}
      ,{10,'ipaddr'}
      ,{11,'datestamp'}
      ,{12,'url'}
      ,{13,'lastdate'}
      ,{14,'em_src_cnt'}
      ,{15,'num_emails'}
      ,{16,'num_indiv'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_dtmatch((SALT311.StrType)le.dtmatch),
    Fields.InValid_email((SALT311.StrType)le.email),
    Fields.InValid_name_full((SALT311.StrType)le.name_full),
    Fields.InValid_address1((SALT311.StrType)le.address1),
    Fields.InValid_address2((SALT311.StrType)le.address2),
    Fields.InValid_city((SALT311.StrType)le.city),
    Fields.InValid_state((SALT311.StrType)le.state),
    Fields.InValid_zip5((SALT311.StrType)le.zip5),
    Fields.InValid_zip_ext((SALT311.StrType)le.zip_ext),
    Fields.InValid_ipaddr((SALT311.StrType)le.ipaddr),
    Fields.InValid_datestamp((SALT311.StrType)le.datestamp),
    Fields.InValid_url((SALT311.StrType)le.url),
    Fields.InValid_lastdate((SALT311.StrType)le.lastdate),
    Fields.InValid_em_src_cnt((SALT311.StrType)le.em_src_cnt),
    Fields.InValid_num_emails((SALT311.StrType)le.num_emails),
    Fields.InValid_num_indiv((SALT311.StrType)le.num_indiv),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,16,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Unknown','Unknown','invalid_name','invalid_address1','invalid_address2','invalid_city','invalid_state','invalid_zip','Unknown','invalid_ip','invalid_datestamp','invalid_url','invalid_lastdate','Unknown','Unknown','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_dtmatch(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_name_full(TotalErrors.ErrorNum),Fields.InValidMessage_address1(TotalErrors.ErrorNum),Fields.InValidMessage_address2(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zip5(TotalErrors.ErrorNum),Fields.InValidMessage_zip_ext(TotalErrors.ErrorNum),Fields.InValidMessage_ipaddr(TotalErrors.ErrorNum),Fields.InValidMessage_datestamp(TotalErrors.ErrorNum),Fields.InValidMessage_url(TotalErrors.ErrorNum),Fields.InValidMessage_lastdate(TotalErrors.ErrorNum),Fields.InValidMessage_em_src_cnt(TotalErrors.ErrorNum),Fields.InValidMessage_num_emails(TotalErrors.ErrorNum),Fields.InValidMessage_num_indiv(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_DunnData_Email, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
