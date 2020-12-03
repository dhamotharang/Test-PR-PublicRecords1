IMPORT SALT311,STD;
EXPORT RawInput_hygiene(dataset(RawInput_layout_IDA) h) := MODULE

//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_firstname_cnt := COUNT(GROUP,h.firstname <> (TYPEOF(h.firstname))'');
    populated_firstname_pcnt := AVE(GROUP,IF(h.firstname = (TYPEOF(h.firstname))'',0,100));
    maxlength_firstname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)));
    avelength_firstname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.firstname)),h.firstname<>(typeof(h.firstname))'');
    populated_middlename_cnt := COUNT(GROUP,h.middlename <> (TYPEOF(h.middlename))'');
    populated_middlename_pcnt := AVE(GROUP,IF(h.middlename = (TYPEOF(h.middlename))'',0,100));
    maxlength_middlename := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.middlename)));
    avelength_middlename := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.middlename)),h.middlename<>(typeof(h.middlename))'');
    populated_lastname_cnt := COUNT(GROUP,h.lastname <> (TYPEOF(h.lastname))'');
    populated_lastname_pcnt := AVE(GROUP,IF(h.lastname = (TYPEOF(h.lastname))'',0,100));
    maxlength_lastname := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)));
    avelength_lastname := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.lastname)),h.lastname<>(typeof(h.lastname))'');
    populated_suffix_cnt := COUNT(GROUP,h.suffix <> (TYPEOF(h.suffix))'');
    populated_suffix_pcnt := AVE(GROUP,IF(h.suffix = (TYPEOF(h.suffix))'',0,100));
    maxlength_suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)));
    avelength_suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.suffix)),h.suffix<>(typeof(h.suffix))'');
    populated_addressline1_cnt := COUNT(GROUP,h.addressline1 <> (TYPEOF(h.addressline1))'');
    populated_addressline1_pcnt := AVE(GROUP,IF(h.addressline1 = (TYPEOF(h.addressline1))'',0,100));
    maxlength_addressline1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline1)));
    avelength_addressline1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline1)),h.addressline1<>(typeof(h.addressline1))'');
    populated_addressline2_cnt := COUNT(GROUP,h.addressline2 <> (TYPEOF(h.addressline2))'');
    populated_addressline2_pcnt := AVE(GROUP,IF(h.addressline2 = (TYPEOF(h.addressline2))'',0,100));
    maxlength_addressline2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline2)));
    avelength_addressline2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.addressline2)),h.addressline2<>(typeof(h.addressline2))'');
    populated_city_cnt := COUNT(GROUP,h.city <> (TYPEOF(h.city))'');
    populated_city_pcnt := AVE(GROUP,IF(h.city = (TYPEOF(h.city))'',0,100));
    maxlength_city := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)));
    avelength_city := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.city)),h.city<>(typeof(h.city))'');
    populated_state_cnt := COUNT(GROUP,h.state <> (TYPEOF(h.state))'');
    populated_state_pcnt := AVE(GROUP,IF(h.state = (TYPEOF(h.state))'',0,100));
    maxlength_state := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)));
    avelength_state := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.state)),h.state<>(typeof(h.state))'');
    populated_zip_cnt := COUNT(GROUP,h.zip <> (TYPEOF(h.zip))'');
    populated_zip_pcnt := AVE(GROUP,IF(h.zip = (TYPEOF(h.zip))'',0,100));
    maxlength_zip := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)));
    avelength_zip := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.zip)),h.zip<>(typeof(h.zip))'');
    populated_dob_cnt := COUNT(GROUP,h.dob <> (TYPEOF(h.dob))'');
    populated_dob_pcnt := AVE(GROUP,IF(h.dob = (TYPEOF(h.dob))'',0,100));
    maxlength_dob := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)));
    avelength_dob := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dob)),h.dob<>(typeof(h.dob))'');
    populated_ssn_cnt := COUNT(GROUP,h.ssn <> (TYPEOF(h.ssn))'');
    populated_ssn_pcnt := AVE(GROUP,IF(h.ssn = (TYPEOF(h.ssn))'',0,100));
    maxlength_ssn := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)));
    avelength_ssn := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ssn)),h.ssn<>(typeof(h.ssn))'');
    populated_dl_cnt := COUNT(GROUP,h.dl <> (TYPEOF(h.dl))'');
    populated_dl_pcnt := AVE(GROUP,IF(h.dl = (TYPEOF(h.dl))'',0,100));
    maxlength_dl := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl)));
    avelength_dl := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dl)),h.dl<>(typeof(h.dl))'');
    populated_dlstate_cnt := COUNT(GROUP,h.dlstate <> (TYPEOF(h.dlstate))'');
    populated_dlstate_pcnt := AVE(GROUP,IF(h.dlstate = (TYPEOF(h.dlstate))'',0,100));
    maxlength_dlstate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.dlstate)));
    avelength_dlstate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.dlstate)),h.dlstate<>(typeof(h.dlstate))'');
    populated_phone_cnt := COUNT(GROUP,h.phone <> (TYPEOF(h.phone))'');
    populated_phone_pcnt := AVE(GROUP,IF(h.phone = (TYPEOF(h.phone))'',0,100));
    maxlength_phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)));
    avelength_phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.phone)),h.phone<>(typeof(h.phone))'');
    populated_clientassigneduniquerecordid_cnt := COUNT(GROUP,h.clientassigneduniquerecordid <> (TYPEOF(h.clientassigneduniquerecordid))'');
    populated_clientassigneduniquerecordid_pcnt := AVE(GROUP,IF(h.clientassigneduniquerecordid = (TYPEOF(h.clientassigneduniquerecordid))'',0,100));
    maxlength_clientassigneduniquerecordid := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.clientassigneduniquerecordid)));
    avelength_clientassigneduniquerecordid := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.clientassigneduniquerecordid)),h.clientassigneduniquerecordid<>(typeof(h.clientassigneduniquerecordid))'');
    populated_emailaddress_cnt := COUNT(GROUP,h.emailaddress <> (TYPEOF(h.emailaddress))'');
    populated_emailaddress_pcnt := AVE(GROUP,IF(h.emailaddress = (TYPEOF(h.emailaddress))'',0,100));
    maxlength_emailaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.emailaddress)));
    avelength_emailaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.emailaddress)),h.emailaddress<>(typeof(h.emailaddress))'');
    populated_ipaddress_cnt := COUNT(GROUP,h.ipaddress <> (TYPEOF(h.ipaddress))'');
    populated_ipaddress_pcnt := AVE(GROUP,IF(h.ipaddress = (TYPEOF(h.ipaddress))'',0,100));
    maxlength_ipaddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ipaddress)));
    avelength_ipaddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ipaddress)),h.ipaddress<>(typeof(h.ipaddress))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_firstname_pcnt *   0.00 / 100 + T.Populated_middlename_pcnt *   0.00 / 100 + T.Populated_lastname_pcnt *   0.00 / 100 + T.Populated_suffix_pcnt *   0.00 / 100 + T.Populated_addressline1_pcnt *   0.00 / 100 + T.Populated_addressline2_pcnt *   0.00 / 100 + T.Populated_city_pcnt *   0.00 / 100 + T.Populated_state_pcnt *   0.00 / 100 + T.Populated_zip_pcnt *   0.00 / 100 + T.Populated_dob_pcnt *   0.00 / 100 + T.Populated_ssn_pcnt *   0.00 / 100 + T.Populated_dl_pcnt *   0.00 / 100 + T.Populated_dlstate_pcnt *   0.00 / 100 + T.Populated_phone_pcnt *   0.00 / 100 + T.Populated_clientassigneduniquerecordid_pcnt *   0.00 / 100 + T.Populated_emailaddress_pcnt *   0.00 / 100 + T.Populated_ipaddress_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'firstname','middlename','lastname','suffix','addressline1','addressline2','city','state','zip','dob','ssn','dl','dlstate','phone','clientassigneduniquerecordid','emailaddress','ipaddress');
  SELF.populated_pcnt := CHOOSE(C,le.populated_firstname_pcnt,le.populated_middlename_pcnt,le.populated_lastname_pcnt,le.populated_suffix_pcnt,le.populated_addressline1_pcnt,le.populated_addressline2_pcnt,le.populated_city_pcnt,le.populated_state_pcnt,le.populated_zip_pcnt,le.populated_dob_pcnt,le.populated_ssn_pcnt,le.populated_dl_pcnt,le.populated_dlstate_pcnt,le.populated_phone_pcnt,le.populated_clientassigneduniquerecordid_pcnt,le.populated_emailaddress_pcnt,le.populated_ipaddress_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_firstname,le.maxlength_middlename,le.maxlength_lastname,le.maxlength_suffix,le.maxlength_addressline1,le.maxlength_addressline2,le.maxlength_city,le.maxlength_state,le.maxlength_zip,le.maxlength_dob,le.maxlength_ssn,le.maxlength_dl,le.maxlength_dlstate,le.maxlength_phone,le.maxlength_clientassigneduniquerecordid,le.maxlength_emailaddress,le.maxlength_ipaddress);
  SELF.avelength := CHOOSE(C,le.avelength_firstname,le.avelength_middlename,le.avelength_lastname,le.avelength_suffix,le.avelength_addressline1,le.avelength_addressline2,le.avelength_city,le.avelength_state,le.avelength_zip,le.avelength_dob,le.avelength_ssn,le.avelength_dl,le.avelength_dlstate,le.avelength_phone,le.avelength_clientassigneduniquerecordid,le.avelength_emailaddress,le.avelength_ipaddress);
