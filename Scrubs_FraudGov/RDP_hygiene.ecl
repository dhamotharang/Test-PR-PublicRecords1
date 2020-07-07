IMPORT SALT311,STD;
EXPORT RDP_hygiene(dataset(RDP_layout_RDP) h) := MODULE
 
//A simple summary record
EXPORT Summary(SALT311.Str30Type  txt) := FUNCTION
  SummaryLayout := RECORD
    txt;
    NumberOfRecords := COUNT(GROUP);
    populated_Transaction_ID_cnt := COUNT(GROUP,h.Transaction_ID <> (TYPEOF(h.Transaction_ID))'');
    populated_Transaction_ID_pcnt := AVE(GROUP,IF(h.Transaction_ID = (TYPEOF(h.Transaction_ID))'',0,100));
    maxlength_Transaction_ID := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Transaction_ID)));
    avelength_Transaction_ID := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Transaction_ID)),h.Transaction_ID<>(typeof(h.Transaction_ID))'');
    populated_TransactionDate_cnt := COUNT(GROUP,h.TransactionDate <> (TYPEOF(h.TransactionDate))'');
    populated_TransactionDate_pcnt := AVE(GROUP,IF(h.TransactionDate = (TYPEOF(h.TransactionDate))'',0,100));
    maxlength_TransactionDate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.TransactionDate)));
    avelength_TransactionDate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.TransactionDate)),h.TransactionDate<>(typeof(h.TransactionDate))'');
    populated_FirstName_cnt := COUNT(GROUP,h.FirstName <> (TYPEOF(h.FirstName))'');
    populated_FirstName_pcnt := AVE(GROUP,IF(h.FirstName = (TYPEOF(h.FirstName))'',0,100));
    maxlength_FirstName := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.FirstName)));
    avelength_FirstName := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.FirstName)),h.FirstName<>(typeof(h.FirstName))'');
    populated_LastName_cnt := COUNT(GROUP,h.LastName <> (TYPEOF(h.LastName))'');
    populated_LastName_pcnt := AVE(GROUP,IF(h.LastName = (TYPEOF(h.LastName))'',0,100));
    maxlength_LastName := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.LastName)));
    avelength_LastName := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.LastName)),h.LastName<>(typeof(h.LastName))'');
    populated_MiddleName_cnt := COUNT(GROUP,h.MiddleName <> (TYPEOF(h.MiddleName))'');
    populated_MiddleName_pcnt := AVE(GROUP,IF(h.MiddleName = (TYPEOF(h.MiddleName))'',0,100));
    maxlength_MiddleName := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.MiddleName)));
    avelength_MiddleName := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.MiddleName)),h.MiddleName<>(typeof(h.MiddleName))'');
    populated_Suffix_cnt := COUNT(GROUP,h.Suffix <> (TYPEOF(h.Suffix))'');
    populated_Suffix_pcnt := AVE(GROUP,IF(h.Suffix = (TYPEOF(h.Suffix))'',0,100));
    maxlength_Suffix := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Suffix)));
    avelength_Suffix := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Suffix)),h.Suffix<>(typeof(h.Suffix))'');
    populated_BirthDate_cnt := COUNT(GROUP,h.BirthDate <> (TYPEOF(h.BirthDate))'');
    populated_BirthDate_pcnt := AVE(GROUP,IF(h.BirthDate = (TYPEOF(h.BirthDate))'',0,100));
    maxlength_BirthDate := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.BirthDate)));
    avelength_BirthDate := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.BirthDate)),h.BirthDate<>(typeof(h.BirthDate))'');
    populated_SSN_cnt := COUNT(GROUP,h.SSN <> (TYPEOF(h.SSN))'');
    populated_SSN_pcnt := AVE(GROUP,IF(h.SSN = (TYPEOF(h.SSN))'',0,100));
    maxlength_SSN := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.SSN)));
    avelength_SSN := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.SSN)),h.SSN<>(typeof(h.SSN))'');
    populated_Lexid_Input_cnt := COUNT(GROUP,h.Lexid_Input <> (TYPEOF(h.Lexid_Input))'');
    populated_Lexid_Input_pcnt := AVE(GROUP,IF(h.Lexid_Input = (TYPEOF(h.Lexid_Input))'',0,100));
    maxlength_Lexid_Input := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Lexid_Input)));
    avelength_Lexid_Input := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Lexid_Input)),h.Lexid_Input<>(typeof(h.Lexid_Input))'');
    populated_Street1_cnt := COUNT(GROUP,h.Street1 <> (TYPEOF(h.Street1))'');
    populated_Street1_pcnt := AVE(GROUP,IF(h.Street1 = (TYPEOF(h.Street1))'',0,100));
    maxlength_Street1 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Street1)));
    avelength_Street1 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Street1)),h.Street1<>(typeof(h.Street1))'');
    populated_Street2_cnt := COUNT(GROUP,h.Street2 <> (TYPEOF(h.Street2))'');
    populated_Street2_pcnt := AVE(GROUP,IF(h.Street2 = (TYPEOF(h.Street2))'',0,100));
    maxlength_Street2 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Street2)));
    avelength_Street2 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Street2)),h.Street2<>(typeof(h.Street2))'');
    populated_Suite_cnt := COUNT(GROUP,h.Suite <> (TYPEOF(h.Suite))'');
    populated_Suite_pcnt := AVE(GROUP,IF(h.Suite = (TYPEOF(h.Suite))'',0,100));
    maxlength_Suite := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Suite)));
    avelength_Suite := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Suite)),h.Suite<>(typeof(h.Suite))'');
    populated_City_cnt := COUNT(GROUP,h.City <> (TYPEOF(h.City))'');
    populated_City_pcnt := AVE(GROUP,IF(h.City = (TYPEOF(h.City))'',0,100));
    maxlength_City := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.City)));
    avelength_City := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.City)),h.City<>(typeof(h.City))'');
    populated_State_cnt := COUNT(GROUP,h.State <> (TYPEOF(h.State))'');
    populated_State_pcnt := AVE(GROUP,IF(h.State = (TYPEOF(h.State))'',0,100));
    maxlength_State := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.State)));
    avelength_State := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.State)),h.State<>(typeof(h.State))'');
    populated_Zip5_cnt := COUNT(GROUP,h.Zip5 <> (TYPEOF(h.Zip5))'');
    populated_Zip5_pcnt := AVE(GROUP,IF(h.Zip5 = (TYPEOF(h.Zip5))'',0,100));
    maxlength_Zip5 := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Zip5)));
    avelength_Zip5 := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Zip5)),h.Zip5<>(typeof(h.Zip5))'');
    populated_Phone_cnt := COUNT(GROUP,h.Phone <> (TYPEOF(h.Phone))'');
    populated_Phone_pcnt := AVE(GROUP,IF(h.Phone = (TYPEOF(h.Phone))'',0,100));
    maxlength_Phone := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Phone)));
    avelength_Phone := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Phone)),h.Phone<>(typeof(h.Phone))'');
    populated_Lexid_Discovered_cnt := COUNT(GROUP,h.Lexid_Discovered <> (TYPEOF(h.Lexid_Discovered))'');
    populated_Lexid_Discovered_pcnt := AVE(GROUP,IF(h.Lexid_Discovered = (TYPEOF(h.Lexid_Discovered))'',0,100));
    maxlength_Lexid_Discovered := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Lexid_Discovered)));
    avelength_Lexid_Discovered := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Lexid_Discovered)),h.Lexid_Discovered<>(typeof(h.Lexid_Discovered))'');
    populated_RemoteIPAddress_cnt := COUNT(GROUP,h.RemoteIPAddress <> (TYPEOF(h.RemoteIPAddress))'');
    populated_RemoteIPAddress_pcnt := AVE(GROUP,IF(h.RemoteIPAddress = (TYPEOF(h.RemoteIPAddress))'',0,100));
    maxlength_RemoteIPAddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.RemoteIPAddress)));
    avelength_RemoteIPAddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.RemoteIPAddress)),h.RemoteIPAddress<>(typeof(h.RemoteIPAddress))'');
    populated_ConsumerIPAddress_cnt := COUNT(GROUP,h.ConsumerIPAddress <> (TYPEOF(h.ConsumerIPAddress))'');
    populated_ConsumerIPAddress_pcnt := AVE(GROUP,IF(h.ConsumerIPAddress = (TYPEOF(h.ConsumerIPAddress))'',0,100));
    maxlength_ConsumerIPAddress := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.ConsumerIPAddress)));
    avelength_ConsumerIPAddress := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.ConsumerIPAddress)),h.ConsumerIPAddress<>(typeof(h.ConsumerIPAddress))'');
    populated_Email_Address_cnt := COUNT(GROUP,h.Email_Address <> (TYPEOF(h.Email_Address))'');
    populated_Email_Address_pcnt := AVE(GROUP,IF(h.Email_Address = (TYPEOF(h.Email_Address))'',0,100));
    maxlength_Email_Address := MAX(GROUP,LENGTH(TRIM((SALT311.StrType)h.Email_Address)));
    avelength_Email_Address := AVE(GROUP,LENGTH(TRIM((SALT311.StrType)h.Email_Address)),h.Email_Address<>(typeof(h.Email_Address))'');
  END;
    T := TABLE(h,SummaryLayout);
  R1 := RECORD
    UNSIGNED LinkingPotential :=  + T.Populated_Transaction_ID_pcnt *   0.00 / 100 + T.Populated_TransactionDate_pcnt *   0.00 / 100 + T.Populated_FirstName_pcnt *   0.00 / 100 + T.Populated_LastName_pcnt *   0.00 / 100 + T.Populated_MiddleName_pcnt *   0.00 / 100 + T.Populated_Suffix_pcnt *   0.00 / 100 + T.Populated_BirthDate_pcnt *   0.00 / 100 + T.Populated_SSN_pcnt *   0.00 / 100 + T.Populated_Lexid_Input_pcnt *   0.00 / 100 + T.Populated_Street1_pcnt *   0.00 / 100 + T.Populated_Street2_pcnt *   0.00 / 100 + T.Populated_Suite_pcnt *   0.00 / 100 + T.Populated_City_pcnt *   0.00 / 100 + T.Populated_State_pcnt *   0.00 / 100 + T.Populated_Zip5_pcnt *   0.00 / 100 + T.Populated_Phone_pcnt *   0.00 / 100 + T.Populated_Lexid_Discovered_pcnt *   0.00 / 100 + T.Populated_RemoteIPAddress_pcnt *   0.00 / 100 + T.Populated_ConsumerIPAddress_pcnt *   0.00 / 100 + T.Populated_Email_Address_pcnt *   0.00 / 100;
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
  SELF.FieldName := CHOOSE(C,'Transaction_ID','TransactionDate','FirstName','LastName','MiddleName','Suffix','BirthDate','SSN','Lexid_Input','Street1','Street2','Suite','City','State','Zip5','Phone','Lexid_Discovered','RemoteIPAddress','ConsumerIPAddress','Email_Address');
  SELF.populated_pcnt := CHOOSE(C,le.populated_Transaction_ID_pcnt,le.populated_TransactionDate_pcnt,le.populated_FirstName_pcnt,le.populated_LastName_pcnt,le.populated_MiddleName_pcnt,le.populated_Suffix_pcnt,le.populated_BirthDate_pcnt,le.populated_SSN_pcnt,le.populated_Lexid_Input_pcnt,le.populated_Street1_pcnt,le.populated_Street2_pcnt,le.populated_Suite_pcnt,le.populated_City_pcnt,le.populated_State_pcnt,le.populated_Zip5_pcnt,le.populated_Phone_pcnt,le.populated_Lexid_Discovered_pcnt,le.populated_RemoteIPAddress_pcnt,le.populated_ConsumerIPAddress_pcnt,le.populated_Email_Address_pcnt);
  SELF.maxlength := CHOOSE(C,le.maxlength_Transaction_ID,le.maxlength_TransactionDate,le.maxlength_FirstName,le.maxlength_LastName,le.maxlength_MiddleName,le.maxlength_Suffix,le.maxlength_BirthDate,le.maxlength_SSN,le.maxlength_Lexid_Input,le.maxlength_Street1,le.maxlength_Street2,le.maxlength_Suite,le.maxlength_City,le.maxlength_State,le.maxlength_Zip5,le.maxlength_Phone,le.maxlength_Lexid_Discovered,le.maxlength_RemoteIPAddress,le.maxlength_ConsumerIPAddress,le.maxlength_Email_Address);
  SELF.avelength := CHOOSE(C,le.avelength_Transaction_ID,le.avelength_TransactionDate,le.avelength_FirstName,le.avelength_LastName,le.avelength_MiddleName,le.avelength_Suffix,le.avelength_BirthDate,le.avelength_SSN,le.avelength_Lexid_Input,le.avelength_Street1,le.avelength_Street2,le.avelength_Suite,le.avelength_City,le.avelength_State,le.avelength_Zip5,le.avelength_Phone,le.avelength_Lexid_Discovered,le.avelength_RemoteIPAddress,le.avelength_ConsumerIPAddress,le.avelength_Email_Address);
