IMPORT SALT38,STD;
EXPORT hygiene(dataset(layout_RealSource) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT38.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_firstname_cnt := COUNT(GROUP,h.firstname <> (TYPEOF(h.firstname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middleinit_cnt := COUNT(GROUP,h.middleinit <> (TYPEOF(h.middleinit))'');
    populated_middleinit_pcnt := AVE(GROUP,IF(h.middleinit = (TYPEOF(h.middleinit))'',0,100));
    maxlength_middleinit := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.middleinit)));
    avelength_middleinit := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.middleinit)),h.middleinit<>(typeof(h.middleinit))'');
    populated_lastname_cnt := COUNT(GROUP,h.lastname <> (TYPEOF(h.lastname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_address_cnt := COUNT(GROUP,h.address <> (TYPEOF(h.address))'');
    populated_address_pcnt := AVE(GROUP,IF(h.address = (TYPEOF(h.address))'',0,100));
    maxlength_address := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.address)));
    avelength_address := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.address)),h.address<>(typeof(h.address))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zipcode_cnt := COUNT(GROUP,h.zipcode <> (TYPEOF(h.zipcode))'');
    populated_zipcode_pcnt := AVE(GROUP,IF(h.zipcode = (TYPEOF(h.zipcode))'',0,100));
    maxlength_zipcode := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zipcode)));
    avelength_zipcode := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zipcode)),h.zipcode<>(typeof(h.zipcode))'');
    populated_zipplus4_cnt := COUNT(GROUP,h.zipplus4 <> (TYPEOF(h.zipplus4))'');
    populated_zipplus4_pcnt := AVE(GROUP,IF(h.zipplus4 = (TYPEOF(h.zipplus4))'',0,100));
    maxlength_zipplus4 := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.zipplus4)));
    avelength_zipplus4 := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.zipplus4)),h.zipplus4<>(typeof(h.zipplus4))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_email_cnt := COUNT(GROUP,h.email <> (TYPEOF(h.email))'');
    populated_email_pcnt := AVE(GROUP,IF(h.email = (TYPEOF(h.email))'',0,100));
    maxlength_email := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.email)));
    avelength_email := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.email)),h.email<>(typeof(h.email))'');
    populated_ipaddr_cnt := COUNT(GROUP,h.ipaddr <> (TYPEOF(h.ipaddr))'');
    populated_ipaddr_pcnt := AVE(GROUP,IF(h.ipaddr = (TYPEOF(h.ipaddr))'',0,100));
    maxlength_ipaddr := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.ipaddr)));
    avelength_ipaddr := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.ipaddr)),h.ipaddr<>(typeof(h.ipaddr))'');
    populated_datestamp_cnt := COUNT(GROUP,h.datestamp <> (TYPEOF(h.datestamp))'');
    populated_datestamp_pcnt := AVE(GROUP,IF(h.datestamp = (TYPEOF(h.datestamp))'',0,100));
    maxlength_datestamp := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.datestamp)));
    avelength_datestamp := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.datestamp)),h.datestamp<>(typeof(h.datestamp))'');
    populated_url_cnt := COUNT(GROUP,h.url <> (TYPEOF(h.url))'');
    populated_url_pcnt := AVE(GROUP,IF(h.url = (TYPEOF(h.url))'',0,100));
    maxlength_url := MAX(GROUP,LENGTH(TRIM((SALT38.StrType)h.url)));
    avelength_url := AVE(GROUP,LENGTH(TRIM((SALT38.StrType)h.url)),h.url<>(typeof(h.url))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middleinit_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_address_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zipcode_pcnt *   0.00 / 100 + T.Populated_zipplus4_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_email_pcnt *   0.00 / 100 + T.Populated_ipaddr_pcnt *   0.00 / 100 + T.Populated_datestamp_pcnt *   0.00 / 100 + T.Populated_url_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'firstname','middleinit','lastname','suffix','address','city','state','zipcode','zipplus4','phone','dob','email','ipaddr','datestamp','url');
  SELF.populated_pcnt := CHOOSE(C,le.populated_firstname_pcnt,le.populated_middleinit_pcnt,le.populated_lastname_pcnt,le.populated_suffix_pcnt,le.populated_address_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zipcode_pcnt,le.populated_zipplus4_pcnt,le.populated_phone_pcnt,le.populated_dob_pcnt,le.populated_email_pcnt,le.populated_ipaddr_pcnt,le.populated_datestamp_pcnt,le.populated_url_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_firstname,le.maxlength_middleinit,le.maxlength_lastname,le.maxlength_suffix,le.maxlength_address,le.maxlength_city,le.maxlength_state,le.maxlength_zipcode,le.maxlength_zipplus4,le.maxlength_phone,le.maxlength_dob,le.maxlength_email,le.maxlength_ipaddr,le.maxlength_datestamp,le.maxlength_url);
  SELF.avelength := CHOOSE(C,le.avelength_firstname,le.avelength_middleinit,le.avelength_lastname,le.avelength_suffix,le.avelength_address,le.avelength_city,le.avelength_state,le.avelength_zipcode,le.avelength_zipplus4,le.avelength_phone,le.avelength_dob,le.avelength_email,le.avelength_ipaddr,le.avelength_datestamp,le.avelength_url);