END;
EXPORT invSummary := NORMALIZE(summary0, 17, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.addressline1),TRIM((SALT311.StrType)le.addressline2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),IF (le.zip <> 0,TRIM((SALT311.StrType)le.zip), ''),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dl),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),IF (le.clientassigneduniquerecordid <> 0,TRIM((SALT311.StrType)le.clientassigneduniquerecordid), ''),TRIM((SALT311.StrType)le.emailaddress),TRIM((SALT311.StrType)le.ipaddress)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,17,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 17);
  SELF.FldNo2 := 1 + (C % 17);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.addressline1),TRIM((SALT311.StrType)le.addressline2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),IF (le.zip <> 0,TRIM((SALT311.StrType)le.zip), ''),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dl),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),IF (le.clientassigneduniquerecordid <> 0,TRIM((SALT311.StrType)le.clientassigneduniquerecordid), ''),TRIM((SALT311.StrType)le.emailaddress),TRIM((SALT311.StrType)le.ipaddress)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.firstname),TRIM((SALT311.StrType)le.middlename),TRIM((SALT311.StrType)le.lastname),TRIM((SALT311.StrType)le.suffix),TRIM((SALT311.StrType)le.addressline1),TRIM((SALT311.StrType)le.addressline2),TRIM((SALT311.StrType)le.city),TRIM((SALT311.StrType)le.state),IF (le.zip <> 0,TRIM((SALT311.StrType)le.zip), ''),IF (le.dob <> 0,TRIM((SALT311.StrType)le.dob), ''),TRIM((SALT311.StrType)le.ssn),TRIM((SALT311.StrType)le.dl),TRIM((SALT311.StrType)le.dlstate),TRIM((SALT311.StrType)le.phone),IF (le.clientassigneduniquerecordid <> 0,TRIM((SALT311.StrType)le.clientassigneduniquerecordid), ''),TRIM((SALT311.StrType)le.emailaddress),TRIM((SALT311.StrType)le.ipaddress)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),17*17,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'firstname'}
      ,{2,'middlename'}
      ,{3,'lastname'}
      ,{4,'suffix'}
      ,{5,'addressline1'}
      ,{6,'addressline2'}
      ,{7,'city'}
      ,{8,'state'}
      ,{9,'zip'}
      ,{10,'dob'}
      ,{11,'ssn'}
      ,{12,'dl'}
      ,{13,'dlstate'}
      ,{14,'phone'}
      ,{15,'clientassigneduniquerecordid'}
      ,{16,'emailaddress'}
      ,{17,'ipaddress'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);

EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);

EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);


ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    RawInput_Fields.InValid_firstname((SALT311.StrType)le.firstname),
    RawInput_Fields.InValid_middlename((SALT311.StrType)le.middlename),
    RawInput_Fields.InValid_lastname((SALT311.StrType)le.lastname),
    RawInput_Fields.InValid_suffix((SALT311.StrType)le.suffix),
    RawInput_Fields.InValid_addressline1((SALT311.StrType)le.addressline1),
    RawInput_Fields.InValid_addressline2((SALT311.StrType)le.addressline2),
    RawInput_Fields.InValid_city((SALT311.StrType)le.city),
    RawInput_Fields.InValid_state((SALT311.StrType)le.state),
    RawInput_Fields.InValid_zip((SALT311.StrType)le.zip),
    RawInput_Fields.InValid_dob((SALT311.StrType)le.dob),
    RawInput_Fields.InValid_ssn((SALT311.StrType)le.ssn),
    RawInput_Fields.InValid_dl((SALT311.StrType)le.dl),
    RawInput_Fields.InValid_dlstate((SALT311.StrType)le.dlstate),
    RawInput_Fields.InValid_phone((SALT311.StrType)le.phone),
    RawInput_Fields.InValid_clientassigneduniquerecordid((SALT311.StrType)le.clientassigneduniquerecordid),
    RawInput_Fields.InValid_emailaddress((SALT311.StrType)le.emailaddress),
    RawInput_Fields.InValid_ipaddress((SALT311.StrType)le.ipaddress),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,17,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := RawInput_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'Invalid_FName','Invalid_MName','Invalid_LName','Invalid_Suffix','Invalid_Address1','Invalid_Address2','Invalid_City','Invalid_State','Invalid_Zip','Invalid_DOB','Invalid_SSN','Invalid_DL','Invalid_State','Invalid_Phone','Invalid_Clientassigneduniquerecordid','Invalid_Emailaddress','Invalid_Ipaddress');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,RawInput_Fields.InValidMessage_firstname(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_middlename(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_lastname(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_suffix(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_addressline1(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_addressline2(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_city(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_state(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_zip(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_dob(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_ssn(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_dl(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_dlstate(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_phone(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_clientassigneduniquerecordid(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_emailaddress(TotalErrors.ErrorNum),RawInput_Fields.InValidMessage_ipaddress(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');

  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_IDA, RawInput_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);

  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));

  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