END;
EXPORT invSummary := NORMALIZE(summary0, 20, invert(LEFT,COUNTER));
// The character counts
// Move everything into 'inverted list' form so processing can be done 'in library'
SALT311.MAC_Character_Counts.X_Data_Layout Into(h le,unsigned C) := TRANSFORM
  SELF.Fld := TRIM(CHOOSE(C,TRIM((SALT311.StrType)le.Transaction_ID),TRIM((SALT311.StrType)le.TransactionDate),TRIM((SALT311.StrType)le.FirstName),TRIM((SALT311.StrType)le.LastName),TRIM((SALT311.StrType)le.MiddleName),TRIM((SALT311.StrType)le.Suffix),TRIM((SALT311.StrType)le.BirthDate),TRIM((SALT311.StrType)le.SSN),IF (le.Lexid_Input <> 0,TRIM((SALT311.StrType)le.Lexid_Input), ''),TRIM((SALT311.StrType)le.Street1),TRIM((SALT311.StrType)le.Street2),TRIM((SALT311.StrType)le.Suite),TRIM((SALT311.StrType)le.City),TRIM((SALT311.StrType)le.State),TRIM((SALT311.StrType)le.Zip5),TRIM((SALT311.StrType)le.Phone),IF (le.Lexid_Discovered <> 0,TRIM((SALT311.StrType)le.Lexid_Discovered), ''),TRIM((SALT311.StrType)le.RemoteIPAddress),TRIM((SALT311.StrType)le.ConsumerIPAddress),TRIM((SALT311.StrType)le.Email_Address)));
  SELF.FldNo := C;