END;
EXPORT invSummary := NORMALIZE(summary0, 15, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT38.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT38.StrType)le.firstname),TRIM((SALT38.StrType)le.middleinit),TRIM((SALT38.StrType)le.lastname),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zipcode),TRIM((SALT38.StrType)le.zipplus4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.email),TRIM((SALT38.StrType)le.ipaddr),TRIM((SALT38.StrType)le.datestamp),TRIM((SALT38.StrType)le.url)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,15,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT38.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 15);
  SELF.FldNo2 := 1 + (C % 15);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT38.StrType)le.firstname),TRIM((SALT38.StrType)le.middleinit),TRIM((SALT38.StrType)le.lastname),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zipcode),TRIM((SALT38.StrType)le.zipplus4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.email),TRIM((SALT38.StrType)le.ipaddr),TRIM((SALT38.StrType)le.datestamp),TRIM((SALT38.StrType)le.url)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT38.StrType)le.firstname),TRIM((SALT38.StrType)le.middleinit),TRIM((SALT38.StrType)le.lastname),TRIM((SALT38.StrType)le.suffix),TRIM((SALT38.StrType)le.address),TRIM((SALT38.StrType)le.city),TRIM((SALT38.StrType)le.state),TRIM((SALT38.StrType)le.zipcode),TRIM((SALT38.StrType)le.zipplus4),TRIM((SALT38.StrType)le.phone),TRIM((SALT38.StrType)le.dob),TRIM((SALT38.StrType)le.email),TRIM((SALT38.StrType)le.ipaddr),TRIM((SALT38.StrType)le.datestamp),TRIM((SALT38.StrType)le.url)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),15*15,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'firstname'}
      ,{2,'middleinit'}
      ,{3,'lastname'}
      ,{4,'suffix'}
      ,{5,'address'}
      ,{6,'city'}
      ,{7,'state'}
      ,{8,'zipcode'}
      ,{9,'zipplus4'}
      ,{10,'phone'}
      ,{11,'dob'}
      ,{12,'email'}
      ,{13,'ipaddr'}
      ,{14,'datestamp'}
      ,{15,'url'}],SALT38.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT38.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT38.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT38.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    Fields.InValid_firstname((SALT38.StrType)le.firstname),
    Fields.InValid_middleinit((SALT38.StrType)le.middleinit),
    Fields.InValid_lastname((SALT38.StrType)le.lastname),
    Fields.InValid_suffix((SALT38.StrType)le.suffix),
    Fields.InValid_address((SALT38.StrType)le.address),
    Fields.InValid_city((SALT38.StrType)le.city),
    Fields.InValid_state((SALT38.StrType)le.state),
    Fields.InValid_zipcode((SALT38.StrType)le.zipcode),
    Fields.InValid_zipplus4((SALT38.StrType)le.zipplus4),
    Fields.InValid_phone((SALT38.StrType)le.phone),
    Fields.InValid_dob((SALT38.StrType)le.dob),
    Fields.InValid_email((SALT38.StrType)le.email),
    Fields.InValid_ipaddr((SALT38.StrType)le.ipaddr),
    Fields.InValid_datestamp((SALT38.StrType)le.datestamp),
    Fields.InValid_url((SALT38.StrType)le.url),
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
  FieldNme := Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_name','invalid_name','invalid_name','invalid_suffix','invalid_alnum','invalid_alpha','invalid_state','invalid_zip5','invalid_zip4','invalid_phone','invalid_date','Unknown','Unknown','invalid_date','Unknown');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,Fields.InValidMessage_firstname(TotalErrors.ErrorNum),Fields.InValidMessage_middleinit(TotalErrors.ErrorNum),Fields.InValidMessage_lastname(TotalErrors.ErrorNum),Fields.InValidMessage_suffix(TotalErrors.ErrorNum),Fields.InValidMessage_address(TotalErrors.ErrorNum),Fields.InValidMessage_city(TotalErrors.ErrorNum),Fields.InValidMessage_state(TotalErrors.ErrorNum),Fields.InValidMessage_zipcode(TotalErrors.ErrorNum),Fields.InValidMessage_zipplus4(TotalErrors.ErrorNum),Fields.InValidMessage_phone(TotalErrors.ErrorNum),Fields.InValidMessage_dob(TotalErrors.ErrorNum),Fields.InValidMessage_email(TotalErrors.ErrorNum),Fields.InValidMessage_ipaddr(TotalErrors.ErrorNum),Fields.InValidMessage_datestamp(TotalErrors.ErrorNum),Fields.InValidMessage_url(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT38.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT38.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_RealSource, Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT38.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT38.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