END;
SHARED FldInv0 := NORMALIZE(h,20,Into(LEFT,COUNTER));
// Move everything into 'pairs' form so processing can be done 'in library'
SALT311.MAC_Correlate.Data_Layout IntoP(h le,UNSIGNED C) := TRANSFORM
  SELF.FldNo1 := 1 + (C / 20);
  SELF.FldNo2 := 1 + (C % 20);
  SELF.Fld1 := TRIM(CHOOSE(SELF.FldNo1,TRIM((SALT311.StrType)le.Transaction_ID),TRIM((SALT311.StrType)le.TransactionDate),TRIM((SALT311.StrType)le.FirstName),TRIM((SALT311.StrType)le.LastName),TRIM((SALT311.StrType)le.MiddleName),TRIM((SALT311.StrType)le.Suffix),TRIM((SALT311.StrType)le.BirthDate),TRIM((SALT311.StrType)le.SSN),IF (le.Lexid_Input <> 0,TRIM((SALT311.StrType)le.Lexid_Input), ''),TRIM((SALT311.StrType)le.Street1),TRIM((SALT311.StrType)le.Street2),TRIM((SALT311.StrType)le.Suite),TRIM((SALT311.StrType)le.City),TRIM((SALT311.StrType)le.State),TRIM((SALT311.StrType)le.Zip5),TRIM((SALT311.StrType)le.Phone),IF (le.Lexid_Discovered <> 0,TRIM((SALT311.StrType)le.Lexid_Discovered), ''),TRIM((SALT311.StrType)le.RemoteIPAddress),TRIM((SALT311.StrType)le.ConsumerIPAddress),TRIM((SALT311.StrType)le.Email_Address)));
  SELF.Fld2 := TRIM(CHOOSE(SELF.FldNo2,TRIM((SALT311.StrType)le.Transaction_ID),TRIM((SALT311.StrType)le.TransactionDate),TRIM((SALT311.StrType)le.FirstName),TRIM((SALT311.StrType)le.LastName),TRIM((SALT311.StrType)le.MiddleName),TRIM((SALT311.StrType)le.Suffix),TRIM((SALT311.StrType)le.BirthDate),TRIM((SALT311.StrType)le.SSN),IF (le.Lexid_Input <> 0,TRIM((SALT311.StrType)le.Lexid_Input), ''),TRIM((SALT311.StrType)le.Street1),TRIM((SALT311.StrType)le.Street2),TRIM((SALT311.StrType)le.Suite),TRIM((SALT311.StrType)le.City),TRIM((SALT311.StrType)le.State),TRIM((SALT311.StrType)le.Zip5),TRIM((SALT311.StrType)le.Phone),IF (le.Lexid_Discovered <> 0,TRIM((SALT311.StrType)le.Lexid_Discovered), ''),TRIM((SALT311.StrType)le.RemoteIPAddress),TRIM((SALT311.StrType)le.ConsumerIPAddress),TRIM((SALT311.StrType)le.Email_Address)));
  END;
SHARED Pairs0 := NORMALIZE(ENTH(h,Config.CorrelateSampleSize),20*20,IntoP(LEFT,COUNTER))(FldNo1<FldNo2);
SHARED FldIds := DATASET([{1,'Transaction_ID'}
      ,{2,'TransactionDate'}
      ,{3,'FirstName'}
      ,{4,'LastName'}
      ,{5,'MiddleName'}
      ,{6,'Suffix'}
      ,{7,'BirthDate'}
      ,{8,'SSN'}
      ,{9,'Lexid_Input'}
      ,{10,'Street1'}
      ,{11,'Street2'}
      ,{12,'Suite'}
      ,{13,'City'}
      ,{14,'State'}
      ,{15,'Zip5'}
      ,{16,'Phone'}
      ,{17,'Lexid_Discovered'}
      ,{18,'RemoteIPAddress'}
      ,{19,'ConsumerIPAddress'}
      ,{20,'Email_Address'}],SALT311.MAC_Character_Counts.Field_Identification);
EXPORT AllProfiles := SALT311.MAC_Character_Counts.FN_Profile(FldInv0,FldIds);
 
EXPORT SrcProfiles := SALT311.MAC_Character_Counts.Src_Profile(FldInv0,FldIds);
 
EXPORT Correlations := SALT311.MAC_Correlate.Fn_Profile(Pairs0,FldIds);
 
ErrorRecord := RECORD
  UNSIGNED1 FieldNum;
  UNSIGNED1 ErrorNum;
END;
ErrorRecord NoteErrors(h le,UNSIGNED1 c) := TRANSFORM
  SELF.ErrorNum := CHOOSE(c,
    RDP_Fields.InValid_Transaction_ID((SALT311.StrType)le.Transaction_ID),
    RDP_Fields.InValid_TransactionDate((SALT311.StrType)le.TransactionDate),
    RDP_Fields.InValid_FirstName((SALT311.StrType)le.FirstName),
    RDP_Fields.InValid_LastName((SALT311.StrType)le.LastName),
    RDP_Fields.InValid_MiddleName((SALT311.StrType)le.MiddleName),
    RDP_Fields.InValid_Suffix((SALT311.StrType)le.Suffix),
    RDP_Fields.InValid_BirthDate((SALT311.StrType)le.BirthDate),
    RDP_Fields.InValid_SSN((SALT311.StrType)le.SSN),
    RDP_Fields.InValid_Lexid_Input((SALT311.StrType)le.Lexid_Input),
    RDP_Fields.InValid_Street1((SALT311.StrType)le.Street1),
    RDP_Fields.InValid_Street2((SALT311.StrType)le.Street2),
    RDP_Fields.InValid_Suite((SALT311.StrType)le.Suite),
    RDP_Fields.InValid_City((SALT311.StrType)le.City),
    RDP_Fields.InValid_State((SALT311.StrType)le.State),
    RDP_Fields.InValid_Zip5((SALT311.StrType)le.Zip5),
    RDP_Fields.InValid_Phone((SALT311.StrType)le.Phone),
    RDP_Fields.InValid_Lexid_Discovered((SALT311.StrType)le.Lexid_Discovered),
    RDP_Fields.InValid_RemoteIPAddress((SALT311.StrType)le.RemoteIPAddress),
    RDP_Fields.InValid_ConsumerIPAddress((SALT311.StrType)le.ConsumerIPAddress),
    RDP_Fields.InValid_Email_Address((SALT311.StrType)le.Email_Address),
    0);
  SELF.FieldNum := IF(SELF.ErrorNum=0,SKIP,c); // Bail early to avoid creating record
END;
Errors := NORMALIZE(h,20,NoteErrors(LEFT,COUNTER));
ErrorRecordsTotals := RECORD
  Errors.FieldNum;
  Errors.ErrorNum;
  UNSIGNED Cnt := COUNT(GROUP);
END;
TotalErrors := TABLE(Errors,ErrorRecordsTotals,FieldNum,ErrorNum,FEW);
PrettyErrorTotals := RECORD
  FieldNme := RDP_Fields.FieldName(TotalErrors.FieldNum);
  FieldType := CHOOSE(TotalErrors.FieldNum,'invalid_numeric','invalid_date','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_date','invalid_ssn','invalid_numeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_alphanumeric','invalid_state','invalid_zip','invalid_phone','invalid_numeric','invalid_ip','invalid_ip','invalid_email');
  ErrorMessage := CHOOSE(TotalErrors.FieldNum,RDP_Fields.InValidMessage_Transaction_ID(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_TransactionDate(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_FirstName(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_LastName(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_MiddleName(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Suffix(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_BirthDate(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_SSN(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Lexid_Input(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Street1(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Street2(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Suite(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_City(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_State(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Zip5(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Phone(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Lexid_Discovered(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_RemoteIPAddress(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_ConsumerIPAddress(TotalErrors.ErrorNum),RDP_Fields.InValidMessage_Email_Address(TotalErrors.ErrorNum));
  TotalErrors.Cnt;
END;
ValErr := TABLE(TotalErrors,PrettyErrorTotals);
EXPORT ValidityErrors := ValErr;
EXPORT StandardStats(BOOLEAN doSummaryGlobal = TRUE, BOOLEAN doAllProfiles = TRUE) := FUNCTION
  myTimeStamp := (UNSIGNED6)SALT311.Fn_Now('YYYYMMDDHHMMSS') : INDEPENDENT;
  fieldPopulationOverall := Summary('');
 
  SALT311.mod_StandardStatsTransforms.mac_hygieneSummaryTransform(Scrubs_FraudGov, RDP_Fields, 'RECORDOF(fieldPopulationOverall)', FALSE);
 
  fieldPopulationOverall_Standard := IF(doSummaryGlobal, NORMALIZE(fieldPopulationOverall, COUNT(FldIds) * 6, xSummary(LEFT, COUNTER, myTimeStamp, 'all', 'all')));
  fieldPopulationOverall_TotalRecs_Standard := IF(doSummaryGlobal, SALT311.mod_StandardStatsTransforms.mac_hygieneTotalRecs(fieldPopulationOverall, myTimeStamp, 'all', FALSE, 'all'));
  allProfiles_Standard := IF(doAllProfiles, SALT311.mod_StandardStatsTransforms.hygieneAllProfiles(AllProfiles, myTimeStamp, 10, 'all'));
 
  RETURN fieldPopulationOverall_Standard & fieldPopulationOverall_TotalRecs_Standard & allProfiles_Standard;
END;
END;
